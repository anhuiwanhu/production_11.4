 //操作css路径
function createLink(cssURL){
    var head = $($('head')[0]),
        linkTag = null;
    if(!cssURL){
        return false;
    }
    linkTag = $('<link href="' + cssURL + '" rel="stylesheet" type="text/css" />');
    head.append(linkTag);
};

function removeLink(cssURL){
    var head = $($('head')[0]);
    if(!cssURL){
        return false;
    }
    $('head link').each(function(){
        var url = $(this).attr('href');
        if(url === cssURL) {
            $(this).remove();
        }
    });
};

//body 加载 字体css
$('.small').click(function(){
    removeLink('../templates/template_default/common/css/template.frame.big.css');
    createLink('../templates/template_default/common/css/template.frame.small.css');
});


$('.big').click(function(){
    removeLink('../templates/template_default/common/css/template.frame.small.css');
    createLink('../templates/template_default/common/css/template.frame.big.css');
});




/**
左侧隐藏切换
*/
function  leftrightButtoon(){
    var leftTree = $(".wh-con-table th");
    leftTree.show();
    $("#switchShow").hide();
    $("#switchHide").click(function(){
        leftTree.hide();
        $("#switchShow").show();
    });
    $("#switchShow").click(function(){
        leftTree.show();
        $("#switchShow").hide();
    })
};

/**
点击 隐藏 菜单编辑 
*/
function judgeClickHideMenu(e){
	//   
	var self = $(e.target);  
	//wh-hd-custom-menu-d   
	var is_inmenuDiv_length=self.parents('#menu_hidden_dd').length; 
    var is_inmenuDiv_length2=self.parents('.wh-hd-custom-menu-d').length;  
	if(self.attr("id")=="menu_hidden_dd"||is_inmenuDiv_length>0||is_inmenuDiv_length2>0){
		return false;
	}else{
	    return true;
	} 
}

/**
*/
function judgeClickHideGaty(e){
	//
    var self = $(e.target);   
	var is_inmenuDiv_length=self.parents('#desktop_choosegateway_dd').length; 
	if(self.attr("id")=="desktop_choosegateway_dd"||is_inmenuDiv_length>0){
		return false;
	}else{
	    return true;
	} 
}



