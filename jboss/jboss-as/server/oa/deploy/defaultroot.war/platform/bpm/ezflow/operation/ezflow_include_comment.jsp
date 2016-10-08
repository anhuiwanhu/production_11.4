<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="com.whir.i18n.Resource"%>
<%@page import="java.util.*"%>
<%@page import="org.activiti.engine.impl.persistence.entity.WhirEzFlowCommentEntity"%>
<%@page import="com.whir.service.api.ezflowservice.*"%> 
<% 
String  oldrecorId="";
String  public_comment_iWebVersion="6,3,0,178";
String  public_comment_iWebUrl="http://"+request.getServerName()+":"+request.getServerPort()+rootPath+"/iWebRevisionServlet";//取得OfficeServer文件的完整URL
java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//是否有 批示意见范围的选项
String  p_wf_commentRangeByDealUser=request.getAttribute("p_wf_commentRangeByDealUser")==null?"":request.getAttribute("p_wf_commentRangeByDealUser").toString();
 // 意见态度设置：   0 不显示态度  1显示同意与不同意 2 显示已阅、同意与不同意 
String  p_wf_commentAttitudeTypeSet=request.getAttribute("p_wf_commentAttitudeTypeSet")==null?"":request.getAttribute("p_wf_commentAttitudeTypeSet").toString();  
String  whir_commentRangeId=request.getAttribute("whir_commentRangeId")==null?"":request.getAttribute("whir_commentRangeId").toString();
String  localcom_comment = session.getAttribute("org.apache.struts.action.LOCALE").toString();  
String include_p_wf_moduleId=request.getAttribute("p_wf_moduleId")+""; 
%>
<link rel="stylesheet" href="<%=rootPath%>/platform/bpm/ezflow/operation/ezflow_include_comment.css" />
<input type="hidden" name="addDivContent" id="addDivContent" value=""> <!-- 在  常用语中用到-->
<%
int handSignInUse_w = 0;//是否使用了手写签名
int signatureInUse_w = 0;//是否使用了电子签章
java.util.Map include_sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
if(include_sysMap != null && include_sysMap.get("使用手写意见") != null && "1".equals(include_sysMap.get("使用手写意见").toString())){
    handSignInUse_w = 1;//手写签名
}
if(include_sysMap != null && include_sysMap.get("电子签章") != null && "1".equals(include_sysMap.get("电子签章").toString())){
	signatureInUse_w = 1;//电子签章
}
 
 String userAgent = request.getHeader("User-Agent");
 //
 if(userAgent != null && userAgent.indexOf("IE") >= 0){

 }else{
	 //非IE 不显示电子签章与 手写签名
     handSignInUse_w=0;
	 signatureInUse_w=0;
 }
//查找上传方式
int smartInUse_w = 0;
if(include_sysMap != null && include_sysMap.get("附件上传") != null){
	smartInUse_w = Integer.parseInt(include_sysMap.get("附件上传").toString());
}
String include_fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());//session.getAttribute("fileServer").toString();


String workflow_accPath=(smartInUse_w==1?rootPath:include_fileServer)+"/upload/workflow_acc/";
 
//当前审批人和日期
String writeUser = session.getAttribute("userName").toString();
String writeUserId = session.getAttribute("userId").toString();
com.whir.org.bd.usermanager.UserBD ub = new com.whir.org.bd.usermanager.UserBD();
String writeUserSignature = ub.getSignature(writeUserId);
if(!"".equals(writeUserSignature)){
	writeUserSignature = "<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+writeUserSignature+"'>";
}else{
	writeUserSignature = writeUser;
}
java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

String nowTime = df.format(new java.util.Date());

//保护字段 
String protectField_w =request.getAttribute("p_wf_protectedField")==null?"":""+request.getAttribute("p_wf_protectedField");

//protectField_w="p_wf_test=test;";
 
//批示意见上传附件
String whir_processCommentAcc=request.getAttribute("p_wf_processCommentAcc")==null?"":request.getAttribute("p_wf_processCommentAcc").toString();

//电子签章div的位置
String inc_divId_w = java.util.Calendar.getInstance().getTimeInMillis() + "";
 

//所有批示意见所在的活动id  按活动来分类取内容
List tmpList=new ArrayList();

List oldtmpList=new ArrayList();
List activityIdList=new ArrayList();
List oldactivityIdList=new ArrayList();
 
//流程实例id
String processInstanceId=request.getAttribute("p_wf_processInstanceId")==null?"":request.getAttribute("p_wf_processInstanceId")+"";
if(processInstanceId==null||processInstanceId.equals("")||processInstanceId.equals("null")){
     processInstanceId=request.getParameter("processInstanceId")==null?"":request.getParameter("processInstanceId")+"";
}

// 当前活动id
String curActivityId=request.getAttribute("p_wf_cur_activityId")==null?"0":request.getAttribute("p_wf_cur_activityId").toString();

//批示意见 内容列表
List commentList_w=new ArrayList();
if(request.getAttribute("commentList_w")!=null){
	commentList_w=(List)request.getAttribute("commentList_w");
}

if(commentList_w!=null&&commentList_w.size()>0){
    for(int i=0;i<commentList_w.size();i++){
	     WhirEzFlowCommentEntity  cEntity=(WhirEzFlowCommentEntity)commentList_w.get(i);
		 String  isoldComment=cEntity.getIsoldComment()+"";
		 //重新发起前的批示意见
		 if(isoldComment.equals("1")){
			 if(!oldactivityIdList.contains(cEntity.getActivityId())){
			    oldactivityIdList.add(cEntity.getActivityId());
			    oldtmpList.add(new String[]{cEntity.getActivityId(),cEntity.getActivityName()});
		     }
		 }else{
		    if(!activityIdList.contains(cEntity.getActivityId())){
			   activityIdList.add(cEntity.getActivityId());
			   tmpList.add(new String[]{cEntity.getActivityId(),cEntity.getActivityName()});
		    }
		 }
		 
	}
}
 
//表单code
String formCode=request.getAttribute("p_wf_formKey_act")==null?"":request.getAttribute("p_wf_formKey_act").toString();
if(formCode==null||formCode.equals("")||formCode.equals("null")){
   //流程选择的表单
   formCode=request.getAttribute("p_wf_formKey")==null?"":request.getAttribute("p_wf_formKey").toString();
}
com.whir.ezoffice.ezform.ui.UIBD   uibd=new  com.whir.ezoffice.ezform.ui.UIBD();

