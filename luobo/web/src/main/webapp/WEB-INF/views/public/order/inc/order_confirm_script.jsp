<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/javascript">
    KISSY.ready(function (S) {
        KISSY.use('page/confirm', function () {
            PW.page.Confirm({
                productOrderUrl: '${website}vip/product/order'
            });
        })
    })
</script>