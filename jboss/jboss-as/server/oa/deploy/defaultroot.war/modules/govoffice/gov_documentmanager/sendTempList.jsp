<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>模板列表</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm2" id="queryForm2" action="${ctx}/GovDocSet!sendTempListData.action" method="post" theme="simple">

	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  

         <tr>
            <td class="whir_td_searchtitle2">模板名称：</td>
            <td class="whir_td_searchinput">
				 <s:textfield id="tempFileName" name="tempFileName"  cssClass="inputText"  />

	        </td>
            <td align="right">
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
	<div >
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'recordID',width:'2%',checkbox:true,renderer:checkit"><input type="checkbox" name="items" id="items" onclick="selectAllCB(this.checked);setCheckBoxState('recordID',this.checked);" ></td>
			<td whir-options="field:'fileName',width:'30%'">模板名称</td> 
			

        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
		<tbody  id="itemContainer"  >
		
		</tbody>
    </table>
    <!-- LIST TITLE PART END -->
	</div>


	

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
	    <s:textarea name="templateName_sel"  id="templateName_sel" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:98%;"  readonly="true"></s:textarea>
		<input type="hidden" name="templateId_sel" id="templateId_sel" value=""></td></tr>
    <tr><td> <button class="btnButton4font" onClick="closeOK();">确　定</button>
	<button class="btnButton4font"  onClick="unsearcher();">清　空</button></td></tr>
    </table>
</body>


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
	//			var api = frameElement.api, W = api.opener; 
	//	$('#templateId_sel').val($('#templateId',W.document).val());  
	//	$('#templateName_sel').val($('#templateName',W.document).val());  
		initListFormToAjax({formId:"queryForm2",echoId:"templateId_sel"});		
	//	$('#queryForm2').uniform();

		var api = frameElement.api, W = api.opener; 
 
 
		$("#templateName_sel").val(W.document.getElementById('templateName').value);
		if( $('#templateName_sel').val().lastIndexOf(";") == $('#templateName_sel').val().length-1){
		}else if( $('#templateName_sel').val() != "" ){
			$('#templateName_sel').val($('#templateName_sel').val()+";");
		}
		
		$("#templateId_sel").val(W.document.getElementById('templateId').value);

	});
	

	//清空
	function unsearcher(){
		$('#templateName_sel').val("");
		$('#templateId_sel').val("");
		$('input[name=\'recordID\']').each(function(){
			
			this.checked=false;
			//$(this).uniform();
		});

	}

	//确定
	function  closeOK(){
		   var api = frameElement.api, W = api.opener; 
		   if( $('#templateId_sel').val() == "" ){
				$('#templateName',W.document).val("");
				$('#templateId',W.document).val("");
		   }else{
				$('#templateName',W.document).attr('value',$('#templateName_sel').val());
				$('#templateId',W.document).val($('#templateId_sel').val());
		   }
		   api.close();
	}

	//判断选择
	function checkOk(obj,tvalue,tText){
		 if(obj.checked){
			document.getElementById('templateName_sel').value=document.getElementById('templateName_sel').value+tText+";";
			if(document.getElementById('templateId_sel').value == ""){
				document.getElementById('templateId_sel').value=tvalue;
			}else{
				document.getElementById('templateId_sel').value=document.getElementById('templateId_sel').value+";"+tvalue;
			}
		 }else{
			document.getElementById('templateName_sel').value=document.getElementById('templateName_sel').value.replace(tText+";","");
			
			if(document.getElementById('templateId_sel').value.indexOf(";") >=0 ){
				//document.getElementById('templateId_sel').value=document.getElementById('templateId_sel').value.replace(";"+tvalue+";",";");
				document.getElementById('templateId_sel').value=document.getElementById('templateId_sel').value.replace(";"+tvalue+"","");
			}else{
				document.getElementById('templateId_sel').value=document.getElementById('templateId_sel').value.replace(tvalue,"");
			}
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


	  //alert(W.document.getElementById('templateId'));
		if(W.document.getElementById('templateId').value.indexOf(po.recordID) != -1){
			return 'checked onclick="checkOk(this,\''+po.recordID+'\',\''+po.fileName+'\');" ';
		}
		return 'onclick="checkOk(this,\''+po.recordID+'\',\''+po.fileName+'\');" ';
	}
	function selectAllCB(v1){
		//alert(v1);
		$("input[type='checkbox'][name!=\"items\"]").each(function(){
			//alert(1);
			if(this.checked != v1){
				this.checked = ! v1;
				this.click();
			}
			//$(this).uniform();
		});
		
	}

	function downloadLink(po,i){
		return "<a href='alert(\""+po.gridId+"\")' >下载正文</a>";
	}

	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd hh:mm:ss");
	}

	
   </script>

</html>


