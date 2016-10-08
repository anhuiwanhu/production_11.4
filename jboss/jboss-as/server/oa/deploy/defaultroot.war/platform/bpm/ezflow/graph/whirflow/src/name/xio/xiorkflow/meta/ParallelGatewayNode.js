
/**
 * <p>Title: UserTaskNode</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function ParallelGatewayNode(model, wrapper) {
    this.base = MetaNode;
    var imageUrl = XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/type.gateway.parallel.png";
    this.base(model, imageUrl, wrapper);
    this.setClassName("NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_METANODE_GATE");
}
ParallelGatewayNode.prototype = new MetaNode();

ParallelGatewayNode.prototype.editActivity = function () {
	  this.startEdit();
};

