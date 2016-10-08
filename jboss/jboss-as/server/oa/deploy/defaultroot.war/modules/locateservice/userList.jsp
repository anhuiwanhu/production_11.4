<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>


<%@ page import="java.util.*"%>
<%
int index = 0 ;
int countRecordCount = 0  ;
if(request.getParameter("pager.offset")!=null)
     index=Integer.parseInt(request.getParameter("pager.offset"));
int offset1 = index ;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<title>人员轨迹</title>
	<!--  STYLE	CHANGE START -->

	<script language="javascript" src="js/js.js" ></script>
	<script language="JavaScript" src="js/date0.js"></script>
	<!--  STYLE	CHANGE START -->
	<script language="JavaScript" type="text/JavaScript">
	<!--
	function killerrors() {
		return true;
	} 
	try{
		window.onerror = killerrors; 
	}catch(e){
	}
	//-->
	</script>
</head>



<body class="MainFrameBox">

	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="LocateServiceAction!userListData.action" method="post" theme="simple">
	
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  

		<tr>
			<td class="whir_td_searchtitle">姓名：</td>
			<td  class="whir_td_searchinput">
				<s:textfield id="username" name="username" size="16" cssClass="inputText"  />
			</td>
			<td class="whir_td_searchtitle">组织：</td>
			<td  class="whir_td_searchinput">
				<s:textfield id="orgname" name="orgname" size="16" cssClass="inputText"  />
			</td>
			<td class="SearchBar_toolbar">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="立即查找" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="清除" onclick="resetForm(this);" />
			</td>
		</tr>
		
		
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td align="right">
	           
	        </td>
	    </tr>
	</table>
	<s:hidden name="numPo.oldYear"/>
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'orgNameString'" >组织</td>
			<td whir-options="field:'empName',width:'80'">姓名</td> 
			<td whir-options="field:'empSex',width:'40',renderer:getsex">性别</td> 
			<td whir-options="field:'lastLocateTime',width:'160',renderer:common_DateFormat">最后定位时间</td> 
			<td whir-options="width:'8%',renderer:myOperate">操作</td> 
        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
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
<script language="javascript">
<!--
function add(){
	MM_openBrWindow('<%=rootPath%>/LocateServiceAction.do?action=add','','TOP=0,LEFT=0,scrollbars=yes,resizable=yes,width=500,height=280');
}

function modify(id){
    MM_openBrWindow('<%=rootPath%>/LocateServiceAction?action=load&id='+id+'&pager.offset=<%=offset1%>','','TOP=0,LEFT=0, resizable=yes,width=500,height=280')
}

$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		
});

function del(id) {
     <%
     int deloffset =  countRecordCount == 1 ? offset1-com.whir.common.util.CommonUtils.getUserPageSize(request):offset1 ;
     deloffset = deloffset < 0 ? 0 : deloffset ;
     %>
     if(confirm("确实要删除吗？")){
         window.location.href="<%=rootPath%>/LocateServiceAction?action=delete&id="+id+"&pager.offset=<%=deloffset%>";
    }
 }

function batchDel(){
	if(getCheckBoxID() != ''){
		var ids = getCheckBoxID();
		ids = ids.substring(0, ids.length-1);
		if(confirm("确实要删除吗？")){
			window.location.href="<%=rootPath%>/LocateServiceAction.do?action=batchDel&ids="+ids+"&pager.offset=<%=deloffset%>";
		}
	}else{
		alert("请选择要删除的记录！");
	}
}

function selectAllItem(){
    var result=document.all.selectAll.checked;
    if(document.all.batchDel){
        if(isNaN(document.all.batchDel.length)){
            document.all.batchDel.checked=result;
        }else{
            for(var i=0;i<document.all.batchDel.length;i++){
                document.all.batchDel[i].checked=result;
            }
        }
    }
}

function getCheckBoxID() {
	if(document.all.batchDel==undefined)return "";
    var retString="" ;
    for(var i = 0 ; i < document.all.batchDel.length ; i++ ) {
    	var obj = document.all.batchDel[i] ;
		if(obj.type == "checkbox"){
			if(obj.checked) {
				retString += obj.value;
                retString += "," ;
			}
        }
    }
	if(document.all.batchDel!=undefined&&document.all.batchDel.length==undefined){
		if(document.all.batchDel.checked){
			retString += document.all.batchDel.value;
        	retString += "," ;
		}
	}
    return retString;
}

function search(){
	form1.submit();
}

function myOperate(po,i){
	var html = '<img style="cursor:hand" border="0" src="/defaultroot/images/browser.PNG" alt="定位"  title="定位" onclick="window.location.href=\'/defaultroot/modules/locateservice/userTrack.jsp?userId='+po.empId;
	if(po.lastLocateTime != "" && po.lastLocateTime  != null){
		html +=  '&fromDate='+po.lastLocateTime.substring(0,10)+'\'"/>';
	}else{
		html +=  '\'"/>';
	}
	return html;
}

function getsex(po,i){
	if(po.empSex == 1){
		return "女";
	}
	return "男";
}

function clearr(){
	form1.username.value='';
	form1.orgname.value='';
	form1.submit();
}
//-->
</script>
