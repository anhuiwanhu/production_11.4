<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String localeCode=request.getParameter("localeCode");
if(localeCode!=null){
    com.whir.component.util.LocaleUtils.setLocale(localeCode, request);
}
%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.whir.org.basedata.bd.UnitSetBD" %>
<%@ page import="com.whir.org.basedata.po.UnitInfoPO" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.component.util.LocaleUtils" %>
<%@ page import="com.whir.component.util.CookieParser" %>
<%@ page import="com.whir.ezoffice.personalwork.setup.bd.MyInfoBD" %>
<%@ page import="com.whir.ezoffice.personalwork.setup.po.MyInfoPO" %>
<%@ page import="com.whir.org.basedata.bd.UnitSetBD" %>
<%@ page import="com.whir.org.basedata.po.UnitInfoPO" %>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.org.common.util.SysSetupReader" %>
<%@ page import="com.whir.ezoffice.logon.bd.ResetPasswordBD" %>
<%@ page import="java.security.SecureRandom" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
//log图片默认不显示
//String logopicacc = rootPath+"/images/logo.png";
String logopicacc  = "";
String ewmpicacc = rootPath+"/images/ewm.jpg";
String logobroadpicacc = rootPath+"/images/bg1.jpg";
String userPhoto = rootPath+"/images/ver113/login/user.jpg";
String preview = request.getParameter("preview")!=null?request.getParameter("preview"):"";
String[] ewmArr = null;
String[] ewmNameArr = null;
String logobgSaveNameArr[] = new String[3];
String logobgpath = "";
String bqxx = "";
String qrcodeStatus = "0";//是否开启二维码，默认不开启
if(!preview.equals("") && preview.equals("true")){
    String logo = request.getParameter("logopicacc")!=null?request.getParameter("logopicacc"):"";
    if(!logo.equals("")){
	    logopicacc = fileServer+"/upload/loginpage/"+logo.substring(0,6)+"/"+logo;
    }
    String ewm = request.getParameter("logoindexpicacc");
    String ewmName = request.getParameter("logoindexpicaccName");
    ewmArr = !"".equals(ewm)?ewm.split("\\|"):null;
    ewmNameArr = !"".equals(ewmName)?ewmName.split("\\|"):null;
	String broad = request.getParameter("logobroadpicacc")!=null?request.getParameter("logobroadpicacc"):"";
    //logobgSaveNameArr = !broad.equals("")?broad.split("\\|"):null; 
    if(!broad.equals("")){
        logobroadpicacc = fileServer+"/upload/loginpage/"+broad.substring(0,6)+"/"+broad;
        logobgpath = fileServer+"/upload/loginpage/"+broad.substring(0,6)+"/";
        logobgSaveNameArr = broad.split("\\|");
    }else{
    	logobgpath = rootPath+"/images/";
    	logobgSaveNameArr[0] = "bg1.jpg";
    }
    qrcodeStatus = request.getParameter("isOpenewm")!= null ?request.getParameter("isOpenewm"):"0";
}else{
	com.whir.org.basedata.bd.LoginPageSetBD loginPageSetBD = new com.whir.org.basedata.bd.LoginPageSetBD();
	String[][] pageset = loginPageSetBD.getLoginPageSet((String)request.getAttribute("previewId"));
	if(pageset!=null && pageset.length>0){
		 if(pageset[0][0]!=null&&!"null".equals(pageset[0][0])&&!"".equals(pageset[0][0])){
			 //String saveName = pageset[0][0];
			 logobgSaveNameArr = !pageset[0][0].equals("")?pageset[0][0].split("\\|"):null; 
			logopicacc = fileServer+"/upload/loginpage/"+pageset[0][0].substring(0,6)+"/"+pageset[0][0];
			logobgpath = fileServer+"/upload/loginpage/"+pageset[0][0].substring(0,6)+"/";
		 }
		 if(pageset[0][2]!=null&&!"null".equals(pageset[0][2])&&!"".equals(pageset[0][2])){
			//ewmpicacc = fileServer+"/upload/loginpage/"+pageset[0][2].substring(0,6)+"/"+pageset[0][2];
            ewmArr = pageset[0][2].split("\\|");
            ewmNameArr = pageset[0][3].split("\\|");
		 }
		 if(pageset[0][4]!=null&&!"null".equals(pageset[0][4])&&!"".equals(pageset[0][4])){
			logobgSaveNameArr = !pageset[0][4].equals("")?pageset[0][4].split("\\|"):null; 
			logobroadpicacc = fileServer+"/upload/loginpage/"+pageset[0][4].substring(0,6)+"/"+pageset[0][4];
			logobgpath = fileServer+"/upload/loginpage/"+pageset[0][4].substring(0,6)+"/";
		 }
		 if(pageset[0][6]!=null&&!"null".equals(pageset[0][6])&&!"".equals(pageset[0][6])){
			 qrcodeStatus = pageset[0][6]; 
		 }
	}
}
//获取版权信息
    UnitSetBD unitSetBD = new UnitSetBD();
