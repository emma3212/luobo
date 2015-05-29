<%@ page  contentType="text/html; charset=UTF-8"%>
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
                path: site.staticWebsite + 'js/vip/'
            },
            {
                name: 'widget',
                path: site.staticWebsite + 'tool/base-widget/js/'
            },
            {
                name: 'module',
                path: site.staticWebsite + 'js/vip/'
            },
            {
                name: 'page',
                path: site.staticWebsite + 'js/vip/'
            }
            ],
            preload: ['sizzle'],//预加载模块
            //对pui各个组件的一个
            modSettings:{
            dialog:{
                opacity: 0.1,
                position: 'fixed',
                title: '提示信息',
                theme: 'white',
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
            }
        },
        //统一错误信息入口
        msg:{
            0: '网络加载错误'
        },
        //地址信息
        url:{
            // 会员身份审核
            check:{
                // 保存联系人
                save: site.website + 'vip/info/contacts/ajax/new',
                // 修改联系人
                edit: site.website + 'vip/info/contacts/ajax/update',
                // 删除联系人
                del: site.website + 'vip/info/contacts/ajax/del',
                // 发送区域的id
                sendRegionId: site.website + 'vip/info/ajax/school'
            },
            //订单
            order: {
                cancelOrder: site.website + 'vip/product/order/canceled',
                //取消白条订单
                whitebarCancel: site.website + 'vip/white/bar/order/ajax/cancel',
                //保存白条申请表单
                whitebarSave: site.website + 'vip/white/bar/order/ajax/new',
                //获取订单详情
                getOrderInfo: site.website + 'vip/any/repay/ajax',
                //取消随意还订单
                anyRepayCancel: site.website + 'vip/any/repay/ajax/canceled',
                //保存随意还申请表单
                anyRepaySave:　site.website + 'vip/any/repay/ajax/new',
                //获取白条订单还款信息
                getRepayInfo: site.website + 'vip/white/bar/order/ajax/cal',
                //获取支付表单
                getPayForm: site.website + 'pay/order/alipay'
            }
        }
    }
})() 