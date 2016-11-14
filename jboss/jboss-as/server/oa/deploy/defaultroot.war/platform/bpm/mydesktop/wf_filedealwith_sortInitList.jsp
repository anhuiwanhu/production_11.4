<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  whir_custom_str="easyui,powerFloat ";
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
<title></title>  
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
<%@ include file="/public/include/meta_base.jsp"%>  
<%@ include file="/public/include/meta_list.jsp"%>  
<!--这里可以追加导入模块内私有的js文件或css文件-->
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/ezform.js"></script>
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>
<style>
.bInputtext{width:30%;}
.bInputtext_hover{width:30%;}
.bInputtext:hover{width:30%;}
</style>
</head>
<%
String attachmentField = "";

String fileServer = (com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr())==null || com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr()).length()<1 || "null".equals(com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr())))?rootPath:com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());

String key = request.getAttribute("key")==null?"":request.getAttribute("key").toString();
String whir_formKey = request.getAttribute("whir_formKey")==null?"":request.getAttribute("whir_formKey").toString();
String pageId = request.getAttribute("pageId")==null?"":request.getAttribute("pageId").toString();

String openType = request.getParameter("openType")==null?"":request.getParameter("openType").toString();
String relation = request.getParameter("relation")==null?"":request.getParameter("relation").toString();

String processID = request.getParameter("processID")==null?"":request.getParameter("processID").toString();

String isViewWorkFlow = request.getParameter("isViewWorkFlow");

String noTreatment = request.getParameter("noTreatment")==null?"0":request.getParameter("noTreatment").toString();
//人事模块参数
String underUserId = request.getParameter("underUserId")==null?"":request.getParameter("underUserId").toString();

String from = request.getParameter("from")==null?"":request.getParameter("from").toString();
//人事模块参数
String employeeId = request.getParameter("employeeId")==null?"":request.getParameter("employeeId").toString();
//1:ezflow 0:workflow
String isEzflow = request.getParameter("isEzflow")==null?"":request.getParameter("isEzflow").toString();
%>
<body class="MainFrameBox">
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="queryForm" id="queryForm" action="/wfdealwith!getSortInitList.action" method="post">
<input type="hidden" name="key" value="<%=key%>"/>
<input type="hidden" name="whir_formKey" value="<%=whir_formKey%>"/>
<input type="hidden" name="pageId" value="<%=pageId%>"/>
<input type="hidden" id="openType" name="openType" value="<%=openType%>"/>
<input type="hidden" id="relation" name="relation" value="<%=relation%>"/>
<input type="hidden" id="processID" name="processID" value="<%=processID%>"/>
<input type="hidden" id="noTreatment" name="noTreatment" value="<%=noTreatment%>"/>
<input type="hidden" id="underUserId" name="underUserId" value="<%=underUserId%>"/>
<input type="hidden" id="from" name="from" value="<%=from%>"/>
<input type="hidden" id="employeeId" name="employeeId" value="<%=employeeId%>"/>
<input type="hidden" id="isViewWorkFlow" name="isViewWorkFlow" value="<%=isViewWorkFlow%>"/>
<input type="hidden" id="isEzflow" name="isEzflow" value="<%=isEzflow%>"/>
<!-- SEARCH PART START -->  
<%@ include file="/public/include/form_list.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
    <s:property value="searchPart" escape="false"/>
	<tr>
		<td class="whir_td_searchtitle" ><s:text name="file.processpromoters"/>：</td>
		<td class="whir_td_searchinput" >
			<s:textfield id="startUserName" name="startUserName" size="16" cssClass="inputText" />
		</td>
		<td class="whir_td_searchtitle" ></td>
		<td class="whir_td_searchinput" ></td>
		<td class="whir_td_searchtitle" ></td>
		<td class="whir_td_searchinput" ></td>
	</tr>

    <s:hidden name="searchBeginDate"  id="searchBeginDate" />
	<s:hidden name="searchEndDate"    id="searchEndDate"   />
    
	<s:hidden name="workDoneWithDateEnd"      id="workDoneWithDateEnd"   />
	<s:hidden name="workDoneWithDateBegin"    id="workDoneWithDateBegin"   />
	<s:hidden name="search_attention"        id="search_attention"   />
	<s:hidden name="submitOrg"    id="submitOrg"   />
	<s:hidden name="workTitle"    id="workTitle"   />
	<s:hidden name="pressDeal"    id="pressDeal"   /> 


    <tr>
        <td class='SearchBar_toolbar' colspan="6">
            <input type="button" class="btnButton4font" onClick="refreshTheListForm('queryForm');" value="<s:text name="comm.searchnow"/>"/>
            <input type="button" class="btnButton4font" onClick="resetTheForm(this);" value="<s:text name="comm.clear"/>"/>
        </td>
    </tr>
