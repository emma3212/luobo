<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-id="&{it.id}">
        <td class="J_name">&{it.name}</td>
        <td  class="J_mobile">&{it.fatherName}</td>
        <td class="J_status">
            {@if it.status == 0}已停用{@/if}
            {@if it.status == 1}已启用{@/if}
        </td>
        <td>
            <a class="J_update" href="javascript:;">修改</a>&nbsp;|
            <a class="J_enlight" href="javascript:;">
                {@if it.status == 0}启用{@/if}
                {@if it.status == 1}停用{@/if}
            </a>&nbsp;|
            <a class="J_updatePwd" href="javascript:;">修改密码</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="newTpl">
    <form class="J_newForm">
        <div class="control-group">
            <label class="control-label">
                姓名
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="text" data-valid-rule="length(0,11)" data-valid-tip="请输入1-10位字符|密码输入有误，请重新填写" class="w200 valid-icon" value="" name="name" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                手机号码
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="text" class="w200 valid-icon J_adminMobile" data-valid-rule="isMobile" data-valid-tip="请输入手机号码|手机号码输入有误，请重新填写"  value="" name="loginName" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                密码
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="password" data-valid-rule="length(7,16)" data-valid-tip="请输入8-15位字符|密码输入有误，请重新填写" id="J_pwd" class="w200 valid-icon" value="" name="pwd" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                确认密码
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="password" class="w200 valid-icon" data-valid-rule="require(J_pwd)&equal(J_pwd)" data-valid-tip="8-15个字符或者空，请再次输入密码|输入密码不一致，请重新填写" name="confPwd"/>
            </div>
        </div>
    </form>
</script>
<script type="text/template" id="updateTpl">
    <form class="J_updateForm">
        <div class="control-group">
            <label class="control-label">
                手机号码
                <span class="required">*</span>
            </label>
            <div class="controls">
                &{mobile}
                <input type="hidden" class="w200" value="&{mobile}" name=""/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                姓名
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="text" data-valid-rule="length(0,11)" data-valid-tip="请输入1-10位字符|密码输入有误，请重新填写" class="w200 valid-icon" value="&{name}" name="name" />
            </div>
        </div>
    </form>
</script>
<script type="text/template" id="updatePwdTpl">
    <form class="J_updatePwdForm">
        <div class="control-group">
            <label class="control-label">
                新密码
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="password" data-valid-rule="length(7,16)" data-valid-tip="请输入8-15位字符|密码输入有误，请重新填写" id="J_pwd" class="w200 valid-icon" value="" name="mm" />
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                确认密码
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="password" class="w200 valid-icon" data-valid-rule="require(J_pwd)&equal(J_pwd)" data-valid-tip="8-15个字符或者空，请再次输入密码|密码输入有误，请重新填写"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">
                敏感密码
                <span class="required">*</span>
            </label>
            <div class="controls">
                <input type="password" data-valid-rule="length(7,16)" data-valid-tip="请输入8-15位字符|敏感密码输入有误，请重新填写"  class="w200 valid-icon" value="" name="mg" />
            </div>
        </div>
    </form>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/administrator/list',function(){
            PW.page.administrator.List({
                renderTo: '#J_pagination',
                juicerRender: '#tpl',
                dataRender: '#J_template',
                themeCss: '.J_pagination_theme2',
                pageSize: 10,
                url: '/admin/administrator/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    //return url+'/'+ page;
                    return url+'/'+ page;
                }
            });
        })
    })
</script>