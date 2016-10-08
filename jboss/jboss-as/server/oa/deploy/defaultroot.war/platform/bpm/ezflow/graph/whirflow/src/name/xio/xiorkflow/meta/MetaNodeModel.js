
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function MetaNodeModel() {
    this.base = MetaModel;
    this.base();

    //
    this.FROMS_MAX = 1;
    this.TOS_MAX = 1;

    //
    this.setPosition(new Point(0, 0));
    this.setSize(new Dimension(120, 35));
    this.setText("MetaNode");

    //
    this.froms = new Array();
    this.tos = new Array();
	
	//属性
	this.attributes = new Map();

    //
    this.setEditing(false);
}
MetaNodeModel.prototype = new MetaModel();

//
MetaNodeModel.prototype.toString = function () {  
	//元节点
    return "["+ workflowMessage_js.designer_Node+":" + this.getText() + "]";
};

//
MetaNodeModel.prototype.setPosition = function (position) {
    if (this.isEditing()) {
        return;
    }
    if (position == null) {
        return;
    }
    if ((position.getX() < 0) || (position.getY() < 0)) {
        return;
    }
    if (this.isResizing()) {
        return;
    }
    this.position = position;
    this.notifyObservers(MetaNodeModel.POSITION_CHANGED);
};
MetaNodeModel.prototype.getPosition = function () {
    return this.position;
};

MetaNodeModel.prototype.getCorePosition = function () {
	var x=this.position.getX();
	var y=this.position.getY(); 
    var w = this.size.getWidth();
	var h = this.size.getHeight(); 
    return new Point(x+Math.round(w/2),y+Math.round(h/2));
};

MetaNodeModel.prototype.setCorePosition = function (corePosition) {
	var x=corePosition.getX();
	var y=corePosition.getY(); 
    var w = this.size.getWidth();
	var h = this.size.getHeight(); 
    this.setPosition(new Point(x-Math.round(w/2),y-Math.round(h/2)));
};


MetaNodeModel.prototype.judgeIsGate =function (){
	var result=false;
	if(this.type==MetaNodeModel.TYPE_PARALLELGATEWAY_NODE){ 
		return true;
	}
	if(this.type==MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE){ 
		return true;
	}
	if(this.type==MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE){ 
		return true;
	}
	return false; 
};


//
MetaNodeModel.prototype.setSize = function (size) {
    if (size == null) {
        return;
    }
    if (size.getWidth() < XiorkFlowWorkSpace.META_NODE_MIN_WIDTH) {
        size.setWidth(XiorkFlowWorkSpace.META_NODE_MIN_WIDTH);
    }
    if (size.getHeight() < XiorkFlowWorkSpace.META_NODE_MIN_HEIGHT) {
        size.setHeight(XiorkFlowWorkSpace.META_NODE_MIN_HEIGHT);
    }

	if (size.getWidth() <this.WIDTH_MIN) {
        size.setWidth(this.WIDTH_MIN);
    }
    if (size.getHeight() < this.HEIGHT_MIN) {
        size.setHeight(this.HEIGHT_MIN);
    }
    this.size = size;
    this.notifyObservers(MetaNodeModel.SIZE_CHANGED);
};


MetaNodeModel.prototype.addImgSize = function () {
	var size=this.size;
    if (size == null) {
        return;
    }
    size.setWidth(size.getWidth()+16);  
    this.setSize(size);
};
MetaNodeModel.prototype.getSize = function () {
    return this.size;
};

//
MetaNodeModel.prototype.isNewFromAvailable = function () {
    var size = this.froms.size();
    return (this.FROMS_MAX == MetaNodeModel.NUM_NOT_LIMIT) ? true : (this.FROMS_MAX > size);
};
MetaNodeModel.prototype.isNewToAvailable = function () {
    var size = this.tos.size();
    return (this.TOS_MAX == MetaNodeModel.NUM_NOT_LIMIT) ? true : (this.TOS_MAX > size);
};

//判断连线是否重复
MetaNodeModel.prototype.isRepeatToThis = function (id) {
	var result=false;
    var size=this.tos.size(); 
	for (var i = 0; i <size; i++) {
        var  transitionModel=this.tos.get(i);
	    var fromMetaNodeModel = transitionModel.getFromMetaNodeModel();
	    var fid=fromMetaNodeModel.getID();
	    if(fid==id){
			result=true;
			break;
		}
    }  
	return result;
};
//
MetaNodeModel.prototype.isFromValidity = function () {
    var size = this.froms.size();
    return (this.FROMS_MAX == MetaNodeModel.NUM_NOT_LIMIT) ? true : (this.FROMS_MAX >= size);
};
MetaNodeModel.prototype.isToValidity = function () {
    var size = this.tos.size();
    return (this.TOS_MAX == MetaNodeModel.NUM_NOT_LIMIT) ? true : (this.TOS_MAX >= size);
};