//域标识 默认 为0    
	UnitInfoPO unitInfoPO = unitSetBD.getUnitInfo("0");
	if(unitInfoPO != null){
		if(StringUtils.isNotBlank(unitInfoPO.getCopyRights())){
			bqxx = unitInfoPO.getCopyRights();
		}
	}
//输入错误次数,用于显示验证码（>=2）
int inputErrorNum = Integer.parseInt(session!=null&&session.getAttribute("inputErrorNum")!=null?session.getAttribute("inputErrorNum").toString():"0");
String isDiglossia = "1" ; //是否双语,0:非双语,1：双语
if(localeCode==null){
   localeCode="zh_CN";
}
//以下语句防止日文系统ja或者zh_CN
localeCode = LocaleUtils.getLocale(localeCode);
String validate=request.getParameter("validate");

//此处进行个人图片的验证
String userId = session.getAttribute("userId")==null?"":session.getAttribute("userId").toString();
MyInfoBD bd = new MyInfoBD();
if(StringUtils.isNotBlank(userId)){
	MyInfoPO  myInfo = bd.load(userId);
	if(myInfo != null&&myInfo.getEmpLivingPhoto()!=null){
		
		java.io.File file = new java.io.File(myInfo.getEmpLivingPhoto());
		if(file.exists()){userPhoto = myInfo.getEmpLivingPhoto();}
	}
}
if("no".equals(validate)){
	if(session.getAttribute("org.apache.struts.action.LOCALE")!=null && !"".equals(session.getAttribute("org.apache.struts.action.LOCALE"))){
        localeCode = session.getAttribute("org.apache.struts.action.LOCALE").toString();
  		//以下语句防止日文系统ja或者zh_CN
        localeCode = LocaleUtils.getLocale(localeCode);
	}
	//注销时，清除工作流当前用户的锁
	String userAccount = session.getAttribute("userAccount")==null?"":session.getAttribute("userAccount").toString(); 
	userAccount=com.whir.component.security.crypto.EncryptUtil.htmlcode(userAccount);
	if(!"".equals(userAccount)){
		com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD wfbd = new com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD();
		wfbd.logoutWFOnlineUser(userAccount);
	}
	
    //session.invalidate();
    if("1".equals(isDiglossia)){
        response.sendRedirect("login.jsp?localeCode="+localeCode);
    }else{
        response.sendRedirect("login.jsp");
    }
}else{
    //以下语句防止日文系统ja或者zh_CN
    localeCode = LocaleUtils.getLocale(localeCode);
    LocaleUtils.setLocale(localeCode, request);
}
CookieParser cookieparser = new CookieParser();
cookieparser.addCookie(response, "LocLan", localeCode, 365*24*60*60, null, "/", false);
String domainAccount=com.whir.org.common.util.SysSetupReader.getInstance().isMultiDomain();
String logoFile = rootPath+"/images/"+localeCode+"/bg.jpg";
int inputPwdErrorNum = Integer.parseInt(request.getAttribute("inputPwdErrorNum")!=null?(String)request.getAttribute("inputPwdErrorNum"):"0");
int inputPwdErrorNumMax = Integer.parseInt(request.getAttribute("inputPwdErrorNumMax")!=null?(String)request.getAttribute("inputPwdErrorNumMax"):"6");
String useCaptcha = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("captcha", "0");
String userAccount = request.getAttribute("userAccount")==null?"":request.getAttribute("userAccount").toString();
userAccount=userAccount.replaceAll("\\+|>|<|\"|'|;|%|&|\\(|\\)","");
String userPassword = request.getAttribute("userPassword")==null?"":request.getAttribute("userPassword").toString();

