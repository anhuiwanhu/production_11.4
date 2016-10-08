<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
String userId = session.getAttribute("userId").toString();
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
whir_custom_str="easyui";
if(request.getParameter("gd")!=null&&request.getParameter("gd").toString().equals("1")){
    whir_custom_str+="notip";
}
String boardroomApplyId = request.getParameter("p_wf_recordId")!=null ? request.getParameter("p_wf_recordId") :"";
String meetingId = request.getParameter("meetingId") !=null ? request.getParameter("meetingId") : "";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%=request.getAttribute("p_wf_processName")%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--工作流包含页 js文件-->
   	<%@ include file="/public/include/meta_base_bpm.jsp"%>
<!-- 		<style type="text/css">
 .doc_Scroll2{    height:93%;  position:relative; overflow:auto;  left:0; top:35px;  _top:0px;}
 .doc_Scroll{background:#fff; min-height:93%;   height:93%; overflow-y:auto;}
</style>
 -->
<style type="text/css">
   .docBodyStyle{ 
     overflow:auto;
  } 
  .doc_Scroll{    height:96%; width:100%; margin-top:33px;  overflow:visible;  }
</style>
</head>
<body class="docBodyStyle"  onload="initBody();viewPrint();commentWidth();"> 
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>

	<!--style="position:relative;"-->
	<div class="doc_Scroll"  >
	<s:form name="dataForm" id="dataForm" action="ezflowoperate!showSend.action" method="post" theme="simple" >
	 <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle"  id="id_doc_movetitle">
					     <div class="docRight" ><bean:message bundle="workflow" key="workflow.st"/><span class="redBold" id="viewPrintNum">0</span><bean:message bundle="workflow" key="workflow.printst"/></div>
						 <ul>
							  <li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" ><bean:message bundle="workflow" key="workflow.newactivitybasicinfo"/></a></li>
							  <li id="Panle1"><a href="#" onClick="changePanle(1);"><bean:message bundle="workflow" key="workflow.newworkflowchart"/></a></li> 
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);"><bean:message bundle="filetransact" key="file.workflowrecord"/></a></li>
							  <li id="Panle4" ><a href="#" onClick="changePanle(4);"><bean:message bundle="workflow" key="workflow.ezFLOWDescription"/></a>
							  <li id="Panle3" ><a href="#" onClick="changePanle(3);"><bean:message bundle="workflow" key="workflow.Relatedworkflow"/><span class="redBold" id="viewrelationnum"></span></a></li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content" >
							<!--表单包含页 -->
							<div>
							  
							   <div> 
							     <%@ include file="/platform/bpm/pool/pool_include_showform.jsp"%>	
							  </div>
							  
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
                                                            <iframe  id="reports" name="reports" src="${ctx}/boardRoom!applyReportList.action?boardroomApplyId=<%=boardroomApplyId%>&isView=<%=EncryptUtil.htmlcode(request.getParameter("isView"))%>" scrolling="no" frameborder="0"  style="width:100%"></iframe>
                                                            
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

							</div>	 
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
							<!--批示意见包含页-->
							<div id="comment_outDiv" style="margin:0 auto;padding:0px 0px 0px 0px;">
                                <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>   
							</div>
				      </div>
					  <div id="docinfo1" class="doc_Content"  style="display:none;text-align:center" ></div>
					  <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					  <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					  <div id="docinfo4" class="doc_Content"  style="display:none;"></div>
                 </div>
             </td>
         </tr>
     </table>
     </s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>             
    <!--归档时用的form -->  
    <form name="form4" action="<%=rootPath%>/platform/bpm/ezflow/operation/ezflow_gd.jsp?gd=1" method="POST">
	  <input type="hidden" name="pageContent">
	  <input type="hidden" name="gd_processInstanceId"  value='<%=request.getAttribute("p_wf_processInstanceId")+""%>' />
	  <input type="hidden" name="gd_title"              value='<%=request.getAttribute("p_wf_processName")+""%>' />
	  <input type="hidden" name="gd_startUserCode"   value='<%=request.getAttribute("p_wf_submitUserAccount")+""%>' />
	  <input type="hidden" name="gd_startUserName"     value='<%=request.getAttribute("p_wf_submitPerson")+""%>' />
	  <input type="hidden" name="gd_startTime"       value='<%=request.getAttribute("p_wf_submitTime")+""%>'  />
	  <input type="hidden" name="gd_startOrgId"       value='<%=request.getAttribute("p_wf_startOrgId")+""%>'  />
    </form>
</body>
<script type="text/javascript">



/***
批示意见框的位置
*/
function commentWidth(){
   var  table=$("#formHTML").find("table").first();
   $("#comment_outDiv").width(table.width()+6); 

   if($("#trigger1_auto").length>0){
	    $("#trigger1_auto").powerFloat();  
   } 
   if($("#trigger1").length>0){
	    //$("#trigger1").powerFloat({offsets :{x:0, y:135} }); 
		$("#trigger1").powerFloat(); 
   } 

   <%if(request.getParameter("gd") != null){%>
     gd();
   <%}%>
}

//归档
function gd(){
	$("#id_doc_movetitle").remove(); 
	$("#popToolbar").remove();
	form4.pageContent.value = document.body.innerHTML;
	form4.submit();
}

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

	//显示流程描述
	if(flag=="4"){
	   showPrcosssDescription("docinfo4");
	}
 
}

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
		<%--//document.all.reports.src="BoardRoomAction.do?action=applyReportList&boardroomApplyId=<%=boardroomApplyId%>&isView=<%=request.getParameter("isView")%>";--%>
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

/**
初始话信息
*/
function initBody(){
	//初始话信息
    ezFlowinit(); 
}
 
</script>
</html>

