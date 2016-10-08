Date.prototype.Format = function(fmt) 
{ //author: meizz 
  var o = { 
    "M+" : this.getMonth()+1,                 //月份 
    "d+" : this.getDate(),                    //日 
    "H+" : this.getHours(),                   //小时 
    "m+" : this.getMinutes(),                 //分 
    "s+" : this.getSeconds(),                 //秒 
    "q+" : Math.floor((this.getMonth()+3)/3), //季度 
    "S"  : this.getMilliseconds()             //毫秒 
  }; 
  if(/(y+)/.test(fmt)) 
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length)); 
  for(var k in o) 
    if(new RegExp("("+ k +")").test(fmt)) 
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length))); 
  return fmt; 
}

jQuery(function ($) {
	$('.artZoom').artZoom({
		path: '/defaultroot/modules/comm/microblog/images',	// 设置artZoom图片文件夹路径
		preload: true,		// 设置是否提前缓存视野内的大图片
		blur: true,			// 设置加载大图是否有模糊变清晰的效果
		
		// 语言设置
		left: weibo.left_rotation,		// 左旋转按钮文字
		right: weibo.right_rotation,		// 右旋转按钮文字
		source: weibo.artwork		// 查看原图按钮文字
	});
	
	//$('#myEmail').html(1987 + '.tangbin@' + 'gmail.com');
});

var highLightIndex = -1;
var contentobj = null;


function DrawImg(obj,boxWidth,boxHeight) { 
	
	var img = new Image();
	img.src = obj.src;
	
	
	var imgWidth  = img.width; 
	var imgHeight = img.height;
	
	var bili = imgWidth/imgHeight ;
	if(imgWidth > boxWidth){
		imgWidth = boxWidth ;
		imgHeight = imgWidth/bili ;
	}
	if(imgHeight > boxHeight){
		imgHeight = boxHeight ;
		imgWidth = imgHeight*bili ;
	}
	//jQuery(obj).width(imgWidth);
	//jQuery(obj).height(imgHeight); 
	//20151007-by jqq 固定长宽
	jQuery(obj).width(boxWidth);
	jQuery(obj).height(boxHeight);
	//jQuery("#image_width").val(imgWidth);
	//jQuery("#image_height").val(imgHeight);
	
} 



function fileupload(){   
		if($("#filePath").val()==""){   
			alert(weibo.select_picture);   
			return false;   
		} 
		var str = $("#filePath").val();
		var pos = str.lastIndexOf(".");
		var lastname = str.substring(pos+1,str.length);
		var allowfile = "gif,jpg,png";
        if (allowfile.indexOf(lastname.toLowerCase())<0){
			alert(weibo.image_type);
			return false;   
		}
		var file_name = str.substring(str.lastIndexOf("\\")+1,str.length);
		//jQuery("#upload_div").hide();
		jQuery("#facebox").hide(); 
		jQuery("#loading").show(); 
		jQuery.ajaxFileUpload({   
			url:"/defaultroot/uploadFile?folder=uploadMicroblog",   
			secureuri:false,   
			fileElementId:'filePath',   
			dataType: 'text/xml',              
			success: function (data) {   
				var arr = data.split(",");
				jQuery("#upload_img").attr("src",arr[1]);
				jQuery("#middleFile").val(arr[1]);
				jQuery("#bigFile").val(arr[2]);
				jQuery("#sourceFile").val(arr[3]);

				jQuery("#image_div").show();
				jQuery("#loading").hide(); 
				jQuery("#file_name").html(file_name); 

				var contentobj = jQuery("#add_weibo_div").find("#content");
				var content = jQuery(contentobj).val();
				if(jQuery.trim(content) == ""){
					contentobj.val(weibo.share_picture);
				}
				
			},error: function (data, status, e){   				
				alert(weibo.upload_failed);   
			}   
		}   
		);   
}   

function  deletePic(){
	jQuery('#face_upload').show();
	jQuery('#upload_div').show();
	jQuery('#facebox').show();	//20151009 -by jqq
	jQuery('#upload_img').attr('src','');	
	jQuery('#upload_img').parent().hide();
	
	
}

function showUpload(){
	if(jQuery('#face_upload').attr("display")=="" || jQuery('#face_upload').attr("display")=="block"){
		return false;
	}
	jQuery('#face_upload').show();
	jQuery('#upload_div').show();
	jQuery('#facebox').show();	//20151009 -by jqq 上传后该id块被隐藏了，再次使用上传时展示
	jQuery('#upload_img').attr('src','');
	jQuery('#upload_img').parent().hide();

}

 jQuery(document).ready(function() {
	
	
	jQuery(".user_photo").each(function(){
		jQuery(this).powerFloat({
			    //eventType: 'click',
			    target: "/defaultroot/user_card.vm?method=user_card&id="+jQuery(this).attr("id")+"&date="+Math.random(),
			    targetMode: "ajax",
				showDelay:800,
			    hoverHold:true,
			    edgeAdjust:true

		});		
	});	

	
	 
	 jQuery('#altxxx').bind('keyup', processKeyup);
	 //jQuery('#altxxx').bind('mouseout', clearDiv);
	 

	 
	var offset = eval(jQuery("#offset").val())*1+0;
	var recordCount = eval(jQuery("#recordCount").val())*1+0;
	if(recordCount <= offset || recordCount<=15){
		jQuery("#page_index").hide();
	}


	
});


