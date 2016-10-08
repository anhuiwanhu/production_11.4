<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.whir.org.basedata.bd.UnitSetBD"%>
<%@ page import="com.whir.org.basedata.po.UnitInfoPO"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="javax.servlet.http.Cookie" %>
<%@ page import="com.whir.i18n.Resource" %>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.org.common.util.SysSetupReader" %>
<%@ page import="java.security.SecureRandom" %>
<script type="text/javascript" src="/defaultroot/scripts/plugins/form/jquery.form.js" />
<script type="text/javascript" src="/defaultroot/scripts/plugins/security/security.js"></script>
<%


//模块页面
/*response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);*/
response.setContentType("text/html; charset=UTF-8");
String domainAccount=com.whir.org.common.util.SysSetupReader.getInstance().isMultiDomain();


String layoutId = request.getParameter("layoutId");
String portletSettingId = request.getParameter("portletSettingId");
String inputErrorNum = "0";
if(session.getAttribute("inputErrorNum")!=null){
	inputErrorNum = session.getAttribute("inputErrorNum").toString();
}

String domainId = "0";
boolean _outter_ = "1".equals(request.getParameter("outter"));
if(!_outter_){
	domainId = session.getAttribute("domainId").toString();
}

UnitSetBD unitSetBD = new UnitSetBD();
UnitInfoPO po = unitSetBD.getUnitInfo(domainId);
String unitName = po.getUnitName();

PortalLayoutBD bd = new PortalLayoutBD();
//platform/portalLayoutPO layoutPO = bd.load(new Long(layoutId));
String[][] layoutPO = bd.loadLayout(layoutId+"");
String localeCode=request.getParameter("localeCode");
if(localeCode==null){
   localeCode="zh_CN";
}
Cookie locCookie=new Cookie("LocLan", localeCode);
locCookie.setMaxAge(60*60*24*365);
response.addCookie(locCookie);
String useCaptcha = com.whir.org.common.util.SysSetupReader.getInstance().getSysValueByName("captcha", "0");

//以下语句防止日文系统ja或者zh_CN
localeCode = com.whir.component.util.LocaleUtils.getLocale(localeCode);
//获取找回密码配置----开始
 String domainId1 = CommonUtils.getSessionDomainId(request) + "";
 SysSetupReader sysRed = SysSetupReader.getInstance();
 Map setupMap = sysRed.getSysSetupMap(domainId1);
 String resetPassword = (String)setupMap.get("resetPassword");
 //获取找回密码配置----结束
 
 //用于判断是否登陆成功
 String existUserAccount =  (String)(session.getAttribute("userAccount")==null?"notExist":session.getAttribute("userAccount"));
//20160922 -by jqq 登录前门户登录跳转到登录页异常改造
SecureRandom random1=SecureRandom.getInstance("SHA1PRNG");
long seq=random1.nextLong();
String random=""+seq;
session.setAttribute("random_session",random);
%>

