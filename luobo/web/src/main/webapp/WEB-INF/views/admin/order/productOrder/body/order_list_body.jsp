<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
    <div class="content">
        <h1>订单列表</h1>

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
                    <a>订单列表</a>
                </li>
            </ul>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-paw"></i>筛选条件</span>
            </div>
            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <form class="J_searchForm">
                        <div class="control-group">
                            <label class="control-label">搜索</label>

                            <div class="controls">
                                <select class="w150 J_searchKey J_select" is-repeat="false" name="">
                                    <option data-name="id" data-valid="isInteger|isNull" data-tip="请输入订单编号|订单编号输入有误，请重新输入"
                                            value="1">订单编号
                                    </option>
                                    <option data-name="userName" data-tip="0-10个字符，请输入申请人姓名|申请人姓名输入有误，请重新输入"
                                            data-valid="length(0,11)|isNull" value="5">申请人姓名
                                    </option>
                                    <option data-name="userMobile" data-tip="请输入电话| 电话输入有误，请重新输入" data-valid="isMobile|isNull"
                                            value="6">电话
                                    </option>
                                </select>
                                <input type="text" placeholder="搜索..." class="w150 no-bgimg" name="id"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                开始时间
                            </label>

                            <div class="controls">
                                <input type="text" data-type="date" data-format="YYYY-MM-DD HH:mm" class="w300" readonly="readonly" name="startTime"
                                       value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                结束时间
                            </label>

                            <div class="controls">
                                <input type="text" data-type="date" data-format="YYYY-MM-DD HH:mm" class="w300" readonly="readonly" name="endTime"
                                       value=""/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                状态
                            </label>

                            <div class="controls">
                                <select class="w332 J_orderSecondType" name="status">
                                    <option value="0"<c:if test="${statusId==0}">selected="selected" </c:if>>全部</option>
                                    <option value="1"<c:if test="${statusId==1}">selected="selected" </c:if>>审核中订单</option>
                                    <option value="2"<c:if test="${statusId==2}">selected="selected" </c:if>>还款中订单</option>
                                    <option value="3"<c:if test="${statusId==3}">selected="selected" </c:if>>还款完成订单</option>
                                    <option value="4"<c:if test="${statusId==4}">selected="selected" </c:if>>取消订单</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-footer col span70 form-footer-reset">
                            <button class="btn btn-blue btn-search btn-margin-right" type="submit">搜索</button>
                            <button class="btn btn-yellow btn-refresh" type="reset">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>查看订单列表</span>
            </div>
            <div class="box-container clearfix">
                <div class="control-group">
                    <div class="pull-right dropdown-container h30 clearfix">
                        <button class="btn dropdown pull-right" id="J_drop" data-dropdown-box="J_dropCnt"
                                data-dropdown-wait=".8" data-dropdown-evt="click">
                            操作<i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-box" id="J_dropCnt">
                            <li><a href="${website}admin/product/order/export" class="J_excel" target="_blank">导出Excel</a></li>
                        </ul>
                    </div>
                </div>
                <div class="box-body">
                    <form class="J_operForm">
                        <table class="table-responsive">
                            <thead>
                            <tr>
                                <th class="table-width-8">订单编号</th>
                                <th class="table-width-18">商品名称</th>
                                <th class="table-width-8">姓名</th>
                                <th class="order pagination-reorder table-width-15" data-order-key="status">订单状态</th>
                                <th class="table-width-15">联系电话</th>
                                <th class="table-width-7">价格(元)</th>
                                <th class="table-width-7">首付(元)</th>
                                <th class="order pagination-reorder table-width-7" data-order-key="payPeriods">分期</th>
                                <th class="order pagination-reorder table-width-10" data-order-key="createdTime">下单时间</th>
                                <th class="table-width-7">操作</th>
                            </tr>
                            </thead>
                            <tbody id="J_template"></tbody>
                        </table>
                    </form>
                    <div id="J_pagination"></div>
                </div>
            </div>
        </div>
    </div>
</div>