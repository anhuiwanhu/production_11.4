<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SenddocumentBD" %>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovIssueUnitPO"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovCustomPO"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.CovCustomBD"%>
<%@ page import="com.whir.ezoffice.personnelmanager.bd.NewEmployeeBD,java.util.*,com.whir.org.vo.usermanager.EmployeeVO" %>
<%@ include file="/public/include/init.jsp"%>

<%@ page isELIgnored ="false" %>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%
whir_custom_str="tagit";

String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
//SendToMyRange
//request.setAttribute("p_wf_modiButton",",Saveclose,Writetext,ReadHistorytext,Readtext,Wait,Print,SendToMyOther,SendToMyRange,GovRead,Back,GovExchange");

//替换国产化环境
boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);

if(isCOSClient){
	//屏蔽 起草正文 批阅正文 查看正文  编辑正文 生成正式文件  查看历史记录 再次套红 

	String modiButton = (String)request.getAttribute("p_wf_modiButton");
	modiButton = modiButton.replaceAll(",Writetext",",");
	modiButton = modiButton.replaceAll(",WritetextModi",",");
	modiButton = modiButton.replaceAll(",Readtext",",");
	modiButton = modiButton.replaceAll(",Savefile",",");
	modiButton = modiButton.replaceAll(",Viewtext",",");
	modiButton = modiButton.replaceAll(",ReSavefile",",");
	modiButton = modiButton.replaceAll(",ReadHistorytext",",");
	if(modiButton != null){
		request.setAttribute("p_wf_modiButton",modiButton);
	}else{
		request.setAttribute("p_wf_modiButton",request.getAttribute("p_wf_modiButton"));//+",ReadHistorytext"
	}



}


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>发文</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform.css">
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform_ext.css">
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <!--工作流包含页 js文件-->  
   
	<%@ include file="/public/include/meta_base_bpm.jsp"%>

    <script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/send.js"   type="text/javascript"></script>
	<script  type="text/javascript">

	<%//快速发文 再加分发事件
 if("1".equals(request.getAttribute("isFastDoc"))){
	%>

	//发文分发
	function cmdSendclose(){
		 if(document.getElementById("flag_savefile") != undefined  && $("*[name='contentAccSaveName']").val() == ""  ){
			  alert("您还没有生成正式文件！");
			  return false;
		  }
		  //document.getElementsByName("documentSendFileByteNumber")[0].value 
		  if(document.getElementById("flag_ChangeNumber") != undefined  && document.getElementsByName("documentSendFileByteNumber")[0].value == ""  ){
			  alert("您还没有编号！");
			  return false;
		  }
		//if($("input[name='p_wf_pool_processType']")[0].value == "1"){
		
			
			
			var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_quickdoc.jsp?sendFileId=" + $("input[name='p_wf_recordId']")[0].value+"&processId=" +  $("input[name='p_wf_pool_processId']")[0].value +"&tableId=" + ( $("input[name='p_wf_tableId']")[0]?$("input[name='p_wf_tableId']")[0].value:"")  + "&recordId=" + $("input[name='p_wf_recordId']")[0].value ;




			//openWin({url:hhref,width:620,height:350,winName:'SendcloseWin'});
			$.dialog({id:'SendcloseWinId',title:'分发',width:620,height:280,content: 'url:'+hhref+''});
	}

 
	 <%
	 }
	 %>
	</script>

	<style type="text/css">
	<!--
	.sw {
		background:transparent;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 1px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		border-bottom-color: #CCCCCC;
	}

	.inputTextsw {
		background:transparent;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 1px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		border-bottom-color: #CCCCCC;
	}

	#noteDiv_toPerson1 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPersonBao {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPerson2 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	.divOver{
		background-color:#003399;
		color:#FFFFFF;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
		white-space:nowrap
	}
	.divOut{
		background-color:#ffffff;
		color:#000000;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
		white-space:nowrap
	}
	.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:"宋体"}
	
	body{
		position:static;
	}
	-->
	</style>

	 <style type="text/css">
        html,body{ height:100%; overflow:hidden; margin:0; padding:0;}
    </style>

    <script type="text/javascript">
     function screeBox(){
        var bh = $("body").height();
        var dh = bh-47;
        $("#mainContent").height(dh);
     }
    $(function(){
       screeBox();
        $(window).resize(function(){
        screeBox();
       });

    });
    </script>
	<%@ include file="/public/include/include_extjs.jsp"%>


