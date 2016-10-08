<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SendFileBD"%>
<%@ page import="com.whir.govezoffice.documentmanager.bd.SenddocumentBD"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>办理查阅</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
 //取 基础信息
String [] secretLevel=null;
String [] keepSecretLevel=null;
String [] transactLevel=null;
String [] contentLevel=null;
String [] openPropertyArr=null;
String [] fileTypeArr=null;

Object [] baseObj=(Object[]) new SenddocumentBD().getSenddocumentBaseInfo();
if(baseObj!=null&&baseObj.length>0){
  if(baseObj[4]!=null&&!baseObj[4].toString().equals("")){
	secretLevel=baseObj[4].toString().split(";");//秘密级别：
	keepSecretLevel=baseObj[3].toString().split(";");//保密期限：
	transactLevel=baseObj[5].toString().split(";"); // 办理紧急：
    contentLevel=baseObj[1].toString().split(";");//内容紧急：
	if(baseObj.length>10&&baseObj[11]!=null&&!baseObj[11].toString().equals("")){
	  openPropertyArr=baseObj[11].toString().split(";");
	}
	
	fileTypeArr=baseObj[2].toString().split(";");// 文件种类
  }
}
 
 %>
<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="GovDocSend!sendFileListData.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	  <input type="hidden" class="btnButton4font"  name="numType" value="<%=request.getParameter("numType")==null?"":request.getParameter("numType")%>"/>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <tr><input type=hidden  name="numId" value="${param.numId}" />
            <td class="whir_td_searchtitle" nowrap>标题：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryTitle" name="queryTitle" size="16" cssClass="inputText"  />
            </td>
           
            <td class="whir_td_searchtitle" nowrap>主题词：</td>
            <td class="whir_td_searchinput">
	             <s:textfield id="documentSendFileTopicWord" name="documentSendFileTopicWord" size="16" cssClass="inputText"  />
            </td>
			<td class="whir_td_searchtitle" nowrap>办理状态：</td>
            <td class="whir_td_searchinput">
               <select id="queryStatus" name="queryStatus" class="easyui-combobox" name="dept" style="width:200px" >  
					 <option value="none" selected>---请选择---</option>
					 <option value="0" <%if("0".equals(request.getParameter("queryStatus"))){%>selected<%}%>>办理中</option>
					 <option value="1"  <%if("1".equals(request.getParameter("queryStatus"))){%>selected<%}%>>办理完毕</option>
					 <option value="2"  <%if("2".equals(request.getParameter("queryStatus"))){%>selected<%}%>>退回</option>
			   </select>
               
            </td>
			<td>
            </td>
        </tr>
        <tr>
            <td class="whir_td_searchtitle" nowrap>文号：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryNumber" name="queryNumber" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle" nowrap>拟稿单位：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="queryOrg" name="queryOrg" size="16" cssClass="inputText"  />
               
            </td>
            <td class="whir_td_searchtitle" nowrap>公开属性：</td>
            <td class="whir_td_searchinput">
	             <select id="queryOpenProperty" name="queryOpenProperty" class="easyui-combobox" name="dept" style="width:200px" >  
					<option value="none" selected>---请选择---</option>
					<%if(openPropertyArr!=null&&openPropertyArr.length>0){
										    for(int i=0;i<openPropertyArr.length;i++){
											 String openPropertyValue=openPropertyArr[i];
											 %>
											  
									    <option value="<%=openPropertyValue%>"<%=openPropertyValue.equals(request.getParameter("queryOpenProperty"))?" selected":""%>><%=openPropertyValue%></option>
					 <%} }%>
				</select>
            </td>
			<td>
            </td>
        </tr>
         <tr>
            <td class="whir_td_searchtitle" nowrap>发文日期：</td>
            <td class="whir_td_searchinput" colspan="4">
            

        		<!--<input type="checkbox" name="queryItem" id="goodDay0" value="1"/>-->

				<input name="queryBeginDate"  id="empBirth"   class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'empBirth2\');}'})" /> 至   
				 <input name="queryEndDate" id="empBirth2"  class="Wdate whir_datebox"   onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'empBirth\');}'})" />  
	        </td>
            <td colspan="1" class="SearchBar_toolbar">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="立即查找" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="清　除" onclick="resetForm(this);" />
            </td>
            <td></td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td class="SearchBar_toolbar">
				<!--<input type="button" class="btnButton4font" onclick="ajaxDelete(\'GovDocSend!delSend.action?deleTitle='+encodeURIComponent(po.documentSendFileTitle)+'&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\'" value="批量删除" />-->

				<input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/GovDocSend!delSend.action','id','id,tableId,deleTitle,isDelete',this);" value="批量删除" />

				<input name="" type="button" value="打包下载" class="btnButton4font" style="display:"  
				onclick="downloadAll()" />
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
			<td whir-options="field:'id',width:'2%',checkbox:true,renderer:generateCHBX" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>
			<!--	<td whir-options="field:'id',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>-->
			<td whir-options="field:'documentSendFileByteNumber',width:'20%'">文号</td> 
			<td whir-options="field:'documentSendFileTitle',width:'30%',renderer:getTitle">标题</td> 
			<td whir-options="field:'documentSendFileWriteOrg', width:'20%'">拟稿单位</td> 
			<td whir-options="field:'transactStatus', width:'10%',renderer:getStatus">办理状态</td> 
			<td whir-options="field:'createdTime', width:'10%',renderer:common_DateFormat">发文日期</td> 
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
	<iframe id="dwin" name="dwin" style="display:none"></iframe>

