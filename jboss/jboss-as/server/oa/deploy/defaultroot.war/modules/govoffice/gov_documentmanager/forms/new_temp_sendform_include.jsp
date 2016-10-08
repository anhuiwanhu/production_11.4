<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String noWriteField = "";
  
String curUserID = session.getAttribute("userId").toString();
//附件
String  accessoryName=request.getAttribute("accessoryName")==null?"":request.getAttribute("accessoryName").toString();
String  accessorySaveName=request.getAttribute("accessorySaveName")==null?"":request.getAttribute("accessorySaveName").toString();


//参考附件
String  referenceAccessory=request.getAttribute("referenceAccessory")==null?"":request.getAttribute("referenceAccessory").toString();
String  referenceAccessorySaveName=request.getAttribute("referenceAccessorySaveName")==null?"":request.getAttribute("referenceAccessorySaveName").toString();
com.whir.ezoffice.ezform.util.ModuleParser parser = new com.whir.ezoffice.ezform.util.ModuleParser();
String formId="";
String  read_recordId= "";
if(request.getAttribute("p_wf_recordId") != null){
	read_recordId =(String)request.getAttribute("p_wf_recordId").toString();
}
 String read_tableId=request.getAttribute("p_wf_tableId").toString();

 String nowYearInt= (new java.util.Date().getYear()+1900)+"";

 String[] realFileArray = new String[0];
 String[] saveFileArray = new String[0];

if(accessoryName.equals("")||accessoryName.equals("null")){
  accessoryName=request.getParameter("accessoryName")==null?"":request.getParameter("accessoryName").toString();
}
if(accessorySaveName.equals("")||accessorySaveName.equals("null")){
  accessorySaveName=request.getParameter("accessorySaveName")==null?"":request.getParameter("accessorySaveName").toString();
}
String  contentAccName=request.getAttribute("contentAccName")==null?"":request.getAttribute("contentAccName").toString();
String contentAccSaveName=request.getAttribute("contentAccSaveName")==null?"":request.getAttribute("contentAccSaveName").toString();
com.opensymphony.xwork2.util.ValueStack  stack = com.opensymphony.xwork2.ActionContext.getContext().getValueStack();
  
  %>


<input type="hidden" name="noNeedFlush" value="1" /> <!--不刷新页面-->
<input type="hidden" name="content" <%if(request.getAttribute("content") != null) out.print("value=\"" + request.getAttribute("content") + "\"");%>>
<%if(request.getParameter("p_wf_recordId") != null){%>
    <input type="hidden" name="sendFileId" value="<%=request.getParameter("p_wf_recordId")%>">
<%}%>
<%
//收文转发文保存相关收文的标识字段 taodp @ 2011-10-15
if(request.getParameter("fromReceiveFileLink") != null&&!"".equals(request.getParameter("fromReceiveFileLink"))){%>
<input type="hidden" name="fromReceiveFileId" value="<%=request.getParameter("fromReceiveFileId")%>">
<input type="hidden" name="fromReceiveFileLink" value="<%=request.getParameter("fromReceiveFileLink")%>">
<%}%>
<%
//文件送审签转发文保存标识字段 taodp @ 2011-10-15
if(request.getParameter("fromFileSendCheckLink") != null&&!"".equals(request.getParameter("fromFileSendCheckLink"))){%>
<input type="hidden" name="fromFileSendCheckId" value="<%=request.getParameter("editId")%>">
<input type="hidden" name="fromFileSendCheckLink" value="<%=request.getParameter("fromFileSendCheckLink")%>">
<%}%>
<!--wanggl_start--> 
 <input type="hidden" name="sendSeqId">
<input type="hidden" name="sendSeqfig"> 
<s:hidden name="sendFilePoNumId" property="sendFilePoNumId"/>
<s:hidden name="templateId" property="templateId"/>
<!--<input type="hidden" name="accessoryName" value="<%=accessoryName%>">
<input type="hidden" name="accessorySaveName" value="<%=accessorySaveName%>">-->
<input type="hidden" name="contentAccName" value="<%=contentAccName%>">
<input type="hidden" name="contentAccSaveName" value="<%=contentAccSaveName%>">
<input type="hidden" name="sendToType" value="0">
<input type="hidden" name="isSyncToInfomation" value="0"/>
<!--  标记那些标签修改过了  -->
<input type="hidden" name="oldTitle" >
<input type="hidden" name="oldToPerson1">
<input type="hidden" name="oldToPerson2">
<input type="hidden" name="oldToInnner">
<s:hidden  name="zjkyWordId" property="zjkyWordId" />
<!--  文件类型 是 word 还是wps-->
<s:hidden name="documentWordType"  property="documentWordType" value=".doc"/>
<input type="hidden" name="tableNameOrId" value="<%=read_tableId%>">

<s:hidden name="sendFileText" property="sendFileText"/>
<s:hidden  name="sendFileType" property="sendFileType"/>
<s:hidden  name="sendFileRedHeadId" property="sendFileRedHeadId"/>
<s:hidden  name="documentSendFileHead" property="documentSendFileHead" value="-1" />
<input type="hidden" name="field3" value="<%=nowYearInt%>">

<s:hidden  name="field1" property="field1"/>
<s:hidden  name="field2" property="field2"/>
<s:hidden  name="field6" property="field6"/>
<s:hidden  name="field5" property="field5"/>

<!--
<s:hidden  name="toPersonBaoId" property="toPersonBaoId"/>

<s:hidden  name="toPerson1Id" property="toPerson1Id"/>	
<s:hidden  name="toPerson2Id" property="toPerson2Id"/>
<s:hidden  name="toPersonInnerId" property="toPersonInnerId"/>-->
<s:hidden  name="toPerson3" property="toPerson3" value=""/>
<s:hidden  name="toPerson4" property="toPerson4" value=""/>
<s:hidden  name="toPerson5" property="toPerson5" value=""/>
<s:hidden  name="toPerson6" property ="toPerson6" value=""/>

<input type="hidden" name="sendFileNeedSendMsg2" value="0">
<input type="hidden" name="sendFileNeedRTX" value="0">
<input type="hidden" name="sendFileCanDownload" value="1">
<input type="hidden" name="useOrgUsers" value="0">
<input type="hidden" name="sendFileNeedMail" value="0">
<input type="hidden" name="isSendToMyOther" value="0">

<input type="hidden" name="sendToMyId" >
<input type="hidden" name="sendToMyName">
<input type="hidden" name="addDivContent" value="">
							  
<govContent></govContent>
						