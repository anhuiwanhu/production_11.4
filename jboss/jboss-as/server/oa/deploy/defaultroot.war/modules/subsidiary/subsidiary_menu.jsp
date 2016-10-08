<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.resource.bd.*"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.booksmanager.bd.*"%>
<%@ page import="com.whir.ezoffice.workflow.newBD.WorkFlowBD"%>
<%@ page import="java.util.List"%>
<%@ page import="java.lang.Long"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD "%>
<%@ page import="com.whir.ezoffice.workflow.vo.*"%>
<%@ page
	import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB"%>
<%@ page
	import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD,com.whir.ezoffice.officemanager.bd.EmployeeBD"%>
<%@ page import="com.whir.ezoffice.bpm.bd.BPMProcessBD "%>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	String expNodeCode=request.getParameter("expNodeCode");
	//java中判断是否国产化客户端环境
	boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);//true-是 false-否

	int menuIndex=0;
	//此处公共业务逻辑
	ManagerBD managerBD = new ManagerBD();
	com.whir.ezoffice.workflow.newBD.ProcessBD procbd = new com.whir.ezoffice.workflow.newBD.ProcessBD();
	
	String domainId    = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
	String userId      = session.getAttribute("userId").toString();
	String orgId       = session.getAttribute("orgId").toString();
	String orgIdString = session.getAttribute("orgIdString").toString();
	
	EmployeeBD empBD=new EmployeeBD();
	List singleEmpList = empBD.selectSingle(new Long(userId));
	String sidelineorgStr = "";
	if(singleEmpList!=null&&singleEmpList.size()>0){
		Object[] __empObj = (Object[])singleEmpList.get(0);
		com.whir.org.vo.usermanager.EmployeeVO __empVO = (com.whir.org.vo.usermanager.EmployeeVO)__empObj[0];
		sidelineorgStr = __empVO.getSidelineOrg()!=null?__empVO.getSidelineOrg():"";
	}
	
	CustomerMenuDB cmdb=new CustomerMenuDB();
	String codes=",officemanager_resource,officemanager_resource_voiture,officemanager_resource_books,officemanager_resource_boardroom,officemanager_resource_equipment,officemanager_voituremanager,officemanager_goodsmanager,officemanager_humanresouce,officemanager_booksmanager,officemanager_cardmanager,officemanager_netsurvey,officemanager_question,officemanager_dossier,officemanager_meeting,officemanager_equipmentmanger,officemanager_examination,officemanager_keepwatchplan,officemanager_projectmanager,officemanager_namecard,officemanager_assetManger,officemanager_contractmanager,hospital_checkwork,hospital_scheduling,officemanager_ezcard,";
	String canShowMenus=cmdb.getShowMenu(codes,domainId);
	List archProcList = procbd.getUserProcess(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), "12");
	String[] tmpStr = {"0", "", "0", ""};
	
    //boolean setRight=managerBD.hasRight(session.getAttribute("userId").toString(), "02*02");
	BPMProcessBD bpmbd =new BPMProcessBD();
	String workflowType=com.whir.common.util.CommonUtils.getWorkflowType(domainId);
%>

<script type="text/javascript">
		var whirRootPath = "<%=rootPath%>";
		var preUrl = "<%=preUrl%>"; 
		var whir_browser = "<%=whir_browser%>"; 
	    var whir_agent = "<%=whir_agent%>"; 
	</script>

