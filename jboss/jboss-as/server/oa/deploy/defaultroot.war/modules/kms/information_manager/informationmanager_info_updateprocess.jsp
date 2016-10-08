<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><s:text name="info.infoaudit"/></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
	<script type="text/javascript">
	<!--
		function cmdPrint(){
			window.print();
		}
	//-->
	</script>
</head>
<%
String userId = session.getAttribute("userId").toString();
String p_wf_openType = request.getParameter("p_wf_openType")!=null?request.getParameter("p_wf_openType"):"";
boolean modify = p_wf_openType.equals("reStart");
String canIssueChannel = request.getAttribute("canIssueChannel")!=null ? request.getAttribute("canIssueChannel").toString() :"[]";
String otherChannel = request.getAttribute("otherChannel")!=null ? request.getAttribute("otherChannel").toString() :"[]";
String isYiBoChannel = request.getAttribute("isYiBoChannel")!=null ? request.getAttribute("isYiBoChannel").toString() :"0";
String modifyFlag = request.getParameter("modifyFlag")!=null?request.getParameter("modifyFlag"):"0";
%>
<body class="docBodyStyle" scroll="no" onload="initBody();">
    <!--包含头部--->
    <jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
    <div class="doc_Scroll">
		<s:form name="dataForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >
			<table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
				<tr valign="top">
					<td height="100%">
						<div class="docbox_noline">
							<div  id="info_add_center_1" class="doc_Movetitle">
								<ul>  
									<li class="aon" id="Panle0"><a href="#" onClick="changePanle(0);"><s:text name="info.newinfobasic"/></a></li>
									<li id="Panle1"><a href="#" onClick="changePanle(1);"><s:text name="info.newinfodetail"/></a></li>
									<%if(!modify){%>
									<li id="Panle2"><a href="#" onClick="changePanle(2);">流程图</a></li>
									<li id="Panle3"><a href="#" onClick="changePanle(3);">流程记录</a></li>
									<li id="Panle4"><a href="#" onClick="changePanle(4);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
									<li id="Panle5"><a href="#" onClick="changePanle(5);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
									<%}%>
								</ul>
							</div>
							<div class="clearboth"></div>
							<div class="doc_Content docBoxNoPanel" >
								<!--工作流包含页-->
								<div>
									<%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
								</div>
								<!--表单包含页 -->
								<div>
									<%@ include file="/public/include/form_detail.jsp"%>
									<%@ include file="information_form.jsp"%>
								</div>
							</div>
							<%if(!modify){%>
							<div id="docinfo2" class="doc_Content"  style="display:none;"></div>
							<div id="docinfo3" class="doc_Content"  style="display:none;"></div>
							<div id="docinfo4" class="doc_Content"  style="display:none;"></div>
							<div id="docinfo5" class="doc_Content"  style="display:none;"></div>
							<%}%>
						</div>
					</td>
				</tr>
			</table>
		</s:form>
    </div>
    <div class="docbody_margin"></div>
    <%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>
