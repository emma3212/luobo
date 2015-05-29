<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="holder">
    <div class="content">
        <h1>查看商品订单详情</h1>

        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>订单管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>商品订单管理</a>
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
                <button class="btn pull-right tab-btn"
                        onclick="window.open('${website}admin/product/order/export/${productOrderDto.id}')">导出订单信息
                </button>
            </div>
            <input type="hidden" class="J_orderId" value="${productOrderDto.id}">

            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <h3>收货人信息</h3>

                    <form class="J_form" action="" method="">
                        <div class="control-group">
                            <label class="control-label">
                                收货人姓名
                            </label>

                            <div class="controls">
                                ${productOrderDto.userName}
                                <a class="small" href="${website}admin/member/${productOrderDto.userId}">查看用户信息</a>
                                <a class="small" href="${website}admin/member/export/pdf/${productOrderDto.userId}"
                                   target="_blank">导出用户信息</a>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                联系电话
                            </label>

                            <div class="controls">${productOrderDto.userMobile}</div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                备注
                            </label>

                            <div class="controls">${productOrderDto.userComment}</div>
                        </div>
                        <h3>商品信息</h3>
                        <table class="table-form">
                            <thead>
                            <tr>
                                <th class="table-width-8">订单编号</th>
                                <th class="table-width-10">下单时间</th>
                                <th class="table-width-7">商品名称</th>
                                <th class="table-width-8">价格(元)</th>
                                <th class="table-width-8">首付(元)</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${productOrderDto.id}</td>
                                <td><fmt:formatDate value="${productOrderDto.createdTime}"
                                                    pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>${productOrderDto.productName}</td>
                                <td>${productOrderDto.productPrice}</td>
                                <td>${productOrderDto.firstPay}</td>
                            </tr>
                            </tbody>
                        </table>
                        <h3>还款信息
                            <c:if test="${productOrderDto.status == 2}">
                                <button type="button" class="btn btn-blue pull-right h-btn J_repayTogether">一键还款</button>
                            </c:if>
                        </h3>
                        <table class="table-form">
                            <thead>
                            <tr>
                                <th class="table-width-8">计划还款金额(元)</th>
                                <th class="table-width-10">实际还款金额(元)</th>
                                <th class="table-width-15">最后期限</th>
                                <th class="table-width-8">还款日期</th>
                                <th class="table-width-8">状态</th>
                                <th class="table-width-8">操作</th>
                            </tr>
                            </thead>
                            <tbody id="J_template">
                            <c:forEach var="repay" items="${repayList}">
                                <tr data-repay-id="${repay.id}"
                                    <c:if test="${repay.isOvertime == true}">class="error-tip"</c:if> >
                                    <td>${repay.planRepayMoney}</td>
                                    <td>${repay.actualRepayMoney}</td>
                                    <td><fmt:formatDate value="${repay.repayDeadline}" pattern="yyyy-MM-dd"/></td>
                                    <td><fmt:formatDate value="${repay.actualRepayDate}" pattern="yyyy-MM-dd"/></td>
                                    <c:if test="${repay.status == 1}">
                                        <td class="payment">
                                            <i class="bigger fa fa-check-circle"></i>
                                        </td>
                                    </c:if>
                                    <c:if test="${repay.status == 0}">
                                        <td class="unpayment">
                                            <i class="bigger fa fa-close"></i>
                                        </td>
                                    </c:if>
                                    <td>
                                        <c:if test="${productOrderDto.status != 1}">
                                            <a class="J_edit" href="javascript:;">编辑</a> |
                                        </c:if>
                                        <a class="J_tip" href="javascript:;">备注</a>
                                        <input type="hidden" class="J_tipVal" value="${repay.comment}"/>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <div class="control-group">
                            <label class="control-label">
                                管理员备注：
                            </label>

                            <div class="controls">
                                ${productOrderDto.adminComment}
                            </div>
                        </div>
                        <div class="form-footer form-footer-margin">
                            <button type="button" class="btn btn-yellow btn-refresh" onclick="window.history.go(-1);">
                                返回
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>