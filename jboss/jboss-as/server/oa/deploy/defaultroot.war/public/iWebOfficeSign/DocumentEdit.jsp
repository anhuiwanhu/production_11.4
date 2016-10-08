<%@ taglib uri="/WEB-INF/tag-lib/struts-tiles.tld" prefix="tiles" %><%@ taglib uri="/WEB-INF/tag-lib/struts-nested.tld" prefix="nested" %><%@ taglib uri="/WEB-INF/tag-lib/struts-logic.tld" prefix="logic" %><%@ taglib uri="/WEB-INF/tag-lib/struts-template.tld" prefix="template" %><%@ taglib uri="/WEB-INF/tag-lib/struts-bean.tld" prefix="bean" %><%@ taglib uri="/WEB-INF/tag-lib/struts-html.tld" prefix="html" %><%@ page import="java.util.*"%><%@ page import="com.whir.component.security.crypto.EncryptUtil"%><%@ page import="java.text.*"%><%
  String moduleType=request.getParameter("moduleType")==null?"default":EncryptUtil.htmlcode( request.getParameter("moduleType"));

	 String  rootPath=com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
	 if(!com.whir.common.util.CommonUtils.isForbiddenPad(request)){

		 if( request.getParameter("RecordID") != null && !"".equals( request.getParameter("RecordID") ) ){
			 //重定向到下载页面
			java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
			int smartInUse = 0;
			if(sysMap != null && sysMap.get("附件上传") != null){
				smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
			}
			com.whir.component.security.crypto.EncryptUtil util1 = new com.whir.component.security.crypto.EncryptUtil();
			String dlcode = util1.getSysEncoderKeyVlaue("FileName",
						request.getParameter("RecordID") + ".doc", "dir");
			String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
			//http://192.168.0.28:7001/defaultroot/public/download/download.jsp?verifyCode=F3FD4232C4FileName00&FileName=1405499690495.doc&name=1121.doc&path=govdocumentmanager
			String url = (smartInUse==1?"/defaultroot/public/download":fileServer)+"/download.jsp?verifyCode="+dlcode+"&FileName="+ request.getParameter("RecordID") +".doc&name="+ request.getParameter("RecordID") +".doc&path="+moduleType;
			//request.sendRedirect(url);
			response.sendRedirect(url);

		 }else{
	 		out.write("该页面不支持在PAD上显示，请于PC端查看。");
		 }
	 	return;
	 }
%>

<SCRIPT LANGUAGE="JavaScript">

var CommonJSResource = new Object();
CommonJSResource = {
	rootPath:"<%=rootPath%>"
}

</SCRIPT>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.text.*,java.util.*,java.sql.*,java.text.SimpleDateFormat,java.text.DateFormat,java.util.Date,javax.servlet.*,javax.servlet.http.*,DBstep.iDBManager2000.*" %>
<%!
  /**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */
  public String FormatDate(String DateValue,String DateType){
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;

  }

  public static boolean isNumeric(String str){ 
	  java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("[0-9]*"); 
	   return pattern.matcher(str).matches();    
  } 
%>
<%
		request.setCharacterEncoding("UTF-8");
		com.whir.ezoffice.information.infomanager.bd.NewInformationBD newInformationBD = new com.whir.ezoffice.information.infomanager.bd.NewInformationBD();
		List list = newInformationBD
				.getDataBySQL("select copyEnable,COPYENABLEVIEW from  gov_senddocumentbaseinfo ");
		String copyEnable = "0";
		String copyEnableView = "0";
		if (list != null && list.size() > 0) {
			Object[] obj = (Object[]) list.get(0);
			copyEnable = obj[0] == null ? "0" : obj[0].toString();
			copyEnableView = obj[1] == null ? "0" : obj[1].toString();
		}

%> 
<%
 
 // String rootPath = "defaultroot";
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
  ResultSet result=null;
  String mSubject=null;
  String mStatus=null;
  String mAuthor=null;
  String mFileName=null;
  String mFileDate=null;
  String mHTMLPath="";

  String mDisabled="";
  String mWord="";
  String mExcel="";

  String mUpdateSign="0";// 记录现在的状态 。是否有人正在打开 查看！ 0 ：没人  1： 有人。
  String mUpdateEidit="1"; // 1 表 有权 修改 ，
  String haveDocument="0"; //0: 没有！1


  //自动获取OfficeServer和OCX文件完整URL路径
  String mHttpUrlName=request.getRequestURI();
  String mScriptName=request.getServletPath();
  String mServerName="officeserverservlet";
  String mClientName="iWebOfficeSign/iWebOffice2003.ocx#version=5,7,0,0";
  String schemeURL = request.getScheme();
  String prefixURL = "http://";
  if(null != request.getScheme() && "https".equalsIgnoreCase(request.getScheme())){
	prefixURL = "https://";
  }
  String mServerUrl=prefixURL + request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mServerName;//取得OfficeServer文件的完整URL
  String mClientUrl=prefixURL + request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/"+mClientName;//取得OCX下载的完整URL
  String mHttpUrl=prefixURL + request.getServerName()+":"+request.getServerPort()+mHttpUrlName.substring(0,mHttpUrlName.lastIndexOf(mScriptName))+"/";

  String mRecordID=request.getParameter("RecordID");
  if(mRecordID!=null && !"".equals(mRecordID)){
	if( !isNumeric(mRecordID) ){
		return;
	}
  }
  String mTemplate=EncryptUtil.htmlcode( request.getParameter("Template") );
  String nowTemplate=mTemplate;// 下面 还会取摸板，此时 取的值 ，如果record 有值 会把 mTemplate 盖掉！
  String mFileType=EncryptUtil.htmlcode( request.getParameter("FileType") );
  String mEditType=EncryptUtil.htmlcode( request.getParameter("EditType") );
  String mUserName= request.getParameter("UserName") ;//EncryptUtil.htmlcode( request.getParameter("UserName") );

  //zhuo add 判断模块类型(信息管理,公文)
  String isSaveHtml=request.getParameter("saveHtml")==null?"0":EncryptUtil.htmlcode( request.getParameter("saveHtml"));//是否生成HTML文件
  String isSaveHtmlImage=request.getParameter("saveHtmlImage")==null?"0":EncryptUtil.htmlcode( request.getParameter("saveHtmlImage"));//是否生成HTML图片文件
  String isSaveDocFile=request.getParameter("saveDocFile")==null?"0":EncryptUtil.htmlcode( request.getParameter("saveDocFile"));//是否生成DOC文件
  String isLoadTemp=request.getParameter("loadTemp")==null?"0":EncryptUtil.htmlcode( request.getParameter("loadTemp"));//是否套用模板
  String tempModuleType=request.getParameter("tempModuleType")==null?moduleType:EncryptUtil.htmlcode( request.getParameter("tempModuleType"));//模板的类型

  //zhuo add 是否显示红头和签章
  //签章
  String showTempSign = request.getParameter("showTempSign")==null?"0":request.getParameter("showTempSign");
  //红头
  String showTempHead=request.getParameter("showTempHead")==null?"0":request.getParameter("showTempHead");

  String  isShowSign=request.getParameter("ShowSign")==null?"":request.getParameter("ShowSign");
  //显示痕迹按钮
  String showSignButton=request.getParameter("showSignButton")==null?"0":request.getParameter("showSignButton");
  //显示编辑按钮
  String showEditButton=request.getParameter("showEditButton")==null?"0":request.getParameter("showEditButton");
  //显示套打按钮
  String showCoverPrint=request.getParameter("showCoverPrint")==null?"1":request.getParameter("showCoverPrint");
  //显示转PDF按钮
  String showTransPDF=request.getParameter("showTransPDF")==null?"0":request.getParameter("showTransPDF");
  //1:起草正文 2：批阅正文 3：生成正式文件  0：查看正文
  String openWordType=request.getParameter("openWordType")==null?"0":request.getParameter("openWordType");
  // 默认不是第一次进; 当为是第一次进时， isFirstIn:1
  String isFirstIn="-1";
  // 是否 打印按扭
  String isPrintButton=request.getParameter("printButton")==null?"0":request.getParameter("printButton");
  //是否 重新加 模板  0不需要 ，1：需要
  String isReTem="0";

  //是否是查看历史痕迹版本
  String isViewOld=request.getParameter("isViewOld")==null?"0":request.getParameter("isViewOld");


  String _rowIndex=request.getParameter("_rowIndex")==null?"0":request.getParameter("_rowIndex");

  String copyType=request.getParameter("copyType")==null?"":request.getParameter("copyType");



  //取得编号
  if ( mRecordID==null||mRecordID.toString().equals("null")){
     mRecordID="";	//编号为空
  }

  //第一次， id 为空
  if(mRecordID==null||mRecordID.equals("")||mRecordID.equals("null")){
	isFirstIn="1";
  }

  //取得类型
  if ( mFileType==null || "".equals(mFileType)) {
    mFileType=".doc";	// 默认为.doc文档
  }
  //取得用户名
  if (mUserName==null){
    mUserName="万户网络";
  }

  //取得模板
  
  if ( mTemplate==null){
    mTemplate="";	// 默认没有模板
  }
  boolean  newRecordId=true;

  //打开数据库
  DBstep.iDBManager2000 DbaObj=new DBstep.iDBManager2000();
  if ( DbaObj.OpenConnection())
  {
    String mSql="Select * From Document Where RecordID='"+ mRecordID + "'";
    try
     {  
		if(!mRecordID.equals("")){
			  result=DbaObj.ExecuteQuery(mSql);
			  if (result.next()){
				mRecordID=result.getString("RecordID");
				mTemplate=result.getString("Template");
				mSubject=result.getString("Subject");
				mAuthor=result.getString("Author");
				mFileDate=result.getString("FileDate");
				mStatus=result.getString("Status");
				mFileType=result.getString("FileType");
				mHTMLPath=result.getString("HTMLPath");
				mUpdateSign=result.getString("updateSign");
				haveDocument="1";
                newRecordId=false;
			  }

			    result.close();
	      }
          //当RecordID 是空的时候 或是找不到 RecordID 的记录的时候 新建新的 RecordID
          if(newRecordId){
				//取得唯一值(mRecordID)
				java.util.Date dt=new java.util.Date();
				long lg=dt.getTime();
				Long ld=new Long(lg);
				//初始化值
				//int b = (int) (Math.random() * 10000);//降低编号重复概率，增加随机数
				mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
				mTemplate=mTemplate;
				mSubject="请输入主题";
				mAuthor=mUserName;
				mFileDate=DbaObj.GetDateTime();
				mStatus="DERF";
				mFileType=mFileType;
				mHTMLPath="";
		   }
 
      } catch(SQLException e) {
       System.out.println(e.toString());
     }
      DbaObj.CloseConnection() ;
    }
	
	//打开id  
   String  initmRecordID=mRecordID;

   //信息模块编辑正文使用字段
   String moditype=request.getParameter("moditype")==null?"0":EncryptUtil.htmlcode(request.getParameter("moditype"));//修改模块

   if(moditype.equals("info")){
	    java.util.Date dt=new java.util.Date();
			long lg=dt.getTime();
			Long ld=new Long(lg);
			//初始化值
			//int b = (int) (Math.random() * 10000);//降低编号重复概率，增加随机数
			mRecordID=ld.toString();//保存的是文档的编号，通过该编号，可以在里找到所有属于这条纪录的文档
   }

//System.out.println("======================"+mTemplate+"==========================="+nowTemplate);
	//如果现在 套进 摸板id,而原来的正文没摸板
	if(nowTemplate!=null&&!nowTemplate.equals("")&&!nowTemplate.equals("null")){ 

	  if(mTemplate==null||mTemplate.equals("")||mTemplate.equals("null")){
	     mTemplate=nowTemplate;	
	     isReTem="1";
	  }else{
	    if(!nowTemplate.equals(mTemplate)){
	      mTemplate=nowTemplate;	
	      isReTem="1";
	    }	
	   }
	}
