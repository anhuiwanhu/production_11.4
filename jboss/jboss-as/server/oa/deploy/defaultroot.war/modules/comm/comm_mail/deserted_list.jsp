<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<script language="JavaScript" src="scripts/i18n/<%=whir_locale%>/CommonResource.js" type="text/javascript"></script>
<script language="JavaScript" src="scripts/i18n/<%=whir_locale%>/MailResource.js" type="text/javascript"></script>

<%
    String cert = "";
	if(session.getAttribute("cert") !=null){
		cert = session.getAttribute("cert").toString();
	}
%>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/innerMail!getDesertedList.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
        <tr>  
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%>：&nbsp;</td>  
            <td class="whir_td_searchinput">  
				<input type="text" id="searchsubject" name="searchsubject" size="14" class="inputText" />  
            </td>  
            <td class="whir_td_searchtitle">
			  <%=Resource.getValue(whir_locale,"mail","mail.addresser")%>：
			 </td>  
            <td class="whir_td_searchinput">  
                <input type="text" id="searchuser" name="searchuser" size="14" value="" class="inputText" />  
            </td>  
        </tr>  
        <tr>  
            <td class="whir_td_searchtitle"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%>：</td>  
            <td class="whir_td_searchinput" colspan="2">   
				<input type="text" class="Wdate whir_datebox" id="searchsendtime_s" name="searchsendtime_s" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'searchsendtime_e\',{d:0});}'})"/>
				<%=Resource.getValue(whir_locale,"mail","mail.to1")%>
				<input type="text" class="Wdate whir_datebox" id="searchsendtime_e" name="searchsendtime_e" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'searchsendtime_s\',{d:0});}'})"/>
            </td>  
            <td class="SearchBar_toolbar">  
                <!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->  
                <input type="button" class="btnButton4font"  onclick="searchform();"  value="<%=Resource.getValue(whir_locale,"common","comm.searchnow")%>" />  
                <!--resetForm(obj)为公共方法-->  
                <input type="button" class="btnButton4font" value="<%=Resource.getValue(whir_locale,"common","comm.clear")%>" onclick="resetForm(this);" />  
            </td>  
        </tr>  
    </table>  
    <!-- SEARCH PART END --> 

	<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="left" width="55%">
			    <%
				java.text.DecimalFormat df = new java.text.DecimalFormat("#0.00");
				Float mailboxSize = (Float) request.getAttribute("mailboxSize");
				%>
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed">
				<%if(mailboxSize.floatValue() < 0){%>
                <span style="color:red"><%=Resource.getValue(whir_locale,"mail","mail.oversize")%></span>
                <%}else{%>
                <%=Resource.getValue(whir_locale,"mail","mail.capacity")%>：<%=df.format(mailboxSize.floatValue()) %> M
                <%}%>
				</span>
            </td>
            <td align="right">
				<!--select name="boxName" id="boxName" class="easyui-combobox111" data-options="panelHeight:'auto',onSelect: function(record){moveMails(record);}"-->
				<select name="boxName" id="boxName" onchange="moveMails(this);">
                    <option selected value="0" ><%=Resource.getValue(whir_locale,"mail","mail.transferto")%> </option>
                    <option  value="toSendedBox"><%=Resource.getValue(whir_locale,"mail","mail.sendbox")%></option>
                    <option  value="toReceiveBox"><%=Resource.getValue(whir_locale,"mail","mail.inbox")%></option>
                    <logic:iterate id="folderList" name="folderList" scope="request" >
                        <%Object[] obj = (Object[]) folderList;%>
                        <option  value=<%=obj[0]%>><%=obj[1]%></option>
                    </logic:iterate>
                </select>
                <input type="button" class="btnButton4font" onclick="delMails();" value="<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>" />
				<input type="button" class="btnButton4font" onclick="clearMails();" value="<%=Resource.getValue(whir_locale,"mail","mail.clear")%>" />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer" whir-options="renderer:showread">
        <tr class="listTableHead">
			<td whir-options="field:'mailuserid',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('mailuserid',this.checked);" ></td>
			<td whir-options="field:'poster',width:'18%',renderer:showPoster"><%=Resource.getValue(whir_locale,"mail","mail.addresser")%></td> 
			<td whir-options="field:'title',width:'55%',renderer:showTitle"><%=Resource.getValue(whir_locale,"mail","mail.title")%></td> 
			<td whir-options="field:'accessorySize', width:'10%',allowSort:true,renderer:showAcc"><%=Resource.getValue(whir_locale,"mail","mail.filesize")%></td> 
			<td whir-options="field:'mailposttime', width:'15%',renderer:getmailposttime"><%=Resource.getValue(whir_locale,"mail","mail.sendtime")%></td> 
			<!--
			<td whir-options="field:'reveivetime', width:'15%',renderer:showreveivetime"><%=Resource.getValue(whir_locale,"mail","mail.reveivetime")%></td> 
			-->
        </tr>
		</thead>
		<tbody  id="itemContainer" >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->

	</s:form>


