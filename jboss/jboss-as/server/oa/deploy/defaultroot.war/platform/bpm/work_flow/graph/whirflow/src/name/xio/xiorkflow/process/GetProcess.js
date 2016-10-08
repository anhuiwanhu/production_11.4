
/**
 * <p>Title:  </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) xio.name 2006</p>
 * @author xio
 */
function GetProcess(wrapper, tableViewer, toolbar) {
    this.base = Ajax;
    this.base();
    this.wrapper = wrapper;
    this.toolbar = toolbar;
    this.tableViewer = tableViewer;
}
GetProcess.prototype = new Ajax();
GetProcess.prototype.setButtonEnable = function (b) {
    if (this.toolbar) {
        this.toolbar.setButtonEnable(b);
    }
};

//
GetProcess.prototype.getProcess = function (name,tableId,moduleId,dealedActivityIds,activity) {
    if (!name) {
        this.name = null;
    	//加载失败，工作流程图名字为空！
        alert("\u52a0\u8f7d\u5931\u8d25\uff0c\u5de5\u4f5c\u6d41\u7a0b\u56fe\u540d\u5b57\u4e3a\u7a7a\uff01");
        return false;
    }
    this.name = name;
	this.tableId=tableId;
	this.moduleId=moduleId;
	this.dealedActivityIds=dealedActivityIds;
	this.activity=activity;

    //
    this.setButtonEnable(false);

    //
    var url = XiorkFlowWorkSpace.URL_GET_PROCESS;
    var method = "POST";
	var params = "processId=" + name;
    params += "&action=loadXml";

    //
    this.loadXMLHttpRequest(url, method, params);
};
GetProcess.prototype.onReadyStateChange = function (httpRequest) {
    if (httpRequest.readyState == 4) {
        if (httpRequest.status == 200) {
            this.processXMLHttpRequest(httpRequest);
        } else {
        	//处理过程出现错误！
            alert("\u5904\u7406\u8fc7\u7a0b\u51fa\u73b0\u9519\u8bef\uff01");
            this.setButtonEnable(true);
        }
    }
};
GetProcess.prototype.processXMLHttpRequest = function (httpRequest) {
    var doc = httpRequest.responseXML;
    if (!doc) {
    	//操作结束，未知服务器处理结果！
        alert("\u64cd\u4f5c\u7ed3\u675f\uff0c\u672a\u77e5\u670d\u52a1\u5668\u5904\u7406\u7ed3\u679c\uff01");
        this.setButtonEnable(true);
        return false;
    }

    //
    var responseNodes = doc.getElementsByTagName("Response");
    if ((responseNodes != null) && (responseNodes.length > 0)) {
        var responseNode = responseNodes[0];
        var statusValue = eval(responseNode.getAttribute("status"));
        var alertStr = "";
        switch (statusValue) {
          case XiorkFlowWorkSpace.STATUS_FAIL:
      		//获取失败。
            alertStr = "\u83b7\u53d6\u5931\u8d25\u3002";
            break;
          case XiorkFlowWorkSpace.STATUS_XML_PARSER_ERROR:
      		//获取失败，xml解析出错。
            alertStr = "\u83b7\u53d6\u5931\u8d25\uff0cxml\u89e3\u6790\u51fa\u9519\u3002";
            break;
          case XiorkFlowWorkSpace.STATUS_IO_ERROR:
      		//获取失败，IO错误。
            alertStr = "\u83b7\u53d6\u5931\u8d25\uff0cIO\u9519\u8bef\u3002";
            break;
          case XiorkFlowWorkSpace.STATUS_FILE_NOT_FOUND:
      		//获取失败，文件未找到。
            alertStr = "\u83b7\u53d6\u5931\u8d25\uff0c\u6587\u4ef6\u672a\u627e\u5230\u3002";
            break;
          default:
        	//获取失败，未知错误。
            alertStr = "\u83b7\u53d6\u5931\u8d25\uff0c\u672a\u77e5\u9519\u8bef\u3002";
            break;
        }
        this.setButtonEnable(true);
        alert(alertStr);
    } else {
		//alert(doc.xml);
        var editable = this.wrapper.getModel().isEditable();
        var model = XiorkFlowModelConverter.convertXMLToModel(doc);
		// 相当于全局变量
		// 设置 processId
        model.setName(this.name);
		// 设置 tableId
		model.setTableId(this.tableId);
		// 设置 moduleId
		model.setModuleId(this.moduleId);

        model.setEditable(editable);
        this.wrapper.setModel(model);
        this.wrapper.setChanged(false);
        if (this.tableViewer) {
            this.tableViewer.setModel(model);
        }

		if(this.activity){
			if(this.activity!=""){
		        var  defaultClass="NAME_XIO_UI_FONT NAME_XIO_XIORKFLOW_METANODE";
		        var  nowClass="red";
		        var  dealedClass="buttonface";
			 

		        //取到所有的活动节点
		        var metaNodeModels = model.getMetaNodeModels();
		         for (var i = 0; i < metaNodeModels.size(); i++) { 
		   
		            var metaNodeModel = metaNodeModels.get(i);
					 ////走过的活动设置为灰
		          	 if(this.dealedActivityIds.indexOf("$"+metaNodeModel.getID()+"$")>=0){
			           metaNodeModel.setClassName(dealedClass);
			         }
                     //当前活动设置为红
			         if(this.activity==metaNodeModel.getID()){
			               metaNodeModel.setClassName(nowClass);
			          }
					  //开始活动 设置为灰
					  if(metaNodeModel.type=="START_NODE" &&( (this.dealedActivityIds !=null && this.dealedActivityIds !='' && this.dealedActivityIds !='null')||
					      ( this.activity !=null && this.activity !='' && this.activity !='null'))){
						metaNodeModel.setClassName(dealedClass);
					 }
					 //结束活动
					  if(metaNodeModel.type=="END_NODE"){
						    if(this.dealedActivityIds.indexOf("$-100$")>=0){
								metaNodeModel.setClassName(dealedClass);
							}
					  }
					 

		        }
			  }
		}

        this.setButtonEnable(true);
    }
};

