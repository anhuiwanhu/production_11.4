<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page isELIgnored ="false" %>
<%@ page import="com.whir.govezoffice.documentmanager.bd.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
com.whir.org.manager.bd.ManagerBD mbd = new com.whir.org.manager.bd.ManagerBD();
int menuIndex=0;
String portletSettingId = request.getParameter("portletSettingId");
String expNodeCode = request.getParameter("expNodeCode");
//此处公共业务逻辑
%>
	<%
		//新老工作流引擎 0使用ezFLOW引擎 1仅使用老引擎
		String workflowType = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("workflowType", (String)request.getSession().getAttribute("domainId"));
	
		Object [] baseObj=(Object[]) new SenddocumentBD().getSenddocumentBaseInfo();
		String [] numObj=null;
		if(baseObj!=null&&baseObj[6]!=null&&!baseObj[6].toString().equals("")){
			numObj=baseObj[6].toString().split(";");
		}
		String numTypeStr = "";
		String numIdStr = "";
		if(numObj!=null&&numObj.length>0){
			for(int i=0;i<numObj.length;i++){
				String numType=numObj[i];		 
			    List numList=new SenddocumentBD().getSendNumByNumClass(numType);
				if(numList!=null&&numList.size()>0){
					numTypeStr+=numType + ",";
	
					for(int j=0;j<numList.size();j++){
						com.whir.govezoffice.documentmanager.po.SendDocumentNumPO numPO=(com.whir.govezoffice.documentmanager.po.SendDocumentNumPO) numList.get(j);
						String numId = numPO.getId()+"";
						String numTitle = numPO.getNumName();
						numIdStr += numType + "$$" + numId + "$$" + numTitle + ",";
					}
				}
			}
		}
		if(!"".equals(numTypeStr)){
			numTypeStr = numTypeStr.substring(0,numTypeStr.length()-1);
		}
		if(!"".equals(numIdStr)){
			numIdStr = numIdStr.substring(0,numIdStr.length()-1);
		}
		String[] numTypeStrArray =  new String[0];
	
		if(!"".equals(numTypeStr)){
			numTypeStrArray=numTypeStr.split(",");
		}
		String[] numIdStrArray =  new String[0];
		if(!"".equals(numIdStrArray)){
			numIdStrArray=numIdStr.split(",");
		}
		//Object tmp=null;
	%>
    <SCRIPT type="text/javascript">  
		var zNodes = [
			<%
				com.whir.ezoffice.bpm.bd.BPMProcessBD procbd = new com.whir.ezoffice.bpm.bd.BPMProcessBD();
				String curUserId = request.getSession(true).getAttribute("userId") + "";
				String orgIdString = request.getSession(true).getAttribute("orgIdString")+"";
				List tmp = procbd.getUserProcessListWithNoPackage(curUserId,orgIdString,null,"2",null);
				long id=1000000012;
			%>
			<c:if test="${fn:contains(canShowMenus,'documentmanager_mydocument')}">
			{ id:-11, pId:-1, name:"我的收文", open:true,iconSkin:"fa fa-cog fa"},
			
			{ id:1000000000, pId:-11, name:"未读收文", expNodeCode:"notRead", url:"<%=rootPath%>/GovRecvDocSet!notRead.action", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:1000000001, pId:-11, name:"所有收文", url:"<%=rootPath%>/GovRecvDocSet!myReceive.action", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:1000000002, pId:-11, name:"按文号分类显示", url:"", target:'mainFrame',iconSkin:"fa fa"}
			
			<%
			for( int i = 0;i< numTypeStrArray.length;i++){
			%>
			,{ id:<%=id+10000%>, pId:1000000002, name:"<%=numTypeStrArray[i]%>", url:"<%=rootPath%>/GovDocSend!handoutFileList.action?numType=<%=java.net.URLEncoder.encode(numTypeStrArray[i],"UTF-8") %>", target:'mainFrame',iconSkin:"fa fa"}	 
			<%	
			for( int j = 0;j< numIdStrArray.length;j++){
			  String[] tempa = numIdStrArray[j].split("\\$\\$");
			  if(tempa[0].equals(numTypeStrArray[i]) && tempa.length > 2 ){
			%>
			,{ id:<%=id+100000%>, pId:<%=id+10000%>, name:"<%=tempa[2]%>", url:"<%=rootPath%>/GovDocSend!handoutFileList.action?numId=<%=tempa[1]%>", target:'mainFrame',iconSkin:"fa fa"}	 
			<%		  }
			}
			id++;
			}
			%>
			,{ id:1000000003, pId:-11, name:"按状态分类显示", url:"", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:10000000031, pId:1000000003, name:"未处理收文", url:"<%=rootPath%>/GovRecvDocSet!isNotHandle.action", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:10000000032, pId:1000000003, name:"已处理收文", url:"<%=rootPath%>/GovRecvDocSet!isHandle.action", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:10000000033, pId:1000000003, name:"无需处理收文", url:"<%=rootPath%>/GovRecvDocSet!notHandle.action", target:'mainFrame',iconSkin:"fa fa"}
			</c:if>
			<%
				menuIndex++;
				boolean displaysw = true;
				if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){
			%>
			<c:if test="${fn:contains(canShowMenus,'documentmanager_sendfile')}">
				<c:if test="${fn:contains(canShowMenus,'documentmanager_mydocument')}">
			        ,{ id:-12, pId:-1, name:"发文管理",iconSkin:"fa fa-cog fa"}
			        <%displaysw = false;%>
			    </c:if>
			 <%if(displaysw){%>
			 	{ id:-12, pId:-1, name:"发文管理",iconSkin:"fa fa-cog fa"}
			 <%}%>
			,{ id:1000000004, pId:-12, name:"新建发文", click:"", target:'_blank',iconSkin:"fa fa"}
			<%
			 tmp = procbd.getUserProcessListWithNoPackage(curUserId,orgIdString,null,"2",null);
			 if (null != tmp) {
				 List list = (List) tmp;
				 for(int i = 0; i < list.size(); i++){
				  Object[] rfObj = (Object[])list.get(i);
				  String processId = rfObj[0] + "" ;
				  String processName = rfObj[1] + "";
				  String processType = rfObj[2] + "";
				  String tableId = rfObj[4] + "";
				  if( "1".equals(processType)){
						 tableId = rfObj[6] + "";
						 if(tableId.length() > 5){
							tableId = tableId.substring(5);
						 }
				  }
				  String remindField = rfObj[6]==null?"":rfObj[6]+"";
			%>
			,{ id:<%=processId%>, pId:1000000004, name:"<%=processName%>",click:"openWin({url:'<%=rootPath%>/GovDocSendProcess!newDoc.action?p_wf_pool_processId=<%=processId%>&p_wf_processType=<%=processType%>',isFull:'false',winName:'govworkflow'})" ,url:'',iconSkin:"fa fa"}
			<%
				 }
			}
			%>
		    ,{ id:1000000005, pId:-12, name:"草稿箱", url:"<%=rootPath%>/GovDocSend!listDraft.action", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:1000000006, pId:-12, name:"经办文件查阅", expNodeCode:"sendFile", url:"<%=rootPath%>/GovDocSend!handlingFileList.action", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:1000000007, pId:-12, name:"分发文件查阅", expNodeCode:"ffFile", url:"<%=rootPath%>/GovDocSend!handoutFileList.action?toMe=1", target:'mainFrame',iconSkin:"fa fa"}
			<%if(null != request.getAttribute("sendFileSee") && "1".equals(request.getAttribute("sendFileSee")+"")){%>
				,{ id:1000000008, pId:-12, name:"办理查阅", url:"<%=rootPath%>/GovDocSend!sendFileList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000081, pId:1000000008, name:"所有文件", url:"<%=rootPath%>/GovDocSend!sendFileList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000082, pId:1000000008, name:"在办文件", url:"<%=rootPath%>/GovDocSend!sendFileList.action?queryStatus=0", target:'mainFrame',iconSkin:"fa fa"}
			    ,{ id:10000000083, pId:1000000008, name:"办结文件", url:"<%=rootPath%>/GovDocSend!sendFileList.action?queryStatus=1", target:'mainFrame',iconSkin:"fa fa"}
			<%  id=10000;
				for( int i = 0;i< numTypeStrArray.length;i++){
			%>
				 ,{ id:<%=id%>, pId:10000000082, name:"<%=numTypeStrArray[i]%>", url:"", target:'mainFrame',iconSkin:"fa fa"}	 
				 ,{ id:<%=id+10000%>, pId:10000000083, name:"<%=numTypeStrArray[i]%>", url:"", target:'mainFrame',iconSkin:"fa fa"}	 
			<%	
				 for( int j = 0;j< numIdStrArray.length;j++){
					  String[] tempa = numIdStrArray[j].split("\\$\\$");
					  if(tempa[0].equals(numTypeStrArray[i]) && tempa.length > 2 ){
			%>
				 ,{ id:<%=id+100000%>, pId:<%=id%>, name:"<%=tempa[2]%>", url:"<%=rootPath%>/GovDocSend!sendFileList.action?queryStatus=0&numId=<%=tempa[1]%>", target:'mainFrame',iconSkin:"fa fa"}	 
				 ,{ id:<%=id+100001%>, pId:<%=id+10000%>, name:"<%=tempa[2]%>", url:"<%=rootPath%>/GovDocSend!sendFileList.action?queryStatus=1&numId=<%=tempa[1]%>", target:'mainFrame',iconSkin:"fa fa"}	 
			<%		  }
				}
				id++;
			 }
			 }
			%>
			<%if(null !=request.getAttribute("sendFileFlowSetting") && "1".equals(request.getAttribute("sendFileFlowSetting") + "")){%>
				,{ id:1000000009, pId:-12, name:"发文设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000091, pId:1000000009, name:"机关代字设置", url:"<%=rootPath%>/GovDocSet!sendFileWordList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000092, pId:1000000009, name:"文号设置", url:"<%=rootPath%>/GovDocSet!sendFileNumList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000093, pId:1000000009, name:"流水号设置", url:"<%=rootPath%>/GovDocSet!sendFileSeqList.action", target:'mainFrame',iconSkin:"fa fa"}
			    ,{ id:10000000094, pId:1000000009, name:"文件类别", url:"<%=rootPath%>/GovDocSet!sendFileFileTypeList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000095, pId:1000000009, name:"模板设置", url:"<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?moduleType=govdocument&haveRight=yes", target:'_blank',iconSkin:"fa fa"}
				<%if("2".equals(workflowType) || "1".equals(workflowType) || "".equals(workflowType) ){%>
				,{ id:10000000096, pId:1000000009, name:"流程设置", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=2", target:'mainFrame',iconSkin:"fa fa"}
				<%}%>
				<%if("2".equals(workflowType) || "0".equals(workflowType) || "".equals(workflowType)  ){%>
				,{ id:10000000097, pId:1000000009, name:"流程设置(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=2", target:'mainFrame',iconSkin:"fa fa"}
				<%}%>
				,{ id:10000000098, pId:1000000009, name:"快速发文", url:"<%=rootPath%>/GovDocSet!fastDocSet.action?moduleId=2", target:'mainFrame',iconSkin:"fa fa"}
			    ,{ id:10000000099, pId:1000000009, name:"签章设置", url:"<%=rootPath%>/public/iWebOfficeSign/Signature/SignatureList.jsp", target:'_blank',iconSkin:"fa fa"}
				,{ id:100000000910, pId:1000000009, name:"表单设置", url:"<%=rootPath%>/GovCustom!formList.action?govFormType=0", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:100000000911, pId:1000000009, name:"分发单位", url:"<%=rootPath%>/GovDocSet!sendFileIssueUnitList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:100000000912, pId:1000000009, name:"组织公文员", url:"<%=rootPath%>/GovDocSet!sendFileDocAssistantList.action", target:'mainFrame',iconSkin:"fa fa"}
			<%}%>
			<%	if(mbd.hasRight(session.getAttribute("userId").toString(),"03*15*86")){%>	
				,{ id:1000000011, pId:-12, name:"基础设置", url:"", target:'mainFrame',iconSkin:"fa fa-cog fa"}
				,{ id:10000000111, pId:1000000011, name:"主题词设置", url:"<%=rootPath%>/GovDocSet!topicList.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000112, pId:1000000011, name:"标签设置", url:"<%=rootPath%>/public/iWebOfficeSign/BookMark/BookMarkList.jsp?haveRight=yes&moduleType=govdocument", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000113, pId:1000000011, name:"参数设置", url:"<%=rootPath%>/GovDocSet!listBaseInfo.action", target:'mainFrame',iconSkin:"fa fa"}
			<%}%>	
			</c:if>
			<%}%>
			<%
				Object[] reseObj=(Object[]) new ReceivedocumentBD().getReceivedocumentBaseInfo();
				if(reseObj!=null&&reseObj[7]!=null&&!reseObj[7].toString().equals("")){
					numObj=reseObj[7].toString().split(";");
				}
				numTypeStr = "";
				numIdStr = "";
				if(numObj!=null&&numObj.length>0){
					for(int i=0;i<numObj.length;i++){
						String numType=numObj[i];		 
					    List numList=new ReceivedocumentBD().getSeqPoListBySeqClass(numType);
						
						if(numList!=null&&numList.size()>0){
							numTypeStr+=numType + ",";
			
							for(int j=0;j<numList.size();j++){
								com.whir.govezoffice.documentmanager.po.ReceiveFileSeqPO numPO=(com.whir.govezoffice.documentmanager.po.ReceiveFileSeqPO) numList.get(j);
								String numId = numPO.getId()+"";
								String numTitle = numPO.getSeqNameR();
								numIdStr += numType + "$$" + numId + "$$" + numTitle + ",";
							}
						}
					}
				}
				if(!"".equals(numTypeStr)){
					numTypeStr = numTypeStr.substring(0,numTypeStr.length()-1);
				}
				if(!"".equals(numIdStr)){
					numIdStr = numIdStr.substring(0,numIdStr.length()-1);
				}
				numTypeStrArray = numTypeStr.split(",");
				numIdStrArray = numIdStr.split(",");
			%>
			<%menuIndex++;if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
			<c:if test="${fn:contains(canShowMenus,'documentmanager_recievefile')}">
				,{ id:-13, pId:-1, name:"收文管理",iconSkin:"fa fa-cog fa"}
			
			,{ id:1000000012, pId:-13, name:"新建收文", url:"", target:'_blank',iconSkin:"fa fa"}
			<%
				 tmp = procbd.getUserProcessListWithNoPackage(curUserId,orgIdString,null,"3",null);
				 if (null != tmp) {
					 List list = (List) tmp;
					 for(int i = 0; i < list.size(); i++){
					  Object[] rfObj = (Object[])list.get(i);
					  String processId = rfObj[0] + "" ;
					  String processName = rfObj[1] + "";
					  String processType = rfObj[2] + "";
					  String tableId = rfObj[4] + "";
					  String remindField = rfObj[6]==null?"":rfObj[6]+"";
					// if(processName != null){ processName = processName.replaceAll(",","&#44");}
			 %>
					,{ id:<%=processId%>, pId:1000000012, name:"<%=processName.replaceAll("\"","&quto;")%>" ,click:"openWin({url:'<%=rootPath%>/GovDocReceiveProcess!newDoc.action?p_wf_pool_processId=<%=processId%>&p_wf_processType=<%=processType%>',isFull:'false',winName:'govrecworkflow'})" ,url:'',iconSkin:"fa fa"}
			 <%
				 }
			%>
					
					,{ id:1000000013, pId:-13, expNodeCode:"receiveFile",name:"经办文件查阅", url:"<%=rootPath%>/GovDocReceiveProcess!handlingFileList.action", target:'mainFrame',iconSkin:"fa fa"}
				
				 <%if(null != request.getAttribute("receiveFileSee") && "1".equals(request.getAttribute("receiveFileSee")+"")){%>
					,{ id:1000000014, pId:-13, name:"办理查阅", url:"<%=rootPath%>/GovDocReceiveProcess!receiveFileList.action", target:'mainFrame',iconSkin:"fa fa"}
					,{ id:10000000141, pId:1000000014, name:"所有文件", url:"<%=rootPath%>/GovDocReceiveProcess!receiveFileList.action", target:'mainFrame',iconSkin:"fa fa"}
					,{ id:10000000142, pId:1000000014, name:"在办文件", url:"<%=rootPath%>/GovDocReceiveProcess!receiveFileList.action?receiveType=noend&queryStatus=0", target:'mainFrame',iconSkin:"fa fa"}
				    ,{ id:10000000143, pId:1000000014, name:"办结文件", url:"<%=rootPath%>/GovDocReceiveProcess!receiveFileList.action?receiveType=end&queryStatus=1", target:'mainFrame',iconSkin:"fa fa"}
				 <%
				 id=30000;	 
				 for( int i = 0;i< numTypeStrArray.length;i++){
				 %>
					,{ id:<%=id%>, pId:10000000142, name:"<%=numTypeStrArray[i]%>", url:"", target:'mainFrame',iconSkin:"fa fa"}	 
					,{ id:<%=id+10000%>, pId:10000000143, name:"<%=numTypeStrArray[i]%>", url:"", target:'mainFrame',iconSkin:"fa fa"}	 
				<%	
					  for( int j = 0;j< numIdStrArray.length;j++){
						  String[] tempa = numIdStrArray[j].split("\\$\\$");
						  if(tempa[0].equals(numTypeStrArray[i]) && tempa.length > 2 ){
				%>
					,{ id:<%=id+100010+j%>, pId:<%=id%>, name:'<%=tempa[2].replaceAll("'","\\\\'")%>', url:"<%=rootPath%>/GovDocReceiveProcess!receiveFileList.action?receiveType=noend&seqId=<%=tempa[1]%>", target:'mainFrame',iconSkin:"fa fa"}	 
					,{ id:<%=id+100020+j%>, pId:<%=id+10000%>, name:'<%=tempa[2].replaceAll("'","\\\\'")%>', url:"<%=rootPath%>/GovDocReceiveProcess!receiveFileList.action?receiveType=end&seqId=<%=tempa[1]%>", target:'mainFrame',iconSkin:"fa fa"}	 
				<%		  }
					}
					id++;
				}
				}
				%>
				  <%if(null !=request.getAttribute("receiveFileSetting") && "1".equals(request.getAttribute("receiveFileSetting")+"")){%>
					   ,{ id:1000000015, pId:-13, name:"收文设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
					   ,{ id:10000000151, pId:1000000015, name:"单位设置", url:"<%=rootPath%>/GovRecvDocSet!unitlist.action", target:'mainFrame',iconSkin:"fa fa"}
					   ,{ id:10000000152, pId:1000000015, name:"流水号设置", url:"<%=rootPath%>/GovRecvDocSet!receiveSeqList.action", target:'mainFrame',iconSkin:"fa fa"}
						<%if("2".equals(workflowType) ||  "1".equals(workflowType) || "".equals(workflowType) ){%>
					   ,{ id:10000000153, pId:1000000015, name:"流程设置", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=3", target:'mainFrame',iconSkin:"fa fa"}
						<%}%>
						<%if("2".equals(workflowType) || "0".equals(workflowType)  || "".equals(workflowType) ){%>
					   ,{ id:10000000154, pId:1000000015, name:"流程设置(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=3", target:'mainFrame',iconSkin:"fa fa"}
						<%}%>
					   ,{ id:10000000155, pId:1000000015, name:"表单设置", url:"<%=rootPath%>/GovCustom!formList.action?govFormType=1", target:'mainFrame',iconSkin:"fa fa"}
	
				<%}%>
				<% if(mbd.hasRight(session.getAttribute("userId").toString(),"03*16*01")){%>
					 ,{ id:10000000161, pId:1000000016, name:"参数设置", url:"<%=rootPath%>/GovRecvDocSet!receiveBase.action", target:'mainFrame',iconSkin:"fa fa"}
					 ,{ id:1000000016, pId:-13, name:"基础设置", url:"", target:'mainFrame',iconSkin:"fa fa"}

				<%}%>
			<%}%>
			</c:if>
			<%}%>
			<%menuIndex++;if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
			<c:if test="${fn:contains(canShowMenus,'documentmanager_filecheckwith')}">
			,{ id:-14, pId:-1, name:"文件送审签",iconSkin:"fa fa-cog fa"}
			
			,{ id:1000000017, pId:-14, name:"新建送审签", url:"", target:'mainFrame',iconSkin:"fa fa"}
				<%
				 tmp = procbd.getUserProcessListWithNoPackage(curUserId,orgIdString,null,"34",null);
				 if (null != tmp) {
					 List list = (List) tmp;
					 for(int i = 0; i < list.size(); i++){
					  Object[] rfObj = (Object[])list.get(i);
					  String processId = rfObj[0] + "" ;
					  String processName = rfObj[1] + "";
					  String processType = rfObj[2] + "";
					  String tableId = rfObj[4] + "";
					  String remindField = rfObj[6]==null?"":rfObj[6]+"";
					  //if(processName != null){ processName = processName.replaceAll(",","&#44");}
					  %>
					,{ id:<%=processId%>, pId:1000000017, name:"<%=processName%>" ,click:"openWin({url:'<%=rootPath%>/GovDocSendCheckProcess!newDoc.action?p_wf_pool_processId=<%=processId%>&p_wf_processType=<%=processType%>&p_wf_tableId=<%=tableId%>',isFull:'false',winName:'govworkflow'})" ,url:'',iconSkin:"fa fa"}
					  <%
					  //result += processId + "," + processName + "," + processType + "," + tableId + "," + remindField + ";";
					 }
				%>
			 <%if(null != request.getAttribute("fileSendCheckSee") && "1".equals(request.getAttribute("fileSendCheckSee")+"")){%>
				,{ id:1000000018, pId:-14, name:"办理查阅", url:"<%=rootPath%>/GovDocSendCheckProcess!list.action", target:'mainFrame',iconSkin:"fa fa"}
			 <%}if(null !=request.getAttribute("fileSendCheckSetting") && "1".equals(request.getAttribute("fileSendCheckSetting")+"")){%>
				,{ id:1000000019, pId:-14, name:"文件送审签设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
				<%if("2".equals(workflowType) || "1".equals(workflowType)  || "".equals(workflowType) ){%>
				,{ id:10000000191, pId:1000000019, name:"流程设置", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=34", target:'mainFrame',iconSkin:"fa fa"}
				 <%}%>
				<%if("2".equals(workflowType) || "0".equals(workflowType)  || "".equals(workflowType) ){%>
				,{ id:10000000192, pId:1000000019, name:"流程设置(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=34", target:'mainFrame',iconSkin:"fa fa"}
				 <%}%>
				,{ id:10000000193, pId:1000000019, name:"表单设置", url:"<%=rootPath%>/GovCustom!formList.action?govFormType=2", target:'mainFrame',iconSkin:"fa fa"}
			<%	}	
			 }
			%> 
			</c:if>
			<%}%>
			<%menuIndex++;if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
			<c:if test="${fn:contains(canShowMenus,'documentmanager_exchange')}">
			,{ id:-15, pId:-1, name:"公文交换",iconSkin:"fa fa-cog fa"}
			
			<% if(null !=request.getAttribute("govExchange") && "1".equals(request.getAttribute("govExchange")+"")){%>
				,{ id:1000000021, pId:-15, name:"收文", url:"<%=rootPath%>/GovExchange!exchangeReceive.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:1000000022, pId:-15, name:"发文", url:"<%=rootPath%>/GovExchange!exchangeSend.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:1000000023, pId:-15, name:"公文撤回", url:"", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000231, pId:1000000023, name:"被撤回", url:"<%=rootPath%>/GovExchange!cancel.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:10000000232, pId:1000000023, name:"我的撤回", url:"<%=rootPath%>/GovExchange!mycancel.action", target:'mainFrame',iconSkin:"fa fa"}
			<%	}
				if(null != request.getAttribute("govExchangeUnit") && "1".equals(request.getAttribute("govExchangeUnit")+"") ){
			%>
				,{ id:1000000024, pId:-15, name:"单位设置", url:"<%=rootPath%>/GovExchange!unitlist.action", target:'mainFrame',iconSkin:"fa fa"}
				,{ id:1000000025, pId:-15, name:"群组设置", url:"<%=rootPath%>/GovExchange!grouplist.action", target:'mainFrame',iconSkin:"fa fa"}
			<%}%>
			</c:if>
			<%}%>
			<%menuIndex++;if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
			<% if(mbd.hasRight(session.getAttribute("userId").toString(),"GOVDOCUMENT*02*01")){%>
			,{ id:-16, pId:-1, name:"公文统计",iconSkin:"fa fa-cog fa"}
			,{ id:1000000026, pId:-16, name:"发文量统计", url:"<%=rootPath%>/GovDocSet!statisticsDoc.action?govtype=sendfile", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:1000000027, pId:-16, name:"收文量统计", url:"<%=rootPath%>/GovDocSet!statisticsDoc.action?govtype=receivefile", target:'mainFrame',iconSkin:"fa fa"}
			<%} }%>
			<%menuIndex++;if(com.whir.common.util.CommonUtils.isForbiddenPad(request)){%>
			<% if(mbd.hasRight(session.getAttribute("userId").toString(),"GOVDOCUMENT*01*03")){%>
			,{ id:-17, pId:-1, name:"领导文件查阅",iconSkin:"fa fa"}
			,{ id:1000000028, pId:-17, name:"发文", url:"<%=rootPath%>/GovDocSend!leaderHandlingFileList.action?isLeader=1", target:'mainFrame',iconSkin:"fa fa"}
			,{ id:1000000029, pId:-17, name:"收文", url:"<%=rootPath%>/GovDocReceiveProcess!leaderHandlingFileList.action", target:'mainFrame',iconSkin:"fa fa"}
			
			<% if(mbd.hasRight(session.getAttribute("userId").toString(),"GOVDOCUMENT*01*02")){%>
			,{ id:1000000031, pId:-17, name:"设置", url:"<%=rootPath%>/GovDocSet!leaderSetting.action?govtype=receivefile", target:'mainFrame',iconSkin:"fa fa"}
			<%}%>
			<%} }%>
			<%
		      	String menutype = "documentmanager";
		    %>
		    <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
		];
      
        //$(document).ready(function(){$.fn.zTree.init($("#treeDemo"), setting, zNodes)});  
        function whir_initMenu(){
        	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
        	if('<%=portletSettingId%>' == "myreceivedfile" ){
				OpenCloseSubMenu(1000000001);	
			}else if('<%=portletSettingId%>' == "notReceive"){
				OpenCloseSubMenu(1000000021);	
			}else if('<%=portletSettingId%>' == "receive"){
				OpenCloseSubMenu(1000000021);	
			}else if('<%=expNodeCode%>' == "sendFile"){
				//OpenCloseSubMenu(1000000006);	
				OpenSubMenu("sendFile");	
			}else if('<%=expNodeCode%>' == "ffFile"){
				//OpenCloseSubMenu(1000000007);	
				OpenSubMenu("ffFile");	
			}else if('<%=expNodeCode%>' == "receiveFile"){
				//OpenCloseSubMenu(1000000013);	
				OpenSubMenu("receiveFile");	
			}else if('<%=portletSettingId%>' == "notRead"){
				OpenCloseSubMenu(1000000000);	
			}else if('<%=expNodeCode%>' == "notRead"){
				OpenCloseSubMenu(1000000000);	
			}
        }
    </SCRIPT>  
    <div class="wh-l-msg">
	    <a href="javascript:void(0)" class="clearfix" style="cursor:default">
	        <i class="fa fa-color fa-briefcase"></i>
	        <span>
	            	公文
	        </span>
	    </a>
 	 </div>
    <div class="wh-l-con">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
	
<SCRIPT LANGUAGE="JavaScript">

function newsend(){
	openWin({url:'/defaultroot/GovDocSendProcess!addfile.action?p_wf_processId=8530&p_wf_processType=1&p_wf_tableId=62',width:620,height:350,winName:'_blank'});
}
function  menuJump(url){
	$('#mainFrame', window.parent.document).attr("src",url);
}

</SCRIPT>
