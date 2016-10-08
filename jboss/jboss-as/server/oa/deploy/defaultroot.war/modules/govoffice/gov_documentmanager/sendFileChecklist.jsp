<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>经办文件查阅</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="/defaultroot/GovDocSendCheckProcess!listData.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr>
            <td class="whir_td_searchtitle" nowrap>标题：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryTitle" name="queryTitle" size="16" cssClass="inputText"  />
            </td>
           
			<td class="whir_td_searchtitle" nowrap>来文日期：</td>
            <td class="whir_td_searchinput">
            	
				<input name="queryBeginDate"  id="empBirth"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'empBirth2\');}'})" /> 至   
				<input name="queryEndDate" id="empBirth2"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'empBirth\');}'})" />  

        		<!--<input type="checkbox" name="queryItem" id="goodDay0" value="1"/>-->
	        </td>
			 <td class="whir_td_searchtitle" nowrap>办理状态：</td>
            <td class="whir_td_searchinput">
                <select id="queryStatus" class="easyui-combobox" name="queryStatus" >  
					<option value="">--请选择--</option>
					<option value="0">办理中</option>
					<option value="1">办理完毕</option>
					<option value="2">退回</option></select>
				</select>
            </td>
        </tr>
       
         <tr>
           
			<td colspan="6" class="SearchBar_toolbar">
				

				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="立即查找" />
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
				<input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/GovDocSendCheckProcess!delBatch.action','id','id,tableId,deleTitle,isDelete',this);" value="批量删除" />
	            <input name="" type="button" value="选中导出" class="btnButton4font" style="display:"  onClick="exportOut(1);"/>
				<input name="" type="button" value="导　出" class="btnButton4font" style="display:"  onClick="exportOut(0);"/>
	        </td>
	    </tr>
	</table>
	
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true,renderer:generateCHBX" >
			<input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>
			<td whir-options="field:'sendFileCheckTitle',width:'40%',renderer:getTitle" >标题</td>
			<td whir-options="field:'sendFileCheckComeUnit',width:'30%'">来文单位</td> 
			<td whir-options="field:'sendFileCheckReceiveDate', width:'10%',renderer:common_DateFormat">来文日期</td> 
			<!--<td whir-options="field:'sendFileCheckFileNumber', width:'20%'">文号</td> -->
			<td whir-options="field:'transactStatus',width:'8%',renderer:getStatus">办理状态</td> 
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


</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		

	});

	function exportOut(flag){
		/*var $form = $('#exportForm');
		if ($form.length > 0) {
			$form.remove();//去除前一次导出时的form
		}*/
	 
		var ids = '';
		if(flag == '1'){
			ids = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'id'});
			if(ids == ''){
				whir_alert('请选择要导出记录！', null);
				return;
			}
		}
	 
		var params = '?selectIds='+ids+'&exportData=1&exportTitle=文件送审签-办理查阅导出';
	 
		commonExportExcel({formId:'queryForm', action:'/defaultroot/GovDocSendCheckProcess!export.action'+params});
	}

	//自定义查看栏内容
	function show(po,i){
	
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendProcess!showfile.action?p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'showUser\'});">'+po.receiveFileTitle+'</a>';
		return html;
	}

	
	//导出
	function exportExcel() {
		queryForm.action="GovDocSendCheckProcess!export.action";
		queryForm.target = "_blank";
		queryForm.submit();
		queryForm.action="GovDocSendCheckProcess!listData.action";
	}

