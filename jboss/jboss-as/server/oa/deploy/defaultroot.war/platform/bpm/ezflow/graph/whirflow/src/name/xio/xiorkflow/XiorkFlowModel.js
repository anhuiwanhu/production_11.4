
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function XiorkFlowModel() {
    this.base = Observable;
    this.base();
    //this.resetID();
    this.setName(null);

    //
    this.metaNodeModels = new Array();
    this.transitionModels = new Array();

    //
    this.selectedMetaNodeModels = new Array();
    this.selectedTransitionModels = new Array();
    this.initMetaNodeIds="";
	this.initTransitionIds="";
	this.isTempSet=0;
	this.commandHistory = new List();
	this.curcommandIndex = 0;
    //
    this.setEnable(true);
    this.setEditable(true);


	//属性
	this.attributes = new Map();
	//扩展属性 存储ExtensionElement
	this.extensionElements = new List();
	//ID管理 key:value=类型 当前id号
	this.ids = new Map();
}
XiorkFlowModel.prototype = new Observable();

//新增加节点
XiorkFlowModel.prototype.newMetaNodeModel = function (metaNodeModel) {
	this.addMetaNodeModel(metaNodeModel);
	var command = new AddMetaNodeModelCommand(this,metaNodeModel);
	this.executeCommand(command);
};

//
XiorkFlowModel.prototype.addMetaNodeModel = function (metaNodeModel) {
	//null
    if (metaNodeModel == null) {
        return;
    }
    //exist
    if (this.metaNodeModels.indexOf(metaNodeModel) > -1) {
        return;
    }

	//
    var id = metaNodeModel.getID();
    if (id) {
		//开始活动  开始活动里默认设置里id 其中前缀是随机数 取这个随机数 
		if(metaNodeModel.type== MetaNodeModel.TYPE_START_NODE){
			var subPrefix =id.replace("startevent1","");  
			if(subPrefix==null||subPrefix==""){
                subPrefix="sub_";
			}     
			this.setSubPrefix(subPrefix);
		}
        //this.updateID(id);
		//如果有ID，不操作
    } else {
        metaNodeModel.setID(this.nextID(metaNodeModel.type));
		//重新设置名称
		var curid =  this.ids.get(metaNodeModel.type);


		var aname = metaNodeModel.getText() + curid;

		var isexist = function(aname){
			var nms = xiorkFlow.xiorkFlowWrapper.getModel().metaNodeModels;
			for( i = 0; i < nms.length; i++) {
				if(nms[i].getID() != metaNodeModel.getID()) {
					if( nms[i].getText() == aname ){
						
						return true;
					}
					
				}
			}
			return false;
		};
		while( isexist( aname) ){
			curid++;
			aname = metaNodeModel.getText() + curid;
		}

		metaNodeModel.setText(aname);

    }

    //
    this.metaNodeModels.add(metaNodeModel);
    var args = [XiorkFlowModel.META_NODE_MODEL_ADD, metaNodeModel];
    this.notifyObservers(args);
};
XiorkFlowModel.prototype.removeMetaNodeModel = function (metaNodeModel) {
	//null
    if (metaNodeModel == null) {
        return;
    }

	//开始活动 结束活动 不能删
	//if(metaNodeModel.type== MetaNodeModel.TYPE_START_NODE){
		//alert("开始活动不能删除");
		//return;
	//}
	//if(metaNodeModel.type==MetaNodeModel.TYPE_END_NODE){
		//alert("结束活动不能删除");
		//return;
	//}
    
    //
    //var fromTransitionModels = metaNodeModel.getFroms();
   //for (var i = 0; i < fromTransitionModels.size(); i++) {
       // this.removeTransitionModel(fromTransitionModels.get(i));
    //}
   // var toTransitionModels = metaNodeModel.getTos();
    //for (var i = 0; i < toTransitionModels.size(); i++) {
       // this.removeTransitionModel(toTransitionModels.get(i));
    //}

    //
    this.metaNodeModels.remove(metaNodeModel);
    this.removeSelectedMetaNodeModel(metaNodeModel);
	//删除数据库中的活动
	//this.deleteActivity_k(metaNodeModel);

    //
    var args = [XiorkFlowModel.META_NODE_MODEL_REMOVE, metaNodeModel];
    this.notifyObservers(args);
};
XiorkFlowModel.prototype.getMetaNodeModels = function () {
    return this.metaNodeModels;
};
//外部新增使用该方法
XiorkFlowModel.prototype.newTransitionModel = function (transitionModel) {
	this.addTransitionModel(transitionModel);
	var command = new AddTransitionCommand(this,transitionModel);
	this.executeCommand(command);
};
//
XiorkFlowModel.prototype.addTransitionModel = function (transitionModel) {
	//null
    if (transitionModel == null) {
        return;
    }
    //exist
    if (this.transitionModels.indexOf(transitionModel) > -1) {
        return;
    }

    //
    var id = transitionModel.getID();
    if (id) {
        //this.updateID(id);
    } else {
        transitionModel.setID(this.nextID("TRANSITIONMODEL"));
    }

    //
    this.transitionModels.add(transitionModel);
    var args = [XiorkFlowModel.TRANSITION_MODEL_ADD, transitionModel];
    this.notifyObservers(args);
};
XiorkFlowModel.prototype.removeTransitionModel = function (transitionModel) {
	//null
    if (transitionModel == null) {
        return;
    }

    //
    this.transitionModels.remove(transitionModel);
    this.removeSelectedTransitionModel(transitionModel);
	//删除数据库中的连线
	//this.deleteTransition_k(transitionModel);
    var args = [XiorkFlowModel.TRANSITION_MODEL_REMOVE, transitionModel];
    this.notifyObservers(args);
};
XiorkFlowModel.prototype.getTransitionModels = function () {
    return this.transitionModels;
};

