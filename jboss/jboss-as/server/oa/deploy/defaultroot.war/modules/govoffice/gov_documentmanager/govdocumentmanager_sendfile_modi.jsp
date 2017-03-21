<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/common/include_common_header.jsp"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SendFileBD" %>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SenddocumentBD"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovIssueUnitPO"%>
<%@page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD"%>

<%
String weburl="iWebRevisionServlet";
      // 获取流程图参数
   String  _table=request.getParameter("table")==null?"":request.getParameter("table");
   String  _processId=request.getParameter("processId")==null?"":request.getParameter("processId");
   String  _work=request.getParameter("work")==null?"":request.getParameter("work");
   String  _submitPerson = request.getParameter("submitPerson")==null?"":request.getParameter("submitPerson");
   String  _record=request.getParameter("record")==null?"":request.getParameter("record");
   String  _submitTime=request.getParameter("submitTime")==null?"":request.getParameter("submitTime");
   String  _moduleId=request.getParameter("moduleId")==null?"":request.getParameter("moduleId");
   String  _activity=request.getParameter("activity")==null?"":request.getParameter("activity");
   String  _workType=request.getParameter("workType")==null?"":request.getParameter("workType");
   //ifrmae  地址
   String  _workFlowGraphURL=rootPath + "/work_flow/workflow_iframe_graph.jsp?table="+_table+"&processId="+_processId+
           "&work="+_work+"&submitPerson="+_submitPerson+"&record="+_record+"&submitTime="+_submitTime+
           "&moduleId="+_moduleId+"&activity="+_activity+"&workType="+_workType;
%>

<%
if(request.getAttribute("supplySend") != null){%>
    <script language="javascript">
    window.close();
    </script>
    <%
 return;
}
//邮件转发 返回  （转本 部门）
String transmitSu="";
if(request.getAttribute("transmitSu")!=null){
  transmitSu=request.getAttribute("transmitSu").toString();
  if(transmitSu.equals("1")){%>   
   <script>
  alert("发送成功");
   window.close();
   </script> 

 <%}else{%>  
  <script>
	alert("发送失败");
   window.close();
  </script>
  
  <%}
}
SendFileBD  sendB=new SendFileBD();

 String domainId = session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();
 String userId=session.getAttribute("userId").toString();
String fileServer =com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());

java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
if(sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")){%>
<object classid="clsid:A7EE3B4B-DB6C-4957-A904-DD7EA2BB3DCB"
	id="ActiveFormX2" width="1" height="1" codebase="public/jsp/pdown.cab#version=1.0.19.0">
	<param name="Color" value="15592680">
	<param name="ftpuser" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("user")%>">
	<param name="ftppwd" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("password")%>whir?!">
	<param name="ftpport" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("port")%>">
	<param name="dddd" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("ddd")%>">
	<param name="ftphost" value="<%=com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(),session.getAttribute("domainId").toString()).get("server")%>">
	<param name="curpath" value="govdocumentmanager">
</object>
<%}
boolean handSignInUse = false;//是否使用了手写签名
if(sysMap != null && sysMap.get("使用手写意见") != null && "1".equals(sysMap.get("使用手写意见").toString())){
    handSignInUse = true;
}

String curCommField = request.getAttribute("curCommField").toString();//批示意见对应字段
String curPassRoundCommField = request.getAttribute("curPassRoundCommField").toString();//阅办意见对应字段

/**************************取常用语*********************************/
java.util.List officelist = new WorkFlowBD().getOffiDict(userId, domainId);
/**分发单位列表*******start**/
SenddocumentBD senddocumentBD = new SenddocumentBD();
java.util.List issueUnitList = senddocumentBD.getGovIssueUnitList("");
/**分发单位列表*******end**/

String  read_tableId=request.getParameter("table");
String  read_processId=request.getParameter("processId");
String  read_recordId=request.getParameter("record");

int read_inWorkType = ("null".equals(request.getParameter("workType")) || request.getParameter("workType")==null)?-1:Integer.parseInt(request.getParameter("workType"));//流程类型
String  read_option=request.getParameter("option")==null?"":request.getParameter("option").toString();
String  read_submitPerson=request.getParameter("submitPerson")==null?"":request.getParameter("submitPerson").toString();
String  read_submitTime=request.getParameter("submitTime")==null?"":request.getParameter("submitTime").toString();
String  read_moduleId=request.getParameter("moduleId")==null?"":request.getParameter("moduleId").toString();
String  read_activity=request.getParameter("activity")==null?"":request.getParameter("activity").toString();


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
String accessoryName2=request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
String accessorySaveName2=request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();
//取附件信息
String contentAccName=request.getAttribute("contentAccName")==null?"":request.getAttribute("contentAccName").toString();
String contentAccSaveName=request.getAttribute("contentAccSaveName")==null?"":request.getAttribute("contentAccSaveName").toString();

//从 保存退出 中选的！
//-------------------------------------start----------------------------------------------------------------/

String displayName[]={"承办单位意见","会签","核稿","审阅意见","审核意见","签发" };
String modifyContent[]={"","","","","",""};
String commentName[] ={"documentSendFileAssumeUnit","sendFileMassDraft","sendFileProveDraft","sendFileReadComment","documentSendFileCheckCommit","documentSendFileSendFile"};

Map commentMap=new com.whir.govezoffice.documentmanager.common.util.WorkFlowDeal().getCommentByCommFiled_All(request,commentName);

/*
documentSendFileAssumeUnit    承办单位意见
sendFileMassDraft              会签
sendFileProveDraft             核稿
sendFileReadComment             审阅意见
documentSendFileCheckCommit     审核意见
documentSendFileSendFile        签发
*/
String isEdit = request.getParameter("isEdit")==null?"0":request.getParameter("isEdit");//办理查阅中修改
com.whir.govezoffice.documentmanager.action.GovSendFileActionForm myform = (com.whir.govezoffice.documentmanager.action.GovSendFileActionForm)request.getAttribute("myform") ;
java.util.Date sendFileDate = new java.util.Date() ;
java.util.Date sendFileSendDate = new java.util.Date();
java.util.Date documentCreateTime=new java.util.Date();
java.util.Date signsendTime=new java.util.Date();

if(request.getAttribute("sendFileDate")!=null)
    sendFileDate =  (java.util.Date)request.getAttribute("sendFileDate") ;
if(request.getAttribute("sendFileSendDate")!=null)
    sendFileSendDate =  (java.util.Date)request.getAttribute("sendFileSendDate") ;

if(request.getAttribute("documentCreateTime")!=null&&!request.getAttribute("documentCreateTime").toString().equals("")){
  documentCreateTime=(java.util.Date)request.getAttribute("documentCreateTime");
}
if(request.getAttribute("signsendTime")!=null&&!request.getAttribute("signsendTime").toString().equals("")){
  signsendTime=(java.util.Date) request.getAttribute("signsendTime");
}
int createTimeYear= documentCreateTime.getYear()+1900;
int createTimeMonth= documentCreateTime.getMonth()+1;
int createTimeDate= documentCreateTime.getDate();
String createTimeStr=""+createTimeYear+"/"+createTimeMonth+"/"+createTimeDate;

int sendFileDateYear = sendFileDate.getYear()+1900 ;
int sendFileDateMonth = sendFileDate.getMonth()+1 ;
int sendFileDateDate = sendFileDate.getDate();

int sendFileSendDateYear = sendFileSendDate.getYear()+1900 ;
int sendFileSendDateMonth = sendFileSendDate.getMonth()+1 ;
int sendFileSendDateDate = sendFileSendDate.getDate();
String sendFileDateShow=String.valueOf(sendFileSendDateYear)+" 年 "+String.valueOf(sendFileSendDateMonth)+" 月 " +String.valueOf(sendFileSendDateDate)+" 日";
int signsendTimeYear=signsendTime.getYear()+1900;
int signsendTimeMonth=signsendTime.getMonth()+1;
int signsendTimeDate=signsendTime.getDate();
String signsendTimeStr=signsendTimeYear+"/"+signsendTimeMonth+"/"+signsendTimeDate;
String sendStatus=request.getAttribute("sendStatus")==null?"0":request.getAttribute("sendStatus").toString();


/// 控制按纽出现 
String workStatus = request.getParameter("workStatus")==null?"":request.getParameter("workStatus").toString();
String modiButton = "none";
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

if(workStatus.equals("102")){
  modiButton=",Viewtext,ReadHistorytext,Print";	 
}


if(workStatus.equals("100")){
	boolean canPrint = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getProcessCanPrint(read_processId);
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
//取 基础信息
String [] secretLevel=null;
String [] keepSecretLevel=null;
String [] transactLevel=null;
String [] contentLevel=null;
String [] openPropertyArr=null;
String [] fileTypeArr=null;

Object [] baseObj=(Object[]) new SenddocumentBD().getSenddocumentBaseInfo();
if(baseObj!=null&&baseObj.length>0){
  if(baseObj[4]!=null&&!baseObj[4].toString().equals("")){
	secretLevel=baseObj[4].toString().split(";");//秘密级别：
	keepSecretLevel=baseObj[3].toString().split(";");//保密期限：
	transactLevel=baseObj[5].toString().split(";"); // 办理紧急：
    contentLevel=baseObj[1].toString().split(";");//内容紧急：
	if(baseObj.length>10&&baseObj[11]!=null&&!baseObj[11].toString().equals("")){
	  openPropertyArr=baseObj[11].toString().split(";");
	}
	
	fileTypeArr=baseObj[2].toString().split(";");// 文件种类
  }
}
//取 文件类别（2010.03.19新增字段）
String[] sendFileFileType_Arr=null;
java.util.List sendFileTypeList = new java.util.ArrayList();
if(read_processId != null && !"".equals(read_processId)){
	sendFileTypeList = new SenddocumentBD().getFileTypesByProcessId(read_processId);
	String sendFileTypeStr = "";
	if(sendFileTypeList != null && sendFileTypeList.size() > 0){
		for(int i=0;i<sendFileTypeList.size();i++){
			sendFileTypeStr+=((Object[])sendFileTypeList.get(i))[1]+",";
		}
	}
	if(!sendFileTypeStr.equals("")){
		sendFileFileType_Arr=sendFileTypeStr.split(",");
	}
}
// 机关代字 名称
String sendWord=request.getAttribute("sendFileDeparatWord")==null?"":request.getAttribute("sendFileDeparatWord").toString();
com.whir.ezoffice.workflow.common.util.WorkflowCommon workflowCommon = new com.whir.ezoffice.workflow.common.util.WorkflowCommon();
com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
String curModifyField = request.getAttribute("curModifyField")==null?"":request.getAttribute("curModifyField").toString();//当前活动可写字段
//判断正文的写权限
boolean isEditSendFileText=false;
if(curModifyField.indexOf("$sendFileText$") >= 0) {
   isEditSendFileText = true;
}
String curProcCommField = request.getAttribute("curProcCommField")==null?"":request.getAttribute("curProcCommField").toString();//当前流程所有的批示意见对应字段名称
String processName = request.getParameter("processName");
processName = java.net.URLDecoder.decode(processName, "UTF-8");
String  contentText=request.getAttribute("content")==null?"":request.getAttribute("content").toString();

String nowYearInt= (new java.util.Date().getYear()+1900)+"";

java.util.List wordList= new java.util.ArrayList();
if(request.getAttribute("unitWord")!=null){
wordList=(java.util.List) request.getAttribute("unitWord");
}		
String commentStartStr="FW";
String moduleId2="2";
java.util.Date   nDate=new java.util.Date();
int nyear= nDate.getYear()+1900;
int nMonth= nDate.getMonth()+1;
int nDay= nDate.getDate();
String  dName=session.getAttribute("userName")+"　　　"+nDate;
String commentNotNull = request.getAttribute("commentNotNull")==null?"0":request.getAttribute("commentNotNull").toString();//批示意见是否可以为空
%>
<html:html>
<head>
<title>发文</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=rootPath%>/skin/<%=session.getAttribute("skin")%>/style.css" rel="stylesheet" type="text/css" />
<script src="<%=rootPath%>/js/js.js" language="javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/public/date_picker/DateObject2.css">
<SCRIPT language="javascript" src="<%=rootPath%>/public/date_picker/DateObject.js"></SCRIPT>
<SCRIPT language="javascript" src="<%=rootPath%>/public/date_picker/DatePicker.js"></SCRIPT>
<SCRIPT language="javascript" src="<%=rootPath%>/public/date_picker/editlib.js"></SCRIPT>
<SCRIPT language="javascript" src="<%=rootPath%>/public/date_picker/tree.js"></SCRIPT>
<script language="javascript" src="<%=rootPath%>/js/openEndow.js"></script>
<script language="javascript" src="<%=rootPath%>/js/checkForm.js"></script>
<script language="javascript" src="<%=rootPath%>/custom_form/datetime/datetime_check.js"></script>
<script language="javascript" src="<%=rootPath%>/custom_form/datetime/datetime_select.js"></script>
<script src="<%=rootPath%>/govezoffice/js/trim.js" language="javascript"></script>
<script  src="<%=rootPath%>/js/util/tool.js"  language="javascript" ></script>
<%if("1".equals(request.getParameter("resubmit"))){%>
<script src="<%=rootPath%>/js/toolbar/standardAdd.js" language="javascript"></script>
<script src="<%=rootPath%>/js/toolbar/govsendfileAdd.js" language="javascript"></script>
<script src="<%=rootPath%>/js/clsPullXMenu.js" language="javascript"></script>
<script src="<%=rootPath%>/public/jsp/cmdbutton.jsp?button=Close,Send,WritetextModi">
</script>
<%}else{%>
<script src="<%=rootPath%>/js/toolbar/standardModi.js" language="javascript"></script>
<script src="<%=rootPath%>/js/toolbar/govsendfileModi.js" language="javascript"></script>
<script src="<%=rootPath%>/js/clsPullXMenu.js" language="javascript"></script>
<%}%>
<script src="<%=rootPath%>/clsPupMenu.js" type="text/javascript"></script>
<script  src="<%=rootPath%>/js/checkText.js"  language="javascript" ></script>
<SCRIPT language="javascript" src="<%=rootPath%>/js/openEndow.js"></SCRIPT>
<script src="<%=rootPath%>/govezoffice/js/govJsTool.js" language="javascript"></script>
<SCRIPT language="javascript" src="<%=rootPath%>/js/utfTooljs.js"></SCRIPT>
<script src="<%=rootPath%>/js/jquery/jquery-1.4.3.js" language="javascript"></script>
<script>
function openPupWin(url,w,h){
    postWindowOpen(url,"_blank","width="+w+",height="+h+",location=no,resizable=yes,status=no");
}

function MM_openBrWindow(theURL,winName,features) { 
  postWindowOpen(theURL,winName,features);
}
</script>
<script>
function openPupWinScroll(url,w,h){
    postWindowOpen(url,"_blank","width="+w+",height="+h+",location=no,scrollbars=yes,resizable=yes,status=no");
}
//公文交换
function  cmdGovExchange(){
  openPupWinScroll("<%=rootPath%>/ExchangeAction.do?action=load&editId=" + document.all.editId.value+"&tableId=<%=read_tableId%>",'width=600,height=500');
}

//加入督办任务
function cmdGovUnionTask(){
	openPupWin('<%=rootPath%>/UnionTaskAction.do?actType=addTask&fromMod=sendfile&unionTaskTitle=' + GovSendFileActionForm.documentSendFileTitle.value,'width=600,height=500');
}

</script>
<style type="text/css">
<!--
.bg {
	background-image: url(../images/gw_line.jpg);
	background-repeat: repeat-y;
}
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
table,td{ background-color: #FFFFFF;}
#noteDiv_documentSendFileAssumeUnit {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}

#noteDiv_sendFileMassDraft {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}
#noteDiv_sendFileProveDraft {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}
#noteDiv_sendFileReadComment {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}
#noteDiv_documentSendFileCheckCommit {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}
#noteDiv_documentSendFileSendFile {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
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
}
.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:"宋体"}
-->
</style>
</head>

