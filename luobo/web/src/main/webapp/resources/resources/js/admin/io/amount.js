KISSY.add('io/amount', function(S){

    var urls;

    try{
        urls = PW.Env.url.amount;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Amount');
    S.mix(PW.io.Amount, {
        conn: urls,
        /**
         * 保存会员额度
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        save: function(data, callback){
            S.IO({      
                url: urls.save,
                type: 'put',
                // type: 'get',
                dataType: 'json',
                data: data,
                success: function(rs){
                    callback(
                        rs.code == 0,
                        rs.data,
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