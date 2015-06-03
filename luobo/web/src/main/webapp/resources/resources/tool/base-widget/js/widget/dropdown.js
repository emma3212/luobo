KISSY.add('widget/dropdown',function(S, Dropdown){
	var
        DOM = S.DOM, query = DOM.query,
        el = {
            dropdown: '.dropdown'
        },
        DD_BOX_ATTR = 'data-dropdown-box',
        DD_WAIT_ATTR = 'data-dropdown-wait',
        DD_EVT_ATTR = 'data-dropdown-evt',
        DD_KEY = 'dropdown';
	PW.namespace('widget.Dropdown');
	PW.widget.Dropdown = {
		refresh: function(){
            var
                that = this;
            S.each(query(el.dropdown), function(dd){
                DOM.data(dd, DD_KEY, that.client({
                    renderTo: dd,
                    boxEl: '#' + DOM.attr(dd, DD_BOX_ATTR),
                    wait: parseFloat(DOM.attr(dd, DD_WAIT_ATTR)),
                    showEvt: DOM.attr(dd, DD_EVT_ATTR)
                }));
            })
            return that;
        },
        client: function(param){
            return new Dropdown(param);
        }
	}


    S.ready(function(){
        PW.widget.Dropdown.refresh();
    })
},{
	requires:['dropdown/core']
});


KISSY.add('dropdown/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
        on = S.Event.on, delegate = S.Event.delegate,
        IO = S.IO,
        BOX_INDEX_ATTR = 'data-downbox-id',
        TRIGGER_SHOW_CLASS = 'show',
        TRIGGER_HIDE_CLASS = 'hide',
        STATUS = {
            inactive: 'inactive',
            fadeIn : 'fadeIn',
            display: 'display',
            fadeOut: 'fadeOut'
        },
        el = {

        },
        config = {
            renderTo: '',
            boxEl: '',
            wait: .1,
            showEvt: ''
        };

    function Dropdown(param){
        this.opts = S.merge(config, param);
        this.triggerEl = get(this.opts.renderTo);
        this._status = STATUS.inactive;
        this._timer;
        this.boxEl;
        this._init();
    }
    S.augment(Dropdown, S.augment, {
        _init: function(){
            var
                that = this;
            that.boxEl = that._getDownBox();
            if(!that.boxEl) return;
            that._buildEvt();
        },
        _buildEvt: function(){
            var
                that = this,
                opts = that.opts;
            if(opts.showEvt === 'click'){
                on(document, 'click', that._toggle, that);
            }else{
                on(that.triggerEl, 'mouseenter', that._triggerMouseOverHandler, that);
                on(that.triggerEl, 'mouseleave', that._triggerMouseOutHandler, that);    
                on(that.boxEl, 'mouseenter', that._boxElMouseOverHandler, that);
                on(that.boxEl, 'mouseleave', that._boxElMouseOutHandler, that);
            }
            
        },
       _toggle: function(evt){
            var
                that = this,
                target = evt.target, flag = 0,
                parenttriggerEl = DOM.parent(target, that.opts.renderTo),
                parentBoxEl = DOM.parent(target, that.opts.boxEl);
            if(parenttriggerEl || target == DOM.get(that.triggerEl)){
                flag = 1;
            }
            if(that._status == STATUS.display && !parentBoxEl){
                that.hide();
            }else if(that._status == STATUS.inactive && flag == 1){
                that.show();
                flag = 0;
            }
        },
        _triggerMouseOverHandler: function(){
            var
                that = this,
                opts = that.opts;
            if(that._timer){
                S.clearTimer(that._timer);
                that._timer = null;
            }else{
                that.show();    
            }
            
        },
        _triggerMouseOutHandler: function(){
            var
                that = this,
                opts = that.opts;
            that._timer = S.timer(function(){
                that.hide();
                that._timer = null;
            }, opts.wait, 1);
        },
        _boxElMouseOverHandler: function(ev){
            var
                that = this,
                t = ev.target,
                prts = DOM.parents(t);
            if(that._timer){
                S.clearTimer(that._timer);
                that._timer = null;
            }
        },
        _boxElMouseOutHandler: function(ev){
            var
                that = this,
                opts = that.opts;
            that._timer = S.timer(function(){
                that.hide();
                that._timer = null;
            }, opts.wait, 1)
        },
        _toggleHandler: function(ev){
            var
                that = this;
            if(that._status == STATUS.inactive){
                that.show();
            }else if(that._status == STATUS.display){
                that.hide();
            }
        },
        show: function(){
            var
                that = this,
                triggerEl = that.triggerEl,
                boxEl = that.boxEl;
           if(that._status != STATUS.inactive) return;
            that._status = STATUS.fadeIn;
            $(boxEl).slideDown(.4, function(){
                DOM.replaceClass(triggerEl, TRIGGER_SHOW_CLASS, TRIGGER_HIDE_CLASS);    
                that._status = STATUS.display;
            }, 'easeInStrong');
        },
        hide: function(){
            var
                that = this,
                triggerEl = that.triggerEl,
                boxEl = that.boxEl;
            if(that._status != STATUS.display) return;
            that._status = STATUS.fadeOut;
            $(boxEl).slideUp(.2, function(){
                DOM.replaceClass(triggerEl, TRIGGER_HIDE_CLASS, TRIGGER_SHOW_CLASS);    
                that._status = STATUS.inactive;
            }, 'easeOutStrong');
            
        },
        _getDownBox: function(){
            var
                that = this,
                opts = that.opts,
                triggerEl = that.triggerEl;
            if(!that.triggerEl) return null;
            return get(opts.boxEl);
        }
    })

    return Dropdown;
},{
    requires:[
        'core',
        'sizzle',
        'mod/ext'
    ]
})