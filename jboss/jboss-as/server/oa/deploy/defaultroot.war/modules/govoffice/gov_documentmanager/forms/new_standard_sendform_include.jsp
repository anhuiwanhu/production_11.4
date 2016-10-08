<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/tag-lib/gov.tld" prefix="gov" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String noWriteField = "";
  //System.out.println("eeeeeeeeeeeeeeeee:"+	request.getAttribute("sendFileTitle") );
  //System.out.println("vvvvvvvvvvvvvvvvv:"+	com.opensymphony.xwork2.ActionContext.getContext().getValueStack().findString("sendFileTitle") );
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


//参考附件
String  referenceAccessory=request.getAttribute("referenceAccessory")==null?"":request.getAttribute("referenceAccessory").toString();
String  referenceAccessorySaveName=request.getAttribute("referenceAccessorySaveName")==null?"":request.getAttribute("referenceAccessorySaveName").toString();


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
	
//if(stack.getContext().get("signsendTime") == null){
		//stack.getContext().put("signsendTime", new java.util.Date());
//}
//if(stack.getContext().get("documentSendFileSendTime") == null){
	//	stack.getContext().put("documentSendFileSendTime", new java.util.Date());
//} 
  
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
<!--  标记那些标签修改过了  -->
<input type="hidden" name="oldTitle" value="<s:property  value="#request.documentSendFileTitle" />">
<input type="hidden" name="oldToPerson1" value="<s:property  value="#request.toPerson1" />">
<input type="hidden" name="oldToPerson2" value="<s:property  value="#request.toPerson2" />">
<input type="hidden" name="oldToInnner" value="<s:property  value="#request.toInnner" />">
<input type="hidden" name="isSyncToInfomation" value="0"/>

<input type="hidden" name="sendFileNeedSendMsg2" value="0">
<input type="hidden" name="sendFileNeedRTX" value="0">
<input type="hidden" name="sendFileCanDownload" value="1">
<input type="hidden" name="useOrgUsers" value="0">


<input type="hidden" name="sendToMyId" >
<input type="hidden" name="sendToMyName">
<input type="hidden" name="sendFileNeedMail" value="0">
<input type="hidden" name="isSendToMyOther" value="0">

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
<s:hidden  name="toPersonBaoId" property="toPersonBaoId"/>
<s:hidden  name="field10" property="field10"/>
<s:hidden  name="field5" property="field5"/>
<s:hidden  name="toPerson1Id" property="toPerson1Id"/>	
<s:hidden  name="toPerson2Id" property="toPerson2Id"/>
<s:hidden  name="toPersonInnerId" property="toPersonInnerId"/>
<s:hidden  name="toPerson3" property="toPerson3" value=""/>
<s:hidden  name="toPerson4" property="toPerson4" value=""/>
<s:hidden  name="toPerson5" property="toPerson5" value=""/>
<s:hidden  name="toPerson6" property ="toPerson6" value=""/>
<s:hidden  name="documentSendFileAssumePeople" property="documentSendFileAssumePeople"/>
<s:hidden  name="sendFilePrinter" property="sendFilePrinter"/>
<s:hidden  name="sendFileProof" property="sendFileProof"/>
<input type="hidden" name="addDivContent" value="">
<input type="hidden" name="done"/>
<!--
<table width="100%" border="0" cellpadding="1" cellspacing="0" class="docBox" style="background-color:#ffffff;border:0px;">
  <tr>
    <td height="312" valign="top"  align="center">
	
	  <div  align="center" >
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr>
                      <td align="right" valign="middle" align="center"><div align="center">
                          <table width="80%" border="0" align="center" cellpadding="1" cellspacing="1">
                            
                     
							
							 
	                          <tr>
							  <td width="100%">--><table width="100%" border="0" cellpadding="0" cellspacing="0">					      
							     <tr>
							       <td colspan="6" align="center" style="border-bottom:#FF0000 solid 4px; font-weight:bold;font-size:30px;color:#FF0000"><s:property  value="#request.p_wf_processName" /></td>
						          </tr>
							     <tr>
							       <td width="10%" height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">签&nbsp;&nbsp;&nbsp; 发：</font></span></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
						           <td colspan="-1" align="left" class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;审核意见：</font></td>
						           <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
					              </tr>
							     <tr>
							       <td height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">会&nbsp;&nbsp;&nbsp; 签：</font></span></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
							       <td colspan="-1" align="left" class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;核&nbsp;&nbsp;&nbsp;稿：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
						         </tr>
							     <tr>
							       <td height="70" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><span class="STYLE1"><font color="#FF0000">审阅意见：</font></span></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
							       <td colspan="-1" align="left" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;border-left:#FF0000 solid 1px;"><font color="#FF0000">&nbsp;承办单位意见：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">&nbsp;</td>
						         </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000" class="STYLE1">附&nbsp;&nbsp;&nbsp; 件：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
                                    
                                      





