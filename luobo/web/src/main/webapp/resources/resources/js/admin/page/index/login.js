/*-----------------------------------------------------------------------------
* @Description:     登录页面
* @Version:         1.0.0
* @author:          kt
* @date             2015.1.19
* ==NOTES:=============================================
* v1.0.0(2014.1.19):
     初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/index/login',function(S,Core){
	PW.namespace('page.index.Login');
	PW.page.index.Login = function(param){
		return new Core(param);
	}
},{
	requires:[
        'login/core'
    ]
});

KISSY.add('login/core',function(S){
	 var 
        DOM = S.DOM, get = DOM.get, on = S.Event.on, $ = S.all,
        Defender = PW.mod.Defender.client,
        loginIO = PW.io.Login,
        el = {
        	//登录表单
            loginForm: '.J_loginForm',
            //登录表单
            registerForm: '.J_registerForm',
            //登录按钮
            loginBtn: '.J_lgBtn',
            //注册按钮
            registerBtn:'.J_registerBtn',
            //登录错误提示
            errorTipRender: '.J_loginError',
            //注册错误提示
            registerError:'.J_registerError',
            //用户名输入框
            usernameInp: '.J_loginMobile',
            //注册手机号
            registerMobile:'.J_registerMobile',
            //密码输入框
            pwdInp: '.J_pwd',
            //记住我复选框
            rememberMeCheckbox: '.J_checkbox',
            //验证码
            validInp: '.J_valid',
            //注册验证码input
            registerValidInp:'.J_registerValid',
            //刷新
            validCode: '.J_validCode',
            //注册刷新
            validRegisterCode:'.J_validRegisterCode',
            //验证码图片
            codeImg:'.J_codeImg',
            //注册验证码图片
            registerCodeImg:'.J_registerCodeImg'
        },
        // 智能按钮
        BTN_KEY = 'btn';
    function Core(param){
        //登录表单验证
        this._formValid;
        //注册表单验证
        this._formRegisterValid;
        this.submitBtn;
        this.registerBtn;
        this._init();
    }

    S.augment(Core,{
    	_init: function(){
            this._validHandler();
            this._validRegisterHandler();
            this.submitBtn = $(el.loginBtn).data(BTN_KEY);
            this.registerBtn = $(el.registerBtn).data(BTN_KEY);
            this._buildEvt();
    	},
    	_buildEvt: function(){
    		var 
    			that = this;
            that.submitBtn.on('loading', function(e){
                that._loginHandler();
                return false;
            });
    		on(el.rememberMeCheckbox, 'click', function(e){
    			that._rememberMe(e.target);
    		});
            //登录：点击填写验证码input，show 验证图片
            on(el.validInp, 'focus', function(){
                that._showLoginImg(el.validCode, el.codeImg);
            });
            //注册：点击填写验证码input，show 验证图片
            on(el.registerValidInp, 'focus', function(){
                that._showLoginImg(el.validRegisterCode, el.registerCodeImg);
            });
            //登录：点击刷新按钮，换验证图片
    		on(el.validCode, 'click', function(){
    			that._showLoginImg(el.validCode, el.codeImg);
    		});
            //注册：点击刷新按钮，换验证图片
            on(el.validRegisterCode, 'click',function(){
                that._showLoginImg(el.validRegisterCode, el.registerCodeImg);
            });
            that.registerBtn.on('loading', function(e){
                that._registerHandler();
                return false;
            });
    	},
        /**
         * 登录填写过程中验证input书写格式是否正确
         * @return {[type]} [description]
         */
        _validHandler:function(){
            this._formValid = Defender(el.loginForm,{
                theme:'inline',
                items:[
                    //验证码验证
                    {
                        queryName:el.validInp,
                        pattern: function(input,shell,form){
                            var
                                code = DOM.val(input);
                            return (code.length == 4);
                        },
                        //tip: '验证码错误|验证码错误',
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    }
                    
                ] 
            });
        },
        /**
         * 注册填写过程中验证input书写格式是否正确
         * @return {[type]} [description]
         */
        _validRegisterHandler:function(){
            this._formRegisterValid = Defender(el.registerForm,{
                theme:'inline',
                items:[
                    //验证码验证
                    {
                        queryName:el.registerValidInp,
                        pattern: function(input,shell,form){
                            var
                                code = DOM.val(input);
                            return (code.length == 4);
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    },
                    //验证手机号码
                    {
                        queryName:el.registerMobile,
                        pattern: function(input,shell,form){
                            var
                                mobile = DOM.val(el.registerMobile),
                                controls = DOM.parent(input),
                                span = DOM.get('span', controls);
                            if(this.test('isMobile', mobile)){
                                loginIO.sendMobile({mobile:mobile}, function(code, errMsg){
                                    if(code){
                                        shell.updateState('success');
                                    }else{
                                        shell.updateState('error');
                                        DOM.html(span,errMsg);
                                    }
                                })
                            }else{
                                return false;
                            }
                            return 'loading';
                        },
                        showEvent:'focus',
                        vldEvent:'blur',
                        tip:'请输入手机号码|手机号码有误，请重新填写',
                        async: true
                    }
                ] 
            });
        },
        /**
         * 登录：点击填写验证码input，show 验证图片
         * @return {[type]} [description]
         */
        _showLoginImg: function(fresh, img){
            var 
                that = this,
                date = new Date().getTime(),
                src = $(img).attr('href').split('?')[0] + '?nocache=' + date;
            $(img).show();
            $(fresh).show();
            $(img).attr('src',src);   
        },
    	/**
    	 * 登录操作
    	 * @return {[type]} [description]
    	 */
    	_loginHandler: function(){
    		var
                that = this,
        		obj = DOM.serialize(el.loginForm),
                f = DOM.get(el.loginForm);
            $(el.errorTipRender).html('');
            that._formValid.validAll(function(rs){
               if(rs){
                    loginIO.check(obj, function(rs, errMsg){
                        if(rs == 0){
                            window.location.href = website + 'home';
                        }else{
                            that._showTip(errMsg);
                            that.submitBtn.reset();
                        }
                    })
                }else{ 
                    that.submitBtn.reset();
                } 
            })
    	},
        /**
         * 注册操作
         * @return {[type]} [description]
         */
        _registerHandler: function(){
            var
                that = this,
                //表单序列化
                obj = DOM.serialize(el.registerForm),
                f = DOM.get(el.registerForm);
            $(el.registerError).html('');
            that._formRegisterValid.validAll(function(rs){
               if(rs){
                    loginIO.submitRegisterForm(obj, function(rs, errMsg){
                        if(rs){
                            f.submit();
                        }else{
                            that._showRegisterTip(errMsg);
                            that.registerBtn.reset();
                        }
                    });
                }else{ 
                    that.registerBtn.reset();
                } 
            })
        },
    	/**
    	 * 表单验证的结果
    	 * @return {[type]} [description]
    	 */
    	_validHandlerResult: function(){
    		var 
    			that = this,
    			codeVal = DOM.val(el.validInp);
	        //如果用户名通不过验证
    		if(!that._formValid.getItemResult(el.usernameInp)){
                get(el.usernameInp).focus();
            	return false;
            }
            //如果密码通不过验证
            if(!that._formValid.getItemResult(el.pwdInp)){
                get(el.pwdInp).focus();
            	return false;
            }
            //如果验证码通不过验证
            if(codeVal.length != 4){
                get(el.validInp).focus();
                return false;
            }
	        //全部项均通过验证
	        return true;
    	},
        /**
         * 登录失败时显示提示信息
         * @param  {[type]} tip [description]
         * @return {[type]}     [description]
         */
        _showTip: function(tip){
            var 
                that = this,
                $errorTip = $(el.errorTipRender);
            tip = tip || '';
            $errorTip.html(tip);
            that.submitBtn.reset();
        },
        /**
         * 注册失败时显示提示信息
         * @param  {[type]} tip [description]
         * @return {[type]}     [description]
         */
        _showRegisterTip: function(tip){
            var 
                that = this,
                $errorTip = $(el.registerError);
            tip = tip || '';
            $errorTip.html(tip);
            that.registerBtn.reset();
        },
        /**
         * “记住我的登录信息”添加checked样式
         * @return {[type]} [description]
         */
        _rememberMe: function(e){
        	var 
        		spanEl = DOM.parent(e);
        	if($(spanEl).hasClass('checkbox-checked')){
        		$(spanEl).removeClass('checkbox-checked');
                DOM.removeAttr(el.rememberMeCheckbox,'checked');
        	}else{
        		$(spanEl).addClass('checkbox-checked');
                DOM.attr(el.rememberMeCheckbox, { checked: 'checked'});
        	}
        }
    });
	return Core;
},{
	requires:[
        'io/login',
        'mod/defender',
        'core', 
        'widget/btn'
    ]
});