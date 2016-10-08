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
      	String baseId=request.getAttribute("baseId")!=null?request.getAttribute("baseId").toString():"";
      %>
      <td>
         <select name="baseId" id="baseId" class="selectlist" onchange="chg(this);" style="width:200px;">
            <%
			  List fristCategory = (List)request.getAttribute("fristCategory");
			  if(fristCategory!=null && fristCategory.size()>0){
			     for(int i=0; i<fristCategory.size();i++){
					 DossierCategoryPO dossierCategoryPO = (DossierCategoryPO)fristCategory.get(i);
			%>
			<option value="<%=dossierCategoryPO.getId()%>" <%=baseId.equals(dossierCategoryPO.getId().toString())?"selected":""%>><%=dossierCategoryPO.getName()!=null?dossierCategoryPO.getName():""%></option>
			<%}}%>
         </select>
      </td>
   </tr>
   <tr>
      <td width="100" class="td_lefttitle">上级类目：</td>
      <td>
         <select name="parentId" id="parentId" class="selectlist" onchange="chg2(this);" style="width:200px;">
            <%
              String space="";
			  List categoryList = (List)request.getAttribute("categoryList");
			  if(categoryList!=null && categoryList.size()>0){
			     for(int i=0; i<categoryList.size();i++){
					 DossierCategoryPO po = (DossierCategoryPO)categoryList.get(i);
					 space="";
					 for(int j=1;j<Integer.parseInt(po.getLevel());j++){
						 space+="&nbsp;&nbsp;";
					 }
			%>
			<option property="<%=po.getLevel()%>" value="<%=po.getId()%>"><%=space%><%=po.getName()!=null?po.getName():""%></option>
			<%}}%>
         </select>
      </td>
   </tr>
   <tr>
      <td width="100" class="td_lefttitle">类目级别：</td>
      <td>
         <s:textfield name="dossierCategoryPo.level" id="level" value="2" cssClass="inputText" cssStyle="width:96%;" readonly="true"/>
      </td>
   </tr>
   
   <s:hidden name="dossierCategoryPo.sort" id="sort" value="1"/>
   
   <tr>
      <td for="可查看人" width="100" class="td_lefttitle">可查看人<span class="MustFillColor">*</span>：</td>
      <td>
         <s:hidden name="dossierCategoryPo.lookUserId" id="lookUserId" /><input type="hidden"  name="fromParentRange" id="fromParentRange"/>
         <s:textarea name="dossierCategoryPo.lookUser"  id="lookUser" cols="112" rows="3" cssClass="inputTextarea" whir-options="vtype:['notempty']" cssStyle="width:96%;" readonly="true"></s:textarea><span id="select0" style="display:"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectLookUser()"></a></span>
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
         <input type="button" class="btnButton4font" onClick="saveAndContinue(this);" value="<s:text name="comm.savecontinue"/>" />
         <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
         <input type="button" class="btnButton4font" onClick="window.close();" value="<s:text name="comm.exit"/>" />
      </td>
   </tr>
</table>
<script type="text/javascript">
	$(function() {
		$('#parentId').change();
	});
	function selectLookUser(){
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