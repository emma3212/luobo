<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="vip">
    <tiles:putAttribute name="title" value="${webTitle}"/>
    <tiles:putAttribute name="extendHead" value="<link rel='stylesheet' href='${staticWebsite}css/vip/vip-check.css'>"/>
    <tiles:putAttribute name="body" value="/WEB-INF/views/vip/member/body/info_check_body.jsp"/>
    <tiles:putAttribute name="script" value="/WEB-INF/views/vip/member/inc/info_check_script.jsp"/>
</tiles:insertDefinition>