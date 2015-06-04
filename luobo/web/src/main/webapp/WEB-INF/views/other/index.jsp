<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
    <title>首页</title>
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
                <li class="active">
                    <a href="javascript:;">货币兑换</a>
                </li>
            </ul>
            <div class="tab-panel tab-no-border">
                <div class="tab-content">
                    <div class="box-container">
                        <div class="box-body">
                            <h1>货币兑换</h1>
                            <p class="msg-tip J_loginError"></p>
                            <form class="J_registerForm" action="${website}index" method="post">
                                <div class="control-group member-icon">
                                    <label class="control-label">原货币</label>
                                    <div class="controls">
                                        <select class="J_brand" data-valid-tip="|原始货币选择有误，请重新选择" data-valid-rule="scale(0,1000)" name="fromCurrencyId">
                                            <option value="0">--请选择--</option>
                                            <c:forEach items="${currencyList}" var="item">
                                                <option value="${item.id}" <c:if test="${item.id == rate.fromCurrencyId}">selected="selected"</c:if>>${item.name} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group password">
                                    <label class="control-label">目标货币</label>
                                    <div class="controls">
                                        <select class="J_brand" data-valid-tip="|原始货币选择有误，请重新选择" data-valid-rule="scale(0,1000)" name="toCurrencyId">
                                            <option value="0">--请选择--</option>
                                            <c:forEach items="${currencyList}" var="item">
                                                <option value="${item.id}" <c:if test="${item.id == rate.toCurrencyId}">selected="selected"</c:if>>${item.name} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group password">
                                    <label class="control-label">日期</label>
                                    <div class="controls">
                                        <input type="text" data-type="date" data-format="YYYY-MM-DD"  class="w200" name="date" value="${rate.dateString}" />
                                    </div>
                                </div>
                                <div class="control-group password">
                                    <label class="control-label">兑换金额</label>
                                    <div class="controls">
                                        <input type="text" class="J_pwd" data-valid-rule="length(7,16)" data-valid-tip="请输入8-15位字符|密码输入有误" name="money" value="${money}"/>
                                    </div>
                                </div>
                                <button type="submit" data-btn-type="loading" data-loading-text="正在提交，请稍后" class="btn btn-blue  btn-margin-right login-btn J_lgBtn">计算</button>
                            </form>
                            <c:if test="${result!=null}">
                                <div class="control-group password">
                                    <label class="control-label" style="color:red;">兑换结果</label>
                                    <div class="controls">
                                            ${money}   ${rate.fromCurrency}  = ${result}   ${rate.toCurrency}
                                    </div>
                                </div>
                                <div class="control-group password">
                                    <label class="control-label " style="color:red;">汇率</label>
                                    <div class="controls">
                                        ${rate.rate}
                                    </div>
                                </div>
                            </c:if>
                            </div>
                    </div>
                </div>
            </div>
        </div>
        <a href="${website}index" class="go-home"><i class="fa fa-home"></i></a>
        <a href="${website}login" class="go-home"><i class="fa fa-home"></i></a>
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