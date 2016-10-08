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
	<script src="<%=rootPath%>/public/relation/relation.js" language="javascript"></script>
</head>
<%
String canIssueChannel = request.getAttribute("canIssueChannel")!=null ? request.getAttribute("canIssueChannel").toString() :"[]";
String otherChannel = request.getAttribute("otherChannel")!=null ? request.getAttribute("otherChannel").toString() :"[]";

String fromGov = request.getAttribute("fromGov")!=null?request.getAttribute("fromGov").toString():"";
String title = request.getAttribute("title")!=null?request.getAttribute("title").toString():"";
String govId = request.getAttribute("govId")!=null?request.getAttribute("govId").toString():"";
String docNo = request.getParameter("docNO")!=null?request.getParameter("docNO"):"";
//20151010 -by jqq 
String channelId = request.getParameter("channelId")!=null?request.getParameter("channelId"):"";
String channelName = request.getParameter("channelName")!=null?request.getParameter("channelName"):"";
String userChannelName = request.getParameter("userChannelName")!=null?request.getParameter("userChannelName"):"";
String type = request.getParameter("type")!=null?request.getParameter("type"):"";
String original = request.getParameter("original")!=null?request.getParameter("original"):"0";
String moduleId = "";
if(fromGov.equals("2")){
	moduleId = request.getAttribute("moduleId")!=null?request.getAttribute("moduleId").toString():"";
}
//是否是易播栏目（新建信息，选择栏目切换页面时会传入后台，用以初始页面控制易播页面的展示情况）
String isyibo = request.getAttribute("isyiboflag")!=null ? request.getAttribute("isyiboflag").toString() :"0";
//20160309 -by jqq 发布时间使用服务器时间
java.text.SimpleDateFormat dateformat1=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String serverdate=dateformat1.format(new java.util.Date());
%>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div id="info_add_center_1">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
				<tr>
					<td>
						<div class="Public_tag">
							<ul>
								<li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><s:text name="info.newinfobasic"/></span><span class="tag_right"></span></li>
								<li id="Panle1" onClick="changePanle(1);"><span class="tag_center"><s:text name="info.newinfodetail"/></span><span class="tag_right"></span></li>
						   </ul>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="docBoxNoPanel">
			<s:form name="form" id="form" action="Information!start.action" method="post">
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
			<s:form name="dataForm" id="dataForm" action="Information!save.action" method="post">
			<%@ include file="/public/include/form_detail.jsp"%>
			<%@ include file="information_form.jsp"%>
			</s:form>
		</div>
	</div>
</body>
<script src="<%=rootPath%>/scripts/main/whir.ready.js" type="text/javascript"></script>
<script type="text/javascript">
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'',"tip":'<s:text name="info.newinfosave"/>',"callbackfunction":setRelation});
Ext.onReady(function() {
	/*var modelCombo = Ext.create('Ext.form.field.ComboBox', {
		id: 'channelId',
		typeAhead: true,
		transform: 'selectChannels',
		hiddenName: 'selectChannel',
		width: 804,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				changeChannel(combo.getValue());
			}
		}
	});

	var modelCombo1 = Ext.create('Ext.form.field.ComboBox', {
		id: 'otherchannelId',
		typeAhead: true,
		transform: 'otherChannels',
		hiddenName: 'information.otherChannel',
		width: 435,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				
			}
		}
	});*/

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
				changeChannel(combo.getValue());
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
		nonProcessChangeChannel("<%=channelId%>,<%=channelName%>");
	}
});

