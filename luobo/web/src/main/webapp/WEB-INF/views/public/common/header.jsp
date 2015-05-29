<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="header">
    <div class="container">
        <a class="logo" href="${website}">
            <img src="${staticWebsite}img/pub/common/logo.png" alt="">
        </a>
        <div class="nav">
            <a class="home <c:if test="${MethodModule eq 'Public:Index'}">active</c:if>" href="${website}index"><i class="fa fa-home"></i></a>
            <ul>
                <li <c:if test="${MethodModule eq 'Public:Product:List'}">class="active"</c:if>>
                    <a href="${website}product/list?fcid=0">分期商品</a>
                </li>
                <li <c:if test="${contentId ==1}">class="active"</c:if> ><a href="${website}content/1">利息计算助手</a></li>
                <li <c:if test="${contentId ==2}">class="active"</c:if> ><a href="${website}content/2">校区负责人</a></li>
                <li <c:if test="${contentId ==3}">class="active"</c:if> ><a href="${website}content/3">分期业务介绍</a></li>
                <li <c:if test="${contentId ==4}">class="active"</c:if> ><a href="${website}content/4">合作商户</a></li>
                <li <c:if test="${contentId ==5}">class="active"</c:if> ><a href="${website}content/5">公司介绍</a></li>
                <li><a <c:if test="${empty web_user_name}">class="J_filter"</c:if> href="${website}home">会员中心</a></li>
            </ul>
        </div>
    </div>
</div>

<script type="text/javascript">
    KISSY.ready(function (S) {
        KISSY.use('module/filter', function () {
            PW.module.Filter();
        });
    });
</script>