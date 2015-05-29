<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="managerTpl">
    {@each list as it}
    <tr data-id="&{it.id}">
        <td>&{it.manager}</td>
        <td>&{it.region}</td>
        <td>&{it.memberAmount}</td>
        <td>&{it.orderAmount}</td>
        <td>&{it.totalAmount}</td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="regionTpl">
    {@each list as it}
    <tr data-id="&{it.id}">
        <td>&{it.region}</td>
        <td>&{it.memberAmount}</td>
        <td>&{it.manager}</td>
        <td>&{it.orderAmount}</td>
        <td>&{it.totalAmount}</td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="schoolTpl">
    {@each list as it}
    <tr data-id="&{it.id}">
        <td>&{it.region}</td>
        <td>&{it.memberAmount}</td>
        <td>&{it.manager}</td>
        <td>&{it.orderAmount}</td>
        <td>&{it.totalAmount}</td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="overPayTpl">
    {@each list as it}
    <tr data-id="&{it.id}">
        <td>&{it.region}</td>
        <td>&{it.orderAmount}</td>
        <td>&{it.totalAmount}</td>
    </tr>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/index/index',function(){
            PW.page.Index.manager({
                renderTo: '#J_managerPagi',
                juicerRender: '#managerTpl',
                dataRender: '#J_managerTemplate',
                pageSize: 10,
                async: false,
                url: '${website}admin/information/ajax/list/manager',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                }
            });
            PW.page.Index.school({
                renderTo: '#J_schoolPagi',
                juicerRender: '#schoolTpl',
                dataRender: '#J_schoolTemplate',
                pageSize: 10,
                async: false,
                url: '${website}admin/information/ajax/list/school',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                }
            });
            PW.page.Index.region({
                renderTo: '#J_regionPagi',
                juicerRender: '#regionTpl',
                dataRender: '#J_regionTemplate',
                pageSize: 10,
                async: false,
                url: '${website}admin/information/ajax/list/region',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                }
            });
            PW.page.Index.overPay({
                renderTo: '#J_overPayPagi',
                juicerRender: '#overPayTpl',
                dataRender: '#J_overPayTemplate',
                pageSize: 10,
                async: false,
                url: '${website}admin/information/ajax/list/overdue',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                }
            });
        });
    });
</script>
