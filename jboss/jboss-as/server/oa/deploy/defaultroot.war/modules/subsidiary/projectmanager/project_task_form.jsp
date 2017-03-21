
<%
    java.util.Map taskProgressMap = new java.util.LinkedHashMap();
    for(int i = 0; i <= 20; i++) {
        taskProgressMap.put(i*5 + "", i*5 + "%");
    }
    request.setAttribute("taskProgressMap", taskProgressMap);
%>
<s:set name="isReadOnly" value="'false'"/>
<s:if test="%{#readType == 2}"> 
    <s:set name="isReadOnly" value="'true'"/> 
</s:if>
<s:hidden name="taskPO.taskId" id="taskId"/>
<s:hidden name="projectId" id="projectId" value="%{projectId}"/>
<s:hidden name="sortCode" id="sortCode" value="%{taskPO.tasksortcode}"/>

<!-- "项目"属性 -->
<s:hidden id="projectStartDate" value="%{#request.projectStartDate}" />
<s:hidden id="projectEndDate" value="%{#request.projectEndDate}" />

<!-- "添加子任务"时，带入的ID -->
<s:hidden id="initTaskId" value="%{#parameters.initTaskId[0]}" />

<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
    <tr>  
        <td for="任务名称" class="td_lefttitle" width="12%" nowrap>任务名称<span class="MustFillColor">*</span>：</td>  
        <td colspan="3" width="88%" nowrap>  
            <s:textfield name="taskPO.taskTitle" id="taskTitle" whir-options="vtype:['notempty', {'maxLength':20}, 'spechar3']" cssClass="inputText" cssStyle="width:94%;" readonly="%{#isReadOnly}"/>  
        </td>  
    </tr>
    <tr>    
        <td for="所属任务" class="td_lefttitle" width="12%" nowrap>所属任务：</td>    
        <td width="38%" nowrap>
            <s:if test="taskId != null">
                <s:hidden id="tmp_parentId" value="%{taskPO.taskParentId}" />  
            </s:if>
			<s:if test="%{#readType != 2}">
			<select name="taskPO.taskParentId" id="parentId" class="easyui-combobox" style="width:290px;" data-options="selectOnFocus:true,onSelect: function(record){onSelect_taskParent(record);}, editable:false">
                <s:iterator var="obj" value="#request.parentList" >
                    <option value="<s:property value='#obj[0]'/>" start="<s:date name='#obj[5]' format='yyyy-MM-dd' />" end="<s:date name='#obj[6]' format='yyyy-MM-dd' />"><s:property value='#obj[1]' escape="false"/></option>
                </s:iterator>
            </select>		 
			</s:if> 
            <s:else>
			<select name="taskPO.taskParentId" id="parentId" class="easyui-combobox" style="width:290px;" data-options="selectOnFocus:true,onSelect: function(record){onSelect_taskParent(record);}, editable:false" disabled="disabled">
                <s:iterator var="obj" value="#request.parentList" >
                    <option value="<s:property value='#obj[0]'/>" start="<s:date name='#obj[5]' format='yyyy-MM-dd' />" end="<s:date name='#obj[6]' format='yyyy-MM-dd' />"><s:property value='#obj[1]' escape="false"/></option>
                </s:iterator>
            </select>			 		
			</s:else>
			           
        </td>
        <td for="任务类型" class="td_lefttitle" width="12%" nowrap>任务类型：</td>    
        <td width="38%" nowrap>    
            <s:select name="taskPO.taskType" id="taskType" list="%{#request.taskTypeMap}" cssClass="selectlist" cssStyle="width:87%" headerKey="其它" headerValue="其它" whir-options="vtype:['notempty']" disabled="%{#isReadOnly}"/>
        </td>
    </tr>
    <tr>    
        <td for="排序" class="td_lefttitle" nowrap>排序：</td>    
        <td> 
            <s:if test="taskId!=null">
                <s:hidden id="tmp_formInsertReferId" value="%{formInsertReferId}" />  
                <s:hidden id="tmp_formInsertSite" value="%{formInsertSite}" />  
                <s:hidden name="formOrderCodeFlag" id="formOrderCodeFlag" value="0" />  
            </s:if>
			<s:if test="%{#readType != 2}">
			<select name="formInsertReferId" id="formInsertReferId" class="easyui-combobox" style="width:290px;" data-options="valueField:'id', textField:'text', editable:false">
                <s:iterator var="obj" value="#request.siblingList" >
                    <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
                </s:iterator>
            </select>
			</s:if> 
            <s:else>
			<select name="formInsertReferId" id="formInsertReferId" class="easyui-combobox" style="width:290px;" data-options="valueField:'id', textField:'text', editable:false" disabled="disabled">
                <s:iterator var="obj" value="#request.siblingList" >
                    <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
                </s:iterator>
            </select>		 		
			</s:else>
            
            <s:radio name="formInsertSite" id="formInsertSite" list="%{#{'0':'前','1':'后'}}" theme="simple" disabled="%{#isReadOnly}"/>    
        </td>
        <td for="前驱任务" class="td_lefttitle" nowrap>前驱任务：</td>    
        <td>    
            <s:select name="taskPO.preTaskId" id="preTaskId" list="%{#request.preTaskMap}" cssClass="selectlist" cssStyle="width:87%;" headerKey="-1" headerValue="--请选择--" disabled="%{#isReadOnly}"/>
        </td>
    </tr>
    <tr>    
        <td for="负责人" class="td_lefttitle"  nowrap>负责人<span class="MustFillColor">*</span>：</td>    
        <td nowrap>  
            <s:hidden name="taskPO.taskPrincipals" id="taskPrincipals"/>
            <s:textfield name="taskPO.taskPrincipalNames" id="taskPrincipalNames" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':1000}]" cssStyle="width:90%;" readonly="true"/><s:if test="%{#readType != 2}"><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'taskPrincipals', allowName:'taskPrincipalNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a></s:if>  
        </td>
        <td for="考核人" class="td_lefttitle" width="12%"　nowrap>考核人<span class="MustFillColor">*</span>：</td>    
        <td nowrap>    
            <s:hidden name="taskPO.taskChecks" id="taskChecks"/>
            <s:textfield name="taskPO.taskCheckNames" id="taskCheckNames" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':1000}]" cssStyle="width:87%;" readonly="true"/><s:if test="%{#readType != 2}"><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'taskChecks', allowName:'taskCheckNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a></s:if>  
        </td>     
    </tr>
    <tr>  
        <td for="参与人" class="td_lefttitle" nowrap>  
            参与人：   
        </td>  
        <td colspan="3" nowrap> 
            <s:hidden id="joinPersonIds" name="taskPO.joinPersonIds"/>
            <s:textfield name="taskPO.joinPersonNames" id="joinPersonNames" cssClass="inputText" whir-options="vtype:[{'maxLength':1000}]" cssStyle="width:94%;" readonly="true"/><s:if test="%{#readType != 2}"><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'joinPersonIds', allowName:'joinPersonNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a></s:if>
        </td>  
    </tr>
    <tr>    
        <td for="开始日期" class="td_lefttitle" nowrap>开始日期<span class="MustFillColor">*</span>：</td>    
        <td>  
            <s:if test="%{#readType != 2}"> 
            <s:textfield name="taskPO.taskBeginTime" id="taskBeginTime" cssClass="Wdate whir_datebox" onFocus="WdatePicker({onpicked:calcDuration(),dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'%{#request.projectStartDate}',maxDate:'#F{$dp.$D(\\'taskEndTime\\',{d:0}) || \\'%{#request.projectEndDate}\\'}',isShowClear:false})" whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.taskBeginTime" format="yyyy-MM-dd" /></s:param> 
            </s:textfield>
            </s:if> 
            <s:else>
            <s:textfield name="taskPO.taskBeginTime" id="taskBeginTime" cssClass="Wdate whir_datebox"  whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.taskBeginTime" format="yyyy-MM-dd" /></s:param> 
            </s:textfield>
            </s:else>
                               至             
            <s:if test="%{#readType != 2}">
            <s:textfield name="taskPO.taskEndTime" id="taskEndTime" cssClass="Wdate whir_datebox" onFocus="WdatePicker({onpicked:calcDuration(),dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'taskBeginTime\\',{d:0}) || \\'%{#request.projectStartDate}\\'}',maxDate:'%{#request.projectEndDate}',isShowClear:false})" whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.taskEndTime" format="yyyy-MM-dd" /></s:param>
            </s:textfield>  
            </s:if> 
            <s:else>
            <s:textfield name="taskPO.taskEndTime" id="taskEndTime" cssClass="Wdate whir_datebox" whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.taskEndTime" format="yyyy-MM-dd" /></s:param>
            </s:textfield>  
            </s:else>
            
        </td>     
        <s:if test="%{#readType != 0}">
        <td for="实际开始日期" class="td_lefttitle" nowrap>实际开始日期<span class="MustFillColor">*</span>：</td>    
        <td>
            <s:if test="%{#readType != 2}">   
            <s:textfield name="taskPO.ReaLBeginTime" id="ReaLBeginTime" cssClass="Wdate whir_datebox" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'ReaLReaLEndTime\\',{d:0})}',isShowClear:false})" whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.ReaLBeginTime" format="yyyy-MM-dd" /></s:param> 
            </s:textfield>
            </s:if> 
            <s:else> 
            <s:textfield name="taskPO.ReaLBeginTime" id="ReaLBeginTime" cssClass="Wdate whir_datebox"  readonly="true">
                <s:param name="value"><s:date name="taskPO.ReaLBeginTime" format="yyyy-MM-dd" /></s:param> 
            </s:textfield>
            </s:else>
            至 
            <s:if test="%{#readType != 2}">   
            <s:textfield name="taskPO.ReaLReaLEndTime" id="ReaLReaLEndTime" cssClass="Wdate whir_datebox" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'ReaLBeginTime\\',{d:0})}',isShowClear:false})" whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.ReaLReaLEndTime" format="yyyy-MM-dd" /></s:param>
            </s:textfield> 
             </s:if> 
            <s:else> 
            <s:textfield name="taskPO.ReaLReaLEndTime" id="ReaLReaLEndTime" cssClass="Wdate whir_datebox" whir-options="vtype:['notempty']" readonly="true">
                <s:param name="value"><s:date name="taskPO.ReaLReaLEndTime" format="yyyy-MM-dd" /></s:param>
            </s:textfield> 
            </s:else> 
        </td>     
        </s:if>
        <s:else>
            <td class="td_lefttitle">&nbsp;</td><td>&nbsp;</td>
        </s:else>
    </tr>
    <tr>    
        <td for="工期" class="td_lefttitle"　nowrap>工期：</td>    
        <td>    
            <s:textfield name="taskPO.tasktimelimit" id="tasktimelimit" whir-options="vtype:[{'maxLength':20}]" cssClass="inputText" cssStyle="width:90%;" readonly="true"/>  
        </td>
        <td for="工作流程" class="td_lefttitle" nowrap>工作流程：</td>    
        <td>    
            <s:select name="taskPO.flowId" id="flowId" list="%{#request.workflowMap}" cssClass="selectlist" cssStyle="width:87%;" headerKey="" headerValue="请选择" disabled="%{#isReadOnly}"/>
        </td>
    </tr>
    <tr>    
        <td for="任务预算" class="td_lefttitle"　nowrap>任务预算（元）：</td>    
        <td colspan="3">
             <s:if test="%{#readType != 2}"> 
           <s:textfield name="taskPO.taskBudget" id="taskBudget" whir-options="vtype:[{'maxLength':8},'p_decimal_e']" cssClass="inputText" cssStyle="width:94%;" />  
            </s:if> 
            <s:else>
             <s:textfield name="taskPO.taskBudget" id="taskBudget" whir-options="vtype:[{'maxLength':8},'p_decimal_e']" cssClass="inputText" cssStyle="width:94%;" readonly="true"/>  
            </s:else>           
        </td>
    </tr>
    <tr>    
        <td for="提醒方式" class="td_lefttitle" nowrap>提醒方式：</td>    
        
         <s:if test="%{#readType != 2}">   
           <td>
            <jsp:include page="/public/im/remind.jsp" flush="true">
                <jsp:param name="modeType" value="im|sms|mail" />
                <jsp:param name="smsModelName" value="项目任务" />
                <jsp:param name="defaultSelected" value="mail" />                
            </jsp:include>
           </td>     
         </s:if> 
         <s:else> 
            <td>
            <jsp:include page="/public/im/remind.jsp" flush="true">
                <jsp:param name="modeType" value="im|sms|mail" />
                <jsp:param name="smsModelName" value="项目任务" />
                <jsp:param name="defaultSelected" value="mail" />
                <jsp:param name="disabled" value="im|sms|mail" /> 
            </jsp:include>
           </td>     
         </s:else> 
                
        <td for="里程碑" class="td_lefttitle"  nowrap>里程碑：</td>    
        <td nowrap> 
            <s:checkbox name="taskPO.islandmark" id="islandmark" fieldValue="1" disabled="%{#isReadOnly}"/>  
        </td>   
    </tr>
    <tr>  
        <td for="附件" class="td_lefttitle">  
            附件：   
        </td>  
        <s:if test="%{#readType != 2}">   
           <td colspan="3">  
            <s:hidden name="realFileName" id="realFileName" value="%{#request.realFileName}"/>  
            <s:hidden name="saveFileName" id="saveFileName" value="%{#request.saveFileName}"/>  
            <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="accessType"       value="include" />
                   <jsp:param name="dir"      value="taskCenter" />  
                   <jsp:param name="uniqueId"    value="uniqueId11" />  
                   <jsp:param name="realFileNameInputId"    value="realFileName" />
                   <jsp:param name="saveFileNameInputId"    value="saveFileName" />
                   <jsp:param name="canModify"       value="yes" />
            </jsp:include>  
        </td>  
             </s:if> 
            <s:else> 
            <td colspan="3">  
            <s:hidden name="realFileName" id="realFileName" value="%{#request.realFileName}"/>  
            <s:hidden name="saveFileName" id="saveFileName" value="%{#request.saveFileName}"/>  
            <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="accessType"       value="include" />
                   <jsp:param name="dir"      value="taskCenter" />  
                   <jsp:param name="uniqueId"    value="uniqueId11" />  
                   <jsp:param name="realFileNameInputId"    value="realFileName" />
                   <jsp:param name="saveFileNameInputId"    value="saveFileName" />
                   <jsp:param name="canModify"       value="no" />
            </jsp:include>  
        </td>  
            </s:else> 
        
    </tr>
    <tr>  
        <td for="任务内容" class="td_lefttitle" nowrap>  
            任务内容：   
        </td>  
        <td colspan="3" nowrap>  
            <s:textarea name="taskPO.taskDescription" id="taskDescription" rows="3" cssClass="inputTextarea" whir-options="vtype:[{'maxLength':2000}]" cssStyle="width:94%;" readonly="%{#isReadOnly}"/> 
        </td>  
    </tr>
    <tr>
        <td colspan="4" style="padding-left:10px;padding-right:6px">
            <!-- 相关性 -->
            <s:if test="%{#readType == 0}">
                <input name="moduleType" type="hidden" value="task">
                <div id=relationObjectDIV></div>
                <IFRAME name=relationIFrame id=relationIFrame src='<%=rootPath%>/relation!relationIncludeList.action?moduleType=task&infoId=&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationadd=1' frameborder=0 marginwidth='0' marginheight='0' scrolling='auto' width='95%' height='150' style=display:''></IFRAME>
            </s:if>
            <s:elseif test="%{#readType == 2}">
                <input name="moduleType" type="hidden" value="task">
                <input name="infoId" type="hidden" value="<s:property value="taskPO.taskId"/>">
                <div id='relationObjectDIV'></div>
                <IFRAME name='relationIFrame' id='relationIFrame' src='<%=rootPath%>/relation!relationIncludeList.action?moduleType=task&infoId=<s:property value="taskPO.taskId"/>&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationview=1' frameborder=0 marginwidth='0' marginheight='0' scrolling='auto' width='95%' height='150' style=display:''></IFRAME>
            </s:elseif>
            <s:else>
                <input name="moduleType" type="hidden" value="task">
                <input name="infoId" type="hidden" value="<s:property value="taskPO.taskId"/>">
                <div id='relationObjectDIV'></div>
                <IFRAME name='relationIFrame' id='relationIFrame' src='<%=rootPath%>/relation!relationIncludeList.action?moduleType=task&infoId=<s:property value="taskPO.taskId"/>&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationview=0' frameborder=0 marginwidth='0' marginheight='0' scrolling='auto' width='95%' height='150' style=display:''></IFRAME>
            </s:else>
        </td>
    </tr>
    <s:if test="%{#readType == 1}">
    <tr>
        <td colspan="4" style="padding-left:10px;padding-right:6px">
            <!-- 任务汇报 -->
            <iframe id="reportIframe" name="reportIframe" width="95%" frameborder="0" src="projectTask!projectTaskReport.action?isView=0&taskId=<s:property value="%{taskPO.taskId}"/>" scrolling="no"></iframe>     
        </td>
    </tr>
    <tr>
        <td>
            相关日志：
        </td>
        <td colspan="3">
        <%
            com.whir.ezoffice.workmanager.worklog.bd.WorkLogBD workLogBD = new com.whir.ezoffice.workmanager.worklog.bd.WorkLogBD();
            String taskId = request.getParameter("taskId")==null?"":request.getParameter("taskId");
            String logNum = workLogBD.getWorkLogNum(taskId);
        %>
            (<a href="javascript:void(0);" onclick="linkToWorkLogList(<%=taskId%>);"><%=logNum%></a>)
        </td>
    </tr>
    </s:if>
    
   <s:if test="%{#readType == 2}">
    
    <tr>
        <td colspan="4" style="padding-left:10px;padding-right:6px">
            <!-- 任务汇报 -->
            <iframe id="reportIframe" name="reportIframe" width="95%" frameborder="0" src="projectTask!projectTaskReport.action?isView=1&taskId=<s:property value="%{taskPO.taskId}"/>" scrolling="no"></iframe>     
        </td>
    </tr>
    <tr>
        <td>
            相关日志：
        </td>
        <td colspan="3">
        <%
            com.whir.ezoffice.workmanager.worklog.bd.WorkLogBD workLogBD = new com.whir.ezoffice.workmanager.worklog.bd.WorkLogBD();
            String taskId = request.getParameter("taskId")==null?"":request.getParameter("taskId");
            String logNum = workLogBD.getWorkLogNum(taskId);
        %>
            (<a href="javascript:void(0);" onclick="linkToWorkLogList(<%=taskId%>);"><%=logNum%></a>)
        </td>
    </tr>
    
    </s:if>
    <tr class="Table_nobttomline">  
         <td class="td_lefttitle"></td> 
        <td colspan="3" nowrap>
        <s:if test="%{#readType != 2}">  
            <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(0,this);}" value="<s:text name="comm.saveclose"/>" />
            <s:if test="%{#readType == 0}">  
                <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(1,this);}" value="<s:text name="comm.savecontinue"/>" />
            </s:if>
            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
        </s:if>
            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
        </td>
    </tr> 
</table>