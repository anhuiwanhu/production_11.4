<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><s:property  value="#request.htmlTitle" /></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
    <script src="/defaultroot/public/relation/relation.js" language="javascript"></script>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<!-- <body class="MainFrameBox"> -->
<!-- <body class="MainFrameBox" style="overflow-x:hidden;" > -->
<body class="MainFrameBox"  >
	<s:form name="queryForm" id="queryForm" action="${ctx}/wfdealwith!realtionList.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
 
	<s:hidden  name="relation" id="relation" />
	<s:hidden  name="emergence" id="emergence" />
	<s:hidden  name="processID" id="processID" />
	<s:hidden  name="last_processName" id="last_processName" /> 
 
	<s:hidden  name="employeeId" id="employeeId" />  
	<s:hidden  name="from"       id="from" />
	
    <!-- 下面根据不同的方式，显示不同的查询栏-->
    <!--如果==1 则用下面的select-->
 
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar"  >
    <s:hidden  name="openType" id="openType"/>
	<s:hidden name="underUserId"      id="underUserId" />
	<s:hidden name="searchDealPerson" id="searchDealPerson" />
	<s:hidden name="pressDeal"        id="pressDeal" />
	<tr>
		<td class="whir_td_searchtitle" ><s:text name="file.title"/>：</td>
		<td class="whir_td_searchinput" >
		 <s:textfield id="workTitle" name="workTitle" size="16" cssClass="inputText" />
		</td>
		<td class="whir_td_searchtitle" ><s:text name="file.processpromoters"/>：</td>
		<td class="whir_td_searchinput" >
		 <s:textfield id="startUserName" name="startUserName" size="16" cssClass="inputText" />
		</td>
		<td class="whir_td_searchtitle"  id="searchStatus_title_td"   ><s:text name="file.status"/>：</td>
		<td class="whir_td_searchinput"  id="searchStatus_select_td"   >
			 <s:select name="searchStatus" id="searchStatus" list="#{'':'全部','1':'办理中','100':'办理完毕'}" listKey="key"  listValue="value"     cssClass="selectlist" cssStyle="width:200px;"   /> 
		</td>
	</tr>
	<tr>
		<td class="whir_td_searchtitle" ><s:text name="file.subtime"/>：</td>
		<td class="whir_td_searchinput"  colspan="4" nowrap >
		 <s:textfield name="searchBeginDate" id="searchBeginDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'searchEndDate\\',{d:0});}'})" /> <s:text name="file.to"/> 
		 <s:textfield name="searchEndDate" id="searchEndDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'searchBeginDate\\',{d:0});}'})" />
		 <!-- <s:checkbox  name="searchDate"  id="searchDate" ></s:checkbox> -->
		</td>
		 
		<td  class="SearchBar_toolbar" >
			<input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
			<!--resetForm(obj)为公共方法-->
			<input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
		</td>
	</tr>