//自定义查看栏内容
	function getTitle(po,i){
		//var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendCheckProcess!showfile.action?p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'21212\'});">'+po.sendFileCheckTitle+'</a>';
		//return html;

		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendCheckProcess!editfile.action?from=blcyview&workStatus=1&p_wf_tableId='+po.tableId+'&p_wf_openType=modifyView&p_wf_recordId='+po.id+'\',width:620,isFull: true,height:290,winName:\'showUser\'});">'+po.sendFileCheckTitle+'</a>';
		return html;
	}
	

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function getStatus(po,i){
		if(po.transactStatus == "0"){
			return "办理中";
		}
		if(po.transactStatus == "1"){
			return "办理完毕";
		}
		if(po.transactStatus == "2"){
			return "退回";
		}
	}

	//强制结束
	function qzjs(recordId,tableId){
		//alert("该功能尚未实现。");
		//if(confirm('确定强制结束吗?')) {
			//document.all.qzjs.src="/defaultroot/work_flow/workflow_qzjs.jsp?workId="+workId+"&recordId="+recordId+"&processId="+processId+"&tableId="+tableId;
			//location.reload();
			//window.location.href
			//document.all.qzjs.src="/defaultroot/govezoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp?recordId="+recordId+"&tableId="+tableId;
			
			//searcher();
		//}

		 ajaxOperate( {
			urlWithData: '/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp?recordId='+recordId+'&tableId='+tableId, // 业务访问的url地址：带数据.
			tip:'强制结束', // 提示.
			isconfirm:true , // 是否需要确认提示.
			formId:'queryForm' , // 待刷新列表的表单id.
			callbackfunction:null // 回调函数.
		});

   


	}

  
	//自定义操作栏内容
	function myOperate(po,i){
		var defendRight = getIsDelete(po,i);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendCheckProcess!editfile.action?from=blcyedit&workStatus=1&isEdit=1&p_wf_tableId='+po.tableId+'&p_wf_openType=modifyView&p_wf_recordId='+po.id+'\',isFull: true,width:620,height:290,winName:\'showUser\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" alt="修改" title="修改" ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'GovDocSendCheckProcess!delBatch.action?deleTitle='+encodeURIComponent(po.sendFileCheckTitle)+'&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" alt="删除"  title="删除"></a>';
		if(po.isSyncToInfomation != "1"){
			html += '<a href="javascript:void(0)" onclick="InfoSynchronization(\''+po.id+'\',\''+po.sendFileCheckFileNumber+'\',\''+po.sendFileCheckTitle+'\',\''+po.field1+'\',\''+po.createdEmp+'\',\'\',\'\');"><img border="0" src="<%=rootPath%>/images/changePwd.gif" alt="同步到信息管理" title="同步到信息管理"></a>';
		}
									 if(po.transactStatus== null){
                                   		
                                     }else if(po.transactStatus==0){
                                        html += '<a href="javascript:void(0)" onclick="qzjs(\''+po.id+'\',\''+po.tableId+'\');"><img border="0" src="<%=rootPath%>/images/cxtj.gif" alt="强制结束"  title="强制结束"></a>';
                                     }else if(po.transactStatus==1){
                                    	 //out.print("&nbsp;");
                                         //out.print("办理完毕");
                                     }else if(po.transactStatus==2){
                                        // out.print("退回");
										 html += '<a href="javascript:void(0)" onclick="qzjs(\''+po.id+'\',\''+po.tableId+'\');"><img border="0" src="<%=rootPath%>/images/cxtj.gif" alt="强制结束"  title="强制结束"></a>';
                                     }else{
                                     	//out.print("&nbsp;");
                                     }
		//html+='<img border="0" src="<%=rootPath%>/images/cxtj.gif" alt="强制结束" ></a>';
		if(defendRight){
			return html;
		}else{
			return "&nbsp;";
		}
	}

	//查询
function InfoSynchronization(id,o1,o2,o3,o4,o5,o6){
	//收文1
	//var srcurl="InformationAction.do?action=otherAdd&channelType=0&_type=4&userDefine=0&_fileId="+id;
	var srcurl="/defaultroot/Information!add.action?isfromgov=1&module=4&action=otherAdd&channelType=0&_type=4&userDefine=0&_fileId="+id+"&_GovSendFileCheckWithWorkFlow_id="+id;


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

	//openWin({url:srcurl,width:620,isFull: true,height:290,winName:'_blank'});
	//postWindowOpen(srcurl,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600');
}


//自定义操作栏内容
	function generateCHBX(po,i){
		var isDelete = getIsDelete(po,i);
		var html = 'tableId="'+ po.tableId + '"' + ' deleTitle="'+encodeURIComponent(po.sendFileCheckTitle) + '"'+' isDelete= "'+isDelete+'"';
		if(!isDelete){
			html = html + '  disabled = "true" '; 			
		}
		//alert(html);
		return html;
	}
//获取是否有权限显示按钮
function getIsDelete(po,i){
	var defendScopeType =("${request.defendScopeType}");
	var defendRight = false;
	if( "${session.userId}" == po.createdEmp){
		//alert(1);
		defendRight = true;
	}else if( "${session.orgId}" == po.documentSendFileWriteOrg){
		//alert(11);
		defendRight = true;
	}else if( po.orgIdString.indexOf("$${session.orgId}$") >=0 ){
		//alert(111+""+ po.orgIdString);
		defendRight = true;
	}else if( "${request.defendOrgRange}".indexOf(",${session.orgId},") >= 0){
		//alert(1111);
		defendRight = true;
	}
	defendRight = false;
	if( defendScopeType == "0"){
		defendRight = true;
	}else if( defendScopeType == "1"){
		if( "${session.userId}" == po.createdEmp){
			//alert(1);
			defendRight = true;
		}
	}else if( defendScopeType == "3"){
		if( po.createdOrg == ${session.orgId}  ){
			//alert(111+""+ po.orgIdString);
			defendRight = true;
		}
	}else if( defendScopeType == "2"){
		if( "${request.defendOrgRange}".indexOf(","+po.createdOrg+",") >= 0 ){
			//alert(1111);
			defendRight = true;
		}
	}else if( defendScopeType == "4"){
		//alert("${request.defendOrgRange}" + "--------" +"${request.userRange}" );
		if( "${request.defendOrgRange}".indexOf(","+po.createdOrg+",") >= 0 ||  "${request.userRange}".indexOf("$"+po.createdEmp+"$") >= 0){
			//alert(1111);
			defendRight = true;
		}
	}
	return defendRight;
}
   </script>

</html>


