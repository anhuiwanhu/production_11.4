<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%
String homePage = request.getParameter("homePage")==null?"2":request.getParameter("homePage");
%>
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
<form id="sendForm">
<section class="wh-section wh-section-bottomfixed" id="mainContent">
    <article class="wh-edit wh-edit-forum">
        <div class="wh-container">
            <table class="wh-table-edit">
                <tr>
                    <th><i class="fa fa-asterisk"></i>所属版块：</th>
                    <td>
                        <input onclick="selectColumn()" class="edit-ipt-r edit-ipt-arrow" type="text" readonly name="className" id="className" placeholder="请选择" />
                        <input type="hidden" name="classId" id="classId"/>
                    </td>
                </tr>
                <tr>
                    <th><i class="fa fa-asterisk"></i>帖子标题：</th>
                    <td><input class="edit-ipt-r" type="text" placeholder="请输入" name="title" id="title"/></td>
                </tr>
                <tr>
                    <th><i class="fa fa-asterisk"></i>署名方式：</th>
                    <td>
                        <ul class="edit-radio">
                            <li data-val="0"><span class="edit-radio-l">实名</span></li>
                            <li data-val="1"><span class="edit-radio-l">匿名</span></li>
                            <li data-val="2" <c:if test="${hasNick eq '0'}">style="display:none;"</c:if>><span class="edit-radio-l">昵称</span></li>
                            <input type="hidden" name="type" id="type"/>
                        </ul>
                    </td>
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
                    <th>正文：</th>
                    <td>
                   		<style type="text/css">
							#content {
								max-height: 250px;
								height: 150px;
								background-color: white;
								border-collapse: separate; 
								border: 1px solid rgb(204, 204, 204); 
								padding: 4px; 
								box-sizing: content-box; 
								-webkit-box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset; 
								box-shadow: rgba(0, 0, 0, 0.0745098) 0px 1px 1px 0px inset;
								border-top-right-radius: 3px; border-bottom-right-radius: 3px;
								border-bottom-left-radius: 3px; border-top-left-radius: 3px;
								overflow: scroll;
								outline: none;
								font-size: 16px;
							}
						</style>
                       	<div name="" id="content" contenteditable="true" style="overflow:auto;" class="edit-txta-box">
						</div>
                        <div class="edit-txta-box">
                            <textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="content" id="realContent" style="display:none;"></textarea>
							<%--<span class="edit-txta-num">300</span>--%>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th colspan="2">                        
                        <div class="edit-face-ico edit-ipt-reslut-l">
                            <span class="face-ico-btn"><img src="/defaultroot/modules/comm/forum/images/QQ_New/1.gif" /></span>
                            <div class="face-ico-all" style="display: none;">
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/1.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/2.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/3.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/4.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/5.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/6.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/7.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/8.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/9.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/10.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/11.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/12.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/13.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/14.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/15.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/16.gif" />
                                <img src="/defaultroot/modules/comm/forum/images/QQ_New/17.gif" />
                            </div>
                        </div>
                    </th>
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
                <a href="javascript:sendPost();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>确定发布</a>
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
        	$("#type").val($(this).data("val"));
            radioList.eq($(this).index()).addClass('radio-active').siblings().removeClass('radio-active')
        });
        $('.face-ico-btn').click(function(){
            $('.face-ico-all').toggle();
        })
        //绑定点击图标事件 
        $('.face-ico-all img').bind('click',function(){
		    var src = this.src;
		    if(src.indexOf("/modules/comm/forum/images/")!=-1){
		        src = src.substring(src.indexOf("/defaultroot/modules/comm/forum/images/"));
		    }
			$("#content").append("<IMG SRC='" + src + "'/>");
        });
    });
    
    //打开选择版块页面
	function selectColumn(){
		var selectClassId = $("#classId").val();
    	pageLoading();
		$.ajax({
			url : '/defaultroot/post/selectcolumn.controller',
			type : "post",
			data : {"selectClassId":selectClassId},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
				if(dialog){
					dialog.close();
				}
			}
		});
	}
    	
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag==0){
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#selectContent").css("display","block");
		}else if(flag==1){
			$("#selectContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#selectContent").empty();
		}
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
	
	//发送帖子
	function sendPost(){
		$("#realContent").val($("#content").html());
		if(checkForm()){
			$.ajax({
				url : "/defaultroot/post/saveforum.controller",
				data : $("#sendForm").serialize(),
				type : "post",
				success : function(data){
					var jsonData = eval("("+data+")");
					if(jsonData.result == 'success'){
						alert("发送成功！");
						location.href="/defaultroot/post/index.controller?homePage="+<%=homePage%>;
					}else if(jsonData.result == 'fail'){
						alert("发送失败！");
					}
				},
				error : function(){
					alert("发送异常！");
				}
			});
		}
	}
	
	//验证表单数据
	function checkForm(){
		var classId = $("#classId").val();
		var title = $("#title").val();
		var type = $("#type").val();
		var content = $('#content').val();
		if(!classId){
			alert("请选择版块名！");
			return false;
		}
		if(!(title.trim()) || /[@#\$%\^&\*]+/g.test(title)){
			alert("请正确填写帖子标题！");
			return false;
		}
		if(title.length > 50){
			alert("帖子标题不得超过50字！");
			return false;
		}
		if(!type || $('.edit-radio li.radio-active').length == 0){
			alert("请选择署名方式！");
			return false;
		}
		if((!(content.trim()) && content.length>0) || /[@#\$%\^&\*]+/g.test(content)){
			alert('请正确填写帖子正文！');
			return false;
		}
		if(content.length > 300){
			alert('帖子正文不得超过300字！');
			return false;
		}
		return true;
	}
</script>