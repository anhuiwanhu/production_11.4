<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %><%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %><%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x" %><%@ taglib uri="/WEB-INF/tag-lib/struts-logic.tld" prefix="logic" %><%@ taglib uri="/WEB-INF/tag-lib/struts-bean.tld" prefix="bean" %><%@ taglib uri="/WEB-INF/tag-lib/struts-html.tld" prefix="html" %><%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/WEB-INF/tag-lib/c.tld" prefix="c" %>
<%@ include file="/public/include/init_base.jsp"%>
<%
whir_custom_str="My97DatePicker powerFloat easyui";
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String comm_upload = Resource.getValue(local,"common","comm.upload");

String moduleId=request.getParameter("moduleId")==null?"1":request.getParameter("moduleId")+"";  

int moduleId_int=Integer.parseInt(moduleId);
String formType=request.getAttribute("formType")==null?"0":request.getAttribute("formType").toString(); 
String subType=request.getParameter("subType")==null?"0":request.getParameter("subType").toString();

String subTypeHidden="";
if(subType.equals("1")){
	//隐藏tr等
    subTypeHidden=" style='display:none' ";
} 

String  comboxType="ext";
if(whir_agent.indexOf("Firefox/4")>0){
	comboxType="";
}  

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:text name="workflow.activityset"/></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/> 
	<script type="text/javascript">
	    var p_comboxType="<%=comboxType%>";
	</script>
	<%
	if(comboxType.equals("ext")){
	%>
	<%@ include file="/public/include/include_extjs.jsp"%>
	<%}%>
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>

	<script src="<%=rootPath%>/platform/bpm/i18n/js_workflowMessage.jsp" type="text/javascript"></script>
	<script src="<%=rootPath%>/platform/bpm/ezflow/process/ezflow_process_setactivity.js" type="text/javascript"></script>  
