 

 $(function() {
	/*  在textarea处插入文本--Start */
	(function($) {
		$.fn
				.extend({
					insertContent : function(myValue, t) {
						var $t = $(this)[0];
						if (document.selection) { // ie
							this.focus();
							var sel = document.selection.createRange();
							sel.text = myValue;
							this.focus();
							sel.moveStart('character', -l);
							var wee = sel.text.length;
							if (arguments.length == 2) {
								var l = $t.value.length;
								sel.moveEnd("character", wee + t);
								t <= 0 ? sel.moveStart("character", wee - 2 * t
										- myValue.length) : sel.moveStart(
										"character", wee - t - myValue.length);
								sel.select();
							}
						} else if ($t.selectionStart
								|| $t.selectionStart == '0') {
							var startPos = $t.selectionStart;
							var endPos = $t.selectionEnd;
							var scrollTop = $t.scrollTop;
							$t.value = $t.value.substring(0, startPos)
									+ myValue
									+ $t.value.substring(endPos,
											$t.value.length);
							this.focus();
							$t.selectionStart = startPos + myValue.length;
							$t.selectionEnd = startPos + myValue.length;
							$t.scrollTop = scrollTop;
							if (arguments.length == 2) {
								$t.setSelectionRange(startPos - t,
										$t.selectionEnd + t);
								this.focus();
							}
						} else {
							this.value += myValue;
							this.focus();
						}
					}
				})
	})(jQuery);
	/* 在textarea处插入文本--Ending */
});


//String.prototype.replaceAll = function(s1,s2){  return this.replace(new RegExp(s1,"gm"),s2);  } 

String.prototype.replaceAllString = function(s1,s2){ 
	this.str=this; 
	if(s1.length==0)return this.str; 
	var idx=this.str.indexOf(s1); 
	while(idx>=0){ 
	this.str=this.str.substring(0, idx)+s2+this.str.substr(idx+s1.length); 
	idx=this.str.indexOf(s1); 
	} 
	return this.str; 
};
 


var  field_text_Map=new Map();  
var  text_field_Map=new Map(); 

var  rm_start="{";
var  rm_end="}";

//当前属性页面编辑的元素对象
var model; 
var initFormKey=""; 
function  initPackage(){
	//alert("第一");
	//设置当前修改对象为流程对象
	model = opener.xiorkFlow.xiorkFlowWrapper.getModel();
	//流程分类id whir:processPackage
	var processPackage1 = model.getAttribute("whir:processPackage");
	var processPackageName1 = model.getAttribute("whir:processPackageName");

	//默认选择一个
	if(processPackage1==null||processPackage1==""){  
		  if($("input[name='processPackage_checbox']").length==1){
             var  firstP=$("input[name='processPackage_checbox']")[0];
			 processPackageName1=$(firstP).attr("displaytext");
             processPackage1 =$(firstP).val();   
		  }
	}   
	$("#processPackageDisName").html(processPackageName1);
	$("#processPackage").val(processPackage1); 
	$("#processPackageName").val(processPackageName1);
	
	var processPackage1_=","+processPackage1+",";
	//选中已经选择的
	$('input:checkbox[name="processPackage_checbox"]').each(function(){
		 var thisvalue=$(this).val();
		 if(processPackage1_.indexOf(","+thisvalue+",")>=0){
			  //alert(processPackage1_);
			  //alert(","+thisvalue+",");
			  $(this).attr("checked",'checked');
		 }											
	});
	
	var dwidth=$("#checkboxSelect").width(); 
	// 弹出层
	$("#checkboxSelect").powerFloat({  width: dwidth });
}


function  getFormType(){
	var moduleId=$("#moduleId").val(); 
	var formType_val="0";
    if(moduleId=='1'){
		 formType_val= $("input[name='formType']:checked").val() ;
	}else{
		formType_val=$("#formType").val();
	} 
	return formType_val;
}

function showJspInfo(){
	var formType_val= getFormType();
	if(formType_val=="1"){
		$('#show_box02').show();
		$('#show_box03').show();
		$('#show_box01').hide();

		$("#tr_field").hide();
		$("#tr_field2").hide();

		$("#tr_remindfield").hide();
		$("#tr_showremind").hide();
		$("#tr_relationTrig").hide();


	}else if(formType_val=="0"){
		$('#show_box02').hide();
		$('#show_box03').hide();
		$('#show_box01').show();

		$("#tr_field").show();
		$("#tr_field2").show();
		$("#tr_remindfield").show();
		$("#tr_showremind").show();
		$("#tr_relationTrig").show();
	}else{
	    $('#show_box02').hide();
		$('#show_box03').hide();
		$('#show_box01').show();

		$("#tr_field").show();
		$("#tr_field2").show();
		$("#tr_remindfield").show();
		$("#tr_showremind").show();
		$("#tr_relationTrig").hide();
	} 
}
 /**
  选中的分类事件
 */
 function  setPackageInfo(){
	  var _processPackage1="";
	  var _processPackageName1="";
	  $('input:checkbox[name="processPackage_checbox"]:checked').each(function(){					 
		   if($(this).attr("checked")=="checked"){
			   _processPackage1+=$(this).val()+",";
			   _processPackageName1+=$(this).attr("displaytext")+",";
		   }			 
	  }); 
	  if(_processPackage1!==""&&_processPackage1.substring(_processPackage1.length-1)==","){
		  _processPackageName1=_processPackageName1.substring(0,_processPackageName1.length-1);
		  _processPackage1=_processPackage1.substring(0,_processPackage1.length-1);
	 } 
	 $("#processPackageDisName").html(_processPackageName1);
	 $("#processPackage").val(_processPackage1);
	 $("#processPackageName").val(_processPackageName1);		
 } 

