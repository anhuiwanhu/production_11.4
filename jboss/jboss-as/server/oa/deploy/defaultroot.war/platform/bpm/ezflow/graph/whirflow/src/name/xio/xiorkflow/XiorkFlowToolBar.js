
/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function XiorkFlowToolBar(xiorkFlow,subType) {
    this.base = ToolBar;
    this.base();

    //
    this.xiorkFlow = xiorkFlow;


    this.addSeparator();




	 
    this.closeButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/close.gif", workflowMessage_js.newactivitybuttonclose);
    //关闭
    this.closeButton.setToolTipText(workflowMessage_js.newactivitybuttonclose);
    this.closeButton.addActionListener(new CloseActionListener());
    this.add(this.closeButton);   


    //
    this.saveButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/save.gif", workflowMessage_js.Save);
    //保存
    this.saveButton.setToolTipText(workflowMessage_js.Save);
    this.saveButton.addActionListener(new SaveActionListener(this.xiorkFlow));
    this.add(this.saveButton);


	//
    this.processtButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/gears.png", workflowMessage_js.setup);
    //流程属性
    this.processtButton.setToolTipText(workflowMessage_js.setup);
    this.processtButton.addActionListener(new ProcessSetActionListener(this.xiorkFlow));
    this.add(this.processtButton);



	this.addSeparator(); 


    //
    this.nodeButtonGroup = new ButtonGroup();
	this.userTaskButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/type.user.png", workflowMessage_js.task, true);//node.gif
    //用户任务
    this.userTaskButton.setToolTipText(workflowMessage_js.task);
    this.add(this.userTaskButton);
    this.nodeButtonGroup.add(this.userTaskButton);
	this.userTaskButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_USERTASK_NODE;



	//workflowMessage_js.AutobackTask	
	this.autoBackTaskButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/join.gif", "自动返回", true);//node.gif
    //自动返回任务
    this.autoBackTaskButton.setToolTipText("自动返回活动");
    this.add(this.autoBackTaskButton);
    this.nodeButtonGroup.add(this.autoBackTaskButton);
	this.autoBackTaskButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_AUTOBACKTASK_NODE;





	this.callActivityButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/callactivity.png", workflowMessage_js.CALLACTIVITY, true);
    //调用过程
    this.callActivityButton.setToolTipText(workflowMessage_js.CALLACTIVITY);
    this.add(this.callActivityButton);
    this.nodeButtonGroup.add(this.callActivityButton);
	this.callActivityButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_CALLACTIVITY_NODE;

 


	this.subType=subType; 
    if(subType=="1"){
	
	}else{ 
		this.subProcessButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/subprocess.png",workflowMessage_js.subworkflow+" ", true);
		//子流程
		this.subProcessButton.setToolTipText(workflowMessage_js.subworkflow+" ");
		this.add(this.subProcessButton);
		this.nodeButtonGroup.add(this.subProcessButton);
		this.subProcessButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_SUBPROCESS_NODE;

		
	}

    this.addSeparator();



	this.exclusiveGatewayButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/type.gateway.exclusive.png", workflowMessage_js.XOR, true);
    //互斥网关
    this.exclusiveGatewayButton.setToolTipText(workflowMessage_js.XOR);
    this.add(this.exclusiveGatewayButton);
    this.nodeButtonGroup.add(this.exclusiveGatewayButton);
	this.exclusiveGatewayButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_EXCLUSIVEGATEWAY_NODE;

 
 
	
	this.parallelGatewayButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/type.gateway.parallel.png", workflowMessage_js.XAND, true);
    //并行网关
    this.parallelGatewayButton.setToolTipText(workflowMessage_js.XAND);
    this.add(this.parallelGatewayButton);
    this.nodeButtonGroup.add(this.parallelGatewayButton);
	this.parallelGatewayButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_PARALLELGATEWAY_NODE;

 


	this.inclusiveGatewayButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/type.gateway.inclusive.png",workflowMessage_js.XX, true);
    //包含网关
    this.inclusiveGatewayButton.setToolTipText(workflowMessage_js.XX);
    this.add(this.inclusiveGatewayButton);
    this.nodeButtonGroup.add(this.inclusiveGatewayButton);
	this.inclusiveGatewayButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_INCLUSIVEGATEWAY_NODE;

 





	this.addSeparator(); 

    


	 

    //左对齐
    this.leftButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/left.png", '左对齐', true);
	this.leftButton.addActionListener(new AlignLeftJustifiedListener(this.xiorkFlow)); 
    this.leftButton.setToolTipText('左对齐');
    this.add(this.leftButton);



	
    //右对齐
    this.rightButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/right.png", '右对齐', true);
	this.rightButton.addActionListener(new AlignRightJustifiedListener(this.xiorkFlow)); 
    this.rightButton.setToolTipText('右对齐');
    this.add(this.rightButton);


    //对齐
    this.upButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/top.png", '上对齐', true);
	this.upButton.addActionListener(new AlignUpJustifiedListener(this.xiorkFlow)); 
    this.upButton.setToolTipText('上对齐');
    this.add(this.upButton);

   //对齐
    this.downButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/down.png", '下对齐', true);
	this.downButton.addActionListener(new AlignDownJustifiedListener(this.xiorkFlow)); 
    this.downButton.setToolTipText('下对齐');
    this.add(this.downButton);


     
    //水平间隔对齐
    this.horizontalButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/halign.png", '水平对齐', true);
	this.horizontalButton.addActionListener(new AlignHorizontalJustifiedListener(this.xiorkFlow)); 
    this.horizontalButton.setToolTipText('水平等间距对齐');
    this.add(this.horizontalButton);

	     
    //垂直间隔对齐
    this.verticalButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/valign.png", '垂直对齐', true);
	this.verticalButton.addActionListener(new AlignVerticalJustifiedListener(this.xiorkFlow)); 
    this.verticalButton.setToolTipText('垂直等间距对齐');
    this.add(this.verticalButton);

    
    this.addSeparator(); 




	
 
	 //
    this.selectButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/select.gif", workflowMessage_js.activitytransel, true);
    //选择
    this.selectButton.setToolTipText(workflowMessage_js.activitytransel);
    this.add(this.selectButton);
    this.nodeButtonGroup.add(this.selectButton);
    this.selectButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_SELECT;



	//
    this.transitionButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/ereference.gif",workflowMessage_js.TRANSITION);//transition.gif
    //连接
    this.transitionButton.setToolTipText(workflowMessage_js.TRANSITION);
    this.add(this.transitionButton);
    this.nodeButtonGroup.add(this.transitionButton);
    this.transitionButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_TRANSITION;

 

    //
    this.deleteButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/delete.gif",workflowMessage_js.d_delete);
    //删除
    this.deleteButton.setToolTipText(workflowMessage_js.d_delete);
    this.deleteButton.addActionListener(new DeleteMetaActionListener(this.xiorkFlow));
    this.add(this.deleteButton);

 
	//workflowMessage_js.d_cancel
    this.undoButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/undo.png", "撤消");
    //撤消
    this.undoButton.setToolTipText("撤消");
    this.undoButton.addActionListener(new UndoActionListener(this.xiorkFlow));
    this.add(this.undoButton);
    this.undoButton.getModel().setEnabled(false);
 
	this.redoButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/newxiorkflow/redo.png", workflowMessage_js.d_redo);
    //重做
    this.redoButton.setToolTipText(workflowMessage_js.d_redo);
    this.redoButton.addActionListener(new RedoActionListener(this.xiorkFlow));
    this.add(this.redoButton);
    this.redoButton.getModel().setEnabled(false);


    this.addSeparator(); 
     

 
   
 

	//AlignLeftJustifiedListener
	//AlignRightJustifiedListener
    //AlignUpJustifiedListener
	//AlignDownJustifiedListener
    
	 
 


   /*
	this.serviceTaskButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/node.gif", "java服务任务", true);
    //java服务任务
    this.serviceTaskButton.setToolTipText("java服务任务");
    this.add(this.serviceTaskButton);
    this.nodeButtonGroup.add(this.serviceTaskButton);
	this.serviceTaskButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_SERVICETASK_NODE;

	this.addSeparator();

	
	this.receiveTaskButton = new ToggleButton(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/node.gif", "等待任务", true);
    //等待任务 
    this.receiveTaskButton.setToolTipText("等待任务");
    this.add(this.receiveTaskButton);
    this.nodeButtonGroup.add(this.receiveTaskButton);
	this.receiveTaskButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_RECEIVETASK_NODE;

	this.addSeparator();
*/
    









    //this.nodeButtonGroup.add(this.leftButton);
    //this.selectButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_SELECT;

    //
 

	//AlignLeftJustifiedListener
	//AlignRightJustifiedListener
    //AlignUpJustifiedListener
	//AlignDownJustifiedListener
    




    
    this.viewerPatternButtonGroup = new ButtonGroup();
    /*
    //design
    var designButton = new ToggleButton("", "\u8bbe\u8ba1", true);
    //设计视图
    designButton.setToolTipText("\u8bbe\u8ba1\u89c6\u56fe");
    this.add(designButton);
    this.viewerPatternButtonGroup.add(designButton);
    designButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_DESIGN;

    //table
    var tableButton = new ToggleButton("", "\u8868\u683c", true);
    //表格视图
    tableButton.setToolTipText("\u8868\u683c\u89c6\u56fe");
    this.add(tableButton);
    this.viewerPatternButtonGroup.add(tableButton);
    tableButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_TABLE;

    //混合显示
    var mixButton = new ToggleButton("", "\u6df7\u5408\u663e\u793a", true);
    //混合视图
    mixButton.setToolTipText("\u6df7\u5408\u89c6\u56fe");
    this.add(mixButton);
    this.viewerPatternButtonGroup.add(mixButton);
    mixButton.getModel().name = XiorkFlowToolBar.BUTTON_NAME_MIX;
   
    //
    this.addSeparator(); */

    //
   // var helpButton = new Button(XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/help.gif", "\u5e2e\u52a9");
    //helpButton.addActionListener(new HelpActionListener());
    //帮助
   // helpButton.setToolTipText("\u5e2e\u52a9");
    //this.add(helpButton);
}
XiorkFlowToolBar.prototype = new ToolBar();
XiorkFlowToolBar.prototype.getNodeButtonGroup = function () {
    return this.nodeButtonGroup;
};
XiorkFlowToolBar.prototype.setDesignButtonEnable = function (b) {
    var buttons = this.nodeButtonGroup.getButtons();
    for (var i = 0; i < buttons.size(); i++) {
        buttons.get(i).getModel().setEnabled(b);
    }
    this.deleteButton.getModel().setEnabled(b);
};
XiorkFlowToolBar.prototype.setButtonEnable = function (b) {
    var buttons = this.nodeButtonGroup.getButtons();
    for (var i = 0; i < buttons.size(); i++) {
        buttons.get(i).getModel().setEnabled(b);
    }
    var viewPatternbuttons = this.viewerPatternButtonGroup.getButtons();
    for (var i = 0; i < viewPatternbuttons.size(); i++) {
        viewPatternbuttons.get(i).getModel().setEnabled(b);
    }
    this.deleteButton.getModel().setEnabled(b);
    this.saveButton.getModel().setEnabled(b);
	this.processtButton.getModel().setEnabled(b);
};
XiorkFlowToolBar.prototype.getViewerPatternButtonGroup = function () {
    return this.viewerPatternButtonGroup;
};

