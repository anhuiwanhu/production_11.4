

function  showDIV(){
   $.dialog.tips(workflowMessage_js.dealing,1000,'loading.gif',function(){});
}
function  hiddenDIV(){
   $.dialog({id:"Tips"}).close();
}
//显示办理内容
function  showDealtipsContent(){
}
 
 
//显示流程图
function  showWorkFLowGraph(id){
	//随机流程 不显示流程图
    if($("#p_wf_processType").val()=="0"){
		$("#"+id).html("");	
	}else{
		var url=whirRootPath+"/platform/bpm/ezflow/operation/ezflow_myflow_graphView.jsp?processInstanceId="
			   +$("#p_wf_processInstanceId").val()+"&processDefinitionId="+$("#p_wf_processId").val()+"&ezflowBusinessKey="+$("#p_wf_recordId").val()
			   +"&whir_formKey="+$("#p_wf_formKey").val()+"&whir_stauts="+$("#p_wf_workStatus").val()+"&p_wf_whir_dealedActInfo="+$("#p_wf_whir_dealedActInfo").val();
	 
		var html = $.ajax({url: url,async: false}).responseText;
	 
		$("#"+id).html(html);
	}
}

//显示相关流程
function  showWorkFlowRelation(id){
	/*var recordId=$("#p_wf_recordId").val();
	//相关流程div为空 或者 是修改页面
    if($("#"+id).html()==""||recordId!=""){
	    var openType=$("#p_wf_openType").val(); 
		var url=whirRootPath+"/platform/bpm/ezflow/operation/ezflow_myflow_relationflow.jsp?openType="+$("#p_wf_openType").val();
		//重新发起  在此发起 
		if(openType=="reStart"||openType=="startAgain"){
		}else{
			url=url+"&processInstanceId="+$("#p_wf_processInstanceId").val();
		}
		var html = $.ajax({url: url,async: false}).responseText; 
		$("#"+id).html(html);
	} 
	//显示相关流程数
    var p_wf_relationallsize=$("#p_wf_relationallsize").val();
	if(p_wf_relationallsize!=null&&p_wf_relationallsize!=""&&p_wf_relationallsize!="null"&&p_wf_relationallsize!="0"){
        $("#viewrelationnum").html("("+p_wf_relationallsize+")");
	}else{
	    $("#viewrelationnum").html("");
	}*/ 

	var recordId=$("#p_wf_recordId").val();
	//相关流程div为空 或者 是修改页面
    if($("#"+id).html()==""||recordId!=""){
		var url=whirRootPath+"/platform/bpm/pool/pool_relationflow.jsp?p_wf_moduleId="+$("#p_wf_moduleId").val()+
				 "&p_wf_recordId="+$("#p_wf_recordId").val()+"&p_wf_workStatus="+$("#p_wf_workStatus").val()+"&openType="+$("#p_wf_openType").val();
        var openType=$("#p_wf_openType").val(); 
		//重新发起  在此发起 
		if(openType=="reStart"||openType=="startAgain"){
		}else{
			url=url+"&processInstanceId="+$("#p_wf_processInstanceId").val();
		}
		var html = $.ajax({url: url,async: false,cache:false}).responseText;
		$("#"+id).html(html);
	} 
 
	//显示相关流程数
    var p_wf_relationallsize=$("#p_wf_relationallsize").val();
	if(p_wf_relationallsize!=null&&p_wf_relationallsize!=""&&p_wf_relationallsize!="null"&&p_wf_relationallsize!="0"){
        $("#viewrelationnum").html("("+p_wf_relationallsize+")");
	}else{
	    $("#viewrelationnum").html("");
	}

	
}

//流程描述
function  showPrcosssDescription(id){
	//流程说明 
	var url=whirRootPath+"/platform/bpm/ezflow/operation/ezflow_myflow_description.jsp?processDefinitionId="+$("#p_wf_processId").val(); 
	var html = $.ajax({url: url,async: false}).responseText;
	$("#"+id).html(html);
}


