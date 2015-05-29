<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="vip">
    <tiles:putAttribute name="title" value="${webTitle}" />
    <tiles:putAttribute name="body" value="/WEB-INF/views/vip/index/body/home_body.jsp" />
    <tiles:putAttribute name="extendHead" value="<link rel='stylesheet' href='${staticWebsite}tool/base-widget/css/dashboard.css'>" />
</tiles:insertDefinition>