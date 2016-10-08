<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>收文</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform.css">
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform_ext.css">
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <!--工作流包含页 js文件-->  
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
 	<script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/receive.js"   type="text/javascript"></script>
	<style type="text/css">
	<!--
	.sw {
		background:transparent;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 1px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		border-bottom-color: #CCCCCC;
	}
	.inputTextsw {
		background:transparent;
		border-top-width: 0px;
		border-right-width: 0px;
		border-bottom-width: 1px;
		border-left-width: 0px;
		border-top-style: solid;
		border-right-style: solid;
		border-bottom-style: solid;
		border-left-style: solid;
		border-bottom-color: #CCCCCC;
	}

	#noteDiv_toPerson1 {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPersonBao {
		position:absolute;
		width:220px;
		height:126px;
		z-index:1;
		overflow:auto;
		border:1px solid #829FBB;
		display:none;
	}
	#noteDiv_toPerson2 {
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
		padding-left:5px;
	}
	.divOut{
		background-color:#ffffff;
		color:#000000;
		border-bottom:1px dashed #cccccc;
		width:100%;
		height:20px;
		line-height:20px;
		cursor:default;
		padding-left:5px;
	}
	.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:"宋体"}
	
	-->
	</style>
	 <style type="text/css">
        html,body{ height:100%; overflow:hidden; margin:0; padding:0;}
    </style>

    <script type="text/javascript">
    $(function(){
     var bh = $("body").height();
     var dh = bh-47;
     $("#mainContent").height(dh);
    });
    </script>
		<%@ include file="/public/include/include_extjs.jsp"%>


	<script language="javascript" src="/defaultroot/scripts/i18n/zh_CN/WorkflowResource.js" type="text/javascript"></script>
	<script language="javascript" src="/defaultroot/platform/custom/ezform/js/ezform.js"></script>
	<script language="javascript" src="/defaultroot/platform/custom/ezform/js/popselectdata.js"></script>
	<script language="javascript" src="/defaultroot/scripts/util/textareaAutoHeight2.js"></script>
</head>
<body  class="docBodyStyle"   style="position:relative; height:100%;"     onload="initBody();">
<s:hidden name="pdfnum"/>
<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
<%
	//System.out.println("[[[[[[[[[[[[[[[[[[[["+request.getAttribute("p_wf_modiButton"));;

	 org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(java.lang.System.class.getName());
	 
String workStatus = request.getAttribute("p_wf_workStatus")==null?"1":(String)request.getAttribute("p_wf_workStatus");
String receiveStatus=request.getAttribute("receiveStatus")==null?"":request.getAttribute("receiveStatus").toString();
//判断是新老工作流
String processType = request.getAttribute("p_wf_pool_processType") ==null?"":request.getAttribute("p_wf_pool_processType").toString();
String modiButton = null ;//"none";
boolean showBackButton = false;
if("0".equals(processType)){
	showBackButton = true;
}
if(request.getParameter("isEdit")!=null&&"1".equals(request.getParameter("isEdit").toString())){
  
 //办理完毕 
 if(receiveStatus.equals("1")){
  	if("1".equals(request.getParameter("isBack"))){
 		modiButton=",Print,Tosend,Saveclose";
 	}else{
 		logger.error("wf_workStatus:"+request.getAttribute("p_wf_workStatus"));
 		modiButton=",Back,Print,Tosend,Saveclose";
		if(!("1".equals(request.getAttribute("p_wf_workStatus")) || "101".equals(request.getAttribute("p_wf_workStatus")) 
				|| ("100".equals(request.getAttribute("p_wf_workStatus")) && showBackButton))  ){
			modiButton=",Print,Tosend,Saveclose";
		}
 	}
 }
 //办理中
 else{
 //System.out.println("_______________________________________________ISBACK__"+request.getParameter("isBack"));
 	if(!"1".equals(request.getParameter("isBack"))){
  		modiButton=",Wait,Back,Print,Tosend,Saveclose";
  		//logger.error("wf_workStatus:"+request.getAttribute("p_wf_workStatus"));
  		//gexiang  modify 2015-11-3 如果是收文管理中的老流程 点击修改流程时 p_wf_workStatus = 0(待办),100(办理完毕) 102(已阅)
		if(!("1".equals(request.getAttribute("p_wf_workStatus")) || "101".equals(request.getAttribute("p_wf_workStatus")) 
				|| "0".equals(request.getAttribute("p_wf_workStatus")) || "102".equals(request.getAttribute("p_wf_workStatus"))) ){
			modiButton=",Wait,Print,Tosend,Saveclose";
		}
  	}else{
  		modiButton=",Wait,Print,Tosend,Saveclose";
  	}
 }
 
}else if(request.getParameter("viewOnly")!=null&&"1".equals(request.getParameter("viewOnly").toString())){
	modiButton="";
}

if(!"waitingRead".equals(  request.getParameter("p_wf_openType")   ) && (request.getAttribute("p_wf_processId")==null||request.getAttribute("p_wf_processId").toString().equals("")||request.getAttribute("p_wf_processId").toString().equals("null"))){
	modiButton="";
}

