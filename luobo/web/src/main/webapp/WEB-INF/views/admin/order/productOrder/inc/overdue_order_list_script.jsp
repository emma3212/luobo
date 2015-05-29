<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td>
            <a href="${website}product/view/&{it.productId}" target="_blank">&{it.productName}</a>
        </td>
        <td>
            <a href="${website}admin/member/&{it.userId}" target="_blank">&{it.userName}</a>
        </td>
        <td>还款中</td>
        <td>&{it.userMobile}</td>
        <td>&{it.productPrice}</td>
        <td>&{it.firstPay}</td>
        <td>&{it.payPeriods}</td>
        <td>&{it.createdTime}</td>
        <td>
            <input type="hidden" class="J_tipHolder" value="&{it.adminComment}"/>
            {@if it.adminComment == null}
            <a class="J_tip font-gray" href="javascript:;">备注</a> |
            {@/if}
            {@if it.adminComment != null}
            <a class="J_tip" href="javascript:;">备注</a> |
            {@/if}
            <a href="${website}admin/product/order/&{it.id}">浏览</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function (S) {
        S.use('widget/calendar,page/order/order', function () {
            PW.page.order.AuditList({
                pagi: {
                    renderTo: '#J_pagination',
                    juicerRender: '#tpl',
                    dataRender: '#J_template',
                    pageSize: 10,
                    url: '${website}admin/product/order/ajax/overdue/list',
                    configUrl: function (url, page, me, prevPaginationData) {
                        return url+'/'+ page;
                        // return url;
                    }
                },
                type: 'cancel'
            });
        });
    });
</script>