//获取找回密码配置----开始
 String domainId1 = request.getAttribute("domainId")==null?"0":request.getAttribute("domainId").toString();
 com.whir.ezoffice.logon.bd.ResetPasswordBD rpbd = new com.whir.ezoffice.logon.bd.ResetPasswordBD();
 String resetPassword = rpbd.getResetPassword(domainId1);

 //获取找回密码配置----结束
 
SecureRandom random1=SecureRandom.getInstance("SHA1PRNG");
long seq=random1.nextLong();
String random=""+seq;
session.setAttribute("random_session",random);
%>

<html lang='zh-cn' id = "loginHtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>万户ezOFFICE协同管理平台</title>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.login.css" />
    <!-- <link type="text/css" rel="stylesheet" href="<%=rootPath%>/themes/login/login.css" /> -->
    <%@ include file="/public/include/login_base.jsp"%>
    <script type="text/javascript" src="<%=rootPath%>/scripts/util/cookie.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/security/security.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/util/login.js"></script>
    <script type="text/javascript" src="<%=rootPath%>/scripts/plugins/flexslide/jquery.flexslider.js"></script>
    <!--[if lt IE 9]>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.login.ie8.css" />
    <![endif]-->
    
</head>

<body>
<div class="wh-wrapper">
    <div class="wh-pg-login">
        <div class="wh-main">
        <div class="wh-login-top">
            <h1> 
          	  <img src="<%=logopicacc%>" id = "loginPic" data-pich="80" />
            </h1>
            <ul class="wh-login-tips">
                <li> <a href="/defaultroot/public/edit/logindownload/Logindownload.jsp?fileName=activex.msi" class="widget"><i class="fa fa-cog2"></i><span><%=Resource.getValue(localeCode,"common","comm.Controlinstallation")%></span></a></li>
                <li style="display:none"><a href="javascript:addFavorite()" class="collect"><i class="fa fa-plus-circle"></i><span><%=Resource.getValue(localeCode,"common","comm.Favorite")%></span></a></li>
                <li><a href="<%=rootPath%>/help/help_set.html" class="help"><i class="fa fa-question-circle"></i><span><%=Resource.getValue(localeCode,"common","comm.setupHelp")%></span></a></li>
            </ul>
        </div>
            <div class="wh-login-cons" id = "submitTyle">
                <div class="wh-md md-dft-lg" id="">
                    <div class="wh-lg-form">
                        <div class="wh-lg-lang">

                        </div>
                        <form>

                        </form>
                    </div>
                </div>
                <div class="wh-md md-mobi-lg" id="">
                    <div class="">

                    </div>
                </div>
                <div class="wh-md md-ca-lg" id="">
                    <div class="">

                    </div>
                </div>
               
                <div class="wh-lg-loIn-bg"></div>
                <!--移动版本-->
                <div class="wh-lg-logoIn" >
                    <div class="wh-lg-logoIn-top" >
                        <a href="javascript:void(0)"><img src="" class="user" id = "empLivingPhoto" onclick ="submitByPhoto()" /></a>
                        <form id="LogonForm" name="LogonForm" action="Logon!logon.action" method="post">
						<input type="hidden" name="random_form" value=<%=random%>></input>
	                         <div <%if(domainAccount!=null){%>style="display:none"<%}%>>
	                            <input type="text" id="domainAccount" name="domainAccount" <%if(domainAccount!=null){%>value="<%=domainAccount%>"<%}%> class="acc textOn" />
	                            <div class="inputText"><%=Resource.getValue(localeCode,"common","comm.unitaccount")%></div>
	                        </div>
                            <div class="vali-username">
                                <i class="fa fa-user" id = "userStyle"></i>
                                <input type="text" id="userAccount" name="userAccount" value="" class="info"/>
                            </div>
							
                            <div class="vali-pass">
                                <i class="fa fa-lock" id  = "passwordStyle"></i>
                                <input type="password" id="userPassword" name="userPassword" class="info" autocomplete="off"/>
                            </div>
                             <%if("1".equals(useCaptcha)||(inputErrorNum>=2 && "2".equals(useCaptcha))){%>
	                       		 <div class="vali-image clearfix" id="getYzm">
	                                <input type="text" name="captchaAnswer" id="captchaAnswer" class="image" value=""/>
	                                <img id="yzm" src="<%=rootPath%>/captcha.png" onclick="document.getElementById('yzm').src='<%=rootPath%>/captcha.png?'+new Date().getTime();">
	                            </div>
                        	<%}%>
                            <div class="pass-check clearfix">
                                <input type="hidden" id="isRemember" name="isRemember"  class="pass-check">
                                <input type="checkbox" name="isRemember" onclick="mychecked(this)" class="checkpass" id = "rememberCheckbox"/>
                                <span><%=Resource.getValue(localeCode,"common","comm.RememberPassword")%></span>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<span id="resetPasswordSPAN" style="display:none;" > 
									<a href="javascript:void(0)" onclick="javascript:openWin({url:'ResetPasswordAction!sendMessage.action',winName:'findPassword',height:280,width:600});">
									<font color="#D1EEEE"><%=Resource.getValue(localeCode,"common","comm.getbackpassword")%></font>
									</a>
								</span>
                            </div>
						
                              
                            
                            <div class="vali-submit">
                                <input type="button"  id="mysubmit" class="sub" value="<%=Resource.getValue(localeCode,"common","comm.logon")%>" onClick="javascript:submitForm();"/>
                            </div>
                             <input type = "hidden" id = "localeCode" name="localeCode" />
                        </form>
                        <div class="wh-lg-lang-sele">
                            <div class="sele-show" id = "localeCode1">
                            	<%if("zh_CN".equals(localeCode)){%>
	                            	<span>简体中文</span><i class="fa fa-angle-right"></i>
                            	<%}else if("zh_TW".equals(localeCode)){%>
                            		<span>繁體中文</span><i class="fa fa-angle-right"></i>
                            	<%}else if("en_US".equals(localeCode)){%>
                            		<span>English</span><i class="fa fa-angle-right"></i>
                            	<%}else if("ko_KR".equals(localeCode)){%>
                            		<span>한국어</span>	<i class="fa fa-angle-right"></i>
                            	<%}else if("ja_JP".equals(localeCode)){%>
                            		<span>日本语</span><i class="fa fa-angle-right"></i>
                            	<%}%>
                           	</div>
                            <div class="sele-list-div"></div>
                            <ul class="sele-list clearfix" id = "localeCode2">
	                            <li <%if("zh_CN".equals(localeCode)){%> class="current"<% }%> id = "jtzw"><span class="sl1" value="zh_CN" onclick="selectLauguale(this)">简体中文</span><i class="fa fa-check-circle-o"></i></li>
                                <li <%if("zh_TW".equals(localeCode)){%> class="current"<% }%> id = "ftzw"><span value="zh_TW" class="sl2" onclick="selectLauguale(this)">繁體中文</span><i class="fa fa-check-circle-o"></i></li>
                                <li <%if("en_US".equals(localeCode)){%> class="current"<% }%> id = "yw"><span value="en_US" class="sl3" onclick="selectLauguale(this)">English</span><i class="fa fa-check-circle-o"></i></li>
                                <li <%if("ko_KR".equals(localeCode)){%> class="current"<% }%> id = "hw"><span value="ko_KR" class="sl4" onclick="selectLauguale(this)">한국어</span><i class="fa fa-check-circle-o"></i></li>
                                <li <%if("ja_JP".equals(localeCode)){%> class="current"<% }%> id = "rw"><span value="ja_JP" class="sl5" onclick="selectLauguale(this)">日本语</span><i class="fa fa-check-circle-o"></i></li>
                            </ul>

                        </div>
                    </div>
                    <div class="wh-lg-logoIn-top"  style="display: none; ">
                        <div class="wh-lg-logoIn-top-title" ><i class="fa fa-info-circle ipersonal"></i><span><%=Resource.getValue(localeCode,"common","comm.openQRcode")%></span></div>
                        <div class="flexslider1">
                            <ul class="slides">
                            <!-- 遍历二维码 -->
                              	<%
				                if(ewmArr!=null && ewmNameArr != null){
				                	int ewmSize = ewmArr.length;
				                	int ewmNameSize = ewmNameArr.length;
				                	int picsize = 0;
				                	if(ewmSize >= ewmNameSize){
				                		picsize = ewmNameSize;
				                	}else{
				                		picsize = ewmSize;
				                	}
				                    for(int i=0;i< picsize ;i++){
				                %>
				                    <li><img src="<%=fileServer+"/upload/loginpage/"+ewmArr[i].substring(0,6)+"/"+ewmArr[i]%>" />
				                   	 <p><%=ewmNameArr[i] %></p>
				                    </li>
				                    
				                <%  }
				                }else{
				                %>
	                                <li>
	                                 <p></p>
	                                </li>
				                <%}%>
                            </ul>
                        </div>
                    </div>
                    <ul class="wh-lg-logoIn-nav" id = "ewmStyle">
                        <li class="current one"><%=Resource.getValue(localeCode,"common","comm.commonlogin")%></li>
                        <li class="two" ><%=Resource.getValue(localeCode,"common","comm.QRcode")%></li>
                    </ul>
                </div>

            </div>
        </div>
        <!--  登录背景切换 -->
        <div class="wh-lg-slider">
                <div class="flexslider">
                        <ul class="slides">
                        	<%
			                if(logobgSaveNameArr!=null){
			                    for(int i=0;i<logobgSaveNameArr.length;i++){
			                    	if(StringUtils.isNotBlank(logobgSaveNameArr[i])){
			                    	%> 		
					                    <li style="background-image:url('<%=logobgpath+logobgSaveNameArr[i]%>')"></li>
					                <% 
			                    	}
					                }}
					        %>
                        </ul>
                 </div>
                 <div class="wh-lg-copy">
                	<%=bqxx %>
           		 </div>
         </div>
    </div>
