<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	whir_custom_str="easyui,powerFloat ";
	String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
	String userId = session.getAttribute("userId").toString();
	String userName = session.getAttribute("userName").toString();
	//人事模块参数
	String isViewWorkFlow = request.getParameter("isViewWorkFlow")==null?"":request.getParameter("isViewWorkFlow");
    String sortType = request.getParameter("sortType")==null?"":request.getParameter("sortType");
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
	<s:form name="queryForm" id="queryForm" action="/wfdealwith!list.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <s:hidden  name="noTreatment" id="noTreatment" />
	<s:hidden  name="relation" id="relation" />
	<s:hidden  name="emergence" id="emergence" />
	<s:hidden  name="processID" id="processID" />
	<s:hidden  name="searchPackageIds" id="searchPackageIds" />
	<s:hidden  name="last_processName" id="last_processName" />  
	<s:hidden  name="employeeId" id="employeeId" />  
	<s:hidden  name="from"       id="from" />
	<input type="hidden" name="noTreatmentPre" id="noTreatmentPre" value="0"/>
	<!--人事管理-->
	<input type="hidden" name="isViewWorkFlow" id="isViewWorkFlow" value="<%=isViewWorkFlow%>" />
    <!-- 下面根据不同的方式，显示不同的查询栏-->
    <!--如果==1 则用下面的select-->
	<s:if test="relation!=1">
        <s:hidden  name="openType" id="openType"/>
	    <s:if test="openType=='waitingDeal'">
           <%@ include file="wf_filedealwith_searchDeal.jsp"%>
	    </s:if>
	    <s:if test="openType=='dealed'">
		   <%@ include file="wf_filedealwith_searchDealed.jsp"%>
	    </s:if>
	    <s:if test="openType=='waitingRead'||openType=='readed'">
		   <%@ include file="wf_filedealwith_searchRead.jsp"%>
	    </s:if>
	    <s:if test="openType=='myTask'">
		   <%@ include file="wf_filedealwith_searchMyTask.jsp"%>
	    </s:if>
	    <s:if test="openType=='myUnderWaitingDeal'">
		   <%@ include file="wf_filedealwith_searchUnderDeal.jsp"%>
	    </s:if>
	    <s:if test="openType=='tran'">
		   <%@ include file="wf_filedealwith_searchTran.jsp"%>
	   </s:if>
	</s:if>
	<s:else>
		<%@ include file="wf_filedealwith_searchRelation.jsp"%>
		<s:hidden name="relationProjectlist" id="relationProjectlist" />
		<s:hidden name="infoId" id="infoId" />
		<s:hidden name="type" id="type" />
		<s:hidden name="moduleType" id="moduleType" />
		<!-- <s:hidden name="workStatus" id="workStatus" /> -->
		<s:hidden name="relationtype" id="relationtype" />
		<!-- <s:hidden name="rprocessId" id="rprocessId" /> -->
		<s:hidden name="rtableId" id="rtableId" />
		<s:hidden name="rrecordId" id="rrecordId" />
		<s:hidden name="rprocessId" id="rprocessId" />
		<s:hidden name="relationIFrame" id="relationIFrame" />
		<s:hidden name="relationModule" id="relationModule" /> 
	</s:else>

 	<!--操作栏-->
	<table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">  
		<tr>  
			<td align="left">  
				<div class="Public_tag">
				   <s:if test="relation!=1">
						<ul>  
							<li class="tag_aon"  id="Panle0"  onclick="changePanle(0)"><span class="tag_center"><bean:message bundle="filetransact" key="file.list"/></span><span class="tag_right"></span>  
							</li>  
							<li id="Panle1" onclick="changePanle(1)"><span class="tag_center"><bean:message bundle="filetransact" key="file.sorttype"/></span><span class="tag_right"></span>  
							</li>
							<s:if test="openType=='waitingDeal'||openType=='myUnderWaitingDeal'">
							  <li id="Panle2" onclick="changePanle(2)"><span class="tag_center"><bean:message bundle="filetransact" key="file.sorturgency"/></span><span class="tag_right"></span></li>  	  
							</s:if> 
							<s:if test="openType=='waitingDeal'">
							  <li id="Panle3" onclick="changePanle(3)"><span class="tag_center"><s:text name="workflow.noprocessing"/><font color='red' id="noTreatmentNum">(0)</font></span><span class="tag_right"></span></li>  	  
							</s:if> 
						 </ul> 
					</s:if>
				</div>  
			</td>  
			<s:if test="openType!='tran'&&relation!=1">
			<td align="right" width="380" nowrap >  
			</s:if>
			<s:else>
			<td align="right" >
			</s:else>
			   <%
			   /**
			   表明不是来之HR之类 
			   */ 
			   %>
			   <s:if test="from=='workflow'">
				<s:if test="relation==1">
				     <s:select name="openType" id="openType" list="#{'waitingDeal':getText('file.underdo'),'waitingRead':getText('file.underview'),'dealed':getText('file.handledtask'),'readed':getText('file.viewed'),'myTask':getText('file.mydocument')}" listKey="key"  listValue="value"  cssClass="selectlist" cssStyle="width:200px;" onchange="openTypeChange()" >
					 </s:select>
				</s:if>
				<s:else>
				    <s:if test="openType=='waitingDeal'">
				    	<input name="" type="button" value='<s:text name="workflow.noprocessing"/>' class="btnButton4font"  id="noTreatmentButton" onClick="batchNoTreatment(this);" />
						<input name="" type="button" value='<s:text name="comm.recover"/>' class="btnButton4font"  style="display:none" id="resetNoTreatmentButton" onClick="batchResetNoTreatment(this);" />
				        <input name="" type="button" value='<s:text name="file.bulkhandling"/>' class="btnButton4font" id="batchDealFun" onClick="batchDeal_fun();" />  
					</s:if>
					<s:if test="openType=='waitingRead'">
						<input name="" type="button" value='<s:text name="file.bulkhandling"/>' class="btnButton4font" id="batchViewFun" onClick="batchView_fun();" />  
					</s:if> 
					<s:if test="openType=='tran'||openType=='waitingDeal' ">
						<input name="" type="button" value='<s:text name="file.bulktransend"/>' class="btnButton4font" id="batchTranFun" onClick="batchTran_fun();" />  
					</s:if> 		
					<s:if test="openType=='myTask'||openType=='dealed'||openType=='readed'">
						<input name="" type="button" value='<s:text name="comm.delselect"/>' class="btnButton4font" id="batchDeleteId" onClick="batchDelete(this);" />  
					</s:if> 
				</s:else>
			   </s:if>
			</td>  
		</tr>  
	</table>   
 
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
	<div  id="docinfo0"  >
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer"  >
        <tr class="listTableHead">
		    <s:if test="openType!='myUnderWaitingDeal'&&relation!=1&&from=='workflow'">
				<td whir-options="field:'wfWorkId',width:'2%',checkbox:true,renderer:showBatchDeal" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('wfWorkId',this.checked);" ></td>
			</s:if>
			<s:if test="(openType=='waitingDeal'&&relation!=1)||openType=='tran'">
				<td whir-options="field:'_huanji_str',width:'5%',renderer:showhuanji"><bean:message bundle="filetransact" key="file.urgency"/></td> 
			</s:if>
			<td whir-options="field:'submitOrg',width:'17%',allowSort:true"><bean:message bundle="filetransact" key="file.suborg"/></td> 
			<td whir-options="field:'workSubmitTime',width:'12%',renderer:common_DateFormatMinite,allowSort:true " nowrap >　　<s:text name="file.subtime"/>　</td> 
			<td whir-options="field:'_workTitle',width:'32%',renderer:showOpen"><s:text name="file.title"/></td> 
			<td whir-options="field:'_curDisActivityName',width:'10%'"><bean:message bundle="filetransact" key="file.dostatus"/></td> 
			<td whir-options="field:'_curDisEmpName',width:'8%'"><bean:message bundle="filetransact" key="file.people"/></td> 
			<s:if test="openType=='waitingDeal'||openType=='tran'">
				<td whir-options="field:'_banliqixian',width:'12%' " nowrap ><bean:message bundle="filetransact" key="file.doschedule"/></td> 
			</s:if> 
			<s:if test="openType=='myTask'||openType=='myTask'||openType=='dealed'">
				<td whir-options="field:'workDoneWithDate',width:'12%',renderer:common_DateFormatMinite " nowrap><s:text name="workflowAnalysis.TransactedTime"/><!--<bean:message bundle="filetransact" key="file.donedate"/>　　 --><!--办结时间--></td> 
			</s:if> 
            <s:if test="relation==1&&relationtype!='view'">
				<td whir-options="field:'',width:'8%',renderer:showMyOperate"><bean:message bundle="common" key="comm.opr" /></td>
			</s:if>
			<s:else>
				<s:if test="(openType=='myTask'||openType=='dealed'||openType=='readed')&&from=='workflow'">
					<td whir-options="field:'',width:'8%',renderer:showDeleteOperate"><bean:message bundle="common" key="comm.opr" /></td>
				</s:if>
		    </s:else>
			<s:if test="openType=='waitingDeal'&&relation!=1">
				<td whir-options="field:'attention',width:'5%',allowSort:true,renderer:showAttention" nowrap><s:text name="workflow.focuson"/></td> 
			</s:if>
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
	</div>
	<div id="docinfo1"  style="display:none;border:1px solid #b7b7b7"></div>
	<div id="docinfo2"  style="display:none"></div>
    <div id="docinfo3"  style="display:none"></div>
    <!-- PAGER END -->
	</s:form> 