String[][] formCommentFields = null; 
if(include_p_wf_moduleId!=null&&(include_p_wf_moduleId.equals("2")||include_p_wf_moduleId.equals("3")||include_p_wf_moduleId.equals("34"))){  
	formCommentFields=uibd.getCommentFieldsByWfModuleId(include_p_wf_moduleId);
}else{
	formCommentFields =  uibd.getCommentFieldsByFormCode(formCode);
}
if(formCommentFields!=null){
    //显示时间格式
    nowTime=uibd.getCommentDateFormatStr(cur_commentField, nowTime, formCommentFields, "");
}
String nowdealOrgName="";
if(formCommentFields!=null){
    ////组织名
    nowdealOrgName=uibd.getCommentUserOrgNameWithCommentField(writeUserId, cur_commentField, formCommentFields);
}
//当前办理人 当前任务的草稿批示意见
String    curDraftContent=request.getAttribute("curDraftContent")==null?"":request.getAttribute("curDraftContent").toString();
String    curDraftAccName=request.getAttribute("curDraftAccName")==null?"":request.getAttribute("curDraftAccName").toString();
String    curDraftAccSName=request.getAttribute("curDraftAccSName")==null?"":request.getAttribute("curDraftAccSName").toString(); 
String    gd=request.getParameter("gd")==null?"":request.getParameter("gd").toString();
%>
<!---------显示已经保存的批示意见内容---------->
<table width="100%" border="0"   cellpadding="0" cellspacing="0" align="center" <%if(!gd.equals("1")&&include_p_wf_moduleId.equals("1")){%>style="margin-top:-15px;"<%}%> >
  <%
    String activityId="";
	String activityName="";

	//是否是归档
	boolean isgd=false;
	boolean inCommentRange=true;
    for(int j = 0; j < tmpList.size(); j ++){  
    	String [] astr=(String[])tmpList.get(j);
	    isgd=true;
	    inCommentRange=true;
	    activityId=astr[0];
	    activityName=astr[1];

		//是否显示下面的自动追加的tr     当有一个批示意见内容是自动追加的时候 就应该显示自动批示意见tr 当前的table的tr td都是自动追加的批示意见
		boolean displayTr=false;
		//判断是否有自动追加的批示意见
		for(int ni=0;ni<commentList_w.size();ni++){
			 WhirEzFlowCommentEntity  cEntity=(WhirEzFlowCommentEntity)commentList_w.get(ni);                  
             String now_activityId=cEntity.getActivityId();
             String commentField=cEntity.getCommentField();
             //批示意见类型。  0： 普通，1：手写签名  2：电子签章   3 附件
             String commentType=cEntity.getCommentType();
			 ////默认1 表示正常    0：表示是草稿
		     int commentStatus=cEntity.getCommentStatus();

             String  isoldComment=cEntity.getIsoldComment()+"";
             //重新发起前的批示意见
			 if(isoldComment.equals("1")){
			    continue;
			 }
			 //
			 if(activityId.equals(now_activityId)&&commentField!=null&&commentField.equals("autoCommentField")&&(commentStatus==1||commentStatus==2)){
			      displayTr=true;
				  break;
			 }
		}

    %>
   <tr id="commTR" style="display:<%=displayTr?"":"none"%>">
      <td>
         <table border="0" width="100%" <%if(j==0 && tmpList.size()>1){out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}else if(j==tmpList.size()-1){out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}else{out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}%> style="margin-bottom:5px;"   cellpadding="0">
		    <tr>
			 <!---此td显示活动名---->
             <td width="180"   align="center" valign="middle" style="border-bottom:<%=j==(tmpList.size()-1)?"1":"0"%>px; font-weight:bold; border-right:1px dashed #C6CCD2;"><%=activityName%>：</td>
             <td   style="word-break:break-all;" id="commTD"  align="left"  style="text-align:left"  >
             <%  if(isgd&&inCommentRange){%>
                <table width="100%" border="0">
                <%
				Map dealOrgIdMap=new HashMap();
                for(int k = 0; k < commentList_w.size(); k ++){
                	WhirEzFlowCommentEntity  cEntity=(WhirEzFlowCommentEntity)commentList_w.get(k);                  
                    String now_activityId=cEntity.getActivityId();
                    String dealUserId=cEntity.getDealUserId();
                    String dealUserName=cEntity.getDealUserName();
                    String dealContent=cEntity.getDealContent()==null?"":cEntity.getDealContent();
                    Date   dealTime=cEntity.getDealTime();
					String daalTimeStr=simpleDateFormat.format(dealTime);	
                    String commentField=cEntity.getCommentField();

		 
					String s_orgId=	cEntity.getS_orgId();
					String s_orgName=	cEntity.getS_orgName();

					
                    //组织名
                    String dealOrgName="";

					String eachOrgName="";
					String eachOrgName2=""; 

					if(formCommentFields!=null){
					    daalTimeStr=uibd.getCommentDateFormatStr(commentField, daalTimeStr, formCommentFields, ""); 
						//if(s_orgId==null||s_orgId.equals("")||s_orgId.equals("null")){
					         dealOrgName=uibd.getCommentUserOrgNameWithCommentField(dealUserId, commentField, formCommentFields);
						//}
					}

       				//批示意见类型。  0： 普通，1：手写签名  2：电子签章   3 附件
                    String commentType=cEntity.getCommentType();
                    int    isStandFor=cEntity.getIsStandFor();
                    String standForUserId=cEntity.getStandForUserId();
                    String standForUserName=cEntity.getStandForUserName();
                    String recordId=cEntity.getRecordId(); 
       				//处理类型 是办件 还是阅件
       				String commentDealType="";
					////默认1 表示正常    0：表示是草稿
					int commentStatus=cEntity.getCommentStatus();

       				//附件
       				String  commentAccDisName =cEntity.getAccDisName();
       				String  commentAccSaveName=cEntity.getAccSaveName();					           
                     if(commentAccDisName!=null){
					    // commentAccDisName= java.net.URLEncoder.encode(commentAccDisName, "UTF-8");
					 }

					 String  isoldComment=cEntity.getIsoldComment()+"";
					 //重新发起前的批示意见
					 if(isoldComment.equals("1")){
						continue;
					 }
     				
					//如果不属于此td 活动的批示意见 以及 是无批示意见字段	 以及草稿	 
				    if(!activityId.equals(now_activityId) || "nullCommentField".equals(commentField)||commentStatus==0){
							continue;
					} 

					if(s_orgId!=null&&!s_orgId.equals("")&&!s_orgId.equals("null")){
						if(dealOrgIdMap.get(s_orgId+"_"+now_activityId+"_"+commentField)==null){
							 eachOrgName="<strong style='font-size:14px;'>"+s_orgName+"</strong><br />";
							 eachOrgName2="<div style='text-align:left'><strong style='font-size:14px;'>"+s_orgName+"</strong></div><br />";
							 dealOrgIdMap.put(s_orgId+"_"+now_activityId+"_"+commentField,s_orgName);
						}
						
					}
					
					//如果是自动追加批示意见
					if("autoCommentField".equals(commentField)){%>
					  <tr> 
						<td  valign="middle" height="30" style="padding-left:10px;">	
						<%=eachOrgName%>
						<%if(commentType.equals("2")){%>
						 <!-- 电子签章 -->
						<div id="signPosi_<%=dealContent%>" style='position:relative;width:100%; height:130px;'></div>
						
						<%}
						//手写批注
						if(commentType.equals("1") && handSignInUse_w==1){%>
						<!-- 手写控件 -->
                                <OBJECT name="incSig<%=k%>" id="incSig<%=k%>" classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="98%" height="180">
                                        <param name="weburl" value="<%=public_comment_iWebUrl%>">
                                        <param name="recordid" value="<%=dealContent%>">
                                        <param name="fieldname" value="SendOut<%=dealContent%>">
                                        <param name="username" value="wanghr">
                                        <param name="Enabled" value="0">
                                        <param name="PenColor" value="00000000">
                                        <param name="BorderStyle" value="0">
										<param name="wmode" value="opaque">
                                  </OBJECT>
                                  <script language="javascript">
							           //加载手写签批的js函数
									   function  incSig<%=k%>LoadSignature(){
										     try{    
											   $("#incSig<%=k%>")[0].LoadSignature();
											}catch(e){
												alert(e);
											}
										}					 
									  incSig<%=k%>LoadSignature();
									  setTimeout("incSig<%=k%>LoadSignature()",500);
							         //document.all.incSig<%=k%>.LoadSignature();document.all.incSig<%=k%>.LoadSignature();
								   </script>                    		
						<%}
						//文字
						if(commentType.equals("0")){
							  //内容
							  out.println(com.whir.common.util.CharacterTool.escapeHTMLTags(dealContent));
							%>
						<%}
                          //4：手机手写签批：
						 if(commentType.equals("4")){ 
							 String imgpath="";
							 if(dealContent!=null&&dealContent.length()>6){
								imgpath=dealContent.substring(0,6)+"/";
							 }
						     out.println("<IMG SRC='"+workflow_accPath+imgpath+dealContent+"'>");  
						 }%>  
						<%
						//文字  4：手机手写签批：5:语音审批
						if(commentType.equals("5")){
							  //内容
							 String iframeHtml="<input type='hidden' name='wfCommentName_iframe"+k+"' id='wfCommentName_iframe"+k+"' value=\""+dealContent+"\" />"+ 
							  " <input type='hidden' name='wfCommentSaveName_iframe"+k+"' id='wfCommentSaveName_iframe"+k+"' value='"+dealContent+"'/>" +
							  " <iframe name='commentIframe"+k+"' id='commentIframe"+k+"' src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=commentIframe"+k+"&realFileNameInputId=wfCommentName_iframe"+k+"&saveFileNameInputId=wfCommentSaveName_iframe"+k+"&canModify=no&style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe>"; 
							  out.println(iframeHtml);  
						   %>
						<%}

						if(commentAccSaveName!=null&&!commentAccSaveName.equals("")&&!commentAccSaveName.equals("null")){
							 
						      String iframeHtml="<input type='hidden' name='wfAccessoryName_iframe"+k+"' id='wfAccessoryName_iframe"+k+"' value=\""+commentAccDisName+"\" />"+ 
							  " <input type='hidden' name='wfAccessorySaveName_iframe"+k+"' id='wfAccessorySaveName_iframe"+k+"' value='"+commentAccSaveName+"'/>" +
							  " <iframe name='accessoryIframe"+k+"' id='accessoryIframe"+k+"' src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe"+k+"&realFileNameInputId=wfAccessoryName_iframe"+k+"&saveFileNameInputId=wfAccessorySaveName_iframe"+k+"&canModify=yes &style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe>";
 
							  out.println(iframeHtml);  
 
						}%>
                       </td>
				     </tr>
					 <tr>
					   <td style="text-align:right;padding-bottom:10px;" valign="middle" >
					    <%//文字
						if(commentType.equals("0")){ 
							String realdealUserName=ub.getSignature(dealUserId).equals("")?dealUserName:("<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+ub.getSignature(dealUserId)+"'>");

							if(commentStatus==2&&!"0".equals(""+request.getAttribute("p_wf_processType"))){
							    realdealUserName="转办人:"+realdealUserName;
							}
							%>
							<!--办理人 以及 转办 代办--->
						    <%=realdealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+((isStandFor==1&&!standForUserName.equals("")&&!standForUserName.equals(""))?"<font color=\"blue\">(代"+standForUserName+"办理)</font>":"")+"&nbsp;&nbsp;"%> 
						<%}else{%>
						   <%=((commentStatus==2&&!"0".equals(""+request.getAttribute("p_wf_processType")))?"转办人:":"")+dealUserName+"&nbsp;&nbsp;"+dealOrgName+"&nbsp;&nbsp;"+daalTimeStr+"&nbsp;&nbsp;"%>
						<%}%>
					   </td>
					 </tr>
			       <%}else{
					   //如果不是自动追加 就要用js赋值到表单 相应的div里
					   //js 赋值内容
					   String jsContent=""+eachOrgName2;
					   if(commentType.equals("2")){
						  //电子签章
						  jsContent+="<div style=\\\"position:relative;height:130px\\\" ><div id=\\\"signPosi_"+dealContent+"\\\" style=''></div></div>";
						    			
						}
						//手写批注
						if(commentType.equals("1")){
                             jsContent+="<div style=\\\"width:100%;\\\">"+                             
                             "   <OBJECT name=\\\"incSig"+k+"\\\"   id=\\\"incSig"+k+"\\\" classid=\\\"clsid:2294689C-9EDF-40BC-86AE-0438112CA439\\\" codebase=\\\""+rootPath+"/public/iWebRevision.jsp/iWebRevision.cab#version="+public_comment_iWebVersion+"\\\" width=\\\"100%\\\" height=\\\"180\\\">"+
                                        "<param name=\\\"weburl\\\" value=\\\""+public_comment_iWebUrl+"\\\">"+
                                        "<param name=\\\"recordid\\\"     value=\\\""+dealContent+"\\\">"+
                                        "<param name=\\\"fieldname\\\"    value=\\\"SendOut"+dealContent+"\\\">"+
                                        "<param name=\\\"username\\\"     value=\\\"\\\">"+
                                        "<param name=\\\"Enabled\\\"      value=\\\"0\\\">"+
                                        "<param name=\\\"PenColor\\\"     value=\\\"00000000\\\">"+
                                        "<param name=\\\"BorderStyle\\\"  value=\\\"0\\\">"+
										"<param name=\\\"wmode\\\"        value=\\\"opaque\\\">"+
                              "   </OBJECT></div>";
							 //eval("document.all.incSig"+k+".LoadSignature()");
                        }
						//文字
						if(commentType.equals("0")){
							  //内容
							  jsContent+="<div style='text-align:left;word-break: break-all;'>"+com.whir.common.util.CharacterTool.escapeHTMLTags(dealContent)+"</div>";						 
						}
 
						if(commentType.equals("4")){
							  //手机手写内容
							   String imgpath="";
							   if(dealContent!=null&&dealContent.length()>6){
								imgpath=dealContent.substring(0,6)+"/";
							   } 
							  jsContent+="<IMG SRC='"+workflow_accPath+imgpath+dealContent+"'>";						 
						}  
						if(commentType.equals("5")){
							  //内容
							   jsContent+="<div style=\\\"width:100%;\\\">"+
							  "<input type='hidden' name='wfCommentName_iframe"+k+"' id='wfCommentName_iframe"+k+"'  value=\\\""+dealContent+"\\\" />"+ 
							  " <input type='hidden' name='wfCommentSaveName_iframe"+k+"' id='wfCommentSaveName_iframe"+k+"' value='"+dealContent+"'/>" +
							  " <iframe name='commentIframe"+k+"' id='commentIframe"+k+"'   src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=commentIframe"+k+"&realFileNameInputId=wfCommentName_iframe"+k+"&saveFileNameInputId=wfCommentSaveName_iframe"+k+"&canModify=no&style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe></div>";						 
						}
						
						if(commentAccSaveName!=null&&!commentAccSaveName.equals("")&&!commentAccSaveName.equals("null")){
                              jsContent+="<div style=\\\"width:100%;\\\">"+
							  "<input type='hidden' name='wfAccessoryName_iframe"+k+"' id='wfAccessoryName_iframe"+k+"'  value=\\\""+commentAccDisName+"\\\" />"+ 
							  " <input type='hidden' name='wfAccessorySaveName_iframe"+k+"' id='wfAccessorySaveName_iframe"+k+"' value='"+commentAccSaveName+"'/>" +
							  " <iframe name='accessoryIframe"+k+"' id='accessoryIframe"+k+"'   src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe"+k+"&realFileNameInputId=wfAccessoryName_iframe"+k+"&saveFileNameInputId=wfAccessorySaveName_iframe"+k+"&canModify=no&style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe></div>";
						}
						//文字
						if(commentType.equals("0")){
							String realdealUserName=ub.getSignature(dealUserId).equals("")?dealUserName:("<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+ub.getSignature(dealUserId)+"'>");
							  //<!--办理人 以及 转办 代办--->
						      jsContent+="<div style=\\\"width:100%;text-align:right\\\">"+((commentStatus==2&&!"0".equals(""+request.getAttribute("p_wf_processType")))?"转办人：":"")+realdealUserName+" "+dealOrgName+" "+daalTimeStr+((isStandFor==1&&!standForUserName.equals("")&&!standForUserName.equals(""))?"<font color=\\\"blue\\\">(代"+standForUserName+"办理)</font>":"")+""+"<br><br></div>";
						}else{
						      jsContent+="<div style=\\\"width:100%;text-align:right\\\">"+((commentStatus==2&&!"0".equals(""+request.getAttribute("p_wf_processType")))?"转办人：":"")+dealUserName+" "+dealOrgName+" "+daalTimeStr+""+"<br><br></div>";
						}
						 	
						%>	
						<SCRIPT LANGUAGE="JavaScript">
				        <!--

					     //归档页面的  批示意见赋值不能赋两次
						if($("#workflow_thisIsInGDpage").length <=0){
							 var commentField_js='<%=commentField%>_commentfield';						 
							 if(commentField_js.indexOf('$')!=-1){
								 commentField_js = commentField_js.replace(/[$]/g, "\\\$"); 
							 }
							 //
							 
							 if($("div[id$='"+commentField_js+"']").length>0){
								$("div[id$='"+commentField_js+"']").eq(0).append("<%=jsContent%>");
							 }  


							<% 
							//手写批注
							if(commentType.equals("1") && handSignInUse_w==1){%>
							   function  incSig<%=k%>LoadSignature(){
									 try{   
										 $("#incSig<%=k%>")[0].LoadSignature();
										// eval("document.all.incSig<%=k%>.LoadSignature()");
									 }catch(e){
										alert(e);
									 }
								 }					 
								 incSig<%=k%>LoadSignature();
								 setTimeout("incSig<%=k%>LoadSignature()",500);

							<%}%>
						}
				          //-->
				        </SCRIPT>
				   <%}%>	
               <%}%>
			   </table>
			 <%}%>
			 </td>
			</tr></table>  
            </td>
		 </tr>
		<%}%>
	</table>
   	<div style="height:5px;"></div> 
<%

 //待办 待阅 才显示输入批示意见
 if(openType.equals("waitingDeal")||openType.equals("waitingRead")){
	 //如果当前是自动追加批示意见
	 if("autoCommentField".equals(cur_commentField)){%>

	  <table width="100%" border="0" align="center" cellpadding="5" cellspacing="0" style="margin-top:5px;border:1px dashed #C6CCD2;;background-color:#F6F6F6;">
        <tr>
           <td width="122" align="left"><!-- 办理意见 --><%=Resource.getValue(localcom_comment,"workflow","workflow.ProcessComment")%>：</td>
           <td>&nbsp;</td>
       </tr>
       <tr>
         <td colspan="2" valign="top" nowrap="nowrap">
         <%
		    String SignatureId = new java.util.Date().getTime() + "";
 
            // 意见态度设置：   0 不显示态度  1显示同意与不同意 2 显示已阅、同意与不同意  
			String attitudeTypeRadioStr="";
			if(p_wf_commentAttitudeTypeSet.equals("1")){
				attitudeTypeRadioStr="<input name=\"radio_commentAttitudeType\"     type=\"radio\"   value=\"1\">同意 <input value=\"2\" type=\"radio\" name=\"radio_commentAttitudeType\"  >不同意&nbsp;&nbsp;&nbsp;&nbsp;"; 
			}

			if(p_wf_commentAttitudeTypeSet.equals("2")){
				attitudeTypeRadioStr="<input name=\"radio_commentAttitudeType\"     type=\"radio\"   value=\"3\">已阅 <input name=\"radio_commentAttitudeType\"     type=\"radio\"   value=\"1\">同意 <input value=\"2\" type=\"radio\" name=\"radio_commentAttitudeType\"  >不同意&nbsp;&nbsp;&nbsp;&nbsp;"; 
			}
 
		 %>
			<!-- 填写意见框 -->
			<!-- 普通 -->
	         <table id="signTb1" width="100%" border="0">
				<tr>
				   <td> 
				       <div>
					     <div style="position:relative;">
						 <div align="right"   style="text-align:right;"><%=attitudeTypeRadioStr%><%if(p_wf_commentRangeByDealUser.equals("true")){%><a href="javascript:;" onclick="chooseCommentRanger('<%=whir_commentRangeId%>');">批示意见范围</a>&nbsp;&nbsp;<%}%><a  id="trigger1_auto" href="javascript:;"  rel="noteDiv" ><!-- 常用语 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Frequentusedwords")%></a></div>  
						 </div> 
                         <div>
							<textarea  name="comment" id="comment"  cols="50" Class="inputTextarea" onblur="include_checkTextArea(this,'<%=Resource.getValue(localcom_comment,"workflow","workflow.activitycomment")%>',1000);" style="height:100px;width:100%;border:1px solid #cccccc;height:expression((this.scrollHeight+2)<120?120:this.scrollHeight+2)"><%=curDraftContent%></textarea>
							<input type="hidden" name="ru_commentRangeEmpId" id="ru_commentRangeEmpId" /><input type="hidden" name="ru_commentRangeEmpName" id="ru_commentRangeEmpName" />
							</div>
						</div> 
					  </td>
				 </tr>
	          </table>
			  <!-- 手写控件 -->
			  <%if(handSignInUse_w==1){%>
			  <table id="signTb2" width="100%" border="0"  style="display:none; ">
				  <tr>
				    <td align="right"><button class="btnButton4font" onclick="if (!SendOut.OpenSignature()){alert(SendOut.Status);};return false;"><!-- 签章 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Signature")%></button>
                      <input type="hidden" name="comment" id="comment" value="<%=SignatureId%>">
					  <!-- <a href="javascript:" onclick="if (!SendOut.OpenSignature()){alert(SendOut.Status);}">打开签章</a> --></td>
			      </tr>
				  <tr>
				    <td height="120">
 			       <OBJECT name="SendOut" id="SendOut" classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="100%" height="180" style=" z-index:-1;">   
							<param name="weburl" value="<%=public_comment_iWebUrl%>">
							<param name="recordid" value="<%=SignatureId%>">
							<param name="fieldname" value="SendOut<%=SignatureId%>">
							<param name="username" value="<%=session.getAttribute("userName")%>">
							<param name="Enabled" value="1">
							<param name="PenWidth" value="1">
							<param name="PenColor" value="00000000">
							<param name="BorderStyle" value="0">
							<param name="EditType" value="0">	
							<param name="wmode" value="transparent">  
					  </OBJECT></td>
					</tr>
				</table>
			<%}%>
			<%if(signatureInUse_w==1){%>
			    <!-- 电子签章 -->
	  			<table id="signTb3" width="100%" border="0" style="display:none;">
				    <tr>
				      <td align="right">
						    <button class="btnButton4font" onclick="include_signature('<%=protectField_w%>','<%=inc_divId_w%>');return false;"><%=Resource.getValue(localcom_comment,"workflow","workflow.Seal")%> <!--盖章 --></button>
                            <button class="btnButton4font" onclick="include_signature2('<%=protectField_w%>','<%=inc_divId_w%>');return false;"> <%=Resource.getValue(localcom_comment,"workflow","workflow.Sign")%><!--签字 --></button>                      </td>
        			</tr>
					 <tr>
					    <td  style="height:150px;">
						    <div style="position:relative;width:100%;height:100%;">
						    <div id="signPosi_<%=inc_divId_w+"0000"%>" style="position:absolute;width:100%;height:98%;border:1px solid #cccccc;background-color:#ffffff;"></div>
							</div>
							<input type="hidden" name="comment" value="<%=inc_divId_w+"0000"%>">
						</td>
					</tr>
	 			 </table>
			<%}%>  
			<%
			//批示意见允许上传附件
			if(whir_processCommentAcc.equals("true")){%>
			<table   width="100%" border="0"  >
			   <tr>
				   <td align="left">
					  <input type="hidden" name="ezFlow_CommentAccessoryName" id="ezFlow_CommentAccessoryName"  value="<%=curDraftAccName%>" />  
                      <input type="hidden" name="ezFlow_CommentAccessorySaveName" id="ezFlow_CommentAccessorySaveName" value="<%=curDraftAccSName%>"/> 
			          <iframe name="accessoryIframe" id="accessoryIframe" src="<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe&realFileNameInputId=ezFlow_CommentAccessoryName&saveFileNameInputId=ezFlow_CommentAccessorySaveName&canModify=yes&style=body{background-color:%23F6F6F6;}"  scrolling=""  border="1" frameborder="0" width="520" height="100%"></iframe>
					 </td>
        			</tr>
		     </table>
			 <%}%>
			 </td>
         </tr>
		 <tr>
		  <td colspan="2" align="right">
			<input type="hidden" name="commentSignType"  id="commentSignType" value="0"><!-- 用户选择的批示类型 -->
			<input type="hidden" name="commentSignIndex" id="commentSignIndex" value="0"><!-- 用户选择的批示类型 -->
			<%if(handSignInUse_w==1 || signatureInUse_w==1){%>
   				<a href="javascript:;" onClick="changeSignType_w('0');return false;"><!-- 普通 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Common")%></a>&nbsp;&nbsp;<%}%><%if(handSignInUse_w==1){%><a href="javascript:;" onClick="changeSignType_w('1');return false;"><!-- 手写签名 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Handwrittensignature")%></a>&nbsp;&nbsp;<%}if(signatureInUse_w==1){%><a href="javascript:;" onClick="changeSignType_w('2');return false;"><!-- 电子签章 --><%=Resource.getValue(localcom_comment,"workflow","workflow.ElectronicSignature")%></a>&nbsp;&nbsp;<%}%>
			<div align="right"><%=writeUserSignature+" "+nowdealOrgName+" "+nowTime+""%></div>		 </td>
		</tr>
     </table>	 
	 <%}else{
	 }
 } 
%>
<%if(signatureInUse_w==1){%>
<OBJECT id="SignatureControl_w" classid="clsid:D85C89BE-263C-472D-9B6B-5264CD85B36E" codebase="<%=rootPath%>/public/iSignatureHTML.jsp/iSignatureHTML.cab#version=7,2,0,216" width="0" height="0" VIEWASTEXT>
<param name="ServiceUrl" value="http://<%=request.getServerName()%>:<%=request.getServerPort()%><%=rootPath%>/public/iSignatureHTML.jsp/Service.jsp"><!--读去数据库相关信息-->
<param name="WebAutoSign" value="0">             <!--是否自动数字签名(0:不启用，1:启用)-->
</OBJECT>
<%}%>
<%  
if(true){
  //重新发起之前的意见
  if(oldtmpList!=null&&oldtmpList.size()>0){
%>
<br>
 <table width="100%" border="0"   cellpadding="0" cellspacing="0" align="center" <%if(!gd.equals("1")){%>style="margin-top:5px;"<%}%> >

 	<tr id="oldcommTR" >
      <td>重新发起前批示意见：</td>
	</tr>
  <%
    String oldactivityId="";
	String oldactivityName="";
 
	boolean oldisgd=false;
	boolean oldinCommentRange=true;
    for(int j = 0; j < oldtmpList.size(); j ++){  
    	String [] astr=(String[])oldtmpList.get(j);
	    oldisgd=true;
	    oldinCommentRange=true;
	    oldactivityId=astr[0];
	    oldactivityName=astr[1]; 
    %> 
   <tr id="oldcommTR" >
      <td>
         <table border="0" width="100%" <%if(j==0 && oldtmpList.size()>1){out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}else if(j==oldtmpList.size()-1){out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}else{out.print("style=\"border:1px dashed #C6CCD2;border-collapse:collapse;\"");}%> style="margin-bottom:5px;"   cellpadding="0">
		    <tr> 
             <td width="110" nowrap align="center" valign="middle" style="border-bottom:<%=j==(oldtmpList.size()-1)?"1":"0"%>px; font-weight:bold; border-right:1px dashed #C6CCD2;"><%=oldactivityName%>：</td>
             <td   style="word-break:break-all;" id="commTD"  align="left"  style="text-align:left"  >
             <%  if(oldisgd&&oldinCommentRange){%>
                <table width="100%" border="0">
                <%
                for(int k = 0; k < commentList_w.size(); k ++){
                	WhirEzFlowCommentEntity  cEntity=(WhirEzFlowCommentEntity)commentList_w.get(k);                  
                    String now_activityId=cEntity.getActivityId();
                    String dealUserId=cEntity.getDealUserId();
                    String dealUserName=cEntity.getDealUserName();
                    String dealContent=cEntity.getDealContent()==null?"":cEntity.getDealContent();
                    Date   dealTime=cEntity.getDealTime();
					String daalTimeStr=simpleDateFormat.format(dealTime);	
                    String commentField=cEntity.getCommentField();

                    if(formCommentFields!=null){
					     daalTimeStr=uibd.getCommentDateFormatStr(commentField, daalTimeStr, formCommentFields, "");
					}

       				//批示意见类型。  0： 普通，1：手写签名  2：电子签章   3 附件
                    String commentType=cEntity.getCommentType();
                    int    isStandFor=cEntity.getIsStandFor();
                    String standForUserId=cEntity.getStandForUserId();
                    String standForUserName=cEntity.getStandForUserName();
                    String recordId=cEntity.getRecordId(); 
       				//处理类型 是办件 还是阅件
       				String commentDealType="";
					////默认1 表示正常    0：表示是草稿
					int commentStatus=cEntity.getCommentStatus();

       				//附件
       				String  commentAccDisName =cEntity.getAccDisName();
       				String  commentAccSaveName=cEntity.getAccSaveName();	 
					 String  isoldComment=cEntity.getIsoldComment()+"";
					 //重新发起前的批示意见
					 if(!isoldComment.equals("1")){
						continue;
					 }
       				
					//如果不属于此td 活动的批示意见 以及 是无批示意见字段	 以及草稿	 
				    if(!oldactivityId.equals(now_activityId) || "nullCommentField".equals(commentField)||commentStatus==0){
							continue;
					}
					
					//如果是自动追加批示意见
					if(true){%>
					  <tr>
					    <%// IE7 不显示td中的文字 -- <td  valign="middle" height="30" style="padding-left:10px; position:relative;">	 %>
						<td  valign="middle" height="30" style="padding-left:10px;">					
						<%if(commentType.equals("2")){%>
						 <!-- 电子签章 -->
						<div id="signPosi_<%=dealContent%>" style='position:relative;width:100%; height:130px;'></div>
						
						<%}
						//手写批注
						if(commentType.equals("1") && handSignInUse_w==1){%>
						<!-- 手写控件 -->
                                <OBJECT name="incSig<%=k%>" id="incSig<%=k%>" classid="clsid:2294689C-9EDF-40BC-86AE-0438112CA439" codebase="<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>" width="98%" height="180">
                                        <param name="weburl" value="<%=public_comment_iWebUrl%>">
                                        <param name="recordid" value="<%=dealContent%>">
                                        <param name="fieldname" value="SendOut<%=dealContent%>">
                                        <param name="username" value="wanghr">
                                        <param name="Enabled" value="0">
                                        <param name="PenColor" value="00000000">
                                        <param name="BorderStyle" value="0">
										<param name="wmode" value="opaque">
                                  </OBJECT>
                                  <script language="javascript">
							           //加载手写签批的js函数
									   function  incSig<%=k%>LoadSignature(){
										     try{   
											  //eval("document.all.incSig<%=k%>.LoadSignature()");
											   $("#incSig<%=k%>")[0].LoadSignature();
											}catch(e){
												alert(e);
											}
										}					 
									  incSig<%=k%>LoadSignature();
									  setTimeout("incSig<%=k%>LoadSignature()",500);
							         //document.all.incSig<%=k%>.LoadSignature();document.all.incSig<%=k%>.LoadSignature();
								   </script>                    		
						<%}
						//文字
						if(commentType.equals("0")){
							  //内容
							  out.println(com.whir.common.util.CharacterTool.escapeHTMLTags(dealContent));
							%>
						<%}
						if(commentAccSaveName!=null&&!commentAccSaveName.equals("")&&!commentAccSaveName.equals("null")){
							 
						      String iframeHtml="<input type='hidden' name='wfAccessoryName_iframe"+k+"' id='wfAccessoryName_iframe"+k+"' value=\""+commentAccDisName+"\" />"+ 
							  " <input type='hidden' name='wfAccessorySaveName_iframe"+k+"' id='wfAccessorySaveName_iframe"+k+"' value='"+commentAccSaveName+"'/>" +
							  " <iframe name='accessoryIframe"+k+"' id='accessoryIframe"+k+"' src='"+rootPath+"/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe"+k+"&realFileNameInputId=wfAccessoryName_iframe"+k+"&saveFileNameInputId=wfAccessorySaveName_iframe"+k+"&canModify=yes &style=body{background-color:%23F6F6F6;}'  scrolling='no'  border='0' frameborder='0' width='100%' height='100%'></iframe>";
 
							  out.println(iframeHtml);  
						}%>
                       </td>
				     </tr>
					 <tr>
					   <td style="text-align:right;padding-bottom:10px;" valign="middle" >
					    <%//文字
						if(commentType.equals("0")){ 
							String realdealUserName=ub.getSignature(dealUserId).equals("")?dealUserName:("<IMG SRC='"+(smartInUse_w==1?rootPath:include_fileServer)+"/upload/peopleinfo/"+ub.getSignature(dealUserId)+"'>");

							if(commentStatus==2&&!"0".equals(""+request.getAttribute("p_wf_processType"))){
							    realdealUserName="转办人:"+realdealUserName;
							}
							%>
							<!--办理人 以及 转办 代办--->
						    <%=realdealUserName+"&nbsp;&nbsp;"+daalTimeStr+((isStandFor==1&&!standForUserName.equals("")&&!standForUserName.equals(""))?"<font color=\"blue\">(代"+standForUserName+"办理)</font>":"")+"&nbsp;&nbsp;"%> 
						<%}else{%>
						   <%=((commentStatus==2&&!"0".equals(""+request.getAttribute("p_wf_processType")))?"转办人:":"")+dealUserName+"&nbsp;&nbsp;"+daalTimeStr+"&nbsp;&nbsp;"%>
						<%}%>
					   </td>
					 </tr>
			       <%}%>	
               <%}%>
			   </table>
			 <%}%>
			 </td>
			</tr></table>  
            </td>
		 </tr>
		<%}%>
	</table>
<BR>
<%}%>
<%}%> 

<script language="javascript">
<!--
//增加批示字段对应意见到指定位置 likun 20070129
//待办 或者待阅   当前不是自动追加批示意见   并且  不是无批示意见
<%if((openType.equals("waitingDeal")||openType.equals("waitingRead"))&&!cur_commentField.equals("autoCommentField")&&!cur_commentField.equals("nullCommentField")){%>
  <%
	String SignatureId1 = new java.util.Date().getTime() + "";
  %>
 
  var cur_commentField_js='<%=cur_commentField%>_commentfield';						 
 if(cur_commentField_js.indexOf('$')!=-1){
	 cur_commentField_js = cur_commentField_js.replace(/[$]/g, "\\\$"); 
 }
 //
 var cur_commentFieldHtml="";
 var  chooseCommentRangerhtml="";
 <%if(p_wf_commentRangeByDealUser.equals("true")){%>
	   chooseCommentRangerhtml="<a href=\"javascript:;\" onclick=\"chooseCommentRanger('<%=whir_commentRangeId%>');\">批示意见范围</a>&nbsp;&nbsp;";
 <%}%>
var  attitudeTypeRadiohtml="";
<%if(p_wf_commentAttitudeTypeSet.equals("1")){%>
		attitudeTypeRadiohtml="<input name=\"radio_commentAttitudeType\"     type=\"radio\"   value=\"1\">同意 <input value=\"2\" type=\"radio\" name=\"radio_commentAttitudeType\"  >不同意&nbsp;&nbsp;&nbsp;&nbsp;"; 
<%}%>

<%if(p_wf_commentAttitudeTypeSet.equals("2")){%>
		attitudeTypeRadiohtml="<input name=\"radio_commentAttitudeType\"     type=\"radio\"   value=\"3\">已阅 <input name=\"radio_commentAttitudeType\"     type=\"radio\"   value=\"1\">同意 <input value=\"2\" type=\"radio\" name=\"radio_commentAttitudeType\"  >不同意&nbsp;&nbsp;&nbsp;&nbsp;"; 
<%}%>
 var index="";
 var useDivArr = 0;
 //复合三种审批方式
 //普通
 cur_commentFieldHtml+=
					"<div id='signTb1' style='display:'>"+
					"<div align='right'    style=\"text-align:right;width:98%;\">&nbsp;&nbsp;"+attitudeTypeRadiohtml+chooseCommentRangerhtml+"<a href=\"javascript:;\"  id=\"trigger1\"   rel=\"noteDiv\" ><!-- 常用语 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Frequentusedwords")%></a></div>"+
					" "+ 
					" "+
					"<div><textarea name=\"<%=cur_commentField%>\" id=\"<%=cur_commentField%>\"  Class=\"inputTextarea\" rows='8' style=\"width:98%;height:expression((this.scrollHeight+2)<120?120:this.scrollHeight+2)\" onblur=\"include_checkTextArea(this,'<%=Resource.getValue(localcom_comment,"workflow","workflow.activitycomment")%>',1000);\"><%=(curDraftContent==null?"":curDraftContent.replaceAll("\"","'").replaceAll("\n","&#13;&#10;").replaceAll("\r",""))%></textarea>&nbsp;<input type=\"hidden\" name=\"ru_commentRangeEmpId\" id=\"ru_commentRangeEmpId\" /><input type=\"hidden\" name=\"ru_commentRangeEmpName\" id=\"ru_commentRangeEmpName\" /></div></div>";

 //手写
 <%if(handSignInUse_w==1){%>
    cur_commentFieldHtml +=
					"<div id='signTb2' style='display:none'>"+
					"<div valign=bottom align=\"right\"><br /><button class=btnButton4font onclick=\"if (!<%=cur_commentField%>_SendOut.OpenSignature()){alert(<%=cur_commentField%>_SendOut.Status);};return false;\"><!-- 签章 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Signature")%></button></div>"+				"<div>"+
					"<OBJECT name=\"<%=cur_commentField%>_SendOut\" id=\"<%=cur_commentField%>_SendOut\" classid=\"clsid:2294689C-9EDF-40BC-86AE-0438112CA439\" codebase=\"<%=rootPath%>/public/iWebRevision.jsp/iWebRevision.cab#version=<%=public_comment_iWebVersion%>\" width=\"100%\" height=180>"
                			+"<param name=\"weburl\" value=\"<%=public_comment_iWebUrl%>\">"
            				+"<param name=\"recordid\" value=\"<%=SignatureId1%>"+index+"\">"
                			+"<param name=\"fieldname\" value=\"SendOut<%=SignatureId1%>"+index+"\">"
                			+"<param name=\"username\" value=\"<%=session.getAttribute("userName")%>\">"
                			+"<param name=\"Enabled\" value=\"1\">"
               	 			+"<param name=\"PenColor\" value=\"00000000\">"
                			+"<param name=\"BorderStyle\" value=\"0\">"
                			+"<param name=\"EditType\" value=\"0\"><param name=\"PenWidth\" value=\"1\">"
                                        +"<Param Name=\"ShowScale\" value=\"50\">"
            				+"</OBJECT>"
            				+"<input type=\"hidden\" name=\"<%=cur_commentField%>\" id=\"<%=cur_commentField%>\" value=\"<%=SignatureId1%>"+index+"\"></div>"+
					"</div>";
 <%}%>

 <%if(signatureInUse_w==1){%>
 //电子签章
//11.4 要求加换行 yuansy
 cur_commentFieldHtml +=
					"<div id='signTb3' style='position:relative;width:100%;height:130px;display:none' >"+
						//"<div valign=bottom align=\"right\"></div>&nbsp;"+
						"<div id=signPosi_<%=inc_divId_w+"0000"%> style='position:absolute;width:100%;height:100%;'><div valign=bottom align=\"right\"><br /><button class=btnButton4font onclick='include_signature(\"<%=protectField_w%>\",\"<%=inc_divId_w%>\");return false;'>  <%=Resource.getValue(localcom_comment,"workflow","workflow.Seal")%></button>&nbsp;<button class=btnButton4font onclick='include_signature2(\"<%=protectField_w%>\",\"<%=inc_divId_w%>\");return false;'><%=Resource.getValue(localcom_comment,"workflow","workflow.Sign")%></button></div><input type=\"hidden\" name=\"<%=cur_commentField%>\"  id=\"<%=cur_commentField%>\" value=\"<%=inc_divId_w+"0000"%>\"></div>"+
					"</div>";
 <%}%>
