<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td>
            <a href="${website}admin/member/&{it.userId}" target="_blank">&{it.userName}</a>
        </td>
        <td>
            <a class="J_status" data-stauts="&{it.status}" href="javascript:;">
                {@if it.status == 1}审核中订单{@/if}
                {@if it.status == 2}还款中订单{@/if}
                {@if it.status == 3}还款完成订单{@/if}
            </a>
            {@if it.status == 4}
            <a class="J_cancel" data-stauts="&{it.status}" href="javascript:;">取消订单
            </a>
            {@/if}
        </td>
        <td>&{it.userMobile}</td>
        <td class="J_freeDayHolder">&{it.freeDay}</td>
        <td class="J_price">&{it.applyMoney}</td>
        <td class="J_planReturn">&{it.shouldRepayMoney}</td>
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
            {@if it.status < 4}
            <a class="J_freeDay" href="javascript:;"> | 免息设置</a>
            {@/if}
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="statusTpl">
    <form class="J_statusForm">
        <input type="hidden" name="id" value="&{id}"/>

        <div class="J_sensitive dlg-group" style="float: right;">
            <label>请输入敏感密码</label>
            <input type="password" class="form-control w150 J_sensitiveEl" data-valid-rule="length(7,16)"
                   disabled="disabled" name="sensitiveCode" val=""/>
        </div>
        <div class="control-group dlg-group">
            <label class="control-label">状态</label>

            <div class="controls">
                <select class="form-control w150 J_statusSelect" name="status">
                    <option value="1">审核中订单</option>
                    <option value="2">还款中订单</option>
                    <option value="3">还款完成订单</option>
                    <option value="4">取消订单</option>
                </select>
            </div>
        </div>
        <div class="control-group dlg-group clearboth J_amountHolder hidden">
            <label class="control-label">总金额</label>

            <div class="controls">
                <input type="text" class="w150 J_dlgAmount" disabled="disabled" data-valid-rule="isFloat" name="applyMoney"
                       value="&{amount}"/>
            </div>
        </div>
        <div class="control-group dlg-group clearboth J_realRepayHolder hidden">
            <label class="control-label">实际还款金额</label>

            <div class="controls ">
                <input type="text" class="w150 J_dlgRealRapay" disabled="disabled" data-valid-rule="isFloat"
                       name="actualRepayMoney" value="&{anyRepay}"/>
            </div>
        </div>
    </form>
</script>
<script type="text/template" id="orderTpl">
    <button class="pull-right dlg-btn" onclick="window.open('${website}admin/any/repay/order/export/pdf/&{id}')">导出PDF</button>
    <div class="control-group dlg-list">
        <label class="control-label">免息天数</label>

        <div class="controls">&{freeDay}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">金额</label>

        <div class="controls">&{applyMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">应还金额</label>

        <div class="controls">&{shouldRepayMoney}</div>
    </div>
    <div class="control-group dlg-list">
        <label class="control-label">实际还款金额</label>

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
<script type="text/template" id="freeDayTpl">
    <form class="J_setFreeDayFrom">
        <div class="control-group dlg-group">
            <label class="control-label">免息天数：</label>
            <div class="controls">
                <input type="text" class="w150" data-valid-rule="isInteger" data-valid-tip="请输入免息天数|输入免息天数有误" name="freeDay" value="&{freeDay}" />
            </div>
        </div>
    </form>
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
                    url: '${website}admin/any/repay/order/ajax/list',
                    configUrl: function (url, page, me, prevPaginationData) {
                        return url+'/'+ page;
                        // return url;
                    }
                }
            });
        });
    });
</script>