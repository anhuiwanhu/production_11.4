<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovCustomFieldPO"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovCustomCheckedFieldPO"%>
<%@ page import="com.whir.ezoffice.customdb.customdb.po.FieldPO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改表单</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<script type='text/javascript' src='<%=rootPath%>/modules/govoffice/custom_documentmanager/js/common.js'></script>
<script type='text/javascript' src='<%=rootPath%>/modules/govoffice/custom_documentmanager/js/custFormAnsc.js'></script>
<link rel="stylesheet" type="text/css" href="<%=rootPath%>/modules/govoffice/custom_documentmanager/ext/resources/css/ext-all.css"/>
<script type="text/javascript" src="<%=rootPath%>/modules/govoffice/custom_documentmanager/ext/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="<%=rootPath%>/modules/govoffice/custom_documentmanager/ext/ext-all.js"></script>

<%
 
String canModifyEmpId=request.getAttribute("canModifyEmpId")==null?"":request.getAttribute("canModifyEmpId").toString();
String canModifyEmpName=request.getAttribute("canModifyEmpName")==null?"":request.getAttribute("canModifyEmpName").toString();
String canManageEmpId=request.getAttribute("canManageEmpId")==null?"":request.getAttribute("canManageEmpId").toString();
String canManageEmpName=request.getAttribute("canManageEmpName")==null?"":request.getAttribute("canManageEmpName").toString();
 int nowYear = (new Date().getYear()) + 1900;
 
 // 发文还是收文  默认 发文：0   收文：1  文件送：2
  String  govFormType="0";
  if(request.getParameter("govFormType")!=null&&!request.getParameter("govFormType").toString().equals("")){
   govFormType=request.getParameter("govFormType");
  }
	String govFormName="ff";
    if(request.getAttribute("govFormName")!=null&&!request.getAttribute("govFormName").toString().equals("")){
		govFormName=request.getAttribute("govFormName").toString();
	}

  String id=request.getParameter("id").toString();

   // 是显示表单 还是 打印表单    0:显示表单  1：打印表单
  String  gffType="0";
  if(request.getParameter("gffType")!=null&&!request.getParameter("gffType").toString().equals("")){
   gffType=request.getParameter("gffType"); 
  }

  String formId=request.getParameter("formId").toString();

  String customContent="";
  if(request.getAttribute("customContent")!=null){
    customContent=request.getAttribute("customContent").toString();
  }

  //
  String fieldelt="";

  com.whir.govezoffice.documentmanager.bd.CovCustomBD  cbd=new com.whir.govezoffice.documentmanager.bd.CovCustomBD();
  List fieldList=new ArrayList();

  if(request.getAttribute("fieldList")!=null){
	  fieldList=(List)request.getAttribute("fieldList");
  }


  List  checkFieldList=new ArrayList();
  if(request.getAttribute("checkFieldList")!=null){
      checkFieldList=(List)request.getAttribute("checkFieldList");
  }%>

  <script language="javascript">
	var govFieldArr = new Array(<%=fieldList.size()%>);
	<%
	for(int fi=0;fi<fieldList.size();fi++){

		FieldPO fpo=(FieldPO)fieldList.get(fi);

		String fieldName=fpo.getFieldCode();//getGffName();
		String displayName=fpo.getFieldDesName();//getGffDisplayName();
		String  displayType="";//+fpo.getGffFieldType();
		String  isChecked=" ";
		String fieldValue = fpo.getFieldValue();//gov.Field10;
		
		if("999".equals(fpo.getShowPO().getShowId().toString()) && null!=fieldValue && !"".equals(fieldValue)){
			fieldValue = fieldValue.replaceAll("gov\\.Field","");
		}else{
			fieldValue = "0";
			fieldName = fpo.getTablePO().getTableName() + "-"+ fpo.getFieldName();
		}

		int   gffLength=fpo.getFieldLen().intValue();//fpo.getGffLength();
		int   gffDisplayType=Integer.parseInt(fieldValue);//fpo.getGffDisplayType();  getFieldValue(),截取最后的 数字
		int   gft=0;//fpo.getGffFieldType();
		System.out.println( "[[[[[[[[[[[[[[["+fpo.getFieldInType() );
		String  tips=" ";
	 switch (gffDisplayType) {
		   case 0:{//普通输入框
			   if(gft==0){
				   tips="字符型("+gffLength+")";				   
			   }else if(gft==1){
				   tips="数值型("+gffLength+")";				   
			   }else if(gft==3){
				   tips="字符型("+gffLength+")";			   
			   }
			   break;
		   }
		   case 1:{// 时间
			   tips="时间";
			   break;
		   }
		   case 2:{//选择框
			   tips="下拉选择";
			   break;
		   }
		   case 4: {//选组织并可修改
			   tips="选组织并可修改";
			   break;
		   }
		   case 5: {//附件
			   tips="附件";
			   break;
		   }

		   case 6: {//机关代字
				tips="机关代字";
			   break;
		   }

		   case 7: {// 文号
			   tips="文号";
			   break;
		   }

		   case 8: {//流水号
			   tips="流水号";
			   break;
		   }
		   case 9: {//流水号
			  tips="主题词";
			  break;
		 }
		 case 10: { //流水号
			  tips="批示意见";
			 break;
		}case 12: { //多行文本
			  tips="字符型("+gffLength+")";
			 break;
		 }case 13: { //word编辑
			  tips="word编辑";
			 break;
		 }case 14: { //excel编辑
			  tips="excel编辑";
			 break;
		 }case 15: { //日期时间
			  tips="日期时间";
			 break;
		 }case 16: { //日期时间
			  tips="日期";
			 break;
		 }case 17: { //日期时间
			  tips="上传";
			 break;
		 }
	   }
 
	
	  if(checkFieldList!=null){
            for(int jj=0;jj<checkFieldList.size();jj++){
              GovCustomCheckedFieldPO  po=(GovCustomCheckedFieldPO)checkFieldList.get(jj);
              if(fieldName.equals(po.getGffName())){
                 displayName=po.getGffDisplayName();   
				 isChecked="checked=\\\"checked\\\"";
				 fieldelt+=fieldName+";";
              }          
            }
	  }
	 
	%>

	govFieldArr[<%=fi%>] = new Array('<%=fieldName%>','<%=displayName%>','<%=displayType%>','<%=isChecked%>','<%=tips%>');

	<%}%>
 </script>

 <% 

 int index=0;
  Object[] obj = null;
 if("1".equals(request.getAttribute("close"))){
  %>
   <script language="javascript">
	  alert("保存成功！");
	 window.close();
	 opener.query();
     //opener.location.href="<%=rootPath%>/GovCustomAction.do?action=list&govFormType=<%=govFormType%>&pager.offset=<%=request.getParameter("pager.offset")%>";
     //opener.parent.topFrame.window.location.reload();
   </script>
<%
}else{%>
<%if("1".equals(request.getAttribute("stat"))){%>
<script language="javascript">
	alert("表单名重复！请更换名称！");
</script>
<%} if("0".equals(request.getAttribute("stat"))){%>
	<script language="javascript">
		alert("新增表单失败，请重试或与管理员联系！");
	</script>
<%}%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改<%="1".equals(request.getParameter("isPrint"))?"打印":""%>表单信息</title>
<link href="skin/<%=session.getAttribute("skin")%>/style.css" rel="stylesheet" type="text/css" />
<link rel=stylesheet type="text/css" href="<%=rootPath%>/public/date_picker/DateObject2.css">
<SCRIPT language="javascript" src="<%=rootPath%>/js/openEndow.js"></SCRIPT>

</head>
<body   style="position:relative;overflow:auto ">
<div class="BodyMargin_10">  
  <div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="GovCustom!editSaveForm.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
	<input type="hidden" name="operate" />
	<input type="hidden" name="fieldelt"  value="<%=fieldelt%>" id="fieldelt"/>
	<input type="hidden" name="pageid" value="<%=request.getParameter("pageid")%>"/>
	<input type="hidden" name="pager.offset" value="<%=request.getParameter("pager.offset")%>">
	<input type="hidden" name="govFormType" value="<%=govFormType%>" id="govFormType">
	<input type="hidden" name="gffType"  value="<%=gffType%>"  id="gffType">
	<input type="hidden" name="displayValues" value=""   id="displayValues">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="hidden" name="formId" value="<%=formId%>"  id="formId" >
	<input type="hidden" name="action" value="modify"  id="action">
	 <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
		<tr>
			  <td width="90" nowrap="nowrap" for="表单名称" class="td_lefttitle">
			  		表单名称<label class="MustFillColor">*</label>：
			  </td>
			  <td>
					<input name="govFormName" id="govFormName" maxlength="30" <%if(gffType.equals("1")){ out.print("readonly");}%> type="text" value='<%=govFormName%>' class="inputText" style="width:95%" onKeyDown="javascript:if(event.keyCode==13) return false;" whir-options="vtype:['notempty']" />
			  </td>
		</tr>
		<tr>
			<td class="td_lefttitle">使用范围：</td>
			<td >
				 <textarea name="canModifyEmpName" id="canModifyEmpName" class="inputTextarea"  readonly="true" wrap="soft" style="width:95%;height:50px"><%=canModifyEmpName%></textarea>
				 <input type="hidden" name="canModifyEmpId" id="canModifyEmpId" value="<%=canModifyEmpId%>"><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'canModifyEmpId', allowName:'canModifyEmpName', select:'user', single:'no', show:'user', range:'*0*'});"/>
				 <!--<br>
				 <label class="MustFillColor" nowrap>“使用范围”为空时默认所有用户。</label>-->
			</td>
		</tr>
		<tr><td ></td>
			<td >
				 <label class="MustFillColor" nowrap>“使用范围”为空时默认所有用户。</label>
			</td>
		</tr>
		<tr>
			<td class="td_lefttitle">维护范围：</td>
			<td>
				 <textarea name="canManageEmpName" id="canManageEmpName"  class="inputTextarea"  readonly="true" wrap="soft" style="width:95%;height:50px"><%=canManageEmpName%></textarea>
				 <input type="hidden" name="canManageEmpId" id="canManageEmpId" value="<%=canManageEmpId%>">
				 <a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'canManageEmpId', allowName:'canManageEmpName', select:'user', single:'no', show:'user', range:'*0*'});"/>
			</td>
		</tr>
		<tr>
			<td class="td_lefttitle"><%="1".equals(request.getParameter("gffType"))?"打印模板":"显示模板"%>：</td>
			<td >
				 <%if(!"1".equals(request.getParameter("gffType"))){%><input type="checkbox" name="syncPrintForm" value="1">同步到打印模板<%}%>
			</td>
		</tr>
		 <tr id="fckLine" style="display:">
                <td id="fckCon" colspan="2">
					    <table width="100%" border="0">
							<tr>
							   <td style="width:85%" >
							   <input type="hidden" name="code"/>
							   <textarea name="codeTemp" style="display:none"><%=customContent%></textarea>
							   <div id="codeDIV" style="display:none"><%=customContent%></div>
									<IFRAME id="pinEditID1" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=code&style=coolblue&hiddenCodeTab=0&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>" frameborder="0" scrolling="no" width="100%" height="520"  onload="initEditor();"></IFRAME>
									<%/*
									String height = "520px";
									String width = "100%";*/
									%>
								  <%//@ include file="/public/pinEditor/editor/editor.jsp"%>
							   </td>
							   <td style="width:20%" id="fieldDIV" valign="top">

							   </td>
							</tr>
						</table>
                </td>
        </tr>
		<tr  height="25%" valign="top">
          <td></td>
          <td>
				<input type="button" class="btnButton4font" onClick="javascript:save1('addquit',this);" value="保存退出"/>
                <input type="button" class="btnButton4font" onClick="javascript:resetDataForm(this);"  value="重　置"/>
                <input type="button" class="btnButton4font" onClick="javascript:window.close();"  value="退　出"/>
		  </td>
        </tr>
    </table>

	<div id=adddelrow_div
		style="BORDER-RIGHT: #0a246a 1px solid; BORDER-TOP: #0a246a 1px solid; VISIBILITY: hidden; BORDER-LEFT: #0a246a 1px solid; WIDTH: 50px; BORDER-BOTTOM: #0a246a 1px solid; POSITION: absolute">
		<table height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
		  <tbody>
		  	<tr>
			    <td onMouseOver="this.style.borderRiht='1px #0A246A solid'" onmouseout="this.style.borderRiht=''" align=middle>
				    <span id=delrow_div title=点击删除重复项 style="CURSOR: hand">
				    	<img height=15 src="<%=rootPath%>/custom_form/images/delarrow.gif" width=16 align=absMiddle>
				    </span> 
			    </td>
			    <td onMouseOver="this.style.borderLeft='1px #0A246A solid'" onmouseout="this.style.borderLeft=''" align=middle>
				    <span id="addrow_div" title="点击添加重复项"  style="CURSOR: hand">
				    	<img height=15 src="<%=rootPath%>/custom_form/images/addarrow.gif" width=16 align=absMiddle>
				    </span>
			  	</td>
		  	</tr>
		</tbody>
	  </table>
  	</div>
  </s:form>
 </div>
