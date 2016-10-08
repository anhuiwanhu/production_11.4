<%@ page import="com.whir.component.config.ConfigXMLReader" %>
<%
String managerScope = (String)request.getAttribute("managerScope");
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
String orgId = request.getParameter("orgId")==null?"":request.getParameter("orgId").toString();
String orgName = request.getAttribute("orgName")==null?"":request.getAttribute("orgName").toString();
String pastOrgId = request.getAttribute("pastOrgId")==null?"":request.getAttribute("pastOrgId").toString();
String type = request.getParameter("type")==null?"":request.getParameter("type").toString();
int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String path = smartInUse == 1 ? rootPath : fileServer;

ConfigXMLReader reader = new ConfigXMLReader();
String keyAuthType = reader.getAttribute("KeyAuth", "type");
boolean isepass = "epass".equals(keyAuthType)?true:false;
if(isepass==false){
%>
<div style="display:none"><OBJECT ID="IkeyCheckClient" CLASSID="CLSID:0C9D30AB-1840-463F-BD45-E4BB5AAD4342" codebase="<%=rootPath%>/public/ikey/ikChkClient.dll#version=1,0,0,5" width=0 height=0 hspace=0 vspace=0></OBJECT></div>
<script language="javascript">
var haveClient = false;
try{haveClient = document.getElementById("IkeyCheckClient").CheckClient();}catch(e){}
if(haveClient==true){
    document.write("<OBJECT ID='iKeyClient' CLASSID='clsid:2669C745-AF54-4B50-B97C-7683123FEBA2' codebase='<%=rootPath%>/public/ikey/iKeyClient.dll#version=1,0,0,6' events='true' width=0 height=0 hspace=0 vspace=0></OBJECT>");
}
</script>
<SCRIPT FOR=iKeyClient EVENT=Insert language="javascript">
OnInsert();
</script>
<SCRIPT FOR=iKeyClient EVENT=Remove language="javascript">
OnRemove();
</script>
<%}%>
<!--link rel="stylesheet" type="text/css" href="<%=rootPath%>/scripts/plugins/extjs/3.3.1/resources/css/ext-all.css"/>
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/extjs/3.3.1/adapter/ext/ext-base.js"></script>
<script type="text/javascript" src="<%=rootPath%>/scripts/plugins/extjs/3.3.1/ext-all.js"></script-->

