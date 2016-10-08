

var noteTimer=null;

function myBrowser(){
	var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
	var isOpera = userAgent.indexOf("Opera") > -1;

	if (isOpera){return "Opera"}; //判断是否Opera浏览器
	if (userAgent.indexOf("Firefox") > -1){return "FF";} //判断是否Firefox浏览器
	if (userAgent.indexOf("Safari") > -1){return "Safari";} //判断是否Safari浏览器
	if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera){return "IE";} ; //判断是否IE浏览器
}


function getNote(index,e){

	 var xx = e.originalEvent.x || e.originalEvent.layerX || 0; 
	 var yy = e.originalEvent.y || e.originalEvent.layerY || 0 ; 


	 var sTop=document.getElementById("mainContent").scrollTop;
	 var sLeft=document.getElementById("mainContent").scrollLeft ;

	if(myBrowser()=="Safari" || myBrowser()=="Opera"){sTop=sTop-40;sLeft=sLeft;}else if(myBrowser()!="IE"){sTop = 0;sLeft=0;} else{sTop =sTop-40;;sLeft=sLeft;}

	var noteDiv="noteDiv_"+index;

// if(myBrowser()!="IE"){
	 $("#"+noteDiv+"").css("float","right");
	 $("#"+noteDiv+"").css("left",xx-200 + sLeft);
	 $("#"+noteDiv+"").css("top",yy　+　sTop 　);
	 $("#"+noteDiv+"").css("display","inline");
 /*}else{
	  var d=document.getElementById(noteDiv);
	  d.style.left=event.x-200;
	// alert(xx);
	  d.style.left=xx;
	  d.style.top=yy;
	  d.style.top=event.y+sTop-30;
	  d.style.top=event.y-30;
	  d.style.display="inline";
 }*/
}
function hiddenNote(dd){
	var dealFunct="closeNote('"+dd+"')";
  noteTimer=window.setTimeout(dealFunct,500);
}
function closeNote(dd){
	  var noteDiv="noteDiv_"+dd;
  var d=document.getElementById(noteDiv);
  d.style.display="none";
}
function lockedNote(){
  window.clearTimeout(noteTimer);
}
function setNote(obj,dd){
	document.getElementById(dd).value+=obj.innerText;
}
function setNoteExt(obj,dd,ddId,issueUnitName,issueUnitID){

	issueUnitID = '~' + issueUnitID + '~';
	var nameValue = document.getElementById(dd).value;
	var idValue = document.getElementById(ddId).value;
	if(obj.checked){
		nameValue +=issueUnitName + ',';
		idValue += issueUnitID + '';
	}else{
		var idIndex =idValue.indexOf(issueUnitID);
		var idLen = issueUnitID.length;
		var idPre = idValue.substring(0,idIndex);
		var idSuf = idValue.substring((idIndex + idLen)+1);

		idValue = idPre + idSuf;

		var nameIndex = nameValue.indexOf(issueUnitName);
		var nameLen = issueUnitName.length;
		var namePre = nameValue.substring(0,nameIndex);
		var nameSub = nameValue.substring((nameIndex+nameLen)+1);
		
		nameValue = namePre + nameSub;
	}
	document.getElementById(dd).value = nameValue;
	document.getElementById(ddId).value = idValue;
	
	//document.getElementById(dd).value+=obj.innerText;
}



//检查页面参数有效性
function initPara() {
	  if($("input[name='documentSendFileTitle']")[0].value==""){
		  whir_alert("标题不能为空！",function(){$("input[name='documentSendFileTitle']").focus()});
		  return false;
	  }
	  if($("input[name='documentSendFileTitle']")[0].value.indexOf("#")>=0){
		  whir_alert("标题不能含'#'",function(){$("input[name='documentSendFileTitle']").focus()});
		  return false;
	  }
	   if($("input[name='documentSendFileTitle']")[0].value.indexOf("&")>=0){
		  whir_alert("标题不能含'&'",function(){$("input[name='documentSendFileTitle']").focus()});
		  return false;
	  }
	  if($("input[name='documentSendFileTitle']")[0].value.indexOf("'")>=0){
		  whir_alert("标题不能含'",function(){$("input[name='documentSendFileTitle']").focus()});
		  return false;
	  }
	  if($("input[name='documentSendFileTitle']")[0].value.indexOf("\"")>=0){
		  whir_alert("标题不能含\"",function(){$("input[name='documentSendFileTitle']").focus()});
		  return false;
	  }
	 // if(!judgeSpword()){
		//return false;
	  //}

	 //if(!isPhone(document.all.field10)){
	  // return false;
	 // }
	  
	
	
	if( $("input[name='documentSendFilePrintNumber']").length > 0 && $("input[name='documentSendFilePrintNumber']")[0].value != "" ){
		 
		 var ex = /^\d+$/;
		if (ex.test(  $("input[name='documentSendFilePrintNumber']")[0].value  )) {
		   // 则为整数
		}else{
			alert("共印必须是整数");
			return false;
		}

		 
		
	}
	//alert(1);
	//toPerson1
	if( document.getElementsByName("field4").length > 0 && document.getElementsByName("field4")[0].value.length >20 ){
			alert("备用字段4长度不能超过20！");
			document.getElementsByName("field4")[0].focus();
			return false;
	}
	if( $("#toPerson1").val() && $("#toPerson1").val().length >1200 ){
			alert("主送长度不能超过1200！");
			return false;
	}
	if( $("#toPerson2").val() && $("#toPerson2").val().length >1200 ){
			alert("抄送长度不能超过1200！");
			return false;
	}
	
	if( $("#toPersonInner").val() && $("#toPersonInner").val().length >1200 ){
			alert("主送长度不能超过1200！");
			return false;
	}
	if( $("#toPersonBao").val() && $("#toPersonBao").val().length >1200 ){
			alert("抄送长度不能超过1200！");
			return false;
	}
	if( $("input[name='documentSendFileTopicWord']").length >0 && $("input[name='documentSendFileTopicWord']").val().length >100 ){
			alert("主题词长度不能超过100！");
			return false;
	}


	 if($("input[name='documentSendFileTitle']")[0].value.indexOf("#")>=0){
		  whir_alert("标题不能含'#'",function(){$("input[name='documentSendFileTitle']").focus()});
		  return false;
	  }


	  var isCOSClient = checkCOS();//true-是 false-否

	  if(! isCOSClient ) {
		  if($("input[name='content']")[0].value==""){
			  whir_alert("您还没有起草正文！");
			  return false;
		  }
	  }
	  if(getCallBackName()=="showCompleteTask" || getCallBackName()=="showPopup"){
		  if(! isCOSClient ) {
			  //加入判断，如果有 生成正式文件，则不用判断
			  if(document.getElementById("WordWindowDue")){
				  if(document.getElementById("flag_savefile") != undefined  && $("*[name='contentAccSaveName']").val() == ""  ){
					  alert("您还没有生成正式文件！");
					  return false;
				  }
			  }
		  }
		  //document.getElementsByName("documentSendFileByteNumber")[0].value 
		  if(document.getElementById("flag_ChangeNumber") != undefined  && document.getElementsByName("documentSendFileByteNumber")[0].value == ""  ){
			  alert("您还没有编号！");
			  return false;
		  }
	  }
	  
	//加入自定义表单中如果是空的话就判断是否为空
		var canSubmit = beforeSubmit();
			if(!canSubmit){
				return false;
			}
	  if(document.getElementsByName("sendFilePoNumId").length >0 && document.getElementsByName("field2").length > 0 ){
	  var numId=document.getElementsByName("sendFilePoNumId")[0].value;
	  var numxuhao=document.getElementsByName("field2")[0].value;
//alert(numId);
//alert(numxuhao);
	  if(numId!=""&&numxuhao!=""){
			var http_request = false;
			/*开始初始化XMLHttpRequest对象*/
			if(window.XMLHttpRequest) { /*Mozilla 浏览器*/
				http_request = new XMLHttpRequest();
				if (http_request.overrideMimeType) {/*设置MiME类别*/
					http_request.overrideMimeType('text/xml');
				}
			} else if (window.ActiveXObject) { /* IE浏览器*/
				try {
					http_request = new ActiveXObject("Msxml2.XMLHTTP");
				} catch (e) {
					try {
						http_request = new ActiveXObject("Microsoft.XMLHTTP");
					} catch (e) {}
				}
			}
			if (!http_request) { /* 异常，创建对象实例失败*/
				window.alert("不能创建XMLHttpRequest对象实例.");
				return false;
			}else{
				var url = "/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_judge.jsp?numId=" + numId+"&record="+document.getElementsByName("p_wf_recordId")[0].value +"&field2="+numxuhao+"&tmp="+new Date().getTime();
			
				//if(document.getElementById("p_wf_openType").value=="startAgain"){

					// url = "/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_judge.jsp?numId=" + numId+"&record=0&field2="+numxuhao+"&tmp="+new Date().getTime();
				//}

				//var url = "/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_judge.jsp?numId=" + numId+"&record="+document.getElementsByName("p_wf_recordId")[0].value +"&field2="+numxuhao+"&tmp="+new Date().getTime();
			
				if(document.getElementsByName("field3").length > 0 && document.getElementsByName("field3")[0].value !=''){
					url +='&field3=' + document.getElementsByName("field3")[0].value;
				}
				
				//http_request.onreadystatechange = processRequest;
				/* 确定发送请求的方式和URL以及是否同步执行下段代码*/
				http_request.open("GET", url, false);/*此处需同步执行*/
				http_request.send(null);
			}
			if (http_request.readyState == 4) { /* 判断对象状态*/
				if (http_request.status == 200) { /*信息已经成功返回，开始处理信息*/
					var result = http_request.responseText;
					//alert("aaa"+result);
					if(result == 0){
						whir_alert("文号重复！");
						return false;
					}
				} else { /*页面不正常*/
					alert("您所请求的页面有异常。");
				}
			}
	   }

	  }
       return true;
	/*
   if (checkTextLengthOnly(GovSendFileActionForm.documentSendFileTopicWord,200,"主题词")&& checkTextLengthOnly(GovSendFileActionForm.field1,20,"文号")&&checkNumber(GovSendFileActionForm.field2,"发文序号",99999)&&checkText(GovSendFileActionForm.documentSendFileTitle,95,"发文标题")&& checkNumber(GovSendFileActionForm.documentSendFilePrintNumber,"份数",9999)&&checkTextLengthOnly(GovSendFileActionForm.sendFileAccessoryDesc,500,"附件描述")&&checkTextLengthOnly(GovSendFileActionForm.toPerson1,200,"主送")&&checkTextLengthOnly(GovSendFileActionForm.toPersonBao,200,"抄报")&&checkTextLengthOnly(GovSendFileActionForm.toPerson2,200,"抄送")&&checkTextLengthOnly(GovSendFileActionForm.toPersonInner,200,"内部发送")
    ){
	 
	setNewUpdate();
	trimrnTitle();//去掉 标题与 附件描述的 换行
	return true;

   }else{
   
    return false;
   }*/
}