//20151012 -by jqq 当前栏目相关参数赋值（非审核流程）
function nonProcessChangeChannel(val){
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				if(data.processId=="0"){
					$("#informationReaderId").val(data.canReader);
					$("#informationReaderId_").val(data.canReader);
					$("#informationReaderName").val(data.canReaderName);
					$("#informationPrinterId").val(data.printer);
					$("#informationPrinterId_").val(data.printer);
					$("#informationPrinterName").val(data.printerName);
					$("#printNum").val(data.printNum);
					$("#informationDownLoaderId").val(data.downloader);
					$("#informationDownLoaderId_").val(data.downloader);
					$("#informationDownLoaderName").val(data.downloaderName);
					$("#downLoadNum").val(data.downloadNum);
					//信息推送提醒方式继承栏目设置的提醒方式
					var remindType = data.remindType;
					if(remindType!=null && remindType!=""){
						if(remindType.indexOf("|")>-1){
							var array = remindType.split("|");
							for(var i=0;i<array.length;i++){
								var remind = array[i];
								if($("#remind_"+remind)[0]){
									$("#remind_"+remind).attr("checked", "checked");
								}
							}
						}else{
							if($("#remind_"+remindType)[0]){
								$("#remind_"+remindType).attr("checked", "checked");
							}
						}
					}else{
						if($("#remind_im")[0]){
							$("#remind_im").attr("checked", false);
						}
						if($("#remind_sms")[0]){
							$("#remind_sms").attr("checked", false);
						}
						if($("#remind_mail")[0]){
							$("#remind_mail").attr("checked", false);
						}
					}
				}
				//initOutSiteSynDiv();
			}
		}
	});
}

$(document).ready(function(){
	var infotype = $(':radio[name="information.informationType"]:checked').val();
	//易播栏目页面初始化
	//易播栏目新建信息页面，部分页面元素不展示
	if("1" == $("#isyiboflag").val()){
			//易播文件模式，默认普通输入
			$(":radio[name='information.informationType'][value=0]").attr("checked",true);
			changeInfoType(0);
			$(":radio[name='information.informationType'][value='1']").hide().next().hide();
			$(":radio[name='information.informationType'][value='2']").hide().next().hide();
			$(":radio[name='information.informationType'][value='4']").hide().next().hide();
			$(":radio[name='information.informationType'][value='5']").hide().next().hide();
			$(":radio[name='information.informationType'][value='6']").hide().next().hide();
			$(document).attr("title","新易播信息");//修改title
			$("#info_add_center_1").hide();
			$("#info_add_1").hide();
			$("#temp").hide();
			$("#info_add_2").hide();
			$("#selectAppend").hide();
	}else{
	}

	$(":radio[name='information.informationType']").change(function(){
		changeInfoType(this.value);
	});
	
	$(":radio[name='information.informationValidType']").change(function(){
		if(this.value==1){
			$("#validBeginTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validEndTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validTime").show();
		}else{
			$("#validBeginTime").val('');
			$("#validBeginTime").val('');
			$("#validTime").hide();
		}
	});
	//初始化发布时间
	$("#informationIssueTime").val("<%=serverdate%>");
	
	//初始化可查看人
	var reader = $("#reader").val();
	var readerName = $("#readerName").val();
	if(reader!=''){
		$("#informationReaderId").val(reader);
		$("#informationReaderId_").val(reader);
		$("#informationReaderName").val(readerName);
	}
	//初始化可打印人
	var printer = $("#printer").val();
	var printerName = $("#printerName").val();
	if(printer!=''){
		$("#informationPrinterId").val(printer);
		$("#informationPrinterId_").val(printer);
		$("#informationPrinterName").val(printerName);
	}
	//打印次数
	var printNum = $("#printNum_").val();
	if(printNum!=''){
		$("#printNum").val(printNum);
	}
	//初始化可下载人
	var downloader = $("#downloader").val();
	var downloaderName = $("#downloaderName").val();
	if(downloader!=''){
		$("#informationDownLoaderId").val(downloader);
		$("#informationDownLoaderId_").val(downloader);
		$("#informationDownLoaderName").val(downloaderName);
	}
	//下载次数
	var downloadNum = $("#downloadNum_").val();
	if(downloadNum!=''){
		$("#downLoadNum").val(downloadNum);
	}
	//初始化内容
	setTimeout("setEditerContent()",500);
	//从公文同步
	var fromGov = '<%=fromGov%>';
	if(fromGov=='1'||fromGov=='0'||fromGov=='4'){
		$(":radio[name='information.informationType'][value=4]").attr("checked",true);
		changeInfoType(4);
		$("#informationTitle").val('<%=title%>');
		$("#fromGOV").val(fromGov);
		$("#fromGOVDocument").val('<%=govId%>');
		$("#documentNo").val('<%=docNo%>');
		$("#content").val($("#_content").val());
	}
	//工作流程同步
	if(fromGov=='2'){
		$(":radio[name='information.informationType'][value=1]").attr("checked",true);
		changeInfoType(1);
		$("#informationTitle").val('<%=title%>');
		$("#fromGOV").val(fromGov);
		$("#fromGOVDocument").val('<%=govId%>');
		if ($("#_content").val()!=""){
			$("#tempContent").val($("#_content").val());
			setTimeout("setEditerContent()",1000);
			//document.getElementById("newedit").contentWindow.setHTML($("#_content").val());
		}
	}
});

