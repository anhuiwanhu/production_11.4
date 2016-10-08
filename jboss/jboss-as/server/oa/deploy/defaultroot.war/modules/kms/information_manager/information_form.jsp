<s:if test="informationId == null">
<s:hidden id="channelType" name="channelType" />
<s:hidden id="userDefine" name="userDefine" />
<s:hidden id="userChannelName" name="userChannelName" />
<s:hidden id="informationStatus" name="information.informationStatus" value="0"/>
<s:hidden id="informationIsCommend" name="information.informationIsCommend" value="0"/>
<s:hidden id="informationKits" name="information.informationKits" value="0"/>
<s:hidden id="informationVersion" name="information.informationVersion" value="1.00"/>
<s:hidden id="informationCommonNum" name="information.informationCommonNum" value="0"/>
<s:hidden id="orderCode" name="information.orderCode" value="1000"/>
<s:hidden id="dossierStatus" name="information.dossierStatus" value="0"/>
<s:hidden id="informationHead" name="information.informationHead" value="0"/>
<s:hidden id="mustRead" name="information.mustRead" value="0"/>
<s:hidden id="isConf" name="information.isConf" value="0"/>
<s:hidden id="fromGOVDocument" name="information.fromGOVDocument" value="%{#request.govId}"/>
<s:hidden id="fromGOV" name="information.fromGOV" value="%{#request.module}"/>
<s:hidden id="wfModuleId" name="information.wfModuleId" value="%{#request.moduleId}"/>
</s:if>
<s:else>
<s:hidden id="informationId" name="information.informationId"/>
<s:hidden id="channelType" name="channelType" />
<s:hidden id="userDefine" name="userDefine" />
<s:hidden id="userChannelName" name="userChannelName" />
<s:hidden id="informationIssuerId" name="information.informationIssuerId"/>
<s:hidden id="informationIssuer" name="information.informationIssuer"/>
<s:hidden id="informationIssueOrgId" name="information.informationIssueOrgId"/>
<s:hidden id="informationIssueOrg" name="information.informationIssueOrg"/>
<s:hidden id="informationStatus" name="information.informationStatus"/>
<s:hidden id="informationIsCommend" name="information.informationIsCommend"/>
<s:hidden id="informationKits" name="information.informationKits"/>
<s:hidden id="informationVersion" name="information.informationVersion"/>
<s:hidden id="informationCommonNum" name="information.informationCommonNum"/>
<s:hidden id="orderCode" name="information.orderCode"/>
<s:hidden id="dossierStatus" name="information.dossierStatus"/>
<s:hidden id="informationHead" name="information.informationHead"/>
<s:hidden id="mustRead" name="information.mustRead"/>
<s:hidden id="isConf" name="information.isConf"/>
<s:hidden id="fromGOVDocument" name="information.fromGOVDocument" />
<s:hidden id="fromGOV" name="information.fromGOV"/>
<s:hidden id="channel" name="channel" value="%{#request.channel}"/>
<s:hidden id="other" name="other" value="%{#request.other}"/>
<s:hidden id="wfModuleId" name="information.wfModuleId"/>
</s:else>
<s:hidden id="relationNew" name="relationNew" value="%{#request.relationNew}"/>
<s:hidden id="modifyToProcess" name="modifyToProcess" value="%{#request.modifyToProcess}"/>
<%
String _isyiboflag=request.getParameter("_isyiboflag")==null?"0":request.getParameter("_isyiboflag").toString();
if(!_isyiboflag.equals("1")){
	_isyiboflag=request.getParameter("isyiboflag")==null?"0":request.getParameter("isyiboflag").toString();
}
%>
<input type="hidden" id="isyiboflag" name="isyiboflag" value="<%=_isyiboflag%>"/>
<div id="docinfo0" style="display:;">
	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
		<tr>  
			<td for="<s:text name='info.viewcolumn'/>" width="8%" class="td_lefttitle" nowrap>  
				<s:text name="info.viewcolumn"/><span class="MustFillColor">*</span>：  
			</td>  
			<td colspan="2">  
			<s:if test="(#request.curModifyField==null || #request.curModifyField.indexOf('$information.canIssueChannel$') > -1) || #request.p_wf_openType!='restart'">
				<select id="selectChannels" name="selectChannels" class="" style="width:804px;" data-options="forceSelection:true,panelHeight:'150',onSelect: function(record){changeChannel(record.value);}">
			</s:if>
			<s:else>
				<select id="selectChannels" name="selectChannels" class="" style="width:804px;" data-options="forceSelection:true,panelHeight:'150'" >
			</s:else>	
				</select>
			</td>
		</tr>
		
		<tr>
			<td for="<s:text name='info.searchareatitle'/>" width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.searchareatitle"/><span class="MustFillColor">*</span>：
			</td>
			<td nowrap>
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationTitle$') > -1">
				<s:textfield name="information.informationTitle" id="informationTitle" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':150}]" cssStyle="width:76%;" />
				<span id="info_add_1">
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.displayTitle$') > -1">
					<s:checkboxlist name="information.displayTitle" list="#{'1':getText('info.newinfodetailnotdisplay')}"/>
				</s:if>
				<s:else>
					<s:checkboxlist name="information.displayTitle" list="#{'1':getText('info.newinfodetailnotdisplay')}" disabled="true"/>
					<s:hidden id="displayTitle" name="information.displayTitle"/>
				</s:else>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.displayColor$') > -1">
					<s:checkboxlist name="information.titleColor" list="#{'1':getText('info.newinforeddisplay')}"/>
				</s:if>
				<s:else>
					<s:checkboxlist name="information.titleColor" list="#{'1':getText('info.newinforeddisplay')}" disabled="true"/>
					<s:hidden id="titleColor" name="information.titleColor"/>
				</s:else>
				</span>
			</s:if>
			<s:else>
				<s:textfield name="information.informationTitle" id="informationTitle" cssClass="inputText" readonly="true" whir-options="vtype:['notempty',{'maxLength':150}]" cssStyle="width:76%;" />
				<span id="info_add_1">
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.displayTitle$') > -1">
					<s:checkboxlist name="information.displayTitle" list="#{'1':getText('info.newinfodetailnotdisplay')}"/>
				</s:if>
				<s:else>
					<s:checkboxlist name="information.displayTitle" list="#{'1':getText('info.newinfodetailnotdisplay')}" disabled="true"/>
					<s:hidden id="displayTitle" name="information.displayTitle"/>
				</s:else>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.displayColor$') > -1">
					<s:checkboxlist name="information.titleColor" list="#{'1':getText('info.newinforeddisplay')}"/>
				</s:if>
				<s:else>
					<s:checkboxlist name="information.titleColor" list="#{'1':getText('info.newinforeddisplay')}" disabled="true"/>
					<s:hidden id="titleColor" name="information.titleColor"/>
				</s:else>
				</span>
			</s:else>
			</td>  
		</tr>

		<s:if test="informationId == null">
		<tr id="temp">  
			<td width="8%" class="td_lefttitle" nowrap>  
				<s:text name="info.newinfotemplate"/>：  
			</td>  
			<td>  
				<select id="templates" name="templates" class="" style="width:804px;" data-options="forceSelection:true,panelHeight:'150',onSelect: function(record){changeTemplate(record.value);}">
					<option value="0"><s:text name="info.nonusetem"/></option>
					<%
					List templateList = (List)request.getAttribute("templateList");
					for(int i=0;i<templateList.size();i++){
						Object[] obj = (Object[])templateList.get(i);
					%>
						<option value="<%=obj[0]%>"><%=obj[1]%></option>
					<%}%>
				</select>  
			</td>  
		</tr>
		</s:if>
		
		<s:if test="informationId == null">
		<tr id="info_add_tr1">
			<td width="8%" class="td_lefttitle" nowrap> 
				<s:text name="info.editMode" />：
			</td>
			<td id="">
			<%
			boolean wordEidt = com.whir.org.common.util.SysSetupReader.getInstance().hasWordEdit(session.getAttribute("domainId").toString());
            boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);//true-是 false-否
            //String isyibo_flag = request.getAttribute("isYiBoChannel")!=null?request.getAttribute("isYiBoChannel").toString():"";
            %>
			<%
			if(wordEidt && !isCOSClient){%>
				<s:radio name="information.informationType" list="%{#{'1':getText('info.newinfohtml'),'0':getText('info.newinfocommon'),'2':getText('info.newinfoaddlink'),'3':getText('info.newinfofilelink'),'4':getText('info.newinfowordedit'),'5':getText('info.newinfoexceledit'),'6':getText('info.pptedite')}}" value="1" theme="simple"></s:radio>
			<%}else{%>
				<s:radio name="information.informationType" list="%{#{'1':getText('info.newinfohtml'),'0':getText('info.newinfocommon'),'2':getText('info.newinfoaddlink'),'3':getText('info.newinfofilelink')}}" value="1" theme="simple"></s:radio>
			<%}%>
			</td>
		</tr>
		
		</s:if>
		<s:else>
			<s:hidden name="information.informationType" id="informationType"/>
		</s:else>

		<tr id="selectImg">
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.relatedpicture" />：
			</td>
			<td>
				<%
				String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
				String picupload = Resource.getValue(local,"information","info.picupload");
				String attupload = Resource.getValue(local,"information","info.attupload");
				String newinfofileupload = Resource.getValue(local,"information","info.newinfofileupload");
				%>
				<div style="float:left;display:inline;">
				<s:hidden name="infoPicName" id="infoPicName" value="%{#request.infoPicName}"/>
				<s:hidden name="infoPicSaveName" id="infoPicSaveName" value="%{#request.infoPicSaveName}"/>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.accessory$') > -1">
				<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
				   <jsp:param name="dir" value="information" />
				   <jsp:param name="uniqueId" value="uploadImg" />
				   <jsp:param name="realFileNameInputId" value="infoPicName" />
				   <jsp:param name="saveFileNameInputId" value="infoPicSaveName" />
				   <jsp:param name="canModify" value="yes" />
				   <jsp:param name="width" value="90" />
				   <jsp:param name="height" value="20" />
				   <jsp:param name="multi" value="true" />
				   <jsp:param name="buttonClass" value="upload_btn" />
				   <jsp:param name="buttonText" value="<%=picupload%>" />
				   <jsp:param name="fileSizeLimit" value="0" />
				   <jsp:param name="fileTypeExts" value="*.jpg;*.jpeg;*.gif;*.png;" />
				   <jsp:param name="uploadLimit" value="0" />
				</jsp:include>
				</s:if>
				<s:else>
				<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
				   <jsp:param name="dir" value="information" />
				   <jsp:param name="uniqueId" value="uploadImg" />
				   <jsp:param name="realFileNameInputId" value="infoPicName" />
				   <jsp:param name="saveFileNameInputId" value="infoPicSaveName" />
				   <jsp:param name="canModify" value="no" />
				   <jsp:param name="width" value="90" />
				   <jsp:param name="height" value="20" />
				   <jsp:param name="multi" value="true" />
				   <jsp:param name="buttonClass" value="upload_btn" />
				   <jsp:param name="buttonText" value="<%=picupload%>" />
				   <jsp:param name="fileSizeLimit" value="0" />
				   <jsp:param name="fileTypeExts" value="*.jpg;*.jpeg;*.gif;*.png;" />
				   <jsp:param name="uploadLimit" value="0" />
				</jsp:include>
				</s:else>
				</div>
				<div style="float:left;display:inline;padding-left:10px;">
				<span id="info_add_2">
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.displayColor$') > -1">
					<s:checkboxlist name="information.displayImage" list="#{'1':getText('info.newinfodetailnotdisplay')}"/>
				</s:if>
				<s:else>
					<s:checkboxlist name="information.displayImage" list="#{'1':getText('info.newinfodetailnotdisplay')}" disabled="true"/>
					<s:hidden id="displayImage" name="information.displayImage" disabled="true"/>
				</s:else>
				</span>
				</div>
			</td>
		</tr>
		
		<tr id="selectAppend">
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.relatedatt" />：
			</td>
			<td>
				<s:hidden name="infoAppendName" id="infoAppendName" value="%{#request.infoAppendName}"/>
				<s:hidden name="infoAppendSaveName" id="infoAppendSaveName" value="%{#request.infoAppendSaveName}"/>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.accessory$') > -1">
				<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
				   <jsp:param name="dir" value="information" />
				   <jsp:param name="uniqueId" value="uploadAppend" />
				   <jsp:param name="realFileNameInputId" value="infoAppendName" />
				   <jsp:param name="saveFileNameInputId" value="infoAppendSaveName" />
				   <jsp:param name="canModify" value="yes" />
				   <jsp:param name="width" value="90" />
				   <jsp:param name="height" value="20" />
				   <jsp:param name="multi" value="true" />
				   <jsp:param name="buttonClass" value="upload_btn" />
				   <jsp:param name="buttonText" value="<%=attupload%>" />
				   <jsp:param name="fileSizeLimit" value="0" />
				   <jsp:param name="uploadLimit" value="0" />
				</jsp:include>
				</s:if>
				<s:else>
				<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
				   <jsp:param name="dir" value="information" />
				   <jsp:param name="uniqueId" value="uploadAppend" />
				   <jsp:param name="realFileNameInputId" value="infoAppendName" />
				   <jsp:param name="saveFileNameInputId" value="infoAppendSaveName" />
				   <jsp:param name="canModify" value="no" />
				   <jsp:param name="width" value="90" />
				   <jsp:param name="height" value="20" />
				   <jsp:param name="multi" value="true" />
				   <jsp:param name="buttonClass" value="upload_btn" />
				   <jsp:param name="buttonText" value="<%=attupload%>" />
				   <jsp:param name="fileSizeLimit" value="0" />
				   <jsp:param name="uploadLimit" value="0" />
				</jsp:include>
				</s:else>
			</td>
		</tr>
		
		<tr id="txt" style="display:none" >
			<td colspan="2" valign="top">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
				<s:textarea id="textContent" name="textContent" rows="15" cssClass="inputTextarea" cssStyle="width:99%;height:350px;" value="%{#request.textContent}"/>
			</s:if>
			<s:else>
				<s:textarea id="textContent" name="textContent" rows="15" cssClass="inputTextarea" cssStyle="width:99%;height:350px;" value="%{#request.textContent}" readonly="true"/>
			</s:else>
			</td>
		</tr>
		
		<tr id="edit">
			<td colspan="2">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
				<s:hidden name="information.informationContent" id="informationContent"/>
				<iframe id="newedit" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=information.informationContent&style=coolblue&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>" frameborder="0" scrolling="no" width="100%" height="350"></iframe>
			</s:if>
			<s:else>
				<s:hidden name="information.informationContent" id="informationContent"/>
				<iframe id="newedit" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=information.informationContent&style=coolblue&lang=<%=session.getAttribute("org.apache.struts.action.LOCALE")%>&readonly=1" frameborder="0" scrolling="no" width="100%" height="350"></iframe>
			</s:else>
			</td>
		</tr>
		
		<input type="hidden" id="content" name="content" value="<%=request.getAttribute("content")!=null?request.getAttribute("content").toString():""%>">
		<tr id="word" style="display:none">
		    <td>&nbsp;</td>
			<td  valign="top">
				<table width="100%">
					<tr>
						<td width="25%">
						<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
							<input type="button" class="btnButton4font" value="<s:text name='info.newinfobodyedit'/>" onClick="wordEdit('1');" />
							<span class="MustFillColor">*</span>
						</s:if>
						<s:else>
							<input type="button" class="btnButton4font" value="<s:text name='info.watchcontent'/>" onClick="wordEdit('0');" />
							<span class="MustFillColor">*</span>
						</s:else>
						</td>
						<td width="10%">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr id="excel" style="display:none">
			<td>&nbsp;</td>
			<td  valign="top">
				<table width="100%">
					<tr>
						<td width="25%">
						<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
							<input type="button" class="btnButton4font" value="<s:text name='info.newinfobodyedit'/>" onClick="excelEdit('1');" />
							<span class="MustFillColor">*</span>
						</s:if>
						<s:else>
							<input type="button" class="btnButton4font" value="<s:text name='info.watchcontent'/>" onClick="excelEdit('0');" />
							<span class="MustFillColor">*</span>
						</s:else>
						</td>
						<td width="10%">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr id="ppt" style="display:none">
			<td>&nbsp;</td>
			<td  valign="top">
				<table width="100%">
					<tr>
						<td width="25%">
						<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
							<input type="button" class="btnButton4font" value="<s:text name='info.newinfobodyedit'/>" onClick="pptEdit('1');" />
							<span class="MustFillColor">*</span>
						</s:if>
						<s:else>
							<input type="button" class="btnButton4font" value="<s:text name='info.newinfobodyedit'/>" onClick="pptEdit('0');" />
							<span class="MustFillColor">*</span>
						</s:else>
						</td>
						<td width="10%">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		
		<tr id="url" style="display:none">
			<td id="urlcolumn"><s:text name="info.newinfoaddlink" /><span class="MustFillColor">*</span>：</td>
			<td>
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
				<s:textfield id="URLContent" name="URLContent" cssClass="inputText" cssStyle="width:76%" value="%{#request.urlContent}"/>
			</s:if>
			<s:else>
				<s:textfield id="URLContent" name="URLContent" cssClass="inputText" cssStyle="width:76%" value="%{#request.urlContent}" readonly="true"/>
			</s:else>
			</td>
		</tr>
		<tr id="file" <s:if test="information.informationType==3">style="display:;"</s:if><s:else>style="display:none;"</s:else>>
			<td id="filecolumn"><s:text name="info.newinfofilelink" /><span class="MustFillColor">*</span>：</td>
			<td>
				<div style="float:left;display:inline;width:76%">
				<s:textfield id="fileLinkContent" name="fileLinkContent" value="%{#request.fileLinkContent}" cssClass="inputText" cssStyle="width:100%" readonly="true"/>
				<s:hidden id="fileLinkContentHidd" name="fileLinkContentHidd" value="%{#request.fileLinkContentHidd}"/>
				</div>
				<div style="padding-left:0px;padding-top:32px;">
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationContent$') > -1">
				<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
				   <jsp:param name="dir" value="information" />
				   <jsp:param name="uniqueId" value="uploadFile" />
				   <jsp:param name="realFileNameInputId" value="fileLinkContent" />
				   <jsp:param name="saveFileNameInputId" value="fileLinkContentHidd" />
				   <jsp:param name="canModify" value="yes" />
				   <jsp:param name="width" value="90" />
				   <jsp:param name="height" value="20" />
				   <jsp:param name="multi" value="false" />
				   <jsp:param name="buttonClass" value="upload_btn" />
				   <jsp:param name="buttonText" value="<%=newinfofileupload%>" />
				   <jsp:param name="fileSizeLimit" value="0" />
				   <jsp:param name="uploadLimit" value="1" />
				</jsp:include>
				</s:if>
				<s:else>
				<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
				   <jsp:param name="dir" value="information" />
				   <jsp:param name="uniqueId" value="uploadFile" />
				   <jsp:param name="realFileNameInputId" value="fileLinkContent" />
				   <jsp:param name="saveFileNameInputId" value="fileLinkContentHidd" />
				   <jsp:param name="canModify" value="no" />
				   <jsp:param name="width" value="90" />
				   <jsp:param name="height" value="20" />
				   <jsp:param name="multi" value="false" />
				   <jsp:param name="buttonClass" value="upload_btn" />
				   <jsp:param name="buttonText" value="<%=newinfofileupload%>" />
				   <jsp:param name="fileSizeLimit" value="0" />
				   <jsp:param name="uploadLimit" value="1" />
				</jsp:include>
				</s:else>
				</div>
			</td>
		</tr>
		
		<s:if test="#request.action=='add' || #request.action=='load'">
		<tr>
			<td width="7%" class="td_lefttitle" nowrap>&nbsp;</td>
			<td nowrap>
				<input type="button" name="saveclose" class="btnButton4font" onClick="save(0,this);" value="<s:text name='comm.saveclose'/>" />
				<s:if test="informationId==null || informationId==''">
				<input type="button" class="btnButton4font" onClick="save(1,this);" value="<s:text name='comm.savecontinue'/>" />
				</s:if>
				<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name='comm.reset'/>" />
				<input type="button" name="exit" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name='comm.exit'/>" />
			</td>
		</tr>
		</s:if>
	</table>
	<input type="hidden"  name="xxxxxx"  value="<%=request.getAttribute("p_wf_recordId")==null?"0":request.getAttribute("p_wf_recordId")+"1"%>">
	<s:if test="#request.p_wf_recordId != null && #request.p_wf_openType != 'restart'">
	<div>
		<%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
	</div>
	</s:if>
