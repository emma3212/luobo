/*-----------------------------------------------------------------------------
* @Description: 区域管理列表 
* @Version: 	V1.0.0
* @author: 		KT(928841785@qq.com)
* @date			2015.01.5
* ==NOTES:=============================================
* v1.0.0(2015.01.5):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/region/region-list', function (S, Core) {
    PW.namespace('page.region.regionList');
    PW.page.region.regionList = function(){
        new Core();
    }
},{
    requires:[
        'list/core'
    ]
});
KISSY.add('list/core', function(S){
	var
		DOM = S.DOM, get = DOM.get,$ = S.all,query = DOM.query,
		on = S.Event.on, delegate = S.Event.delegate,
		Dialog = PW.widget.Dialog,
		RegionIO = PW.io.Region,
		Defender = PW.mod.Defender.client,
		Juicer = PW.mod.Juicer,
		el = {
			//操作表单
            operForm: '.J_operForm',
			//table的tbody
			template:'#J_template',
			//启用停用触发器
            enlightTrigger: '.J_enlight',
            //编辑按钮
			updateTrigger:'.J_update',
			//保存按钮
			saveTrigger:'.J_save',
			//保存按钮
			addTrigger:'.J_new',
			//取消按钮
			cancelTrigger:'.J_cancel',
			//区域名称
			regionName:'.J_regionName',
			//负责人
			managerEl: '.J_manager',
			//会员数量
			memberNum:'.J_memberNum',
			//当前状态
			presentStatus:'.J_status',
			// 联系人电话
			phone: '.J_phone'
		},
		ABLED_STATUS = 0,
		DISABLED_STATUS = 1,
		//启用停用显示方式
        ENLIGHT_TIP = ['停用', '启用'],
        CONFIRM_TIP = '操作失败：已存在编辑项，请保存后再操作！',
		//tr属性
		DATA_ID = 'region-id',
		CONTENT = '确定要修改状态吗？', 
		//操作类型是'update' or 'new'
        OPER_ATTR_TYPE = 'data-oper-type',
		SUCCESS_TIP = ['修改成功！', '添加成功！', '状态更改成功！'];
	var
		Core = function(){
			this.defender = Defender(el.operForm, {showTip: false});
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			//判断是否已经有保存状态的tr，进行编辑操作
			delegate(el.template, 'click',  el.updateTrigger,function(evt){
				if(that._isUpdate(evt.target)){
					that._updateOper(evt.target);
				}			
			});
			//保存
			delegate(el.template, 'click', el.saveTrigger, function(evt){
                that._saveRegionEvt(evt.target);
            });
            //判断是否已经有保存状态的tr，添加新区域
            on(el.addTrigger, 'click', function(evt){
                 if(that._isUpdate(evt.target)){
                    that._addRegionEvt(evt.target);
                }
            });
             //取消修改操作
            delegate(el.template, 'click', el.cancelTrigger, function(evt){
                that._cancelRegion(evt.target);
            });
			//启用停用设置
            delegate(el.template, 'click', el.enlightTrigger, function(evt){
                that._toggelEnlightEvt(evt.target);
            });
		},
		/**
         * 添加区域
         * @param {[type]} e [description]
         */
        _addRegionEvt: function(e){
            var
                that = this,
                newTemp = DOM.html('#updateInpTpl'),
                newTempStr = Juicer(newTemp, {customerNum: 0,presentStatus:'已启用'}),
                newEl = DOM.create(newTempStr);
            DOM.prepend(newEl, el.template);
            that.defender.refresh();
        },
		/**
         * 编辑操作
         * @return {[type]} [description]
         */
		_updateOper:function(e){
			var
				that = this,
				$tr = DOM.parent(e, 'tr'),
                id = DOM.attr($tr, DATA_ID),
				oldName = $(el.regionName, $tr).html(),
				oldNumber = $(el.memberNum, $tr).html(),
				manager = $(el.managerEl, $tr).html(),
				presentStatus = $(el.presentStatus, $tr).html(),
				phone = $(el.phone, $tr).html(),
				region = {
					id: id,
					name:oldName,
					customerNum:oldNumber,
					manager: manager,
					presentStatus:presentStatus,
					type: 'update',
					phone: phone
				};
			DOM.hide($tr);
            that._renderEditOper(region, $tr);
		},
		 /**
         * 渲染修改信息
         * @return {[type]} [description]
         */
        _renderEditOper: function(obj, oldTr){
            var
                that = this,
                newTemp = DOM.html('#updateInpTpl'),
                newTempStr = Juicer(newTemp, obj),
                newEl = DOM.create(newTempStr);
            DOM.insertBefore(newEl, oldTr);
            that.defender.refresh();
        },
         /**
         * 保存区域
         * @param  {[type]} e [description]
         * @return {[type]}   [description]
         */
        _saveRegionEvt: function(e){
            var
                that = this,
                tr = DOM.parent(e, 'tr'),
                type = DOM.attr(tr, OPER_ATTR_TYPE),
                id = DOM.attr(tr, DATA_ID),
                d = DOM.serialize(el.operForm),
                d = S.merge(d, {
                    id: id
                });
            that.defender.validAll(function(rs){
                if(rs){
                	if(type == 'update'){
                		//修改的保存
                		RegionIO.updateRegion(d, function(code, errMsg){
		                    if(code){
		                    	S.mix(d, {type:'update'});
		                        that._renderUpdateSaveOper(d, tr);
		                        Dialog.alert(SUCCESS_TIP[0]);
		                    }else{
		                        Dialog.alert(errMsg);
		                    }
		                })
                	}else{
                		//新建的保存
                		RegionIO.newRegion(d, function(code, data, errMsg){
		                    if(code){
		                    	S.mix(d, {type:'new', id:data.id});
		                    	that._renderUpdateSaveOper(d, tr);
		                    	Dialog.alert(SUCCESS_TIP[1]);
		                    }else{
		                        Dialog.alert(errMsg);
		                    }
		                })
                	}
                }
            })
        },
         /**
         * 渲染保存后区域信息，并删除掉原有信息
         * @param  {[type]} data [description]
         * @return {[type]}      [description]
         */
        _renderUpdateSaveOper: function(data ,trObj){
            var
                that = this,data, prevTr, enabled, presentStatus,
                newTemp, editTempStr, newEl;
            if(data.type == 'update'){
            	prevTr = DOM.next(trObj);
                enabled = $(el.enlightTrigger, prevTr).html();
                presentStatus = $(el.presentStatus, prevTr).html();
                data = S.merge(data, {
                    presentStatus:presentStatus,
                    enabled: enabled
                });
                DOM.remove(prevTr);
            }else{
            	data = S.merge(data, {
                    enabled: '停用',
                    presentStatus:'已启用'
                });
            }
            newTemp = DOM.html('#updateTpl');
            editTempStr = Juicer(newTemp, data);
            newEl = DOM.create(editTempStr);
            DOM.replace(trObj, newEl);
        },
        /**
         * 取消修改操作
         * @param  {[type]} target [description]
         * @return {[type]}        [description]
         */
        _cancelRegion: function(target){
            var
                that = this,
                tr = DOM.parent(target, 'tr'),
                prevTr = DOM.next(tr);
            DOM.show(prevTr);
            DOM.remove(tr);
        },
		/**
		 * 停用启用设置
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_toggelEnlightEvt: function(e){
			var
				that = this,
				statusTip = S.trim(DOM.html(e)),
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				td = DOM.get(el.presentStatus, tr),
				status;
			if(statusTip == ENLIGHT_TIP[0]){
				//启用状态
				status = ABLED_STATUS;
			}else{
				//停用状态
				status = DISABLED_STATUS;
			}
			Dialog.confirm(CONTENT, function(){
				RegionIO.toggelEnlight({
					id: id,
					enabled: status
				}, function(code, errMsg){
					if(code){
						switch(statusTip){
							case ENLIGHT_TIP[0]:
								DOM.html(e, ENLIGHT_TIP[1]);
								DOM.html(td, '已停用');
								break;
							case ENLIGHT_TIP[1]:
								DOM.html(e, ENLIGHT_TIP[0]);
								DOM.html(td, '已启用');
								break;
						}
						Dialog.alert(SUCCESS_TIP[2]);
					}else{
						Dialog.alert(errMsg);
					}
				})
			})
		},
        //判断是否已经有保存状态的tr
		_isUpdate:function(e){
			var
				that = this,
				saveBtn = DOM.get(el.saveTrigger,el.template);
			if(saveBtn){
            	Dialog.alert(CONFIRM_TIP);
				return false;
			}
			return true;
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/defender',
				'mod/juicer',
				'io/region',
				'widget/dialog'
			]
})