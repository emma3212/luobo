/*-----------------------------------------------------------------------------
* @Description:     增加对box的支持
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.21
* ==NOTES:=============================================
* v1.0.0(2014.5.21):
     初始生成
     将所有box的实例隐藏在页面的data数据中
  v1.0.1(2014.6.26):
     by wangjing
     添加data-fold-type属性记录能否闭合下拉内容,该值为disabled时，禁掉闭合功能
  v1.0.2(2014.7.2):
     by wangjing
     修改data-fold属性，当该属性值为unfold时，初始状态为闭合状态
* ---------------------------------------------------------------------------*/

KISSY.add('widget/box', function(S, Box){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        el = {
            box: '.box'
        },
        FOLD_ATTR = 'data-fold',
        //该属性记录是否可以闭合下拉框
        FOLD_TYPE = 'data-fold-type',
        BOX_KEY = 'box';

    PW.namespace('widget.Box');
    PW.widget.Box = {
        foldAll: function(){
            var
                that = this;
            S.each(query(el.box), function(b){
                DOM.data(b, BOX_KEY).fold();
            })
            return this;
        },
        unfoldAll: function(){
            S.each(query(el.box), function(b){
                DOM.data(b, BOX_KEY).unfold();  
            })
            return this;
        },
        refresh: function(){
            var    
                that = this;

            S.each(query(el.box), function(b){
                DOM.data(b, BOX_KEY, that.client(b));
            })

            return this;
        },
        client: function(selector){
            return new Box(selector);
        }
    }


    S.ready(function(){
        PW.widget.Box.refresh();

    })

},{
    requires:[
        'box/core'
    ]
})

KISSY.add('box/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on,
        FOLD_ATTR = 'data-fold',
        //该属性记录是否可以闭合下拉框
        FOLD_TYPE = 'data-fold-type',
        FOLD_CLASS = 'collapse',
        el = {
            foldTrigger: '.collapse',
            unfoldTrigger: '.expand',
            boxTitle: '.box-title',
            boxTool: '.tools',
            boxBody: '.box-container',
            remove: '.remove',
            box: '.box'
        }


    function Box(selector){
        var 
            el;
        //如果找不到节点，则不做任何操作
        if(!(el  = get(selector)) ) return false;
        this.boxEl = el;
        this.boxTitle;
        this.trigger;
        this.boxBody;
        this.isFolded;
        this.canFold;
        this._init(selector);
    }

    S.augment(Box, {
        _init: function(){
            var 
                that = this;
            that.isFolded = (DOM.attr(that.boxEl, 'data-fold') == 'unfold') ? true :  false;
            that.canFold = (DOM.attr(that.boxEl, 'data-fold-type') == 'disabled')? true : false;
            that.boxTitle = get(el.boxTitle, that.boxEl);
            that.trigger = get(el.foldTrigger, that.boxEl) || 
                            get(el.unfoldTrigger, that.boxEl);
            that.boxBody = get(el.boxBody, that.boxEl);
            this._buidlEvt();
            //判断能否闭合
            this._judgeFold();
            //判断初始状态是否闭合
            this._initFold();
        },
        _buidlEvt: function(){
            var 
                that = this,
                box = that.boxEl,
                btl = that.boxTitle,
                trigger = that.trigger;
            on(trigger, 'click', that._clickHandler, that);
            on(btl, 'dblclick', that._clickHandler, that);
            on(el.remove,'click',that._remove,that);

        },
        _clickHandler: function(ev){
            var
                that = this,
                box = that.boxEl;
            if(!that.isFolded){
                that.unfold();
            }else{
                that.fold();
            }
            DOM.toggleClass(that.trigger, "expand collapse");
        },
        fold: function(){
            var
                that = this,
                box = that.boxEl,
                bb = that.boxBody;
            // if(!that.isFolded){
               $(bb).slideToggle(.2, function(){
                    DOM.attr(box, FOLD_ATTR, 'fold');
                    that.isFolded = true;
                },'easeIn');
           // }
        },
        unfold: function(){
            var
                that = this,
                box = that.boxEl,
                bb = that.boxBody;
            // if(that.isFolded){
                $(bb).slideToggle(.2, function(){
                    DOM.attr(box, FOLD_ATTR, 'fold');
                    that.isFolded = false;
                },'easeOut');
            // }
        },
        /**
         * 判断能否闭合该下拉内容
         * by wangjing
         * @return {[type]} [description]
         */
        _judgeFold: function(){
            var
                that = this,
                trigger = that.trigger,
                btl = that.boxTitle;
            if(that.canFold){
                DOM.remove(trigger);
                S.Event.remove(btl, 'dblclick', that._clickHandler, that);
            }
        },
        /**
         * 判断初始是闭合还是打开
         * @return {[type]} [description]
         */
        _initFold: function(){
            var
                that = this,
                box = that.boxEl;
            if(that.isFolded){
                that.fold();
                DOM.toggleClass(that.trigger, "expand collapse");
            }
        },
        /**
         * 关闭box
         * @param  {[type]} e [description]
         * @return {[type]}   [description]
         */
        _remove: function(e){
            var
                that = this,
                e = e.target,
                boxEl = DOM.parent(e,el.box);
            
            DOM.remove(boxEl);
        }
    });

    return Box;
},{
    requires:[
        'core',
        'sizzle'
    ]
})