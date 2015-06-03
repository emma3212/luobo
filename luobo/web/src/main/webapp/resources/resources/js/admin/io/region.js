KISSY.add('io/region', function(S){

    var urls;

    try{
        urls = PW.Env.url.region;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Region');
    S.mix(PW.io.Region, {
        conn: urls,
        /**
         * 区域:启用停用设置
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        toggelEnlight: function(data, callback){
            S.IO({      
                url: urls.toggelEnlight + '/' + data.id,
                //url: urls.toggelEnlight,
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
         * 区域:修改区域
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        updateRegion: function(data, callback){
            S.IO({      
                url: urls.updateRegion,
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
         * 区域:添加区域
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        newRegion: function(data, callback){
            S.IO({      
                url: urls.newRegion,
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
         * 修改学校状态
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        schoolEnlight: function(data, callback){
            S.IO({      
                url: urls.schoolEnlight + '/' + data.id,
                 //url: urls.schoolEnlight,
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
         * 保存新学校
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        newSchool: function(data, callback){
            S.IO({      
                url: urls.newSchool,
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
         * 编辑学校
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        editSchool: function(data, callback){
            S.IO({
                url: urls.editSchool + '/' + data.id,      
                // url: urls.editSchool,
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
        }
    })
},{
    requires:[
        'mod/ext'
    ]
})