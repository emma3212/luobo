<%@ page  contentType="text/html;charset=UTF-8"%>
(function(){

    var site ={
        website: '${website}' || '', //站点地址
        staticWebsite: '${staticWebsite}' || '', // 前端服务器地址
        puiWebsite: '${staticWebsite}tool/pui/1.1/' || 'http://pui.pandawork.net/1.1/' //pui地址
    }

    _pw_env = {
        status: 0, //0-前端调试，1-后端调试, 2-后端部署
        website: site.website,
        staticWebsite: site.staticWebsite,
        puiWebsite: site.puiWebsite,
        tag: '',
        pkgs:[
            {
                name: 'io',
                path: site.staticWebsite + 'js/admin/'
            },
            {
                name: 'widget',
                path: site.staticWebsite + 'tool/base-widget/js/'
            },
            {
                name: 'module',
                path: site.staticWebsite + 'js/admin/'
            },
            {
                name: 'page',
                path: site.staticWebsite + 'js/admin/'
            }
        ],
        preload: ['sizzle'],//预加载模块
        //对pui各个组件的一个
        modSettings:{
            notifier: {
                top: 100
            },
            dialog:{
                opacity: 0.1,
                position: 'fixed',
                theme: 'white',
                title: '提示信息',
                width:600,
                themeUrl: site.staticWebsite + 'tool/base-widget/css/pui-core.css'
            },
            defender:{
                themeUrl: site.staticWebsite + 'tool/base-widget/css/pui-core.css'
            },
            pagination: {
                themePackage: {
                    layout: ['first','num','last'],
                    //默认分页样式（定义了五种）
                    themeCss: 'pagination-white',
                    //首页按钮内容显示
                    firstPageTip: '<i class="fa fa-angle-left"></i>',
                    //尾页按钮内容显示
                    lastPageTip: '<i class="fa fa-angle-right"></i>'
                },
                themeUrl: site.staticWebsite + 'tool/base-widget/css/pui-core.css'
            },
            upload: {
                flashUrl: site.staticWebsite + 'tool/flash/swfupload_fp10.swf',
                flash9Url: site.staticWebsite + 'tool/flash/swfupload_fp9.swf'
            }
        },
        //统一错误信息
        msg:{
        },
        //统一路径位置
        //地址信息
        url:{
            module:{

            },
            //区域
            region: {
                //区域:停用启用设置
                toggelEnlight: site.website + 'admin/region/ajax/enabled',
                //修改区域
                updateRegion: site.website + 'admin/region/ajax/update',
                //添加区域
                newRegion: site.website + 'admin/region/ajax/new',

                //学校：停用启用设置
                schoolEnlight: site.website + 'admin/school/ajax/enabled',
                //学校：新建
                newSchool: site.website + 'admin/school/ajax/new',
                //学校：编辑
                editSchool: site.website + 'admin/school/ajax/update'
            },
            member: {
                //会员类型
                type: {
                    //启用禁用
                    enlight: site.website + 'admin/member/type/ajax/cancel',
                    //编辑
                    edit: site.website + 'admin/member/type/ajax/update',
                    //新建
                    newType: site.website + 'admin/member/type/ajax/new'
                },
                // 修改会员状态
                updateStatus: site.website + 'admin/member/ajax/update/status',
                //添加会员备注
                memberTip: site.website + 'admin/member/ajax/update/comments',
                //修改会员等级
                updateGrade: site.website + 'admin/member/ajax/update/type',
                // 编辑会员时的联系人操作
                contact: {
                    // 保存联系人
                    save: site.website + 'admin/member/contacts/ajax/new',
                    // 修改联系人
                    edit: site.website + 'admin/member/contacts/ajax/update',
                    // 删除联系人
                    del: site.website + 'admin/member/contacts/ajax/del',
                    // 发送区域的id
                    sendRegionId: site.website + 'admin/member/ajax/school'
                }
            },
            product: {
                //禁用品牌
                brand: {
                    //启用禁用
                    enlight: site.website + 'admin/product/brand/ajax/cancel',
                    //编辑
                    edit: site.website + 'admin/product/brand/ajax/update',
                    //新建
                    newBrand: site.website + 'admin/product/brand/ajax/new'
                },
                //禁用品牌
                product: {
                    //商品分类页：启用禁用
                    enlight: site.website + 'admin/product/category/ajax/cancel',
                    //商品分类页：新建分类
                    newType: site.website + 'admin/product/category/ajax/add',
                    //商品分类页：编辑分类
                    editType: site.website + 'admin/product/category/ajax/update',
                    //添加商品页：父分类及子分类的联动
                    sendParentType: site.website + 'admin/product/ajax/getCategory',
                    //商品列表页：上架下架
                    toggelEnlight: site.website + 'admin/product/ajax/update/status'
                }
            },
            login:{
                check: site.website + 'ajax/login',
                sendMobile: site.website + 'ajax/query/exist',
                submitRegisterForm: site.website + 'register'
            },
            // 产品订单
            order: {
                product: {
                    //未审核订单备注
                    auditTip: site.website + 'admin/product/order/ajax/comment',
                    //取消订单备注
                    cancelTip: site.website + 'admin/product/order/ajax/comment',
                    //修改状态
                    saveStatus: site.website + 'admin/product/order/ajax/status',
                    //修改还款订单备注
                    viewTip: site.website + 'admin/repay/ajax',
                    //保存还款信息
                    saveReturn: site.website + 'admin/repay/ajax',
                    //一键还款
                    onePressRepay: site.website + 'admin/repay/all/ajax'
                },
                //白条订单
                whitebar:{
                    //未审核订单备注
                    auditTip: site.website + 'admin/white/bar/order/ajax/comment',
                    //取消订单备注
                    cancelTip: site.website + 'admin/white/bar/order/ajax/comment',
                    //修改状态
                    saveStatus: site.website + 'admin/white/bar/order/ajax/update/status',
                    //修改还款订单备注
                    viewTip: site.website + 'admin/repay/ajax',
                    //保存还款信息
                    saveReturn: site.website + 'admin/repay/ajax',
                    //保存开始还款状态
                    saveStartReturnStatus: site.website + 'admin/white/bar/order/ajax/update',
                    //获取每月还款金额
                    getPerPrice: site.website + 'admin/white/bar/order/ajax/count',
                    //一键还款
                    onePressRepay: site.website + 'admin/repay/all/ajax'
                },
                anyrepay: {
                    //未审核订单备注
                    auditTip: site.website + 'admin/any/repay/order/ajax/comment',
                    //取消订单备注
                    cancelTip: site.website + 'admin/any/repay/order/ajax/comment',
                    //修改状态
                    saveStatus: site.website + 'admin/any/repay/order/ajax/status',
                    //获取订单详情
                    getOrderInfo: site.website + 'admin/any/repay/order/ajax',
                    //设置免息天数
                    saveFreeDay: site.website + 'admin/any/repay/order/ajax/free/day'
                }
            },
            //内容管理
            content: {
                //添加
                save: site.website + 'admin/content/ajax',
                //编辑
                edit: site.website + 'admin/content/ajax',
                //删除
                del: site.website + 'admin/content/ajax'
            },
            //管理员管理
            administrator: {
                //管理员添加时，校验手机号码
                sendMobile: '${website}ajax/query/exist',
                //添加新管理员
                newAdministrator: '${website}admin/administrator',
                //修改管理员
                updateAdministrator: site.website + 'admin/administrator/ajax/update/name',
                //修改管理员密码
                updatePwd: site.website + 'admin/administrator/ajax/update/password',
                //停用启用
                toggelEnlight: site.website + 'admin/administrator/ajax/cancel'
            },
            // 会员额度管理
            amount: {
            // 保存会员额度
            save: site.website + 'admin/member/amount/update',
            },
            system: {
                //刷新缓存
                refresh: site.website + 'admin/security/monthly/rate/flush'
            },
            siteManage: {
                //添加图片
                newImg: site.website + 'admin/site/product/ajax/new',
                //编辑图片
                editImg: site.website + 'admin/site/product/ajax/update',
                //删除图片
                delImg: site.website + 'admin/site/product/ajax/del'
            }
        }
    }
})()
