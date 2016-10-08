<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>

<%@ page import="java.text.*"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardRoomApplyPO"%>
<%@ page import="com.whir.ezoffice.boardroom.po.BoardroomMeetingTimePO"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String pageOffSet = request.getParameter("pageOffSet")!=null&&
					!"".equals(request.getParameter("pageOffSet"))&&
					!"null".equals(request.getParameter("pageOffSet"))?request.getParameter("pageOffSet"):"0";

String isNew = (String)request.getAttribute("isNew");

//会议记录人
String notePerson = request.getAttribute("notePerson")+"";
String userId = request.getSession(true).getAttribute("userId").toString();
boolean isNotePerson = false;
if(notePerson.indexOf("$"+userId+"$")>=0){

  isNotePerson = true;
}

String meetingId = request.getParameter("meetingId");
if(meetingId == null || "".equals(meetingId) || "null".equals(meetingId)){
	meetingId = (String)request.getAttribute("meetingId");
}

BoardRoomApplyPO po = new BoardRoomApplyPO();
if(request.getAttribute("boardroomApplyPO")!=null){
	po = (BoardRoomApplyPO)request.getAttribute("boardroomApplyPO");
}

Set ms = null;
String year="";
String month="";
String day="";
String shour="";
String sminutes="";
String ehour="";
String eminutes="";

String descriptions="";
if(request.getAttribute("meetingTime")!=null){
	ms = (Set)request.getAttribute("meetingTime");
	Iterator itor = ms.iterator();

	while(itor.hasNext()){
		BoardroomMeetingTimePO tt = (BoardroomMeetingTimePO)itor.next();
		if(meetingId.equals(tt.getId().toString())){

			Date destineDate = tt.getMeetingDate();
			year = Integer.toString(destineDate.getYear()+1900);
			month = Integer.toString(destineDate.getMonth()+1);
			day = Integer.toString(destineDate.getDate());
			int startTime =Integer.parseInt(tt.getStartTime());
			shour=startTime/3600+"";
			sminutes=(startTime%3600)/60+"";
			int endTime = Integer.parseInt(tt.getEndTime());
			ehour=endTime/3600+"";
			eminutes=(endTime%3600)/60+"";

			descriptions = tt.getDescriptions()!=null?tt.getDescriptions():"";
			break;
		}
	}
}

 if(sminutes.length()<2){
   sminutes = "0"+sminutes;
 }
 if(eminutes.length()<2){
   eminutes = "0"+eminutes;
 }


try{
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>会议执行情况</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
<script language="javascript">

</script>
<style type="text/css">
.remark_td1{
	border-top:solid 1px #000000;
	border-right:solid 1px #000000;
	border-color:black
}
.remark_td2{
	border-top:solid 1px #000000;
	border-color:black
}
</style>
</head>

<body leftmargin="0" topmargin="0" onload="resizeWin(800,650);window.focus();"  class="MainFrameBox Pupwin">
<s:form name="dataForm" id="dataForm" action="${ctx}/boardRoom!saveExecuteStatus.action" method="post" theme="simple" >
<table width="100%" border="0" cellpadding="2" cellspacing="1" class="docBoxNoPanel">
	<input type="hidden" name="boardroomApplyId" value="<%=po.getBoardroomApplyId()%>"/>
	<input type="hidden" name="meetingId" value="<%=meetingId%>"/>
    <input type="hidden" name="pageOffSet" value="<%=pageOffSet%>"/>
	<tr>
		<td align="center" style="font-size:15pt"><b>会议执行情况</b></td>
	</tr>
	<tr>
		<td align="left">&nbsp;会议编号：&nbsp;<%=po.getBoardroomCode()!=null?po.getBoardroomCode():""%></td>
	</tr>
	<tr>
		<td align="left">&nbsp;会议主题：&nbsp;<%=po.getMotif()%></td>
	</tr>
	<tr>
		<td align="left">&nbsp;会议时间：&nbsp;<%=year%>年<%=month%>月<%=day%>日 <%=shour%>：<%=sminutes%> - <%=ehour%>：<%=eminutes%></td>
	</tr>
	<tr>
		<td align="center" style="font-size:11pt">会议签到表</td>
	</tr>
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<%
					if(isNotePerson){
				%>
				<tr>
					<td colspan="4">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="90%"></td>
								<td nowrap="nowrap" align="right">
									<input type="button" class="btnButton4font" onclick="addROW2();" value='<s:text name="comm.add"/>' />
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<%}%>
				<tr>
					<td colspan="4">
						<table id="tbl_2" width="100%" border="0" cellpadding="0" cellspacing="0" style="border:solid 1px #000000;border-color:black; ">
							<tr height="25" align="center" style="background-color:#D3D3D3;border-bottom:solid 1px #000000;border-color:black">
								<td width="25%" style="border-right:solid 1px #000000;border-color:black" for="部门">部门</td>
								<td width="15%" style="border-right:solid 1px #000000;border-color:black" for="姓名">姓名</td>
								<td width="10%" style="border-right:solid 1px #000000;border-color:black" >是否参会</td>
								<td width="10%" style="border-right:solid 1px #000000;border-color:black" >是否签到</td>
								<td width="35%" style="border-right:solid 1px #000000;border-color:black" for="备注">备注</td>
								<td width="5%"style="border-color:black">操作</td>
							</tr>
							<%
								List list = (List)request.getAttribute("list");
								if(list!=null && list.size()>0){
									Object[] obj=null;
									for(int i=0; i<list.size(); i++){
										obj = (Object[])list.get(i);
							%>
							<tr>
								
								<td class="remark_td1" style="word-break:break-all">
                                    <%=obj[3]!=null?obj[3].toString():""%>
                                    <input type="hidden" name="orgName" value="<%=obj[3]!=null?obj[3].toString():""%>" />
                                    <input type="hidden" name="orgId" value="<%=obj[2]%>"/>
									<input type="hidden" name="bespoId" value="<%="true".equals(isNew)?"":(obj[6]!=null&&!"".equals(obj[6].toString())?obj[6].toString():"")%>"/>&nbsp;
                                </td>
								<td class="remark_td1">
                                    <%=obj[1]!=null?obj[1].toString():""%>
                                    <input type="hidden" name="empName" value="<%=obj[1]!=null?obj[1].toString():""%>">
                                    <input type="hidden" name="empId" value="<%=obj[0]%>">&nbsp;
                                </td>
								<td class="remark_td1" align="center">
                                    <input type="checkbox" name="isjoined" value="1" <%="true".equals(isNew)?"checked":(obj[4]!=null&&"1".equals(obj[4].toString())?"checked":"")%> onclick="selectIsjoined(this, event);"/>
                                    <input type="hidden" name="isjoined_val" value="<%="true".equals(isNew)?"1":(obj[4]!=null&&"1".equals(obj[4].toString())?"1":"0")%>"/>
                                </td>
								<td class="remark_td1" align="center">
                                    <%
									if(obj[8] !=null && !"".equals(obj[8].toString()) && "0".equals(obj[8].toString())){
										out.print("已签到");
									}else{
										out.print("未签到");
									}
									%>
                                </td>
								<td class="remark_td1" style="word-break:break-all" align="center">
                                    <textarea name="memo" style="height:expression(this.scrollHeight+5);overflow:hidden;width:98%;" rows="1" class="inputTextarea" id="memo<%=i%>" whir-options="vtype:[{'maxLength':50}]"><%="true".equals(isNew)?"":(obj[5]!=null?obj[5].toString():"")%></textarea>
                                </td>
								<td class="remark_td2">
								</td>
							</tr>
							<%}}%>
							
						</table>
						
					</td>
				</tr>

			</table>
		</td>
	</tr>
	<tr height="25">
		<td align="center" style="font-size:11pt">会议异常情况说明</td>
	</tr>
    <br/>
	<tr height="25" class="Table_nobttomline">
		<td align="center">
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
					<td>
						<textarea name="descriptions" id="descriptions" cols="100" rows="3" style="width:100%"  whir-options="vtype:[{'maxLength':1000}]"  class="inputTextarea" maxlength="1000"><%=descriptions%></textarea>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<%
				if(isNotePerson){
			%>
              <input type="button" class="btnButton4font" onClick="ok(0,this);" value='<s:text name="comm.saveclose"/>' />
			<%}%>
            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' /> 
		</td>
	</tr>
	</s:form>
</table>

</body>

<%}catch(Throwable e){e.printStackTrace();}%>
<script language="JavaScript">
<!--
//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

