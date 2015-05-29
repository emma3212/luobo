<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<p class="ads"><img src="${staticWebsite}img/pub/page/confirm/ads-img.jpg"></p>

<div class="holder">
    <div class="container clearfix">
        <ul class="crumb clearfix">
            <li>首页
                <i class="fa fa-angle-double-right"></i>
            </li>
            <c:if test="${!empty productDto.fatherCategory}">
                <li>${productDto.fatherCategory}
                    <i class="fa fa-angle-double-right"></i>
                </li>
            </c:if>
            <c:if test="${!empty productDto.category}">
                <li>${productDto.category}
                    <i class="fa fa-angle-double-right"></i>
                </li>
            </c:if>
            <li class="orange">${productDto.name}</li>
        </ul>
        <div class="product-holder">
            <div class="holder-img">
                <img alt="商品图片" src="${productDto.url}"/>
            </div>
            <div class="holder-info">
                <form class="J_orderForm" action="${website}product/order/confirm" method="post">
                    <input type="hidden" value="${productDto.id}" name="productId" />
                    <h3>${productDto.name}</h3>

                    <p class="tip">${productDto.title}</p>

                    <p>
                        <span class="title">商品总金额：</span>
                        <span class="price bigger J_productPrice">￥${productDto.price}</span>
                    </p>

                    <p>
                        <label class="title">首付金额：</label>
                            <span class="price first-pay">
                                <input type="text" class="J_pay" data-valid-rule="isFloat" name="firstPay" value="0"/>元
                            </span>
                        <span class="J_errMsg error-tip">首付金额输入有误，请重新填写</span>
                    </p>

                    <p>
                        <input type="hidden" class="J_staging" name="payPeriods"/>
                        <label class="title">分期月数：</label>
									<span class="price staging-month">
										<a class="J_stagingMonth active" data-month="3" href="javascript:;">3个月</a>
										<a class="J_stagingMonth" data-month="6" href="javascript:;">6个月</a>
										<a class="J_stagingMonth" data-month="9" href="javascript:;">9个月</a>
										<a class="J_stagingMonth" data-month="12" href="javascript:;">12个月</a>
										<a class="J_stagingMonth" data-month="15" href="javascript:;">15个月</a>
										<a class="J_stagingMonth" data-month="18" href="javascript:;">18个月</a>
										<a class="J_stagingMonth" data-month="24" href="javascript:;">24个月</a>
									</span>
                    </p>

                    <p class="totol-holder">
                        <span>月供：￥</span>
                        <span class="J_monthlyRepay"></span>
                        <span class="J_priceTip">（本金:￥+服务费:￥）X </span>
                        <span class="J_stagingShow"></span>
                        <span>期</span>
                    </p>
                    <button <c:if test="${empty web_user_name}">class="J_filter"</c:if> type="submit">立即购买</button>
                </form>
            </div>
        </div>
        <div class="detail-holder">
            <div class="sub-nav">
                <h3>商品分类</h3>
                <input type="hidden" class="J_fatherId" value="1"/>
                <ul class="sub-nav-classify">
                    <c:forEach var="category" items="${productFatherCategoryList}">
                        <c:if test="${productDto.fatherCategoryId == category.id}">
                            <li><a href="${website}product/list?fcid=${category.id}&fc=${category.name}" class="active">${category.name}</a></li>
                        </c:if>
                        <c:if test="${productDto.fatherCategoryId != category.id}">
                            <li><a href="${website}product/list?fcid=${category.id}&fc=${category.name}">${category.name}</a></li>
                        </c:if>
                    </c:forEach>
                </ul>
                <h3 class="green-h3">本周热卖</h3>
                <ul class="hot-sales">
                    <c:forEach items="${productSalesList}" var="item">
                        <li class="clearfix">
                            <a class="img" href="${website}product/view/${item.id}" target="_blank">
                                <img src="${item.url}">
                            </a>
                            <a class="J_hotSaleTitle hot-sale-title"  href="${website}product/view/${item.id}" target="_blank">${item.name}</a>
                            <a class="hot-sale-count" href="javascript:void(0);">销量：${item.sales}</a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <div class="detail-info">
                <h3>商品详情</h3>

                <div class="detail-main">
                    ${productDto.desc}
                </div>
            </div>
        </div>
    </div>
</div>