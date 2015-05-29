<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="page">
    <a href="javascript:;" class="logo"></a>

    <h3 class="lighter-black">随意还信息</h3>
    <ul class="order-list detail">
        <li>
            <span class="first-span">金额</span>
            <span>${anyRepayOrderDto.applyMoney}</span>
        </li>
        <li>
            <span class="first-span">应还金额</span>
            <span>${anyRepayOrderDto.shouldRepayMoney}</span>
        </li>
        <li>
            <span class="first-span">实际还款金额</span>
            <span>${anyRepayOrderDto.actualRepayMoney}</span>
        </li>
        <li>
            <span class="first-span">状态</span>
            <span>${anyRepayOrderDto.statusStr}</span>
        </li>
        <li>
            <span class="first-span">生效日期</span>
            <span>${anyRepayOrderDto.startTimeStr}</span>
        </li>
        <li>
            <span class="first-span">下单日期</span>
            <span>${anyRepayOrderDto.createdTimeStr}</span>
        </li>
        <li>
            <span class="first-span">还款日期</span>
            <span>${anyRepayOrderDto.actualRepayDate}</span>
        </li>
        <li>
            <span class="first-span reason">借款用途</span>
            <span>${anyRepayOrderDto.reason}</span>
        </li>
    </ul>
</div>