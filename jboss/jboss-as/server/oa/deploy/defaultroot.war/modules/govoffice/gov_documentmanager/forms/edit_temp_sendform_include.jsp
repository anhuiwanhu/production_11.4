<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
  <%
  String noWriteField = "";
 // System.out.println("eeeeeeeeeeeeeeeee:"+	request.getAttribute("sendFileTitle") );
 // System.out.println("vvvvvvvvvvvvvvvvv:"+	com.opensymphony.xwork2.ActionContext.getContext().getValueStack().findString("sendFileTitle") );
  //org.apache.struts2.ServletActionContext.getContext().getValueStack().setValue("noWriteField", "11");
 // com.opensymphony.xwork2.ActionContext.getContext().getValueStack().getContext().put("noWriteField", "11");
   // com.opensymphony.xwork2.ActionContext.getContext().getValueStack().setValue("noWriteField", "11");
	//org.apache.struts2.ServletActionContext.getValueStack(request).setValue("noWriteField", "11");
//  request.setAttribute("noWriteField","11");
  
String curUserID = session.getAttribute("userId").toString();
//List  list = new NewEmployeeBD().selectSingle(new Long(curUserID));
//Object[] object = (Object[]) list.get(0);
//EmployeeVO vo = (EmployeeVO)object[0];
//String telephone = vo.getEmpBusinessPhone()==null?"":vo.getEmpBusinessPhone();

//附件
String  accessoryName=request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
String  accessorySaveName=request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();

com.whir.ezoffice.ezform.util.ModuleParser parser = new com.whir.ezoffice.ezform.util.ModuleParser();

//参考附件
String  referenceAccessory=request.getAttribute("referenceAccessory")==null?"":request.getAttribute("referenceAccessory").toString();
String  referenceAccessorySaveName=request.getAttribute("referenceAccessorySaveName")==null?"":request.getAttribute("referenceAccessorySaveName").toString();



 String read_tableId=(String)request.getAttribute("p_wf_tableId").toString();

String  read_processId=(String)request.getAttribute("p_wf_processId");
String  read_recordId=(String)request.getAttribute("p_wf_recordId");

String formId=read_recordId;
 String nowYearInt= (new java.util.Date().getYear()+1900)+"";

 String[] realFileArray = new String[0];
 String[] saveFileArray = new String[0];
java.util.Date sendFileDate = new java.util.Date() ;
java.util.Date sendFileSendDate = new java.util.Date();
java.util.Date documentCreateTime=new java.util.Date();
//java.util.Date signsendTime=new java.util.Date();

if(request.getAttribute("sendFileDate")!=null)
    sendFileDate =  (java.util.Date)request.getAttribute("sendFileDate") ;
if(request.getAttribute("sendFileSendDate")!=null)
    sendFileSendDate =  (java.util.Date)request.getAttribute("sendFileSendDate") ;

if(request.getAttribute("documentCreateTime")!=null&&!request.getAttribute("documentCreateTime").toString().equals("")){
  documentCreateTime=(java.util.Date)request.getAttribute("documentCreateTime");
}
if(request.getAttribute("signsendTime")!=null&&!request.getAttribute("signsendTime").toString().equals("")){
 // signsendTime=(java.util.Date) request.getAttribute("signsendTime");
}
 int createTimeYear= documentCreateTime.getYear()+1900;
int createTimeMonth= documentCreateTime.getMonth()+1;
int createTimeDate= documentCreateTime.getDate();
int createTimeHour = documentCreateTime.getHours();
String createTimeHourStr=""+createTimeHour;
if(createTimeHour<10){
   createTimeHourStr = "0"+createTimeHourStr;
}
int createTimeMinute = documentCreateTime.getMinutes();
String createTimeMinuteStr = ""+createTimeMinute;
if(createTimeMinute<10){
createTimeMinuteStr = "0"+createTimeMinuteStr;
}
int createTimeSencond = documentCreateTime.getSeconds();
String createTimeSencondStr = ""+createTimeSencond;
if(createTimeSencond<10){
   createTimeSencondStr ="0" + createTimeSencondStr;
}
String createTimeStr=""+createTimeYear+"-"+createTimeMonth+"-"+createTimeDate+" "+createTimeHourStr+":"+createTimeMinuteStr+":"+createTimeSencondStr;