//初始化属性
function initData() {
	if(p_comboxType=="ext"){
		initExt();
	}else{
		initChange();
	} 
    $("#hxr").hide();//document.all.hxr.style.display = "none";
	$("#qbblr").hide();//document.all.qbblr.style.display = "none";
	$("#bdzd").hide();//document.all.bdzd.style.display = "none";
	$("#participantRole").hide();//document.all.participantRole.style.display = "none";
	$("#zdzz").hide();//document.all.zdzz.style.display = "none";
	$("#xdqz").hide();//document.all.xdqz.style.display = "none"; 

	//alert("第三");
	/*
	1、所有分类 
	2、所有字段
	3、可选表单
	4、提醒项
	*/
	if(opener == null || opener.xiorkFlow == null || opener.xiorkFlow.xiorkFlowWrapper == null || opener.xiorkFlow.xiorkFlowWrapper.getModel() == null) {
		alert("父页面或者流程已经不存在！");
		return;
	}
	//设置当前修改对象为流程对象
	model = opener.xiorkFlow.xiorkFlowWrapper.getModel();
	
	//ID
	$("input[name='id']").attr("value", model.getID());
	//名称
	$("input[name='name']").attr("value", model.getName());
	//$("input[name='name']").attr("value", model.getAttribute("name"));

	//流程使用范围
	$("input[name='processUserScope']").attr("value", model.getAttribute("whir:processUserScope"));

	//流程使用范围名称
	$("textarea[name='processUserScopeName']").attr("value", model.getAttribute("whir:processUserScopeName"));

	//流程分类id whir:processPackage
	/*var processPackage = model.getAttribute("whir:processPackage");
	var processPackageName = model.getAttribute("whir:processPackageName");
	if(processPackage != null) {
		$("input[name='processPackage']").attr("value", processPackage);
		$("input[name='processPackageName']").attr("value", processPackageName); 
	}*/
     
	

	var processType_v= model.getAttribute("whir:processType");
	if(processType_v==null){
		processType_v="1";
	}   
	$("input[name='processType'][value='"+processType_v+"']")[0].checked=true;
 
	//whir:processNeedDossier		是否需要归档，  true /false
	var priority = model.getAttribute("whir:processPackage");
	if(priority != null) {
		$("select[name='processPackage']").attr("value", priority);
	}


	//whir:processNeedPrint		发起人是否可以打印  true/false
	 var processNeedPrintRadio = $("input[name='processNeedPrint'][value='" + model.getAttribute("whir:processNeedPrint") + "']");
	 if(processNeedPrintRadio.length > 0) {
		processNeedPrintRadio[0].checked = true;
	 }

	/* var processPrintExportTemp_val=model.getAttribute("whir:processPrintExportTemp");
     //
	 if(processPrintExportTemp_val==null||processPrintExportTemp_val=="true"||processPrintExportTemp_val!="false"){
		  //流程办结后可以导出word模板和下载
		 var processPrintExportTempRadio = $("input[name='processPrintExportTemp'][value='true']");
		 if(processPrintExportTempRadio.length > 0) {
			processPrintExportTempRadio[0].checked = true;
		 }	 
	 }*/

	//whir:processCommentIsNull		批示意见是否可以为空  true/false
	var processCommentIsNullRadio = $("input[name='processCommentIsNull'][value='" + model.getAttribute("whir:processCommentIsNull") + "']");
	if(processCommentIsNullRadio.length > 0) {
		processCommentIsNullRadio[0].checked = true;
	}
	//
	if(model.getAttribute("whir:commentSortType") != null){
		var commentSortTypeSelect = $("select[name='commentSortType']");
		if(commentSortTypeSelect.length > 0) {
			 commentSortTypeSelect[0].value = model.getAttribute("whir:commentSortType");

		}
	}

    if(model.getAttribute("whir:orgcommentSortType") != null){
		var orgcommentSortTypeSelect = $("select[name='orgcommentSortType']");
		if(orgcommentSortTypeSelect.length > 0) {
			 orgcommentSortTypeSelect[0].value = model.getAttribute("whir:orgcommentSortType");
		}
	}


	//whir:processKeepBackComment		保留退回意见  true/false
	var processKeepBackCommentRadio = $("input[name='processKeepBackComment'][value='" + model.getAttribute("whir:processKeepBackComment") + "']");
	if(processKeepBackCommentRadio.length > 0) {
		processKeepBackCommentRadio[0].checked = true;
	}

	//whir:processEndMail		结束邮件提醒  true/false
	var processEndMailRadio = $("input[name='processEndMail'][value='" + model.getAttribute("whir:processEndMail") + "']");
	if(processEndMailRadio.length > 0) {
		processEndMailRadio[0].checked = true;
	}

	//whir:processCommentAcc		批示意见上传附件  true/false
	var processCommentAccRadio = $("input[name='processCommentAcc'][value='" + model.getAttribute("whir:processCommentAcc") + "']");
	if(processCommentAccRadio.length > 0) {
		processCommentAccRadio[0].checked = true;
	}

	//whir:processKeepReSubmitComment 保留退回后重新提交前的批示意见 true/false
	var processKeepReSubmitCommentRadio = $("input[name='processKeepReSubmitComment'][value='" + model.getAttribute("whir:processKeepReSubmitComment") + "']");
	if(processKeepReSubmitCommentRadio.length > 0) {
		processKeepReSubmitCommentRadio[0].checked = true;
	}

	//办理查阅查看人ID
	var processCanReadEmp = model.getAttribute("whir:processCanReadEmp");
	$("input[name='processCanReadEmp']").attr("value" , processCanReadEmp );
	//办理查阅查看人显示
	var processCanReadEmpName = model.getAttribute("whir:processCanReadEmpName");
	$("textarea[name='processCanReadEmpName']").attr("value" , processCanReadEmpName );
	//办理查阅维护人ID
	var processCanModifyEmp = model.getAttribute("whir:processCanModifyEmp");
	$("input[name='processCanModifyEmp']").attr("value" , processCanModifyEmp );
	//办理查阅维护人显示
	var processCanModifyEmpName = model.getAttribute("whir:processCanModifyEmpName");
	$("textarea[name='processCanModifyEmpName']").attr("value" , processCanModifyEmpName );
	//流程管理员ID
	var processAdministrator = model.getAttribute("whir:processAdministrator");
	$("input[name='processAdministrator']").attr("value" , processAdministrator );
	//流程管理员显示
	var processAdministratorName = model.getAttribute("whir:processAdministratorName");
	$("textarea[name='processAdministratorName']").attr("value" , processAdministratorName );

	//whir:processNeedDossier		是否需要归档  true/false
	var processNeedDossierRadio = $("input[name='processNeedDossier'][value='" + model.getAttribute("whir:processNeedDossier") + "']");
	if(processNeedDossierRadio.length > 0) {
		processNeedDossierRadio[0].checked = true;
	}

	//whir:processAutoNextWithNullUser  活动参与者为空自动跳转下一步
	var processAutoNextWithNullUserRadio = $("input[name='processAutoNextWithNullUser'][value='" + model.getAttribute("whir:processAutoNextWithNullUser") + "']");
	if(processAutoNextWithNullUserRadio.length > 0) {
		processAutoNextWithNullUserRadio[0].checked = true;
	}


	if(model.getRecordId()>0){ 
		$("input[name='id']")[0].disabled=true;
	}
	//whir:processRemindField		提醒字段:  ,fieldid,,fieldid,,fieldid,  

	//whir:nodeWriteField		可写字段   ,fieldid,,fieldid,……

	//whir: formKey		表单id 或者 某个jsp路径（绝对还是相对）
	var formKey = model.getAttribute("whir:formKey");
    initFormKey=formKey;
	var formType_v = model.getAttribute("whir:formType");
	if(formType_v==null){
		formType_v="0";
	} 

	if(formKey != null&&formKey!="-1") { 
		//$("select[name='formKey']").attr("value", formKey);
		//$('#formKey').combobox('setValue',formKey); 
		 setpcomboxval('formKey', formKey+formType_v);
	}
	if( formKey == "-1" ){
		$("input[name='formType'][value='1']")[0].checked=false;
		$("input[name='formType'][value='1']")[0].click();
		$("input[name='formAddUrl']").val( model.getAttribute("whir:formAddUrl"));
		$("input[name='formUpdateUrl']").val( model.getAttribute("whir:formUpdateUrl"));
	}else{
		
	}
    
    //var  formKeyval=$('#formKey').combobox('getValue');
	var  formKeyval=getpcomboxval('formKey'); 
	if(formKeyval!=null&&formKeyval!=""){
		changeFormKey();
	//if($("select[name='formKey'] option:selected").length == 0){			
	}else{
		//$("select[name='formKey']").change();  	 
	}

	//字段联动
	var relationTrig = model.getAttribute("whir:relationTrig");
	if(relationTrig != null) {
		$("select[name='relationTrig']").attr("value", relationTrig);
	}

	//流程描述
	var documentation = model.getDocumentation();
	if(documentation != null) {
		//$("textarea[name='documentation']").attr("value", documentation);
		//processDescription_html.setHTML(documentation);
        document.getElementById("newedit").contentWindow.setHTML(documentation);
		/*if ($("#processDescription").val()!=""){
			document.getElementById("newedit").contentWindow.setHTML($("#processDescription").val());
		}*/
	}

	//移动办公
	//pad端
	var  mobileStatus=model.getAttribute("whir:mobileStatus");
	if(mobileStatus==null||mobileStatus==""){
	     mobileStatus="0";
	}
	if(mobileStatus=="1"){
		 var processCanPADCheck = $("input[name='processCanPAD'][value='1']");
		 if(processCanPADCheck.length > 0) {
			processCanPADCheck[0].checked = true;
		 }
	} 
   
	//手机端
	var  mobilePhoneStatus=model.getAttribute("whir:mobilePhoneStatus");
	if(mobilePhoneStatus==null||mobilePhoneStatus==""){
	     mobilePhoneStatus="0";
	}
	if(mobilePhoneStatus=="1"){
		 var processCanMobilePhoneCheck = $("input[name='processCanMobilePhone'][value='1']");
		 if(processCanMobilePhoneCheck.length > 0) {
			processCanMobilePhoneCheck[0].checked = true;
		 }
	}
	
	// 是否显示 原来的表单  
	//手机端
	var  processFormShowAtMobile=model.getAttribute("whir:processFormShowAtMobile");
	if(processFormShowAtMobile==null||processFormShowAtMobile==""){
	     processFormShowAtMobile="0";
	}
	if(processFormShowAtMobile=="1"){
		 var processFormShowAtMobileCheck = $("input[name='processFormShowAtMobile'][value='1']");
		 if(processFormShowAtMobileCheck.length > 0) {
			processFormShowAtMobileCheck[0].checked = true;
		 }
	}  


	/*
	//
	var formClassname = model.getAttribute("whir:formClassName");
	if(formClassname != null) {
		//$("textarea[name='documentation']").attr("value", documentation);
		$("input[name='formClassName']").attr("value", formClassname);
	}
	*/
		
	var fields = "" ;
	//可写字段
	fields = model.getAttribute("whir:nodeWriteField");
	var field1Select = $("select[name='field']");//全部字段下拉框
	var nodeWriteFieldSelect = $("select[name='nodeWriteField']");//可写字段下拉框
	if( nodeWriteFieldSelect.length < 1){
		alert("没有找到name为nodeWriteField的SELECT！");
	}else{
		if(fields != null ){//存在可写字段属性
			fieldArray = fields.split(",");
			if(field1Select.length >0 ){
				for( i = 0 ;i < fieldArray.length; i ++){
					var field = fieldArray[i];
					var alloptions = field1Select[0].options;
					for( j=0;j<alloptions.length;j++){
						if( alloptions[j].value == field ){
							/*var newOpt =document.createElement("OPTION");
							newOpt.value=alloptions[j].value;
							newOpt.text =alloptions[j].text;
							nodeWriteFieldSelect[0].add(newOpt); */
                            nodeWriteFieldSelect.append("<option value='"+alloptions[j].value+"'>"+alloptions[j].text+"</option>");

							field1Select[0].remove(j);
							break;
						}
					}
				}
			}else{
				alert("没有找到name为field的SELECT！");
			}
		}
	}



	var fields2 = "" ;
	//可写字段
	fields2 = model.getAttribute("whir:nodeHiddenForStartUserField");
	var field1Select2 = $("select[name='field2']");//全部字段下拉框
	var nodeHiddenForStartUserFieldselect = $("select[name='nodeHiddenForStartUserField']");//可写字段下拉框
	if( nodeHiddenForStartUserFieldselect.length < 1){
		alert("没有找到name为nodeHiddenForStartUserField的SELECT！");
	}else{
		if(fields2 != null ){//存在可写字段属性
			fieldArray = fields2.split(",");
			if(field1Select2.length >0 ){
				for( i = 0 ;i < fieldArray.length; i ++){
					var field = fieldArray[i];
					var alloptions = field1Select2[0].options;
					for( j=0;j<alloptions.length;j++){
						if( alloptions[j].value == field ){
							/*var newOpt =document.createElement("OPTION");
							newOpt.value=alloptions[j].value;
							newOpt.text =alloptions[j].text;
							nodeHiddenForStartUserFieldselect[0].add(newOpt);*/  
							nodeHiddenForStartUserFieldselect.append("<option value='"+alloptions[j].value+"'>"+alloptions[j].text+"</option>");
							
							field1Select2[0].remove(j);
							break;
						}
					}
				}
			}else{
				alert("没有找到name为field2的SELECT！");
			}
		}
	}


	var field1CheckBox = $("input[name='processRemindField']");
	//alert(field1CheckBox.length);
	fields = "" ;
	//提醒项
	fields = model.getAttribute("whir:processRemindField");
	if(fields != null ){//存在可写字段属性
		//$("#processRemindFieldPreviewValue").val(fields);
		/*fieldArray = fields.split(",");
		for( i = 0 ;i < fieldArray.length; i ++){
			var field = fieldArray[i];

			var field1CheckBox = $("input[name='processRemindField'][value='" + field + "']");//全部字段下拉框
			//alert(field1CheckBox.length);
			if( field1CheckBox.length > 0){
				field1CheckBox[0].checked = true;
				preview(field1CheckBox[0]);

			}
		}*/ 
		transRemindFieldToText(fields);
	}



	// 办理期限
    //办理期限类型
	var processDeadlineType=model.getAttribute("whir:processDeadlineType");
	if(processDeadlineType!=null&&processDeadlineType=="1"){
	}else{
	  processDeadlineType="0";
	}
    
	if( processDeadlineType == "1" ){
		$("input[name='processDeadlineType'][value='1']")[0].checked=false;
		$("input[name='processDeadlineType'][value='1']")[0].click(); 
	    var deadlineLimit=model.getAttribute("whir:deadlineLimit");
    	var deadlineTimeType=model.getAttribute("whir:deadlineTimeType");
	    $("select[name='deadlineLimit']").val(deadlineLimit);
        $("select[name='deadlineTimeType']").val(deadlineTimeType);
	}else{
		$("#deadlineSpan").hide();
	} 
 
    //办理类taskDealWithClass
	extension = model.getWhirExtensionByName("taskDealWithClass");
	if(extension != null) {

		classname = extension.get("classname");
		saveData = extension.get("saveData");
		saveStauts = extension.get("saveStauts");
		completeData = extension.get("completeData");
		completeStauts = extension.get("completeStauts");

		forminitJsFunName=extension.get("forminitJsFunName");
		formsaveJsFunName=extension.get("formsaveJsFunName");


		$("input[name='formClassName']").attr("value", classname);
		$("input[name='formUpdateData']").attr("value", saveData);
		$("input[name='formUpdateStatus']").attr("value", saveStauts);
		$("input[name='formBackData']").attr("value", completeData);
		$("input[name='formBackStauts']").attr("value", completeStauts);

		$("input[name='forminitJsFunName_text']").attr("value", forminitJsFunName);
		$("input[name='formsaveJsFunName_text']").attr("value", formsaveJsFunName);
	}
    
 
	var completeReadType_val="0";

	if(model.getAttribute("whir:completeReadType")!=null){
         completeReadType_val= model.getAttribute("whir:completeReadType");
	}
    //whir:taskNeedRead		是否需要阅件 ， True/False
	var taskNeedReadRadio = $("input[name='completeReadType'][value='" +completeReadType_val + "']");
	if(taskNeedReadRadio.length > 0) {
		taskNeedReadRadio[0].checked = true; 
	}
 
	showCompleteInfo(completeReadType_val);

	//办理人 participantType 
	var extension = model.getWhirExtensionByName("taskReadParticipantType");//参与者
	
	if( completeReadType_val=="1" &&extension != null ){ 
		var value = extension.get("code");
		var participantTypeInput = $("input[name='participantType'][value='" + value + "']");
		if( participantTypeInput.length > 0 ){
			participantTypeInput[0].checked = false;
			participantTypeInput[0].click();
		}

		//对于特殊的参与者类型还有其他属性
		//participantType
		if(extension.get("code") == "chooseOrgLeader"){
			$("select[name='chooseOrgLeaderType']")[0].value = extension.get("type");

		//lastpassRoundUserOrgLevel
		}else if(extension.get("code") == "initiator"){
			$("select[name='initiatorType']")[0].value = extension.get("type");

		//lastpassRoundUserOrgLevel
		}else if(extension.get("code") == "prevTransactorOrg"){
			//上一活动办理人组织及下级组织AND组织级别prevTransactorOrg
			//组织级别 lastpassRoundUserOrgLevel
			//设置 lastpassRoundUserOrgLevel
			$("select[name='lastParticipantOrgLevel']")[0].value = extension.get("orgLevel");
		}else if(extension.get("code") == "initiatorLeaderOrg"){
			//流程启动人上级组织 AND 职务级别 initiatorLeaderOrg
			//设置 dutyLevelOperate 和 dutyLevel
			$("select[name='dutyLevelOperate']")[0].value = extension.get("dutyLevelOperate");
			$("select[name='dutyLevel']")[0].value = extension.get("dutyLevel");
		}else if(extension.get("code") == "prevTransactorLeader"){
			//上一活动办理人的上级领导
			//设置 dutyLevelOperate 和 dutyLevel
			$("select[name='prevTraLAnd']")[0].value = extension.get("dutyLevelOperateAnd");
			$("select[name='prevDutyLevelOperate']")[0].value = extension.get("dutyLevelOperate");
			$("select[name='prevDutyLevel']")[0].value = extension.get("dutyLevel"); 	 
		} else if(extension.get("code") == "systemRole"){		
			//从系统角色中指定 systemRole
			//设置 partRole 角色 和 partRoleNexus 关系 和 partRoleOrg 组织 和 partRoleOrgLevel 组织级别
			//$("select[name='partRole']")[0].value = extension.get("role");
			//$('#partRole').combobox('setValue',extension.get("role")); 
			setpcomboxval("partRole",extension.get("role"));
			//如果角色删除  默认显示第一个角色 
			setfirstOption("partRole"); 
			var  roleOrg=extension.get("roleOrg");
			if(roleOrg=="-3"||roleOrg=="-6"){
				$("#partRoleOrgLevelID").show();
			}
			$("select[name='partRoleNexus']")[0].value = extension.get("roleNexus");
			//$("select[name='partRoleOrg']")[0].value = extension.get("roleOrg");
			//$('#partRoleOrg').combobox('setValue',roleOrg); 
			setpcomboxval("partRoleOrg",roleOrg);

			$("select[name='partRoleOrgLevel']")[0].value = extension.get("roleOrgLevel");
		}else if(extension.get("code") == "activityTransactor"){
			//活动参与者本人
			$("select[name='dealedActivityId']")[0].value = extension.get("activityId");
		}else if(extension.get("code") == "activityTransactorLeader"){
			//活动参与者上级领导
			$("select[name='dealedActivityId_leader']")[0].value = extension.get("activityId");
		}else if(extension.get("code") == "someGroups"){
			//从选定的群组中选择 someGroups
			//设置  participantGivenGroupName 选定群组名 和 participantGivenGroup 选定群组id 和 partGroupNexus 关系 和 partgGroupOrg  组织  partgGroupOrgLevel  组织级别
			$("textarea[name='participantGivenGroupName']")[0].value = extension.get("givenGroupName");
			$("input[name='participantGivenGroup']")[0].value = extension.get("givenGroup");
			$("select[name='partGroupNexus']")[0].value = extension.get("groupNexus"); 
            var groupOrgVal=extension.get("groupOrg");
			if(groupOrgVal=="-3"||groupOrgVal=="-6"){
				$("#partgGroupOrgLevelID").show();
			}
			//$("select[name='partgGroupOrg']")[0].value = extension.get("groupOrg");
			//$('#partgGroupOrg').combobox('setValue',groupOrgVal);  
			setpcomboxval("partgGroupOrg",groupOrgVal);

			$("select[name='partgGroupOrg']").change();
			$("select[name='partgGroupOrgLevel']")[0].value = extension.get("groupOrgLevel");
	 
			if(groupOrgVal=="-4"){
				$("#addressTypeSpan").show();
			    //相同办公地点的分类
			    $("select[name='workAddressType']")[0].value = extension.get("workAddressType");
			}
		
		}else if(extension.get("code") == "someUsers"){
			//从候选人员中指定 someUsers
			//candidateId 候选人ID candidate 候选人
			$("input[name='candidateId']")[0].value = extension.get("candidateId");
			$("textarea[name='candidate']")[0].value = extension.get("candidate");
		}else if(extension.get("code") == "someScope"){
			//从选定的范围中选择 someScope
			//participantGivenOrgName 选定的范围名称 participantGivenOrg 选定的范围
			$("textarea[name='participantGivenOrgName']")[0].value = extension.get("givenOrgName");
			$("input[name='participantGivenOrg']")[0].value = extension.get("givenOrg");
		}else if(extension.get("code") == "someField"){
			//由表单中的某个字段值决定 someField
			//participantUserField participantUserFieldType 
			$("select[name='participantUserField']")[0].value = extension.get("userField");
			$("select[name='participantUserFieldType']")[0].value = extension.get("userFieldType");
		}else if(extension.get("code") == "setAllTransactors"){
			//指定全部办理人 setAllTransactors
			//allUserId allUser 
			$("input[name='allUserId']")[0].value = extension.get("allUserId");
			$("textarea[name='allUser']")[0].value = extension.get("allUser");
		}else if(extension.get("code") == "setByInterface"){
			//由接口决定 setByInterface
			//passRoundUserClassName 接口类名 passRoundUserMethodName 接口方法名 passRoundInpaNames 接口参数名 passRoundInpaValues 接口参数值
			$("input[name='participantClassName']")[0].value = extension.get("className");
			$("input[name='participantMethodName']")[0].value = extension.get("methodName");
			$("input[name='participantInPaNames']")[0].value = extension.get("inPaNames");
			$("input[name='participantInPavalues']")[0].value = extension.get("inPavalues");
		}
	}
   
	var  formKeyval2=getpcomboxval('formKey'); 
	if(formKeyval2!=null&&formKeyval2!=""){ 	
	}else{ 
       setfirstOption2("formKey");
	} 
	setCheckStyle();
}

