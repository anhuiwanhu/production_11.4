<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ page import="java.io.File"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>
<!DOCTYPE html>
<html>
	<head lang="en">
	    <meta charset="UTF-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
	    <title>查看信息</title>
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.swiper.css" />
	    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
	</head>
	<body>
	<c:if test="${not empty docXml}">
		<x:parse xml="${docXml}" var="doc"/>
		<c:set var="informationTitle" ><x:out select="$doc//informationTitle/text()"/></c:set>
		<c:set var="informationType" ><x:out select="$doc//informationType/text()"/></c:set>
		<c:set var="informationContent" ><x:out select="$doc//informationContent/text()"/></c:set>
		<c:set var="informationIssuer" ><x:out select="$doc//informationIssuer/text()"/></c:set>
		<c:set var="informationIssueTime" ><x:out select="$doc//informationIssueTime/text()"/></c:set>
		<c:set var="informationKits" ><x:out select="$doc//informationKits/text()"/></c:set>
		<c:set var="channelName" ><x:out select="$doc//address/text()"/></c:set>
		<c:set var="displayTitle" ><x:out select="$doc//displayTitle/text()"/></c:set>
		<c:set var="displayImage" ><x:out select="$doc//displayImage/text()"/></c:set>
		<c:if test="${informationType =='2'}">
			<script>
				window.location = '${informationContent}';
			</script>
		</c:if>
		<section class="wh-section wh-section-bottomfixed">
		    <article class="wh-article wh-article-text">
		        <div class="wh-container">
		        	<c:if test="${displayTitle != '0'}">
		        		<h1>${informationTitle}</h1>
		           		<hr />
		        	</c:if>
		            <%
		            String infoRealPath = request.getRealPath("/upload/information");
		            String informationContent = org.apache.commons.lang.StringEscapeUtils.unescapeXml((String)pageContext.getAttribute("informationContent"));
		            %>
		            <div class="wh-article-desc">
		                <strong class="desc-author">${informationIssuer}</strong>
		                <span class="desc-date">${fn:substring(informationIssueTime,0,16)}	发布</span>
		            </div>
		            <div class="wh-article-fulltext">
		            	<x:forEach select="$doc//picList/picSaveName" var="pic" varStatus="status">
							<c:set var="filename"><x:out select="$pic/text()"/></c:set>
							<c:set var="folderVal">${fn:substring(filename,0,6)}</c:set>
							<c:if test="${displayImage != '0'}">
								<p><a href="/defaultroot/upload/information/${folderVal}/${filename}"><img src='/defaultroot/upload/information/${folderVal}/${filename}'/></a></p>
							</c:if>
						</x:forEach>
			            <c:choose>
			            	<c:when test="${informationType =='0' || informationType =='1'}">
								<%
								informationContent = com.whir.component.util.StringUtils.resizeImgSize(informationContent, "240", "50%");
								informationContent = informationContent.replaceAll("amp;", "");
								%>
						        <p style="text-indent:2em;"><%=informationContent%></p>
			            	</c:when>
			            	<c:when test="${informationType =='3'}">
							    <%
								informationContent = informationContent.replace("<![CDATA[","").replace("]]","");
								String fileName = informationContent.split("\\:")[1];
								String realFileName = informationContent.split("\\:")[0];
								%>
								<p>		
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="<%=realFileName%>" />
										<jsp:param name="saveFileNames" value="<%=fileName%>" />
										<jsp:param name="moduleName" value="information" />
									</jsp:include>
								</p>
			            	</c:when>
			            	<c:when test="${informationType =='4'}">
			            		<p>		
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="正文.doc" />
										<jsp:param name="saveFileNames" value="<%=informationContent+".doc"%>" />
										<jsp:param name="moduleName" value="information" />
									</jsp:include>
								</p>
			            	</c:when>
			            	<c:when test="${informationType =='5'}">
			            		<p>		
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="正文.xls" />
										<jsp:param name="saveFileNames" value="<%=informationContent+".xls"%>" />
										<jsp:param name="moduleName" value="information" />
									</jsp:include>
								</p>
			            	</c:when>
			            	<c:when test="${informationType =='6'}">
			            		<p>		
									<jsp:include page="../common/include_download.jsp" flush="true">
										<jsp:param name="realFileNames"	value="正文.ppt" />
										<jsp:param name="saveFileNames" value="<%=informationContent+".ppt"%>" />
										<jsp:param name="moduleName" value="information" />
									</jsp:include>
								</p>
			            	</c:when>
			            </c:choose>
		            </div>
	                <%
					File file = null;
					String fileUrl = "";
					String fileSizeStr = "";
					double fileSize = 0;
					BigDecimal bd = null;
					String downloadFileLink = "";
					//上传下载方式：1：http，0：ftp
					String smartInUse = "1";
					java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(""+session.getAttribute("domainId"));
					if(sysMap != null && sysMap.get("附件上传") != null){
						smartInUse = sysMap.get("附件上传").toString();
					}
					com.whir.evo.weixin.util.UploadFile uploadFile = new com.whir.evo.weixin.util.UploadFile();
					String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
				    %>
				    <x:forEach select="$doc//appList/appName" var="app"  varStatus="status">
					    <c:set var="filename"><x:out select="$app/following-sibling::appSaveName/text()"/></c:set>
					    <c:set var="appName"><x:out select="$app/text()"/></c:set>
					    <c:set var="folderVal">${fn:substring(filename,0,6)}</c:set>
					    <%
						/*fileUrl = infoRealPath + "/" + (String)pageContext.getAttribute("folderVal") + "/" + (String)pageContext.getAttribute("filename");
						file = new File(fileUrl);
						fileSizeStr = "";
						fileSize = file.length();
						if ((fileSize / 1024 / 1024) < 1) {
							if (fileSize / 1024 < 1) {
								fileSizeStr = String.valueOf(fileSize).concat("B");
							} else {
								fileSizeStr = String.valueOf(Math.round(fileSize / 1024 * 10) / 10.0).concat("KB");							
							}
						} else {
							bd = new BigDecimal(fileSize / 1024 / 1024);
							fileSizeStr = String.valueOf(bd.setScale(2, RoundingMode.HALF_UP)).concat("M");
						}*/
						downloadFileLink = uploadFile.getDownloadFileLink(((String)pageContext.getAttribute("filename")), ((String)pageContext.getAttribute("appName")), "information", fileServer, smartInUse).replaceAll("&cd=inline","");
						%>
			            <div class="wh-article-atta">
			                <i class="fa fa-paperclip"></i>
			                <a href="javascript:void();" onclick="clickSub('<%=downloadFileLink%>',this,'${filename}','information','<%=smartInUse %>');">
			                    <strong class="atta-name">${appName}</strong>
			                </a>
			                <span class="atta-size"><%=fileSizeStr%></span>
			            </div>
		            </x:forEach>
		            <!-- <div class="wh-article-pagenav">
		                <a href="javascript:void(0);" class="prev">上一页</a>
		                <a href="javascript:void(0);" class="next">下一页</a>
		            </div> -->
		        </div>
		    </article>
		</section>
		<footer class="wh-footer wh-footer-text">
			<c:set var="newChannelName">${channelName}</c:set>
			<c:if test="${fn:indexOf(newChannelName, '.') >= 0  }" >
				<c:set var="newChannelName">${fn:substringAfter(newChannelName,".")}</c:set>
			</c:if>
			<c:if test="${fn:indexOf(newChannelName, '.') >= 0  }" >
				<c:set var="newChannelName">${fn:substringAfter(newChannelName,".")}</c:set>
			</c:if>
			<c:if test="${fn:indexOf(newChannelName, '.') >= 0  }" >
				<c:set var="newChannelName">${fn:substringAfter(newChannelName,".")}</c:set>
			</c:if>
			<c:if test="${fn:indexOf(newChannelName, '.') >= 0  }" >
				<c:set var="newChannelName">${fn:substringAfter(newChannelName,".")}</c:set>
			</c:if>
			<c:if test="${fn:indexOf(newChannelName, '.') >= 0  }" >
				<c:set var="newChannelName">${fn:substringAfter(newChannelName,".")}</c:set>
			</c:if>
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:goChannelPage('${channelId}','${newChannelName}');" class="fbtn-link col-xs-6"><i class="fa fa-list"></i>${newChannelName}</a>
		                <span class="fbtn-matter col-xs-6"><i class="fa fa-eye"></i>阅读：${informationKits}</span>
		            </div>
		        </div>
		    </div>
		</footer>
	</c:if>
	</body>
</html>

<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
<script type="text/javascript">
    //跳转到对应栏目页面
    function goChannelPage(channelId,channelName){
		window.location = "/defaultroot/information/channelList.controller?channelId="+channelId+"&channelName="+channelName;
  	}
    
    wx.ready(function(){
	    wx.getNetworkType({
		    success: function (res) {
		        var networkType = res.networkType; // 返回网络类型2g，3g，4g，wifi
		    }
		});
    });
</script>








