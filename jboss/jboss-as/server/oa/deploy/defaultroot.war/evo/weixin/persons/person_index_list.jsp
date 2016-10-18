<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>通讯录</title>
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
                <a href="#" class="active"><span>全部</span></a>
                <a href="#"><span>组织</span></a>
            </div>
        </div>
    </div>
</header>
<section id="sectionScroll" class="wh-section wh-section-topfixed">
    <header class="wh-search" id="searchHeader">
        <div class="wh-container">
            <form>
                <input type="search" placeholder="输入姓名查询" name="queryCondition" value="${param.linkManName}" id="queryCondition"/>
                <input type="text" style="display: none"/>
                <i class="fa fa-search"></i>
            </form>
        </div>
    </header>
    <aside class="wh-category wh-category-contact">
        <div class="wh-container">
            <div class="wh-cate-lists" name="cateListChek">
            	<ul></ul>
            </div>
        </div>
    </aside>
    <article class="wh-article wh-article-contact">
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
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
	window.$$=window.Zepto = Zepto;
    var dialog = null;
    //标识当前列表
    var pageType = 'persons';
    var index = 0;
    Zepto(function($) {
        var cateListCK = $('div[name=cateListChek] i.fa-check-circle');
        cateListCK.tap(function(){
            cateListCK.not(this).removeClass('fa-check-circle-active');
            $(this).addClass('fa-check-circle-active');
        });
        var scrollTop = $(this).scrollTop();
        var scrollHeight = $(document).height();
        var windowHeight = $(this).height();
        var headerBtn = $("#headerBtn a");
        var sectionScroll = $("#sectionScroll");
        //页面加载完后ajax方式加载联系人数据
        ajaxLoding();
        loadPersonData();
        headerBtn.click(function(){
            index = $(this).index();
            headerBtn.eq(index).addClass("active").siblings().removeClass("active");
            var $conditionObj = $('#queryCondition');
            if(index==0){
            	$conditionObj.attr('placeholder','输入姓名查询');
            	$('#searchHeader').show();
            	$(".wh-article-lists ul").empty();
            	curpage = '1';
    		 	nomore = 'true';
            	loadPersonData('personPageList.controller');
            	pageType = 'persons';
            }else if(index==1){
            	//$conditionObj.attr('placeholder','输入组织查询');
            	$('#searchHeader').hide();
            	loadIndex = '0';
            	$(".wh-cate-lists ul").empty();
            	loadOrgData('0');
            	pageType = 'org';
            	$(".wh-load-box").css("display","none");
            }
        });
    });
    
    //联系人列表页加载下一页数据
    $(window).scroll(function(){
	    var scrollTop = $(this).scrollTop();
	    var scrollHeight = $(document).height();
	    var windowHeight = $(this).height();
	    if(scrollTop + windowHeight == scrollHeight){
			if(pageType == 'persons'){
				loadPersonData();
			}
	    }
    })

    //ajax加载loding
    function ajaxLoding(){
        dialog = $$.dialog({
            content:"数据加载中...",
            title: 'ok'
        });
    }
    
    //加载联系人数据
    var curpage = '1';
    var nomore = 'true';
    var loadFlag = '0';
    function loadPersonData(url){
    	if(loadFlag == '1'){
    		return false;
    	}
    	loadFlag = '1';
    	if(!url){
	    	url = 'personPageList.controller?curpage='+curpage;
    	}
    	queryCondition = $('#queryCondition').val();
    	if(nomore){
    		$(".wh-load-md").css("display","block");
			$(".wh-load-tap").html("正在加载...");
	        $.ajax({
	            type: 'post',
	            url: url,
	            dataType: 'text',
	            data : {'linkManName' : queryCondition},
	            success: function(data){
	               	var jsonData;
	               	if(data){
	              	 	jsonData = eval("("+data+")");
	              	 	var personArray = jsonData.data0;
		                nomore = jsonData.data1;
		                curpage = jsonData.data2;
		                var result = '';
		                if(personArray){
		                	var empLivingPhoto = '';
						    for(var i = 0; i < personArray.length; i++){
						    	if(personArray[i].empLivingPhoto && 'null' != personArray[i].empLivingPhoto){
						    		empLivingPhoto = '/defaultroot/upload/peopleinfo/'+personArray[i].empLivingPhoto;
						    	}else{
						    		empLivingPhoto = '/defaultroot/evo/weixin/images/head.png';
						    	}
						        result +=
						        '<li onclick="openPersonInfo('+personArray[i].id+');">'
				                    +'<strong class="contact-icon">'
				                    	+'<img src="'+empLivingPhoto+'"/>'
				                    +'</strong>'
				                    +'<p>'
					                    +'<a href="javascript:void(0)" class="contact-author">'+personArray[i].linkManName+'</a>'
					                    +'<span class="contact-part">'+personArray[i].linkManDepart+'</span>'
				                    +'</p>'
			                    +'</li>';
						  	}
		                }
		                //显示联系人列表
		               	$('article.wh-article').show();
						if(!result){
							result = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
						}
					  	$(".wh-article-lists ul").append(result);
					  	//隐藏组织列表
	                    $('aside.wh-category').hide();
					  	if(nomore){
							$(".wh-load-tap").html("上滑加载更多");
							$(".wh-load-box").css("display","block");
							$(".wh-load-md").css("display","none");
						}else{
							$(".wh-load-box").css("display","none");
						}
	               	}else{
	               		nomore = '';
	               	}
	               	if(dialog != null){
                		dialog.close();
                	}
	               	loadFlag = '0';
	            },
	            error: function(xhr, type){
	            	nomore = '';
	                $(".wh-load-tap").html("加载失败！");
	            }
	        });
    	}else{
    		$(".wh-load-box").css("display","none");
    	}
    }
    
   	//打开联系人详情 
	function openPersonInfo(id){
		window.location = "/defaultroot/persons/showPersonInfo.controller?personId="+id;
	}
   	
   	var loadIndex = '0';
    //加载组织数据
    function loadOrgData(parentOrgId,obj){
    	ajaxLoding();
    	if($(obj).siblings() && $(obj).siblings().eq(0).css("display") == "block"){
    		$(obj).siblings().hide();
    		$(obj).removeClass("wh-cate-libox-active");
    		if(dialog){
           		dialog.close();
           	}
    		return;
    	}else if($(obj).siblings() && $(obj).siblings().eq(0).css("display") == "none"){
    		$(obj).siblings().show();
    		$(obj).addClass("wh-cate-libox-active");
    		if(dialog){
           		dialog.close();
           	}
    		return;
    	}
        $.ajax({
            type: 'post',
            url: 'getOrgAndPersonByOrgId.controller?parentOrgId='+parentOrgId,
            dataType: 'text',
            success: function(data){
        		if(data){
        			var jsonData = eval("("+data+")");
        			var orgArray = jsonData.data0;
        			var personArray = jsonData.data1;
	                var result = '<ul>';
	                var personLis = '';
	                var addDom = '';
	                var iconClass = '';
	                if(loadIndex == '0'){
		                addDom = '<li>';
	                }
                	if(personArray){
                		// 判断头像数据是否为空
                		var empLivingPhoto = "";
                		personLis = '<div class="wh-article-lists"><ul>';
				        for(var j=0,length=personArray.length;j<length;j++){
	                		empLivingPhoto = "/defaultroot/upload/peopleinfo/"+personArray[j].empLivingPhoto;
	                		if(!personArray[j].empLivingPhoto || 'null' == personArray[j].empLivingPhoto){
	                			empLivingPhoto = '/defaultroot/evo/weixin/images/head.png';
	                		}
				        	personLis += 
								'<li onclick="openPersonInfo('+personArray[j].id+');">'
						        	+'<strong class="contact-icon">'
						        		+'<img src="'+empLivingPhoto+'"/>'
						        	+'</strong>'
						        	+'<p>'
						        		+'<a class="contact-author">'+personArray[j].linkManName+'</a>'
						        	+'</p>'
				        		+'</li>';	
				        }
				        personLis += '</ul></div>';
				    }
                	addDom += personLis;
                	var divHtml = '';
	                if(orgArray){
		                for(var i = 0; i < orgArray.length; i++){
		                	iconClass = getIconClass();
		                	if(orgArray[i].orgUserNum == 0){
		                		divHtml = '<div class="wh-cate-libox wh-cate-libox-empty">';
		                	}else{
		                		divHtml = '<div class="wh-cate-libox" onclick="loadOrgData('+orgArray[i].orgId+',this);">';
		                	}
		                	result += '<li>'+divHtml
							        	+'<a>'
							        	+'<i class="icon '+iconClass+'">'+orgArray[i].orgName.substring(0,1)+'</i>'
								        	+'<p>'
										        +'<strong>'+orgArray[i].orgName+'</strong>'
										        +'<span>人数'+orgArray[i].orgUserNum+'</span>'
									        +'</p>'
								        +'</a>'
							        +'</div></li>';
		                }
	                }
	                if(loadIndex == '0'){
		                addDom += result + '</ul></li>';
	                }else{
	                	addDom += result + '</ul>';
	                }
	                //隐藏联系人列表
	                $('article.wh-article').hide();
	                if(!obj){
		                $(".wh-cate-lists ul").append(addDom);
	                }else{
	                	$(obj).after(addDom);
	                }
	           	    //显示组织列表
	                $('aside.wh-category').show();
	           	    $(obj).addClass("wh-cate-libox-active");
	           	    loadIndex = '1';
	           	    if(dialog){
	               		dialog.close();
	               	}
        		}else{
        			//TODO
	            }
            },
            error: function(xhr, type){
                alert('数据查询异常！');
            }
        });
    }
    
    var queryCondition = '';
    //绑定查询框回车事件
    $('#queryCondition').keydown(function(event){
    	queryCondition = $('#queryCondition').val();
		if(event.keyCode == 13){ //绑定回车 
           	$(".wh-article-lists ul").empty();
           	curpage = '1';
   		 	nomore = 'true';
           	loadPersonData('personPageList.controller');
           	pageType = 'persons';
		} 
	});

	//input输入时，顶部fixed错位
	$('#queryCondition').bind('focus',function(){
	    $('#header_content').css('position','static');
	    $("#sectionScroll").css('padding-top',0);
	}).bind('blur',function(){
	    //$('#header_content').css('position','fixed');
	    //$("#sectionScroll").removeAttr("style");
	});
</script>