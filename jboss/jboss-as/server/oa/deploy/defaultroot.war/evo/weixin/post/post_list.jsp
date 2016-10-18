<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>帖子列表</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
</head>
<body>
<section id="sectionScroll" class="wh-section wh-section-topstatic">
    <header class="wh-search">
        <div class="wh-container">
            <form method="post" action="/defaultroot/post/index.controller" id="searchForm">
                <input type="search" placeholder="搜索帖子标题" name="queryTitle" value="${queryTitle}" id="search_title"/>
                <input type="text" style="display: none;"/>
                <i class="fa fa-search"></i>
            </form>
        </div>
    </header>
    <article class="wh-category wh-category-forum">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul id="wh-ul-list" data-loadflag="0">
	                <c:choose>
						<c:when test="${not empty docXml}">
							<x:parse xml="${docXml}" var="doc"/>				
							<c:set var="recordCount"><x:out select="$doc//recordCount/text()" /></c:set>
							<c:if test="${recordCount==0}">
								<li><p><a>系统没有查询到帖子记录！</a></p></li>
							</c:if>
							<%
							String empLivingPhoto = "";
							String photoPath = "";
							String anonymous = "";
							String authName = "";
							String nickName = "";
							String forumAuthor = "";
							%>
							<x:forEach select="$doc//list" var="n"  varStatus="status">
								<c:set var="time" ><x:out select="$n/forumIssueTime/text()"/></c:set>
								<c:if test="${fn:indexOf(time,'.') > 0}">
									<c:set var="time" >${fn:substringBefore(time,".")}</c:set>
								</c:if>
								<c:set var="forumKits" ><x:out select="$n/forumKits/text()"/></c:set>
								<c:set var="forumRevertNum" ><x:out select="$n/forumRevertNum/text()"/></c:set>
								<c:set var="forumTitle" ><x:out select="$n/forumTitle/text()"/></c:set>
								<c:set var="postId" ><x:out select="$n/id/text()"/></c:set>
								<c:set var="classParentName" ><x:out select="$n/classParentName/text()"/></c:set>
								<c:set var="forumAuthor" ><x:out select="$n/forumAuthor/text()"/></c:set>
								<c:set var="curClassId" ><x:out select="$n/classid/text()"/></c:set>
								<c:set var="empLivingPhoto" ><x:out select="$n/empLivingPhoto/text()"/></c:set>
								<c:set var="anonymous" ><x:out select="$n/anonymous/text()"/></c:set>
								<c:set var="nickName" ><x:out select="$n/nickName/text()"/></c:set>
								<%  
									empLivingPhoto = pageContext.getAttribute("empLivingPhoto").toString();
								 	nickName = pageContext.getAttribute("nickName").toString();
								 	forumAuthor = pageContext.getAttribute("forumAuthor").toString();
									photoPath = "";
									if(null != empLivingPhoto && !empLivingPhoto.equals("") && !"null".equals(empLivingPhoto)){
										photoPath = "/defaultroot/upload/peopleinfo/"+empLivingPhoto.split("\\.")[0]+"_small."+empLivingPhoto.split("\\.")[1];
									}else{
										photoPath = "/defaultroot/evo/weixin/images/head.png";
									}
									anonymous = pageContext.getAttribute("anonymous").toString();
									if("1".equals(anonymous)) {
										authName = "匿名";
										photoPath = "/defaultroot/evo/weixin/images/head.png";
									}else if("0".equals(anonymous)) {
										authName = forumAuthor;
									}else if("2".equals(anonymous)) {
										authName = nickName;
									} 
								%>
								<li onclick="openForum('${postId}','${curClassId}');">
	                        		<!-- TODO 头像待接口提供  -->
			                        <strong class="forum-avatar">
			                        	<img src='<%=photoPath%>'/>
			                           
			                        </strong>
			                        <p>
			                            <a><%=authName %>&nbsp;&nbsp;${forumTitle}</a>
			                            <span>&nbsp;${fn:substring(time,0,16)}</span>
			                        </p>
			                        <em <c:if test="${forumRevertNum eq '0'}">class="rate-zero"</c:if>>${forumRevertNum}</em>
			                    </li>
		                    </x:forEach>
						</c:when>
						<c:otherwise>
							<li><p><a>数据查询异常！</a></p></li>
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
</body>
<input type="hidden" value="${offset}" id="offset"/>
<input type="hidden" value="${nomore}" id="nomore"/>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
	var nomore = "";
	var offset = "";
	$(function(){
		nomore = $("#nomore").val();
		offset = $("#offset").val();
		if(nomore){
			$(".wh-load-box").css("display","block");
		}else{
			$(".wh-load-box").css("display","none");
		}
	});

	//打开帖子详细页面
	function openForum(postId,curClassId){
		window.location = "/defaultroot/post/info.controller?postId="+postId+"&curClassId="+curClassId;
	}

	//滚动条至底部事触发事件
    $(window).scroll(function(){
       var scrollTop = $(this).scrollTop();
       var scrollHeight = $(document).height();
       var windowHeight = $(this).height();
       if(scrollTop + windowHeight == scrollHeight){
      	 loadNextPage();
       }
    });

	//加载下一页内容
	function loadNextPage(){
		var $ulList = $('#wh-ul-list');
		if($ulList.data('loadflag') == '1'){
			return;
		}
		$ulList.data('loadflag','1');
		if(nomore){
			var classId = "${classId}";
			var nextPageUrl = "/defaultroot/post/pagelist.controller?pageSize="+offset+"&classId="+classId;
			$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : nextPageUrl,
				type : "post",
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
					$("#wh-ul-list").append($("li",data));
					$ulList.data('loadflag','0');
				},
				error:function(data){
					$(".wh-load-box").html("加载失败");
				}
			});
		}
	}
	    
	//绑定查询框回车事件
    $('#search_title').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			if(/[@#\$%\^&\*]+/g.test($('#search_title').val())){
				alert('请正确填写搜索帖子标题！');
				return false;
			}
			$('#searchForm').submit();
		} 
	});
</script>


