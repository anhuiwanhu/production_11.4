<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String sysManager  = session!=null?session.getAttribute("sysManager")+"":"";
String userAccount = session!=null?session.getAttribute("userAccount")+"":"";
boolean sysRole=false, userRole=false, defineRole=false;
if(sysManager.indexOf("1")>=0){sysRole=true;userRole=true;defineRole=true;}
if(sysManager.indexOf("2")>=0){userRole=true;}
if(sysManager.indexOf("3")>=0){defineRole=true;}
//0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
String workflowType = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("workflowType", session.getAttribute("domainId")+"");
ManagerBD managerBD = new ManagerBD();
%>
<script>
<%
int menuIndex=0;
int whir_treeId = 10000;
int whir_treeParentId = 0;
int whir_treeParentId_two = 0;
int whir_treeParentId_three = 0;
int whir_treeParentId_four = 0;
%>
	  var zNodes =[	  
	        <% if((sysRole)&&!"security".equals(userAccount)){%>
		    { id:<%=whir_treeParentId%>, pId:-1, name:"基础设置", open:true, iconSkin:"fa fa-cog fa"},	  	
                    <%
                        if(sysRole){
                            if("admin".equals(userAccount)||sysRole){
                                if(com.whir.org.common.util.SysSetupReader.getInstance().isMultiDomain()!=null){
                    %>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"系统设置", url:"<%=rootPath%>/SysSetup!init.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%}}%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"界面设置", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"基本设置", url:"<%=rootPath%>/UnitSet!view.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"登录页设置", url:"<%=rootPath%>/LoginPageSet!initlist.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"弹窗设置", url:"<%=rootPath%>/Popwin!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%
                            if("admin".equals(userAccount)||sysRole){
                    %>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"基础数据设置", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"工作时间设置", url:"<%=rootPath%>/kqworktime!kqworktime_list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"工作日设置", url:"<%=rootPath%>/WorkDay!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"工作周设置", url:"<%=rootPath%>/WorkWeek!init.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"职务设置", url:"<%=rootPath%>/dutysetting!duty_list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"办公地点分类设置", url:"<%=rootPath%>/workaddresstype!workaddresstype_list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"办公地点设置", url:"<%=rootPath%>/workaddress!workAddress_list.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%}%>                    
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"接口设置", url:"<%=rootPath%>/SysInterface!initList.action", target:'mainFrame', iconSkin:"fa fa"},
			        <%
                        if("admin".equals(userAccount)){
				            //判断是否使用即时通讯工具
                            com.whir.integration.realtimemessage.Realtimemessage util= new com.whir.integration.realtimemessage.Realtimemessage();
				            if(util.getUsed()){
                    %>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"用户同步", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"全部同步", target:'_blank', open:true, click:"openWin({url:'<%=rootPath%>/realtimemessage!syncAllData.action',isFull:false,width:520,height:180,winName: 'synch'});", iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"增量同步", target:'_blank', open:true, click:"openWin({url:'<%=rootPath%>/realtimemessage!syncPartData.action',isFull:true,winName: 'synch'});", iconSkin:"fa fa"},
                    <%}%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"组织用户导入", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"导入组织", url:"<%=rootPath%>/ImportOrgUser!importOrg.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"导入用户", url:"<%=rootPath%>/ImportOrgUser!importUser.action", target:'mainFrame', iconSkin:"fa fa"},
					{ id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"密码设置", url:"<%=rootPath%>//MyInfoAction!modiSuperPassword.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"垃圾附件清理", url:"<%=rootPath%>/FileClean!fileClean.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%}}%>
		   	<%menuIndex++;%>
			<%}%>	  
            <%whir_treeParentId++;%>
            <%if((sysRole || userRole)&&!"security".equals(userAccount)){%>
	        { id:<%=whir_treeParentId%>, pId:-1, name:"组织用户管理", iconSkin:"fa fa-personnel-pos fa"},	
                    <%if(sysRole||userRole){%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"组织管理", url:"<%=rootPath%>/Organization!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"群组管理", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"群组分类", url:"<%=rootPath%>/GroupClass!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"群组设置", url:"<%=rootPath%>/Group!initList.action?groupType=0", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"角色管理", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"角色分类", url:"<%=rootPath%>/RoleClass!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"角色设置", url:"<%=rootPath%>/Role!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"权限管理", url:"<%=rootPath%>/Right!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"用户管理", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"当前用户", url:"<%=rootPath%>/User!initList.action?status=active", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"禁用用户", url:"<%=rootPath%>/User!initList.action?status=disabled", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"休眠用户", url:"<%=rootPath%>/User!initList.action?status=sleep", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"申请用户", url:"<%=rootPath%>/User!initList.action?status=apply", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"移动设备用户", url:"<%=rootPath%>/MobileUser!initMobileList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"浏览范围", url:"<%=rootPath%>/BrowseScope!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"工作代理", url:"<%=rootPath%>/bpmproxy!fileList.action?from=system", target:'mainFrame', iconSkin:"fa fa"},
                    <%}%>
			<%menuIndex++;%>
			<%}%>
            <%whir_treeParentId++;%>
	   		<%if((sysRole || defineRole)&&!"security".equals(userAccount)){%>
	   		{ id:<%=whir_treeParentId%>, pId:-1, name:"自定义平台", iconSkin:"fa fa-laptop fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义门户", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    <%if(sysRole||defineRole){%>                    
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"门户中心", iconSkin:"fa fa"},
                    <%whir_treeParentId_three = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"菜单方案", url:"<%=rootPath%>/PortalMenuSet!list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"顶部设置", url:"<%=rootPath%>/Header!list.action?type=0", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"底部设置", url:"<%=rootPath%>/Header!list.action?type=1", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"模板设置", url:"<%=rootPath%>/PortalTemplate!list.action", target:'mainFrame', iconSkin:"fa fa"},
					{ id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"主题设置", url:"<%=rootPath%>/PortalTheme!list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"门户设置", iconSkin:"fa fa"},
                    <%whir_treeParentId_four = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_four%>, name:"登录前门户", url:"<%=rootPath%>/PortalLayout!list.action?useMode=0", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_four%>, name:"登录后门户", url:"<%=rootPath%>/PortalLayout!list.action?useMode=1", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"登录后首页", iconSkin:"fa fa"},
                    <%whir_treeParentId_three = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"首页", url:"<%=rootPath%>/PortalLayout!homePage.action?type=homepage", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"模块首页", url:"<%=rootPath%>/PortalLayout!homePage.action?type=other", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_three%>, name:"分类设置", url:"<%=rootPath%>/PortalType!list.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%}%>

                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义数据表", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"分类管理", url:"<%=rootPath%>/Model!initModelList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"用户数据表", url:"<%=rootPath%>/Table!initTableList.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%if("2".equals(workflowType) || "1".equals(workflowType)){%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义表单", url:"<%=rootPath%>/CustomForm!initFormList.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%}%>
                    <%if("2".equals(workflowType) || "0".equals(workflowType)){%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"新自定义表单", url:"<%=rootPath%>/EzForm!initFormList.action?wfModuleId=1", target:'mainFrame', iconSkin:"fa fa"},
                    <%}%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义模块", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"在用模块", url:"<%=rootPath%>/custormermenu!custMenuList.action?validate=1", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"隐藏模块", url:"<%=rootPath%>/custormermenu!custMenuList.action?validate=0", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义信息频道", url:"<%=rootPath%>/UserChannel!list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义流程频道", url:"<%=rootPath%>/wfchannel!channelList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义关系", url:"<%=rootPath%>/custcenter!menuList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"自定义图表", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"图表分类", url:"<%=rootPath%>/GraphType!list.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"图表设计", url:"<%=rootPath%>/Graph!list.action", target:'mainFrame', iconSkin:"fa fa"},

                    <%if(sysRole || defineRole){//sysManager.indexOf("1")>=0){//系统管理员才可操作此菜单---单点登录系统帐号设置
                    %>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"<%=Resource.getValue(whir_locale, "personalwork", "Unifiedlogin.SystemManagement")%>", url:"<%=rootPath%>/LdapSet!initLdapSetList.action", target:'mainFrame', iconSkin:"fa fa"},
                    <%}%>
                    //{ id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"移动OA管理", url:"<%=rootPath%>/mobilecustmenu!mobCustMenu.action", target:'mainFrame', iconSkin:"fa fa"},
			  <%menuIndex++;%>
        <%}%>		
              <%whir_treeParentId++;%>
            <%if("security".equals(userAccount)){%>
			{ id:<%=whir_treeParentId%>, pId:-1, name:"安全管理", iconSkin:"fa fa"},
              
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"日志", iconSkin:"fa fa"},
                    <%whir_treeParentId_two = whir_treeId-1;%>
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"当前日志", url:"<%=rootPath%>/Log!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"历史日志", url:"<%=rootPath%>/LogHistory!initList.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"日志设置", url:"<%=rootPath%>/LogSet!initSet.action", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId_two%>, name:"日志级别设置", url:"<%=rootPath%>/platform/logset/logset.jsp", target:'mainFrame', iconSkin:"fa fa"},
                    { id:<%=whir_treeId++%>, pId:<%=whir_treeParentId%>, name:"访问IP设置", url:"<%=rootPath%>/Ip!initList.action", target:'mainFrame', iconSkin:"fa fa"}
			 <%menuIndex++;%>
        <%}%>
         //--移动OA管理 2015-12-24 xiehd--
		 <%whir_treeParentId++;%>
            <%if((sysRole)&&!"security".equals(userAccount)){%>
			
			{ id:<%=whir_treeParentId%>, pId:-1, name:"移动OA管理", url:"<%=rootPath%>/MoveOAmanager!wxmanager.action",target:'mainFrame',iconSkin:"fa fa"} 
			 <%menuIndex++;%>
            <%}%>
     ];

        $(document).ready(function(){
            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
        });
	</script>
	
   <div class="wh-l-msg">
       <a href="javascript:void(0);" class="clearfix">
            <i class="fa fa-cog fa-color"></i>
            <span>
                系统管理
                <!--i class="fa fa-meeting-mana fa-color"></i-->
            </span>
        </a>
    </div>
    <div class="wh-l-con">
        <ul id="treeDemo" class="ztree"></ul>
    </div>
             
<SCRIPT LANGUAGE="JavaScript">
<!--
$(function() {
	OpenCloseSubMenu(0);
});
//-->
</SCRIPT>