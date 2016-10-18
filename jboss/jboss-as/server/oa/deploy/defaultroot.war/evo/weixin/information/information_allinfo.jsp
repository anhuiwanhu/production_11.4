<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>
    	${channelName}
	</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
</head>
<body>
<header class="wh-header" id="header_content">
	<div class="wh-wrapper">
	    <div class="wh-hd-op-left"></div>
	    <div class="wh-container">
	        <nav class="wh-info-nav">
	            <ul class="wh-i-n-default swiper-wrapper">
	                <li class="col-xs-3 swiper-slide" data-checkbox="check" channelType="1" userDefine="" channelName="全部信息" userChannelId="">
	                	<span>全部</span><em><i class="fa fa-check-circle"></i></em>
	                </li>
	                <li id="portal" class="col-xs-3 swiper-slide" data-checkbox="uncheck" channelType="1" userDefine="0" channelName="单位主页" userChannelId="">
	                	<span>单位主页</span><em><i class="fa fa-check-circle"></i></em>
	                </li>
	                <li id="infomation" class="col-xs-3 swiper-slide" data-checkbox="uncheck" channelType="0" userDefine="0" channelName="信息管理" userChannelId="">
	                	<span>信息管理</span><em><i class="fa fa-check-circle"></i></em>
	                </li>
	                <c:if test="${not empty docXml1}">
						<x:parse xml="${docXml1}" var="doc1"/>
						<x:forEach select="$doc1//userChannel" var="n" varStatus="status">
						<c:set var="uChannelId" ><x:out select="$n/userChannelId/text()"/></c:set> 
						<c:set var="uChannelName" ><x:out select="$n/userChannelName/text()"/></c:set>
						<li id="defined_${uChannelId}" class="col-xs-3 swiper-slide" data-checkbox="uncheck" channelType="1" userDefine="1" channelName="${uChannelName}" userChannelId="${uChannelId}">
	                		<c:if test="${fn:length(uChannelName)>4}">
	                		     <span>${fn:substring(uChannelName,0,3)}...</span>
	                		</c:if>
	                		<c:if test="${fn:length(uChannelName)<=4}">
	                		     <span>${uChannelName}</span>
	                		</c:if>
	                		<em><i class="fa fa-check-circle"></i></em>
	                	</li>
						</x:forEach>	
					</c:if>
	            </ul>
	        </nav>
	    </div>
	    <div class="wh-hd-op-right"></div>
    </div>
