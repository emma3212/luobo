<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<tiles:insertDefinition name="vip">
  <tiles:putAttribute name="title" value="${webTitle}" />
  <tiles:putAttribute name="body" value="/WEB-INF/views/vip/memberProfile/body/memberProfile_body.jsp" />
  <tiles:putAttribute name="script" value="/WEB-INF/views/vip/memberProfile/inc/memberProfile_script.jsp" />
</tiles:insertDefinition>