/**
desktop  页面元素 加上点击事件
*/
function initdesktopEvent(){ 
    /*菜单收缩*/
    var wh_hd_custom_switch = $(".wh-hd-custom-switch");
    var wh_hd_custom_menu = $(".wh-hd-custom-menu");
    var wh_hd_cmc = $(".wh-hd-menu-add-cut");
    $(".wh-hd-menu-btn-a").click(function () {
        if(wh_hd_custom_switch.is(':visible')){
            $(this).parents().removeClass('current');
            wh_hd_custom_switch.hide();
            return false;
        }else{
            wh_hd_custom_switch.slideDown(300);
            $(this).parents(".wh-hd-menu-btn").addClass('current');
            return false;
        }
        return false;
    });
    
	
    /*点击门户 菜单显示隐藏*/
    var wh_hd_gi = $(".wh-hd-l-gateway-info");

    $(document).click(function(e){ 
		//隐藏  菜单以及门户 编辑栏目
		if(wh_hd_custom_switch.is(':visible')&&judgeClickHideMenu(e)){
			$(".wh-hd-menu-btn").removeClass('current');
			wh_hd_custom_switch.slideUp(100);
			return false;
		}   
		if(wh_hd_gi.is(':visible')&&judgeClickHideGaty(e)){
			//
			$('.fa-gateway').attr('class','fa fa-angle-down fa-gateway fa-color');
            wh_hd_gi.slideUp(100);
		} 
    });

    $('.fa-gateway').click(function () {
        var $this = $(this);
        if(wh_hd_gi.is(':visible')){
            $this.attr('class','fa fa-angle-down fa-gateway fa-color');
            wh_hd_gi.hide();
            return false;
        }else{
            $this.attr('class','fa fa-angle-up fa-gateway fa-color');
            wh_hd_gi.slideDown(100);
            return false;
        }
    })
    //门户下单菜单
    $(".wh-hd-l-gateway-info").find("a").click(function () {
        $(this).addClass("current").siblings().removeClass("current");
        return false;
    });

    /*自定义菜单显隐*/
    $(".wh-hd-custom-menu-btn").click(function(){
		showEditMenuInfo();
        wh_hd_custom_menu.css({
            "right":"-470px",
            "transition":"right 300ms linear",
            "-webkit-transition":"right 300ms linear",
            "-ms-transition":"right 300ms linear"
        });
        wh_hd_cmc.css({
            "right":"0",
            "transition":"right 300ms linear",
            "-webkit-transition":"right 300ms linear",
            "-ms-transition":"right 300ms linear"
        });
        return false;
    });

    //
	wh_hd_custom_switch.hover(
		function(){
	},
		function(){ 
         	$(".wh-hd-menu-btn").removeClass('current');
			$(this).slideUp(100);
	
	});


    wh_hd_gi.hover(
		function(){
	},
		function(){ 
         	$('.fa-gateway').attr('class','fa fa-angle-down fa-gateway fa-color');
			$(this).slideUp(100);
	
	}); 


    //点击向左按钮 自定义菜单消失
    $(".fa-angle-left").click(function(){
        wh_hd_custom_menu.css({
            "right":"0",
            "transition":"right 300ms linear",
            "-webkit-transition":"right 300ms linear",
            "-ms-transition":"right 300ms linear"
        });
        wh_hd_cmc.css({
            "right":"470px",
            "transition":"right 300ms linear",
            "-webkit-transition":"right 300ms linear",
            "-ms-transition":"right 300ms linear"
        });
        return false;
    });
   /* //自定义菜单显示 hover单个选项 出现删除按钮
    var iremove= '<i class="fa fa-times"></i>';
    $(".wh-hd-menu-cut-slide .wh-hd-custom-menu-d").hover(function(){
        $(this).append(iremove);
    },function(){
        $(this).find('.fa-times').remove();
    });
    //自定义菜单显示 hover单个选项 出现添加按钮
    var itag = '<i class="fa fa-plus"></i>';
    $(".wh-hd-menu-add .wh-hd-custom-menu-d").hover(function(){
        $(this).append(itag);
    },function(){
        $(this).find('.fa-plus').remove();
    });*/

    //右侧菜单常规HOVER交互
    $(".wh-hd-r-nav li:has(.wh-hd-box-shadow)").hover(function(){
        $(this).find(".wh-hd-box-shadow").stop(true,true).slideDown(100);
    },function(){
        $(this).find(".wh-hd-box-shadow").stop(true,true).slideUp(100);
    });

    //右侧菜单 搜索 展开搜索分类交互
    var wh_hd_usl = $('.wh-hd-user-search-list');
    $(".wh-hd-search-info").click(function(){
        $(this).children(".fa").toggleClass("fa-angle-down");
        wh_hd_usl.slideToggle(100);
    });

    //个人资料交互
    var wh_hd_state = $(".wh-hd-state");
    var fathis = $('.wh-hd-user-faclick i.fa');
    fathis.click(function(){
        var index = fathis.index(this);
        fathis.not(this).removeClass("fa-angle-down");
        $(this).toggleClass("fa-angle-down");
        wh_hd_state.eq(index).slideToggle(100).siblings(".wh-hd-state").hide();
    });
    //点击个人中心出现的详细信息中的选项 添加样式
   /* $(".wh-hd-state").find("a").click(function () {
       // $(this).addClass("current").siblings().removeClass("current");
        //return false;
    });*/
    //提醒
    $("#desktop_all_remindNum_a").click(function(){  
        var wh_hd_tips_dialog =  $.dialog({
			id:"wh_hd_tips_dialog",
            title: ''+comm.desktop_remindtitle,//
            content: $(".wh-sys-setting-dialog").html(),
            width: 500,
            height: 270,
            max: false,
            min: false,
        });
        $(".edit-notice").click(function () {
            $('.wh-sys-notice-list-setting').hide();
            $(".wh-sys-notice-list-setting-edit").toggle();
        });
        $('.setting-tips-to-close').click(function () {
            $(".wh-sys-notice-list-setting-edit").hide();
            $('.wh-sys-notice-list-setting').show();
        })
    }); 
    //换肤hover效果
    /*$('.wh-sys-setting-skin-change').click(function(){
        var wh_hd_skin_dialog =  $.dialog({
            title: ''+comm.skin_set,
            content: $(".wh-sys-skin-dialog").html(),
            width: 624,
            height: 200,
            max: false,
            min: false,
        });
        $(".wh-sys-setting-skinlist p").click(function () {
            $(this).addClass('current').siblings().removeClass('current');
        });
    });*/
 
 
    $(".wh-hd-r-nav li:nth-child(2n)").hover(function(){
        showUserNum(); 
    },function(){
         
    });   
 
};

//关闭remind弹出框

function  closeRemindEdit(){
    $.dialog({id:'wh_hd_tips_dialog'}).close();
}
  

/**
获取数据库里状态
*/
function getStates(){
	var result = "";
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/modules/personal/setup/getDefineStates.jsp",
		cache: true,
        async: false,
		dataType: 'text',
		success: function(data) {
			result = data;
		}
	});
	result = result.replace(/\</g,'&lt;').replace(/\>/g,'&gt;');
	return result;
};


/**
设置左侧菜单的某一项为选中状态
*/
function  OpenCloseSubMenu(index){
	try{
		 var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		 var node = zTree.getNodeByParam("id",index); 
		 zTree.selectNode(node);  
		 zTree.checkNode(node, true, true);
	}catch(e){
	}
};


/**
设置左侧菜单的某一项为选中状态
*/
function  OpenSubMenu(code){
	try{
		 var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		 var node = zTree.getNodeByParam("expNodeCode",code,null); 
		 zTree.selectNode(node);  
		 zTree.checkNode(node, true, true);
	}catch(e){
	}
};

