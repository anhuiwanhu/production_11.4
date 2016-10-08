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

    String recordId = request.getParameter("boardroomApplyId");
    com.whir.ezoffice.workflow.newBD.WorkFlowCommonBD wfcBD = new com.whir.
    ezoffice.workflow.newBD.WorkFlowCommonBD();
    boolean hasFlow = false;
    Map workMap = wfcBD.getWorkInfo("15",recordId);
    if(workMap != null){
        hasFlow = true;
    }

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
	String boardroomApplyId = boardRoomApplyPO.getBoardroomApplyId()==null?"":boardRoomApplyPO.getBoardroomApplyId().toString();
	
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
     if(boardRoomApplyPO != null){
        if(boardRoomApplyPO.getApplyDate() !=null){
            applyDate =boardRoomApplyPO.getApplyDate();
        }
       }
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

    String m_address="";
    boolean isTempAddress = false;
    if(boardroomId!=null&&!"".equals(boardroomId)&&!"null".equals(boardroomId)){
        BoardRoomPO poo = new BoardRoomBD().selectBoardroom(new Long(boardroomId));
        String __isVideo = poo.getIsVideo()+"";
        if("2".equals(__isVideo))isTempAddress=true;//临时会议
        m_address=poo.getLocation()!=null?poo.getLocation():"";
    }
	String notmessage = (String)request.getAttribute("notmessage");
     Calendar now = Calendar.getInstance();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>查看</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<!--工具栏按钮 公用js-->
	<%@ include file="/public/include/meta_base_workflow.jsp"%> 
    <%if("1".equals(notmessage)){%>
        <script language="javascript">
            whir_alert("信息不存在，可能被删除了，请联系管理员！",null,null);
            window.close();
        </script>
    <%return;}%>
    <style TYPE="text/css">

#receiveForm{
  background-color:#000000;
}
.receiveForm td{
  font-size:12px;
  background-color:#ffffff;
}
.doc_Content{ padding:20px 0px;}
.doc_Content td{ padding:5px;}
//-->
</style>
<SCRIPT LANGUAGE="JavaScript">
    //打印
    function cmdPrint(){
        var val='<%=rootPath%>/modules/subsidiary/boardroom/printWord.jsp';
        openWin({url:val,isFull:true,width:800,height:600,winName:'printWord'});
    }
	//预览
	function cmdPrintpriview(){
        var val='<%=rootPath%>/modules/subsidiary/boardroom/selectTemplate.jsp?boardroomApplyId=<%=boardRoomApplyPO.getBoardroomApplyId()%>';
        openWin({url:val,width:560,height:300,winName:'preview'});
    }
	//转发
	 function cmdZfToSend(){
        var val='<%=rootPath%>/modules/subsidiary/boardroom/toSend.jsp?boardroomApplyId=<%=boardRoomApplyPO.getBoardroomApplyId()%>&isNewOrOld=old';
        openWin({url:val,width:800,height:700,winName:'zfToSend'});
    }
    </SCRIPT>
