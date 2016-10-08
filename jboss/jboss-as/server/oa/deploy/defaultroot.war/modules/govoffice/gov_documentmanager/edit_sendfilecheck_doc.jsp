<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>文件送审签</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform.css">
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform_ext.css">
	<!--这里可以追加导入模块内私有的js文件或css文件-->
    <!--工作流包含页 js文件-->  
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
 	<script src="<%=rootPath%>/modules/govoffice/gov_documentmanager/js/sendfilecheck.js"   type="text/javascript"></script>
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
		white-space:nowrap
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
		white-space:nowrap
	}
	.STYLE1,.STYLE1 font,.STYLE1 text,.STYLE1 textarea{font-size: 14px; font-family:"宋体"}
	
	body{
		position:static;
	}
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


	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform.css">
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform_ext.css">
	<script language="javascript" src="/defaultroot/scripts/i18n/zh_CN/WorkflowResource.js" type="text/javascript"></script>
	<script language="javascript" src="/defaultroot/platform/custom/ezform/js/ezform.js"></script>
	<script language="javascript" src="/defaultroot/platform/custom/ezform/js/popselectdata.js"></script>
	<script language="javascript" src="/defaultroot/scripts/util/textareaAutoHeight2.js"></script>
</head>
<body  class="docBodyStyle" style="position:relative; height:100%;"  onload="initBody();">
<input type="hidden" name="from" value="<%=request.getParameter("from")%>">
	<%
	//System.out.println("[[[[[[[[[[[[[[[[[[[["+request.getAttribute("p_wf_modiButton"));;
	String modiButton = (String)request.getAttribute("p_wf_modiButton");


String workStatus = request.getParameter("workStatus")==null?"":request.getParameter("workStatus").toString();
String transactStatus=request.getAttribute("transactStatus")==null?"":request.getAttribute("transactStatus").toString();

	
int   read_inWorkType = ("null".equals(request.getParameter("workType")) || request.getParameter("workType")==null)?-1:Integer.parseInt(request.getParameter("workType"));//流程类型

//String 
modiButton = null;

//可编辑
if(request.getParameter("isEdit")!=null&&"1".equals(request.getParameter("isEdit").toString())){
 // System.out.println("==============================");;
 //办理完毕
  if(transactStatus.equals("1")){
  	if(!"1".equals(request.getParameter("isBack"))){
 		modiButton=",Back,Viewtext,Print,Saveclose";
			if(!("1".equals(request.getAttribute("p_wf_workStatus")) || "101".equals(request.getAttribute("p_wf_workStatus")) ) ){
				modiButton=",Viewtext,Print,Saveclose";
			}

 	}else{
 		modiButton=",Viewtext,Print,Saveclose";
 	}
 }
 //办理中 
 else{
 	if(!"1".equals(request.getParameter("isBack"))){
 		modiButton=",Wait,Viewtext,Back,Print,Saveclose";
		if(!("1".equals(request.getAttribute("p_wf_workStatus")) || "101".equals(request.getAttribute("p_wf_workStatus")) ) ){
				modiButton=",Wait,Viewtext,Print,Saveclose";
		}
 	}else{
 		modiButton=",Wait,Viewtext,Print,Saveclose";
 	}
 	//modiButton=",Wait,Viewtext,Back,Print,Saveclose";
 }

}else if(request.getParameter("viewOnly")!=null&&"1".equals(request.getParameter("viewOnly").toString())){
	// System.out.println("==============================2");;
	modiButton="";

}

if(request.getParameter("p_wf_processId")==null||request.getParameter("p_wf_processId").toString().equals("")||request.getParameter("p_wf_processId").toString().equals("null")){
	 //System.out.println("==============================3");;
	//modiButton=",Viewtext,Saveclose";
}


if(workStatus.equals("2")){
// System.out.println("==============================4");;
	modiButton="none";
}