/*
function screeBox(leftList11,rightIframe){
	var   leftList=$("#left2Div");
	var winHeight = $(window).height();
	leftList.css({'height':winHeight - 130});
	rightIframe.css({'height':winHeight - 90});
};
 

//DOM加载完成之后执行的操作
$(function(){
	var rightIframeH = $("#rightTd");
	var leftListH = $("#left2Div"); 
	screeBox(leftListH,rightIframeH); 
	$(window).resize(function(){ 
		screeBox(leftListH,rightIframeH); 
	    //console.log("left html:"+$("#left2Div").html());
	});
});*/


/**
*/
function screeBox(_leftList,_rightIframe){
	var winHeight = $(window).height();   
	var rightIframeH = $(".wh-con-table .wh-r-content");
	rightIframeH.css({'height':winHeight - 74});
	if($(".wh-l-con").length>0){
		var  iframeLen=$('iframe#leftIframe').length;
		//左侧没有使用 iframe时候 才赋值高度
		if(iframeLen<=0){
		   var leftList=$(".wh-l-con");
		   leftList.css({'height':winHeight - 118}); 
		} 
	}  
 
	//console.log("screeBox r:"+$(".wh-con-table td").height());
	//console.log("screeBox l:"+$(".wh-l-con").height());
	/*
	var winHeight = $(window).height();   
	if(true||leftList==null||typeof(leftList)=="undefined"){ 
		if($(".wh-l-con").length>0){
			leftList=$(".wh-l-con");
			leftList.css({'height':winHeight - 130});  
		} 
	}else{ 
	    leftList.css({'height':winHeight - 130}); 
	}
 
	rightIframe.css({'height':winHeight - 90});
	//console.log("rightIframe height:"+rightIframe.height()); 
	if(leftList!=null&&typeof(leftList)!="undefined"){ 
	   // console.log("leftList height:"+leftList.height());
	}*/
};
 
/**
初始化执行函数
*/
$(function(){
	var rightIframeH = $(".wh-con-table .wh-r-content");
	var leftListH ;
	if($(".wh-l-con").length>0){
	    leftListH=$(".wh-l-con"); 
	} 
	screeBox(leftListH,rightIframeH); 
    var resizeTimer;
    function resizeFunction() {
        screeBox(leftListH,rightIframeH);
    };

	$(window).resize(function(){ 
		//screeBox(leftListH,rightIframeH);
		clearTimeout(resizeTimer);
        resizeTimer = setTimeout(resizeFunction, 300);
	});  
	leftrightButtoon();  
	initdesktopEvent(); 
	//打开桌面
	openDesktopNew();  
	//初始化两个隐藏的 iframe
	initIframe(0); 

	//更改图片高度
	//initImageHeight();
});
 

/**

*/
function initPortalNew(layoutId){
    var _firsetLayoutId = ""; 
    if(layoutId!=null && layoutId!="" && layoutId!="null"){
		if($("#Layout"+layoutId).length>=1){
			 _firsetLayoutId = layoutId;
		}  
        return _firsetLayoutId;
    }

    if(layoutId==null || layoutId=="" || layoutId=="null"){
	     var _id = $("#gateway_div a:first-child").attr('id');
		 if(_id){
             _firsetLayoutId = _id.substring(6);  
		 }
    }
    return _firsetLayoutId;
};
 

//选择当前上次选择的非个人门户 的门户
function openLastChoosedDesktopNew(){ 
	var layoutId="";
    var choosedLayout = $("#gateway_div > a.current");  
	if(choosedLayout.length>0){ 
		layoutId=choosedLayout.attr('id'); 
		layoutId = layoutId.substring(6); 
	}else{
		var _id = $("#gateway_div a:first-child").attr('id');
		if(_id){
           layoutId = _id.substring(6); 
		}
	} 
    selectLayout(layoutId);
};

/**定义图片高度*/
function  initImageHeight(){
	 var ver=navigator.appVersion.substring(navigator.appVersion.indexOf("MSIE ")+5, navigator.appVersion.indexOf("MSIE ")+8);
	 var  loginPicheight = 0;
	 if(navigator.appVersion.indexOf("MSIE") >0 && ver < 9){
		var loginPic = getNatural(document.getElementById('desktop_logoFileImage'));
		loginPicheight = loginPic.height;
	}else{
	    loginPicheight = $('img#desktop_logoFileImage')[0].naturalHeight;
	}
	
	if(loginPicheight > 0){
		$("#desktop_logoFileImage").attr("data-pich",loginPicheight);
	}

	var picHeight = parseInt($("#desktop_logoFileImage").data('pich')+"px");
	var picMarginTop = "-"+parseInt($("#desktop_logoFileImage").data('pich'))/2+"px";
	$("#desktop_logoFileImage").height(picHeight);
	$("#desktop_logoFileImage").css({"height":picHeight, "margin-top":picMarginTop});
};


function getNatural (DOMelement) {
    var img = new Image();
    img.src = DOMelement.src;
    return {width: img.width, height: img.height};
};

/**
 隐藏的iframe 加载页面
 即时通讯
 重复登入踢人，   刷新session
 usedPortal: 0 从登录页 进来     1： 从portal 进来
*/
function initIframe(usedPortal){  
	if($("#iframe2").length>0){		
         $("#iframe1").attr("src", "public/desktop/getfestival.jsp?usedPortal="+usedPortal);
	     $("#iframe2").attr("src", "public/desktop/topiframeNewNew.jsp?usedPortal="+usedPortal);
	}else{
	    setTimeout('initIframe('+usedPortal+')',300);
	}
};


