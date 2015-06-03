<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sidebar">
<div class="sidebar-toggler"></div>
<h6 class="side-title"><a href="${website}admin/index">管理员面板</a></h6>
<ul class="page-sidebar-menu" id="sideBar" data-layer="1">
<li>
    <a href="${website}admin/index">
        <span class="fa fa-home"></span>
        管理员面板首页
    </a>
    <a href="javascript:;">
        <span class="fa fa-group"></span>
        币种管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li <c:if test="${MethodModule eq 'Admin:Currency'}">class="active"</c:if>>
            <a href="${website}admin/currency/list">
                <span class="fa fa-cubes"></span>
                币种管理
                <c:if test="${MethodModule eq 'Admin:Currency'}"> <i class="selected"></i></c:if>
            </a>
        </li>
    </ul>
    <a href="javascript:;">
        <span class="fa fa-group"></span>
        汇率管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li <c:if test="${MethodModule eq 'Admin:Rate:Add'}">class="active"</c:if>>
            <a href="${website}admin/rate/new">
                <span class="fa fa-cubes"></span>
                添加汇率
                <c:if test="${MethodModule eq 'Admin:Rate:Add'}"> <i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Rate:List'}">class="active"</c:if>>
            <a href="${website}admin/rate/list">
                <span class="fa fa-cubes"></span>
                汇率列表
                <c:if test="${MethodModule eq 'Admin:Rate:List'}"> <i class="selected"></i></c:if>
            </a>
        </li>
    </ul>
</li>
</ul>
</div>
<script type="text/javascript">
    KISSY.ready(function (S) {
        S.use('module/sidebar', function (S) {
            PW.module.SideBar();
        });
    });
</script>