</table>

 	<!--操作栏-->
	<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">  
		 
	</table>   
 
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	 
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer"  >
        <tr class="listTableHead"> 
			<td whir-options="field:'submitOrg',width:'17%'"><bean:message bundle="filetransact" key="file.suborg"/></td> 
			<td whir-options="field:'workSubmitTime',width:'12%',renderer:common_DateFormatMinite,allowSort:true " nowrap ><s:text name="file.subtime"/>　</td> 
			<td whir-options="field:'_workTitle',width:'32%',renderer:showOpen"><s:text name="file.title"/></td> 
			<td whir-options="field:'_curDisActivityName',width:'10%'"><bean:message bundle="filetransact" key="file.dostatus"/></td> 
			<td whir-options="field:'_curDisEmpName',width:'8%'"><bean:message bundle="filetransact" key="file.people"/></td>  
			<td whir-options="field:'workDoneWithDate',width:'12%',renderer:common_DateFormatMinite " nowrap><bean:message bundle="filetransact" key="file.donedate"/>　　<!--办结时间--></td>  
		    <td whir-options="field:'',width:'8%',renderer:showMyOperate"><bean:message bundle="common" key="comm.opr" /></td>
        </tr>
		</thead>
		<tbody  id="itemContainer" > 
		</tbody>
    </table>
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
    var api =null;
	var W=null;
	//关联流程是弹出页
	if($("#relation").val()=="1"&&$("#relationProjectlist").val()!="1"){
	     api=frameElement.api, W = api.opener; 
		 //防止刷新后 再次调用max() 变最小化了
		 if(api._maxState){
		 }else{
	       // api.max();
		 }
	}

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm"});		
	});
 
	/**
	显示缓急
	*/
	function showhuanji(po,i){
		var huanji_str="";
		if(po._huanji_str=="4"){
			huanji_str="<label style='color:red'><s:text name='file.sort1'/></label>";//"特提";
		}else if(po._huanji_str=="3"){
			huanji_str="<label style='color:brown'><s:text name='file.sort2'/></label>";//"特急";
		}else if(po._huanji_str=="2"){
			huanji_str="<label style='color:Fuchsia'><s:text name='file.sort4'/></label>";//"急件";
		}else if(po._huanji_str=="1"){
			huanji_str="<label style='color:#ffcc00'><s:text name='file.sort3'/></label>";//"加急";
		}else if(po._huanji_str=="0"){
			huanji_str="<s:text name='file.sort5'/>";//一般
		}else{
			huanji_str="<s:text name='file.sort5'/>";//一般
		}
		return huanji_str;
	}

    /**
    	打开流程
	*/
	function  showOpen(po,i){
		 var _workTitle =po._workTitle;
		 _workTitle =_workTitle.replace(/</gm,'&lt;').replace(/>/gm,'&gt;');
         var html =  '<a href="javascript:void(0)" onclick="openWorkFlow(\''+po.workMainLinkFile+'\',\''+po.wfWorkId+'\',\''+po.workRecordId+'\',\''+po.isezFlow+'\',\''+po.ezFlowTaskId+'\',\''+po.ezFlowProcessInstanceId+'\',\''+po.wfWorkId_verifyCode+'\',\''+po.ezFlowTaskId_verifyCode+'\',\''+po.ezFlowProcessInstanceId_verifyCode+'\',\'\');">'+_workTitle+'</a>';
		 return html;   
	}
    

	//自定义操作栏内容
	function showMyOperate(po,i){
		var html="";
		var openType_v=$("#openType").val();
		var relation_v=$("#relation").val();
		var _workTitle =po._workTitle.replace(/\"/g, "\\\"");
		var ff='{moduleId:"'+po.moduleId+'",submitOrg:"'+po.submitOrg+'",workSubmitTime:"'+po.workSubmitTime+'",_workTitle:"'+_workTitle+'",_curDisActivityName:"'+po._curDisActivityName+'",_curDisEmpName:"'+po._curDisEmpName+'",workProcessId:"'+po.workProcessId+'",wfWorkId:"'+po.wfWorkId+'",workTableId:"'+po.workTableId+'",workRecordId:"'+po.workRecordId+'",workMainLinkFile:"'+po.workMainLinkFile+'",isezFlow:"'+po.isezFlow+'",ezFlowTaskId:"'+po.ezFlowTaskId+'",ezFlowProcessInstanceId:"'+po.ezFlowProcessInstanceId+'",wfWorkId_verifyCode:"'+po.wfWorkId_verifyCode+'",ezFlowTaskId_verifyCode:"'+po.ezFlowTaskId_verifyCode+'",ezFlowProcessInstanceId_verifyCode:"'+po.ezFlowProcessInstanceId_verifyCode+'"}';
		var html =  '<a href="javascript:void(0)" onclick=\'setRelation('+ff+');\'><img border="0" src="<%=rootPath%>/images/createlink.gif" title="<bean:message bundle="workflow" key="workflow.choosethis" />" ></a>';
		
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

	  
    //打开流程
	function  openWorkFlow(url,workId, recordId,isezFlow,ezFlowTaskId,ezFlowProcessInstanceId,  wfWorkId_verifyCode,ezFlowTaskId_verifyCode,ezFlowProcessInstanceId_verifyCode,moduleId){
	    var openType=$("#openType").val();  
		var openurl=url;
		var purl="wfWorkId="+workId+"&p_wf_recordId="+recordId+"&p_wf_openType=mailView&verifyCode="+wfWorkId_verifyCode;
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
		    openurl=url+"?ezFlowProcessInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType=mailView&p_wf_pool_processType=1&p_wf_recordId="+recordId; 
		} 
		openurl=openurl+"&from=workflow"; 
		openWin({url:openurl,isFull:true,width:850,height:750,winName:'openWorkFlow'+workId}); 
	} 
	
    /**
	  相关性的 相关流程设置
	*/
    function setRelation_(obj){
         var work=obj.wfWorkId;
		 var name=obj._workTitle;
		 var relationModule=$("#relationModule").val();
		 var relationIFrame=$("#relationIFrame").val();
 
         
		 //打开地址
         var openurl="";
		 if(obj.isezFlow=="1"){
             openurl="ezflowopen!updateProcess.action?p_wf_processInstanceId="+obj.ezFlowProcessInstanceId+
				 "&verifyCode="+obj.ezFlowProcessInstanceId_verifyCode+"&p_wf_openType=relation";  
		 }else{
			 openurl=obj.workMainLinkFile;
			 var purl="wfWorkId="+obj.wfWorkId+"&p_wf_recordId="+obj.workRecordId+"&p_wf_openType=relation&verifyCode="+obj.wfWorkId_verifyCode;
			 if(openurl.indexOf("?")>=0){
				 openurl=openurl+"&"+purl;
			 }else{
				 openurl=openurl+"?"+purl;
			 }
		 }

		 if(openurl.indexOf('<%=rootPath%>')==0){ 
              openurl=openurl.replace("<%=rootPath%>","");
			  openurl=openurl.substring(1);
          }  
	     setRelationInfo(work,name,openurl+"&comm_relation=1",relationModule,relationIFrame); 
	}



    /**
	 设置相关流程
	*/
	function setRelation(obj){ 
		var haverepeat=false;
		//新增时的关联
		if('<%=request.getParameter("rrecordId")%>'=='-1'||'<%=request.getParameter("rrecordId")%>'==''){
			$('input[name="relationIdStr"]',parent.document.body).each(function(){ 
				 if($(this).val()==(obj.moduleId+','+obj.workRecordId)){
					 haverepeat=true;
				 }
	　　　  }) 
			if(haverepeat){
			    whir_alert('<%=Resource.getValue(local,"workflow","workflow.tworelation")%>',function(){},api);
			    return false;
			} 
			//新建时关联
			var table1 = $('#relationTable',W.document); 
			var row = $('<tr id="TR"'+obj.wfWorkId+'></tr>'); 
			var td0 = $('<td class="subTitleList" >'+obj.submitOrg+'</td>'); 
			var td1 = $('<td class="subTitleList">'+obj.workSubmitTime+'</td>'); 

 
			var td2 = $('<td class="subTitleList"><a href="javascript:void(0)" onclick="openWorkFlow_relation(\''+obj.workMainLinkFile+'\',\''+obj.wfWorkId+'\',\''+obj.workRecordId+'\',\''+obj.isezFlow+'\',\''+obj.ezFlowTaskId+'\',\''+obj.ezFlowProcessInstanceId+'\',\''+obj.wfWorkId_verifyCode+'\',\''+obj.ezFlowProcessInstanceId_verifyCode+'\');">'+obj._workTitle+'</a></td>'); 

 
			var td3 = $('<td class="subTitleList">'+obj._curDisActivityName+'&nbsp;</td>'); 
			var td4 = $('<td class="subTitleList">'+obj._curDisEmpName+'</td>'); 
		  
			var td5 = $('<td class="subTitleList"><input type="hidden" name="relationIdStr" value="'+obj.moduleId+','+obj.workRecordId+'"><img src="<%=rootPath%>/images/del.gif" onclick="delRelationProcess_add(this);" style="cursor:hand" title="<s:text name="comm.sdel"/>"></td>'); 
 
			row.append(td0); 
			row.append(td1); 
			row.append(td2); 
			row.append(td3); 
			row.append(td4); 
			row.append(td5); 
			table1.append($('<div></div>').append(row.clone()).html());  
			//table1.append(row); 
			whir_alert("<%=Resource.getValue(local,"workflow","workflow.RelatedSuccess")%>！",function(){},api);
		} else{
			 
			if('<%=request.getParameter("rmoduleId")%>,<%=request.getParameter("rrecordId")%>'==(obj.moduleId+','+obj.workRecordId)){
			   whir_alert('<%=Resource.getValue(local,"workflow","workflow.cannotrelationself")%>',function(){},api);
			   return ;
			}
			
            $('input[name="relation_moduelId_record"]',W.document).each(function(){ 
				 if($(this).val()==(obj.moduleId+','+obj.workRecordId)){
					 haverepeat=true;
				 }
	　　　   })
 	 
			if(haverepeat){
				whir_alert('<%=Resource.getValue(local,"workflow","workflow.tworelation")%>',function(){},api);
			    return false;
			}
 

			var url="<%=rootPath%>/wfoperate!addBpmRelationWork.action?p_wf_moduelId="+obj.moduleId+"&p_wf_recordId="+obj.workRecordId+"&rmoduleId=<%=request.getParameter("rmoduleId")%>&rrecordId=<%=request.getParameter("rrecordId")%>"; 

		    var html = $.ajax({url: url,async: false}).responseText;  
			whir_alert("<%=Resource.getValue(local,"workflow","workflow.RelatedSuccess")%>！",function(){},api);
			parent.refreshRelation(); 
 
		}
		
	}

 
 
	//自定义查看栏内容
	function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/wfprocess!viewButton.action?buttonId='+po.buttonId+'&moduleId='+$("#moduleId").val()+'\',width:620,height:310,winName:\'showUser\'});">'+po.packageName+'</a>';
		return html;
	}

	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
 
   </script>
</html>

