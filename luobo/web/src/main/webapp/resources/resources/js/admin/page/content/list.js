/*-----------------------------------------------------------------------------
* @Description:     页面管理列表控制
* @Version:         1.0.0
* @author:          wangjing(1284663246@qq.com)
* @date             2015.01.20
* ==NOTES:=============================================
* v1.0.0(2015.01.20):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/content/list', function(S, Core){
	PW.namespace('page.content.List');
	PW.page.content.List = function(param){
        return new Core(param);
    }
},{
	requires:[
		'page/core'
	]
});

KISSY.add('page/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, $ = S.all, delegate = S.Event.delegate,
        Juicer = PW.mod.Juicer,
        Dialog = PW.widget.Dialog,
        Defender = PW.mod.Defender.client,
        Pagination = PW.mod.Pagination.client,
        pageIO = PW.io.Page,
        config = {
            
        },
        el = {
            //操作表单
            operForm: '.J_operForm',
            //添加触发器
            addTrigger: '.J_add',
            //保存触发器
            saveTrigger: '.J_save',
            //修改触发器
            editTrigger: '.J_edit',
            //取消触发器
            cancelTrigger: '.J_cancel',
            // 取消触发器
            delTrigger: '.J_del',
            //编辑模板
            itemTemp: '#editTpl',
            //数据渲染
            dataTemp: '#J_template',  
            // 列表项的页面标题
            name: '.J_name',
            // 列表项的页面链接
            link: '.J_link',
            // 页面标题 
            pageName: '.J_pageName',
            // 进入触发器
            enter: '.J_enter',
            view: '.J_view'
        },
        DATA_PAGE_ID = 'data-page-id',
        DATA_OPER_TYPE = 'data-oper-type',
        ERROR_TIP = ['操作失败：已存在编辑项，请保存后再操作！', '保存页面失败：页面标题一栏为空!'],
        CONFIRM_TIP = ['确定删除该页面吗？'],
        SUCCESS_TIP = ['添加成功!','修改成功！','删除成功！'],
        EDIT_SAVE_TEMP = '<tr data-tag-id="&{id}">'+
                         '<td class="J_name">&{title}</td>'+
                         '<td class="J_link">&{link}</td>'+
                         '</tr>';
        
	function Core(param){
		this.opts = S.merge(config, param);
		this.pagination;
		this.defender = Defender(el.operForm, {showTip: false});
		this._init();
	}

	S.augment(Core, {
		_init: function(){
			this._buildEvt();
			this._initPagination();
		},
		_buildEvt: function(){
			var
				that = this;

			on(el.addTrigger, 'click', function(){
				if(!that._isEdit()){
					that._add();
				}
			});

			delegate(el.dataTemp, 'click', el.delTrigger, function(e){
				if(!that._isEdit()){
					that._del(e.target);
				}
			});

			delegate(el.dataTemp, 'click', el.editTrigger, function(e){
				if(!that._isEdit()){
					that._edit(e.target);
				}
			});

			delegate(el.dataTemp, 'click', el.saveTrigger, function(e){
				that._save(e.target);
			});

			delegate(el.dataTemp, 'click', el.cancelTrigger, function(e){
				that._cancel(e.target);
			});
		},
		/**
		 * 初始化分页
		 * @return {[type]} [description]
		 */
		_initPagination: function(){
			var
				that = this,
				opts = that.opts;
			that.pagination = Pagination(opts);
		},
		/**
		 * 添加页面
		 */
		_add: function(){
			var
				that = this,
				defender = that.defender,
				newTemp = DOM.html(el.itemTemp),
				newTempStr = Juicer(newTemp, {page:{}}),
				newEl = DOM.create(newTempStr);

			DOM.prepend(newEl, el.dataTemp);
			DOM.remove('td[colspan="3"]');
			defender.refresh();
		},
		/**
		 * 删除页面
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_del: function(e){
			var
			 	that = this,
			 	tr = DOM.parent(e, 'tr'),
			 	id = DOM.attr(tr, DATA_PAGE_ID);

			Dialog.confirm(CONFIRM_TIP, function(e,me){
				pageIO.del({
					id: id
				}, function(code, errMsg){
					if(code){
						that.pagination.reload();
						Dialog.alert(SUCCESS_TIP[2]);
					}else{
						Dialog.alert(errMsg);
					}
				});
			}, null,{width: 600});
		},
		/**
		 * 编辑页面操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_edit: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
			 	id = DOM.attr(tr, DATA_PAGE_ID),
			 	nameEl = get(el.name, tr),
			 	name = DOM.text(nameEl),
			 	linkEl = get(el.link, tr),
			 	link = DOM.text(linkEl),
			 	data = {
			 		id: id,
			 		name: name,
			 		link: link,
			 		type: 'edit'
			 	};
			that._renderEditOper(data, tr);
		},
		/**
		 * 渲染编辑模板
		 * @param  {[type]} data  [description]
		 * @param  {[type]} oldtr [description]
		 * @return {[type]}       [description]
		 */
		_renderEditOper: function(data, oldtr){
			var
				that = this,
				defender = that.defender,
				editTemp = DOM.html(el.itemTemp),
				editTempStr = Juicer(editTemp, {page:data}),
				editEl = DOM.create(editTempStr);

			DOM.insertAfter(editEl, oldtr);
			DOM.hide(oldtr);
			defender.refresh();
		},
		/**
		 * 保存标签
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_save: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
				defender = that.defender,
				data = DOM.serialize(el.operForm),
				type = DOM.attr(tr, DATA_OPER_TYPE),
				pageNameEl = get(el.pageName, tr),
				pageName = DOM.val(pageNameEl),
				linkEl = get(el.link, tr),
				link = DOM.text(linkEl),
				obj = S.merge(data, {
					link: link
				});

			if(!pageName){
				Dialog.alert(ERROR_TIP[1], function(){
					pageNameEl.focus();
				});
				return false;
			}
			defender.validAll(function(rs){
				if(rs){
					if(type == 'edit'){
						that._editSave(obj, tr);
					}else{
						that._newSave(data);
					}
				}else{
					S.log('系统异常');
				}
			});
		},
		/**
		 * 修改保存
		 * @param  {[type]} data [description]
		 * @return {[type]}      [description]
		 */
		_editSave: function(data, tr){
			var
				that = this;
			pageIO.edit(data, function(code, errMsg){
				if(code){
					that._renderEditSaveOper(data, tr);
					Dialog.alert(SUCCESS_TIP[1]);
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 新建保存
		 * @param  {[type]} data [description]
		 * @return {[type]}      [description]
		 */
		_newSave: function(data){
			var
				that = this;
			pageIO.save(data, function(code, errMsg){
				if(code){
					that.pagination.reload();
					Dialog.alert(SUCCESS_TIP[0]);
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 渲染编辑后保存，并删去原来节点
		 * @param  {[type]} data [description]
		 * @param  {[type]} tr   [description]
		 * @return {[type]}      [description]
		 */
		_renderEditSaveOper: function(data, tr){
			var
				that = this,
				newTempStr = Juicer(EDIT_SAVE_TEMP, data),
				newEl = DOM.create(newTempStr),
				prevTr = DOM.prev(tr);

			DOM.replace(tr, newEl);
			//重置操作内容
			that._addExtraHandler(newEl);
			DOM.remove(prevTr);
		},
		/**
		 * 取消操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_cancel: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
				prevTr = DOM.prev(tr);

			DOM.remove(tr);
			DOM.show(prevTr);
		},
		/**
		 * 添加保存后额外操作
		 * 将原td中的操作按钮等元件复制到新信息行中
		 * @param {[type]} trObj [description]
		 */
		_addExtraHandler: function(trObj){
			var
				that = this,
				preEl = DOM.prev(trObj),
				handlerEl = DOM.last(preEl),
				newHanlderEl = DOM.clone(handlerEl, true, true);
			DOM.append(newHanlderEl, trObj);
		},
		/**
		 * 是否有编辑状态
		 * @return {Boolean} [存在编辑状态，返回 true; 不存在编辑状态返回false]
		 */
		_isEdit: function(){
			if(get(el.saveTrigger)){
					Dialog.alert(ERROR_TIP[0]);
					return true;
			}else{
				return false;
			}
		}
	});

	return Core;
},{
	requires:[
		'io/page',
		'widget/dialog',
		'mod/defender',
        'mod/pagination',
        'mod/juicer',
        'mod/ext'
	]
});