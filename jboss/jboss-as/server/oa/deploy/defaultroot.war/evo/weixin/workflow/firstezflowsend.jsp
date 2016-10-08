<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>发送流程</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" /> 
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<section class="wh-section wh-section-bottomfixed" id="mainContent">
	<article class="wh-edit wh-edit-document">
		<div class="wh-container">
			<form id="sendForm" action="/defaultroot/workflow/sendezflowprocess.controller" method="post">
				<input type="hidden" id="userId" name="userId" value=""/>
		     	<input type="hidden" id="scopeId" name="scopeId" value=""/>
			 	<input type="hidden" id="activityName" name="activityName" value=""/>
			 	<input type="hidden" id="activityType" name="activityType" value=""/>
		     	<input type="hidden" id="businessId" name="businessId" value="${businessId}"/>
			 	<input type="hidden" id="processId" name="processId" value="${param.processId}"/>
				<input type="hidden" id="moduleId" name="moduleId" value="${moduleId}"/>
			 	<c:set var="mainLinkFile">${param.mainLinkFile}</c:set>
			 	<c:choose>
			 		<c:when test="${not empty mainLinkFile}">
			 			<input type="hidden" id="mainLinkFile" name="mainLinkFile" value="${param.mainLinkFile}"/>
			 		</c:when>
			 		<c:otherwise>
			 			<input type="hidden" id="mainLinkFile" name="mainLinkFile" value=""/>
			 		</c:otherwise>
			 	</c:choose>
			 	<c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc"/>
					<input type="hidden" id="gateNum" name="gateNum" value="<x:out select="$doc//gateNum/text()"/>"/>
				</c:if>
				<input type="hidden"  name="docTitle" value="${docTitle }"/>
				<c:set var="docTitle" value="${docTitle }"></c:set>
				<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
				<input type="hidden" id="gateType" name="gateType" value="${gateType}"/>
				<table class="wh-table-edit">
					<c:choose>
						<c:when test="${gateType == 'XX'}">
							<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
								<c:set var="activityId"><x:out select="$n//activityId/text()"/></c:set>
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
				            		<th><i class="fa fa-asterisk"></i>下一环节：</th>
				            		<td style="text-align:right">
				            			<input type="checkbox" name="activity" id='activity<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityId/text()"/>' checked="true" /><x:out select="$n/activityName/text()"/>
				            			<input type="hidden" id='activityName<x:out select="$n/activityId/text()"/>' name='activityName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityName/text()"/>'/>
				            			<input type="hidden" id='activityType<x:out select="$n/activityId/text()"/>' name='activityType<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityType/text()"/>'/>
				            		</td>
				            	</tr>
				            	<tr <c:if test="${activityId eq '-2'}">style="display : none;"</c:if>>
				            		<th><i class="fa fa-asterisk"></i>办理人：</th>
				            		<td>
										<x:if select="$n/scopeType/text() = 'default_users' ">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
											<span class="fr" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
											<input placeholder="请选择" type="hidden"   id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickb='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</x:if>
										<x:if select="$n/scopeType/text() = 'scopes_user' ">
											<c:if test="${scopeId !=null && scopeId !=''}">
												<c:if test="${scopeIdLength =='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
												</c:if>
												<c:if test="${scopeIdLength !='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</c:if>
											<c:if test="${scopeId ==null || scopeId ==''}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
												<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</c:if>
										</x:if>
										<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
				            		</td>
				            	</tr>
							</x:forEach>
						</c:when>
						<c:when test="${gateType == 'XAND'}">
							<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
								<c:set var="activityId"><x:out select="$n//activityId/text()"/></c:set>
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
									<th><i class="fa fa-asterisk"></i>下一环节：</th>
									<td style="text-align:right">
										<input onclick="return false;" type="checkbox" name="activity" id='activity<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityId/text()"/>' checked="true" /><x:out select="$n/activityName/text()"/>
										<input type="hidden" id='activityName<x:out select="$n/activityId/text()"/>' name='activityName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityName/text()"/>'/>
				            			<input type="hidden" id='activityType<x:out select="$n/activityId/text()"/>' name='activityType<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/activityType/text()"/>'/>
									</td>
								</tr>
								<tr <c:if test="${activityId eq '-2'}">style="display : none;"</c:if>>
				            		<th><i class="fa fa-asterisk"></i>办理人：</th>
				            		<td>
										<x:if select="$n/scopeType/text() = 'default_users' ">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
											<span class="fr" onclick="$(this).next('input').click()"><x:out select="$n/scopeName/text()"/></span>
											<input type="hidden" placeholder="请选择" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r"  readonly="readonly" onclickd='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</x:if>
										<x:if select="$n/scopeType/text() = 'scopes_user' ">
											<c:if test="${scopeId !=null && scopeId !=''}">
												<c:if test="${scopeIdLength =='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value='<x:out select="$n/scopeName/text()"/>' class="edit-ipt-r" readonly="readonly"/>
												</c:if>
												<c:if test="${scopeIdLength !='1'}">
													<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
													<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
													<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
												</c:if>
											</c:if>
											<c:if test="${scopeId ==null || scopeId ==''}">
												<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
												<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
												<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
											</c:if>
										</x:if>
										<c:if test="${scopeType != 'scopes_user' && scopeType != 'default_users' }">
											<input type="hidden" id="scopeId" name="scopeId" value='<x:out select="$n/scopeId/text()"/>'/>
											<input type="hidden" id='userId<x:out select="$n/activityId/text()"/>' name='userId<x:out select="$n/activityId/text()"/>' value=""/>
											<input placeholder="请选择" type="text" id='userName<x:out select="$n/activityId/text()"/>' name='userName<x:out select="$n/activityId/text()"/>' value="" class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName<x:out select="$n/activityId/text()"/>","userId<x:out select="$n/activityId/text()"/>","<x:out select="$n/scopeId/text()"/>");'/>
										</c:if>
									</td>
								</tr>
							</x:forEach>
						</c:when>
						<c:otherwise>
							<c:set var="isdefaultusers" value="0"/>
							<tr>
								<th><i class="fa fa-asterisk"></i>下一环节：</th>
								<td style="text-align:right">
								<!-- 
									<select class="selt" name="activity"  id="activity" prompt="请选择下一办理环节" onchange="hiddenEnd();">
										<option value="">--请选择--</option>
										<%--判断nextActivityList结点长度 开始--%>
										<c:set var="nextActivityListNum" value="0"/>
										<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
											<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
										</x:forEach>
										<c:if test="${nextActivityListNum == 1}">
											<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
												<x:if select="$n/scopeType/text() = 'default_users' ">
														<c:set var="isdefaultusers" value="1"/>
												</x:if>
												<option selected="true" value='<x:out select="$n/activityId/text()"/>'><x:out select="$n/activityName/text()"/></option>
											</x:forEach>
										</c:if>
										<c:if test="${nextActivityListNum != 1}">
											<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
												<c:set var="activityclass"><x:out select="$doc//activityClass/text()"/></c:set>
												<option value='<x:out select="$n/activityId/text()"/>'><x:out select="$n/activityName/text()"/></option>
												<x:if select="$n/scopeType/text() = 'default_users' ">
													<x:if select="$n/isDefaultActivity/text() = '1' ">
														<c:set var="isdefaultusers" value="1"/>
													</x:if>
												</x:if>
											</x:forEach>
										</c:if>
										<%--判断nextActivityList结点长度 结束--%>
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
												 <x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
												 	<c:set var="nextActivityListNum" value="${nextActivityListNum+1}"/>
												 </x:forEach>
												<c:if test="${nextActivityListNum == 1}">
													<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
														<x:if select="$n/scopeType/text() = 'default_users' ">
															<c:set var="isdefaultusers" value="1"/>
														</x:if>
														<c:set var="activitys"><x:out select="$n/activityId/text()"/></c:set>
														<li onclick="hiddenEnd('<x:out select="$n/activityId/text()"/>')"><x:out select="$n/activityName/text()"/></li>
													</x:forEach>
												</c:if>
												<c:if test="${nextActivityListNum != 1}">
													<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
														<c:set var="activityclass"><x:out select="$doc//activityClass/text()"/></c:set>
														<li onclick="hiddenEnd('<x:out select="$n/activityId/text()"/>')"><x:out select="$n/activityName/text()"/></li>
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
									</select>
								</td>
							</tr>
							<tr id="person" style="display:none;">
								<th><i class="fa fa-asterisk"></i>办理人：</th>
								<td>

									<input type="hidden" id='scopeId' name='scopeId' value='' />
									<input type="hidden" id="userId"  name="userId"  value=""/>
									<span class="fr" onclick="$(this).next('input').click()"></span>
			           				<input type="text" placeholder="请选择" id='userName' name='userName' value='' class="edit-ipt-r" readonly="readonly" onclick='selectUser("1","userName","userId",$("#scopeId").val());'/>
		           				</td>
							</tr>
						</c:otherwise>
					</c:choose>
				</table>
			</form>
		</div>
	</article>