</table>
<!-- SEARCH PART END -->

<!-- MIDDLE  BUTTONS START -->  
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
    <tr>
        <td align="left">&nbsp;</td>
        <td align="right">
			<s:if test="from=='workflow'">
				<s:if test="relation==1">
				</s:if>
				<s:else>
					<s:if test="openType=='waitingDeal'">
						<input name="" type="button" value='<s:text name="workflow.noprocessing"/>' class="btnButton4font"  id="noTreatmentButton" onClick="batchNoTreatment(this);" />
						<input name="" type="button" value='<s:text name="file.bulkhandling"/>' class="btnButton4font" onClick="batchDeal_fun();" />  
					</s:if>
					<s:if test="openType=='waitingRead'">
						<input name="" type="button" value='<s:text name="file.bulkhandling"/>' class="btnButton4font" onClick="batchView_fun();" />  
					</s:if>
					<s:if test="openType=='tran'||openType=='waitingDeal' ">
						<input name="" type="button" value='<s:text name="file.bulktransend"/>' class="btnButton4font" onClick="batchTran_fun();" />  
					</s:if>	
					<s:if test="openType=='myTask'||openType=='dealed'||openType=='readed'">
						<input name="" type="button" value='<s:text name="comm.delselect"/>' class="btnButton4font" onClick="batchDelete(this);" />  
					</s:if>
				</s:else>
			</s:if>
			<input type="button" class="btnButton4font" onClick="backFiledealwithList('<%=openType%>');" value="<s:text name="file.backButton"/>">
        </td>  
    </tr>
</table>  
<!-- MIDDLE  BUTTONS END -->  

<!-- LIST TITLE PART START -->      
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">  
    <!-- thead必须存在且id必须为headerContainer -->
    <thead id="headerContainer">  
    <tr class="listTableHead">
        <s:if test="openType!='myUnderWaitingDeal'&&relation!=1&&from=='workflow'">
			<td whir-options="field:'wfWorkId',width:'2%', checkbox:true, renderer:showBatchDeal"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('wfWorkId',this.checked);" ></td>
		</s:if>
		<%
        String[][] listFields = (String[][])request.getAttribute("listFields");
        if(listFields != null && listFields.length > 0){
            for(int i=0; i<listFields.length; i++){
		%>
        <td whir-options="field:'<%=listFields[i][2]%>',width:'<%=listFields[i][3]%>%', allowSort:true<%if("115".equals(listFields[i][4])){attachmentField += listFields[i][2] + ";" ;%>, renderer:renderAttachment<%}%>"><%=listFields[i][1]%></td>
		<%}}%>
        <td whir-options="field:'_curDisActivityName',width:'10%',renderer:showOpen"><bean:message bundle="filetransact" key="file.dostatus"/></td> 
		<td whir-options="field:'_curDisEmpName',width:'8%'"><bean:message bundle="filetransact" key="file.people"/></td>
		<s:if test="openType=='waitingDeal'||openType=='tran'">
			<td whir-options="field:'_banliqixian',width:'12%' " nowrap ><bean:message bundle="filetransact" key="file.doschedule"/></td> 
		</s:if>
		<s:if test="openType=='myTask'||openType=='myTask'||openType=='dealed'">
			<td whir-options="field:'workDoneWithDate',width:'12%',renderer:common_DateFormatMinite" nowrap><s:text name="workflowAnalysis.TransactedTime"/></td> 
		</s:if>
		<s:if test="(openType=='myTask'||openType=='dealed'||openType=='readed')&&from=='workflow'">
			<td whir-options="field:'',width:'8%',renderer:showDeleteOperate"><bean:message bundle="common" key="comm.opr" /></td>
		</s:if>
		<s:if test="openType=='waitingDeal'&&relation!=1">
			<td whir-options="field:'attention',width:'5%',allowSort:true,renderer:showAttention" nowrap><s:text name="workflow.focuson"/></td> 
		</s:if>
    </tr>
    </thead>
    <!-- tbody必须存在且id必须为itemContainer -->  
    <tbody id="itemContainer">
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
<iframe id="downf" name="downf" style="display:none;"></iframe>
</body>
<script type="text/javascript">
//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){         
	initListFormToAjax({formId:"queryForm"});
});

