<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.whir.i18n.Resource"%>
<%@page import="java.util.*"%>
<%String rootPath="/defaultroot";
 String localcmd = session.getAttribute("org.apache.struts.action.LOCALE").toString();
 
%>
<style>
 .workflowBtnbox a:link {
	                     color:#333;
                         font-size:14px; 
						 text-decoration:none;
					    }
 .workflowBtn a:link{
	                    color:#333;  font-size:14px; 
						text-decoration:none;
					    }

</style>
<!--style="position:relative;z-index:1"-->
<div  id="popToolbar" >
<div id="commandBar">
<table width="96%" border="0"  cellpadding="0" cellspacing="0" id="commandBarTable">
  <tr valign="top">
    <td  style="text-align:left" >
    <div class="workflowBtnbox" id="workflowBtnbox"></div>
    </td>
    <td width="150">       
     <div class="open_menu" id="open_menu" ><img src="/defaultroot/images/toolbar/open_menu.gif" width="24" height="23" />
		 <div class="work_submenu" id="work_submenu"></div>
     </div>   
     <script>
		 $(document).ready(function(){
		  $('.open_menu').mousemove(function(){
		       $(this).find('.work_submenu').show();
		  });
		  $('.open_menu').mouseleave(function(){
		       $(this).find('.work_submenu').slideUp("fast");
		  });  
		});
	</script> 
    <div class="workflowClose">
        <a href="#" class="workflowBtn"  onclick="cmdClose();"><span class="imgIco"><img src="/defaultroot/images/toolbar/close.png" /></span><%=Resource.getValue(localcmd,"common","comm.Close")%></a>
    </div>
</td>
  </tr>
</table>
</div></div>
 <%
  String usedWhirButtonsIds=request.getParameter("usedWhirButtonsIds")==null?"":request.getParameter("usedWhirButtonsIds").toString();
  if(request.getAttribute("p_wf_modiButton")!=null){
      if(usedWhirButtonsIds==null||usedWhirButtonsIds.equals("")){
		  usedWhirButtonsIds=request.getAttribute("p_wf_modiButton").toString();
	  }
  }

  //自定义按钮的函数
  String p_wf_extButtonFunContent=request.getAttribute("p_wf_extButtonFunContent")==null?"":request.getAttribute("p_wf_extButtonFunContent").toString();

  if(p_wf_extButtonFunContent.equals("null")){
      p_wf_extButtonFunContent="";
  }

 %>
 <%@ include file="/public/toolbar/initButton.jsp"%>
 <SCRIPT LANGUAGE="JavaScript">
 <!--
	try{
		whirToolbar.showToolbar();
	}catch(e){
	}
	function  cmdClose(){
		whir_confirm(workflowMessage_js.confirmclose+'？', function (){  
			var isEzflow =$('#p_wf_pool_processType').val();
			//alert("isEzflow:"+isEzflow);
			//删除锁
			if(isEzflow =='1'){//ezflow
				$.ajax({
					url: '/defaultroot/platform/bpm/ezflow/operation/ezflow_myflow_close.jsp?p_wf_recordId='+$("#p_wf_recordId").val()+'&p_wf_formKey='+$("#p_wf_formKey").val()+'&p_wf_processInstanceId='+$("#p_wf_processInstanceId").val()+'&p_wf_taskId='+$("#p_wf_taskId").val(),
					async: false,cache: false
				});
			}else{
				$.ajax({
					url: '/defaultroot/platform/bpm/work_flow/operate/wf_close.jsp?p_wf_recordId='+$("#p_wf_recordId").val()+'&p_wf_tableId='+$("#p_wf_tableId").val()+'&p_wf_processId='+$("#p_wf_processId").val()+'&p_wf_workId='+$("#p_wf_workId").val(),
					async: false,cache:false
				});
			}
		    window.close();
		});  
	}
	<%=p_wf_extButtonFunContent%>
 //-->
</SCRIPT>
<div class="docMargintop"></div>