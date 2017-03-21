<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>发文</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <!--工作流包含页 js文件-->  
    <%@ include file="/public/include/meta_base_workflow.jsp"%>  

	<script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/send.js"   type="text/javascript"></script>
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
	.inputTextsw{
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
	
	-->
	</style>
	<style type="text/css">
        html,body{ height:100%; overflow:hidden; margin:0; padding:0;}
    </style>

    <script type="text/javascript">
    $(function(){
     var bh = $("body").height();
     var dh = bh-47;
     $("#mainContent").height(dh);
    });

	window.onresize = function() {
		 var bh = $("body").height();
		 var dh = bh-47;
		 $("#mainContent").height(dh);
	}

    </script>

</head>
<%

/// 控制按纽出现 
//String workStatus = request.getAttribute("p_wf_workStatus")==null?"":(String)request.getAttribute("p_wf_workStatus").toString();
String workStatus = request.getParameter("workStatus")==null?"":(String)request.getParameter("workStatus").toString();
String sendStatus=request.getAttribute("sendStatus")==null?"0":request.getAttribute("sendStatus").toString();
String modiButton = null;//"none";
//System.out.println("isEdit::"+request.getParameter("isEdit"));
if(request.getParameter("isEdit")!=null&&"1".equals(request.getParameter("isEdit").toString())){
 modiButton=",Viewtext,ReadHistorytext,Downtext,Print,SendToMyOther,SendToMyRange,GovRead";
 if(sendStatus.equals("1")){
 	modiButton=",Viewtext,ReadHistorytext,Downtext,Print,SendToMyOther,SendToMyRange,GovRead";
 }else{
 	if(!"1".equals(request.getParameter("isBack"))){
 		modiButton=",Saveclose,Viewtext,ReadHistorytext,Readtext,Wait,Print,SendToMyOther,SendToMyRange,GovRead,Back,GovExchange";
 	}else{
 		modiButton=",Saveclose,Viewtext,ReadHistorytext,Readtext,Wait,Print,SendToMyOther,SendToMyRange,GovRead,GovExchange";
 	}
 }
 	if(!"1".equals(request.getParameter("isBack"))){
 		modiButton=",Saveclose,Viewtext,ReadHistorytext,Readtext,Wait,Print,SendToMyOther,SendToMyRange,GovRead,Back,GovExchange";
 	}else{
 		modiButton=",Saveclose,Viewtext,ReadHistorytext,Readtext,Wait,Print,SendToMyOther,SendToMyRange,GovRead,GovExchange";
 	}
}else if(request.getParameter("viewOnly")!=null&&"1".equals(request.getParameter("viewOnly").toString())){
 	modiButton=",Viewtext,ReadHistorytext,Downtext,Print,GovRead";
}

//System.out.println("workStatus::"+workStatus);
if(workStatus.equals("102")){
  modiButton=",Viewtext,ReadHistorytext,Print";	 
}


if(workStatus.equals("100")){
	boolean canPrint = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getProcessCanPrint((String)request.getAttribute("p_wf_processId"));
	if(canPrint){
		modiButton=",Viewtext,EmailSend,AddNew,ReadHistorytext,SendToMyOther,Print";
	}else{
  		modiButton=",Viewtext,EmailSend,AddNew,ReadHistorytext,SendToMyOther";
  	}	 
}


if(workStatus.equals("2"))
modiButton="none";

if(request.getParameter("fromdesktop")!=null && !"null".equals(request.getParameter("fromdesktop")) && "2".equals(request.getParameter("fromdesktop"))){
	modiButton="";
}
if(workStatus.equals("-1"))
modiButton=",ReadHistorytext";
if(workStatus.equals("-2"))
modiButton=",ReadHistorytext";
	if("notsend".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		modiButton=",Viewtext,Wait,EmailSend,AddNew,Print,ReadHistorytext,Toreceive,Tocheck";
	}
	if("hassend".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		modiButton=",Viewtext,Wait,EmailSend,AddNew,Print,ReadHistorytext,Toreceive,Tocheck,GovExchange";
	}
	if("mycancel".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		modiButton=",Viewtext,Wait,EmailSend,AddNew,Print,ReadHistorytext,Toreceive,Tocheck,GovExchange";
	}
if( "waitingView".equals(  request.getAttribute("p_wf_openType") ) ){
	modiButton=",Viewtext,ReadHistorytext,Print,Downtext,Toreceive,Tocheck,EmailSend";

}//查看正文、查看历史痕迹、打印、下载文件
	
if( "startAgain".equals(  request.getAttribute("p_wf_openType") ) || "reStart".equals(  request.getAttribute("p_wf_openType") ) ){
	modiButton=",Send,Relation,WritetextModi";

}
if( "blcyview".equals( request.getParameter("from") )  ){
	modiButton=modiButton+",SendToMyOther";
}

if(!com.whir.common.util.CommonUtils.isForbiddenPad(request) && modiButton != null){
	 modiButton = modiButton.replaceAll(",Downtext","");
	 
	 modiButton = modiButton.replaceAll(",Readtext",",Downtext");
	 modiButton = modiButton.replaceAll(",Viewtext",",Downtext");
	 modiButton = modiButton.replaceAll(",SeeWord",",Downtext");
	 
}
if(!com.whir.common.util.CommonUtils.isForbiddenPad(request) && modiButton == null && request.getAttribute("p_wf_modiButton") != null){
	 modiButton =  (String)request.getAttribute("p_wf_modiButton");
	 modiButton = modiButton.replaceAll(",Downtext","");
	 
	 modiButton = modiButton.replaceAll(",Readtext",",Downtext");
	 modiButton = modiButton.replaceAll(",Viewtext",",Downtext");
	 modiButton = modiButton.replaceAll(",SeeWord",",Downtext");
	 
}
//System.out.println("modiButton::"+modiButton);
if(modiButton != null){
	request.setAttribute("p_wf_modiButton",modiButton);
}else{
	request.setAttribute("p_wf_modiButton",request.getAttribute("p_wf_modiButton"));//+",ReadHistorytext"
}

String  qianfaName="";
String  qianfaTime="";
String [] qianfaStr=new com.whir.ezoffice.bpm.bd.BPMCommonBD().getCommentUserAndDateByCommField((String)request.getAttribute("p_wf_tableId"),(String)request.getAttribute("p_wf_recordId"),"documentSendFileSendFile","2");
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
	
if( "blcyview".equals(  request.getParameter("from") ) || "blcyedit".equals(  request.getParameter("from") ) ){

	request.removeAttribute("p_wf_concealField");
	
}
 
%>
<body  class="docBodyStyle"  style="position:relative; height:100%;"      onload="initBody();">

<%
if((""+request.getAttribute("p_wf_modiButton")).indexOf("ChangeNumber")>=0 ){
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
	 <div style="height:47px; position:absolute; top:0; width:100%;z-index:1000;" >
	<jsp:include page="/public/toolbar/toolbar_include.jsp" > </jsp:include>
	 </div>
	 <div class=""  id="mainContent"  style="overflow-y:auto; position:absolute; top:47px; width:100%; _width:99%; "><!-- id="mainContent" style="height:100%;width:100%;overflow:auto;" -->
	 	 <input type="hidden" name="accessoryName1" value="<%=request.getAttribute("documentSendFileTitle")%>.doc">
		 <input type="hidden" name="accessorySaveName1" value="<%=request.getAttribute("sendFileText")%>.doc">

<form name="form1" action="public/iWebOfficeSign/DocumentEdit.jsp" method="post">
<input type="hidden" name="RecordID">
<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
<input type="hidden" name="EditType" value="1">
<input type="hidden" name="UserName" value="<%=session.getAttribute("userName")%>">
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
<input type="hidden" name="$sendFileProof" value="-1">
<input type="hidden" name="$zjkySecrecyterm" value="-1">
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
<input type="hidden" name="FileType">
<input type="hidden" name="$sendFileFileType">
</form>
<!--补发表单-->
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
	 <s:form name="GovSendFileActionForm" id="dataForm" action="GovDocSend!saveDraft.action" method="post" theme="simple" >
	<input type="hidden" name="oldTitle" value="<s:property  value="#request.sendFileTitle" />">
	<input type="hidden" name="oldToPerson1" value="<s:property  value="#request.toPerson1" />">
	<input type="hidden" name="oldToPerson2" value="<s:property  value="#request.toPerson2" />">
	<input type="hidden" name="oldToInnner" value="<s:property  value="#request.toInnner" />">
	<input type="hidden" name="documentWordType" value="<s:property  value="#request.documentWordType" />">
	 <input type="hidden" name="createdEmp" value="<%=request.getAttribute("createdEmp")%>">
	 <input type="hidden" name="createdOrg" value="<%=request.getAttribute("createdOrg")%>">
 <input type="hidden" name="fileVerifyCode" value="<%=request.getAttribute("fileVerifyCode")%>">




	 <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline"   >
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="#" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <li id="Panle4" ><a href="#" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
							  <li id="Panle5" ><a href="#" onClick="changePanle(5);">修改记录</a></li>
							  <li id="Panle6" ><a href="#" onClick="changePanle(6);">相关收文</a></li>

						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content"  align="center">
							<!--表单包含页-->
							<div  align="center" > 
						
								<iframe id="ifrm" name="ifrm" src="" style="width:0;height:0;display:none"></iframe><iframe id="ifrm1" name="ifrm1" src="" style="width:0;height:0;display:none"></iframe>
								<%
								
								com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
								String tableId_form = (String)request.getAttribute("p_wf_tableId");
								List tableInfoList = sendFileBD.getWfTableInfoByTableId(tableId_form); // 根据tableId
								// 找table
								// 信息
								String tableName = "";
			

								if (tableInfoList != null && tableInfoList.size() > 0) {
									Object[] tableInfoObj = (Object[]) tableInfoList.get(0);
									tableName = "" + tableInfoObj[0];
								}
								if (tableName.equals("发文表")) { //
									tableId_form = "standard";
								}
								String add = "/modules/govoffice/gov_documentmanager/forms/edit_"+tableId_form+"_sendform_include.jsp"; 
								File file = new File(request.getRealPath("") +
                                        add);
								if (!file.exists()) {
									new com.whir.govezoffice.documentmanager.actionsupport.GovCustomAction().replayGovCustomPage(request,tableId_form,"0","0");
							 
								}
								
								%> 
								<jsp:include page="<%=add %>"></jsp:include>  
								 
							</div>	
							<!--工作流包含页-->
							 <div>  <%try{%>
								   <%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%>
								  <%}catch(Throwable ex){ex.printStackTrace();}%>
						    </div>
							 <!--批示意见包含页-->  
                            <div>  
                                
                            </div>  
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo4" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo5" class="doc_Content" style="display:none">
 <%
  java.util.List updatelist=new java.util.ArrayList();
  java.util.List titlelist=new java.util.ArrayList();
  java.util.List mainlist=new java.util.ArrayList();
  java.util.List copylist=new java.util.ArrayList();
  java.util.List innerlist=new java.util.ArrayList();
  String [] titleArr=null;
  String [] mainArr=null;
  String [] copyArr=null;
  String [] innerArr=null;
  //com.whir.govezoffice.documentmanager.bd.SendFileBD  sendFileBD=new com.whir.govezoffice.documentmanager.bd.SendFileBD();
   if(request.getAttribute("p_wf_recordId")!=null&&!request.getAttribute("p_wf_recordId").equals(""))
    updatelist=sendFileBD.getAllSendDocumentUpdatePO((String)request.getAttribute("p_wf_recordId"));

	if(updatelist!=null&&updatelist.size()>0){
	   for(int i=0;i<updatelist.size();i++){
		Object [] updateObj=(Object[])updatelist.get(i);
        String empId=""+updateObj[7];
	
	    if(empId.equals("")){
       if(updateObj[4].toString().equals("1")){           
	   titleArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};
		}
		 if(updateObj[4].toString().equals("2")){
		mainArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};

		}

		if(updateObj[4].toString().equals("3")){
		copyArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};

		}

		if(updateObj[4].toString().equals("4")){
		innerArr=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};

		}
			
		}else{
       
	       if(updateObj[4].toString().equals("1")){           
	         String titleObj []=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};
		titlelist.add(titleObj);
		}

		 if(updateObj[4].toString().equals("2")){
		String mainObj[]=new String[]{(updateObj[3]==null?"":updateObj[3].toString()),""+updateObj[1],""+updateObj[6]};
			mainlist.add(mainObj);
		}

		if(updateObj[4].toString().equals("3")){
		String copyObj[]=new String[]{""+updateObj[3],""+updateObj[1],""+updateObj[6]};
		copylist.add(copyObj);
		}

		if(updateObj[4].toString().equals("4")){
		String  innerObj[]=new String[]{(updateObj[3]==null?"":updateObj[3].toString()),(updateObj[1]==null?"":updateObj[1].toString()),(updateObj[6]==null?"":updateObj[6].toString())};
		innerlist.add(innerObj);
		}
		
		
		}
	   }
	
	}


 %>
      <TABLE width="100%" 
     class="listTable">
  
        <TR class="listTableHead">
          <TD width="60%" class="td_lefttitle">修改内容</TD>
          <TD width="15%">修改人</TD>
          <TD width="25%">修改时间</TD></TR>
 
        <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>标题</B></TD></TR>

		  <%if(titleArr!=null&&titleArr.length>0){%>
		     
		  <TD width="50%"><%=titleArr[0]%></TD>
          <TD width="20%"><%=titleArr[1]%></TD>
          <TD width="30%"><%=titleArr[2]%></TD></TR>
		  
		  <%}%>

         <%if(titlelist!=null&&titlelist.size()>0){
		   for(int i=0;i<titlelist.size();i++){
			 Object []titleObj=(Object[])titlelist.get(i); %>  


		  <TR class="listTableLine1">
          <TD width="50%"><%=titleObj[0]%></TD>
          <TD width="20%"><%=titleObj[1]%></TD>
          <TD width="30%"><%=titleObj[2]%></TD></TR>
			   
		  <% }
		 
		 
		 }%> 
        

        <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>主送</B></TD></TR>
		   <%if(mainArr!=null&&mainArr.length>0){%>
		     
		  <TD width="50%"><%=mainArr[0]%></TD>
          <TD width="20%"><%=mainArr[1]%></TD>
          <TD width="30%"><%=mainArr[2]%></TD></TR>
		  
		  <%}%>
           
		   <%
		    if(mainlist!=null&&mainlist.size()>0){
			  for(int i=0;i<mainlist.size();i++){
			   Object mainObj[]=(Object[])mainlist.get(i);
				if( !(mainObj[0]==null||"0".equals(mainObj[0])) ){    
		   %>
			   
		  <TR class="listTableLine1">
          <TD width="60%"><%=(mainObj[0]==null||"0".equals(mainObj[0]))?"&nbsp;":mainObj[0]%></TD>
          <TD width="15%"><%=mainObj[1]%></TD>
          <TD width="25%"><%=mainObj[2]%></TD></TR>
			  
			 <% }
			  }
			}
		   %>

        <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>抄送</B></TD></TR>
		  <%if(copyArr!=null&&copyArr.length>0){%>
		     
		  <TD width="50%"><%=copyArr[0]%></TD>
          <TD width="20%"><%=copyArr[1]%></TD>
          <TD width="30%"><%=copyArr[2]%></TD></TR>
		  
		  <%}%>

		  <%
		   if(copylist!=null&&copylist.size()>0){
		      for(int i=0;i<copylist.size();i++){
			   Object [] copyObj=(Object[])copylist.get(i);
			   
				if( ! (copyObj[0]==null||"0".equals(copyObj[0])) ){
		   %>
             
			  <TR class="listTableLine1">
          <TD width="60%"><%=(copyObj[0]==null||"0".equals(copyObj[0]))?"&nbsp;":copyObj[0] %></TD>
          <TD width="15%"><%=copyObj[1]%></TD>
          <TD width="25%"><%=copyObj[2]%></TD></TR>  
			  
			 <%}
		     }
		   }
		  %>		  
		    <TR cellpadding="0" class="listTableLine2">
          <TD colSpan=3 class="td_lefttitle"><B>内部发送</B></TD></TR>
		   <%if(innerArr!=null&&innerArr.length>0){%>
		     
		  <TD width="50%"><%=innerArr[0]==null?"":innerArr[0]%></TD>
          <TD width="20%"><%=innerArr[1]==null?"":innerArr[1]%></TD>
          <TD width="30%"><%=innerArr[2]==null?"":innerArr[2]%></TD></TR>
		  
		  <%}%>
           
		   <%
		    if(innerlist!=null&&innerlist.size()>0){
			  for(int i=0;i<innerlist.size();i++){
			   Object innerObj[]=(Object[])innerlist.get(i);
			    	if( ! (innerObj[0]==null||"0".equals(innerObj[0])) ){   
		 	%>
		  <!--   
		  <TR>
          <TD width="60%"><%=(innerObj[0]==null||"0".equals(innerObj[0])) ?"&nbsp;":innerObj[0]%></TD>
          <TD width="15%"><%=innerObj[1]==null?"":innerObj[1]%></TD>
          <TD width="25%"><%=innerObj[2]==null?"":innerObj[2]%></TD></TR>	
          -->	  
		 <% }}} %>

 </TABLE>
 

					 
					 </div>
					 <div id="docinfo6" class="doc_Content"  style="display:none;"></div>
					 
                 </div>
				 <%@ include file="/platform/bpm/work_flow/operate/wf_include_comment.jsp"%>  
             </td>
         </tr>
     </table>
	 </s:form>
	 <%
	String accessoryName2=request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
	String accessorySaveName2=request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();
	//取附件信息
	String contentAccName=request.getAttribute("contentAccName")==null?"":request.getAttribute("contentAccName").toString();
	String contentAccSaveName=request.getAttribute("contentAccSaveName")==null?"":request.getAttribute("contentAccSaveName").toString();

	 %>
	 <form name="gdform" method="POST" action="/defaultroot/modules/govoffice/gov_documentmanager/sendfile_gd.jsp?gd=1">
		<input type="hidden" name="pageContent">
		<input type="hidden" name="fileTitle" value="<%=request.getAttribute("documentSendFileTitle")==null?"":request.getAttribute("documentSendFileTitle")%>">
		<input type="hidden" name="fileId" value="<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>">
		<input type="hidden" name="createdEmp" value="<%=session.getAttribute("userId").toString()%>">
		<input type="hidden" name="wh">
		<input type="hidden" name="dateTime">
		<input type="hidden" name="org" >
		<input type="hidden" name="fileName1" value="<%=contentAccName%>">
		<input type="hidden" name="saveName1" value="<%=contentAccSaveName%>">
		<input type="hidden" name="fileName2" value="<%=accessoryName2%>">
		<input type="hidden" name="saveName2" value="<%=accessorySaveName2%>">
		<input type="hidden" name="zwurl">
	</form>
	</div>
    <div class="docbody_margin"></div>
	<%try{%>
	<%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
	<%}catch(Throwable ex){ex.printStackTrace();}%>