<script> 

 var zNodes =[
	  //  资源使用 -->
	    <% if(canShowMenus.indexOf("officemanager_resource")>=0 && cmdb.hasMenuAuth("officemanager_resource",session.getAttribute("userId").toString(),session.getAttribute("orgId").toString())){ %>
		   { id:"menuTitleBox<%=menuIndex%>", pId:0, name:"资源使用", target:'mainFrame',iconSkin:"fa fa"}
		   <% if(canShowMenus.indexOf("officemanager_resource_voiture")>=0){ %>
                    	,{ id:100, pId:"menuTitleBox<%=menuIndex%>", name:"车辆申请",  target:'mainFrame',url:"<%=rootPath%>/voiture!view.action?init=0",iconSkin:"fa fa"}
                        <%}%>
                        <%-- if(canShowMenus.indexOf("officemanager_resource_books")>=0){ %>
                    	,{ id:200, pId:"menuTitleBox<%=menuIndex%>", name:"资料借阅",iconSkin:"fa fa"}
                             <%
                              List libList=new LibraryBD().getMenue(request.getSession().getAttribute("orgId").toString(),request.getSession().getAttribute("userId").toString(),request.getSession(true).getAttribute("orgIdString").toString());
                              for(int i0=0; i0<libList.size(); i0++){
                                  ArrayList libObj=(ArrayList)libList.get(i0);
                                   int index1=200+i0+1;
                                  if(libObj.get(3)!=null&&"1".equals(libObj.get(3).toString())){
                                  
                              %>
                            ,{ id:'<%=index1%>', pId:200, name:"<%=libObj.get(2)%>",  target:'mainFrame',url:"<%=rootPath%>/books!list_2.action?init=0&libraryId=<%=libObj.get(1)%>&manageContent=<%=libObj.get(3)%>",iconSkin:"fa fa"}
                              <%}else{%>
                            ,{ id:'<%=index1%>', pId:200, name:"<%=libObj.get(2)%>",  target:'mainFrame',url:"<%=rootPath%>/books!list.action?init=0&libraryId=<%=libObj.get(1)%>&manageContent=<%=libObj.get(3)%>",iconSkin:"fa fa"}
                              <%}}%>
                        <%}--%>
                        <% if(canShowMenus.indexOf("officemanager_resource_boardroom")>=0){ %>
                    	,{ id:300, pId:"menuTitleBox<%=menuIndex%>", name:"会议室申请",  target:'mainFrame',url:"<%=rootPath%>/boardRoom!boardRoomView.action?init=0&type=dayView",iconSkin:"fa fa"}
                        <%}%>
                        <%-- if(canShowMenus.indexOf("officemanager_resource_equipment")>=0){ %>
                    	,{ id:400, pId:"menuTitleBox<%=menuIndex%>", name:"设备申请",  target:'mainFrame',url:"<%=rootPath%>/equipment!equipmentView.action?init=0",iconSkin:"fa fa"}
                        <%}--%>
				<%}%>
		   
		  	<%menuIndex++;%>
			<% if(canShowMenus.indexOf("officemanager_voituremanager")>=0 && cmdb.hasMenuAuth("officemanager_voituremanager",userId,orgId)){ 
				//String voitureMtRight  = request.getAttribute("voitureMtRight")+"" ;
				boolean voitureMtRight = managerBD.hasRight(userId, "07*14*02");
			%>
		  ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"车辆管理", target:'mainFrame',iconSkin:"fa fa"}
		    		,{ id:101, pId:"menuTitleBox<%=menuIndex%>", name:"车辆信息",  target:'mainFrame',url:"<%=rootPath%>/voiture!view.action",iconSkin:"fa fa"}
                   ,{ id:202, pId:"menuTitleBox<%=menuIndex%>", name:"使用记录",  target:'mainFrame',url:"<%=rootPath%>/voitureApply!uselist.action?ismenu=1",iconSkin:"fa fa"}
                     <%if(voitureMtRight) {%>
                   ,{ id:303, pId:"menuTitleBox<%=menuIndex%>", name:"取消用车",  target:'mainFrame',url:"<%=rootPath%>/voitureCancel!view.action",iconSkin:"fa fa"}
                   ,{ id:404, pId:"menuTitleBox<%=menuIndex%>", name:"车辆费用",  target:'mainFrame',url:"<%=rootPath%>/voitureFee!voitureview.action",iconSkin:"fa fa"}
                     <%}%>
                     <% if(managerBD.hasRight(session.getAttribute("userId").toString(), "07*14*04")){%>
                   ,{ id:505, pId:"menuTitleBox<%=menuIndex%>", name:"报表统计",  target:'mainFrame',url:"<%=rootPath%>/reportForms!list.action",iconSkin:"fa fa"}
                   ,{ id:606, pId:"menuTitleBox<%=menuIndex%>", name:"反馈统计",  target:'mainFrame',url:"<%=rootPath%>/voitureSend!reedBackAStat.action?feedlist=1",iconSkin:"fa fa"}
                     <%}%>
                     <%if(voitureMtRight && isForbiddenPad) {%>
                   ,{ id:707, pId:"menuTitleBox<%=menuIndex%>", name:"设置",iconSkin:"fa fa"}
                   ,{ id:708, pId:707, name:"车辆类别",  target:'mainFrame',url:"<%=rootPath%>/voitureType!view.action",iconSkin:"fa fa"}
					 <%
					 //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
					 if(workflowType.equals("1") || workflowType.equals("2")){	 
					 %>
                   ,{ id:709, pId:707, name:"流程定义",  target:'mainFrame',url:"<%=rootPath%>/wfprocess!processList.action?moduleId=11",iconSkin:"fa fa"}
					 <%}%>
					 <%if(workflowType.equals("0") || workflowType.equals("2")){%>
					 ,{ id:710, pId:707, name:"流程定义(ezFLOW)",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=11",iconSkin:"fa fa"}
					 <%}%>
                     <%}%>
		   
		   	<%}%>
		//-----资料管理------	
		  <%--  menuIndex++;%>
          <%if(canShowMenus.indexOf("officemanager_booksmanager")>=0 && cmdb.hasMenuAuth("officemanager_booksmanager",userId,orgId)){ 
            BooksBD bookbd=new BooksBD();
            boolean right1=false;
            boolean right2=false;
            if(managerBD.hasRightTypeName(userId, "资料管理","维护")){
                right1=true;
            }
            if(managerBD.hasRight(userId, "07*18*02")){
                right2=true;
            }
        %>
		  ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"资料管理", target:'mainFrame',iconSkin:"fa fa"}
		 <%
         LibraryBD lbd=new LibraryBD();
         List lm=lbd.getMenue(session.getAttribute("orgId").toString(),session.getAttribute("userId").toString(),
             session.getAttribute("orgIdString").toString());
          List cqList=lbd.getMenue4(session.getAttribute("orgId").toString(),session.getAttribute("userId").toString(),session.getAttribute("orgIdString").toString());
         %> 
		  ,{ id:100001, pId:"menuTitleBox<%=menuIndex%>", name:"资料信息",iconSkin:"fa fa"}
                      <%
                        if(lm.size() > 0){
                            for(int i=0;i<lm.size();i++){
                                ArrayList _lm=(ArrayList)lm.get(i);
                                if(_lm.get(3)!=null&&"1".equals(_lm.get(3).toString())){
                      %>
                        ,{ id:<%=100001+i+1%>, pId:100001, name:"<%=_lm.get(2)%>",  target:'mainFrame',url:"<%=rootPath%>/books!list_2.action?libraryId=<%=_lm.get(1)%>&manageContent=<%=_lm.get(3)%>",iconSkin:"fa fa"}
                       <%}else{%>
                     ,{ id:<%=100001+i+1%>, pId:100001, name:"<%=_lm.get(2)%>",  target:'mainFrame',url:"<%=rootPath%>/books!list.action?libraryId=<%=_lm.get(1)%>&manageContent=<%=_lm.get(3)%>",iconSkin:"fa fa"}
                       <%}}}%>
                      ,{ id:2000001, pId:"menuTitleBox<%=menuIndex%>", name:"使用记录",iconSkin:"fa fa"}
                      <%
                        if(lm.size() > 0){
                            for(int i=0;i<lm.size();i++){
                                ArrayList _lm=(ArrayList)lm.get(i);
                      %>
                     ,{ id:<%=2000001+i+1%>, pId:2000001, name:"<%=_lm.get(2)%>",  target:'mainFrame',url:"<%=rootPath%>/borrowApply!list.action?libraryId=<%=_lm.get(1)%>&manageContent=<%=_lm.get(3)%>",iconSkin:"fa fa"}
                       <%}}%>
                        <%
                        if(cqList.size() > 0){
                        %>
                        ,{ id:3000001, pId:"menuTitleBox<%=menuIndex%>", name:"超期列表",iconSkin:"fa fa"}
                      <%
                            for(int i=0;i<cqList.size();i++){
                                ArrayList _lm=(ArrayList)cqList.get(i);
                      %>
                     ,{ id:<%=3000001+i+1%>, pId:3000001, name:"<%=_lm.get(2)%>",  target:'mainFrame',url:"<%=rootPath%>/borrowApply!listOver.action?libraryId=<%=_lm.get(1)%>&manageContent=<%=_lm.get(3)%>",iconSkin:"fa fa"}
                       <%}}%>
                     
                     <%
                         List lm2=lbd.getMenue2(session.getAttribute("orgId").toString(),session.getAttribute("userId").toString(),session.getAttribute("orgIdString").toString());
                        // if((right1||(lm2!=null&&lm2.size()>0)) && isForbiddenPad){
							if((right1) && isForbiddenPad){
                     %>
                   ,{ id:400001, pId:"menuTitleBox<%=menuIndex%>", name:"设置",iconSkin:"fa fa"}
                   ,{ id:400002, pId:400001, name:"资料室",  target:'mainFrame',url:"<%=rootPath%>/library!list.action",iconSkin:"fa fa"}
                   ,{ id:400003, pId:400001, name:"登记类型",  target:'mainFrame',url:"<%=rootPath%>/recordType!list.action",iconSkin:"fa fa"}
                   ,{ id:400004, pId:400001, name:"资料分类",  target:'mainFrame',url:"<%=rootPath%>/booksType!list.action",iconSkin:"fa fa"}   
                     <%}%>
		   		 <%} ---%>
		   		 
		  //  物品管理
		     <%if(canShowMenus.indexOf("officemanager_goodsmanager")>=0 && cmdb.hasMenuAuth("officemanager_goodsmanager",userId,orgId)){%>
        		<%menuIndex++;%>
		    	,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"物品管理", target:'mainFrame',iconSkin:"fa fa"}
				<%
				  String goodsTableId = request.getAttribute("goodsTableId")==null?"":request.getAttribute("goodsTableId").toString();
				  com.whir.ezoffice.resource.bd.StockBD sfbd = new com.whir.ezoffice.resource.bd.StockBD();
				  com.whir.ezoffice.resource.bd.IntoOutStockBD iobd= new com.whir.ezoffice.resource.bd.IntoOutStockBD();
				  WorkFlowBD wfBD = new WorkFlowBD();
				  List procList = wfBD.getModuleProc("13");
				  List stockList = new StockBD().getUserManaStock(userId, domainId);
				  Object[] stockObj = null;
				  int x=10001;
				%>
		    <%
                      if((stockList!= null && stockList.size()>0) || managerBD.hasRightType(userId, "物品管理-仓库管理")){
                    %>
                  ,{ id:1000000000, pId:"menuTitleBox<%=menuIndex%>", name:"采购进货", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    <%
                      if(stockList != null && stockList.size() > 0){
                      	  String goodsProcessId   = "null";
                      	  String goodsRemindField = "null";
                      	  String goodProcessType  = "null";
                      	  String goodsProcessName = "null";
                      	  for(int j = 0; j < stockList.size(); j ++){
                      	  	  stockObj = (Object[]) stockList.get(j);
                      	  	  x++;
                      	  	  String sss = stockObj[2].toString().trim();
                      	  	  String aaa = "";
                      	  	  if(sss.length()<4){
                      	  	  	  for(int iii=0; iii<4-sss.length();iii++){
                      	  	  	  	  aaa += "0";
                      	  	  	  }
                      	  	  }
                      	  	  sss += aaa;
                      	  	  if(stockObj[2]!=null&&"1".equals(sss.substring(0,1))){
                      	  	  	  List list11 = iobd.getWFProcessInfoByStockId(stockObj[0].toString(), "0");
                      	  	  	  if(list11!=null&&list11.size()>0){
                      	  	  	  	  Object _aa1 = (Object)list11.get(1);
                      	  	  	  	  for(int k=0; k<procList.size(); k++){
                      	  	  	  	  	  Object[] pp = (Object[])procList.get(k);
                      	  	  	  	  	  if(String.valueOf(_aa1).equals(String.valueOf(pp[0]))){
                      	  	  	  	  	  	  goodsProcessId   = String.valueOf(pp[0]);
                      	  	  	  	  	  	  goodsRemindField = String.valueOf(pp[1]);
                      	  	  	  	  	  	  goodProcessType  = String.valueOf(pp[2]);
                      	  	  	  	  	  	  goodsProcessName = String.valueOf(pp[3]);
                      	  	  	  	  	  	  break;
                      	  	  	  	  	  }
                      	  	  	  	  }
                      	  	  	  }
                      	  	  }
                    %>
                  ,{ id:<%=x%>, pId:1000000000, name:"<%=stockObj[1]%>", url:encodeURI("<%=rootPath%>/intoStockAction!list.action?stockId=<%=stockObj[0]%>&stockName=<%=stockObj[1]%>&processName=<%=goodsProcessName%>&processType=<%=goodProcessType%>&processId=<%=goodsProcessId%>&remindField=<%=goodsRemindField%>&tableId=<%=goodsTableId%>&mode=stock"), target:'mainFrame',iconSkin:"fa fa"}
                    <%
                              goodsProcessId   = "null";
				              goodsRemindField = "null";
				              goodProcessType  = "null";
				              goodsProcessName = "null";
                          }
                      }
                      }
                    %>
                    
                  ,{ id:1000000001, pId:"menuTitleBox<%=menuIndex%>", name:"领用出库", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    <%
                      x=20001;
                      //增加对兼职组织的支持
                      String __sidelineorgWhere = "";
                      if(!"".equals(sidelineorgStr)){
                      	  if(sidelineorgStr.startsWith("*")&&sidelineorgStr.endsWith("*")){
                      	  	  String ___tmp = sidelineorgStr.substring(1,sidelineorgStr.length()-1);
                      	  	  String[] ___tmpArr = ___tmp.split("\\*\\*");
                      	  	  for(int _i0=0; _i0<___tmpArr.length; _i0++){
                      	  	  	  __sidelineorgWhere += " or aaa.stockApplyExtensionId like '%*"+___tmpArr[_i0]+"*%' ";
                      	  	  }
                      	  }
                      }
                      String stockWhere = managerBD.getScopeFinalWhere(userId, orgId, orgIdString, "aaa.stockApplyExtensionId", "aaa.stockApplyExtensionId", "aaa.stockApplyExtensionId");
                      stockWhere += " or aaa.stockPut like '%$" + userId + "$%' "+__sidelineorgWhere;
                      List allStockList = new StockBD().getStockIDName(domainId, stockWhere);
                      if(allStockList != null && allStockList.size() > 0){
                      	  String goodsProcessId   = "null";
                      	  String goodsRemindField = "null";
                      	  String goodProcessType  = "null";
                      	  String goodsProcessName = "null";
                      	  for(int j = 0; j < allStockList.size(); j ++){
                      	  	  stockObj = (Object[]) allStockList.get(j);
                      	  	  x++;
                      	  	  String sss = stockObj[2].toString().trim();
                      	  	  String aaa = "";
                      	  	  if(sss.length()<4){
                      	  	  	  for(int iii=0; iii<4-sss.length();iii++){
                      	  	  	  	  aaa += "0";
                      	  	  	  }
                      	  	  }
                      	  	  sss += aaa;
                      	  	  if(stockObj[2]!=null&&"1".equals(sss.substring(1,2))){
                      	  	  	  List list22 = iobd.getWFProcessInfoByStockId(stockObj[0].toString(), "1");
                      	  	  	  if(list22!=null&&list22.size()>0){
                      	  	  	  	  Object _aa2 = (Object)list22.get(1);
                      	  	  	  	  for(int k=0; k<procList.size(); k++){
                      	  	  	  	  	  Object[] pp = (Object[])procList.get(k);
                      	  	  	  	  	  if(String.valueOf(_aa2).equals(String.valueOf(pp[0]))){
                      	  	  	  	  	  	  goodsProcessId   = String.valueOf(pp[0]);
                      	  	  	  	  	  	  goodsRemindField = String.valueOf(pp[1]);
                      	  	  	  	  	  	  goodProcessType  = String.valueOf(pp[2]);
                      	  	  	  	  	  	  goodsProcessName = String.valueOf(pp[3]);
                      	  	  	  	  	  	  break;
                      	  	  	  	  	  }
                      	  	  	  	  }
                      	  	  	  }
                      	  	  }
                    %>
                  ,{ id:<%=x%>, pId:1000000001, name:"<%=stockObj[1]%>", url:encodeURI("<%=rootPath%>/outStockAction!list.action?stockId=<%=stockObj[0]%>&stockName=<%=stockObj[1]%>&processName=<%=goodsProcessName%>&processType=<%=goodProcessType%>&processId=<%=goodsProcessId%>&remindField=<%=goodsRemindField%>&tableId=<%=goodsTableId%>&mode=outStock"), target:'mainFrame',iconSkin:"fa fa"}
                    <%
                              goodsProcessId   = "null";
                              goodsRemindField = "null";
                              goodProcessType  = "null";
                              goodsProcessName = "null";
                          }
                      }
                    %>
                    
                  ,{ id:1000000002, pId:"menuTitleBox<%=menuIndex%>", name:"领用退库", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    <%
                      x=30001;
                      if(allStockList != null && allStockList.size() > 0){
                      	  String goodsProcessId   = "null";
                      	  String goodsRemindField = "null";
                      	  String goodProcessType  = "null";
                      	  String goodsProcessName = "null";
                      	  for(int j = 0; j < allStockList.size(); j ++){
                      	  	  stockObj = (Object[]) allStockList.get(j);
                      	  	  x++;
                      	  	  String sss = stockObj[2].toString().trim();
                      	  	  String aaa = "";
                      	  	  if(sss.length()<4){
                      	  	  	  for(int iii=0; iii<4-sss.length();iii++){
                      	  	  	  	  aaa += "0";
                      	  	  	  }
                      	  	  }
                      	  	  sss += aaa;
                      	  	  if(stockObj[2]!=null&&"1".equals(sss.substring(2,3))){
                      	  	  	  List list33 = iobd.getWFProcessInfoByStockId(stockObj[0].toString(), "2");
                      	  	  	  if(list33!=null&&list33.size()>0){
                      	  	  	  	  Object _aa3 = (Object)list33.get(1);
                      	  	  	  	  for(int k=0; k<procList.size(); k++){
                      	  	  	  	  	  Object[] pp = (Object[])procList.get(k);
                      	  	  	  	  	  if(String.valueOf(_aa3).equals(String.valueOf(pp[0]))){
                      	  	  	  	  	  	  goodsProcessId   = String.valueOf(pp[0]);
                      	  	  	  	  	  	  goodsRemindField = String.valueOf(pp[1]);
                      	  	  	  	  	  	  goodProcessType  = String.valueOf(pp[2]);
                      	  	  	  	  	  	  goodsProcessName = String.valueOf(pp[3]);
                      	  	  	  	  	  	  break;
                      	  	  	  	  	  }
                      	  	  	  	  }
                      	  	  	  }
                      	  	  }
                    %>
                  ,{ id:<%=x%>, pId:1000000002, name:"<%=stockObj[1]%>", url:encodeURI("<%=rootPath%>/outStockAction!list.action?stockId=<%=stockObj[0]%>&stockName=<%=stockObj[1]%>&processName=<%=goodsProcessName%>&processType=<%=goodProcessType%>&processId=<%=goodsProcessId%>&remindField=<%=goodsRemindField%>&tableId=<%=goodsTableId%>&mode=returnStock"), target:'mainFrame',iconSkin:"fa fa"}
                    <%
                              goodsProcessId   = "null";
                              goodsRemindField = "null";
                              goodProcessType  = "null";
                              goodsProcessName = "null";
                          }
                      }
                    %>
                    
                    <%if((stockList!= null && stockList.size()>0) || managerBD.hasRightType(userId, "物品管理-仓库管理")){%>
                  ,{ id:1000000003, pId:"menuTitleBox<%=menuIndex%>", name:"物品退货", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    <%
                      x=40001;
                      if(stockList != null && stockList.size() > 0){
                      	  String goodsProcessId   = "null";
                      	  String goodsRemindField = "null";
                      	  String goodProcessType  = "null";
                      	  String goodsProcessName = "null";
                      	  for(int j = 0; j < stockList.size(); j ++){
                      	  	  stockObj = (Object[]) stockList.get(j);
                      	  	  x++;
                      	  	  String sss = stockObj[2].toString().trim();
                      	  	  String aaa = "";
                      	  	  if(sss.length()<4){
                      	  	  	  for(int iii=0; iii<4-sss.length();iii++){
                      	  	  	  	  aaa += "0";
                      	  	  	  }
                      	  	  }
                      	  	  sss += aaa;
                      	  	  if(stockObj[2]!=null&&"1".equals(sss.substring(3,4))){
                      	  	  	  List list44 = iobd.getWFProcessInfoByStockId(stockObj[0].toString(), "3");
                      	  	  	  if(list44!=null&&list44.size()>0){
                      	  	  	  	  Object _aa4 = (Object)list44.get(1);
                      	  	  	  	  for(int k=0; k<procList.size(); k++){
                      	  	  	  	  	  Object[] pp = (Object[])procList.get(k);
                      	  	  	  	  	  if(String.valueOf(_aa4).equals(String.valueOf(pp[0]))){
                      	  	  	  	  	  	  goodsProcessId   = String.valueOf(pp[0]);
                      	  	  	  	  	  	  goodsRemindField = String.valueOf(pp[1]);
                      	  	  	  	  	  	  goodProcessType  = String.valueOf(pp[2]);
                      	  	  	  	  	  	  goodsProcessName = String.valueOf(pp[3]);
                      	  	  	  	  	  	  break;
                      	  	  	  	  	  }
                      	  	  	  	  }
                      	  	  	  }
                      	  	  }
                    %>
                  ,{ id:<%=x%>, pId:1000000003, name:"<%=stockObj[1]%>", url:encodeURI("<%=rootPath%>/intoStockAction!list.action?stockId=<%=stockObj[0]%>&stockName=<%=stockObj[1]%>&processName=<%=goodsProcessName%>&processType=<%=goodProcessType%>&processId=<%=goodsProcessId%>&remindField=<%=goodsRemindField%>&tableId=<%=goodsTableId%>&mode=salesreturn"), target:'mainFrame',iconSkin:"fa fa"}
                    <%
                              goodsProcessId   = "null";
                              goodsRemindField = "null";
                              goodProcessType  = "null";
                              goodsProcessName = "null";
                          }
                      }
                    %>
                    <%}%>
                    
                    <%if(managerBD.hasRightType(userId, "物品管理-统计报表")){%>
                  ,{ id:1000000004, pId:"menuTitleBox<%=menuIndex%>", name:"统计报表", url:"<%=rootPath%>/reportFormsAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
                    
                    <%if((stockList!= null && stockList.size()>0) || managerBD.hasRightType(userId, "物品管理-仓库管理")){%>
                    <%if(isForbiddenPad){%>
                  ,{ id:1000000005, pId:"menuTitleBox<%=menuIndex%>", name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    	<%if(managerBD.hasRightType(userId, "物品管理-仓库管理")){%>
                    	,{ id:1100000001, pId:1000000005, name:"仓库管理", url:"<%=rootPath%>/stockAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    	<%}%>
                    	,{ id:1100000002, pId:1000000005, name:"物品类别", url:"<%=rootPath%>/goodsTypeAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:1100000003, pId:1000000005, name:"物品信息", url:"<%=rootPath%>/goodsAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:1100000004, pId:1000000005, name:"<bean:message bundle="managementtools" key="official.Supplyunit" />", url:"<%=rootPath%>/supplyUnit!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:1100000005, pId:1000000005, name:"<bean:message bundle="managementtools" key="official.Materialssectorled" />", url:"<%=rootPath%>/drawDeptAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    	<%if(managerBD.hasRightType(userId, "物品管理-仓库管理")){%>
                    	,{ id:1100000006, pId:1000000005, name:"类别定义", url:"<%=rootPath%>/typeDefine!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    	<%}%>
                    <%}}%>
		    <%}%>
		   
		 <%menuIndex++;%>
       // 资产管理
        <% if(canShowMenus.indexOf("officemanager_assetManger")>=0 && cmdb.hasMenuAuth("officemanager_assetManger",userId,orgId)){ 
        %>
		 ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"资产管理", target:'mainFrame',iconSkin:"fa fa"}
		    <% if(managerBD.hasRight(session.getAttribute("userId").toString(), "2011*0105*01")||managerBD.hasRight(session.getAttribute("userId").toString(), "2011*0105*02")){%>
                  ,{ id:50001, pId:"menuTitleBox<%=menuIndex%>", name:"资产采购",  target:'mainFrame',url:"<%=rootPath%>/assetApply!assetApplyList.action",iconSkin:"fa fa"}
                    <%}%>
                    <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "2011*0105*03")||managerBD.hasRight(session.getAttribute("userId").toString(), "2011*0105*04")){%>
                  ,{ id:50002, pId:"menuTitleBox<%=menuIndex%>", name:"资产信息",  target:'mainFrame',url:"<%=rootPath%>/assetInfo!assetInfoList.action",iconSkin:"fa fa"}
                    <%}%>
                    <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "2011*0325*01")){%>
                  ,{ id:50003, pId:"menuTitleBox<%=menuIndex%>", name:"办理查阅",  target:'mainFrame',url:"<%=rootPath%>/assetApply!assetApplyDealList.action",iconSkin:"fa fa"}
                    <%}%>
                    <%if(isForbiddenPad && managerBD.hasRight(session.getAttribute("userId").toString(), "2011*0105*05")){%>
                  ,{ id:50004, pId:"menuTitleBox<%=menuIndex%>", name:"设置",iconSkin:"fa fa"}
                  ,{ id:500041, pId:50004, name:"采购类别",  target:'mainFrame',url:"<%=rootPath%>/assetSetup!applyClassList.action",iconSkin:"fa fa"}
                  ,{ id:500042, pId:50004, name:"资产类别",  target:'mainFrame',url:"<%=rootPath%>/assetSetup!assetClassList.action",iconSkin:"fa fa"}
                  ,{ id:500043, pId:50004, name:"采购单编号",  target:'mainFrame',url:"<%=rootPath%>/assetSetup!assetCodeList.action?codeClass=2",iconSkin:"fa fa"}
                  ,{ id:500044, pId:50004, name:"资产编号",  target:'mainFrame',url:"<%=rootPath%>/assetSetup!assetCodeList.action?codeClass=1",iconSkin:"fa fa"}
                  ,{ id:500045, pId:50004, name:"存放地点",  target:'mainFrame',url:"<%=rootPath%>/assetSetup!assetPlaceList.action",iconSkin:"fa fa"}
                  ,{ id:500046, pId:50004, name:"自定义字段",  target:'mainFrame',url:"<%=rootPath%>/hrextension!filed_list.action?module=ASSET",iconSkin:"fa fa"}
                   <%
					 //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
					 if(workflowType.equals("1") || workflowType.equals("2")){	 
					 %>
                   ,{ id:500047, pId:50004, name:"流程定义",  target:'mainFrame',url:"<%=rootPath%>/wfprocess!processList.action?moduleId=110",iconSkin:"fa fa"}
					 <%}%>
					 <%if(workflowType.equals("0") || workflowType.equals("2")){%>
					 ,{ id:500048, pId:50004, name:"流程定义(ezFLOW)",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=110",iconSkin:"fa fa"}
					 <%}%>                   
                  <%}%>
		    <%}%>
		    <%menuIndex++;%>
			// 项目管理 
			<% if(canShowMenus.indexOf("officemanager_projectmanager")>=0  && cmdb.hasMenuAuth("officemanager_projectmanager",session.getAttribute("userId").toString(),session.getAttribute("orgId").toString())){ %>
		 ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"项目管理", target:'mainFrame',iconSkin:"fa fa"}
		   	<%if(managerBD.hasRight(String.valueOf(userId), "PJ*01*01")){%>
                  ,{ id:600001, pId:"menuTitleBox<%=menuIndex%>", name:"立项申请",  target:'_blank',click:"openWin({url:'<%=rootPath%>/project!selectWorkFlow.action',width:560,height:180,winName:'selectWorkFlow'});",iconSkin:"fa fa"}
                    <%}%>
                  ,{ id:600002, pId:"menuTitleBox<%=menuIndex%>", name:"我的项目",  target:'mainFrame',url:"<%=rootPath%>/project!projectMyList.action",iconSkin:"fa fa"}
                  ,{ id:600003, pId:"menuTitleBox<%=menuIndex%>", name:"我的任务",  target:'mainFrame',url:"<%=rootPath%>/projectTask!projectTaskMyList.action",iconSkin:"fa fa"}
                    <%if(managerBD.hasRight(String.valueOf(userId), "PJ*01*01")){%>
                  ,{ id:600004, pId:"menuTitleBox<%=menuIndex%>", name:"项目模板",  target:'mainFrame',url:"<%=rootPath%>/projectModel!projectModelSortList.action",iconSkin:"fa fa"}
                    <%}%>
                    <%if(managerBD.hasRight(String.valueOf(userId), "PJ*01*02")){%>
                  ,{ id:600005, pId:"menuTitleBox<%=menuIndex%>", name:"项目查询",  target:'mainFrame',url:"<%=rootPath%>/project!projectList.action",iconSkin:"fa fa"}
                  ,{ id:600006, pId:"menuTitleBox<%=menuIndex%>", name:"项目预算统计",  target:'mainFrame',url:"<%=rootPath%>/projectBudget!budgetList.action?fromFlag=budgetStaticstic",iconSkin:"fa fa"}
                    <%}%>
                    <%if(managerBD.hasRight(String.valueOf(userId), "PJ*01*03")){%>
                  ,{ id:600007, pId:"menuTitleBox<%=menuIndex%>", name:"设置",iconSkin:"fa fa"}
                  ,{ id:6000071, pId:600007, name:"项目类型",  target:'mainFrame',url:"<%=rootPath%>/projectType!projectTypeList.action",iconSkin:"fa fa"}
                     <%
					 //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
					 if(workflowType.equals("1") || workflowType.equals("2")){	 
					 %>
                     ,{ id:6000072, pId:600007, name:"流程定义",  target:'mainFrame',url:"<%=rootPath%>/wfprocess!processList.action?moduleId=91",iconSkin:"fa fa"}
					 <%}%>
					 <%if(workflowType.equals("0") || workflowType.equals("2")){%>
					 ,{ id:6000073, pId:600007, name:"流程定义(ezFlow)",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=91",iconSkin:"fa fa"}
					 <%}%>                        
                  ,{ id:6000074, pId:600007, name:"项目模板",  target:'mainFrame',url:"<%=rootPath%>/projectModel!projectModelList.action",iconSkin:"fa fa"}
                  ,{ id:6000075, pId:600007, name:"自定义字段",  target:'mainFrame',url:"<%=rootPath%>/hrextension!filed_list.action?module=project",iconSkin:"fa fa"}
                    <%}%>
				 <%}%>
			<%menuIndex++;%>
			//  网上调查 
			<% if(canShowMenus.indexOf("officemanager_netsurvey")>=0 && managerBD.hasRightTypeName(userId, "网上调查","维护") && cmdb.hasMenuAuth("officemanager_netsurvey",userId,orgId)){ %>	 
			 ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"网上调查", target:'mainFrame',url:"<%=rootPath%>/lookInto!lookIntoList.action','','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600')",iconSkin:"fa fa"}
			  <%}%>
			<%menuIndex++;%>
			// 问卷调查 
			<% if(canShowMenus.indexOf("officemanager_question")>=0 && managerBD.hasRightTypeName(userId, "问卷管理","维护")&&cmdb.hasMenuAuth("officemanager_question",session.getAttribute("userId").toString(),session.getAttribute("orgId").toString())){ %>	 
			,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"问卷调查", target:'mainFrame',iconSkin:"fa fa"}
			 ,{ id:7000001, pId:"menuTitleBox<%=menuIndex%>", name:"问卷管理", url:"<%=rootPath%>/questionnaire!questionnaireList.action", target:'mainFrame',iconSkin:"fa fa"}
           ,{ id:7000002, pId:"menuTitleBox<%=menuIndex%>", name:"答卷管理", url:"<%=rootPath%>/questionnaire!questionnaireAnswerList.action", target:'mainFrame',iconSkin:"fa fa"}
		   <%}%>
		   
		// 会务管理
        <%menuIndex++;%>
        <% if(canShowMenus.indexOf("officemanager_meeting")>=0 && cmdb.hasMenuAuth("officemanager_meeting",userId,orgId)){ %>
		,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"会务管理", target:'mainFrame',iconSkin:"fa fa"}
		 ,{ id:8000001, expNodeCode:"meetingInfo", pId:"menuTitleBox<%=menuIndex%>", name:"会议通知",  target:'mainFrame',url:"<%=rootPath%>/boardRoom!meetingInformView.action?type=day",iconSkin:"fa fa"}
                        <%
                        archProcList = procbd.getUserProcess(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), "15");
                        tmpStr = new String[]{"0", "", "0", ""};
                        if(archProcList != null && archProcList.size() > 0){
                        Object[] rfObj = (Object[]) archProcList.get(0);
                        tmpStr[0] = rfObj[2] + "";
                        tmpStr[2] = rfObj[4] + "";
                        tmpStr[3] = rfObj[3] + "";
                        }
                        %>
					<%if(isForbiddenPad){%>
                  ,{ id:8000002, pId:"menuTitleBox<%=menuIndex%>", name:"会议室信息",  target:'mainFrame',url:"<%=rootPath%>/boardRoom!boardRoomView.action?processId=<%=tmpStr[0]%>&remindField=&tableId=<%=tmpStr[2]%>&moduleId=15",iconSkin:"fa fa"}
					<%}%>
                  ,{ id:8000003, pId:"menuTitleBox<%=menuIndex%>", name:"使用记录",  target:'mainFrame',url:"<%=rootPath%>/boardRoom!useBoardroomView.action",iconSkin:"fa fa"}
                    <%if(managerBD.hasRightTypeName(userId, "会务管理","维护") && isForbiddenPad){%>
                  ,{ id:8000004, pId:"menuTitleBox<%=menuIndex%>", name:"设置",iconSkin:"fa fa"}
					,{ id:80000041, pId:8000004, name:"会议类型",  target:'mainFrame',url:"<%=rootPath%>/boardRoom!boardRoomApplyTypeList.action",iconSkin:"fa fa"}
                  ,{ id:80000042, pId:8000004, name:"流程定义",iconSkin:"fa fa"}
					<%
					 //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
					 if(workflowType.equals("1") || workflowType.equals("2")){	 
					%>
                  ,{ id:800000421, pId:80000042, name:"会议室申请流程",  target:'mainFrame',url:"<%=rootPath%>/wfprocess!processList.action?moduleId=15",iconSkin:"fa fa"}
					<%}%>
					<%if(workflowType.equals("0") || workflowType.equals("2")){%>
					,{ id:800000422, pId:80000042, name:"会议室申请流程(ezFLOW)",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=15",iconSkin:"fa fa"}
					<%}%>
					<%
					 //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
					 if(workflowType.equals("1") || workflowType.equals("2")){	 
					%>
                  ,{ id:800000423, pId:80000042, name:"会议转批流程",  target:'mainFrame',url:"<%=rootPath%>/wfprocess!processList.action?moduleId=16",iconSkin:"fa fa"}
					<%}%>
					<%if(workflowType.equals("0") || workflowType.equals("2")){%>
					,{ id:800000424, pId:80000042, name:"会议转批流程(ezFLOW)",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=16",iconSkin:"fa fa"}
					
					,{ id:800000425, pId:8000004, name:"审批表单",  target:'mainFrame',url:"<%=rootPath%>/EzForm!initFormList.action?wfModuleId=15",iconSkin:"fa fa"}
					<%if(!isCOSClient){%>
					,{ id:800000426, pId:8000004, name:"会议通知预览",  click:"openWin({url:'<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=yes&moduleType=boardroom',isResizable: 'true',width:800,height:600,isFull: true,winName:'_blank'});",iconSkin:"fa fa"}
					<%}%>
					<%}%>
                    <%}%>
		    <%}%>
			
			 <%--menuIndex++;%>
			// 设备管理 
			<% if(canShowMenus.indexOf("officemanager_equipmentmanger")>=0 && cmdb.hasMenuAuth("officemanager_equipmentmanger",userId,orgId)){ %>
		 ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"设备管理", target:'mainFrame',iconSkin:"fa fa"}
		     <%
                    tmpStr = new String[]{"0", "", "0", ""};
                    archProcList = procbd.getUserProcess(session.getAttribute("userId").toString(), session.getAttribute("orgIdString").toString(), "14");
                    tmpStr[0] = "0";
                    tmpStr[1] = "";
                    tmpStr[2] = "0";
                    tmpStr[3] = "";
                    if(archProcList != null && archProcList.size() > 0){
                      Object[] rfObj = (Object[]) archProcList.get(0);
                      tmpStr[0] = rfObj[2] + "";
                      tmpStr[2] = rfObj[4] + "";
                      tmpStr[3] = rfObj[3] + "";
                    }
                    %>
					<%if(isForbiddenPad){%>
                  ,{ id:900000001, pId:"menuTitleBox<%=menuIndex%>", name:"设备信息",  target:'mainFrame',url:"<%=rootPath%>/equipment!equipmentView.action?processId=<%=tmpStr[0]%>&remindField=&tableId=<%=tmpStr[2]%>&moduleId=14",iconSkin:"fa fa"}
                    <%}%>
                    <%if(managerBD.hasRightTypeName(userId, "设备管理","维护")){%>
                  ,{ id:900000002, pId:"menuTitleBox<%=menuIndex%>", name:"使用记录",  target:'mainFrame',url:"<%=rootPath%>/equipment!equipmentUseView.action",iconSkin:"fa fa"}
					<%if(isForbiddenPad){%>
                  ,{ id:900000003, pId:"menuTitleBox<%=menuIndex%>", name:"设备类别",  target:'mainFrame',url:"<%=rootPath%>/equipment!equipmentTypeView.action",iconSkin:"fa fa"}
					<%
					 //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
					 if(workflowType.equals("1") || workflowType.equals("2")){	 
					%>
                 ,{ id:900000004, pId:"menuTitleBox<%=menuIndex%>", name:"流程定义",  target:'mainFrame',url:"<%=rootPath%>/wfprocess!processList.action?moduleId=14",iconSkin:"fa fa"}
					<%}%>
					<%if(workflowType.equals("0") || workflowType.equals("2")){%>
					,{ id:900000005, pId:"menuTitleBox<%=menuIndex%>", name:"流程定义(ezFLOW)",  target:'mainFrame',url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=14",iconSkin:"fa fa"}
					<%}%>
					<%}%>
                    <%}%>
		    <%} --%>
			
			//合同管理
		   <%if(canShowMenus.indexOf("officemanager_contractmanager")>=0&&cmdb.hasMenuAuth("officemanager_contractmanager",session.getAttribute("userId").toString(),session.getAttribute("orgId").toString())){ %>
        <%menuIndex++;%>
		 ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"合同管理", target:'mainFrame',iconSkin:"fa fa"}
		    <%
			          //列出所有的流程
			          List list0 = new ArrayList();
    				  list0 =bpmbd.getUserProcessListWithNoPackage(userId,orgIdString,null,"92",null);
                      if(list0 != null && list0.size()>0){
			        %>
                  ,{ id:900000006, pId:"menuTitleBox<%=menuIndex%>", name:"合同审批", target:'_blank', click:"openWin({url:'<%=rootPath%>/contract!newWf.action', width:600, height:200, winName: '合同审批'});",iconSkin:"fa fa"}
                    <%}%>
                    <%
                      //列出所有的流程
				      List list1 = new ArrayList();
				      list1 =bpmbd.getUserProcessListWithNoPackage(userId,orgIdString,null,"93",null);
                      if(list1 != null && list1.size()>0){
                    %>
                  ,{ id:900000007, pId:"menuTitleBox<%=menuIndex%>", name:"合同变更审批", target:'_blank', click:"openWin({url:'<%=rootPath%>/contract!changeWf.action', width:600, height:200, winName: '合同变更审批'});",iconSkin:"fa fa"}
                    <%}%>
                    <%
                      // 维护/查看权限
				      if(managerBD.hasRight(session.getAttribute("userId").toString(),"HT*01*01") || managerBD.hasRight(session.getAttribute("userId").toString(),"HT*03*01")){
			        %>
                  ,{ id:900000008, pId:"menuTitleBox<%=menuIndex%>", name:"合同信息", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:9000000081, pId:900000008, name:"应付款合同", url:"<%=rootPath%>/contract!givedConList.action", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:9000000082, pId:900000008, name:"应收款合同", url:"<%=rootPath%>/contract!receivedConList.action", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:9000000083, pId:900000008, name:"其他合同", url:"<%=rootPath%>/contract!otherConList.action", target:'mainFrame',iconSkin:"fa fa"}
                  ,{ id:900000009001, pId:"menuTitleBox<%=menuIndex%>", name:"审批记录", url:"<%=rootPath%>/contract!appConList.action", target:'mainFrame',iconSkin:"fa fa"}
                  ,{ id:900000009002,expNodeCode:"contract", pId:"menuTitleBox<%=menuIndex%>", name:"合同约定情况提醒", url:"<%=rootPath%>/contract!reminderList.action", target:'mainFrame',iconSkin:"fa fa"}
                  ,{ id:900000009003, pId:"menuTitleBox<%=menuIndex%>", name:"统计报表", url:"<%=rootPath%>/contract!searchReportForm.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%
				      }
					if(managerBD.hasRight(session.getAttribute("userId").toString(),"HT*02*01")){
			        %>
			        <%if(isForbiddenPad){%>
                  ,{ id:900000009004, pId:"menuTitleBox<%=menuIndex%>", name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:900000009005, pId:900000009004, name:"合同类别", url:"<%=rootPath%>/contract!conTypeList.action", target:'mainFrame',iconSkin:"fa fa"}
                    	<%
						//0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
						if(workflowType.equals("1") || workflowType.equals("2")){	 
						%>
                    	,{ id:900000009006, pId:900000009004, name:"合同审批流程定义", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=92", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:900000009007, pId:900000009004, name:"合同变更审批流程定义", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=93", target:'mainFrame',iconSkin:"fa fa"}
						<%}%>
						<%if(workflowType.equals("0") || workflowType.equals("2")){%>
                    	,{ id:900000009008, pId:900000009004, name:"合同审批流程定义(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=92", target:'mainFrame',iconSkin:"fa fa"}
                    	,{ id:900000009009, pId:900000009004, name:"合同变更审批流程定义(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=93", target:'mainFrame',iconSkin:"fa fa"}	
                    	<%}%>
                    <%}}%>
		   <%}%>
		   
		 <%if(!isCOSClient){%>
		//ezCARD-----20140925-----start
		
		//ezCARD-----20140925-----end

		<%
		  if(canShowMenus.indexOf("officemanager_namecard")>=0&&cmdb.hasMenuAuth("officemanager_namecard",session.getAttribute("userId").toString(),session.getAttribute("orgId").toString())){
		  	  String n_userId      = session.getAttribute("userId").toString();
		  	  String n_domainId    = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
		  	  String n_orgIdString = session.getAttribute("orgIdString")+"";
		  	  List namecardlist =new ArrayList();
		  	  namecardlist =bpmbd.getUserProcessListWithNoPackage(n_userId,n_orgIdString,null,"35",null);
		%>
		<%menuIndex++;%>  
		 ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"名片订购", target:'mainFrame',iconSkin:"fa fa"}  
		  ,{ id:90000000900901, pId:"menuTitleBox<%=menuIndex%>", name:"申请订购", url:"", target:'mainFrame',iconSkin:"fa fa"}
					<%
					  int nodeId =21001;
					  if(namecardlist !=null){
					      for(int nc = 0; nc < namecardlist.size(); nc++){
					      	  Object[] rfObj = (Object[])namecardlist.get(nc);
					      	  String processId   = rfObj[0] + "";
					      	  String processName = rfObj[1] + "";
					      	  nodeId ++;
					%>
					,{ id:<%=nodeId%>, pId:90000000900901, name:"<%=processName%>", target:'_blank', click:"openWin({url:'<%=rootPath%>/nameCardAction!add.action?p_wf_pool_processId=<%=processId%>', isFull:true , winName: '申请订购'});",iconSkin:"fa fa"}
					<%
					  }}
					%>
                  ,{ id:90000000900902, pId:"menuTitleBox<%=menuIndex%>", name:"我的名片", url:"<%=rootPath%>/cardEmpInfoAction!load.action?editType=3", target:'mainFrame',iconSkin:"fa fa"}
                  ,{ id:90000000900903, pId:"menuTitleBox<%=menuIndex%>", name:"状态查询", url:"<%=rootPath%>/nameCardAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%if(managerBD.hasRight(n_userId, "13*01*01")){%>
                    <%if(isForbiddenPad){%>
					  ,{ id:90000000900904, pId:"menuTitleBox<%=menuIndex%>", name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
                    	  ,{ id:900000009009041, pId:90000000900904, name:"字段设置", target:'_blank', click:"openWin({url:'<%=rootPath%>/cardEmpInfoAction!editField.action', isFull:true, winName: 'editField'});",iconSkin:"fa fa"} 
                    	  ,{ id:900000009009042, pId:90000000900904, name:"信息设置", url:"<%=rootPath%>/cardEmpInfoAction!list.action", target:'mainFrame',iconSkin:"fa fa"}
						<%
						//0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
						if(workflowType.equals("1") || workflowType.equals("2")){	 
						%>
                    	  ,{ id:900000009009045, pId:90000000900904, name:"流程定义", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=35", target:'mainFrame',iconSkin:"fa fa"}
						<%}%>
						<%if(workflowType.equals("0") || workflowType.equals("2")){%>
                    	  ,{ id:900000009009046, pId:90000000900904, name:"流程定义(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=35", target:'mainFrame',iconSkin:"fa fa"}
						<%}%>
						  ,{ id:900000009009047, pId:90000000900904, name:"帐号设置", url:"<%=rootPath%>/nameCardAction!loadsetup.action", target:'mainFrame',iconSkin:"fa fa"}
					<%}}%>
		   	<%}%>
		<%}%>
		   
				<%menuIndex++;%>
				// 排班管理 
				<% if(canShowMenus.indexOf("hospital_scheduling")>=0){ %>   
		    	  ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"排班管理", target:'mainFrame',iconSkin:"fa fa"} 
		   			 ,{ id:900000009009048, pId:"menuTitleBox<%=menuIndex%>", name:"排班表", url:"<%=rootPath%>/scheduling!setClassList.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*01*02")){%>
                  ,{ id:900000009009049, pId:"menuTitleBox<%=menuIndex%>", name:"排班统计", url:"<%=rootPath%>/scheduling!setClassStat.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
                    <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*01*03")||managerBD.hasRight(session.getAttribute("userId").toString(), "YL*01*04")){%>
                    <%if(isForbiddenPad){%>
                  ,{ id:9000000090090410, pId:"menuTitleBox<%=menuIndex%>", name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
		                <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*01*03")){%>    
	                  ,{ id:9000000090090411, pId:9000000090090410, name:"基本设置", url:"<%=rootPath%>/scheduling!loadHospitalBaseSet.action", target:'mainFrame',iconSkin:"fa fa"}
	                    <%}%>
			  			<%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*01*04")){%>
	                  ,{ id:9000000090090412, pId:9000000090090410, name:"班头设置", url:"<%=rootPath%>/scheduling!hospitalClassHeadSetList.action", target:'mainFrame',iconSkin:"fa fa"}
	                    <%}%>
	                <%}}%>
		    <%}%>
		   
		     <%menuIndex++;%>
       //  考勤上报管理 
        <% if(canShowMenus.indexOf("hospital_checkwork")>=0){ %>
		  ,{ id:"menuTitleBox<%=menuIndex%>", pId:0, name:"考勤上报管理", target:'mainFrame',iconSkin:"fa fa"} 
		   <%
				    com.whir.hospital.checkwork.bd.CheckworkBD bd = new com.whir.hospital.checkwork.bd.CheckworkBD();
				    List checkerList = bd.isChecker(Long.valueOf(session.getAttribute("userId").toString()));
				    //有考勤管理-维护权限或是考勤员
				    %>
	                <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*02*03") || checkerList !=null){%>
                  ,{ id:9000000090090413, pId:"menuTitleBox<%=menuIndex%>", name:"考勤录入", url:"<%=rootPath%>/checkwork!checkWorkWriteList.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
			  		<%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*02*01")){%>
                  ,{ id:9000000090090414, pId:"menuTitleBox<%=menuIndex%>", name:"考勤统计", url:"<%=rootPath%>/checkwork!checkWorkStat.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
			  		<%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*02*04")){%>
                  ,{ id:9000000090090415, pId:"menuTitleBox<%=menuIndex%>", name:"人员调动统计", url:"<%=rootPath%>/checkwork!gotoEmpChangList.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
			  		<%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*02*05")){%>
                  ,{ id:9000000090090416, pId:"menuTitleBox<%=menuIndex%>", name:"考勤记录", url:"<%=rootPath%>/checkwork!checkWorkMonthCheckList.action", target:'mainFrame',iconSkin:"fa fa"}
                    <%}%>
			  		<%if(managerBD.hasRight(session.getAttribute("userId").toString(), "YL*02*02")){%>
			  		<%if(isForbiddenPad){%>
                  ,{ id:9000000090090417, pId:"menuTitleBox<%=menuIndex%>", name:"设置", url:"", target:'mainFrame',iconSkin:"fa fa"}
	                  ,{ id:9000000090090418, pId:9000000090090417, name:"考勤范围", url:"<%=rootPath%>/checkwork!checkWorkBaseSetList.action", target:'mainFrame',iconSkin:"fa fa"}
	                  ,{ id:9000000090090419, pId:9000000090090417, name:"请假类别", url:"<%=rootPath%>/checkwork!leaveClassSetList.action", target:'mainFrame',iconSkin:"fa fa"}
                	<%}}%>
		    <%}%>
		   
		      <%menuIndex++;%>
        <%
          String menutype = "officemanager";
        %>
        <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
		   ];
		
     
		
		   //$(document).ready(function(){
           // $.fn.zTree.init($("#treeDemo"), setting, zNodes);
       // });
        function whir_initMenu(){
				 $.fn.zTree.init($("#treeDemo"), setting, zNodes);
				
		var loc="statusType0";
		var ind=0;
		var obj;
		var id="";
	    OpenCloseSubMenu(0);
		
		<%if(request.getParameter("statusType")!=null&&!request.getParameter("statusType").toString().equals("")){%>
			loc="statusType<%=request.getParameter("statusType")%>";
			obj = $('#'+loc);
			if(obj.length>0){
				id=obj.find('td:first').attr('id');
				ind=id.substring(12);
			}
			OpenCloseSubMenu(ind);
		<%}else{%>
			OpenCloseSubMenu(0);
		<%}%>
	
	
	
	
	 if('<%=expNodeCode%>'=="contract"){
		OpenSubMenu('contract');
	}
	else if('<%=expNodeCode%>'=="meetingInfo"){
		OpenSubMenu('meetingInfo');
	}
	

				 }

</script>
<div class="wh-l-msg">
	<a class="clearfix"> <i class="fa fa-desktop fa-color"></i> <span>
			综合办公 </span> </a>
</div>
<div class="wh-l-con">
	<ul id="treeDemo" class="ztree"></ul>
</div>
<SCRIPT LANGUAGE="JavaScript">
	
</SCRIPT>