//保存
function save(type){
	if(!validateForm("dataForm")){
		  return false;
	} 
    
	if($("#processPackage").val()==""){
		 whir_poshytip($("#checkboxSelect"),workflowMessage_js.packagecannotnull);
		 return false;
	}
	
    ///var  formKey=$('#formKey').combobox('getValue');
	var  formKey=getpcomboxval('formKey');
	var formType_val=getFormType();
    //请选择表单
	if((formType_val == "0"||formType_val == "2")&&formKey==""){
		//需要改
        whir_poshytip($("#formKey").next().find('input').eq(0),workflowMessage_js.workflowselectform);
		return false;
	}

	if(formType_val == "1"&&$("#formAddUrl").val()==""){
        whir_poshytip($("#formAddUrl"),workflowMessage_js.startjspisnull);
		return false;
	}

	if(formType_val == "1"&&$("#formUpdateUrl").val()==""){
        whir_poshytip($("#formUpdateUrl"),workflowMessage_js.updatejspisnull);
		return false;
	}
 
	if(model == null) { 
		whir_alert("不可以保存！",function(){});
		return;
	}
	//alert("保存到记录："+model.getRecordId());
	//ID
	if(/^\d.*/.test($("input[name='id']").attr("value"))){
		//whir_alert("流程id不能以数字打头！",function(){});
	    whir_poshytip($("#id"),workflowMessage_js.processIdcannotstartwith);
		return;
	}
	if(/^ .*/.test($("input[name='id']").attr("value"))){
		whir_poshytip($("#id"),workflowMessage_js.processIdcannotstartwith);
		//whir_alert("流程id不能以空格打头！",function(){});
		return;
	}
	if(/[$%^@&*\'\"、]/.test($("input[name='id']").attr("value"))){
		whir_poshytip($("#id"),'流程id不能有$%^&*\'\"、字符！');
		return;
	}

	if(/[$%^&*\'\"]/.test($("input[name='name']").attr("value"))){
		whir_poshytip($("#name"),'流程名称不能有$%^&*\'\"字符！');
		return;
	}
	if(!/^[-_\da-zA-Z()]*$/.test($("input[name='id']").attr("value"))){
		//whir_poshytip($("#id"),'流程id允许的字符只能是数字、字母和-！');
	    whir_poshytip($("#id"),'流程ID只允许字母、数字、-、_组成！');
		//whir_poshytip($("#id"),'流程id允许的字符只能是数字、字母和-()！');
		return;
	}

	//2015-12-29 流程设置验证流程ID、流程名称
	var recordId =model.getRecordId();
	if(recordId ==null || recordId =='' || recordId =='null'){
		var processId =$('#id').val();
		var processName =$('#name').val();
		var address = whirRootPath + "/ezflowprocess!getProcessIdAndProcessName.action?processId="+processId+"&processName="+processName;
		var isRepeat ='false';
		$.ajax({
			type: 'get',
			url: address,
			async: false,
			dataType: 'json',
			success: function(json){
				isRepeat =json.isRepeat;
			}
		});
		if(isRepeat == 'true'){
			$.dialog.alert('流程名或者流程ID重复',function(){});
			return;
		}
	}

	if($("input[name='id']").attr("value")=="-"){
		whir_poshytip($("#id"),'流程id不能为-');
		return;
	}

	if($("input[name='id']").attr("value").indexOf("(")>=0){
		whir_poshytip($("#id"),'流程id不能包含(');
		return;
	}

	if($("input[name='id']").attr("value").indexOf(")")>=0){
		whir_poshytip($("#id"),'流程id不能包含)');
		return;
	}

    
	var completeReadTypeRadio = $("input[name='completeReadType']:checked");
	var completeReadType_val="0";
	if(completeReadTypeRadio.length > 0 && completeReadTypeRadio[0].value == "1") { 
		completeReadType_val="1";
		//判断参与人必填写项
		var pat = $("input[name='participantType']:checked");
		if(pat.length>0){
			var v1 = pat[0].value; 
			if(v1 == "someGroups" ){
				//从选定的群组中选择 someGroups
				//设置  participantGivenGroupName 选定群组名 和 participantGivenGroup 选定群组id 和 partGroupNexus 关系 和 partgGroupOrg  组织  partgGroupOrgLevel  组织级别
				if(   $("input[name='participantGivenGroup']")[0].value ==  ""      ){
					whir_poshytip($("#participantGivenGroupName"),'从选定的群组中不可以为空！');
					return ;
				}
			}

			if( v1 == "setAllTransactors"){
				//指定全部办理人 setAllTransactors
				//allUserId allUser 
				if($("input[name='allUserId']")[0].value == ""){
					whir_poshytip($("#allUser"),'指定全部办理人不可以为空！');
					return ;
				}
			}
		}
	}

	model.setID($("input[name='id']").attr("value"));
	//model.setAttribute("id",$("input[name='id']").attr("value"));

	//名称
	model.setName($("input[name='name']").attr("value"));
	model.setAttribute("name",$("input[name='name']").attr("value"));

	//流程使用范围
	var processUserScopeInput = $("input[name='processUserScope']");
	if(processUserScopeInput.length > 0) {
		model.setAttribute("whir:processUserScope", processUserScopeInput[0].value);
	}else{
		model.removeAttribute("whir:processUserScope");
	}

	var processType_val= $("input[name='processType']:checked").val() ; 
    model.setAttribute("whir:processType", processType_val);


	//流程使用范围名称
	var processUserScopeInput = $("textarea[name='processUserScopeName']");
	if(processUserScopeInput.length > 0) {
		model.setAttribute("whir:processUserScopeName", processUserScopeInput[0].value)
	}else{
		model.removeAttribute("whir:processUserScopeName");
	}
	
	//流程分类id whir:processPackage

	//var processPackage = $("select[name='processPackage']").attr("value");

	var processPackage = $("input[name='processPackage']").attr("value");

	
	if(processPackage != null) {
		model.setAttribute("whir:processPackage", processPackage);
	}else{
		model.removeAttribute("whir:processPackage");
	}
	
	//流程分类名称 whir:processPackageName
	//var processPackageName = $("select[name='processPackage'] option[selected=true]");

	var processPackageName = $("input[name='processPackageName']");
	if(processPackageName.length > 0 ){
		model.setAttribute("whir:processPackageName", processPackageName[0].value);
	}else{
		model.removeAttribute("whir:processPackageName");
	}

	//其他属性
	//whir: formKey		表单id 或者 某个jsp路径（绝对还是相对）
	//var formKey = $("select[name='formKey']").attr("value");
	if( formType_val=="1"){
		//jsp
		//formKey = $("input[name='startJSPName']").attr("value");
		model.setAttribute("whir:formAddUrl", $("input[name='formAddUrl']").attr("value"));
		model.setAttribute("whir:formUpdateUrl", $("input[name='formUpdateUrl']").attr("value"));
		model.setAttribute("whir:formKey", "-1");
		var mlist = model.getMetaNodeModels();
		for( n =0; n<mlist.length; n++){
				var nmodel = mlist.get(n);
				if( nmodel.type == "USERTASK_NODE" || nmodel.type == "AUTOBACKTASK_NODE" || nmodel.type == "START_NODE"){
					if(nmodel.getAttribute("whir:formKey") != formKey){ 
						nmodel.setAttribute("whir:formKey", "");
						//清除所有字段相关的设置
						nmodel.removeAttribute("whir:nodeWriteField");
						nmodel.removeAttribute("whir:nodeHiddenField");
						nmodel.removeAttribute("whir:protectedField");
						nmodel.removeAttribute("whir:passNodeCommentField");
						nmodel.removeAttribute("whir:nodeCommentField");
						//nmodel.removeWhirExtension("dueDateFinal");
						if(nmodel.type == "USERTASK_NODE" || nmodel.type == "AUTOBACKTASK_NODE" ){
							var extensionArray = nmodel.getWhirExtensionsByName("dueDateFinal");
							//先删除所有的dueDateFinal
							for(i=0;i<extensionArray.length;i++){
								nmodel.removeWhirExtension(extensionArray[i]);
							}
						}

					}
				}
				/*if( nmodel  instanceof UserTaskNodeModel){
					nmodel.setAttribute("whir:formKey", formKey);
				}*/
		}

	}else{
		if(formKey != null) {
			formKey=formKey.substring(0,formKey.length-1); 
			model.setAttribute("whir:formKey", formKey);
			model.removeAttribute("whir:formAddUrl");
			model.removeAttribute("whir:formUpdateUrl");
           //修改了 formKey  才更新其所有的活动
			if(initFormKey!=formKey){
				//修改所有节点的formKey设置
				var mlist = model.getMetaNodeModels();
				for( n =0; n<mlist.length; n++){
					var nmodel = mlist.get(n);
					if( nmodel.type == "USERTASK_NODE" || nmodel.type == "AUTOBACKTASK_NODE" || nmodel.type == "START_NODE"){
						if(nmodel.getAttribute("whir:formKey") != formKey){ 
							nmodel.setAttribute("whir:formKey", formKey);
							//清除所有字段相关的设置
							nmodel.removeAttribute("whir:nodeWriteField");
							nmodel.removeAttribute("whir:nodeHiddenField");
							nmodel.removeAttribute("whir:protectedField");
							nmodel.removeAttribute("whir:passNodeCommentField");
							nmodel.removeAttribute("whir:nodeCommentField");
							//nmodel.removeWhirExtension("dueDateFinal");
							if(nmodel.type == "USERTASK_NODE" || nmodel.type == "AUTOBACKTASK_NODE" ){
								var extensionArray = nmodel.getWhirExtensionsByName("dueDateFinal");
								//先删除所有的dueDateFinal
								for(i=0;i<extensionArray.length;i++){
									nmodel.removeWhirExtension(extensionArray[i]);
								}
							}

						}
					}
 
					if( nmodel.type == "CALLACTIVITY_NODE"){ 
						var extensionArray = nmodel.getWhirExtensionsByName("callFieldJICHEN");
						//先删除所有的dueDateFinal
						for(i=0;i<extensionArray.length;i++){
							nmodel.removeWhirExtension(extensionArray[i]);
						} 
					} 

					/*if( nmodel  instanceof UserTaskNodeModel){
						nmodel.setAttribute("whir:formKey", formKey);
					}*/
				}
			}
		}else{
			model.removeAttribute("whir:formKey");
		}
	}

	model.setAttribute("whir:formType", formType_val);


    // 办理期限
    //办理期限类型 
	var processDeadlineType = $("input[name='processDeadlineType']:checked");
	var pDeadlineValue=processDeadlineType[0].value;	 
	model.setAttribute("whir:processDeadlineType",pDeadlineValue);


	if(pDeadlineValue == 1 ){
		model.setAttribute("whir:deadlineLimit",$("#deadlineLimit").val());
		model.setAttribute("whir:deadlineTimeType",$("#deadlineTimeType").val()); 
	}
  
	//移动办公 
	///pad端
	var processCanPADCheck = $("input[name='processCanPAD']:checked");
	if(processCanPADCheck.length > 0) {
		model.setAttribute("whir:mobileStatus", "1");
	}else{
		model.setAttribute("whir:mobileStatus","0");
	}
    //手机端
	var processCanMobilePhoneCheck = $("input[name='processCanMobilePhone']:checked");
	if(processCanMobilePhoneCheck.length > 0) {
		model.setAttribute("whir:mobilePhoneStatus", "1");
	}else{
		model.setAttribute("whir:mobilePhoneStatus","0");
	}

		//手机端 
	var processFormShowAtMobileCheck = $("input[name='processFormShowAtMobile']:checked");
	if(processFormShowAtMobileCheck.length > 0) {
		model.setAttribute("whir:processFormShowAtMobile", "1");
	}else{
		model.setAttribute("whir:processFormShowAtMobile","0");
	}


	//whir:processNeedDossier		是否需要归档，  true /false
	var processNeedDossierRadio = $("input[name='processNeedDossier']:checked");
	if(processNeedDossierRadio.length > 0) {
		model.setAttribute("whir:processNeedDossier", processNeedDossierRadio[0].value);
	}else{
		model.removeAttribute("whir:processNeedDossier");
	}


	//whir:processAutoNextWithNullUser  活动参与者为空自动跳转下一步
	var processAutoNextWithNullUserRadio = $("input[name='processAutoNextWithNullUser']:checked");
	if(processAutoNextWithNullUserRadio.length > 0) {
		model.setAttribute("whir:processAutoNextWithNullUser", processAutoNextWithNullUserRadio[0].value);
	}else{
		model.removeAttribute("whir:processAutoNextWithNullUser");
	}


	//whir:processNeedPrint		发起人是否可以打印，  true /false
	var processNeedPrintRadio = $("input[name='processNeedPrint']:checked");
	if(processNeedPrintRadio.length > 0) {
		model.setAttribute("whir:processNeedPrint", processNeedPrintRadio[0].value);
	}else{
		model.removeAttribute("whir:processNeedPrint");
	} 

	//流程办结后可以导出word模板和下载
	/*var processPrintExportTempRadio = $("input[name='processPrintExportTemp']:checked");
	if(processPrintExportTempRadio.length > 0) {
		model.setAttribute("whir:processPrintExportTemp", processPrintExportTempRadio[0].value)
	}else{
		//model.removeAttribute("whir:processPrintExportTemp");
		model.setAttribute("whir:processPrintExportTemp", "false");
	}*/

	//whir:processCommentIsNull		批示意见是否可以为空  true/false
	var processCommentIsNullRadio = $("input[name='processCommentIsNull']:checked");
	if(processCommentIsNullRadio.length > 0) {
		model.setAttribute("whir:processCommentIsNull", processCommentIsNullRadio[0].value);
	}else{
		model.removeAttribute("whir:processCommentIsNull");
	}
	//whir:commentSortType
	var commentSortTypeSelect = $("select[name='commentSortType']");
	if(commentSortTypeSelect.length > 0) {
		model.setAttribute("whir:commentSortType", commentSortTypeSelect[0].value)
	}else{
		model.removeAttribute("whir:commentSortType");
	}


    
    var orgcommentSortTypeSelect = $("select[name='orgcommentSortType']");
	if(orgcommentSortTypeSelect.length > 0) {
		model.setAttribute("whir:orgcommentSortType", orgcommentSortTypeSelect[0].value)
	}else{
		model.removeAttribute("whir:orgcommentSortType");
	}


	//字段联动
	var relationTrigSelect = $("select[name='relationTrig']");
	if(relationTrigSelect.length > 0) {
		model.setAttribute("whir:relationTrig", relationTrigSelect[0].value)
	}else{
		model.removeAttribute("whir:relationTrig");
	}

	/*
	//字段联动
	var formClassnameSelect = $("input[name='formClassName']");
	if(formClassnameSelect.length > 0) {
		model.setAttribute("whir:formClassName", formClassnameSelect[0].value)
	}else{
		model.removeAttribute("whir:formClassName");
	}*/


	//whir:processCommentIsNull		保留退回意见  true/false
	var processKeepBackCommentRadio = $("input[name='processKeepBackComment']:checked");
	if(processKeepBackCommentRadio.length > 0) {
		model.setAttribute("whir:processKeepBackComment", processKeepBackCommentRadio[0].value)
	}else{
		model.removeAttribute("whir:processKeepBackComment");
	}

	//whir:processEndMail		结束邮件提醒  true/false
	var processEndMailRadio = $("input[name='processEndMail']:checked");
	if(processEndMailRadio.length > 0) {
		model.setAttribute("whir:processEndMail", processEndMailRadio[0].value)
	}else{
		model.removeAttribute("whir:processEndMail");
	}

	//whir:processCommentAcc		批示意见上传附件  true/false
	var processCommentAccRadio = $("input[name='processCommentAcc']:checked");
	if(processCommentAccRadio.length > 0) {
		model.setAttribute("whir:processCommentAcc", processCommentAccRadio[0].value)
	}else{
		model.removeAttribute("whir:processCommentAcc");
	}

	//whir:processKeepReSubmitComment 保留退回后重新提交前的批示意见 true/false
	var processKeepReSubmitCommentRadio = $("input[name='processKeepReSubmitComment']:checked");
	if(processKeepReSubmitCommentRadio.length > 0) {
		model.setAttribute("whir:processKeepReSubmitComment", processKeepReSubmitCommentRadio[0].value)
	}else{
		model.removeAttribute("whir:processKeepReSubmitComment");
	}

	//办理查阅查看人ID
	var processCanReadEmpInput = $("input[name='processCanReadEmp']");
	if( processCanReadEmpInput.length > 0 ){
		model.setAttribute("whir:processCanReadEmp", processCanReadEmpInput[0].value)
	}else{
		model.removeAttribute("whir:processCanReadEmp");
	}
	
	//办理查阅查看人显示
	var processCanReadEmpNameTextarea = $("textarea[name='processCanReadEmpName']");
	if( processCanReadEmpNameTextarea.length > 0 ){
		model.setAttribute("whir:processCanReadEmpName", processCanReadEmpNameTextarea[0].value)
	}else{
		model.removeAttribute("whir:processCanReadEmpName");
	}
	
	//办理查阅维护人ID
	var processCanModifyEmpInput = $("input[name='processCanModifyEmp']");
	if( processCanModifyEmpInput.length > 0 ){
		model.setAttribute("whir:processCanModifyEmp", processCanModifyEmpInput[0].value)
	}else{
		model.removeAttribute("whir:processCanModifyEmp");
	}

	//办理查阅维护人显示
	var processCanModifyEmpNameTextarea = $("textarea[name='processCanModifyEmpName']");
	if( processCanModifyEmpNameTextarea.length > 0 ){
		model.setAttribute("whir:processCanModifyEmpName", processCanModifyEmpNameTextarea[0].value)
	}else{
		model.removeAttribute("whir:processCanModifyEmpName");
	}

	//流程管理员ID
	var processAdministratorInput = $("input[name='processAdministrator']");
	if( processAdministratorInput.length > 0 ){
		
		model.setAttribute("whir:processAdministrator", processAdministratorInput[0].value)
	}else{
		model.removeAttribute("whir:processAdministrator");
	}

	//流程管理员显示
	var processAdministratorNameTextarea = $("textarea[name='processAdministratorName']");
	if( processAdministratorNameTextarea.length > 0 ){
		model.setAttribute("whir:processAdministratorName", processAdministratorNameTextarea[0].value)
	}else{
		model.removeAttribute("whir:processAdministratorName");
	}
	
	//流程描述
	//var documentation = processDescription_html.getHTML();//$("textarea[name='documentation']").attr("value");
	var o_Editor = document.getElementById("newedit").contentWindow;
	var documentation =o_Editor.getHTML(); 

	if(documentation != null) {
		model.setDocumentation(documentation);
	}else{
		model.setDocumentation("");
	}
	
	//whir:nodeWriteField	发起时不填的字段  ,fieldid,,fieldid,…… //取出select下的所有option
	var fields = "" ;
	var nodeWriteFieldSelect = $("select[name='nodeWriteField']");
	if( nodeWriteFieldSelect.length > 0 ){
		var nodeWriteFieldOptions = nodeWriteFieldSelect[0].options;
		for(i =0 ;i < nodeWriteFieldOptions.length ; i++){
			fields = fields + "," + nodeWriteFieldOptions[i].value + ",";
		}
		
	}
	if( fields != "" ){
		model.setAttribute("whir:nodeWriteField",fields);
	}else{
		model.removeAttribute("whir:nodeWriteField");
	}


	var fields2 = "" ;
	var nodeHiddenForStartUserFieldSelect = $("select[name='nodeHiddenForStartUserField']");
	if( nodeHiddenForStartUserFieldSelect.length > 0 ){
		var nodeWriteFieldOptions = nodeHiddenForStartUserFieldSelect[0].options;
		for(i =0 ;i < nodeWriteFieldOptions.length ; i++){
			fields2 = fields2 + "," + nodeWriteFieldOptions[i].value + ",";
		}
		
	}
	if( fields2 != "" ){
		model.setAttribute("whir:nodeHiddenForStartUserField",fields2);
	}else{
		model.removeAttribute("whir:nodeHiddenForStartUserField");
	}



	//附加属性 办理类 taskDealWithClass
	extension = model.getWhirExtensionByName("taskDealWithClass");
	if(extension == null) {
		extension = model.newWhirExtension("taskDealWithClass");
		model.addWhirExtension(extension);
	}
	extension.set("classname", $("input[name='formClassName']").attr("value"));
	extension.set("saveData", $("input[name='formUpdateData']").attr("value"));
	extension.set("saveStauts", $("input[name='formUpdateStatus']").attr("value"));
	extension.set("completeData", $("input[name='formBackData']").attr("value"));
	extension.set("completeStauts", $("input[name='formBackStauts']").attr("value"));	
	extension.set("forminitJsFunName", $("input[name='forminitJsFunName_text']").attr("value"));
	extension.set("formsaveJsFunName", $("input[name='formsaveJsFunName_text']").attr("value"));


	//提醒项
	var fields = "";
	/*var field1CheckBox = $("input[name='processRemindField']:checked");//全部字段下拉框
	if( field1CheckBox.length > 0 ){
		for (i=0;i<field1CheckBox.length ;i++ ){
			fields = fields + field1CheckBox[i].value + ",";
		}
		
	}*/
	//fields = $("#processRemindFieldPreviewValue").val(); 
	fields=transRemindMutual( $("#processRemindFieldPreview").val(),text_field_Map);

	if(fields.indexOf(rm_start+"condi_processName"+rm_end)<0){
		fields=fields+rm_start+"condi_processName"+rm_end;
	}
	if(fields.indexOf(rm_start+"condi_start_userName"+rm_end)<0){
		fields=rm_start+"condi_start_userName"+rm_end+fields;
	}
 

	if( fields != "" ){
		model.setAttribute("whir:processRemindField",fields);
	}else{
		model.removeAttribute("whir:processRemindField");
	}
 
    model.setAttribute("whir:completeReadType",completeReadType_val); 
	var extension = model.getWhirExtensionByName("taskReadParticipantType");//参与者
	if( extension != null ){
	}else{
		extension = model.newWhirExtension("taskReadParticipantType");
		model.addWhirExtension(extension);  
	}

	//办理人 participantType 
	var participantTypeInput = $("input[name='participantType']:checked");

	if( participantTypeInput.length > 0 ){
		for( i=0;i<participantTypeInput.length;i++){
			extension.set("code",participantTypeInput[i].value);
			//对于特殊的参与者类型还有其他属性
			//lastParticipantOrgLevel
		    if(extension.get("code") == "initiator"){
				extension.set("type",$("select[name='initiatorType']")[0].value);
			//lastpassRoundUserOrgLevel
			} else if(extension.get("code") == "systemRole"){

			   // var  partRoleval=$('#partRole').combobox('getValue');
			 	// var  partRoleOrgval=$('#partRoleOrg').combobox('getValue');

				var  partRoleval=getpcomboxval("partRole");
			    var  partRoleOrgval=getpcomboxval("partRoleOrg");

				//从系统角色中指定 systemRole
				//设置  partRole 角色 和 partRoleNexus 关系 和 partRoleOrg 组织 和 partRoleOrgLevel 组织级别
				//extension.set("role",$("select[name='partRole']")[0].value);
				extension.set("role",partRoleval);
				extension.set("roleNexus",$("select[name='partRoleNexus']")[0].value);
				extension.set("roleOrg",partRoleOrgval);
				extension.set("roleOrgLevel",$("select[name='partRoleOrgLevel']")[0].value);
			} else if(extension.get("code") == "someGroups"){
				//从系统角色中指定 someGroups
				//设置  participantGivenGroupName 选定群组名 和 participantGivenGroup 选定群组id 和 partGroupNexus 关系 和 partgGroupOrg  组织  partgGroupOrgLevel  组织级别
				extension.set("givenGroupName",$("textarea[name='participantGivenGroupName']")[0].value);
				extension.set("givenGroup",$("input[name='participantGivenGroup']")[0].value);
				extension.set("groupNexus",$("select[name='partGroupNexus']")[0].value);
				var  partgGroupOrgval=getpcomboxval("partgGroupOrg");
				//var  partgGroupOrgval=$('#partgGroupOrg').combobox('getValue');
				//extension.set("groupOrg",$("select[name='partgGroupOrg']")[0].value);
				extension.set("groupOrg",partgGroupOrgval);
				extension.set("groupOrgLevel",$("select[name='partgGroupOrgLevel']")[0].value); 

				//相同办公地点的分类
			    extension.set("workAddressType",$("select[name='workAddressType']")[0].value);

				//必须 为true
		        extension.set("groupNeedAllSend","true");

			}else if(extension.get("code") == "someUsers"){
				//从候选人员中指定 someUsers
				//candidateId 候选人ID candidate 候选人
				extension.set("candidateId",$("input[name='candidateId']")[0].value);
				extension.set("candidate",$("textarea[name='candidate']")[0].value);
			}else if(extension.get("code") == "someScope"){
				//从选定的范围中选择 someScope
				//participantGivenOrgName 选定的范围名称 participantGivenOrg 选定的范围
				extension.set("givenOrgName",$("textarea[name='participantGivenOrgName']")[0].value);
				extension.set("givenOrg",$("input[name='participantGivenOrg']")[0].value);
			}else if(extension.get("code") == "someField"){
				//由表单中的某个字段值决定 someField
				//participantUserField participantUserFieldType 
				extension.set("userField",$("select[name='participantUserField']")[0].value);
				extension.set("userFieldType",$("select[name='participantUserFieldType']")[0].value);
			}else if(extension.get("code") == "setAllTransactors"){
				//指定全部办理人 setAllTransactors
				//allUserId allUser 
				extension.set("allUserId",$("input[name='allUserId']")[0].value);
				extension.set("allUser",$("textarea[name='allUser']")[0].value);
			}else if(extension.get("code") == "setByInterface"){
				//由接口决定 setByInterface
				//passRoundUserClassName 接口类名 passRoundUserMethodName 接口方法名 passRoundInpaNames 接口参数名 passRoundInpaValues 接口参数值
				extension.set("className",$("input[name='participantClassName']")[0].value);
				extension.set("methodName",$("input[name='participantMethodName']")[0].value);
				extension.set("inPaNames",$("input[name='participantInPaNames']")[0].value);
				extension.set("inPavalues",$("input[name='participantInPavalues']")[0].value);
			}else if(extension.get("code") == "prevTransactorLeader"){ 
				//上一活动办理人的上级领导 
				extension.set("dutyLevelOperateAnd",$("select[name='prevTraLAnd']")[0].value);
				extension.set("dutyLevelOperate",$("select[name='prevDutyLevelOperate']")[0].value);
				extension.set("dutyLevel",$("select[name='prevDutyLevel']")[0].value); 
			}else if(extension.get("code") == "allDealUser"){
				//所有经办人 
				extension.set("type","allDealUser");
			}
		}
	}
    //1 业务流程    0：随机流程     2：半自由流程     3： 完全自由流程
	opener.xiorkFlow.xiorkFlowWrapper.setChanged(true);
    if(processType_val==0){
	    model.removeAll();
	}else{
	    model.showAllButton();
		if(processType_val==2||processType_val==3){
			model.hiddenButtonWithProcessType2();
		}
	}
	window.close();
}



 
function transferOptions(srcObj,desObj){
   if($("#"+srcObj+" option:selected").length>0){
　　　 $("#"+srcObj+" option:selected").each(function(){
　　　　　  $("#"+desObj).append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
　　　　　  $(this).remove();　
　　　 })
   } else { 
      $.dialog.alert(workflowMessage_js.pleasechoossefield,function(){});
　 } 
}


function transferOptionsAll(srcObj,desObj){ 
    if($("#"+srcObj+" option").length>0){
　　　 $("#"+srcObj+" option").each(function(){ 
　　　　　  $("#"+desObj).append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
　　　　　  $(this).remove();　
　　　 })
   } else {
　　　 $.dialog.alert(workflowMessage_js.pleasechoossefield,function(){});
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
	　　　  })
		} 
	}catch(e){
	}	
}
 
