/*-----------------------------------------------------------------------------
* @Description: 会员编辑
* @Version:     V1.0.0
* @author:      cuiy(361151713@qq.com)
* @date         2014.01.21
* ==NOTES:=============================================
* v1.0.0(2014.01.21):
*   初始生成
* ---------------------------------------------------------------------------*/

KISSY.add('page/member/edit', function (S, Contact) {
    PW.namespace('page.Member.Edit');
    PW.page.Member.Edit = function(param){
        new Contact(param);
    }
},{
    requires:[
        'edit/contact',
        'module/forbidBackSpace'
    ]
});
/**
 * 会员来源操作
 * @param  {[type]} S [description]
 * @return {[type]}   [description]
 */
KISSY.add('edit/source', function(S){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, delegate = S.Event.delegate,
        $ = S.all, 
        Dialog = PW.widget.Dialog,
        MemberIO = PW.io.Member,
        Juicer = PW.mod.Juicer,
        el = {
            //会员身份审核表单
            editForm:'.J_editForm',
            // 人员来源为在校学生
            student: '.J_student',
            // 人员来源为社会人员
            staff: '.J_staff',
            // 职位
            job: '.J_job',
            // 区域
            regionEl: '.J_region',
            // 学校
            schoolEl: '.J_school',
            // 学校列表模板
            schoolListTpl: '#schoolTpl',
            // 隐藏域人员来源
            sourceEl: '.J_source'
        },
        DATA_ENLIGHT = 'data-enlight';

    function Source(param){
        this.original;
        this.editFormValid;
        this._init();
    }

    S.augment(Source, {
        _init: function(){
        	this._initOriginal();
            this._buildEvtHandle();
        },
        _buildEvtHandle: function(){
            var
                that = this;
            // 根据人员来源初始学校/工作单位、职位
            on('input[name="source"]', 'click', function(e){
                that._getOriginal(e.target);
            });
            // 选择区域，联动学校
            on(el.regionEl, 'change', function(e){
                that._selectSchool(e.target);
            });
            // 消除学校下拉列表焦点
            delegate(el.editForm, 'click', el.schoolEl, function(){
                that._removeFocus();
            });
        },
        /**
         * 初始化人员来源值
         * @return {[type]} [description]
         */
        _initOriginal: function(){
        	var
        		that = this,
        		// 人员来源节点
        		sourceEl = get(el.sourceEl),
        		// 学校节点
        		schoolEl = get(el.schoolEl, el.editForm);

        	that.original =  DOM.val(sourceEl);
        	if(that.original == 1){
        		DOM.hide(schoolEl);
        	}else{
        		DOM.show(schoolEl);
        	}
        },
        /**
         * 获取人员来源
         * @param  {[type]} e [description]
         * @return {[type]}   [description]
         */
        _getOriginal: function(e){
            var
                that = this,
                jobValue = DOM.val(e),
                schoolEl = get(el.schoolEl, el.editForm);

            if(jobValue == 0){
                DOM.show(schoolEl);
                DOM.attr(schoolEl, 'name', 'regionId');
                that.original = 0;
            }else if(jobValue == 1){
                DOM.attr(schoolEl, 'name', '');
                DOM.hide(schoolEl);
                that.original = 1;
            }
        },
        /**
         * 消除focus焦点
         * @return {[type]} [description]
         */
        _removeFocus: function(){
            var
                that = this,
                schoolEl = get(el.schoolEl, el.editForm),
                regionEl = get(el.regionEl, el.editForm);
            DOM.removeClass(schoolEl, 'focus');

        },
        /**
         * 联动选择出学校的列表
         * @param  {[type]} e [description]
         * @return {[type]}   [description]
         */
        _selectSchool: function(e){
            var
                that = this,
                regionId = DOM.val(e),
                schoolTplHtml,
                schoolListTpl,
                schoolListTplEl;
            DOM.removeClass(e, 'focus');
            if(that.original == 0){
                MemberIO.sendRegionId({id: regionId}, function(code, data, errMsg){
                    if(code){
                        // 获取渲染模板
                        schoolTplHtml = DOM.html(el.schoolListTpl);
                        // 获取学校列表数据
                        schoolListTpl = Juicer(schoolTplHtml, {list: data});
                        schoolListTplEl = DOM.create(schoolListTpl);
                        DOM.empty(el.schoolEl);
                        DOM.append(schoolListTplEl, el.schoolEl);
                    }
                });
            }
        }
    });
    return Source;
},{
    requires:[
        'core',
        'io/member',
        'widget/dialog',
        'mod/juicer'
    ]
});

