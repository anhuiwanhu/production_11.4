<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %><%@page import="com.whir.component.security.crypto.EncryptUtil"%><%
request.setCharacterEncoding("UTF-8");//处理中文乱码

com.whir.govezoffice.documentmanager.action.GovSendFileActionForm myform = (com.whir.govezoffice.documentmanager.action.GovSendFileActionForm)request.getAttribute("myform") ;

com.whir.govezoffice.documentmanager.po.GovDocumentSendFilePO po = (com.whir.govezoffice.documentmanager.po.GovDocumentSendFilePO) request.getAttribute("po") ;
		String toMe = request.getParameter("toMe")==null?"":request.getParameter("toMe");

   int smartInUse = 0;
   if(sysMap != null && sysMap.get("附件上传") != null){
    	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
   }

   String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
		com.whir.component.security.crypto.EncryptUtil util1 = new com.whir.component.security.crypto.EncryptUtil();
		String filename= po.getGoldGridId() + po.getDocumentWordType();
	String dlcode = util1.getSysEncoderKeyVlaue("FileName",
						filename, "dir");
   String  url = (smartInUse==1?"/defaultroot/public/download":fileServer) + "/download.jsp?verifyCode=" + dlcode + "&FileName=" + filename + "&name=" + java.net.URLEncoder.encode(po.getDocumentSendFileTitle(),"UTF-8") + po.getDocumentWordType() + "&path=govdocumentmanager";

   
	 if(!com.whir.common.util.CommonUtils.isForbiddenPad(request)){
		response.sendRedirect(url);
	 }

   String userId1=session.getAttribute("userId").toString();
   String OrgId1=session.getAttribute("orgId").toString();
   String uo=userId1+OrgId1;


   String accessoryName = request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
   String accessorySaveName = request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();

    String accessoryName1 = request.getAttribute("contentAccName")==null?"":request.getAttribute("contentAccName").toString();
   String accessorySaveName1 = request.getAttribute("contentAccSaveName")==null?"":request.getAttribute("contentAccSaveName").toString();

	String sendFileWriteOrg=request.getAttribute("sendFileWriteOrg")==null?"":request.getAttribute("sendFileWriteOrg").toString();
	String sendFileTopicWord=request.getAttribute("sendFileTopicWord")==null?"":request.getAttribute("sendFileTopicWord").toString();

   String  read_tableId=(String)request.getAttribute("p_wf_tableId");
   String  read_processId=(String)request.getAttribute("p_wf_processId");
   String  read_recordId=(String)request.getAttribute("p_wf_recordId");
   String SendToMyRange = (String)request.getAttribute("SendToMyRange")==null?"":request.getAttribute("SendToMyRange").toString();
 
	//java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
	//int smartInUse = 0;
	//if(sysMap != null && sysMap.get("附件上传") != null){
	//	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
	//}

	// String modiButton = ",Viewacc,Toselfdept,Toreceive,Viewread,End";
	request.setAttribute("p_wf_cur_ModifyField",null);  

   String modiButton = ",Toreceive,DepartSend,Hasread,Noread,SendToMyRange,GovRead,BackDoc";

   String workStatus=request.getParameter("workStatus")==null?"-3":request.getParameter("workStatus").toString();

      if(request.getParameter("myFile")!=null&&request.getParameter("myFile").toString().equals("1")){
		
		String queryNumber=request.getParameter("queryNumber")==null?"":request.getParameter("queryNumber").toString();
		String queryTitle=request.getParameter("queryTitle")==null?"":request.getParameter("queryTitle").toString();
		String queryOrg=request.getParameter("queryOrg")==null?"":request.getParameter("queryOrg").toString();

		String _page_off=request.getParameter("pager.offset")==null?"0":request.getParameter("pager.offset").toString();
		String tag=request.getParameter("tag")==null?"0":request.getParameter("tag").toString();
		
		String queryItem = request.getParameter("queryItem")==null?"":request.getParameter("queryItem");
		String queryBeginDate = request.getParameter("queryBeginDate")==null?"":request.getParameter("queryBeginDate");
		String queryEndDate = request.getParameter("queryEndDate")==null?"":request.getParameter("queryEndDate");


		%>
     <script>
			var myUrl = "GovReceiveFileBoxAction.do?action=list&queryNumber=<%=queryNumber%>&queryTitle=<%=queryTitle%>&queryOrg=<%=queryOrg%>&pager.offset=<%=_page_off%>&tag=<%=tag%>";
			<%if(!"".equals(queryItem)){%>
				myUrl += '&queryItem=<%=queryItem%>&queryBeginDate=<%=queryBeginDate%>&queryEndDate=<%=queryEndDate%>';
			<%}%>
				<%if(!"1".equals(toMe)){%>			
		window.opener.location.href=encodeURI(myUrl);
		<%}%>
	    // UTFWindowOpener.location.reload();
	</script>
	<%}else{
		modiButton = ",Toreceive,DepartSend,Hasread,Noread,SendToMyRange,GovRead,GovCollection,BackDoc";//增加阅读情况
	}

	if(workStatus.equals("2")){
		modiButton = ",End,DepartSend,Toreceive,Hasread,Noread,TranRead,SendToMyRange,BackDoc";
	}
	if("notsend".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		modiButton=",Viewtext,Wait,Print,EmailSend,AddNew,ReadHistorytext,SendToReceive,ToSendfilecheck,BackDoc";
	}
	if("hassend".equals(request.getParameter("fromex")) ){
		//关闭、打印、催办、查看正文、邮件转发、新建流程、转收文、转文件送审签、公文交换、查看历史痕迹
		modiButton=",Viewtext,Wait,Print,EmailSend,AddNew,ReadHistorytext,SendToReceive,ToSendfilecheck,GovExchange,BackDoc";
	}
	if(request.getParameter("viewonly") != null ){
		modiButton = "";
	}
	if(!"".equals(toMe)){		
		modiButton = modiButton.replaceAll(",BackDoc","");
	}
	request.setAttribute("p_wf_modiButton",modiButton);