<%
    if("notExist".equals(existUserAccount)){
%>
<div class="wh-portal-login">
    <h4><%=unitName %></h4>
    <div class="wh-portal-login-ipt">
    <form id="LogonForm" name="LogonForm" action="Logon!logon.action" method="post" target="_self">
    	<input type="hidden" name="random_form" value=<%=random%>></input>
			<input type="hidden" name="_portal_loginUsed" value="<%=layoutPO[0][6]%>">
	    <input type="hidden" name="_portal_goUrl" value="platform/portal/index.jsp?layoutId=<%=layoutId%>&portletSettingId=<%=portletSettingId%>">
	    <input type="hidden" name="_portal_flag" value="1">
	    <div class="wh-portal-l-usrname">
	        <i class="fa fa-user"></i>
	        <input type="text" name="userAccount" id="userAccount" onKeyDown="if(event.keyCode==13) submitForm();" class="info">
	    </div>
	    <div class="wh-portal-l-pwd">
	        <i class="fa fa-lock"></i>
	        <input type="password" name="userPassword" id="userPassword" class="info" onKeyDown="if(event.keyCode==13) submitForm();">
	    </div>
		<input type="hidden" id="domainAccount" name="domainAccount" <%if(domainAccount!=null){%>value="<%=domainAccount%>"<%}%>/>
	
		<div class="wh-portal-l-check clearfix">
             <div class="wh-portal-l-select">
                 <span id="chooseLanguage" class="lang-default"><%="zh_CN".equals(localeCode) ? "简体中文" : "zh_TW".equals(localeCode) ? "繁体中文" : "ko_KR".equals(localeCode) ? "韩国语" : "ja_JP".equals(localeCode) ? "日本语" : "en_US".equals(localeCode) ? "English" : "简体中文"%></span>
                 <ul class="lang-list">
                     <li value="zh_CN" >简体中文</li>
                     <li value="zh_TW" >繁体中文</li>
                     <li value="en_US" >English</li>
                     <li value="ko_KR" >韩国语</li>
                     <li value="ja_JP" >日本语</li>
                 </ul>
             </div>
             <input type="hidden" id="localeCode" name="localeCode" value="<%=localeCode %>"/>
             <div class="wh-portal-l-rmbpwd">
                 <input type="checkbox" id="remember" name="remember" value="1"/><span><%=Resource.getValue(localeCode,"common","comm.RememberPassword")%></span>
             </div>
         </div>
         <%
			if("1".equals(useCaptcha) || ("2".equals(useCaptcha) && Integer.parseInt(inputErrorNum)>=2)){
		 %>
		 <div class="formdiv">
			 <input type="text" id="captchaAnswer" name="captchaAnswer" class="captchatext" autocomplete="off" style="width:54px" maxlength="4"/><a href="javascript:void(0);" onclick="document.getElementById('yzm').src='<%=rootPath%>/captcha.png?'+new Date().getTime();"><img id="yzm" src="<%=rootPath%>/captcha.png" border=0 style="margin:-3px 5px 0 5px;" align="absmiddle"/></a>
		 </div>
		 <%}%>
         <div class="wh-portal-l-btn">
             <a href="javascript:void(0)" onClick="javascript:submitForm();">登&nbsp;录</a>
         </div>
       	<p class="wh-portal-l-fogot" style="display:none" id="resetPasswordDIV">
			<a href="javascript:void(0)" title="找回密码" onclick="javascript:openWin({url:'ResetPasswordAction!sendMessage.action',winName:'findPassword',height:280,width:600});">找回密码</a>
	 	</p>
     </form>
     </div>
</div>
<%
int inputPwdErrorNum = Integer.parseInt(request.getParameter("inputPwdErrorNum")!=null?(String)request.getParameter("inputPwdErrorNum"):"0");
int inputPwdErrorNumMax = Integer.parseInt(request.getParameter("inputPwdErrorNumMax")!=null?(String)request.getParameter("inputPwdErrorNumMax"):"6");
%>
<script language="JavaScript">



$(document).ready(function(){
	$("#chooseLanguage").click(function(){
	    $(this).toggleClass("lang-select");
	    $("ul.lang-list").toggle();
	    $("ul.lang-list li").click(function(){
	        $(".lang-default").html($(this).text());
	        $("ul.lang-list").hide();
	        $("#localeCode").val($(this).attr("value"));
	    })
	})

	$("#userAccount").val($.cookie("userAccount"));
    if ($.cookie("isRemember") == "true") {
		$("#remember").attr("checked", true);
		$("#userPassword").val($.cookie("userPassword"));
		if('<%=inputErrorNum%>'!="0"){
			$("#userPassword").val("");
			$("#remember").attr("checked", false);
			$.cookie("isRsa", "false", { expires: 365 });
		}else{
			if ($.cookie("isRsa") != "true") {
				var p = encodeURIComponent($.cookie("userPassword"));
				var key = RSAUtils.getKeyPair("010001", "", "0086dd23d3e1fb5660e83468945e851c666d63512b799c4e29694bf54dc7877f1e9787531161c5bad76a16e497f8273136b6336d4919f8d7786e023b4a8b23d1f80a9a524210acfd2b504b4a02043c9d68f51a22ec4c111e2890f185955197301e8089f9bfe047e0e1a84d81d3b1c3f19cf43633264681a0cc60d2812bcd441001");
				//document.LogonForm.userPassword.value=RSAUtils.encryptedString(key, p);
				$("#userPassword").val(RSAUtils.encryptedString(key, p));
			}else{
				if($.cookie("userPassword").length<80){
					var p = encodeURIComponent($.cookie("userPassword"));
					var key = RSAUtils.getKeyPair("010001", "", "0086dd23d3e1fb5660e83468945e851c666d63512b799c4e29694bf54dc7877f1e9787531161c5bad76a16e497f8273136b6336d4919f8d7786e023b4a8b23d1f80a9a524210acfd2b504b4a02043c9d68f51a22ec4c111e2890f185955197301e8089f9bfe047e0e1a84d81d3b1c3f19cf43633264681a0cc60d2812bcd441001");
					$("#userPassword").val(RSAUtils.encryptedString(key, p));
				}
			}
		}
	}
	 var resetPassword = '<%=resetPassword%>';
	 if(resetPassword==1){
	 	document.getElementById("resetPasswordDIV").style.display="block";;
	 }
	 
	
});

function submitForm(){
    if(checkForm()){
		var userName = $("#userAccount").val();
		$.cookie("userAccount", userName, { expires: 365 });
		if ($("input[name='remember']:checked").val()=='1') {
			var passWord = $("#userPassword").val();
			//if ($.cookie("isRsa") == "true") {
			//	passWord = $.cookie("userPassword");
			//}
			if(passWord.length<80){
				var p = encodeURIComponent(passWord);
				var key = RSAUtils.getKeyPair("010001", "", "0086dd23d3e1fb5660e83468945e851c666d63512b799c4e29694bf54dc7877f1e9787531161c5bad76a16e497f8273136b6336d4919f8d7786e023b4a8b23d1f80a9a524210acfd2b504b4a02043c9d68f51a22ec4c111e2890f185955197301e8089f9bfe047e0e1a84d81d3b1c3f19cf43633264681a0cc60d2812bcd441001");
				$.cookie("userPassword", RSAUtils.encryptedString(key, p), { expires: 365 });
			}else{
				$.cookie("userPassword", passWord, { expires: 365 });
			}
			$.cookie("isRemember", "true", { expires: 365 }); 
			//if(passWord.length<80){
				$.cookie("isRsa", "true", { expires: 365 });
			//}else{
			//	$.cookie("isRsa", "false", { expires: 365 });
			//}
		} else {
			$.cookie("isRemember", "false", { expires: -1 });
			$.cookie("userPassword", "", { expires: -1 });
			$.cookie("isRsa", "false", { expires: 365 });
		}
        $('#userPassword').blur();
        
        $('#LogonForm').submit();
    }
}

function checkForm(){
    if($('#userAccount').val()==""){
        whir_alert("<%=Resource.getValue(localeCode,"common","comm.loginremind4")%>！", function(){
            $('#userAccount').focus();
        });
        $('#userAccount').focus();
        return false;
    }else if($('#userPassword').val()==""){
        whir_alert("请输入密码！", function(){
            $('#userPassword').focus();
        });
        $('#userPassword').focus();
        return false;
    }else if($('#captchaAnswer').val()==""){
    	whir_alert("请输入验证码！", function(){
            $('#captchaAnswer').focus();
        });
        $('#captchaAnswer').focus();
        return false;
    }
    return true;
}

function myReset(){
    $('#userAccount').val('');
    $('#userPassword').val('');
}


</script>
<%}else{%>
<%
    String userName = session.getAttribute("userName").toString();
    DateFormat df = DateFormat.getDateInstance(DateFormat.FULL);
    df = DateFormat.getDateInstance(DateFormat.FULL, Locale.CHINA);
    String todayIs = df.format(Calendar.getInstance().getTime());
%>
<div class="wh-portal-i-content">
	<div class="wh-portal-login">
        <h4><%=userName%>，您好，您已登录成功</h4>
        <p class="wh-portal-l-btn"><a href="javascript:void(0)" onClick="javascript:logoutPortal();">注&nbsp;销</a></p>
    </div>
</div>

<form id="LogoutForm" name="LogoutForm" action="<%=rootPath%>/platform/portal.jsp" method="post" target="_parent">
    <input type="hidden" name="_portal_logout" value="1">
    <input type="hidden" name="layoutId" value="<%=layoutId%>">
</form>
<script language="JavaScript">
function logoutPortal(){
    //$('#LogoutForm').submit();
    parent.location.href="<%=rootPath%>/portal.jsp?layoutId=<%=layoutId%>&_portal_logout=1";
}
</script>
<%}%>