/**
保存草稿
*/
function cmdSaveDraft(){

	if(!initPara()) return;
	$('#dataForm').attr("action","/defaultroot/GovDocSendProcess!saveDraft.action");

	setCallBackName("saveDraftOk");
	$('#dataForm').submit();
	//ok(0,$('#dataForm'));
}

function saveDraftOk(){
	whir_alert("保存成功！",function(){window.close();});
}

/**
起草/编辑正文
*/
function cmdWordWindowFirst(){

	var underwriteTime="";
	var hasSeal="";
	var departWord="";
	var  wordValue=$("*[name='sendFileDepartWord']")[0].value;   
	if(wordValue!=""){		 
		mystr=wordValue.split(";");      
		departWord=mystr[1];               
	}
	//是否是再次发送
	var isAjainSend = $("#p_wf_openType").val();
	if(isAjainSend == "startAgain"){
		$("input[name='initRecordId']")[0].value = $("input[name='content']")[0].value;
		$("input[name='RecordID']")[0].value = "";
	}else{
		$("input[name='RecordID']")[0].value = $("input[name='content']")[0].value; // document.all.content.value;
	}
	$("input[name='Template']")[0].value = "";
	$("input[name='showSignButton']")[0].value="1";//显示/隐藏痕迹
	$("input[name='ShowSign']")[0].value="-1";
	//$("input[name='ShowSign']")[0].value="-1";
	$("input[name='textContent']")[0].value="";
	$("input[name='loadTemp']")[0].value="0";
   
	// 选择 编辑 类型
   /* if(confirm(" 是否默认word起草正文？ \n 点‘确认’则默认word起草，点‘取消’则wps起草！")){
    document.all.documentWordType.value=".doc";
	document.all.FileType.value=".doc";	
	}else{
    document.all.documentWordType.value=".wps";
	document.all.FileType.value=".wps";
	}*/
	var  myDatestr=""+new Date().getTime();
   
        openWin({url:"about:blank",isFull: true,winName: 'ec'+myDatestr});
        // window.open("", "ec"+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
        form1.target="ec"+myDatestr;
        form1.submit();
    

}

