KISSY.add('module/advanced-pagination', function(S, AdvancedPagination){
    PW.namespace('module.AdvancedPagination');
    PW.module.AdvancedPagination = function(){
        return new AdvancedPagination();
    }
},{
    requires:[
        'advancedPagination/core'
    ]
})

KISSY.add('advancedPagination/core',function(S){
	var
		DOM = S.DOM, get = DOM.get,
		on = S.Event.on, delegate = S.Event.delegate,
		$ = S.all,
		el = {
			down: '.down',
			//搜索选项框
			up: '.up'
		};
	var
		Core = function(){
			this.opts = param;
			this.pagination;
			/*this.order;
			this.status;*/
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._addEvt();
			this._buildPagi('',0);	
		},
		_addEvt: function(){
			var
				that = this;
			//根据每页显示条数分页
			/*on(el.pageSize, 'change', function(){
				that._buildPagi(that.order, that.status);
			});*/
			//按照升序排列
			on(el.up, 'click', function(e){
				var					
					order = $(e.target).parent('th').children('span').attr('span-name');
				
				that._reloadPagi(order, 0);	
			});
			//按照降序排列
			on(el.down, 'click', function(e){
				var
					order = $(e.target).parent('th').children('span').attr('span-name');
				
				that._reloadPagi(order, 1);	
			});
		},
		/**
		 * 分页条件
		 * @param  {[type]} order  [description]
		 * @param  {[type]} status [description]
		 * @return {[type]}        [description]
		 */
		_buildPagi: function(order, status){
			var
				that = this,
				condition = {
					order: order,
					status: status
				}
			/*that.order = order;
			that.status = 0;*/
			that.pagination = Pagination(S.merge(that.opts, {
				extraParam: condition
			}));
		},
		/**
		 * 重新加载分页
		 * @param  {[type]} order  [description]
		 * @param  {[type]} status [description]
		 * @return {[type]}        [description]
		 */
		_reloadPagi: function(order, status){
			var
				that = this,
				condition = {
					order: order,
					status: status
				}
			/*that.order = order;
			that.status = 1;*/
			that.pagination.reload(S.merge(that.opts, {
				extraParam: condition
			}))
		}
	});
	return AdvancedPagination;
},{
    requires:[
        'core'
    ]
});