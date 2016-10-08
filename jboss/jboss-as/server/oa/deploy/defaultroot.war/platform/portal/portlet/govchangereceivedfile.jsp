<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.component.util.DateUtils"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.PortletUtil"%>

<%
//模块页面
/*response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);*/
response.setContentType("text/html; charset=UTF-8");
String _skin = PortletUtil.getSkin(request);
String portletSettingId = request.getParameter("portletSettingId");

PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String limitNum = confMap.get("limitNum");
String limitChar = confMap.get("limitChar");
DateUtils utils = new DateUtils();
String dateFmt = confMap.get("dateFmt");
int limitCharNum = 0;
if(limitChar!=null && !"".equals(limitChar)){
	limitCharNum = Integer.parseInt(limitChar);
}
String showItem = confMap.get("showItem");
String []item = null;
if(showItem!=null && !"".equals(showItem)){
	showItem = showItem.substring(0,showItem.length()-1);
	item = showItem.split(",");
}

int cnt = 10;
if(limitNum!=null&&!"".equals(limitNum)&&!"null".equals(limitNum)){
    cnt = Integer.parseInt(limitNum);
}
Object[] obj=null;
Object[] obj1=null;
if(showItem.indexOf("未收公文")!=-1){
	//未收
	obj = new com.whir.govezoffice.documentmanager.actionsupport.GovExchangeAction().getListReceiveByRemote(session.getAttribute("userId").toString(), session.getAttribute("orgId").toString(), cnt, "0");
}
if(showItem.indexOf("已收公文")!=-1){
	//已收
	obj1 = new com.whir.govezoffice.documentmanager.actionsupport.GovExchangeAction().getListReceiveByRemote(session.getAttribute("userId").toString(), session.getAttribute("orgId").toString(), cnt, "1");
}
%>
<script type="text/javascript">
var jsonData=[{
	ulCss:"wh-portal-title-slide04-<%=portletSettingId%>",
	data:[
	<%
	if(item!=null){
		String leftUrl = "/defaultroot/GovDoc!menu.action?portletSettingId=notReceive";
		String rightUrl = "/defaultroot/GovExchange!exchangeReceive.action";
		for(int i=0;i<item.length;i++){
			if("已收公文".equals(item[i])){
				leftUrl="/defaultroot/GovDoc!menu.action?portletSettingId=receive";
				rightUrl="/defaultroot/GovExchange!exchangeReceive.action?receive=hasReceive";
			}
	%>
	<%if(i!=item.length-1){%>
	{title:'<%=item[i]%>',url:'#',onclick:'',defaultSelected:'<%=i==0?"on":""%>',liCss:'',morelink:"jumpnew('<%=leftUrl%>','<%=rightUrl%>')"},
	<%}else{%>
	{title:'<%=item[i]%>',url:'#',onclick:'',defaultSelected:'<%=i==0?"on":""%>',liCss:'',morelink:"jumpnew('<%=leftUrl%>','<%=rightUrl%>')"}
	<%}}}%>
	]
}];
Portlet.setPortletDataTitle('<%=portletSettingId%>',jsonData);
Portlet.setMoreLink('<%=portletSettingId%>', {});
</script>
<%if(item!=null){ %>
	<div class="wh-portal-info-content">
		<div class="wh-portal-slide04-<%=portletSettingId%>">
			<ul class="clearfix">
<% if(showItem.indexOf("未收公文")!=-1){ %>
				<li>
<% if(obj!=null&&obj.length>0){
	if(obj.length>1){
        List list = (List)obj[1];
        if(list!=null&&list.size()>0){
            for(int i=0; i<list.size(); i++){
                String[] o = (String[])list.get(i);
                if(o!=null){%>
					<div class="wh-portal-i-item clearfix">
					    <a href="javascript:void(0)" class="clearfix">
					    <%= o[2].toString()==null || "".equals(o[2].toString()) ? "暂无文号" : o[2].toString()%>&nbsp;&nbsp;
					    <span class="wh-portal-a-cursor" title="<%= o[1].toString().replaceAll("\"","&quot;")%>" onclick="openWin({url:'<%=o[0]%>',winName:'govexchange',isFull:true});"><%=o[1].toString().length()>limitCharNum && limitCharNum>0 ? o[1].toString().substring(0,limitCharNum)+"..." : o[1].toString()%></span>
					    <em class="wh-pending-em">&nbsp;[<%=utils.strToDateFmtStr(o[3],dateFmt)%>]</em>
					    </a>
					</div>
<%}}}}}%>
				</li>
<%}%>

<%if(showItem.indexOf("已收公文")!=-1){ if(showItem.indexOf("未收公文")==-1){%>
				<li>
<%}else{ %>
				 <li class="wh-portal-hidden">
<%} %>
<%if(obj1!=null&&obj1.length>0){
    if(obj1.length>1){
        List list = (List)obj1[1];
        if(list!=null&&list.size()>0){
            for(int i=0; i<list.size(); i++){
                String[] o = (String[])list.get(i);
                if(o!=null){%>
					<div class="wh-portal-i-item clearfix">
					    <a href="javascript:void(0)" class="clearfix">
					    <%= o[2].toString()==null || "".equals(o[2].toString()) ? "暂无文号" : o[2].toString()%>&nbsp;&nbsp;
					    <span class="wh-portal-a-cursor" title="<%= o[1].toString().replaceAll("\"","&quot;")%>" onclick="openWin({url:'<%=o[0]%>',winName:'govexchange',isFull:true});"><%=o[1].toString().length()>limitCharNum && limitCharNum>0 ? o[1].toString().substring(0,limitCharNum)+"..." : o[1].toString()%></span>
					    <em class="wh-pending-em">&nbsp;[<%=utils.strToDateFmtStr(o[3],dateFmt)%>]</em>
					    </a>
					</div>
<%}}}}}%>
				</li>
<%}%>
			</ul>
		</div>
	</div>
<%} %>
<script type="text/javascript">
	slideTab("slide04-<%=portletSettingId%>");
</script>