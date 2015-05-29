<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="editTpl">
    <tr data-repay-id="&{id}">
        <td>&{planPrice}</td>
        <td><input type="text" data-valid-rule="isFloat" class="form-control input-small" name="actualRepayMoney" value="&{actualRepayMoney}" /></td>
        <td>&{lastTime}</td>
        <td><input type="text" class="form-control input-small J_realTime" data-valid-rule="notNull" readonly="readonly" name="actualRepayDate" value="&{actualRepayDate}" />
        </td>
        <td>
            <select class="form-control input-small" name="status">
                <option {@if status == 0}selected="selected"{@/if} value="0">未还款</option>
                <option {@if status == 1}selected="selected"{@/if} value="1">已还款</option>
            </select>
        </td>
        <td>
            <a class="J_save" href="javascript:;">保存</a> |
            <a class="J_cancel" href="javascript:;">取消</a>
        </td>
    </tr>
</script>
<script type="text/template" id="saveTpl">
    <tr data-repay-id="&{id}" data-type="&{type}">
        <td>&{planPrice}</td>
        <td>&{actualRepayMoney}</td>
        <td>&{lastTime}</td>
        <td>&{actualRepayDate}</td>
        {@if status == 1}
        <td class="payment"><i class="bigger fa fa-check-circle"></i></td>
        {@/if}
        {@if status == 0}
        <td class="unpayment"><i class="bigger fa fa-close"></i></td>
        {@/if}
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/order/white-view',function(){
            PW.page.order.WhitebarView();
        });
    });
</script>