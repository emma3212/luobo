<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<script type="text/template" id="editTpl">
    <tr data-type-id="&{id}" data-type="&{type}">
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="length(0,11)" name="name" value="&{name}" />
        </td>
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="isInteger" name="whiteBarCreditLine" value="&{creditLine}" />
        </td>
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="isInteger" name="anyRepayCreditLine" value="&{anyRepayCreditLine}" />
        </td>
        <td>&{statusStr}</td>
        <td>
            <a class="J_save" href="javascript:;">保存</a> <span>|</span>
            <a class="J_cancel" href="javascript:;">取消</a>
        </td>
    </tr>
</script>
<script type="text/template" id="saveTpl">
    <tr data-type-id="&{id}">
        <td>&{name}</td>
        <td>&{whiteBarCreditLine}</td>
        <td>&{anyRepayCreditLine}</td>
        <td>&{statusStr}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a>
            <span>|</span>
            <a class="J_enlight" href="javascript:;">&{status}</a>
        </td>
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/member/type',function(){
            PW.page.member.Type();
        })
    })
</script>
