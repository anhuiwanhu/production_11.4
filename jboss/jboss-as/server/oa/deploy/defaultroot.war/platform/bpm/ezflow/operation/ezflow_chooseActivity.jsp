<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.whir.ezflow.vo.*"%>
<%@page import="com.whir.ezoffice.message.bd.*"%>
<%@page import="com.whir.i18n.Resource"%>
<%@ include file="/public/include/init.jsp"%>
<%
whir_custom_str="easyui,powerFloat ";
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<%
 
    java.util.Random random = new java.util.Random();
	String pageKey = random.nextLong() + "";

	String p_wf_openType=request.getAttribute("p_wf_openType")==null?"":request.getAttribute("p_wf_openType")+"";
 

	//下一办理活动
	List nextActivitys = new ArrayList();
	if (request.getAttribute("nextActivitys") != null) {
		nextActivitys = (List) request.getAttribute("nextActivitys");
	}
	//默认活动id
	String defaultActivity = request.getAttribute("defaultActivity") == null ? "": request.getAttribute("defaultActivity").toString();
	//此次发送的网关类型    XOR XAND   XX
	String gateType = request.getAttribute("gateType") == null ? "": request.getAttribute("gateType").toString();
	//此次发送经过几个网关
	String gateNum = request.getAttribute("gateNum") == null ? "": request.getAttribute("gateNum").toString();
   
	// 解决空岗模式 ， 自动发送到下一步了， 也就是当前的taskId变了。afterInsertTaskIds
	String  afterInsertTaskIds=request.getAttribute("afterInsertTaskIds") == null ? "": request.getAttribute("afterInsertTaskIds").toString();



	//流程实例id
	String processInstanceId=request.getAttribute("p_wf_processInstanceId") == null ? "": request.getAttribute("p_wf_processInstanceId").toString();

	//流程主键id
	String ezflowBusinessKey=request.getAttribute("ezflowBusinessKey") == null ? "": request.getAttribute("ezflowBusinessKey").toString();

	//父流程id
	String superProcessInstanceId=request.getAttribute("p_wf_superProcessInstanceId") == null ? "": request.getAttribute("p_wf_superProcessInstanceId").toString();

	if(p_wf_openType.equals("reStart")||p_wf_openType.equals("startAgain")){
		processInstanceId="";
	}
 

    //是那个action进来的
	String deal_action=""+request.getParameter("action");
    
    String msgFrom=request.getParameter("msgFrom")==null?"工作流程":request.getParameter("msgFrom").toString();
	String domainId=session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();
	String title="";
	//设置短信内容
    messageSettingBD messageSetting = new messageSettingBD();
	title=request.getParameter("processDefinitionName")==null?"":request.getParameter("processDefinitionName").toString();
    String contents = messageSetting.getModleContents(msgFrom, title, session.getAttribute("userName").toString(), session.getAttribute("orgName").toString(),session.getAttribute("domainId").toString()); //返回短信内容

	//显示短信
    boolean showSmsRemind = false;
    java.util.Map include_sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
    if(include_sysMap != null && include_sysMap.get("短信开通") != null && "1".equals(include_sysMap.get("短信开通").toString())){
	      if(new com.whir.ezoffice.message.action.ModelSendMsg().judgePurviewMessage(msgFrom, domainId)){	 
		      if(new com.whir.org.manager.bd.ManagerBD().hasRight(session.getAttribute("userId").toString(), "09*01*01")){
			       showSmsRemind = true;
		      }
	   }
    } 

    String  p_wf_dealWithJob=request.getAttribute("p_wf_dealWithJob")==null?"0":request.getAttribute("p_wf_dealWithJob").toString();

	long processInstanceId_long=new Long(0).longValue();
	if(processInstanceId!=null&&!processInstanceId.equals("")&&!processInstanceId.equals("null")){
		 processInstanceId_long=new Long(processInstanceId).longValue();
	}

	// 
	String inputType="checkbox";
	//
	String checkreturn="onclick='checkOnclikFun(this,0);'";
	String checkedStr="";
	if (gateType.equals("XOR")) { 
	   inputType="radio";
	} else {		
		//并行活动必须所有的选择
		if(gateType.equals("XAND")){
			 checkreturn="checked  onclick='XANDcheckFun(this);'";
	  }
	}
    
	//当前的流程实例id
	long avo_processInstanceId_long=processInstanceId_long;
	
	String isMainOrSon="";  
	ChoosedActivityVO avo=null;

    Calendar cnow = Calendar.getInstance();
	//c.setTime(date);
	cnow.add(Calendar.MINUTE, 60);


%>
<body>

