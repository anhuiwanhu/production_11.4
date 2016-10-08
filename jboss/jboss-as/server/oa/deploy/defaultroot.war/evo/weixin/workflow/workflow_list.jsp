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
	    <header class="wh-search">
	        <div class="wh-container">
	            <form id="sendForm" class="dialog" action="/defaultroot/workflow/listflow.controller" method="post">
	                <input type="search" placeholder="搜索流程标题" name="processName" value="${processName}" />
	                <i class="fa fa-search"></i>
	            </form>
	        </div>
	    </header>
	    <article class="wh-article wh-article-receive">
	        <div class="wh-container">
	        	<%
	        		int packageCount = 0;
	        	%>
			    <x:forEach select="$doc//package" var="n" varStatus="status" >
					<c:set var="processNum" ><x:out select="$n//processNum/text()" /></c:set>
					<c:set var="moduleId" ><x:out select="$n//moduleId/text()" /></c:set>
					<%
						packageCount ++;
					%>
		            <div class="wh-article-lists wh-article-list-d">
		                <h2><x:out select="$n//packageName/text()" /> ${processNum}条</h2>
		                <ul>
		                <x:forEach select="$n//process" var="ct" >
							<c:set var="processId" ><x:out select="$ct//pool_processId/text()" /></c:set>
							<c:set var="process_type" ><x:out select="$ct//pool_process_type/text()" /></c:set>
							<c:set var="oldprocess_id" ><x:out select="$ct//pool_oldprocess_id/text()" /></c:set>
							<c:set var="oldprocess_formid" ><x:out select="$ct//pool_oldprocess_formid/text()" /></c:set>
							<c:set var="ezflowprocess_id" ><x:out select="$ct//pool_ezflowprocess_defid/text()" /></c:set>
							<c:set var="ezflowprocess_formKey" ><x:out select="$ct//pool_ezflowprocess_formKey/text()" /></c:set>
							<c:set var="processName" ><x:out select="$ct//pool_processName/text()" /></c:set>
							<c:choose>
								<c:when test="${process_type == 0}">
			                    	<c:choose>
										<c:when test="${moduleId == 11}">
											<li onclick="newCarForm('${oldprocess_formid}','${oldprocess_id}','${processName}','${process_type }');">
										</c:when>
										<c:otherwise>
											<li onclick="newform('${oldprocess_formid}','${oldprocess_id}','${processName}');">
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:when test="${process_type == 1}">
				                   <c:choose>
										<c:when test="${moduleId == 11}">
											<li onclick="newCarEzForm('${ezflowprocess_formKey}','${ezflowprocess_id}','${processName}','${process_type }');">
										</c:when>
										<c:otherwise>
											<li onclick="newezform('${ezflowprocess_formKey}','${ezflowprocess_id}','${processName}');">
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<li>
								</c:otherwise>
							</c:choose>
		                        <strong class="flow-icon">
		                            <i class="fa fa-file-text"></i>
		                        </strong>
		                        <p>
									<a><x:out select="$ct//pool_processName/text()" /></a>
		                        </p>
		                    </li>
		                </x:forEach>
		                </ul>
		                <c:if test="${processNum >3}">
		                	<i class="fa fa-chevron-down"></i>
		                </c:if>
		            </div>
		        </x:forEach>
		        <c:set var="packageCount" ><%=packageCount%></c:set>
		        <c:if test="${packageCount eq 0}">
					<div class="wh-article-lists">
					   <ul id="content_ul">
							<li><p><a>系统没有查询到流程列表！</a></p></li>
					   </ul>
					</div>
		        </c:if>
	        </div>
	    </article>
	</section>
</c:if>
<c:if test="${selVoiture =='1'}">
	<script language="javascript" type="text/javascript">
		alert("没有可以使用的车辆!");
	</script>
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
    
    //新建老流程
    function newform(pageId,processId,processName){
		window.location = '/defaultroot/workflow/newform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	}

    //新建新流程
	function newezform(pageId,processId,processName){
		window.location = '/defaultroot/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	}

	//新建车辆老流程
    function newCarForm(pageId,processId,processName,process_type){
		window.location = '/defaultroot/workflow/getVoitureNewInfo.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&process_type='+process_type;
	}

    //新建车辆新流程
	function newCarEzForm(pageId,processId,processName,process_type){
		window.location = '/defaultroot/workflow/getVoitureNewInfo.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName+'&process_type='+process_type;
	}
</script>