/*
   if(workStatus.equals("102")){
   modiButton = ",Viewacc,Toselfdept,Toreceive,Viewread";
   
   }
   if(workStatus.equals("-3")){
    modiButton = ",Viewacc";
   
   }*/
   //是否可下载，是从列表中传入的参数
   String canDownLoad = request.getParameter("canDownLoad")==null?"0":request.getParameter("canDownLoad").toString();
%>
<%if(sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")){%>
<!--<object classid="clsid:A7EE3B4B-DB6C-4957-A904-DD7EA2BB3DCB"
	id="ActiveFormX2" width="1" height="1" codebase="public/jsp/pdown.cab#version=1.0.19.0">
	<param name="Color" value="15592680">
	<param name="ftpuser" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("user")%>">
	<param name="ftppwd" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("password")%>whir?!">
	<param name="ftpport" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("port")%>">
	<param name="dddd" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("ddd")%>">
	<param name="ftphost" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("server")%>">
	<param name="curpath" value="govdocumentmanager">
</object>-->
<%}%>
<%String fileTitle1= myform.getDocumentSendFileTitle()==null?"":myform.getDocumentSendFileTitle();
  String  byteNum=myform.getDocumentSendFileByteNumber()==null?"":myform.getDocumentSendFileByteNumber();
  String  seqNum=myform.getZjkySeq()==null?"":myform.getZjkySeq();
  String sendRecordId=request.getParameter("editId")==null?"":request.getParameter("editId").toString();
  String mRecordID_1=myform.getSendFileText()==null?"":myform.getSendFileText();
  String mTemplate_1=request.getParameter("Template")==null?"":request.getParameter("Template").toString();
  String mFileType_1=myform.getDocumentWordType()==null?"":myform.getDocumentWordType().toString();
  String mEditType_1=request.getAttribute("copyEnable")==null?"0":request.getAttribute("copyEnable").toString();
   
	String fileTitle="";

	for(int k=0;k<fileTitle1.length();k++)
	{
	if(fileTitle1.charAt(k)==13||fileTitle1.charAt(k)==10)
	fileTitle+="";
	else
	fileTitle+=fileTitle1.charAt(k);
	}
%>
<%
String editId=request.getParameter("editId");//发文记录ID
//String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%if("1".equals(request.getParameter("showReceiveFile"))){%>收文查阅<%}else{%>收文查阅<%}%></title><!--发文查阅-->
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<style>
		html,body {height:100%;}
	</style>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<%@ include file="/public/include/meta_base_workflow.jsp"%>  

<link rel='stylesheet' type='text/css' href='test.css'>
<link href="style/cssmain.css" rel="stylesheet" type="text/css">
<link href="skin/<%=session.getAttribute("skin")%>/style.css" rel="stylesheet" type="text/css" />
<SCRIPT language="javascript" src="js/openEndow.js"></SCRIPT>
<script src="js/toolbar/standardModi.js" language="javascript"></script>
<script src="js/toolbar/govsendfileModi.js" language="javascript"></script>
<script>

