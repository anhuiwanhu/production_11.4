
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function AutoBackTaskNodeModel() {
    this.base = MetaNodeModel;
    this.base();
    
    //
    this.setText(workflowMessage_js.AutobackTask);//自动返回任务
	
	// 限制1进1出
    this.TOS_MAX = 1;//MetaNodeModel.NUM_NOT_LIMIT;
    this.FROMS_MAX = 0;//MetaNodeModel.NUM_NOT_LIMIT;



	//this.WIDTH_MIN=120;
	//this.HEIGHT_MIN=35;

    //
    this.setSize(new Dimension(120, 35));

	//扩展属性
	this.extensionElements = new List();
	this.attributes.put("whir:isBacktrackAct","true");
	
}
AutoBackTaskNodeModel.prototype = new MetaNodeModel();

//
AutoBackTaskNodeModel.prototype.toString = function () {
	//节点
    //return "[\u8282\u70b9:" + this.getText() + "]";
	return "["+ workflowMessage_js.designer_Node+":" + this.getText() + "]";
};

//类型ID
AutoBackTaskNodeModel.prototype.type = MetaNodeModel.TYPE_AUTOBACKTASK_NODE;

//属性**********************
/*
//显示名
AutoBackTaskNodeModel.prototype.setName = function (name) {
    this.name = name;
};
AutoBackTaskNodeModel.prototype.getName = function () {
    return this.enable;
};

//过期时间
AutoBackTaskNodeModel.prototype.setDueDate = function (dueDate) {
    this.dueDate = dueDate;
};
AutoBackTaskNodeModel.prototype.getDueDate = function () {
    return this.dueDate;
};

//表单信息
AutoBackTaskNodeModel.prototype.setFormKey = function (formKey) {
    this.formKey = formKey;
};
AutoBackTaskNodeModel.prototype.getFormKey = function () {
    return this.formKey;
};

//优先级
AutoBackTaskNodeModel.prototype.setPriority = function (priority) {
    this.priority = priority;
};
AutoBackTaskNodeModel.prototype.getPriority = function () {
    return this.priority;
};

//任务办理顺序
AutoBackTaskNodeModel.prototype.setTaskSequenceType = function (taskSequenceType) {
    this.taskSequenceType = taskSequenceType;
};
AutoBackTaskNodeModel.prototype.getTaskSequenceType = function () {
    return this.taskSequenceType;
};


//办理人选择范围
AutoBackTaskNodeModel.prototype.setTaskParticipantType  = function (taskParticipantType ) {
    this.taskParticipantType  = taskParticipantType ;
};
AutoBackTaskNodeModel.prototype.getTaskParticipantType = function () {
    return this.taskParticipantType ;
};


//活动过期执行操作类型
AutoBackTaskNodeModel.prototype.setOverdueTpye  = function (overdueTpye ) {
    this.overdueTpye  = overdueTpye ;
};
AutoBackTaskNodeModel.prototype.getOverdueTpye = function () {
    return this.overdueTpye ;
};

//可写字段
AutoBackTaskNodeModel.prototype.setNodeWriteField   = function (nodeWriteField  ) {
    this.nodeWriteField   = nodeWriteField  ;
};
AutoBackTaskNodeModel.prototype.getNodeWriteField  = function () {
    return this.nodeWriteField  ;
};

//隐藏字段
AutoBackTaskNodeModel.prototype.setNodeHiddenField   = function (nodeHiddenField  ) {
    this.nodeHiddenField   = nodeHiddenField  ;
};
AutoBackTaskNodeModel.prototype.getNodeHiddenField  = function () {
    return this.nodeHiddenField  ;
};

//批示意见对应字段
AutoBackTaskNodeModel.prototype.setNodeCommentField   = function (nodeCommentField  ) {
    this.nodeCommentField   = nodeCommentField  ;
};
AutoBackTaskNodeModel.prototype.getNodeCommentField  = function () {
    return this.nodeCommentField  ;
};

//是否允许代办
AutoBackTaskNodeModel.prototype.setNodeNeedAgent   = function (nodeNeedAgent  ) {
    this.nodeNeedAgent   = nodeNeedAgent  ;
};
AutoBackTaskNodeModel.prototype.getNodeNeedAgent = function () {
    return this.nodeNeedAgent  ;
};


//单个办理人
AutoBackTaskNodeModel.prototype.setAssignee   = function (assignee  ) {
    this.assignee   = assignee  ;
};
AutoBackTaskNodeModel.prototype.getAssignee   = function (assignee  ) {
    return this.assignee  ;
};

//是否需要阅件
AutoBackTaskNodeModel.prototype.setTaskNeedRead   = function (taskNeedRead  ) {
    this.taskNeedRead   = taskNeedRead  ;
};
AutoBackTaskNodeModel.prototype.getTaskNeedRead   = function (taskNeedRead  ) {
    return this.taskNeedRead  ;
};

//办理执行的类
AutoBackTaskNodeModel.prototype.setTaskDealWithClass   = function (taskDealWithClass  ) {
    this.taskDealWithClass   = taskDealWithClass  ;
};
AutoBackTaskNodeModel.prototype.getTaskDealWithClass   = function (taskDealWithClass  ) {
    return this.taskDealWithClass  ;
};  
*/
//扩展属性对象
//使用一个List 中放置Map的方式

//设置扩展属性
AutoBackTaskNodeModel.prototype.addWhirExtension     = function (whirExtension   ) {
	if( whirExtension instanceof WhirExtension){
		this.extensionElements.add(whirExtension);
	}else{
		alert("扩展属性只能增加WhirExtension对象！");
	}
};

//新建立扩展属性对象
AutoBackTaskNodeModel.prototype.newWhirExtension     = function (name  ) {
	return new WhirExtension(name);
};

//删除扩展属性对象
AutoBackTaskNodeModel.prototype.removeWhirExtension     = function (whirExtension  ) {
	this.extensionElements.remove(whirExtension);
};

//根据扩展属性名称获取扩展属性
AutoBackTaskNodeModel.prototype.getWhirExtensionByName    = function (name) {
	for( i=0; i<this.extensionElements.size();i++){
		if(name == this.extensionElements.get(i).name){
			whirExtension = this.extensionElements.get(i);
			return whirExtension;
			break;
		}
	}
    return null;
}; 

//根据扩展属性名称获取扩展属性列表，返回是一个Array
AutoBackTaskNodeModel.prototype.getWhirExtensionsByName    = function (name) {
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
AutoBackTaskNodeModel.prototype.getWhirExtension    = function (index) {
    return this.extensionElements.get(index);
}; 

//获取扩展属性数量
AutoBackTaskNodeModel.prototype.getWhirExtensionCount    = function () {
    return this.extensionElements.size();
}; 
