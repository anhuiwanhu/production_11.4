<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
%>
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
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
</head>
<body>
<c:if test="${not empty docXml}"><!--1-->
	<x:parse xml="${docXml}" var="doc"/>
	<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
	<c:set var="wfsmsRight"><x:out select="$doc//smsRight/text()"/></c:set>
	<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
	<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
	<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
	<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
	<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
	<c:if test="${not empty EmpLivingPhoto}"><c:set var="EmpLivingPhoto">/defaultroot/upload/peopleinfo/${EmpLivingPhoto}</c:set></c:if>
	<section class="wh-section wh-section-bottomfixed" id="mainContent">
	    <article class="wh-edit wh-edit-document">
	        <div class="wh-container">
	            <div class="wh-article-lists">
	           		<ul>
	                    <li>
	                    	<strong class="document-icon">
	                    		<img src="${EmpLivingPhoto eq '' || EmpLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : EmpLivingPhoto}">
	                    	</strong>
	                    	<p>
		                    	<a><c:if test="${fn:indexOf(workcurstep,'办理完毕') == -1}"><em class="not-over">未完成</em></c:if>${worktitle}当前环节为${workcurstep}</a>
		                    	<span>（${fn:substring(worksubmittime,0,16)}）</span>
	                    	</p>
	                    </li>
	                </ul>
	            </div>
				<c:if test="${not empty docXml2}"><!--2-->
					<x:parse xml="${docXml2}" var="doc2"/>
	            	<table class="wh-table-edit">
						<!--主表信息begin-->
						<x:forEach select="$doc2//fieldList/field" var="fd" >
							<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
							<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
							<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
							<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
							<tr>
								<th><x:out select="$fd/name/text()"/><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>：</th>
								<td>
									<c:choose>
										<%--附件上传 115--%>
										<c:when test="${showtype =='115'}">
											<c:set var="values"><x:out select="$fd/value/text()"/></c:set>
											<c:if test="${not empty values}">
												<%
												String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="customform";
												String aValues =(String)pageContext.getAttribute("values");
												String[] aval  = aValues.split(";");
												String[] aval0=new String[0];
												String[] aval1=new String[0];
												if(aval[0] != null && aval[0].endsWith(",")) {
													saveFileNames =aval[0].substring(0, aval[0].length() -1);
													saveFileNames =saveFileNames.replaceAll(",","|");
												}
												if(aval[1] != null && aval[1].endsWith(",")) {
													realFileNames =aval[1].substring(0, aval[1].length() -1);
													realFileNames =realFileNames.replaceAll(",","|");
												}
												%>
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
													<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
													<jsp:param name="moduleName" value="<%=moduleName%>" />
												</jsp:include>
											</c:if>
										</c:when>
		
										<%--Word编辑 116--%>
										<c:when test="${showtype =='116'}">
											<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
											<c:if test="${not empty filename}">
												<%
												String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="information";
												realFileNames =(String)pageContext.getAttribute("filename")+".doc";
												saveFileNames =(String)pageContext.getAttribute("filename")+".doc";
												%>
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
													<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
													<jsp:param name="moduleName" value="<%=moduleName%>" />
												</jsp:include>
											</c:if>
										</c:when>
		
										<%--Excel编辑 117--%>
										<c:when test="${showtype =='117'}">
											<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
											<c:if test="${not empty filename}">
												<%
												String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="information";
												realFileNames =(String)pageContext.getAttribute("filename")+".xls";
												saveFileNames =(String)pageContext.getAttribute("filename")+".xls";
												%>
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
													<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
													<jsp:param name="moduleName" value="<%=moduleName%>" />
												</jsp:include>
											</c:if>
										</c:when>
		
										<%--WPS编辑 118--%>
										<c:when test="${showtype =='118'}">
											<c:set var="filename"><x:out select="$fd/value/text()"/></c:set>
											<c:if test="${not empty filename}">
												<%
												String realFileNames ="";
												String saveFileNames ="";
												String moduleName ="information";
												realFileNames =(String)pageContext.getAttribute("filename")+".wps";
												saveFileNames =(String)pageContext.getAttribute("filename")+".wps";
												%>
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
													<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
													<jsp:param name="moduleName" value="<%=moduleName%>" />
												</jsp:include>
											</c:if>
										</c:when>
		
										<%--批示意见 401--%>
										<c:when test="${showtype =='401' }">
											<x:forEach select="$fd//dataList/comment" var="ct" >
												<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
											</x:forEach>
										</c:when>
										<c:otherwise>
											<x:out select="$fd/value/text()"/>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:forEach>
						<!--主表信息end-->
						<!--子表信息begin-->
						<%--<c:set var="subTable" ></c:set>
						<x:forEach select="$doc2//subTableList/subTable/subFieldList" var="ct" varStatus="xh">
							<c:set var="subTable" >${xh.index+1}</c:set>
						</x:forEach>
						<c:if test="${ not empty subTable}">
						<tr>
							<th>子表填写：</th>
							<td>
								<input type="text" class="edit-ipt-r" readonly="readonly" value="${subTable}条子表数据" onclick="addSubTable(${param.workId});"/>
							</td>
						</tr>
						</c:if>
						--%>
						<x:forEach select="$doc2//subTableList/subTable" var="st">
							<c:set var="subTable"></c:set>
							<x:forEach select="$st/subFieldList" var="ct" varStatus="xh">
								<c:set var="subTable" >${xh.index+1}</c:set>
							</x:forEach>
							<c:set var="subName" ><x:out select="$st/name/text()"/></c:set>
							<c:set var="subTableName" ><x:out select="$st/tableName/text()"/></c:set>
							<input name="subTableName" value="${subTableName}" type="hidden" />
							<input name="subName" value="${subName}" type="hidden" />
							<tr>
								<th>子表填写：</th>
								<td>
									<input id="subTableInput" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
									<c:if test="${not empty subTable}">value="${subTable}条子表数据"</c:if>
									 readonly="readonly" onclick="addSubTable('${subTableName}');"/>
								</td>
							</tr>
						</x:forEach>
						<!--子表信息end-->
						
						<!--批示意见begin-->
						<x:forEach select="$doc2//commentList/comment" var="ct" >
							<c:set var="commentType"><x:out select="$ct//type/text()"/></c:set>
							<c:set var="commentContent"><x:out select="$ct//content/text()"/></c:set>
							<tr>
								<th><x:out select="$ct//step/text()"/>：</th>
								<td>
									<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
								</td>
							</tr>
						</x:forEach>
						<!--批示意见end-->
	
						<!--退回意见begin-->
						<c:set var="backcomment" ><x:out select="$doc//backComment/text()" escapeXml="false" /></c:set>
						<c:if test="${not empty backcomment}">
							<tr>
								<th>退回意见：</th>
								<td>${backcomment}</td>
							</tr>
						</c:if>
						<!--退回意见end-->
	            	</table>
					<form id="sendForm" class="dialog" action="/defaultroot/dealfile/pressInfo.controller?workId=${wfworkId}&amp;smsRight=${wfsmsRight }" method="post">
						<input type="hidden" name="empLivingPhoto" value="${empLivingPhoto}">
						<input type="hidden" name="worktitle" value="${worktitle}">
						<input type="hidden" name="workcurstep" value="${workcurstep}">
						<input type="hidden" name="worksubmittime" value="${worksubmittime}">
						<input type="hidden" name="workStatus" value="1100">
					</form>
	            </c:if>
            </div>
        </article>
	</section>
	<c:if test="${fn:indexOf(modibutton,'Wait') >0}">
		<footer class="wh-footer wh-footer-text" id="footerButton">
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:document.getElementById('sendForm').submit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>催办</a>
		            </div>
		        </div>
		    </div>
		</footer>
	</c:if>