<!-- 分叉活动选择时 记住 选择的是哪个活动-->
<input type="hidden"  name="temp_nowActivityId"  id="temp_nowActivityId" />
<!-- 设置过默认信息的活动id-->
<input type="hidden"  name="temp_setActInfoIds"  id="temp_setActInfoIds" />
<input type="hidden" name="defaultActivity" value="<%=defaultActivity%>">
<input type="hidden" name="gateType" value="<%=gateType%>">
<div><span>&nbsp;</span></div>
<div >
  <table width="586"  id="wf_c_mainTable" border="0" cellspacing="0" cellpadding="0" class="Table_bottomline" >
    <tr class="Table_nobttomline">
      <td width="85" valign="top"  class="td_lefttitle" style="text-align:left;"><bean:message bundle="filetransact" key="file.nextactivity"/><span class="MustFillColor">*</span>：</td>
      <td>
	  <div  class="newxLink"  style="max-height:110px;width:488px;margin-right:7px;text-align:left;" >
			<logic:iterate id="navo" name="nextActivitys"> 
			<%   				  
			    avo = (ChoosedActivityVO)navo; 

				String  li_name_display=" name=\"choose_subProcess_li\"  sytle=\"display:none\" ";

				//活动所属processInstanceId  跟当前流程相同   
				if(avo.getProcessInstanceId()!=null&&avo.getProcessInstanceId().equals(processInstanceId)){
					 li_name_display=" name=\"choose_nowProcess_li\" ";
				}

				//活动所属processInstanceId  跟当前流程不相同  可能是当前流程的子流程  也可能是当前流程的主流程
				if(avo.getProcessInstanceId()!=null&&!avo.getProcessInstanceId().equals(processInstanceId)){
				  
				} 


				isMainOrSon="";
				//当为0 时 表明是发起时。
				if(processInstanceId_long==0){

				}else{        
					if(avo.getProcessInstanceId()!=null&&!avo.getProcessInstanceId().equals("")&&!avo.getProcessInstanceId().equals("null")){
						avo_processInstanceId_long=new Long(avo.getProcessInstanceId()).longValue();
					}else{
						avo_processInstanceId_long=processInstanceId_long;
					}

					if(avo_processInstanceId_long>processInstanceId_long){
						isMainOrSon="<font color=\"red\">(子流程)</font>";
					}
					if(avo_processInstanceId_long<processInstanceId_long){
						isMainOrSon="<font color=\"red\">(主流程)</font>";
					}
				}

				//如果跟默认活动想同 就默认选中
				if(avo.getActivityId().equals(defaultActivity)||gateType.equals("XX")){
					checkedStr="checked";
				}else{
					checkedStr="";
				}

				//并行活动 还是 "checked  onclick='return   false;'";
				if(!gateType.equals("XAND")){
					checkreturn="onclick=\"checkOnclikFun('"+avo.getActivityId()+"',0);\"";
				}

			 
                //子流程的结束活动不需要选
				//if(avo.getActivityType()!=null&&avo.getActivityId()!=null&&avo.getActivityType().equals("end")&&avo.getActivityId().equals("sub_endevent1")){
				if(avo.getActivityType()!=null&&avo.getActivityId()!=null&&avo.getActivityType().equals("end")&&avo.getActivityId().startsWith("sub_")){
					 li_name_display+= " style=\"display:none\" ";
				}
				  
				  
				String radioAttributeStr="";
				radioAttributeStr+=" value='"+avo.getActivityId()+"' ";
				radioAttributeStr+=" self_activityName='"+avo.getActivityName()+"' ";//_choosedActivityName
				radioAttributeStr+=" self_activityType='"+avo.getActivityType()+"' ";//_choosedActivityType
				radioAttributeStr+=" self_processInstanceId='"+avo.getProcessInstanceId()+"' "; //_choosedProcessInstanceId
				radioAttributeStr+=" self_noteRemindType='"+avo.getNoteRemindType()+"' ";//_choosedNoteRemindType 短信提醒类型   no   没有短信提醒     有短信提醒时两个值： defaultCheck  默认短信提醒 defaultNoCheck  默认不短信提醒

				radioAttributeStr+=" self_priority='"+avo.getPriority()+"' ";//_choosedActivityType


				String  getActivityName=avo.getActivityName();
				if(getActivityName!=null&&getActivityName.equals("结束")){
				    getActivityName=Resource.getValue(local,"workflow","workflow.activitysetupend");
				}
 
			  %>
			 <div <%=li_name_display%>>
			     <input type="<%=inputType%>" name="chooseActivity"  <%=checkreturn%>   <%=radioAttributeStr%>  <%=checkedStr%>      />
				 <label><a href="#one"  onclick="checkOnclikFun('<%=avo.getActivityId()%>',5)"><%=getActivityName+isMainOrSon %></a></label>
			 </div> 
		  </logic:iterate>  
        </div> 
		</td>
    </tr>
    <tr class="Table_nobttomline" style="display:none">
      <td valign="top"  class="td_lefttitle"  style="text-align:left;"><bean:message bundle="filetransact" key="file.auditype"/><span class="MustFillColor">*</span>：</td>
      <td> 
		  <logic:iterate id="navo" name="nextActivitys"> 
		      <%
			      avo = (ChoosedActivityVO)navo;
			  %>
			  <div class="radiolist" id="radiolist_<%=avo.getActivityId()%>" style="display:none;text-align:left;"></div>
          </logic:iterate>   
	  </td>
    </tr>
    <tr class="Table_nobttomline" style="display:none" >
      <td valign="top"  class="td_lefttitle"  style="text-align:left;"><bean:message bundle="filetransact" key="file.doschedule"/>：</td>
      <td><div style="text-align:left;"  >
          <input type="checkbox" name="needProcessDeadlineDate" id="needProcessDeadlineDate" onclick="showProcessDeadlineDate();"/>
		  <span id="processDeadlineDateSapn" style="display:none">
		  <input type="text" id="temp_processDeadlineDate"  class="Wdate" style="width:180px"  onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})"    value="<%=new java.util.Date().toLocaleString()%>"/></span>
        </div></td>
    </tr>
    <tr class="Table_nobttomline">
      <td colspan="2" valign="middle"   id="allChoosedActivityUserTD">
	     <logic:iterate id="navo" name="nextActivitys"> 
		     <%
			    avo = (ChoosedActivityVO)navo;
			 %>
			    <input type="hidden" name="<%=avo.getActivityId()%>_choosedActivityName"       id="<%=avo.getActivityId()%>_choosedActivityName"  value="<%=avo.getActivityName()%>">
		        <input type="hidden" name="<%=avo.getActivityId()%>_choosedActivityType"       id="<%=avo.getActivityId()%>_choosedActivityType"  value="<%=avo.getActivityType()%>">
		        <input type="hidden" name="<%=avo.getActivityId()%>_choosedProcessInstanceId"  id="<%=avo.getActivityId()%>_choosedProcessInstanceId"  value="<%=avo.getProcessInstanceId()%>">
			 <%
				String activityId=avo.getActivityId();
				String activityName=avo.getActivityName();
				// 活动办理人 
				TransactorInfoVO  dealTransactorInfoVO=avo.getDealTransactorInfoVO();
				//活动阅件人
				TransactorInfoVO  readTransactorInfoVO=avo.getReadTransactorInfoVO();
				if(dealTransactorInfoVO!=null){ 
			 %>
				 <div  style="padding: 7px;" id="chooseUserDiv_<%=avo.getActivityId()%>">
					<%@ include file="ezflow_setUser.jsp"%>
				 </div>
			 <%}%>
          </logic:iterate>   
         <!--logic:iterate id="navo" name="nextActivitys"---> 
		  <%  
			  //avo = (ChoosedActivityVO)navo;	
			  //String  eachActivityId=avo.getActivityId();
			  String  eachActivityId=""; 
		  %>
          
		  <!--/logic:iterate-->
      <!--   </div> -->
		</td>
    </tr>
	
	 <tr class="Table_nobttomline"   id="remindTr">
        <td valign="top"  class="td_lefttitle" style="text-align:left;"><%=Resource.getValue(local,"workflow","workflow.remindersettings")%>：</td>
        <td style="text-align:left;">
	      <span   id="appendDiv_<%=eachActivityId%>" style="display:none">
		      <%if(showSmsRemind){%><span id="temp_sendNeedNoteType_span_<%=eachActivityId%>"  style="display:none"><input type="checkbox" name="temp_sendNeedNoteType_<%=eachActivityId%>" id="temp_sendNeedNoteType_<%=eachActivityId%>"  value="1" onClick="showSmsContentHref('<%=eachActivityId%>')"><bean:message bundle="workflow" key="workflow.activitysmsremind"/>&nbsp;</span><span id="showNoteDiv_a_<%=eachActivityId%>"  style="display:none" ><a  href="#" onClick="showSmsContent();"><%=Resource.getValue(local,"filetransact","file.smsremindcontent")%></a>&nbsp;&nbsp;</span><%}%>
               <input type="checkbox" name="temp_sendNeedMailType_<%=eachActivityId%>"  id="temp_sendNeedMailType_<%=eachActivityId%>" value="1"><%=Resource.getValue(local,"workflow","workflow.EmailReminder")%>&nbsp;&nbsp;</span>
			   <logic:iterate id="enavo" name="nextActivitys"><%  avo = (ChoosedActivityVO)enavo;	 String  _eachActivityId=avo.getActivityId();%> 
			   <span id="emergenceSpan<%=_eachActivityId%>"><bean:message bundle="filetransact" key="file.urgency"/>：<SELECT NAME="emergence<%=_eachActivityId%>" ID="emergence<%=_eachActivityId%>">
					<option value='10'  ><%=Resource.getValue(local,"filetransact","file.sort5")%></option> 
					<option value='20'  ><%=Resource.getValue(local,"filetransact","file.sort3")%></option>
					<option value='30'  ><%=Resource.getValue(local,"filetransact","file.sort4")%></option>
					<option value='40'  ><%=Resource.getValue(local,"filetransact","file.sort2")%></option>
					<option value='50'  ><%=Resource.getValue(local,"filetransact","file.sort1")%></option>
				</SELECT></span></logic:iterate>
          </span>
		  <span>&nbsp;&nbsp;<a href="javascript:void(0);"  onclick="showDealTips();"><%=Resource.getValue(local,"filetransact","file.tranremind")%></a></span>
	    </td>
    </tr>
    <tr class="Table_nobttomline" id="tipsmstr" style="display:none">
      <td colspan="2"  > 
         <div id="dealTipTr" style="padding: 7px;display:none">
          <textarea name="temp_dealTips"  wrap="physical"  id="temp_dealTips"   class="inputTextarea" style="width:100%;height:60px"></textarea>
         </div>

		 <div id="smsContentTR" style="padding: 7px;display:none">
            <textarea name="temp_smsContent"  id="temp_smsContent" wrap="physical"   class="inputTextarea" style="width:100%;height:60px"><%=request.getAttribute("smsContent")==null?"":request.getAttribute("smsContent")+""%></textarea>
         </div> 
	  </td>
    </tr>


    <tr class="Table_nobttomline"  style="<%=p_wf_dealWithJob.equals("1")?"":"display:none"%>" >
       <td valign="top"  class="td_lefttitle"  style="text-align:left;"><%=Resource.getValue(local,"workflow","workflow.JobStart")%>：</td>
       <td> 
		   <input type="text" id="temp_jobStartTime_str"  class="Wdate" style="width:180px"  onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss ',readOnly:true})"    value="<%= cnow.getTime().toLocaleString()%>"/>
	   </td>
    </tr>
 
    <tr class="Table_nobttomline">
	     <td ></td>
         <td style="text-align:left;">
	         <input id="psendbutton0" type="button" value='<%=Resource.getValue(local,"workflow","workflow.button_send")%>'  class="btnButton4font"  onclick="ok(0,this);" />
			 <s:if test="p_wf_openType=='startOpen'">
             <input id="psendbutton1" type="button" value="<%=Resource.getValue(local,"workflow","workflow.button_sendcontinue")%>"  class="btnButton4font"  onclick="ok(1,this);" />
			 </s:if>
             <input id="cancelbutton" type="button" value='<%=Resource.getValue(local,"workflow","workflow.button_cancel")%>'  class="btnButton4font"  onclick="thisClose();" />
		</td>
    </tr>
  </table>
