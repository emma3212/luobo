/*-----------------------------------------------------------------------------
* @Description: 站点展示图片管理列表 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.02.05
* ==NOTES:=============================================
* v1.0.0(2015.02.05):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/siteMange/img-mange', function (S, Core) {
    PW.namespace('page.siteMange.ImgManage');
    PW.page.siteMange.ImgManage = function(param){
        new Core(param);
    }
},{
    requires:[
        'imgManage/core'
    ]
});
KISSY.add('imgManage/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, Juicer = PW.mod.Juicer,
		Defender = PW.mod.Defender.client,
		Pagination = PW.mod.Pagination.client,
		Dialog = PW.widget.Dialog,
		SiteManageIO = PW.io.SiteManage,
		el = {
			//form
			form: '.J_form',
			//table的tbody
			template:'#J_template',
			//产品名称
			productName: '.J_productName',
            //添加触发器
            newTrigger: '.J_new',
            //编辑触发器
            editTrigger: '.J_edit',
            //保存触发器
            saveTrigger: '.J_save',
            //删除触发器
            delTrigger: '.J_del',
            //可编辑模板
            editTpl: '#editTpl',
            //保存模板
            saveTpl: '#saveTpl',
            //取消触发器
            cancelTrigger: '.J_cancel'
		},
		ABLED_STATUS = 0,
		DISABLED_STATUS = 1,
        CONFIRM_TIP = '确定要执行该操作吗？',
		//tr属性
		DATA_ID = 'data-product-id',
		DATA_TYPE = 'data-type',
		SUCCESS_TIP = ['新增链接成功！', '修改链接成功！', '删除链接成功！'],
		FAIL_TIP = ['操作失败：请先保存当前操作！'];
	var
		Core = function(param){
			this.opts = param;
			this._defender = Defender(el.form, {showTip: false});
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
				that = this,
				flag;
			//删除操作
            delegate(el.template, 'click', el.delTrigger, function(e){
                that._delHandler(e.target);
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
		//分页
		_pagination: function(){
			var
				that = this;
			that._pagination = Pagination(that.opts.pagi);
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
		/**
		 * 保存分发操作
		 * @param  {[type]} target [description]
		 * @return {[type]}        [description]
		 */
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
				typeId = that.opts.typeId,
				extraData = S.merge(DOM.serialize(el.form),{id: '', typeId: typeId});
			SiteManageIO.newImg(extraData, function(code, errMsg){
				if(code){
					that._pagination.reload();
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
				typeId = that.opts.typeId,
				id = DOM.attr(tr, DATA_ID),
				productName = S.trim(DOM.html(query('td', tr)[0])),
				data = S.merge(DOM.serialize(el.form), {id: id, typeId:typeId});
			SiteManageIO.editImg(data, function(code, errMsg){
				if(code){
					S.mix(data,{name: productName});
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
		_delHandler: function(e){
			var
				that = this,
				typeId = that.opts.typeId,
				statusTip = S.trim(DOM.html(e)),
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_ID);
			Dialog.confirm(CONFIRM_TIP, function(){
				SiteManageIO.delImg({id: id, typeId: typeId}, function(code, errMsg){
					if(code){
						that._pagination.reload();
						Dialog.alert(SUCCESS_TIP[2]);
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
				pid: (type == 'edit') ? datas[1] : 0,
				url: datas[2],
				rank:(type == 'edit') ? datas[3] : 0,
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
				emptyTr = DOM.parent('td[colspan="3"]', 'tr');
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
				status = S.trim($(el.enlightTrigger, nextEl).html()),
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
				'io/siteManage',
				'mod/defender',
				'widget/dialog',
				'mod/juicer'
			]
})