</body>

<script type="text/javascript">

//initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

/**
 切换页面
 */

function  changePanle(flag){
//if( flag == 3 ) flag= 2;
	for(var i=0;i<7;i++){
		$("#Panle"+i).removeClass("aon");
	}
	$("#Panle"+flag).addClass("aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
    
	//显示流程图
	if(flag=="1"){
		//传流程图的div的id
       showWorkFLowGraph("docinfo1");
	}
	 //显示关联流程
	if(flag=="2"){
	   showWorkFlowLog("docinfo2");
	}
	//显示关联流程
	if(flag=="3"){
	   showWorkFlowRelation("docinfo3");
	}
 
	//显示相关附件
	if(flag=="4"){
	   showWorkFlowAcc("docinfo4");
	}
	if(flag=="6"){
	    var url="/defaultroot/GovDocSend!sendAssociate.action?sendFileId="+$("#p_wf_recordId").val();

		var html = $.ajax({url: url,async: false,cache:false}).responseText;

		$("#docinfo"+flag).html(html);
	}
	//http://localhost:7001/defaultroot/GovDocSend!sendAssociate.action
}
/**
初始话信息
*/
function initBody(){
	
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight);
	//初始话信息
    ezFlowinit();
	//hidfield();
}

function gd(){    

	//alert("归档");
	//document.all.contentText.style.display='';
	if(document.getElementById("gdword")){
		document.getElementById("gdword").style.display="inline";
	}
//	 var toolbarObjs = $('SPAN[id^=Panle]');
//	for(var k=0;k<toolbarObjs.length;k++){
//		if(!(toolbarObjs[k].innerText=='基本信息' || toolbarObjs[k].innerText=='流程记录' || toolbarObjs[k].innerText=='修改记录')){
//			toolbarObjs[k].parentNode.removeChild(toolbarObjs[k].nextSibling);
//			toolbarObjs[k].parentNode.removeChild(toolbarObjs[k]);
//		}
//		
//	}
    
   // gdform.fileTitle.value = GovSendFileActionForm.documentSendFileTitle.value;
   // gdform.fileId.value = GovSendFileActionForm.editId.value;
	gdform.wh.value=document.all.documentSendFileByteNumber?document.all.documentSendFileByteNumber.value:'';
	gdform.org.value=document.all.documentSendFileWriteOrg?document.all.documentSendFileWriteOrg.value:'';
	var signsendTime =document.all.signsendTime?document.all.signsendTime.value:'';
	if(signsendTime && signsendTime !='')gdform.dateTime.value=signsendTime.substring(0,4);
    var url="<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID=<%=request.getAttribute("content")%>&EditType=0&UserName="+document.all.UserName.value+"&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=0&showEditButton=0&FileType="+(document.all.documentWordType?document.all.documentWordType.value:"");
	if(document.all.sendFileCheckTitle){
		url+="&copyType=1";
	}
	
	gdform.zwurl.value=url;//查看正文的url

	//gdform.pageContent.value = document.body.innerHTML;
	gdform.pageContent.value = "<br><br><div style=\"padding:20px\">"+document.getElementById("docinfo0").outerHTML+"</div>";

	gdform.pageContent.value += "<"+"script>var newNode = document.createElement('a');newNode.href='#';newNode.onclick=function(){window.open('"+url+"','','TOP=0,LEFT=0, resizable=yes,width=800,height=600')};newNode.innerHTML ='<table width=100% ><tr><td align=left>&nbsp;&nbsp;&nbsp;&nbsp;查看正文</td></tr></table>';document.getElementById('docinfo0').insertBefore(newNode,document.getElementById('docinfo0').firstChild);<"+"/script>";

    gdform.submit();
}
<%if(request.getParameter("gd") != null){%>
gd();
<%}%>

function closeWin(){	
	$.dialog({id:'cmdSendToMyRange_pop'}).close();
}
</script>
 
</html> 