</header>
<section class="wh-section wh-section-topfixed" id="list_content">
    <header class="wh-search">
        <div class="wh-container">
            <form id="searchForm" action="/defaultroot/information/infoList.controller" method="post">
            	<input type="hidden" name="channelType" value="${channelType}" id="channelType"/>
				<input type="hidden" name="userDefine" value="${userDefine}" id="userDefine"/>
				<input type="hidden" name="channelName" value="${channelName}" id="channelName"/>
				<input type="hidden" name="userChannelId" value="${userChannelId}" id="userChannelId"/>
                <input type="search" placeholder="搜索信息标题" id="search_title" name="title" value="${title}" />
                <i class="fa fa-search"></i>
            </form>
        </div>
    </header>
    <article class="wh-article-info">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul id="content_ul">
	               	<c:choose>
					  	<c:when test="${not empty docXml}">
							<x:parse xml="${docXml}" var="doc"/>
							<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
							<c:if test="${recordCount==0}">
								<li>
			                        <a>系统没有查询到信息记录！</a>
			                    </li>
							</c:if>
							<x:forEach select="$doc//infoList" var="n" varStatus="status">
								<c:set var="currTitle" ><x:out select="$n/informationTitle/text()"/></c:set>   
								<c:set var="time" ><x:out select="$n/informationIssueTime/text()"/></c:set>
								<c:set var="infoId" ><x:out select="$n/informationId/text()"/></c:set>
								<c:set var="informationType" ><x:out select="$n/informationType/text()"/></c:set>
								<c:set var="informationKits" ><x:out select="$n/informationKits/text()"/></c:set>
								<c:set var="currChannelId" ><x:out select="$n/channelId/text()"/></c:set>
								<li onclick="openInfo('${infoId}','${informationType}','${currChannelId}')" name="content_li">
			                        <p>
				                        <a>${currTitle}</a>
				                        <span>${fn:substring(time,0,16)}</span>
			                        </p>
									<c:if test="${informationKits==0}">
			                        <em style="background-color:grey"><x:out select="$n/informationKits/text()"/></em>
									</c:if>
									<c:if test="${informationKits>0}">
			                        <em ><x:out select="$n/informationKits/text()"/></em>
									</c:if>
			                    </li>
							</x:forEach>
						</c:when>
						<c:otherwise>
							<li>
	                        	<a>数据查询异常！</a>
		                    </li>
						</c:otherwise>
					</c:choose>
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
<input type="hidden" value="${pagerOffset}" id="pagerOffset"/>
<input type="hidden" value="${nomore}" id="nomore"/>
<input type="hidden" value="${channelType}" id="channelType"/>
<input type="hidden" value="${userDefine}" id="userDefine"/>
<input type="hidden" value="${channelName}" id="channelName"/>
<input type="hidden" value="${userChannelId}" id="userChannelId"/>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
   	var nomore = $("#nomore").val();
	var pagerOffset = $("#pagerOffset").val();
	var channelId = "${channelId}";
	var title = "${title}";
	var channelType = "${channelType}";
	var userDefine = "${userDefine}";
	var userChannelId = "${userChannelId}";
    $(function () {
        //水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 4,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
        //判断是否显示下拉加载区域
        if(nomore){
			$(".wh-load-box").show();
		}else{
			$(".wh-load-box").css("display","none");
		}
        //页面加载完后标记按钮样式
        signButt();
        //绑定头部按钮点击事件
		$(".col-xs-3").bind("click",function(){
			$("#channelType").val($(this).attr("channelType"));
			$("#userDefine").val($(this).attr("userDefine"));
			$("#channelName").val($(this).attr("channelName"));
			$("#userChannelId").val($(this).attr("userChannelId"));
			$("#search_title").val("");
			$("#searchForm").submit();
		});
        addScrollEvent();
    });
    
   	//标记按钮样式
	function signButt(){
		var infoNav = $('.wh-info-nav');
       	var infoNavli = $('.wh-info-nav .wh-i-n-default li');
		if(userDefine == ""){
			infoNavli.eq(0).addClass('nav-active');
        	infoNavli.first().children("em").show().css("display","block");
		}else if(channelType == "0" && userDefine == "0"){
			$("#infomation").addClass('nav-active');
        	$("#infomation").children("em").show().css("display","block");
		}else if(channelType == "1" && userDefine == "0"){
			$("#portal").addClass('nav-active');
        	$("#portal").children("em").show().css("display","block");
		}else if(channelType == "1" && userDefine == "1"){
			$("#defined_"+userChannelId).addClass('nav-active');
        	$("#defined_"+userChannelId).children("em").show().css("display","block");
		}
	}
   	
	//滚动条至底部事触发事件
	function addScrollEvent(){
	    $(window).scroll(function(){
	       var scrollTop = $(this).scrollTop();
	       var scrollHeight = $(document).height();
	       var windowHeight = $(this).height();
	       if(scrollTop + windowHeight == scrollHeight){
	      	 loadNextPage();
	       }
	    });
	}
	
 	//加载下一页内容
 	var loadFlag = '0';
	function loadNextPage(){
		if(loadFlag == '1'){
			return false;
		}
		loadFlag = '1';
		if(nomore){
	   	    $(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : "/defaultroot/information/infoList.controller",
				type : "post",
				data : {"channelId" : channelId, "title" : title ,"pagerOffset" : pagerOffset, "channelType" : channelType,"userDefine" : userDefine,"userChannelId" : userChannelId},
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
					$("#content_ul").append($("li[name='content_li']",data));
					loadFlag = '0';
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
	    
    //绑定查询框回车事件
    $('#search_title').keydown(function(event){
    	var searchTitle = $('#search_title').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				alert('请正确填写搜索信息标题！');
				return false;
			}
			$('#searchForm').submit();
		} 
	});
	   
    //input输入时，顶部fixed错位
	$('#search_title').bind('focus',function(){
	    $('#header_content').css('position','static');
	    $("#list_content").css('padding-top',0);
	}).bind('blur',function(){
	    $('#header_content').css('position','fixed');
	    $("#list_content").removeAttr("style");
	});
</script>
