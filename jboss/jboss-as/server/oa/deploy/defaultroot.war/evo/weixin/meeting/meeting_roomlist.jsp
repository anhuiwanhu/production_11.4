<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>会议室申请</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />

    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>

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
 
</head>
<body>

<section class="wh-section">
    <article class="wh-edit wh-edit-forum">
        <div class="wh-container">
		    <input type="hidden"  name="personNum" value="${personNum}" id="personNum"/>
		    <input type="hidden"  name="startDate" value="${startDate}" id="startDate"/>
			<input type="hidden"  name="sHour" value="${sHour}" id="sHour"/>
			<input type="hidden"  name="sMinu" value="${sMinu}" id="sMinu"/>
			<input type="hidden"  name="endDate" value="${endDate}" id="endDate"/>
		    <input type="hidden"  name="eHour" value="${eHour}" id="eHour"/>
		    <input type="hidden"  name="eMinu" value="${eMinu}" id="eMinu"/>
            <div class="meeting-room" id="meetRoomInfo">
               
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
<script type="text/javascript">
    var firstLoad = true;
	$(document).ready(function(){
		var url = "meetingRoomListData.controller?curpage=1";
		loadMeetRoom(url,0);
	})

	 var dialog = null;
     //数据加载提示
     function showLoding(){
         dialog = $.dialog({
             content:"数据加载中...",
             title: 'load'
         });
     }
     
     //是否有下一页 全局变量
     var nomore = "";
     //当前页页数 全局变量
     var curPage = "1";
     //ajax方式加载收/发件箱
     function loadMeetRoom(loadUrl,loadFlag){
    	 //if(firstLoad){
	    	 //showLoding();
    	// }
    	 //firstLoad = false;		 
	     var personNum =$("#personNum").val();
		 var startDate =$("#startDate").val();
		 var sHour =$("#sHour").val();
		 var sMinu =$("#sMinu").val();
		 var endDate =$("#endDate").val();
	     var eHour =$("#eHour").val();
	     var eMinu =$("#eMinu").val();
		 var result ='';
         $.ajax({
             type: 'post',
             url: loadUrl,
			 dataType:'text',
		     data : {"startDate" : startDate, "sHour" : sHour ,"sMinu" : sMinu, "endDate" : endDate,"eHour" : eHour,"eMinu" : eMinu,"personNum" : personNum},
             success: function(data){
        		 if(!data){
        			 return;
        		 }
        		 var jsonData = eval("("+data+")");
        		 if(!jsonData){
        			 return;
        		 }
        		 //是否有下一页标识
        		 nomore = jsonData.data1;
        		 if(nomore){
        			 $(".wh-load-box").css("display","block");
        		 }else{
        			 $(".wh-load-box").css("display","none");
        		 }
        		 //当前页
        		 curPage = jsonData.data2;
                 var boardroomId='';
				 var boardroomName='';
				 var locationArea='';
                 var capacitance='';
				 var isVideo='';
				 for(var i = 0; i < jsonData.data0.length; i++){
					boardroomId = jsonData.data0[i].boardroomId;
					boardroomName = jsonData.data0[i].boardroomName;
					locationArea = jsonData.data0[i].location;
					capacitance = jsonData.data0[i].capacitance;
					isVideo = jsonData.data0[i].isVideo;
                    result +=' <div class="meeting-list">'
                    +'<p class="list-tips">'+boardroomName+'</p>'
                    +'<p class="list-con">'
                    +   '<span>'+locationArea+'可容纳'+capacitance+'人</span><a href="javascript:apply('+boardroomId+','+isVideo+',\''+boardroomName+'\')"><em>预定<i></i></em></a>'
                    + '</p>'
                    +'</div>'
				 }
                 //查询数据为空时页面展示信息
                 if(jsonData.data0.length == 0){
                	 result = '<li><p><a>系统没有查询到相关记录！</a></p></li>';
                 }
                 $(".wh-load-md").css("display","none");
                 if(loadFlag == '1'){
	                 $('#meetRoomInfo').append(result);
                 }else{
	                 $('#meetRoomInfo').html(result);
                 }
                 if(dialog){
                	 dialog.close();
                 }
             },
             error: function(xhr, type){
                 alert('数据查询异常！');
             }
         });
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
    
    //加载下一页
    function loadNextPage(){
    	if(nomore == 'true'){
    		$(".wh-load-md").css("display","block");
    		loadMeetRoom('meetingRoomListData.controller?curpage='+curPage,'1');
    	}
    }

	function apply(mid,isVideo,mname){
		var personNum =$("#personNum").val();
		var startDate =$("#startDate").val();
		var sHour =$("#sHour").val();
		var sMinu =$("#sMinu").val();
		var endDate =$("#endDate").val();
	    var eHour =$("#eHour").val();
	    var eMinu =$("#eMinu").val();
		window.location = '/defaultroot/meeting/meetingWorkFlowList.controller?meetRoomId='+mid+'&meetRoomName='+mname+'&personNum='+personNum+'&startDate='+startDate+'&sHour='+sHour+'&sMinu='+sMinu+'&endDate='+endDate+'&eHour='+eHour+'&eMinu='+eMinu+'&isVideo='+isVideo;
	}
</script>
</html>