</section>
<footer class="wh-footer wh-footer-text" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:send();" class="fbtn-matter col-xs-6 fbtn-single"><i class="fa fa-check-square"></i>发送</a>
            </div>
        </div>
    </div>
</footer>
<section id="selectContent" style="display:none">
</section>
</body>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var optionLen = $('#activityLi li').length;
		if(optionLen == 1){
			var value = $('#activityLi li').html();
			$('#activitySpan span').html(value);
			hiddenEnd('${activitys}');
		}else{
			hiddenEnd();
		}
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

			<x:forEach select="$doc//activityList/activity" var="n" >
				$('#activityName').val('<x:out select="$n/activityName/text()"/>');
				$('#activityType').val('<x:out select="$n/activityType/text()"/>');
				if('<x:out select="$n/activityId/text()"/>' == $('#activity').val()){
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
								$('#userName').prev('span').html('<x:out select="$n/scopeName/text()"/>');
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
	
	function loadSend(){
	    dialog = $.dialog({
	        content:"正在发送...",
	        title: 'load'
	    });
	}
	
	function send(){
		var url ='/defaultroot/workflow/sendezflowprocess.controller';

		<c:if test="${not empty docXml}">
			<x:parse xml="${docXml}" var="doc"/>
			<c:set var="gateType"><x:out select="$doc//gateType/text()"/></c:set>
			<c:if test="${gateType == 'XAND'}">
				<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc"> 
					<c:set var="id"><x:out select="$n//activityId/text()"/></c:set>
					<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
					if('<x:out select="$n/activityId/text()"/>' != '-100' && '<x:out select="$n/activityId/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/activityId/text()"/>').value == ''){
						alert('<x:out select="$n/activityName/text()"/>办理人不能为空');
						return false;
					}
				</x:forEach>
				ajaxSend(url);
				return;
			</c:if>
			
			<c:if test="${gateType == 'XX'}">
				var selected = false;
				<x:forEach select="$doc//activityList/activity" var="n" varStatus="statusc">
					<c:set var="id"><x:out select="$n//activityId/text()"/></c:set>
					<c:set var="scopeType"><x:out select="$n/scopeType/text()"/></c:set>
					if(document.getElementById('activity<x:out select="$n/activityId/text()"/>').checked){
						selected = true;
						if('<x:out select="$n/activityId/text()"/>' != '-100' && '<x:out select="$n/activityId/text()"/>' != '-2' && document.getElementById('userId<x:out select="$n/activityId/text()"/>').value == ''){
							alert('<x:out select="$n/activityName/text()"/>办理人不能为空');
							return false;
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
			if(($('#activity') ==null || $('#activity').val() =='')){
				alert("请选择下一节点!");
			}else{
				if($('#activity').val() !='' && $('#activity').val() !='-2' && $('#activity').val() !='-100'){
					if($('#userName') != null && $('#userName').val() == ''){
						alert('办理人不能为空');
						return false;
					}
				}
				ajaxSend(url);
			}
		</c:if>
	}
	var sendFlag = '1';
	function ajaxSend(url){
		if(sendFlag == '0'){
			return false;
		}
		var openUrl ='/defaultroot/workflow/listflow.controller';
		loadSend();
		$.ajax({
			type: 'POST',
			url: url,
			data: $('#sendForm').serialize(),
			async: true,
			dataType: 'text',
			success: function(data){
				var json = eval("("+data+")");
				sendFlag = '0';
				if(dialog){
					dialog.close();
				}
				if(json!=null){
					if(json.result == 'success'){
						alert("发送成功！");
						window.location.href =openUrl;
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
	
	
	//发送
	/* function send(){
		if($('#activity').val() ==''){
			alert("请选择下一节点!");
			return false;
		}
		if($('#userName') != null && $('#userName').val() == ''){
			alert('办理人不能为空');
			return false;
		}
		loadSend();
		//发送流程
		$.ajax({
			url : '/defaultroot/workflow/sendezflowprocess.controller',
			type : 'post',
			data : $('#sendForm').serialize(),
			success : function(data){
				if(dialog){
					dialog.close();
				}
				if(data){
					var jsonData = eval('('+data+')');
					if(jsonData.result = 'success'){
						alert('发送成功！');
						window.location = '/defaultroot/workflow/listflow.controller';
					}
				}else{
					alert('发送失败！');
				}
			},
			error : function(){
				alert('发送异常！');
			}
		});
	} */

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
	
	var dialog = null;
	function loadPage(){
	    dialog = $.dialog({
	        content:"正在加载中...",
	        title: 'load'
	    });
	}
		
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range){ 
		loadPage();
		var selectIdVal = $('#'+selectId).val();
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
			type : 'post',
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('#'+selectName).val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$('#selectContent').append(data);
				hiddenContent(0);
				if(dialog){
					dialog.close();
				}
			}
		});
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
</script>
</html>