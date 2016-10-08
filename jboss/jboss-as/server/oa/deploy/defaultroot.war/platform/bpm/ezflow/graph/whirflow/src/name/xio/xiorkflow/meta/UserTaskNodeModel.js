
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function UserTaskNodeModel() {
    this.base = MetaNodeModel;
    this.base();
    
    //
    this.setText(workflowMessage_js.task);//用户任务
	
	// 限制n进1出
    this.TOS_MAX = MetaNodeModel.NUM_NOT_LIMIT;//1;
    this.FROMS_MAX = 1;//MetaNodeModel.NUM_NOT_LIMIT;

	//this.WIDTH_MIN=120;
	//this.HEIGHT_MIN=35;

    //
    this.setSize(new Dimension(120, 35));

	//扩展属性
	this.extensionElements = new List();
}
UserTaskNodeModel.prototype = new MetaNodeModel();

//
UserTaskNodeModel.prototype.toString = function () {
	//节点
    //return "[\u8282\u70b9:" + this.getText() + "]";
	return "["+ workflowMessage_js.designer_Node+":" + this.getText() + "]";
};

//类型ID
UserTaskNodeModel.prototype.type = MetaNodeModel.TYPE_USERTASK_NODE;

//属性**********************
/*
//显示名
UserTaskNodeModel.prototype.setName = function (name) {
    this.name = name;
};
UserTaskNodeModel.prototype.getName = function () {
    return this.enable;
};

//过期时间
UserTaskNodeModel.prototype.setDueDate = function (dueDate) {
    this.dueDate = dueDate;
};
UserTaskNodeModel.prototype.getDueDate = function () {
    return this.dueDate;
};

//表单信息
UserTaskNodeModel.prototype.setFormKey = function (formKey) {
    this.formKey = formKey;
};
UserTaskNodeModel.prototype.getFormKey = function () {
    return this.formKey;
};

//优先级
UserTaskNodeModel.prototype.setPriority = function (priority) {
    this.priority = priority;
};
UserTaskNodeModel.prototype.getPriority = function () {
    return this.priority;
};

//任务办理顺序
UserTaskNodeModel.prototype.setTaskSequenceType = function (taskSequenceType) {
    this.taskSequenceType = taskSequenceType;
};
UserTaskNodeModel.prototype.getTaskSequenceType = function () {
    return this.taskSequenceType;
};


//办理人选择范围
UserTaskNodeModel.prototype.setTaskParticipantType  = function (taskParticipantType ) {
    this.taskParticipantType  = taskParticipantType ;
};
UserTaskNodeModel.prototype.getTaskParticipantType = function () {
    return this.taskParticipantType ;
};


//活动过期执行操作类型
UserTaskNodeModel.prototype.setOverdueTpye  = function (overdueTpye ) {
    this.overdueTpye  = overdueTpye ;
};
UserTaskNodeModel.prototype.getOverdueTpye = function () {
    return this.overdueTpye ;
};

//可写字段
UserTaskNodeModel.prototype.setNodeWriteField   = function (nodeWriteField  ) {
    this.nodeWriteField   = nodeWriteField  ;
};
UserTaskNodeModel.prototype.getNodeWriteField  = function () {
    return this.nodeWriteField  ;
};

//隐藏字段
UserTaskNodeModel.prototype.setNodeHiddenField   = function (nodeHiddenField  ) {
    this.nodeHiddenField   = nodeHiddenField  ;
};
UserTaskNodeModel.prototype.getNodeHiddenField  = function () {
    return this.nodeHiddenField  ;
};

//批示意见对应字段
UserTaskNodeModel.prototype.setNodeCommentField   = function (nodeCommentField  ) {
    this.nodeCommentField   = nodeCommentField  ;
};
UserTaskNodeModel.prototype.getNodeCommentField  = function () {
    return this.nodeCommentField  ;
};

//是否允许代办
UserTaskNodeModel.prototype.setNodeNeedAgent   = function (nodeNeedAgent  ) {
    this.nodeNeedAgent   = nodeNeedAgent  ;
};
UserTaskNodeModel.prototype.getNodeNeedAgent = function () {
    return this.nodeNeedAgent  ;
};


//单个办理人
UserTaskNodeModel.prototype.setAssignee   = function (assignee  ) {
    this.assignee   = assignee  ;
};
UserTaskNodeModel.prototype.getAssignee   = function (assignee  ) {
    return this.assignee  ;
};

//是否需要阅件
UserTaskNodeModel.prototype.setTaskNeedRead   = function (taskNeedRead  ) {
    this.taskNeedRead   = taskNeedRead  ;
};
UserTaskNodeModel.prototype.getTaskNeedRead   = function (taskNeedRead  ) {
    return this.taskNeedRead  ;
};

//办理执行的类
UserTaskNodeModel.prototype.setTaskDealWithClass   = function (taskDealWithClass  ) {
    this.taskDealWithClass   = taskDealWithClass  ;
};
UserTaskNodeModel.prototype.getTaskDealWithClass   = function (taskDealWithClass  ) {
    return this.taskDealWithClass  ;
};  
*/
//扩展属性对象
//使用一个List 中放置Map的方式

//设置扩展属性
UserTaskNodeModel.prototype.addWhirExtension     = function (whirExtension   ) {
	if( whirExtension instanceof WhirExtension){
		this.extensionElements.add(whirExtension);
	}else{
		alert("扩展属性只能增加WhirExtension对象！");
	}
};

//新建立扩展属性对象
UserTaskNodeModel.prototype.newWhirExtension     = function (name  ) {
	return new WhirExtension(name);
};

//删除扩展属性对象
UserTaskNodeModel.prototype.removeWhirExtension     = function (whirExtension  ) {
	this.extensionElements.remove(whirExtension);
};

//根据扩展属性名称获取扩展属性
UserTaskNodeModel.prototype.getWhirExtensionByName    = function (name) {
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
UserTaskNodeModel.prototype.getWhirExtensionsByName    = function (name) {
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
UserTaskNodeModel.prototype.getWhirExtension    = function (index) {
    return this.extensionElements.get(index);
}; 

//获取扩展属性数量
UserTaskNodeModel.prototype.getWhirExtensionCount    = function () {
    return this.extensionElements.size();
}; 

UserTaskNodeModel.prototype.validate = function(){
	var result = "";
	if(this.getFroms().size() == 0){
		result = "用户任务["+this.getName() + "]没有进入连接线；\n";
	}
	if(this.getTos().size() == 0){
		result += "用户任务["+this.getName() + "]没有出去连接线；\n";
	}
	return result;
};