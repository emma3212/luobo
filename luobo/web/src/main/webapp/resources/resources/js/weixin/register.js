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
        config = {
            sendMobileUrl: null
        },
        el = {
           validForm:'.J_validForm',
           codeImg:'.J_codeImg',
           validCode:'.J_validCode',
           mobile:'.J_mobile',
           code:'.J_code',
           mobileTip:'.J_mobileTip'
        };

    function init(param){
        opts = $.extend(config, param);
        _changeValidCodeImg();
        $(el.mobile).on('focus', _hideTip);
        $(el.mobile).on('blur', _validMobile);
        $(el.validCode).on('click', _changeValidCodeImg);
        $(el.validForm).on('submit', _submitForm);
    }
    _hideTip = function(){
      $(el.mobileTip).hide();
    }
    /**
     * 验证手机号码是否重复
     * @return {[type]} [description]
     */
    _validMobile = function(){
      var
          that = this,flag = 1,
          mobile = $(el.mobile).val();
      if(/^[1]{1}[3458]{1}[0-9]{9}$/.test(mobile)){
          $.ajax({
              url: opts.sendMobileUrl,
              type: "get",
              dataType: "json",
              async: false,
              data: {mobile: mobile},
              success: function(rs){
                 if(rs.code != 0){
                  flag = 0;
                  $(el.mobileTip).html(rs.errMsg).show()
                 }
              },
              error: function(msg){
                  console.log( "Data Saved: " + msg );
              }
          })
      }else{
          flag = 0;
          $(el.mobileTip).html('手机号码填写不正确，请重新填写！').show()
      }
      return flag;
    }
    _changeValidCodeImg = function(){
  		var
              date = new Date().getTime(),flag = 1,
              src = $(el.codeImg).attr('href').split('?')[0] + '?nocache=' + date;
          $(el.codeImg).attr('src',src);
  	}
    _submitForm = function(){
    	var 
          code = $(el.code).val(),
          f = _validMobile();
      if(f == 0){
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
    $.register = {
        init: init
    };
})(jQuery)