</c:if><!--1-->
<jsp:include page="../common/include_workflow_subTable_view.jsp" flush="true">
	<jsp:param name="docXml" value="${docXml2}" />
	<jsp:param name="orgId" value="<%=orgId %>" />
</jsp:include>
<%--<section id="subtableContent" style="display:none">--%>
<%--</section>--%>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper/swiper.min.js"></script>
<script type="text/javascript">
	var dialog = null;
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    function pageLoaded(){
        if (document.readyState == "complete") {
            setTimeout(function(){
                dialog.close();
            },500);
        }
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
		}else if(flag==2){//显示子表 
			$("#mainContent").css("display","none");
			$("#footerButton").css("display","none");
			$("#subtableContent").css("display","block");
		}else if(flag==3){
			$("#subtableContent").css("display","none");
			$("#mainContent").css("display","block");
			$("#footerButton").css("display","block");
			$("#subtableContent").empty();
		}
	}

	//打开子表 
    /*function addSubTable(workId){
		pageLoading();
		var postUrl = '/defaultroot/dealfile/subprocess.controller?workId='+workId;
		$.ajax({
			url : postUrl,
			type : "post",
			data : {},
			success : function(data){
				$("#subtableContent").append(data);
				hiddenContent(2);
				if(dialog){
					dialog.close();
				}
			}
		});
		//window.open('/defaultroot/dealfile/subprocess.controller?workId='+workId);
	}*/
</script>