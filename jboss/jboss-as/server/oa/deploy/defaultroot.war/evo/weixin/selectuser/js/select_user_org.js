//列表页面标识emp:用户列表，org：组织列表
var pageFlag = 'emp';
//用户记录查询偏移量和是否有下一页标识
var offset = $('#offset').val();
var nomore = $('#nomore').val();
//组织记录查询偏移量和是否有下一页标识
var orgNomore = $('#orgNomore').val();
var orgOffset = $('#orgOffset').val();
//选择表单id值的id
var selectId = $('#selectId').val();
//选择表单name值的id
var selectName = $('#selectName').val();
//单选/多选标识 0：单选，1：多选
var selectType = $('#selectType').val();
//已选择的用户名
var selectNameVal = $("#selectNameVal").val();
//已选择的用户id
var selectIdVal = $("#selectIdVal").val();
var idValArray = selectIdVal.split(',');
var range = $("#range").val();
var selectIndex = 0;
$(function() {
    var headerBtn = $("#headerBtn a");
    headerBtn.click(function(){
        selectIndex = $(this).index();
        headerBtn.eq(selectIndex).addClass("active").siblings().removeClass("active");
        if(selectIndex==0){
        	//改变占位文字为用户搜索
        	$('#search_header').show();
            $('article.wh-article').show();
            $('aside.wh-category').hide();
            //$("#org_list i.fa-check-circle").removeClass('fa-check-circle-active');
            //selectNameVal = '';
            //selectIdVal = '';
            pageFlag = 'emp';
		    //判断是否显示下拉加载区域
		    if(nomore){
				$(".wh-load-box").show();
			}else{
				$(".wh-load-box").hide();
			}
        }else if(selectIndex==1){
        	//改变占位文字为组织搜索
        	$('#search_header').hide();
            $('aside.wh-category').show();
            $('article.wh-article').hide();
            //$("#all_user_list i.fa-check-circle").removeClass('fa-check-circle-active');
            //selectNameVal = '';
            //selectIdVal = '';
            pageFlag = 'org';
		    //判断是否显示下拉加载区域
		    if(orgNomore){
				$(".wh-load-box").show();
				$(".wh-load-tap").html("上滑加载更多");
				$(".wh-load-md").hide();
			}else{
				$(".wh-load-box").hide();
			}
        }
    });
    //绑定用户选择点击事件
	bindEmpSelect();
    //判断是否显示下拉加载区域
    if(nomore){
		$(".wh-load-box").show();
	}else{
		$(".wh-load-box").hide();
	}
    //设置icon样式类
	setIconClass($('.icon'));
});

//绑定用户选择点击事件
function bindEmpSelect(){
    //$("#all_user_list i.fa-check-circle").each(function(){
	var empId = '';
	var empName = '';
    $("i.fa-check-circle").each(function(){
    	$(this).unbind('click');
    	$(this).bind('click',function(){
    		empId = $(this).data('empid');
    		empName = $(this).data('empname');
	    	//单选时选择方式
	    	if(selectType == '0'){//单选
	        	$(this).addClass('fa-check-circle-active');
	        	$('i.fa-check-circle').not(this).removeClass('fa-check-circle-active');
	        	selectIdVal = empId;
	        	selectNameVal = empName;
	    	}else if(selectType == '1'){//多选 
	    		if($(this).hasClass('fa-check-circle-active')){
	    			$(this).removeClass('fa-check-circle-active');
	    			selectIdVal = selectIdVal.replace(empId,'');
	    			selectNameVal = selectNameVal.replace(empName,'');
	    		}else{
			        $(this).addClass('fa-check-circle-active');
			        if(selectIdVal.indexOf(empId) == -1 && selectNameVal.indexOf(empName) == -1){
		    			selectIdVal += empId;
		    			selectNameVal += empName;
			        }
	    		}
	    	}
    	});
    	//回显已勾选的数据
		setSelectVal(this,$(this).data('empid'));
    });
}

//回显已勾选的数据
function setSelectVal(obj,curEmpId){
	if(idValArray){
		for(var i=0,length=idValArray.length; i<length; i++){
			if(idValArray[i]+',' == curEmpId){
				$(obj).addClass('fa-check-circle-active');
			}
		}
	}
}

//全部人员列表页加载下一页数据
$(window).scroll(function(){
    var scrollTop = $(this).scrollTop();
    var scrollHeight = $(document).height();
    var windowHeight = $(this).height();
    if(scrollTop + windowHeight == scrollHeight){
    	if(pageFlag == 'emp'){
	    	//加载下一页用户数据
			loadNextEmpData();
    	}else if(pageFlag == 'org'){
	    	//加载下一页组织数据 
    		loadNextOrgData();
    	}
    }
});

