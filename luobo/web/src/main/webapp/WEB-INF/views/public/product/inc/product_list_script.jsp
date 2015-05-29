<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="tpl">
    {@each list as it}
    <li>
        <a href="&{it.viewUrl}" target="_blank">
            <img width="230" height="336" src="&{it.url}" />
        </a>
    </li>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/classify',function(){
            PW.page.Classify({
                renderTo: '#J_pagination',
                juicerRender: '#tpl',
                dataRender: '#J_template',
                pageSize: 9,
                url: '${website}product/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                    return url+'/'+ page;
                    //return url;
                }
            });
        });
    });
</script>