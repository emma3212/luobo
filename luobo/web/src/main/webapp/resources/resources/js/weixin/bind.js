/*-----------------------------------------------------------------------------
* @Description:     注册
* @Version:         1.0.0
* @author:          kt
* @date             2015.1.23
* ==NOTES:=============================================
* v1.0.0(2015.1.23):
     初始生成
* -----------------------------------------------------------------------------*/
(function($){
    var 
        el = {
           validForm:'.J_validForm',
           codeImg:'.J_codeImg',
           validCode:'.J_validCode',
           pwd:'.J_pwd',
           mobile:'.J_mobile',
           code:'.J_code'
        };

    function init(){
        _changeValidCodeImg();
        $(el.validForm).on('submit', _submitForm);
        $(el.validCode).on('click', _changeValidCodeImg);
    }
    _changeValidCodeImg = function(){
  		var
              date = new Date().getTime(),
              src = $(el.codeImg).attr('href').split('?')[0] + '?nocache=' + date;
          $(el.codeImg).attr('src',src);
  	}
    _submitForm = function(){
    	var mobile = $(el.mobile).val(),
			pwd = $(el.pwd).val();
		
		if(!(/^[1]{1}[3458]{1}[0-9]{9}$/.test(mobile))){
			$("#popupBasic p").html("手机号码输入有误！");
			$("#popupBasic").popup("open");
			return false;
		}
		if(pwd.length < 8 || pwd.length > 15){
			$("#popupBasic p").html("密码输入有误！");
			$("#popupBasic").popup("open");
			return false;
		}
    if(code.length != 4 ){
      $("#popupBasic p").html("验证码输入有误！");
      $("#popupBasic").popup("open");
      return false;
    }
		$.mobile.loading( "show", {
			text: '提交中，请耐心等候',
			textVisible: true,
			textonly: false
		});
    } 
    $.bind = {
        init: init
    };
})(jQuery)