//补发
function cmdSendToMyOther(){
 //alert(1);
	/*$.dialog({
		title:'补发',
		id: 'LHG1976DD',
			resize: false,
		height:300,
			width:620,
				max: false,
		min: false,
		
		content: 'url:',
		lock:true
	});*/
	//openWin({url:'',width:620,height:350,winName:'sendtoother'});
	//window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	//document.sendToMyOtherForm.target="target";
	//document.sendToMyOtherForm.submit();
//alert($("*[name='sendToMyOtherForm']"));
//alert(1);
		$("#sendToMyOtherForm").ajaxForm({
		     success: function(responseText){ 
			     popup({id:'cmdSendToMyRange_pop',title: '补发',fixed: true, max:true, width:'300',left: '50%', top: '50%', padding: 0,drag: true, resize: false,lock: true,content: responseText}); 		 
				
/*
				 $.dialog({
					title:'补发',
					id: 'LHG1976D1',
						resize: false,
					height:200,
						width:420,
							max: false,
					min: false,
					/* ifrst.html 和 second.html 中的代码请自行查看 * /
					content: responseText,
					lock:true
				});*/
			      // popup({title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			 }
		});	
		$("form[name='sendToMyOtherForm']")[0].target="ifrm" ;
		$("#sendToMyOtherForm").submit();
}
//分发范围
function cmdSendToMyRange(){

//	popup({id:'workflowDialog',title: '催办',fixed: true, left: '50%', top: '40%',
//		 width:'590px',height:'430px', drag: true, resize: true,lock: true,content: "url:"+url}); 
	//window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	//document.sendToMyForm.target="target";
	//document.sendToMyForm.sendFileId.value = document.all.editId.value;
	//document.sendToMyForm.submit();
		$("input[name='p_wf_recordId']")[0].value = $("input[name='p_wf_recordId']")[0].value;//form[name='sendToMyForm'] 
		$("#sendToMyForm").ajaxForm({
		     success: function(responseText){ 
				// alert(responseText);
			       popup({id:'cmdSendToMyRange_show_pop',title: '分发范围',fixed: false,max:true,
					   width:'300px',height:'250px',left: '50%', top: '50%', padding: 0,drag: true, resize: false,lock: false,content: responseText}); 	
				   // width:'590px',height:'430px', drag: true, resize: true,lock: true,content: "url:"+url}); 
			 }
		});	
		$("#sendToMyForm").submit();
}

//下载文件
function cmdDowntext(){
	//alert(1);///defaultroot/public/upload/download/download.jsp?FileName=2013051414111050017252965.zip&name=%E6%B5%81%E7%A8%8B%E8%AF%B4%E6%98%8Ev1.0.zip&path=govdocumentmanager
		location_href ( '/defaultroot/public/download/download.jsp?verifyCode='+$("*[name='fileVerifyCode']").val()+'&FileName='+$("*[name='content']").val()+$("*[name='documentWordType']").val()+'&name='+encodeURIComponent($("*[name='documentSendFileTitle']").val())+$("*[name='documentWordType']").val()+'&path=govdocumentmanager');

		//window.location.href = 'http://192.168.0.28:7099/oafile/download.jsp?FileName='+document.getElementById("content").value+'.doc&name='+encodeURIComponent(document.getElementById("documentSendFileTitle").value)+'.doc&path=govdocumentmanager';
	
}


function   changeSenddocumentWord(){
	
  var  wordValue=$("*[name='sendFileDepartWord']")[0].value;//document.all.sendFileDepartWord.value; 

     if(wordValue!=""){	
		  mystr=wordValue.split(";"); 	
	
          if(mystr.length>3){
				   var  sendWordId=mystr[0]; //机关代字 id 
			       var  sendWord=mystr[1];   //机关代字名
				   var  temId="";      //模班id 		
				   for(ii=2;ii<mystr.length;ii++){
                        temId+=mystr[ii]+";";
				   }
				   temId=temId.substring(0,temId.length-1);
				   
	               $("*[name='templateId']")[0].value=temId;	
				
				  
				   //document.all.templateId.value=temId;			 
			 }else{
				
				  var  sendWordId=mystr[0]; //机关代字 id 
			      var  sendWord=mystr[1];   //机关代字名
			      var  temId=mystr[2];      //模班id 		
			
	             // document.all.templateId.value=temId;	
				 $("*[name='templateId']")[0].value=temId;		
			
			 }         
                
	 }else{
		 $("*[name='templateId']")[0].value="";			
	    // document.all.templateId.value="";
	 
	 }  
	
	$("*[name='documentSendFileByteNumber']")[0].value="";	
	$("*[name='sendFilePoNumId']")[0].value="";	
	 //document.all.documentSendFileByteNumber.value="";
	 //document.all.sendFilePoNumId.value="";


}
function   changeSenddocumentWordOnload(){
	var value1 =$("*[name='documentSendFileByteNumber']")[0].value;
	if(value1 != ""){
		return;
	}
	var value2 = $("*[name='sendFilePoNumId']")[0].value;
	if(value2 != ""){
		return;
	}
	var obj= $("select[name='sendFileDepartWord']") ; 
	if(obj.length ==0){
		return;
	}

    var  wordValue=obj[0].value;//document.all.sendFileDepartWord.value; 
	if(wordValue==""){
		return;
	}
     if(wordValue!=""){	
		  mystr=wordValue.split(";"); 	
	
          if(mystr.length>3){
				   var  sendWordId=mystr[0]; //机关代字 id 
			       var  sendWord=mystr[1];   //机关代字名
				   var  temId="";      //模班id 		
				   for(ii=2;ii<mystr.length;ii++){
                        temId+=mystr[ii]+";";
				   }
				   temId=temId.substring(0,temId.length-1);
				   
	               $("*[name='templateId']")[0].value=temId;	
				
				  
				   //document.all.templateId.value=temId;			 
			 }else{
				
				  var  sendWordId=mystr[0]; //机关代字 id 
			      var  sendWord=mystr[1];   //机关代字名
			      var  temId=mystr[2];      //模班id 		
			
	             // document.all.templateId.value=temId;	
				 $("*[name='templateId']")[0].value=temId;		
			
			 }         
                
	 }else{
		 $("*[name='templateId']")[0].value="";			
	    // document.all.templateId.value="";
	 
	 }  
	
	$("*[name='documentSendFileByteNumber']")[0].value="";	
	$("*[name='sendFilePoNumId']")[0].value="";	
	 //document.all.documentSendFileByteNumber.value="";
	 //document.all.sendFilePoNumId.value="";


}



//分发范围 显示
function cmdSendToMyRange_show(){
	
	//window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	//$("form[name='sendToMyForm']")[0].target="target";
	//$("form[name='sendToMyForm'] input[name='sendFileId']")[0].value = $("input[name='editId']")[0].value;//.submit();
	//$("form[name='sendToMyForm']")[0].submit();
	//document.sendToMyForm.target="target";
	//document.sendToMyForm.sendFileId.value = document.all.editId.value;
	//document.sendToMyForm.submit();

		$("form[name='sendToMyForm'] input[name='p_wf_recordId']")[0].value = $("input[name='p_wf_recordId']")[0].value;
		$("#sendToMyForm").ajaxForm({
		     success: function(responseText){ 
				 //  alert(responseText);
			       popup({id:'cmdSendToMyRange_show_pop',title: '分发范围',fixed: true, left: '50%', top: '50%',padding: 0,drag: true, resize: true,lock: false,content: responseText}); 		 
			 }
		});	
		$("#sendToMyForm").submit();
}

//发文分发
function cmdSendclose(){

    //sendClose();
    //openPupWin(CommonJSResource.rootPath+"/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp",500,250);
    //openPupWin(CommonJSResource.rootPath+"/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?sendFileId=" + document.all.editId.value+"&processId=" +document.all.processId.value +"&tableId=" +document.all.tableId.value + "&recordId=" + document.all.recordId.value +"&activityId=" + document.all.curActivityId.value+"&submitPersonId=" +document.all.submitPersonId.value+"&tranFromPersonId="+document.all.tranFromPersonId.value ,500,250);
	//var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?sendFileId=" + $("input[name='p_wf_recordId']")[0].value+"&processId=" +$("input[name='p_wf_processId']")[0].value +"&tableId=" +$("input[name='p_wf_tableId']")[0].value + "&recordId=" + $("input[name='p_wf_recordId']")[0].value +"&activityId=" + $("input[name='p_wf_recordId']")[0].value document.all.curActivityId.value+"&submitPersonId=" +document.all.submitPersonId.value+"&tranFromPersonId="+document.all.tranFromPersonId.value  ;

	if($("input[name='p_wf_pool_processType']")[0].value == "1"){
		var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_newFlow.jsp?sendFileId=" + $("input[name='p_wf_recordId']")[0].value+"&processId=" +  $("input[name='p_wf_processId']")[0].value +"&tableId=" + ( $("input[name='p_wf_tableId']")[0]?$("input[name='p_wf_tableId']")[0].value:"")  + "&recordId=" + $("input[name='p_wf_recordId']")[0].value +"&activityId=" + $("input[name='p_wf_cur_activityId']")[0].value +"&p_wf_pool_processType="+  $("input[name='p_wf_pool_processType']")[0].value+"&p_wf_cur_activityId="+  $("input[name='p_wf_cur_activityId']")[0].value+"&p_wf_processInstanceId="+  $("input[name='p_wf_processInstanceId']")[0].value+"&p_wf_taskId="+  $("input[name='p_wf_taskId']")[0].value;




		//openWin({url:hhref,width:620,height:350,winName:'SendcloseWin'});
		$.dialog({id:'SendcloseWinId',title:'分发',width:600,height:300,content: 'url:'+hhref+''});

	}else{

		var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?sendFileId=" + $("input[name='p_wf_recordId']")[0].value+"&processId=" +  $("input[name='p_wf_pool_processId']")[0].value +"&tableId=" + ( $("input[name='p_wf_tableId']")[0]?$("input[name='p_wf_tableId']")[0].value:"")  + "&recordId=" + $("input[name='p_wf_recordId']")[0].value +"&activityId=" + $("input[name='p_wf_cur_activityId']")[0].value +"&submitPersonId=" + $("input[name='p_wf_submitPersonId']")[0].value+"&tranFromPersonId="+  $("input[name='p_wf_tranFromPersonId']")[0].value;




		//openWin({url:hhref,width:620,height:350,winName:'SendcloseWin'});
		$.dialog({id:'SendcloseWinId',title:'分发',width:600,height:300,content: 'url:'+hhref+''});
	}
}



//word编辑正文
function accWordEdit(name,fileType, editType){

    var t_recordId="";
	var t_editType="0";
	var t_cansave="0";
	var t_showTempSign="0";
	var t_showTempHead="0";
	var t_showSiqn="0";
	var t_showSignButton="0";
	var t_showEditButton="0";
	var t_saveDocFile="0";
 
    t_recordId=eval("document.getElementsByName(\""+name+"\")[0].value");

	if(editType=="1"){
	  t_editType="1"; 
	  t_cansave="1"
	  t_showSignButton="1";
	  t_saveDocFile="1";
	  t_showEditButton="1";
	}
	//var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType="+t_editType+"&UserName="+$("*[name='UserName']").val() +"&CanSave="+t_cansave+"&showTempSign="+t_showTempSign+"&showTempHead="+t_showTempHead+"&ShowSign="+t_showSiqn+"&showSignButton="+t_showSignButton+"&showEditButton="+t_showEditButton+"&saveDocFile="+t_saveDocFile+"&moduleType=govdocument&textContent=-1&FileType="+fileType+"&field="+name
	openWin({url:url,width:620,height:350,winName:'_blank'});

  // window.open("/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType="+t_editType+"&UserName="+document.all.UserName.value+"&CanSave="+t_cansave+"&showTempSign="+t_showTempSign+"&showTempHead="+t_showTempHead+"&ShowSign="+t_showSiqn+"&showSignButton="+t_showSignButton+"&showEditButton="+t_showEditButton+"&saveDocFile="+t_saveDocFile+"&moduleType=govdocument&textContent=-1&FileType="+fileType+"&field="+name, "editContent", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");


}


// 发文分发
function cmdSendToMy(useOrgUsers){
//< %=sendStatus% >

	var  toId=$("input[name='sendToMyId']")[0].value;

	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;

	var  t_p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;
	//alert(t_p_wf_recordId);
	if( t_p_wf_recordId == "" ){
		//alert(11);
		whir_alert("请先保存再分发");
	    return;
	}
	//alert(12);
	
	if(toName==""){
	    whir_alert("请选择接收者");
	    return;
	}
//alert(13);
	//$("#GovSendFileActionForm").ajaxForm({
		    // success: function(responseText){ 
					//alert("分发成功！");
					//var api = frameElement.api, W = api.opener; 
					//api.close();
					// $.dialog({id:'LHG1976D1'}).close();
			       //popup({id:'sendtoMyDialog',title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
			// }
	//});	
	//alert($("form[name='GovSendFileActionForm']")[0]);

	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!sendToMyReceive.action?sendFileCanDownload="+$("input[name='sendFileCanDownload']").val()+"&useOrgUsers="+useOrgUsers+"&sendType=1&p_wf_recordId="+t_p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("#dataForm input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("#dataForm input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("#dataForm input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=1&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	//	document.all.GovSendFileActionForm.action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=0&isSendToMyOther="+document.all.isSendToMyOther.value);
	//isInModify=isInModify&sendStatus=0&
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	//$("form[name='GovSendFileActionForm']")[0].submit();
	//alert(14);
	$("form[name='GovSendFileActionForm']").ajaxSubmit();
	whir_alert("分发成功！");
	$("form[name='GovSendFileActionForm']")[0].target="";

	
	//alert(3);
	//$("#GovSendFileActionForm").submit();

	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
	//document.all.GovSendFileActionForm.target="";
}






// 我的收文，转本部门.（只是其中之一）
function cmdSendToMyDep(){
	var  toId=$("input[name='sendToMyId']")[0].value;
	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;
	var  p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;

	if(toName==""){
	    alert("请选择接收者");
	    return;
	}
	//$("#GovSendFileActionForm").ajaxForm({
	    // success: function(responseText){ 
			//alert("分发成功！");
			//var api = frameElement.api, W = api.opener; 
			//api.close();
			// $.dialog({id:'LHG1976D1'}).close();
	       //popup({id:'sendtoMyDialog',title: '补发',fixed: true, left: '50%', top: '50%', padding: 0,drag: true, resize: true,lock: true,content: responseText}); 		 
		// }
	//});	
	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!sendToMyReceive.action?sendType=1&p_wf_recordId="+p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	$("form[name='GovSendFileActionForm']").ajaxSubmit();
	alert("分发成功！");
	$("form[name='GovSendFileActionForm']")[0].target="";
	
	//alert(3);
	//$("#GovSendFileActionForm").submit();
	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
	//document.all.GovSendFileActionForm.target="";
}



//去掉所有的换行
String.prototype.Trimrn = function(){
	//return this.replace(/(^\s*)|(\s*$)/g, "");
	var reg = /[\r\n]/g; 
    return   this.replace(reg,"");
}


//补发直接发送
function cmdSupplySend(){
    if(!initPara()) return;

	if($("input[name='sendToId2']")[0].value==""){
		whir_alert("请选择要发送的人！");
		return;
	}

	$("form[name='GovSendFileActionForm']")[0].action="target";
	$("form[name='GovSendFileActionForm']")[0].submit();
    //GovSendFileActionForm.action = "< %=rootPath% >/GovSendFileAction.do?action=supplySend";
    //GovSendFileActionForm.submit();
}


//套用模板时检验
function checkTextBe(){
  //if(document.all.sendFileDepartWord.value==""){
  if( $("*[name='sendFileDepartWord']").val() == "" ){
   whir_alert("机关代字不能为空！");
   return false;
  }
  // if(document.all.documentSendFileTitle.value==""){
  if( $("*[name='documentSendFileTitle']").val() == "" ){
   whir_alert("标题不能为空！");
   return false;
  }

 return true;

}
function trimrnTitle(){
	var title=  $("*[name='documentSendFileTitle']").val() ;//document.all.documentSendFileTitle.value;
	title=title.Trimrn();
	//document.all.documentSendFileTitle.value=title;
	$("*[name='documentSendFileTitle']").val(title) ;


	var sendFileAccessoryDescStr=""+ $("*[name='sendFileAccessoryDesc']").val() ; //document.all.sendFileAccessoryDesc.value;
	sendFileAccessoryDescStr=sendFileAccessoryDescStr.Trimrn();
	//document.all.sendFileAccessoryDesc.value=sendFileAccessoryDesc;
	$("*[name='sendFileAccessoryDesc']").val(sendFileAccessoryDescStr);
}	

function baodate2chinese(s)
{
     //验证输入的日期格式.并提取相关数字.
     var datePat = /^(\d{2}|\d{4})(\/|-)(\d{1,2})(\2)(\d{1,2})$/; 
     var matchArray = s.match(datePat); 
     var ok="";
     if (matchArray == null) return false;
     for(var i=1;i<matchArray.length;i=i+2)
     {
         ok+=n2c(matchArray[i]-0)+ydm[(i-1)/2];
     }
	 return ok;
}

var chinese = ['零','一','二','三','四','五','六','七','八','九'];
var len = ['十'];
var ydm =['年','月','日'];
function num2chinese(s)
{
    //将单个数字转成中文.
    s=""+s;
    slen = s.length;
    var result="";
    for(var i=0;i<slen;i++)
    {
        result+=chinese[s.charAt(i)];
    }
     return result;
}
function n2c(s)
{ 
    //对特殊情况进行处理.
    s=""+s;
    var result="";
    if(s.length==2)
    {
         if(s.charAt(0)=="1")
         {
            if(s.charAt(1)=="0")return len[0];
            return len[0]+chinese[s.charAt(1)];
          }
     if(s.charAt(1)=="0")return chinese[s.charAt(0)]+len[0];
        return chinese[s.charAt(0)]+len[0]+chinese[s.charAt(1)];
     }
     return num2chinese(s)
}
//生成正式文件
function cmdWordWindowDue(){
	
	if($("input[name='content']")[0].value==""){
		  whir_alert("您还没有起草正文！");
		  return false;
	}
	$("input[name='showSignButton']")[0].value="1";//显示/隐藏痕迹

	 $("*[name='loadTemp']").val("1");
	 $("*[name='retem']").val("0");
	 //document.all.loadTemp.value="1";
	 var underwriteTime="";
	 var hasSeal="";
	 var underwritePerson="";
	
	 underwriteTime=(($("*[name='signsendTime']").length > 0)?$("*[name='signsendTime']").val():"");
	// underwriteTime.replaceAll("/","-");

	 if(underwriteTime!=""){
         var  dtEndsign="";
		underwriteTime=$("*[name='signsendTime']").val();
        if (typeof underwriteTime == 'string' && underwriteTime!="" )//如果是字符串转换为日期型
        {
             dtEndsign = StringToDate(underwriteTime);
            underwriteTime=dtEndsign.getFullYear()+'年'+(dtEndsign.getMonth()+1)+'月'+dtEndsign.getDate()+'日'
        }else{
            if( underwriteTime != "" ){
                underwriteTime=underwriteTime.replace("/","年");underwriteTime=underwriteTime.replace("-","年");
                underwriteTime=underwriteTime.replace("/","月");underwriteTime=underwriteTime.replace("-","月");
                underwriteTime=underwriteTime+"日";
            }
        }
	
	 }

	 //underwritePerson="";
	 hasSeal="1";	 
	  var departWord="";
	  
      var  wordValue=(( $("*[name='sendFileDepartWord']").length > 0)? $("*[name='sendFileDepartWord']").val():"");  
      if(wordValue!=""){		 
             mystr=wordValue.split(";");      
			  departWord=mystr[1];               
	  }
            
	 //检查
	 if(!checkTextBe()){
		 return ;
	 }

	trimrnTitle();//去掉 标题与 附件描述的 换行
	$("*[name='RecordID']").val($("*[name='content']").val());
	//document.all.RecordID.value = document.all.content.value;
	var rr ='';
	if($("*[name='documentSendFileSendTime']").length > 0){
        var  dtEnd="";
		rr=$("*[name='documentSendFileSendTime']").val();
        if (typeof rr == 'string' && rr!="" )//如果是字符串转换为日期型
        {
             dtEnd = StringToDate(rr);
            rr=dtEnd.getFullYear()+'年'+(dtEnd.getMonth()+1)+'月'+dtEnd.getDate()+'日'
        }else{
            if( rr != "" ){
                rr=rr.replace("/","年");rr=rr.replace("-","年");
                rr=rr.replace("/","月");rr=rr.replace("-","月");
                rr=rr+"日";
            }
        }

	}
	
	//document.all.documentSendFileSendTime_1.value=rr;
	$("*[name='sendFileRedHeadId_1']").val( $("*[name='sendFileRedHeadId_1']")  );
	$("*[name='sendFileRedHeadId_1']").val( (( $("*[name='sendFileRedHeadId']").length > 0)? $("*[name='sendFileRedHeadId']").val():"") );
	//document.all.sendFileRedHeadId_1.value = ((document.all.sendFileRedHeadId)?document.all.sendFileRedHeadId.value:"");
	$("*[name='hasSeal']").val(hasSeal);
	//document.all.hasSeal.value =hasSeal;
	
	$("*[name='$signsendTime']").val("[签发日期]"+underwriteTime);
	//$("*[name='$underwriteTime']").val("[签发日期]"+underwriteTime);
	//document.all.$underwriteTime.value="[签发日期]"+underwriteTime;
	$("*[name='$sendFileGrade']").val(  "[办理缓急]"+((  $("*[name='sendFileGrade']").length > 0 )?   $("*[name='sendFileGrade']").val() :"") );

	//document.all.$sendFileGrade.value = "[办理缓急]"+((document.all.sendFileGrade)?document.all.sendFileGrade.value:"");

	$("*[name='$documentSendFileWriteOrg']").val(  "[拟稿单位]"+((  $("*[name='documentSendFileWriteOrg']").length > 0 )?   $("*[name='documentSendFileWriteOrg']").val() :"") );
	//document.all.$documentSendFileWriteOrg.value = "[拟稿单位]"+((document.all.documentSendFileWriteOrg)?document.all.documentSendFileWriteOrg.value:"");
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"")+" "+((document.all.documentFileType)?document.all.documentFileType.value:"");
	
	$("*[name='$documentSendFileTopicWord']").val(  "[主题词]"+((  $("*[name='documentSendFileTopicWord']").length > 0 )?   $("*[name='documentSendFileTopicWord']").val() :"") );
	
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"");

	$("*[name='$documentFileType']").val(  "[文件种类]"+((  $("*[name='documentFileType']").length > 0 )?   $("*[name='documentFileType']").val() :"") );

	//document.all.$documentFileType.value = "[文件种类]"+((document.all.documentFileType)?document.all.documentFileType.value:"");

	$("*[name='$toPerson1']").val(  "[主送]"+((  $("*[name='toPerson1']").length > 0 )?   $("*[name='toPerson1']").val() :"") );
	//document.all.$toPerson1.value = "[主送]"+((document.all.toPerson1)?document.all.toPerson1.value:"");

	$("*[name='$toPerson2']").val(  "[抄送]"+((  $("*[name='toPerson2']").length > 0 )?   $("*[name='toPerson2']").val() :"") );
	//document.all.$toPerson2.value = "[抄送]"+((document.all.toPerson2)?document.all.toPerson2.value:"");

	//if($("*[name='toPersonBao']").length > 0){
	$("*[name='$toPersonBao']").val(  "[抄报]"+((  $("*[name='toPersonBao']").length > 0 )?   $("*[name='toPersonBao']").val() :"") );
		
	  //document.all.$toPersonBao.value = "[抄报]"+((document.all.toPersonBao)?document.all.toPersonBao.value:"");
	//}
	//承办人、呈送签批时间要求、拟稿日期、代拟稿、拟稿人电话、抄送、抄报、内部发送、文件类别、参考文件描述
	//if(document.all.toPersonInner){
		$("*[name='$toPersonInner']").val(  "[内部发送]"+((  $("*[name='toPersonInner']").length > 0 )?   $("*[name='toPersonInner']").val() :"") );
	  //document.all.$toPersonInner.value = "[内部发送]"+((document.all.toPersonInner)?document.all.toPersonInner.value:"");
	//}
	$("*[name='$field9']").val(  "[拟稿人电话]"+((  $("*[name='field9']").length > 0 )?   $("*[name='field9']").val() :"") );
	
		$("*[name='$sendFileAgentDraft']").val(  "[代拟稿]"+((  $("*[name='sendFileAgentDraft']").length > 0 )?   $("*[name='sendFileAgentDraft']").val() :"") );
	$("*[name='$documentSendFilePrintNumber']").val(  "[共印]"+((  $("*[name='documentSendFilePrintNumber']").length > 0 )?   $("*[name='documentSendFilePrintNumber']").val() :"") );
	//document.all.$documentSendFilePrintNumber.value = "[共印]"+((document.all.documentSendFilePrintNumber)?document.all.documentSendFilePrintNumber.value:"");
	$("*[name='$sendFileDepartWord']").val(   "[机关代字]"+departWord );
	//document.all.$sendFileDepartWord.value = "[机关代字]"+departWord;

	$("*[name='$senddocumentTitle']").val(   "[发文标题]"+((  $("*[name='documentSendFileTitle']").length > 0 )?   $("*[name='documentSendFileTitle']").val() :"") );

	//document.all.$senddocumentTitle.value = "[发文标题]"+((document.all.documentSendFileTitle)?document.all.documentSendFileTitle.value:"");
	$("*[name='$toPerson2']").val(   "[抄送]"+((  $("*[name='toPerson2']").length > 0 )?   $("*[name='toPerson2']").val() :"") );
	//$("*[name='$underwritePerson']").val(   "[签发人]"+underwritePerson );
	//document.all.$underwritePerson.value = "[签发人]"+underwritePerson;
	
	$("*[name='$documentSendFileAssumePeople']").val(   "[承办人]"+ ((  $("*[name='documentSendFileAssumePeople']").length > 0 )?   $("*[name='documentSendFileAssumePeople']").val() :"")  );
	$("*[name='$referenceAccessoryDesc']").val(   "[参考文件描述]"+ ((  $("*[name='referenceAccessoryDesc']").length > 0 )?   $("*[name='referenceAccessoryDesc']").val() :"")  );
	$("*[name='$securityGrade']").val(   "[秘密级别]"+((  $("*[name='documentSendFileSecurityGrade']").length > 0 )?   $("*[name='documentSendFileSecurityGrade']").val() :"") );
	//document.all.$securityGrade.value = "[秘密级别]"+((document.all.documentSendFileSecurityGrade)?document.all.documentSendFileSecurityGrade.value:"");
	//document.all.$documentSendFilePrintNumber.value = "[印刷份数]"+document.all.documentSendFilePrintNumber.value;

	$("*[name='$documentSendFileSendTime']").val(   "[印发日期]"+rr);
	//document.all.$documentSendFileSendTime.value = "[印发日期]"+rr;
	//document.all.$documentSendFileSendTime.value = "[印发时间]"+rr;
	//document.all.$sendFileAccessoryDesc.value = "[附件描述]"+((document.all.sendFileAccessoryDesc)?document.all.sendFileAccessoryDesc.value:"");
	$("*[name='$sendFileAccessoryDesc']").val(   "[附件描述]"+((  $("*[name='sendFileAccessoryDesc']").length > 0 )?   $("*[name='sendFileAccessoryDesc']").val() :"") );

	//document.all.$sendfileNUM.value = "[文号]"+((document.all.documentSendFileByteNumber)?document.all.documentSendFileByteNumber.value:"");
	$("*[name='$sendfileNUM']").val(   "[文号]"+((  $("*[name='documentSendFileByteNumber']").length > 0 )?   $("*[name='documentSendFileByteNumber']").val() :"") );

	//document.all.$field10.value = "[联系电话]"+((document.all.field10)?document.all.field10.value:"");

	$("*[name='$field10']").val(   "[联系电话]"+((  $("*[name='field10']").length > 0 )?   $("*[name='field10']").val() :"") );

	$("*[name='$sendFileDraft']").val(   "[拟稿人]"+((  $("*[name='sendFileDraft']").length > 0 )?   $("*[name='sendFileDraft']").val() :"") );
	//document.all.$field10.value = "[联系电话]"+document.all.field10.value;
	//document.all.$sendFileDraft.value="[拟稿人]"+((document.all.sendFileDraft)?document.all.sendFileDraft.value:"");

	//document.all.$zjkySeq.value="[流水号]"+((document.all.zjkySeq)?document.all.zjkySeq.value:"");
	$("*[name='$zjkySeq']").val(   "[流水号]"+((  $("*[name='zjkySeq']").length > 0 )?   $("*[name='zjkySeq']").val() :"") );

	$("*[name='$sendFilePrinter']").val(   "[打字]"+((  $("*[name='sendFilePrinter']").length > 0 )?   $("*[name='sendFilePrinter']").val() :"") );

	$("*[name='$sendFileProof']").val(   "[校对]"+((  $("*[name='sendFileProof']").length > 0 )?   $("*[name='sendFileProof']").val() :"") );

	//document.all.$zjkySecrecyterm.value="[保密期限]"+((document.all.zjkySecrecyterm)?document.all.zjkySecrecyterm.value:"");

	$("*[name='$zjkySecrecyterm']").val(   "[保密期限]"+((  $("*[name='zjkySecrecyterm']").length > 0 )?   $("*[name='zjkySecrecyterm']").val() :"") );

	$("*[name='$zjkyContentLevel']").val(   "[内容紧急]"+((  $("*[name='zjkyContentLevel']").length > 0 )?   $("*[name='zjkyContentLevel']").val() :"") );
	//document.all.$zjkyContentLevel.value="[内容紧急]"+((document.all.zjkyContentLevel)?document.all.zjkyContentLevel.value:"");

	$("*[name='$documentSendFileCounterSign']").val(   "[会签单位]"+((  $("*[name='documentSendFileCounterSign']").length > 0 )?   $("*[name='documentSendFileCounterSign']").val() :"") );
	//document.all.$documentSendFileCounterSign.value="[会签单位]"+((document.all.documentSendFileCounterSign)?document.all.documentSendFileCounterSign.value:"");

	$("*[name='$openProperty']").val(   "[公开属性]"+((  $("*[name='openProperty']").length > 0 )?   $("*[name='openProperty']").val() :"") );

	//document.all.$openProperty.value="[公开属性]"+((document.all.openProperty)?document.all.openProperty.value:"");

	//document.all.$documentSendFileCheckDate.value="[呈送签批时间要求]"+document.all.documentSendFileCheckDate.value;
	$("*[name='$documentSendFileCheckDate']").val(   "[呈送签批时间要求]"+((  $("*[name='documentSendFileCheckDate']").length > 0 )?   $("*[name='documentSendFileCheckDate']").val() :"") );
	//if($("*[name='$sendFileFileType']").length > 0 && $("*[name='sendFileFileType']").length > 0){
		$("*[name='$sendFileFileType']").val(   "[文件类别]"+((  $("*[name='sendFileFileType']").length > 0 )?   $("*[name='sendFileFileType']").val() :"") );
	//}

	//if(document.all.sendFileFileType && document.all.$sendFileFileType){
		//document.all.$sendFileFileType.value="[文件类别]" + document.all.sendFileFileType.value;
	//}
	var  nigaoshijian = "";
	if( $("*[name='documentSendFileTime']").length > 0){
	//if(document.all.documentSendFileTime){
		 nigaoshijian= $("*[name='documentSendFileTime']").val(); //document.all.documentSendFileTime.value;
		 if( nigaoshijian != ""){
			 nigaoshijian=nigaoshijian.replace("/","年");
			 nigaoshijian=nigaoshijian.replace("/","月");
			 nigaoshijian=nigaoshijian+"日";
		 }
	}
	$("*[name='$documentSendFileTime']").val("[拟稿日期]"+nigaoshijian);
		 // document.all.$documentSendFileTime.value="[拟稿日期]"+nigaoshijian;	
	
	if( $("*[name='showTempSign']").length > 0){
		$("*[name='showTempSign']").val("1");
	}

	//if(document.all.showTempSign)
	//document.all.showTempSign.value="1";
	if( $("*[name='showTempHead']").length > 0){
		$("*[name='showTempHead']").val("1");
	}

	//if(document.all.showTempHead)
	//document.all.showTempHead.value="1";

	if( $("*[name='showTransPDF']").length > 0){
		$("*[name='showTransPDF']").val("1");
	}
	//if(document.all.showTransPDF)
	//document.all.showTransPDF.value="1";

	if( $("*[name='FileType']").length > 0){
		$("*[name='FileType']").val(   ((  $("*[name='documentWordType']").length > 0 )?   $("*[name='documentWordType']").val() :"")  );
	}

	//if(document.all.FileType)
	//document.all.FileType.value=((document.all.documentWordType)?document.all.documentWordType.value:"");
	

	if( $("*[name='wordId']").length > 0){
		//$("*[name='wordId']").val(   ((  $("*[name='documentWordType']").length > 0 )?   $("*[name='documentWordType']").val() :"")  );

		 var  wordValue=((  $("*[name='sendFileDepartWord']").length > 0 )?   $("*[name='sendFileDepartWord']").val() :"") ;//((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
		 if(wordValue!=""){		 
				 mystr=wordValue.split(";");    
				 $("*[name='wordId']").val( mystr[0] );
				// document.all.wordId.value=mystr[0];               
		 }else{
			// document.all.wordId.value="";	 
			  $("*[name='wordId']").val( "" );
		 }  	
	}
	if( $("*[name='remakehead']").length > 0){
		
		 $("*[name='remakehead']").val( "0" );
	}
	//if(document.all.wordId){
   // var  wordValue=((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
    // if(wordValue!=""){		 
        //     mystr=wordValue.split(";");    
		//	 document.all.wordId.value=mystr[0];               
	 //}else{
	    // document.all.wordId.value="";	 
	// }  	
	//}

	 var  templateIds=(  $("*[name='templateId']").length > 0 )?   $("*[name='templateId']").val() :"" ;//((document.all.templateId)?document.all.templateId.value:"");
