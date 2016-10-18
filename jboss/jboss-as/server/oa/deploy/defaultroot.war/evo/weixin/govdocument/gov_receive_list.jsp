<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>公文列表</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<header class="wh-header">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div id="headerBtn" class="wh-header-btn">
                <a href="#" class="active"><span>全部</span></a>
                <a href="#"><span>未读</span><c:if test="${unReadNum ne '0'}"><em>${unReadNum}</em></c:if></a>
            </div>
        </div>
    </div>
</header>
<section id="sectionScroll" class="wh-section wh-section-topfixed">
    <header class="wh-search">
        <div class="wh-container">
        	<form>
		        <input type="search" placeholder="搜索公文标题" id="searchTitle"/>
		        <input type="text" style="display: none"/>
		        <i class="fa fa-search"></i>
	        </form>
        </div>
    </header>
    <article class="wh-article wh-article-receive">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul id="doc_list">
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
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
	//列表类型：allList全部收文，unReadList未读收文
	window.$$=window.Zepto = Zepto;
    var listType = 'allList';
    Zepto(function($)  {
        var cateListCK = $('div[name=cateListChek] i.fa-check-circle');
        cateListCK.tap(function(){
            cateListCK.not(this).removeClass('fa-check-circle-active');
            $(this).addClass('fa-check-circle-active');
        });
		
		//input输入时，顶部fixed错位
		$('#searchTitle').bind('focus',function(){
			$('.wh-header').css('position','static');
			$("#sectionScroll").css('padding-top',0);
		}).bind('blur',function(){
			//$('.wh-header').css('position','fixed');
			//$("#sectionScroll").removeAttr("style");
		});

        var headerBtn = $("#headerBtn a");
        //页面加载完后加载我的全部收文
        loadDocList('getReceiveFileBoxPage.controller',listType);
        headerBtn.tap(function(){
        	$('#searchTitle').val('');
            var index = $(this).index();
            $('#doc_list').empty();
            headerBtn.eq(index).addClass("active").siblings().removeClass("active");
            if(index == 0){
            	listType = 'allList';
            }else if(index == 1){
            	listType = 'unReadList';
            }
           	offset = '0';
            loadDocList('getReceiveFileBoxPage.controller',listType);
        })
    });

    var dialog = null;
    //加载遮罩层
    function ajaxLoding(){
        dialog = $$.dialog({
            content:"数据加载中...",
            title: 'ok'
        });
    }
    
    //列表记录偏移量
    var offset = '0';
    //是否有下一页标志
    var nomore = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatus = '0';
    //加载收文列表数据
    function loadDocList(jsonurl,listType,searchTitle){
    	if(loadStatus == '1'){
    		return;
    	}
    	loadStatus = '1';
    	ajaxLoding();
        $.ajax({
            type : 'post',
            url : jsonurl,
            dataType : 'text',
            data : {'offset' : offset,'listType' : listType,'title' : searchTitle},
            success: function(data){
                var addDom = '';
                if(!data){
                	return;
                }
               	var jsonData = eval("("+data+")");
               	var docArray = jsonData.data0;
               	if(!docArray){
               		return;
               	}
               	var readedClass = '';//是否已读样式
               	var stongClass = '';
               	var emDom = '';//附件表示dom
               	for(var i=0,length=docArray.length;i<length;i++){
               		//判断读取状态
	               	if(docArray[i].userIsReaded == '1'){
	               		readedClass = 'list-readed';
	               		iClass = 'fa fa-file-text-o';
	               	}else{
	               		readedClass = 'list-unread';
	               		iClass = 'fa fa-file-text-o';
	               	}
               		//判断是否有附件
               		if(docArray[i].accessoryName && docArray[i].accessorySaveName){
						if(docArray[i].userIsReaded == '1'){
							//emDom = '<em class="blue">附件</em>';
							emDom = '<img src="/defaultroot/evo/weixin/images/fj2.gif"/>'
						}else{
							emDom = '<em class="orange">未读</em><img src="/defaultroot/evo/weixin/images/fj2.gif"/>';
						}
               			
               		}else{
						if(docArray[i].userIsReaded == '1'){
               				emDom = '';
						}else{
							emDom = '<em class="orange">未读</em>';
						}
               		}
               		addDom += '<li onclick="openDetail(this);" class="'+readedClass+'">'+
						          '<strong class="receive-icon">'+
						          	  '<i class="'+iClass+'"></i>'+
						          '</strong>'+
						          '<p>'+
							          '<a>'+emDom+docArray[i].title+'</a>'+
									  '<span>（'+docArray[i].createdTime.substring(0,10)+'）</span>'+
						          '</p>'+
								  '<form>'+
									  '<input type="hidden" name="writeOrg" value="'+docArray[i].writeOrg+'"/>'+
									  '<input type="hidden" name="createdTime" value="'+docArray[i].createdTime+'"/>'+
									  '<input type="hidden" name="title" value="'+docArray[i].title+'"/>'+
									  '<input type="hidden" name="accessoryName" value="'+docArray[i].accessoryName+'"/>'+
									  '<input type="hidden" name="accessorySaveName" value="'+docArray[i].accessorySaveName+'"/>'+
									  '<input type="hidden" name="goldGridId" value="'+docArray[i].goldGridId+'"/>'+
									  '<input type="hidden" name="wordType" value="'+docArray[i].wordType+'"/>'+
									  '<input type="hidden" name="id" value="'+docArray[i].id+'"/>'+
								  '</form>'+
			                  '</li>';
               	}
               	if(!addDom){
               		addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
               	}
                $('#doc_list').append(addDom);
                //是否有下一页标识
                nomore = jsonData.data1;
                //返回的记录偏移量
                offset = jsonData.data2;
               	if(nomore){
        			$(".wh-load-box").css("display","block");
       		 	}else{
       				$(".wh-load-box").css("display","none");
       		 	}
               	$(".wh-load-md").css("display","none");
                if(dialog != null){
                	dialog.close();
                }
                //将加载状态重置为0
                loadStatus = '0';
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
    	   //加载下一页
		   if(nomore == 'true'){
		   	   $(".wh-load-md").css("display","block");
		   	   loadDocList('getReceiveFileBoxPage.controller',listType,$('#searchTitle').val());
	   	   }
       }
    });
    
    //绑定查询框回车事件
    $('#searchTitle').keydown(function(event){ 
    	var searchTitle = $('#searchTitle').val();
		if(event.keyCode == 13){ //绑定回车 
			if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
				alert('请正确填写搜索公文标题！');
				return false;
			}
			offset = '0';
			$('#doc_list').empty();
			loadDocList('getReceiveFileBoxPage.controller',listType,searchTitle);
		} 
	});
    
    //打开收文详情
    function openDetail(obj){
    	$(obj).find('form').attr('action','openReceiveDetail.controller').attr('method','get').submit();
    }



</script>




