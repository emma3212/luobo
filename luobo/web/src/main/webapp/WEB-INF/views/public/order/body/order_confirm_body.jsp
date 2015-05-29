<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<p class="ads"><img src="${staticWebsite}img/pub/page/confirm/ads-img.jpg"></p>

<div class="holder">
    <div class="container clearfix">
        <c:if test="${memberInfo.status != 1}">
            <p class="note">会员使用分期业务，需要通过身份审核认证，联系方式及收货地址等信息与认证信息一致，如果需要修改已经通过的会员身份认证信息，请拨打巨汇400电话联系客服：4006467456</p>
        </c:if>
        <h2>收货信息</h2>

        <div class="user-info">
            <p>
                <span>收货人：</span>
                <span>${memberInfo.name}</span>
            </p>

            <p>
                <span>学校地址：</span>
                <span>${memberInfo.schoolOrCompanyAdd}</span>
            </p>

            <p>
                <span>寝室地址：</span>
                <span>${memberInfo.presentAddress}</span>
            </p>

            <p>
                <span>手机号码：</span>
                <span>${memberInfo.mobile}</span>
            </p>
        </div>
        <h2>商品信息</h2>
        <table>
            <thead>
            <th>商品</th>
            <th>价格</th>
            <th>首付</th>
            <th>分期数</th>
            <th>月供</th>
            <th></th>
            </thead>
            <tbody>
            <tr>
                <td class="product-name">
                    <a class="orange" href="${website}product/view/${productId}">${productTitle}</a>
                </td>
                <td>${productPrice}</td>
                <td>${firstPay}</td>
                <td>${payPeriods}个月</td>
                <td>本金：${principal}+服务费：${serviceCharge} = ${monthlyRepay}元</td>
                <td><a class="orange" href="${website}product/view/${productId}">返回修改</a></td>
            </tr>
            </tbody>
        </table>
        <form class="J_orderForm" action="" method="">
            <div class="control-group">
                <label class="control-label">
                    用户备注
                </label>

                <div class="controls">
                    <textarea type="text" value="" name="userComment" data-valid-rule="isNull|length(0,201)"
                              data-valid-tip="请输入您的备注|您的备注过多，请重新填写" class="w250 valid-icon"></textarea>
                </div>
            </div>

            <input type="hidden" name="productId" value="${productId}">
            <input type="hidden" name="firstPay" value="${firstPay}">
            <input type="hidden" name="payPeriods" value="${payPeriods}">

            <div class="order-msg">
                <p>
                    <span class="title">商品总金额：</span>
                    <span class="price">${productPrice}元</span>
                </p>

                <p>
                    <span class="title">首付金额：</span>
                    <span class="price">${firstPay}元</span>
                </p>

                <p class="total">
                    <span class="title">总计分期金额：</span>
                    <span class="bigger">${totalPayMoney}元</span>
                </p>

                <p class="orange">(本金：￥${principal}+服务费：￥${serviceCharge}) × ${payPeriods}期 = ${totalShouldRepayMoney}元</p>
                <button <c:if test="${empty web_user_name}">class="J_filter"</c:if> type="submit">提交订单</button>
            </div>
        </form>
    </div>
</div>