</head>
<body  onload="initBody();" scroll=no class="docBodyStyle">
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
     <div class="doc_Scroll">
    <s:form name="dataForm" id="dataForm" action="${ctx}/boardRoom!changeBoardRoom.action" method="post" theme="simple" >
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
            <td   height="50" ></td>
         </tr>
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
                              <li id="Panle2" ><a href="javascript:void(0);" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="javascript:void(0);" onClick="changePanle(3);">相关流程<span class="redBold" id="viewrelationnum"></span></a></li>
                              <li id="Panle4" ><a href="javascript:void(0);" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content">
							<!--表单包含页-->
								<table width="100%" border="0" cellpadding="2" cellspacing="1" class="docBoxNoPanel">
                                    <s:hidden name="boardRoomApplyPO.boardroomApplyId" id="boardroomApplyId"/>
                                    <s:hidden name="saveType" id="saveType"/>
                                    <input type="hidden" name="meetingId" value="<%=meetingId%>">
                                    <input type="hidden" name="m_address" id="m_address" value="<%=m_address%>">
                                    <input type="hidden" name="isTemp" id="isTemp" value="<%=isTempAddress?1:0%>">
                                    <tr>
                                        <td for="会议编号" nowrap="nowrap">&nbsp;&nbsp;会议编号：</td>
                                        <td width="42%">
                                         <s:textfield name="boardRoomApplyPO.boardroomCode" id="boardroomCode" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:88%;" maxlength="100" readonly="true"/>
                                        </td>
                                        <td for="会议类型" nowrap="nowrap">&nbsp;&nbsp;会议类型：</td>
                                        <td width="42%">
                                            
                                            <select name="boardroomApplyType" id="boardroomApplyType" whir-options="vtype:['notempty']" class="easyui-combobox" style="width:150px"  data-options="panelHeight:'auto'" disabled="true">
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
                                         <s:textfield name="boardRoomApplyPO.motif" id="motif" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':100}]" cssStyle="width:94.7%;" maxlength="100" readonly="true"/>
                                        </td>
                                    </tr>
                                    
                                    <tr>
                                        <td for="会议内容" nowrap="nowrap">&nbsp;&nbsp;会议内容：</td>
                                        <td colspan="3">
                                                 <s:textarea name="boardRoomApplyPO.depict" id="depict" cols="112" rows="2"   cssClass="inputTextarea" cssStyle="width:94.7%;" readonly="true"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td for="主持人" nowrap="nowrap">&nbsp;&nbsp;主持人<span class="MustFillColor">*</span>：</td>
                                        <td>
                                            <s:textfield name="boardRoomApplyPO.emceeName" id="emceeName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':100}]" cssStyle="width:88%;" 
                                            maxlength="100" readonly="true"/><s:hidden name="boardRoomApplyPO.emcee" id="emcee"/>
                                            
                                            
                                        </td>
                                        <td for="出席人数" >出席人数：</td>
                                        <td>
                                            
                                                <s:textfield name="boardRoomApplyPO.personNum" id="personNum" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':10}]" cssStyle="width:88%;" 
                                            maxlength="10" readonly="true"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="出席领导" nowrap="nowrap">&nbsp;&nbsp;出席领导：</td>
                                        <td >
                                            <s:textfield name="boardRoomApplyPO.attendeeLeader" id="attendeeLeader" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:88%;" 
                                            maxlength="100" readonly="true"/><s:hidden name="boardRoomApplyPO.attendeeLeaderId" id="attendeeLeaderId"/>
                                           
                                            
                                        </td>
                                        <td for="会议记录人"  nowrap="nowrap">会议记录人：</td>
                                        <td>
                                            <s:textfield name="boardRoomApplyPO.notePersonName" id="notePersonName" cssClass="inputText" whir-options="vtype:[{'maxLength':10}]" cssStyle="width:88%;" 
                                            maxlength="10" readonly="true"/><s:hidden name="boardRoomApplyPO.notePerson" id="notePerson"/>
                                           
                                            
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
                                                    
                                                    String year = Integer.toString(now.get(Calendar.YEAR));;
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
                                                        <input type="text" name="destineDate" class="Wdate whir_datebox" onfocus="WdatePicker({el:'destineDate',isShowWeek:true})" value="<%=formatter.format(destineDate)%>" 
                                                        disabled='true'/>
                                                
                                                
                                                        <input type="hidden" name="startHour" value="<%=startTime/3600%>">
                                                         <input type="hidden" name="startMinutes" value="<%=(startTime%3600)/60%>">
                                                        <input type="hidden" name="endHour" value="<%=endTime/3600%>">
                                                        <input type="hidden" name="endMinutes" value="<%=(endTime%3600)/60%>">
                                                       
                                                        <select name="startHour" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <% for(int hi=0;hi<24;hi++){
                                                                String selected = hi==startTime/3600 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
                                                            <%}%>
                                                        </select>&nbsp;时&nbsp;<select name="startMinutes" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <%for(int mi=0;mi<60;){
                                                                String selected = mi==(startTime%3600)/60 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
                                                            <%
                                                            mi+=5;
                                                            }%>
                                                        </select>&nbsp;分至&nbsp;<select name="endHour" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <%for(int hi=0;hi<24;hi++){
                                                                String selected = hi==endTime/3600 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
                                                            <%}%>
                                                        </select>&nbsp;时&nbsp;<select name="endMinutes" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <%for(int mi=0;mi<60;){
                                                                String selected = mi==(endTime%3600)/60 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
                                                            <%
                                                            mi+=5;
                                                            }%>
                                                        </select>&nbsp;分&nbsp;
                                                        
                                                    </td>
                                                </tr>
												 <tr style="display:none">
                                                    <td>
                                                        <input type="hidden" name="destineDateBeginTime"  id="destineDateBeginTime"value="" >
                                                        <input type="hidden" name="destineDateEndTime" id="destineDateEndTime"value="" >
                                                        <input type="text" name="destineDate"  class="Wdate whir_datebox" onfocus="WdatePicker({el:'destineDate',isShowWeek:true})" value="<%=formatter.format(applyDate)%>"/>
                                                        <select name="startHour" style="font-size:9pt;width:6%;" class="selectlist">
                                                            <%for(int hi=0;hi<24;hi++){
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
                                                        <input type="text" name="destineDate" class="Wdate whir_datebox" onfocus="WdatePicker({el:'destineDate',isShowWeek:true})" value="<%=formatter.format(destineDate)%>" 
                                                        disabled='true'/>
                                                
                                                
                                                        <input type="hidden" name="startHour" value="<%=startTime/3600%>">
                                                         <input type="hidden" name="startMinutes" value="<%=(startTime%3600)/60%>">
                                                        <input type="hidden" name="endHour" value="<%=endTime/3600%>">
                                                        <input type="hidden" name="endMinutes" value="<%=(endTime%3600)/60%>">
                                                       
                                                        <select name="startHour" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <% for(int hi=0;hi<24;hi++){
                                                                String selected = hi==startTime/3600 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
                                                            <%}%>
                                                        </select>&nbsp;时&nbsp;<select name="startMinutes" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <%for(int mi=0;mi<60;){
                                                                String selected = mi==(startTime%3600)/60 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
                                                            <%
                                                            mi+=5;
                                                            }%>
                                                        </select>&nbsp;分至&nbsp;<select name="endHour" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <%for(int hi=0;hi<24;hi++){
                                                                String selected = hi==endTime/3600 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
                                                            <%}%>
                                                        </select>&nbsp;时&nbsp;<select name="endMinutes" style="font-size:9pt;width:6%;" 
                                                        class="selectlist" disabled>
                                                            <%for(int mi=0;mi<60;){
                                                                String selected = mi==(endTime%3600)/60 ? "selected":"";
                                                            %>
                                                            <option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
                                                            <%
                                                            mi+=5;
                                                            }%>
                                                        </select>&nbsp;分&nbsp;
                                                        
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

                                    <!-- <tr style="<%=isTempAddress?"":"display:none"%>">
                                        <td for="地点" nowrap="nowrap">&nbsp;&nbsp;地点<span class="MustFillColor">*</span>：</td>
                                        <td colspan="3">
                                            <s:textfield name="boardRoomApplyPO.addr" id="addr" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':200}]" cssStyle="width:95%;" 
                                        maxlength="200"/>
                                        </td>
                                    </tr> -->
									<%if(request.getAttribute("isVideo")!=null && ("0".equals(request.getAttribute("isVideo").toString())||"2".equals(request.getAttribute("isVideo").toString()))){ %>
									 <tr>
                                        <td for="地点" nowrap="nowrap">&nbsp;&nbsp;地点<span class="MustFillColor">*</span>：</td>
                                        <td colspan="3">
                                            <s:textfield name="boardRoomApplyPO.addr" id="addr" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':200}]" cssStyle="width:95%;" 
                                        maxlength="200"/>
                                        </td>
                                    </tr>
									<%
                                      }else{
                                      %>
                                    <tr>
                                        <td for="点数">&nbsp;&nbsp;点数<span class="MustFillColor">*</span>：</td>
                                        <td colspan="3">
                                            
                                             <s:textfield name="boardRoomApplyPO.points" id="points" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':10}]" cssStyle="width:95%;" 
                                            maxlength="10" readonly="true"/>

                                            <s:hidden name="maxNumber" id="maxNumber"/>
                                            &nbsp;
                                        </td>
                                    </tr>
									<%}%>
                                    <tr>
                                        <td for="会议出席人" nowrap="nowrap">&nbsp;&nbsp;会议出席人：</td>
                                        <td colspan="3">
                                            <s:textarea name="boardRoomApplyPO.attendee" id="attendee" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.7%;" readonly="true"/><s:hidden name="boardRoomApplyPO.attendeeEmpId" id="attendeeEmpId"/>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="会议列席人"nowrap="nowrap">&nbsp;&nbsp;会议列席人：</td>
                                        <td colspan="3">
                                             <s:textarea name="boardRoomApplyPO.nonvoting" id="nonvoting" cols="112" rows="2"   cssClass="inputTextarea" cssStyle="width:94.7%;" readonly="true"/><s:hidden name="boardRoomApplyPO.nonvotingEmpId" id="nonvotingEmpId"/>
                                             
                                        </td>
                                    </tr>
									<tr>
                                        <td for="其他参会人员"nowrap="nowrap">&nbsp;&nbsp;其他参会人员：</td>
                                        <td colspan="3">
                                             <s:textarea name="boardRoomApplyPO.otherAttendeePerson" id="otherAttendeePerson" cols="112" rows="2"   cssClass="inputTextarea" cssStyle="width:94.7%;" readonly="true"/>
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
                                             <s:textfield name="boardRoomApplyPO.swPerson" id="swPerson" cssClass="inputText" cssStyle="width:94.7%;" readonly="true"/>
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
                                        <td  for="预定部门" nowrap="nowrap">预定部门：</td>
                                        <td>
                                            <s:textfield name="boardRoomApplyPO.applyOrgName" id="applyOrgName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:88%;" 
                                            maxlength="100" readonly="true"/><s:hidden name="boardRoomApplyPO.applyOrg" id="applyOrg"/>
                                             
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="预定日期">&nbsp;&nbsp;预定日期：</td>
                                        <td>
                                           
                                            <input type="text" name="boardRoomApplyPO.applyDate" id="applyDate"   class="Wdate whir_datebox" onfocus="WdatePicker({el:'applyDate',isShowWeek:true})" value="<%=formatter.format(applyDate)%>" disabled="true"/>
      
                                        </td>
                                        <td  for="联系电话"nowrap="nowrap">联系电话：</td>
                                        <td>
                                            
                                            <s:textfield name="boardRoomApplyPO.linkTelephone" id="linkTelephone" cssClass="inputText" whir-options="vtype:['tel',{'maxLength':20}]" cssStyle="width:88%;" 
                                        maxlength="20" readonly="true"/>
                                       
                                        </td>
                                    </tr>
                                 
                                    <tr>
                                        <td for="席卡">&nbsp;&nbsp;席卡：</td>
                                        <td colspan="3">
                                            
                                            <s:textarea name="boardRoomApplyPO.seatcard" id="seatcard" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.7%;" readonly="true"/>
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="备注">&nbsp;&nbsp;备注：</td>
                                        <td colspan="3">
                                            
                                            <s:textarea name="boardRoomApplyPO.remark" id="remark" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:94.7%;" readonly="true"/>
                                           
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
                                            <jsp:param name="height"		 value="16" />
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
                                            <input type="checkbox" name="bdEqu"  value="<%=po.getEquId()%>" <%if(boardEquipment.indexOf(po.getEquId()+"")>-1){%>checked<%}%> disabled><%=po.getEquName()%>&nbsp;
                                            <input type="hidden" name="bdEquName" value="<%=po.getEquName()%>">
                                            <%}%>
                                           
                                        </td>
                                    </tr>
                                     <%
                                      }}%>
                                    <s:hidden name="boardRoomApplyPO.boardEquipment" id="boardEquipment"/>
                                    <input type="hidden" name="emphasis"  id="emphasis">
                                </table>
                                <br />
                                <table width="100%" border="0" cellpadding="0" cellspacing="0" id="report_table" style="display:" >
                                    <tr>
                                        <td align="center" width="100%">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="inlineBottomLine">
                                                <tr><td height="10"></td></tr>
                                                <tr>
                                                    <td width="100%" nowrap="nowrap" align="left">
                                                        <span id="_Panle1" onClick="changePanle1(1);" style="color:red;cursor:hand">回复信息</span>
                                                        | <span id="_Panle5" onClick="changePanle1(5);" style="color:black;cursor:hand">回复信息统计</span>
                                                        | <span id="_Panle3" onClick="changePanle1(3);" style="color:black;cursor:hand">查看情况</span>
                                                        <%
                                                        String notePerson = request.getAttribute("notePerson")+"";
                                                        if(("true".equals(request.getParameter("executeStatus")) ||
                                                        ("$"+userId+"$").equals(notePerson)) && (request.getParameter("meetingId") !=null && !"".equals(request.getParameter("meetingId"))) ){
                                                        %>
                                                        | <span id="_Panle4" onClick="changePanle1(4);" style="color:black;cursor:hand">会议执行情况</span>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="docBoxNoPanel">
                                                <tr>
                                                    <td height="100" valign="top">
                                                        <div id="div_1" style="display:block">
                                                            <iframe  id="reports" name="reports" src="${ctx}/boardRoom!applyReportList.action?boardroomApplyId=<%=boardroomApplyId%>&isView=<%=request.getParameter("isView")%>" scrolling="no" frameborder="0"  style="width:100%"></iframe>
                                                            
                                                        </div>
                                                        <div id="div_5" style="display:none">
                                                            <iframe  id="tj" name="tj" src="<%=rootPath%>/modules/subsidiary/boardroom/boardRoomApply_tj.jsp?boardroomApplyId=<%=boardroomApplyId%>" scrolling="no" frameborder="0"  style="width:100%"></iframe>
                                                        </div>
                                                        <div id="div_2" style="display:none">
                                                        </div>
                                                        <div id="div_3" style="display:none">
                                                        </div>
                                                        <%
                                                        if(!"false".equals(request.getParameter("executeStatus"))){
                                                        %>
                                                        <div id="div_4" style="display:none">
                                                        </div>
                                                        <%}%>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
								
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/work_flow/operate/wf_include_form.jsp"%>
						    </div>
                             <!--批示意见包含页-->
							
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo4" class="doc_Content"  style="display:none;"></div>
                 </div>
             </td>
         </tr>
     </table>
     <input type="hidden" name="addDivContent"id="addDivContent" value=""> <!-- 在  常用语中用到-->
     </s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
</body>
<script type="text/javascript">
function changePanle1(id){
	for(i=0;i<=5;i++){
 	 	if(document.getElementById("_Panle"+i)){
	 		document.getElementById("_Panle"+i).style.color = "black";
	 	}
 	 	if(document.getElementById("div_"+i)){
	 		document.getElementById("div_"+i).style.display = "none";
	 	}
  	}
	if(document.getElementById("_Panle"+id)){
		document.getElementById("_Panle"+id).style.color = "red";
	}
	if(document.getElementById("div_"+id)){
		document.getElementById("div_"+id).style.display = "";
	}

	if(id==1){
		//document.all.reports.src="BoardRoomAction.do?action=applyReportList&boardroomApplyId=<%=boardroomApplyId%>&isView=<%=request.getParameter("isView")%>";
	}
	if(id==5){
		document.getElementById("tj").src="<%=rootPath%>/modules/subsidiary/boardroom/boardRoomApply_tj.jsp?boardroomApplyId=<%=boardroomApplyId%>";
	}
    if(id==4){
		var url='${ctx}/boardRoom!executeStatus.action?boardroomApplyId=<%=boardroomApplyId%>&meetingId=<%=meetingId%>';
        openWin({url:url,width:650,height:500,winName:'executeStatus'});
        
	}
     if(id==3){
		//var url='${ctx}/boardRoom!unviewUsers.action?boardroomApplyId=<%=boardroomApplyId%>&fromtype=boardroom';
        //openWin({url:url,isFull:'true',winName: 'viewUsers' });
        openWin({url:'realtimemessage!onlinelist.action?id=<%=boardroomApplyId%>&fromtype=boardroom',isFull:'true',winName: 'viewUsers' });
	}
}
function viewUser(flag){
	if(flag == '1'){
		var win = MM_openBrWindow('BoardRoomAction.do?action=viewUsers&boardroomApplyId=<%=boardroomApplyId%>&yhlx=qb','win1','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=650,height=500');
	} else if(flag == '0'){
		var win = MM_openBrWindow('BoardRoomAction.do?action=unviewUsers&boardroomApplyId=<%=boardroomApplyId%>&yhlx=qb','win2','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=650,height=500');
	}
}
    var screenwidth;//分辨率宽度
    var screenheight;//分辨率高度
    screenwidth = screen.availWidth-5;
    screenheight = screen.availHeight-18;

/**
 切换页面
 */
function  changePanle(flag){
	for(var i=0;i<5;i++){
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
}
/**
初始话信息
*/
function initBody(){
	//初始话信息
    ezFlowinit();
    var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
    window.resizeTo(windowWidth,windowHeight);
    //$("#boardroomId").val('<%=boardroomId%>');
}


</script>
</html>

