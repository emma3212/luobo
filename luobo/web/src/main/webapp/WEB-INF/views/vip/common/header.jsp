<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="header user-header">
<a class="logo" href="${website}home">
    <img src="${staticWebsite}img/admin/common/transparent-logo.png" alt="" height="58">
</a>
<div class="user-nav user-nav-margin">
    <!-- <a class="tip" href="#"><span class="label label-error"></span></a> -->
    <a class="dropdown" id="J_userInfo" data-dropdown-box="J_userMenu" data-dropdown-wait=".5"><i class = "fa fa-user icon-margin-right"></i>${requestScope.web_user_name}<i class="fa fa-caret-down press-right"></i></a>
    <ul id="J_userMenu" class="dropdown-info">
        <li>
            <a href="${website}vip/user/profile"><i class="fa fa-user"></i>会员档案编辑</a>
            <a href="${website}logout"><i class="fa fa-key"></i>注销登录</a>
        </li>
    </ul>
</div>
<div class="dropdown-container manager">
    <a href="${website}index">返回网站首页</a>
</div>
<div class="dropdown-container manager">
    <a href="${website}vip/white/bar/order/new">快速申请白条</a>
</div>
<div class="manager">
    <a href="${website}vip/any/repay">快速申请随意还</a>
</div>
<div class="info">
    <div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_monthTable" data-dropdown-box="J_monthTableMenu" data-dropdown-wait=".5">
            <i class="fa fa-warning"></i>
            <span class="badge">${overdue_num}</span>
            <span class="tip">逾期订单</span>
        </a>
    </div>
    <%--<div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_monthTable" data-dropdown-box="J_monthTableMenu" data-dropdown-wait=".5">
            <i class="fa fa-warning"></i>
            <span class="badge">9</span>
            <span class="tip">月度报告</span>
        </a>
        <ul id="J_monthTableMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>--%>
    <%--<div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_evaluateOrder" data-dropdown-box="J_evaluateOrderMenu" data-dropdown-wait=".5">
            <i class="fa fa-envelope"></i>
            <span class="badge">412</span>
            <span class="tip">未评价订单</span>
        </a>
        <ul id="J_evaluateOrderMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>--%>
    <%--<div class="dropdown-container">
        <a href="${website}user/maintenance/order/unfinish" class="nav_informs dropdown" id="J_maintenanceOrder" data-dropdown-box="J_maintenanceOrderMenu" data-dropdown-wait=".5">
            <i class="fa fa-tasks"></i>
            <span class="badge">${requestScope.web_user_Vip_maintenance_num}</span>
            <span class="tip">未完成的维护订单</span>
        </a>
        <ul id="J_maintenanceOrderMenu" class="dropdown-new-box new-box">
            <c:choose>
                <c:when test="${!empty web_user_Vip_maintenance_list}">
                    <c:forEach items="${web_user_Vip_maintenance_list}" var="order">
                        <li>
                            <a href="${website}user/maintenance/order/${order.id}">订单：${order.num}</a>
                        </li>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <li style="text-align: center;">暂没有未完成维护订单</li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>--%>
        
    <%--<div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_OrderNum" data-dropdown-box="J_OrderNumMenu" data-dropdown-wait=".5">
            <i class="fa fa-folder-open-o"></i>
            <span class="badge">0</span>
            <span class="tip">未完成产品</span>
        </a>
        <ul id="J_OrderNumMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>--%>
    <%--<div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_activityNum" data-dropdown-box="J_activityNumMenu" data-dropdown-wait=".5">
            <i class="fa fa-list"></i>
            <span class="badge">13</span>
            <span class="tip">待确认活动</span>
        </a>
        <ul id="J_activityNumMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>
    <div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_trainingNum" data-dropdown-box="J_trainingNumMenu" data-dropdown-wait=".5">
            <i class="fa fa-paperclip"></i>
            <span class="badge">2</span>
            <span class="tip">待确认培训</span>
        </a>
        <ul id="J_trainingNumMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>
    <div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_packageNum" data-dropdown-box="J_packageNumMenu" data-dropdown-wait=".5">
            <i class="fa fa-shopping-cart"></i>
            <span class="badge">7</span>
            <span class="tip">待确认套餐</span>
        </a>
        <ul id="J_packageNumMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>
    <div class="dropdown-container">
        <a href="javascript:;" class="nav_informs dropdown" id="J_projectNum" data-dropdown-box="J_projectNumMenu" data-dropdown-wait=".5">
            <i class="fa fa-tag"></i>
            <span class="badge">5</span>
            <span class="tip">待确认项目</span>
        </a>
        <ul id="J_projectNumMenu" class="dropdown-new-box new-box">
            <li>
                <a href="javascript:;">订单：1284555666</a>
            </li>
        </ul>
    </div>--%>
</div>
</div>
<script>
    KISSY.ready(function(S){
        S.use('widget/dropdown', function(){});
    })
</script>