</div>

<div class="wh-iewarning" id = "iewarning" style="display:none">
    <div class="wh-iewarn-box" style="display:none" id = "ie8warning">
        <h2 class="clearfix"><strong>温馨提示</strong><a class="close" onclick="closeIewarning()" href="javascript:void(0)" ></a></h2>
        <table>
            <tr>
                <td>
                    <i class="wh-iewarn-notice"></i>
                    <em><%=Resource.getValue(localeCode,"common","comm.commie8")%></em>
                </td>
            </tr>
            <tr>
                <td>
                    <p><a class="wh-iewarn-btn" href="http://download.microsoft.com/download/1/6/1/16174D37-73C1-4F76-A305-902E9D32BAC9/IE8-WindowsXP-x86-CHS.exe" target="_blank"><%=Resource.getValue(localeCode,"common","comm.updateie8")%></a></p>
                    <p><a href="http://www.google.cn/intl/zh-CN/chrome/browser/"  target="_blank"><%=Resource.getValue(localeCode,"common","comm.chrome")%></a><a href="http://www.firefox.com.cn/"  target="_blank"><%=Resource.getValue(localeCode,"common","comm.firefox")%></a></p>
                </td>
            </tr>
        </table>
    </div>
    <div class="wh-iewarn-box" style="display:none" id = "ie9warning">
        <h2 class="clearfix"><strong>温馨提示</strong><a class="close" href="javascript:void(0)" onclick="closeIewarning()"></a></h2>
        <table>
            <tr>
                <td>
                    <i class="wh-iewarn-notice"></i>
                    <em><%=Resource.getValue(localeCode,"common","comm.commie9")%></em>
                </td>
            </tr>
            <tr>
                <td>
                    <p><a class="wh-iewarn-btn wh-iewarn-btn-disable" href="javascript:void(0)" onclick="closeIewarning()"><%=Resource.getValue(localeCode,"common","comm.notupdate")%></a><a class="wh-iewarn-btn" href="http://windows.microsoft.com/zh-cn/internet-explorer/ie-9-worldwide-languages" target="_blank"><%=Resource.getValue(localeCode,"common","comm.updateie9")%></a></p>
                    <p><a href="http://www.google.cn/intl/zh-CN/chrome/browser/"  target="_blank"><%=Resource.getValue(localeCode,"common","comm.chrome")%></a><a href="http://www.firefox.com.cn/"  target="_blank"><%=Resource.getValue(localeCode,"common","comm.firefox")%></a></p>
                </td>
            </tr>
        </table>
    </div>
    <div class="wh-iewarn-wrap"></div>