<link rel="stylesheet" type="text/css" href="<%=rootPath%>/platform/system/system_manager/systemmanager_user.css"/>
<!--[if IE 6]>
<style type="text/css">
.imgPhoto{margin-top:-20px;}
</style>
<![endif]-->
<style>
.sysSaveBtn{background: url(<%=rootPath%>/themes/common/images/inbtnbg_disabled.jpg) repeat-x left bottom #f2f2f2;}

#ext-comp-1002{ position:static;}
</style>
<div class="whir_mainbox">
<s:hidden name="action" id="action" />
<s:hidden name="status" id="status" />
<s:hidden name="saveOperateType" id="saveOperateType" />
<s:hidden name="tansUse" id="tansUse" />
<s:hidden name="sysManagerFlag" id="sysManagerFlag" />
<s:hidden name="empId" id="empId" />
<s:hidden name="dogMaxUserNum" id="dogMaxUserNum" />
<s:hidden name="currentUserNum" id="currentUserNum" />
<s:hidden name="userRoleId" id="userRoleId" />
<s:hidden name="rightIds" id="rightIds" />
<s:hidden name="rightScopeTypes" id="rightScopeTypes" />
<s:hidden name="rightScopeScopes" id="rightScopeScopes" />
<s:hidden name="rightScopeDsps" id="rightScopeDsps" />
    <!--滑动标签开始-->
    <div class="Public_tag">
        <ul id="whir_tab_ul">
            <li class="tag_aon" whir-options="{target:'tab0'}" id="base" onclick="confirmSave(this)"><span class="tag_center">基本信息</span><span class="tag_right"></span>

            </li>
            <li whir-options="{target:'tab1'}" id="rights" onclick="confirmSave(this)"><span class="tag_center">角色权限</span><span class="tag_right"></span>

            </li>
            <s:if test="empId!=null && status != 'apply'">
            <li whir-options="{target:'tab2', operate:'iframe', url:'<%=rootPath%>/InfoStat!rightList.action?dealUserId=<s:property value="empId"/>&dealOrgId=<s:property value="orgIds"/>', dest:'tab2_iframe'}" id="inforights" onclick="changeInfoRights(this)">
                <span class="tag_center">信息栏目权限</span>
                <span class="tag_right"></span>
            </li>
            </s:if>
        </ul>
    </div>
    <!--滑动标签结束-->
    <div class="clear_fix"></div>
    <div id="tab0" class="grayline">

<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
    <tr>
        <td for="账号" width="100" class="td_lefttitle">账&nbsp;&nbsp;&nbsp;&nbsp;号<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="userPO.userAccounts" id="userAccounts" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:92%;" maxlength="20" onblur="accountAllow();" autocomplete="off"/>
        
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><div id="userAccountAllow"></div>请输入a-z小写英文字母、0~9数字或下划线、汉字，不可输入空格，账号长度应在2~20个字符之间。</td>
    </tr>
    <tr>
        <td for="密码" class="td_lefttitle">密&nbsp;&nbsp;&nbsp;&nbsp;码<span class="MustFillColor">*</span>：</td>
        <td>
        <s:if test="empId==null">
            <s:password name="userPO.userPassword" id="userPassword" cssClass="inputText" cssStyle="width:92%;" maxlength="20" whir-options="vtype:['notempty']" autocomplete="off"/>
        </s:if>
        <s:else>
            <s:password name="userPO.userPassword" id="userPassword" cssClass="inputText" cssStyle="width:92%;" maxlength="20"/>
        </s:else>        
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td>
            <input type="checkbox" name="userPO.isPasswordRule" id="isPasswordRule" value="1" <s:if test="userPO.isPasswordRule == 1">checked</s:if> onclick="javascript:changePasswordRule();"/>启用密码规则
            <div id="passwordRule_TR" style="display:<s:if test="userPO.isPasswordRule != 1">none</s:if>">密码规则：数字+字母+特殊字符（大于等于7位），要求每三个月至少更新一次，且两年内不能和以前的密码重复。系统提前两周提醒。如果没有修改，则每次登录时都会提示剩余天数。如果到期仍不修改，则系统自动休眠此用户。</div>
        </td>
    </tr>

    <tr>
        <td for="密码确认" class="td_lefttitle">密码确认<span class="MustFillColor">*</span>：</td>
        <td>
        <s:if test="empId==null">
            <s:password name="confirmPassword" id="confirmPassword" cssClass="inputText" cssStyle="width:92%;" maxlength="20" whir-options="vtype:['notempty']"/>
        </s:if>
        <s:else>
            <s:password name="confirmPassword" id="confirmPassword" cssClass="inputText" cssStyle="width:92%;" maxlength="20"/>
        </s:else>  
        </td>
    </tr>
    <tr>
        <td for="中文名" class="td_lefttitle">中&nbsp;文&nbsp;名<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="userPO.empName" id="empName" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:92%;" maxlength="30"/>
        </td>
    </tr>
    <tr>
        <td for="用户简码" class="td_lefttitle">用户简码<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="userPO.userSimpleName" id="userSimpleName" cssClass="inputText" whir-options="vtype:['notempty','spechar3']" cssStyle="width:92%;" maxlength="20"/>
        </td>
    </tr>
    <tr>
        <td for="英文名" class="td_lefttitle">英&nbsp;文&nbsp;名：</td>
        <td><s:textfield name="userPO.empEnglishName" id="empEnglishName" cssClass="inputText" cssStyle="width:92%;" whir-options="vtype:['spechar3']" maxlength="50"/>
        </td>
    </tr>
    <tr <s:if test="tansUse != 1">style="display:none"</s:if>>
        <td for="身份证号" class="td_lefttitle">身份证号<span class="MustFillColor">*</span>：</td>
        <td>
            <s:if test="tansUse != 1">
                <s:textfield name="userPO.empIdCard" id="empIdCard" cssClass="inputText" cssStyle="width:92%;" maxlength="18" />
            </s:if>
            <s:else>
                <s:textfield name="userPO.empIdCard" id="empIdCard" cssClass="inputText" whir-options="vtype:['notempty','idcard']" cssStyle="width:92%;" maxlength="18" />
            </s:else>
        </td>
    </tr>
	
    <tr>
        <td for="员工编号" class="td_lefttitle">员工编号：</td>
        <td>
            <s:textfield name="userPO.empNumber" id="empNumber" cssClass="inputText" whir-options="vtype:[{'maxLength':10},'spechar3']" cssStyle="width:92%;"  />
        </td>
    </tr>
    <tr>
        <td for="办公地点" class="td_lefttitle">办公地点：</td>
        <td>
            <s:hidden name="userPO.workAddress" id="workAddress" />
            <%
                String addressName = request.getAttribute("addressName")!=null?request.getAttribute("addressName").toString():"";
            %>
            <input type="text" id="workAddressName" value="<%=addressName%>" class="inputText" readonly="readonly" style="width:92%;"/><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onClick="javascript:selectWorkAddress();" ></a>
        </td>
    </tr>

    <tr>
        <td for="性别" class="td_lefttitle">性&nbsp;&nbsp;&nbsp;&nbsp;别：</td>
        <td><s:radio id="empSex" name="userPO.empSex" list="#{'0':'男','1':'女','-1':'空'}"></s:radio>
        </td>
    </tr>
    <tr style="display:none">
        <td for="外发邮件" class="td_lefttitle">外发邮件：</td>
        <td><s:radio id="canSendMail" name="userPO.canSendMail" list="#{'0':'禁止','1':'允许'}"></s:radio>
        </td>
    </tr>
    <tr>
        <td for="认证方式" class="td_lefttitle">认证方式：</td>
        <td>
            <input type="checkbox" name="userPO.keyValidate" <s:if test="userPO.keyValidate == 1">checked</s:if> id="keyValidate" value="1" onClick="javascript:initKey();"/>令牌认证
            <s:hidden name="userPO.keySerial" id="keySerial"/>
            <span id="isAdCheckSpan" <s:if test="showAdCheck == false">style="display:none"</s:if>>
            &nbsp;<input type="checkbox" name="isAdCheckbox" <s:if test="userPO.isAdCheck == 1">checked</s:if> id="isAdCheckbox" value="1" />Windows域认证
            <s:hidden name="userPO.isAdCheck" id="isAdCheck"/>
            </span>
        </td>
    </tr>
    <tr>
        <td for="特权" class="td_lefttitle">特&nbsp;&nbsp;&nbsp;&nbsp;权：</td>
        <td>
            <input onclick="javascript:showDate();" type="checkbox" name="userPO.userIsSuper" <s:if test="userPO.userIsSuper == 1">checked</s:if> id="userIsSuper" value="1" />
            <span id="showDate" <s:if test="userPO.userIsSuper != 1">style="display:none"</s:if>>从：<input type="text" class="Wdate whir_datebox" name="userPO.userSuperBegin" id="userSuperBegin" onfocus="WdatePicker({el:'userSuperBegin',maxDate:'#F{$dp.$D(\'userSuperEnd\')}'})" value="<s:date name="userPO.userSuperBegin" format="yyyy-MM-dd" />"/>到：<input type="text" class="Wdate whir_datebox" name="userPO.userSuperEnd" id="userSuperEnd" onfocus="WdatePicker({el:'userSuperEnd',minDate:'#F{$dp.$D(\'userSuperBegin\')}'})" value="<s:date name="userPO.userSuperEnd" format="yyyy-MM-dd" />"/></span>
        </td>
    </tr>
    <tr>
        <td for="移动办公" class="td_lefttitle">移动办公：</td>
        <td>
            <input onclick="checkMobile(this)" type="checkbox" name="userPO.mobileUserFlag" <s:if test="userPO.mobileUserFlag == 1">checked</s:if> id="mobileUserFlag" value="1">APP&nbsp;&nbsp;</input>
            <span id="mobileSpan" <s:if test="userPO.mobileUserFlag != 1">style="display:none"</s:if>>
                <s:radio id="securitypolicy" name="userPO.securitypolicy" list="#{'0':'低安全策略','1':'高安全策略'}"></s:radio>&nbsp;<img src="images/helpuser.gif" width=14 height=16 title="安全策略目前仅对于Android、iPhone手机版有效，如果对该用户设置的是“高安全策略”，则首次登录时系统记录该用户登录时使用的手机设备ID、手机号码等但不允许其登录，直到该设备ID开通，由系统管理员通过用户管理列表中“绑定”操作为该用户的该手机设备ID开通访问权限，授权该用户使用已绑定的手机能够访问移动办公系统。"/>&nbsp;&nbsp;
            </span>
            <input  onclick="checkEnterprisenumber(this)" type="checkbox" name="userPO.enterprisenumber" <s:if test="userPO.enterprisenumber == 1">checked</s:if> id="enterprisenumber" value="1">企业号</input>
        </td>
        
           
           
       
    </tr>
    <tr <s:if test="userPO.mobileUserFlag != 1&&userPO.enterprisenumber != 1">style="display:none"</s:if> id="empMobilePhoneTR">
        <td for="手机号" class="td_lefttitle">手机号：</td>
        <td>
            <s:textfield name="userPO.empMobilePhone" id="empMobilePhone" cssClass="inputText" whir-options="vtype:['mobile',{'maxLength':11}]" cssStyle="width:20%;"  />
        </td>
    </tr>
    <tr>
        <td for="排序" class="td_lefttitle">排&nbsp;&nbsp;&nbsp;&nbsp;序：</td>
        <td><s:textfield name="userPO.userOrderCode" id="userOrderCode" cssClass="inputText" whir-options="vtype:['digit',{'maxLength':10}]" cssStyle="width:80px;" maxlength="10"/>
        </td>
    </tr>
    <tr>
        <td for="职务" class="td_lefttitle">职&nbsp;&nbsp;&nbsp;&nbsp;务：</td>
        <td>
            <select id="empDuty" name="empDuty" class="xeasyui-combobox" data-options="forceSelection:true,width:300">
                <option value="">--请选择--</option>
                <s:iterator value="#request.listDuty" status="status" id="duty">
                <option value="<s:property value="#request.listDuty[#status.index][1]"/>" 
	                <s:if test="#request.listDuty[#status.index][1] == userPO.empDuty">selected</s:if>
	                <s:elseif test="empId==null && #status.last">selected</s:elseif>>
	                <s:property value="#request.listDuty[#status.index][1]"/>
                </option>
                </s:iterator>
            </select>
        </td>
    </tr>

    <tr>
        <td for="所属组织" class="td_lefttitle">所属组织<span class="MustFillColor">*</span>：</td>
         <td>
          <s:hidden name="orgIds" id="orgIds"/>
			<input type="hidden" name="pastOrgId" id="pastOrgId" value="<%=pastOrgId%>"/>
			<input type="hidden" id="_orgId" value="<%=orgId%>"/>
            <input type="hidden" name="orgId" id="orgId" value="<%=orgId%>"/>
            <input type="text" name="orgName" id="orgName" value="<%=orgName%>" style="width:92%;" class="inputText" readonly="readonly" whir-options="vtype:['notempty']" value="<%=orgName%>" /><a href="javascript:void(0);" class="selectIco" style="cursor:pointer" onclick="openSelect({allowId:'orgIds', allowName:'orgName', select:'org', single:'yes', show:'org', range:'<%=managerScope%>',callbackOK:'getFillLeader'});" ></a>							
         </td>
        
    </tr>

    <tr>
        <td for="兼职组织" class="td_lefttitle">兼职组织：</td>
        <td>
            <s:hidden name="userPO.sidelineOrg" id="sidelineOrg"/>
            <s:textfield name="userPO.sidelineOrgName" id="sidelineOrgName" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'sidelineOrg', allowName:'sidelineOrgName', select:'org', single:'no', show:'org', range:'<%=managerScope%>', limited:'1'});"></a>
        </td>
    </tr>

    <tr>
        <td for="分管领导" class="td_lefttitle">分管领导：</td>
        <td>
            <s:hidden name="userPO.chargeLeaderIds" id="chargeLeaderIds"/>
            <s:textfield name="userPO.chargeLeaderNames" id="chargeLeaderNames" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'chargeLeaderIds', allowName:'chargeLeaderNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
        </td>
    </tr>

    <tr>
        <td for="部门领导" class="td_lefttitle">部门领导：</td>
        <td>
            <s:hidden name="userPO.deptLeaderIds" id="deptLeaderIds"/>
            <s:textfield name="userPO.deptLeaderNames" id="deptLeaderNames" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'deptLeaderIds', allowName:'deptLeaderNames', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
        </td>
    </tr>

    <tr>
        <td for="上级领导" class="td_lefttitle">上级领导：</td>
        <td>
            <s:hidden name="userPO.empLeaderId" id="empLeaderId"/>
            <s:textfield name="userPO.empLeaderName" id="empLeaderName" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'empLeaderId', allowName:'empLeaderName', select:'user', single:'no', show:'usergroup', range:'*0*'});"></a>
        </td>
    </tr>

    <tr>
        <td class="td_lefttitle" align=top>签名图片：</td>
        <td>
            <s:textfield id="signatureImgName" name="userPO.signatureImgName" cssClass="inputText" cssStyle="width:92%;" readonly="true"/>
            <s:hidden id="signatureImgSaveName" name="userPO.signatureImgSaveName"/>
            <table cellpadding="5" cellspacing="0" width="230">
             <tr>
             <td>
               <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="onInit" value="" />
                <jsp:param name="onSelect" value="" />
                <jsp:param name="onUploadSuccess" value="showIMG" />
                <jsp:param name="isShowBatchDownButton" value="no" />
                <jsp:param name="accessType" value="include" />
                <jsp:param name="makeYMdir" value="no" />
                <jsp:param name="dir" value="peopleinfo" />
                <jsp:param name="uniqueId" value="UserAdd" />
                <jsp:param name="realFileNameInputId" value="signatureImgName" />
                <jsp:param name="saveFileNameInputId" value="signatureImgSaveName" />
                <jsp:param name="canModify" value="yes" />
                <jsp:param name="width" value="90" />
                <jsp:param name="height" value="20" />
                <jsp:param name="multi" value="false" />
                <jsp:param name="buttonClass" value="upload_btn" />
                <jsp:param name="buttonText" value="上传图片" />
                <jsp:param name="fileSizeLimit" value="0" />
                <jsp:param name="fileTypeExts" value="*.jpg;*.jpeg;*.gif;*.png;" />
                <jsp:param name="uploadLimit" value="0" />
            </jsp:include>
             </td>
             <td>
             <div class="imgPhoto" onclick="clearImg();">删除图片</div>
             </td>
             </tr>
            </table>
        </td>
    </tr>
    <tr id="imgShowTR">
        <td class="td_lefttitle">&nbsp;</td>
        <td>
        <div style="margin-top:5px;">
        <s:if test="userPO.signatureImgSaveName != null && userPO.signatureImgSaveName != ''">
            <img id="ImgShow" src="<%=path%>/upload/peopleinfo/<s:property value="userPO.signatureImgSaveName"/>"/>
        </s:if>
        <s:else>
            <img id="ImgShow" src="<%=rootPath%>/images/blank.gif"/>
        </s:else>
        </div>
        </td>
    </tr>

    <tr>
        <td class="td_lefttitle">浏览范围：</td>
        <td>
            <s:radio id="rd" name="rd" list="#{'0':'全部','1':'自定义'}" onclick="selRange(this);"></s:radio>
        </td>
    </tr>
    <tr id="browseRangeTR" <s:if test="userPO.browseRange == null || userPO.browseRange == ''">style="display:none"</s:if>>
        <td class="td_lefttitle">&nbsp;</td>
        <td>
            <s:hidden name="userPO.browseRange" id="browseRange"/>
            <s:textfield name="userPO.browseRangeName" id="browseRangeName" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'browseRange', allowName:'browseRangeName', select:'org', single:'no', show:'org', range:'*0*'});"></a>
        </td>
    </tr>

    <tr <s:if test="showMobilePush==false">style="display:none"</s:if>>
        <td class="td_lefttitle">移动办公推送：
        <td>
            <s:radio id="isMobilePush" name="userPO.isMobilePush" list="#{'0':'不使用','1':'使用'}"></s:radio>
            <s:hidden name="userPO.isMobileReceive" id="isMobileReceive"/>
        </td>
    </tr>
    <tr>
        <td for="邮箱容量" class="td_lefttitle">邮箱容量：</td>
        <td>
            <s:textfield name="userPO.mailboxSize" id="mailboxSize" cssClass="inputText" whir-options="vtype:['p_integer_e']" cssStyle="width:80px;" maxlength="6"/>&nbsp;M
        </td>
    </tr>
    <tr>
        <td for="我的文档" class="td_lefttitle">我的文档：</td>
        <td>
            <s:textfield name="userPO.netDiskSize" id="netDiskSize" cssClass="inputText" whir-options="vtype:['p_integer_e']" cssStyle="width:80px;" maxlength="6"/>&nbsp;M
        </td>
    </tr>

    <tr class="Table_nobttomline">
        <td></td>
        <td nowrap>
          <s:if test="status != 'disabled'&&status != 'sleep'">
            <input type="button" class="btnButton4font saveBtn" onclick="saveForm(0,this);" value="<s:text name="comm.saveclose"/>" />
            <s:if test="empId==null">
                <input type="button" class="btnButton4font saveBtn" onclick="saveForm(1,this);" value="<s:text name="comm.savecontinue"/>" />
            </s:if>
            <input type="button" class="btnButton4font saveBtn" onclick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
           </s:if>
            <input type="button" class="btnButton4font saveBtn" onclick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
        </td>
    </tr>
