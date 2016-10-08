<%@ include file="/public/include/xhtml1.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt" %>
<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader ("Expires", 0);
	
	int menuIndex=0;
	//此处公共业务逻辑
	String userId = session.getAttribute("userId").toString();
	String userAccount = session.getAttribute("userAccount").toString();
	String domainId = session.getAttribute("domainId")==null?"0":session.getAttribute("domainId").toString();
	String orgId = session.getAttribute("orgId").toString();
	String orgIdString = session.getAttribute("orgIdString").toString();
	
	String portletSettingId = request.getParameter("portletSettingId");
	
	ManagerBD managerBD = new ManagerBD();
	
	String databaseType = com.whir.common.config.SystemCommon.getDatabaseType();
%>

  <script type="text/javascript">
	var zNodes = [
		<%
        	List zhidaoList =new ArrayList();
        	com.whir.ezoffice.zhidao.bd.ClassBD cbd =new com.whir.ezoffice.zhidao.bd.ClassBD();
			com.whir.ezoffice.zhidao.bd.QuestionBD qbd =new com.whir.ezoffice.zhidao.bd.QuestionBD();
        	zhidaoList =cbd.getClassList();
        	String classId ="";
			String className ="";
			String classParentId = "";
			String classLevel = "";
      	%>
	    <%menuIndex++;%>
	    {id:'a-<%=menuIndex%>' ,pId:-1, name:'所有问题',url:'<%=rootPath%>/question!list.action?action=all',target:'mainFrame', iconSkin:"fa fa-question-circle fa"}
			
		<%
       	if(zhidaoList !=null && zhidaoList.size() >0){
            for(int i=0;i<zhidaoList.size();i++){
            		Object[] classObj = (Object[]) zhidaoList.get(i);
                classId =classObj[0]==null?"":classObj[0].toString();
								int num =0;
								num =qbd.getQuestionNumForClassId(classId,domainId);
                className =classObj[1]==null?"":classObj[1].toString()+"("+num+")";
                classParentId =classObj[2]==null?"":classObj[2].toString();
                classLevel =classObj[3]==null?"":classObj[3].toString();
       	%>
       	<%if("1".equals(classLevel)){%>
	     ,{ id:<%=classId%>, pId:'a-<%=menuIndex%>', name:"<%=className%>", url:"<%=rootPath%>/question!list.action?classId=<%=classId%>", target:'mainFrame', iconSkin:"fa fa"}
	     <%}else{%>
	     ,{ id:<%=classId%>, pId:<%=classParentId%>, name:"<%=className%>", url:"<%=rootPath%>/question!list.action?classId=<%=classId%>", target:'mainFrame', iconSkin:"fa fa"}
	    <%}%>
	    <%}}%> 
	                 
	    <%menuIndex++;%>
	   	 ,{id:'menuTitleBox<%=menuIndex%>' ,pId:-1, name:'精华问题',url:'<%=rootPath%>/question!list.action?action=essence',target:'mainFrame', iconSkin:"fa fa-essence-pro fa"}
			
		<%menuIndex++;%>
	   	 ,{id:'menuTitleBox<%=menuIndex%>' ,pId:-1, name:'个人问题管理',target:'mainFrame', iconSkin:"fa fa-personal-pro fa"}
			 ,{ id:1000000000, pId:'menuTitleBox<%=menuIndex%>', name:"我的提问", url:"<%=rootPath%>/question!myQuestionList.action", target:'mainFrame', iconSkin:"fa fa"}
		  	 ,{ id:1000000001, pId:'menuTitleBox<%=menuIndex%>', name:"我的回答", url:"<%=rootPath%>/question!myAnswerList.action", target:'mainFrame', iconSkin:"fa fa"}
		  	 ,{ id:1000000002, pId:'menuTitleBox<%=menuIndex%>', name:"他人求助", url:"<%=rootPath%>/question!otherHelpList.action", target:'mainFrame', iconSkin:"fa fa"}
		<%if(managerBD.hasRight(session.getAttribute("userId").toString(), "ZHIDAO*01*02")){%>
			<%if(isForbiddenPad){%>
	        <%menuIndex++;%>
	        ,{id:'menuTitleBox<%=menuIndex%>' ,pId:-1, name:'分类设置',url:'<%=rootPath%>/classSet!list.action',target:'mainFrame', iconSkin:"fa fa-cog fa"}
	        <%}}%>
	    <%if(managerBD.hasRight(session.getAttribute("userId").toString(), "EXPERT*01*01")){%>
	        <%if(isForbiddenPad){%>
	        <%menuIndex++;%>
	        
	    ,{id:'menuTitleBox<%=menuIndex%>' ,pId:-1, name:'专家设置',url:'Expert!ExpertList.action',target:'mainFrame', iconSkin:"fa fa-expert-set fa"}
			<%}}%>
	  	<%menuIndex++;%>
			
		,{id:'menuTitleBox<%=menuIndex%>' ,pId:-1, name:'知道专家库',url:'Expert!homePage.action',target:'mainFrame', iconSkin:"fa fa-expert-gro fa"}
			
		<%menuIndex++;%>
	    <%
	          String menutype = "know";
	    %>
	    <%@ include file="/platform/custom/customize/custLeftMenuUnderOriginal.jsp"%>
		];
			
			/*$(document).ready(function(){ 
				$.fn.zTree.init($("#treeDemo"), setting, zNodes);
			});*/

		 function whir_initMenu(){
			 $.fn.zTree.init($("#treeDemo"), setting, zNodes);
			 if('<%=portletSettingId%>' == "myQuestion" ){
				 OpenCloseSubMenu(1000000000);	
			 }else if('<%=portletSettingId%>' == "myAnswer"){
				 OpenCloseSubMenu(1000000001);	
			 }else if('<%=portletSettingId%>' == "help"){
				 OpenCloseSubMenu(1000000002);	
			 }
		 }
	</script>

	<div class="wh-l-msg">
    	<a class="clearfix">
        <i class="fa fa-cog fa-color fa-lightbulb-o"></i>
       	<span>知道</span>
        </a>
    </div>
    <div class="wh-l-con">
     	<ul id="treeDemo" class="ztree"></ul>
    </div>