<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 刷列表模板 -->
<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-product-id="&{it.id}" data-type="edit">
        <td class="J_productName">&{it.name}</td>
        <td>
            &{it.fatherName}
        </td>
        <td class="J_status">
            {@if it.status == 1}已启用{@/if}
            {@if it.status == 0}已停用{@/if}
        </td>
        <td>
            <a class="J_update" href="javascript:;">编辑</a> &nbsp;|
            <a class="J_enlight" href="javascript:;">
                {@if it.status == 0}启用{@/if}
                {@if it.status == 1}停用{@/if}
            </a>
        </td>
        {@if it.fatherId == 0}
        <td class="J_subclassification"><a  href="javascript:;">子分类</a></td>
        {@/if}
    </tr>
    {@/each}
</script>
<script type="text/template" id="editTpl">
    <tr data-product-id="&{id}" data-type="&{type}">
        <td>
            <input type="text" class="form-control input-small valid-icon J_productName" data-valid-rule="length(0,11)" name="name" value="&{name}" />
        </td>
        <td>
            &{fatherName}
        </td>
        <td  class="J_status">
            &{presentStatus}
        </td>
        <td>
            <a class="J_save" href="javascript:;">保存</a> &nbsp;|
            <a class="J_cancel" href="javascript:;">取消</a>
        </td>
        {@if fatherId == 0}
        <td><a class="J_subclassification" href="javascript:;">子分类</a></td>
        {@/if}
    </tr>
</script>
<script type="text/template" id="saveTpl">
    <tr data-product-id="&{id}" data-type="edit">
        <td class="J_productName">&{name}</td>
        <td>
            &{fatherName}
        </td>
        <td  class="J_status">
            &{presentStatus}
        </td>
        <td>
            <a class="J_update" href="javascript:;">编辑</a> &nbsp;|
            <a class="J_enlight" href="javascript:;">
                &{status}
            </a>
        </td>
        {@if fatherId == 0}
        <td><a class="J_subclassification" href="javascript:;">子分类</a></td>
        {@/if}
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/product/product-type',function(){
            PW.page.product.productType({
                renderTo:'#J_pagination',
                juicerRender:'#tpl',
                dataRender:'#J_template',
                url: '${website}admin/product/category/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                }
            });
        })
    })
</script>