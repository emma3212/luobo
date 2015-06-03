(function(){

    var site ={
        website:'/', //站点地址
        staticWebsite: '/', // 前端服务器地址
        puiWebsite: '/resources/tool/pui/1.1/'
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
                path: site.staticWebsite + 'resources/js/admin/'
            },
            {
                name: 'widget',
                path: site.staticWebsite + 'resources/tool/base-widget/js/'
            },
            {
                name: 'module',
                path: site.staticWebsite + 'resources/js/admin/'
            },
            {
                name: 'page',
                path: site.staticWebsite + 'resources/js/admin/'
            }
        ],
        preload: ['sizzle'],//预加载模块
        //对pui各个组件的一个
        modSettings:{
            dialog:{
                opacity: 0.1,
                position: 'fixed',
                theme: 'white',
                title: '提示信息',
                width: 600,
                themeUrl: site.staticWebsite + 'resources/tool/base-widget/css/pui-core.css'
            },
            defender:{
                themeUrl: site.staticWebsite + 'resources/tool/base-widget/css/pui-core.css'  
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
                themeUrl: site.staticWebsite + 'resources/tool/base-widget/css/pagination.css' 
            },
            upload: {
                flashUrl: site.staticWebsite + 'resources/tool/flash/swfupload_fp10.swf',
                flash9Url: site.staticWebsite + 'resources/tool/flash/swfupload_fp9.swf'
            }
        },
        //统一错误信息入口
        msg:{
            0: '网络加载错误'
        },
        //地址信息
        url:{
            module:{
                   
            },
            //区域
            region: {
                //区域:停用启用设置
                toggelEnlight: site.staticWebsite + 'mock/admin/region/enlight.json',
                //修改区域
                updateRegion: site.staticWebsite + 'mock/admin/region/enlight.json',
                //添加区域
                newRegion: site.staticWebsite + 'mock/admin/region/new.json',
                //学校：停用启用设置
                schoolEnlight: site.staticWebsite + 'mock/admin/region/enlight.json',
                //学校：新建
                newSchool: site.staticWebsite + 'mock/admin/region/enlight.json',
                //学校：编辑
                editSchool: site.staticWebsite + 'mock/admin/region/enlight.json'
            },
            //会员
            member: {
                //会员等级
                type: {
                    //启用禁用
                    enlight: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //编辑
                    edit: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //新建
                    newType: site.staticWebsite + 'mock/admin/region/enlight.json'
                },
                // 修改会员状态
                updateStatus: site.staticWebsite + 'mock/admin/region/enlight.json',
                //修改会员等级
                updateGrade: site.staticWebsite + 'mock/admin/region/enlight.json',
                //添加会员备注
                memberTip: site.staticWebsite + 'mock/admin/region/enlight.json',
                // 编辑会员时的联系人操作
                contact: {
                    // 保存联系人
                    save: site.staticWebsite + 'mock/vip/check.json',
                    // 修改联系人
                    edit: site.staticWebsite + 'mock/vip/check.json',
                    // 删除联系人
                    del: site.staticWebsite + 'mock/vip/check.json',
                    // 发送区域的id
                    sendRegionId: site.staticWebsite + 'mock/vip/school.json'
                }
            },
            product: {
                //品牌操作
                brand: {
                    //启用禁用
                    enlight: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //编辑
                    edit: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //新建
                    newBrand: site.staticWebsite + 'mock/admin/region/enlight.json'
                },
                //商品分类、添加及列表
                product: {
                    //商品分类页：启用禁用
                    enlight: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //商品分类页：编辑分类
                    newType: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //商品分类页：新建分类
                    editType: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //添加商品页：父分类及子分类的联动
                    sendParentType: site.staticWebsite + 'mock/admin/product/son-type.json',
                    //商品列表页：上架下架
                    toggelEnlight: site.staticWebsite + 'mock/admin/region/enlight.json'
                }
            },
            login:{
                check: site.staticWebsite + 'mock/admin/region/enlight.json',
                sendMobile: site.staticWebsite + 'mock/admin/region/new.json',
                submitRegisterForm: site.staticWebsite + 'mock/admin/region/enlight.json'
            },
            //订单
            order: {
                //产品订单
                product: {
                    //未审核订单备注
                    auditTip: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //取消订单备注
                    cancelTip: site.staticWebsite + 'mock/admin/region/enlight1.json',
                    //修改状态
                    saveStatus: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //修改还款订单备注
                    viewTip: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //保存还款信息
                    saveReturn: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //一键还款
                    onePressRepay: site.staticWebsite + 'mock/admin/region/enlight.json'
                },
                //白条订单
                whitebar:{
                    //未审核订单备注
                    auditTip: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //取消订单备注
                    cancelTip: site.staticWebsite + 'mock/admin/region/enlight1.json',
                    //修改状态
                    saveStatus: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //修改还款订单备注
                    viewTip: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //保存还款信息
                    saveReturn: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //保存开始还款状态
                    saveStartReturnStatus: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //获取每月还款金额
                    getPerPrice: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //一键还款
                    onePressRepay: site.staticWebsite + 'mock/admin/region/enlight.json'

                },
                anyrepay: {
                    //未审核订单备注
                    auditTip: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //取消订单备注
                    cancelTip: site.staticWebsite + 'mock/admin/region/enlight1.json',
                    //修改状态
                    saveStatus: site.staticWebsite + 'mock/admin/region/enlight.json',
                    //获取订单详情
                    getOrderInfo: site.staticWebsite + 'mock/admin/order/detail.json',
                    //设置免息天数
                    saveFreeDay: site.staticWebsite + 'mock/admin/order/detail.json'
                }
            },
            //内容管理
            content: {
                //添加
                save: site.staticWebsite + 'mock/admin/region/enlight.json',
                //编辑
                edit: site.staticWebsite + 'mock/admin/region/enlight.json',
                //删除
                del: site.staticWebsite + 'mock/admin/region/enlight.json'
            },
            //管理员管理
            administrator: {
                //管理员添加时，校验手机号码
                sendMobile: site.staticWebsite + 'mock/admin/region/enlight.json',
                //添加新管理员
                newAdministrator: site.staticWebsite + 'mock/admin/region/enlight.json',
                //修改管理员
                updateAdministrator: site.staticWebsite + 'mock/admin/region/enlight.json',
                //修改管理员密码
                updatePwd: site.staticWebsite + 'mock/admin/region/enlight.json',
                //停用启用
                toggelEnlight: site.staticWebsite + 'mock/admin/region/enlight.json'
            },
            // 会员额度管理
            amount: {
                // 保存会员额度
                save: site.staticWebsite + 'mock/admin/amount/amount.json'
            },
            system: {
                //刷新缓存
                refresh: site.staticWebsite + 'mock/admin/amount/amount.json'
            },
            //站点展示
            siteManage: {
                //添加图片
                newImg: site.staticWebsite + 'mock/admin/region/enlight.json',
                //编辑图片
                editImg: site.staticWebsite + 'mock/admin/region/enlight.json',
                //删除图片
                delImg: site.staticWebsite + 'mock/admin/region/enlight.json'
            }
        }
    }
})() 