/**
改变选择的表单触发的事件
*/
function changeFormKey(){   
	var formKey= getpcomboxval('formKey');   
    if(formKey!=null){
		$("#formType").val(formKey.substring(formKey.length-1));
		formKey=formKey.substring(0,formKey.length-1);
		//alert("formKeyformKey:"+formKey);  
	} 
	var formType_val=getFormType();
	var result = $.ajax({
	   url: "/defaultroot/ezflowprocess!getFieldByForm.action?formKey="+encodeURIComponent(formKey)+"&formType="+formType_val+"&moduleId="+$("#moduleId").val(),
	   async: false
	}).responseXML;
	
	//可写字段
	var field1Select = $("select[name='field']");//全部字段下拉框
	//清空
	if(field1Select.length >0 ){
		var alloptions = field1Select[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			field1Select[0].remove(j);
		}
	}

	var nodeWriteFieldSelect = $("select[name='nodeWriteField']");//可写字段下拉框
	//清空
	if(nodeWriteFieldSelect.length >0 ){
		var alloptions = nodeWriteFieldSelect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			nodeWriteFieldSelect[0].remove(j);
		}
	}
	
    var participantUserFieldselect = $("select[name='participantUserField']");//
	//清空
	if(participantUserFieldselect.length >0 ){
		var alloptions = participantUserFieldselect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			participantUserFieldselect[0].remove(j);
		}
	} 
	
    var field1Select2 = $("select[name='field2']");//全部字段下拉框
	//清空
	if(field1Select2.length >0 ){
		var alloptions = field1Select2[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			field1Select2[0].remove(j);
		}
	}

	var nodeHiddenForStartUserFieldSelect = $("select[name='nodeHiddenForStartUserField']");//可写字段下拉框
	//清空
	if(nodeHiddenForStartUserFieldSelect.length >0 ){
		var alloptions = nodeHiddenForStartUserFieldSelect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			nodeHiddenForStartUserFieldSelect[0].remove(j);
		}
	}
	
	$("#processRemindFieldDiv").html("");
	$("#processRemindFieldPreview").val("");
	$("#processRemindFieldPreviewValue").val("");
	
	$("#processRemindFieldDiv").append("<input name='processRemindField' type='checkbox' onclick='preview(this)' value='condi_start_userName' text='流程发起人'>流程发起人"); 
    $("#processRemindFieldDiv").append("<input name='processRemindField' type='checkbox' onclick='preview(this)' value='condi_processName' text='流程名称'>流程名称");
    text_field_Map.clear();
	text_field_Map.put(rm_start+"流程名称"+rm_end,rm_start+"condi_processName"+rm_end); 
	text_field_Map.put(rm_start+"流程发起人"+rm_end,rm_start+"condi_start_userName"+rm_end); 

    field_text_Map.clear();
	field_text_Map.put(rm_start+"condi_processName"+rm_end,rm_start+"流程名称"+rm_end); 
	field_text_Map.put(rm_start+"condi_start_userName"+rm_end,rm_start+"流程发起人"+rm_end); 
 
 
	var inputnum = 0;
	//加载
	if(field1Select.length >0 ){
		$(result).find("field").each(function(i){    
			var fieldid=$(this).children("fieldid").text();   //取文本  
			var fieldtext=$(this).children("fieldtext").text();  //取文本 或者 $("id" , xml).text();    
			
			var fieldtype=$(this).children("fieldtype").text(); 
			var tabletype =$(this).children("tabletype").text();
			/*var newOpt =document.createElement("OPTION");
			newOpt.value=fieldid;
			newOpt.text =fieldtext;


			var newOpt2 =document.createElement("OPTION");
			newOpt2.value=fieldid;
			newOpt2.text =fieldtext;*/
			//会议转批新建新流程不需要
			if($("#moduleId").val()=="16"){
			}else{
				if(fieldtype != 401){
					// field1Select[0].add(newOpt); 
					//field1Select2[0].add(newOpt2); 
					field1Select.append("<option value='"+fieldid+"'>"+fieldtext+"</option>");
					field1Select2.append("<option value='"+fieldid+"'>"+fieldtext+"</option>");
				}
			}

			//密码输入102、word编辑116、excel编辑117、115附件上传、118wps编辑  不可选
			//单选弹出选择404、多选弹出选择405、单选组织212、多选组织214、关联保存402、金额301、金额大写302  可选
 
			/* 单行文本 101    多行文本 110   自动编号 111    单选 103     多选 104 
			   单选弹出选择 404   多选弹出选择 405    单选人 210   多选人 211    单选组织 212  
			   多选组织 214    下拉框 105    时间 107  日期 108   时间日期 109  
			   金额  301  金额大写 302\
			   
			   计算字段  203       子表字段合计 606   、单选人（本组织）704     多选人（本组织）未支持 705
			*/ 
			if(fieldtype == 101||fieldtype == 110||fieldtype == 111||fieldtype == 103||fieldtype == 104||fieldtype == 404||fieldtype == 405
				 ||fieldtype == 210||fieldtype == 211||fieldtype == 212||fieldtype == 214||fieldtype == 105||fieldtype == 107
				 ||fieldtype == 108||fieldtype == 109||fieldtype == 301||fieldtype == 302||fieldtype== 203||fieldtype== 606||fieldtype== 704||fieldtype== 705){ 
				/*if(fieldtype > 100 &&  fieldtype < 200 && fieldtype != 102  && fieldtype != 116  && fieldtype != 117  && fieldtype != 115  && fieldtype != 118 ||( 
				fieldtype == 404 ||   fieldtype == 405  ||   fieldtype == 212 ||   fieldtype == 214 ||   fieldtype == 402 ||   fieldtype == 301 ||   fieldtype == 302
				) ){*/
				inputnum ++;
				if(inputnum % 8 == 0){
					//$("#processRemindFieldDiv").append("<br/>");
				}
				//只显示主表字段
				if(tabletype =='1'){
					$("#processRemindFieldDiv").append("<input name='processRemindField' type='checkbox' onclick='preview(this)' value='"+fieldid+"' text='"+fieldtext+"'>"+fieldtext); 
					field_text_Map.put(rm_start+""+fieldid+""+rm_end,rm_start+""+fieldtext+""+rm_end);
					text_field_Map.put(rm_start+""+fieldtext+""+rm_end,rm_start+""+fieldid+""+rm_end);
				}
			}
 
			 //202 登入人姓名 fieldtype == "202" ||      fieldtype == ("215")||
			if(fieldtype == ("210")||fieldtype == ("211")||fieldtype == ("704")||fieldtype == ("705")){ 
                 //由字段决定 加字段 
				 $("#participantUserField").append("<option value='"+fieldid+"'>"+fieldtext+"</option");
			}
		});    
   }
   //字段联动
	var relationTrigSelect = $("select[name='relationTrig']");//字段联动下拉框
	//清空
	if(relationTrigSelect.length >0 ){
		var alloptions = relationTrigSelect[0].options;
		for( j=alloptions.length-1;j>=1;j--){
			relationTrigSelect[0].remove(j);
		}
	}

	if( relationTrigSelect.length > 0 ){
		$(result).find("RelaTrig").each(function(i){    
			var fieldid=$(this).children("RelaTrigId").text();   //取文本  
			var fieldtext=$(this).children("RelaTrigText").text();  //取文本 或者 $("id" , xml).text();    
			
			/*var newOpt =document.createElement("OPTION");
			newOpt.value=fieldid;
			newOpt.text =fieldtext;
			relationTrigSelect[0].add(newOpt);*/

			relationTrigSelect.append("<option value='"+fieldid+"'>"+fieldtext+"</option>");
		});    
	}
}


