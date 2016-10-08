
//
/**
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function TransitionTextMouseListener(transition, wrapper) {
    this.transition = transition;
    this.wrapper = wrapper;
}
TransitionTextMouseListener.prototype = new MouseListener();
TransitionTextMouseListener.prototype.onDblClick = function (e) {
    var editable = this.wrapper.getModel().isEditable();
	if(!editable){
	    return false;
	}

    var state = this.wrapper.getStateMonitor().getState();
    if (state != StateMonitor.SELECT) {
        return;
    }	
    this.wrapper.getModel().clearSelectedMetaNodeModels();

	var xiorkFlowModel = this.wrapper.getModel();
	var processId=xiorkFlowModel.getName();
	var tableId=xiorkFlowModel.getTableId();
	var moduleId=xiorkFlowModel.getModuleId();

	var transitionModel=this.transition.getModel();
	var transitionId=transitionModel.getID();
    var transitionText=transitionModel.getText();
 
    if(!xiorkFlowModel.judgeCanEditTransition(transitionModel.getAttribute("whir:tempsetforbidmodify"))){
	    Toolkit.whir_alert(workflowMessage_js.cannotsetzyezflow,function(){});
		return ;
	}

	var fromMetaNodeModel=transitionModel.getFromMetaNodeModel();
	//如果是从exclusivegateway 或者是 inclusivegateway出来的transtion需要设置条件

	if(fromMetaNodeModel.type==MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE||fromMetaNodeModel.type==MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE){//(fromMetaNodeModel.type==MetaNodeModel.TYPE_FORK_NODE||fromMetaNodeModel.type==MetaNodeModel.TYPE_FLOW_NODE){
	    //var url=CommonJSResource.rootPath+"/ActivityAction.do?action=transitionRestrictionLoad&transitionId="+transitionId+"&processId="+processId+"&tableId="+tableId+"&moduleId="+moduleId;
        //url+="&isDesigner=1&transitionText="+transitionText;
	    //alert(url);
	    //http://localhost:7001/CommonJSResource.rootPath/ActivityAction.do?action=modify&activityId=97834600&processId=97834528&tableId=97829949&moduleId=1
	  	//window.open(encodeURI(url),'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=900,height=800');    
		//var url=CommonJSResource.rootPath+"/ezflow/workFlowDesigner/whirFlow/jsp/condition.jsp?id="+transitionModel.getID();
		var url=CommonJSResource.rootPath+"/ezflowprocess!setCondition.action?id="+transitionModel.getID()+"&formCode="+
	    xiorkFlowModel.getAttribute("whir:formKey")+"&moduleId="+moduleId+"&formType="+xiorkFlowModel.getAttribute("whir:formType");
        //Toolkit.popup({id:'setExpressionDialog',title: '表达式设置',fixed: true, width:'750px',height:'400px',padding: 0,drag: true, resize: true,lock: true,content: 'url:'+url});	
		 
	    Toolkit.openWin({url:url,width:'800',height:'520',winName:'setExpressionDialog'});
		 //window.open(encodeURI(url),'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=900,height=800');    
	}else{
	   this.transition.startEdit();
	}
};


TransitionTextMouseListener.prototype.onMouseOver = function (e) {
	var editable = this.wrapper.getModel().isEditable();
	if(!editable){ 
		var transitionModel=this.transition.getModel();
		var fromMetaNodeModel=transitionModel.getFromMetaNodeModel();
	    if(fromMetaNodeModel.type==MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE||fromMetaNodeModel.type==MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE){ 
            var point = Toolkit.getContainerCoord(e, this.wrapper.getViewer());
			var   expressionDisplay=transitionModel.getConditionExpressionDisplay();
			if(expressionDisplay==null){
			   expressionDisplay=""; 
			}
	        Toolkit.tip_show(expressionDisplay,point.getX()+"px",point.getY()+"px");
		}
	}
};
TransitionTextMouseListener.prototype.onMouseOut = function (e) {
	var editable = this.wrapper.getModel().isEditable();
	if(!editable){
		//
		var transitionModel=this.transition.getModel();
		var fromMetaNodeModel=transitionModel.getFromMetaNodeModel();
	    if(fromMetaNodeModel.type==MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE||fromMetaNodeModel.type==MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE){ 
            Toolkit.tip_close();
		}
	}
};
TransitionTextMouseListener.prototype.showTip = function (e) {

};

 
TransitionTextMouseListener.prototype.onClick = function (e) {
	var editable = this.wrapper.getModel().isEditable();
	if(!editable){

		var transitionModel=this.transition.getModel();
		var fromMetaNodeModel=transitionModel.getFromMetaNodeModel();
	    if(fromMetaNodeModel.type==MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE||fromMetaNodeModel.type==MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE){ 
            var point = Toolkit.getContainerCoord(e, this.wrapper.getViewer());
			var   expressionDisplay=transitionModel.getConditionExpressionDisplay();
			if(expressionDisplay==null){
			   expressionDisplay=""; 
			}
	        Toolkit.tip_show(expressionDisplay,point.getX()+"px",point.getY()+"px" ,"tip_show");
		} 
	}else{
	    return false;
	}
};
