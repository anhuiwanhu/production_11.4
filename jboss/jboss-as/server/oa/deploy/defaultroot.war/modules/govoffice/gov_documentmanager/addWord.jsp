<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>
		<s:if test="#parameters.view != null">查看机关代字</s:if>
		<s:else>
			<s:if test="wordPo!=null">修改机关代字</s:if>
			<s:else>新增机关代字</s:else>
		</s:else>
	</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body class="Pupwin">
	<div class="BodyMargin_10">  
		<div class="docBoxNoPanel">
	<s:form name="dataForm" id="dataForm" action="GovDocSet!saveWord.action" method="post" theme="simple" >
    <%@ include file="/public/include/form_detail.jsp"%>
               <s:hidden name="wordPo.id" />
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for="机关代字" width="100" class="td_lefttitle">  
                            机关代字<span class="MustFillColor">*</span>：  
                        </td>  
                        <td>  
                            <s:textfield name="wordPo.wordName" id="wordName" cssClass="inputText" maxlength="20" whir-options="vtype:['notempty',{'maxLength':20}],'promptText':'请输入名称'" cssStyle="width:96%;" />  
                        </td>  
                    </tr>
					<tr>  
                        <td for="排序码" class="td_lefttitle">  
                            排序码<span class="MustFillColor">*</span>：
                        </td>  
                        <td  colspan="3" align="left">  
				           <s:textfield name="wordPo.ordernum" id="ordernum" cssClass="inputText"  whir-options="vtype:['notempty','p_integer_e',{'maxLength':10}],'promptText':'请输入排序码'" cssStyle="width:96%;" maxlength="50" />  
                        </td>  
                    </tr>
                    <tr>  
                        <td for="文号" class="td_lefttitle">  
                            文号：  
                        </td>  
                        <td>  
				           <%--<s:select name="wordPo.sendDocumentNumId" list="#request.numList" headerKey="-1" editable="false" headerValue="--请选择--" cssClass="easyui-combobox" cssStyle="width:96%;" data-options="width:202,panelHeight:'500', editable:false">

						   </s:select>--%>
                            <s:hidden name="wordPo.sendDocumentNumId" id="sendDocumentNumId"/>
                            <s:textfield  id="sendDocumentNumName" name="numPo.numName"  readonly="true" cssClass="inputText" cssStyle="width:96%;" /><a  href="javascript:void(0);" class="selectIco" onclick="popup({content:'url:<%=rootPath%>/GovDocSet!sendFileNumListRadio.action?tempWHId='+$('#sendDocumentNumId').val(),title: '文号列表',width:800,height:600});"></a>

                        </td>  
                    </tr>
                    <tr>  
                        <td for="流水号" class="td_lefttitle">  
                            流水号：  
                        </td>  
                        <td>  
							<s:select name="wordPo.sendDocumentSeqId" list="#request.seqList" headerKey="-1" headerValue="--请选择--" cssClass="easyui-combobox" cssStyle="width:96%;" data-options="width:202,panelHeight:'500', editable:false">
						   </s:select>
                        </td>  
                    </tr>	
					<%
						boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);
						if(!isCOSClient){//if("zh".equals( request.getLocale().getLanguage() )){//en
					%>
					<tr>  
                        <td for="对应模板" class="td_lefttitle">  
                            对应模板：  
                        </td>  
                        <td>  
							<s:hidden name="wordPo.templateId" id="templateId"/>
                            <s:textfield name="wordPo.templateName" id="templateName"  readonly="true" cssClass="inputText" cssStyle="width:96%;" /><a  href="javascript:void(0);" class="selectIco" onclick="popup({content:'url:<%=rootPath%>/GovDocSet!sendTempList.action',title: '模板列表',width:800,height:600});"></a>
                        </td>  
                    </tr>
					<%
						}
					%>
					<tr>  
                        <td for="对应流程" class="td_lefttitle">  
                            对应流程：  
                        </td>  
                        <td>  
							<s:hidden name="wordPo.poolProcessId" id="processId"/>
                            <s:textfield name="wordPo.processName" id="processName" readonly="true" cssClass="inputText" cssStyle="width:96%;"/><a href="javascript:void(0);" class="selectIco" onclick="popup({content:'url:<%=rootPath%>/GovDocSet!sendProcessList.action?moduleId=2',title: '流程列表',width:800,height:600,winName:'selProcess'});"></a>
                        </td>  
                    </tr>

					<tr>  
                        <td for="使用范围" class="td_lefttitle">  
                            使用范围：  
                        </td>  
                        <td>  
							<s:hidden name="wordPo.receiveScopeId" id="receiveScopeId"/>
                           <!-- <s:textfield name="wordPo.userRange" id="userRange" readonly="true"  cssClass="inputText" cssStyle="width:96%;"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'userRangeId', allowName:'userRange', select:'user', single:'no', show:'userorg', range:'*0*'});"></a>-->
						    <s:hidden name="wordPo.receiveUser" id="receiveUser"/>
							<s:hidden name="wordPo.receiveOrg" id="receiveOrg"/>
							<s:hidden name="wordPo.receiveGroup" id="receiveGroup"/>
							<s:textarea name="wordPo.receiveScopeName"  id="receiveScopeName" cols="112" rows="3" readonly="true" cssClass="inputTextarea" cssStyle="width:96%;"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'receiveScopeId', allowName:'receiveScopeName', select:'userorg', single:'no', show:'userorg', range:'*0*'});"></a>
							<br><font color="red" style="font-color:red">使用范围为空时默认所有用户</label>
                        </td>  
                    </tr>
					<%
						//boolean isCOSClient = com.whir.component.util.SystemUtils.isCOS4Firefox4(request);
						if(!isCOSClient){//if("zh".equals( request.getLocale().getLanguage() )){//en
					%>
					<tr>  
                        <td for="对应红头" class="td_lefttitle">  
                            对应红头：
                        </td>  
                        <td>  
                            <div>
							<s:hidden name="wordPo.redHeadSaveName" id="redHeadSaveName"/>
                            <s:textfield name="wordPo.redHeadName" id="redHeadName" readonly="true"   cssClass="inputText" cssStyle="width:96%;"/>
                            </div>
							<div style="margin-top: 5px;">
							<input type="button" class="btnButton4font" onclick="uploadHead();" value="导　入"/>
							<input type="button"  class="btnButton4font" onclick="clearHead();" value="清　除"/>
							</div>
                          </td>  
                    </tr>		
					<%
						}
					%>
					<tr>  
                        <td for="可维护人" class="td_lefttitle">  
                            可维护人：  
                        </td>  
                        <td> 	
							<s:hidden name="wordPo.canModifyEmpId" id="canModifyEmpId"/>
                            <s:textarea name="wordPo.canModifyEmpName"  id="canModifyEmpName" cols="112" rows="3" readonly="true" cssClass="inputTextarea" maxlength="95"  cssStyle="width:96%;"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'canModifyEmpId', allowName:'canModifyEmpName', select:'user', single:'no', show:'userorg', range:'*0*'});"></a>
				         </td>  
                    </tr>

                   
                    <!--tr>  
                        <td for="角色" class="td_lefttitle">  
                           角色：  
                        </td>  
                        <td>  
                            <input type="checkbox" name="type" value="0"> 会员 <input type="checkbox" name="type" value="1"> 管理员
                        </td>  
                    </tr>
                    <tr>  
                        <td for="年龄" class="td_lefttitle">年龄：</td>  
                        <td>  
                           <input type="text" class="easyui-numberspinner" data-options="min:10,max:100" style="width:80px;" name="age" id="age" ></input>
                        </td>  
                    </tr>

					 <tr>  
                        <td for="年龄" class="td_lefttitle">组织（公共选人、组织、群组）：</td>  
                        <td>  
                           <input type="text" class="inputText"  name="org" id="org" ></input>
                        </td>  
                    </tr>

					 <tr>  
                        <td for="年龄" class="td_lefttitle">联系人（zTree）：</td>  
                        <td>  
                           <s:checkboxlist name="list" list="{'Java','.Net','RoR','PHP'}" value="{'Java','.Net'}" />
                        </td>  
                    </tr-->
                    <tr class="Table_nobttomline">  
	                    <td > </td> 
                        <td nowrap>
							<s:if test="#parameters.view == null">
                            <input type="button" class="btnButton4font" onClick="save1(this)" value="保存退出" />  
							<s:if test="wordPo==null">
                            <input type="button" class="btnButton4font" onClick="save2(this)" value="保存继续" />  
							</s:if>
                            <input type="button" class="btnButton4font"  onClick="resetDataForm(this)"     value="重    置" />  
							</s:if>
                            <input type="button" class="btnButton4font" onClick="window.close();" value="退    出" />  
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
	//分割范围