function timedCount() {
    var now = new Date().Format("yyyy-MM-dd HH:mm:ss");
	var year = now.substring(0,4);
	var month = now.substring(5,7);
	var day = now.substring(8,10);
	var hour = now.substring(11,13);
	var minite = now.substring(14,16);
	var second = now.substring(17,19);
	var nowdate = new Date(year,month,day,hour,minite,second,0).getTime();
	
	jQuery('.wb_listbox').each(function(){
	       
		var time = "";
		var send_time = jQuery(this).find('#send_time').val(); 
		if(send_time==undefined){
			return ;
		}
		var year2 = send_time.substring(0,4);
		var month2 = send_time.substring(5,7);
		var day2 = send_time.substring(8,10);
		var hour2 = send_time.substring(11,13);
		var minite2 = send_time.substring(14,16);
		var second2 = send_time.substring(17,19);		
		var date = new Date(year2,month2,day2,hour2,minite2,second2,0).getTime();

		var between = (nowdate - date)/1000;
		var day1 = Math.round(between / (24 * 3600)-0.5);
		var hour1 = Math.round(between % (24 * 3600) / 3600-0.5);
		var minute1 = Math.round(between % 3600 / 60-0.5);
		var second1 = Math.round(between % 60 / 60-0.5);
		
		if(day != day2){
           day1 = 1;
       }

		if (day1==0 && hour1==0 && minute1==0) {
		   if(second1==0){
		       time = weibo.moment_ago;
		   }else{
		       time = second1+weibo.seconds_ago;
		   }
		}else if (day1==0 && hour1==0 ) {
	       time = minute1+weibo.minutes_ago;
		}else if (day1==0 ) {			
	       time = weibo.today+send_time.substring(11,16);
		}else {
	       time = send_time.substring(0,16);;
		}
		jQuery(this).find("#send_time_span").html(time);
		
	});
	setTimeout("timedCount()",180000) ;
}   


function  checkContent(obj,event){	
	var myEvent = event || window.event;
    var keyCode = myEvent.keyCode;
	if (keyCode == 13){ 
	    var rows = obj.rows ;
		if(rows<3){
			rows = rows +1 ;
		}else{
			rows = 3;
		}
		obj.rows = rows;
		var top = 60+17*(rows-1);
		jQuery("#face_upload").css("top",top+"px");

	}	
	var content = jQuery(obj).val();
	var len = 140;
	var v = 0;
	var content2 = "";
	if(content.length>0){
		for (var i = 0; i < content.length; i++) {
			var c = content.substring(i,i+1);
			if (content.charCodeAt(i)>128){
				len = len - 1;
			}else {
				v = v + 0.5 ;
				if(v==1){
				  len = len-1;
				  v = 0;
				}
			}
			if(len>=0){
			   content2 = content2+c;
			}
		}
	}
	
	if(len<0){
	   len = 0;
	   jQuery(obj).val(content2);
	}	
	jQuery("#limit").html(len);

	savePos(obj);

	processKeyupIndex(obj);

}

function addWeibo(obj){
	var contentobj = jQuery("#add_weibo_div").find("#content");
	var weiboContent = jQuery(contentobj).emotionsToHtml();	
	if(weiboContent==""){
		weiboContent = jQuery(contentobj).val();
	}
	
	if(jQuery.trim(contentobj.val()) == ""){
		//contentobj.attr("style", "background-color=#FFFCC");
		jQuery(contentobj).focus();
	}else{
		var img = "<br><a  href='"+jQuery("#bigFile").val()+"' rel='"+jQuery("#sourceFile").val()+"' ><img    src='"+jQuery("#middleFile").val()+"'  class='artZoom' /></a>" ;
		if(jQuery("#upload_img").attr("src")==""){
			img = "";
		}		
		
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/weibo_ajax.vm?method=add",
				data: "content="+encodeURIComponent(weiboContent)+img,
				contentType:"application/x-www-form-urlencoded;charset=UTF-8",
				success: function(msg){
					jQuery('#face_upload').hide();
					jQuery('#upload_div').hide();
					jQuery('#upload_img').attr('src','');
					jQuery('#upload_img').parent().hide();

					contentobj.val("");
					jQuery("#limit").html("140");
					 
					var type = jQuery("#type").val();
					
					if(type=='1' || type=='2'){			  
					  jQuery("#weibo_div").find("#current_latest_id").remove();
					  jQuery("#weibo_div").prepend(msg);
					  var offset = eval(jQuery("#offset").val())*1+1;
					  jQuery("#offset").val(offset);
					}
					

					jQuery("#panel").show();
					setTimeout("hidePanel()",1000);
					
					var weibo_count = eval(jQuery("#weibo_count_span").html())*1 + 1;
					jQuery("#weibo_count_span").html(weibo_count+"") ;
					window.location.reload();
				}
		});
	}
}


function hidePanel(){
	jQuery("#panel").hide();
}

/*
function selectMyConcernUser(obj){
	var start = document.getElementById("start").value;
	var content = jQuery("#content").html();
	var subcontent = content.substring(0,start);
	var subsubcontent1 = subcontent.substring(0,subcontent.lastIndexOf('@')+1);
	var subsubcontent2 = content.substring(start,content.length);
	jQuery("#content").html(subsubcontent1+jQuery(obj).html()+subsubcontent2);
	
	jQuery("#altxxx").hide();
	jQuery("#altxxx").html("");

}
*/

function showalt() {
var s=document.selection.createRange();
altxxx.style.pixelLeft=s.offsetLeft+5;
altxxx.style.pixelTop=s.offsetTop+3;
if(altxxx.style.visibility=='hidden')altxxx.style.visibility='visible';
jQuery("#altxxx").show();
//jQuery('#altxxx').children().eq(0).focus();
}


