<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%
whir_custom_str="tagit";

String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>新建送审签</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform.css">
	<link rel="stylesheet" type="text/css" href="/defaultroot/platform/custom/ezform/css/ezform_ext.css">
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
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
<body  class="docBodyStyle"  style="position:relative; height:100%;"  onload="initBody();">
       <!--包含头部--->
	    <div style="height:37px; position:absolute; top:0; width:100%;" >
	<jsp:include page="/public/toolbar/toolbar_include.jsp" ></jsp:include>
		</div>
	 <div class="" id="mainContent" style="overflow-y:auto; position:relative; top:47px; width:100%; _width:99%; "><!--id="mainContent" style="height:100%;width:100%;overflow:auto;"-->
	 

<form name="form1" action="public/iWebOfficeSign/DocumentEdit.jsp?moduleType=govdocument&saveDocFile=1" method="post">

<input type="hidden" name="RecordID">
<input type="hidden" name="EditType" value="1">
<input type="hidden" name="UserName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" id="sys_userName" value="<%=session.getAttribute("userName")%>">
<input type="hidden" name="ShowSign" value="0">
<input type="hidden" name="CanSave" value="1">
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

	 <s:form name="dataForm" id="dataForm" action="GovDocSend!saveDraft.action" method="post" theme="simple" >
	  <%@ include file="/public/include/form_detail.jsp"%>
	 <input type="hidden" name="content">
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline"   >
					   <div class="doc_Movetitle">
						 <ul>
							 <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							 <!-- <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> -->
							  <li id="Panle2" ><a href="javascript:void(0);" onClick="changePanle(2);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
							 <!-- <li id="Panle3" ><a href="#" onClick="changePanle(3);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>-->
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content"  align="center">
							<!--表单包含页--><!--<input type="button" value="保存草稿" onclick="cmdSaveDraft()">
											 <input type="button" value="起草正0文" onclick="wordWindowFirst()">-->

							<div align="center"> 
							<%
							com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
							String tableId_form =(String) request.getAttribute("p_wf_tableId");
							System.out.println("-----------------"+tableId_form);
							List tableInfoList = sendFileBD.getWfTableInfoByTableId(tableId_form); // 根据tableId
							// 找table
							// 信息
							String tableName = "";
							//tableId_form="100723604";

							if (tableInfoList != null && tableInfoList.size() > 0) {
								Object[] tableInfoObj = (Object[]) tableInfoList.get(0);
								tableName = "" + tableInfoObj[0];
							}
							if (tableName.equals("文件送审签表") ) { //
								tableId_form = "standard";
							}
							
							
							String add = "/modules/govoffice/gov_documentmanager/forms/new_"+tableId_form+"_sendfilecheckform_include.jsp"; 
							
								File file = new File(request.getRealPath("") +
                                        add);
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
				      </div>
					 <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
                 </div>
				 <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
             </td>
         </tr>
     </table>
	 </s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>
</body>

<script type="text/javascript">

/**
 切换页面
 */
function  changePanle(flag){
//	if( flag == 3 ) flag= 2;
	for(var i=0;i<4;i++){
		if(i==1 || i==3){
			continue;
		}
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
}
/**
初始话信息
*/
function initBody(){
	var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
	window.resizeTo(windowWidth,windowHeight);
	//初始话信息
    ezFlowinit();

}
 
</script>
 
</html>

