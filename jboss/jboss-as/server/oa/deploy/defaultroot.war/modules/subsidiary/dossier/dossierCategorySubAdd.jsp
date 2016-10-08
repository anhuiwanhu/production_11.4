<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.dossier.po.DossierCategoryPO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>新增子类目</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div class="docBoxNoPanel">
	       <s:form name="dataForm" id="dataForm" action="/dossierCategory!subAdd.action" method="post" theme="simple" >
              <%@ include file="/public/include/form_detail.jsp"%>
	          <%@ include file="dossierCategorySubForm.jsp"%>
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
    
    function saveAndContinue(obj){
        ok(1,obj);
    }
    
    function chg(obj){
		$.ajax({
			type: 'POST',
			url: whirRootPath+"/dossierCategory!selectParentCategory.action?baseId="+obj.value,
			dataType: 'json',
			success: function(json){
				//alert(json.selectJosn);
				$('#parentId').html(json.selectJosn);
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
			   if(json.parentId =='0'){
			      $('#select0').attr('style','display:;');
			   }else{
			      if($('#lookUser') == ''){
			         $('#select0').attr('style','display:none;');
			      }else{
			         $('#select0').attr('style','display:;');
			      }
			   }
			   $('#parentId').change();
    	 	},
    	 	error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(XMLHttpRequest.status);
                alert(XMLHttpRequest.readyState);
                alert(textStatus);
            }
		});
		
    }
    
    function chg2(obj){
        $('#level').val(parseInt($(obj).find('option:selected').attr('property'))+1);
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
			   if(json.parentId =='0'){
			      $('#select0').attr('style','display:;');
			   }else{
			      if($('#lookUser') == ''){
			         $('#select0').attr('style','display:none;');
			      }else{
			         $('#select0').attr('style','display:;');
			      }
			   }
		    }
	    });
    }
</script>
</html>