//
XiorkFlowModel.prototype.addSelectedMetaNodeModel = function (metaNodeModel) {
	//null
    if (metaNodeModel == null) {
        return;
    }
    //exist
    if (this.selectedMetaNodeModels.indexOf(metaNodeModel) > -1) {
        return;
    }
    metaNodeModel.setSelected(true);
    this.selectedMetaNodeModels.add(metaNodeModel);
};
XiorkFlowModel.prototype.removeSelectedMetaNodeModel = function (metaNodeModel) {
	//null
    if (metaNodeModel == null) {
        return;
    }
    metaNodeModel.setSelected(false);
    this.selectedMetaNodeModels.remove(metaNodeModel);
};
XiorkFlowModel.prototype.getSelectedMetaNodeModels = function () {
    return this.selectedMetaNodeModels;
};

// 清除选择
XiorkFlowModel.prototype.clearSelectedMetaNodeModels = function () {
    for (var i = 0; i < this.selectedMetaNodeModels.size(); i++) {
        this.selectedMetaNodeModels.get(i).setSelected(false);
    }
    return this.selectedMetaNodeModels.clear();
};

//
XiorkFlowModel.prototype.addSelectedTransitionModel = function (transitionModel) {
	//null
    if (transitionModel == null) {
        return;
    }
    //exist
    if (this.selectedTransitionModels.indexOf(transitionModel) > -1) {
        return;
    }
    transitionModel.setSelected(true);
    this.selectedTransitionModels.add(transitionModel);
};
XiorkFlowModel.prototype.removeSelectedTransitionModel = function (transitionModel) {
	//null
    if (transitionModel == null) {
        return;
    }
    transitionModel.setSelected(false);
    this.selectedTransitionModels.remove(transitionModel);
};
XiorkFlowModel.prototype.getSelectedTransitionModels = function () {
    return this.selectedTransitionModels;
};
XiorkFlowModel.prototype.clearSelectedTransitionModels = function () {
    for (var i = 0; i < this.selectedTransitionModels.size(); i++) {
        this.selectedTransitionModels.get(i).setSelected(false);
    }
    return this.selectedTransitionModels.clear();
};

XiorkFlowModel.prototype.deleteObject = function (selectedMetaNodeModels,selectedTransitionModels) {
	if(!( selectedMetaNodeModels.size() >0 || selectedTransitionModels.size() >0)){
		//没有选择元素
		return ;
	}
	for( var i = 0;i < selectedMetaNodeModels.size(); i ++){
		var metaNodeModel = selectedMetaNodeModels.get(i);
		//开始活动 结束活动 不能删
		if(metaNodeModel.type== MetaNodeModel.TYPE_START_NODE){
			Toolkit.whir_alert("开始活动不能删除！",function(){});

			return;
		}
		if(metaNodeModel.type==MetaNodeModel.TYPE_END_NODE){
			Toolkit.whir_alert("结束活动不能删除！",function(){});
			return;
		}
	}
	var command = new DeleteCommand(this,selectedMetaNodeModels,selectedTransitionModels);
	this.executeCommand(command);
	//if(window.confirm("恢复") ){
		//command.undo();
	//}
};

