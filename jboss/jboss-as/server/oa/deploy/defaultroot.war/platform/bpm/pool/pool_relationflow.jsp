<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.whir.i18n.Resource"%>
<%@page import="java.util.*"%>
<%
 
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString(); 

com.whir.component.security.crypto.EncryptUtil  eutil=new com.whir.component.security.crypto.EncryptUtil(request);


String  openType=request.getParameter("openType")==null?"":request.getParameter("openType").toString();


String n_moduleId=request.getParameter("p_wf_moduleId")==null?"1":request.getParameter("p_wf_moduleId").toString();
String n_recordId=request.getParameter("p_wf_recordId")==null?"-1":request.getParameter("p_wf_recordId").toString();

String  nowProcessInstanceId=request.getParameter("processInstanceId")==null?"-1":request.getParameter("processInstanceId").toString();
 
if(n_recordId.equals("")||n_recordId.equals("null")){
     n_recordId="-1";
}
com.whir.ezoffice.bpm.bd.BPMRelationBD  bpmRelationBD=new com.whir.ezoffice.bpm.bd.BPMRelationBD();
 
List poolRelationnList=bpmRelationBD.findRelationProcess(new Integer(n_moduleId),new Long(n_recordId));

List ezFlowList=new ArrayList();
if(nowProcessInstanceId!=null&&!nowProcessInstanceId.equals("-1")&&!nowProcessInstanceId.equals("")&&!nowProcessInstanceId.equals("")){
    ezFlowList= bpmRelationBD.findEzFlowRelationProcess(nowProcessInstanceId);
}
com.whir.ezflow.util.EzFlowDateUtil ezFlowDateUtil=new com.whir.ezflow.util.EzFlowDateUtil();
com.whir.component.security.crypto.EncryptUtil encryptUtil =new com.whir.component.security.crypto.EncryptUtil(request);
 
%>
<html>
<head>
	<title>标准列表页面结构</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body bgcolor="#ffffff">

<%
//父流程 子流程相关  不可删除
java.util.List listRelationWork = new java.util.ArrayList(); 

String processId=request.getParameter("p_wf_processId")+"";
String tableId=request.getParameter("p_wf_tableId")+""; 
String workId=request.getParameter("p_wf_workId")+""; 
String curUserId=session.getAttribute("userId")+"";
if (n_recordId!= null&&!n_recordId.equals("")&&!n_recordId.equals("null")&&eutil.isInteger(processId)&&eutil.isInteger(tableId)&&eutil.isInteger(workId)) {
	listRelationWork = new com.whir.ezoffice.workflow.newBD.WorkFlowServiceBD().getAllRelationWork(processId,tableId,n_recordId,workId,curUserId);
}
 
