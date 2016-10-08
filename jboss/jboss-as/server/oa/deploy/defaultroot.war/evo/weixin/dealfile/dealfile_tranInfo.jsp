<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../common/taglibs.jsp"%>
<% 
	String userId = session.getAttribute("userId").toString();
%>
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
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>
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
		<div class="wh-container">
			<div class="wh-article-lists">
               <ul>
                   <li>
                   	<strong class="document-icon">
                   		<img src="${param.empLivingPhoto eq '' || param.empLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : param.empLivingPhoto}">
                   	</strong>
                   	<p>
                    	<a>${param.worktitle}当前环节为${param.workcurstep}</a>
                    	<span>（${fn:substring(param.worksubmittime,0,16)}）</span>
                   	</p>
                   </li>
               </ul>
            </div>
           	<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<form id="sendForm" class="dialog" action="/defaultroot/workflow/updateprocess2.controller" method="post">
				<input type="hidden" value="${param.workId}" name="workId"/>
				<table class="wh-table-edit">
					<tr>
						<th>选择办理人<i class="fa fa-asterisk"></i>：</th>
						<td>
							<c:set var="scopeType"><x:out select="$doc//scopeType/text()"/></c:set>
							<x:if select="$doc//scopeType/text() = 'default_users' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='<x:out select="$doc//scopeId/text()"/>' />
			           			<input type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='<x:out select="$doc//scopeName/text()"/>' class="edit-ipt-r" />
							</x:if>
							<x:if select="$doc//scopeType/text() = 'scopes_user' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
			           			<input placeholder="请选择" type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$doc//scopeId/text()"/>");'/>
							</x:if>
							<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
			           			<input placeholder="请选择" type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$doc//scopeId/text()"/>");'/>
							</c:if>
						</td>
					</tr>
					<tr>
						<th>当前办理环节<i class="fa fa-asterisk"></i>：</th>
						<td style="text-align:right">
							<%=workcurstep%>
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
                <a href="javascript:onSubmit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>确认转办</a>
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
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" language="javascript">
	var dialog = null;
	function loadPage(){
	    dialog = $.dialog({
	        content:"页面加载中...",
	        title: 'load'
	    });
	}
	
	function onSubmit(){ 
	    var userId = '<%=userId%>';
		var cbUserId =$("#chooseUserId").val();
		if(cbUserId == ""){
			alert("办理人不能为空！");
			return false;
		}
		if(cbUserId.indexOf(userId+',')>-1){
			alert('办理人中不能包含自己！');
			return false;
		}
		loadPage();
		var url ='/defaultroot/workflow/workflowTran.controller';
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
						alert("转办成功！");
						window.location.href =openUrl;
					}else{
						alert("转办失败！");
					}
				}
			},
			error: function(){
				alert("异常！");
			}
		});
	}
	 
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		loadPage();
		var selectIdVal = $('input[name="'+selectId+'"]').val();
		if(selectIdVal.indexOf('$') != -1){
			var selectIdArray = selectIdVal.split('$');
			if(selectIdArray){
				selectIdVal = '';
				for(var i=0,length=selectIdArray.length;i<length;i++){
					if(selectIdArray[i]){
						selectIdVal += selectIdArray[i] + ',';
					}
				}
			}
		}
		$.ajax({
			url : '/defaultroot/person/newsearch.controller?flag=user',
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':selectIdVal,'range':range},
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