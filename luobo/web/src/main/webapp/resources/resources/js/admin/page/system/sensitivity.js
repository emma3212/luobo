/*-----------------------------------------------------------------------------
* @Description:     敏感密码控制
* @Version:         1.0.0
* @author:          wangjing(1284663246@qq.com)
* @date             2015.01.20
* ==NOTES:=============================================
* v1.0.0(2015.01.20):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/system/sensitivity', function(S, Core){
	PW.namespace('page.system.Sensitivity');
	PW.page.system.Sensitivity = function(param){
        return new Core(param);
    }
},{
	requires:[
		'sensitivity/core'
	]
});

KISSY.add('sensitivity/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, $ = S.all, delegate = S.Event.delegate,
        Defender = PW.mod.Defender.client,
        Dialog = PW.widget.Dialog,
        config = {
            
        },
        el = {
            //操作表单
            operForm: '.J_operForm',
            // 保存按钮
            saveBtn: '.J_save',
            errMsg: '.J_errMsg'
        },
        // 智能按钮
        BTN = 'btn';

	function Core(param){
		this.opts = S.merge(config, param);
		this.defender = Defender(el.operForm, {});
		this._init();
	}

	S.augment(Core, {
		_init: function(){
			this._initErrInfo();
			this._save();
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
		/**
		 * 保存敏感操作密码
		 * @return {[type]} [description]
		 */
		_save: function(){
			var
				that = this,
				defender = that.defender,
				form = get(el.operForm),
				btn = $(el.saveBtn).data(BTN);

			btn.on('loading', function(e){
				defender.validAll(function(rs){
					if(rs){
						form.submit();
					}else{
						btn.reset();
					}
				});
			});
		}
	});

	return Core;
},{
	requires:[
		'mod/defender',
		'widget/btn',
        'mod/ext',
        'widget/dialog'
	]
});