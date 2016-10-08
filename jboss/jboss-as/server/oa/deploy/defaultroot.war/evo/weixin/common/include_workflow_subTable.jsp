<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String docXml = request.getParameter("docXml");
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
%>
<c:if test="${not empty param.docXml}">
<input type="hidden" id="subTableFlag"/>
<x:parse xml="${param.docXml}" var="doc2"/>
<x:forEach select="$doc2//subTableList/subTable" var="st" >
<c:set var="name"><x:out select="$st/name/text()"/></c:set>
<c:set var="tableName"><x:out select="$st/tableName/text()"/></c:set>
<!-- 子表编辑dom begin -->
<header class="wh-header" id="subHeader_${tableName}" style="display:none" data-hide="0">
    <div class="wh-wrapper">
        <div class="wh-hd-op-left"></div>
        <div class="wh-container">
            <nav class="wh-info-nav">
                <ul class="wh-i-n-default swiper-wrapper" id="swiper_ul_${tableName}">
                <c:if test="${not empty docXml}">
        			<x:if select="$doc2//subTableList/subTable">
			        	<c:set var="liNum"></c:set>
			        	<x:forEach select="$st/subFieldList" varStatus="xhli">
			        		<c:set var="liNum">${xhli.index+1}</c:set>
	                    	<li <c:if test="${liNum eq 1}">class="col-xs-2 swiper-slide nav-active"</c:if>
	                    	<c:if test="${liNum ne 1}">class="col-xs-2 swiper-slide"</c:if> data-checkbox="check">
	                    		<a href="#stp${liNum}_${tableName}" id="clickA_${liNum}">${liNum}</a><em><i class="fa fa-check-circle"></i></em>
                    		</li>
	                	</x:forEach>
	                </x:if>
                </c:if>
                </ul>
            </nav>
        </div>
        <div class="wh-hd-op-right"></div>
    </div>
