/*-----------------------------------------------------------------------------
* @Description:     对于一些常用的错误，放在此处处理
* @Version:         1.0.0
* @author:          simon(406400939@qq.com)
* @date             2014.5.16
* ==NOTES:=============================================
* v1.0.0(2014.5.16):
     初始生成
* ---------------------------------------------------------------------------*/


KISSY.add('widget/error', function(S){

    var 
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        Notifier = PW.mod.Notifier;

    /**
     * 此处只是一个示例，如果用户未登录，可以直接控制跳转
     */
    function notLogin(){
        var nf = Notifier.client({
            region: 'n',
            title: '用户没有登陆',
            content: '请检查'
        })
        nf.show();
    }

    PW.namespace('widget.Error');
    PW.widget.Error = {
        notLogin: notLogin
    }

},{
    requires:[
        'core',
        'mod/notifier'
    ]
})