/**
 * 会员的联系人操作
 * @param  {[type]} S    [description]
 * @param  {[type]} Core [description]
 * @return {[type]}      [description]
 */
KISSY.add('edit/contact', function(S, Core){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, delegate = S.Event.delegate,
        $ = S.all, 
        Defender = PW.mod.Defender.client,
        Dialog = PW.widget.Dialog,
        MemberIO = PW.io.Member,
        Juicer = PW.mod.Juicer,
        el = {
            //会员身份审核表单
            editForm:'.J_editForm',
            // 添加家庭联系人按钮
	        addFamily: '.J_addFamily',
	        // 添加其他联系人按钮
	        addOther: '.J_addOther',
	        // 添加联系人模板
	        addContact: '#addTpl',
	        // 家庭联系人渲染区域
	        dataTemp: '#J_familyTemplate',
	        // 其他联系人渲染区域
	        itemTemp: '#J_otherTemplate',
	        // 联系人表单
	        contactFrom: '.J_contactForm',
	        // 保存联系人
	        saveContactEl: '.J_save',
	        // 取消联系人
	        cancelContact: '.J_cancel',
	        // 编辑联系人
	        editContact: '.J_edit',
	        // 删除联系人
	        deleteContact: '.J_delete',
            // 渲染联系人模板
            renderTpl: '#renderTpl',
            // 会员id
            userIdEl: '.J_userId',
            // 联系人的关系
            contactRelation: '.J_contactRelation',
            // 联系人姓名
            contactName: '.J_contactName',
            // 联系人电话
            contactPhone: '.J_contactPhone',
            // 联系人工作单位
            contactWork: '.J_contactWork'
        },
        DATA_CONTACT_ID = 'data-contact-id',
     	TYPE = 'type',
     	CONFIRM_TIP = '确定要删除该联系人吗？',
     	FAMILY_TABLE = 'J_familyTemplate',
     	ERROR_TIP = ['操作联系人失败：已存在编辑项，请保存后再操作！', '保存成功！', '修改成功！', '删除成功！'];
	

    function Contact(param){
    	this.relationshipType;
    	this.core = new Core(param);
        this._init();
    }

    S.augment(Contact, {
        _init: function(){
            this._buildEvtHandle();
        },
        _buildEvtHandle: function(){
            var
                that = this;
            // 添加家庭联系人操作
            on(el.addFamily, 'click', function(){
             	if(that.core._isEdit()){
                 	that._addFamliy();
             	}
            });
            // 添加其他联系人操作
            on(el.addOther, 'click', function(){
             	if(that.core._isEdit()){
                 	that._addOther();
             	}
            });
            // 保存家庭联系人操作
            delegate(el.dataTemp, 'click', el.saveContactEl, function(e){
                that._saveContact(e.target);
            });
            // 取消家庭联系人操作
            delegate(el.dataTemp, 'click', el.cancelContact, function(e){
                that._cancelContact(e.target);
            });
            // 删除家庭联系人操作
            delegate(el.dataTemp, 'click', el.deleteContact, function(e){
                if(that.core._isEdit()){
                    that._deleteContact(e.target);
                }
            });
            // 编辑家庭联系人操作
            delegate(el.dataTemp, 'click', el.editContact,function(e){
             	if(that.core._isEdit()){
                 	that._editContact(e.target);
             	}
            });
            //  保存其他联系人操作
            delegate(el.itemTemp, 'click', el.saveContactEl, function(e){
                that._saveContact(e.target);
            });
            // 取消其他联系人操作
            delegate(el.itemTemp, 'click', el.cancelContact, function(e){
                that._cancelContact(e.target);
            });
            // 删除其他联系人操作
            delegate(el.itemTemp, 'click', el.deleteContact, function(e){
                if(that.core._isEdit()){
                    that._deleteContact(e.target);
                }
            });
            // 编辑其他联系人操作
            delegate(el.itemTemp, 'click', el.editContact,function(e){
             	if(that.core._isEdit()){
                 	that._editContact(e.target);
             	}
            });
        },
		/**
      	 * 添加家庭联系人操作
         */
     	_addFamliy: function(){
         	var
             	that = this,
             	newFamliyHtml = DOM.html(el.addContact),
             	newFamliyTpl = Juicer(newFamliyHtml, {contact: {}}),
             	newFamliyEl = DOM.create(newFamliyTpl);
         	that.relationshipType = 0;
         	DOM.append(newFamliyEl, el.dataTemp);
         	that.core.formValid.refresh();
     	},
	     /**
	      * 添加其他联系人操作
	      */
	    _addOther: function(){
	        var
	            that = this,
	            newOtherHtml = DOM.html(el.addContact),
	            newOtherTpl = Juicer(newOtherHtml, {contact: {}}),
	            newOtherEl = DOM.create(newOtherTpl);

	        that.relationshipType = 1;
	        DOM.append(newOtherEl, el.itemTemp);
         	that.core.formValid.refresh();
	    },
	    /**
	      * 保存联系人操作
	      * @param  {[type]} e [description]
	      * @return {[type]}   [description]
	      */
     	_saveContact: function(e){          
         	var
             	that = this,
             	trEl = DOM.parent(e, 'tr'),
             	contactObj = {},
             	type = DOM.attr(trEl, TYPE),
             	result = true;

         	// 获取到联系人的信息对象
         	contactObj = that._getContactObj(trEl);
         	// 验证表格是否为空
         	result = that._getValidResult(contactObj);

         	if(result){
             	if(type == 'edit'){
                 	that._sendEditContact(contactObj, trEl);
             	}else{
                 	that._sendNewContace(contactObj, trEl);
            	}
         	}else{
             	that._getFocus(trEl);
             	S.log('联系人表单未通过验证');
         	}
     	},
     	/**
	      * 发送新建的联系人
	      * @param  {[type]} obj [description]
	      * @param  {[type]} tr  [description]
	      * @return {[type]}     [description]
	      */
     	_sendNewContace: function(obj, tr){
         	var
             	that = this,
             	relationshipType,
             	userIdEl = get(el.userIdEl),
             	userId = DOM.val(userIdEl);
         	S.mix(obj, {
             	relationshipType: that.relationshipType,
             	userId: userId
         	});
         	MemberIO.save(obj, function(code, data, errMsg){
             	if(code){
                 	Dialog.alert(ERROR_TIP[1]);
                 	S.mix(obj, {id: data.id});
                 	that._renderContact(obj, tr);
             	}else{
                 	Dialog.alert(errMsg);
             	}
         	});
     	},
     	/**
	      * 取消编辑联系人
	      * @param  {[type]} e [description]
	      * @return {[type]}   [description]
	      */
     	_cancelContact: function(e){
     	    var
             	that = this,
             	trEl = DOM.parent(e, 'tr'),
             	nextTrEl = DOM.next(trEl);

         	DOM.remove(trEl);
         	DOM.show(nextTrEl);
     	},
     	/**
	      * 删除联系人
	      * @param  {[type]} e [description]
	      * @return {[type]}   [description]
	      */
     	_deleteContact: function(e){
         	var
             	that = this,
             	trEl = DOM.parent(e,'tr'),
             	id = DOM.attr(trEl, DATA_CONTACT_ID),
             	userIdEl = get(el.userIdEl),
             	userId = DOM.val(userIdEl);
            
         	Dialog.confirm(CONFIRM_TIP,function(e,me){
             	try{
                 	MemberIO.del({
                 	    id: id,
                     	userId: userId
                 	},function(code,errMsg){
                     	if(code){
                         	Dialog.alert(ERROR_TIP[3]);
                         	DOM.remove(trEl);
                     	}else{
                        	Dialog.alert(errMsg); 
                     	}
                 	});
             	}catch(e){
                 	S.log(e);
            	}
         	}, null, {width:600});
     	},
     	/**
	      * 编辑联系人信息
	      * @param  {[type]} e [description]
	      * @return {[type]}   [description]
	      */
     	_editContact: function(e){
         	var
             	that = this,
             	trEl = DOM.parent(e, 'tr'),
             	contactObj = {};
         	// 获取联系人的类型
         	that._getRelationType(e);
         	// 获取编辑的联系人的信息对象
         	contactObj = that._getContactObj(trEl);
         	// 标记此刻的操作为编辑操作
         	S.mix(contactObj, {type: 'edit'});
         	// 渲染编辑中的联系人
         	that._renderEditContact(contactObj, trEl);
     	},
     	/**
	      * 获取联系人的信息对象
	      * @param  {[type]} trEl [description]
	      * @return {[type]}      [description]
	      */
     	_getContactObj: function(trEl){
         	var
             	that = this,
             	// 获取联系人的id
             	id = DOM.attr(trEl, DATA_CONTACT_ID),
             	type = DOM.attr(trEl, TYPE),
             	// 获取关系、姓名、电话、工作单位
             	data = that._getContactData(trEl),
             	contactObj = {
                 	relationship: data[0],
                 	name: data[1],
                 	mobile: data[2],
                 	company: data[3],
                 	id: id
             	};

         	return contactObj;
     	},
     	/**
	      * 获取联系人的类型（家庭联系人、其他联系人）
	      * @param  {[type]} e [description]
	      * @return {[type]}   [description]
	      */
     	_getRelationType: function(e){
         	var
             	that = this,
             	tbodyEl = DOM.parent(e, 'tbody'),
             	idStr = DOM.attr(tbodyEl, 'id');

         	if(idStr == FAMILY_TABLE){
             	that.relationshipType = 0;
         	}else{
             	that.relationshipType = 1;
         	}
     	},
     	/**
	      * 渲染联系人模板
	      * @param  {[type]} obj [description]
	      * @param  {[type]} tr  [description]
	      * @return {[type]}     [description]
	      */
     	_renderEditContact: function(obj, tr){
         	var
             	that = this,
             	// 编辑模板
             	renderTplHtml = DOM.html(el.addContact),
             	renderTpl = Juicer(renderTplHtml, {contact: obj}),
             	renderEl = DOM.create(renderTpl);

         	DOM.insertBefore(renderEl, tr);
         	DOM.hide(tr);
            that.core.formValid.refresh();
     	},
     	/**
	      * 获取联系人的信息
	      * @param  {[type]} tr [description]
	      * @return {[type]}    [description]
	      */
     	_getContactData: function(tr){
         	var
             	that = this,
             	tds = query('td', tr),
             	value = '',
             	str = '',
             	contactObj = [];
         	S.each(tds, function(td, index){
             	if(index >= 1 && index <=4){
                 	inputEl = get('input', td);
                 	if(inputEl){
                     	contactObj.push(DOM.val(inputEl));
                 	}else{
                     	str = S.trim(DOM.html(td));
                     	contactObj.push(str);
                 	}
             	}
         	});
         	return contactObj;
     	},
     	/**
	      * 判断联系人是否通过验证
	      * @param  {[type]} obj [description]
	      * @return {[type]}     [description]
	      */
     	_getValidResult: function(obj){
         	if(obj.relationship && obj.name && obj.mobile && obj.company){
             	return true;
         	}else{
             	return false;
         	}
     	},
     	/**
	      * 发送修改后的联系人
	      * @param  {[type]} data [description]
	      * @param  {[type]} trEl [description]
	      * @return {[type]}      [description]
	      */
     	_sendEditContact: function(data, trEl){
         	var
             	that = this,
             	userIdEl = get(el.userIdEl),
             	userId = DOM.val(userIdEl);
         	S.mix(data, {
             	relationshipType: that.relationshipType,
             	userId: userId
         	});
         	MemberIO.edit(data, function(code, errMsg){
             	if(code){
                 	Dialog.alert(ERROR_TIP[2]);
                 	// 为了帮助渲染编辑之后的数据正确
                 	S.mix(data, {
                     	type: 'edit'
                 	});
                	that._renderContact(data, trEl);
             	}else{
                 	Dialog.alert(errMsg);
             	}
         	});
     	},
     	/** 渲染编辑完后的联系人信息
	      * @param  {[type]} obj [description]
	      * @param  {[type]} tr  [description]
	      * @return {[type]}     [description]
	      */
     	_renderContact: function(obj, tr){
         	var
             	that = this,
             	// 显示模板
             	renderTplHtml = DOM.html(el.renderTpl),
                renderTpl = Juicer(renderTplHtml, {contact: obj}),
             	renderEl = DOM.create(renderTpl);
         	DOM.insertAfter(renderEl, tr);
         	if(obj.type == 'edit'){
            	nextTrEl = DOM.next(tr);
             	lastTrEl = DOM.next(nextTrEl);
             	DOM.remove(lastTrEl);
         	}
         	DOM.remove(tr);
         	that.core.formValid.refresh();
     	},
     	/**
	      * 获取未通过验证的表单焦点
	      * @param  {[type]} trEl [description]
	      * @return {[type]}      [description]
	      */
     	_getFocus: function(){
         	var
             	relationEl = get(el.contactRelation, 'tr'),
             	nameEl = get(el.contactName, 'tr'),
             	phoneEl = get(el.contactPhone, 'tr'),
             	workEl = get(el.contactWork, 'tr');
         	if(DOM.val(relationEl) == ''){
             	relationEl.focus();
         	}else if(DOM.val(nameEl) == ''){
             	nameEl.focus();
         	}else if(DOM.val(phoneEl) == ''){
             	phoneEl.focus();
         	}else if(DOM.val(workEl) == ''){
                workEl.focus();
            }
     	}
    });
    return Contact;
},{
    requires:[
        'edit/core'
    ]
});
/**
 * 验证、错误提示
 * @param  {[type]} S      [description]
 * @param  {[type]} Source [description]
 * @return {[type]}        [description]
 */
