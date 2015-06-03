<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<div class="holder">
    <div class="content">
        <h1>币种管理</h1>

        <div class="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>币种管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>币种管理</a>
                    <i class="icon-angle-right"></i>
                </li>
            </ul>
        </div>
        <div class="box box-blue" data-fold="fold">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>查看币种</span>
            </div>
            <div class="box-container clearfix">
                <div class="row-fluid control-group">
                    <div class="col span50">
                        <button class="btn-big btn-green btn-back-add J_new" type="button">
                            添加币种
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <form class="J_form">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th class="table-width-20">币种名称</th>
                            <th class="table-width-10">操作</th>
                        </tr>
                        </thead>
                        <tbody id="J_template">
                        <c:choose>
                            <c:when test="${list != null && fn:length(list) != 0}">
                                <c:forEach items="${list}" var="s">
                                    <tr data-type-id="${s.id}">
                                        <td>${s.name}</td>
                                        <td>
                                            <a class="J_edit" href="javascript:;">编辑</a>
                                            <span>|</span>
                                            <a class="J_enlight" href="javascript:;">删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <td colspan="4">暂无数据!</td>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </form>
                <div id="J_pagination"></div>
            </div>
        </div>
    </div>
</div>