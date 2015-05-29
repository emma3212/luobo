<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
    <title>登录页面</title>
    <%@ include file="/WEB-INF/views/admin/common/head.jsp" %>
    <link rel="stylesheet" href="${staticWebsite}css/admin/page/login.css" />
</head>
<body>
<div class="header">
    <a class="logo" href="${website}">
        <img src="${staticWebsite}img/admin/common/transparent-logo.png" alt="" height="58">
    </a>
</div>
<div class="page">
    <div class="login-center">
        <div class="tab tab-horizon tab-red">
            <ul class="tab-nav btn-group clearfix">
                <li class="active">
                    <a href="javascript:;">会员登录</a>
                </li>
                <li class="">
                    <a href="javascript:;">会员注册</a>
                </li>
            </ul>

            <div class="tab-panel tab-no-border">
                <div class="tab-content">
                    <div class="box-container">
                        <div class="box-body">
                            <h1>登录会员中心</h1>
                            <p class="msg-tip J_loginError"></p>
                            <form class="J_loginForm" action="${website}login" method="post">
                                <div class="control-group member-icon">
                                    <label class="control-label">手机号码</label>
                                    <div class="controls">
                                        <input type="text" class="J_loginMobile" data-valid-rule="isMobile" data-valid-tip="请输入手机号码|手机号码错误,请重新填写" name="username"/>
                                    </div>
                                </div>
                                <div class="control-group password">
                                    <label class="control-label">密码</label>
                                    <div class="controls">
                                        <input type="password" class="J_pwd" data-valid-rule="length(7,16)" data-valid-tip="请输入8-15位字符|密码输入有误" name="password"/>
                                    </div>
                                </div>
                                <div class="control-group code">
                                    <label class="control-label">验证码</label>
                                    <div class="controls">
                                        <input type="text" class="J_valid"  name="valid"/>
                                    </div>
                                </div>
                                <img id="J_img" class="code-img hidden J_codeImg" href="${website}Kaptcha.jpg" alt="验证码">
                                <a class="refresh hidden J_validCode" href="#">刷新</a>
                                <div class="tips">
                                            <span class="checkbox-container checkbox-checked">
                                                <input type="checkbox" class="J_checkbox" checked="checked" name="remember" value="true" />
                                            </span>
                                    <span class="remember">记住我的登录信息</span>
                                    <a href="javascript:;" class="login-qq">
                                        用QQ企业账号登录
                                    </a>
                                </div>
                                <button type="submit" data-btn-type="loading" data-loading-text="正在提交，请稍后" class="btn btn-blue  btn-margin-right login-btn J_lgBtn">登&nbsp;&nbsp;录</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="tab-content">
                    <div class="box-container">
                        <div class="box-body">
                            <h1>注册会员</h1>
                            <!-- <a href="javascript:;" class="register-tip">注册会员</a>  -->
                            <p class="register-err-tip J_registerError"></p>
                            <form class="J_registerForm" action="${website}login" method="get">
                                <div class="control-group member-icon">
                                    <label class="control-label">手机号码</label>
                                    <div class="controls">
                                        <input type="text" class="J_registerMobile" data-valid-rule="isMobile" data-valid-tip="请输入手机号码|手机号码错误,请重新填写" name="mobile"/>
                                    </div>
                                </div>
                                <div class="control-group code">
                                    <label class="control-label">验证码</label>
                                    <div class="controls">
                                        <input type="text" class="J_registerValid"  name="valid"/>
                                    </div>
                                </div>
                                <img class="code-img hidden J_registerCodeImg" href="${website}Kaptcha.jpg" alt="验证码">
                                <a class="refresh hidden J_validRegisterCode" href="#">刷新</a>
                                <button type="submit" data-btn-type="loading" data-loading-text="正在提交，请稍后" class="btn btn-blue  btn-margin-right register-btn J_registerBtn">注&nbsp;&nbsp;册</button>
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
                        2014 <span title="@2014">&copy;</span>长春市巨汇网络科技有限公司.版权所有</span>
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
        S.use('page/index/login, widget/tab', function(S){
            PW.page.index.Login();
        })
    })
</script>
</body>
</html>