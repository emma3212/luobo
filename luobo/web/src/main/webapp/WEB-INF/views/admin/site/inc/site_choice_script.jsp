<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-product-id="&{it.id}">
        <td>&{it.name}</td>
        <td>&{it.pid}</td>
        <td>&{it.url}</td>
        <td>&{it.rank}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a> |
            <a class="J_del" href="javascript:;">删除</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="editTpl">
    <tr data-product-id="&{id}" data-type="&{type}">
        <td class="J_productName">&{name}</td>
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="isInteger" name="pid" value="&{pid}" />
        </td>
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="notNull" name="url" value="&{url}" />
        </td>
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="isInteger" name="rank" value="&{rank}" />
        </td>
        <td>
            <a class="J_save" href="javascript:;">保存</a> |
            <a class="J_cancel" href="javascript:;">取消</a>
        </td>
    </tr>
</script>
<script type="text/template" id="saveTpl">
    <tr data-product-id="&{id}">
        <td>&{name}</td>
        <td>&{pid}</td>
        <td>&{url}</td>
        <td>&{rank}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a> |
            <a class="J_del" href="javascript:;">删除</a>
        </td>
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/siteMange/img-mange',function(){
            PW.page.siteMange.ImgManage({
                pagi: {
                    renderTo:'#J_pagination',
                    juicerRender:'#tpl',
                    dataRender:'#J_template',
                    extraParam: {typeId: ${typeId}},
                    url: '/admin/site/product/ajax/list',
                    configUrl: function(url,page,me,prevPaginationData){
                        return url+'/'+ page;
                    }
                },
                typeId:${typeId}
            });
        })
    })
</script>