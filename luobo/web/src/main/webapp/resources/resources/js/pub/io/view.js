KISSY.add('io/view', function(S){

    var urls;

    try{
        urls = PW.Env.url.product;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.View');
    S.mix(PW.io.View, {
        conn: urls,
        /**
         * 获取月供信息
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        getPerMonth: function(data, callback){
            S.IO({      
                url: urls.getPerMonth,
                type: 'get',
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
                        null,
                        PW.Env.msg[0]
                    )
                }
            })
        },
        /**
         * 提交商品订单
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        submitOrder: function(data, callback){
           S.IO({      
                url: urls.submitOrder,
                type: 'post',
                dataType: 'json',
                data: data,
                success: function(rs){
                    callback(
                        rs.code,
                        rs.errMsg
                    );
                },
                error: function(err){
                    callback(
                        -1,
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