function savePos(textBox){
	var start =0;
	var end =0;
        //如果是Firefox(1.5)的话，方法很简单
        if(typeof(textBox.selectionStart) == "number"){
            start = textBox.selectionStart;
            end = textBox.selectionEnd;
        }
        //下面是IE(6.0)的方法，麻烦得很，还要计算上'\n'
        else if(document.selection){
            var range = document.selection.createRange();
			//20160624 -by jqq ie8浏览器进入后，上面range获取有问题，需要先focus焦点处理（ie8的bug）
			if(document.selection.type == "Text" || document.selection.type == "None") {      
				//window.alert('document.selection.type:['+document.selection.type+']')
				//document.getElementById(textBox.id).focus();
				document.getElementById("content").focus();
				range = document.selection.createRange();
			}
            if(range.parentElement().id == textBox.id){
                // create a selection of the whole textarea
                var range_all = document.body.createTextRange();
                range_all.moveToElementText(textBox);
                //两个range，一个是已经选择的text(range)，一个是整个textarea(range_all)
                //range_all.compareEndPoints()比较两个端点，如果range_all比range更往左(further to the left)，则           
		//返回小于0的值，则range_all往右移一点，直到两个range的start相同。
                // calculate selection start point by moving beginning of range_all to beginning of range
                for (start=0; range_all.compareEndPoints("StartToStart", range) < 0; start++)
                    range_all.moveStart('character', 1);
                // get number of line breaks from textarea start to selection start and add them to start
                // 计算一下\n
                for (var i = 0; i <= start; i ++){
                    if (textBox.value.charAt(i) == '\n')
                        start++;
                }
                // create a selection of the whole textarea
                 var range_all = document.body.createTextRange();
                 range_all.moveToElementText(textBox);
                 // calculate selection end point by moving beginning of range_all to end of range
                 for (end = 0; range_all.compareEndPoints('StartToEnd', range) < 0; end ++)
                     range_all.moveStart('character', 1);
                     // get number of line breaks from textarea start to selection end and add them to end
                     for (var i = 0; i <= end; i ++){
                         if (textBox.value.charAt(i) == '\n')
                             end ++;
                     }
                }
            }
        document.getElementById("start").value = start;
        document.getElementById("end").value = end;
}


	 



 function processKeyup(event) { 
     var myEvent = event || window.event;
     var keyCode = myEvent.keyCode;
     //处理上下键(up,down)
     if (keyCode == 38 || keyCode == 40) {
	 processKeyUpAndDown(keyCode);
	 //按下了回车键
     } else if (keyCode == 13){ 
	 processEnter();
     }else{
	 highLightIndex = -1;
	 processAjaxRequest(obj);
     }
 }

 function processKeyupIndex(obj) { 
     contentobj = obj ;      
     highLightIndex = -1;
     processAjaxRequest(obj);
 }


 function processAjaxRequest(obj){
	var content = jQuery(obj).val();  //jQuery("#content").html();		
	var start = document.getElementById("start").value ;
	var subcontent = content.substring(0,start);
	if(subcontent.indexOf('@')>=0){
		var subsubcontent = subcontent.substring(subcontent.lastIndexOf('@')+1,subcontent.length);
		if(subsubcontent!="" && subsubcontent.indexOf(" ") < 0){
			var name = subsubcontent; 
			jQuery("#altxxx").hide();
			jQuery("#altxxx").html("");
			jQuery.ajax({
				type: "POST",
				url: "/defaultroot/searchMyConcernUser.vm?method=searchMyConcernUser",
				data: "name="+encodeURIComponent(name)+"&date="+Math.random(),
				success: processAjaxResponse
			});				
		}else{
			jQuery("#altxxx").hide();
			jQuery("#altxxx").html("");
		}
	}
 }


 function processAjaxResponse(data) { 
	 if(jQuery.trim(data)=="")return;
     jQuery('#altxxx').html('').show();
     var words = data.split("-");   
     jQuery.each(words, function(i){
	 if(words[i]!=""){
		 var word_div = jQuery("<div style='width:10%;' ></div>");
		 word_div.html(words[i]);
		 word_div.hover(fnOver, fnOut);
		 word_div.click(getAutoText);
		 jQuery('#altxxx').append(word_div);
	 }
     });
     showalt();
 }

 function fnOver(){
     changeToWhite();
     jQuery(this).css('background-color', 'pink');
     //alert(jQuery(this).index());
     highLightIndex = jQuery(this).index();
 }


 function fnOut(){
    jQuery(this).css('background-color', 'white');
 }


 function getAutoText(){
     //有高亮显示的则选中当前选中当前高亮的文本
     if (highLightIndex != -1) {
	var start = document.getElementById("start").value;
	var content = jQuery(contentobj).val(); //jQuery("#content").html();
	var subcontent = content.substring(0,start);
	var subsubcontent1 = subcontent.substring(0,subcontent.lastIndexOf('@')+1);
	var subsubcontent2 = content.substring(start,content.length);
	jQuery(contentobj).val(subsubcontent1+jQuery.trim(jQuery(this).val())+" "+subsubcontent2);
	
	var str = subsubcontent1+jQuery.trim(jQuery(this).val())+" " ;		
	moveEnd(contentobj,str.length);

	jQuery("#altxxx").hide();
	jQuery("#altxxx").html("");
     }

 }

 function processEnter(){
	//alert(highLightIndex);
     if (highLightIndex != -1) {
	var start = document.getElementById("start").value;
	var content = jQuery(contentobj).val(); //jQuery("#content").html();
	//alert(content);
	var subcontent = content.substring(0,start);
	var subsubcontent1 = subcontent.substring(0,subcontent.lastIndexOf('@')+1);
	var subsubcontent2 = content.substring(start,content.length);
	jQuery(contentobj).val(subsubcontent1+jQuery.trim(jQuery('#altxxx').children().eq(highLightIndex).html())+" "+subsubcontent2);
	
	var str = subsubcontent1+jQuery.trim(jQuery('#altxxx').children().eq(highLightIndex).html())+" " ;		
	moveEnd(contentobj,str.length);

	jQuery("#altxxx").hide();
	jQuery("#altxxx").html("");             
     }
 }

 function processKeyUpAndDown(keyCode){
     var words = jQuery('#auto_div').children();
     var num = words.length;
     if (num <= 0) return;
     changeToWhite();
     highLightIndex = ((keyCode != 38 ? num + 1 : num - 1) + highLightIndex) % num;
     words.eq(highLightIndex).css('background-color', 'pink');
     //jQuery('#auto_txt').val(words.eq(highLightIndex).html());
 }


 function changeToWhite(){
     if (highLightIndex != -1) {
	jQuery('#altxxx').children().eq(highLightIndex).css('background-color', 'white');
     }
 }

function moveEnd(obj,len){
    obj.focus();	    
    if (document.selection) {
	var sel = obj.createTextRange();
	sel.moveStart('character',len);
	sel.collapse();
	sel.select();
    } else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
	obj.selectionStart = obj.selectionEnd = len;
    }
}


function clearDiv(){	
	jQuery("#altxxx").html("");  
	jQuery("#altxxx").hide();	
}

function searchIndex(weibo_user_id){
	//alert("/defaultroot/index.vm?method=list&offset=0&type=1&keyword="+encodeURI(jQuery("#keyword").val()));
	//alert("/defaultroot/index.vm?method=list&offset=0&type=1&keyword="+jQuery("#keyword").val());
	window.location.href="/defaultroot/index.vm?method=list&weibo_user_id="+weibo_user_id+"&offset=0&type=1&keyword="+encodeURI(jQuery("#keyword").val()) ;
}

