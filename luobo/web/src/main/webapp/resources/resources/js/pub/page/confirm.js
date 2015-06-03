/*-----------------------------------------------------------------------------
* @Description: 公共页面——商品订单确认页 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.02.04
* ==NOTES:=============================================
* v1.0.0(2015.02.04):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/confirm', function (S, Core) {
    PW.namespace('page.Confirm');
    PW.page.Confirm = function(param){
        	new Core(param);
    	}
},{
    requires:[
        'confirm/core'
    ]
});
KISSY.add('confirm/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, 
		Dialog = PW.widget.Dialog,
		Defender = PW.mod.Defender.client,
		ViewIO = PW.io.View,
		el = {
			orderForm: '.J_orderForm'
		},
		SUCCESS_TIP = '提交订单成功！'

	var
		Core = function(param){
			this.opts = param;
			this._formValid = Defender(el.orderForm, {})
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			on(el.orderForm, 'submit', that._validForm, that);
		},
		_validForm: function(){
			var
				that = this,
				data = DOM.serialize(el.orderForm),
				gotoTip = '';
			that._formValid.validAll(function(rs){
                if(rs){
                    ViewIO.submitOrder(data, function(code, errMsg){
						if(code == 0){
							Dialog.alert(SUCCESS_TIP, function(){
								window.location.href = that.opts.productOrderUrl;
							});
						}else if(code == 22007){
							gotoTip = errMsg + '<a href="' + website+ 'vip/info">立即完善个人信息，成为我们的正式会员！</a>';
							Dialog.alert(gotoTip);
						}else{
							Dialog.alert(errMsg);
						}
					});
                }
            })
			return false;
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'widget/dialog',
				'mod/defender',
				'io/view'
			]
});