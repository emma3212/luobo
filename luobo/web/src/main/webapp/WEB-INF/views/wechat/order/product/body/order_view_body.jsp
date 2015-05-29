<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="page">
    <a href="javascript:;" class="logo"></a>

    <h3 class="lighter-black">商品信息</h3>
    <ul class="order-list detail">
        <li>
            <span class="first-span">商品名称</span>
            <span>${productOrderDto.productName}</span>
        </li>
        <li>
            <span class="first-span">价格</span>
            <span>${productOrderDto.productPrice}</span>
        </li>
        <li>
            <span class="first-span">首付</span>
            <span>${productOrderDto.firstPay}</span>
        </li>
        <li>
            <span class="first-span">状态</span>
            <span>${productOrderDto.statusStr}</span>
        </li>
    </ul>
    <h3 class="lighter-black">还款信息</h3>

    <div class="list-holder">
        <ul class="order-list">
            <li>
                <span class="first-col">最后期限</span>
                <span>计划还款金额</span>
                <span>状态</span>
            </li>
            <c:forEach var="repay" items="${repayList}">
                <li>
                    <span class="first-col"><fmt:formatDate value="${repay.repayDeadline}" pattern="yyyy-MM-dd"/> </span>
                    <span>&nbsp;${repay.planRepayMoney}</span>
                    <span>
                        <c:if test="${repay.status == 0}">
                            未还款
                        </c:if>
                        <c:if test="${repay.status == 1}">
                            已还款
                        </c:if>
                    </span>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>