</body>


	<script type="text/javascript">

   //*************************************下面的函数属于公共的或半自定义的*************************************************//  
  
    //初始化列表页form表单,"queryForm"是表单id，可修改。  
    $(document).ready(function(){         
        initListFormToAjax({formId:"queryForm"});         
    });
      
    //*************************************下面的函数属于各个模块 完全 自定义的*************************************************//                         
    function showread(po,i){
	   var rt = '';
	   if(po.notRead==1){
	      rt = 'style="color:red;"';
	   }
       return rt;
    }
	function showPoster(po,i){
		var html='';

		var sendMailUser = po.mailpostername;
		if(po.mailpostername==null){
		   sendMailUser = "&nbsp;";
		}
		  if(sendMailUser.indexOf(",") > 0){
			  sendMailUser = sendMailUser.substring(0, sendMailUser.indexOf(","));
		  }
		  if(sendMailUser.indexOf("<") > 0){
			  sendMailUser = sendMailUser.substring(sendMailUser.indexOf("<") + 1);
		  }
		  if(sendMailUser.indexOf("/") > 0){
			  sendMailUser = sendMailUser.substring(0, sendMailUser.indexOf("/"));
		  }
		  if(sendMailUser.indexOf("_") > 0){
			  sendMailUser = sendMailUser.substring(0, sendMailUser.indexOf("_"));
		  }
		  if(po.notRead==1){
			  html = sendMailUser;
		  }else{
			  if(sendMailUser.indexOf("匿名") > 0){
				html = '<%=Resource.getValue(whir_locale,"mail","mail.anonymous")%>';
			  }else{
				html = sendMailUser;
			  }
		  }

		return html;
	}
                                      
    function showTitle(po,i){

		//计算当前数据偏移量
		var index = i + parseInt(document.getElementById("start_page").value-1)*parseInt(document.getElementById("page_size").value);

		var html='';
		if(po.mailhasaccessory==1){
		   html +='<img src="images/fj2.gif" title="<%=Resource.getValue(whir_locale,"mail","mail.fujian")%>">';
		}
        var mailtitle="";
		if(po.mailsubject==null){
		   mailtitle = "<%=Resource.getValue(whir_locale,"mail","mail.noTitle")%>";
		}else{
		   mailtitle = HtmlEncode(po.mailsubject);
		}
		if(po.encrypt!=null && po.encrypt==1){
		   mailtitle += "(<%=Resource.getValue(whir_locale,"mail","mail.encrypt")%>)";
		}
		if(po.notRead==1){
		  mailtitle = "<font color='red'>"+HtmlEncode(mailtitle)+"</font>";
		}

		if(po.encrypt==null || po.encrypt==0){
			html +=  '<a href="javascript:void(0)" onclick="view('+po.mailuserid+','+po.mailid+','+index+');">'+mailtitle+'</a>';  
		}else if ("<%=cert%>"=="JC_" && po.encrypt==1){
			html +=  '<a href="javascript:void(0)" onclick="view('+po.mailuserid+','+po.mailid+','+index+');">'+mailtitle+'</a>'; 
		}else{
            html += '<a href="javascript:void(0)" onclick="alertr();">'+HtmlEncode(po.mailsubject)+'</a>'; 
		}
		return html;
	}

	function view(mailuserid,mailid,index){
		
		//数据总条数
		var recordCount=document.getElementById("recordCount").value;
	    openWin({url:'innerMail!viewMail.action?mailuserid='+mailuserid+'&mailid='+mailid+'&index='+index+'&recordCount='+recordCount+'&frommod=desertedbox',isFull:'true',winName: 'viewmail'+mailid });
	}
	function alertr() {
	  alert(Mail.encryptmail);
	  return;
	}

	function showAcc(po,i){
		var html= "";
		if(po.accessorySize!=null && po.accessorySize!="null" && po.accessorySize!=""){
	       html= formatFileSize(po.accessorySize);
		}
	   return html;
	}

	function getmailposttime(po,i){
		//var html = getFormatDateByLong(po.mailposttime, 'yyyy-MM-dd hh:mm');
		var html = po.mailposttime.substring(0,16);
		return html;
	}
	function showreveivetime(po,i){
		var html = "&nbsp;";
		if(po.mailreceivetime!=null)
		   getFormatDateByLong(po.mailreceivetime, 'yyyy-MM-dd hh:mm');
		return html;
	}

	function delMails() {
		 ajaxBatchOperate({url:"innerMail!delMails.action",checkbox_name:"mailuserid",attr_name:"mailuserid",tip:'<%=Resource.getValue(whir_locale,"mail","mail.deleteerase")%>',isconfirm:true,formId:"queryForm",callbackfunction:null});
	}
	function moveMails(obj) {
	     ajaxBatchOperate({url:"innerMail!moveMails.action?boxId="+obj.value,checkbox_name:"mailuserid",attr_name:"mailuserid",isconfirm:false,formId:"queryForm",callbackfunction:null});
		 //$('#boxName').combobox('setValue', 0);
	}
	function clearMails() {
		whir_confirm("<%=Resource.getValue(whir_locale,"mail","mail.remind19")%>", function(){
		ajaxForAsync("innerMail!clearMails.action","",function(){window.refreshListForm_('queryForm');}); 
		}, null); 
		 
	}
	function searchform() {

	   var searchsubject = $('#searchsubject').val();
	   var searchuser = $('#searchuser').val();

	  if(searchsubject.indexOf("'") >= 0){
		  whir_alert(Mail.querycondition,null);
		  document.getElementById("searchsubject").focus();
		  return;
	  }
	  if(searchuser.indexOf("'") >= 0){
		  whir_alert(Mail.querycondition,null);
		  document.getElementById("searchuser").focus();
		  return;
	  }
	  refreshListForm('queryForm');

	}
	
   </script>

</html>

