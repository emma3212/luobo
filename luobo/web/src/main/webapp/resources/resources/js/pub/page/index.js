/*-----------------------------------------------------------------------------
* @Description: 公共页面_首页js
* @Version:     V1.0.0
* @author:      cuiy(361151713@qq.com)
* @date         2014.02.03
* ==NOTES:=============================================
* v1.0.0(2014.02.03):
*   初始生成
* v1.0.1(2015.03.10):
*   添加重置密码模块(index/forgetPwd) by wangjing
* v1.0.2(2015.03.13):
*   添加banner下方圆点
* ---------------------------------------------------------------------------*/

KISSY.add('page/index', function (S, Core, ForgetPwd) {
    PW.namespace('page.Index');
    PW.page.Index = function(param){
        new Core(param);
        new ForgetPwd();
    }
},{
    requires:[
        'index/core',
        'index/forgetPwd'
    ]
});

KISSY.add('index/core', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, delegate = S.Event.delegate,
        $ = S.all, $j = jQuery;
        Defender = PW.mod.Defender.client,
        loginIO = PW.io.Login,
        Dialog = PW.widget.Dialog,
        config = {
            boxClass:'', 
            width: 0, 
            height: 0, 
            scrollSpeed: 0, 
            autoSlide: 0
        },
        el = {
            //登录表单
            loginForm: '.J_loginForm',
            //注册表单
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
            registerCodeImg:'.J_registerCodeImg',
            // banner轮播
            banner: '#banner',
            // 新品推荐
            recommend: '#recommend',
            // 新品推荐控制
            next: '#next',
            pre: '#previous',
            // 促销商品
            sale: '#sale',
            // 促销商品控制
            nextV: '#nextV',
            previousV: '#previousV',
            // 精选商品
            select: '#select',
            // 精选商品控制
            selectNext: '#selectNext',
            selectPrevious: '#selectPrevious',
            //记住我复选框
            rememberMeCheckbox: '.J_checkbox',
            // banner下方圆点
            counter: '#counter',
            // 首页tab中，会员登录按钮
            tabLoginBtn: '.J_tabLoginBtn',
            // 首页tab中，会员注册按钮
            tabRegisterBtn: '.J_tabRegisterBtn'
        },
        BTN_KEY = 'btn',
        MSCAROUSEL = 'msCarousel';

    function Core(param){
        this.opts = S.merge(config, param);
        //登录表单验证
        this._formValid;
        //注册表单验证
        this._formRegisterValid;
        this.submitBtn = DOM.data(el.loginBtn, BTN_KEY);
        this.registerBtn = DOM.data(el.registerBtn, BTN_KEY);
        this.placeHolder = DOM.data('input[placeholder]', 'placeholder');
        this._init();
    }

    S.augment(Core, {
        _init: function(){
            this._bannerHandle();
            this._recommendHandle();
            this._saleHandle();
            this._selectHandle();
            this._validHandler();
            this._validRegisterHandler();
            this._buildEvt();
        },
        _buildEvt: function(){
            var 
                that = this;

            that.submitBtn.on('loading', function(e){
                that._loginHandler();
                return false;
            });
            //登录：点击填写验证码input，show 验证图片
            on(el.validInp, 'focus', function(){
                that._showLoginImg(el.codeImg);
            });
            // 注册：点击填写验证码input，show 验证图片
            on(el.registerValidInp, 'focus', function(){
                that._showLoginImg(el.registerCodeImg);
            });
            //登录：点击验证码图片，换验证图片
            on(el.codeImg, 'click', function(){
                that._showLoginImg(el.codeImg);
            });
            //注册：点击验证码图片，换验证图片
            on(el.registerCodeImg, 'click', function(){
                that._showLoginImg(el.registerCodeImg);
            });
            that.registerBtn.on('loading', function(e){
                that._registerHandler();
                return false;
            });
            if(that.placeHolder){
                that.placeHolder.on('pwdFocus', function(e){
                    that._formValid.refresh();
                });
                that.placeHolder.on('pwdBlur', function(e){
                    if(DOM.val('.pwdPlaceholder')){
                        DOM.addClass('.pwdPlaceholder', 'error-field');
                    }
                });
            }
            // 记住我一个月
            on(el.rememberMeCheckbox, 'click', function(e){
                that._rememberMe(e.target);
            });
            
            // 清空登录注册框上方的错误提示
            on(el.tabLoginBtn, 'click', function(){
                that._emptyErrorTip();
            });
            on(el.tabRegisterBtn, 'click', function(){
                that._emptyErrorTip();
            });
        },
        /**
         * 设置banner的id圆点样式
         * @param  {[type]} arg [description]
         * @return {[type]}     [description]
         */
        highlightNo: function(arg) {
            var caller = arg;
            var number = caller.getCurrentID();
            $j(el.counter + ' li').removeClass("active");
            $j(el.counter + ' li:eq('+ (number + 1) +')').addClass("active");
        },
        /**
         * banner轮播
         * @return {[type]} [description]
         */
        _bannerHandle: function(){
            var 
                that = this,
                opts = S.mix(that.opts.banner,{callback: that.highlightNo}),
                bannerMcarousel = $j(el.banner).msCarousel(opts).data(MSCAROUSEL),
                rowHtml;
            // 获取圆点html
            rowHtml = bannerMcarousel.getNumbers(true, '', '');
            $j(el.counter).append(rowHtml);
            // 为banner下方圆点设置操作
            that._rowBuildEvt(bannerMcarousel);
        },
        /**
         * 为banner下方圆点设置操作
         * @param  {[type]} obj [description]
         * @return {[type]}     [description]
         */
        _rowBuildEvt: function(obj){
            $j(el.counter + ' li:not(".buttons")').click(function(e) {
                if(obj != undefined) {
                    var no = $j(this).html();
                    obj.goto(parseInt(no)-1);
                }
            });
            $j(el.counter + ' li').mouseover(function() {
                if(obj != undefined) {
                    obj.pause();
                }
            });
            $j(el.counter + ' li').mouseout(function() {
                if(obj != undefined) {
                    obj.play();
                }
            });
        },
        /**
         * 新品推荐轮播
         * @return {[type]} [description]
         */
        _recommendHandle: function(){
            var 
                that = this,
                opts = that.opts.recommend;
                oHandlerHorizontal = $j(el.recommend).msCarousel(opts).data(MSCAROUSEL);

            that._handleBuildEvt({next: el.next, pre: el.pre}, oHandlerHorizontal);
        },
        /**
         * 为左右按钮操作添加事件
         * @param  {[type]} oper [description]
         * @param  {[type]} obj  [description]
         * @return {[type]}      [description]
         */
        _handleBuildEvt: function(oper, obj){
            $j(oper.next).click(function() {
                obj.next();
            });
            $j(oper.pre).click(function() {
                obj.previous();
            }); 
        },
        /**
         * 促销商品轮播
         * @return {[type]} [description]
         */
        _saleHandle: function(){
            var 
                that = this,
                opts = that.opts.sale;
                oHandlerVertical = $j(el.sale).msCarousel(opts).data(MSCAROUSEL);

            that._handleBuildEvt({next: el.nextV, pre: el.previousV}, oHandlerVertical);
        },
        /**
         * 精选商品轮播
         * @return {[type]} [description]
         */
        _selectHandle: function(){
            var 
                that = this,
                opts = that.opts.select;
                selectEl = $j(el.select).msCarousel(opts).data(MSCAROUSEL);

            that._handleBuildEvt({next: el.selectNext, pre: el.selectPrevious}, selectEl);
        },
        /**
         * 登录填写过程中验证input书写格式是否正确
         * @return {[type]} [description]
         */
        _validHandler:function(){
            this._formValid = Defender(el.loginForm,{
                theme:'inline',
                items:[
                    //手机号码验证
                    {
                        queryName:el.usernameInp,
                        pattern: function(input,shell,form){
                            return !(this.test('isNull',DOM.val(input)));
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    }
                ],
                showTip: false
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
                                errorTipEl = get(el.registerError);
                            if(this.test('isMobile', mobile)){
                                loginIO.sendMobile({mobile:mobile}, function(code, errMsg){
                                    if(code){
                                        shell.updateState('success');
                                    }else{
                                        shell.updateState('error');
                                        DOM.html(errorTipEl, errMsg);
                                    }
                                })
                            }else{
                                return false;
                            }
                            return 'loading';
                        },
                        showEvent:'focus',
                        vldEvent:'blur',
                        async: true,
                        showTip:false
                    }
                ] 
            });
        },
        /**
         * 登录：点击填写验证码input，show 验证图片
         * @return {[type]} [description]
         */
        _showLoginImg: function(img){
            var 
                that = this,
                date = new Date().getTime(),
                imgEl = get(img),
                src = DOM.attr(img, 'src').split('?')[0] + '?nocache=' + date;
            $(img).show();
            $(img).attr('src',src);   
        },
        /**
         * 登录操作
         * @return {[type]} [description]
         */
        _loginHandler: function(){
            var
                that = this,
                obj = DOM.serialize(el.loginForm);
            $(el.errorTipRender).html('');
            if(DOM.val('.pwdPlaceholder')){
                DOM.addClass('.pwdPlaceholder', 'error-field');
            }
            that._formValid.validAll(function(rs){
                if(rs){
                    loginIO.check(obj, function(rs, errMsg){
                        if(rs == 0){
                            window.location.reload();
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
                            Dialog.alert(errMsg, function(){
                                f.submit();
                            });
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
         * 登录失败时显示提示信息
         * @param  {[type]} tip [description]
         * @return {[type]}     [description]
         */
        _showTip: function(tip){
            var 
                that = this,
                errorTip = get(el.errorTipRender);
            tip = tip || '';
            DOM.html(errorTip, tip);
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
                errorTip = $(el.registerError);
            tip = tip || '';
            DOM.html(errorTip, tip);
            that.registerBtn.reset();
        },
        /**
         * 清空错误提示信息
         * @return {[type]} [description]
         */
        _emptyErrorTip: function(){
            var
                that = this;
            DOM.empty(el.errorTipRender);
            DOM.empty(el.registerError);
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
        'module/msCarousel',
        'widget/btn',
        'mod/defender',
        'widget/dialog',
        'module/placeholder',
        'core'
    ]
});
//忘记密码
KISSY.add('index/forgetPwd', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, delegate = S.Event.delegate,
        Defender = PW.mod.Defender.client,
        LoginIO = PW.io.Login,
        Dialog = PW.widget.Dialog,
        el = {
            //重置密码模板
            forgetDlgTlp: '#resetPwdTpl',
            //忘记密码触发器
            forgetTrigger: '.J_forgetEl',
            //重置密码验证码
            resetCodeImg: '.J_resetCodeImg',
            //验证码输入框
            resetCodeInp: '.J_resetValid',
            //重置表单
            resetForm: '.J_resetForm',
            //错误提示信息
            errMsgEl: '.J_errMsgEl'
        },
        SUCCESS_TIP = ['您的密码已重置成功，我们将新密码已发送至您的手机当中，请注意查收！'];
    var
        ForgetPwd = function(){
            this.defenderResetPwd;
            this._init();
        };
    S.augment(ForgetPwd, {
        _init: function(){
            this._buildEvt();
        },
        _buildEvt: function(){
            var
                that = this;
            on(el.forgetTrigger, 'click', that._openForgetDlg, that);
            //重置密码：点击填写验证码input，show 验证图片
            delegate(document, 'focus', el.resetCodeInp, function(){
                that._showCodeImg(el.resetCodeImg);
            });
            //重置密码：点击验证码图片，换验证图片
            delegate(document, 'click', el.resetCodeImg, function(){
                that._showCodeImg(el.resetCodeImg);
            });
        },
        _openForgetDlg: function(){
            var
                that = this,
                RESET_HTML = DOM.html(el.forgetDlgTlp),
                data;
            Dialog.alert(RESET_HTML,function(){},{footer: 
                {
                    btns:[{
                    text: '确定',
                    clickHandler: function(e,me){
                        that.defenderResetPwd.validAll(function(rs){
                            if(rs){
                                data = DOM.serialize(el.resetForm);
                                LoginIO.resetPwd(data, function(code, errMsg){
                                    if(code){
                                        Dialog.alert(SUCCESS_TIP[0]);
                                        me.close();
                                    }else{
                                        DOM.html(el.errMsgEl, errMsg);
                                        DOM.show(el.errMsgEl);
                                    }
                                });
                            }
                        });
                    }
                },{
                    text: '取消',
                    clickHandler: function(e,me){
                        me.close();
                    }
                }]
                },
                afterOpenHandler: function(e,me){
                    that.defenderResetPwd = Defender(el.resetForm,{
                         theme:'inline',
                            items:[
                                //验证码验证
                                {
                                    queryName:el.resetCodeInp,
                                    pattern: function(input,shell,form){
                                        var
                                            code = DOM.val(input);
                                        return (code.length == 4);
                                    },
                                    showEvent:'focus',
                                    vldEvent:'keyup',
                                    showTip:false
                                }
                            ]
                        });
                },
                title: "重置密码：",
                width: 600
            });
        },
        /**
         * 登录：点击填写验证码input，show 验证图片
         * @return {[type]} [description]
         */
        _showCodeImg: function(imgEl){
            var 
                that = this,
                src = DOM.attr(imgEl, 'src').split('?')[0] + '?nocache=' + S.now();
            $(imgEl).show();
            $(imgEl).attr('src',src);   
        }
    });
    return ForgetPwd;
},{
    requires: [
        'io/login',
        'mod/defender',
        'widget/dialog'
    ]
});
