<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
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
<body>
<c:if test="${not empty docXml}">
<x:parse xml="${docXml}" var="doc"/>
<c:set var="hasbackbutton"><x:out select="$doc//workInfo/havebackbutton/text()"/></c:set>
<c:set var="modibutton"><x:out select="$doc//workInfo/modibutton/text()"/></c:set>
<c:set var="wfworkId"><x:out select="$doc//wf_work_id/text()"/></c:set>
<c:set var="workcurstep"><x:out select="$doc//workInfo/workcurstep/text()"/></c:set>
<c:set var="worktitle"><x:out select="$doc//workInfo/worktitle/text()"/></c:set>
<c:set var="worksubmittime"><x:out select="$doc//workInfo/worksubmittime/text()"/></c:set>
<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
<c:set var="trantype"><x:out select="$doc//workInfo/trantype/text()"/></c:set>
<c:if test="${not empty EmpLivingPhoto}"><c:set var="EmpLivingPhoto">/defaultroot/upload/peopleinfo/${EmpLivingPhoto}</c:set></c:if>
<section class="wh-section wh-section-bottomfixed">
    <article class="wh-edit wh-edit-document">
        <div class="wh-container">
            <div class="wh-article-lists">
                <ul>
                    <li>
                    	<strong class="document-icon">
                    		<img src="${EmpLivingPhoto eq '' || EmpLivingPhoto eq null ? '/defaultroot/evo/weixin/images/head.png' : EmpLivingPhoto}">
                    	</strong>
                    	<p>
	                    	<a href="javascript:void(0);"><c:if test="${fn:indexOf(workcurstep,'办理完毕') == -1}"><em class="not-over">未完成</em></c:if>${worktitle}当前环节为${workcurstep}</a>
	                    	<span>（${fn:substring(worksubmittime,0,16)}）</span>
                    	</p>
                    </li> 
                </ul>
            </div>
            <form id="sendForm" class="dialog" action="/defaultroot/workflow/sendnew.controller" method="post">
            	<c:if test="${not empty govDocXml}">
            		<x:parse xml="${govDocXml}" var="govDoc"/>
            		<table class="wh-table-edit">
	            		<x:if select="$govDoc//sendFileCheckTitle">
		            		<tr>
		            			<th>标题</th>
		            			<td><x:out select="$govDoc//sendFileCheckTitle/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//sendFileCheckComeUnit">
		            		<tr>
		            			<th>来文单位</th>
		            			<td><x:out select="$govDoc//sendFileCheckComeUnit/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//docSaveFile/file">
		            		<tr>
		            			<th>查看正文</th>
		            			<td>
									<%
									StringBuilder docSaveFiles = new StringBuilder();
									StringBuilder docRealFiles = new StringBuilder();
									%>
									<x:forEach select="$govDoc//docSaveFile/file" var="file" >
										<c:set var="saveFile" ><x:out select="$file/text()" /></c:set>
										<%
										docSaveFiles.append(pageContext.getAttribute("saveFile").toString()).append("|");
										%>
									</x:forEach>
									<x:forEach select="$govDoc//docSaveFile/file" var="file" >
										<c:set var="realFile" ><x:out select="$file/text()" /></c:set>
										<%
										docRealFiles.append(pageContext.getAttribute("realFile").toString()).append("|");
										%>
									</x:forEach>
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=docSaveFiles.toString() %>" />
										<jsp:param name="saveFileNames" value="<%=docRealFiles.toString() %>" />
										<jsp:param name="moduleName" value="govdocumentmanager" />
									</jsp:include>
		            			</td>
		            		</tr>
	            		</x:if>
	            		<tr>
	            			<th>附件</th>
	            			<td>
	            				<x:if select="$govDoc//realFile/file">
									<%
									StringBuilder saveFiles = new StringBuilder();
									StringBuilder realFiles = new StringBuilder();
									%>
									<x:forEach select="$govDoc//saveFile/file" var="file" >
										<c:set var="saveFile" ><x:out select="$file/text()" /></c:set>
										<%
										saveFiles.append(pageContext.getAttribute("saveFile").toString()).append("|");
										%>
									</x:forEach>
									<x:forEach select="$govDoc//realFile/file" var="file" >
										<c:set var="realFile" ><x:out select="$file/text()" /></c:set>
										<%
										realFiles.append(pageContext.getAttribute("realFile").toString()).append("|");
										%>
									</x:forEach>
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=realFiles.toString() %>" />
										<jsp:param name="saveFileNames" value="<%=saveFiles.toString() %>" />
										<jsp:param name="moduleName" value="govdocumentmanager" />
									</jsp:include>
								</x:if> 
	            			</td>
	            		</tr>
	            		<c:set var="field1"><x:out select="$govDoc//field1/text()"/></c:set> 
	            		<c:if test="${field1 !='' }">
		            		<tr>
		            			<th>备用字段1</th>
		            			<td><x:out select="$govDoc//field1/text()"/></td>
		            		</tr>
	            		</c:if>
	            		
	            		<c:set var="field2"><x:out select="$govDoc//field2/text()"/></c:set> 
	            		<c:if test="${field2 !='' }">
		            		<tr>
		            			<th>备用字段2</th>
		            			<td><x:out select="$govDoc//field2/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:set var="field3"><x:out select="$govDoc//field3/text()"/></c:set> 
	            		<c:if test="${field3 !='' }">
		            		<tr>
		            			<th>备用字段3</th>
		            			<td><x:out select="$govDoc//field3/text()"/></td>
		            		</tr>
	            		</c:if>
	            		
	            		<c:set var="field4"><x:out select="$govDoc//field4/text()"/></c:set> 
	            		<c:if test="${field4 !='' }">
		            		<tr>
		            			<th>备用字段4</th>
		            			<td><x:out select="$govDoc//field4/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:set var="field5"><x:out select="$govDoc//field5/text()"/></c:set> 
	            		<c:if test="${field5 !='' }">
		            		<tr>
		            			<th>备用字段5</th>
		            			<td><x:out select="$govDoc//field5/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:set var="field6"><x:out select="$govDoc//field6/text()"/></c:set> 
	            		<c:if test="${field6 !='' }">
		            		<tr>
		            			<th>备用字段6</th>
		            			<td><x:out select="$govDoc//field6/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:set var="field7"><x:out select="$govDoc//field7/text()"/></c:set> 
	            		<c:if test="${field5 !='' }">
		            		<tr>
		            			<th>备用字段7</th>
		            			<td><x:out select="$govDoc//field7/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:set var="field8"><x:out select="$govDoc//field8/text()"/></c:set> 
	            		<c:if test="${field8 !='' }">
		            		<tr>
		            			<th>备用字段8</th>
		            			<td><x:out select="$govDoc//field8/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:set var="field10"><x:out select="$govDoc//field10/text()"/></c:set> 
	            		<c:if test="${field10 !='' }">
		            		<tr>
		            			<th>备用字段9</th>
		            			<td><x:out select="$govDoc//field10/text()"/></td>
		            		</tr>
	            		</c:if>
	            		<c:if test="${param.flag !='ed'}">
	            		 <c:set var="commentFieldName"><x:out select="$doc//workInfo/commentFieldName/text()"/></c:set>
	            		 <c:if test="${commentFieldName !='' }">
							<tr>
								<th>
									${commentFieldName }
								</th>
								<td>
									<!-- <row><label style="color: #330000"><x:out select="$govDoc//doComment/text()" /> -->
									<textarea class="edit-txta edit-txta-l" placeholder="请输入文字" name="comment_input" id="comment_input" maxlength="300"></textarea>
									<div class="examine" style="text-align:right;">
										<a class="edit-select edit-ipt-r">
											<div class="edit-sel-show">
												<span>常用审批语</span>
											</div>    
											<select class="btn-bottom-pop" onchange="selectComment(this);">
												<option value="0">常用审批语</option> 
											 <x:forEach select="$doc//officelist" var="selectvalue" >
												<option value='<x:out select="$selectvalue/text()"/>'><x:out select="$selectvalue/text()"/></option>
										     </x:forEach>
											</select>
										</a>
									</div>
								</td>
							</tr>
							</c:if>
							</c:if>
							<x:if select="$govDoc//comment/sendFileCheckWriterComment">
	            				<tr>
			            			<th><x:out select="$govDoc//comment/sendFileCheckWriterComment/@name"/></th>
			            			<td>
			            				<c:set var="sendFileCheckWriterComment"><x:out select="$govDoc//comment/sendFileCheckWriterComment/text()" escapeXml="false"/></c:set> 
			            				${fn:replace(sendFileCheckWriterComment,'.0', '')}
			            			</td>
			            		</tr>
		            		</x:if>
		            		<x:if select="$govDoc//comment/sendFileCheckFinishDate">
	            				<tr>
			            			<th><x:out select="$govDoc//comment/sendFileCheckFinishDate/@name"/></th>
			            			<td>
			            				<c:set var="sendFileCheckFinishDate"><x:out select="$govDoc//comment/sendFileCheckFinishDate/text()" escapeXml="false"/></c:set>
			            				${fn:replace(sendFileCheckFinishDate,'.0', '')}
			            			</td>
			            		</tr>
		            		</x:if>
		            		<x:if select="$govDoc//comment/sendFileCheckLeaderComment">
	            				<tr>
			            			<th><x:out select="$govDoc//comment/sendFileCheckLeaderComment/@name"/></th>
			            			<td>
			            				<c:set var="sendFileCheckLeaderComment"><x:out select="$govDoc//comment/sendFileCheckLeaderComment/text()" escapeXml="false"/></c:set>
			            				${fn:replace(sendFileCheckLeaderComment,'.0', '')}
			            			</td>
			            		</tr>
		            		</x:if>
	            		<!--退回意见begin-->
						<c:set var="dealTipsContent" ><x:out select="$doc//dealTipsContent/text()" escapeXml="false" /></c:set>
						<c:if test="${not empty dealTipsContent}">
							<c:if test="${fn:indexOf(dealTipsContent,'加签提示') == -1}">
								<tr>
									<th>退回意见：</th>
									<td id="dealTipsContent">${dealTipsContent}</td>
								</tr>
							</c:if>
						</c:if>
						<!--退回意见end-->
            		</table>
            		<input type="hidden" name="tableId" value="<%=workId%>" />
					<input type="hidden" name="recordId" value="<x:out select="$doc//workInfo/workrecord_id/text()"/>" />
					<input type="hidden" name="activityId" value="<x:out select="$doc//workInfo/initactivity/text()"/>" />
					<input type="hidden" name="workId" value="<x:out select="$doc//workInfo/wf_work_id/text()"/>" />
					<input type="hidden" name="stepCount" value="<x:out select="$doc//workInfo/workstepcount/text()"/>" />
					<input type="hidden" name="isForkTask" value="<x:out select="$doc//isForkTask/text()"/>" />
					<input type="hidden" name="forkStepCount" value="<x:out select="$doc//forkStepCount/text()"/>" />
					<input type="hidden" name="forkId" value="<x:out select="$doc//forkId/text()"/>" />
					<input type="hidden" name="activityclass" value="<x:out select="$doc//activityClass/text()"/>" />
					<input type="hidden" name="commentType" value="0" />
					<input type="hidden" name="pass_title" value="" />
					<input type="hidden" name="pass_time" value="" />
					<input type="hidden" name="pass_person" value="" />
					<input type="hidden" name="__sys_operateType" value="2" />
					<input type="hidden" name="__sys_infoId" value='<x:out select="$doc//paramList/workrecord_id/text()"/>' />
					<input type="hidden" name="__sys_pageId" value='<x:out select="$doc//paramList/worktable_id/text()"/>' />
					<input type="hidden" name="__sys_formType" value='<x:out select="$doc//paramList/formType/text()"/>' />	
					<input type="hidden" name="__main_tableName" value='<x:out select="$doc//fieldList/tableName/text()"/>' />	
					<input type="hidden" name="actiCommFieldType" value='<x:out select="$doc//workInfo/actiCommFieldType/text()"/>' />
					<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
					<input type="hidden" name="trantype" value='<x:out select="$doc//workInfo/trantype/text()"/>' />
					<x:if select="$doc//workInfo/commentmustnonull" var="commentmustnonull">
						<input type="hidden" name="commentmustnonull" value='<x:out select="$doc//workInfo/commentmustnonull/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/backnocomment" var="backnocomment">
						<input type="hidden" name="backnocomment" value='<x:out select="$doc//workInfo/backnocomment/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/backMailRange" var="backMailRange">
						<input type="hidden" name="backMailRange" value='<x:out select="$doc//workInfo/backMailRange/text()"/>' />
					</x:if>
					<x:if select="$doc//workInfo/smsRight" var="smsRight">
						<input type="hidden" name="smsRight" value='<x:out select="$doc//workInfo/smsRight/text()"/>' />
					</x:if>
					<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
					<input type="hidden" name="worktitle" value="${worktitle}">
					<input type="hidden" name="workcurstep" value="${workcurstep}">
					<input type="hidden" name="worksubmittime" value="${worksubmittime}">
					<input type="hidden" name="workStatus" value="0">
            	</c:if>
            </form>
        </div>
    </article>