</div>
</body>
<SCRIPT LANGUAGE="JavaScript">
$(document).ready(function() {

	var userAccount = $('#userAccount');
	userAccount.focus();
});
/**
var oaV = getVersion();
//获取操作系统版本，只针对window
function getVersion(){
	var ua = window.navigator.userAgent;
	var osV = "";
	var osVersion = "";
	if(ua.indexOf("MSIE") > 0 ){
		osVersion = ua.split(";")[2];
		osV = osVersion.substr(osVersion.length-3,3);
	}
	return osV;
}
*/
//判断系统，在判断版本 若是xp的则。。若是win7的则。。
/** var ver=navigator.appVersion.substring(navigator.appVersion.indexOf("MSIE ")+5, navigator.appVersion.indexOf("MSIE ")+8);
//对ie6,7,8的处理
//if(oaV == "5.1"){
	//xp
	if(ver<8){
		addStyleByIe6();
		$("#iewarning").show();
		$("#ie8warning").show();
	}
//}else if(oaV == "6.1"){
	//win7
	if(ver<9){
		$("#iewarning").show();
		$("#ie9warning").show();
	}
//}
*/



//关闭div层
function closeIewarning(){
	$("#iewarning").hide();
}

/**
//获取图片高度，宽度
function getNatural (DOMelement) {
    var img = new Image();
    img.src = DOMelement.src;
    return {width: img.width, height: img.height};
  }
*/

