<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.web.util.HtmlUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<%String newContent = "";%>
<%
String homePage = request.getParameter("homePage")==null?"2":request.getParameter("homePage");
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>邮件详情</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>
</head>
<body>
<c:choose>
<c:when test="${not empty docXml}">
	<form action="" method="post" id="readForm">
		<section class="wh-section wh-section-bottomfixed">
		    <article class="wh-edit wh-edit-forum">
		        <div class="wh-container">
					<x:parse xml="${docXml}" var="doc" />
					<c:set var="mailto"><x:out select="$doc//mailto/text()" /></c:set> 
					<c:set var="mailtosimple"><x:out select="$doc//mailtosimple/text()" /></c:set>
					<c:set var="mailposttime"><x:out select="$doc//mailposttime/text()" /></c:set>
					<c:set var="content">${mailcontent}</c:set> 
					<c:set var="mailpostername"><x:out select="$doc//mailpostername/text()"/></c:set> 
					<c:set var="mailsubject"><x:out select="$doc//mailsubject/text()" /></c:set> 
					<c:set var="accessorySize"><x:out select="$doc//accessorySize/text()" /></c:set> 
					<c:set var="gnome"><x:out select="$doc//gnome/text()" /></c:set> 
					<c:set var="mailcontent"><x:out select="$doc//mailcontent/text()" /></c:set>
					<c:if test="${fn:contains(mailpostername,'&lt;')}">
						<c:set var="mailpostername">${fn:substringBefore(mailpostername, "&lt;")}</c:set> 
					</c:if>
					<c:if test="${empty mailto}">
						<c:set var="mailto"></c:set> 
					</c:if> 
					<c:if test="${empty mailtosimple}">
						<c:set var="mailtosimple"></c:set> 
					</c:if> 
					<c:set var="mailcc"><x:out select="$doc//mailcc/text()"/></c:set>
					<c:set var="mailccsimple"><x:out select="$doc//mailccsimple/text()"/></c:set>
					<c:if test="${empty mailcc}">
						<c:set var="mailcc"></c:set> 
					</c:if> 
					<c:if test="${empty mailccsimple}">
						<c:set var="mailccsimple"></c:set> 
					</c:if> 
		            <table class="wh-table-edit">
		                <tr>
		                    <th >时间：</th>
		                    <td><input class="edit-ipt-r" type="text" readonly value="${fn:substring(mailposttime,0,16)}" style="text-align:left"/></td>
		                </tr>
		                <tr>
		                    <th>发件人：</th>
		                    <td><input class="edit-ipt-r" type="text" value="${mailpostername}" readonly style="text-align:left"/></td>
		                </tr>
		                <tr>
		                    <th>收件人：</th>
		                    <td>
		                        <span class="edit-ipt-reslut-l" >${mailto}</span>
		                    </td>
		                </tr>
		                <tr>
		                    <th>抄送：</th>
		                    <td>
		                        <span class="edit-ipt-reslut-l" >${mailcc}</span>
		                    </td>
		                </tr>
		                <tr>
		                    <th>主题：</th>
		                    <td><span class="edit-ipt-reslut-l" ><x:out select="$doc//mailsubject/text()" /></span></td>
		                </tr>
		                <tr>
		                    <th>附件：</th>
		                    <td>
		                    	<div class="wh-article-atta">
								<c:if test="${not empty realFileNames}">
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="${realFileNames}" />
										<jsp:param name="saveFileNames" value="${saveFileNames}" />
										<jsp:param name="moduleName" value="innerMailbox" />
									</jsp:include>
								</c:if>
								</div>
		                    </td>
		                </tr>
		                <tr>
		                    <th class="td-noborder">正文：</th><td class="td-noborder"></td>
						</tr>
						<tr>
							<%
		                		newContent = (String)pageContext.getAttribute("content");
								newContent = newContent.replaceAll("<SCRIPT[^>]*>[\\d\\D]*?</SCRIPT>","").replaceAll("<script[^>]*>[\\d\\D]*?</script>","").replaceAll("\"","'");
								String mailsubject = (String)pageContext.getAttribute("mailsubject");
								mailsubject = mailsubject.replace("\n","");
							%>
							<c:set var="newContent"><%=newContent %></c:set> 
							<c:set var="mailsubject"><%=mailsubject %></c:set> 
		                    <td colspan="2">
		                        <div class="wh-iframe" id="iframeDiv">
		                            <iframe src="mailDetailContet.controller?mailuserId=${param.mailuserId}&mailId=${param.mailId}" 
		                            allowtransparency="transparent" scrolling="auto" style="zoom:75%" class="wh-portal" 
		                            width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0">
		                            </iframe>
		                        </div>
		                    </td>
		                </tr>
		            </table>
		        </div>
		    </article>
		</section>
		<input type="hidden" name="mailreplySub" id="mailreplySub">
		<input type="hidden" name="mailreplyContent" id="mailreplyContent">
		<input type="hidden" name="mailId" id="mailId" value="${param.mailId}">
		<input type="hidden" name="mailuserId" id="mailuserId" value="${param.mailuserId}">
		<input type="hidden" name="openType" id="openType"/>
	</form>
	<footer class="wh-footer wh-footer-text">
	    <div class="wh-wrapper">
	        <div class="wh-container">
	            <div class="wh-footer-btn">
	            	 <div class="fbtn-more-nav">
	                    <div class="fbtn-more-nav-inner">
	                        <a href="javascript:replyAll();" class="fbtn-matter col-xs-12"><i class="fa fa-reply-all"></i>回复全部</a>
	                    </div>
	                    <div class="fbtn-more-nav-arrow"></div>
	                </div>
	                <a href="javascript:forward();" class="fbtn-cancel col-xs-5"><i class="fa fa-share"></i>转发</a>
	            	<c:choose>
	            		<c:when test="${param.detailType eq 'receive'}">
			                <a href="javascript:reply();" class="fbtn-matter col-xs-5"><i class="fa fa-reply-all"></i>回复</a>
	            		</c:when>
	            		<c:when test="${param.detailType eq 'send'}">
			                <a href="javascript:sendAgain();" class="fbtn-matter col-xs-5"><i class="fa fa-reply-all"></i>再次发送</a>
	            		</c:when>
	            	</c:choose>
			           <span id="fbtnMore" class="fbtn-matter col-xs-2"><i class="fa fa-bars"></i></a>    
	            </div>
	        </div>
	    </div>
	</footer>
 </c:when>
 <c:otherwise>
 	<script>
 		wx.ready(function(){
	 		alert('该邮件已被撤回或删除！');
	 		wx.closeWindow();
 		});
 	</script>
 </c:otherwise>
 </c:choose>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.core.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.datetime.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.select.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.ios7.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>   
