<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%@ page import="com.whir.org.vo.MoveOAmanager.CorpSetAppPO" %>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String 	corpid1 = com.whir.component.config.ConfigReader.getReader().getAttribute("Weixin", "corpid");
String corpid2 = (String)(session.getAttribute("corpid")==null?"":session.getAttribute("corpid"));
//if(corpid.equals(session.getAttribute("corpid")) ||( request.getParameter("appId") != null && request.getParameter("appId").equals(corpid)) ){
//	session.setAttribute("corpid",corpid);
List<CorpSetAppPO> csapppolist	= (List<CorpSetAppPO>)request.getAttribute("csapppolist");
String relactionId =(String)(request.getAttribute("relactionId")==null? "empId":request.getAttribute("relactionId"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
   	<link rel="stylesheet" href="/defaultroot/templates/template_default/common/css/template.fa.css" />
   	<link rel="stylesheet" href="/defaultroot/templates/template_system/common/css/template.reset.css" />
	<link rel="stylesheet" href="/defaultroot/templates/template_default/common/css/template.style.css" />
   	<link rel="stylesheet" href="/defaultroot/templates/template_default/themes/2015/color_default/template.keyframe.default.css" />
	<link rel="stylesheet" href="/defaultroot/templates/template_default/themes/2015/color_default/template.color.default.css" />
   
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
</head>
<body class="Pupwin">
	<div class="Public_tag">  
		<ul>  
			<li id="enterprisenumberLI" class="tag_aon" onclick="enterprisenumberLI()" ><span class="tag_center">微信企业号管理</span><span class="tag_right"></span></li>
			<li  id="evoLI" onclick="evoLI()" ><span class="tag_center">evo客户端管理</span><span class="tag_right"></span></li>
		</ul>  
	</div>
<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">

	<s:form id="corpsetForm" name="corpsetForm" action="" method="post">

	<table width="98%" border="0" cellpadding="0" cellspacing="0"  class="Table_bottomline">  
		<tr>
			<td class="td_lefttitle" width="100%" ><span style="font-size:15px">1.建立连接</span> </td>  
		</tr>
		<tr>
			<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					
					<td width="4%"></td>
					<td width="17%">  
						填写企业号CorpID <span class="MustFillColor">*</span> ：
					</td>
					<td width="30%">
						<s:hidden name="cspo.id" id="id" />
						<s:textfield type="text" id="corpid" cssClass="inputText" name="cspo.corpid" 
					 	 whir-options="vtype:['notempty',{},'spechar3'],'promptText':'企业号后台-设置-账号信息'" class="inputText" 
					 	 
					 	/>  
					</td>
					<td width="3%"></td>
					<td width="50%">
						<input style="display:none" type="button" id="checkcorpid" class="btnButton4font"  onclick="corpidcheck()"   value="验  证" /> 
					</td>
				</tr>
				<tr>
					<td width="4%"></td>
					<td width="17%">  
						填写管理员Corpsecret <span class="MustFillColor">*</span> ：
					</td>
					<td width="35%">
						<s:textfield type="text" id="corpsecret" Class="inputText" name="cspo.corpsecret" 
					 	 whir-options="vtype:['notempty',{},'spechar3'],'promptText':'企业号后台-设置-权限管理-新建管理员组后即可查看'" class="inputText"/>  
					</td>
					<td width="40%">
					</td>
				</tr>
				<tr>
					<td width="4%"></td>
					<td width="17%">  
						填写应用Token <span class="MustFillColor">*</span> ：
					</td>
					<td width="35%">
						<s:textfield type="text" id="token" Class="inputText" name="cspo.token"  
					 	 whir-options="vtype:['notempty',{},'spechar3'],'promptText':'企业号后台-应用中心-创建应用-回调模式-回调URL及密钥'" class="inputText"/>  
					</td>
					<td width="40%">
					</td>
				</tr>
				<tr>
					<td width="4%"></td>
					<td width="25%">  
						填写应用EncodingAESKey <span class="MustFillColor">*</span> ：
					</td>
					<td width="38%">
						<s:textfield type="text" id="encodingAESKey" Class="inputText" name="cspo.encodingAESKey"  
					 	 whir-options="vtype:['notempty',{},'spechar3'],'promptText':'企业号后台-应用中心-创建应用-回调模式-回调URL及密钥'" />  
					</td>
					<td width="30%">
					</td>
				</tr>
				<tr style="display:">
					<td width="4%"></td>
					<td width="20%">  
						设置关联ID ：
					</td>
					<td width="30%">
						
						<input type="radio" value="empId" id="relactionId1" name="relactionId"  <%if("empId".equals(relactionId)){%>checked<%}%>>&nbsp;empId&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" value="userAccount" id="relactionId2" name="relactionId"  <%if("userAccount".equals(relactionId)){%>checked<%}%>>&nbsp;OA账号(不支持中文)&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" value="userSimpleName" id="relactionId3" name="relactionId"  <%if("userSimpleName".equals(relactionId)){%>checked<%}%>>&nbsp;用户简码&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" value="empIdCard" id="relactionId4" name="relactionId"  <%if("empIdCard".equals(relactionId)){%>checked<%}%>>&nbsp;身份证号 
					</td>
					<td width="43%">
					</td>
				</tr>
				<tr>
					<td width="4%"></td>
					<td width="10%">
						<input type="button" id="checkcorpid" class="btnButton4font"  onclick="updatecorpset()"   value="同步配置" />  
					</td>
				</tr>
			</table>
			</td>
		</tr>
		
		<tr>
			<td class="td_lefttitle" width="100%" ><span style="font-size:15px">2.同步数据</span> </td>  
		</tr>
		<tr>
			<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="4%"></td>
					<td width="12%">  
						<input  type="button" id="user_org_syn_button" class="btnButton4font"  onclick="synAll()"  value="同步组织用户" />  
					</td>
					
					<td width="80%" id="resultStr">
						
					</td>
				</tr>
				<tr style="height:10px;"></tr>
				<tr id="synErrorLog" >
					<td width="4%"></td>
					<td colspan="2" >
						<a href="javascript:void(0)" onclick="javascript:openWin({url:'MoveOAmanager!getUserLogList.action',winName:'synErrorLog',height:600,width:900});"><font color=blue>&nbsp;&nbsp;&nbsp;&nbsp;查看失败日志</font></a>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</s:form> 
<s:form id="corpsetappForm" name="corpsetappForm" action="" method="post">

	<table width="98%" border="0" cellpadding="0" cellspacing="0"  class="Table_bottomline">  
		<tr>
			<td class="td_lefttitle" width="100%" ><span style="font-size:15px">3.功能配置</span> </td>  
		</tr>
		<tr>
			<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id="corpsetappname_table">
				<tr>
					<td width="4%"></td>
					
					<td width="20%">
						<span class="MustFillColor">请先在企业号内创建该应用，在此填写对应应用的ID </span>
					</td>
					<td width="3%"></td>
					<td width="57%">
					</td>
				</tr>
				<%if(csapppolist.size()>0){for(int i=0;i<csapppolist.size();i++){ %>
				<tr >
					<td width="4%"></td>
					
					<td width="30%" id="corpsetappname_app">
	                   <input  id="corpsetappname_appname_input<%=i%>" disabled="disabled"  type="text" id="appname" Class="inputText" name="appname"   value="<%=csapppolist.get(i).getAppname() %>"
					 	 whir-options="vtype:['notempty',{},'spechar3']" /><a id="corpsetappname_a_input<%=i%>" href="javascript:void(0);" class="selectIco" onclick="openSelectAPP(this);"></a>
					   <input  id="corpsetappname_appid_input<%=i%>" style="display:none" id="appid" Class="inputText" name="appid"   value="<%=csapppolist.get(i).getAppid() %>"
					 	 />
					</td>
					<td width="10%" id="corpsetappname_corpid">
						<input  id="corpsetappname_corpid_input<%=i%>" type="text" id="appcorpid" Class="inputText" name="appcorpid"   value="<%=csapppolist.get(i).getCorpid() %>"
					 	 whir-options="vtype:['notempty',{},'spechar3']" />  
					</td>
					
					<td width="10%">
						<i  >&nbsp;&nbsp;</i>
						<a href="javascript:void(0)" onclick="addTR(this)"><i  style="color:#2196f3;font-size:40px">+&nbsp;&nbsp;</i> </a>
						<a href="javascript:void(0)" onclick="deletetr(this)"><i   style="color:#2196f3;font-size:40px">-</i> </a>
					</td>
				</tr>
				<%}} else {%>
				<tr>
					<td width="4%"></td>
					
					<td width="30%" id="corpsetappname_app">
	                   <input  id="corpsetappname_appname_input0" disabled="disabled"  type="text" id="appname" Class="inputText" name="appname"   value=""
					 	 whir-options="vtype:['notempty',{},'spechar3']" /><a id="corpsetappname_a_input0" href="javascript:void(0);" class="selectIco" onclick="openSelectAPP(this);"></a>
					   <input  id="corpsetappname_appid_input0" style="display:none" id="appid" Class="inputText" name="appid"   value=""
					 	 />
					</td>
					<td width="10%" id="corpsetappname_corpid">
						<input  id="corpsetappname_corpid_input0" type="text" id="appcorpid" Class="inputText" name="appcorpid"   value=""
					 	 whir-options="vtype:['notempty',{},'spechar3']" />  
					</td>
					
					<td width="10%">
						<i  >&nbsp;&nbsp;</i>
						<a href="javascript:void(0)" onclick="addTR(this)"><i  style="color:#2196f3;font-size:40px">+&nbsp;&nbsp;</i> </a>
						<a href="javascript:void(0)" onclick="deletetr(this)"><i   style="color:#2196f3;font-size:40px">-</i> </a>
					</td>
				</tr>
				<% }%>
				<tr>
					<td width="4%"></td>
					<td width="10%">
						<input type="button" id="checkcorpid" class="btnButton4font"  onclick="syncorpappset()"   value="同步配置" />  
					</td>
				</tr>
			</table>
			</td>
		</tr>
		
		
	</table>
</s:form> 
</div>
</div>
</body>
<script type="text/javascript">

//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){         
    initListFormToAjax({formId:"sendMassageForm"});
    
});