KISSY.add('edit/core', function(S, Source){
    var
        DOM = S.DOM, get = DOM.get, query = DOM.query,
        on = S.Event.on, delegate = S.Event.delegate,
        $ = S.all, 
        Defender = PW.mod.Defender.client,
        Dialog = PW.widget.Dialog,
        MemberIO = PW.io.Member,
        Juicer = PW.mod.Juicer,
        el = {
            //会员身份审核表单
            editForm:'.J_editForm',
            //提交审核按钮
            submitBtn:'.J_submitBtn',
            // 错误提示
            showTip: '.showErrInp',
            // 联系人的关系
         	contactRelation: '.J_contactRelation',
         	// 联系人姓名
         	contactName: '.J_contactName',
         	// 联系人电话
         	contactPhone: '.J_contactPhone',
         	// 联系人工作单位
         	contactWork: '.J_contactWork',
            // 区域
            regionEl: '.J_region',
            // 学校
            schoolEl: '.J_school',
            // 保存按钮
            saveTrigger: '.J_save',
            // 学校/单位地址
            sAddressInp: '.J_schoolOrDepartmentAddress',
            // 宿舍/现住地址
            dAddressInp: '.J_dormitoryOrNowAddress',
            // 家庭联系人表格
            familyTemp: '#J_familyTemplate',
            // 其他联系人表格
            otherTemp: '#J_otherTemplate'
        },
        BTN_KEY = 'btn',
     	ERROR_TIP = ['操作联系人失败：已存在编辑项，请保存后再操作！', 
                    '保存成功！', 
                    '修改成功！', 
                    '删除成功！',
                    '请至少添加一项家庭联系人和其他联系人信息！',
                    '请至少添加一项家庭联系人！',
                    '请至少添加一项其他联系人！',
                    '请完善未填信息！'];

    function Core(param){
        this.source = new Source(param);
        this.submitBtn = DOM.data(el.submitBtn, BTN_KEY);
        this._init();
    }

    S.augment(Core, {
        _init: function(){
            this._showErrTip();
            this._validHandler();
            this._buildEvtHandle();
        },
        _buildEvtHandle: function(){
            var
                that = this;
            // 整体表单提交
            that.submitBtn.on('loading', function(e){
             	if(that._isEdit()){
                 	that._submitInfo();
             	}else{
                 that.submitBtn.reset();
             	}
            });
        },
        /**
         * 错误提示
         * @return {[type]} [description]
         */
        _showErrTip: function(){
            var
                showTipEl = get(el.showTip,el.editForm),
                showTip = DOM.val(showTipEl);
            
            if(showTip){
                Dialog.alert(showTip);
            }
        },
        /**
         * 为表单添加验证条件
         * @return {[type]} [description]
         */
        _validHandler: function(){
            var
                that = this;

            that.formValid = Defender(el.editForm, {
                theme:'inline',
                items:[
                    // 关系验证
                    {
                        queryName:el.contactRelation,
                        pattern: function(input,shell,form){
                            return !(this.test('isNull',DOM.val(input)));
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    },
                    // 姓名验证
                    {
                        queryName:el.contactName,
                        pattern: function(input,shell,form){
                            return !(this.test('isNull',DOM.val(input)));
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    },
                    // 电话验证
                    {
                        queryName:el.contactPhone,
                        pattern: function(input,shell,form){
                            return (/^[1]{1}[34578]{1}[0-9]{9}$/.test(DOM.val(input)))&&!(this.test('isNull',DOM.val(input)));
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    },
                    // 工作单位验证
                    {
                        queryName:el.contactWork,
                        pattern: function(input,shell,form){
                            return !(this.test('isNull',DOM.val(input)));
                        },
                        showEvent:'focus',
                        vldEvent:'keyup',
                        showTip:false
                    }
                    ,
                    //地址验证
                    {
                        queryName:el.sAddressInp,
                        pattern: function(input,shell,form){
                            return that._validAddress(input);
                        },
                        tip: '请“学校地址、宿舍地址”至少填写一项|地址不能为空',
                        showEvent:'focus',
                        vldEvent:'keyup'
                    },
                    //地址验证
                    {
                        queryName:el.dAddressInp,
                        pattern: function(input,shell,form){
                            return that._validAddress(input);
                        },
                        tip: '请“学校地址、宿舍地址”至少填写一项|地址不能为空',
                        showEvent:'focus',
                        vldEvent:'keyup'
                    }
                ] 
            });
        },
        /**
         * 验证联系人每个至少要填写一人
         * @return {[type]} [description]
         */
        _validContact: function(){
            var 
                that = this,
                familyContactEl = query('tr', el.familyTemp),
                otherContactEl = query('tr', el.otherTemp);
            if(familyContactEl.length != 0  && otherContactEl.length != 0){
                return {
                    hasContact: true
                };
            }else{
                if(familyContactEl.length == 0 && otherContactEl.length != 0){
                    return {
                        hasContact: false,
                        errTip: 5
                    };
                }else if(otherContactEl.length == 0 && familyContactEl.length != 0){
                    return {
                        hasContact: false,
                        errTip: 6
                    };
                }else if(familyContactEl.length == 0 && otherContactEl.length == 0){
                    return {
                        hasContact: false,
                        errTip: 4
                    };
                }
            }
        },
        /**
         * 学校地址、宿舍地址至少填写一项的验证条件
         * @return {[type]} [description]
         */
        _validAddress: function(input){
            var
                that = this,
                dlength = DOM.val(el.dAddressInp).length,
                slength = DOM.val(el.sAddressInp).length;
            if(dlength == 0 && slength == 0){
                return false;
            }else{
                if(slength > 0){
                    that._operVaildStyle(el.dAddressInp);
                }else if(dlength > 0){
                    that._operVaildStyle(el.sAddressInp);
                }
                return true;
            }
        },
        /**
         * 将学校地址/单位地址、宿舍地址/现住地址中，没填写的地址验证样式去除，避免用户疑虑
         * @param  {[type]} input [description]
         * @return {[type]}       [description]
         */
        _operVaildStyle: function(input){
             var
                addressTipEl = DOM.next(input, 'span'),
                pAddressTipEl = DOM.parent(addressTipEl, '.controls');
            DOM.css($(pAddressTipEl),'height', '32px');
            DOM.empty(addressTipEl);
            DOM.removeClass(input, '.error-field');
        },
        /**
	      * 提交大表单
	      * @return {[type]} [description]
	      */
     	_submitInfo: function(){
            var
                that = this,
                form = get(el.editForm),
                regionEl = get(el.regionEl, el.editForm),
                schoolEl = get(el.schoolEl, el.editForm),
                schoolEnlight,
                regionEnlight,
                // 联系人是否为空
                resultObj = that._validContact(),
                // 联系人填写情况
                resultTip;

            // 判断学校或区域是否为空
            that._hasSchoolOrRegion();
            
            that.formValid.validAll(function(rs){
                if(rs){
                    if(resultObj.hasContact){
                        schoolEnlight = $(el.schoolEl).one('option:selected').attr('data-enlight');
                        regionEnlight = $(el.regionEl).one('option:selected').attr('data-enlight');
                        if(that.source.original == 0){
                            DOM.attr(regionEl,'disabled', 'disabled');
                            if(schoolEnlight == 1 && regionEnlight == 1){
                                form.submit();
                            }else if((schoolEnlight == 1 && regionEnlight == 0) || (schoolEnlight == 0 && regionEnlight == 0)){
                                that._tipEnlight(1);
                            }else if(schoolEnlight == 0 && regionEnlight == 1){
                                that._tipEnlight(0);
                            }
                        }else if(that.source.original == 1){
                            if(regionEnlight == 1){
                                DOM.attr(el.schoolEl, 'name', '');
                                form.submit();
                            }else if(regionEnlight == 0){
                                that._tipEnlight(1);
                            }
                        }
                    }else{
                        resultTip = resultObj.errTip;
                        Dialog.alert(ERROR_TIP[resultTip]);
                        that.submitBtn.reset();
                        return false;
                    }
                }else{
                    that._focusError();
                    that.submitBtn.reset();
                }
            });
        },
        /**
         * 定位错误域位置
         * @return {[type]} [description]
         */
        _focusError: function(){
            var 
                that = this,
                errorEl = get('.error-field', el.editForm);
            Dialog.alert(ERROR_TIP[7], function(){
                that._focusErrorInp(errorEl);
            });
        },
        /**
         * 显示错误信息操作
         * @param  {[type]} errorEl [description]
         * @return {[type]}         [description]
         */
        _focusErrorInp: function(errorEl){
            var 
                that = this,
                tabContentEl = DOM.parent(errorEl, '.tab-content'),
                indexTab = DOM.index(tabContentEl),
                activeTabNavEl = get('.active', '.tab-nav'),
                tabLisEl = query('li', '.tab-nav');
            DOM.removeClass(activeTabNavEl, 'active');
            DOM.addClass(tabLisEl[indexTab], 'active');
            DOM.hide('.tab-content');
            DOM.show(tabContentEl);
            errorEl.focus();
        },
        /**
         * 判断学校或区域是否为空
         * @return {Boolean} [description]
         */
        _hasSchoolOrRegion: function(){
            if($(el.schoolEl).one('option:selected') == null || $(el.regionEl).one('option:selected') == null){
                Dialog.alert('请添加学校或区域信息!');
                that.submitBtn.reset();
                return false;
            }
        },
        /**
         * 提示区域已停用(传1)还是学校已停用(传0)
         * @param  {[type]} val [description]
         * @return {[type]}     [description]
         */
        _tipEnlight: function(val){
            var
                that = this,
                regionEl = get(el.regionEl, el.editForm),
                schoolEl = get(el.schoolEl, el.editForm);

            if(val == 1){
                Dialog.alert('区域已停用，请重新选择!', function(){
                    schoolEl.focus();
                    DOM.addClass(regionEl, 'focus');
                    DOM.addClass(schoolEl, 'focus');
                });
                DOM.removeAttr(regionEl,'disabled');
                that.submitBtn.reset();
            }else if(val == 0){
                 Dialog.alert('学校已停用，请重新选择!', function(){
                    schoolEl.focus();
                    DOM.addClass(schoolEl, 'focus');
                });
                DOM.removeAttr(regionEl,'disabled');
                that.submitBtn.reset();
            }
        },
         /**
        }
       	* 判断是否存在编辑项
       	* @return {Boolean} [description]
       	*/
      	_isEdit: function(){
            var
                saveContactEl = S.one(el.saveTrigger);
            if(saveContactEl){
                Dialog.alert(ERROR_TIP[0]);
                return false;
            }else{
                return true;
            }
        }
    });
    return Core;
},{
    requires:[
        'edit/source',
        'io/member',
        'widget/dialog',
        'mod/defender',
        'widget/btn',
        'mod/juicer'
    ]
});