/**
展现批量选择复选框
*/
function showBatchDeal(po, i){
    var html =' wfWorkId="'+po.wfWorkId+'"  isezFlow="'+po.isezFlow+'"  workProcessId="'+  po.workProcessId+
		'"  workTableId="'+po.workTableId+'"  workRecordId="'+po.workRecordId+'"  ezFlowTaskId="'+po.ezFlowTaskId+'" ezFlowProcessInstanceId="'+po.ezFlowProcessInstanceId+'" ezFlowTaskId_verifyCode="'+po.ezFlowTaskId_verifyCode+'"  ezFlowProcessInstanceId_verifyCode="'+po.ezFlowProcessInstanceId_verifyCode+'" wfWorkId_verifyCode="'+po.wfWorkId_verifyCode+'"  workMainLinkFile="'+po.workMainLinkFile+'"'; 
	var openType=$("#openType").val();
	if(openType=="myTask"){
		if(po._workStatus=="100"||po._workStatus=="-1"||po._workStatus=="-2"){
			
		}else{
			html+=' disabled=true ';
		}	 
	}
	if(openType=="dealed"){
		//已办 的只有办结的才删除     100  办理完毕	
		if(po._workStatus=="1012"){
			
		}else{	
			html+=' disabled=true ';
		}		 
	}
	//alert(html);
	return html;
}

function  showOpen(po,i){
	var isViewWorkFlow =$('#isViewWorkFlow').val();
	var redStyle=' style="color:#1396b3"';		 
	if(po._overDate=="true"){
		redStyle=' style="color:red"';
	}
	var html ='';
	if("no"==isViewWorkFlow){ 
		html =  '<a '+redStyle+' href="javascript:void(0)" onclick="noRightAlert()">'+po._curDisActivityName+'</a>';
	}else{
		html =  '<a '+redStyle+' href="javascript:void(0)" onclick="openWorkFlow(\''+po.workMainLinkFile+'\',\''+po.wfWorkId+'\',\''+po.workRecordId+'\',\''+po.isezFlow+'\',\''+po.ezFlowTaskId+'\',\''+po.ezFlowProcessInstanceId+'\',\''+po.wfWorkId_verifyCode+'\',\''+po.ezFlowTaskId_verifyCode+'\',\''+po.ezFlowProcessInstanceId_verifyCode+'\',\'\');">'+po._curDisActivityName+'</a>';
	}
	return html;
}

function noRightAlert(){ 
	 whir_alert("无权限查看！");
}

function renderAttachment(po, i){
    var attachmentField = '<%=attachmentField%>';
    var atArr = attachmentField.split(';');
    var html = '';
	
    for(var i=0; i<atArr.length; i++){
        var f = atArr[i];
        if(f != ''){
            var pof = eval('po.'+f);
            if(pof != null && pof != '' && pof != 'NULL' && pof != 'null'){
                var fArr = pof.indexOf(';')!=-1?pof.split(';'):pof.split('|');
                var realName = fArr[0].split(',');
                var showName = fArr[1].split(',');
                for(var j=0; j<realName.length; j++){
                    if(realName[j] != ''){
                        if(html != '') html += ',';
                        html += '<a style="cursor:pointer;" href="<%=rootPath%>/platform/monitor/download.jsp?FileName=' + realName[j] + '&name=' + encodeURIComponent(showName[j]) + '&path=customform" target="downf">' + showName[j] + '</a>';
                    }
                }
            }
        }
    }
    return html;
}

function showDeleteOperate(po ,i){
	var html =  '<a href="javascript:void(0)" onclick="ajaxDelete(\'${ctx}/wfdealwith!deleteWork.action?openType='+$("#openType").val()+'&wfWorkId='+po.wfWorkId+'&ezFlowTaskId='+po.ezFlowTaskId+'&ezFlowProcessInstanceId='+po.ezFlowProcessInstanceId+'&isezFlow='+po.isezFlow+'&workRecordId='+po.workRecordId+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="comm.sdel"/>" ></a>';

	var openType=$("#openType").val();
	if(openType=="myTask"){
		//	
		if(po._workStatus=="100"||po._workStatus=="-1"||po._workStatus=="-2"){

		}else{	
			html='';
		}
		
		//可以有重新发起
		if(po._workStatus=="-1"||po._workStatus=="-2"){
			html+='<a href="javascript:void(0)" onclick="re_openWorkFlow(\''+po.workMainLinkFile+'\',\''+po.wfWorkId+'\',\''+po.workRecordId+'\',\''+po.isezFlow+'\',\''+po.ezFlowTaskId+'\',\''+po.ezFlowProcessInstanceId+'\',\''+po.wfWorkId_verifyCode+'\',\''+po.ezFlowTaskId_verifyCode+'\',\''+po.ezFlowProcessInstanceId_verifyCode+'\',\'reStart\');"><img border="0" src="<%=rootPath%>/images/cxtj.gif" title="<bean:message bundle="filetransact" key="file.resubmit"/>" ></a>';
		}else{	
			//再次发起
			html+='<a href="javascript:void(0)" onclick="re_openWorkFlow(\''+po.workMainLinkFile+'\',\''+po.wfWorkId+'\',\''+po.workRecordId+'\',\''+po.isezFlow+'\',\''+po.ezFlowTaskId+'\',\''+po.ezFlowProcessInstanceId+'\',\''+po.wfWorkId_verifyCode+'\',\''+po.ezFlowTaskId_verifyCode+'\',\''+po.ezFlowProcessInstanceId_verifyCode+'\',\'startAgain\');"><img border="0" src="<%=rootPath%>/images/cxtj.gif" title="<bean:message bundle="workflow" key="workflow.sendAgain"/>" ></a>';
		}
	}
	if(openType=="dealed"){
		//已办 的只有办结的才删除     100  办理完毕	
		if(po._workStatus=="1012"){

		}else{	
			html='';
		}		 
	}
	return html;
}

