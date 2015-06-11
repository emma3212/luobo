<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="holder">
    <div class="content">
        <h1>添加汇率</h1>
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
                    <a>添加汇率</a>
                </li>
            </ul>
        </div>
        <div class="tab tab-horizon tab-red">
            <ul class="tab-nav clearfix">
                <li class="active">
                    <a href="javascript:;">基本信息</a>
                </li>
            </ul>
            <form data-fold="fold" class="box box-blue no-margin-box J_addForm" autoComplete="off" action="${website}admin/rate/new" method="post">
                <!-- 套返回的错误信息 -->
                <input type="hidden" class="J_showErrInp" value="${errorMsg}" name="">
                <div class="tab-panel tab-no-border">
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>填写汇率信息</span>
                        </div>
                        <div class="box-container show-parent">
                            <div class="box-body">
                                <div class="control-group">
                                    <label class="control-label">
                                        原始货币
                                        <span class="required">*</span></label>
                                    <div class="controls">
                                        <select class="J_brand" data-valid-tip="|原始货币选择有误，请重新选择" data-valid-rule="scale(0,1000)" name="fromCurrencyId">
                                            <option value="0">--请选择--</option>
                                            <c:forEach items="${currencyList}" var="item">
                                                <option value="${item.id}" <c:if test="${item.id == rate.fromCurrencyId}">selected="selected"</c:if>>${item.name} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        目标货币
                                        <span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="hidden" class="w200" name="toCurrencyId" value="1">
                                        人民币

                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        日期<span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" data-type="date" data-format="YYYY-MM-DD"  class="w200" name="date" value="${rate.date}">
                                        </input>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        汇率<span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="请输入汇率，汇率必须为数字|汇率有误，汇率必须为数字，请重新填写" data-valid-rule="isFloat" name="rate" value="${rate.rate}"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-footer form-footer-margin">
                    <button class="btn btn-blue btn-ok btn-margin-right" data-loading-text="正在提交，请稍后" data-btn-type="loading" type="submit">保存</button>
                    <button class="btn btn-yellow btn-refresh J_reset" type="reset" >重置</button>
                </div>
            </form>
        </div>
    </div>
</div>