</div>

<div id="docinfo1" style="display:none;">
	<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
		<tr>  
			<td width="8%" class="td_lefttitle" nowrap><s:text name="info.newinfosecondtitle"/>：</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationSubTitle$') > -1">
				<s:textfield name="information.informationSubTitle" id="informationSubTitle" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':50}]"/>  
			</s:if>
			<s:else>
				<s:textfield name="information.informationSubTitle" id="informationSubTitle" cssClass="inputText" cssStyle="width:93%;" readonly="true"/>
			</s:else>
			</td>
			<td width="8%" class="td_lefttitle" nowrap><s:text name="info.newinfoarticleno"/>：</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.documentNo$') > -1">
				<s:textfield name="information.documentNo" id="documentNo" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':50}]"/>
			</s:if>
			<s:else>
				<s:textfield name="information.documentNo" id="documentNo" cssClass="inputText" cssStyle="width:93%;" readonly="true"/>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap><s:text name="info.newinfosamepub"/>：</td>
			<td width="42%">
				<select id="otherChannels" name="otherChannels" class="" style="width:435px;" data-options="forceSelection:true,panelHeight:'150'" >
				</select>
			</td>
			<td width="8%" class="td_lefttitle" nowrap><s:text name="info.searchareakey"/>：</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationKey$') > -1">
				<s:textfield name="information.informationKey" id="informationKey" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':50}]"/>
			</s:if>
			<s:else>
				<s:textfield name="information.informationKey" id="informationKey" cssClass="inputText" cssStyle="width:93%;" readonly="true"/>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap><s:text name="info.viewauthor"/>：</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationAuthor$') > -1">
				<s:textfield name="information.informationAuthor" id="informationAuthor" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':30}]"/> 
			</s:if>
			<s:else>
				<s:textfield name="information.informationAuthor" id="informationAuthor" cssClass="inputText" cssStyle="width:93%;" readonly="true"/>
			</s:else>
			</td>  
			<td width="8%" class="td_lefttitle" nowrap><s:text name="info.authorstatauthordep"/>：</td>
			<td width="42%">  
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.documentEditor$') > -1">
				<s:textfield name="information.documentEditor" id="documentEditor" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':50}]"/>
			</s:if>
			<s:else>
				<s:textfield name="information.documentEditor" id="documentEditor" cssClass="inputText" cssStyle="width:93%;" readonly="true"/>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.viewcontenttype"/>：
			</td>
			<td width="42%">
			<s:if test="informationId == null">
				<s:radio name="information.documentType" list="%{#{'0':getText('info.authorstatcompose'),'1':getText('info.authorstatedit'),'2':getText('info.authorstatexcerpt')}}" value="0" theme="simple"></s:radio> 
			</s:if>
			<s:else>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.documentType$') > -1">
					<s:radio name="information.documentType" list="%{#{'0':getText('info.authorstatcompose'),'1':getText('info.authorstatedit'),'2':getText('info.authorstatexcerpt')}}" theme="simple"></s:radio>
				</s:if>
				<s:else>
					<s:radio name="information.documentType" list="%{#{'0':getText('info.authorstatcompose'),'1':getText('info.authorstatedit'),'2':getText('info.authorstatexcerpt')}}" theme="simple" disabled="true"></s:radio>
					<s:hidden id="documentType" name="information.documentType"/>
				</s:else>
			</s:else>
			</td>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.newinfosource"/>：
			</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.comeFrom$') > -1">
				<s:textfield name="information.comeFrom" id="comeFrom" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':100}]"/>  
			</s:if>
			<s:else>
				<s:textfield name="information.comeFrom" id="comeFrom" cssClass="inputText" cssStyle="width:93%;" readonly="true"/>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.newinfocanview"/>：
			</td>
			<td width="42%" nowrap>
				<s:hidden id="informationReader" name="information.informationReader"/>
				<s:hidden id="informationReaderOrg" name="information.informationReaderOrg"/>
				<s:hidden id="informationReaderGroup" name="information.informationReaderGroup"/>
				<s:hidden id="informationReaderId" name="informationReaderId" value="%{#request.informationReaderId}"/>
				<s:hidden id="informationReaderId_" name="informationReaderId_"/>
				<s:textarea name="information.informationReaderName" id="informationReaderName" rows="3" cssClass="inputTextarea" cssStyle="width:93%;" readonly="true"/><s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationReaderName$') > -1"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectReader();"></a>
				</s:if>
			</td>
			<td width="8%" class="td_lefttitle" for="<s:text name='info.newinfoabstract'/>" nowrap>
				<s:text name="info.newinfoabstract"/>：
			</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationSummary$') > -1">
				<s:textarea name="information.informationSummary" id="informationSummary" maxlength="1000" rows="3" cssClass="inputTextarea" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':1000}]"/> 
			</s:if>
			<s:else>
				<s:textarea name="information.informationSummary" id="informationSummary" maxlength="1000" rows="3" cssClass="inputTextarea" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':1000}]" readonly="true"/>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.printright"/>：
			</td>
			<td width="42%" nowrap>
				<s:hidden id="informationPrinter" name="information.informationPrinter"/>
				<s:hidden id="informationPrinterOrg" name="information.informationPrinterOrg"/>
				<s:hidden id="informationPrinterGroup" name="information.informationPrinterGroup"/>
				<s:hidden id="informationPrinterId" name="informationPrinterId" value="%{#request.informationPrinterId}"/>
				<s:hidden id="informationPrinterId_" name="informationPrinterId_" value="%{#request.informationPrinterId_}"/>
				<s:textarea name="information.informationPrinterName" id="informationPrinterName" rows="3" cssClass="inputTextarea" cssStyle="width:93%;" readonly="true"/><s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationPrinterName$') > -1"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectPrinter();"></a></s:if>
			</td>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.downloadright"/>：
			</td>
			<td width="42%" nowrap>
				<s:hidden id="informationDownLoader" name="information.informationDownLoader"/>
				<s:hidden id="informationDownLoaderOrg" name="information.informationDownLoaderOrg"/>
				<s:hidden id="informationDownLoaderGroup" name="information.informationDownLoaderGroup"/>
				<s:hidden id="informationDownLoaderId" name="informationDownLoaderId" value="%{#request.informationDownLoaderId}"/>
				<s:hidden id="informationDownLoaderId_" name="informationDownLoaderId_" value="%{#request.informationDownLoaderId_}"/>
				<s:textarea name="information.informationDownLoaderName" id="informationDownLoaderName" rows="3" cssClass="inputTextarea" cssStyle="width:93%;" readonly="true"/><s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationDownLoaderName$') > -1"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="selectDownLoader();"></a></s:if>
			</td>
		</tr>

		<tr>
			<td width="8%" class="td_lefttitle" for="<s:text name='info.printnum'/>" nowrap><s:text name="info.printnum"/>：</td>
			<td width="42%">
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.printNum$') > -1">
					<s:textfield name="information.printNum" id="printNum" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':5},'p_integer_e']"/> 
				</s:if>
				<s:else>
					<s:textfield name="information.printNum" id="printNum" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':5},'p_integer_e']" readonly="true"/> 
				</s:else>
			</td>  
			<td width="8%" class="td_lefttitle" for="<s:text name='info.downloadnum'/>" nowrap><s:text name="info.downloadnum"/>：</td>
			<td width="42%">  
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.downLoadNum$') > -1">
					<s:textfield name="information.downLoadNum" id="downLoadNum" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':5},'p_integer_e']"/>
				</s:if>
				<s:else>
					<s:textfield name="information.downLoadNum" id="downLoadNum" cssClass="inputText" cssStyle="width:93%;" whir-options="vtype:[{'maxLength':5},'p_integer_e']" readonly="true"/> 
				</s:else>
			</td>
		</tr>

		<tr>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.newinfoprintcopy"/>：
			</td>
			<td width="42%">
			<s:if test="informationId == null">
				<s:radio name="information.forbidCopy" list="%{#{'1':getText('info.yes'),'0':getText('info.no')}}" value="0" theme="simple"></s:radio>
			</s:if>
			<s:else>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.forbidCopy$') > -1">
					<s:radio name="information.forbidCopy" list="%{#{'1':getText('info.yes'),'0':getText('info.no')}}" theme="simple"></s:radio>
				</s:if>
				<s:else>
					<s:radio name="information.forbidCopy" list="%{#{'1':getText('info.yes'),'0':getText('info.no')}}" theme="simple" disabled="true"></s:radio>
					<s:hidden id="forbidCopy" name="information.forbidCopy"/>
				</s:else>
			</s:else>
			</td>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.searchareapubdate"/>：
			</td>
			<td width="42%">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationIssueTime$') > -1">
				<s:textfield name="information.informationIssueTime" id="informationIssueTime" cssClass="Wdate whir_datetimeboxlong" onFocus="WdatePicker({el:'informationIssueTime',dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})"> 
				<s:param name="value"><s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></s:param></s:textfield>
			</s:if>
			<s:else>
				<s:textfield name="information.informationIssueTime" id="informationIssueTime" cssStyle="width:150px;" cssClass="inputText" readonly="true">
				<s:param name="value"><s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/></s:param></s:textfield>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name="info.AllowComments"/>：
			</td>
			<td width="42%">
			<s:if test="informationId == null">
				<s:radio name="information.informationCanRemark" list="%{#{'1':getText('info.yes'),'0':getText('info.no')}}" value="1" theme="simple"></s:radio> 
			</s:if>
			<s:else>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationCanRemark$') > -1">
					<s:radio name="information.informationCanRemark" list="%{#{'1':getText('info.yes'),'0':getText('info.no')}}" theme="simple"></s:radio> 
				</s:if>
				<s:else>
					<s:radio name="information.informationCanRemark" list="%{#{'1':getText('info.yes'),'0':getText('info.no')}}" theme="simple" disabled="true"></s:radio>
					<s:hidden id="informationCanRemark" name="information.informationCanRemark"/>
				</s:else>
			</s:else>
			</td>
			<td width="8%" class="td_lefttitle" nowrap>  
				<s:text name="info.newinfovalidity"/>：  
			</td>  
			<td nowrap>  
			<s:if test="informationId == null">
				<s:radio name="information.informationValidType" list="%{#{'1':getText('info.newinfotemporarily'),'0':getText('info.newinfoforever')}}" value="0" theme="simple"></s:radio>
			</s:if>
			<s:else>
				<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationValidType$') > -1">
					<s:radio name="information.informationValidType" list="%{#{'1':getText('info.newinfotemporarily'),'0':getText('info.newinfoforever')}}" theme="simple"></s:radio>
				</s:if>
				<s:else>
					<s:radio name="information.informationValidType" list="%{#{'1':getText('info.newinfotemporarily'),'0':getText('info.newinfoforever')}}" theme="simple" disabled="true"></s:radio>
					<s:hidden id="informationValidType" name="information.informationValidType"/>
				</s:else>
			</s:else>
			</td>
		</tr>

		<%String options=com.whir.org.common.util.SysSetupReader.getInstance().getSystemOption(session.getAttribute("domainId").toString());%>
		<tr >
			<td width="8%" class="td_lefttitle" nowrap style="<%if(options.charAt(6)!='1') out.print("display:none");%>">
				<s:text name="info.newinfotowebsite"/>：
			</td>
			<td width="42%" style="<%if(options.charAt(6)!='1') out.print("display:none");%>"><div id="outSiteSynDiv"></div></td>
				<s:if test="informationId == null">
					<s:hidden id="transmitToEzsite" name="information.transmitToEzsite" value="0"/>
				</s:if>
				<s:else>
					<s:hidden id="transmitToEzsite" name="information.transmitToEzsite" />
				</s:else>
			<td <%if(options.charAt(6)!='1') out.print("width='58%' colspan='3'"); else out.print("width='8%'");%>>&nbsp;</td>
			
			<td width="42%" id="validTime" style="display:none" valign="top">
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.vaildBeginTime$') > -1">
				<s:textfield name="information.validBeginTime" id="validBeginTime" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})">
				<s:param name="value"><s:date name="information.validBeginTime" format="yyyy-MM-dd"/></s:param>
                </s:textfield>
			</s:if>
			<s:else>
				<s:textfield name="information.validBeginTime" id="validBeginTime" cssStyle="width:150px;" cssClass="inputText" readonly="true">
				<s:param name="value"><s:date name="information.validBeginTime" format="yyyy-MM-dd"/></s:param>
				</s:textfield>
			</s:else>
			&nbsp;<s:text name="info.to"/>&nbsp;
			<s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.vaildEndTime$') > -1">
				<s:textfield name="information.validEndTime" id="validEndTime" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'validBeginTime\\')}'})">
				<s:param name="value"><s:date name="information.validEndTime" format="yyyy-MM-dd"/></s:param>
                </s:textfield>
			</s:if>
			<s:else>
				<s:textfield name="information.validEndTime" id="validEndTime" cssStyle="width:150px;" cssClass="inputText" readonly="true">
				<s:param name="value"><s:date name="information.validEndTime" format="yyyy-MM-dd"/></s:param></s:textfield>
			</s:else>
			</td>
		</tr>
		
		<tr>
			<td width="8%" class="td_lefttitle" nowrap>
				<s:text name='info.InformationPush' />：
			</td>
			<td width="42%">
				<s:textarea name="information.informationMailSendName" id="informationMailSendName" rows="3" cssClass="inputTextarea" cssStyle="width:93%;" readonly="true"/><s:if test="#request.curModifyField==null || #request.curModifyField.indexOf('$information.informationMailSendName$') > -1"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'informationMailSendId', allowName:'informationMailSendName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});"></a>
				</s:if>
				<s:hidden name="information.informationMailSendUserId"/>
				<s:hidden name="information.informationMailSendOrg"/>
				<s:hidden name="information.informationMailSendGroup"/>
				<s:hidden id="informationMailSendId" name="information.informationMailSendId"/>
				<br>
				<%String remindType = request.getAttribute("remindType")!=null?request.getAttribute("remindType").toString():"";%>
				<jsp:include page="/public/im/remind.jsp" flush="true">  
					<jsp:param name="modeType" value="im|sms|mail" />  
					<jsp:param name="smsModelName" value="信息管理" />  
					<jsp:param name="defaultSelected" value="<%=remindType%>" />  
					<jsp:param name="disabled" value="" />  
				</jsp:include>
			</td>  
			<td colspan='2'>&nbsp;</td>
		</tr>
		<s:if test="#request.relationNew!=1">
		<tr id="relationId">
			<td colspan="4">&nbsp;<input name="moduleType" type="hidden" value="information"><input name="infoId" type="hidden" value="<s:property value='information.informationId'/>">
				<div id='relationObjectDIV'></div>
				<IFRAME name='relationIFrame' id='relationIFrame' src='' frameborder='0' marginwidth='0' marginheight='0' scrolling='auto' width='99%' height='150' style="display:''"></IFRAME>
			</td>
		</tr>
		</s:if>
		<s:if test="#request.action=='add' || #request.action=='load'">
		<tr>  
			<td width="8%" class="td_lefttitle" nowrap>&nbsp;</td>
			<td colspan="3" nowrap>
				<input type="button" name="saveclose" class="btnButton4font" onClick="save(0,this);" value="<s:text name='comm.saveclose'/>" />
				<s:if test="informationId==null || informationId==''">
				<input type="button" class="btnButton4font" onClick="save(1,this);" value="<s:text name='comm.savecontinue'/>" />
				</s:if>
				<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name='comm.reset'/>" />
				<input type="button" name="exit" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name='comm.exit'/>" />
			</td>  
		</tr>
		</s:if>
	</table>
</div>
<%@ include file="/public/include/include_extjs.jsp"%>