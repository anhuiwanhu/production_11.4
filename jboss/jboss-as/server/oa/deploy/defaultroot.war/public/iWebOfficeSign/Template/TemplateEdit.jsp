<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%
//String rootPath ="defaultroot";
String  moduleType=request.getParameter("moduleType")==null?"":request.getParameter("moduleType").toString();
  if(moduleType != null && moduleType.indexOf("<" )>= 0 ){
	return;
  }
  if(moduleType != null && moduleType.indexOf("'" )>= 0 ){
	return;
  }
  if(moduleType != null && moduleType.indexOf("\"" )>= 0 ){
	return;
  }
  if(moduleType != null && moduleType.indexOf("%" )>= 0 ){
	return;
  }
  if(moduleType != null && !moduleType.matches("[a-zA-Z_]+") ){
	return;
  }

%>
<%

  request.setCharacterEncoding("UTF-8");
  ResultSet result=null;
  String mDescript="";
  String mFileName="";

  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  //String mServerName="iWebOfficeSign/OfficeServer.jsp";
  String mServerName="officeserverservlet";
  String mClientName="iWebOfficeSign/iWebOffice2003.ocx#version=5,6,0,5";
  String schemeURL = request.getScheme();
  String prefixURL = "http://";
  if(null != request.getScheme() && "https".equalsIgnoreCase(request.getScheme())){
	prefixURL = "https://";
  }
  String mServerUrl=prefixURL+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;
  String mClientUrl=prefixURL+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mClientName;

 String iwebObjectUrl=prefixURL+request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+"iWebOfficeSign/iWebOffice2006.cab#version=9,0,0,2";


  String mRecordID=request.getParameter("RecordID");
  String mFileType=request.getParameter("FileType");
  String mEditType="1";
  String mUserName="Administrator";
  //whir add for templete range
  String useName="";
  String useId="";
  String canModifyEmpId="";
  String canModifyEmpName="";
  String c_userId=session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
  String c_orgId=session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();

 if(mFileType != null && mFileType.indexOf("'" )>= 0 ){
	return;
 }
 if(mFileType != null && mFileType.indexOf("<" )>= 0 ){
	return;
 }
 if(mFileType != null && mFileType.indexOf(">" )>= 0 ){
	return;
 }
 if(mFileType != null && mFileType.indexOf("%" )>= 0 ){
	return;
 }

  if(mFileType != null && !mFileType.matches("[a-zA-Z_.]+") ){
	return;
  }

  if(mRecordID != null && mRecordID.indexOf("<" )>= 0 ){
	return;
  }
  if(mRecordID != null && mRecordID.indexOf("'" )>= 0 ){
	return;
  }
  if(mRecordID != null && mRecordID.indexOf("\"" )>= 0 ){
	return;
  }
  if(mRecordID != null && mRecordID.indexOf("%" )>= 0 ){
	return;
  }
  if(mRecordID != null && !mRecordID.matches("[0-9a-zA-Z_.]+") ){
	return;
  }
  //取得模式
  if ( mEditType==null)
  {
    mEditType="2";		// 2 起草
  }
  //取得类型
  if ( mFileType==null)
  {
    mFileType=".doc";	// 默认为.doc文档
  }
  //取得用户名
  if (mUserName==null)
  {
    mUserName="金格科技";
  }

  //取得模板
  if ( mRecordID==null)
  {
    mRecordID="";	// 默认没有模板
  }

  //打开数据库
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();

  if (DbaObj.OpenConnection())
  {
    //String mSql="Select * From Template_File Where RecordID='"+ mRecordID + "'";
	String mSql="Select RecordID,FileName,FileType,Descript,useUserId,useName,canModifyEmpId,canModifyEmpName  From Template_File Where RecordID='"+ mRecordID + "'";
    try
    {
      result=DbaObj.ExecuteQuery(mSql);
      if (result.next())
      {
        mRecordID=result.getString("RecordID");
        mFileName=result.getString("FileName");
        mFileType=result.getString("FileType");
        mDescript=result.getString("Descript");
		//模版添加字段
		useId=result.getString("useUserId");
		useName=result.getString("useName");
		canModifyEmpId=result.getString("canModifyEmpId");
		canModifyEmpName=result.getString("canModifyEmpName");
		//System.out.println("*******************************"+useName);
      }
      else
      {
	//取得唯一值(mRecordID)
        java.util.Date dt=new java.util.Date();
        long lg=dt.getTime();
        Long ld=new Long(lg);
	//初始化值
        mRecordID=ld.toString();
       // mFileName="公文模版"+mFileType;
        mFileType=mFileType;
       //mDescript="发文公文模版";
      }
      result.close();
    }
    catch(Exception e)
    {
      System.out.println(e.toString());
    }
    DbaObj.CloseConnection() ;
  }

