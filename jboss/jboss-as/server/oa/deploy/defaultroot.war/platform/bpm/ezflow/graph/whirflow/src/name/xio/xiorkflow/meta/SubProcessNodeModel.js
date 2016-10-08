
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function SubProcessNodeModel() {
    this.base = MetaNodeModel;
    this.base();
    
    //
    this.setText(workflowMessage_js.subworkflow);//"子流程" workflowMessage_js.CALLACTIVITY
	
	 // 限制1进1出
    this.TOS_MAX = MetaNodeModel.NUM_NOT_LIMIT;//MetaNodeModel.NUM_NOT_LIMIT;
    this.FROMS_MAX =1;//MetaNodeModel.NUM_NOT_LIMIT;
    

	this.WIDTH_MIN=120;
	this.HEIGHT_MIN=35;

    var  swidth=80;
	if(workflowMessage_js.subworkflow!="子流程"){
	    swidth=110;
	}

	swidth=120;
    //
    this.setSize(new Dimension(swidth, 30));
}
SubProcessNodeModel.prototype = new MetaNodeModel();

//
SubProcessNodeModel.prototype.toString = function () {
	//节点
    //return "[\u8282\u70b9:" + this.getText() + "]";
	return "["+ workflowMessage_js.designer_Node+":" + this.getText() + "]";
};

//类型ID
SubProcessNodeModel.prototype.type = MetaNodeModel.TYPE_SUBPROCESS_NODE;


//属性**********************

//显示名
SubProcessNodeModel.prototype.setName = function (name) {
    this.name = name;
};
SubProcessNodeModel.prototype.getName = function () {
    return this.enable;
};