if(accessoryName.equals("")||accessoryName.equals("null")){

  accessoryName=request.getParameter("accessoryName")==null?"":request.getParameter("accessoryName").toString();
}
if(accessorySaveName.equals("")||accessorySaveName.equals("null")){

  accessorySaveName=request.getParameter("accessorySaveName")==null?"":request.getParameter("accessorySaveName").toString();
}
String  contentAccName=request.getAttribute("contentAccName")==null?"":request.getAttribute("contentAccName").toString();
String contentAccSaveName=request.getAttribute("contentAccSaveName")==null?"":request.getAttribute("contentAccSaveName").toString();
//ValueStack stack = ActionContext.getContext().getValueStack();
com.opensymphony.xwork2.util.ValueStack  stack = com.opensymphony.xwork2.ActionContext.getContext().getValueStack();
	
if(stack.getContext().get("signsendTime") == null){
		stack.getContext().put("signsendTime", "");
}
if(stack.getContext().get("documentSendFileSendTime") == null){
		stack.getContext().put("documentSendFileSendTime","");
} 
%>

<input type="hidden" name="htmlContent">
<input type="hidden" name="content" value="<%=request.getAttribute("content")%>">
<s:hidden property="sendFileLink"/>

<input type="hidden" name="oldTitle" >
<input type="hidden" name="oldToPerson1">
<input type="hidden" name="oldToPerson2">
<input type="hidden" name="oldToInnner">

<input type="hidden" name="sendSeqId">
<input type="hidden" name="sendSeqfig" >
<input type="hidden" name="done">
<input type="hidden" name="editId" value="<%=read_recordId%>">
<s:hidden  property="sendFilePoNumId"    name="sendFilePoNumId"/>
<input type="hidden"  property="templateId"  name="templateId" value="<%=(String)request.getAttribute("sendFileTemId")%>"/>
<s:hidden  property="zjkyWordId"   name="zjkyWordId"/>


<input type="hidden" name="tableNameOrId" value="<%=read_tableId%>">
<input type="hidden" name="read_processId" value="<%=read_processId%>">
<s:hidden property="documentWordType"/>
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
<input type="hidden" name="sendFileCanDownload" value="1">

<input type="hidden" name="useOrgUsers" value="0">
<input type="hidden" name="sendFileNeedMail" value="0">
<input type="hidden" name="isSendToMyOther" value="0">
<input type="hidden" name="isSyncToInfomation" value="<%=request.getAttribute("isSyncToInfomation")==null?"0":request.getAttribute("isSyncToInfomation").toString()%>"/>
<s:hidden property="sendFileText"  name="sendFileText"/>
<s:hidden property="sendFileType"  name="sendFileType"/>
<s:hidden property="sendFileRedHeadId"  name="sendFileRedHeadId"/>
<s:hidden property="documentSendFileHead"   name="documentSendFileHead" value="-1" />
<s:hidden  property="field1"  name="field1"/>
<input type="hidden" name="field2" value="<%=!"1".equals(request.getParameter("newResubmit"))?(request.getAttribute("field2")==null?"":request.getAttribute("field2")):""%>"/>
<s:hidden   property="field6" name="field6" />

<s:hidden property="field5"  name="field5"/>
 <s:hidden name="done" />
<input type="hidden" name="field3" value="<%=request.getAttribute("field3")==null?nowYearInt:request.getAttribute("field3").toString()%>">
<input type="hidden" name="handOutTime" value="<%=request.getAttribute("handOutTime")==null?"":request.getAttribute("handOutTime").toString()%>">
<input type="hidden" id="sendToMyRange" name="sendToMyRange" value="<%=request.getAttribute("sendToMyRange")==null?"":request.getAttribute("sendToMyRange").toString()%>">
<input type="hidden" name="createdEmp" value="<%=request.getAttribute("createdEmp")==null?"":request.getAttribute("createdEmp").toString()%>">
<input type="hidden" name="createdOrg" value="<%=request.getAttribute("createdOrg")==null?"":request.getAttribute("createdOrg").toString()%>">
<govContent></govContent>

