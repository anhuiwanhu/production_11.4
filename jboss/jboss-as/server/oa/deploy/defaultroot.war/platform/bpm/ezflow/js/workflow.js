 /**
 流程发起  cmdEzFlowStartProcess
 */
 function  cmdSend(){ 

	 if(!judgePageIsShowAll()){
		  whir_alert(workflowMessage_js.waitingload,function(){});
		  return false;
	 }

     $("#dataForm").attr("action",whirRootPath+"/ezflowoperate!startProcess_init.action");
     //$("#submitFormType").val("showPopup");
     setCallBackName("showPopup");
     setWf_dialog_title(workflowMessage_js.startProcess);
     $("#p_wf_dealWithJob").val("0");
     $("#dataForm").submit();
}
//判断是否是批量发起
function  judgeIsBatch(){
	//fff batchSendUserIds 
	var length=$("input[name='batchSendUserIds']").length;
	if(length>0){
		return true;
	}
	return false;

}
//定时发送 
function  cmdEzFlowJobStart(){
   if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
   }
   if(judgeIsBatch()){
	   whir_alert("表单中设置了“流程发起人（批量发起）”字段，不支持定时发送。",function(){});
       return false;
   }
   $("#dataForm").attr("action",whirRootPath+"/ezflowoperate!startProcess_init.action");
   //$("#submitFormType").val("showPopup");
   setCallBackName("showPopup");
   setWf_dialog_title(workflowMessage_js.startProcess);
   $("#p_wf_dealWithJob").val("1");
   $("#dataForm").submit();
}



/**
保存草稿
*/
function cmdEzFlowSaveDraft(){ 
	 if(judgeIsBatch()){
	   whir_alert("表单中设置了“流程发起人（批量发起）”字段，不支持保存草稿。",function(){});
       return false;
     }
	 var url=whirRootPath+"/ezflowbuttonevent!saveDraft.action"; 
	 $("#dataForm").attr("action",url);
	 setCallBackName("");
	 setHtmlValue();
	 $("#dataForm").submit();  

}

/**
  办理任务
 */
function  cmdCompleteTask(){
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
	//if($("#p_wf_openType").val()=="waitingRead"){
	if(false){
		completeRead();
	}else{
		//设置批示意见等
		if(initCommentAndAccessory()){
			$("#dataForm").attr("action",whirRootPath+"/ezflowoperate!completeTask_init.action");
			setCallBackName("showPopup");
			setWf_dialog_title(workflowMessage_js.completetask);
			$("#dataForm").submit();
		}
	}   
}


 
/**
 关联流程
 */
function cmdRelation(){
    
	 refreshRelation();
     var url=whirRootPath+"/wfdealwith!dealwithList.action?openType=relation&relation=1";
	 //var processId=$("#p_wf_processId").val(); 
	 var recordId=$("#p_wf_recordId").val();
	 var moduleId=$("#p_wf_moduleId").val();
	 if(recordId==""||recordId=="null"){
		 recordId="-1";
	 }
	 url+="&rmoduleId="+moduleId+"&rrecordId="+recordId;   
	 popup({id:'relation',title:  workflowMessage_js.Relatedworkflow,fixed: true, width:'95%',height:'580px',top: '10%',autoSize:true,padding: 0,drag: true,lock: true,content: 'url:'+url}); 
 
     /*refreshRelation();
     var url=whirRootPath+"/ezflowdealwith!dealList.action?openType=relation";
	 var openType=$("#p_wf_openType").val(); 	 
	 //重新发起  在此发起 
	 if(openType=="reStart"||openType=="startAgain"){
	 }else{
		 url+="&n_processInstanceId="+$("#p_wf_processInstanceId").val();
	 } 
	 popup({id:'relation',title: workflowMessage_js.Relatedworkflow,fixed: true,width:'95%',height:'580px', top: '10%', autoSize:true,padding: 0,drag: true,lock: true,content: 'url:'+url}); 
     */
}


/**
退回
*/
function cmdBack(){
	 var url=whirRootPath+"/ezflowbuttonevent!back_init.action?";
    	// p_wf_isForkTask p_wf_workStatus p_wf_stepCount p_wf_tableId  p_wf_recordId
		// p_wf_forkStepCount p_wf_forkId p_wf_cur_activityId
     var para="p_wf_taskId="+$("#p_wf_taskId").val()+"&p_wf_processInstanceId="+$("#p_wf_processInstanceId").val()+
		      "&p_wf_superProcessInstanceId="+$("#p_wf_superProcessInstanceId").val();
	 url=url+para;
	 //'视窗11',width:'640px',height:'400px'
	 popup({id:'workflowDialog',title:  workflowMessage_js.newactivitybuttonback,width:'620px',height:'360px',fixed: true, autoSize:true,padding: 0,drag: true,lock: true,resize: true,content: 'url:'+url}); 
}




