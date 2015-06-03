/*-----------------------------------------------------------------------------
* @Description:     为tab新增的js自动控制
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.22
* ==NOTES:=============================================
* v1.0.0(2014.5.22):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('widget/tab', function(S, Tab){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        el = {
            tab: '.tab'
        },
        TAB_KEY = 'tab';

    PW.namespace('widget.Tab');
    PW.widget.Tab = {
        refresh: function(){
            var
                that = this;
            S.each(query(el.tab), function(t){
                DOM.data(t, TAB_KEY, that.client(t));
            })
            return that;
        },
        client: function(selector){
            return new Tab(selector);
        }
    }

    S.ready(function(){
        PW.widget.Tab.refresh();
    });

},{
    requires:[
        'tab/core'
    ]
})

KISSY.add('tab/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on, delegate = S.Event.delegate,
        Dialog = PW.mod.Dialog,
        //淡入动画时间
        SHOW_SPEED = .2,
        TAB_ACTIVE_CLASS = 'active',
        el = {
            tabNav: '.tab-nav',
            tabPanel: '.tab-panel',
            tabContent: '.tab-content'
        };


    function Tab(selector){
        this.tabEl = get(selector);
        this.tabNav;
        this.tabNavList;
        this.tabPanel;
        this.tabPanelList;
        this._init();
    }

    S.augment(Tab, {
        _init: function(){
            var
                that = this,
                tabEl = that.tabEl;
            that.tabNav = get(el.tabNav, tabEl);
            that.tabNavList = query('li', that.tabNav);
            that.tabPanel = get(el.tabPanel, tabEl);
            that.tabPanelList = query(el.tabContent, that.tabPanel);
            that.curTabIndex;
            that._buildEvt();
            that._setDefault();
        },
        _buildEvt: function(){
            var
                that = this;
            delegate(that.tabNav, 'click', 'li', that._tabClickHandler, that);
        },
        _tabClickHandler: function(ev){
            var
                that = this,
                t = ev.target,
                li = DOM.parent(t, 'li') || t,
                i = DOM.index(li);
            //根据序号显示相应内容
            that.showTabContentByIndex(i);
        },
        showTabContentByIndex: function(index, callback){
            var
                that = this,
                tpList = that.tabPanelList,
                tnList = that.tabNavList,
                $nav, $cnt;
            if(index < 0 || index >= tpList.length){
                Dialog.alert('找不到相应内容');
                return false;
            }
            $nav = $(tnList[index]);
            $cnt = $(tpList[index]);

            $cnt.siblings().hide();
            $cnt.fadeIn(SHOW_SPEED, function(){
                $nav.addClass(TAB_ACTIVE_CLASS)
                    .siblings().removeClass(TAB_ACTIVE_CLASS);
                $cnt.addClass(TAB_ACTIVE_CLASS).siblings().removeClass(TAB_ACTIVE_CLASS);     
            });

            // //设置当前tab 索引值
            that.curTabIndex = index;
        },
        _setDefault: function(){
            var
                that = this,
                tn = that.tabNav,
                nav = get('.' + TAB_ACTIVE_CLASS, tn);

            (nav)?
                that.showTabContentByIndex(DOM.index(nav)):
                that.showTabContentByIndex(0);
        }
    });

    return Tab;
},{
    requires:[
        'core',
        'sizzle',
        'mod/ext',
        'mod/dialog'
    ]
})