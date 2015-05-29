<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<img src="${staticWebsite}img/pub/page/confirm/ads-img.jpg" class="ads-img">
<div class="classify-container clearfix">
    <div class="sub-nav">
        <h3>商品分类</h3>
        <input type="hidden" class="J_fatherId" value="${defaultFatherCategoryId}" />
        <ul class="sub-nav-classify">
            <c:forEach items="${productFatherCategoryList}" var="item">
                <li><a href="${website}product/list?fcid=${item.id}&fc=${item.name}" <c:if test="${item.id==defaultFatherCategoryId}">class="active"</c:if> >${item.name}</a></li>
            </c:forEach>
        </ul>
        <h3 class="green-h3">本周热卖</h3>
        <ul class="hot-sales">
            <c:forEach items="${productSalesList}" var="item">
                <li class="clearfix">
                    <a class="img" href="${website}product/view/${item.id}" target="_blank">
                        <img src="${item.url}">
                    </a>
                    <a class="J_hotSaleTitle hot-sale-title" href="${website}product/view/${item.id}">${item.name}</a>
                    <a class="hot-sale-count" href="javascript:void(0);">销量：${item.sales}</a>
                </li>
            </c:forEach>
        </ul>
    </div>
    <div class="product-box">
        <h3 class="product-box-classify">首页><span>${defaultFatherCategory}</span></h3>
        <div class="product-select clearfix">
            <label>商品分类：</label>
            <div>
                <ul class="J_selectSonUl">
                    <li><a class="J_sendClassify change-color" href="#">全部</a></li>
                    <c:forEach items="${productCategoryList}" var="item">
                        <li><a href="javascript:;" class="J_sendClassify" data-id="${item.id}">${item.name}</a></li>
                    </c:forEach>
                </ul>
            </div>
        </div>
        <div class="product-select clearfix">
            <label>品&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;牌：</label>
            <div>
                <ul class="J_selectBrandUl">
                    <li><a class="J_sendClassify change-color" href="#">全部</a></li>
                    <c:forEach items="${productBrandList}" var="item">
                        <li><a href="javascript:;" class="J_sendClassify" data-id="${item.id}">${item.brandName}</a></li>
                    </c:forEach>
                </ul>
                    <a href="javascript:;" class="spread J_spread">展开</a>
            </div>
        </div>
        <div class="product-select clearfix">
            <label>售&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：</label>
            <div>
                <ul class="J_selectPricedUl">
                    <li><a class="J_sendClassify change-color" href="#">全部</a></li>
                    <li><a href="javascript:;" class="J_sendClassify" data-id="1">1000元以下</a></li>
                    <li><a href="javascript:;" class="J_sendClassify" data-id="2">1000-2000元</a></li>
                    <li><a href="javascript:;" class="J_sendClassify" data-id="3">2000-3000元</a></li>
                    <li><a href="javascript:;" class="J_sendClassify" data-id="4">3000-4000元</a></li>
                    <li><a href="javascript:;" class="J_sendClassify" data-id="5">4000-5000元</a></li>
                    <li><a href="javascript:;" class="J_sendClassify" data-id="6">5000元以上</a></li>
                </ul>
            </div>
        </div>
        <h3 class="rank-title">
            <a class="rank-color J_sendRank" rank-name="rank" rank-type="" href="javascript:;">默认排序</a>
            <a class="arrow-bottom J_sendRank" rank-name="price" rank-type="0" href="javascript:;">价格</a>
            <a class="arrow-top J_sendRank" rank-name="sales" rank-type="1" href="javascript:;">销量</a>
            <p>共有
                <span class="J_dataCount page-color">0</span >
                款产品
                <span class="J_currentPage page-color">0</span>
                /
                <span class="J_sumPage">0</span>
            </p>
        </h3>
        <ul class="show-imgs clearfix" id="J_template">
        </ul>
        <div class="pagination-margin" id="J_pagination"></div>
    </div>
</div>