if( !"waitingRead".equals(  request.getParameter("p_wf_openType")   ) && workStatus.equals("-1")){
	modiButton="";
}

if(!"waitingRead".equals(  request.getParameter("p_wf_openType")   ) && workStatus.equals("2")){
modiButton="none";
//modiButton=",End,Viewtran";

}
//System.out.println("=================================================================================" + modiButton);
if(request.getParameter("fromdesktop")!=null && !"null".equals(request.getParameter("fromdesktop")) && "2".equals(request.getParameter("fromdesktop"))){
	modiButton="";
}
String commentNotNull = request.getAttribute("commentNotNull")==null?"0":request.getAttribute("commentNotNull").toString();//批示意见是否可以为空
//
if( "dealwith".equals(  request.getParameter("from") ) )
if( "1".equals( workStatus) ){
	modiButton=",Wait,Print,Cancel,EmailSend,AddNew,Tosend,Tocheck";
}else if("1011".equals( workStatus)){
	modiButton=",Print,EmailSend,AddNew";
}
//if( "waitingRead".equals(  request.getParameter("p_wf_openType")   ) ){
//	modiButton=",Send,EmailSend,Print,";
//}
if( "blcyview".equals(  request.getParameter("from") ) || "blcyedit".equals(  request.getParameter("from") ) ){
	request.setAttribute("p_wf_concealField","");
}
if( "blcyview".equals(  request.getParameter("from") ) ){
	 modiButton = (String)request.getAttribute("p_wf_modiButton");
	 modiButton = modiButton.replace("ReadHistorytext","");
	 modiButton = modiButton.replace("GovRead","");
	 request.setAttribute("p_wf_modiButton",modiButton);
	 modiButton = null;
}
if( "startAgain".equals(  request.getAttribute("p_wf_openType") ) || "reStart".equals(  request.getAttribute("p_wf_openType") ) ){
	modiButton=",Send,Relation";

}
if(modiButton == null){
	 modiButton = (String)request.getAttribute("p_wf_modiButton");
}//System.out.println("_______________________________________________modiButton__"+modiButton);
	request.setAttribute("p_wf_modiButton",modiButton.replaceAll(",Saveclose,",","));
	//System.out.println("[[[[[[[[[[[[[[[[[[[["+request.getAttribute("p_wf_modiButton"));;
	%>
       <!--包含头部--->
		 <div style="height:37px; position:absolute; top:0; width:100%;z-index:1000;" >
	<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
		</div>
	 <div class="" id="mainContent" style="overflow-y:auto; position:relative; top:47px; width:100%; _width:99%; "><!-- id="mainContent" style="height:100%;width:100%;overflow:auto;"-->

	
	 <s:form name="dataForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >
	 <input type="hidden" name="createdEmp" value="<%=request.getAttribute("createdEmp")%>">
	 <input type="hidden" name="createdOrg" value="<%=request.getAttribute("createdOrg")%>">

	 <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline"   >
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
							  <li id="Panle2" ><a href="#" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="javascript:void(0);" onClick="changePanle(3);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <%if( !"1".equals( request.getAttribute("p_wf_pool_processType") ) ){%>
							  <li id="Panle4" ><a href="#" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
							  <%}%>
							  <li id="Panle5" ><a href="#" onClick="changePanle(5);">相关发文</a></li>
							  <li id="Panle6" ><a href="#" onClick="changePanle(6);">PDF批注</a><span class="redBold" id="viewpdfnum"></span></li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content"  align="center">
							<!--表单包含页--><!--<input type="button" value="保存草稿" onclick="cmdSaveDraft()">
											 <input type="button" value="起草正0文" onclick="wordWindowFirst()">-->

							<div  align="center"> 
							<%
							com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
							String tableId_form =(String) request.getAttribute("p_wf_tableId" );
							List tableInfoList = sendFileBD.getWfTableInfoByTableId(tableId_form); // 根据tableId
							// 找table
							// 信息
							String tableName = "";
		

							if (tableInfoList != null && tableInfoList.size() > 0) {
								Object[] tableInfoObj = (Object[]) tableInfoList.get(0);
								tableName = "" + tableInfoObj[0];
							}
							if (tableName.equals("收文表") || "23".equals(tableId_form)) { //
								tableId_form = "standard";
							}
							
							
							String add = "/modules/govoffice/gov_documentmanager/forms/edit_"+tableId_form+"_receiveform_include.jsp"; 
							 File file = new File(request.getRealPath("") +
                                        add);
								if (!file.exists()) {
									new com.whir.govezoffice.documentmanager.actionsupport.GovCustomAction().replayGovCustomPage(request,tableId_form,"1","0");
							 
								}
							%> 
							
								<jsp:include page="<%=add %>"></jsp:include>  

								
							</div>	
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
							<div>  
							 <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
							</div>
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo4" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo5" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo6" class="doc_Content"  style="display:none;"></div>
                 </div>
				 
             </td>
         </tr>
     </table>
	 </s:form>
	  <%
	  String  accessoryName1=request.getAttribute("accessory1")==null?"":request.getAttribute("accessory1").toString();
	  String  accessorySaveName1=request.getAttribute("accessorySave1")==null?"":request.getAttribute("accessorySave1").toString();

      String  accessoryName2=request.getAttribute("accessory2")==null?"":request.getAttribute("accessory2").toString();
	  String  accessorySaveName2=request.getAttribute("accessorySave2")==null?"":request.getAttribute("accessorySave2").toString();

      String orgId2=session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
	  String orgName=new com.whir.org.bd.organizationmanager.OrganizationBD().getOrgName(orgId2);
	 %>
	 <form name="gdform" method="POST" action="/defaultroot/modules/govoffice/gov_documentmanager/receivefile_gd.jsp?gd=1">
		<input type="hidden" name="pageContent">
		<input type="hidden" name="fileTitle">
		<input type="hidden" name="fileId" value="<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>">
		<input type="hidden" name="createdEmp" value="<%=session.getAttribute("userId").toString()%>">
		<input type="hidden" name="wh">
		<input type="hidden" name="dateTime">
		<input type="hidden" name="org" value="<%=orgName%>">
		<input type="hidden" name="fileName1" value="<%=accessoryName1%>">
		<input type="hidden" name="saveName1" value="<%=accessorySaveName1%>">
		<input type="hidden" name="fileName2" value="<%=accessoryName2%>">
		<input type="hidden" name="saveName2" value="<%=accessorySaveName2%>">
		
	</form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>


