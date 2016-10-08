
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
/**
 *
 * @param viewer Component
 * @param model XiorkFlowModel
 */
function XiorkFlowWrapper(viewer, model, stateMonitor, statuser) {
	//
    if (stateMonitor) {
        this.setStateMonitor(stateMonitor);
        this.getStateMonitor().addObserver(this);
        this.transitionMonitor = new TransitionMonitor();
    }

	//
    this.metaNodes = new Array();
    this.transitions = new Array();

	//
    this.nodeMouseListener = new Array();
    this.transitionMouseListener = new Array();

    //
    if (model == null) {
        model = new XiorkFlowModel();
    }
    this.setModel(model);

    //
    if (viewer == null) {
        return;
    }
    this.setViewer(viewer);

    //
    this.statuser = statuser;
    this.setChanged(false);
}

//
XiorkFlowWrapper.prototype.setStateMonitor = function (stateMonitor) {
    this.stateMonitor = stateMonitor;
};
XiorkFlowWrapper.prototype.getStateMonitor = function () {
    return this.stateMonitor;
};

//
XiorkFlowWrapper.prototype.setChanged = function (b) {
    this.changed = b;
};
XiorkFlowWrapper.prototype.isChanged = function () {
    return this.changed;
};

//
XiorkFlowWrapper.prototype.setStatusInfo = function (text) {
    if (this.statuser) {
        this.statuser.setText(text);
    }
};

//
XiorkFlowWrapper.prototype.getTransitionMonitor = function () {
    return this.transitionMonitor;
};

//
XiorkFlowWrapper.prototype._initViewer = function () {
    this.getViewer().setPosition("relative");

    //画板的鼠标事件
    if (this.getModel().isEditable()) {
        this.getViewer().addMouseListener(new WrapperMetaMouseListener(this));
        this.getViewer().addMouseListener(new WrapperSelectMouseListener(this));
        this.getViewer().addMouseListener(new MetaMoveMouseListener(this));
        this.getViewer().addMouseListener(new WrapperTransitionMouseListener(this));
        this.getViewer().addKeyListener(new MetaMoveKeyListener(this));
    }
};
XiorkFlowWrapper.prototype._updateViewer = function () {
    //Toolkit.clearElement(this.getViewer());
    var model = this.getModel();
    var viewer = this.getViewer();

    //
    var metaNodeModels = model.getMetaNodeModels();
    for (var i = 0; i < metaNodeModels.size(); i++) {
        var metaNodeModel = metaNodeModels.get(i);
        var metaNode = XiorkFlowWrapper.convertMetaNodeModelToMetaNode(metaNodeModel, this);
        this.addMetaNode(metaNode);
    }

	//
    var transitionModels = model.getTransitionModels();
    for (var i = 0; i < transitionModels.size(); i++) {
        var transitionModel = transitionModels.get(i);
        var transition = XiorkFlowWrapper.convertTransitionModelToTransition(transitionModel, this);
        this.addTransition(transition);
    }
};

//
XiorkFlowWrapper.prototype.setViewer = function (viewer) {
    if (!viewer) {
        return;
    }
    if (this.viewer == viewer) {
        return;
    }
    if (this.viewer) {
        this.viewer.listenerProxy.clear();//clear memory
    }
    this.viewer = viewer;
    this._initViewer();
};
XiorkFlowWrapper.prototype.getViewer = function () {
    return this.viewer;
};

//
XiorkFlowWrapper.prototype.setModel = function (model) {
    if (!model) {
        return;
    }
    if (this.model == model) {
        return;
    }
    if (this.transitionMonitor) {
        this.transitionMonitor.reset();
    }
    this.model = model;
    this.model.addObserver(this);
    this._updateViewer();
};
XiorkFlowWrapper.prototype.getModel = function () {
    return this.model;
};

//
XiorkFlowWrapper.prototype.addMetaNode = function (metaNode) {
    this.metaNodes.add(metaNode);
    this.getViewer().add(metaNode);

	// 活动控件的事件 
	// 按钮的点击     拖动    连线的触发
	//按钮拖动事件   
	metaNode.addMouseListener(new MetaNodeMouseListener(metaNode.getModel(), this));
    if (this.getModel().isEditable()) { 
		//双击事件
     
		metaNode.addMouseListener(new MetaNodeTextMouseListener(metaNode, this));
        metaNode.addKeyListener(new MetaNodeTextKeyListener(metaNode, this));
    } 

};
XiorkFlowWrapper.prototype.removeMetaNode = function (metaNode) {
    metaNode.listenerProxy.clear();//clear memory
    this.metaNodes.remove(metaNode);
    this.getViewer().remove(metaNode);
};
XiorkFlowWrapper.prototype.addTransition = function (transition) {

    if (this.getModel().isEditable()) {

		//连线的事件
		// 连线的 双击   连线的 
        transition.addMouseListener(new TransitionMouseListener(transition.getModel(), this));
        transition.addMouseListener(new TransitionTextMouseListener(transition, this));
        transition.addKeyListener(new TransitionTextKeyListener(transition, this));
    }

	//transition.addMouseListener(new TransitionTextMouseListener(transition, this));

	if (this.getModel().isEditable()) {     
        transition.addKeyListener(new TransitionTextKeyListener(transition, this));
    }
 
    this.transitions.add(transition);
  
    this.getViewer().addChildElement(transition.getLineText());
    this.getViewer().addChildElement(transition);
	//this.getViewer().getSvgPanel().appendChild(transition.getSvgLineUI());
	//this.getViewer().getSvgPanel().appendChild(transition.getLineText().getSvgLineUI());
};
XiorkFlowWrapper.prototype.removeTransition = function (transition) {
    transition.listenerProxy.clear();//clear memory
    this.transitions.remove(transition);
    this.getViewer().removeChildElement(transition);
    this.getViewer().removeChildElement(transition.getLineText());
};

