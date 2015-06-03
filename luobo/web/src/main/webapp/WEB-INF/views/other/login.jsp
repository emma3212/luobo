<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
    <title>登录</title>
    <%@ include file="/WEB-INF/views/admin/common/head.jsp" %>
    <link rel="stylesheet" href="${staticWebsite}css/admin/page/login.css" />
</head>
<body>
<div class="header">
    <a class="logo" href="${website}index">
        <img src="${staticWebsite}img/admin/common/exchange.png" alt="" height="85">
    </a>
</div>
<div class="page">
    <div class="login-center">
        <div class="tab tab-horizon tab-red">
            <ul class="tab-nav btn-group clearfix">
                <li class="">
                    <a href="javascript:;">登录</a>
                </li>
            </ul>
            <div class="tab-panel tab-no-border">
                <div class="tab-content">
                    <div class="box-container">
                        <div class="box-body">
                            <h1>登录</h1>
                            <p class="msg-tip J_loginError"></p>
                            <form class="J_loginForm" action="${website}login" method="post">
                                <div class="control-group member-icon">
                                    <label class="control-label">用户名</label>
                                    <div class="controls">
                                        <input type="text" class="J_loginMobile" data-valid-rule="isMobile" data-valid-tip="请输入手机号码|手机号码错误,请重新填写" name="name"/>
                                    </div>
                                </div>
                                <div class="control-group password">
                                    <label class="control-label">密码</label>
                                    <div class="controls">
                                        <input type="password" class="J_pwd" data-valid-rule="length(7,16)" data-valid-tip="请输入8-15位字符|密码输入有误" name="pwd"/>
                                    </div>
                                </div>
                                <button type="submit" data-btn-type="loading" data-loading-text="正在提交，请稍后" class="btn btn-blue  btn-margin-right login-btn J_lgBtn">登&nbsp;&nbsp;录</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a href="${website}index" class="go-home"><i class="fa fa-home"></i></a>
    </div>
</div>
<div class="login-footer">
    <div class="login-footer-center">
        <div class="footer">
                    <span class="footer-inner">
                        2014 <span title="@2014">&copy;</span>倔强的萝卜.版权所有</span>
            <div class="footer-tools">
                        <span class="contact">
                            客服联系方式
                            <i class="fa fa-phone"></i>
                            158 4302 8477
                            <i class="fa fa-qq"></i>
                            361754796
                        </span>
            </div>
        </div>
    </div>
</div>
<script>
    KISSY.ready(function(S){
        S.use('widget/tab,widget/calendar', function(S){
        })
    })
</script>
</body>
</html>