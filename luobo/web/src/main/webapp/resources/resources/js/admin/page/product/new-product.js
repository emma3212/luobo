/*-----------------------------------------------------------------------------
* @Description: 品牌类型管理列表 
* @Version: 	V1.0.0
* @author: 		kt
* @date			2015.01.13
* ==NOTES:=============================================
* v1.0.0(2015.01.13):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/product/new-product', function (S, Core) {
    PW.namespace('page.product.NewProduct');
    PW.page.product.NewProduct = function(){
        new Core();
    }
},{
    requires:[
        'product/core'
    ]
});
KISSY.add('product/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, 
		on = S.Event.on, delegate = S.Event.delegate,
		$ = S.all, Dialog = PW.widget.Dialog,empty = DOM.empty,
		productIO = PW.io.Product,
		el = {
			addForm:'.J_addForm',
			showErrInp:'.J_showErrInp',
			//当前error-state的span
			errorSpan:'span[class~=error-state]',
			//当前active的li
			activeLi:'li[class~=active]',
			//当前active的div
			activeDiv:'div[class~=active]',
			reset:'.J_reset'
		}
		STOP_TIP = '保存失败：选择已停用项！';
	var
		Core = function(){
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._showErr();
			this._buildEvt();
			this._saveForm();
		},

		/**
         * 初始时错误或信息提示,并定位光标
         * @return {[type]} [description]
         */
		_showErr:function(){
			var 
				that = this,
				showMsg = DOM.val(el.showErrInp);
			if(showMsg){
				Dialog.alert(showMsg,null);
			}
		},
		_buildEvt:function(){
			var that = this;
			on(el.parentType, 'change', that._initLinkage, that);
			on(el.productPicInp, 'blur', that._showPic, that);
			on(el.reset, 'click', function(){
                CKEDITOR.instances.editor1.setData('');//蓝色为控件名称
            });
		},
		/**
         * 保存表单
         * @return {[type]} [description]
         */
		_saveForm:function(){
			var 
				that = this,
				form = get(el.addForm),
				defenderObj = PW.mod.Defender.client(form ,{}),
				btn = $('.btn').data('btn');
				btn.on('loading', function(ev){

                defenderObj.validAll(function(rs){
                    	form.submit();
                    	btn.reset();
                })
            });
		}
	});
	return Core;
},{
	requires:[
				'core',
				'widget/btn',
				'mod/defender',
				'widget/dialog',
				'io/product'
			]
})