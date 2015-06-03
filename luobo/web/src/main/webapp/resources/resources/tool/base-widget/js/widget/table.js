/*-----------------------------------------------------------------------------
* @Description:     智能表格(排序功能)自动控制
* @Version:         1.0.0
* @author:          wangjing(1284663246@qq.com)
* @date             2014.09.12
* ==NOTES:=============================================
* v1.0.0(2014.09.12):
     初始生成： 该智能表格含有功能：
                1、可以根据外部配置，动态配置每页显示条数即：pageSize;
                eg: pageSet: {
                    setPageSize: true,
                    pageSizeRender: '.J_pageSize' 
                }
                2、可以根据外部配置，动态获取外部表格，为分页添加，分页条件：extramParam'
                eg: formSet: {
                    hasForm: true,
                    formRender: '.J_searchForm'
                }
* ---------------------------------------------------------------------------*/

KISSY.add('widget/table', function(S, Tabel){

    PW.namespace('widget.Table');
    PW.widget.Table = {
        client: function(param){
            return new Tabel(param);
        }
    }
},{
    requires:[
        'tabel/core'
    ]
})

KISSY.add('tabel/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on, delegate = S.Event.delegate,
        Pagination = PW.mod.Pagination,
        //正序排序
        ORDERBY_ASC_CLASS = 'pagination-reorder-asc',
        //逆序排序
        ORDERBY_DESC_CLASS = 'pagination-reorder-desc',
        //默认排序
        ORDERBY_DEFAULT_CLASS = 'pagination-reorder',
        //排序关键字
        ORDERBY_KEY = 'data-order-key',
        //正序排序
        ASC_ORDER =  0,
        //逆序排序
        DESC_ORDER = 1,
        el = {
            tabel: '.table-responsive',
            order: '.order'
        },
        CONFIG = {
            pagi:{
                renderTo: '',
                juicerRender: '',
                dataRender: '',
                pageSize: 10,
                url: null
            },
            pageSet: {
               //是否由用户设置分页数
                setPageSize: false,
                //获取分页选择器
                pageSizeRender: '' 
            },
            formSet: {
                //是否设置搜索form
                hasForm: false,
                //获取form选择器
                formRender: '',
                //搜索内容是否有验证
                formDefender :null
            }
            
        }

    function Tabel(param){
        this.opts = S.merge(CONFIG, param);
        this.pagiOpts = this.opts.pagi;
        this.pageSet = this.opts.pageSet;
        this.formSet = this.opts.formSet;
        this._init();
    }

    S.augment(Tabel, {
        _init: function(){
            this._initPagi();
            this._buildEvt();
        },
        _buildEvt: function(){
            var
                that = this,
                formSet = that.formSet,
                ths = query(el.order, el.tabel);
            on(ths, 'click', that._resetPagiEvt, that);
            //当配有form，序列化表单，获取内容刷新分页
            if(formSet.hasForm){
                 on(formSet.formRender, 'submit', function(){
                    var
                        extraParam = DOM.serialize(formSet.formRender);
                    if(formSet.formDefender){
                        formSet.formDefender.validAll(function(rs){
                            if(rs){
                               that.reloadPagi(extraParam); 
                            }
                        })
                    }else{
                        that.reloadPagi(extraParam); 
                    }
                    return false;
                 }, that);
            }
           
        },
        /**
         * 重置分页(外部函数)
         * @param  {[type]} extraObj [额外分页条件]
         * @return {[type]}          [根据额外添加的分页条件进行分页]
         */
        reloadPagi: function(extraObj){
            var
                that = this,
                pageSet = that.pageSet,
                pageSize;
            if(pageSet.setPageSize){
                pageSize = DOM.val(pageSet.pageSizeRender);
                S.mix(extraObj, {pageSize: pageSize});
                that.pagiOpts = S.merge(that.pagiOpts, {extraParam: extraObj}, {pageSize: pageSize});
            }else{
                that.pagiOpts = S.merge(that.pagiOpts, {extraParam: extraObj});
            }
            that.pagination.reload(that.pagiOpts);
            that._resetDefaultPagi();
        },
        /**
         * 初始化分页
         * @return {[type]} [description]
         */
        _initPagi: function(){
            var
                that = this,
                pagiOpts = that.pagiOpts,
                pageSet = that.pageSet,
                pageSize;
            if(pageSet.setPageSize){
                pageSize = DOM.val(pageSet.pageSizeRender);
                that.pagiOpts = S.merge(pagiOpts, {
                    extraParam: {pageSize : pageSize}
                }, {pageSize: pageSize});
            }
            that.pagination = Pagination.client(that.pagiOpts);
        },
        /**
         * 重置分页事件
         * @param  {[type]} e [description]
         * @return {[type]}   [description]
         */
        _resetPagiEvt: function(e){
            var
                that = this,
                target = e.target,
                currentClass = DOM.attr(target, 'class');
            if(DOM.hasClass(target, ORDERBY_DEFAULT_CLASS)){
                that._resetDefaultPagi();
                that._orderByAsc(target);
            }else if(DOM.hasClass(target, ORDERBY_ASC_CLASS)){
                that._orderByDesc(target);
            }else if(DOM.hasClass(target, ORDERBY_DESC_CLASS)){
                that._orderByAsc(target);
            }
        },
        /**
         * 正序排列
         * @param  {[type]} obj [正序列对象]
         * @return {[type]}     [description]
         */
        _orderByAsc: function(obj){
            var
                that = this,
                key = DOM.attr(obj, ORDERBY_KEY);
            that._resetPagiClass(obj);
            DOM.addClass(obj, ORDERBY_ASC_CLASS);
            that._resetPagi(key, ASC_ORDER);
        },
        /**
         * 逆序排列
         * @param  {[type]} obj [逆序列对象]
         * @return {[type]}     [description]
         */
        _orderByDesc: function(obj){
            var
                that = this,
                key = DOM.attr(obj, ORDERBY_KEY);
            that._resetPagiClass(obj);
            DOM.addClass(obj, ORDERBY_DESC_CLASS);
            that._resetPagi(key, DESC_ORDER);
        },
        /**
         * 重置默认排序
         * @return {[type]} [description]
         */
        _resetDefaultPagi: function(){
            var
                that = this,
                ths = query(el.order, el.tabel);
            that._resetPagiClass(ths);
            DOM.addClass(ths, ORDERBY_DEFAULT_CLASS);
        },
        /**
         * 按照排序情况刷新页面
         * @param  {[type]} key    [description]
         * @param  {[type]} status [description]
         * @return {[type]}        [description]
         */
        _resetPagi: function(key, status){
            var
                that = this,
                pagiOpts = that.pagiOpts;
            if(key){
                pagiOpts = S.mix(pagiOpts, {
                    extraParam: {
                        orderByName: key,
                        orderByType: status
                    }
                }, true, undefined, true);
            }
            that.pagination.reload(pagiOpts);
        },
        _resetPagiClass: function(obj){
            DOM.removeClass(obj, ORDERBY_DESC_CLASS);
            DOM.removeClass(obj, ORDERBY_DEFAULT_CLASS);
            DOM.removeClass(obj, ORDERBY_ASC_CLASS);
        }
    });

    return Tabel;
},{
    requires:[
        'core',
        'sizzle',
        'mod/ext',
        'mod/pagination'
    ]
})