<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%
String numDBRecordCount = request.getParameter("numDBRecordCount")==null?"":request.getParameter("numDBRecordCount");
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>流程主页</title>
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

<section class="wh-section">
    <div class="wh-stepmain-tips ">
        <div class="wh-container">
            <ul class="clearfix">
                <li class="wh-step-overfile">
                	<c:set var="numDBRecordCount" ><%=numDBRecordCount %></c:set>
                    <a href="javascript:openDealFileList('0');"><span>${numDBRecordCount}件</span></a><p>待办文件</p>
                </li>
                <li class="wh-step-prefile">
                    <a href="javascript:openDealFileList('101');"><span>${numYBRecordCount}件</span></a><p>已办文件</p>
                </li>
                <li class="wh-step-myfile">
                    <a href="javascript:openDealFileList('1100');"><span>${numWDRecordCount}件</span></a><p>我的文件</p>
                </li>
            </ul>
        </div>
    </div>
    <div class="wh-stepmain-stepmore clearfix"> 
        <div class="wh-container">
            <h3>我的常用流程</h3>
            <a href="javascript:openlistsFlow()">更多</a> 
        </div>
    </div>
    <c:if test="${not empty docXml}">
    <x:parse xml="${docXml}" var="doc"/>
    <div class="wh-article-lists wh-stepmain-list">
        <div class="wh-container">
            <ul>
            <x:forEach select="$doc//process" var="ct" >
            	<c:set var="processnum" ><x:out select="$ct//processnum/text()" /></c:set>
            	<c:set var="processId" ><x:out select="$ct//pool_processId/text()" /></c:set>
            	<c:set var="processName" ><x:out select="$ct//pool_processName/text()" /></c:set>
				<c:set var="process_type" ><x:out select="$ct//pool_process_type/text()" /></c:set>
				<c:set var="oldprocess_id" ><x:out select="$ct//pool_oldprocess_id/text()" /></c:set>
				<c:set var="oldprocess_formid" ><x:out select="$ct//pool_oldprocess_formid/text()" /></c:set>
				<c:set var="ezflowprocess_formKey" ><x:out select="$ct//pool_ezflowprocess_formKey/text()" /></c:set>
                <c:set var="ezflowprocess_id" ><x:out select="$ct//pool_ezflowprocess_defid/text()" /></c:set>
                <c:choose>
					<c:when test="${process_type == 0}">
                    	<li onclick="newform('${oldprocess_formid}','${oldprocess_id}','${processName}');">
					</c:when>
					<c:when test="${process_type == 1}">
	                    <li onclick="newezform('${ezflowprocess_formKey}','${ezflowprocess_id}','${processName}');">
					</c:when>
					<c:otherwise>
						<li>
					</c:otherwise>
				</c:choose>
                <strong class="step-icon"><i class="fa fa-file-text"></i></strong>
                <a>
                 <p>
					<x:out select="$ct//pool_processName/text()" />
                </p>
                <span>已发起<x:out select="$ct//processnum/text()" />次</span>
                </a>
            </li>
           	</x:forEach>
            </ul>
        </div>
    </div>
  	</c:if>
</section>

</body>
</html>
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
<script type="text/javascript">
	//新建老流程
	function newform(pageId,processId,processName){
		window.location = '/defaultroot/workflow/newform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	}
	
	//新建新流程
	function newezform(pageId,processId,processName){
		window.location = '/defaultroot/workflow/newezform.controller?pageId='+pageId+'&processId='+processId+'&processName='+processName;
	}
	
	//打开发送流程列表
	function openlistsFlow(){
		window.location = '/defaultroot/workflow/listflow.controller';
	}

	//打开流程列表
	function openDealFileList(workStatus){
		window.location = '/defaultroot/dealfile/list.controller?workStatus='+workStatus;
	}
</script>