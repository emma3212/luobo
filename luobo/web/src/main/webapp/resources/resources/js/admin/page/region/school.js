/*-----------------------------------------------------------------------------
* @Description: 学校管理列表 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.01.12
* ==NOTES:=============================================
* v1.0.0(2015.01.12):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/region/school', function (S, Core) {
    PW.namespace('page.region.School');
    PW.page.region.School = function(){
        new Core();
    }
},{
    requires:[
        'list/core'
    ]
});
KISSY.add('list/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, Juicer = PW.mod.Juicer,
		Defender = PW.mod.Defender.client,
		Dialog = PW.widget.Dialog,
		regionIO = PW.io.Region,
		el = {
			//form
			form: '.J_form',
			//table的tbody
			template:'#J_template',
			//启用停用触发器
            toggleEnlightTrigger: '.J_enlight',
            //添加触发器
            newTrigger: '.J_new',
            //编辑触发器
            editTrigger: '.J_edit',
            //保存触发器
            saveTrigger: '.J_save',
            //区域选择
            reginList: '.J_reginList',
            //区域
            reginId: '.J_reginId',
            //可编辑模板
            editTpl: '#editTpl',
            //保存模板
            saveTpl: '#saveTpl',
            //区域模板
            reginTpl: '.J_reginTpl',
            //取消触发器
            cancelTrigger: '.J_cancel',
            //停用样式
            disabledClass: '.J_disable'
		},
		ABLED_STATUS = 0,
		DISABLED_STATUS = 1,
		//启用停用显示方式
        ENLIGHT_TIP = ['停用', '启用'],
		//tr属性
		DATA_ID = 'data-school-id',
		DATA_TYPE = 'data-type',
		CONFIRM_TIP = '确定要执行该操作吗？',
		SUCCESS_TIP = ['新增学校成功！', '修改学校成功！', '状态更改成功！'],
		FAIL_TIP = ['修改失败：选择区域已停用！', '操作失败：请先保存当前操作！'];
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
			//启用停用设置
            delegate(el.template, 'click', el.toggleEnlightTrigger, function(e){
                that._toggelEnlightEvt(e.target);
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
				Dialog.alert(FAIL_TIP[1])
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
				Dialog.alert(FAIL_TIP[1])
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
				statusStr = S.trim(DOM.html(query('td', tr)[5])),
				data = S.merge(DOM.serialize(el.form),{id: ''});
			//判断是否选择已禁用区域
			if(!that._hasDisabled()){
				regionIO.newSchool(data, function(code, reData, errMsg){
					if(code){
						S.mix(data, {region: that._getSelectName(),id: reData.id, statusStr: statusStr});
						that._renderSaveTpl(data, tr);
						Dialog.alert(SUCCESS_TIP[0]);
					}else{
						Dialog.alert(errMsg);
					}
				});
			}else{
				Dialog.alert(FAIL_TIP[0]);
			}
		},
		/**
		 * 编辑保存
		 * @return {[type]} [description]
		 */
		_editSave: function(tr){
			var
				that = this,
				id = DOM.attr(tr, DATA_ID),
				statusStr = S.trim(DOM.html(query('td', tr)[5])),
				data = S.merge(DOM.serialize(el.form), {id: id});
			//判断是否选择已禁用区域
			if(!that._hasDisabled()){
				regionIO.editSchool(data, function(code, errMsg){
					if(code){
						S.mix(data,{region: that._getSelectName(), statusStr: statusStr});
						that._renderSaveTpl(data, tr, 'edit');
						Dialog.alert(SUCCESS_TIP[1]);
						
					}else{
						Dialog.alert(errMsg);
					}
				});
			}else{
				Dialog.alert(FAIL_TIP[0]);
			}
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
				status;
			if(statusTip == ENLIGHT_TIP[0]){
				//启用状态
				status = ABLED_STATUS;
			}else{
				//停用状态
				status = DISABLED_STATUS;
			}
			Dialog.confirm(CONFIRM_TIP, function(){
				that._changeStatus(status, e);
			}, null);
			
		},
		/**
		 * 修改状态
		 * @return {[type]} [description]
		 */
		_changeStatus: function(status, e){
			var
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				statusTip = S.trim(DOM.html(e)),
				statusStrEl = query('td', tr)[4];
			regionIO.schoolEnlight({
				id: id,
				enabled: status
			}, function(code, errMsg){
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
				}else{
					Dialog.alert(errMsg);
				}
			});
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
					if(DOM.hasClass(td, 'J_regin')){
						datas.push($(el.reginId, td).val());
						return true;
					}
					datas.push(DOM.html(td));
				});
			}
			
			data = {
				id: id,
				name: datas[0],
				manager: datas[1],
				reginId: datas[2],
				customerNum: datas[3],
				phone: datas[4],
				statusStr: (type == 'edit') ? datas[5] : '已'+ENLIGHT_TIP[1],
				type: type
			};
			if(!data.customerNum) data.customerNum = 0;
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
				htmlEl = DOM.create(html);
			if(trObj){
				DOM.insertBefore(htmlEl, trObj);
				that._copyRegin(data.reginId);
				that._hideTr(trObj);
			}else{
				DOM.prepend(htmlEl, el.template);
				that._copyRegin(0);
			}
		},
		/**
		 * 渲染保存模板
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @param  {[type]} trObj [保存类型： 编辑时类型为：edit]
		 * @return {[type]}       [description]
		 */
		_renderSaveTpl: function(data, trObj, type){
			var
				that = this,
				nextEl = DOM.next(trObj),
				enabled = (type == 'edit') ? S.trim($(el.toggleEnlightTrigger, nextEl).html()) : ENLIGHT_TIP[0],
				saveHtml, saveEl;

			S.mix(data, {enabled: enabled});
			saveHtml = Juicer(el.saveTpl, data);
			saveEl = DOM.create(saveHtml);
			DOM.replace(trObj, saveEl);
			if(type == 'edit') DOM.remove(nextEl);
		},
		/**
		 * 克隆节点并赋值
		 * @param  {[type]} reginId [description]
		 * @return {[type]}         [description]
		 */
		_copyRegin: function(reginId){
			var
				reginEl = DOM.clone(el.reginTpl, true, true);
			DOM.append(reginEl, el.reginList);
			DOM.show(reginEl);
			DOM.val(el.reginTpl, reginId);
		},
		/**
		 * 获取选中区域名称
		 * @return {[type]} [description]
		 */
		_getSelectName: function(){
			var
				that = this,
				regionEl = DOM.get(el.reginTpl, el.template),
				region =  $(el.reginTpl, el.template).one("option:selected").text();
			return region;
		},
		/**
		 * 是否选择禁用
		 * @return {Boolean} [description]
		 */
		_hasDisabled: function(){
			var
				that = this,
				regionEl = DOM.get(el.reginTpl, el.template),
				region =  $(el.reginTpl, el.template).one("option:selected").hasClass(el.disabledClass);
			return region;
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
				'io/region',
				'mod/defender',
				'widget/dialog',
				'mod/juicer'
			]
})