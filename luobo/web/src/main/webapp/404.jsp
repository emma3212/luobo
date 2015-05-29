<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>404</title>
	<%@include file="/WEB-INF/views/common/head.jsp"%>
	<link rel="stylesheet" href="${staticWebsite}css/admin/common/new-error.css">
	
</head>
<body>
	<div class="main">
		<div class="container page-text">
			<div class="row">
				<div class="col-sm-12">
					<h1 class="rotate">404!</h1>
					<span><c:if test="${empty eMsg}">我们无法找到您所请求的页面！</c:if><c:if test="${!empty eMsg}">${eMsg}</c:if><br>
						请点击这里返回 <a href="${website}index">首页</a>，或者继续浏览其他页面。</span>
				</div>
			</div>
		</div>
	</div>
	<div class="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<div class="menu-container clearfix">
						<ul class="menu">
							<!-- start menu links -->
							<!-- replace the # with menu links -->
							<li><a href="${website}">首页</a></li>
							<li><a href="${website}home">我的会员中心</a></li>
							<li><a href="${website}vip/white/bar/order/new">申请随意还</a></li>
							<li><a href="${website}vip/any/repay">申请白条</a></li>
							<li><a href="javascript:alert('看到的，联系一下，这块还没有')">分期介绍</a></li>
							<!-- end menu links -->
						</ul>
					</div>
				</div>
				<div class="col-md-6">
					<div class="socila-container clearfix">
						<ul class="social pull-right">
							<!-- start social links -->
							<!-- replace the # with your own profile link address -->
							<li><a href="#"><i class="fa fa-weibo"></i></a></li>
							<li><a href="#"><i class="fa fa-tencent-weibo"></i></a></li>
							<li><a href="#"><i class="fa fa-weixin"></i></a></li>
							<!-- end social links -->
						</ul>
					</div>
					<div class="copyright pull-right">Copyright 2015 &copy; 长春巨汇网络科技有限公司.</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%
	String url = "http://"+request.getServerName()+ "/" + (String)request.getAttribute("javax.servlet.error.request_uri")+
			(request.getQueryString()==null?"":("?"+request.getQueryString()));
	String referer = request.getHeader("Referer");
	String ip = com.pandawork.core.util.IpUtil.getClientIP(request);
	String requestMethod = request.getMethod();
	String message = "404|" + url + "|" + referer +  "|" + ip + "|" + requestMethod;
	com.pandawork.core.log.LogClerk.monitorLog.debug(message);
%>
