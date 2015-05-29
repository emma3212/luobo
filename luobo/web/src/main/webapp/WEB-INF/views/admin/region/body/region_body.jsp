<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="holder">
  <div class="content">
    <h1>服务区域管理</h1>
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
          <a>服务区域管理</a>
        </li>
      </ul>
    </div>
    <div class="box box-blue" data-fold="fold">
      <div class="box-title clearfix">
        <span><i class="fa fa-table"></i>查看服务区域列表</span>
      </div>
      <div class="box-container clearfix">
        <div class="row-fluid control-group">
          <div class="col span50">
            <button class="btn-big btn-green btn-back-add J_new" type="button">
              添加服务区域
              <i class="fa fa-plus"></i>
            </button>
          </div>
        </div>
        <form class="J_operForm">
          <table class="table-responsive">
            <thead>
            <tr>
              <th class="table-width-40">服务区域名称</th>
              <th class="table-width-10">负责人</th>
              <th class="table-width-10">客户数量</th>
              <th class="table-width-20">联系人电话</th>
              <th class="table-width-10">状态</th>
              <th class="table-width-10">操作</th>
            </tr>
            </thead>
            <tbody id="J_template">

              <c:forEach items="${regionSchoolList}" var="regionSchool">
                <tr region-id="${regionSchool.id}" data-oper-type="update">
                  <td class="J_regionName">${regionSchool.name}</td>
                  <td class="J_manager">${regionSchool.manager}</td>
                  <td class="J_memberNum"><c:if test="${empty regionSchool.customerNum}">0</c:if><c:if test="${!empty regionSchool.customerNum}">${regionSchool.customerNum}</c:if></td>
                  <td class="J_phone">${regionSchool.phone}</td>
                  <td class="J_status">
                    <c:if test="${regionSchool.enabled == 0}">已停用</c:if>
                    <c:if test="${regionSchool.enabled == 1}">已启用</c:if>
                  </td>
                  <td>
                    <a class="J_update" href="javascript:;">编辑</a>&nbsp;|
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
      </div>
    </div>
  </div>
</div>