var result=0;
function corpidcheck(){
	var corpid1='<%=corpid1%>';
	var corpid2='<%=corpid2%>';
	var corpid=$.trim($('#corpid').val());
	if(corpid!=null&&corpid!=""&&(corpid==corpid1||corpid==corpid2)){
		whir_alert("验证成功");
		result=1;
		//var user_org_syn_button =$('#user_org_syn_button');
		//user_org_syn_button.removeAttr("disabled"); 
	}else{
		whir_alert("请输入正确的企业号！");
		result=0;
	}
	
}
function synAll(){
	 whir_confirm("确定同步所有组织用户？ ", function check(){

	//var flag=0;
 	//var corpid1='<%=corpid1%>';
	//var corpid2='<%=corpid2%>';
	/* var corpid=$.trim($('#corpid').val());
	if(corpid!=null&&corpid!=""&&(corpid==corpid1||corpid==corpid2)&&result==1){
		flag=1;
		//var user_org_syn_button =$('#user_org_syn_button');
		//user_org_syn_button.removeAttr("disabled"); 
	}else{
		result=0;
	}
	if(flag==1){ */
	$.dialog.tips("正在同步"+'....',1000,'loading.gif',function(){},true); 
		$.ajax({
				url: "/defaultroot/synOrgAndEmp/synAll.controller",
				//url:"/defaultroot/MoveOAmanager!allSyn.action",
				cache: false,
				async: true,
				success: function(dataForm) {
				
					//alert(dataForm);
					//dataForm='{"result":"success","data0":{"orgCount":45,"successOrgCount":45,"failOrgCount":0,"empCount":8,"successEmpCount":7,"failEmpCount":1}}';
					//dataForm='{"result":"false","data0":"dsadas"}';
					var data = eval('('+dataForm+')');
					var res = data.data0;
					if(data.result=="success"){
						
						$('#resultStr').html("同步组织成功"+res.successOrgCount+"个 同步用户成功"+res.successEmpCount+"个；同步组织失败"+res.failOrgCount+"个 同步用户失败"+res.failEmpCount+"个");
						//whir_alert("");
					}else{
						$('#resultStr').html(res);
					}
					 $.dialog({id:"Tips"}).close();
				}
				
			});
		/*}else{
			whir_alert("请先验证企业号！");
		}*/
  }, function(){});
}
 function syncorpappset(){
 var corpsetappname_table = $('#corpsetappname_table tr').length;
	 	var num = corpsetappname_table-2;
	 	
	 	var json='{"csapppo":[';
	 	var jsonstr="";
	 	var ary = new Array();
	 	for(var i=0;i<num;i++){
	 			var  appid = $('#corpsetappname_appid_input'+i).val();
		 		var  appname = $('#corpsetappname_appname_input'+i).val();
		 		var  corpid = $('#corpsetappname_corpid_input'+i).val();
		 		if(appname==undefined&&corpid==undefined){
		 			num=num+1;
			 		continue;
			 	}
		 		if(appname!=undefined&&corpid!=undefined){
			 		if(corpid==null||corpid==""||corpid=="null"||corpid=="请填写对应的ID"
			 			||appname=="null"||appname==null||appname==""
			 			){
			 			whir_alert("配置项不能为空！");
			 			return false;
			 		}
			 		var p = /^([0-9.]+)$/;
			 		if(!p.test(corpid)){
			 			whir_alert("ID项只能为数字！");
			 				return false;
			 		}
			 		ary.push(corpid);
			 		appname = encodeURI(appname);
			 		jsonstr =jsonstr+'{"appid":"'+appid+'","corpid":"'+corpid+'","appname":"'+appname+'"},';
			 	}
	 	}
	 	//判断corpid 不能重复
	 	var nary=ary.sort();
			for(var i=0;i<ary.length;i++){
				if (nary[i]==nary[i+1]){
					whir_alert("配置项不能重复！");
					return false;
				}
			}
	 	jsonstr=jsonstr.substring(0,jsonstr.length-1);
	 	json = json+jsonstr+']}';
		var datastr = {"json":json};
  whir_confirm("确定同步设置？ ", function savecorpappset(){
	 	$.dialog.tips("正在同步"+'....',1000,'loading.gif',function(){},true); 
		 $.ajax({
					url: "/defaultroot/MoveOAmanager!savecorpsetapp.action",
					cache: false,
					async: true,
					success: function(dataForm) {
					data:datastr,
					type:"POST",
						var data = eval('('+dataForm+')');
						var res = data.result;
						if(data.result=="true"){
							whir_alert("同步成功！");
						}else{
							whir_alert("同步失败！");
						}
						$.dialog({id:"Tips"}).close();
					}
				});
	  },function(){});
  }
  
