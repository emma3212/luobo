<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
  <div class="content">
    <h1>会员档案编辑</h1>
    <div class="crumb" id="crumb">
      <button class="btn btn-red time">
        <i class="fa fa-calendar"></i>
        <!--  span需要套时间 -->
        <span>${requestScope.web_date}</span>
      </button>
      <ul class="clearfix">
        <li>
          <i class="icon icon-home"></i>
          <!--  需要套会员中心控制面板地址 -->
          <a>会员中心</a>
          <i class="icon-angle-right"></i>
        </li>

        <li>
          <a>会员档案编辑</a>
        </li>
      </ul>
    </div>
    <form data-fold="fold" autocomplete="off" class="box box-blue no-margin-box J_editForm" action="${website}vip/user/profile/edit/${user.id}" method="post">
      <input type="hidden" value="PUT" name="_method">
      <input type="hidden" class="showErrInp" value="${eMsg}" name="">

      <div class="tab-panel tab-no-border">
        <div class="tab-content">
          <div class="box-title clearfix">
            <span >
                <i class="fa fa-reorder"></i>
            </span>
            <span>修改会员信息</span>
          </div>
          <div class="box-container">
            <div class="box-body">
              <div class="control-group">
                <label class="control-label">
                  账号
                  <span class="required">*</span>
                </label>
                <div class="controls">
                  ${user.loginName}
                  <input type="hidden" class="w200" name="loginName" value="${user.loginName}" />
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">
                  巨汇卡卡号
                </label>
                <div class="controls">
                  <input type="text" class="w200"  data-valid-tip="请输入卡号|卡号有误，请重新填写" data-valid-rule="isNull|isNumber" name="carNum" value="${user.carNum}" />
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">
                  原密码
                </label>
                <div class="controls">
                  <input type="text" autocomplete="off" class="w200 valid-icon J_oldInp"  name=""/>
                  <input type="password" autocomplete="off" class="w200 valid-icon J_oldPwd" style="display: none;"  name="pwd"/>
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">
                  新密码
                </label>
                <div class="controls">
                  <input id="J_pwd" class="w200 valid-icon" type="password" autocomplete="off" name="newPwd" />
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">
                  确认新密码
                </label>
                <div class="controls">
                  <input type="password" class="w200 valid-icon" data-valid-rule="require(J_pwd)&equal(J_pwd)" data-valid-tip="8-15个字符或者空，请再次输入密码|密码有误，请重新填写"/>
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">OPENID</label>
                <div class="controls">
                  <span>
                    <c:if test="${empty user.openId}">无</c:if>
                    ${user.openId}
                  </span>
                </div>
              </div>
              <div class="control-group">
                <label class="control-label">是否绑定微信</label>
                <div class="controls J_weixin">
                  <c:choose>
                    <c:when test="${empty user.openId}">
                      否
                    </c:when>
                    <c:otherwise>
                      是
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
              <div class="control-group  J_weixinBox" style="display:none;">
                <label class="control-label">是否解绑</label>
                <div class="controls">
                  <input id="yes" type="radio" value="1" name="weChatStatus">
                  <label for="yes">是</label>
                  <input id="no" type="radio" value="0" name="weChatStatus" checked="checked">
                  <label for="no">否</label>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="form-footer form-footer-margin">
        <button type="submit" class="btn btn-blue btn-ok btn-margin-right J_submitBtn" data-loading-text="正在提交，请稍后" data-btn-type="loading" >保存</button>
        <button type="button" class="btn btn-yellow btn-refresh" onclick="history.go(-1)">返回</button>
      </div>
    </form>
  </div>
</div>