//收藏
function cmdGovCollection(){
	//alert(1);
	var userChannelName = '公文管理';
/*
   String  read_tableId=(String)request.getAttribute("p_wf_tableId");
   String  read_processId=(String)request.getAttribute("p_wf_processId");
   String  read_recordId=(String)request.getAttribute("p_wf_recordId");
*/
	var informationTitle = "<%=fileTitle%>";
	$("#httpUrl").val("GovDocSendProcess!viewfile.action?viewonly=true&p_wf_recordId=<%=read_recordId%>&p_wf_tableId=<%=read_tableId%>");
	$("#title").val("<%=fileTitle%>");
	$("#infoId").val(<%=read_recordId%>);
	$("#channelIdForCollection").val(420);

	openWin({url:'netdisk!infoFolderSelect.action',winName:'collection',width:650,height:350});
	$("#collectionForm").submit();
	//var url = whirRootPath + 'netdisk!infoFolderSelect.action?title=' + informationTitle + '&infoId=' + informationId + '&channelIdForCollection=' + channelId;
	//url += '&httpUrl=Information!view.action%3FinformationId%3D'+informationId+'%26informationType%3D'+informationType+'%26userChannelName%3D'+userChannelName+'%26channelId%3D'+channelId;
	//openWin({url:url,winName:'collection',width:650,height:350});
}


</script>
<script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/send_v.js"   type="text/javascript"></script>
<script src="js/clsPullXMenu.js" language="javascript"></script>
<script  src="js/util/tool.js"  language="javascript" ></script>
<% if(workStatus.equals("-3")){%>
<script src="public/jsp/cmdbutton.jsp?button=Close,Viewacc"></script>
<%}%>
<script  src="js/utfTooljs.js"  language="javascript" ></script>
<script language=javascript>
/*
form表单名称:webform1
iWebOffice名称:WebOffice
WebObject文档对象接口，相当于：
如果是Word  文件，WebObject 是Word  VBA的ActiveDocument对象
如果是Excel 文件，WebObject 是Excel VBA的ActiveSheet对象

如：WebOffice.WebObject
*/


function openPupWin(url,w,h){
    postWindowOpen(url,"_blank","width="+w+",height="+h+",location=no,resizable=no,status=no");
}

function MM_openBrWindow(theURL,winName,features) { 
  postWindowOpen(theURL,winName,features);
}

self.moveTo(0,0);
self.resizeTo(screen.availWidth,screen.availHeight);


<%if(request.getParameter("work")==null||request.getParameter("work").toString().equals("null")||request.getParameter("table")==null||request.getParameter("table").toString().equals("null")){%>
 //关闭
function include_close(){
    if(confirm("确认关闭吗？")){
    	window.opener=null;
        window.open("about:blank","_self");
        window.close();
    }
}
 <%}%>  
</script>


</head>
<body   onload="adjustIframeSize();" class="docBodyStyle" style="overflow:hidden" ><!--scroll=yes   onload="initBody();adjustIframeSize();" onResize="adjustIframeSize();"-->
  <!--<body bgcolor="#ffffff" onLoad="initBody();;adjustIframeSize();"  onResize="loadToolbar('commandBar');adjustIframeSize();"  class="MainFrameBox Pupwin" scroll="no">引导和退出iWebOffice-->
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
  <div class="doc_Scroll" style="height:100%;"> 
<%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%> 


<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0"  class="doc_width" style="height:100%;width:100%">
 

     <tr>
<td height="1" id="fjtable">
   <table width="100%" height="100%" border="0" >
	<%
	EncryptUtil util = new EncryptUtil();

	//String
	dlcode = "";
	if(request.getAttribute("accessoryName") != null && request.getAttribute("accessorySaveName") != null){%>
		<tr>
		<td height="1" colspan="6"><b><font face="微软雅黑" color="#000000"  style="font-size:14px">附件：</font></b><br>
	    <%String accessoryName2 = request.getAttribute("accessoryName").toString();
		String accessorySaveName2 = request.getAttribute("accessorySaveName").toString();
	 if(accessoryName2.indexOf("|") >= 0){
		accessoryName2 = accessoryName2.replace('|',':');
		accessorySaveName2 = accessorySaveName2.replace('|',':');
		String[] acceNameArr = accessoryName2.split(":");
		String[] acceSaveNameArr = accessorySaveName2.split(":");

		for(int i = 0; i < acceNameArr.length; i ++){
			if(smartInUse==0 && sysMap.get("ftpDownloadType") != null && sysMap.get("ftpDownloadType").toString().equals("0")){%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onClick="DOWN2('<%=request.getAttribute("accessorySaveName").toString()%>','<%=request.getAttribute("accessoryName").toString()%>');" href="#"><font size="4"><%=acceNameArr[i]%></font><br>
			<%}else{
				dlcode = util.getSysEncoderKeyVlaue("FileName",acceSaveNameArr[i].toString(),"dir");
			
			%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=fileServer%>/public/download/download.jsp
?FileName=<%= java.net.URLEncoder.encode(acceSaveNameArr[i].toString(),"UTF-8")%>&verifyCode=<%=dlcode%>&name=<%= java.net.URLEncoder.encode(acceNameArr[i].toString(),"UTF-8")%>&path=govdocumentmanager" target="ifrm9"><font size="4"><%=acceNameArr[i]%></font><br>
			<%}%>
	  <%}}else{%>
			<%if(smartInUse==0 && sysMap.get("ftpDownloadType") != null && sysMap.get("ftpDownloadType").toString().equals("0")){%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onClick="DOWN2('<%=request.getAttribute("accessorySaveName").toString()%>','<%=request.getAttribute("accessoryName").toString()%>');" href="#"><font size="4"><%=request.getAttribute("accessoryName").toString()%></font><br>
			<%}else{
			dlcode = util.getSysEncoderKeyVlaue("FileName",request.getAttribute("accessorySaveName").toString(),"dir");
			%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="<%=fileServer%>/public/download/download.jsp?FileName=<%= java.net.URLEncoder.encode(request.getAttribute("accessorySaveName").toString(),"UTF-8")%>&verifyCode=<%=dlcode%>&name=<%= java.net.URLEncoder.encode(request.getAttribute("accessoryName").toString(),"UTF-8")%>&path=govdocumentmanager" target="_blank" style="cursor:hand"><font size="4"><%=request.getAttribute("accessoryName")%></font>
			<%}%>
	  <%}%>
		</td>
		</tr>
		<%}%>
	</table>