XiorkFlowModel.prototype.undo = function () {
	if( this.curcommandIndex > 0 ){
		var command = this.commandHistory.get(this.curcommandIndex - 1 );
		if(command.undo() ){
			this.curcommandIndex -- ;
			
		}else{
			alert("不可撤消！");
		}
	}
	this.updateButton();
	//if( this.curcommandIndex <= 0  ){
		//this.undoButton.getModel().setEnabled(false);
	//}
};


XiorkFlowModel.prototype.redo = function (selectedMetaNodeModels,selectedTransitionModels) {
	
	if( this.curcommandIndex + 1 <= this.commandHistory.size()  ){
		var command = this.commandHistory.get(this.curcommandIndex);
		if(command.redo() ){
			this.curcommandIndex ++ ;
		}else{
			alert("不可重做！");
		}
	}
	this.updateButton();
	//if( this.curcommandIndex  >= this.commandHistory.size()  ){
		//this.redoButton.getModel().setEnabled(false);
	//}
  
};

//
XiorkFlowModel.prototype.deleteSelected = function () {
 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	if ((selectedMetaNodeModels.size() > 0) || (selectedTransitionModels.size() > 0)) {
	    for (var i = 0; i < selectedTransitionModels.size(); i++) {
			 if(!this.judgeCanEditTransition(selectedTransitionModels.get(i).getAttribute("whir:tempsetforbidmodify"))){
				 canDelete=false;
				 break;
			 }
        }

        //
        for (var i = 0; i < selectedMetaNodeModels.size(); i++) { 
			 if(!this.judgeCanEditMetaNode(selectedMetaNodeModels.get(i).getAttribute("whir:tempsetforbidmodify"))){
				 canDelete=false;
				 break;
			 }
        }
	}

	if(canDelete){
	     this.deleteObject(selectedMetaNodeModels,selectedTransitionModels);
	}else{
	     Toolkit.whir_alert(workflowMessage_js.cannotsetzyezflow,function(){});
	}

	
	return;
    if ((selectedMetaNodeModels.size() > 0) || (selectedTransitionModels.size() > 0)) {

		//删除后无法恢复，你确定删除  workflowMessage_js.includeconfirmdeleterecord+'？' ,
        if (!window.confirm(workflowMessage_js.includeconfirmdeleterecord+' ')) {
            return;
        }
	
        //
        for (var i = 0; i < selectedTransitionModels.size(); i++) {
			//如果删除的是连接线,还要去除 default属性
			if( selectedTransitionModels.get(i).getFromMetaNodeModel().getAttribute("default") == selectedTransitionModels.get(i).getID() ){
				selectedTransitionModels.get(i).getFromMetaNodeModel().removeAttribute("default");
				//alert(selectedTransitionModels.get(i).getFromMetaNodeModel().getID()+"删除default属性!");
			}
            this.removeTransitionModel(selectedTransitionModels.get(i));
        }

        //
        for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
            this.removeMetaNodeModel(selectedMetaNodeModels.get(i));
        }
    }
};


//
XiorkFlowModel.prototype.setEnable = function (enable) {
    this.enable = enable;
};
XiorkFlowModel.prototype.isEnable = function () {
    return this.enable;
};
XiorkFlowModel.prototype.setEditable = function (editable) {
    this.editable = editable;
};
XiorkFlowModel.prototype.isEditable = function () {
    return this.editable;
};

// name 就是processId
XiorkFlowModel.prototype.setName = function (name) {
    this.name = name;
};
XiorkFlowModel.prototype.getName = function () {
    return this.name;
};

//tableId
XiorkFlowModel.prototype.setTableId = function (tableId) {
    this.tableId = tableId;
};
XiorkFlowModel.prototype.getTableId = function () {
    return this.tableId;
};

//moduleId
XiorkFlowModel.prototype.setModuleId = function (moduleId) {
    this.moduleId = moduleId;
};
XiorkFlowModel.prototype.getModuleId = function () {
    return this.moduleId;
};


//新工作流增加的属性
//displayName 流程的显示名
XiorkFlowModel.prototype.setDisplayName = function (displayName) {
    this.displayName = displayName;
};
XiorkFlowModel.prototype.getDisplayName = function () {
    return this.displayName;
};