function saveForm(type, obj){
        $('#corpsetForm').submit();
}

function updatecorpset(){
 var corpid = $('#corpid').val();
 var corpsecret = $('#corpsecret').val();
 var token = $('#token').val();
 var encodingAESKey = $('#encodingAESKey').val();
 var id = $('#id').val();
 var relactionId = $("input[name='relactionId']:checked").val();

 if(corpid==null||corpid==""||corpid=="企业号后台-设置-账号信息"
 ||corpsecret==null||corpsecret==""||corpsecret=="企业号后台-设置-权限管理-新建管理员组后即可查看"
 ||token==null||token==""||token=="企业号后台-应用中心-创建应用-回调模式-回调URL及密钥"||
 encodingAESKey==null||encodingAESKey==""||encodingAESKey=="企业号后台-应用中心-创建应用-回调模式-回调URL及密钥"){
 	whir_alert("必填项不能为空！");
 	return false;
 }
	$.ajax({
				url: "/defaultroot/MoveOAmanager!savecorpset.action?corpid="+corpid+"&corpsecret="+corpsecret+"&token="+token+"&encodingAESKey="+encodingAESKey+"&id="+id+"&relactionId="+relactionId,
				cache: false,
				async: true,
				success: function(dataForm) {
				
					var data = eval('('+dataForm+')');
					var res = data.result;
					if(data.result=="true"){
						whir_alert("同步成功！");
					}else{
						whir_alert("同步失败！");
					}
				}
			});
	
}
function openSelectAPP(obj){
var id = $(obj).attr("id");

var corpsetappname_table = $('#corpsetappname_table tr').length;
 	var num = corpsetappname_table-2;
 	var appid="";
 	for(var i=0;i<num;i++){
 		
 		 appid =appid+"***"+ $('#corpsetappname_appid_input'+i).val();
 		
 	}

	openWin({url:'MoveOAmanager!selectAPP.action?id='+id+'&appid='+appid,winName:'selectAPP',height:280,width:800});
	//popup({content: "url:"+whirRootPath+"/workaddress!workAddress_list_select.action",width:800,height:500,title:"閫夋嫨鍔炲叕鍦扮偣"});
}

