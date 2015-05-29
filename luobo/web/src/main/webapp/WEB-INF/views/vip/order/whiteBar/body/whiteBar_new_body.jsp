<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="holder">
    <div class="content">
        <h1>申请白条订单</h1>
        <div class="crumb" id="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a href="${website}home">会员中心</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>申请白条订单</a>
                </li>
            </ul>
        </div>
        <%--<c:if test="${!pass}">
        <div class="alert alert-danger">
            <strong>提示：</strong> 您当前身份未审核，无法申请白条订单！
        </div>
        </c:if>--%>
        <div class="box box-blue">
            <div class="box-title clearfix">
                <span><i class="fa fa-paw"></i>申请白条</span>
            </div>
            <div class="box-container clearfix">
                <div class="box-body row-fluid">
                    <h3>会员信息</h3>
                    <div class="control-group">
                        <label class="control-label">会员类型</label>
                        <div class="controls">${dto.memberType}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">白条信用额度(元)</label>
                        <div class="controls">${dto.whiteBarLine}</div>
                    </div>
                    <div class="control-group">
                        <label class="control-label">白条可用额度(元)</label>
                        <div class="controls J_abledCredit">${dto.whiteBar}</div>
                    </div>
                    <h3>白条信息</h3>
                    <form class="J_form" action="" method="">
                        <input type="hidden" class="J_errMsg" value="" />
                        <div class="control-group">
                            <label class="control-label">金额(元)</label>
                            <div class="controls">
                                <input  type="text" class="w200 valid-icon J_amount" name="amount" value="0" />
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">期数</label>
                            <div class="controls dropdown-container dropdown-container-select">
                                <input type="text" class="dropdown w200 valid-icon J_payPeriods" readonly="readonly" data-valid-tip="请输入期数|期数输入有误，请重新填写" data-valid-rule="notNull" data-dropdown-box="J_dropCnt" data-dropdown-wait=".8" data-dropdown-evt="click" name="payPeriods" value="" />
                                <ul class="dropdown-box clearfix" id="J_dropCnt">
                                    <li class="J_periods">1</li>
                                    <li class="J_periods">2</li>
                                    <li class="J_periods">3</li>
                                    <li class="J_periods">4</li>
                                    <li class="J_periods">5</li>
                                    <li class="J_periods">6</li>
                                    <li class="J_periods">7</li>
                                    <li class="J_periods">8</li>
                                    <li class="J_periods">9</li>
                                    <li class="J_periods">10</li>
                                    <li class="J_periods">11</li>
                                    <li class="J_periods">12</li>
                                    <li class="J_periods">13</li>
                                    <li class="J_periods">14</li>
                                    <li class="J_periods">15</li>
                                    <li class="J_periods">16</li>
                                    <li class="J_periods">17</li>
                                    <li class="J_periods">18</li>
                                    <li class="J_periods">19</li>
                                    <li class="J_periods">20</li>
                                    <li class="J_periods">21</li>
                                    <li class="J_periods">22</li>
                                    <li class="J_periods">23</li>
                                    <li class="J_periods">24</li>
                                </ul>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">月供：</label>

                            <div class="controls">
                                <span class="J_repayInfo">￥ 0</span>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">借款用途</label>
                            <div class="controls">
                                <textarea class="w400 valid-icon" data-valid-rule="length(0,200)" data-valid-tip="请输入借款用途，200字以内|借款用途输入有误，请重新填写" name="reason"></textarea>
                            </div>
                        </div>
                        <div class="form-footer form-footer-margin">
                            <button type="submit" class="btn btn-blue btn-ok btn-margin-right J_save" data-loading-text="正在提交，请稍后" data-btn-type="loading" >保存</button>
                            <button type="reset" class="btn btn-yellow btn-refresh btn-margin-right">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>