//processPackage 分类id
XiorkFlowModel.prototype.setProcessPackage  = function (processPackage ) {
    this.processPackage  = processPackage ;
};
XiorkFlowModel.prototype.getProcessPackage  = function () {
    return this.processPackage ;
};

//processRemindField 提醒字段
XiorkFlowModel.prototype.setProcessRemindField  = function (processRemindField ) {
    this.processRemindField  = processRemindField ;
};
XiorkFlowModel.prototype.getProcessRemindField  = function () {
    return this.processRemindField ;
};

//processUserScope  流程使用范围
XiorkFlowModel.prototype.setProcessUserScope   = function (processUserScope  ) {
    this.processUserScope   = processUserScope  ;
};
XiorkFlowModel.prototype.getProcessUserScope   = function () {
    return this.processUserScope  ;
};

//processNeedDossier 流程是否归档 
XiorkFlowModel.prototype.setProcessNeedDossier    = function (processNeedDossier  ) {
    this.processNeedDossier   = processNeedDossier  ;
};
XiorkFlowModel.prototype.getProcessNeedDossier   = function () {
    return this.processNeedDossier  ;
};

//processNeedPrint  流程打印
XiorkFlowModel.prototype.setProcessNeedPrint     = function (processNeedPrint   ) {
    this.processNeedPrint    = processNeedPrint   ;
};
XiorkFlowModel.prototype.getProcessNeedPrint    = function () {
    return this.processNeedPrint   ;
};

//processCommentIsNull  批示意见是否可以为空
XiorkFlowModel.prototype.setProcessCommentIsNull     = function (processCommentIsNull   ) {
    this.processCommentIsNull    = processCommentIsNull   ;
};
XiorkFlowModel.prototype.getProcessCommentIsNull    = function () {
    return this.processCommentIsNull   ;
};

//nodeWriteField 可写字段   
XiorkFlowModel.prototype.setNodeWriteField     = function (nodeWriteField   ) {
    this.nodeWriteField    = nodeWriteField   ;
};
XiorkFlowModel.prototype.getNodeWriteField    = function () {
    return this.nodeWriteField   ;
};

//formKey  表单id 或者 表单路径
XiorkFlowModel.prototype.setFormKey     = function (formKey   ) {
    this.formKey    = formKey   ;
};
XiorkFlowModel.prototype.getFormKey    = function () {
    return this.formKey   ;
};

//流程描述
XiorkFlowModel.prototype.setDocumentation  = function (documentation   ) {
    this.documentation    = documentation   ;
};

XiorkFlowModel.prototype.getDocumentation  = function () {
    return this.documentation   ;
};


//扩展属性对象
//使用一个List 中放置Map的方式

//设置扩展属性
XiorkFlowModel.prototype.addWhirExtension     = function (whirExtension   ) {
    this.extensionElements.add(whirExtension);
};

//根据扩展属性名称获取扩展属性
XiorkFlowModel.prototype.getWhirExtensionByName    = function (name) {
	for( i=0; i<this.extensionElements.size();i++){
		if(name == this.extensionElements.get(i).name){
			whirExtension = this.extensionElements.get(i);
			return whirExtension;
			break;
		}
	}
    return null;
}; 

//删除扩展属性对象
XiorkFlowModel.prototype.removeWhirExtension     = function (whirExtension  ) {
	this.extensionElements.remove(whirExtension);
};

//新建立扩展属性对象
XiorkFlowModel.prototype.newWhirExtension     = function (name  ) {
	return new WhirExtension(name);
};

//根据扩展属性名称获取扩展属性列表，返回是一个Array
XiorkFlowModel.prototype.getWhirExtensionsByName    = function (name) {
	var result = new Array();
	for( i=0; i<this.extensionElements.size();i++){
		if(name == this.extensionElements.get(i).name){
			whirExtension = this.extensionElements.get(i);
			result.add(whirExtension);
		}
	}
    return result;
}; 

//根据位置获取扩展属性
XiorkFlowModel.prototype.getWhirExtension    = function (index) {
    return this.extensionElements.get(index);
}; 

//获取扩展属性数量
XiorkFlowModel.prototype.getWhirExtensionCount    = function () {
    return this.extensionElements.size();
}; 


 
//recordId
XiorkFlowModel.prototype.setRecordId = function (recordId) {
    this.recordId = recordId;
};
XiorkFlowModel.prototype.getRecordId = function () {
    return this.recordId;
};