</header>
<section class="wh-section wh-section-topfixed wh-section-bottomfixed wh-section-morebtmfixed" id="subSection_${tableName}" style="display:none">
    <article class="wh-edit wh-edit-forum">
        <div class="wh-container" id="subTableContent_${tableName}">
        	<c:if test="${not empty docXml}">
        		<x:if select="$doc2//subTableList/subTable">
		        	<c:set var="subFieldsNum"></c:set>
		        	<x:forEach select="$st/subFieldList" var="ct" varStatus="xh">
		        		<c:set var="subFieldsNum">${xh.index+1}</c:set>
			            <span class="wh-place-holder" id="stp${subFieldsNum}_${tableName}"></span>
						<c:set var="dataId"><x:out select="$ct/dataId/text()"/></c:set>
						<!-- TODO -->
				            <div <c:if test="${subFieldsNum eq 1}">class="wh-edit-lists wh-edit-list-d wh-edit-list-d-fst"</c:if>
				            <c:if test="${subFieldsNum ne 1}">class="wh-edit-lists wh-edit-list-d"</c:if>  
				            id="subTableTemplate_${tableName}">
				            <!----------- 子表表单开始 ------------->
				            <input name="${tableName}_subdataId" value="${dataId}" type="hidden"/>
				            	<!-- 复选框 -->                
				                <div class="wh-l-ckbox">
				                    <i class="fa fa-check-circle"></i>
				                </div>
				                <!-- 表单建立 -->
				                <div class="wh-r-tbbox">        
				                    <table class="wh-table-edit">
				                    	<c:set var="index" value="0" />
				                    	<c:set var="subFieldCount" value="0"/>
										<x:forEach select="$ct//field" var="field" >
											<c:set var="subFieldCount" value="${subFieldCount+1}"/>
											<c:set var="showtype"><x:out select="$field/showtype/text()"/></c:set>
											<c:set var="readwrite"><x:out select="$field/readwrite/text()"/></c:set>
											<c:set var="fieldtype"><x:out select="$field/fieldtype/text()"/></c:set>
											<c:set var="mustfilled"><x:out select="$field/mustfilled/text()"/></c:set>
											<c:set var="name"><x:out select="$field/name/text()"/></c:set>
											<c:set var="totfield"><x:out select="$field/totfield/text()"/></c:set>
					                        <tr>
					                            <th>${name}<c:if test="${mustfilled == '1' && readwrite == '1'}"><i class="fa fa-asterisk"></i></c:if>：</th>
					                            <td>                             
													<c:choose>
														<%--单行文本 101--%>
														<c:when test="${showtype =='101' && readwrite =='1'}">
															<c:if test="${ fieldtype == '1000000'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="9" name='_sub_<x:out select="$field/sysname/text()"/>' onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');math(this)" value='<x:out select="$field/value/text()"/>'   />
															</c:if>
															<c:if test="${ fieldtype == '1000001'   }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="18" name='_sub_<x:out select="$field/sysname/text()"/>'  onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');math(this)"  value='<x:out select="$field/value/text()"/>' />
															</c:if>
															<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text"  name='_sub_<x:out select="$field/sysname/text()"/>'  onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');math(this)" value='<x:out select="$field/value/text()"/>'/>
															</c:if>
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$field/sysname/text()'/>"/>
														</c:when>
						
														<%--密码输入 102--%>
														<c:when test="${showtype =='102' && readwrite =='1'}">
															<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="password" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
														</c:when>
						
														<%--单选 103--%>
														<c:when test="${showtype =='103' && readwrite =='1'}">
															<c:set var="selectedvalue"><x:out select="$field/hiddenval/text()"/></c:set>
															<div class="examine">
																<a class="edit-select edit-ipt-r">
																	<div class="edit-sel-show">
																		<span>请选择</span>
																	</div>    
																	<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_sub_<x:out select="$field/sysname/text()"/>' prompt='<x:out select="$field/value/text()"/>'>
																		<option value="">请选择</option>
																		<x:forEach select="$field//dataList/val" var="selectvalue" >
																			<c:set var="curvalue"><x:out select="$selectvalue/hiddenval/text()"/></c:set>
																			<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selectedvalue == curvalue}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
																		</x:forEach>
																	</select>
																</a>
															</div>
														</c:when>
						
														<%--多选 104--%>
														<c:when test="${showtype =='104' && readwrite =='1'}">
															<c:set var="selectedvalue">,<x:out select="$field/hiddenval/text()"/></c:set>
															<ul class="tchose">
																<x:forEach select="$field//dataList/val" var="selectvalue" >
																<c:set var="curvalue">,<x:out select="$selectvalue/hiddenval/text()"/>,</c:set>
																<li>
																	<a>
																		<input onclick="setCheckBoxVal(this);" type="checkbox" value='<x:out select="$selectvalue/hiddenval/text()"/>,' <c:if test="${fn:indexOf(selectedvalue, curvalue) > -1}">checked="true"</c:if> />
																		<label for='checkIput<x:out select="$field/id/text()"/><x:out select="$selectvalue/hiddenval/text()"/>'><x:out select="$selectvalue/showval/text()"/></label>
																	</a>
																</li>
																</x:forEach>
															</ul>
															<input type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>' id='checkIput<x:out select="$field/id/text()"/>${selectedvalue}' value='<x:out select="$field/hiddenval/text()"/>' />
														</c:when>
														
														<%--下拉框 105--%>
														<c:when test="${showtype =='105' && readwrite =='1'}">
															<c:set var="selectedvalue"><x:out select="$field/hiddenval/text()"/></c:set>
															<div class="examine">
																<a class="edit-select edit-ipt-r">
																	<div class="edit-sel-show">
																		<span>请选择</span>
																	</div>    
																	<select onchange="setSpanHtml(this);" class="btn-bottom-pop" name='_sub_<x:out select="$field/sysname/text()"/>' prompt='<x:out select="$field/value/text()"/>'>
																		<option value="">请选择</option>
																		<x:forEach select="$field//dataList/val" var="selectvalue" >
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
																<input data-dateType="date" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' placeholder="选择日期"/>
																<label class="edit-ipt-label" for="scroller"></label>
															</div>
														</c:when>
						
														<%--时间 108--%>
														<c:when test="${showtype =='108' && readwrite =='1'}">
															<div class="edit-ipt-a-arrow">
																<input data-dateType="time" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' placeholder="选择时间"/>
																<label class="edit-ipt-label" for="scroller"></label>
															</div>
														</c:when>
						
														<%--日期 时间 109--%>
														<c:when test="${showtype =='109' && readwrite =='1'}">
															<div class="edit-ipt-a-arrow">
																<input data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' placeholder="选择日期时间"/>
																<label class="edit-ipt-label" for="scroller"></label>
															</div>
														</c:when>
						
														<%--多行文本 110--%>
														<c:when test="${showtype =='110' && readwrite =='1'}">
															<c:set var="fvalue"><x:out select="$field/value/text()"/></c:set>
															<c:set var="showNum">${300-fn:length(fvalue)}</c:set>
															<textarea name='_sub_<x:out select="$field/sysname/text()"/>' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');" 
															onchange="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"><x:out select="$field/value/text()" /></textarea>
															<span class="edit-txta-num">${showNum}</span>
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$field/sysname/text()'/>"/>
														</c:when>
						
														<%--自动编号 111--%>
														<c:when test="${showtype =='111' && readwrite =='1'}">
															<x:out select="$field/value/text()"/>
														</c:when>
						
														<%--html编辑 113--%>
														<c:when test="${showtype =='113' && readwrite =='1'}">
															<textarea name='_sub_<x:out select="$field/sysname/text()"/>'  onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"><x:out select="$field/value/text()"/></textarea>
															<span class="edit-txta-num">300</span>
														</c:when>
						
														<%--附件上传 115--%>
														<c:when test="${showtype =='115' && readwrite =='1'}">
															<ul class="edit-upload">
									                            <li class="edit-upload-in" onclick="addSubTableImg('<x:out select="$field/sysname/text()"/>',this);"><span><i class="fa fa-plus"></i></span></li>
										                        <input name="_sub_file_<x:out select="$field/sysname/text()"/>" id="_subfile_<x:out select="$field/sysname/text()"/>" type="hidden"/>
									                        </ul>
															<c:set var="values"><x:out select="$field/value/text()"/></c:set>
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
																<input name="fileNames<x:out select="$field/sysname/text()"/>" value="${values}" type="hidden"/>
															</c:if>
														</c:when>
														
														<%--Word编辑 116--%>
														<c:when test="${showtype =='116'}">
															<c:set var="index" value="${index+1}"/>
															<c:set var="filename"><x:out select="$field/value/text()"/></c:set>
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
															<c:set var="filename"><x:out select="$field/value/text()"/></c:set>
															<c:set var="index" value="${index+1}"/>
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
															<c:set var="filename"><x:out select="$field/value/text()"/></c:set>
															<c:set var="index" value="${index+1}"/>
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
															<x:out select="$field/value/text()"/>
															<input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
														</c:when>
						 
														<%--登录人信息 --%>
														<c:when test="${( showtype =='213' || showtype =='215'|| showtype =='406'|| showtype =='601'|| showtype =='602'|| showtype =='603'|| showtype =='604'|| showtype =='605'|| showtype =='607'|| showtype =='701'|| showtype =='702'|| showtype =='201'|| showtype =='202' || showtype =='207'  ) && readwrite =='1'}">
															<x:out select="$field/value/text()"/><input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>'  value='<x:out select="$field/value/text()"/>' />
														</c:when>
						
														<%--单选人 全部 210--%>
														<c:when test="${showtype =='210' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","*0*","user")' placeholder="请选择"/>
														</c:when>
						
														<%--多选人 全部 211--%>
														<c:when test="${showtype =='211' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","*0*","user");' placeholder="请选择"/>
														</c:when>
						
														<%--单选组织 212--%>
														<c:when test="${showtype =='212' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","*0*","org");' placeholder="请选择"/> 
														</c:when>
						
														<%--多选组织 214--%>
														<c:when test="${showtype =='214' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("1","_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","*0*","org");' placeholder="请选择"/>
														</c:when>
						
														<%--金额 301--%>
														<c:when test="${showtype =='301' && readwrite =='1'}">
															<c:if test="${fieldtype == '1000000' || fieldtype == '1000001'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" name='_sub_<x:out select="$field/sysname/text()"/>' onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');math(this);" value='<x:out select="$field/value/text()"/>' />
															</c:if>
															<c:if test="${fieldtype != '1000000' && fieldtype != '1000001'  }">
																<input class="edit-ipt-r" placeholder="请输入" id='<x:out select="$field/sysname/text()"/>' type="text" name='_sub_<x:out select="$field/sysname/text()"/>' onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');math(this);" value='<x:out select="$field/value/text()"/>' />
															</c:if>
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$field/sysname/text()'/>"/>
														</c:when>
						
														<%--金额大写 302--%>
														<c:when test="${showtype =='302' && readwrite =='1'}">
															<input class="edit-ipt-r" readonly type="text" maxlength="18" id='<x:out select="$field/sysname/text()"/>' onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$field/sysname/text()'/>"/>
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
																<c:set var="index" value="${index+1}"/>
																<x:forEach select="$field//dataList/comment" var="ct" >
																	<x:out select="$ct//content/text()"/>&nbsp;&nbsp;<x:out select="$ct//person/text()"/>(<x:out select="$ct//date/text()"/>)
																</x:forEach>
															</c:if>
														</c:when>
						
														<%--当前日期时间 703--%>
														<c:when test="${showtype =='703' && readwrite =='1'}">
															<x:out select="$field/value/text()"/>
															<input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
														</c:when>
						
														<%--单选人 本组织 704--%>
														<c:when test="${showtype =='704' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
															<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("0","_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","*<%=orgId%>*","user");'/>
														</c:when>
														
														<%--多选人 本组织 705--%>
														<c:when test="${showtype =='705' && readwrite =='1'}">
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
															<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" onclick='selectUser("1","_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}","*<%=orgId%>*","user");'/>
														</c:when>
						
														<%--流程发起人 708--%>
														<c:when test="${showtype =='708' && readwrite =='1'}">
															<x:out select="$field/value/text()"/><input id='<x:out select="$field/sysname/text()"/>' type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>'  value='<x:out select="$field/value/text()"/>' />
														</c:when>
														<%--日期时间计算 808--%>
														<c:when test="${showtype =='808' && readwrite =='1'}">
															<c:set var="index" value="${index+1}"/>
															该字段暂不支持手机办理，请于电脑端操作。
														</c:when>
														<c:when test="${showtype =='105' && readwrite !='1'}">
														    <c:set var="index" value="${index+1}"/>
															<input class="edit-ipt-r"  id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="9" name='_sel_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' readonly="readonly" />
															<input type="hidden"  name="keyv" value="${name},${totfield},_sel_<x:out select='$field/sysname/text()'/>"/>
															<input type="hidden"  name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>'/>
														</c:when>
														<c:when test="${showtype =='212' && readwrite !='1'}">
														    <c:set var="index" value="${index+1}"/>
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow"  placeholder="请选择"/> 
														</c:when>
														<c:when test="${showtype =='214' && readwrite !='1'}">
														 	<c:set var="index" value="${index+1}"/>
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow"  placeholder="请选择"/>
														</c:when>
														<c:when test="${showtype =='704' && readwrite !='1'}">
															<c:set var="index" value="${index+1}"/>
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
															<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" />
														</c:when>
														<%--多选人 本组织 705--%>
														<c:when test="${showtype =='705' && readwrite !='1'}">
															<c:set var="index" value="${index+1}"/>
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
															<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" placeholder="请选择" />
														</c:when>
														<c:when test="${showtype =='210' && readwrite !='1'}">
															<c:set var="index" value="${index+1}"/>
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow"  placeholder="请选择"/>
														</c:when>
														<c:when test="${showtype =='211' && readwrite !='1'}">
															<c:set var="index" value="${index+1}"/>
															<input type="hidden" readonly="readonly" id='_sub_<x:out select="$field/sysname/text()"/>_${subFieldsNum}' name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>' />
								           					<input type="text"   readonly="readonly" id='_mainShow_<x:out select="$field/sysname/text()"/>_${subFieldsNum}'  name='_mainShow_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' class="edit-ipt-r edit-ipt-arrow"  placeholder="请选择"/>
														</c:when>
														
														<c:when test="${showtype =='103' && readwrite !='1'}">
														    <c:set var="index" value="${index+1}"/>
															<input class="edit-ipt-r"  id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="9" name='_sel_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' readonly="readonly" />
															<input type="hidden"  name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/hiddenval/text()"/>'/>
														</c:when>
														<c:when test="${showtype =='104' && readwrite !='1'}">
															<c:set var="index" value="${index+1}"/>
															<input class="edit-ipt-r"  id='<x:out select="$field/sysname/text()"/>' type="text" maxlength="9" name='_sel_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' readonly="readonly" />
															<input type="hidden" name='_sub_<x:out select="$field/sysname/text()"/>' id='checkIput<x:out select="$field/id/text()"/>${selectedvalue}' value='<x:out select="$field/hiddenval/text()"/>' />
														</c:when>
														<c:when test="${showtype =='115' && readwrite !='1'}">
															<c:set var="index" value="${index+1}"/>
															<c:set var="values"><x:out select="$field/value/text()"/></c:set>
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
																<c:set var="fileValues" value="${fn:replace(values,',;', '|')}" />
																<input name="_sub_file_<x:out select="$field/sysname/text()"/>" type="hidden" value="${fileValues }">
															</c:if>
														</c:when>
														<%--计算字段 203--%>
														<c:when test="${showtype =='203' && readwrite =='1'}">
														    <c:set var="expressionval"><x:out select="$field/expressionval/text()"/></c:set>
															<input class="edit-ipt-r whmath" readonly="readonly" mathfun="${expressionval}" type="text" maxlength="18" id='<x:out select="$field/sysname/text()"/>' onkeyup="addtot('${name}','${totfield}','_sub_<x:out select='$field/sysname/text()'/>');" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>' />
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$field/sysname/text()'/>"/>
														</c:when>
														<c:otherwise>
															<c:set var="index" value="${index+1}"/>
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$field/sysname/text()'/>"/>
															<input class="edit-ipt-r" id='<x:out select="$field/sysname/text()"/>' type="hidden" maxlength="50" name='_sub_<x:out select="$field/sysname/text()"/>' value='<x:out select="$field/value/text()"/>'  />
															<x:out select="$field/value/text()"/>
														</c:otherwise>
													</c:choose>
												</td>
					                        </tr>
						                </x:forEach>
				                    </table>
				                </div>
			                </div>
					</x:forEach>
        		</x:if>
			</c:if>
        </div>
    </article>
