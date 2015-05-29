<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="holder">
    <div class="content">
        <h1>编辑商品</h1>
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
                    <a>商品列表</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>编辑商品</a>
                </li>
            </ul>
        </div>
        <div class="tab tab-horizon tab-red">
            <ul class="tab-nav clearfix">
                <li class="active">
                    <a href="javascript:;">基本信息</a>
                </li>
                <li >
                    <a href="javascript:;">商品描述</a>
                </li>
                <li >
                    <a href="javascript:;">商品备注</a>
                </li>
            </ul>
            <form data-fold="fold" class="box box-blue no-margin-box J_addForm" autoComplete="off" action="${website}admin/product/update" method="post">
                <!-- 套返回的错误信息 -->
                <input type="hidden" class="J_showErrInp" value="${errorMsg}" name="">
                <input type="hidden" class="J_showErrInp" value="PUT" name="_method">
                <input type="hidden" class="J_showErrInp" value="${product.id}" name="id">
                <div class="tab-panel tab-no-border">
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>填写商品信息</span>
                        </div>
                        <div class="box-container show-parent">
                            <div class="box-body">
                                <div class="control-group">
                                    <label class="control-label">
                                        商品名称
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="1-60个字符，请输入商品名称|商品名称有误，商品名称必须是1到60个字符，请重新填写。" data-valid-rule="length(0,61)" name="name" value="${product.name}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        商品编码
                                        <span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="1-60个字符，请输入商品编码|商品编码有误，商品编码必须是1到60个字符，请重新填写。" data-valid-rule="length(0,61)" name="code" value="${product.code}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        商品副标题
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="1-60个字符或者为空，请输入商品副标题|商品副标题有误，商品副标题必须为1-60个字符或者为空，请重新填写" data-valid-rule="length(0,61)|isNull" name="title" value="${product.title}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        所属品牌
                                        <span class="required">*</span></label>
                                    <div class="controls">
                                        <select class="J_brand" data-valid-tip="|所属品牌选择有误，请重新选择" data-valid-rule="scale(0,1000)" name="brandId">
                                            <option value="0">--请选择--</option>
                                            <c:forEach items="${brandList}" var="brand">
                                                <option <c:if test="${brand.enabled==0}">class="J_disable"</c:if> value="${brand.id}" <c:if test="${brand.id == product.brandId}">selected="selected"</c:if>>${brand.brandName}<c:if test="${brand.enabled==0}">(已停用)</c:if></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        商品分类
                                        <span class="required">*</span></label>
                                    <div class="controls">
                                        <select class="J_parentType" data-valid-tip="|所属商品分类选择有误，请重新选择" data-valid-rule="scale(0,1000)" name="fatherCategoryId">
                                            <option value="0">--请选择--</option>
                                            <!-- 套已停用 -->
                                            <c:forEach items="${productFatherCategoryList}" var="item">
                                                <option <c:if test="${item.enabled==0}">class="J_disable"</c:if> value="${item.id}" <c:if test="${item.id == product.fatherCategoryId}">selected="selected"</c:if>>${item.name}<c:if test="${item.enabled==0}">(已停用)</c:if></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        子分类
                                        <span class="required">*</span></label>
                                    <div class="controls">
                                        <select class="J_sonType" data-valid-tip="|子分类选择有误，请重新选择" data-valid-rule="scale(0,1000)" name="categoryId">
                                            <option value="0">--请选择--</option>
                                            <!-- 套已停用 -->
                                            <c:forEach items="${productCategoryList}" var="item">
                                                <option <c:if test="${item.enabled==0}">class="J_disable"</c:if>value="${item.id}" <c:if test="${item.id == product.categoryId}">selected="selected"</c:if>>${item.name}<c:if test="${item.enabled==0}">(已停用)</c:if></option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        销售价格(元)<span class="required">*</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="请输入销售价格，价格必须为数字|销售价格有误，价格必须为数字，请重新填写" data-valid-rule="isFloat" name="price" value="${product.price}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        产品图片地址
                                    </label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon J_productPicInp" name="url" value="${product.url}" />
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label">
                                        排序
                                        <span class="required">*</span></label>
                                    <div class="controls">
                                        <input type="text" class="w200 valid-icon" data-valid-tip="请输入排序，排序必须为数字|排序有误，排序必须为数字，请重新填写" data-valid-rule="length(-1,11)&isInteger" name="rank" value="${product.rank}" />
                                    </div>
                                </div>
                            </div>
                            <img src="${product.url}" onerror="javascript:this.src='${staticWebsite}img/admin/common/default-img.jpg'" class="show-picture J_productPic" alt="产品图片">
                        </div>
                    </div>
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>添加商品信息</span>
                        </div>
                        <div class="box-container">
                            <div class="box-body">
                                <div class="control-group">
                                    <label class="control-label">
                                        描述：
                                    </label>
                                    <div class="controls">
                                        <textarea id="editor1" class="ckeditor w200" rows="6" name="desc" >${product.desc}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-content">
                        <div class="box-title clearfix">
                                    <span >
                                        <i class="fa fa-reorder"></i>
                                    </span>
                            <span>添加商品信息</span>
                        </div>
                        <div class="box-container">
                            <div class="box-body">
                                <div class="control-group">
                                    <label class="control-label">
                                        备注：
                                    </label>
                                    <div class="controls">
                                        <textarea class="w400" data-valid-tip="200个字符以内，请输入备注信息|备注有误，请重新填写" data-valid-rule="length(-1,201)" name="remark">${product.remark}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-footer form-footer-margin">
                    <button class="btn btn-blue btn-ok btn-margin-right" data-loading-text="正在提交，请稍后" data-btn-type="loading" type="submit">保存</button>
                    <button type="button" class="btn btn-yellow btn-refresh"
                            onclick="window.location.href='${website}admin/product/list'">返回
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>