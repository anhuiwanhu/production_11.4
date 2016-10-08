
/**
 * <p>Title: MetaNode</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function MetaNode(model, img, wrapper) {
    this.base = Panel;
    this.base(Toolkit.newLayer());
    this.setClassName("NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_METANODE");

    //
    this.wrapper = wrapper;

    //bound rectangle
    var rectangleUrl = XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/rectangle.gif";
    //lefttop
    this.lefttopRetangle = new Component(Toolkit.newImage());
    this.lefttopRetangle.getUI().src = rectangleUrl;
    this.lefttopRetangle.setLeft("-5px");
    this.lefttopRetangle.setTop("-5px");
    this.lefttopRetangle.setPosition("absolute");
    this.add(this.lefttopRetangle);
    //righttop
    this.righttopRetangle = new Component(Toolkit.newImage());
    this.righttopRetangle.getUI().src = rectangleUrl;
    this.righttopRetangle.setRight("-5px");
    this.righttopRetangle.setTop("-5px");
    this.righttopRetangle.setPosition("absolute");
    this.add(this.righttopRetangle);
    //leftbottom
    this.leftbottomRetangle = new Component(Toolkit.newImage());
    this.leftbottomRetangle.getUI().src = rectangleUrl;
    this.leftbottomRetangle.setLeft("-5px");
    this.leftbottomRetangle.setBottom("-5px");
    this.leftbottomRetangle.setPosition("absolute");
    this.add(this.leftbottomRetangle);
    //rightbottom
    this.rightbottomRetangle = new Component(Toolkit.newImage());
    this.rightbottomRetangle.getUI().src = rectangleUrl;
    this.rightbottomRetangle.setRight("-5px");
    this.rightbottomRetangle.setBottom("-5px");
    this.rightbottomRetangle.setPosition("absolute");
    this.add(this.rightbottomRetangle);
    this.rightbottomRetangle.setCursor(Cursor.RESIZE_SE);

    //
    this.table = Toolkit.newTable();
    this.table.width = "100%";
    this.table.height = "100%";
    this.table.cellPadding = 0;
    this.table.cellSpacing = 0;
    this.add(this.table);

    //
    var titleRow = this.table.insertRow(-1);
    titleRow.className = "TITLE";

    //
    var titleImgCell = titleRow.insertCell(-1);
    titleImgCell.align = "center";
    titleImgCell.valign = "middle";
    if (!img) {
        img = XiorkFlowWorkSpace.XIORK_FLOW_PATH + "images/xiorkflow/metanode.gif";
    }
    var titleImg = Toolkit.newLayer();
   
    titleImg.style.background = "url(' " + img + "')";
	titleImg.className = "IMG";
    titleImgCell.appendChild(titleImg);
	

    // 仅显示名
    this.titleTxtCell = titleRow.insertCell(-1);
    this.titleTxtCell.align = "center";
    this.titleTxtCell.valign = "middle";
    this.titleTxtCell.className = "TXT";

    //编辑时的名
    this.titleInputCell = titleRow.insertCell(-1);
    this.titleInputCell.align = "left";
    this.titleInputCell.valign = "middle";
    this.titleInput = Toolkit.newElement("<input type=\"text\">");
    this.titleInput.style.display = "none";


	

	//编辑时的名
    this.viewImgCell = titleRow.insertCell(-1);
    this.viewImgCell.align = "left";
    this.viewImgCell.valign = "middle"; 
	this.viewImg = Toolkit.newLayer(); 
	//viewImg.style.background = "url(' " + vimg + "')";
	//viewImg.className = "IMG";
	this.viewImgCell.appendChild(this.viewImg);




    var _MetaNode = this;
    this.titleInput.onchange = function () {
        _MetaNode.stopEdit();
    };
    this.titleInput.onblur = function () {
        _MetaNode.stopEdit();
    };
    this.titleInputCell.appendChild(this.titleInput);

    //
    this.setModel(model);
    this.rightbottomRetangle.addMouseListener(new MetaNodeResizeMouseListener(this.rightbottomRetangle, model, this.wrapper));
}
MetaNode.prototype = new Panel();

//
MetaNode.prototype.setModel = function (model) {
    if (this.model == model) {
        return;
    }
    if (this.model) {
        this.model.removeObserver(this);
    }
    this.model = model;
    this.model.addObserver(this);

    //
    this._updatePosition();
    this._updateSize();
    this._updateText();
    this._updateBoundRectangle();
};
MetaNode.prototype.getModel = function () {
    return this.model;
};

//
MetaNode.prototype.startEdit = function () {
    this.titleTxtCell.style.display = "none";
    this.titleInput.style.display = "";
    this.titleInputCell.style.display = "";
    this.titleInput.focus();
    this.getModel().setEditing(true);
};
// 当输入值后 失去鼠标焦点后 隐藏文本框
MetaNode.prototype.stopEdit = function () {
    this.titleTxtCell.style.display = "";
    this.titleInput.style.display = "none";
    this.titleInputCell.style.display = "none";
    this.getModel().setText(this.titleInput.value);
    this.getModel().setEditing(false);
};

// 双击弹出活动修改页面 进行活动的修改 并返回 修改后的活动名
MetaNode.prototype.editActivity = function () {
	 
	 	//开始活动 结束活动 不能删
	if(this.getModel().type== MetaNodeModel.TYPE_START_NODE){
		//alert("开始活动不能删除");
		return;
	}
	if(this.getModel().type==MetaNodeModel.TYPE_END_NODE){
		//alert("结束活动不能删除");
		return;
	}
	 var  _xiorkFlowModel=this.wrapper.getModel();
	 var model=this.getModel();
	 var processId=_xiorkFlowModel.getName();
	 var tableId=_xiorkFlowModel.getTableId();
	 var moduleId=_xiorkFlowModel.getModuleId();
	 var formType="0";
	 if(_xiorkFlowModel.getAttribute("whir:formKey")!=null){
         formType=_xiorkFlowModel.getAttribute("whir:formType");
	 }
	 var id=model.getID();
     var url=CommonJSResource.rootPath+"/ActivityAction.do?action=modify&activityId="+id+"&processId="+processId+"&tableId="+tableId+"&moduleId="+moduleId;
     url+="&isDesigner=1";

	 var width_val=1100;
	 var height_val=600;
	 //alert(url);
	 //url = CommonJSResource.rootPath+ "/ezflow/workFlowDesigner/whirFlow/jsp/huodong.jsp?id="+model.getID();
	 url = CommonJSResource.rootPath+ "/ezflowprocess!setActivity.action?id="+model.getID()+"&formCode="+_xiorkFlowModel.getAttribute("whir:formKey")+"&moduleId="+moduleId ;
	 url+="&subType="+_xiorkFlowModel.getSubType()+"&formType="+formType;
	 if(this.getModel().type== MetaNodeModel.TYPE_START_NODE){
		  //url = CommonJSResource.rootPath+ "/ezflow/workFlowDesigner/whirFlow/jsp/event.jsp?id="+model.getID();
		  url = CommonJSResource.rootPath+ "/ezflowprocess!setStartEvent.action?id="+model.getID()+"&formCode="+_xiorkFlowModel.getAttribute("whir:formKey") ;
	
	 }
	 
	 //调用活动	
	 if(this.getModel().type== MetaNodeModel.TYPE_CALLACTIVITY_NODE){
		  url = CommonJSResource.rootPath+ "/ezflowprocess!setCallActivity.action?id="+model.getID()+"&formKey="+_xiorkFlowModel.getAttribute("whir:formKey")
			  +"&formType="+_xiorkFlowModel.getAttribute("whir:formType") +"&moduleId="+moduleId ;
		  width_val=750;
          height_val=500;
	 }

	 //子流程
	 if(this.getModel().type== MetaNodeModel.TYPE_SUBPROCESS_NODE){
		  url = CommonJSResource.rootPath+ "/ezflowprocess!setSubProcess.action?id="+model.getID();
		  width_val=550;
          height_val=200;
	 }

	 if(this.getModel().type== MetaNodeModel.TYPE_EXCLUSIVEGATEWAY_NODE ){
		  url = CommonJSResource.rootPath+ "/platform/bpm/ezflow/process/ezflow_process_exclusivegateway.jsp?id="+model.getID();

		  width_val=550;
          height_val=200;
	 }

	 //http://localhost:7001/CommonJSResource.rootPath/ActivityAction.do?action=modify&activityId=97834600&processId=97834528&tableId=97829949&moduleId=1
	 //var newwindow = window.open(encodeURI(url),'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=900,height=800');\
      

	 Toolkit.openWin({url:url,width:width_val,height:height_val,winName:'setProcessActivi'});

	  
	 //newwindow.model = model;
	 //newwindow.initData();
};
//
MetaNode.prototype._updatePosition = function () {
    var point = this.model.getPosition();
    this.setLeft(point.getX() + "px");
    this.setTop(point.getY() + "px");
	this.wrapper.getViewer().updateSvgPosition(point);
};
MetaNode.prototype._updateSize = function () {
    var size = this.model.getSize();
    this.setWidth(size.getWidth() + "px");
    this.setHeight(size.getHeight() + "px");
};
MetaNode.prototype._updateText = function () {
    var text = this.model.getText();
    this.titleInput.value = text;
    this.titleTxtCell.innerHTML = text;
};

//改变样式表
MetaNode.prototype._updateClassName = function () {
    var className = this.model.getClassName();
	if(className=="red"){
		this.getUI().style.background="none"; 
	    this.getUI().style.backgroundColor="rgb(141,206,60)";
	}
	if(className=="buttonface"){
		if(this.model.judgeIsGate()){
			var vimg=XiorkFlowWorkSpace.XIORK_FLOW_PATH+"/src/name/xio/xiorkflow/ling-x-dealed.png";
			this.getUI().style.background= "url(' " + vimg + "') no-repeat center 50%";  
		}else{
			this.getUI().style.background="none";  
			this.getUI().style.backgroundColor="rgb(143,143,143)";  
		}
	}  

	if(className=="viewed"||className=="NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_METANODE_VIEWED"){	   
	    // this.getUI().style.background="viewed.jpg"; 
	    this.setClassName(className);
	    //this.getUI().style.backgroundImage="url(/defaultroot/platform/bpm/ezflow/graph/whirflow/src/name/xio/xiorkflow/viewed.jpg)"; 
		

		this.getUI().style.background="none"; 
	    this.getUI().style.backgroundColor="rgb(141,206,60)";

		var vimg=XiorkFlowWorkSpace.XIORK_FLOW_PATH+"/src/name/xio/xiorkflow/eye.png";
		this.viewImg.style.background = "url(' " + vimg + "')";
		this.viewImg.className = "IMG";


	}

	
    //this.setClassName(className);
};

//选中 当
MetaNode.prototype._updateBoundRectangle = function () {
    if (this.model.isSelected()) {
        this.lefttopRetangle.setClassName("BOUND_RECTANGLE");
        this.righttopRetangle.setClassName("BOUND_RECTANGLE");
        this.leftbottomRetangle.setClassName("BOUND_RECTANGLE");
        this.rightbottomRetangle.setClassName("BOUND_RECTANGLE");
    } else {
        this.lefttopRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");
        this.righttopRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");
        this.leftbottomRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");
        this.rightbottomRetangle.setClassName("BOUND_RECTANGLE_UNSELECTED");

        //
        this.stopEdit();
    }
};

//
MetaNode.prototype.update = function (observable, arg) {
    this.wrapper.setChanged(true);
    switch (arg) {
      case MetaNodeModel.POSITION_CHANGED:
        this._updatePosition();
        break;
      case MetaNodeModel.SIZE_CHANGED:
        this._updateSize();
        break;
      case MetaModel.TEXT_CHANGED:
        this._updateText();
        break;
      case MetaModel.SELECTED_CHANGED:
        this._updateBoundRectangle();
        break;
      case MetaModel.SUICIDE:
        this._suicide();
        break;
	  case MetaModel.CLASSNAME_CHANGED:
		this._updateClassName();
	    break;
      default:
        break;
    }
};

//
MetaNode.prototype._suicide = function () {
    this.listenerProxy.clear();
    if (!this.wrapper) {
        return;
    }
    this.wrapper.removeMetaNode(this);
};



