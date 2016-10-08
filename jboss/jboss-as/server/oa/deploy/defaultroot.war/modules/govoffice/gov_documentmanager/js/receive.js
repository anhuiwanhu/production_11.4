
//选择来文单位
function  choosePerson(type,field,fieldId,title){
	var url = "GovDocReceiveProcess!chooseUnit.action?type="+type+"&field="+field+"&fieldId="+fieldId;
	openWin({url:url,width:620,height:350,winName:'sendtoother'});
	//postWindowOpen("SenddocumentBaseAction.do?action=unitlist_choose&type="+type+"&field="+field+"&fieldId="+fieldId,title,'menubar=0,scrollbars=yes,locations=0,width=800,height=600,resizable=yes');
}

//查看历史痕迹
function cmdReadHistorytext(){
	alert("未支持！");
}

function cmdSeeWord(){
}
function cmdReadtext(){
}
function cmdWordWindowFirst(){
}
function cmdViewtext(){
}
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
 
    t_recordId=$("*[name='"+name+"']").val() ;//eval("document.all."+name+".value");

	if(editType=="1"){
	  t_editType="1"; 
	  t_cansave="1"
	  t_showSignButton="1";
	  t_saveDocFile="1";
	  t_showEditButton="1";
	}
	var url="/defaultroot/public/iWebOfficeSign/DocumentEdit.jsp?RecordID="+t_recordId+"&EditType="+t_editType+"&UserName="+$("*[name='UserName']").val()+"&CanSave="+t_cansave+"&showTempSign="+t_showTempSign+"&showTempHead="+t_showTempHead+"&ShowSign="+t_showSiqn+"&showSignButton="+t_showSignButton+"&showEditButton="+t_showEditButton+"&saveDocFile="+t_saveDocFile+"&moduleType=govdocument&textContent=-1&FileType="+fileType+"&field="+name;
	//alert(url);
	openWin({url:url,width:620,height:350,winName:'editword'});
  // window.open(CommonJSResource.rootPath + ");


}

function changeSeqNum(){
	openWin({url:"GovDocReceiveProcess!iniSeqNum.action?processId="+$('#p_wf_pool_processId').val()+"",width:500,height:300,winName:"opeinit"});
}


/**保存**/
/*function cmdSaveclose(){
	if(wfCheckBeforeSaveClose()){
		$('#dataForm').attr("action","/defaultroot/GovDocSendProcess!save.action");

		setCallBackName("saveOk");
		$('#dataForm').submit();
	}
}*/
/**保存**/
function cmdSaveclose(){
	if(wfCheckBeforeSaveClose()){
		$('#dataForm').attr("action","/defaultroot/GovDocReceiveProcess!save.action");

		setCallBackName("saveOk");
		//$('#dataForm').submit();
		ok(0,document.getElementById("docinfo0"));
		//alert(document.getElementById("btn"));
		//document.getElementById("btn").click();
	}
}


function saveOk(){
	whir_alert("保存成功！",function(){	if( window.opener && window.opener.document.getElementById("queryForm") ){	window.opener.refreshListForm_("queryForm");} window.close();});
}

//加入督办任务
function cmdGovUnionTask(){
	var acceName = "";
	var acceSaveName = "";
	if(document.getElementsByName("accessorySaveName1").length >0){
		acceSaveName = document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"";
	}
	if(document.getElementsByName("accessoryName1").length >0){
		acceName = (document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"");
	}
	if(document.getElementsByName("accessoryName2").length >0){
		if(acceName == ""){
			acceName = (document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"");
		}else{
			acceName = acceName + "|" + (document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"");
		}
	}
	if(document.getElementsByName("accessorySaveName2").length >0){
		if(acceSaveName == ""){
			acceSaveName = document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"";
		}else{
			acceSaveName = acceSaveName + "|" + (document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"");
		}
	}
	

	//var url='/defaultroot/urgetask!addTask.action?actType=addTask&fromMod=receivefile&unionTaskTitle=' + ($("*[name='receiveFileTitle']").val() );
	var url='/defaultroot/urgetask!addTask.action?acceName='+acceName+'&acceSaveName='+acceSaveName +'&actType=addTask&fromMod=receivefile&unionTaskTitle=' + ($("*[name='receiveFileTitle']").val() );
	openWin({url:url,width:600,height:500,isFull:true,winName:'cmdGovUnionTaskWin'});
}