<%
 //批示意见允许上传附件
 if(whir_processCommentAcc.equals("true")){%>
     /*commentObj.innerHTML+='<div><iframe id="accessoryIframe"  name="accessoryIframe"  height="70" width="98%"  frameborder=0 scrolling=auto  src="<%=rootPath%>/work_flow/workflow_iframe_wfAccessory.jsp?accName=<%=curDraftAccName%>&accSName=<%=curDraftAccSName%>"></iframe></div>';*/

	 var ifrmaHtml='<input type="hidden" name="ezFlow_CommentAccessoryName" id="ezFlow_CommentAccessoryName"  value="<%=curDraftAccName%>" />'+  
	               '<input type="hidden" name="ezFlow_CommentAccessorySaveName" id="ezFlow_CommentAccessorySaveName" value="<%=curDraftAccSName%>"/>'+ 
	               '<iframe name="accessoryIframe" id="accessoryIframe" src="<%=rootPath%>/public/upload/uploadify/upload_include.jsp?accessType=iframe&dir=workflow_acc&uniqueId=accessoryIframe&realFileNameInputId=ezFlow_CommentAccessoryName&saveFileNameInputId=ezFlow_CommentAccessorySaveName&canModify=yes&style=body{background-color:%23F6F6F6;}"  scrolling=""  border="0" frameborder="0" width="100%" height="100%"></iframe>';
	  cur_commentFieldHtml+=ifrmaHtml;
<%}%>
 
 cur_commentFieldHtml +=
					"<div align=\"right\"><input type=\"hidden\" name=\"commentSignType\"  id=\"commentSignType\" value=\"0\"><input type=\"hidden\" name=\"commentSignIndex\"  id=\"commentSignIndex\"   value=\"0\">"+
					"<%if(handSignInUse_w==1 || signatureInUse_w==1){%><a href=\"javascript:;\" onClick=\"changeSignTypeArr('0',"+useDivArr+");return false;\"><!-- 普通 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Common")%></a>   <%}%><%if(handSignInUse_w==1){%><a href=\"javascript:;\""+ "onClick=\"changeSignTypeArr('1',"+useDivArr+");return false;\"><!-- 手写签名 --><%=Resource.getValue(localcom_comment,"workflow","workflow.Handwrittensignature")%></a>  <%}if(signatureInUse_w==1){%><a href=\"javascript:;\" onClick=\"changeSignTypeArr('2',"+useDivArr+");return false;\"><!-- 电子签章 --><%=Resource.getValue(localcom_comment,"workflow","workflow.ElectronicSignature")%></a>   <%}%></div>";
 cur_commentFieldHtml += "<div align=\"right\"><%=writeUserSignature+" "+nowdealOrgName+" "+nowTime+""%></div>";
 if($("div[id$='"+cur_commentField_js+"']").length>0){
	$("div[id$='"+cur_commentField_js+"']").eq(0).append(cur_commentFieldHtml);
 }  
			  
<%}%>

