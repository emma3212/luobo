<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="${staticWebsite}js/weixin/list.js"></script>
<script type="text/javascript">
    $().ready(function () {
        $.list.init({
            //获取分页url
            getListUrl: '${website}wechat/order/product/ajax/list/${openId}',
            //跳转详情url
            detailUrl: '${website}wechat/order/product/${openId}'
        })
    })
</script>