</table>

    </div>

    <div id="tab1" class="grayline" style="display:none">
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline righttable">
    <tr>
        <td width="80%" valign="top">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="80" nowrap>权&nbsp;&nbsp;&nbsp;&nbsp;限：</td>
                    <td width="100" nowrap>
                        <select id="changeRights"  data-options="panelHeight:'auto',width:200,onSelect: function(record){ChangeSelect(record);}">
                            <option value="1">本人</option>
                            <option value="3">本组织</option>
                            <option value="2">本组织及下属组织</option>
                            <s:if test="sysManagerFlag.indexOf('1')>=0">
                            <option value="0">全部</option>
                            </s:if>
                            <option value="4">自定义</option>
                        </select>
                    </td>
                    <td align="left" width="80%">
                        <span id="defaulDefineRangeTD" style="display:none;">
                        <s:hidden name="defaultRightScopeScopeId" id="defaultRightScopeScopeId"/>
                        <s:textfield name="defaultRightScopeScopeDsp" id="defaultRightScopeScopeDsp" cssClass="inputText" cssStyle="width:92%;" readonly="true"></s:textfield><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'defaultRightScopeScopeId', allowName:'defaultRightScopeScopeDsp', select:'userorg', single:'no', show:'orgusergroup', range:'<%=managerScope%>', limited:'1'});"></a>
                        <span>
                    </td>
                </tr>

                <tr>
                    <td valign="top">&nbsp;</td>
                    <td colspan=2 valign="top">
                        <div style="width:94%;height:100%;">
                        <div class="Public_tag" >
                            <div id="whir_mainMenuBar" style="FLOAT: left; OVERFLOW: hidden; WIDTH: 530px;">
                                <div id="whir_mainMenuBarBox" style="WIDTH: 20000px;">
                                    <div id="whir_mainMenuBarBox2" style="FLOAT: left;">
                                        <ul id="whir_tab_ul2">
                                            <li class="tag_aon" whir-options="{target:'tab_0'}">
                                                <span class="tag_center">系统</span>
                                                <span class="tag_right"></span>
                                            </li>
                                            <li whir-options="{target:'tab_1'}">
                                                <span class="tag_center">自定义模块</span>
                                                <span class="tag_right"></span>
                                            </li>
                                            <li whir-options="{target:'tab_2'}">
                                                <span class="tag_center">自定义关系</span>
                                                <span class="tag_right"></span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="whir_clear"></div>
                        </div>
                        <!--滑动标签结束-->
                        <div class="whir_clear"></div>

                        <div id="rightsList">

                        <div id="tab_0" class="grayline graylinetd">
                        </div>
                        <div id="tab_1" class="grayline graylinetd" style="display:none">
                        </div>
                        <div id="tab_2" class="grayline graylinetd" style="display:none">
                        </div>

                        </div>
                    </td>
                </tr>

                <tr class="Table_nobttomline">
                    <td></td>
                    <td nowrap colspan=2>
                    
                        <input type="button" class="btnButton4font saveBtn" onclick="saveTheForm(0,this);" value="<s:text name="comm.saveclose"/>" />
                        <s:if test="empId==null">
                            <input type="button" class="btnButton4font saveBtn" onclick="saveTheForm(1,this);" value="<s:text name="comm.savecontinue"/>" />
                        </s:if>
                        <input type="button" class="btnButton4font saveBtn" onclick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
                       
                        <input type="button" class="btnButton4font saveBtn" onclick="closeWindow(null);" value="<s:text name="comm.exit"/>" />
                    </td>
                </tr>
            </table>
        </td>
        <td width="20%" valign="top">
            <table width="100%" height="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                <tr>
                    <td>
                        <input type="checkbox" id="allRole" name="allRole" onclick="getAllRole(this);">全部角色
                    </td>
                </tr>
                <tr>
                    <td width="100%">                    
                        <div style="width:96%;height:100%;padding:0px;" id="search-panel"></div>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
    </div>

    <s:if test="empId != null && status != 'apply'">
    <div id="tab2" class="grayline" style="display:none">
        <div class="whir_space10"></div>
        <div class="grayline_notop" style="background:url()">
            <iframe id="tab2_iframe" width="100%" height="400" border=0 frameborder=0 src=""></iframe>
        </div>
    </div>
    </s:if>

