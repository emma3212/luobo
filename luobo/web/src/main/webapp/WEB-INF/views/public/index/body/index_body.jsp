<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="banner">
    <div class="page clearfix">
        <!-- banner轮播 -->
        <div id="banner">
            <div class="box">
                <a <c:if test="${empty web_user_name}">class="J_filter"</c:if> href="${website}vip/any/repay">
                    <img src="${staticWebsite}img/pub/index/any-order.jpg" alt="随意还">
                </a>
            </div>
            <div class="box">
                <a <c:if test="${empty web_user_name}">class="J_filter"</c:if> href="${website}vip/white/bar/order/new">
                    <img src="${staticWebsite}img/pub/index/banner.jpg" alt="分期白条">
                </a>
            </div>
        </div>
        <div class="coutner-row">
            <ol id="counter">
                <li class="buttons hidden"></li>
            </ol>
        </div>
        <!-- 登录区域 -->
        <div class="login">
            <div class="login-box <c:if test="${!empty web_user_name}"> hidden</c:if>">
                <div class="tab tab-horizon tab-red">
                    <p class="J_loginError"></p>
                    <p class="J_registerError"></p>
                    <ul class="tab-nav btn-group clearfix">
                        <li class="active">
                            <a class="J_tabLoginBtn" href="javascript:;">会员登录</a>
                        </li>
                        <li class="li-last">
                            <a class="J_tabRegisterBtn" href="javascript:;">会员注册</a>
                        </li>
                    </ul>

                    <div class="tab-panel tab-no-border">
                        <div class="tab-content">
                            <div class="box-container">
                                <div class="box-body">
                                    <form class="J_loginForm" action="" method="">
                                        <div class="input-group margin-top-15">
														<span class="input-group-addon">
															<i class="fa fa-user"></i>
														</span>
                                            <input type="text" class="J_loginMobile user" placeholder="手机号" data-valid-rule="isMobile" name="username" />
                                        </div>
                                        <div class="input-group margin-top-10">
														<span class="input-group-addon">
															<i class="fa fa-unlock-alt"></i>
														</span>
                                            <input type="password" class="J_pwd pwd" placeholder="密码" data-valid-rule="length(7,16)" name="password"/>
                                        </div>
                                        <div class="clearfix">
                                            <div class="input-group valid-code margin-top-10">
															<span class="input-group-addon">
																<i class="fa fa-check-square-o"></i>
															</span>
                                                <input type="text" class="valid-code J_valid valid" placeholder="验证码" name="valid" />
                                            </div>
                                            <img class="margin-top-10 valid-img  J_validCode J_codeImg hidden" src="${website}Kaptcha.jpg" alt="验证码">
                                        </div>
                                        <div class="oper clearfix margin-top-8">
                                            <label class="remember checkbox-container">
                                                <input type="checkbox" class="check-box J_checkbox" name="remember" value="true"/>
                                            </label>
                                            <span>记住我一个月</span>
                                            <a class="forget J_forgetEl" href="javascript:;">忘记密码？</a>
                                        </div>
                                        <button type="submit" class="btn J_lgBtn submit-btn margin-top-10" data-btn-type="loading" data-loading-text="正在提交，请稍后">
                                            登&nbsp;&nbsp;录
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="tab-content">
                            <div class="box-container">
                                <div class="box-body">
                                    <form class="J_registerForm" action="" method="">
                                        <div class="input-group margin-top-15">
														<span class="input-group-addon">
															<i class="fa fa-user"></i>
														</span>
                                            <input type="text" class="J_registerMobile user" placeholder="手机号" data-valid-rule="isMobile" name="mobile" />
                                        </div>
                                        <div class="clearfix">
                                            <div class="input-group valid-code margin-top-10">
															<span class="input-group-addon">
																<i class="fa fa-check-square-o"></i>
															</span>
                                                <input type="text" class="valid-code J_registerValid valid" placeholder="验证码" name="valid"/>
                                            </div>
                                            <img class="margin-top-10 valid-img J_registerCodeImg  hidden" src="${website}Kaptcha.jpg" alt="验证码">
                                        </div>
                                        <button type="submit" class="btn J_registerBtn submit-btn margin-top-10" data-btn-type="loading" data-loading-text="正在提交，请稍后">
                                            注&nbsp;&nbsp;册
                                        </button>
                                        <div class="register-tip">
                                            请填写手机号和验证码，首次登陆密码会通过短信发送到手机中，登陆后可修改密码
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 登录成功 -->
            <div class="login-success <c:if test="${empty web_user_name}">hidden</c:if>">
                <h1>巨汇分期欢迎你,${web_user_name}</h1>
                <div class="enter clearfix">
                    <img src="${staticWebsite}img/pub/index/welcome.jpg" alt="">
                    <ul>
                        <c:if test="${web_admin_vip_key eq 2}">
                            <li><a href="${website}home">会员中心面板</a></li>
                            <li><a href="${website}vip/product/order">商品订单查询</a></li>
                            <li><a href="${website}vip/white/bar/order">白条订单查询</a></li>
                            <li><a href="${website}vip/any/repay/list">随意还订单查询</a></li>
                            <li><a href="${website}vip/user/profile">编辑会员档案</a></li>
                            <li><a href="${website}logout">注销登录</a></li>
                        </c:if>
                        <c:if test="${web_admin_vip_key eq 1}">
                            <li><a href="${website}home">管理员面板</a></li>
                            <li><a href="${website}admin/user/profile">编辑管理员档案</a></li>
                            <li><a href="${website}logout">注销登录</a></li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 三个大广告 -->
