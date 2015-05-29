<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!doctype html>
<html>
<head>

</head>
<body>
${url}
     <input type="hidden" id="formStr" value="" />
<script type="text/javascript">
     var formStr = document.getElementById('formStr').val();
     document.write(formStr);
//     document.forms['alipaysubmit'].submit();
</script>
</body>
</html>