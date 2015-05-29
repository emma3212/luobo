<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="holder">
    <div class="content">
        <h1>会员列表</h1>
        <div class="crumb">
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
                    <a>会员列表</a>
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
                                <select class="w100 J_select" name="key">
                                    <option data-valid="isMobile|isNull" data-tip="请输入手机号码|手机号码有误，请重新输入" value="1">手机号</option>
                                    <option data-tip="0-10个字符，请输入姓名|姓名输入有误，请重新输入"
                                            data-valid="length(0,11)|isNull" value="2">姓名</option>
                                </select>
                                <input type="text" placeholder="搜索..." class="w182 no-bgimg" name="value"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                会员类型
                            </label>
                            <div class="controls">
                                <select class="w300 J_grade" name="typeId">
                                    <option class="J_all" value="0">全部</option>
                                    <c:forEach items="${typeList}" var="type" varStatus="s">
                                        <option value="${s.index + 1}" data-type-id="${type.id}">${type.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                状态
                            </label>
                            <div class="controls">
                                <select class="w300" name="status">
                                    <option value="-1" <c:if test="${statusId==-1}">selected="selected" </c:if>>全部</option>
                                    <option value="3"  <c:if test="${statusId==3}"> selected="selected" </c:if>>未审核</option>
                                    <option value="2"  <c:if test="${statusId==2}">selected="selected" </c:if>>待审核</option>
                                    <option value="0"  <c:if test="${statusId==0}">selected="selected" </c:if>>停用</option>
                                    <option value="1"  <c:if test="${statusId==1}">selected="selected" </c:if>>正常</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-footer col span70 form-footer-reset">
                            <button class="btn btn-blue btn-search J_search btn-margin-right" type="submit">搜索</button>
                            <button class="btn btn-yellow btn-refresh" type="reset">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>查看会员列表</span>
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
                                <a href="${website}admin/member/list/export/excel" class="J_excel">导出Excel</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <form class="J_operForm">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th class="table-width-10">姓名</th>
                            <th class="order pagination-reorder min-width" data-order-key="gender">性别</th>
                            <th class="table-width-7">联系人手机</th>
                            <th class="order pagination-reorder table-width-10" data-order-key="region">学校</th>
                            <th class="order pagination-reorder min-width" data-order-key="typeName">会员类型</th>
                            <th class="order pagination-reorder min-width" data-order-key="status">会员状态</th>
                            <th class="min-width">逾期类型</th>
                            <th class="order pagination-reorder table-width-10" data-order-key="createdTime">注册日期</th>
                            <th class="table-width-20">操作</th>
                        </tr>
                        </thead>
                        <tbody id="J_template">
                        </tbody>
                    </table>
                </form>
                <div id="J_pagination"></div>
                <button id="J_upload">上传图片</button>
            </div>
        </div>
    </div>
</div>