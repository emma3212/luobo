<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="header user-header">
    <a class="logo" href="${website}home">
        <img src="${staticWebsite}img/admin/common/transparent-logo.png" alt="" height="58">
    </a>

    <div class="user-nav">

        <a class="dropdown" id="J_userInfo" data-dropdown-box="J_userMenu" data-dropdown-wait=".5">
            <i class="fa fa-user icon-margin-right"></i>${requestScope.web_user_name}<i class="fa fa-caret-down press-right"></i>
        </a>

        <ul id="J_userMenu" class="dropdown-info">
            <li>

                <a href="${website}admin/user/profile"><i class="fa fa-user"></i>我的信息</a>
            </li>
            <li>

                <a href="${website}logout"><i class="fa fa-key"></i>注销登录</a>
            </li>
        </ul>
    </div>
    <div class="dropdown-container manager">
        <a href="${website}index">返回网站首页</a>
    </div>
    <div class="info">
        <div class="dropdown-container">
            <a href="${website}admin/white/bar/order?statusId=1" class="nav_informs dropdown" id="J_evaluateOrder" data-dropdown-box="J_evaluateOrderMenu" data-dropdown-wait=".5">
                <i class="fa fa-envelope"></i>
                <span class="badge">${white_bar_repay_order}</span>
                <span class="tip">白条 订单</span>
            </a>
        </div>
        <div class="dropdown-container">
            <a href="${website}admin/product/order?statusId=1" class="nav_informs dropdown" id="J_maintenanceOrder" data-dropdown-box="J_maintenanceOrderMenu" data-dropdown-wait=".5">
                <i class="fa fa-tasks"></i>
                <span class="badge">${product_repay_order}</span>
                <span class="tip">商品 订单</span>
            </a>
        </div>
        <div class="dropdown-container">
            <a href="${website}admin/any/repay/order?statusId=1" class="nav_informs dropdown" data-dropdown-box="J_imcompleteOrder" data-dropdown-wait=".5">
                <i class="fa fa-tasks"></i>
                <span class="badge">${any_repay_order}</span>
                <span class="tip">随意还订单</span>
            </a>
        </div>
        <div class="dropdown-container">
            <a href="${website}admin/member/?statusId=2" class="nav_informs dropdown" data-dropdown-box="J_imcompleteOrder" data-dropdown-wait=".5">
                <i class="fa fa-tasks"></i>
                <span class="badge">${not_checked_vip_num}</span>
                <span class="tip">待审核会员</span>
            </a>
        </div>
    </div>
</div>
<script>
    KISSY.ready(function(S){
        S.use('widget/dropdown', function(){
        });
    })
</script>