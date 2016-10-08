<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.whir.i18n.Resource"%>
<%@page import="java.util.*"%>
<%   
    String ezflowBusinessKey=request.getParameter("p_wf_recordId")==null?"":request.getParameter("p_wf_recordId").toString();
    String whir_formKey     =request.getParameter("p_wf_formKey")==null?"":request.getParameter("p_wf_formKey").toString();
    String processInstanceId=request.getParameter("p_wf_processInstanceId")==null?"":request.getParameter("p_wf_processInstanceId").toString();
    String taskId           =request.getParameter("p_wf_taskId")==null?"":request.getParameter("p_wf_taskId").toString();
	String userAccount      =session.getAttribute("userAccount")==null?"":session.getAttribute("userAccount").toString();
    Map onlieMap=new HashMap();
	
	onlieMap.put("businessKey", ezflowBusinessKey);
	onlieMap.put("formKey", whir_formKey);
	onlieMap.put("processInstanceId", processInstanceId);
	onlieMap.put("taskId", taskId);	
	onlieMap.put("userAccount", userAccount);	
    //½âËø
	com.whir.service.api.ezflowservice.EzFlowMainService  mainSercice=new com.whir.service.api.ezflowservice.EzFlowMainService();
	mainSercice.delEzFlowOnlineUser(onlieMap); 
%>