<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="holder">
    <div class="content">
        <h1>管理员面板</h1>
        <div class="crumb" id="crumb">
            <button class="btn btn-red time">
                <i class="fa fa-calendar"></i>
                <span>2015年03月11日</span>
            </button>
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a href="${website}home">管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a href="#">控制面板</a>
                </li>
            </ul>
        </div>
        <!-- <a href="http://mc.pandawork.net?t=f0956ec3796c4a148f5e15cad61fc95c&m=eyJpZCI6MSwibG4iOiJzYWRtaW4iLCJ1dCI6MTAsImZsYWciOmZhbHNlfQ==">进入系统</a> -->
        <div class="container">
            <div class="row-fluid">
                <div class="col span49">
                    <div class="box box-green" data-fold="fold">
                        <div class="box-title clearfix">
                            <span><i class="fa fa-table"></i>订单统计</span>
                        </div>
                        <div class="box-container clearfix">
                            <div class="control-group">
                                <div class="pull-right clearfix">
                                    <h2>
                                        <c:set value="0" var="sum" />
                                        <c:forEach items="${orderStatusDto}" var="item">
                                            <c:set value="${sum + item.totalAmount}" var="sum" />
                                        </c:forEach>
                                        总金额：￥${sum}
                                    </h2>
                                </div>
                            </div>
                            <table class="table-responsive">
                                <thead>
                                <tr>
                                    <th>状态</th>
                                    <th>订单数量</th>
                                    <th>总金额</th>
                                </tr>
                                </thead>
                                <tbody id="J_template">
                                <c:forEach items="${orderStatusDto}" var="item">
                                <tr>
                                    <td>${item.orderStatus}</td>
                                    <td>${item.orderAmount}</td>
                                    <td>${item.totalAmount}</td>
                                </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="box box-blue" data-fold="fold">
                        <div class="box-title clearfix">
                            <span><i class="fa fa-table"></i>负责人统计</span>
                        </div>
                        <div class="box-container clearfix">
                            <table class="table-responsive">
                                <thead>
                                <tr>
                                    <th>负责人名称</th>
                                    <th>区域名称</th>
                                    <th>会员数量</th>
                                    <th>订单数量</th>
                                    <th>总金额</th>
                                </tr>
                                </thead>
                                <tbody id="J_managerTemplate">
                                <tr>
                                    <td>好人1</td>
                                    <td>净月开发区</td>
                                    <td>12</td>
                                    <td>120</td>
                                    <td>1200.11</td>
                                </tr>
                                <tr>
                                    <td>好人3</td>
                                    <td>南关区</td>
                                    <td>16</td>
                                    <td>160</td>
                                    <td>1600.12</td>
                                </tr>
                                <tr>
                                    <td>好人4</td>
                                    <td>宽城区</td>
                                    <td>12</td>
                                    <td>140</td>
                                    <td>140.123</td>
                                </tr>
                                </tbody>
                            </table>
                            <div id="J_managerPagi"></div>
                        </div>
                    </div>
                    <div class="box box-green" data-fold="fold">
                        <div class="box-title clearfix">
                            <span><i class="fa fa-table"></i>逾期订单统计</span>
                        </div>
                        <div class="box-container clearfix">
                            <div class="control-group">
                                <div class="pull-right clearfix">
                                    <h2 class="J_total"></h2>
                                </div>
                            </div>
                            <table class="table-responsive">
                                <thead>
                                <tr>
                                    <th>区域/学校</th>
                                    <th>数量</th>
                                    <th>总金额</th>
                                </tr>
                                </thead>
                                <tbody id="J_overPayTemplate">
                                <tr>
                                    <td>朝阳区</td>
                                    <td>123</td>
                                    <td>1200.00</td>
                                </tr>
                                <tr>
                                    <td>东北师范大学</td>
                                    <td>300</td>
                                    <td>1600.12</td>
                                </tr>
                                <tr>
                                    <td>吉林大学</td>
                                    <td>123</td>
                                    <td>1212.12</td>
                                </tr>
                                <tr>
                                    <td>绿园区</td>
                                    <td>25</td>
                                    <td>3400</td>
                                </tr>
                                </tbody>
                            </table>
                            <div id="J_overPayPagi"></div>
                        </div>
                    </div>
                </div>
                <div class="col span49 offset2">
                    <div class="box box-yellow" data-fold="fold">
                        <div class="box-title clearfix">
                            <span><i class="fa fa-table"></i>区域统计</span>
                        </div>
                        <div class="box-container clearfix">
                            <div class="control-group">
                                <div class="pull-right clearfix">
                                    <span class="small-tip">总会员数量：${totalMember}</span>
                                    <span class="small-tip">正式会员数量：${passMember}</span>
                                        <span class="small-tip">待审核会员数量：${waitingMember}</span>
                                    <span class="small-tip">注册数量：${noPassMember}</span>
                                </div>
                            </div>
                            <table class="table-responsive">
                                <thead>
                                <tr>
                                    <th>区域名称</th>
                                    <th>会员数量</th>
                                    <th>负责人名称</th>
                                    <th>订单数量</th>
                                    <th>总金额</th>
                                </tr>
                                </thead>
                                <tbody id="J_regionTemplate">
                                <tr>
                                    <td>好人1</td>
                                    <td>净月开发区</td>
                                    <td>12</td>
                                    <td>1200</td>
                                    <td>12</td>
                                </tr>
                                </tbody>
                            </table>
                            <div id="J_regionPagi"></div>
                        </div>
                    </div>
                    <div class="box box-red" data-fold="fold">
                        <div class="box-title clearfix">
                            <span><i class="fa fa-table"></i>学校统计</span>
                        </div>
                        <div class="box-container clearfix">
                            <table class="table-responsive">
                                <thead>
                                <tr>
                                    <th>学校名称</th>
                                    <th>会员数量</th>
                                    <th>负责人名称</th>
                                    <th>订单数量</th>
                                    <th>总金额</th>
                                </tr>
                                </thead>
                                <tbody id="J_schoolTemplate"></tbody>
                            </table>
                            <div id="J_schoolPagi"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