</div>
<!--解决 浮动层 被Object 覆盖的问题加的  注意  z-Index:-1 -->
<!-- <iframe id='iframebar' src="about:blank" frameBorder=0 marginHeight=0 marginWidth=0
style="position:absolute; visibility:inherit; top:6px; left:6px;height:98%;width:98%; z-Index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';">
</iframe>
  -->
<!-- <iframe id='iframebar' src="about:blank" frameBorder=0 marginHeight=0 marginWidth=0 style="position:absolute; visibility:inherit; top:6px; left:6px;height:98%;width:98%; z-Index:-1;filter:alpha(opacity=0);opacity:0;-ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)';">
</iframe> -->
<script type="text/javascript"> 
 /**
   XAND 
 */
 function XANDcheckFun(obj){
	 $(obj).attr("checked",'checked');
	 return false;
 }
 
  // 活动选择 与点击事件
  //// 活动选择 与点击事件  ctype: 0:选中前面的checkbox      5: 点击活动名 显示次活动对应的div
  function  checkOnclikFun(onclik_aid,ctype){
	  var choosedObj=null;
	  var ischecked=false;
	  $("input[name='chooseActivity']").each(function(){  
		  var aid=$(this).prop("value");
		  if(aid==onclik_aid){
			 choosedObj=$(this);
			 //点击活动名  表明是选择这个活动打开对应的div
			 if(ctype==5){
                 $(this).attr("checked",'checked');
				 ischecked=true;
			 }else{
			     if( $(this).prop("checked")){
                    ischecked=true;
			     }else{
					ischecked=false;
				} 
			 }
		     // c[k].checked=true;
		     //alert(c[k].checked)		
			 return false;
		 }
	  });

	  if(ischecked){ 		 
	      dealDefaultDic(choosedObj); 
      }else{
	      //设置默认的活动
          setDefaultActivity();
      }  
}

 
/**
关闭当前的对话框
*/
 function  thisClose(){
      $.dialog({id:'workflowDialog'}).close(); 
 }
 
 //显示办理期限