/**
修改流程时的删除相关附件
*/
function delRelationWork(relationId){
      var url=whirRootPath+"/wfoperate!delRelationWork.action?relationId="+relationId;
      var html = $.ajax({url: url,async: false}).responseText;  
	  whir_alert("删除成功！",function(){});
      refreshRelation();
}
 

 

//打开流程
function  openWorkFlow_relation(url,workId, recordId,isezFlow,ezFlowTaskId,ezFlowProcessInstanceId, verifyCode,ezFlowProcessInstanceId_verifyCode){
   var openurl=url;
   var purl="";
   if(isezFlow=="1"){
	   purl="ezFlowProcessInstanceId="+ezFlowProcessInstanceId+"&p_wf_recordId="+recordId+"&p_wf_openType=relation&verifyCode="+ezFlowProcessInstanceId_verifyCode;
   }else{
	   purl="wfWorkId="+workId+"&p_wf_recordId="+recordId+"&p_wf_openType=relation&verifyCode="+verifyCode;
   }
    if(url.indexOf("?")>=0){
	   openurl=openurl+"&"+purl;
   }else{
	   openurl=openurl+"?"+purl;
   }
   if(!openurl.startWith(whirRootPath)){
	   openurl=whirRootPath+openurl;
   }
   openWin({url:openurl,width:850,height:750,winName:'openWorkFlow'+workId});
}




/**
刷新相关流成
*/
function  refreshRelation(){
     //showWorkFlowRelation($("#relationLiId").val()); 
	 var recordId=$("#p_wf_recordId").val();
	 var openType=$("#p_wf_openType").val();
     var relationLiId=$("#relationLiId").val(); 
	 changePanle(relationLiId); 
	/* //新增时刷新相关流程列表    
	 if(recordId==""||recordId=="null"||openType=="fromDraft"){
		 changePanle("2");
	 }else{
	     //修改时刷新相关流程列表
	     changePanle("3");
	 } */
}

/**
显示相关流程的数据
*/
function  initRealtionNum(){ 
	if($("#viewrelationnum").length>0){
		 //获取onclick事件
		 var onclickhtml=$("#viewrelationnum").parent().attr("onclick");   
		 //获取 相关流程的id号
		 var relationLiId=onclickhtml.replace(/\D/g,""); 
		 $("#relationLiId").val(relationLiId); 
		 showWorkFlowRelation("docinfo"+relationLiId); 
	 }
}




//显示流程日志
function  showWorkFlowLog(id){

	var url="/defaultroot/platform/bpm/ezflow/operation/ezflow_log.jsp?p_wf_processInstanceId="+$("#p_wf_processInstanceId").val();
 
	var html = $.ajax({url: url,async: false,cache:false}).responseText;
 
	$("#"+id).html(html);
}

//显示相关附件
function  showWorkFlowAcc(id){
	$("#"+id).html("相关附件....");
}


/**
设置表单初始化js操作相关的信息
*/
function initWFFormToAjax(dialog_json){
     var  dataForm = dialog_json.dataForm;
	 var  queryForm = dialog_json.queryForm;
	 var  tip = dialog_json.tip;
	 var  title = dialog_json.title; 
	 var  callbackfunction=dialog_json.callbackfunction; 

	 if(dataForm!=undefined){
		 $("#p_wf_dataForm").val(dataForm);
	 }
	 if(queryForm!=undefined){
		 $("#p_wf_queryForm").val(queryForm);
	 }
	 if(callbackfunction!=undefined){
		 $("#callBackName").val(callbackfunction);
	 }
	 if(tip!=undefined){
		 $("#callBackTips").val(tip);
	 }
	 if(callbackfunction!=undefined){
		 $("#callBackTitle").val(callbackfunction);
	 }
}



/**
设置弹出对话框的标题
*/
function  setWf_dialog_title(title){
      $("#wf_dialog_title").val(title);
}

/**
  取弹出对话框的标题
*/
function  getWf_dialog_title(){
      return $("#wf_dialog_title").val();
}



/**
设置提交form 返回的时执行的js函数
*/
function setCallBackName(name){
     $("#callBackName").val(name);
}

