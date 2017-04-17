<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--
    <s:if test="classType=='public'">
        <title>联系人-公共联系人分类-查看页面</title>
    </s:if>
    <s:else>
        <title>联系人-个人联系人分类-查看页面</title>
    </s:else>
-->
    <s:if test="classType=='public'">
        <title><s:text name="personalwork.view" /><s:text name="pubcontact.category" /></title>
    </s:if>
    <s:else>
        <title><s:text name="personalwork.view" /><s:text name="pubcontact.personcategory" /></title>
    </s:else>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->
    <script src="<%=rootPath%>/modules/personal/linkman/personal_personClass_js.js" type="text/javascript"></script>
    <script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" type="text/javascript"></script>
</head>

<body class="Pupwin">
    <div class="BodyMargin_10">  
        <div class="docBoxNoPanel">
            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                <!-- Main Part Start -->
                <tr>
                    <td class="td_lefttitle">
                        <s:text name="pubcontact.categoryname"/><span class="MustFillColor">*</span>：
                    </td>
                    <td>
                        <s:textfield name="personPO.className" id="className" cssClass="inputText" disabled="true" /> 
                    </td>
                </tr>
                <tr>
                    <td class="td_lefttitle">  
                        <s:text name="pubcontact.Category"/>：  
                    </td>  
                    <td >  
                        <s:hidden id="classParentIdOld" value="%{personPO.classParentId}" /> 
                        <select name="personPO.classParentId" id="classParentId" class="easyui-combobox" style="width:300px;" data-options="  selectOnFocus:true,onSelect: function(record){loadClassSiblingList(record);}">
                            <s:iterator var="obj" value="#request.classParentList" >
                                <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
                            </s:iterator>
                        </select>
                    </td>  
                </tr>
                <tr>  
                    <td class="td_lefttitle">  
                        <s:text name="pubcontact.Sort"/>：  
                    </td>  
                    <td>  
                        <s:hidden id="formInsertReferIdOld" value="%{formInsertReferId}" /> 
                        <select name="formInsertReferId" id="formInsertReferId" class="easyui-combobox" style="width:300px;" data-options="selectOnFocus:true, valueField:'id', textField:'text'">
                            <s:iterator var="obj" value="#request.classSiblingList" >
                                <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
                            </s:iterator>
                        </select>&nbsp;&nbsp;
                        <s:hidden id="formInsertSiteOld" value="%{formInsertSite}" />  
                        <s:radio name="formInsertSite" id="formInsertSite" list="%{#{'0':getText('pubcontact.Forward'),'1':getText('pubcontact.Afterward')}}" theme="simple" disabled="true" ></s:radio>
                    </td>  
                </tr>
                <tr>
                    <td class="td_lefttitle">
                        <s:text name="pubcontact.description"/>：
                    </td>
                    <td>
                        <s:textarea name="personPO.classDescribe" id="classDescribe" cssClass="inputTextarea" cssStyle="width:98%" rows="4" disabled="true" ></s:textarea>
                    </td>
                </tr>
                <!-- Main Part End   -->
                <tr class="Table_nobttomline"> 
                    <td>&nbsp;</td>
                    <td colspan="2" nowrap>
                        <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
                    </td>  
                </tr>  
            </table>  
        </div>
    </div>
</body>

<script type="text/javascript">
$(document).ready(function(){
    if(initViewForm()){
    }
});

function initViewForm(){
    if(initModiForm()){
        $('#classParentId').combobox('disable');
        $('#formInsertReferId').combobox('disable');
        return true;
    }
    return false;
}
</script>

</html>