</div>
</body>
<script language="javascript">

$(document).ready(function(){		
//	$('#pinEditID1')[0].src="<%=rootPath%>/public/edit/ewebeditor.htm?id=code&style=coolblue&hiddenCodeTab=0&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>";
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

});


function initEditor(){
	 gov_showFile(govFieldArr);
	 // pinEditID1.insertHTML(        document.all.codeDIV.innerHTML);
	  if($.browser.msie){
			pinEditID1.insertHTML( $("#codeDIV")[0].innerHTML );
	  }else{
			$("#pinEditID1")[0].contentWindow.insertHTML( $("#codeDIV")[0].innerHTML );
	  }
	 //pinEditID1.insertHTML( $("#codeDIV")[0].innerHTML );
	 //document.all.codeDIV.innerHTML = "";
	 $("#codeDIV")[0].innerHTML = "";
}

function postWindowReload(sURL,winName,features) { //v2.0
   var  oW ;
   oW=window;//.open('','',features);
   var  contents="";
   var  mainUrl=""; 
  // <input   style=display:none   type=text   name=submitData> 
  // setTimeout( "startSubmit() ",50);
  // encodeURI(theURL)
  // window.open(encodeURI(theURL),winName,features);

   if (sURL.indexOf("?") > 0)
   {
      //分解URL,第二的元素为完整的查询字符串
       var arrayParams = sURL.split("?");   
       //分解查询字符串
       var arrayURLParams = arrayParams[1].split("&");
	   mainUrl=arrayParams[0];     
       //遍历分解后的键值对
       for (var i = 0; i < arrayURLParams.length; i++)
       {       
          //分解一个键值对
          var sParam =  arrayURLParams[i].split("=");  
          if ((sParam[0] != "") && (sParam[1] != ""))
          { 
			  contents+=" <input  type=\"hidden\"   name=\""+sParam[0] +"\"  value=\""+sParam[1]+"\" >";	 
          }
       }  
  }else{
	  mainUrl=sURL;
  
  }

   oW.document.write('<form   name= "postform"   action="'+mainUrl+'"  method= "post">'+contents+'</form>') ;
   oW.postform.submit();

  /*

  setTimeout( "startSubmit() ",50);
  function startSubmit(){
	  alert("ttt");
     oW.form2.submit();
   }*/
 
}

function moder(id,formId,govFormType,gffType) {
    var hhref = "/defaultroot/GovCustomAction.do?action=loadForm" ;
	hhref += "&id="+id;
    hhref += "&formId=" + formId ;
    hhref += "&gffType=" +gffType;
	hhref += "&isPrint="+gffType;
	hhref += "&govFormType="+govFormType;
    hhref += "&pager.offset=0" ;
    postWindowReload(hhref,'','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=800,height=600') ;
}
</script>

<%}%>
