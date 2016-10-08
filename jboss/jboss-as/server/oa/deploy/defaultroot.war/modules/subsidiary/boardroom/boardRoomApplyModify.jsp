<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomEquipmentPO" %>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomPO" %>
<%@ page import="com.whir.ezoffice.boardroom.bd.BoardRoomBD" %>
<%@ page import="com.whir.ezoffice.message.action.ModelSendMsg"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardroomMeetingTimePO" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	com.whir.ezoffice.boardroom.po.BoardRoomApplyPO boardRoomApplyPO=null;
	if(request.getAttribute("boardRoomApplyPO") !=null){
		boardRoomApplyPO = (com.whir.ezoffice.boardroom.po.BoardRoomApplyPO)request.getAttribute("boardRoomApplyPO");
    }
	
    String userId = session.getAttribute("userId").toString();
    String userName = session.getAttribute("userName").toString();
	String orgId = session.getAttribute("orgId").toString();
	String orgName = session.getAttribute("orgName").toString();
	String domainId = session.getAttribute("domainId").toString();

    String boardroomFileName = "";
	if(request.getAttribute("boardroomFileName") !=null){
		boardroomFileName = request.getAttribute("boardroomFileName").toString();
	}

    String boardroomSaveName = "";
	if(request.getAttribute("boardroomSaveName") !=null){
		boardroomSaveName = request.getAttribute("boardroomSaveName").toString();
	}

    String emphasis ="0";
	emphasis = request.getAttribute("emphasis")==null?"0":request.getAttribute("emphasis").toString();
	emphasis = "1";
    
    String bdroomAppTypeId = "";
	if(request.getAttribute("bdroomAppTypeId") !=null){
		bdroomAppTypeId = request.getAttribute("bdroomAppTypeId").toString();
	}

	String boardroomApplyId = "";
	if(request.getAttribute("boardroomApplyId") !=null){
		boardroomApplyId = request.getAttribute("boardroomApplyId").toString();
	}

	String boardroomId = "";
	if(request.getAttribute("boardroomId") !=null){
		boardroomId = request.getAttribute("boardroomId").toString();
	}

	String boardEquipment = boardRoomApplyPO.getBoardEquipment()==null?"":boardRoomApplyPO.getBoardEquipment();
	String isVideo ="0";
	isVideo = request.getAttribute("isVideo")==null?"0":request.getAttribute("isVideo").toString();

	String meetingId = "";
	if(request.getParameter("meetingId") !=null){
		 meetingId = request.getParameter("meetingId");
	}

    java.util.Date applyDate = new java.util.Date();
	if(request.getAttribute("applyDate") !=null){
		applyDate = (java.util.Date)request.getAttribute("applyDate");
	}
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	String curModiFields=request.getAttribute("p_wf_cur_ModifyField")==null?"":request.getAttribute("p_wf_cur_ModifyField").toString();
	String m_address="";
	boolean isTempAddress = false;
	if(boardroomId!=null&&!"".equals(boardroomId)&&!"null".equals(boardroomId)){
		BoardRoomPO poo = new BoardRoomBD().selectBoardroom(new Long(boardroomId));
		String __isVideo = poo.getIsVideo()+"";
		if("2".equals(__isVideo))isTempAddress=true;//临时会议
		m_address=poo.getLocation()!=null?poo.getLocation():"";
	}

	String p_wf_openType = request.getParameter("p_wf_openType")==null?"":request.getParameter("p_wf_openType").toString();
	// reStart重新发起
	// startAgain再次发起
	
    boolean canModifyDate = true;
    String resubmit = "";
    if ("reStart".equals(p_wf_openType)) {
        resubmit = "1";
        canModifyDate = true;
    }else{ 
        canModifyDate = false;
	}
    Calendar now = Calendar.getInstance();
    java.util.List officelist = new com.whir.ezoffice.workflow.newBD.WorkFlowBD().getOffiDict(session.getAttribute("userId").toString(), session.getAttribute("domainId").toString());

	String meetingAttendance =boardRoomApplyPO.getMeetingAttendance()==null?"":boardRoomApplyPO.getMeetingAttendance().toString();;
	String attendancetype =boardRoomApplyPO.getAttendancetype()==null?"":boardRoomApplyPO.getAttendancetype().toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改使用记录</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <style TYPE="text/css">
	<!--
	#receiveForm{
		background-color:#000000;
	}
	.receiveForm td{
		font-size:12px;
		background-color:#ffffff;
	}
	.doc_Content{ padding:20px 0px;}
	.doc_Content td{ padding:5px;}
	#noteDiv {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
		background-color:#ffffff;
	}
	#noteDiv1 {
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
		padding-left:0px;
	}
	.divOut{
		background-color:#ffffff;
		color:#000000;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:0px;
	}
	//-->
	</style>
