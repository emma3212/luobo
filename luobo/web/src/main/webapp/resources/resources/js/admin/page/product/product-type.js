/*-----------------------------------------------------------------------------
* @Description: 查看商品分类列表 
* @Version: 	V1.0.0
* @author: 		kt(928841785@qq.com)
* @date			2015.01.13
* ==NOTES:=============================================
* v1.0.0(2015.01.13):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/product/product-type', function (S, Core) {
    PW.namespace('page.product.productType');
    PW.page.product.productType = function(param){
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
		Pagination = PW.mod.Pagination.client,
		Dialog = PW.widget.Dialog,
		ProductIO = PW.io.Product,
		el = {
			form:'.J_from',
			//table的tbody
			template:'#J_template',
            //添加触发器
            newTrigger: '.J_new',
            //编辑触发器
            editTrigger: '.J_update',
            //保存触发器
            saveTrigger: '.J_save',
            //停用启用触发器
            enlightTrigger: '.J_enlight',
            //可编辑模板
            editTpl: '#editTpl',
            //保存模板
            saveTpl: '#saveTpl',
            //取消触发器
            cancelTrigger: '.J_cancel',
            //子分类
            subTrigger:'.J_subclassification',
            //返回按钮
            goBack:'.J_goBack',
            //产品名称
            productName:'.J_productName',
            //隐藏域父亲id
            pIdInp:'.J_pIdInp',
            //父分类名称
            fatherName:'.J_fatherName',
            //去掉进入的th
            removeTh:'.J_removeTh',
            //当前状态
            presentStatus:'.J_status',
		},
		ABLED_STATUS = 0,
		DISABLED_STATUS = 1,
		//启用停用显示方式
        ENLIGHT_TIP = ['停用', '启用'],
        CONFIRM_TIP = '确定要执行该操作吗？',
		//tr的id属性
		DATA_ID = 'data-product-id',
		//操作类型：新增or修改
		DATA_TYPE = 'data-type',
		ADDBTN_TIP = ['添加商品子分类 <i class="fa fa-plus"></i>','添加商品分类 <i class="fa fa-plus"></i>'],
		SUCCESS_TIP = ['新增分类成功！', '修改分类成功！', '状态修改成功！'],
		FAIL_TIP = ['操作失败：已存在编辑项，请保存后再操作！'];
	var
		Core = function(param){
			this.opts = param;
			//父分类名称
			this.fatherName = '顶级分类';
			//父分类id
			this.fatherId = 0;
			this.pagination;
			this._defender = Defender(el.form, {showTip: false});
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._initPagination();
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
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
            //进入子分类
            delegate(el.template, 'click', el.subTrigger, function(e){
            	that._enterSub(e.target);
            });
            //返回父分类
            delegate('.page', 'click', el.goBack, function(e){
            	that._goBack(e.target);
            });
		},
		//初始化分页
		_initPagination: function(){
    		this.opts = S.merge(this.opts, {
    			extraParam: {
    				fatherId: 0
    			}
    		});
    		this.pagination = Pagination(this.opts);
    	},
		/**
		 * 添加操作
		 * @return {[type]} [description]
		 */
		_newHandler: function(){
			var
				that = this,
				data = that._getRenderData('', 'new');
			DOM.remove('td[colspan=5]');
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
		 * 获取渲染数据
		 * @param  {[type]} trObj [description]
		 * @param  {[type]} type  [description]
		 * @return {[type]}       [description]
		 */
		_getRenderData: function(trObj, type){
			var  that = this,
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
				fatherName: datas[1],
				presentStatus: datas[2],
				type: type,
				fatherId: that.fatherId
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
				that = this, html, htmlEl;
			if(trObj){
				html = Juicer(el.editTpl, data);
				htmlEl = DOM.create(html);
				DOM.insertBefore(htmlEl, trObj);
				that._hideTr(trObj);
			}else{
				data = S.merge(data,{presentStatus:'已启用',fatherName: that.fatherName,fatherId: that.fatherId});
				html = Juicer(el.editTpl, data);
				htmlEl = DOM.create(html);
				DOM.prepend(htmlEl, el.template);
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
		 * 保存操作
		 * @return {[type]} [description]
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
				data = S.merge(DOM.serialize(el.form), {id: '', fatherId:that.fatherId});
			ProductIO.newType(data, function(code, errMsg){
				if(code){
					that.pagination.reload();
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
				data = S.merge(DOM.serialize(el.form), {id: id});
			ProductIO.editType(data, function(code, errMsg){
				if(code){
					that._renderSaveTpl(data, tr, 'edit');
					Dialog.alert(SUCCESS_TIP[1]);
				}else{
					Dialog.alert(errMsg);
				}
			});
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
				presentStatus = (type == 'edit') ? S.trim($(el.presentStatus, nextEl).html()) : '已启用',
				saveHtml, saveEl;
			S.mix(data, {presentStatus:presentStatus, status: status, fatherName:that.fatherName,fatherId:that.fatherId});
			saveHtml = Juicer(el.saveTpl, data);
			saveEl = DOM.create(saveHtml);
			DOM.replace(trObj, saveEl);
			if(type == 'edit') DOM.remove(nextEl);
		},
		/**
		 * 停用启用操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_enlightHandler: function(e){
			var
				that = this,
				statusTip = S.trim(DOM.html(e)),
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				td = DOM.get(el.presentStatus, tr),
				status;
			if(statusTip == ENLIGHT_TIP[0]){
				//启用状态0
				status = ABLED_STATUS;
			}else{
				//停用状态1
				status = DISABLED_STATUS;
			}
			Dialog.confirm(CONFIRM_TIP, function(){
				ProductIO.enlight({id: id}, function(code, errMsg){
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
				});
			},null, {width: 600});
			
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
		},
		/**
    	 * 进入子分类
    	 * @param  {[type]} e [description]
    	 * @return {[type]}   [description]
    	 */
    	_enterSub: function(target){
    		var
    			that = this,
    			tr = DOM.parent(target, 'tr'),
    			input = DOM.get('input', tr),
    			id = DOM.attr(tr, DATA_ID),
                typeNameEl = get(el.productName, tr),
                typeName = DOM.text(typeNameEl);
            if(input){
            	Dialog.alert(FAIL_TIP[0]);
            	return false;
            }
            that.fatherName = typeName;
            that.fatherId = id;
    		that.pagination.reload({
    			extraParam:{
    				fatherId: id
    			}
    		});
    		if(id != 0){
    			$(el.goBack).show();
    			$(el.removeTh).hide();
                $(el.newTrigger).html(ADDBTN_TIP[0]);
    		}
    	},
    	_goBack:function(target){
    		var
    			that = this;
    		that.fatherId = 0;
	        that.fatherName = '顶级分类';
	        $(el.goBack).hide();
			$(el.removeTh).show();	
			$(el.newTrigger).html(ADDBTN_TIP[1]);
    		that.pagination.reload({
    			extraParam:{
    				fatherId: 0
    			}
    		});
    	}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/pagination',
				'io/product',
				'mod/defender',
				'widget/dialog',
				'mod/juicer'
			]
})