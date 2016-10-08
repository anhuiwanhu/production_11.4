<%@ include file="../common/include_login.jsp"%><%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.whir.common.util.*"%><%@ page import="java.util.*"%><%@ page import="com.whir.common.db.Dbutil"%><%! 
 //获取文件办理url
    public String getDealFileDetailUrl(String workMainLinkFile){
    	if(workMainLinkFile  == null ){
    		return "";
    	}
    	if(workMainLinkFile.indexOf("/defaultroot/GovDocSendProcess!") > -1){
    		return "/defaultroot/doc/sendGovProcess.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/GovSendFileLoadAction.do") > -1){
    		return "/defaultroot/doc/sendGovProcess.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/wfopenflow!") > -1){
    		return "/defaultroot/dealfile/process.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/WorkFlowProcAction.do") > -1){
    		return "/defaultroot/dealfile/process.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/Information!") > -1){
    		return "/defaultroot/information/process.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/InformationAction.do") > -1){
    		return "/defaultroot/information/process.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/GovDocReceiveProcess!") > -1){
    		return "/defaultroot/doc/receiveGovProcess.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/GovReceiveFileLoadAction.do") > -1){
    		return "/defaultroot/doc/receiveGovProcess.controller";
    	}else if(workMainLinkFile.indexOf("/defaultroot/voitureApply!modi.action") > -1){
		    return "/defaultroot/dealfile/voitureProcess.controller";
		}else if(workMainLinkFile.indexOf("/defaultroot/outStockAction!modifyFlow.action") > -1){
			return "/defaultroot/dealfile/getOutStockResult.controller";
		}else if(workMainLinkFile.indexOf("/defaultroot/intoStockAction!modifyFlow.action") > -1){
			return "/defaultroot/dealfile/getIntoStockResult.controller";
		}else if(workMainLinkFile.indexOf("/defaultroot/GovDocSendCheckProcess!") > -1){
			return "/defaultroot/doc/sendfileCheckProcess.controller";
		}else{
    		return "/defaultroot/dealfile/process.controller";
    	}
    }
%><% 
	System.out.println("----->workflow_open.jsp");
	String contextPath = request.getContextPath();
	
	request.setCharacterEncoding("UTF-8");
	
	//是否是ezFLOW  1:是   0:不是
	String isezflow=request.getParameter("isezFlow")==null?"":request.getParameter("isezFlow").toString();
	//wf_work 表的 wf_work_id   当为 isezflow 为1 时， workId 为空，  需通过下面的sql 取出 workId
	String workId=request.getParameter("workId")==null?"":request.getParameter("workId").toString();
	//ezFLOW  任务id 
	String ezflow_taskId=request.getParameter("ezflow_taskId")==null?"":request.getParameter("ezflow_taskId").toString();
	//ezFLOW  流程实例id
	String ezflow_processInstanceId=request.getParameter("ezflow_processInstanceId")==null?"":request.getParameter("ezflow_processInstanceId").toString();
	//头像
	String empLivingPhoto = request.getParameter("empLivingPhoto") == null ? "" : "/defaultroot/upload/peopleinfo/"+request.getParameter("empLivingPhoto").toString();
	
	//--------------------根据传进来的参数信息  取流程信息-------------------
	String sql=" select wf_work_id, workmainlinkfile, workstatus, moduleid from wf_work where isezflow=:v_isezflow ";
	Map varMap=new HashMap();
	varMap.put("v_isezflow",isezflow);

	if(!"".equals(workId)){
		sql+=" and wf_work_id=:v_workId ";
		varMap.put("v_workId",workId);
	}else{
		//ezFLOW
		if(isezflow.equals("1")){
			sql += " and ezflowtaskid=:v_taskId ";
			varMap.put("v_taskId",ezflow_taskId);
			if(ezflow_processInstanceId !=null && !"".equals(ezflow_processInstanceId)){
				sql += " and ezflowprocessinstanceid=:v_processIntanceId ";
				varMap.put("v_processIntanceId",ezflow_processInstanceId);
			}
		}else{
			//workflow
			sql+=" and wf_work_id=:v_workId ";
			varMap.put("v_workId",workId);
		}
	}
	Dbutil  dbUtil=new Dbutil();
	Object []workInfoObj=null;
	try {
		workInfoObj=dbUtil.getFirstDataBySQL(sql, varMap);
	} catch (Exception e) { 
		e.printStackTrace();
	}
	
    //跳转到的打开地址
	String openUrl="";
	//pc打开地址
	String  pcopenURL="";
	String  workstatus="";

	if(workInfoObj!=null){
		//取出workId
        workId=""+workInfoObj[0];
		pcopenURL=""+workInfoObj[1];
		workstatus=""+workInfoObj[2];
	}
	
	//----------------------------根据pc打开地址 判断是哪个模块打开  start---------------------------------
	//工作流
	if(pcopenURL.indexOf("/wfopenflow!updateProcess.action")!=-1){
		openUrl = "/defaultroot/dealfile/process.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}

	//ezFLOW
	if(isezflow.equals("1")){
		openUrl = "/defaultroot/dealfile/process.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}

	//发文
	if(pcopenURL.indexOf("/GovDocSendProcess!editfile.action")!=-1){
		openUrl = contextPath + "/doc/sendGovProcess.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	
	//收文
	if(pcopenURL.indexOf("/GovDocReceiveProcess!editfile.action")!=-1){
		openUrl = contextPath + "/doc/receiveGovProcess.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	
	//送审批
	if(pcopenURL.indexOf("/GovDocSendCheckProcess!")!=-1){
		openUrl = contextPath + "/doc/sendfileCheckProcess.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	
	//信息
	if(pcopenURL.indexOf("/Information!updateProcess.action")!=-1){
		openUrl = contextPath + "/information/process.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	//车辆
	if(pcopenURL.indexOf("/voitureApply!modi.action")!=-1){
		openUrl = contextPath + "/dealfile/voitureProcess.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	//出库退库
	if(pcopenURL.indexOf("/outStockAction!modifyFlow.action")!=-1){
		openUrl = contextPath + "/dealfile/getOutStockResult.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	//进货退货
	if(pcopenURL.indexOf("/intoStockAction!modifyFlow.action")!=-1){
		openUrl = contextPath + "/dealfile/getIntoStockResult.controller?workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;
	}
	//----------------------------根据pc打开地址 判断是哪个模块打开  end---------------------------------
	//跳转到相应页面
	if(workstatus.equals("0") || workstatus.equals("2")){
		if(!openUrl.equals("")){
			try{
				response.sendRedirect(openUrl);
			}catch(Exception ex1){
				ex1.printStackTrace();
			}
		}else{
			out.print("<font style=\"font-size:40px; color:#22292c; font-weight:normal;\">地址无效！</font>");
		}
	}else{

		openUrl =  getDealFileDetailUrl(pcopenURL)+"?from=push&workStatus="+workstatus+"&workId="+workId+"&empLivingPhoto="+empLivingPhoto;;
		if(!openUrl.equals("")){
			try{
				response.sendRedirect(openUrl);
			}catch(Exception ex1){
				ex1.printStackTrace();
			}
		}else{
			out.print("<font style=\"font-size:40px; color:#22292c; font-weight:normal;\">地址无效！</font>");
		}
		//out.print("<font style=\"font-size:40px; color:#22292c; font-weight:normal;\"><script>alert('该文件您已办理完毕！')</script></font>");
	}
	return; 
%>