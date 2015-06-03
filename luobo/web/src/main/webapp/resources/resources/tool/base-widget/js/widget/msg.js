/*-----------------------------------------------------------------------------
* @Description:     点击x关闭警告框js
* @Version:         1.0.0
* @author:          cuiy(361151713@qq.com)
* @date             2014.5.21
* ==NOTES:=============================================
* v1.0.0(2014.5.21):
     初始生成
* ---------------------------------------------------------------------------*/
KISSY.add('widget/msg',function(S, Core){
    PW.namespace('widget.Msg');
    PW.widget.Msg = function(param){
        return new Core(param);
    }
    S.ready(function(param){
        PW.widget.Msg(param);
    })
},{
    requires:[
        'msg/core'
    ]
});

KISSY.add('msg/core',function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on,
        el = {
            //x按钮
            close: '.close',
            //box上的x按钮
            remove: '.remove'
        };

    function Core(param){
        this._init();
    }

    S.augment(Core,{
        _init: function(){
            this._addEvt();
        },
        _addEvt: function(){
            var
                that = this;

            on(el.close,'click',function(e){
                that._close(e.target);
            });
        },
        /**
         * 关闭alert框
         * @param  {[type]} e [description]
         * @return {[type]}   [description]
         */
        _close: function(e){
            var
                that = this,
                msgEl = DOM.parent(e);

            DOM.remove(msgEl);
        }
        
    });

    return Core;
},{
    requires:[
        'core'
    ]
});