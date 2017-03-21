<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.math.RoundingMode"%>
<link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
<%
request.setCharacterEncoding("UTF-8");
java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(""+session.getAttribute("domainId"));
//上传下载方式：1：http，0：ftp
int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
//文件下载服务
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
//真实文件名
String realFileNames = request.getParameter("realFileNames") != null ? request.getParameter("realFileNames") : "";
//保存文件名
String saveFileNames = request.getParameter("saveFileNames") != null ? request.getParameter("saveFileNames") : "";
//模块名称
String moduleName = request.getParameter("moduleName") != null ? request.getParameter("moduleName") : "";
String[] realFileNamesArray = realFileNames.split("\\|");
String[] saveFileNamesArray = saveFileNames.split("\\|");
com.whir.evo.weixin.util.UploadFile uploadFile = new com.whir.evo.weixin.util.UploadFile();
File file = null;
String fileUrl = "";
String fileSizeStr = "";
double fileSize = 0;
BigDecimal bd = null;
String downloadFileLink = "";
String moduleRealPath = request.getRealPath("/upload/"+moduleName);
String isYzOffice = com.whir.component.config.ConfigReader.getReader().getAttribute("Weixin", "isYzOffice");
%>
<div class="wh-article-atta">
<%
for(int i = 0,length = realFileNamesArray.length ;i < length ;i ++){
	downloadFileLink = uploadFile.getDownloadFileLink(saveFileNamesArray[i], realFileNamesArray[i], moduleName, fileServer).replaceAll("&cd=inline","");
%>
	<p>
		<i class="fa fa-paperclip"></i>
		<a href='javascript:void(0);' onclick='clickSubyz("<%=downloadFileLink%>",this,"<%=saveFileNamesArray[i]%>","<%=moduleName%>","<%=smartInUse%>","<%=isYzOffice %>");' color='blue'>
			<strong class="atta-name">
				<%=realFileNamesArray[i]%>
			</strong>
		</a>
	</p>
<%
}
%>
</div>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>