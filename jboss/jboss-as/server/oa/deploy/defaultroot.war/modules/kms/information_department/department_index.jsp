<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" style="overflow: auto; ">
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.ezoffice.information.channelmanager.bd.*"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD"%>
<%@ page import="com.whir.org.manager.bd.ManagerBD"%>
<%
    ManagerBD managerBD = new ManagerBD();
	String orgId   = EncryptUtil.htmlcode(request,"orgId"); 
	String orgName = EncryptUtil.htmlcode(request,"orgName"); 
	orgName =java.net.URLDecoder.decode(orgName, "UTF-8");
	String userOrgId   = session.getAttribute("orgId").toString();
	String userId      = session.getAttribute("userId").toString();
	String orgIdString = session.getAttribute("orgIdString").toString();
	//是否有该单位主页的维护权限
	ChannelBD channelBD = new ChannelBD();
	boolean channelRight = false;
	channelRight = channelBD.departPageRight(userId,userOrgId,orgIdString,orgId);
	//该单位主页中的可查看栏目
	DepartmentPageBD pbd = new DepartmentPageBD();
	List list = (List) pbd.getAllChannel(userOrgId,userId,orgId);

	OrganizationBD organizationBD = new OrganizationBD();
	String skins = (String)organizationBD.getOrgStyle(orgId);
    if(skins == null || "".equals(skins)){
        skins = "default/blue";
    }
	String style = request.getParameter("style")!=null?request.getParameter("style"):skins;
	String bgImg = request.getParameter("bgImg")!=null?request.getParameter("bgImg"):"";
	String isView = request.getParameter("isView")!=null?request.getParameter("isView"):"";
    Long orgLayoutId = organizationBD.getOrgLayout(orgId);
	String layoutId = orgLayoutId!=null?orgLayoutId.toString():"";
	
	DefineSkinBD dsBD =new DefineSkinBD();
	if(bgImg ==null || "null".equals(bgImg) || "".equals(bgImg)){
		String pic_style =dsBD.getEnableSkinPic(orgId);
		if(pic_style !=""){
			bgImg =pic_style.split(";")[0];
			style =pic_style.split(";")[1];
		}
	}
	String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
    //0-仅使用ezFLOW引擎 1-仅使用老引擎 2-新老引擎都支持
    String workflowType = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("workflowType", session.getAttribute("domainId")+"");
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=orgName%></title>
<%@ include file="/public/include/department_base.jsp"%>
<link href="<%=rootPath%>/themes/department/<%=style%>/css/css_whir.css" rel="stylesheet" type="text/css">
<SCRIPT src="<%=rootPath%>/themes/department/<%=style%>/js/menu.js" type="text/javascript"></SCRIPT>
<script src="<%=rootPath%>/themes/department/<%=style%>/js/Columns_index.js" type="text/javascript"></script>
<!--[if IE 6]>
<script type="text/javascript" src="js/iepng.js"></script>
<script type="text/javascript"> 
EvPNG.fix('img,'); </script>
<![endif]-->

<%if(bgImg!=null && !"".equals(bgImg) && !"null".equals(bgImg)){%>
<style>
body { background:url(<%=preUrl%>/upload/department/<%=bgImg.substring(0,6)%>/<%=bgImg%>) top center repeat; background-attachment:fixed;}
</style>
<%}else{%>
<style>
body { background:url(<%=rootPath%>/themes/department/<%=style%>/images/bodybg.jpg) top center repeat; background-attachment:fixed;}
</style>
<%}%>