/**
 取  提交form 返回的时执行的js函数名
*/
function getCallBackName(){
   return $("#callBackName").val();
}

function  getWFdataForm(){
	return $("#p_wf_dataForm").val();
}
function  setWFdataForm(name){
	$("#p_wf_dataForm").val(name);
}
function  getWFqueryForm(){
	return $("#p_wf_queryForm").val();
}
function  setWFqueryForm(name){
	$("#p_wf_queryForm").val(name);
}


var wfDapi;
/**
提交form 成功
*/
function  formSuccess(responseText){

	var dialog_title=getWf_dialog_title();
	if(dialog_title==""){
		//流程操作
		dialog_title=workflowMessage_js.processdeal;
	}


    var queryForm="queryForm";
	//提交的类型
	 //test(responseText);
	 var  backName=getCallBackName();
	 if(backName=="showPopup"){
		 //
         popup({id:'workflowDialog',title: dialog_title,fixed: true, left: '50%', top: '40%', padding: 0,drag: true, resize: true,max:true,autoSize:true,lock: true,content: responseText,init:function(){popupFormInit();}}); 
	 }else if(backName=="reshowPopup"){
	     //先关闭
	     $.dialog({id:'workflowDialog'}).close(); 
		 popup({id:'workflowDialog',title: dialog_title,fixed: true, left: '50%', top: '40%', padding: 0,drag: true, resize: true,max:false,autoSize:true,lock: true,content: responseText}); 
	 }else if(backName=="noCloseRefresh"){
		    //
		    var msg_json = eval("("+responseText+")");
			if(msg_json.result == "success"){
				   $.dialog.tips(workflowMessage_js.dealsuccess,1.5,'success.gif',function(){
					   //关闭弹出层
					   $.dialog({id:'workflowDialog'}).close(); 
				  });
			}else{
				if(msg_json.result=='failure'){
					whir_alert(workflowMessage_js.dealfailed,function(){});
				}else{
					whir_alert(msg_json.result,function(){ 
						$.dialog({id:'workflowDialog'}).close();
					});
				}
			}           

	 }else if(backName==""){
		    //
		    var msg_json = eval("("+responseText+")");
			if(msg_json.result == "success"){
				$.dialog.tips(workflowMessage_js.dealsuccess,1.5,'success.gif',function(){
					var p_wf_saveType_v=$("#p_wf_saveType").val();
					if(p_wf_saveType_v=="0"){
					    window.close();
					 }else{
					    $.dialog({id:'workflowDialog'}).close(); 
						resetDataFormById(getWFdataForm());
					 }
					  //来之首页
					 var portletSettingId_val=$("#portletSettingId").val();
					 if(portletSettingId_val!=null&&portletSettingId_val!=""&&portletSettingId_val!="null"&&portletSettingId_val!="NULL"){
						 if(window.opener){
							 try{
					            opener.refreshMod("", portletSettingId_val);
							 }catch(e){
							 }
						 }
					 }else{
                         try{
							 if(window.opener){
					             window.opener.refreshListForm_(getWFqueryForm());
						     }
						 }catch(e){ 
						 }
					 } 
				});
			}else{
			if(msg_json.result=='failure'){
				var  data=msg_json.data;
				if(data!=null&&data.errorCotent!=null&&data.errorCotent!=""){
					whir_alert(data.errorCotent,function(){}); 
				}else{
					whir_alert(workflowMessage_js.dealfailed,function(){});
				}
			}else{
				whir_alert(msg_json.result,function(){});
			}
			}           
	 }else{
	       eval(backName).call(eval(backName),responseText);  
	 }
	 

     //重置对话框标题
	 setWf_dialog_title("");
}
 

