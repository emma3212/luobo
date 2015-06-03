KISSY.add('io/siteManage', function(S){

    var urls;

    try{
        urls = PW.Env.url.siteManage;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.SiteManage');
    S.mix(PW.io.SiteManage, {
        conn: urls,
        /**
         * 新建图片
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {Boolean}           [description]
         */
        newImg: function(data, callback){
            S.IO({      
                url: urls.newImg,
                // type: 'get',
                type: 'post',
                data: data,
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
        },
        /**
         * 编辑图片
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        editImg: function(data, callback){
            S.IO({      
                url: urls.editImg + '/' + data.id,
                // url: urls.editImg,
                type: 'put',
                // type: 'get',
                data: data,
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
        },
        /**
         * 删除图片
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        delImg: function(data, callback){
            S.IO({      
                url: urls.delImg  + '/' + data.id,
                // url: urls.delImg,
                type: 'delete',
                // type: 'get',
                data: data,
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