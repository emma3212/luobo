KISSY.add('io/administrator', function(S){

    var urls, type;

    try{
        urls = PW.Env.url.administrator;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Administrator');
    S.mix(PW.io.Administrator, {
        conn: urls,
        /**
         * 验证手机号码是否重复
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        sendMobile: function(data, callback){
            S.IO({
                url: urls.sendMobile,
                type: 'post',
                //type: 'get',
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
         * 新建管理员
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        newAdministrator: function(data, callback){
            S.IO({
                url: urls.newAdministrator,
                type: 'post',
                //type: 'get',
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
         * 修改管理员
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        updateAdministrator: function(data, callback){
            S.IO({
                url: urls.updateAdministrator + '/' + data.id,
                //url: urls.updateAdministrator,
                type: 'put',
                //type: 'get',
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
         * 修改管理员密码
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        updatePwd: function(data, callback){
            S.IO({
                url: urls.updatePwd + '/' + data.id,
                //url: urls.updatePwd,
                type: 'put',
                //type: 'get',
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
         * 停用启用
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        toggelEnlight: function(data, callback){
            S.IO({
                url: urls.toggelEnlight + '/' + data.id,
                type: 'put',
                //url: urls.toggelEnlight,
                //type: 'get',
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