</td>
</tr>  
<tr><td id="itd" style="height:99%">

<%	//是否查看pdf
	com.whir.govezoffice.documentmanager.bd.SenddocumentBD senddocumentBD = new com.whir.govezoffice.documentmanager.bd.SenddocumentBD();
	java.util.Map docMap = senddocumentBD.getGovDocumentExt(mRecordID_1);

		//java.util.Map sysMap =  com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
		//String url = "";
        if (sysMap != null && sysMap.get("附件上传") != null &&
            sysMap.get("附件上传").toString().equals("0")) {
			//String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
			if(null != docMap && null !=docMap.get(mRecordID_1)){	
				url = fileServer + "/download.jsp?FileName="+ mRecordID_1 + docMap.get(mRecordID_1).toString()+"%26name="+ mRecordID_1 + docMap.get(mRecordID_1).toString()+ "%26ispdf=1%26path=govdocumentmanager";
			}
		}else{
			if(null != docMap && null !=docMap.get(mRecordID_1)){
				url = rootPath + "/downloadpdf.jsp?FileName="+ mRecordID_1 + docMap.get(mRecordID_1).toString()+"%26name="+ mRecordID_1 + docMap.get(mRecordID_1).toString()+ "%26ispdf=1%26path=govdocumentmanager";
			}
		}

	if(null != docMap && null !=docMap.get(mRecordID_1)){	 		
	%><!-- <iframe id="ddFram" name="dd" src="govezoffice/gov_documentmanager/viewPDF.jsp?url=<%=rootPath + "/upload/govdocumentmanager/" + mRecordID_1 + docMap.get(mRecordID_1).toString()%>" frameborder=0 style="width:800px;height:600px;" border=0 scrolling="no"></iframe>-->
		<iframe id="dd" name="dd" src="modules/govoffice/gov_documentmanager/viewPDF.jsp?url=<%=url%>" frameborder=0 style="width:100%;height:100%;" border=0 scrolling="no"></iframe>
	<%}else{%>
		<!--<iframe name="dd" id="dd"  src="modules/govoffice/gov_documentmanager/jigeObj_iframe.jsp?Template=<%=mTemplate_1%>&FileType=<%=mFileType_1%>&EditType=<%=mEditType_1%>&RecordID=<%=mRecordID_1%>&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=0&showEditButton=0" frameborder=0 style="filter:alpha(opacity=0); display:block; width:100%;height:100%;z-index:0" width="100%" height="100%" border="1" scrolling="no"></iframe>-->
		  <table border=0 cellspacing='0' cellpadding='0' width='100%' height='99%' >
             <tr>
                <td valign="top" style="height:99%">
				
					 <!--<script src="iWebOffice2006.js"></script>
                 调用iWebOffice，注意版本号，可用于升级-->
                  <!-- <OBJECT id="WebOffice" width="100%" height="100%" classid="clsid:23739A7E-5741-4D1C-88D5-D50B18F7C347" codebase="<%//=mClientUrl%>" >
                  </OBJECT>  =7,9,0,0 -->
					<div  id="panel3"  name="panel3" width="100%" height="96%" style="height:96%"  >
				   <%@ include file="/public/iWebOfficeSign/iWebOfficeVersion.jsp"%>
					</div>
					</form>
                </td>
             </tr>
             <tr style="">
                <td height='20'><div id=StatusBar>状态栏</div></td>
             </tr>
           </table>
    	
		
	<%}%>

  </td></tr>

