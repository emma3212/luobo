<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="pub">
    <tiles:putAttribute name="title" value="${webTitle}"/>
    <tiles:putAttribute name="extendHead" value="<link rel='stylesheet' href='${staticWebsite}tool/base-widget/css/form.css'>
                                                <link rel='stylesheet' href='${staticWebsite}css/pub/page/index.css'>"/>
    <tiles:putAttribute name="body" value="/WEB-INF/views/public/index/body/index_body.jsp"/>
    <tiles:putAttribute name="script" value="/WEB-INF/views/public/index/inc/index_script.jsp"/>
</tiles:insertDefinition>