</head>
<body  onload="initBody();"class="Pupwin" >
<div class="BodyMargin_10" >  
	<div class="docBoxNoPanel">
    <!--包含头部--->
    <s:form name="dataForm" id="dataForm" action="${ctx}/boardRoom!modifyBoardroomApply.action" method="post" theme="simple" >
		<!--表单包含页-->
		<table width="100%" border="0" cellpadding="2" cellspacing="1" class="Table_bottomline">
			<s:hidden name="boardRoomApplyPO.boardroomApplyId" id="boardroomApplyId"/>
			<s:hidden name="saveType" id="saveType"/>
			<input type="hidden" name="meetingId" value="<%=meetingId%>">
			<input type="hidden" name="m_address" id="m_address" value="<%=m_address%>">
			<input type="hidden" name="isTemp" id="isTemp" value="<%=isTempAddress?1:0%>">
			<s:hidden name="boardRoomApplyPO.status" id="status" value="0"/>
			<tr>
				<td for="会议编号" nowrap="nowrap">&nbsp;&nbsp;会议编号：</td>
				<td width="42%">
					<s:textfield name="boardRoomApplyPO.boardroomCode" id="boardroomCode" cssClass="inputText" whir-options="vtype:[{'maxLength':100},'spechar3']" cssStyle="width:88%;" maxlength="100" readonly="true"/>
				</td>
				<td for="会议类型" nowrap="nowrap">&nbsp;&nbsp;会议类型：</td>
				<td width="42%"> 
					<select name="boardroomApplyType" id="boardroomApplyType"  whir-options="vtype:['notempty']"class="easyui-combobox" style="width:150px"  data-options="panelHeight:200,forceSelection:true">
					<%
					java.util.List boardroomApplyTypeList=(java.util.List)request.getAttribute("boardroomApplyTypeList");
					if(boardroomApplyTypeList !=null){
						for(int	j =	0; j < boardroomApplyTypeList.size(); j++){
							Object[] obj = (Object[])boardroomApplyTypeList.get(j);
							 boolean result = false;
							if(bdroomAppTypeId.equals(obj[0].toString())){
								result=true;
							}
					%>
					<option value="<%=obj[0]%>"<%=result==true?"selected":""%>><%=obj[1]%></option>
					<%}}%>
					</select>
				</td>
			</tr>
			<tr>
				<td for="会议主题" nowrap="nowrap">&nbsp;&nbsp;会议主题<span class="MustFillColor">*</span>：</td>
				<td colspan="3">
					<s:textfield name="boardRoomApplyPO.motif" id="motif" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':100},'spechar3']" cssStyle="width:94.6%;" maxlength="100" readonly="true"/>
				</td>
			</tr>
			<!--  <tr>
				<td>&nbsp;&nbsp;</td>
				<td colspan="3" align="left">
					<table id="signTb1" width="95%" height="90%" border="0">
						<tr>
							<td width="90%" for="常用语">
								<div align="right">
									<a  id="trigger1" href="javascript:;"  rel="noteDiv">常用语</a>
								</div>
								<div id="noteDiv" value="comment" style="display:none;">
									<%
									if(officelist!=null&&officelist.size()>0){
									for(int i=0;i<officelist.size();i++){
									String offContent=""+officelist.get(i);%>
									<div class="divOut" onmouseover="this.className='divOver'" onmouseout="this.className='divOut'" onclick="include_set_comment('<%=offContent%>','depict')"><%=offContent%></div>
									<%}}%>
									<div class="divOut">
									<a href="javascript:void(0);"  onclick="openWin({url:'<%=rootPath%>/OfficalDictionAction!addOfficalDiction.action',width:560,height:290,winName:'addOfficalDiction'});">>>添加</a>
									</div>
								</div>
							 </td>
						</tr>
					</table>
				</td>
			</tr> -->
			<tr>
				<td for="会议内容" nowrap="nowrap">&nbsp;&nbsp;会议内容：</td>
				<td colspan="3">
					<s:textarea name="boardRoomApplyPO.depict" id="depict" cols="112" rows="2"   cssClass="inputTextarea" cssStyle="width:94.6%;" maxlength="500" whir-options="vtype:[{'maxLength':500}]" />
				</td>
			</tr>
			<tr>
				<td for="主持人" nowrap="nowrap">&nbsp;&nbsp;主持人<span class="MustFillColor">*</span>：</td>
				<td width="42%">
					<s:textfield name="boardRoomApplyPO.emceeName" id="emceeName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':100}]" cssStyle="width:88%;" 
					maxlength="100" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'emcee', allowName:'emceeName', select:'user', single:'no', show:'groupuser', range:'*0*'});"></a>
					<s:hidden name="boardRoomApplyPO.emcee" id="emcee"/>
				</td>
				<td for="出席人数" >出席人数：</td>
				<td width="42%">
					<s:textfield name="boardRoomApplyPO.personNum" id="personNum" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':10}]" cssStyle="width:88%;" 
					maxlength="10"/>
				</td>
			</tr>
			<tr>
				<td for="出席领导" nowrap="nowrap">&nbsp;&nbsp;出席领导：</td>
				<td>
					<s:textfield name="boardRoomApplyPO.attendeeLeader" id="attendeeLeader" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:88%;" 
					maxlength="100" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'attendeeLeaderId', allowName:'attendeeLeader', select:'user', single:'no', show:'groupuser', range:'*0*'});"></a>
					<s:hidden name="boardRoomApplyPO.attendeeLeaderId" id="attendeeLeaderId"/>
				</td>
				<td for="会议记录人"  nowrap="nowrap">会议记录人：</td>
				<td>
					<s:textfield name="boardRoomApplyPO.notePersonName" id="notePersonName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:88%;" 
					maxlength="100" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'notePerson', allowName:'notePersonName', select:'user', single:'no', show:'groupuser', range:'*0*'});"></a>
					<s:hidden name="boardRoomApplyPO.notePerson" id="notePerson"/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" for="时间">&nbsp;&nbsp;时间：</td>
				<td colspan="3">
					<table border="0" width="100%" cellpadding="0" cellspacing="0" id="board_time_tbl">
						<%
						Set meetingTime = (Set) request.getAttribute("meetingTime");
						Iterator itor = meetingTime.iterator();
						int kk0=0;
						while(itor.hasNext()){
							BoardroomMeetingTimePO tt = (BoardroomMeetingTimePO)itor.next();
							java.util.Date destineDate = new java.util.Date();
							destineDate = tt.getMeetingDate();
							now.setTime(destineDate);
							
							String year = Integer.toString(now.get(Calendar.YEAR));
							String month = Integer.toString(now.get(Calendar.MONTH) + 1);
							String day = Integer.toString(now.get(Calendar.DATE));
							int startTime =Integer.parseInt(tt.getStartTime());
							int endTime = Integer.parseInt(tt.getEndTime());

							if(kk0==0){							
						%>
						<tr>
							<td>
								<input type="hidden" name="destineDateBeginTime"  id="destineDateBeginTime"value="<%=startTime%>" >
								<input type="hidden" name="destineDateEndTime" id="destineDateEndTime"value="<%=endTime%>" >
								<input type="text" name="destineDate" class="Wdate whir_datebox" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" value="<%=formatter.format(destineDate)%>" 
								/>
								<select name="startHour" style="font-size:9pt;width:6%;" class="selectlist">
									<% for(int hi=0;hi<24;hi++){
									   
										String selected = hi==startTime/3600 ? "selected":"";
									%>
									<option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
									<%}%>
								</select>&nbsp;时&nbsp;<select name="startMinutes" style="font-size:9pt;width:6%;" class="selectlist" >
									<%for(int mi=0;mi<60;){
										String selected = mi==(startTime%3600)/60 ? "selected":"";

									%>
									<option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
									<%
									mi+=5;
									}%>
								</select>&nbsp;分至&nbsp;<select name="endHour" style="font-size:9pt;width:6%;" class="selectlist" >
									<%for(int hi=0;hi<24;hi++){
										String selected = hi==endTime/3600 ? "selected":"";
									%>
									<option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
									<%}%>
								</select>&nbsp;时&nbsp;<select name="endMinutes" style="font-size:9pt;width:6%;" class="selectlist" >
									<%for(int mi=0;mi<60;){
										String selected = mi==(endTime%3600)/60 ? "selected":"";
									%>
									<option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
									<%
									mi+=5;
									}%>
								</select>&nbsp;分&nbsp;
								<IMG height=12 src="<%=rootPath%>/images/addarrow.gif" width=12 onclick='addBoardtime()' align=absMiddle title="增加" style="cursor:pointer;">
							   <!--  <input type="button" class="btnButton4font" onclick="addBoardtime();" value='<s:text name="comm.add"/>' /> -->
							</td>
						</tr>
						<tr style="display:none">
							<td>
								<input type="text" name="destineDate"  class="Wdate whir_datebox" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" value="<%=formatter.format(applyDate)%>"/>
								<select name="startHour" style="font-size:9pt;width:6%;" class="selectlist">
									<%
									for(int hi=0;hi<24;hi++){
										 String selected = hi==9 ? "selected":"";
									%>
									<option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
									<%}%>
								</select>&nbsp;时&nbsp;<select name="startMinutes" style="font-size:9pt;width:6%;" class="selectlist">
									<%for(int mi=0;mi<60;){
										String selected = mi==0 ? "selected":"";
									%>
									<option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
									<%
									mi+=5;
									}%>
								</select>&nbsp;分至&nbsp;<select name="endHour" style="font-size:9pt;width:6%;" class="selectlist">
									<%for(int hi=0;hi<24;hi++){
										String selected = hi==9 ? "selected":"";
									%>
									<option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
									<%}%>
								</select>&nbsp;时&nbsp;<select name="endMinutes" style="font-size:9pt;width:6%;" class="selectlist">
									<%for(int mi=0;mi<60;){
									   String selected = mi==30 ? "selected":"";
									%>
									<option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
									<%
									mi+=5;
									}%>
								</select>&nbsp;分&nbsp;
								<img width="12" height="12" border="0" src="<%=rootPath%>/images/delarrow.gif" style="cursor:pointer;" onClick="minRow(this);" title="删除">
							</td>
						</tr>
						<%} else {%>
						<tr>
							<td>
								<input type="hidden" name="destineDateBeginTime"  id="destineDateBeginTime"value="<%=startTime%>" >
								<input type="hidden" name="destineDateEndTime" id="destineDateEndTime"value="<%=endTime%>" >
								<input type="text" name="destineDate" class="Wdate whir_datebox" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" value="<%=formatter.format(destineDate)%>" />
								<select name="startHour" style="font-size:9pt;width:6%;" class="selectlist">
									<% for(int hi=0;hi<24;hi++){
										 String selected = hi==startTime/3600 ? "selected":"";
									%>
									<option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
									<%}%>
								</select>&nbsp;时&nbsp;<select name="startMinutes" style="font-size:9pt;width:6%;" class="selectlist" >
									<%for(int mi=0;mi<60;){
										
										String selected = mi==(startTime%3600)/60 ? "selected":"";
									%>
									<option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
									<%
									mi+=5;
									}%>
								</select>&nbsp;分至&nbsp;<select name="endHour" style="font-size:9pt;width:6%;" class="selectlist" >
									<%for(int hi=0;hi<24;hi++){
									   
										String selected = hi==endTime/3600 ? "selected":"";
									%>
									<option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
									<%}%>
								</select>&nbsp;时&nbsp;<select name="endMinutes" style="font-size:9pt;width:6%;" class="selectlist" >
									<%for(int mi=0;mi<60;){
										
										 String selected = mi==(endTime%3600)/60 ? "selected":"";
									%>
									<option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
									<%
									mi+=5;
									}%>
								</select>&nbsp;分&nbsp;
								<img width="12" height="12" border="0" src="<%=rootPath%>/images/delarrow.gif" style="cursor:pointer;" onClick="minRow(this);" title="删除">
							</td>
						</tr>
						<%}
							kk0++;
						}
						%>
					</table>
				</td>
			</tr>
			<tr>
				<td for="会议室名称"  nowrap="nowrap">&nbsp;&nbsp;会议室名称<span class="MustFillColor">*</span>：</td>
				<td colspan="3" nowrap="nowrap">
					<s:textfield name="boardRoomPO.name" id="name" cssClass="inputText" cssStyle="width:94.7%" readonly="true"/>
					 <input type="hidden" name="boardroomId"  id="boardroomId" value="<%=boardroomId%>">
				</td>
			</tr>
			<%if(isTempAddress){%>
			<!-- <tr>
				<td for="地点" nowrap="nowrap">&nbsp;&nbsp;地点<span class="MustFillColor">*</span>：</td>
				<td colspan="3">
					<s:textfield name="boardRoomApplyPO.addr" id="addr" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':200}]" cssStyle="width:94.6%;" 
				maxlength="200"/>
				</td>
			</tr> -->
			<%}%>
			<%
			if(request.getAttribute("isVideo")!=null && ("0".equals(request.getAttribute("isVideo").toString())||"2".equals(request.getAttribute("isVideo").toString()))){
			%>
				<tr>
				<td for="地点" nowrap="nowrap">&nbsp;&nbsp;地点<span class="MustFillColor">*</span>：</td>
				<td colspan="3">
					<s:textfield name="boardRoomApplyPO.addr" id="addr" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':200}]" cssStyle="width:94.6%;" 
				maxlength="200"/>
				</td>
			</tr>
			<%}else{%>
			<tr>
				<td for="点数">&nbsp;&nbsp;点数<span class="MustFillColor">*</span>：</td>
				<td colspan="3">
					 <s:textfield name="boardRoomApplyPO.points" id="points" cssClass="inputText" whir-options="vtype:['p_integer_e','notempty',{'maxLength':10}]" cssStyle="width:94.6%;" 
					maxlength="10" readonly="true"/>
					<s:hidden name="maxNumber" id="maxNumber"/>
				</td>
			</tr>
			<tr>
				<td for="点数">&nbsp;</td>
				<td colspan="3">
					<span style="color:red;">该会议室最大支持<%=request.getAttribute("maxNumber")%>点</span>
				</td>
			</tr>
			<%}%>
			<tr>
				<td for="会议出席人" nowrap="nowrap">&nbsp;&nbsp;会议出席人：</td>
				<td colspan="3">
					<s:textarea name="boardRoomApplyPO.attendee" id="attendee" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.6%;" readonly="true"/><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'attendeeEmpId', allowName:'attendee', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"></a>
					<s:hidden name="boardRoomApplyPO.attendeeEmpId" id="attendeeEmpId"/>
				</td>
			</tr>
			<tr>
				<td for="会议列席人"nowrap="nowrap">&nbsp;&nbsp;会议列席人：</td>
				<td colspan="3">
					 <s:textarea name="boardRoomApplyPO.nonvoting" id="nonvoting" cols="112" rows="2"   cssClass="inputTextarea" cssStyle="width:94.6%;" readonly="true"/><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'nonvotingEmpId', allowName:'nonvoting', select:'user', single:'no', show:'groupuser', range:'*0*'});"></a>
					 <s:hidden name="boardRoomApplyPO.nonvotingEmpId" id="nonvotingEmpId"/>
				</td>
			</tr>
			<tr>
				<td for="其他参会人员"nowrap="nowrap">&nbsp;&nbsp;其他参会人员：</td>
				<td colspan="3">
					 <s:textarea name="boardRoomApplyPO.otherAttendeePerson" id="otherAttendeePerson" cols="112" rows="2"   cssClass="inputTextarea" cssStyle="width:94.7%;"/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap">&nbsp;&nbsp;</td>
				<td colspan="3">
					 <font color=red>以上人员无法收到系统、短信以及RTX提醒。</font>
				</td>
			</tr>
			<tr>
				<td for="单位收文员"nowrap="nowrap">&nbsp;&nbsp;单位收文员：</td>
				<td colspan="3">
					 <s:textfield name="boardRoomApplyPO.swPerson" id="swPerson" cssClass="inputText" cssStyle="width:94.7%;" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'swPersonId', allowName:'swPerson', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
					<s:hidden name="boardRoomApplyPO.swPersonId" id="swPersonId"/>
					<s:hidden name="boardRoomApplyPO.swPersonId" id="swPersonId"/>
				</td>
			</tr>
			<tr>
				<td for="预定者">&nbsp;&nbsp;预定者：</td>
				<td>
					<s:textfield name="boardRoomApplyPO.applyEmpName" id="applyEmpName" cssClass="inputText" whir-options="vtype:[{'maxLength':15}]" cssStyle="width:88%;" 
					maxlength="15" readonly="true"/>
					<s:hidden name="boardRoomApplyPO.applyEmp" id="applyEmp"/>
				</td>
				<td  for="预定部门"nowrap="nowrap">预定部门：</td>
				<td>
					<s:textfield name="boardRoomApplyPO.applyOrgName" id="applyOrgName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:88%;" 
					maxlength="100" readonly="true"/><s:hidden name="boardRoomApplyPO.applyOrg" id="applyOrg"/>
				</td>
			</tr>
			<tr>
				<td for="预定日期">&nbsp;&nbsp;预定日期：</td>
				<td>
					<input type="text" name="boardRoomApplyPO.applyDate" id="applyDate"   class="Wdate whir_datebox" onfocus="WdatePicker({el:'applyDate',isShowWeek:true})" value="<%=formatter.format(applyDate)%>"/>
				</td>
				<td  for="联系电话"nowrap="nowrap">联系电话：</td>
				<td>
					<s:textfield name="boardRoomApplyPO.linkTelephone" id="linkTelephone" cssClass="inputText" whir-options="vtype:['tel',{'maxLength':20}]" cssStyle="width:88%;" maxlength="20" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td >&nbsp;&nbsp;</td>
				<td colspan="3">
					<jsp:include page="/public/im/remind.jsp" flush="true"> 
					<jsp:param name="modeType" value="im|sms|mail" />  
					<jsp:param name="smsModelName" value="会议通知" />  
					<jsp:param name="disabled" value="*" />  
					</jsp:include> 
				</td>
			</tr>
			<tr>
				<td for="席卡">&nbsp;&nbsp;席卡：</td>
				<td colspan="3">
					<s:textarea name="boardRoomApplyPO.seatcard" id="seatcard" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.6%;" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td for="备注">&nbsp;&nbsp;备注：</td>
				<td colspan="3">
					<s:textarea name="boardRoomApplyPO.remark" id="remark" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.6%;" readonly="true"/>
				</td>
			</tr>
			<tr>
				<td nowrap="nowrap" for="附件">&nbsp;&nbsp;附件：</td>
				<td height="40" colspan="3" valign="bottom" style="width:88%">
					<input type="hidden" name="boardroomFileName" id="boardroomFileName" value="<%=boardroomFileName%>">
					<input type="hidden" name="boardroomSaveName" id="boardroomSaveName" value="<%=boardroomSaveName%>">
					<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
					<jsp:param name="dir"		 value="boardroom" />
					<jsp:param name="uniqueId"    value="uniqueId" />
					<jsp:param name="realFileNameInputId"    value="boardroomFileName" />
					<jsp:param name="saveFileNameInputId"    value="boardroomSaveName" />
					<jsp:param name="canModify"       value="no" />
					<jsp:param name="width"		 value="90" />
					<jsp:param name="height"		 value="20" />
					<jsp:param name="multi"		 value="true" />
					<jsp:param name="buttonClass" value="upload_btn" />
					<jsp:param name="fileSizeLimit"		 value="0" />
					<jsp:param name="fileTypeExts"		 value="*.jpg;*.jpeg;*.gif;*.png;*.zip;*.doc;*.docx;*.xls;*.xlsm;*.ppt;*.pptx;*.txt" />
					</jsp:include>                 
				</td>
			</tr>
			<%
			Set equSet = (Set)request.getAttribute("bdequSet");
			if( equSet != null ){
			Iterator iter = equSet.iterator();
			BoardRoomEquipmentPO po = null;
			if(iter.hasNext()){ %>
			<tr>
				<td for="会议设备">&nbsp;&nbsp;会议设备：</td>
				<td colspan="3">
					<% 
					while(iter.hasNext()){
					po = (BoardRoomEquipmentPO) iter.next();
					%>
					<input type="checkbox" name="bdEqu"  value="<%=po.getEquId()%>" <%if(boardEquipment.indexOf(po.getEquId()+"")>-1){%>checked<%}%>><%=po.getEquName()%>&nbsp;
					<input type="hidden" name="bdEquName" value="<%=po.getEquName()%>">
					<%}%>
				</td>
			</tr>
			<%}}%>

			<tr>
				<td for="启用会议签到">&nbsp;&nbsp;启用会议签到：</td>
				<td colspan="3">
					<input type="radio" name="meetingAttendance"  value="0" <%if(meetingAttendance.equals("") || meetingAttendance.equals("0")){%>checked<%}%>>是
					<input type="radio" name="meetingAttendance"  value="1" <%if(meetingAttendance.equals("1")){%>checked<%}%>>否
				</td>
			</tr>
			<tr>
				<td for="签到方式">&nbsp;&nbsp;签到方式：</td>
				<td colspan="2">
					<input type="radio" name="attendancetype" value="0" <%if(attendancetype.equals("") || attendancetype.equals("0")){%>checked<%}%>>主动扫码
					<input type="radio" name="attendancetype" value="1" <%if(attendancetype.equals("1")){%>checked<%}%>>被动扫码
				</td>
				<td><input type="button" class="btnButton4font" id="hiddenQrCode" onClick="qrCode();" value='生成二维码' /></td>
			</tr>

			<tr class="Table_nobttomline">  
				<td>&nbsp;</td> 
				<td colspan="3">  
					<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
					<input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
					<input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
				</td>  
			</tr>  
			<s:hidden name="boardRoomApplyPO.boardEquipment" id="boardEquipment"/>
			<input type="hidden" name="emphasis"  id="emphasis">
		</table>					
		<!--工作流包含页-->				 
		<input type="hidden" name="addDivContent"id="addDivContent" value=""> <!-- 在  常用语中用到-->
	</s:form>
	</div>
