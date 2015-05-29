<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="html" uri="http://jakarta.apache.org/struts/tags-html" %>
<div class="holder">
    <div class="content">
        <h1>短信平台设置</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>系统配置管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>短信平台设置</a>
                </li>
            </ul>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-paw"></i>设置短信平台</span>
            </div>
            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <input type="hidden" class="J_errMsg" value="${eMsg}" />
                    <form class="J_form" action="${website}admin/system/eemsg/update" method="post">
                        <div class="control-groNup">
                            <label class="control-label">
                                登录名
                                <span class="required">*</span>
                            </label>
                            <div class="controls">
                                <input  type="text" class="w250 valid-icon" data-valid-tip="请输入短信平台登录名" data-valid-rule="notNull" name="loginName" value="${loginName}" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                接口密码
                                <span class="required">*</span>
                            </label>
                            <div class="controls">
                                <input  type="text" class="w250 valid-icon" data-valid-tip="请输入短信平台密码" data-valid-rule="notNull" name="loginPwd" value="${loginPwd}" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                敏感密码
                                <span class="required">*</span>
                            </label>
                            <div class="controls">
                                <input type="text" onfocus="this.type='password'" id="J_pwd"  class="w250 valid-icon" data-valid-tip="8-15个字符，请输入敏感操作密码|输入无效，请重新输入" data-valid-rule="length(7,16)" name="sensitiveCode" value="" />
                            </div>
                        </div>
                        <div class="form-footer form-footer-margin">
                            <button class="btn btn-blue btn-ok btn-margin-right" data-loading-text="正在提交，请稍后" data-btn-type="loading"  type="submit">保存</button>
                            <button class="btn btn-yellow btn-refresh btn-margin-right" type="reset" >取消</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>