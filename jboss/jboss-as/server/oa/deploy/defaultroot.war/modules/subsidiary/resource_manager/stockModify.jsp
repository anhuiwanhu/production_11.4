<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  String type =request.getParameter("type") == null ? "" : request.getParameter("type");
  String title ="修改仓库";
  if("view".equals(type)){
      title ="查看仓库";
  }
%>
<head>
	<title><%=title%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="Pupwin">
	<div class="BodyMargin_10">
		<div class="docBoxNoPanel">
	       <s:form name="dataForm" id="dataForm" action="/stockAction!updatetock.action" method="post" theme="simple" >
              <%@ include file="/public/include/form_detail.jsp"%>
	          <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
	          <s:hidden name="stockPo.id" id="stockPo.id"/>
	          <s:hidden name="vindicate" id="vindicate" value="%{#request.vindicate}"/>
	          <tr>
	             <td for="仓库名称" class="td_lefttitle" width="8%" nowrap>仓库名称<span class="MustFillColor">*</span>：</td>
	             <td>
	                 <%if("view".equals(type)){%>
	                 <s:textfield name="stockPo.stockName" id="stockName" cssClass="inputText" cssStyle="width:94%;" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" readonly="true"/>
	                 <%}else{%>
	                 <s:textfield name="stockPo.stockName" id="stockName" cssClass="inputText" cssStyle="width:94%;" whir-options="vtype:['notempty',{'maxLength':20},'spechar3']" />
	            	 <%}%>
	            </td>
	          </tr>
	          
	          <tr>
	             <td for="适用范围" class="td_lefttitle" width="8%" nowrap>适用范围<span class="MustFillColor">*</span>：</td>
	             <td>
	             	 <s:hidden name="stockPo.stockApplyExtensionId" id="stockApplyExtensionId"/><s:textarea name="stockPo.stockApplyExtension" id="stockApplyExtension" cssClass="inputTextarea" rows="3" cssStyle="width:94%;" readonly="true" whir-options="vtype:['notempty',{'maxLength':500}]"></s:textarea><%if(!"view".equals(type)){%><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'stockApplyExtensionId', allowName:'stockApplyExtension', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"></a><%}%>
	             </td>
	          </tr>
	          
	          <tr>
	             <td for="管理员" class="td_lefttitle" width="8%" nowrap>管理员<span class="MustFillColor">*</span>：</td>
	             <td>
	             	 <s:hidden name="stockPo.stockPut" id="stockPut"/><s:textarea name="stockPo.stockPutName" id="stockPutName" cssClass="inputTextarea" cssStyle="width:94%;" rows="3" readonly="true" whir-options="vtype:['notempty',{'maxLength':500}]"></s:textarea><%if(!"view".equals(type)){%><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'stockPut', allowName:'stockPutName', select:'user', single:'no', show:'user', range:'*0*'});"></a><%}%>
	             </td>
	          </tr>
	          
	          <tr>
	             <td for="描述" class="td_lefttitle" width="8%" nowrap>描述：</td>
	             <td>
	             	 <%if("view".equals(type)){%>
	             	 <s:textarea name="stockPo.stockDesci" id="stockDesci" cssClass="inputTextarea" cssStyle="width:94%;" rows="3"  whir-options="vtype:[{'maxLength':500}]" readonly="true"></s:textarea>
	             	 <%}else{%>
	             	 <s:textarea name="stockPo.stockDesci" id="stockDesci" cssClass="inputTextarea" cssStyle="width:94%;" rows="3"  whir-options="vtype:[{'maxLength':500}]"></s:textarea>
	             	 <%}%>
	             </td>
	          </tr>
	          
	          <tr>
	             <td for="备注" class="td_lefttitle" width="8%" nowrap>备注：</td>
	             <td>
	                 <%if("view".equals(type)){%>
	                 <s:textarea name="stockPo.remark" id="remark" cssClass="inputTextarea" cssStyle="width:94%;" rows="3"  whir-options="vtype:[{'maxLength':50}]" readonly="true"></s:textarea>
	                 <%}else{%>
	             	 <s:textarea name="stockPo.remark" id="remark" cssClass="inputTextarea" cssStyle="width:94%;" rows="3"  whir-options="vtype:[{'maxLength':50}]"></s:textarea>
	             	 <%}%>
	             </td>
	          </tr>
	          
	          <tr>
	             <td for="出库审核" class="td_lefttitle" width="8%" nowrap>出库审核：</td>
	             <td>
	             	 <%if("view".equals(type)){%>
	             	 <s:radio id="chukuShenhe" name="stockPo.chukuShenhe" list="%{#{'1':'是','0':'否'}}" onclick="displayKucun(this);" disabled="true"></s:radio>
	             	 <%}else{%>
	             	 <s:radio id="chukuShenhe" name="stockPo.chukuShenhe" list="%{#{'1':'是','0':'否'}}" onclick="displayKucun(this);" ></s:radio>
	             	 <%}%>
	             </td>
	          </tr>
	          
	          <tr id="shenhe" <s:if test="stockPo.chukuShenhe ==1">style="display:"</s:if><s:else>style="display:none"</s:else>>
	             <td class="td_lefttitle" width="8%">&nbsp;</td>
	             <td>
	             	  <%if("view".equals(type)){%>
	             	  <s:checkboxlist name="shenhe1" id="shenhe1" list="#{'1':'采购进货流程'}" value="%{#request.shenhe1}" disabled="true"/>
	             	  <s:checkboxlist name="shenhe2" id="shenhe2" list="#{'1':'领用出库流程'}" value="%{#request.shenhe2}" disabled="true"/>
	             	  <s:checkboxlist name="shenhe3" id="shenhe3" list="#{'1':'领用退库流程'}" value="%{#request.shenhe3}" disabled="true"/>
	             	  <s:checkboxlist name="shenhe4" id="shenhe4" list="#{'1':'物品退货流程'}" value="%{#request.shenhe4}" disabled="true"/>
	             	  <%}else{%>
	             	  <s:checkboxlist name="shenhe1" id="shenhe1" list="#{'1':'采购进货流程'}" value="%{#request.shenhe1}"/>
	             	  <s:checkboxlist name="shenhe2" id="shenhe2" list="#{'1':'领用出库流程'}" value="%{#request.shenhe2}"/>
	             	  <s:checkboxlist name="shenhe3" id="shenhe3" list="#{'1':'领用退库流程'}" value="%{#request.shenhe3}"/>
	             	  <s:checkboxlist name="shenhe4" id="shenhe4" list="#{'1':'物品退货流程'}" value="%{#request.shenhe4}"/>
	             	  <%}%>
	             </td>
	          </tr>
	          <tr id="tongbu" <s:if test="stockPo.chukuShenhe ==1">style="display:"</s:if><s:else>style="display:none"</s:else>>
                 <td class="td_lefttitle" width="8%" for="同步到移动端">同步到移动端：</td>
                 <td>
				     <%if("view".equals(type)){%>
					 <s:checkboxlist name="pToMPhone" id="pToMPhone" list="#{'1':'同步到手机端'}" value="%{#request.pToMPhone}" disabled="true"/>
	             	 <s:checkboxlist name="pToPAD" id="pToPAD" list="#{'1':'同步到PAD端'}" value="%{#request.pToPAD}" disabled="true"/>  
					 <%}else{%>
                     <s:checkboxlist name="pToMPhone" id="pToMPhone" list="#{'1':'同步到手机端'}" value="%{#request.pToMPhone}" />
	             	 <s:checkboxlist name="pToPAD" id="pToPAD" list="#{'1':'同步到PAD端'}" value="%{#request.pToPAD}"/>  
					 <%}%>
                  </td>
              </tr>
	          <tr id="kucunTr" <s:if test="stockPo.chukuShenhe ==0">style="display:"</s:if><s:else>style="display:none"</s:else>>
	             <td for="申请影响库存" class="td_lefttitle" width="8%" nowrap>申请影响库存：</td>
	             <td>
	             	 <%if("view".equals(type)){%>
	             	 <s:radio id="isKucun" name="stockPo.isKucun" list="%{#{'1':'是','0':'否'}}" disabled="true"></s:radio>
	             	 <%}else{%>
	             	 <s:radio id="isKucun" name="stockPo.isKucun" list="%{#{'1':'是','0':'否'}}"></s:radio>
	             	 <%}%>
	             </td>
	          </tr>
	          
	          <tr class="Table_nobttomline">
                   <td></td>
                   <td nowrap>
                      <%if(!"view".equals(type)){%>
                      <input type="button" class="btnButton4font" onClick="saveAndExit(this);" value="<s:text name='comm.saveclose'/>" />
                      <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name='comm.reset'/>" />
                      <%}%>
                      <input type="button" class="btnButton4font" onClick="window.close();" value="<s:text name='comm.exit'/>" />
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
    function displayKucun(obj){
        var chukuShenhe =$(obj).val();
        if(chukuShenhe =='0'){
            $('#kucunTr').attr('style','display:');
            $('#shenhe').attr('style','display:none');
			$('#tongbu').attr('style','display:none');	
        }else if(chukuShenhe =='1'){
        	$('#uniform-isKucun1').find('span').attr('class','checked');
        	$('#uniform-isKucun1').find('#isKucun1').prop('checked',true);
        	
        	$('#uniform-isKucun0').find('span').attr('class','');
        	$('#uniform-isKucun0').find('#isKucun0').prop('checked',false);
        	
            $('#kucunTr').attr('style','display:none');
            $('#shenhe').attr('style','display:');
			$('#tongbu').attr('style','display:');	
        }
    }
    
    function saveAndExit(obj){
    	var chukuShenheRadio = $('input:radio[name="stockPo.chukuShenhe"]:checked').val();
    	if(chukuShenheRadio =='1'){
    	   var shenhe1 = $('input:checkbox[name="shenhe1"]:checked').val();
    	   var shenhe2 = $('input:checkbox[name="shenhe2"]:checked').val();
    	   var shenhe3 = $('input:checkbox[name="shenhe3"]:checked').val();
    	   var shenhe4 = $('input:checkbox[name="shenhe4"]:checked').val();
    	   if(shenhe1 != '1' && shenhe2 != '1' && shenhe3 != '1' && shenhe4 != '1'){
    	      whir_alert("请选择相应的审核流程！", null);
    	      return false;
    	   }
    	}
        ok(0,obj);
    }
    
    //2013-08-06-----禁止Backspace-----start
	$(document).keydown(function(e){
        var doPrevent;
        var varkey =(e.keyCode) || (e.which) || (e.charCode);
        if(varkey ==8){
        	 var d = e.srcElement || e.target;
        	 if(d.tagName.toUpperCase() == 'INPUT' || d.tagName.toUpperCase() == 'TEXTAREA'){
        	 	doPrevent = d.readOnly || d.disabled;
        	 	if(d.type.toUpperCase() == 'SUBMIT' || d.type.toUpperCase() == 'RADIO' || d.type.toUpperCase() == 'CHECKBOX' || d.type.toUpperCase() == 'BUTTON'){
        	 		doPrevent = true;
        	 	}
        	 }else{
        	 	doPrevent = true;
        	 }
        }
        if(doPrevent){
        	e.preventDefault();
        }
    });
    //2013-08-06-----禁止Backspace-----end
</script>
</html>