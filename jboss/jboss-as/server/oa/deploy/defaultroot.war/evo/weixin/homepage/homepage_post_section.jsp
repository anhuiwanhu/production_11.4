<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
	<head lang="en">
	    <meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
	    <title>论坛主页</title>
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
	</head>
	<body>
	<header class="wh-header">
	    <div class="wh-wrapper">
	        <div class="wh-container">
	            <div id="headerBtn" class="wh-header-btn">
	                <a href="#"><span>最近更新</span></a>
	                <a href="#" class="active"><span>论坛版块</span></a>
	            </div>
	        </div>
	    </div>
	</header>
	<section id="sectionScroll" class="wh-section wh-section-topfixed wh-section-bottomfixed">
	    <header class="wh-search">
	        <div class="wh-container">
	            <form method="post" action="/defaultroot/post/index.controller" id="searchForm">
	                <input type="search" placeholder="搜索帖子标题" name="queryTitle" id="search_title"/>
	                <input type="hidden" name="classId" value="${param.classId}"/>
	                <input type="text" style="display: none"/>
	                <i class="fa fa-search"></i>
	            </form>
	        </div>
    	</header>
	    <aside class="wh-category wh-category-forum">
	        <div class="wh-container">
	            <div class="wh-cate-lists">
	                <ul>
	                	<c:if test="${not empty docXml}">
	                		<x:parse xml="${docXml}" var="doc" />
							<x:forEach select="$doc//list" var="n" varStatus="status">
							<c:set var="className"><x:out select="$n/className/text()" /></c:set>
							<c:set var="id"><x:out select="$n/id/text()"/></c:set>
							<c:set var="hasForumCount"><x:out select="$n/hasForumCount/text()"/></c:set>
							<c:set var="classHasJunior"><x:out select="$n/classHasJunior/text()"/></c:set>
							<c:set var="haveRightFlag"><x:out select="$n/haveRightFlag/text()"/></c:set>

								<c:if test="${haveRightFlag eq '1' || classHasJunior eq '1' }">
			                    <li>
									<c:choose>
										<c:when test="${hasForumCount ne '0' || classHasJunior ne '0'}">
				                    		<div class="wh-cate-libox wh-cate-libox-right">
					                        	<a href="javascript:openForumSection('${id}','${className}','${haveRightFlag}');">
										</c:when>
										<c:when test="${hasForumCount eq '0' && classHasJunior eq '0'}">
				                    		<div class="wh-cate-libox wh-cate-libox-empty">
												<a>
										</c:when>
									</c:choose>
			                            <i class="icon">${fn:substring(className,0,1)}</i>
			                            <p>
			                                <strong>${className}</strong>
			                                <c:choose>
												<c:when test="${classHasJunior eq '0'}">
													
												</c:when>
												<c:otherwise>
													<span>下级版块</span>
												</c:otherwise>
											</c:choose>
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
	    <article class="wh-article wh-article-forum">
	        <div class="wh-container">
	            <div class="wh-article-lists">
	                <ul id="forum_list">
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
	<footer class="wh-footer wh-footer-forum">
	    <div class="wh-wrapper">
	        <div class="wh-container">
	            <div class="wh-footer-btn">
	                <a href="javascript:createForum();" class="fbtn-matter col-xs-12">发布帖子</a>
	            </div>
	        </div>
	    </div>
	</footer>
	</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script type="text/javascript">
var headerBtn = $("#headerBtn a");
headerBtn.click(function(){
	var index = $(this).index();
    headerBtn.eq(index).addClass("active").siblings().removeClass("active");
    if(index==0){ 
    	window.location = "/defaultroot/post/index.controller?homePage=1";
    }
    if(index==1){ 
    	window.location = "/defaultroot/post/list.controller?homePage=1";
    }
});
	var nomore = true;
	var classId = "";
	var offset = "1";
	$(function(){
		classId = "${classId}";
		title = $("#search_title").val();
		if(classId != "0"){
			loadForumList();
		}
		//设置icon样式类
		setIconClass($('.icon'));
	});
	
	var loadFlag = '0';
	//加载指定版块下的帖子列表
	function loadForumList(){
		if(loadFlag == '1'){
			return false;
		}
		loadFlag = '1';
		if('1' != '${param.haveRightFlag}'){
			//$("#forum_list").append('<li>您暂无该版块下帖子的查看权限！</li>');
			//return false;
		}
		if(nomore){
			$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : "/defaultroot/post/pagelist.controller",
				type : "post",
				data : {"classId" : classId, "pageSize" : offset},
				success : function(data){
					nomore = $($(data)[26]).val();
					offset = $($(data)[24]).val();
					if(nomore){
						$(".wh-load-tap").html("上滑加载更多");
						$(".wh-load-box").css("display","block");
						$(".wh-load-md").css("display","none");
					}else{
						$(".wh-load-box").css("display","none");
					}
					$("#forum_list").append($("li",data));
					//设置icon样式类
					setIconClass($("i[class=icon]"));
					loadFlag = '0';
				},
				error:function(data){
					$(".wh-load-tap").html("加载失败");
				}
			});
		}
	}
		
	//滚动条至底部事触发事件
	$(window).scroll(function(){
	   var scrollTop = $(this).scrollTop();
	   var scrollHeight = $(document).height();
	   var windowHeight = $(this).height();
	   if(scrollTop + windowHeight == scrollHeight){
		 if(nomore && classId != "0"){
			loadForumList();
		 }
	  }
	});
	
	//打开指定板块的帖子列表
	function openForumSection(classId, className, haveRightFlag) {
		window.location = "/defaultroot/post/list.controller?classId=" + classId + "&className=" + className + "&haveRightFlag=" + haveRightFlag;
	}
	
	//打开帖子详细页面
	function openForum(postId,curClassId){
		window.location = "/defaultroot/post/info.controller?postId="+postId+"&curClassId="+curClassId;
	}
	
	//绑定查询框回车事件
    $('#search_title').keydown(function(event){
    	var searchTitle = $('#search_title').val();
		if(event.keyCode == 13){ //绑定回车 
  			if(/[@#\$%\^&\*]+/g.test(searchTitle) || (!searchTitle.trim() && searchTitle.length>0)){
				alert('请正确填写搜索帖子标题！');
				return false;
			}
			$('#searchForm').submit();
		} 
	});
    //打开新建信息
	function createForum(){
		window.location = "/defaultroot/post/new.controller?homePage=1";
	}
</script>
