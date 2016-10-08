<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.lang.*"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="../common/taglibs.jsp" %>
<%
String workId = request.getParameter("workId");
String orgId = session.getAttribute("orgId").toString();
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");

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
            		<c:set var="goldGridId"><x:out select="$govDoc//goldGridId/text()"/></c:set>
            		<c:set var="wordType"><x:out select="$govDoc//wordType/text()"/></c:set>
            		<table class="wh-table-edit">
	            		<x:if select="$govDoc//title">
		            		<tr>
		            			<th><x:out select="$govDoc//title/@name"/></th>
		            			<td><x:out select="$govDoc//title/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<tr>
	            			<th>查看正文</th>
	            			<td>
								<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="${goldGridId}${wordType}" />
									<jsp:param name="saveFileNames" value="${goldGridId}${wordType}" />
									<jsp:param name="moduleName" value="govdocumentmanager" />
								</jsp:include>
	            			</td>
	            		</tr>
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
	            		<x:if select="$govDoc//departWord">
		            		<tr>
		            			<th><x:out select="$govDoc//departWord/@name"/></th>
		            			<td><x:out select="$govDoc//departWord/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//zjkySeq">
		            		<tr>
		            			<th><x:out select="$govDoc//zjkySeq/@name"/></th>
		            			<td><x:out select="$govDoc//zjkySeq/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//securityGrade">
		            		<tr>
		            			<th><x:out select="$govDoc//securityGrade/@name"/></th>
		            			<td><x:out select="$govDoc//securityGrade/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//secrecyterm">
		            		<tr>
		            			<th><x:out select="$govDoc//secrecyterm/@name"/></th>
		            			<td><x:out select="$govDoc//secrecyterm/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//grade">
		            		<tr>
		            			<th><x:out select="$govDoc//grade/@name"/></th>
		            			<td><x:out select="$govDoc//grade/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//zjkyContentLevel">
		            		<tr>
		            			<th><x:out select="$govDoc//zjkyContentLevel/@name"/></th>
		            			<td><x:out select="$govDoc//zjkyContentLevel/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//topicWord">
		            		<tr>
		            			<th><x:out select="$govDoc//topicWord/@name"/></th>
		            			<td><x:out select="$govDoc//topicWord/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//mainToName">
		            		<tr>
		            			<th><x:out select="$govDoc//mainToName/@name"/></th>
		            			<td><x:out select="$govDoc//mainToName/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//copyToName">
		            		<tr>
		            			<th><x:out select="$govDoc//copyToName/@name"/></th>
		            			<td><x:out select="$govDoc//copyToName/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//writeOrg">
		            		<tr>
		            			<th><x:out select="$govDoc//writeOrg/@name"/></th>
		            			<td><x:out select="$govDoc//writeOrg/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//counterSign">
		            		<tr>
		            			<th><x:out select="$govDoc//counterSign/@name"/></th>
		            			<td><x:out select="$govDoc//counterSign/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//draft">
		            		<tr>
		            			<th><x:out select="$govDoc//draft/@name"/></th>
		            			<td><x:out select="$govDoc//draft/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//checkDate">
		            		<tr>
		            			<th><x:out select="$govDoc//checkDate/@name"/></th>
		            			<td><x:out select="$govDoc//checkDate/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//assumePeople">
		            		<tr>
		            			<th><x:out select="$govDoc//assumePeople/@name"/></th>
		            			<td><x:out select="$govDoc//assumePeople/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//printer">
		            		<tr>
		            			<th><x:out select="$govDoc//printer/@name"/></th>
		            			<td><x:out select="$govDoc//printer/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//assumePeople">
		            		<tr>
		            			<th><x:out select="$govDoc//assumePeople/@name"/></th>
		            			<td><x:out select="$govDoc//assumePeople/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//proof">
		            		<tr>
		            			<th><x:out select="$govDoc//proof/@name"/></th>
		            			<td><x:out select="$govDoc//proof/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//date">
		            		<tr>
		            			<th><x:out select="$govDoc//date/@name"/></th>
		            			<td><x:out select="$govDoc//date/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//sendDate">
		            		<tr>
		            			<th><x:out select="$govDoc//sendDate/@name"/></th>
		            			<td><x:out select="$govDoc//sendDate/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//printNumber">
		            		<tr>
		            			<th><x:out select="$govDoc//printNumber/@name"/></th>
		            			<td><x:out select="$govDoc//printNumber/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//toPersonBao">
		            		<tr>
		            			<th><x:out select="$govDoc//toPersonBao/@name"/></th>
		            			<td><x:out select="$govDoc//toPersonBao/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//sendTime">
		            		<tr>
		            			<th><x:out select="$govDoc//sendTime/@name"/></th>
		            			<td><x:out select="$govDoc//sendTime/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//toPersonBao">
		            		<tr>
		            			<th><x:out select="$govDoc//toPersonBao/@name"/></th>
		            			<td><x:out select="$govDoc//toPersonBao/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//openProperty">
		            		<tr>
		            			<th><x:out select="$govDoc//openProperty/@name"/></th>
		            			<td><x:out select="$govDoc//openProperty/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//toPersonInner">
		            		<tr>
		            			<th><x:out select="$govDoc//toPersonInner/@name"/></th>
		            			<td><x:out select="$govDoc//toPersonInner/text()"/></td>
		            		</tr>
	            		</x:if>
	            		<x:if select="$govDoc//accessoryDesc">
		            		<tr>
		            			<th><x:out select="$govDoc//accessoryDesc/@name"/></th>
		            			<td><x:out select="$govDoc//accessoryDesc/text()"/></td>
		            		</tr>
	            		</x:if>
	            		
						<x:if select="$govDoc//referenceAccessory">
							<tr>
								<th>
									参考文件
								</th>
								<td>
							 	<c:set var="realname"><x:out select="$govDoc//referenceAccessory//@saveName"/></c:set>
							 	<c:set var="filename"><x:out select="$govDoc//referenceAccessory/text()"/></c:set>
								<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="${realname}" />
									<jsp:param name="saveFileNames" value="${filename}" />
									<jsp:param name="moduleName" value="govdocumentmanager" />
								</jsp:include>
								</td>
							</tr>									
						</x:if> 
						<x:if select="$govDoc//referenceAccessoryDesc">
							<tr>
								<th>
									参考文件描述
								</th>
								<td> 
									<x:out select="$govDoc//referenceAccessoryDesc/text()"  /> 
								</td>
							</tr>
						</x:if> 
						<x:if select="$govDoc//sendFileFileType">
						<tr>
							<th>
								文件类别
							</th>
							<td> 
								<x:out select="$govDoc//sendFileFileType/text()"  /> 
							</td>
						</tr>
						</x:if> 
						<x:if select="$govDoc//documentFileType">
						<tr>
							<th>
								文件种类
							</th>
							<td> 
								<x:out select="$govDoc//documentFileType/text()"  /> 
							</td>
							</tr>
						</x:if> 
						<x:if select="$govDoc/output/data/baseData/field1">
							<tr>
								<th>
									<x:out select="$govDoc//field1/@name"/>
								</th>
								<td> 
									<c:set var="fieldtype"><x:out select="$govDoc//field1/@fieldDisplayType" /></c:set> 
									<c:choose>
										<c:when test="${fieldtype eq '13' }">
											<x:if select="$govDoc//field1/text() != 'null'">
											<c:set var="appName"><x:out select="$govDoc//field1/text()" /></c:set>
											<c:set var="filename"><x:out select="$govDoc//field1/text()" />.doc</c:set>
											<c:if test="${not empty filename}">
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${realname}" />
													<jsp:param name="saveFileNames" value="${filename}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>         			
											 </c:if>	
											 </x:if>
										</c:when>
										<c:when test="${fieldtype eq '14' }">
											<x:if select="$govDoc//field1/text() != 'null'">
											<c:set var="appName"><x:out select="$govDoc//field1/text()" /></c:set>
											<c:set var="filename"><x:out select="$govDoc//field1/text()" />.xls</c:set>
											<c:if test="${not empty filename}">
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${realname}" />
													<jsp:param name="saveFileNames" value="${filename}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>     			
											</c:if>	
											</x:if>
										</c:when>
										<c:when test="${fieldtype eq '17' }">
											<x:if select="$govDoc//field1/text() != 'null'">
												<c:set var="sc_fujian"><x:out select="$govDoc//field1/text()" /></c:set>
				            					<%
				            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
				            						String[] fujian_array=fujian_value.split(",");
				            					%>
				            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
								            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
						           			 	<c:if test="${not empty filename}">
						           			 		<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="${appNames}" />
														<jsp:param name="saveFileNames" value="${filenames}" />
														<jsp:param name="moduleName" value="govdocumentmanager" />
													</jsp:include>
					                	 		</c:if>
						                	 </x:if>
										</c:when>
										<c:otherwise>
											<x:out select="$govDoc//field1/text()" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field2">
							<tr>
								<th>
									<x:out select="$govDoc//field2/@name"/>
								</th>
								<td> 
									<c:set var="fieldtype"><x:out select="$govDoc//field2/@fieldDisplayType" /></c:set> 
									<c:set var="fieldvalue"><x:out select="$govDoc//field2/text()" /></c:set> 
									<c:choose>
										<c:when test="${fieldtype eq '13' }">
											<x:if select="$govDoc//field2/text() != 'null'">
												<c:set var="appName"><x:out select="$govDoc//field2/text()" /></c:set>
												<c:set var="filename"><x:out select="$govDoc//field2/text()" />.doc</c:set>
												<c:if test="${not empty filename}">
													<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="${appName}" />
														<jsp:param name="saveFileNames" value="${filename}" />
														<jsp:param name="moduleName" value="govdocumentmanager" />
													</jsp:include>       			
												</c:if>	
											</x:if>
										</c:when>
										<c:when test="${fieldtype eq '14' }">
											<x:if select="$govDoc//field2/text() != 'null'">
												<c:set var="appName"><x:out select="$govDoc//field2/text()" /></c:set>
												<c:set var="filename"><x:out select="$govDoc//field2/text()" />.xls</c:set>
												<c:if test="${not empty filename}">
													<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="${appName}" />
														<jsp:param name="saveFileNames" value="${filename}" />
														<jsp:param name="moduleName" value="govdocumentmanager" />
													</jsp:include>  			
												</c:if>	
											 </x:if>
										</c:when>
										<c:when test="${fieldtype eq '17' }">
											<x:if select="$govDoc//field2/text() != 'null'">
												<c:set var="sc_fujian"><x:out select="$govDoc//field2/text()" /></c:set>
				            					<%
				            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
				            						String[] fujian_array=fujian_value.split(",");
				            					%>
				            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
								            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
						           			 	<c:if test="${not empty filename}">
						           			 		<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="${appNames}" />
														<jsp:param name="saveFileNames" value="${filenames}" />
														<jsp:param name="moduleName" value="govdocumentmanager" />
													</jsp:include>
					                	 		</c:if>
						                	 </x:if>
										</c:when>
										<c:otherwise>
											<x:out select="$govDoc//field2/text()" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field3">
						<tr>
							<th>
								<x:out select="$govDoc//field3/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field3/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
										<x:if select="$govDoc//field3/text() != 'null'">
											<c:set var="appName"><x:out select="$govDoc//field3/text()" /></c:set>
											<c:set var="filename"><x:out select="$govDoc//field3/text()" />.doc</c:set>
											<c:if test="${not empty filename}">   
												<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appName}" />
													<jsp:param name="saveFileNames" value="${filename}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>      			
											</c:if>
										</x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
										<x:if select="$govDoc//field3/text() != 'null'">
											<c:set var="appName"><x:out select="$govDoc//field3/text()" /></c:set>
											<c:set var="filename"><x:out select="$govDoc//field3/text()" />.xls</c:set>
											<c:if test="${not empty filename}">
										 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appName}" />
													<jsp:param name="saveFileNames" value="${filename}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>     			
											</c:if>	
										</x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
										<x:if select="$govDoc//field3/text() != 'null'">
											<c:set var="sc_fujian"><x:out select="$govDoc//field3/text()" /></c:set>
		            						<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
				                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field3/text()" />
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</x:if>
					<x:if select="$govDoc/output/data/baseData/field4">
						<tr>
							<th>
								<x:out select="$govDoc//field4/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field4/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field4/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field4/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field4/text()" />.doc</c:set>
										<c:if test="${not empty filename}"> 
										 	<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>         			
										</c:if>
										</x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field4/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field4/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field4/text()" />.xls</c:set>
										<c:if test="${not empty filename}"> 
										 	<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>         			
										</c:if>         			
										</x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
										<x:if select="$govDoc//field4/text() != 'null'">
											<c:set var="sc_fujian"><x:out select="$govDoc//field4/text()" /></c:set>
			            					<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
				                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field4/text()" />
									</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field5">
						<tr>
							<th>
								<x:out select="$govDoc//field5/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field5/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field5/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field5/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field5/text()" />.doc</c:set>
										 <c:if test="${not empty filename}"> 
										 	<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>         			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field5/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field5/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field5/text()" />.xls</c:set>
										 <c:if test="${not empty filename}">  
										 	<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>        			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
										<x:if select="$govDoc//field5/text() != 'null'">
											<c:set var="sc_fujian"><x:out select="$govDoc//field5/text()" /></c:set>
		            						<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
				                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field5/text()" />
									</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field6">
						<tr>
							<th>
								<x:out select="$govDoc//field6/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field6/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field6/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field6/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field6/text()" />.doc</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>
										 </x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field6/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field6/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field6/text()" />.xls</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
									<x:if select="$govDoc//field6/text() != 'null'">
										<c:set var="sc_fujian"><x:out select="$govDoc//field6/text()" /></c:set>
			            					<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
					                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field6/text()" />
									</c:otherwise>
									</c:choose>
							</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field7">
						<tr>
							<th>
								<x:out select="$govDoc//field7/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field7/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field7/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field7/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field7/text()" />.doc</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>
										 </x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field7/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field7/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field7/text()" />.xls</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
									<x:if select="$govDoc//field7/text() != 'null'">
										<c:set var="sc_fujian"><x:out select="$govDoc//field7/text()" /></c:set>
			            					<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
					                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field7/text()" />
									</c:otherwise>
									</c:choose>
							</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field8">
						<tr>
							<th>
								<x:out select="$govDoc//field8/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field8/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field8/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field8/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field8/text()" />.doc</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>
										 </x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field8/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field8/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field8/text()" />.xls</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
									<x:if select="$govDoc//field8/text() != 'null'">
										<c:set var="sc_fujian"><x:out select="$govDoc//field8/text()" /></c:set>
			            					<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
					                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field8/text()" />
									</c:otherwise>
									</c:choose>
							</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field9">
						<tr>
							<th>
								<x:out select="$govDoc//field9/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field9/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field9/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field9/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field9/text()" />.doc</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>
										 </x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field9/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field9/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field9/text()" />.xls</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
									<x:if select="$govDoc//field9/text() != 'null'">
										<c:set var="sc_fujian"><x:out select="$govDoc//field9/text()" /></c:set>
			            					<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
					                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field9/text()" />
									</c:otherwise>
									</c:choose>
							</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/field10">
						<tr>
							<th>
								<x:out select="$govDoc//field10/@name"/>
							</th>
							<td> 
								<c:set var="fieldtype"><x:out select="$govDoc//field10/@fieldDisplayType" /></c:set> 
								<c:choose>
									<c:when test="${fieldtype eq '13' }">
									<x:if select="$govDoc//field10/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field10/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field10/text()" />.doc</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>
										 </x:if>	
									</c:when>
									<c:when test="${fieldtype eq '14' }">
									<x:if select="$govDoc//field10/text() != 'null'">
										<c:set var="appName"><x:out select="$govDoc//field10/text()" /></c:set>
										<c:set var="filename"><x:out select="$govDoc//field10/text()" />.xls</c:set>
										 <c:if test="${not empty filename}"> 
											<jsp:include page="../common/include_download.jsp" flush="true">
												<jsp:param name="realFileNames"	value="${appName}" />
												<jsp:param name="saveFileNames" value="${filename}" />
												<jsp:param name="moduleName" value="govdocumentmanager" />
											</jsp:include>          			
										 </c:if>	
										 </x:if>
									</c:when>
									<c:when test="${fieldtype eq '17' }">
									<x:if select="$govDoc//field10/text() != 'null'">
										<c:set var="sc_fujian"><x:out select="$govDoc//field10/text()" /></c:set>
			            					<%
			            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
			            						String[] fujian_array=fujian_value.split(",");
			            					%>
			            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
							            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
					           			 	<c:if test="${not empty filename}">
					           			 		<jsp:include page="../common/include_download.jsp" flush="true">
													<jsp:param name="realFileNames"	value="${appNames}" />
													<jsp:param name="saveFileNames" value="${filenames}" />
													<jsp:param name="moduleName" value="govdocumentmanager" />
												</jsp:include>
				                	 		</c:if>
					                	 	</x:if>
									</c:when>
									<c:otherwise>
										<x:out select="$govDoc//field10/text()" />
									</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:if>
						<x:if select="$govDoc/output/data/baseData/custemFieldList">
							<x:forEach select="$govDoc/output/data/baseData/custemFieldList/custemField" var="cf" >
								<tr>
									<th>
										<x:out select="$cf/name/text()"/>
									</th>
									<td>
										<c:set var="custemFieldtype"><x:out select="$cf/fieldDisplayType/text()" /></c:set> 
										<c:choose>
											<c:when test="${custemFieldtype eq '116' || custemFieldtype eq '118'}">
											<x:if select="$cf/content/text() != 'null'">
												<c:set var="appName"><x:out select="$cf/content/text()" /></c:set>
												<c:set var="filename"><x:out select="$cf/content/text()" />.doc</c:set>
												 <c:if test="${not empty filename}"> 
													<jsp:include page="../common/include_download.jsp" flush="true">
														<jsp:param name="realFileNames"	value="${appName}" />
														<jsp:param name="saveFileNames" value="${filename}" />
														<jsp:param name="moduleName" value="govdocumentmanager" />
													</jsp:include>          			
												 </c:if>
												 </x:if>	
											</c:when>
											<c:when test="${custemFieldtype eq '117' }">
												<x:if select="$cf/content/text() != 'null'">
													<c:set var="appName"><x:out select="$cf/content/text()" /></c:set>
													<c:set var="filename"><x:out select="$cf/content/text()" />.xls</c:set>
													 <c:if test="${not empty filename}"> 
														<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appName}" />
															<jsp:param name="saveFileNames" value="${filename}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>          			
													 </c:if>	
												 </x:if>
											</c:when>
											<c:when test="${custemFieldtype eq '115' }">
											<x:if select="$cf/content/text() != 'null'">
												<c:set var="sc_fujian"><x:out select="$cf/content/text()" /></c:set>
					            					<%
					            						String fujian_value=(String)pageContext.getAttribute("sc_fujian");
					            						String[] fujian_array=fujian_value.split(",");
					            					%>
					            				 	<c:set var="appNames"><%=fujian_array[0] %></c:set>
									            	<c:set var="filenames"><%=fujian_array[1] %></c:set>
							           			 	<c:if test="${not empty filename}">
							           			 		<jsp:include page="../common/include_download.jsp" flush="true">
															<jsp:param name="realFileNames"	value="${appNames}" />
															<jsp:param name="saveFileNames" value="${filenames}" />
															<jsp:param name="moduleName" value="govdocumentmanager" />
														</jsp:include>
						                	 		</c:if>
							                	 	</x:if>
											</c:when>
											<c:otherwise>
												<x:out select="$cf/content/text()" />
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</x:forEach>
						</x:if>
						<!-- 批示意见内容 -->
