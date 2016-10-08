<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>已处理收文</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<%@ include file="/public/include/include_extjs.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
com.whir.org.manager.bd.ManagerBD mbd = new com.whir.org.manager.bd.ManagerBD();
%>
<body class="MainFrameBox" onload="init()">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="GovRecvDocSet!isHandleData.action" method="post" theme="simple">
	
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	<input name="tag" type="hidden" value="isHandle" class="btnButton4font"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr>
            <td class="whir_td_searchtitle" nowrap>标题：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryTitle" name="queryTitle" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle" nowrap>拟稿单位：</td>
            <td class="whir_td_searchinput">
                <select id="queryOrg" name="queryOrg"  width="20">
					<option value="" >--请选择--</option>
					<c:forEach  items="${nameList}"  var="list"  >
						<option  >${list[1]}</option>
					</c:forEach> 
				</select>
            </td>
            <td class="whir_td_searchtitle" nowrap>文号：</td>
            <td class="whir_td_searchinput">
	             <s:textfield id="queryNumber" name="queryNumber" size="16" cssClass="inputText" />
            </td>
			<td>
            </td>
        </tr>
         <tr>
            <td class="whir_td_searchtitle" nowrap>发文日期：</td>
            <td colspan="2" class="whir_td_searchinput">
        		<!--<input type="checkbox" name="queryItem" id="goodDay0" value="1"/>-->
				<input name="queryBeginDate"  id="empBirth"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'empBirth2\');}'})" /> 至   
				<input name="queryEndDate" id="empBirth2"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'empBirth\');}'})" />  
	        </td>
            <td colspan="4" class="SearchBar_toolbar">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="if(checkform())refreshListForm('queryForm');"  value="立即查找" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="清　除" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td align="right">
	            <input name="" type="button" value="" class="btnButton4font" style="display:none"/>
				<input name="getfile" type="button"  id="withdrawBtn" value="批量收藏" class="btnButton4font" onclick="collectionBatch()">  
			    <input type="button" class="btnButton4font" onclick="ajaxBatchOperate({url:'<%=rootPath%>/GovDocSet!delBatch.action',checkbox_name:'id',attr_name:'id,sendFileUserId',tip:'删除',isconfirm:true,formId:'queryForm',callbackfunction:null});" value="批量删除" />
	        </td>
	    </tr>
	</table>
	<%
	boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);
	%>
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true,renderer:getcbx" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>
			<td whir-options="field:'documentSendFileByteNumber',width:'20%'">文号</td> 
			<td whir-options="field:'documentSendFileTitle',width:'30%',renderer:show">标题</td> 
			<td whir-options="field:'documentSendFileWriteOrg', width:'20%'">拟稿单位</td> 
			<td whir-options="field:'recivedDate', width:'10%',renderer:common_DateFormat">分发日期</td> 
			<%if(!isCOSClient){%>
			<td whir-options="field:'goldGridId', width:'10%',renderer:downloadLink">下载正文</td> 
			<%}%>
			<td whir-options="field:'transactStatus',width:'8%',renderer:myOperate">操作</td> 

        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->

	</s:form>

	<form id="collectionForm" name="collectionForm" action="/defaultroot/netdisk!infoFolderSelect.action" target="collection" method="post">
		<input type="hidden" name="httpUrl" value="" id="httpUrl" type="hidden"/>
		<input type="hidden" name="infoId" value="" id="infoId" type="hidden"/>
		<input type="hidden" name="channelIdForCollection" value="" id="channelIdForCollection" type="hidden"/>
		<input type="hidden" name="title" value="" id="title" type="hidden"/>
		<input type="hidden" name="fromModule" value="govdocumentmanager" id="fromModule" type="hidden"/>
	</form>
	<iframe id="dwin" name="dwin" style="display:none"></iframe>
</body>