<table width="100%" border="0" cellpadding="0" cellspacing="1" id="govdocumenttable">
    <tr id="modiUploadtr" >
        <td height="25">

  <input type="hidden" name="accessoryName"  id="accessoryName"  value="<%=accessoryName%>">
  <input type="hidden" name="accessorySaveName"  id="accessorySaveName" value="<%=accessorySaveName%>">
<jsp:include page="/public/upload/uploadify/upload_include.jsp" > 
   <jsp:param name="accessType"		 value="include" />
   <jsp:param name="makeYMdir"		 value="yes" />
   <jsp:param name="onInit"		     value="init" />
   <jsp:param name="onSelect"		 value="onSelect" />
   <jsp:param name="onUploadProgress"		 value="onUploadProgress" />
   <jsp:param name="onUploadSuccess"		 value="onUploadSuccess" />
   <jsp:param name="dir"		 value="govdocumentmanager" />
   <jsp:param name="uniqueId"    value="govdocumentmanager" />
   <jsp:param name="realFileNameInputId"    value="accessoryName" />
   <jsp:param name="saveFileNameInputId"    value="accessorySaveName" />
   <jsp:param name="canModify"       value="yes" />
   <jsp:param name="width"		 value="90" />
   <jsp:param name="height"		 value="20" />
   <jsp:param name="multi"		 value="true" />
   <jsp:param name="buttonClass" value="upload_btn" />
   <jsp:param name="buttonText"		 value="上传文件" />
   <jsp:param name="fileSizeLimit"		 value="0" />
   <jsp:param name="uploadLimit"		 value="0" />
</jsp:include>

        </td>
    </tr>
    <tr id="govdocumenttable_tr">
        <td id="govdocumenttable_td">
        
        </td>
    </tr>
</table>
<input type="hidden" name="saveFileNameTemp_0_1" value="">
<table style="display:none">
   <tr>
       <td>
           <iframe id="delFile" name="delFile" src=""></iframe>
           <input type="hidden" name="deletedFileNames" id="deletedFileNames" value="">
		   <input type="hidden" name="allAttachSize" value="0">
        </td>
   </tr>