function preview(ob){ 
   /*	$("#processRemindFieldPreview").insertContent("插入的内容"); 
    // $(obj).removeAttr("checked");
        $(ob).attr("checked", false);     
		alert(1); 
    return fasle;*/
    var  nowText=$(ob).attr("text"); 
    if(ob.checked){
		 $("#processRemindFieldPreview").insertContent(rm_start+""+nowText+""+rm_end);

		 // $("#processRemindFieldPreview").val($("#processRemindFieldPreview").val()+"["+nowText+"]");
	}else{
		 $("#processRemindFieldPreview").val($("#processRemindFieldPreview").val().replace(rm_start+""+nowText+""+rm_end,"")); 
	} 
	/*if(ob.checked){
		$("#processRemindFieldPreviewValue").val($("#processRemindFieldPreviewValue").val()+","+$(ob).val()+",");
		$("#processRemindFieldPreview").val($("#processRemindFieldPreview").val()+"["+$(ob).attr("text")+"]");
	}else{
		$("#processRemindFieldPreview").val($("#processRemindFieldPreview").val().replace("["+$(ob).attr("text")+"]",""));
		var v1 = $("#processRemindFieldPreviewValue").val(); 
		$("#processRemindFieldPreviewValue").val($("#processRemindFieldPreviewValue").val().replace(","+$(ob).val()+",",","));	 
	}*/
}

