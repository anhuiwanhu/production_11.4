<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");

ModuleVO mvo = (ModuleVO)request.getAttribute("mvo");
if(mvo!=null){
    List list = mvo.getItemList();
%>
	    <%
		if(list != null && list.size() > 0){
		    for (int i = 0; i < list.size(); i++) {
		        ItemVO ivo = (ItemVO)list.get(i);
				//20160705 -by jqq 过滤标点符号特殊字符，针对ie8等浏览器open新窗口winName报错改造
				String dealedTitle = portletSettingId!=null ? portletSettingId : "";
				if(ivo.getTitle()!=null && !"".equals(ivo.getTitle())){
					dealedTitle = ivo.getTitle().replaceAll("[\\pP‘’“”]", "") + dealedTitle;
				}
		%>
        <div class="wh-portal-i-item clearfix">
            <a href="javascript:void(0)" >
                <i class="fa fa-file-o"></i>
                <span title = "<%=ivo.getTitle()%>" onclick="gotoPortletURL(this, {lefturl:'<%=ivo.getLink()%>', righturl:'', winname:'<%=dealedTitle%>', wintype:'1'});"><%=ivo.getTitle()%></span>
            </a>
            <em class="wh-pending-em"><%=ivo.getTime()%> 截至</em>
        </div>
        <%}}%>
<%}%>