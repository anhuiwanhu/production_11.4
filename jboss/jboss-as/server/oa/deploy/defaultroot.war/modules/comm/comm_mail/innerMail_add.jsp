<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.personalwork.innermailbox.bd.*" %>
<%@ page import="com.whir.ezoffice.personalwork.innermailbox.po.*" %>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.ezoffice.message.bd.MessageModelSend"%>
<%whir_custom_str="easyui,tagit";%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<%
  String outmailremind = Resource.getValue(whir_locale,"mail","mail.outmailremind");
%>
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
	<title><%=Resource.getValue(whir_locale,"mail","mail.newmail")%></title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/> 
	<meta http-equiv="X-UA-Compatible" content="IE=edge"> 
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_detail.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  

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


	function screeBox(){
		var bh = $(window).height();
		var dh = bh-37;
		$("#ddd").height(dh);
	}
	$(function(){
		screeBox();
		$(window).resize(function(){
			screeBox();
		});

	});

	</script>
<%
    InnerMailBD innerMailBD = new InnerMailBD();
    Float mailboxSize = innerMailBD.getMailboxSize(session.getAttribute("userId").toString());
    boolean isExcess = innerMailBD.excessMailNum(request);
    String Str1 ="";
    if(mailboxSize.floatValue()<=0){
       Str1 = Resource.getValue(whir_locale,"mail","mail.maxClew1");
    }else if(!isExcess){
       Str1 = Resource.getValue(whir_locale,"mail","mail.maxClew2");
    }
    if(mailboxSize.floatValue()<=0 || !isExcess){
       
 %>  
 <SCRIPT LANGUAGE="JavaScript">
	<!--
	alert("<%=Str1%>");
    window.close();
	//-->
	</SCRIPT>
 <%}%>

