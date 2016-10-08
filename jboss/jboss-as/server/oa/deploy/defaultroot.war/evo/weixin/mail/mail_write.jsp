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
    <title>
  	<c:choose>
  		<c:when test="${param.openType eq 'reply'}">
  			回复邮件
  		</c:when>
  		<c:when test="${param.openType eq 'forward'}">
  			转发邮件
  		</c:when>
  		<c:when test="${param.openType eq 'sendAgain'}">
  			发送邮件
  		</c:when>
  		<c:when test="${param.openType eq 'replyAll'}">
  			回复全部
  		</c:when>
  		<c:when test="${param.openType eq 'replyAllandAccessory'}">
  			回复全部(带附件)
  		</c:when>
  		<c:otherwise>写邮件</c:otherwise>
  	</c:choose>  
    </title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<form id="sendForm">
	<section class="wh-section wh-section-bottomfixed" id="mainContent">
	    <article class="wh-edit wh-edit-forum">
	        <div class="wh-container">
	            <table class="wh-table-edit">
	                <tr>
	                    <th>收件人<i class="fa fa-asterisk"></i>：</th>
	                    <td>
	                    	<span class="fr" onclick="$(this).next('input').click()"></span>
	                    	<input onclick="selectUser('1','empName','empId','*0*');"  class="edit-ipt-r edit-ipt-arrow" readonly type="text" 
	                    	id="empName" name="mailto" <c:if test="${param.openType eq 'reply'}">value="${requestScope.userName}"</c:if>
	                    	<c:if test="${param.openType eq 'personSend'}">value="${param.empName},"</c:if>
	                    	<c:if test="${param.openType eq 'sendAgain'}">value="${mailTo}"</c:if>  
	                    	<c:if test="${param.openType eq 'replyAll'}">value="${requestScope.userName}"</c:if>
	                    	<c:if test="${param.openType eq 'replyAllandAccessory'}">value="${requestScope.userName}"</c:if>
	                    	placeholder="请选择"/>
	                    	<input type="hidden" name="mailtoid" <c:if test="${param.openType eq 'reply'}">value="${requestScope.userId}"</c:if> 
	                    	<c:if test="${param.openType eq 'personSend'}">value="${param.personId}"</c:if>
	                    	<c:if test="${param.openType eq 'sendAgain'}">value="${mailToId}"</c:if> 
	                    	<c:if test="${param.openType eq 'replyAll'}">value="${requestScope.userId}"</c:if>
	                    	<c:if test="${param.openType eq 'replyAllandAccessory'}">value="${requestScope.userId}"</c:if>
	                    	id="empId"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th>抄送：</th>
	                    <td><span class="fr" onclick="$(this).next('input').click()"></span>
	                        <input onclick="selectUser('1','mailcc','mailccid','*0*');" class="edit-ipt-r edit-ipt-arrow" type="text" readonly value="${mailCc}" id="mailcc" name="mailcc" placeholder="请选择"/>
	                        <input type="hidden" value="${mailccId}" name="mailccid" id="mailccid"/>
	                    </td>
	                </tr>
	                <tr>
	                    <th>主题<i class="fa fa-asterisk"></i>：</th>
	                    <td><input placeholder="请输入" class="edit-ipt-r" type="text" id="mailsubject" name="mailsubject" value="${empty mailreplySub ? title : mailreplySub}"/></td>
	                </tr>
	                <tr>
	                    <th>发送选项：</th>
	                    <td>
	                        <ul class="edit-radio">
	                            <li><span class="edit-radio-l">紧急</span><input type="hidden" name="maillevel" value="${empty mailLevel ? '0' : mailLevel}"/></li>
	                            <li><span class="edit-radio-l">回执</span><input type="hidden" name="mailneedrevert" value="${empty mailNeedRevert ? '0' : mailNeedRevert}"/></li>
	                            <li><span class="edit-radio-l">签名</span><input type="hidden" name="mailSign" value="${empty mailSign ? '0' : mailSign}"/></li>
	                            <li><span class="edit-radio-l">匿名</span><input type="hidden" name="mailanonymous" value="${empty mailAnonymous ? '0' : mailAnonymous}"/></li>
	                        </ul>
	                    </td>
	                </tr>
	                <tr>
	                    <th>附件：</th>
	                    <td>
	                        <ul class="edit-upload">
	                            <li class="edit-upload-in" onclick="addImg();"><span><i class="fa fa-plus"></i></span></li>
	                        </ul>
	                        <input type="hidden" id="fileSizeCount" name="fileSizeCount" value="0"/>
	                    </td>
	                </tr>
                    <c:if test="${(param.openType eq 'forward' || param.openType eq 'sendAgain' || param.openType eq 'replyAllandAccessory') && not empty realFileNames}">
		                <tr>
		                	<td colspan="2">
			                        <c:set var="realFileNames">${realFileNames}</c:set> 
			                        <c:set var="saveFileNames">${saveFileNames}</c:set> 
			                        <%
				                        //真实文件名
										String realFileNames = pageContext.getAttribute("realFileNames") != null ? pageContext.getAttribute("realFileNames").toString() : "";
										//保存文件名
										String saveFileNames = pageContext.getAttribute("saveFileNames") != null ? pageContext.getAttribute("saveFileNames").toString() : "";
										String[] realFileNamesArray = realFileNames.split("\\|");
										String[] saveFileNamesArray = saveFileNames.split("\\|");
										for(int i=0,length=realFileNamesArray.length;i<length;i++){%>
					                        <input type="hidden" name="imgName" value="<%=realFileNamesArray[i] %>"/>
					                        <input type="hidden" name="imgSaveName" value="<%=saveFileNamesArray[i] %>"/>
										<%}
									%>
									<div class="wh-article-atta">
										<c:if test="${not empty realFileNames}">
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="<%=realFileNames %>" />
												<jsp:param name="saveFileNames" value="<%=saveFileNames %>" />
												<jsp:param name="moduleName" value="innerMailbox" />
											</jsp:include>
										</c:if>
									</div>
		                	</td>
		                </tr>
                    </c:if>
	                <tr>
	                    <th>正文：</th>
	                    <td></td>
	                </tr>
	                <tr>
	                    <td colspan="2">
	                        <div class="edit-txta-box">
	                        <c:set var="content">${empty mailreplyContent ? content : mailreplyContent}</c:set> 
	                        <%
		                		String newContent = (String)pageContext.getAttribute("content");
							    newContent = com.whir.component.util.StringUtils.resizeImgSize(newContent, "240", "");
		                		//newContent = newContent.replaceAll("<br/>通过以下链接地址直接查看详情：<br/>", "");
		                		//newContent = newContent.replaceAll("<a[^>]+WorkFlowProcAction+([^>]+?)>.*?</a>", "");
		                		//newContent = newContent.replaceAll("<a[^>]+BoardRoomAction.do\\?action=selectBoardroomApplyView+([^>]+?)>.*?</a>", "");
		                		//newContent = newContent.replaceAll("<a[^>]+GovReceiveFileBoxAction.do\\?action=load+([^>]+?)>.*?</a>", "");
		                		//newContent = newContent.replaceAll("<a[^>]+GovSendFileLoadAction.do\\?action=load+([^>]+?)>.*?</a>", "");
		                		//newContent = newContent.replaceAll("<a[^>]+GovReceiveFileLoadAction.do\\?action=load+([^>]+?)>.*?</a>", "");
		                		//newContent = newContent.replaceAll("<a[^>]+boardRoom!selectBoardroomApplyView.action+([^>]+?)>.*?</a>", "");
		                		//newContent = newContent.replaceAll("<.?((?i)a).*?>","");
		                		newContent.replaceAll("<a href[^>]*>","").replaceAll("</a>","");
		                		newContent = newContent.replaceAll("<br>","\n");
		   
		                		
							%>
							<c:set var="newContent"><%=newContent %></c:set> 
							<c:choose>
							<c:when test="${param.openType eq 'reply'}">
					  			<textarea onmousedown="cursorReset(event,this)" id="mailcontent" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								
								
								
								
								                         ${newContent}
								</textarea>	
					  		</c:when>					  		
							<c:when test="${param.openType eq 'forward'}">
					  		    <textarea id="mailcontent" onmousedown="cursorReset(event,this)" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								
								
								
								
								                          ${newContent}
								</textarea>	
					  		</c:when>
						  	<c:when test="${param.openType eq 'replyAll'}">
						  		<textarea id="mailcontent" onmousedown="cursorReset(event,this)" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								
								
								
								
								                          ${newContent}
								</textarea>		
						  	</c:when>
						  	<c:when test="${param.openType eq 'sendAgain'}">
						  		<textarea id="mailcontent" onmousedown="cursorReset(event,this)" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">
								
								
								
								
								                          ${newContent}
								</textarea>		
						  	</c:when>
					  		<c:otherwise>
				                <textarea id="mailcontent" onmousedown="cursorReset(event,this)" name="mailcontent" class="edit-txta edit-txta-l" placeholder="请输入文字" style="min-height:20rem">${newContent}</textarea>	
							</c:otherwise>
					  		</c:choose>
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
                <a href="javascript:sendMail();" class="fbtn-matter col-xs-6 fbtn-single" id="sendMail"><i class="fa fa-check-square"></i>发送</a>
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
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>