//templateIds ="1;2";
	 var  templateArr=templateIds.split(";");

	 if(templateArr.length>1){ 
		// alert("ok");
	   // postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/senddocument_singleTemplate.jsp?templates="+((document.all.templateId)?document.all.templateId.value:""), "fff", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
		url = "/defaultroot/modules/govoffice/gov_documentmanager/senddocument_singleTemplate.jsp?templates="+templateIds;

		  openWin({url:url,width:620,height:190,winName:'aaaaaaaaad'});
	 }else{
		 var  myDatestr=""+new Date().getTime();  
		$("*[name='Template']").val(  ((  $("*[name='templateId']").length > 0 )?   $("*[name='templateId']").val() :"") );
		 //document.all.Template.value = ((document.all.templateId)?document.all.templateId.value:"");
		 window.open("", "ec2"+$("*[name='RecordID']").val()+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
		// form1.target="ec2"+document.all.RecordID.value+myDatestr;
		 
		 form1.target="ec2"+ $("*[name='RecordID']").val()+myDatestr;
		
		 form1.submit();
		 //alert(1);
		 managerDueWord();
	 }
    //setdispaly();
	if(document.getElementById("flag_savefile")){
		document.getElementById("flag_savefile").value="1";
	}
}

//+---------------------------------------------------
//| 字符串转成日期类型
//| 格式 MM/dd/YYYY MM-dd-YYYY YYYY/MM/dd YYYY-MM-dd
//+---------------------------------------------------
function StringToDate(DateStr)
{

    var converted = Date.parse(DateStr);
    var myDate = new Date(converted);
    if (isNaN(myDate))
    {
        //var delimCahar = DateStr.indexOf('/')!=-1?'/':'-';
        var arys= DateStr.split('-');
        myDate = new Date(arys[0],--arys[1],arys[2]);
    }
    return myDate;
}