<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform.css">
<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform_ext.css">
<script language="javascript" src="/defaultroot/scripts/i18n/zh_CN/WorkflowResource.js" type="text/javascript"></script>
<script language="javascript" src="/defaultroot/platform/custom/ezform/js/ezform.js"></script>
<script language="javascript" src="/defaultroot/platform/custom/ezform/js/popselectdata.js"></script>
<script language="javascript" src="/defaultroot/scripts/util/textareaAutoHeight2.js"></script>



</head>
<%

String  qianfaName="";
String  qianfaTime="";
/*String [] qianfaStr=new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getCommentUserAndDateByCommField((String)request.getAttribute("p_wf_tableId"),(String)request.getAttribute("p_wf_recordId"),"documentSendFileSendFile");
if(qianfaStr!=null&&qianfaStr.length>2){
  qianfaName=qianfaStr[1];
  qianfaTime=qianfaStr[2];
  if(qianfaTime!=null&&qianfaTime.length()>5){
       int nh = qianfaTime.indexOf("日");
	   if (nh != -1) {
        qianfaTime = qianfaTime.substring(0, nh+1) ;
       }
  }
}
*/
%>
<body  class="docBodyStyle"    style="position:relative; height:100%;"  onload="initBody();">


<%
//System.out.println(":::::::::::::::::::::::::::::::::::::::::::::::"+request.getAttribute("p_wf_modiButton"));
if((""+request.getAttribute("p_wf_modiButton")).indexOf("Code")>=0 ){
	%>
	<input type="hidden" id="flag_ChangeNumber" value="">
	<%
}

%>
<%
if((""+request.getAttribute("p_wf_modiButton")).indexOf("WordWindowDue")>=0 ){
	%>
	<input type="hidden" id="flag_WordWindowDue" value="">
	<%
}

%>

<%
if((""+request.getAttribute("p_wf_modiButton")).indexOf("Savefile")>=0 ){
	%>
	<input type="hidden" id="flag_savefile" value="">
	<%
}

%>
       <!--包含头部--->
	     <div style="height:47px; position:absolute; top:0; width:100%;" >
			<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
		</div>
		<div class="" id="mainContent"  style="overflow-y:auto; position:absolute; top:47px; width:100%; _width:99%; "><!-- id="mainContent" style="height:100%;width:100%;overflow:auto;" -->
<form name="sendToMyOtherForm" id="sendToMyOtherForm" method="post" action="<%=rootPath%>/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_other.jsp" >
<input type="hidden" name="p_wf_recordId" value="<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>"/>
	<table width="100%" style="display='none'">
		<input type="hidden" id="sendToMyRange2" name="sendToMyRange2" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>">
	</table>
</form>
<!--分发范围表单-->
<form name="sendToMyForm" id="sendToMyForm" action="<%=rootPath%>/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_range.jsp" method="post" >
<input type="hidden" id="sendToMyRange3" name="sendToMyRange3" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>"/>
<input type="hidden" name="p_wf_recordId" value="<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>"/>

<input type="hidden" id="sendToIdNew" name="sendToIdNew" value="<%=request.getAttribute("sendToId")==null?"":request.getAttribute("sendToId").toString()%>"/>
<input type="hidden" name="sendToNameNew" id="sendToNameNew" value="<%=request.getAttribute("sendToName")==null?"":request.getAttribute("sendToName").toString()%>"/>


</form>

<form name="form1" action="public/iWebOfficeSign/DocumentEdit.jsp" method="post">
<input type="hidden" name="RecordID">
<input type="hidden" name="remakehead">
<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
<input type="hidden" name="EditType" value="5">
<input type="hidden" name="sendfileNUM"> 
<input type="hidden" name="UserName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" id="sys_userName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" name="ShowSign" value="0">
<input type="hidden" name="CanSave" value="1">
<input type="hidden" name="showTempSign" value="0">
<input type="hidden" name="showTempHead" value="1">
<input type="hidden" name="showSignButton" value="1">
<input type="hidden" name="showEditButton" value="1">
<input type="hidden" name="loadTemp" value="1">
<input type="hidden" name="textContent" value="-1"> <!--  1 套用 content   0  不套用 content-->
 <input type="hidden" name="sendFileRedHeadId_1"  >
 <input type="hidden" name="Template" >
 <input type="hidden" name="hasSeal">
 <input type="hidden" name="$underwriteTime" value="-1">
