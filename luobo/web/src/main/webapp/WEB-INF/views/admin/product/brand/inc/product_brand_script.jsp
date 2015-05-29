<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-type-id="&{it.id}">
        <td>&{it.brandName}</td>
        <td> {@if it.enabled == 1}已启用{@/if}
                  {@if it.enabled == 0}已停用{@/if}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a> |
            <a class="J_enlight" href="javascript:;">
                {@if it.enabled == 0}启用{@/if}
                {@if it.enabled == 1}停用{@/if}
            </a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="editTpl">
    <tr data-type-id="&{id}" data-type="&{type}">
        <td>
            <input type="text" class="form-control input-small valid-icon" data-valid-rule="length(0,11)" name="brandName" value="&{brandName}" />
        </td>
        <td>
            &{statusStr}
        </td>
        <td>
            <a class="J_save" href="javascript:;">保存</a> |
            <a class="J_cancel" href="javascript:;">取消</a>
        </td>
    </tr>
</script>
<script type="text/template" id="saveTpl">
    <tr data-type-id="&{id}">
        <td>&{brandName}</td>
        <td>&{statusStr}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a> |
            <a class="J_enlight" href="javascript:;">&{status}</a>
        </td>
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/product/brand',function(){
            PW.page.product.Brand({
                renderTo:'#J_pagination',
                juicerRender:'#tpl',
                dataRender:'#J_template',
                url: '${website}admin/product/brand/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                }
            });
        })
    })
</script>