/**显示关注**/
function showAttention(po,i){ 
	var hl='<a href="javascript:void(0)"  onclick="ajaxOperate({urlWithData:\'<%=rootPath%>/wfdealwith!setAttention.action?wfWorkId='+po.wfWorkId+'\',tip:\'<s:text name="workflow.setthefocus"/>\',isconfirm:true,formId:\'queryForm\',callbackfunction:null});" ><img border="0" src="<%=rootPath%>/images/cancelgz.png" title="<s:text name="workflow.setthefocus"/>" ></a>'
	if(po.attention=="1"){
		hl='<a href="javascript:void(0)"   onclick="ajaxOperate({urlWithData:\'<%=rootPath%>/wfdealwith!cancelAttention.action?wfWorkId='+po.wfWorkId+'\',tip:\'<s:text name="workflow.canceltheattention"/>\',isconfirm:true,formId:\'queryForm\',callbackfunction:null});"   ><img border="0" src="<%=rootPath%>/images/setgz.png" title="<s:text name="workflow.canceltheattention"/>" ></a>'
	}  
	return hl;
}

//再次发起  重新发起
function  re_openWorkFlow(url, workId, recordId, isezFlow, ezFlowTaskId, ezFlowProcessInstanceId, 	wfWorkId_verifyCode, ezFlowTaskId_verifyCode, ezFlowProcessInstanceId_verifyCode, openType){

	var openurl=url;
	var purl="wfWorkId="+workId+"&p_wf_recordId="+recordId+"&p_wf_openType="+openType+"&verifyCode="+wfWorkId_verifyCode;
	if(url.indexOf("?")>=0){
		openurl=openurl+"&"+purl;
	}else{
		openurl=openurl+"?"+purl;
	}
	openurl+="&p_wf_pool_processType=0"; 
	//新工作流
	if(isezFlow=="1"){
		if(url==null||url==""||url=="null"){
			url="<%=rootPath%>/ezflowopen!updateProcess.action";
		}
		if(!url.startWith("<%=rootPath%>")){
			url="<%=rootPath%>"+url;
		} 
		var purl="p_wf_pool_processType=1&ezFlowProcessInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType="+openType+"&p_wf_recordId="+recordId;
		if(url.indexOf("?")>=0){ 
			openurl=url+"&"+purl;
		}else{
			openurl=url+"?"+purl; 
		}   
	}  
	openWin({url:openurl,isFull:true,width:850,height:750,winName:'openWorkFlow'+workId});
}

function refreshTheListForm(obj) {
    refreshListForm(obj);
}

function resetTheForm(obj){

	 $("#searchBeginDate").val("");
	$("#searchEndDate").val("");
	$("#startUserName").val("");

	$("#search_attention").val("");
	$("#submitOrg").val("");
	$("#workTitle").val("");
	$("#pressDeal").val("");  

    $("#workDoneWithDateEnd").val("");
	$("#workDoneWithDateBegin").val(""); 


    resetForm(obj);
}

/**
*暂不处理
*/
function  batchNoTreatment(obj){  
	 var wfWorkIds= getCheckBoxData("wfWorkId","wfWorkId"); 
	 if(wfWorkIds==""){
		   $.dialog.alert('<s:text name="workflow.pleasechoosedata"/>',function(){});
	 }else{ 
		   var wfWorkId_verifyCodes= getCheckBoxData("wfWorkId","wfWorkId_verifyCode"); 
		   var wfWorkIdArr=wfWorkIds.split(","); 
		   var wfWorkId_verifyCodeArr=wfWorkId_verifyCodes.split(",");  
		   var batchValues=wfWorkIdArr[0];  
		   if(wfWorkIdArr.length>1){
			   for(var i=1;i<wfWorkIdArr.length;i++){ 
				  batchValues+=","+wfWorkIdArr[i]; 
			   }
		   }
		   var openurl="<%=rootPath%>/wfbuttonevent!notreatmentInit.action?batchValues="+batchValues;
		   openWin({url:openurl,width:550,height:260,winName:'openWorkFlow'});     
	 } 
}

