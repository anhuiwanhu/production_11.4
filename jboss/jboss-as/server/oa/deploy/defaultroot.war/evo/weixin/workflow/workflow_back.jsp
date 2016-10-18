<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Expires" content="-1">
	<meta http-equiv="Cache-Control" content="no-cache">
	<meta http-equiv="Pragma" content="no-cache">
	<meta name="Author" content="万户网络">
	<meta content="万户网络 www.wanhu.com.cn" name="design">
	<title>文件办理</title>
	<link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<%
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
String worktitle = request.getParameter("worktitle")==null?"":request.getParameter("worktitle");
String workcurstep = request.getParameter("workcurstep")==null?"":request.getParameter("workcurstep");
String worksubmittime = request.getParameter("worksubmittime")==null?"":request.getParameter("worksubmittime");
String workStatus = request.getParameter("workStatus")==null?"":request.getParameter("workStatus");
%>
<body>
<section class="wh-section wh-section-bottomfixed" id="mainContent">
	<article class="wh-edit wh-edit-document">
		<div>
			<div class="wh-article-lists">
               <ul>
                   <li>
                   	<strong class="document-icon">
                   		<img src="${param.empLivingPhoto eq '' || param.empLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : param.empLivingPhoto}">
                   	</strong>
                   	<p>
                    	<a>${param.worktitle} 当前环节为：${param.workcurstep}</a>
                    	<span>（${fn:substring(param.worksubmittime,0,16)}）</span>
                   	</p>
                   </li>
               </ul>
            </div>
				<form id="sendForm" class="dialog" action="/defaultroot/workflow/backprocess.controller" method="post">
					<input type="hidden" name="workId" value="${param.workId}" />
					<input type="hidden" name="commentField" value="${param.curCommField}"/>
					<!--backMailRange 邮件提醒范围0:退回环节经办人1:所有办理人-->
					<input type="hidden" name="backMailRange" value="0"/>
					<!--needSmsRemind 是否短信提醒 0：不提醒  1：提醒-->
					<input type="hidden" name="needSmsRemind" value="0"/>
					<table class="wh-table-edit">
						<c:choose>
				            <c:when test="${not empty docXml}">
								<x:parse xml="${docXml}" var="doc"/>
								<tr>
									<th><i class="fa fa-asterisk"></i>退回环节：</th>
									<td>
										<select class="selt" name="activity" id="activity" prompt="请选择下一环节" onchange="getDealwithEmpName(this);">
											<option value="0">退回发起人</option>
											<x:forEach select="$doc//backWorkFlow" var="n" varStatus="status">
												<option value='<x:out select="$n/activityId/text()"/>;<x:out select="$n/activityName/text()"/>;<x:out select="$n/curstepcount/text()"/>;<x:out select="$n/dealwithEmpId/text()"/>;<x:out select="$n/dealwithEmpName/text()"/>;<x:out select="$n/forkStepCount/text()"/>' <c:if test="${status.count==1}">selected="true"</c:if> ><x:out select="$n/activityName/text()"/><x:if select="$n//dealwithEmpName/text() != 'null'">:<x:out select="$n/dealwithEmpName/text()"/></x:if></option>
											</x:forEach>
										</select>
									</td>
								</tr>
								<tr id="dealwithEmpName">
									<th><i class="fa fa-asterisk"></i>退回人：</th>
									<td>
										<x:forEach select="$doc//backWorkFlow" var="n" varStatus="status">
											<c:if test="${status.count==1}"><x:out select="$n/dealwithEmpName/text()"/></c:if>
										</x:forEach>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<th><i class="fa fa-asterisk"></i>退回环节：</th>
									<td>
										<select class="selt" name="activity" id="activity">
											<option value="0">退回发起人</option>
										</select>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
						<tr>
							<th><i class="fa fa-asterisk"></i>退回意见：</th>
							<td>
								<textarea name='comment' placeholder="请输入" onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );" class="edit-txta edit-txta-l" maxlength="300" id="backcomment"></textarea>
								<span class="edit-txta-num">300</span>
							</td>
						</tr>
					</table>
				</form>
		</div>
	</article>
</section>
<footer class="wh-footer wh-footer-text" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:onSubmit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>退回</a>
            </div>
        </div>
    </div>
</footer>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" language="javascript">
	var dialog = null;
	function loadPage(){
	    dialog = $.dialog({
	        content:"正在退回...",
	        title: 'load'
	    });
	}
	function getDealwithEmpName(obj){
		var selectedValues =$(obj).val();
		if(selectedValues =='0'){
			$("#dealwithEmpName").hide();
		}else{
			$("#dealwithEmpName").show();
			var selectedValues_obj =selectedValues.split(";");
			$("#dealwithEmpName").find("td").html(selectedValues_obj[4]);
		}
	}

	function onSubmit(){
		var backcomment = $("#backcomment").val();
		if(backcomment.replace(/\s/g,"")==""){
			alert("退回意见不能为空!");
		}else{
			loadPage();
			var url ='/defaultroot/workflow/backprocess.controller';
			var openUrl ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>';
			$.ajax({
				type: 'POST',
				url: url,
				data: $('#sendForm').serialize(),
				async: true,
				dataType: 'text',
				success: function(data){
					if(dialog){
						dialog.close();
					}
					var json = eval("("+data+")");
					if(json!=null){
						if(json.result == 'success'){
							alert("退回成功！");
							window.location.href =openUrl;
						}else{
							alert("退回失败！");
						}
					}
				},
				error: function(){
					alert("异常！");
				}
			});
		}
	}
</script>