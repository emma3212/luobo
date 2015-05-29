<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% // 用户中心 %>
<c:if test="${web_admin_vip_key eq 2}">
    <%@ include file="/WEB-INF/views/vip/common/sidebar.jsp" %>
</c:if>

<% // 管理员面板 %>
<c:if test="${web_admin_vip_key eq 1}">
    <%@ include file="/WEB-INF/views/admin/common/sidebar.jsp" %>
</c:if>


