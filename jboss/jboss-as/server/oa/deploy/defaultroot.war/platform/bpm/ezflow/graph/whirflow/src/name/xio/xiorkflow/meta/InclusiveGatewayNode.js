
/**
 * <p>Title: UserTaskNode</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function InclusiveGatewayNode(model, wrapper) {
    this.base = MetaNode;
    var imageUrl = XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/type.gateway.inclusive.png";
    this.base(model, imageUrl, wrapper);
    this.setClassName("NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_METANODE_GATE");
}
InclusiveGatewayNode.prototype = new MetaNode();


InclusiveGatewayNode.prototype.editActivity = function () {
	  this.startEdit();
};