/**转化提醒字段**/
function transRemindFieldToText(fields){ 
	//存在可写字段属性
	//$("#processRemindFieldPreviewValue").val(fields);
	var varFields="";
	if(fields.indexOf(rm_start+"")>=0||fields.indexOf(""+rm_end)>=0){
		varFields=fields;
	}else{ 
		fieldArray = fields.split(",");
		for( i = 0 ;i < fieldArray.length; i ++){
			var field = fieldArray[i]; 
			if(field!=""){
			   varFields+=rm_start+""+field+""+rm_end; 
			}
		}
	} 
    
	//默认加流程启动人  与流程名称
    if(varFields.indexOf(rm_start+"condi_processName"+rm_end)<0){
		varFields=varFields+rm_start+"condi_processName"+rm_end;
	}
	if(varFields.indexOf(rm_start+"condi_start_userName"+rm_end)<0){
		varFields=rm_start+"condi_start_userName"+rm_end+varFields;
	}


	var fieldTexts=transRemindMutual(varFields,field_text_Map,"1");
    $("#processRemindFieldPreview").val(fieldTexts);  
} 


/***转化提醒字段**/
function transRemindMutual(contents,textfieldMap,type){  
    var  infoList=new List();
	var  tempIndex = 0;
	var  tempIndex2=0; 
	//List fieldIdList=new ArrayList(); 
	for (var index = 0;contents.indexOf(rm_start+"",index) >= 0; index = tempIndex + 1) {
	   tempIndex = contents.indexOf(rm_start+"", index);
	   tempIndex2=contents.indexOf(""+rm_end, tempIndex+1);
	   if (tempIndex2 < 0) {
		   break;
	   } 
	   var fileName = contents.substring(tempIndex, tempIndex2+1); 
	   infoList.add(fileName); 
	}

     
	var  size=infoList.size(); 
	var key="";
	for (var i = 0; i <size; i++) {
		key=infoList.get(i);  
		if(key.length>2){
			//当type 为 1 时 checkbox 选中
			if(type!=null&&type=="1"){
				var field1CheckBox = $("input[name='processRemindField'][value='" + key.substring(1,key.length-1)+ "']");//全部字段下拉框
				if( field1CheckBox.length > 0){
					field1CheckBox[0].checked = true;
				}
			}
			contents=contents.replaceAllString(key,textfieldMap.get(key)==null?"":textfieldMap.get(key));
		}
	}   
	return contents;  
}

