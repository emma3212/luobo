/*-----------------------------------------------------------------------------
* @Description:     对dialog进行进一步处理
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.26
* ==NOTES:=============================================
* v1.0.0(2014.5.26):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('widget/dialog', function(S){
    var
        that = this,
        ret = {},
        Dialog = PW.mod.Dialog;
    PW.namespace('widget.Dialog');
    //继承自 mod dialog
    PW.widget.Dialog = S.merge(Dialog, {
       
        alert: function(txt, cb, settings){
            var 
                html =  '<div class="dlg-alert">';
                html += '<div>'+ ((txt) ? txt : 'null') +'</div>',
                html += '</div>';
                cfg = {
                    theme: 'white',
                    content:html,
                    footer:{
                        btns:[{
                            text: '确定',
                            clickHandler: function(e,me){
                                me.close();
                            }
                        }]
                    },
                    // onClick: function(e, me){
                    //     me.close()
                    // },
                    afterClose: function(e, me){
                        if(S.isFunction(cb)){
                            cb.call(me,e,me);
                        }
                    }
                };
            S.mix(cfg, settings);
            return Dialog.client(cfg);
        },
        success: function(txt, cb){
            return Dialog.alert(txt, cb, {
                theme: 'green'
            })
        },
        error: function(txt, cb){
            return Dialog.alert(txt, cb, {
                theme: 'red'
            })
        },
        warn: function(txt, cb){
            return Dialog.alert(txt, cb, {
                theme: 'yellow'
            })
        },
        confirm: function(str, okCb, cancelCb, settings){
            var
                cfg = S.merge(settings,{header:true, theme: 'white-confirm'});
            
            return Dialog.confirm(str, okCb, cancelCb, cfg);
        },
        prompt: function(tip, orginalTxt, cb, settings){
            return Dialog.prompt(tip, orginalTxt, cb, {
                theme: 'white'
            })
        }
    });


},{
    requires:[
        'mod/dialog'
    ]
})