<script type="text/javascript">
    $(function(){
    	//多选
        $(".edit-radio li").click(function(){
        	if($(this).attr("class")){
        		$(this).find("input:hidden").val("0");
        		$(this).removeClass('radio-active');
        	}else{
        		if($(this).index() == 0){
	        		$(this).find("input:hidden").val("2");
	        	}else{
	        		$(this).find("input:hidden").val("1");
	        	}
	        	$(this).addClass('radio-active');
        	}
        });
    	//标记紧急程度等选项
    	mark();
    });
    
    //绑定发送点击事件
    function sendMail(){
    	if(!checkForm()){
	    	return false;
	    }
		ajaxSendMail();
    }
    //正文光标定位
    function cursorReset(e,a){
		if ( e && e.preventDefault )
		e.preventDefault();
		else 
		window.event.returnValue=false;
		a.focus();
	}
    
    //ajax方式发送邮件
    function ajaxSendMail(){
    	var loadingDialog = openTipsDialog('正在发送...');
	    //计算附件总大小
	    var fileSize = 0;
	    $("input[id^='img_save_name_']").each(function(){
	    	fileSize += parseFloat($(this).data("filesize"));
	    });
	    $("#fileSizeCount").val(fileSize);
	    $.ajax({
	    	url : 'sendMail.controller',
	    	data : $('#sendForm').serialize(),
	    	type : 'post',
	    	success : function(data){
	    		loadingDialog.close();
	    		if(!data){
	    			//openTipsDialog('邮件发送失败！','',1000);
	    			alert('邮件发送失败！');
	    		}
	    		var json = eval("("+data+")");
	    		if(json.result == 'fail'){
	     			//openTipsDialog('邮件发送失败！','',1000);
	    			alert('邮件发送失败！');
	    		}else if(json.result == 'success'){
	     			openTipsDialog('邮件发送成功！','',1000);
	    			//alert('邮件发送成功！');
	     			window.location = 'mailBox.controller?homePage='+<%=homePage%>;
	    		}
	    	},
	    	error : function(){
	    		//openTipsDialog('邮件发送异常！','',1000);
    			alert('邮件发送异常！');
	    	}
	    });
    }
    
    //校验表单
    function checkForm(){
    	var empName = $('#empName').val();
    	var empId = $('#empId').val();
    	var mailsubject = $('#mailsubject').val();
    	var mailcontent = $('#mailcontent').val();
    	if(!empName || !empId){
    		alert('请选择收件人！');
    		return false;
    	}
    	if(!mailsubject){
    		alert('请输入主题！');
    		return false;
    	}
    	return true;
    }
    
    //标记紧急程度等选项
    function mark(){
    	var mailLevel = '${mailLevel}';
    	var mailNeedRevert = '${mailNeedRevert}';
    	var mailSign = '${mailSign}';
    	var mailAnonymous = '${mailAnonymous}';
    	if(mailLevel != '0' && mailLevel != ''){
    		$('input[name=maillevel]').parent().addClass('radio-active');
    	}
    	if(mailNeedRevert != '0' && mailNeedRevert != ''){
    		$('input[name=mailneedrevert]').parent().addClass('radio-active');
    	}
    	if(mailSign != '0' && mailSign != ''){
    		$('input[name=mailSign]').parent().addClass('radio-active');
    	}
    	if(mailAnonymous != '0' && mailAnonymous != ''){
    		$('input[name=mailanonymous]').parent().addClass('radio-active');
    	}
    }
    
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
		       '<input type="hidden" id="img_save_name_'+index+'" name="imgSaveName" data-filesize="0"/>'+
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
			url: '/defaultroot/upload/fileUpload.controller?modelName=innerMailbox', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				//alert(1);
				$("#img_save_name_"+(index-1)).val(msg.data);
				$("#img_save_name_"+(index-1)).data("filesize",msg.fileSize);
				$("#img_name_"+(index-1)).val(fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				//alert(2);
				alert("文件上传失败！");
			}
		});
	}

	//选择人员
	function selectCallBack(input ){
		if( $(input).val() != ""){
			$(input).prev('span').html($(input).val());
			$(input).hide();
		}else{
			$(input).prev('span').html($(input).val());
			$(input).show();
		}
	}

	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		var dialog = openTipsDialog('正在加载...');
		$.ajax({
			url : '/defaultroot/person/newsearch.controller?flag=user',
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':$('#'+selectId).val(),'range':range},
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
	
</script>