//subType
XiorkFlowModel.prototype.setSubType = function (subType) {
    this.subType = subType;
};
XiorkFlowModel.prototype.getSubType = function () {
    return this.subType;
};

//processType
XiorkFlowModel.prototype.setProcessType = function (processType) {
    this.processType = processType;
};
//processType
XiorkFlowModel.prototype.getProcessType = function () {
    return this.processType;
};

//subType
XiorkFlowModel.prototype.setSubPrefix = function (subPrefix) {
    this.subPrefix= subPrefix;
};

XiorkFlowModel.prototype.getSubPrefix = function (){
    return this.subPrefix;
};
/*
XiorkFlowModel.prototype.resetID = function () {
    this.id = XiorkFlowWorkSpace.ID;
};
XiorkFlowModel.prototype.updateID = function (id) {
    if (id > this.id) {
        this.id = id;
    }
};
*/
//新加设置ID属性
XiorkFlowModel.prototype.setID = function (id) {
        this.id = id;
};
XiorkFlowModel.prototype.getID = function () {
        return this.id ;
};
/*
XiorkFlowModel.prototype.nextID = function () {
    return this.id++;
};
*/

//根据type设置ID值
XiorkFlowModel.prototype.nextID = function (type) {
	index = this.ids.get(type);
	if( index ){
		index ++;
	}else{
		index = 1;
	}
    var subType_str=""; 
	if(this.subType=="1"){
		var subPrefix=this.getSubPrefix();
		if(subPrefix){
           subType_str=subPrefix;
		}else{
	       subType_str="sub_";
		} 
	}
	var name = "undefined";
    switch( type){
		case MetaNodeModel.TYPE_USERTASK_NODE:
			name = "usertask"; 
			break;
		case MetaNodeModel.TYPE_AUTOBACKTASK_NODE:
			name = "autobacktask"; 
			break;
		case MetaNodeModel.TYPE_PARALLELGATEWAY_NODE :
			name = "parallelgateway"; 
			break;
		case MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE :
			name = "exclusivegateway"; 
			break;
		case MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE :
			name = "inclusivegateway"; 
			break;
		case MetaNodeModel.TYPE_SUBPROCESS_NODE :
			name = "subprocess"; 
			break;
		case MetaNodeModel.TYPE_CALLACTIVITY_NODE :
			name = "callactivity"; 
			break;
		case MetaNodeModel.TYPE_SERVICETASK_NODE :
			name = "servicetask"; 
			break;
		case MetaNodeModel.TYPE_RECEIVETASK_NODE :
			name = "receivetask"; 
			break;
		case "TRANSITIONMODEL":
			name = "sequenceflow"; 
			break;
	}
	name=subType_str+name;
	//检查重复
	var i =0;
	while(i != this.metaNodeModels.length){ //在所有任务节点中检查
		for( i=0;i<this.metaNodeModels.length;i++){
			if( this.metaNodeModels[i].getID() == (name+index) ){
				index ++;
				break;
			}
		}
	}
	i =0 ;
	while(i != this.transitionModels.length){ //在所有顺序流中检查
		for( i=0;i<this.transitionModels.length;i++){
			if( this.transitionModels[i].getID() == (name+index) ){
				index ++;
				break;
			}
		}
	}
	this.ids.put(type,index);
	return name + index;
};


//属性相关操作方法
//设置属性
XiorkFlowModel.prototype.setAttribute = function (name,value) {
    this.attributes.put(name,value);
};
//获取属性
XiorkFlowModel.prototype.getAttribute = function (name) {
    return this.attributes.get(name);
};

//获取属性名数组
XiorkFlowModel.prototype.getAttributeNameArray = function () {
    return this.attributes.keyArray();
};

//删除属性
XiorkFlowModel.prototype.removeAttribute = function (name) {
    this.attributes.remove(name);
};
XiorkFlowModel.prototype.executeCommand = function (command){
	if(command.execute() ){
		//这里将栈顶的数据全部删除再增加新命令
		while(this.commandHistory.size() > this.curcommandIndex){
			this.commandHistory.removeByIndex(this.commandHistory.size()-1);
		}
		this.commandHistory.add(command);
		this.curcommandIndex = this.commandHistory.size() ;
		
		this.updateButton();
	}
};
XiorkFlowModel.prototype.updateButton = function(){
		if( this.curcommandIndex <= 0  ){
			xiorkFlow.getToolBar().undoButton.getModel().setEnabled(false);
		}else{
			xiorkFlow.getToolBar().undoButton.getModel().setEnabled(true);
		}
		if( this.curcommandIndex  >= this.commandHistory.size()  ){
			xiorkFlow.getToolBar().redoButton.getModel().setEnabled(false);
		}else{
			xiorkFlow.getToolBar().redoButton.getModel().setEnabled(true);
		}

};

