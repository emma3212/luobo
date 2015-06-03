/*-----------------------------------------------------------------------------
* @Description:     智能按钮，针对按钮处理一些特殊情况
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.22
* ==NOTES:=============================================
* v1.0.0(2014.5.22):
     初始生成
* ---------------------------------------------------------------------------*/


KISSY.add('widget/btn', function(S, Btn){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        BTN_TYPE_ATTR = 'data-btn-type',
        el = {
            smartBtn: '.btn[' + BTN_TYPE_ATTR + ']'
        },
        BTN_KEY = 'btn';

    PW.namespace('widget.Btn');
    PW.widget.Btn = {
        refresh: function(){
            var
                that = this;
            S.each(query(el.smartBtn), function(b){
                DOM.data(b, BTN_KEY, that.client(b))    
            })
            return that;
        },
        client: function(selector){
            return new Btn(selector);
        }
    }

    S.ready(function(){
        PW.widget.Btn.refresh();
    });

},{
    requires:[
        'btn/core'
    ]
})

KISSY.add('btn/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on, delegate = S.Event.delegate,
        LOADING_CLASS = 'btn-loading',
        DISABLED_CLASS = 'btn-disabled',
        DEFAULT_LOADING_TEXT = '正在进行...',
        BTN_TYPE_ATTR = 'data-btn-type',
        BTN_LOADING_ATTR = 'data-loading-text',
        el = {
        };


    function Btn(selector){
        this.btnEl = get(selector);
        this.formEl;
        this.orginalText;
        this.btnType;
        this.loadingTimer;
        this._init();
    }

    S.augment(Btn, S.EventTarget, {
        _init: function(){
            var
                that = this,
                btn = that.btnEl;
            that.orginalText = DOM.text(btn);
            that.formEl = DOM.parent(btn, 'form');
            that.btnType = DOM.attr(btn, BTN_TYPE_ATTR);
            that._buildEvt();
        },
        _buildEvt: function(){
            var
                that = this;
            on(that.btnEl, 'click', that._clickHanlder, that);
            on(that.formEl, 'submit', that._formSubmitHandler, that)
        },
        _clickHanlder: function(ev){
            var
                that = this,
                btn = ev.target;
            if(that.btnType == 'loading'){
                that._loading();
                return false;
            }
        },
        _formSubmitHandler: function(){
            var
                that = this,
                btn = that.btnEl;
            if(that.btnType === 'loading' && btn.type === 'submit'){
                return false;
            }
        },
        //更新文本
        text: function(text){
            var
                that = this;
            if(!S.isString(text)) return;
            DOM.html(that.btnEl, text);
        },
        //可用
        lock: function(){
            var
                that = this;
            that.btnEl.disabled = true;
            DOM.addClass(that.btnEl, DISABLED_CLASS);
        },
        //不可用
        unlock: function(){
            var
                that = this;
            that.btnEl.disabled = false;
            DOM.removeClass(that.btnEl, DISABLED_CLASS);
        },
        reset: function(){
            var
                that = this;
            that.text(that.orginalText);
            that.unlock();
            if(that.loadingTimer){
                that._unloading(); 
            }
        },
        /**
         * 设置loading状态
         */
        _loading: function(ldText){
            var
                that = this,
                btnEl = that.btnEl,
                txt = ldText || DOM.attr(that.btnEl, BTN_LOADING_ATTR) || '';
            that.loadingTimer = S.timer(function(index){
                var 
                    t = txt;
                if(index >= 2) {
                    that.loadingTimer = this.restart();
                }
                if(index == 0) t = txt + '.&nbsp;&nbsp;'; 
                if(index == 1) t = txt + '..&nbsp;'; 
                if(index == 2) t = txt + '...'; 
                that.text(t);
            }, .5, 0);

            that.lock(); 
            DOM.addClass(that.btnEl, LOADING_CLASS);
            that.fire('loading',{
                timer: that.loadingTimer,
                loadingText: txt
            })
        },
        _unloading: function(){
            var
                that = this;
            if(that.loadingTimer){
                S.clearTimer(that.loadingTimer);    
                that.loadingTimer = null;
            }
            DOM.removeClass(that.btnEl, LOADING_CLASS);
            that.fire('unloading', {});
        }
    });

    return Btn;
},{
    requires:[
        'core',
        'mod/ext'
    ]
})