//保存相关性
function setRelation(json){
	if(json.data!=null){
		var informationId = json.data.informationId;
		var informationTitle = json.data.informationTitle;
		var informationType = json.data.informationType;
		var channelId = json.data.channelId;
		var userChannelName = json.data.userChannelName;
		var channelType = json.data.channelType;
		var userDefine = json.data.userDefine;
		setRelationInfo(informationId, informationTitle, 'Information!view.action?informationId='+informationId+'&informationType='+informationType+'&userChannelName='+userChannelName+'&channelId='+channelId+'&userDefine='+userDefine+'&channelType='+channelType, 'information', 'relationIFrame');
	}
}

function setEditerContent(){
	if ($("#tempContent").val()!=""){
		document.getElementById("newedit").contentWindow.setHTML($("#tempContent").val());
	}
}

function changeInfoType(val){
	if(val==0){
		$("#temp").hide();
		$("#selectImg").show();
		if("1" == $("#isyiboflag").val()){
			$("#selectAppend").hide();
		}else{
			$("#selectAppend").show();
		}
		$("#txt").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==1){
		$("#temp").show();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").show();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==2){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").show();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		if("1" == $("#isyiboflag").val()){
			$("#filecolumn").innerHTML = '视频文件<span class="MustFillColor">*</span>：';
		}else{
			$("#filecolumn").innerHTML = '<s:text name="info.newinfofilelink" /><span class="MustFillColor">*</span>：';
		}
		
	}else if(val==3){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").show();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		//处理ie10点击选择文件没反应问题-----20130929
		whir_uploader_reset("uploadFile");
	}else if(val==4){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").show();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==5){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").show();
		$("#ppt").hide();
	}else if(val==6){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").show();
	}
}

function changePanle(flag){
    if(flag==0){
		$("#docinfo1").hide();
		$("#Panle1").removeClass();
		$("#docinfo0").show();
		$("#Panle0").addClass("tag_aon");
	}else{
		$("#docinfo0").hide();
		$("#Panle0").removeClass();
		$("#docinfo1").show();
		$("#Panle1").addClass("tag_aon");
		//处理新建信息页面经常加载不出相关对象
		var url="<%=rootPath%>/relation!relationIncludeList.action?moduleType=information&infoId=<s:property value='information.informationId'/>&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationadd=1";
		$("#relationIFrame").attr("src", url);
	}
}