if( "1".equals(request.getParameter("remakehead"))  ){
	isReTem="1";
}
//System.out.println("==========================isReTem============================" + isReTem);

 //isReTem = "1";    
	/*if ( mEditType.compareTo("0,0")==0){
		 mDisabled="disabled";
	 } else{
		 mDisabled="";
	 }*/

	 mDisabled="disabled";

     mFileName=mRecordID + mFileType;  //取得完整的文档名称

     if (mFileType.compareTo(".doc")==0){
		 mWord="";
		 mExcel="disabled";
	 } else{
		 mWord="disabled";
		 mExcel="";
	 }

boolean  b_fun_hide_sign=false; // 隐藏印章；
boolean  b_fun_show_sign=false; // 显示印章；
boolean  b_fun_hide_head=false; // 隐藏红头；
boolean  b_fun_show_head=false; // 显示红头；
boolean  b_fun_addTemplate=false;// 加载模板；
boolean  b_fun_loadBookmarks=false;// 套标签；慢


boolean  b_but_savedocument=false;//保存正文；
boolean  b_but_hide_show_head=false;//显示隐藏红头按钮；
boolean  b_but_importDoc=false;//引入文件
boolean  b_but_hide_show_trace=false;//显示隐藏痕迹；

boolean  b_but_taoda=false;  //套打
boolean  b_but_formalPrint=false;//正式打印
boolean  b_but_transPdf=false;//转pdf;
boolean  b_but_exportText=false;//导出text;


//当有编辑按钮时 ，可以有保存按钮
if("1".equals(showEditButton)){
   b_but_savedocument=true;
   //当有编辑按钮，并且是 word 或wps起草时
   if(".doc".equals(mFileType)||".wps".equals(mFileType)){
      b_but_hide_show_head=true;
     // b_but_importDoc=true;
   }
}

//显示隐藏痕迹按钮
if("1".equals(showSignButton)&&(".doc".equals(mFileType)||".wps".equals(mFileType))){
   b_but_hide_show_trace=true;
}

//打印
if("1".equals(showCoverPrint)&&!"information".equals(moduleType)){
   b_but_taoda=true;
   b_but_formalPrint=true;
}

//打印
if( "custom".equals(request.getParameter("fromModule"))  &&  "1".equals(showCoverPrint)   ){
   //b_but_taoda=true;
   b_but_formalPrint=true;
}

// 转pdf
if("1".equals(showTransPDF)){
  b_but_transPdf=true;  //产品里没有转 pdf 
 }

//显示隐藏印章
if("0".equals(showTempSign)&&(".doc".equals(mFileType)||".wps".equals(mFileType))){
  b_fun_hide_sign=true; 
}else if("1".equals(showTempSign)&&(".doc".equals(mFileType)||".wps".equals(mFileType))){
  b_fun_show_sign=true;
}

//显示隐藏红头
if("-1".equals(showTempHead)){

}else if("0".equals(showTempHead)&&(".doc".equals(mFileType)||".wps".equals(mFileType))){
  b_fun_hide_head=true;
}else if(".doc".equals(mFileType)||".wps".equals(mFileType)){
  b_fun_show_head=true;
}
 
// 如是打印正文进来的 因为 不能保存 ，所以 隐藏 印章后不会 保存下来
 if("1".equals(isPrintButton)){
   b_fun_hide_sign=true;
 }

//重新加摸板  
 if(isReTem.equals("1") || "1".equals(request.getParameter("retem"))  ){
   b_fun_addTemplate=true;
 }

 //自动填充摸板
 if(isLoadTemp.equals("1")){
   b_fun_loadBookmarks=true;
 }


 