</table>

<%
  String copyType=request.getParameter("copyType")==null?"":request.getParameter("copyType");
com.whir.ezoffice.information.infomanager.bd.NewInformationBD newInformationBD = new com.whir.ezoffice.information.infomanager.bd.NewInformationBD();
		List list = newInformationBD
				.getDataBySQL("select copyEnable,COPYENABLEVIEW from  gov_senddocumentbaseinfo ");
		String copyEnable = "0";
		String copyEnableView = "0";
		if (list != null && list.size() > 0) {
			Object[] obj = (Object[]) list.get(0);
			copyEnable = obj[0] == null ? "0" : obj[0].toString();
			copyEnableView = obj[1] == null ? "0" : obj[1].toString();
		} 
%>
<iframe id="ifrm9" name="ifrm9" src="" style="display:none"></iframe>
<div style="display:none">
 <form name="sendToMyForm" id="sendToMyForm" method="post" action="modules/govoffice/gov_documentmanager/sendocument_bottom_SendToMy_range2.jsp" >
	<input type="hidden" name="sendToMyRange3" value="<%=SendToMyRange%>">
	<input type="hidden" name="p_wf_recordId" value="<%=request.getParameter("p_wf_recordId")==null?"":request.getParameter("p_wf_recordId")%>"/>
	<input type="hidden" id="sendToIdNew" name="sendToIdNew" value="<%=request.getAttribute("sendToId")==null?"":request.getAttribute("sendToId").toString()%>"/>
	<input type="hidden" name="sendToNameNew" id="sendToNameNew" value="<%=request.getAttribute("sendToName")==null?"":request.getAttribute("sendToName").toString()%>"/>
	<input type="hidden" name="viewOnly" id="viewOnly" value="1" />
 </form>
<form name="webform1" method="post" action="" >     
<input type="hidden" name="sendFileTitle" value="<%=fileTitle%>">

<input type="hidden" name="sendFileUserId" value="<%=request.getParameter("sendFileUserId")%>">
<input type="hidden" name="empId" value="<%=request.getParameter("empId")==null?session.getAttribute("userId").toString():request.getParameter("empId")%>">


<input type="hidden" name="documentSendFileTitle" value="<%=fileTitle%>">
<input type="hidden" name="documentSendFileByteNumber" value="<%=byteNum%>">
<input type="hidden" name="documentSendFileWriteOrg" value="<%=sendFileWriteOrg%>">
<input type="hidden" name="zjkySeq"  value="<%=seqNum%>">
<input type="hidden" name="byteNum" value="<%=byteNum%>">
<input type="hidden" name="seqNum"  value="<%=seqNum%>">
<input type="hidden" name="sendFileId" value="<%=request.getParameter("p_wf_recordId")%>">
<input type="hidden" name="editId" value="<%=request.getParameter("p_wf_recordId")%>">
<input type="hidden" name="sendFileLink" value="GovReceiveFileBoxAction.do?<%=request.getAttribute("queryStr")%><%//old=request.getAttribute("javax.servlet.forward.query_string")%>">
<input type="hidden" name="candidateId">
<input type="hidden" name="candidate">
<input type="hidden" name="accessoryName" value="<%=accessoryName%>">
<input type="hidden" name="accessorySaveName" value="<%=accessorySaveName%>">
<input type="hidden" name="accessoryName1" value="<%=fileTitle%>.doc">
<input type="hidden" name="accessorySaveName1" value="<%=mRecordID_1%>.doc">
<!-- 是否可以下载正文，转本部门中看 -->
<input type="hidden" id ="canDownLoad" value = "<%=canDownLoad%>" >
<%//=request.getAttribute("javax.servlet.forward.query_string")%>
<%java.util.List receivefilelist = new com.whir.ezoffice.workflow.newBD.ProcessBD().getUserProcess(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), "3");%>
 <script language="javascript">
 var receiveFileProcArr = new Array(<%=receivefilelist.size()%>);
 </script>