function viewWeibo(type,obj,weibo_user_id){
	jQuery("#type").val(type);
	jQuery("#weibo_page_div").html("");
	jQuery("#loadTip").show();
	if(type==1){
		jQuery("#refresh_label").html("主页");
		jQuery("#add_part").show();
	}else if(type==0){
		jQuery("#refresh_label").html("关注微博");
		jQuery("#add_part").hide();
	}else if(type==2){
		jQuery("#refresh_label").html("我的微博");
		jQuery("#add_part").show();
	}else if(type==4){
		jQuery("#refresh_label").html("提到我的");
		jQuery("#add_part").hide();
	}
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/weibo_page_ajax_portal.vm",
		data: "offset=0&type="+type+"&method=list&weibo_user_id="+weibo_user_id,
		success: function(msg){	
			jQuery("#loadTip").hide();
			jQuery("#weibo_page_div").html(msg);
			var offset = eval(jQuery("#offset").val())*1+0;
			var recordCount = eval(jQuery("#recordCount").val())*1+0;
			if(recordCount <= offset || recordCount<=15){
				jQuery("#page_index").hide();
			}
		}
	});

	
    jQuery("#Float").css("top",0+"px");
}

function toSearchWeiboByTopic(topic,weibo_user_id){
	jQuery("#type").val('1');
	jQuery("#spA_1").addClass("aon");
	jQuery("#spA_1").parent().find("a").not(jQuery("#spA_1")).each(function(){
		jQuery(this).removeClass("aon");	
	});
	jQuery("#weibo_page_div").html("");
	jQuery("#keyword").val(topic);
	jQuery("#loadTip").show();
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/weibo_page_ajax.vm?method=list&weibo_user_id="+weibo_user_id,
		data: "offset=0&type=1&keyword="+encodeURIComponent(topic),
		success: function(msg){	
			jQuery("#loadTip").hide();
			jQuery("#weibo_page_div").html(msg);
			var offset = eval(jQuery("#offset").val())*1+0;
			var recordCount = eval(jQuery("#recordCount").val())*1+0;
			if(recordCount <= offset || recordCount<=15){
				jQuery("#page_index").hide();
			}
			
		}
	});
}



function showLatestWeibo(obj){
	jQuery(obj).hide();
	jQuery("#loadTip").show();
	var pageSize = jQuery("#latestWeiboSpan").html();
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/index.vm?method=list",
		data: "pageSize="+pageSize+"&type="+jQuery("#type").val()+"&keyword="+jQuery("#keyword").val(),
		success: function(msg){
			jQuery("#weibo_div").prepend(msg);
			jQuery("#loadTip").hide();
		}
	});
	jQuery("#latestWeiboSpan").html("");
}

function getMoreWeibo(obj,weibo_user_id){
	jQuery("#loadMorediv").hide();
	jQuery("#loadMoreTip").show();
	var keyword ="";
	if(jQuery("#keyword").length>0){
		keyword = jQuery("#keyword").val();
	}
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/weibo_more_ajax_portal.vm",
		data: "offset="+jQuery("#offset").val()+"&method=list&weibo_user_id="+weibo_user_id,
		success: function(msg){
			jQuery("#offset").remove();
			jQuery("#weibo_div").append(msg);
			jQuery("#loadMoreTip").hide();
			jQuery("#loadMorediv").show();

			var offset = eval(jQuery("#offset").val())*1+0;
			var recordCount = eval(jQuery("#recordCount").val())*1+0;
			if(recordCount <= offset || recordCount<=15){
				jQuery("#page_index").hide();
			}
			
			//setScroll();
			
		}
	});

	 //var offsetTop = jQuery(window).scrollTop() +"px"; 
	 //jQuery("#Float").css("top",offsetTop);
}

function insertTopic(obj){
   contentobj = jQuery("#add_weibo_div").find("#content");
   var content = jQuery(contentobj).val();
   if(content==weibo.say_tip){
	 $(contentobj).val("");
	 content = "";
   }
   
   if(content.indexOf("#"+weibo.topic+"#")>=0){
	var s = content.indexOf("#"+weibo.topic+"#");
	if (document.selection) {
		var range = contentobj[0].createTextRange(); 
		range.collapse(true);//将插入点移动到当前范围的开始或结尾 
		range.moveStart('character',parseInt(eval(s)*1+1) );//start为开始字符的索引 
		range.moveEnd('character',parseInt(12));//len为需要选中的长度 
		range.select();//选中
	} else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
		textarea.setSelectionRange(parseInt(s), (parseInt(s)+parseInt(12)));
	}
	return ;
   }
   var start = document.getElementById("start").value;   
   var subcontent1 = content.substring(0,start);
   var subcontent2 = content.substring(start,content.length);
   content = subcontent1+"#"+weibo.topic+"#" +subcontent2;
   contentobj.val(content);
   if (document.selection) {
	var range = contentobj[0].createTextRange(); 
	range.collapse(true);//将插入点移动到当前范围的开始或结尾 
	range.moveStart('character',parseInt(eval(start)*1+1) );//start为开始字符的索引 
	range.moveEnd('character',parseInt(12));//len为需要选中的长度 
	range.select();//选中
    } else if (typeof obj.selectionStart == 'number' && typeof obj.selectionEnd == 'number') {
	textarea.setSelectionRange(parseInt(start), (parseInt(start)+parseInt(12)));
    }

	
}

function getCommentByWeiboId(obj,weibo_id){
	var divObj = jQuery(obj).parent().parent().next();
	if(divObj.get(0).style.display == 'none' || divObj.get(0).style.display == ''){
		jQuery(divObj).show();
		jQuery(divObj).find("#loadCommentTip").show();
		jQuery.ajax({
			type: "POST",
			url: "/defaultroot/comment_ajax.vm?method=getCommentByWeiboId",
			data: "offset=0&weibo_id="+weibo_id,
			success: function(msg){				
				jQuery(divObj).html(msg);		
			}
		});
	}else{
		jQuery(divObj).hide();
	}
}