</section>

<!-- 底部白条部分 -->
<footer class="wh-ofooter" id="subFooter_totname" style="display:none">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="s-table-count">
                <strong id="totname"></strong><span id="tot"></span>
            </div>
        </div>
    </div>
</footer>

<!-- 按钮完成部分 -->
<footer class="wh-footer wh-footer-forum" id="subFooter_${tableName}" style="display:none">
    <c:choose>
    	<c:when test="${index lt subFieldCount}">
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:deleteSubTableForm();" class="fbtn-cancel col-xs-4"><i class="fa fa-times"></i>删除</a>
		                <a href="javascript:addSubTableForm();" class="fbtn-matter col-xs-4"><i class="fa fa-plus"></i>添加</a>
		                <a href="javascript:finishSubTableForm();" class="fbtn-matter col-xs-4"><i class="fa fa-check-square"></i>完成<em id="em_num_${tableName}">${empty subFieldsNum ? '1' : subFieldsNum}</em></a>
		            </div>
		        </div>
		    </div>
    	</c:when>
    	<c:otherwise>
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:finishSubTableForm2();" class="fbtn-matter col-xs-12">
		                	<i class="fa fa-check-square"></i>完成
		                </a>
		            </div>
		        </div>
		    </div>
    	</c:otherwise>
    </c:choose>