function showProcessDeadlineDate(){
   if($("#needProcessDeadlineDate").attr("checked")=="checked"){
		$("#processDeadlineDateSapn").show();
	} else{
		$("#processDeadlineDateSapn").hide();
	}
}

 
//显示办理提示
function showDealTips(){
	var temp= $("#dealTipTr").is(":hidden");//是否隐藏 
	if(temp){
	    $("#tipsmstr").show();
		$("#dealTipTr").show();
		$("#smsContentTR").hide();
		$("#temp_dealTips").focus();
	}else{
		$("#dealTipTr").hide();
		$("#tipsmstr").hide();
	}
  
    $.dialog({id:'workflowDialog'})._reset(); 
}

//显示短信内容
function showSmsContent(){
	var temp= $("#smsContentTR").is(":hidden");//是否隐藏 
	if(temp){
	    $("#tipsmstr").show();
		$("#smsContentTR").show();
		$("#dealTipTr").hide();
		$("#temp_smsContent").focus(); 
	}else{
		$("#smsContentTR").hide();
		$("#tipsmstr").hide();
	}
	
	 $.dialog({id:'workflowDialog'})
}


function  showSmsContentHref(id){ 
    if($("#temp_sendNeedNoteType_").attr("checked")=="checked"){
		$("#showNoteDiv_a_").show();
	} else{
		$("#showNoteDiv_a_").hide();
	}
}
 
//chooseActivity();

