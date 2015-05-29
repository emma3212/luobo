<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="holder">
    <div class="content">
        <h1>查看会员</h1>
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
                    <a>查看会员</a>
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
            <form data-fold="fold" class="box box-blue no-margin-box J_editForm" autoComplete="off" action="" method="">
                <div class="tab-panel tab-no-border">
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>查看会员信息</span>
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
                                        ${user.carNum}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        是否绑定微信
                                    </label>
                                    <div class="controls">
                                        <c:if test="${empty user.openId}">否</c:if>
                                        <c:if test="${!empty user.openId}">是</c:if>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        OPENID
                                    </label>
                                    <div class="controls">
                                        <c:if test="${empty user.openId}">未绑定</c:if>
                                        <c:if test="${!empty user.openId}">${user.openId}</c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>查看会员信息</span>
                        </div>
                        <div class="box-container">
                            <div class="box-body">
                                <div class="clearfix">
                                    <a class="btn btn-green btn-back-add pull-right" href="${website}/admin/member/export/pdf/${info.userId}">
                                        导出核实信息
                                        <i class="fa fa-share"></i>
                                    </a>
                                </div>

                                <h3 class="clearfix">
                                    个人账号信息
                                </h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        姓名
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.name}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        性别
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <c:if test="${info.gender==0}">男</c:if><c:if test="${info.gender==1}">女</c:if>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        联系人手机
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.mobile}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        联系人邮箱
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.email}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        联系人QQ号
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.qq}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        出生日期
                                    </label>
                                    <div class="controls">
                                        <fmt:formatDate value="${info.birthday}" type="both" pattern="yyyy-MM-dd"/>
                                    </div>
                                </div>
                                <h3>银行账号信息</h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        银行选择
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${bankList[info.bankId]}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        银行卡号
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.cardNum}
                                    </div>
                                </div>
                                <h3>个人联系信息</h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        详细家庭地址
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.address}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        身份证号
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        ${info.idCard}
                                    </div>
                                </div>
                                <div class="control-group J_cardImg">
                                    <label class="control-label">
                                        身份证图片
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        身份证正面
                                    </div>
                                    <div class="controls">
                                        <img width="200" height="200" src="<c:if test="${!empty info.idCardPicPros}">${uploadStaticWebsite}${info.idCardPicPros}</c:if><c:if test="${empty info.idCardPicPros}">${staticWebsite}img/vip/common/avatar_small.jpg</c:if>" alt="身份证正面图片">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        身份证反面
                                    </div>
                                    <div class="controls">
                                        <img width="200" height="200" src="<c:if test="${!empty info.idCardPicCons}">${uploadStaticWebsite}${info.idCardPicCons}</c:if><c:if test="${empty info.idCardPicCons}">${staticWebsite}img/vip/common/avatar_small.jpg</c:if>" alt="身份证反面图片">
                                    </div>
                                </div>
                                <div class="control-group J_cardImg">
                                    <label class="control-label">
                                        与会员合影
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <img width="200" height="200" src="<c:if test="${!empty info.suretyPic}">${uploadStaticWebsite}${info.suretyPic}</c:if><c:if test="${empty info.suretyPic}">${staticWebsite}img/vip/common/avatar_small.jpg</c:if>" alt="与会员合影">
                                    </div>
                                </div>
                                <h3>个人学校</h3>
                                <div class="control-group">
                                    <label class="control-label">
                                        学校
                                    </label>
                                    <div class="controls">
                                        ${regionSchool.schoolRegionName} ${regionSchool.name}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        专业班级
                                    </label>
                                    <div class="controls">
                                        ${info.classOrDepartment}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        入学日期
                                    </label>
                                    <div class="controls">
                                        <fmt:formatDate value="${info.entrance}" type="both" pattern="yyyy-MM-dd"/>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        职位
                                    </label>
                                    <div class="controls">
                                        ${info.position}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        学校地址
                                    </label>
                                    <div class="controls">
                                        ${info.schoolOrCompanyAdd}
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        宿舍地址
                                    </label>
                                    <div class="controls">
                                        ${info.presentAddress}
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
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
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
                                        </tr>
                                        </thead>
                                        <tbody id="J_otherTemplate">
                                        <c:forEach items="${contactsList}" var="contacts">
                                            <tr data-contact-id="${contacts.id}">
                                                <td>
                                                    联系人
                                                    <span class="required">*</span>
                                                </td>
                                                <td class="relation">${contacts.relationship}</td>
                                                <td class="name">${contacts.name}</td>
                                                <td class="phone">${contacts.mobile}</td>
                                                <td class="work">${contacts.company}</td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                    <div class="controlp-group">
                                        <label class="control-label">
                                            备注
                                        </label>
                                        <div class="controls">
                                            ${info.comments}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-footer form-footer-margin">
                    <button type="button" class="btn btn-yellow btn-refresh" onclick="history.go(-1);">返回</button>
                </div>
            </form>
        </div>
    </div>
</div>