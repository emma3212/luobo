/*-----------------------------------------------------------------------------
* @Description: 商品列表 
* @Version: 	V1.0.0
* @author: 		kt
* @date			2015.01.20
* ==NOTES:=============================================
* v1.0.0(2015.01.20):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/product/product-list', function (S, Core) {
    PW.namespace('page.product.ProductList');
    PW.page.product.ProductList = function(param){
        new Core(param);
    }
},{
    requires:[
        'list/core',
        'module/forbidBackSpace'
    ]
});
KISSY.add('list/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, 
		Defender = PW.mod.Defender.client,
		Pagination = PW.mod.Pagination.client,
		Dialog = PW.widget.Dialog,
		ProductIO = PW.io.Product,
		el = {
			//form
			searchForm: '.J_searchForm',
			//启用停用触发器
            enlightTrigger: '.J_enlight',
			//table的tbody
			template:'#J_template',
			//导出pdf
		    pdfTrigger: '.J_PDF'
		},
		//tr属性
		DATA_ID = 'data-order-id',
		ABLED_STATUS = 1,
		DISABLED_STATUS = 0,
		//上架下架显示方式
        ENLIGHT_TIP = ['上架', '下架'],
        CONTENT = '确定要修改状态吗？', 
		SUCCESS_TIP = ['状态修改成功！'];
	var
		Core = function(param){
			this.searchDefender = Defender(el.searchForm);
			this.opts = param;
			this._pagination;
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._pagination();
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			on(el.pdfTrigger, 'click', that._exportPdf, that);
			on(el.searchForm, 'submit', that._reloadPagi, that);
			//上架下架
            delegate(el.template, 'click', el.enlightTrigger, function(evt){
                that._toggelEnlightEvt(evt.target);
            });
		},
		//初始化分页
		_pagination: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);
			that.opts.pagi = S.merge(that.opts.pagi,{
				extraParam: data
			});
			that._pagination = Pagination(that.opts);
		},
		/**
		 * 搜索重新加载分页
		 * @return {[type]} [description]
		 */
		_reloadPagi: function(){
			var
				that = this,
				data = DOM.serialize(el.searchForm);
			that.searchDefender.validAll(function(rs){
				if(rs){
					S.mix(that.opts,{
						extraParam: data
					});
					that._pagination.reload(that.opts);
				}
			});
			return false;
		},
		/**
		 * 导出Pdf操作
		 * @return {[type]} [description]
		 */
		_exportPdf:function(){
            var 
                that = this,
                f = S.IO.serialize(el.searchForm),
                pdfHref = DOM.attr(el.pdfTrigger, 'href'),
                frontPdfHref = pdfHref.split("?"),
                newPdfHref = frontPdfHref[0] + '?'+f;
            DOM.attr(el.pdfTrigger, {href:newPdfHref});
        },
        /**
		 * 上架下架设置
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_toggelEnlightEvt: function(e){
			var
				that = this,
				statusTip = S.trim(DOM.html(e)),
				tr = DOM.parent(e, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				td = DOM.get('.J_productStatus', tr),
				status;
			if(statusTip == ENLIGHT_TIP[0]){
				//现在是下架状态，即将变成上架
				status = ABLED_STATUS;
			}else{
				//现在是上架状态，即将变成下架
				status = DISABLED_STATUS;
			}
			Dialog.confirm(CONTENT, function(){
				ProductIO.toggelEnlight({
					id: id,
					status: status
				}, function(code, errMsg){
					if(code){
						switch(statusTip){
							case ENLIGHT_TIP[0]:
								DOM.html(e, ENLIGHT_TIP[1]);
								DOM.html(td, '已上架');
								break;
							case ENLIGHT_TIP[1]:
								DOM.html(e, ENLIGHT_TIP[0]);
								DOM.html(td, '已下架');
								break;
						}
						Dialog.alert(SUCCESS_TIP[0]);
					}else{
						Dialog.alert(errMsg);
					}
				});
			})
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/pagination',
				'mod/defender',
				'io/product',
				'widget/dialog',
				'widget/dropdown'
			]
});
