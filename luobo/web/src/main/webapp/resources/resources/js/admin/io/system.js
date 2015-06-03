KISSY.add('io/system', function(S){

    var urls;

    try{
        urls = PW.Env.url.system;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.System');
    S.mix(PW.io.System, {
        conn: urls,
        /**
         * 刷新缓存
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        refresh: function(callback){
            S.IO({      
                url: urls.refresh,
                type: 'put',
                dataType: 'json',
                success: function(rs){
                    callback(
                        rs.code == 0,
                        rs.errMsg
                    );
                },
                error: function(err){
                    callback(
                        false,
                        PW.Env.msg[0]
                    )
                }
            })
        }
    })
},{
    requires:[
        'mod/ext'
    ]
})