function closeCommentDiv(obj){
	var divObj = jQuery(obj).parents(".pl_box");
	jQuery(divObj).html('<span id="loadCommentTip" style="display:none;"><img src="">正在加载,请稍后</span>');
	jQuery(divObj).hide();
	//jQuery(divObj).slideToggle(100); 
}

function addComment(obj,forward_direct_weibo_id){
	contentobj = jQuery(obj).parents(".pl_content").find("#content");
	contentobj.emotionsToHtml();
	if(jQuery.trim(contentobj.html()) == ""){
		contentobj.focus();
	}else{
		
		var forward = "";
		var comment_to_init_author = "";
		if(jQuery(contentobj).parents(".pl_content").find("#forward").attr("checked") == true){
			forward = "yes";
		}
		if(jQuery(contentobj).parents(".pl_content").find("#comment_to_init_author").attr("checked") == true){
			comment_to_init_author = "yes";
		}
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/comment_add.vm?method=add",
				data: "forward_direct_weibo_id="+forward_direct_weibo_id+"&forward="+forward+"&comment_to_init_author="+comment_to_init_author+"&content="+encodeURIComponent(jQuery(contentobj).html())+"&comment_id="+jQuery(obj).parents(".pl_content").find("#comment_id").val(),
				success: function(msg){				
					jQuery(contentobj).html("");									
					jQuery(obj).parents(".pl_content").find(".pl_list").prepend(msg);
					var weibo_count = eval(jQuery(obj).parents(".wb_listbox").find('#plc'+forward_direct_weibo_id).html())*1 + 1;
					jQuery(obj).parents(".wb_listbox").find('#plc'+forward_direct_weibo_id).html(weibo_count+"") ;
				}
		});
	}
}


function addCommentDetail(obj,forward_direct_weibo_id){
	contentobj = jQuery("#content");
	contentobj.emotionsToHtml();
	if(jQuery.trim(contentobj.html()) == ""){
		contentobj.focus();
	}else{		
		var forward = "";
		var comment_to_init_author = "";
		if(jQuery(obj).parent().find("#forward").attr("checked") == true){
			forward = "yes";
		}
		if(jQuery(obj).parent().find("#comment_to_init_author").attr("checked") == true){
			comment_to_init_author = "yes";
		}
		
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/weibo_forward_comment_ajax.vm?method=add",
				data: "forward_direct_weibo_id="+forward_direct_weibo_id+"&forward="+forward+"&comment_to_init_author="+comment_to_init_author+"&content="+encodeURIComponent(jQuery(contentobj).html())+"&comment_id="+jQuery(obj).parents("#pl_div").find("#comment_id").val(),
				success: function(msg){				
					jQuery(contentobj).html("");	
					jQuery("#limit").html("140");
					jQuery("#forward_list_div").prepend(msg);
					var zfcount = eval(jQuery("#plcount").html())*1 + 1;
					jQuery("#plcount").html(zfcount);
					jQuery("#splcount").html(zfcount);
					jQuery(".operateTrigger").eq(1).click();

					jQuery(obj).parent().find("#forward").attr("checked",false);
					jQuery(obj).parent().find("#comment_to_init_author").attr("checked",false);
				}
		});
	}
}




function addCommentIndex(obj,forward_direct_weibo_id){
	contentobj = jQuery(obj).parents(".pl_content").find("#content");
	contentobj.emotionsToHtml();
	if(jQuery.trim(contentobj.html()) == ""){
		contentobj.focus();
	}else{
		
		var forward = "";
		var comment_to_init_author = "";
		if(jQuery(contentobj).parents(".pl_content").find("#forward").attr("checked") == true){
			forward = "yes";
		}
		if(jQuery(contentobj).parents(".pl_content").find("#comment_to_init_author").attr("checked") == true){
			comment_to_init_author = "yes";
		}
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/comment_add.vm?method=add",
				data: "forward_direct_weibo_id="+forward_direct_weibo_id+"&forward="+forward+"&comment_to_init_author="+comment_to_init_author+"&content="+encodeURIComponent(jQuery(contentobj).html())+"&comment_id="+jQuery(obj).parents(".pl_content").find("#comment_id").val(),
				success: function(msg){					
					jQuery(contentobj).html("");									
					showCommentBox(obj);
					jQuery(".operateTrigger").click();

				}
		});
	}
}

function addCommentDetailReply(obj,forward_direct_weibo_id){
	contentobj = jQuery(obj).parents(".pl_content").find("#content");
	contentobj.emotionsToHtml();
	if(jQuery.trim(contentobj.html()) == ""){
		contentobj.focus();
	}else{
		
		var forward = "";
		var comment_to_init_author = "";
		if(jQuery(contentobj).parents(".pl_content").find("#forward").attr("checked") == true){
			forward = "yes";
		}
		if(jQuery(contentobj).parents(".pl_content").find("#comment_to_init_author").attr("checked") == true){
			comment_to_init_author = "yes";
		}
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/comment_add.vm?method=add",
				data: "forward_direct_weibo_id="+forward_direct_weibo_id+"&forward="+forward+"&comment_to_init_author="+comment_to_init_author+"&content="+encodeURIComponent(jQuery(contentobj).html())+"&comment_id="+jQuery(obj).parents(".pl_content").find("#comment_id").val(),
				success: function(msg){					
					jQuery(contentobj).html("");
					jQuery("#limit").html("140");	
					showCommentBoxDetail(obj);
					jQuery(".operateTrigger").eq(1).click();

				}
		});
	}
}



function reply(obj,comment_id){
	contentobj = jQuery(obj).parents(".pl_content").find("#content");
	jQuery(obj).parents(".pl_content").find("#comment_id").val(comment_id);
	jQuery(contentobj).html("回复@"+jQuery(obj).attr("id")+":");
	jQuery(contentobj).focus();
	moveEnd(contentobj[0],jQuery(contentobj).html().length);

}

function addFavorite(obj,weibo_id){
	
        jQuery(obj).next().show();
        jQuery(obj).hide();
        jQuery(obj).parents(".wb_listbox").find("#cancelFavoriteSucDiv").slideToggle(500); 
	jQuery(obj).parents(".wb_listbox").find("#cancelFavoriteSucDiv").slideToggle(500); 
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/addOrDeleteFavorite.vm?method=addOrDeleteFavorite",
		data: "weibo_id="+weibo_id+"&operation=add",
		success: function(msg){
			
		}
	});

}

