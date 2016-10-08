<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.po.CustomerMenuConfigerPO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
	<title>业务处理列表</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_list.jsp"%>  

	<SCRIPT language=javascript src="<%=rootPath%>/platform/custom/custom_form/run/js/form.js"></SCRIPT>
	<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>

<style>
.bInputtext{width:30%;}
.bInputtext_hover{width:30%;}
.bInputtext:hover{width:30%;}
</style>
</head>  
<%
  Boolean isRefFlow = (Boolean)request.getAttribute("isRefFlow");
  Boolean isNewRefFlow = (Boolean)request.getAttribute("isNewRefFlow");
  Boolean hasNewForm = (Boolean)request.getAttribute("hasNewForm");
  String menuId = request.getParameter("menuId");
  String headerContainer = (String)request.getAttribute("headerContainer");
  CustomerMenuConfigerPO po = (CustomerMenuConfigerPO)request.getAttribute("customerMenuConfpo");
  String tableName = (String)request.getAttribute("tableName");
  String tableId = po.getMenuListTableMap()+"";
  String formId = po.getMenuSearchBound()+"";
  String menuName = po.getMenuName();

  String rightType = (String)request.getAttribute("rightType");
  String defineOrgs = (String)request.getAttribute("defineOrgs");
  /**
  boolean hasUpdAndDelRight = false;
  if(!"".equals(rightType) && new CustomerMenuDB().hasUpdAndDelRight(request,tableName,menuId,rightType,defineOrgs, CommonUtils.getSessionDomainId(request)+"")){
     hasUpdAndDelRight = true;
  }
  **/

  String middlButton = (String)request.getAttribute("middlButton");
  String searchPart = (String)request.getAttribute("searchPart");
  String saveAllFieldsSuccess = (String)request.getAttribute("saveAllFieldsSuccess");
  String isHasExport = (String)request.getAttribute("isHasExport");//是否有导出权限"false":没有；"true":有

%>

<body class="MainFrameBox">  
	<s:form name="queryForm" id="queryForm" action="custormerbiz!getCustDataList.action" method="post" theme="simple">
	<input name="menuId" id="menuId" value="<%=menuId%>" type="hidden">
	<input name="menuName" id="menuName" value="<%=menuName%>" type="hidden">
	<input name="isRefFlow" id="isRefFlow" value="<%=isRefFlow%>" type="hidden">
	<input name="hasNewForm" id="hasNewForm" value="<%=hasNewForm%>" type="hidden">
	<input name="isNewRefFlow" id="isNewRefFlow" value="<%=isNewRefFlow%>" type="hidden">
	<input name="tableName" id="tableName" value="<%=tableName%>" type="hidden">
	<input name="tableId" id="tableId" value="<%=tableId%>" type="hidden">
	<input name="formId" id="formId" value="<%=formId%>" type="hidden">

	<input name="rootPath" id="rootPath" value="<%=rootPath%>" type="hidden">
	<input name="rightType" id="rightType" value="<%=rightType%>" type="hidden">
	<input name="defineOrgs" id="defineOrgs" value="<%=defineOrgs%>" type="hidden">

	<input name="saveAllFieldsFlag" id="saveAllFieldsFlag" value="0" type="hidden">
    <input name="isHasExport" id="isHasExport" value="<%=isHasExport%>" type="hidden">
    <!-- SEARCH PART START -->  
    <%@ include file="/public/include/form_list.jsp"%>  
    <%if(searchPart!=null&&!"".equals(searchPart)){%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
       <%=searchPart%>  
    </table>  
	<%}%>
    <!-- SEARCH PART END -->      
  
    <!-- MIDDLE  BUTTONS START -->  
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
        <tr>  
            <td align="right">  
                <%=middlButton%>
            </td>  
        </tr>  
    </table>  
    <!-- MIDDLE  BUTTONS END -->  

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
          <%=headerContainer%>
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

  <IFRAME id="downloadIframe" name="downloadIframe" frameborder="0" width="0" height="0" style="display:none"></IFRAME>
</body>  
<script type="text/javascript">

//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){         
	initListFormToAjax({formId:"queryForm", onLoadSuccessAfter:successLoad});         
});  
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  

</SCRIPT>
<script src="<%=rootPath%>/platform/custom/customize/js/BizAjax.js" language="javascript"></script>
</html>  
<%
//------------------------------------------------------------
//自定义表单在删除、批量删除、批量保存时预留接口-start
//------------------------------------------------------------

String _jsp_include_file = "";//jsp文件
String _FUN_delload = "";   //删除加载名
String _FUN_delAllload = "";//批量删除加载名
String _FUN_saveAllLoad = "";//批量保存加载名