//作废
function cmdDelete(){
  whir_confirm(workflowMessage_js.includeconfirmdelete,  function(){include_deleteSubmit();});
}


//撤办
function cmdUndo(){
   whir_confirm(workflowMessage_js.includeconfirmundo,  function(){include_undoSubmit();});
}
 


/**
 打印
*/
function cmdPrint(){
	var  fkey=$("#p_wf_formKey_act").val(); 
    if(fkey==null||fkey==""){
        fkey=$("#p_wf_formKey").val();
	}
	var url=whirRootPath+"/PrintEzForm!printEzForm.action?p_wf_formKey="+fkey
	   +"&p_wf_recordId="+$("#p_wf_recordId").val()
	   +"&p_wf_processInstanceId="+$("#p_wf_processInstanceId").val()+"&p_wf_formKey_act="+fkey
	   +"&p_wf_commentSortType="+$("#p_wf_commentSortType").val()+"&p_wf_openType=print";
 
	openWin({url:url,width:850,height:750,winName:'printEzFlow'});  
	var para="?p_wf_processInstanceId="+$("#p_wf_processInstanceId").val(); 
	//更新打印次数
	var ajaxurl=whirRootPath+"/ezflowopen!updatePrint.action";
	ajaxurl=ajaxurl+para+"&type=update";

	var responseText = $.ajax({url: ajaxurl,async: false,cache:false}).responseText;
	var msg_json = eval("("+responseText+")");
	var judegeresult=msg_json.result; 
	if(judegeresult==null||judegeresult==""||judegeresult=="null"){
		judegeresult="0";
	} 
	$("#viewPrintNum").html(judegeresult);
}

//显示打印次数
function  viewPrint(){
	if($("#p_wf_processInstanceId").val()!=null&&$("#p_wf_processInstanceId").val()!=""){
		var para="?p_wf_processInstanceId="+$("#p_wf_processInstanceId").val(); 
		//更新打印次数
		var ajaxurl=whirRootPath+"/ezflowopen!updatePrint.action";
		ajaxurl=ajaxurl+para+"&type=view";
 
		var responseText = $.ajax({url: ajaxurl,async: false,cache:false}).responseText;
		var msg_json = eval("("+responseText+")");
        var judegeresult=msg_json.result; 
		if(judegeresult==null||judegeresult==""||judegeresult=="null"){
			judegeresult="0";
		} 
		$("#viewPrintNum").html(judegeresult);
	}

}
 
 

//加签
function cmdAddSign(){
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
    $("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!addSign_init.action");
   //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.addsign);
    $("#dataForm").submit();
}


