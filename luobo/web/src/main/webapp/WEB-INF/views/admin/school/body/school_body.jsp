<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
  <div class="content">
    <h1>学校管理</h1>
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
          <a>学校管理</a>
        </li>
      </ul>
    </div>
    <div class="box box-blue" data-fold="fold">
      <div class="box-title clearfix">
        <span><i class="fa fa-table"></i>查看学校列表</span>
      </div>
      <div class="box-container clearfix">
        <div class="row-fluid control-group">
          <div class="col span50">
            <button class="btn-big btn-green btn-back-add J_new">添加学校<i class="fa fa-plus"></i></button>
          </div>
        </div>
        <form class="J_form">
          <table class="table-responsive">
            <thead>
            <tr>
              <th class="table-width-30"><span class="required">*学校</span>名称</th>
              <th class="table-width-20">负责人</th>
              <th class="table-width-10">区域</th>
              <th class="table-width-10">客户数量</th>
              <th class="table-width-10">联系人电话</th>
              <th class="table-width-10">状态</th>
              <th class="table-width-10">操作</th>
            </tr>
            </thead>
            <tbody id="J_template">
            <c:forEach items="${regionSchoolList}" var="regionSchool">

              <tr data-school-id="${regionSchool.id}">
                <td>${regionSchool.name}</td>
                <td>${regionSchool.manager}</td>
                <td class="J_regin">
                  <input type="hidden" class="J_reginId" value="${regionSchool.parentId}" />
                    ${regionSchool.schoolRegionName}
                </td>
                <td>${regionSchool.customerNum}</td>
                <td>${regionSchool.phone}</td>
                <td>
                  <c:if test="${regionSchool.enabled == 0}"> 已停用 </c:if>
                  <c:if test="${regionSchool.enabled == 1}"> 已启用 </c:if>
                </td>
                <td>
                  <a class="J_edit" href="javascript:;">编辑</a> |
                  <a class="J_enlight" href="javascript:;">
                    <c:if test="${regionSchool.enabled == 0}">启用</c:if>
                    <c:if test="${regionSchool.enabled == 1}">停用</c:if>
                  </a>
                </td>
              </tr>

            </c:forEach>
            </tbody>
          </table>
        </form>

        <select class="J_reginTpl form-control w200 hidden" data-valid-rule="scale(0,10000)" name="parentId">
          <option value="0">请选择</option>
          <c:forEach items="${regionList}" var="region">
            <option value="${region.id}" <c:if test="${region.enabled == 0}">class="J_disable"</c:if>>
                ${region.name}<c:if test="${region.enabled == 0}">(已停用)</c:if>
            </option>
          </c:forEach>
        </select>

      </div>
    </div>
  </div>
</div>