if(menuId!=null && !"null".equals(menuId) && !"".equals(menuId)){

    try{
			String __jspfile = po.getListIncludeFile();
			if(__jspfile!=null&&!"".equals(__jspfile)&&!"null".equals(__jspfile)){

				_jsp_include_file = "/modulesext/devform/customize/"+__jspfile;
				_FUN_delload = po.getDelLoad();
				_FUN_delAllload = po.getDelAllLoad();
				_FUN_saveAllLoad = po.getSaveAllLoad();
%>

<jsp:include page="<%=_jsp_include_file%>" flush="true"/>
<%
                }
            
        }catch(Exception e){e.printStackTrace();}
    
}
//------------------------------------------------------------
//自定义表单在打开、点击保存、修改时预留接口-end
//------------------------------------------------------------
%>

<SCRIPT LANGUAGE="JavaScript">
<!--

function del(id) {
  
<%
    if(_FUN_delload!=null&&!"".equals(_FUN_delload)){
%>
	if(!<%=_FUN_delload%>()){
	   return;
	}
<%}%>
    
  ajaxOperate({urlWithData:'custormerbiz!delBatchData.action?menuName=<%=menuName%>&tableName=<%=tableName%>&infoIds='+id,tip:'删除',isconfirm:true,formId:'queryForm'});
}
//批量删除
function delBatch() {

<%
    if(_FUN_delAllload!=null&&!"".equals(_FUN_delAllload)){
%>
	if(!<%=_FUN_delAllload%>()){
	   return;
	}
<%}%>

    var ids = getCheckBoxData("id","id");
	if(ids==""){
		whir_alert("请选择要删除的数据！", null) ;
		return;
	}else{
	   ajaxOperate({urlWithData:'custormerbiz!delBatchData.action?menuName=<%=menuName%>&tableName=<%=tableName%>&infoIds='+ids,tip:'删除',isconfirm:true,formId:'queryForm'});
	}
 }
 function saveAllFields() {
  
	<%
		if(_FUN_saveAllLoad!=null&&!"".equals(_FUN_saveAllLoad)){
	%>
		if(!<%=_FUN_saveAllLoad%>()){
		   return;
		}
	<%}%>

	 $("#saveAllFieldsFlag").val('1');
	 //refreshListForm('queryForm');
	 $("#start_page").val("1");
     $("#queryForm").submit();
	 whir_alert("保存成功！", null) ;
}

function successLoad(json){

	var colspan = $('.listTableHead td').length;
    var _recordCount = parseInt($('#recordCount').val(), 10);
    if(_recordCount > 0){
        var _sumInfo = json.sumInfo;
        if(_sumInfo != ''){
            $('#itemContainer').append('<tr class="listTableLine1"><td class="listTableLineLastTD" colspan='+colspan+' align=right>'+_sumInfo+'</td></tr>');
        }
    }

	//alert($("#saveAllFieldsFlag").val());
	//批量保存标记
	$("#saveAllFieldsFlag").val('0');
}

<%
  List showJSData = (List)request.getAttribute("showJSData");

    //获取列表保存字段
	List list2 = new CustomerMenuDB().getFieldControls(menuId,"4");
	//可编辑字段
	String custListFields ="";
	if(list2 != null && list2.size()>0){
		for(int i=0;i<list2.size();i++){
			List _list = (List)list2.get(i);
			String fieldname = (String)_list.get(1);
			custListFields += _list.get(1)+",";
		}
	}

  if(showJSData!=null){
     for(int i=0;i<showJSData.size();i++){
	    Object[] _obj=(Object[])showJSData.get(i);
		String _jsName = _obj[0]+"";
		String _fieldid = _obj[1]+"";
		String _fielddesName = _obj[2]+"";
		String _fieldname = _obj[3]+"";
		String _fieldwidth = _obj[4]+"";
		String _fieldshow = _obj[5]+"";
		String _fieldvalue = _obj[6]+"";
		String _fieldtype = _obj[7]+"";
		String isLink = "0";
		if(_fieldname.equals(po.getMenuMaintenanceSubTableName())){
		    isLink = "1";
		}
		String canModify="0";
		if (custListFields.indexOf(_fieldname) > -1) {
			canModify = "1";
		}
%>
     function <%=_jsName%>(po,i){
	
        var html='';
		var json = ajaxForSync("custormerbiz!getShowHTML.action","thisrow="+i+"&dataId="+po.id+"&dataValue="+encodeURI(po.<%=_fieldname%>)+"&fieldid=<%=_fieldid%>&fielddesname=<%=_fielddesName%>&fieldname=<%=_fieldname%>&fieldwidth=<%=_fieldwidth%>&fieldshow=<%=_fieldshow%>&fieldvalue=<%=_fieldvalue%>&fieldtype=<%=_fieldtype%>&isLink=<%=isLink%>&canModify=<%=canModify%>");

		html = json;
		return html;

     }
  
<%
	 }
  }
%>
//-->
</SCRIPT>