<!-- 
<script type="text/javascript">
(function($){
var selects=$('#localeCode');//获取select
for(var i=0;i<selects.length;i++){
	createSelect(selects[i],i);
}
function createSelect(select_container,index){
	//创建select容器，class为select_box，插入到select标签前
	var tag_select=$('<div></div>');//div相当于select标签
	tag_select.attr('class','select_box');
	tag_select.insertBefore(select_container);
	//显示框class为select_showbox,插入到创建的tag_select中
	var select_showbox=$('<div></div>');//显示框
	select_showbox.attr('id','query_input');
	select_showbox.css('cursor','pointer').attr('class','select_showbox').appendTo(tag_select);
	//创建option容器，class为select_option，插入到创建的tag_select中
	var ul_option=$('<ul></ul>');//创建option列表
	ul_option.attr('id','s_option');
	ul_option.attr('class','select_option');
	ul_option.appendTo(tag_select);
	createOptions(index,ul_option);//创建option
	//点击显示框
	/*tag_select.toggle(function(){
		$(this).addClass('on');
		ul_option.slideDown(100);
	},function(){
		$(this).removeClass('on');
		ul_option.slideUp(100);
	});*/
	select_showbox.click(function(){
	if(ul_option.is(":hidden")){
	tag_select.addClass('on');
	ul_option.slideDown(100);
	}else{
	tag_select.removeClass('on');
	ul_option.slideUp(100);
	}
		var inw = $('#query_input').width();
		$('#s_option').width(inw-10);
	})
	
	document.onclick=function(e){ 
    var e=e?e:window.event; 
    var tar = e.srcElement||e.target; 
    if(tar.id!="query_input"){ 
				tag_select.removeClass('on');
                $(".select_option").slideUp(100);
        } 
    }
	
	var li_option=ul_option.find('li');
	li_option.on('click',function(){
		$(this).addClass('selected').siblings().removeClass('selected');
		var value=$(this).text();
		select_showbox.text(value);
		var searchtype = $(this).attr('searchtype');
		$("#searchType").val(searchtype);
		ul_option.hide();
	});
	li_option.hover(function(){
		$(this).addClass('hover').siblings().removeClass('hover');
	},function(){
		li_option.removeClass('hover');
	});
}

function createOptions(index,ul_list){
	//获取被选中的元素并将其值赋值到显示框中
	var options=selects.eq(index).find('option'),
		selected_option=options.filter(':selected'),
		selected_index=selected_option.index(),
		showbox=ul_list.prev();
		showbox.text(selected_option.text());
	//为每个option建立个li并赋值
	for(var n=0;n<options.length;n++){
		var tag_option=$('<li></li>'),//li相当于option
			txt_option=options.eq(n).text();
		tag_option.text(txt_option).css('cursor','pointer').appendTo(ul_list);
		tag_option.attr('searchtype',options.eq(n).val());
		//为被选中的元素添加class为selected
		if(n==selected_index){
			tag_option.attr('class','selected');
		}
	}
}
})(jQuery)

</script> -->
<script>
<%
String errorType=request.getParameter("errorType");
 if("nokey".equals(errorType)){
	session.invalidate();
%>
    whir_alert("<%=Resource.getValue(localeCode,"common","comm.nokey")%>",null);
<%}
 if("keyErr".equals(errorType)){
	session.invalidate();
%>
	whir_alert("<%=Resource.getValue(localeCode,"common","comm.keyerror")%>",null);
<%}
 
%>

</script>
