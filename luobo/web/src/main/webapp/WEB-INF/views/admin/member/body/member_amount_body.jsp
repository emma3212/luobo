<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="holder">
    <div class="content">
        <h1>会员信用额度管理</h1>
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
                    <a>会员信用额度管理</a>
                </li>
            </ul>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-paw"></i>筛选条件</span>
            </div>
            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <form class="J_searchForm" method="" action="">
                        <div class="control-group">
                            <label class="control-label">
                                手机号码
                            </label>
                            <div class="controls">
                                <input type="text" placeholder="" data-valid-tip="请输入手机号码|手机号码有误，请重新输入" data-valid-rule="isMobile|isNull" class="w300 no-bgimg" name="mobile"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                会员类型
                            </label>
                            <div class="controls">
                                <select class="w300" name="memberTypeId">
                                    <option class="J_all" value="0">全部</option>
                                    <c:forEach items="${memberTypeList}" var="item">
                                        <option value="${item.id}">${item.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-footer col span70 form-footer-reset">
                            <button class="btn btn-blue btn-search btn-margin-right J_search" type="submit">搜索</button>
                            <button class="btn btn-yellow btn-refresh" type="reset">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>查看会员额度列表</span>
            </div>
            <div class="box-container clearfix">
                <form class="J_operForm">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th class="table-width-10">姓名</th>
                            <th class="table-width-10">联系人手机</th>
                            <th class="table-width-10">会员类型</th>
                            <th class="table-width-10">白条信用额度(元)</th>
                            <th class="table-width-10">白条可用额度(元)</th>
                            <th class="table-width-10">随意还信用额度(元)</th>
                            <th class="table-width-10">随意还可用额度(元)</th>
                            <th class="table-width-10">最近修改时间</th>
                            <th class="table-width-10">操作</th>
                        </tr>
                        </thead>
                        <tbody id="J_template">
                        </tbody>
                    </table>
                </form>
                <div id="J_pagination"></div>
            </div>
        </div>
    </div>
</div>