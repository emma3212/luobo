<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="holder">
    <div class="content">
        <h1>编辑会员</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>会员管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>编辑会员</a>
                </li>
            </ul>
        </div>
        <div class="tab tab-horizon tab-red">
            <ul class="tab-nav clearfix">
                <li class="active">
                    <a href="javascript:;">账户信息</a>
                </li>
                <li >
                    <a href="javascript:;">审核信息</a>
                </li>
            </ul>
            <form data-fold="fold" class="box box-blue no-margin-box J_editForm" autoComplete="off" enctype="multipart/form-data" action="${website}admin/member/update" method="POST">
                <!-- 返回的错误信息 -->
                <input type="hidden" class="showErrInp" value="${errMsg}" name="">
                <input type="hidden" value="PUT" name="_method">
                <!-- 会员id -->
                <input type="hidden" value="${info.id}" name="id">
                <input type="hidden" class="J_userId" value="${info.userId}" name="userId">
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
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        巨汇卡卡号
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="请输入巨汇卡卡号|巨汇卡卡号有误，请重新填写" data-valid-rule="isNull|isNumber" name="memberCardNum" value="${user.carNum}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        是否绑定微信
                                    </label>
                                    <div class="controls">
                                        <label>
                                            <c:if test="${empty user.openId}">否</c:if><c:if test="${!empty user.openId}">是</c:if>
                                        </label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        OPENID
                                    </label>
                                    <div class="controls">
                                        <c:if test="${empty user.openId}">未绑定</c:if><c:if test="${!empty user.openId}">${user.openId}</c:if>
                                    </div>
                                </div>
                                <c:if test="${!empty user.openId}">
                                    <div class="control-group">
                                        <label class="control-label">
                                            是否解绑
                                            <span class="required">*</span>
                                        </label>
                                        <div class="controls">
                                            <label>
                                                <input type="radio" checked="" name="bind" value="0">
                                                否
                                            </label>
                                            <label>
                                                <input type="radio" name="bind" value="1">
                                                是
                                            </label>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>修改会员信息</span>
                        </div>
                        <div class="box-container">
                            <div class="box-body">
                                <h3 class="clearfix">
                                    个人账号信息
                                </h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        姓名
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="请输入姓名|姓名有误，请重新填写" data-valid-rule="notNull" name="name" value="${info.name}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        性别
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <label>
                                            <input type="radio" <c:if test="${info.gender==0}"> checked="checked" </c:if> value="0" name="gender">男
                                        </label>
                                        <label>
                                            <input type="radio" <c:if test="${info.gender==1}"> checked="checked" </c:if> value="1" name="gender">女
                                        </label>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        联系人手机
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon"  data-valid-tip="请输入手机号|手机号有误，请重新填写" data-valid-rule="isMobile" name="mobile" value="${info.mobile}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        联系人邮箱
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon"  data-valid-tip="请输入邮箱号|邮箱号有误，请重新填写" data-valid-rule="isEmail" name="email" value="${info.email}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        联系人QQ号
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon"  data-valid-tip="请输入QQ号|QQ号有误，请重新填写" data-valid-rule="isQQ" name="qq" value="${info.qq}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        出生日期
                                    </label>
                                    <div class="controls">
                                        <input type="text" data-type="date" data-format="YYYY-MM-DD"  class="w200" readonly="readonly" name="birthday" value="<fmt:formatDate value="${info.birthday}" type="both" pattern="yyyy-MM-dd"/>" />
                                    </div>
                                </div>
                                <h3>银行账号信息</h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        银行选择
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <select class="w200 valid-icon" name="bankId">
                                            <c:forEach items="${bankList}" var="bank">
                                                <option value="${bank.key}" <c:if test="${info.bankId==bank.key}">selected="selected"</c:if> >${bank.value}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        银行卡号
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon"  data-valid-tip="请输入银行卡号|银行卡号有误，请重新填写" data-valid-rule="isNumber" name="cardNum" value="${info.cardNum}" />
                                    </div>
                                </div>
                                <h3>个人联系信息</h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        详细家庭地址
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon"  data-valid-tip="请输入详细家庭地址|详细家庭地址为空，请重新填写" data-valid-rule="notNull" name="address" value="${info.address}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        身份证号
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon"  data-valid-tip="请输入身份证号|身份证号有误，请重新填写" data-valid-rule="isIdCard" name="idCard" value="${info.idCard}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        身份证图片
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="file" class="w200 valid-icon" data-valid-tip="请上传身份证正面图片|身份证正面图片有误，请重新填写" data-valid-rule="<c:if test="${!empty info.idCardPicPros}">isNull|</c:if>isImage" name="picPros" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        <img width="200" height="200" src="<c:if test="${!empty info.idCardPicPros}">${uploadStaticWebsite}${info.idCardPicPros}</c:if><c:if test="${empty info.idCardPicPros}">${staticWebsite}img/vip/common/avatar_small.jpg</c:if>" alt="身份证正面图片">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        <input type="file" class="w200 valid-icon" data-valid-tip="请输入身份证反面图片|身份证反面图片有误，请重新填写" data-valid-rule="<c:if test="${!empty info.idCardPicPros}">isNull|</c:if>isImage" name="picCons" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        <img width="200" height="200" src="<c:if test="${!empty info.idCardPicCons}">${uploadStaticWebsite}${info.idCardPicCons}</c:if><c:if test="${empty info.idCardPicCons}">${staticWebsite}img/vip/common/avatar_small.jpg</c:if>" alt="身份证反面图片">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        与会员合影
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="file" class="w200 valid-icon" data-valid-tip="请上传与会员合影|与会员合影有误，请重新填写" data-valid-rule="<c:if test="${!empty info.suretyPic}">isNull|</c:if>isImage" name="suretyPicture" value="" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        <img width="200" height="200" src="<c:if test="${!empty info.suretyPic}">${uploadStaticWebsite}${info.suretyPic}</c:if><c:if test="${empty info.suretyPic}">${staticWebsite}img/vip/common/avatar_small.jpg</c:if>" alt="与会员合影">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <%-- <label class="control-label">
                                         人员来源
                                         <span class="required">*</span>
                                     </label>
                                     <div class="controls">
                                         <label>
                                             <input type="radio" class="J_student" <c:if test="${info.source==0}">checked="checked"</c:if> value="0" name="source">在校学生
                                         </label>
                                         <label>
                                             <input type="radio" class="J_staff" <c:if test="${info.source==1}">checked="checked"</c:if> value="1" name="source">社会人员
                                         </label>
                                     </div>--%>
                                    <!-- 人员来源类型 -->
                                    <input type="hidden" class="J_source" name="" value="0">
                                </div>
                                <h3>个人学校</h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        学校
                                    </label>
                                    <div class="controls">
                                        <select class="w200 valid-icon J_region" name="regionId">
                                            <c:forEach items="${regionList}" var="region">
                                                <option value="${region.id}" data-enlight="${region.enabled}"
                                                        <c:if test="${parentId !=0 and parentId == region.id}">selected="selected"</c:if>
                                                        <c:if test="${info.regionId == region.id}">selected="selected"</c:if> >
                                                        ${region.name}<c:if test="${region.enabled == 0}">(已停用)</c:if></option>
                                            </c:forEach>
                                        </select>
                                        <select class="w200 valid-icon J_school" name="regionId">
                                            <c:forEach items="${schoolList}" var="school">
                                                <option value="${school.id}" data-enlight="${school.enabled}"
                                                        <c:if test="${info.regionId == school.id}">selected="selected"</c:if> >
                                                        ${school.name}<c:if test="${school.enabled == 0}">(已停用)</c:if></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        专业班级
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" name="classOrDepartment" value="${info.classOrDepartment}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        入学日期
                                    </label>
                                    <div class="controls">
                                        <input type="text" data-type="date" readonly="readonly" data-format="YYYY-MM-DD"  class="w200" name="entrance" value="<fmt:formatDate value="${info.entrance}" type="both" pattern="yyyy-MM-dd"/>" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        职位
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon J_job" name="position" value="${info.position}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        学校地址
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon J_schoolOrDepartmentAddress" name="schoolOrCompanyAdd" value="${info.schoolOrCompanyAdd}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        宿舍地址
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon J_dormitoryOrNowAddress" name="presentAddress" value="${info.presentAddress}" />
                                    </div>
                                </div>
                                <h3>家庭联系人信息</h3>
                                <div class="control-group">
                                    <table class="table-responsive">
                                        <thead>
                                        <tr>
                                            <th class="table-width-10"></th>
                                            <th class="table-width-10">关系</th>
                                            <th class="table-width-10">姓名</th>
                                            <th class="table-width-10">电话</th>
                                            <th class="table-width-20">工作单位</th>
                                            <th class="table-width-10">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="J_familyTemplate">
                                        <c:forEach items="${families}" var="family">
                                            <tr data-contact-id="${family.id}">
                                                <td>
                                                    联系人
                                                    <span class="required">*</span>
                                                </td>
                                                <td class="relation">${family.relationship}</td>
                                                <td class="name">${family.name}</td>
                                                <td class="phone">${family.mobile}</td>
                                                <td class="work">${family.company}</td>
                                                <td>
                                                    <a href="javascript:;" class="J_edit">编辑</a> |
                                                    <a href="javascript:;" class="J_delete">删除</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="controlp-group clearfix">
                                        <a class="fa fa-plus-square pull-right J_addFamily" href="javascript:;"></a>
                                    </div>
                                </div>
                                <h3>其他联系人信息</h3>
                                <div class="control-group">
                                    <table class="table-responsive">
                                        <thead>
                                        <tr>
                                            <th class="table-width-10"></th>
                                            <th class="table-width-10">关系</th>
                                            <th class="table-width-10">姓名</th>
                                            <th class="table-width-10">电话</th>
                                            <th class="table-width-20">工作单位</th>
                                            <th class="table-width-10">操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="J_otherTemplate">
                                        <c:forEach items="${contactsList}" var="con">
                                            <tr data-contact-id="${con.id}">
                                                <td>
                                                    联系人
                                                    <span class="required">*</span>
                                                </td>
                                                <td class="relation">${con.relationship}</td>
                                                <td class="name">${con.name}</td>
                                                <td class="phone">${con.mobile}</td>
                                                <td class="work">${con.company}</td>
                                                <td>
                                                    <a href="javascript:;" class="J_edit">编辑</a> |
                                                    <a href="javascript:;" class="J_delete">删除</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="controlp-group clearfix">
                                        <a class="fa fa-plus-square pull-right J_addOther" href="javascript:;"></a>
                                    </div>
                                    <div class="controlp-group">
                                        <label class="control-label">
                                            备注
                                        </label>
                                        <div class="controls">
                                            <textarea class="w500 valid-icon" name="comments">${info.comments}</textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-footer form-footer-margin">
                    <button type="submit" class="btn btn-blue btn-ok btn-margin-right J_submitBtn" data-loading-text="正在提交，请稍后" data-btn-type="loading" >保存</button>
                    <button type="button" class="btn btn-yellow btn-refresh" onclick="window.location.href='${website}admin/member'">返回</button>
                </div>
            </form>
        </div>
    </div>
</div>