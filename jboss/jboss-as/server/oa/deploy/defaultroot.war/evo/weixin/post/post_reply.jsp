<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>发帖</title>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<form id="myForm" action="/defaultroot/post/save.controller" method="post">
<section class="wh-section wh-section-bottomfixed" id="mainContent">
    <article class="wh-edit wh-edit-forum">
    	<c:if test="${not empty docXml}">
		<x:parse xml="${docXml}" var="doc" />
			<x:forEach select="$doc//list" var="n" varStatus="status">
			<c:if test="${status.index + 1 == forumFloor}">
				<input type="hidden" name="postId" value="${postId}" />
				<input type="hidden" name="forumId" value="${forumId}" />
				<input type="hidden" name="classId" value="<x:out select="$n/classid/text()"/>" />
				<input type="hidden" name="forumSign" value="<x:out select="$n/forumSign/text()"/>" />
				<input type="hidden" name="forumFloor" value="${forumFloor }" />
				<input type="hidden" name="forumUserName" value="${forumUserName }" />
				<input type="hidden" name="forumIssueTime" value="${forumIssueTime }" />
		        <div>
		            <table class="wh-table-edit">
		                <tr>
		                    <th>帖子标题<i class="fa fa-asterisk"></i>：</th>
		                    <td><input class="edit-ipt-r" type="text" value="Re:<x:out select='$n/forumTitle/text()'/>" name="title" id="title" readonly/></td>
		                </tr>
		                <tr>
		                    <th>附件：</th>
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
		                            <textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="content" id="content"></textarea>
		                            <span class="edit-txta-num">300</span>
		                        </div>
		                    </td>
		                </tr>
		            </table>
		        </div>
	        </c:if>
	        </x:forEach>
        </c:if>
    </article>
</section>
</form>
<footer class="wh-footer wh-footer-text" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:sendReply();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>发送</a>
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
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script type="text/javascript">
	//发送回复
	var flag = 1;
	function sendReply(){
		if(flag == 0){
    		return;
    	}
    	flag = 0;
		var content = $("#content").val();
		if(!(content.trim()) || /[@#\$%\^&\*]+/g.test(content)){
			alert('请正确填写帖子正文！');
			return false;
		}
		if(content.length > 300){
			alert('帖子正文不得超过300字！');
			return false;
		}
		$("#myForm").submit();
	}
		
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
		       '<input type="hidden" id="img_name_'+index+'" name="imgName"/>'+
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName"/>'+
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
		var loadingDialog = openTipsDialog('正在上传...');
		$("#img_name_"+(index-1)).val($("#"+upImgId).val());
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=forum', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				alert("文件上传失败！");
			}
		});
	}
</script>