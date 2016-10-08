<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.whir.ezoffice.workflow.vo.PackageVO"%>
<%@ page import="com.whir.ezoffice.workflow.vo.AccessTableVO"%>
<%@ page import="com.whir.ezoffice.workflow.vo.SimpleFieldVO"%>
<%@ page import="java.util.*"%>
<%@page import="com.whir.i18n.Resource"%>
<%
  String moduleId = request.getAttribute("moduleId")+"";
  if(Integer.parseInt(moduleId)>=100 && Integer.parseInt(moduleId)<110){
	moduleId = "1";
  }

  String  dossierDisplayStr="  style=\"display:none\"  ";
  if(moduleId.equals("1")){
        dossierDisplayStr=" ";
  }

  String comm_upload = Resource.getValue(local,"common","comm.upload");
%>

<style type ="text/css" >
  .td0 {border-bottom:1px solid #AAA}
 </style>
<s:hidden name="wfWorkFlowProcessId" id="wfWorkFlowProcessId" />
<s:hidden name="moduleId"  id="moduleId" />
<s:hidden name="moduleVO.formClassName" id="moduleVO_formClassName"/>
<s:hidden name="moduleVO.newFormMethod" id="moduleVO_newFormMethod"/>
<s:hidden name="moduleVO.completeMethod" id="moduleVO_completeMethod"/>
<s:hidden name="processPO.processSort"  id="processSort" />
<div class="BodyMargin_10">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
    <tr>
        <td colspan="2">
            <div class="Public_tag">
                <ul>
                    <li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newworkflowbasicinfo"/></span><span class="tag_right"></span>
                    </li>
					<li id="Panle1" onClick="changePanle(1);"><span class="tag_center"><s:text name="workflow.newactivitydefinefiled"/></span><span class="tag_right"></span>
                    <li id="Panle2" onClick="changePanle(2);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newworkflowinterface"/></span><span class="tag_right"></span>
                    </li>     
                </ul>
            </div>
        </td>
    </tr>
</table>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="TableLine">
    <tr>
        <td valign="top">
            <div id="docinfo0" style="display:;">
                <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0">
				   <!--流程分类-->
                   <tr>  
		              <td for='<bean:message bundle="workflow" key="workflow.setupcategory"/>' width="110px" nowrap class="td_lefttitle"><bean:message bundle="workflow" key="workflow.setupcategory"/><span class="MustFillColor">*</span>：</td>  
		              <td colspan="2"><s:select name="packageId" id="packageId" list="#request.packageList" listKey="id"  listValue="name"   cssStyle="width:200px;height:29px;" whir-options="vtype:['notempty']"  /> 
		              </td> 
					  <td>&nbsp;</td>
	              </tr>

				  <!--流程名-->
				   <tr>  
		              <td for='<bean:message bundle="workflow" key="workflow.workflowname"/>' width="100" class="td_lefttitle"><bean:message bundle="workflow" key="workflow.workflowname"/><span class="MustFillColor">*</span>：</td>  
		              <td colspan="2">  
						<s:textfield name="processPO.workFlowProcessName" id="workFlowProcessName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']" cssStyle="width:96%;" />  
		              </td> 
					  <td >&nbsp;</td>
	              </tr> 
				  <!--适用范围--->
				  <tr>  
		              <td for='<bean:message bundle="workflow" key="workflow.setupusers"/>' width="100" class="td_lefttitle"><bean:message bundle="workflow" key="workflow.setupusers"/><span class="MustFillColor">*</span>：</td>  
		              <td colspan="2">  
						<s:textfield name="processPO.userScope" id="userScope" cssClass="inputText" whir-options="vtype:['notempty']" readonly="true" cssStyle="width:96%;" /><a href="#" class="selectIco" onclick="openSelect({allowId:'scopeId', allowName:'userScope', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
						<s:hidden  name="scopeId" id="scopeId"/>
						<s:hidden  name="processPO.useOrg" id="useOrg"/> 
						<s:hidden  name="processPO.useGroup" id="useGroup"/> 
						<s:hidden  name="processPO.usePerson" id="usePerson"/> 
		              </td> 
					  <td  align="left" valign="bottom">&nbsp;</td>
	              </tr> 
				  <s:if test="moduleVO.changeProcType==true">
				   <!--'1':'业务流程','0':'随机流程'  -->
				   <tr>
				      <td class="td_lefttitle" ><bean:message bundle="workflow" key="workflow.Workflowcategory"/>：</td>
				      <td><s:radio name="processPO.processType"  id="processType" list="%{#{'1':getText('workflow.newworkflowfix'),'0':getText('workflow.newworkflowrandom')}}" theme="simple"  ></s:radio></td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
				   </tr>
				  </s:if>
				  <s:else>
                    <s:hidden  name="processPO.processType"  id="processType"/>
                  </s:else>
				  <tr style="display:none">
				     <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowcancel"/>：
					 </td>
					 <td colspan="2">
					   <s:hidden  name="processPO.canCancel"  id="canCancel" />
					 </td>
					 <td>
					 </td>
				  </tr>

				  <s:if test="moduleId==1">
				  <!--'0':'自定义表单','1':'JSP文件'-->
				  <tr>
				     <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowformtype"/>：</td>
				     <td><s:radio name="processPO.formType"  id="formType" list="%{#{'0':getText('workflow.newworkflowdiyform'),'1':getText('workflow.newworkflowjspfile')}}" theme="simple"  onclick="setFormType(this)" ></s:radio></td>
					 <td>&nbsp;</td>
					 <td>&nbsp;</td>
				   </tr>
				  </s:if>
				  <s:else>
                     <s:hidden  name="processPO.formType"  id="formType"/>
                  </s:else>
                  
				  <!--上传jsp  注意验证是否为空-->
				  <tr name="startJSPTR" id="startJSPTR" style="display:none" >
					  <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowjspfilestart"/>：</td>
					  <td>
					     <s:textfield name="processPO.startJSP" id="startJSP" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" cssStyle="width:96%;"/>
					   </td>
					  <td colspan="2">
					   <%--<div style="margin-left:-1px;margin-top:10px">
						 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">      
						   <jsp:param name="onInit"             value="" /> 
						   <jsp:param name="onSelect"             value="" />  
						   <jsp:param name="onUploadProgress"     value="" /> 
						   <jsp:param name="onUploadSuccess"      value="formStartJSPUpload" />
						   <jsp:param name="dir"         value="/WEB-INF/classes/com/whir/ezoffice/form/" />
						   <jsp:param name="uniqueId"    value="workFlow01" />
						   <jsp:param name="realFileNameInputId"    value="startJSP" /> 
						   <jsp:param name="saveFileNameInputId"    value="startJSP" />
						   <jsp:param name="canModify"       value="yes" /> 		  
						   <jsp:param name="width"        value="70" /> 
						   <jsp:param name="height"       value="20" /> 
						   <jsp:param name="multi"        value="true" /> 
						   <jsp:param name="buttonClass" value="upload_btn" /> 
						   <jsp:param name="buttonText"       value="" /> 
						   <jsp:param name="fileSizeLimit"        value="0" /> 
						   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
						   <jsp:param name="uploadLimit"      value="0" /> 
						</jsp:include>
					  </div>--%>
					 </td>
				  </tr>

				  <tr name="optJSPTR" id="optJSPTR"  style="display:none"  >
					 <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowjspfileflow"/>：</td>
					 <td>
					   <s:textfield name="processPO.optJSP" id="optJSP" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" cssStyle="width:96%;" />
					  </td>
					 <td colspan="2">
						 <%--<div style="margin-left:-1px;margin-top:10px">
							 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">      
							   <jsp:param name="onInit"             value="" /> 
							   <jsp:param name="onSelect"           value="" />  
							   <jsp:param name="onUploadProgress"   value="" /> 
							   <jsp:param name="onUploadSuccess"      value="formOptJSPUpload" />
							   <jsp:param name="dir"         value="/WEB-INF/classes/com/whir/ezoffice/form/" />
							   <jsp:param name="uniqueId"    value="workFlow02" />
							   <jsp:param name="realFileNameInputId"    value="optJSP" /> 
							   <jsp:param name="saveFileNameInputId"    value="optJSP" />
							   <jsp:param name="canModify"       value="yes" /> 		  
							   <jsp:param name="width"        value="70" /> 
							   <jsp:param name="height"       value="20" /> 
							   <jsp:param name="multi"        value="true" /> 
							   <jsp:param name="buttonClass" value="upload_btn" /> 
							   <jsp:param name="buttonText"       value="" /> 
							   <jsp:param name="fileSizeLimit"        value="0" /> 
							   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
							   <jsp:param name="uploadLimit"      value="0" /> 
							</jsp:include>
						  </div>--%>
				      </td>
				  </tr>
				
               <tr name="customForm" id="customForm">
			      <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowformuse"/><span class="MustFillColor">*</span>：</td>
				  <td colspan="2" id="accessDatabaseIdTD">
                     <s:select name="processPO.accessDatabaseId" id="accessDatabaseId" list="#request.tableList" listKey="id"  listValue="displayName"    cssStyle="width:200px;height:29px;"  data-options="onSelect: function(record){changeTable(record);}" /> 
                  </td>
				  <td>&nbsp;</td>
			  </tr>
			 

              <!--办理查阅查看人-->
			  <tr <%=dossierDisplayStr%>>
			     <td class="td_lefttitle" nowrap><bean:message bundle="workflow" key="workflow.newworkflowauthorizeduser"/>：</td>
				 <td colspan=2><s:textarea name="processPO.dossierFileSeeScope"  id="dossierFileSeeScope" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:96%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'dossierFileSeeScopeId', allowName:'dossierFileSeeScope', select:'userorggroup', single:'no', show:'usergrouporg', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
				 <s:hidden  name="dossierFileSeeScopeId" id="dossierFileSeeScopeId"/>
				 <s:hidden name="processPO.dossierFileSeeOrg"  id="dossierFileSeeOrg"/>
				 <s:hidden name="processPO.dossierFileSeeGroup"  id="dossierFileSeeGroup"/>
				 <s:hidden name="processPO.dossierFileSeePerson"  id="dossierFileSeePerson"/>
				 </td>
				 <td align="left" valign="bottom"></td>
			  </tr>
              
			  <!--办理查阅维护人-->
			  <tr <%=dossierDisplayStr%>>
			     <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowmaintainuser"/>：</td>
                 <td colspan=2><s:textarea name="processPO.dossierFileOperScope"  id="dossierFileOperScope" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:96%;" readonly="true"></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'dossierFileOperScopeId', allowName:'dossierFileOperScope', select:'userorggroup', single:'no', show:'usergrouporg', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
				 <s:hidden  name="dossierFileOperScopeId" id="dossierFileOperScopeId"/>
				 <s:hidden name="processPO.dossierFileOperOrg"  id="dossierFileOperOrg"/>
				 <s:hidden name="processPO.dossierFileOperGroup"  id="dossierFileOperGroup"/>
				 <s:hidden name="processPO.dossierFileOperPerson"  id="dossierFileOperPerson"/> 
			    </td>
		        <td align="left" valign="bottom">
				</td> 
			  </tr>


             <!--流程管理员-->
			 <tr <%=dossierDisplayStr%>>
                 <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.Workflowadministrator"/>：</td>
                 <td colspan=2><s:textarea name="processPO.processAdminScope"  id="processAdminScope" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:96%;" readonly="true"></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'processAdminScopeId', allowName:'processAdminScope', select:'userorggroup', single:'no', show:'usergrouporg', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
				 <s:hidden name="processPO.processAdminOrg"  id="processAdminOrg"/>
				 <s:hidden name="processPO.processAdminGroup"  id="processAdminGroup"/>
				 <s:hidden name="processPO.processAdminPerson"  id="processAdminPerson"/>
				 <s:hidden  name="processAdminScopeId" id="processAdminScopeId"/>
			     </td>
		         <td align="left" valign="bottom"></td> 
             </tr>

			<!--打印权限 现在删除了-->
			<s:hidden name="processPO.printFileSeeScope" id="printFileSeeScope" />
			<s:hidden name="printFileSeeScopeId" id="printFileSeeScopeId" />
			<s:hidden name="processPO.printFileSeeOrg" id="printFileSeeOrg" />
			<s:hidden name="processPO.printFileSeeGroup" id="printFileSeeGroup" />
			<s:hidden name="processPO.printFileSeePerson" id="printFileSeePerson" />
            <!--设置项-->
			 <tr>
				 <td class="td_lefttitle"><s:text name="workflow.set_set"/>：</td>
				 <td colspan="3">
					<span  style="display:'<%=(",1,,2,,3,,4,,34,,50,".indexOf(","+moduleId+",")<0)?"none":""%>'"><s:checkbox  name="dossier"  id="dossier" ></s:checkbox><bean:message bundle="workflow" key="workflow.newworkflowarchive"/>&nbsp;</span>
					<span  style="display:<%="1".equals(moduleId)?"":""%>">
					<s:checkbox  name="canPrint"  id="canPrint" ></s:checkbox><bean:message bundle="workflow" key="workflow.Sponsormayprinttheworkflowafterprocess"/>&nbsp;
					<s:checkbox  name="commentNotNull"  id="commentNotNull" ></s:checkbox><s:text name="workflow.set_commentisnotnull"/>&nbsp;
					<s:checkbox  name="keepBackComment"  id="keepBackComment" ></s:checkbox><s:text name="workflow.set_backsavecomment"/>&nbsp;
					<s:checkbox  name="completeNeddMailRemind"  id="completeNeddMailRemind" ></s:checkbox><s:text name="workflow.set_completeprocesswithemail"/>
					</span>						 
				 </td>
            </tr>

			 <tr <%if(moduleId.equals("50") || moduleId.equals("52")){%>style="display:none;"<%}%>>
				 <td class="td_lefttitle"><s:text name="workflow.processMobileStatus"/>：</td>
				 <td colspan="3">
				    <s:checkbox  name="bool_mobilePhoneStatus"  id="bool_mobilePhoneStatus"></s:checkbox><s:text name="workflow.processCanMobilePhoneStatus"/><!-- 同步到手机端 -->&nbsp;
                    <s:checkbox  name="bool_padStatus"  id="bool_padStatus"></s:checkbox><s:text name="workflow.processCanPADStatus"/><!-- 同步到PAD端 -->
				 </td>
            </tr>
              
           <tr>
              <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.ezFLOWDescription"/>：</td><td colspan=3></td>
          </tr>
		  <tr>
              <td colspan=3>
			      <INPUT type="hidden" name="content1" id="content1">
			      <IFRAME   id="newedit" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=content1&style=coolblue&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>"  frameborder="0" scrolling="no" width="97%" height="350"></IFRAME>
				  <s:textarea name="processPO.processDescription"  id="processDescription" cols="112" rows="3" cssClass="inputTextarea" cssStyle="display:none"></s:textarea> 
			 </td>
			 <td></td>
         </tr>
		 <tr>
              <td colspan=4><p><B><bean:message bundle="workflow" key="workflow.newworkflowps"/>：</B><bean:message bundle="workflow" key="workflow.newworkflowrandomtip"/></p></td>
         </tr>

		 <tr  class="Table_nobttomline">
			   <td class="td_lefttitle" >&nbsp;</td>
			   <td colspan="3">
				<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
				<s:if test="wfWorkFlowProcessId==null">
				<input type="button" class="btnButton4font" onClick="save(1,this);"  id="saveContinueButton" value='<s:text name="comm.savecontinue"/>' />  
				</s:if>
				<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
				<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
			   </td>
          </tr>
       </table>
  </div>
  <div id="docinfo1" style="display:none;">
      <div id="fielddiv"></div>
  </div>
  <div id="docinfo2" style="display:none;">
      <!--接口-->
	 <table width="100%" border="0" cellpadding="2" cellspacing="1" class="Table_bottomline" >
		  <tr>
			<td  width="110px" class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowformclass"/>：</td>
			<td width="45%"> 
			<s:textfield name="processPO.formClassName" id="formClassName" cssClass="inputText" whir-options="vtype:[{'maxLength':50}],'promptText':'请输入名称'" cssStyle="width:96%;" readonly="false" /> 
			 </td>
			 <td width="110px">
				   <%--<div style="margin-left:-1px;margin-top:10px">
					 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">      
					   <jsp:param name="onInit"             value="" /> 
					   <jsp:param name="onSelect"           value="" />  
					   <jsp:param name="onUploadProgress"   value="" /> 
					   <jsp:param name="onUploadSuccess"      value="formClassUpload" />
					   <jsp:param name="dir"         value="/WEB-INF/classes/com/whir/ezoffice/form/" />
					   <jsp:param name="uniqueId"    value="workFlow" />
					   <jsp:param name="realFileNameInputId"    value="formClassName" /> 
					   <jsp:param name="saveFileNameInputId"    value="formClassName" />
					   <jsp:param name="canModify"       value="yes" /> 		  
					   <jsp:param name="width"        value="70" /> 
					   <jsp:param name="height"       value="20" /> 
					   <jsp:param name="multi"        value="true" /> 
					   <jsp:param name="buttonClass" value="upload_btn" /> 
					   <jsp:param name="buttonText"       value="" /> 
					   <jsp:param name="fileSizeLimit"        value="0" /> 
					   <jsp:param name="fileTypeExts"         value="*.class" /> 
					   <jsp:param name="uploadLimit"      value="0" /> 
					</jsp:include>
				  </div>--%>
            </td>
			<td><label class="MustFillColor"><bean:message bundle="workflow" key="workflow.newworkflowtip"/></label></td>
		  </tr>
		  <tr>
			 <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowsubmitmethod"/>：</td>
			 <td >
			    <s:textfield name="processPO.formClassMethod" id="formClassMethod" cssClass="inputText" whir-options="vtype:[{'maxLength':25}]" cssStyle="width:96%;" readonly="true" />
			 </td>
		     <td></td>
			 <td><label class="MustFillColor"><bean:message bundle="workflow" key="workflow.newworkflowtip"/></label></td>
		  </tr>
		  <tr>
			<td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newworkflowfinishmethod"/>：</td>
			<td ><s:textfield name="processPO.formClassCompMethod" id="formClassCompMethod" cssClass="inputText" whir-options="vtype:[{'maxLength':25}]" cssStyle="width:96%;" readonly="true" />
			</td>
			<td></td>
			<td><label class="MustFillColor"><bean:message bundle="workflow" key="workflow.newworkflowtip"/></label></td>
		  </tr>
		  <tr><td colspan="4" class="td_lefttitle" ><b><s:text name="workflow.set_dealwithjs"/></b></td></tr>
		  <tr>
				<td class="td_lefttitle" ><s:text name="workflow.set_jsfile"/>：</td>
				<td> 
				<s:textfield name="processPO.jsFileName" id="jsFileName" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" cssStyle="width:96%;" readonly="false" /></td>
				<td>
				  <%--<div style="margin-left:-1px;margin-top:10px">
					 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">       
					   <jsp:param name="onInit"             value="" /> 
					   <jsp:param name="onSelect"           value="" />  
					   <jsp:param name="onUploadProgress"   value="" /> 
					   <jsp:param name="onUploadSuccess"      value="jsFileUpload" />
					   <jsp:param name="dir"         value="/modulesext/devform/workflow/" />
					   <jsp:param name="uniqueId"    value="workFlow2" />
					   <jsp:param name="realFileNameInputId"    value="jsFileName" /> 
					   <jsp:param name="saveFileNameInputId"    value="jsFileName" />
					   <jsp:param name="canModify"       value="yes" /> 		  
					   <jsp:param name="width"        value="70" /> 
					   <jsp:param name="height"       value="20" /> 
					   <jsp:param name="multi"        value="true" /> 
					   <jsp:param name="buttonClass" value="upload_btn" /> 
					   <jsp:param name="buttonText"       value="" /> 
					   <jsp:param name="fileSizeLimit"        value="0" /> 
					   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
					   <jsp:param name="uploadLimit"      value="0" /> 
					</jsp:include>
				  </div>--%>
				</td>
				<td></td>
		  </tr>
		  <tr>
				<td class="td_lefttitle" ><!-- 手机 --><s:text name="workflow.Mobilephone"/><s:text name="workflow.set_jsfile"/>：</td>
				<td> 
				<s:textfield name="processPO.jsFileName_phone" id="jsFileName_phone" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" cssStyle="width:96%;" readonly="false" /></td>
				<td>
				  <%--<div style="margin-left:-1px;margin-top:10px">
					 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">       
					   <jsp:param name="onInit"             value="" /> 
					   <jsp:param name="onSelect"           value="" />  
					   <jsp:param name="onUploadProgress"   value="" /> 
					   <jsp:param name="onUploadSuccess"      value="jsFileUpload_phone" />
					   <jsp:param name="dir"         value="/modulesext/devform/workflow/" />
					   <jsp:param name="uniqueId"    value="workFlow3" />
					   <jsp:param name="realFileNameInputId"    value="jsFileName" /> 
					   <jsp:param name="saveFileNameInputId"    value="jsFileName" />
					   <jsp:param name="canModify"       value="yes" /> 		  
					   <jsp:param name="width"        value="70" /> 
					   <jsp:param name="height"       value="20" /> 
					   <jsp:param name="multi"        value="true" /> 
					   <jsp:param name="buttonClass" value="upload_btn" /> 
					   <jsp:param name="buttonText"       value="" /> 
					   <jsp:param name="fileSizeLimit"        value="0" /> 
					   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
					   <jsp:param name="uploadLimit"      value="0" /> 
					</jsp:include>
				  </div>--%>
				</td>
				<td></td>
		  </tr>
		  <tr>
				<td class="td_lefttitle"><s:text name="workflow.set_loadjsmethod"/>：</td>
				<td>
				   <s:textfield name="processPO.jsLoadMethod" id="jsLoadMethod" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" cssStyle="width:96%;"  />
				</td>
				<td></td>
				<td></td>
		  </tr>
		  <tr>
				<td class="td_lefttitle"><s:text name="workflow.set_updatejsmethod"/>：</td>
				<td><s:textfield name="processPO.jsSaveMethod" id="jsSaveMethod" cssClass="inputText" whir-options="vtype:[{'maxLength':50}]" cssStyle="width:96%;"  />&nbsp;</td>
				<td></td>
				<td></td>
		  </tr> 

		  <tr  class="Table_nobttomline">
			   <td class="td_lefttitle"  id="gggggggggg" >&nbsp;</td>
			   <td colspan="3">
				<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
				<s:if test="wfWorkFlowProcessId==null">
				<input type="button" class="btnButton4font" onClick="save(1,this);"  id="saveContinueButton" value='<s:text name="comm.savecontinue"/>' />  
				</s:if>
				<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
				<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
			   </td>
          </tr>
	 </table>
	 <iframe name="myIframe" id="myIframe" style="display:none" ></iframe>
  </div>          
    </td>
 </tr>
</table>
</div>
<SCRIPT LANGUAGE="JavaScript">
<!--
 /*
 上传js脚本文件
 */
function jsFileUpload(json){
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#jsFileName").val(file_name+file_type);
}

//jsFileName_phone
 /*
 上传js脚本文件
 */
function jsFileUpload_phone(json){
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#jsFileName_phone").val(file_name+file_type);
}

/*
上传自定义类
*/
function  formClassUpload(json){
     var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#formClassName").val(file_name+file_type);
}


 /*
 上传jsp开始文件
 */
function formStartJSPUpload(json){ 
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#startJSP").val(file_name+file_type);
}

 /*
 上传jsp打开文件
 */
function formOptJSPUpload(json){ 
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#optJSP").val(file_name+file_type);
}
 

/*
选择使用的表单
*/
function changeTable(objvalue){	
	var chanNoWrite='<s:property  value="moduleVO.chanNoWrite"/>'=='true'?'1':'0';
    var chanRemind='<s:property  value="moduleVO.chanRemind"/>'=='true'?'1':'0';	
    if(chanNoWrite == 1 || chanRemind == 1){
		 var  url='/defaultroot/wfprocess!changeForm.action';
	     var  para='tableId='+objvalue+'&moduleId=<%=moduleId%>&chanNoWrite='+chanNoWrite+'&chanRemind=' + chanRemind+'&attributeRelate=<s:property  value="attributeRelate"/>&fieldRelate=<s:property value="fieldRelate" />&remindField=<s:property  value="#request.remindField"/>';
		 if($("#wfWorkFlowProcessId").val()!=""){
		     para+='&processId='+$("#wfWorkFlowProcessId").val();
			 para+='&wfWorkFlowProcessId='+$("#wfWorkFlowProcessId").val();		
		 }
		 var  result=ajaxForSync(url,para);
		 //alert(result);
		 $("#fielddiv").html(result);
		 //setInputStyle();
    }
}


function setFormType(obj){  
	setFormType_forValue(obj.value);
	/*if(obj.value=="0"){
		$("#customForm").show();
		if($("#field_td1").length>0){
		    $("#field_td1").show();
		}
		if($("#field_td2").length>0){
		   $("#field_td2").show();
		}
		if($("#field_td3").length>0){
		   $("#field_td3").show();
		}
		if($("#field_td4").length>0){
		    $("#field_td4").show();
		}
		$("#startJSPTR").hide();
		$("#optJSPTR").hide();
	}else if(obj.value=="1"){
		if($("#field_td1").length>0){
			  $("#field_td1").hide();
		}
		if($("#field_td2").length>0){
			  $("#field_td2").hide();
		}
		if($("#field_td3").length>0){
			  $("#field_td3").hide();
		}
		if($("#field_td4").length>0){
			  $("#field_td4").hide();
		}
		$("#customForm").hide();
	 
		$("#startJSPTR").show();
		$("#optJSPTR").show();
	}*/
}  
function setFormType_forValue(value){ 
	if(value=="0"){
		$("#customForm").show();
		if($("#field_td1").length>0){
		    $("#field_td1").show();
		}
		if($("#field_td2").length>0){
		   $("#field_td2").show();
		}
		if($("#field_td3").length>0){
		   $("#field_td3").show();
		}
		if($("#field_td4").length>0){
		    $("#field_td4").show();
		}
		$("#startJSPTR").hide();
		$("#optJSPTR").hide();
	}else if(value=="1"){
		if($("#field_td1").length>0){
			  $("#field_td1").hide();
		}
		if($("#field_td2").length>0){
			  $("#field_td2").hide();
		}
		if($("#field_td3").length>0){
			  $("#field_td3").hide();
		}
		if($("#field_td4").length>0){
			  $("#field_td4").hide();
		}
		$("#customForm").hide();
	 
		$("#startJSPTR").show();
		$("#optJSPTR").show();
	}
}

//装载使用范围
function  buildScopeId(){
    var useOrg = "";
    var useGroup = "";
    var usePerson = "";

    var scopeId =$("#scopeId").val();
    if(scopeId != ""){
    	for( var i = 0; i < scopeId.length; i ++ ){
            flagCode = scopeId.charAt(i);
            nextPos = scopeId.indexOf(flagCode,i + 1);
            str = scopeId.substring(i,nextPos+1);
            if(flagCode == "$"){
                usePerson = usePerson + str;
            }else if(flagCode == "*"){
                useOrg = useOrg + str;
            }else{
                useGroup = useGroup + str;
            }
            i = nextPos;
        }
    }
	$("#useOrg").val(useOrg);
	$("#useGroup").val(useGroup);
	$("#usePerson").val(usePerson);
}

//装载办理查阅查看范围
function  buildDossierFileSee(){

	var dossPerson = "";
    var dossOrg = "";
    var dossGroup = "";
    var dossScope = $("#dossierFileSeeScopeId").val();
    if(dossScope != ""){
     	for( var i = 0; i < dossScope.length; i ++ ){
            flagCode = dossScope.charAt(i);
            nextPos = dossScope.indexOf(flagCode,i + 1);
            str = dossScope.substring(i,nextPos+1);
            if(flagCode == "$"){
                dossPerson = dossPerson + str;
            }else if(flagCode == "*"){
                dossOrg = dossOrg + str;
            }else{
                dossGroup = dossGroup + str;
            }
            i = nextPos;
        }
    }

	$("#dossierFileSeeOrg").val(dossOrg);
	$("#dossierFileSeeGroup").val(dossGroup);
	$("#dossierFileSeePerson").val(dossPerson);	
}


//装载办理查阅维护范围
function  buildDossOperPerson(){

	 //维护查看人
    var dossOperPerson = "";
    var dossOperOrg = "";
    var dossOperGroup = "";
    var dossOperScope =$("#dossierFileOperScopeId").val();
    if(dossOperScope != ""){
     	for( var i = 0; i < dossOperScope.length; i ++ ){
            flagCode = dossOperScope.charAt(i);
            nextPos = dossOperScope.indexOf(flagCode,i + 1);
            str = dossOperScope.substring(i,nextPos+1);
            if(flagCode == "$"){
                dossOperPerson = dossOperPerson + str;
            }else if(flagCode == "*"){
                dossOperOrg = dossOperOrg + str;
            }else{
                dossOperGroup = dossOperGroup + str;
            }
            i = nextPos;
        }
    }


	$("#dossierFileOperOrg").val(dossOperOrg);
	$("#dossierFileOperGroup").val(dossOperGroup);
	$("#dossierFileOperPerson").val(dossOperPerson);	
	
}

//装载办理查阅管理员
function  buildProcessAdminScope(){
	//管理员
    var adminPerson = "";
    var adminOrg = "";
    var adminGroup = "";
    var adminScope = $("#processAdminScopeId").val();
    if(adminScope != ""){
     	for( var i = 0; i < adminScope.length; i ++ ){
            flagCode = adminScope.charAt(i);
            nextPos = adminScope.indexOf(flagCode,i + 1);
            str = adminScope.substring(i,nextPos+1);
            if(flagCode == "$"){
                adminPerson = adminPerson + str;
            }else if(flagCode == "*"){
                adminOrg = adminOrg + str;
            }else{
                adminGroup = adminGroup + str;
            }
            i = nextPos;
        }
    }
 
	$("#processAdminOrg").val(adminOrg);
	$("#processAdminGroup").val(adminGroup);
	$("#processAdminPerson").val(adminPerson);	 
}


 

function beforeSubmit(){
	chooseAllselect("noWriteField");
	chooseAllselect("firstHiddenField");
	buildScopeId();
	//装载办理查阅查看范围
    buildDossierFileSee();
	//装载办理查阅维护范围
    buildDossOperPerson();

	//装载办理查阅管理员
    buildProcessAdminScope();
	//装载办理查阅管理员
   // buildProcessAdminScope();
	var o_Editor = document.getElementById("newedit").contentWindow;
	$("#processDescription").val(o_Editor.getHTML());
    //document.all.processDescription.value = processDescription_html.getHTML();
}

function save(type,obj){ 
	var isSubmit =true;
	var isNullStr =true;
	$("input[name^='f_tableName']").each(function (){
		var f_tableName_as =$(this).val();

		if(f_tableName_as!=null && f_tableName_as !=''){
			if(f_tableName_as.indexOf(' ') > -1){
				isNullStr =false;
				return false;
			}
		}

		//alert($(this).val().substring(0,1)+'|'+isNaN($(this).val()));
		if(f_tableName_as.trim() !='' && !isNaN(f_tableName_as.trim().substring(0,1))){
			isSubmit =false;
			return false;
		}
	});
	if(!isNullStr){
		whir_alert('别名中不能输入空格！',function(){});
		return false;
	}
	
	if(!isSubmit){
		whir_alert('别名第一位不能输入数字！',function(){});
		return false;
	}

	/*var tableId=$("#accessDatabaseId").val();
	try{
       tableId=$('#accessDatabaseId').combobox('getValue');
	}catch(e){
	   tableId=$("#accessDatabaseId").val();
	}*/ 
	var tableId=Ext.getCmp("accessDatabaseId_extId").getValue();

	var   formTypeValue= $("input[name='processPO.formType']:checked").val(); 
 
	if(formTypeValue== undefined){
	      formTypeValue=$("input[name='processPO.formType']").val(); 
	}
 
 
	if((tableId==""||tableId=="-1")&& formTypeValue=="0"){
	    //$.dialog.alert('<%=Resource.getValue(local,"workflow","workflow.workflowselectform")%>',function(){});
		// whir_alert("连接金格数据库失败！请与管理员联系！",function(){});
		whir_poshytip($("#accessDatabaseId_extId").find('input').eq(0),'<%=Resource.getValue(local,"workflow","workflow.workflowselectform")%>');
		//$("#accessDatabaseId").focus(); 
		return ;
	 } 
 
	if(formTypeValue=="1"&& ($("#startJSP").val()==""||$("#optJSP").val()=="")){
	     //$.dialog.alert('<%=Resource.getValue(local,"workflow","workflow.workflowftpjsp")%>',function(){});
		 whir_poshytip($("#startJSP"),'<s:text name="workflow.workflowftpjsp"/>');
		 return;
	}  
   beforeSubmit();
   if(!checkAttributeIsNull()){
      return false;
   }

   var  url='/defaultroot/wfprocess!judgeName.action';
   var  para='j_packageId='+Ext.getCmp("packageId_extId").getValue()+'&j_processName=' +encodeURI($("#workFlowProcessName").val());
   if($("#wfWorkFlowProcessId").val()!=""){  
		 para+='&j_processId='+$("#wfWorkFlowProcessId").val();		
   }
  
   var  responseText=ajaxForSync(url,para); 
   var msg_json = eval("("+responseText+")");
   var judegeresult=msg_json.result; 
 

   if(judegeresult=="success"){
       ok(type,obj);
   }else{
	   whir_alert('<s:text name="workflow.workflowsamename"/>',function(){});
   }
}
 
//
function checkAttributeIsNull(){
	if($("#attributeRelate").attr("checked")=="checked"){
	   var checkArrobj=document.getElementsByName("relateValue");
	   if(checkArrobj){	   
			 if(checkArrobj.length>0){
			     for(var i=0;i<checkArrobj.length;i++){
                      var chkObj = checkArrobj[i] ;
					  if(chkObj.value=="-1"||chkObj.value=="") {
						 whir_alert('<s:text name="workflow.attributeRelate1"/>',function(){});
						 return false;
				     }					 
				 }		           
			 }else{
				  if(checkArrobj.value=="-1"||checkArrobj.value==""){
				      whir_alert('<s:text name="workflow.attributeRelate1"/>',function(){});
					  return false;
				  }
			 }
      
			 checkArrobj=document.getElementsByName("beRelateField");//document.all.beRelateField;
			 if(checkArrobj.length>0){
			     for(var i=0;i<checkArrobj.length;i++){
                      var chkObj = checkArrobj[i] ;
					  if(chkObj.value=="-1"||chkObj.value=="") {
						 whir_alert('<s:text name="workflow.attributeRelate2"/>',function(){});
						 return false;
				     }					 
				 }		           
			 }else{
				  if(checkArrobj.value=="-1"||checkArrobj.value==""){
				      whir_alert('<s:text name="workflow.attributeRelate2"/>',function(){});
					  return false;
				  }
			 }
	   }
	} 
     
	var result=true;
	if($("#fieldRelate").attr("checked")=="checked"){ 
	   //启动字段联动设置 
	   if($("#fieldRelateAddNum").length>0){
		   var  num=$("#fieldRelateAddNum").val();
		   if(num>0){
			   for(var index=0;index<num;index++){

				  $("[name='f_whereInputTextFieldName"+index+"']").each(function(){ 
					  var  chkObj=$(this).val();
					  if(chkObj=="-1"||chkObj==""){
                            whir_alert('<s:text name="workflow.attributeRelate3"/>',function(){});
						    result=false;
							return false;						   
					  }
				 }); 
 

				 $("[name='f_selectInputTextFieldName"+index+"']").each(function(){ 
					  var  chkObj=$(this).val();
					  if(chkObj=="-1"||chkObj==""){
						    whir_alert('<s:text name="workflow.attributeRelate3"/>',function(){});
						    result=false;
							return false;	    
					  }	 
				 }); 
			   }	       
		    }
		  }
	   }

	   return result;

}

//取radio的值
function getRadioValue(id){
    var choosedActivityIdObj=document.getElementsByName(id);
    var value="";
	if(choosedActivityIdObj){
	   if(choosedActivityIdObj.length>1){
		   for(var i=0;i<choosedActivityIdObj.length;i++){
			   if(choosedActivityIdObj[i].checked){
				   value=choosedActivityIdObj[i].value;
				   //break  保证是第一个 选中的
				   break;
			   } 
		   }
	   }else{
		   if(choosedActivityIdObj.checked){
			   value=choosedActivityIdObj.value;
		   }
	   }
	}
	return value;
}


function transferOptions(srcObj,desObj){
   if($("#"+srcObj+" option:selected").length>0){
　　　 $("#"+srcObj+" option:selected").each(function(){
　　　　　  $("#"+desObj).append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
　　　　　  $(this).remove();　
　　　 })
   } else { 
      $.dialog.alert('<s:text name="workflow.pleasechoossefield"/>',function(){});
　 } 
}


function transferOptionsAll(srcObj,desObj){ 
    if($("#"+srcObj+" option").length>0){
　　　 $("#"+srcObj+" option").each(function(){ 
　　　　　  $("#"+desObj).append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
　　　　　  $(this).remove();　
　　　 })
   } else {
　　　 $.dialog.alert('<s:text name="workflow.pleasechoossefield"/>',function(){});
　 }   
}
 
/*
设置selectr 所有option 选中
*/
function  chooseAllselect(desObj){
	try{
		if($("#"+desObj+" option").length>0){
	　　　  $("#"+desObj+" option").each(function(){ 
	　　　　　  $(this).attr("selected", true); 　　  
	　　　  });
		} 
	}catch(e){
	}	
}

function  changePanle(flag){
	$(".tag_aon").removeClass("tag_aon");
	$("#Panle"+flag).addClass("tag_aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
}

//初始化
 function  init(){
	  //初始化ext
	  initExt();
	  var chanNoWrite='<s:property  value="moduleVO.chanNoWrite"/>'=='true'?'1':'0';
	  var chanRemind='<s:property  value="moduleVO.chanRemind"/>'=='true'?'1':'0';
	  if($("#wfWorkFlowProcessId").val()!=""){
		    var tableId=Ext.getCmp("accessDatabaseId_extId").getValue();
			var  url='/defaultroot/wfprocess!changeForm.action';
			var  para='tableId='+tableId+'&moduleId=<%=moduleId%>&chanNoWrite='+chanNoWrite+'&chanRemind=' + chanRemind+'&attributeRelate=<s:property  value="attributeRelate"/>&fieldRelate=<s:property value="fieldRelate" />&remindField=<s:property  value="#request.remindField"/>';
			if($("#wfWorkFlowProcessId").val()!=""){
				para+='&processId='+$("#wfWorkFlowProcessId").val();
				para+='&wfWorkFlowProcessId='+$("#wfWorkFlowProcessId").val();
			}
			var  result=ajaxForSync(url,para);
			$("#fielddiv").html(result);
			//展现字段联动
			fieldRelateCheck(document.getElementsByName("fieldRelate"));
			//展现属性关联
			attributeRelateCheck(document.getElementsByName("attributeRelate"));
	  }else{
		  var nowTableId =Ext.getCmp("accessDatabaseId_extId").getValue();
          changeTable(nowTableId);  
		  if(judegeNotNull($("#moduleVO_formClassName").val())){
			  $("#formClassName").val($("#moduleVO_formClassName").val());
		  }
		  if(judegeNotNull($("#moduleVO_newFormMethod").val())){
			  $("#formClassMethod").val($("#moduleVO_newFormMethod").val());
		  }
		  if(judegeNotNull($("#moduleVO_completeMethod").val())){
			  $("#formClassCompMethod").val($("#moduleVO_completeMethod").val());
		  }
	  }
      



      var   formTypeValue= $("input[name='processPO.formType']:checked").val(); 
	  if(formTypeValue== undefined){
	      formTypeValue=$("input[name='processPO.formType']").val(); 
	  }
	  setFormType_forValue(formTypeValue);
 }
 
/*
检测是否不为空
*/
function  judegeNotNull(value){
    if(value!=""&&value!="null"){
	   return true;
	}else{
       return false;
	}
}


// 选择提醒
function  chooseRemindField(obj,name,displayName){
    //  parent.document.all.field_td41.innerHTML = '<input type="text"  name="remindFieldDisplayName" style="width:80%"><input type="hidden"  name="remindFieldHiddenId">';
	var nowDisplayName=$("#remindFieldDisplayName").val();
	var nowHiddenId=$("#remindFieldHiddenId").val();
	//选中
	if(obj.checked){ 
	     $("#remindFieldDisplayName").val(nowDisplayName+"["+displayName+"]");
	     $("#remindFieldHiddenId").val(nowHiddenId+"S"+name+"S");
	}else{
	     $("#remindFieldDisplayName").val(nowDisplayName.replace("["+displayName+"]",""));
	     $("#remindFieldHiddenId").val(nowHiddenId.replace("S"+name+"S",""));
	} 
}



//-----------------------属性关联  js-----------------------------------
//属性关联设置
function  attributeRelateCheck(obj){ 
    if($("#attributeRelate").attr("checked")){
	    if($("#hasindex").val()==0){
		    obj.checked=false;
		    $("#attributeCheckTr_table").hide();
			whir_alert('<s:text  name="workflow.norelationfield"/>',function(){});
		    return ;
	    }else{
           $("#attributeCheckTr_table").show();   
	   }
	}else{
	      $("#attributeCheckTr_table").hide();
	}
}


//属性关联设置 给选中的字段 给一个下拉范围
function attributeSelectOnchange(obj){  
	 $("#attributeCheckTr_table").show();
     var index=-1;
	 var fieldId="";
     $("select[name='relateField']").each(function(){ 
		  index++;
	　　　if(obj==this){ 
		      fieldId=$(this).find("option:selected").attr("fieldId");
		      return false;
	      }  	　　  
	 }); 
     index=index+1;
     var url="<%=rootPath%>/platform/bpm/work_flow/process/wf_process_attrelate_aiframe.jsp";
	 var para="index="+(index)+"&fieldId="+fieldId;
	 //$("#myIframe",document.body).attr("src", url); 
	 var  result=ajaxForSync(url,para); 
     $("#tbl_1 tr:eq("+index+") td:eq(1)").html('<select name="relateValue">'+result+'</select>');  

  
	 $("#tbl_1 tr:eq("+index+") td:eq(1)").show();  
	 $("#tbl_1 tr:eq("+index+")").show(); 
      $("#tbl_1").show(); 
	  $("#attributeCheckTr_table").show();
	 
 
} 
 

var trindex=0;
function   addRow(obj){
	var parentTr = $(obj).parent().parent(); 
	var f_tableName_tr_html=parentTr.html();
	parentTr.after($('<tr>'+f_tableName_tr_html+'</tr>'));
}
 

//删除所选的行
function deleteRow(obj){
    var parentTr = $(obj).parent().parent();
    var length=parentTr.parent().parent().find("tr").length;
    if(length>2){
		parentTr.remove();
	}else{
	    whir_alert('<s:text name="workflow.Pleasereserveatleastonerow"/>', function (){}) ; 
	}
	 	
    // whir_confirm('确定要删除？', function (){deleteRow_fun();}) ; 
}


//deleteRow 确定删除执行的函数
function  deleteRow_fun(){
	 var checkDeleteobj = $("input[type='checkbox'][name='checkDelete']"); 
	 $(checkDeleteobj).each(function(){ 
		 var len = $("#tbl_1 tr").length; 
		 if($(this).attr("checked")=="checked") //注意：此处判断不能用$(this).attr("checked")==‘true'来判断。 
		 {   
			//至少保留一行
			if(len>3){
		     $(this).parent().parent().remove();
			}else{
				whir_alert('<s:text name="workflow.Pleasereserveatleastonerow"/>',function(){});
			} 	  
		 } 
	 }); 
}

/**

*/
function  fieldRelateCheck(obj){ 
    var chanNoWrite='<s:property  value="moduleVO.chanNoWrite"/>'=='true'?'1':'0';
    var chanRemind='<s:property  value="moduleVO.chanRemind"/>'=='true'?'1':'0';
	/*var tableId=$("#accessDatabaseId").val();
	try{
       tableId=$('#accessDatabaseId').combobox('getValue');
	}catch(e){
	   tableId=$("#accessDatabaseId").val();
	}*/ 
	var tableId=Ext.getCmp("accessDatabaseId_extId").getValue();
    if(tableId==""||tableId=="-1"){
		$.dialog.alert('<s:text name="workflow.pleasechooseformfirst" />',function(){});
	    obj.checked=false;
	    $("#attributeCheckTr_table").hide();
	    $("#field_td7").html('');
	    return ;
	}
	
    if($("#fieldRelate").attr("checked")=="checked"){ 
		var url2="/defaultroot/wfprocess!fieldIframe.action";
		var para2='tableId='+tableId+'&moduleId=<%=moduleId%>&chanNoWrite='+chanNoWrite+'&chanRemind=' + chanRemind+'&remindField=<s:property value="remindField" />&wfWorkFlowProcessId='+$("#wfWorkFlowProcessId").val();
		if($("#wfWorkFlowProcessId").val()!=""){
		    para2+='&processId='+$("#wfWorkFlowProcessId").val();
		}
	   	var  result=ajaxForSync(url2,para2);
		$("#field_td7").html(result);
		$("#fieldRelateFormtable").show();
		setInputStyle();
	}else{
		$("#fieldRelateFormtable").hide();
		$("#field_td7").html('');
	}
}


 
 //全选|全除  删除属性关联
 function selectAll(obj) {
    if(obj.checked){
	   $("input[name='checkDelete']").attr("checked",true);  
    }else{
	   $("input[name='checkDelete']").attr("checked",false);  
    }

	 setInputStyle();
 }
 
  $(document).ready(function(){
	   //初始化内容
	   setTimeout("setEditerContent()",500);
  });

  /**
  
  */
  function setEditerContent(){
	  if ($("#processDescription").val()!=""){
		  document.getElementById("newedit").contentWindow.setHTML($("#processDescription").val());
	  }
  }
 //-----------------------字段关联js-----------------------------
 

 String.prototype.replaceAll  = function(s1,s2){    
    return this.replace(new RegExp(s1,"gm"),s2);    
 }   
 
 //新增一个触发字段
 function addTouch(){ 
	 //个数
	 var fieldRelateAddNum_value=$("#fieldRelateAddNum").val();
	 //序号  
	 var fieldRelateIndex_value=$("#fieldRelateIndex").val();
 

     var table1 = $('#tableTotalTable'); 
     //var lastTR = table1.find('tbody>tr:last');  
     var row = $('<tr id="totalTr"'+fieldRelateIndex_value+' align="center"></tr>'); 
	 var td0 = $('<td valign="top" >  <img style="cursor:hand" src="<%=rootPath%>/images/addarrow.gif" title="<s:text name="workflow.set_addTriggerField"/>" onclick="addTouch();" border="0" height="16" width="16"> <img style="cursor:hand" src="<%=rootPath%>/images/delarrow.gif" title="<s:text name="workflow.set_deleteTriggerField"/>" onclick="deleteTouch(this);" border="0" height="15" width="15"></td>'); 

	 var gggcotent=$("#ggg").html();
	 var gggcotent_real=gggcotent.replaceAll("XXXX",fieldRelateIndex_value);
     var td1 = $('<td class="td0" ></td>'); 
	 td1.append(gggcotent_real);
  
     //td.append($("<input type='checkbox' name='count' value='New'><b>CheckBox"+row_count+"</b>") ); 
     row.append(td1); 
	 row.append(td0); 	
     table1.append(row); 
	 fieldRelateAddNum_value=Number(fieldRelateAddNum_value)+1; 
	 fieldRelateIndex_value=Number(fieldRelateIndex_value)+1;
	 //opener.document.all.fieldRelateAddNum.value=AddNum;
     // document.all.fieldRelateAddNum.value=AddNum;
     $("#fieldRelateAddNum").val(fieldRelateAddNum_value);		
	 $("#fieldRelateIndex").val(fieldRelateIndex_value);
 }
 
  //删除触发字段
 function deleteTouch(obj){
	 var fieldRelateAddNum_value=$("#fieldRelateAddNum").val();
     if(fieldRelateAddNum_value==1){
		 whir_alert('<s:text name="workflow.Pleasereserveatleastonerow"/>',function(){});
		 return ;
	 }

	  whir_confirm('<s:text name="workflow.activitysindeleteconfirm"/>', function (){deleteTouch_fun_r(obj);}) ;  
}

function  deleteTouch_fun_r(obj){
	 var fieldRelateAddNum_value=$("#fieldRelateAddNum").val();
	 var parentTr = $(obj).parent().parent();
     parentTr.remove(); 
	 if(fieldRelateAddNum_value!=0){
	    fieldRelateAddNum_value=Number(fieldRelateAddNum_value)-1;
	 }
	 $("#fieldRelateAddNum").val(fieldRelateAddNum_value);	
}
 
//选择字段
function  chooseField(obj, type,tableIndex){ 
	var buttonName="whereButton";
	if(type=="1"){
	   buttonName="selectButton";
	} 
    var selectAllobj=document.getElementsByName(buttonName+tableIndex);
 
   //取所在table的行数
   var clickIndex=0;
   if(selectAllobj.length>0){
		 for(var i=0;i<selectAllobj.length;i++){
			  var selectObj = selectAllobj[i] ;
			  if(selectObj==obj) {
					clickIndex=i;
			 }					 
		 }		           
	 }else{		 
	   clickIndex=0;
	 } 
 
	 var tableRealNames="";
	 var tableDisNames="";  
	 var alltable=document.getElementsByName("f_tableName"+tableIndex);
	 if(alltable){
	   if(alltable.length>0){
		 for(var i=0;i<alltable.length;i++){  
			  var selectObj = alltable[i] ;
			  tableRealNames+="'"+selectObj.value+"',";
			  tableDisNames+="'"+selectObj.options[selectObj.selectedIndex].text+"',";
		  }		           
	    }
	 } 
 
     if(tableRealNames.length>0){
		 tableRealNames=tableRealNames.substring(0,tableRealNames.length-1);
		 tableDisNames=tableDisNames.substring(0,tableDisNames.length-1);
	 }
 
     var urllll="/defaultroot/wfprocess!fieldChoose.action?tableRealNames="+tableRealNames+"&tableDisNames="+tableDisNames+"&type="+type
		     +"&clickIndex="+clickIndex+"&totalIndex="+tableIndex;

 
	// openWin({url:urllll,isPost:true,ifFull:true,width:800, height:600,isScroll:'yes',isResizable:'yes',winName:'fff'});

	  popup({id:'chooseField',title: '<s:text name="workflow.set_chooseField"/>',fixed: true, left: '50%', top: '40%',
		 width:'700px',height:'500px', drag: true, resize: true,lock: true,content: "url:"+urllll}); 
    

   }


	 //字段联动 增加行
	function addEachTr(obj){
		var parentTr = $(obj).parent().parent(); 
	    var f_tableName_tr_html=parentTr.html();
		parentTr.after($('<tr>'+f_tableName_tr_html+'</tr>'));
		/*var secondRow = $(currentTrigTable).find('#refTable tr:eq(1)');
		var _html = $(secondRow).html();
		var tr = $('<tr>'+_html+'</tr>');
		$(tr).find('select[name=_refTableName_'+g_component_no+']').val('');
		$(tr).find('input[name=_refTableAlias_'+g_component_no+']').val('');
		var parentTr = $(obj).parent().parent();
		$(parentTr).after(tr);*/
	}

	//字段联动 ，删去行
	function  delEachTr(obj){
	   var parentTr = $(obj).parent().parent();
	   var input0name=parentTr.find('input').eq(0).attr('name');
	   var length=parentTr.parent().find("input[name='"+input0name+"']").length;
	  // var length=$("input[name='"+input0name+"']").length;
	   if(length>1){
		   parentTr.remove();
	   }else{
		   whir_alert('<s:text name="workflow.Pleasereserveatleastonerow"/>',function(){});
	   }
	}


	
//初始化ext combox
function  initExt(){ 
    //角色选择  角色 
	 var cb1 = Ext.create('Ext.form.field.ComboBox', {
		id : 'packageId_extId',  
        typeAhead: true,
        transform: 'packageId',
		hiddenName:'packageId',
		name: 'packageId_name',
        width: 300,
        forceSelection: false
    }); 

	//角色选择  组织
	var cb2 = new Ext.form.ComboBox({
		id : 'accessDatabaseId_extId',  
		typeAhead: true,
		triggerAction: 'all',
		transform:'accessDatabaseId',
		hiddenName:'processPO.accessDatabaseId',
		name:'accessDatabaseId_name',
		width:300,
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){
					//changeChannel(this); 
					 changeTable(this.value); 
				}
			}
		}
	});    
}
 
//-->
</SCRIPT>