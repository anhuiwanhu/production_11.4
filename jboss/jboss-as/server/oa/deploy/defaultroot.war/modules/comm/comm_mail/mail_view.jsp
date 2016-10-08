<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%> 
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.ezoffice.personalwork.innermailbox.bd.InnerMailBD"%>
<%@ page import="com.whir.ezoffice.message.bd.MessageModelSend"%>
<%@ page import="java.lang.*"%>
<%whir_custom_str="easyui,tagit";%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  

<%
    InnerMailBD innerMailBD = new InnerMailBD();

	String cert="";
	if(session.getAttribute("cert") !=null){
       cert = session.getAttribute("cert").toString();
    }

	com.whir.org.common.util.SysSetupReader sysRed = com.whir.org.common.util.SysSetupReader.getInstance();
	MessageModelSend sendMsg=new MessageModelSend ();
	ManagerBD managerBD = new ManagerBD();
    boolean falg= sendMsg.judgePurviewMessage("内部邮件",CommonUtils.getSessionDomainId(request).toString());

   String modi_id = request.getParameter("mailid");//邮件ID
   String mailuser_id = request.getParameter("mailuserid");//用户邮件ID
   String mailposttime = (String) request.getAttribute("mailposttime");//发送时间
   String mailto_ren = request.getAttribute("mailto_ren")+"";//收件人
   String mailtoId = request.getAttribute("mailtoId")+"";//收件人
   String mailcc_ren = request.getAttribute("mailcc_ren")+"";//收件人
   String mailccId = request.getAttribute("mailccId")+"";//收件人

   String mailpostername = request.getAttribute("mailpostername").toString();//发件人
   String mailposterid = request.getAttribute("mailposterid").toString();//发件人id

   String userIsActive = request.getAttribute("userIsActive").toString();//发件人状态

   String mailcontent ="";
   if(request.getAttribute("mailcontent")!=null){
		mailcontent = request.getAttribute("mailcontent").toString();
   }
   String gnome=request.getAttribute("gnome")==null?"":request.getAttribute("gnome").toString();

   String mailsubject = (String) request.getAttribute("mailsubject");
   String status=request.getParameter("status")==null?"1":request.getParameter("status").toString();
   String mailcontenttype = request.getAttribute("mailcontenttype")==null?"0":request.getAttribute("mailcontenttype").toString();


   String fromdesktop = request.getParameter("fromdesktop");

%>

<head>  
	<title><%//=Resource.getValue(whir_locale,"mail","mail.checkingMails")%><%=mailsubject%></title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">   
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_detail.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<link href="<%=rootPath%>/modules/comm/comm_mail/css/buttonStyle.css" rel="stylesheet" type="text/css" />

	<script language="JavaScript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
    <script language="JavaScript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/MailResource.js" type="text/javascript"></script>
	 <style>
	.ui-autocomplete-loading {
	background: white url('<%=rootPath%>/scripts/plugins/jquery_ui/images/ui-anim_basic_16x16.gif') right center no-repeat;
	}
	</style>
	
	<style type="text/css">
		html,body{ height:100%; overflow:hidden; margin:0; padding:0;}
	</style>
	<script type="text/javascript">
		$(function(){
		 var bh = $("body").height();
		 var dh = bh-37;
		 $("#ddd").height(dh);
		});
	</script>
</head>  
<%
   /**
   //文本类型并且非系统发的提醒处理<>符号
   if("0".equals(mailcontenttype)&&
	   !"0".equals(mailposterid)){
       com.whir.component.util.StringUtils strutil = new com.whir.component.util.StringUtils();
       mailcontent = strutil.escapeHTMLTags(mailcontent);
   }
   **/

   //当前邮件下标
   int index = 0;
   if(request.getParameter("index")!=null&&
	   !"null".equals(request.getParameter("index")+"")&&
	   !"".equals(request.getParameter("index")+"")){
       index = Integer.parseInt(request.getParameter("index")+"");
   }
   //数据总条数
   int recordCount = 0;
   if(request.getParameter("recordCount")!=null&&
	   !"null".equals(request.getParameter("recordCount")+"")&&
	   !"".equals(request.getParameter("recordCount")+"")){
       recordCount = Integer.parseInt(request.getParameter("recordCount")+"");
   }   

   EncryptUtil encutil = new EncryptUtil();
   String frommod = encutil.htmlcode(request,"frommod");

   //禁止发邮件
	boolean estopMail=false;
    Float mailboxSize = innerMailBD.getMailboxSize(session.getAttribute("userId").toString());
    boolean isExcess = innerMailBD.excessMailNum(request);
    String Str1 ="";
    if(mailboxSize.floatValue()<=0){
       Str1 = Resource.getValue(whir_locale,"mail","mail.maxClew1");
    }else if(!isExcess){
       Str1 = Resource.getValue(whir_locale,"mail","mail.maxClew2");
    }
    if(mailboxSize.floatValue()<=0 || !isExcess){
       estopMail=true;
       
 %>  
 <SCRIPT LANGUAGE="JavaScript">
	<!--
	alert("<%=Str1%>");
	//-->
	</SCRIPT>
 <%}
   //回复、转发权限
   boolean sendMailAuth = !estopMail;
   if("0".equals(request.getAttribute("mailposterid")+"")) sendMailAuth = false;
   //匿名不回复
   if("1".equals(request.getAttribute("mailanonymous")+"")) sendMailAuth = false;

