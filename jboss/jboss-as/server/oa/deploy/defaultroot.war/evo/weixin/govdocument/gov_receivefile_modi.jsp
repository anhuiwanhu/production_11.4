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
<c:set var="wfsmsRight"><x:out select="$doc//smsRight/text()"/></c:set>
<c:set var="trantype"><x:out select="$doc//workInfo/trantype/text()"/></c:set>
<c:set var="EmpLivingPhoto"><x:out select="$doc//workInfo/empLivingPhoto/text()"/></c:set>
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
	                    	<a href="javascript:void(0);"><em class="not-over">未完成</em>${worktitle}</a>
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
						<x:if select="$govDoc//zjkySeq">
						 	 <tr>
						 	 	<th>
						 			<x:out select="$govDoc//zjkySeq/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//zjkySeq/text()" />
						 		</td>
						 	 </tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//fileUnit">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//fileUnit/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//fileUnit/text()" />
						 		</td>
					 		</tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//fileNumber">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//fileNumber/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//fileNumber/text()"  />
						 		</td>
					 		</tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//safetyGrade">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//safetyGrade/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//safetyGrade/text()"  />
						 		</td>
					 		</tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//quantity">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//quantity/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//quantity/text()"  />
						 		</td>
					 		</tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//field4">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//field4/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//field4/text()" />
						 		</td>
					 		</tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//receiveDate">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//receiveDate/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//receiveDate/text()" />
						 		</td>
					 		</tr>
					 	 </x:if>
				   	   <x:if select="$govDoc//fileType">
					 	 	<tr>
						 	 	<th>
						 			<x:out select="$govDoc//fileType/@name" />
						 		</th>
						 		<td>
						 			<x:out select="$govDoc//fileType/text()" />
						 		</td>
					 		</tr>
					 	 </x:if>
					 	 <x:if select="$govDoc//zjkyType">
					 	 	<tr>
						 	 	<th>
									<x:out select="$govDoc//zjkyType/@name" />
								</th>
								<td>
									<row><label style="color: #330000"><x:out select="$govDoc//zjkyType/text()" /> 
								</td>
							</tr>
						</x:if> 
						<x:if select="$govDoc//zjkykeepTerm">
							<tr>
								<th>
									<x:out select="$govDoc//zjkykeepTerm/@name" />
								</th>
								<td>
									<row><label style="color: #330000"><x:out select="$govDoc//zjkykeepTerm/text()" /> 
								</td>
							</tr>
						</x:if> 
						
						<x:if select="$govDoc//doComment">
							<c:set var="commentFieldName"><x:out select="$doc//workInfo/commentFieldName/text()"/></c:set>
							<c:if test="${commentFieldName !='' }">
							<tr>
								<th>
									<!-- <x:out select="$govDoc//doComment/@name" /> -->
									${commentFieldName }
								</th>
								<td>
									<!-- <row><label style="color: #330000"><x:out select="$govDoc//doComment/text()" /> -->
									<row><textarea name='comment_input' class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入文字"></textarea> 
								</td>
							</tr>
							</c:if>
						</x:if> 
						<x:if select="$govDoc//createdTime">
							<tr>
								<th>
									<x:out select="$govDoc//createdTime/@name" />
								</th>
								<td>
									<row><label style="color: #330000"><x:out select="$govDoc//createdTime/text()" /> 
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
						<!-- 批示意见内容 
						<x:forEach select="$govDoc//commentList/custemComment" var="ct" >
							<c:set var="isCurrent"><x:out select="$ct//current/text()" /></c:set>
							<c:set var="commentDate"><x:out select="$ct//date/text()"/></c:set>
							<tr>
								<th>
									<x:out select="$ct//name/text()"/>
								</th>
								<td>
									<c:choose>
										<c:when test="${isCurrent eq 'true' && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
											<textarea name='comment_input' class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入文字"></textarea>
											</br><x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(<x:out select="$ct//date/text()"/>)</c:if>
										</c:when>
										<c:otherwise>
											<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/><c:if test="${not empty commentDate}">(<x:out select="$ct//date/text()"/>)</c:if>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:forEach>
						-->
						
						<c:set var="commentField"><x:out select="$govDoc//commentList//text()"/></c:set>
						<c:if test="${commentField == '' }">
						<x:forEach select="$doc//commentList/comment" var="cm" >
							<tr>
								<th>
									<x:out select="$cm//step/text()"/>
								</th>
								<td>
									<c:set var="commentDate"><x:out select="$cm//date/text()"/></c:set>
									<x:out select="$cm//content/text()"/>&nbsp;&nbsp;<x:out select="$cm//person/text()"/><c:if test="${not empty commentDate}">(${commentDate})</c:if></br>
								</td>
							</tr>
						</x:forEach>
						</c:if>
						
						<c:set var="commentField"><x:out select="$govDoc//curCommField/text()"/></c:set>
						<x:forEach select="$govDoc//commentList/contentList" var="ct" >
							<c:set var="isCurrent"><x:out select="$ct//current/text()" /></c:set>
							<tr>
								<th>
									<x:out select="$ct//name/text()"/>
								</th>
								<td>
									<c:choose>
										<c:when test="${isCurrent eq 'true' && not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
											<textarea name='comment_input' class="edit-txta edit-txta-l" maxlength="300" placeholder="请输入文字"></textarea>
											<x:forEach select="$ct/commentContent" var="cc">
												<c:set var="commentDate"><x:out select="$cc//date/text()"/></c:set>
												<x:out select="$cc//content/text()"/>&nbsp;&nbsp;<x:out select="$cc//person/text()"/><c:if test="${not empty commentDate}">(${commentDate})</c:if></br>
											</x:forEach>
										</c:when>
										<c:otherwise>
											<x:forEach select="$ct/commentContent" var="cc">
												<c:set var="commentDate"><x:out select="$cc//date/text()"/></c:set>
												<x:out select="$cc//content/text()"/>&nbsp;&nbsp;<x:out select="$cc//person/text()"/><c:if test="${not empty commentDate}">(${commentDate})</c:if></br>
											</x:forEach>
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</x:forEach>
						<!-- nullCommentField -->
						<%--
						<c:if test="${not empty commentField && '-1' ne commentField && 'nullCommentField' ne commentField && param.workStatus ne '102' && param.workStatus ne '101'}">
							<tr>
								<th>批示意见</th>
								<td> 
								</td>
							</tr>
						</c:if>
						--%>
						<%--
						<x:if select="$govDoc//comment/receiveFileLeaderComment">
						 <c:set var="content" ><x:out select="$govDoc//comment/receiveFileLeaderComment/text()"/></c:set>
						<tr>
							<th>
								<x:out select="$govDoc//comment/receiveFileLeaderComment/@name" />
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
					 <x:if select="$govDoc//comment/receiveFileSettleLeaderComment">
					 <c:set var="content" ><x:out select="$govDoc//comment/receiveFileSettleLeaderComment/text()"/></c:set>
					 <tr>
					 		<th>
								<x:out select="$govDoc//comment/receiveFileSettleLeaderComment/@name" />
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
					 <x:if select="$govDoc//comment/receiveFileSettleComment">
					  <c:set var="content" ><x:out select="$govDoc//comment/receiveFileSettleComment/text()"/></c:set>
					 	<tr>
					 		<th>
								<x:out select="$govDoc//comment/receiveFileSettleComment/@name" /> 
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
					 <x:if select="$govDoc//comment/field9">
					 <c:set var="content" ><x:out select="$govDoc//comment/field9/text()"/></c:set>
					 	<tr>
					 		<th>
								<x:out select="$govDoc//comment/field9/@name" /> 
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
					 <x:if select="$govDoc//comment/receiveFileTransAuditComment">
				   	 	<c:set var="content" ><x:out select="$govDoc//comment/receiveFileTransAuditComment/text()"/></c:set>
				 		<tr>
					 		<th>
								<x:out select="$govDoc//comment/receiveFileTransAuditComment/@name" /> 
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
					 <x:if select="$govDoc//comment/receiveFileMemo">
						 <c:set var="content" ><x:out select="$govDoc//comment/receiveFileMemo/text()"/></c:set>
						 <tr>
					 		<th>
								<x:out select="$govDoc//comment/receiveFileMemo/@name" /> 
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
</script>