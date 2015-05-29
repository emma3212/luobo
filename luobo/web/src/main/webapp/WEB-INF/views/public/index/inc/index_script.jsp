<%@ page contentType="text/html;charset=UTF-8" %>
<script type="text/template" id="resetPwdTpl">
    <form class="J_resetForm resetForm">
        <h3>我们将重置您的密码，并将新密码发送到您的手机中，请注意查收！</h3>
        <p class="J_errMsgEl error-tip hidden"></p>
        <div class="input-group margin-top-15">
            <label class="">手机号:</label>
            <input type="text" class="" data-valid-rule="isMobile" data-valid-tip="请输入手机号|手机号码填写有误" name="loginName" />
        </div>
        <div class="input-group margin-top-10">
            <label class="">验证码:</label>
            <input type="text" class="valid-code J_resetValid" data-valid-rule="length(0,5)" name="validCode"/>
            <img class="valid-img J_resetCodeImg hidden" src="${website}Kaptcha.jpg" alt="验证码">
        </div>
    </form>
</script>
<script type="text/javascript">
    KISSY.ready(function(S){
        S.use('page/index, widget/tab',function(){
            PW.page.Index({
                banner: {
                    boxClass:'div.box',
                    width:642,
                    height:278,
                    scrollSpeed:500,
                    autoSlide:5000
                },
                recommend:{
                    boxClass:'div.recommend-list',
                    width:457,
                    height:371,
                    scrollSpeed:500
                },
                sale: {
                    boxClass:'div.sale-list',
                    width:457,
                    height:340,
                    scrollSpeed:500,
                    vertical:true
                },
                select: {
                    boxClass:'div.select-list',
                    width:940,
                    height:640,
                    scrollSpeed:500
                }
            });
        })
    })
</script>