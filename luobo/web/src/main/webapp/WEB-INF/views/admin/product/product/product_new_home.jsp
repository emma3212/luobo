<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="admin">
    <tiles:putAttribute name="title" value="${webTitle}" />
    <tiles:putAttribute name="extendHead" value="<script src='${staticWebsite}tool/ckeditor/ckeditor.js'></script>"/>
    <tiles:putAttribute name="body" value="/WEB-INF/views/admin/product/product/body/product_new_body.jsp" />
    <tiles:putAttribute name="script" value="/WEB-INF/views/admin/product/product/inc/product_new_script.jsp"/>
</tiles:insertDefinition>

