/*-----------------------------------------------------------------------------
* @Description:     敏感密码控制
* @Version:         1.0.0
* @author:          kt
* @date             2015.01.20
* ==NOTES:=============================================
* v1.0.0(2015.01.20):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/system/interest-rate', function(S, Core){
	PW.namespace('page.system.InterestRate');
	PW.page.system.InterestRate = function(){
        return new Core();
    }
},{
	requires:[
		'interestRate/core'
	]
});

KISSY.add('interestRate/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, $ = S.all, 
        Defender = PW.mod.Defender.client,
        Dialog = PW.widget.Dialog,
        SystemIO = PW.io.System,
        el = {
            //操作表单
            operForm: '.J_form',
            //后台返回的错误信息
            errMsg: '.J_errMsg',
            //刷新缓存
            refresh: '.J_refresh'
        },
        SUCCESS_TIP = ['刷新成功！'];
	function Core(){
		this.defender = Defender(el.operForm, {});
		this._init();
	}

	S.augment(Core, {
		_init: function(){
			this._initErrInfo();
			this._addEvent();
			this._saveForm();
		},
		/**
		 * 提示错误信息
		 * @return {[type]} [description]
		 */
		_initErrInfo: function(){
			var
				that = this,
				errMsg = DOM.val(el.errMsg);
			if(errMsg != ''){
				Dialog.alert(errMsg);
			}
		},
		_addEvent: function(){
			var
				that = this;
			on(el.refresh, 'click', that._refreshCache, that);
		},
		/**
		 * 刷新缓存
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_refreshCache: function(e){
			SystemIO.refresh(function(code, errMsg){
				if(code){
					Dialog.alert(SUCCESS_TIP[0]);
				}else{
					Dialog.alert(errMsg);
				}
			});
		},
		/**
		 * 保存利率
		 * @return {[type]} [description]
		 */
		_saveForm: function(){
			var
				that = this,
				form = get(el.operForm),
				btn = $('.btn').data('btn');
			btn.on('loading', function(evt){
                that.defender.validAll(function(rs){
                    if(rs){
                        form.submit();
                    }else{
                    	btn.reset();
                    }
                })
        	});
		}
	});
	return Core;
},{
	requires:[
		'mod/defender',
		'widget/btn',
        'mod/ext',
        'widget/dialog',
        'io/system'
	]
});