/*	A  必须为“-1”
B  “1” 是否保护文档		 “0” 不保护文档， “1” 保护文档， “2” 特殊保护
C  “1” 是否显示痕迹		 “0” 不显示痕迹， “1” 显示痕迹
D  “1” 是否保留痕迹	 	 “0” 不保留痕迹， “1” 保留痕迹
E  “1” 是否打印痕迹	 	 “0” 不打印痕迹， “1” 打印痕迹
F  “1” 是否显示审阅工具  “0” 不显示工具， “1” 显示工具
G  “1” 是否允许拷贝操作  “0” 不允许拷贝， “1” 允许拷贝
H  “1” 是否允许手写批注  “0” 不可以批注， “1” 可以批注
如：需要不保护文档，有显示痕迹，有痕迹保留，不打印痕迹，不显示审阅工具，允许拷贝，允许手写批注操作，就可以设置为 WebOffice.EditType="-1,0,1,1,0,0,0,1";。
*/
		if( "1".equals(copyEnableView) && ! "".equals( request.getParameter("viewdoc") ) && request.getParameter("viewdoc") != null  ){
			  mEditType="1"; //EditType:编辑类型  方式一、方式二  <参考技术文档>
			
		}


  if(copyType.equals("1")){
     mEditType="4";
  }
  //取得模式
  if ( mEditType==null){
     // mEditType="1,1";// 0 显示  1 起草 2 批改 3 审核
	  mEditType="-1,0,0,1,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
  }else{
    if(mEditType.equals("0")){
	   
		if(isShowSign.equals("1")){
		   mEditType="-1,1,1,0,0,0,0,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		}else{
		   mEditType="-1,1,0,0,0,0,0,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		}
	}else if(mEditType.equals("1")){

		if(isShowSign.equals("1")){
		   mEditType="-1,0,1,1,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>


		}else{
		   mEditType="-1,0,0,1,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		}
		if(b_fun_addTemplate){
		   mEditType="-1,0,0,0,0,0,1,1";
		}
	

	}else if(mEditType.equals("4")){
	    mEditType="-1,2,0,0,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		b_but_formalPrint=true;
	}else if(mEditType.equals("5")){//起草发文时不保留痕迹
	    if(isShowSign.equals("1")){
		   mEditType="-1,0,1,0,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参Z考技术文档>
		}else{
		   mEditType="-1,0,0,0,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		}
	}else{
	  mEditType="-1,0,0,1,0,0,1,1";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
	} 
  }


  //System.out.println("mEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditTypemEditType"+mEditType);
%>

<html>
<head>
<title>iWebOfficeSign</title>
<link rel='stylesheet' type='text/css' href='test.css'>


<script src="/defaultroot/scripts/jquery-1.8.0.min.js" type="text/javascript"></script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
	//作用：套用模版定稿
function WebInsertFile(){
  var mDialogUrl = "Template/TemplateForm.jsp?tempModuleType=<%=tempModuleType%>";
  var mObject = new Object();
  mObject.Template = "";
  window.showModalDialog(mDialogUrl, mObject, "dialogHeight:200px; dialogWidth:360px;center:yes;scroll:no;status:no;");

  //判断用户是否选择模板
  if (mObject.Template==""){
    StatusMsg("取消套用模");
    return false;
  }else{
    SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');    //保存当前编辑的文档
    webform.WebOffice.WebSetMsgByName("COMMAND","INSERTFILE");   //设置变量COMMAND="INSERTFILE"，在WebLoadTemplate()时，一起提交到OfficeServer中     <参考技术文档>
    webform.WebOffice.Template=mObject.Template;       	//全局变量Template赋值，此示例读取服务器目录中模板，如读取数据库中模板，Template值为数据库中的模板编号，则上句代码不需要，如Template="1050560363767"，模板名称为“Word公文模板”，注：模板中有要标签Content，区分大小写，可以自行修改
    if (webform.WebOffice.WebLoadTemplate()){                    //交互OfficeServer的OPTION="LOADTEMPLATE"
       //SetBookmarks("Title","关于中间件研发工作会议通知");     //填充模板其它基本信息，如标题，主题词，文号，主送机关等
       if (webform.WebOffice.WebInsertFile()){                   //填充公文正文   交互OfficeServer的OPTION="INSERTFILE"
         StatusMsg(webform.WebOffice.Status);
       }else{
         StatusMsg(webform.WebOffice.Status);
       }
    }else{
       StatusMsg(webform.WebOffice.Status);
    }
  }
}



   if (vIndex==1){  //打开本地文件
  	  var file=WebOpenLocal2();
      if(file != ""){
	    webform.WebOffice.WebObject.Saved = false;
      }
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==3){  //保存到服务器上
   <%if("1".equals(request.getParameter("CanSave"))){%>
      SaveDocument();    //保存正文
   <%}%>
   }
   if (vIndex==5){  //签名印章
      WebOpenSignature();
   }
   if (vIndex==6){  //验证签章
      WebShowSignature();
   }
   if (vIndex==8){  //保存版本
      WebSaveVersion();
   }
   if (vIndex==9){  //打开版本
      WebOpenVersion();
   }
   if (vIndex==11){  //测试菜单一
     alert('菜单编号:'+vIndex+'\n\r'+'菜单条目:'+vCaption+'\n\r'+'请根据这些信息编写菜单具体功能');
   }
   if (vIndex==12){  //测试菜单二
     alert('菜单编号:'+vIndex+'\n\r'+'菜单条目:'+vCaption+'\n\r'+'请根据这些信息编写菜单具体功能');
   }
   if (vIndex==14){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();
   }
   if (vIndex==16){  //打印文档
      WebOpenPrint();
   }
   if (vIndex==17){  //套用模版
       WebInsertFile();
   }
   if (vIndex==18){  //填充模板
       LoadBookmarks();
   }
   //if (vIndex==17){  //显示痕迹
   //    ShowRevision(true);
   //}
   //if (vIndex==18){  //隐藏痕迹
   //    ShowRevision(false);
   //}
   if(vIndex==19){  //获取痕迹
       WebGetRevisions();
   }
   if(vIndex==20){  //解除锁定
       WebProtect(false);
   }


    if(vIndex==21){  //引入文章
      insertDoc();
   }
      if(vIndex==22){  //导出Text
      WebExportText();
   }

</script>

<script language=javascript>
/*
form表单名称:webform
iWebOffice名称:WebOffice
WebObject文档对象接口，相当于：
如果是Word  文件，WebObject 是Word  VBA的ActiveDocument对象
如果是Excel 文件，WebObject 是Excel VBA的ActiveSheet对象

如：webform.WebOffice.WebObject
*/


//作用：显示操作状态
function StatusMsg(mString){
  StatusBar.innerText=mString;
}

//加模板
function addTemplate(){

   
	//清除痕迹
	webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();

    SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');    //保存当前编辑的文档
    webform.WebOffice.WebSetMsgByName("COMMAND","INSERTFILE");   //设置变量COMMAND="INSERTFILE"，在WebLoadTemplate()时，一起提交到OfficeServer中     <参考技术文档>
    webform.WebOffice.Template="<%=mTemplate%>";    	//全局变量Template赋值，此示例读取服务器目录中模板，如读取数据库中模板，Template值为数据库中的模板编号，则上句代码不需要，如Template="1050560363767"，模板名称为“Word公文模板”，注：模板中有要标签Content，区分大小写，可以自行修改
    if (webform.WebOffice.WebLoadTemplate()){                    //交互OfficeServer的OPTION="LOADTEMPLATE"
       //SetBookmarks("Title","关于中间件研发工作会议通知");     //填充模板其它基本信息，如标题，主题词，文号，主送机关等
       if (webform.WebOffice.WebInsertFile()){                   //填充公文正文   交互OfficeServer的OPTION="INSERTFILE"
         StatusMsg(webform.WebOffice.Status);
       }else{
         StatusMsg(webform.WebOffice.Status);
       }
    }else{
       StatusMsg(webform.WebOffice.Status);
    }

}



//作用：载入iWebOffice
function Load(){

	/*
	
	A  必须为“-1”
B  “1” 是否保护文档		 “0” 不保护文档， “1” 保护文档， “2” 特殊保护
C  “1” 是否显示痕迹		 “0” 不显示痕迹， “1” 显示痕迹
D  “1” 是否保留痕迹	 	 “0” 不保留痕迹， “1” 保留痕迹
E  “1” 是否打印痕迹	 	 “0” 不打印痕迹， “1” 打印痕迹
F  “1” 是否显示审阅工具  “0” 不显示工具， “1” 显示工具
G  “1” 是否允许拷贝操作  “0” 不允许拷贝， “1” 允许拷贝
H  “1” 是否允许手写批注  “0” 不可以批注， “1” 可以批注
如：需要不保护文档，有显示痕迹，有痕迹保留，不打印痕迹，不显示审阅工具，允许拷贝，允许手写批注操作，就可以设置为 WebOffice.EditType="-1,0,1,1,0,0,0,1";。

	
	
	
	*/
<%
 if ( mTemplate==null){
    mTemplate="";	// 默认没有模板
  }
%>
  //以下属性必须设置，实始化iWebOffice
  webform.WebOffice.WebUrl="<%=mServerUrl%>";    //WebUrl:系统服务器路径，与服务器文件交互操作，如保存、打开文档，重要文件
  webform.WebOffice.RecordID="<%=initmRecordID%>";   //RecordID:本文档记录编号
  webform.WebOffice.Template="<%=mTemplate%>";   //Template:模板编号
  webform.WebOffice.FileName="<%=mFileName%>";   //FileName:文档名称
  webform.WebOffice.FileType="<%=mFileType%>";   //FileType:文档类型  .doc  .xls  .wps
  webform.WebOffice.EditType="<%=mEditType%>";   //EditType:编辑类型  方式一、方式二  <参考技术文档>

  <%
    if(newRecordId&&request.getParameter("initRecordId")!=null&&!request.getParameter("initRecordId").toString().equals("")){%>
         webform.WebOffice.RecordID="<%=request.getParameter("initRecordId")%>";   //RecordID:本文档记录编号
   <%}	  
  %>

   
  webform.WebOffice.UserName="<%=mUserName%>";   //UserName:操作用户名，痕迹保留需要

	<%if(local.equals("en_us")){%>
    webform.WebOffice.Language="EN";  
	<%}%>
    <%
    String wordlimitsize = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("wordlimitsize", (String)request.getSession().getAttribute("domainId"));
	if("".equals(wordlimitsize) || wordlimitsize == null){
	%>
		webform.WebOffice.MaxFileSize=15*1024;	//设置为15M
    <% 
	}else{
	%>
		//webform.WebOffice.MaxFileSize=15*1024;	//设置为15M
		 webform.WebOffice.MaxFileSize=<%=wordlimitsize%>*1024;	//设置为15M	
	<%
	}%>
   <%//isViewOld="0";
    if(isViewOld.equals("1")){%>
      webform.WebOffice.WebSetMsgByName("isViewOld","1");// 
   <%}else{%>
      webform.WebOffice.WebSetMsgByName("isViewOld","0");// 
  <%}%>

  //以下属性可以不要
  <%if("1".equals(showEditButton)){%>
	webform.WebOffice.ShowMenu="1";
  <%} else{%>
	webform.WebOffice.ShowMenu="0";
	WebToolsVisible('Standard',false);
	WebToolsVisible('Formatting',false);
  <%}%>  
  <%if("1".equals(isPrintButton)){%>
	  webform.WebOffice.ShowMenu="1";
	  WebToolsVisible('Standard',false);
	  WebToolsVisible('Formatting',false);		
  <%}%>
  <%if(!"1".equals(isPrintButton)){%>
  webform.WebOffice.AppendMenu("1","打开本地文件(&L)");
  webform.WebOffice.AppendMenu("2","保存本地文件(&S)");
  //webform.WebOffice.AppendMenu("3","保存远程文件(&U)");
  webform.WebOffice.AppendMenu("4","-");
  webform.WebOffice.AppendMenu("5","签名印章(&Q)");
  webform.WebOffice.AppendMenu("6","验证签章(&Y)");
  webform.WebOffice.AppendMenu("7","-");
  webform.WebOffice.AppendMenu("8","保存版本(&B)");
  webform.WebOffice.AppendMenu("9","打开版本(&D)");
  webform.WebOffice.AppendMenu("20","解除锁定");//解除锁定
  webform.WebOffice.AppendMenu("10","-");
  <%}%>
  webform.WebOffice.AppendMenu("16","打印文档(&P)");
  <%if(b_but_importDoc){%>
  webform.WebOffice.AppendMenu("21","引入文章");
  <%}%>
  webform.WebOffice.AppendMenu("22","导出Text");
  <%
	  if(!moduleType.equals("govdocument")){
   %>
    webform.WebOffice.AppendMenu("17","套用模版");
   <%}%>
  //webform.WebOffice.AppendMenu("18","填充模板");
  //webform.WebOffice.AppendMenu("19","获取痕迹");
  webform.WebOffice.DisableMenu("宏;选项;帮助");  //禁止菜单
  //增加按钮


 webform.WebOffice.AppendTools("100",'<bean:message bundle="information" key="info.ReturnSystem" />',7);

<%if(b_but_savedocument){%>
 webform.WebOffice.AppendTools("102",'<bean:message bundle="information" key="info.SaveDocumentEdit" />',2);
<%}%>

<%if(b_but_hide_show_head){%>
 webform.WebOffice.AppendTools("103","显示/隐藏红头",21);
<%}%>

<%if(b_but_importDoc){%>
 webform.WebOffice.AppendTools("101","引入文章",16);
<%}%>

<%if(b_but_hide_show_trace){%>
  webform.WebOffice.AppendTools("104","显示/隐藏痕迹",3);
<%}%>

<%if(b_but_taoda){%>
 webform.WebOffice.AppendTools("105","套打",4);
<%}%>
//"<%=mFileType%>";   //FileType:文档类型  .doc  .xls
<%if(b_but_formalPrint&&!mFileType.equals(".xls")&&!mFileType.equals(".xls")){%>
 webform.WebOffice.AppendTools("106","正式打印",5);
<%}%>

<%if(b_but_transPdf){%>
  webform.WebOffice.AppendTools("107","转换PDF",5);
<%}%>

 //webform.WebOffice.AppendTools("108","导出TEXT",5);

 //打开该文档    交互OfficeServer  调出文档OPTION="LOADFILE"    调出模板OPTION="LOADTEMPLATE"     <参考技术文档>
 webform.WebOffice.WebOpen();  

 webform.WebOffice.ShowType="1";
 webform.WebOffice.FileType="<%=mFileType%>";   //FileType:文档类型  .doc  .xls  .wps
 webform.WebOffice.RecordID="<%=mRecordID%>";   //RecordID:本文档记录编号

 //隐藏按钮
 webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
 webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
 webform.WebOffice.VisibleTools("保存文件",false);
 webform.WebOffice.VisibleTools("文字批注",false);
 webform.WebOffice.VisibleTools("手写批注",false);
 webform.WebOffice.VisibleTools("文档清稿",false);
 webform.WebOffice.VisibleTools("重新批注",false);


  //隐藏按钮
 webform.WebOffice.VisibleTools("New",false); //隐藏“新建文件”功能按钮
 webform.WebOffice.VisibleTools("Open",false); //隐藏“打开文件”功能按钮
 webform.WebOffice.VisibleTools("Save",false);
 webform.WebOffice.VisibleTools("Office",false);
 webform.WebOffice.VisibleTools("Handwrite",false);
 webform.WebOffice.VisibleTools("Comparison",false);
 webform.WebOffice.VisibleTools("Rewrite",false);



//重新加 模班  
<%if(b_fun_addTemplate){%>
    addTemplate();
	webform.WebOffice.WebObject.Saved = true;
<%}%>

//自动填充摸板
<%if(b_fun_loadBookmarks ){%>
  LoadBookmarks();
<%}%>

//隐藏印章
<%if(b_fun_hide_sign){%>
 hidePicture('TempSign');
<%}%>

//显示印章
<%if(b_fun_show_sign){%>
showPicture('TempSign');
<%}%>

//隐藏红头
<%if(b_fun_hide_head){%>
  hidePicture('TempHead');
<%}%>

//显示红头
<%if(b_fun_show_head){%>
  showPicture('TempHead');
<%}%>
	
//是否 隐藏痕迹
<%
if("1".equals(isViewOld)){
%>
showTrack();
<%
}
%>
<%if(b_fun_addTemplate){%>
webform.WebOffice.WebObject.Saved = false;
<%}%>

	  //以下属性可以不要
  <%if("1".equals(showEditButton)){%>
	webform.WebOffice.ShowMenu="1";
  <%} else{%>
	webform.WebOffice.ShowMenu="0";
	WebToolsVisible('Standard',false);
	WebToolsVisible('Formatting',false);
  <%}%> 
document.all.panel3.style.display="";
//$("*[name='panel3']").css("display","none");

webform.WebOffice.style.width='100%';
//WebOffice.style.height='100%';


if (window.addEventListener) { 
	//window.addEventListener('DOMContentLoaded', WebOffice, false); //firefox 
	//alert(3);
	//alert(webform.WebOffice.contentWindow);
	//webform.WebOffice.addEventListener('OnToolsClick',function(vIndex,vCaption){alert(1);} , false); 
	//alert(2);
//	WebOffice.toolsClick(1,"2");
} else if (window.attachEvent) { 
	//alert(1);
	//window.attachEvent("OnToolsClick", webform.WebOffice); //IE 
	//alert(2);
} 



}
function getViewSize(){return {w: window['innerWidth'] || document.documentElement.clientWidth,h: window['innerHeight'] || document.documentElement.clientHeight}}function getFullSize(){var w = Math.max(document.documentElement.clientWidth ,document.body.clientWidth) + Math.max(document.documentElement.scrollLeft, document.body.scrollLeft);var h = Math.max(document.documentElement.clientHeight,document.body.clientHeight) +  Math.max(document.documentElement.scrollTop, document.body.scrollTop);w = Math.max(document.documentElement.scrollWidth,w);h = Math.max(document.documentElement.scrollHeight,h);return {w:w,h:h};}

//-----编辑页面中调转换PDF文档的接口--------------------------------------------------//
function TestWebSavePDF(){
	try{
	if(webform.WebOffice.WebSavePDF()){
		if( opener.document.getElementsByName("documentWordType").length > 0){
			opener.document.getElementsByName("documentWordType")[0].value=".pdf";
		}
		alert("转换并保存成功");
		//opener.document.all.contentAccName.value = opener.document.all.documentSendFileTitle.value+".pdf";
		//opener.document.all.contentAccSaveName.value = webform.WebOffice.RecordID+".pdf";
		// window.opener.updateContent();//保存
	}
	else{
		alert("转换并保存失败");
	}
	}
	catch(e){
	alert("11:"+e.description); //出现异常时提示错误信息
	}
}



//隐藏签章 picType='TempSign' 签章, picType='TempHead' 红头
function hidePicture(picType){
  var PicObj;
  // var count = webform.WebOffice.WebObject.InlineShapes.Count;	//嵌入式图片
  if(webform.WebOffice.WebObject && webform.WebOffice.WebObject.Shapes){
	  var count = webform.WebOffice.WebObject.Shapes.Count;		//沉浮式图片 
	  try{
		for(var i=1;i < count+1;i++){
		  if(webform.WebOffice.WebObject.Shapes.Item(i).AlternativeText == picType){
		//	PicObj = webform.WebOffice.WebObject.Shapes(i);
			PicObj = webform.WebOffice.WebObject.Shapes.Item(i);
			//隐藏
			PicObj.PictureFormat.IncrementBrightness(1);
		  }    
		}
	  }catch(e){
		alert("12:"+e.description);
	  }
  }

}

//显示签章 picType='TempSign' 签章, picType='TempHead' 红头
function showPicture(picType){
  var PicObj;
  // var count = webform.WebOffice.WebObject.InlineShapes.Count;	//嵌入式图片
  if(webform.WebOffice.WebObject && webform.WebOffice.WebObject.Shapes){
	var count = webform.WebOffice.WebObject.Shapes.Count;		//沉浮式图片
	  try{
		for(var i=1;i < count+1;i++){
		  if(webform.WebOffice.WebObject.Shapes.Item(i).AlternativeText == picType){
			//PicObj = webform.WebOffice.WebObject.Shapes(i);

			PicObj = webform.WebOffice.WebObject.Shapes.Item(i);
			//显示
			PicObj.PictureFormat.ColorType=1;
		  }    
		}
	  }catch(e){
		alert("13:"+e.description);
	  }
  }
  
}

//切换显示签章
function alterPicture(picType){
  var PicObj;
  // var count = webform.WebOffice.WebObject.InlineShapes.Count;	//嵌入式图片
  var count = webform.WebOffice.WebObject.Shapes.Count;		//沉浮式图片
  try{
    for(var i=1;i < count+1;i++){
      if(webform.WebOffice.WebObject.Shapes.Item(i).AlternativeText == picType){
        //PicObj = webform.WebOffice.WebObject.Shapes(i);
		PicObj = webform.WebOffice.WebObject.Shapes.Item(i);
		//显示
		if(PicObj.PictureFormat.ColorType==1){
			PicObj.PictureFormat.IncrementBrightness(1);
		} else{
			PicObj.PictureFormat.ColorType=1;
		}
      }    
    }
  }catch(e){
    alert("14:"+e.description);
  }
}

//引入文档
function insertDoc(){
	//-----跳到书签位置----------
	//webform.WebOffice.WebObject.Application.Selection.GoTo(-1,0,0,"conent");//"conent"为标签名称
	var mFilePath = webform.WebOffice.WebOpenLocalDialog();
	if(mFilePath){
		webform.WebOffice.WebObject.Application.Selection.InsertFile(mFilePath);
	} 
}
var icountCloseVal = 0; 

window.onbeforeunload = function(event){

//if(window.confirm("点击“确定”按扭将保存文档。点击“取消”按扭放弃保存退出")){
if(!webform.WebOffice.WebObject.Saved){
	<%if("1".equals(showEditButton)){%>
			if(icountCloseVal==0){
			return "文档还没有保存,确定不保存退出吗?";
			}
	<%}%>
}
	webform.HaveSavePhysicalFile.value = 0;
	//清除痕迹，在ie8的环境中报错。没有对象,不知道为什么，先这么处理下, 在查看的情况下，此方法是无效的也要处理下
	if(webform.WebOffice.WebObject.Application.ActiveDocument && !(webform.WebOffice.WebObject.ProtectionType != -1)){
		webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();
	}
	savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');		
		webform.WebOffice.WebClose();
//}
return ;
	//return;
	event = event || window.event;	
	<%if(null !=request.getParameter("isWordWindowFirst") && "1".equals(request.getParameter("isWordWindowFirst"))){%>
   if(webform.WebOffice.WebObject.Content.Text.replace(/(^\s*)|(\s*$)/g,"")==''){
		alert('没有填写内容!');
		return;
	}else{
		try{
		if(!webform.WebOffice.WebObject.Saved){
			
			<%if("1".equals(showEditButton)){%>
					if(icountCloseVal==0){
						if(window.confirm("点击“确定”按扭将保存文档。点击“取消”按扭放弃保存退出")){
							if( SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>') ){
							
								//$("*[name='IsOut']").val("1");
								//$("*[name='webform']").submit();
								document.getElementsByName("IsOut")[0].value = "1";
								document.getElementsByName("webform")[0].submit();
								
								savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');				
							}
							//document.all.webform.IsOut.value="1";
							//document.all.webform.submit();
						}else{
						}
						//return "请在点击“确定”按扭前保存文档。点击“取消”按扭保存退出";
						//return null;
					}
				
			<%}%>
				
		}
	 }catch(e){}
	}
	<%}else if(null !=request.getParameter("Template") && !"".equals(request.getParameter("Template"))){%>
		try{
		if(!webform.WebOffice.WebObject.Saved){
			<%if("1".equals(showEditButton)){%>
					if(icountCloseVal==0){
					/*SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
					savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');				
					//$("*[name='IsOut']").val("1");
		  			//$("*[name='webform']").submit();
		  			document.getElementsByName("IsOut")[0].value = "1";
					document.getElementsByName("webform")[0].submit();
					//document.all.webform.IsOut.value="1";
					//document.all.webform.submit();
					return "请在点击“确定”按扭前保存文档。点击“取消”按扭保存退出";*/
						if(window.confirm("点击“确定”按扭将保存文档。点击“取消”按扭放弃保存退出")){
							if( SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>')){
								//$("*[name='IsOut']").val("1");
								document.getElementsByName("IsOut")[0].value = "1";
								document.getElementsByName("webform")[0].submit();

								savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');		
							}
		  					//$("*[name='webform']").submit();
							//document.all.webform.IsOut.value="1";
							//document.all.webform.submit();
						}else{
						}
						//return "请在点击“确定”按扭前保存文档。点击“取消”按扭保存退出";
						//return null;
				}
			<%}%>
				
		}
	 }catch(e){}
	<%}%>
webform.WebOffice.WebClose();
} 
//作用：退出iWebOffice
function UnLoad(){	
  /*document.all.ifrm.src = "<%=rootPath%>/iWebOfficeSign/DocumentIframe.jsp?haveDocument=<%=haveDocument%>&mUpdateEidit=<%=mUpdateEidit%>&mRecordID=<%=mRecordID%>";*/

  try{
  //alert(1);
	 // savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
  //if (!webform.WebOffice.WebClose()){
   //  StatusMsg(webform.WebOffice.Status);
  //}else{
     //StatusMsg("关闭文档...");
  //}
	<%if(isFirstIn.equals("1")){%>		
      if(opener.document.all.sendSectNum){//第一次新建时紫金用  
          window.opener.managerDueWord();
	      window.opener.updateGold();
	   }
	<%}%>
  }catch(e){}
}

//作用：打开文档
function LoadDocument(){
  StatusMsg("正在打开文档...");
  if (!webform.WebOffice.WebOpen()){  	//打开该文档    交互OfficeServer的OPTION="LOADFILE"
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}



//作用：保存文档（同时生成两份文档，一份为原WORD文档，一份为PGF全文批注文档，用于领导批注使用）
function SaveDocument(moduleType,isSaveHtmlImage,isSaveDocFile,isSaveHtml){
    webform.WebOffice.ShowType="1";
    webform.needPhysicalFile.value="1"; //需要保存物理文件
  
	//WebEnableCopy(true);


	//if( $("*[name='isChange']", window.opener.document) ){// 表 已经修改了
		//$("*[name='isChange']", window.opener.document).val("1");
		//opener.document.all.isChange.value="1";	
	//}

	//是否是加 模班 是的保存
	<%if(b_fun_addTemplate){%>
		webform.WebOffice.WebSetMsgByName("isaddTemplate","true");//是否保存为DOC文件--zhuo      
	<%}else{%>	
	   webform.WebOffice.WebSetMsgByName("isaddTemplate","false");//是否保存为DOC文件--zhuo  
	<%}%>


	if(".doc"==("<%=mFileType%>")||".wps"==("<%=mFileType%>")){
   //webform.WebOffice.WebSetMsgByName("MyDefine1","自定义变量值1");  //设置变量MyDefine1="自定义变量值1"，变量可以设置多个  在WebSave()时，一起提交到OfficeServer中

    //判断文档是否锁定，是则解锁保存
    if (webform.WebOffice.WebObject.ProtectionType != -1){
	  //alert("已经保护");
	  <%if(! "1".equals(copyEnable)){ %>
		webform.WebOffice.WebSetProtect(false,"");  //""表示密码为空,把文档设置为解锁
	  <%}%>
	}

	 webform.WebOffice.WebSetMsgByName("isDoc","false");//是否保存为DOC文件--zhuo


	try{
		//对wps做单独控制，可能不支持saveAs方法,wps也能创建.doc文档
		//if(!".wps"==("<%=mFileType%>")){
		//	webform.WebOffice.WebObject.SaveAs();
		// 	var FileSize1=webform.WebOffice.WebObject.BuiltInDocumentProperties(22);
		// 	webform.WebOffice.WebSetMsgByName("firstFilesize",FileSize1);
		//}else{
		//	webform.WebOffice.WebSetMsgByName("firstFilesize","undefined");
		//}
		if(webform.WebOffice.WebObject.Description && webform.WebOffice.WebObject.Description.indexOf("WPS") > -1){
			webform.WebOffice.WebSetMsgByName("firstFilesize",undefined);
		}else{
			webform.WebOffice.WebObject.SaveAs();
			var FileSize1=webform.WebOffice.WebObject.BuiltInDocumentProperties(22);
			webform.WebOffice.WebSetMsgByName("firstFilesize",FileSize1);
		}
		}catch(e){
			//alert(e);
		}

	  if (!webform.WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"

		 StatusMsg(webform.WebOffice.Status);
		 alert(webform.WebOffice.Status);
		 return false;
	  }else{
		 if (webform.WebOffice.FileType==".doc"||webform.WebOffice.FileType==".doc"){
		    //webform.WebOffice.WebSavePage();    //交互OfficeServer的OPTION="SAVPAGE"   生成全文批注PGF格式文档，存放服务器目录Document中，文件名RecordID+.pgf 如：3937725762429.pgf
		 }
		 //生成html图片
		 if(isSaveHtmlImage=='1'){
			webform.WebOffice.ExtParam=moduleType;//全局变量传递模块类型
			webform.WebOffice.WebSaveImage();
			StatusMsg(webform.WebOffice.Status);
		 }
		//生成html
		 if(isSaveHtml=='1'){
			webform.WebOffice.WebSaveAsHtml(); 	//交互OfficeServer的OPTION="SAVEASHTML" 
		 }
		 try{
			 if(parent.opener.document.getElementsByName("content")[0].value==""){
				parent.opener.document.getElementsByName("content")[0].value="<%=mRecordID%>";
			 }
		 }catch(e){
		 }
		 //恢复修改状态
		 webform.WebOffice.WebObject.Saved = true;
		 return true;
	  }
	}else if(".xls"==("<%=mFileType%>")){
            webform.WebOffice.WebSetMsgByName("isDoc","false");//是否保存为DOC文件
            if (!webform.WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
                StatusMsg(webform.WebOffice.Status);
                return false;
            }else{

			 //生成html
			 if(isSaveHtml=='1'){
				webform.WebOffice.WebSaveAsHtml(); 	//交互OfficeServer的OPTION="SAVEASHTML" 
			 }
                //恢复修改状态
		    webform.WebOffice.WebObject.Saved = true;
            return true;
            }
	}else if(".ppt"==("<%=mFileType%>")){
	       webform.WebOffice.WebSetMsgByName("isDoc","false");//是否保存为DOC文件
            if (!webform.WebOffice.WebSave()){    //交互OfficeServer的OPTION="SAVEFILE"
                StatusMsg(webform.WebOffice.Status);
                return false;
            }else{

			 //生成html
			 if(isSaveHtml=='1'){
				//webform.WebOffice.WebSaveAsHtml(); 	//交互OfficeServer的OPTION="SAVEASHTML" 
			 }
                 //恢复修改状态
		     webform.WebOffice.WebObject.Saved = true;
             return true;
            }
	}
	return false;
}

//保存物理文件
//分开写 保证打开后 在最后关闭控件时 才保存物理文件  ，防止把 清了痕迹的文保存到数据里
function  savePhysicalFile(moduleType,isSaveHtmlImage,isSaveDocFile,isSaveHtml){

	  if(webform.needPhysicalFile.value=="0"){//不需要保存物理文件
	     return false; 
	  }

      if(webform.HaveSavePhysicalFile.value=="1"){//已经保存过物理文件不再保存
	   return false;
	  }

	  webform.HaveSavePhysicalFile.value="1";// 标明已经保存过物理文件

	if(".doc"==("<%=mFileType%>")||".wps"==("<%=mFileType%>")){

		 if(isSaveDocFile=='1'){
			//传递模块类型
			 webform.WebOffice.WebSetMsgByName("moduleType",moduleType);//信息管理:information 公文管理:govdocument
			 //在服务器上生成word文件
			 // webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();//zhuo

			 if(moduleType=='govdocument'){
				   <%if( ! "1".equals(copyEnable)){ %>
				webform.WebOffice.WebSetProtect(true,"");  //""表示密码为空--zhuo
				   <%}%>
			 }
			 webform.WebOffice.WebSetMsgByName("isDoc","true");//是否保存为DOC文件--zhuo
			 //webform.WebOffice.WebSetMsgByName("docSavePath","//upload//govdocumentmanager");//doc文件保存路径
			 webform.WebOffice.WebSave(true);
			 StatusMsg(webform.WebOffice.Status);
			 webform.WebOffice.WebSetProtect(false,"");  //""表示密码为空,把文档设置为解锁
		 }
		 //恢复修改状态
		 webform.WebOffice.WebObject.Saved = true;
		 return true;
	 
	}else if(".xls"==("<%=mFileType%>")){   
			if(isSaveDocFile=='1'){
				//传递模块类型
				 webform.WebOffice.WebSetMsgByName("moduleType",moduleType);//信息管理:information 公文管理:govdocument
				 //在服务器上生成word文件
				 //webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();//zhuo
				// webform.WebOffice.WebSetProtect(true,"");  //""表示密码为空--zhuo
				 webform.WebOffice.WebSetMsgByName("isDoc","true");//是否保存为DOC文件--zhuo
				 //webform.WebOffice.WebSetMsgByName("docSavePath","//upload//govdocumentmanager");//doc文件保存路径
				 webform.WebOffice.WebSave(true);
				 StatusMsg(webform.WebOffice.Status);
			 }
		  //恢复修改状态
		 webform.WebOffice.WebObject.Saved = true;
         return true;
	}else if(".ppt"==("<%=mFileType%>")){   
			if(isSaveDocFile=='1'){
				//传递模块类型
				 webform.WebOffice.WebSetMsgByName("moduleType",moduleType);//信息管理:information 公文管理:govdocument
				 //在服务器上生成word文件
				 //webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();//zhuo
				// webform.WebOffice.WebSetProtect(true,"");  //""表示密码为空--zhuo
				 webform.WebOffice.WebSetMsgByName("isDoc","true");//是否保存为DOC文件--zhuo
				 //webform.WebOffice.WebSetMsgByName("docSavePath","//upload//govdocumentmanager");//doc文件保存路径
				 webform.WebOffice.WebSave(true);
				 StatusMsg(webform.WebOffice.Status);
			 }
		  //恢复修改状态
		 webform.WebOffice.WebObject.Saved = true;
         return true;
	}


}

//作用：显示或隐藏痕迹  true表示隐藏痕迹  false表示显示痕迹
function ShowRevision(mValue){
  //判断文档是否锁定
  if (webform.WebOffice.WebObject.ProtectionType != -1){
	  alert("该文档已经被锁定！");
	}
  else{
	  if (mValue){
		 webform.WebOffice.WebShow(true);
		 StatusMsg("显示痕迹...");
	  }else{
		 webform.WebOffice.WebShow(false);
		 StatusMsg("隐藏痕迹...");
	  }
  }
}


//作用：获取痕迹
function WebGetRevisions(){
  var i;
  var Text="";
  for (i = 1;i <= webform.WebOffice.WebObject.Revisions.Count;i++){
    Text=Text + webform.WebOffice.WebObject.Revisions.Item(i).Author;
    if (webform.WebOffice.WebObject.Revisions.Item(i).Type=="1"){
    Text=Text + '插入:'+webform.WebOffice.WebObject.Revisions.Item(i).Range.Text+"\r\n";
    }else{
    Text=Text + '删除:'+webform.WebOffice.WebObject.Revisions.Item(i).Range.Text+"\r\n";
    }
  }
  alert("痕迹内容：\r\n"+Text);
}

//作用：刷新文档
function WebReFresh(){
  webform.WebOffice.WebReFresh();
  StatusMsg("文档已刷新...");
}

//作用：打开版本
function WebOpenVersion(){
  webform.WebOffice.WebOpenVersion();  	//交互OfficeServer  列出版本OPTION="LISTVERSION"     调出版本OPTION="LOADVERSION"   <参考技术文档>
  StatusMsg(webform.WebOffice.Status);
}

//作用：保存版本
function WebSaveVersion(){
  webform.WebOffice.WebSaveVersion();  	//交互OfficeServer的OPTION="SAVEVERSION"
  StatusMsg(webform.WebOffice.Status);

}

//作用：保存当前版本
function WebSaveVersionByFileID(){
  var mText=window.prompt("请输入版本说明:","版本号:V");
  if (mText==null){
     mText="已修改版本.";
  }
  webform.WebOffice.WebSaveVersionByFileID(mText);  	//交互OfficeServer的OPTION="SAVEVERSION"  同时带FileID值   <参考技术文档>
  StatusMsg(webform.WebOffice.Status);
}


//作用：填充模板
function LoadBookmarks(){
  StatusMsg("正在填充模扳...");

    <%if(request.getParameter("textContent") != null && !"-1".equals(request.getParameter("textContent"))){%>
      webform.WebOffice.WebSetBookMarks("Content","<%=request.getParameter("textContent").replaceAll("\r\n","\\\\r\\\\n")%>");
  <%}%>

  <%
	Enumeration e = (Enumeration)request.getParameterNames(); 
    while(e.hasMoreElements()){
    String parName=(String)e.nextElement();
	if(parName.startsWith("$")){
		if(request.getParameter(parName) != null && !"-1".equals(request.getParameter(parName))){
		  String bookMarkAll = request.getParameter(parName);
		  if(!(bookMarkAll.indexOf("[") !=-1 && bookMarkAll.indexOf("]") !=-1)){
		  	continue;
		  }
		  String bookMarkName = bookMarkAll.substring(bookMarkAll.indexOf("[")+1,bookMarkAll.indexOf("]"));
		  String bookMarkValue = bookMarkAll.substring(bookMarkAll.indexOf("]")+1,bookMarkAll.length());
		  String  v1 = bookMarkValue.replaceAll("\r\n","\\\\r\\\\n");//.replaceAll("\\\\","\\\\\\\\");
		  v1 = v1.replaceAll("\"","\\\\\"");
		  %>
			webform.WebOffice.WebSetBookMarks("<%=bookMarkName%>","<%=v1%>");
		  <%
			//System.out.println("PPPPPPPPPPPPPPPP::::"+bookMarkName+":::::::::"+v1 );	
		  %>
		  <%
		}
	  }
  }
  %>
	

//套红头
  <%if(request.getParameter("wordId") != null && !"-1".equals(request.getParameter("wordId"))&&!"".equals(request.getParameter("wordId"))){
      com.whir.govezoffice.documentmanager.bd.SenddocumentBD senddocumentBD = new com.whir.govezoffice.documentmanager.bd.SenddocumentBD();

      //根据机关代字 id取  机关代字
      com.whir.govezoffice.documentmanager.po.SendDocumentWordPO  po= senddocumentBD.loadSendDocumentWordPO(request.getParameter("wordId"));

      %>
      webform.WebOffice.WebSetBookMarks("红头","");

      <%
	  //取机关代字对应的红头 
      if( ( po.getRedHeadSaveName()!= null &&!po.getRedHeadSaveName().toString().equals(""))){
      %>
      webform.WebOffice.WebInsertImage("红头","<%=po.getRedHeadSaveName()%>",true,4);//套红
      <%
      }
  }

%>



//  if (!webform.WebOffice.WebLoadBookmarks()){  	//交互OfficeServer的OPTION="LOADBOOKMARKS"
//     StatusMsg(webform.WebOffice.Status);
//  }else{
//     StatusMsg(webform.WebOffice.Status);
//  }
}



//作用：标签管理
function WebOpenBookMarks(){
  try{
    webform.WebOffice.WebOpenBookmarks();  	//交互OfficeServer的OPTION="LISTBOOKMARKS"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
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

//作用：套打印文档
function WebOpenPrintOfCover(){
  try{
	 // var SignStatus = isShowPicture('TempSign');
	  var HeadStatus = isShowPicture('TempHead');
	//hidePicture('TempSign');
	hidePicture('TempHead');
    webform.WebOffice.WebOpenPrint();
	if(SignStatus){
	//showPicture('TempSign');
	}
	if(HeadStatus){
	showPicture('TempHead');
	}
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：正式打印文档
function WebOpenPrintOfFormal(){
  try{
	  var SignStatus = isShowPicture('TempSign');
	//hidePicture('TempSign');
    webform.WebOffice.WebOpenPrint();
	if(SignStatus){
	//showPicture('TempSign');
	}
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}


//判断红头和印张显示状态
function isShowPicture(picType){
  var PicObj;
  // var count = webform.WebOffice.WebObject.InlineShapes.Count;	//嵌入式图片
  var count = webform.WebOffice.WebObject.Shapes.Count;		//沉浮式图片
  try{
    for(var i=1;i < count+1;i++){
      if(webform.WebOffice.WebObject.Shapes.Item(i).AlternativeText == picType){
		  //PicObj = webform.WebOffice.WebObject.Shapes(i);
		  PicObj = webform.WebOffice.WebObject.Shapes.Item(i);
        if(PicObj.PictureFormat.ColorType==1){
			return true;
		} else{
			return false;
		}
      }    
    }
  }catch(e){
    alert("15:"+e.description);
  }
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
   }catch(e){}
}

//作用：插入图片
function WebOpenPicture(){
  try{
    webform.WebOffice.WebOpenPicture();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：签名印章
function WebOpenSignature(){
  alert("如果你要签章,建议采用iSignature电子签章软件进行签章:\r\n下载地址http://www.goldgrid.com/iSignature/Download.asp\r\n该软件是支持CA证书和数字签名技术的,\r\n是通过了国家公安部认证的电子签章产品!");
  try{
    webform.WebOffice.WebOpenSignature();  	//交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：验证印章A
function WebShowSignature(){
  try{
    webform.WebOffice.WebShowSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：验证印章B
function WebCheckSignature(){
  try{
    var i=webform.WebOffice.WebCheckSignature();  	//交互OfficeServer的OPTION="LOADSIGNATURE"
    alert("检测结果："+i+"\r\n 注释: (=-1 有非法印章) (=0 没有任何印章) (>=1 有多个合法印章)");
    StatusMsg(i);
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
	webform.WebOffice.FileType = "<%=mFileType%>";
    StatusMsg(webform.WebOffice.Status);
  
  }catch(e){}
}


//作用：打开本地文件
function WebOpenLocal2(){
  try{

	//webform.WebOffice.FileType = ".*";
    webform.WebOffice.WebOpenLocal();
    StatusMsg(webform.WebOffice.Status);
	webform.WebOffice.FileType = "<%=mFileType%>";
	
  }catch(e){}
}


//作用：保存为HTML文档
function WebSaveAsHtml(){
  try{
    if (webform.WebOffice.WebSaveAsHtml())  	//交互OfficeServer的OPTION="SAVEASHTML"
    {
      webform.HTMLPath.value="HTML/<%=mRecordID%>.htm";
      //window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}


//作用：保存为文档图片
function WebSaveAsPage(){
  try{
    if (webform.WebOffice.WebSaveImage())  	//交互OfficeServer的OPTION="SAVEIMAGE"
    {
      webform.HTMLPath.value="HTMLIMAGE/<%=mRecordID%>.htm";
      //window.open("<%=mHttpUrl%>"+ webform.HTMLPath.value);
    }
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}


//作用：关闭或显示工具 参数1表示工具条名称  参数2为false时，表示关闭  （名称均可查找VBA帮助）
//参数2为true时，表示显示
function WebToolsVisible(ToolName,Visible){
  try{
    webform.WebOffice.WebToolsVisible(ToolName,Visible);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}


//作用：禁止或启用工具 参数1表示工具条名称  参数2表示工具条铵钮的编号  （名称和编号均可查找VBA帮助）
//参数3为false时，表示禁止  参数3为true时，表示启用
function WebToolsEnable(ToolName,ToolIndex,Enable){
  try{
    webform.WebOffice.WebToolsEnable(ToolName,ToolIndex,Enable);
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//作用：保护与解除  参数1为true表示保护文档  false表示解除保护
function WebProtect(value){
  try{
    webform.WebOffice.WebSetProtect(value,"");  //""表示密码为空
  }catch(e){}
}

//作用：允许与禁止拷贝功能  参数1为true表示允许拷贝  false表示禁止拷贝
function WebEnableCopy(value){
  try{
    webform.WebOffice.CopyType=value;
  }catch(e){}
}


//作用：插入远程服务器图片
function WebInsertImage(){
  try{
    webform.WebOffice.WebInsertImage('Image','GoldgridLogo.jpg',true,4);   //交互OfficeServer的OPTION="INSERTIMAGE"  参数1表示标签名称  参数2表示图片文件名  参数3为true透明  false表示不透明  参数4为4表示浮于文字上方  5表示衬于文字下方
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}


//作用：下载服务器文件到本地
function WebGetFile(){
  if (webform.WebOffice.WebGetFile("c:\\WebGetFile.doc","DownLoad.doc")){   //交互OfficeServer的OPTION="GETFILE"  参数1表示本地路径  参数2表示服务器文件名称
    StatusMsg(webform.WebOffice.Status);
  }else{
    StatusMsg(webform.WebOffice.Status);
  }
  alert(webform.WebOffice.Status+"\r\n"+"文件放在c:\\WebGetFile.doc");
}


//作用：上传本地文件到服务器
function WebPutFile(){
  var mLocalFile=webform.WebOffice.WebOpenLocalDialog();
  if (mLocalFile!=""){
    alert(mLocalFile);
    if (webform.WebOffice.WebPutFile(mLocalFile,"Test.doc")){   //交互OfficeServer的OPTION="PUTFILE"  参数1表示本地路径，可以任何格式文件  参数2表示服务器文件名称
      StatusMsg(webform.WebOffice.Status);
    }else{
      StatusMsg(webform.WebOffice.Status);
    }
    alert(webform.WebOffice.Status);
  }
}


//作用：打开远程文件
function WebDownLoadFile(){
  mResult=webform.WebOffice.WebDownLoadFile("http://www.goldgrid.com/Images/abc.doc","c:\\abc.doc");
  if (mResult){
    webform.WebOffice.WebOpenLocalFile("c:\\abc.doc");
    alert("成功");
  }else{
    alert("失败");
  }
}

//作用：表格生成及填充
function WebSetWordTable(){
  var mText="",mName="",iColumns,iCells,iTable;
  //设置COMMAND为WORDTABLE
  webform.WebOffice.WebSetMsgByName("COMMAND","WORDTABLE");   //设置变量COMMAND="WORDTABLE"，在WebSendMessage()时，一起提交到OfficeServer中
  //发送到服务器上
  //如果没有错误
  if (webform.WebOffice.WebSendMessage()){                //交互OfficeServer的OPTION="SENDMESSAGE"
	iColumns = webform.WebOffice.WebGetMsgByName("COLUMNS");  //取得列
	iCells = webform.WebOffice.WebGetMsgByName("CELLS");      //取得行
	iTable=webform.WebOffice.WebObject.Tables.Add(webform.WebOffice.WebObject.Application.Selection.Range,iCells,iColumns);   //生成表格
	for (var i=1; i<=iColumns; i++)
	{
   	  for (var j=1; j<=iCells; j++)
	  {
		mName=i.toString()+j.toString();
		mText=webform.WebOffice.WebGetMsgByName(mName);	 //取得OfficeServer中的表格内容
		iTable.Columns(i).Cells(j).Range.Text=mText;   	//填充单元值
	   }
	}
   }
   StatusMsg(webform.WebOffice.Status);
}


//作用：获取文档Txt正文
function WebGetWordContent(){
  try{
    alert(webform.WebOffice.WebObject.Content.Text);
  }catch(e){}
}

//作用：写Word内容
function WebSetWordContent(){
  var mText=window.prompt("请输入内容:","测试内容");
  if (mText==null){
     return (false);
  }
  else
  {
     //下面为显示选中的文本
     //alert(webform.WebOffice.WebObject.Application.Selection.Range.Text);
     //下面为在当前光标出插入文本
     webform.WebOffice.WebObject.Application.Selection.Range.Text= mText+"\n";
     //下面为在第一段后插入文本
     //webform.WebOffice.WebObject.Application.ActiveDocument.Range(1).Text=(mText);
  }
}


//作用：打印黑白文档
function WebWordPrintBlackAndWhile(){
   var i,n;

   //图片变黑白
   i=0;
   n=webform.WebOffice.WebObject.Shapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.Shapes.Item(i).PictureFormat.ColorType=3;
   }
   i=0;
   n=webform.WebOffice.WebObject.InlineShapes.Count;
   for (var i=1; i<=n; i++)
   {
      webform.WebOffice.WebObject.InlineShapes.Item(i).PictureFormat.ColorType=3;
   }

   //文字变黑白
   webform.WebOffice.WebObject.Application.Selection.WholeStory();
   webform.WebOffice.WebObject.Application.Selection.Range.Font.Color = 0;
}

//作用：用Excel求和
function WebGetExcelContent(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "126";
    webform.WebOffice.WebObject.Application.Range("C6").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "446";
    webform.WebOffice.WebObject.Application.Range("C7").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "556";
    webform.WebOffice.WebObject.Application.Range("C5:C8").Select;
    webform.WebOffice.WebObject.Application.Range("C8").Activate;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "=SUM(R[-3]C:R[-1]C)";
    webform.WebOffice.WebObject.Application.Range("D8").Select;
    alert(webform.WebOffice.WebObject.Application.Range("C8").Text);
}


//作用：保护工作表单元
function WebSheetsLock(){
    webform.WebOffice.WebObject.Application.Sheets(1).Select;

    webform.WebOffice.WebObject.Application.Range("A1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "产品";
    webform.WebOffice.WebObject.Application.Range("B1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "价格";
    webform.WebOffice.WebObject.Application.Range("C1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "详细说明";
    webform.WebOffice.WebObject.Application.Range("D1").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "库存";
    webform.WebOffice.WebObject.Application.Range("A2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "书签";
    webform.WebOffice.WebObject.Application.Range("A3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "毛笔";
    webform.WebOffice.WebObject.Application.Range("A4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "钢笔";
    webform.WebOffice.WebObject.Application.Range("A5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "尺子";

    webform.WebOffice.WebObject.Application.Range("B2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "0.5";
    webform.WebOffice.WebObject.Application.Range("C2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "樱花";
    webform.WebOffice.WebObject.Application.Range("D2").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "300";

    webform.WebOffice.WebObject.Application.Range("B3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "2";
    webform.WebOffice.WebObject.Application.Range("C3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "狼毫";
    webform.WebOffice.WebObject.Application.Range("D3").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "50";

    webform.WebOffice.WebObject.Application.Range("B4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "3";
    webform.WebOffice.WebObject.Application.Range("C4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "蓝色";
    webform.WebOffice.WebObject.Application.Range("D4").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "90";

    webform.WebOffice.WebObject.Application.Range("B5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "1";
    webform.WebOffice.WebObject.Application.Range("C5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "20cm";
    webform.WebOffice.WebObject.Application.Range("D5").Select;
    webform.WebOffice.WebObject.Application.ActiveCell.FormulaR1C1 = "40";

    //保护工作表
    webform.WebOffice.WebObject.Application.Range("B2:D5").Select;
    webform.WebOffice.WebObject.Application.Selection.Locked = false;
    webform.WebOffice.WebObject.Application.Selection.FormulaHidden = false;
    webform.WebOffice.WebObject.Application.ActiveSheet.Protect(true,true,true);

    alert("已经保护工作表，只有B2-D5单元格可以修改。");
}

//作用：VBA套红
function WebInsertVBA(){

	//画线
	var object=webform.WebOffice.WebObject;
	var myl=object.Shapes.AddLine(100,60,305,60)
	myl.Line.ForeColor=255;
	myl.Line.Weight=2;
	var myl1=object.Shapes.AddLine(326,60,520,60)
	myl1.Line.ForeColor=255;
	myl1.Line.Weight=2;

	//object.Shapes.AddLine(200,200,450,200).Line.ForeColor=6;
   	var myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();

	var mtext="★";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
   	var myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
   	myRange.ParagraphFormat.LineSpacingRule =1.5;
   	myRange.font.ColorIndex=6;
   	myRange.ParagraphFormat.Alignment=1;
   	myRange=webform.WebOffice.WebObject.Range(0,0);
	myRange.Select();
	mtext="金格发[２００３]１５４号";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;
	myRange.ParagraphFormat.Alignment=1;
	myRange.font.ColorIndex=1;

	mtext="金格电子政务文件";
	webform.WebOffice.WebObject.Application.Selection.Range.InsertAfter (mtext+"\n");
	myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	myRange.ParagraphFormat.LineSpacingRule =1.5;

	//myRange.Select();
	myRange.Font.ColorIndex=6;
	myRange.Font.Name="仿宋_GB2312";
	myRange.font.Bold=true;
	myRange.Font.Size=50;
	myRange.ParagraphFormat.Alignment=1;

	//myRange=myRange=webform.WebOffice.WebObject.Paragraphs(1).Range;
	webform.WebOffice.WebObject.PageSetup.LeftMargin=70;
	webform.WebOffice.WebObject.PageSetup.RightMargin=70;
	webform.WebOffice.WebObject.PageSetup.TopMargin=70;
	webform.WebOffice.WebObject.PageSetup.BottomMargin=70;
}



//作用：保存定稿文件
function WebUpdateFile(){
  if (webform.WebOffice.WebUpdateFile()){                //交互OfficeServer的OPTION="UPDATEFILE"，类似WebSave()或WebSaveVersion()方法
     StatusMsg(webform.WebOffice.Status);
  }else{
     StatusMsg(webform.WebOffice.Status);
  }
}

//作用：导入Text
function WebInportText(){
    var mText;
    webform.WebOffice.WebSetMsgByName("COMMAND","INPORTTEXT");  //设置变量COMMAND="INPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    if (webform.WebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
      mText=webform.WebOffice.WebGetMsgByName("CONTENT");       //取得OfficeServer传递的变量CONTENT值
      webform.WebOffice.WebObject.Application.Selection.Range.Text=mText;
      alert("导入文本成功");
    }
    StatusMsg(webform.WebOffice.Status);
}



//作用：导出Text
function WebExportText(){
    var mText=webform.WebOffice.WebObject.Content.Text;
    webform.WebOffice.WebSetMsgByName("COMMAND","EXPORTTEXT");  //设置变量COMMAND="EXPORTTEXT"，在WebSendMessage()时，一起提交到OfficeServer中
    webform.WebOffice.WebSetMsgByName("CONTENT",mText);         //设置变量CONTENT="mText"，在WebSendMessage()时，一起提交到OfficeServer中，可用于实现全文检索功能，对WORD的TEXT内容进行检索
    if (webform.WebOffice.WebSendMessage()){                    //交互OfficeServer的OPTION="SENDMESSAGE"
        //alert("导出文本成功");
	    //  window.open("<%=rootPath%>/download.jsp?FileName=<%=mRecordID%>.txt&name=<%=mRecordID%>.txt&path=govdocumentmanager", "send", 'menubar=0,scrollbars=0,locations=0,width=500,height=400,resizable=no,location=no,status=no');    
	   // window.location.href= '<%=rootPath%>/download.jsp?FileName=<%=mRecordID%>.txt&name=<%=mRecordID%>.txt&path=govdocumentmanager';
	   // document.all.dd.href='<%=rootPath%>/download.jsp?FileName=<%=mRecordID%>.txt&name=<%=mRecordID%>.txt&path=govdocumentmanager';
       //document.all.dd.click();
        webform.WebOffice.FileName="<%=mRecordID%>.txt";
	    var gg=webform.WebOffice.WebSaveLocalDialog();
		  webform.WebOffice.FileName="<%=mFileName%>";   //FileName:文档名称
		if (webform.WebOffice.WebGetFile(gg,"<%=mRecordID%>.txt")){   //交互OfficeServer的OPTION="GETFILE"  参数1表示本地路径  参数2表示服务器文件名称
		StatusMsg(webform.WebOffice.Status);
		}else{
		StatusMsg(webform.WebOffice.Status);
		}
	    //document.getElementById("dd").click();
	   //document.all.dd.click();
	  }
   // StatusMsg(webform.WebOffice.Status);
}

//作用：获取文档页数
function WebDocumentPageCount(){
    if (webform.WebOffice.FileType==".doc"){
	var intPageTotal;
	intPageTotal = webform.WebOffice.WebObject.Application.ActiveDocument.BuiltInDocumentProperties(14);
	alert("文档页总数："+intPageTotal);
    }
    if (webform.WebOffice.FileType==".wps"){
	var intPageTotal;
	intPageTotal = webform.WebOffice.WebObject.PagesCount();
	alert("文档页总数："+intPageTotal);
    }
}

//作用：签章锁定文件功能
function WebSignatureAtReadonly(){
  webform.WebOffice.WebSetProtect(false,"");                  //解除文档保护
  webform.WebOffice.WebSetRevision(false,false,false,false);  //设置文档痕迹保留的状态  参数1:不显示痕迹  参数2:不保留痕迹  参数3:不打印时有痕迹  参数4:不显痕迹处理工具
  try{
    webform.WebOffice.WebOpenSignature();                     //交互OfficeServer的 A签章列表OPTION="LOADMARKLIST"    B签章调出OPTION="LOADMARKIMAGE"    C确定签章OPTION="SAVESIGNATURE"    <参考技术文档>    文档中要定义标签Manager，可以自行修改标签名称
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
  webform.WebOffice.WebSetProtect(true,"");                   //锁定文档

}


var click = 0;
//是否显示痕迹
function showTrack(){
	if(click%2==0){
		<%if("0".equals(mEditType)){%>
			webform.WebOffice.EditType="-1,1,1,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		<%}else if("1".equals(mEditType)){%>
			webform.WebOffice.EditType="-1,0,1,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		<%}else if(mEditType.length() > 1){
			String str = mEditType.split(",")[1];
			if("1".equals(str)){%>
				webform.WebOffice.EditType="-1,1,1,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			<%}else{%>
				webform.WebOffice.EditType="-1,0,1,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			<%}%>
		<%}%>
		//webform.WebOffice.WebSetRevision(true,true,false,true); 
	} else{
		<%if("0".equals(mEditType)){%>
			webform.WebOffice.EditType="-1,1,0,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		<%}else if("1".equals(mEditType)){%>
			webform.WebOffice.EditType="-1,0,0,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
		<%}else if(mEditType.length() > 1){
			String str = mEditType.split(",")[1];
			if("1".equals(str)){%>
				webform.WebOffice.EditType="-1,1,0,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			<%}else{%>
				webform.WebOffice.EditType="-1,0,0,1,0,0,1,0";   //EditType:编辑类型  方式一、方式二  <参考技术文档>
			<%}%>
		<%}%>
		//webform.WebOffice.WebSetRevision(false,true,false,true); 
		
	}
	click ++;
}

self.moveTo(0,0);
self.resizeTo(screen.availWidth,screen.availHeight);



function OnMenuClick(vIndex,vCaption){


   if (vIndex==1){  //打开本地文件
  	  var file=WebOpenLocal2();
      if(file != ""){
	    webform.WebOffice.WebObject.Saved = false;
      }
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==3){  //保存到服务器上
   <%if("1".equals(request.getParameter("CanSave"))){%>
      SaveDocument();    //保存正文
   <%}%>
   }
   if (vIndex==5){  //签名印章
      WebOpenSignature();
   }
   if (vIndex==6){  //验证签章
      WebShowSignature();
   }
   if (vIndex==8){  //保存版本
      WebSaveVersion();
   }
   if (vIndex==9){  //打开版本
      WebOpenVersion();
   }
   if (vIndex==11){  //测试菜单一
     alert('菜单编号:'+vIndex+'\n\r'+'菜单条目:'+vCaption+'\n\r'+'请根据这些信息编写菜单具体功能');
   }
   if (vIndex==12){  //测试菜单二
     alert('菜单编号:'+vIndex+'\n\r'+'菜单条目:'+vCaption+'\n\r'+'请根据这些信息编写菜单具体功能');
   }
   if (vIndex==14){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();
   }
   if (vIndex==16){  //打印文档
      WebOpenPrint();
   }
   if (vIndex==17){  //套用模版
       WebInsertFile();
   }
   if (vIndex==18){  //填充模板
       LoadBookmarks();
   }
   //if (vIndex==17){  //显示痕迹
   //    ShowRevision(true);
   //}
   //if (vIndex==18){  //隐藏痕迹
   //    ShowRevision(false);
   //}
   if(vIndex==19){  //获取痕迹
       WebGetRevisions();
   }
   if(vIndex==20){  //解除锁定
       WebProtect(false);
   }


    if(vIndex==21){  //引入文章
      insertDoc();
   }
      if(vIndex==22){  //导出Text
      WebExportText();
   }


}


function OnToolsClick(vIndex,vCaption){
    setTimeout("OnToolsClick_REAL(" + vIndex +",'" + vCaption+"');",10);
}

function OnToolsClick_REAL(vIndex,vCaption){
if (vIndex==100){

try{
	if(!webform.WebOffice.WebObject.Saved){
		<%if("1".equals(showEditButton)){%>
			
			if(confirm("是否保存对文档的修改？")){
				icountCloseVal++;
				if(!SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>')){
					return;
				}
				savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');

				//判断是否保存成功


				//document.all.webform.IsOut.value="1";
				//document.all.webform.submit();
				//alert(1);
				$("*[name='IsOut']").val("1");
				//alert(2);
		  		$("*[name='webform']").submit();
		  		//	alert(3);
			} else {
				icountCloseVal++;
				//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
				window.close();
			}
		<%} else{%>
			//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
			window.close();
		<%}%>
	} else{
			//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
		    window.close();
	}
 }catch(e){
		if(confirm("是否保存对文档的修改？")){
			icountCloseVal++;
			if(!SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>')){
				return;
			}
		 
			$("*[name='IsOut']").val("1");
			$("*[name='webform']").submit();
			savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
		 // document.all.webform.submit();
		} else {
			icountCloseVal++;
			//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
			window.close();
		}

 }
}

if (vIndex==101){insertDoc();}
if (vIndex==102){

   if( SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>')){
	   document.getElementById("webform").submit(); 
	   savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
	   alert('保存成功！');
   }
  
 // webform.WebOffice.WebOpen(); 
}
if (vIndex==103){alterPicture('TempHead');}
if (vIndex==104){showTrack();}
if (vIndex==105){WebOpenPrintOfCover();}
if (vIndex==106){WebOpenPrintOfFormal();}

	if(vIndex==-1&&vCaption=='全屏'){
	document.all.panel3.style.display="";
 
	}
	if (vIndex==-1 && vCaption=='返回'){
	webform.WebOffice.WebObject.Saved = true;
	//document.all.panel3.style.display="none";
	 $("*[name='panel3']").css("display","none");
	}

//if (vIndex==11){alert('编号:'+vIndex+'\n\r'+'标题:'+vCaption+'\n\r'+'请根据这些信息编写具体功能'+'\n\r\n\r'+'窗口状态:'+webform.WebOffice.WindowStatus);} 
//if (vIndex==12){webform.WebOffice.Alert('自定义工具栏测试');}  
//if (vIndex==-1){webform.WebOffice.Alert(vCaption);}             //在完成相应操作后响应iWebOffice标准工具栏操作铵钮事件，如"手写批注",vCaption="手写批注"

if (vIndex==107){TestWebSavePDF();}
if (vIndex==108){WebExportText();}
if(vIndex==-1){
  	  //以下属性可以不要
  <%if("1".equals(showEditButton)){%>
	webform.WebOffice.ShowMenu="1";
  <%} else{%>
	webform.WebOffice.ShowMenu="0";
	WebToolsVisible('Standard',false);
	WebToolsVisible('Formatting',false);
  <%}%> 
}

	
	
}


</script>



<script language=javascript for=WebOffice event=OnToolsClick(vIndex,vCaption)>

if (vIndex==100){

try{
	if(!webform.WebOffice.WebObject.Saved){
		<%if("1".equals(showEditButton)){%>
			
			if(confirm("是否保存对文档的修改？")){
				icountCloseVal++;
				if(!SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>')){
					return;
				};
				
				$("*[name='IsOut']").val("1");
		  		$("*[name='webform']").submit();
				savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
				//document.all.webform.IsOut.value="1";
				//document.all.webform.submit();
			} else {
				icountCloseVal++;
				//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
				window.close();
			}
		<%} else{%>
			//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
			window.close();
		<%}%>
	} else{
			//savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
		    window.close();
	}
 }catch(e){
		if(confirm("是否保存对文档的修改？")){
			icountCloseVal++;
		  SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
		 
		  $("*[name='IsOut']").val("1");
		  $("*[name='webform']").submit();

		   savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
		  //document.all.webform.IsOut.value="1";
		  //document.all.webform.submit();
		} else {
			icountCloseVal++;
		  //savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');
		  window.close();
		}

 }
}

if (vIndex==101){insertDoc();}
if (vIndex==102){if(SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>')){
	  
	document.all.webform.submit();
	
	 savePhysicalFile('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');

	alert('保存成功！');
	
	
	}
 // webform.WebOffice.WebOpen(); 
}
if (vIndex==103){alterPicture('TempHead');}
if (vIndex==104){showTrack();}
if (vIndex==105){WebOpenPrintOfCover();}
if (vIndex==106){WebOpenPrintOfFormal();}

	if(vIndex==-1&&vCaption=='全屏'){
	document.all.panel3.style.display="";

	}
	if (vIndex==-1 && vCaption=='返回'){
	webform.WebOffice.WebObject.Saved = true;
	document.all.panel3.style.display="none";
	}

//if (vIndex==11){alert('编号:'+vIndex+'\n\r'+'标题:'+vCaption+'\n\r'+'请根据这些信息编写具体功能'+'\n\r\n\r'+'窗口状态:'+webform.WebOffice.WindowStatus);} 
//if (vIndex==12){webform.WebOffice.Alert('自定义工具栏测试');}  
//if (vIndex==-1){webform.WebOffice.Alert(vCaption);}             //在完成相应操作后响应iWebOffice标准工具栏操作铵钮事件，如"手写批注",vCaption="手写批注"

if (vIndex==107){TestWebSavePDF();}
if (vIndex==108){WebExportText();}
if(vIndex==-1){
  	  //以下属性可以不要
  <%if("1".equals(showEditButton)){%>
	webform.WebOffice.ShowMenu="1";
  <%} else{%>
	webform.WebOffice.ShowMenu="0";
	WebToolsVisible('Standard',false);
	WebToolsVisible('Formatting',false);
  <%}%> 
}

</script>

</head>
<script language="javascript">
function showSign(){
    <%
    String ShowSign = request.getParameter("ShowSign")==null?"0":request.getParameter("ShowSign");
	if(!ShowSign.equals("-1") && !mFileType.equals(".xls")){//判断是不是在已批文件的锁定状态，是锁定则不控制痕迹
		if(ShowSign.equals("1")){%>
		//ShowRevision(true);
		webform.WebOffice.WebSetRevision(true,true,false,true); 
		<%}else if(!mEditType.equals("0")){%>
		//ShowRevision(false);
		webform.WebOffice.WebSetRevision(false,true,false,true); 
		//webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();
		<%
		 }
	}
	%>
    if(opener.document.all.htmlContent){
        document.all.htmlContent.value = opener.document.all.htmlContent.value;
    }
	 //加载时保存修改状态
     webform.WebOffice.WebObject.Saved = true;
}
</script>
<body bgcolor="#ffffff" onLoad="Load();WebEnableCopy(true);" onUnload="UnLoad()">  <!--引导和退出iWebOffice-->

	<iframe id="targetFrame" name="targetFrame" style="display:none"></iframe>
  <form name="webform" id="webform" method="post" action="DocumentSave.jsp?field=<%=request.getParameter("field")%>&_rowIndex=<%=_rowIndex%>" onSubmit="return SaveDocument('<%=moduleType%>','<%=isSaveHtmlImage%>','<%=isSaveDocFile%>','<%=isSaveHtml%>');" target="targetFrame">  <!--保存iWebOffice后提交表单信息-->
    <input type="hidden" name="RecordID" value="<%=mRecordID%>">
    <input type="hidden" name="Template" value="<%=mTemplate%>">
    <input type="hidden" name="FileType" value="<%=mFileType%>">
    <input type="hidden" name="EditType" value="<%=mEditType%>">
    <input type="hidden" name="HTMLPath" value="<%=mHTMLPath%>">
    <input type="hidden" name="IsOut"   value="0">
	<input type="hidden" name="HaveSavePhysicalFile"   value="0"><!--当不等于0时表明保存过一次 物理文件 --->
	<input type="hidden" name="needPhysicalFile" value="0"><!--- 当调用过SaveDocument 就应保存物理文件（变为1 ，表需要保存物理文件）---->
    <table border=0  cellspacing='0' cellpadding='0' width="100%" height="100%" align="center" class="TBStyle">
      <tr>
        <!--td align=right valign=top  class="TDTitleStyle" width=64>内容</td-->
        <td align=right valign=top style="display:none" class="TDTitleStyle" width="79" hegith="100%">
	   <b>HTML按钮</b><br><font color="red"><b>功能列表</b></font>
           <input type=button class=button value="显示痕迹" <%=mDisabled%> onClick="ShowRevision(true)">
           <input type=button class=button value="隐藏痕迹" <%=mDisabled%> onClick="ShowRevision(false)">
           <input type=button class=button value="获取痕迹" <%=mDisabled%> onClick="WebGetRevisions()">
           <input type=button class=button value="清除痕迹" <%=mDisabled%> onClick="webform.WebOffice.WebObject.Application.ActiveDocument.AcceptAllRevisions();">
           <input type=button class=button value="保护文档" onClick="WebProtect(true)">
           <input type=button class=button value="解除保护" onClick="WebProtect(false)">
           <input type=button class=button value="允许拷贝" onClick="WebEnableCopy(true)">
           <input type=button class=button value="禁止拷贝" onClick="WebEnableCopy(false)">
           <input type=button class=button value="页面设置" <%=mDisabled%> onClick="WebOpenPageSetup()">
           <input type=button class=button value="打印文档" <%=mDisabled%> onClick="WebOpenPrint()">
           <input type=button class=button value="插入图片" <%=mDisabled%> onClick="WebOpenPicture()">
           <input type=button class=button value="重调文档" <%=mDisabled%> onClick="LoadDocument()">
           <input type=button class=button value="打开本地文件" <%=mDisabled%> onClick="WebOpenLocal()">
           <input type=button class=button value="存为本地文件" <%=mDisabled%> onClick="WebSaveLocal()">
		<font color="red"><b>与服务器交互</b></font>
           <input type=button class=button value="签名印章" <%=mDisabled%> onClick="WebOpenSignature()">
           <input type=button class=button value="验证签章[A]" <%=mDisabled%>  onclick="WebShowSignature()">
           <input type=button class=button value="验证签章[B]" <%=mDisabled%>  onclick="WebCheckSignature()">
           <input type=button class=button value="打开标签" <%=mDisabled%>  <%=mWord%>  onclick="WebOpenBookMarks()">
           <input type=button class=button value="填充模版" <%=mDisabled%>  <%=mWord%>  onclick="LoadBookmarks()">
           <input type=button class=button value="保存版本" <%=mDisabled%>  onclick="WebSaveVersion()">
           <input type=button class=button value="打开版本" <%=mDisabled%>  onclick="WebOpenVersion()">
           <input type=button class=button value="保存当前版本" <%=mDisabled%>  onclick="WebSaveVersionByFileID()">
           <input type=button class=button value="保存定稿版本" <%=mDisabled%>  onclick="WebUpdateFile()">
           <input type=button class=button value="存为HTML" <%=mDisabled%>  onclick="WebSaveAsHtml()">
           <input type=button class=button value="存为HTML图片" <%=mDisabled%>  <%=mWord%>  onclick="WebSaveAsPage()">
           <input type=button class=button value="套用模版定稿" <%=mDisabled%>  <%=mWord%> onClick="WebInsertFile()">
           <input type=button class=button value="VBA套红定稿" <%=mDisabled%>  <%=mWord%>  onclick="WebInsertVBA();">
           <input type=button class=button value="导入数据内容" <%=mDisabled%>  <%=mWord%>  onclick="WebInportText();">
           <input type=button class=button value="导出文档内容" <%=mDisabled%>  <%=mWord%>  onclick="WebExportText();">
           <input type=button class=button value="插入远程表格" <%=mDisabled%>  <%=mWord%>  onclick="WebSetWordTable()">
           <input type=button class=button value="插入远程图片" <%=mDisabled%>  <%=mWord%>  onclick="WebInsertImage()">
           <input type=button class=button value="下载服务器文件" <%=mDisabled%> <%=mWord%> onClick="WebGetFile()">
           <input type=button class=button value="上传文件到服务器" <%=mDisabled%> <%=mWord%> onClick="WebPutFile()">
           <input type=button class=button value="打开远程文件"  <%=mDisabled%> <%=mWord%>  onclick="WebDownLoadFile()">
           <font color="red"><b>VBA调用</b></font>
           <input type=button class=button value="取Word内容" <%=mDisabled%>  <%=mWord%>  onclick="WebGetWordContent()">
           <input type=button class=button value="写Word内容" <%=mDisabled%>  <%=mWord%>  onclick="WebSetWordContent()">
           <input type=button class=button value="WORD禁止拖动" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.Application.Options.AllowDragAndDrop=false;">  <!--false禁止拖动  true允许拖动-->
           <input type=button class=button value="打印黑白" <%=mDisabled%> <%=mWord%> onClick="WebWordPrintBlackAndWhile();">
           <input type=button class=button value="插入页眉" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.ActiveWindow.ActivePane.View.SeekView=9;">
           <input type=button class=button value="插入页码" <%=mDisabled%> <%=mWord%> onClick="webform.WebOffice.WebObject.Application.Dialogs(294).Show();">
           <input type=button class=button value="用Excel求和" <%=mDisabled%>  <%=mExcel%> onClick="WebGetExcelContent()">
           <input type=button class=button value="锁定工作表" <%=mDisabled%>   <%=mExcel%> onClick="WebSheetsLock()">
           <input type=button class=button value="EXCEL禁止拖动" <%=mDisabled%> <%=mExcel%> onClick="webform.WebOffice.WebObject.Application.CellDragAndDrop=false;">  <!--false禁止拖动  true允许拖动-->
           <input type=button class=button value="文档页数" <%=mDisabled%>  <%=mWord%>  onclick="WebDocumentPageCount()">
		<font color="red"><b>工具栏</b></font>
           <input type=button class=button value="关闭常用工具" <%=mDisabled%>  onclick="WebToolsVisible('Standard',false)">
           <input type=button class=button value="打开常用工具" <%=mDisabled%>  onclick="WebToolsVisible('Standard',true)">
           <input type=button class=button value="关闭格式工具" <%=mDisabled%>  onclick="WebToolsVisible('Formatting',false)">
           <input type=button class=button value="打开格式工具" <%=mDisabled%>  onclick="WebToolsVisible('Formatting',true)">
           <input type=button class=button value="关闭打印按钮" <%=mDisabled%>  onclick="WebToolsEnable('Standard',2521,false);">
           <input type=button class=button value="打开打印按钮" <%=mDisabled%>  onclick="WebToolsEnable('Standard',2521,true);">
                <font color="red"><b>其他调用</b></font>
           <input type=button class=button value="签章锁定文件" <%=mDisabled%>  onclick="WebSignatureAtReadonly();">
        </td>
        <td class="TDStyle" height="100%">
           <table border=0 cellspacing='0' cellpadding='0' width='100%' height='100%' >
             <tr>
                <td bgcolor=menu valign="top">

					 <!--<script src="iWebOffice2006.js"></script>
                 调用iWebOffice，注意版本号，可用于升级-->
                  <!-- <OBJECT id="WebOffice" width="100%" height="100%" classid="clsid:23739A7E-5741-4D1C-88D5-D50B18F7C347" codebase="<%//=mClientUrl%>" >
                  </OBJECT>  =7,9,0,0 -->
				  <div  id="panel3"  name="panel3" width="100%" height="100%" style="height:100%"  >
				   <%@ include file="/public/iWebOfficeSign/iWebOfficeVersion.jsp"%>
					</div>
                </td>
             </tr>
             <tr style="display:none">
                <td bgcolor=menu height='20'><div id=StatusBar>状态栏</div></td>
             </tr>
           </table>
        </td>
      </tr>
    </table>
    <div align="center" style="display:none">
    <%if("1".equals(request.getParameter("CanSave"))){%>
    <input id="input1" type="submit" value="  保存  " <%=mDisabled%> onClick="saveHTML();WebSaveAsHtml(); alert('保存成功！');">
    <script language="javascript">
    <!--
    document.all.input1.style.color = "red";
    document.all.input1.style.fontSize = "20px";
    //-->
    </script>
    <%}%>
    <input id="input2" type="button" value="  返回  " onClick="window.close();">
    <input id="input3" type="button" value=" 显示痕迹 " onClick="javascript:ShowRevision(true);">
	<input id="input4" type="button" value=" 隐藏痕迹 " onClick="javascript:ShowRevision(false);">
    <script language="javascript">
    <!--
    document.all.input2.style.color = "red";
    document.all.input2.style.fontSize = "20px";
    //-->
    </script>
    <script language="javascript">
    <!--
    document.all.input3.style.color = "red";
    document.all.input3.style.fontSize = "20px";
    //-->
    </script>
    <script language="javascript">
    <!--
    document.all.input4.style.color = "red";
    document.all.input4.style.fontSize = "20px";
    //-->
    </script>
    <%if(request.getParameter("clear") != null){%>
<!--     <input id="input3" type="button" value="  清稿  " onclick="window.open('<%=rootPath%>/govezoffice/gov_documentmanager/govdocumentmanager_sendfile_htmlEdit.jsp', '', 'status=no,menubar=no,scrollbars=yes,resizable=yes,width=500,Height=400,left=0,top=0')"> -->
    <script language="javascript">
    <!--
    document.all.input3.style.color = "red";
    document.all.input3.style.fontSize = "20px";
    //-->
    </script>
    <%}%>
    </div>
    <input type="hidden" name="htmlContent">
    <!--注意：只有选择《保存》后，所做的操作才有效！-->
    <%if(request.getParameter("fieldName") != null){%>
    <input type="hidden" name="fieldName" value="<%=request.getParameter("fieldName")%>">
    <%}%>
	<%if(request.getParameter("field") != null){%>
    <input type="hidden" name="fieldName" value="<%=request.getParameter("field")%>">
    <%}%>
  </form>
</body>
<script language="javascript">
function saveHTML(){
    if(opener.document.all.htmlContent){
        opener.document.all.htmlContent.value = document.all.htmlContent.value;
    }
}
<%
if( "1".equals(copyEnableView) && ! "".equals( request.getParameter("viewdoc") ) && request.getParameter("viewdoc") != null  ){
		mEditType="1"; //EditType:编辑类型  方式一、方式二  <参考技术文档>
%>
		WebEnableCopy(false);
<%
}
%>
</script>
 
 <iframe id="ifrm" name="ifrm" src="" style="width:0;height:0;display:'none'"></iframe>
</html>