<input type="hidden" name="$sendFileGrade" value="-1">
<input type="hidden" name="$documentSendFileWriteOrg" value="-1">
<input type="hidden" name="$documentSendFileTopicWord" value="-1">
<input type="hidden" name="$toPerson1" value="-1">
<input type="hidden" name="$toPerson2" value="-1">
<input type="hidden" name="$toPersonBao" value="-1">
<input type="hidden" name="$toPersonInner" value="-1">
<input type="hidden" name="$documentSendFilePrintNumber" value="-1">
<input type="hidden" name="$sendFileDepartWord" value="-1">
<input type="hidden" name="$senddocumentTitle" value="-1">
<input type="hidden" name="$underwritePerson" value="[签发人]<%="".equals(qianfaName)?"":qianfaName%>">
<input type="hidden" name="$securityGrade" value="-1">
<input type="hidden" name="$documentSendFileSendTime" value="-1">
<input type="hidden" name="$referenceAccessoryDesc" value="-1">
<input type="hidden" name="$documentSendFileAssumePeople" value="-1">
<input type="hidden" name="$sendFileAgentDraft" value="-1">
<input type="hidden" name="$sendFileAccessoryDesc" value="-1">
<input type="hidden" name="$sendfileNUM" value="-1">
<input type="hidden" name="$documentFileType" value="-1">
<input type="hidden" name="$signsendTime" value="-1">
<input type="hidden" name="$sendFilePrinter" value="-1">
<input type="hidden" name="$sendFileProof" value="-1">
<input type="hidden" name="$field9" value="-1">
<input type="hidden" name="$field10" value="-1">
<input type="hidden" name="$sendFileDraft" value="-1">
<input type="hidden" name="$zjkySeq" value="-1">
<input type="hidden" name="$zjkySecrecyterm" value="-1">
<input type="hidden" name="$zjkyContentLevel" value="-1">
<input type="hidden" name="$documentSendFileCounterSign" value="-1">
<input type="hidden" name="$openProperty" value="-1">
<input type="hidden" name="$documentSendFileCheckDate" value="-1">
<input type="hidden" name="$documentSendFileTime" value="-1">
<input type="hidden" name="showTransPDF" value="0">
<input type="hidden" name="moduleType"  value="govdocument">
<input type="hidden" name="saveDocFile"  value="1">
<input type="hidden" name="wordId">
<input type="hidden" name="FileType" value=".doc">
<input type="hidden" name="$sendFileFileType">
<input type="hidden" name="isWordWindowFirst" value="1"><!--是起草正文页面,只有发起页面才会判断正文内容及修改情况-->
</form>

		 <s:form name="GovSendFileActionForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >
		 <input type="hidden" name="documentWordType" value=".doc">
         <s:hidden name="tempFilename" value="" id="tempFilename" />
		 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
			 <tr valign="top">
				 <td height="100%">
					<div class="docbox_noline"   >
						   <div class="doc_Movetitle">
							 <ul>
								  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
								  <!--<li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li>--> 
								  <li id="Panle1" ><a href="javascript:void(0);" onClick="changePanle(1);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
								  <!--<li id="Panle3" ><a href="#" onClick="changePanle(3);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>-->
							 </ul>
						   </div>  
						   <div class="clearboth"></div>  
						   <div id="docinfo0" class="doc_Content"  align="center">
								<!--表单包含页--><!--<input type="button" value="保存草稿" onclick="cmdSaveDraft()">
												 <input type="button" value="起草正0文" onclick="wordWindowFirst()">-->
								
								<div  align="center"> 
								<%
								com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
								String tableId_form = (String) request.getAttribute("p_wf_tableId");
								
								List tableInfoList = sendFileBD.getWfTableInfoByTableId(tableId_form); // 根据tableId
								// 找table
								// 信息
								String tableName = "";
			

								if (tableInfoList != null && tableInfoList.size() > 0) {
									Object[] tableInfoObj = (Object[]) tableInfoList.get(0);
									tableName = "" + tableInfoObj[0];
								}

								//System.out.println("============="+tableName);
								if (tableName.equals("发文表")) { //
									tableId_form = "standard";
								}
								
								String add = "/modules/govoffice/gov_documentmanager/forms/new_"+tableId_form+"_sendform_include.jsp"; 
							
								File file = new File(request.getRealPath("") +
                                        add);
								if (!file.exists()) {
									new com.whir.govezoffice.documentmanager.actionsupport.GovCustomAction().replayGovCustomPage(request,tableId_form,"0","0");
							 
								}
								%> 
							
								<jsp:include page="<%=add %>"></jsp:include>  
								
								<%
								//String tableId_form = request.getParameter("p_wf_tableId");
								//System.out.println("========"+tableId_form);
								//CovCustomBD bd = new CovCustomBD();
								//GovCustomPO po = bd.loadGovCustomPO(tableId_form);
								//String html = po.getGovFormContent();
								//System.out.println("========"+html);
								//com.whir.ezoffice.ezform.util.ModuleParser parser = new com.whir.ezoffice.ezform.util.ModuleParser();
								//out.println( parser.parseHtml("","1",html,request));
								%>	
								</div>	
								<!--工作流包含页-->
								<div>  
									  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
								</div>
								
						  </div>
						 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
						 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
						 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					 </div>
					 <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
				 </td>
			 </tr>
		 </table>
		 </s:form>
		</div>
		<div class="docbody_margin"></div>
		<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>