//批量办理
function  batchDeal_fun(){
	var wfWorkIds= getCheckBoxData("wfWorkId","wfWorkId"); 
	if(wfWorkIds==""){
		whir_alert('<s:text name="workflow.pleasechoosedata"/>',function(){});
	}else{
		var isezFlows= getCheckBoxData("wfWorkId","isezFlow");
		var workRecordIds= getCheckBoxData("wfWorkId","workRecordId");
		var workProcessIds= getCheckBoxData("wfWorkId","workProcessId");
		var workTableIds= getCheckBoxData("wfWorkId","workTableId");
		var ezFlowTaskIds= getCheckBoxData("wfWorkId","ezFlowTaskId");
		var ezFlowProcessInstanceIds= getCheckBoxData("wfWorkId","ezFlowProcessInstanceId");
		var wfWorkId_verifyCodes= getCheckBoxData("wfWorkId","wfWorkId_verifyCode");
		var ezFlowTaskId_verifyCodes= getCheckBoxData("wfWorkId","ezFlowTaskId_verifyCode");
		var ezFlowProcessInstanceId_verifyCodes= getCheckBoxData("wfWorkId","ezFlowProcessInstanceId_verifyCode");
		var workMainLinkFiles=getCheckBoxData("wfWorkId","workMainLinkFile");

		var wfWorkIdArr=wfWorkIds.split(",");
		var isezFlowArr=isezFlows.split(",");
		var workRecordIdArr=workRecordIds.split(",");
		var workProcessIdArr=workProcessIds.split(",");
		var workTableIdArr=workTableIds.split(",");
		var ezFlowTaskIdArr=ezFlowTaskIds.split(",");
		var ezFlowProcessInstanceIdArr=ezFlowProcessInstanceIds.split(",");
		var wfWorkId_verifyCodeArr=wfWorkId_verifyCodes.split(",");
		var ezFlowTaskId_verifyCodeArr=ezFlowTaskId_verifyCodes.split(",");
		var ezFlowProcessInstanceId_verifyCodeArr=ezFlowProcessInstanceId_verifyCodes.split(",");
		var workMainLinkFileArr=workMainLinkFiles.split(",");
		var first_workRecordId=workRecordIdArr[0];
		var first_isezFlow=isezFlowArr[0];   
		var first_wfWorkId=wfWorkIdArr[0]; 
		var first_ezFlowTaskId=ezFlowTaskIdArr[0]; 
		var first_ezFlowProcessInstanceId=ezFlowProcessInstanceIdArr[0]; 
		var first_wfWorkId_verifyCode=wfWorkId_verifyCodeArr[0]; 
		var first_ezFlowTaskId_verifyCode=ezFlowTaskId_verifyCodeArr[0]; 
		var first_ezFlowProcessInstanceId_verifyCode=ezFlowProcessInstanceId_verifyCodeArr[0]; 
		var first_url=workMainLinkFileArr[0]; 
 
		var p_wf_batchWorkIds="";
		if(isezFlowArr.length>1){
			if(first_isezFlow=="0"){
				p_wf_batchWorkIds=first_wfWorkId;
			}else{
				//ezFlow不需要第一个
				p_wf_batchWorkIds="";
			}
			for(var i=1;i<isezFlowArr.length;i++){
				if(isezFlowArr[i]==first_isezFlow){
					if(first_isezFlow=="0"){
						p_wf_batchWorkIds+=","+wfWorkIdArr[i];
					}else{
						if(p_wf_batchWorkIds==""){
							p_wf_batchWorkIds+=ezFlowTaskIdArr[i];
						}else{
							p_wf_batchWorkIds+=","+ezFlowTaskIdArr[i];
						}
					}
				}
			}
		}
		openWorkFlow(first_url,first_wfWorkId, first_workRecordId,first_isezFlow,first_ezFlowTaskId,first_ezFlowProcessInstanceId, first_wfWorkId_verifyCode,first_ezFlowTaskId_verifyCode,first_ezFlowProcessInstanceId_verifyCode,p_wf_batchWorkIds);
	}
}