<style>
.bodybg{margin-bottom:20px;}
html,body{height:auto;}
</style>
</head>
<body class="MainFrameBox">
<div class="bodybg">
<!--头部开始-->
	<div id="head">
		<div class="topbox">
			<div class="logo"><%=orgName%></div>
			<!--div class="searchbox">
				<input name="title" type="text" class="textbg"/><input name="" type="button" value="搜索" class="btnbg"/><a href="#" class="searcha">高级搜索</a>
			</div-->
		</div>
		<div class="nav">
			<div id="mainMenuBar" style="FLOAT: left;  WIDTH: 960px;OVERFLOW: hidden;">
				<div id="mainMenuBarBox" style="WIDTH:20000px;">
					<div id="mainMenuBarBox2" style="FLOAT: left;">
						<ul>
							<li><a href="department_index.jsp?orgId=<%=orgId%>&orgName=<%=orgName%>"><%=Resource.getValue(local,"common","comm.homepage")%></a></li>
							<%
							if(list!=null && list.size()>0){
								for(int i=0;i<list.size();i++){
									Object[] obj = (Object[]) list.get(i);
									String channelId = obj[0].toString();
									if("1".equals(obj[3].toString())){
							%>
							<li id="<%=obj[0]%>"><a href="javascript:void(0);" onclick="menuJump('<%=rootPath%>/InfoList!allList.action?checkdepart=1&channelId=<%=obj[0]%>&channelName=<%=obj[1]%>&channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&headColor=D2D2D2','<%=obj[1].toString()%>');"><%=obj[1].toString()%></a>
							<%
										boolean second = false;
										for(int j=0;j<list.size();j++){
											Object[] ob = (Object[]) list.get(j);
											if(channelId.equals(ob[4].toString())){
												second = true;
												break;
											}
										}
										if(second){
							%>
								<div class="subnav" id="subnav_<%=obj[0]%>">
									<div class="subnavbox">
							<%
											for(int m=0;m<list.size();m++){
												Object[] o = (Object[]) list.get(m);
												if(channelId.equals(o[4].toString())){
													String channelId1 = o[0].toString();
													boolean third = false;
													for(int k=0;k<list.size();k++){
														Object[] o_ = (Object[]) list.get(k);
														if(channelId1.equals(o_[4].toString())){
															third = true;
															break;
														}
													}
													if(third){
							%>
										<div class="threebox">
											<a href="javascript:void(0);" class="navmore" onclick="menuJump('<%=rootPath%>/InfoList!allList.action?checkdepart=1&channelId=<%=o[0]%>&channelName=<%=obj[1]%>&channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&headColor=D2D2D2','<%=o[1].toString()%>');"><%=o[1].toString()%></a>
												<div class="threenav">
							<%
														for(int n=0;n<list.size();n++){
															Object[] o__ = (Object[]) list.get(n);
															if(channelId1.equals(o__[4].toString())){
							%>
													<a href="javascript:void(0);" onclick="menuJump('<%=rootPath%>/InfoList!allList.action?checkdepart=1&channelId=<%=o__[0]%>&channelName=<%=obj[1]%>&channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&headColor=D2D2D2','<%=o__[1].toString()%>');"><%=o__[1].toString()%></a>	
							<%
															}
														}
							%>
												</div>
										</div>
							<%
													}else{
							%>
										<a href="javascript:void(0);" class="nonav" onclick="menuJump('<%=rootPath%>/InfoList!allList.action?checkdepart=1&channelId=<%=o[0]%>&channelName=<%=obj[1]%>&channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&headColor=D2D2D2','<%=o[1].toString()%>');"><%=o[1].toString()%></a>
							<%
													}
												}
											}
							%>
									</div>
								</div>
							</li>
							<%
										}else{
							%>
							</li>
							<%
										}
									}
								}
							}
							%>
						</ul>
					</div>
				</div>
			</div>
			<div >
				<div class="scrollArrowLeft" id="moveLeftSpan" title="<%=Resource.getValue(local,"common","comm.showleft")%>" onclick="menuMoveLeft();"></div>
				<div class="scrollArrowRight" id="moveRightSpan" title="<%=Resource.getValue(local,"common","comm.showright")%>" onclick="menuMoveRight();"></div>
			</div>
		</div>
        <!--菜单按钮开始-->
        <div class="shortcut">
			<ul>
				<li class="b_01"><a href="javascript:void(0);" onclick="openWin({url:'<%=rootPath%>/Information!add.action?channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&type=department',isFull:true,winName:'newInfo'});" title="<bean:message bundle='information' key='info.newcontent'/>"></a></li>
				<li class="b_02"><a href="javascript:void(0);" onclick="menuJump('<%=rootPath%>/InfoList!myIssue.action?channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&headColor=D2D2D2&type=department','<%=Resource.getValue(local,"common","comm.myrelase")%>');" title="<bean:message bundle='information' key='info.mypulication'/>"></a></li>
				<%if(((channelRight && !"isView".equals(isView))||managerBD.hasRight(userId, "01*01*02")||managerBD.hasRight(userId, "01*02*01")||managerBD.hasRight(userId, "01*03*03")) && !isPad){%>
				<%
					if(channelRight && (managerBD.hasRight(userId, "01*02*01") || managerBD.hasRight(userId, "01*03*03") || managerBD.hasRight(userId, "01*01*02"))){
				%>
				<li class="b_03"><a href="javascript:void(0);" onclick="menuJump('<%=rootPath%>/Channel!channelList.action?channelType=<%=orgId%>&userChannelName=<%=orgName%>&userDefine=0&headColor=D2D2D2&type=department','<%=Resource.getValue(local,"common","comm.cateset")%>');" title="<bean:message bundle='information' key='info.columnsetup'/>"></a></li>               
                <%if("2".equals(workflowType) || "1".equals(workflowType)){%>
				<li class="b_04"><a href="javascript:void(0);" onclick="menuJump('<%=rootPath%>/wfprocess!processList.action?moduleId=4&headColor=D2D2D2&type=department','<%=Resource.getValue(local,"common","comm.flowset")%>');" title="<bean:message bundle='information' key='info.processsetup'/>"></a></li>
                <%}%>
                <%if("2".equals(workflowType) || "0".equals(workflowType)){%>
                <li class="b_07"><a href="javascript:void(0);" onclick="menuJump('<%=rootPath%>/ezflowprocess!ezFlowList.action?moduleId=4&headColor=D2D2D2&type=department','<%=Resource.getValue(local,"common","comm.flowset")%>(ezFlow)');" title="<bean:message bundle='information' key='info.processsetup'/>(ezFlow)"></a></li><%}%>
                <%}%>
				<%
					boolean isSetting = false;
					if(managerBD.hasRight(userId, "01*02*01") || managerBD.hasRight(userId, "01*03*03") || managerBD.hasRight(userId, "01*01*02")){
						//if(managerBD.hasRight(userId, "01*02*01") || managerBD.hasRight(userId, "01*03*03"))
							isSetting=true;
						/*if(isSetting == false){
							if(managerBD.hasRight(userId, "01*01*02")) {
								List rightList = managerBD.getRightScope(userId, "01*01*02");
								if(rightList != null && rightList.size() > 0) {
									//有权限
									Object[] objRight = (Object[])rightList.get(0);
									int scopeType = Integer.parseInt(objRight[0].toString());
									if(scopeType != 0){
										if(userOrgId.equals(orgId)){
											isSetting = true;
										}
									}else if(scopeType == 0){
										isSetting = true;
									}
								}
							}
						}*/

						if(isSetting && channelRight){
				%>
				<li class="b_05"><a href="javascript:void(0);" onclick="menuJump('department_skin.jsp?orgId=<%=orgId%>&orgName=<%=orgName%>&style=<%=style%>','<%=Resource.getValue(local,"common","comm.skinset")%>');" title="<bean:message bundle='information' key='info.skinSetting'/>"></a></li>
				<li class="b_06"><a href="javascript:void(0);" onclick="design();" title="<bean:message bundle='information' key='info.detailfirstSetting'/>"></a></li>
				<%}}%>
				<%}%>
			</ul>
		</div>
        <!--菜单按钮结束-->
	</div>