<body  onUnload="try{document.all.SignatureControl.DeleteSignature();}catch(e){}"
  onload="init();loadToolbar('commandBar');" onResize="loadToolbar('commandBar');" class="MainFrameBox Pupwin" scroll=no>

<%
String resubmit_local = request.getParameter("resubmit") == null?"":request.getParameter("resubmit").trim();
_activity =(request.getParameter("initActivity")==null ? _activity : request.getParameter("initActivity"));
%>
<jsp:include page="/govezoffice/gov_documentmanager/govdocumentmanager_jspInclude_initComment.jsp" >
   <jsp:param name="activity"  value="<%=_activity%>"/>
   <jsp:param name="table"  value="<%=_table%>"/>
   <jsp:param name="workType"  value="<%=_workType%>"/>
   <jsp:param name="record"  value="<%=_record%>"/>
   <jsp:param name="moduleId2"  value="<%=moduleId2%>"/>
   <jsp:param name="curCommField"  value="<%=curCommField%>"/>
   <jsp:param name="workStatus"  value="<%=workStatus%>"/>
   <jsp:param name="curPassRoundCommField"  value="<%=curPassRoundCommField%>"/>
   <jsp:param name="commentNotNull"  value="<%=commentNotNull%>"/>
   <jsp:param name="curProcCommField"  value="<%=curProcCommField%>"/>
   <jsp:param name="resubmit"  value="<%=resubmit_local%>"/>
   <jsp:param name="weburl"  value="<%=weburl%>"/>
   <jsp:param name="commentStartStr"  value="<%=commentStartStr%>"/>
   
</jsp:include>

<!--存放原放在外面的内容-->
<script language="javascript">
/*初始化页面*/
<%
/*归档*/
String close="";
if(request.getAttribute("close")!=null)
close=request.getAttribute("close").toString();
String wantPigeonhole="";/*是否要归档*/
if(request.getParameter("wantPigeonhole")!=null)
wantPigeonhole=request.getParameter("wantPigeonhole").toString();
%>



function init() {

		/*归档*/
<%if(!"".equals(wantPigeonhole)&&"true".equals(wantPigeonhole)){%>
    var htmlBody=document.body.innerHTML;
	  document.all.field10.value=htmlBody;/*field10做为BODY的内容传递使用*/
	  GovSendFileActionForm.action = "<%=rootPath%>/GovSendFileLoadAction.do?action=pigeonhole" ;
      GovSendFileActionForm.submit() ;
<%}
if(!"".equals(close)&&"yes".equals(close)){%>
	parent.window.alert("操作成功！");
   parent.window.close();
<%}%>
   var done = "<%=request.getParameter("done")%>" ;
   if(done=="done") {
        <%if(!"yes".equals(close)){%>
        window.close();
		<%}%>
    }
   selSendType("<%=myform.getSendToType()%>") ;

var windowWidth = window.screen.availWidth;
var windowHeight = window.screen.availHeight;
window.moveTo(0,0);
window.resizeTo(windowWidth,windowHeight);


innerHtmlForTD();
initComment();

showRelationIfr();
showRealtionaccessoryIframe();
showSendAssociate();
}
//导航按钮
function btnSelect(id){
  for(i=0;i<=8;i++){
 	 if(document.getElementById("Panle"+i)){
	 	document.getElementById("Panle"+i).style.color = "black";
	 }
 	 if(document.getElementById("docinfo"+i)){
	 	document.getElementById("docinfo"+i).style.display = "none";
	 }
  }

   if(document.getElementById("Panle"+id)){
	 	document.getElementById("Panle"+id).style.color = "red";
	 }
 	 if(document.getElementById("docinfo"+id)){
	 	document.getElementById("docinfo"+id).style.display = "";
	 }


  if(id==1){
	  showWorkFlowGraph();
  }else if(id==8){
	  showSendAssociate();
  }else if(id==6){
	showRelationIfr();
  }else if(id==7){
	showRealtionaccessoryIframe();
  }


}
  //显示流程图
   function  showWorkFlowGraph(){
   	document.getElementById("workFlowGraphIframe").width=(screen.availWidth); 
       document.getElementById("workFlowGraphIframe").src=encodeURI("<%=_workFlowGraphURL%>");
              
   }
   //显示相关收文
   function showSendAssociate(){
		document.getElementById("showAssociateIframe").src=encodeURI("<%=rootPath%>/GovSendFileAction.do?action=sendAssociate&sendFileId=<%=_record%>&filetitle=" + GovSendFileActionForm.documentSendFileTitle.value);
   }
   
   //显示相关流程
   function showRelationIfr(){
	document.getElementById("relationIfr").src="<%=rootPath%>/work_flow/workflow_include_relationprocess.jsp?processId=<%=read_processId%>&table=<%=read_tableId%>&record=<%=read_recordId%>&workStatus=<%=workStatus%>";
   }
   //显示相关附件
   function showRealtionaccessoryIframe(){
	document.getElementById("realtionaccessoryIframe").src="<%=rootPath%>/work_flow/workflow_include_relationAccessory.jsp?processId=<%=request.getParameter("processId")%>&table=<%=request.getParameter("table")%>&record=<%=request.getParameter("record")%>&workStatus=<%=request.getParameter("workStatus")%>";
   }

/*发送类型 主送及抄送  送、发、抄  分送*/
function selSendType(val) {
    for(var i = 0 ; i < 3 ; i ++) {
        var sendTR = eval("document.all.send"+i+"TR")  ;
        if(sendTR) {
        if(parseInt(val) == i ) sendTR.style.display="" ;
        else sendTR.style.display="none" ;
        }
    }
}

function changeNumber(){
   
	var  wordValue=document.all.sendFileDepartWord.value; 

     if(wordValue!=""){		 
             mystr=wordValue.split(";");      
       		 var  sendWordId=mystr[0];
			
	   if(sendWordId==""){
		   alert("机关代字为空！");
        return ;

          }else{
	openPupWin("<%=rootPath%>/GovSendFileAction.do?action=initZjkySendWord&sendWordId="+sendWordId+"&changeNumType=add",400,200);
   		
		   }
                
	 }else{
		 alert("机关代字为空！");
	 
	  return;
	 
	 }       

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
    document.all.ifrm.src = "<%=rootPath%>/GovSendFileAction.do?action=initNumber&fileNumberId="+GovSendFileActionForm.documentSendFileHead.value+"&sendFileYear="+ GovSendFileActionForm.field2.value;
}

function selRedHead(redhead) {
     if(redhead ==-1)     return ;
     document.all.ifrm.src = "<%=rootPath%>/GovSendFileAction.do?action=selRedHead&redHeadId="+redhead ;
}


function delRelationWork(relationId){
	document.all.tempIframe.src="<%=rootPath%>/WorkflowButtonAction.do?flag=delRelationWork&relationId="+relationId;
	alert("删除成功！");
	document.getElementById('RETR'+relationId).style.display="none";
}


function reloadRelationIframe(){
	document.all.relationIfr.src="<%=rootPath%>/work_flow/workflow_include_relationprocess.jsp?processId="+document.all.read_processId.value+"&table="+document.all.tableNameOrId.value+"&record="+document.all.editId.value+"&workStatus=<%=workStatus%>";
}