<script type="text/javascript">	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		
	});

	function getcbx(po,i){
		//var html = " sendFileUserId='"+po.sendFileUserId + "' id='"+po.id+"'";
		var html = 'sendFileUserId="'+ po.sendFileUserId+ '" title="' + po.documentSendFileTitle + '"  url="' +  '/defaultroot/GovDocSendProcess!viewfile.action?viewonly=true&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'"' ;
		//alert(html);
		return html;
	}
	
	
	//自定义操作栏内容
	function myOperate(po,i){
		var html =  '<img src="images/modi.gif" title="修改" style="cursor:hand" onclick="modify(\''+po[0]+'\', \''+po[4]+'\', \''+po[5]+'\', \''+po[6]+'\', \''+po[7]+'\', \''+po[8]+'\')" ><img src="images/del.gif" alt="删除" style="cursor:hand" onclick="delSingle(\''+po[0]+'\')" >';
		return html;
	}

	//自定义查看栏内容
	function show(po,i){
		//var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendProcess!viewfile.action?p_wf_recordId='+po.id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'showUser\'});">'+po.documentSendFileTitle+'</a>';
		if(0==po.isReaded){
			return "<a href='javascript:void(0)' onclick='openWin({url:\"GovDocSendProcess!viewfile.action?sendFileUserId="+po.sendFileUserId+"&empId="+po.empId +"&p_wf_recordId="+po.id+"&canDownLoad="+po.canDownload+"\",width:620,height:290,isResizable: true,isFull: true,winName:\"shownoteread\"});' ><b><font color='red'>"+po.documentSendFileTitle+"</font></b></a>";
		}else{
			return "<a href='javascript:void(0)' onclick='openWin({url:\"GovDocSendProcess!viewfile.action?sendFileUserId="+po.sendFileUserId+"&empId="+po.empId +"&p_wf_recordId="+po.id+"&canDownLoad="+po.canDownload+"\",width:620,height:290,isResizable: true,isFull: true,winName:\"shownoteread\"});' >"+po.documentSendFileTitle+"</a>";
		}
		return html;
	}

	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
		var html ;
		if(po.sex==0){
			html = "男";
		}else{
			html = "女";
		}
		return html;
	}

	//检查表单数据是否正确
	function checkform(){
		if( $("#goodDay0:checked").length>0 )
		if(
		compareTwoDate($("#d122").val(), $("#d124").val()) == ">"
		){
			$.dialog.alert("发文日期开始日期大于结束日期！");
			return false;
		}
		return true;
	}


	

	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd hh:mm:ss");
	}

	//自定义操作栏内容
	function myOperate(po,i){
	
		/*var html =  '<a href="javascript:void(0)" onclick="ajaxDelete(\'GovRecvDocSet!delMyReceive.action?sendFileUserId='+po.sendFileUserId+'&id='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" ></a><a href="javascript:void(0)" onclick="back(\'GovRecvDocSet!backMyReceive.action?sendFileUserId='+po.sendFileUserId+'&id='+po.id+'\');"><img border="0" src="<%=rootPath%>/images/undo.gif" title="退回" ></a>';*/

		
		var html =  '<a href="javascript:void(0)" onclick="ajaxDelete(\'GovRecvDocSet!delMyReceive.action?sendFileUserId='+po.sendFileUserId+'&id='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" ></a><a href="javascript:void(0)" onclick="back(\'sendFileUserId='+po.sendFileUserId+'&empId='+po.empId +'&id='+po.id+'\');"><img border="0" src="<%=rootPath%>/images/undo.gif" title="退回" ></a>';
		<% if(mbd.hasRight(session.getAttribute("userId").toString(),"MYDOCUMENT2INFO*02*01")){%>
		if(po.isSyncToInfomation == "0"){
			html += '<a href="javascript:void(0)" onclick="InfoSynchronization(\''+po.id+'\',\''+po.documentSendFileByteNumber+'\',\''+po.documentSendFileTitle+'\',\''+po.goldGridId+'\',\''+po.sendFileDraft+'\',\''+po.accessoryName+'\',\''+po.accessorySaveName+'\');"><img border="0" src="<%=rootPath%>/images/changePwd.gif" title="同步到信息管理" ></a>';
		}
		<%}%>
		
		return html;
	}

	//查询
	function InfoSynchronization(id,o1,o2,o3,o4,o5,o6){
		//var srcurl="InformationAction.do?action=otherAdd&channelType=0&_type=4&userDefine=0&_fileId="+id;
		var srcurl="/defaultroot/Information!add.action?isfromgov=1&module=0&action=otherAdd&channelType=0&_type=4&userDefine=0&_fileId="+id;

		if(o1!=""&&o1!="null"){
			srcurl+="&_docNO="+o1;
		}
		if(o2!=""){
			srcurl+="&_title="+o2;
		}
		if(o3!=""&&o3!="null"){
			srcurl+="&_content="+o3;
		}
		if(o4!=""&&o4!="null"){
			srcurl+="&_author="+o4;
		}
		if(o5!=""&&o5!="null"){
			srcurl+="&_accessName="+o5;
		}
		if(o6!=""&&o6!="null"){
			srcurl+="&_accessSaveName="+o6;
		}
		openWin({url:srcurl,width:620,height:350,isFull:true,winName:'_blank'});
		//postWindowOpen(srcurl,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600');
	}

	//退回
	function back(url){
		openWin({url:"/defaultroot/modules/govoffice/gov_documentmanager/sendocument_back.jsp?" + url,width:620,height:420,winName:'ddddddddddddddd'});
	    
		return;
		ajaxOperate( {
			urlWithData: url, // 业务访问的url地址：带数据.
			tip:'退回', // 提示.
			isconfirm:true , // 是否需要确认提示.
			formId:'queryForm' , // 待刷新列表的表单id.
			callbackfunction:null // 回调函数.
		});
	}
 <%
//java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());

%>
	function downloadLink(po,i){
		var url = '<%=smartInUse==1?"/defaultroot/public/download":fileServer%>/download.jsp?verifyCode='+po.verifyCode1+'&FileName='+po.goldGridId+'.doc&name='+encodeURIComponent(po.documentSendFileTitle)+'.doc&path=govdocumentmanager';
		if( po.canDownload == "0" ){
			return "";
		}else{
			return "<a href='"+url+"' target='dwin'>下载正文</a>";
		}
		
	}

	String.prototype.replaceAll = function(s1,s2){ return this.replace(new RegExp(s1,"gm"),s2); } 
	//批量收藏
	function collectionBatch(){

		//var ids = '';
		var informationTitle = "";
		var informationId = "";

		informationId = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'id'});
		if(informationId == ''){
			whir_alert('请选择要收藏记录！', null);
			return;
		}
		informationTitle = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'title'});
		informationTitle = informationTitle.replaceAll(",","|");

		var httpUrl = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'url'});
		//GovDocSendProcess!viewfile.action?p_wf_tableId="+po.tableId+"&p_wf_recordId="+po.id+"\",
		//var channelId = '407';
		//var userChannelName = '信息管理';
		//var informationType = "1";
		httpUrl = httpUrl.replaceAll(",","|");
		//
		// httpUrl = "";
		//$("#httpUrl").val("Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+userChannelName+"&channelId="+ch//annelId);
		$("#title").val(informationTitle);
		$("#infoId").val(informationId);
		$("#httpUrl").val(httpUrl);
		//$("#channelIdForCollection").val(channelId);
		openWin({url:'netdisk!infoFolderSelect.action',winName:'collection',width:650,height:350});
		$("#collectionForm").submit();


		//ajaxBatchOperate({url:"GovTrans!backBatch.action",checkbox_name:"docId",attr_name:"docId",tip:"追回",isconfirm:true,formId:"queryForm",callbackfunction:null});
	}
	
   </script>
<script>
function init(){

		//角色选择  组织
		var cb2 = new Ext.form.ComboBox({
			id : 'queryOrg_extId',  
			typeAhead: true,
			triggerAction: 'all',
			transform:'queryOrg',
			hiddenName:'queryOrg',
			name:'queryOrg_name',
			width:300,
			forceSelection:true, 
			listeners:{
				select:{
					fn:function(combo, record, index){
						//changeChannel(this); 
						// changeTable(this); 
					}
				}
			}
		}); 

   }
</script> 
</html>