%>

<html>
<head>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
<title>模板管理</title>
<link rel='stylesheet' type='text/css' href='../test.css'>

<script language="JavaScript" src="../../../js/util/tool.js"></script>
<script src="../../../js/js.js" language="javascript"></script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
   if (vIndex==1){  //打开本地文件
      WebOpenLocal();
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==4){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();  //提交表单
   }
   if (vIndex==6){  //打印文档
      WebOpenPrint();
   }
</script>

<script language=javascript>

//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

//作用：载入iWebOffice
function Load(){
  try{
	webform.WebOffice.width="100%";
  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID="<%=mRecordID%>";   //RecordID:本文档记录编号
  webform.WebOffice.Template="<%=mRecordID%>";   //Template:模板编号
  webform.WebOffice.FileName="<%=mFileName%>";   //FileName:文档名称
  webform.WebOffice.FileType="<%=mFileType%>";   //FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="<%=mEditType%>";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  webform.WebOffice.UserName="dddddd";   //UserName:操作用户名<%//=mUserName%>

  //以下属性可以不要
  webform.WebOffice.ShowMenu="1";  //ShowMenu:1 显示菜单  0 隐藏菜单
  webform.WebOffice.AppendMenu("1","打开本地文件(&L)");
  webform.WebOffice.AppendMenu("2","保存本地文件(&S)");
  webform.WebOffice.AppendMenu("3","-");
  webform.WebOffice.AppendMenu("4","保存并退出(&E)");
  webform.WebOffice.AppendMenu("5","-");
  webform.WebOffice.AppendMenu("6","打印文档(&P)");
  webform.WebOffice.DisableMenu("宏;选项;帮助");  //禁止菜单
 
  webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
 webform.WebOffice.ShowType="1";
  //隐藏按钮
  webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
  webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
  webform.WebOffice.VisibleTools("保存文件",false);
  webform.WebOffice.VisibleTools("文字批注",false);
  webform.WebOffice.VisibleTools("手写批注",false);
  webform.WebOffice.VisibleTools("文档清稿",false);
  webform.WebOffice.VisibleTools("重新批注",false);
  webform.WebOffice.VisibleTools("全屏",false);

  StatusMsg(webform.WebOffice.Status);

  showPicture('TempHead');
  showPicture('TempSign');
  }catch(e){}
}


//显示上传
function showUpload(picType){
	document.all.selectPicTR.style.display="";
	document.all.picType.value = picType;
}

function hideUpload(){
	document.all.selectPicTR.style.display="none";
}
function   endWith(s1,s2)  
{  
      if(s1.length<s2.length)  
        return   false;  
      if(s1==s2)  
        return   true;  
      if(s1.substring(s1.length-s2.length)==s2)  
          return   true;  
      return   false;  
}