//再次套红
function cmdWordWindowReDue(){
	
	if($("input[name='content']")[0].value==""){
		  whir_alert("您还没有起草正文！");
		  return false;
	}


	 $("*[name='loadTemp']").val("1");
	$("*[name='retem']").val("1");
	 $("input[name='showSignButton']")[0].value="1";//显示/隐藏痕迹
	 //document.all.loadTemp.value="1";
	 var underwriteTime="";
	 var hasSeal="";
	 var underwritePerson="";
	
	 underwriteTime=(($("*[name='signsendTime']").length > 0)?$("*[name='signsendTime']").val():"");
	// underwriteTime.replaceAll("/","-");

	 if(underwriteTime!=""){
	   //underwriteTime=baodate2chinese(underwriteTime);
	    underwriteTime=underwriteTime.replace("/","年");underwriteTime=underwriteTime.replace("-","年");
		underwriteTime=underwriteTime.replace("/","月");underwriteTime=underwriteTime.replace("-","月");
		underwriteTime=underwriteTime+"日"; 
	 }

	 //underwritePerson="";
	 hasSeal="1";	 
	  var departWord="";
	  
      var  wordValue=(( $("*[name='sendFileDepartWord']").length > 0)? $("*[name='sendFileDepartWord']").val():"");  
      if(wordValue!=""){		 
             mystr=wordValue.split(";");      
			  departWord=mystr[1];               
	  }
            
	 //检查
	 if(!checkTextBe()){
		 return ;
	 }

	trimrnTitle();//去掉 标题与 附件描述的 换行
	$("*[name='RecordID']").val($("*[name='content']").val());
	//document.all.RecordID.value = document.all.content.value;
	var rr ='';
	if($("*[name='documentSendFileSendTime']").length > 0){
		rr=$("*[name='documentSendFileSendTime']").val();
		if(rr != ""){
			rr=rr.replace("/","年");rr=rr.replace("-","年");
			rr=rr.replace("/","月");rr=rr.replace("-","月");
			rr=rr+"日"; 
		}
	}
	
	//document.all.documentSendFileSendTime_1.value=rr;
	$("*[name='sendFileRedHeadId_1']").val( $("*[name='sendFileRedHeadId_1']")  );
	$("*[name='sendFileRedHeadId_1']").val( (( $("*[name='sendFileRedHeadId']").length > 0)? $("*[name='sendFileRedHeadId']").val():"") );
	//document.all.sendFileRedHeadId_1.value = ((document.all.sendFileRedHeadId)?document.all.sendFileRedHeadId.value:"");
	$("*[name='hasSeal']").val(hasSeal);
	//document.all.hasSeal.value =hasSeal;
	
	$("*[name='$signsendTime']").val("[签发日期]"+underwriteTime);
	//$("*[name='$underwriteTime']").val("[签发日期]"+underwriteTime);
	//document.all.$underwriteTime.value="[签发日期]"+underwriteTime;
	$("*[name='$sendFileGrade']").val(  "[办理缓急]"+((  $("*[name='sendFileGrade']").length > 0 )?   $("*[name='sendFileGrade']").val() :"") );

	//document.all.$sendFileGrade.value = "[办理缓急]"+((document.all.sendFileGrade)?document.all.sendFileGrade.value:"");

	$("*[name='$documentSendFileWriteOrg']").val(  "[拟稿单位]"+((  $("*[name='documentSendFileWriteOrg']").length > 0 )?   $("*[name='documentSendFileWriteOrg']").val() :"") );
	//document.all.$documentSendFileWriteOrg.value = "[拟稿单位]"+((document.all.documentSendFileWriteOrg)?document.all.documentSendFileWriteOrg.value:"");
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"")+" "+((document.all.documentFileType)?document.all.documentFileType.value:"");
	
	$("*[name='$documentSendFileTopicWord']").val(  "[主题词]"+((  $("*[name='documentSendFileTopicWord']").length > 0 )?   $("*[name='documentSendFileTopicWord']").val() :"") );
	
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"");

	$("*[name='$documentFileType']").val(  "[文件种类]"+((  $("*[name='documentFileType']").length > 0 )?   $("*[name='documentFileType']").val() :"") );

	//document.all.$documentFileType.value = "[文件种类]"+((document.all.documentFileType)?document.all.documentFileType.value:"");

	$("*[name='$toPerson1']").val(  "[主送]"+((  $("*[name='toPerson1']").length > 0 )?   $("*[name='toPerson1']").val() :"") );
	//document.all.$toPerson1.value = "[主送]"+((document.all.toPerson1)?document.all.toPerson1.value:"");

	$("*[name='$toPerson2']").val(  "[抄送]"+((  $("*[name='toPerson2']").length > 0 )?   $("*[name='toPerson2']").val() :"") );
	//document.all.$toPerson2.value = "[抄送]"+((document.all.toPerson2)?document.all.toPerson2.value:"");

	//if($("*[name='toPersonBao']").length > 0){
	$("*[name='$toPersonBao']").val(  "[抄报]"+((  $("*[name='toPersonBao']").length > 0 )?   $("*[name='toPersonBao']").val() :"") );
		
	  //document.all.$toPersonBao.value = "[抄报]"+((document.all.toPersonBao)?document.all.toPersonBao.value:"");
	//}
	//承办人、呈送签批时间要求、拟稿日期、代拟稿、拟稿人电话、抄送、抄报、内部发送、文件类别、参考文件描述
	//if(document.all.toPersonInner){
		$("*[name='$toPersonInner']").val(  "[内部发送]"+((  $("*[name='toPersonInner']").length > 0 )?   $("*[name='toPersonInner']").val() :"") );
	  //document.all.$toPersonInner.value = "[内部发送]"+((document.all.toPersonInner)?document.all.toPersonInner.value:"");
	//}
	$("*[name='$field9']").val(  "[拟稿人电话]"+((  $("*[name='field9']").length > 0 )?   $("*[name='field9']").val() :"") );
	
		$("*[name='$sendFileAgentDraft']").val(  "[代拟稿]"+((  $("*[name='sendFileAgentDraft']").length > 0 )?   $("*[name='sendFileAgentDraft']").val() :"") );
	$("*[name='$documentSendFilePrintNumber']").val(  "[共印]"+((  $("*[name='documentSendFilePrintNumber']").length > 0 )?   $("*[name='documentSendFilePrintNumber']").val() :"") );
	//document.all.$documentSendFilePrintNumber.value = "[共印]"+((document.all.documentSendFilePrintNumber)?document.all.documentSendFilePrintNumber.value:"");
	$("*[name='$sendFileDepartWord']").val(   "[机关代字]"+departWord );
	//document.all.$sendFileDepartWord.value = "[机关代字]"+departWord;

	$("*[name='$senddocumentTitle']").val(   "[发文标题]"+((  $("*[name='documentSendFileTitle']").length > 0 )?   $("*[name='documentSendFileTitle']").val() :"") );

	//document.all.$senddocumentTitle.value = "[发文标题]"+((document.all.documentSendFileTitle)?document.all.documentSendFileTitle.value:"");
	$("*[name='$toPerson2']").val(   "[抄送]"+((  $("*[name='toPerson2']").length > 0 )?   $("*[name='toPerson2']").val() :"") );
	//$("*[name='$underwritePerson']").val(   "[签发人]"+underwritePerson );
	//document.all.$underwritePerson.value = "[签发人]"+underwritePerson;
	
	$("*[name='$documentSendFileAssumePeople']").val(   "[承办人]"+ ((  $("*[name='documentSendFileAssumePeople']").length > 0 )?   $("*[name='documentSendFileAssumePeople']").val() :"")  );
	$("*[name='$referenceAccessoryDesc']").val(   "[参考文件描述]"+ ((  $("*[name='referenceAccessoryDesc']").length > 0 )?   $("*[name='referenceAccessoryDesc']").val() :"")  );
	$("*[name='$securityGrade']").val(   "[秘密级别]"+((  $("*[name='documentSendFileSecurityGrade']").length > 0 )?   $("*[name='documentSendFileSecurityGrade']").val() :"") );
	//document.all.$securityGrade.value = "[秘密级别]"+((document.all.documentSendFileSecurityGrade)?document.all.documentSendFileSecurityGrade.value:"");
	//document.all.$documentSendFilePrintNumber.value = "[印刷份数]"+document.all.documentSendFilePrintNumber.value;

	$("*[name='$documentSendFileSendTime']").val(   "[印发日期]"+rr);
	//document.all.$documentSendFileSendTime.value = "[印发日期]"+rr;
	//document.all.$documentSendFileSendTime.value = "[印发时间]"+rr;
	//document.all.$sendFileAccessoryDesc.value = "[附件描述]"+((document.all.sendFileAccessoryDesc)?document.all.sendFileAccessoryDesc.value:"");
	$("*[name='$sendFileAccessoryDesc']").val(   "[附件描述]"+((  $("*[name='sendFileAccessoryDesc']").length > 0 )?   $("*[name='sendFileAccessoryDesc']").val() :"") );

	//document.all.$sendfileNUM.value = "[文号]"+((document.all.documentSendFileByteNumber)?document.all.documentSendFileByteNumber.value:"");
	$("*[name='$sendfileNUM']").val(   "[文号]"+((  $("*[name='documentSendFileByteNumber']").length > 0 )?   $("*[name='documentSendFileByteNumber']").val() :"") );

	//document.all.$field10.value = "[联系电话]"+((document.all.field10)?document.all.field10.value:"");

	$("*[name='$field10']").val(   "[联系电话]"+((  $("*[name='field10']").length > 0 )?   $("*[name='field10']").val() :"") );

	$("*[name='$sendFileProof']").val(   "[校对]"+((  $("*[name='sendFileProof']").length > 0 )?   $("*[name='sendFileProof']").val() :"") );


	$("*[name='$sendFileDraft']").val(   "[拟稿人]"+((  $("*[name='sendFileDraft']").length > 0 )?   $("*[name='sendFileDraft']").val() :"") );
	//document.all.$field10.value = "[联系电话]"+document.all.field10.value;
	//document.all.$sendFileDraft.value="[拟稿人]"+((document.all.sendFileDraft)?document.all.sendFileDraft.value:"");

	//document.all.$zjkySeq.value="[流水号]"+((document.all.zjkySeq)?document.all.zjkySeq.value:"");
	$("*[name='$zjkySeq']").val(   "[流水号]"+((  $("*[name='zjkySeq']").length > 0 )?   $("*[name='zjkySeq']").val() :"") );

	//document.all.$zjkySecrecyterm.value="[保密期限]"+((document.all.zjkySecrecyterm)?document.all.zjkySecrecyterm.value:"");

	$("*[name='$zjkySecrecyterm']").val(   "[保密期限]"+((  $("*[name='zjkySecrecyterm']").length > 0 )?   $("*[name='zjkySecrecyterm']").val() :"") );

	$("*[name='$zjkyContentLevel']").val(   "[内容紧急]"+((  $("*[name='zjkyContentLevel']").length > 0 )?   $("*[name='zjkyContentLevel']").val() :"") );
	//document.all.$zjkyContentLevel.value="[内容紧急]"+((document.all.zjkyContentLevel)?document.all.zjkyContentLevel.value:"");

	$("*[name='$documentSendFileCounterSign']").val(   "[会签单位]"+((  $("*[name='documentSendFileCounterSign']").length > 0 )?   $("*[name='documentSendFileCounterSign']").val() :"") );
	//document.all.$documentSendFileCounterSign.value="[会签单位]"+((document.all.documentSendFileCounterSign)?document.all.documentSendFileCounterSign.value:"");

	$("*[name='$openProperty']").val(   "[公开属性]"+((  $("*[name='openProperty']").length > 0 )?   $("*[name='openProperty']").val() :"") );

	//document.all.$openProperty.value="[公开属性]"+((document.all.openProperty)?document.all.openProperty.value:"");

	//document.all.$documentSendFileCheckDate.value="[呈送签批时间要求]"+document.all.documentSendFileCheckDate.value;
	$("*[name='$documentSendFileCheckDate']").val(   "[呈送签批时间要求]"+((  $("*[name='documentSendFileCheckDate']").length > 0 )?   $("*[name='documentSendFileCheckDate']").val() :"") );
	//if($("*[name='$sendFileFileType']").length > 0 && $("*[name='sendFileFileType']").length > 0){
		$("*[name='$sendFileFileType']").val(   "[文件类别]"+((  $("*[name='sendFileFileType']").length > 0 )?   $("*[name='sendFileFileType']").val() :"") );
	//}

	//if(document.all.sendFileFileType && document.all.$sendFileFileType){
		//document.all.$sendFileFileType.value="[文件类别]" + document.all.sendFileFileType.value;
	//}
	var  nigaoshijian = "";
	if( $("*[name='documentSendFileTime']").length > 0){
	//if(document.all.documentSendFileTime){
		 nigaoshijian= $("*[name='documentSendFileTime']").val(); //document.all.documentSendFileTime.value;
		 if( nigaoshijian != ""){
			 nigaoshijian=nigaoshijian.replace("/","年");
			 nigaoshijian=nigaoshijian.replace("-","年");
			 nigaoshijian=nigaoshijian.replace("/","月");
			 nigaoshijian=nigaoshijian.replace("-","月");
			 nigaoshijian=nigaoshijian+"日";
		 }
	}
	$("*[name='$documentSendFileTime']").val("[拟稿日期]"+nigaoshijian);
		 // document.all.$documentSendFileTime.value="[拟稿日期]"+nigaoshijian;	
	
	if( $("*[name='showTempSign']").length > 0){
		$("*[name='showTempSign']").val("1");
	}

	//if(document.all.showTempSign)
	//document.all.showTempSign.value="1";
	if( $("*[name='showTempHead']").length > 0){
		$("*[name='showTempHead']").val("1");
	}

	//if(document.all.showTempHead)
	//document.all.showTempHead.value="1";

	if( $("*[name='showTransPDF']").length > 0){
		$("*[name='showTransPDF']").val("1");
	}
	//if(document.all.showTransPDF)
	//document.all.showTransPDF.value="1";

	if( $("*[name='FileType']").length > 0){
		$("*[name='FileType']").val(   ((  $("*[name='documentWordType']").length > 0 )?   $("*[name='documentWordType']").val() :"")  );
	}

	//if(document.all.FileType)
	//document.all.FileType.value=((document.all.documentWordType)?document.all.documentWordType.value:"");
	

	
	if( $("*[name='wordId']").length > 0){
		//$("*[name='wordId']").val(   ((  $("*[name='documentWordType']").length > 0 )?   $("*[name='documentWordType']").val() :"")  );

		 var  wordValue=((  $("*[name='sendFileDepartWord']").length > 0 )?   $("*[name='sendFileDepartWord']").val() :"") ;//((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
		 if(wordValue!=""){		 
				 mystr=wordValue.split(";");    
				 $("*[name='wordId']").val( mystr[0] );
				// document.all.wordId.value=mystr[0];               
		 }else{
			// document.all.wordId.value="";	 
			  $("*[name='wordId']").val( "" );
		 }  	
	}
	if( $("*[name='remakehead']").length > 0){
		
		 $("*[name='remakehead']").val( "1" );
	}
	//if(document.all.wordId){
   // var  wordValue=((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
    // if(wordValue!=""){		 
        //     mystr=wordValue.split(";");    
		//	 document.all.wordId.value=mystr[0];               
	 //}else{
	    // document.all.wordId.value="";	 
	// }  	
	//}

	 var  templateIds=(  $("*[name='templateId']").length > 0 )?   $("*[name='templateId']").val() :"" ;//((document.all.templateId)?document.all.templateId.value:"");
