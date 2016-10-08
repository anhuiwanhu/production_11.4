<%
    //取生日贺卡
	List birthList = new com.whir.ezoffice.subsidiarywork.bd.BirthCardBD().getBirthCard(userId, orgIdString);
    if(birthList!=null&&birthList.size()>0){
	    for(int i=0;i<birthList.size();i++){
		    Object[] obj =(Object[])birthList.get(i);
%>
	<script>
	    openWin({url:encodeURI('<%=rootPath%>/hrmbirthcard!birthdaycard_show.action?id=<%=obj[0]%>&ispop=yes'),winName:'birth<%=i%>',width:700,height:520});
	</script>
<%}}%>

<%
	//取节日贺卡
	List list = new com.whir.ezoffice.subsidiarywork.bd.FestalCardBD().getFestalCard(userId, orgIdString);
    if(list!=null&&list.size()>0){
	    for(int i=0;i<list.size();i++){
		Object[] obj =(Object[])list.get(i);
%>
	<script>
	    openWin({url:encodeURI('<%=rootPath%>/hrmfestalcard!festivalcard_show.action?id=<%=obj[0]%>&ispop=yes'),winName:'festival<%=i%>',width:700,height:520});
	</script>
<%}}%> 
<link   href="<%=rootPath%>/scripts/desktop/popwin.css" rel="stylesheet" type="text/css"/>
<SCRIPT LANGUAGE="JavaScript" src="<%=rootPath%>/scripts/desktop/popwin.js"></SCRIPT>
<iframe id="logoutIframe" style="display:none"></iframe>
<SCRIPT LANGUAGE="JavaScript">
<!--
<%
com.whir.org.bd.usermanager.UserBD userbd = new com.whir.org.bd.usermanager.UserBD();
if(session.getAttribute("userId")!=null){
	String userAccounts=session.getAttribute("userAccount").toString();
	if(!"admin".equals(userAccounts)&&!"sys".equals(userAccounts)&&!"security".equals(userAccounts)){
	    String isAdCheck = userbd.getIsAdCheckByAccount(session.getAttribute("userAccount").toString());
	    if(!"1".equals(isAdCheck)){//非AD验证，首次登录提示修改密码
	        int isChangePwd = (userbd.getIsChangePwd(userId)).intValue();
	        if(isChangePwd == 0){
				%>
				var _isAlert = false;
				function jumpPwd(){
					if(document.getElementById("mainFrame").readyState!="complete"){
						setTimeout("jumpPwd()",1000,"javascript");
					}
				    if(_isAlert==false){
				        _isAlert = true;
					    whir_alert("<bean:message bundle="common" key="comm.firstLoginMsg"/>");
					    jumpnew('/modules/personal/personal_menu.jsp','/MyInfoAction!modiMyPassword.action');
				    }
				}
				setTimeout("jumpPwd()",1000,"javascript");
			<%}
		}
	}else{
		int isChangePwd_admin = (userbd.getIsChangePwdByUserAccounts("admin")).intValue();
		int isChangePwd_sys = (userbd.getIsChangePwdByUserAccounts("sys")).intValue();
		int isChangePwd_security = (userbd.getIsChangePwdByUserAccounts("security")).intValue();
		int isChangePwd_webservice =1;
		/*String web_inf = getServletContext().getRealPath("/WEB-INF/");
		java.io.File file2 = new java.io.File(web_inf+"/classes/ServiceParse.xml");
					java.io.BufferedReader br = new java.io.BufferedReader(new java.io.InputStreamReader(
							new java.io.FileInputStream(file2)));
					List list2 =new ArrayList();
					//定义一个集合存放每一行的字符串
					while(true){
						String str=br.readLine();
						//读取文件当中的一行
						if(str==null) break;
						//如果读取的是空，也就是文件读取结束 跳出循环
						int index2=str.indexOf("<vkey>whir2011</vkey>");
						if(index2!=-1){
						//原始密码
							isChangePwd_webservice=0;
						}
					}
					br.close();
			*/
		//从数据库读取oa_vkey
		//String domainId = com.whir.common.util.CommonUtils.getSessionDomainId(request) + "";
		com.whir.org.common.util.SysSetupReader sysRed = com.whir.org.common.util.SysSetupReader.getInstance();
		//sysRed.init(domainId);
		String vkey = sysRed.getOa_vkey(domainId);
		String zz1="[^a-zA-Z0-9]";
		String zz2="[^`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？_-]";
		
		//true 表示密码符合规则
		boolean b = vkey.replaceAll(zz1, "").length()!=0&&vkey.length()>6&&vkey.replaceAll(zz2, "").length()!=0;
		if("".equals(vkey)||vkey==null){
				isChangePwd_webservice=0;
		}else if(!b){
			isChangePwd_webservice=0;
		}	
		
		if(isChangePwd_admin*isChangePwd_sys*isChangePwd_security*isChangePwd_webservice==0){%>
			var _isAlert = false;
			function jumpPwd2(){
				if(document.getElementById("mainFrame").readyState!="complete"){
					setTimeout("jumpPwd2()",1000,"javascript");
				}
			    if(_isAlert==false){
			        _isAlert = true;
				    whir_alert("<bean:message bundle="common" key="comm.firstLoginMsg"/>");
				    jumpnew('/modules/personal/personal_menu.jsp','/MyInfoAction!modiSuperAccountPassword.action');
			    }
			}
			setTimeout("jumpPwd2()",1000,"javascript");
		<%}
	}
}%>

<%if(session.getAttribute("_portal_flag")!=null){%>
setCookie("ezofficeUserPortal", "1", expdate, "/", null, false);
function reLog(){
	location.href="<%=rootPath%>/portal.jsp?_portal_logout=1";
}
<%}else{%>
try{
    setCookie("ezofficeUserPortal", "", expdate, "/", null, false);
}catch(E){}
<%}%>
//-->
</SCRIPT>