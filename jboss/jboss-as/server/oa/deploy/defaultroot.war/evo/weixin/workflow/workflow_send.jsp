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
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>
    <%--
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/xmlHttpHelper.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/frost.js"></script>
	<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js?t=<%=(new java.util.Date()).getTime()%>"></script>
	--%>
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
		<c:if test="${not empty docXml}">
		<x:parse xml="${docXml}" var="doc"/>
		<form id="sendForm" class="dialog" action="/defaultroot/workflow/updateprocess2.controller" method="post">
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
	            <input type="hidden" name="workId" id="workId" value="${param.workId}" />
				<input type="hidden" name="comment" id="comment" value="${param.comment_input}" />
				<input type="hidden" name="commentType" id="commentType" value="${commentType}" />
				<input type="hidden" id="docTitle" name="docTitle" value="${docTitle }"/>
				<input type="hidden" id="commentField" name="commentField" value="${param.curCommField}"/>
				<input type="hidden" id="activityclassId" value="${param.activityclass}" name="activityclassId"></input>
				<input type="hidden" id="afterInsertTaskIds" name="afterInsertTaskIds" value='<x:out select="$doc//afterInsertTaskIds/text()"/>' />
				<input type="hidden" id="beginForkActivityId" name="beginForkActivityId" value='<x:out select="$doc//beginForkActivityId/text()"/>' />
				<input type="hidden" id="beginForkActivityName" name="beginForkActivityName" value='<x:out select="$doc//beginForkActivityName/text()"/>' />
				<input type="hidden" id="toJoinActivityId" name="toJoinActivityId" value='<x:out select="$doc//toJoinActivityId/text()"/>' />
				<input type="hidden" name="_mainfile_commentacc" id="_mainfile_commentacc" value="${commentAcc}" />
				<input type="hidden" id="fromFlag" name="fromFlag"  value="${param.fromFlag}" />
				<!--gateType  XOR或者空时：多个活动选一个  XAND：多个活动都选  XX：多个活动选择多个-->
				<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
				<input type="hidden" id="gateType" name="gateType" value="${gateType}"/>
				<c:set var="workType">${workType}</c:set>
				<input type="hidden" id="workType" name="workType" value="${workType}"/>
				<c:set var="comment_input">${comment_input}</c:set>
				<input type="hidden" id="comment_input" name="comment_input" value="${comment_input}"/>
	            <table class="wh-table-edit">
		            <c:choose>
						<c:when test="${gateType == 'XX'}">
							<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
								<c:set var="id"><x:out select="$n//id/text()"/></c:set>
								<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
								<%--处理办理人只有一个人的情况--%>
								<%
								int scopeIdLength =0;
								%>
								<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
								<c:if test="${scopeId !=null && scopeId !=''}">
								<%
								String scopeId =(String)pageContext.getAttribute("scopeId");
								if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
									scopeId =scopeId.replaceAll("\\$",",");
									scopeId =scopeId.replaceAll(",,",",");
									scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
									String[] scopeIds =scopeId.split(",");
									if(scopeIds !=null && scopeIds.length >0){
										scopeIdLength =scopeIds.length;
									}
								}
								%>
								</c:if>
								<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
								<%--处理办理人只有一个人的情况--%>
								<tr>
				            		<th><i class="fa fa-asterisk"></i>下一办理环节：</th>
				            		<td style="text-align:right">
				            			<input type="checkbox" name="activity" id='activity<x:out select="$n/id/text()"/>' value='<x:out select="$n/id/text()"/>' checked="true" /><x:out select="$n/name/text()"/>
				            		</td>
				            	</tr>
				            	<tr <c:if test="${id eq '-2'}">style="display : none;"</c:if>>
				            		<th><i class="fa fa-asterisk"></i>下一办理人：</th>
				            		<td>
										<x:if select="$n/scopeType/text() = 'default_users' ">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
											<span class="fr" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
											<input placeholder="请选择" type="hidden"   id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickb='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</x:if>
										<x:if select="$n/scopeType/text() = 'scopes_user' ">
											<c:if test="${scopeId !=null && scopeId !=''}">
												<c:if test="${scopeIdLength =='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
												</c:if>
												<c:if test="${scopeIdLength !='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</c:if>
											<c:if test="${scopeId ==null || scopeId ==''}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
												<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</c:if>
										</x:if>
										<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
				            		</td>
				            	</tr>
							</x:forEach>
						</c:when>
						<c:when test="${gateType == 'XAND'}">
							<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
								<c:set var="id"><x:out select="$n//id/text()"/></c:set>
								<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
								<%--处理办理人只有一个人的情况--%>
								<%
								int scopeIdLength =0;
								%>
								<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
								<c:if test="${scopeId !=null && scopeId !=''}">
								<%
								String scopeId =(String)pageContext.getAttribute("scopeId");
								if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
									scopeId =scopeId.replaceAll("\\$",",");
									scopeId =scopeId.replaceAll(",,",",");
									scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
									String[] scopeIds =scopeId.split(",");
									if(scopeIds !=null && scopeIds.length >0){
										scopeIdLength =scopeIds.length;
									}
								}
								%>
								</c:if>
								<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
								<%--处理办理人只有一个人的情况--%>
								<tr>
									<th><i class="fa fa-asterisk"></i>下一办理环节：</th>
									<td style="text-align:right">
										<input onclick="return false;" type="checkbox" name="activity" id='activity<x:out select="$n/id/text()"/>' value='<x:out select="$n/id/text()"/>' checked="true" /><x:out select="$n/name/text()"/>
									</td>
								</tr>
								<tr <c:if test="${id eq '-2'}">style="display : none;"</c:if>>
				            		<th><i class="fa fa-asterisk"></i>下一办理人：</th>
				            		<td>
										<x:if select="$n/scopeType/text() = 'default_users' ">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
											<span class="fr" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
											<input type="hidden" placeholder="请选择" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickd='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</x:if>
										<x:if select="$n/scopeType/text() = 'scopes_user' ">
											<c:if test="${scopeId !=null && scopeId !=''}">
												<c:if test="${scopeIdLength =='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
												</c:if>
												<c:if test="${scopeIdLength !='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</c:if>
											<c:if test="${scopeId ==null || scopeId ==''}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
												<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</c:if>
										</x:if>
										<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/id/text()"/>' name='userId<x:out select="$n/id/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/id/text()"/>' name='userName<x:out select="$n/id/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/id/text()"/>","userId<x:out select="$n/id/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
									</td>
								</tr>
							</x:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="isdefaultusers" value="0"/>
							<tr>
								<th><i class="fa fa-asterisk"></i>下一办理环节：</th>
								<td style="text-align:right">
									<!-- <select class="selt" name="activity"  id="activity" prompt="请选择下一办理环节" onchange="hiddenEnd();">
										<option value="">--请选择--</option>
										<%--判断nextActivityList结点长度 开始--%>
										<c:set var="nextActivityListNum" value="0"/>
										<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
											<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
										</x:forEach>
										<c:if test="${nextActivityListNum == 1}">
											<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
												<x:if select="$n/scopeType/text() = 'default_users' ">
														<c:set var="isdefaultusers" value="1"/>
												</x:if>
												<option selected="true" value='<x:out select="$n/id/text()"/>'><x:out select="$n/name/text()"/></option>
											</x:forEach>
										</c:if>
										<c:if test="${nextActivityListNum != 1}">
											<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
												<option <c:if test="${param.activityclass == '3'}">selected="true"</c:if> <x:if select="$n/isDefaultActivity/text() = '1'">selected="true"</x:if> value='<x:out select="$n/id/text()"/>'><x:out select="$n/name/text()"/></option>
												<x:if select="$n/scopeType/text() = 'default_users' ">
													<x:if select="$n/isDefaultActivity/text() = '1' ">
														<c:set var="isdefaultusers" value="1"/>
													</x:if>
												</x:if>
											</x:forEach>
										</c:if>
										<%--判断nextActivityList结点长度 结束--%>
									</select>
									-->
									<div class="examine">
										<a class="edit-select edit-ipt-r">
											<div class="edit-sel-show" id="activitySpan">
												<span>请选择</span>
												<input type="hidden" id="activity" name="activity" value=""/>
											</div>     
										</a>
										<div class="select-div">
											<ul id="activityLi">
												<%--判断nextActivityList结点长度 开始--%>
												 <c:set var="nextActivityListNum" value="0"/>
												 <x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
													<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
												</x:forEach>
												<c:if test="${nextActivityListNum == 1}">
													<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
														<x:if select="$n/scopeType/text() = 'default_users' ">
															<c:set var="isdefaultusers" value="1"/>
														</x:if>
														<c:set var="activitys"><x:out select="$n/id/text()"/></c:set>
														<li onclick="hiddenEnd('<x:out select="$n/id/text()"/>')"><x:out select="$n/name/text()"/></li>
													</x:forEach>
												</c:if>
												<c:if test="${nextActivityListNum != 1}">
													<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
														<li onclick="hiddenEnd('<x:out select="$n/id/text()"/>')"><x:out select="$n/name/text()"/></li>
														<x:if select="$n/scopeType/text() = 'default_users' ">
															<x:if select="$n/isDefaultActivity/text() = '1' ">
																<c:set var="isdefaultusers" value="1"/>
															</x:if>
														</x:if>
													</x:forEach>
												</c:if>
												<%--判断nextActivityList结点长度 结束--%>
											</ul>
										</div>
									</div>
								</td>
							</tr>
							<tr id="person" style="display:none;">
								<th><i class="fa fa-asterisk"></i>下一办理人：</th>
								<td>
									<input type="hidden" id='scopeId' name='scopeId' value='' />
									<input type="hidden" id="userId"  name="userId"  value=""/>
									<span class="fr" onclick="$(this).next('input').click()"></span>
			           				<input type="text" placeholder="请选择" id='userName' name='userName' value='' class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName","userId",$("#scopeId").val());'/>
		           				</td>
							</tr>
						</c:otherwise>
					</c:choose>
					<c:if test="${workType == '0'}">
					<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
						<c:set var="id"><x:out select="$n//id/text()"/></c:set>
						<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
						<%--处理办理人只有一个人的情况--%>
						<%
						int scopeIdLength =0;
						%>
						<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
						<c:if test="${scopeId !=null && scopeId !=''}">
						<%
						String scopeId =(String)pageContext.getAttribute("scopeId");
						if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
							scopeId =scopeId.replaceAll("\\$",",");
							scopeId =scopeId.replaceAll(",,",",");
							scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
							String[] scopeIds =scopeId.split(",");
							if(scopeIds !=null && scopeIds.length >0){
								scopeIdLength =scopeIds.length;
							}
						}
						%>
						</c:if>
						<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
						<%--处理办理人只有一个人的情况--%>
					<tr>
						<th><i class="fa fa-asterisk"></i>下一办理人：</th>
						<td>
							<c:set var="scopeType"><x:out select="$n//scopeType/text()"/></c:set>
							<x:if select="$n//scopeType/text() = 'default_users' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='<x:out select="$n//scopeId/text()"/>' />
								<input type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='<x:out select="$n//scopeName/text()"/>' class="edit-ipt-r" />
							</x:if>
							<x:if select="$n//scopeType/text() = 'scopes_user' ">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
								<input placeholder="请选择" type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$n//scopeId/text()"/>");'/>
							</x:if>
							<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
								<input type="hidden" id='chooseUserId' name='chooseUserId' value='' />
								<input placeholder="请选择" type="text"   readonly="readonly" id='chooseUserName' name='chooseUserName' value='' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","chooseUserName","chooseUserId","<x:out select="$n//scopeId/text()"/>");'/>
							</c:if>
						</td>
					</tr>
					</x:forEach>
				</c:if>
	            </table>
			</div>
		</form>
		</c:if>
	</article>