</footer>
</x:forEach>
</c:if>
<script type="text/javascript">
	
	var map={};
    function showSubOperate(){
    	//水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 5,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
        //var infoNavli = $('.wh-info-nav .wh-i-n-default li');
        //infoNavli.first().addClass("nav-active");
		bindSelect();
    }
    
    //绑定选择方法
    function bindSelect(){
    	var $ckBoxs = $('.wh-l-ckbox');
    	$ckBoxs.unbind('click');
 	    $ckBoxs.click(function(){
            var $ckBox = $(this);
            if($ckBox.hasClass('ckbox-active')){
	            $ckBox.removeClass('ckbox-active');
            }else{
	            $ckBox.addClass('ckbox-active');
            }
        });
    }
    
    var subTableTemplate;
    var subTableName;
    //添加子表数据
    function addSubTable(subTableNameParam){
    	$('#subTableFlag').val(subTableNameParam);
    	subTableName = subTableNameParam;
    	$('#mainContent').hide();
		$('#footerButton').hide();
		$('[id="subHeader_'+subTableNameParam+'"]').show();
		$('[id="subSection_'+subTableNameParam+'"]').show();
		$('[id="subFooter_'+subTableNameParam+'"]').show();
		showSubOperate();
		//绑定头部点击效果事件
    	var $swiperLis = $('[id="swiper_ul_'+subTableName+'"] li');
    	$swiperLis.unbind('click');
    	$swiperLis.click(function(){
    		var $swiperLi = $(this);
    		$swiperLis.not(this).removeClass('nav-active').data("checkbox","uncheck");
            $swiperLi.addClass('nav-active').data("checkbox","check");
    	});
		var $firstDataId = $('[id="subTableTemplate_'+subTableNameParam+'"] input').eq(0);
		var dataIdVal = $firstDataId.val();        
		$firstDataId.val('');
		//添加新子表表单置空
		subTableTemplate = $('[id="subTableTemplate_'+subTableNameParam+'"]').html();
		/*var sub = $('[id="subTableTemplate_'+subTableNameParam+'"]').eq(0).html();
       $('[id="subTableTemplate_'+subTableNameParam+'"]').eq(0).find('input,select,textarea').each(function(){
			if($(this).attr("readonly") != 'readonly'){
				$(this).attr("value","");
			}
	    });
		subTableTemplate = $('[id="subTableTemplate_'+subTableNameParam+'"]').eq(0).html();
		$('[id="subTableTemplate_'+subTableNameParam+'"]').eq(0).html(sub);*/
		$firstDataId.val(dataIdVal);
	    initTot();
	    var htmlA='${liNum}';
	    if(htmlA > 0){
	    	document.getElementById("clickA_1").click();
		 }
    }
    
    //添加子表表单
    function addSubTableForm(){
    	var $swiperUl = $('[id="swiper_ul_'+subTableName+'"]');
    	var menuIndex = $swiperUl.find('li').length + 1;
    	$('[id="subTableContent_'+subTableName+'"]').append('<span class="wh-place-holder" id="stp'+menuIndex+'_'+subTableName+'"></span>' +
    	'<div class="wh-edit-lists wh-edit-list-d">'+subTableTemplate+'</div>');
    	$('.wh-l-ckbox').unbind('click');
    	//var menuLi = '<li class="col-xs-2 swiper-slide" data-checkbox="check">' +
    	//'<a href="#stp'+menuIndex+'_'+subTableName+'">' + menuIndex + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    	//$swiperUl.append(menuLi);
    	restructureLi($swiperUl);
    	bindSelect();
    	setNewId();
    	//设置点击日期时间事件，解决添加后日期选择无事件的问题
    	selectDateTime();
    	var $emNumber = $('[id="em_num_'+subTableName+'"]');
    	$emNumber.html(parseInt($emNumber.text())+parseInt(1));
		initTot();
    }
    
    //设置新表单域的id
    function setNewId(){
    	var tableIndex = 0;
    	var oldId;
    	var clickContent;
    	var clickConArray;
    	var newClickContent = '';
    	$('[id="subTableContent_'+subTableName+'"] table').each(function(){
    		tableIndex ++;
    		newClickContent = '';
    		$(this).find('input,select,textarea').each(function(){
    			clickContent = $(this).attr('onclick');
    			if(clickContent && clickContent.indexOf('selectUser') != -1){
	    			clickConArray = clickContent.split(',');
	    			for(var i=0,length=clickConArray.length;i<length;i++){
	    				if(i == 1 || i == 2){
		    				newClickContent += clickConArray[i].substring(0,clickConArray[i].length-1)+'_'+tableIndex+'_"';
	    				}else{
	    					newClickContent += clickConArray[i];
	    				}
	    				if(i < length-1){
	    					 newClickContent +=  ','
	    				}
	    			}
	    			$(this).attr('onclick',newClickContent);
    			}
    			oldId = $(this).attr('id');
    			if(oldId){
	    			if(oldId.substring(oldId.length-1) == '_'){
	    				return;
	    			}
	    			$(this).attr('id',oldId+'_'+tableIndex+'_');
    			}
   			});
   		});
    }
    
    //删除子表表单
    function deleteSubTableForm(){
    	var $ckboxActive = $('.wh-l-ckbox.ckbox-active');
    	if($ckboxActive.length <= 0){
    		alert('请选择需要删除的子表表单！');
    		return;
    	}
    	var $ckboxDiv;
    	//var aHrefVal;
    	$ckboxActive.each(function(){
    		$ckboxDiv = $(this);
    		//aHrefVal = '#'+$ckboxDiv.parent().prev().attr('id');
    		$ckboxDiv.parent().prev().remove();
    		$ckboxDiv.parent().remove();
    		//$('a[href="'+aHrefVal +'"]').parent().remove();
    	});
   		restructureLi($('[id="swiper_ul_'+subTableName+'"]'));
    	var $emNumber = $('[id="em_num_'+subTableName+'"]');
    	$emNumber.html($('[id="swiper_ul_'+subTableName+'"] li').length);
		initTot();
    }
    
    //添加完成子表表单
    function finishSubTableForm(){
    	$('#mainContent').show();
		$('#footerButton').show();
		$('[id="subHeader_'+subTableName+'"]').hide();
		$('[id="subSection_'+subTableName+'"]').hide();
		$('[id="subFooter_'+subTableName+'"]').hide();
		$('#subFooter_totname').hide();
		$('[id="subTableInput_'+subTableName+'"]').val($('[id="swiper_ul_'+subTableName+'"] li').length+'条子表记录');
		maniSum();
    }
        
    function finishSubTableForm2(){
    	$('#mainContent').show();
		$('#footerButton').show();
		$('[id="subHeader_'+subTableName+'"]').hide();
		$('#subFooter_totname').hide();
		$('[id="subSection_'+subTableName+'"]').hide();
		$('[id="subFooter_'+subTableName+'"]').hide();
    }
    
    //重构头部li
    function restructureLi($swiperUl){
    	var menuLi = '';
    	$('[id="swiper_ul_'+subTableName+'"] li').remove();
    	$('[id="subTableContent_'+subTableName+'"] span[id^="stp"]').each(function(index){
    		if(index == 0){
	    		menuLi = '<li class="col-xs-2 swiper-slide nav-active" data-checkbox="check">' +
	    				 '<a href="#'+$(this).attr('id')+'">' + parseInt(index+1) + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    		}else{
    			menuLi = '<li class="col-xs-2 swiper-slide" data-checkbox="check">' +
	    				 '<a href="#'+$(this).attr('id')+'">' + parseInt(index+1) + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    		}
    		$swiperUl.append(menuLi);
    	});
   	 	//水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 5,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
    	var $swiperLis = $('[id="swiper_ul_'+subTableName+'"] li');
    	$swiperLis.unbind('click');
    	$swiperLis.click(function(){
    		var $swiperLi = $(this);
    		$swiperLis.not(this).removeClass('nav-active').data("checkbox","uncheck");
            $swiperLi.addClass('nav-active').data("checkbox","check");
    	});
    }
    
   //图片数标记
    var subIndex = 0;
   
    //添加图片
    function addSubTableImg(name,obj){
	   $(obj).before(       
		   '<li class="edit-upload-ed" id="sub_imgli_'+subIndex+'" style="display:none">'+
		       '<span>'+
		       	   '<img src="" id="sub_imgShow_'+subIndex+'"/>'+
			       '<em>'+
			       	 '<i onclick="removeSubImg('+subIndex+');" class="fa fa-minus-circle"></i>'+
			       '</em>'+
		       '</span>'+
		       '<input type="file" id="sub_up_img_'+subIndex+'" style="display:none" name="imgFile"/>'+
		       '<input type="hidden" id="sub_img_name_'+subIndex+'" name="_subfile_'+name+'_'+subIndex+'"/>'+
       	   '</li>');
	   var img_li_id = "sub_imgli_"+subIndex;
	   var up_img_id = "sub_up_img_"+subIndex;
	   new uploadPreview({ UpBtn: up_img_id, DivShow: img_li_id, ImgShow: "sub_imgShow_"+subIndex, callback : function(){subCallBackFun(up_img_id,img_li_id,obj)} });
	   $("#sub_up_img_"+subIndex).click();
	   subIndex++;
    }
   
	//删除缩略图
    function removeSubImg(subIndex){
	   $("#sub_imgli_"+subIndex).remove();
	   $("#sub_up_img_"+subIndex).remove();
    }
	
	//回调函数上传图片
	function subCallBackFun(upImgId,imgliId,obj){
		var loadingDialog = openTipsDialog('正在上传...');
		var fileShowName = $("#"+upImgId).val();
		$.ajaxFileUpload({
			url: '/defaultroot/upload/fileUpload.controller?modelName=customform', //用于文件上传的服务器端请求地址
			secureuri:false,
			fileElementId: upImgId, //文件上传域的ID
			dataType: 'json', //返回值类型 一般设置为json
			success: function (msg, status){  //服务器成功响应处理函数---获取上传图片保存名
				$("#sub_img_name_"+(subIndex-1)).val(msg.data+"|"+fileShowName);
				$("#"+imgliId).show();
				var $valInput = $(obj).next();
				var value = $valInput.val();
				if(value){
					$valInput.val(value + ';' + msg.data+"|"+fileShowName);
				}else{
					$valInput.val(msg.data+"|"+fileShowName);
				}
				loadingDialog.close();
			},
			error: function (data, status, e){//服务器响应失败处理函数
				alert("文件上传失败！");
			}
		});
	}
	
	//设置多选框的选中值
	function setCheckBoxVal(obj){
		var $checkBox = $(obj);
		var isChecked = $checkBox.is(':checked');
		var checkVal = $checkBox.val();
		var $hideInput = $checkBox.parent().parent().parent().next('input');
		var hideInputVal = $hideInput.val();
		if(isChecked){
			$hideInput.val(hideInputVal + checkVal);
		}else{
			$hideInput.val(hideInputVal.replace(checkVal,''));
		}
	}
    
	function addtot(sysname,flag,name){
		$("#totname").html("合计项：");
		//alert(flag);
		if(flag == '0'){
			//alert("sysname="+sysname);
			//alert("flag="+flag);
		   // alert("name="+name);
			var arr = $("input[name='"+name+"']");
			//alert(arr[0].value);
			var sum = 0-0;
			for(var i=0;i<arr.length;i++){
				if(!isNaN(arr[i].value)){
					if(arr[i].value != ''){
						var num = arr[i].value-0;
						sum = sum+num;
							
					}
				}else{
					alert("请输入数字");
					return false;
				}
			}
			//alert(sysname+":"+sum);
			var content="";
			/*if(content.indexOf(sysname)<-1){
				content += sysname+":"+sum+"<br>";
			}else{
			
			}*/
			map[sysname]=sysname+":"+sum;
			for(var prop in map){
				content += map[prop];
			}
			if(content !=""){
				$('#subFooter_totname').show();
			}
			$("#tot").html(content+"&nbsp;");
			var subId = name.substring(5,name.length);
			subId = subId.replace("$","");
			var sumrmb = changeNumMoneyToChinese(sum);
            var rmbId = $("#" + subId).attr("name");//大写金额
			if(rmbId != undefined &&　rmbId　!= 'undefined'){
				rmbId =rmbId.substring(6,rmbId.length);
				rmbId = rmbId.replace("$","");
				if($("#" + subId).val() != 'undefined'){
					$("#" + subId).val(sum);				
				}
				if($("#" + rmbId).val() != 'undefined'){
					$("#" + rmbId).val(sumrmb);				
				}
			}

		}
	}

	function initTot(){
		//子表合计字段相关
		$("#totname").html("合计项：");
		var arr = $("input[name=keyv]");
        for(var i=0;i<arr.length;i++){
			//alert(arr[i].value);
			var arrV = (arr[i].value).split(",");
			//alert(arrV[0]+" "+arrV[1]+" "+arrV[2]);
			//alert(arrV[1]);
            if(arrV[1] =='0'){
				var arrN = $("input[name='"+arrV[2]+"']");
				//alert(arr[0].value);
				var sum = 0-0;
				for(var j=0;j<arrN.length;j++){
					if(!isNaN(arrN[j].value)){
						if(arrN[j].value != ''){
							var num = arrN[j].value-0;
							sum = sum+num;
						}
					}else{
						alert("请输入数字");
						return false;
					}	
				}
				//alert(sysname+":"+sum);
				var content="";
				/*if(content.indexOf(sysname)<-1){
					content += sysname+":"+sum+"<br>";
				}else{
				
				}*/
				
				map[arrV[0]]=arrV[0]+":"+sum;
				for(var prop in map){
					content += map[prop];
				}
				if(content !=""){
					$('#subFooter_totname').show();
				}
				$("#tot").html(content+"&nbsp;");
			}
		}
	
	}

	//将数字转换成大写的人民币