</body>
<script src="<%=rootPath%>/scripts/main/whir.ready.js" type="text/javascript"></script>
<script src="<%=rootPath%>/modules/kms/information_manager/informationmanager_info_updateprocess.js" type="text/javascript"></script>
<script type="text/javascript">
Ext.onReady(function() {
	var readonly = true;
	<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.otherChannel$') > -1">
		readonly = false;
	</s:if>
	var tp = Ext.create('Ext.XTemplate',
		'<tpl for=".">',
			'<tpl if="first == 1">',  
				'<div style="font-size:12px;font-weight:bold;">信息管理</div>',  
			'</tpl>',
			'<tpl if="first == 2">',  
				'<div style="font-size:12px;font-weight:bold;">单位主页</div>',  
			'</tpl>',
			'<tpl if="first == 3">',  
				'<div style="font-size:12px;font-weight:bold;">自定义信息频道</div>',  
			'</tpl>',
			'<div class="x-boundlist-item">{name}</div>',
		'</tpl>'
	);
	var states = Ext.create('Ext.data.Store', {
		fields: ['id', 'name', 'first'],
		data : <%=canIssueChannel%>
	});
	Ext.create('Ext.form.ComboBox', {
		store: states,
		queryMode: 'local',
		valueField: 'id',
		displayField: 'name',
		typeAhead: true,
		id: 'channelId',
		transform: 'selectChannels',
		hiddenName: 'selectChannel',
		width:804,
		forceSelection: true,
		renderTo: Ext.getBody(),
		emptyText: '请输入栏目名称筛选或者下拉选择',
		listeners: {
			select: function(combo, record, index) {
				changeChannel(combo.getValue());
			}
		},
		readOnly: true,
		tpl: tp
	});
	var states1 = Ext.create('Ext.data.Store', {
		fields: ['id', 'name', 'first'],
		data : <%=otherChannel%>
	});
	Ext.create('Ext.form.ComboBox', {
		store: states1,
		queryMode: 'local',
		valueField: 'id',
		displayField: 'name',
		typeAhead: true,
		id: 'otherchannelId',
		transform: 'otherChannels',
		hiddenName: 'information.otherChannel',
		width:435,
		forceSelection: true,
		renderTo: Ext.getBody(),
		emptyText: '请输入栏目名称筛选或者下拉选择',
		readOnly: readonly,
		tpl: tp
	});
	whirExtCombobox.setValue('channelId',$("#channel").val());
	whirExtCombobox.setValue('otherchannelId',$("#other").val().substring(1,$("#other").val().length-1));
	//初始化网站同步
	initOutSiteSynDiv();
});
//切换页签
var divNum = 6;
<%if(modify){%>
	divNum = 2;
<%}%>
function  changePanle(flag){
    for(var i=0;i<divNum;i++){
        $("#Panle"+i).removeClass("aon");
    }
    $("#Panle"+flag).addClass("aon");
    $("div[id^='docinfo']").hide();
    $("#docinfo"+flag).show();
	if(flag==1){
		//处理新建信息页面经常加载不出相关对象
		var url="<%=rootPath%>/relation!relationIncludeList.action?moduleType=information&infoId=<s:property value='information.informationId'/>&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationadd=1";
		$("#relationIFrame").attr("src", url);
	}
	<%if(!modify){%>
    //显示流程图
    if(flag=="2"){
        //传流程图的div的id
       showWorkFLowGraph("docinfo2");
    }
    //显示关联流程
    if(flag=="3"){
       showWorkFlowLog("docinfo3");
    }
    //显示关联流程
    if(flag=="4"){
       showWorkFlowRelation("docinfo4");
    }
    //显示相关附件
    if(flag=="5"){
       showWorkFlowAcc("docinfo5");
    }
	<%}%>
}
//初始化信息
function initBody(){
    ezFlowinit();
}
$(document).ready(function(){
	initfunction("<%=isYiBoChannel%>","<%=modifyFlag%>");
});
function initPara(){
	var informationType = $("#informationType").val();//$(':radio[name="information.informationType"]:checked').val();
	if(informationType == 1){
		var o_Editor = document.getElementById("newedit").contentWindow;
		$("#informationContent").val(o_Editor.getHTML());
	}else if(informationType == 0){
		$("#informationContent").val($("#textContent").val());
	}else if(informationType == 2){
		var url = $("#URLContent").val();
		if(url==""){
			whir_alert('<s:text name="info.Addressnotempty"/>');
			return;
		}else{
			url = $.trim(url);
			if(url.substring(0,7)!="http://"){
				whir_alert('<s:text name="info.Addresserrors"/>');
				return;
			}else{
				$("#informationContent").val(url);
			}
		}
	}else if(informationType == 3){
		if($("#fileLinkContent").val()==""){
			whir_alert('<s:text name="info.notselectedfiles"/>');
			return;
		}else{
			$("#informationContent").val($("#fileLinkContent").val()+":"+$("#fileLinkContentHidd").val());
		}
	}else if(informationType == 4){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}else if(informationType == 5){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}else if(informationType == 6){
		if($("#content").val()==""){
			whir_alert('<s:text name="info.noeditext"/>');
			return;
		}else{
			$("#informationContent").val($("#content").val());
		}
	}
	var selectChannel = whirExtCombobox.getValue("channelId");//whirCombobox.getValue("selectChannel");
	if(selectChannel==""||selectChannel=="0"){
		whir_alert('<s:text name="info.haveNotselectedColumn"/>');
		return;
	}
	if($(":radio[name='information.informationValidType']:checked").val()==1){
		if($("#validEndTime").val()!='' && $("#validBeginTime").val()==''){
			whir_alert('<s:text name="info.selectValidityStartTime"/>');
			return;
		}else if($("#validEndTime").val()=='' && $("#validBeginTime").val()!=''){
			whir_alert('<s:text name="info.selectValidityEndTime"/>');
			return;
		}else if($("#validEndTime").val()!='' && $("#validBeginTime").val()!=''){
			if($("#validBeginTime").val() > $("#validEndTime").val()){
				whir_alert('<s:text name="info.timejudge"/>');
				return;
			}
		}
	}
	var flag = validateForm("dataForm");
	if(flag){
		return true;
	}
}
function wordEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:whirRootPath+'/public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.doc&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&moditype=info',isFull:true,winName:'editContent'});
}
function excelEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:whirRootPath+'/public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.xls&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&moditype=info',isFull:true,winName:'editContent'});
}
function pptEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:whirRootPath+'/public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.ppt&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1&moditype=info',isFull:true,winName:'editContent'});
}
</script>  
</html>