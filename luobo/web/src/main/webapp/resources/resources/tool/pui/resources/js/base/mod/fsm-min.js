KISSY.add("mod/fsm",function(a){var b=function(){};a.augment(b,{atf:{inactive:{}},currentState:"inactive",unexpetedEvent:"inactive",undefinedState:"inactive",trace:false,setATF:function(c){if(a.isObject(c)){this.atf=c;}},setTrace:function(c){this.trace=!!c||false;},drive:function(c){if(a.isString(c)){this.handleEvent({type:c});}this.handleEvent(c);},handleEvent:function(c){var e=this.atf[this.currentState][c.type],d;if(!e){a.log("未知事件"+c.type);e=this.unexpetedEvent;}d=e.call(this,c);if(!d){a.log("没有下一个状态");a.log(c.type);d=this.currentState;}if(!this.atf[d]){a.log("状态机无法判断下一个状态");d=this.undefinedState(c,d);}if(this.trace){a.log(this.currentState+"----["+c.type+"]--->"+d);}this.currentState=d;},unexpetedEvent:function(c){return this.initState;},undefinedState:function(){return this.initState;},doActionTransition:function(c,e,d){return this.actionTransitionFunctions[c][e].call(this,d);}});PW.namespace("mod.FSM");a.FSM=PW.mod.FSM=function(){return new b();};return b;});