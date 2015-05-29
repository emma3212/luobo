<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html>
<head>

</head>
<body>
     <p>会员号:${partyId}</p>
     <p>订单号:${orderId}</p>
     <p>需要支付:${needToPay}元</p>
     <p>使用支付宝支付：<a class="pay-now" type="button"
        href="${website}pay/order/${orderId}/orderpay?partyId=${partyId}&needToPay=${needToPay}&payTypeId=16&currencyId=1">立即支付</a>
     </p>
     <p>使用交通银行网银支付：<a class="pay-now" type="button"
        href="${website}pay/order/${orderId}/orderpay?partyId=${partyId}&needToPay=${needToPay}&payTypeId=2&currencyId=1">立即支付</a>
     </p>
</body>
</html>