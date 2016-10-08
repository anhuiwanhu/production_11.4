<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored ="false" %>
<%
String jumpUrl = request.getParameter("jumpUrl")== null?"":request.getParameter("jumpUrl");
jumpUrl = java.net.URLDecoder.decode(jumpUrl,"UTF-8");
String info = request.getParameter("info") == null?"":request.getParameter("info");
info = java.net.URLDecoder.decode(info,"UTF-8");
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>验证页面</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" /> 
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/> 
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.zepto.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.core.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.datetime.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.select.js"></script>
    <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.ios7.js"></script> 
</head>
<body>
<section class="wh-section wh-section-bottomfixed">
    <article class="wh-edit wh-edit-forum"> 
            <div class="wh-file-validate-img"> 
            </div>
            <div class="wh-container">
                <div class="wh-file-validate"> 
                    <form id="sendForm" class="dialog" action="/defaultroot/synOrgAndEmp/loginFromOut.controller" method="post">
                        <input type="text" name="username"  placeholder="请输入您的OA账号"  class="username" />
                        <input type="password" name="pass"  placeholder="请输入您的OA密码"  class="pass" />
                        <input type="hidden" value="<%=jumpUrl%>" name="jumpUrl"/>
                        <input type="submit" name="submit" value="验证并访问" class="sub" onclick="sendFlow()"/>
                    </form>
					<p class="validate-info"><%=info%></p>
                </div>
            </div>
    </article> 
</section>
</body>
<script type="text/javascript">
	function send(){
		$('#sendForm').submit();		
	}
</script>
</html>