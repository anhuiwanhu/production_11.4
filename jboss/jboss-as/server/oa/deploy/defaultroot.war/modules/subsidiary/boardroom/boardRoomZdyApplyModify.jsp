<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.ezform.ui.*"%>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	com.whir.ezoffice.boardroom.po.BoardRoomApplyPO boardRoomApplyPO=null;
	if(request.getAttribute("boardRoomApplyPO") !=null){
		boardRoomApplyPO = (com.whir.ezoffice.boardroom.po.BoardRoomApplyPO)request.getAttribute("boardRoomApplyPO");
	}
	
	com.whir.ezoffice.bpm.bd.BPMInstanceBD bPMInstanceBD=new com.whir.ezoffice.bpm.bd.BPMInstanceBD();
	String code=bPMInstanceBD.getEzFlowFormCode(boardRoomApplyPO.getBoardroomApplyId(),15);
	ParserHtml parse = new ParserHtml();

	String meetingAttendance =boardRoomApplyPO.getMeetingAttendance()==null?"":boardRoomApplyPO.getMeetingAttendance().toString();;
	String attendancetype =boardRoomApplyPO.getAttendancetype()==null?"":boardRoomApplyPO.getAttendancetype().toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改使用记录</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%
		whir_custom_str="easyui,tagit";
	%>
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body>
	<div class="BodyMargin_10" >  
		<div class="docBoxNoPanel">
			<s:form name="dataForm" id="dataForm" action="${ctx}/boardRoom!modifyBoardroomZdyApply.action" method="post" theme="simple" >
				<input type="hidden" name="boardroomApplyId" id="boardroomApplyId" value="<%=boardRoomApplyPO.getBoardroomApplyId()%>">
				<jsp:include page="/platform/custom/ezform/run/showform.jsp" flush="true">
					<jsp:param name="formCode" value="<%=code%>"/>
					<jsp:param name="infoId" value="<%=boardRoomApplyPO.getBoardroomApplyId()%>"/>
					<jsp:param name="p_wf_openType" value="waitingDeal"/>
					<jsp:param name="p_wf_moduleId" value="15"/>
					<jsp:param name="canModify" value="1"/>
				</jsp:include>
				<table width="100%" border="0" cellpadding="2" cellspacing="1" class="Table_bottomline">
					<tr>
						<td for="启用会议签到" width="15%">&nbsp;&nbsp;启用会议签到：</td>
						<td colspan="3">
							<input type="radio" name="meetingAttendance"  value="0" <%if(meetingAttendance.equals("") || meetingAttendance.equals("0")){%>checked<%}%>>是
							<input type="radio" name="meetingAttendance"  value="1" <%if(meetingAttendance.equals("1")){%>checked<%}%>>否
						</td>
					</tr>
					<tr>
						<td for="签到方式">&nbsp;&nbsp;签到方式：</td>
						<td colspan="2">
							<input type="radio" name="attendancetype"  value="0" <%if(attendancetype.equals("") || attendancetype.equals("0")){%>checked<%}%>>主动扫码
							<input type="radio" name="attendancetype"  value="1" <%if(attendancetype.equals("1")){%>checked<%}%>>被动扫码
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
				</table>  
			</s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
	function save(n,obj) {
		var formId = $(obj).parents("form").attr("id");
		var validation = validateForm(formId);
		$(obj).parents("form").find("#saveType").val(n);
		if(beforeSubmit()){
			$('#'+formId).submit();
		}	
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