function deleteFavorite(obj,weibo_id){
	
        jQuery(obj).parents(".wb_listbox").find("#favorite_a").show();
        jQuery(obj).parents(".wb_listbox").find("#cancel_favorite_a").hide();
        jQuery(obj).parents(".wb_listbox").find("#cancelFavoriteDiv").slideToggle(100); 
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/addOrDeleteFavorite.vm?method=addOrDeleteFavorite",
		data: "weibo_id="+weibo_id+"&operation=delete",
		success: function(msg){
			
		}
	});

}



function deleteFavoriteIndex(obj,weibo_id){
	jQuery(obj).parents(".wb_listbox").attr("id","page_sc_");
    jQuery(obj).parents(".wb_listbox").slideToggle(100); 
	
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/addOrDeleteFavorite.vm?method=addOrDeleteFavorite",
		data: "weibo_id="+weibo_id+"&operation=delete",
		success: function(msg){
			var c = jQuery("#sc_count").html();
			jQuery("#sc_count").html(eval(c)*1-1);
		}
	});

	var len = jQuery("#weibo_div").find("#page_sc").length ;
	if(len == 0){
			var start_page = jQuery("#start_page").val();
			start_page = eval(start_page)*1 - 1 ;
			PageClick(start_page);
	}	
}


function confirmFavorite(obj,weibo_id){

	jQuery(obj).parents(".wb_listbox").find("#cancelFavoriteDiv").slideToggle(100); 
}


function getMoreConcernOrFans(type,order,weibo_user_id){
  window.location.href = "/defaultroot/concernOrfansIndex.vm?weibo_user_id="+weibo_user_id+"&method=list&type="+type+"&order="+order+"&keyword_refer="+jQuery("#concernfans_keyword").val();
	
}

function setBq(obj){
	var img_name = obj.src.subsing(obj.src.lastIndexOf("/")+1,obj.src.lastIndexOf("."));
	contentobj = jQuery("#add_weibo_div").find("#content");
	var content = contentobj.val();
	//var oText = document.getElementById("content");
	//var oImg = document.createElement("IMG");
	//oImg.src = obj.src;
	//oText.appendChild(oImg);
	var start = document.getElementById("start").value;   
	var subcontent1 = content.substring(0,start);
	var subcontent2 = content.substring(start,content.length);
	content = subcontent1+"["+img_name+"]" +subcontent2;
	contentobj.val(content);
	

}




function forwardWeibo(obj,forward_direct_weibo_id){
	jQuery("#content").emotionsToHtml();
	if(jQuery.trim(jQuery("#content").html()) == ""){
		contentobj.focus();
	}else{
		var comment_to_this_author = "";
		var comment_to_init_author = "";
		if(jQuery("#comment_to_this_author").attr("checked") == true){
			comment_to_this_author = "yes";
		}
		if(jQuery("#comment_to_init_author").attr("checked") == true){
			comment_to_init_author = "yes";
		}
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/weibo_ajax.vm?method=add",
				data: "forward=yes&comment_to_this_author="+comment_to_this_author+"&comment_to_init_author="+comment_to_init_author+"&forward_direct_weibo_id="+forward_direct_weibo_id+"&content="+encodeURIComponent(jQuery("#content").html()),
				success: function(msg){
					var current_user = jQuery("#current_user",window.parent.document).val();
					var uri = jQuery("#uri",window.parent.document).val();
					var type = jQuery("#type",window.parent.document).val();
					if(current_user=='yes'){
						if(uri=="index"){							
							if(type == "1" || type == "2"){
								jQuery("#weibo_div").find("#current_latest_id").remove();
								var offset = eval(jQuery("#offset").val())*1+1;
								jQuery("#offset").val(offset);
								jQuery("#weibo_div",window.parent.document).prepend(msg);
							}					   
						}
						var weibo_count = eval(jQuery("#weibo_count_span",window.parent.document).html())*1 + 1;
						jQuery("#weibo_count_span",window.parent.document).html(weibo_count+"") ;
					}else{
						if(uri=="index"){							
							if(type == "2"){
								jQuery("#weibo_div").find("#current_latest_id").remove();
								var offset = eval(jQuery("#offset").val())*1+1;
								jQuery("#offset").val(offset);
								jQuery("#weibo_div",window.parent.document).prepend(msg);								
							}					   
						}						
					}
					

					if(uri=="index"){
						var forward_weibo_count = eval(jQuery('#'+forward_direct_weibo_id,window.parent.document).html())*1 + 1;
						jQuery('#'+forward_direct_weibo_id,window.parent.document).html(forward_weibo_count+"") ;
					}
					jQuery("#targetFixed",window.parent.document).html("0");					
					window.parent.jQuery.fancybox.close();
					if(uri=="weibo_detail"){
						jQuery(".operateTrigger",window.parent.document).eq(0).click();
						jQuery("#targetFixed",window.parent.document).html("");
					}


					//setTimeout("closeFancybox()",1000);
					
				}
		});
	}
}


function forwardWeiboDetail(obj,forward_direct_weibo_id){
	jQuery("#content").emotionsToHtml();
	if(jQuery.trim(jQuery("#content").html()) == ""){
		contentobj.focus();
	}else{
		var comment_to_this_author = "";
		var comment_to_init_author = "";
		if(jQuery("#comment_to_this_author").attr("checked") == true){
			comment_to_this_author = "yes";
		}
		if(jQuery("#comment_to_init_author").attr("checked") == true){
			comment_to_init_author = "yes";
		}
		jQuery.ajax({
				type: "POST",
				url: "/defaultroot/weibo_forward_ajax.vm?method=add",
				data: "forward=yes&comment_to_this_author="+comment_to_this_author+"&comment_to_init_author="+comment_to_init_author+"&forward_direct_weibo_id="+forward_direct_weibo_id+"&content="+encodeURIComponent(jQuery("#content").html()),
				success: function(msg){
					var current_user = jQuery("#current_user",window.parent.document).val();
						
					jQuery("#forward_list_div").prepend(msg);
					if(current_user == "yes"){
						var weibo_count = eval(jQuery("#weibo_count_span",window.parent.document).html())*1 + 1;
						jQuery("#weibo_count_span",window.parent.document).html(weibo_count+"") ;
					}
					var zfcount = eval(jQuery("#zfcount").html())*1 + 1;
					jQuery("#zfcount").html(zfcount);
					jQuery("#szfcount").html(zfcount);
				


					//jQuery("#targetFixed",window.parent.document).html("0");					
					//jQuery.fancybox.close();

			
				    jQuery(".operateTrigger").eq(0).click();
				    
					jQuery("#content").html("");
					jQuery("#limit").html("140");
					//setTimeout("closeFancybox()",1000);
					
				}
		});
	}
}