</head>  
<%
    com.whir.org.common.util.SysSetupReader sysRed = com.whir.org.common.util.SysSetupReader.getInstance();
	MessageModelSend sendMsg=new MessageModelSend ();
	ManagerBD managerBD = new ManagerBD();
    boolean falg= sendMsg.judgePurviewMessage("内部邮件",CommonUtils.getSessionDomainId(request).toString());
    
	String cert="";
	if(session.getAttribute("cert") !=null){
       cert = session.getAttribute("cert").toString();
    }
    String canChooseOrg = "";
    if(request.getAttribute("canChooseOrg") !=null){
      canChooseOrg = request.getAttribute("canChooseOrg").toString();
    }

	String mailto = (request.getAttribute("mailto")!= null &&!"null".equals(request.getAttribute("mailto")+""))?request.getAttribute("mailto").toString():"";
	String mailtoid = (request.getAttribute("mailtoid")!= null &&!"null".equals(request.getAttribute("mailtoid")+""))?request.getAttribute("mailtoid").toString():"";
	String mailcc = (request.getAttribute("mailcc")!= null &&!"null".equals(request.getAttribute("mailcc")+""))?request.getAttribute("mailcc").toString():"";
	String mailccid = (request.getAttribute("mailccid")!= null &&!"null".equals(request.getAttribute("mailccid")+""))?request.getAttribute("mailccid").toString():"";
	String mailbcc = (request.getAttribute("mailbcc")!= null &&!"null".equals(request.getAttribute("mailbcc")+""))?request.getAttribute("mailbcc").toString():"";
	String mailbccid = (request.getAttribute("mailbccid")!= null &&!"null".equals(request.getAttribute("mailbccid")+""))?request.getAttribute("mailbccid").toString():"";

	String accessorySize = (request.getAttribute("accessorySize")!= null &&!"null".equals(request.getAttribute("accessorySize")+""))?request.getAttribute("accessorySize").toString():"0";

	String mailcontent = (request.getAttribute("mailcontent")!= null &&!"null".equals(request.getAttribute("mailcontent")+""))?request.getAttribute("mailcontent").toString():"";
	String mailcontenttype = (request.getAttribute("mailcontenttype")!= null &&!"null".equals(request.getAttribute("mailcontenttype")+""))?request.getAttribute("mailcontenttype").toString():"";
    //信息发送邮件接口
	if(request.getParameter("pageURL")!=null&&
	   !"null".equals(request.getParameter("pageURL"))&&
	   !"".equals(request.getParameter("pageURL"))){
	       mailcontenttype="1";
           mailcontent=request.getParameter("pageURL");
	}

	String mailsubject = (request.getAttribute("mailsubject")!= null &&!"null".equals(request.getAttribute("mailsubject")+""))?request.getAttribute("mailsubject").toString():"";
    if(request.getParameter("pageSubject")!=null&&
	   !"null".equals(request.getParameter("pageSubject"))&&
	   !"".equals(request.getParameter("pageSubject"))){
           mailsubject=request.getParameter("pageSubject");
	}

	String maillevel = request.getAttribute("maillevel")+"";
	String mailneedrevert = request.getAttribute("mailneedrevert")+"";
	String mailSign = request.getAttribute("mailSign")+"";
	String mailanonymous = request.getAttribute("mailanonymous")+"";
	String mailRTMessage = request.getAttribute("mailRTMessage")+"";
	String sendSms = request.getAttribute("sendSms")+"";
	String encrypt = request.getAttribute("encrypt")+"";
	String cloudcontrol = request.getAttribute("cloudcontrol")+"";
	String mail_id = request.getParameter("mail_id")==null?"":request.getParameter("mail_id");
	//当前草稿下标
   int index = 0;
   if(request.getParameter("index")!=null&&
	   !"null".equals(request.getParameter("index")+"")&&
	   !"".equals(request.getParameter("index")+"")){
       index = Integer.parseInt(request.getParameter("index")+"");
   }
   //草稿数据总条数
   int recordCount = 0;
   if(request.getParameter("recordCount")!=null&&
	   !"null".equals(request.getParameter("recordCount")+"")&&
	   !"".equals(request.getParameter("recordCount")+"")){
       recordCount = Integer.parseInt(request.getParameter("recordCount")+"");
   }

   //外部输入收件人
   String empId=request.getParameter("empId");
   String empName=request.getParameter("empName");
   if(empId != null){
	  mailto = empName;
	  mailtoid = empId;
   }

   boolean ccbut = true;
   if("".equals(mailcc)&&
	  "".equals(mailccid)){
	  ccbut = false;
   }
   boolean bccbut = true;
   if("".equals(mailbcc)&&
	  "".equals(mailbccid)){
	  bccbut = false;
   }

    boolean ispad = com.whir.common.util.CommonUtils.isForbiddenPad(request);

	//外部邮件
	List internetMailSetList = (List)request.getAttribute("internetMailSetList");

	InternetMailBD internetMailBD = new InternetMailBD();
    InternetMailToPO emailtoPO = null;
	String internetmailto = ""; 
    String internetmailcc = ""; 
    String internetmailbcc = ""; 
	if(mail_id!=null && !"null".equals(mail_id)&&!"".equals(mail_id)){
		  emailtoPO = (InternetMailToPO)internetMailBD.getEmailto(mail_id);
		  if(emailtoPO!=null){
			internetmailto = emailtoPO.getInternetmailto()==null||"null".equals(emailtoPO.getInternetmailto())?"":emailtoPO.getInternetmailto(); 
			internetmailcc = emailtoPO.getInternetmailcc()==null||"null".equals(emailtoPO.getInternetmailcc())?"":emailtoPO.getInternetmailcc(); 
			internetmailbcc = emailtoPO.getInternetmailbcc()==null||"null".equals(emailtoPO.getInternetmailbcc())?"":emailtoPO.getInternetmailbcc(); 
		  }
	}

	String internetmailcontent = "";
	String internetmailsubject = "";
	if("replyEmail".equals(request.getParameter("replyType"))){
	   internetmailto = (request.getAttribute("internetmailto")!= null &&!"null".equals(request.getAttribute("internetmailto")+""))?request.getAttribute("internetmailto").toString():"";
       internetmailcc = (request.getAttribute("internetmailcc")!= null &&!"null".equals(request.getAttribute("internetmailcc")+""))?request.getAttribute("internetmailcc").toString():"";
       internetmailbcc = (request.getAttribute("internetmailbcc")!= null &&!"null".equals(request.getAttribute("internetmailbcc")+""))?request.getAttribute("internetmailbcc").toString():"";
	   
	   internetmailcontent = (request.getAttribute("internetmailcontent")!= null &&!"null".equals(request.getAttribute("internetmailcontent")+""))?request.getAttribute("internetmailcontent").toString():"";
       mailcontent = internetmailcontent;

	   internetmailsubject = (request.getAttribute("internetmailsubject")!= null &&!"null".equals(request.getAttribute("internetmailsubject")+""))?request.getAttribute("internetmailsubject").toString():"";
	   mailsubject = internetmailsubject;
	}

%>  
<style type="text/css">
.out {color:blue;}
.on {color:red;}
</style>

