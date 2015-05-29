<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/template" id="tpl">
    {@each list as it}
    {@if it.isOverdue == 1}
        <tr data-order-id="&{it.id}" class="error-tip">
    {@/if}
    {@if it.isOverdue == 0}
        <tr data-order-id="&{it.id}">
    {@/if}
        <td>&{it.id}</td>
        <td>
            <a href="${website}product/view/&{it.productId}" target="_blank">&{it.productName}</a>
        </td>
        <td>
            {@if it.status == 1}审核中订单{@/if}
            {@if it.status == 2}还款中订单{@/if}
            {@if it.status == 3}还款完成订单{@/if}
            {@if it.status == 4}取消订单{@/if}
        </td>
        <td>&{it.productPrice}</td>
        <td>&{it.firstPay}</td>
        <td>&{it.payPeriods}</td>
        <td>&{it.repayDay}日</td>
        <td>&{it.createdTime}</td>
        <td>
            {@if it.status == 1}
            <a class="J_cancel" href="javascript:;">取消订单 |</a>
            {@/if}
            <a href="${website}vip/product/order/&{it.id}">浏览</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function (S) {
        S.use('widget/calendar, page/order/list', function () {
            PW.page.order.List({
                pagi: {
                    renderTo: '#J_pagination',
                    juicerRender: '#tpl',
                    dataRender: '#J_template',
                    pageSize: 10,
                    url: '${website}vip/product/order/ajax/list',
                    configUrl: function (url, page, me, prevPaginationData) {
                        return url+'/'+ page;
                        // return url;
                    }
                }
            });
        });
    });
</script>