KISSY.add('module/map', function(S, Core){
    PW.namespace('module.Map');
    PW.module.Map = function(){
        return new Core();
    }
},{
    requires:[
        'map/core'
    ]
})

KISSY.add('map/core',function(S){
	var
		DOM = S.DOM, get = DOM.get;
	var
		Core = function(){
			this.arr = new Array();
			this._init();
		}
	S.augment(Core, {
		_init: function(){},
		/**
		 * put 元素
		 * @param  {[type]} key   [description]
		 * @param  {[type]} value [description]
		 * @return {[type]}       [description]
		 */
		put: function(key, value){
			var
				that = this;
			that.arr.push({
	            key : key,
	            value : value
	        });
		},
		/**
		 * get 元素
		 * @param  {[type]} key [description]
		 * @return {[type]}     [description]
		 */
		get: function(key){
			var
				that = this;
			try {
	            for (i = 0; i < that.arr.length; i++) {
	                if (that.arr[i].key == key) {
	                    return that.arr[i].value;
	                }
	            }
	        } catch (e) {
	            return null;
	        }
		},
		/**
		 * 是否包含key值
		 * @param  {[type]} key [description]
		 * @return {[type]}     [description]
		 */
		containsKey: function(key){
			var 
				that = this,
				flag = false;
				
	        try {
	            for (i = 0; i < that.arr.length; i++) {
	                if (that.arr[i].key == key) {
	                    flag = true;
	                }
	            }
	        } catch (e) {
	            flag = false;
	        }
        	return flag;
		},
		/**
		 * map中是否有value值
		 * @param  {[type]} value [description]
		 * @return {[type]}       [description]
		 */
		containsValue: function(value){
			var
				that = this,
				flag = false;
			try {
	            for (i = 0; i < that.arr.length; i++) {
	                if (that.arr[i].value == value) {
	                    flag = true;
	                }
	            }
	        } catch (e) {
	            flag = false;
	        }
	        return flag;
		}
		
	});
	return Core;
},{
    requires:[
        'core'
    ]
});