function initLang(localeCode){
	var language = "zh-cn";
	if(localeCode == 'zh_TW'){
		language = "zh-tw";
	}else if(localeCode == 'en_US'){
		language = "en-us";
	}else if(localeCode == 'ko_KR'){
		language = "ko-kr";
	}else if(localeCode == 'ja_JP'){
		language = "ja-jp";
	}
	$("#loginHtml").attr("lang",language);
}
$(function(){
	 var ver=navigator.appVersion.substring(navigator.appVersion.indexOf("MSIE ")+5, navigator.appVersion.indexOf("MSIE ")+8);
	//对log图片赋值，暂时去掉
	 /**
	 var  loginPicheight = 0;
	 if(navigator.appVersion.indexOf("MSIE") >0 && ver < 9){
		var loginPic = getNatural(document.getElementById('loginPic'));
		loginPicheight = loginPic.height;
	}else{
	    loginPicheight = $('img#loginPic')[0].naturalHeight;
	}
	if(loginPicheight > 0){
		$("#loginPic").attr("data-pich",loginPicheight);
	}

	var picHeight = parseInt($("#loginPic").data('pich')+"px");
	var picMarginTop = "-"+parseInt($("#loginPic").data('pich'))/2+"px";
	$("#loginPic").height(picHeight);
	$("#loginPic").css({"height":picHeight, "margin-top":picMarginTop});
	*/
	//对语言赋值
	var localeCode = '<%=localeCode%>';
	initLang(localeCode);
	
	//不同浏览器时需要隐藏
	var srcName = '<%=logopicacc%>';
	if(srcName == "" || srcName == "undefined" || srcName == null){
		$("#loginPic").hide();
	}
	//通过二维码状态判断是否显示二维码
	var qrcodeStatus = '<%=qrcodeStatus%>';
	if(qrcodeStatus == "0" || qrcodeStatus == null || qrcodeStatus == ""){
		$("#submitTyle").addClass("wh-login-cons wh-lg-no-button");
		$("#ewmStyle").hide();
	}
    //动态赋高
    function scrh(obj){
        var scrHeight=document.body.scrollHeight;
        obj.css({'height':scrHeight});
    }
    $(function(){
   	    var scrH=$(".wh-pg-login,.wh-lg-slider");
          scrh(scrH);

          var resizeTimer;
          function resizeFunction() {
              scrh(scrH);
          };

          $(window).resize(function() {
              clearTimeout(resizeTimer);
              resizeTimer = setTimeout(resizeFunction, 300);
          });            
          resizeFunction();
           
        $(".flex-next").text('');
        $(".flex-prev").text('');
        //click language selection
        var sele_bd = $(".sele-list-div");
        var sele_list = $(".sele-list");
        var wh_llnav = $(".wh-lg-logoIn-nav li");
        var wh_lltop = $(".wh-lg-logoIn-top");

        $(".sele-show").click(function () {
            sele_bd.show();
            sele_list.show(200);
            return false;
        });

        sele_list.find("li").click(function(){
            sele_list.hide();
            sele_bd.hide();
            return false;
        });

        $("body").click(function () {
            sele_bd.hide();
            sele_list.hide();
           /* return false;*/
        });

        $(".info").focus(function(){
            $(this).parent().css("border-color","#0c89e1");
        });
        $(".info").blur(function(){
            $(this).parent().css("border-color","#666");
        });
        $(".info").hover(function(){
            $(this).parent().css("border-color","#0c89e1");
        },function(){
            $(this).parent().css("border-color","#666");
        });
        $(".image").hover(function(){
            $(this).css("border-color","#0c89e1");
        },function(){
            $(this).css("border-color","#666");
        });
       	 wh_llnav.on("click",function(){
                var $this = $(this);
                var index = $this.index();
                $this.addClass("current").siblings().removeClass("current");
                wh_lltop.hide().eq(index).show();
                if(index == 1){
                    $('.flexslider1').flexslider({
                        animation: "slide",
                        directionNav: true,
                        controlNav: false,
                        slideshowSpeed: 700000
                    });
                }
            });
    });

    //轮播
    $('.flexslider').flexslider({
        directionNav: false,
        controlNav: true
    });

	//判断找回密码功能
	 var resetPassword = '<%=resetPassword%>';
	 if(resetPassword==1){
	 	document.getElementById("resetPasswordSPAN").style.display="inline-block";
	 }
	 
});

