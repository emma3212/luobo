/*-----------------------------------------------------------------------------
* @Description: 白条订单管理列表 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.01.22
* ==NOTES:=============================================
* v1.0.0(2015.01.22):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/order/white-order', function (S, Core, Audit) {
    PW.namespace('page.order.whitebar');
    PW.page.order.whitebar = {
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
		WhitebarIO = PW.io.Whitebar,
		el = {
			//form
			searchForm: '.J_searchForm',
			//搜索关键字条件
			searchKey: '.J_searchKey',
			//table的tbody
			template:'#J_template',
			//导出excel触发器
			excelTrigger: '.J_excel',
			//备注触发器
			tipTrigger: '.J_tip',
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
			});
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
			});
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
				WhitebarIO.cancelTip({id:id, adminComment:newContent},function(code, errMsg){
                    if(code){
                        DOM.val(tipHolderEl, newContent);
                        DOM.removeClass(target, NONE_CONTENT_CLASS);
                        Dialog.alert(SUCCESS_TIP[0]);
                    }else{
                        Dialog.alert(errMsg);
                    }
                });
			}else{
				WhitebarIO.auditTip({id:id, adminComment:newContent},function(code, errMsg){
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
				'io/whitebar',
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
		WhitebarIO = PW.io.Whitebar,
		el = {
			//table的tbody
			template:'#J_template',
			//状态模板
			statusTpl: '#statusTpl',
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
			//分期
			staging: '.J_staging',
			//弹出层分期
			dlgStaging: '.J_dlgStages',
			//弹出层总金额
			dlgAmount: '.J_dlgAmount',
			//订单详情
			dlgOrderHolder: '.J_orderHolder',
			//每月还款金额
			dlgMonthPriceEl: '.J_monthPrice'
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
		DATA_ID = 'data-order-id';
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
			//重置每月还款金额
			delegate(document, 'change', el.dlgStaging, that._resetMonthPrice, that);
			delegate(document, 'blur', el.dlgAmount, that._resetMonthPrice, that);
		},
		/**
		 * 打开修改状态弹出框
		 * @return {[type]} [description]
		 */
		_openStatusDlg: function(e){
			var
				that = this,
				target = e.target,
				renderData = that._getStatusData(target),//TODO: 获取列表返回数据
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
                	that._resetMonthPrice();
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
				data = DOM.serialize(el.statusForm);
				
			switch (that.stagingFlag){
				case 0: 
					that._saveOtherStatus(data, target);
					break;
				case 1:
					that._saveStartReturnStatus(data, target);
			}
			
		},
		/**
		 * 保存其他状态信息
		 * 不包含还款中状态的保存信息
		 * @param  {[type]} data      [description]
		 * @param  {[type]} statusObj [description]
		 * @return {[type]}           [description]
		 */
		_saveOtherStatus: function(data, statusObj){
			var
				statusHtml = this._getSelectHtml();
			delete data.payPeriods;
			delete data.amount;
			delete data.monthRepay;
			WhitebarIO.saveStatus(data, function(code, errMsg){
				if(code){
					DOM.text(statusObj, statusHtml);
					DOM.attr(statusObj, DATA_STATUS, data.status);
					if(data.status == 4) DOM.replaceClass(statusObj, 'J_status', 'J_cancel');
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 保存开始还款状态信息
		 * @param  {[type]} data      [description]
		 * @param  {[type]} statusObj [description]
		 * @return {[type]}           [description]
		 */
		_saveStartReturnStatus: function(data, statusObj){
			var
				that = this,
				statusHtml = that._getSelectHtml();
			WhitebarIO.saveStartReturnStatus(data, function(code, errMsg){
				if(code){
					DOM.text(statusObj, statusHtml);
					DOM.attr(statusObj, DATA_STATUS, data.status);
					that._resetOrderInfo(data, statusObj);
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 重置每月还款金额
		 * @return {[type]} [description]
		 */
		_resetMonthPrice: function(){
			var
				that = this,
				amount = DOM.val(el.dlgAmount),
				payPeriods = DOM.val(el.dlgStaging);
			WhitebarIO.getPerPrice({amount: amount, payPeriods: payPeriods}, function(code, data, errMsg){
				if(code){
					DOM.html(el.dlgMonthPriceEl, data.planRepayMoney);
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
				this.stagingFlag = 0;
				this._orderDisabled();
				DOM.removeAttr(el.sensitiveVal, 'disabled');
			//原状态为‘新建订单’，并更改为'还款中订单'
			}else if(preStatus == 1 && status == 2){
				this.stagingFlag = 1;
				DOM.show(el.dlgOrderHolder);
				this._orderAbled();
			}else{
				this.stagingFlag = 0;
				DOM.hide(el.dlgOrderHolder);
				this._orderDisabled();
				DOM.attr(el.sensitiveVal, 'disabled', 'disabled');
			}
			this.statusForm.refresh();
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
			return {id: id, amount: amount, payPeriods: payPeriods};
		},
		/**
		 * 重置订单信息
		 * @param  {[type]} data [description]
		 * @return {[type]}      [description]
		 */
		_resetOrderInfo: function(data, statusObj){
			var
				tr = DOM.parent(statusObj, 'tr'),
				priceEl = get(el.price, tr),
				stagingEl = get(el.staging, tr);
			DOM.html(priceEl, data.amount);
			DOM.html(stagingEl, data.payPeriods);
		},
		/**
		 * 启用输入域
		 * @return {[type]} [description]
		 */
		_orderAbled: function(){
			$('input', el.dlgOrderHolder).removeAttr('disabled', 'disabled');
			$('select', el.dlgOrderHolder).removeAttr('disabled', 'disabled');
		},
		/**
		 * 禁用输入域
		 * @return {[type]} [description]
		 */
		_orderDisabled: function(){
			$('input', el.dlgOrderHolder).attr('disabled', 'disabled');
			$('select', el.dlgOrderHolder).attr('disabled', 'disabled');
		}
	});
	return Audit;
},{
	requires:[
		'core',
		'mod/juicer',
		'mod/defender',
		'widget/dialog',
		'io/whitebar'
	]
});