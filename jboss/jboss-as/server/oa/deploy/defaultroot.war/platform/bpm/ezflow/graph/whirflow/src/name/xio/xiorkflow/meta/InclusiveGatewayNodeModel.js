
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function InclusiveGatewayNodeModel() {
    this.base = MetaNodeModel;
    this.base();
    
    //
    this.setText(workflowMessage_js.XX);//包含网关
	
	 // 限制1进1出
    this.TOS_MAX = MetaNodeModel.NUM_NOT_LIMIT;
    this.FROMS_MAX = MetaNodeModel.NUM_NOT_LIMIT;

	this.WIDTH_MIN=140;
	this.HEIGHT_MIN=60;

    //
    this.setSize(new Dimension(140, 60));
}
InclusiveGatewayNodeModel.prototype = new MetaNodeModel();

//
InclusiveGatewayNodeModel.prototype.toString = function () {
	//节点
    //return "[\u8282\u70b9:" + this.getText() + "]";
	return "["+ workflowMessage_js.designer_Node+":" + this.getText() + "]";
};

//类型ID
InclusiveGatewayNodeModel.prototype.type = MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE;


//属性**********************

//显示名
InclusiveGatewayNodeModel.prototype.setName = function (name) {
    this.name = name;
};
InclusiveGatewayNodeModel.prototype.getName = function () {
    return this.enable;
};