</section>
</c:if>
<c:if test="${param.workStatus ne '102'}">
	<c:choose>
		<c:when test="${param.workStatus eq '0'}">
			<footer class="wh-footer wh-footer-forum">
		    <div class="wh-wrapper">
	        <div class="wh-container">
            <div class="wh-footer-btn">
            	<div class="fbtn-more-nav">
                    <div class="fbtn-more-nav-inner">
                    	<c:if test="${fn:indexOf(modibutton,'Tran') >0}">
                        	<a href="javascript:$('#tranInfoForm').submit();" class="fbtn-matter col-xs-12"><i class="fa fa-share"></i>转办</a>
                        </c:if>
                        <c:if test="${fn:indexOf(modibutton,'AddSign') >0}">
                        	<a href="javascript:$('#addSignForm').submit();" class="fbtn-matter col-xs-12"><i class="fa fa-plus"></i>加签</a>
                        </c:if>
                        <c:if test="${fn:indexOf(modibutton,'Selfsend') >0}">
                        	<a href="javascript:$('#selfsendForm').submit();" class="fbtn-matter col-xs-12"><i class="fa fa-plus"></i>阅件</a>
                        </c:if>
                    </div>
                    <div class="fbtn-more-nav-arrow"></div>
                </div>
               <c:choose>
                <c:when test="${hasbackbutton == 'true' }">
	               	<a href="javascript:subBackForm();" class="fbtn-cancel col-xs-5"><i class="fa fa-arrow-left"></i>退回</a>
	                <a href="javascript:subForm();" class="fbtn-matter col-xs-5"><i class="fa fa-check-square"></i>发送</a>
                </c:when>
                <c:otherwise>
	                <a href="javascript:subForm();" class="fbtn-matter col-xs-10"><i class="fa fa-check-square"></i>发送</a>
                </c:otherwise>
               </c:choose>
               <span id="fbtnMore" class="fbtn-matter col-xs-2"><i class="fa fa-bars"></i></span>
            </div>
	        </div>
		    </div>
			</footer>
		</c:when>
		<c:when test="${param.workStatus eq '2'}">
			<footer class="wh-footer wh-footer-forum">
			    <div class="wh-wrapper">
			        <div class="wh-container">
			            <div class="wh-footer-btn">
							<a href="javascript:workfolwSend('${wfworkId}');" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>发送</a>
			            </div>
			        </div>
			    </div>
			</footer>
		</c:when>
		<c:when test="${param.workStatus eq '101'}">
			<c:if test="${fn:indexOf(workcurstep,'办理完毕') == '-1'}">
			<footer class="wh-footer wh-footer-forum">
		    <div class="wh-wrapper">
	        <div class="wh-container">
            <div class="wh-footer-btn">
           	<c:choose>
           		<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') >0}">
           			<a href="javascript:workfolwUndo('${wfworkId}');" class="fbtn-cancel col-xs-6"><i class="fa fa-retweet"></i>撤办</a>
           			<a href="javascript:document.getElementById('sendFormAgain').submit();" class="fbtn-matter col-xs-6"><i class="fa fa-thumb-tack"></i>催办</a>
           		</c:when>
           		<c:when test="${fn:indexOf(modibutton,'Undo') >0 && fn:indexOf(modibutton,'Wait') <=0}">
           			<a href="javascript:workfolwUndo('${wfworkId}');" class="fbtn-cancel col-xs-6 fbtn-single"><i class="fa fa-retweet"></i>撤办</a>
           		</c:when>
           		<c:when test="${fn:indexOf(modibutton,'Undo') <=0 && fn:indexOf(modibutton,'Wait') >0}">
           			<a href="javascript:document.getElementById('sendFormAgain').submit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-thumb-tack"></i>催办</a>
           		</c:when>
           	</c:choose>
            </div>
	        </div>
		    </div>
			</footer>
			</c:if>
		</c:when>
		<c:when test="${param.workStatus eq '1100'}">
			<c:if test="${fn:indexOf(modibutton,'Wait') >0}">
			<footer class="wh-footer wh-footer-forum">
		    	<div class="wh-wrapper">
		        <div class="wh-container">
	            <div class="wh-footer-btn">
				<a href="javascript:document.getElementById('sendFormAgain').submit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>催办</a>
	            </div>
		        </div>
			    </div>
			</footer>
			</c:if>
		</c:when>
	</c:choose>