if(request.getParameter("fromdesktop")!=null && !"null".equals(request.getParameter("fromdesktop")) && "2".equals(request.getParameter("fromdesktop"))){
	// System.out.println("==============================5");;
	modiButton="";
}
if(modiButton != null){
	//request.setAttribute("p_wf_modiButton",modiButton);
}

if( "blcyedit".equals(  request.getParameter("from") ) ){
	modiButton=",Saveclose,Viewtext,EmailSend,Print,Wait,Back,Readtext";
	//modify by gexiang  2015-11-3 老工作流需要加上退回 按钮 p_wf_workStatus = 102
	if(!("1".equals(request.getAttribute("p_wf_workStatus")) 
			|| "101".equals(request.getAttribute("p_wf_workStatus"))
			|| "102".equals(request.getAttribute("p_wf_workStatus"))) ){
				modiButton=",Saveclose,Viewtext,EmailSend,Print,Wait,Readtext";
	}
	//如果是办理完毕的送审签 ，需要去掉催办按钮，此时不需要催办了
	if(transactStatus.equals("1")){
	    modiButton=",Saveclose,Viewtext,EmailSend,Print,Back,Readtext";
	}
}

if( "startAgain".equals(  request.getAttribute("p_wf_openType") ) || "reStart".equals(  request.getAttribute("p_wf_openType") ) ){
	modiButton="Send,Relation,WritetextModi";

}
if(modiButton == null){
	 modiButton = (String)request.getAttribute("p_wf_modiButton");
}//System.out.println("_______________________________________________modiButton__"+modiButton);
	//request.setAttribute("p_wf_modiButton",modiButton.replaceAll(",Saveclose,",","));
	//request.setAttribute("p_wf_modiButton",modiButton.replaceAll(",Saveclose,",","));
	//System.out.println("[[[[[[[[[[[[[[[[[[[["+request.getAttribute("p_wf_modiButton"));;
if( "blcyview".equals(  request.getParameter("from") ) ){
	//modiButton=",Wait,Viewtext,Print,Saveclose";
	//modiButton	=	modiButton + ",Viewtext";
	modiButton=",Viewtext,EmailSend,Print,";
}

if( "blcyview".equals(  request.getParameter("from") ) || "blcyedit".equals(  request.getParameter("from") ) ){
	request.setAttribute("p_wf_concealField","");
}
boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);

if(isCOSClient){
	//屏蔽 起草正文 批阅正文 查看正文  编辑正文 生成正式文件  查看历史记录 再次套红 
	if( modiButton ==null) modiButton=(String) request.getAttribute("p_wf_modiButton");
	modiButton = modiButton.replaceAll(",Writetext",",");
	modiButton = modiButton.replaceAll(",WritetextModi",",");
	modiButton = modiButton.replaceAll(",Readtext",",");
	modiButton = modiButton.replaceAll(",Savefile",",");
	modiButton = modiButton.replaceAll(",Viewtext",",");
	modiButton = modiButton.replaceAll(",ReSavefile",",");
	modiButton = modiButton.replaceAll(",ReadHistorytext",",");
}
if(modiButton != null){
	request.setAttribute("p_wf_modiButton",modiButton);
}else{
	request.setAttribute("p_wf_modiButton",request.getAttribute("p_wf_modiButton"));//+",ReadHistorytext"
}


	%>
       <!--包含头部--->
	   <div style="height:37px; position:absolute; top:0; width:100%;z-index:1000;" >
	<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
		</div>
	 <div class=""  id="mainContent" style="overflow-y:auto; position:relative; top:47px; width:100%; _width:99%; "><!--id="mainContent" style="height:100%;width:100%;overflow:auto;"-->
