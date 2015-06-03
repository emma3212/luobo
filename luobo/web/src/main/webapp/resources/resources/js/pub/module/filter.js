/*-----------------------------------------------------------------------------
* @Description: 公共页面_拦截js
* @Version:     V1.0.0
* @author:      cuiy(361151713@qq.com)
* @date         2014.02.04
* ==NOTES:=============================================
* v1.0.0(2014.02.04):
*   初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('module/filter', function (S, Core) {
    PW.namespace('module.Filter');
    PW.module.Filter = function(param){
        new Core(param);
    }
},{
    requires:[
        'filter/core'
    ]
});

KISSY.add('filter/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, delegate = S.Event.delegate,
        $ = S.all, 
        Dialog = PW.widget.Dialog,
        el = {
            // 拦截器
            filerEl: '.J_filter'
        },
        TIP = '您尚未登录，无法进行该操作，请您 <strong><a href="'+ website + 'index">立即登录！</a></strong>';

    function Core(param){
        this.opts = S.merge(config, param);
        this._init();
    }

    S.augment(Core, {
        _init: function(){
            this._buildEvt();
        },
        _buildEvt: function(){
            var
                that = this;
            on(el.filerEl, 'click', function(){
                that._dialogTip();
                return false;
            });
        },
        /**
         * 弹框提示
         * @return {[type]} [description]
         */
        _dialogTip: function(){
            var
                that = this;

            Dialog.alert(TIP, function(){}, {
                footer: {
                    btns:[{
                        text: '去登录',
                        clickHandler: function(e,me){
                            that._goToLogin();
                            me.close();
                        }
                    },{
                        text: '取消',
                        clickHandler: function(e,me){
                            me.close();
                        }
                    }]
                }
            });
        },
        /**
         * 去登录
         * @return {[type]} [description]
         */
        _goToLogin: function(){
            var
                that = this,
                href = website + 'index';

            window.location.href = href;
        }
    });
    return Core;
},{
    requires:[
        'widget/dialog',
        'core'
    ]
});