<%--						<c:set var="commentField"><x:out select="$doc//workInfo/commentField/text()"/></c:set>--%>
						<c:set var="commentField"><x:out select="$doc//workInfo/commentField/text()"/></c:set>
						<c:set var="commentFieldName"><x:out select="$doc//workInfo/commentFieldName/text()"/></c:set>
						<x:forEach select="$doc//commentList/comment" var="ct" >
							<tr>
								<th>
									<x:out select="$ct//step/text()"/>
								</th>
								<td>					
									<c:set var="commentDate"><x:out select="$ct//date/text()"/></c:set>
									<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(${commentDate})</c:if></br>												
								</td>
							</tr>
						</x:forEach>
						<c:choose>
                        <c:when test="${not empty commentFieldName && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
							<tr>
								<th>
									${commentFieldName}
								</th>
								<td>
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
						</c:when>
						<c:when test="${not empty workcurstep && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
							<tr>
								<th>
									${workcurstep}
								</th>
								<td>
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
						</c:when>
						</c:choose>
						<%--
						<c:if test="${not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
							<tr>
								<th>批示意见</th>
								<td> 
									<textarea name='comment_input' class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入文字"></textarea>
								</td>
							</tr>
						</c:if>
						--%>
						<%--
						<x:if select="$govDoc//comment/documentSendFileAssumeUnit">
						 <c:set var="content" ><x:out select="$govDoc//comment/documentSendFileAssumeUnit/text()"/></c:set>
						<tr>
							<th>
								<x:out select="$govDoc//comment/documentSendFileAssumeUnit/@name" />
							</th>
							<td> 
								 <%
							       String aContent =(String)pageContext.getAttribute("content");
							       aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							       aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							       newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
								   newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
								   newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
							      %> 
							      <c:set var="uname" value="<%=newcontent%>" />
							      ${uname} 
							</td>
							</tr>
						</x:if> 
					 <x:if select="$govDoc//comment/sendFileMassDraft">
					 <c:set var="content" ><x:out select="$govDoc//comment/sendFileMassDraft/text()"/></c:set>
					 <tr>
					 		<th>
								<x:out select="$govDoc//comment/sendFileMassDraft/@name" />
							</th>
							<td> 
								 <%
							       String aContent =(String)pageContext.getAttribute("content");
							      aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							         aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							        newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
									newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
									newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
							      %> 
							    <c:set var="uname" value="<%=newcontent%>" /> 
							    ${uname}
							</td>
					</tr>
					 </x:if>
					 <x:if select="$govDoc//comment/sendFileProveDraft">
					  <c:set var="content" ><x:out select="$govDoc//comment/sendFileProveDraft/text()"/></c:set>
					 	<tr>
					 		<th>
								<x:out select="$govDoc//comment/sendFileProveDraft/@name" /> 
							</th>
							<td> 
								<%
							       String aContent =(String)pageContext.getAttribute("content");
							       aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							         aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							        newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
									newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
									newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
							      %> 
							      <c:set var="uname" value="<%=newcontent%>" /> 
							      ${uname}
							</td>
					</tr>
					 </x:if>
					 <x:if select="$govDoc//comment/sendFileReadComment">
					 <c:set var="content" ><x:out select="$govDoc//comment/sendFileReadComment/text()"/></c:set>
					 	<tr>
					 		<th>
								<x:out select="$govDoc//comment/sendFileReadComment/@name" /> 
							</th>
							<td> 
								<%
							       String aContent =(String)pageContext.getAttribute("content");
							        aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							         aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							        newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
									newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
									newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
							      %> 
							      <c:set var="uname" value="<%=newcontent%>" />
							      ${uname} 
							</td>
					</tr>
					 </x:if>
					 <x:if select="$govDoc//comment/documentSendFileCheckCommit">
				   	 	<c:set var="content" ><x:out select="$govDoc//comment/documentSendFileCheckCommit/text()"/></c:set>
				 		<tr>
					 		<th>
								<x:out select="$govDoc//comment/documentSendFileCheckCommit/@name" /> 
							</th>
							<td> 
								<%
							       String aContent =(String)pageContext.getAttribute("content");
							       aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							       aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							        newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
									newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
									newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
							      %> 
							      <c:set var="uname" value="<%=newcontent%>" /> 
							      ${uname}
							</td>
						</tr>
					 </x:if>
					 <x:if select="$govDoc//comment/documentSendFileSendFile">
						 <c:set var="content" ><x:out select="$govDoc//comment/documentSendFileSendFile/text()"/></c:set>
						 <tr>
					 		<th>
								<x:out select="$govDoc//comment/documentSendFileSendFile/@name" /> 
							</th>
							<td> 
								<%
							       String aContent =(String)pageContext.getAttribute("content");
							       aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							         aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							        newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
									newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
									newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
							      %> 
							      <c:set var="uname" value="<%=newcontent%>" /> 
							      ${uname}
							</td>
						 </tr>
					 </x:if>
					 --%>
					 <x:if select="$govDoc//backComment/text != ''">
					 	<tr>
					 		<c:set var="content" ><x:out select="$govDoc//backComment/text()" /></c:set>
					 	 	<th>
								退回意见
							</th>
							<td>
							 	<%
							       String aContent =(String)pageContext.getAttribute("content");
							       aContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml(aContent);
							       aContent = StringUtils.replace(aContent,"<br>&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   aContent = StringUtils.replace(aContent,"&nbsp;&nbsp;&nbsp;&nbsp;","\n<br/>    ");
								   String newcontent = aContent;
							        newcontent = StringUtils.replace(newcontent,"<br>","<br/>");
									newcontent = StringUtils.replace(newcontent,"<br/>","\n<br/>");
									newcontent = StringUtils.replace(newcontent,"&nbsp;"," ");
									int blankpos = newcontent.lastIndexOf("    ");
									if(blankpos > 0){
										newcontent = newcontent.substring(0,blankpos)+"\n<br/>"+newcontent.substring(blankpos+4);
									}
							      %>   
								<c:set var="uname" value="<%=newcontent%>" /> 
								${uname }
							</td>
						</tr>
					 </x:if>
            		</table>
            	</c:if>
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
            </form>
        </div>
    </article>
</section>
<%--
<c:if test="${param.workStatus ne '101' && param.workStatus ne '102' && param.workStatus ne '1100'}">
<footer class="wh-footer wh-footer-forum">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <c:choose>
	                <c:when test="${hasbackbutton == 'true' }">
		               	<a href="javascript:$('#backForm').submit();" class="fbtn-cancel col-xs-6"><i class="fa fa-arrow-left"></i>退回</a>
		                <a href="javascript:$('#sendForm').submit();" class="fbtn-matter col-xs-6"><i class="fa fa-check-square"></i>发送</a>
	                </c:when>
	                <c:otherwise>
		                <a href="javascript:$('#sendForm').submit();" class="fbtn-matter col-xs-12"><i class="fa fa-check-square"></i>发送</a>
	                </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</footer>
</c:if>
--%>
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
</c:if>
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