function  afterCompleteProcess(responseText){
    // 
	var msg_json = eval("("+responseText+")");
	if(msg_json.result == "success"){
		$.dialog.tips(workflowMessage_js.dealsuccess,1.5,'success.gif',function(){
			 //刷新父页面
			 //来之首页
			 var portletSettingId_val=$("#portletSettingId").val();
			 if(portletSettingId_val!=null&&portletSettingId_val!=""&&portletSettingId_val!="null"&&portletSettingId_val!="NULL"){
				 if(window.opener){
					  try{
					     opener.refreshMod("", portletSettingId_val);
					  }catch(e){
					  }
				 }
			 }else{
				 try{
					 if(window.opener){
						 window.opener.refreshListForm_(getWFqueryForm());
					 }
				 }catch(e){ 
				 }
			 } 

			var p_wf_saveType_v=$("#p_wf_saveType").val();
			if(p_wf_saveType_v=="0"){
				//window.close();
				var  data=msg_json.data;
				if(data.gdInfo!=null&&data.gdInfo!=""){
					location_href(data.href+"&gd=1");
				}else{
				   window.close();
				} 
			 }else{
				$.dialog({id:'workflowDialog'}).close(); 
			 }  	
		});
	}else{
		if(msg_json.result=='failure'){
			var  data=msg_json.data;
			if(data!=null&&data.errorCotent!=null&&data.errorCotent!=""){
				whir_alert(data.errorCotent,function(){}); 
			}else{
				whir_alert(workflowMessage_js.dealfailed,function(){});
			}  
		}else{
			whir_alert(msg_json.result,function(){});
		}
	}           
}
 
//验证表单的函数
function wf_checkBeforeJS(){
	var functionName=$("#p_wf_initPara").val();
	var result=false;
	try{
		//if($.isFunction(eval(""+functionName))){
		if(typeof(eval(""+functionName)) == 'function'){
		//if(typeof functionName == 'function'){
			 if(eval(functionName+"()")){
				 result=true;
			 }else{
				 result=false;
			 }
		}else{
			result=true;
		}
	}catch(e){
		result=true;
	}
    return result;
}
 
function  SaveFavorite(id){
   alert("SaveFavorite:"+id);
} 
function  initPara(){  
	var result=true;
	//alert($("#p_wf_recordId").val());
	//document.getElementById('outIframeId').contentWindow.gggg(); 
    return result;
}
 
function  parentSumbit(){
   $("#dataForm").submit();
}

/**
 表单提交前的检测
*/
function  ajaxFormBeforeSubmit(){
    var result=true;
	var actionUrl=$("#dataForm").attr("action");
	//发送窗口
	var showStartUrl=whirRootPath+"/ezflowoperate!startProcess_init.action";
	//办理窗口
	var showUpdate=whirRootPath+"/ezflowoperate!completeTask_init.action";
    //转办窗口
	var showTran=whirRootPath+"/ezflowbuttonevent!transferDeal_init.action";
    //保存草稿
	var saveDraft=whirRootPath+"/ezflowbuttonevent!saveDraft.action";

	var saveUrl="";
	var completeUrl="";
	var endUrl="";

	//if(actionUrl==showStartUrl||actionUrl==showUpdate||actionUrl==showTran){
	if(actionUrl==showStartUrl||actionUrl==showUpdate){
		//检测表单数据
	    if(!wf_checkBeforeJS()){
			result=false;
		}
	}
	if(actionUrl==showTran){
	   if(!wf_checkComment("0")){
		   result=false;
	   }	
	}
	return  result; 
}


function ezFlowinit(){	   
	windowWidth = window.screen.availWidth;
	windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight); 
	initRealtionNum();

    if($("#trigger1_auto").length>0){
	    $("#trigger1_auto").powerFloat();  
    } 
    if($("#trigger1").length>0){
	    //$("#trigger1").powerFloat({offsets :{x:0, y:135} }); 
		$("#trigger1").powerFloat(); 
    } 
}
var  pageisshowall=false;

