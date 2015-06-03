KISSY.add('module/selectValid',function(S, SelectValid){
    var
        DOM = S.DOM, query = DOM.query,
        el = {
            selectEl: '.J_select'
        },
        IS_REPEAT = 'is-repeat',
        DD_KEY = 'selectValid';
    PW.namespace('module.SelectValid');
    PW.module.SelectValid = {
        refresh: function(){
            var
                that = this;
            S.each(query(el.selectEl), function(dd){
                DOM.data(dd, DD_KEY, that.client({
                    renderTo: dd,
                    repeat: DOM.attr(dd, IS_REPEAT)
                }));
            })
            return that;
        },
        client: function(param){
            return new SelectValid(param);
        }
    }
    S.ready(function(){
        PW.module.SelectValid.refresh();
    })
},{
    requires:['selectValid/core']
});


KISSY.add('selectValid/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on,  IO = S.IO, fire = S.Event.fire, detach = S.Event.detach,
        DATA_NAME = 'data-name',
        DATA_VALID = 'data-valid',
        DATA_TIP = 'data-tip',
        config = {
            renderTo: '',
            repeat: '',
        };
    function SelectValid(param){
        this.opts = S.merge(config,param);
        this.triggerEl = get(this.opts.renderTo);
        this._init();
    }
    S.augment(SelectValid, S.EventTarget, {
        _init: function(){
            this._triggerChange();
            this._buildEvt();
        },
        _buildEvt: function(){
            var
                that = this;
            on(that.triggerEl, 'change', that._triggerChange, that);
        },
        _triggerChange: function(){
            var
                that = this,
                target = get(that.triggerEl),
                inputEl = DOM.next(target),
                option = $('option:selected', that.triggerEl),
                optionName = DOM.attr(option, DATA_NAME),
                inputTip = DOM.attr(option, DATA_TIP),
                inputValid = DOM.attr(option, DATA_VALID);
            that.opts.repeat = that.opts.repeat || 'true';
            (S.trim(that.opts.repeat) == 'true') ? '' : DOM.attr(inputEl, 'name', optionName);
            DOM.attr(inputEl, 'data-valid-rule',  inputValid); 
            DOM.attr(inputEl, 'data-valid-tip',  inputTip);
            that.fire('refresh');
        }
    })

    return SelectValid;
},{
    requires:[
        'core',
        'sizzle',
        'mod/ext'
    ]
})