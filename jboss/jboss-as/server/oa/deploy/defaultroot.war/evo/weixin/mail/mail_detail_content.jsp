<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.web.util.HtmlUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport">
	<link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
</head>
<body style="word-wrap:break-word;">
	<c:set var="mailcontent">${mailcontent}</c:set>
	<c:set var="gnome">${gnome}</c:set>
	<c:set var="infoId">${infoId}</c:set>
	<c:set var="infoType">${infoType}</c:set>
	<c:set var="channelId">${channelId}</c:set>
	<%
	    String content = (String)pageContext.getAttribute("mailcontent");
	    content = com.whir.component.util.StringUtils.resizeImgSize(content, "240", "50%");
	    if(content.indexOf("查看表单")!=-1){
	    	content = content.replaceAll("查看表单", "");
	    }
	    String infoId = (String)pageContext.getAttribute("infoId");
	    String infoType = (String)pageContext.getAttribute("infoType");
	    String channelId = (String)pageContext.getAttribute("channelId");
	    String rep = "<a href='/defaultroot/mail/mailInfo.controller?infoId="+infoId+"&informationType="+infoType+"&channelId="+channelId+"'>";
    	content = content.replaceAll("<a href[^>]*>",rep);
    	String gnome = HtmlUtils.htmlUnescape((String)pageContext.getAttribute("gnome"));
	%>
	<%=content %> <%=gnome %>
</body>
</html>