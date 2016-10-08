<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %><%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %><%@ taglib uri="/WEB-INF/tag-lib/struts-logic.tld" prefix="logic" %><%@ taglib uri="/WEB-INF/tag-lib/struts-bean.tld" prefix="bean" %><%@ taglib uri="/WEB-INF/tag-lib/struts-html.tld" prefix="html" %><%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/tag-lib/c.tld" prefix="c" %>
<%@ include file="/public/include/init_base.jsp"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String comm_upload = Resource.getValue(local,"common","comm.upload");
whir_custom_str="My97DatePicker  easyui";
String subType=request.getParameter("subType")==null?"0":request.getParameter("subType")+"";
if(subType.equals("null")||subType.equals("0")){
	subType="0";
}

String  displaynone=" style=\"display:none\"";
 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="workflow.setup"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<script src="<%=rootPath%>/platform/bpm/i18n/js_workflowMessage.jsp" type="text/javascript"></script>
	<script src="<%=rootPath%>/platform/bpm/ezflow/process/ezflow_process_sub_set.js" type="text/javascript"></script> 
	<%@ include file="/public/include/include_extjs.jsp"%>
	<style type="text/css">
	<!--
	#noteDiv {
		position:absolute; 
		height:200px; 
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
		background-color:#ffffff;
	} 
	-->
   </style>
