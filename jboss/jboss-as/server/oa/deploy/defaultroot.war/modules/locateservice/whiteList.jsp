<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>主题词设置</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">

	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="${ctx}/LocateServiceAction!whiteListData.action" method="post" theme="simple">
	
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  

		<tr>
			<td class="whir_td_searchtitle2">姓名：</td>
			<td  class="whir_td_searchinput">
				<s:textfield id="username" name="username" cssClass="inputText" />
			</td>
			
			<td class="SearchBar_toolbar">
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value="立即查找" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="清　除" onclick="resetForm(this);" />
			</td>
		</tr>
		
    </table>
	<!-- SEARCH PART END -->
    
	<!-- 操作按纽栏	-->
	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">
	    <tr>
	        <td align="right">
	          	<input type="button"  class="btnButton4font" onclick="openSelect({allowId:'ids', allowName:'newWhiteNames', select:'user', single:'no', show:'user', range:'*0*',callbackOK:'selectUserCallBack'});" style="cursor:hand" value="新　增"/>
				<input type="button" class="btnButton4font" onclick="ajaxBatchDelete('<%=rootPath%>/LocateServiceAction!deleteWhite.action','empId','empId',this);" value="批量删除" />
	        </td>
	    </tr>
	</table>
	<s:hidden name="numPo.oldYear"/>
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'empId',width:'2%',checkbox:true" ><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('empId',this.checked);" ></td>
			<td whir-options="field:'empName',width:'10%'">中文名</td> 
			<td whir-options="field:'empSex',width:'5%',renderer:sex">性别</td> 
			<td whir-options="field:'orgName',width:'30%'">组织</td> 
			<td whir-options="field:'empDuty',width:'20%'">职务</td> 
			<td whir-options="field:'deptLeaderNames',width:'25%'">上级领导</td> 
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
	
		<form name="addWhiteForm" id="addWhiteForm" action="<%=rootPath%>/LocateServiceAction!addWhite.action"><input type="hidden" name="ids" id="ids"><input type="hidden" name="newWhiteNames" id="newWhiteNames"></form>
</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});		
	});
	

	//自定义查看栏内容
	function show(po,i){
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'${ctx}/viewUser.action?userId='+po.userId+'\',width:620,height:290,winName:\'showUser\'});">'+po.name+'</a>';
		return html;
	}
	
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
		var html ;
		//alert(po.empSex); 
		if(po.empSex==0){
			html = "男";
		}else{
			html = "女";
		}
		return html;
	}

	function downloadLink(po,i){
		return "<a href='alert(\""+po.gridId+"\")' >下载正文</a>";
	}

	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd hh:mm:ss");
	}

	function splitTopical(po,i){
		return po.sortTopical.substring(0, po.sortTopical.indexOf("|"));
	}

	//自定义操作栏内容
	function myOperate(po,i){
		var html =  '<a href="javascript:void(0)" onclick="ajaxDelete(\'${ctx}/LocateServiceAction!deleteWhite.action?id='+po.empId+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" alt="删除" ></a>';
		return html;
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

function clearr(){
	form1.username.value='';
	form1.submit();
}

function selectUserCallBack(){
	//alert(1);
	//document.all.ids.value = document.all.ids.value.replace(/\$/g,'');
	//alert(document.all.ids.value);
	//alert($('#ids').val());
	ajaxOperate({urlWithData:"LocateServiceAction!addWhite.action?ids="+$('#ids').val(),tip:"新增白名单",isconfirm:false,formId:'queryForm'});
	$('#ids').val("");
	$('#newWhiteNames').val("");
}

	function killerrors() {
		return true;
	} 
	try{
		window.onerror = killerrors; 
	}catch(e){
	}
	
   </script>

</html>



