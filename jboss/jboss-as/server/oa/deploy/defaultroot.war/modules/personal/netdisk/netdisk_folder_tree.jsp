<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.bd.usermanager.UserBD" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>  
	<title><s:text name="webdisk.MyDocuments"/></title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/tree.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
	<script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
	<link   href="<%=rootPath%>/scripts/plugins/form/form.css" rel="stylesheet" type="text/css"/>
	
	<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgdialog.js?skin=idialog" type="text/javascript"></script>
</head>
<%
String domainId = session.getAttribute("domainId")==null?"":session.getAttribute("domainId").toString();
String userId = session.getAttribute("userId").toString();

String title = request.getParameter("title")!=null?request.getParameter("title").toString():"";//标题
title = title.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
String channelIdForOther=request.getParameter("channelIdForCollection")==null?"":request.getParameter("channelIdForCollection");
channelIdForOther = channelIdForOther.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
String infoId=request.getParameter("infoId")==null?"":request.getParameter("infoId");
infoId = infoId.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
String fromModule=request.getParameter("fromModule")==null?"info":request.getParameter("fromModule");
fromModule = fromModule.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
String httpUrl=request.getParameter("httpUrl")==null?"":request.getParameter("httpUrl");
httpUrl = httpUrl.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
%>

<%!
private String genTree(String index, Map map){
	String rootPath = com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
    String result = "";
    if(map!=null && map.size()>0){
        Set _s = map.keySet();
        Iterator _itor = _s.iterator();
        int _j=0;
        while(_itor.hasNext()){
            String _key = (String)_itor.next();
            String fid = _key.substring(0,_key.indexOf("-"));
            String fname = _key.substring(_key.indexOf("-")+1,_key.length());
            result += "{ id:"+fid+", pId:"+index+", name:'"+fname+"', url:'', icon:''},"; 
            Map _value = (Map)map.get(_key);
            result += genTree(fid, _value);
        }
    }
    return result;
}
%>
<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
			<form id="form1" name="form1" action="<%=rootPath%>/netdisk!infoFolderSave.action" method="post">
		        <input  type="hidden"  name="httpUrl"           id="httpUrl"           value="<%=httpUrl%>"/>
		        <input  type="hidden"  name="title"             id="title"             value="<%=title%>"/>
		        <input  type="hidden"  name="fatherFolderId"    id="fatherFolderId"    value=""/>
				<input  type="hidden"  name="infoId"     id="infoId"     value="<%=infoId%>" > 
		        <input  type="hidden"  name="channelIdForOther" id="channelIdForOther" value="<%=channelIdForOther%>">
				<input  type="hidden"  name="fromModule"     id="fromModule"     value="<%=fromModule%>" > 

				<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" >
				<%
					int menuIndex=0;
					 UserBD ubd=new UserBD();
					 if(ubd.getNetDiskSize(request.getSession(true).getAttribute("userId").toString())!=0){
				             com.whir.ezoffice.netdisk.bd.NetdiskBD netdiskBD = new com.whir.ezoffice.netdisk.bd.NetdiskBD();
				             Map folderMap = netdiskBD.getFolderMapByUserId(userId);
				             System.out.println("folderMap.size:::"+folderMap.size());
				%>
				
				<tr id="submenuBox<%=menuIndex%>" valign="top" style="display:">
				      <td  >
				      		<ul id="treeMenu<%=menuIndex%>" class="ztree"></ul>     
				            <SCRIPT type="text/javascript">     
				                <!--     
				                var zNodes<%=menuIndex%> =[   
				                    { id:0, pId:-1, name:"<%=Resource.getValue(whir_locale,"personalwork","webdisk.MyDocuments")%>", url:"", icon:''},  
				                    	    <%
				                          	if(folderMap!=null && folderMap.size()>0){
			                                      Set _s = folderMap.keySet();
			                                      Iterator _itor = _s.iterator();
			                                      int _j = 0;
			                                      while(_itor.hasNext()){
			                                          String _key = (String)_itor.next();
			                                          System.out.println("_key:::"+_key);
			                                          String fid = _key.substring(0,_key.indexOf("-"));
			                                          String fname = _key.substring(_key.indexOf("-")+1,_key.length());
			                                          Map _value = (Map)folderMap.get(_key);
				                            %>
				                          			  { id:<%=fid%>, pId:0, name:"<%=fname%>", url:"", icon:''}, 
							                          <%
							                          	out.print(genTree(fid, _value));
							                          %>
				                          		<%}
				                            }%>   
				                ];   
				            
				                $(document).ready(function(){     
				                	whir_treeSetting.check = {enable: true,chkStyle: "radio",radioType: "all"};
				                	whir_treeSetting.view.showLine = true;
				                    $.fn.zTree.init($("#treeMenu<%=menuIndex%>"), whir_treeSetting, zNodes<%=menuIndex%>);   
				                    var treeObj = $.fn.zTree.getZTreeObj("treeMenu<%=menuIndex%>");  
				                    treeObj.expandAll(true);
				                });     
				                //-->     
				            </SCRIPT>     
	            
					    
					</td>
				  </tr>
				<%}%>
				
				
					<tr valign="bottom">
				    	<td>
				    		<div style="padding-left:5px;padding-bottom:5px;padding-top:10px;">
				                <input type="button" class="btnButton4font" onclick="saveandexit();"  value='<s:text name="comm.saveclose"/>' />  
	                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />  
	                        </div>
				        </td>
				  	</tr>
				
				</table>
			
     	</div>
    </div>
  </body>
</html>

<script type="text/javascript">
$(document).ready(function(){
	//init();
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'form1',"queryForm":'',"tip":'收藏'});
});


function init(){
    //$("#httpUrl").val($("#httpUrl",window.opener.document).val());//获得连接地址
}

function selectRadioValue(thisValue){
    $("#fatherFolderId").val(thisValue.value);
}

function saveandexit(){
	var treeObj = $.fn.zTree.getZTreeObj("treeMenu<%=menuIndex%>");
	var nodes = treeObj.getCheckedNodes(true);
	for(var i=0;i<nodes.length;i++){
		$("#fatherFolderId").val(nodes[i].id);
	}			
			
    var folderId = $("#fatherFolderId").val();
    if(folderId==""){
        whir_alert("<%=Resource.getValue(whir_locale,"personalwork","webdisk.Pleaseselectthefolder")%>");
        return;
    }
    //获得文件夹的全路径名称------2009-07-17---start
    var folderPath = Personalwork.webdisk_addtomydocuments;
    var folderPathStr = getFolderPathStr(folderId).replace(/\n|\r/g,"");
    var vMsgPath = "";
    if(folderPathStr.length==0){
        vMsgPath = folderPath+"。";
    }else{
        vMsgPath = folderPath+"-"+folderPathStr+"。";
    }
    //alert(vMsgPath);
    //获得文件夹的全路径名称------2009-07-17---end
    $("#form1").submit();
}

//获得文件夹的全路径名称,如：我的文档-新文件夹1-新文件夹11
function getFolderPathStr(vfolderId){
	var newData= ajaxForSync("<%=rootPath%>/modules/personal/netdisk/getFolderPathString.jsp?folderId="+vfolderId,"");
	return newData;
}

</SCRIPT>
