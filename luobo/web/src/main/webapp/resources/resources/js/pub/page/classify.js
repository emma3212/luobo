/*-----------------------------------------------------------------------------
* @Description: 公共页面——商品分类 
* @Version: 	V1.0.0
* @author: 		kt
* @date			2015.02.03
* ==NOTES:=============================================
* v1.0.0(2015.02.03):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/classify', function (S, Core) {
    PW.namespace('page.Classify');
    PW.page.Classify = function(param){
        	new Core(param);
    	}
},{
    requires:[
        'classify/core'
    ]
});
KISSY.add('classify/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, 
		Pagination = PW.mod.Pagination.client,
		el = {
			//父id的input
			fatherId:'.J_fatherId',
			//搜索条件a
			classifyTrigger:'.J_sendClassify',
			//点击搜索之后的颜色变化
			changeColor:'.change-color',
			//子分类ul
			selectSonUl:'.J_selectSonUl',
			//品牌ul
			selectBrandUl:'.J_selectBrandUl',
			//价格ul
			selectPricedUl:'.J_selectPricedUl',
			//排名的颜色变化
			rankColor:'.rank-color',
			//排序按钮
			rankTrigger:'.J_sendRank',
			//总数span
			dataCount:'.J_dataCount',
			//当前是第几页span
			currentPage:'.J_currentPage',
			//总页数span
			sumPage:'.J_sumPage',
			//展开按钮
			spreadTrigger:'.J_spread',
			//全选
			allTrigger:'.J_all',
			hotSaleTitle: '.J_hotSaleTitle'
		},
		DATA_ID="data-id",
		RANK_NAME = "rank-name",
		RANK_TYPE = "rank-type";
	var
		Core = function(param){
			this.opts = param;
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._pagination;
			this._isSpread();
			this._pagination();
			this._subString();
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			on(el.classifyTrigger, 'click', that._reloadPagi, that);
			on(el.rankTrigger, 'click', that._reloadPagiRank, that);
			on(el.spreadTrigger, 'click', that._spreadBrand, that);
			on(el.allTrigger, 'click', that._allProduct, that);
		},
		_subString: function(){
			var
				length = $(el.hotSaleTitle).length,
				hotSaleTitle = query(el.hotSaleTitle),
				hotSaleTitleSubStr;
			S.each(hotSaleTitle, function(i){
				var
					title = DOM.text(i);
				if(title.length > 40){
					titleStr = title.substring(0,40);
					DOM.text(i, titleStr + '...');
				}
			});
		},
		//初始化分页
		_pagination: function(){
			var
				that = this,
				fatherId = DOM.val(el.fatherId),
				d = {fatherId:fatherId,type:'',rank:'rank',categoryId:'',brandId:'',priceId:''};
			that.opts= S.merge(that.opts,{
				extraParam: d
			});
			that._pagination = Pagination(S.mix(that.opts,{
				afterDataLoad: function(that, data, page){
					var
						dataCount = data.dataCount,
						pageSize = data.pageSize,
						sumPage = Math.ceil(dataCount/pageSize);
					if(data.dataCount == 0) page = 0;
					DOM.html(el.dataCount,dataCount);
					DOM.html(el.currentPage,page);
					DOM.html(el.sumPage,sumPage);	
				}
			}));
		},
		_allProduct: function(e){
			var
				that = this,
				target = e.target,
			    ul =DOM.siblings(target,'ul')
				a = DOM.get(el.changeColor,ul);
			if(a){
				DOM.removeClass(a,"change-color");
			}
			that._sendData();
			return false;
		},
		/**
		 * 按排序条件重新加载分页
		 * @return {[type]} [description]
		 */
		_reloadPagiRank:function(e){
			var
				that = this,
				target = e.target,
				letter = S.trim(DOM.html(target)),flag;
			DOM.removeClass(el.rankTrigger,"rank-color");	
			DOM.addClass(target,"rank-color");
			if(letter !='默认排序'){
				flag = DOM.hasClass(target,"arrow-bottom");
				if(flag){
					DOM.removeClass(target,"arrow-bottom");	
					DOM.addClass(target,"arrow-top");
					$(target).attr(RANK_TYPE,1)
				}else{
					DOM.removeClass(target,"arrow-top");	
					DOM.addClass(target,"arrow-bottom");
					$(target).attr(RANK_TYPE,0)
				}
			}
			that._sendData();
		},
		/**
		 * 按子分类品牌等重新加载分页
		 * @return {[type]} [description]
		 */
		_reloadPagi: function(e){
			var
				that = this,
				target = e.target,
				ul = DOM.parent(target,'ul'),
				a = DOM.get(el.changeColor,ul);
			if(a){
				DOM.removeClass(a,"change-color");
			}
			DOM.addClass(target,"change-color");
			that._sendData();
			return false;
		},
		/**
		 * 重新加载分页
		 * @return {[type]} [description]
		 */
		_sendData: function(e){
			var
				that = this,
				categoryIdEl = DOM.get(el.changeColor,el.selectSonUl),
				brandIdEl = DOM.get(el.changeColor,el.selectBrandUl),
				priceIdEl = DOM.get(el.changeColor,el.selectPricedUl),
				fatherId = DOM.val(el.fatherId),
				categoryId = DOM.attr(categoryIdEl,DATA_ID),
				brandId = DOM.attr(brandIdEl,DATA_ID),
				priceId = DOM.attr(priceIdEl,DATA_ID),
				rank = DOM.attr(el.rankColor,RANK_NAME),
				type = DOM.attr(el.rankColor,RANK_TYPE),
				d = {
					categoryId:'',
					brandId:'',
					priceId:''
				};
			S.mix(d,{fatherId:fatherId,
				rank:rank,
				type:type,
				categoryId:categoryId,
				brandId:brandId,
				priceId:priceId
			});
			S.mix(that.opts,{
				extraParam: d
			});

			that._pagination.reload(that.opts);
		},
		/**
		 * 是否显示展开二字
		 * @return {[type]} [description]
		 */
		_isSpread:function(){
			var
				height = DOM.height(el.selectBrandUl);

			if(height>29){
				DOM.addClass(el.selectBrandUl, 'hide-brand')
				$(el.spreadTrigger).show();
			}
		},
		/**
		 * 收起展开
		 * @return {[type]} [description]
		 */
		_spreadBrand:function(){
			var
				letter = S.trim(DOM.text(el.spreadTrigger))
			if(letter == '展开'){
				DOM.removeClass(el.selectBrandUl, 'hide-brand')
				$(el.spreadTrigger).html('收起');
			}else{
				DOM.addClass(el.selectBrandUl, 'hide-brand')
				$(el.spreadTrigger).html('展开');
			}
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/pagination'
			]
});