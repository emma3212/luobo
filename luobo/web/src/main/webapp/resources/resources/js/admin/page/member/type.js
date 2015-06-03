/*-----------------------------------------------------------------------------
* @Description: 会员类型管理列表 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.01.13
* ==NOTES:=============================================
* v1.0.0(2015.01.13):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/member/type', function (S, Core) {
    PW.namespace('page.member.Type');
    PW.page.member.Type = function(param){
        new Core(param);
    }
},{
    requires:[
        'type/core'
    ]
});
KISSY.add('type/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, Juicer = PW.mod.Juicer,
		Defender = PW.mod.Defender.client,
		Dialog = PW.widget.Dialog,
		MemberIO = PW.io.Member,
		el = {
			//form
			form: '.J_form',
			//table的tbody
			template:'#J_template',
            //添加触发器
            newTrigger: '.J_new',
            //编辑触发器
            editTrigger: '.J_edit',
            //保存触发器
            saveTrigger: '.J_save',
            //停用启用触发器
            enlightTrigger: '.J_enlight',
            //可编辑模板
            editTpl: '#editTpl',
            //保存模板
            saveTpl: '#saveTpl',
            //取消触发器
            cancelTrigger: '.J_cancel'
		},
		ABLED_STATUS = 0,
		DISABLED_STATUS = 1,
		//启用停用显示方式
        ENLIGHT_TIP = ['删除'],
        CONFIRM_TIP = '确定要执行该操作吗？',
		//tr属性
		DATA_ID = 'data-type-id',
		DATA_TYPE = 'data-type',
		SUCCESS_TIP = ['新增币种成功！', '修改币种成功！', '删除成功！'],
		FAIL_TIP = ['操作失败：请先保存当前操作！'];
	var
		Core = function(param){
			this.opts = param;
			this._defender = Defender(el.form, {showTip: false});
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this,
				flag;
			//停用、启用操作
            delegate(el.template, 'click', el.enlightTrigger, function(e){
                that._enlightHandler(e.target);

            });
            //修改
            delegate(el.template, 'click', el.editTrigger, function(e){
            	that._editHandler(e.target);
            });
            //取消
            delegate(el.template, 'click', el.cancelTrigger, function(e){
            	that._cancelHandler(e.target);
            });
            //保存
            delegate(el.template, 'click', el.saveTrigger, function(e){
            	that._saveHandler(e.target);
            });
            //添加
            on(el.newTrigger, 'click', that._newHandler, that);
		},
		/**
		 * 添加操作
		 * @return {[type]} [description]
		 */
		_newHandler: function(){
			var
				that = this,
				data = that._getRenderData('', 'new');
			if(!that._isEdit()){
				that._renderTpl(data);
				that._defender.refresh();
			}else{
				Dialog.alert(FAIL_TIP[0]);
			}
			
		},
		/**
		 * 修改操作
		 * @return {[type]} [description]
		 */
		_editHandler: function(target){
			var
				that = this,
				tr = DOM.parent(target, 'tr'),
				data = that._getRenderData(tr, 'edit');
			if(!that._isEdit()){
				that._renderTpl(data, tr);
				that._defender.refresh();
			}else{
				Dialog.alert(FAIL_TIP[0])
			}
		},
		/**
		 * 取消操作
		 * @return {[type]} [description]
		 */
		_cancelHandler: function(target){
			var
				that = this,
				tr = DOM.parent(target, 'tr'),
				type = DOM.attr(tr, DATA_TYPE);
			switch(type){
				case 'edit':
					that._showTr(DOM.next(tr));
					DOM.remove(tr);
					break;
				case 'new':
					DOM.remove(tr);
			}
		},
		_saveHandler: function(target){
			var
				that = this,
				tr = DOM.parent(target, 'tr'),
				type = DOM.attr(tr, DATA_TYPE);
			that._defender.validAll(function(rs){
				if(rs){
					switch(type){
						case 'new': 
							that._newSave(tr);
							break;
						case 'edit':
							that._editSave(tr);
							break;
					}
				}
			});
			
		},
		/**
		 * 新建保存
		 * @return {[type]} [description]
		 */
		_newSave: function(tr){
			var
				that = this,
				statusStr = S.trim(DOM.html(query('td', tr)[3])),

				extraData = S.merge(DOM.serialize(el.form),{id: ''});
			MemberIO.newType(extraData, function(code, data, errMsg){
				if(code){
					extraData.id = data.id;
					S.mix(extraData,{statusStr: statusStr});
					that._renderSaveTpl(extraData, tr);
					Dialog.alert(SUCCESS_TIP[0]);
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 编辑保存
		 * @return {[type]} [description]
		 */
		_editSave: function(tr){
			var
				that = this,
				id = DOM.attr(tr, DATA_ID),
				statusStr = S.trim(DOM.html(query('td', tr)[3])),
				data = S.merge(DOM.serialize(el.form), {id: id});
			MemberIO.editType(data, function(code, errMsg){
				if(code){
					S.mix(data,{statusStr: statusStr});
					that._renderSaveTpl(data, tr, 'edit');
					Dialog.alert(SUCCESS_TIP[1]);
					
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 删除操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_enlightHandler: function(e){
			var
				that = this,
				statusTip = S.trim(DOM.html(e)),
				tr = DOM.parent(e, 'tr'),
				statusStrEl = query('td', tr)[3],
				id = DOM.attr(tr, DATA_ID),
				status;
			Dialog.confirm(CONFIRM_TIP, function(){
				MemberIO.enlightType({id: id}, function(code, errMsg){
					if(code){
						switch(statusTip){
							case ENLIGHT_TIP[0]:
								DOM.html(e, ENLIGHT_TIP[1]);
								DOM.html(statusStrEl, '已'+ENLIGHT_TIP[0]);
								break;
							case ENLIGHT_TIP[1]:
								DOM.html(e, ENLIGHT_TIP[0]);
								DOM.html(statusStrEl, '已'+ENLIGHT_TIP[1]);
								break;
						}
						Dialog.alert(SUCCESS_TIP[2]);
						DOM.remove(tr);
					}else{
						Dialog.alert(errMsg);
					}
				});
			},null, {width: 600});
			
		},
		/**
		 * 获取渲染数据
		 * @param  {[type]} trObj [description]
		 * @param  {[type]} type  [description]
		 * @return {[type]}       [description]
		 */
		_getRenderData: function(trObj, type){
			var
				id = (type == 'edit') ? DOM.attr(trObj, DATA_ID) : '',
				tds = (type == 'edit') ? query('td', trObj) : undefined,
				datas = [], data = {};

			if(tds){
				S.each(tds, function(td){
					datas.push(DOM.html(td));
				});
			}
			
			data = {
				id: id,
				name: datas[0],
				creditLine: datas[1],
				anyRepayCreditLine: datas[2],
				statusStr: (type == 'edit') ? datas[3] : '已'+ENLIGHT_TIP[1],
				type: type
			};
			return data;
		},
		/**
		 * 渲染修改模板
		 * 当存在trObj时，替换当前记录，当不存在trObj时，在table第一行添加空记录
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_renderTpl: function(data, trObj){
			var
				that = this,
				html = Juicer(el.editTpl, data),
				htmlEl = DOM.create(html),
				emptyTr = DOM.parent('td[colspan="5"]', 'tr');
			DOM.remove(emptyTr);
			if(trObj){
				DOM.insertBefore(htmlEl, trObj);
				that._hideTr(trObj);
			}else{
				DOM.prepend(htmlEl, el.template);
			}
		},
		/**
		 * 渲染保存模板
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_renderSaveTpl: function(data, trObj, type){
			var
				that = this,
				nextEl = DOM.next(trObj),
				status = (type == 'edit') ? S.trim($(el.enlightTrigger, nextEl).html()) : ENLIGHT_TIP[0],
				saveHtml, saveEl;
			S.mix(data, {status: status});
			saveHtml = Juicer(el.saveTpl, data);
			saveEl = DOM.create(saveHtml);
			DOM.replace(trObj, saveEl);
			if(type == 'edit') DOM.remove(nextEl);
		},
		/**
		 * 是否已经编辑
		 * 已经存在编辑返回 true， 不存在编辑返回false
		 * @return {Boolean} [description]
		 */
		_isEdit: function(){
			var
				that = this,
				saveBtns = $(el.saveTrigger, el.template);
			if(saveBtns.length >= 1){
				return true;
			}else{
				return false;
			}
		},
		/**
		 * 隐藏记录
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_hideTr: function(trObj){
			DOM.hide(trObj);
		},
		/**
		 * 显示记录
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_showTr: function(trObj){
			DOM.show(trObj);
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/pagination',
				'io/member',
				'mod/defender',
				'widget/dialog',
				'mod/juicer'
			]
})