//作用：模板签章
function setSignature(){
  var picType = document.all.picType.value;
  try{
	//var path="C:\\Documents and Settings\\Samuel\\My Documents\\My Pictures\\362.jpg";
	var path=document.all.oFile1.value;
	if(path == null || path.length == 0){
		alert("名称不能为空！");
		return;
	}
	if( !(endWith(path,'.jpg') || endWith(path,'.gif') || endWith(path,'.png')|| endWith(path,'.bmp'))){
		alert("请选择图片文件！");
		return;
	}
	//alert(path);
	if(!webform.WebOffice.WebObject.Application || !webform.WebOffice.WebObject.Application.Selection || !webform.WebOffice.WebObject.Application.Selection.InlineShapes){
		alert("请选择插入位置！");
		return;
	}
	var p1 = webform.WebOffice.WebObject.Application.Selection.InlineShapes.AddPicture(path,false,true);
	
	if(p1 != null){
	var pp = p1.ConvertToShape();
	//var pp = webform.WebOffice.WebObject.Shapes.AddPicture(path,false,true);
		if(pp != null){
			pp.AlternativeText = picType;
	   		pp.ZOrder(5);
		}
	    hideUpload();
    }
  }catch(e){
    alert(e.description);
  }
  
}

//隐藏签章 picType='TempSign' 签章, picType='TempHead' 红头
function hidePicture(picType){
  var PicObj;
  // var count = webform.WebOffice.WebObject.InlineShapes.Count;	//嵌入式图片
  var count = webform.WebOffice.WebObject.Shapes.Count;		//沉浮式图片 
  try{
    for(var i=1;i < count+1;i++){
      if(webform.WebOffice.WebObject.Shapes(i).AlternativeText == picType){
        PicObj = webform.WebOffice.WebObject.Shapes(i);
		//隐藏
		PicObj.PictureFormat.IncrementBrightness(1);
      }    
    }
  }catch(e){
    alert(e.description);
  }
}

//显示签章 picType='TempSign' 签章, picType='TempHead' 红头
function showPicture(picType){
  var PicObj;
  // var count = webform.WebOffice.WebObject.InlineShapes.Count;	//嵌入式图片
  var count = webform.WebOffice.WebObject.Shapes.Count;		//沉浮式图片
  try{
    for(var i=1;i < count+1;i++){
      if(webform.WebOffice.WebObject.Shapes(i).AlternativeText == picType){
        PicObj = webform.WebOffice.WebObject.Shapes(i);
		//显示
		PicObj.PictureFormat.ColorType=1;
      }    
    }
  }catch(e){
    alert(e.description);
  }
}


//作用：退出iWebOffice
function UnLoad(){
  try{
 // if (!webform.WebOffice.WebClose()){
    // StatusMsg(webform.WebOffice.Status);
 // }else{
    // StatusMsg("关闭文档...");
//  }
  }catch(e){}
}


//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebLoadTemplate()){  //交互OfficeServer的OPTION="LOADTEMPLATE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}
function legalCharacters(o) {
	//参数'o'是页面上的一个对象，如'document.forms[0].code'
	//var cnst ="!\"#$%&'()=`|~{+*}<>?_-^\\@[;:],./";
	var cnst ="\\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/";
    for (i=0;i<o.value.length;i++){
       	if (cnst.indexOf(o.value.charAt(i))>-1){
			return true;
        }
    }
    return false;
}
//作用：保存文档
function SaveDocument(){

	if (document.all.FileName.value.Trim() == ""){
		alert("模板名称不能为空！");
		document.all.FileName.focus();
	    return (false);
	}else if(legalCharacters(document.all.FileName)){
		alert("模板名称不能包含以下字符 \\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/");
		document.all.FileName.focus();
		return false;
	}
	
	if (document.all.Descript.value.Trim() == ""){
		alert("模板说明不能为空！");
		document.all.Descript.focus();
	    return (false);
	}else if(legalCharacters(document.all.Descript)){
		alert("模板说明不能包含以下字符 \\\"#$%&'()=`|~{+*}<>?_-^\\@[]\.,;:!/");
		document.all.Descript.focus();
		return false;
	}
	
	
	
	//检查模板是否已经存在
	var result = $.ajax({
		  url: "TemplateJudgeName.jsp?moduleType=<%=moduleType%>&FileName="+encodeURIComponent
		 (document.all.FileName.value),
		  async: false}).responseText;
 	if(result !="-1" && result!="<%=mRecordID%>" ){
	    alert("模板已经存在!");
		document.all.FileName.focus();
		return false;
	}
	
	
	
	
	

	<%if(mFileType.equals(".doc")){%>
	try{
	   hidePicture('TempHead');
	   //hidePicture('TempSign');
	}catch(e){}
	try{
	  // hidePicture('TempHead');
	   hidePicture('TempSign');
	}catch(e){}
	<%}%>
		
  webform.WebOffice.WebClearMessage();            //清空iWebOffice变量
  <%if(mFileType.equals(".doc")){%>
  if (!webform.WebOffice.WebSaveBookMarks()){    //交互OfficeServer的OPTION="SAVEBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
     return false;
  }
  <%}%>
  //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSaveTemplate()时，一起提交到OfficeServer中
    webform.WebOffice.WebSetMsgByName("c_userId","<%=c_userId%>"); 
    webform.WebOffice.WebSetMsgByName("c_orgId","<%=c_orgId%>"); 
    webform.WebOffice.WebSetMsgByName("moduleType","<%=moduleType%>"); 

  if (!webform.WebOffice.WebSaveTemplate()){    //交互OfficeServer的OPTION="SAVETEMPLATE"
     StatusMsg(webform.WebOffice.Status);
     return false;
  }else{
     StatusMsg(webform.WebOffice.Status);
     return true;
  }
}

