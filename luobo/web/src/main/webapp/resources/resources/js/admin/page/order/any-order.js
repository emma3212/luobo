/*-----------------------------------------------------------------------------
* @Description: 随意还订单管理列表 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.01.24
* ==NOTES:=============================================
* v1.0.0(2015.01.24):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/order/any-order', function (S, Core, Audit) {
    PW.namespace('page.order.anyRepay');
    PW.page.order.anyRepay = {
    	AuditList: function(param){
        	new Core(param);
        	new Audit();
    	},
    	cancelList: function(param){
    		new Core(param);
    	}
    }
},{
    requires:[
        'list/core',
        'list/audit',
        'module/forbidBackSpace'
    ]
});
KISSY.add('list/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, Juicer = PW.mod.Juicer,
		TablePagi = PW.widget.Table.client,
		Defender = PW.mod.Defender.client,
		Dialog = PW.widget.Dialog,
		AnyRepayIO = PW.io.AnyRepay,
		el = {
			//form
			searchForm: '.J_searchForm',
			//搜索关键字条件
			searchKey: '.J_searchKey',
			//table的tbody
			template:'#J_template',
			//订单详情模板
			orderTpl: '#orderTpl',
			//导出excel触发器
			excelTrigger: '.J_excel',
			//备注触发器
			tipTrigger: '.J_tip',
			//浏览触发器
			skimTrigger: '.J_skim',
			//备注存储器
			tipHolder: '.J_tipHolder',
			//提示信息
			tipContent: '.J_tipContent',
			//备注form
			tipForm: '.J_tipForm'
		},
		//启用停用显示方式
		//tr属性
		DATA_ID = 'data-order-id',
		//搜索条件name值
		DATA_NAME = 'data-name',
		NONE_CONTENT_CLASS = 'font-gray',
		CONTENT = '<form class="J_tipForm"><textarea class="w500 form-control J_tipContent" style="height:100px;" data-valid-rule="length(-1,201)" name=""></textarea></form>',
		SUCCESS_TIP = ['保存备注成功！'];
	var
		Core = function(param){
			this.opts = param;
			this.searchDefender;
			this.defenderTipObj;
			this._pagination;
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._validForm();
			this._pagination();
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this,
				flag;
			delegate(el.template, 'click', el.tipTrigger, that._openTipDlg, that);
			delegate(el.template, 'click', el.skimTrigger, that._skimHandler, that);
			on(el.excelTrigger, 'click', that._exportExcel, that);
			on(el.searchForm, 'submit', that._reloadPagi, that);
		},
		//验证搜索表单
		_validForm:function(){
			var 
				that = this,
        		selectValid = DOM.data('.J_select','selectValid');
        	that.searchDefender = Defender(el.searchForm ,{});
        	selectValid.on('refresh',function(){
        		that.searchDefender.refresh();
        	})
		},
		//分页
		_pagination: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);
			that.opts.pagi = S.merge(that.opts.pagi,{
				extraParam: data
			});
			that._pagination = TablePagi({
				pagi: that.opts.pagi,
				formSet: {
					hasForm: true,
                	formRender: '.J_searchForm',
                    formDefender: that.searchDefender
				}
			});;
		},
		/**
		 * 重新加载分页
		 * @return {[type]} [description]
		 */
		_reloadPagi: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);
			that.searchDefender.validAll(function(rs){
				if(rs){
					S.mix(that.opts.pagi,{
						extraParam: data
					});
					
					that._pagination.reloadPagi(that.opts.pagi);
				}
			})
			return false;
		},
		/**
		 * 导出excel操作
		 * @return {[type]} [description]
		 */
		_exportExcel: function(){
			var
				that = this,
				data = S.IO.serialize(el.searchForm),
				excelHref = DOM.attr(el.excelTrigger, 'href').split('?')[0]  + '?' + data;
			DOM.attr(el.excelTrigger, 'href', excelHref);
		},
		/**
		 * 浏览操作
		 * @return {[type]} [description]
		 */
		_skimHandler: function(e){
			var
				that = this,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				SKIM_CONTENT = that._getSkimHtml(id);
			//如果请求订单信息成功则显示	
			if(SKIM_CONTENT){
				Dialog.alert(SKIM_CONTENT, null, {title: '查看订单详情', width: 400, top: 50});
			} 
		},
		/**
		 * 获取浏览信息模板
		 * @return {[type]} [description]
		 */
		_getSkimHtml: function(id){
			var
				that = this,
				tpl = '';
			AnyRepayIO.getOrderInfo({id: id}, function(code, data, errMsg){
				if(code){
					tpl = Juicer(el.orderTpl, data);
				}else{
					Dialog.alert(errMsg);
				}
			});
			return tpl;
		},
		/**
		 * 打开修改备注弹出框
		 * @return {[type]} [description]
		 */
		_openTipDlg: function(e){
			var
				that = this,
				target = e.target,
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
				type = that.opts.type,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				newContent = DOM.val(el.tipContent);
			if(type == 'cancel'){
				AnyRepayIO.cancelTip({id:id, adminComment:newContent},function(code, errMsg){
                    if(code){
                        DOM.val(tipHolderEl, newContent);
                        Dialog.alert(SUCCESS_TIP[0]);
                        DOM.removeClass(target, NONE_CONTENT_CLASS);
                    }else{
                        Dialog.alert(errMsg);
                    }
                });
			}else{
				AnyRepayIO.auditTip({id:id, adminComment:newContent},function(code, errMsg){
                    if(code){
                        DOM.val(tipHolderEl, newContent);
                        DOM.removeClass(target, NONE_CONTENT_CLASS);
                        Dialog.alert(SUCCESS_TIP[0]);
                    }else{
                        Dialog.alert(errMsg);
                    }
                });
			}
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/pagination',
				'io/anyrepay',
				'widget/dialog',
				'mod/juicer',
				'mod/defender',
				'widget/dropdown',
				'module/selectValid',
				'widget/table'
			]
});
/**
 * 未审核页操作
 * @param  {[type]} S){}               [description]
 * @param  {[type]} options.requires:[	] [description]
 * @return {[type]}                      [description]
 */
