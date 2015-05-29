<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td>
            <a href="${website}admin/member/&{it.userId}" target="_blank">&{it.userName}</a>
        </td>
        <td>&{it.userMobile}</td>
        <td>&{it.applyMoney}</td>
        <td>&{it.createdTime}</td>
        <td>
            <input type="hidden" class="J_tipHolder" value="&{it.comment}"/>
            {@if it.comment == null}
            <a class="J_tip font-gray" href="javascript:;">备注</a> |
            {@/if}
            {@if it.comment != null}
            <a class="J_tip" href="javascript:;">备注</a> |
            {@/if}
            <a class="J_skim" href="javascript:;">浏览</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="orderTpl">
    <button class="pull-right dlg-btn" onclick="window.open('${website}admin/any/repay/order/export/pdf/&{id}')">导出PDF</button>
    <div class="control-group dlg-list">
        <label class="control-label">免息天数</label>

        <div class="controls">&{freeDay}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">金额(元)</label>

        <div class="controls">&{applyMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">应还金额(元)</label>

        <div class="controls">&{shouldRepayMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">实际还款金额(元)</label>

        <div class="controls">&{actualRepayMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">状态</label>

        <div class="controls">&{status}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">生效日期</label>

        <div class="controls">&{startTime}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">下单日期</label>

        <div class="controls">&{createdTime}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">还款日期</label>

        <div class="controls">&{actualRepayDate}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">借款用途</label>

        <div class="controls">&{reason}</div>
    </div>
</script>
<script type="text/javascript">
    KISSY.ready(function (S) {
        S.use('widget/calendar, page/order/any-order', function () {
            PW.page.order.anyRepay.AuditList({
                pagi: {
                    renderTo: '#J_pagination',
                    juicerRender: '#tpl',
                    dataRender: '#J_template',
                    pageSize: 10,
                    url: '${website}admin/any/repay/order/ajax/canceled/list',
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