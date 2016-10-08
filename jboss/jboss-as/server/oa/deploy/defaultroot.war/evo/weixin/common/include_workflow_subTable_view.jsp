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
<header class="wh-header" id="subHeader_${tableName}" style="display:none">
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
	                    		<a href="#stp${liNum}_${tableName}">${liNum}</a><em><i class="fa fa-check-circle"></i></em>
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
				            <div class="wh-edit-lists wh-edit-list-d" id="subTableTemplate_${tableName}">
				            <input name="${tableName}_subdataId" value="${dataId}" type="hidden"/>                
				                <div class="wh-r-tbbox wh-full-tbbox">        
				                    <table class="wh-table-edit">
				                    	<c:set var="index" value="0" />
										<x:forEach select="$ct//field" var="fd" >
											<c:set var="showtype"><x:out select="$fd/showtype/text()"/></c:set>
											<c:set var="readwrite"><x:out select="$fd/readwrite/text()"/></c:set>
											<c:set var="fieldtype"><x:out select="$fd/fieldtype/text()"/></c:set>
											<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
											<c:set var="name"><x:out select="$fd/name/text()"/></c:set>
											<c:set var="index" value="${index+1}"/>
											<c:set var="totfield"><x:out select="$fd/totfield/text()"/></c:set>
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
															<input class="edit-ipt-r"  id='<x:out select="$fd/sysname/text()"/>' type="text" maxlength="9" name='_sub_<x:out select="$fd/sysname/text()"/>' value='<x:out select="$fd/value/text()"/>' readonly="readonly" />
															<input type="hidden"  name="keyv" value="${name},${totfield},_sub_<x:out select='$fd/sysname/text()'/>"/>
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
<footer class="wh-ofooter">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="s-table-count">
                <strong id="totname"></strong><span id="tot"></span>
            </div>
        </div>
    </div>
</footer>
<footer class="wh-footer wh-footer-forum" id="subFooter_${tableName}" style="display:none">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:finishSubTableForm();" class="fbtn-matter col-xs-12">
                	<i class="fa fa-check-square"></i>完成
                </a>
            </div>
        </div>
    </div>
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
        var infoNavli = $('.wh-info-nav .wh-i-n-default li');
        infoNavli.first().addClass("nav-active");
    }
    
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
		bindLiClick();
		initTot();
    }
    
    //初始化子表表单
    function bindLiClick(){
    	/*
    	var $swiperUl = $('[id="swiper_ul_'+subTableName+'"]');
    	var menuIndex = $swiperUl.find('li').length + 1;
    	$('[id="subTableContent_'+subTableName+'"]').append('<span class="wh-place-holder" id="stp'+menuIndex+'_'+subTableName+'"></span>' +
    	'<div class="wh-edit-lists wh-edit-list-d">'+subTableTemplate+'</div>');
    	$('.wh-l-ckbox').unbind('click');
    	var menuLi = '<li class="col-xs-2 swiper-slide" data-checkbox="check">' +
    				 '<a href="#stp'+menuIndex+'_'+subTableName+'">' + menuIndex + '</a><em><i class="fa fa-check-circle"></i></em></li>';
    	$swiperUl.append(menuLi);
    	*/
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
    
    //添加完成子表表单
    function finishSubTableForm(){
    	$('#mainContent').show();
		$('#footerButton').show();
		$('[id="subHeader_'+subTableName+'"]').hide();
		$('[id="subSection_'+subTableName+'"]').hide();
		$('[id="subFooter_'+subTableName+'"]').hide();
		initTot();
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
				$("#tot").html(content+"&nbsp;");
			}
		}
	
	}
    
</script>