</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		
	});
	

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

	function downloadLink(po,i){
		return "<a href='alert(\""+po.gridId+"\")' >下载正文</a>";
	}

	//自定义操作栏内容
	function generateCHBX(po,i){
		var isDelete = getIsDelete(po,i);
		var html = 'gridId="' + po.gridId + '" tableId="'+ po.tableId + '"' + ' deleTitle="'+encodeURIComponent(po.documentSendFileTitle) + '"' + ' isDelete= "'+isDelete+'"';
		if(!isDelete){
			html = html + ' disabled = "true" '; 			
		}
		return html;
	}

	//自定义操作栏内容
	function myOperate(po,i){
		var defendRight = getIsDelete(po,i);

		//alert(po.isSyncToInfomation);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendProcess!editfile.action?from=blcyedit&isEdit=1&p_wf_tableId='+po.tableId+'&p_wf_openType=modifyView&p_wf_recordId='+po.id+'\',isFull: true,width:620,height:290,winName:\'showUser\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" title="修改" ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'GovDocSend!delSend.action?deleTitle='+encodeURIComponent(po.documentSendFileTitle)+'&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" ></a>';
		if(po.isSyncToInfomation == "0"){
			html += '<a href="javascript:void(0)" onclick="InfoSynchronization(\''+po.id+'\',\''+po.documentSendFileByteNumber+'\',\''+po.documentSendFileTitle+'\',\''+po.sendFileText+'\',\''+po.sendFileDraft+'\',\''+po.accessoryName+'\',\''+po.accessorySaveName+'\');"><img border="0" src="<%=rootPath%>/images/changePwd.gif" title="同步到信息管理" ></a>';
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

	//获取办理状态
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
	
		return "&nbsp;";
	}

	//获取标题
	function getTitle(po,i){
		var title = po.documentSendFileTitle;
		title = title.replace(">","&gt");
		title = title.replace("<","&lt");
		var xgsw = "";
		if(po.countNum>0){
			xgsw = "<a href=\"#\" onclick= \"javascript:getAssociate("+po.tableId+","+po.id+",'"+po.documentSendFileTitle+"')\"><font color=\"red\">[相关收文]</font></a>";
		}
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocSendProcess!editfile.action?viewOnly=1&from=blcyview&workStatus=1&p_wf_tableId='+po.tableId+'&p_wf_openType=modifyView&p_wf_recordId='+po.id+'\',width:620,isFull: true,height:290,winName:\'showUser\'});">'+title+'</a>'+xgsw;
		return html;
	}
//function moder(editId,editType,tableId,isBack) {
function getAssociate(tableId,sendFileId,filetitle){
	openWin({url:'GovDocSend!sendAssociate.action?winOpen=1&sendFileId=' + sendFileId+'&filetitle='+filetitle,width:720,height:290,winName:'getAssociateWin'});
	//MM_openBrWindow("GovSendFileAction.do?action=sendAssociate&winOpen=1&sendFileId=" + sendFileId+"&filetitle="+filetitle,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=600,height=300') ;
}
//强制结束
function qzjs(recordId,tableId){
    //alert("该功能尚未实现。");
   /* if(confirm('确定强制结束吗?')) {
        //document.all.qzjs.src="/defaultroot/work_flow/workflow_qzjs.jsp?workId="+workId+"&recordId="+recordId+"&processId="+processId+"&tableId="+tableId;
        //location.reload();
		//document.all.qzjs.src	="/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp?module=send&recordId="+recordId+"&tableId="+tableId;
		//window.location.href
		//searcher();
		//alert(recordId + "}}"+tableId);
		$.get("/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp", { module: "send", recordId: recordId,tableId:tableId } ,
		  function(data){
			alert(data);
		  });
		 // alert(1);
    }*/

	
		ajaxOperate({
			urlWithData: '/defaultroot/modules/govoffice/gov_documentmanager/govdocumentmanager_qzjs.jsp?module=send&recordId='+ recordId+'&tableId='+tableId, // 业务访问的url地址：带数据.
			tip:'强制结束', // 提示.
			isconfirm:true , // 是否需要确认提示.
			formId:'queryForm' , // 待刷新列表的表单id.
			callbackfunction:null // 回调函数.
		});

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



//导出
function exportExcel() {
	queryForm.action="GovDocSend!listExcel.action";
	queryForm.target = "_blank";
	queryForm.submit();
	queryForm.action="GovDocSend!sendFileListData.action";
}

function downloadAll(){
	var ids = '';
   // if(flag == '1'){
        ids = getCheckBoxData4J({rangeId:'queryForm', checkbox_name:'id', attr_name:'id'});
        if(ids == ''){
            whir_alert('请选择要导出记录！', null);
            return;
        }
   // }
 //ajaxBatchOperate({url:'<%=rootPath%>/GovDocSend!downloadAll.action?zipName=file.zip',checkbox_name:'id',attr_name:'id,id',tip:'下载',isconfirm:true,formId:'queryForm',callbackfunction:null});
    var params = '?zipName=公文打包.zip&id='+ids+'';
	//打开全部下载链接
    //commonExportExcel({formId:'queryForm', action:'/defaultroot/GovDocSend!listExcel.action'+params});
	openWin({url:'GovDocSend!downloadAll.action' + params,width:620,height:350,winName:'dwin'});
}

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
 
    var params = '?selectIds='+ids+'&exportData=1&exportTitle=发文管理-办理查阅导出';
 
    commonExportExcel({formId:'queryForm', action:'/defaultroot/GovDocSend!listExcel.action'+params});
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
		if( po.createdOrg == ${session.orgId} ){
			//alert(111+""+ po.orgIdString);
			defendRight = true;
		}
	}else if( defendScopeType == "2"){
		if( "${request.defendOrgRange}".indexOf(","+po.createdOrg+",") >= 0){
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