</table>

                                                                    </td>
						          </tr>
							     <tr>
							       <td width="10%" height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文&nbsp;&nbsp;&nbsp; 头：</font></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
										 

										<gov:field name="sendFileDepartWord" id="sendFileDepartWord" list="wordlist" field="sendFileDepartWord"/>
                                    </td>
						           <td width="10%" colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">字&nbsp;&nbsp;&nbsp; 号：</font></td>
						           <td width="10%" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
								   		<gov:field name="documentSendFileByteNumber" id="documentSendFileByteNumber"  styleClass="sw"  field="documentSendFileByteNumber"  style ="width:240px;"/>
								  </td>
						           <td width="10%" align="right" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">办理缓急：</font></td>
						           <td width="20%" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left"> 
                                     	<gov:field name="sendFileGrade" id="sendFileGrade" list="transactLevel"  field="sendFileGrade" /> 
									
                                  </td>
							     </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件标题：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
								     <gov:field name="documentSendFileTitle" id="documentSendFileTitle"  styleClass="sw"  field="documentSendFileTitle" /> 
								  </td>
								   <td colspan="1" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">文件种类：</font></td>
								   <td colspan="1" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
										<gov:field name="documentFileType" id="documentFileType"  list="fileTypeArr"  field="documentFileType"/> 
                                  	</td>
						          </tr>
							     <!--tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">主&nbsp;题&nbsp;词：</font></td>
							       <td colspan="3" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
										<gov:field name="documentSendFileTopicWord" id="documentSendFileTopicWord" styleClass="sw" style="width:85%" field="documentSendFileTopicWord" /> 
                                  
						          </tr-->
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">主&nbsp;&nbsp;&nbsp; 送：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
                                     <gov:field name="toPerson1" id="toPerson1"   field="toPerson1" list="issueUnitList"  style="width:85%" /> 
                                     <!--<button class="btnButton2Font" onClick="openEndowSend('toPerson1');">选择</button>-->
                                   </td>
								 </tr>
							
                                   
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">抄&nbsp;&nbsp;&nbsp; 送：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
                                     <gov:field name="toPerson2" id="toPerson2" field="toPerson2" list="issueUnitList"  style="width:85%" /> 
                                      <!--<button class="btnButton2Font" onClick="openEndowSend('toPerson2');">选择</button>-->
                                   </td>
								 </tr>
								
                                   
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">拟稿单位：</font></td>
							       <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
								   <%
								 
								   String WriteOrg =(String)session.getAttribute("orgName");
								    String WriteUser =(String)session.getAttribute("userName");
								   %>
								     <gov:field name="documentSendFileWriteOrg" id="documentSendFileWriteOrg" style="width:85%" styleClass="sw"  field="documentSendFileWriteOrg" value="<%=WriteOrg%>" /> 
                                    
                                   </td>
						           <td colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">会签单位：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
									 <gov:field name="documentSendFileCounterSign" id="documentSendFileCounterSign"  styleClass="sw"  field="documentSendFileCounterSign" /> 
                                   </td>
						           <td align="right" nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">拟稿人：</font></td>
						           <td nowrap class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
									 <gov:field name="sendFileDraft" id="sendFileDraft"  value="<%=WriteUser%>" styleClass="sw" field="sendFileDraft"/> 
									 <Script>$(document).ready(function(){document.getElementsByName("sendFileDraft")[0].readOnly =true;document.getElementsByName("documentSendFileWriteOrg")[0].readOnly ="true";});</script>
                                   </td>
							     </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">公开属性：</font></td>
							       <td colspan="5" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
									 <gov:field name="openProperty" id="openProperty" list="openPropertyArr"  field="openProperty"/> 
                                   </td>
					              </tr>
							     <tr>
							       <td height="40" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">签发日期：</font></td>
							       <td width="80" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"  align="left">
											<gov:field name="signsendTime" id="signsendTime"    field="signsendTime"  styleClass="sw"/> 
									</td>
						           <td colspan="-1" align="center" class="STYLE1" style="border-bottom:#FF0000 solid 1px;"><font color="#FF0000">共&nbsp;&nbsp;&nbsp; 印：</font></td>
						           <td class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                   <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                      <tr>
                                        <td>
                                           <gov:field name="documentSendFilePrintNumber" id="documentSendFilePrintNumber"   styleClass="inputTextsw"  field="documentSendFilePrintNumber"/> 
                                         </td>
                                        <td align="left"><font color="#FF0000">份</font></td>
                                      </tr>
                                    </table>                                   </td>
						           <td colspan="2" align="right" class="STYLE1" style="border-bottom:#FF0000 solid 1px;">
                                     <gov:field name="documentSendFileSendTime" id="documentSendFileSendTime"   styleClass="sw" field="documentSendFileSendTime"/> 
        							<font color="#FF0000">印发</font>
								  </td>
					              </tr>
							    </table>
					

<script>
$(document).ready(function(){
	alert("请勿处理涉密件");
});
</script>