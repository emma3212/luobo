<%@ page contentType="text/html;charset=UTF-8" %>


<script type="text/template" id="tpl">
    {@each list as it}
    <tr data-amount-id="&{it.id}">
        <input type="hidden" class="J_userId" name="userId" value="&{it.userId}"/>
        <td class="name">&{it.name}</td>
        <td class="mobile">&{it.mobile}</td>
        <td class="type">&{it.memberType}</td>
        <td class="white-bar-amount">&{it.whiteBarLine}</td>
        <td class="white-bar-use-amount">&{it.whiteBar}</td>
        <td class="any-return-amount">&{it.anyRepayLine}</td>
        <td class="any-return-use-amount">&{it.anyRepay}</td>
        <td>&{it.lastModifiedTime}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a>
        </td>
    </tr>
    {@/each}
</script>
<script type="text/template" id="editTpl">
    <tr data-amount-id="&{amount.id}">
        <input type="hidden" class="J_userId" name="userId" value="&{amount.userId}"/>
        <td class="name">&{amount.name}</td>
        <td class="mobile">&{amount.mobile}</td>
        <td class="type">&{amount.memberType}</td>
        <td class="white-bar-amount">&{amount.whiteBarLine}</td>
        <td>
            <input type="text" class="form-control w100 valid-icon J_whiteBarUseAmount" data-valid-rule="isInteger" name="whiteBarUseAmount" value="&{amount.whiteBar}" />
        </td>
        <td class="any-return-amount">&{amount.anyRepayLine}</td>
        <td>
            <input type="text" class="form-control w100 valid-icon J_anyReturnUseAmount" data-valid-rule="isInteger" name="anyReturnUseAmount" value="&{amount.anyRepay}" />
        </td>
        <td>&{amount.lastModifiedTime}</td>
        <td>
            <a class="J_save" href="javascript:;">保存</a>
            <a class="J_cancel" href="javascript:;">取消</a>
        </td>
    </tr>
</script>
<script type="text/template" id="renderTpl">
    <tr data-amount-id="&{amount.id}">
        <td class="name">&{amount.name}</td>
        <td class="mobile">&{amount.mobile}</td>
        <td class="type">&{amount.memberType}</td>
        <td class="white-bar-amount">&{amount.whiteBarLine}</td>
        <td>&{amount.whiteBar}</td>
        <td class="any-return-amount">&{amount.anyRepayLine}</td>
        <td>&{amount.anyRepay}</td>
        <td>&{amount.lastModifiedTime}</td>
        <td>
            <a class="J_edit" href="javascript:;">编辑</a>
        </td>
    </tr>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/amount/list', function(){
            PW.page.Amount.List({
                renderTo: '#J_pagination',
                juicerRender: '#tpl',
                dataRender: '#J_template',
                themeCss: '.J_pagination_theme2',
                pageSize: 10,
                url: '${website}admin/member/amount/ajax/list',
                configUrl: function(url,page,me,prevPaginationData){
                     return url+'/'+ page;
                    // return url;
                }
            });
        })
    })
</script>