//转办
function cmdTran(){
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
	$("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!transferDeal_init.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.newactivitybuttontran);
    $("#dataForm").submit();

}


//阅件
function cmdSelfsend(){
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
	$("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!sendRead_init.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title(workflowMessage_js.f_review);
    $("#dataForm").submit();
}




//转阅
function cmdTranRead(){
	 if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
     }
	 $("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!tranRead_init.action");
     //$("#submitFormType").val("showPopup");
     setCallBackName("showPopup");
	 setWf_dialog_title(workflowMessage_js.newactivitybuttontransferforreview);
     $("#dataForm").submit();
}



 
/**
  反馈按钮， 取反馈标题， 再调用showFeedBack 弹出反馈页面
*/
function cmdFeedback(){
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
    $("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!ajaxInitFeedBackTitle.action");
	setCallBackName("showFeedBack");
    $("#dataForm").submit();
} 
/**
弹出反馈页面
*/
function showFeedBack(responseText){
	var msg_json = eval("("+responseText+")");
    var result=msg_json.result;
    var url=whirRootPath+"/ezflowbuttonevent!feedback_init.action"; 
	url+="?button_remindTitle="+encodeURI(result);
    url+="&p_wf_processInstanceId="+$("#p_wf_processInstanceId").val();
	url+="&p_wf_msgFrom="+encodeURI($("#p_wf_msgFrom").val());

	url+="&p_wf_submitUserAccount="+encodeURI($("#p_wf_submitUserAccount").val());

	popup({id:'workflowDialog',title: workflowMessage_js.newactivitybuttonfeedback,fixed: true, left: '50%', top: '40%',
		 width:'590px',height:'450px', drag: true, resize: true,lock: true,content: "url:"+url}); 
}


//收回
function cmdReturn(){ 
	var url=whirRootPath+"/ezflowbuttonevent!drawBack_init.action?p_wf_processInstanceId="+$("#p_wf_processInstanceId").val();
	popup({id:'workflowDialog',title: workflowMessage_js.newactivitybuttonreturn,fixed: true, left: '50%', top: '40%',
		 width:'500px',height:'280px', drag: true, resize: true,lock: true,content: "url:"+url}); 
} 


 

//取消
function cmdCancel(){
	 var url=whirRootPath+"/ezflowbuttonevent!showCancel.action";
	 popup({id:'workflowDialog',title:  workflowMessage_js.i_newinfocancel,fixed: true, left: '50%', top: '40%',  width:'540px',height:'258px', drag: true, resize: true,lock: true,content: "url:"+url}); 
} 

//新建流程
function cmdAddNew(){
 
    //var url=whirRootPath+"/ezflowcanstart!newAdd.action?moduleId=1&relationProcessInstanceId="+$("#p_wf_processInstanceId").val();
    var url=whirRootPath+"/bpmscope!canStart.action?myCommon=0&moduleId=1&rmoduleId="+$("#p_wf_moduleId").val()
		 +"&rrecordId="+$("#p_wf_recordId").val(); 
	popup({id:'workflowDialog',title: workflowMessage_js.i_newProcess,fixed: true,width:'800px',height:'600px', left: '50%', top: '10%', padding: 0,drag: true, resize: true,lock: true,content: 'url:'+url}); 
 
}


//催办
function cmdWait(){ 
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
	$("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!ajaxInitPressTitle.action");
	setCallBackName("showWait");
    $("#dataForm").submit();
 	
} 


//打开催办页面
function showWait(responseText){
	var msg_json = eval("("+responseText+")");
    var result=msg_json.result;
	var url=whirRootPath+"/ezflowbuttonevent!press_init.action";
	url+="?button_remindTitle="+encodeURI(result);
    url+="&p_wf_processInstanceId="+$("#p_wf_processInstanceId").val();
	url+="&p_wf_msgFrom="+encodeURI($("#p_wf_msgFrom").val());
	popup({id:'workflowDialog',title:  workflowMessage_js.newactivitybuttonwait,fixed: true, left: '50%', top: '40%',
		 width:'610px',height:'430px', drag: true, resize: true,lock: true,content: "url:"+url}); 
}


//邮件转发
function cmdEmailSend(){
	//
    var url=whirRootPath+"/ezflowbuttonevent!tranWithMail_init.action";
    popup({id:'workflowDialog',title:  workflowMessage_js.i_emailSend,fixed: true, left: '50%', top: '40%',
		 width:'615px',height:'380px', drag: true, resize: true,lock: true,content: "url:"+url}); 
} 

//保存退出
function cmdSaveclose(){
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
    //保存前检测  
	 if(initCommentAndAccessory()&&wf_checkBeforeJS()){
		$("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!saveClose.action");
		setCallBackName("");
		$("#dataForm").submit();
	 }
} 
 
  
//撤销转办
function  cmdCancelTran(){   
    whir_confirm("您确定撤销转办？",  function(){include_CancelTran();}); 
} 


  
//补签
function  cmdEdAddSign(){  
	if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }
   $("#dataForm").attr("action",whirRootPath+"/ezflowbuttonevent!edAddSign_init.action");
    //$("#submitFormType").val("showPopup");
    setCallBackName("showPopup");
	setWf_dialog_title("补签");
    $("#dataForm").submit();
} 


//按钮撤办
function include_CancelTran(){
	 if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
     }
	 var url=whirRootPath+"/ezflowbuttonevent!cancelTran.action"; 
	 $("#dataForm").attr("action",url);
	 setCallBackName("");
	 $("#dataForm").submit();  
} 



//设置流程
function cmdSetProcess(){
	var src=whirRootPath+"/platform/bpm/ezflow/graph/jsp/updateprocess.jsp?recordId=&subType=0&moduleId="+$("#p_wf_moduleId").val();
	src+="&processDefId="+$("#p_wf_processId").val();
	//window.open(src,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=920,height=800');
	openWin({url:src,width:1185,height:780,scrollbars:'yes',resizable:'yes',winName:''}); 
} 

//跳转
function cmdFreeJump(){
     if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
     }
	 var url=whirRootPath+"/ezflowoperate!showJumpActs.action"; 
	 $("#dataForm").attr("action",url);
	 setCallBackName("showPopup");
	 $("#dataForm").submit();
}