int  relationSize=0;
%>
<div>&nbsp;</div>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="SubTable"  id="relationTable" >
  <tr class="subTitle">
    <td><bean:message bundle="filetransact" key="file.suborg"/><!-- 报送单位 --></td>
    <td width="15%" nowrap><bean:message bundle="filetransact" key="file.subtime"/><!-- 报送时间 --></td>
    <td  width="35%" nowrap><bean:message bundle="workflow" key="workflow.Title"/><!-- 标题 --></td>
    <td><bean:message bundle="workflow" key="workflow.ProcessStatus"/><!-- 办理状态 --></td>
    <td><!-- 报送人 --><!--bean:message bundle="workflow" key="workflow.ProcessPerson"/--><bean:message bundle="filetransact" key="file.people"/></td>
	 <td><!-- 报送人 --><!--bean:message bundle="workflow" key="workflow.ProcessPerson"/--><bean:message bundle="common" key="comm.opr" /></td>
  </tr>

  <%
  if (listRelationWork != null && listRelationWork.size() > 0) {
	  for (int i = 0; i < listRelationWork.size(); i++) {
		 String[] rWork = (String[]) listRelationWork.get(i);
		 relationSize++;
  %>
	<tr>
		<td class="subTitleList" ><%=rWork[0]%></td>
		<td class="subTitleList" ><%=rWork[1]%></a></td>
		<td class="subTitleList" >
		   <a href="javascript:"
			onclick="javascript:relationOpen_this(encodeURI('<%=rWork[5]%>'));"><%=rWork[2]%>
		</td>
		<td class="subTitleList" ><%=rWork[3]%>&nbsp;</td>
		<td class="subTitleList" ><%=getCurEmpName(rWork[6],rWork[7])%></td>
		<td class="subTitleList" >&nbsp;</td>
	</tr>
 <%
	 }
  }
 %>


  <%
	  //父流程 子流程
	  if(ezFlowList!=null&&ezFlowList.size()>0){
		  for(int i=0;i<ezFlowList.size();i++){
		      Object[] rWork=(Object[])ezFlowList.get(i);
		      relationSize++;
			  String  pId=""+rWork[0];
			  String  verifyCode=encryptUtil.getSysEncoderKeyVlaue("p_wf_processInstanceId", pId, "WFDealWithAction");
		  %>
		  <tr >
			<td class="subTitleList"><%=rWork[3]%></td>
			<td class="subTitleList" ><%=ezFlowDateUtil.covertTimestampToStr(rWork[4])%></a></td>
			<td class="subTitleList"><a href="#" onclick="openEzFlowWorkFlow('<%=pId%>','<%=verifyCode%>','<%=rWork[9]%>','<%=rWork[1]%>')"><%=rWork[5]%></td>
			<td class="subTitleList"><%=rWork[7]%></td>
			<td class="subTitleList"><%=rWork[8]%>&nbsp</td>
			<td class="subTitleList">&nbsp;</td>
		  </tr>
  <% 
	    }
	}
  %>
  <%
	   String startOrg="";
	   String startTime="";
	   String title="";
	   String nowActivitys="";
	   String pId="";
	   String nowStauts="";
	   String nowUsers="";
	   String strartUser="";
	   String busnessKey="";
	   String pr_pId="";
	   String pr_r_pId=""; 
	   String verifyCode="";
	   Object [] robj=null;
	   String realtionId="";
	   String moduelId=""; 
	   //相关流程
	   if(poolRelationnList!=null&&poolRelationnList.size()>0){
		   for(int i=0;i<poolRelationnList.size();i++){
			 robj=(Object [])poolRelationnList.get(i); 
			 startOrg=robj[0]==null?"&nbsp;":robj[0].toString();
			 strartUser=robj[4]==null?"&nbsp;":robj[4].toString();
			 title=robj[2]==null?"&nbsp;":robj[2].toString();
			 nowActivitys=robj[3]==null?"&nbsp;":robj[3].toString();
			 nowUsers=robj[7]==null?"&nbsp;":robj[7].toString();
			 nowStauts=robj[5]==null?"":robj[5].toString(); 
             startTime=ezFlowDateUtil.covertTimestampToStr(robj[1]);	 
			 if(startTime==null||startTime.equals("")){
			     startTime=robj[1]+"";
			 }
			 busnessKey=robj[8]==null?"":robj[8].toString();
			 moduelId=robj[6]==null?"":robj[6].toString();
			 realtionId=robj[13]==null?"":robj[13].toString();
			 /*pId=rMap.get("PROC_INST_ID_").toString();		
             pr_pId=rMap.get("PR_PID").toString();
			 pr_r_pId=rMap.get("PR_R_PID").toString();	*/	 
			 //办理完毕
			 if(nowStauts.equals("100")){
			     nowActivitys=Resource.getValue(local, "workflow", "workflow.Transacted");//"办理完毕";
                 nowUsers="&nbsp;"; 
			 }  
			 if(nowStauts.equals("-1")){
			    nowActivitys=Resource.getValue(local, "workflow", "workflow.Return");//"退回";
				nowUsers="&nbsp;"; 
			 }
			 if(nowStauts.equals("-2")){
				nowActivitys=Resource.getValue(local, "workflow", "workflow.Cancel");//"取消";
				nowUsers="&nbsp;"; 
			 }
			 if(nowStauts.equals("-3")){
				nowActivitys=Resource.getValue(local, "workflow", "workflow.newactivitybuttondelete");//"作废";
				nowUsers="&nbsp;"; 		 
			 }
			 if(nowStauts.equals("-4")){
			    nowActivitys=Resource.getValue(local, "workflow", "workflow.Return");//"退回";
				nowUsers="&nbsp;"; 
			 }  
			 verifyCode=encryptUtil.getSysEncoderKeyVlaue("p_wf_recordId", busnessKey, "WFDealWithAction");
		     relationSize++;
	  %>
		  <tr  id="TR_<%=pId%>">
			<td class="subTitleList"><%=startOrg%></td>
			<td class="subTitleList"><%=startTime%></td>
			<td class="subTitleList"><a href="javascript:bpmopenWorkFlow('<%=busnessKey%>','<%=moduelId%>','<%=verifyCode%>')"> <%=title%></a></td>
			<td class="subTitleList"><%=nowActivitys%>&nbsp</td>
			<td class="subTitleList"><%=nowUsers%>&nbsp;</td>
			<td style="display:" class="subTitleList"><%if(openType!=null&&(openType.equals("waitingDeal")||openType.equals("fromDraft")||openType.equals("reStart")||openType.equals("startAgain"))){%><img src="<%=rootPath%>/images/del.gif" onclick="delRelationWork('<%=realtionId%>');" style="cursor:hand" title="<bean:message bundle="common" key="comm.sdel"/>"><%}%>&nbsp; 
			<input type="hidden" name="relation_moduelId_record" value="<%=moduelId%>,<%=busnessKey%>">
			<input type="hidden" name="relationIdStr" value="<%=moduelId%>,<%=busnessKey%>">
			</td>  
		  </tr>
  <%  }   
	}
  %>
