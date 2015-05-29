<%@ page contentType="text/html;charset=UTF-8" %>

<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-member-id="&{it.id}">
        <td class="name">&{it.name}</td>
        <td class="gender">&{it.gender}</td>
        <td class="mobile">&{it.mobile}</td>
        <td class="region">&{it.region}</td>
        <td class="type">&{it.typeName}</td>
        <td class="status">
            {@if it.status == 3}未审核{@/if}
            {@if it.status == 2}待审核{@/if}
            {@if it.status == 1}正常{@/if}
            {@if it.status == 0}停用{@/if}
        </td>
        <td class="overdueType">&{it.overdueType}</td>
        <td class="register-time">&{it.registerTime}</td>
        <td>
            <a class="J_edit" href="${website}admin/member/update/&{it.id}">编辑</a> |
            <a class="J_del" href="${website}admin/member/&{it.id}">查看</a> |
            {@if it.status == 3}
            <a class="J_enlight" href="javascript:;">审核通过</a>
            <a class="J_enlight" href="javascript:;">审核未通过</a>
            {@/if}
            {@if it.status == 2}
            <a class="J_enlight" href="javascript:;">审核通过</a>
            <a class="J_enlight" href="javascript:;">审核未通过</a>
            {@/if}
            {@if it.status == 1}
            <a class="J_enlight" href="javascript:;">停用</a>
            {@/if}
            {@if it.status == 0}
            <a class="J_enlight" href="javascript:;">启用</a>
            {@/if}
            |
            <a class="J_editGrade" href="javascript:;">修改类型</a> |
            <input type="hidden" class="J_tipHolder" value="&{it.adminComments}" />
            {@if it.adminComments == null}
            <a class="J_tip font-gray" href="javascript:;">备注</a>
            {@/if}
            {@if it.adminComments != null}
            <a class="J_tip" href="javascript:;">备注</a>
            {@/if}
        </td>
    </tr>
    {@/each}
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/member/list', function(){
            PW.page.Member.List({
                pagi: {
                    renderTo: '#J_pagination',
                    juicerRender: '#tpl',
                    dataRender: '#J_template',
                    themeCss: '.J_pagination_theme2',
                    pageSize: 10,
                    url: '${website}admin/member/ajax/list',
                    configUrl: function(url,page,me,prevPaginationData){
                        return url+'/'+ page;
                    }
                },
                upload: {
                    url: '${website}admin/member/uploadExcel'
                }
            });
        })
    })
</script>
