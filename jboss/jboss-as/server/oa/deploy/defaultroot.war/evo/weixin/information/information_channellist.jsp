<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>${empty channelName ? "信息栏目" : channelName}</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
</head>
<%
String flagChannelId = request.getParameter("channelId")==null?"":request.getParameter("channelId");
String flagChannelName = request.getParameter("channelName")==null?"":request.getParameter("channelName");
String title = request.getParameter("title")==null?"":request.getParameter("title");
%>
<body>
<section id="sectionScroll" class="wh-section wh-section-topstatic">
    <header class="wh-search">
        <div class="wh-container">
            <c:set var="flagChannelId"><%=flagChannelId%></c:set>
			<c:set var="flagChannelName"><%=flagChannelName%></c:set>
			<c:set var="title"><%=title%></c:set>
			<c:choose>  
  				   <c:when test="${flagChannelId ==''}">
						<form method="post" action="/defaultroot/information/allChannelList.controller" id="searchForm">
							<input type="hidden" name="searchChannel" value="${channelId}" id="channelId"/>
							<input type="search" placeholder="搜索栏目标题" name="channelName" value=""/>
							<i class="fa fa-search"></i>
						</form>
				   </c:when>  
				   <c:otherwise> 
						<form method="post" id="searchForm" onsubmit="searchTitle()">
							<input type="search" placeholder="搜索信息标题" name="title" value="${title}"  id="search_title"/>
							<i class="fa fa-search"></i>
						</form>
				   </c:otherwise>  
			</c:choose>  
        </div>
    </header>
    <aside class="wh-category wh-category-info">
        <div class="wh-container">
            <div class="wh-cate-lists">
                <ul>
                	<c:if test="${not empty docXml}">
                		<x:parse xml="${docXml}" var="doc" />
                		<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
						<c:if test="${recordCount==0}">
							<li>
		                        <p><strong>系统没有查询到栏目记录！</strong></p>
		                    </li>
						</c:if>
						<x:forEach select="$doc//informationChannel" var="n" varStatus="status">
							<c:set var="isView"><x:out select="$n/isView/text()" /></c:set>
							<c:set var="curChannelName"><x:out select="$n/channelName/text()" /></c:set>
							<c:set var="curChannelId"><x:out select="$n/channelId/text()"/></c:set>
							<c:set var="hasChildChannl"><x:out select="$n/hasChildChannl/text()"/></c:set>
							<c:set var="hasInfomation"><x:out select="$n/hasInfomation/text()"/></c:set>
							<c:set var="channelNeedCheckup"><x:out select="$n/channelNeedCheckup/text()"/></c:set>
							<c:if test="${isView != 0 }">
			                    <li>
			                    	<div class="wh-cate-libox wh-cate-libox-right">
				                        <a href="/defaultroot/information/channelList.controller?channelId=${curChannelId}&channelName=${curChannelName}">
				                            <i class="icon">${fn:substring(curChannelName,0,1)}</i>
				                            <p>
				                                <strong>${curChannelName}</strong>
				                                <c:if test="${hasChildChannl eq '1'}">
					                                <span>下级栏目</span>
				                                </c:if>
				                            </p>
				                        </a>
			                        </div>
			                    </li>
		                    </c:if>
	                    </x:forEach>
                    </c:if>
                </ul>
            </div>
        </div>
    </aside>
    <article class="wh-article wh-article-info">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul id="info_list" data-loadflag="0">
                </ul>
            </div>
        </div>
    </article>
    <aside class="wh-load-box" style="display: none">
        <div class="wh-load-tap">上滑加载更多</div>
        <div class="wh-load-md" style="display: none">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </aside>
</section>
<footer>
</footer>
</body>
</html>
<script type="text/javascript">
	var nomore = true;
	var pagerOffset = "0";
	var channelId = "";
	var title = "";
	var channelType = "0";
	var userDefine = "";
	function searchTitle(){
		 loadInfoList();
	}
	$(function(){
		channelId = "${channelId}";
		//title = $("#search_title").val();
		title = "${title}";
		if(channelId != "0"){
			loadInfoList();
		}
		//设置icon样式类
		setIconClass($('.icon'));
	});
	
     var dialog = null;
     //数据加载提示
     function showLoding(){
         dialog = $.dialog({
             content:"正在加载信息列表...",
             title: 'load'
         });
     }
	var firstLoad = true;
	//使用ajax方式加载当前栏目下的信息
	function loadInfoList(){
		var $infoList = $('#info_list');
		if($infoList.data('loadflag') == '1'){
			return;
		}
		$infoList.data('loadflag','1');
		if(nomore){
			if(firstLoad){
				showLoding();
			}
			firstLoad = false;
			$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : "/defaultroot/information/infoList.controller",
				type : "post",
				data : {"channelId" : channelId, "title" : title, "channelType" : channelType,"userDefine" : userDefine,"pagerOffset" : pagerOffset},
				success : function(data){
					nomore = $($(data)[32]).val();
					pagerOffset = $($(data)[30]).val();
					if(nomore){
						$(".wh-load-tap").html("上滑加载更多");
						$(".wh-load-box").css("display","block");
						$(".wh-load-md").css("display","none");
					}else{
						$(".wh-load-box").css("display","none");
					}
					var dataLi = $("li[name='content_li']",data);
					$infoList.append(dataLi);
					if(dataLi.length == 0){
						$infoList.append('<li name="content_li"><p><a>系统没有查询到信息记录！</a></p></li>');
					}
					//设置icon样式类
					setIconClass($("i[class=icon]"));
					$infoList.data('loadflag','0');
					if(dialog){
						dialog.close();
					}
				},
				error:function(data){
					$(".wh-load-tap").html("加载失败！");
				}
			});
		}
	}
	
	//打开详情页
	function openInfo(infoId,informationType,channelId){
		window.location="/defaultroot/information/infoDetail.controller?infoId="+infoId+"&informationType="+informationType+"&channelId="+channelId;
	}
	
	//滚动条至底部事触发事件
	$(window).scroll(function(){
	   var scrollTop = $(this).scrollTop();
	   var scrollHeight = $(document).height();
	   var windowHeight = $(this).height();
	   if(scrollTop + windowHeight == scrollHeight){
		 if(nomore && channelId != "0"){
			loadInfoList();
		 }
	  }
	});
</script>