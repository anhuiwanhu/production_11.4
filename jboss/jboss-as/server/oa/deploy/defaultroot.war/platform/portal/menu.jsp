<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.portal.bd.*,com.whir.ezoffice.portal.po.PortalMenuSetPO,com.whir.ezoffice.portal.po.PortalMenuPO"%>
<%
String rnd = request.getParameter("rnd");
String _skin = request.getParameter("skin");
String layoutId = request.getParameter("layoutId");
String solutionId = request.getParameter("solutionId");
String skin = _skin.substring(_skin.lastIndexOf("/")+1);
if(solutionId!=null&&!"".equals(solutionId)&&!"null".equals(solutionId)){
%>
<link href="<%=rootPath%>/<%=_skin%>/menu/css/main.css" rel="stylesheet" type="text/css" />
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
<%
//String path = "http://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath();
PortalBD bd = new PortalBD();
//PortalMenuSetPO po = bd.getMenuSet();
//List menuList = bd.getMenus();//po.id,po.name,po.linkUrl,po.linkType,po.menuType,po.menuId 
PortalMenuSetPO po = bd.loadPortalMenuSetPO(solutionId);
List menuList = bd.getAllYJMenuBySolutionId(solutionId);
if(menuList!=null&&menuList.size()>0){
	if("0".equals(po.getMenuShowType())){%>
	<td height="30" align="left" valign="top" class="moduleHeader" style="background-repeat:repeat-x;">
	<div id="mainMenuBar" style="width:900px;overflow:hidden;float:left;">
        <div id="mainMenuBarBox" style="width:20000px;overflow:hidden;">
            <div id="mainMenuBarBox2">
            <div id="btnMod"  class="btnModule" onmouseover="mouseOver(this);" onMouseOut="mouseOut(this);" onClick="main();">
                <div class="mnuMainLeft_"></div>
                <div class="mnuMainLeftCenter">首&nbsp; &nbsp;页</div>
                <div class="mnuMainLeftRight"></div>
            </div>
<%		for(int i=0; i<menuList.size(); i++){
			PortalMenuPO mpo = (PortalMenuPO)menuList.get(i);
			//po.id,po.name,po.linkUrl,po.linkType
			//linkURL 按 leftURL $ rightURL格式保存的
			//out.print(" | " + obj[1]);
            List secondList = bd.getXJMenuByMenuId(mpo.getId()+"");//二级菜单
            boolean hasChild = secondList!=null&&secondList.size()>0?true:false;
%>
			<div id="btnMod" class="btnModule" onClick="clicked('<%=mpo.getId()%>','<%=mpo.getLinkUrl()%>','<%=mpo.getMenuType()%>','<%=mpo.getMenuId()%>',<%=hasChild%>, '<%=mpo.getLinkType()%>');" onmouseover="mouseOver(this);" onMouseOut="mouseOut(this);">
				 <div class="mnuMainLeft"></div>
				 <div class="mnuMainLeftCenter"><%=mpo.getName()%></div>
				 <div class="mnuMainLeftRight"></div>
			</div>

<%}%>
			<!--div class="btnModule">
				 <div class="mnuMainLeft"></div>
				 <div class="mnuMainLeftCenter"><div style="padding:6px;"><input type="text" id="title" name="title" value=""  class="text-title"/><input name="" type="submit" value="站内搜索"  onclick="searchInfo();" class="btn-search"></div></div>
				 <div class="mnuMainLeftRight"></div>
			</div-->
		</div>
	</div>
</div>
		<div>
            <div id="moveLeftSpan" class="scrollArrowLeft" title="显示左端" onClick="menuMoveLeft();"></div>
            <div id="moveRightSpan" class="scrollArrowRight" title="显示右端" onClick="menuMoveRight();"></div>
        </div>
<%	}else{
		int num = po.getMenuColumns().intValue();
		int row = (menuList.size()+1)%num;
		if(row>0)row = (menuList.size()+1)/num + 1;
		else row = (menuList.size()+1)/num;
%>		
	<td>
		<div class="nav_bg">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr valign="top">
					<td nowrap>
						<ul>
						<li><a href="#" onClick="main();">首&nbsp; &nbsp;页</a></li>
					<%
                        for(int i=0;i<num-1;i++){
						    PortalMenuPO mpo = (PortalMenuPO)menuList.get(i);
                            List secondList = bd.getXJMenuByMenuId(mpo.getId()+"");//二级菜单
                            boolean hasChild = secondList!=null&&secondList.size()>0?true:false;
					%>
						<li><a href="#" onclick="clicked('<%=mpo.getId()%>','<%=mpo.getLinkUrl()%>','<%=mpo.getMenuType()%>','<%=mpo.getMenuId()%>',<%=hasChild%>, '<%=mpo.getLinkType()%>');"><%=mpo.getName()%></a></li>
					<%}%>
						</ul>
					<td>
				</tr>
		<%if(row>1&&row!=2){%>
			<%for(int j=1;j<row;j++){
				if(j==1){
			%>
				<tr valign="top">
					<td nowrap>
						<ul>
					<%
                        for(int m=num-1;m<num*2-1;m++){
						    PortalMenuPO mpo = (PortalMenuPO)menuList.get(m);
                            List secondList = bd.getXJMenuByMenuId(mpo.getId()+"");//二级菜单
                            boolean hasChild = secondList!=null&&secondList.size()>0?true:false;
					%>
						<li><a href="#" onclick="clicked('<%=mpo.getId()%>','<%=mpo.getLinkUrl()%>','<%=mpo.getMenuType()%>','<%=mpo.getMenuId()%>',<%=hasChild%>, '<%=mpo.getLinkType()%>');"><%=mpo.getName()%></a></li>
					<%}%>
						</ul>
					</td>
				</tr>
				<%}else if(j==row-1){%>
				<tr valign="top">
					<td nowrap>
						<ul>
					<%
                        for(int m=num*j-1;m<menuList.size();m++){
						    PortalMenuPO mpo = (PortalMenuPO)menuList.get(m);
                            List secondList = bd.getXJMenuByMenuId(mpo.getId()+"");//二级菜单
                            boolean hasChild = secondList!=null&&secondList.size()>0?true:false;
					%>
						<li><a href="#" onclick="clicked('<%=mpo.getId()%>','<%=mpo.getLinkUrl()%>','<%=mpo.getMenuType()%>','<%=mpo.getMenuId()%>',<%=hasChild%>, '<%=mpo.getLinkType()%>');"><%=mpo.getName()%></a></li>
					<%}%>
						</ul>
					</td>
				</tr>                
				<%}else{%>
				<tr valign="top">
					<td nowrap>
						<ul>
					<%
                        for(int m=num*j-1;m<num*(j+1)-1;m++){
						    PortalMenuPO mpo = (PortalMenuPO)menuList.get(m);
                            List secondList = bd.getXJMenuByMenuId(mpo.getId()+"");//二级菜单
                            boolean hasChild = secondList!=null&&secondList.size()>0?true:false;
					%>
						<li><a href="#" onclick="clicked('<%=mpo.getId()%>','<%=mpo.getLinkUrl()%>','<%=mpo.getMenuType()%>','<%=mpo.getMenuId()%>',<%=hasChild%>, '<%=mpo.getLinkType()%>');"><%=mpo.getName()%></a></li>
					<%}%>
						</ul>
					</td>
				</tr>
				<%}%>
			<%}%>
		<%}else if(row==2){%>
			<tr valign="top">
				<td nowrap>
					<ul>
					<%
                        for(int m=num-1;m<menuList.size();m++){
						    PortalMenuPO mpo = (PortalMenuPO)menuList.get(m);
                            List secondList = bd.getXJMenuByMenuId(mpo.getId()+"");//二级菜单
                            boolean hasChild = secondList!=null&&secondList.size()>0?true:false;
					%>
						<li><a href="#" onclick="clicked('<%=mpo.getId()%>','<%=mpo.getLinkUrl()%>','<%=mpo.getMenuType()%>','<%=mpo.getMenuId()%>',<%=hasChild%>, '<%=mpo.getLinkType()%>');"><%=mpo.getName()%></a></li>
					<%}%>
					</ul>
				</td>
			</tr>
		<%}%>
        </table>
		</div>
	<%}%>
<%}%>	
        </td>
    </tr>
</table>
<script>
function setMoveButton(){	
	var m=document.getElementById("mainMenuBar");
	var mW=document.getElementById("mainMenuBarBox2").offsetWidth-m.offsetWidth;
	var sW=m.scrollLeft;
	if(sW<=0){
		document.getElementById("moveLeftSpan").className="scrollArrowLeftDisabled";
	}else{
		document.getElementById("moveLeftSpan").className="scrollArrowLeft";
	}
	if(sW<mW){
		document.getElementById("moveRightSpan").className="scrollArrowRight";
	}else{
		document.getElementById("moveRightSpan").className="scrollArrowRightDisabled";
	}
} 

function menuMoveRight(){
	var m=document.getElementById("mainMenuBar");
	var mW=document.getElementById("mainMenuBarBox2").offsetWidth-m.offsetWidth;
	var sW=m.scrollLeft;
	if(sW<mW){
        sW+=150;
	}
    if(sW>mW){
		sW=mW
	}
	m.scrollLeft=sW;
	setMoveButton();
}

function menuMoveLeft(){
	var m=document.getElementById("mainMenuBar");
	var mW=0;
	var sW=m.scrollLeft;
	if(sW>mW){
        sW-=150;
	}
    if(sW<mW){sW=mW}
	m.scrollLeft=sW;
	setMoveButton();
}

function mouseOver(obj){
	var _className=obj.className;
	if(_className=='btnModuleSelected'){
	}else{
		obj.className="btnModuleActive";
	}
}

function mouseOut(obj){
	var _className=obj.className;
	if(_className=='btnModuleSelected'){
	}else{
		obj.className="btnModule";
	}
}

function clicked(id,linkURL,menuType,menuId,hasChild,linkType){
    //linkType 链接类型：0-弹出窗口 1-当前窗口
    <%if(!"1".equals(rnd)){%>
        if(hasChild){
            if(linkType=='1'){
                location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
            }else{
                openWin({url:'<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>', isFull:true,winName: 'menu'});
            }
        }else{
            if(menuType=='0'){
                if(linkURL.indexOf("http://")>-1){
                }else{
                    linkURL="http://"+linkURL;
                }
                if(linkType=='0'){
                    window.open(linkURL, '', '');
					//openWin({url:linkURL, isFull:true, winName:'menu'});
                }else{
                    //location.href=linkURL;
                    location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
                }
            }else if(menuType=='3'){
                if(linkType=='0'){
                    //window.open("<%=rootPath%>/platform/portal/main_go.jsp?preview=1&layoutId=<%=layoutId%>&rnd=1&id="+id+"&_self=true");
					//openWin({url:'<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true', isFull:true, winName:'menu'});
                    window.open('<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>');
                }else{
                    location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
                }
            }else if(menuType=='4'){
                if(linkType=='0'){
                    //window.open("<%=rootPath%>/platform/portal/main_go.jsp?preview=1&layoutId=<%=layoutId%>&rnd=1&id="+id+"&_self=true");
					//openWin({url:'<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true', isFull:true, winName:'menu'});
                    window.open('<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>');
                }else{
                   location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
                }
            }
        }
    <%}else{%>
        if(hasChild){
            if(linkType=='1'){
                location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
            }else{
                //window.open("<%=rootPath%>/platform/portal/main_go.jsp?preview=1&layoutId=<%=layoutId%>&rnd=1&id="+id, '', '');
				//openWin({url:'<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id, isFull:true, winName:'menu'});
                window.open('<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>');
            }
        }else {
            if(menuType=='0'){
                if(linkURL.indexOf("http://")>-1){
                }else{
                    linkURL="http://"+linkURL;
                }
                if(linkType=='0'){
                    window.open(linkURL, '', '');
					//openWin({url:linkURL, isFull:true, winName:'menu'});
                }else{
                    //location.href=linkURL;
                    location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
                }
            }else if(menuType=='3'){
                if(linkType=='0'){
                    //window.open("<%=rootPath%>/platform/portal/main_go.jsp?preview=1&layoutId=<%=layoutId%>&rnd=1&id="+id+"&_self=true");
					//openWin({url:'<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true', isFull:true, winName:'menu'});
                    window.open('<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>');
                }else{
                    location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
                }
            }else if(menuType=='4'){
                if(linkType=='0'){
                    //window.open("<%=rootPath%>/platform/portal/main_go.jsp?preview=1&layoutId=<%=layoutId%>&rnd=1&id="+id+"&_self=true");
					//openWin({url:'<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true', isFull:true, winName:'menu'});
                    window.open('<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>');
                }else{
                    location.href='<%=rootPath%>/Portal!main_go.action?layoutId=<%=layoutId%>&rnd=1&id='+id+'&_self=true&skin=<%=skin%><%="1".equals(request.getParameter("useMode"))?"&useMode=1":""%>';
                }
            }
        }
    <%}%>
}

function main(){
    <%if("0".equals(request.getParameter("preview")!=null?request.getParameter("preview"):"") || "1".equals(request.getParameter("useMode")!=null?request.getParameter("useMode"):"")){%>
	    location.href="<%=rootPath%>/Portal!main.action?layoutId=<%=layoutId%>&useMode=1&skin=<%=skin%>";
    <%}else{%>
        location.href="<%=rootPath%>/portal.jsp?skin=<%=skin%>";
    <%}%>
}

function btnModClick(obj){
    if(btnMod){
	  for(i=0;i<btnMod.length;i++){
	    btnMod[i].style.backgroundImage='';
	    btnMod[i].style.color='';
	    btnMod[i].className="btnModule";
	  }
	  obj.className="btnModuleSelected";
	}
}
</script>
<%}%>