//
XiorkFlowToolBar.prototype.update = function (observable, arg) {
    if (arg instanceof Array) {
        if (arg.size() == 2) {
            var property = arg[0];
            var state = arg[1];
            if (property == StateMonitor.OPERATION_STATE_RESET) {
                switch (state) {
                  case StateMonitor.SELECT:
                    this.selectButton.getModel().setPressed(true);
                    break;
                  case StateMonitor.NODE:
                    this.nodeButton.getModel().setPressed(true);
                    break;
                  case StateMonitor.FORK_NODE:
                    this.forkNodeButton.getModel().setPressed(true);
                    break;
                  case StateMonitor.JOIN_NODE:
                    this.joinNode.getModel().setPressed(true);
                    break;
                  case StateMonitor.START_NODE:
                    this.startNodeButton.getModel().setPressed(true);
                    break;
                  case StateMonitor.END_NODE:
                    this.endNodeButton.getModel().setPressed(true);
                    break;
				  //// ffflow_node
				  case StateMonitor.FLOW_NODE:
                    this.flowButton.getModel().setPressed(true);
                    break;
				  
				  case StateMonitor.SPLIT_NODE:
                    this.flowButton.getModel().setPressed(true);
                    break;

				  case StateMonitor.UNITE_NODE:
                    this.flowButton.getModel().setPressed(true);
                    break;

                  case StateMonitor.TRANSITION:
                    this.transitionButton.getModel().setPressed(true);
                    break;
                  default:
                    break;
                }
            }
        }
    }
};

