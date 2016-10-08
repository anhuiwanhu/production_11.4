<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.dossier.po.DossierCategoryPO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>修改子类目</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div class="docBoxNoPanel">
	       <s:form name="dataForm" id="dataForm" action="/dossierCategory!subModify.action" method="post" theme="simple" >
              <%@ include file="/public/include/form_detail.jsp"%>
	          <s:hidden name="dossierCategoryPo.id" />
	          <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
	             <tr>
                    <td for="类目名称" width="100" class="td_lefttitle">类目名称<span class="MustFillColor">*</span>：</td>
                    <td>
                       <s:textfield name="dossierCategoryPo.name" id="name" cssClass="inputText" maxLength="20" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" cssStyle="width:96%;" />
                    </td>
                 </tr>
                 <tr>
                    <td for="类目编号" width="100" class="td_lefttitle">类目编号<span class="MustFillColor">*</span>：</td>
                    <td>
                       <s:textfield name="dossierCategoryPo.categoryCode" id="categoryCode" cssClass="inputText" maxLength="20" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" cssStyle="width:96%;" />
                    </td>
                 </tr>
                 <tr>
                    <td width="100" class="td_lefttitle">所属一级类目：</td>
                    <%
                      List fristCategory = (List)request.getAttribute("fristCategory");
                      String baseId = request.getAttribute("baseId")!=null?request.getAttribute("baseId").toString():"";
                    %>
                    <td>
                       <select name="baseId" id="baseId" class="selectlist" onchange="chg(this);" style="width:200px;">
                       <%
                         if(fristCategory!=null && fristCategory.size()>0){
                         	 for(int i=0; i<fristCategory.size(); i++){
                         	 	 DossierCategoryPO dossierCategoryPO = (DossierCategoryPO)fristCategory.get(i);
                       %>
                          <option value="<%=dossierCategoryPO.getId()%>" <%=baseId.equals(dossierCategoryPO.getId().toString())?"selected":""%>><%=dossierCategoryPO.getName()!=null?dossierCategoryPO.getName():""%></option>
					   <%}}%>
                       </select>
                    </td>
                 </tr>
                 <tr>
                    <td width="100" class="td_lefttitle">上级类目：</td>
                    <%
                      String parentId = String.valueOf(request.getAttribute("parentId"));
                      String space = "";
                    %>
                    <td>
                       <select name="parentId" id="parentId" class="selectlist" onchange="chg2(this);" style="width:200px;">
                       <%
                         List categoryList = (List)request.getAttribute("categoryList");
                         if(categoryList!=null && categoryList.size()>0){
                         	 for(int i=0; i<categoryList.size();i++){
                         	 	 DossierCategoryPO po = (DossierCategoryPO)categoryList.get(i);
                         	 	 space="";
                         	 	 for(int j=1;j<Integer.parseInt(po.getLevel());j++){
						             space+="&nbsp;&nbsp;";
					             }
                       %>
                          <option value="<%=po.getId()%>" id="subLevel_<%=po.getLevel().toString()%>" <%=parentId.equals(po.getId().toString())?"selected":""%>><%=space%><%=po.getName()%></option>
                       <%}}%>
                       </select>
                    </td>
                 </tr>
                 <tr>
                    <td width="100" class="td_lefttitle">类目级别：</td>
                    <td>
                       <s:textfield name="dossierCategoryPo.level" id="level" cssClass="inputText" cssStyle="width:96%;" readonly="true"/>
                    </td>
                 </tr>
                 <s:hidden name="dossierCategoryPo.sort" id="sort" value="1"/>
                 <tr>
                    <td for="可查看人" width="100" class="td_lefttitle">可查看人:<span class="MustFillColor">*</span>：</td>
                    <%
					  String fromParentRange = ((request.getAttribute("fromParentRange")==null || "null".equals(request.getAttribute("fromParentRange")))?"":request.getAttribute("fromParentRange")+"");
					  String parentParentId = request.getAttribute("parentParentId")+"";
					%>
                    <td>
                       <input type="hidden"  name="fromParentRange" id="fromParentRange" value="<%=fromParentRange%>">
				       <input type="hidden"  name="parentParentId"  id="parentParentId"  value="<%=parentParentId%>">
                       <s:hidden name="dossierCategoryPo.lookUserId" id="lookUserId" />
                       <s:textarea name="dossierCategoryPo.lookUser"  id="lookUser" cols="112" rows="3" cssClass="inputTextarea" whir-options="vtype:['notempty']" cssStyle="width:96%;" readonly="true"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectModUser();"></a>
                    </td>
                 </tr>
                 <tr>
                    <td for="备注" width="100" class="td_lefttitle">备注：</td>
                    <td>
                       <s:textarea name="dossierCategoryPo.categoryRemark"  id="categoryRemark" cols="112" rows="3" cssClass="inputTextarea" whir-options="vtype:[{'maxLength':2000}]" cssStyle="width:96%;"></s:textarea>
                    </td>
                 </tr>
                 <tr class="Table_nobttomline">
                   <td></td>
                   <td nowrap>
                      <input type="button" class="btnButton4font" onClick="saveAndExit(this);" value="<s:text name="comm.saveclose"/>" />
                      <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
                      <input type="button" class="btnButton4font" onClick="window.close();" value="<s:text name="comm.exit"/>" />
                   </td>
                 </tr>
	          </table>
	       </s:form>
		</div>
	</div>
