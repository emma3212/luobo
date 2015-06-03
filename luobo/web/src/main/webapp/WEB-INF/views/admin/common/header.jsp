<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="header user-header">
    <a class="logo" href="${website}index">
        <img src="${staticWebsite}img/admin/common/exchange.png" alt="" height="70">
    </a>

    <div class="user-nav">

        <a class="dropdown" id="J_userInfo" data-dropdown-box="J_userMenu" data-dropdown-wait=".5">
            <i class="fa fa-user icon-margin-right"></i>${web_login_name}<i class="fa fa-caret-down press-right"></i>
        </a>

        <ul id="J_userMenu" class="dropdown-info">
      <%--      <li>

                <a href="${website}admin/user/profile"><i class="fa fa-user"></i>我的信息</a>
            </li>--%>
            <li>

                <a href="${website}logout"><i class="fa fa-key"></i>注销登录</a>
            </li>
        </ul>
    </div>
    <div class="dropdown-container manager">
        <a href="${website}index">返回网站首页</a>
    </div>
</div>
<script>
    KISSY.ready(function(S){
        S.use('widget/dropdown', function(){
        });
    })
</script>