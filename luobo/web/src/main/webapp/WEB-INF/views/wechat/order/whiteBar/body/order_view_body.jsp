<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="page">
    <a href="javascript:;" class="logo"></a>

    <h3 class="lighter-black">白条信息</h3>
    <ul class="order-list detail">
        <li>
            <span class="first-span">金额</span>
            <span>${whiteBarOrderDto.amount}</span>
        </li>
        <li>
            <span class="first-span">状态</span>
            <span>${whiteBarOrderDto.statusStr}</span>
        </li>
    </ul>
    <h3 class="lighter-black">还款信息</h3>

    <div class="list-holder">
        <ul class="order-list">
            <li>
                <span class="first-col">最后期限</span>
                <span>金额</span>
                <span>状态</span>
            </li>
            <c:forEach var="repay" items="${repayList}">
                <li>
                    <span class="first-col"><fmt:formatDate value="${repay.repayDeadline}" pattern="yyyy-MM-dd" /></span>
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