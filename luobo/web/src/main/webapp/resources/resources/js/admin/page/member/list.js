/*-----------------------------------------------------------------------------
* @Description: 会员列表
* @Version: 	V1.0.0
* @author: 		cuiy(361151713@qq.com)
* @date			2014.01.21
* ==NOTES:=============================================
* v1.0.0(2014.01.21):
* 	初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/member/list', function (S, Core, Upload) {
    PW.namespace('page.Member.List');
    PW.page.Member.List = function(param){
    	new Upload(param);
        new Core(param);
    }
},{
    requires:[
        'list/core',
        'member/upload'
    ]
});

KISSY.add('list/core', function (S) {
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query,
		on = S.Event.on, delegate = S.Event.delegate,
		$ = S.all, 
		Dialog = PW.widget.Dialog,
        Juicer = PW.mod.Juicer,
        Pagination = PW.widget.Table.client,
		Defender = PW.mod.Defender.client,
        MemberIO = PW.io.Member,
        SearchValid = PW.module.SearchValid,
		el = {
			// 搜索表单
			searchForm: '.J_searchForm',
			// 操作表单
			operForm: '.J_operForm',
			// 导出按钮
			exportTrigger: '.J_excel',
			// 修改等级触发器
			editGradeTrigger: '.J_editGrade',
			// 渲染
			dataTemp: '#J_template',
			// 会员等级表单
			gradeForm: '.J_gradeForm',
			// 会员等级模板
			gradeTemp: '#gradeForm',
			// 会员等级
			gradeEl: '.J_grade',
			// 会员id
			userIdEl: '.J_userId',
			// 会员等级
			grade: '.type',
			// 会员状态
			status: '.status', 
			// 状态改变触发器
			statusTrigger: '.J_enlight',
			// 额度改变触发器
			limitTrigger: '.J_editLimit',
			// 弹框中的会员类型
			typeEl: '.J_type',
			// 选择会员类型表单
			selecteGrade: '.J_selectGrade',
			// 搜索触发器
			searchTrigger: '.J_search',
			//备注触发器
			tipTrigger: '.J_tip',
			//备注存储器
			tipHolder: '.J_tipHolder',
			//提示信息
			tipContent: '.J_tipContent',
			//备注form
			tipForm: '.J_tipForm'
		},

		DATA_MEMBER_ID = 'data-member-id',
		DATA_TYPE_ID = 'data-type-id',
		ERROR_TIP = ['修改状态成功！', '修改会员类型成功！'],
		STATUS = ['停用', '正常', '待审核', '未审核'],
		OPER = ['审核通过', '审核未通过', '启用', '停用'],
		GRADE_FORM = '<form class="J_gradeForm">'+
                     '		<div class="control-group">'+
                     '             <input type="hidden" class="J_userId" name="userId" value="">'+
                     '             <label class="control-label">'+
                     '                选择等级'+
                     '              </label>'+
                     '              <div class="controls J_selectGrade">'+
                     '           </div>'+
                     '        </div>'+
                     '</form>',
        NONE_CONTENT_CLASS = 'font-gray',
		CONTENT = '<form class="J_tipForm"><textarea  class="w500 form-control J_tipContent" style="height:100px;" data-valid-rule="length(-1,201)" name=""></textarea></form>',
		SUCCESS_TIP = ['保存备注成功！'];

	function Core(param){
    	this.opts = param.pagi;
    	this.defenderSearch;
    	this.defenderTipObj;
		this.pagination;
		this._init();
	}

	S.augment(Core, {
		_init: function(){
			this._validForm();
			this._initPagination();
			this._buildEvtHandle();
			
		},
		_buildEvtHandle: function(){
			var
				that = this;
			// 导出excel操作
			on(el.exportTrigger, 'click', function(){
				that._export();
			});
			// 搜索
			on(el.searchForm, 'submit', function(){
				that._search();
				return false;
			});
			// 修改等级
			delegate(el.dataTemp, 'click', el.editGradeTrigger, function(e){
				that._editGrade(e.target);
			});
			// 状态改变操作
			delegate(el.dataTemp, 'click', el.statusTrigger, function(e){
				that._editStatus(e.target);
			});
			//备注操作
			delegate(el.dataTemp, 'click', el.tipTrigger, function(e){
				that._openTipDlg(e.target);
			}, that);
		},
		/**
		 * 验证搜索
		 * @return {[type]} [description]
		 */
		_validForm:function(){
			var
				that = this,
        		selectValid = DOM.data('.J_select','selectValid');
        	that.defenderSearch = Defender(el.searchForm ,{});
        	selectValid.on('refresh',function(){
        		that.defenderSearch.refresh();
        	})
		},
		/**
		 * 初始化分页
		 * @return {[type]} [description]
		 */
		_initPagination: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);
			that.pagination = Pagination({
                pagi:S.mix(that.opts, {extraParam: data}),
                formSet: {
                    hasForm: true,
                    formRender: '.J_searchForm',
                    formDefender:that.defenderSearch
                }
            });
		},
		/**
		 * 发送搜索条件的参数
		 * @return {[type]} [description]
		 */
		_search: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm),
				selectEl = get(el.gradeEl),
				options = query('option', selectEl);
			that.defenderSearch.validAll(function(rs){
                if(rs){
                    S.mix(data, {
						typeId: DOM.attr(options[data.typeId], DATA_TYPE_ID)
					});
					S.mix(that.opts, {extraParam: data});
					that.pagination.reloadPagi(that.opts); 
                }
            })
			return false;
		},
		/**
		 * 导出excel
		 * @return {[type]} [description]
		 */
		_export: function(){
			var 
                that = this,
                data = S.IO.serialize(el.searchForm),
                dataObj = DOM.serialize(el.searchForm),
                selectEl = get(el.gradeEl),
				options = query('option', selectEl),
				href, frontHref, newHref;

			S.mix(dataObj, {
				typeId: DOM.attr(options[dataObj.typeId], DATA_TYPE_ID)
			});

            href = DOM.attr(el.exportTrigger, 'href'),
            frontHref = href.split("?"),
            newHref = frontHref[0] + '?'+ 'key=' + dataObj.key + '&value=' + dataObj.value + '&typeId=' + dataObj.typeId + '&status=' + dataObj.status;
            DOM.attr(el.exportTrigger, {href:newHref});
		},
		/**
		 * 修改会员类型
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_editGrade: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
				// 获取会员的id
				id = DOM.attr(tr, DATA_MEMBER_ID),
				gradeEl = get(el.grade, tr),
				grade = DOM.text(gradeEl);
			
			Dialog.alert(GRADE_FORM, function(){}, {
				footer: {
					btns:[{
                        text: '保存',
                        clickHandler: function(e,me){
                            that._operGrade(tr);
                            me.close();
                        }
                    },{
                        text: '取消',
                        clickHandler: function(e,me){
                            me.close();
                        }
                    }]
                },
                afterOpenHandler: function(){
                	that._renderSelect(grade, id);
                }
            });
		},
		/**
		 * 渲染会员类型列表
		 * @param  {[type]} val [description]
		 * @param  {[type]} id  [description]
		 * @return {[type]}     [description]
		 */
		_renderSelect: function(grade, id){
			var
        		selectEl = DOM.clone(el.gradeEl, true),
        		selecteGradeEl = DOM.get(el.selecteGrade),
        		options = query('option', selectEl);
			// 赋值给userId域
			DOM.val(el.userIdEl, id);
    		DOM.append(selectEl, selecteGradeEl);
    		// 将当前会员类型定位
    		S.each(options, function(option){
    			if(DOM.text(option) == grade){
    				DOM.attr(option, 'selected', 'selected');
    			}
    		});
    		// 将复制过来的“全部”节点删除
    		// DOM.text(options[0], '请选择');
    		DOM.remove(options[0]);
		},
		/**
		 * 操作会员类型信息
		 * @param  {[type]} tr [description]
		 * @param  {[type]} id [description]
		 * @return {[type]}    [description]
		 */
		_operGrade: function(tr){
			var
				that = this,
				data,
				obj = {},
				grade = {};
			// 将会员类型表单序列化
			data = DOM.serialize(el.gradeForm);
			// 获取原先和修改后的会员类型
			grade = that._getOldAndNewGrade(tr, data.typeId);
			// 渲染提示信息
			obj = that._renderTip(grade.oldGrade, grade.newGrade);
			
			S.mix(data, {
				typeId: grade.typeId
			});
			// 发送修改会员类型请求
			that._sendGrade(tr, data, obj.tip, grade.newGrade);
		},
		/**
		 * 发送修改会员类型请求
		 * @param  {[type]} obj   [description]
		 * @param  {[type]} grade [description]
		 * @return {[type]}       [description]
		 */
		_sendGrade: function(tr, data, tip, newGrade){
			var
				that = this;
			// 询问是否修改会员类型
			Dialog.alert(tip, function(){}, {
				footer: {
					btns:[{
                        text: '确定',
                        clickHandler: function(e,me){
                            MemberIO.updateGrade(data, function(code, errMsg){
								if(code){
									that._renderGrade(tr, newGrade);
									Dialog.alert(ERROR_TIP[1]);
								}else{
									Dialog.alert(errMsg);
								}
							});
                            me.close();
                        }
                    },{
                        text: '取消',
                        clickHandler: function(e,me){
                            me.close();
                        }
                    }]
                }
            });
		},
		/**
		 * 获取原先和修改后的会员类型
		 * @param  {[type]} tr [description]
		 * @return {[type]}    [description]
		 */
		_getOldAndNewGrade: function(tr, val){
			var
				that = this,
				selectEl = get(el.gradeEl, el.gradeForm),
				selectVal = DOM.val(selectEl),
				options = query('option', selectEl),
				newGrade,
				typeId;

			typeId = DOM.attr(options[val - 1], DATA_TYPE_ID);
			newGrade = DOM.text(options[val - 1]);
			oldGradeEl = get(el.grade, tr);
			oldGrade = DOM.text(oldGradeEl);

			return {
				oldGrade: oldGrade,
				newGrade: newGrade,
				typeId: typeId
			}
		},
		/**
		 * 拼凑会员类型修改提示
		 * @return {[type]} [description]
		 */
		_renderTip: function(oldGrade, newGrade){
			var
				confirmTip;
			if(oldGrade == ''){
				confirmTip = '确定将该会员变为 <strong>' + newGrade + '</strong> 吗？';
			}else{
				confirmTip = '确定将该会员由 <strong>' + oldGrade + '</strong> 变为 <strong>' + newGrade + '</strong> 吗？';
			}
			return {
				tip: confirmTip
			};
		},
		/**
		 * 渲染会员类型
		 * @param  {[type]} tr  [description]
		 * @param  {[type]} val [description]
		 * @return {[type]}     [description]
		 */
		_renderGrade: function(tr, newGrade){
			var
				that = this,
				gradeEl = get(el.grade, tr);
			// 将修改之后的会员类型渲染回列表中
			DOM.html(gradeEl, newGrade);
		},
		/**
		 * 修改会员状态
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_editStatus: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_MEMBER_ID),
				statusHtml = S.trim(DOM.html(e)),
				target = e,
				ALERT = '确定 ' + statusHtml + ' 吗?';

			Dialog.alert(ALERT, function(){}, {
				footer: {
					btns:[{
                        text: '确定',
                        clickHandler: function(e,me){
                            that._sendStatus(tr, id, target);
                            me.close();
                        }
                    },{
                        text: '取消',
                        clickHandler: function(e,me){
                            me.close();
                        }
                    }]
                }
            });
		},
		/**
		 * 发送会员状态
		 * @param  {[type]} tr     [description]
		 * @param  {[type]} id     [description]
		 * @param  {[type]} status [description]
		 * @param  {[type]} target [description]
		 * @return {[type]}        [description]
		 */
		_sendStatus: function(tr, id, target){
			var
				that = this,
				statusEl = get(el.status, tr),
				oper = S.trim(DOM.html(target)),
				status = that._getStatus(oper);
			MemberIO.updateStatus({
					userId: id,
					status: status
				}, function(code, errMsg){
				if(code){
					that._renderStatus(tr, status, target);
					Dialog.alert(ERROR_TIP[0]);
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 打开修改备注弹出框
		 * @return {[type]} [description]
		 */
		_openTipDlg: function(target){
			var
				that = this,
				tipHolderEl = DOM.prev(target),
				tip = DOM.val(tipHolderEl);
			Dialog.alert(CONTENT,function(){},{footer: 
				{
					btns:[{
                    text: '保存',
                    clickHandler: function(e,me){
                        that.defenderTipObj.validAll(function(rs){
                            if(rs){
                            	that._saveTip(target, tipHolderEl);
                                me.close();
                            }
                        });
                    }
                },{
                    text: '取消',
                    clickHandler: function(e,me){
                        me.close();
                    }
                }]
                },
                afterOpenHandler: function(e,me){
                    that.defenderTipObj = Defender(el.tipForm, {showTip:false});
                    DOM.val(el.tipContent, tip);
                },
                title: "备注（200字以内）：",
                width: 600
            });
		},
		/**
		 * 保存备注
		 * @param  {[type]} target      [description]
		 * @param  {[type]} tipHolderEl [description]
		 * @return {[type]}             [description]
		 */
		_saveTip: function(target, tipHolderEl){
			var
				that = this,
				opts = that.opts,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_MEMBER_ID),
				newContent = DOM.val(el.tipContent);
			MemberIO.memberTip({id:id, adminComment:newContent},function(code, errMsg){
                if(code){
                    DOM.val(tipHolderEl, newContent);
                    DOM.removeClass(target, NONE_CONTENT_CLASS);
                    Dialog.alert(SUCCESS_TIP[0]);
                }else{
                    Dialog.alert(errMsg);
                }
            });
		},
		/**
		 * 获取操作按钮状态
		 * @param  {[type]} oper [description]
		 * @return {[type]}      [description]
		 */
		_getStatus: function(oper){
			if(oper == OPER[0] || oper == OPER[2]){
				return 1;
			}else if(oper == OPER[1]){
				return 3;
			}else if(oper == OPER[3]){
				return 0;
			}
		},
		/**
		 * 渲染会员状态
		 * @param  {[type]} tr     [description]
		 * @param  {[type]} status [description]
		 * @param  {[type]} target [description]
		 * @return {[type]}        [description]
		 */
		_renderStatus: function(tr, status, target){
			var
				that = this,
				statusEl = get(el.status, tr),
				nextStatusEl = DOM.next(target),
				statusHtml = DOM.text(nextStatusEl);
			if(status == 3){
				// 会员状态
				DOM.html(statusEl, STATUS[3]);
			}else if(status == 1){
				DOM.html(statusEl, STATUS[1]);
				// 操作状态
				DOM.html(target, OPER[3]);
				S.log(statusHtml);
				if(statusHtml == OPER[1]){
					DOM.remove(nextStatusEl);
				}
			}else if(status == 0){
				DOM.html(statusEl, STATUS[0]);
				DOM.html(target, OPER[2]);
			}
		}
	});
    return Core;
},{
    requires:[
    	'io/member',
        'mod/pagination',
        'mod/defender',
        'widget/dialog',
        'mod/juicer',
        'mod/ext',
        'module/selectValid',
        'widget/table'
    ]
});
KISSY.add('member/upload', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query,
		on = S.Event.on, delegate = S.Event.delegate,
		Dialog = PW.widget.Dialog,
		el = {
			uploadTrigger: '#J_upload'
		},
		TIP = {
			upload_sucess: '上传成功！',
			upload_fail: '上传失败'
		};
	var 
		Upload = function(param){
			this.opts = param;
			this._init();
		}
	S.augment(Upload,{
		_init: function(){
			this._upLoadImg();
		},
		_upLoadImg: function(){
            var
                that = this,
                url = that.opts.upload.url,
                settings;
             settings = {
                 upload:{
                        url: url,    
                        type: 'post'
                      },
                file:{
                		postName: 'myfiles',
                        typeLimit: '*.xls; *.xlsx;',
                        uploadNumLimit: 6, //上传数量限制
                        queueNumLimit: 6, //队列数量限制
                        typeDesp: 'All Files'//文件选择框中给用户的描述
                        },
                button: {
                    width: 128,
                    height: 30,
                    text: '<span class="theFont">上传文件</span>',
                    cursor: 'hand',
                    textTopPadding: 3,
                    textleftPadding: 28,
                    style: '.theFont {color: #FFFFFF;}',
                    renderTo: el.uploadTrigger,
                    imgUrl: _pw_env.puiWebsite + 'assets/upload/img/upload-logo.png' 
                },
                events:{
                    uploadError: function(rs){
                    	Dialog.alert(TIP.upload_fail);
                    },
                    uploadSuccess: function(uploadData,rs){
                    	if(rs.code == 0){
                    		Dialog.alert(TIP.upload_sucess);
                    	}else{
                    		var errMsg = rs.errMsg ? rs.errMsg : TIP.upload_fail;
                     		Dialog.alert(errMsg);
                    	}
                    	
                    },
                    uploadComplete: null
                }
            }
			that.upload = PW.mod.Upload.client(settings);
        }
	});
	return Upload;
},{
	requires: [
		'mod/upload',
		'io/member',
        'widget/dialog'
	]
});