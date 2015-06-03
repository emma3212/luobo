KISSY.add('module/forbidBackSpace',function(S, ForbidBackSpace){
    PW.namespace('module.ForbidBackSpace');
    PW.module.ForbidBackSpace = {
        client: function(){
            return new ForbidBackSpace();
        }
    }
    S.ready(function(){
        PW.module.ForbidBackSpace.client();
    })
},{
    requires:['forbidBackSpace/core']
});

KISSY.add('forbidBackSpace/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, on = S.Event.on;
    function ForbidBackSpace(){
        this._init();
    }
    S.augment(ForbidBackSpace, S.EventTarget, {
        _init: function(){
            this._buildEvt();
        },
        _buildEvt: function(){
        	/*alert('buildEvt');*/
            var
                that = this;
            on(document, 'keypress', that._onkeypress, that);
             on(document, 'keydown', that._onkeypress, that);
        },
        _onkeypress: function(e) {
		    var ev = e || window.event; //获取event对象
		    var obj = ev.target || ev.srcElement; //获取事件源
		    var t = obj.type || obj.getAttribute('type'); //获取事件源类型
		    //获取作为判断条件的事件类型
		    var vReadOnly = obj.readOnly;
		    var vDisabled = obj.disabled;
		    //处理undefined值情况
		    vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
		    vDisabled = (vDisabled == undefined) ? true : vDisabled;
		    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，
		    //并且readOnly属性为true或disabled属性为true的，则退格键失效
		    var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
		    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
		    var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
		    //判断
		    /*alert(flag2);
		    alert(flag1);*/
		    if (flag2 || flag1) return false;
		}
    })

    return ForbidBackSpace;
},{
    requires:[
        'core',
        'sizzle',
        'mod/ext'
    ]
})