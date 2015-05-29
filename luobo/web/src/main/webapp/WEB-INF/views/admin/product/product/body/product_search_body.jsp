<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
    <div class="content">
        <h1>商品列表</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>商品管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a >商品列表</a>
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
                                编码
                            </label>
                            <div class="controls">
                                <input type="text" class="w300" data-valid-rule="length(-1,61)" data-valid-tip="0-60个字符，请输入编码|编码有误，编码为数字或字符，请重新填写" name="code" value="" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                名称
                            </label>
                            <div class="controls">
                                <input type="text" class="w300" data-valid-rule="length(-1,61)" data-valid-tip="0-60个字符，请输入名称|名称有误，请重新填写"  name="name" value="" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                开始时间
                            </label>
                            <div class="controls">
                                <input type="text" readonly data-type="date" data-format="YYYY-MM-DD HH:mm"  class="w300" name="startTime" value="" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                结束时间
                            </label>
                            <div class="controls">
                                <input type="text" readonly data-type="date" data-format="YYYY-MM-DD HH:mm"  class="w300" name="endTime" value="" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                价格区间
                            </label>
                            <div class="controls">
                                <select class="w300" name="priceId" data-valid-rule="scale(0,1000,1)">
                                    <option value="0">全部</option>
                                    <option value="1">0-1000</option>
                                    <option value="2">1000-2000</option>
                                    <option value="3">2000-3000</option>
                                    <option value="4">3000-4000</option>
                                    <option value="5">4000-5000</option>
                                    <option value="6">5000以上</option>
                                </select>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                状态
                            </label>
                            <div class="controls">
                                <select class="w300" name="status">
                                    <option value="">全部</option>
                                    <option value="1">已上架</option>
                                    <option value="0">已下架</option>
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
                <span><i class="fa fa-table"></i>查看商品列表</span>
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
                            <th class="table-width-10">商品编号</th>
                            <th class="table-width-30">商品名称</th>
                            <th class="table-width-10">商品编码</th>
                            <th class="table-width-10">商品价格(元)</th>
                            <th class="table-width-10">状态</th>
                            <th class="table-width-20">创建日期</th>
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