//
XiorkFlowToolBar.BUTTON_NAME_SELECT = "BUTTON_NAME_SELECT";
XiorkFlowToolBar.BUTTON_NAME_START_NODE = "BUTTON_NAME_START_NODE";
XiorkFlowToolBar.BUTTON_NAME_END_NODE = "BUTTON_NAME_END_NODE";
XiorkFlowToolBar.BUTTON_NAME_FORK_NODE = "BUTTON_NAME_FORK_NODE";
XiorkFlowToolBar.BUTTON_NAME_JOIN_NODE = "BUTTON_NAME_JOIN_NODE";
XiorkFlowToolBar.BUTTON_NAME_FLOW_NODE = "BUTTON_NAME_FLOW_NODE";
XiorkFlowToolBar.BUTTON_NAME_SPLIT_NODE = "BUTTON_NAME_SPLIT_NODE";
XiorkFlowToolBar.BUTTON_NAME_UNITE_NODE = "BUTTON_NAME_UNITE_NODE";
XiorkFlowToolBar.BUTTON_NAME_NODE = "BUTTON_NAME_NODE";
XiorkFlowToolBar.BUTTON_NAME_TRANSITION = "BUTTON_NAME_TRANSITION";

//
XiorkFlowToolBar.BUTTON_NAME_DESIGN = "BUTTON_NAME_DESIGN";
XiorkFlowToolBar.BUTTON_NAME_TABLE = "BUTTON_NAME_TABLE";
XiorkFlowToolBar.BUTTON_NAME_MIX = "BUTTON_NAME_MIX";

