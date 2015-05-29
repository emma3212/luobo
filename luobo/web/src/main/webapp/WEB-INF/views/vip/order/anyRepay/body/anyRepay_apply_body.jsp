<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
    <div class="content">
        <h1>申请随意还</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>会员中心</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>申请随意还</a>
                </li>
            </ul>
        </div>
        <%--<c:if test="${!pass}">
        <div class="alert alert-danger">
            <strong>提示：</strong> 您当前身份未审核，无法申请随意还订单！
        </div>
        </c:if>--%>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-paw"></i>申请随意还</span>
            </div>
            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <h3>会员信息</h3>
                    <div class="control-group">
                        <label class="control-label">会员类型</label>
                        <div class="controls">${dto.memberType}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">随意还信用额度(元)</label>
                        <div class="controls">${dto.anyRepayLine}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">随意还可用额度(元)</label>
                        <div class="controls J_abledCredit">${dto.anyRepay}</div>
                    </div>
                    <h3>随意还信息</h3>
                    <form class="J_form" action="" method="POST">
                        <input type="hidden" class="J_errMsg" value="${eMsg}" />
                        <div class="control-group">
                            <label class="control-label">金额(元)</label>
                            <div class="controls">
                                <input  type="text" class="w200 valid-icon J_amount" name="applyMoney" value="0" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">借款用途</label>
                            <div class="controls">
                                <textarea class="w400 valid-icon" data-valid-rule="length(0,200)" data-valid-tip="请输入理由，200字以内|理由输入有误，请重新填写" name="reason" ></textarea>
                            </div>
                        </div>
                        <div class="form-footer form-footer-margin">
                            <button class="btn btn-blue btn-ok btn-margin-right J_save" data-loading-text="正在提交，请稍后" data-btn-type="loading"  type="submit" >保存</button>
                            <button type="reset" class="btn btn-yellow btn-refresh btn-margin-right" >重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>