<form name="gdform" method="POST" action="/defaultroot/modules/govoffice/gov_documentmanager/filesendcheck_gd.jsp?gd=1&recordId=<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>">
    <input type="hidden" name="pageContent">
    <input type="hidden" name="fileTitle">
    <input type="hidden" name="createdEmp" value="<%=session.getAttribute("userId").toString()%>">
	<input type="hidden" name="fileId" value="<%=request.getAttribute("p_wf_recordId")==null?"":request.getAttribute("p_wf_recordId")%>">
	<input type="hidden" name="org" value="<%=session.getAttribute("userName").toString()%>">
	<input type="hidden" name="zwurl">
	
</form>
<form name="form1" action="public/iWebOfficeSign/DocumentEdit.jsp?moduleType=govdocument&saveDocFile=1" method="post">

<input type="hidden" name="RecordID">
<input type="hidden" name="EditType" value="1">
<input type="hidden" name="UserName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" name="ShowSign" value="0">
<input type="hidden" name="CanSave" value="1">
<input type="hidden" name="content" value="<%=request.getAttribute("field1")%>">
<input type="hidden" name="sendfileNUM"> 
<input type="hidden" name="documentSendFileWriteOrg_1"> 
<input type="hidden" name="documentSendFileTopicWord_1"> 
<input type="hidden" name="toPerson1_1" > 
<input type="hidden" name="toPerson2_1" > 
<input type="hidden" name="documentSendFilePrintNumber_1">
<input type="hidden" name="documentSendFileSendTime_1">
<input type="hidden" name="sendFileRedHeadId_1" > 
<input type="hidden" name="moduleType"  value="govdocument">
<input type="hidden" name="saveDocFile"  value="1">
<input type="hidden" name="Template">
<input type="hidden" name="sendFileDepartWord_1">
<input type="hidden" name="hasSeal">
<input type="hidden" name="senddocumentTitle">
<input type="hidden" name="underwriteTime">
<input type="hidden" name="sendFileAccessoryDesc_1">
<input type="hidden" name="showTempSign" value="0">
<input type="hidden" name="showTempHead" value="1">
<input type="hidden" name="showSignButton" value="1">
<input type="hidden" name="showEditButton" value="1">
<input type="hidden" name="sendFileGrade_1"><!--办理缓急 （等级）-->
<input type="hidden" name="underwritePerson"><!--签发人-->
<input type="hidden" name="securityGrade_1"><!-- 密级-->
<input type="hidden" name="isWordWindowFirst" value="1">

</form>     

	 <s:form name="dataForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >
	 <input type="hidden" name="createdEmp" value="<%=request.getAttribute("createdEmp")%>">
	 <input type="hidden" name="createdOrg" value="<%=request.getAttribute("createdOrg")%>">
	 <input type="hidden" name="transactStatus" value="<%=request.getAttribute("transactStatus")%>">

	 <input type="hidden" name="content" value="<%=request.getAttribute("field1")%>">
	 	 <%@ include file="/public/include/form_detail.jsp"%>
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%" align="center">
	            <div class="docbox_noline"  align="center" >
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
							  <li id="Panle2" ><a href="javascript:void(0);" onClick="changePanle(2);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							  <%if( !"1".equals( request.getAttribute("p_wf_pool_processType") ) ){%>
							  <li id="Panle3" ><a href="#" onClick="changePanle(3);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
							  <%}%>
							  <li id="Panle4" ><a href="#" onClick="changePanle(4);">流程记录</a></li>
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
							//out.println(tableName);
							if ("文件送审签表".equals(tableName)) { //
								tableId_form = "standard";
							}
							
							System.out.print("自定义是送审签流程------------------："+tableId_form);
							String add = "/modules/govoffice/gov_documentmanager/forms/edit_"+tableId_form+"_sendfilecheckform_include.jsp"; 
							File file = new File(request.getRealPath("") +   add);
							if (!file.exists()) {
								new com.whir.govezoffice.documentmanager.actionsupport.GovCustomAction().replayGovCustomPage(request,tableId_form,"2","0");
							}
							%> 
							
								<jsp:include page="<%=add %>"></jsp:include>  

								
							</div>	
							<!--工作流包含页-->
							 <div>  
									<%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
							 <!--批示意见包含页-->  
                            <div>  
                                 <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>  
                            </div>  
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
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
</body>