function judegeS(value){
    var r_value="\\\,/,?,#,&,\',\"";
    var speCharArr = r_value.split(",");
	for(var i=0;i<speCharArr.length;i++ ){
		if(speCharArr[i]!='' && value.indexOf(speCharArr[i])>=0){
			return "不能包含 "+replaceAll(r_value,",","，")+" 这些特殊字符！";
		}
	}
	return "";
}

function ok(type,obj){
	try{
	   //调用表单js再一次检查自动编号
	   checkOnlyFields(false);
	}catch(e){
	}
    
 <%if(p_wf_dealWithJob.equals("1")){%> 
	var  remindDate=$("#temp_jobStartTime_str").val(); 
	remindDate = remindDate.replace("-","/");//替换字符，变成标准格式 
	remindDate = remindDate.replace("-","/");//替换字符，变成标准格式 
	//alert(remindDate);
	var d = new Date(Date.parse(remindDate));  
	var d2 =new Date();  
	if (d <= d2) { 
		whir_alert('您选择的时间已过期！',function (){});
		return false;
	}   
<%}%>


	//是否是发送继续
	$("#p_wf_saveType").val(type);

   if($("#temp_dealTips").val()!=""&&$("#temp_dealTips").val().length>100){
       //whir_poshytip($("#temp_dealTips"),"提示信息不能超过100!");
	   whir_alert('<%=Resource.getValue(local,"workflow","workflow.tipsinfoistoolong")%>');
	   return false;
   }else{
	   /* var jTips=judegeS($("#temp_dealTips").val());
        if(jTips!=""){
			whir_alert("提示信息"+jTips);
			return false;
		}*/
   }

   if($("#temp_sendNeedNoteType_").attr("checked")=="checked"&&$("#temp_smsContent").val()!=""&&$("#temp_smsContent").val().length>100){
       //whir_poshytip($("#temp_dealTips"),"提示信息不能超过100!");
	   whir_alert('<%=Resource.getValue(local,"workflow","workflow.smsinfoistoolong")%>');
	   return false;
   }
   $("#ezFlow_includeHiddenDivInfo").html("");
   if(checkSubmit()){
       //给隐藏的div赋值
	   $("#ezFlow_includeHiddenDivInfo").html($("#allChoosedActivityUserTD").html());
 
	   //缓急
	   /* var emergence=$("#emergence").val();
       $("#whir_priority").val(emergence);*/

       var  htmlemergenceInfo='';
	   $("input[name='chooseActivity']:checked").each(function(){  
		  var aid=$(this).prop("value"); 
          htmlemergenceInfo+='<input type="hidden" name="whir_priority'+aid+'"  value="'+$("#emergence"+aid).val()+'">';
	  });   
	  $("#ezFlow_includeHiddenDivInfo").append(htmlemergenceInfo); 

       
       //检测选择的人的状态，是否是在正常上班的状态， 如果不是，让用户选择是否继续发送。
	   var totalUserAccounts="";
	   $("input[name='chooseActivity']:checked").each(function(){  
		  var aid=$(this).prop("value"); 
          totalUserAccounts=$("#"+aid+"_deal_userAccount").val();	 
	    }); 
		var judgeStatusUrl="<%=rootPath%>/platform/bpm/ezflow/operation/ezflow_judge_empstatus.jsp?operId="+totalUserAccounts;
		var shtml = $.ajax({url: judgeStatusUrl,async: false}).responseText;  
		if(shtml == ""){
			 sendProcess();				  
		} else {
			 whir_confirm("<%=Resource.getValue(local,"workflow","workflow.includenextuser")%>:"+shtml+ ",<%=Resource.getValue(local,"workflow","workflow.includeconfirmturntodeal")%>",   function(){sendProcess();});
		} 	
   }else{
     return false;
   }
}
 
/**
流程发送 里面判断是发起 还是办理
*/
function  sendProcess(){
	//发起流程
	var openType=$("#p_wf_openType").val();
	//发起页面
	if(openType=="startOpen"||openType=="reStart"||openType=="startAgain"||openType=="fromDraft"){
		startProcess();
	}else{
	   //修改办理页面
		updateProcess();
	}	
}
 


//发送前检测
function  checkSubmit(){	 
	var result=true;
    //检测表单 设置批示意见
	if(false){
		result=false;
		return result;
	}

	//先判断是否选了人
	//选择的活动id
	var temp_choosedActivityIdValuse="";
	//判断选择的办理人总长度不能超过300
	var all_choosedUserName ="";
	
	$("input[name='chooseActivity']:checked").each(function(){  
		  var aid=$(this).prop("value");
		  if(checkUser(aid)){
			   temp_choosedActivityIdValuse+=aid+",";
			   all_choosedUserName += $("#"+aid+"_deal_userName").val();
		  }else{
               result=false;
			   return false;
		  } 
	});

	if(result){
		if(all_choosedUserName !='undefined' && all_choosedUserName.length >300){
			whir_alert('您选择的用户过多，请重新选择！',function(){});
			result=false;
		}
	}

	if(result){
	   if(temp_choosedActivityIdValuse==""){
		   whir_alert('<%=Resource.getValue(local,"workflow","workflow.pleasechoosedealactivity")%>',function(){});
           result=false;
	   }else{
		   //给 发送 办理选择的活动 赋值
	       temp_choosedActivityIdValuse=temp_choosedActivityIdValuse.substring(0,temp_choosedActivityIdValuse.length-1); 
		   $("#p_wf_choosedActivityId").val(temp_choosedActivityIdValuse);
	   }
	}
 
   //短信提醒
   var temp_sendNeedNoteType_str="0"; 
   if($("#temp_sendNeedNoteType_").attr("checked")=="checked"){
		   temp_sendNeedNoteType_str="1";
   } 

   $("#sendNeedNoteType").val(temp_sendNeedNoteType_str);

   //邮件提醒
   var  temp_sendNeedMailType_str="0";
 
   // 是否需要发送邮件
   if($("#temp_sendNeedMailType_").attr("checked")=="checked"){
		 temp_sendNeedMailType_str="1";
   } else{
		 temp_sendNeedMailType_str="0";
   }
 
   $("#sendNeedMailType").val(temp_sendNeedMailType_str);

   //提示内容
   $("#whir_dealTips").val($("#temp_dealTips").val());
   //短信内容
   $("#whir_noteContent").val($("#temp_smsContent").val());
 
   return result;
}
 