//templateIds ="1;2";
	 var  templateArr=templateIds.split(";");

	 if(templateArr.length>1){ 
		// alert("ok");
	   // postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/senddocument_singleTemplate.jsp?templates="+((document.all.templateId)?document.all.templateId.value:""), "fff", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
		url = "/defaultroot/modules/govoffice/gov_documentmanager/senddocument_singleTemplate.jsp?templates="+templateIds;

		  openWin({url:url,width:620,height:190,winName:'aaaaaaaaad'});
	 }else{
		 var  myDatestr=""+new Date().getTime();  
		$("*[name='Template']").val(  ((  $("*[name='templateId']").length > 0 )?   $("*[name='templateId']").val() :"") );
		 //document.all.Template.value = ((document.all.templateId)?document.all.templateId.value:"");
		 window.open("", "ec2"+$("*[name='RecordID']").val()+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
		// form1.target="ec2"+document.all.RecordID.value+myDatestr;
		 
		 form1.target="ec2"+ $("*[name='RecordID']").val()+myDatestr;
		
		 form1.submit();
		 //alert(1);
		 managerDueWord();
	 }
    //setdispaly();
	if(document.getElementById("flag_savefile")){
		document.getElementById("flag_savefile").value="1";
	}
}


function selecttw() {
  var hhref = "GovDocSend!chooseSendTopical.action" ;
  openWin({url:hhref,width:620,height:350,winName:'sendToReceive'});
 // postWindowOpen(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=no,width=600,height=300') ;
}


