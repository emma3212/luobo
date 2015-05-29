<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td>
            <a href="${website}admin/member/&{it.userId}" target="_blank">&{it.userName}</a>
        </td>
        <td>还款中</td>
        <td>&{it.userMobile}</td>
        <td>&{it.amount}</td>
        <td>&{it.payPeriods}</td>
        <td>&{it.createdTime}</td>
        <td>
            <input type="hidden" class="J_tipHolder" value="&{it.comment}" />
            {@if it.comment == null}
            <a class="J_tip font-gray" href="javascript:;">备注</a> |
            {@/if}
            {@if it.comment != null}
            <a class="J_tip" href="javascript:;">备注</a> |
            {@/if}
            <a href="${website}admin/white/bar/order/&{it.id}">浏览</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('widget/calendar, page/order/white-order',function(){
            PW.page.order.whitebar.AuditList({
                pagi: {
                    renderTo: '#J_pagination',
                    juicerRender: '#tpl',
                    dataRender: '#J_template',
                    pageSize: 10,
                    url: '${website}admin/white/bar/order/ajax/list/overdue',
                    configUrl: function(url,page,me,prevPaginationData){
                        return url+'/'+ page;
                    }
                },
                type: 'cancel'
            });
        });
    });
</script>
