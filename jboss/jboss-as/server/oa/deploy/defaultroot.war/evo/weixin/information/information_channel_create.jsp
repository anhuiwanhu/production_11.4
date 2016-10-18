<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<script>
var addAuth = '${addAuth}';
if(addAuth == 'false'){
	wx.ready(function(){
		alert('无新增信息权限！');
		wx.closeWindow();
	});
}
</script>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>新建信息</title>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<form id="saveForm">
<section class="wh-section wh-section-bottomfixed" id="mainContent">
    <article class="wh-edit wh-edit-forum">
        <div>
            <table class="wh-table-edit">
                <tr>
                    <th>所属栏目<i class="fa fa-asterisk"></i>：</th>
                    <td>
                        <input class="edit-ipt-r edit-ipt-arrow" type="text" readonly value="${parentChannelName}" name="channelName" id="channelName"/>
                        <input type="hidden" name="channelId" id="channelId" value="${parentChannelId}"/>
                    </td>
                </tr>
                <tr>
                    <th>信息标题<i class="fa fa-asterisk"></i>：</th>
                    <td><input class="edit-ipt-r" type="text" placeholder="请输入" name="title" id="title"/></td>
                </tr>
                <tr>
                	<!-- TODO接口需要接收该条件 -->
                    <th>显示方式：</th>
                    <td>
                        <ul class="edit-radio">
                            <li>
                            	<span class="edit-radio-l">细览不显示</span>
                            	<input type="hidden" name="displayTitle"/>
                            </li>
                            <li>
                            	<span class="edit-radio-l">首页显示为红色</span>
                            	<input type="hidden" name="titleColor"/>
                            </li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th>相关图片：</th>
                    <td>
                        <ul class="edit-upload">
                            <li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
                        </ul>
                    </td>
                </tr>
                <tr>
                    <th>正文<i class="fa fa-asterisk"></i>：</th>
                    <td>
                        <div class="edit-txta-box">
                            <textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="content" id="content" maxlength="300"
                            onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" onchange="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"></textarea>
                            <span class="edit-txta-num">300</span>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </article>
</section>
</form>
<footer class="wh-footer wh-footer-text" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:saveInfo();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>确定发布</a>
            </div>
        </div>
    </div>
</footer>
<section id="selectContent" style="display:none">
</section>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/modules/comm/microblog/script/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/uploadPreview.min.js"></script>
<script type="text/javascript">
    var dialog = null;
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    $(function(){
    	//单选
        var radioList = $(".edit-radio li");
        radioList.click(function(){
        	var $obj = $(this);
        	var $input = $obj.find('input');
            if($obj.attr("class")){
        		$obj.removeClass('radio-active');
        		if($obj.index() == 0){
	        		$input.val('1');
        		}else if($obj.index() == 1){
	        		$input.val('0');
        		}
        	}else{
	        	$obj.addClass('radio-active');
	        	if($obj.index() == 0){
	        		$input.val('0');
        		}else if($obj.index() == 1){
	        		$input.val('1');
        		}
        	}
        })
    });
    
    //图片数标记
    var index = 0;
   
    //添加图片
    function addImg(){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="fileName_'+index+'" name="fileName"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   
	//删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=information', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#fileName_"+(index-1)).val(fileShowName+"|"+msg.data);
				$("#"+imgliId).show();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				alert("文件上传失败！");
			}
		});
	}
	
	//保存信息
	function saveInfo(){
		if(checkForm()){
			$.ajax({
				url : "/defaultroot/information/save.controller",
				data : $("#saveForm").serialize(),
				type : "post",
				success : function(data){
					var jsonData = eval("("+data+")");
					if(jsonData.result == 'success'){
						alert("发布成功！");
						location.href="/defaultroot/channel/channelList.controller?channelId=${parentChannelId}";
					}else if(jsonData.result == 'fail'){
						alert("发布失败！");
					}
				},
				error : function(){
					alert("发布异常！");
				}
			});
		}
	}
	
	//验证表单数据
	function checkForm(){
		var channelId = $("#channelId").val();
		var title = $("#title").val();
		var content = $('#content').val();
		if(!channelId){
			alert("请选择所属栏目！");
			return false;
		}
		if(!(title.trim()) || /[@#\$%\^&\*]+/g.test(title)){
			alert("请正确填写信息标题！");
			return false;
		}
		if(title.length > 150){
			alert("标题不得超过150字！");
			return false;
		}
		if(!(content.trim()) || /[@#\$%\^&\*]+/g.test(content)){
			alert('请正确填写正文！');
			return false;
		}
		if(content.length > 300){
			alert("正文不得超过300字！");
			return false;
		}
		return true;
	}
</script>