<script>
/**
**/
function  judgeSpword(){

       if(document.all.documentSendFileTitle.value.indexOf("'") >= 0||document.all.documentSendFileTitle.value.indexOf("\"") >= 0||document.all.documentSendFileTitle.value.indexOf("/") >= 0||document.all.documentSendFileTitle.value.indexOf("\\") >= 0||document.all.documentSendFileTitle.value.indexOf("\|") >= 0||document.all.documentSendFileTitle.value.indexOf("<") >= 0||document.all.documentSendFileTitle.value.indexOf(">") >= 0){
	     	alert("标题中不能包含\ /,\\,:,\",?,*, <,>,\|,'");
			return  false;
		}
	 return true;
}


/**
保存草稿
*/
function draftSave(){

	if(!initPara()) return;
	$('#dataForm').submit();
	//ok(0,$('#dataForm'));
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
	  document.all.GovSendFileActionForm.action="GovSendFileAction.do?action=mailtransmit&toId="+toId+"&toName="+toName+"&editId="+editId+"&isEdit=1";
	  document.all.GovSendFileActionForm.submit();
}

//分发范围
function sendToMyRange_show(){
	//alert(1);
	window.open("","target","TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300");
	$("form[name='sendToMyForm']")[0].target="target";
	$("form[name='sendToMyForm'] input[name='sendFileId']")[0].value = $("input[name='editId']")[0].value;//.submit();
	$("form[name='sendToMyForm']")[0].submit();
	//document.sendToMyForm.target="target";
	//document.sendToMyForm.sendFileId.value = document.all.editId.value;
	//document.sendToMyForm.submit();
}


// 发文分发
function sendToMy(){
//< %=sendStatus% >

	var  toId=$("input[name='sendToMyId']")[0].value;
	//alert(1);
	var  toName=$("input[name='sendToMyName']")[0].value; //document.all.sendToMyName.value;
	//alert(2);
	var  editId=$("input[name='editId']")[0].value;//document.all.editId.value;

	if(toName==""){
	    alert("请选择接收者");
	    return;
	}
	//$("form[name='GovSendFileActionForm']")[0].action=encodeURI("GovSendFileAction.do?action=sendToMy&editId="+editId+"&isEdit=1&documentSendFileTitle="+document.all.documentSendFileTitle.value+"&sendFileNeedMail="+document.all.sendFileNeedMail.value+"&sendFileNeedRTX="+document.all.sendFileNeedRTX.value+"&sendFileNeedSendMsg2="+document.all.sendFileNeedSendMsg2.value+"&isinmodijsp=1&isInModify=isInModify&sendStatus=&isSendToMyOther="+document.all.isSendToMyOther.value);
	
	$("form[name='GovSendFileActionForm']")[0].target="ifrm1";
	$("form[name='GovSendFileActionForm']")[0].submit();
	$("form[name='GovSendFileActionForm']")[0].target="";
	//document.all.GovSendFileActionForm.target="ifrm1";//发送不关闭
	//document.all.GovSendFileActionForm.submit();
	//document.all.GovSendFileActionForm.target="";
}



//下载文件
/*
function cmdDowntext(){
		
	
}
*/

//补发直接发送
function supplySend(){
    if(!initPara()) return;

	if($("input[name='sendToId2']")[0].value==""){
		window.alert("请选择要发送的人！");
		return;
	}

	$("form[name='GovSendFileActionForm']")[0].action="target";
	$("form[name='GovSendFileActionForm']")[0].submit();
    //GovSendFileActionForm.action = "< %=rootPath% >/GovSendFileAction.do?action=supplySend";
    //GovSendFileActionForm.submit();
}

</script>