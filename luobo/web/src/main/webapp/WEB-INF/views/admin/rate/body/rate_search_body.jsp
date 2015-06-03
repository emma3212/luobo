<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
    <div class="content">
        <h1>汇率列表</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>汇率管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a >汇率列表</a>
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
                            <label class="control-label">
                                原始货币
                            </label>
                            <div class="controls">
                                <select class="w300" name="fromCurrencyId">
                                    <option value="">全部</option>
                                     <c:forEach items="${currencyList}" var="item">
                                         <option value="${item.id}">${item.name}</option>
                                     </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                目标货币
                            </label>
                            <div class="controls">
                                <select class="w300" name="toCurrencyId">
                                    <option value="">全部</option>
                                    <c:forEach items="${currencyList}" var="item">
                                        <option value="${item.id}">${item.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                日期
                            </label>
                            <div class="controls">
                                <input type="text" readonly data-type="date" data-format="YYYY-MM-DD"  class="w300" name="date" value="" />
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
                <span><i class="fa fa-table"></i>查看汇率列表</span>
            </div>
            <div class="box-container clearfix">
                <div class="control-group">
                    <div class="pull-right dropdown-container h30 clearfix">
                        <button class="btn dropdown pull-right" id="J_drop" data-dropdown-box="J_dropCnt" data-dropdown-wait=".8" data-dropdown-evt="click">
                            操作
                            <i class="fa fa-angle-down"></i>
                        </button>
                        <ul class="dropdown-box" id="J_dropCnt">
                            <li>
                                <a href="${website}admin/product/export/excel" class="J_PDF">导出Excel</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="box-body">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th class="table-width-10">编号</th>
                            <th class="table-width-30">原始货币</th>
                            <th class="table-width-10">目标货币</th>
                            <th class="table-width-10">汇率</th>
                            <th class="table-width-20">日期</th>
                            <th class="table-width-10">操作</th>
                        </tr>
                        </thead>
                        <tbody id="J_template"></tbody>
                    </table>
                    <div id="J_pagination"></div>
                </div>
            </div>
        </div>
    </div>
</div>