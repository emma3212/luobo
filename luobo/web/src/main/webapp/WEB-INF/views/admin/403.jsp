<%@ page  contentType="text/html; charset=UTF-8"%>
<!doctype html>
<head>
    <title>${webTitle} -- 403</title>
    <link rel="stylesheet" href="${staticWebsite}css/base/reset.css" />
    <link rel="stylesheet" href="${staticWebsite}tool/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${staticWebsite}tool/base-widget/css/font-awesome.css" />
    <link rel="stylesheet" href="${staticWebsite}css/admin/page/index/new-error.css">
</head>
<body>
<div class="main">
    <div class="container page-text">
        <div class="row">
            <div class="col-sm-12">
                <h1 class="rotate">403!</h1>
					<span>资源请求失败，服务器未返回您所需要的资源，请重试。<br>
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
                        <li><a href="${website}index">首页</a></li>
                        <li><a href="#">免费IT维护</a></li>
                        <li><a href="#">IT产品直送</a></li>
                        <li><a href="#">帮助与支持</a></li>
                        <!-- end menu links -->
                    </ul>
                </div>
            </div>
            <div class="col-md-6">
                <div class="socila-container clearfix">
                    <ul class="social pull-right">
                        <!-- start social links -->
                        <li><a href="#"><i class="fa fa-weibo"></i></a></li>
                        <li><a href="#"><i class="fa fa-tencent-weibo"></i></a></li>
                        <li><a href="#"><i class="fa fa-weixin"></i></a></li>
                        <!-- end social links -->
                    </ul>
                </div>
                <div class="copyright pull-right">Copyright 2014 &copy; 北京广德腾建博曼科技有限公司.</div>
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
    String message = "403|" + url + "|" + referer +  "|" + ip + "|" + requestMethod;
    com.pandawork.core.log.LogClerk.monitorLog.debug(message);
%>