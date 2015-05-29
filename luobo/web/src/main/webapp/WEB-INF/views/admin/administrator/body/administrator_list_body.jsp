<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<div class="holder">
    <div class="content">
        <h1>管理员管理</h1>

        <div class="crumb">
            <ul class="clearfix">
                <li>
                    <i class="icon icon-home"></i>
                    <a>管理员面板</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>系统配置管理</a>
                    <i class="icon-angle-right"></i>
                </li>
                <li>
                    <a>管理员管理</a>
                </li>
            </ul>
        </div>
        <div class="box box-blue" data-fold="fold">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>查看管理员列表</span>
            </div>
            <div class="box-container clearfix">
                <div class="row-fluid control-group">
                    <div class="col span50">
                        <button class="btn-big btn-green btn-back-add J_new" type="button">
                            添加管理员
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <form class="J_operForm">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>状态</th>
                            <th class="table-width-20">操作</th>
                        </tr>
                        </thead>
                        <tbody id="J_template">
                        </tbody>
                    </table>
                </form>
            </div>
        </div>
    </div>
</div>