var innerHtml="";
var oncklickIndex=0;

/**
发起流程
*/
function  startProcess(){ 
	 if(oncklickIndex==0&&ezFormSaveATezFLOW()){
		  var url="<%=rootPath%>/ezflowoperate!startProcess.action";
		  $("#dataForm").attr("action",url);
		  setCallBackName("");
		   //设置按钮不可用
		  $("#psendbutton0").attr("disabled", "disabled"); 
		  if($("#psendbutton1").length>0){
		      $("#psendbutton1").attr("disabled", "disabled");
		  }
		  $("#cancelbutton").attr("disabled", "disabled");
		  $("#jobStartTime_str").val($("#temp_jobStartTime_str").val());
		  //设置已经提交一次
		  oncklickIndex=1;
		  $("#dataForm").submit();
	 }
}

/**
办理流程
*/
function  updateProcess(){   
      if(oncklickIndex==0&&initCommentAndAccessory()&&ezFormSaveATezFLOW()){
		  var url="<%=rootPath%>/ezflowoperate!completeTask.action";
		  $("#dataForm").attr("action",url);
		  setCallBackName("afterCompleteProcess");
		  //设置按钮不可用
		  $("#psendbutton0").attr("disabled", "disabled"); 
		  if($("#psendbutton1").length>0){
		      $("#psendbutton1").attr("disabled", "disabled");
		  }
		  $("#cancelbutton").attr("disabled", "disabled");
		  //设置已经提交一次
		  oncklickIndex=1;
		  $("#dataForm").submit();
	  }
}

 
 


// 检测是否选人
function  checkUser(aid){
    //办件选人方式
	var  dealTpye= $("#"+aid+"_deal_userId_type").val();

	var isSingle=judgeIsSingleUser_real(aid);
 
	//阅件选人方式
	var  readTpye="";
	var  needRead=false;
	if($("#"+aid+"_read_userId_type").length>0){
		 needRead=true;
		 readTpye= $("#"+aid+"_read_userId_type").val();
	}else{
	}
	
	//如果是树形选人要特殊处理
	if(dealTpye=="tree"){	  
		    var codes = getTreeInfo(aid+"_deal_","code");
		    var names = getTreeInfo(aid+"_deal_","name");
		    var ids = getTreeInfo(aid+"_deal_","id");
		    dressUpUserOfTree(codes,"$",aid+"_deal_userAccount");
		    dressUpUserOfTree(names,",",aid+"_deal_userName");
		    dressUpUserOfTree(ids,"$",aid+"_deal_userId");    
	}
	if(needRead){
		if(readTpye=="tree"){		 
			  var codes = getTreeInfo(aid+"_read_","code");
			  var names = getTreeInfo(aid+"_read_","name");
			  var ids = getTreeInfo(aid+"_read_","id");
			  dressUpUserOfTree(codes,"$",aid+"_read_userAccount");
			  dressUpUserOfTree(names,",",aid+"_read_userName");
			  dressUpUserOfTree(ids,"$",aid+"_read_userId"); 	  
		}
	}
 
	var result=true;
	if($("#"+aid+"_deal_userAccount").val()==""){
		whir_alert('<%=Resource.getValue(local,"workflow","workflow.dealuserisnull")%>',function(){});
		result=false;
	}else{
		////如果是单人办理方式 ， 选的人没有前后$  这里加上。
		var eachUserId=$("#"+aid+"_deal_userAccount").val(); 
		if(eachUserId!=undefined){
			if(!eachUserId.startWith("$")&&!eachUserId.endWith("$")){
				//自动加上前后$
				$("#"+aid+"_deal_userAccount").val("$"+eachUserId+"$");
			}
		}
	}  

	if(isSingle=="yes"){ 
		var ggg="s"+$("#"+aid+"_deal_userAccount").val()+"s";
	    var gggArr=ggg.split("$");
	    var gggArr_length=gggArr.length; 
		if(gggArr_length>3){
			 whir_alert("审批方式为单人不能选择多个办理人！");
			 return ;
		}
	}
    return result;
}
 