</c:if>
<form id="sendFormAgain" action="/defaultroot/dealfile/pressInfo.controller?workId=${wfworkId}&amp;smsRight=${wfsmsRight }" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="1100">
</form>
<form id="backForm" action="/defaultroot/workflow/back.controller" method="post">
	<input type="hidden" name="workId" value="<%=workId%>">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
	<input type="hidden" name="tableId" value='<x:out select="$doc//workInfo/worktable_id/text()"/>'>
	<input type="hidden" name="recordId" value='<x:out select="$doc//workInfo/workrecord_id/text()"/>'>
	<input type="hidden" name="stepCount" value='<x:out select="$doc//workInfo/workstepcount/text()"/>'>
	<input type="hidden" name="forkId" value='<x:out select="$doc//workInfo/forkId/text()"/>'>
	<input type="hidden" name="forkStepCount" value='<x:out select="$doc//workInfo/forkStepCount/text()"/>'>
	<input type="hidden" name="isForkTask" value='<x:out select="$doc//workInfo/isForkTask/text()"/>'>
	<input type="hidden" name="curCommField" value='<x:out select="$doc//workInfo/commentField/text()"/>' />
</form>
<!----------阅件开始---------->
<form id="selfsendForm" class="dialog" action="/defaultroot/dealfile/selfSend.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------阅件结束---------->
<!----------转办开始---------->
<form id="tranInfoForm" class="dialog" action="/defaultroot/dealfile/tranInfo.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="trantype" value="${trantype}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------转办结束---------->
<!----------加签开始---------->
<form id="addSignForm" class="dialog" action="/defaultroot/dealfile/addSign.controller?workId=${wfworkId}" method="post">
	<input type="hidden" name="empLivingPhoto" value="${EmpLivingPhoto}">
	<input type="hidden" name="worktitle" value="${worktitle}">
	<input type="hidden" name="workcurstep" value="${workcurstep}">
	<input type="hidden" name="worksubmittime" value="${worksubmittime}">
	<input type="hidden" name="workStatus" value="0">
