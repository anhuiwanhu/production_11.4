<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>流程列表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">   
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm2" id="queryForm2" action="${ctx}/GovDocSet!sendProcessListData.action?moduleId=2" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
		
         <tr>
            <td  class="whir_td_searchtitle2">流程名称：<s:hidden name="moduleId" value="2"/></td>
            <td  class="whir_td_searchinput">
				 <s:textfield id="processName" name="processName" size="16" cssClass="inputText" />
	        </td>
            <td  align="right">
				
				<!-- refreshListForm 是公共方法，queryForm 为上面的表单id-->
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm2');"  value="立即查找" />
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
	           <input name="" type="button" value="" class="btnButton4font" style="display:none"/>
	        </td>
	    </tr>
	</table>
	
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'wfWorkFlowProcessId',width:'2%',checkbox:true,renderer:checkit"><input type="checkbox" name="items" id="items" onclick="selectAllCB(this.checked);setCheckBoxState('wfWorkFlowProcessId',this.checked);" ></td>
			<td whir-options="field:'workFlowProcessName',width:'30%'">流程名称</td> 
			

        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
		<tbody  id="itemContainer"  >
		
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


	<table width="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr><td style="height:90%" valign="top">
	    <s:textarea name="processName_sel"  id="processName_sel" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:98%;"  readonly="true"></s:textarea>
		<input type="hidden" name="processId_sel" id="processId_sel" value=""></td></tr>
    <tr><td> <button class="btnButton4font" onClick="closeOK();">确　定</button>
	<button class="btnButton4font"  onClick="unsearcher();">清　空</button></td></tr>
    </table>
</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm2",echoId:"processId_sel"});		
	    var api = frameElement.api, W = api.opener; 


		$("#processName_sel").val(W.document.getElementById('processName').value);
		if( $('#processName_sel').val().lastIndexOf(";") == $('#processName_sel').val().length-1){
		}else if( $('#processName_sel').val() != "" ){
			$('#processName_sel').val($('#processName_sel').val()+";");
		}
		
		$("#processId_sel").val(W.document.getElementById('processId').value);
	});
	//清空
	function unsearcher(){
		$('#processName_sel').val("");
		$('#processId_sel').val("");
		$('input[name=\'wfWorkFlowProcessId\']').each(function(){
			this.checked=false;
		});
		//$("input[name=\'wfWorkFlowProcessId\']").uniform();
	}
	//确定
	function  closeOK(){

		  if($('#processName_sel').val().lastIndexOf(";") == $('#processName_sel').val().length-1){
				$('#processName_sel').val($('#processName_sel').val().substring(0,$('#processName_sel').val().length-1));
		   }
		   var api = frameElement.api, W = api.opener; 
		   if( $('#processId_sel').val() == "" ){
				$('#processName',W.document).val("");
				$('#processId',W.document).val("");
		   }else{
				$('#processName',W.document).attr('value',$('#processName_sel').val());
				$('#processId',W.document).val($('#processId_sel').val());
		   }
		   api.close();
	}

	function selectAllCB(v1){
		$("input[type='checkbox'][name!=\"items\"]").each(function(){
			//alert(1);
			if(this.checked != v1){
				this.checked = ! v1;
				this.click();
			}
		});
		
	}

	//判断选择
	function checkOk(obj,tvalue,tText){
		 if(obj.checked){
			document.getElementById('processName_sel').value=document.getElementById('processName_sel').value+tText+";";
			document.getElementById('processId_sel').value=document.getElementById('processId_sel').value+"$"+tvalue+"$";
		 }else{
			document.getElementById('processName_sel').value=document.getElementById('processName_sel').value.replace(tText+";","");
			document.getElementById('processId_sel').value=document.getElementById('processId_sel').value.replace("$"+tvalue+"$","");
		 }
		 
	}

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
		var html ;
		if(po.sex==0){
			html = "男";
		}else{
			html = "女";
		}
		return html;
	}
	function checkit(po,i){

		var api = frameElement.api, W = api.opener; 

		if(document.getElementById('processId_sel').value.indexOf("$"+po.wfWorkFlowProcessId+"$") >=0){
		//if(W.document.getElementById('processId').value.indexOf("$"+po.wfWorkFlowProcessId+"$") >=0){
			return 'checked onclick="checkOk(this,\''+po.wfWorkFlowProcessId+'\',\''+po.workFlowProcessName+'\');" ';
		}
		return 'onclick="checkOk(this,\''+po.wfWorkFlowProcessId+'\',\''+po.workFlowProcessName+'\');" ';
	}

	function downloadLink(po,i){
		return "<a href='alert(\""+po.gridId+"\")' >下载正文</a>";
	}

	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd hh:mm:ss");
	}

	
   </script>

</html>


