<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovCustomFieldPO"%>
<%@ page import="com.whir.govezoffice.documentmanager.po.GovCustomCheckedFieldPO"%>
<%@ page import="com.whir.ezoffice.customdb.customdb.po.FieldPO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<title>新增表单</title>
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
<script src="<%=rootPath%>/scripts/main/whir.openselect.js" type="text/javascript"></script>  
<html>
<%

  int nowYear = (new Date().getYear()) + 1900;
 
 // 发文还是收文  默认 发文：0   收文：1  文件送：2
  String  govFormType="0";
  if(request.getParameter("govFormType")!=null&&!request.getParameter("govFormType").toString().equals("")){
   govFormType=request.getParameter("govFormType");
  }

   // 是显示表单 还是 打印表单    0:显示表单  1：打印表单
  String  gffType="0";
  if(request.getParameter("gffType")!=null&&!request.getParameter("gffType").toString().equals("")){
   gffType=request.getParameter("gffType"); 
  }

  com.whir.govezoffice.documentmanager.bd.CovCustomBD  cbd=new com.whir.govezoffice.documentmanager.bd.CovCustomBD();
  List fieldList=new ArrayList();

  if(request.getAttribute("fieldList")!=null){
	  fieldList=(List)request.getAttribute("fieldList");
  }
System.out.println("size:"+fieldList.size());

%>

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
		//System.out.println( "[[[[[[[[[[[[[[["+fpo.getFieldInType() );
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
		%>
        govFieldArr[<%=fi%>] = new Array('<%=fieldName%>','<%=displayName%>','<%=displayType%>','<%=isChecked%>','<%=tips%>');
  <%}%>
</script>

<%
 int index=0;
 String fileName = "";
 String saveName = "";