<div class="page ads-list clearfix">
    <a class="ads margin-top-30 margin-right-20" href="${website}content/6" target="_blank">
        <img src="${staticWebsite}img/pub/index/ads-1.jpg" alt="">
    </a>
    <a class="ads margin-top-30 margin-right-20" href="${website}content/7" target="_blank">
        <img src="${staticWebsite}img/pub/index/ads-2.jpg" alt="">
    </a>
    <a class="ads ads-last margin-top-30 margin-right-20" href="${website}content/8" target="_blank">
        <img src="${staticWebsite}img/pub/index/ads-3.jpg" alt="">
    </a>
</div>
<div class="page recommend-sale margin-bottom-30 clearfix">
    <!-- 新品推荐 -->
    <div id="recommend" class="recommend margin-top-20 clearfix">
        <div class="recommend-title clearfix">
            <h1 class="title"><span>新品</span>&nbsp;推荐</h1>
            <div class="btn-group-oper">
                <i id="previous" class="fa fa-arrow-circle-o-left"></i>
                <i id="next" class="fa fa-arrow-circle-o-right"></i>
            </div>
        </div>
        <c:forEach items="${newProductList}" var="item" varStatus="v">
            <c:if test="${v.index%2==0}"><div class="recommend-list clearfix"></c:if>
                <a class="recommend-view <c:if test="${v.index%2==1}">recommend-view-last</c:if>" href="${website}product/view/${item.pid}"  target="_blank">
                    <img src="${item.url}" alt="">
                </a>
            <c:if test="${v.index%2==1 or v.last}"></div></c:if>
        </c:forEach>
    </div>
    <!-- 促销商品 -->
    <div class="sales margin-top-20">
        <div class="sale-title clearfix">
            <h1 class="title"><span>促销</span>&nbsp;商品</h1>
            <div class="btn-group-oper">
                <i id="previousV" class="fa fa-arrow-circle-o-left"></i>
                <i id="nextV" class="fa fa-arrow-circle-o-right"></i>
            </div>
        </div>
        <div id="sale" class="sale">
            <c:forEach items="${saleProductList}" var="item" varStatus="v">
                <c:if test="${v.index%2==0}"><div class="sale-list clearfix"></c:if>
                    <a class="sale-view <c:if test="${v.index%2==1}">sale-view-last</c:if>" href="${website}product/view/${item.pid}" target="_blank">
                        <img src="${item.url}" alt="">
                    </a>
                <c:if test="${v.index%2==1 or v.last}"></div></c:if>
            </c:forEach>
        </div>
    </div>
</div>
<!-- 精选商品 -->
<div class="page select clearfix">
    <div id="select">
        <div class="title">
            <h1>
                <span>精选</span>&nbsp;商品
            </h1>
            <div class="btn-group-oper">
                <i id="selectPrevious" class="fa fa-arrow-circle-o-left"></i>
                <i id="selectNext" class="fa fa-arrow-circle-o-right"></i>
            </div>
        </div>
        <c:forEach items="${selectedProductList}" var="item" varStatus="v">
            <c:if test="${v.index%8==0}"><div class="select-list"></c:if>
                <a class="select-view <c:if test="${v.index%4==3}">select-view-last</c:if>" href="${website}product/view/${item.pid}" target="_blank">
                    <img src="${item.url}" alt="">
                </a>
            <c:if test="${v.index%8==7 or v.last}"></div></c:if>
        </c:forEach>
    </div>
</div>
<!-- 随意还 -->
<div class="page borrow clearfix">
    <div class="title">
        <h1>
            <span class="title-color">随意还</span><span>校园消费&nbsp;全网购物</span>
        </h1>
    </div>
    <div class="borrow-list-logo clearfix">
        <div class="borrow-list">
            <div class="borrow-activity-list clearfix">
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-1.jpg" alt="">
                </a>
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-2.jpg" alt="">
                </a>
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-3.jpg" alt="">
                </a>
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-4.jpg" alt="">
                </a>
                <a class="borrow-view borrow-view-last" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-5.jpg" alt="">
                </a>
            </div>
            <div class="borrow-logo-list clearfix">
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/taobao.jpg" alt="">
                </a>
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/meituan.jpg" alt="">
                </a>
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/jumei.jpg" alt="">
                </a>
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/vip.jpg" alt="">
                </a>
                <a class="borrow-logo borrow-logo-last" href="">
                    <img src="${staticWebsite}img/pub/index/1haodian.jpg" alt="">
                </a>
            </div>
        </div>
        <div class="borrow-list borrow-list-last">
            <div class="borrow-activity-list clearfix">
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-6.jpg" alt="">
                </a>
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-7.jpg" alt="">
                </a>
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-8.jpg" alt="">
                </a>
                <a class="borrow-view" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-9.jpg" alt="">
                </a>
                <a class="borrow-view borrow-view-last" href="">
                    <img src="${staticWebsite}img/pub/index/borrow-10.jpg" alt="">
                </a>
            </div>
            <div class="borrow-logo-list clearfix">
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/suning.jpg" alt="">
                </a>
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/jd.jpg" alt="">
                </a>
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/ctrip.jpg" alt="">
                </a>
                <a class="borrow-logo" href="">
                    <img src="${staticWebsite}img/pub/index/tuanbaobao.jpg" alt="">
                </a>
            </div>
        </div>
    </div>
</div>