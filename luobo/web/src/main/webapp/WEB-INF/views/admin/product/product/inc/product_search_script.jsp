<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td><a href="&{it.viewUrl}" target="_blank">&{it.name}</a></td>
        <td >&{it.code}</td>
        <td >&{it.price}</td>
        <td class="J_productStatus">
            &{it.enabled}
        </td>
        <td>&{it.createdTime}</td>
        <td>
            <a href="&{it.editUrl}">编辑</a>&nbsp;|
            <a class="J_enlight" href="javascript:;">
                {@if it.status == 0}上架{@/if}
                {@if it.status == 1}下架{@/if}
            </a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('widget/calendar, page/product/product-list', function(){
            PW.page.product.ProductList({
                renderTo: '#J_pagination',
                juicerRender: '#tpl',
                dataRender: '#J_template',
                pageSize: 10,
                url: '${website}admin/product/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                    //return url;
                }
            });
        });
    });
</script>