/**
切换皮肤
*/
function modiMySkinSC(){
    var url = whirRootPath + "/MyInfoAction!modiMySkin.action?fromDesktop=1&date="+new Date();
    popup({content:'url:'+url, title:comm.skin_set, width:'624px', height:'250px', lock:true, resize: false, min: false, max: false});
  

	/*var wh_hd_skin_dialog =  $.dialog({
		title: ''+comm.skin_set,
		content: $(".wh-sys-skin-dialog").html(),
		width: 624,
		height: 200,
		max: false,
		min: false,
	});
	$(".wh-sys-setting-skinlist p").click(function () {
		$(this).addClass('current').siblings().removeClass('current');
	});*/


};


/**
打开帮助手册
*/
function openHelp(){
    var vherf = whirRootPath+"/help/index.html";
    openWin({url:vherf,isFull:true,winName:'openHelp'});
}

/**
 修改图片
*/
function modiMyPhoto(){
	if(!isPad()){
		jumpnew(whirRootPath +'/modules/personal/personal_menu.jsp?expNodeCode=myInfo',whirRootPath +'/MyInfoAction!modiMyPhoto.action');			
	}
};


/**
个人设置页面 修改个人信息
*/
function  modiMyInfo(){
	jumpnew('/modules/personal/personal_menu.jsp?expNodeCode=myInfo','MyInfoAction!modiMyInfo.action');
};


/**
安全退出
*/
function reLog() { 
    window.location.href = whirRootPath + "/login.jsp?validate=no";
};

/**
全文检索 搜索
*/
function ezLuceneSearch(){
	var searchKey = $("#searchKey").val();
    if(searchKey == ''){
        whir_alert(comm.search_tip);
        return;
    }
    var searchType = $("#searchType").val();
    if(searchType=="info"){
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','InfoList!retrievalList.action?channelType=0&userChannelName=信息管理&userDefine=0&type=all&retrievalKey='+searchKey);
    }else if(searchType=="sendfile"){
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','/defaultroot/modules/govoffice/gov_documentmanager/ezLucene_sendfile_list.jsp?retrievalKey='+searchKey);
    }else if(searchType=="receivefile"){
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','/defaultroot/modules/govoffice/gov_documentmanager/ezLucene_receivefile_list.jsp?retrievalKey='+searchKey);
    }else if(searchType=="contract"){
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','contract!contractInLucene.action?retrievalKey='+searchKey);
    }else if(searchType=="forum"){
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','ForumAction!luceneList.action?retrievalKey='+searchKey);
    }else if(searchType=="govcheck"){  
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','/defaultroot/modules/govoffice/gov_documentmanager/ezLucene_sendfilecheck_list.jsp?retrievalKey='+searchKey);
    }else if(searchType=="document"){
        jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','Document!luceneList.action?retrievalKey='+searchKey);
    }else if(searchType=="filedeal"){
    	jumpnew('/defaultroot/modules/personal/personal_menu.jsp?expNodeCode=search','wfdealwith!getWorkFlowLucene.action?retrievalKey='+searchKey);
    }     
};

/**
选择全文检索的模块
*/
function changeSearchType(type,name,obj){
   $("#searchType").val(type);
   $("#searchType_span").html(name); 
   $(obj).addClass("current").siblings().removeClass("current");
};

/**
切换组织信息
*/
function changeCurOrgInfo(orgId){
	var result = "";
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/change_current_org.jsp?orgId="+orgId,
        async: false,
		dataType: 'text',
		success: function(data){
			result = data;
		}
	});	
	return result;
};

//切换当前组织信息
function changeCurOrg(orgId,orgName,orgIdString,orgSelfName,orgEnglishName,obj){
    var curOrgId = $("#curOrgId").val();//document.getElementById("curOrgId").value;
    var msg = comm.confirm_tip1 + orgSelfName + comm.whir_confirmlast;
    if(orgId!=curOrgId){
    	if(confirm(msg)){
			var returnValue = changeCurOrgInfo(orgId).replace(/\n|\r/g,"");
			if(returnValue=="1"){
				$("#curOrgId").val(orgId);
				$("#currentOrgName").attr("title",orgSelfName); 
				if(orgSelfName.length>10)orgSelfName=orgSelfName.substring(0, 7) + "...";
				$("#currentOrgName").html(orgSelfName);
               
				//$("#currentOrgName").html(orgSelfName); 
			}

			$(obj).addClass("current").siblings().removeClass("current");
    	}
    }
};


/**
显示在线人数
*/
function showUserNumInfo(){
	//
    var result = "0;0";
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/public/desktop/ajax_getUserNum.jsp",
        async: false,
		dataType: 'text',
		success: function(data){
			result = data;
		}
	});	
	return result;
};


/**
$(".wh-hd-r-nav li:nth-child(2n)").hover()
显示在线人数
*/
function showUserNum(){
	//
	var result =showUserNumInfo();
	var userArr=result.split(";"); 
	$("#alluserNum").html(userArr[0]);
	$("#nowuserNum").html(userArr[1]);
};

