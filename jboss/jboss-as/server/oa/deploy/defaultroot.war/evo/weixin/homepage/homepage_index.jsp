<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>移动办公应用门户中心</title>
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
<c:if test="${not empty docXml1}">
	<x:parse xml="${docXml1}" var="doc1"/>
	<c:set var="EmpName"><x:out select="$doc1//EmpName/text()" /></c:set>
	<c:set var="EmpDepart"><x:out select="$doc1//EmpDepart/text()" /></c:set>
	<c:set var="EmpLivingPhoto"><x:out select="$doc1//EmpLivingPhoto/text()" /></c:set>
	<c:set var="uId"><x:out select="$doc1//id/text()" /></c:set>
</c:if>
<section class="wh-section">
    <article class="wh-edit wh-edit-forum"> 
        <div class="wh-main-top">
            <div class="wh-main-img">  
            </div>  
            <div class="wh-mainimgcon">
                <div class="wh-container">
                    <a href="javascript:openPersonInfo('${uId}');"><img src="/defaultroot/upload/peopleinfo/${EmpLivingPhoto}" onerror="this.src='/defaultroot/evo/weixin/images/head.png'" /></a>
                    <p><span>${EmpName}</span></p>
                </div>
            </div>
        </div>
        <c:if test="${not empty docXml}">
       	 <x:parse xml="${docXml}" var="doc"/>
        	<c:set var="waitFile"><x:out select="$doc//waitFile/text()" /></c:set>
        	<c:set var="newMail"><x:out select="$doc//newMail/text()" /></c:set>
        	<c:set var="newInnerSendFile"><x:out select="$doc//newInnerSendFile/text()" /></c:set>
        </c:if>
        <div class="wh-container">
            <section class="wh-main-list">
                <ul class="clearfix">
                    <li class="wh-step"><a href="javascript:openWorkFlow('${waitFile}');"><i class="fa fa-share-alt"></i><c:if test="${not empty waitFile && '0' ne waitFile}"><em>${waitFile}</em></c:if></a><p>流程</p></li>
                    <li class="wh-file"><a href="javascript:openGov();"><i class="fa fa-briefcase"></i><c:if test="${not empty newInnerSendFile && '0' ne newInnerSendFile}"><em>${newInnerSendFile}</em></c:if></a><p>公文</p></li>
                    <li class="wh-info"><a href="javascript:openInfo();"><i class="fa fa-commenting"></i></a><p>信息</p></li>
                    <li class="wh-mail"><a href="javascript:openMail();"><i class="fa fa-envelope-o"></i><c:if test="${not empty newMail && '0' ne newMail}"><em>${newMail}</em></c:if></a><p>邮件</p></li>
                    <li class="wh-link"><a href="javascript:openPersons();"><i class="fa fa-user"></i></a><p>通讯录</p></li>
                    <li class="wh-forum"><a href="javascript:openForum();"><i class="fa fa-comments"></i></a><p>论坛</p></li>
                    <li class="wh-forum"><a href="javascript:openMeeting();"><i class="fa fa-comments"></i></a><p>会议</p></li>
                    <!--<li class="wh-add"><a href=""><i class="fa fa-plus"></i></a><p>订阅信息栏目</p></li>-->
                </ul>
            </section>
        </div>
    </article> 
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
	//打开公文页面
	function openGov(){
		window.location = "/defaultroot/doc/getReceiveFileBox.controller";
	}
	//打开信息页面
	function openInfo(){
		window.location = "/defaultroot/information/infoList.controller?homePage=1";
	}
	//打开通讯录页面
	function openPersons(){
		window.location = "/defaultroot/persons/personList.controller";
	}
	//打开邮件页面
	function openMail(){
		window.location = "/defaultroot/mail/mailBox.controller?homePage=1";
	}

	//打开论坛
	function openForum(){
		window.location = "/defaultroot/post/index.controller?homePage=1";
	}
	//打开联系人详情
	function openPersonInfo(id){
		window.location = "/defaultroot/persons/showPersonInfo.controller?personId="+id;
	}
	//打开流程主页
	function openWorkFlow(num){
		window.location = "/defaultroot/homePage/homepageWorkFlow.controller?numDBRecordCount="+num;
	}
	//打开会议
	function openMeeting(){
		window.location = "/defaultroot/meeting/meetingNoticeList.controller?homePage=1";
	}
	
</script>