function changeChannel(val){
	var infotype = $(':radio[name="information.informationType"]:checked').val();
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				//是否易播栏目
				var isYiBoChannel = data.isYiBoChannel != null && data.isYiBoChannel != "" && data.isYiBoChannel != '' ? data.isYiBoChannel : "0";
				//whir_alert(isYiBoChannel);
				$("#isyiboflag").val(isYiBoChannel);
				$("#_isyiboflag").val(isYiBoChannel);
				//易播栏目新建信息页面，部分页面元素不展示
				if(isYiBoChannel == "1"){
					$(":radio[name='information.informationType'][value=0]").attr("checked",true);
					changeInfoType(0);
					$(":radio[name='information.informationType'][value='1']").hide().next().hide();
					$(":radio[name='information.informationType'][value='2']").hide().next().hide();
					$(":radio[name='information.informationType'][value='4']").hide().next().hide();
					$(":radio[name='information.informationType'][value='5']").hide().next().hide();
					$(":radio[name='information.informationType'][value='6']").hide().next().hide();
					$(document).attr("title","新易播信息");//修改title
					$("#info_add_center_1").hide();
					$("#info_add_1").hide();
					$("#temp").hide();
					$("#info_add_2").hide();
					$("#selectAppend").hide();
				}else{
					if(infotype == null || infotype == ""){
						$(":radio[name='information.informationType'][value=1]").attr("checked",true);
						infotype = 1;
					}
					changeInfoType(infotype);
					$(":radio[name='information.informationType'][value='1']").show().next().show();
					$(":radio[name='information.informationType'][value='2']").show().next().show();
					$(":radio[name='information.informationType'][value='4']").show().next().show();
					$(":radio[name='information.informationType'][value='5']").show().next().show();
					$(":radio[name='information.informationType'][value='6']").show().next().show();
					$(document).attr("title",'<s:text name="info.newinfo"/>');
					$("#info_add_center_1").show();
					$("#info_add_1").show();
					if(infotype == '1' || infotype == 1){
						$("#temp").show();
					}else{
						$("#temp").hide();
					}
					$("#info_add_2").show();
					if(infotype == '2' || infotype == '3'){
						$("#selectAppend").hide();
					}else{
						$("#selectAppend").show();
					}
				}


				if(data.processId=="0"){
					$("#informationReaderId").val(data.canReader);
					$("#informationReaderId_").val(data.canReader);
					$("#informationReaderName").val(data.canReaderName);
					$("#informationPrinterId").val(data.printer);
					$("#informationPrinterId_").val(data.printer);
					$("#informationPrinterName").val(data.printerName);
					$("#printNum").val(data.printNum);
					$("#informationDownLoaderId").val(data.downloader);
					$("#informationDownLoaderId_").val(data.downloader);
					$("#informationDownLoaderName").val(data.downloaderName);
					$("#downLoadNum").val(data.downloadNum);
					//信息推送提醒方式继承栏目设置的提醒方式
					var remindType = data.remindType;
					if(remindType!=null && remindType!=""){
						if(remindType.indexOf("|")>-1){
							var array = remindType.split("|");
							for(var i=0;i<array.length;i++){
								var remind = array[i];
								if($("#remind_"+remind)[0]){
									$("#remind_"+remind).attr("checked", "checked");
								}
							}
						}else{
							if($("#remind_"+remindType)[0]){
								$("#remind_"+remindType).attr("checked", "checked");
							}
						}
					}else{
						if($("#remind_im")[0]){
							$("#remind_im").attr("checked", false);
						}
						if($("#remind_sms")[0]){
							$("#remind_sms").attr("checked", false);
						}
						if($("#remind_mail")[0]){
							$("#remind_mail").attr("checked", false);
						}
					}
				}else{
					if(data.processId=="-1"){
						whir_alert('<s:text name="info.noprocess"/>');
						whirExtCombobox.setValue('channelId','');
					}else{
						$("#p_wf_pool_processId").val(data.processId);
						$("#channel").val(val);
						$("#reader").val(data.canReader);
						$("#readerName").val(data.canReaderName);
						$("#remindType").val(data.remindType);
						$("#printer").val(data.printer);
						$("#printerName").val(data.printerName);
						$("#printNum_").val(data.printNum);
						$("#downloader").val(data.downloader);
						$("#downloaderName").val(data.downloaderName);
						$("#downloadNum_").val(data.downloadNum);
						if($(':radio[name="information.informationType"]:checked').val()=='1'){
							try{
								$("#tempContent").val(document.getElementById("newedit").contentWindow.getHTML());
							}catch(e){

							}
						}
						var fromGov = '<%=fromGov%>';
						$("#module").val(fromGov);
						$(".btnButton4font").attr("disabled","disabled");
						$("#form").submit();
					}
				}
				initOutSiteSynDiv();
			}
		}
	});
}