/*检查页面参数有效性*/
function initPara() {
	if(!evaluateComent()){
		return false;
    }
    if(GovSendFileActionForm.documentSendFileAssumeUnit) {
        if(checkTextLengthOnly(GovSendFileActionForm.documentSendFileAssumeUnit,2000,"承办单位意见")==false) return false ;
		if(GovSendFileActionForm.documentSendFileAssumeUnit.value.indexOf("'")>=0){
			alert('承办单位意见不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.documentSendFileAssumeUnit.value.indexOf("\"")>=0){
			alert('承办单位意见不能输入双引号');
			return false;
		}
    }
    if(GovSendFileActionForm.documentSendFileCheckCommit) {
        if(checkTextLengthOnly(GovSendFileActionForm.documentSendFileCheckCommit,2000,"审核意见")==false) return false ;
		if(GovSendFileActionForm.documentSendFileCheckCommit.value.indexOf("'")>=0){
			alert('审核意见不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.documentSendFileCheckCommit.value.indexOf("\"")>=0){
			alert('审核意见不能输入双引号');
			return false;
		}
    }
    if(GovSendFileActionForm.documentSendFileSendFile) {
		
        if(checkTextLengthOnly(GovSendFileActionForm.documentSendFileSendFile,2000,"签发")==false) return false ;
		if(GovSendFileActionForm.documentSendFileSendFile.value.indexOf("'")>=0){
			alert('签发不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.documentSendFileSendFile.value.indexOf("\"")>=0){
			alert('签发不能输入双引号');
			return false;
		}
    }
    if(GovSendFileActionForm.sendFileReadComment) {
        if(checkTextLengthOnly(GovSendFileActionForm.sendFileReadComment,2000,"审阅意见")==false) return false ;
		if(GovSendFileActionForm.sendFileReadComment.value.indexOf("'")>=0){
			alert('审阅意见不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.sendFileReadComment.value.indexOf("\"")>=0){
			alert('审阅意见不能输入双引号');
			return false;
		}
    }
  
    if(GovSendFileActionForm.sendFileAccessoryDesc) {
        if(checkTextLengthOnly(GovSendFileActionForm.sendFileAccessoryDesc,500,"附件描述")==false) return false ;
		if(GovSendFileActionForm.sendFileAccessoryDesc.value.indexOf("'")>=0){
			alert('附件描述不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.sendFileAccessoryDesc.value.indexOf("\"")>=0){
			alert('附件描述不能输入双引号');
			return false;
		}
    }
    if(GovSendFileActionForm.sendFileMassDraft) {
        if(checkTextLengthOnly(GovSendFileActionForm.sendFileMassDraft,100,"会签")==false) return false ;
		
		if(GovSendFileActionForm.sendFileMassDraft.value.indexOf("'")>=0){
			alert('会签不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.sendFileMassDraft.value.indexOf("\"")>=0){
			alert('会签不能输入双引号');
			return false;
		}
    }
 
    if(GovSendFileActionForm.sendFileProveDraft ) {
        if(checkTextLengthOnly(GovSendFileActionForm.sendFileProveDraft ,2000,"核稿")==false) return false ;
		if(GovSendFileActionForm.sendFileProveDraft.value.indexOf("'")>=0){
			alert('核稿不能输入单引号');
			return false;
		}else if(GovSendFileActionForm.sendFileProveDraft.value.indexOf("\"")>=0){
			alert('核稿不能输入双引号');
			return false;
		}
    }
    
  
  if(!isPhone(document.all.field10)){
   
   return false;
  }
	
	if(GovSendFileActionForm.field1) {
        if(checkTextLengthOnly(GovSendFileActionForm.field1,39,"文号")==false) return false ;
    }
	if(GovSendFileActionForm.field2) {
        if(checkNumber(GovSendFileActionForm.field2,"发文编号",99999)==false) return false ;
    }
	if(GovSendFileActionForm.documentSendFileTitle) {
        if(checkText(GovSendFileActionForm.documentSendFileTitle,95,"发文标题")==false) return false ;
    }
    if( GovSendFileActionForm.documentSendFileTopicWord){
        if(checkTextLengthOnly(GovSendFileActionForm.documentSendFileTopicWord,95,"主题词")==false) return false ;
    }
if(GovSendFileActionForm.documentSendFilePrintNumber) {
        if(checkNumber(GovSendFileActionForm.documentSendFilePrintNumber,"份数",9999)==false) return false ;
    }
	if(GovSendFileActionForm.toPerson1) {
        if(checkTextLengthOnly(GovSendFileActionForm.toPerson1,200,"主送")==false) return false ;
    }
	if(GovSendFileActionForm.toPersonBao) {
        if(checkTextLengthOnly(GovSendFileActionForm.toPersonBao,200,"抄报")==false) return false ;
    }

	if(GovSendFileActionForm.toPerson2) {
        if(checkTextLengthOnly(GovSendFileActionForm.toPerson2,200,"抄送")==false) return false ;
    }
	//if(GovSendFileActionForm.toPersonInner) {
       // if(checkTextLengthOnly(GovSendFileActionForm.toPersonInner,200,"内部发送")==false) return false ;
    //}
	checkOffice();

	if(document.all.documentSendFileTitle && document.all.documentSendFileTitle.value.indexOf("#")>0){
	alert("标题不能含'#'");
	return false;
	}
    var numId=document.all.sendFilePoNumId.value;
	var numxuhao=document.all.field2.value;

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
        var url = "<%=rootPath%>/govezoffice/gov_documentmanager/govdocumentmanager_judge.jsp?numId=" + numId+"&record="+document.all.editId.value+"&field2="+numxuhao+"&tmp="+new Date().getTime();
		if(document.all.field3 && document.all.field3.value !=''){
			url +='&field3=' + document.all.field3.value;
		}
		
        //http_request.onreadystatechange = processRequest;
        /* 确定发送请求的方式和URL以及是否同步执行下段代码*/
        http_request.open("GET", url, false);/*此处需同步执行*/
        http_request.send(null);
    }
    if (http_request.readyState == 4) { /* 判断对象状态*/
        if (http_request.status == 200) { /*信息已经成功返回，开始处理信息*/
            var result = http_request.responseText;
            if(result == 0){
                alert("文号重复！");
                return false;
            }
        } else { /*页面不正常*/
            alert("您所请求的页面有异常。");
        }
    }
	}
    

	setNewUpdate();//判断哪些标签修改了
	trimrnTitle();//去掉 标题与 附件描述的 换行

	
	return true;
	
	
}

//去掉标题 ，附件说明换行
function trimrnTitle(){
	var title=document.all.documentSendFileTitle.value;
	title=title.Trimrn();
	document.all.documentSendFileTitle.value=title;

	var sendFileAccessoryDesc=document.all.sendFileAccessoryDesc.value;
	sendFileAccessoryDesc=sendFileAccessoryDesc.Trimrn();
	document.all.sendFileAccessoryDesc.value=sendFileAccessoryDesc;
}


//是否是号码
function isPhone(obj) {
	if(obj){
    var str = "0123456789- ()" ;
    var val = obj.value ;
    for(var i = 0  ;val &&  i < val.length ; i++ ) {
        if(str.indexOf(val.substring(i,i+1))==-1) {
            alert("号码允许字符：0123456789-( )") ;
            obj.focus() ;
            obj.select();
            return false ;
        }
    }
	}
    return true ;
}

function setNewUpdate(){
  if(document.all.oldTitle.value!=document.all.documentSendFileTitle.value){
   document.all.oldTitle.value="1";     
  }
  if(document.all.oldToPerson1.value!=document.all.toPerson1.value){ 
	 document.all.oldToPerson1.value="2";
  }
  if(document.all.oldToPerson2.value!=document.all.toPerson2.value){
	  document.all.oldToPerson2.value="3";
  }
   if(document.all.oldToInnner.value!=document.all.toPersonInner.value){
	  document.all.oldToInnner.value="4";
  }
     
     
}

//转收文
function sendToReceive(){
//openPupWin("<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?fileTitle="+document.all.documentSendFileTitle.value+"&byteNum="+document.all.documentSendFileByteNumber.value+"&seqNum="+(document.all.zjkySeq?document.all.zjkySeq.value:"")+"&sendRecordId="+document.all.editId.value+"&accessoryName1=<%=contentAccName%>&accessorySaveName1=<%=contentAccSaveName%>&accessoryName2=<%=accessoryName2%>&accessorySaveName2=<%=accessorySaveName2%>&tableId="+document.all.tableNameOrId.value+"&field4=" + (document.all.sendFileGrade?document.all.sendFileGrade.value:"")+"&receiveFileFileNumber="  + (document.all.documentSendFileByteNumber?document.all.documentSendFileByteNumber.value:""),'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
openPupWin("<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_bottom_toSend.jsp?receiveFileSendFileUnit=<%=request.getAttribute("documentSendFileWriteOrg")==null?"":request.getAttribute("documentSendFileWriteOrg")%>&fileTitle=<%=request.getAttribute("documentSendFileTitle")==null?"":request.getAttribute("documentSendFileTitle")%>&byteNum="+document.all.documentSendFileByteNumber.value+"&seqNum="+(document.all.zjkySeq?document.all.zjkySeq.value:"")+"&sendRecordId="+document.all.editId.value+"&accessoryName1=<%=contentAccName%>&accessorySaveName1=<%=contentAccSaveName%>&accessoryName2=<%=accessoryName2%>&accessorySaveName2=<%=accessorySaveName2%>&tableId="+document.all.tableNameOrId.value+"&field4=" + (document.all.sendFileGrade?document.all.sendFileGrade.value:"")+"&receiveFileFileNumber="  + (document.all.documentSendFileByteNumber?document.all.documentSendFileByteNumber.value:""),'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
}


//收文 转文件送审签
function  toSendfilecheck(){
	//postWindowOpen("<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?id="+document.all.editId.value+"&sendType=sendFile&fileTitle="+document.all.documentSendFileTitle.value+"&accessory1=<%=contentAccName%>&accessorySaveName1=<%=contentAccSaveName%>&accessoryName2=<%=accessoryName2%>&accessorySaveName2=<%=accessorySaveName2%>",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');
	postWindowOpen("<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_bottom_tosendfilecheck.jsp?sendFileCheckComeUnit=<%=request.getAttribute("documentSendFileWriteOrg")==null?"":request.getAttribute("documentSendFileWriteOrg")%>&id="+document.all.editId.value+"&sendType=sendFile&sendFileCheckComeUnit=<%=request.getAttribute("receiveFileSendFileUnit")==null?"":request.getAttribute("receiveFileSendFileUnit")%>&fileTitle=<%=request.getAttribute("documentSendFileTitle")==null?"":request.getAttribute("documentSendFileTitle")%>&accessory1=<%=contentAccName%>&accessorySaveName1=<%=contentAccSaveName%>&accessoryName2=<%=accessoryName2%>&accessorySaveName2=<%=accessorySaveName2%>",'mydwin','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=400,height=200');

}


function selecttw() {

var hhref = "<%=rootPath%>/SenddocumentBaseAction.do?action=chooseSendTopical" ;
  postWindowOpen(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=no,width=600,height=300') ;
}

function showAcc(scan){

openPupWin("<%=rootPath%>/public/jsp/pup.jsp?path=govdocumentmanager&fileName=accessoryName&saveName=accessorySaveName&canModify="+scan,550,400);

}

 //起草正文
function wordWindowFirst(){
	 var underwriteTime="";
	 var hasSeal="";
     var departWord="";
     var  wordValue=document.all.sendFileDepartWord.value;   
     if(wordValue!=""){		 
         mystr=wordValue.split(";");      
		 departWord=mystr[1];               
	  }

    document.all.RecordID.value = document.all.content.value;
    document.all.Template.value ="";//现在起抄的时候不套摸班
    document.all.showSignButton.value="0";
    document.all.ShowSign.value="-1";
    document.all.textContent.value="";
    document.all.loadTemp.value="0";
	var  myDatestr=""+new Date().getTime();
    window.open("", "ec"+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0");
 
    form1.target="ec"+myDatestr;
    form1.submit();
	//setdispaly(); 

}

//生成正式文件
function wordWindowDue(){
	 document.all.loadTemp.value="1";
	 var underwriteTime="";
	 var hasSeal="";
	 var underwritePerson="";
	
	 underwriteTime=((document.all.signsendTime)?document.all.signsendTime.value:"");
	 underwriteTime.replaceAll("/","-");
	 if(underwriteTime!=""){
	   underwriteTime=baodate2chinese(underwriteTime);
	 }

	 underwritePerson="<%=qianfaName%>";
	 hasSeal="1";	 
	  var departWord="";
	  
      var  wordValue=((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
      if(wordValue!=""){		 
             mystr=wordValue.split(";");      
			  departWord=mystr[1];               
	  }
            
	 //检查
	 if(!checkTextBe()){
		 return ;
	 }

	trimrnTitle();//去掉 标题与 附件描述的 换行

	document.all.RecordID.value = document.all.content.value;
	var rr ='';
	if(document.all.documentSendFileSendTime){
	rr=document.all.documentSendFileSendTime.value;
	rr=rr.replace("/","年");
	rr=rr.replace("/","月");
	rr=rr+"日"; 
	}
	
	//document.all.documentSendFileSendTime_1.value=rr;
	document.all.sendFileRedHeadId_1.value = ((document.all.sendFileRedHeadId)?document.all.sendFileRedHeadId.value:"");
	document.all.hasSeal.value =hasSeal;
	document.all.$underwriteTime.value="[签发日期]"+underwriteTime;
	document.all.$sendFileGrade.value = "[办理缓急]"+((document.all.sendFileGrade)?document.all.sendFileGrade.value:"");
	document.all.$documentSendFileWriteOrg.value = "[拟稿单位]"+((document.all.documentSendFileWriteOrg)?document.all.documentSendFileWriteOrg.value:"");
	//document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"")+" "+((document.all.documentFileType)?document.all.documentFileType.value:"");
	document.all.$documentSendFileTopicWord.value = "[主题词]"+((document.all.documentSendFileTopicWord)?document.all.documentSendFileTopicWord.value:"");
	document.all.$documentFileType.value = "[文件种类]"+((document.all.documentFileType)?document.all.documentFileType.value:"");
	document.all.$toPerson1.value = "[主送]"+((document.all.toPerson1)?document.all.toPerson1.value:"");
	document.all.$toPerson2.value = "[抄送]"+((document.all.toPerson2)?document.all.toPerson2.value:"");

	if(document.all.toPersonBao){
	  document.all.$toPersonBao.value = "[抄报]"+((document.all.toPersonBao)?document.all.toPersonBao.value:"");
	}

	//if(document.all.toPersonInner){
	  //document.all.$toPersonInner.value = "[内部发送]"+((document.all.toPersonInner)?document.all.toPersonInner.value:"");
	//}

	document.all.$documentSendFilePrintNumber.value = "[共印]"+((document.all.documentSendFilePrintNumber)?document.all.documentSendFilePrintNumber.value:"");
	document.all.$sendFileDepartWord.value = "[机关代字]"+departWord;
	document.all.$senddocumentTitle.value = "[发文标题]"+((document.all.documentSendFileTitle)?document.all.documentSendFileTitle.value:"");
	document.all.$underwritePerson.value = "[签发人]"+underwritePerson;
	document.all.$securityGrade.value = "[秘密级别]"+((document.all.documentSendFileSecurityGrade)?document.all.documentSendFileSecurityGrade.value:"");
	//document.all.$documentSendFilePrintNumber.value = "[印刷份数]"+document.all.documentSendFilePrintNumber.value;
	document.all.$documentSendFileSendTime.value = "[印发日期]"+rr;
	//document.all.$documentSendFileSendTime.value = "[印发时间]"+rr;
	document.all.$sendFileAccessoryDesc.value = "[附件描述]"+((document.all.sendFileAccessoryDesc)?document.all.sendFileAccessoryDesc.value:"");
	document.all.$sendfileNUM.value = "[文号]"+((document.all.documentSendFileByteNumber)?document.all.documentSendFileByteNumber.value:"");
	document.all.$field10.value = "[联系电话]"+((document.all.field10)?document.all.field10.value:"");
	//document.all.$field10.value = "[联系电话]"+document.all.field10.value;
	document.all.$sendFileDraft.value="[拟稿人]"+((document.all.sendFileDraft)?document.all.sendFileDraft.value:"");

	document.all.$zjkySeq.value="[流水号]"+((document.all.zjkySeq)?document.all.zjkySeq.value:"");
	document.all.$zjkySecrecyterm.value="[保密期限]"+((document.all.zjkySecrecyterm)?document.all.zjkySecrecyterm.value:"");
	document.all.$zjkyContentLevel.value="[内容紧急]"+((document.all.zjkyContentLevel)?document.all.zjkyContentLevel.value:"");
	document.all.$documentSendFileCounterSign.value="[会签单位]"+((document.all.documentSendFileCounterSign)?document.all.documentSendFileCounterSign.value:"");
	document.all.$openProperty.value="[公开属性]"+((document.all.openProperty)?document.all.openProperty.value:"");
	//document.all.$documentSendFileCheckDate.value="[呈送签批时间要求]"+document.all.documentSendFileCheckDate.value;
	if(document.all.sendFileFileType && document.all.$sendFileFileType){
		document.all.$sendFileFileType.value="[文件类别]" + document.all.sendFileFileType.value;
	}
	if(document.all.documentSendFileTime){
    var  nigaoshijian=document.all.documentSendFileTime.value;
	     nigaoshijian=nigaoshijian.replace("/","年");
		 nigaoshijian=nigaoshijian.replace("/","月");
		 nigaoshijian=nigaoshijian+"日";

    document.all.$documentSendFileTime.value="[拟稿日期]"+nigaoshijian;	
	}
	if(document.all.showTempSign)
	document.all.showTempSign.value="1";
	if(document.all.showTempHead)
	document.all.showTempHead.value="1";
	if(document.all.showTransPDF)
	document.all.showTransPDF.value="1";
	if(document.all.FileType)
	document.all.FileType.value=((document.all.documentWordType)?document.all.documentWordType.value:"");

	if(document.all.wordId){
    var  wordValue=((document.all.sendFileDepartWord)?document.all.sendFileDepartWord.value:"");  
     if(wordValue!=""){		 
             mystr=wordValue.split(";");    
			 document.all.wordId.value=mystr[0];               
	 }else{
	     document.all.wordId.value="";	 
	 }  	
	}

	 var  templateIds=((document.all.templateId)?document.all.templateId.value:"");

	 var  templateArr=templateIds.split(";");

	 if(templateArr.length>1){ 
	    postWindowOpen("<%=rootPath%>/govezoffice/gov_documentmanager/senddocument_singleTemplate.jsp?templates="+((document.all.templateId)?document.all.templateId.value:""), "fff", "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
	 }else{
	  var  myDatestr=""+new Date().getTime();  
	 document.all.Template.value = ((document.all.templateId)?document.all.templateId.value:"");
	 window.open("", "ec2"+document.all.RecordID.value+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
	 form1.target="ec2"+document.all.RecordID.value+myDatestr;
	 form1.submit();
	 managerDueWord();
	 }
    //setdispaly();
}



function MTWordWindowDue(){
	var  myDatestr=""+new Date().getTime();  
    window.open("", "ec2"+document.all.RecordID.value+myDatestr, "status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0"); 
	form1.target="ec2"+document.all.RecordID.value+myDatestr;
	form1.submit();
	managerDueWord(); 
}


//已查看用户
function showHasRead() {	postWindowOpen('<%=rootPath%>/GovReceiveFileBoxAction.do?action=userinfo&type=showHasRead&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//未查看用户
function showNotRead() {	postWindowOpen('<%=rootPath%>/GovReceiveFileBoxAction.do?action=userinfo&type=showNotRead&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//查看传阅
function viewRead(){
postWindowOpen("<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_Read_main.jsp?tableId="+document.all.tableNameOrId.value+"&processId="+document.all.read_processId.value+"&recordId="+document.all.editId.value,'查看传阅','menubar=0,scrollbars=0,locations=0,width=800,height=600,resizable=no');
}

//阅读情况
function cmdGovRead(){
	postWindowOpen('<%=rootPath%>/GovReceiveFileBoxAction.do?action=userinfo&editId='+document.all.editId.value,'','left=0,top=0,scrollbars=yes,resizable=yes,width=780,height=500');
}

//选择主送 ，抄送
function openEndowSend(type){

if(type=="toPerson1"){   
openEndow('toPerson1Id','toPerson1',document.all.toPerson1Id.value,document.all.toPerson1.value,'userorggroup','no','userorggroup','*0*');
}
if(type=="toPerson2"){   
openEndow('toPerson2Id','toPerson2',document.all.toPerson2Id.value,document.all.toPerson2.value,'userorggroup','no','userorggroup','*0*');
}

if(type=="toPersonBao"){   
openEndow('toPersonBaoId','toPersonBao',document.all.toPersonBaoId.value,document.all.toPersonBao.value,'userorggroup','no','userorggroup','*0*');
}

if(type=="toPersonInner"){   
openEndow('toPersonInnerId','toPersonInner',document.all.toPersonInnerId.value,document.all.toPersonInner.value,'org','no','org','*0*');
}
}

//套用模板时检验
function checkTextBe(){
  if(document.all.sendFileDepartWord.value==""){
   alert("机关代字不能为空！");
   return false;
  }
   if(document.all.documentSendFileTitle.value==""){
   alert("标题不能为空！");
   return false;
  }

 return true;

}

// 生成正文管理文件

 function managerDueWord(){
   if(document.all.content.value!=""){
    var oldName=document.all.contentAccSaveName.value;
	if(oldName==""){
	 document.all.contentAccSaveName.value=document.all.content.value+document.all.documentWordType.value;
     document.all.contentAccName.value=document.all.documentSendFileTitle.value+document.all.documentWordType.value;
	}else{
        var  name=document.all.content.value+document.all.documentWordType.value;
        var resultJ=oldName.indexOf(name);
		if(resultJ==-1){
           document.all.contentAccSaveName.value+="|"+document.all.content.value+document.all.documentWordType.value;
           document.all.contentAccName.value+="|"+document.all.documentSendFileTitle.value+document.all.documentWordType.value;		
		}
	
	}
    
   
   }
 
 }


//
function commPrint(){
alert("预留接口，功能暂未实现!");
}

function sendPrinttext(){
alert("预留接口，功能暂未实现!");
}

//归档
function saveDocument(){
alert("预留接口，功能暂未实现!");
}

//打印
function printTable(){
	postWindowOpen("<%=rootPath%>/GovSendFileAction.do?action=listLoad&editId=<%=_record%>&editType=0&canEdit=0&viewOnly=1&myFile=1&isPrint=1&tableId=<%=_table%>&recordId=<%=_record%>&processId=<%=_processId%>&workId=<%=_work%>", "", "TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600");
}

 //检查办公用语
 function checkOffice(){
	<%  for(int i=0;i<commentName.length;i++){
		if((workStatus.equals("0") && (curCommField.indexOf("$"+commentName[i]+"$")>=0 || curCommField.equals(commentName[i].toString())))|| (workStatus.equals("2") && (curPassRoundCommField.equals(commentName[i].toString()) || curPassRoundCommField.indexOf("$"+commentName[i]+"$") >= 0))){%>
		   document.all.whichBatch.value="<%=commentName[i].toString()%>";//保存的哪个批示意见
	<%}}%>
}

//邮件转发
function transmit(){
 var  toId=document.all.candidateId.value;
 var  toName=document.all.candidate.value;
 var  editId=document.all.editId.value;
 
  if(toName==""){
   alert("请选择接收者");
   return;
  }
  document.all.GovSendFileActionForm.action="<%=rootPath%>/GovSendFileAction.do?action=mailtransmit&toId="+toId+"&toName="+toName+"&editId="+editId+"&isEdit=1";
  document.all.GovSendFileActionForm.submit();
}


// 发文分发
function sendToMy(){

	var  toId=document.all.sendToMyId.value;
	var  toName=document.all.sendToMyName.value;
	var  editId=document.all.editId.value;
	if(toName==""){
	    alert("请选择接收者");
	    return;
	}
	
	document.all.GovSendFileActionForm.action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=<%=sendStatus%>&isSendToMyOther="+document.all.isSendToMyOther.value);
	document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	document.all.GovSendFileActionForm.submit();
	document.all.GovSendFileActionForm.target="";

}

//补发
function cmdSendToMyOther(){
  window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	document.sendToMyOtherForm.target="target";
	document.sendToMyOtherForm.submit();
}

//分发范围
function sendToMyRange(){
	window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	document.sendToMyForm.target="target";
	document.sendToMyForm.sendFileId.value = document.all.editId.value;
	document.sendToMyForm.submit();
}

//下载文件
function cmdDowntext(){
	<%if(smartInUse==0 && sysMap.get("ftpDownloadType") != null && sysMap.get("ftpDownloadType").toString().equals("0")){%>
		DOWN2(document.getElementById("content").value+'.doc',document.getElementById("documentSendFileTitle").value+'.doc');
	<%}else{%>
		window.location.href = '<%=smartInUse==1?rootPath:fileServer%>/public/download/download.jsp?FileName='+document.getElementById("content").value+'.doc&name='+encodeURIComponent(document.getElementById("documentSendFileTitle").value)+'.doc&path=govdocumentmanager';
	<%}%>
}
function DOWN2(serverFileName, clietFileName){
	var retdown = '';
	if(document.all.ActiveFormX2 && document.all.ActiveFormX2.length != undefined){
		retdown = document.all.ActiveFormX2[0].downall(clietFileName,serverFileName);
	} else {
		retdown = document.all.ActiveFormX2.downall(clietFileName,serverFileName);
	}
}

//选择办公用语
function offiDict(textAreaName){
  postWindowOpen('<%=rootPath%>/work_flow/workflow_offiDict.jsp?userId=<%=session.getAttribute("userId")%>&textAreaName=' + textAreaName,'','menubar=0,scrollbars=yes,locations=0,width=400,height=200,resizable=yes');
}




function getNum(){
 document.all.ifrm.src = "<%=rootPath%>/GovSendFileAction.do?action=initSendNum&processId="+document.all.read_processId.value;

}


function modify(){

	   if(!initPara()){
	    return ;
	   }
       
	  document.all.isInModify.value="isInModify";	 document.all.GovSendFileActionForm.action="<%=rootPath%>/GovSendFileAction.do?action=update&sendStatus=<%=sendStatus%>&table="+document.all.tableNameOrId.value;
      document.all.GovSendFileActionForm.submit();
}

//补发直接发送
function supplySend(){
    if(!initPara()) return;
	if(document.all.sendToId2.value==""){
    window.alert("请选择要发送的人！");
	return;
	}
    GovSendFileActionForm.action = "<%=rootPath%>/GovSendFileAction.do?action=supplySend";
    GovSendFileActionForm.submit();
}



//切换 机关代字
function   changeSenddocumentWord(){
   var  wordValue=document.all.sendFileDepartWord.value;
   
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
	               document.all.templateId.value=temId;			 
			 }else{
				  var  sendWordId=mystr[0]; //机关代字 id 
			      var  sendWord=mystr[1];   //机关代字名
			      var  temId=mystr[2];      //模班id 		
	              document.all.templateId.value=temId;			 
			 }         
	 }else{
	     document.all.templateId.value="";	 
	 }  	 
	 document.all.documentSendFileByteNumber.value="";
	 document.all.sendFilePoNumId.value="";
}
</script>
<!--补发表单-->
<form name="sendToMyOtherForm" method="post" action="<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy_other.jsp" >
<input type="hidden" name="sendFileId" value="<%=request.getParameter("record")==null?"":request.getParameter("record")%>"/>
	<table width="100%" style="display='none'">
		<input type="hidden" id="sendToMyRange2" name="sendToMyRange2" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>">
	</table>
</form>
<!--分发范围表单-->
<form name="sendToMyForm" action="<%=rootPath%>/govezoffice/gov_documentmanager/sendocument_bottom_SendToMy_range.jsp" method="post" >
<input type="hidden" id="sendToMyRange3" name="sendToMyRange3" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>"/>
<input type="hidden" name="sendFileId" value="<%=request.getParameter("record")==null?"":request.getParameter("record")%>"/>

<input type="hidden" id="sendToIdNew" name="sendToIdNew" value="<%=request.getAttribute("sendToId")==null?"":request.getAttribute("sendToId").toString()%>"/>
<input type="hidden" name="sendToNameNew" id="sendToNameNew" value="<%=request.getAttribute("sendToName")==null?"":request.getAttribute("sendToName").toString()%>"/>


</form>
<form name="form1" action="<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp" method="post">
<input type="hidden" name="RecordID">
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
<input type="hidden" name="$sendFileDepartWord" value="-1">
<input type="hidden" name="$senddocumentTitle" value="-1">
<input type="hidden" name="$underwritePerson" value="-1">
<input type="hidden" name="$securityGrade" value="-1">
<input type="hidden" name="$documentSendFileSendTime" value="-1">
<input type="hidden" name="$sendFileAccessoryDesc" value="-1">
<input type="hidden" name="$sendfileNUM" value="-1">
<input type="hidden" name="$documentFileType" value="-1">
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
<html:form action="/GovSendFileAction.do?action=update" method="post">
<input type="hidden" name="htmlContent">
<input type="hidden" name="content" value="<%=request.getAttribute("content")%>">
<html:hidden property="sendFileLink"/>

<input type="hidden" name="oldTitle" >
<input type="hidden" name="oldToPerson1">
<input type="hidden" name="oldToPerson2">
<input type="hidden" name="oldToInnner">

<input type="hidden" name="sendSeqId">
<input type="hidden" name="sendSeqfig">
<input type="hidden" name="done">
<input type="hidden" name="editId" value="<%=read_recordId%>">
<html:hidden  property="sendFilePoNumId" />
<html:hidden  property="templateId" />
<html:hidden  property="zjkyWordId"  />

<html:hidden property="toPerson3"/>
<html:hidden property="toPerson4"/>
<html:hidden property="toPerson5"/>
<html:hidden property="toPerson6"/>
<input type="hidden" name="tableNameOrId" value="<%=read_tableId%>">
<input type="hidden" name="read_processId" value="<%=read_processId%>">
<html:hidden property="documentWordType"/>
<input type="hidden" name="candidateId">
<input type="hidden" name="candidate">
<input type="hidden" name="addDivContent" value="">
<input type="hidden" name="whichBatch" value="">
<input type="hidden" name="isInModify" value="">
<input type="hidden" name="contentAccName" value="<%=contentAccName%>">
<input type="hidden" name="contentAccSaveName" value="<%=contentAccSaveName%>">
<input type="hidden" name="sendToMyId" >
<input type="hidden" name="sendToMyName">
<input type="hidden" name="sendToType" value="0">
<input type="hidden" name="documentCreateTime" value="<%=createTimeStr%>">
<input type="hidden" name="sendFileNeedSendMsg2" value="0">
<input type="hidden" name="sendFileNeedRTX" value="0">
<input type="hidden" name="sendFileNeedMail" value="0">
<input type="hidden" name="isSendToMyOther" value="0">
<input type="hidden" name="isSyncToInfomation" value="<%=request.getAttribute("isSyncToInfomation")==null?"0":request.getAttribute("isSyncToInfomation").toString()%>"/>
<html:hidden property="sendFileText"/>
<html:hidden property="sendFileType"/>
<html:hidden property="sendFileRedHeadId"/>
<html:hidden property="documentSendFileHead" value="-1" />
<html:hidden  property="field1" />
<input type="hidden" name="field2" value="<%=!"1".equals(request.getParameter("newResubmit"))?(request.getAttribute("field2")==null?"":request.getAttribute("field2")):""%>"/>
<html:hidden   property="field6" />
<html:hidden property="toPerson1Id"/>	
<html:hidden property="toPerson2Id"/>
<html:hidden property="toPersonInnerId"/>
<html:hidden property="toPersonBaoId"/>
<html:hidden property="field5"/>

<input type="hidden" name="field3" value="<%=request.getAttribute("field3")==null?nowYearInt:request.getAttribute("field3").toString()%>">
<input type="hidden" name="handOutTime" value="<%=request.getAttribute("handOutTime")==null?"":request.getAttribute("handOutTime").toString()%>">
<input type="hidden" id="sendToMyRange" name="sendToMyRange" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>">
<input type="hidden" name="createdEmp" value="<%=request.getAttribute("createdEmp")==null?"":request.getAttribute("createdEmp").toString()%>">
<input type="hidden" name="createdOrg" value="<%=request.getAttribute("createdOrg")==null?"":request.getAttribute("createdOrg").toString()%>">
<%if(request.getParameter("resubmit")!=null&&request.getParameter("resubmit").toString().equals("1")&&request.getParameter("work") != null){%>
  <input type="hidden" name="resubmitWorkId" value="<%=request.getParameter("work").toString()%>">
  <input type="hidden" name="newResubmit" value="<%=request.getParameter("newResubmit")==null?"0":request.getParameter("newResubmit")%>">
  <%}%>
<%
boolean banli=(request.getParameter("option")!=null&&"banli".equals(request.getParameter("option")))?true:false;
if(banli){
%>
<script src="js/js.js" language="javascript"></script>
<script language="javascript">
resizeWin(700,600);
</script>
<%}%>
<!--重新提交-->

<html:hidden property="receiveFileIsFlowMode"/>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  
 <tr>
    <td height="37" id="popToolbar"><div id="commandBar"></div>
	</td>
  </tr>
  
  <tr>
  <td valign="top" style="padidng:1px;padding-top:0px;">
<div id="mainFrame" style="height:100%;width:100%;overflow:auto;">

<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
  <tr>
    <td>
	&nbsp;&nbsp;&nbsp;<span id="Panle0" onClick="btnSelect(0);" style="color:red;cursor:hand">基本信息</span>
	
	<%if(read_inWorkType!=0&&read_inWorkType!=-1){%>| <span id="Panle1" onClick="btnSelect(1);" style="color:black;cursor:hand">流程图</span><%}%>
	
	| <span id="Panle2" onClick="btnSelect(2);" style="color:black;cursor:hand">流程记录</span>
	
	| <span id="Panle3" onClick="btnSelect(3);" style="color:black;cursor:hand">修改记录</span>
	| <span id="Panle6" onClick="btnSelect(6);" style="color:black;cursor:hand">关联流程</span>
	| <span id="Panle7" onClick="btnSelect(7);" style="color:black;cursor:hand;">相关附件</span>
    | <span id="Panle8" onClick="btnSelect(8);" style="color:black;cursor:hand;">相关收文</span>
	  </td>
  </tr>
</table>

<table width="100%" border="0" cellpadding="1" cellspacing="0" class="docBox" style="background-color:#ffffff;border:0px;">
  <tr>
    <td height="312" valign="top">
	           <div id="docinfo0">
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
                      <td align="right" valign="middle"><div align="left">
                          <table width="80%" border="0" align="center" cellpadding="1" cellspacing="1">
                              <input type="hidden" name="done"/>
                     
		
	                          <tr>
							  <td width="100%"><table width="100%" border="0" cellpadding="0" cellspacing="0">					      
							     <tr <%=banli?"style='display:none'":""%>>
							       <td colspan="6" align="center" style="border-bottom:#FF0000 solid 4px; font-weight:bold;font-size:30; color:#FF0000">&nbsp;<%=processName%>&nbsp;</td>
						          </tr>
							     <tr>
							       <td width="10%" height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">签&nbsp;&nbsp;&nbsp; 发：</font></span></td>
							       <td valign="top" class="STYLE1" id="commentDiv_documentSendFileSendFile" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
						           <td colspan="-1" align="left" class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;审核意见：</font></td>
						           <td colspan="3" valign="top" class="STYLE1" id="commentDiv_documentSendFileCheckCommit" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
					              </tr>
							     <tr>
							       <td height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">会&nbsp;&nbsp;&nbsp; 签：</font></span></td>
							       <td valign="top" class="STYLE1" id="commentDiv_sendFileMassDraft" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
							       <td colspan="-1" align="left" class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;核&nbsp;&nbsp;&nbsp;稿：</font></td>
							       <td colspan="3" valign="top" class="STYLE1" id="commentDiv_sendFileProveDraft" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
						          </tr>
							     <tr>
							       <td height="70" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">审阅意见：</font></span></td>
							       <td valign="top" class="STYLE1" id="commentDiv_sendFileReadComment" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
							       <td colspan="-1" align="left" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;承办单位意见：</font></td>
							       <td colspan="3" valign="top" class="STYLE1" id="commentDiv_documentSendFileAssumeUnit" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
						          </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000" class="STYLE1">附&nbsp;&nbsp;&nbsp; 件：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;
                                   <%
									boolean canModify = true ;
									if(curModifyField.indexOf("$accessoryName$") < 0) {
									canModify = false;
									}
									if("1".equals(isEdit)){
									canModify = true;
									}
									String[] realFileArray ;
									String[] saveFileArray ;
									Object accName = accessoryName2 ;
									Object accSName = accessorySaveName2 ;
									if(null!=accName && !"".equals(accName) && null!=accSName && !"".equals(accSName)) {
									realFileArray = (accName+"").split("\\|");
									saveFileArray = (accSName+"").split("\\|") ;
									}else {
									realFileArray = new String[0] ;
									saveFileArray = new String[0] ;
									}
									String path = "govdocumentmanager" ;
									String tableName="govdocumenttable";
									String fileName = "accessoryName" ;
									String saveName = "accessorySaveName";
									int fileMaxSize = 0;
									int fileMaxNum  = 20;
									int fileMaxWidth = 0 ;
									int fileMaxHeight = 0;
									int fileMinWidth = 0;
									int fileMinHeight = 0;
									String fileType = "" ;
									%>
									<%@ include file = "../../public/jsp/modifyupload.jsp" %>                                 </td>
						          </tr>
							     <tr>
							       <td width="10%" height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文&nbsp;&nbsp;&nbsp; 头：</font></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"> 
                                   <%
									String zjkyWordId=request.getAttribute("zjkyWordId")==null?"":request.getAttribute("zjkyWordId").toString();
									if("".equals(zjkyWordId)){
										zjkyWordId = myform.getZjkyWordId()+"";
									}
									%>
									 <%if("1".equals(isEdit)||curModifyField.indexOf("$sendFileDepartWord$") >=0){%>
									 <select name="sendFileDepartWord"  onchange="changeSenddocumentWord()">
									  <option value="">-请选择-</option> 
									 <%if(wordList!=null&&wordList.size()>0){
								 	  for(int i=0;i<wordList.size();i++){
									     Object wordObj[]=(Object [])wordList.get(i);				
								     	 String  wordValue=""+wordObj[0]+";"+wordObj[1]+";"+wordObj[2];
									     String  wordText=wordObj[1]+"";
									%>								
									 <option value="<%=wordValue%>"<%=zjkyWordId.equals(wordObj[0]+"")?" selected":""%>><%=wordText%></option>
									<%}}%>
									</select>   
                                   <%}else{%>
                                   
                                     <%=sendWord==null?"&nbsp;":sendWord%>     
                                      <html:hidden property="sendFileDepartWord"/>
                                  <%}%>&nbsp;                                   </td>
						           <td width="10%" colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">字&nbsp;&nbsp;&nbsp; 号：</font></td>
						           <td width="10%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp; 
                                     <input type="text" class="sw" name="documentSendFileByteNumber" value="<%=!"1".equals(request.getParameter("newResubmit"))?(request.getAttribute("documentSendFileByteNumber")==null?"":request.getAttribute("documentSendFileByteNumber")):""%>" readonly="true" size="30"/>                                   </td>
						           <td width="10%" align="right" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">办理缓急：</font></td>
						           <td width="20%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"> &nbsp;
                                     <%if("1".equals(isEdit)){%>
                                    <html:select property="sendFileGrade">
                                       <%if(transactLevel!=null&&transactLevel.length>0){
										    for(int i=0;i<transactLevel.length;i++){
											 String transactLevelObj=transactLevel[i];
											 
											 %>
											  
									 <option value="<%=transactLevelObj%>"<%=transactLevelObj.equals(myform.getSendFileGrade())?" selected":""%>><%=transactLevelObj%></option>
											<%}
										  
										  }%>
                                    </html:select>
                                <%}else{%>
                                <%if(curModifyField.indexOf("$sendFileGrade$") < 0){%>
                                    <%=myform.getSendFileGrade()==null?"":myform.getSendFileGrade()%>
                                    <html:hidden property="sendFileGrade"/>
                                <%}else{%>
                                    <html:select property="sendFileGrade">
                                        <%if(transactLevel!=null&&transactLevel.length>0){
										    for(int i=0;i<transactLevel.length;i++){
											 String transactLevelObj=transactLevel[i];
											 %>
											  
									 <option value="<%=transactLevelObj%>"<%=transactLevelObj.equals(myform.getSendFileGrade())?" selected":""%>><%=transactLevelObj%></option>
											<%}
										  
										  }%>
                                    </html:select>
                                <%}
                                }%>                                   </td>
							     </tr>
							     <tr>
							       <td height="40" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件标题：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)){%>
								   <html:text styleClass="sw" maxlength="200" property="documentSendFileTitle" style="width:100%;" size="70"/>                        
                                <%}else{
                                  if(curModifyField.indexOf("$documentSendFileTitle$") < 0){%>
                                    <%=myform.getDocumentSendFileTitle()==null?"&nbsp;":myform.getDocumentSendFileTitle()%>
                                    <html:hidden property="documentSendFileTitle"/>
                                  <%}else{%>
                                    <html:text styleClass="sw" maxlength="200" property="documentSendFileTitle" style="width:100%;" size="70"/>          
                                <%} }%>
                                                                  </td>
						          </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
								   <font color="#FF0000">主 题 词：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)||curModifyField.indexOf("$documentSendFileTopicWord$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                    <html:text styleClass="sw" maxlength="49" style="width:65%;" property="documentSendFileTopicWord" size="70" />
                                    <img src="images/select.gif"  onclick="selecttw()" style="cursor:hand"/>
									<font color="#FF0000">文件种类：</font>
									<html:select property="documentFileType">
                                        <%if(fileTypeArr!=null&&fileTypeArr.length>0){
										    for(int i=0;i<fileTypeArr.length;i++){
											 String sendfileTypeValue=fileTypeArr[i];
											 %>										  
									      <option value="<%=sendfileTypeValue%>"<%=sendfileTypeValue.equals(myform.getDocumentFileType())?" selected":""%>><%=sendfileTypeValue%></option>
									 <%}}%>
                                    </html:select>
                                    <input type="hidden" name="topicWordMustWrite" value="1">
                                  <%}else{%>                                 
                                     <%=(myform.getDocumentSendFileTopicWord()==null||"".equals(myform.getDocumentSendFileTopicWord()))?"&nbsp;":myform.getDocumentSendFileTopicWord()%>
									</td>
									<td width="10%" colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件种类：</font></td>
						           	<td width="10%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp; 
						           	<%=myform.getDocumentFileType()==null?"&nbsp;":("&nbsp;"+myform.getDocumentFileType())%>
                                     <html:hidden property="documentSendFileTopicWord"/>
									 <html:hidden property="documentFileType"/>
                                   <%}%>&nbsp;								 </td>
						          </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">主&nbsp;&nbsp;&nbsp; 送：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                    <%if("1".equals(isEdit)||curModifyField.toLowerCase().indexOf("$maintoname$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                  
                                    <html:text styleClass="sw" style="width:85%;" maxlength="200"  property="toPerson1"  size="70"/><a href="javascript:;" onClick="getNote('toPerson1');" onMouseOut="hiddenNote('toPerson1');" onMouseOver="lockedNote();">分发单位&nbsp;</a><img src="images/select.gif" title="选择" style="cursor:hand" onClick="openEndowSend('toPerson1');"/><!--<button class="btnButton2Font" onClick="openEndowSend('toPerson1');">选择</button>-->                                          
                                      <%}else{%>
                                         <%=myform.getToPerson1()==null?"&nbsp;":myform.getToPerson1()%>
                                          <html:hidden property="toPerson1"/>
                                      <%}%>	&nbsp;							  </td>
								 </tr>
								 <div id="noteDiv_toPerson1" onMouseOut="hiddenNote('toPerson1');" onMouseOver="lockedNote();"   style= "background-color:White;z-index:0">
									<% for(int j=0;null !=issueUnitList && j<issueUnitList.size();j++){										
										 GovIssueUnitPO govIssueUnitPO = (GovIssueUnitPO)issueUnitList.get(j);
									%>
										<div class="divOut" onMouseOver="lockedNote();this.className='divOver'" onMouseOut="this.className='divOut'" ><input type="checkbox" name="issueUnit_toPerson1_<%=j%>" onClick="setNoteExt(this,'toPerson1','toPerson1Id','<%=govIssueUnitPO.getUnitName()%>','<%=govIssueUnitPO.getUnitId()%>')"/><%=govIssueUnitPO.getUnitName()%></div>
									<%}%>
							   </div>	
                                   
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">抄&nbsp;&nbsp;&nbsp; 送：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)||curModifyField.toLowerCase().indexOf("$copytoname$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                     <html:text styleClass="sw" maxlength="200"  style="width:85%;" property="toPerson2" size="70"/><a href="javascript:;" onClick="getNote('toPerson2');" onMouseOut="hiddenNote('toPerson2');" onMouseOver="lockedNote();">分发单位&nbsp;</a><img src="images/select.gif" title="选择" style="cursor:hand" onClick="openEndowSend('toPerson2');"/><!--<button class="btnButton2Font" onClick="openEndowSend('toPerson2');" >选择</button>-->
                                              
                                          <%}else{%>
                                             <%=myform.getToPerson2()==null?"&nbsp;":myform.getToPerson2()%>
                                              <html:hidden property="toPerson2"/>
                                          <%}%>	&nbsp;							  </td>
								 </tr>
								<div id="noteDiv_toPerson2" onMouseOut="hiddenNote('toPerson2');" onMouseOver="lockedNote();"   style= "background-color:White;z-index:0;display:none">
									<% for(int j=0;null !=issueUnitList && j<issueUnitList.size();j++){										
										 GovIssueUnitPO govIssueUnitPO = (GovIssueUnitPO)issueUnitList.get(j);
									%>
										<div class="divOut" onMouseOver="lockedNote();this.className='divOver'" onMouseOut="this.className='divOut'" ><input type="checkbox" name="issueUnit_toPerson1_<%=j%>" onClick="setNoteExt(this,'toPerson2','toPerson2Id','<%=govIssueUnitPO.getUnitName()%>','<%=govIssueUnitPO.getUnitId()%>')"/><%=govIssueUnitPO.getUnitName()%></div>
									<%}%>
							   </div>	
                                   
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">拟稿单位：</font></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
								   <%if("1".equals(isEdit)||curModifyField.indexOf("$documentSendFileWriteOrg$")>=0||"1".equals(request.getParameter("resubmit"))){%>
								    <html:text styleClass="sw" style="width:100%;" property="documentSendFileWriteOrg"  maxlength="100" size="60"/>
                                    
                                   <%}else{%>
                                     <%=myform.getDocumentSendFileWriteOrg()==null?"&nbsp;":myform.getDocumentSendFileWriteOrg()%>
                                    <html:hidden property="documentSendFileWriteOrg"/>
                                <%}%>&nbsp;								   </td>
						           <td colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">会签单位：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)||curModifyField.indexOf("$documentSendFileCounterSign$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                   <html:text styleClass="sw" style="width:100%;" maxlength="1000" property="documentSendFileCounterSign" size="30"/>
                                <%}else{%>
                                    <%=myform.getDocumentSendFileCounterSign()==null?"&nbsp;":myform.getDocumentSendFileCounterSign()%>
                                    <html:hidden property="documentSendFileCounterSign"/>
                                <%}%>								  &nbsp; </td>
						           <td align="right" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">拟稿人：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)||curModifyField.indexOf("$sendFileDraft$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                   <html:text styleClass="sw" style="width:100%;" property="sendFileDraft" maxlength="25" size="30"/>
                                        <%}else{%>
                                            <%=myform.getSendFileDraft()==null?"&nbsp;":myform.getSendFileDraft()%>
                                            <html:hidden property="sendFileDraft"/>
                                      <%}%>&nbsp;</td>
							     </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">公开属性：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                    <%if("1".equals(isEdit)||curModifyField.indexOf("$openProperty$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                    <html:select property="openProperty">
                                        <%if(openPropertyArr!=null&&openPropertyArr.length>0){
										    for(int i=0;i<openPropertyArr.length;i++){
											 String openPropertyValue=openPropertyArr[i];
											 %>
											  
									    <option value="<%=openPropertyValue%>"<%=openPropertyValue.equals(myform.getOpenProperty())?" selected":""%>><%=openPropertyValue%></option>
									  <%} }%>
                                    </html:select>
                                   <%}else{%>
                                    <%=myform.getOpenProperty()==null?"&nbsp;":myform.getOpenProperty()%>
                                    <html:hidden property="openProperty"/>
                                  <%}%>	&nbsp;							   </td>
						           </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">签发日期：</font></td>
							       <td width="80" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)||curModifyField.indexOf("$signsendTime$")>=0||"1".equals(request.getParameter("resubmit"))){%>
								    
                                    <script language=javascript>
						            var signsendTime = createDatePicker("signsendTime",'<%=signsendTimeYear%>','<%=signsendTimeMonth%>','<%=signsendTimeDate%>');
					               </script>
								   
                                   <%}else{
									   if(request.getAttribute("signsendTime")!=null&&!request.getAttribute("signsendTime").toString().equals("")){
									   %>
                                   <%=signsendTimeYear%>&nbsp;年&nbsp;<%=signsendTimeMonth%>&nbsp;月&nbsp;<%=signsendTimeDate%>&nbsp;日
								   <%}%>
                                   <input type="hidden" name="signsendTime" value="<%=signsendTimeStr%>">
                                  <%}%>								  </td>
						           <td colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">共&nbsp;&nbsp;&nbsp; 印：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td width="1%" align="left" nowrap>
                                        <%if("1".equals(isEdit)||curModifyField.indexOf("$documentSendFilePrintNumber$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                         <html:text styleClass="sw"  property="documentSendFilePrintNumber" size="10"/>
                                          <%}else{%>
                                              <%="0".equals(myform.getDocumentSendFilePrintNumber())?"0&nbsp;":myform.getDocumentSendFilePrintNumber()%>
                                              <html:hidden property="documentSendFilePrintNumber"/>
                                          <%}%></td>
                                        <td align="left"><font color="#FF0000">份</font></td>
                                      </tr>
                                    </table>                                   </td>
						           <td colspan="2" align="right" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <%if("1".equals(isEdit)||curModifyField.indexOf("$documentSendFileSendDate$")>=0||"1".equals(request.getParameter("resubmit"))){%>
                                   
                                   <script language=javascript>
						 var dtpDate = createDatePicker("documentSendFileSendTime",'<%=sendFileSendDateYear%>','<%=sendFileSendDateMonth%>','<%=sendFileSendDateDate%>');
					     </script>
                                         <%}else{%>
                                             <input type="hidden" name="documentSendFileSendTime" value="<%=sendFileSendDateYear+"/"+sendFileSendDateMonth+"/"+sendFileSendDateDate%>"/><%=sendFileSendDateYear%>&nbsp;年&nbsp;<%=sendFileSendDateMonth%>&nbsp;月&nbsp;<%=sendFileSendDateDate%>&nbsp;日
                                     
                                         <%}%>印发							  </td>
					              </tr>
                                  <%String backComment=new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getBackComment(read_processId,read_tableId,read_recordId)==null?"":new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getBackComment(read_processId,read_tableId,read_recordId);
          
			   if(backComment!=null &&!backComment.trim().equals("")&&!backComment.equals("null")){%>
               
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">退回意见：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><%out.print(backComment);%>&nbsp;</td>
						        </tr>
							     <% }%> 
							    </table></td>
							  </tr>

                         
                         <%
                         String cancelHref = "postWindowOpen('" + rootPath + "/govezoffice/gov_documentmanager/workflow_cancelReason.jsp?workStatus=1&workId=workIdValue&search=searchValue&workTitle=workTitleValue&tableId=tableIdValue&processName=processName&processId=processIdValue&recordId=recordIdValue&fileType=GSF&fileTitle=fileTitleValue','','TOP=0,LEFT=0,scrollbars=no,resizable=no,width=480,height=250')";
                          String formName = "GovSendFileActionForm";//在包含页中指定form的名称
                          String saveCheckFn = "initPara()";//保存时校验表单的javascript函数名称
                          String mainLinkFile = rootPath + "/GovSendFileLoadAction.do?action=load";//文件办理时打开的页面链接
						  //String passLinkFile="GovReceiveFileBoxAction.do?action=loadFile&editId="+request.getParameter("record")+"&canEdit=1&isEdit=0&viewType=1&showReceiveFile=1&transmitType=wordTransmit";//文件查阅的页面链接

						  String passLinkFile=rootPath + "/GovSendFileLoadAction.do?action=load";//文件查阅的页面链接
                          String subProcHref =rootPath + "/GovSendFileAction.do?action=see&moduleId=2";//新建子流程链接
                          String titleFieldName = "documentSendFileTitle";//作为显示标题的表单中的元素的名称,如果为""则按工作流程的标题
				          String title = myform.getDocumentSendFileTitle()==null?"临时标题":myform.getDocumentSendFileTitle();
				          String[][] button = null;//包含页面中的附加按钮的名称和触发的javascript函数名称
				          if("1".equals(request.getParameter("resubmit"))&&(1>2)){
							  button = new String[2][2];
                              button[0][0] = "直接发送";
                              button[0][1] = "directSendShow()";
							  button[1][0] = "保存草稿";
                              button[1][1] = "draft()";
						  }else if((!banli)&&(1>2)){
							  button = new String[1][2];
                          	  button[0][0] = "打印";
                          	  button[0][1] = "myPrint()";
                          }
                          String msgFrom = "发文管理";//短信提醒模块名称
                          %>
                            <tr id="directSendTR" style="display=none">
                              <td height="22" nowrap>
                              <div align=center>发送到：<input type=hidden name=sendToId2>
				<textarea cols=40 rows=5 class=css0 readonly=true name=sendToName2></textarea>&nbsp;&nbsp;&nbsp;&nbsp;<img src=images/group.gif>&nbsp;<img src=images/select.gif style=cursor:hand onClick="openEndow('sendToId2','sendToName2',document.all.sendToId2.value,document.all.sendToName2.value,'user','no','userorggroup','*0*');"></div>
				 <%if(new com.whir.ezoffice.message.action.ModelSendMsg().judgePurviewMessage("发文管理",session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString())){%>
                              <input type="checkbox" name="sendFileNeedSendMsg2" value="1">短信提醒
                              <%}%>                        </td>
                            </tr>
                            <tr id="includeTR">
                              <td height="22">
							 <%
							  String resubmitMyTmp = request.getParameter("resubmit")==null?"":request.getParameter("resubmit");
						  %>
						  <%if(!"1".equals(resubmitMyTmp)){%>
						<jsp:include page="/work_flow/workflow_jspInclude_middleHidden.jsp" flush="true">
								<jsp:param name="formName"  value="<%=formName%>"/>
								<jsp:param name="saveCheckFn"  value="<%=saveCheckFn%>"/>
								<jsp:param name="passLinkFile"  value="<%=passLinkFile%>" />
								<jsp:param name="mainLinkFile"  value="<%=mainLinkFile%>"/>
								<jsp:param name="subProcHref"  value="<%=subProcHref%>"/>
								<jsp:param name="titleFieldName"  value="<%=titleFieldName%>"/>
								<jsp:param name="subProcHref"  value="<%=subProcHref%>"/>
								<jsp:param name="msgFrom"  value="<%=msgFrom%>"/>
								<jsp:param name="cancelHref"  value="<%=cancelHref%>"/>
								<jsp:param name="resubmit"  value="<%=resubmitMyTmp%>"/>
								<jsp:param name="modiButton"  value="<%=modiButton%>"/>
                                <jsp:param name="curCommField"  value="<%=curCommField%>"/>
							</jsp:include>
						<%}else{%>
								<jsp:include page="/work_flow/workflow_jspInclude_firstHidden.jsp" flush="true"> 
								<jsp:param name="formName"  value="<%=formName%>"/>
								<jsp:param name="saveCheckFn"  value="<%=saveCheckFn%>"/>
								<jsp:param name="mainLinkFile"  value="<%=mainLinkFile%>"/>
								<jsp:param name="titleFieldName"  value="<%=titleFieldName%>"/>
								<jsp:param name="msgFrom"  value="<%=msgFrom%>"/>
								<jsp:param name="cancelHref"  value="<%=cancelHref%>"/> 
								</jsp:include>
						<%}%>
                             </td>
                            </tr>
                            <tr  id="directSendButtonTR" style="display=none">                         
                            <td align="left">&nbsp;</td>
                          	</tr>
                            <!--下面为9500版本之前老字段隐藏的部分start-->
                             <tr style="display=none">                         
                            <td align="left">
                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><font color="#FF0000">参考文件：</font></td>
    <td>
   <%
								    canModify = true ;
									if(curModifyField.indexOf("$referenceAccessory$") < 0) {
									canModify = false;
									}
									if("1".equals(isEdit)){
									canModify = true;
									}
									Object referAccessory = request.getAttribute("referenceAccessory") ;
									Object referAccessorySaveName = request.getAttribute("referenceAccessorySaveName") ;
									if(null!=referAccessory && !"".equals(referAccessory) && null!=referAccessory && !"".equals(referAccessory)) {
									realFileArray = (referAccessory+"").split("\\|");
									saveFileArray = (referAccessorySaveName+"").split("\\|") ;
									}else {
									realFileArray = new String[0] ;
									saveFileArray = new String[0] ;
									}
									 path = "govdocumentmanager" ;
									 tableName="govdocumenttable2";
									 fileName = "referenceAccessory" ;
									 saveName = "referenceAccessorySaveName";
									 fileMaxSize = 0;
									 fileMaxNum  = 20;
									 fileMaxWidth = 0 ;
									 fileMaxHeight = 0;
									 fileMinWidth = 0;
									 fileMinHeight = 0;
									 fileType = "" ;
									%>
									<%@ include file = "../../public/jsp/modifyupload.jsp" %> </td>
  </tr>
  <tr>
    <td><font color="#FF0000">附件描述：</font></td>
    <td>
    <%if("1".equals(isEdit)){%>
                                    <html:textarea cols="50" styleClass="inputTextArea" rows="3" property="sendFileAccessoryDesc"></html:textarea>
                                    <%}else{
                                    if(curModifyField.indexOf("$sendFileAccessoryDesc$")==-1) {%>
                                        <%=myform.getSendFileAccessoryDesc()==null?"&nbsp;":myform.getSendFileAccessoryDesc().replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")%>
                                        <html:hidden property="sendFileAccessoryDesc"/>
                                    <%}else{%>
                                        <html:textarea cols="50" styleClass="inputTextArea" rows="3" property="sendFileAccessoryDesc"></html:textarea>
                                    <%} }%>  </td>
  </tr>
  <tr>
    <td><font color="#FF0000">参考文件描述：</font></td>
    <td>
    <%
								   String referenceAccessoryDesc=request.getAttribute("referenceAccessoryDesc")==null?"":request.getAttribute("referenceAccessoryDesc").toString();
								   %>
								  <%if("1".equals(isEdit)||curModifyField.indexOf("$referenceAccessoryDesc$") >=0){%>
								        <textarea cols="50" class="inputTextArea" rows="3" name="referenceAccessoryDesc"><%=referenceAccessoryDesc%></textarea>								  
                                  <%}else{%>
								          <%=referenceAccessoryDesc.replaceAll("\r\n","<br/>").replaceAll(" ","&nbsp;")%>
                                         <input type="hidden" name="referenceAccessoryDesc" value="<%=referenceAccessoryDesc%>">  
                                  <%}%>      </td>
  </tr>
  <tr>
    <td><font color="#FF0000">秘密级别：</font></td>
    <td>
    <%if("1".equals(isEdit)){%>
                                    <html:select property="documentSendFileSecurityGrade">
                                       <%if(secretLevel!=null&&secretLevel.length>0){
										    for(int i=0;i<secretLevel.length;i++){
											 String secretLevelObj=secretLevel[i];
											 %>										  
									 <option value="<%=secretLevelObj%>"><%=secretLevelObj%></option>
									<%}	}%>
                                    </html:select>
                                <%}else{%>
                                <%if(curModifyField.indexOf("$documentSendFileSecurityGrade$") < 0){%>
                                    <%=myform.getDocumentSendFileSecurityGrade()==null?"":myform.getDocumentSendFileSecurityGrade()%>
                                    <html:hidden property="documentSendFileSecurityGrade"/>
                                <%}else{%>
                                    <html:select property="documentSendFileSecurityGrade">
                                        <%if(secretLevel!=null&&secretLevel.length>0){
										    for(int i=0;i<secretLevel.length;i++){
											 String secretLevelObj=secretLevel[i];
											 %>
											  
									 <option value="<%=secretLevelObj%>"><%=secretLevelObj%></option>
									<%} }%>
                                    </html:select>
                                <%}
                                }%></td>
  </tr>
  <tr>
    <td><font color="#FF0000">流水号：</font></td>
    <td> <input type="text" class="sw" name="zjkySeq" value="<%=!"1".equals(request.getParameter("newResubmit"))?(request.getAttribute("zjkySeq")==null?"":request.getAttribute("zjkySeq")):""%>" readonly="true" size="20" maxlength="25" /></td>
  </tr>
  <tr>
    <td><font color="#FF0000">文件类别：</font></td>
    <td>
    <% String sendFileFileType_value=request.getAttribute("sendFileFileType")==null?"":request.getAttribute("sendFileFileType").toString();
									if("1".equals(isEdit)||curModifyField.indexOf("$sendFileFileType$")>= 0||"1".equals(request.getParameter("resubmit"))){%>
										<html:select property="sendFileFileType">
											 <%if(sendFileFileType_Arr!=null&&sendFileFileType_Arr.length>0){
												  for(int i=0;i<sendFileFileType_Arr.length;i++){
												  String sendFileFileType_ArrObj=sendFileFileType_Arr[i].toString(); %>
												<option value="<%=sendFileFileType_ArrObj%>"><%=sendFileFileType_ArrObj%></option>
											<%}}%>
										</html:select>
										<%}else{%><%=sendFileFileType_value==null?"":sendFileFileType_value%>
										<html:hidden property="sendFileFileType"/>
										<%}%>
    </td>
  </tr>
  <tr>
    <td><font color="#FF0000">保密期限：</font></td>
    <td>
    <%if("1".equals(isEdit)){%>
                                    <html:select property="zjkySecrecyterm">
                                       <%if(keepSecretLevel!=null&&keepSecretLevel.length>0){
										    for(int i=0;i<keepSecretLevel.length;i++){
											 String keepSecretLevelObj=keepSecretLevel[i];
											 %>
											  
									 <option value="<%=keepSecretLevelObj%>"><%=keepSecretLevelObj%></option>
											<%}
										  
										  }%>
                                    </html:select>
                                <%}else{%>
                                <%if(curModifyField.indexOf("$zjkySecrecyterm$") < 0){%>
                                    <%=myform.getZjkySecrecyterm()==null?"":myform.getZjkySecrecyterm()%>
                                    <html:hidden property="zjkySecrecyterm"/>
                                <%}else{%>
                                    <html:select property="zjkySecrecyterm">
                                        <%if(keepSecretLevel!=null&&keepSecretLevel.length>0){
										    for(int i=0;i<keepSecretLevel.length;i++){
											 String keepSecretLevelObj=keepSecretLevel[i];
											 %>
											  
									 <option value="<%=keepSecretLevelObj%>"><%=keepSecretLevelObj%></option>
											<%}
										  
										  }%>
                                    </html:select>
                                <%}
                                }%></td>
  </tr>
  <tr>
    <td><font color="#FF0000">内容紧急：</font></td>
    <td>
     <%if(curModifyField.indexOf("$toPersonInner$") < 0 && !"1".equals(request.getParameter("resubmit"))){%>
                                              <%=myform.getToPersonInner()==null?"&nbsp;":myform.getToPersonInner()%>
                                              <html:hidden property="toPersonInner"/>
                                          <%}else{%>
                                              <html:text styleClass="sw" maxlength="200"   property="toPersonInner" size="70"/><img src="images/select.gif" title="选择" style="cursor:hand" onClick="openEndowSend('toPersonBao');"/><!--<button class="btnButton2Font" onClick="openEndowSend('toPersonBao');" >选择</button>-->  
                                          <%}%>
								  </td>
  </tr>
  <tr>
    <td><font color="#FF0000">抄报：</font></td>
    <td>
     <%if(curModifyField.indexOf("$toPersonBao$") < 0 && !"1".equals(request.getParameter("resubmit"))){%>
                                              <%=myform.getToPersonBao()==null?"&nbsp;":myform.getToPersonBao()%>
                                              <html:hidden property="toPersonBao"/>
                                          <%}else{%>
                                              <html:text styleClass="sw" maxlength="200"   property="toPersonBao" size="70"/><a href="javascript:;" onClick="getNote('toPersonBao');" onMouseOut="hiddenNote('toPersonBao');" onMouseOver="lockedNote();">分发单位&nbsp;</a><img src="images/select.gif" title="选择" style="cursor:hand" onClick="openEndowSend('toPersonBao');"/><!--<button class="btnButton2Font" onClick="openEndowSend('toPersonBao');" >选择</button>-->
                                     <%}%>  </td>
  </tr>
  								 <div id="noteDiv_toPersonBao" onMouseOut="hiddenNote('toPersonBao');" onMouseOver="lockedNote();"   style= "background-color:White;z-index:0">
									<% for(int j=0;null !=issueUnitList && j<issueUnitList.size();j++){
										GovIssueUnitPO govIssueUnitPO = (GovIssueUnitPO)issueUnitList.get(j);
									%>
										<div class="divOut" onMouseOver="lockedNote();this.className='divOver'" onMouseOut="this.className='divOut'" ><input type="checkbox" name="issueUnit_toPersonBao_<%=j%>" onClick="setNoteExt(this,'toPersonBao','toPersonBaoId','<%=govIssueUnitPO.getUnitName()%>','<%=govIssueUnitPO.getUnitId()%>')"/><%=govIssueUnitPO.getUnitName()%></div>
									<%}%>
							   </div>	
  <tr>
    <td><font color="#FF0000">内部发送：</font></td>
    <td><%if(curModifyField.indexOf("$toPersonInner$") < 0 && !"1".equals(request.getParameter("resubmit"))){%>
                                              <%=myform.getToPersonInner()==null?"&nbsp;":myform.getToPersonInner()%>
                                              <html:hidden property="toPersonInner"/>
                                          <%}else{%>
                                              <html:text styleClass="sw" maxlength="200"   property="toPersonInner" size="70"/><img src="images/select.gif" title="选择" style="cursor:hand" onClick="openEndowSend('toPersonInner');"/><!--<button class="btnButton2Font" onClick="openEndowSend('toPersonInner');" >选择</button>-->  
                                          <%}%>
								  </td>
  </tr>
  <tr>
    <td><font color="#FF0000">拟稿日期：</font></td>
    <td>
    <%if(curModifyField.indexOf("$documentSendFileDate$") < 0 && !"1".equals(request.getParameter("resubmit"))){
										   if(request.getAttribute("sendFileDate")!=null){%>
                                             <%=sendFileDateYear%>&nbsp;年&nbsp;<%=sendFileDateMonth%>&nbsp;月&nbsp;<%=sendFileDateDate%>&nbsp;日
											 <%}%>
                                             <input type="hidden" name="documentSendFileTime" value="<%=sendFileDateYear+"/"+sendFileDateMonth+"/"+sendFileDateDate%>"/>
                                         <%}else{%>
                                             <script language=javascript>
                                             var dtpDate = createDatePicker("documentSendFileTime",'<%=sendFileDateYear%>','<%=sendFileDateMonth%>','<%=sendFileDateDate%>');
                                             </script>
                                         <%}%>
								   </td>
  </tr>
  <tr>
    <td><font color="#FF0000">联系电话：</font></td>
    <td>
    <%if(!"1".equals(isEdit)&&curModifyField.indexOf("$field9$") < 0 && !"1".equals(request.getParameter("resubmit"))){%>
                                            <%=myform.getField9()==null?"&nbsp;":myform.getField9()%>
                                            <html:hidden property="field9"/>
                                        <%}else{%>
                                            <html:text styleClass="sw" property="field9" maxlength="25" size="40"/>
                                        <%}%>
								   </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>

                            </td>
                          	</tr>
                            <!--下面为9500版本之前老字段隐藏的部分end-->
                          </table>
                        </div></td>
                    </tr>
					<%if(read_inWorkType!=0&&read_inWorkType!=-1){%>
						 <tr>                         
						<td align="left">
						<jsp:include page="/govezoffice/gov_documentmanager/govdocumentmanager_jspInclude_backComment.jsp" flush="true">
							 <jsp:param name="table"  value="<%=_table%>"/>  
							<jsp:param name="record"  value="<%=_record%>"/>
						</jsp:include>

						</td>
						</tr>
					  <%}else if(read_inWorkType == 0){%>
					   <tr>                         
						<td align="left"><jsp:include page="/work_flow/workflow_jspinclude_comment.jsp" flush="true" /></td>
						</tr>
						<%}%>
            </table>
            </div>
            <div id="docinfo1" style="display:none">					   
			<TABLE>
		<tr>
		<td valign="top" align="center">		
  <iframe id="workFlowGraphIframe" src=""  allowTransparency="true"    frameborder="0"  style="" ></iframe>
		</td>
		</tr>
		</TABLE>     
            </div>


 <div id="docinfo2" style="display:none">
<%
java.util.List alist=new java.util.ArrayList();
if(request.getParameter("record")!=null){
 alist = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD().getAllDealWithLog(read_processId,read_tableId,read_recordId);
} 
 %>
               
<TABLE width="100%"  border="0" cellpadding="3" cellspacing="0" >
	<TBODY>  
	   <%
	      if(alist!=null&&alist.size()>0){
		    for(int i=0;i<alist.size();i++){
			 Object dealObj[]=(Object[])alist.get(i);%>

       <TR>
	    <TD width="2%"><span style="color:brown"><B>&nbsp;<%=""+(i+1)+"、"%></B></span></TD>
		<TD width="5%"><span style="color:blue"><B>&nbsp;<%=""+dealObj[0]%></B></span></TD>
		<TD width="15%"><span style="color:purple"><B>&nbsp;<%=""+dealObj[1]%></B></span></TD>
		<TD width="10%"><span style="color:green"><B>&nbsp;<%=""+dealObj[2]%></B></span></TD>
		<TD width="15%"><span style="color:mediumblue"><B>&nbsp;<%=""+dealObj[3]%></B></span></TD>
		<TD width="10%"><span style="color:blue"><B>&nbsp;&nbsp;</B></span></TD>
	  </TR>	
		<%}}%>     
	  <TR>
		<TD colSpan=7><FONT color=#0000ff></FONT></TD>          
	  </TR>	    
	</TBODY>
</TABLE>           
    </div>
<div id="docinfo3" style="display:none">
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
   if(request.getParameter("record")!=null&&!request.getParameter("record").equals(""))
    updatelist=sendFileBD.getAllSendDocumentUpdatePO(request.getParameter("record"));

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
      border=1 align="center" cellPadding=5 cellSpacing=0 borderColor=#b2d0c8>
  
        <TR style="FONT-WEIGHT: bold" align=middle bgColor=#eef8f3>
          <TD width="60%">修改内容</TD>
          <TD width="15%">修改人</TD>
          <TD width="25%">修改时间</TD></TR>
 
        <TR cellpadding="0">
          <TD colSpan=3><B>标题</B></TD></TR>

		  <%if(titleArr!=null&&titleArr.length>0){%>
		     
		  <TD width="50%"><%=titleArr[0]%></TD>
          <TD width="20%"><%=titleArr[1]%></TD>
          <TD width="30%"><%=titleArr[2]%></TD></TR>
		  
		  <%}%>

         <%if(titlelist!=null&&titlelist.size()>0){
		   for(int i=0;i<titlelist.size();i++){
			 Object []titleObj=(Object[])titlelist.get(i); %>  


		  <TR>
          <TD width="50%"><%=titleObj[0]%></TD>
          <TD width="20%"><%=titleObj[1]%></TD>
          <TD width="30%"><%=titleObj[2]%></TD></TR>
			   
		  <% }
		 
		 
		 }%> 
        

        <TR cellpadding="0">
          <TD colSpan=3><B>主送</B></TD></TR>
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
			   
		  <TR>
          <TD width="60%"><%=(mainObj[0]==null||"0".equals(mainObj[0]))?"&nbsp;":mainObj[0]%></TD>
          <TD width="15%"><%=mainObj[1]%></TD>
          <TD width="25%"><%=mainObj[2]%></TD></TR>
			  
			 <% }
			  }
			}
		   %>

        <TR cellpadding="0">
          <TD colSpan=3><B>抄送</B></TD></TR>
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
             
			  <TR>
          <TD width="60%"><%=(copyObj[0]==null||"0".equals(copyObj[0]))?"&nbsp;":copyObj[0] %></TD>
          <TD width="15%"><%=copyObj[1]%></TD>
          <TD width="25%"><%=copyObj[2]%></TD></TR>  
			  
			 <%}
		     }
		   }
		  %>		  
		    <TR cellpadding="0">
          <TD colSpan=3><B>内部发送</B></TD></TR>
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
  		<!-- 相关流程 -->
		<div id="docinfo6" style="display:none">
			<iframe allowTransparency="true" id="relationIfr" name="relationIfr" frameborder="0"  style="width:100%"></iframe>	
		</div><!--相关附件-->
		<div id="docinfo7" style="display:none">
			<iframe allowTransparency="true" id="realtionaccessoryIframe" name="realtionaccessoryIframe" frameborder="0"  style="width:100%"></iframe>
		</div><!--相关收文-->
		<div id="docinfo8" style="display:none">
			<iframe allowTransparency="true" id="showAssociateIframe" name="showAssociateIframe" frameborder="0"  style="width:100%"></iframe>
		</div>
	</td></tr>
