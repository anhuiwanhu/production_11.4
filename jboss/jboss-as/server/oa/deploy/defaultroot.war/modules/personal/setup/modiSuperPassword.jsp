<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
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
	<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/security/security.js"></script>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">  
        <div class="docBoxNoPanel">
            <s:form name="dataForm" id="dataForm" action="MyInfoAction!updateSuperPassword.action" method="post" theme="simple" >
				<!--滑动标签开始-->
    <div class="Public_tag">
        <ul id="whir_tab_ul">
            <li class="tag_aon" whir-options="{target:'tab0'}" id="base" onclick="confirmChangeTag(this)" value="admin"><span class="tag_center" >admin</span><span class="tag_right"></span>

            </li>
            <li whir-options="{target:'tab1'}" id="rights" onclick="confirmChangeTag(this)" value="sys"><span class="tag_center">sys</span><span class="tag_right"></span>

            </li>
            <li whir-options="{target:'tab1'}" id="rights" onclick="confirmChangeTag(this)" value="security"><span class="tag_center">security</span><span class="tag_right"></span>

            </li>
			 <li whir-options="{target:'tab1'}" id="rights" onclick="confirmChangeTag(this)" value="webservice" ><span class="tag_center">web service</span><span class="tag_right"></span>

            </li>
           
           
        </ul>
    </div>
    <!--滑动标签结束-->
                <%@ include file="/public/include/form_detail.jsp"%>
                                    
                <input type="hidden" name="account" id="account" value="admin"/>  
                <s:hidden id="isPasswordRule" value="%{#request.isPasswordRule}"/>
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for='<s:text name="personalset.oldpassword"/>' width="100" class="td_lefttitle">  
                            <s:text name="personalset.oldpassword"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password name="oldMyPassword" id="oldMyPassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalset.newpassword"/>' width="100" class="td_lefttitle">  
                            <s:text name="personalset.newpassword"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password name="newMyPassword" id="newMyPassword" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalset.confirm"/>' width="100" class="td_lefttitle">  
                            <s:text name="personalset.confirm"/><span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:password id="newMyPasswordConfirm" cssClass="inputText" whir-options="vtype:[{'maxLength':20, 'minLength':6}]" cssStyle="width:28%;" />
                        </td>  
                    </tr>  
                    <tr id="isPasswordRule_TR">
                        <td nowrap="nowrap">&nbsp;</td>
                        <td><s:text name="personalinfo.Passwordrules" /></td>
                    </tr>
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
                            <input type="button" class="btnButton4font" onClick="if(checkForm2()){if(checkForm()){ok(1,this);}}" value='<s:text name="comm.save"/>' id="savebutton" />
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
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
var o ;
function confirmChangeTag(obj){
	o=obj;
	whir_confirm('您的操作需要保存吗？',yesConfirm,noConfirm);
}
function yesConfirm(){

	if(checkForm2()){if(checkForm()){
		var flag2 = false;
		var savebutton = $('#savebutton');
		if(!flag2){
			ok(1,savebutton);
			
			flag2=true;
		}
		if(flag2){
			changerTag(o);
		}
		
		
	}}
}
function noConfirm(){

	changerTag(o);
}
function changerTag(obj){
	var li = $('#whir_tab_ul li');
	for(var i=0;i<li.length;i++){
		li.attr("class","");
	}
	$(obj).attr("class","tag_aon");
	var acc = obj.getAttribute("value");
	
	$('#account').val(acc);
	$("#newMyPassword").val('');
	$("#oldMyPassword").val('');
	$("#newMyPasswordConfirm").val('');
	
}

function checkForm2(){
	var newMyPassword = $("#newMyPassword").val();
	
	var err="";
	var reChars = /[a-zA-Z]+/i;
    var reNums = /[0-9]+/i;
    var reSpecialChars = /[\!\@\#\$\%|^\&\*\(\)\+\|\\|?\/\>\<\.\,\~\-\_]+/i;//验证是否包含了特殊字符
	if(newMyPassword.length<6){
		 	err="密码位数不够，请重新输入!";
			whir_alert(err, function(){$("#newMyPassword").focus();});
			return false;
	}
	 if(!reNums.test(newMyPassword)){
		err="密码未包含数字，请重新输入!";
		whir_alert(err, function(){$("#newMyPassword").focus();});
		return false;
	 }
	  if(!reChars.test(newMyPassword)){
		err="密码未包含字母，请重新输入！";
		whir_alert(err, function(){$("#newMyPassword").focus();});
		return false;
	 }
	  if(!reSpecialChars.test(newMyPassword)){
		err="密码未包含字符，请重新输入！";
		whir_alert(err, function(){$("#newMyPassword").focus();});
		return false;
	 }
	 return true;
}
</script>

</html>
