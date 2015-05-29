<%@ page contentType="text/html;charset=UTF-8" %>
<div class="holder">
    <div class="content">
        <h1>白条订单查询</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a href="${website}home">会员中心</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>白条订单查询</a>
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
                            <label class="control-label">订单编号</label>

                            <div class="controls">
                                <input type="text" placeholder="搜索..." class="w300 no-bgimg" data-valid-rule="isInteger|isNull" data-valid-tip="请输入订单编号|订单编号输入有误，请重新输入" name="id"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                开始时间
                            </label>
                            <div class="controls">
                                <input type="text" data-type="date" data-format="YYYY-MM-DD HH:mm" class="w300" readonly="readonly" name="startTime" value="" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                结束时间
                            </label>
                            <div class="controls">
                                <input type="text" data-type="date" data-format="YYYY-MM-DD HH:mm"  class="w300" readonly="readonly" name="endTime" value="" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">
                                状态
                            </label>
                            <div class="controls">
                                <select class="w300 J_orderSecondType" name="status">
                                    <option value="0" selected="">全部</option>
                                    <option value="1">审核中订单</option>
                                    <option value="2">还款中订单</option>
                                    <option value="3">还款完成订单</option>
                                    <option value="4">取消订单</option>
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
                <div class="box-body">
                    <form class="J_operForm">
                        <table class="table-responsive">
                            <thead>
                            <tr>
                                <th class="table-width-8">订单编号</th>
                                <th class="table-width-15">订单状态</th>
                                <th class="table-width-7">金额(元)</th>
                                <th class="table-width-7">分期</th>
                                <th class="table-width-7">每月还款日</th>
                                <th class="table-width-10">下单时间</th>
                                <th class="table-width-10">操作</th>
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