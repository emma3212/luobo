/*-----------------------------------------------------------------------------
* @Description: 公共页面——商品详情 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.02.04
* ==NOTES:=============================================
* v1.0.0(2015.02.04):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/view', function (S, Core) {
    PW.namespace('page.View');
    PW.page.View = function(){
        	new Core();
    	}
},{
    requires:[
        'view/core'
    ]
});
KISSY.add('view/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all, delegate = S.Event.delegate,
		on = S.Event.on, 
		Defender = PW.mod.Defender.client,
		Dialog = PW.widget.Dialog,
		ViewIO = PW.io.View,
		el = {
			orderForm: '.J_orderForm',
			firstPayHolder: '.first-pay',
			//首付
			firstPay: '.J_pay',
			//分期月数holder
			stagingMonthHolder: '.staging-month',
			//分期数
			stagingInp: '.J_staging',
			//分期月数
			stagingMonth: '.J_stagingMonth',
			//商品金额
			productPrice: '.J_productPrice',
			//月供
			monthlyRepay: '.J_monthlyRepay',
			//价格提示
			priceTip: '.J_priceTip',
			//显示分期数
			stagingShow: '.J_stagingShow',
			//错误提示信息
			errorTip: '.J_errMsg',
			hotSaleTitle: '.J_hotSaleTitle'
		},
		SUCCESS_CLASS = "success",
		ERROR_CLASS = 'error',
		SUCCESS_STATUS = 'success-field',
		FOCUS_CLASS = 'focus',
		ERROR_STATUS = 'error-field',
		FOCUS_STATUS = 'focus-field',
		ACTIVE_CLASS = 'active',
		MONTH_ATTR = 'data-month';

	var
		Core = function(param){
			this.opts = param;
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._initDefender();
			this._getRepayHandler();
			this._subString();
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			on(el.firstPay, 'blur', that._blurHandler, that);
			on(el.firstPay, 'valuechange', that._setClassHandler, that);
			on(el.firstPay, 'focus', that._setClassHandler, that);

			on(el.stagingMonth, 'click', that._stagingHandler, that);
			on(el.orderForm, 'submit', that._validForm, that);
		},
		_initDefender: function(){
			var
				that = this;
            that._formValid = Defender(el.orderForm,{
                theme:'inline',
                items:[
                    //验证码验证
                    {
                       	queryName: el.firstPay,
                        pattern: function(input,shell,form){
                            var
                                firstPay = DOM.val(input),
                                productPrice = DOM.html(el.productPrice).split('￥')[1];

                            return (this.test('isFloat', firstPay) && firstPay >= 0 && firstPay <= parseInt(productPrice));
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    }
                ] 
            });
		},
		_subString: function(){
			var
				length = $(el.hotSaleTitle).length,
				hotSaleTitle = query(el.hotSaleTitle),
				hotSaleTitleSubStr;
			S.each(hotSaleTitle, function(i){
				var
					title = DOM.text(i);
				if(title.length > 40){
					titleStr = title.substring(0,40);
					DOM.text(i, titleStr + '...');
				}
			});
		},
		_blurHandler: function(e){
			var
				that = this,
				target = e.target,
				holder = DOM.parent(target, el.firstPayHolder);
			that._setClassHandler();
			that._getRepayHandler();
		},
		_validForm: function(){
			var
				that = this;
			that._formValid.validAll(function(rs){
				if(rs){
					DOM.get(el.orderForm).submit();
				}else{
					DOM.show(el.errorTip);
				}
			});
			return false;
		},
		_setClassHandler: function(){
			var
				that = this,
				target = get(el.firstPay),
				holder = DOM.parent(el.firstPay, el.firstPayHolder);
			if(DOM.hasClass(target, SUCCESS_STATUS)){
				that._resetAllClass(target);
				DOM.addClass(holder, SUCCESS_CLASS);
			}else if(DOM.hasClass(target, ERROR_STATUS)){
				that._resetAllClass(target);
				DOM.addClass(holder, ERROR_CLASS);
				DOM.show(el.errorTip);
			}else if(DOM.hasClass(target, FOCUS_STATUS)){
				that._resetAllClass(target);
				DOM.addClass(holder, FOCUS_CLASS);
			}
		},
		_stagingHandler: function(e){
			var
				that = this,
				target = e.target,
				as = DOM.siblings(target);
			if(!DOM.hasClass(target, ACTIVE_CLASS)){
				DOM.removeClass(as, ACTIVE_CLASS);
				DOM.addClass(target, ACTIVE_CLASS);
			}
			that._getRepayHandler();
		},
		/**
		 * 获取还款数据
		 * @return {[type]} [description]
		 */
		_getRepayHandler: function(){
			var
				that = this,
				productPrice = DOM.html(el.productPrice).split('￥')[1],
				stagingMonth = $('.active', el.stagingMonthHolder).attr(MONTH_ATTR),
				firstPay = DOM.val(el.firstPay),
				sendData = {
					productPrice: productPrice,
					firstPay: firstPay,
					payPeriods: stagingMonth
				};
			DOM.val(el.stagingInp, stagingMonth);
			if(!(that._formValid.test('isFloat', firstPay) && firstPay > 0 && firstPay <= parseInt(productPrice))){
				sendData.firstPay = 0;
			}
			ViewIO.getPerMonth(sendData, function(code, data, error){
				if(code){
					S.mix(data, {payPeriods: sendData.payPeriods});
					that._renderRePay(data);
				}else{
					Dialog.alert(error);
				}
			});
		},
		/**
		 * 渲染月供信息
		 * @param  {[type]} data [description]
		 * @return {[type]}      [description]
		 */
		_renderRePay: function(data){
			var
				showTipStr = '（本金:￥' + data.principal + '服务费:￥' + data.serviceCharge + '）X ';
			DOM.html(el.monthlyRepay, data.monthlyRepay);
			DOM.html(el.priceTip, showTipStr);
			DOM.html(el.stagingShow, data.payPeriods);
		},
		/**
		 * 重置样式
		 * @param  {[type]} target [description]
		 * @return {[type]}        [description]
		 */
		_resetAllClass: function(target){
			var holder = DOM.parent(target, el.firstPayHolder);
			DOM.removeClass(target, FOCUS_STATUS);
			DOM.removeClass(target, ERROR_STATUS);
			DOM.removeClass(target, SUCCESS_STATUS);

			DOM.removeClass(holder, SUCCESS_CLASS);
			DOM.removeClass(holder, ERROR_CLASS);
			DOM.removeClass(holder, FOCUS_CLASS);

			DOM.hide(el.errorTip);
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/defender',
				'widget/dialog',
				'io/view'
			]
});