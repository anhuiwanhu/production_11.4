<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><s:text name="info.newinfo"/></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <%@ include file="/public/include/meta_base_bpm.jsp"%>
</head>
<%
String canIssueChannel = request.getAttribute("canIssueChannel")!=null ? request.getAttribute("canIssueChannel").toString() :"[]";
String otherChannel = request.getAttribute("otherChannel")!=null ? request.getAttribute("otherChannel").toString() :"[]";
String fromGov = request.getAttribute("fromGov")!=null?request.getAttribute("fromGov").toString():"";
String title = request.getAttribute("title")!=null?request.getAttribute("title").toString():"";
String govId = request.getAttribute("govId")!=null?request.getAttribute("govId").toString():"";
String docNo = request.getParameter("docNO")!=null?request.getParameter("docNO"):"";
String moduleId = "";
if(fromGov.equals("2")){
	moduleId = request.getAttribute("moduleId")!=null?request.getAttribute("moduleId").toString():"";
}
//20151010 -by jqq 
String channelId = request.getParameter("channelId")!=null?request.getParameter("channelId"):"";
String channelName = request.getParameter("channelName")!=null?request.getParameter("channelName"):"";
String userChannelName = request.getParameter("userChannelName")!=null?request.getParameter("userChannelName"):"";
String type = request.getParameter("type")!=null?request.getParameter("type"):"";
String original = request.getParameter("original")!=null?request.getParameter("original"):"0";
//是否是易播栏目（新建信息，选择栏目切换页面时会传入后台，用以初始页面控制易播页面的展示情况）
String isyibo = request.getAttribute("isYiBoChannel")!=null ? request.getAttribute("isYiBoChannel").toString() :"0";
//20160309 -by jqq 发布时间使用服务器时间
java.text.SimpleDateFormat dateformat1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String serverdate=dateformat1.format(new java.util.Date());
%>
<body class="docBodyStyle" scroll="no" onload="initBody();">
    <!--包含头部-->
    <jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
    <div class="doc_Scroll">
		<s:form name="form" id="form" action="Information!add.action" method="post">
			<s:hidden id="p_wf_pool_processId" name="p_wf_pool_processId"/>
			<s:hidden id="channel" name="channel" value="%{#request.channel}"/>
			<s:hidden id="reader" name="reader" value="%{#request.reader}"/>
			<s:hidden id="readerName" name="readerName" value="%{#request.readerName}"/>
			<s:hidden id="tempContent" name="tempContent" value="%{#request.tempContent}"/>
			<s:hidden id="remindType" name="remindType" value="%{#request.remindType}"/>
			<s:hidden id="printer" name="printer" value="%{#request.printer}"/>
			<s:hidden id="printerName" name="printerName" value="%{#request.printerName}"/>
			<s:hidden id="printNum_" name="printNum_" value="%{#request.printNum}"/>
			<s:hidden id="downloader" name="downloader" value="%{#request.downloader}"/>
			<s:hidden id="downloaderName" name="downloaderName" value="%{#request.downloaderName}"/>
			<s:hidden id="downloadNum_" name="downloadNum_" value="%{#request.downloadNum}"/>
			<s:hidden id="module" name="module"/>
			<s:hidden id="_title" name="_title" value="%{#request.title}"/>
			<s:hidden id="_content" name="_content" value="%{#request.content}"/>
			<s:hidden id="_fileId" name="_fileId" value="%{#request.govId}"/>
			<s:hidden id="_author" name="_author" value="%{#request.author}"/>
			<s:hidden id="_docNo" name="_docNo" value="%{#request.docNo}"/>
			<s:hidden id="_accessName" name="_accessName" value="%{#request.infoAppendName}"/>
			<s:hidden id="_accessSaveName" name="_accessSaveName" value="%{#request.infoAppendSaveName}"/>
			<s:hidden id="_moduleId" name="_moduleId" value="%{#request.moduleId}"/>
			<input type="hidden" name="_isyiboflag" id="_isyiboflag">
		</s:form>
		<s:form name="dataForm" id="dataForm" action="wfoperate!showSend.action" method="post" theme="simple" >
			<table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
				<tr valign="top">
					<td height="100%">
						<div class="docbox_noline">
							<div class="doc_Movetitle" id="info_add_center_1">
								<ul>
									<li class="aon" id="Panle0"><a href="#" onClick="changePanle(0,'<s:property value='information.informationId'/>');" ><s:text name="info.newinfobasic"/></a></li>
									<li id="Panle1"><a href="#" onClick="changePanle(1,'<s:property value='information.informationId'/>');" ><s:text name="info.newinfodetail"/></a></li>
								</ul>
							</div>
							<div class="clearboth"></div>
							<div class="doc_Content docBoxNoPanel" >
								<!--表单包含页-->
								<div>
									<%@ include file="/public/include/form_detail.jsp"%>
									<%@ include file="information_form.jsp"%>
								</div>
								<!--工作流包含页-->
								<div>     
									<%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</s:form>
    </div>
    <div class="docbody_margin"></div>
    <%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