function  judgePageIsShowAll(){
    return  pageisshowall;
}
function readyFun(){
   pageisshowall=true;
   //dialog打开
   $("#"+getWFdataForm()).ajaxForm({
	   beforeSubmit: function(formData, jqForm, optionss){
		   $("#callBackTips").val("");
		   if(!ajaxFormBeforeSubmit()){
			   return false;
		   }
		   showDIV();
	   },
	   success: function(responseText){ 
				 hiddenDIV(); 
				 if($("#callBackTips").val()!=""){
					 //
				     whir_confirm($("#callBackTips").val(), function (){ formSuccess(responseText);}) ;         
			     }else{
				     formSuccess(responseText);	
			     } 
				 
				},
	   error:   function (XMLHttpRequest, textStatus, errorThrown) {
				   hiddenDIV();
				   whir_alert(workflowMessage_js.completeException+"!",function(){});
				}
	});	
	
   //onbeforeunload  事件
   $(window).bind("beforeunload",function(){
	   //电子签章销毁
	  /* if(document.all.SignatureControl_w){
			document.all.SignatureControl_w.DeleteSignature();
	   }*/

	  /* //删除锁
	   $.ajax({
		  url: '/defaultroot/ezflow/operation/ezflow_myflow_ajax.jsp?businessKey='+$("#ezflowBusinessKey").val()+'&formKey='+$("#whir_formKey").val()+'&processInstanceId='+$("#processInstanceId").val()+'&taskId='+$("#taskId").val(),
		  async: false
		 });*/
	});
	
   //显示办理内容
   showDealtipsContent();
   //表单的初始化函数
   ezForminitATezFLOW(); 
   //等待层先隐藏
   hiddenDIV();
   $("#popToolbar").show();
}

//-------------------------

//按钮作废
function include_deleteSubmit(){
	 var url=whirRootPath+"/ezflowbuttonevent!abandonProcess.action"; 
	 $("#dataForm").attr("action",url);
	 setCallBackName("");
	 $("#dataForm").submit(); 
}



/**
保存草稿检测
*/
function  wfCheckBeforeSaveClose(){
   var result=true;
   if( wf_checkBeforeJS()){
        result=wf_checkComment("0");
   }else{
      return false;
   }
 
   return result;
}


function  wf_checkComment(type){
	var result=true;
	if(!setComment(type)){
		result=false;
		return false;
	}
	if(!include_saveSignature()){	
		//workflowMessage_js.includegoldlinkerror
		whir_alert("连接金格数据库失败！请与管理员联系！",function(){});
		result=false;
		return false;
	} 
	return result;
}
 


//按钮撤办
function include_undoSubmit(){
	 var url=whirRootPath+"/ezflowbuttonevent!recall.action"; 
	 $("#dataForm").attr("action",url);
	 setCallBackName("");
	 $("#dataForm").submit();  
}; 

/**
showPopup 的初始化事件。
*/
function popupFormInit(){
    
};




function changeSignTypeArr(type, i){
	var len =$("#commentSignType").length;
	if(len>1){
		if(type=='0'){
			if($("#signTb1").length >0){
                $("#signTb1")[i].show();
			}
			if($("#signTb2").length >0){
				$("#signTb2")[i].hide();
			}
			if($("#signTb3").length >0){
				$("#signTb3")[i].hide();
			}
		} else if(type=='1'){
			if($("#signTb1").length >0){
                $("#signTb1")[i].hide();
			}
			if($("#signTb2").length >0){
				$("#signTb2")[i].show();
			}
			if($("#signTb3").length >0){
				$("#signTb3")[i].hide();
			}
		} else if(type=='2'){
			if($("#signTb1").length >0){
                $("#signTb1")[i].hide();
			}
			if($("#signTb2").length >0){
				$("#signTb2")[i].hide();
			}
			if($("#signTb3").length >0){
				$("#signTb3")[i].show();
			}
		}

		$("#commentSignType")[i].value=type;
		$("#commentSignIndex")[i].value=type;
 
		
		//判断电子签章选项
		if($("#signTb2").length <=0&& type=='2'){
			$("#commentSignIndex")[i].value=1; 
		}
	} else{
		changeSignType_w(type);
	}
};