$(document).ready(function(){
	//由于份数数据库字段长度为5，页面长度为95，采用界面加载时更新份数文本框最大长度属性方法（老界面已经生成，无法通过改生成界面的方法完成）
	if($("input[name='receiveFileQuantity']") != null && $("input[name='receiveFileQuantity']") != undefined){
		$("input[name='receiveFileQuantity']").attr("maxlength",5);
	}
	

	/*	if($("input[name='receiveFileTitle']").length >0){
			$("input[name='receiveFileTitle']").change(function(){
				$("#p_wf_titleFieldName").val($("input[name='receiveFileTitle']").val());

	
			});
		}*/
});


//收文 转文件送审签
function  cmdToSendfilecheck(){
	//postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?id="+document.all.editId.value+"&sendType=sendFile&fileTitle="+document.all.documentSendFileTitle.value+"&accessory1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
	//postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?sendFileCheckComeUnit=初始化组织.初始二级组织.初始三级组织&id="+document.all.editId.value+"&sendType=sendFile&sendFileCheckComeUnit=&fileTitle=test&accessory1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
	//openWin({url:'/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp',width:620,height:350,winName:'sendToReceive'});
	
	//alert( document.getElementsByName("zjkySeq111") );
	//alert( document.getElementsByName("zjkySeq111").length );
	//alert( document.getElementsByName("zjkySeq111")[0] ? "111" : "222" );

	$.dialog({
		title:'转文件送审签',
		id: 'LHG1976DE',
			resize: false,
		height:200,
			max: false,
			min: false,
			width:420,
		/* ifrst.html 和 second.html 中的代码请自行查看 */
		content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?sendFileCheckComeUnit='+encodeURIComponent(document.getElementsByName("receiveFileSendFileUnit")[0]?document.getElementsByName("receiveFileSendFileUnit")[0].value:"")+'&fileTitle='+encodeURIComponent(document.getElementsByName("receiveFileTitle")[0] ?document.getElementsByName("receiveFileTitle")[0].value:"")+'&byteNum='+(document.getElementsByName("zjkySeq")[0] ?document.getElementsByName("zjkySeq")[0].value:"")+"&seqNum="+(document.getElementsByName("zjkySeq")[0]?document.getElementsByName("zjkySeq")[0].value:"")+"&sendRecordId="+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) +'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='+encodeURIComponent(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='+encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
		lock:true
	});
}


/**
起草正文
*/
function cmdWordWindowFirst(){
}


//收文 转发文
function  cmdTosend(){
//postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_ReToSend.jsp?id=234&receiveFileTitle="+document.all.receiveFileTitle.value+"&accessory1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=&tableId=23",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
//postWindowOpen("/defaultroot/govezoffice/gov_documentmanager/sendocument_bottom_ReToSend.jsp?id=234&receiveFileTitle=test2
//&accessory1=&accessorySaveName1=&accessoryName2=&accessorySaveName2=&tableId=23",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
 	$.dialog({
		title:'转发文',
		id: 'LHG1976DE',
			resize: false,
		height:200,
			max: false,
			min: false,
			width:420,
		/* ifrst.html 和 second.html 中的代码请自行查看 */
		content: 'url:/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_ReToSend.jsp?receiveFileTitle='
		+encodeURIComponent(document.getElementsByName("receiveFileTitle")[0].value)+'&id='+document.getElementsByName("p_wf_recordId")[0].value+'&sendRecordId='+document.getElementsByName("p_wf_recordId")[0].value+'&accessoryName='
		+encodeURIComponent((document.getElementsByName("accessoryName")[0] ?document.getElementsByName("accessoryName")[0].value:"")) 
			+'&accessorySaveName='+encodeURIComponent(document.getElementsByName("accessorySaveName")[0] ?document.getElementsByName("accessorySaveName")[0].value:"") 
			+'&accessoryName2='+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessoryName1='
		+encodeURIComponent(document.getElementsByName("accessoryName1")[0] ?document.getElementsByName("accessoryName1")[0].value:"") +'&accessorySaveName1='
		+encodeURIComponent(document.getElementsByName("accessorySaveName1")[0] ?document.getElementsByName("accessorySaveName1")[0].value:"") +'&accessoryName2='
		+encodeURIComponent(document.getElementsByName("accessoryName2")[0] ?document.getElementsByName("accessoryName2")[0].value:"") +'&accessorySaveName2='
		+encodeURIComponent(document.getElementsByName("accessorySaveName2")[0] ?document.getElementsByName("accessorySaveName2")[0].value:"") +'&tableId='
		+document.getElementsByName('p_wf_tableId')[0].value+'&field4=' + (document.getElementsByName('sendFileGrade')[0]?document.getElementsByName('sendFileGrade')[0].value:"")
			+'&receiveFileFileNumber='  + (document.getElementsByName("documentSendFileByteNumber")[0] ?document.getElementsByName("documentSendFileByteNumber")[0].value:""),
		lock:true
	});
}
 