</body>

<script type="text/javascript">
    $(function(){
        $.fn.autoTextarea = function (options) {
            var defaults = {
                maxHeight: null,//文本框是否自动撑高，默认：null，不自动撑高；如果自动撑高必须输入数值，该值作为文本框自动撑高的最大高度
                minHeight: $(this).height() //默认最小高度，也就是文本框最初的高度，当内容高度小于这个高度的时候，文本以这个高度显示
            };
            var opts = $.extend({}, defaults, options);
            return $(this).each(function () {
                $(this).bind("paste cut keydown keyup focus blur", function () {
                    var height, style = this.style;
                    this.style.height = opts.minHeight + 'px';
                    if (this.scrollHeight > opts.minHeight) {
                        if (opts.maxHeight && this.scrollHeight > opts.maxHeight) {
                            height = opts.maxHeight;
                            style.overflowY = 'scroll';
                        } else {
                            height = this.scrollHeight;
                            style.overflowY = 'hidden';
                        }
                        style.height = height + 'px';
                    }
                });
            });
        };
        $("textarea").autoTextarea({maxHeight:1000});
    });
    /**
 切换页面
 */
function  changePanle(flag){
	//if( flag == 3 ) flag= 2;
	for(var i=0;i<2;i++){
		//if(i==1 || i==3){
		//	continue;
		//}
		$("#Panle"+i).removeClass("aon");
	}

	$("#Panle"+flag).addClass("aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
    
	//显示流程图
	if(flag=="1"){
		//传流程图的div的id
         showWorkFlowRelation("docinfo1");//showWorkFLowGraph("docinfo1");
	}
    //显示关联流程
	if(flag=="2" ){
	  // showWorkFlowRelation("docinfo2");
	}
}

/**
刷新相关流成
*/
function  refreshRelation(){
  
     //showWorkFlowRelation($("#relationLiId").val()); 
	 var recordId=$("#p_wf_recordId").val();
	 //新增时刷新相关流程列表
	 if(recordId==""||recordId=="null"){
		 changePanle("1");
	 }else{
	     //修改时刷新相关流程列表
	     changePanle("1");
	 } 
}


/**
初始话信息
*/
function initBody(){
	//var windowWidth = window.screen.availWidth;
	//var windowHeight = window.screen.availHeight;
	//window.moveTo(0,0);
	//window.resizeTo(windowWidth,windowHeight);
	//初始话信息
    ezFlowinit();

	//hidfield();
//角色选择  组织
		var cb2 = new Ext.form.ComboBox({
			id : 'queryOrg_extId',  
			typeAhead: true,
			triggerAction: 'all',
			transform:'sendFileDepartWord',
			hiddenName:'sendFileDepartWord',
			name:'queryOrg_name',
		
			forceSelection:true, 
			listeners:{
				select:{
					fn:function(combo, record, index){
						//changeChannel(this); 
						// changeTable(this); 
					}
				}
			}
		}); 
		changeSenddocumentWordOnload();
}
 <%//快速发文 再加分发事件
 //System.out.println("==========isFastDoc=============" + request.getAttribute("isFastDoc"));
 if("1".equals(request.getAttribute("isFastDoc"))){
 %>
 // 发文分发
function cmdSendToMy(useOrgUsers){
//< %=sendStatus% >
		
	var  toId=$("input[name='sendToMyId']")[0].value;

	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;

	var  t_p_wf_recordId=$("input[name='p_wf_recordId']")[0].value;//document.all.editId.value;
	//alert(t_p_wf_recordId);
	//if( t_p_wf_recordId == "" ){
		//alert(11);
	//	whir_alert("请先保存再分发");
	//    return;
	//}
	//alert(12);
	
	if(toName==""){
	    whir_alert("请选择接收者");
	    return;
	}
	//alert($("input[name='sendFileCanDownload']").val());
	$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovDocSend!quickSendToMyReceive.action?sendFileCanDownload="+$("input[name='sendFileCanDownload']").val()+"&useOrgUsers="+useOrgUsers+"&sendType=1&p_wf_recordId="+t_p_wf_recordId+"&isEdit=1&documentSendFileTitle="+$("input[name='documentSendFileTitle']").val()+"&sendFileNeedMail="+$("#dataForm input[name='sendFileNeedMail']").val()+"&sendFileNeedRTX="+$("#dataForm input[name='sendFileNeedRTX']").val()+"&sendFileNeedSendMsg2="+$("#dataForm input[name='sendFileNeedSendMsg2']").val()+"&isinmodijsp=0&isSendToMyOther="+$("input[name='isSendToMyOther']").val());
	//	document.all.GovSendFileActionForm.action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=0&isSendToMyOther="+document.all.isSendToMyOther.value);
	//isInModify=isInModify&sendStatus=0&
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	//$("form[name='GovSendFileActionForm']")[0].submit();
	//alert(14);

	var options = {       success:          function(data){   
		var json = eval("("+data+")").result;
		$("input[name='p_wf_recordId']")[0].value = (json);             
	}}; 
	$("form[name='GovSendFileActionForm']").ajaxSubmit(options);
	whir_alert("分发成功！");
	$("form[name='GovSendFileActionForm']")[0].target="";

	

}

//发文分发
function cmdSendclose(){
  
    //sendClose();
    //openPupWin(CommonJSResource.rootPath+"/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp",500,250);
    //openPupWin(CommonJSResource.rootPath+"/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?sendFileId=" + document.all.editId.value+"&processId=" +document.all.processId.value +"&tableId=" +document.all.tableId.value + "&recordId=" + document.all.recordId.value +"&activityId=" + document.all.curActivityId.value+"&submitPersonId=" +document.all.submitPersonId.value+"&tranFromPersonId="+document.all.tranFromPersonId.value ,500,250);
	//var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?sendFileId=" + $("input[name='p_wf_recordId']")[0].value+"&processId=" +$("input[name='p_wf_processId']")[0].value +"&tableId=" +$("input[name='p_wf_tableId']")[0].value + "&recordId=" + $("input[name='p_wf_recordId']")[0].value +"&activityId=" + $("input[name='p_wf_recordId']")[0].value document.all.curActivityId.value+"&submitPersonId=" +document.all.submitPersonId.value+"&tranFromPersonId="+document.all.tranFromPersonId.value  ;

	//if($("input[name='p_wf_pool_processType']")[0].value == "1"){
		var hhref = "/defaultroot/modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_quickdoc.jsp?sendFileId=" + $("input[name='p_wf_recordId']")[0].value+"&processId=" +  $("input[name='p_wf_pool_processId']")[0].value +"&tableId=" + ( $("input[name='p_wf_tableId']")[0]?$("input[name='p_wf_tableId']")[0].value:"")  + "&recordId=" + $("input[name='p_wf_recordId']")[0].value +"&activityId=" + $("input[name='p_wf_cur_activityId']")[0].value +"&p_wf_pool_processType="+  $("input[name='p_wf_pool_processType']")[0].value+"&p_wf_cur_activityId="+  $("input[name='p_wf_cur_activityId']")[0].value+"&p_wf_processInstanceId="+  $("input[name='p_wf_processInstanceId']")[0].value+"&p_wf_taskId="+  $("input[name='p_wf_taskId']")[0].value;




		//openWin({url:hhref,width:620,height:350,winName:'SendcloseWin'});
		$.dialog({id:'SendcloseWinId',title:'分发',width:620,height:350,content: 'url:'+hhref+''});

	//}else{

	//}
}

 
 <%
 }
 %>
//设置拟稿人 拟稿单位 拟稿日期 拟稿人电话 --由于发文保存草稿的时候，拟稿人电话有时候可能没有，所以 以用户自己设置为准 -modify by gexiang
<%
String curUserID = session.getAttribute("userId").toString();
List  list = new NewEmployeeBD().selectSingle(new Long(curUserID));
Object[] object = (Object[]) list.get(0);
EmployeeVO vo = (EmployeeVO)object[0];
String telephone = vo.getEmpBusinessPhone()==null?"":vo.getEmpBusinessPhone();
String WriteOrg =(String)session.getAttribute("orgName");
String WriteUser =(String)session.getAttribute("userName");
%>
if( $("*[name='sendFileDraft']").length >0){ 
	$("*[name='sendFileDraft']").val("<%=WriteUser%>"); 
}
if( $("*[name='documentSendFileWriteOrg']").length >0){ 
	$("*[name='documentSendFileWriteOrg']").val("<%=WriteOrg%>"); 
}
//if( $("*[name='field9']").length >0){ 
//	$("*[name='field9']").val("<%=telephone%>"); 
//}


</script>
 
</html>

