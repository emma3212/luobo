<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="admin">
    <tiles:putAttribute name="title" value="${webTitle}" />
    <tiles:putAttribute name="body" value="/WEB-INF/views/admin/currency/body/currency_body.jsp" />
    <tiles:putAttribute name="script" value="/WEB-INF/views/admin/currency/inc/currency_script.jsp" />
</tiles:insertDefinition>