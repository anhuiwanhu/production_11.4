<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
	String workStatus =request.getAttribute("workStatus")==null?"0":request.getAttribute("workStatus").toString();
	String headTitle ="";
	if("101".equals(workStatus)){
		headTitle ="已办文件";
	}else if("102".equals(workStatus)){
		headTitle ="已阅文件";
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
	<title><%=headTitle%></title>
	<link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
</head>
<%
	int G_PAGE_SIZE = 15;
	int recordCount =request.getAttribute("recordCount")==null?Integer.parseInt("0"):Integer.parseInt(request.getAttribute("recordCount").toString());
	String offset =request.getAttribute("offset")==null?"0":request.getAttribute("offset").toString();
%>
<body>
<header class="wh-header"  id="headerBug">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div id="headerBtn" class="wh-header-btn">
                <a href="#" class="active col-xs-6"><span>已办</span></a>
                <a href="#" class="col-xs-6"><span>已阅</span></a>
            </div>
        </div>
    </div>
</header>
<section id="sectionScroll" class="wh-section wh-section-topfixed">
    <header class="wh-search">
        <div class="wh-container">
	    	<form>
		        <input type="search" placeholder="搜索流程标题" id="searchTitle"/>
		        <input type="text" style="display: none;"/>
		        <i class="fa fa-search"></i>
	        </form>
        </div>
    </header>
    <article class="wh-article wh-article-document">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul id="deal_file_list">
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
<script type="text/javascript">
   	var dialog = null;
    var workStatus = '${workStatus}';
    Zepto(function($) {
        var cateListCK = $('div[name=cateListChek] i.fa-check-circle');
        cateListCK.tap(function(){
            cateListCK.not(this).removeClass('fa-check-circle-active');
            $(this).addClass('fa-check-circle-active');
        });
		//input输入时，顶部fixed错位
		$('#searchTitle').bind('focus',function(){
			$('#headerBug').css('position','static');
			$("#sectionScroll").css('padding-top',0);
		}).bind('blur',function(){
			$('#headerBug').css('position','fixed');
			$("#sectionScroll").removeAttr("style");
		});

        var headerBtn = $("#headerBtn a");
        loadDealFileList('getListData.controller');
        headerBtn.tap(function(){
        	$('#deal_file_list').empty();
        	$('#searchTitle').val('');
            var index = $(this).index();
            headerBtn.eq(index).addClass("active").siblings().removeClass("active");
            if(index == 0){
            	//已办
            	workStatus = '101';
            }else if(index == 1){
            	//已阅
            	workStatus = '102';
            }
            offset = '0';
            loadDealFileList('getListData.controller');
        });
    });

    function ajaxLoding(){
        dialog = $.dialog({
            content:"数据加载中...",
            title: 'ok'
        });
    }
    
    var offset = '0';
    //是否有下一页标志
    var nomore = '';
    //加载状态，0：未加载，1：已加载，防止重复加载数据
    var loadStatus = '0';
    //加载列表数据
    function loadDealFileList(url){
    	if(loadStatus == '1'){
    		return;
    	}
    	loadStatus = '1';
        $.ajax({
            type: 'post',
            url: url,
            dataType: 'text',
            data : {'workStatus' : workStatus,'offset' : offset,'title' : $('#searchTitle').val()},
            success: function(data){
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
                var addDom = '';//添加的dom
                var empLivingPhoto = '';//用户头像
                var curFlag = '';//当前环节
                var emDom = '';//未完成时，显示未完成
                offset = jsonData.data2;
                for(var i = 0,length = listData.length; i < length; i++){
                	if(listData[i].empLivingPhoto && 'null' != listData[i].empLivingPhoto){
                		empLivingPhoto = '/defaultroot/upload/peopleinfo/'+listData[i].empLivingPhoto;
                	}else{
                		empLivingPhoto = '/defaultroot/evo/weixin/images/head.png';
                	}
                	if(listData[i].workCurStep.indexOf('办理完毕') == -1){
                		curFlag = '当前环节为 ' + listData[i].workCurStep;
                		emDom = '<em class="not-over">未完成</em>';
                	}else{
                		curFlag = '';
                		emDom = '';
                	}
                	addDom += '<li>'
			                     +'<strong class="document-icon">'
			                    	 +'<img src="'+empLivingPhoto+'" />'
			                     +'</strong>'
			                     +'<p>'
				                     +'<a href="'+getDealFileDetailUrl(listData[i].workMainLinkFile)+'?workStatus='
				                     +workStatus+'&workId='+listData[i].workId+'&workCurStep='+listData[i].workCurStep+'&empLivingPhoto='+empLivingPhoto+'&flag=ed">'
				                     +emDom+listData[i].workTitle+curFlag+'</a>'                                                                
				                     +'<span>（'+listData[i].workSubmitTime.substring(0,16)+'）</span>'
			                     +'</p>'
		                      +'</li>';
                }
                if(!addDom){
                	addDom = '<li><p><a>系统没有查询到任何记录！</a></p></li>';
                }
                $('#deal_file_list').append(addDom);
                //是否有下一页标识
                nomore = jsonData.data1;
                if(nomore){
        			$(".wh-load-box").css("display","block");
       		 	}else{
       				$(".wh-load-box").css("display","none");
       		 	}
               	$(".wh-load-md").css("display","none");
                if(dialog){
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
    
    //获取文件办理url
    function getDealFileDetailUrl(workMainLinkFile){
    	if(!workMainLinkFile){
    		return '';
    	}
    	if(workMainLinkFile.indexOf('/defaultroot/GovDocSendProcess!') > -1){
    		return '/defaultroot/doc/sendGovProcess.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/GovSendFileLoadAction.do') > -1){
    		return '/defaultroot/doc/sendGovProcess.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/wfopenflow!') > -1){
    		return '/defaultroot/dealfile/process.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/WorkFlowProcAction.do') > -1){
    		return '/defaultroot/dealfile/process.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/Information!') > -1){
    		return '/defaultroot/information/process.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/InformationAction.do') > -1){
    		return '/defaultroot/information/process.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/GovDocReceiveProcess!') > -1){
    		return '/defaultroot/doc/receiveGovProcess.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/GovReceiveFileLoadAction.do') > -1){
    		return '/defaultroot/doc/receiveGovProcess.controller';
    	}else if(workMainLinkFile.indexOf('/defaultroot/voitureApply!modi.action') > -1){
		    return '/defaultroot/dealfile/voitureProcess.controller';
		}else if(workMainLinkFile.indexOf('/defaultroot/outStockAction!modifyFlow.action') > -1){
			return '/defaultroot/dealfile/getOutStockResult.controller';
		}else if(workMainLinkFile.indexOf('/defaultroot/intoStockAction!modifyFlow.action') > -1){
			return '/defaultroot/dealfile/getIntoStockResult.controller';
		}else if(workMainLinkFile.indexOf('/defaultroot/GovDocSendCheckProcess!') > -1){
			return '/defaultroot/doc/sendfileCheckProcess.controller';
		}else{
    		return '/defaultroot/dealfile/process.controller';
    	}
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
		   	   loadDealFileList('getListData.controller');
	   	   }
       }
    });
    
    //绑定查询框回车事件
    $('#searchTitle').keydown(function(event){ 
		if(event.keyCode == 13){ //绑定回车 
			offset = '0';
			$('#deal_file_list').empty();
			loadDealFileList('getListData.controller');
		} 
	});







