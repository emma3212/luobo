/*-----------------------------------------------------------------------------
* @Description:     管理员列表
* @Version:         1.0.0
* @author:          kt
* @date             2015.01.22
* ==NOTES:=============================================
* v1.0.0(2015.01.22):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/administrator/list', function(S, Core){
	PW.namespace('page.administrator.List');
	PW.page.administrator.List = function(param){
        return new Core(param);
    }
},{
	requires:[
		'list/core'
	]
});

KISSY.add('list/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, $ = S.all, delegate = S.Event.delegate,
        Defender = PW.mod.Defender.client,
        Dialog = PW.widget.Dialog,
        Juicer = PW.mod.Juicer,
        Pagination = PW.mod.Pagination.client,
        AdministratorIO = PW.io.Administrator,
        el = {
        	template:'#J_template',
            //新建按钮
            newTrigger:'.J_new',
            //新建弹出框表单
            newForm:'.J_newForm',
            //新建弹出框模版
            newTpl:'#newTpl',
            //弹出框中手机号码域
            adminMobile:'.J_adminMobile',
            //修改管理员按钮
            updateTrigger:'.J_update',
            //修改管理员弹出框表单
            updateForm:'.J_updateForm',
            //修改管理员弹出框模版
            updateTpl:'#updateTpl',
            //修改密码按钮
            updatePwdTrigger:'.J_updatePwd',
            //修改密码弹出框表单
            updatePwdForm:'.J_updatePwdForm',
			//修改密码弹出框模版
            updatePwdTpl:'#updatePwdTpl',
            //启用停用触发器
            enlightTrigger: '.J_enlight',
            //已停用 已启用 td
            status:'.J_status',
            name:'.J_name',
            mobile:'.J_mobile'
        },
        DATA_ID = 'data-id',
		SUCCESS_TIP = ['新建操作成功！', '修改操作成功！', '修改密码操作成功！','状态修改成功！'],
		ABLED_STATUS = 0,
		DISABLED_STATUS = 1,
		//启用停用显示方式
        ENLIGHT_TIP = ['停用', '启用'],
        CONFIRM_TIP = '确定要执行该操作吗？';
	function Core(param){
		this.opts = param;
		this.defenderNewObj;
		this.defenderUpdateObj;
		this.defenderUpdatePwdObj;
		this._pagination;
		this._init();
	}
	S.augment(Core, {
		_init: function(){
			this._pagination();
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			on(el.newTrigger, 'click', that._new, that);
			delegate(el.template, 'click', el.updateTrigger, that._update, that);
			delegate(el.template, 'click', el.updatePwdTrigger, that._updatePwd, that);
			delegate(el.template, 'click', el.enlightTrigger, that._toggelEnlightEvt, that);
		},
		//初始化分页
		_pagination: function(){
			var
				that = this;
			that._pagination = Pagination(that.opts);
		},
		/**
		 * 打开新建弹出框
		 * @return {[type]} [description]
		 */
		_new: function(e){
			var
				that = this,data,
				content = DOM.html(el.newTpl);
			Dialog.alert(content,function(){},{footer: 
				{
					btns:[{
                    text: '保存',
                    clickHandler: function(e,me){
                        that.defenderNewObj.validAll(function(rs){
                            if(rs){
                            	data = DOM.serialize(el.newForm);
                        		that._saveNew(data);
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
                	that._validNewHandler();
                },
                title: "添加管理员：",
                width: 600,
                top:100
            });
		},
		/**
		 * 打开修改管理员弹出框
		 * @return {[type]} [description]
		 */
		_update: function(e){
			var
				that = this,data,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
                name = $(el.name, tr).html(),
                mobile = $(el.mobile, tr).html(),
				content = Juicer(el.updateTpl,{name:name,mobile:mobile});
			Dialog.alert(content,function(){},{footer: 
				{
					btns:[{
                    text: '保存',
                    clickHandler: function(e,me){
                        that.defenderUpdateObj.validAll(function(rs){
                            if(rs){
                            	data = DOM.serialize(el.updateForm);
                            	S.mix(data,{id:id});
                            	that._saveUpdate(data, tr);
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
                	that.defenderUpdateObj = Defender(el.updateForm,{theme:'inline'})
                },
                title: "编辑管理员：",
                width: 600,
                top:100
            });
		},
		/**
		 * 打开修改管理员密码弹出框
		 * @return {[type]} [description]
		 */
		_updatePwd: function(e){
			var
				that = this,data,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				content = DOM.html(el.updatePwdTpl);
			Dialog.alert(content,function(){},{footer: 
				{
					btns:[{
                    text: '保存',
                    clickHandler: function(e,me){
                        that.defenderUpdatePwdObj.validAll(function(rs){
                            if(rs){
                            	data = DOM.serialize(el.updatePwdForm);
                            	S.mix(data,{id:id});
                            	that._saveUpdatePwd(data);
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
                	that.defenderUpdatePwdObj = Defender(el.updatePwdForm,{theme:'inline'})
                },
                title: "修改管理员密码：",
                width: 600,
                top:100
            });
		},
		/**
		 * 保存管理员添加操作
		 * @param  {[type]} target      [description]
		 * @param  {[type]} tipHolderEl [description]
		 * @return {[type]}             [description]
		 */
		_saveNew: function(data){
			var
				that = this;
			AdministratorIO.newAdministrator(data,function(code, errMsg){
                if(code){
                	that._pagination.reload();
                    Dialog.alert(SUCCESS_TIP[0]);
                }else{
                    Dialog.alert(errMsg);
                }
            });
		},
		/**
		 * 保存管理员修改操作
		 * @param  {[type]} target      [description]
		 * @param  {[type]} tipHolderEl [description]
		 * @return {[type]}             [description]
		 */
		_saveUpdate: function(data, tr){
			var
				name = DOM.get(el.name, tr);
			AdministratorIO.updateAdministrator(data,function(code, errMsg){
                if(code){
                    Dialog.alert(SUCCESS_TIP[1]);
                    DOM.html(name, data.name);
                }else{
                    Dialog.alert(errMsg);
                }
            });
		},
		/**
		 * 保存管理员密码修改操作
		 * @param  {[type]} target      [description]
		 * @param  {[type]} tipHolderEl [description]
		 * @return {[type]}             [description]
		 */
		_saveUpdatePwd: function(data){
			AdministratorIO.updatePwd(data,function(code, errMsg){
                if(code){
                    Dialog.alert(SUCCESS_TIP[2]);
                }else{
                    Dialog.alert(errMsg);
                }
            });
		},
		/**
         * 新建管理员的表单验证
         * @return {[type]} [description]
         */
        _validNewHandler:function(){
            this.defenderNewObj = Defender(el.newForm,{
                theme:'inline',
                items:[
                    //验证码验证
                    {
                        queryName:el.adminMobile,
                        pattern: function(input,shell,form){
                            var
                                mobile = DOM.val(input);
				            if(this.test('isMobile', mobile)){
                                AdministratorIO.sendMobile({mobile:mobile}, function(code, errMsg){
                                    if(code){
                                    	shell.updateState('success');
                                    }else{
                                        shell.updateErrTip(errMsg);
                                    	shell.updateState('error');
                                    }
                                })
                            }else{
                                return false;
                            }
                            return 'loading';
                        },
                        tip: '请输入手机号码|手机号码输入有误，请重新填写',
                        showEvent:'focus',
                        vldEvent:'blur',
                        async: true
                    }
                ] 
            });
        },
        /**
		 * 停用启用设置
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_toggelEnlightEvt: function(e){
			var
				that = this,
				target = e.target ,
				statusTip = S.trim(DOM.html(target)),
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				td = DOM.get(el.status, tr),
				status;
			if(statusTip == ENLIGHT_TIP[0]){
				//现在是启用状态，即将变成停用
				status = ABLED_STATUS;
			}else{
				//现在是停用状态，即将变成启用
				status = DISABLED_STATUS;
			}
			Dialog.confirm(CONFIRM_TIP, function(){
				AdministratorIO.toggelEnlight({
					id: id,
					status: status
				}, function(code, errMsg){
					if(code){
						switch(statusTip){
							case ENLIGHT_TIP[0]:
								DOM.html(target, ENLIGHT_TIP[1]);
								DOM.text(td, '已停用');
								break;
							case ENLIGHT_TIP[1]:
								DOM.html(target, ENLIGHT_TIP[0]);
								DOM.text(td, '已启用');
								break;
						}
						Dialog.alert(SUCCESS_TIP[3]);
					}else{
						Dialog.alert(errMsg);
					}
				}, null, {width: 600});
			})
		}
	});
	return Core;
},{
	requires:[
		'mod/ext',
		'mod/pagination',
		'mod/defender',
        'io/administrator',
        'widget/dialog',
        'mod/juicer'
	]
});