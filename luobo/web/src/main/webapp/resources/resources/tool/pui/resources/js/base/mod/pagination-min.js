KISSY.add("mod/pagination",function(b,a){PW.pagination=function(c){return new a(c);};},{requires:["mod/pagination/core"]});KISSY.add("mod/pagination/core",function(g,n,f,h,b){var q=g.DOM,e=q.get,m=q.query,o=g.JSON,l=g.Event.on,c=g.IO,r=function(){},k={showCounter:true,themeCounter:"{page}/{pageCount}",showJump:true,themeJump:"跳到第{input}页{button}",showPageNum:true,showFirst:true,showLast:true,themeCss:"J_pagination_theme1",firstPageTip:"<<",lastPageTip:">>",prevPageTip:"上一页",nextPageTip:"下一页"},d={renderTo:"",juicerRender:"",dataRender:"#J_template",page:1,pageSize:10000,dataCount:0,pageCount:0,themePackageURL:"",themeName:"default",type:"get",url:"",extraParam:null,sendData:function(){},configUrl:function(j,s,a){},beforeDataLoad:r,afterDataLoad:r,initCompleted:r,beforeSendAJAX:r,errorFun:r};THEME_URL=PW.libUrl+"js/base/assets/pagination/css/default.css";g.getScript(THEME_URL,{charset:"utf-8"});var p=function(j){var a=g.clone(d);this.opts=g.mix(a,j,true,[],true);this.lock=false;this.init();};p.prototype={init:function(){var j=this,a=j.opts;j.prevPaginationData=null;j._getThemePackage();if(a.initCompleted){a.initCompleted();}},reload:function(a){this.opts=g.mix(this.opts,{page:1},a);this.tDOM.html("");this.init();},refresh:function(a){this.opts=g.mix(this.opts,{page:1},a);this._sendAjax(this.opts.page);},_getThemePackage:function(){var s=this,j=s.opts,a=j.themePackageURL,u;if(a&&a!==""&&a!==null&&a!==undefined){u=$.getJSON(a,function(w){w=(g.isString(w))?g.JSON.parse(w):w;var v;if(j.themeName){v=j.themeName;}else{v="default";}s.opts.themePackage=w.pagination[v];});window.setTimeout(function(){if(u.status!==200){g.log("主题包获取失败,直接使用默认配置！");if(j.themePackage){var v;if(j.themeName){v=j.themeName;}else{v="default";}if(PW.modSettings.pagination){s.opts.themePackage=PW.modSettings.pagination.themePackage[v];}}else{j.themePackage=k;}}},2000);s.prevPaginationData;s.pctrl=new b(j);s._sendAjax(j.page);}else{if(PW.modSettings){if(PW.modSettings.pagination){var t;if(j.themeName){t=j.themeName;}else{t="default";}s.opts.themePackage=PW.modSettings.pagination.themePackage[t];}else{j.themePackage=k;}}s.prevPaginationData;s.pctrl=new b(j);s._sendAjax(j.page);}},_sendAjax:function(u){var t=this,s=t.opts,a,j;if(!s.timeout||s.timeout==undefined||s.timeout==""||s.timeout==null){s.timeout=10;}t.lock=true;c({type:s.type,url:s.configUrl(t.opts.url,t.opts.page,t,t.prevPaginationData),data:g.mix(s.extraParam,{_:g.now()}),timeout:s.timeout,success:function(B){B=(g.isString(B))?g.JSON.parse(B):B;if(s.beforeDataLoad){if(s.beforeDataLoad(t,B)==false){t.lock=false;return;}}if(B.dataCount!==null&&B.dataCount!==""&&B.dataCount!==undefined){s.dataCount=B.dataCount;}s.pageCount=Math.ceil(s.dataCount/s.pageSize);t.opts.sendData(t,B);for(i in B){if(g.isArray(B[i])){var A=B[i];}}if(A){if(A.length==0){var w=q.get(s.dataRender).nodeName.toLowerCase();if(w=="tbody"){var y=q.parent(s.dataRender),z=e("thead",y),v=1,x="";if(z){v=m("th",z).length||m("td",z).length;}x='<tr><td colspan="'+v+'" align="center">暂无数据！</td></tr>';$(s.dataRender).html(x);}else{q.html(s.dataRender,"暂无数据！");}q.html(s.renderTo,"");}else{if(s.juicerRender.indexOf("#")<0){j=$("#"+s.juicerRender).html();}else{j=$(s.juicerRender).html();}t.prevPaginationData=B;var x=f(j,B);q.html(s.dataRender,x);t.pctrl.refresh(s.dataCount,u);}}t._pageClick();if(s.afterDataLoad){s.afterDataLoad(t,B,u);}t.lock=false;},error:function(){g.log("ajax发送失败，没有获取到数据！");if(s.errorFun){s.errorFun(t);}}});},_pageClick:function(){var j=this,a=j.opts;j.tDOM=$(a.renderTo);j.tDOM.find("#J_firstPage").click(function(){if(!($(this).hasClass("disabled"))){if(!j.lock){a.page=1;j._sendAjax(a.page);}}});j.tDOM.find("#J_prevPage").click(function(){if(!($(this).hasClass("disabled"))){if(!j.lock){a.page=a.page-1;j._sendAjax(a.page);}}});j.tDOM.find("#J_nextPage").click(function(){if(!($(this).hasClass("disabled"))){if(!j.lock){a.page=a.page+1;j._sendAjax(a.page);}}});j.tDOM.find("#J_lastPage").click(function(){if(!($(this).hasClass("disabled"))){if(!j.lock){a.page=a.pageCount;j._sendAjax(a.page);}}});j.tDOM.find(".J_page").each(function(){if(!($(this).hasClass("check"))){$(this).click(function(){if(!j.lock){var s=$(this).children("span").text();a.page=parseInt(s);j._sendAjax(a.page);}});}});j.tDOM.find(".J_btnGo").click(function(){if($(this).prev("#pageNum").val()&&$(this).prev("#pageNum").val()!==""&&$(this).prev("#pageNum").val()!==null){if(!j.lock){var s=$(this).prev("#pageNum").val();s=parseInt(s);if(s>j.opts.pageCount){a.page=a.pageCount;}else{if(s<1){a.page=1;}else{if(isNaN(s)){a.page=1;}else{a.page=s;}}}j._sendAjax(a.page);}}});},_toPage:function(s){var j=this,a=j.opts;a.page=parseInt(s);j.tDOM.html("");j.pctrl.refresh(a.dataCount,a.page);}};return p;},{requires:["thirdparty/jquery","mod/juicer","core","pagination/Pctrl"]});KISSY.add("pagination/Pctrl",function(d){var e=d.DOM,c=e.get,f=e.query,b={renderTo:"",pageSize:10,showCounter:true,showJump:true,showPageNum:true};function a(g){this.opts=d.merge(b,g);}d.augment(a,d.EventTarget,{refresh:function(m,l){var j=this,h=j.opts,g="",k=$(h.renderTo);h.page=l;h.dataCount=m;h.pageCount=Math.ceil(h.dataCount/h.pageSize);j._checkPage(l);g=j._generateHTML(l);k.addClass(h.themePackage.themeCss).html(g);},_configHandel:function(){var h=this,g=h.opts;if(g.themePackage){h.themeCounter=g.themePackage.themeCounter;h.themeCounter=d.substitute(h.themeCounter,{page:g.page,pageCount:g.pageCount});h.themeJump=g.themePackage.themeJump;h.themeJump=d.substitute(h.themeJump,{input:'<input type="text" id="pageNum" name="pageNum" class="goTo" value="" />',button:'<button class="J_btnGo" type="button">&nbsp;</button>'});}},_generateHTML:function(){var n=this,m=n.opts,l="",h=0,j=parseInt(m.page)-1,g=parseInt(m.page)+1;n._configHandel();if(j<1){if(m.themePackage.showFirst==true){l+='<span id="J_firstPage" class="firstPage disabled" title="First Page">'+m.themePackage.firstPageTip+"</span>";}l+='<span id="J_prevPage" class="prevPage disabled" title="Prev Page">'+m.themePackage.prevPageTip+"&nbsp;</span>";}else{if(m.themePackage.showFirst==true){l+='<a><span id="J_firstPage" title="First Page">'+m.themePackage.firstPageTip+"</span></a>";}l+='<a><span id="J_prevPage" title="Prev Page">'+m.themePackage.prevPageTip+"&nbsp;</span></a>";}if(m.page!=1&&m.themePackage.showPageNum==true){l+='<a class="J_page"><span title="Page 1">1</span></a>';}if(m.page>=5&&m.themePackage.showPageNum==true){l+='<span class="until">...</span>';}if(m.pageCount>m.page+2){h=m.page+2;}else{h=m.pageCount;}for(var k=m.page-2;k<=h;k++){if(k>0){if(k==m.page&&m.themePackage.showPageNum==true){l+='<span title="Page '+k+'" class="check">'+k+"</span>";}else{if(k!=1&&k!=m.pageCount&&m.themePackage.showPageNum==true){l+='<a class="J_page"><span title="Page '+k+'">'+k+"</span></a>";}}}}if(m.page+3<m.pageCount&&m.themePackage.showPageNum==true){l+='<span class="until">...</span>';}if(m.page!=m.pageCount&&m.themePackage.showPageNum==true){l+='<a class="J_page"><span title="Page '+this.opts.pageCount+'">'+this.opts.pageCount+"</span></a>";}if(g>m.pageCount){l+='<span id="J_nextPage" class="nextPage disabled" title="Next Page">&nbsp;'+m.themePackage.nextPageTip+"</span>";if(m.themePackage.showLast==true){l+='<span id="J_lastPage" class="lastPage disabled" title="Last Page">'+m.themePackage.lastPageTip+"</span>";}}else{l+='<a><span id="J_nextPage" title="Next Page">&nbsp;'+m.themePackage.nextPageTip+"</span></a>";if(m.themePackage.showLast==true){l+='<a><span id="J_lastPage" title="Last Page">'+m.themePackage.lastPageTip+"</span></a>";}}if(m.themePackage.showCounter==true&&m.pageCount>=5){l+='<span class="count">'+this.themeCounter+"</span>";}if(m.themePackage.showJump==true&&m.pageCount>=5){l+=this.themeJump;}l+="<br/>";if(m.pageCount<=1){l="";}return l;},_checkPage:function(){var g=this.opts;if(isNaN(parseInt(g.page))){g.page=1;}if(isNaN(parseInt(g.pageCount))){g.pageCount=1;}if(g.page<1){g.page=1;}if(g.pageCount<1){g.pageCount=1;}if(g.page>g.pageCount){g.page=g.pageCount;}g.page=parseInt(g.page);g.pageCount=parseInt(g.pageCount);}});return a;},{requires:["core"]});