//同步到信息
function  cmdSynToInfo(){
    /* var $form = $('#syntoInfoFormId');
    if ($form.length > 0) {
        $form.remove();
    } 
	var pname=$("#p_wf_processName").val();
	var _content="<a  href='"+$("#p_wf_mailviewUrl").val()+"\'  target='_blank' >"+pname+"<a>"; 
	var _moduleId="";
	var _recordid="";
    var  contents = "<input  type=\"hidden\"   name=\"userDefine\"  value=\"0\" > ";
	contents += "<input  type=\"hidden\"   name=\"channelType\"  value=\"0\" > ";
	contents += "<input  type=\"hidden\"   name=\"_title\"  value=\""+pname+"\" > ";
	contents += "<input  type=\"hidden\"   name=\"_type\"  value=\"1\" > ";
	contents += "<input  type=\"hidden\"   name=\"_content\"  value=\""+_content+"\" > ";
	contents += "<input  type=\"hidden\"   name=\"_moduleId\"  value=\""+_moduleId+"\" > ";
	contents += "<input  type=\"hidden\"   name=\"_fileId\"  value=\""+_recordid+"\" > ";
	contents += "<input  type=\"hidden\"   name=\"informationType\"  value=\"1\" > ";
	contents += "<input  type=\"hidden\"   name=\"module\"  value=\"2\" > "; 
    $form = $('<form id="syntoInfoFormId" name="syntoInfoFormId" action="'+whirRootPath+'/Information!add.action" method="get" target="_blank" enctype="application/x-www-form-urlencoded" />');	
 
	$(contents).appendTo($form); 
    var dest = 'body';
    $form.appendTo(dest);
    $form[0].submit();*/ 
	
    if(!judgePageIsShowAll()){
	    whir_alert(workflowMessage_js.waitingload,function(){});
	    return false;
    }

    var _moduleId=$("#p_wf_moduleId").val();
	var _recordid=$("#p_wf_recordId").val(); 

    var url=whirRootPath+"/platform/bpm/ezflow/operation/ezflow_judge_syninfo.jsp?p_wf_moduleId="+_moduleId+"&p_wf_recordId="+_recordid;
	 
    var result = $.ajax({url: url,async: false}).responseText;
	if(result=="1"){
		  whir_alert("此流程已同步到信息，不能重复同步！",function(){});
	      return false;
	} 

	var pname=$("#p_wf_processName").val();
	//收文
	if(_moduleId == 3 && $("[name = 'receiveFileTitle']")){
		pname = $("[name = 'receiveFileTitle']").val();
	}
	//发文
	else if(_moduleId == 2 && $("[name = 'documentSendFileTitle']")){
		pname = $("[name = 'documentSendFileTitle']").val();
	}
	//送审签
	else if(_moduleId ==  34 && $("[name = 'sendFileCheckTitle']")){
		pname = $("[name = 'sendFileCheckTitle']").val();
	}
	//var _content="<a  href='"+$("#p_wf_mailviewUrl").val()+"\'  target='_blank' >"+pname+"<a>"; 
	var _content = "";
	if(_moduleId =='3' || _moduleId =='2' || _moduleId =='34'){
		if($("input[name='content']") && $("input[name='content']").length >0){
			_content = $("input[name='content']").val();
		}
	}else{
		_content="<a  href=\'"+$("#p_wf_mailviewUrl").val()+"\'  target='_blank' >"+pname+"<a>";
	}

	var mianUrl ="";
	if(_moduleId =='3' || _moduleId =='2' || _moduleId =='34'){
		mianUrl=whirRootPath+'/Information!add.action?userDefine=0&channelType=0&_type=4&module=0'+
					'&_title='+encodeURIComponent(pname)+'&_moduleId='+_moduleId+'&_fileId='+_recordid+'&_content='+encodeURIComponent(_content);
	}else{
		mianUrl=whirRootPath+'/Information!add.action?userDefine=0channelType=0&_type=1&informationType=1&module=2'+
				'&_title='+encodeURIComponent(pname)+'&_moduleId='+_moduleId+'&_fileId='+_recordid+'&_content='+encodeURIComponent(_content);
	}
	
	if($("#accessoryName") && $("#accessorySaveName") && $("#accessoryName").val() !=undefined && $("#accessorySaveName").val() !=undefined){
		var _accessName = $("#accessoryName").val();
		var _accessSaveName = $("#accessorySaveName").val();
		mianUrl	 += "&_accessName="+_accessName+"&_accessSaveName="+_accessSaveName;
	}
    wf_openWin({url:mianUrl,width:850,height:750,isFull:true,winName:'printEzFlow'}); 
}
 

