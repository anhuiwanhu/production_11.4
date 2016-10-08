<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="java.util.*" %>
<%
    if(session==null || session.getAttribute("userName")==null){
%>
    location.href="about:blank";
<%
    }else{
        String local = session.getAttribute("org.apache.struts.action.LOCALE")!=null?session.getAttribute("org.apache.struts.action.LOCALE").toString().toLowerCase():"zh_cn";
        try{
            java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
            if(sysMap != null &&
               sysMap.get("附件上传") != null &&
               sysMap.get("附件上传").toString().equals("0")){
%>
	ftp = true;
<%
            }
%>
    defaultFontSize="<%=com.whir.org.common.util.SysSetupReader.getInstance().getHtmlWordSize(session.getAttribute("domainId").toString())%>";
    defaultFontFamily="<%=com.whir.org.common.util.SysSetupReader.getInstance().getHtmlFontType(session.getAttribute("domainId").toString())%>";

    local="<%=local%>";
<%
        }catch(Exception e){
%>
	ftp=false;
	defaultFontSize="";
	defaultFontFamily="";
<%      
        }
%>
    def_rootPath = "<%=request.getContextPath()%>";
<%}%>