//设置个人状态
function setDefineStatesByStatusId(statusId,obj){
	var vstatusId = statusId;
    var vherf = whirRootPath+"/StatusAction!addStatus.action?statusClassId="+statusId;
    openWin({url:vherf,width:600,height:300,winName:'changeStatus'});
};

/**
选择已经选择的状态名
*/
function showDestopStatuName(name){
	//
    name=name.replace(/\</g,'&lt;').replace(/\>/g,'&gt;'); 
    $("#desktop_userstatus_em").attr("title",name);
	$("#desktop_userstatus_em").html(name);
};


/**显示在线人数*/
function openUserList(){
	var ww=screen.width;
	var hh=screen.height;

	var leftP=ww-715;
	var topP=hh-600;
	if(hh<=600){
		hh=360;
		topP=170;
	}else{
		hh=420;
	}

	openWin({url:whirRootPath+'/realtimemessage!onlinelist.action?fromtype=index',width:700,height:hh,winName:'userList'});
};



/**
设置 字号大小
*/
function updatePagaFontSize(size){
	 $.ajax({
			type: 'POST',
			url: whirRootPath+"/public/desktop/ajax_setUserFontSize.jsp?fontSize="+size,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!="1"){
					//whir_alert(comm.failure);
				}else{
				   var url = whirRootPath + "/desktop.jsp" +'?date='+Math.random();
                   location_href(url); 
				}
			}
	  }); 
}


/**
 打开内容联系人
*/
function openInnerUser(){
	// 
	jumpnew('/modules/personal/personal_menu.jsp?expNodeCode=innerPersonList','PersonInnerAction!innerPersonList.action');
};

/**
选择默认的个人门户
*/
function chooseDefaultMyLayout(){
    var clickFirst=$("#desktop_hidden_isfirstClick").val();  
    if(clickFirst=="0"){
		//"欢迎使用\“我的门户\”，您可以在此根据个人使用偏好设置门户内容，是否将其默认为OA登陆后的门户（个人门户设置中可关闭该默认）？"
        whir_confirm(comm.desktop_welcomeself, 
	    function(){//确定
			setIsNeedSelfLayout("1");
            jumpnew(whirRootPath+'/modules/personal/personal_menu.jsp?expNodeCode=selfLayout',whirRootPath+'/PortalLayout!homePage.action?type=personal');
		}
		,function(){
			//取消
			setIsNeedSelfLayout("2");
			chooseMySelfLayoutView();
		});      
	}else{
		chooseMySelfLayoutView();
	}


}

function  chooseMySelfLayoutView(){
	//defaultId   为：如果有默认的 否则为第一个。
	var defaultId=$("#desktop_hidden_defaultMyLayoutId").val();
	if(defaultId!=""&&defaultId!="null"){
		selectLayout(defaultId);
	}else{
	    jumpnew(whirRootPath+'/modules/personal/personal_menu.jsp?expNodeCode=selfLayout',whirRootPath+'/PortalLayout!homePage.action?type=personal');
	} 
	return defaultId;
}


//是否使用个人门户
function setIsNeedSelfLayout(status){
	  $("#desktop_hidden_isfirstClick").val(status);
	  $.ajax({
			type: 'POST',
			url: whirRootPath+"/public/desktop/ajax_setFirstClickSelf.jsp?status="+status,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!="1"){
					//whir_alert(comm.failure);
				}
			}
	  }); 
}

/**
显示或者影藏提醒类型
*/
function  showhideRemindModule(obj){
	var name=$(obj).parent().attr("remindModule"); 
	var realObj=$("#desktop_remind_editshowhide_div > div[remindModule='"+name+"'] > span");
	if($(obj).hasClass('show')){
		//是当前的提醒 显示
		$(realObj).removeClass("show");
		$(realObj).html(comm.desktop_hide); //"隐藏"
		$("#desktop_remindModule1_div > p[remindModule='"+name+"']").show().attr("isview","1");
		$("#desktop_remindmodule_div > div[remindModule='"+name+"']").show().attr("isview","1");
	}else{
		var length=$("#desktop_remindModule1_div p[isview='1']").length;
		if(length==1){
			 alert(comm.desktop_keeponeremind);//alert("请至少保留1个提醒项。");
			 return;
		} 
		$(realObj).addClass("show");
		$(realObj).html(comm.desktop_show);//"显示"
		$("#desktop_remindModule1_div > p[remindModule='"+name+"']").hide().attr("isview","0");
		$("#desktop_remindmodule_div > div[remindModule='"+name+"']").hide().attr("isview","0");

		setRemindNumByModuleId(name,0);
	}  
	changeRemindModule();
	setAllRemindNum();

	//refresh remind num
	$('#iframe2').attr('src', $('#iframe2').attr('src'));
};

/**
保存提醒类型到数据库
*/
function  changeRemindModule(){
    var  modules=getRemindModule();  
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/public/desktop/ajax_setRemindModule.jsp?remindModules="+modules,
        async: true,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!="1"){
				whir_alert(comm.failure);
			}
		}
	});
};