function wf_openWin(winJson) {
    var winJson_ = {
        url: winJson.url || '',					
        isPost: winJson.isPost || true,     			
        isFull: winJson.isFull || false,	     		
        width:  winJson.width || 300,				
        height: winJson.height || 150,				
        isScroll: winJson.isScroll || 'yes',				
        isResizable: winJson.isResizable || 'yes',			
        winName: winJson.winName || ('w'+Math.round(Math.random()*100000))
    };

    if(isSurface()){//ms pad
        if(winJson.height){
            if(winJson.height >= 600){
                winJson_.isFull = true;
            }
        }
    }

    var wn = winJson_.winName;
    if(wn.length>20){
        wn = wn.substring(0,20);
        winJson_.winName = wn ;
    }

    if(winJson_.isFull){
        winJson_.width  = screen.availWidth;
        winJson_.height = screen.availHeight;
    }
    var l = (screen.availWidth - winJson_.width) / 2;
    var t = (screen.availHeight - winJson_.height) / 2;

    if(!winJson_.isFull){
        if(whir_browser=='firefox' || whir_browser=='chrome' || whir_browser=='opera' ){
            winJson_.height = (winJson_.height)-15 ;
        }else if(whir_browser=='safari' ){
            winJson_.height = (winJson_.height) - 100 ;
        }else if( whir_agent.indexOf("MSIE 10")>=0 ){
            winJson_.height = (winJson_.height) + 30 ;
        }else if( whir_agent.indexOf("MSIE 11")>=0 ){
            winJson_.height = (winJson_.height) + 30 ;
        }else{
            winJson_.height = (winJson_.height) + 60 ;
        }
    }else{
    }

    var s = 'width=' + winJson_.width + ', height=' + winJson_.height + ', top=' + t + ', left=' + l;
    s += ', toolbar=no, scrollbars='+winJson_.isScroll+', menubar=no, locations=0,location=no, status=no, status=0,resizable='+winJson_.isResizable;
    if(winJson_.isPost){
        if (window.attachEvent){ //ie,360兼容模式（其实是当前系统上装的ie浏览器对应的版本）
            wf_UTFWindowOpen(winJson_.url, winJson_.winName, s, l, t, winJson_.width, winJson_.height, winJson_.isFull);
        }else{
            wf_whir_openWindow(winJson_.url, winJson_.winName, s, l, t, winJson_.width, winJson_.height, winJson_);
        }
    }else{
        window.open(encodeURI(winJson_.url), winJson_.winName, s);
    }
}

function wf_whir_openWindow(url, name, features, l, t, width, height, winJson_) {
    var targeturl = url;
    var newwin = window.open("", name, features);
    if( (whir_browser == 'chrome' || whir_agent.indexOf("MSIE 10")>=0 || whir_browser=='safari' ) && winJson_.isFull){
        newwin.moveTo(l, t);
        newwin.resizeTo(width, height);
    }
    targeturl = targeturl.replace(/#/,'%23');
    newwin.location = targeturl;
} 

//被openWin方法调用
function wf_UTFWindowOpen(sURL, winName, features, l, t, width, height, isFull) { 
    var oW;
    var contents = "";
    var mainUrl  = ""; 
    if(sURL.indexOf("?") > 0){
        var arrayParams = sURL.split("?");
        var arrayURLParams = arrayParams[1].split("&");
        mainUrl = arrayParams[0];
        for (var i = 0, len=arrayURLParams.length; i < len; i++){
            var sParam = arrayURLParams[i].split("=");
            if ((sParam[0] != "") && (sParam[1] != "")){
                contents += "<input type=\"hidden\" name=\""+sParam[0] +"\" value=\""+decodeURIComponent(sParam[1])+"\"/>";
            }else if (sParam[0] != "" && sParam[1] == ""){
                contents += "<input type=\"hidden\" name=\""+sParam[0] +"\" value=\"\"/>";
            }
        }
    }else{
        mainUrl=sURL;
    }

    oW = window.open('', winName, features);
    oW.document.open();
    oW.document.write('<form name="postform" id="postform" action="'+mainUrl+'" method="post" accept-charset="utf-8">'+contents+'</form><script type="text/javascript">document.getElementById("postform").submit();</script>');
    oW.document.close();
    //$("#postform", oW.document).submit();

    oW.moveTo(l, t);
    oW.resizeTo(width, height);
}
