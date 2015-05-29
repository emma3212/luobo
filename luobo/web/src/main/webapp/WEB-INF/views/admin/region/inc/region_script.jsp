<%@ page contentType="text/html; charset=UTF-8" %>

<script type="text/template" id="updateInpTpl">
  <tr region-id="&{id}" data-oper-type="&{type}">
      <td><input type="text" class="form-control input-small valid-icon" data-valid-rule="length(0,11)"  name="name" value="&{name}"/></td>
      <td><input type="text" class="form-control input-small valid-icon" data-valid-rule="length(0,11)"  name="manager" value="&{manager}"/></td>
      <td>&{customerNum}
      <input type="hidden" class="form-control input-small"  name="customerNum" value="&{customerNum}" /></td>
     <td>
      <input type="text" class="form-control input-small valid-icon" data-valid-rule="isMobile|isNull"  name="phone" value="&{phone}" />
    </td>
    <td>&{presentStatus}</td>
    <td>
      <a class="J_save" href="javascript:;">保存</a>&nbsp;|
      <a class="J_cancel" href="javascript:;">
        取消
      </a>
    </td>
  </tr>
</script>
<script type="text/template" id="updateTpl">
  <tr region-id="&{id}" data-oper-type="update">
    <td class="J_regionName">&{name}</td>
    <td class="J_manager">&{manager}</td>
    <td class="J_memberNum">&{customerNum}</td>
    <td class="J_phone">&{phone}</td>
    <td class="J_status">&{presentStatus}</td>
    <td>
      <a class="J_update" href="javascript:;">编辑</a>&nbsp;|
      <a class="J_enlight" href="javascript:;">
      &{enabled}
    </a>
    </td>
  </tr>
</script>
<script type="text/javascript">
  KISSY.ready(function(S){
    S.use('page/region/region-list',function(){
      PW.page.region.regionList();
    })
  })
</script>