<%@ page contentType="text/html;charset=UTF-8" %>

<!-- 添加联系人模板 -->
<script type="text/template" id="addTpl">
    <tr data-contact-id="&{contact.id}" type="&{contact.type}">
        <td>
            联系人
            <span class="required">*</span>
        </td>
        <td><input type="text" class="form-control input-small valid-icon J_contactRelation" data-valid-rule="notNull" data-valid-tip="" name="relationship" value="&{contact.relationship}"/></td>
        <td><input type="text" class="form-control input-small valid-icon J_contactName" data-valid-rule="notNull" data-valid-tip="" name="name" value="&{contact.name}"/></td>
        <td><input type="text" class="form-control input-small valid-icon J_contactPhone" data-valid-rule="isMobile" data-valid-tip="" name="mobile" value="&{contact.mobile}"/></td>
        <td><input type="text" class="form-control input-small valid-icon J_contactWork" data-valid-rule="notNull" data-valid-tip="" name="company" value="&{contact.company}"/></td>
        <td>
            <a href="javascript:;" class="J_save">保存</a> |
            <a href="javascript:;" class="J_cancel">取消</a>
        </td>
    </tr>
</script>
<!-- 修改之后渲染联系人模板 -->
<script type="text/template" id="renderTpl">
    <tr data-contact-id="&{contact.id}">
        <td>
            联系人
            <span class="required">*</span>
        </td>
        <td class="relation">&{contact.relationship}</td>
        <td class="name">&{contact.name}</td>
        <td class="phone">&{contact.mobile}</td>
        <td class="work">&{contact.company}</td>
        <td>
            <a href="javascript:;" class="J_edit">编辑</a> |
            <a href="javascript:;" class="J_delete">删除</a>
        </td>
    </tr>
</script>
<script type="text/template" id="schoolTpl">
    {@each list as it}
    <option data-enlight="&{it.enabled}" value="&{it.id}">&{it.name}</option>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/vip-check, widget/calendar', function(){
            PW.page.VipCheck();
        })
    })
</script>