</form>
</div>
<form name="GovSendFileActionForm" action="/GovSendFileAction.do?action=update" method="post" target="ifrm1">
<input type="hidden" name="htmlContent">
<input type="hidden" name="content" value="<%=request.getAttribute("content")%>">
<input type="hidden" name="sendToId2" >
<input type="hidden" name="sendToName2" >
<input type="hidden" name="sendFileNeedSendMsg2" >
<input type="hidden" name="sendFileNeedRTX" value="0">
<input type="hidden" name="sendToMyId" >
<input type="hidden" name="sendToMyName">
<input type="hidden" name="sendFileNeedMail" value="0">
<input type="hidden" name="sendFileCanDownload" value="0">
<input type="hidden" name="tableNameOrId" value="<%=read_tableId%>">
<input type="button" id = "refreshList" style ="display: none" onclick="refreshParentWindow()"/>
 <%
   if(!workStatus.equals("-3")){
 %>
<div style="display:none">
		<table style="display:none">
		<%
		String cancelHref = "postWindowOpen('govezoffice/gov_documentmanager/workflow_cancelReason.jsp?workStatus=1&workId=workIdValue&search=searchValue&workTitle=workTitleValue&tableId=tableIdValue&processName=processName&processId=processIdValue&recordId=recordIdValue&fileType=GSF&fileTitle=fileTitleValue','','TOP=0,LEFT=0,scrollbars=no,resizable=no,width=480,height=250')";
		String formName = "GovSendFileActionForm";//在包含页中指定form的名称
		String saveCheckFn = "initPara()";//保存时校验表单的javascript函数名称
		String mainLinkFile = "GovSendFileLoadAction.do?action=load";//文件办理时打开的页面链接
		String passLinkFile="GovReceiveFileBoxAction.do?action=load&editId="+request.getParameter("record")+"&canEdit=1&isEdit=0&viewType=1&showReceiveFile=1&transmitType=wordTransmit";//文件查阅的页面链接
		String subProcHref = "GovSendFileAction.do?action=see&moduleId=2";//新建子流程链接
		String titleFieldName = "documentSendFileTitle";//作为显示标题的表单中的元素的名称,如果为""则按工作流程的标题
		String title = myform.getDocumentSendFileTitle()==null?"临时标题":myform.getDocumentSendFileTitle();
		String[][] button = null;//包含页面中的附加按钮的名称和触发的javascript函数名称

		String msgFrom = "发文管理";//短信提醒模块名称
		//                          String curCommField = request.getAttribute("curCommField").toString();//批示意见对应字段
		//                          String curPassRoundCommField = request.getAttribute("curPassRoundCommField").toString();//阅办意见对应字段
		String curCommField=""; /////////////////////////////////////////////////////////////
		String curPassRoundCommField ="";///////////////////////////////////////////////////////
		%>

         <tr style="display:none">
		 <td>
	
		 </td>
		 </tr>
		</table>
</div>
<%}%>
</form>
</div>
 
<form id="collectionForm" name="collectionForm" action="/defaultroot/netdisk!infoFolderSelect.action" target="collection" method="post">
	<input type="hidden" name="httpUrl" value="" id="httpUrl" type="hidden"/>
	<input type="hidden" name="infoId" value="" id="infoId" type="hidden"/>
	<input type="hidden" name="channelIdForCollection" value="" id="channelIdForCollection" type="hidden"/>
	<input type="hidden" name="title" value="" id="title" type="hidden"/>
	<input type="hidden" name="fromModule" value="govdocumentmanager" id="fromModule" type="hidden"/>
</form>
 
 

	  <iframe id="ifrm1" name="ifrm1" src="" style="display:none"></iframe>
</body>
<%
 String id1= request.getParameter("editId")==null?"":request.getParameter("editId").toString();
%>
<script language="javascript">
function DOWN2(serverFileName, clietFileName){
	var retdown = '';
	if(document.all.ActiveFormX2 && document.all.ActiveFormX2.length != undefined){
		retdown = document.all.ActiveFormX2[0].downall(clietFileName,serverFileName);
	} else {
		retdown = document.all.ActiveFormX2.downall(clietFileName,serverFileName);
	}
}
function newDocReceiveFile(){
}

function chReceiveFileProc(obj){

}

function sendToMyRange(){
	window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	document.sendToMyForm.target="target";
	document.sendToMyForm.submit();
	//postWindowOpen('govezoffice/gov_documentmanager/sendocument_bottom_SendToMy_range.jsp?sendToMyRange=<%=SendToMyRange%>','','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300');
}

//查看传阅
function viewRead(){
postWindowOpen("govezoffice/gov_documentmanager/senddocument_Read_main.jsp?tableId=<%=read_tableId%>&processId=<%=read_processId%>&recordId=<%=read_recordId%>",'查看传阅','menubar=0,scrollbars=0,locations=0,width=800,height=600,resizable=yes');

}


//通过邮件发送 连接地址

function transmit(){
 var  toId=document.all.candidateId.value;
 var  toName=document.all.candidate.value;
 var  editId=document.all.editId.value;
  if(toName==""){
   alert("请选择接收者");
   return;
  }

 //邮件转发 能看到
  document.webform1.action = encodeURI("GovSendFileAction.do?action=mailtransmit&toId="+toId+"&toName="+toName+"&editId="+editId+"&isEdit=1&transmitType=wordTransmit");
  document.webform1.submit();

}

