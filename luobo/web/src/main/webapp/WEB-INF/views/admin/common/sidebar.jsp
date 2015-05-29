<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sidebar">
<div class="sidebar-toggler"></div>
<h6 class="side-title"><a href="${website}home">管理员面板</a></h6>
<ul class="page-sidebar-menu" id="sideBar" data-layer="1">
<li>
    <a href="${website}home">
        <span class="fa fa-home"></span>
        管理员面板首页
    </a>
    <a href="javascript:;">
        <span class="fa fa-group"></span>
        会员管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li <c:if test="${MethodModule eq 'Admin:Region'}">class="active"</c:if>>
            <a href="${website}admin/region">
                <span class="fa fa-map-marker"></span>
                服务区域管理
                <c:if test="${MethodModule eq 'Admin:Region'}"> <i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:School'}">class="active"</c:if>>
            <a href="${website}admin/school">
                <span class="fa fa-graduation-cap"></span>
                学校管理
                <c:if test="${MethodModule eq 'Admin:School'}"> <i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Member:Type'}">class="active"</c:if>>
            <a href="${website}admin/member/type">
                <span class="fa fa-cubes"></span>
                会员类型管理
                <c:if test="${MethodModule eq 'Admin:Member:Type'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Member:Amount'}">class="active"</c:if>>
            <a href="${website}admin/member/amount/list">
                <span class="fa fa-user"></span>
                会员信用额度管理
                <c:if test="${MethodModule eq 'Admin:Member:Amount'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Member'}">class="active"</c:if>>
            <a href="${website}admin/member">
                <span class="fa fa-table"></span>
                会员列表
                <c:if test="${MethodModule eq 'Admin:Member'}"><i class="selected"></i></c:if>
            </a>
        </li>
    </ul>
</li>
<li>
    <a href="javascript:;">
        <span class="fa fa-tty"></span>
        商品管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li
                <c:if test="${MethodModule eq 'Admin:Product:New'}">class="active"</c:if> >
            <a href="${website}admin/product/new">
                <span class="fa fa-plus-square"></span>
                添加商品
                <c:if test="${MethodModule eq 'Admin:Product:New'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Product:List'}">class="active"</c:if>>
            <a href="${website}admin/product/list">
                <span class="fa fa-table"></span>
                商品列表
                <c:if test="${MethodModule eq 'Admin:Product:List'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Product:Category'}">class="active"</c:if>>
            <a href="${website}admin/product/category">
                <span class="fa fa-sitemap"></span>
                商品分类管理
                <c:if test="${MethodModule eq 'Admin:Product:Category'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Product:Brand'}">class="active"</c:if>>
            <a href="${website}admin/product/brand">
                <span class="fa fa-yelp"></span>
                商品品牌管理
                <c:if test="${MethodModule eq 'Admin:Product:Brand'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <c:if test="${MethodModule eq 'Admin:Product:Edit'}">
            <li <c:if test="${MethodModule eq 'Admin:Product:Edit'}">class="active"</c:if>>
                <a>
                    <span class="fa fa-unlink"></span>
                    编辑商品
                    <c:if test="${MethodModule eq 'Admin:Product:Edit'}"><i class="selected"></i></c:if>
                </a>
            </li>
        </c:if>
    </ul>