/*
上传自定义类
*/
function  formClassUpload(json){
     var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 //$("#formClassName").val(file_name+file_type);
	 $("#formClassName").val(file_name);
}


/**
切换div
*/
function  changePanle(flag){
	$(".tag_aon").removeClass("tag_aon");
	$("#Panle"+flag).addClass("tag_aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();

}


/**
渲染checkbox
*/
function  setCheckStyle(){ 
}

/**
 是否显示打印下载选项
*/
function  showExportTemp(obj){
	if(obj.checked){
		$("#ExportTempSpan").show();
	}else{
		$("#ExportTempSpan").hide();
	}
}
 

 //办理期限使用的js
function clickPressType(value) {
	if(value == 0) {
		$("#deadlineSpan").hide(); 
	} else if(value == 1) {
		$("#deadlineSpan").show(); 
	} else if(value == 2) { 
	}
}



//初始化ext combox
function  initExt(){ 
    //角色选择  角色 
	 var cb1 = Ext.create('Ext.form.field.ComboBox', {
		id : 'formKey_extId',  
        typeAhead: true,
        transform: 'formKey',
		hiddenName:'formKey',
		name:'formKeyName',
        width: 300, 
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){
					//changeChannel(this); 
					 changeFormKey(); 
				}
			}
		}
    }); 

	//角色选择  角色 
	 var cb1 = Ext.create('Ext.form.field.ComboBox', {
		id : 'partRole_extId',  
        typeAhead: true,
        transform: 'partRole',
        width: 360,
        forceSelection: false
    }); 

	//角色选择  组织
	 var cb2 = new Ext.form.ComboBox({
		id : 'partRoleOrg_extId',  
		typeAhead: true,
		triggerAction: 'all',
		transform:'partRoleOrg',
		width:360,
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){
					//changeChannel(this); 
					 roleOrgchange('partRoleOrg','partRoleOrgLevelID','');
					 
				}
			}
		}
	}); 
	 

   //群组  组织
	var cb3= new Ext.form.ComboBox({
		id : 'partgGroupOrg_extId',  
		typeAhead: true,
		triggerAction: 'all',
		transform:'partgGroupOrg',
		width:360,
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){  
					 roleOrgchange('partgGroupOrg','partgGroupOrgLevelID','addressTypeSpan');
				}
			}
		}
	});   
}