<script type="text/javascript">
   $(function(){
       $.fn.autoTextarea = function (options) {
           var defaults = {
               maxHeight: null,//文本框是否自动撑高，默认：null，不自动撑高；如果自动撑高必须输入数值，该值作为文本框自动撑高的最大高度
               minHeight: $(this).height() //默认最小高度，也就是文本框最初的高度，当内容高度小于这个高度的时候，文本以这个高度显示
           };
           var opts = $.extend({}, defaults, options);
           return $(this).each(function () {
               $(this).bind("paste cut keydown keyup focus blur", function () {
                   var height, style = this.style;
                   this.style.height = opts.minHeight + 'px';
                   if (this.scrollHeight > opts.minHeight) {
                       if (opts.maxHeight && this.scrollHeight > opts.maxHeight) {
                           height = opts.maxHeight;
                           style.overflowY = 'scroll';
                       } else {
                           height = this.scrollHeight;
                           style.overflowY = 'hidden';
                       }
                       style.height = height + 'px';
                   }
               });
           });
       };
       $("textarea").autoTextarea({maxHeight:1000});
   }) ;
/**
 切换页面
 */
function  changePanle(flag){
	for(var i=0;i<=4;i++){
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
	   showWorkFlowRelation("docinfo2");
	}
	//显示相关附件
	if(flag=="3"){
		showWorkFlowAcc("docinfo3");
	}
	//显示流程记录
	if(flag=="4"){
	   showWorkFlowLog("docinfo4");
	}
}

/**
初始话信息
*/
function initBody(){
	
	//初始话信息
    ezFlowinit();

}

function gd(){
		//alert("11111111");
			 if(document.getElementById("gdword")){
				document.getElementById("gdword").style.display="inline";
			 }
	//		var toolbarObjs = $('SPAN[id^=Panle]');
	//		for(var k=0;k<toolbarObjs.length;k++){
	//			if(!(toolbarObjs[k].innerText=='基本信息' || toolbarObjs[k].innerText=='流程记录' || toolbarObjs[k].innerText=='修改记录')){
	//				toolbarObjs[k].parentNode.removeChild(toolbarObjs[k].nextSibling);
	//				toolbarObjs[k].parentNode.removeChild(toolbarObjs[k]);
	//			}
	//			
	//		}
			//gdform.pageContent.value = document.body.innerHTML;
				gdform.pageContent.value = "<br><br><div style=\"padding:20px\"><input type=\"hidden\" name= \"workflow_thisIsInGDpage\" id = \"workflow_thisIsInGDpage\" >"+document.getElementById("docinfo0").outerHTML+"</div>";
			//gdform.fileId.value = GovSendFileCheckWithWorkFlowActionForm.editId.value;
			//gdform.fileTitle.value = GovSendFileCheckWithWorkFlowActionForm.sendFileCheckTitle.value;
			
			gdform.fileTitle.value = document.getElementsByName("sendFileCheckTitle")[0].value;
			gdform.fileId.value = document.getElementsByName("p_wf_recordId")[0].value;
			var url="<%=rootPath%>/public/iWebOfficeSign/DocumentEdit.jsp?RecordID=<%=request.getAttribute("field1")%>&EditType=0&UserName="+document.all.UserName.value+"&CanSave=1&hiddenStatus=1&showTempSign=2&showTempHead=1&ShowSign=0&showSignButton=0&showEditButton=0&FileType="+(document.all.documentWordType?document.all.documentWordType.value:"");
			if(document.all.sendFileCheckTitle){
				url+="&copyType=1";
			}
			gdform.zwurl.value=url;
			gdform.submit();
		
}

<%if(request.getParameter("gd") != null){%>
gd();
<%}%>


</script>
 
</html>