</div>
<div id="ikeyDiv" style="display:none"></div>
<iframe id="setkeyiframe" style="display:none"></iframe>
<br/><br/><br/>
<%@ include file="/public/include/include_extjs.jsp"%>
<script type="text/javascript" src="<%=rootPath%>/platform/system/system_manager/searchfield.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var a = '<%=orgId%>';
var b = '<%=orgName%>';
var c = '<%=type%>';
if(a!=null&&b!=null&&c!=null&&a!=""&&b!=""&&c!=""&&c=="add"){
	$('#orgIds').val('<%=orgId%>');
}

<!--
function showIMG(json){
    var flag = false;
	$('#ImgShow').attr("src", "<%=path%>/upload/peopleinfo/"+json.save_name+json.file_type).load(function() {
        var fileOffsetWidth = this.width;
        var fileOffsetHeight = this.height;
        if(flag == false){            
            //alert(fileOffsetWidth + "X" + fileOffsetHeight);
            flag = true;

            if(99>fileOffsetWidth || 19>fileOffsetHeight){
                whir_confirm("系统推荐上传的图片尺寸为100X20，而您上传的图片大小为"+fileOffsetWidth+"X"+fileOffsetHeight+'，可能导致显示不正常！点击"确定"继续上传，点击"取消"退出上传', function(){
                },
                function(){
                 	clearImg();
                });
            }else if(101<fileOffsetWidth || 21<fileOffsetHeight){
                whir_confirm("系统推荐上传的图片尺寸为100X20，而您上传的图片大小为"+fileOffsetWidth+"X"+fileOffsetHeight+'，可能导致显示不正常！点击"确定"继续上传，点击"取消"退出上传', function(){
                },
                function(){
                	clearImg();
                });
            }
        }
    });
    $('#signatureImgName').val(json.file_name+json.file_type);
    $('#signatureImgSaveName').val(json.save_name+json.file_type);
}

