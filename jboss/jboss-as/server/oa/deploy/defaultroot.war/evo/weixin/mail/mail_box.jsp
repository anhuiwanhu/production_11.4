<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>我的邮箱</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
	<header class="wh-header" id="header_content">
	    <div class="wh-wrapper">
	        <div class="wh-container">
	            <div id="headerBtn" class="wh-header-btn">
	                <a href="#" class="active"><span>收件箱</span><c:if test="${not empty newMailCount && '0' ne newMailCount}"><em>${newMailCount}</em></c:if></a>
	                <a href="#"><span>发件箱</span></a>
	            </div>
	        </div>
	    </div>
	</header>
	<section id="sectionScroll" class="wh-section wh-section-topfixed">
	    <header class="wh-search">
	        <div class="wh-container">
	       	 	<form>
	                <input type="search" placeholder="搜索邮件标题" id="searchTitle" value="${param.subject}"/>
	                <input type="text" style="display: none" />
	                <i class="fa fa-search"></i>
                </form>
	        </div>
	    </header>
	    <article class="wh-article wh-article-mail">
	        <div class="wh-container">
	            <div class="wh-article-lists">
	                <ul>
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
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/ajax.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
	//区分收信和发信链接
	 var urlType = "";
	 var detailUrl = "";
	 var detailType = 'receive';
	 var firstLoad = true;
     $(function () {
         var cateListCK = $('div[name=cateListChek] i.fa-check-circle');
         cateListCK.tap(function(){
             cateListCK.not(this).removeClass('fa-check-circle-active');
             $(this).addClass('fa-check-circle-active');
         });
         var headerBtn = $("#headerBtn a");
         //加载邮件列表
         urlType = "receiveBox.controller";
         detailUrl = 'receiveMailDetail.controller';
         var url = "receiveBox.controller?curpage=1";
         loadMailBox(url);
         headerBtn.click(function(){
        	 $("#searchTitle").val("");
             var index = $(this).index();
             if(index == 0){
            	 urlType = 'receiveBox.controller';
            	 url = 'receiveBox.controller?curpage=1';
            	 //收信列表打开详情
            	 detailUrl = 'receiveMailDetail.controller';
            	 detailType = 'receive';
            	 firstLoad = true;
             }else if(index == 1){
            	 urlType = 'sendBox.controller';
            	 url = 'sendBox.controller?curpage=1';
            	 detailUrl = 'receiveMailDetail.controller';
            	 detailType = 'send';
            	 firstLoad = true;
             }
             headerBtn.eq(index).addClass("active").siblings().removeClass("active");
             loadMailBox(url);
         })
     });

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
     function loadMailBox(loadUrl,loadFlag){
    	 if(firstLoad){
	    	 showLoding();
    	 }
    	 firstLoad = false;
    	 var searchTitle = $("#searchTitle").val();
    	 if(searchTitle){
    		 loadUrl = loadUrl + "&subject=" + searchTitle;
    	 }
         $.ajax({
             type: 'post',
             url: loadUrl,
             dataType: 'text',
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
        		 var mailPostTime = '';
        		 var notRead = '';
                 var result = '';
                 var readFlag = '';
                 var mailId = '';
                 var mailUserId = '';
                 var attachmentName = '';
                 var empPhotoSrc = '';
                 var boxFlag = jsonData.data3;
                 var mailName = '';
                 for(var i = 0; i < jsonData.data0.length; i++){
                	 mailPostTime = jsonData.data0[i].mailposttime.substring(0,16);
                	 notRead = jsonData.data0[i].NotRead;
                	 mailId = jsonData.data0[i].mailid;
                	 mailUserId = jsonData.data0[i].mailuserid;
                	 cloudcontrol = jsonData.data0[i].cloudcontrol;
                	 if(!jsonData.data0[i].empLivingPhoto || jsonData.data0[i].empLivingPhoto == 'null'){
                		 empPhotoSrc = '/defaultroot/evo/weixin/images/head.png';
                	 }else{
                		 empPhotoSrc = '/defaultroot/upload/peopleinfo/'+jsonData.data0[i].empLivingPhoto;
                	 }
                	 if(jsonData.data0[i].accessorySize > 0){
                		 attachmentName = '<img src="/defaultroot/evo/weixin/images/fj2.gif"/>';//<em class="blue">附件</em>';
                	 }else{
                		 attachmentName = '';
                	 }
                	 if(notRead == '1'){
                		 readFlag = '<em class="orange">未读</em>';
                	 }else{
                		 readFlag = '';
                	 }
                	 if(boxFlag == '0'){
                	 	mailName = jsonData.data0[i].mailto;
                	 	mailName = mailName.substring(0,mailName.length-1);
                	 	if(mailName.length>15){
                	 		mailName = mailName.substring(0,15);
                	 		if(mailName.substring(14,15)==','){
                	 			mailName = mailName.substring(0,14)+'...'
                	 		}else{
                	 			mailName = mailName + '...';
                	 		}
                	 	}
                	 }else{
                	 	mailName = jsonData.data0[i].mailpostername;
                	 }
                     result +='<li onclick="openDetail('+mailId+','+mailUserId+',\''+detailType+'\',\''+cloudcontrol+'\');">'
                     +'<strong class="forum-avatar" valign="middle">'
                     +'<img src="'+empPhotoSrc+'"/>'
                    // +'<span>'+jsonData.data0[i].mailpostername+'</span>'
                     +'</strong>'
                     +'<p>'
                     +'<a>'+readFlag+mailName+'&nbsp;&nbsp;'+attachmentName+jsonData.data0[i].mailsubject+'</a>'
                     +'<span>（'+mailPostTime+'）</span>'
                     +'</p>'
                     +'</li>'
                 }
                 //查询数据为空时页面展示信息
                 if(jsonData.data0.length == 0){
                	 result = '<li><p><a>系统没有查询到相关记录！</a></p></li>';
                 }
                 $(".wh-load-md").css("display","none");
                 if(loadFlag == '1'){
	                 $('.wh-article-lists ul').append(result);
                 }else{
	                 $('.wh-article-lists ul').html(result);
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
    		loadMailBox(urlType+'?curpage='+curPage,'1');
    	}
    }
    
    //绑定查询框回车事件
    $(document).keydown(function(event){ 
    	var searchTitle = $('#searchTitle').val();
		if(event.keyCode == 13){ //绑定回车
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				alert('请正确填写搜索邮件标题！');
				return false;
			}
			searchMail();
		} 
	});
    //查询收发信箱
    function searchMail(){
    	var searchTitle = $("#searchTitle").val();
    	if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
			alert('请正确填写搜索邮件标题！');
			return false;
		}
    	loadMailBox(urlType+'?curpage=1&subject='+searchTitle);
    }
    
    //打开收信或发信详情页面
    function openDetail(mailId,mailUserId,detailType,cloudcontrol){
    	if(cloudcontrol == '1'){
    		alert('该邮件不允许公有云查看，请与PC端查看！');
    	}else{
    		window.location = detailUrl+"?mailId="+mailId+"&mailuserId="+mailUserId+"&detailType="+detailType;
    	}
    }

	//input输入时，顶部fixed错位
	$('#searchTitle').bind('focus',function(){
	    $('#header_content').css('position','static');
	    $("#sectionScroll").css('padding-top',0);
	})/*.bind('blur',function(){
	    $('#header_content').css('position','fixed');
	    $("#sectionScroll").removeAttr("style");
	});*/
</script>
