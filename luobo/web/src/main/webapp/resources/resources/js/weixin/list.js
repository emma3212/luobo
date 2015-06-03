/*-----------------------------------------------------------------------------
* @Description:     微信分页js
* @Version:         1.0.0
* @author:          wangjing(1284663246@qq.com)
* @date             2014.11.11
* ==NOTES:=============================================
* v1.0.0(2014.11.11):
     初始生成
* -----------------------------------------------------------------------------*/
(function($){
    var 
        config = {
            //获取分页url
            getListUrl: null,
            //跳转详情url
            detailUrl: null
        },
        el = {
            //向上拉的div的id
            pullUpDOM: '.pullUp',
            pullDownDOM: '.pullDown',
            //翻页的图标
            pullUpIcon:'.pullUpIcon',
            //翻页信息框
            pullUpLabel:'.pullUpLabel',
            //分页渲染节点
            listRender: '.J_listRender',
            //页码
            pageNo: '.J_pageNo',
            container: '.page',
            wrapperContainer: '#wrapper'
        },
        WAPPERHOLDER = 'wrapper',
        SCROLLBARCLASS = 'myScrollbar',
        pageNo = 1,
        opts,
        _containerScroll,
        pullDownOffset;

    function init(param){
        opts = $.extend(config, param);
        _initPage();
        _loadScrollbar();
        _getInfoList(pageNo);
        $(window).on('resize',_resize);
    }
    /**
     * 初始化内容高度
     * @return {[type]} [description]
     */
    _initPage = function(){
        var 
            documentHeight = window.innerHeight,
            
            titleHeight = $('.lighter-black').height(),
            titlePaddingTop = $('.lighter-black').css('padding-top').replace('px',''),
            titlePaddingBottom = $('.lighter-black').css('padding-bottom').replace('px',''),
            logoHeight = $('.logo').height(),
            logoPaddingTop = $('.logo').css('padding-top').replace('px',''),
            logoPaddingBottom = $('.logo').css('padding-bottom').replace('px',''),
            containerPaddingTop = $(el.container).css('margin-top').replace('px',''),
            containerPaddingBottom = $(el.container).css('margin-bottom').replace('px',''),
            containerheight = documentHeight - containerPaddingTop - containerPaddingBottom - logoHeight - logoPaddingTop - logoPaddingBottom-titleHeight- titlePaddingBottom - titlePaddingTop; 
        $(el.wrapperContainer).css('height', containerheight);
    }
    /**
     * 重置屏幕大小
     * @return {[type]} [description]
     */
    _resize = function(){
        _initPage();
        _refreshScroll();
    }

    /**
     * 页面加载滚动条设置
     * @return {[type]} [description]
     */
    _loadScrollbar = function(){
        var 
            that = this,
            pullDownHeight = $('.pullDown').height(),
            pullDownMarginTop = parseInt($('.pullDown').css('margin-top').replace('px', '')),
            pullDownPaddingTop = parseInt($('.pullDown').css('padding-top').replace('px','')),
            pullDownPaddingBottom = parseInt($('.pullDown').css('padding-bottom').replace('px','')),
            pullDownOffset = pullDownHeight + pullDownMarginTop + pullDownPaddingTop + pullDownPaddingBottom,
            setting = {
                useTransition: true,
                topOffset: pullDownOffset,
                scrollbarClass: SCROLLBARCLASS,
                onRefresh: function(){
                    that._onRefresh();
                },
                onScrollMove:function(){
                    var me = this;
                    that._onScrollMove(me);
                },
                onScrollEnd:function(){
                    that._onScrollEnd();
                }
            };
        _containerScroll = new iScroll(WAPPERHOLDER, setting);
    }
    /**
     *  滚动条刷新
     */
    _onRefresh = function(){
        var 
            that = this;
        if($(el.pullUpDOM).hasClass('loading')){
            $(el.pullUpDOM).removeClass('loading');
            $(el.pullUpLabel).text('上拉获取更多内容...');
        }
    }
    _onScrollMove = function(me){
        var 
            pullUpOffset = $(el.pullUpDOM).offset(),
            pullDownOffset = $(el.pullDownDOM).offset();
        if (me.y > 5 && !($(el.pullDownDOM).hasClass('flip'))) {
            $(el.pullDownDOM).addClass('flip');
            $(el.pullDownLabel).text('正在刷新内容...');
            this.minScrollY = 0;
        }else if (me.y < 5 && $(el.pullDownDOM).hasClass('flip')) {
            $(el.pullDownDOM).removeClass('flip');
            $(el.pullDownLabel).text('下拉刷新内容...');
            this.minScrollY = -pullDownOffset;
        }else if(me.y < 0 && me.y < (me.maxScrollY - 5) && !($(el.pullUpDOM).hasClass('flip'))) {
            $(el.pullUpDOM).addClass('flip');
            $(el.pullUpLabel).text('正在获取更多内容...');
        me.maxScrollY = me.maxScrollY;
        }else if(me.y > (me.maxScrollY + 5) && $(el.pullUpDOM).hasClass('flip')) {
            $(el.pullUpDOM).removeClass('flip');
            $(el.pullUpLabel).text('上拉获取更多内容...');
            me.maxScrollY = pullUpOffset;
        }
    }
    _onScrollEnd = function(evt){
        var 
            that = this;
        if($(el.pullUpDOM).hasClass('flip')){
            console.log(222)
            pageNo ++;
            $(el.pullUpDOM).removeClass('flip').addClass('loading');
            $(el.pullUpLabel).text('正在加载列表,请稍后...');
            _getInfoList(pageNo);      
        }
        if($(el.pullDownDOM).hasClass('flip')){
            console.log(111)
            $(el.pullDownDOM).removeClass('flip').addClass('loading');
            $(el.pullDownLabel).text('正在刷新,请稍后...');

           window.location.reload();
        }
    }
    /**
     * 获取更多列表信息
     * @return {[type]} [description]
     */
    _getInfoList = function(pageNo){
        var
            that = this,
            dishStr = '',
            dishEl;
        $.ajax({
            url: opts.getListUrl,
            type: "get",
            dataType: "json",
            data: {curPage: pageNo},
            success: function(rs){
                that._renderHtml(rs);
                that._refreshScroll();
            },
            error: function(msg){
                console.log( "Data Saved: " + msg );
            }
        });
    }
    _renderHtml = function(data){
        var
            dishStr = '',
            hasNextPage = data.hasNextPage;
        $.each(data.list, function(index, item){
            dishStr += '<li><a href="' + opts.detailUrl + '/' + item.id 
                        + '" class="a-in-list ui-link">' + item.id
 
                        + '</a><span>' + item.productName 
                        + '</span><span>'+item.status
                        + '</span></li>';
        })
        $(el.listRender).append(dishStr);
        if(hasNextPage == 0){
            $(el.pullUpDOM).remove();
        }
    }
    /**
     * 刷新滚动条
     */
    _refreshScroll = function(){
        var
            that = this;
        _containerScroll.refresh(); 
    }
    $.list = {
        init: init
    };
})(jQuery)