/**var n = $('#getYzm').length;
if(n>0){
    $('#login_bgcolor').height(480);
}else{
    $('#login_bgcolor').height(440);
}*/


function mychecked(obj){
	if(obj.checked){
		document.getElementById("isRemember").value= "1";
		//document.LogonForm.isRemember.value="1";
	}else{
		document.getElementById("isRemember").value= "0";
		//document.LogonForm.isRemember.value="0";
	}
}
function submitByPhoto(){
	var empLivingPhoto = document.getElementById("empLivingPhoto").src;
	if(empLivingPhoto != "" && empLivingPhoto !="/defaultroot/images/noliving.gif"){
		submitForm();
	}
}
function selectLauguale(obj){
	if(obj.innerText != ""){
	 var localcode  = obj.getAttribute('value');
	 $("#localeCode1").val(obj.innerText);
	 $("#jtzw").removeClass("current");
     location.href = "login.jsp?localeCode="+localcode;
	}
}

document.onkeydown=function(e){ 
	var theEvent = window.event || e; 
	var code = theEvent.keyCode || theEvent.which; 
	if (code == 13) { 
		submitForm();
	} 
} 

function load(){
	//去除原来下拉框的设置
	
    loadCookie();
	<%if("user".equals((String)request.getAttribute("errorType"))){%>
		document.LogonForm.userAccount.select();
	<%}else{%>
	//	document.LogonForm.userPassword.focus();
	<%}%>
}

function checkForm(){
	  //需要对隐藏域重新赋值
	  $("#localeCode").val("<%=localeCode%>");	
     if(document.LogonForm.userAccount.value==""){
        whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind4")%>", function(){
            document.LogonForm.userAccount.focus();
            return false;
        });

        document.LogonForm.userAccount.focus();
        
        return false;
    }else if( document.LogonForm.userPassword.value==""){
        whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind5")%>", function(){
            document.LogonForm.userPassword.focus();
            return false;
        });

        document.LogonForm.userPassword.focus();
        
        return false;
    }
     
    return true;
}

function killerrors() { 
    return true; 
} 
window.onerror = killerrors; 

window.onload = function (e) {
    /*bodyclick = document.getElementsByTagName('body').item(0);
    rSelects();
    bodyclick.onclick = function () {
        for (i = 0; i < selects.length; i++) {
            _$('select_info_' + selects[i].name).className = 'tag_select';
            _$('options_' + selects[i].name).style.display = 'none';
        }
    }*/
    load();

    checkBrowser();
}
   