<SCRIPT language=javascript>

/**
 切换页面
 */
function  changePanle(flag){
	//if( flag == 3 ) flag= 2;
	for(var i=0;i<=6;i++){
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
    	//显示流程记录
	if(flag=="2" ){
	   showWorkFlowLog("docinfo2");
	}
	//显示相关附件
	if(flag=="4"){
		showWorkFlowAcc("docinfo4");
	}
  //显示关联流程
	if(flag=="3"){
	   showWorkFlowRelation("docinfo3");
	}
	
	if(flag=="5"){
	    var url="/defaultroot/GovDocReceiveProcess!receiveAssociate.action?receiveFileId=" + $("#p_wf_recordId").val() +"&filetitle="+ encodeURIComponent(document.getElementsByName("receiveFileTitle")[0].value );
//'GovDocReceiveProcess!receiveAssociate.action?winOpen=1&receiveFileId=' + sendFileId+'&filetitle='+filetitle
		var html = $.ajax({url: url,async: false,cache:false}).responseText;

		$("#docinfo"+flag).html(html);
	}
    if(flag=="6"){
        var url="/defaultroot/GovDocReceiveProcess!pdflistbz.action?receiveFileId="+$("#p_wf_recordId").val();
        var html = $.ajax({url: url,async: false,cache:false}).responseText;
        $("#docinfo"+flag).html(html);


    }
}

/**
初始话信息
*/
function initBody(){
	//var windowWidth = window.screen.availWidth;
	//var windowHeight = window.screen.availHeight;
	//window.moveTo(0,0);
	//window.resizeTo(windowWidth,windowHeight);
	//初始话信息
    //ezFlowinit();

}

$(document).ready(function() {
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	//window.resizeTo(windowWidth,windowHeight);
	//initDataFormToAjax({"dataForm":'dataForm'});
	//初始话信息
    ezFlowinit();
    var pdfnum=$("#pdfnum").val();
    if(pdfnum>0){
        $("#viewpdfnum").html("("+pdfnum+")");
    }
});
function gd(){
    //alert("11111111");
//	var toolbarObjs = $('SPAN[id^=Panle]');
//	for(var k=0;k<toolbarObjs.length;k++){
//		if(!(toolbarObjs[k].innerText=='基本信息' || toolbarObjs[k].innerText=='流程记录' || toolbarObjs[k].innerText=='修改记录')){
//			toolbarObjs[k].parentNode.removeChild(toolbarObjs[k].nextSibling);
//			toolbarObjs[k].parentNode.removeChild(toolbarObjs[k]);
//		}
//		
//	}
	gdform.pageContent.value = "<br><br><div style=\"padding:20px\"><input type=\"hidden\" name= \"workflow_thisIsInGDpage\" id = \"workflow_thisIsInGDpage\" >"+document.getElementById("docinfo0").outerHTML+"</div>";
   // gdform.pageContent.value = document.body.innerHTML;
    gdform.fileTitle.value = document.getElementsByName("receiveFileTitle")[0].value;
    gdform.fileId.value = document.getElementsByName("p_wf_recordId")[0].value;
	if(document.getElementsByName("receiveFileFileNumber").length > 0){
		gdform.wh.value=document.getElementsByName("receiveFileFileNumber")[0].value;
	}
	if(document.getElementsByName("createdDate").length > 0){
	var receiveFileReceiveDate =document.getElementsByName("createdDate")[0].value;
	if(receiveFileReceiveDate)gdform.dateTime.value=receiveFileReceiveDate.substring(0,4);
	}	
    gdform.submit();
}
<%if(request.getParameter("gd") != null){%>
gd();
<%}%>

</SCRIPT>
 </body>
</html>

