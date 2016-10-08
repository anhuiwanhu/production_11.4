<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%String id=request.getParameter("id");
	String appid = request.getParameter("appid");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
<title>默认功能</title>  
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
<%@ include file="/public/include/meta_base.jsp"%>  
<%@ include file="/public/include/meta_list.jsp"%>  
<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>  

<body class="MainFrameBox">  
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="queryForm" id="queryForm" action="" method="post">

<!-- SEARCH PART START -->  
<%@ include file="/public/include/form_list.jsp"%>  

<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
    <tr>  
        
        <td class="SearchBar_toolbar">  
           <input type="radio" value="address_appid" id="address_appid" name="selectapp" data="通讯录" >通讯录&nbsp;&nbsp;&nbsp;&nbsp;</input>
           <input type="radio" value="information_appid" id="information_appid" name="selectapp" data="信息">信息&nbsp;&nbsp;&nbsp;&nbsp;</input>
           <input type="radio" value="workflow_appid" id="workflow_appid" name="selectapp" data="文件办理">文件办理&nbsp;&nbsp;&nbsp;&nbsp;</input>
           <input type="radio" value="govdocument_appid" id="govdocument_appid" name="selectapp" data="公文" >公文&nbsp;&nbsp;&nbsp;&nbsp;</input>
           <input type="radio" value="mail_appid" id="mail_appid" name="selectapp" data="内部邮件">内部邮件&nbsp;&nbsp;&nbsp;&nbsp;</input>
           <input type="radio" value="forum_appid" id="forum_appid" name="selectapp" data="论坛">论坛&nbsp;&nbsp;&nbsp;&nbsp;</input>
		   <input type="radio" value="meet_appid" id="meet_appid" name="selectapp" data="会议助手">会议助手&nbsp;&nbsp;&nbsp;&nbsp;</input>
        </td>
        <td nowrap>  
       	 	<input type="button" class="btnButton4font"  onclick="save();"  value="确  定" />  
    	</td>
    </tr>  
</table>  

</s:form>  

</body>  

<script type="text/javascript">
//---判断是否存在--start
var appids = '<%=appid%>';
appids=appids.substring(3,appids.length);
var appidarray = new Array();
appidarray = appids.split("***");

for(var i=0;i<appidarray.length;i++){
	var id =appidarray[i];
	$('#'+id).attr("disabled","disabled");
}
//---判断是否存在--end


function save(){
	var id = '<%=id%>';
	var id_name = id.replace("_a_", "_appname_");
	var id_id = id.replace("_a_", "_appid_");
 	var inputname = opener.document.getElementById(id_name);
 	var inputid = opener.document.getElementById(id_id);
 	var radio = $('input[type="radio"]');
 	for(var i=0;i<radio.length;i++){
 		if(radio[i].checked){
 		
 			var value = radio[i].value;
 			var text = radio[i].getAttribute('data');
 			$(inputname).val(text);
 			$(inputid).val(value);
 			//inputname.value=text;
 			//inputid.value=value;
 			// whir_alert("选择成功 ！",function(){ window.close();});
 			 window.close();
 		}
 	}
 	
	}
</script>
</html>