function getscope(){
	var receiveScopeId = document.getElementById("receiveScopeId").value;
	var  receiveUser="";
	var  receiveOrg="";
	var  receiveGroup="";

	if(receiveScopeId != ""){
	for( var i = 0; i < receiveScopeId.length; i ++ ){
	flagCode = receiveScopeId.charAt(i);
	nextPos = receiveScopeId.indexOf(flagCode,i + 1);
	str = receiveScopeId.substring(i,nextPos+1);
	if(flagCode == "$"){
	receiveUser = receiveUser + str;
	}else if(flagCode == "*"){
	receiveOrg = receiveOrg + str;
	}else{
	receiveGroup = receiveGroup + str;
	}
	i = nextPos;
	}
	}
	document.getElementById("receiveUser").value = receiveUser;
	document.getElementById("receiveOrg").value = receiveOrg;
	document.getElementById("receiveGroup").value = receiveGroup;

}
	//保存退出
	function save1(O){
		var result = $.ajax({
		  url: "<%=rootPath%>/modules/govoffice/gov_documentmanager/senddocument_ajaxjudgename.jsp?type=sendWord&name="+encodeURIComponent
		 ($("#wordName").val()),
		  async: false
		}).responseText;
 		if(result !="-1" && result!="<s:property  value="wordPo.id" />" ){
	    	whir_alert("机关代字已经存在!");
			document.getElementById("wordName").focus();
			return false;
		}
		if($("#processName").val().length >=200){
			whir_alert("您流程选择太多！");
			return false;
		}
		var wordName = $("#wordName").val();
		var checkresult = spechar3(wordName,"");
		if(checkresult != ""){
			whir_alert(checkresult);
			return false;
		}
		getscope();
		ok(0,O);
	}
	//保存继续
	function save2(obj){
		if($("#processName").val().length >=200){
			whir_alert("您流程选择太多！");
			return false;
		}
		var wordName = $("#wordName").val();
		var checkresult = spechar3(wordName,"");
		if(checkresult != ""){
			whir_alert(checkresult);
			return false;
		}
		ok(1,obj);
	}

	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	//上传 红头
	function  uploadHead(){
		popup({content:'url:<%=rootPath%>/modules/govoffice/gov_documentmanager/senddocument_import.jsp?path=govReadHead&fileName=wordPo.redHeadName&saveName=wordPo.redHeadSaveName&fileMaxSize=0&fileMaxNum=1&fileType=jpg,gif,bmp,jpeg,png',title: '导入',width:560,height:280,winName:'_blank'});
	}
	function clearHead(){
		$('#redHeadName').val("");
		$('#redHeadSaveName').val("");
	}
</script>
</html>

