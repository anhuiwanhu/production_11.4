<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.whir.ezoffice.desktop.bd.DesktopBD"%>
<%@ page import = "com.whir.integration.realtimemessage.cocall.CocallSendMessage"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
if(session.getAttribute("hasLoged")==null){
    String userAccount=session.getAttribute("userAccount").toString();
	String userId=session.getAttribute("userId").toString();
	String userName=session.getAttribute("userName").toString();
	String orgName=session.getAttribute("orgName").toString();
	String domainId=session.getAttribute("domainId").toString();
	String remoteIP=session.getAttribute("userIP").toString();//request.getRemoteAddr();

	//记录用户登录信息
	com.whir.ezoffice.security.log.bd.LogBD logBD=new com.whir.ezoffice.security.log.bd.LogBD();
	java.util.Date date=new java.util.Date();
	logBD.log(userId,userName,orgName,"oa_index","首页",date,date,"0","",remoteIP,domainId);

	session.setAttribute("hasLoged","yes");
	com.whir.integration.realtimemessage.Realtimemessage util=new com.whir.integration.realtimemessage.Realtimemessage();
	//取得当前用户是否设置为rtx单点登录
		com.whir.org.bd.usermanager.UserBD userBD=new com.whir.org.bd.usermanager.UserBD();

	if(util.getUsed()){
        String type=util.getType();

		if("rtx".equals(type)||"rtx_http".equals(type)){
			
			if(userBD.getRtxLogin(userId)){
				//取rtx登录信息
				String ip = util.getServerDN();
				String key= util.getSessionKey(userAccount);
				if(!"".equals(key)){

%>
<html>
    <head>
    </head>
    <body OnLoad="Logon2006();">
        <OBJECT classid=clsid:5EEEA87D-160E-4A2D-8427-B6C333FEDA4D id=RTXAX></OBJECT>
    </body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
//RTX2006的登录方式
function Logon2006(){
  try{
       var key="<%=key%>";
       var account="<%=userAccount%>";
       var ip="<%=ip%>";
       var RTXCRoot = RTXAX.GetObject("KernalRoot");  //客户端SDK
       RTXCRoot.LoginSessionKey(ip,8000,account,key);
  }catch(e){
  }
}
//-->
</SCRIPT>
<script language="vbscript">
'RTX3.61及一下版本的登录方式
Sub Logon3X()
    ip="<%=ip%>"
    key="<%=key%>"
    account="<%=userAccount%>"

    on error resume next
    Set objProp = RTXAX.GetObject("Property")

    objProp.Value("RTXUsername") = account
    objProp.Value("LoginSessionKey") = key
    objProp.Value("ServerAddress") = ip
    objProp.Value("ServerPort") = 8000
    RTXAX.Call 2, objProp
    If Err.Number <> 0 Then
        'MsgBox "Error # " & CStr(Err.Number) & " " & Err.Description
        'Err.Clear
        'Clear the error.
    End If
End Sub
</script>
<%				}
			}
		}else if("ucStar".equals(type)){

           if(userBD.getRtxLogin(userId)){

%>
<OBJECT id="UcStar" classid=clsid:2532DED7-AB04-4D70-9D0C-1FB71F13323F>
    <PARAM NAME="_Version" VALUE="65536">
    <PARAM NAME="_ExtentX" VALUE="2646">
    <PARAM NAME="_ExtentY" VALUE="1323">
    <PARAM NAME="_StockProps" VALUE="0">
</OBJECT>
<script>
function runUcstar(username,sessionkey) { 
	//设定登录的服务器地址和端口，缺省不调用的话用的是客户端设定的服务器地址和端口
	/*
	try {
		UcStar.SetUcStarHost("127.0.0.1","5200");
	} catch(e) {
		
	}
	*/
	//启动ucstar客户端程序，调用的是activex控件
	try {
		UcStar.StartUcStar(username,sessionkey); 
	} catch(e) {
		alert("请先安装UcStar客户端！");
	}
}
</script>
<%
        //修改登录参数设置
        String host = util.getServerDN();
        String port = util.getPort();

        //单点登录
        String ssoLoginUrl = "http://" + host + ":" + port + "/sso-login.jsp"; //单点登陆地址
        String ssoGetSessionUrl = "http://" + host + ":" + port + "/sso-getsessionkey.jsp"; //取sessionkey地址
        String sessionKey = ""; //sessionkey
        try {
            URL url = new URL(ssoGetSessionUrl + "?username=" + userAccount);
            BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream())); // 得到页面的信息流
            sessionKey = br.readLine(); // 读取数据
            //out.println(sessionKey);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //判断sessionkey存在则直接进行单点登陆
        if (sessionKey != null && sessionKey.length() > 0) {
%>
<script>
    runUcstar('<%=userAccount%>','<%=sessionKey%>');
</script>
<%
            }

          }

		}else if("eLink".equals(type)){

          if(userBD.getRtxLogin(userId)){

            String host = util.getServerDN();
            String port = util.getPort();

            com.whir.integration.realtimemessage.elink.ELinkApi el = new com.whir.integration.realtimemessage.elink.ELinkApi();
            String[] allLoginUser = el.getAllLoginUser(host,port);
            
            boolean elinkHasLoged = true;
			if(allLoginUser!=null){

				for(int i=0; i< allLoginUser.length;i++){
					if(allLoginUser[i].indexOf(userAccount+"@")>-1){
					   elinkHasLoged = false;
					}
				}
				
				if(elinkHasLoged){

					String pass = com.whir.common.util.CommonUtils.decryptPassword(session.getAttribute("userPassword").toString());
%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="<%=rootPath%>/public/desktop/js/PEEIMUtil.js"></script>
    </head>
    <body>
        <SCRIPT LANGUAGE="JavaScript">
           PEEIM.RunEim('<%=userAccount%>','<%=pass%>');
        //-->
        </SCRIPT>
    </body>
</html>
	<%
                }
		   
		   }

		 }

      }else if("cocall".equals(type)){
		  CocallSendMessage cocall = new CocallSendMessage();
		  Map logmap = cocall.getToken(userAccount);
		  String cocallstatus = cocall.getStatus(userAccount);

		  if(userBD.getRtxLogin(userId)&&"0".equals(cocallstatus)){
%>

<html>
 <body>
  <script type="text/javascript">
    window.location.href="thunisoft://cocall/login?uid=<%=logmap.get("Uid")%>&token=<%=logmap.get("Token")%>&server=<%=logmap.get("CocallServer")%>&port=<%=logmap.get("CocallURLPort")%>";
  </script>
 </body>
</html>

<%
		  }

	  }else{

            if(session.getAttribute("imID") != null){
                String gid=session.getAttribute("imID").toString();
                String pwd=com.whir.common.util.CommonUtils.decryptPassword(session.getAttribute("userPassword").toString());
                if(!gid.equals("") && userBD.getRtxLogin(userId)){
                    //gk 登录
                    pwd=new com.whir.common.util.MD5().toMD5(pwd);
			  %>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>						
    </body>
</html>
<SCRIPT LANGUAGE="JavaScript">
<!--
    var t=setTimeout("logGK()",300);

    function logGK(){
        if(check_elava_installed()){
            window.location.href="elava://login?gid=<%=util.getZoneID()%>.<%=gid%>&pwd=<%=pwd%>";
        }
    }

    function check_elava_installed(){
        var isinstalled = false;
        var obj = null;
        try { 
            obj = new ActiveXObject("LAVACTRL.LavaCtrlCtrl.1");
            isinstalled = (obj)?true:false;
        }catch(e){
            obj = null;
        }
        return isinstalled;
    }
//-->
</SCRIPT>
		   <%
                }
            }

        }//end if(type=="gk")
    }//end if(getUseed()) //设置使用即时通讯工具
}%>