/**
阅件批量办理
*/
function  batchView_fun(){
	 var wfWorkIds= getCheckBoxData("wfWorkId","wfWorkId"); 
	 if(wfWorkIds==""){
		   $.dialog.alert('<s:text name="workflow.pleasechoosedata"/>',function(){});
	 }else{
		   var isezFlows= getCheckBoxData("wfWorkId","isezFlow");
		   var workRecordIds= getCheckBoxData("wfWorkId","workRecordId");
		   var workProcessIds= getCheckBoxData("wfWorkId","workProcessId");
		   var workTableIds= getCheckBoxData("wfWorkId","workTableId");
		   var ezFlowTaskIds= getCheckBoxData("wfWorkId","ezFlowTaskId");
		   var ezFlowProcessInstanceIds= getCheckBoxData("wfWorkId","ezFlowProcessInstanceId");
		   var wfWorkId_verifyCodes= getCheckBoxData("wfWorkId","wfWorkId_verifyCode");
		   var ezFlowTaskId_verifyCodes= getCheckBoxData("wfWorkId","ezFlowTaskId_verifyCode");
		   var ezFlowProcessInstanceId_verifyCodes= getCheckBoxData("wfWorkId","ezFlowProcessInstanceId_verifyCode");
		   var workMainLinkFiles=getCheckBoxData("wfWorkId","workMainLinkFile");

		   var wfWorkIdArr=wfWorkIds.split(",");
		   var isezFlowArr=isezFlows.split(",");
		   var workRecordIdArr=workRecordIds.split(",");
		   var workProcessIdArr=workProcessIds.split(",");
		   var workTableIdArr=workTableIds.split(",");
		   var ezFlowTaskIdArr=ezFlowTaskIds.split(",");
		   var ezFlowProcessInstanceIdArr=ezFlowProcessInstanceIds.split(",");
		   var wfWorkId_verifyCodeArr=wfWorkId_verifyCodes.split(",");
		   var ezFlowTaskId_verifyCodeArr=ezFlowTaskId_verifyCodes.split(",");
		   var ezFlowProcessInstanceId_verifyCodeArr=ezFlowProcessInstanceId_verifyCodes.split(",");
		   var workMainLinkFileArr=workMainLinkFiles.split(",");
		   var first_workRecordId=workRecordIdArr[0];
		   var first_isezFlow=isezFlowArr[0];   
		   var first_wfWorkId=wfWorkIdArr[0]; 
		   var first_ezFlowTaskId=ezFlowTaskIdArr[0]; 
		   var first_ezFlowProcessInstanceId=ezFlowProcessInstanceIdArr[0]; 
		   var first_wfWorkId_verifyCode=wfWorkId_verifyCodeArr[0]; 
		   var first_ezFlowTaskId_verifyCode=ezFlowTaskId_verifyCodeArr[0]; 
		   var first_ezFlowProcessInstanceId_verifyCode=ezFlowProcessInstanceId_verifyCodeArr[0]; 
		   var first_url=workMainLinkFileArr[0]; 
		   //workId*tableId*processId*recordId*activityId*isEzFlow*ezFlowTaskId*ezFlowProcessInstanceId
		   var batchValues=first_wfWorkId;
		   //workFlow 取的 是workId   ezFLOW 取的是任务id
		   if(first_isezFlow=="1"){
			   //batchValues=first_ezFlowTaskId;
			   //ezFlow不需要第一个
			   batchValues="";
		   }else{
			   batchValues=first_wfWorkId;
		   }
		   if(isezFlowArr.length>1){
			   for(var i=1;i<isezFlowArr.length;i++){
				   if(isezFlowArr[i]==first_isezFlow){
					   if(first_isezFlow=="1"){ 
							if(batchValues==""){
							   batchValues+=ezFlowTaskIdArr[i];
							}else{
							   batchValues+=","+ezFlowTaskIdArr[i];
							} 
					   }else{
							batchValues+=","+wfWorkIdArr[i];
					   }
					  
				   }
			   }
		   }
		   if(first_isezFlow=="1"){
				openWorkFlow(first_url,first_wfWorkId, first_workRecordId,first_isezFlow,first_ezFlowTaskId,first_ezFlowProcessInstanceId, first_wfWorkId_verifyCode,first_ezFlowTaskId_verifyCode,first_ezFlowProcessInstanceId_verifyCode,batchValues);		   
		   }else{
			   var openurl="<%=rootPath%>/wfoperate!showBatchRead.action?batchValues="+batchValues;
			   openWin({url:openurl,width:650,height:330,winName:'openWorkFlow'+first_wfWorkId});   
		   }		  
	 }
}

