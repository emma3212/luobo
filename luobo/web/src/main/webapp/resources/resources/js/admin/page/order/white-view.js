/*-----------------------------------------------------------------------------
* @Description: 白条订单详情管理(还款信息页) 
* @Version: 	V1.0.0
* @author: 		wangjing(1284663246@qq.com)
* @date			2015.01.22
* ==NOTES:=============================================
* v1.0.0(2015.01.22):
* 	初始生成 
* ---------------------------------------------------------------------------*/
KISSY.add('page/order/white-view', function (S, Core) {
    PW.namespace('page.order');
    PW.page.order.WhitebarView = function(){
    	return new Core();
    }
},{
    requires:[
        'list/core'
    ]
});
KISSY.add('list/core', function(S){
	var
		DOM = S.DOM, get = DOM.get, query = DOM.query, $ = S.all,
		on = S.Event.on, delegate = S.Event.delegate, Juicer = PW.mod.Juicer,
		Defender = PW.mod.Defender.client,
		Dialog = PW.widget.Dialog,
		WhitebarIO = PW.io.Whitebar,
		el = {
			//form
			form: '.J_form',
			//商品id
			orderId: '.J_orderId',
			//table的tbody
			template:'#J_template',
			//实际还款时间
			realTimeEl: '.J_realTime',
			//编辑触发器
			editTrigger: '.J_edit',
			//保存触发器
			saveTrigger: '.J_save',
			//取消触发器
			cancelTrigger: '.J_cancel',
			//备注触发器
			tipTrigger: '.J_tip',
			//一键还款
			repayTogether: '.J_repayTogether',
			//备注存储器
			tipHolder: '.J_tipVal',
			//提示信息
			tipContent: '.J_tipContent',
			//备注form
			tipForm: '.J_tipForm',
			//编辑模板
			editTpl: '#editTpl',
			//保存模板
			saveTpl: '#saveTpl'
		},
		//警告样式
		WARNING_CLASS = 'error-tip',
		//启用停用显示方式
		//tr属性
		DATA_ID = 'data-repay-id',
		CONTENT = '<form class="J_tipForm"><textarea  class="w500 form-control J_tipContent" style="height:100px;" data-valid-rule="length(-1,201)" name=""></textarea></form>',
		SUCCESS_TIP = ['修改还款信息成功！', '保存备注成功！'],
		FAIL_TIP = ['操作失败：请先保存当前操作！'],
		//一键还款提示信息
		ONEPRESS_REPAY_TIP = '进行一键还款后，当前订单下所有未还款状态的还款条目将变成已还款，并且实际还款金额和已还款一致。点击‘确定’进行该操作，点击‘取消’取消该操作。';
	var
		Core = function(){
			//提示验证对象
			this.defenderTipObj;
			//编辑验证对象
			this.defenderObj = Defender(el.form, {showTip: false});
			this._init();
		}
	S.augment(Core, {
		_init: function(){
			this._addEvt();
		},
		_addEvt: function(){
			var 
				that = this;
			delegate(el.template, 'click', el.tipTrigger, that._openTipDlg, that);
			delegate(el.template, 'click', el.editTrigger,  that._editHandler, that);
			delegate(el.template, 'click', el.saveTrigger, that._saveHandler, that);
			delegate(el.template, 'click', el.cancelTrigger, that._cancelHandler, that);
			on(el.repayTogether, 'click', that._repayTogetherHanlder, that);
		},
		/**
		 * 编辑还款信息
		 * @return {[type]} [description]
		 */
		_editHandler: function(e){
			var
				that = this,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				data = that._getRenderData(tr);
			if(!that._isEdit()){
				that._renderTpl(data, tr);
				that._initCalender();
				that.defenderObj.refresh();
			}else{
				Dialog.alert(FAIL_TIP[0]);
			}
		},
		/**
		 * 保存还款信息操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_saveHandler: function(e){
			var 
				that = this,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				data = DOM.serialize(el.form);
			S.mix(data, {id: id});
			that.defenderObj.validAll(function(rs){
				WhitebarIO.saveReturn(data, function(code, errMsg){
					if(code){
						data = that._resetSaveData(data, tr);
						that._renderSaveTpl(data, tr);
						Dialog.alert(SUCCESS_TIP[0]);
					}
				});
			});
		},
		/**
		 * 取消编辑操作
		 * @param  {[type]} e [description]
		 * @return {[type]}   [description]
		 */
		_cancelHandler: function(e){
			var
				that = this,
				target = e.target,
				tr = DOM.parent(target, 'tr'),
				nextEl = DOM.next(tr);
			that._showTr(nextEl);
			DOM.remove(tr);
		},
		/**
		 * 打开修改备注弹出框
		 * @return {[type]} [description]
		 */
		_openTipDlg: function(e){
			var
				that = this,
				target = e.target,
				tipHolderEl = DOM.next(target),
				tip = DOM.val(tipHolderEl);
			Dialog.alert(CONTENT,function(){},{footer: 
				{
					btns:[{
                    text: '保存',
                    clickHandler: function(e,me){
                        that.defenderTipObj.validAll(function(rs){
                            if(rs){
                            	that._saveTip(target, tipHolderEl);
                                me.close();
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
                    that.defenderTipObj = Defender(el.tipForm, {showTip:false});
                    DOM.val(el.tipContent, tip);
                },
                title: "还款备注（200字以内）：",
                width: 600
            });
		},
		/**
		 * 保存备注
		 * @param  {[type]} target      [description]
		 * @param  {[type]} tipHolderEl [description]
		 * @return {[type]}             [description]
		 */
		_saveTip: function(target, tipHolderEl){
			var
				that = this,
				opts = that.opts,
				tr = DOM.parent(target, 'tr'),
				id = DOM.attr(tr, DATA_ID),
				newContent = DOM.val(el.tipContent);
			WhitebarIO.viewTip({id:id, comment:newContent},function(code, errMsg){
                if(code){
                    DOM.val(tipHolderEl, newContent);
                    Dialog.alert(SUCCESS_TIP[1]);
                }else{
                    Dialog.alert(errMsg);
                }
            });
		},
		/**
		 * 一键还款操作
		 * @return {[type]} [description]
		 */
		_repayTogetherHanlder: function(){
			var
				that = this,
				id = DOM.val(el.orderId);
			Dialog.confirm(ONEPRESS_REPAY_TIP, function(){
				WhitebarIO.repayPress({id: id}, function(code, errMsg){
					if(code){
						window.location.reload();
					}else{
						this.close();
						Dialog.alert(errMsg);
					}
				});
			});
		},
		/**
		 * 获取渲染数据
		 * @param  {[type]} trObj [description]
		 * @param  {[type]} type  [description]
		 * @return {[type]}       [description]
		 */
		_getRenderData: function(trObj){
			var
				id = DOM.attr(trObj, DATA_ID),
				tds = query('td', trObj),
				tip = $(trObj,el.tipHolder),
				datas = [], data = {};

			if(tds){
				S.each(tds, function(td){
					if(DOM.hasClass(td, 'payment')){
					 	datas.push(1);
					 	return true;
					}else if(DOM.hasClass(td, 'unpayment')){
						datas.push(0);
						return true;
					}
					datas.push(DOM.html(td));
				});
			}
			//如果为未还款状态，实际还款金额为计划还款金额
			if(datas[4] == 0) datas[1] = datas[0];
			
			data = {
				id: id,
				planPrice: datas[0],
				actualRepayMoney: datas[1],
				lastTime: datas[2],
				actualRepayDate: datas[3],
				status: datas[4]
			};
			return data;
		},
		/**
		 * 渲染修改模板
		 * 当存在trObj时，替换当前记录，当不存在trObj时，在table第一行添加空记录
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_renderTpl: function(data, trObj){
			var
				that = this,
				html = Juicer(el.editTpl, data),
				htmlEl = DOM.create(html);

			DOM.insertBefore(htmlEl, trObj);
			that._hideTr(trObj);
		},
		/**
		 * 渲染保存模板
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_renderSaveTpl: function(data, trObj){
			var
				that = this,
				nextEl = DOM.next(trObj),
				saveHtml, saveEl;
			saveHtml = Juicer(el.saveTpl, data);
			saveEl = DOM.create(saveHtml);
			DOM.replace(trObj, saveEl);
			that._addExtraHandler(saveEl);
			DOM.remove(nextEl);
			that._judgeTime(data, saveEl);
		},
		/**
		 * 重置保存数据
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_resetSaveData: function(data, trObj){
			var
				tds = query('td', trObj),
				datas = [], mixData = {};
			if(tds){
				S.each(tds, function(td){
					datas.push(DOM.html(td));
				});
			}
			
			mixData = S.merge(data, {
				planPrice: datas[0],
				lastTime: datas[2]
			});

			return mixData;
		},
		/**
		 * 是否已经编辑
		 * 已经存在编辑返回 true， 不存在编辑返回false
		 * @return {Boolean} [description]
		 */
		_isEdit: function(){
			var
				that = this,
				saveBtns = $(el.saveTrigger, el.template);
			if(saveBtns.length >= 1){
				return true;
			}else{
				return false;
			}
		},
		/**
		 * 初始化日历
		 * @return {[type]} [description]
		 */
		_initCalender: function(){
			PW.mod.Calendar.client({
				renderTo: el.realTimeEl,
				select:{
				    showTime: true,
				    dateFmt: 'YYYY-MM-DD'
				}
			});
		},
		/**
		 * 添加保存后额外操作
		 * 将原td中的操作按钮等元件复制到新信息行中
		 * @param {[type]} trObj [description]
		 */
		_addExtraHandler: function(trObj){
			var
				that = this,
				nextEl = DOM.next(trObj),
				handlerEl = DOM.last(nextEl),
				newHanlderEl = DOM.clone(handlerEl, true, true);
			DOM.append(newHanlderEl, trObj);
		},
		/**
		 * 判断时间是否合法
		 * @param  {[type]} data  [description]
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_judgeTime: function(data, trObj){
			var realTime = data.actualRepayDate.split("-"),
				lastTime = data.lastTime.split("-"),
				now = new Date(),
				year = now.getFullYear(),
				month = now.getMonth()+1,
				day = now.getDate();
            if(data.status == 1 && (Date.parse(lastTime[0]+"/"+lastTime[1]+"/"+lastTime[2]) < Date.parse(realTime[0]+"/"+realTime[1]+"/"+realTime[2]))){  
                DOM.addClass(trObj, WARNING_CLASS);      
            }else if(data.status == 0 && (Date.parse(lastTime[0]+"/"+lastTime[1]+"/"+lastTime[2]) < Date.parse(year+"/" + month+"/"+day))){
            	DOM.addClass(trObj, WARNING_CLASS);
            }
		},
		/**
		 * 隐藏记录
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_hideTr: function(trObj){
			DOM.hide(trObj);
		},
		/**
		 * 显示记录
		 * @param  {[type]} trObj [description]
		 * @return {[type]}       [description]
		 */
		_showTr: function(trObj){
			DOM.show(trObj);
		}
	});
	return Core;
},{
	requires:[
				'mod/ext',
				'mod/pagination',
				'io/whitebar',
				'widget/dialog',
				'mod/calendar',
				'mod/juicer',
				'mod/defender'
			]
});