<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	String processDefinitionId=EncryptUtil.htmlcode(request,"processDefinitionId"); //request.getParameter("processDefinitionId")==null?"":request.getParameter("processDefinitionId").toString();
	String processInstanceId=EncryptUtil.htmlcode(request,"processInstanceId");// request.getParameter("processInstanceId")==null?"":request.getParameter("processInstanceId").toString();
	String ezflowBusinessKey=EncryptUtil.htmlcode(request,"ezflowBusinessKey");//request.getParameter("ezflowBusinessKey")==null?"":request.getParameter("ezflowBusinessKey").toString();
	String whir_formKey=EncryptUtil.htmlcode(request,"whir_formKey");//request.getParameter("whir_formKey")==null?"":request.getParameter("whir_formKey").toString();
	String whir_stauts=EncryptUtil.htmlcode(request,"whir_stauts");//request.getParameter("whir_stauts")==null?"":request.getParameter("whir_stauts").toString();
	
	com.whir.service.api.ezflowservice.EzFlowMainService  mainService=new com.whir.service.api.ezflowservice.EzFlowMainService();
	
	String p_wf_whir_dealedActInfo=EncryptUtil.htmlcode(request,"p_wf_whir_dealedActInfo"); 
	
	List  dealingList=mainService.findDealingActivity(processInstanceId);
	
	
	//&dealedActivityIds="+dealedActivityIds+"&activity="+activity;
	com.whir.ezflow.vo.ChoosedActivityVO  vo=null;
	String dealedActivityIds="";
	String nowActivityIds="";
	
	String dealedActivityIds_="";
	List  dealedList=mainService.findDealedActivity_real(processInstanceId);
	if(dealedList!=null&&dealedList.size()>0){
		for(int i=0;i<dealedList.size();i++){
			vo=(com.whir.ezflow.vo.ChoosedActivityVO)dealedList.get(i);
			dealedActivityIds_+="$"+vo.getActivityId()+"$";
		}
	} 
	
	dealedActivityIds=mainService.findDealedActivityStrs(processInstanceId,dealedActivityIds_);
	
	dealedActivityIds=dealedActivityIds+p_wf_whir_dealedActInfo;

	if(whir_stauts.equals("100")){
		dealedActivityIds+="$startevent1$";
		dealedActivityIds+="$endevent1$";
	} 
	
	if(!whir_stauts.equals("")){
		//dealedActivityIds+="$startevent1$";
	} 
	
	if(dealingList!=null&&dealingList.size()>0){
		for(int i=0;i<dealingList.size();i++){
			vo=(com.whir.ezflow.vo.ChoosedActivityVO)dealingList.get(i);
			nowActivityIds+="$"+vo.getActivityId()+"$";
 		}
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body >
<div>&nbsp;</div>
<table width="100%" height="100%" border="0" cellpadding="3" cellspacing="0">
  <tr><td>流程图节点颜色说明：<font color="#0098FE">蓝色</font>（未经过的节点），<font color="#8F8F8F">灰色</font>（已经办理过的节点），<font color="#8DCE3C">绿色</font>（当前所处节点），<font color="#8DCE3C">绿色+ 眼睛图标</font>（已查看但尚未办理的节点）</td></tr>
  <tr>
     <td>
	    <%
		   String url=rootPath+"/platform/bpm/ezflow/graph/jsp/viewprocess.jsp?recordId="+processDefinitionId+"&dealedActivityIds="+dealedActivityIds+"&activity="+nowActivityIds+"&p_wf_processInstanceId="+processInstanceId+"&dealedActivityIds_="+dealedActivityIds_;
	    %>
        <iframe   id="flowImageFrame"  src="<%=url%>"  allowTransparency="true"    frameborder="0"  style="width:100%;height:700px" ></iframe>	
     </td>
 </tr>
</table>
</body>
</html>
 