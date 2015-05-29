<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>

<tiles:insertDefinition name="wechat">
    <tiles:putAttribute name="title" value="${webTitle}"/>
    <tiles:putAttribute name="extendHead" value="<script src='${staticWebsite}js/weixin/register.js'></script>" />
    <tiles:putAttribute name="body" value="/WEB-INF/views/wechat/user/body/reg_body.jsp"/>
    <tiles:putAttribute name="script" value="/WEB-INF/views/wechat/user/inc/reg_script.jsp" />
</tiles:insertDefinition>