XiorkFlowModel.prototype.moveMetaNodeModelEnd = function (metaNodeModels, beginCoord, endCoord) {
	var command = new MoveMetaNodeModelCommand(this,metaNodeModels, beginCoord, endCoord);
	this.executeCommand(command);
	return;
};
//
XiorkFlowModel.moveMetaNodeModelBy = function (metaNodeModels, x, y) {//.prototype
    for (var i = 0; i < metaNodeModels.size(); i++) {
        var metaNodeModel = metaNodeModels.get(i);
        var pos = metaNodeModel.getPosition();
        if (((pos.getX() + x) < 0) || ((pos.getY() + y) < 0)) {
            return;
        }
    }
    for (var i = 0; i < metaNodeModels.size(); i++) {
        var metaNodeModel = metaNodeModels.get(i);
        var pos = metaNodeModel.getPosition();
        metaNodeModel.setPosition(new Point(pos.getX() + x, pos.getY() + y));
    }
};

//增加初始化的活动id
XiorkFlowModel.prototype.addInitMetaNodeId = function (id) {
   this.initMetaNodeIds+="$"+id+"$";
};

//增加初始化的连线id
XiorkFlowModel.prototype.addInitTransitionId = function (id) {
   this.initTransitionIds+="$"+id+"$";
};

 // 
XiorkFlowModel.prototype.getInitMetaNodeIds = function (id) {
     return  initMetaNodeIds;
};

// 
XiorkFlowModel.prototype.getInitTransitionIds = function (id) {
    return this.initTransitionIds;
};

XiorkFlowModel.prototype.judgeCanEditTransition = function (tempsetforbidmodify) { 
	if(tempsetforbidmodify==null){
	    tempsetforbidmodify="0";
	}
	var result=true;
	if(tempsetforbidmodify=="1"&&this.judgeIsTempSet()){
		result=false; 
	}
	return result;
};


XiorkFlowModel.prototype.judgeCanEditMetaNode = function (tempsetforbidmodify) { 

	if(tempsetforbidmodify==null){
	    tempsetforbidmodify="0";
	}
	var result=true;
	if(tempsetforbidmodify=="1"&&this.judgeIsTempSet()){
		result=false; 
	}
	return result;
};


XiorkFlowModel.prototype.setIsTempSet = function (type) { 
	 this.isTempSet=type;
};

XiorkFlowModel.prototype.getIsTempSet = function (type) { 
	return this.isTempSet;
};

XiorkFlowModel.prototype.judgeIsTempSet = function () { 
	if(this.isTempSet==1){
	    return true;
	}else{
	    return false;
	}
};


XiorkFlowModel.prototype.removeAll = function () { 

    var selectedMetaNodeModels = this.getMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getTransitionModels();//.clone();
 
	for (var i = 0; i < selectedTransitionModels.size(); i++) {  
		 this.addSelectedTransitionModel(selectedTransitionModels.get(i)); 
	}
	//
	for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
		 var metaNodeModel = selectedMetaNodeModels.get(i);
		 //开始活动 结束活动 不能删
		 if(metaNodeModel.type== MetaNodeModel.TYPE_START_NODE){
			  this.removeSelectedMetaNodeModel(metaNodeModel);
			  continue;
		 }
		 if(metaNodeModel.type==MetaNodeModel.TYPE_END_NODE){
			  this.removeSelectedMetaNodeModel(metaNodeModel);
			  continue;
		 }
		 this.addSelectedMetaNodeModel(selectedMetaNodeModels.get(i));  	 
	}
    
	this.deleteSelected();
	this.hiddenAllButton();
};


XiorkFlowModel.prototype.showAllButton = function(){ 
	 xiorkFlow.getToolBar().userTaskButton.getModel().setEnabled(true); 
	 xiorkFlow.getToolBar().autoBackTaskButton.getModel().setEnabled(true); 
	 xiorkFlow.getToolBar().parallelGatewayButton.getModel().setEnabled(true); 
	 xiorkFlow.getToolBar().exclusiveGatewayButton.getModel().setEnabled(true); 
	 xiorkFlow.getToolBar().inclusiveGatewayButton.getModel().setEnabled(true); 

	 xiorkFlow.getToolBar().callActivityButton.getModel().setEnabled(true);
     if(xiorkFlow.getToolBar().subType=="1"){ 
	 }else{
	     xiorkFlow.getToolBar().subProcessButton.getModel().setEnabled(true);
	 }
	 xiorkFlow.getToolBar().transitionButton.getModel().setEnabled(true);
	 xiorkFlow.getToolBar().deleteButton.getModel().setEnabled(true);

	 this.updateButton();

};