function changeTemplate(val){
	if(val != 0){
		$.ajax({
			type: 'POST',
			url: whirRootPath+"/Template!getTemplateContent.action?id="+val,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					document.getElementById("newedit").contentWindow.setHTML(data);
				}
			}
		});
    }else{
	    try{
			document.getElementById("newedit").contentWindow.setHTML("");
		}catch(e){}
    }
}

function save(flag,obj){
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
	var selectChannel = whirExtCombobox.getValue('channelId');//whirCombobox.getValue("selectChannel");
	if(selectChannel==null||selectChannel==""||selectChannel=="0"){
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
	ok(flag,obj);
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

function fileLink(json){
	$("#fileLinkContent").val(json.file.name);
}

function uploadSuccess(json){
	$("#fileLinkContentHidd").val(json.save_name+json.file_type);
}

function selectReader(){
	var channelReader_ = $("#informationReaderId_").val();
	if(channelReader_!=""){
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelReader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectPrinter(){
	var channelPrinter_ = $("#informationPrinterId_").val();
	if(channelPrinter_!=""){
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelPrinter_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectDownLoader(){
	var channelDownLoader_ = $("#informationDownLoaderId_").val();
	if(channelDownLoader_!=""){
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelDownLoader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

//加载网站同步信息
function initOutSiteSynDiv(){
    var _channel = whirExtCombobox.getValue('channelId');//whirCombobox.getValue("selectChannel");
	var _channelId="";
	if(_channel!=""&&_channel!="0"&&_channel!=null){
	    _channelId=_channel.substring(0,_channel.indexOf(","));
	}
	if(_channelId==""){
	    return ;
	}
    var url="<%=rootPath%>/modules/kms/information_manager/informationmanager_info_synsite_div.jsp?channelId="+_channelId;
    var html = $.ajax({url: url,async: false}).responseText;
    $("#outSiteSynDiv").html(html); 
}

//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外  
function banBackSpace(e){     
    var ev = e || window.event;//获取event对象     
    var obj = ev.target || ev.srcElement;//获取事件源     
    var t = obj.type || obj.getAttribute('type');//获取事件源类型    
    //获取作为判断条件的事件类型  
    var vReadOnly = obj.getAttribute('readonly');  
    var vEnabled = obj.getAttribute('enabled');  
    //处理null值情况  
    vReadOnly = (vReadOnly == null) ? false : vReadOnly;  
    vEnabled = (vEnabled == null) ? true : vEnabled;  
    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，  
    //并且readonly属性为true或enabled属性为false的，则退格键失效  
    var flag1=(ev.keyCode == 8 && (t=="password" || t=="text" || t=="textarea")   
                && (vReadOnly==true || vEnabled!=true))?true:false;  
    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效  
    var flag2=(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")  
                ?true:false;          
    //判断  
    if(flag2){  
        return false;  
    }  
    if(flag1){     
        return false;     
    }     
}  
//禁止后退键 作用于Firefox、Opera  
document.onkeypress=banBackSpace;  
//禁止后退键  作用于IE、Chrome  
document.onkeydown=banBackSpace;
//20160111 -by jqq 页面禁止回退
window.location.hash="";
window.location.hash="";//again because google chrome don't insert first hash into history
window.onhashchange=function(){window.location.hash="";}
</script>
</html>