</section>
<footer class="wh-footer wh-footer-text" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
			<c:if test="${workType != '0'}">
                <a href="javascript:onSubmit();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>发送</a>
            </c:if>
			<!--随机流程-->
			<c:if test="${workType == '0'}">
                <a href="javascript:send();" class="fbtn-matter col-xs-5"><i class="fa fa-check-square"></i>发送</a>
				<a href="javascript:onSubmit();" class="fbtn-matter col-xs-5"><i class="fa fa-check-square"></i>结束流程</a>
            </c:if>
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
	$(document).ready(function(){
		var optionLen = $('#activityLi li').length;
		if(optionLen == 1){
			var value = $('#activityLi li').html();
			$('#activitySpan span').html(value);
			hiddenEnd('${activitys}');
		}else{
			hiddenEnd();
		}
		//如果是并行下一活动办理完毕 在保存表单时候自动办理流程
		var url ='/defaultroot/workflow/updateprocess2.controller';
		<c:if test="${not empty docXml}">
		<x:parse xml="${docXml}" var="doc"/>
			<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc"> 
				<c:set var="id"><x:out select="$n//id/text()"/></c:set>
				if('<x:out select="$n/id/text()"/>' == '-100'){
					ajaxSend(url);
				}
			</x:forEach>
		</c:if>

	});
	
	function hiddenEnd(activityId){
		$('#activity').val(activityId);
		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			if($('#activity')==null || $('#activity').val() == undefined){
				return;
			}
			if($('#activity').val() =='' || $('#activity').val() =='-2' || $('#activity').val() =='-100'){
				$('#person').hide();
			}else{
				$('#person').show();
			}

			<x:forEach select="$doc//nextActivityList" var="n" >
				if('<x:out select="$n/id/text()"/>' == $('#activity').val()){
					if('<x:out select="$n/scopeType/text()"/>' == 'default_users'){
						$('#userId').val('<x:out select="$n/scopeId/text()"/>');
						$('#userName').val('<x:out select="$n/scopeName/text()"/>');
						$('#userName').css("display","none"); 
						$('#userName').prev('span').html('<x:out select="$n/scopeName/text()"/>');
          	 			$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
						$('#userName').unbind("click");
					}else if('<x:out select="$n/scopeType/text()"/>' == 'scopes_user'){
						$('#userName').show();
						<%
						int scopeIdLength =0;
						%>
						<c:set var="scopeId"><x:out select="$n/scopeId/text()"/></c:set>
						<c:if test="${scopeId !=null && scopeId !=''}">
						<%
						String scopeId =(String)pageContext.getAttribute("scopeId");
						if(scopeId.indexOf("*") <0 && scopeId.indexOf("@") <0){
							scopeId =scopeId.replaceAll("\\$",",");
							scopeId =scopeId.replaceAll(",,",",");
							scopeId =scopeId.substring(scopeId.indexOf(",")+1, scopeId.lastIndexOf(","));
							String[] scopeIds =scopeId.split(",");
							if(scopeIds !=null && scopeIds.length >0){
								scopeIdLength =scopeIds.length;
							}
						}
						%>
						</c:if>
						<c:set var="scopeIdLength" value="<%=scopeIdLength %>"></c:set>
						<c:if test="${scopeId !=null && scopeId !=''}">
							<c:if test="${scopeIdLength =='1'}">
								$('#userId').val('<x:out select="$n/scopeId/text()"/>');
								$('#userName').val('<x:out select="$n/scopeName/text()"/>');
								$('#userName').prev('span').html('');
<%--								$('#userName').prev('span').html('<x:out select="$n/scopeName/text()"/>');--%>
							</c:if>
							<c:if test="${scopeIdLength !='1'}">
								$('#userId').val('');
								$('#userName').val('');
								$('#userName').prev('span').html('');
							</c:if>
						</c:if>
						<c:if test="${scopeId ==null || scopeId ==''}">
							$('#userId').val('');
							$('#userName').val('');
							$('#userName').prev('span').html('');
						</c:if>
						$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
					}else{
						$('#userId').val('');
          	 			$('#userName').val('');
          	 			$('#scopeId').val('<x:out select="$n/scopeId/text()"/>');
          	 			$('#userName').prev('span').html('');
          	 			$('#userName').css("display","");
					}
				}
			</x:forEach>
		</c:if>
	}
	
	function onSubmit(){
		var url ='/defaultroot/workflow/updateprocess2.controller';

		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
			<c:if test="${gateType == 'XAND'}">
				<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc"> 
					<c:set var="id"><x:out select="$n//id/text()"/></c:set>
					<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
					if('<x:out select="$n/id/text()"/>' != '-100' && '<x:out select="$n/id/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/id/text()"/>').value == ''){
						alert('<x:out select="$n/name/text()"/>办理人不能为空');
						return false;
					}else if('<x:out select="$n/id/text()"/>' == '-2'){
						if('${isDossier}'){
							alert('该流程需要归档，请于PC端办理完毕！');
							return false;
						}
					}
				</x:forEach>
				ajaxSend(url);
				return;
			</c:if>
			
			<c:if test="${gateType == 'XX'}">
				var selected = false;
				<x:forEach select="$doc//nextActivityList" var="n" varStatus="statusc">
					<c:set var="id"><x:out select="$n//id/text()"/></c:set>
					<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
					if(document.getElementById('activity<x:out select="$n/id/text()"/>').checked){
						selected = true;
						if('<x:out select="$n/id/text()"/>' != '-100' && '<x:out select="$n/id/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/id/text()"/>').value == ''){
							alert('<x:out select="$n/name/text()"/>办理人不能为空');
							return false;
						}else if('<x:out select="$n/id/text()"/>' == '-2'){
							if('${isDossier}'){
								alert('该流程需要归档，请于PC端办理完毕！');
								return false;
							}
						}
					}
				</x:forEach>
				if(!selected){
					alert('请至少选择一个节点！');
					return false;
				}
				ajaxSend(url);
				return;
			</c:if>
			//$('#sendForm').attr("action","/defaultroot/workflow/updateprocess1.controller");
			//url ="/defaultroot/workflow/updateprocess1.controller";
			<c:if test="${param.trantype == '1'}"> 
				ajaxSend(url);
				return;
			</c:if>
			if(($('#activity') ==null || $('#activity').val() =='') && $('#activityclassId').val() != '3'){
				alert("请选择下一节点!");
			}else{
				if($('#activityclassId').val() != '3'){
					if($('#activity').val() !='' && $('#activity').val() !='-2' && $('#activity').val() !='-100'){
						if($('#userName') != null && $('#userName').val() == ''){
							alert('办理人不能为空');
							return false;
						}
					}else if($('#activity').val() =='-2' ){
						if('${isDossier}'){
							alert('该流程需要归档，请于PC端办理完毕！');
							return false;
						}
					}
				}
				ajaxSend(url);
			}
		</c:if>
	}
	
	var dialog = null;
	function loadPage(){
	    dialog = $.dialog({
	        content:"正在发送...",
	        title: 'load'
	    });
	}
	
	function ajaxSend(url){
		var openUrl ='/defaultroot/dealfile/list.controller?workStatus=<%=workStatus%>';
		loadPage();
		$.ajax({
			type: 'POST',
			url: url,
			data: $('#sendForm').serialize(),
			async: true,
			dataType: 'text',
			success: function(data){
				var json = eval("("+data+")");
				if(dialog){
					dialog.close();
				}
				if(json!=null){
					if(json.result == 'success'){
						alert("发送成功！");
						//window.location.href =openUrl;
						var fromFlag = $("#fromFlag").val();
						if(fromFlag == '1'){
							window.history.go(-2);
						}else{
							WeixinJSBridge.call('closeWindow');
						}
					}else{
						alert("发送失败！");
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
		dialog = $.dialog({
	        content:"正在加载...",
	        title: 'load'
	    });
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
					'selectNameVal':$('input[name="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
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
	// 请选择 
	$(".examine>a").on("click", function(){
		$(this).parent().find(".select-div").addClass("open"); 
	})

	$(".select-div").on("click", function(e){
		var $target= $(e.target); 
		if(!$target.is('li'))   return ; 
		var value = $target.html(); 
		$(this).parent().find(">a").find('span').html(value);
		$(this).removeClass("open"); 
	})
    
	//随机流程发送
	function send(){ 
	    var userId = '<%=userId%>';
	    var isMustBack='${isMustBack}';
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
						alert("发送成功！");
						var fromFlag = $("#fromFlag").val();
						if(fromFlag == '1'){
							window.history.go(-2);
						}else{
							WeixinJSBridge.call('closeWindow');
						}
					}else{
						alert("发送失败！");
					}
				}
			},
			error: function(){
				alert("异常！");
			}
		});
	}
</script>