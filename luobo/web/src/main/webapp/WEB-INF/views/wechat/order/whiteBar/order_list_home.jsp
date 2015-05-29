<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<tiles:insertDefinition name="wechat">
    <tiles:putAttribute name="title" value="${webTitle}"/>

    <tiles:putAttribute name="extendHead"
                        value="<link rel='stylesheet' type='text/css' href='${staticWebsite}css/weixin/module/iscroll.css' />
                        <script src='${staticWebsite}js/weixin/iscroll.js'></script>"/>

    <tiles:putAttribute name="body" value="/WEB-INF/views/wechat/order/whiteBar/body/order_list_body.jsp"/>
    <tiles:putAttribute name="script" value="/WEB-INF/views/wechat/order/whiteBar/inc/order_list_script.jsp"/>
</tiles:insertDefinition>