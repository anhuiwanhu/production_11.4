<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@page import="java.util.*"%>
<%@page import="com.whir.ezflow.vo.*"%>
<%  
    whir_custom_str="easyui,powerFloat ";
    String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
    //下一办理活动
	List nextActivitys = new ArrayList();
	if (request.getAttribute("choosedActivityList") != null) {
		nextActivitys = (List) request.getAttribute("choosedActivityList");
	}
 
	//父流程id
	String superProcessInstanceId=request.getAttribute("p_wf_superProcessInstanceId") == null ? "": request.getAttribute("p_wf_superProcessInstanceId").toString();
    
	//是否有短信权限
	boolean showSmsRemind=false;
    if(request.getAttribute("showSmsRemind")!=null&&request.getAttribute("showSmsRemind").toString().equals("true")){
	   showSmsRemind=true;
    }

	String  hiddenBackSetStyle="";
	
	String  __p_wf_isbacktrackAct=request.getAttribute("p_wf_isbacktrackAct") == null ? "": request.getAttribute("p_wf_isbacktrackAct").toString();

	if(__p_wf_isbacktrackAct.equals("1")){
	    hiddenBackSetStyle="style='display:none'";
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>标准详细页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	 <SCRIPT LANGUAGE="JavaScript">
	 <!--
	 var api =null;
	 var W=null;
     api=frameElement.api, W = api.opener; 
	 //-->
	 </SCRIPT>
</head>
<body >
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	      <s:form name="popForm" id="popForm" action="wfprocess!saveProcess.action" method="post" theme="simple" >
		         <input type="hidden" name="addDivContent"  id="addDivContent" value=""> <!-- 在  常用语中用到-->
				 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Table_bottomline" >
					<tr>
					  <td width="90" valign="top"  class="td_lefttitle"><bean:message bundle="workflow" key="workflow.back_step"/><span class="MustFillColor">*</span>：</td>
					  <td id="selPressTD"> 
						   <select size="2" name="back_activity_init"  id="back_activity_init" style="width:98%;height:105px" onchange="resetbackNeedBackType();" whir-options="vtype:['notempty']">
						    <%
								   if(nextActivitys!=null && nextActivitys.size() > 0){
									  for (int ai = 0; ai < nextActivitys.size(); ai++) {
										   ChoosedActivityVO avo = (ChoosedActivityVO) nextActivitys.get(ai);
											String activityId=avo.getActivityId();
											String activityName=avo.getActivityName();
											// 活动办理人 
											TransactorInfoVO  dealTransactorInfoVO=avo.getDealTransactorInfoVO();
											if(dealTransactorInfoVO!=null){
												List identityVOList=dealTransactorInfoVO.getIdentityVOList();
												if(identityVOList!=null&&identityVOList.size()>0){
													//总个活动办理人的帐号  名字   id (id 目前可以为空)
													String  back_userAccounts="";
													String  back_userNames="";
													String  back_userIds="";
													int  ulength=identityVOList.size(); 
													for(int i=0;i<identityVOList.size();i++){
														 IdentityVO  identityVo=(IdentityVO)identityVOList.get(i);
														 //back_userAccounts+=identityVo.getIdentityCode()+",";
														 //back_userNames+=identityVo.getIdentityName()+",";
														 //back_userIds+=identityVo.getIdentityId()+",";
														 %>
														 <option  value="<%=activityId%>"  back_userAccounts="<%=identityVo.getIdentityCode()%>"  back_userNames="<%=identityVo.getIdentityName() %>"  back_userIds="<%=identityVo.getIdentityId() %>"><%=activityName%>  <%=identityVo.getIdentityName() %></option>
													<%}
													for(int j=identityVOList.size()-1;j>=0;j--){
														IdentityVO  identityVo=(IdentityVO)identityVOList.get(j);
														back_userAccounts+=identityVo.getIdentityCode()+",";
														back_userNames+=identityVo.getIdentityName()+",";
														back_userIds+=identityVo.getIdentityId()+",";
													}
													if(back_userAccounts.length()>1){
														 back_userAccounts=back_userAccounts.substring(0,back_userAccounts.length()-1);
														 back_userNames=back_userNames.substring(0,back_userNames.length()-1);
														 back_userIds=back_userIds.substring(0,back_userIds.length()-1);
													}
													%>
													<%
													if(ulength>1){
													%>
													<option  value="<%=activityId%>"  back_userAccounts="<%=back_userAccounts%>"  back_userNames="<%=back_userNames%>"  back_userIds="<%=back_userIds%>"><%=activityName%> 全部办理人</option>	
													<%}%>
												<%}
											}
									  }
								   }
								 %>
								  <%if(superProcessInstanceId==null||superProcessInstanceId.equals("null")||superProcessInstanceId.equals("")){%>
									<option  value="-1"  back_userAccounts=""  back_userNames=""  back_userIds=""><bean:message bundle="workflow" key="workflow.Sponsor" /></option>
								  <%}%>
						  </select>
					  </td>
					  <td>&nbsp;</td>
					</tr>
					<!--退回原因 -->
					<tr >
					  <td  class="td_lefttitle"  for='<bean:message bundle="workflow" key="workflow.back_reason"/>'  valign="top" ><bean:message bundle="workflow" key="workflow.back_reason"/><span class="MustFillColor">*</span>：</td>
					  <td><textarea name="temp_backReason"  id="temp_backReason"  class="inputTextarea"  style="width:98%;height:60px"              whir-options="vtype:['notempty',{'maxLength':100}]"  ></textarea></td>
					  <td>&nbsp;</td>
					</tr>
					<!--邮件提醒-->
					<tr class="Table_nobttomline">
					  <td    class="td_lefttitle" for='提醒设置' ><%=Resource.getValue(local,"workflow","workflow.EmailReminder")%>：</td>
					  <td><input type="radio" name="temp_backEmailRemindType"  value="0" checked ><%=Resource.getValue(local,"workflow","workflow.ReturnPartOfManagers")%><!--退回环节经办人-->&nbsp;&nbsp; 
                          <input type="radio" name="temp_backEmailRemindType"  value="1"><%=Resource.getValue(local,"workflow","workflow.AllParticipator")%>&nbsp;&nbsp;&nbsp; 
						  <span <%=showSmsRemind?"":"style='display:none'"%> >
						  <input type="checkbox" name="temp_backNeedNoteRemind"  id="temp_backNeedNoteRemind" value="1"><bean:message bundle="workflow" key="workflow.activitysmsremind"/></span></td>
					  <td>&nbsp;</td>
					</tr>

					<!--反馈人-->
					<tr class="Table_nobttomline" id="backNeedBackType_div"    <%=hiddenBackSetStyle%> >
					  <td  class="td_lefttitle"><%=Resource.getValue(local,"workflow","workflow.back_dealafterbackset")%>：</td>
					  <td>
					      <input type="radio" name="temp_backNeedBackType"  value="0" checked><%=Resource.getValue(local,"workflow","workflow.back_dealwithold")%>
                          <input type="radio" name="temp_backNeedBackType"  value="1"><%=Resource.getValue(local,"workflow","workflow.back_backtothis")%>
					  </td>
					  <td>&nbsp;</td>
					</tr>
 	 
					<tr class="Table_nobttomline" >
					  <td></td>
					  <td colspan="2">
						   <input name="input2" id="back_button" type="button" value='<%=Resource.getValue(local,"workflow","workflow.button_ok")%>' class="btnButton4font" onclick="sendok();" />
						   <input name="input2"  type="button" value='<%=Resource.getValue(local,"workflow","workflow.button_cancel")%>' class="btnButton4font" onclick="thisClose();" />
					  </td>
					</tr>
				  </table>
	      </s:form>
		</div>
	     <!--解决 浮动层 被Object 覆盖的问题加的  注意  z-Index:-1 -->
		<iframe id='iframebar' src="about:blank" frameBorder=0 marginHeight=0 marginWidth=0 style="position:absolute; visibility:inherit; top:6px; left:6px;height:98%;width:98%; z-Index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';">
		</iframe>
	</div>
</body>
<script type="text/javascript">
 

    
    //只有退回发起人是偶， 默认选择退回发起人
	if($("#back_activity_init option").length==1){
	　　 $("#back_activity_init option").each(function(){ 
	　　　　 $(this).attr("selected", true); 　
	　　 })
		 resetbackNeedBackType();
	}


	 var fff=$("#p_wf_isbacktrackAct",parent.document.body).val();
	 if(fff=="1"){
	      $("#backNeedBackType_div").hide();
	 }
 
	/**
	关闭当前的对话框
	*/
	 function  thisClose(){
		  //$.dialog({id:'workflowDialog'}).close(); 
		  api.close(); 
	 }


	/**
	常用语添加
	*/
	function addDivContent(){
		var adddivcontent=$("#addDivContent").val();
		var comment=document.getElementById("noteDiv").getAttribute("value");
		document.getElementById("noteDiv").innerHTML= ""+"<div class='divOut' onmouseover='this.className=\"divOver\"' onmouseout='this.className=\"divOut\"' onclick=\"include_set_comment(this,\'"+comment+"\');\">"+adddivcontent+"<\/div>"+document.getElementById("noteDiv").innerHTML;
	}

	 /**
	    设置 是否显示 "重新提交设置"
	    退回中间环节 可以 "重新提交设置";
	 */
     function resetbackNeedBackType(){
		 var activityId=$("#back_activity_init").val();
		 if(activityId=="-1"){
			  $("#backNeedBackType_div").hide();
		 }else{
			  $("#backNeedBackType_div").show();
		 }

	      var _fff=$("#p_wf_isbacktrackAct",parent.document.body).val();
	      if(_fff=="1"){
	           $("#backNeedBackType_div").hide();
	     }
      }
 
	  /**
	  发送
	  */
	 function  sendok(){
	    if(!validateForm("popForm")){
		    return false;
	    }
        //alert($("#ezFlow_includeHiddenDivInfo").html()); 
		$("#ezFlow_includeHiddenDivInfo").html("");
		var activityId=$("#back_activity_init").val();
        if(activityId==null||activityId==""){
			//$.dialog.alert("<%=Resource.getValue(local,"filetransact","file.selreturnstep")%>",function(){},api);
			W.$.dialog.alert("<%=Resource.getValue(local,"filetransact","file.selreturnstep")%>",function(){});
			return;
		}
        //选择哪一项
	    var back_userAccounts="";//activityOption.back_userAccounts;
		var back_userNames="";//activityOption.back_userNames;
		var back_userIds="";//activityOption.back_userIds;
		if($("#back_activity_init option:selected").length>0){
	　　　 $("#back_activity_init option:selected").each(function(){
	　　　　　  back_userAccounts=$(this).attr("back_userAccounts");//activityOption.back_userAccounts;
				back_userNames=$(this).attr("back_userNames");//activityOption.back_userNames;
				back_userIds=$(this).attr("back_userIds");//activityOption.back_userIds;	               　
	　　　 });
		}  	   
	    //提醒范围
	    var  temp_backEmailRemindType_str="0";
	    var temp_backEmailRemindTypeObj=$('input[name=temp_backEmailRemindType]:checked');   
	    temp_backEmailRemindType_str =temp_backEmailRemindTypeObj.val(); 
	    //短信是否提醒
	    var temp_backNeedNoteRemind_str="0";
	    if($("#temp_backNeedNoteRemind").attr("checked")=="checked"){
		    temp_backNeedNoteRemind_str="1";
	    }     
	    $("#back_activityId",parent.document.body).val(activityId);
	    $("#back_userAccounts",parent.document.body).val(back_userAccounts);
	    $("#back_userNames",parent.document.body).val(back_userNames);
	    $("#back_userIds",parent.document.body).val(back_userIds);   
	    $("#backEmailRemindType" ,parent.document.body).val(temp_backEmailRemindType_str);
	    $("#backNeedNoteRemind" ,parent.document.body).val(temp_backNeedNoteRemind_str);
	    $("#backReason",parent.document.body).val($("#temp_backReason").val()); 	
		//是否自动返回
		var c=document.getElementsByName("temp_backNeedBackType");
		for(var k=0;k<c.length;k++){
			if(c[k].checked){
			  $("#backNeedBackType",parent.document.body).val(c[k].value);
			}	   
		}			
		//检测批示意见等
		if(!parent.checkEzFlowBack()){
			return false;
		}
		var url="<%=rootPath%>/ezflowbuttonevent!backProcess.action"; 
		$("#dataForm",parent.document.body).attr("action",url);
		parent.setCallBackName("");
		//设置按钮不可用
        $("#back_button").attr("disabled", "disabled"); 

		parent.parentSumbit();
	 }

      //""  p_wf_button_backRange
      var p_wf_button_backRange_val=$("#p_wf_button_backRange",parent.document.body).val();
	  if(p_wf_button_backRange_val=="1"){
	       $('input:radio[name="temp_backEmailRemindType"]').eq(1).attr("checked",'checked'); 
	  }else{
		   $('input:radio[name="temp_backEmailRemindType"]').eq(0).attr("checked",'checked'); 
	  }

	 
       
 
</script>
</html>
 