<body style="overflow-y:auto;position:relative; height:100%;" >  

     <s:form name="dataForm" id="dataForm" action="innerMail!sendMail.action" method="post" >  
		<%@ include file="/public/include/form_detail.jsp"%>

	  <%//回复转发
		  if(request.getParameter("replyType")==null){
	  %>
        <div id="popToolbar" style="height:37px;position:absolute; <%if(ispad){%>top:0;<%}else{%>top:10px;<%}%> width:100%;" >
		 <div id="commandBar"  >
		  <table id="commandBarTable" width="96%" cellspacing="0" cellpadding="0" border="0">
		   <tbody>
		    <tr valign="top">
			 <td>
			  <div id="workflowBtnbox" class="workflowBtnbox">
			    <a id="CompleteTask" class="workflowBtn" onclick="sendAndExit(this);" href="javascript:void(0);"><span class="imgIco"><img src="<%=rootPath%>/images/sendexit.gif"></img></span>
                <%=Resource.getValue(whir_locale,"mail","mail.sendquit")%>
                </a>
				<a id="CompleteTask" class="workflowBtn" onclick="sendAndContinue(this);" href="javascript:void(0);"><span class="imgIco"><img src="<%=rootPath%>/images/sendcontinue.gif"></img></span>
                <%=Resource.getValue(whir_locale,"mail","mail.sendcontinue")%>
                </a>
				<a id="CompleteTask" class="workflowBtn" onclick="save(this);" href="javascript:void(0);"><span class="imgIco"><img src="<%=rootPath%>/images/savedraft.gif"></img></span>
                <%=Resource.getValue(whir_locale,"mail","mail.savedraft")%>
                </a>
			  </div>
			 </td>
			 <td width="150">
			  <div id="open_menu" class="open_menu" style="display: none;"></div><script></script>
			  <div class="workflowClose">
			    <a class="workflowBtn" onclick="winClose();" href="javascript:void(0);">
				  <span class="imgIco"><img src="<%=rootPath%>/images/toolbar/close.png"></img></span>
                 <%=Resource.getValue(whir_locale,"mail","mail.quit")%>
                </a>
			  </div>
			 </td>
		    </tr>
		  </tbody>
		 </table>
		</div>
	  </div>
	<%}%>

          
	  <div class="" id="ddd" <%if(request.getParameter("replyType")==null){%>style="overflow-y:auto; position:relative; top:37px; width:100%; _width:99%;"<%}else{%>
      <%if(ispad){%>style="height:37px;position:absolute;top:0;width:100%;"<%}else{%>style="height:37px;position:absolute;top:20px;width:100%;"<%}%><%}%> >

        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
		   <%//回复转发
			  if(request.getParameter("replyType")!=null){
		   %>
		   <tr>    
			   <td width="100" class="td_lefttitle">&nbsp;</td>    
			   <td>  
			     <%if("modify".equals(request.getParameter("replyType"))){%>
					<input type="button" class="btnButton4font" onClick='saveAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.undersend")%>" />
					<input type="button" class="btnButton4font" onClick='sendAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.sendquit")%>" />
					<input type="button" class="btnButton4font" onClick='delDrafts(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>" />
					<input type="button" class="btnButton4font" onClick='resetDataForm(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.reset")%>" />
					<input type="button" class="btnButton4font" onClick='closeWindow(null);' value="<%=Resource.getValue(whir_locale,"mail","mail.quit")%>" />
					<%if(index>0){%>
					 <input type="button" class="btnButton4font" onClick="goNextMail('<%=index-1%>');" value="<%=Resource.getValue(whir_locale,"mail","mail.preMail")%>" />
					<%}%>
					<%if(index<recordCount-1){%>
					 <input type="button" class="btnButton4font" onClick="goNextMail('<%=index+1%>');" value="<%=Resource.getValue(whir_locale,"mail","mail.nextMail")%>" />
					<%}%>

				 <%}else{%>
					<input type="button" class="btnButton4font" onClick='sendAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.sendquit")%>" />
					<input type="button" class="btnButton4font" onClick='saveAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.undersend")%>" />
					<input type="button" class="btnButton4font" onClick='closeWindow(null);' value="<%=Resource.getValue(whir_locale,"mail","mail.quit")%>" />
				 <%}%>

			   </td>    
		   </tr>
		   <%}%>

		   <tr>    
			   <td width="100" class="td_lefttitle" colspan="2" height="10"></td>    
		   </tr>
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<a href="javascript:void(0);" style="cursor:pointer" title="<%=Resource.getValue(whir_locale,"mail","mail.ClickSelectRecipients")%>" onClick='click_selectto();'><span class="out" onmouseover="this.className='on'" onmouseout="this.className='out'"><%=Resource.getValue(whir_locale,"mail","mail.sendto")%></span></a>：    
			   </td>    
			   <td>   
				<div class="whirTagitDiv">  
					<div class="whirTagitDivUL" style="width:87%;">  
						<ul id="mailtoUl" data-name="mailtoUl"></ul>  
					</div>  
					<div class="whirTagitDivArrow" style="width:13%;">  
						<a href="javascript:void(0);" class="selectIcoTagit" onclick="click_selectto();"></a>
						<input type="button" class="btnButton4font" onClick="deluser('mailtoUl','mailtoid','mailto');" value="<%=Resource.getValue(whir_locale,"mail","mail.clearSelection")%>" style="width:auto;"/>
					</div>  
					<input type="hidden" id="mailto" name="mailto" value="<%=mailto%>"/>  
					<input type="hidden" id="mailtoid" name="mailtoid" value="<%=mailtoid%>"/>
				 </div>
			   </td>    
		   </tr>
		   
		   <tr id="cs_tr" style="display:none">
			  <td width="100" class="td_lefttitle">&nbsp;&nbsp;<a href="javascript:void(0);" style="cursor:pointer" title="<%=Resource.getValue(whir_locale,"mail","mail.ClickselectCc")%>" onClick='click_selectcc();'><span class="out" onmouseover="this.className='on'" onmouseout="this.className='out'"><%=Resource.getValue(whir_locale,"mail","mail.copyto")%></span></a>：
			  </td>
			 <td colspan="2">

				  <div class="whirTagitDiv">  
					<div class="whirTagitDivUL" style="width:87%;">  
						<ul id="mailccUl" data-name="mailccUl"></ul>  
					</div>  
					<div class="whirTagitDivArrow" style="width:13%;">  
						<a href="javascript:void(0);" class="selectIcoTagit" onclick="click_selectcc();"></a>
						<input type="button" class="btnButton4font" onClick="deluser('mailccUl','mailccid','mailcc');" value="<%=Resource.getValue(whir_locale,"mail","mail.clearSelection")%>" style="width:auto;"/>
					</div>  
					<input type="hidden" id="mailcc" name="mailcc" value="<%=mailcc%>"/>  
					<input type="hidden" id="mailccid" name="mailccid" value="<%=mailccid%>"/>
				 </div>
			 </td>
			</tr>

			<tr id="ms_tr" style="display:none">
			  <td width="100" class="td_lefttitle">&nbsp;&nbsp;<a href="javascript:void(0);" style="cursor:pointer" title="<%=Resource.getValue(whir_locale,"mail","mail.ClickselectBcc")%>" onClick='click_selectbcc();'><span class="out" onmouseover="this.className='on'" onmouseout="this.className='out'"><%=Resource.getValue(whir_locale,"mail","mail.mailto")%></span></a>：
			  </td>
			 <td colspan="2">

				  <div class="whirTagitDiv">  
					<div class="whirTagitDivUL" style="width:87%;">  
						<ul id="mailbccUl" data-name="mailbccUl"></ul>  
					</div>  
					<div class="whirTagitDivArrow" style="width:13%;">  
						<a href="javascript:void(0);" class="selectIcoTagit" onclick="click_selectbcc();"></a>
						<input type="button" class="btnButton4font" onClick="deluser('mailbccUl','mailbccid','mailbcc');" value="<%=Resource.getValue(whir_locale,"mail","mail.clearSelection")%>" style="width:auto;"/>
					</div>  
					<input type="hidden" id="mailbcc" name="mailbcc" value="<%=mailbcc%>"/>  
					<input type="hidden" id="mailbccid" name="mailbccid" value="<%=mailbccid%>"/>
				 </div>

			 </td>
			</tr>
			<tr>
				<td width="100" class="td_lefttitle">&nbsp;&nbsp;</td>
				<td>
                    <input type="button" class="btnButton4font" id="but1" onClick="butccCk()" value="<%=Resource.getValue(whir_locale,"mail","mail.showcopyto")%>" />
					<input type="button" class="btnButton4font" id="but2" onClick="butbccCk()" value="<%=Resource.getValue(whir_locale,"mail","mail.showmailto")%>" />
				</td>
		    </tr>
            <%
			    
				if(internetMailSetList!=null && internetMailSetList.size()>0){
                    
					if("".equals(internetmailto)){
					  internetmailto = outmailremind;
					}
			%>
			<tr>    
			   <td width="100" class="td_lefttitle" for="<%=Resource.getValue(whir_locale,"mail","mail.outto")%>">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.outto")%>：    
			   </td>    
			   <td>    
				   <input type="text" name="internetmailto" id="internetmailto" maxlength="200" class="inputText" value="<%=internetmailto%>" 
				   style="width:95%;color:#CCCCCC" onfocus=if(this.value=="<%=outmailremind%>")this.value="";this.style.color=""; 
				   />
			   </td>    
		    </tr> 
			
		   <tr id="outcs_tr" style="display:none">    
			   <td width="100" class="td_lefttitle" for="<%=Resource.getValue(whir_locale,"mail","mail.outcc")%>">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.outcc")%>：    
			   </td>    
			   <td>    
				   <input type="text" name="internetmailcc" id="internetmailcc" style="width:95%" maxlength="200" class="inputText" value="<%=internetmailcc%>" />
			   </td>    
		    </tr>
			<tr id="outms_tr" style="display:none">    
			   <td width="100" class="td_lefttitle" for="<%=Resource.getValue(whir_locale,"mail","mail.outbcc")%>">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.outbcc")%>：    
			   </td>    
			   <td>    
				   <input type="text" name="internetmailbcc" id="internetmailbcc" style="width:95%" maxlength="200" class="inputText" value="<%=internetmailbcc%>" />
			   </td>    
		    </tr>
			<tr>
				<td width="100" class="td_lefttitle">&nbsp;&nbsp;</td>
				<td>
                    <input type="button" class="btnButton4font" id="but3" onClick="butoutccCk()" value="<%=Resource.getValue(whir_locale,"mail","mail.showcopyto")%>" />
					<input type="button" class="btnButton4font" id="but4" onClick="butoutbccCk()" value="<%=Resource.getValue(whir_locale,"mail","mail.showmailto")%>" />
				</td>
		   </tr>

			<tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;Internet邮箱：    
			   </td>    
			   <td>    
				   <select id="emailSetId"  name="emailSetId" class="selectlist" style="width:200px;">
						<%
						  for(int i=0;i<internetMailSetList.size();i++){
							   Object[] obj = (Object[])internetMailSetList.get(i);
						%>
						<option VALUE="<%=obj[0]%>" <%if("1".equals(obj[2]+"")){out.print("selected");}%>><%=obj[3]%></option>
						<%}%>
					</select> 
			   </td>    
		   </tr> 

		   <%}%>

		   <tr>    
			   <td width="100" class="td_lefttitle" for="<%=Resource.getValue(whir_locale,"mail","mail.title")%>">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.title")%><span class="MustFillColor">*</span>：    
			   </td>    
			   <td>    
				   <input type="text" name="mailsubject" id="mailsubject" maxlength="200" style="width:95%;color:#CCCCCC" class="inputText" value="<%=Resource.getValue(whir_locale,"mail","mail.noTitle")%>" onfocus="if(this.value=='<%=Resource.getValue(whir_locale,"mail","mail.noTitle")%>')this.value='';this.style.color='';" whir-options="vtype:['notempty','spechar3']" >
			   </td>    
		   </tr> 
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.sendoption")%>：    
			   </td>    
			   <td>    
				    <input type="checkbox" name="maillevel" id="maillevel" value="2" /><%=Resource.getValue(whir_locale,"mail","mail.urgency")%>
					<input type="checkbox" name="mailneedrevert" id="mailneedrevert" value="1"/><%=Resource.getValue(whir_locale,"mail","mail.receipt")%>  
					<input type="checkbox" name="mailSign" id="mailSign" value="1"/><%=Resource.getValue(whir_locale,"mail","mail.signature")%>  
					<input type="checkbox" name="mailanonymous" id="mailanonymous" value="1"/><%=Resource.getValue(whir_locale,"mail","mail.anonymous")%>
					<%    
					  if(sysRed.hasRtxOnline(CommonUtils.getSessionDomainId(request).toString())){
					%>
					<input type="checkbox" name="mailRTMessage" id="mailRTMessage" value="1" checked="checked"/><%=Resource.getValue(whir_locale,"mail","mail.imRemind")%>
					<%}%>
					<%if(falg&&managerBD.hasRight(CommonUtils.getSessionUserId(request).toString(),"09*01*01")){%>
					<input type="checkbox" name="mailneedsendMsg" id="mailneedsendMsg" value="1"/><%=Resource.getValue(whir_locale,"mail","mail.messageremind")%>
					<%}%>
					<%if("JC_".equals(cert)){%>
					<input type="checkbox" name="encrypt" id="encrypt" value="1" /><%=Resource.getValue(whir_locale,"mail","mail.encrypt")%>
					<%}%>
					<input type="checkbox" name="cloudcontrol" id="cloudcontrol" value="1"/>公有云控制
			   </td>    
		   </tr>
		   <%
			  List list=(List)request.getAttribute("accessoryList");
			  int arrlen=0;
			  if(list!=null){
				  arrlen=list.size();
			  }

			  String realFileArray="";//已经存在的文件 要在页面显示的文件名数组
			  String saveFileArray="";//已经存在的文件 文件的存储名(磁盘上的物理文件名)数组

			  Object[] obj;
			  if(list!=null&&!"0".equals(accessorySize)){
				  for(int i=0;i<arrlen;i++){
					  obj=(Object[])list.get(i);

					  realFileArray += obj[0]+"|";
					  saveFileArray += obj[1]+"|";
				  }
			  }

			%>
		   <tr>    
			   <td class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.attachment")%>：    
			   </td>    
			   <td>    
					<input type="hidden" name="realFileName" id="realFileName" style="width:800px;" value="<%=realFileArray%>"/>   
					<input type="hidden" name="saveFileName" id="saveFileName" style="width:800px;" value="<%=saveFileArray%>"/> 
					<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
					   <jsp:param name="dir"      value="innerMailbox" />
					   <jsp:param name="uniqueId"    value="uniqueId" />
					   <jsp:param name="realFileNameInputId"    value="realFileName" />
					   <jsp:param name="saveFileNameInputId"    value="saveFileName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="multi"        value="true" />
					   <jsp:param name="buttonClass" value="upload_btn" />
					   <jsp:param name="fileSizeLimit"        value="0" />
					   <jsp:param name="uploadLimit"      value="0" />
					   <jsp:param name="onSelect"         value="clickAcc" />
					   <jsp:param name="onUploadSuccess"      value="backAcc" />
					</jsp:include>
			   </td>    
		   </tr>
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;<%=Resource.getValue(whir_locale,"mail","mail.textformat")%>：    
			   </td>    
			   <td>
				   <input type="radio" name="mailcontenttype" value="0" <%if("".equals(mailcontenttype)||"0".equals(mailcontenttype)){out.print("checked");}%> onClick="displayNormal('0');"><%=Resource.getValue(whir_locale,"mail","mail.text")%>&nbsp;&nbsp;<input type="radio" name="mailcontenttype" value="1" <%if("1".equals(mailcontenttype)){out.print("checked");}%> onClick="displayNormal('1');">HTML
			   </td>    
		   </tr> 
		   <%if("".equals(mailcontenttype)||"0".equals(mailcontenttype)){%>
			   <tr id="content_text" style="display:" >    
				   <td colspan="2" class="td_lefttitle">
				   &nbsp;
				   <textarea id="mailcontentText" name="mailcontentText" style="width:94%;height:400px;word-break:break-all;word-wrap:break-word;"  rows="20" class="inputTextarea"><%=mailcontent%></textarea>
				   </td>    
			   </tr>
			   <tr id="html_text" style="display:none">    
				   <td colspan="2" class="td_lefttitle">
				      <div id="htmlDIV">
					      <IFRAME id="mailcontentHtml" src="public/edit/ewebeditor.htm?id=content1&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="95%" height="400"></IFRAME>
						  <input type="hidden" name="content1"  id="content1" value=''>
					  </div>
				   </td>    
			   </tr> 
		   <%}else{%>
			    <tr id="content_text" style="display:none">    
				   <td colspan="2" class="td_lefttitle">
				   &nbsp;
				   <textarea id="mailcontentText" name="mailcontentText" style="width:94%;height:400px;word-break:break-all;word-wrap:break-word;" rows="20" class="inputTextarea" ></textarea>
				   </td>    
			   </tr>
			   <tr id="html_text" style="display:">    
				   <td colspan="2" class="td_lefttitle1">
					  <div id="htmlDIV">
						  <IFRAME id="mailcontentHtml" src="public/edit/ewebeditor.htm?id=content1&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="95%" height="400"></IFRAME>
				           <input type="hidden" name="content1"  id="content1" value='<%=mailcontent.replaceAll("'","&#39;")%>'>
					  </div>
				   </td>    
			   </tr> 

		   <%}%>
		   
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   &nbsp;&nbsp;
			   </td>    
			   <td>    
				  <input type="checkbox"  name="savetosended" value="1" checked><%=Resource.getValue(whir_locale,"mail","mail.savetosended")%>
			   </td>    
		   </tr>
		   <input name="modi_id" id="modi_id" type="hidden">
		   <input name="mailisdraft" id="mailisdraft" type="hidden">
		   <tr>    
			   <td width="100" class="td_lefttitle">&nbsp;</td>    
			   <td>  
			         
					<%//回复转发
					   if(request.getParameter("replyType")!=null){
					         
							if("modify".equals(request.getParameter("replyType"))){
					%>
								<input type="button" class="btnButton4font" onClick='saveAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.undersend")%>" />
								<input type="button" class="btnButton4font" onClick='sendAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.sendquit")%>" />
								<input type="button" class="btnButton4font" onClick='delDrafts(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>" />
								<input type="button" class="btnButton4font" onClick='resetDataForm(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.reset")%>" />
								<input type="button" class="btnButton4font" onClick='closeWindow(null);' value="<%=Resource.getValue(whir_locale,"mail","mail.quit")%>" />
								<%if(index>0){%>
								 <input type="button" class="btnButton4font" onClick="goNextMail('<%=index-1%>');" value="<%=Resource.getValue(whir_locale,"mail","mail.preMail")%>" />
								<%}%>
								<%if(index<recordCount-1){%>
								 <input type="button" class="btnButton4font" onClick="goNextMail('<%=index+1%>');" value="<%=Resource.getValue(whir_locale,"mail","mail.nextMail")%>" />
								<%}%>
					        <%}else{
						        //回复，转发等清空修改id
								mail_id="";
						     %>
								<input type="button" class="btnButton4font" onClick='sendAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.sendquit")%>" />
								<input type="button" class="btnButton4font" id="savebutton" onClick='saveAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.undersend")%>" />
								<input type="button" class="btnButton4font" onClick='closeWindow(null);' value="<%=Resource.getValue(whir_locale,"mail","mail.quit")%>" />
							<%}%>
					<%}else{%>
					        <input type="button" id="sendAndExitbutton"  class="btnButton4font" onClick='sendAndExit(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.sendquit")%>" />
				            <input type="button" id="sendAndContinuebutton"  class="btnButton4font" onClick='sendAndContinue(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.sendcontinue")%>" />
				            <input type="button" id="savebutton"  class="btnButton4font" onClick='save(this);' value="<%=Resource.getValue(whir_locale,"mail","mail.savedraft")%>" />
							<input type="button"  class="btnButton4font" onClick='winClose();' value="<%=Resource.getValue(whir_locale,"mail","mail.quit")%>" />
				  <%}%>
				  <input type="hidden" name="modiId" id="modiId" value="<%=mail_id%>">

				  <input type="hidden" name="informationIdForMail" value="<%=request.getParameter("informationIdForMail")%>">
                  <input type="hidden" name="channelIdForMail" value="<%=request.getParameter("channelIdForMail")%>">
			   </td>    
		   </tr> 
	     </table>
         
       </div>

        </s:form>  