/**
获取当前设置的需要提醒的模块
*/
function  getRemindModule(){
    var  modules=""; 
	$("#desktop_remindModule1_div p[isview='1']").each(function(){   
		modules+="@"+$(this).attr("remindModule") +"@"; 
	});
	return modules;
}

/**
设置 每个模块的提醒数目
*/
function  setRemindNumByModuleId(moduleId,num){
	if(num==null||num==""||num=="null"){
	   num="0";
	}
	
    $("#desktop_remindModule1_div > p[remindModule='"+moduleId+"'] > span").html("("+num+")"); 
    
	$("#desktop_remindmodule_div > div[remindModule='"+moduleId+"'] > span").html(num);
}

function setAllRemindNum(){
    var  allNums=0; 
	$("#desktop_remindModule1_div p[isview='1'] > span").each(function(){   
		 var  numstr=$(this).html();
		 allNums+=parseInt(numstr.substring(1,numstr.length-1));
	}); 

	$("#desktop_all_remindNum_span").removeClass('wh-sys-warn-num'); 
	$("#desktop_all_remindNum_a").removeClass('on');
	if(allNums==0){
		allNums="";
	}else{
	     $("#desktop_all_remindNum_span").addClass("wh-sys-warn-num");
		 $("#desktop_all_remindNum_a").addClass('on');

		 //add 
        var old_nums = $("#desktop_all_remindNum_span").text();
        if(old_nums != allNums){
            $('#desktop_all_remindNum_a').css({
            "-webkit-box-shadow":"0 0 0 20px transparent",
            "box-shadow":"0 0 0 20px transparent",
            "-webkit-transform":"translate3d(0,0,0)",
            "transform":"translate3d(0,0,0)",
            "-webkit-box-shadow":"0 0 0 0 rgba(152,205,243,.5)",
            "box-shadow":"0 0 0 0 rgba(152,205,243,.5)",
            "-webkit-transition":"all .4s linear",
            "-o-transition":"all .4s linear",
            "transition":"all .4s linear"
            });

            setTimeout(function(){$('#desktop_all_remindNum_a').removeAttr("style");}, 1000);
        }
	}
	$("#desktop_all_remindNum_span").html(allNums);
}

/**

 $(".wh-hd-custom-menu-btn").click(function(){}

根据取出来的所有men
*/
function showEditMenuInfo(){
	//编辑栏的顶部 菜单
	var html=$("#desktop_edit_ul").html();  
	var needAddNew_top=false;
	var needAddNew_bottom=false;
	//不为空 说明已经添加了，不需要再加了
	if(html==""){
		needAddNew_top=true;
		needAddNew_bottom=true;
	} 

    //编辑  顶部
    $("#show_menu_top_dl > dd:not(.wh-hd-menu-btn):not(.wh-hd-l-gateway)").each(function(){
		if(needAddNew_top){
			var liInfo="<li><div class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-del\">"+$(this).html()+"</div></li>"; 
		    liInfo=liInfo.replace("class=\"wh-hd-la\"",""); 
			$("#desktop_edit_ul").append(liInfo);
		}  
		/* 
		  <dd id="dd_menu_<%=menuCode%>"><a href="#"   onclick="xx" id="menu_<%=menuCode%>" menuId="<%=menuObj[4]%>" title="<%=menuName%>"><i class="fa <%=menuClass%> fa-color"></i><span><%=menuName%></span></a></dd>  
		  加到 
		 <li><div  class="wh-hd-custom-menu-d wh-hd-custom-menu-d-del"><a href=""><i class="fa fa-desktop"></i><span>综合办公七个字</span></a></div></li>
		*/
		//<a href="" class="wh-hd-la"><i class="fa fa-comments-o fa-color"></i><span>信息</span></a>
		// <li><div class="wh-hd-custom-menu-d"><a href=""><i class="fa fa-home fa-color"></i><span>门　　户</span></a><i class="fa fa-times"></i></div></li>
	}); 

    
   if(needAddNew_bottom){
		//编辑  底部
		$("#menu_hidden_ul >li >div").each(function(){  
			 /*<li><div class="wh-hd-custom-menu-d"><a href="#" onclick="<%if(openMainType.equals("iframe")){%>jumpnew('<%=_leftUrl%>','<%=_rightUrl%>');<%}else{%>window.open('<%=_rightUrl%>');<%}%>return false;" id="menu_<%=menuCode%>"  menuId="<%=menuObj[4]%>" title="<%=menuName%>"><i class="fa <%=menuClass%> fa-color"></i><span><%=menuName%></span></a></div></li>
			
			 改为： 
			 <li><div  class="wh-hd-custom-menu-d wh-hd-custom-menu-d-add"><a href=""><i class="fa fa-weibo"></i><span>微博</span></a></div></li> 
			  */ 			
			  var liInfo="<li><div  class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-add\">"+$(this).html()+"</div></li>"; 
			  $("#desktop_edit_ul").append(liInfo); 
		});
	} 

    //给编辑区的 底部菜单 加上 自动加加号的事件
	addAddImage();  
	//给编辑区的 顶部菜单 加上 remove的事件
	addRemoveImage();
};


