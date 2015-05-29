<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="vip">
    <tiles:putAttribute name="title" value="${webTitle}"/>
    <tiles:putAttribute name="body" value="/WEB-INF/views/vip/order/product/body/order_view_body.jsp"/>
    <tiles:putAttribute name="script" value="/WEB-INF/views/vip/order/product/inc/order_view_script.jsp"/>
</tiles:insertDefinition>