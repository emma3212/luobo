KISSY.add('io/login', function(S){

    var urls;

    try{
        urls = PW.Env.url.login;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Login');
    S.mix(PW.io.Login, {
        conn: urls,
        /**
         * 登录操作
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        check: function(data, callback){
            S.IO({      
                url: urls.check,
                type: 'post',
                // type: 'get',
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
                        false,
                        PW.Env.msg[0]
                    )
                }
            })
        },
         /**
         * 注册发送手机号验重操作
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        sendMobile: function(data, callback){
            S.IO({      
                url: urls.sendMobile,
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
        },
        /**
         * 注册操作
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        submitRegisterForm: function(data, callback){
            S.IO({      
                url: urls.submitRegisterForm,
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
        },
        /**
         * 重置密码
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        resetPwd: function(data, callback){
            S.IO({      
                url: urls.resetPwd,
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
        }
    })
},{
    requires:[
        'mod/ext'
    ]
})