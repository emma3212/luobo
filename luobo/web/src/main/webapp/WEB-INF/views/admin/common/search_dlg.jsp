<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!doctype html>
<html>
<head>
    <title>搜索用户弹出框</title>
    <%@include file="head.jsp"%>
</head>
<body style="background-color: #fff">
    <div class="content">
        <form class="form" action="" id="J_partySearchDlg">
            <div class="control-group">
                <div class="controls">
                    <input type="text" class="w200" name="key">
                    <button class="btn btn-blue btn-search" type="submit">查找</button>
                </div>

            </div>
        </form>
        <div class="box box-blue" data-fold="fold">
            <div class="box-title clearfix">
                <span>搜索结果</span>
                <div class="tools">
                    <a href="javascript:;" class="collapse"></a>
                </div>
            </div>
            <div class="box-container">
                <div class="box-body">
                    <table class="table-blue" id="J_partySearchList">
                        <thead>
                            <tr>
                                <th>姓名</th>
                                <th>工号</th>
                                <th>登录用户</th>
                                <th>所在部门</th>
                                <th>权限</th>
                            </tr>
                        </thead>
                        <tbody id="J_template">
                            <tr>
                                <td colspan="4">根据搜索条件进行查找</td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="J_pagination"></div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/template" id="J_tpl">
    {@each list as it}
        <tr>
            <td>
                <a href="javascript:;" class="label label-error J_userSelect">&{it.name}</a>
                <input type="hidden" name="partyId" value="&{it.partyId}" />
                <input type="hidden" name="name" value="&{it.name}">
            </td>
            <td>&{it.code}</td>
            <td>&{it.loginName}</td>
            <td>&{it.partyName}</td>
            <td>&{it.securityName}</td>
        </tr>
    {@/each}
    </script>
    <script>
    KISSY.ready(function(S){
        S.use('module/partySearch, widget/box', function(){
            PW.module.PartySearch.init({
                url: PW.Env.website + 'admin/search/dialog/json'
            });
        })
    })
    </script>
</body>
</html>