if("1".equals(request.getAttribute("close"))){
%>

<script language="javascript">
	alert("保存成功！");
	window.close();
   opener.location.href="<%=rootPath%>/GovCustomAction.do?action=list&govFormType=<%=govFormType%>";
   // opener.parent.topFrame.window.location.reload();
</script>
<%
}else{%>

<%if("1".equals(request.getAttribute("stat"))){%>
<script language="javascript">
	alert("表单名重复！请更换名称！");
</script>
<%}else if("0".equals(request.getAttribute("stat"))){%>
	<script language="javascript">
		alert("新增表单失败，请重试或与管理员联系！");
	</script>
<%}else if(request.getParameter("continue")!=null){// if("3".equals(request.getAttribute("stat"))){%>
	<script language="javascript">
		//window.close();
         opener.location.href="<%=rootPath%>/GovCustomAction.do?action=list&govFormType=<%=govFormType%>";
	</script>	
	
<%}%>
	
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新表单</title>
<link href="<%=rootPath%>/skin/<%=session.getAttribute("skin")%>/style.css" rel="stylesheet" type="text/css" />
<link rel=stylesheet type="text/css" href="<%=rootPath%>/public/date_picker/DateObject2.css">
<SCRIPT language="javascript" src="<%=rootPath%>/js/openEndow.js"></SCRIPT>
</head>

<body  style="position:relative;overflow:auto ">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="GovCustom!saveForm.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
	
<!--<table width="100%" height="100%" border="1" cellpadding="10" cellspacing="0" class="Table_bottomline">
<tr><td valign="top" height="100%">-->
	
	  <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">

	  <input type="hidden" name="operate" />
 		<input type="hidden" name="fieldelt" id="fieldelt"/>
 		<input type="hidden" name="path" />
 		<input type="hidden" name="filenm" />
		<input type="hidden" id="isShow" value="0"  id="isShow"/>
		<input type="hidden" id="hidStr" value=""/>
 		<input type="hidden" name="govFormType" value="<%=govFormType%>" id="govFormType">
		<input type="hidden" name="gffType"  value="<%=gffType%>" id="gffType">
		<input type="hidden" name="displayValues" value=""  id="displayValues">
		<input type="hidden" name="action" value="addquit"  id="action">
	
 
	
		<tr>
		<td width="80" style="width:80px" nowrap="nowrap" for="表单名称" class="td_lefttitle">表单名称<label class="MustFillColor">*</label>：</td>
		<td>
		 <input name="govFormName" id="govFormName" type="text" class="inputText" style="width:95%" maxlength="30" whir-options="vtype:['notempty']" onKeyDown="javascript:if(event.keyCode==13) return false;"/>
		</td>
		</tr>
		<tr>
			<td class="td_lefttitle">使用范围：</td>
			<td >
			  <textarea name="canModifyEmpName" id="canModifyEmpName"  class="inputTextarea"  readonly="true" wrap="soft" style="width:95%;height:50px"></textarea>
			  <input type="hidden" name="canModifyEmpId" id="canModifyEmpId">
			  <a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'canModifyEmpId', allowName:'canModifyEmpName', select:'user', single:'no', show:'user', range:'*0*'});"/>
			 <!-- <br>
			  <label class="MustFillColor" nowrap>“使用范围”为空时默认所有用户。</label>-->
			</td>
		</tr>
		<tr><td ></td><td align="left" >
				 <label class="MustFillColor" nowrap>“使用范围”为空时默认所有用户。</label>
			</td>
		</tr>
		<tr>
			<td class="td_lefttitle">维护范围：</td>
			<td nowrap>
				 <textarea name="canManageEmpName" id="canManageEmpName" class="inputTextarea"  readonly="true" wrap="soft" style="width:95%;height:50px"></textarea>
				 <input type="hidden" name="canManageEmpId" id="canManageEmpId" value="">
				 <a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'canManageEmpId', allowName:'canManageEmpName', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"/>
			</td>
		</tr>
		<tr style="display:none">
		<td class="td_lefttitle">显示列数：</td>
		<td>
		<select name="colset" id="colset"  onchange="setDefault($('content').value);">
		<option value="-1">请选择</option>
		<option value="1">一列</option>
		<option value="2">二列</option>
		<option value="3">三列</option>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;
		<!--<button id="word" onclick="userWord();" class="btnButton4font" disabled="disabled">WORD编辑</button>
		&nbsp;&nbsp;
		<button id="fill" onclick="fillCont();" class="btnButton4font" disabled="disabled">填充控件</button>-->
		</td>
		</tr>
	<tr id="fckTitle" style="display:">
				   <td class="td_lefttitle"  style="width:90px" width="40px">样式设计：</td><td>&nbsp;</td>
				</tr>
				<tr id="fckLine" style="display:">
					<td id="fckCon"  colspan="2"><input type="hidden" name="code"/>
							<table width="100%" border="0">
								<tr>
								   <td style="width:85%" >
									<IFRAME id="pinEditID1" src="" frameborder="0" scrolling="no" width="100%" height="520"></IFRAME>
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
		<tr id="fckBtn" valign="baseline">
	      <td >&nbsp;</td><td>
				<input type="button" class="btnButton4font" onClick="javascript:save1('addquit',this);" value="保存退出"/>
                <input type="button"  class="btnButton4font" onClick="javascript:save1('continue',this);"  value="保存继续"/>
                <input type="button" class="btnButton4font" onClick="javascript:dataForm.reset();"  value="重　置"/>
                <input type="button" class="btnButton4font" onClick="javascript:window.close();"  value="退　出"/>
              </td>
        </tr>
	</table>
	
	<!--</td></tr>
</table>-->
<DIV id=adddelrow_div
style="BORDER-RIGHT: #0a246a 1px solid; BORDER-TOP: #0a246a 1px solid; VISIBILITY: hidden; BORDER-LEFT: #0a246a 1px solid; WIDTH: 50px; BORDER-BOTTOM: #0a246a 1px solid; POSITION: absolute">
<TABLE height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
  <TBODY>
  <TR>
    <TD onMouseOver="this.style.borderRiht='1px #0A246A solid'"
    onmouseout="this.style.borderRiht=''" align=middle><SPAN id=delrow_div
      title=点击删除重复项 style="CURSOR: hand"><IMG height=15
      src="<%=rootPath%>/custom_form/images/delarrow.gif" width=16 align=absMiddle></SPAN> </TD>
    <TD onMouseOver="this.style.borderLeft='1px #0A246A solid'"
    onmouseout="this.style.borderLeft=''" align=middle><SPAN id=addrow_div
      title=点击添加重复项 style="CURSOR: hand"><IMG height=15
      src="<%=rootPath%>/custom_form/images/addarrow.gif" width=16 align=absMiddle></SPAN>
  </TD></TR></TBODY></TABLE></DIV>
	</s:form>
		</div>
	</div>
</body>
<script language="javascript">
$(document).ready(function(){		
	$('#pinEditID1')[0].src="<%=rootPath%>/public/edit/ewebeditor.htm?id=code&style=coolblue&hiddenCodeTab=0&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>";
	var arr = new Array();
	arr[0] = {title: '主表字段',html: ''};
	//initTab(arr);
	setInputStyle();

	gov_showFile(govFieldArr);
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});

});
</script>

<%}%>
</html>
