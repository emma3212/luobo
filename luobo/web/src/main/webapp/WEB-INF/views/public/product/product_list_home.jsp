<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="pub">
    <tiles:putAttribute name="title" value="${webTitle}" />
    <tiles:putAttribute name="extendHead" value="
                                         <link href='${staticWebsite}css/pub/page/classify.css' rel='stylesheet'>"/>
    <tiles:putAttribute name="body" value="/WEB-INF/views/public/product/body/product_list_body.jsp" />
    <tiles:putAttribute name="script" value="/WEB-INF/views/public/product/inc/product_list_script.jsp" />
</tiles:insertDefinition>