</head>
<body class="Pupwin" onload="initData();setStyle();">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	      <s:form name="dataForm" id="dataForm" action="ezflowprocess!save.action" method="post" theme="simple" >
            <%@ include file="/public/include/form_detail.jsp"%>
			<input type="hidden" name="subType" value="<%=subType%>">
	        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
				<tr>
					<td colspan="2">
						<div class="Public_tag">
							<ul>
								<li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newworkflow"/></span><span class="tag_right"></span>
								</li>
								<li id="Panle1" onClick="changePanle(1);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newworkflowinterface"/></span><span class="tag_right"></span>
								</li>     
							</ul>
						</div>
					</td>
				</tr>
			</table>
			<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="TableLine">
				<tr>
					<td valign="top">
						<div id="docinfo0" style="display:;">
				            <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0">
								  <tr>
									<td width="120"  valign="top"  class="td_lefttitle"> <s:text name="workflow.setupcategory"/>&nbsp;<span class="MustFillColor">*</span>： </td>
									<td  class="table_linebottom"> 
                                         <input type="hidden" name="processPackage" id="processPackage" />
									     <input type="hidden" name="processPackageName" id="processPackageName" />
									     <div id="checkboxSelect" class="public_overflow"  style=" background-color:#FFFFFF;display: block; height:20px; padding-top:3px; padding-left:2px;  cursor:pointer;width:95%;border: 1px solid #000000;"     onclick="javascript:;"   rel="noteDiv"><a id="processPackageDisName" href="javascript:;"  ></a></div>
                                         <div id="noteDiv"  >
                                            <ul>
									          <c:forEach items="${processPackageList}" var="processPackage">
									           <li><input type="checkbox" name="processPackage_checbox"  displaytext="${processPackage[1]}"  value="${processPackage[0]}"  onchange="setPackageInfo()">${processPackage[1]}</li> 
											   </c:forEach>
									       </ul>
									      </div>
									 </td>
									 <td width="40px">&nbsp;</td>
								  </tr>
								  <tr>
									<td class="td_lefttitle"  for='<s:text name="workflow.set_processId"/>'><s:text name="workflow.set_processId"/>&nbsp;<span class="MustFillColor">*</span>：</td>
									<td>
									    <input type="text" name="id"  id="id"    class="inputText"  style="width:95%;" whir-options="vtype:['notempty',{'maxLength':100},'spechar3']">
									</td>
									<td>&nbsp;</td>
								  </tr>

								  <!--流程名-->
								  <tr>
									  <td  class="td_lefttitle" for='<s:text name="workflow.workflowname"/>'><s:text name="workflow.workflowname"/>&nbsp;<span class="MustFillColor">*</span>：</td>
									  <td>
									     <input type="text" name="name" id="name" class="inputText"  style="width:95%;" whir-options="vtype:['notempty',{'maxLength':100},'spechar3']">
									  </td>
									  <td>&nbsp;</td>
								  </tr>

								  <!--适用范围-->
								  <tr  <%=displaynone%> >
									<td  class="td_lefttitle" style="border-bottom:0px"  for='<s:text name="workflow.setupusers"/>'><s:text name="workflow.setupusers"/><span class="MustFillColor">*</span><!--span class="mustFillcolor_red">*</span-->：</td>
									<td>
									  <textarea name="processUserScopeName" id="processUserScopeName"  style="width:95%;" readonly="true" rows="3" class="inputTextarea"  whir-options="vtype:[{'maxLength':400}]"  ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processUserScope', allowName:'processUserScopeName', select:'usergrouporg', single:'no', show:'usergrouporg', range:'*0*',key:'code'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
									  <input type="hidden" name="recordId" id="recordId" value=""><input type="hidden" name="processUserScope"  id="processUserScope" value="">
								    </td>
									<td></td>
								  </tr> 
								  <!--表单类型-->
								  <tr <%=displaynone%> >
									<td class="td_lefttitle" ><s:text name="workflow.newworkflowformtype"/><span class="MustFillColor">*</span>：</td>
									<td>
									     <INPUT  onClick="showJspInfo();" value="0" CHECKED type="radio" name="formType"><s:text name="workflow.newworkflowdiyform"/><!--自定义表单-->
									     <INPUT onClick="showJspInfo();"  value="1" type="radio" name="formType"><s:text name="workflow.newworkflowjspfile"/>
								    </td>
									<td>&nbsp;</td>
								 </tr>	
								  <tr id="show_box01" <%=displaynone%> >
									  <td  class="td_lefttitle" > <s:text name="workflow.newworkflowformuse"/><span class="MustFillColor">*</span>：</td>
									  <td>
										 <select name="formKey"  id="formKey"    >
									      <c:forEach items="${formList}" var="form">
										    <option value="${form[0]}">${form[1]}</option>
									      </c:forEach>
									   </select>
									  </td>
									  <td>&nbsp;</td>
								 </tr>
								 
								 <tr id="show_box02" style="display:none">
									  <td  class="td_lefttitle"><s:text name="workflow.newworkflowjspfilestart"/><span class="MustFillColor">*</span>：</td>
									  <td>
										 <input type="text" class="inputText" name="formAddUrl"  id="formAddUrl"   style=" width:95%;" value="">
									  </td>
									  <td>&nbsp;</td>
								 </tr>

								 <tr id="show_box03" style="display:none" >
								      <td  class="td_lefttitle" ><s:text name="workflow.newworkflowjspfileflow"/><span class="MustFillColor">*</span>：</td>
									  <td>
									     <input type="text" class="inputText" name="formUpdateUrl"  id="formUpdateUrl"   style=" width:95%;" value="">
									  </td>
									  <td>&nbsp;</td>
								 </tr> 
								 <tr id="tr_field" <%=displaynone%> >
									<td  class="td_lefttitle" ><!--可写字段：--><s:text name="workflow.newactivitywritefield"/>：</td>
									<td  height="150px" valign="middle">
										 <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" class="table_noline"  style="margin-left:-4px">
											<tr >
												<td width="120px" align="left" valign="middle">
													  <select name="field" id="field"  multiple="multiple" size="10" style="width:120px;height:150px">
														   <c:forEach items="${fieldList}" var="field">
															<option value="${field[0]}">${field[1]}</option>
														   </c:forEach>
													  </select>
												</td>
												<td width="80px" align="center" valign="middle"> 
												      <input type="button" class="btnButton4font" id="button" value="> " onclick='transferOptions("field","nodeWriteField");'/>
													  <div style="height:5px">&nbsp;</div>
													  <input name="button" type="button" id="button" value=">>" onclick='transferOptionsAll("field","nodeWriteField");' class="btnButton4font" >
													  <div style="height:5px">&nbsp;</div>
													  <input name="button" type="button" id="button" value="< " onclick='transferOptions("nodeWriteField","field");' class="btnButton4font" >
													  <div style="height:5px">&nbsp;</div>
													  <input name="button" type="button" id="button" value="<<" onclick='transferOptionsAll("nodeWriteField","field");' class="btnButton4font">
												</td>
											    <td width="120px" align="left"  valign="middle" > 
												      <select name="nodeWriteField" id="nodeWriteField" multiple="multiple" size="10" style="width:120px;height:150px">
													  </select>
											    </td>
											    <td >&nbsp;</td>
										  </tr>
									    </table>
									</td>
									<td>&nbsp;</td>
								 </tr>
								 <tr style="display:none">
									<td class="td_lefttitle">对发起人隐藏字段：</td>
									<td><table width="100%" border="0" cellspacing="0" cellpadding="0" class="table_noline">
									  <tr valign="top">
										<td width="10%" align="right"><select name="field2" multiple="multiple" size="10" style="width:100%;">
										  <option value="1003806">事项说明</option>
										  <option value="1003800">附件</option>
										  <option value="1003783">部门</option>
										  <option value="1003801">主题</option>
										  <option value="1003782">制表人</option>
										  <option value="1003784">制表日期</option>
										</select></td>
										<td width="4%" align="center"><input name="button2" type="button" id="button2" value="> " onclick='transferOptions("field2","noWriteField2");'>
										  <br>
										  <br>
										  <input name="button2" type="button" id="button2" value=">>" onclick='transferOptionsAll("field2","noWriteField2");'>
										  <br>
										  <br>
										  <input name="button2" type="button" id="button2" value="< " onclick='transferOptions("noWriteField2","field2");'>
										  <br>
										  <br>
										  <input name="button2" type="button" id="button2" value="<<" onclick='transferOptionsAll("noWriteField2","field2");'>
										  <br>
										  <br></td>
										<td width="86%"><select name="noWriteField2" multiple="multiple" size="10">
										</select></td>
									  </tr>
									</table></td>
									<td>&nbsp;</td>
								  </tr>
								  <tr id="tr_remindfield" <%=displaynone%> >
									  <td  class="td_lefttitle"><s:text name="workflow.newworkflowwarning"/>：</td>
									  <td>
									     <div id="processRemindFieldDiv" style="width:95%">
											   <c:forEach items="${processRemindFieldList}" var="processRemindField">
												<input name="processRemindField" type="checkbox" value="${processRemindField[0]}">${processRemindField[1]}
											   </c:forEach>
										 </div>
									  </td>
									  <td>&nbsp;</td>
								  </tr>
								  <tr  id="tr_showremind" <%=displaynone%> >
									  <td  class="td_lefttitle" ><s:text name="workflow.set_remindview" />：</td>
									  <td>
									    <label>
									       <input type="text" name="processRemindFieldPreview" id="processRemindFieldPreview" readonly  class="inputText" style="width:95%;" >
									       <input type="hidden" name="processRemindFieldPreviewValue" id="processRemindFieldPreviewValue"  value="" > 
									     </label>
									   </td>
									   <td>&nbsp;</td>
								 </tr>
								 <!--字段联动-->
								 <tr  id="tr_relationTrig"  <%=displaynone%> >
									  <td class="td_lefttitle" ><s:text name="workflow.set_relationTrig" />：</td>
									  <td><select name="relationTrig" id="relationTrig"><option value="">--</option></select></td>
									  <td>&nbsp;</td>
								 </tr>
								 <!--办理查阅查看人：-->
								 <tr <%=displaynone%>>
									  <td  class="td_lefttitle" for='<s:text name="workflow.newworkflowauthorizeduser"/>'><s:text name="workflow.newworkflowauthorizeduser"/>：</td>
									  <td>
											<input type="hidden" name="processCanReadEmp" id="processCanReadEmp" value="">
											<textarea name="processCanReadEmpName" id="processCanReadEmpName"   rows="5" class="inputTextarea" style="width:95%;" readonly="true" ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processCanReadEmp', allowName:'processCanReadEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',key:'code'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
									  </td>
									  <td>
									    
									  </td>
								  </tr>
								  <!--办理查阅维护人-->
								  <tr  <%=displaynone%> >
									 <td class="td_lefttitle" for='<s:text name="workflow.newworkflowmaintainuser"/>' ><s:text name="workflow.newworkflowmaintainuser"/>：</td>
									 <td>
									    <textarea name="processCanModifyEmpName" id="processCanModifyEmpName" class="inputTextarea" style="width:95%;" readonly="true" rows="5"></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processCanModifyEmp', allowName:'processCanModifyEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',key:'code'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
									    <input type="hidden" name="processCanModifyEmp" id="processCanModifyEmp" value="">
									 </td>
									 <td></td>
								 </tr>
								 <!--流程管理员-->
								 <tr  <%=displaynone%>>
									 <td  class="td_lefttitle"  for='<s:text name="workflow.Workflowadministrator"/>'><s:text name="workflow.Workflowadministrator"/>：</td>
									 <td>
									     <textarea name="processAdministratorName" id="processAdministratorName"   rows="5" class="inputTextarea" style="width:95%;" readonly="true" ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processAdministrator', allowName:'processAdministratorName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',key:'code'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <input type="hidden" name="processAdministrator" id="processAdministrator" value="">
									</td>
									<td> </td>
								</tr>
								<!--设置项-->
								<tr <%=displaynone%> >
									 <td class="td_lefttitle" ><s:text name="workflow.set_set"/>：</td>
									 <td> 
									     <div style="padding-top:4px;padding-bottom:3px;">
									         <input name="processNeedDossier"  id="processNeedDossier" type="checkbox" value="true"><s:text name="workflow.newworkflowarchive"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="processEndMail" type="checkbox" value="true"><s:text name="workflow.set_completeprocesswithemail"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="processKeepBackComment" type="checkbox" value="true"><s:text name="workflow.set_backsavecomment"/>&nbsp; &nbsp;<br>
									         <input name="processCommentIsNull" type="checkbox" value="true"><s:text name="workflow.set_commentisnotnull"/>&nbsp; &nbsp;<input name="processCommentAcc" type="checkbox" value="true"><s:text name="workflow.set_commentcanacc"/>&nbsp; &nbsp;<s:text name="workflow.set_commentsort"/>：<select name="commentSortType"><option value="time_asc"><s:text name="workflow.set_commenttimeasc"/></option><option value="time_desc"><s:text name="workflow.set_commenttimedesc"/></option><option value="dute_asc"><s:text name="workflow.set_commentdutyasc"/></option><option value="dute_desc"><s:text name="workflow.set_commentdutydesc"/></option></select><br>
											 <input name="processNeedPrint" id="processNeedPrint" type="checkbox" value="true" ><!-- onclick="showExportTemp(this)"  流程办结后可以打印 --><s:text name="workflow.Sponsormayprinttheworkflowafterprocess" />&nbsp;&nbsp;<span id="ExportTempSpan" style="display:none"><input name="processPrintExportTemp" type="checkbox" value="true">流程办结后可以导出word模板和下载&nbsp; &nbsp;</span><input name="processAutoNextWithNullUser"  id="processAutoNextWithNullUser" type="checkbox" value="true">活动参与者为空自动跳转下一步
											<!--  <input name="processAutoNextWithRepeat"  id="processAutoNextWithRepeat" type="checkbox" value="true">下一步参与者重复 -->
										 </div> 
									 </td>
									 <td>&nbsp;</td>
								</tr> 
								<tr <%=displaynone%> >
									  <td  class="td_lefttitle" for='<s:text name="workflow.workflowname"/>'><s:text name="workflow.processMobileStatus"/>：</td>
									  <td>
									      <!-- -->
									      <input name="processCanMobilePhone"          id="processCanMobilePhone" type="checkbox" value="1"> <s:text name="workflow.processCanMobilePhoneStatus"/><!-- 同步到手机端 -->
                                          <input name="processCanPAD"  id="processCanPAD" type="checkbox" value="1"> <s:text name="workflow.processCanPADStatus"/><!-- 同步到PAD端 -->
									  </td>
									  <td>&nbsp;</td>
								 </tr>
								<!--流程描述-->
								<tr <%=displaynone%> >
									<td class="td_lefttitle" ><s:text name="workflow.ezFLOWDescription"/>：</td>
									<td style="padding-bottom:0px;">
									     <INPUT type="hidden" name="content1" id="content1">
			                             <IFRAME   id="newedit" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=content1&style=coolblue&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>"  frameborder="0" scrolling="no" width="97%" height="350"></IFRAME>
				                          <textarea name="processDescription" cols="60" rows="6" style="display:none" class="inputTextarea"></textarea>
                                     </td>
									 <td>&nbsp;</td>
								 </tr> 
								 <tr  class="Table_nobttomline">
								   <td class="td_lefttitle" >&nbsp;</td>
								   <td colspan="2">
									<input type="button" class="btnButton4font" onClick="save('trueModify');" value='<s:text name="comm.saveclose"/>' />  
									<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
									<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>'/>  
								   </td>
							   </tr>
							</table>
			            </div>
			            <div id="docinfo1" style="display:none;">
				         <!--接口-->
						 <table width="100%" border="0" class="Table_bottomline" cellpadding="1" cellspacing="0">
						       <!--流转表单处理类-->
							   <tr>
									<td width="120" class="td_lefttitle"  for='<s:text name="workflow.newworkflowformclass"/>' ><s:text name="workflow.newworkflowformclass"/>：</td>
									<td  valign="middle" class="table_linebottom">
										 <input type="text" style="width:95%;"  name="formClassName" id="formClassName" class="inputText" maxlength="25" value="">                        
								    </td>							   
								    <td width="210px"  valign="top">
								      <%-- <div style="margin-left:-1px;">
										 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">      
										   <jsp:param name="onInit"             value="" /> 
										   <jsp:param name="onSelect"             value="" />  
										   <jsp:param name="onUploadProgress"     value="" /> 
										   <jsp:param name="onUploadSuccess"      value="formClassUpload" />
										   <jsp:param name="dir"         value="/WEB-INF/classes/com/whir/ezoffice/formhandler/" />
										   <jsp:param name="uniqueId"    value="workFlow_class" />
										   <jsp:param name="realFileNameInputId"    value="formClassName" /> 
										   <jsp:param name="saveFileNameInputId"    value="formClassName" />
										   <jsp:param name="canModify"       value="yes" /> 		  
										   <jsp:param name="width"        value="70" /> 
										   <jsp:param name="height"       value="20" /> 
										   <jsp:param name="multi"        value="true" /> 
										   <jsp:param name="buttonClass" value="upload_btn" /> 
										   <jsp:param name="buttonText"       value="" /> 
										   <jsp:param name="fileSizeLimit"        value="0" /> 
										   <jsp:param name="fileTypeExts"         value="*.class" /> 
										   <jsp:param name="uploadLimit"      value="0" /> 
										 </jsp:include>
									  </div> --%>
								  </td>
								</tr>
								<!--表单保存数据方法名：-->
								<tr>
									<td class="td_lefttitle"  for='<s:text name="workflow.newworkflowsubmitmethod"/>' ><s:text name="workflow.newworkflowsubmitmethod"/>：</td>
									<td  valign="middle" class="table_linebottom">
														<input type="text" style="width:95%;"  name="formUpdateData"  id="formUpdateData" class="inputText" maxlength="25" value="">                            
									</td>
									<td> <span class="MustFillColor"><s:text name="workflow.newworkflowtip"/></span> </td>
								</tr>
								<tr style="display:none">
									<td class="td_lefttitle"  for="接口保存数据方法名" >接口保存数据方法名：</td>
									<td  valign="middle" class="table_linebottom">
										<input type="text" style="width:95%;"  name="formUpdateStatus"  id="formUpdateStatus" class="inputText" maxlength="25" value="">
									</td>
									<td>
									 <span class="MustFillColor"><s:text name="workflow.newworkflowtip"/></span>
									</td>
								</tr>
								<!--表单完成数据方法名-->
								<tr>
									<td  class="td_lefttitle"  for='<s:text name="workflow.newworkflowfinishmethod"/>' ><s:text name="workflow.newworkflowfinishmethod"/>：</td>
									<td  valign="middle" class="table_linebottom">
										 <input type="text" style="width:95%;"  name="formBackData" id="formBackData" class="inputText" maxlength="25" value="">
									</td>
									<td>
									   <span class="MustFillColor"><s:text name="workflow.newworkflowtip"/></span>
									</td>
								</tr>

								<!--接口完成数据方法名：-->
								<tr style="display:none" >
									<td class="td_lefttitle" >接口完成数据方法名：</td>
									<td  valign="middle" class="table_linebottom">
										 <input type="text" style="width:95%;"  name="formBackStauts" id="formBackStauts" class="inputText" maxlength="25" value=""> 
									</td>
									<td>
									  <span class="MustFillColor"><s:text name="workflow.newworkflowtip"/></span>
									</td>
								</tr>
								<tr>
									<td  align="left"  colspan="3" ><span class="MustFillColor"><s:text name="workflow.set_dealwithjsmethod"/></span></td>
								</tr>

								<tr>
									<td class="td_lefttitle" ><s:text name="workflow.set_loadjsmethod"/>：</td>
									<td  valign="middle" class="table_linebottom">
											<input type="text" style="width:95%;"  name="forminitJsFunName_text"  id="forminitJsFunName_text"  class="inputText" maxlength="25" value=""> 
									</td>
								    <td></td>
								</tr>
								<tr>
									<td class="td_lefttitle" ><s:text name="workflow.set_updatejsmethod"/>：</td>
									<td  valign="middle" class="table_linebottom">
										 <input type="text" style="width:95%;"  name="formsaveJsFunName_text" id="formsaveJsFunName_text"  class="inputText" maxlength="25" value="">  
									</td>
									<td></td>
								</tr>
								<tr>
									<td  colspan="3" >&nbsp;
									</td>
								</tr> 
								<tr  class="Table_nobttomline">
								   <td class="td_lefttitle" >&nbsp;</td>
								   <td  colspan="2" >
									 <input type="button" class="btnButton4font" onClick="save('trueModify');" value='<s:text name="comm.saveclose"/>' />  
									 <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
									 <input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>'/>  
								   </td>
							   </tr>
							  </table>
			         </div>          
				</td>
			 </tr>
			  

			 <!--<tr>
				<td>
					<div style="margin:10px;">
					 <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
				   <tr>
					   <td class="td_lefttitle" style="width:85px;">&nbsp;</td>
					   <td colspan="4">
						<input type="button" class="btnButton4font" onClick="save('trueModify');" value='<s:text name="comm.saveclose"/>' />  
						 
						<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
						<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
					   </td>
				   </tr>
				   </table>
				   </div>
				</td>
			 </tr>-->
			</table>
	      </s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
//*************************************下面的函数属于公共的或半自定义的*************************************************//
//设置表单为异步提交
//initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//	
function MM_openBrWindow(theURL,winName,features) { //v2.0
   window.open(encodeURI(theURL),winName,features);
}

//初始化 分类
initPackage();

//检查为空
function checkEmpty(fieldname,showname){
	var filedctl = $("*[name='"+fieldname+"']");
	if(filedctl != null && filedctl.length > 0 ){
		if(filedctl[0].value == "" || filedctl[0].value.replace(/(^\s*)|(\s*$)/g, "") == "" ){
			alert(showname + "不能为空！");
			try{
				filedctl[0].focus();
			}catch(e){
			}
			return false;
		}else if( filedctl[0].value.indexOf("'") >= 0 ){
			alert(showname + "不能有'号！");
			return false;
		}
	}
	return true;
} 
</script>
</html>