</body>
<script src="<%=rootPath%>/scripts/main/whir.ready.js" type="text/javascript"></script>
<script src="<%=rootPath%>/modules/kms/information_manager/informationmanager_info_addprocess.js" type="text/javascript"></script>
<script type="text/javascript">
Ext.onReady(function() {
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
		emptyText: '<s:text name="info.searchcolumn"/>',
		listeners: {
			select: function(combo, record, index) {
				changeChannel(combo.getValue(),$("#isyiboflag").val(),'<s:text name="info.newinfo"/>','<s:text name="info.noprocess"/>','<%=fromGov%>');
			}
		},
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
		emptyText: '<s:text name="info.searchcolumn"/>',
		tpl: tp
	});

	var modelCombo2 = Ext.create('Ext.form.field.ComboBox', {
		id: 'temp',
		typeAhead: true,
		transform: 'templates',
		hiddenName: 'template',
		width: 804,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				changeTemplate(combo.getValue());
			}
		}
	});

	//初始化栏目
	var channel = $("#channel").val();
	if(channel!=''){
		whirExtCombobox.setValue('channelId',channel);
	}
	//20151012 -by jqq 改造：新建信息时候，自带填入当前栏目
	//当通过点击新建信息（original=1）时候，并且不是所有信息对应的新建信息（type!=all），自动填写当前栏目
	if('1' == '<%=original%>' && '<%=type%>' != 'all'){
		whirExtCombobox.setValue('channelId','<%=channelId%>,<%=channelName%>');
		//给当前栏目相关参数赋值
		processChangeChannel("<%=channelId%>,<%=channelName%>",'<s:text name="info.noprocess"/>','<%=fromGov%>');
	}

	initOutSiteSynDiv();
});

//初始化信息
function initBody(){
    ezFlowinit();
}

$(document).ready(function(){
	chushihua('<s:text name="info.newinfo"/>','<%=fromGov%>','<%=title%>','<%=govId%>','<%=docNo%>','<%=serverdate%>');
});

function initPara(){
	var informationType = $(':radio[name="information.informationType"]:checked').val();
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
	var selectChannel = whirExtCombobox.getValue('channelId');// whirCombobox.getValue("selectChannel");
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
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.doc&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1',isFull:true,winName:'editContent'});
}

function excelEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.xls&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1',isFull:true,winName:'editContent'});
}

function pptEdit(editType){
	var content = $("#content").val();
	var userName = '<%=session.getAttribute("userName")%>';
	openWin({url:'public/iWebOfficeSign/DocumentEdit.jsp?RecordID='+content+'&EditType='+editType+'&UserName='+userName+'&ShowSign=0&CanSave='+editType+'&moduleType=information&saveHtmlImage=0&saveDocFile='+editType+'&FileType=.ppt&showSignButton=1&showEditButton='+editType+'&saveHtml=0&showTempSign=-1&showTempHead=-1',isFull:true,winName:'editContent'});
}

//禁止后退键 作用于Firefox、Opera  
document.onkeypress=banBackSpace;  
//禁止后退键  作用于IE、Chrome  
document.onkeydown=banBackSpace;  
</script> 
</html>
