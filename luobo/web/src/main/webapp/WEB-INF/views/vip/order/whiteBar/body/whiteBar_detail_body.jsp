<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="holder">
    <div class="content">
        <h1>查看订单</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a href="${website}home">会员中心</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>白条订单查询</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>查看订单</a>
                </li>
            </ul>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-paw"></i>查看订单信息</span>
            </div>
            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <h1>订单号：${whiteBarOrderDto.id}</h1>
                    <h3>白条明细</h3>
                    <div class="control-group">
                        <label class="control-label">
                            收货人姓名
                        </label>
                        <div class="controls">${whiteBarOrderDto.userName}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            联系电话
                        </label>
                        <div class="controls">${whiteBarOrderDto.userMobile}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            金额(元)
                        </label>
                        <div class="controls">${whiteBarOrderDto.amount}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            状态
                        </label>
                        <div class="controls">${whiteBarOrderDto.statusStr}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">
                            借款用途
                        </label>
                        <div class="controls">${whiteBarOrderDto.reason}</div>
                    </div>
                    <h3>还款信息</h3>
                    <table class="table-form">
                        <thead>
                        <tr>
                            <th class="table-width-8">计划还款金额(元)</th>
                            <th class="table-width-10">实际还款金额(元)</th>
                            <th class="table-width-15">最后期限</th>
                            <th class="table-width-8">还款日期</th>
                            <th class="table-width-8">状态</th>
                        </tr>
                        </thead>
                        <tbody id="J_template">
                        <c:forEach var="repay" items="${repayList}">
                            <tr data-order-id="${repay.id}" <c:if test="${repay.isOvertime == true}">class="error-tip"</c:if>>
                                <td>${repay.planRepayMoney}</td>
                                <td>${repay.actualRepayMoney}</td>
                                <td><fmt:formatDate value="${repay.repayDeadline}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td><fmt:formatDate value="${repay.actualRepayDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
                                    <c:if test="${repay.status == 1}">
                                        <i class="bigger fa fa-check-circle"></i>
                                    </c:if>
                                    <c:if test="${repay.status == 0}">
                                        <i class="bigger fa fa-close"></i>
                                        <c:if test="${repay.allRepaid == false}">
                                            <button type="button" class="btn btn-yellow J_toPay">支付</button>
                                        </c:if>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="form-footer form-footer-margin">
                        <button type="button" class="btn btn-blue btn-refresh btn-margin-right" onclick="window.history.go(-1);">返回</button>
                    </div>
                    <div class="J_payForm"></div>
                </div>
            </div>
        </div>
    </div>
</div>