</body>
<script type="text/javascript">  
	<%
	if(sortType.equals("sortType")){
	%>
	changePanle("1");
	<%}%>
    /**
	切换页签 0：列表 1：按类型 2：按缓急 3：暂不处理
	*/
    function  changePanle(flag){
		 var openType=$("#openType").val();

		 $(".tag_aon").removeClass("tag_aon");
		 $("#Panle"+flag).addClass("tag_aon");
		 $("div[id^='docinfo']").hide();

		 //0：列表 1：按类型 2：按缓急 3：暂不处理 
		 //noTreatmentButton:暂不处理 batchDeal_fun:批量办理 batchTran_fun:批量转交 
		 //resetNoTreatmentButton:恢复 batchView_fun 

		 if(flag=='3'){
			 $("#docinfo0").show();
			 if($("#noTreatmentPre").val()=='0'){
				 $("#noTreatment").val('1');
				 $("#noTreatmentPre").val('1');
                 refreshListForm('queryForm');
			 }
			 $("#noTreatmentButton").hide();
			 $("#resetNoTreatmentButton").show();

			 $('#batchDealFun').show();
			 $('#batchTranFun').show();
			 $('#batchViewFun').show();
			 $('#batchDeleteId').show();
		 }else{
			 $("#noTreatmentButton").show();
			 $("#resetNoTreatmentButton").hide();
			 
			 $("#noTreatment").val('0');
		     
			 if(flag=="0" && $("#noTreatmentPre").val()=='1'){
				 $("#noTreatmentPre").val('0');
                 refreshListForm('queryForm');
			 }
			 
		     $("#docinfo"+flag).show();

			 $('#batchDealFun').show();
			 $('#batchTranFun').show();
			 $('#batchViewFun').show();
			 $('#batchDeleteId').show();
		 }
		 if(flag=='1'||flag=='2'){
		     $('#noTreatmentButton').hide();
			 $('#resetNoTreatmentButton').hide();
			 $('#batchDealFun').hide();
			 $('#batchTranFun').hide();
			 $('#batchViewFun').hide();
			 $('#batchDeleteId').hide();

			 if(false){

		     }else{
				  var url1="/defaultroot/wfdealwith!pagelist2.action?";
				  var url2="/defaultroot/wfdealwith!pagelist3.action?"; 
				  var paraStr="openType="+$("#openType").val();
					  paraStr+="&workTitle="+$("#workTitle").val();
					  paraStr+="&startUserName="+$("#startUserName").val();				  
					  paraStr+="&searchBeginDate="+$("#searchBeginDate").val();
					  paraStr+="&searchEndDate="+$("#searchEndDate").val();
					  paraStr+="&searchDate=false";
					  //paraStr+="&searchStatus="+$("#searchStatus").val();
					  paraStr+="&searchDealPerson="+$("#searchDealPerson").val();
					  
				  if($("#submitOrg").length>0){
					  paraStr+="&submitOrg="+$("#submitOrg").val(); 
				  } 
				  if(openType=="waitingDeal"||openType=="myUnderWaitingDeal"){
				       paraStr+="&pressDeal="+$('#pressDeal').val();//.combobox('getValue'); //  +$("#pressDeal").val();	
				  }
				  if(openType=="waitingDeal"){
				       paraStr+="&search_attention="+$('#search_attention').val();//.combobox('getValue'); //  +$("#pressDeal").val();	
				  }
				  if(openType=="myUnderWaitingDeal"){
				       paraStr+="&underUserId="+$('#underUserId').val();//.combobox('getValue'); // $("#underUserId").val();
				  }
				  if(openType=="myTask"){
				       paraStr+="&workDoneWithDateBegin="+$("#workDoneWithDateBegin").val();
					   paraStr+="&workDoneWithDateEnd="+$("#workDoneWithDateEnd").val();  
					   paraStr+="&searchStatus="+$('#searchStatus').val();//.combobox('getValue'); //  +$("#pressDeal").val();	 
				  }
				  if(openType=="dealed"){      
					   paraStr+="&searchStatus="+$('#searchStatus').val();//.combobox('getValue'); //  +$("#pressDeal").val();	 
				  }
				  if(openType=="tran"){
					   paraStr+="&pressDeal="+$('#pressDeal').val();
				  }
 
				  var url="";
				  if(flag=="1"){
					  url=url1+paraStr;
					  var from =$('#from').val();
					  if(from =='hrm'){
						var employeeId =$('#employeeId').val();
						url += "&employeeId="+employeeId;
					  }
				  }else{
					  url=url2+paraStr;
				  }		 
				  url=encodeURI(url);
				  var html = $.ajax({url: url,async: false}).responseText; 
				  $("#docinfo"+flag).html(html)
			  }
		 }
   }
	
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
		initListFormToAjax({formId:"queryForm",onLoadSuccessAfter:showNoTreatmentNum});		
	});

	function showNoTreatmentNum(po){ 
		$("#noTreatmentNum").html("("+po.noTreatmentNum+")"); 
	    for(var i=0;i<4;i++){ 
		    if($("#Panle"+i).length>0){
		       //$("#Panle"+flag).addClass("tag_aon");
			   if($("#Panle"+i).hasClass("tag_aon")){
			      changePanle(i);
			   }  
		   }  
		}  
	}

    /**
	  展现批量选择复选框
	*/
	function  showBatchDeal(po,i){
		 var html =' wfWorkId="'+po.wfWorkId+'"  isezFlow="'+po.isezFlow+'"  workProcessId="'+  po.workProcessId+
			       '"  workTableId="'+po.workTableId+'"  workRecordId="'+po.workRecordId+'"  ezFlowTaskId="'+po.ezFlowTaskId+'" ezFlowProcessInstanceId="'+po.ezFlowProcessInstanceId+'" ezFlowTaskId_verifyCode="'+po.ezFlowTaskId_verifyCode+'"  ezFlowProcessInstanceId_verifyCode="'+po.ezFlowProcessInstanceId_verifyCode+'" wfWorkId_verifyCode="'+po.wfWorkId_verifyCode+'"  workMainLinkFile="'+po.workMainLinkFile+'"'; 
		 var openType=$("#openType").val();
		 if(openType=="myTask"){
			 //	
			 if(po._workStatus=="100"||po._workStatus=="-1"||po._workStatus=="-2"){
			 }else{	
				 //html+=' style="display:none"  disabled=true ';
				 html+='    disabled=true ';
			 }		 
		 }

		 if(openType=="dealed"){
			 //已办 的只有办结的才删除     100  办理完毕	
			 if(po._workStatus=="1012"){
			 }else{	
				 //html+=' style="display:none"  disabled=true ';   td测试要求去掉
				 html+='  disabled=true ';
			 }		 
		 }
		 return html;
	}

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
 

	/**显示关注**/
	function showAttention(po,i){ 
		var hl='<a href="javascript:void(0)"  onclick="ajaxOperate({urlWithData:\'<%=rootPath%>/wfdealwith!setAttention.action?wfWorkId='+po.wfWorkId+'\',tip:\'<s:text name="workflow.setthefocus"/>\',isconfirm:true,formId:\'queryForm\',callbackfunction:null});" ><img border="0" src="<%=rootPath%>/images/cancelgz.png" title="<s:text name="workflow.setthefocus"/>" ></a>'
		if(po.attention=="1"){
			hl='<a href="javascript:void(0)"   onclick="ajaxOperate({urlWithData:\'<%=rootPath%>/wfdealwith!cancelAttention.action?wfWorkId='+po.wfWorkId+'\',tip:\'<s:text name="workflow.canceltheattention"/>\',isconfirm:true,formId:\'queryForm\',callbackfunction:null});"   ><img border="0" src="<%=rootPath%>/images/setgz.png" title="<s:text name="workflow.canceltheattention"/>" ></a>'
		}  
		return hl;
	}
 
    /**打开流程	 
	function  showOpen(po,i){
		 var redStyle='';		 
		 if(po._overDate=="true"){
			redStyle=' style="color:red"';
		 }
         var html =  '<a '+redStyle+' href="javascript:void(0)" onclick="openWorkFlow(\''+po.workMainLinkFile+'\',\''+po.wfWorkId+'\',\''+po.workRecordId+'\',\''+po.isezFlow+'\',\''+po.ezFlowTaskId+'\',\''+po.ezFlowProcessInstanceId+'\',\''+po.wfWorkId_verifyCode+'\',\''+po.ezFlowTaskId_verifyCode+'\',\''+po.ezFlowProcessInstanceId_verifyCode+'\',\'\');">'+po._workTitle+'</a>';
		 return html;   
	}
	*/

	/**打开流程  update by tianml 2015/11/7 添加控制查看权限 **/
	function  showOpen(po,i){
	     var isViewWorkFlow='<%=isViewWorkFlow%>';	  	    
		 var redStyle='';		 
		 if(po._overDate=="true"){
			redStyle=' style="color:red"';
		 }
		 var html="";
		 var _workTitle =po._workTitle;
		 
		 _workTitle =_workTitle.replace(/<\/br>/ig, "\n").replace(/<br\/>/ig, "\n").replace(/<br \/>/ig, "\n").replace(/<br>/ig, "\n");
		 _workTitle =_workTitle.replace(/</gm,'&lt;').replace(/>/gm,'&gt;');
		 _workTitle =_workTitle.replace(/\n/g, "<br />");
         if("no"==isViewWorkFlow){        
           html =  '<a '+redStyle+' href="javascript:void(0)" onclick="noRightAlert()">'+_workTitle+'</a>';
         }else{
           html =  '<a '+redStyle+' href="javascript:void(0)" onclick="openWorkFlow(\''+po.workMainLinkFile+'\',\''+po.wfWorkId+'\',\''+po.workRecordId+'\',\''+po.isezFlow+'\',\''+po.ezFlowTaskId+'\',\''+po.ezFlowProcessInstanceId+'\',\''+po.wfWorkId_verifyCode+'\',\''+po.ezFlowTaskId_verifyCode+'\',\''+po.ezFlowProcessInstanceId_verifyCode+'\',\'\');">'+_workTitle+'</a>';		 
         }
        return html;    
	}

	function noRightAlert(){ 
		 whir_alert("无权限查看！");
	}

	//自定义操作栏内容
	function showMyOperate(po,i){
		var html="";
		var openType_v=$("#openType").val();
		var relation_v=$("#relation").val();
		if(relation_v=="1"){
			var ff='{submitOrg:"'+po.submitOrg+'",workSubmitTime:"'+po.workSubmitTime+'",_workTitle:"'+po._workTitle+'",_curDisActivityName:"'+po._curDisActivityName+'",_curDisEmpName:"'+po._curDisEmpName+'",workProcessId:"'+po.workProcessId+'",wfWorkId:"'+po.wfWorkId+'",workTableId:"'+po.workTableId+'",workRecordId:"'+po.workRecordId+'",workMainLinkFile:"'+po.workMainLinkFile+'",isezFlow:"'+po.isezFlow+'",ezFlowTaskId:"'+po.ezFlowTaskId+'",ezFlowProcessInstanceId:"'+po.ezFlowProcessInstanceId+'",wfWorkId_verifyCode:"'+po.wfWorkId_verifyCode+'",ezFlowTaskId_verifyCode:"'+po.ezFlowTaskId_verifyCode+'",ezFlowProcessInstanceId_verifyCode:"'+po.ezFlowProcessInstanceId_verifyCode+'"}';
		   	var html =  '<a href="javascript:void(0)" onclick=\'setRelation('+ff+');\'><img border="0" src="<%=rootPath%>/images/createlink.gif" title="<bean:message bundle="workflow" key="workflow.choosethis" />" ></a>';
            //相关性  的关联流程   relationtype=modi  需要   relationtype=view 不需要
			if($("#relationProjectlist").val()=="1"&&$("#relationtype").val()=="view"){
				html="";
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
               //// workId*tableId*processId*recordId*activityId*isEzFlow*ezFlowTaskId*ezFlowProcessInstanceId
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
               //// workId*tableId*processId*recordId*activityId*isEzFlow*ezFlowTaskId*ezFlowProcessInstanceId
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

 

    //打开流程
	function  openWorkFlow(url,workId, recordId,isezFlow,ezFlowTaskId,ezFlowProcessInstanceId,  wfWorkId_verifyCode,ezFlowTaskId_verifyCode,ezFlowProcessInstanceId_verifyCode,batchWorkIds){
	    var openType=$("#openType").val();
		var from =$('#from').val();
		var employeeId =$('#employeeId').val();

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

				//2015-12-28 处理人事管理：领导查看下属待办文件、发起文件、已办文件
				if(employeeId !=null && employeeId !=''){
					openurl += "&employeeId="+employeeId;
				}
			}
			//openurl =openurl+"&from=workflow";
			openurl =openurl+"&from="+from;
			
			var isViewWorkFlow='<%=isViewWorkFlow%>';
			if(isViewWorkFlow !=null && isViewWorkFlow !='null' && isViewWorkFlow !=''){
				openurl =openurl+"&isViewWorkFlow="+isViewWorkFlow;
			}
			//alert("openurl:"+openurl);

			openWin({url:openurl,isFull:true,width:850,height:750,winName:'openWorkFlow'+workId});
		}
	}



	 //再次发起  重新发起
	function  re_openWorkFlow(url,workId, recordId,isezFlow,ezFlowTaskId,ezFlowProcessInstanceId, wfWorkId_verifyCode,ezFlowTaskId_verifyCode,ezFlowProcessInstanceId_verifyCode,openType){
 
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
     
    /**
	  相关性的 相关流程设置
	*/
    function setRelation_(obj){
         var work=obj.wfWorkId;
		 var name=obj._workTitle;
		 var relationModule=$("#relationModule").val();
		 var relationIFrame=$("#relationIFrame").val();

		 //ff='{submitOrg:"'+po.submitOrg+'",workSubmitTime:"'+po.workSubmitTime+'",_workTitle:"'+po._workTitle+'",_curDisActivityName:"'+po._curDisActivityName+'",_curDisEmpName:"'+po._curDisEmpName+'",workProcessId:"'+po.workProcessId+'",wfWorkId:"'+po.wfWorkId+'",workTableId:"'+po.workTableId+'",workRecordId:"'+po.workRecordId+'",workMainLinkFile:"'+po.workMainLinkFile+'",isezFlow:"'+po.isezFlow+'",ezFlowTaskId:"'+po.ezFlowTaskId+'",ezFlowProcessInstanceId:"'+po.ezFlowProcessInstanceId+'",wfWorkId_verifyCode:"'+po.wfWorkId_verifyCode+'",ezFlowTaskId_verifyCode:"'+po.ezFlowTaskId_verifyCode+'",ezFlowProcessInstanceId_verifyCode:"'+po.ezFlowProcessInstanceId_verifyCode+'"}';
         
		 //打开地址
         var openurl="";
		 if(obj.isezFlow=="1"){
             openurl="ezflowopen!updateProcess.action?p_wf_processInstanceId="+obj.ezFlowProcessInstanceId+"&ezFlowProcessInstanceId="+obj.ezFlowProcessInstanceId+"&verifyCode="+obj.ezFlowProcessInstanceId_verifyCode+"&p_wf_openType=relation";  
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
		if($("#relationProjectlist").val()=="1"){
		     setRelation_(obj);
			 return;
		}
		var haverepeat=false;
		//新增时的关联
		if('<%=request.getParameter("rprocessId")%>'=='0'||'<%=request.getParameter("rprocessId")%>'==''){
			 $('input[name="relationIdStr"]',parent.document.body).each(function(){ 
				 if($(this).val()==(obj.workProcessId+','+obj.workTableId+','+obj.workRecordId)){
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

 
			var td2 = $('<td class="subTitleList"><a href="javascript:void(0)" onclick="openWorkFlow_relation(\''+obj.workMainLinkFile+'\',\''+obj.wfWorkId+'\',\''+obj.workRecordId+'\',\''+obj.isezFlow+'\',\''+obj.ezFlowTaskId+'\',\''+obj.ezFlowProcessInstanceId+'\',\''+obj.wfWorkId_verifyCode+'\',\''+obj.wfWorkId+'\');">'+obj._workTitle+'</a></td>'); 

 
			var td3 = $('<td class="subTitleList">'+obj._curDisActivityName+'&nbsp;</td>'); 
			var td4 = $('<td class="subTitleList">'+obj._curDisEmpName+'</td>'); 
			var td5 = $('<td class="subTitleList"><input type="hidden" name="relationIdStr" value="'+obj.workProcessId+','+obj.workTableId+','+obj.workRecordId+'"><img src="<%=rootPath%>/images/del.gif" onclick="delRelationWork3(this);" style="cursor:hand" title="<s:text name="comm.sdel"/>"></td>'); 
 
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
			 
			if('<%=request.getParameter("rtableId")%>,<%=request.getParameter("rrecordId")%>'==(obj.workTableId+','+obj.workRecordId)){
			   whir_alert('<%=Resource.getValue(local,"workflow","workflow.cannotrelationself")%>',function(){},api);
			   return ;
			}
			
            $('input[name="relation_table_record"]',W.document).each(function(){ 
				 if($(this).val()==(obj.workTableId+','+obj.workRecordId)){
					 haverepeat=true;
				 }
	　　　   })
 	 
			if(haverepeat){
				whir_alert('<%=Resource.getValue(local,"workflow","workflow.tworelation")%>',function(){},api);
			    return false;
			}


			var url="<%=rootPath%>/wfoperate!addRelationWork.action?p_wf_processId="+obj.workProcessId+"&p_wf_tableId="+obj.workTableId+"&p_wf_recordId="+obj.workRecordId+"&rprocessId=<%=request.getParameter("rprocessId")%>&rtableId=<%=request.getParameter("rtableId")%>&rrecordId=<%=request.getParameter("rrecordId")%>";

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

 
	function add(){
	     var url='<%=rootPath%>/wfprocess!addProcess.action?moduleId='+$("#moduleId").val();
	     openWin({url:url,width:850,height:750,winName:'addProcess'});
	}
     

	/**
	*/
	function  openTypeChange(){
	   //var url="<%=rootPath%>/wfdealwith!dealwithList.action?openType="+$("#openType").val()+"&relation=1";
	   //location_href(url);
	   
			//'waitingDeal':'待办','waitingRead':'待阅','dealed':'已办','readed':'已阅','myTask':'我的文件'
		$("#searchStatus").val("");

		$("#searchStatus").empty(); 
		
        var openType_val=$("#openType").val();
		if(openType_val=="waitingDeal"){
			$("#searchStatus_title_td").hide();
			$("#searchStatus_select_td").hide();
		}
		if(openType_val=="waitingRead"){
			$("#searchStatus_title_td").hide();
			$("#searchStatus_select_td").hide();
		}
		if(openType_val=="dealed"){
			$("#searchStatus_title_td").show();
			$("#searchStatus_select_td").show();

			$("#searchStatus").append("<option value=''><bean:message bundle="filetransact" key="file.total"/></option>");   
			$("#searchStatus").append("<option value='1'><bean:message bundle="workflow" key="workflow.Transacting"/></option>");
			$("#searchStatus").append("<option value='100'><bean:message bundle="workflow" key="workflow.Transacted"/></option>"); 

		}
		if(openType_val=="readed"){
			$("#searchStatus_title_td").hide();
			$("#searchStatus_select_td").hide();
		}
		if(openType_val=="myTask"){
			$("#searchStatus_title_td").show();
			$("#searchStatus_select_td").show();
		    $("#searchStatus").append("<option value=''><bean:message bundle="filetransact" key="file.total"/></option>");   
		    $("#searchStatus").append("<option value='1'><bean:message bundle="workflow" key="workflow.Transacting"/></option>");
		    $("#searchStatus").append("<option value='100'><bean:message bundle="workflow" key="workflow.Transacted"/></option>"); 
		    $("#searchStatus").append("<option value='-1'><bean:message bundle="workflow" key="workflow.Return"/></option>"); 
		    $("#searchStatus").append("<option value='-2'><bean:message bundle="workflow" key="workflow.Cancel"/></option>"); 
		}
	    refreshListForm('queryForm');
	}

   function  batchDelete(obj){
        ajaxBatchDelete('<%=rootPath%>/wfdealwith!deleteWork.action?openType='+$("#openType").val(),'wfWorkId','wfWorkId,ezFlowTaskId,ezFlowProcessInstanceId,isezFlow,workRecordId',obj);
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
		 /*ajaxBatchOperate({url:'<%=rootPath%>/wfdealwith!noTreatmentWork.action?openType='+$("#openType").val(),checkbox_name:"wfWorkId",attr_name:"wfWorkId,ezFlowTaskId,ezFlowProcessInstanceId,isezFlow,workRecordId",tip:"暂不处理",isconfirm:true,formId:"queryForm",callbackfunction:null});*/
   }

   /**
   * 恢复暂不处理
   */
   function  batchResetNoTreatment(obj){
	   ajaxBatchOperate({url:'<%=rootPath%>/wfbuttonevent!reSetnoTreatmentWork.action?openType='+$("#openType").val(),checkbox_name:"wfWorkId",attr_name:"wfWorkId,ezFlowTaskId,ezFlowProcessInstanceId,isezFlow,workRecordId",tip:"<s:text name="comm.recover1"/>",isconfirm:true,formId:"queryForm",callbackfunction:null});
   }
   </script>
</html>