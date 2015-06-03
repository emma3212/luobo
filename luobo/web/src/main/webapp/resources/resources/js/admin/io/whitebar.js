KISSY.add('io/whitebar', function(S){

    var urls;

    try{
        urls = PW.Env.url.order.whitebar;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Whitebar');
    S.mix(PW.io.Whitebar, {
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
         * 保存开始还款信息
         * @param  {[type]}   code     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        saveStartReturnStatus: function(data, callback) {
            S.IO({      
                // url: urls.saveStartReturnStatus,
                url: urls.saveStartReturnStatus + '/' + data.id,
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
         * 获取每月还款金额
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        getPerPrice: function(data, callback){
            S.IO({      
                url: urls.getPerPrice,
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
         * 一键还款
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        repayPress: function(data, callback){
            S.IO({      
                // url: urls.onePressRepay,
                url: urls.onePressRepay + '/' + data.id,
                type: 'put',
                // type: 'get',
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