function changeSignType_w(type){
	if(type=='0'){
	    if($("#signTb1").length >0){
			$("#signTb1").show();
		}
		if($("#signTb2").length >0){
			$("#signTb2").hide();
		}
		if($("#signTb3").length >0){
			$("#signTb3").hide();
		} 
	} else if(type=='1'){
		if($("#signTb1").length >0){
			$("#signTb1").hide();
		}
		if($("#signTb2").length >0){
			$("#signTb2").show();
		}
		if($("#signTb3").length >0){
			$("#signTb3").hide();
		} 
	} else if(type=='2'){
		 if($("#signTb1").length >0){
			$("#signTb1").hide();
		}
		if($("#signTb2").length >0){
			$("#signTb2").hide();
		}
		if($("#signTb3").length >0){
			$("#signTb3").show();
		} 
	}
	$("#commentSignType").val(type);
	$("#commentSignIndex").val(type); 

	//判断电子签章选项
	if($("#signTb2").length<=0&& type=='2'){
		$("#commentSignIndex").val(1); 
	}
};
function changeSignature(name,type){
    var obj=document.getElementsByName(name);
			//alert(name);
	if(obj.EditType== 0){
        	//手写变键盘
			obj.EditType=1;
        	//eval("document.all."+name).EditType = 1;
			document.getElementsByName("signatureHref"+name).innerHTML="切换手写";
            //eval("document.all.signatureHref"+name).innerHTML = "切换手写";
        }else{
        	//键盘变手写
			obj.EditType=0;
			document.getElementsByName("signatureHref"+name).innerHTML="切换键盘";
        }
};



function include_offiDict(userId, field){
    window.open(whirRootPath+'/work_flow/workflow_offiDict.jsp?userId=' + userId + '&textAreaName=' + field,'','menubar=0,scrollbars=yes,locations=0,width=400,height=200,resizable=yes');
}

/**
设置批示意见框里的值
*/
function include_set_comment(obj,commentName){
	var val=$(obj).text();
    var  cobj=document.getElementById(commentName);
	if(cobj.length){
        cobj[0].value=cobj[0].value+val;
	} else{
		cobj.value=cobj.value+val;
	}
}
/**
新加常用语
*/
function  addOffical(){
	//
    var openurl=whirRootPath+'/OfficalDictionAction!addOfficalDiction.action';
    openWin({url:openurl,width:600,height:300,winName:''});
}

/**
管理常用语
*/
function  manangerOffical(){
    var openurl=whirRootPath+'/OfficalDictionAction!OfficalDictionList.action';
    openWin({url:openurl,width:800,height:600,winName:''});
}
  
function addDivContent(){
	var adddivcontent=$("#addDivContent").val();
	var comment=document.getElementById("noteDiv").getAttribute("value");
	document.getElementById("noteDiv").innerHTML= ""+"<div class='divOut' onmouseover='this.className=\"divOver\"' onmouseout='this.className=\"divOut\"' onclick=\"include_set_comment(this,\'"+comment+"\');\">"+adddivcontent+"<\/div>"+document.getElementById("noteDiv").innerHTML;
}

//电子签章
var wnd;

