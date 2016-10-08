<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="com.whir.org.common.util.SysSetupReader"%>




<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><s:text name="personalset.passwordmodi" /></title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/modules/personal/setup/personal_myPassword_js.js" type="text/javascript"></script>
</head>
<% String domainId = com.whir.common.util.CommonUtils.getSessionDomainId(request) + "";
com.whir.org.bd.usermanager.UserBD userbd = new com.whir.org.bd.usermanager.UserBD();
int isChangePwd_admin = (userbd.getIsChangePwdByUserAccounts("admin")).intValue();
int isChangePwd_sys = (userbd.getIsChangePwdByUserAccounts("sys")).intValue();
int isChangePwd_security = (userbd.getIsChangePwdByUserAccounts("security")).intValue();
int isChangePwd_webservice=1;
SysSetupReader sysRed = SysSetupReader.getInstance();
//sysRed.init(domainId);
String vkey = sysRed.getOa_vkey(domainId);
String zz1="[^a-zA-Z0-9]";
String zz2="[^`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]";

//true 表示密码符合规则
boolean b = vkey.replaceAll(zz1, "").length()!=0&&vkey.length()>6&&vkey.replaceAll(zz2, "").length()!=0;
if("".equals(vkey)||vkey==null){
				isChangePwd_webservice=0;
}else if(!b){
			isChangePwd_webservice=0;
}
/*String web_inf = getServletContext().getRealPath("/WEB-INF/");
 File file = new java.io.File(web_inf+"/classes/ServiceParse.xml");
					BufferedReader br = new BufferedReader(new InputStreamReader(
							new FileInputStream(file)));
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
 
%>
<body class="Pupwin">
    <div class="BodyMargin_10">  
        <div class="docBoxNoPanel">
            <s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
                <%@ include file="/public/include/form_detail.jsp"%>
                                   
               
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                <%if(isChangePwd_admin==0){%>
	                    <tr>  
	                        <td  width="100" class="td_lefttitle">  
	                            admin账号密码<span class="MustFillColor">*</span>：  
	                        </td>  
	                        <td>  
	                            <s:password name="adminPassword" id="adminPassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
	                        </td>  
	                    </tr> 
                    <%} %> 
                    <%if(isChangePwd_sys==0){%>
                    <tr>  
                        <td  width="100" class="td_lefttitle">  
                            sys账号密码<span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password name="sysPassword" id="sysPassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
                        </td>  
                    </tr> 
                    <%} %>
                    <%if(isChangePwd_security==0){%> 
                    <tr>  
                        <td  width="100" class="td_lefttitle">  
                            security账号密码<span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password name="securityPassword" id="securityPassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
                        </td>  
                    </tr>
                    <%} %> 
                    <%if(isChangePwd_webservice==0){%> 
                    <tr>  
                        <td  width="100" class="td_lefttitle">  
                            web service账号密码<span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password name="webservicePassword" id="webservicePassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
                        </td>  
                    </tr>
                    <%} %> 
                    <%if(false){%> 
                    <tr>  
                        <td  width="100" class="td_lefttitle">  
                            evo app控制台密码<span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password name="evoappPassword" id="evoappPassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
                        </td>  
                    </tr>  
                    <%} %>
                    <tr>  
                        <td  width="100" class="td_lefttitle">  
                           
                        </td>  
                        <td>  
                            所有密码要求6位以上，且包含数字、字符及字母 
                        </td>  
                    </tr>  
                    <tr class="Table_nobttomline"> 
                        <td nowrap="nowrap">&nbsp;</td> 
                        <td nowrap>  
                            <input type="button" class="btnButton4font" onClick="savePassword(this)" value='<s:text name="comm.save"/>' />
                           <!--  <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' /> -->  
                        </td>  
                    </tr>  
                </table>  
            </s:form>
        </div>
    </div>
</body>

<script type="text/javascript">

$(document).ready(function(){
    if(initModiForm()){
        //设置表单为异步提交
        initDataFormToAjax({"dataForm":'dataForm', "tip":'<s:text name="personalwork.save" />'});
    }
});

function savePassword(form){
	var  isChangePwd_admin = '<%=isChangePwd_admin%>'; 
	var isChangePwd_sys  = '<%=isChangePwd_sys%>';
	var isChangePwd_security = '<%=isChangePwd_security%>';
	var isChangePwd_webservice = '<%=isChangePwd_webservice%>';
	
	var adminPassword="";
	var sysPassword="";
	var securityPassword="";
	var webservicePassword="";
	var err="";
    var reChars = /[a-zA-Z]+/i;
    var reNums = /[0-9]+/i;
    var reSpecialChars = /[\!\@\#\$\%|^\&\*\(\)\+\|\\|?\/\>\<\.\,\~]+/i;//验证是否包含了特殊字符
   // alert(isChangePwd_admin+isChangePwd_sys+isChangePwd_security+isChangePwd_webservice);
    var datastr={};
	if(isChangePwd_admin==0){
		 adminPassword = $.trim($('#adminPassword').val());
		 if(adminPassword.length<6){
		 	err=err+"位数不够    ";
		 }
		 if(!reNums.test(adminPassword)){
		 	err=err+"未包含数字    ";
		 }
		  if(!reChars.test(adminPassword)){
		 	err=err+"未包含字母    ";
		 }
		  if(!reSpecialChars.test(adminPassword)){
		 	err=err+"未包含字符";
		 }
		 if(err!=""){
		 	 whir_poshytip($('#adminPassword'), err);
         	 $('#adminPassword').focus();
         	 return false;
		 }
		 datastr["adminPassword"] = adminPassword; 
	}
	if(isChangePwd_sys==0){
		 sysPassword = $.trim($('#sysPassword').val());
		  if(sysPassword.length<6){
		 	err=err+"位数不够    ";
		 }
		 if(!reNums.test(sysPassword)){
		 	err=err+"未包含数字    ";
		 }
		  if(!reChars.test(sysPassword)){
		 	err=err+"未包含字母    ";
		 }
		  if(!reSpecialChars.test(sysPassword)){
		 	err=err+"未包含字符";
		 }
		 if(err!=""){
		 	 whir_poshytip($('#sysPassword'), err);
         	 $('#sysPassword').focus();
         	 return false;
		 }
		 datastr["sysPassword"] = sysPassword;
	}
	if(isChangePwd_security==0){
		 securityPassword = $.trim($('#securityPassword').val());
		  if(securityPassword.length<6){
		 	err=err+"位数不够    ";
		 }
		 if(!reNums.test(securityPassword)){
		 	err=err+"未包含数字    ";
		 }
		  if(!reChars.test(securityPassword)){
		 	err=err+"未包含字母    ";
		 }
		  if(!reSpecialChars.test(securityPassword)){
		 	err=err+"未包含字符";
		 }
		 if(err!=""){
		 	 whir_poshytip($('#securityPassword'), err);
         	 $('#securityPassword').focus();
         	 return false;
		 }
		 datastr["securityPassword"] = securityPassword;
	}
	if(isChangePwd_webservice==0){
		 webservicePassword = $.trim($('#webservicePassword').val());
		  if(webservicePassword.indexOf("&")>-1){
			 whir_poshytip($('#webservicePassword'), "web service账号密码不可包含&符号！");
			  return false;
		 }
		 
		   if(webservicePassword.length<6){
		 	err=err+"位数不够    ";
		 }
		 if(!reNums.test(webservicePassword)){
		 	err=err+"未包含数字    ";
		 }
		  if(!reChars.test(webservicePassword)){
		 	err=err+"未包含字母    ";
		 }
		  if(!reSpecialChars.test(webservicePassword)){
		 	err=err+"未包含字符";
		 }
		 if(err!=""){
		 	 whir_poshytip($('#webservicePassword'), err);
         	 $('#webservicePassword').focus();
         	 return false;
		 }
		 datastr["webservicePassword"] = webservicePassword;
	}
	//var datastr={"adminPassword":adminPassword,"sysPassword":sysPassword,"securityPassword":securityPassword,"webservicePassword":webservicePassword};
	
	$.ajax({
			url: "/defaultroot/MyInfoAction!updateSuperUserPassword.action",
			cache: false,
			async: true,
			data:datastr,
			success: function(dataForm) {
				var data = eval('('+dataForm+')');
				if(data.result=="true"){
				  whir_alert("保存成功 ！",function(){
				  	  if(isChangePwd_admin!=1){
				  		$('#adminPassword').val("");
				  	  }
				  	  if(isChangePwd_sys!=1){
				  		$('#sysPassword').val("");
				  	  }
				  	  if(isChangePwd_security!=1){
				  		$('#securityPassword').val("");
				  	  }
				  	  if(isChangePwd_webservice!=1){
				  		$('#webservicePassword').val("");
				  	  }
				  });
				}else{
					var errName = data.data.errName;
					whir_alert(errName+"账号密码保存失败 ,请稍后再试 ！",function(){
						resetDataForm(form);
					});
					
				}
			}
		});
}
</script>

</html>