var count=0;

//增加行
function addROW2() {
  	var str='';
	str+="<td class='remark_td1' align='center'><input type='text' id='orgName_1_"+count+"' name='orgName_1' class='inputText' style='width:98%' value='' maxlength='100' whir-options=\"vtype:[{'maxLength':100}]\"/><input type='hidden' name='orgId_1'></td>";

	str+="<td class='remark_td1' align='center'><input type='text'id='empName_1_"+count+"' name='empName_1' class='inputText' style='width:98%' value='' maxlength='20' whir-options=\"vtype:[{'maxLength':30}]\"/><input type='hidden' name='empId_1'></td>";

	str+="<td class='remark_td1' align='center'><input type='checkbox' name='isjoined_1' value='1' checked onclick='selectIsjoined1(this, event);'/><input type='hidden' name='isjoined_val_1' value='1'></td>";

	str+="<td class='remark_td1' align='center' style='word-break:break-all'><textarea id='memo_1_"+count+"' name='memo_1' class='inputTextarea' style='height:expression(this.scrollHeight+5);overflow:hidden;width:98%;' whir-options=\"vtype:[{'maxLength':50}]\" maxlength='50' rows='1'></textarea></td>";
	
	str+="<td class='remark_td2' align='center'><img width='13' height='13' border='0' src='<%=rootPath%>/images/del.gif' style='cursor:hand' onClick='javascript:$(this).parent(\"td\").parent(\"tr\").remove();' title='删除'></td>";
    $('#tbl_2').append("<tr>"+str+"</tr>");
    setStyle();//重新渲染鼠标放到输入框上的样式
    //$("input:checkbox").uniform();
    count=count+1;
}
//查找顺序值
	function findIndex(field,evt){
		var popIndex = 0;
		var target = window.event?window.event.srcElement.parentElement:evt.target.parentNode;
		var field_obj = document.getElementsByName(field);
		for (var i = 0; i < field_obj.length; i++) {
			var val=field_obj[i].value;
			var parentElement=window.event?field_obj[i].parentElement:field_obj[i].parentNode;
			if (target == parentElement) {
				popIndex=i;
				break;
			}
		}
		return popIndex;
	}

function selectIsjoined(obj, event){
    var index=findIndex("isjoined",event);
	if(obj.checked){
        $('input[name=isjoined_val]')[index].value="1";
	}else{
        $('input[name=isjoined_val]')[index].value="0";
	}
}
function selectIsjoined1(obj, event){
    var index=findIndex("isjoined_1",event);
	if(obj.checked){
        $('input[name=isjoined_val_1]')[index].value="1";
	}else{
        $('input[name=isjoined_val_1]')[index].value="0";
	}
}
//-->
</script>
</html>