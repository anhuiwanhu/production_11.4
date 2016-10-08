<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.dossier.bd.DossierBD"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt"%>

<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	int menuIndex = 0;
	//此处公共业务逻辑
	String userId = session.getAttribute("userId").toString();
	String userAccount = session.getAttribute("userAccount").toString();
	String domainId = session.getAttribute("domainId") == null
			? "0"
			: session.getAttribute("domainId").toString();
	String orgId = session.getAttribute("orgId").toString();
	String orgIdString = session.getAttribute("orgIdString").toString();

	ManagerBD mbd = new ManagerBD();
	DossierBD dossierBD = new DossierBD();
	com.whir.ezoffice.workflow.newBD.ProcessBD procbd = new com.whir.ezoffice.workflow.newBD.ProcessBD();
	boolean hasRight = mbd.hasRight(String.valueOf(userId), "07*99*01");
	boolean isDossierAdmin = dossierBD.isDossierAdmin(new Long(userId),
			new Long(domainId)) == Boolean.TRUE ? true : false;

	String databaseType = com.whir.common.config.SystemCommon
			.getDatabaseType();

	com.whir.ezoffice.bpm.bd.BPMProcessBD bpmbd = new com.whir.ezoffice.bpm.bd.BPMProcessBD();
	String workflowType = com.whir.common.util.CommonUtils
			.getWorkflowType(domainId);
			
	com.whir.org.manager.bd.ManagerBD  managerBD = new com.whir.org.manager.bd.ManagerBD ();
	boolean isright=managerBD.hasRight(userId, "07*99*03");
	boolean isSelRight=managerBD.hasRight(userId, "07*99*02");		
