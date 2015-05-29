<%@ page contentType="text/html; charset=UTF-8" %>

<script type="text/template" id="saveTpl">
  <tr data-school-id="&{id}">
    <td>&{name}</td>
    <td>&{manager}</td>
    <td class="J_regin">
      <input type="hidden" class="J_reginId" value="&{parentId}" />
      &{region}
    </td>
    <td>&{customerNum}</td>
    <td>&{phone}</td>
    <td>&{statusStr}</td>
    <td>
      <a class="J_edit" href="javascript:;">编辑</a> |
      <a class="J_enlight" href="javascript:;">
        &{enabled}
      </a>
    </td>
  </tr>
</script>
<script type="text/template" id="editTpl">
  <tr data-school-id="&{id}" data-type="&{type}">
    <td>
      <input type="text" class="form-control input-small valid-icon J_actionName" data-valid-rule="length(0,11)" name="name" value="&{name}" />
    </td>
    <td>
        <input type="text" class="form-control input-small valid-icon" data-valid-rule="length(0,11)" name="manager" value="&{manager}" />
    </td>
    <td class="J_reginList"></td>
    <td>
      &{customerNum}
      <input type="hidden" name="customerNum" value="&{customerNum}" />
    </td>
    <td>
      <input type="text" class="form-control input-small valid-icon" data-valid-rule="isMobile|isNull"  name="phone" value="&{phone}" />
    </td>
    <td>&{statusStr}</td>
    <td>
      <a class="J_save" href="javascript:;">保存</a> |
      <a class="J_cancel" href="javascript:;">取消</a>
    </td>
  </tr>
</script>
<script type="text/javascript">
  KISSY.ready(function(S){
    S.use('page/region/school',function(){
      PW.page.region.School();
    })
  })
</script>