// 生成正文管理文件

 function managerDueWord(){
    if($("*[name='content']").val() !=""){
		var oldName=$("*[name='contentAccSaveName']").val()  ;
		if(oldName==""){
			$("*[name='contentAccSaveName']").val($("*[name='content']").val() + $("*[name='documentWordType']").val()    )  ;
		// document.all.contentAccSaveName.value=document.all.content.value+document.all.documentWordType.value;
		 //document.all.contentAccName.value=document.all.documentSendFileTitle.value+document.all.documentWordType.value;
			$("*[name='contentAccName']").val($("*[name='documentSendFileTitle']").val() + $("*[name='documentWordType']").val()    )  ;
		}else{
			var  name= $("*[name='content']").val() + $("*[name='documentWordType']").val()     ;//document.all.content.value+document.all.documentWordType.value;
			var resultJ=oldName.indexOf(name);
			if(resultJ==-1){
				$("*[name='contentAccSaveName']").val( $("*[name='content']").val() + $("*[name='documentWordType']").val() );
			  // document.all.contentAccSaveName.value+="|"+document.all.content.value+document.all.documentWordType.value;
			   //document.all.contentAccName.value+="|"+document.all.documentSendFileTitle.value+document.all.documentWordType.value;		
			   $("*[name='contentAccName']").val( $("*[name='documentSendFileTitle']").val() + $("*[name='documentWordType']").val() );
			}
		
		}
   }
 
 }