function closeFancybox(){
	window.parent.jQuery.fancybox.close();
}


 function show_hiddendiv(){
 	document.getElementById("hidden_div").style.display='block';
 	document.getElementById("_strHref").href='javascript:hidden_showdiv();';
 	document.getElementById("_strSpan").innerHTML="<img src='modules/comm/microblog/images/zf_yc.gif' />";
 }
 function hidden_showdiv(){
 	document.getElementById("hidden_div").style.display='none';
 	document.getElementById("_strHref").href='javascript:show_hiddendiv();';
 	document.getElementById("_strSpan").innerHTML="<img src='modules/comm/microblog/images/zf_xs.gif' />";
 }


function getWeibo_forward_list_ajax(forward_direct_weibo_id){
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/weibo_forward_list_ajax.vm?method=weibo_forward_list_ajax",
		data: "offset=0&forward_direct_weibo_id="+forward_direct_weibo_id,
		success: function(msg){
			
			jQuery("#forward_list_div").html(msg);
			jQuery("#forward_list_div").show();
			jQuery('#show_div_a').hide();
			jQuery('#hide_div_a').show();
		}
	});

}

function upforwardlist(obj) {
	jQuery("#forward_list_div").hide();
	jQuery(obj).hide();
	jQuery('#show_div_a').show();
}



function toWeiboDetail(weibo_id,weibo_user_id,type){
	window.parent.jQuery.fancybox.close();
	window.parent.location.href= "/defaultroot/weibo_detail.vm?method=weibo_detail&weibo_id="+weibo_id+"&weibo_user_id="+weibo_user_id+"&type="+type;
}


function toWeiboDetailIndex(weibo_id,weibo_user_id,type){
	window.location.href= "/defaultroot/weibo_detail.vm?method=weibo_detail&weibo_id="+weibo_id+"&weibo_user_id="+weibo_user_id+"&type="+type;
}





function deleteComment(obj,id,weibo_id){	
    jQuery(obj).parents("li").find("#deleteCommentDiv").slideToggle(100); 	
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/comment_delete.vm?method=delete",
		data: "id="+id+"&weibo_id="+weibo_id,
		success: function(msg){
			var c = jQuery("#pl_count").html();
			jQuery("#pl_count").html(eval(c)*1-1);

		}
	});
	jQuery(obj).parents("li").slideToggle(100); 

	jQuery(obj).parents("li").attr("id","page_sc_");
	
	var len = jQuery(".pl_listpl").find("#page_sc").length ;
	if(len == 0){
			var start_page = jQuery("#start_page").val();
			start_page = eval(start_page)*1 - 1 ;
			PageClick(start_page);
	}	


}

function confirmComment(obj,attentioned_user_id){
	jQuery(obj).parents("li").find("#deleteCommentDiv").slideToggle(100); 
}

function showCommentBox(obj){
	jQuery(obj).parents("li").find("#pl_box").slideToggle(100); 
}

function showCommentBoxDetail(obj){
	jQuery(obj).parents(".wb_listbox").find("#pl_box").slideToggle(100); 
}

function editSig(obj){
	
	jQuery(obj).hide();
	jQuery(obj).next().show();
	jQuery(obj).next().find("textarea").focus();

}



function saveSig(obj){
	var sig = jQuery.trim(jQuery(obj).text()) ;
	if(sig==""){
		sig = "一句话个性签名";
	}
	jQuery(obj).parent().hide();
	if(sig.length>15){
		jQuery(obj).parent().prev().html(sig.substring(0,15)+"...");
	}else{
		jQuery(obj).parent().prev().html(sig);
	}
	jQuery(obj).parent().prev().attr("title",sig);
	jQuery(obj).parent().prev().show();
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/saveSig.vm?method=saveSig",
		data: "sig="+encodeURIComponent(jQuery.trim(jQuery(obj).text()))+"&date="+Math.random(),
		success: function(msg){
			

		}
	});		

}


function showBorder(obj){	
	jQuery(obj).addClass("input_sig");
}

function hideBorder(obj){	
	jQuery(obj).removeClass("input_sig");
}


function checkNum(obj){
	var c = jQuery.trim(jQuery(obj).html());	
	if(c.length > 30){
		c = c.substring(0,30);
	}
	jQuery(obj).html(c);
}