KISSY.add('list/audit', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, 
		Juicer = PW.mod.Juicer,
		Defender = PW.mod.Defender.client,
		Dialog = PW.widget.Dialog,
		AnyRepayIO = PW.io.AnyRepay,
		el = {
			//table的tbody
			template:'#J_template',
			//状态模板
			statusTpl: '#statusTpl',
			//免息模板
			freeDayTpl: '#freeDayTpl',
			//状态触发器
			statusTrigger: '.J_status',
			//状态选择
			statusSelect: '.J_statusSelect',
			//敏感密码
			sensitiveEl: '.J_sensitive',
			//敏感密码输入框
			sensitiveVal: '.J_sensitiveEl',
			//状态表单
			statusForm: '.J_statusForm',
			//金额
			price: '.J_price',
			//应还款
			planReturn: '.J_planReturn',
			//弹出层总金额输入域
			dlgAmount: '.J_dlgAmount',
			//弹出层实际还款金额输入
			dlgRealRepay: '.J_dlgRealRapay',
			//总金额模块
			amountHolder: '.J_amountHolder',
			//实际还款模块
			realRepayHolder: '.J_realRepayHolder',
			//免息表单
			setFreeDayFrom: '.J_setFreeDayFrom',
			//免息触发器
			freeDayTrigger: '.J_freeDay',
			//免息天数
			freeDayHolder: '.J_freeDayHolder'
		},
		//状态map定义
		MAP = {
			1: [1,2,4],
			2: [2,3,4],
			3: [3,4],
			4: [4]
		},
		//状态属性
		DATA_STATUS = 'data-stauts',
		DATA_ID = 'data-order-id',
		SUCCESS_TIP = ['设置免息天数操作成功！'];
	function Audit(){
		this.preStatus = 0;
		//还款表示, description: 新建订单变为还款中状态时为1,其余情况为0
		this.stagingFlag = 0;
		//修改状态表单
		this.statusForm;
		this._init();
	}
	S.augment(Audit, {
		_init: function(){
			this._addEvt();
		},
		_addEvt: function(){
			var
				that = this;
			delegate(el.template, 'click', el.statusTrigger, that._openStatusDlg, that);
			delegate(document, 'change', el.statusSelect, that._selectHandler, that);
			delegate(el.template, 'click', el.freeDayTrigger, that._setFreeDayHandler, that);
		},
		/**
		 * 打开修改状态弹出框
		 * @return {[type]} [description]
		 */
		_openStatusDlg: function(e){
			var
				that = this,
				target = e.target,
				renderData = that._getStatusData(target),
				CONTENT = Juicer(el.statusTpl, renderData),
				status = DOM.attr(target, DATA_STATUS);
			that.preStatus = status;
			Dialog.alert(CONTENT,function(){},{
				footer:{
					btns:[{
	                    text: '保存',
	                    clickHandler: function(e,me){
	                    	that.statusForm.validAll(function(rs){
	                    		if(rs){
                    				that._saveStatus(target);
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
                	that._resetRender();
                	DOM.val(el.dlgStaging, renderData.payPeriods);
                	that.statusForm = Defender(el.statusForm, {showTip: false});
                },
                title: "选择状态",
                width: 600
            });
		},
		/**
		 * 保存状态
		 * @return {[type]} [description]
		 */
		_saveStatus: function(target){
			var
				that = this,
				data = DOM.serialize(el.statusForm),
				tr = DOM.parent(target, 'tr'),
				priceEl = get(el.price, tr),
				planReturnEl = get(el.planReturn, tr),
				statusHtml = that._getSelectHtml();
			AnyRepayIO.saveStatus(data, function(code, returnData, errMsg){
				if(code){
					DOM.text(target, statusHtml);
					DOM.attr(target, DATA_STATUS, data.status);
					DOM.html(planReturnEl, returnData.shouldRepayMoney);
					//重置列表总金额
					if(data.status == 2) DOM.html(priceEl, data.amount);
					if(data.status == 4) DOM.replaceClass(target, 'J_status', 'J_cancel');
				}else{
					Dialog.alert(errMsg);
				}
			});	
		},
		/**
		 * 设置选择状态标识，显示修改内容
		 * @return {[type]} [description]
		 */
		_selectHandler: function(e){
			var
				preStatus = this.preStatus,
				status = DOM.val(e.target);
			//原状态不为为‘新建订单’
			if(preStatus != 1 && status == 4){
				DOM.removeAttr(el.sensitiveVal, 'disabled');
			//原状态为‘新建订单’，并更改为'还款中订单'
			}else if(preStatus == 1 && status == 2){
				this._showAmount();
			//原状态为‘还款中订单’，并更改为‘还款完成’
			}else if(preStatus == 2 && status == 3){
				this.staging = 2;
				this._showRealRepay();
			}else{
				this._hideAmount();
				this._hideRealRepay();
				DOM.attr(el.sensitiveVal, 'disabled', 'disabled');
			}
			this.statusForm.refresh();
		},
		/**
		 * 弹出框设置免息天数
		 * @param {[type]} e [description]
		 */
		_setFreeDayHandler: function(e){
			var
				that = this,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				freeDay = $(el.freeDayHolder, tr).html(),
				id = DOM.attr(tr, DATA_ID),
				FREE_CONTENT = Juicer(el.freeDayTpl, {freeDay: freeDay});
			Dialog.alert(FREE_CONTENT,function(){},{
				footer:{
					btns:[{
	                    text: '保存',
	                    clickHandler: function(e,me){
	                    	that.freeDayForm.validAll(function(rs){
	                    		if(rs){
	                    				data = S.merge(DOM.serialize(el.setFreeDayFrom), {id: id});
                    				that._saveSetFreeDay(data, function(){
                    					$(el.freeDayHolder ,tr).html(data.freeDay);
                    					Dialog.alert(SUCCESS_TIP[0]);
                    				});
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
                	that.freeDayForm = Defender(el.setFreeDayFrom);
                },
                title: "修改免息天数",
                width: 600
            });

		},
		/**
		 * 保存免息天数
		 * @param  {[type]}   data     [description]
		 * @param  {Function} callback [description]
		 * @return {[type]}            [description]
		 */
		_saveSetFreeDay:function(data,callback){
			var
				that = this;
			AnyRepayIO.saveFreeDay(data, function(code, errMsg){
				if(code){
					callback();
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 获取选择内容
		 * @return {[type]} [description]
		 */
		_getSelectHtml: function(){
			var
				html = $(el.statusSelect).one('option:selected').text();
			return html;
		},
		/**
		 * 重置选择框内容
		 * @param  {[type]} status [description]
		 * @return {[type]}        [description]
		 */
		_resetRender: function(){
			var
				status = this.preStatus,
				selectStatus = MAP[status],
				optionsEl = $(el.statusSelect + ' option');
			S.each(optionsEl, function(option){
				optVal = parseInt(DOM.val(option));
				if(!S.inArray(optVal, selectStatus)){
					DOM.remove(option);
				}
			});
		},
		/**
		 * 获取状态信息
		 * @param  {[type]} target [description]
		 * @return {[type]}        [description]
		 */
		_getStatusData: function(target){
			var
				that = this,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				amount = $(el.price, tr).html(),
				payPeriods = $(el.staging, tr).html();
			return {id: id, amount: amount};
		},
		/**
		 * 显示总金额
		 * @return {[type]} [description]
		 */
		_showAmount: function(){
			DOM.show(el.amountHolder);
			$(el.dlgAmount).removeAttr('disabled');
		},
		/**
		 * 隐藏总金额
		 * @return {[type]} [description]
		 */
		_hideAmount: function(){
			DOM.hide(el.amountHolder);
			$(el.dlgAmount).attr('disabled', 'disabled');
		},
		/**
		 * 显示实际还款
		 * @return {[type]} [description]
		 */
		_showRealRepay: function(){
			DOM.show(el.realRepayHolder);
			$(el.dlgRealRepay).removeAttr('disabled');
		},
		/**
		 * 隐藏实际还款
		 * @return {[type]} [description]
		 */
		_hideRealRepay: function(){
			DOM.hide(el.realRepayHolder);
			$(el.dlgRealRepay).attr('disabled', 'disabled');
		}
	});
	return Audit;
},{
	requires:[
		'core',
		'mod/juicer',
		'mod/defender',
		'widget/dialog',
		'io/anyrepay'
	]
});