</li>
<li>
    <a href="javascript:;">
        <span class="fa fa-building-o"></span>
        订单管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li>
            <a href="javascript:;">
                <span class="fa fa-check-square-o"></span>
                商品订单管理
                <i class="fa fa-angle-left arrow"></i>
            </a>
            <ul class="third-layer-menu" data-layer="3">
                <li <c:if test="${MethodModule eq 'Admin:Product:Order'}">class="active"</c:if>>
                    <a href="${website}admin/product/order">
                        <span class="fa fa fa-dashboard"></span>
                        订单列表
                        <c:if test="${MethodModule eq 'Admin:Product:Order'}"><i class="selected"></i></c:if>
                    </a>
                </li>
                <li <c:if test="${MethodModule eq 'Admin:Product:Overdue:Order'}">class="active"</c:if>>
                    <a href="${website}admin/product/order/overdue">
                        <span class="fa-exclamation-triangle"></span>
                        逾期订单
                        <c:if test="${MethodModule eq 'Admin:Product:Overdue:Order'}"><i class="selected"></i></c:if>
                    </a>
                </li>
                <li <c:if test="${MethodModule eq 'Admin:Product:Canceled:Order'}">class="active"</c:if>>
                    <a href="${website}admin/product/order/canceled">
                        <span class="fa fa-star-o"></span>
                        已取消订单
                        <c:if test="${MethodModule eq 'Admin:Product:Canceled:Order'}"><i class="selected"></i></c:if>
                    </a>
                </li>
                <c:if test="${MethodModule eq 'Admin:Product:Order:View'}">
                    <li class="active">
                        <a href="">
                            <span class="fa fa-unlink"></span>
                            查看订单
                            <i class="selected"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </li>
        <li>
            <a href="javascript:;">
                <span class="fa  fa-bookmark-o"></span>
                白条订单管理
                <i class="fa fa-angle-left arrow"></i>
            </a>
            <ul class="third-layer-menu" data-layer="3">
                <li <c:if test="${MethodModule eq 'Admin:WhiteBar:Order:List'}">class="active"</c:if>>
                    <a href="${website}admin/white/bar/order">
                        <span class="fa fa fa-dashboard"></span>
                        订单列表
                        <c:if test="${MethodModule eq 'Admin:WhiteBar:Order:List'}"><i class="selected"></i></c:if>
                    </a>
                <li <c:if test="${MethodModule eq 'Admin:White:Bar:Overdue:Order'}">class="active"</c:if>>
                    <a href="${website}admin/white/bar/order/overdue">
                        <span class="fa-exclamation-triangle"></span>
                        逾期订单
                        <c:if test="${MethodModule eq 'Admin:White:Bar:Overdue:Order'}"><i class="selected"></i></c:if>
                    </a>
                </li>
                <li <c:if test="${MethodModule eq 'Admin:WhiteBar:Order:CancelList'}">class="active"</c:if>>
                    <a href="${website}admin/white/bar/order/cancel">
                        <span class="fa fa-star-o"></span>
                        已取消订单
                        <c:if test="${MethodModule eq 'Admin:WhiteBar:Order:CancelList'}"><i
                                class="selected"></i></c:if>
                    </a>
                </li>
                <c:if test="${MethodModule eq 'Admin:WhiteBar:Order:View'}">
                    <li class="active">
                        <a href="">
                            <span class="fa fa-unlink"></span>
                            查看订单
                            <i class="selected"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </li>
        <li>
            <a href="javascript:;">
                <span class="fa  fa-bullhorn"></span>
                随意还订单管理
                <i class="fa fa-angle-left arrow"></i>
            </a>
            <ul class="third-layer-menu" data-layer="3">
                <li <c:if test="${MethodModule eq 'Admin:Any:Repay:Order'}">class="active"</c:if>>
                    <a href="${website}admin/any/repay/order">
                        <span class="fa fa fa-dashboard"></span>
                        订单列表
                        <c:if test="${MethodModule eq 'Admin:Any:Repay:Order'}"><i class="selected"></i></c:if>
                    </a>
                </li>
                <li <c:if test="${MethodModule eq 'Admin:Any:Repay:Canceled:Order'}">class="active"</c:if>>
                    <a href="${website}admin/any/repay/order/canceled/list">
                        <span class="fa fa-star-o"></span>
                        已取消订单
                        <c:if test="${MethodModule eq 'Admin:Any:Repay:Canceled:Order'}"><i class="selected"></i></c:if>
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</li>
<li <c:if test="${MethodModule eq 'Admin:Content'}">class="active"</c:if>>
    <a href="${website}admin/content">
        <span class="fa fa-newspaper-o"></span>
        内容设置
        <c:if test="${MethodModule eq 'Admin:Content'}"><i class="selected"></i></c:if>
    </a>
</li>
<li>
    <a href="javascript:;">
        <span class="fa fa-picture-o"></span>
        站点展示管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li <c:if test="${MethodModule eq 'Admin:Site:Product' and typeId ==1}">class="active"</c:if>>
            <a href="${website}admin/site/product?typeId=1">
                <span class="fa fa-puzzle-piece"></span>
                新品推荐展示管理
                <c:if test="${MethodModule eq 'Admin:Site:Product' and typeId ==1}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Site:Product' and typeId ==2}">class="active"</c:if>>
            <a href="${website}admin/site/product?typeId=2">
                <span class="fa fa-send-o"></span>
                促销商品展示管理
                <c:if test="${MethodModule eq 'Admin:Site:Product' and typeId ==2}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Site:Product' and typeId ==3}">class="active"</c:if>>
            <a href="${website}admin/site/product?typeId=3">
                <span class="fa fa-magnet"></span>
                精选商品展示管理
                <c:if test="${MethodModule eq 'Admin:Site:Product' and typeId ==3}"><i class="selected"></i></c:if>
            </a>
        </li>
    </ul>
</li>
<li>
    <a href="javascript:;">
        <span class="fa fa-gear"></span>
        系统配置管理
        <i class="fa fa-angle-left arrow"></i>
    </a>
    <ul class="second-layer-menu" data-layer="2">
        <li <c:if test="${MethodModule eq 'Admin:System:Rate'}">class="active"</c:if>>
            <a href="${website}admin/security/monthly/rate">
                <span class="fa fa-jpy"></span>
                利率设置
                <c:if test="${MethodModule eq 'Admin:System:Rate'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:System:Sensitive'}">class="active"</c:if>>
            <a href="${website}admin/security/pass/setting">
                <span class="fa fa-unlock-alt"></span>
                敏感密码设置
                <c:if test="${MethodModule eq 'Admin:System:Sensitive'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:System:EEMsg'}">class="active"</c:if>>
            <a href="${website}admin/system/eemsg">
                <span class="fa fa-envelope-o"></span>
                短信平台设置
                <c:if test="${MethodModule eq 'Admin:System:EEMsg'}"><i class="selected"></i></c:if>
            </a>
        </li>
        <li <c:if test="${MethodModule eq 'Admin:Administrator'}">class="active"</c:if>>
            <a href="${website}admin/administrator">
                <span class="fa fa-user"></span>
                管理员管理
                <c:if test="${MethodModule eq 'Admin:Administrator'}"><i class="selected"></i></c:if>
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