</div>
</body>
<script type="text/javascript">
//设置表单为异步提交
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

/**
初始话信息
*/
function initBody(){
	//初始话信息
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
    window.resizeTo(windowWidth,windowHeight);
	// $("#trigger1").powerFloat();
}

var noteTimer=null;
function getNote(){
	var d=document.getElementById("noteDiv");
	var s_top=0;
	if(document.getElementById("mainFrame"))s_top=document.getElementById("mainFrame").scrollTop;
	d.style.left=event.x-220;
	d.style.top=s_top+event.y-30;
	d.style.display="inline";
}

function hiddenNote(){
  //noteTimer=window.setTimeout("closeNote()",200);
}
function closeNote(){
  var d=document.getElementById("noteDiv");
  d.style.display="none";
}
function lockedNote(){
  window.clearTimeout(noteTimer);
}
function setNote(obj){
	document.getElementById("flowNote").innerText+=obj.innerText;
}
function include_set_comment(nr,commentName){
	var cobj=eval("document.getElementById('"+commentName+"')");
	cobj.value=nr;
}
function addDivContent(){
	var adddivcontent=$("#addDivContent").val();
	var comment=document.getElementById("noteDiv").getAttribute("value");
	document.getElementById("noteDiv").innerHTML= ""+"<div class='divOut' onmouseover='lockedNote();this.className=\"divOver\"' onmouseout='this.className=\"divOut\"' onclick=\"include_set_comment(\'"+adddivcontent+"\',\'depict\');\">"+adddivcontent+"<\/div>"+document.getElementById("noteDiv").innerHTML;
	//alert(document.getElementById("noteDiv").innerHTML);
}