</body>
<script type="text/javascript">
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//设置表单为异步提交
	initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
    function saveAndExit(obj){
        ok(0,obj);
    }
    
    function chg(obj){
		var id = $('#dataForm_dossierCategoryPo_id').val();
	    $.ajax({
		    type:"POST",
		    url: whirRootPath+"/dossierCategory!getSubList.action?id="+id+"&baseId="+obj.value,
		    async:true,
		    dataType:'json',
		    success:function(json){
			    $('#parentId').html(json.resultStr);
			    $('#level').val("2");
				
				if(json.lookUserId){
					$('#lookUserId').val(json.lookUserId);
					$('#lookUser').val(json.lookUser);
					$('#fromParentRange').val(json.lookUserId);
				}else{
					$('#lookUserId').val("");
					$('#lookUser').val("");
					$('#fromParentRange').val("");
				}
				$('#parentId').change();
		    }
	    });
    }
    
    function chg2(obj){
    	var varcheckId = $(obj).find("option:selected").attr("id");
    	var varcheckLevel = parseInt(varcheckId.substring(9, varcheckId.length)) + 1;
        $('#level').val(varcheckLevel);
		
		$.ajax({
		    type: 'POST',
		    url: whirRootPath+"/dossierCategory!loadDossierCategory.action?categoryId="+obj.value,
            async: true,
		    dataType: 'json',
		    success: function(json){
				if(json.lookUserId){
					$('#lookUserId').val(json.lookUserId);
					$('#lookUser').val(json.lookUser);
					$('#fromParentRange').val(json.lookUserId);
				}else if(json.orgId){
				   $('#lookUserId').val(json.orgId);
			       $('#lookUser').val(json.orgName);
			       $('#fromParentRange').val(json.orgId);
			    }else{
					$('#lookUserId').val("");
					$('#lookUser').val("");
					$('#fromParentRange').val("");
				}
		    }
	    });
    }

	function selectModUser(){
		var categoryId = $('#parentId').val();
		var fromParentRange = "*0*";
		$.ajax({
		    type: 'POST',
		    url: whirRootPath+"/dossierCategory!loadDossierCategory.action?categoryId="+categoryId,
            async: true,
		    dataType: 'json',
		    success: function(json){
				if(json.lookUserId){
				   fromParentRange = json.lookUserId;
			   }else if(json.orgId){
				   fromParentRange = json.orgId;
			   }
			   openSelect({allowId:'lookUserId', allowName:'lookUser', select:'userorggroup', single:'no', show:'userorggroup', range:''+fromParentRange+''});
		    }
	    });
	}
</script>

</html>