<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>

<div class="holder">
    <div class="content">
        <div class="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>站点展示管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>新品推荐管理</a>
                </li>
            </ul>
        </div>
        <div class="alert alert-warning">
            <strong>提示：</strong> 新品推荐商品图片尺寸大小为：228 * 340 (高 * 宽)！
        </div>
        <div class="box box-blue" data-fold="fold">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>新品推荐展示列表</span>
            </div>
            <div class="box-container clearfix">
                <div class="row-fluid control-group">
                    <div class="col span50">
                        <button class="btn-big btn-green btn-back-add J_new" type="button">
                            添加链接
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <form class="J_form">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th class="table-width-20">商品名称</th>
                            <th class="table-width-20 red">ID <span class="required">*</span></th>
                            <th class="table-width-30">图片地址</th>
                            <th class="table-width-20 red">排序 <span class="required">*</span></th>
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