</form>
<!----------加签结束---------->
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript">
    var dialog = null;
    var flag = 1;//防止重复提交
    var backFlag = 1//防止退回重复提交
    function subForm(){
    	if(flag == 0){
    		return;
    	}
    	flag = 0;
    	$('#sendForm').submit();
    }
    function subBackForm(){
    	if(backFlag == 0){
    		return;
    	}
    	backFlag = 0;
    	$('#backForm').submit();
    }         
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
    
     $(function(){
        //更多菜单展开
        var fbtnMore = $("#fbtnMore");
        var fbtnMoreCon = $(".fbtn-more-nav");
        if(fbtnMoreCon.is(':visible')){
            fbtnMoreCon.hide();
            $(".wh-section").click(function(){
                fbtnMoreCon.hide();
            })
        }
        fbtnMoreCon.hide();
        fbtnMore.click(function(){
            fbtnMoreCon.toggle();
        });
    });
    
   	function workfolwSend(workId){
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/readover.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				if(data){
					var jsonData = eval('('+data+')');
					console.info(jsonData.result);
					if(jsonData.result = 'success'){
						alert('发送成功！');
						window.location = '/defaultroot/dealfile/list.controller?workStatus=0';
					}
				}else{
					alert('发送失败！');
				}
			},
			error : function(){
				alert('发送异常！');
			}
		});
	}
	
	function workfolwUndo(workId){
		var status = confirm('是否撤回该流程到您的待办文件中重新办理？');
        if(!status){
            return false;
        }
		var dialog = $.dialog({
	            content:"正在撤办中...",
	            title: 'load'
	        });
		var url ='/defaultroot/workflow/workfolwUndo.controller?workId='+workId;
		var openUrl ='/defaultroot/dealfile/list.controller?workStatus=101';
		$.ajax({
			type:'POST',
			url: url,
			async: true,
			dataType: 'text',
			success: function(data){
				if(dialog){
					dialog.close();
				}
				var json = eval("("+data+")");
				if(json!=null){
					if(json.result == 'success'){
						alert("撤办成功！");
						window.location.href =openUrl;
					}else{
						alert("撤办失败！");
					}
				}
			},
			error: function(){
				alert("异常！");
			}
		});
	}
	//选择批示意见
	function selectComment(obj){
		 var $selectObj = $(obj);
	     var selectVal = $selectObj.val();
	     if(selectVal == '0'){
	         selectVal = '';
	     }
	     var $textarea = $('#comment_input');
	     $textarea.val($textarea.val()+selectVal);
    }
</script>