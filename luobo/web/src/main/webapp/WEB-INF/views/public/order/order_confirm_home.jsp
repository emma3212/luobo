<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="pub">
    <tiles:putAttribute name="title" value="${webTitle}"/>
    <tiles:putAttribute name="extendHead" value="<link href='${staticWebsite}css/pub/page/confirm.css' rel='stylesheet'>" />

    <tiles:putAttribute name="body" value="/WEB-INF/views/public/order/body/order_confirm_body.jsp"/>
    <tiles:putAttribute name="script" value="/WEB-INF/views/public/order/inc/order_confirm_script.jsp" />
</tiles:insertDefinition>