//加载下一页人员
function loadNextEmpData(){
	if($('#all_user_list').data('loaduserflag') == '1'){
		return;
	}
	$('#all_user_list').data('loaduserflag','1');
	if(nomore){
		var searchTitle = $('#queryCondition').val();
		$(".wh-load-md").css("display","block");
		$(".wh-load-tap").html("正在加载...");
		$.ajax({
			url : '/defaultroot/person/searchUser.controller',
			data : {'pageSize' : offset,'nomore' : nomore,'title' : searchTitle,'range' : range},
			type : 'post',
			success : function(data){
				offset = $($(data)[10]).val();
				nomore = $($(data)[14]).val();
				$('#all_user_list').append($("ul[name='all_user_list'] li",data));
				//绑定生成的点击事件
				bindEmpSelect();
				if(nomore){
					$(".wh-load-tap").html("上滑加载更多");
					$(".wh-load-box").css("display","block");
					$(".wh-load-md").css("display","none");
				}else{
					$(".wh-load-box").css("display","none");
				}
				$('#all_user_list').data('loaduserflag','0');
			}
		});
	}
}

//加载下一页组织
function loadNextOrgData(){
	if($('#org_list').data('loadorgflag') == '1'){
		return;
	}
	$('#org_list').data('loadorgflag','1');
	if(orgNomore){
		var searchTitle = $('#queryCondition').val();
		$(".wh-load-md").show();
		$(".wh-load-tap").html("正在加载...");
		$.ajax({
			url : '/defaultroot/person/searchOrg.controller',
			data : {'pageSize' : orgOffset,'nomore' : orgNomore,'title' : searchTitle,'range' : range},
			type : 'post',
			success : function(data){
				orgOffset = $($(data)[12]).val();
				orgNomore = $($(data)[18]).val();
				$('#org_list').append($("ul[name='org_list'] li",data));
				if(orgNomore){
					$(".wh-load-tap").html("上滑加载更多");
					$(".wh-load-box").show();
					$(".wh-load-md").hide();
				}else{
					$(".wh-load-box").hide();
				}
				$('#org_list').data('loadorgflag','0');
				//设置icon样式类
				setIconClass($("i[class=icon]"));
			}
		});
	}
}

//是否已经加载标志（防止重复加载）：0：未加载，1：已加载
var loadNextOrgAndSubEmpFlag = '0';
//加载下级组织和当前用户
function loadNextOrgAndSubEmp(parentOrgId,obj){
	if($(obj).siblings() && $(obj).siblings().eq(0).css("display") == "block"){
		$(obj).siblings().hide();
		$(obj).removeClass("wh-cate-libox-active");
		return;
	}else if($(obj).siblings() && $(obj).siblings().eq(0).css("display") == "none"){
		$(obj).siblings().show();
		$(obj).addClass("wh-cate-libox-active");
		return;
	}
	if(loadNextOrgAndSubEmpFlag == '1'){
		//若已经加载则不允许再次加载
		return;
	}
	loadNextOrgAndSubEmpFlag = '1';
	$.ajax({
	    type: 'post',
	    data : {'range' : range},
	    url: '/defaultroot/person/getUserAndOrg.controller?orgId='+parentOrgId,
	    dataType: 'text',
	    success: function(data){
			if(!data){
				return;
			}
			var jsonData = eval("("+data+")");
			if(!jsonData){
				return;
			}
			//用户列表数据
			var personArray = jsonData[0].userList;
			//组织列表数据
			var orgArray = jsonData[1].orgList;
			var result = '<ul>';
            var personList = '';
            var addDom = '';
            if(personArray){
	    		// 判断头像数据是否为空
	    		var empLivingPhoto = "";
	    		personList = '<div class="wh-article-lists"><ul>';
		        for(var j=0,length=personArray.length;j<length;j++){
	        		empLivingPhoto = "/defaultroot/upload/peopleinfo/"+personArray[j].empLivingPhoto;
	        		if(!personArray[j].empLivingPhoto){
	        			empLivingPhoto = '/defaultroot/evo/weixin/images/head.png';
	        		}
		        	personList += 
						'<li>'
			        		+'<i class="fa fa-check-circle" data-empid="'+personArray[j].userId+'," data-empname="'+personArray[j].userName+',"></i>'
				        	+'<strong class="contact-icon">'
				        		+'<img src="'+empLivingPhoto+'"/>'
				        	+'</strong>'
				        	+'<p>'
				        		+'<a class="contact-author">'+personArray[j].userName+'</a>'
				        	+'</p>'
		        		+'</li>';	
		        }
		        personList += '</ul></div>';
            }
            addDom += personList;
            if(orgArray){
            	//判断是否有下级组织
            	var childOrgDom = '';
            	var divAddClass = '';
            	var iconClass;
	            for(var i = 0; i < orgArray.length; i++){
	            	iconClass = getIconClass();
	            	if(orgArray[i].orgHasJunior == '1'){
	            		childOrgDom = '下级组织'+orgArray[i].childOrgNum;
	            	}
	            	if(orgArray[i].orgHasJunior == '0' || orgArray[i].orgUserNum != '0'){
	            		divAddClass = ' wh-cate-libox-empty';
	            	}
	            	result += '<li><div class="wh-cate-libox"'+divAddClass+' onclick="loadNextOrgAndSubEmp('+orgArray[i].orgId+',this);">'
					        	+'<a>'
					        	+'<i class="icon '+iconClass+'">'+orgArray[i].orgName.substring(0,1)+'</i>'
						        	+'<p>'
								        +'<strong>'+orgArray[i].orgName+'</strong>'
								        +'<span>人数'+orgArray[i].orgUserNum+'&nbsp;&nbsp;'+childOrgDom+'</span>'
							        +'</p>'
						        +'</a>'
					        +'</div></li>';
	            }
            }
            addDom += result + '</ul>';
            //将拼接的dom放入指定位置
            $(obj).after(addDom);
            //绑定用户选择点击事件
			bindEmpSelect();
            //重置加载标识
            loadNextOrgAndSubEmpFlag = '0';
	    },
	    error: function(xhr, type){
	        alert('数据查询异常！');
	    }
	});
}