</table> 
<input type="hidden" id="p_wf_relationallsize" name="p_wf_relationallsize" value="<%=relationSize%>">
</body>
<SCRIPT LANGUAGE="JavaScript">
<!--
 function  relationOpen_this(url){	   
	 openWin({url:url,width:880,height:600,winName:''});
 }
//打开流程
function  bpmopenWorkFlow(busnessKey,moduelId, verifyCode ){
    var openurl="<%=rootPath%>/bpmopen!nourlopen.action?p_wf_moduleId="+moduelId+"&verifyCode="+verifyCode+"&p_wf_recordId="+busnessKey+"&p_wf_openType=relation";	 
	openWin({url:openurl,width:850,height:750,isFull:true,winName:'openWorkFlow'+busnessKey});
}
 
//打开流程
function  openEzFlowWorkFlow( ezFlowProcessInstanceId,ezFlowProcessInstanceId_verifyCode,mainUrl,recordId){

	if(mainUrl==null||mainUrl==""){
		mainUrl="<%=rootPath%>/ezflowopen!updateProcess.action?";
	}else{
		if(mainUrl.indexOf("?")<0){
			mainUrl+="?";
		}else{
			mainUrl+="&";
		}
		
	}
	if(mainUrl.indexOf("<%=rootPath%>")<0){
		mainUrl="<%=rootPath%>"+mainUrl;
	}
    var openurl=mainUrl+"p_wf_processInstanceId="+ezFlowProcessInstanceId+"&verifyCode="+ezFlowProcessInstanceId_verifyCode+"&p_wf_openType=relation&p_wf_recordId="+recordId;	

	openWin({url:openurl,width:850,height:750,isFull:true,winName:'openWorkFlow'+ezFlowProcessInstanceId});
} 
//中间环节关联删除
function delRelationWork(realtionId){  
	var url="<%=rootPath%>/wfoperate!delBpmRelationWork.action?relationId="+realtionId;
    var html = $.ajax({url: url,async: false}).responseText;  	
	whir_alert("<%=Resource.getValue(local,"workflow","workflow.deleteSuccess")%>",function(){});
	refreshRelation();
}


/**
新增流程删除相关附件
*/
function  delRelationProcess_add(obj){
	$(obj).parent().parent().remove();
}
//-->
</SCRIPT>
</html>
<%!
public String getCurEmpName(  String tableId, String recordId) {
	com.whir.common.util.DataSourceBase dsb = new com.whir.common.util.DataSourceBase();
	javax.sql.DataSource ds = dsb.getDataSource();
	java.sql.Connection conn = null;
	java.sql.Statement stmt = null;
	StringBuffer empNameStr = new StringBuffer();
	try{
		conn = ds.getConnection();
		stmt = conn.createStatement();
		String sql = "select empname,TRANTYPE from org_employee,wf_work where emp_id=wf_curemployee_id and workstatus=0 and worklistcontrol=1   and worktable_id=" + tableId + " and workrecord_id=" + recordId; 
		 
		java.sql.ResultSet rs = stmt.executeQuery(sql);
		while(rs.next()){ 
			empNameStr.append(rs.getString(1) + " ");  
		}
		rs.close();
	}catch(Exception e){

	}finally{
		try{
			stmt.close();
			conn.close();
		}catch(java.sql.SQLException ex){}

	}
	return empNameStr.toString();
}
%> 