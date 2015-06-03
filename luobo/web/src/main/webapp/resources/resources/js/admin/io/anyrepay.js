KISSY.add('io/anyrepay', function(S){

    var urls;

    try{
        urls = PW.Env.url.order.anyrepay;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.AnyRepay');
    S.mix(PW.io.AnyRepay, {
        conn: urls,
        /**
         * 保存未审批订单备注
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        auditTip: function(data, callback){
            S.IO({
                url: urls.auditTip + '/' + data.id,
                // url: urls.auditTip,
                type: 'put',
                // type: 'get',
                dataType: 'json',
                data: data,
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
        },
        /**
         * 保存取消订单备注
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        cancelTip: function(data, callback){
            S.IO({      
                url: urls.cancelTip + '/' + data.id,
                // url: urls.cancelTip,
                type: 'put',
                // type: 'get',
                dataType: 'json',
                data: data,
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
            });
        },
        /**
         * 保存订单状态
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        saveStatus: function(data, callback){
            S.IO({      
                // url: urls.saveStatus,
                url: urls.saveStatus + '/' + data.id,
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
                        null,
                        PW.Env.msg[0]
                    )
                }
            })
        },
        /**
         * 获取定单信息
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        getOrderInfo: function(data, callback){
            S.IO({      
                // url: urls.getOrderInfo,
                url: urls.getOrderInfo + '/' + data.id,
                type: 'get',
                dataType: 'json',
                async: false,
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
         * 修改还款订单备注
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        viewTip: function(data, callback){
            S.IO({      
                // url: urls.viewTip,
                url: urls.viewTip + '/' + data.id,
                // type: 'get',
                type: 'put',
                dataType: 'json',
                data: data,
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
        },
        /**
         * 保存还款信息
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        saveReturn: function(data, callback){
            S.IO({      
                // url: urls.saveReturn,
                url: urls.saveReturn + '/' + data.id,
                type: 'put',
                // type: 'get',
                dataType: 'json',
                data: data,
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
        },
        /**
         * 设置免息天数
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        saveFreeDay: function(data, callback){
            S.IO({      
                // url: urls.saveFreeDay,
                url: urls.saveFreeDay + '/' + data.id,
                type: 'post',
                // type: 'get',
                dataType: 'json',
                data: data,
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