<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
    <title><tiles:insertAttribute name="title" /></title>
    <tiles:insertAttribute name="head" />
    <tiles:insertAttribute name="extendHead" />
</head>
<body>
    <tiles:insertAttribute name="body" />
    <tiles:insertAttribute name="script" />
</body>
</html>