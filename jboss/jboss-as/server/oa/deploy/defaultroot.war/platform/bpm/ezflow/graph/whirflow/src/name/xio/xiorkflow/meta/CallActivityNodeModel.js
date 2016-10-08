
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function CallActivityNodeModel() {
    this.base = MetaNodeModel;
    this.base();
    
    //
    this.setText(workflowMessage_js.CALLACTIVITY);//"调用过程"
	
	 // 限制1进1出
    this.TOS_MAX = 1;//MetaNodeModel.NUM_NOT_LIMIT;
    this.FROMS_MAX = 1;//MetaNodeModel.NUM_NOT_LIMIT;


	//this.WIDTH_MIN=120;
	//this.HEIGHT_MIN=35;

    //
    this.setSize(new Dimension(120, 35));

		//扩展属性
	this.extensionElements = new List();
}
CallActivityNodeModel.prototype = new MetaNodeModel();

//
CallActivityNodeModel.prototype.toString = function () {
	//节点
    //return "[\u8282\u70b9:" + this.getText() + "]";
	return "["+ workflowMessage_js.designer_Node+":" + this.getText() + "]";
};

//类型ID
CallActivityNodeModel.prototype.type = MetaNodeModel.TYPE_CALLACTIVITY_NODE;


//属性**********************

//显示名
CallActivityNodeModel.prototype.setName = function (name) {
    this.name = name;
};
CallActivityNodeModel.prototype.getName = function () {
    return this.enable;
};


//扩展属性对象
//使用一个List 中放置Map的方式

//设置扩展属性
CallActivityNodeModel.prototype.addWhirExtension     = function (whirExtension   ) {
	if( whirExtension instanceof WhirExtension){
		this.extensionElements.add(whirExtension);
	}else{
		alert("扩展属性只能增加WhirExtension对象！");
	}
};

//新建立扩展属性对象
CallActivityNodeModel.prototype.newWhirExtension     = function (name  ) {
	return new WhirExtension(name);
};

//删除扩展属性对象
CallActivityNodeModel.prototype.removeWhirExtension     = function (whirExtension  ) {
	this.extensionElements.remove(whirExtension);
};

//根据扩展属性名称获取扩展属性
CallActivityNodeModel.prototype.getWhirExtensionByName    = function (name) {
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
CallActivityNodeModel.prototype.getWhirExtensionsByName    = function (name) {
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
CallActivityNodeModel.prototype.getWhirExtension    = function (index) {
    return this.extensionElements.get(index);
}; 

//获取扩展属性数量
CallActivityNodeModel.prototype.getWhirExtensionCount    = function () {
    return this.extensionElements.size();
}; 