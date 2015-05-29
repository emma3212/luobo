<%@ page contentType="text/html; charset=UTF-8"%>
<!doctype html>
<html>
<head>
    <title>会员中心首页</title>
    <!--#include file="/pages/admin/common/user-head.html"-->
</head>
<body>
<p>会员号:${partyId}</p>
<p>订单号:${orderId}</p>
<p>成功支付:${payMoney}元</p>
<!--#include file="/pages/admin/common/user-header.html"-->
<div class="page">
    <div class="holder">
        <div class="content">
            <div class="alert alert-success">
                <strong>恭喜您！支付成功！</strong> 请返回订单详情页面，点击“已完成支付”，并关闭该页面。
            </div>
        </div>
    </div>
</div>
<!--#include file="/pages/admin/common/user-footer.html"-->
</body>
</html>