//清空
function clearSelect(){
	$("i.fa-check-circle-active").removeClass("fa-check-circle-active");
	selectNameVal = '';
    selectIdVal = '';
}

//确定
function confirmSelect(){
	nomore = '';
	orgNomore = '';
	var $select = $("i.fa-check-circle-active");
	/*
	var empId = '';
	var empName = '';
	$select.each(function(){
		empId += $(this).data("empid")== undefined ? "" : $(this).data("empid");
		empName += $(this).data("empname")== undefined ? "" : $(this).data("empname");
	});
	*/
	$("input[id='"+selectId+"']").val(selectIdVal);
	$("input[id='"+selectName+"']").val(selectNameVal);

	if(typeof ( selectCallBack ) == "function" ){
		selectCallBack( $("input[id='"+selectName+"']"),$("input[id='"+selectId+"']") );
	}

	hiddenContent(1);
}


//查询用户数据
function searchEmpData(searchTitle){
	if($('#all_user_list').data('loaduserflag') == '1'){
		return;
	}
	$('#all_user_list').data('loaduserflag','1');
	$(".wh-load-md").css("display","block");
	$(".wh-load-tap").html("正在加载...");
	$.ajax({
		url : '/defaultroot/person/searchUser.controller',
		data : {'pageSize' : '0','title' : searchTitle,'range' : range},
		type : 'post',
		success : function(data){
			offset = $($(data)[10]).val();
			nomore = $($(data)[14]).val();
			var $add_li = $("ul[name='all_user_list'] li",data);
			if($add_li[0]){
				$('#all_user_list').append($("ul[name='all_user_list'] li",data));
			}else{
				$('#all_user_list').append('<li>系统没有查询到用户记录！</li>');
			}
			//绑定生成的点击事件
			bindEmpSelect();
			if(nomore){
				$(".wh-load-tap").html("上滑加载更多");
				$(".wh-load-box").css("display","block");
				$(".wh-load-md").css("display","none");
			}else{
				$(".wh-load-box").css("display","none");
			}
			$('#all_user_list').data('loaduserflag','0');
		}
	});
}

//绑定查询框回车事件
$('#queryCondition').keydown(function(event){
	var searchTitle = $('#queryCondition').val();
	if(event.keyCode == 13){ //绑定回车 
		if((searchTitle.length > 0 && !(searchTitle.trim())) || /[@#\$%\^&\*]+/g.test(searchTitle)){
			alert('非法字符，请正确填写搜索标题！');
			return false;
		}
		if(selectIndex == 0){
			$('#all_user_list').empty();
			searchEmpData(searchTitle);
		}
	} 
});