<script type="text/javascript">
$(".nav li").each(function (i, item) {
	var left = $(this).offset().left - $(".nav li").offset().left;
	$(this).attr("alt", left);
	var id = $(this).attr("id");
	if (left > 820) {
		jQuery("#subnav_" + id).css("left", "780px");
	}
	else {
		jQuery("#subnav_" + id).css("left", left);
	}
});
</script>
<!--头部结束-->
<!--内容开始-->
	<div class="mainbox">
		<div class="mainnr">
			<!--左开始-->
			<div class="left906" style="background-color:#fff;">
				<iframe id="leftFrame" name="leftFrame" src="about:blank" scrolling="no" frameborder="0" border="0" width="1%" height="1%" style="display:none"></iframe>
				<iframe id="MainIframe" name="MainIframe" src="about:blank" scrolling="no" frameborder="0" border="0" width="100%" height="100%" framespacing="0" allowTransparency="true"></iframe>
			</div>
			<!--左结束-->
		</div>
		<div class="clear_1"></div>
	</div>
</div>
</body>
<script>
var s = 0;
$(document).ready(function(){
	//resizeWin(screen.width, screen.height);
	/*$('.nav li').mouseover(function(){
		$(this).find('.subnav').slideDown("fast");
		jQuery(this).attr("class", "aon");
	});
	$('.nav li').mouseleave(function(){
		$(this).find('.subnav').hide();
		jQuery(this).attr("class", "");
	});*/
	$('.threebox').mouseover(function(){
		$(this).find('.threenav').show();
	});
	$('.threebox').mouseleave(function(){
		$(this).find('.threenav').hide();
	});
	

	$('.nav li').mouseover(function () {
		$('.nav li').removeAttr("class"); 
		$(this).find('.subnav').slideDown("fast");
		jQuery(this).addClass("aon");
		var id = $(this).attr("id");
		var left = $(this).attr("alt") - $(this).attr("rel");
		jQuery("#subnav_" + id).show();
		jQuery("#subnav_" + id).css("left", left);
	});

	$('.nav li').mouseleave(function () {
		$('.nav li').removeAttr("class"); 
		$('.subnav').hide();
	});

	$('.threenav').mouseleave(function(){
		$(this).hide();
	});
	
	var layoutId = '<%=layoutId%>';
	if(layoutId!=null && layoutId!='null'){
		menuJump(whirRootPath+'/platform/portal/portal_main.jsp?preview=1&orgId=<%=orgId%>&id='+layoutId,'');
	}

	loadIframe();
});
var sheight =0;
function loadIframe(){
	s = setInterval('reSetIframe()',1000);
}

