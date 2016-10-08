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
String moduleId=request.getParameter("moduleId")==null?"1":request.getParameter("moduleId")+"";  
String formType=request.getAttribute("formType")==null?"0":request.getAttribute("formType").toString(); 
String processType=request.getParameter("processType")==null?"":request.getParameter("processType").toString();
String  comboxType="ext";
if(whir_agent.indexOf("Firefox/4")>0){
	comboxType="";
} 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="workflow.setup"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
    <script type="text/javascript">
	    var p_comboxType="<%=comboxType%>";
	</script>
	<script src="<%=rootPath%>/platform/bpm/i18n/js_workflowMessage.jsp" type="text/javascript"></script>
	<%
	if(comboxType.equals("ext")){
	%>
	<%@ include file="/public/include/include_extjs.jsp"%>
	<%}%>
	<script src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/Map.js" type="text/javascript"></script> 
	<script src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/src/name/xio/util/List.js" type="text/javascript"></script> 
	<script src="<%=rootPath%>/platform/bpm/ezflow/process/ezflow_process_set.js" type="text/javascript"></script> 
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
			<input type="hidden" name="moduleId" id="moduleId" value="<%=moduleId%>">
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
									    <input type="text" name="id"  id="id"    class="inputText"  style="width:95%;" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']">
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
								  <tr>
									<td  class="td_lefttitle" style="border-bottom:0px"  for='<s:text name="workflow.setupusers"/>'><s:text name="workflow.setupusers"/><span class="MustFillColor">*</span><!--span class="mustFillcolor_red">*</span-->：</td>
									<td>
									  <textarea name="processUserScopeName" id="processUserScopeName"  style="width:95%;" readonly="true" rows="3" class="inputTextarea"  whir-options="vtype:['notempty',{'maxLength':400}]"  ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processUserScope', allowName:'processUserScopeName', select:'usergrouporg', single:'no', show:'usergrouporg', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
									  <input type="hidden" name="recordId" id="recordId" value=""><input type="hidden" name="processUserScope"  id="processUserScope" value="">
								    </td>
									<td></td>
								  </tr> 

								   <!--流程类型-->
								  <tr>
									<td  class="td_lefttitle" style="border-bottom:0px"  for='<s:text name="workflowAnalysis.WorkflowType"/>'><s:text name="workflowAnalysis.WorkflowType"/><span class="MustFillColor">*</span><!--span class="mustFillcolor_red">*</span-->：</td>
									<td>
									     <INPUT   value="1" CHECKED type="radio" name="processType"><!-- 业务流程 --><s:text name="workflow.newworkflowfix"/>
										 <!--自定义表单-->
									     <INPUT   value="0" type="radio" name="processType"><!-- 随机流程 --><s:text name="workflow.newworkflowrandom"/>
										 <INPUT   value="3" type="radio" name="processType"><!-- 自由流程 --><s:text name="workflow.newworkflowfreedom"/>
										 <INPUT   value="2" type="radio" name="processType"><!-- 半自由流程 --><s:text name="workflow.newworkflowfreedomhalf"/>
								    </td>
									<td></td>
								  </tr> 

								  <!--表单类型-->
								  <%if(moduleId.equals("1")){%>
								  <tr>
									<td class="td_lefttitle" ><s:text name="workflow.newworkflowformtype"/><span class="MustFillColor">*</span>：</td>
									<td>
									     <INPUT  onClick="showJspInfo();" value="0" CHECKED type="radio" name="formType"><s:text name="workflow.newworkflowdiyform"/>
										 <!--自定义表单-->
									     <INPUT onClick="showJspInfo();"  value="1" type="radio" name="formType"><s:text name="workflow.newworkflowjspfile"/>
								    </td>
									<td>&nbsp;</td>
								 </tr>
								 <%}else{%>
                                    <input type="hidden" name="formType" id="formType" value="<%=formType%>">
								 <%  }%>
								  <tr id="show_box01"  >
									  <td  class="td_lefttitle" > <s:text name="workflow.newworkflowformuse"/><span class="MustFillColor">*</span>：</td>
									  <td>
										 <select name="formKey"  id="formKey"    >
									      <c:forEach items="${formList}" var="form">
										    <option value="${form[0]}${form[2]}" >${form[1]}</option>
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
								 <tr id="tr_field">
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


								  <tr id="tr_field2">
									<td  class="td_lefttitle" ><!--可写字段：--><s:text name="workflow.set_hiddenforinit"/>：</td>
									<td  height="150px" valign="middle">
										 <table width="100%" height="100%"  border="0" cellspacing="0" cellpadding="0" class="table_noline"  style="margin-left:-4px">
											<tr >
												<td width="120px" align="left" valign="middle">
													  <select name="field2" id="field2"  multiple="multiple" size="10" style="width:120px;height:150px">
														   <c:forEach items="${fieldList}" var="field">
															<option value="${field[0]}">${field[1]}</option>
														   </c:forEach>
													  </select>
												</td>
												<td width="80px" align="center" valign="middle"> 
												      <input type="button" class="btnButton4font" id="button" value="> " onclick='transferOptions("field2","nodeHiddenForStartUserField");'/>
													  <div style="height:5px">&nbsp;</div>
													  <input name="button" type="button" id="button" value=">>" onclick='transferOptionsAll("field2","nodeHiddenForStartUserField");' class="btnButton4font" >
													  <div style="height:5px">&nbsp;</div>
													  <input name="button" type="button" id="button" value="< " onclick='transferOptions("nodeHiddenForStartUserField","field2");' class="btnButton4font" >
													  <div style="height:5px">&nbsp;</div>
													  <input name="button" type="button" id="button" value="<<" onclick='transferOptionsAll("nodeHiddenForStartUserField","field2");' class="btnButton4font">
												</td>
											    <td width="120px" align="left"  valign="middle" > 
												      <select name="nodeHiddenForStartUserField" id="nodeHiddenForStartUserField" multiple="multiple" size="10" style="width:120px;height:150px">
													  </select>
											    </td>
											    <td >&nbsp;</td>
										  </tr>
									    </table>
									</td>
									<td>&nbsp;</td>
								 </tr>  
                                  <tr>
								      <td  class="td_lefttitle" ><!-- 流程办结抄送 --><s:text name="workflow.completeprocesssendread"/>：</td>
									  <td>
									  <INPUT  onClick="showCompleteInfo(this.value);" value="0" CHECKED type="radio" name="completeReadType"><s:text name="workflow.newactivityneedno"/><!-- 不需要 -->
									  <INPUT onClick="showCompleteInfo(this.value);"  value="1" type="radio" name="completeReadType"><s:text name="workflow.newactivityneed"/><!-- 需要 -->
									  </td>
									  <td>&nbsp;</td>
								 </tr> 

								  <tr  id="completeReadInfo" >
									<td  class="td_lefttitle" ><!--可写字段：--></td>
									<td  height="150px" valign="middle"> 
									     <table width="100%" cellpadding="0" cellspacing="0"  border="0"  style="margin-left:-4px;">
											    <!--表明角色选择-->
											    <tr>
												   <td height="22">
												       <strong><s:text name="workflow.newactivityroleselect"/></strong>
												    </td>
												</tr>
												<!--从系统角色中指定-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="systemRole" type="radio" name="participantType"> 
													   	<s:text name="workflow.newactivityroleselect1"/>
												    </td>
												</tr>
												<tr id="participantRole">
													<td>
													   <table width="100%" border="0"> 
														   <%//角色选择%>
															 <tr>
																 <td width="62" align="right" nowrap><s:text name="workflow.newactivityroleselect"/></td>
																 <td width="370"> 
																	  <!-- <input id="partRole" value="7720" type="hidden" name="partRole"> -->
																	  <select name="partRole"  id="partRole" >
																		 <c:forEach items="${allRoleList}" var="role">
																			 <option value="${role[0]}">${role[1]}</option>
																		  </c:forEach>
																	  </select>
																 </td>
																  <td>
																	   <select name="partRoleNexus">
																			 <!-- <option value="0"></option> -->
																			  <option value="and">AND</option>
																	    </select> 
																 </td>
														     </tr>
															 <%/*组&nbsp;&nbsp;&nbsp;&nbsp;织
															      启动人的组织 -1
																  启动人的组织及上级组织-2
																  启动人的组织及下级组织 -3
																  启动人相同办公地点 -4
																  ------------------- 
															    */
															 %>
															 <tr>
																 <td align="right"><s:text name="workflow.Organization"/> <!--组织--></td>
																 <td>
																    <select  id="partRoleOrg"   name="partRoleOrg" >
																	    <option selected value="-1"><s:text name="workflow.OrganizationofStartPeople"/></option>
																		<option value="-2"><s:text name="workflow.OrganizationandUpperLevelOrganizationofStartPeople"/></option>
																		<option value="-3"><s:text name="workflow.OrganizationandLowerLevelOrganizationofStartPeople"/></option>
																	    <option value="-4"><s:text name="workflow.Sameworkplaceofstartpeople"/></option>
																	    <option value="0">-------------------</option>
																		 <c:forEach items="${allOrgList}" var="org">
																			 <option value="${org[0]}">${org[1]}</option>
																		 </c:forEach>
																	  </select>
																  </td> 
																  <td>
																  </td>
															 </tr> 
															  <tr id="partRoleOrgLevelID" style="display: none">
																 <td align="right"><s:text name="workflow.from"/><!-- <s:text name="workflow.OrganizationalLevel"/> --><!--组织级别--></td>
																 <td> 
																     <select  name="partRoleOrgLevel">
																		<option selected value="0">1</option>
																		<option value="1">2</option>
																		<option value="2">3</option>
																		<option value="3">4</option>
																		<option value="4">5</option>
																		<option value="5">6</option>
																		<option value="6">7</option>
																		<option value="7">8</option>
																		<option value="8">9</option>
																		<option value="9">10</option>
																		<option value="10">11</option>
																		<option value="11">12</option>
																		<option value="12">13</option>
																		<option value="13">14</option>
																		<option value="14">15</option>
																		<option value="15">16</option>
																		<option value="16">17</option>
																		<option value="17">18</option>
																		<option value="18">19</option>
																		<option value="19">20</option>
																      </select><!-- 级组织向下寻找 --><s:text name="workflow.Lookingfordownlevelorganization"/>
																  </td>
																  <td>
																  </td>
															 </tr> 
													   </table>
												    </td>
												</tr>
												
												<!--流程启动人-->
												<%
												
												%>
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="initiator" checked type="radio" name="participantType"> 
													   	<s:text name="workflow.newactivityroleselect2"/>&nbsp;&nbsp;
														<select name="initiatorType">
															<option selected value="Initiator"><s:text name="workflow.self"/></option>
															<option value="Leader"><s:text name="workflow.leader"/></option>
															<option value="DepartLeader"><s:text name="workflow.departleader"/></option>
															<option value="ChargeLeader"><s:text name="workflow.chargeleader"/></option>
														</select>
												    </td>
												</tr>  
												<tr>
												  <td height="22"><strong><s:text name="workflow.newactivityorggroup"/></strong></td>
												</tr>  

												<!--从选定的群组中选择-->
											
												<tr>
												   <td>
												      <input onClick="clickParticipantType(this);" value="someGroups" type="radio" name="participantType">
													  <s:text name="workflow.activityallgroup"/>  
												    </td>
												</tr>
												  <!-- 群组 --> 
                                                <tr id="xdqz">
                                                   <td>
												    <table width="100%">
													 <tr>
													    <td colspan="2">
														  <textarea rows="3" readonly name="participantGivenGroupName"  id="participantGivenGroupName"  class="inputTextarea"></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'participantGivenGroup', allowName:'participantGivenGroupName', select:'group', single:'no', show:'group', range:'*0*',key:'code'});return  false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
														  <input type="hidden" name="participantGivenGroup" id="participantGivenGroup">
														<td>
													 </tr> 
													 <tr>
														<td width="100" nowrap>
															<select name="partGroupNexus">
															  <option selected value="0"></option>
															   <option value="yu">AND</option>
															</select>
															<s:text name="workflow.Organization"/> 
														</td>
														<td>
															<select  name="partgGroupOrg"  id="partgGroupOrg"    >
															   <option selected value="-1"><s:text name="workflow.OrganizationofStartPeople"/></option>
																<option value="-2"><s:text name="workflow.OrganizationandUpperLevelOrganizationofStartPeople"/></option>
																<option value="-3"><s:text name="workflow.OrganizationandLowerLevelOrganizationofStartPeople"/></option>
																<option value="-4"><s:text name="workflow.Sameworkplaceofstartpeople"/></option>
																<option value="-5"><s:text name="workflow.OrganizationAndUpperLevelOrganizationOfPreviousActivity"/></option>
															   <option value="0">-------------------</option>
																 <c:forEach items="${allOrgList}" var="org">
																	<option value="${org[0]}">${org[1]}</option>
																 </c:forEach>
															  <!--	
															  <option value="19552">博航一统.test</option>-->
															 </select>
														</td>
													</tr>
													<tr id="partgGroupOrgLevelID" 	name="partgGroupOrgLevelID" style="display:none">
														<td  colspan="2"> <s:text name="workflow.from"/><!-- 组织级别 --><!-- <s:text name="workflow.OrganizationalLevel"/> ： --> 
															<select name="partgGroupOrgLevel">
															  <option selected value="0">1</option>
															  <option value="1">2</option>
															  <option value="2">3</option>
															  <option value="3">4</option>
															  <option value="4">5</option>
															  <option value="5">6</option>
															  <option value="6">7</option>
															  <option value="7">8</option>
															  <option value="8">9</option>
															  <option value="9">10</option>
															  <option value="10">11</option>
															  <option value="11">12</option>
															  <option value="12">13</option>
															  <option value="13">14</option>
															  <option value="14">15</option>
															  <option value="15">16</option>
															  <option value="16">17</option>
															  <option value="17">18</option>
															  <option value="18">19</option>
															  <option value="19">20</option>
															</select><!-- 级组织向下寻找 --><s:text name="workflow.Lookingfordownlevelorganization"/>
														 </td>
													</tr>
													<tr id="addressTypeSpan" style="display:none">
														<td> 办公地点分类： </td>
														 <td>
															  <select  name="workAddressType">
																  <option  value="">-----请选择----</option> 
																  <c:forEach items="${addressTypeList}" var="atype">
																		<option value="${atype[0]}">${atype[1]}</option>
																  </c:forEach> 
															  </select> 
														 </td>
													 </tr> 
                                                    </table>
					                               </td>
                                                </tr>   
												<tr>
												  <td height="22">
												     <strong><s:text name="workflow.newactivitydefaultselect"/></strong>
												  </td>
												</tr> 
												
											   <!--由表单中的某个字段值决定-->
												<tr  >
												   <td>
                                                      <input  onClick="clickParticipantType(this);" value="someField" type="radio" name="participantType">
													  <s:text name="workflow.newactivityroleselect9"/>&nbsp;&nbsp;
													  <input type="hidden" id="bdzd">
													  <select name="participantUserField" id="participantUserField">   
													  </select>
													  <select name="participantUserFieldType">
														  <option selected value="Initiator"><s:text name="workflow.self"/></option>
														  <option value="Leader"><s:text name="workflow.leader"/></option>
														  <option value="DepartLeader"><s:text name="workflow.departleader"/></option>
														  <option value="ChargeLeader"><s:text name="workflow.chargeleader"/></option>
													  </select>	
												   </td>
												</tr>
												
                                                <!-- 指定全部办理人-->
												<tr>
												    <td>
												      <input type="radio" value="setAllTransactors" name="participantType" onClick="clickParticipantType(this);" >
													 <s:text name="workflow.newactivityroleselect8"/>
												    </td>
												</tr>

												 
												<tr id="qbblr">
													  <td nowrap>
													     <textarea rows="3" readonly name="allUser"  id="allUser"	class="inputTextarea"></textarea> <a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'allUserId', allowName:'allUser', select:'user', single:'no', show:'usergroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
														 <input type="hidden" name="allUserId" id="allUserId">
														
													   </td>
												</tr> 
												<!--由接口决定-->
												<tr>
												   <td>
												     <input type="radio" value="setByInterface" name="participantType" onclick="clickParticipantType(this);">
													  <s:text name="workflow.byTheInterface"/> 
												    </td>
												</tr>
												<tr id="participantinterfacetr" style="display:none">
													<td colspan=2>
													  <table width="100%">
													      <tr>
														       <td nowrap><s:text name="workflow.className"/><!--接口类名-->：</td>
															   <td style="width:40%">
															     <input type="text" 	class="inputText" name="participantClassName" id="participantClassName"  style="width:98%"   value="">
															   </td>
															   <td nowrap><s:text name="workflow.methodName"/>：</td>
															   <td style="width:40%">
															     <input type="text" class="inputText"  name="participantMethodName" id="participantMethodName" style="width:98%"  value="">
															   </td>
															   <td>&nbsp;</td>
														  </tr>
														   <tr>
														       <td nowrap><s:text name="workflow.parameterName"/><!-- 接口参数名 -->：</td>
															   <td style="width:40%">
															     <input type="text" class="inputText"  name="participantInPaNames" id="participantInPaNames"  style="width:98%"  	value="">
															   </td style="width:40%">
															   <td nowrap><s:text name="workflow.parameterValue"/><!-- 接口参数值 -->：</td>
															   <td style="width:40%">
															     <input 	type="text" class="inputText" 	name="participantInPavalues" id="participantInPavalues"  style="width:98%"  value="">
															   </td>
															    <td>
																  <%-- <div style="margin-left:-1px;margin-top:10px;margin-bottom:9px">
																	  <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
																	   <jsp:param name="onInit"             value="" /> 
																	   <jsp:param name="onSelect"             value="" />  
																	   <jsp:param name="onUploadProgress"     value="" /> 
																	   <jsp:param name="onUploadSuccess"      value="participantClassNameJs" />
																	   <jsp:param name="dir"         value="/WEB-INF/classes/com/whir/ezoffice/formhandler/" />
																	   <jsp:param name="uniqueId"    value="participantClassNameUpload" />
																	   <jsp:param name="realFileNameInputId"    value="participantClassName" /> 
																	   <jsp:param name="saveFileNameInputId"    value="participantClassName" />
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
																  </div>--%>
																</td>
														    </tr>
													    </table>  
													 </td>
												</tr> 
												<!--所有经办人-->
												<tr>
													<td>
														<input onClick="clickParticipantType(this);" value="allDealUser" type="radio" name="participantType">
														所有经办人  
													</td>
												</tr>
											</table>  
									</td>
									<td>&nbsp;</td>
								 </tr> 
								  <tr id="tr_remindfield"  <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%> >
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
								  <tr  id="tr_showremind" <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%>  >
									  <td  class="td_lefttitle" ><s:text name="workflow.set_remindview" />：</td>
									  <td>
									    <label>
									       <input type="text" name="processRemindFieldPreview" id="processRemindFieldPreview"    class="inputText" style="width:95%;" > 
									       <input type="hidden" name="processRemindFieldPreviewValue" id="processRemindFieldPreviewValue"  value="" > 
									     </label>
										 <div><span class="MustFillColor">
										 请不要输入{}$,' 等特殊字符，以免破坏格式<br>
										 流程启动人，流程名称 必须有，否则会自动前后加 流程启动人与流程名称
										 </span></div>
									   </td>
									   <td>&nbsp;</td>
								 </tr>

								 <!--办理期限-->
								<tr>
									<td class="td_lefttitle" for='<s:text name="workflow.newactivityperiod"/>'>
									   <s:text name="workflow.newactivityperiod"/>：
									</td>
									<td>
									   <INPUT name="processDeadlineType" CHECKED type="radio" onClick="clickPressType(this.value);" value="0"><s:text name="workflow.newactivityperiodnone"/>
									   <input value="1" type="radio" name="processDeadlineType" onClick="clickPressType(this.value);"><s:text name="workflow.newactivityperiodfix"/>  
									   <span id="deadlineSpan">
									     <SELECT name="deadlineLimit" id="deadlineLimit" class="selectlist" style="width:80px" >
												<OPTION selected value="1">1</OPTION>
												<OPTION value="2">2</OPTION>
												<OPTION value="3">3</OPTION>
												<OPTION value="4">4</OPTION>
												<OPTION value="5">5</OPTION>
												<OPTION value="6">6</OPTION>
												<OPTION value="7">7</OPTION>
												<OPTION value="8">8</OPTION>
												<OPTION value="9">9</OPTION>
												<OPTION value="10">10</OPTION>
												<OPTION value="11">11</OPTION>
												<OPTION value="12">12</OPTION>
												<OPTION value="13">13</OPTION>
												<OPTION value="14">14</OPTION>
												<OPTION value="15">15</OPTION>
												<OPTION value="16">16</OPTION>
												<OPTION value="17">17</OPTION>
												<OPTION value="18">18</OPTION>
												<OPTION value="19">19</OPTION>
												<OPTION value="20">20</OPTION>
												<OPTION value="21">21</OPTION>
												<OPTION value="22">22</OPTION>
												<OPTION value="23">23</OPTION>
												<OPTION value="24">24</OPTION>
										   </SELECT> 
										   <SELECT name="deadlineTimeType" id="deadlineTimeType" class="selectlist" style="width:80px" >
												<OPTION selected value="1"><s:text name="workflow.activityhour"/></OPTION>
												<OPTION value="0"><s:text name="workflow.activityday"/></OPTION>
										   </SELECT>
									   </span>
									</td>
									<td>&nbsp;</td>
								</tr>
								 <!--字段联动-->
								 <tr  id="tr_relationTrig"  <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%> >
									  <td class="td_lefttitle" ><s:text name="workflow.set_relationTrig" />：</td>
									  <td><select name="relationTrig" id="relationTrig"><option value="">--</option></select></td>
									  <td>&nbsp;</td>
								 </tr>
								 <!--办理查阅查看人：-->
								 <tr  <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%>  >
									  <td  class="td_lefttitle" for='<s:text name="workflow.newworkflowauthorizeduser"/>'><s:text name="workflow.newworkflowauthorizeduser"/>：</td>
									  <td>
											<input type="hidden" name="processCanReadEmp" id="processCanReadEmp" value="">
											<textarea name="processCanReadEmpName" id="processCanReadEmpName"   rows="5" class="inputTextarea" style="width:95%;" readonly="true" ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processCanReadEmp', allowName:'processCanReadEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
									  </td>
									  <td>
									    
									  </td>
								  </tr>
								  <!--办理查阅维护人-->
								  <tr   <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%>  >
									 <td class="td_lefttitle" for='<s:text name="workflow.newworkflowmaintainuser"/>' ><s:text name="workflow.newworkflowmaintainuser"/>：</td>
									 <td>
									    <textarea name="processCanModifyEmpName" id="processCanModifyEmpName" class="inputTextarea" style="width:95%;" readonly="true" rows="5"></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processCanModifyEmp', allowName:'processCanModifyEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
									    <input type="hidden" name="processCanModifyEmp" id="processCanModifyEmp" value="">
									 </td>
									 <td></td>
								 </tr>
								 <!--流程管理员-->
								 <tr  <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%>  >
									 <td  class="td_lefttitle"  for='<s:text name="workflow.Workflowadministrator"/>'><s:text name="workflow.Workflowadministrator"/>：</td>
									 <td>
									     <textarea name="processAdministratorName" id="processAdministratorName"   rows="5" class="inputTextarea" style="width:95%;" readonly="true" ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processAdministrator', allowName:'processAdministratorName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <input type="hidden" name="processAdministrator" id="processAdministrator" value="">
									</td>
									<td> </td>
								</tr>
								<!--设置项-->
								<tr>
									 <td class="td_lefttitle" ><s:text name="workflow.set_set"/>：</td>
									 <td> 
									     <div style="padding-top:4px;padding-bottom:3px;">
									         <input name="processNeedDossier"  id="processNeedDossier" type="checkbox" value="true"><s:text name="workflow.newworkflowarchive"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="processEndMail" type="checkbox" value="true"><s:text name="workflow.set_completeprocesswithemail"/>&nbsp;&nbsp;&nbsp;&nbsp;<input name="processKeepBackComment" type="checkbox" value="true"><s:text name="workflow.set_backsavecomment"/>&nbsp; &nbsp;&nbsp;&nbsp;<input name="processKeepReSubmitComment" type="checkbox" value="true">保留退回后重新提交前的批示意见<br>
									         <input name="processCommentIsNull" type="checkbox" value="true"><s:text name="workflow.set_commentisnotnull"/>&nbsp; &nbsp;<input name="processCommentAcc" type="checkbox" value="true"><s:text name="workflow.set_commentcanacc"/>&nbsp; &nbsp;<s:text name="workflow.set_commentsort"/>：<select name="orgcommentSortType"><option value="">不按组织排序</option><option value="org_asc">按组织顺序显示</option><option value="org_desc">按组织倒序显示</option></select>&nbsp;<select name="commentSortType"><option value="time_asc"><s:text name="workflow.set_commenttimeasc"/></option><option value="time_desc"><s:text name="workflow.set_commenttimedesc"/></option><option value="dute_asc"><s:text name="workflow.set_commentdutyasc"/></option><option value="dute_desc"><s:text name="workflow.set_commentdutydesc"/></option></select><br>
											 <input name="processNeedPrint" id="processNeedPrint" type="checkbox" value="true" ><!-- onclick="showExportTemp(this)"  流程办结后可以打印 --><s:text name="workflow.Sponsormayprinttheworkflowafterprocess" />&nbsp;&nbsp;<span id="ExportTempSpan" style="display:none"><input name="processPrintExportTemp" type="checkbox" value="true">流程办结后可以导出word模板和下载&nbsp; &nbsp;</span><input name="processAutoNextWithNullUser"  id="processAutoNextWithNullUser" type="checkbox" value="true"><s:text name="workflow.autodealwithnullusers"/><!-- 活动参与者为空自动跳转下一步 -->
											<!--  <input name="processAutoNextWithRepeat"  id="processAutoNextWithRepeat" type="checkbox" value="true">下一步参与者重复 -->
										 </div> 
									 </td>
									 <td>&nbsp;</td>
								</tr> 
								<tr <%if(moduleId.equals("50") || moduleId.equals("52")){%>style="display:none;"<%}%>>
									  <td  class="td_lefttitle" for='<s:text name="workflow.workflowname"/>'><s:text name="workflow.processMobileStatus"/>：</td>
									  <td>
									      <!-- -->
									      <input name="processCanMobilePhone"          id="processCanMobilePhone" type="checkbox" value="1"> <s:text name="workflow.processCanMobilePhoneStatus"/><!-- 同步到手机端 -->
                                          <input name="processCanPAD"  id="processCanPAD" type="checkbox" value="1"> <s:text name="workflow.processCanPADStatus"/><!-- 同步到PAD端 -->
									  </td>
									  <td>&nbsp;</td>
								 </tr>
								<!--流程描述-->
								<tr>
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
								       <%--<div style="margin-left:-1px;">
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