/**
给编辑区的 底部菜单 加上 自动加加号的事件
*/
function addAddImage(){
	/*var itag = '<i class="fa fa-plus" onclick="addMenuTop(this);return false;"></i>';
    $("#edit_menu_bottom_div .wh-hd-custom-menu-d").hover(function(){
        $(this).append(itag);
    },function(){
        $(this).find('.fa-plus').remove();
    });*/

	var itag = '<i class="fa fa-plus" onclick="addMenuTop(this);return false;"></i>';
    $(".wh-hd-menu-add .wh-hd-custom-menu-d-add").hover(function(){
        $(this).append(itag);
    },function(){
        $(this).find('.fa-plus').remove();
    });  
};

/**
给编辑区的 顶部菜单 加上 remove的事件
*/
function  addRemoveImage(){
   /* var iremove= '<i class="fa fa-times" onclick=\"removeTopMenu(this);return false;\" ></i>';
    $("#edit_menu_top_ul .wh-hd-custom-menu-d").hover(function(){
        $(this).append(iremove);
    },function(){
        $(this).find('.fa-times').remove();
    });*/
	var iremove = '<i class="fa fa-times" onclick="removeTopMenu(this);return false;" ></i>';
    $(".wh-hd-menu-add .wh-hd-custom-menu-d-del").hover(function(){
        $(this).append(iremove);
    },function(){
        $(this).find('.fa-times').remove();
    }) 
}


/**
增加菜单到外部（主部分）
*/
function addMenuTop(obj){ 
    //a标签中 menuId
	var menu_a_obj=$(obj).parent().find("a");
	var a_menuId=menu_a_obj.attr("id");
	var mmmMenuId=menu_a_obj.attr("menuId");
	var dd_menuId="dd_"+a_menuId; 
 
    //最多加5个
    var length=$("#desktop_edit_ul >li >div.wh-hd-custom-menu-d-del").length; 


	

//    if(kw<140){
//	//if(length==4){
//	    var firstMenu=$("#desktop_edit_ul >li >div.wh-hd-custom-menu-d-del").eq(0);
//		var firstMenu_a=firstMenu.find("a");
//	    var first_a_menu_Id=firstMenu_a.attr("id");
//        //编辑区 顶部删除第一个 
//        firstMenu.parent().remove();
//		
//
//		//显示区 顶部删除第一个 
//		$("#dd_"+first_a_menu_Id).remove(); 
//
//	    //显示区 隐藏区加菜单
//	    $("#menu_hidden_ul").append("<li><div class=\"wh-hd-custom-menu-d\">"+firstMenu_a.prop("outerHTML")+"</div></li>");
//
//
//	    //编辑区 底部加菜单  
//        $("#desktop_edit_ul").append("<li><div class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-add\">"+firstMenu_a.prop("outerHTML")+"</div></li>"); 
//
//		//给编辑区的 底部菜单 加上 自动加加号的事件
//	    addAddImage();
//	}
	 

   /* alert(menu_a_obj.html());
	  alert(menu_a_obj.prop("outerHTML"));
	 alert(menu_a_obj.prop("innerHTML"));*/
    //编辑区 顶部新增 
	//<li><div class="wh-hd-custom-menu-d"><a href="####"><i class="fa fa-home fa-color"></i><span>门户</span></a><i class="fa fa-times" onclick="alert(111111)"></i></div></li>
	//$("#desktop_edit_ul").append("<li><div class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-del\">"+menu_a_obj.prop("outerHTML")+"</div></li>");
    
    //编辑区 顶部新增 
    $("#desktop_edit_ul >li >div.wh-hd-custom-menu-d-del").last().parent().after("<li><div class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-del\">"+menu_a_obj.prop("outerHTML")+"</div></li>");
	//$(‘.first’).insertAfter($(‘.last’));


	//显示区 顶部新增   
    //$("p").prev(".selected") 
    $("#menu_hidden_dd").before("<dd id=\""+dd_menuId+"\">"+menu_a_obj.prop("outerHTML")+"</dd>");
    
    // 
	//编辑区 底部 reomve
	$(obj).parent().parent().remove();


	//显示区 底部remove
    $("#menu_hidden_ul a[menuId='"+mmmMenuId+"']").parent().parent().remove();


    //给编辑区的 顶部菜单 加上 remove的事件
	addRemoveImage();

	changeMenu();
	
	var  allw=$("#desktop_container_div").width();//$("#desktop_container_div").width();
	var  aw=$("#desktop_logo_a").outerWidth();
	var  dlw=$("#show_menu_top_dl").width();
	var  ulw=$("#desktop_right_ul").width();

	var kw=allw-aw-dlw-ulw;
	//alert(kw);
	while(kw<100){
		 var firstMenu=$("#desktop_edit_ul >li >div.wh-hd-custom-menu-d-del").eq(0);
			var firstMenu_a=firstMenu.find("a");
		    var first_a_menu_Id=firstMenu_a.attr("id");
	        //编辑区 顶部删除第一个 
	        firstMenu.parent().remove();
			

			//显示区 顶部删除第一个 
			$("#dd_"+first_a_menu_Id).remove(); 

		    //显示区 隐藏区加菜单
		    $("#menu_hidden_ul").append("<li><div class=\"wh-hd-custom-menu-d\">"+firstMenu_a.prop("outerHTML")+"</div></li>");


		    //编辑区 底部加菜单  
	        $("#desktop_edit_ul").append("<li><div class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-add\">"+firstMenu_a.prop("outerHTML")+"</div></li>"); 

			//给编辑区的 底部菜单 加上 自动加加号的事件
		    addAddImage();
		      allw=$("#desktop_container_div").width();//$("#desktop_container_div").width();
			  aw=$("#desktop_logo_a").outerWidth();
			  dlw=$("#show_menu_top_dl").width();
			  ulw=$("#desktop_right_ul").width();
			  kw=allw-aw-dlw-ulw;
			// alert(kw);
	} 
};


