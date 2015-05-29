<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<div class="holder">
    <div class="content">
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>管理员档案编辑</a>
                </li>
            </ul>
        </div>
        <form data-fold="fold" class="box box-blue no-margin-box J_form" autoComplete="off"
              action="${website}admin/user/profile/edit/${user.id}" method="POST">
            <input type="hidden" class="J_errMsg" value="${eMsg}" name="">

            <div class="tab-panel tab-no-border">
                <div class="tab-content">
                    <div class="box-title clearfix">
                                <span>
                                    <i class="fa fa-reorder"></i>
                                </span>
                        <span>管理员档案编辑</span>
                    </div>
                    <div class="box-container">
                        <div class="box-body">
                            <div class="control-group">
                                <label class="control-label">
                                    手机号码
                                    <span class="required">*</span>
                                </label>

                                <div class="controls">
                                    ${user.loginName}
                                    <input type="hidden" class="w200" name="loginName" value=""/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    姓名
                                    <span class="required">*</span>
                                </label>

                                <div class="controls">
                                    <input type="text" class="w200 valid-icon" data-valid-tip="1-10个字符，请输入姓名|姓名有误，请重新填写"
                                           data-valid-rule="length(0,11)" name="name" value="${admin.name}"/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    原密码
                                    <span class="required">*</span>
                                </label>

                                <div class="controls">
                                    <input type="text" onfocus="this.type='password'" class="w200 valid-icon"
                                           data-valid-tip="8-15个字符，请输入密码|密码有误，请重新填写"
                                           data-valid-rule="length(7,16)" name="pwd" value=""/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    密码
                                </label>

                                <div class="controls">
                                    <input type="text" onfocus="this.type='password'" class="w200 valid-icon"
                                           data-valid-tip="8-15个字符，请输入密码|密码有误，请重新填写"
                                           data-valid-rule="length(7,16)|isNull" id="J_pwd" name="newPwd"
                                           value=""/>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label">
                                    确认密码
                                </label>

                                <div class="controls">
                                    <input type="text" onfocus="this.type='password'" class="w200 valid-icon"
                                           data-valid-tip="8-15个字符，请再次输入密码|确认密码不一致，请重新填写"
                                           data-valid-rule="require(J_pwd)&equal(J_pwd)" name="confirmPwd"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-footer form-footer-margin">
                <button class="btn btn-blue btn-ok btn-margin-right" data-loading-text="正在提交，请稍后"
                        data-btn-type="loading" type="submit">保存
                </button>
                <button class="btn btn-yellow btn-refresh" type="reset">重置</button>
            </div>
        </form>
    </div>
</div>