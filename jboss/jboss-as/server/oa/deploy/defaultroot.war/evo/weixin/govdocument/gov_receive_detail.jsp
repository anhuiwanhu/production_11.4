<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@ page import="com.whir.common.util.*"%><%@ page import="java.util.*"%><%@ page import="com.whir.common.db.Dbutil"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>收文详情</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<%
String recordId = request.getParameter("recordId");
if(recordId == null){
	recordId = request.getParameter("id");
}
if(recordId == null || "".equals(recordId)){
	recordId = request.getParameter("docId");
}

com.whir.govezoffice.documentmanager.bd.SendFileBD sendFileBD = new com.whir.govezoffice.documentmanager.bd.SendFileBD();
com.whir.govezoffice.documentmanager.po.GovDocumentSendFilePO po = sendFileBD.load(recordId);
String goldGridId = po.getGoldGridId();
String accessoryName = po.getAccessoryName();
String accessorySaveName = po.getAccessorySaveName();
request.setAttribute("accessoryName",accessoryName);
request.setAttribute("accessorySaveName",accessorySaveName);
String documentSendFileWriteOrg = po.getDocumentSendFileWriteOrg();
java.text.SimpleDateFormat myFmt1= new java.text.SimpleDateFormat("yy/MM/dd"); 
String wordType = po.getDocumentWordType();
String createdTime = myFmt1.format(po.getCreatedTime());
String title = po.getDocumentSendFileTitle();


	String sql=" select sendfile_id from gov_sendfile_user where isdelete is null and sendfile_id =:sendfileid and emp_Id=:empid ";
	Map varMap=new HashMap();
	varMap.put("sendfileid",recordId);
	varMap.put("empid",	session.getAttribute("userId").toString() );
	Dbutil  dbUtil=new Dbutil();
	Object []workInfoObj=null;
	try {
		workInfoObj=dbUtil.getFirstDataBySQL(sql, varMap);

	} catch (Exception e) { 
		e.printStackTrace();
	}

%>
<body>
<%if (workInfoObj == null || workInfoObj.length == 0){}else{%>

	<section class="wh-section wh-section-bottomfixed">
	    <article class="wh-edit wh-edit-forum">
	        <div>
	            <table class="wh-table-edit">
	                <tr>
	                    <th>拟稿单位：</th>
	                    <td><span class="fr" ><%=documentSendFileWriteOrg%></span><input class="edit-ipt-r" type="hidden" value="<%=documentSendFileWriteOrg%>" readonly /></td>
	                </tr>
	                <tr>
	                    <th>分发日期：</th>
	                    <td><input class="edit-ipt-r" type="text" value="<%=createdTime%>" readonly /></td>
	                </tr>
	                <tr>
	                    <th>公文标题：</th>
	                    <td><span class="fr" ><%=title%></span><input class="edit-ipt-r" type="hidden" value="<%=title%>" readonly /></td>
	                </tr>
	                <tr>
	                    <th>公文正文：</th>
	                    <td style="text-align:right;">
	                        <div class="wh-article-atta">
							<p>
								<%
								java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap("0");
								int smartInUse = 0;
								if(sysMap != null && sysMap.get("附件上传") != null){
									smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
								} 
								%>
								<i class="fa fa-paperclip"></i>
								<a href="javascript:void(0);" class="clickstyle" color="blue"
								onclick="clickSub('/defaultroot/evo/weixin/download/download.jsp?FileName=<%=goldGridId+wordType%>&name=正文<%=wordType%>&path=govdocumentmanager',this,'<%=goldGridId+wordType%>','govdocumentmanager','<%=smartInUse %>');">
									<strong class="atta-name">点击查看正文<%=wordType%></strong>
								</a>
							</p>
							</div>
	                    </td>
	                </tr>
	                <tr> 
	                    <th>公文附件：</th>
	                    <td>
	                    	<div class="wh-article-atta">
							<c:if test="${not empty accessoryName}">
								<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="${accessoryName}" />
									<jsp:param name="saveFileNames" value="${accessorySaveName}" />
									<jsp:param name="moduleName" value="govdocumentmanager" />
								</jsp:include>
							</c:if>
							</div>
	                    </td>
	                </tr>
	            </table>
	        </div>
	    </article>
	</section>
	<%}%>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>   
<script type="text/javascript">
<%if (workInfoObj == null || workInfoObj.length == 0)
{
	%>
		wx.ready(function(){
	 		alert('该收文已被撤回或删除！');
	 		wx.closeWindow();
 		});
	<%
}%>
</script>