function clearImg(){
    $('#ImgShow').attr('src','<%=rootPath%>/images/blank.gif');
    $('#signatureImgName').val('');
    $('#signatureImgSaveName').val('');
}

function initKey() {
    var iKeySerial = "";
    if($.browser.msie){
        if ($('#keyValidate').attr('checked')=='checked') {
            <%if(isepass==false){%>
            $('#ikeyDiv').html("<OBJECT classid='clsid:F9A1BC7E-CD32-11D3-8D0A-00A0C99FF62A' data='data:application/x-oleobject;base64,fryh+TLN0xGNCgCgyZ/2KgADAADYEwAA2BMAAA==' id='iKeyServer' width=0 height=0 hspace=0 vspace=0 VIEWASTEXT></OBJECT>");
            try {
                var iKeyServer = document.getElementById("iKeyServer");
                iKeyServer.OpenDevice(1, "");
                iKeySerial = iKeyServer.GetStringProperty(7, 0, "");
                iKeyServer.CloseDevice();
            } catch (e) {                
                whir_alert(e + "未发现令牌，请插入令牌，如果令牌已存在请确认您的驱动程序是否正确安装！", null);                
                $('#keyValidate').attr('checked', false);
                //$('#keyValidate').parent().removeClass("checked");
            }
            $('#keySerial').val(iKeySerial);

            <%}else{%>
            //飞天诚信key-epass1000ND
            document.getElementById("setkeyiframe").src="<%=rootPath%>/platform/system/system_manager/setkey.jsp?nav=" + window.navigator.platform;
            <%}%>
        }
    }else{
        $('#keyValidate').attr('checked', false);
        //$('#keyValidate').parent().removeClass("checked");
        $('#keySerial').val(iKeySerial);
        whir_alert("此功能只能在 IE 浏览器下使用！", null);
    }    
}

function resetKeyValidate(){
    $('#keyValidate').attr('checked', false);
    //$('#keyValidate').parent().removeClass("checked");
}

<%if(isepass==false){%>
function OnInsert() {
    initKey();
}

function OnRemove() {
}
<%}%>

Ext.onReady(function() {

    if($('#action').val()=='add' || $('#status').val()=='apply'){
        $('#userAccounts').val('');
        $('#userPassword').val('');
    }

    <s:if test="empId==null">
    $('#userAccounts').focus();
    </s:if>

    initTab('whir_tab_ul2');

    var combo1 = Ext.create('Ext.form.field.ComboBox', {
        id: 'empDuty',
        typeAhead: true,
        transform: 'empDuty',
        hiddenName: 'userPO.empDuty',
        width: 300,
        forceSelection: true
    });

    var combo2 = Ext.create('Ext.form.field.ComboBox', {
        id: 'changeRights',
        typeAhead: true,
        transform: 'changeRights',
        width: 200,
        forceSelection: true,
        listeners: {
            select: function(combo, record, index) {
                ChangeSelect(combo);
            }
        }
    });
});
//-->
</SCRIPT>