function reSetIframe() {
	var iframe = document.getElementById("MainIframe");
	try {
		gg();
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.height = height;
	} catch (ex) { 
    }
	if(document.getElementById("MainIframe").height==sheight){
		clearInterval(s);
	}
	sheight =height;
}

function gg() {
	var iframe = document.getElementById("MainIframe");
	//20160623 -by jqq 去掉高度设置，否则页面只能展示600px高 ，显示不全
	//iframe.height =600;
}

function design(){
	var orgId = '<%=orgId%>';
	var orgName = '<%=orgName%>';
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Define!getOrgLayout.action",
		async: true,
		dataType: 'json',
        data: "orgId="+orgId+"&orgName="+orgName,
		success: function(data){
			if(data!=null && data!=""){
				data = eval(data);
				if(data.layoutId != null){
					//menuJump(whirRootPath+'/PortalLayout!design.action?layoutId='+data.layoutId+'&type=department&orgId='+orgId,'首页设置');
					openWin({url:whirRootPath+'/PortalLayout!design.action?layoutId='+data.layoutId+'&type=department&orgId='+orgId,isFull:true});
				}
			}
		}
	});
}

function menuJump(url,text){
	$(".left906").find('div').eq(0).remove();
	if(text!=''){
		$(".left906").prepend('<div class="title01" style="margin-bottom:10px;">'+text+'</div>');
	}
	window.MainIframe.location.href=encodeURI(url);
    setTimeout('reSetIframe()',1000);
}
</script>
</html>