function addBoardtime1(){
	var table = document.getElementById("board_time_tbl");
	var lastRow = table.rows[table.rows.length - 1];
	var oClone = lastRow.cloneNode(true);
	oClone.style.display='';
	//lastRow.parentElement.insertAdjacentElement("beforeEnd", oClone);
}
function addBoardtime(){
     commonAddTr({tableId:'board_time_tbl',trIndex:1,operate:'clone',position:'end',isKeep:true,obj:null,callbackfunction:mycall});
}
function mycall(newTr){
   $(newTr).show();
}
function minRow(obj) {
    $(obj).parent("td").parent("tr").remove();
}
function changeBoardRoom(obj){
    var boardroomApplyId=$("#boardroomApplyId").val();
    dataForm.action ="<%=rootPath%>/boardRoom!selectBoardroomApplyView.action?changeBoardRoom=1&type=view&action=selectBoardroomApplyModify"
    +"&boardroomApplyId="+boardroomApplyId;
	dataForm.submit();
}
function searchBoardroom(){
	//容纳人数
	var personNum = $("#personNum").val();

	//会议时间
	var destineDate = $('input[name=destineDate]')[0].value;
	var startHour =$('select[name=startHour]')[0].value;
	var startMinutes =$('select[name=startMinutes]')[0].value; 
	var endHour = $('select[name=endHour]')[0].value;
	var endMinutes = $('select[name=endMinutes]')[0].value;
	var boardtime = destineDate.replace(/\//gm,'-');
	var startTime = startHour * 3600 + startMinutes * 60;
	var endTime = endHour * 3600 + endMinutes * 60;
	//设备
	var equipment = getCheckBoxData("bdEquName", "value");
	var url='${ctx}/boardRoom!selectBoardroomByConditions.action?personNum=' + personNum + "&boardtime="+boardtime+"&startTime="+startTime+"&endTime="+endTime+"&equipment=" 
	+equipment;
	$('#boardroomId').combobox('clear');
	$('#boardroomId').combobox('reload', url);
}

function searchBoardroom1(){
	//容纳人数
	var personNum = $("#personNum").val();

	//会议时间
	var destineDate = $('input[name=destineDate]')[0].value;
	var startHour =$('select[name=startHour]')[0].value;
	var startMinutes =$('select[name=startMinutes]')[0].value; 
	var endHour = $('select[name=endHour]')[0].value;
	var endMinutes = $('select[name=endMinutes]')[0].value;
	var boardtime = destineDate.replace(/\//gm,'-');
	var startTime = startHour * 3600 + startMinutes * 60;
	var endTime = endHour * 3600 + endMinutes * 60;

	//设备
	var equipment = getCheckBoxData("bdEquName", "value");
	$.ajax({
		url: '<%=rootPath%>/modules/subsidiary/boardroom/boardRoom_httprequest.jsp?personNum=' + personNum + "&boardtime="+boardtime+"&startTime="
		+startTime+"&endTime="+endTime+"&equipment=" +
			equipment+ "&" + Math.round(Math.random()*1000),
		type: 'GET',
		data: null,
		timeout: 1000,
		async: false,      //true异，false,ajax同步
		error: function(){
		//alert('Error loading XML document');
		},
		success: function(data){
		   // data = data.replace(/(^\s*)|(\s*$)/g,"");
			document.getElementById("_boardrooms").innerHTML=data;
		}
	});
}

function save(n,obj) {
    var formId = $(obj).parents("form").attr("id");
	var validation = validateForm(formId);
	$(obj).parents("form").find("#saveType").val(n);
	if(validation){
        if(checkFormElement()){
			$('#'+formId).submit();
        }
	}
}

var _flag = false;
//验证表单元素
function checkFormElement(){
	var boardroomApplyId=$("#boardroomApplyId").val();
    var strCheckBox =getCheckBoxData("bdEqu", "value");
    $("#boardEquipment").val(strCheckBox);
	var motif = $('#motif').val();
	if (motif !=""){
		if(motif.substring(0,1) ==" "){
             whir_poshytip($('#motif'),"会议主题不得为空格开头，请去空格。");
			return false;
		}
	}
	var destineDateBeginTime = 0;
	var destineDateEndTime = 0;
    var _destineDate = $('input[name=destineDate]');
	_flag = false;
	for(var i=0; i<_destineDate.length; i++){
        if(i!=1){
            //会议时间数组
            var destineDate = $('input[name=destineDate]')[i].value;
                $("#destineDateBeginTime").val($('select[name=startHour]')[i].value *3600 +$('select[name=startMinutes]')[i].value*60);
                $("#destineDateEndTime").val($('select[name=endHour]')[i].value *3600 +$('select[name=endMinutes]')[i].value*60);
                
            destineDateBeginTime = $("#destineDateBeginTime").val();
            destineDateEndTime = $("#destineDateEndTime").val();
            if(eval(destineDateBeginTime)>=eval(destineDateEndTime)){
                whir_poshytip($('select[name=startHour]')[i],"预定结束时间不得小于或等于预定开始时间，请调整。");
                return false;
				break;
            }
            var boardroomId = $("#boardroomId").val();
			if (_flag==false && !checkMeetingDateAndTime(i)){return false; break;}
            var timeFlag=true;
            //临时会议室不判断时间
            <% if(!isVideo.equals("2")){ %>
                $.ajax({
                    url: '<%=rootPath%>/modules/subsidiary/boardroom/selectImpropriateTime.jsp?destineDate=' + destineDate + "&destineDateBeginTime="+destineDateBeginTime+"&destineDateEndTime="
                    +destineDateEndTime+"&boardroomId="+boardroomId+"&boardroomApplyId="+boardroomApplyId+"&isVideo=<%=isVideo%>" + "&" + Math.round(Math.random()*1000),
                    type: 'GET',
                    data: null,
                    timeout: 1000,
                    async: false,      //true异，false,ajax同步
                    error: function(){
                    //alert('Error loading XML document');
                    },
                    success: function(data){
                        data = data.replace(/(^\s*)|(\s*$)/g,"");
                        if(data == '-1'){
                            whir_alert("您申请的时间段已定出，请重新申请。",null,null);
                            timeFlag= false;
							//break;
                        }else{
                            <% if(isVideo.equals("1")){ %>	
                                if(Number($("#maxNumber").val())-(data)<Number($("#points").val())){
                                    whir_alert("该会议室本时间段内可以使用的点数为:"+(Number($("#maxNumber").val())-(data)),null,null);
                                    $("#points").val(Number($("#maxNumber").val())-(data));
                                    timeFlag= false;
									//break;
                                }
                            <%}%>
                        }
                    }
                });
            <%}%>
			if (timeFlag==false ){return false; break;}
        }
	}
    <%if(curModiFields.indexOf("$destineDate$") > -1){%>
	for(var i=0; i<_destineDate.length-1; i++){
        if(i!=1){
            //会议时间数组
            var destineDate = $('input[name=destineDate]')[i].value;
            $("#destineDateBeginTime").val($('select[name=startHour]')[i].value *3600 +$('select[name=startMinutes]')[i].value*60);
            $("#destineDateEndTime").val($('select[name=endHour]')[i].value *3600 +$('select[name=endMinutes]')[i].value*60);
            destineDateBeginTime = $("#destineDateBeginTime").val();
            destineDateEndTime = $("#destineDateEndTime").val();

            for(var j=i+1; j<_destineDate.length; j++){
                if(j!=1){
                    var destineDate2 = $('input[name=destineDate]')[j].value;
                    var destineDateBeginTime2 = $('select[name=startHour]')[j].value *3600 +$('select[name=startMinutes]')[j].value*60;
                    var destineDateEndTime2 = $('select[name=endHour]')[j].value *3600 +$('select[name=endMinutes]')[j].value*60;

                    if(destineDate == destineDate2 &&
                    ((eval(destineDateBeginTime)<=eval(destineDateBeginTime2) && eval(destineDateBeginTime2)<=eval(destineDateEndTime)) ||
                    (eval(destineDateBeginTime)<=eval(destineDateEndTime2) && eval(destineDateEndTime2)<=eval(destineDateEndTime)) ||
                    (eval(destineDateBeginTime)>=eval(destineDateBeginTime2) && eval(destineDateEndTime)<=eval(destineDateEndTime2)))){
                        whir_poshytip($('select[name=startHour]')[j],"申请的会议时间有重复，请调整。");
                        return false;
						break;
                    }
                }
            }
        }
	}
    <%}%>
	return true;
}

function checkMeetingDateAndTime(_index) {
	var pageDate =  $('input[name=destineDate]')[_index].value.replace(/[/]/g,"-");
	var today = new Date();
    var year= ( today.getYear() < 1900 ) ? ( 1900 + today.getYear() ):today.getYear();
	var hour = today.getHours();
	var minute = today.getMinutes();
	var time = (hour > 9 ? hour : ("0"+hour)) + ":" + (minute > 9 ? minute : ("0"+minute));
	var midStr = year + "-" + (today.getMonth()+1) + "-" + today.getDate();
	var beTime =$("#destineDateBeginTime").val();
	beTime = (beTime / 3600) + "";
	if (beTime.indexOf(".") > 0) {
		var tArr = beTime.split(".");
		var tH;
		var tT;
		if (tArr[0].length > 1)
			tH = "0" + tArr[0];
		else
			tH = tArr[0];
		if (tArr[1] = 5)
			tT = "30";
		else
			tT = "00";
		beTime = tH + ":" + tT;
	} else {
		if (beTime > 9)
			beTime = beTime + ":00";
		else
			beTime = "0" + beTime + ":00";
	}
	if (checkDateEarlier(midStr, pageDate) == '0') {
		if (!confirm("选择的会议日期已过期， 是否确定安排这次会议！")){
			return false;
		} else {
			_flag = true;
		}
	} else if (checkDateEarlier(midStr, pageDate) == '1') {
		return true;
	} else if (comptime(time,beTime) != -1) {
		if (!confirm("选择的会议时间已过期， 是否确定安排这次会议！")){
			return false;
		} else {
			_flag = true;
		}
	}
	return true;
}

function checkIsValidDate(str){
    //如果为空，则通过校验
	if(str == ""){return true;}
	var pattern = /^((\\d{4})|(\\d{2}))-(\\d{1,2})-(\\d{1,2})$/g;
	var arrDate = str.split("-");
	if(parseInt(arrDate[0],10) < 100){
		arrDate[0] = 2000 + parseInt(arrDate[0],10) + "";
    }
    
	var date =  new Date(arrDate[0],(parseInt(arrDate[1],10) -1)+"",arrDate[2]);
    var year= ( date.getYear() < 1900 ) ? ( 1900 + date.getYear() ):date.getYear();
	if(year == arrDate[0]
		&& date.getMonth() == (parseInt(arrDate[1],10) -1)+""
		&& date.getDate() == arrDate[2]){
		return true;
    }else{
		return false;
    }
}

function checkDateEarlier(strStart,strEnd){
	if(checkIsValidDate(strStart) == false || checkIsValidDate(strEnd) == false) {
		alert("wrong");
		return false;
	}
    //如果有一个输入为空，则通过检验
	if (( strStart == "" ) || ( strEnd == "" ))
		return true;
	var arr1 = strStart.split("-");
	var arr2 = strEnd.split("-");
	var date1 = new Date(arr1[0],parseInt(arr1[1].replace(/^0/,""),10) - 1,arr1[2]);
	var date2 = new Date(arr2[0],parseInt(arr2[1].replace(/^0/,""),10) - 1,arr2[2]);
	if(arr1[1].length == 1)
		arr1[1] = "0" + arr1[1];
	if(arr1[2].length == 1)
		arr1[2] = "0" + arr1[2];
	if(arr2[1].length == 1)
		arr2[1] = "0" + arr2[1];
	if(arr2[2].length == 1)
		arr2[2]="0" + arr2[2];
	var d1 = arr1[0] + arr1[1] + arr1[2];
	var d2 = arr2[0] + arr2[1] + arr2[2];
	if(parseInt(d1,10) > parseInt(d2,10)) {
		return "0";
	} else if(parseInt(d1,10) < parseInt(d2,10)) {
		return "1";
	} else {
		return "2";
	}
	return "1";
}

function comptime(a,b) {
	var dateA = new Date("1900/1/1 " + a);
	var dateB = new Date("1900/1/1 " + b);
	if(isNaN(dateA) || isNaN(dateB)) return null;
	if(dateA > dateB) return 1;
	if(dateA < dateB) return -1;
	return 0;
}

$(document).ready(function () {
	$("input[name=attendancetype]").click(function () {
		//alert($(this).val());
		if($(this).val() == '1'){
			$('#hiddenQrCode').hide();
		}else{
			$('#hiddenQrCode').show();
		}
	});
});

function qrCode(){
	var boardroomApplyId =$('#boardroomApplyId').val();
	if(boardroomApplyId !=null && boardroomApplyId !=''){
		var ajaxCallUrl = whirRootPath + "/boardRoom!qrCode.action?boardroomApplyId="+boardroomApplyId;
		$.ajax({
			cache: true,
			type: "get", 
			url:ajaxCallUrl,
			async: false,
			dataType: 'json',
			error: function(request) {
				whir_alert("操作异常，请联系管理员！");
			},
			success: function(json) {
				var flag =json.flag;
				var dlcode =json.dlcode;
				//alert(flag+"|"+dlcode);
				location.href="<%=rootPath%>/public/download/download.jsp?verifyCode="+dlcode+"&FileName="+flag+"&name="+flag+"&path=boardroom";
			}
		});
	}
}
</script>
</html>