function addTR(obj){
	var corpsetappname_table = $('#corpsetappname_table tr').length;
	var i=corpsetappname_table-2;
	var tr = '<tr>'+
					'<td width="4%"></td>'+
					
					'<td width="30%" id="corpsetappname_app">'+
	                   '<input  id="corpsetappname_appname_input'+i+'" disabled="disabled"  type="text" id="appname" Class="inputText" name="appname"   value=""'+
					 	' whir-options="vtype:[\'notempty\',{},\'spechar3\']" /><a id="corpsetappname_a_input'+i+'" href="javascript:void(0);" class="selectIco" onclick="openSelectAPP(this);"></a>'+
					   '<input  id="corpsetappname_appid_input'+i+'" style="display:none" id="appid" Class="inputText" name="appid"   value=""'+
					 	' />'+
					'</td>'+
					'<td width="10%" id="corpsetappname_corpid">'+
						'<input  id="corpsetappname_corpid_input'+i+'" type="text" id="appcorpid" Class="inputText" name="appcorpid"   value="请填写对应的ID"'+
					 	' whir-options="vtype:[\'notempty\',{},\'spechar3\']" style= "color:#CCC " onfocus="revalue(this)" /> '+ 
					'</td>'+
					
					'<td width="10%">'+
						'<i  >&nbsp;&nbsp;</i>'+
						'<a href="javascript:void(0)" onclick="addTR(this)"><i  style="color:#2196f3;font-size:40px">+&nbsp;&nbsp;</i> </a>'+
						'<a href="javascript:void(0)" onclick="deletetr(this)"><i   style="color:#2196f3;font-size:40px">-</i> </a>'+
					'</td>'+
				'</tr>';
    $(obj).parent().parent().after(tr);  

}
function deletetr(obj){
var corpsetappname_table = $('#corpsetappname_table tr').length;
var num = corpsetappname_table-2;  
    if(num>1){
    	$(obj).parent().parent().remove(); 
	}else{
		whir_alert("至少保留一项！");
	}
}
 function revalue(obj){
  var value= $(obj).val();
	 if("请填写对应的ID"==value){
		$(obj).val("");
	 }
	$(obj).css("color","#333");
 }
 
 //企业号页签
function enterprisenumberLI(){
	$("#enterprisenumberLI").addClass("tag_aon");
	$("#evoLI").removeClass();
	location_href("<%=rootPath%>/MoveOAmanager!wxmanager.action");
}

//evo页签
function evoLI(){
	$("#evoLI").addClass("tag_aon");
	$("#enterprisenumberLI").removeClass();
	location_href("<%=rootPath%>/mobilecustmenu!mobCustMenu.action");
}

</script>
</html>