</table>

<br>
</div>
</td>
</tr>
</table>
</html:form>
</body>
<form name="gdform" method="POST" action="<%=rootPath%>/govezoffice/gov_documentmanager/sendfile_gd.jsp?gd=1">
    <input type="hidden" name="pageContent">
    <input type="hidden" name="fileTitle">
    <input type="hidden" name="fileId">
	<input type="hidden" name="createdEmp" value="<%=request.getParameter("submitPersonId")%>">
	<input type="hidden" name="wh">
	<input type="hidden" name="dateTime">
	<input type="hidden" name="org" >
	<input type="hidden" name="fileName1" value="<%=contentAccName%>">
	<input type="hidden" name="saveName1" value="<%=contentAccSaveName%>">
	<input type="hidden" name="fileName2" value="<%=accessoryName2%>">
	<input type="hidden" name="saveName2" value="<%=accessorySaveName2%>">
	<input type="hidden" name="zwurl">
</form>
<script language="javascript">
function gd(){    
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
    
    gdform.fileTitle.value = GovSendFileActionForm.documentSendFileTitle.value;
    gdform.fileId.value = GovSendFileActionForm.editId.value;
	gdform.wh.value=document.all.documentSendFileByteNumber?document.all.documentSendFileByteNumber.value:'';
	gdform.org.value=document.all.documentSendFileWriteOrg?document.all.documentSendFileWriteOrg.value:'';
	var signsendTime =document.all.signsendTime?document.all.signsendTime.value:'';
	if(signsendTime && signsendTime !='')gdform.dateTime.value=signsendTime.substring(0,4);
    var url="<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID=<%=request.getAttribute("content")%>&EditType=0&UserName="+document.all.UserName.value+"&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=0&showEditButton=0&FileType="+document.all.documentWordType.value;
	if(document.all.sendFileCheckTitle){
		url+="&copyType=1";
	}
	
	gdform.zwurl.value=url;//查看正文的url

	gdform.pageContent.value = document.body.innerHTML;

	gdform.pageContent.value += "<"+"script>var newNode = document.createElement('a');newNode.href='#';newNode.onclick=function(){window.open('"+url+"','','TOP=0,LEFT=0, resizable=yes,width=800,height=600')};newNode.innerHTML ='&nbsp;&nbsp;&nbsp;&nbsp;查看正文';document.getElementById('docinfo0').insertBefore(newNode,document.getElementById('docinfo0').firstChild);<"+"/script>";

    gdform.submit();
}
<%if(request.getParameter("gd") != null){%>
gd();
<%}%>

function  setInitTitle(){
document.all.oldTitle.value=document.all.documentSendFileTitle.value;
document.all.oldToPerson1.value=document.all.toPerson1.value;
document.all.oldToPerson2.value=document.all.toPerson2.value;
document.all.oldToInnner.value=document.all.toPersonInner.value;
}
setInitTitle();

function include_close(){
 window.close();
}

</script>
<table width="90%" border="0" cellspacing="0" cellpadding="0">
       <tr style="display:'none'">
      <td width="0" height="0">
          <iframe id="ifrm" name="ifrm" src="" style="display='none'"></iframe><iframe id="ifrm1" name="ifrm1" src="" style="display='none'"></iframe>
      </td>
  </tr>
  	<tr style="display:'none'">
   <td>
   <input type="hidden" name="judgeChannelName" value="-1">
   <iframe name="judgeNameFrame" src=""></iframe>
   </td>
</tr>
     </table>
</html:html>
