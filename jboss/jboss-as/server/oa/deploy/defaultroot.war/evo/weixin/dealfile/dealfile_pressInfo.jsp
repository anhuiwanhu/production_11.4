<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
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

String userName =session.getAttribute("userName") == null?"":session.getAttribute("userName").toString();
Date date = new Date(); 
DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm"); 
%>
<body>
	<section class="wh-section wh-section-bottomfixed">
	    <article class="wh-edit wh-edit-document">
	        <div>
	            <div class="wh-article-lists">
	           		<ul>
	                    <li>
	                    	<strong class="document-icon">
	                    		<img src="${param.empLivingPhoto eq '' || param.empLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : param.empLivingPhoto}">
	                    	</strong>
	                    	<p>
		                    	<a><c:if test="${fn:indexOf(param.workcurstep,'办理完毕') == -1}"><em class="not-over">未完成</em></c:if>${param.worktitle}当前环节为${param.workcurstep}</a>
		                    	<span>（${fn:substring(param.worksubmittime,0,16)}）</span>
	                    	</p>
	                    </li>
	                </ul>
	            </div>
	            <c:if test="${not empty docXml}">
					<x:parse xml="${docXml}" var="doc"/>
					<form id="sendForm" class="dialog" action="/defaultroot/workflow/workflowPress.controller" method="post">
						<input type="hidden" name="workId" id="workId" value="${param.workId}" />
						<input type="hidden" name="smsRight" id="smsRight" value="${param.smsRight}" />
						<table class="wh-table-edit">
							<tr>
								<th><i class="fa fa-asterisk"></i>被催办人：</th>
								<td>
									<x:if select="$doc//userList" var="userList">
										<x:forEach select="$doc//userList/user" var="n">
											<c:set var="userId"><x:out select="$n/userId/text()" /></c:set>
											<c:set var="userName"><x:out select="$n/userName/text()" /></c:set>
											<c:set var="userAccount"><x:out select="$n/userAccount/text()" /></c:set>
											<c:set var="orgName"><x:out select="$n/orgName/text()" /></c:set>
											<input type="checkbox" name="cbUserId" id="cbUserId" value="${userId },${userName }" >${userAccount }&lt;${userName }/${orgName }&gt;</checkbox>
										</x:forEach>
									</x:if>
								</td>
							</tr>
							<tr>
								<th><i class="fa fa-asterisk"></i>催办标题：</th>
								<td>
									<input type="text" class="edit-ipt-r" name="cbTitle" value='<x:out select="$doc//title/text()"/>'/>
								</td>
							</tr>
							<tr>
								<th><i class="fa fa-asterisk"></i>催办内容：</th>
								<td>
									<input type="text" class="edit-ipt-r" name="cbContent" value="请抓紧时间办理！"/>
								</td>
							</tr>
							<tr>
								<th><i class="fa fa-asterisk"></i>催办人：</th>
								<td>
									<input type="text" class="edit-ipt-r" name="userName" value="<%=userName%>" readonly />
								</td>
							</tr>
							<tr>
								<th><i class="fa fa-asterisk"></i>催办时间：</th>
								<td>
									<input type="text" class="edit-ipt-r" name="cbTime" value="<%=df.format(date)%>" readonly />
								</td>
							</tr>
						</table>
					</form>
				</c:if>
            </div>
		</article>
	</section>
   	<footer class="wh-footer wh-footer-text" id="footerButton">
	    <div class="wh-wrapper">
	        <div class="wh-container">
	            <div class="wh-footer-btn">
	                <a href="javascript:onSubmit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>发送催办</a>
	            </div>
	        </div>
	    </div>
	</footer>
<%--<nav class="Step3">
	<table>
		<tr>
			<td><%if("".equals(empLivingPhoto)){%><img src="/defaultroot/evo/weixin/images/p2.jpg" /><%}else{%><img src="/defaultroot/upload/peopleinfo/<%=empLivingPhoto%>" /><%}%></td>
			<td><a><%=worktitle%>当前环节为<%=workcurstep%><span>（<%=worksubmittime%>）</span></a></td>
			<td><%if(workcurstep.indexOf("办理完毕") == -1){%><span class="ts">未完成</span><%}%></td>
		</tr>
	</table>
</nav>
<c:if test="${not empty docXml}">
	<x:parse xml="${docXml}" var="doc"/>
	<form id="sendForm" class="dialog" action="/defaultroot/workflow/workflowPress.controller" method="post">
		<input type="hidden" name="workId" id="workId" value="${param.workId}" />
		<input type="hidden" name="smsRight" id="smsRight" value="${param.smsRight}" />
		<section class="Contain">
			<div class="CbForm1">
				<dl>
					<dt>
						<span class="erro"></span><em class="tt">被催办人：</em>
						<x:if select="$doc//userList" var="userList">
							<x:forEach select="$doc//userList/user" var="n">
								<c:set var="userId"><x:out select="$n/userId/text()" /></c:set>
								<c:set var="userName"><x:out select="$n/userName/text()" /></c:set>
								<c:set var="userAccount"><x:out select="$n/userAccount/text()" /></c:set>
								<c:set var="orgName"><x:out select="$n/orgName/text()" /></c:set>
								<input type="checkbox" name="cbUserId" id="cbUserId" value="${userId },${userName }" >${userAccount }&lt;${userName }/${orgName }&gt;</checkbox>
							</x:forEach>
						</x:if>
					</dt>

					<dt>
						<span class="erro"></span><em class="tt">催办标题：</em>
						<input type="text" class="txtms" name="cbTitle" value='<x:out select="$doc//title/text()"/>'/>
					</dt>

					<dt>
						<span class="erro"></span><em class="tt">催办内容：</em>
						<input type="text" class="txtms" name="cbContent" value="请抓紧时间办理！"/>
					</dt>

					<dt>
						<em class="tt">催办人：</em><input type="text" class="txt1" name="userName" value="<%=userName%>" readonly />
					</dt>

					<dt>
						<em class="tt">催办时间：</em><input type="text" class="txt1" name="cbTime" value="<%=df.format(date)%>" readonly />
					</dt>
				</dl>
			</div>
			<div class="Handler1">
				<a class="send" onclick="onSubmit();">发送催办</a>
			</div>
		</section>
	</form>
</c:if>
--%>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" language="javascript">
	function onSubmit(){
		var cbUserId ="";
		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/> 
			<x:if select="$doc//userList" var="userList">
				 $('input[name="cbUserId"]:checked').each(function(){ 
					cbUserId +=$(this).val() +"|";
				});
			</x:if>
		</c:if>
		if(cbUserId == ""){
			alert("被催办人不能为空！");
			return false;
		}
		var dialog = $.dialog({
	            content:"发送催办中...",
	            title: 'load'
	        });
		var url ='/defaultroot/workflow/workflowPress.controller';
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
						alert("催办成功！");
						window.location.href =openUrl;
					}else{
						alert("催办失败！");
					}
				}
			},
			error: function(){
				alert("异常！");
			}
		});
	}
</script>