//封装
function  dressUpUserOfTree(values, dressUpStr ,id){
  var resultValue="";
  if(values!=""){
      var  valuesArr=values.split(",");
	  for(var i=0;i< valuesArr.length;i++){
	      if(valuesArr[i]!=""){
			  if(dressUpStr=="$"){
                  resultValue+=dressUpStr+valuesArr[i]+dressUpStr;
			  }else if(dressUpStr==","){
				  resultValue+=valuesArr[i]+dressUpStr;
			  }          
		  }
	  } 
	  $("#"+id).val(resultValue);
  }
}
 


//设置当前选中的活动
function setDefaultActivity(){  
	var choosedObj=null;
	var totalLength=$('input[name=chooseActivity]').length; 
	var length=$('input[name=chooseActivity]:checked').length; 
	if(length<=0){
	    $('input[name="chooseActivity"]').eq(0).attr("checked",'checked');
	    choosedObj=$('input[name=chooseActivity]:checked');
		if(choosedObj.attr("self_activityType")=="end"&&totalLength>1){
		    $('input[name="chooseActivity"]').eq(1).attr("checked",'checked');
	        choosedObj=$('input[name=chooseActivity]:checked');
		}
	}else{
		var index=1;
		//第一个选中的 并且不是结束活动
		$("input[name='chooseActivity']").each(function(){  
		    if($(this).prop("checked")){
				//如果是结束活动 并且 还有其它选中的活动 就接着选下一个
				if($(this).attr("self_activityType")=="end"&&index<length){
				}else{
			      choosedObj=$(this);
			      return false;
				}
		    } 	
			index++;
	   });
	}

 
	//显示默认的div
	dealDefaultDic(choosedObj);
}

//设置选中的div
function  dealDefaultDic(choosedObj){
    var defaultAId=choosedObj.val();
    //记住本次选择的是那个活动 此数据后台不需要    
    $("#temp_nowActivityId").val(defaultAId); 
	$("div[id^='chooseUserDiv_']").hide();
	$("#chooseUserDiv_"+choosedObj.val()).show();
    /*
    办理方式
	$("div[id^='radiolist_']").hide();
	$("#radiolist_"+choosedObj.val()).show();*/
    //提醒设置提醒设置
	$("span[id^='appendDiv_']").hide();
	$("#appendDiv_").show(); 
	if(choosedObj.attr("self_activityType")=="end"){
		$("#remindTr").hide();
	}else{
	    $("#remindTr").show();
	} 
    //处理 子过程 结束的情况
	setChecked();
	 //显示短信设置
    disableSMS(choosedObj);
	//自动办理
	autoOk();
}


/**
 显示短信提醒
*/
function disableSMS(choosedObj){  
   var id=choosedObj.val();
   var activityType_val=choosedObj.attr("self_activityType");
   var noteRemindType_val=choosedObj.attr("self_noteRemindType"); 
   var rpriority=choosedObj.attr("self_priority");  
   var temp_setActInfoIds_=$("#temp_setActInfoIds").val();
   $("span[id^='emergenceSpan']").hide(); 
   $("#emergenceSpan"+id).show();
 
   //只设置一次
   if(temp_setActInfoIds_.indexOf("$"+id+"$")<0){
	   $("#emergence"+id).val(rpriority);
	   $("#temp_setActInfoIds").val($("#temp_setActInfoIds").val()+"$"+id+"$");
   }else{  
   } 

   //如果选中的是结束活动  隐藏邮件提醒 与办理提示
   if(activityType_val=="end"){
	   $("#appendDiv_").hide(); 
   }else{
	   $("#appendDiv_").show(); 
   } 

   <%if(showSmsRemind){%>
	   //没有短信提醒
      if(noteRemindType_val=="no"||noteRemindType_val=="null"){
          $("#temp_sendNeedNoteType_span_").hide();
		  $("#showNoteDiv_a_").hide();
      }else{
	      $("#temp_sendNeedNoteType_span_").show();  
		  //默认短信提
		   if(noteRemindType_val=="defaultCheck"){
			    $("input[name='temp_sendNeedNoteType_']").attr("checked",true);
				showSmsContentHref(id);
		   }
	  }    
  <%}%> 
}
 