XiorkFlowModel.prototype.hiddenAllButton = function(){ 
	 xiorkFlow.getToolBar().undoButton.getModel().setEnabled(false);
	 xiorkFlow.getToolBar().redoButton.getModel().setEnabled(false); 

	 xiorkFlow.getToolBar().userTaskButton.getModel().setEnabled(false); 
	 xiorkFlow.getToolBar().autoBackTaskButton.getModel().setEnabled(false); 
	 xiorkFlow.getToolBar().parallelGatewayButton.getModel().setEnabled(false); 
	 xiorkFlow.getToolBar().exclusiveGatewayButton.getModel().setEnabled(false); 
	 xiorkFlow.getToolBar().inclusiveGatewayButton.getModel().setEnabled(false); 

	 xiorkFlow.getToolBar().callActivityButton.getModel().setEnabled(false);
     if(xiorkFlow.getToolBar().subType=="1"){ 
	 }else{
	     xiorkFlow.getToolBar().subProcessButton.getModel().setEnabled(false);
	 }
	 xiorkFlow.getToolBar().transitionButton.getModel().setEnabled(false);
	 xiorkFlow.getToolBar().deleteButton.getModel().setEnabled(false);

	 
};


 

XiorkFlowModel.prototype.hiddenButtonWithProcessType2 = function(){   
	 //xiorkFlow.getToolBar().callActivityButton.getModel().setEnabled(false);
	 //流程图显示 应该没有 xiorkFlow
	 try{
		 if(xiorkFlow){
			 if(xiorkFlow.getToolBar().subType=="1"){ 
			 }else{
				 xiorkFlow.getToolBar().subProcessButton.getModel().setEnabled(false);
			 }   
			 this.judgeHiddenProcessButton();
		 }
	 }catch(e){
	 }
};


XiorkFlowModel.prototype.judgeHiddenProcessButton = function(){  
	 //xiorkFlow.getToolBar().callActivityButton.getModel().setEnabled(false); 
     if(this.isTempSet=="1"){ 
		 xiorkFlow.getToolBar().processtButton.getModel().setEnabled(false);
	 }   
};
 
 
//删除数据库中的 活动
XiorkFlowModel.prototype.deleteActivity_k = function (metaNodeModel) {
    var  service=new DesignerService();
	service.deleteActivity(metaNodeModel.getID());
};
//删除数据库中的 连线
XiorkFlowModel.prototype.deleteTransition_k = function (transitionModel) {
    var  service=new DesignerService();
	service.deleteTransition(transitionModel.getID(),transitionModel.getFromMetaNodeModel().getID(),transitionModel.getToMetaNodeModel().getID());
};

//static
XiorkFlowModel.META_NODE_MODEL_ADD = "META_NODE_MODEL_ADD";
XiorkFlowModel.META_NODE_MODEL_REMOVE = "META_NODE_MODEL_REMOVE";
XiorkFlowModel.TRANSITION_MODEL_ADD = "TRANSITION_MODEL_ADD";
XiorkFlowModel.TRANSITION_MODEL_REMOVE = "TRANSITION_MODEL_REMOVE";

//删除数据库中的 连线
XiorkFlowModel.prototype.verify = function () {
	//必须有开始节点和结束节点

	//每个节点必须有连接线

	//各节点的必须属性

	//某些网关的条件

	
};


/*

*/
XiorkFlowModel.prototype.leftJustified = function () { 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	//最左边坐标
	var  minx=0;  
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
            if(minx==0){
				minx=selectedMetaNodeModels.get(i).getCorePosition().getX();
			}else{
	            minx=Math.min(selectedMetaNodeModels.get(i).getCorePosition().getX(),minx); 
			}  
        } 
	}
 
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
			var metaNodeModel=selectedMetaNodeModels.get(i);
			metaNodeModel.setCorePosition(new Point(minx, metaNodeModel.getCorePosition().getY())); 
        } 
	} 
  
};