/* 
	$(".Invest1").find("span").click( function(){
		$(this).hide();
		$(".Invest1").find(".sreach_ipu").show();
		$(".Invest1").find(".sreach_ipu")[0].focus()  
	});
	
	function hide(){
		$(".Invest1").find(".sreach_ipu").hide();
		$(".Invest1").find("span").show();
    }
	
	<%if("101".equals(workStatus)){%>
	$(".handle").addClass("onnav");
	<%}else if("102".equals(workStatus)){%>
	$(".critiqued").addClass("onnav");
	<%}%>
	$(".Contain .ContTab").find(".Box:first").show();

	var pager_offset ='<%=offset%>';
	var stop=true;
	<c:if test="${empty nomore}">
		stop =false;
	</c:if>

	$(window).scroll(function(){ 
		totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop()); 
		if($(document).height() <= totalheight){ 
			if(stop==true){
				stop=false;
				loadmore();
			}
		}
	});

	function loadmore(){
		$("#footer").html("正在加载...");
		var url ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>&pageSize='+pager_offset;
		$.get(url, function(data,status){
			if(status != "success"){
				alert("加载失败！");
				$("#footer").html("上滑加载更多");
				$("#loader").show();
				stop = true;
				return;
			}
			var $data = $(data);
			var len =$data.find('#page_row').length;
			if(len>0){
				pager_offset = parseInt(pager_offset) + <%=G_PAGE_SIZE%>;
				$('#content').append($data.find('#page_row'));
			}
			if(len < <%=G_PAGE_SIZE%>){
				$("#footer").detach();
				$("#loader").hide();
				stop =false;
			}else{
				if('<%=recordCount%>' == pager_offset){
					$("#footer").detach();
					$("#loader").hide();
					stop =false;
				}else{
					$("#footer").html("上滑加载更多");
					$("#loader").show();
					stop=true;
				}
			}
		});
	}
	*/
</script>