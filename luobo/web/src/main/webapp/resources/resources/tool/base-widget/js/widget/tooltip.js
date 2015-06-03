/*-----------------------------------------------------------------------------
* @Description:     下拉框
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.27
* ==NOTES:=============================================
* v1.0.0(2014.5.27):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('widget/tooltip', function(S, Tooltip){
    PW.namespace('widget.Tooltip');
    PW.widget.Tooltip = {
        client: function(param){
            return new Tooltip(param);
        }
    }
},{
    requires:[
        'tt/core'
    ]
})



KISSY.add('tt/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on,
        BOX_INDEX_ATTR = 'data-downbox-id',
        BOX_OFFSET_ATTR = 'data-downbox-offset',
        el = {

        },
        config = {
            renderTo: '#J_tooltip',
            boxTo: '#down1',
            wait: .1,
            arrow: false,
            theme: 'grey',
            showEvt: 'mouseover',
            hideEvt: 'mouseout'
        };


    function Tooltip(param){
        this.opts = S.merge(config, param);
        this.triggerEl = get(this.opts.renderTo);
        this.boxEl;
        this.toolTip;
        this._init();
    }

    S.augment(Tooltip, S.FSM, S.EventTarget, {
        _init: function(){
            var
                that = this;
            that.boxEl = that._getDownBox();
            if(!that.boxEl) return;
            that._buildTooltip();
        },
        _buildTooltip: function(){
            var
                that = this,
                opts = that.opts;

            that.toolTip = PW.mod.Tooltip.client({
                renderTo: that.triggerEl,
                content:{ //maybe a HTMLElement
                    text: that.boxEl, //text in the tip
                },
                position: { 
                    page: 'fixed',
                    my: 'tc',
                    at: 'bc', //options: tl,tc,tr, rt,rc,rb, bl,bc,br,lt,lc,lb 
                    adjust: {
                        x: 0,
                        y: opts.arrow ? 0 : -8,
                        resize: false,  //reposition the tip by the window size automatically
                        mouse: false    // reposition the tip by Mouse position automatically
                    }
                },
                styles:{
                    theme: opts.theme, //default style
                    arrow: opts.arrow
                },
                show: {
                    event: opts.showEvt,
                    //显示等待时间
                    delay: opts.wait,
                },
                hide: {
                    event: opts.hideEvt,
                    delay: .1,  //关闭等待时间
                }
            })
        },
        _getDownBox: function(){
            var
                that = this,
                opts = that.opts,
                triggerEl = that.triggerEl,
                downBoxId = DOM.attr(triggerEl, BOX_INDEX_ATTR);
            if(!that.triggerEl) return null;
            return get(opts.boxTo) || get('#' + downBoxId);
        }
    })

    return Tooltip;

},{
    requires:[
        'mod/tooltip'
    ]
})