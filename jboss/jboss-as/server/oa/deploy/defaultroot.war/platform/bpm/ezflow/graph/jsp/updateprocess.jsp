<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.whir.org.manager.bd.ManagerBD"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%

  String processId=request.getParameter("processId")+"";
  String tableId=request.getParameter("tableId")+""; 

  String dealedActivityIds=request.getParameter("dealedActivityIds")+"";
  String activity=request.getParameter("activity")+"";
  String recordId=request.getParameter("recordId")+"";

  String subType=request.getParameter("subType")+"";
  
  String rightCode="02*02";	
  String moduleId=request.getParameter("moduleId")==null?"1":request.getParameter("moduleId").toString();
  
  com.whir.ezoffice.workflow.newBD.ModuleBD moduleBD = new com.whir.ezoffice.workflow.newBD.ModuleBD();
  com.whir.ezoffice.workflow.vo.ModuleVO moduleVO = moduleBD.getModule(Integer.parseInt(moduleId));
  	
  if (moduleVO!=null&&moduleVO.isProcRight()) { 	
	  rightCode = moduleVO.getProcRightType();
  }  
 
  String processType=request.getParameter("processType")==null?"1":request.getParameter("processType").toString();
  

  String processDefId=request.getParameter("processDefId")==null?"-1":request.getParameter("processDefId").toString();

  ManagerBD managerBD = new ManagerBD();
  boolean setRight=managerBD.hasRight(session.getAttribute("userId").toString(), rightCode);

  	 //表明是临时修改 流程设置 ，流程发起时的修改流程设置
  if(processId!=null&&!processId.equals("-1")&&!processId.equals("")&&processDefId!=null&&!processDefId.equals("-1")&&!processDefId.equals("")){
	   setRight=true;
  }
  //是
  if(!setRight){
     response.sendRedirect(com.whir.component.config.PropertiesUtil.getInstance().getRootPath()+"/login.jsp");
  }
  
    
  String _local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
  String  d_whir_ezflow=com.whir.i18n.Resource.getValue(_local, "workflow", "workflow.d_whir_ezflow");
  //20160311 -by jqq 安全性漏洞改造
  subType = com.whir.component.security.crypto.EncryptUtil.htmlcode(subType);
 /* if(null!= subType && !"".equals(subType) && !"null".equals(subType)){
	subType = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(subType);
  }*/
  recordId = com.whir.component.security.crypto.EncryptUtil.htmlcode(recordId);
  /*if(null!= recordId && !"".equals(recordId) && !"null".equals(recordId)){
	recordId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(recordId);
  }*/
  activity = com.whir.component.security.crypto.EncryptUtil.htmlcode(activity);
 /* if(null!= activity && !"".equals(activity) && !"null".equals(activity)){
	activity = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(activity);
  }*/
  dealedActivityIds = com.whir.component.security.crypto.EncryptUtil.htmlcode(dealedActivityIds);
 /* if(null!= dealedActivityIds && !"".equals(dealedActivityIds) && !"null".equals(dealedActivityIds)){
	dealedActivityIds = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(dealedActivityIds);
  }*/
  processId = com.whir.component.security.crypto.EncryptUtil.htmlcode(processId);
  /*if(null!= processId && !"".equals(processId) && !"null".equals(processId)){
	processId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(processId);
  }*/
  tableId = com.whir.component.security.crypto.EncryptUtil.htmlcode(tableId);
  /*if(null!= tableId && !"".equals(tableId) && !"null".equals(tableId)){
	tableId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(tableId);
  }*/
  processType = com.whir.component.security.crypto.EncryptUtil.htmlcode(processType);
 /* if(null!= processType && !"".equals(processType) && !"null".equals(processType)){
	processType = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(processType);
  }*/
  processDefId = com.whir.component.security.crypto.EncryptUtil.htmlcode(processDefId);
 /* if(null!= processDefId && !"".equals(processDefId) && !"null".equals(processDefId)){
	processDefId = com.whir.component.security.crypto.EncryptUtil.replaceHtmlcode(processDefId);
  }*/
%>
<html xmlns:v="urn:schemas-microsoft-com:vml">
	<head>
		<title><%=d_whir_ezflow%></title>
		<meta http-equiv="keywords" content="xio">
		<meta http-equiv="keywords" content="WorkFlow xio javascript">
		<meta http-equiv="description" content="XiorkFlow is a WorkFlow Designer based javascript.">
		<meta http-equiv="copyright" content="Copyright &copy;2006 www.xio.name">
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv=X-UA-Compatible content=IE=EmulateIE7>
		<%@ include file="workflow_header.jsp"%>  
		<script charset="UTF-8" src="<%=rootPath%>/platform/bpm/ezflow/graph/whirflow/js/XiorkFlowWorkSpace.js" language="javascript"></script>
		<script charset="UTF-8" src="updateprocess.js" language="javascript"></script>
		<SCRIPT LANGUAGE="JavaScript">
		<!--
			function refreshListForm_(fromId){
			
			}
		//-->
		</SCRIPT>
	</head>
	<body onload="initPara('<%=processId%>','<%=tableId%>','<%=moduleId%>','<%=recordId%>','<%=subType%>','<%=processType%>','<%=processDefId%>')" onselectstart="return false;" style="margin: 0px;overflow:hidden">
		<div id="designer" style="width: 99%;height: 99%;border: #e0e0e0 1px solid;"></div>
	</body>
</html>