//选择主送 ，抄送
function openEndowSend(type){

	if(type=="toPerson1"){   
		//openEndow('toPerson1Id','toPerson1',document.all.toPerson1Id.value,document.all.toPerson1.value,'userorggroup','no','userorggroup','*0*');
		openSelect({allowId:'toPerson1Id', allowName:'toPerson1', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}
	if(type=="toPerson2"){   
		//openEndow('toPerson2Id','toPerson2',document.all.toPerson2Id.value,document.all.toPerson2.value,'userorggroup','no','userorggroup','*0*');
		openSelect({allowId:'toPerson2Id', allowName:'toPerson2', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}

	if(type=="toPersonBao"){   
		//openEndow('toPersonBaoId','toPersonBao',document.all.toPersonBaoId.value,document.all.toPersonBao.value,'userorggroup','no','userorggroup','*0*');
		openSelect({allowId:'toPersonBaoId', allowName:'toPersonBao', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}

	if(type=="toPersonInner"){   
		//openEndow('toPersonInnerId','toPersonInner',document.all.toPersonInnerId.value,document.all.toPersonInner.value,'org','no','org','*0*');
		openSelect({allowId:'toPersonInnerId', allowName:'toPersonInner', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});	
	}
}


//转收文
function cmdSendToReceive(){

//openPupWin("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?fileTitle="+document.all.documentSendFileTitle.value+"&byteNum="+document.all.documentSendFileByteNumber.value+"&seqNum="+(document.all.zjkySeq?document.all.zjkySeq.value:"")+"&sendRecordId="+document.all.editId.value+"&accessoryName1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=&tableId="+document.all.tableNameOrId.value+"&field4=" + (document.all.sendFileGrade?document.all.sendFileGrade.value:"")+"&receiveFileFileNumber="  + (document.all.documentSendFileByteNumber?document.all.documentSendFileByteNumber.value:""),'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
//openPupWin("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?receiveFileSendFileUnit=初始化组织.初始二级组织.初始三级组织&fileTitle=test&byteNum="+document.all.documentSendFileByteNumber.value+"&seqNum="+(document.all.zjkySeq?document.all.zjkySeq.value:"")+"&sendRecordId="+document.all.editId.value+"&accessoryName1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=&tableId="+document.all.tableNameOrId.value+"&field4=" + (document.all.sendFileGrade?document.all.sendFileGrade.value:"")+"&receiveFileFileNumber="  + (document.all.documentSendFileByteNumber?document.all.documentSendFileByteNumber.value:""),'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
$.dialog({
	title:'转收文',
    id: 'LHG1976D',
		resize: false,
	height:200,
		width:420,
			max: false,
    min: false,
    /* ifrst.html 和 second.html 中的代码请自行查看 */
    content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?receiveFileSafetyGrade='+encodeURIComponent(document.getElementsByName("documentSendFileSecurityGrade")[0] ?document.getElementsByName("documentSendFileSecurityGrade")[0].value:"")+'&receiveFileSendFileUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent(document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"") +'&accessorySaveName='+(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+(document.getElementsByName('p_wf_tableId')[0]?document.getElementsByName('p_wf_tableId')[0].value:"")+'&field4=' + encodeURIComponent(document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
    lock:true
});
//documentSendFileSecurityGrade 


}


//转本部门
function cmdDepartSend(){
 //  openPupWin("govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?todeaprat=1&tranType=1",500,250);
   	var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMyDep.jsp?todeaprat=1&tranType=1" ;
	openWin({url:hhref,width:620,height:420,winName:'SendcloseWinId'});
	//$.dialog({id:'SendcloseWinId',title:'转本部门',content: 'url:'+hhref+''});
}


//收文 转文件送审签
function  cmdToSendfilecheck(){
	
	$.dialog({
		title:'转文件送审签',
		id: 'LHG1976DE',
			resize: false,
		height:200,
			max: false,
    min: false,

			width:420,
		/* ifrst.html 和 second.html 中的代码请自行查看 */
		//content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?id='+document.getElementsByName("p_wf_recordId")[0].value+'&sendType=sendFile&sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+encodeURIComponent(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
		content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?id='+document.getElementsByName("p_wf_recordId")[0].value+'&sendType=sendFile&sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+ ((document.getElementsByName("contentAccName")[0].value==""||document.getElementsByName("contentAccName")[0].value=="null" )?"": encodeURIComponent(document.getElementsByName("contentAccName")[0] ?document.getElementsByName("contentAccName")[0].value:"") )+'&accessorySaveName1='+((document.getElementsByName("contentAccSaveName")[0].value==""||document.getElementsByName("contentAccSaveName")[0].value=="null" )?"": encodeURIComponent(document.getElementsByName("contentAccSaveName")[0] ?document.getElementsByName("contentAccSaveName")[0].value:"") )+'&accessorySaveName2='+(encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") )+'&tableId='+(document.getElementsByName('p_wf_tableId')[0]?document.getElementsByName('p_wf_tableId')[0].value:"")+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
		//content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_sendtosendfilecheck.jsp?id='+document.getElementsByName("p_wf_recordId")[0].value+'&sendType=sendFile&sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
		//content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_sendtosendfilecheck.jsp?id='+document.getElementsByName("p_wf_recordId")[0].value+'&sendType=sendFile&sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+encodeURIComponent(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),

		lock:true
	});
		//	content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?id='+document.getElementsByName("p_wf_recordId")[0].value+'&sendType=sendFile&sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+encodeURIComponent(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),

}

//公文交换
function  cmdGovExchange(){
	
	var url = "/defaultroot/GovExchange!load.action?editId=" +  $("input[name='p_wf_recordId']")[0].value +"&tableId="+   ( $("input[name='p_wf_tableId']")[0]?$("input[name='p_wf_tableId']")[0].value:"");
	openWin({url:url,width:620,height:350,isFull:true,winName:'govexchange'});
	//alert("暂未实现！");
	return;
	openPupWinScroll("/defaultroot/ExchangeAction.do?action=load&editId=" + document.all.editId.value+"&tableId=62",'width=600,height=500');
}

//
function cmdViewtext(){
		$("*[name='RecordID']").val($("*[name='content']").val());
				        var url="";
			        	url="/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?viewdoc=true&RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val()+"&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=1&showEditButton=0&FileType="+$("*[name='documentWordType']").val() ;
				      // if(document.all.sendFileCheckTitle){
					   if(document.getElementsByName("sendFileCheckTitle").length > 0 ){
				        url+="&copyType=1";
				       }
					//   alert(url);
			openWin({url:url,width:620,height:350,winName:'_blank'});
return ;
	
	$("*[name='RecordID']").val($("*[name='content']").val());
	
	var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	openWin({url:url,width:620,height:350,winName:'_blank'});

}
//批阅正文
function cmdReadtext(){
	//$("*[name='RecordID']").val($("*[name='content']").val() ) ;
	document.getElementsByName("RecordID")[0].value = document.getElementsByName("content")[0].value;
	
	var  myDatestr=""+new Date().getTime();
    var url="";
  
        url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+
            "&EditType=1&UserName="+$("*[name='UserName']").val()+"&CanSave=1&showTempSign=0&showTempHead=1&ShowSign=0&showSignButton=1&showTransPDF=1&showEditButton=1&saveDocFile=1&moduleType=govdocument&textContent=-1&FileType="+$("*[name='documentWordType']").val();
    

	openWin({url:url,width:620,height:350,winName:'afadfaf'});

	//var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val() +"&EditType=1&UserName="+$("*[name='UserName']").val()+"&ShowSign=0&CanSave=1";
	//openWin({url:url,width:620,height:350,winName:'sendtoother'});
}

//查看历史痕迹
function cmdReadHistorytext(){
	/*弹出WORK编辑器，编辑正文*/
	 $("*[name='RecordID']").val($("*[name='content']").val() ) ;
	 var url="/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+
		 "&EditType=0&UserName="+$("*[name='UserName']").val()+
		 "&CanSave=0&showTempSign=0&showTempHead=1&ShowSign=1&showSignButton=1&showEditButton=0&saveDocFile=0&moduleType=govdocument&textContent=-1&FileType="
	 +$("*[name='documentWordType']").val()+"&isViewOld=1";
	 openWin({url:url,width:620,height:350,winName:'_blank'});
}


//已查看用户
function showHasRead() {	postWindowOpen('/defaultroot/GovReceiveFileBoxAction.do?action=userinfo&type=showHasRead&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//未查看用户
function showNotRead() {	postWindowOpen('/defaultroot/GovReceiveFileBoxAction.do?action=userinfo&type=showNotRead&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//查看传阅
function viewRead(){
		alert("暂未实现！");
	return;
	postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_Read_main.jsp?tableId="+document.all.tableNameOrId.value+"&processId="+document.all.read_processId.value+"&recordId="+document.all.editId.value,'查看传阅','menubar=0,scrollbars=0,locations=0,width=800,height=600,resizable=no');
}

//阅读情况
function cmdGovRead(){

	
	//alert("暂未实现！");
	//return;
	//postWindowOpen('/defaultroot/GovReceiveFileBoxAction.do?action=userinfo&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
	//var url='/defaultroot/GovDocSend!userinfo.action?type=0&editId='+$("*[name='editId']").val();

	var url='/defaultroot/modules/govoffice/gov_documentmanager/readInfo.jsp?id='+$("*[name='p_wf_recordId']").val();
	openWin({url:url,width:620,height:350,isFull:true,winName:'readinfo'});
	

}


//查看正文
function  cmdSeeWord(){
	$("*[name='RecordID']").val($("*[name='content']").val());
	var url="";
   
        url="/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()
            +"&viewdoc=true&EditType=0&UserName="+$("*[name='UserName']").val()
            +"&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=1&showEditButton=0&FileType="
            +$("*[name='documentWordType']").val() ;
        if(document.all.sendFileCheckTitle){
            url+="&copyType=1";
        }
 
    openWin({url:url,width:620,height:350,winName:'seeword'});

	//var url = "/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+$("*[name='RecordID']").val()+"&EditType=0&UserName="+$("*[name='UserName']").val() +"&ShowSign=0&CanSave=1";
	//openWin({url:url,width:620,height:350,winName:'viewtext'});
					//	openWin({url:'',width:620,height:350,winName:'sendtoother'});
                    //  postWindowOpen(url, "editContent", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
					
}

//编号
function cmdChangeNumber(){
   
	var  wordValue=document.getElementsByName("sendFileDepartWord")[0].value;//$("*[name='sendFileDepartWord']").val(); 

     if(wordValue!="" && wordValue != undefined){		 
             mystr=wordValue.split(";");      
       		 var  sendWordId=mystr[0];
			
	   if(sendWordId==""){
			whir_alert("请先选择机关代字！");
			return ;

       }else{
			  //openPupWin("/defaultroot/GovSendFileAction.do?action=initZjkySendWord&sendWordId="+sendWordId+"&changeNumType=add",400,200);
	//openPupWin("/defaultroot/GovSendFileAction.do?action=initZjkySendWord&sendWordId="+sendWordId+"&changeNumType=add",400,200);
   				popup({id:'cmdChangeNumber_pop',title: '编号',fixed: true, left: '50%', top: '50%',width:'560px',height:'180px',padding: 0,drag: true, resize: true,lock: true,content: 'url:GovDocSend!initZjkySendWord.action?sendWordId='+sendWordId+'&changeNumType=add'}); 	
		   }
                
	 }else{
		 whir_alert("请先选择机关代字！");
	 
	  return;
	 
	 }       

}

//编号
function cmdPrint(){
   //打印
	var from = document.getElementsByName("from").length >0 ? document.getElementsByName("from")[0].value : "";
	
	//postWindowOpen("/defaultroot/GovSendFileAction.do?action=listLoad&editId=590&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&tableId=24&recordId=590&processId=952&workId=3272378", "", "TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600");
	var url='/defaultroot/GovDocSendProcess!showfile.action?p_wf_openType=print&flag=print&p_wf_recordId='+ $("*[name='p_wf_recordId']").val() + 
		'&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&p_wf_tableId='+  ( $("input[name='p_wf_tableId']")[0]?$("input[name='p_wf_tableId']")[0].value:"") + '&p_wf_pool_processId='
		+ $("*[name='p_wf_pool_processId']").val()  +"&from="+from;
	//alert(url);
	openWin({url:url,width:600,height:500,isFull:true,winName:'printWindow'});

}

//加入督办任务
function cmdGovUnionTask(){

	//acceName
	//acceSaveName
//    content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?
//receiveFileSendFileUnit='+encodeURIComponent(document.getElementsByName("documentSendFileWriteOrg")[0].value)+'&
//fileTitle='+encodeURIComponent(document.getElementsByName("documentSendFileTitle")[0].value)+'&byteNum='+encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0].value)+"&
//seqNum="+encodeURIComponent(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+
//'&accessoryName='+encodeURIComponent(document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"") +
//'&accessorySaveName='+(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +
//'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +
//'&accessoryName1='+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +
//'&accessorySaveName1='+(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +
//'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +
//'&accessorySaveName2='+(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +
//'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+
//'&receiveFileFileNumber='  + encodeURIComponent(document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
	// <input type="hidden" name="accessoryName"  id="accessoryName"  value="">
 	//  <input type="hidden" name="accessorySaveName"  id="accessorySaveName" value="">
	//正文//附件
	var acceName = "";
	var acceSaveName = "";
	if(document.getElementsByName("accessorySaveName").length >0){
		acceSaveName = document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"";
	}
	if(document.getElementsByName("accessoryName").length >0){
		acceName = encodeURIComponent(document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"");
	}
	
	var url='/defaultroot/urgetask!addTask.action?acceName='+acceName+'&acceSaveName='+ acceSaveName +'&actType=addTask&fromMod=sendfile&unionTaskTitle=' + $("*[name='documentSendFileTitle']").val() ;
	
	openWin({url:url,width:600,height:500,winName:'cmdGovUnionTask'});
	

}

/*选择文号*/
function changeNumber2(){
    if(GovSendFileActionForm.documentSendFileHead.value ==-1) {
    GovSendFileActionForm.documentSendFileByteNumber.value = "" ;
	if(GovSendFileActionForm.field1&&GovSendFileActionForm.field1.type!="hidden")
    GovSendFileActionForm.field1.value = "" ;
    if(GovSendFileActionForm.field2&&GovSendFileActionForm.field2.type!="hidden")
    GovSendFileActionForm.field2.value = "" ;
	if(GovSendFileActionForm.field3&&GovSendFileActionForm.field3.type!="hidden")
	GovSendFileActionForm.field3.value = "" ;
    return ;
    }
    document.all.ifrm.src = "/defaultroot/GovSendFileAction.do?action=initNumber&fileNumberId="+GovSendFileActionForm.documentSendFileHead.value+"&sendFileYear="+ GovSendFileActionForm.field2.value;
}

/**保存**/
function cmdSaveclose(){
	try{
		setCallBackName("");
	}catch(e){
	}
	if(wfCheckBeforeSaveClose()){
		$('#dataForm').attr("action","/defaultroot/GovDocSendProcess!save.action");
		//setCallBackName("saveOk");
		//$('#dataForm').submit();
		ok(0,document.getElementById("docinfo0"));
		//alert(document.getElementById("btn"));
		//document.getElementById("btn").click();
	}
}

function MTWordWindowDue(){
	var  myDatestr=""+new Date().getTime();  
    window.open("", "ec2"+ $("*[name='RecordID']").val()+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
	form1.target="ec2"+$("*[name='RecordID']").val()+myDatestr;
	form1.submit();
	managerDueWord(); 
}


function saveOk(){
	//whir_alert("保存成功！");
	//window.close();
}


//加入督办任务
function cmdGovUnionTask(){
		//cmdWordWindowReDue();
	//return;
	var acceName = "";
	var acceSaveName = "";
	if(document.getElementsByName("accessorySaveName").length >0){
		acceSaveName = document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"";
	}
	if(document.getElementsByName("accessoryName").length >0){
		acceName = (document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"");
	}
	
	var url='/defaultroot/urgetask!addTask.action?goldgridId='+$("input[name='content']")[0].value+'&acceName='+acceName+'&acceSaveName='+ acceSaveName +'&actType=addTask&fromMod=sendfile&unionTaskTitle=' + $("*[name='documentSendFileTitle']").val() ;
	
	openWin({url:url,width:600,height:500,isFull:true,winName:'cmdGovUnionTaskWin'});
	
}

function openDocEdit(fieldName, index, defaultVal, fileType, newOrUpdate){
    index = 0;
    if(newOrUpdate == "0"){//不可编辑
        window.open(whirRootPath +"/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+document.getElementsByName(fieldName)[0].value+"&EditType=4&_rowIndex="+index+"&UserName="+document.getElementsByName("UserName")[0].value+"&showTempSign=0&ShowSign=0&CanSave=0&moduleType=information&saveHtmlImage=0&saveDocFile=0&field="+fieldName+"&FileType="+fileType+"&showSignButton=1&initRecordId="+defaultVal, "", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
    }else if(newOrUpdate == "1"){//可编辑
        window.open(whirRootPath+"/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+document.getElementsByName(fieldName)[0].value+"&EditType=1&_rowIndex="+index+"&UserName="+document.getElementsByName("UserName")[0].value+"&textContent=-1&showTempSign=0&ShowSign=0&CanSave=1&moduleType=information&saveHtmlImage=0&saveDocFile=1&field="+fieldName+"&FileType="+fileType+"&showEditButton=1&showSignButton=1&initRecordId="+defaultVal, "", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
    }
}

$(document).ready( function(){
		/*
		if($("input[name='documentSendFileTitle']").length >0){
			$("input[name='documentSendFileTitle']").change(function(){
				$("#p_wf_titleFieldName").val($("input[name='documentSendFileTitle']").val());
	
			});
		}*/
});