/**
 批量转交
*/
function  batchTran_fun(){ 
	 var wfWorkIds= getCheckBoxData("wfWorkId","wfWorkId"); 
	 if(wfWorkIds==""){
		   $.dialog.alert('<s:text name="workflow.pleasechoosedata"/>',function(){});
	 }else{
		   var isezFlows= getCheckBoxData("wfWorkId","isezFlow");
		   var workRecordIds= getCheckBoxData("wfWorkId","workRecordId");
		   var workProcessIds= getCheckBoxData("wfWorkId","workProcessId");
		   var workTableIds= getCheckBoxData("wfWorkId","workTableId");
		   var ezFlowTaskIds= getCheckBoxData("wfWorkId","ezFlowTaskId");
		   var ezFlowProcessInstanceIds= getCheckBoxData("wfWorkId","ezFlowProcessInstanceId");
		   var wfWorkId_verifyCodes= getCheckBoxData("wfWorkId","wfWorkId_verifyCode");
		   var ezFlowTaskId_verifyCodes= getCheckBoxData("wfWorkId","ezFlowTaskId_verifyCode");
		   var ezFlowProcessInstanceId_verifyCodes= getCheckBoxData("wfWorkId","ezFlowProcessInstanceId_verifyCode");
		   var workMainLinkFiles=getCheckBoxData("wfWorkId","workMainLinkFile");

		   var wfWorkIdArr=wfWorkIds.split(",");
		   var isezFlowArr=isezFlows.split(",");
		   var workRecordIdArr=workRecordIds.split(",");
		   var workProcessIdArr=workProcessIds.split(",");
		   var workTableIdArr=workTableIds.split(",");
		   var ezFlowTaskIdArr=ezFlowTaskIds.split(",");
		   var ezFlowProcessInstanceIdArr=ezFlowProcessInstanceIds.split(",");
		   var wfWorkId_verifyCodeArr=wfWorkId_verifyCodes.split(",");
		   var ezFlowTaskId_verifyCodeArr=ezFlowTaskId_verifyCodes.split(",");
		   var ezFlowProcessInstanceId_verifyCodeArr=ezFlowProcessInstanceId_verifyCodes.split(",");
		   var workMainLinkFileArr=workMainLinkFiles.split(",");
			
		   var first_workRecordId=workRecordIdArr[0];
		   var first_isezFlow=isezFlowArr[0];   
		   var first_wfWorkId=wfWorkIdArr[0]; 
		   var first_ezFlowTaskId=ezFlowTaskIdArr[0]; 
		   var first_ezFlowProcessInstanceId=ezFlowProcessInstanceIdArr[0]; 
		   var first_wfWorkId_verifyCode=wfWorkId_verifyCodeArr[0]; 
		   var first_ezFlowTaskId_verifyCode=ezFlowTaskId_verifyCodeArr[0]; 
		   var first_ezFlowProcessInstanceId_verifyCode=ezFlowProcessInstanceId_verifyCodeArr[0]; 
		   var first_url=workMainLinkFileArr[0]; 
		   //workId*tableId*processId*recordId*activityId*isEzFlow*ezFlowTaskId*ezFlowProcessInstanceId
		   var batchValues=first_wfWorkId;
		   //workFlow 取的 是workId   ezFLOW 取的是任务id
		   if(first_isezFlow=="1"){
			   batchValues=first_ezFlowTaskId;
		   }else{
			   batchValues=first_wfWorkId;
		   }
		   if(isezFlowArr.length>1){
			   for(var i=1;i<isezFlowArr.length;i++){
				   if(isezFlowArr[i]==first_isezFlow){
					   if(first_isezFlow=="1"){
							batchValues+=","+ezFlowTaskIdArr[i];
					   }else{
							batchValues+=","+wfWorkIdArr[i];
					   }
				   }
			   }
		   }
		   if(first_isezFlow=="1"){
				var openurl="<%=rootPath%>/ezflowbuttonevent!trans_batch_init.action?batchValues="+batchValues+"&openType="+$("#openType").val();
				openWin({url:openurl,width:850,height:650,winName:'openWorkFlow'+first_wfWorkId});  
		   }else{
				var openurl="<%=rootPath%>/wfoperate!trans_batch_init.action?batchValues="+batchValues;
				openWin({url:openurl,width:850,height:650,winName:'openWorkFlow'+first_wfWorkId});   
		   }			  
	 }
}

function  batchDelete(obj){
	ajaxBatchDelete('<%=rootPath%>/wfdealwith!deleteWork.action?openType='+$("#openType").val(),'wfWorkId','wfWorkId,ezFlowTaskId,ezFlowProcessInstanceId,isezFlow,workRecordId',obj);
}