function  initChange(){
   $('#formKey').change(function(){changeFormKey();});  
   $('#partRoleOrg').change(function(){roleOrgchange('partRoleOrg','partRoleOrgLevelID','');});  
   $('#partgGroupOrg').change(function(){roleOrgchange('partgGroupOrg','partgGroupOrgLevelID','addressTypeSpan');});  
}

/*
下拉框的值
*/
function getpcomboxval(name){
	var value="";
    if(p_comboxType=="ext"){
		value=whirExtCombobox.getValue(name+'_extId');   
	}else{
	    value=$("#"+name).val(); 
	}
	return value
}

/*
设置下拉框的值
*/
function setpcomboxval(name,value){
    if(p_comboxType=="ext"){
		whirExtCombobox.setValue(name+'_extId', value);
	}else{
	    $("#"+name).val(value);
	}
}

/**

*/
function  setfirstOption(name){
   if(p_comboxType=="ext"){   
	    if(Ext.getCmp(name+"_extId").getValue()==Ext.getCmp(name+"_extId").getRawValue()){ 
			 var range = Ext.getCmp(name+"_extId").getStore().getRange();  
			 if(range != null && range.length>0){  
				 var ssssss = range[0].data;
				 var value= ssssss.field1;  
				 Ext.getCmp(name+"_extId").setValue(value); 
			 }    
		}
   }else{ 
   }  
}


function  setfirstOption2(name){
   if(p_comboxType=="ext"){   
		var range = Ext.getCmp(name+"_extId").getStore().getRange();  
		if(range != null && range.length>0){  
			var ssssss = range[0].data;
			var value= ssssss.field1; 
			Ext.getCmp(name+"_extId").setValue(value);
			changeFormKey();
		}    
   }else{
   
   }  
}

// obj  组织的selecte     levelId  组织级别     addressTypeSpan 相同办公地点的td
function roleOrgchange(selectName,levelTd,addressTypeSpan){
  var  selectValue=getpcomboxval(selectName);
   //var selectValue=obj.value;
   if(selectValue=="-3"||selectValue=="-6"){ 
      $("#"+levelTd).show();   	 	  
   }else{     
	  $("#"+levelTd).hide();   
   }
   
   //相同办公地点
   if(addressTypeSpan!=null&&addressTypeSpan!=""){
	   if(selectValue=="-4"){
		  $("#"+addressTypeSpan).show();  
	   }else{
		  $("#"+addressTypeSpan).hide(); 
	   }
   }
}


//设置参与者使用的js
function clickParticipantType(obj) {
	 if(obj.value == "setAllTransactors") {
		$("#hxr").hide();//document.all.hxr.style.display = "none";
		$("#qbblr").show();//document.all.qbblr.style.display = "";
		$("#bdzd").hide();//document.all.bdzd.style.display = "none";
		$("#participantRole").hide();//document.all.participantRole.style.display = "none";
		$("#zdzz").hide();//document.all.zdzz.style.display = "none";
		$("#xdqz").hide();//document.all.xdqz.style.display = "none";
	} else if(obj.value == "someField") {
		$("#hxr").hide();
		$("#qbblr").hide();
		$("#bdzd").show();
		$("#participantRole").hide();
		$("#zdzz").hide();
		$("#xdqz").hide();		 
	} else if(obj.value == "systemRole") {
		$("#hxr").hide();
		$("#qbblr").hide();
		$("#bdzd").hide();
		$("#participantRole").show();
		$("#zdzz").hide();
		$("#xdqz").hide();	
	} else if(obj.value == "someGroups") {
		$("#hxr").hide();
		$("#qbblr").hide();
		$("#bdzd").hide();
		$("#participantRole").hide();
		$("#zdzz").hide();
		$("#xdqz").show();	 

 	}else{
		$("#hxr").hide();
		$("#qbblr").hide();
		$("#bdzd").hide();
		$("#participantRole").hide();
		$("#zdzz").hide();
		$("#xdqz").hide();	
	}
	if(obj.value == "setByInterface") {
		$("#participantinterfacetr").show();
	} else {
		$("#participantinterfacetr").hide();
	}
}
 


/**
上传办件接口
*/
function participantClassNameJs(json){
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#participantClassName").val(file_name+file_type);
}


function  showCompleteInfo(value){
     if(value=="1"){
		 $("#completeReadInfo").show();
	 }else{
		 $("#completeReadInfo").hide();
	 }
}