//增加自动返回任务的按钮
XiorkFlowToolBar.BUTTON_NAME_AUTOBACKTASK_NODE = " BUTTON_NAME_AUTOBACKTASK_NODE ";
//增加用户任务的按钮
XiorkFlowToolBar.BUTTON_NAME_USERTASK_NODE = " BUTTON_NAME_USERTASK_NODE ";
//增加并行网关的按钮
XiorkFlowToolBar.BUTTON_NAME_PARALLELGATEWAY_NODE = " BUTTON_NAME_PARALLELGATEWAY_NODE ";
//增加互斥网关的按钮
XiorkFlowToolBar.BUTTON_NAME_EXCLUSIVEGATEWAY_NODE = " BUTTON_NAME_EXCLUSIVEGATEWAY_NODE ";
//增加包含网关的按钮
XiorkFlowToolBar.BUTTON_NAME_INCLUSIVEGATEWAY_NODE =  " BUTTON_NAME_INCLUSIVEGATEWAY_NODE ";
//增加调用过程的按钮
XiorkFlowToolBar.BUTTON_NAME_CALLACTIVITY_NODE =  " BUTTON_NAME_CALLACTIVITY_NODE ";

//增加子流程的按钮
XiorkFlowToolBar.BUTTON_NAME_SUBPROCESS_NODE =  " BUTTON_NAME_SUBPROCESS_NODE ";
// serviceTask  
XiorkFlowToolBar.BUTTON_NAME_SERVICETASK_NODE =   " BUTTON_NAME_SERVICETASK_NODE ";
// receiveTask  
XiorkFlowToolBar.BUTTON_NAME_RECEIVETASK_NODE =   " BUTTON_NAME_RECEIVETASK_NODE ";
