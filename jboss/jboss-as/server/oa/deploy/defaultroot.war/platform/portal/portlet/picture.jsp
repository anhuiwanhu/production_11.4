<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.PortletUtil"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
String portletSettingId = request.getParameter("portletSettingId");
String path = request.getParameter("path");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String mWidth = confMap.get("mWidth");
String mHeight = confMap.get("mHeight");
PortalLayoutBD bd = new PortalLayoutBD();
List list = bd.getPortalPortletFileList(portletSettingId);
%>
<%
if(list!=null&&list.size()>0){
%>

<div class="wh-portal-pic-slide wh-portal-pic-sigslide" id="pictureSlide_<%=portletSettingId %>">
<%
if(list.size()>1){
%>
        <ul class="slides clearfix" id="slides_<%=portletSettingId %>">
    <%
        for(int i=0; i<list.size(); i++){
            PortalPortletFilePO fpo = (PortalPortletFilePO)list.get(i);
    %>
    	<li>
            <div class="wh-portal-pic-slide-box">
                <a class="wh-portal-pic-slide-img"><img width="<%=mWidth %>" height="<%=mHeight %>" id="<%=fpo.getId()%>" src="<%=fileServer%>/upload/portal/<%=fpo.getSavename().substring(0,6)%>/<%=fpo.getSavename()%>" alt="<%=fpo.getRealname()%>" <%=fpo.getUrl()!=null?"onclick=\"window.open('"+fpo.getUrl()+"');\"":""%>/></a>
            </div>
        </li>
    <%}%>
    </ul>
    <ul class="wh-portal-pic-slide-circle" id="wh-portal-pic-slide-circle_<%=portletSettingId %>">
    <%
        for(int i=0; i<list.size(); i++){
    %>
        <li></li>
    <%} %>
    </ul>
    <%}else{ PortalPortletFilePO fpo = (PortalPortletFilePO)list.get(0);%>
    <p class="wh-portal-pic-simg"><img width="<%=mWidth %>" height="<%=mHeight %>" id="<%=fpo.getId()%>" src="<%=fileServer%>/upload/portal/<%=fpo.getSavename().substring(0,6)%>/<%=fpo.getSavename()%>" alt="<%=fpo.getRealname()%>" <%=fpo.getUrl()!=null?"onclick=\"window.open('"+fpo.getUrl()+"');\"":""%>/></p>
<%} %>
</div>
<%}%>
<script type="text/javascript">
	$('#pictureSlide_<%=portletSettingId %>').flexslider({
        controlsContainer: "#slides_<%=portletSettingId %>",
        manualControls: "#wh-portal-pic-slide-circle_<%=portletSettingId %> li",
        directionNav: false,
        animation: 'fade',
        pauseOnHover: false
    });
</script>