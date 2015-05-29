<%@ page contentType="text/html;charset=UTF-8" %>
<div class="holder">
    <div class="content">
        <h1>商品品牌管理</h1>
        <div class="crumb">
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
                    <a>商品品牌管理</a>
                </li>
            </ul>
        </div>
        <div class="box box-blue" data-fold="fold">
            <div class="box-title clearfix">
                <span><i class="fa fa-table"></i>查看商品品牌</span>
            </div>
            <div class="box-container clearfix">
                <div class="row-fluid control-group">
                    <div class="col span50">
                        <button class="btn-big btn-green btn-back-add J_new" type="button">
                            添加品牌
                            <i class="fa fa-plus"></i>
                        </button>
                    </div>
                </div>
                <form class="J_form">
                    <table class="table-responsive">
                        <thead>
                        <tr>
                            <th class="table-width-50">品牌名称</th>
                            <th class="table-width-30">状态</th>
                            <th class="table-width-10">操作</th>
                        </tr>
                        </thead>
                        <tbody id="J_template">
                        </tbody>
                    </table>
                </form>
                <div id="J_pagination"></div>
            </div>
        </div>
    </div>
</div>