</script>
<SCRIPT LANGUAGE="JavaScript">
<!--
//已查看用户
function showHasRead() {
	postWindowOpen('GovReceiveFileBoxAction.do?action=userinfo&type=showHasRead&editId=<%=editId%>','','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}
//未查看用户
function showNotRead() {				postWindowOpen('GovReceiveFileBoxAction.do?action=userinfo&type=showNotRead&editId=<%=editId%>','','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');

}
//短信未发送用户
function showNotReceieve(editId) {							postWindowOpen('GovReceiveFileBoxAction.do?action=userinfo&type=showNotReceieve&editId='+editId,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

function supplySend(){
    if(document.all.sendToId2.value==""){
        window.alert("请选择要发送的人！");
        return;
    }
    webform1.action = "GovSendFileAction.do?action=supplySend";
    webform1.submit();
}

//转收文
function sendToReceive(){	
postWindowOpen("govezoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?receiveFileSendFileUnit=<%=request.getParameter("receiveFileSendFileUnit")==null?"":request.getParameter("receiveFileSendFileUnit")%>&fileTitle=<%=fileTitle%>&receiveFileFileNumber=<%=byteNum%>&seqNum=<%=seqNum%>&sendRecordId=<%=sendRecordId%>&accessoryName2=<%=accessoryName%>&accessorySaveName2=<%=accessorySaveName%>&accessoryName1=<%=accessoryName1%>&accessorySaveName1=<%=accessorySaveName1%>&sendFileWriteOrg=<%=sendFileWriteOrg%>&sendFileTopicWord=<%=sendFileTopicWord%>&tableId=<%=read_tableId%>&isMyReceiveDoc=1",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
}


function showAcc(scan){
  openPupWin("public/jsp/pup.jsp?path=govdocumentmanager&fileName=accessoryName&saveName=accessorySaveName&canModify="+scan,550,400);
}



//转本部门
//function cmdDepartSend(){
//   openPupWin("govezoffice/gov_documentmanager/sendocument_bottom_SendToMy.jsp?todeaprat=1&tranType=1",500,250);
//}

//发文分发（发送到我的收文箱）  sendType:1 分发     sendType:0 转本部门    只有 分发 才计算在已查看用户之列
function sendToMy(){
  var  toId=document.all.sendToMyId.value;
  var  toName=document.all.sendToMyName.value;
  var  editId=document.all.editId.value;
  if(toName==""){
   alert("请选择接收者!");
   return;
  }	

    document.all.GovSendFileActionForm.action="GovSendFileAction.do?action=sendToMy&sendType=0&sendToId="+toId+"&toName="+encodeURIComponent(toName)+"&editId="+editId+"&isEdit=1&documentSendFileTitle="+encodeURIComponent(document.all.sendFileTitle.value)+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value;
	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	document.all.GovSendFileActionForm.submit();
    document.all.GovSendFileActionForm.target="";
}

//调整iframe的长度和高度
function adjustIframeSize(){
	var screenwidth;
    var screenheight;
   	screenwidth = screen.availWidth;
   	screenheight = screen.availHeight;
	if(document.getElementById('ddFram')){
		//document.getElementById('ddFram').style.width="100%";//screenwidth;
	}
	if(document.getElementById('dd')){		
	
		//document.getElementById('itd').style.height=document.body.clientHeight - document.getElementById('popToolbar').clientHeight - document.getElementById('fjtable').clientHeight-25;;
		//document.getElementById('dd').style.height="100%";//screenwidth;
		//document.getElementById('dd').style.width="100%";//screenwidth;
		if(!$.browser.msie){
		//document.getElementById('dd').contentWindow.WebOffice.style.height=document.body.clientHeight - document.getElementById('popToolbar').clientHeight -20;
		}
	}

	if(document.getElementById('dd')){		
		//document.getElementById('dd').style.height=document.body.clientHeight - document.getElementById('popToolbar').clientHeight - document.getElementById('fjtable').clientHeight;
	}

}

function downHttp(url){
	openPupWin(url,'ifrm9','menubar=0,scrollbars=0,locations=0,width=10,height=10,resizable=yes');
}

function include_close(){
    if(confirm("确认关闭吗？")){
    	window.opener=null;
        window.open("about:blank","_self");
        window.close();
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
	//dd.width="100%"
	//dd.height="100%"
	//初始话信息
   // ezFlowinit();

	//WebOffice.style.width='100%';
	//WebOffice.style.height='100%';
	 ezFlowinit();
}
<%
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="officeserverservlet";
  String mClientName="iWebOfficeSign/iWebOffice2003.ocx#version=5,7,0,0";
  String schemeURL = request.getScheme();

  String prefixURL = "http://";
  if(null != request.getScheme() && "https".equalsIgnoreCase(request.getScheme())){
	prefixURL = "https://";
  }
  String mServerUrl=prefixURL + request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得

%>
$(document).ready(function(){

<%
		if(null != docMap && null !=docMap.get(mRecordID_1)){	 
	
		}else{
%>
    var isfordbidCopy = '0';
			<%if(!"1".equals(copyEnable) ){%>
				  isfordbidCopy = '1';
			<%}%>
	if(isfordbidCopy == '1'){
		isfordbidCopy="-1,1,0,0,0,0,0,0";
	}else{
		isfordbidCopy="-1,2,0,0,0,0,1,0";
	}
		var navigator = window.navigator;
		var userAgent = navigator.userAgent.toLowerCase();

	
		if(userAgent.indexOf('windows nt') < 0 ){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = 'null';
			WebOffice.WebUrl="<%=mServerUrl%>";
			WebOffice.RecordID=<%=mRecordID_1%>;
			WebOffice.Template="";
			WebOffice.FileName="<%=mRecordID_1%>.doc";
			WebOffice.FileType=".doc";
			WebOffice.EditType=isfordbidCopy;
			WebOffice.UserName="gyb1";
			WebOffice.showMenu = "0";
			WebOffice.EnablePrint =isfordbidCopy;
			WebOffice.WebOpen();
			WebOffice.ShowType="1";
			if(isfordbidCopy == "-1,2,0,0,0,0,1,0"){
			   WebOffice.AppendTools("106","打印",5);
			}
			WebOffice.WebToolsVisible('Standard',false);  //标准
			WebOffice.WebToolsVisible('Formatting',false);  //格式
			WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			WebOffice.WebToolsVisible('Database',false);  // 数据库
			WebOffice.WebToolsVisible('Drawing',false);  //绘图
			WebOffice.WebToolsVisible('Forms',false);  //窗体
			WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			WebOffice.WebToolsVisible('Web',false);  //Web
			WebOffice.WebToolsVisible('Picture',false);  //图片
			WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			WebOffice.WebToolsVisible('Frames',false);//  框架集
			WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			WebOffice.WebToolsVisible('Outlining',false); // 大纲
			WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			WebOffice.VisibleTools("保存文件",false);
			WebOffice.VisibleTools("文字批注",false);
			WebOffice.VisibleTools("手写批注",false);
			WebOffice.VisibleTools("文档清稿",false);
			WebOffice.VisibleTools("重新批注",false);
			
			//ShowRevision(false);
			$("#panel3").show();
		}
	
<%
	}	
%>
	
});


function cmdClose(){
	if(confirm("确认关闭窗口吗？")){
		window.close();
	}
}
try{
	if( window.opener && window.opener.document.getElementById('queryForm') ){	
		window.opener.refreshListForm_('queryForm');
	} ;
	if( window.opener.parent.frames['mainFrame'] && window.opener.parent.frames['mainFrame'].document.getElementById('queryForm') ){	
		window.opener.parent.frames['mainFrame'].refreshListForm_('queryForm');
	}
}catch(e){
}



 
//作用：打印文档
function WebOpenPrint(){
  try{

    WebOffice.WebOpenPrint();
    StatusMsg(WebOffice.Status);
  }catch(e){}
}

function refreshParentWindow(){
	try{
		if( window.opener && window.opener.document.getElementById('queryForm') ){	
			window.opener.refreshListForm_('queryForm');
		} 
		if( window.opener.parent.frames['mainFrame'] && window.opener.parent.frames['mainFrame'].document.getElementById('queryForm') ){	
			window.opener.parent.frames['mainFrame'].refreshListForm_('queryForm');
		}
}catch(e){
		
	}
}
//-->
</SCRIPT>


<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)"> 

   if (vIndex==1){  //打印文档
WebOpenPrint();
   }
 if (vIndex==106){WebOpenPrint();}
 if (vIndex==108){WebExportText();}
</script>
 
<script language=javascript for=WebOffice event=OnToolsClick(vIndex,vCaption)> 

	if (vIndex==1){  //打印文档
	WebOpenPrint();
	}
	if (vIndex==106){WebOpenPrint();}
	if (vIndex==108){WebExportText();}
 
	if(vIndex==-1&&vCaption=='全屏'){
	document.all.panel3.style.display="";
	}
	if (vIndex==-1 && vCaption=='返回'){
	WebOffice.WebObject.Saved = true;
	document.all.panel3.style.display="none";
	}
</script>

</html>