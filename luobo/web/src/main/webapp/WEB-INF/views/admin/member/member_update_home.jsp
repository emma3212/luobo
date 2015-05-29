<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="admin">
    <tiles:putAttribute name="title" value="${webTitle}" />
    <tiles:putAttribute name="script" value="/WEB-INF/views/admin/member/inc/member_update_script.jsp" />
    <tiles:putAttribute name="body" value="/WEB-INF/views/admin/member/body/member_update_body.jsp" />
    <tiles:putAttribute name="extendHead" value="<link rel='stylesheet' href='${staticWebsite}css/vip/vip-check.css'>" />
</tiles:insertDefinition>
