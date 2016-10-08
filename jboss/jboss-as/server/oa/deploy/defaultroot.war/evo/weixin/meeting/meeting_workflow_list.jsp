<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>发起流程</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<c:if test="${not empty docXml}">
	<x:parse xml="${docXml}" var="doc"/>
	<section id="sectionScroll" class="wh-section">
	    <article class="wh-article wh-article-receive">
	        <div class="wh-container"> 
			         <input type="hidden"  name="personNum" value="${personNum}" id="personNum"/>
					 <input type="hidden"  name="startDate" value="${startDate}" id="startDate"/>
					 <input type="hidden"  name="sHour" value="${sHour}" id="sHour"/>
					 <input type="hidden"  name="sMinu" value="${sMinu}" id="sMinu"/>
					 <input type="hidden"  name="endDate" value="${endDate}" id="endDate"/>
					 <input type="hidden"  name="eHour" value="${eHour}" id="eHour"/>
					 <input type="hidden"  name="eMinu" value="${eMinu}" id="eMinu"/>
					 <input type="hidden"  name="meetRoomId" value="${meetRoomId}" id="meetRoomId"/>
					 <input type="hidden"  name="meetRoomName" value="${meetRoomName}" id="meetRoomName"/>
					 <input type="hidden"  name="isVideo" value="${isVideo}" id="isVideo"/>
					<%
						int packageCount = 0;
					%>
		            <div class="wh-article-lists wh-article-list-d">
		                <ul>
		                <x:forEach select="$doc//processList/process" var="ct" >
						    <%
								packageCount ++;
							%>
							<c:set var="processId" ><x:out select="$ct//processId/text()" /></c:set>
							<c:set var="processName" ><x:out select="$ct//processName/text()" /></c:set>
							<c:set var="ezflowprocess_defid" ><x:out select="$ct//pool_ezflowprocess_defid/text()" /></c:set>
							<c:set var="pool_ezflowprocess_formKey" ><x:out select="$ct//pool_ezflowprocess_formKey/text()" /></c:set>
							<li onclick="newezform('${pool_ezflowprocess_formKey}','${ezflowprocess_defid}','${processName}');">
							<strong class="flow-icon">
								<i class="fa fa-file-text"></i>
							</strong>
							<p>
								<a><x:out select="$ct//processName/text()" /></a>
							</p>
		                    </li>
		                </x:forEach>
		                </ul>
						<c:set var="packageCount" ><%=packageCount%></c:set>
		                <c:if test="${packageCount >3}">
		                	<i class="fa fa-chevron-down"></i>
		                </c:if>
		            </div>
	        </div>
	    </article>
	</section>
</c:if>
<c:if test="${empty docXml}">
<div class="wh-article-lists">
   <ul id="content_ul">
		<li><p><a>暂无可用的会议申请ezFLOW流程！</a></p></li>
   </ul>
</div>
</c:if>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
    $(function () {
        $(".wh-article-list-d ul").find("li:gt(2)").hide();
        //页面加载完后，绑定点击事件
        showOrhideLi();
    });
    
    //显示\隐藏条数大于第三条的li
    function showOrhideLi(){
	    $('.wh-article-lists').children('i.fa').bind('click',function(){
	    	if($(this).hasClass('fa-chevron-down')){
		    	$(this).parent().find('li:gt(2)').show();
		    	$(this).addClass("fa-chevron-up").removeClass("fa-chevron-down");
	    	}else if($(this).hasClass('fa-chevron-up')){
		    	$(this).parent().find('li:gt(2)').hide();
		    	$(this).addClass("fa-chevron-down").removeClass("fa-chevron-up");
	    	}
	    });
    }
    
    //新建新流程
	function newezform(pageId,processId,processName){
		var personNum =$("#personNum").val();
		var startDate =$("#startDate").val();
		var sHour =$("#sHour").val();
		var sMinu =$("#sMinu").val();
		var endDate =$("#endDate").val();
	    var eHour =$("#eHour").val();
	    var eMinu =$("#eMinu").val();
		var meetRoomId =$("#meetRoomId").val();
        var meetRoomName =$("#meetRoomName").val();
		var isVideo =$("#isVideo").val();
		window.location = '/defaultroot/meeting/newEzmeetForm.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&personNum='+personNum+'&startDate='+startDate+'&sHour='+sHour+'&sMinu='+sMinu+'&endDate='+endDate+'&eHour='+eHour+'&eMinu='+eMinu+'&meetRoomId='+meetRoomId+'&meetRoomName='+meetRoomName+'&isVideo='+isVideo;
	}
</script>