//
MetaNodeModel.prototype.setResizing = function (resizing) {
    this.resizing = resizing;
};
MetaNodeModel.prototype.isResizing = function () {
    return this.resizing;
};

//
MetaNodeModel.prototype.addFrom = function (transitionModel) {
    this.froms.add(transitionModel);
    this.notifyObservers(MetaNodeModel.FROM_CHANGED);
    this.addObserver(transitionModel);
};
MetaNodeModel.prototype.removeFrom = function (transitionModel) {
    this.froms.remove(transitionModel);
    this.notifyObservers(MetaNodeModel.FROM_CHANGED);
    this.removeObserver(transitionModel);
};
MetaNodeModel.prototype.getFroms = function () {
    return this.froms;
};
MetaNodeModel.prototype.addTo = function (transitionModel) {
    this.tos.add(transitionModel);
    this.notifyObservers(MetaNodeModel.TO_CHANGED);
    this.addObserver(transitionModel);
};
MetaNodeModel.prototype.removeTo = function (transitionModel) {
    this.tos.remove(transitionModel);
    this.notifyObservers(MetaNodeModel.TO_CHANGED);
    this.removeObserver(transitionModel);
};
MetaNodeModel.prototype.getTos = function () {
    return this.tos;
};

//属性相关操作方法
//设置属性
MetaNodeModel.prototype.setAttribute = function (name,value) {
    this.attributes.put(name,value);
};
//获取属性
MetaNodeModel.prototype.getAttribute = function (name) {
    return this.attributes.get(name);
};

//获取属性名数组
MetaNodeModel.prototype.getAttributeNameArray = function () {
    return this.attributes.keyArray();
};

//删除属性
MetaNodeModel.prototype.removeAttribute = function (name) {
    this.attributes.remove(name);
};

//节点描述
MetaNodeModel.prototype.setDocumentation  = function (documentation   ) {
    this.documentation    = documentation   ;
};

MetaNodeModel.prototype.getDocumentation  = function () {
    return this.documentation   ;
};

//
MetaNodeModel.NUM_NOT_LIMIT = -1;

//
MetaNodeModel.POSITION_CHANGED = "POSITION_CHANGED";
MetaNodeModel.SIZE_CHANGED = "SIZE_CHANGED";
MetaNodeModel.FROM_CHANGED = "FROM_CHANGED";
MetaNodeModel.TO_CHANGED = "TO_CHANGED";

//
MetaNodeModel.TYPE_META_NODE = "META_NODE";
MetaNodeModel.TYPE_START_NODE = "START_NODE";//开始节点
MetaNodeModel.TYPE_END_NODE = "END_NODE";//结束节点
MetaNodeModel.TYPE_NODE = "NODE";  //标准节点
MetaNodeModel.TYPE_FORK_NODE = "FORK_NODE";//虚拟活动
MetaNodeModel.TYPE_JOIN_NODE = "JOIN_NODE";//自动返回挥动
MetaNodeModel.TYPE_DUMMY_NODE = "DUMMY_NODE"; //-------
MetaNodeModel.TYPE_FLOW_NODE = "FLOW_NODE";// 流程决定走向   0：由流程决定活动走向
MetaNodeModel.TYPE_SPLIT_NODE="SPLIT_NODE";//分支节点
MetaNodeModel.TYPE_UNITE_NODE="UNITE_NODE";//聚合节点

//新工作流设计器增加
MetaNodeModel.TYPE_USERTASK_NODE = "USERTASK_NODE";  //用户任务节点
MetaNodeModel.TYPE_AUTOBACKTASK_NODE = "AUTOBACKTASK_NODE";  //自动返回任务节点
MetaNodeModel.TYPE_PARALLELGATEWAY_NODE = "PARALLELGATEWAY_NODE";  //并行网关
MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE = "EXCLUSIVEGATEWAY_NODE";  //互斥网关
MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE = "INCLUSIVEGATEWAY_NODE";  //包含网关
MetaNodeModel.TYPE_CALLACTIVITY_NODE = "CALLACTIVITY_NODE";  //调用子过程
MetaNodeModel.TYPE_SERVICETASK_NODE = "SERVICETASK_NODE";  //java服务任务
MetaNodeModel.TYPE_RECEIVETASK_NODE = "RECEIVETASK_NODE";  //等待任务 

MetaNodeModel.TYPE_SUBPROCESS_NODE = "SUBPROCESS_NODE";  //子流程  

MetaNodeModel.prototype.type = MetaNodeModel.TYPE_META_NODE;




  