//
XiorkFlowWrapper.convertMetaNodeModelToMetaNode = function (metaNodeModel, wrapper) {
    var type = metaNodeModel.type;
    var metaNode = null;
    switch (type) {
      case MetaNodeModel.TYPE_NODE:
        metaNode = new Node(metaNodeModel, wrapper);
        break;
      case MetaNodeModel.TYPE_FORK_NODE:
        metaNode = new ForkNode(metaNodeModel, wrapper);
        break;
      case MetaNodeModel.TYPE_JOIN_NODE:
        metaNode = new JoinNode(metaNodeModel, wrapper);
        break;
      case MetaNodeModel.TYPE_START_NODE:
        metaNode = new StartNode(metaNodeModel, wrapper);
        break;
      case MetaNodeModel.TYPE_END_NODE:
        metaNode = new EndNode(metaNodeModel, wrapper);
        break;
	  //// ffflow_node
	  case MetaNodeModel.TYPE_FLOW_NODE:
        metaNode = new FlowNode(metaNodeModel, wrapper);
        break;

	 case MetaNodeModel.TYPE_SPLIT_NODE:
        metaNode = new SplitNode(metaNodeModel, wrapper);
        break;

	 case MetaNodeModel.TYPE_UNITE_NODE:
        metaNode = new UniteNode(metaNodeModel, wrapper);
        break;
	 //自动返回任务
	 case MetaNodeModel.TYPE_AUTOBACKTASK_NODE:
        metaNode = new AutoBackTaskNode(metaNodeModel, wrapper);
        break;
	 //用户任务
      
	 case MetaNodeModel.TYPE_USERTASK_NODE:
        metaNode = new UserTaskNode(metaNodeModel, wrapper);
        break;
	 //并行网关
      
	 case MetaNodeModel.TYPE_PARALLELGATEWAY_NODE:
        metaNode = new ParallelGatewayNode(metaNodeModel, wrapper);
        break;
	 //互斥网关
      
	 case MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE:
        metaNode = new ExclusiveGatewayNode(metaNodeModel, wrapper);
        break;
	 //包含网关
     
	 case MetaNodeModel.TYPE_INCLUSIVEGATEWAY_NODE:
        metaNode = new InclusiveGatewayNode(metaNodeModel, wrapper);
        break;
	 //调用过程
      
	 case MetaNodeModel.TYPE_CALLACTIVITY_NODE:
        metaNode = new CallActivityNode(metaNodeModel, wrapper);
        break;
	//子流程
	 case MetaNodeModel.TYPE_SUBPROCESS_NODE:
        metaNode = new SubProcessNode(metaNodeModel, wrapper);
        break; 

	 //java服务
      
	 case MetaNodeModel.TYPE_SERVICETASK_NODE:
        metaNode = new UserTaskNode(metaNodeModel, wrapper);
        break;
	 //等待任务 
      case MetaNodeModel.TYPE_RECEIVETASK_NODE:
        metaNode = new UserTaskNode(metaNodeModel, wrapper);
        break;


      default:
        break;
    }
    return metaNode;
};
XiorkFlowWrapper.convertTransitionModelToTransition = function (transitionModel, wrapper) {
	 //IE浏览器 用 vml
	if(Toolkit.getBrowserType()=="MSIE"){
		return new Transition(transitionModel, wrapper);
	}else{//非IE浏览器用svg
        return new Transition_svg(transitionModel, wrapper);	
	}
};

//
XiorkFlowWrapper.prototype.addNodeMouseListener = function () {
};
XiorkFlowWrapper.prototype.removeNodeMouseListener = function () {
};
XiorkFlowWrapper.prototype.addTransitionMouseListener = function () {
};
XiorkFlowWrapper.prototype.removeTransitionMouseListener = function () {
};

//  wanggl  活动的增加
XiorkFlowWrapper.prototype.update = function (observable, arg) {
    if (arg instanceof Array) {
        this.setChanged(true);
        if (arg.size() == 2) {
            var property = arg[0];
            var model = arg[1];
            switch (property) {
              case XiorkFlowModel.META_NODE_MODEL_ADD:
                var node = XiorkFlowWrapper.convertMetaNodeModelToMetaNode(model, this);
                this.addMetaNode(node);
                break;
              case XiorkFlowModel.META_NODE_MODEL_REMOVE:
                model.suicide();
                break;
              case XiorkFlowModel.TRANSITION_MODEL_ADD:
                var transition = XiorkFlowWrapper.convertTransitionModelToTransition(model, this);
                this.addTransition(transition);
                break;
              case XiorkFlowModel.TRANSITION_MODEL_REMOVE:
                model.suicide();
                break;
              default:
                break;
            }
        }
        return;
    }

	// 改变鼠标形状 
    if (arg == StateMonitor.OPERATION_STATE_CHANGED) {
        var state = this.getStateMonitor().getState();
        if (state == StateMonitor.SELECT) {
            this.getViewer().setCursor(Cursor.AUTO);
            this.getViewer().getUI().focus();
        } else {
            this.getViewer().setCursor(Cursor.CROSSHAIR);
        }
        return;
    }
};

