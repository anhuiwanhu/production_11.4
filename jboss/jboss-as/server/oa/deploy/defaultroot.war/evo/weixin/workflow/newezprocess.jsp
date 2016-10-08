<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String pageId = request.getParameter("pageId");
String processId = request.getParameter("processId");
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>${param.processName}</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" /> 
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/swiper/template.swiper.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>
</head>
<body>
<form id="sendForm" class="dialog" action="/defaultroot/workflow/firstezflowsend.controller" method="post">
<section class="wh-section wh-section-bottomfixed" id="mainContent">
    <article class="wh-edit wh-edit-document">
        <div class="wh-container">
            <c:if test="${not empty docXml}">
				<x:parse xml="${docXml}" var="doc2"/>
				<c:if test="${not empty docXml1}">
            		<x:parse xml="${docXml1}" var="doc3"/>
            		<c:set var="hideField"><x:out select="$doc3//hideField/text()"/></c:set>
           		</c:if>
				<input  id="__sys_pageId" type="hidden"  name="__sys_pageId" value="<%=pageId%>" />
				<input  id="processId" type="hidden"  name="processId" value="<%=processId%>" />
				<input  id="__main_tableName" type="hidden"  name="__main_tableName" value='<x:out select="$doc2//fieldList/tableName/text()"/>' />
				<input  id="moduleId" type="hidden"  name="moduleId" value="${moduleId}" />
	            <table class="wh-table-edit" id="table_form">
	            	<!--主表信息begin-->
	            	<x:forEach select="$doc2//fieldList/field" var="fd" >
            			<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
						<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
						<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
						<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
						<c:set var="id">$<x:out select="$fd/sysname/text()"/>$</c:set>
						<tr>
							<c:if test="${not empty docXml1}">
							<th><c:if test="${mustfilled == 1 && fn:indexOf(hideField, id) == -1}"><i class="fa fa-asterisk"></i></c:if><x:out select="$fd/name/text()"/>：</th>
							</c:if>
							<c:if test="${empty docXml1}">
							<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if><x:out select="$fd/name/text()"/>：</th>
							</c:if>
							<td style="text-align: right;">
								<c:choose>
									<%--单行文本 101--%>
									<c:when test="${showtype =='101' && readwrite =='1'}">
										<c:if test="${ fieldtype == '1000000'  }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onkeyup="mainMath(this);" />
										</c:if>
										<c:if test="${ fieldtype == '1000001'   }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' onkeyup="mainMath(this);"/>
										</c:if>
										<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text"  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
										</c:if>
									</c:when>
	
									<%--密码输入 102--%>
									<c:when test="${showtype =='102' && readwrite =='1'}">
										<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="password" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
									</c:when>
	
									<%--单选 103--%>
									<c:when test="${showtype =='103' && readwrite =='1'}">
										<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
										<div class="examine">
											<a class="edit-select edit-ipt-r">
												<div class="edit-sel-show">
													<span>请选择</span>
												</div>    
												<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
													<option value="">请选择</option>
													<x:forEach select="$fd//dataList/val" var="selectvalue" >
														<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
														<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
													</x:forEach>
												</select>
											</a>
										</div>
									</c:when>
	
									<%--多选 104--%>
									<c:when test="${showtype =='104' && readwrite =='1'}">
										<c:set var="selectedvalue">,<x:out select="$fd/hiddenval/text()"/></c:set>
										<ul class="tchose">
											<x:forEach select="$fd//dataList/val" var="selectvalue" >
											<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
											<li>
												<a>
													<input type="checkbox" name='_main_<x:out select="$fd/sysname/text()"/>' id='checkIput<x:out select="$fd/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>' value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> />
													<label for='checkIput<x:out select="$fd/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>'><x:out select="$selectvalue/showval/text()"/></label>
												</a>
											</li>
											</x:forEach>
										</ul>
									</c:when>
	
									<%--下拉框 105--%>
									<c:when test="${showtype =='105' && readwrite =='1'}">
										<c:set var="selectedvalue"><x:out select="$fd/hiddenval/text()"/></c:set>
										<div class="examine">
											<a class="edit-select edit-ipt-r">
												<div class="edit-sel-show">
													<span>请选择</span>
												</div>    
												<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_main_<x:out select="$fd/sysname/text()"/>' prompt='<x:out select="$fd/value/text()"/>'>
													<option value="">请选择</option>
													<x:forEach select="$fd//dataList/val" var="selectvalue" >
														<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
														<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
													</x:forEach>
												</select>
											</a>
										</div>
									</c:when>
	
									<%--日期 107--%>
									<c:when test="${showtype =='107' && readwrite =='1'}">
										<div class="edit-ipt-a-arrow">
											<input data-dateType="date" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' placeholder="选择日期"/>
											<label class="edit-ipt-label" for="scroller"></label>
										</div>
									</c:when>
	
									<%--时间 108--%>
									<c:when test="${showtype =='108' && readwrite =='1'}">
										<div class="edit-ipt-a-arrow">
											<input data-dateType="time" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' placeholder="选择时间"/>
											<label class="edit-ipt-label" for="scroller"></label>
										</div>
									</c:when>
	
									<%--日期 时间 109--%>
									<c:when test="${showtype =='109' && readwrite =='1'}">
										<div class="edit-ipt-a-arrow">
											<input data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' placeholder="选择日期时间"/>
											<label class="edit-ipt-label" for="scroller"></label>
										</div>
									</c:when>
	
									<%--多行文本 110--%>
									<c:when test="${showtype =='110' && readwrite =='1'}">
										<textarea name='_main_<x:out select="$fd/sysname/text()"/>'  onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
										<span class="edit-txta-num">300</span>
									</c:when>
	
									<%--自动编号 111--%>
									<c:when test="${showtype =='111' && readwrite =='1'}">
										<x:out select="$fd/value/text()"/>
										<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:when>
	
									<%--html编辑 113--%>
									<c:when test="${showtype =='113' && readwrite =='1'}">
										<textarea name='_main_<x:out select="$fd/sysname/text()"/>'  onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"><x:out select="$fd/value/text()"/></textarea>
										<span class="edit-txta-num">300</span>
									</c:when>
	
									<%--附件上传 115--%>
									<c:when test="${showtype =='115'}">
										<c:if test="${readwrite =='1'}">
											<ul class="edit-upload">
					                            <li class="edit-upload-in" onclick="addImg('<x:out select="$fd/sysname/text()"/>');"><span><i class="fa fa-plus"></i></span></li>
					                        </ul>
										</c:if>
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
											<input name="fileNames<x:out select="$fd/sysname/text()"/>" value="${values}" type="hidden"/>
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
										<c:if test="${empty filename && readwrite =='1'}">
											该字段暂不支持手机办理，请于电脑端操作。
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
										<c:if test="${empty filename && readwrite =='1'}">
											该字段暂不支持手机办理，请于电脑端操作。
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
										<c:if test="${empty filename && readwrite =='1'}">
											该字段暂不支持手机办理，请于电脑端操作。
										</c:if>
									</c:when>
	
									<%--当前日期 204--%>
									<c:when test="${showtype =='204' && readwrite =='1'}">
										<x:out select="$fd/value/text()"/>
										<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:when>
	 
									<%--登录人信息 --%>
									<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
										<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
									</c:when>
	
									<%--单选人 全部 210--%>
									<c:when test="${showtype =='210' && readwrite =='1'}">
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
			           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user")' placeholder="请选择"/>
									</c:when>
	
									<%--多选人 全部 211--%>
									<c:when test="${showtype =='211' && readwrite =='1'}">
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
			           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","user");' placeholder="请选择"/>
									</c:when>
	
									<%--单选组织 212--%>
									<c:when test="${showtype =='212' && readwrite =='1'}">
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
			           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/> 
									</c:when>
	
									<%--多选组织 214--%>
									<c:when test="${showtype =='214' && readwrite =='1'}">
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
			           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*0*","org");' placeholder="请选择"/>
									</c:when>
	
									<%--金额 301--%>
									<c:when test="${showtype =='301' && readwrite =='1'}">
										<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="changeMoney('<x:out select='$fd/sysname/text()'/>');mainMath(this);" value='<x:out select="$fd/value/text()"/>' />
										</c:if>
										<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
											<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" name='_main_<x:out select="$fd/sysname/text()"/>' onkeyup="changeMoney('<x:out select='$fd/sysname/text()'/>');mainMath(this);" value='<x:out select="$fd/value/text()"/>' />
										</c:if>
									</c:when>								
									<%--批示意见 401--%>
									<c:when test="${showtype =='401' }">
										<c:if test="${readwrite =='1' }">
											<textarea class="edit-txta edit-txta-l" placeholder="请输入" name="comment_input" id="comment_input" maxlength="50"></textarea>
											<div class="examine" style="text-align:right;">
												<a class="edit-select edit-ipt-r">
													<div class="edit-sel-show">
														<span>常用审批语</span>
													</div>    
													<select class="btn-bottom-pop" onchange="selectComment(this);">
														<option value="">常用审批语</option> 
														<option value="同意">同意</option>
														<option value="已阅">已阅</option>
													</select>
												</a>
											</div>
										</c:if>
										<c:if test="${readwrite =='0' }">
											<x:forEach select="$fd//dataList/comment" var="ct" >
												<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
											</x:forEach>
										</c:if>
									</c:when>
	
									<%--当前日期时间 703--%>
									<c:when test="${showtype =='703' && readwrite =='1'}">
										<x:out select="$fd/value/text()"/>
										<input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:when>
	
									<%--单选人 本组织 704--%>
									<c:when test="${showtype =='704' && readwrite =='1'}">
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
										<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>' name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
									</c:when>
									
									<%--多选人 本组织 705--%>
									<c:when test="${showtype =='705' && readwrite =='1'}">
										<input type="hidden" readonly="readonly" id='_main_<x:out select="$fd/sysname/text()"/>' name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/hiddenval/text()"/>' />
										<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$fd/sysname/text()"/>'  name='_mainShow_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$fd/sysname/text()"/>","_main_<x:out select="$fd/sysname/text()"/>","*<%=orgId%>*","user");'/>
									</c:when>
	
									<%--流程发起人 708--%>
									<c:when test="${showtype =='708' && readwrite =='1'}">
										<x:out select="$fd/value/text()"/><input id='<x:out select="$fd/sysname/text()"/>' type="hidden" name='_main_<x:out select="$fd/sysname/text()"/>'  value='<x:out select="$fd/value/text()"/>' />
									</c:when>
									<%--合计字段 606--%>            
									<c:when test="${showtype =='606'}">
									    <c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
										<%
										String exp =(String)pageContext.getAttribute("expressionval");
										String[] newexpArr = exp.split("\\.");
										String  newxp = newexpArr[2];
										String nexp = (String)newxp.substring(0,newxp.length()-1);
										//nexp = nexp.replace("$","");
                                        pageContext.setAttribute("expressionval",nexp);
										%>
										<c:if test="${readwrite == '1'}">
											<input class="edit-ipt-r mainhj" mainsum="${expressionval}" placeholder="请输入" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>'/>
										</c:if>
										<c:if test="${readwrite != '1'}">
											<input class="edit-ipt-r mainhj" placeholder="" mainsum="${expressionval}" id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_main_<x:out select="$fd/sysname/text()"/>' readonly="readonly"/>
										</c:if>
									</c:when>
									<%--大写字段 302--%>
									<c:when test="${showtype =='302'}">
									    <c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
									    <%
										String exp =(String)pageContext.getAttribute("expressionval");
										String nexp = exp.replace("$","");
                                        pageContext.setAttribute("expressionval",nexp);
										%>
										<c:if test="${readwrite == '1'}">
											<input class="edit-ipt-r" placeholder="请输入" id="${expressionval}" type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>'/>		
										</c:if>
										<c:if test="${readwrite != '1'}">
											<input class="edit-ipt-r" placeholder="" id="${expressionval}" type="text" maxlength="18" name='_main_<x:out select="$fd/sysname/text()"/>' readonly="readonly"/>	
										</c:if>
									</c:when>
									<%--日期时间计算 808--%>
									<c:when test="${showtype =='808' && readwrite =='1'}">
										该字段暂不支持手机办理，请于电脑端操作。
									</c:when>
									<%--计算字段 203--%>
									<c:when test="${showtype =='203' && readwrite =='1'}">
										<c:set var="expressionval"><x:out select="$fd/expressionval/text()"/></c:set>
										<input class="edit-ipt-r mainmath" readonly="readonly" mainmathfun="${expressionval}" type="text" maxlength="18" id='<x:out select="$fd/sysname/text()"/>'  name='_main_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' />
									</c:when>
									<c:otherwise>
										<x:out select="$fd/value/text()"/>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
	            	</x:forEach>
	            	<x:forEach select="$doc2//subTableList/subTable" var="st">
						<c:set var="subName" ><x:out select="$st/name/text()"/></c:set>
						<c:set var="subTableName" ><x:out select="$st/tableName/text()"/></c:set>
						<input name="subTableName" value="${subTableName}" type="hidden" />
						<input name="subName" value="${subName}" type="hidden" />
						<tr>
							<!--子表信息begin-->
							<%--<c:set var="subTable" ></c:set>
							<x:forEach select="$doc2//subTableList/subTable/subFieldList" var="ct" varStatus="xh">
								<c:set var="subTable" >${xh.index+1}</c:set>
							</x:forEach>
							<c:if test="${not empty subTable}">
								<th>子表填写<c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></c:if>：</th>
								<td>
									<input id="subTableInput" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" value="" readonly="readonly" onclick="addSubTable();"/>
								</td>
							</c:if>
							--%><!--子表信息end-->
							<th>子表（${subName}）填写：</th>
							<td>
								<input id="subTableInput_${subTableName}" placeholder="添加子表" type="text" class="edit-ipt-r edit-ipt-arrow" 
								value="" readonly="readonly" onclick="addSubTable('${subTableName}');"/>
							</td>
						</tr>
					</x:forEach>	  
					<!-- ----------------------华丽的分界线-------------------------- -->  
	            </table>
            </c:if>
        </div>
    </article>