/**
删除顶部的菜单
*/
function removeTopMenu(obj){

	 var length=$("#desktop_edit_ul >li >div.wh-hd-custom-menu-d-del").length;
	 if(length==1){
		 alert(comm.desktop_keeponemenu);//"请至少保留1个菜单"
		 return;
	 }
	 //<li> <div  class="wh-hd-custom-menu-d"><a href="" id="menu_xxxx"><i class="fa fa-comments-o fa-color "></i><span>信息</span></a><i class="fa fa-times"></i></div>   </li>    
     //a标签中 menuId
	 var menu_a_obj=$(obj).parent().find("a");
	 var a_menuId=menu_a_obj.attr("id");
	 var dd_menuId="dd_"+a_menuId; 

	 //显示区 隐藏区加菜单
	 $("#menu_hidden_ul").append("<li><div class=\"wh-hd-custom-menu-d\">"+menu_a_obj.prop("outerHTML")+"</div></li>");
	 //编辑区 底部加菜单  
     $("#desktop_edit_ul").append("<li><div class=\"wh-hd-custom-menu-d wh-hd-custom-menu-d-add\">"+menu_a_obj.prop("outerHTML")+"</div></li>"); 

	 //给编辑区的 底部菜单 加上 自动加加号的事件
	 addAddImage();
     
	 //编辑区 顶部 reomve
	 $(obj).parent().parent().remove();


     //显示区 顶部 reomve
     $("#"+dd_menuId).remove();  

	 changeMenu();
};


/**
保存选择的菜单到数据库
*/
function changeMenu(){
	var outMenuId = "";
	var inboxMenuId = "";  

    var menuArr = new Array();
	//  顶部
	var index=0;
    $("#show_menu_top_dl > dd:not(.wh-hd-menu-btn):not(.wh-hd-l-gateway) a ").each(function(){ 
		var menuId=$(this).attr("menuId"); 
		if(menuId!=null&&menuId!=""&&menuId!="null"){
			//outMenuId += menuId + ',';
			menuArr[index]=menuId;
			index++;
		}
	}); 
    

	for(var i=menuArr.length-1;i>=0;i--){
	    outMenuId += menuArr[i] + ',';
	}


    // 底部
	index=0;
	$("#menu_hidden_ul >li a ").each(function(){ 
		var menuId=$(this).attr("menuId");  
		if(menuId!=null&&menuId!=""&&menuId!="null"){
			menuArr[index]=menuId;
			index++;
		} 
	});  
	
	for(var i=menuArr.length-1;i>=0;i--){
	    inboxMenuId += menuArr[i] + ',';
	}



    if(outMenuId!=""){
		outMenuId = outMenuId.substring(0,outMenuId.length-1);
	 } 
	inboxMenuId = inboxMenuId.substring(0,inboxMenuId.length-1); 
 
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/PortalMenu!changeMenu.action?outMenuId="+outMenuId+"&inboxMenuId="+inboxMenuId,
        async: true,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!="1"){
				whir_alert(comm.failure);
			}
		}
	});
};
 



 //登录exchange邮箱
function DirectLoginCommon(vstrServer, vstrUsername, vstrPassword, dest) {
	$.ajax({
		type:"post",
		url:whirRootPath + "/getUserInfo.jsp",
		async:true,
		dataType:"Json",
		success:function(data){
			//data = eval("("+data+")");
			var strUrl = "https://" + vstrServer + "/owa/auth/owaauth.dll";
			var strExchange = { destination: 'https://' + vstrServer + '/owa/'+dest, 
				flags: '0', forcedownlevel: '0', 
				trusted: '0', isUtf8: '1', username:data.account, password: data.password 
			};
			var myForm = document.createElement("form");
			myForm.method = "post";
			myForm.action = strUrl;
            myForm.enctype = "application/x-www-form-urlencoded";
			myForm.target = "_blank";

			for (var varElement in strExchange) {
				var myInput = document.createElement("input");
				myInput.setAttribute("name", varElement);
                myInput.setAttribute("type", "hidden");
				myInput.setAttribute("value", strExchange[varElement]);
				myForm.appendChild(myInput);
			} 
			document.body.appendChild(myForm);
			myForm.submit();
			document.body.removeChild(myForm);
		},
		error:function(s,d,f){
			alert(22);
		}
	});

};