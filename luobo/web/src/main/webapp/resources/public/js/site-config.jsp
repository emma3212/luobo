<%@ page contentType="text/html; charset=UTF-8"%>

(function(){

    var site ={
        website:'${website}' || '', //站点地址
        staticWebsite: '${staticWebsite}' || '', // 前端服务器地址
        puiWebsite: '${staticWebsite}tool/pui/1.1/' || 'http://pui.pandawork.net/1.1/'
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
            path: site.staticWebsite + 'js/pub/'
        },
        {
            name: 'widget',
            path: site.staticWebsite + 'tool/base-widget/js/'
        },
        {
            name: 'module',
            path: site.staticWebsite + 'js/pub/'
        },
        {
            name: 'page',
            path: site.staticWebsite + 'js/pub/'
        }
        ],
        preload: ['sizzle'],//预加载模块
        //对pui各个组件的一个
        modSettings:{
            notifier: {
                top: 100
            },
            dialog:{
                title:'提示信息',
                opacity: 0.1,
                position: 'fixed',
                theme: 'grey',
                themeUrl: site.staticWebsite + 'tool/base-widget/css/dialog.css'
            },
            defender:{
                themeUrl: site.staticWebsite + 'tool/base-widget/css/form.css'
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
            themeUrl: site.staticWebsite + 'tool/base-widget/css/pagination.css'
            }
        },
        //统一错误信息入口
        msg:{
            0: '网络加载错误'
        },
        //地址信息
        url:{
            // 首页登录与注册
            login:{
                // 登录提交
                check: site.website + 'ajax/login',
                // 发送用户的手机号
                sendMobile: site.website + 'ajax/query/exist',
                // 注册表单提交
                submitRegisterForm: site.website + 'register',
                //重置密码
                resetPwd: site.website + 'reset/pwd'
            },
            product: {
                //获取月供信息
                getPerMonth: site.website + 'product/ajax/cal',
                //确认订单
                submitOrder: site.website + 'product/order/ajax/new'
            }
        }
    }
})()