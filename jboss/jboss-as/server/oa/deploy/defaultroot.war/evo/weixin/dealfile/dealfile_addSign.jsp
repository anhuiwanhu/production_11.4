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
String userId = session.getAttribute("userId").toString();
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
				<c:set var="scopeType"><x:out select="$doc//scopeType/text()"/></c:set>
				<input type="hidden" value="${param.workId}" name="workId"/>
				<input type="hidden" id="hasReceiveWf" value='<x:out select="$doc//sendedUser/text()"/>'/>
				<input type="hidden" id="isEzflow" value='<x:out select="$doc//isezflow/text()"/>'/>
				<table class="wh-table-edit">
					<tr>
						<th><i class="fa fa-asterisk"></i>选择办理人：</th>
						<td>
							<c:set var="scopeType"><x:out select="$doc//scopeType/text()"/></c:set>
							<x:if select="$doc//scopeType/text() = 'default_users' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='<x:out select="$doc//scopeId/text()"/>' />
			           			<input type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='<x:out select="$doc//scopeName/text()"/>' class="edit-ipt-r" />
							</x:if>
							<x:if select="$doc//scopeType/text() = 'scopes_user' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
			           			<input type="text" readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$doc//scopeId/text()"/>");' placeholder="请选择"/>
							</x:if>
							<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
			           			<input type="text" readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$doc//scopeId/text()"/>");' placeholder="请选择"/>
							</c:if>
						</td>
					</tr>
					<tr>
						<th><i class="fa fa-asterisk"></i>当前办理环节：</th>
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
                <a href="javascript:onSubmit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>确认加签</a>
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
	        content:"正在加签...",
	        title: 'load'
	    });
	}
	function onSubmit(){
	    var userId = '<%=userId%>';
	  	var cbUserId =$("#chooseUserId").val();
		var cbUserName = $("#chooseUserName").val();
		var isEzFlow = $("#isEzFlow").val();
		if(cbUserId == ""){
			alert("办理人不能为空！");
			return false;
		}
		var hasReceive = $('#hasReceiveWf').val();
		var hasArr = hasReceive.split(',');
		for(var i=0; i<hasArr.length;i++){
		if(isEzFlow == '1' || isEzFlow == 1){
			if(cbUserName.indexOf(hasArr[i]+',')>-1 || cbUserName.indexOf(userId+',')>-1){
				alert('加签办理人不能包含当前活动办理人！');
				return false;
			}
		}else{
			if(cbUserId.indexOf(hasArr[i]+',')>-1 || cbUserId.indexOf(userId+',')>-1){
				alert('加签办理人不能包含当前活动办理人！');
				return false;
			}
		}	
		}
		loadPage();
		var url ='/defaultroot/workflow/workflowAddSign.controller';
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
						alert("加签成功！");
						window.location.href =openUrl;
					}else{
						alert("加签失败！");
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
	
	//选人选组织代码-----开始
	function hiddenDiv(flag){
		if(flag==0){
			document.getElementById("dd").style.display="none";
			document.getElementById("user").style.display="";
		}else if(flag==1){
			document.getElementById("dd").style.display="";
			document.getElementById("user").style.display="none";
			document.getElementById("user").innerHTML="";
		}
	}
	
	/**
	 * range：选人范围
	 * selectUserId：赋值的用户ID，用于程序保存用
	 * selectUserName：赋值的用户名称，用于页面展示
	 * flag：user：选人；org：选组织
	 * selectType：选择类型，radio：单选；checkbox：多选
	 */
	function selectUserWithConditions(range,selectUserId,selectUserName,flag,selectType){
		var url_param ='/defaultroot/person/newsearch.controller';
		url_param +='?range='+range;
		
		var selectedUserId = document.getElementById(selectUserId).value;
		if(selectType =='radio'){//处理选中问题
			selectedUserId = selectedUserId + ",";
		}
		url_param += "&type=1";//文件办理中选人特有参数 0：文件办理选人字段 1：一般选人
		url_param += "&selectUserId="+selectUserId;
		url_param += "&selectUserName="+selectUserName;
		url_param += "&flag="+flag;
		url_param += "&selectType="+selectType;//选择类型
		url_param += "&selectedUserId="+selectedUserId;//已选中的赋值
		XHReq(url_param,'user', false, false);
		
		hiddenDiv(0);
	}
	//选人选组织代码-----结束
</script>