/*-----------------------------------------------------------------------------
* @Description:     管理员面板dashboard
* @Version:         1.0.0
* @author:          wangjing(1284663246@qq.com)
* @date             2015.03.12
* ==NOTES:=============================================
* v1.0.0(2015.03.12):
     初始生成
* ---------------------------------------------------------------------------*/
KISSY.add('page/index/index', function(S, manager, school, region, overPay){
	PW.namespace('page.Index');
	PW.page.Index = {
		manager:function(param){
			return new manager(param);
		},
		school: function(param){
			return new school(param);
		},
		region: function(param){
			return new region(param); 
		},
		overPay: function(param){
			return new overPay(param); 
		}
	}
},{
	requires:['index/manager','index/school', 'index/region', 'index/overPay']
});
KISSY.add('index/manager', function(S){
	var
		Pagination = PW.mod.Pagination.client,
		el = {};
	function Manager(param){
		this.opts = param;
		this._init();
	};
	S.augment(Manager, {
		_init: function(){
			var
				that = this;
			Pagination(that.opts)
		}
	});
	return Manager;
},{
	requires:['mod/pagination']
});
KISSY.add('index/school', function(S){
	var
		Pagination = PW.mod.Pagination.client,
		el = {};
	function School(param){
		this.opts = param;
		this._init();
	};
	S.augment(School, {
		_init: function(){
			var
				that = this;
			Pagination(that.opts);
		}
	});
	return School;
},{
	requires:['mod/pagination']
});
KISSY.add('index/region', function(S){
	var
		Pagination = PW.mod.Pagination.client,
		el = {};
	var Region = function(param){
		this.opts = param;
		this._init();
	};
	S.augment(Region, {
		_init: function(){
			Pagination(this.opts);
		}
	});
	return Region;
},{
	requires:['mod/pagination']
});
KISSY.add('index/overPay', function(S){
	var
		Pagination = PW.mod.Pagination.client,
		el = {
			
		};
	var OverPay = function(param){
		this.opts = param;
		this._init();
	};
	S.augment(OverPay, {
		_init: function(){
			Pagination(this.opts);
		}
	});
	return OverPay;
},{
	requires:['mod/pagination']
});