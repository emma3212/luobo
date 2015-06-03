KISSY.add('io/page', function(S){

    var urls;

    try{
        urls = PW.Env.url.content;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Page');
    S.mix(PW.io.Page, {
        conn: urls,
        /**
         * 添加页面
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        save: function(data, callback){
            S.IO({      
                url: urls.save,
                type: 'post',
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
         * 编辑页面
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        edit: function(data, callback){
           S.IO({      
                url: urls.edit,
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
         * 删除页面
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        del: function(data, callback){
            S.IO({      
                url: urls.del + '/' + data.id,
                type: 'delete',
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