var emp = [
                 {'id':1,'phrase':'['+weibo.oh+']','url':'1.gif'},{'id':2,'phrase':'['+weibo.hee+']','url':'2.gif'},
				{'id':3,'phrase':'['+weibo.haha+']','url':'3.gif'},{'id':4,'phrase':'['+weibo.lovely+']','url':'4.gif'},
				{'id':5,'phrase':'['+weibo.pity+']','url':'5.gif'},{'id':6,'phrase':'['+weibo.nose_picking+']','url':'6.gif'},
				{'id':7,'phrase':'['+weibo.surprised+']','url':'7.gif'},{'id':8,'phrase':'['+weibo.shy+']','url':'8.gif'},
				{'id':9,'phrase':'['+weibo.wink+']','url':'9.gif'},{'id':10,'phrase':'['+weibo.shut+']','url':'10.gif'},
				{'id':11,'phrase':'['+weibo.slight+']','url':'11.gif'},{'id':12,'phrase':'['+weibo.love_you+']','url':'12.gif'},
				{'id':13,'phrase':'['+weibo.tears+']','url':'13.gif'},{'id':14,'phrase':'['+weibo.giggle+']','url':'14.gif'},
				{'id':15,'phrase':'['+weibo.kiss+']','url':'15.gif'},{'id':16,'phrase':'['+weibo.sick+']','url':'16.gif'},
				{'id':17,'phrase':'['+weibo.happy+']','url':'17.gif'},{'id':18,'phrase':'['+weibo.lazy_to_care+']','url':'18.gif'},
				{'id':19,'phrase':'['+weibo.left_hum+']','url':'19.gif'},{'id':20,'phrase':'['+weibo.right_hum+']','url':'20.gif'},
				{'id':21,'phrase':'['+weibo.shush+']','url':'21.gif'},{'id':22,'phrase':'['+weibo.decline+']','url':'22.gif'},
				{'id':23,'phrase':'['+weibo.grievance+']','url':'23.gif'},{'id':24,'phrase':'['+weibo.spit+']','url':'24.gif'},
				{'id':25,'phrase':'['+weibo.yawn+']','url':'25.gif'},{'id':26,'phrase':'['+weibo.hug+']','url':'26.gif'},
				{'id':27,'phrase':'['+weibo.anger+']','url':'27.gif'},{'id':28,'phrase':'['+weibo.doubt+']','url':'28.gif'},
				{'id':29,'phrase':'['+weibo.glutton+']','url':'29.gif'},{'id':30,'phrase':'['+weibo.bye+']','url':'30.gif'},
				{'id':31,'phrase':'['+weibo.think+']','url':'31.gif'},{'id':32,'phrase':'['+weibo.sweat+']','url':'32.gif'},
				{'id':33,'phrase':'['+weibo.sleepy+']','url':'33.gif'},{'id':34,'phrase':'['+weibo.sleep+']','url':'34.gif'},
				{'id':35,'phrase':'['+weibo.money+']','url':'35.gif'},{'id':36,'phrase':'['+weibo.despair+']','url':'36.gif'},
				{'id':37,'phrase':'['+weibo.cool+']','url':'37.gif'},{'id':38,'phrase':'['+weibo.mahogany+']','url':'38.gif'},
				{'id':39,'phrase':'['+weibo.hum+']','url':'39.gif'},{'id':40,'phrase':'['+weibo.clap+']','url':'40.gif'},
				{'id':41,'phrase':'['+weibo.dizzy+']','url':'41.gif'},{'id':42,'phrase':'['+weibo.sad+']','url':'42.gif'},
				{'id':43,'phrase':'['+weibo.mad+']','url':'43.gif'},{'id':44,'phrase':'['+weibo.black_line+']','url':'44.gif'},
				{'id':45,'phrase':'['+weibo.sinister+']','url':'45.gif'},{'id':46,'phrase':'['+weibo.satire+']','url':'46.gif'},
				{'id':47,'phrase':'['+weibo.heart+']','url':'47.gif'},{'id':48,'phrase':'['+weibo.grieved+']','url':'48.gif'},
				{'id':49,'phrase':'['+weibo.pig+']','url':'49.gif'},{'id':50,'phrase':'['+weibo.ok+']','url':'50.gif'},
				{'id':51,'phrase':'['+weibo.yeah+']','url':'51.gif'},{'id':52,'phrase':'['+weibo.excellent+']','url':'52.gif'},
				{'id':53,'phrase':'['+weibo.unwilling+']','url':'53.gif'},{'id':54,'phrase':'['+weibo.praise+']','url':'54.gif'},
				{'id':55,'phrase':'['+weibo.come+']','url':'55.gif'},{'id':56,'phrase':'['+weibo.weak+']','url':'56.gif'},
				{'id':57,'phrase':'['+weibo.candle+']','url':'57.gif'},{'id':58,'phrase':'['+weibo.bell+']','url':'58.gif'},
				{'id':59,'phrase':'['+weibo.cake+']','url':'59.gif'},{'id':60,'phrase':'['+weibo.mike+']','url':'60.gif'}
            ];



function stripscript(obj) 
{	
	var s = obj.value ;
	//var pattern = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）&mdash;—|{}【】‘；：”“'。，、？]") ;
	var rs = ""; 
	for (var i = 0; i < s.length; i++) { 
		rs = rs+s.substring(i, i+1).replace("'",""); 
	} 
	obj.value = rs; 
} 



function deleteWeibo(obj,weibo_id){
	
	
	jQuery(obj).parents(".wb_listbox").slideToggle(100); 
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/deleteWeibo.vm?method=deleteWeibo",
		data: "weibo_id="+weibo_id,
		success: function(msg){
					var weibo_count = eval(jQuery("#weibo_count_span").html())*1 - 1;
					jQuery("#weibo_count_span").html(weibo_count+"") ;
		}
	});
	
}

function confirmDeleteWeibo(obj,weibo_id){

	jQuery(obj).parents(".wb_listbox").find("#deleteWeibo").slideToggle(100); 
}


function showDelete(obj,pra,current_user){
	var type = jQuery("#type").val();
	if(pra=='1' && type=='2' && current_user=='yes'){
		jQuery(obj).find("#deleteLink").show(); 
	}else{
		jQuery(obj).find("#deleteLink").hide(); 		
	}
	
}



function addAttention(obj,emp_id){
	
	jQuery.ajax({
		type: "POST",
		url: "/defaultroot/addOrDeleteAttention.vm?method=addOrDeleteAttention",
		data: "attentioned_user_id="+emp_id+"&operation=add",
		success: function(msg){
			jQuery(".operateTrigger").click();
			jQuery(obj).hide();
			jQuery(obj).next().show();
		}
	});
	
}




function addrows(obj){
	obj.rows = 4;
	jQuery("#face_upload").css("margin-top",20+"px");
}

function deleterows(obj){	
	if(jQuery.trim(jQuery(obj).html())=="" || jQuery.trim(jQuery(obj).html())=="说说你在做什么，想什么"){
		obj.rows = 3;
		jQuery(obj).html("说说你在做什么，想什么");		
		jQuery("#face_upload").css("margin-top",0+"px");
	}else{		
		jQuery("#face_upload").css("margin-top",20+"px");
	}
}




function addcols(){
cols = form1.txt.cols;
cols++;
form1.txt.cols = cols;
}

jQuery(window).scroll(function (){ 
var offsetTop = jQuery(window).scrollTop() +"px"; 
jQuery("#Float").css("top",offsetTop);
//jQuery("#Float").animate({top : offsetTop},{duration:0 , queue:false}); 
}); 