/**function createSelect(select_container,index){
	//创建select容器，class为select_box，插入到select标签前
	var tag_select = $('<div></div>');//div相当于select标签
	tag_select.attr('class','select_box');
	tag_select.insertBefore(select_container);
	//显示框class为select_showbox,插入到创建的tag_select中
	var select_showbox = $('<div></div>');//显示框
	tag_select.attr('id','query_input');
	select_showbox.css('cursor','pointer').attr('class','select_showbox').appendTo(tag_select);
	//创建option容器，class为select_option，插入到创建的tag_select中
	var ul_option = $('<ul></ul>');//创建option列表
	ul_option.attr('class','select_option');
	ul_option.appendTo(tag_select);
	createOptions(index,ul_option);//创建option
	//点击显示框
	
	
	select_showbox.click(function(){
		if(ul_option.is(":hidden")){
			tag_select.addClass('on');
			ul_option.slideDown(100);
		}else{
			tag_select.removeClass('on');
			ul_option.slideUp(100);
		}
	})
	
	/*document.onclick=function(e){ 
		var e=e?e:window.event; 
		var tar = e.srcElement||e.target; 
		if(tar.id!="query_input"){ 
			tag_select.removeClass('on');
			//ul_option.slideUp(100);
        } 
    }
	var li_option = ul_option.find('li');
	li_option.on('click',function(){
		$(this).addClass('selected').siblings().removeClass('selected');
		var text = $(this).text();
		select_showbox.text(text);
        var localcode = $(this).attr('localcode');
        $("#localeCode").val(localcode);
		ul_option.hide();
        location.href = "login.jsp?localeCode="+localcode;
	});
	li_option.hover(function(){
		$(this).addClass('hover').siblings().removeClass('hover');
	},function(){
		li_option.removeClass('hover');
	});
}

function createOptions(index,ul_list){
	//获取被选中的元素并将其值赋值到显示框中
    var selects = $('select');
	var options = selects.eq(index).find('option');
	var	selected_option = options.filter(':selected');
	var	selected_index = selected_option.index();
	var	showbox = ul_list.prev();
	showbox.text(selected_option.text());
	//为每个option建立个li并赋值
	for(var n=0;n<options.length;n++){
		var tag_option = $('<li></li>'),//li相当于option
			txt_option = options.eq(n).text();
		tag_option.text(txt_option).css('cursor','pointer').appendTo(ul_list);
        tag_option.attr('localcode',options.eq(n).val());
		//为被选中的元素添加class为selected
		if(n==selected_index){
			tag_option.attr('class','selected');
		}
	}
}*/

<%
String errorType=(String)request.getAttribute("errorType");

if("noDog".equals(errorType)){
%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.noDog")%>",null);
<%}else if("active".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.active")%>",null);
<%}else if("sleep".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.userIsSleep")%>",null);
<%}else if("captchaWrong".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrong")%>",null);
<%}else if("captchaWrongNull".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.captchawrongNull")%>",null);
<%}else if("resetpassword".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.resetpassword")%>",null);
<%}else if("ip".equals(errorType)){
    String addr=request.getRemoteAddr();
    addr=addr==null?"":"("+addr+")";
%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind1")%>",null);
<%}else if("password".equals(errorType)
//&&!("admin".equals(userAccount)||"security".equals(userAccount))
){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind31")%><%=inputPwdErrorNumMax-inputPwdErrorNum%><%=Resource.getValue(localeCode,"common","comm.loginremind32")%>",function(){
        document.LogonForm.userPassword.select();
        document.LogonForm.userPassword.value="";
        document.LogonForm.userAccount.value='<%=userAccount%>';
    });
<%}else if("password".equals(errorType)&&("admin".equals(userAccount)||"security".equals(userAccount))){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind3")%>",function(){
        document.LogonForm.userPassword.select();
        document.LogonForm.userPassword.value="";
        document.LogonForm.userAccount.value='<%=userAccount%>';
    });
<%}else if("user".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind2")%>",function(){
        document.LogonForm.userAccount.select();
        document.LogonForm.userAccount.value='<%=userAccount%>';
        document.LogonForm.userPassword.value="";
        
    });
<%}else if("online".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.online")%>",null);
<%}else if("domainError".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainerror")%>",null);
<%}else if("userNumError".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.usernumerror")%>",null);
<%}else if("forbidUser".equals(errorType)){%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.active")%>",null);
<%}
errorType=request.getParameter("errorType");
if("overtime".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.overtime")%>",null);
<%}else if("nokey".equals(errorType)){
	session.invalidate();
%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.nokey")%>",null);
<%}else if("keyErr".equals(errorType)){
	session.invalidate();
%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.keyerror")%>",null);
<%}else if("domainError".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainiderror")%>",null);
<%}else if("userNumError".equals(errorType)){%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.domainerror")%>",null);
<%}else if("kickout".equals(errorType)){
    session.invalidate();
%>
    whir_alert("您的账号正在另一客户端登录！"); 
<%}%>


</script>
</html>