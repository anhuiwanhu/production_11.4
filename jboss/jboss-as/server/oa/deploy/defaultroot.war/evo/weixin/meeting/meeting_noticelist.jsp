<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>会议通知</title>
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
        <div class="wh-article-lists">
            <div class="meeting-notice">
              <ul id="meetNoticeInfo">
                
              </ul>
            </div>
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
		var url = "meetingNoticeListData.controller?curpage=1";
		loadMeetNotice(url,0);
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
     function loadMeetNotice(loadUrl,loadFlag){
    	 //if(firstLoad){
	    	 //showLoding();
    	// }
    	 //firstLoad = false;		 
         $.ajax({
             type: 'post',
             url: loadUrl,
			 dataType:'text',
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
                 var status='';
				 var emceeName='';
                 var applyDate='';
				 var motif='';
				 var meetingDate='';
                 var createDate='';
				 var result='';
				 var statuName='';
				 var boardroomApplyId ='';
				 for(var i = 0; i < jsonData.data0.length; i++){
					status = jsonData.data0[i].status;
					emceeName = jsonData.data0[i].emceeName;
					emceeName = emceeName.substring(0,emceeName.length-1);
					applyDate = jsonData.data0[i].applyDate;
					applyDate = applyDate.split(" ")[0];
					motif = jsonData.data0[i].motif;
					meetingDate = jsonData.data0[i].meetingDate;
                    meetingDate = meetingDate.split(" ")[0];
					createDate = jsonData.data0[i].createDate;
					if(createDate == 'null'){
						createDate ="";
					}
					boardroomApplyId = jsonData.data0[i].boardroomApplyId;
					var cla ='';
                    if(status == '2'){
						statuName = '已参加';
						cla = 'forum-avatar m-tag-had';
					}else if(status == '1'){
						statuName = '不参加';
						cla = 'forum-avatar m-tag-not';
					}else{
					    statuName ='待参加';
						cla = 'forum-avatar m-tag-ny';
					} 
                    result  +='<li>'
						    +	  '<strong class="'+cla+'">'+statuName+'</strong>'
						    +  '<p>'
							+	'<a href="javascript:openNotice('+boardroomApplyId+')">'+emceeName+'在'+meetingDate+'召开的'+motif+'等待您的参与！</a>'
							+	'<span>'+createDate+'</span>'
							+  '</p>' 
							+ '</li>'

				 }
                 //查询数据为空时页面展示信息
                 if(jsonData.data0.length == 0){
                	 result = '<li><p><a>系统没有查询到相关记录！</a></p></li>';
                 }
                 $(".wh-load-md").css("display","none");
                 if(loadFlag == '1'){
	                 $('#meetNoticeInfo').append(result);
                 }else{
	                 $('#meetNoticeInfo').html(result);
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
    		loadMeetNotice('meetingNoticeListData.controller?curpage='+curPage,'1');
    	}
    }
    
	function  openNotice(val){		
		var detailUrl="/defaultroot/meeting/meetingNoticeDetail.controller";
		window.location = detailUrl+"?boardroomApplyId="+val;		
	}
	
</script>
</html>