<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td>
            {@if it.status == 1}审核中订单{@/if}
            {@if it.status == 2}还款中订单{@/if}
            {@if it.status == 3}还款完成订单{@/if}
            {@if it.status == 4}取消订单{@/if}
        </td>
        <td>&{it.freeDay}</td>
        <td>&{it.applyMoney}</td>
        <td>&{it.actualRepayMoney}</td>
        <td>&{it.actualRepayDate}</td>
        <td>&{it.createdTime}</td>
        <td>
            {@if it.status == 1}
            <a class="J_cancel" href="javascript:;">取消订单 |</a>
            {@/if}
            <a class="J_skim" href="javascript:;">浏览</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="orderTpl">
    <div class="control-group dlg-list">
        <label class="control-label">免息天数：</label>

        <div class="controls">&{freeDay}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">金额(元)：</label>

        <div class="controls">&{applyMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">应还金额(元)：</label>

        <div class="controls">&{shouldRepayMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">实际还款金额(元)：</label>

        <div class="controls">&{actualRepayMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">状态：</label>

        <div class="controls">&{status}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">生效日期：</label>

        <div class="controls">&{startTime}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">下单日期：</label>

        <div class="controls">&{createdTime}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">还款日期：</label>

        <div class="controls">&{actualRepayDate}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">借款用途：</label>

        <div class="controls">&{reason}</div>
    </div>
</script>

<script type="text/javascript">
    KISSY.ready(function (S) {
        S.use('widget/calendar, page/order/anyrepay-list', function () {
            PW.page.order.AnyRepay({
                pagi: {
                    renderTo: '#J_pagination',
                    juicerRender: '#tpl',
                    dataRender: '#J_template',
                    pageSize: 10,
                    url: '${website}vip/any/repay/ajax/list',
                    configUrl: function (url, page, me, prevPaginationData) {
                        return url+'/'+ page;
                        // return url;
                    }
                }
            });
        });
    });
</script>