KISSY.add('io/member', function(S){

    var urls, type;

    try{
        urls = PW.Env.url.member;
        type = urls.type;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Member');
    S.mix(PW.io.Member, {
        conn: urls,
        /**
         * 会员等级修改
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        updateGrade: function(data, callback){
            S.IO({
                url: urls.updateGrade,
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
         * 修改会员状态
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        updateStatus: function(data, callback){
            S.IO({      
                url: urls.updateStatus,
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
         * 保存会员备注
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        memberTip: function(data, callback){
            S.IO({
                url: urls.memberTip,
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
         * 修改用户类型
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        editType: function(data, callback){
            S.IO({      
                // url: type.edit,
                url: type.edit + '/' + data.id,
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
         * 新建用户类型
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        newType: function(data, callback){
            S.IO({      
                url: type.newType,
                type: 'post',
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
         * 用户类型状态设置
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        enlightType: function(data, callback){
            S.IO({      
                url: type.enlight + '/' + data.id,
                // url: type.enlight,
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
         * 发送区域id
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        sendRegionId: function(data, callback){
            S.IO({
                url: urls.contact.sendRegionId,
                type: 'get',
                dataType: 'json',
                data: data,
                success: function(rs){
                    callback(
                        rs.code == 0,
                        rs.list,
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
         * 添加联系人
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        save: function(data, callback){
            S.IO({
                url: urls.contact.save,
                type: 'post',
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
        },
        /**
         * 修改联系人
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        edit: function(data, callback){
            S.IO({
                url: urls.contact.edit,
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
         * 删除联系人
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        del:function(data, callback){
            S.IO({
                // url: urls.contact.del,
                url: urls.contact.del + '/' + data.id,
                type: 'delete',
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