%>
 
<body class="Pupwin" >  
<div class="BodyMargin_10">  
    <div class="docBoxNoPanel"> 

	   <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
	        <tr height="8">    
			   <td width="100" class="td_lefttitle"></td>    
			   <td>  </td>    
		   </tr>
			<tr>
				<td nowrap align="left" colspan=2>
				<div style="padding-left:15px;" >
				   <%//发件箱邮件
				   if("sendedbox".equals(frommod)){%>

                    <a href="#" onclick="transmit();" class="but_class" style="color:#000;">
					  <span class="but_fontspce"><span class="but_forward"></span><%=Resource.getValue(whir_locale,"mail","mail.transfer")%></span><span class="but_rightbg"></span>
					</a>
					<a href="#" onclick="againSend();" class="but_class" style="color:#000;">
					  <span class="but_fontspce"><span class="but_forward"></span><%=Resource.getValue(whir_locale,"mail","mail.againSend")%></span><span class="but_rightbg"></span>
					</a>
				   <%}else{

					     if(sendMailAuth){
				   %>
					<div style="float:left; margin-right:2px;" >
						<a class="btnbox"><span class="btnfont"  onclick="onButtonReply();"><%=Resource.getValue(whir_locale,"mail","mail.reply")%></span></a>
						<div style="position:relative; float:left;z-index:100000;">
						   <a href="#" class="btnshow"></a>
						   <div id="Layer1" style="width:150px; left:0; position:absolute; top:25px; display:none; " >
							 <div class="sub_butbox" >
							 <%if(!(CommonUtils.getSessionUserId(request)+"").equals(mailposterid)){%>
								<a href="#" style="color:#000;" onclick="replyAll();"><%=Resource.getValue(whir_locale,"mail","mail.replyall")%></a>
								<a href="#" style="color:#000;" onclick="replyAllAtt();"><%=Resource.getValue(whir_locale,"mail","mail.replyallAtt")%></a>
							 <%}%>
								<a href="#" style="color:#000;" onclick="replyNew();"><%=Resource.getValue(whir_locale,"mail","mail.replyallNew")%></a>
							 </div>
						   </div>
						 </div>
					</div>
					<a href="#" onclick="transmit();" class="but_class" style="color:#000;">
					  <span class="but_fontspce"><span class="but_forward"></span><%=Resource.getValue(whir_locale,"mail","mail.transfer")%></span><span class="but_rightbg"></span>
					</a>
					<%    }
					   }%>
					<a href="#" onclick="delMailToDeserted();" class="but_class" style="color:#000;">
					   <span class="but_fontspce"><span class="but_delete"></span><%=Resource.getValue(whir_locale,"mail","mail.delete")%></span><span class="but_rightbg"></span>
					</a>

					<a href="#" onclick="delMails();" class="but_class" style="color:#000;">
					   <span class="but_fontspce"><%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%></span><span class="but_rightbg"></span>
					</a>
					  
					<div style="position:relative; float:left;z-index:100000;">
						<a href="#" class="but_class" style="color:#000;" id="movemail" >
						  <span class="but_fontspce"><span class="but_floatleft"><%=Resource.getValue(whir_locale,"mail","mail.transferto")%></span><span class="but_downbg"></span></span><span class="but_rightbg"></span>
						</a>
						<div id="Layer2" style="width:150px; left:2px; _left:4px; position:absolute; top:25px; display:none;margin:0;" >
						   <div class="sub_butbox">
						        <%if("receivebox".equals(request.getParameter("frommod"))){%>
								  <a href="#" onclick="moveMails('toSendedBox');"><%=Resource.getValue(whir_locale,"mail","mail.sendbox")%></a>
								  <a href="#" onclick="moveMails('toDesertedBox');"><%=Resource.getValue(whir_locale,"mail","mail.trashbox")%></a>
								<%}else if("sendedbox".equals(request.getParameter("frommod"))){%>
								  <a href="#" onclick="moveMails('toReceiveBox');"><%=Resource.getValue(whir_locale,"mail","mail.inbox")%></a>
								  <a href="#" onclick="moveMails('toDesertedBox');"><%=Resource.getValue(whir_locale,"mail","mail.trashbox")%></a>
								<%}else if("desertedbox".equals(request.getParameter("frommod"))){%>
								  <a href="#" onclick="moveMails('toReceiveBox');"><%=Resource.getValue(whir_locale,"mail","mail.inbox")%></a>
								  <a href="#" onclick="moveMails('toSendedBox');"><%=Resource.getValue(whir_locale,"mail","mail.sendbox")%></a>
								<%}else{%>
								  <a href="#" onclick="moveMails('toReceiveBox');"><%=Resource.getValue(whir_locale,"mail","mail.inbox")%></a>
								  <a href="#" onclick="moveMails('toSendedBox');"><%=Resource.getValue(whir_locale,"mail","mail.sendbox")%></a>
								  <a href="#" onclick="moveMails('toDesertedBox');"><%=Resource.getValue(whir_locale,"mail","mail.trashbox")%></a>
								<%}%>
								<logic:iterate id="folderList" name="folderList" scope="request" >
									<%Object[] obj = (Object[]) folderList;%>
									<a href="#" onclick="moveMails('<%=obj[0]%>');"><%=obj[1]%></a>
								</logic:iterate>
						   </div>
						 </div>
					</div>
					<a href="#" onclick="print();" style="color:#000;" class="but_class">
					   <span class="but_fontspce"><%=Resource.getValue(whir_locale,"mail","mail.print")%></span><span class="but_rightbg"></span>
					</a>
					<div style="position:relative; float:left;z-index:100000;">
						<a href="#" class="but_class" style="color:#000;" id="exportmail" >
						  <span class="but_fontspce"><span class="but_floatleft"><%=Resource.getValue(whir_locale,"mail","mail.export")%></span><span class="but_downbg"></span></span><span class="but_rightbg"></span>
						</a>
						<div id="Layer3" style="width:150px; left:2px; _left:4px; position:absolute; top:25px; display:none;margin:0;margin:0; " >
						   <div class="sub_butbox">
						        <a href="#" onclick="expmails('txt');">txt</a>
								<a href="#" onclick="expmails('eml');">eml</a>
						   </div>
						 </div>
					</div>
					<a href="#" onclick="closeWindow(null);" style="color:#000;" class="but_class">
					   <span class="but_fontspce"><%=Resource.getValue(whir_locale,"mail","mail.quit")%></span><span class="but_rightbg"></span>
					</a>
					<%if(index>0){%>
					<a href="#" style="color:#000;" onclick="goNextMail('<%=index-1%>');" class="but_class">
					   <span class="but_fontspce"><%=Resource.getValue(whir_locale,"mail","mail.preMail")%></span><span class="but_rightbg"></span>
					</a>
					<%}%>
					<%if(index<recordCount-1){%>
					<a href="#" style="color:#000;" onclick="goNextMail('<%=index+1%>');" class="but_class">
					   <span class="but_fontspce"><%=Resource.getValue(whir_locale,"mail","mail.nextMail")%></span><span class="but_rightbg"></span>
					</a>
					<%}%>
				</div>
					   
			</tr>
			<tr height="2">    
			   <td width="100" class="td_lefttitle"></td>    
			   <td>  </td>    
		   </tr>
		   
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.time")%>：    
			   </td>    
			   <td style = " padding-right :18px ">    
				   <input type="text" class="inputText" id="mailposttime" name="mailposttime" value="<%=mailposttime.length()>16?mailposttime.substring(0,16):mailposttime%>" readonly="true" style="width:100%"/>   
			   </td>    
		   </tr>
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.addresser")%>：    
			   </td>    
			   <td style = " padding-right :14px ">   
			       <%if("$0$".equals(mailposterid)||"匿名,".equals(mailpostername)){%>
			        <input type="text" class="inputText" id="mailpostername" name="mailpostername" value="<%=mailpostername%>" readonly="true" style="width:98%"/>
				    <%--input type="hidden" name="mailposterid" value="<%=mailposterid%>"--%>
				  <%}else{%>
				  <div class="whirTagitDiv">  
					 <div class="whirTagitDivUL" style="width:100%;">  
						<ul id="mailposterUl" data-name="mailposterUl"></ul>  
					 </div>   
					 <input type="hidden" id="mailpostername" name="mailpostername" value="<%=mailpostername%>"/>  
					 <input type="hidden" id="mailposterid" name="mailposterid" value="<%=mailposterid%>"/>
				   </div>
				  <%}
				   %>
			       

			   </td>    
		   </tr> 
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.sendto")%>：    
			   </td>    
			   <td style = " padding-right :14px "> 
				 <div class="whirTagitDiv">  
					<div class="whirTagitDivUL" style="width:100%;">  
						<ul id="sendtoUl" data-name="sendtoUl"></ul>  
					</div>   
					<input type="hidden" id="sendto" name="sendto" value="<%=mailto_ren%>"/>  
					<input type="hidden" id="sendtoid" name="sendtoid" value="<%=mailtoId%>"/>
				 </div>
			   </td>    
		   </tr>
		   <%if(mailcc_ren!=null&&!"null".equals(mailcc_ren)&&!"".equals(mailcc_ren)){%>
		    <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.copyto")%>：    
			   </td>    
			   <td style = " padding-right :14px ">   
			       <div class="whirTagitDiv">  
					<div class="whirTagitDivUL" style="width:100%;">  
						<ul id="sendccUl" data-name="sendccUl"></ul>  
					</div>   
					<input type="hidden" id="mailcc" name="mailcc" value="<%=mailcc_ren%>"/>  
					<input type="hidden" name="mailccid" id="mailccid" value="<%=mailccId%>">
				   </div>
			   </td>    
		   </tr>
		   <%}%>

		   <tr>    
			   <td class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.title")%><span class="MustFillColor">*</span>：    
			   </td>    
			   <td style = " padding-right :18px ">    
				  <input type="text" class="inputText" id="mailsubject" name="mailsubject" value="<%=mailsubject%>" readonly="true" style="width:100%"/>
			   </td>    
		   </tr>
		   <%
		      //优先级 0:普通  1:重要  2:紧急
		      String maillevel=request.getAttribute("maillevel")==null?"":request.getAttribute("maillevel").toString();
			  //是否需要回执 0:不需要 1:需要
			  String mailneedrevert=request.getAttribute("mailneedrevert")==null?"":request.getAttribute("mailneedrevert").toString();
			  //是否签名标识 0:不需要 1:需要
			  String mailSign=request.getAttribute("mailSign")==null?"":request.getAttribute("mailSign").toString();
			  //是否匿名标识 0:不匿名  1:匿名
			  String mailanonymous=request.getAttribute("mailanonymous")==null?"":request.getAttribute("mailanonymous").toString();
			  //是否提醒标识 1:发提醒；0：不发提醒 默认发
			  String mailRTMessage=request.getAttribute("mailRTMessage")==null?"":request.getAttribute("mailRTMessage").toString();
			  //是否短信提醒 1:发提醒；0：不提醒 
			  String sendSms=request.getAttribute("sendSms")==null?"":request.getAttribute("sendSms").toString();
			  //是否加密
			  String encrypt=request.getAttribute("encrypt")==null?"":request.getAttribute("encrypt").toString();
			  
			   //公有云控制 0 不选中 1-选中
			  String cloudcontrol=request.getAttribute("cloudcontrol")==null?"":request.getAttribute("cloudcontrol").toString();
		   %>
		   <tr>    
			   <td class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.sendoption")%>：    
			   </td>
			   <td>    
			    <input type="checkbox" name="maillevel" id="maillevel" value="2" disabled="true" <%if("2".equals(maillevel)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.urgency")%>
				<input type="checkbox" name="mailneedrevert" id="mailneedrevert" value="1" disabled="true" <%if("1".equals(mailneedrevert)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.receipt")%>  
				<input type="checkbox" name="mailSign" id="mailSign" value="1" disabled="true" <%if("1".equals(mailSign)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.signature")%>  
				<input type="checkbox" name="mailanonymous" id="mailanonymous" value="1" disabled="true" <%if("1".equals(mailanonymous)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.anonymous")%>   
			   <%    
				  if(sysRed.hasRtxOnline(CommonUtils.getSessionDomainId(request).toString())){
				%>
				<input type="checkbox" name="mailRTMessage" id="mailRTMessage" value="1" disabled="true" <%if("1".equals(mailRTMessage)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.imRemind")%>  
              <%}%>
			  <%if(falg&&managerBD.hasRight(CommonUtils.getSessionUserId(request).toString(),"09*01*01")){%>
				<input type="checkbox" name="mailneedsendMsg" id="mailneedsendMsg" value="1" disabled="true" <%if("1".equals(sendSms)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.messageremind")%>  
			  <%}%>
			  <%if("JC_".equals(cert)){%>
				<input type="checkbox" name="encrypt" id="encrypt" value="1" disabled="true" <%if("1".equals(encrypt)){out.print("checked");}%>/><%=Resource.getValue(whir_locale,"mail","mail.encrypt")%>  
			  <%}%>
			   <input type="checkbox" name="cloudcontrol" id="cloudcontrol" value="1" disabled="true" <%if("1".equals(cloudcontrol)){out.print("checked");}%>/>公有云控制
			   </td>    
		   </tr>
		   <tr>    
			   <td class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.attachment")%>：    
			   </td>    
			   <td>    
			    <%
				  List list=(List)request.getAttribute("accessoryList");
				  int arrlen=0;
				  if(list!=null){
					  arrlen=list.size();
				  }

				  String realFileArray="";//已经存在的文件 要在页面显示的文件名数组
				  String saveFileArray="";//已经存在的文件 文件的存储名(磁盘上的物理文件名)数组

				  Object[] obj;
				  if(list!=null){
					  for(int i=0;i<arrlen;i++){
						  obj=(Object[])list.get(i);
						  realFileArray += obj[0]+"|";
						  saveFileArray += obj[1]+"|";
					  }
				  }
				%>
					<input type="hidden" name="realFileName" id="realFileName" style="width:800px;" value="<%=realFileArray%>"/>  
					<input type="hidden" name="saveFileName" id="saveFileName" style="width:800px;" value="<%=saveFileArray%>"/>  
					  
					<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
					   <jsp:param name="dir"      value="innerMailbox" />
					   <jsp:param name="uniqueId"    value="uniqueId" />
					   <jsp:param name="realFileNameInputId"    value="realFileName" />
					   <jsp:param name="saveFileNameInputId"    value="saveFileName" /> 
					   <jsp:param name="canModify"       value="no" />
					   <jsp:param name="multi"        value="true" />
					   <jsp:param name="buttonClass" value="upload_btn" />
					   <jsp:param name="fileSizeLimit"        value="0" />
					   <jsp:param name="uploadLimit"      value="0" />
					</jsp:include>
			   </td>    
		   </tr>
           <input type="hidden" name="printmailcontent" id="printmailcontent" value="<%=mailcontent.replaceAll("\"","'")%>"/>
		   <input type="hidden" name="modi_id" id="modi_id" value="<%=modi_id%>"/>
		   <input type="hidden" name="mailuser_id" id="mailuser_id" value="<%=mailuser_id%>"/>
	   </table>
	   <div align="left" style="height:auto;border:1px solid #dddddd;padding:0;margin-left:18px;margin-right:18px;overflow-y:auto; overflow-x:auto;">
			<table width="100%" border="0" height="240"  style="height:290px;">
			<tr>
				<td valign="top" style="line-height:20px;word-break:break-all;word-wrap:break-word;">
					<%
					if(mailcontent.length()>0){
						 String startStr = mailcontent.substring(0, 1);
						 if (" ".equals(startStr)) {
							 mailcontent = "&nbsp;" + mailcontent.substring(1);
						 }
					 }
					out.print(mailcontent);
					%>
					<br/>
					<%if(!"".equals(gnome)){%>
					<br/>
					<br/><%out.print(gnome);%>
					<%
					mailcontent += "<br/><br/>"+gnome;
					}%>
				</td>
			</tr>
			</table>
		</div>
	   <br/>
	   <br/>
	   <br/>
	   <br/>
	   <br/>
	</div>
</div>
</body>  
 <script>
 $(".btnshow").click(function(){
$("#Layer1").slideDown();
});

$("#Layer1").mouseleave(function(){
$("#Layer1").slideUp();
});

$("#movemail").click(function(){
$("#Layer2").slideDown();
});

$("#Layer2").mouseleave(function(){
$("#Layer2").slideUp();
});

$("#exportmail").click(function(){
$("#Layer3").slideDown();
});

$("#Layer3").mouseleave(function(){
$("#Layer3").slideUp();
});
 </script>
  
<script type="text/javascript">  
	//*************************************下面的函数属于公共的或半自定义的*************************************************//  
  
	//设置表单为异步提交  
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<%=Resource.getValue(whir_locale,"mail","mail.save")%>'});  
    
  
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  
$(document).ready(function() {


    whirTagit({tagitId:'sendtoUl', single:false, initBool:true, inputId:'sendtoid', inputName:'sendto',readOnly:true});
	whirTagit({tagitId:'sendccUl', single:false, initBool:true, inputId:'mailccid', inputName:'mailcc',readOnly:true});
    <%if(!"0".equals(mailposterid)){%>
      whirTagit({tagitId:'mailposterUl', single:false, initBool:true, inputId:'mailposterid', inputName:'mailpostername',readOnly:true});
	<%}%>

    Initialize();

});
	function Initialize(){
      try{
	    window.opener.refreshListForm_('queryForm');
	  }catch(e){}
	}
	function print(){
	   openWin({url:'<%=rootPath%>/modules/comm/comm_mail/mail_printview.jsp',isFull:'true',isScroll: 'yes',winName:'printwin'});
    }
    function goNextMail(index){

        var recordCount = window.opener.document.getElementById("recordCount").value;

		var orderByFieldName="";
		if(window.opener.document.getElementById("orderByFieldName")){
		   orderByFieldName=window.opener.document.getElementById("orderByFieldName").value;
		}
		var orderByType="";
		if(window.opener.document.getElementById("orderByType")){
			orderByType=window.opener.document.getElementById("orderByType").value;
		}
		var ahref="type=nextmail&index="+index+'&frommod=<%=frommod%>&orderByFieldName='+orderByFieldName+'&orderByType='+orderByType;
		if(window.opener.document.getElementById("searchsubject")){
			 ahref += '&searchsubject='+window.opener.document.getElementById("searchsubject").value;
		}
		if(window.opener.document.getElementById("searchuser")){
			 ahref += '&searchuser='+window.opener.document.getElementById("searchuser").value;
		}
		if(window.opener.document.getElementById("searchsendtime_s")){
			 ahref += '&searchsendtime_s='+window.opener.document.getElementById("searchsendtime_s").value;
		}
		if(window.opener.document.getElementById("searchsendtime_e")){
			 ahref += '&searchsendtime_e='+window.opener.document.getElementById("searchsendtime_e").value;
		}
		ahref += '&boxId=<%=request.getParameter("boxId")%>';

		var json = ajaxForSync("<%=rootPath%>/innerMail!goNextMail.action",ahref);
		json = eval("("+json+")");
		if(json!=""){
			 	
            whir_tips("",1,'',function(){
	          location_href('innerMail!viewMail.action?mailuserid='+json.mailuserid+'&mailid='+json.mailid+'&index='+json.index+'&recordCount='+recordCount+'&frommod=<%=frommod%>&boxId=<%=request.getParameter("boxId")%>');
	        });
		  
		}
            
	}
    //答复
    function onButtonReply(){
		<%if(!"1".equals(userIsActive)){%>
           <%if("0".equals(mailposterid)){%>
             alert("<%=Resource.getValue(whir_locale,"mail","mail.remind2")%>");
			 return;
		   <%}else{%>
			 alert(Mail.userisactive);
			 return;
		   <%}%>
        <%}%>
         	
        whir_tips("",1,'',function(){
	          location_href('innerMail!openAddMail.action?replyType=replySingle&mail_id=<%=modi_id%>&mailuser_id=<%=mailuser_id%>');
	    });
		
    }
	//全部答复
    function replyAll(){
		<%if(!"1".equals(userIsActive)){%>
			<%if("0".equals(mailposterid)){%>
             alert("<%=Resource.getValue(whir_locale,"mail","mail.remind2")%>");
			 return;
		   <%}else{%>
			 alert(Mail.userisactive);
			 return;
		   <%}%>
        <%}%>
		 	
         whir_tips("",1,'',function(){
	          location_href('innerMail!openAddMail.action?replyType=replyAll&mail_id=<%=modi_id%>&mailuser_id=<%=mailuser_id%>');
	    });
    }
	//全部答复带附件
    function replyAllAtt(){
		<%if(!"1".equals(userIsActive)){%>
			<%if("0".equals(mailposterid)){%>
             alert("<%=Resource.getValue(whir_locale,"mail","mail.remind2")%>");
			 return;
		   <%}else{%>
			 alert(Mail.userisactive);
			 return;
		   <%}%>
        <%}%>
		 	
        whir_tips("",1,'',function(){
	          location_href('innerMail!openAddMail.action?replyType=replyAllAtt&mail_id=<%=modi_id%>&mailuser_id=<%=mailuser_id%>');
	    });
    }
	//全部答复 新邮件
    function replyNew(){
		<%if(!"1".equals(userIsActive)){%>
			<%if("0".equals(mailposterid)){%>
             alert("<%=Resource.getValue(whir_locale,"mail","mail.remind2")%>");
			 return;
		   <%}else{%>
			 alert(Mail.userisactive);
			 return;
		   <%}%>
        <%}%>
		 	
        whir_tips("",1,'',function(){
	       location_href('innerMail!openAddMail.action?replyType=replyNew&mail_id=<%=modi_id%>&mailuser_id=<%=mailuser_id%>');
	    });
		
    }
	//转发
    function transmit(){
		<%if(!"1".equals(userIsActive)){%>
			<%if("0".equals(mailposterid)){%>
             alert("<%=Resource.getValue(whir_locale,"mail","mail.remind2")%>");
			 return;
		   <%}else{%>
			 alert(Mail.userisactive);
			 return;
		   <%}%>
        <%}%>
		 	
        whir_tips("",1,'',function(){
	       location_href('innerMail!openAddMail.action?replyType=transmit&mail_id=<%=modi_id%>&mailuser_id=<%=mailuser_id%>');
	    });
		
    }
	//再次发送
    function againSend(){
		<%if(!"1".equals(userIsActive)){%>
			<%if("0".equals(mailposterid)){%>
             alert("<%=Resource.getValue(whir_locale,"mail","mail.remind2")%>");
			 return;
		   <%}else{%>
			 alert(Mail.userisactive);
			 return;
		   <%}%>
        <%}%>
		whir_tips('',1,'',function(){
	          location_href('innerMail!openAddMail.action?replyType=againSend&mail_id=<%=modi_id%>&mailuser_id=<%=mailuser_id%>');
	    });
		
    }

	function delMailToDeserted() {
		 ajaxOperate({urlWithData: 'innerMail!delMailToDeserted.action?mailuserid=<%=mailuser_id%>',tip:Mail.confirmsingletodrash1,isconfirm:true,callbackfunction:reflashandcloses});
	}
	function delMails() {
		 ajaxOperate({urlWithData: 'innerMail!delMails.action?mailuserid=<%=mailuser_id%>',tip:'<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>',isconfirm:true,callbackfunction:reflashandcloses});
	}
	function moveMails(obj) {
		 ajaxOperate({urlWithData: 'innerMail!moveMails.action?boxId='+obj+'&mailuserid=<%=mailuser_id%>',isconfirm:false,callbackfunction:reflashandcloses});
	}
    function reflashandcloses(opeJson_,msg_json) {
		<%if("1".equals(fromdesktop)){%>
			try{
			opener.refreshMod('', '<%=request.getParameter("portletSettingId")%>');
		}catch(e){}
		<%}else{%>
          window.opener.refreshListForm_('queryForm');
		<%}%>
		window.close();
	    
	}

    function closess() {
	  window.close();
	}
	function expmails(val) {
        
		var ahref = "ids=<%=mailuser_id%>";
        var json = ajaxForSync("<%=rootPath%>/innerMail!hasExportEmailSize.action",ahref);
        json = eval("("+json+")");
		if(json.result=="true"){
		  commonExportExcel({formId:'queryForm', action:'innerMail!exportEmail.action?ids=<%=mailuser_id%>&filetype='+val});
		}else{
		  alert("附件大小不能超过30M！");
		}
	}
</script>
  
</html>  