//作用：进行甲方签章
function include_signature(s_protectField_w,s_inc_divId_w) {
	if( wnd != undefined ){
		var results = wnd.split(";");
		$("#SignatureControl_w")[0].CharSetName = results[0];		//多语言集
		$("#SignatureControl_w")[0].WebAutoSign = results[1];		//自动数字签名
		$("#SignatureControl_w")[0].WebCancelOrder = results[2];		//撤消顺序
		$("#SignatureControl_w")[0].PassWord = results[3];			//签章密码
		var tmp = $("#SignatureControl_w")[0].WebSetFontOther((results[4]=="1"?true:false),results[5],results[6],results[7],results[8],results[9],(results[10]=="1"?true:false));				//设置签章附加文字格式
		$("#SignatureControl_w")[0].WebIsProtect=results[11];		//保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
    }else{
		$("#SignatureControl_w")[0].WebIsProtect=1;			    //保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
 	}
	var mXml = "<?xml version='1.0' encoding='GB2312' standalone='yes'?>";
    mXml = mXml + "  <Signature>";
    mXml = mXml + "    <OtherParam>";
    mXml = mXml + "	    <RemberFontOther>1</RemberFontOther>"; 
    mXml = mXml + "    </OtherParam>"; 
    mXml = mXml + "	    <RememberPassword>true</RememberPassword>";//是否自动记忆密码  mXml = mXml + "    </OtherParam>";
    mXml = mXml + "  </Signature>";
    $("#SignatureControl_w")[0].XmlConfigParam = mXml;
	$("#SignatureControl_w")[0].FieldsList=s_protectField_w;       //所保护字段
	$("#SignatureControl_w")[0].DivId="signPosi_"+s_inc_divId_w+"0000";                     //签章所在的层
	$("#SignatureControl_w")[0].Position(100,0);                     //签章位置
	$("#SignatureControl_w")[0].SaveHistory="False";                    //是否自动保存历史记录,true保存  false不保存  默认值false
	$("#SignatureControl_w")[0].UserName="lyj";                         //文件版签章用户
	$("#SignatureControl_w")[0].WebCancelOrder=1;			    //签章撤消原则设置, 0无顺序 1先进后出  2先进先出  默认值0
	$("#SignatureControl_w")[0].WebSetFontOther(false,"","1","宋体",11,"$000000","False");//设置签章样式
	$("#SignatureControl_w")[0].RunSignature();                          //执行签章操作
}

//作用：进行手写签名
function include_signature2(s_protectField_w,s_inc_divId_w) {
	$("#SignatureControl_w")[0].FieldsList=""       //所保护字段
	if( wnd != undefined ){
		var results = wnd.split(";");
		$("#SignatureControl_w")[0].CharSetName = results[0];		//多语言集
		$("#SignatureControl_w")[0].WebAutoSign = results[1];		//自动数字签名
		$("#SignatureControl_w")[0].WebCancelOrder = results[2];		//撤消顺序
		$("#SignatureControl_w")[0].PassWord = results[3];			//签章密码
		$("#SignatureControl_w")[0].WebIsProtect=results[11];		//保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1
	}else {
        $("#SignatureControl_w")[0].WebCancelOrder=0;			            //签章撤消原则设置, 0无顺序 1先进后出  2先进先出  默认值0
		$("#SignatureControl_w")[0].WebIsProtect=1;			    //保护表单数据， 0不保护  1保护表单数据，可操作  2保存表单数据，并不能操作  默认值1 
	}
	var mXml = "<?xml version='1.0' encoding='GB2312' standalone='yes'?>";
    mXml = mXml + "  <Signature>";
    mXml = mXml + "    <OtherParam>";
    mXml = mXml + "	    <RemberFontOther>1</RemberFontOther>"; 
    mXml = mXml + "    </OtherParam>"; 
    mXml = mXml + "	    <RememberPassword>true</RememberPassword>";//是否自动记忆密码  mXml = mXml + "    </OtherParam>";
    mXml = mXml + "  </Signature>";
    $("#SignatureControl_w")[0].XmlConfigParam = mXml;
	$("#SignatureControl_w")[0].FieldsList=s_protectField_w;      //所保护字段
	$("#SignatureControl_w")[0].DivId="signPosi_"+s_inc_divId_w+"0000";                   //签章所在的层
	$("#SignatureControl_w")[0].Position(0,0);                       //手写签名位置

	//$("#SignatureControl_w")[0].SaveHistory="false";                   //是否自动保存历史记录,true保存  false不保存  默认值false
	$("#SignatureControl_w")[0].RunHandWrite();                          //执行手写签名
}
/*
选择批示意见范围
*/
function  chooseCommentRanger(s_whir_commentRangeId){
   openSelect({allowId:'ru_commentRangeEmpId', allowName:'ru_commentRangeEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:s_whir_commentRangeId,showSidelineorg:'0'});
}

function lockedNote_w(){
 
}
function setNote_w(obj){
} 
//alert($(".doc_Scroll").scrollTop());
// 给 常用语添加 弹出层
 // $("#trigger1").powerFloat();  
 // 给 常用语添加 弹出层
 //$("#trigger1").powerFloat({offsets :{x:-280, y:-30} });
 