</head>
<body class="Pupwin" onload="initData('<%=request.getParameter("id")%>')">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	      <s:form name="dataForm" id="dataForm" action="ezflowprocess!save.action" method="post" theme="simple" >
		     <input type="hidden" name="formType" id="formType" value="<%=formType%>">
			 <input type="hidden" name="moduleId" id="moduleId" value="<%=moduleId%>">
             <input type="hidden" name="subType" id="subType" value="<%=subType%>"> 
            <%@ include file="/public/include/form_detail.jsp"%>
	        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
				<tr>
					<td colspan="2">
						<div class="Public_tag">
							<ul>
								<li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><s:text name="workflow.newactivitybasicinfo"/></span><span class="tag_right"></span>
								</li>
								<li id="Panle1" onClick="changePanle(1);" <%=subTypeHidden%> ><!--表单控制--><span class="tag_center"><s:text name="workflow.formInfo"/></span><span class="tag_right"></span>
								</li>
								<li id="Panle2" onClick="changePanle(2);"><span class="tag_center"><s:text name="workflow.newactivityoperbutton"/></span><span class="tag_right"></span>
								</li>  
								<li id="Panle3" onClick="changePanle(3);"><span class="tag_center"><s:text name="workflow.newactivityinterface"/></span><span class="tag_right"></span>
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
				         <input type="hidden" name="id" value="">
						 <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0">
						     <!--活动名-->
						     <tr>
							    <td width="90px" class="td_lefttitle" for='<s:text name="workflow.newactivityname"/>'>
								   <s:text name="workflow.newactivityname"/><span class="MustFillColor">*</span>：
								</td>
								<td>
								   <input type="text" name="name" id="name"  value="" class="inputText" style="width:95%;"  whir-options="vtype:['notempty',{'maxLength':30},'spechar3'],'promptText':'<s:text name="workflow.newactivityname"/>'">
								</td>
								<td width="60px">&nbsp;</td>
							</tr>
							<!--办理方式-->
							<tr>
							    <td  class="td_lefttitle" for='<s:text name="workflow.newactivityprocesstype"/>'>
								   <s:text name="workflow.newactivityprocesstype"/><span class="MustFillColor">*</span>：
								</td>
								<td>
								   <select name="taskSequenceType" id="taskSequenceType" class="selectlist"  style="width:95%;" >
										<c:forEach items="${taskSequenceTypeList}" var="taskSequence">
											<option value="${taskSequence[0]}">${taskSequence[1]}</option>
										</c:forEach>
					              </select>
								</td>
								<td width="60px">&nbsp;</td>
							</tr>
							<!--优先级别-->
							<tr>
							    <td  class="td_lefttitle" for='<s:text name="workflow.EmergencyDegree"/>'>
								   <s:text name="workflow.EmergencyDegree"/><span class="MustFillColor">*</span>：
								</td>
								<td>
								   <select name="priority" id="priority" class="selectlist" style="width:95%;"  >
										<c:forEach items="${priorityList}" var="priority">
											<option value="${priority[0]}">${priority[1]}</option>
										</c:forEach>
							       </select>
								</td>
								<td width="60px">&nbsp;</td>
							</tr>
							<!--使用表workflow.newactivityformuse单-->
							<tr <%=subTypeHidden%> >
							    <td  class="td_lefttitle" for='<s:text name="workflow.newactivityprocesstype"/>'>
								   <s:text name="workflow.newactivityformuse"/><span class="MustFillColor">*</span>：
								</td>
								<td>
								   <select name="formKey" id="formKey"  onChange="changerFormKey(this.value)" >
										<c:forEach items="${formList}" var="form">
											<option value="${form[0]}${form[2]}">${form[1]}</option>
										</c:forEach>
									</select>
								</td>
								<td width="60px">&nbsp;</td>
							</tr>
							<!--活动描述-->
							<tr>
							    <td class="td_lefttitle" for='<s:text name="workflow.newactivitydescription"/>'>
								   <s:text name="workflow.newactivitydescription"/>：
								</td>
								<td>
								    <textarea name="documentation" id="documentation" cols="45" rows="5" class="inputTextarea" style="width:95%;"   whir-options="vtype:[{'maxLength':500}]" ></textarea>
								</td>
								<td width="60px">&nbsp;</td>
							</tr>


							<tr>
							    <td class="td_lefttitle" for='<s:text name="workflow.ProcessTips"/>'>
								   <s:text name="workflow.ProcessTips"/>：
								</td>
								<td> 
							        <input value="0" type="radio" name="activityTip" onClick="clickActivityTips(this.value);"><!-- 无 --><s:text name="workflowAnalysis.No"/>
								    <INPUT value="1" type="radio" name="activityTip" onClick="clickActivityTips(this.value);"><!-- 有 --><s:text name="workflowAnalysis.Yes"/> 
								</td>
								<td width="60px">&nbsp;</td>
							</tr>

							<tr  id="activityTipTitle_tr">
							    <td class="td_lefttitle" for='<s:text name="workflow.ProcessTipsTitle"/>'>
								   <s:text name="workflow.ProcessTipsTitle"/><span class="MustFillColor">*</span>：
								</td>
								<td>
								    <input type="text" name="activityTipTitle" id="activityTipTitle"  value="" class="inputText" style="width:95%;"  whir-options="vtype:[{'maxLength':50},'spechar3']">
								</td>
								<td width="60px">&nbsp;</td>
							</tr>

							<tr  id="activityTipCotent_tr" >
							    <td class="td_lefttitle" for='<s:text name="workflow.ProcessTipsContent"/>'>
								   <s:text name="workflow.ProcessTipsContent"/><span class="MustFillColor">*</span>：
								</td>
								<td>  
									 <textarea name="activityTipCotent" id="activityTipCotent" cols="45" rows="5" class="inputTextarea" style="width:95%;"   whir-options="vtype:[{'maxLength':500}]" ></textarea>
								</td>
								<td width="60px">&nbsp;</td>
							</tr>
							
							<!--办理期限-->
							<tr>
							    <td class="td_lefttitle" for='<s:text name="workflow.newactivityperiod"/>'>
								   <s:text name="workflow.newactivityperiod"/>：
								</td>
								<td>
								   <INPUT name="overdueType" CHECKED type="radio" onClick="clickPressType(this.value);" value="0"><s:text name="workflow.newactivityperiodnone"/>
							       <input value="1" type="radio" name="overdueType" onClick="clickPressType(this.value);"><s:text name="workflow.newactivityperiodfix"/>
                                   <%if(moduleId.equals("1")){%> 
								     <INPUT value="2" type="radio" name="overdueType" onClick="clickPressType(this.value);"><s:text name="workflow.activitytrandiy"/> 
								   <%}%>   
								</td>
								<td width="60px">&nbsp;</td>
							</tr>

							<tr id="show_box03" style="display:none">
							    <td  class="td_lefttitle" > 
								</td>
								<td>
								    <SPAN id="blts">
										    <SELECT name="pressLimit" class="selectlist" style="width:80px" >
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
										   <SELECT name="pressMotionTimeType" class="selectlist" style="width:80px" >
												<OPTION selected value="1"><s:text name="workflow.activityhour"/></OPTION>
												<OPTION value="0"><s:text name="workflow.activityday"/></OPTION>
										   </SELECT>
										</SPAN>&nbsp;&nbsp;
										<SPAN id="txsj">
										    <INPUT value="1" CHECKED type="checkbox" id="isMotion" name="isMotion"><s:text name="workflow.newactivityperiodfixdetail"/><!-- 提前 --> 
											<SELECT  name="pressMotionTime" class="selectlist"  style="width:80px">
													<OPTION selected value="900">15<s:text name="workflow.activityminute"/></OPTION>
													<OPTION value="1800">30<s:text name="workflow.activityminute"/></OPTION>
													<OPTION value="3600">1<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="7200">2<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="10800">3<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="14400">4<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="18000">5<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="21600">6<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="86400">1<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="172800">2<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="259200">3<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="345600">4<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="432000">5<s:text name="workflow.activityday"/></OPTION>
											</SELECT>
										 </SPAN>
								</td>
								<td width="60px">&nbsp;</td>
							</tr>
						    <tr id="show_box04">
							 <td  class="td_lefttitle"></td>
							 <td> 
								<table  id="dispTable"  border="0" cellspacing="0" cellpadding="0" class="SubTable" style="width:95%" >
									<tr class="subTitle">
										<td width="20%" ><s:text name="workflow.newactivitydefinefiled"/><!-- 字段 --></td>
										<td width="10%" ><s:text name="workflow.newactivitydefinecaculation"/><!-- 运算 --></td>
										<td width="10%" ><s:text name="workflow.newactivitydefinevalue"/><!-- 值 --></td>
										<td width="15%" ><bean:message bundle="filetransact" key="file.doschedule"/></td>
										<td width="10%"><s:text name="workflow.newactivitydefineremind"/><!-- 催办时间(提前) --></td>
										<td width="30%"><s:text name="workflow.newactivitydefinePerson"/></td>
										<td width="5%" valign="middle">&nbsp;</td>
									</tr>
									<tr>
										<td class="subTitleList" style="border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;">
										   <select name="customFieldName" id="customFieldName"  class="selectlist"   style="width:120px;height:29px">
										   </select>
										</td>
										<td class="subTitleList" style="border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;">
										   <select name="customOperateStr" id="customOperateStr"  class="selectlist"  style="width:70px;height:29px">
												<option value=">" selected>大于</option>
												<option value=">=">大于等于</option>
												<option value="<">小于</option>
												<option value="<=">小于等于</option>
												<option value="==">等于</option>
										   </select>
										</td>
										<td class="subTitleList" style="border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;">
											<input name="customFieldValueStr" id="customFieldValueStr" type="text" class="inputText"    style="width:50px;" value="">
										</td>
										<td  class="subTitleList" style="border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;" nowrap>
										   <input name="customTimeNum" id="customTimeNum" type="text" class="inputText"    style="width:50px;" value=""> 
											 <!-- <SELECT  name="customTimeNum" id="customTimeNum" class="selectlist"  style="width:40px">
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
											</SELECT> -->
											<SELECT name="customTimeType" id="customTimeType" class="selectlist"  style="width:55px;height:29px;">
												<OPTION selected value="1"><s:text name="workflow.activityhour"/></OPTION>
												<OPTION value="0"><s:text name="workflow.activityday"/></OPTION>
											</SELECT>
										</td>
										<td class="subTitleList" style="border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;" nowrap>
											<input value="1" checked type="checkbox" name="customIsMotion" id="customIsMotion"><s:text name="workflow.newactivityperiodfixdetail"/><!-- 提前 --> 
											 <select  name="customPressMotionTime" id="customPressMotionTime" class="selectlist"  style="width:60px;height:29px">
													<OPTION selected value="900">15<s:text name="workflow.activityminute"/></OPTION>
													<OPTION value="1800">30<s:text name="workflow.activityminute"/></OPTION> 
													<OPTION value="3600">1<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="7200">2<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="10800">3<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="14400">4<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="18000">5<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="21600">6<s:text name="workflow.activityhour"/></OPTION>
													<OPTION value="86400">1<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="172800">2<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="259200">3<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="345600">4<s:text name="workflow.activityday"/></OPTION>
													<OPTION value="432000">5<s:text name="workflow.activityday"/></OPTION>
											</select>
										</td>
										<td  class="subTitleList" ><select  name="customPressUserIds_select" id="customPressUserIds_select" class="selectlist"  style="width:120px;height:29px">
										        <option value="$-1$">无</option>
												<option value="$-2$">当前办理人</option>
												<option value="$-3$">当前办理人上级领导</option>
												<option value="$-4$">当前办理人分管领导</option>  
												<option value="$-5$">当前办理人部门领导</option>
											</select><input type="hidden"  name="dispTable_index"  value="0"><input type="hidden" name="customPressUserIds0" id="customPressUserIds0" value=""><input  name="customPressUserNames0" id="customPressUserNames0"    type="text" class="inputText"    style="width:40%" readonly><a href="#" class="selectIco" onclick="openSelect({allowId:'customPressUserIds0', allowName:'customPressUserNames0', select:'user', single:'yes', show:'userorggroup', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a></td> 
										<td class="subTitleList" style="border-right:1px solid #d9d9d9; border-bottom:1px solid #d9d9d9; padding:4px;"  nowrap >
										<a href="#"  onClick="addRow(this);return false;"><img src="<%=rootPath%>/images/madd.gif" width="12" height="12" align="absmiddle"/></a><a href="#"   onClick="delRow(this);return false;"><img src="<%=rootPath%>/images/adelete.gif" width="12" height="12" align="absmiddle"/></a> 
										</td>
									</tr>
								</table> 
							</td>
							<td></td>
							<tr>

							<tr id="show_box05" style="display: none">
					            <td   align="left" valign="top"   class="td_lefttitle">
								   <s:text name="workflow.activityduedeal"/>：
								</td>
					            <td class="table_linebottom">
									<input type="checkbox" 	value=",system," name="overdueDealType"><s:text name="taskcenter.remind0"/><!-- 系统中提醒 -->
									<c:if test="${noteRemind == 'true'}"> 
	                                 <input type="checkbox" name="overdueDealType" value=",note,"   ><bean:message bundle="workflow" key="workflow.activitysmsremind"/><!--即时通讯提醒--> 
								    </c:if>
									<input type="checkbox" value=",press," name="overdueDealType"><s:text name="workflow.activityduepress"/><!-- 催办 -->
									<input type="checkbox" value=",autoDeal," name="overdueDealType"><s:text name="workflow.Autojump"/> 
									<input type="checkbox" value=",autoTran," name="overdueDealType"><s:text name="workflow.AutoTran"/>
								</td>
								<td></td>
				            </tr>
							<!--参与者-->
							<tr>
							    <td  class="td_lefttitle" for='<s:text name="workflow.newactivityparticipant"/>'>
								   <s:text name="workflow.newactivityparticipant"/><span class="MustFillColor">*</span>：
								</td>
								<td>
								   
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
																			 <option value="0"></option>
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
												
												<!--上一活动办理人的上级领导-->
												<tr>
												   <td>
												         <input onClick="clickParticipantType(this);" value="prevTransactorLeader" type="radio" name="participantType" > 
														 <s:text name="workflow.newactivityroleselect3"/> 
														  <select name="prevTraLAnd"  id="prevTraLAnd" >
															   <option selected value="0"></option>
															   <option value="yu">AND</option>
														  </select>
														  <s:text name="workflow.dutyLevel"/> 
														  <select name="prevDutyLevelOperate">
															  <option selected value="<">&lt;</option>
															  <option value="<=">&lt;=</option>
															  <option value="<>">≠</option>
															  <option value="=">=</option>
															  <option value=">">&gt;</option>
															  <option value=">=">&gt;=</option>
														  </select>
														  <select name="prevDutyLevel">
														     <c:forEach items="${dutyList}" var="org">
																<option value="${org[2]}">${org[1]}(${org[2]})</option>
														    </c:forEach>
														 </select>
												    </td>
												</tr>
												
												<!--上一活动办理人的组织及下级组织-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="prevTransactorOrg" type="radio" name="participantType">
											          <s:text name="workflow.OrganizationAndLowerLevelOrganizationOfPreviousActivity"/>
										              &nbsp;<s:text name="workflow.from"/>
											          <!--  <s:text name="workflow.OrganizationalLevel"/>： -->
											          <select name="lastParticipantOrgLevel">
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
													   </select>
													   <!-- 级组织向下寻找 --><s:text name="workflow.Lookingfordownlevelorganization"/>
												    </td>
												</tr>
												
												<!--上一活动所有参与者-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="prevTransactors" type="radio" name="participantType">
                                                       <s:text name="workflow.newactivityroleselect12"/> 
												    </td>
												</tr>
												
												<!--活动参与者本人-->
												<tr>
												   <td>
												      <input onClick="clickParticipantType(this);" value="activityTransactor" type="radio"  name="participantType">
				                                      <s:text name="workflow.activityself"/> 
													  <select name="dealedActivityId" id="dealedActivityId" style="margin-left:2px;"  >
													  </select>
												    </td>
												</tr>
												
												<!--活动参与者上级领导-->
												<tr>
												   <td>
												      <input onClick="clickParticipantType(this);" value="activityTransactorLeader" type="radio" name="participantType">
				                                      <s:text name="workflow.activityLeader"/> 
													  <select name="dealedActivityId_leader" id="dealedActivityId_leader" style="margin-left:2px;">
													  </select>
												    </td>
												</tr>
												
												
												<!--选中组织-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="chooseOrgLeader" type="radio"  name="participantType">
                                                       <s:text name="workflow.choosedorg"/>&nbsp;&nbsp;
													   <select name="chooseOrgLeaderType">
														  <option value="orgDepart"><s:text name="workflow.departleader"/></option>
														  <option value="orgCharge"><s:text name="workflow.chargeleader"/></option>
													   </select>
												    </td>
												</tr>
												
												<!--流程启动人上级组织 AND 职务-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="initiatorLeaderOrg" type="radio"  name="participantType">
													   <s:text name="workflow.activitysubmitpersonuporg"/> 
													   <select name="dutyLevelOperate">
														  <option selected value="<">&lt;</option>
														  <option value="<=">&lt;=</option>
														  <option value="<>">≠</option>
														  <option value="=">=</option>
														  <option value=">">&gt;</option>
														  <option value=">=">&gt;=</option>
														</select>
														<select name="dutyLevel">
														    <c:forEach items="${dutyList}" var="org">
																<option value="${org[2]}">${org[1]}(${org[2]})</option>
														    </c:forEach>
														</select>
												    </td>
												</tr>
												
												<tr>
												  <td height="22"><strong><s:text name="workflow.newactivityorggroup"/></strong></td>
												</tr> 
												
												<!--从所有用户中选择-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="allUser" type="radio" name="participantType">
													   <s:text name="workflow.newactivityroleselect4"/>   
												    </td>
												</tr>
												
												<!--从选定的群组中选择-->
												<tr>
												   <td>
												      <input onClick="clickParticipantType(this);" value="someGroups" type="radio" name="participantType">
													  <s:text name="workflow.activityallgroup"/>
													  <INPUT value="true" type="checkbox" name="participantGroupNeedAllSend">默认全部发送
												    </td>
												</tr>
												  <!-- 群组 --> 
                                                <tr id="xdqz">
                                                   <td>
												    <table width="100%">
													 <tr>
													    <td colspan="2">
														  <textarea rows="3" readonly name="participantGivenGroupName"  id="participantGivenGroupName"  class="inputTextarea"></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'participantGivenGroup', allowName:'participantGivenGroupName', select:'group', single:'no', show:'group', range:'*0*',key:'code',showShortcut:'0'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
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
															<select  name="partgGroupOrg"  id="partgGroupOrg">
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
														<td colspan="2"> <s:text name="workflow.from"/><!-- 组织级别 --><!-- <s:text name="workflow.OrganizationalLevel"/> ： --> 
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
														<td> 办公地点分类：
														</td>
														 <td>
															  <select  name="workAddressType">
																  <option  value="">--<s:text name="workflowAnalysis.PleaseSelect"/>--</option> 
																  <c:forEach items="${addressTypeList}" var="atype">
																		<option value="${atype[0]}">${atype[1]}</option>
																  </c:forEach> 
															  </select> 
														 </td>
													 </tr> 
                                                    </table>
					                               </td>
                                                </tr> 
												
												
											    <!--从本级组织及其下级组织中选择-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="orgAndsonOrgs" type="radio" name="participantType">
													   <s:text name="workflow.newactivityroleselect10"/>  
												    </td>
												</tr>
												
												
												 <!--从候选人员中指定-->
												<tr>
												   <td>
												      <input onClick="clickParticipantType(this);" value="someUsers" type="radio" name="participantType">
													  <s:text name="workflow.newactivityroleselect6"/>    
												    </td>
												</tr>
												
												<tr id="hxr">
												  <td height="18"  nowrap>
												    <textarea   Class="inputTextarea"   rows="3"  style="width:93%;" readonly name="candidate" id="candidate"  ></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'candidateId', allowName:'candidate', select:'user', single:'no', show:'usergroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
													<input type="hidden" name="candidateId" id="candidateId">
													</td>
												</tr>
												
												
												<!--从选定的范围中选择-->
												<tr>
												   <td>
												       <input onClick="clickParticipantType(this);" value="someScope" type="radio" name="participantType">
													   <s:text name="workflow.newactivityroleselect7"/>  
												    </td>
												</tr>
												
												<tr id="zdzz">
												  <td>
												     <textarea rows="3" readonly="true"  name="participantGivenOrgName" id="participantGivenOrgName" class="inputTextarea">
													 </textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'participantGivenOrg', allowName:'participantGivenOrgName', select:'user', single:'no', show:'orggroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
													 <input type="hidden" name="participantGivenOrg" id="participantGivenOrg">
													 
												  </td>
												</tr>
												<tr>
												  <td height="22">
												     <strong><s:text name="workflow.newactivitydefaultselect"/></strong>
												  </td>
												</tr> 
												
											   <!--由表单中的某个字段值决定-->
												<tr <%=subTypeHidden%> >
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
													     <textarea rows="3" readonly name="allUser"  id="allUser"	class="inputTextarea"></textarea> <a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'allUserId', allowName:'allUser', select:'user', single:'no', show:'usergroup', range:'*0*',key:'code'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
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
																   <%--<div style="margin-left:-1px;margin-top:10px;margin-bottom:9px">
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
											</table>
									 
								</td>
								<td>&nbsp;</td>
							</tr>
							
						    <!--批示意见-->
							<tr>
							    <td  class="td_lefttitle" for='<s:text name="workflow.activitycomment"/>'>
								   <s:text name="workflow.activitycomment"/>：
								</td>
								<td>
								    <select name="nodeCommentField" id="nodeCommentField" onclick="nodeCommentFieldClick(this)">
										 <option value="nullCommentField" selected><s:text name="workflow.newactivitycomment3"/></option>
										 <% if( moduleId_int!=2&&moduleId_int!=3&&moduleId_int!=34){%>
										   <option value="autoCommentField"><s:text name="workflow.newactivitycomment2"/></option>
										 <%}%>
										 <option value=""><s:text name="workflow.newactivitycomment1"/></option>
								    </select>
						            <div style="padding-top:4px;display:none" id="nodeCommentFieldsDiv">
										  <c:forEach items="${nodeCommentFieldList}" var="nodeCommentField">
										    <input value="${nodeCommentField[0]}" type="checkbox" name="nodeCommentFields">${nodeCommentField[1]}
										 </c:forEach>
						           </div>
								</td>
								<td>&nbsp;</td>
							</tr>

							<tr>
							    <td  class="td_lefttitle" for='意见态度设置'>
								   意见态度设置：
								</td>
								<td>
								    <input name="commentAttitudeTypeSet"  checked  type="radio"   value="0">不显示态度
							        <input value="1" type="radio" name="commentAttitudeTypeSet"  >显示同意与不同意
									<input value="2" type="radio" name="commentAttitudeTypeSet"  >显示已阅、同意与不同意
								</td>
								<td>&nbsp;</td>
							</tr> 
							<!--需要阅件-->
							<tr>
							    <td  class="td_lefttitle" for='<s:text name="workflow.newactivityneedreview"/>'>
								   <s:text name="workflow.newactivityneedreview"/>：
								</td>
								<td>
								     <input type="radio" name="taskNeedRead" value="0" checked="checked" onClick="needPassRount(this);"><s:text name="workflow.newactivityneedno"/><!-- 不需要 -->
									 <input type="radio" name="taskNeedRead" value="1" onclick="needPassRount(this);"><s:text name="workflow.newactivityneed"/><!-- 需要 -->
								</td>
								<td>&nbsp;</td>
							</tr>
							
							<tr id="needPassRound_tr" style="display:none">
							   <td  class="td_lefttitle">&nbsp;   
							   
							   </td>
							   <td>    
									<table width="100%" cellpadding="0" cellspacing="0"    style="margin-left:-4px;">
									   <tr>
										   <td height="22" width="98%">
											   <strong><s:text name="workflow.newactivityroleselect"/></strong>
										    </td>
											<td height="22" width="2%">&nbsp;</td>
										</tr>
										<!--从系统角色中指定-->
										<tr>
											<td height="22">
											   <input type="radio" value="systemRole" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);">
											   <s:text name="workflow.newactivityroleselect1"/>
										    </td>
											<td>&nbsp;</td>
										</tr>
										<tr id="passRoundRole" style="display:none">
											<td height="18" colspan="2">
												<table width="100%" border="0" >
												   <tr>
													 <td width="66" nowrap><s:text name="workflow.newactivityroleselect"/><!-- 角色选择 --></td>
													 <td width="370">
														 <select name="passRole"  id="passRole"  >
															  <c:forEach items="${allRoleList}" var="role">
																	<option value="${role[0]}">${role[1]}</option>
															   </c:forEach>
														 </select>
													 </td>
													 <td>
														 <select name="passRoleNexus">
															<option value="0"></option>
															<option value="and">AND</option>
														   </select>
													  </td> 
												   </tr> 
												   <tr nowrap>
													  <td><s:text name="workflow.Organization"/> <!--组织--></td>
													  <td>
														  <select name="passOrg"    id="passOrg"   >
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
													  <td></td>
												   </tr> 
												   <tr   id="passOrgLevelId" name="passOrgLevelId" style="display:none" >
													  <td> <s:text name="workflow.from"/><!-- <s:text name="workflow.OrganizationalLevel"/> --><!-- 组织级别 --></td>
													  <td> 
														   <select name="passOrgLevel">
															 <option value="0">1</option> 
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
														   </select> <!-- 级组织向下寻找 --><s:text name="workflow.Lookingfordownlevelorganization"/>
													  </td> 
													  <td></td>
												   </tr>
												</table>
											</td>
										</tr>
										
										<!--流程启动人-->
										<tr>
											<td>
											   <input type="radio" value="initiator" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);">
											   <s:text name="workflow.newactivityroleselect2"/>&nbsp;&nbsp;
											   <select 	name="taskInitiatorType">
													<option selected value="Initiator"><s:text name="workflow.self"/></option>
													<option value="Leader"><s:text name="workflow.leader"/></option>
													<option value="DepartLeader"><s:text name="workflow.departleader"/></option>
													<option value="ChargeLeader"><s:text name="workflow.chargeleader"/></option>
												</select>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										<!--上一活动办理人的上级领-->
										<tr>
											<td>
											   <input type="radio" value="prevTransactorLeader" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);">
											   <s:text name="workflow.newactivityroleselect3"/>
											     <select name="passprevTraLAnd"  id="passprevTraLAnd" >
													   <option selected value="0"></option>
													   <option value="yu">AND</option>
												  </select>
												  <s:text name="workflow.dutyLevel"/> 
												  <select name="passprevDutyLevelOperate">
													  <option selected value="<">&lt;</option>
													  <option value="<=">&lt;=</option>
													  <option value="<>">≠</option>
													  <option value="=">=</option>
													  <option value=">">&gt;</option>
													  <option value=">=">&gt;=</option>
												  </select>
												  <select name="passprevDutyLevel">
													 <c:forEach items="${dutyList}" var="org">
														<option value="${org[2]}">${org[1]}(${org[2]})</option>
													</c:forEach>
												 </select>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										<!--上一活动办理人的组织及下级组织-->
										<tr>
											<td>
											  <input type="radio" value="prevTransactorOrg" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);">
											  <s:text name="workflow.OrganizationAndLowerLevelOrganizationOfPreviousActivity"/>&nbsp;&nbsp;<s:text name="workflow.from"/><!-- <s:text name="workflow.OrganizationalLevel"/> --><!--组织级别--><!-- ： --><select 	name="lastpassRoundUserOrgLevel"> 
												 <option value="0">1</option> 
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
											<td>&nbsp;</td>
										</tr>
										
											
										<!--上一活动所有参与者-->
										<tr>
											<td>
											   <input type="radio" value="prevTransactors" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);">
											   <s:text name="workflow.newactivityroleselect12"/>
										    </td>
											<td>&nbsp;</td>
										</tr> 


										<!--选中组织-->
										<tr>
											<td>
											   <input onClick="clickPassRoundUserType(this);" value="chooseOrgLeader" type="radio"  name="taskReadParticipantType">
											   <s:text name="workflow.choosedorg"/>&nbsp;&nbsp;
											   <select name="taskChooseOrgLeaderType">
													<option value="orgDepart"><s:text name="workflow.departleader"/></option>
													<option value="orgCharge"><s:text name="workflow.chargeleader"/></option>
												</select>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										
										<!--流程启动人上级组织 AND 职务级别-->
										<tr>
											<td>
												 <input type="radio" value="initiatorLeaderOrg" 	name="taskReadParticipantType" onClick="clickPassRoundUserType(this);">
												 <s:text name="workflow.activitysubmitpersonuporg"/>&nbsp;
												 <select name="passDutyLevelOperate">
													<option value="<" ><!-- 小于 -->&lt;</option>
													<option value="<=" ><!-- 不大于 -->&lt;=</option>
													<option value="<>" ><!-- 不等于 -->≠</option>
													<option value="=" ><!-- 等于 -->=</option>
													<option value=">" ><!-- 大于 -->&gt;</option>
													<option value=">=" ><!-- 不小于 -->&gt;=</option>
												</select>
												<select name="passDutyLevel">
													   <c:forEach items="${dutyList}" var="org">
															<option value="${org[2]}">${org[1]}(${org[2]})</option>
													  </c:forEach>	
												</select>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										<!--用户群组组织-->
										<tr>
										   <td height="22">
											   <strong><s:text name="workflow.newactivityorggroup"/></strong>
										    </td>
											<td width="56%" height="22">&nbsp;</td>
										</tr>
										
										
										<!--从所有用户中选择-->
										<tr>
											<td>
												<input type="radio" value="allUser" name="taskReadParticipantType" checked onClick="clickPassRoundUserType(this);" >
												<s:text name="workflow.newactivityroleselect4"/>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
												
										<!--从选定的群组中选择-->
										<tr>
											<td>
												<input type="radio" value="someGroups" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" >
												<s:text name="workflow.activityallgroup"/>
												<INPUT value="true" type="checkbox" name="passRoundGroupNeedAllSend">默认全部发送
										    </td>
											<td>&nbsp;</td>
										</tr> 

										<!--从选定的群组中选择-->
										<tr id="passRoundxdqz" style="display:none">
											<td colspan="2">
											  <textarea style="width:90%;" class="inputTextarea" rows="3" name="passRoundGivenGroupName" id="passRoundGivenGroupName" readonly="true">
											  </textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRoundGivenGroup', allowName:'passRoundGivenGroupName', select:'group', single:'no', show:'group', range:'*0*',key:'code',showShortcut:'0'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
											  <input type="hidden" name="passRoundGivenGroup" id="passRoundGivenGroup" value=""> 
											  <table> 
												 <tr>
													<td width="100" nowrap>
														<select name="passPartGroupNexus">
															<option selected value="0"></option>
															<option value="yu">AND</option>
														</select>
														<s:text name="workflow.Organization"/>
													 </td>
													 <td>
														<select  name="passPartgGroupOrg"  id="passPartgGroupOrg" >
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
													<tr id="passPartgGroupOrgLevelID" name="passPartgGroupOrgLevelID"  style="display:none">
													  <td colspan="2"><s:text name="workflow.from"/><!-- <s:text name="workflow.OrganizationalLevel"/> --><!-- 组织级别 --><!-- ： -->
														<select name="passPartgGroupOrgLevel">
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
												 <tr id="passaddressTypeSpan" style="display:none" >
												   <td> 办公地点分类：</td>
												   <td>
													  <select  name="passworkAddressType">
														  <option  value="">--<s:text name="workflowAnalysis.PleaseSelect"/>--</option> 
														  <c:forEach items="${addressTypeList}" var="atype">
																<option value="${atype[0]}">${atype[1]}</option>
														  </c:forEach> 
													  </select>
												   </td>
											   </tr> 
											</table>
										 </td>
										</tr>	
										
										<!--从本级组织及其下级组织中选择-->
										<tr>
											<td>
												 <input type="radio" value="orgAndsonOrgs" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" >
												 <s:text name="workflow.newactivityroleselect10"/>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										
										<!--从候选人员中指定-->
										<tr>
											<td>
												<input type="radio" value="someUsers" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" >
												<s:text name="workflow.newactivityroleselect6"/>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										<tr id="passhxr" style="display:none">
											<td>
											 <textarea style="width:90%;" Class="inputTextarea" rows="3" name="passRound_candidate" readonly="true"  id="passRound_candidate"></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRound_candidateId', allowName:'passRound_candidate', select:'user', single:'no', show:'usergroup', range:'*0*',key:'code'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
											 <input type="hidden" name="passRound_candidateId"  id="passRound_candidateId" value="">
											 
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										
										<!--从选定的范围中选择-->
										<tr>
											<td>
												<input type="radio" value="someScope" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" >
												<s:text name="workflow.newactivityroleselect7"/>
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										<!--从选定的范围中选择-->
										<tr id="passRoundzdzz" style="display:none">
											<td>
												<textarea style="width:90%;" class="inputTextarea" rows="3" name="passRoundGivenOrgName" readonly="true" id="passRoundGivenOrgName">
												</textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRoundGivenOrg', allowName:'passRoundGivenOrgName', select:'user', single:'no', show:'orggroup', range:'*0*',key:'code'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
												<input type="hidden" name="passRoundGivenOrg" id="passRoundGivenOrg" value="">
												
										    </td>
											<td>&nbsp;</td>
										</tr>
										
										<!--默认选择-->
										<tr>
										   <td height="22">
											   <strong><s:text name="workflow.newactivitydefaultselect"/></strong>
										    </td>
											<td width="56%" height="22">&nbsp;</td>
										</tr>	
										
										
										<!--由表单中的某个字段值决定-->
										<tr <%=subTypeHidden%> >
											<td>
												 <input type="radio" value="someField" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" >
												 <s:text name="workflow.newactivityroleselect9"/>
												 <span id="passbdzd"  style="display:none" >
													<select name="passRoundUserField" id="passRoundUserField"></select>
												 </span>
										    </td>
											<td>
												
											</td>
										</tr>
										
										<!--指定全部办理人-->
										<tr>
											<td>
												<input type="radio" value="setAllTransactors" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" > 
												<s:text name="workflow.newactivityroleselect8"/>
										    </td>
											<td>&nbsp; </td>
										</tr>
										 
										<tr id="passqbblr" style="display:none">
										   <td>
											  <textarea style="width:90%;" class="inputTextarea" rows="3" name="passRound_allUser" id="passRound_allUser" readonly="true"></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRound_allUserId', allowName:'passRound_allUser', select:'user', single:'no', show:'usergroup', range:'*0*',key:'code'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><span class="MustFillColor">*</span>
											  <input type="hidden" name="passRound_allUserId" id="passRound_allUserId" value=""> 
										    </td>
											<td>&nbsp; </td>
										</tr>	
										
										<!--由接口决定-->
										<tr>
											<td>
												<input type="radio" value="setByInterface" name="taskReadParticipantType" onClick="clickPassRoundUserType(this);" >
												<s:text name="workflow.byTheInterface"/><!--由接口决定-->
										    </td>
											<td>&nbsp; </td>
										</tr>
										<tr id="passRoundUserinterfacetr" style="display:none">
											<td colspan=2>
											  <table width="100%">
												  <tr>
													   <td nowrap><s:text name="workflow.className"/><!-- 接口类名 -->：</td>
													   <td style="width:40%">
														 <input type="text" class="inputText" name="passRoundUserClassName"  id="passRoundUserClassName" style="width:98%" value="">
													   </td>
													   <td nowrap><s:text name="workflow.methodName"/><!-- 接口方法名 -->：</td>
													   <td style="width:40%"> 
														 <input type="text" class="inputText" name="passRoundUserMethodName" id="passRoundUserMethodName" style="width:98%" value="">
													   </td>
													   <td>&nbsp;</td>
												  </tr>
												   <tr>
													   <td nowrap><s:text name="workflow.parameterName"/><!-- 接口参数名 -->：</td>
													   <td> 
														 <input type="text" class="inputText" name="passRoundInpaNames" id="passRoundInpaNames"  style="width:98%" value="">
													   </td>
													   <td nowrap><s:text name="workflow.parameterValue"/><!-- 接口参数值 -->：</td>
													   <td> 
														 <input type="text" class="inputText" name="passRoundInpaValues" id="passRoundInpaValues" style="width:98%" value="">
													   </td>
														<td>
															<%--<div style="margin-left:-1px;margin-top:10px;margin-bottom:9px">
															   <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">     
																   <jsp:param name="onInit"             value="" /> 
																   <jsp:param name="onSelect"             value="" />  
																   <jsp:param name="onUploadProgress"     value="" /> 
																   <jsp:param name="onUploadSuccess"      value="passRoundUserClassNameJs" />
																   <jsp:param name="dir"         value="/WEB-INF/classes/com/whir/ezoffice/formhandler/" />
																   <jsp:param name="uniqueId"    value="passRoundUserClassNameUpload" />
																   <jsp:param name="realFileNameInputId"    value="passRoundUserClassName" /> 
																   <jsp:param name="saveFileNameInputId"    value="passRoundUserClassName" />
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
														  </div>  --%>
														</td>
													</tr>
												</table> 
											</td>
										  </tr>		 
									</TABLE>
										 
							   </td>
							   <td>&nbsp;</td>
							</tr>
							
							
							<!--阅件意见-->
							<tr id="needPassRoundTR"  style="display:none" >
							    <td  class="td_lefttitle" for='<s:text name="workflow.activityreviewcomment"/>'>
								   <s:text name="workflow.activityreviewcomment"/>：
								</td>
								<td>
								     <table border="0" cellpadding="0" cellspacing="0" style="margin-left:-4px;">
										<tr>
										   <td nowrap="nowrap" colspan="3">
										      <select name="passNodeCommentField" onclick="passRoundCommFieldSel_ck(this)">
												 <option value="nullCommentField" selected ><s:text name="workflow.newactivitycomment3"/></option>
												 <% if( moduleId_int!=2&&moduleId_int!=3&&moduleId_int!=34){%>
												   <option value="autoCommentField"><s:text name="workflow.newactivitycomment2"/></option>
												 <%}%> 
												 <option value="" ><s:text name="workflow.newactivitycomment1"/></option>
											  </select>
										 </tr>
										<tr>
											 <td>
											     <div style="padding-top:4px;display:none" id="passNodeCommentFieldsDiv">
												      <c:forEach items="${nodeCommentFieldList}" var="nodeCommentField">
														 <input  value="${nodeCommentField[0]}"  type="checkbox" name="passNodeCommentFields">${nodeCommentField[1]}
													  </c:forEach>
												 </div> 
											 </td>
										</tr>	
									 </table>
								</td>
								<td>&nbsp;</td>
							</tr> 
						    <tr>
								<td  align="left" valign="top"   nowrap class="td_lefttitle" ><s:text name="workflow.newactivitycommentcheck"/>：</td>
								<td><input type="hidden" name="commentRangeEmpId" id="commentRangeEmpId" value=""><textarea name="commentRangeEmpName" id="commentRangeEmpName"   rows="3" class="inputTextarea"  style="width:95%" readonly></textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'commentRangeEmpId', allowName:'commentRangeEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a> 
							 </td>
							 <td >&nbsp;</td>
						    </tr>
						    <tr> 
								<td  align="left" valign="top" class="td_lefttitle" ><s:text name="workflow.newactivityadvancedsetting"/><!-- 高级设置 -->：</td>
								<td>
								    <INPUT value="true" type="checkbox" name="nodeNeedAgent"><s:text name="workflow.newactivityreplacement"/><!-- 允许代办 --> 
									<c:if test="${noteRemind == 'true'}"> 
									  <input type="checkbox"  value="" name="noteRemindType" onClick="if(this.checked) {$('#noteRemindTypeSpan').show();}else{$('#noteRemindTypeSpan').hide();} "><bean:message bundle="workflow" key="workflow.activitysmsremind"/>
									  <span id="noteRemindTypeSpan" style="display:none">
									     <input type="radio" checked name="noteRemindTypeValue" value="defaultCheck"><s:text name="workflow.defaultcheck"/><!-- 默认提醒--><input type="radio"  name="noteRemindTypeValue" value="defaultNoCheck"><s:text name="workflow.defaultnotcheck"/><!-- 默认不提醒 -->
									  </span>
									</c:if>
									<INPUT value="true" type="checkbox" name="commentRangeByDealUser"><!-- 办理人设置审批意见查看范围 --><s:text name="workflow.Thetransactorsetviewrange"/>
									<INPUT value="true" type="checkbox" name="processDealUserWithRepeat">办理人重复时自动跳过
								 </td>
								 <td></td>		
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
						  <table width="99%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0" id="fieldTable"  style="margin-left:4px;margin-right:4px;margin-top:4px;">
						   <tbody>
						      <tr>
									<!--<td width="120" align="center" valign="top" bgcolor="#F0F0F0" class="table_linebottom">读字段</td>-->
									<td width="120px" bgcolor="#F0F0F0" align="left" class="table_linebottom">
									   <b><s:text name="workflow.newactivitysourcefield"/><!-- 字段名称 --></b>
									</td>
									<td width="1%"  bgcolor="#F0F0F0" align="center" class="table_linebottom">
									    <input type="checkbox" onClick="selectAllField(this,'nodeWriteField')">
									</td>
									<td width="20%" align="left" valign="middle" bgcolor="#F0F0F0" class="table_linebottom">
									     <b><s:text name="workflow.newactivitywritefield"/><!-- 写字段 --></b>
									</td>
									<td width="1%"  bgcolor="#F0F0F0" align="center" class="table_linebottom">
									   <input type="checkbox" onClick="selectAllField(this,'nodeProtectedField')">
									</td>
									<td width="20%" align="left" valign="middle" bgcolor="#F0F0F0" class="table_linebottom">
									   <b><s:text name="workflow.newactivitysignaturefield"/><!-- 签章保护字段 --></b>
									</td>
									<td width="1%"  bgcolor="#F0F0F0" align="center" class="table_linebottom">
									   <input type="checkbox" onClick="selectAllField(this,'nodeHiddenField')">
									</td>
									<td width="20%" align="left" valign="middle" bgcolor="#F0F0F0" class="table_linebottom">
									    <b><s:text name="workflow.HiddenField"/><!-- 隐藏字段 --></b>
									</td>
									<td  align="left" valign="middle" bgcolor="#F0F0F0" class="table_linebottom"></td>
								</tr> 
								<tr  class="Table_nobttomline">
								   <td colspan="8">
								    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<input type="button" class="btnButton4font" onClick="save('trueModify');" value='<s:text name="comm.saveclose"/>' />  
									<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
									<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>'/>  
								   </td>
							   </tr>
							   </tbody>
						   </table> 	  
			            </div>
						
						<div id="docinfo2" style="display:none;"> 
						  <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0"  style="margin-left:4px;margin-top:4px;">
						       <tr>
                                 <td colspan="2" align="left">
                                  <s:text name="workflow.newactivitybuttonall"/>：<input type="checkbox" name="sa" onClick="selectAllBtn(this)" >
                                 </td>
                              </tr>
							  <tr>
							    <td colspan="2"><B><s:text name="workflow.newactivitybuttonworkflow"/></B></td>
							  </tr>
							  
							  <tr>
							    <td width="55%">
								  <INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowBackTask" onClick="checkBackButton()" ><IMG SRC="images/toolbar/back.png" align="absmiddle" width="24" height="24">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonback"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】<!-- 退回【待办按钮】 -->        
							    </td>
		  		                <td width="45%">
								   <INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowAbandon"><IMG SRC="images/toolbar/delete.png" align="absmiddle" width="24" height="24">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonvoid"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】<!-- 作废【待办按钮】 -->           
								</td>
        		            </tr>
				            <tr id="backMailRangeTR"  style="display:none">
				               <td colspan="2">
                                  <div style="padding-left:66px;">
									  <s:text name="workflow.mailRange"/><!-- 邮件提醒范围 -->： <INPUT TYPE="radio" NAME="EzFlowBackTask" value="0"   checked><s:text name="workflow.ReturnPartOfManagers"/><!-- 退回环节经办人 --><INPUT TYPE="radio" NAME="EzFlowBackTask" value="1"  ><s:text name="workflow.AllParticipator"/><!-- 所有经办人 -->
							     </div>
				               </td>
							</tr>
							
							<tr>
		  		               <td>
							     <INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowTransfer" onClick="showTranTR();"><IMG SRC="images/toolbar/transend.png" align="absmiddle" width="24" height="24">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonshift"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】<!-- 转办【待办按钮】 -->&nbsp;&nbsp;
								  <input type="checkbox" value="1" name="autoTranReturn"  ><bean:message bundle="workflow" key="workflow.Automaticallyreturn"/><!-- 自动返回 -->
							   </td>
							   <td> 
							       <INPUT TYPE="checkbox" NAME="operButton" onClick="clickSelfsend();"  value="EzFlowSendReadTask"><IMG SRC="images/toolbar/view.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonreview"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】<!-- 阅件【待办按钮】 --></td>
        	                </tr>
							<tr id="tranTR" style="display:none">
								<td colspan="2">
								    <div style="padding-left:66px;">
									  <bean:message bundle="workflow" key="workflow.activitytranrange"/><!-- 转办范围 -->：
									  <INPUT TYPE="radio" NAME="EzFlowTransfer"  value="0" onClick="showTranTR();"><s:text name="workflow.activitytranall"/><!-- 全部 -->
									  <INPUT TYPE="radio" NAME="EzFlowTransfer"   value="1" onClick="showTranTR();"><s:text name="workflow.activitytranorg"/><!-- 本部门 -->
									  <INPUT TYPE="radio" NAME="EzFlowTransfer"   value="2" onClick="showTranTR();" style="display:none">
									  <INPUT TYPE="radio" NAME="EzFlowTransfer"  checked value="3" onClick="showTranTR();"><s:text name="workflow.activitytranperson"/><!-- 本活动办理人 -->
									  <INPUT TYPE="radio" NAME="EzFlowTransfer"   value="4" onClick="showTranTR();"><s:text name="workflow.activitytrandiy"/><!-- 自定义 -->
								      <span id="tranCustomTR">
									       <INPUT TYPE="text" NAME="EzFlowTransferCustomExtent" id="EzFlowTransferCustomExtent" value="" class="inputText"  readonly="true"  style="width:50%" ><a href="#" class="selectIco" onclick="openSelect({allowId:'EzFlowTransferCustomExtentId', allowName:'EzFlowTransferCustomExtent', select:'orggroup', single:'no', show:'orggroup', range:'*0*',key:'code', showPersonalGroup:'0'});return  false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										   <input type="hidden" name="EzFlowTransferCustomExtentId" id="EzFlowTransferCustomExtentId" value="">
								      </span>
								    </div>
								</td>
							 </tr>
							 
							 <tr>
								<td>
								   <INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowAddSignTask" onClick="showAddSignTR();"><IMG SRC="images/toolbar/adds.png" align="absmiddle" width="24" height="24">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.addsign"/><!--加签-->【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
								</td>
								<td>
								   <INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowRelationProcess"><IMG SRC="images/toolbar/relation.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.Relatedworkflow"/><!--关联流程-->【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
								</td>
							 </tr>
							 
						     <tr id="addSignTR"  style="display:none">
				                 <td colspan="2">
								   <div style="padding-left:66px;">
								     <s:text name="workflow.addsignRange"/><!-- 加签范围 -->：
									 <INPUT TYPE="radio" NAME="EzFlowAddSignTask"  value="0" onClick="showAddSignTR();"><s:text name="workflow.activitytranall"/><!-- 全部 -->
									 <INPUT TYPE="radio" NAME="EzFlowAddSignTask"   value="1" onClick="showAddSignTR();"><s:text name="workflow.activitytranorg"/><!-- 本部门 -->
									 <INPUT TYPE="radio" NAME="EzFlowAddSignTask"   value="2" onClick="showAddSignTR();" style="display:none">
									 <INPUT TYPE="radio" NAME="EzFlowAddSignTask"  checked value="3" onClick="showAddSignTR();"><s:text name="workflow.activitytranperson"/><!-- 本活动办理人 -->
									 <INPUT TYPE="radio" NAME="EzFlowAddSignTask"   value="4" onClick="showAddSignTR();"><s:text name="workflow.activitytrandiy"/><!-- 自定义 -->
									 <span id="addSignCustomTR">
									     <INPUT TYPE="text" NAME="EzFlowAddSignTaskCustomExtent" id="EzFlowAddSignTaskCustomExtent" value="" class="inputText"   readonly="true"  style="width:50%" ><a href="#" class="selectIco" onclick="openSelect({allowId:'EzFlowAddSignTaskCustomExtentId', allowName:'EzFlowAddSignTaskCustomExtent', select:'orggroup', single:'no', show:'orggroup', range:'*0*',key:'code', showPersonalGroup:'0'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <input type="hidden" name="EzFlowAddSignTaskCustomExtentId" id="EzFlowAddSignTaskCustomExtentId" value="">	
									 </span>
                                  </div>
				                </td>
                             </tr>
							 
							 <tr>
							    <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowTranRead" onClick="showTranReadTR();"><IMG SRC="images/toolbar/tranview.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.Transferforreview"/>【<bean:message bundle="workflow" key="workflow.Waitingtoreviewbutton"/>】</td>
							    <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowReCall"><IMG SRC="images/toolbar/undo.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttondrawback"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】</td>
						     </tr>
							 
							 <tr id="tranReadTR"  style="display:none">
								<td colspan="2">
								  <div style="padding-left:66px;">
								      <bean:message bundle="workflow" key="workflow.Scopeoftransferforreviewing"/><!-- 转阅范围 -->：
									  <INPUT TYPE="radio" NAME="EzFlowTranRead"  value="0" onClick="showTranReadTR();"><s:text name="workflow.activitytranall"/><!-- 全部 --> 
									  <INPUT TYPE="radio" NAME="EzFlowTranRead"   value="1" onClick="showTranReadTR();"><s:text name="workflow.activitytranorg"/><!-- 本部门 --> 
									  <INPUT TYPE="radio" NAME="EzFlowTranRead"   value="2" onClick="showTranReadTR();" style="display:none">
								      <INPUT TYPE="radio" NAME="EzFlowTranRead"  checked value="3" onClick="showTranReadTR();"><bean:message bundle="workflow" key="workflow.CurrentReviewer"/><!-- 本活动阅件人 -->
									  <INPUT TYPE="radio" NAME="EzFlowTranRead"   value="4" onClick="showTranReadTR();"><s:text name="workflow.activitytrandiy"/>
									  <span id="tranReadCustomTR">
									     <INPUT TYPE="text" NAME="EzFlowTranReadCustomExtent" id="EzFlowTranReadCustomExtent" value="" class="inputText"   readonly style="width:50%"><a href="#" class="selectIco" onclick="openSelect({allowId:'EzFlowTranReadCustomExtentId', allowName:'EzFlowTranReadCustomExtent', select:'org', single:'no', show:'org', range:'*0*',key:'code', showPersonalGroup:'0'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
								         <input type="hidden" name="EzFlowTranReadCustomExtentId" id="EzFlowTranReadCustomExtentId" value=""> 
								    </span>
								   </div>
								</td>
							  </tr>
  
							  <tr>
							    <td><INPUT TYPE="checkbox" NAME="operButton"  value="EdAddSign" onClick="showEdAddSignTR();"><IMG SRC="images/toolbar/adds.png">&nbsp;&nbsp;<!-- 补签 --><bean:message bundle="workflow" key="workflow.EdAddSign"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】</td>
							    <td><INPUT TYPE="checkbox" NAME="operButton"  value="CancelTran"><IMG SRC="images/toolbar/undo.png">&nbsp;&nbsp<!-- 转办撤办 --><bean:message bundle="workflow" key="workflow.CancelTran"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】</td>
						     </tr>
							 
							  <tr id="edaddSignTR"  style="display:none">
				                 <td colspan="2">
								   <div style="padding-left:66px;">
								     <!-- <s:text name="workflow.addsignRange"/> -->补签范围<!-- 加签范围 -->：
									 <INPUT TYPE="radio" NAME="EdAddSign"  value="0" onClick="showEdAddSignTR();"><s:text name="workflow.activitytranall"/><!-- 全部 -->
									 <INPUT TYPE="radio" NAME="EdAddSign"   value="1" onClick="showEdAddSignTR();"><s:text name="workflow.activitytranorg"/><!-- 本部门 -->
									 <INPUT TYPE="radio" NAME="EdAddSign"   value="2" onClick="showEdAddSignTR();" style="display:none">
									 <INPUT TYPE="radio" NAME="EdAddSign"  checked value="3" onClick="showEdAddSignTR();"><s:text name="workflow.activitytranperson"/><!-- 本活动办理人 -->
									 <INPUT TYPE="radio" NAME="EdAddSign"   value="4" onClick="showEdAddSignTR();"><s:text name="workflow.activitytrandiy"/><!-- 自定义 -->
									 <span id="edaddSignCustomTR">
									     <INPUT TYPE="text" NAME="EdAddSignCustomExtent" id="EdAddSignCustomExtent" value="" class="inputText"   readonly="true"  style="width:50%" ><a href="#" class="selectIco" onclick="openSelect({allowId:'EdAddSignCustomExtentId', allowName:'EdAddSignCustomExtent', select:'orggroup', single:'no', show:'orggroup', range:'*0*',key:'code', showPersonalGroup:'0'}); return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <input type="hidden" name="EdAddSignCustomExtentId" id="EdAddSignCustomExtentId" value="">	
									 </span>
                                  </div>
				                </td>
                             </tr> 

							  <tr>
								 <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowFeedback"><IMG SRC="images/toolbar/feedback.png" align="absmiddle" >&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonfeedback"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】</td>
								 <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowDrwaBack"><IMG SRC="images/toolbar/drawback.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonrecycle"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinishedfinished"/>】</td>
        		              </tr>
							  <tr>
								 <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowCancel"><IMG SRC="images/toolbar/cancel.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.Cancel"/>【<bean:message bundle="workflow" key="workflow.Buttonofmydocumentinprocessing"/>】</td>
								 <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowNewProcess"><IMG SRC="images/toolbar/addnew.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="information" key="info.newProcess"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】</td>
							  </tr>
							  
							  <tr>
								 <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowPress"><IMG SRC="images/toolbar/press.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonurge"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】</td>
								 <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowTranWithMail"><IMG SRC="images/toolbar/tranmail.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="information" key="info.emailSend"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】</td>
							  </tr>
							  <tr>
								  <td><INPUT TYPE="checkbox" NAME="operButton"  value="EzFlowPrint"><IMG SRC="images/toolbar/print.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonprint"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】</td>
								  <td>
								  <%if(moduleId_int==1||moduleId_int==2||moduleId_int==3||moduleId_int==34){%>
								  <INPUT TYPE="checkbox" NAME="operButton"  value="SynToInfo"><IMG SRC="images/toolbar/syncinfo.png" align="absmiddle">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.SynToInfo"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】<%
								  }%> </td>
							  </tr>  
 
							   <%
							      if( moduleId_int==2||moduleId_int==3||moduleId_int==34||(moduleId_int>200&&moduleId_int<300)){
							   %>
								  <!---公文按钮--->
								  <tr height="1">
									  <td colspan="2"> <table width="100%" border="0" cellpadding="0" cellspacing="0">
										  <tr height="1" bgcolor="#808080">
											<td height="1"  style="padding:0px 0 0px 0;"></td>
										  </tr>
										  <tr height="1"  bgcolor="#FFFFFF">
											<td height="1"  style="padding:0px 0 0px 0;"></td>
										  </tr>
										</table>
									 </td>
								  </tr>
								  <tr>
									<td colspan="2"><B>公文按钮</B></td>
								  </tr>  			 
								  <tr>	 
									  <td><INPUT TYPE="checkbox" NAME="operButton"  value="cmdGovUnionTask"><IMG SRC="images/toolbar/addunion.png">&nbsp;&nbsp;加入督办任务【待办按钮】</td>
									  <td>&nbsp;&nbsp;</td>
								  </tr>
								<%}%>
								<%
							      if( moduleId_int==2||(moduleId_int>=260&&moduleId_int<300)){
							    %> 
								  <!--//发文按钮-->
								  <tr height="1">
										<td colspan="2"> 
											<table width="100%" border="0" cellpadding="0" cellspacing="0">
												 <tr height="1" bgcolor="#808080">
												   <td height="1"  style="padding:0px 0 0px 0;"></td>
												</tr>
												<tr height="1"  bgcolor="#FFFFFF">
												   <td height="1"  style="padding:0px 0 0px 0;"></td>
												</tr>
											</table>
									   </td>
								  </tr>
								  <tr>
									   <td colspan="2">
										   <B>发文按钮</B>
									   </td>
								  </tr>
								  <tr>
										 <td>
											<INPUT TYPE="checkbox" NAME="operButton"  value="Writetext"><IMG SRC="images/toolbar/writetext.gif">&nbsp;&nbsp;起草正文【待办按钮】
										 </td>
										 <td>
											<INPUT TYPE="checkbox" NAME="operButton"  value="Readtext"><IMG SRC="images/toolbar/readtext.gif">&nbsp;&nbsp;批阅正文【待办按钮】
										 </td>
								 </tr>
								 <tr>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="Savefile"><IMG SRC="images/toolbar/savefile.gif">&nbsp;&nbsp;生成正式文件【待办按钮】</td>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="Code"><IMG SRC="images/toolbar/code.gif">&nbsp;&nbsp;编号【待办按钮】
										</td>
								  </tr>
								 <tr>
										<td><INPUT TYPE="checkbox" NAME="operButton" value="Sendclose"  onClick="showDispenseTR();"><IMG SRC="images/toolbar/documentSend.gif">&nbsp;&nbsp;分发【待办按钮】</td>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="Toreceive"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转收文【通用按钮】
										</td>
								 </tr> 
								 <tr id="dispenseTR" style="display:none" >
										<td colspan="2">
										<div style="padding-left:66px;">分发范围：
										<INPUT TYPE="radio" NAME="Sendclose" value="0" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytranall"/>
										<INPUT TYPE="radio" NAME="Sendclose" value="1" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytranorg"/>
										<INPUT TYPE="radio" NAME="Sendclose" value="2" onClick="showDispenseTR();" style="display:none">
										<INPUT TYPE="radio" NAME="Sendclose" checked value="3" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytranperson"/>
										<INPUT TYPE="radio" NAME="Sendclose" value="4" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytrandiy"/>
										<span id="dispenseCustomTR"><INPUT TYPE="text" name="SendcloseCustomExtent"  id="SendcloseCustomExtent"   class="inputText"   readonly  style="width:50%" ><a href="#" class="selectIco" onclick="openSelect({allowId:'SendcloseCustomExtentId', allowName:'SendcloseCustomExtent', select:'orggroup', single:'no', show:'orggroup', range:'*0*',key:'code', showPersonalGroup:'0' }); return fasle;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><input type="hidden" name="SendcloseCustomExtentId" id="SendcloseCustomExtentId"  >
										</span>
										 </div>
										</td>
								   </tr>
								   <tr>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="Tocheck"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转文件送审签【通用按钮】</td>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="GovExchange"><IMG SRC="images/toolbar/govexchange.png">&nbsp;&nbsp;公文交换【通用按钮】</td>
								  </tr>
								  <tr>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="Viewtext"><IMG SRC="images/toolbar/viewtext.gif">&nbsp;&nbsp;查看正文【通用按钮】</td>
										<td><INPUT TYPE="checkbox" NAME="operButton"  value="ReSavefile"><IMG SRC="images/toolbar/worddue.png">&nbsp;&nbsp;再次套红【待办按钮】</td> 
								  </tr>
								 <%}%>
								 <%
							      if( moduleId_int==3||(moduleId_int>=230&&moduleId_int<230)){
							     %> 
								  <!--//收文按钮-->
								  <tr height="1">
									   <td colspan="2">
										   <table width="100%" border="0" cellpadding="0" cellspacing="0">
												  <tr height="1" bgcolor="#808080">
													<td height="1"  style="padding:0px 0 0px 0;"></td>
												  </tr>
												  <tr height="1"  bgcolor="#FFFFFF">
													<td height="1"  style="padding:0px 0 0px 0;"></td>
												  </tr>
										   </table>
										</td>
								  </tr>
								  <tr>
										<td colspan="2"><B>收文按钮</B></td>
								  </tr>
								  <tr>
										<td><INPUT TYPE="checkbox" NAME="operButton" value="Tosend"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转发文【通用按钮】</td>
										<td><INPUT TYPE="checkbox" NAME="operButton" value="Tocheck"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转文件送审签【通用按钮】</td>			
								 </tr>
								 <%}%>
								 <%
							      if( moduleId_int==34||(moduleId_int>200&&moduleId_int<229)){
							     %> 
								  <tr height="1">
									  <td colspan="2">
										   <table width="100%" border="0" cellpadding="0" cellspacing="0">
												  <tr height="1" bgcolor="#808080">
													<td height="1"  style="padding:0px 0 0px 0;"></td>
												  </tr>
												  <tr height="1"  bgcolor="#FFFFFF">
													<td height="1"  style="padding:0px 0 0px 0;"></td>
												  </tr>
											</table>
									  </td>
								  </tr>
								  <tr>
									   <td colspan="2"><B>文件送审签按钮</B></td>
								  </tr>
								  <tr>
										<td><INPUT TYPE="checkbox" NAME="operButton" value="Writetext"><IMG SRC="images/toolbar/writetext.gif">&nbsp;&nbsp;起草正文【待办按钮】</td>
										<td><INPUT TYPE="checkbox" NAME="operButton" value="Readtext"><IMG SRC="images/toolbar/readtext.gif">&nbsp;&nbsp;批阅正文【待办按钮】</td>
								   </tr>
								   <!-- <tr>
										 <td><INPUT TYPE="checkbox" NAME="operButton" value="Savefile"><IMG SRC="images/toolbar/savefile.gif">&nbsp;&nbsp;生成正式文件【待办按钮】</td>
										 <td>&nbsp;</td> 
									</tr> -->
								<%}%>
								<%
								  com.whir.service.api.ezflowservice.EzFlowButtonService  buttonService=new  com.whir.service.api.ezflowservice.EzFlowButtonService(); 
								 java.util.List extButtonsList=buttonService.getAllbuttonIds("");
								 if(extButtonsList!=null&&extButtonsList.size()>0){
									  int  extButtonsListSize=extButtonsList.size();
									  int  nowTdIndex=1;
									  Object extButtonArr[]=null;				   
							   %>
								<tr>
									<td colspan="2"><B><s:text name="workflow.trandiyButton"/></B></td>
								</tr>
								<%
									 for(int jj=0;jj<extButtonsListSize;jj++){ 
									    extButtonArr=(String [])extButtonsList.get(jj);
									    if(nowTdIndex==1){ 
										  out.print("<tr>");
										}
								%>
								<td><INPUT TYPE="checkbox" NAME="operButton" value="<%=extButtonArr[0]%>"><IMG SRC="<%=extButtonArr[3]%>"   align="absmiddle" width="24" height="24"  >&nbsp;&nbsp;<%=extButtonArr[1]%></td>
								<%  
								    if(nowTdIndex==2){
										nowTdIndex=1;
										out.print("</tr>");  
									  }else{
										nowTdIndex=2;
									  } 
							      } 	 
								  if(nowTdIndex==2){
								%>
								    <td>&nbsp;&nbsp;</td> 
								  </tr>
								<%
									} 
								}
								%>  
                                <tr>
								  <td colspan="2">
								    <table>
										<tr  class="Table_nobttomline">
										   <td class="td_lefttitle" >&nbsp;</td>
										   <td nowrap>&nbsp;&nbsp;&nbsp;<input type="button" class="btnButton4font" onClick="save('trueModify');" value='<s:text name="comm.saveclose"/>' /> <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />   <input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>'/>  
										   </td>
										</tr>
									 </table>
								  </td>
								</tr> 
						   </table> 	  
			            </div>  
					 
						<div id="docinfo3" style="display:none;">
				          <!--接口-->
						  <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0" id="fieldTable"  style="margin-left:4px;margin-top:4px;" >
						      <tr>
								 <td width="150px"  align="left"   class="td_lefttitle" for='<s:text name="workflow.newactivityworkflowmethod"/>'>
								     <s:text name="workflow.newactivityworkflowmethod"/><!-- 表单保存数据方法名 -->：
								 </td>
								 <td  valign="middle" class="table_linebottom">
									 <input type="text" style="width:70%;"  name="formUpdateData" id="formUpdateData" class="inputText"  value=""  whir-options="vtype:['notempty',{'maxLength':25}]"> 
									 <span class="MustFillColor"><s:text name="workflow.newactivityspecialwarning"/></span>
							     </td>
							  </tr>
							  <tr style="display:none">
								  <td  class="td_lefttitle" for='接口保存数据方法名'>接口保存数据方法名：</td>
								  <td  valign="middle" class="table_linebottom">
									 <input type="text" style="width:70%;"  name="formUpdateStatus"  id="formUpdateStatus" class="inputText" value=""  whir-options="vtype:['notempty',{'maxLength':25}]">
									 <span class="MustFillColor"><s:text name="workflow.newactivityspecialwarning"/></span>
								  </td>
							  </tr>
							  <tr>
								  <td class="td_lefttitle" for='<s:text name="workflow.newactivityreturnmethod"/>'><s:text name="workflow.newactivityreturnmethod"/><!-- 表单退回数据方法名 -->：</td>
								  <td  valign="middle" class="table_linebottom">
									 <input type="text" style="width:70%;"  name="formBackData" id="formBackData" class="inputText"  value=""  whir-options="vtype:['notempty',{'maxLength':25}]">
									 <span class="MustFillColor"><s:text name="workflow.newactivityspecialwarning"/></span>
								  </td>
							  </tr>
							  <tr style="display:none">
								  <td class="td_lefttitle" for='接口退回数据方法名'>接口退回数据方法名：</td>
								  <td> 
								      <input type="text" style="width:70%;"  name="formBackStauts"  id="formBackStauts" class="inputText" maxlength="25" value="" whir-options="vtype:['notempty',{'maxLength':25}]">
									  <span class="MustFillColor"><s:text name="workflow.newactivityspecialwarning"/></span>
								  </td>
							 </tr>
							  <tr>
								  <td    colspan="2" class="td_lefttitle"><b><s:text name="workflow.set_dealwithjsmethod"/></b></td>
							  </tr>
							  <tr>
								 <td class="td_lefttitle"  for='<s:text name="workflow.set_loadjsmethod"/>'><s:text name="workflow.set_loadjsmethod"/><!-- 页面加载方法名 -->：</td>
								 <td  valign="middle" class="table_linebottom">
									 <input type="text" style="width:70%;"  name="forminitJsFunName_text" id="forminitJsFunName_text"   class="inputText"  value=""  whir-options="vtype:[{'maxLength':25}]">  
							     </td>
							  </tr>
							  <tr>
								 <td  class="td_lefttitle"  for='<s:text name="workflow.set_updatejsmethod"/>'><s:text name="workflow.set_updatejsmethod"/><!-- 页面保存方法名 -->：</td>
								 <td  valign="middle" class="table_linebottom">
									 <input type="text" style="width:70%;"  name="formsaveJsFunName_text" id="formsaveJsFunName_text" class="inputText"  value="" whir-options="vtype:[{'maxLength':25}]" > 
								 </td>
							  </tr> 
							  <tr  class="Table_nobttomline">
								   <td class="td_lefttitle" >&nbsp;</td>
								   <td >
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
 initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<s:text name="comm.save1"/>'});
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//	
function MM_openBrWindow(theURL,winName,features) { //v2.0
   window.open(encodeURI(theURL),winName,features);
}
 
 
 

$(document).ready(function(){
	//过期处理类型事件
	$("input[name='overdueDealType'][value=',autoDeal,']").click(function(){
		if(this.checked){
			$("input[name='overdueDealType'][value=',autoTran,']").attr("disabled",true);
		}else{
			$("input[name='overdueDealType'][value=',autoTran,']").removeAttr("disabled");
		}
		setCheckStyle();
	});

	$("input[name='overdueDealType'][value=',autoTran,']").click(function(){
		if(this.checked){
			$("input[name='overdueDealType'][value=',autoDeal,']").attr("disabled",true);
		}else{
			$("input[name='overdueDealType'][value=',autoDeal,']").removeAttr("disabled");
		}
		setCheckStyle();
	});
	
	
	/*$("#formKey").combobox({ 
		onChange: function (now,old) { 
			changerFormKey(now);	 
		} 
    }); */
});

</script>
</html>