//作用：填充模板
function LoadBookmarks(){
  StatusMsg("正在填充模扳...");
  if (!webform.WebOffice.WebLoadBookmarks()){    //交互OfficeServer的OPTION="LOADBOOKMARKS"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：设置书签值  vbmName:标签名称，vbmValue:标签值   标签名称注意大小写
function SetBookmarks(vbmName,vbmValue){
  if (!webform.WebOffice.WebSetBookmarks(vbmName,vbmValue)){
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：根据标签名称获取标签值  vbmName:标签名称
function GetBookmarks(vbmName){
  var vbmValue;
  vbmValue=webform.WebOffice.WebGetBookmarks(vbmName);
  return vbmValue;
}

//作用：打印文档
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

String.prototype.Trim = function(){
	//return this.replace(/(^\s*)|(\s*$)/g, "");
   return   this.replace(/\s/g,   '');
}

//作用：页面设置
function WebOpenPageSetup(){
   try{
	if (webform.WebOffice.FileType==".doc"){
	  webform.WebOffice.WebObject.Application.Dialogs(178).Show();
	}
	if(webform.WebOffice.FileType==".xls"){
	  webform.WebOffice.WebObject.Application.Dialogs(7).Show();
	}
   }catch(e){

   }
}

//作用：标签管理
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebSetMsgByName("moduleType","<%=moduleType%>");   
    webform.WebOffice.WebOpenBookmarks();    //交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：存为本地文件
function WebSaveLocal(){
  try{
    webform.WebOffice.WebSaveLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：打开本地文件
function WebOpenLocal(){
  try{
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}
</script>
</head>
<SCRIPT language="javascript" src="<%=rootPath%>/js/openEndow.js"></SCRIPT>
<body bgcolor="#ffffff" onLoad="Load()" onUnload="UnLoad()" scroll="yes"  style="overflow:auto"> <!--引导和退出iWebOffice-->

<form name="webform" method="post" action="TemplateSave.jsp?moduleType=<%=moduleType%>" onSubmit="return SaveDocument();"> <!--保存iWebOffice后提交表单信息-->
<input type="hidden" name="RecordID" value="<%=mRecordID%>">

<table border=0  cellspacing='0' cellpadding='0' width=100% height=100% align=center class=TBStyle>
<tr id="selectPicTR" style="display:none">
  <td align="right" class="TDTitleStyle" width=64>红头签章</td>
  <td align="left" class="TDTitleStyle" colspan="2">
	<INPUT TYPE="file" NAME="oFile1" size="100">
	<input type="hidden" name="picType">
	<INPUT TYPE="button" VALUE="插入" onClick="setSignature();">
	<INPUT TYPE="button" VALUE="关闭" onClick="hideUpload();">
  </td>
</tr>

<tr>
  <td align="right" class="TDTitleStyle" width=64>模板名</td>
  <td class="TDStyle"><input type="text" name="FileName" value="<%=mFileName%>" class="IptStyle" maxLength="100" ></td>
</tr>

<tr>
  <td align=right class="TDTitleStyle" width=64>说明</td>
  <td class="TDStyle"><input type="text" name="Descript" value="<%=mDescript==null?"":mDescript%>" class="IptStyle" maxLength="100" ></td>
</tr>

<tr>
  <!--td align=right valign=top  class="TDTitleStyle" width=64>内容</td-->
  <td align=right valign=top  class="TDTitleStyle" width=64 height=800 >
                 <input type=button value="打印文档"  onclick="WebOpenPrint()">
                 <input type=button value="定义标签"  onclick="WebOpenBookMarks()">
                 <input type=button value="填充模板"  onclick="LoadBookmarks()">
                 <input type=button value="重调文档"  onclick="LoadDocument()">
                 <input type=button value="打开文件"  onclick="WebOpenLocal()">
                 <input type=button value="保存文件"  onclick="WebSaveLocal()">
				 <input type=button value="插入签章"  onclick="showUpload('TempSign')">
				 <input type=button value="插入红头"  onclick="showUpload('TempHead')">

  </td>

  <td class="TDStyle"  height=800>
        <table border=0 cellspacing='0' cellpadding='0' width='100%' height='100%' >
        <tr>
          <td bgcolor="menu">
            <!--调用iWebOffice，注意版本号，可用于升级-->
			<!--<script src="<%=rootPath%>/iWebOfficeSign/iWebOffice2006.js"></script>-->
            <!-- <OBJECT id="WebOffice" width="100%" height="100%" classid="clsid:23739A7E-5741-4D1C-88D5-D50B18F7C347" codebase="<%=mClientUrl%>" >
            </OBJECT> -->
			  <%@ include file="/public/iWebOfficeSign/iWebOfficeVersion.jsp"%>

          </td>
        </tr>
        <tr>
          <td bgcolor=menu height='20'>
		<div id=StatusBar>状态栏</div>
          </td>
        </tr>
        </table>
  </td>
</tr>
<tr> 
  <td align="right" class="TDTitleStyle" width=64>使用范围</td>
  <td class="TDStyle">
     <textarea  cols=60 rows=8 readonly=true name="useName" id="useName" ><%=(useName==null||useName.equalsIgnoreCase("null"))?"":useName%></textarea><!--<img src="<%=rootPath%>/images/group.gif">-->&nbsp;<img src="<%=rootPath%>/images/select.gif" style=cursor:hand  onclick="openSelect({allowId:'useId', allowName:'useName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',winModalDialog:'1'});"><input type="hidden" name="useId" id="useId" value="<%=(useId==null||useId.equalsIgnoreCase("null"))?"":useId%>">
  </td>
</tr>
<tr> 
  <td align="right" class="TDTitleStyle" width=64>可维护人</td>
  <td class="TDStyle">
     <textarea  cols=60 rows=8 readonly=true id="canModifyEmpName" name="canModifyEmpName" ><%=(canModifyEmpName==null||canModifyEmpName.equalsIgnoreCase("null"))?"":canModifyEmpName%></textarea><!--<img src="<%=rootPath%>/images/group.gif">-->&nbsp;<img src="<%=rootPath%>/images/select.gif" style=cursor:hand  onclick="openSelect({allowId:'canModifyEmpId', allowName:'canModifyEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',winModalDialog:'1'});"><input type="hidden" name="canModifyEmpId"  id="canModifyEmpId"  value="<%=(canModifyEmpId==null||canModifyEmpId.equalsIgnoreCase("null"))?"":canModifyEmpId%>">
  </td>
</tr>
</table>
<input type=submit value="  保存  ">
<input type=button value="  返回  " onClick="location_href('<%=rootPath%>/public/iWebOfficeSign/Template/TemplateList.jsp?haveRight=yes&moduleType=<%=moduleType%>')"><font size="36" style="font-size:18px">选择保存后，所做的操作才有效。</font>
</form>

</body>
</html>