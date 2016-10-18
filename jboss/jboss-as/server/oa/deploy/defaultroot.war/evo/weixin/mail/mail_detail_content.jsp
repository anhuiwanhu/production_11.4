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
	<c:set var="boardroomApplyId">${boardroomApplyId}</c:set>
	<c:set var="wfWorkId">${wfWorkId}</c:set>
	<%
	    String content = (String)pageContext.getAttribute("mailcontent");
	    content = com.whir.component.util.StringUtils.resizeImgSize(content, "240", "50%");
	    String infoId = (String)pageContext.getAttribute("infoId");
	    String infoType = (String)pageContext.getAttribute("infoType");
	    String channelId = (String)pageContext.getAttribute("channelId");
	    String boardroomApplyId = (String)pageContext.getAttribute("boardroomApplyId");
		String wfWorkId = (String)pageContext.getAttribute("wfWorkId");
		String rep ="";
		if(infoId != null && !"".equals(infoId)){
			rep = "<a target='_top' href='/defaultroot/mail/mailInfo.controller?infoId="+infoId+"&informationType="+infoType+"&channelId="+channelId+"'>";
		}else if(boardroomApplyId != null && !"".equals(boardroomApplyId)){
		    rep = "<a target='_top' href='/defaultroot/meeting/meetingNoticeDetail.controller?boardroomApplyId="+boardroomApplyId+"'>";
		}else if(wfWorkId != null && !"".equals(wfWorkId)){
		    rep = "<a target='_top' href='/defaultroot/dealfile/process.controller?workStatus=0&workId="+wfWorkId+"'>";
		}
    	content = content.replaceAll("<a href[^>]*>",rep);
    	String gnome = HtmlUtils.htmlUnescape((String)pageContext.getAttribute("gnome"));
	%>
	<%=content %> <%=gnome %>
</body>
</html>