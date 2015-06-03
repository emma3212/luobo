KISSY.add('io/product', function(S){

    var urls, type;

    try{
        urls = PW.Env.url.product;
        product = urls.product;
        brand = urls.brand;
    }catch(e){
        S.log('地址信息错误');
        return;
    }

    PW.namespace('io.Product');
    S.mix(PW.io.Product, {
        conn: urls,
        enlightBrand: function(data, callback){
            S.IO({      
                url: brand.enlight + '/' + data.id,
                // url: brand.enlight,
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
            });
        },
        /**
         * 修改用户类型
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        editBrand: function(data, callback){
            S.IO({      
                // url: brand.edit,
                url: brand.edit + '/' + data.id,
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
        newBrand: function(data, callback){
            S.IO({      
                url: brand.newBrand,
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
         * 商品列表页:启用禁用
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        enlight: function(data, callback){
            S.IO({      
                url: product.enlight + '/' + data.id,
                //url: product.enlight,
                type: 'put',
                //type: 'get',
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
         * 商品列表页:添加商品分类
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        newType: function(data, callback){
            S.IO({      
                url: product.newType,
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
         * 商品列表页:编辑商品分类
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        editType: function(data, callback){
            S.IO({      
                url: product.editType,
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
         * 商品列表页:上架下架
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        toggelEnlight: function(data, callback){
            S.IO({      
                url: product.toggelEnlight + '/' + data.id,
                //url: product.toggelEnlight,
                //type: 'get',
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
         * 商品添加页:父分类和子分类的联动
         * @param  {[type]}   data     [description]
         * @param  {Function} callback [description]
         * @return {[type]}            [description]
         */
        sendParentType: function(data, callback){
            S.IO({      
                url: product.sendParentType,
                type: 'get',
                dataType: 'json',
                data: data,
                cache: false,
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
        }
    })
},{
    requires:[
        'mod/ext'
    ]
})