<script type="text/javascript">
	$(function(){
		var agent = navigator.userAgent;
		if(agent.indexOf('iPhone')){
			$('#iframeDiv').addClass('wh-ios-iframe-bug');
		}
		 //更多菜单展开
        var fbtnMore = $("#fbtnMore");
        var fbtnMoreCon = $(".fbtn-more-nav");
        if(fbtnMoreCon.is(':visible')){
            fbtnMoreCon.hide();
            $(".wh-section").click(function(){
                fbtnMoreCon.hide();
            })
        }
        fbtnMoreCon.hide();
        fbtnMore.click(function(){
            fbtnMoreCon.toggle();
        });
	});
	
	//回复
	function replyAll(){
		var replySub = "Re:" + "${mailsubject}";
		var replyContent = "\r\n\r\n\r\n\r\n\r\n---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		replyContent += "内容: " + "${newContent}" + "\r\n";
		replyContent += "-----------  End  ------------" + "\r\n";
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('replyAll');
		$("#readForm").attr("action","replyAll.controller?openType=replyAll&homePage="+<%=homePage%>);
		$("#readForm").submit();
	}
	
    //回复
	function reply(){
		var replySub = "Re:" + "${mailsubject}";
		var replyContent = "\r\n\r\n\r\n\r\n\r\n---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		replyContent += "内容: " + "${newContent}" + "\r\n";
		replyContent += "-----------  End  ------------" + "\r\n";
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('reply');
		$("#readForm").attr("action","reply.controller?openType=reply&homePage="+<%=homePage%>);
		$("#readForm").submit();
	}
    
    //转发
	function forward(){
	    var replySub = "Fw:" + "${mailsubject}";
		var replyContent = "\r\n\r\n\r\n\r\n\r\n---------- 来源信息 ----------" + "\r\n";
		replyContent += "来自: " + "${mailpostername}" + "\r\n";
		replyContent += "给: " + "${mailtosimple}" + "${mailto}" + "\r\n";
		replyContent += "抄送:" + "${mailcc}" + "\r\n";
		replyContent += "发送时间:  " + "${mailposttime}" + "\r\n";
		replyContent += "主题:  " + "${mailsubject}" + "\r\n";
		replyContent += "内容: " + "${newContent}" + "\r\n";
		replyContent += "----------  End  ----------" + "\r\n";
		$("#mailreplySub").val(replySub);
		$("#mailreplyContent").val(replyContent);
		$('#openType').val('forward');
		$("#readForm").attr("action","forward.controller?openType=forward&homePage="+<%=homePage%>);
		$("#readForm").submit(); 
	}
    
    //再次发送
    function sendAgain(){
    	$('#openType').val('sendAgain');
    	$("#readForm").attr("action","sendAgain.controller?openType=sendAgain&homePage="+<%=homePage%>);
		$("#readForm").submit();
    }
</script>