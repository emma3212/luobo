KISSY.add("mod/defender",function(a,b){PW.namespace("defener");PW.namespace("Defener");PW.namespace("mod.Defener");PW.Defender=PW.defender=PW.mod.Defender=function(c,d){return new b(c,d);};},{requires:["defender/core"]});KISSY.add("defender/core",function(j,n,a,w,D,d,c,h){var x=j.DOM,A=x.get,k=x.query,F=j.Event,o=F.on,C=F.detach,v=F.delegate,g=j.IO,f=j.JSON,i=j.all,p=function(){},r="input,select,textarea",B="data-valid-rule",u="data-valid-pattern",q="data-valid-tip",z="data-valid-id",t="vs",b="error-field",s="pw-validation",m="错误：没有找到指定的表单！",l=0.2,E={showEvent:"focus",vldEvent:"valuechange",showTip:true,formErrorContainer:"",fieldErrorContainer:"",tip:"请正确输入(default) | 输入错误(default)",filter:"",zIndex:101,theme:"inline",width:400,direction:"right",alignY:"center",alignX:"center",showTimeout:0.3,hideTimeout:0.2,trace:false,smartMode:true,loadingStyle:true,focusStyle:true,errorStyle:true,successStyle:true,wait:2,onStateChange:p,themeUrl:PW.libUrl+"js/base/assets/defender/styles/style.css"},e=PW.modSettings.defender||{};function y(G,H){var I=this._getContainer(G,H);if(I==null){j.log("注意:配置错误，当前找不到任何可配置表单，请检查选择器!","warn","pui/mod/defender");return;}this.container=I;this.pattern=new n(this.container);this.form=this.container;this.opts=(j.isObject(G)&&G.container)?j.merge(E,e,G):j.merge(E,e,H);this.fec=new D(I,this.opts);this.nextFieldId;this.fieldSet=[];this.shellIndex={};this._loadStyles();this.init();}j.augment(y,j.EventTarget,{init:function(){var H=this,G=H.opts;if(!PW.GLOBAL_VALID_FIELD_ID){PW.GLOBAL_VALID_FIELD_ID=0;}H.nextFieldId=PW.GLOBAL_VALID_FIELD_ID;H._renderFormStyle();H._embedTagRule();H._embedCustomRule();if(G.showTip){H._getTip(function(){this.fieldset=j.filter(k(r,H.form),function(I){return H._initFormField(I);});H.addEvtDispatcher();});}else{this.fieldset=j.filter(k(r,H.form),function(I){H._initFormField(I);});H.addEvtDispatcher();}},addEvtDispatcher:function(){var L=this,K=L.form,J=L.opts,H=L.fec,I=L._getShellArray(),G=i(K);G.on("reset",function(M){j.each(I,function(P){var O=P.field.attributes,N=!O.value?"":O.value.value;(!N)?i(P.field).val(""):i(P.field).val(N);P.doValid();});return true;});if(J.smartMode){G.on("submit",function(M){var P,N=false;L._checkFields();try{P=L.getValidResult();N=(P!="success")?false:true;if(!N){throw ("表单验证未通过");}}catch(O){j.log(O);}finally{L.fire("submit",{rs:N,stateCode:P,form:L.form});if(!N){H.showFormError();}else{H.hideFormError();}return N;}});}},getItemResult:function(G){var J=this,I=J.form,M=A(G,I),L=i(M).data()||{},H=L.pattern,K=J.pattern;if(M==null){j.log("不存在要查找的项目");return false;}return K.valid(H,M);},test:function(G,J){var H=this,I=H.pattern;return I.test(G,J);},validItem:function(G){var J=this,K=J.form,M=J._getShellArray(),H,L,I;L=A(G,K);if(L==null){j.log("你要验证的内容找不到");return;}H=x.attr(L,z);I=J.shellIndex[H];if(H==""||!I){j.log("找不到验证项");}else{I.doValid();}return I.validState==="success";},validAll:function(){var H=this,G=H._getShellArray();j.each(G,function(I){I.doValid();});return H.getValidSet();},getValidSet:function(){var I=this,H=I._getShellArray(),J=[],G=[];j.each(H,function(K){if(K.validState!=true){G.push(K);}else{J.push(K);}});return{pass:J,error:G};},getValidResult:function(M,N){var L=this,J=L.opts.wait,H=L._getShellArray(),O="success",G=[];if(j.isFunction(M)){N=M;M="bool";}for(var I=0;I<H.length;I++){var K=H[I];if(L._isInvalidField(K.field)){continue;}if((K.validState!=true&&K.validState!="success")&&!K.async){O="error";break;}if(K.async){G.push(K);}}if(O=="error"){if(j.isFunction(N)){N(false);}return(M=="bool")?false:O;}if(G.length>0){j.timer(function(R,T){var P=false,U=false;for(var S=0,Q=G.length;S<Q;S++){var V=G[S];if(V.validState=="success"){continue;}else{if(V.validState=="loading"){U=true;}else{if(V.validState=="error"){P=true;break;}}}}if(P){if(j.isFunction(N)){N(false);}T();}else{if(!U){if(j.isFunction(N)){N(true);}T();}}if(R==19){j.log("表单异步验证超时，目前的验证时间为");if(j.isFunction(N)){N(false);}T();}},l,Math.floor(J/l),L);return(M=="bool")?false:"loading";}else{if(j.isFunction(N)){N(true);}return(M=="bool")?true:"success";}},getFormData:function(G){var H=this;return x.serialize(H.form,G);},serialize:function(){var G=this;return G.getFormData(true);},refresh:function(I){var H=this,G;if(!H.removeValid()){j.log("移除事件失败");return;}H.removeTip();if(!I){I=H.opts;}this.form=this.container;this.opts=j.merge(E,I);this.nextFieldId=undefined;this.fieldSet=[];this.shellIndex={};this.init();},removeValid:function(){var J=this,I=J.opts,G=J._getShellArray();try{j.each(G,function(K){K.removeValid();});i(J.form).removeClass(s);return true;}catch(H){j.log(H);return false;}},removeTip:function(){var H=this,G=H._getShellArray();j.each(G,function(I){I.destroyTip();});},_getContainer:function(G,J){var I=this,H=null;if(j.isString(G)||x.isHTMLElement(G)){H=A(G);}else{if(j.isObject(G)&&G.container){H=A(G.container);}}if(x.data(H,"hasValid")==true){j.log("您所设置的节点已经添加了表单验证，请检查！");H=null;}else{x.data(H,"hasValid",true);}return H;},_renderFormStyle:function(){var H=this,G=H.opts,I=H.form;i(I).addClass(s);if(G.theme!=""){i(I).addClass(G.theme);}},_initFormField:function(J){var I=this,H=I.opts,G;if(I._isInvalidField(J)){return;}if(!i(J).data("pattern")){return false;}G=new a(J,H,I);I.shellIndex[G.fieldId]=G;if(H.showTip){G.setTip(I.FormTip);}G.on("valid",function(L){var M=i(L.target.field),N=M.data("req"),K=M.data("onStateChange");if(!N){}else{j.each(N,function(O){var P=A("*["+z+"="+O+"]",I.form);I.shellIndex[O].doValid(P);});}if(j.isFunction(K)){K.call(this,L.lastState,L.currentState,M.getDOMNode(),this,I);}});return true;},_getTip:function(I){var H=this,G=H.opts;if(G.showTip==true){if(G.fieldErrorContainer!=""){H.FormTip=c;}else{if(G.theme=="inline"){H.FormTip=h;}else{H.FormTip=d;}}if(j.isFunction(I)){I();}}},_checkFields:function(){var H=this,G=H._getShellArray();j.each(G,function(I){if(!I.async){I.doValid();}else{if(I.validState=="inactive"){I.doValid();}if(I.validState=="focus"){I.doValid();}}});return H.getValidSet();},_getShellArray:function(){var I=this,J=I.shellIndex,H=[];for(var G in J){H.push(J[G]);}return H;},_embedTagRule:function(){var K=this,J=K.opts,I=K.form,G=i(I),H;H=x.filter(r,function(L){return !K._isInvalidField(L);},I);if(J.filter!=""){H=x.filter(H,function(M){var L=x.parent(M,J.filter);return !(L&&A(L,I));},I);}H=j.filter(H,function(Q){var O=i(Q),N=O.attr(B),M=O.attr(u),L=O.attr("type"),P=O.attr(q);if(L=="reset"||L=="button"||L=="submit"){return false;}if((!N||N==""||N=="none")&&(!M||M=="")){return false;}if(N&&(!P||P=="")){if(N.search("\\[")>=0||N.search("\\]")>=0||N.search("\\|")>=0||N.search("\\&")>=0){P=J.tip;}else{P=K._getMatchTip(N);}}if(M){if(!P||P==""){P=J.tip;}N=function(R,S,T){return new RegExp(j.unEscapeHTML(M),"g").test(i(R).val());};}i(Q).data({pattern:N,tip:P,showEvent:J.showEvent,vldEvent:J.vldEvent,showTip:J.showTip,vs:"inactive",onStateChange:J.onStateChange});return true;});},_embedCustomRule:function(){var H=this,G=H.opts;j.each(G.items,function(J){var I=j.clone(G);j.mix(I,J);if(j.isFunction(I.pattern)){i(J.queryName).each(function(K){if(H._isInvalidField(K)){return;}i(this).data({tip:(I.tip!="")?I.tip:G.tip,pattern:I.pattern,showEvent:(I.showEvent!="")?I.showEvent:G.showEvent,vldEvent:(I.vldEvent!="")?I.vldEvent:G.vldEvent,vs:"inactive",showTip:(!I.showTip)?false:true,async:(!I.async)?false:true,onStateChange:(!j.isFunction(I.onStateChange))?undefined:I.onStateChange});});}});},_getMatchTip:function(J){var H=this,G=H.opts,I=w.getTipByRule(J);return(I&&I!="")?I:G.tip;},_isInvalidField:function(G){return G.disabled||x.attr(G,"type")=="hidden";},_loadStyles:function(){var H=this,G=H.opts;j.loadCSS(G.themeUrl);}});return y;},{requires:["validation/pattern","validation/shell","validation/tipText","validation/form-error-tip","validation/float-tip","validation/inside-tip","validation/inline-tip","mod/ext","core","sizzle"]});KISSY.add("validation/shell",function(f){var r=f.DOM,t=r.get,g=r.query,x=f.Event,j=x.on,v=x.detach,p=x.delegate,d=f.IO,c=f.JSON,e=f.all,k=function(){},n="input,select,textarea",w="data-valid-rule",m="data-valid-tip",s="data-valid-id",q="vs",o="focus-field",b="error-field",u="success-field",i="loading-field",l=0,h;function a(A,z,y){this.field=A;this.opts=z;this.prtForm=y;this.pattern=y.pattern;this.fieldData=e(A).data();this.showTip=(e(A).data("showTip")!=true)?false:true;this.async=(e(A).data("async")!=true)?false:true;this.validState="inactive";this.fieldId=f.guid();this.tipClient;this.disable=false;h=this.pattern;this.init();}f.augment(a,f.EventTarget,{init:function(){e(this.field).attr(s,this.fieldId);this.addEvtDispatcher();},addEvtDispatcher:function(){var z=this,y=z.opts,A=z.fieldData;j(z.field,"focus",function(B){z.doValid(this,B);});if(r.nodeName(z.field)=="select"){j(z.field,"change",function(B){z.doValid();});}else{j(z.field,"valuechange",function(B){z.doValid(this,B);});}j(z.field,"blur",function(B){if(!z.async){z.doValid(this,B);}});},removeValid:function(){var C=this,E=C.field,A=e(E),B=C.opts,D=A.data("showEvent"),z=A.data("vldEvent"),y=C.tipClient;v(E,D);v(E,z);v(E,"focus");v(E,"change");v(E,"blur");if(y){y.destroyTip();}if(B.errorStyle==true){A.removeClass(b);}A.removeAttr(s);C._removeValidData();C.disable=true;},_removeValidData:function(){var y=this,z=y.field;r.removeData(z,"tip");r.removeData(z,"showEvent");r.removeData(z,"vldEvent");r.removeData(z,"showTip");r.removeData(z,"vs");r.removeData(z,"pattern");r.removeData(z,"onStateChange");},doValid:function(B,z){var F=this,B=F.field,y=F.tipClient,C=e(B).data("pattern"),E,A=e(B).data(q),D;E=(f.isString(C))?h.valid(C,B):C.call(F,B,F,F.prtForm);if(e(B).val()==""){if(document.activeElement!==B&&E==true){F.updateState("success");}else{if(document.activeElement!==B&&E==false){F.updateState("error");}else{F.updateState("focus");}}return;}switch(E){case"true":case true:F.updateState("success");break;case"false":case false:F.updateState("error");break;case"load":case"loading":F.updateState("loading");break;default:f.log("发生内部错误");F.updateState("error");}},updateState:function(D){if(this.disable==true){f.log("操作拒绝，此验证已经移除");return;}var C=this,B=C.opts,E=C.field,z=e(E).data(q),A,y=C.tipClient;switch(D){case"success":case"error":case"loading":case"focus":A=D;if(y){y.handleEvent({type:D,target:E});}C.validState=D;break;default:A="error";if(y){y.handleEvent({type:"error",target:E});}C.validState="error";}if(A!=z){e(E).data(q,A);C.updateFieldClass(A);}C.fire("valid",{currentState:A,lastState:z});},updateFieldClass:function(A){var z=this,B=z.field,y=z.opts;r.removeClass(B,[o,b,u,i].join(" "));switch(A){case"focus":if(y.focusStyle){r.addClass(B,o);}break;case"loading":if(y.loadingStyle){r.addClass(B,i);}break;case"success":if(y.successStyle){r.addClass(B,u);}break;default:if(y.errorStyle){r.addClass(B,b);}}},destroyTip:function(){var z=this,y=z.tipClient;if(y){y.destroyTip();}},setTip:function(B){var z=this,A=z.field,y=z.opts;if(!z.showTip){return;}z.tipClient=new B(A,y);},test:function(y,B){var z=this,A=z.pattern;return A.test(y,B);}});return a;},{requires:["core","sizzle"]});KISSY.add("validation/pattern",function(d,e){var j=d.DOM,b=j.get,h=j.query,f=d.all,g="vs",i="data-valid-id",a={isCommonUser:function(k){return/^[a-zA-Z]{1}([a-zA-Z0-9]|[._-]){5,19}$/.test(k);},notCommonUser:function(k){return !a.isCommonUser(k);},isPassword:function(k){return/^(\w){6,20}$/.test(k);},notPassword:function(k){return !a.isPassword(k);},isEmail:function(k){return/^[0-9a-zA-Z_\-\.]+@[0-9a-zA-Z_\-]+(\.[0-9a-zA-Z_\-]+)+$/.test(k);},notEmail:function(k){return !a.isEmail(k);},isNull:function(k){return k.length==0;},notNull:function(k){return !/^\s*$/.test(k);},isNumber:function(k){return/^\d+$/.test(k);},notNumber:function(k){return !a.isNumber(k);},isTelephone:function(k){return/^\d{3,4}-\d{7,8}(-\d{3,4})?$/.test(k);},notTelePhone:function(k){return !a.isTelephone(k);},isImage:function(k){return/^.+(\.jpg|\.JPG|\.gif|\.GIF|\.png|.PNG|\.x\-png|\.bmp|\.BMP)$/.test(k);},notImage:function(k){return !a.isImage(k);},isEnglish:function(k){return/^[a-zA-Z]*$/.test(k);},notEnglish:function(k){return !a.isEnglish(k);},isHttp:function(k){return/^http\:\/\/([^\s]+)$/.test(k);},notHttp:function(k){return !a.isHttp(k);},isFlv:function(k){return/^.+(\.flv|\.FLV|\.Flv)$/.test(k);},notFlv:function(k){return !a.isFlv(k);},isFloat:function(k){return/^[-]?[0-9]*\.?[0-9]+$/.test(k);},notFloat:function(k){return !a.isFloat(k);},isQQ:function(k){return/^[1-9]\d{4,13}$/.test(k);},notQQ:function(k){return !a.isQQ(k);},isMobile:function(k){return/^[1]{1}[3458]{1}[0-9]{9}$/.test(k);},notMobile:function(k){return !a.isMobile(k);},isChinese:function(k){return/^[\u4e00-\u9faf]+$/.test(k);},notChinese:function(k){return !a.isChinese(k);},isUrl:function(k){return/[a-zA-z]+:\/\/[^\s]*/.test(k);},notUrl:function(k){return !a.isUrl(k);},isIdCard:function(m){var l=e,k=new l(m);return k.IsValid();},notIdCard:function(k){return !a.isIdCard(k);},isZipCode:function(k){return/^[1-9][0-9]{5}$/.test(k);},notZipCode:function(k){return !a.isZipCode(k);},isIP:function(k){return/^((1?\d?\d|(2([0-4]\d|5[0-5])))\.){3}(1?\d?\d|(2([0-4]\d|5[0-5])))$/.test(k);},notIp:function(k){return !a.isIP(k);},scale:function(m,o,k,n){if(!/^(-?\.?\d+)(\.\d+)?$/.test(m)){return false;}m=parseFloat(m,10);o=parseFloat(o,10);k=parseFloat(k,10);return(n&&parseInt(n,10)==1)?(m>=o&&m<=k):(m>o&&m<k);},require:function(m,k,q){var p=f(this.form).one("#"+k),o=f(q),l=o.attr(i),n=p.data("req");if(p==null){d.log("要查找相等项目不存在，请检查id"+k+"的项目是否存在");return false;}else{if(!n||n.length==0){p.data("req",[l]);}else{if(!d.inArray(l,n)){n.push(l);p.data("req",n);}}return p.data(g)=="success";}},equal:function(l,k){var m=f(this.form).one("#"+k);if(m==null){d.log("要查找相等项目不存在，请检查id"+k+"的项目是否存在");return false;}else{return m.val()==l;}},length:function(n,p,k,o){var m=n.length;p=parseInt(p,10);k=parseInt(k,10);return(o&&parseInt(o,10)==1)?(m>=p)&&(m<=k):(m>p)&&(m<k);},one:function(m,k){var n=h(k,this.form),o=arguments[2],l=false;d.each(n,function(p){if(p==o){return;}if(l){return;}if(f(p).data("vs")=="success"){l=true;}});return l;}};function c(k){this.form=k;}d.augment(c,d.EventTarget,{test:function(k,n){var m=this;try{return(d.isString(k)&&/^[is](\w)*$/.test(k)&&a[k])?m.valid(k,n):false;}catch(l){d.log(l);return false;}},valid:function(p,m){var k=this,l,o,n="";l=k.cutToken(p);o=k.getRPN(l);if(!d.isString(m)){n=f(m).val();}else{n=m;}return k.doValid(o,n,m);},doValid:function(o,k,m){var l=this,n=[];d.each(o,function(p){if(p!="|"&&p!="&"){n.push(p);}else{var r=n.pop(),q=n.pop();if(p=="&"){n.push(l.subValid(r,k,m)&&l.subValid(q,k,m));}else{n.push(l.subValid(r,k,m)||l.subValid(q,k,m));}}});if(n.length!=1){throw ("计算错误，请检查传入样式是否争取");}return l.subValid(n[0],k,m);},cutToken:function(k){var l=/\[|\]|\||&|[.a-zA-Z0-9,()_-]+/ig,m;m=k.match(l);m=d.filter(m,function(n){return/^\s*$/.test(n)?false:true;});return m==null?"":m;},getRPN:function(p){var n=this,k=["#"],o=[],m,l;d.each(p,function(q){if(q!="["&&q!="]"&&q!=" "&&q!="|"&&q!="&"){o.push(q);}else{if(q=="["){k.push(q);}else{if(q=="]"){while((m=k.pop())!="["){o.push(m);}}else{if(q=="|"||q=="&"){l=k[k.length-1];if(l=="["||l=="#"){k.push(q);}else{if(l=="|"||l=="&"){do{m=k.pop();o.push(m);}while(k[k.length-1]!="#"&&k[k.length-1]!="[");k.push(q);}}}}}}});while((m=k.pop())!="#"){o.push(m);}return o;},subValid:function(l,k,p){if(d.isBoolean(l)){return l;}var n=l,q=[k],m=l.search("\\("),o=l.search("\\)");if(m>0&&o>0){n=l.substr(0,m);q=q.concat(l.substr(m+1,o-m-1).split(","));}q.push(p);return(a[n])?a[n].apply(this,q):"false";}});return c;},{requires:["validation/id-card","core"]});KISSY.add("validation/form-error-tip",function(b){var c=b.DOM,a=c.get,e=c.query,d=b.all;function f(h,g){this.form=h;this.opts=g;this.formErrorContainer;this.init();}b.augment(f,{init:function(){var g=this;g._getErrorHolder();},showFormError:function(){var h=this,g=h.formErrorContainer;d(g).show();},hideFormError:function(){var h=this,g=h.formErrorContainer;d(g).hide();},refreshErrorText:function(){},_getErrorHolder:function(){var i=this,j=i.form,h=i.opts,g=a(h.formErrorContainer,j);i.formErrorContainer=g;}});return f;},{requires:["core"]});KISSY.add("validation/tipText",function(b){var a={isCommonUser:"输入以字母开头、可带数字、“_”、“.”、“-”，长度为6-20位 | 输入用户名格式不正确",notCommonUser:"输入内容不可是用户名格式(以字母开头、带数字、“_”、“.”、“-”,长度在6-20位) | 格式不正确",isPassword:"请输入6-20个字母、数字、下划线 | 输入密码格式错误",notPassword:"输如内容不可为密码格式 | 格式不正确",isEmail:"请输入正确的邮件格式,形如：XXX@XX.XX | 输入邮件格式不正确",notEmail:"输入内容不可为邮件格式 | 格式不正确",isNull:"请不要输入 | 输入必须为空",notNull:"请输入任意文本 | 输入错误，输入不能为空",isNumber:"请输入数字 |输入错误，只能输入数字0-9的数字",notNumber:"输入内容不可是数字 | 输入内容是纯数字,错误",isTelephone:"输入座机号码，形如XXXX-XXXXXXX(-XXXX)| 输入座机号码错误，请注意加上区号",notTelePhone:"输入内容不可是电话号码格式 | 格式不正确",isImage:"请输入或者选择图片,图片格式只能是:jpg、gif、png、bmp | 输入或选择图片文件不正确",notImage:"输入内容不可是图片地址 | 格式不正确",isEnglish:"请输入英文字母 | 输入英文格式不正确",notEnglish:"输入内容不可为英文 | 输入内容为纯英文，错误",isHttp:"请输入http地址|http地址输入不正确",notHttp:"输入内容不可是http地址 | 格式不正确",isFlv:"请输入或者选择flv格式文件 | 输入或者选择flv格式文件不正确 ",notFlv:"输入内容不可为Flv地址 | 格式不正确",isFloat:"请输入一个小数(浮点数) | 格式不正确",notFloat:"输入内容不可为浮点数 | 格式不正确",isQQ:"请输入qq号码 | 输入qq号码错误，qq号码必须是-12位的数字",notQQ:"输入内容不可为QQ号码 | 格式不正确",isMobile:"请输入正确的手机号 | 输入手机号码不符合规格",notMobile:"输入不可为手机号码 | 格式不正确",isChinese:"请输入汉字 | 输入必须是汉字",notChinese:"输入不可为汉字 | 格式不正确",isUrl:"请输入URL地址，形如XXX://XXXXXX | URL地址错误",notUrl:"输入不可为Url地址 | 格式不正确",isIdCard:"请输入正确的身份证号 | 输入身份证号错误",notIdCard:"输入不可为身份证号码 | 格式不正确",isZipCode:"请输入邮政编码 | 邮政编码格式错误，一般为6位数字",notZipCode:"输入不可为邮政编码 | 格式不正确",isIP:"请输入IP地址，格式如：XXX.XXX.XXX.XXX,XXX代表0-255之间的数字 | 输入IP地址错误",notIp:"输入不可为IP地址 | 格式不正确",scale:function(f,c,e){var f=parseFloat(f,10),c=parseFloat(c,10),d="";d+="请输入一个范围在"+f+"到"+c+"的(";if(e&&parseInt(e,10)==1){d+="包";}else{d+="不";}d+="含"+f+"和"+c+")的数字 | 输入数值范围不正确";return d;},require:function(c){return"输入需要id名为"+c+"的项目已经验证通过 | "+c+"输入域没有通过验证";},equal:function(c){return"输入需要和id名为"+c+"的项目一致 | 输入内容和selector 项目不同";},length:function(f,c,e){var d="请输入长度在"+f+"-"+c+"之间(";if(e&&parseInt(e,10)==1){d+="包";}else{d+="不";}d+="含"+f+"和"+c+")的数|输入内容长度不符合要求,当前输入长度";return d;}};Tip={getTipByRule:function(g){if(!g||g==""){return"";}var e=g,h=[],d=g.search("\\("),f=g.search("\\)"),c="";if(d>0&&f>0){e=g.substr(0,d);h=h.concat(g.substr(d+1,f-d-1).split(","));}if(c=a[e]){if(b.isFunction(c)){c=c.apply(this,h);}}return(c)?c:"";},removeTipDOM:function(d){var c=query(TIP_CLASS,d);$(c).remove();}};return Tip;});KISSY.add("validation/float-tip",function(f){var w=f.DOM,x=w.get,g=w.query,n=f.Event.on,u=f.Event.delegate,z=f.Event.detach,d=f.IO,e=f.all,m=PW.juicer,l=20,y=6,B=16,i=9,t=6,j=".pw-tip",a="error-state",o="success-state",h="loading-state",b="focus-state",s="vs",k=".tip-arrow",c=".tip-content",r="data-tk",q="data-tipId",C=0,p='<div class="pw-tip &{theme}" '+q+'="&{tipId}" style="display: none; max-width: &{width}px; z-index: &{zIndex};"><div class="tip-arrow tip-arrow-&{direction}"></div><div class="tip-content">&&{content}</div></div>',A={width:100,theme:"yellow",content:"空",showTimeout:2,hideTimeout:2,direction:"top",alignX:"center",alignY:"center",offsetX:0,offsetY:0,zIndex:101,showEvent:"focus",vldEvent:"keyup",trace:false};function v(D,E){this.trigger=x(D);this.tipDOM;this.opts=f.merge(A,E);this.errTipTxt=e(D).data("tip").split("|")[1],this.focusTipTxt=e(D).data("tip").split("|")[0],this.loadingTiptxt="正在加载...";this.tipId=-1;this.tipType="";this.currentState="";this.initState="";this.trace=this.opts.trace;this.actionTransitionFunctions={inactive:{focus:function(F){this.showTip(F.target);this.update("focus");return"fadein";},error:function(F){this.showTip(F.target);this.update("error");return"fadein";},success:function(F){this.showTip(F.target);this.update("success");return"fadein";},loading:function(F){this.showTip(F.target);this.update("loading");return"fadein";}},fadein:{timeout:function(F){return"dsp";},error:function(F){this.update("error");return this.currentState;},success:function(F){this.update("success");return this.currentState;},loading:function(F){this.update("loading");return this.currentState;},focus:function(F){return this.currentState;}},dsp:{error:function(F){this.update("error");return this.currentState;},success:function(F){this.update("success");return this.currentState;},loading:function(F){this.update("loading");return this.currentState;},focus:function(F){this.update("focus");return this.currentState;}},fadeout:{error:function(F){this.reDsp();this.update("error");return"dsp";},success:function(F){this.reDsp();this.update("success");return"dsp";},loading:function(F){this.reDsp();this.update("loading");return"dsp";},focus:function(F){this.reDsp();this.update("focus");return"dsp";},timeout:function(F){return"inactive";}}};this.init();}f.augment(v,f.EventTarget,{init:function(){var E=this,D=E.opts;E.initState="inactive";E.currentState=E.initState;},handleEvent:function(D){var F=this.actionTransitionFunctions[this.currentState][D.type],E;if(!F){F=this.unexpetedEvent;}E=F.call(this,D);if(!E){E=this.currentState;}if(!this.actionTransitionFunctions[E]){E=this.undefinedState(D,E);}if(this.trace){f.log("tipId:"+this.tipId+","+D.type+" 事件引起自动机转移，从 "+this.currentState+"状态->"+E+"状态");}this.currentState=E;},unexpetedEvent:function(D){f.log("未设定的事件出现");return this.initState;},undefinedState:function(){f.log("未定义状态");return this.initState;},doActionTransition:function(D,F,E){return this.actionTransitionFunctions[D][F].call(this,E);},update:function(F){var D=this,E=D.tipDOM;if(F==""){return;}if(F=="success"){D.showSuccessTip();}else{if(F=="error"){D.showErrorTip();}else{if(F=="focus"){D.showFocusTip();}else{if(F=="loading"){D.showLoadingTip();}}}}D._fixPos(D.trigger,D.tipDOM);},showSuccessTip:function(){var E=this,D=E.trigger,F=E.tipDOM;e(F).removeClass(b).removeClass(a).removeClass(h).addClass(o).one(c).html("&nbsp;");e(D).data(s,"success");},showErrorTip:function(){var F=this,E=F.opts,D=F.trigger,G=F.tipDOM;e(G).removeClass(b).removeClass(o).removeClass(h).addClass(a).one(c).html(F.errTipTxt);e(D).data(s,"error");},showFocusTip:function(){var F=this,E=F.opts,D=F.trigger,G=F.tipDOM;e(G).removeClass(a).removeClass(o).removeClass(h).addClass(b).one(c).html(F.focusTipTxt);e(D).data(s,"focus");},showLoadingTip:function(){var F=this,E=F.opts,D=F.trigger,G=F.tipDOM;e(G).removeClass(a).removeClass(o).removeClass(b).addClass(h).one(c).html(F.loadingTiptxt);e(D).data(s,"focus");},showTip:function(E){var F=this,G,D=w.attr(E,r),H;if(!D||D==""){G=F._createTipDOM(E);w.append(G,"body");F._fixPos(E,G);e(G).fadeIn(F.opts.showTimeout,function(){F.handleEvent({type:"timeout"});});F.tipDOM=G;}else{f.log("tip已经存在");}return F;},hideTip:function(){var E=this,F,D=E.trigger,G=E.tipDOM;if(G!=null){e(G).fadeOut(E.opts.hideTimeout,function(){e(G).remove();e(D).removeAttr(r);E.handleEvent({type:"timeout"});});}else{f.log("关闭失败，你要关闭的tip不存在");}return E;},destroyTip:function(E){var G=this,F=G.opts,D=G.trigger,H=G.tipDOM;if(H){e(H).fadeOut(G.opts.hideTimeout,function(){e(D).removeAttr(r);e(H).remove();if(f.isFunction(E)){E(D);}});}else{e(D).removeAttr(r);e(H).remove();if(f.isFunction(E)){E(D);}}},_createTipDOM:function(E){var I=this,H=I.opts,G="",D=C++,J,F;G=m(p,{tipId:D,width:H.width,theme:H.theme,direction:H.direction,zIndex:H.zIndex,content:(H.content&&f.isString(H.content))?H.content.split("|")[0]:""});this.tipId=D;w.attr(E,r,D);J=w.create(G);return J;},_fixPos:function(G,M){var L=this,E=L.opts,P=x(k,M),Q=w.outerWidth(G),J=w.outerHeight(G),S=w.offset(G),H=S.left,R=S.top,D=w.width(M),N=w.height(M),K,F,O,I;switch(E.direction){case"auto":break;case"top":F=R-N-i;if(E.alignX=="left"){K=H;O=(Q>l+B)?l:(Q-B)/2;if(O<t){K=H+Q/2-B/2-t;O=t;}e(P).css({marginLeft:0,left:O});}else{if(E.alignX=="right"){K=H+Q-D;O=(Q>l+B)?(D-l-B):D-Q/2-B/2;if(Q/2-B/2<t){O=D-t-B;K=H+Q/2+B/2+t-D;}e(P).css({marginLeft:0,left:O});}else{if(E.alignX=="center"){K=H+Q/2-D/2;}}}break;case"bottom":F=R+J+i;if(E.alignX=="left"){K=H;O=(Q>l+B)?l:(Q-B)/2;if(O<t){K=H+Q/2-B/2-t;O=t;}e(P).css({marginLeft:0,left:O});}else{if(E.alignX=="right"){K=H+Q-D;O=(Q>l+B)?(D-l-B):D-Q/2-B/2;if(Q/2-B/2<t){O=D-t-B;K=H+Q/2+B/2+t-D;}e(P).css({marginLeft:0,left:O});}else{if(E.alignX=="center"){K=H+Q/2-D/2;}}}break;case"left":K=H-D-i;if(E.alignY=="top"){F=R;I=(J>y+B)?y:(J-B)/2;if(I<t){I=t;F=R+J/2-B/2-t;}e(P).css({top:I});}else{if(E.alignY=="bottom"){F=R+J-N;I=(J>y+B)?(N-y-B):N-J/2-B/2;if(J/2-B/2<t){F=R+J/2+B/2+t-N;I=N-t-B;}e(P).css({top:I});}else{if(E.alignY=="center"){F=R+J/2-N/2;e(P).css({top:N/2-B/2});}}}break;case"right":K=H+Q+i;if(E.alignY=="top"){F=R;I=(J>y+B)?y:(J-B)/2;if(I<t){I=t;F=R+J/2-B/2-t;}e(P).css({top:I});}else{if(E.alignY=="bottom"){F=R+J-N;I=(J>y+B)?(N-y-B):N-J/2-B/2;if(J/2-B/2<t){F=R+J/2+B/2+t-N;I=N-t-B;}e(P).css({top:I});}else{if(E.alignY=="center"){F=R+J/2-N/2;e(P).css({top:N/2-B/2});}}}break;default:break;}e(M).css({left:K,top:F});return M;}});return v;},{requires:["core","mod/juicer","sizzle"]});KISSY.add("validation/inside-tip",function(e){var k=e.DOM,d=k.get,i=k.query,f=e.all,a="focus-state",g="error-state",h="loading-state",b="success-state",j={fieldErrorContainer:""};function c(l,m){this.field=l;this.opts=e.merge(j,m);this.form=this.form;this.tipEl;this.loadingTipText="正在加载...";this.errorTipText;this.focusTipText;this.currentState="";this.initState="";this.trace=this.opts.trace;this.actionTransitionFunctions=this._getATF();this.init();}e.augment(c,e.EventTarget,{init:function(){var l=this;this.actionTransitionFunctions=this._getATF();this.tipEl=this._getTipEelement();this.errorTipText=f(this.field).data("tip").split("|")[1];this.focusTipText=f(this.field).data("tip").split("|")[0];l.initState="inactive";l.currentState=l.initState;},handleEvent:function(l){var n=this.actionTransitionFunctions[this.currentState][l.type],m;if(!n){n=this.unexpetedEvent;}m=n.call(this,l);if(!m){m=this.currentState;}if(!this.actionTransitionFunctions[m]){m=this.undefinedState(l,m);}if(this.trace){e.log("tipId:"+this.tipId+","+l.type+" 事件引起自动机转移，从 "+this.currentState+"状态->"+m+"状态");}this.currentState=m;},unexpetedEvent:function(l){e.log("未设定的事件出现");return this.initState;},undefinedState:function(){e.log("未定义状态");return this.initState;},doActionTransition:function(l,n,m){return this.actionTransitionFunctions[l][n].call(this,m);},update:function(m){var n=this,l=f(n.tipEl);switch(m){case"focus":n._change2Focus();break;case"error":n._change2Error();break;case"success":n._chage2Success();break;case"loading":n._change2Loading();break;default:alert("验证出现错误");}},showTip:function(){var m=this,l=m.tipEl;f(l).show();},hideTip:function(){var m=this,l=m.tipEl;f(l).hide();},destroyTip:function(){var m=this,l=m.tipEl;f(l).hide();},_change2Loading:function(){var n=this,m=n.tipEl,l=n.loadingTipText;f(m).removeClass(a).removeClass(b).removeClass(g).addClass(h).text(l);},_change2Error:function(){var m=this,l=m.tipEl,n=m.errorTipText;f(l).removeClass(a).removeClass(b).removeClass(h).addClass(g).text(n);},_chage2Success:function(){var m=this,l=m.tipEl,n=m.errorTipText;f(l).removeClass(a).removeClass(g).removeClass(h).addClass(b).html("&nbsp;");},_change2Focus:function(){var m=this,l=m.tipEl,n=m.focusTipText;f(l).removeClass(g).removeClass(b).removeClass(h).addClass(a).text(n);},_getTipEelement:function(){var o=this,p=o.form,n=o.opts,q=o.field,m,l=null;m=k.attr(q,"id");if(m!=""){l=d(n.fieldErrorContainer+'[for="'+m+'"]',p);}return l;},_getATF:function(){return{inactive:{focus:function(l){this.showTip(l.target);this.update("focus");return"dsp";},error:function(l){this.showTip(l.target);this.update("error");return"dsp";},success:function(l){this.showTip(l.target);this.update("success");return"dsp";},loading:function(l){this.showTip(l.target);this.update("loading");return"dsp";}},dsp:{error:function(l){this.update("error");return this.currentState;},success:function(l){this.update("success");return this.currentState;},loading:function(l){this.update("loading");return this.currentState;},focus:function(l){this.update("focus");return this.currentState;}}};}});return c;},{requires:["core","sizzle"]});KISSY.add("validation/inline-tip",function(f){var p=f.DOM,e=p.get,m=p.query,g=f.all,k=f.juicer,b="focus-state",l="error-state",j="loading-state",c="success-state",d="",n="data-tk",d="data-tipId",i='<span class="pw-tip" '+d+'="&{tipId}" style="display: none;"></span>',a=0,o={};function h(q,r){this.field=q;this.opts=f.merge(o,r);this.form=this.form;this.tipEl;this.loadingTipText="正在加载...";this.errorTipText;this.focusTipText;this.currentState="";this.initState="";this.trace=this.opts.trace;this.actionTransitionFunctions=this._getATF();this.init();}f.augment(h,{init:function(){var q=this;q.actionTransitionFunctions=q._getATF();q.errorTipText=g(q.field).data("tip").split("|")[1];q.focusTipText=g(q.field).data("tip").split("|")[0];q.initState="inactive";q.currentState=q.initState;},handleEvent:function(q){var s=this.actionTransitionFunctions[this.currentState][q.type],r;if(!s){s=this.unexpetedEvent;}r=s.call(this,q);if(!r){r=this.currentState;}if(!this.actionTransitionFunctions[r]){r=this.undefinedState(q,r);}if(this.trace){f.log("tipId:"+this.tipId+","+q.type+" 事件引起自动机转移，从 "+this.currentState+"状态->"+r+"状态");}this.currentState=r;},_getATF:function(){return{inactive:{focus:function(q){this.showTip(q.target);this.update("focus");return"dsp";},error:function(q){this.showTip(q.target);this.update("error");return"dsp";},success:function(q){this.showTip(q.target);this.update("success");return"dsp";},loading:function(q){this.showTip(q.target);this.update("loading");return"dsp";}},dsp:{error:function(q){this.update("error");return this.currentState;},success:function(q){this.update("success");return this.currentState;},loading:function(q){this.update("loading");return this.currentState;},focus:function(q){this.update("focus");return this.currentState;}}};},unexpetedEvent:function(q){f.log("未设定的事件出现");return this.initState;},undefinedState:function(){f.log("未定义状态");return this.initState;},doActionTransition:function(q,s,r){return this.actionTransitionFunctions[q][s].call(this,r);},showTip:function(){var q=this,r=q.field;if(!q.tipEl){q.tipEl=q._getTipEelement();g(q.tipEl).insertAfter(r).show();}},hideTip:function(){var q=this;if(q.tipEl){g(q.tipEl).hide();}},destroyTip:function(){var q=this;if(q.tipEl){g(q.tipEl).remove();q.tipEl=undefined;}},update:function(q){var r=this;switch(q){case"focus":r._change2Focus();break;case"error":r._change2Error();break;case"success":r._chage2Success();break;case"loading":r._change2Loading();break;default:alert("验证出现错误");}},_getTipEelement:function(){var u=this,s=u.opts,r,q;r=k(i,{theme:s.theme,tipId:a++,direction:s.direction,content:""});return p.create(r);},_change2Loading:function(){var s=this,r=s.tipEl,q=s.loadingTipText;g(r).removeClass(b).removeClass(c).removeClass(l).addClass(j).text(q);},_change2Error:function(){var r=this,q=r.tipEl,s=r.errorTipText;g(q).removeClass(b).removeClass(c).removeClass(j).addClass(l).text(s);},_chage2Success:function(){var r=this,q=r.tipEl;g(q).removeClass(b).removeClass(l).removeClass(j).addClass(c).html("&nbsp;");},_change2Focus:function(){var r=this,q=r.tipEl,s=r.focusTipText;g(q).removeClass(l).removeClass(c).removeClass(j).addClass(b).text(s);}});return h;},{requires:["mod/juicer","core","sizzle"]});KISSY.add("validation/id-card",function(b){function a(c){this.Valid=false;this.ID15="";this.ID18="";this.Local="";if(c!=null){this.SetCardNo(c);}}a.prototype.SetCardNo=function(c){this.ID15="";this.ID18="";this.Local="";c=c.replace(" ","");var d;if(c.length==18){pattern=/^\d{17}(\d|x|X)$/;if(pattern.exec(c)==null){return;}d=c.toUpperCase();}else{pattern=/^\d{15}$/;if(pattern.exec(c)==null){return;}d=c.substr(0,6)+"19"+c.substr(6,9);d+=this.GetVCode(d);}this.Valid=this.CheckValid(d);};a.prototype.IsValid=function(){return this.Valid;};a.prototype.GetBirthDate=function(){var c="";if(this.Valid){c=this.GetBirthYear()+"-"+this.GetBirthMonth()+"-"+this.GetBirthDay();}return c;};a.prototype.GetBirthYear=function(){var c="";if(this.Valid){c=this.ID18.substr(6,4);}return c;};a.prototype.GetBirthMonth=function(){var c="";if(this.Valid){c=this.ID18.substr(10,2);}if(c.charAt(0)=="0"){c=c.charAt(1);}return c;};a.prototype.GetBirthDay=function(){var c="";if(this.Valid){c=this.ID18.substr(12,2);}return c;};a.prototype.GetSex=function(){var c="";if(this.Valid){c=this.ID18.charAt(16)%2;}return c;};a.prototype.Get15=function(){var c="";if(this.Valid){c=this.ID15;}return c;};a.prototype.Get18=function(){var c="";if(this.Valid){c=this.ID18;}return c;};a.prototype.GetLocal=function(){var c="";if(this.Valid){c=this.Local;}return c;};a.prototype.GetVCode=function(g){var f=new Array(7,9,10,5,8,4,2,1,6,3,7,9,10,5,8,4,2,1);var e=new Array("1","0","X","9","8","7","6","5","4","3","2");var d=0;for(var h=0;h<g.length;h++){d+=g.charAt(h)*f[h];}var c=d%11;return e[c];};a.prototype.CheckValid=function(c){if(this.GetVCode(c.substr(0,17))!=c.charAt(17)){return false;}if(!this.IsDate(c.substr(6,8))){return false;}var d={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"};if(d[parseInt(c.substr(0,2))]==null){return false;}this.ID18=c;this.ID15=c.substr(0,6)+c.substr(8,9);this.Local=d[parseInt(c.substr(0,2))];return true;};a.prototype.IsDate=function(c){var e=c.match(/^(\d{1,4})(\d{1,2})(\d{1,2})$/);if(e==null){return false;}var f=new Date(e[1],e[2]-1,e[3]);return(f.getFullYear()==e[1]&&(f.getMonth()+1)==e[2]&&f.getDate()==e[3]);};return a;});