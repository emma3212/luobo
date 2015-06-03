/*-----------------------------------------------------------------------------
* @Description:     页面管理列表控制
* @Version:         1.0.0
* @author:          wangjing(1284663246@qq.com)
* @date             2015.01.20
* ==NOTES:=============================================
* v1.0.0(2015.01.20):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/amount/list', function(S, Core){
	PW.namespace('page.Amount.List');
	PW.page.Amount.List = function(param){
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
        AmountIO = PW.io.Amount,
        config = {
            
        },
        el = {
        	// 搜索表单
			searchForm: '.J_searchForm',
            //操作表单
            operForm: '.J_operForm',
            //保存触发器
            saveTrigger: '.J_save',
            //修改触发器
            editTrigger: '.J_edit',
            //取消触发器
            cancelTrigger: '.J_cancel',
            //编辑模板
            itemTemp: '#editTpl',
            //数据渲染
            dataTemp: '#J_template',
            // 编辑之后的渲染模板
            renderTpl: '#renderTpl',
            // 列表中白条信用额度
            whiteBarAmount: '.white-bar-amount',
            // 列表中随意还信用额度
            anyReturnAmount: '.any-return-amount',
            // 列表中白条可用额度
			whiteBarUseAmount: '.white-bar-use-amount',
            // 列表中随意还可用额度
			anyReturnUseAmount: '.any-return-use-amount',
			// 编辑模板中白条可用额度输入框
			whiteBarUseAmountEl: '.J_whiteBarUseAmount',
			// 编辑模板中随意还可用额度输入框
			anyReturnUseAmountEl: '.J_anyReturnUseAmount',
			// 该会员的id
			userIdEl: '.J_userId',
			// 搜索按钮
			searchTrigger: '.J_search'
        },
        DATA_AMOUNT_ID = 'data-amount-id',
        ERROR_TIP = ['操作失败：已存在编辑项，请保存后再操作！',
        			 '保存白条可用额度失败：白条可用额度一栏为空!', 
        			 '保存随意还可用额度失败：随意还可用额度一栏为空!',
        			 '白条可用额度超出白条信用额度，请重新输入',
        			 '随意还可用额度超出随意还信用额度，请重新输入'
        			 ],
        CONFIRM_TIP = ['确定删除吗？'],
        SUCCESS_TIP = ['添加成功!','修改成功！','删除成功！'];
        
	function Core(param){
		this.opts = S.merge(config, param);
		this.pagination;
		this.defender;
		this.whiteBarAmount;
		this.anyReturnAmount;
		this.userId;
		this._init();
	}

	S.augment(Core, {
		_init: function(){
			this._initPagination();
			this._buildEvt();
			this._validHandler();
			this._validForm();
		},
		_buildEvt: function(){
			var
				that = this;
			// 搜索
			on(el.searchForm, 'submit', function(){
				that._search();
				return false;
			});
			// 编辑会员额度
			delegate(el.dataTemp, 'click', el.editTrigger, function(e){
				if(!that._isEdit()){
					that._edit(e.target);
				}
			});
			// 保存会员额度
			delegate(el.dataTemp, 'click', el.saveTrigger, function(e){
				that._save(e.target);
			});
			// 取消会员额度
			delegate(el.dataTemp, 'click', el.cancelTrigger, function(e){
				that._cancel(e.target);
			});
		},
		/**
		 * 验证搜索
		 * @return {[type]} [description]
		 */
		_validForm:function(){
			Defender(el.searchForm ,{});
		},
		/**
		 * 初始化分页
		 * @return {[type]} [description]
		 */
		_initPagination: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);

			that.pagination = Pagination(S.mix(that.opts, {extraParam: data}));
		},
		/**
		 * 发送搜索条件的参数
		 * @return {[type]} [description]
		 */
		_search: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);
			S.mix(that.opts, {extraParam: data});
			that.pagination.reload(that.opts);
		},
		/**
		 * 编辑会员额度操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_edit: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
			 	data = {};

			data = that._getAmount(tr);
			that.whiteBarAmount = data.whiteBarLine;
			that.anyReturnAmount = data.anyRepayLine;
			that._renderEditOper(data, tr);
		},
		_validHandler: function(){
			var
				that = this;

			that.defender = Defender(el.operForm,{
                theme:'inline',
                items:[
                	// 白条可用额度验证 
                    {
                        queryName:el.whiteBarUseAmountEl,
                        pattern: function(input,shell,form){
                        	if(this.test('isInteger', DOM.val(input))){
                           		return (parseFloat(DOM.val(input)) <= parseFloat(that.whiteBarAmount));
                        	}else{
                        		return false;
                        	}
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    },
                    // 随意还可用额度验证 
                    {
                        queryName:el.anyReturnUseAmountEl,
                        pattern: function(input,shell,form){
                        	if(this.test('isInteger', DOM.val(input))){
                           		return (parseFloat(DOM.val(input)) <= parseFloat(that.anyReturnAmount));
                        	}else{
                        		return false;
                        	}
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    }
                ] 
            });
		},
		/**
		 * 保存会员额度
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_save: function(e){
			var
				that = this,
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_AMOUNT_ID),
				obj = that._getAmountObj(tr);

			that._isEmpty(tr);
			that.defender.validAll(function(rs){
				if(rs){
					if(that._isOver()){
						that._sendAmount(obj, tr);
					}else{
					}
				}else{
					that._errTip(tr);
				}
			});
		},
		/**
		 * 传向后台的参数
		 * @param  {[type]} tr [description]
		 * @return {[type]}    [description]
		 */
		_getAmountObj: function(tr){
			var
				that = this,
				id = DOM.attr(tr, DATA_AMOUNT_ID),
				whiteBarUseAmountEl = get(el.whiteBarUseAmountEl, tr),
				whiteBarUseAmount = DOM.val(whiteBarUseAmountEl),
				anyReturnUseAmountEl = get(el.anyReturnUseAmountEl, tr),
				anyReturnUseAmount = DOM.val(anyReturnUseAmountEl),
				data = {};

			data = {
				id: id,
				userId: that.userId,
				whiteBarLine: that.whiteBarAmount,
				anyRepayLine: that.anyReturnAmount,
				whiteBar: whiteBarUseAmount,
				anyRepay: anyReturnUseAmount
			};
			return data;
		},
		/**
		 * 超出信用额度错误提示
		 * @param  {[type]} tr [description]
		 * @return {[type]}    [description]
		 */
		_errTip: function(tr){
			var
				that = this,
				whiteBarUseAmountEl = get(el.whiteBarUseAmountEl, tr),
				whiteBarUseAmount = DOM.val(whiteBarUseAmountEl),
				anyReturnUseAmountEl = get(el.anyReturnUseAmountEl, tr),
				anyReturnUseAmount = DOM.val(anyReturnUseAmountEl);
			
			if(parseFloat(whiteBarUseAmount) > parseFloat(that.whiteBarAmount)){
				Dialog.alert(ERROR_TIP[3], function(){
					whiteBarUseAmountEl.focus();
				});
			}else if(parseFloat(anyReturnUseAmount) > parseFloat(that.anyReturnAmount)){
				Dialog.alert(ERROR_TIP[4], function(){
					anyReturnUseAmountEl.focus();
				});
			}
		},
		/**
		 * 发送会员额度
		 * @param  {[type]} data [description]
		 * @param  {[type]} tr   [description]
		 * @return {[type]}      [description]
		 */
		_sendAmount: function(obj, tr){
			var
				that = this;
			AmountIO.save(obj, function(code, data, errMsg){
				if(code){
					S.mix(obj, {lastModifiedTime: data.lastModifiedTime});
					that._renderEditSaveOper(obj, tr);
					Dialog.alert(SUCCESS_TIP[1]);
				}else{
					Dialog.alert(errMsg);
				}
			});
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
				editTemp = DOM.html(el.itemTemp),
				editTempStr = Juicer(editTemp, {amount: data}),
				editEl = DOM.create(editTempStr);

			DOM.insertAfter(editEl, oldtr);
			DOM.hide(oldtr);
			that.defender.refresh();
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
				newTempEl, newTempStr, newEl,prevTr,
				obj = {};

			obj = that._getAmount(tr);
			S.mix(obj, {
				whiteBar: data.whiteBar,
				anyRepay: data.anyRepay,
				lastModifiedTime: data.lastModifiedTime
			});
			newTempEl = DOM.html(el.renderTpl),
			newTempStr = Juicer(newTempEl, {amount: obj}),
			newEl = DOM.create(newTempStr),
			prevTr = DOM.prev(tr);

			DOM.replace(tr, newEl);
			DOM.remove(prevTr);
			that.defender.refresh();
		},
		/**
		 * 获取会员额度对象
		 * @param  {[type]} tr [description]
		 * @return {[type]}    [description]
		 */
		_getAmount: function(tr){
			var
				that = this,
				tds = query('td', tr),
				id = DOM.attr(tr, DATA_AMOUNT_ID),
				amount = [],
				obj = {},
			 	userIdEl = get(el.userIdEl, tr),
			 	userId = DOM.val(userIdEl);

			S.each(tds, function(td){
				amount.push(DOM.text(td));
			});
			that.userId = userId;
			obj = {
				id: id,
				userId: that.userId,
				name: amount[0],
				mobile: amount[1],
				memberType: amount[2],
				whiteBarLine: amount[3],
				whiteBar: amount[4],
				anyRepayLine: amount[5],
				anyRepay: amount[6],
				lastModifiedTime: amount[7]
			};
			return obj;
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
			that.defender.refresh();
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
		},
		/**
		 * 判断白条或随意还的可用额度是否为空
		 * @param  {[type]}  tr [description]
		 * @return {Boolean}    [description]
		 */
		_isEmpty: function(tr){
			var
				that = this,
				whiteBarUseAmountEl = get(el.whiteBarUseAmountEl, tr),
				whiteBarUseAmount = DOM.val(whiteBarUseAmountEl),
				anyReturnUseAmountEl = get(el.anyReturnUseAmountEl, tr),
				anyReturnUseAmount = DOM.val(anyReturnUseAmountEl);
				
			if(!whiteBarUseAmount){
				Dialog.alert(ERROR_TIP[1], function(){
					whiteBarUseAmountEl.focus();
				});
				return false;
			}else if(!anyReturnUseAmount){
				Dialog.alert(ERROR_TIP[2], function(){
					anyReturnUseAmountEl.focus();
				});
				return false;
			}
		},
		/**
		 * 判断输入值是否超过最高额度值
		 * @param  {[type]}  tr [description]
		 * @return {Boolean}    [description]
		 */
		_isOver: function(tr){
			var
				that = this,
				whiteBarUseAmountEl = get(el.whiteBarUseAmountEl, tr),
				whiteBarUseAmount = DOM.val(whiteBarUseAmountEl),
				anyReturnUseAmountEl = get(el.anyReturnUseAmountEl, tr),
				anyReturnUseAmount = DOM.val(anyReturnUseAmountEl);

			if(parseFloat(whiteBarUseAmount) <= parseFloat(that.whiteBarAmount) && parseFloat(anyReturnUseAmount) <= parseFloat(that.anyReturnAmount)){
				return true;
			}else {
				return false;
			}
		}
	});

	return Core;
},{
	requires:[
		'io/amount',
		'widget/dialog',
		'mod/defender',
        'mod/pagination',
        'mod/juicer'
	]
});