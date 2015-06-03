KISSY.add('module/sidebar', function(S, SideBar){
    PW.namespace('module.SideBar');
    PW.module.SideBar = function(){
        return new SideBar();
    }
},{
    requires:[
        'sidebar/core'
    ]
})

KISSY.add('sidebar/core',function(S, Juicer){
    var
        DOM = S.DOM, query = DOM.query, IO = S.IO, JSON = S.JSON,
        on = S.Event.on, $ = S.all,
        el = {
            sidebarHolder: '.sidebar',
            containerHolder: '.holder',
            //折叠开关
            toggler: '.sidebar-toggler',
            //一级菜单
            layer_1_menu: '.page-sidebar-menu',
            //二级菜单
            layer_2_menu: '.second-layer-menu',
            //三级菜单
            layer_3_menu: '.third_layer_menu',
            //四级菜单
            layer_4_menu: '.forth_layer_menu',
            //菜单列表
            menu_list: '.page-sidebar-menu > li',
            //搜索
            sidebarsearch:'.sidebar-search'
        },
        LAYER = 'data-layer',
        CLOSE_CLASS = 'closed',
        OPEN_CLASS = 'fa-angle-down',
        FOCUS_CLASS = 'opened',
        ACTIVE_CLASS = 'active';

    function SideBar(){
        this._init();
    }


    S.augment(SideBar, {
        _init: function(){
            this._hasActive();
            this._addEventListener();
        },
        /**
         * 判断当前的菜单是否有active样式，有则打开相应菜单级
         * @return {[type]} [description]
         */
        _hasActive: function(){
            var
                that = this,
                sbHolder = $(el.sidebarHolder),
                $active = sbHolder.one('.active');
            if($active) that._defaultOpen();
        },
        /**
         * 打开默认菜单
         * @return {[type]} [description]
         */
        _defaultOpen: function(){
            var
                that = this,
                sbHolder = $(el.sidebarHolder),
                $active = sbHolder.one('.active'),
                currentLayer = parseInt($active.parent().attr(LAYER)),
                args = [];

            S.log('当前页面所对应的菜单有' + currentLayer + '层');
            that._openLayers(currentLayer);
        },
        /**
         * 打开或者关闭对应层级菜单
         * @param  {[number]} currentLayer [需要操作的层级]
         * @return {[type]}                [description]
         */
        _openLayers: function(currentLayer){
            var
                that = this,
                sbHolder = $(el.sidebarHolder),
                $active = sbHolder.one('.active'),
                $dom = $active.parent(),
                $childDom = $active.one('ul');

            that._open($dom);
            //打开下一层节点
            if($childDom){
                that._open($childDom);
            }
            for(var i = 0; i < currentLayer - 2; i++){
                $dom = $dom.parent().parent();
                that._open($dom);
            }

        },
        /**
         * 打开菜单层级
         * @param  {[object]} d [要打开的dom节点]
         * @return {[type]}     [description]
         */
        _open: function(d){
            var icon = d.prev().one('i'),
                menu = d.prev();
            if(icon) icon.addClass(OPEN_CLASS);
            $(menu).addClass(FOCUS_CLASS);
            d.show();
        },
        /**
         * 关闭菜单层级
         * @param  {[object]} d [要关闭的dom节点]
         * @return {[type]}     [description]
         */
        _close: function(d){
            d.prev().one('i').removeClass(OPEN_CLASS);
            d.prev().removeClass(FOCUS_CLASS);
            d.hide();
        },
        _addEventListener: function(){
            var that = this;

            on(el.toggler, 'click', function(){
                that._sidebarToggle();
            });

            on(el.menu_list, 'click', function(evt){
                that._toggle(evt.target);
            });
        },
        /**
         * 折叠或者打开侧边栏
         * @return {[type]} [description]
         */
        _sidebarToggle: function(){
            var
                that     = this,
                $toggler = $(el.toggler),
                isClose  = $toggler.hasClass(CLOSE_CLASS);

            if(isClose) {
                $toggler.removeClass(CLOSE_CLASS);
                that._openSidebar();
            }else{
                $toggler.addClass(CLOSE_CLASS);
                that._closeSidebar();
            }
        },
        /**
         * 打开侧边栏
         * @return {[type]} [description]
         */
        _openSidebar: function(){
            var
                that = this,
                $toggler = $(el.toggler),
                $sbHolder = $(el.sidebarHolder),
                $cHolder = $(el.containerHolder),
                fl = $(el.layer_1_menu);

            $toggler.animate({marginLeft: 175},{duration: 0.1});
            $sbHolder.animate({width: 225},{duration: 0.1});
            $cHolder.animate({marginLeft: 225},{duration: 0.1});
            fl.show();
            $(el.sidebarsearch).show();
        },
        /**
         * 折叠侧边栏
         * @return {[type]} [description]
         */
        _closeSidebar: function(){
            var
                that = this,
                $toggler = $(el.toggler),
                $sbHolder = $(el.sidebarHolder),
                $cHolder = $(el.containerHolder),
                fl = $(el.layer_1_menu);
            $(el.sidebarsearch).hide();
            fl.hide();
            $toggler.animate({marginLeft: 0},{duration: 0.1});
            $sbHolder.animate({width: 29},{duration: 0.1});
            $cHolder.animate({marginLeft: 29},{duration: 0.1});
        },
        /**
         * 判断当前的状态，是要执行打开操作，还是关闭操作
         * @param  {[type]} e [点击的节点]
         * @return {[type]}   [description]
         */
        _toggle: function(e){
            var
                that = this,
                $menu = $(e).next(),
                $siblings = $(e).parent().siblings(), $ul,
                isOpen = ($menu)? ($menu.css('display') == 'block'): null;
           
            if(isOpen !== null){
                if(isOpen){
                    that._close($menu);
                }else{
                    $siblings.each(function(item){
                        $ul = item.one('ul');
                        if($ul){
                            that._close($ul);
                        }
                    });
                    that._open($menu);
                }
            }
        }
    });

    return SideBar;
},{
    requires:[
        'core','sizzle'
    ]
});