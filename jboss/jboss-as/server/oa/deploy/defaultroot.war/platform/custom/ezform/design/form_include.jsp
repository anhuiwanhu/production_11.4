<style>
.Table_bottomlinetd table td {
    margin:0;
    padding:2px 0 2px 0;
}

.Table_nobttomline td{
    padding-bottom:4px;
}
.tdpad{
    padding-top:3px;
}
.x-docked{position:absolute!important;z-index:1}
</style>
<s:hidden name="formId" id="formId"/>
<s:hidden name="formType" id="formType"/>
<s:hidden name="wfModuleId" id="wfModuleId"/>
<input type="hidden" name="mainFields" id="mainFields" value="<s:property value="mainFields"/>" tableName="<s:property value="mainTable"/>"/>
<s:hidden name="subTable" id="subTable"/>
<s:hidden name="selectedSubField" id="selectedSubField"/>
<s:property value="subTable_fields" escape="false"/>
<textarea style="display:none" name="formXML" id="formXML"><s:property value="formXML" escape="false"/></textarea>

    <!--滑动标签开始-->
    <div class="Public_tag" style="border-bottom:0px;">
        <ul id="whir_tab_ul">
            <li id="li_0" class="tag_aon" whir-options="{target:'tab0'}">
                <span class="tag_center">基本信息</span>
                <span class="tag_right"></span>
            </li>
            <li id="li_1" whir-options="{target:'tab1'}">
                <span class="tag_center">表单事件</span>
                <span class="tag_right"></span>
            </li>
        </ul>
    </div>
    <!--滑动标签结束-->
    <div class="clear_fix"></div>
    <div id="tab0" class="grayline">
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline_">
            <tr>
                <td for="表单名称" width="100" class="td_lefttitle tdpad">表单名称<span class="MustFillColor">*</span>：</td>
                <td width="42%" class="tdpad">
                    <s:if test="formType == 0">
                        <s:textfield name="formName" id="formName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':50},'spechar3']" cssStyle="width:298px;" maxlength="50"/>
                    </s:if>
                    <s:else>
                        <s:textfield name="formName" id="formName" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:298px;" maxlength="50" readonly="true"/>
                    </s:else>
                </td>
                <td for="表单编号" width="100" class="td_lefttitle tdpad">表单编号<span class="MustFillColor">*</span>：</td>
                <td width="42%" class="tdpad">
                    <s:if test="formType == 0 && sysAttr != 0">
                        <s:textfield name="formCode" id="formCode" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':35},'spechar3']" cssStyle="width:298px;" maxlength="35"/>
                    </s:if>
                    <s:else>
                        <s:textfield name="formCode" id="formCode" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:298px;" maxlength="35" readonly="true"/>
                    </s:else>
                </td>
            </tr>

            <tr>
                <td for="数据表分类" class="td_lefttitle">数据表分类：</td>
                <td width="40%" class="Table_bottomlinetd tdpad">
                    <select id="model" name="model" class="xeasyui-combobox" data-options="<s:if test="formType == 1">readonly:true,</s:if>width:300,onSelect:function(record){getTable();}">
                        <option value="">--请选择--</option>
                    <s:iterator value="#request.modelList" status="status" id="model">
                        <option value="<s:property value="#request.modelList[#status.index][0]"/>" <s:if test="#request.modelList[#status.index][0] == modelId">selected</s:if>><s:property value="#request.modelList[#status.index][2]"/></option>
                    </s:iterator>
                    </select>
                </td>
                <td for="关联数据表" width="100" class="td_lefttitle">关联数据表<span class="MustFillColor">*</span>：</td>
                <td width="40%" class="Table_bottomlinetd">
                    <div id="tableCombo"></div>
                </td>
            </tr>
            <tr>
                <td for="使用范围" class="td_lefttitle" valign="top">使用范围：</td>
                <td colspan=3>
                    <s:hidden name="scopeIds" id="scopeIds"/>
                    <s:textarea name="scopeNames" id="scopeNames" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:94%;" readonly="true"></s:textarea><s:if test="formType == 0"><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'scopeIds', allowName:'scopeNames', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"></a></s:if>
                    <div><span class="MustFillColor MustFillExt">“使用范围”为空时默认所有用户。</span></div>
                </td>
            </tr>
            <tr>
                <s:if test="formType == 1">
                <td for="打印模板" class="td_lefttitle" valign="top">打印模板：</td>
                </s:if>
                <s:else>
                <td for="显示模板" class="td_lefttitle" valign="top">显示模板：</td>
                <s:if test="formType == 0">
                        <s:if test="formId!=null">
                <td colspan=3>
                    
                        <input type="checkbox" name="syncPrintForm" id="syncPrintForm" value="1">同步到打印模板
                       
                </td>
            </tr>
            <tr>
                <td class="td_lefttitle" valign="top">&nbsp;</td>
                 </s:if>
                    </s:if>
                </s:else>

                <td colspan=3 valign=top>
                    <input type="hidden" name="formContent" id="formContent"/>
                    <s:if test="formId!=null">
                    <div id="codeDIV" style="display:none"><s:property value="formContent" escape="false"/></div>
                    </s:if>
                    <SCRIPT LANGUAGE="JavaScript">
                    <!--
                        $('#formContent').val($('#codeDIV').html());
                        $('#codeDIV').html('');
                    //-->
                    </SCRIPT>
                    <table width="100%" border="0">
                        <tr>
                            <td style="width:80%" valign=top>
                                <iframe id="templateIframe" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=formContent&style=coolblue&hiddenCodeTab=0&ezform=1&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="100%" height="520"></iframe>
                            </td>
                            <td style="width:20%" id="fieldDIV" valign="top"></td>
                        </tr>
                    </table>
                </td>
            </tr>
            
            <tr class="Table_nobttomline">
                <td></td>
                <td nowrap>
                    <input type="button" class="btnButton4font" onClick="saveFormData(0,this);" value="<s:text name="comm.saveclose"/>" />
                    <s:if test="formId==null">
                        <input type="button" class="btnButton4font" onClick="saveFormData(1,this);" value="<s:text name="comm.savecontinue"/>" />
                    </s:if>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
                </td>
            </tr>
        </table>      
    </div>

    <div id="tab1" class="grayline" style="display:none">
        <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
            <tr>
                <td class="td_lefttitle" width="100" nowrap valign=top>JSP文件：</td>
                <td width="98%">
                    <input type="text" class="inputText" id="jspFileName" name="jspFileName" style="width:90%;" maxlength=40 value="<s:property value="jspFileName" escape="false"/>">
                </td>
            </tr>
             <% /* <tr>
                <td class="td_lefttitle"></td>
                <td>
                    <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                        <jsp:param name="isShowBatchDownButton"     value="no" />
                        <jsp:param name="accessType"       value="include" />
                        <jsp:param name="makeYMdir"        value="no" />
                        <jsp:param name="dir"      value="/platform/custom/ezform/ext/" />
                        <jsp:param name="uniqueId"    value="uniqueId_jspFileName" />
                        <jsp:param name="realFileNameInputId"    value="jspFileName" />
                        <jsp:param name="saveFileNameInputId"    value="jspFileName" />
                        <jsp:param name="canModify"       value="yes" />
                        <jsp:param name="width"        value="90" />
                        <jsp:param name="height"       value="20" />
                        <jsp:param name="multi"        value="false" />
                        <jsp:param name="buttonClass" value="upload_btn" />
                        <jsp:param name="buttonText"       value="上传附件" />
                        <jsp:param name="fileSizeLimit"        value="0" />
                        <jsp:param name="fileTypeExts"         value="*.jsp" />
                        <jsp:param name="uploadLimit"      value="1" />
                    </jsp:include> 
                </td>
            </tr> */%>

            <tr>
                <td class="td_lefttitle" width="100" nowrap valign=top>移动端JSP文件：</td>
                <td width="98%">
                    <input type="text" class="inputText" id="jspFileNameMobile" name="jspFileNameMobile" style="width:90%;" maxlength=40 value="<s:property value="jspFileNameMobile" escape="false"/>">
                </td>
            </tr>
             <% /* <tr>
                <td class="td_lefttitle"></td>
                <td>
                    <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                        <jsp:param name="isShowBatchDownButton"     value="no" />
                        <jsp:param name="accessType"       value="include" />
                        <jsp:param name="makeYMdir"        value="no" />
                        <jsp:param name="dir"      value="/platform/custom/ezform/ext/mobile/" />
                        <jsp:param name="uniqueId"    value="uniqueId_jspFileNameMobile" />
                        <jsp:param name="realFileNameInputId"    value="jspFileNameMobile" />
                        <jsp:param name="saveFileNameInputId"    value="jspFileNameMobile" />
                        <jsp:param name="canModify"       value="yes" />
                        <jsp:param name="width"        value="90" />
                        <jsp:param name="height"       value="20" />
                        <jsp:param name="multi"        value="false" />
                        <jsp:param name="buttonClass" value="upload_btn" />
                        <jsp:param name="buttonText"       value="上传附件" />
                        <jsp:param name="fileSizeLimit"        value="0" />
                        <jsp:param name="fileTypeExts"         value="*.jsp" />
                        <jsp:param name="uploadLimit"      value="1" />
                    </jsp:include>
                </td>
            </tr>*/%>

            <tr>
                <td class="td_lefttitle" colspan=2><label class="_MustFillColor"><b>以下填写JS方法名：</b></label></td><td></td>
            </tr>
            <tr>
                <td for="加载后触发" class="td_lefttitle" nowrap>加载后触发：</td>
                <td><input type="text" class="inputText" id="jsLoadAfterFunc" name="jsLoadAfterFunc" style="width:90%;" whir-options="vtype:['spechar3']" maxlength=40 value="<s:property value="jsLoadAfterFunc" escape="false"/>" <s:if test="formType == 1">readonly</s:if>></td>
            </tr>
            <tr>
                <td for="保存验证前触发" class="td_lefttitle" nowrap>保存验证前触发：</td>
                <td><input type="text" class="inputText" id="jsSaveVerifyBeforeFunc" name="jsSaveVerifyBeforeFunc" style="width:90%;" whir-options="vtype:['spechar3']" maxlength=40 value="<s:property value="jsSaveVerifyBeforeFunc" escape="false"/>" <s:if test="formType == 1">readonly</s:if>></td>
            </tr>
            <tr>
                <td for="保存验证后触发" class="td_lefttitle" nowrap>保存验证后触发：</td>
                <td><input type="text" class="inputText" id="jsSaveVerifyAfterFunc" name="jsSaveVerifyAfterFunc" style="width:90%;" whir-options="vtype:['spechar3']" maxlength=40 value="<s:property value="jsSaveVerifyAfterFunc" escape="false"/>" <s:if test="formType == 1">readonly</s:if>></td>
            </tr>

            <tr class="Table_nobttomline">
                <td></td>
                <td nowrap>
                    <input type="button" class="btnButton4font" onClick="saveTheFormData(0,this);" value="<s:text name="comm.saveclose"/>" />
                    <s:if test="formId==null">
                        <input type="button" class="btnButton4font" onClick="saveTheFormData(1,this);" value="<s:text name="comm.savecontinue"/>" />
                    </s:if>
                    <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
                    <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
                </td>
            </tr>
        </table>
    </div>

