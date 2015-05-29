<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-page-id="&{it.id}">
        <td class="J_name">&{it.title}</td>
        <td class="J_link">${website}${contentLink}/&{it.id}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a> |
            <a class="J_del" href="javascript:;">删除</a> |
            <a href="${website}admin/content/page/content/&{it.id}/update" class="J_enter">修改页面内容</a> |
            <a href="${website}${contentLink}/&{it.id}">浏览</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="editTpl">
    <tr data-page-id="&{page.id}" data-oper-type="&{page.type}">
        <td>
            <input type="hidden" name="id" value="&{page.id}" />
            <input type="text" class="form-control input-small valid-icon J_pageName" data-valid-rule="notNull & length(0,31)" name="title" value="&{page.name}" /></td>
        <td class="J_link">&{page.link}</td>
        <td>
            <a class="J_save" href="javascript:;">保存</a> |
            <a class="J_cancel" href="javascript:;">取消</a> |
            <a href="${website}admin/content/page/content/&{page.id}/update" class="J_enter">修改页面内容</a> |
            <a href="${website}${contentLink}/&{page.id}">浏览</a>
        </td>
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/content/list',function(){
            PW.page.content.List({
                renderTo: '#J_pagination',
                juicerRender: '#tpl',
                dataRender: '#J_template',
                themeCss: '.J_pagination_theme2',
                pageSize: 10,
                url: '/admin/content/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    // return url+'/'+ page;
                    return url+'/'+ page;
                }
            });
        })
    })
</script>