//编号
function cmdPrint(){
   //打印
  //打印
	var from = document.getElementsByName("from").length >0 ? document.getElementsByName("from")[0].value : "";
	//postWindowOpen("/defaultroot/GovSendFileAction.do?action=listLoad&editId=590&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&tableId=24&recordId=590&processId=952&workId=3272378", "", "TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600");
	var url='/defaultroot/GovDocReceiveProcess!showfile.action?p_wf_openType=print&flag=print&p_wf_recordId='+ $("*[name='p_wf_recordId']").val() + 
		'&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&p_wf_tableId='+ $("*[name='p_wf_tableId']").val() + '&p_wf_processId='
		+ $("*[name='p_wf_processId']").val() +"&from="+from; ;
//	alert(url);
	openWin({url:url,width:600,height:500,isFull:true,winName:'printWindow'});

}


//检查页面参数有效性
function initPara(){
	
	if( $("input[type='text'][name='receiveFileSendFileUnit']").length>0 &&  /^[ ]*$/.test($("input[type='text'][name='receiveFileSendFileUnit']").val())){
		whir_alert("来文单位不能为空！",function(){$("input[type='text'][name='receiveFileSendFileUnit']").focus();});
		
		return false;
	}
	if( $("input[type='text'][name='receiveFileTitle']").length>0 && /^[ ]*$/.test($("input[type='text'][name='receiveFileTitle']").val()) ){
		whir_alert("标题不能为空！",function(){$("input[type='text'][name='receiveFileTitle']").focus();});
		
		return false;
	}

	if( $("input[name='receiveFileQuantity']").length > 0 && $("input[name='receiveFileQuantity']")[0].value != "" ){
		var ex = /^\d+$/;
		if ( ex.test(  $("input[name='receiveFileQuantity']")[0].value  ) ) {
		   // 则为整数
		}else{
			alert("份数必须是整数");
			return false;
		}
		
	}
	//加入自定义表单中如果是空的话就判断是否为空
	var canSubmit = beforeSubmit();
		if(!canSubmit){
			return false;
		}
	if($("*[name='isChangeSeq']").val() == 1){
			//var numId=document.all.seqId.value;
			var numId= $("*[name='seqId']").val();
			var numxuhao= $("*[name='field2']").val();
			//var numxuhao=document.all.field2.value;
			//var seq=document.all.zjkySeq.value;
			var seq= $("*[name='zjkySeq']").val();
	//alert(numId);
	//alert(numxuhao);
			if(numId!=""&&numxuhao!=""){
				//alert("enter");
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
					whir_alert("不能创建XMLHttpRequest对象实例.");
					return false;
				}else{
					var url = "/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_judge_receivenum.jsp?numId=" + numId+"&record=null"+"&field2="+numxuhao+"&zjkySeq="+seq+"&tmp="+new Date().getTime();
					//http_request.onreadystatechange = processRequest;
					/* 确定发送请求的方式和URL以及是否同步执行下段代码*/
					http_request.open("GET", encodeURI(url), false);/*此处需同步执行*/
					http_request.send(null);
				}
				if (http_request.readyState == 4) { /* 判断对象状态*/
					if (http_request.status == 200) { /*信息已经成功返回，开始处理信息*/
						var result = http_request.responseText;
						if(result == 0){
							whir_alert("收文流水号重复！");
							return false;
						}
					} else { /*页面不正常*/
						whir_alert("您所请求的页面有异常。");
						return;
					}
				}
			}
	}


	//alert( validateForm("dataForm"));
	//return  validateForm("dataForm");
	return true;
 
}
//增加收文文号验证 likun 20070427 start
//检查收文文号是否重复
//1。声明XMLHttp
var xmlHttp = false;
	try {
		xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
	} catch (e) {
		try {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} catch (e2) {
			xmlHttp = false;
		}
	}
	if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
		xmlHttp = new XMLHttpRequest();
	}
//2。发送验证信息到服务器
function checkreceiveFileCode(){
	xmlHttp.open("GET", "govezoffice/gov_documentmanager/govdocumentmanager_checkrecievefilecode.jsp?code="+document.all.field1.value+"["+document.all.field2.value+"]"+document.all.field3.value, true);
	xmlHttp.onreadystatechange = showResult;
	xmlHttp.send(null);
}
//3。将验证结过输出
function showResult(){
	if (xmlHttp.readyState == 4) {
		var response = xmlHttp.responseText;
		if(response.indexOf("OK")<0){
			document.all.field3.value="";
			whir_alert("收文编号重复，请修改！");
		}
	}
}
//增加收文文号验证 likun 20070427 end