/**
检测字符数
*/
function include_checkTextArea(obj, tmp, len){
    if(obj.value.length > len){
        //alert(tmp + "不能超过" + len + "字！");
		whir_alert(tmp + "<%=Resource.getValue(localcom_comment,"workflow","workflow.notexceedy")%>" + len + "！",function(){});
        obj.focus();
    }
}
<%if(signatureInUse_w==1){%> 
    try{
	  $("#SignatureControl_w")[0].ShowSignature($("#p_wf_recordId").val());
	  <%if(oldrecorId!=null&&!oldrecorId.equals("null")&&!oldrecorId.equals("")){%>
	   // $("#SignatureControl_w")[0].ShowSignature('<%=oldrecorId%>');
	  <%}%>
	  $("#iHtmlSignature").css("position","static");
    }catch(e){
    }
<%}%>
var tt_commTD = document.getElementsByName("commTD");
var tt_commTR = document.getElementsByName("commTR");
if(tt_commTD && tt_commTR) {
    for(var ii  = 0; ii < tt_commTD.length; ii ++) {
        var tmp = tt_commTD[ii].innerHTML;
        if(tmp.indexOf("<TBODY></TBODY>") == 31) {
           tt_commTR[ii].style.display = "none";
        }
    }
}

$(document).ready(function(){
    $('#iHtmlSignature').each(function(){
        //alert($(this).attr('style').replace('static','absolute'));
        var newStyle= $(this).attr('style').replace('static','absolute');
        $(this).attr('style',newStyle)
    });
});
//-->
</script>  