XiorkFlowModel.prototype.rightJustified = function () { 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	//最右边坐标
	var  maxx=0;  
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
            if(maxx==0){
				maxx=selectedMetaNodeModels.get(i).getCorePosition().getX();
			}else{
	            maxx=Math.max(selectedMetaNodeModels.get(i).getCorePosition().getX(),maxx); 
			}  
        } 
	}
 
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
			var metaNodeModel=selectedMetaNodeModels.get(i);
			metaNodeModel.setCorePosition(new Point(maxx, metaNodeModel.getCorePosition().getY())); 
        } 
	} 
  
};



XiorkFlowModel.prototype.upJustified = function () { 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	//最左边坐标
	var  miny=0;  
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
            if(miny==0){
				miny=selectedMetaNodeModels.get(i).getCorePosition().getY();
			}else{
	            miny=Math.min(selectedMetaNodeModels.get(i).getCorePosition().getY(),miny); 
			}  
        } 
	}
 
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
			var metaNodeModel=selectedMetaNodeModels.get(i);
			metaNodeModel.setCorePosition(new Point(metaNodeModel.getCorePosition().getX(),miny)); 
        } 
	} 
  
};


XiorkFlowModel.prototype.downJustified = function () { 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	//最左边坐标
	var  maxy=0;  
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
            if(maxy==0){
				maxy=selectedMetaNodeModels.get(i).getCorePosition().getY();
			}else{
	            maxy=Math.max(selectedMetaNodeModels.get(i).getCorePosition().getY(),maxy); 
			}  
        } 
	}
 
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) {
			var metaNodeModel=selectedMetaNodeModels.get(i);
			metaNodeModel.setCorePosition(new Point(metaNodeModel.getCorePosition().getX(),maxy)); 
        } 
	} 
  
};

//水平间隔对齐
XiorkFlowModel.prototype.horizontalJustified = function () { 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	//最左边坐标
	var  minx=-1;  
	var  maxx=-1;
	var  ssize=selectedMetaNodeModels.size();
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) { 
            if(minx==-1||maxx==-1){
				minx=selectedMetaNodeModels.get(i).getCorePosition().getX();
				maxx=minx;
			}else{
	            maxx=Math.max(selectedMetaNodeModels.get(i).getCorePosition().getX(),maxx); 
				minx=Math.min(selectedMetaNodeModels.get(i).getCorePosition().getX(),minx); 
			}  
        } 

		var selectedMetaNodeModels2= selectedMetaNodeModels.sort(function(a, b) { 
            return a.getCorePosition().getX() - b.getCorePosition().getX();
		}); 
	}

    var jiangeX=Math.round((maxx-minx)/(ssize-1));  
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 1; i < ssize-1; i++) {
			var metaNodeModel=selectedMetaNodeModels.get(i);
			metaNodeModel.setCorePosition(new Point(minx+i*jiangeX,metaNodeModel.getCorePosition().getY())); 
        } 
	} 
  
};



//水平间隔对齐
XiorkFlowModel.prototype.verticalJustified = function () { 
    var selectedMetaNodeModels = this.getSelectedMetaNodeModels();//.clone();
    var selectedTransitionModels = this.getSelectedTransitionModels();//.clone();
    var canDelete=true;
	//最左边坐标
	var  miny=-1;  
	var  maxy=-1;
	var  ssize=selectedMetaNodeModels.size();
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 0; i < selectedMetaNodeModels.size(); i++) { 
            if(miny==-1||maxy==-1){
				miny=selectedMetaNodeModels.get(i).getCorePosition().getY();
				maxy=miny;
			}else{
	            maxy=Math.max(selectedMetaNodeModels.get(i).getCorePosition().getY(),maxy); 
				miny=Math.min(selectedMetaNodeModels.get(i).getCorePosition().getY(),miny); 
			}  
        } 

		var selectedMetaNodeModels2= selectedMetaNodeModels.sort(function(a, b) { 
            return a.getCorePosition().getY() - b.getCorePosition().getY();
		}); 
	}

    var jiangeY=Math.round((maxy-miny)/(ssize-1));  
	if (selectedMetaNodeModels.size() > 0) {
	    for (var i = 1; i < ssize-1; i++) {
			var metaNodeModel=selectedMetaNodeModels.get(i);
			metaNodeModel.setCorePosition(new Point(metaNodeModel.getCorePosition().getX(),miny+i*jiangeY)); 
        } 
	} 
  
};
