<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.i18n.Resource"%>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String classId = confMap.get("classId");
String view ="1";
view = confMap.get("view");
String newentry = "," + confMap.get("newentry");
int num = newentry.split(",").length-1;
int num2=0;
if(num>0){ num2= 100/num;}
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
String width = String.valueOf(num2).concat("%");
String[] arr = {"facolor-acd598","facolor-8f82bc","facolor-84ccc9","facolor-c989be","facolor-f29c9f","facolor-facd89","facolor-d5b798","facolor-7ecef4","facolor-82bc90","facolor-c6c1ba"};
//int index=(int)(Math.random()*arr.length);
//String rand = arr[index];
%>

<%if("2".equals(view)){ %><!--双行-->

    <div class="wh-quick-entry">
        <ul class="wh-quick-entry-list">
        <%if(newentry.indexOf(",1,")!=-1){ %>
            <li>
                <a title="<%=Resource.getValue(local, "common", "comm.newinfo")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/Information!add.action?channelType=0&userChannelName=信息管理&userDefine=0',isFull:true,winName:'newInfo'})"><i class="fa fa-pencil-square-o <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newinfo")%></span></a>
            </li>
         <%} %>
          <%if(newentry.indexOf(",2,")!=-1){ %>
            <li>
                <a title="<%=Resource.getValue(local, "common", "comm.mail")%>" href="javascript:void(0)" onclick="openWin({url:'/defaultroot/innerMail!openAddMail.action',isFull:'true',winName: 'openmail' });"><i class="fa fa-envelope <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.mail")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",3,")!=-1){ %>
            <li>
                <a title="<%=Resource.getValue(local, "common", "comm.workreport")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/WorkReportAction!addWorkReport.action?isFromDesktop=1&reportType=week',isFull:true,winName:'workreport'});"><i class="fa fa-file-text <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.workreport")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",4,")!=-1){ %>
            <li>
                <a title="<%=Resource.getValue(local, "common", "comm.worklog")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/WorkLogAction!addMyWorkLog.action',isFull:true,winName:'worklog'});"><i class="fa fa-file-text <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.worklog")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",5,")!=-1){ %>
            <li>
                <a  title="<%=Resource.getValue(local, "common", "comm.schedule")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/EventAction!addMyEvent.action?flagChangeEventType=1',width:810,height:640,winName:'taskcenter'});"><i class="fa fa-file-text <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.schedule")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",6,")!=-1){ %>
            <li>
                <a title="<%=Resource.getValue(local, "common", "comm.newworkflow")%>"  href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/bpmscope!canStart.action?myCommon=0&moduleId=1',width:810,height:640,winName:'bmp'});" ><i class="fa fa-sitemap <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newworkflow")%></span></a>
            </li>
            <%} %>
            <%if(newentry.indexOf(",7,")!=-1){ %>
            <li>
                <a title="<%=Resource.getValue(local, "common", "comm.newpost")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'defaultroot/ForumAction!addForum.action?forumFlag=topic&forumClassId=',width:810,height:640,winName:''});" ><i class="fa fa-comment <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newpost")%></span></a>
            </li>
            <%} %>
            <%if(newentry.indexOf(",8,")!=-1){ %>
            <li>
                <a  title="<%=Resource.getValue(local, "common", "comm.newmicroblog")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/index.vm?weibo_user_id=',width:810,height:640,winName:''});" ><i class="fa fa-weibo <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newmicroblog")%></span></a>
            </li>
            <%} %>
        </ul>
    </div>

<%} %>
<%if("1".equals(view)){ %><!--单行-->
<ul class="wh-sim-quick-entry-list">
        <%if(newentry.indexOf(",1,")!=-1){ //信息%>
            <li style="width:<%=width%>" >
                <a  title="<%=Resource.getValue(local, "common", "comm.newinfo")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/Information!add.action?channelType=0&userChannelName=信息管理&userDefine=0',isFull:true,winName:'newInfo'})"><i class="fa fa-pencil-square-o  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newinfo")%></span></a>
            </li>
         <%} %>
          <%if(newentry.indexOf(",2,")!=-1){ //邮件%>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.mail")%>" href="javascript:void(0)" onclick="openWin({url:'/defaultroot/innerMail!openAddMail.action',isFull:'true',winName: 'openmail' });"><i class="fa fa-envelope  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.mail")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",3,")!=-1){ //工作汇报 %>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.workreport")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/WorkReportAction!addWorkReport.action?isFromDesktop=1&reportType=week',isFull:true,winName:'workreport'});"><i class="fa fa-file-text  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.workreport")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",4,")!=-1){ //工作日志%>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.worklog")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/WorkLogAction!addMyWorkLog.action',isFull:true,winName:'worklog'});"><i class="fa fa-file-text  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.worklog")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",5,")!=-1){ //日程%>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.schedule")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/EventAction!addMyEvent.action?flagChangeEventType=1',width:810,height:640,winName:'taskcenter'});"><i class="fa fa-file-text  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.schedule")%></span></a>
            </li>
            <%} %>
          <%if(newentry.indexOf(",6,")!=-1){ //流程%>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.newworkflow")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'/defaultroot/bpmscope!canStart.action?myCommon=0&moduleId=1',width:810,height:640,winName:'bmp'});" ><i class="fa fa-sitemap  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newworkflow")%></span></a>
            </li>
            <%} %>
            <%if(newentry.indexOf(",7,")!=-1){ //发帖子%>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.newpost")%>" href="javascript:void(0)" onclick="javascript:openWin({url:'defaultroot/ForumAction!addForum.action?forumFlag=topic&forumClassId=',width:810,height:640,winName:''});" ><i class="fa fa-comment  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newpost")%></span></a>
            </li>
            <%} %>
            <%if(newentry.indexOf(",8,")!=-1){ //发微博%>
            <li style="width:<%=width%>" >
                <a title="<%=Resource.getValue(local, "common", "comm.newmicroblog")%>" href="javascript:void(0)" class="no-border" onclick="javascript:openWin({url:'/defaultroot/index.vm?weibo_user_id=',width:810,height:640,winName:''});" ><i class="fa fa-weibo  <%=arr[(int)(Math.random()*arr.length)]%>"></i><span><%=Resource.getValue(local, "common", "comm.newmicroblog")%></span></a>
            </li>
            <%} %>
        </ul>
  
<%} %>