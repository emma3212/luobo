/*-----------------------------------------------------------------------------
* @Description:     使用定制的scroll处理
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.26
* ==NOTES:=============================================
* v1.0.0(2014.5.26):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('widget/scroll', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        el = {
            scroll: '.scroll'
        },
        SCROLL_KEY = 'scroll';

    PW.namespace('widget.Scroll');

    PW.widget.Scroll = S.merge(PW.mod.Scroll,{
        refresh: function(){
            var that = this;
            S.each(query(el.scroll), function(s){
                DOM.data(s, SCROLL_KEY, that.client({
                    renderTo: s
                }))
            })

            return that;
        }
        //client 在mod/scroll中实现了
    })

    //初始化
    S.ready(function(){
        PW.widget.Scroll.refresh();
    })
},{
    requires:[
        'mod/scroll'
    ]
})