//处理 子过程
function  setChecked(){
    var c=document.getElementsByName("temp_choosedActivityId");
	//------------------判断是否有结束活动  并且 结束活动 是否选中  star----------------------
	//是否有结束活动
    var haveEnd="false";
	//结束活动是否选中
	var endChecked="false";

	$("input[name='chooseActivity']").each(function(){  
		  var aid=$(this).prop("value");
		  var activityType_val=$(this).attr("self_activityType");
		  var processInstanceId_val=$(this).attr("self_processInstanceId");
		  //if(activityType_val=="end"&&processInstanceId_val=="<%=processInstanceId%>"){
		  //并且不是 子流程的结束活动
		  // 
		  //if(activityType_val=="end"&&processInstanceId_val=="<%=processInstanceId%>"&&aid!="sub_endevent1"){
		  if(activityType_val=="end"&&processInstanceId_val=="<%=processInstanceId%>"&&aid.indexOf("sub_")!=0){
			   haveEnd="true";
			   if($(this).prop("checked")){
			      endChecked="true";
			   } 
	      }
	 }); 
   
   //------------------判断是否有结束活动  并且 结束活动 是否选中   end ----------------------

   $("input[name='chooseActivity']").each(function(){  
		  var aid=$(this).prop("value");
		  var activityType_val=$(this).attr("self_activityType");
		  var processInstanceId_val=$(this).attr("self_processInstanceId");
		  if(activityType_val=="end"&&processInstanceId_val=="<%=processInstanceId%>"){
			   
	      }else{
			   if(haveEnd=="true"){
				  //选中了子流程的结束事件
				  if(endChecked=="true"){
					  //都是子流程的
					  if(processInstanceId_val=="<%=processInstanceId%>"){
						  $(this).prop("checked",false);	
						  //  $(this).attr("checked",'checked');
						  //不能选择
						  //c[k].checked=false;
					  }else{
						  //父流程的都选中
						  //c[k].checked=true;
						  $(this).prop("checked",true);	
					  }
				  }else{
					  //没有选择子流程的结束事件

					  //都是子流程的
					  if(processInstanceId_val=="<%=processInstanceId%>"){
						 
					  }else{
						  //没有选择子流程的结束活动， 父流程的都不能选中
						  // c[k].checked=false;
						  $(this).prop("checked",false);
					  }
				  }
			   }
		  }
	 });
 
	 //结束活动
	 if(haveEnd=="true"&&endChecked=="true"){
		 $("#gate_dealType").val("COMPLETE");
	 }else{
		 $("#gate_dealType").val("<%=gateType%>");
	 }  
}

function popupFormInit(){
	//主要是子活动 生成主键
	<% if(ezflowBusinessKey!=null&&!ezflowBusinessKey.equals("")&&!ezflowBusinessKey.equals("null")){%>
		   $("#p_wf_recordId").val("<%=ezflowBusinessKey%>");
	<%} %>

	<% if(afterInsertTaskIds!=null&&!afterInsertTaskIds.equals("")&&!afterInsertTaskIds.equals("null")){%>
		   $("#p_wf_taskId").val("<%=afterInsertTaskIds%>");
	<%} %>
    
	 <%if(p_wf_dealWithJob.equals("1")){%> 
              $("#p_wf_dealWithJob").val("1");
	 <%}%> 
	$("#gate_dealType").val("<%=gateType%>");
	$("#gateNum").val("<%=gateNum%>");
    setDefaultActivity();
	setInputStyle();
}

/**
 自动发送
*/
function  autoOk(){  
   <%if(p_wf_dealWithJob.equals("0")){%> 
		//本次有几个活动
		var length=$("input[name='chooseActivity']").length;
		//只有一个活动时
		if(length==1){
			   var id =$("#temp_nowActivityId").val();  
			   var length_yue=$("#Panle_A_"+id+"_1").length;
			   //有阅件不自动发送
			   if(length_yue>=1){
			       return false;
			   }
			  //default_text
			  //办件选人方式
			  var  dealTpye= $("#"+id+"_deal_userId_type").val();
			  //默认全部发送的
			  if(dealTpye=="default_text"){  
				   if($("#"+id+"_deal_userAccount").val()==null||$("#"+id+"_deal_userAccount").val()==undefined||$("#"+id+"_deal_userAccount").val()==""){
					  
				   }else{ 
					  //ok(0,$("#psendbutton0"));
				   } 
			  }    
		} 
	<%}%>
}


/**
*判断是否是单选人
*/
function  judgeIsSingleUser(){   
	//当前选中的活动
    var id =$("#temp_nowActivityId").val(); 
	return judgeIsSingleUser_real(id);
} 

function judgeIsSingleUser_real(id){
	var approveVal= $("#isSingle_"+id).val();
	if(approveVal=='yes'){
		return "yes";
	}else{
		return "no";
	}
}

/**
树形选人
**/
function  dealAfterTreeAuto(){
   <%if(p_wf_dealWithJob.equals("0")){%> 
	//本次有几个活动
	var length=$("input[name='chooseActivity']").length;

	
	//只有一个活动时
	if(length==1){
		   var id =$("#temp_nowActivityId").val();  
		   var length_yue=$("#Panle_A_"+id+"_1").length;
		   //有阅件不自动发送
		   if(length_yue>=1){
			   return false;
		   }
		 
		  //default_text
		  //办件选人方式
		  var  dealTpye= $("#"+id+"_deal_userId_type").val();
		  //默认全部发送的
		  if(dealTpye=="default_text"){  
			   if($("#"+id+"_deal_userAccount").val()==null||$("#"+id+"_deal_userAccount").val()==undefined||$("#"+id+"_deal_userAccount").val()==""){
				  
			   }else{ 
				  //ok(0,$("#psendbutton0"));
			   } 
		  } 

		  if(dealTpye=="tree"){    
				var ids = getTreeInfo(id+"_deal_","id"); 
				if(ids==null||ids==undefined||ids==""){
				
				}else{   
					if(ids.endWith(",")){
						 ids=ids.substring(0,ids.length-1);
					} 
					var idsArr=ids.split(",");
					
					 if(idsArr.length==1){
						 //ok(0,$("#psendbutton0"));
					 } 
			   } 
		  }   
	} 
 <%}%>
}

</script>
</body>
</html>
