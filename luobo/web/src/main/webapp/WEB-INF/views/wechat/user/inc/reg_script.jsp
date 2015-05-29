<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/javascript">
    $().ready(function () {
        $.register.init({
            //发送手机号码路径
            sendMobileUrl: '${website}wechat/user/reg/ajax/mobile/exist'
        })
    })
</script>