<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>文号设置</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
    <s:hidden name="tempWHId" id="tempWHId"/>
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm" action="${ctx}/GovDocSet!sendFileNumListData.action" method="post" theme="simple">
	
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  

		<tr>
			<td class="whir_td_searchtitle2" nowrap>文号名称：</td>
			<td class="whir_td_searchinput2">
				<s:textfield id="queryTitle" name="numName" size="16" cssClass="inputText" />
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
                <input type="button" class="btnButton4font" onclick="getWHValue();" value="确 定" />
	        </td>
	    </tr>
	</table>
	<s:hidden name="numPo.oldYear"/>
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'4%',radio:true,renderer:getIdHtml" ></td>
			<td whir-options="field:'numType',width:'32%'">文号类别</td>
			<td whir-options="field:'numName',width:'32%'">文号名称</td>
			<td whir-options="field:'numMode', width:'32%'">文号预览</td> 
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


	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});
	});
    function getIdHtml(po,i){
        var html="whName='"+po.numName+"'";
        var tempWHId=$("#tempWHId").val();
        var tempId=po.id;
        if(tempWHId!=""&&tempId!=""){
            if(tempWHId==tempId){
              html+="checked='checked'";
            }
        }
        return  html;
    }
    function getWHValue(){
        var api = frameElement.api, W = api.opener;
        if($('#queryForm input[name="id"]:checked ').length>0){
            var chooseId= $('#queryForm input[name="id"]:checked ').attr("id");
            var whName= $('#queryForm input[name="id"]:checked ').attr("whName");
            W.$("#sendDocumentNumId").val(chooseId);
            W.$("#sendDocumentNumName").val(whName);
            api.close()
        }else{
            alert("请选择文号！");
        }
    }
   </script>

</html>


