<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="sidebar">
    <div class="sidebar-toggler"></div>
    <h6 class="side-title"><a href="${website}home">会员中心</a></h6>
    <ul class="page-sidebar-menu" id="sideBar" data-layer="1">
        <li <c:if test="${MethodModule eq 'Home'}">class="active"</c:if>>
            <a href="${website}home" >
                <span class="fa fa-home"></span>
                会员中心首页
                <c:if test="${MethodModule eq 'Home'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${PWModule eq 'Vip:Product:Order'}">class="active"</c:if>>
            <a href="${website}vip/product/order" >
                <span class="fa fa-check-square-o"></span>
                商品订单查询
                <c:if test="${PWModule eq 'Vip:Product:Order'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Vip:WhiteBar:Order:List'}">class="active"</c:if>>
            <a href="${website}vip/white/bar/order" >
                <span class="fa fa-bookmark-o"></span>
                白条订单查询
                <c:if test="${MethodModule eq 'Vip:WhiteBar:Order:List'}"> <i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Vip:Any:Repay'}">class="active"</c:if>>
            <a href="${website}vip/any/repay/list" >
                <span class="fa fa-bullhorn"></span>
                随意还订单查询
                <c:if test="${MethodModule eq 'Vip:Any:Repay'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Vip:Member'}">class="active"</c:if>>
            <a href="${website}vip/info" >
                <span class="fa fa-building-o"></span>
                会员身份审核
                <c:if test="${MethodModule eq 'Vip:Member'}"> <i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Vip:User:Profile'}">class="active"</c:if>>
            <a href="${website}vip/user/profile" >
                <span class="fa fa-user"></span>
                会员档案编辑
                <c:if test="${MethodModule eq 'Vip:User:Profile'}"> <i class="selected"></i></c:if>
            </a>
        </li>
    </ul>
</div>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('module/sidebar',function(S){
            PW.module.SideBar();
        });
    });
</script>