%>
<script>
	  var zNodes =[
        <%if (isright) {%>
        <%menuIndex++;%>
         { id:"statusType<%=menuIndex%>", pId:-1, name:"文件著录", target:'mainFrame',iconSkin:"fa fa"},
       	 { id:1000000000, pId:"statusType<%=menuIndex%>", name:"本系统信息", url:"", target:'mainFrame',iconSkin:"fa fa"},
                        { id:1100000001, pId:1000000000, name:"信息管理", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=ZSGL", target:'mainFrame',iconSkin:"fa fa"},
                    	{ id:1100000002, pId:1000000000, name:"工作流程", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=GZLC", target:'mainFrame',iconSkin:"fa fa"},
                    	{ id:1100000003, pId:1000000000, name:"文档管理", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=WDGL", target:'mainFrame',iconSkin:"fa fa"},
                        { id:1100000004, pId:1000000000, name:"公文管理", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=GWGL", target:'mainFrame',iconSkin:"fa fa"},
                            { id:1110000001, pId:1100000004, name:"发文管理", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=FWGL", target:'mainFrame',iconSkin:"fa fa"},
                    	    { id:1110000002, pId:1100000004, name:"收文管理", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=SWGL", target:'mainFrame',iconSkin:"fa fa"},
                            { id:1110000003, pId:1100000004, name:"文件送审签", url:"<%=rootPath%>/dossierAction!innerList.action?fileType=SSQGL", target:'mainFrame',iconSkin:"fa fa"},
                    	{ id:1000000001, pId:"statusType<%=menuIndex%>", name:"外部信息", url:"<%=rootPath%>/dossierAction!list.action", target:'mainFrame',iconSkin:"fa fa"},
        
        
        
        <%menuIndex++;%>
        { id:"a-<%=menuIndex%>", pId:-1, name:"类目管理", target:'mainFrame',iconSkin:"fa fa"},
        
        <%
        java.util.List lists1 = dossierBD.getDossierCategoryList(
						new Long(userId), null, new Long(domainId), null, null,
						null);
				String orgId1 = "";
				String orgName1 = "";
				String tmpOrgName1 = "";
				String idStr1 = "";
				int orgLevel1 = 0;
				int orgParentId1 = 0;
				java.util.ArrayList alist1 = new java.util.ArrayList();
				com.whir.ezoffice.dossier.po.DossierCategoryPO objj1 = null;%>
                    <%for (int jj = 0; jj < lists1.size(); jj++) {
					objj1 = (com.whir.ezoffice.dossier.po.DossierCategoryPO) lists1
							.get(jj);
					orgId1 = String.valueOf(objj1.getId());
					orgName1 = objj1.getName();
					orgLevel1 = Integer.parseInt(objj1.getLevel());
					orgParentId1 = objj1.getParentId().intValue();
					idStr1 = objj1.getIdStr();
					tmpOrgName1 = orgName1;
                    if(0==orgParentId1){%>
                    
                    	{ id:"aa-<%=orgId1%>", pId:"a-<%=menuIndex%>", name:"<%=tmpOrgName1%>", url:"<%=rootPath%>/dossierCategoryManageAction!list.action?categoryId=<%=orgId%>&idStr=<%=idStr1%>&level=<%=orgLevel1%>", target:'mainFrame',iconSkin:"fa fa"},
                    
                    <%}else{%>
                    	{ id:"aa-<%=orgId1%>", pId:"aa-<%=orgParentId1%>", name:"<%=tmpOrgName1%>", url:"<%=rootPath%>/dossierCategoryManageAction!list.action?categoryId=<%=orgId%>&idStr=<%=idStr1%>&level=<%=orgLevel1%>", target:'mainFrame',iconSkin:"fa fa"},
                    
                   <% }%>
                    
                    <%}%>
               
         <%}%>
        
        <%if ((orgIdString != null && !"null".equals(orgIdString) && !""
					.equals(orgIdString))
					|| ("admin".equals(userAccount))
					|| ("security".equals(userAccount))) {%>
        <%menuIndex++;%>
          { id:"b-<%=menuIndex%>", pId:-1, name:"档案查询", target:'mainFrame',iconSkin:"fa fa"},
        
        <%String whereSQL = "((1=1 ";
				String tempSQL = " or po.adminId like '%$" + userId
						+ "$%' or po.createdOrg = " + orgId;
				if (databaseType.indexOf("db2") >= 0) {
					tempSQL += " or locate("
							+ orgIdString
							+ ", EZOFFICE.FN_LINKCHAR(EZOFFICE.FN_LINKCHAR('%$', po.orgId), '$%'))>0 ";
				} else if (databaseType.indexOf("mysql") >= 0) {
					tempSQL += " or '" + orgIdString
							+ "' like concat('%$', po.orgId,'$%')";
				} else {
					tempSQL += " or '"
							+ orgIdString
							+ "' like EZOFFICE.FN_LINKCHAR(EZOFFICE.FN_LINKCHAR('%$', po.orgId), '$%')";
				}
				whereSQL += " ) and po.domainId=" + domainId;
				String[] res11 = null;
				String tempSQL2 = "po.lookUserId like '%$" + userId + "$%' ";
				DbOpt dbopt = null;
				try {
					dbopt = new DbOpt();
					String sql = "select group_id from org_user_group where emp_id="
							+ userId;
					res11 = dbopt.executeQueryToStrArr1(sql);
					dbopt.close();
				} catch (Exception e) {
					System.out.println("error on dossier_menu.jsp");
				} finally {
					try {
						dbopt.close();
					} catch (Exception ex) {
					}
				}
				if (res11 != null) {
					for (int i = 0; i < res11.length; i++) {
						tempSQL2 += " or po.lookUserId like '%@" + res11[i]
								+ "@%' ";
					}
				}
				if (!"".equals(orgIdString)) {
					String[] orgIdStrings = (orgIdString.substring(1,
							orgIdString.length()) + "$").split("\\$\\$");
					for (int i = 0; i < orgIdStrings.length; i++) {
						tempSQL2 += " or po.lookUserId like '%*"
								+ orgIdStrings[i] + "*%' ";
					}
				}
				String sLevelOneHasSubCategorySQL = "AND po.id in (select po.parentId from com.whir.ezoffice.dossier.po.DossierCategoryPO po where po.level<>1 and po.parentId in (select po.id from com.whir.ezoffice.dossier.po.DossierCategoryPO po where po.level=1) and ("
						+ tempSQL2 + ")) ";
				whereSQL = "(" + whereSQL + " and po.level=1 "
						+ sLevelOneHasSubCategorySQL
						+ " ) or (po.level <> 1 and (";
				whereSQL += tempSQL2 + ")))";
                if(isSelRight){
					whereSQL = "showAll";
				}
				java.util.List lists2 = dossierBD.getDossierCategoryList(
						new Long(userId), new Long(orgId), new Long(domainId),
						null, null, whereSQL);
				String orgId2 = "";
				String orgName2 = "";
				String tmpOrgName2 = "";
				int orgLevel2 = 0;
				int orgParentId2 = 0;
				int orgHasChannel2 = 0;
				String idStr2 = "";
				java.util.ArrayList alist2 = new java.util.ArrayList();
				com.whir.ezoffice.dossier.po.DossierCategoryPO objj2 = null;%>
       
                    <%for (int jj = 0; jj < lists2.size(); jj++) {
					objj2 = (com.whir.ezoffice.dossier.po.DossierCategoryPO) lists2
							.get(jj);
					orgId2 = String.valueOf(objj2.getId());
					orgName2 = objj2.getName();
					orgLevel2 = Integer.parseInt(objj2.getLevel());
					orgParentId2 = objj2.getParentId().intValue();
					idStr2 = objj2.getIdStr();
					tmpOrgName2 = orgName2;
                    if(0==orgParentId2){
                   %>
                    
                    	{ id:"bb-<%=orgId2%>", pId:"b-<%=menuIndex%>", name:"<%=tmpOrgName2%>", url:"<%=rootPath%>/dossierCategoryQueryAction!list.action?categoryId=<%=orgId2%>&idStr=<%=idStr2%>&level=<%=orgLevel2%>&flag=2&orderbysendDate=0", target:'mainFrame',iconSkin:"fa fa"},
                    
                   <% }else{%>
                    	{ id:"bb-<%=orgId2%>", pId:"bb-<%=orgParentId2%>", name:"<%=tmpOrgName2%>", url:"<%=rootPath%>/dossierCategoryQueryAction!list.action?categoryId=<%=orgId2%>&idStr=<%=idStr2%>&level=<%=orgLevel2%>&flag=2&orderbysendDate=0", target:'mainFrame',iconSkin:"fa fa"},
                    <%}%>
                    <%}%>
               
                
        <%}%>
        
        <%if (mbd.hasRight(String.valueOf(userId), "07*99*06")) {%>
        <%menuIndex++;%>
        { id:"c-<%=menuIndex%>", pId:-1, name:"档案销毁", target:'mainFrame',iconSkin:"fa fa"},
       
        
        <%java.util.List lists3 = dossierBD.getDossierCategoryList(
						new Long(userId), null, new Long(domainId), null, null,
						null);
				String orgId3 = "";
				String orgName3 = "";
				String tmpOrgName3 = "";
				String idStr3 = "";
				int orgLevel3 = 0;
				int orgParentId3 = 0;
				java.util.ArrayList alist3 = new java.util.ArrayList();
				com.whir.ezoffice.dossier.po.DossierCategoryPO objj3 = null;%>
        
                    <%for (int jj = 0; jj < lists3.size(); jj++) {
					objj3 = (com.whir.ezoffice.dossier.po.DossierCategoryPO) lists3
							.get(jj);
					orgId3 = String.valueOf(objj3.getId());
					orgName3 = objj3.getName();
					orgLevel3 = Integer.parseInt(objj3.getLevel());
					orgParentId3 = objj3.getParentId().intValue();
					idStr3 = objj3.getIdStr();
					tmpOrgName3 = orgName3;
                    if(0==orgParentId3){
                    %>
                    	{ id:"cc-<%=orgId3%>", pId:"c-<%=menuIndex%>", name:"<%=tmpOrgName3%>", url:"<%=rootPath%>/dossierCategoryManageAction!logdellist.action?categoryId=<%=orgId3%>&idStr=<%=idStr3%>&level=<%=orgLevel3%>", target:'mainFrame',iconSkin:"fa fa"},
                    <%}else{%>
                    	{ id:"cc-<%=orgId3%>", pId:"cc-<%=orgParentId3%>", name:"<%=tmpOrgName3%>", url:"<%=rootPath%>/dossierCategoryManageAction!logdellist.action?categoryId=<%=orgId3%>&idStr=<%=idStr3%>&level=<%=orgLevel3%>", target:'mainFrame',iconSkin:"fa fa"},
                    <%}%>
                 <%}%>
                
        <%}%>
        
		<%if (mbd.hasRight(String.valueOf(userId), "07*99*05")) {%>
        <%menuIndex++;%>
        { id:"menuTitleBox<%=menuIndex%>", pId:-1, name:"档案借阅", click:"menuJump('<%=rootPath%>/dossierAction!borrowList.action');" ,target:'mainFrame',iconSkin:"fa fa"},
       
		<%}%>
        
        <%if (isDossierAdmin) {%>
        <%menuIndex++;%>
         { id:"menuTitleBox<%=menuIndex%>", pId:-1, name:"档案统计", click:"menuJump('<%=rootPath%>/dossierStatisticAction!list.action');" ,target:'mainFrame',iconSkin:"fa fa"},
       
       
        <%}%>
        
        <%if (hasRight || isDossierAdmin) {%>
        <%if (isForbiddenPad) {%>
        <%menuIndex++;%>
        { id:"menuTitleBox<%=menuIndex%>", pId:-1, name:"档案设置", target:'mainFrame',iconSkin:"fa fa"},
        
        
           
                    <%if (hasRight) {%>
	                    { id:10000000000, pId:"menuTitleBox<%=menuIndex%>", name:"参数设置", url:"<%=rootPath%>/dossierPara!paraset.action", target:'mainFrame',iconSkin:"fa fa"},
	                    { id:10000000001, pId:"menuTitleBox<%=menuIndex%>", name:"一级类目设置", url:"<%=rootPath%>/dossierCategory!list.action", target:'mainFrame',iconSkin:"fa fa"},
                    <%}%>
                    <%if (isDossierAdmin) {%>
	                    { id:10000000002, pId:"menuTitleBox<%=menuIndex%>", name:"子类目设置", url:"<%=rootPath%>/dossierCategory!subList.action", target:'mainFrame',iconSkin:"fa fa"},
	                 <%}%>
                    <%if (hasRight) {%>
						<%//0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
						if (workflowType.equals("1")
								|| workflowType.equals("2")) {%>
	                    { id:10000000003, pId:"menuTitleBox<%=menuIndex%>", name:"借阅流程", url:"<%=rootPath%>/wfprocess!processList.action?moduleId=37", target:'mainFrame',iconSkin:"fa fa"},
						<%}%>
						<%if (workflowType.equals("0")
								|| workflowType.equals("2")) {%>
	                    { id:10000000004, pId:"menuTitleBox<%=menuIndex%>", name:"借阅流程(ezFLOW)", url:"<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=37", target:'mainFrame',iconSkin:"fa fa"},
						<%}%>
	                    { id:10000000005, pId:"menuTitleBox<%=menuIndex%>", name:"归档设置", url:"<%=rootPath%>/dossierPara!pigeonholeSet.action", target:'mainFrame',iconSkin:"fa fa"},
                  <%}%>
           
             <%}}%>
     
		];
		
		   $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
     
</script>

<div class="wh-l-msg">
	<a  class="clearfix"> <i class="fa fa-file-mana fa-color"></i>
		<span> 档案 </span>
	</a>
</div>
<div class="wh-l-con">
	<ul id="treeDemo" class="ztree"></ul>
</div>