//打开流程
function openWorkFlow(url,workId,recordId,isezFlow,ezFlowTaskId,ezFlowProcessInstanceId,
	wfWorkId_verifyCode,ezFlowTaskId_verifyCode,ezFlowProcessInstanceId_verifyCode,batchWorkIds){
	var openType=$("#openType").val();
	
	//转交
	if(openType=="tran"){
		 if(isezFlow=="1"){
			 var openurl="<%=rootPath%>/ezflowbuttonevent!trans_batch_init.action?batchValues="+ezFlowTaskId;
			 openWin({url:openurl,width:850,height:650,winName:'openWorkFlow'+workId});  
		 }else{
			 var openurl="<%=rootPath%>/wfoperate!trans_batch_init.action?batchValues="+workId;
			 openWin({url:openurl,width:850,height:650,winName:'openWorkFlow'+workId});   
		 }			
	}else{  
		//新工作流
		if(isezFlow=="1"){
			if(url==null||url==""||url=="null"){
				url="<%=rootPath%>/ezflowopen!updateProcess.action";
			}
			if(!url.startWith("<%=rootPath%>")){
				url="<%=rootPath%>"+url;
			}
			if(recordId=="-1"){
			   recordId="";
			}
			if(openType=="myTask"||openType=="ibacked"){
				openurl=url+"?ezFlowProcessInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType="+$("#openType").val()+"&p_wf_pool_processType=1&p_wf_recordId="+recordId; 
				if(url.indexOf("?")>=0){ 
					 openurl=url+"&ezFlowProcessInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType="+$("#openType").val()+"&p_wf_pool_processType=1&p_wf_recordId="+recordId;
				}else{
					openurl=url+"?ezFlowProcessInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType="+$("#openType").val()+"&p_wf_pool_processType=1&p_wf_recordId="+recordId;
				}     
			}else{
				if(url.indexOf("?")>=0){ 
					 openurl=url+"&ezFlowTaskId="+ezFlowTaskId+"&verifyCode="+ezFlowTaskId_verifyCode+"&p_wf_openType="+$("#openType").val()+"&otherTaskId="+batchWorkIds+"&p_wf_pool_processType=1&p_wf_recordId="+recordId;
				}else{
					openurl=url+"?ezFlowTaskId="+ezFlowTaskId+"&verifyCode="+ezFlowTaskId_verifyCode+"&p_wf_openType="+$("#openType").val()+"&otherTaskId="+batchWorkIds+"&p_wf_pool_processType=1&p_wf_recordId="+recordId;
				}    
			}
		}else{
			//老工作流
			var openurl=url;
			var purl="wfWorkId="+workId+"&p_wf_recordId="+recordId+"&p_wf_openType="+$("#openType").val()+"&p_wf_batchWorkIds="+batchWorkIds+"&verifyCode="+wfWorkId_verifyCode;
			if(url.indexOf("?")>=0){
			   openurl=openurl+"&"+purl;
			}else{
			   openurl=openurl+"?"+purl;
			} 
			openurl+="&p_wf_pool_processType=0"; 
		} 
		openurl=openurl+"&from=workflow"; 
		openWin({url:openurl,isFull:true,width:850,height:750,winName:'openWorkFlow'+workId});
	}
}

function backFiledealwithList(openType){
	//alert("openType:"+openType);
	var from =$('#from').val();
	var underUserId =$('#underUserId').val();
	var isViewWorkFlow =$('#isViewWorkFlow').val();
	var employeeId =$('#employeeId').val();
	//alert("from:"+from);
	var url ="";
	if(openType == 'waitingDeal'){
		url ="/defaultroot/wfdealwith!dealwithList.action?openType=waitingDeal&noTreatment=0";
	}else if(openType == 'waitingRead'){
		url ="/defaultroot/wfdealwith!dealwithList.action?openType=waitingRead";
	}else if(openType == 'dealed'){
		if(from =='hrm'){
			url ="/defaultroot/wfdealwith!dealwithList.action?openType=dealed&employeeId="+employeeId+"&from=hrm&isViewWorkFlow="+isViewWorkFlow;
		}else{
			url ="/defaultroot/wfdealwith!dealwithList.action?openType=dealed";
		}
	}else if(openType == 'readed'){
		url ="/defaultroot/wfdealwith!dealwithList.action?openType=readed";
	}else if(openType == 'myTask'){
		if(from =='hrm'){
			url ="/defaultroot/wfdealwith!dealwithList.action?openType=myTask&employeeId="+employeeId+"&from=hrm&isViewWorkFlow="+isViewWorkFlow;
		}else{
			url ="/defaultroot/wfdealwith!dealwithList.action?openType=myTask";
		}
	}else if(openType == 'myUnderWaitingDeal'){
		if(from =='hrm'){
			url ="/defaultroot/wfdealwith!dealwithList.action?openType=myUnderWaitingDeal&underUserId="+underUserId+"&from=hrm&isViewWorkFlow="+isViewWorkFlow;
		}else{
			url ="/defaultroot/wfdealwith!dealwithList.action?openType=myUnderWaitingDeal";
		}
	}else if(openType == 'tran'){
		url ="/defaultroot/wfdealwith!dealwithList.action?openType=tran";
	}
	url =url + "&sortType=sortType";
	url = encodeURI(url);
	//alert(url);
	location_href(url);
}
</script>
</html>