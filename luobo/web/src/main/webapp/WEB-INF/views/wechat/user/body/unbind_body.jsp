<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="page">
    <form class="J_validForm" autoComplete="off" action="${website}wechat/user/unbind" method="post">
        <input type="hidden" value="${openId}" name="openId" />
        <div>
            <a href="javascript:;" class="logo"></a>

            <h3 class="lighter-black">解绑会员</h3>

            <div class="padding-reset">
                <div class="border-slide control-group">
                    <label class="lighter-black">手机号码</label>

                    <div class="control">
                        <input type="text" placeholder="请输入手机号码" class="no-border J_mobile" name="mobile"/>
                    </div>
                </div>
                <div class="border-slide control-group">
                    <label class="lighter-black">密码</label>

                    <div class="control">
                        <input type="password" placeholder="请输入密码" class="no-border J_pwd" name="password"/>
                    </div>
                </div>
                <div class="control-group">
                    <label class="lighter-black">验证码</label>

                    <div class="control code-inp">
                        <input type="text" class="no-border J_code" name="valid"/>
                    </div>
                    <img class="code-img J_codeImg" src="${website}Kaptcha.jpg"
                         href="${website}Kaptcha.jpg" alt="验证码">
                    <a class="refresh J_validCode" href="#">刷新</a>
                </div>
            </div>
            <button type="submit" class="form-btn-submit middle bigger-font un-bind">解除绑定</button>
    </form>
</div>
<div data-role="popup" class="ui-content" data-position-to="origin" data-overlay-theme="a" id="popupBasic">
    <a class="ui-btn ui-corner-all ui-shadow ui-btn-a ui-icon-delete ui-btn-icon-notext ui-btn-right" data-rel="back"
       href="#">Close</a>

    <p>This is a completely basic popup, no options set.</p>
</div>
</div>