　　function changeNumMoneyToChinese(money) {

　　var cnNums = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"); //汉字的数字

　　var cnIntRadice = new Array("", "拾", "佰", "仟"); //基本单位

　　var cnIntUnits = new Array("", "万", "亿", "兆"); //对应整数部分扩展单位

　　var cnDecUnits = new Array("角", "分", "毫", "厘"); //对应小数部分单位

　　var cnInteger = "整"; //整数金额时后面跟的字符

　　var cnIntLast = "元"; //整型完以后的单位

　　var maxNum = 999999999999999.9999; //最大处理的数字

　　var IntegerNum; //金额整数部分

　　var DecimalNum; //金额小数部分

　　var ChineseStr = ""; //输出的中文金额字符串

　　var parts; //分离金额后用的数组，预定义

　　if (money == "") {

　　return "";

　　}

　　money = parseFloat(money);

　　if (money >= maxNum) {

　　alert('超出最大处理数字');

　　return "";

　　}

　　if (money == 0) {

　　ChineseStr = cnNums[0] + cnIntLast + cnInteger;

　　return ChineseStr;

　　}

　　money = money.toString(); //转换为字符串

　　if (money.indexOf(".") == -1) {

　　IntegerNum = money;

　　DecimalNum = '';

　　} else {

　　parts = money.split(".");

　　IntegerNum = parts[0];

　　DecimalNum = parts[1].substr(0, 4);

　　}

　　if (parseInt(IntegerNum, 10) > 0) { //获取整型部分转换

　　var zeroCount = 0;

　　var IntLen = IntegerNum.length;

　　for (var i = 0; i < IntLen; i++) {

　　var n = IntegerNum.substr(i, 1);

　　var p = IntLen - i - 1;

　　var q = p / 4;

　　var m = p % 4;

　　if (n == "0") {

　　zeroCount++;

　　} else {

　　if (zeroCount > 0) {

　　ChineseStr += cnNums[0];

　　}

　　zeroCount = 0; //归零

　　ChineseStr += cnNums[parseInt(n)] + cnIntRadice[m];

　　}

　　if (m == 0 && zeroCount < 4) {

　　ChineseStr += cnIntUnits[q];

　　}

　　}

　　ChineseStr += cnIntLast;

　　//整型部分处理完毕

　　}

　　if (DecimalNum != '') { //小数部分

　　var decLen = DecimalNum.length;

　　for (var i = 0; i < decLen; i++) {

　　var n = DecimalNum.substr(i, 1);

　　if (n != '0') {

　　ChineseStr += cnNums[Number(n)] + cnDecUnits[i];

　　}

　　}

　　}

　　if (ChineseStr == '') {

　　ChineseStr += cnNums[0] + cnIntLast + cnInteger;

　　} else if (DecimalNum == '') {

　　ChineseStr += cnInteger;

　　}

　　return ChineseStr;

　　}
    
	//子表计算字段
    function math(obj){
		var id = obj.id;
		var objval =document.getElementById(id).value;
       // if(isNaN(objval)){
			//document.getElementById(id).value="";
			//alert("请输入数字");
			//return false;
		//}
		var val = $('.edit-ipt-r.whmath').attr("mathfun");//合计字段的公式
		var mathId = $('.edit-ipt-r.whmath').attr("id");
		var arr=id.split("_");
		var str = val.replace(/\*/g, '|').replace(/\+/g, '|').replace(/\-/g, '|').replace(/\//g, '|').replace(/\(/g, '|').replace(/\)/g, '|');
		str = str.replace("||", "|");
		if(arr.length>2){//两个及以上子表
			var num = id.substring(id.length-2,id.length-1);
			mathId = mathId.substring(0,mathId.length-3)+"_"+num+"_";
		}
		var strArr = str.split("|");
		var sa="";//公式id;
		var mval="";//公式id对应的值
	    for(var i=0;i<strArr.length;i++){
			sa = strArr[i];
			if(arr.length>2 && sa !=null && sa!=''){//两个及以上子表
				sa = sa+"_"+num+"_";
			}
			if(sa !=null && sa!=''){
				mval = document.getElementById(sa).value;
				if(arr.length>2){
					sa = sa.substring(0,sa.length-3); 
				}
				val=val.replace(sa,mval);
			}			
		}
        document.getElementById(mathId).value=eval(val);
		//alert('val='+val);
	}
    
	//主表合计字段
	function maniSum(){
		var val = $('.edit-ipt-r.mainhj').attr("mainsum");//主表合计字段子表字段的字段名
		val = "_sub_"+val;
		var sum= 0-0;
		var varr = document.getElementsByName(val);
		for(var i=0;i<varr.length;i++){
			var num = varr[i].value-0;
			sum =sum+num;
		}
		$('.edit-ipt-r.mainhj').val(sum);
	}
</script>