</section>
<footer class="wh-footer wh-footer-forum" id="footerButton">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
<%--                <a href="javascript:saveDraft();" class="fbtn-cancel col-xs-6"><i class="fa fa-file-text-o"></i>保存草稿</a>--%>
                <a href="javascript:sendFlow();" class="fbtn-matter col-xs-12"><i class="fa fa-check-square"></i>发送</a>
            </div>
        </div>
    </div>
</footer>
<section id="selectContent" style="display:none">
</section>
<jsp:include page="../common/include_workflow_subTable.jsp" flush="true">
	<jsp:param name="docXml" value="${docXml}" />
	<jsp:param name="orgId" value="<%=orgId %>" />
</jsp:include>
</form>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/modules/comm/microblog/script/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.core.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.datetime.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.select.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/followskip/followskip.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<%--<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.ios7.js"></script>--%>
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

    $(function(){
        selectDateTime();
		$("textarea").each(function(){
			$(this).change(function(){ 
				$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );
			});
		});
    });
    
    //日期空间初始化参数
    var opt = {
		'date': {
			preset: 'date', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            showNow: false,
            endYear:2099
		},
		'datetime': {
	  	 	preset: 'datetime', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            timeFormat: 'HH:ii',
            timeWheels:'HHii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            hourText:'时',
            minuteText:'分',
            showNow: false,
            endYear:2099
		},
		'time': {
	  	 	preset: 'time', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            timeFormat: 'HH:ii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            hourText:'时',
            minuteText:'分',
            amText:'上午',
            pmText:'下午',
            showNow: false,
            endYear:2099
		}
	}
    
    //选择日期时间
    function selectDateTime(){
    	var dateType = '';
    	$('input[data-datetype=date],[data-datetype=datetime],[data-datetype=time]').each(function(){
    		dateType = $(this).data('datetype');
    		if(dateType){
				$(this).mobiscroll(opt[dateType]);
    		}
    	});
    }
    
    
    //保存草稿
    function saveDraft(){
    	alert("功能暂无......");
	}

    //发送
	function sendFlow(){
		if(confirmForm()){
			//$('#sendForm table').append('<div style="display:none">' + $('[id^="subTableForm"] table tbody').html() + '</div>');
			$('#sendForm').submit();
		}
	}
    
    var dialog = null;
    function pageLoading(){
        dialog = $.dialog({
            content:"页面加载中...",
            title: 'load'
        });
    }
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){ 
		pageLoading();
		var selectIdVal = $('input[id="'+selectId+'"]').val();
		if( selectIdVal.indexOf(";") > 0 ){
			var selectIdArray = selectIdVal.split(';');
			selectIdVal = selectIdArray[1];
		}
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
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/person/searchOrg.controller?flag=org';
		}else if(listType=='user'){
			postUrl = '/defaultroot/person/newsearch.controller?flag=user';
		}
		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[id="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
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
		if(flag == 0){
			if($('#mainContent').is(':hidden')){
				$('[id="subHeader_'+subTableName+'"]').hide();
				$('[id="subSection_'+subTableName+'"]').hide();
				$('[id="subFooter_'+subTableName+'"]').hide();
				$('[id="subHeader_'+subTableName+'"]').data('hide','1');
			}else{
				$("#mainContent").css("display","none");
				$("#footerButton").css("display","none");
			}
			$("#selectContent").css("display","block");
		}else if(flag == 1){
			if($('[id="subHeader_'+subTableName+'"]') && $('[id="subSection_'+subTableName+'"]').is(':hidden') 
					&& $('[id="subHeader_'+subTableName+'"]').data('hide') == '1'){
				$('[id="subHeader_'+subTableName+'"]').data('hide','0');
				$('#selectContent').hide();
				$('[id="subHeader_'+subTableName+'"]').show();
				$('[id="subSection_'+subTableName+'"]').show();
				$('[id="subFooter_'+subTableName+'"]').show();
			}else{
				$("#selectContent").css("display","none");
				$("#mainContent").css("display","block");
				$("#footerButton").css("display","block");
			}
			$("#selectContent").empty();
		}
	}

	  //图片数标记
    var index = 0;
   
    //添加图片
    function addImg(name){
	   $(".edit-upload-in").before(       
		   '<li class="edit-upload-ed" id="imgli_'+index+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="imgShow_'+index+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeImg('+index+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="up_img_'+index+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="img_name_'+index+'" name="_mainfile_'+name+'"/>'+
       	   '</li>');
	   var img_li_id = "imgli_"+index;
	   var up_img_id = "up_img_"+index;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "imgShow_"+index, callback : function(){callBackFun(up_img_id,img_li_id)} });
	   $("#up_img_"+index).click();
	   index++;
    }
   
	//删除缩略图
    function removeImg(index){
	   $("#imgli_"+index).remove();
	   $("#up_img_"+index).remove();
    }
	
	//回调函数上传图片
	function callBackFun(upImgId,imgliId){
		var loadingDialog = openTipsDialog('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#img_name_"+(index-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				alert("文件上传失败！");
			}
		});
	}

    function selectCallBack(obj1,obj2){
		obj2.val( obj1.val() + ";" + obj2.val());
	}
    
    //选择批示意见
    function selectComment(obj){
    	var $selectObj = $(obj);
    	var selectVal = $selectObj.val();
    	var $textarea = $selectObj.parent().parent().siblings();
    	setSpanHtml(obj,selectVal);
    	$textarea.val($textarea.val() + selectVal);
    }
    
    //设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	} 

	//金额大写
	function changeMoney(id,name){
		var val =document.getElementById(id).value;
		if(isNaN(val)){
			document.getElementById(id).value="";
			alert("请输入数字");
			return false;
		}
		var cid = id.replace("$","");
        var valRmb = changeNumMoneyToChinese(val);
		if($("#" + cid).val() != 'undefined'){
			$("#" + cid).val(valRmb);				
		}
	
	}
    
	//主表计算字段
	function mainMath(obj){
		var id=obj.id;
		var objval =document.getElementById(id).value;
        if(isNaN(objval)){
			document.getElementById(id).value="";
			alert("请输入数字");
			return false;
		}
		var val = $('.edit-ipt-r.mainmath').attr("mainmathfun");//合计字段的公式
		var mathId = $('.edit-ipt-r.mainmath').attr("id");
		var str = val.replace(/\*/g, '|').replace(/\+/g, '|').replace(/\-/g, '|').replace(/\//g, '|').replace(/\(/g, '|').replace(/\)/g, '|');
		str = str.replace("||", "|");
		var strArr = str.split("|");
		var sa="";//公式id;
		var mval="";//公式id对应的值
		for(var i=0;i<strArr.length;i++){
			sa = strArr[i];
			if(sa !=null && sa!=''){
				mval = document.getElementById(sa).value;
				val=val.replace(sa,mval);
			}			
		}
        document.getElementById(mathId).value=eval(val);
	}
</script>


