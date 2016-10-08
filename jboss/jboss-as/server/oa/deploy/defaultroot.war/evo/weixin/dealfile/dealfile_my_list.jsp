<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
	String workStatus =request.getAttribute("workStatus")==null?"0":request.getAttribute("workStatus").toString();
	String headTitle ="";
	if("1100".equals(workStatus)){
		headTitle ="我的文件";
	}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title><%=headTitle %></title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<%
	int G_PAGE_SIZE = 15;
	int recordCount =request.getAttribute("recordCount")==null?Integer.parseInt("0"):Integer.parseInt(request.getAttribute("recordCount").toString());
	String offset =request.getAttribute("offset")==null?"0":request.getAttribute("offset").toString();
%>
<body>
<section id="sectionScroll" class="wh-section">
    <header class="wh-search">
        <div class="wh-container">
        	<form>
		        <input type="search" placeholder="搜索流程标题" id="searchTitle"/>
		        <i class="fa fa-search"></i>
		        <input type="hidden" name="workStatus" id="workStatus" value="<%=workStatus%>"/>
		        <input type="text" style="display: none;"/>
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
        loadDealFileList('getListData.controller');
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
                		if(listData[i].workCurStep.indexOf('取消') == -1){
                			emDom = '<em class="not-over">未完成</em>';
                    	}else{
                    		emDom = '<em class="not-over">已取消</em>';
                        }
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
	$(".Invest").find("span").click( function(){
		$(this).hide();
		$(".Invest").find(".sreach_ipu").show();
		$(".Invest").find(".sreach_ipu")[0].focus()  
	});
	
    function hide(){
		$(".Invest").find(".sreach_ipu").hide();
		$(".Invest").find("span").show();
    }

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