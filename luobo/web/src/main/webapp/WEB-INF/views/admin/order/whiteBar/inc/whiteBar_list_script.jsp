<%@ page contentType="text/html;charset=UTF-8" %>
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
        <td class="J_price">&{it.amount}</td>
        <td class="J_staging">&{it.payPeriods}</td>
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
<script type="text/template" id="statusTpl">
    <form class="J_statusForm">
        <input type="hidden" name="id" value="&{id}" />
        <div class="J_sensitive dlg-group" style="float: right;">
            <label>请输入敏感密码：</label>
            <input type="password" class="form-control w150 J_sensitiveEl" data-valid-rule="length(7,16)" disabled="disabled" name="sensitiveCode" val="" />
        </div>
        <div class="control-group dlg-group">
            <label class="control-label">状态：</label>
            <div class="controls">
                <select class="form-control w150 J_statusSelect" name="status">
                    <option value="1">审核中订单</option>
                    <option value="2">还款中订单</option>
                    <option value="3">还款完成订单</option>
                    <option value="4">取消订单</option>
                </select>
            </div>
        </div>
        <div class="J_orderHolder hidden">
            <div class="control-group pull-right dlg-group">
                <label class="control-label">期数：</label>
                <div class="controls">
                    <select class="form-control w150 J_dlgStages" name="payPeriods">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                        <option value="13">13</option>
                        <option value="14">14</option>
                        <option value="15">15</option>
                        <option value="16">16</option>
                        <option value="17">17</option>
                        <option value="18">18</option>
                        <option value="19">19</option>
                        <option value="20">20</option>
                        <option value="21">21</option>
                        <option value="21">21</option>
                        <option value="22">22</option>
                        <option value="23">23</option>
                        <option value="24">24</option>
                    </select>
                </div>
            </div>
            <div class="control-group dlg-group">
                <label class="control-label">总金额：</label>
                <div class="controls">
                    <input type="text" class="w150 J_dlgAmount" data-valid-rule="isNumber" name="amount" value="&{amount}" />
                </div>
            </div>
            <div class="control-group dlg-group clearboth">
                <label class="control-label">月还款金额：</label>
                <div class="controls J_monthPrice"></div>
            </div>
        </div>
    </form>
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
                    url: '${website}admin/white/bar/order/ajax/list',
                    configUrl: function(url,page,me,prevPaginationData){
                         return url+'/'+ page;
                    }
                }
            });
        });
    });
</script>