<%@ include file="/public/include/include_extjs.jsp"%>
<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/common.js"></script>

<SCRIPT LANGUAGE="JavaScript">
<!--
var tableStore;
Ext.onReady(function() {

    initTab('whir_tab_ul');

    var modelCombo = Ext.create('Ext.form.field.ComboBox', {
        id: 'modelId',
        typeAhead: true,
        transform: 'model',
        hiddenName: 'modelId',
        width: 300,
        forceSelection: true,
        //emptyText: '--请选择--',
        listeners: {
            select: function(combo, record, index) {
                getTable();
            }
        }
    });

    var table1 = Ext.define('table1', {
            extend: 'Ext.data.Model',
            fields: ['id', 'text']
        });
    tableStore = new Ext.data.Store({
        model: table1,
        proxy: {
            type: 'jsonp',
            callbackKey: 'callback',
            //limitParam: 'per_page',
            url: whirRootPath + '/EzForm!getTableList.action?format=jsonp&wfModuleId=<s:property value="wfModuleId"/>',
            reader: {
                type: 'json',

                // Response is an array where element [1] is the array of records
                getData: function(raw) {
                    return raw;//[1];
                }
            }
        },
        // Load whole dataset.
        // API only returns 25 by default.
        //pageSize: 1000,
        autoLoad: <s:if test='modelId != null'>false</s:if><s:else>true</s:else>
    });

    var tableCombo = Ext.create('Ext.form.field.ComboBox', {
        id:"tableId",
	    name:"tableName",
        renderTo: 'tableCombo',
        displayField: 'text',
        valueField: 'id',
        hiddenName: 'tableId',
        emptyText: '--请选择--',
        width: 300,
        store: tableStore,
        queryMode: 'local',
        forceSelection: true,
        tpl: '<ul class="x-list-plain">' +
                '<tpl for=".">' +
                    '<li class="x-boundlist-item">' +
                        '{text}' +
                    '</li>'+
                '</tpl>'+
            '</ul>',
        listeners: {
            select: function(combo, record, index) {
                getTableField();
            }
        }
    });

    <s:if test="formId==null">
    var arr = new Array();
    arr[0] = {
        title: '主表字段',
        html: ''
    };
    initTableFieldTab(arr);
    </s:if>
    <s:else>

    var modelId = whirExtCombobox.getValue('modelId');

    whirExtCombobox.clearValue('tableId');

    tableStore.load({params:{modelId:modelId}});

    whirExtCombobox.setValue('tableId', '<s:property value="tableId"/>');

    loadField(true);

    //$("#syncPrintForm").uniform();

    </s:else>
});
//-->
</SCRIPT>