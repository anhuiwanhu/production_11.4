<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<html>
  <head>
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no">
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
	<link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/ezcard.css">
	<title>我的申请</title>

  </head>
  
  <body class="sqzt">
  
	<ul class="sel">
		<c:choose>
			<c:when test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<c:set var="recordCount"><x:out select="$doc//recordcount/text()" /></c:set>
			<c:if test="${recordCount==0}">
				<li>
					<table cellpadding="0" cellpadding="0" border="0">
						<tr><td>系统没有查询到申购记录！</td></tr>
					</table>
				</li>
			</c:if>
			<x:forEach select="$doc//ezCardInfo" var="n">
			<c:set var="ezCardId" ><x:out select="$n/ezCardId/text()" /></c:set>
			<c:set var="ezCardUserId" ><x:out select="$n/ezCardUserId/text()" /></c:set>
			<c:set var="ezCardUserName" ><x:out select="$n/ezCardUserName/text()" /></c:set>
			<c:set var="ezCardOrgId" ><x:out select="$n/ezCardOrgId/text()" /></c:set>
			<c:set var="ezCardOrgName" ><x:out select="$n/ezCardOrgName/text()" /></c:set>
			<c:set var="ezCardDate" ><x:out select="$n/ezCardDate/text()" /></c:set>
			<c:set var="ezCardTemplateId" ><x:out select="$n/ezCardTemplateId/text()" /></c:set>
			<c:set var="ezCardTemplateName" ><x:out select="$n/ezCardTemplateName/text()" /></c:set>
			<c:set var="ezCardStatus" ><x:out select="$n/ezCardStatus/text()" /></c:set>
			<c:set var="ezCardStatusName" ><x:out select="$n/ezCardStatusName/text()" /></c:set>
			<c:set var="ezCardNum" ><x:out select="$n/ezCardNum/text()" /></c:set>	
			<c:set var="ezCardAddress" ><x:out select="$n/ezCardAddress/text()" /></c:set>
			<c:set var="oaflowId" ><x:out select="$n/oaflowId/text()" /></c:set>
			<a href="javascript:status(${oaflowId },${ezCardStatus });">
				<li>
					<table cellpadding="0" cellpadding="0" border="0">
						<tr>
							<td width="90%">
								<div class="name">${ezCardUserName }</div><div class="tel">${ezCardNum }盒</div>
								<div class="adr">${ezCardAddress }</div>
							</td>
							<td width="10%"><div class="line">${ezCardStatusName }</div></td>
						</tr>
					</table>
				</li>
			</a>
			</x:forEach>
				<div id="pageList">
					
				</div>
			</c:when>
			<c:otherwise>
				<table cellpadding="0" cellpadding="0" border="0">
					<tr><td>数据查询异常！</td></tr>
				</table>
			</c:otherwise>
		</c:choose>
	</ul>
	
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
</body>
<input type="hidden" value="${offset}" id="offset"/>
<input type="hidden" value="${nomore}" id="nomore"/>
<input type="hidden" value="${appId}" id="appId"/>
</html>

<script src="/defaultroot/evo/weixin/template/js/jquery-1.12.3.min.js"></script>
<script src="/defaultroot/evo/weixin/template/js/js.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
<script type="text/javascript">
	
	//是否有下一页标识
	var nomore = '';
	//页面偏移量
	var offset = '';
	//客户唯一标识
	var appId = '';
	//加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatus = '0';
	
	$(function(){
		nomore = $("#nomore").val();
		offset = $("#offset").val();
		if(nomore){
			$(".wh-load-box").css("display","block");
		}else{
			$(".wh-load-box").css("display","none");
		}
	});
	
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
    	if(loadStatus == '1'){
    		return;
    	}
    	loadStatus = '1';
    	if(nomore){
    		var nextPageUrl = "/defaultroot/ezcard/nextPageList.controller?offset="+offset;
    		$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
			$.ajax({
				url : nextPageUrl,
				type : "post",
				dataType: 'text',
				success : function(data){
					if(!data){
                		return;
                	}
                	var jsonData = eval("("+data+")");
                	if(!jsonData){
                		return;
                	}
                	var listData = jsonData.data0;
                	if(!listData){
                		return;
                	}
                	var addDom = '';
                	offset = jsonData.data2;
                	for(var i=0;i<listData.length;i++){
                		addDom+='<a href="javascript:status('+listData[i].oaflowId+','+listData[i].ezCardStatus+');"><li><table cellpadding="0" cellpadding="0" border="0"><tr><td width="90%"><div class="name">'+listData[i].ezCardUserName+'</div><div class="tel">'+listData[i].ezCardNum+'盒</div><div class="adr">'+listData[i].ezCardAddress+'</div></td><td width="10%"><div class="line">'+listData[i].ezCardStatusName+'</div></td></tr></table></li></a>';
                	}
                	$('#pageList').append(addDom);
                	//是否有下一页标识
                	nomore = jsonData.data1;
                	if(nomore){
        				$(".wh-load-box").css("display","block");
       		 		}else{
       					$(".wh-load-box").css("display","none");
       		 		}
               		$(".wh-load-md").css("display","none");
                	//将加载状态重置为0
                	loadStatus = '0'; 	
				},
				error:function(data){
					$(".wh-load-box").html("加载失败");
				}
			});
    	}
    }
    
    //订单状态显示跳转页面
    function status(oaflowId,ezCardStatus){
    	appId=$("#appId").val();
    	if(ezCardStatus=='2'){//已订购
    		window.location="http://demo.namex.cn:4005/OA/Moblie/FlowOrder.aspx?appId="+appId+"&oaflowIds="+oaflowId;
    	}else{//办理中和办理完毕
    		window.location="http://demo.namex.cn:4005/OA/Moblie/GetEmployeeCardPicture.aspx?appId="+appId+"&oaflowId="+oaflowId;
    	}
    }
    
    
</script>