</body>  
  
<script type="text/javascript">  
	//*************************************下面的函数属于公共的或半自定义的*************************************************//  
  
	//设置表单为异步提交  
	//initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'发送',"reset":'no'});  
  
     initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'<%=Resource.getValue(whir_locale,"mail","mail.send")%>'}); 
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  

function click_selectto(){

 <%if("can".equals(canChooseOrg)){%>
    openSelect({allowId:'mailtoid', allowName:'mailto', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*', tagitId:'mailtoUl'});
 <%}else{%>
	openSelect({allowId:'mailtoid', allowName:'mailto', select:'user', single:'no', show:'userorggroup', range:'*0*', tagitId:'mailtoUl'});
 <%}%>  
   
}
function click_selectcc(){
 
 <%if("can".equals(canChooseOrg)){%>
    openSelect({allowId:'mailccid', allowName:'mailcc', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*', tagitId:'mailccUl'});
 <%}else{%>
	openSelect({allowId:'mailccid', allowName:'mailcc', select:'user', single:'no', show:'userorggroup', range:'*0*', tagitId:'mailccUl'});
 <%}%>  
   
}
function click_selectbcc(){
 
 <%if("can".equals(canChooseOrg)){%>
    openSelect({allowId:'mailbccid', allowName:'mailbcc', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*', tagitId:'mailbccUl'});
 <%}else{%>
	openSelect({allowId:'mailbccid', allowName:'mailbcc', select:'user', single:'no', show:'userorggroup', range:'*0*', tagitId:'mailbccUl'});
 <%}%>  
   
}

function Initialize(){
	
   

   InitData();

   $('.autoHeight').each(function(){
       if(this.scrollHeight>27){
		 $(this).height(this.scrollHeight);
	   }
	   
	});
}
function InitData(){

   <%if(mailsubject!=null&&!"null".equals(mailsubject)&&!"".equals(mailsubject)){%>
      document.getElementById("mailsubject").value="<%=mailsubject%>";
	  document.getElementById("mailsubject").style.color='';
   <%}%>
	
   <%
   //回复转发设置数据
   if(request.getParameter("replyType")!=null){%>

	  //有抄送人 打开
	  if(document.getElementById("mailcc").value!=""||
		  document.getElementById("mailccid").value!=""){
		 butccCk();
	  }
	  //有密送人 打开
	  if(document.getElementById("mailbcc").value!=""||
		  document.getElementById("mailbccid").value!=""){
		 butbccCk();
	  }
      
	  if(document.getElementById("internetmailto")){

		  <%if(!"".equals(internetmailcc)){%>
			butoutccCk();
		  <%}%>
		  <%if(!"".equals(internetmailbcc)){%>
			butoutbccCk();
		  <%}%>

	  }

	  <%if("2".equals(maillevel)){%>
		  $("input[name='maillevel']").each(function(){
			 if($(this).val()==2){
				$(this).attr("checked","checked");
			 }
		  });
	  <%}%>
	  <%if("1".equals(mailneedrevert)){%>
		 $("input[name='mailneedrevert']").each(function(){
			 if($(this).val()==1){
				$(this).attr("checked","checked");
			 }
		  });	  
	  <%}%>
	  <%if("1".equals(mailSign)){%>
		  $("input[name='mailSign']").each(function(){
			 if($(this).val()==1){
				$(this).attr("checked","checked");
			 }
		  });
	  <%}%>
	  <%if("1".equals(mailanonymous)){%>
		  $("input[name='mailanonymous']").each(function(){
			 if($(this).val()==1){
				$(this).attr("checked","checked");
			 }
		  });	  
	  <%}%>
	  <%if("1".equals(mailRTMessage)){%>
		  if(document.getElementById("mailRTMessage")){
				$("input[name='mailRTMessage']").each(function(){
				 if($(this).val()==1){
					$(this).attr("checked","checked");
				 }
			  });
		  }
	  <%}%>
	  <%if("1".equals(sendSms)){%>
		  if(document.getElementById("mailneedsendMsg")){
			  $("input[name='mailneedsendMsg']").each(function(){
				 if($(this).val()==1){
					$(this).attr("checked","checked");
				 }
			  });
		  }
	  <%}%>
	  <%if("1".equals(encrypt)){%>
		  if(document.getElementById("encrypt")){
			 $("input[name='encrypt']").each(function(){
				 if($(this).val()==1){
					$(this).attr("checked","checked");
				 }
			  });
		 }
	  <%}%>
	   <%if("1".equals(cloudcontrol)){%>
		  if(document.getElementById("cloudcontrol")){
			 $("input[name='cloudcontrol']").each(function(){
				 if($(this).val()==1){
					$(this).attr("checked","checked");
				 }
			  });
		 }
	  <%}%>
   <%}else{%>
      <%if("1".equals(mailneedrevert)){%>
		 $("input[name='mailneedrevert']").each(function(){
			 if($(this).val()==1){
				$(this).attr("checked","checked");
			 }
		  });	  
	  <%}%>
	  <%if("1".equals(mailSign)){%>
		  $("input[name='mailSign']").each(function(){
			 if($(this).val()==1){
				$(this).attr("checked","checked");
			 }
		  });
	  <%}%>
   <%}%>
}
var cansend="1";
function delDrafts() {
	 ajaxOperate({urlWithData: 'innerMail!delDrafts.action?mailid=<%=mail_id%>',tip:'<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>',isconfirm:true,callbackfunction:closess});
}
function clickAcc(json) {
	cansend="0";
	onSelect(json);
}
function backAcc(json) {
	
	cansend="1";
    onUploadSuccess(json);
	var realFileName = $('#realFileName').val();
	if($('#mailsubject').val() == "<%=Resource.getValue(whir_locale,"mail","mail.noTitle")%>"||
		$('#mailsubject').val().trim() == ""){
		realFileName = realFileName.substring(0,realFileName.lastIndexOf('.'));
	   $('#mailsubject').val(realFileName);
	   document.getElementById("mailsubject").style.color="";
	}
}

var js_send = "<%=Resource.getValue(whir_locale,"mail","mail.send")%>";
var js_entercode='<%=Resource.getValue(whir_locale,"mail","mail.entercode")%>';
var js_save='<%=Resource.getValue(whir_locale,"mail","mail.save1")%>';
var js_outmailremind="<%=outmailremind%>";
</script>  
  <script src="<%=rootPath%>/modules/comm/comm_mail/js/innerMail.js"></script>
</html>  
