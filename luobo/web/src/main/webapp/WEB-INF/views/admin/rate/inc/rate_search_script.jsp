<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-order-id="&{it.id}">
        <td>&{it.id}</td>
        <td><a href="&{it.viewUrl}" target="_blank">&{it.fromCurrency}</a></td>
        <td >人民币</td>
        <td >&{it.rate}</td>
        <td>&{it.date}</td>
        <td>
            <a href="&{it.editUrl}">编辑</a>
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
                url: '${website}admin/rate/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                    //return url;
                }
            });
        });
    });
</script>