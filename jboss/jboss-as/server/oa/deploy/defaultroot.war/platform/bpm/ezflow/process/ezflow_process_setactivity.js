//当前属性页面编辑的元素对象
var model;
var initDataStatus="0";

/**
切换div
*/
function  changePanle(flag){
	$(".tag_aon").removeClass("tag_aon");
	$("#Panle"+flag).addClass("tag_aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
}


//保存，将当前属性页面设置项保存到对象属性中
function save(type) {
    if(!validateForm("dataForm")){
			  return false;
	}
 
	if(model == null) {
		whir_alert("不可以保存！",function(){});
		return;
	}

    //activiti:formKey		表单id 或者 某个jsp路径
	var formKeyval0 = $("select[name='formKey']").attr("value");  

	var  subType_v=$("#subType").val();
    //var  formKeyval=$('#formKey').combobox('getValue');
 
	if(formKeyval0 != null&&formKeyval0!="") {
	}else{
        //不是子流程
        if(subType_v!="1"){
           whir_alert("请选择表单！",function(){});
		   return ;
		}
	}

	/*if(!checkEmpty('name','活动名称')){
		return;
	}*/
	//判断参与人必填写项
	var pat = $("input[name='participantType']:checked");
	if(pat.length>0){
		var v1 = pat[0].value;
		if(v1 == "someUsers"){
			if( $("input[name='candidateId']")[0].value == ""){
				whir_poshytip($("#candidate"),'从候选人员中指定不可以为空！');
				return;
			}
		}
		if(v1 == "someScope"){
			if(  $("textarea[name='participantGivenOrgName']")[0].value == ""){
				whir_poshytip($("#participantGivenOrgName"),'从选定的范围中不可以为空！');
				return ;
			}
		}
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
  
	var activityTip = $("input[name='activityTip']:checked");
	if(activityTip[0].value=="0"){
	}else{  
       if($("#activityTipTitle").val()==""){
		   	whir_poshytip($("#activityTipTitle"),workflowMessage_js.tiptitilecannotnull);
			return ;
	   } 
	   if($("#activityTipCotent").val()==""){
		   	whir_poshytip($("#activityTipCotent"),workflowMessage_js.tipcontentcannotnull);
			return ;
	   }
	}

	//model.setAttribute("whir:overdueType",$("input[name='overdueType']:checked");
	var overdueType = $("input[name='overdueType']:checked");
	if(overdueType[0].value == 2 ){
		var values = $("input[name='customFieldValueStr']");
		for( var i =0;i< values.length; i ++){
			if( values[i].value == ""  ){
				whir_poshytip($("input[name='customFieldValueStr']")[i],'自定义办理期限值不能为空！');
				//values[i].focus();
				return;
			}
		}


		var values = $("input[name='customTimeNum']");
		for( var i =0;i< values.length; i ++){
			var  _valuse=values[i].value;
			if( _valuse == "" || _valuse == "0"||isNaN(_valuse)||_valuse.indexOf(".")>=0 ||_valuse.indexOf("-")>=0){
				whir_poshytip($("input[name='customTimeNum']")[i],'自定义办理期限只能为大于0的整数！');
				//values[i].focus();
				return;
			}
		}

	}

	//批示意见
	var nodeCommentFieldSelect = $("select[name='nodeCommentField']");
	if(nodeCommentFieldSelect.length > 0 ){
		var nodeCommentField = nodeCommentFieldSelect[0].value;
		if( nodeCommentField == 'nullCommentField' || nodeCommentField == 'autoCommentField' ){
			
		}else{
			var nodeCommentFieldSelect = $("input[name='nodeCommentFields']:checked");
			if( nodeCommentFieldSelect.length > 0){
				//存选中的批示意见字段
				
			}else{
		        whir_alert("批示意见字段不能为空！",function(){});
				//whir_poshytip($("input[name='nodeCommentField']"),'批示意见字段不能为空！');
				return;
			}
		}
	}

	var taskNeedReadRadio = $("input[name='taskNeedRead']:checked");
	if(taskNeedReadRadio.length > 0 && taskNeedReadRadio[0].value == "1") {


   //阅件批示意见
	var nodeCommentFieldSelect = $("select[name='passNodeCommentField']");//$("input[name='passNodeCommentField']:checked");

	if(nodeCommentFieldSelect.length > 0 ){
		var nodeCommentField = nodeCommentFieldSelect[0].value;
		//alert(nodeCommentField);
		if( nodeCommentField == 'nullCommentField' || nodeCommentField == 'autoCommentField' ){
			
		}else{
			var nodeCommentFieldSelect = $("input[name='passNodeCommentFields']:checked");
			if( nodeCommentFieldSelect.length > 0){
				//存选中的批示意见字段
			
			}else{ 
				whir_alert("阅件批示意见字段不能为空！",function(){});
				//whir_poshytip($("input[name='nodeCommentField']"),'批示意见字段不能为空！');
				return;
			}
		}
	}

		//判断阅件参与人必填写项
	
		var pat = $("input[name='taskReadParticipantType']:checked");
		if(pat.length >0){
			var v1 = pat[0].value;

			if(v1 == "someUsers"){
				if( $("input[name='passRound_candidateId']")[0].value == ""){
					whir_poshytip($("#passRound_candidate"),'阅件从候选人员中指定不可以为空！');
					return;
				}
			}
			if(v1 == "someScope"){
				if(  $("textarea[name='passRoundGivenOrgName']")[0].value == ""){
					whir_poshytip($("#passRoundGivenOrgName"),'阅件从选定的范围中不可以为空！');
					return ;
				}
			}
			if(v1 == "someGroups" ){
				//从选定的群组中选择 someGroups
				//设置  participantGivenGroupName 选定群组名 和 participantGivenGroup 选定群组id 和 partGroupNexus 关系 和 partgGroupOrg  组织  partgGroupOrgLevel  组织级别
				if(   $("input[name='passRoundGivenGroup']")[0].value ==  ""      ){
					whir_poshytip($("#passRoundGivenGroupName"),'阅件从选定的群组中不可以为空！');
					return ;
				}
			}

			if( v1 == "setAllTransactors"){
				//指定全部办理人 setAllTransactors
				//allUserId allUser 
				if($("input[name='passRound_allUserId']")[0].value == ""){
					whir_poshytip($("#passRound_allUser"),'阅件指定全部办理人不可以为空！');
					return ;
				}
			}
		}
	}
    

	if(!validateForm("dataForm")){
		return "";
	} 


	if(getOperButtonCheckByValue("EzFlowTransfer")){
		var tranType_v=getRadioValue("EzFlowTransfer");
		if(tranType_v=="4"){
			 if($("#EzFlowTransferCustomExtent").val()==""){
                  whir_poshytip($("#EzFlowTransferCustomExtent"),'转办范围不能为空！');
				  return ;
			 }
		} 
	} 

	if(getOperButtonCheckByValue("EzFlowAddSignTask")){
		var tranType_v=getRadioValue("EzFlowAddSignTask");
		if(tranType_v=="4"){
			 if($("#EzFlowAddSignTaskCustomExtent").val()==""){
                  whir_poshytip($("#EzFlowAddSignTaskCustomExtent"),'加签范围不能为空！');
				  return ;
			 }
		} 
	} 
	if(getOperButtonCheckByValue("EzFlowTranRead")){
		var tranType_v=getRadioValue("EzFlowTranRead");
		if(tranType_v=="4"){
			 if($("#EzFlowTranReadCustomExtent").val()==""){
                  whir_poshytip($("#EzFlowTranReadCustomExtent"),'转阅范围不能为空！');
				  return ;
			 }
		} 
	} 


	if(getOperButtonCheckByValue("EdAddSign")){
		var tranType_v=getRadioValue("EdAddSign");
		if(tranType_v=="4"){
			 if($("#EdAddSignCustomExtent").val()==""){
                  whir_poshytip($("#EdAddSignCustomExtent"),'补签范围不能为空！');
				  return ;
			 }
		} 
	} 

	if(getOperButtonCheckByValue("Sendclose")){
		var tranType_v=getRadioValue("dispenseType");
		if(tranType_v=="4"){
			 if($("#SendcloseCustomExtent").val()==""){
                  whir_poshytip($("#SendcloseCustomExtent"),'分发范围不能为空！');
				  return ;
			 }
		} 
	} 


	
 
	//名称
	var aname = $("input[name='name']").attr("value");
	//检查重复性
	var nms = opener.xiorkFlow.xiorkFlowWrapper.getModel().metaNodeModels;
	for( i = 0; i < nms.length; i++) {
		if(nms[i].getID() != model.getID()) {
			if( nms[i].getText() == aname ){			 
				whir_poshytip($("#name"),"活动名称：" + aname + " 已经存在！");
				return;
			}
			
		}
	}

	model.setText(aname);

	//其他属性
	//activiti:priority 优先级别
	var priority = $("select[name='priority']").attr("value");
	if(priority != null) {
		model.setAttribute("activiti:priority", priority);
	}else{
		model.removeAttribute("activiti:priority");
	}

	//whir:taskSequenceType	必须	任务办理顺序： 抢占，顺序，并行。
	var taskSequenceType = $("select[name='taskSequenceType']").attr("value");
	if(taskSequenceType != null) {
		model.setAttribute("whir:taskSequenceType", taskSequenceType);
	}else{
		model.removeAttribute("whir:taskSequenceType");
	}

	//whir:taskNeedRead		是否需要阅件 ， True/False
	var taskNeedReadRadio = $("input[name='taskNeedRead']:checked");
	if(taskNeedReadRadio.length > 0) {
		model.setAttribute("whir:taskNeedRead", taskNeedReadRadio[0].value)
	}else{
		model.removeAttribute("whir:taskNeedRead");
	}

	//whir:nodeNeedAgent		是否允许代办   T/F
	var nodeNeedAgentInput = $("input[name='nodeNeedAgent']:checked");
	if(nodeNeedAgentInput.length > 0) {
		model.setAttribute("whir:nodeNeedAgent", nodeNeedAgentInput[0].value);
	}else{
		model.removeAttribute("whir:nodeNeedAgent");
	}

    //办理人设置审批意见查看范围
    var commentRangeByDealUserInput = $("input[name='commentRangeByDealUser']:checked");
	if(commentRangeByDealUserInput.length > 0) {
		model.setAttribute("whir:commentRangeByDealUser", commentRangeByDealUserInput[0].value);
	}else{
		model.removeAttribute("whir:commentRangeByDealUser");
	}
	
	//办理人重复时自动跳过
    var processDealUserWithRepeatInput = $("input[name='processDealUserWithRepeat']:checked");
	if(processDealUserWithRepeatInput.length > 0) {
		//alert(processDealUserWithRepeatInput[0].value);
		model.setAttribute("whir:processDealUserWithRepeat", processDealUserWithRepeatInput[0].value);
	}else{
		model.removeAttribute("whir:processDealUserWithRepeat");
	} 

	//whir:commentRangeEmpId		批示意见范围
	var commentRangeEmpIdVal = $("#commentRangeEmpId").val();
	model.setAttribute("whir:commentRangeEmpId", commentRangeEmpIdVal);

	var commentRangeEmpNameVal = $("#commentRangeEmpName").val();
	model.setAttribute("whir:commentRangeEmpName", commentRangeEmpNameVal);



	//whir:noteRemindType		短信提醒  no   没有短信提醒 defaultCheck  默认短信提醒 defaultNoCheck  默认不短信提醒
	var noteRemindTypeInput = $("input[name='noteRemindType']:checked");
	if(noteRemindTypeInput.length > 0) {
		model.setAttribute("whir:noteRemindType", $("input[name='noteRemindTypeValue']:checked")[0].value);
	}else{
		//model.setAttribute("whir:noteRemindType", "no");
		model.removeAttribute("whir:noteRemindType");
	}

	


	//activiti:formKey		表单id 或者 某个jsp路径
	 var formKeyval = $("select[name='formKey']").attr("value");

	 formKeyval=formKeyval.substring(0,formKeyval.length-1); 
    //var  formKeyval=$('#formKey').combobox('getValue');
	if(formKeyval != null) {
		model.setAttribute("whir:formKey", formKeyval); 
		if(opener.xiorkFlow.xiorkFlowWrapper.getModel().getAttribute("whir:formKey") == null || opener.xiorkFlow.xiorkFlowWrapper.getModel().getAttribute("whir:formKey") == ""){
			opener.xiorkFlow.xiorkFlowWrapper.getModel().setAttribute("whir:formKey", formKeyval); 
		}  
	}else{
		model.removeAttribute("whir:formKey");
	}
    if(opener.xiorkFlow.xiorkFlowWrapper.getModel().getAttribute("whir:formType") == null || opener.xiorkFlow.xiorkFlowWrapper.getModel().getAttribute("whir:formType") == ""){
			opener.xiorkFlow.xiorkFlowWrapper.getModel().setAttribute("whir:formType", $("#formType").val()); 
    }
	model.setAttribute("whir:formType", $("#formType").val());
	
	//批示意见
	var nodeCommentFieldSelect = $("select[name='nodeCommentField']");
	if(nodeCommentFieldSelect.length > 0 ){
		var nodeCommentField = nodeCommentFieldSelect[0].value;
		if( nodeCommentField == 'nullCommentField' || nodeCommentField == 'autoCommentField' ){
			 model.setAttribute("whir:nodeCommentField",nodeCommentField);
		}else{
			var nodeCommentFieldSelect = $("input[name='nodeCommentFields']:checked");
			if( nodeCommentFieldSelect.length > 0){
				//存选中的批示意见字段
				var values = "";
				for( k=0;k<nodeCommentFieldSelect.length;k++){
					values = values + "," + nodeCommentFieldSelect[k].value + ","
				}
				model.setAttribute("whir:nodeCommentField",values);
			}else{
				model.setAttribute("whir:nodeCommentField","");
			}
		}
	}

	//阅件批示意见
	var nodeCommentFieldSelect = $("select[name='passNodeCommentField']");//$("input[name='passNodeCommentField']:checked");

	if(nodeCommentFieldSelect.length > 0 ){
		var nodeCommentField = nodeCommentFieldSelect[0].value;
		//alert(nodeCommentField);
		if( nodeCommentField == 'nullCommentField' || nodeCommentField == 'autoCommentField' ){
			 model.setAttribute("whir:passNodeCommentField",nodeCommentField);
		}else{
			var nodeCommentFieldSelect = $("input[name='passNodeCommentFields']:checked");
			if( nodeCommentFieldSelect.length > 0){
				//存选中的批示意见字段
				var values = "";
				for( k=0;k<nodeCommentFieldSelect.length;k++){
					values = values + "," + nodeCommentFieldSelect[k].value + ","
				}

				model.setAttribute("whir:passNodeCommentField",values);
			}else{
				model.setAttribute("whir:passNodeCommentField","");
			}
		}
	}
	
	//节点描述 documentation
	var documentation = $("textarea[name='documentation']").attr("value");
	if(documentation != null) {
		model.setDocumentation(documentation);
	}

	//附加属性 办理类 taskDealWithClass
	extension = model.getWhirExtensionByName("taskDealWithClass");
	if(extension == null) {
		extension = model.newWhirExtension("taskDealWithClass");
		model.addWhirExtension(extension);
	}
	//extension.set("classname", $("input[name='formClassname']").attr("value"));
	extension.set("updateData", $("input[name='formUpdateData']").attr("value"));
	extension.set("updateStatus", $("input[name='formUpdateStatus']").attr("value"));
	extension.set("backData", $("input[name='formBackData']").attr("value"));
	extension.set("backStauts", $("input[name='formBackStauts']").attr("value"));

	extension.set("forminitJsFunName", $("input[name='forminitJsFunName_text']").attr("value"));
	extension.set("formsaveJsFunName", $("input[name='formsaveJsFunName_text']").attr("value"));

	var fields = "" ;
	
	var nodeWriteFieldOptions =  $("input[name='nodeWriteField']:checked");
	for(i =0 ;i < nodeWriteFieldOptions.length ; i++){
		fields = fields + "," + nodeWriteFieldOptions[i].value + ",";
	}
	if( fields != "" ){
		model.setAttribute("whir:nodeWriteField",fields);
	}else{
		model.setAttribute("whir:nodeWriteField","");
	}
	

	fields = "" ;
	
	var nodeHiddenFieldOptions =  $("input[name='nodeHiddenField']:checked");
	for(i =0 ;i < nodeHiddenFieldOptions.length ; i++){
		fields = fields + "," + nodeHiddenFieldOptions[i].value + ",";
	}
	if( fields != "" ){
		model.setAttribute("whir:nodeHiddenField",fields);
	}else{
		model.setAttribute("whir:nodeHiddenField","");
	}
	

	fields = "" ;
	
	var nodeProtectFieldOptions =  $("input[name='nodeProtectedField']:checked");
	for(i =0 ;i < nodeProtectFieldOptions.length ; i++){
		fields = fields + "," + nodeProtectFieldOptions[i].value + ",";
	}
	if( fields != "" ){
		model.setAttribute("whir:protectedField",fields);
	}else{
		model.setAttribute("whir:protectedField","");
	}
	

	

	var extension = model.getWhirExtensionByName("taskParticipantType");//参与者
	if( extension != null ){
	}else{
		extension = model.newWhirExtension("taskParticipantType");
		model.addWhirExtension(extension);
	}

	//办理人 participantType 
	var participantTypeInput = $("input[name='participantType']:checked");

	if( participantTypeInput.length > 0 ){
		for( i=0;i<participantTypeInput.length;i++){
			extension.set("code",participantTypeInput[i].value);
			//对于特殊的参与者类型还有其他属性
			//lastParticipantOrgLevel
			if( extension.get("code") == "chooseOrgLeader" ){
				extension.set("type",$("select[name='chooseOrgLeaderType']")[0].value);
			//lastpassRoundUserOrgLevel
			}else if(extension.get("code") == "initiator"){
				extension.set("type",$("select[name='initiatorType']")[0].value);
			//lastpassRoundUserOrgLevel
			}else if(extension.get("code") == "prevTransactorOrg"){
				//上一活动办理人组织及下级组织AND组织级别prevTransactorOrg
				//组织级别lastParticipantOrgLevel
				//设置  lastParticipantOrgLevel
				extension.set("orgLevel",$("select[name='lastParticipantOrgLevel']")[0].value);

			}else if(extension.get("code") == "initiatorLeaderOrg"){
				//流程启动人上级组织 AND 职务级别 initiatorLeaderOrg
				//设置  dutyLevelOperate 和 dutyLevelOperate
				extension.set("dutyLevelOperate",$("select[name='dutyLevelOperate']")[0].value);
				extension.set("dutyLevel",$("select[name='dutyLevel']")[0].value);
			}else if(extension.get("code") == "systemRole"){

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
			}else if(extension.get("code") == "activityTransactor"){
				//活动参与者本人
				
				extension.set("activityId",$("select[name='dealedActivityId']")[0].value);
				
			}else if(extension.get("code") == "activityTransactorLeader"){
				//活动参与者上级领导
				
				extension.set("activityId",$("select[name='dealedActivityId_leader']")[0].value);
				
			}else if(extension.get("code") == "someGroups"){
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


				//whir:nodeNeedAgent		是否允许代办   T/F
				var participantGroupNeedAllSendInput = $("input[name='participantGroupNeedAllSend']:checked");
				if(participantGroupNeedAllSendInput.length > 0) {
					 extension.set("groupNeedAllSend","true");
				}else{
					 extension.set("groupNeedAllSend","false");
				}

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
			}
		}
	}

	//其他属性
	//activiti:dueDate 活动到期时间
	//var dueDate = $("input[name='dueDate'][value='" + model.getAttribute("activiti:dueDate") + "']");
	//whir: overdueType		过期的执行事件类型
	//var overdueType = $("input[name='overdueType'][value='" + model.getAttribute("activiti:overdueType") + "']");
	
	//过期处理
	//model.setAttribute("whir:overdueType",$("input[name='overdueType']:checked");
	var overdueType = $("input[name='overdueType']:checked");
	model.setAttribute("whir:overdueType",overdueType[0].value);

    
    //批示意见是否设置态度
	var commentAttitudeTypeSetFiled = $("input[name='commentAttitudeTypeSet']:checked");
	model.setAttribute("whir:commentAttitudeTypeSet",commentAttitudeTypeSetFiled[0].value);
 
	
	if(overdueType[0].value == 1 || overdueType[0].value == 2 ){
		var overdueDealType = $("input[name='overdueDealType']:checked");
		var overdueDealTypeValue = "";
		for( i=0;i<overdueDealType.length;i++){
			overdueDealTypeValue += overdueDealType[i].value;
		}
		model.setAttribute("whir:overdueDealType",overdueDealTypeValue);
	}
	var extension = model.getWhirExtensionByName("dueDateFinal");//阅件参与者
	if( extension != null ){
		model.removeWhirExtension(extension);
	}
	if(overdueType[0].value == 1  ){//固定 保存固定类型
		//if( extension != null ){
		//}else{
		extension = model.newWhirExtension("dueDateFinal");
		model.addWhirExtension(extension);
		//}
		extension.set("timeNum",$("select[name='pressLimit']").val());
		extension.set("timeType",$("select[name='pressMotionTimeType']").val());
		extension.set("isPreRemind",$("input[name='isMotion']:checked").length>0?"true":"false");
		extension.set("preRemindTime",$("select[name='pressMotionTime']").val());
	}

	var extension = model.getWhirExtensionByName("taskReadParticipantType");//阅件参与者
	if( extension != null ){
	}else{
		extension = model.newWhirExtension("taskReadParticipantType");
		model.addWhirExtension(extension);
	}



	//清除所有的
	extensionArray = model.getWhirExtensionsByName("dueDateCustom");
	//先删除所有的dueDateCustom
	for(i=0;i<extensionArray.length;i++){
		model.removeWhirExtension(extensionArray[i]);
	}
	
	
	if(overdueType[0].value == 2  ){//自定义类型
		var customFieldNameFields = $("select[name='customFieldName']");
		var customOperateStrFields = $("select[name='customOperateStr']");
		var customFieldValueFields = $("input[name='customFieldValueStr']");
		var customTimeNumFields = $("input[name='customTimeNum']");
		var customTimeTypeFields = $("select[name='customTimeType']");
		var customIsMotionFields = $("input[name='customIsMotion']");
		var customPressMotionTimeFields = $("select[name='customPressMotionTime']");
 

        /*var customPressUserIdsFields = $("input[name='customPressUserIds']");
        var customPressUserNamesFields = $("input[name='customPressUserNames']");*/

		var customPressUserIds_select = $("select[name='customPressUserIds_select']");
        var dispTable_index_obj = $("input[name='dispTable_index']");
 



		for( i = 0; i < customFieldNameFields.length; i ++){
			
			var extension = model.newWhirExtension("dueDateCustom");
			extension.set("fieldName",customFieldNameFields[i].value);
			extension.set("operateStr",customOperateStrFields[i].value);
			extension.set("fieldValueStr",customFieldValueFields[i].value);
			extension.set("timeNum",customTimeNumFields[i].value);
			extension.set("timeType",customTimeTypeFields[i].value);
			extension.set("isPreRemind",customIsMotionFields[i].checked?"true":"false");
			extension.set("preRemindTime",customPressMotionTimeFields[i].value); 

             
			var  index=dispTable_index_obj[i].value;
            var  customPressUserIds_select_v=customPressUserIds_select[i].value;
			var  customPressUserIds_v=$("#customPressUserIds"+index).val();
			var  customPressUserNames_v=$("#customPressUserNames"+index).val();
            
			var  pids=customPressUserIds_select_v;
			if(customPressUserIds_v!=null&&customPressUserIds_v!="null"&&customPressUserIds_v!=""){
				pids=pids+";"+"$"+customPressUserIds_v+"$"
			}
            

			extension.set("customPressUserIds",pids); 
			extension.set("customPressUserNames",customPressUserNames_v);


			model.addWhirExtension(extension);
		}
	}
 
	var extension = model.getWhirExtensionByName("taskReadParticipantType");//参与者
	if( extension != null ){
	}else{
		extension = model.newWhirExtension("taskReadParticipantType");
		model.addWhirExtension(extension);
	}

	//阅件办理人 taskReadParticipantType 
	var participantTypeInput = $("input[name='taskReadParticipantType']:checked");
	if( participantTypeInput.length > 0 && model.getAttribute("whir:taskNeedRead") == "1" ){
		for( i=0;i<participantTypeInput.length;i++){
			extension.set("code",participantTypeInput[i].value);
			//对于特殊的参与者类型还有其他属性
			//对于特殊的参与者类型还有其他属性
			//lastParticipantOrgLevel

			if( extension.get("code") == "chooseOrgLeader" ){
				extension.set("type",$("select[name='taskChooseOrgLeaderType']")[0].value);
			//lastpassRoundUserOrgLevel
			}else if(extension.get("code") == "initiator"){
				extension.set("type",$("select[name='taskInitiatorType']")[0].value);
			//lastpassRoundUserOrgLevel
			}else if(extension.get("code") == "prevTransactorOrg"){
				//上一活动办理人组织及下级组织AND组织级别prevTransactorOrg
				//组织级别lastParticipantOrgLevel
				//设置  lastParticipantOrgLevel
				extension.set("orgLevel",$("select[name='lastpassRoundUserOrgLevel']")[0].value);
			}else if(extension.get("code") == "prevTransactorLeader"){ 
				//上一活动办理人的上级领导
				extension.set("dutyLevelOperateAnd",$("select[name='passprevTraLAnd']")[0].value);
				extension.set("dutyLevelOperate",$("select[name='passprevDutyLevelOperate']")[0].value);
				extension.set("dutyLevel",$("select[name='passprevDutyLevel']")[0].value); 
			}	else if(extension.get("code") == "initiatorLeaderOrg"){
				//流程启动人上级组织 AND 职务级别 initiatorLeaderOrg
				//设置  dutyLevelOperate 和 dutyLevelOperate
				extension.set("dutyLevelOperate",$("select[name='passDutyLevelOperate']")[0].value);
				extension.set("dutyLevel",$("select[name='passDutyLevel']")[0].value);
			}else if(extension.get("code") == "systemRole"){
				//从系统角色中指定 systemRole
				//设置  partRole 角色 和 partRoleNexus 关系 和 partRoleOrg 组织 和 partRoleOrgLevel 组织级别
				//var  passRoleval=$('#passRole').combobox('getValue'); 
				//var  passOrgval=$('#passOrg').combobox('getValue');

				var  passRoleval=getpcomboxval("passRole"); 
				var  passOrgval=getpcomboxval("passOrg"); 

				//extension.set("role",$("select[name='passRole']")[0].value);
				extension.set("role",passRoleval);
				extension.set("roleNexus",$("select[name='passRoleNexus']")[0].value);
				//extension.set("roleOrg",$("select[name='passOrg']")[0].value);
				extension.set("roleOrg",passOrgval);
				extension.set("roleOrgLevel",$("select[name='passOrgLevel']")[0].value);
			}else if(extension.get("code") == "someGroups"){
				//从选定的群组中选择 someGroups
				//设置  participantGivenGroupName 选定群组名 和 participantGivenGroup 选定群组id 和 partGroupNexus 关系 和 partgGroupOrg  组织  partgGroupOrgLevel  组织级别
				extension.set("givenGroupName",$("textarea[name='passRoundGivenGroupName']")[0].value);
				extension.set("givenGroup",$("input[name='passRoundGivenGroup']")[0].value);
				extension.set("groupNexus",$("select[name='passPartGroupNexus']")[0].value);
				//extension.set("groupOrg",$("select[name='passPartgGroupOrg']")[0].value);

			    var  passPartgGroupOrgval=getpcomboxval("passPartgGroupOrg"); 
				//var  partgGroupOrgval=$('#partgGroupOrg').combobox('getValue');
				//extension.set("groupOrg",$("select[name='partgGroupOrg']")[0].value);
				extension.set("groupOrg",passPartgGroupOrgval);


				extension.set("groupOrgLevel",$("select[name='passPartgGroupOrgLevel']")[0].value);
                //相同办公地点的分类
				extension.set("workAddressType",$("select[name='passworkAddressType']")[0].value); 



				//whir:groupNeedAllSend		群组是否默认发送全部 
				var passRoundGroupNeedAllSendInput = $("input[name='passRoundGroupNeedAllSend']:checked");
				if(passRoundGroupNeedAllSendInput.length > 0) {
					 extension.set("groupNeedAllSend","true");
				}else{
					 extension.set("groupNeedAllSend","false");
				}
 
				//extension.set("partGroupNexus",$("select[name='partGroupNexus']")[0].value);
				//extension.set("partgGroupOrg",$("select[name='partgGroupOrg']")[0].value);
				//extension.set("partgGroupOrgLevel",$("select[name='partgGroupOrgLevel']")[0].value);
			}else if(extension.get("code") == "someUsers"){
				//从候选人员中指定 someUsers
				//candidateId 候选人ID candidate 候选人
				extension.set("candidateId",$("input[name='passRound_candidateId']")[0].value);
				extension.set("candidate",$("textarea[name='passRound_candidate']")[0].value);
			}else if(extension.get("code") == "someScope"){
				//从选定的范围中选择 someScope
				//participantGivenOrgName 选定的范围名称 participantGivenOrg 选定的范围
				extension.set("givenOrgName",$("textarea[name='passRoundGivenOrgName']")[0].value);
				extension.set("givenOrg",$("input[name='passRoundGivenOrg']")[0].value);
			}else if(extension.get("code") == "someField"){
				//由表单中的某个字段值决定 someField
				//participantUserField participantUserFieldType 
				extension.set("userField",$("select[name='passRoundUserField']")[0].value);
				//extension.set("participantUserFieldType",$("select[name='participantUserFieldType']")[0].value);
			}else if(extension.get("code") == "setAllTransactors"){
				//指定全部办理人 setAllTransactors
				//allUserId allUser 
				extension.set("allUserId",$("input[name='passRound_allUserId']")[0].value);
				extension.set("allUser",$("textarea[name='passRound_allUser']")[0].value);
			}else if(extension.get("code") == "setByInterface"){
				//由接口决定 setByInterface
				//passRoundUserClassName 接口类名 passRoundUserMethodName 接口方法名 passRoundInpaNames 接口参数名 passRoundInpaValues 接口参数值
				extension.set("className",$("input[name='passRoundUserClassName']")[0].value);
				extension.set("methodName",$("input[name='passRoundUserMethodName']")[0].value);
				extension.set("inPaNames",$("input[name='passRoundInpaNames']")[0].value);
				extension.set("inPavalues",$("input[name='passRoundInpaValues']")[0].value);
			}
		}
	}else{
		//防止 第一选了阅件， 第二次又不选，结果出现没选阅件，但是发送时出现阅件
		model.removeWhirExtension(extension);
	    extension = model.newWhirExtension("taskReadParticipantType");
		model.addWhirExtension(extension);
	}
    
    //办理提示 activityTip
	extension_ = model.getWhirExtensionByName("activityTip");
	if(extension_ == null) {
		extension_ = model.newWhirExtension("activityTip");
		model.addWhirExtension(extension_);
	} 
	extension_.set("enable",activityTip[0].value);
	if(activityTip[0].value=="1"){
	    extension_.set("activityTipTitle",$("#activityTipTitle").val());//设置 活动提示标题
	    extension_.set("activityTipCotent",$("#activityTipCotent").val());//设置 活动提示内容
	}

 
	//办理按钮taskButtons
	extensionArray = model.getWhirExtensionsByName("taskButtons");
	//先删除所有的taskButtons
	for(i=0;i<extensionArray.length;i++){
		model.removeWhirExtension(extensionArray[i]);
	}
	//循环每个选中的按钮，增加扩展属性
	var btnCheckBox = $("input[name='operButton']");
	if(btnCheckBox.length > 0) {
		//第二个值是选择范围
		for( i = 0; i < btnCheckBox.length; i++) {
			if(btnCheckBox[i].checked) {
				extension = model.newWhirExtension("taskButtons");
				var name = btnCheckBox[i].value;
				extension.set("id",name);//设置name属性
				{
					if (name=="EzFlowStartProcess") extension.set("name","发起");//设置name属性	
					if (name=="EzFlowCompleteTask") extension.set("name","办理任务");	
					if (name=="EzFlowBackTask") extension.set("name","退回");	
					if (name=="EzFlowAbandon") extension.set("name","作废");	
					if (name=="EzFlowTransfer") extension.set("name","转办");	
					if (name=="EzFlowSendReadTask") extension.set("name","阅件");	
					if (name=="EzFlowAddSignTask") extension.set("name","加签");	
					if (name=="EzFlowRelationProcess") extension.set("name","关联流程");	
					if (name=="EzFlowTranRead") extension.set("name","转阅");	
					if (name=="EzFlowReCall") extension.set("name","撤办");	
					if (name=="EzFlowFeedback") extension.set("name","反馈");	
					if (name=="EzFlowDrwaBack") extension.set("name","收回");	
					if (name=="EzFlowCancel") extension.set("name","取消");	
					if (name=="EzFlowNewProcess") extension.set("name","新建流程");	
					if (name=="EzFlowPress") extension.set("name","催办");	
					if (name=="EzFlowTranWithMail") extension.set("name","邮件转发");	
					if (name=="EzFlowPrint") extension.set("name","打印");	
			
					//extension.set("name",name);//设置name属性
				}

				var rangeCheckObj = $("input[name='"+name+"']:checked");
				if(rangeCheckObj.length >0){
					extension.set("range", rangeCheckObj[0].value);//设置range属性
					if( rangeCheckObj[0].value == "4" ){//自定义范围
						//自定义值
						var customInput = $("input[name='"+name+"CustomExtent']");
						if(customInput.length > 0) {
							extension.set("customNames", customInput[0].value);
						}
						var customInput = $("input[name='"+name+"CustomExtentId']");
						if(customInput.length > 0) {
							extension.set("customIds", customInput[0].value);
						}
					}
				}
				
				//如果是转办按钮，则增加自动返回 autoTranReturn
				if(name == "EzFlowTransfer"){
					var autoTranReturnCheckBox = $("input[name='autoTranReturn']:checked"); 
					if(autoTranReturnCheckBox.length > 0 ){
						extension.set("autoTranReturn", autoTranReturnCheckBox[0].value);
					}
				}
				model.addWhirExtension(extension);
			}
		}
	}
	window.close();
}





//初始化属性
function initData(id) { 
	if(p_comboxType=="ext"){
		initExt();
	}else{
		initChange();
	} 
	//ajax获取数据
    //表明是初始化阶段，不要渲染。 以提高性能。
	initDataStatus="1";
	/*
	1、所有表单
	2、批示意见对应字段
	3、表单字段
	4、提醒项
	5、系统角色
	6、系统组织
	7、职务级别
	*/
	//初始化显示
	$("#hxr").hide();//document.all.hxr.style.display = "none";
	$("#qbblr").hide();//document.all.qbblr.style.display = "none";
	$("#bdzd").hide();//document.all.bdzd.style.display = "none";
	$("#participantRole").hide();//document.all.participantRole.style.display = "none";
	$("#zdzz").hide();//document.all.zdzz.style.display = "none";
	$("#xdqz").hide();//document.all.xdqz.style.display = "none";

	if(opener == null || opener.xiorkFlow == null || opener.xiorkFlow.xiorkFlowWrapper == null || opener.xiorkFlow.xiorkFlowWrapper.getModel() == null) {
		alert("父页面或者流程已经不存在！");
		return;
	}
	var nms = opener.xiorkFlow.xiorkFlowWrapper.getModel().metaNodeModels;
	for( i = 0; i < nms.length; i++) {
		if(nms[i].getID() == id) {
			model = nms[i];
			//break;
		}
		//>0为子流程的活动 ， 
		if( nms[i].getID().indexOf("usertask")>= 0 || nms[i].getID().indexOf("autobacktask")>= 0   ){
		//if( nms[i].getID().indexOf("usertask") == 0 || nms[i].getID().indexOf("autobacktask") == 0   ){
			var uId=nms[i].getID();
			var uText=nms[i].getText();
 

			$("#dealedActivityId_leader").append("<option value='"+uId+"'>"+uText+"</option");
			$("#dealedActivityId").append("<option value='"+uId+"'>"+uText+"</option");
		}
	}
	if(model == null) {
		alert("编辑的节点已经不存在！");
		return;
	}
	//名称
	$("input[name='name']").attr("value", model.getText());
	//ID
	$("input[name='id']").attr("value", model.getID());

	/*model.setAttribute("whir:activityTip",activityTip[0].value);
    model.setAttribute("whir:activityTipTitle", $("#activityTipTitle").val());
	model.setAttribute("whir:activityTipCotent",$("#activityTipCotent").val());*/

    var activityTip_val="0";
    var activityTipTitle_="";
	var activityTipCotent_="";
 
	//办理提示 activityTip
	extension_ = model.getWhirExtensionByName("activityTip");
	if(extension_ == null) { 
	}else{
        activityTip_val = extension_.get("enable");
		activityTipTitle_=extension_.get("activityTipTitle");
		activityTipCotent_=extension_.get("activityTipCotent");
	} 

	if(activityTip_val=="0"){
		$('input:radio[name="activityTip"]').eq(0).attr("checked",'checked');
		$("#activityTipTitle_tr").hide();
		$("#activityTipCotent_tr").hide();
	}else{
		$('input:radio[name="activityTip"]').eq(1).attr("checked",'checked');
        $("#activityTipTitle").val(activityTipTitle_);
		$("#activityTipCotent").val(activityTipCotent_);
	} 



	//
    var commentAttitudeTypeSet_v= model.getAttribute("whir:commentAttitudeTypeSet");
    if(commentAttitudeTypeSet_v==null||commentAttitudeTypeSet_v==""||commentAttitudeTypeSet_v=="null"){
       commentAttitudeTypeSet_v="0";
   }

    var commentAttitudeTypeSetField = $("input[name='commentAttitudeTypeSet'][value='" +commentAttitudeTypeSet_v + "']");
    if(commentAttitudeTypeSetField.length >0 ){
		commentAttitudeTypeSetField[0].checked = true;
    }
 
	//其他属性
	//activiti:dueDate 活动到期时间
	//var dueDate = $("input[name='dueDate'][value='" + model.getAttribute("activiti:dueDate") + "']");
	//dueDate[0].checked = true
	//whir: overdueType		过期的执行事件类型
	var overdueType = $("input[name='overdueType'][value='" + model.getAttribute("whir:overdueType") + "']");
	if(overdueType.length >0 ){
		overdueType[0].checked = true;
		overdueType[0].click();
	}
	//var overdueDealType = $("input[name='overdueType']:checked");
	var overdueDealTypeValue = model.getAttribute("whir:overdueDealType");
	if( overdueDealTypeValue != null){
		var overdueDealTypeValues = overdueDealTypeValue.split(",");
		for(i=0;i<overdueDealTypeValues.length;i++){
			if(overdueDealTypeValues[i] != ""){
				var overdueDealType = $("input[name='overdueDealType'][value=',"+overdueDealTypeValues[i]+",']");
				if(overdueDealType.length > 0 ){
					overdueDealType[0].checked = false;
					overdueDealType[0].click();
				}
			}
		}
	}

	
	var extension = model.getWhirExtensionByName("dueDateFinal");//固定时间
	if( extension != null ){
		$("select[name='pressLimit']").val(extension.get("timeNum"));
		$("select[name='pressMotionTimeType']").val(extension.get("timeType"));
		$("input[name='isMotion']")[0].checked = (extension.get("isPreRemind") == "true");
		$("select[name='pressMotionTime']").val(extension.get("preRemindTime"));
	}

	/*//0: 无   1： 固定  2：自定义
	if(overdueType == 0){
		
	}else if(overdueType == 1){

	}else if(overdueType == 2){

	}*/

	//**********************************************************************************************************************************************************
	//处理--待完成

	//activiti:priority 优先级别
	var priority = model.getAttribute("activiti:priority");
	if(priority != null) {
		$("select[name='priority']").attr("value", priority);
	}

	//whir:taskSequenceType	必须	任务办理顺序： 抢占，顺序，并行。
	var taskSequenceType = model.getAttribute("whir:taskSequenceType");
	if(taskSequenceType != null) {
		$("select[name='taskSequenceType']").attr("value", taskSequenceType);
	}

	//whir:taskNeedRead		是否需要阅件 ， True/False
	var taskNeedReadRadio = $("input[name='taskNeedRead'][value='" + model.getAttribute("whir:taskNeedRead") + "']");
	if(taskNeedReadRadio.length > 0) {
		taskNeedReadRadio[0].checked = true;
		needPassRount(taskNeedReadRadio[0]);
		//显示或隐藏阅件范围选择
	}

	//whir:nodeNeedAgent		是否允许代办   T/F
	var nodeNeedAgent = model.getAttribute("whir:nodeNeedAgent");
	if(nodeNeedAgent != null) {
		var nodeNeedAgentInput = $("input[name='nodeNeedAgent']");
		if(nodeNeedAgentInput.length > 0) {
			nodeNeedAgentInput[0].checked = nodeNeedAgent;
		}
	}
    
	//办理人设置审批意见查看范围
	var commentRangeByDealUser = model.getAttribute("whir:commentRangeByDealUser");
	if(commentRangeByDealUser != null) {
		var commentRangeByDealUserInput = $("input[name='commentRangeByDealUser']");
		if(commentRangeByDealUserInput.length > 0) {
			commentRangeByDealUserInput[0].checked = commentRangeByDealUser;
		}
	}

	//办理人重复时自动跳过
	var processDealUserWithRepeat = model.getAttribute("whir:processDealUserWithRepeat");
	if(processDealUserWithRepeat != null) {
		var processDealUserWithRepeatInput = $("input[name='processDealUserWithRepeat']");
		if(processDealUserWithRepeatInput.length > 0) {
			processDealUserWithRepeatInput[0].checked = processDealUserWithRepeat;
		}
	}

    //批示意见范围
	var commentRangeEmpIdVal = model.getAttribute("whir:commentRangeEmpId");
	var commentRangeEmpNameVal = model.getAttribute("whir:commentRangeEmpName");

	if(commentRangeEmpIdVal!=undefined&&commentRangeEmpIdVal!=null&&commentRangeEmpIdVal!="null"){
	   $("#commentRangeEmpId").val(commentRangeEmpIdVal);
	}
	if(commentRangeEmpNameVal!=undefined&&commentRangeEmpNameVal!=null&&!commentRangeEmpNameVal!="null"){
	   $("textarea[name='commentRangeEmpName']").attr("value", commentRangeEmpNameVal);
	}

	//whir:noteRemindType		短信提醒  no   没有短信提醒 defaultCheck  默认短信提醒 defaultNoCheck  默认不短信提醒
	var noteRemindType = model.getAttribute("whir:noteRemindType");
	if(noteRemindType != null && noteRemindType != "no") {
		var noteRemindTypeInput = $("input[name='noteRemindType']");
		if(noteRemindTypeInput.length > 0) {
			//noteRemindTypeInput[0].checked = true;
			noteRemindTypeInput[0].click();
		}
		var noteRemindTypeValueRadio = $("input[name='noteRemindTypeValue'][value='" + noteRemindType + "']");
		if(noteRemindTypeValueRadio.length > 0){
			noteRemindTypeValueRadio[0].checked = true;
			
		}
	}

	//activiti:formKey		表单id 或者 某个jsp路径
	var formKey = model.getAttribute("whir:formKey");
	var formType = model.getAttribute("whir:formType");

	if(formType==null){
		formType="0";
	}
	if(formType=="null"||formType==""){
	    formType="0"
	}
	if(formKey != null) {
	    $("select[name='formKey']").attr("value", formKey+formType);
		//$('#formKey').combobox('setValue',formKey);
	}
    var formKeyval = $("select[name='formKey']").attr("value"); 
	//var  formKeyval=$('#formKey').combobox('getValue');
    //$("select[name='formKey']").change();
	changerFormKey(formKeyval);

	//节点描述 documentation
	var documentation = model.getDocumentation();
	if(documentation != null) {
		$("textarea[name='documentation']").attr("value", documentation);
	}

	//超期提醒2
	extensionArray = model.getWhirExtensionsByName("dueDateCustom");
	for(i=0;i<extensionArray.length;i++){
		//model.removeWhirExtension(extensionArray[i]);
		var extension = extensionArray[i];

		var customFieldNameFields = $("select[name='customFieldName']");
		if(customFieldNameFields.length < i+1){
			addRow();
		}
		customFieldNameFields = $("select[name='customFieldName']");
		var customOperateStrFields = $("select[name='customOperateStr']");
		var customFieldValueFields = $("input[name='customFieldValueStr']");
		var customTimeNumFields = $("input[name='customTimeNum']");
		var customTimeTypeFields = $("select[name='customTimeType']");
		var customIsMotionFields = $("input[name='customIsMotion']");
		var customPressMotionTimeFields = $("select[name='customPressMotionTime']");
  
		customFieldNameFields[i].value = extension.get("fieldName");
		customOperateStrFields[i].value = extension.get("operateStr");
		customFieldValueFields[i].value = extension.get("fieldValueStr");
		customTimeNumFields[i].value = extension.get("timeNum");
		customTimeTypeFields[i].value = extension.get("timeType")
		customIsMotionFields[i].checked = extension.get("isPreRemind")=="true";
		customPressMotionTimeFields[i].value = extension.get("preRemindTime");

 
 
	    var customPressUserIds_select = $("select[name='customPressUserIds_select']");
        var dispTable_index_obj = $("input[name='dispTable_index']");
  
	    var pressIdTotal_v=extension.get("customPressUserIds")==null?"":extension.get("customPressUserIds"); 
		var customPressUserNames_v=extension.get("customPressUserNames")==null?"":extension.get("customPressUserNames");
        
		var  customPressUserIds_select_v="$-1$";
		var  customPressUserIds_v=""; 
        if(pressIdTotal_v!=null&&pressIdTotal_v!=""&&pressIdTotal_v!="null"){
			var pressIdTotal_v_arr=pressIdTotal_v.split(";");
			customPressUserIds_select_v=pressIdTotal_v_arr[0];
			customPressUserIds_v=pressIdTotal_v_arr[1];
            
			if(customPressUserIds_v!=null&&customPressUserIds_v.length>2&&customPressUserIds_v.indexOf("$")>=0){
				customPressUserIds_v=customPressUserIds_v.substring(1,customPressUserIds_v.length-1);
			}

		}else{
		}

		customPressUserIds_select[i].value=customPressUserIds_select_v;
		dispTable_index_obj[i].value=i; 
		$("#customPressUserIds"+i).val(customPressUserIds_v);
		$("#customPressUserNames"+i).val(customPressUserNames_v); 
	}

	//办理类taskDealWithClass
	extension = model.getWhirExtensionByName("taskDealWithClass");
	if(extension != null) {
	//	classname = extension.get("classname");
		saveData = extension.get("updateData");
		saveStauts = extension.get("updateStatus");
		completeData = extension.get("backData");
		completeStauts = extension.get("backStauts");

		//js方法名
		forminitJsFunName=extension.get("forminitJsFunName");
		formsaveJsFunName=extension.get("formsaveJsFunName");


	//	$("input[name='formClassname']").attr("value", classname);
		$("input[name='formUpdateData']").attr("value", saveData);
		$("input[name='formUpdateStatus']").attr("value", saveStauts);
		$("input[name='formBackData']").attr("value", completeData);
		$("input[name='formBackStauts']").attr("value", completeStauts);

		$("input[name='forminitJsFunName_text']").attr("value", forminitJsFunName);
		$("input[name='formsaveJsFunName_text']").attr("value", formsaveJsFunName);
	}

	//办理按钮taskButtons
	extensionArray = model.getWhirExtensionsByName("taskButtons");
	for(i =0 ;i< extensionArray.length;i ++ ) {
		extension = extensionArray[i];
		//按钮名称
		name = extension.get("id");
		var btnCheckBox = $("input[name='operButton'][value='" + name + "']");
		if(btnCheckBox.length > 0) {
			btnCheckBox[0].checked = false;
			btnCheckBox[0].click();//click一下就变true,并触发事件
		}

		//如果是转办按钮，则增加自动返回 autoTranReturn
		if(name == "EzFlowTransfer"){
			var value = extension.get("autoTranReturn");
			if( value != null ){
				var autoTranReturnCheckBox = $("input[name='autoTranReturn'][value='"+ value+"']"); 
				if(autoTranReturnCheckBox.length > 0 ){
					autoTranReturnCheckBox[0].checked = false;
					autoTranReturnCheckBox[0].click();//click一下就变true,并触发事件
				}
			}
		}

		//范围
		range = extension.get("range");
		if(range != null ){
			var btnCheckBox = $("input[name='"+name+"'][value='" + range + "']");
			if(btnCheckBox.length > 0) {
				btnCheckBox[0].checked = false;
				btnCheckBox[0].click();//click一下就变true,并触发事件
			}
		}
		if( range == "4" ){//自定义范围
			//如果是自定义还需要 填充 值
			customNames = extension.get("customNames");
			if(customNames != null ){
				var customInput = $("input[name='"+name+"CustomExtent']");
				if(customInput.length > 0) {
					$(customInput[0]).attr("value",customNames);
				}
			}
			customIds = extension.get("customIds");
			if(customIds != null ){
				var customInput = $("input[name='"+name+"CustomExtentId']");
				if(customInput.length > 0) {
					$(customInput[0]).attr("value",customIds);
				}
			}
		}
	}

	//批示意见
	var nodeCommentFieldSelect = $("select[name='nodeCommentField']");
	var nodeCommentField = model.getAttribute("whir:nodeCommentField");
	if(nodeCommentFieldSelect.length > 0 && nodeCommentField != null){
		if (nodeCommentField == "nullCommentField" || nodeCommentField == "autoCommentField"  )
		{
			nodeCommentFieldSelect[0].value = nodeCommentField;
			nodeCommentFieldSelect[0].onclick();
		}else{
			nodeCommentFieldSelect[0].value = "";
			nodeCommentFieldSelect[0].onclick();
			//如果是空还要找到字段
			var nodeCommentFieldArray = nodeCommentField.split(",");
			for( k=0;k<nodeCommentFieldArray.length;k++){
				var nodeCommentFieldSelect = $("input[name='nodeCommentFields'][value='"+nodeCommentFieldArray[k]+"']"); 
				if(nodeCommentFieldSelect.length > 0 ) {
					nodeCommentFieldSelect[0].checked = true;
				}
			}
		}
	}

	//阅件批示意见
	var nodeCommentField = model.getAttribute("whir:passNodeCommentField");
	//var nodeCommentFieldSelect = $("input[name='passNodeCommentField'][value='"+nodeCommentField+"']");
	var nodeCommentFieldSelect = $("select[name='passNodeCommentField']");
	
	if( nodeCommentField != null){
		if (nodeCommentField == "nullCommentField" || nodeCommentField == "autoCommentField"  )
		{
			//nodeCommentFieldSelect.val(nodeCommentField);
			nodeCommentFieldSelect[0].value = nodeCommentField;
			nodeCommentFieldSelect[0].onclick();
		}else{
			//var nodeCommentFieldSelect = $("input[name='passNodeCommentField'][value='']");
			//nodeCommentFieldSelect.val(nodeCommentField);
			nodeCommentFieldSelect[0].value = "";
			nodeCommentFieldSelect[0].onclick();
			//如果是空还要找到字段
			var nodeCommentFieldArray = nodeCommentField.split(",");
			for( k=0;k<nodeCommentFieldArray.length;k++){
				//var nodeCommentFieldSelect = $("input[name='passNodeCommentFields'][value='"+nodeCommentFieldArray[k]+"']"); 

				var nodeCommentFieldSelect = $("input[name='passNodeCommentFields'][value='"+nodeCommentFieldArray[k]+"']"); 
				if(nodeCommentFieldSelect.length > 0 ) {
					nodeCommentFieldSelect[0].checked = true;
				}
			}
		}
	}
		
	var fields = "" ;
	//可写字段
	fields = model.getAttribute("whir:nodeWriteField");
	//var field1Select = $("select[name='field1']");//全部字段下拉框
 

	if(fields != null ){//存在可写字段属性
		fieldArray = fields.split(",");
		for( i = 0 ;i < fieldArray.length; i ++){
			var field = fieldArray[i];
			var fieldCheckbox = $("input[name='nodeWriteField'][value='"+field+"']");
			if(fieldCheckbox.length > 0 ){
				fieldCheckbox[0].checked = true;
				disableOthers(fieldCheckbox[0]);
			}
		}
	}
	
	//其他全部列入读字段
	//transferOptionsAll("field1","readFields");

	//隐藏字段
	fields = model.getAttribute("whir:nodeHiddenField");
	
	if(fields != null ){//存在可写字段属性
		fieldArray = fields.split(",");
		for( i = 0 ;i < fieldArray.length; i ++){
			var field = fieldArray[i];
			var fieldCheckbox = $("input[name='nodeHiddenField'][value='"+field+"']");
			if(fieldCheckbox.length > 0 ){
				fieldCheckbox[0].checked = true;
				disableOthers(fieldCheckbox[0]);
			}
		}
	}
	
	//签章保护字段
	fields = model.getAttribute("whir:protectedField");
	
	if(fields != null ){//存在可写字段属性
		fieldArray = fields.split(",");
		for( i = 0 ;i < fieldArray.length; i ++){
			var field = fieldArray[i];
			var fieldCheckbox = $("input[name='nodeProtectedField'][value='"+field+"']");
			if(fieldCheckbox.length > 0 ){
				fieldCheckbox[0].checked = true;
				disableOthers(fieldCheckbox[0]);
			}
		}
	}
	
	//办理人 participantType 
	var extension = model.getWhirExtensionByName("taskParticipantType");//参与者
	if( extension != null ){
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
			//如果 角色删除了 就会出现下面的情况，默认选择第一个

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

		    var groupNeedAllSendV=extension.get("groupNeedAllSend");
			if(groupNeedAllSendV!=null&&groupNeedAllSendV=="true"){
			    $("input[name='participantGroupNeedAllSend']")[0].checked=true;
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
	//阅件办理人 taskReadParticipantType  
	var extension = model.getWhirExtensionByName("taskReadParticipantType");//阅件办理人
	if( extension != null ){
		var value = extension.get("code");
		var participantTypeInput = $("input[name='taskReadParticipantType'][value='" + value + "']");
		if( participantTypeInput.length > 0 ){
			participantTypeInput[0].checked = false;
			participantTypeInput[0].click();
		}

		//对于特殊的参与者类型还有其他属性
		//lastpassRoundUserOrgLevel
		if(extension.get("code") == "chooseOrgLeader"){
			$("select[name='taskChooseOrgLeaderType']")[0].value = extension.get("type");

		//lastpassRoundUserOrgLevel
		}else if(extension.get("code") == "initiator"){
			$("select[name='taskInitiatorType']")[0].value = extension.get("type");

		//lastpassRoundUserOrgLevel
		}else if(extension.get("code") == "prevTransactorOrg"){
			//上一活动办理人组织及下级组织AND组织级别prevTransactorOrg
			//组织级别 lastpassRoundUserOrgLevel
			//设置 lastpassRoundUserOrgLevel
			$("select[name='lastpassRoundUserOrgLevel']")[0].value = extension.get("orgLevel");
		}else if(extension.get("code") == "prevTransactorLeader"){
			//上一活动办理人的上级领导
			//设置 dutyLevelOperate 和 dutyLevel
			$("select[name='passprevTraLAnd']")[0].value = extension.get("dutyLevelOperateAnd");
			$("select[name='passprevDutyLevelOperate']")[0].value = extension.get("dutyLevelOperate");
			$("select[name='passprevDutyLevel']")[0].value = extension.get("dutyLevel");  
		}else if(extension.get("code") == "initiatorLeaderOrg"){
			//流程启动人上级组织 AND 职务级别 initiatorLeaderOrg
			//设置 dutyLevelOperate 和 dutyLevel  passDutyLevelOperate passDutyLevel
			$("select[name='passDutyLevelOperate']")[0].value = extension.get("dutyLevelOperate");
			$("select[name='passDutyLevel']")[0].value = extension.get("dutyLevel");
		}else if(extension.get("code") == "systemRole"){
			//从系统角色中指定 systemRole 
			//设置 partRole 角色 和 partRoleNexus 关系 和 partRoleOrg 组织 和 partRoleOrgLevel 组织级别
			//passRole passRoleNexus passOrg passOrgLevel
			//$('#passRole').combobox('setValue',extension.get("role"));
			setpcomboxval("passRole",extension.get("role"));  
            //如果角色删除  ，默认显示选择第一个角色。
			setfirstOption("passRole");
			 
			//$("select[name='passRole']")[0].value = extension.get("role");
			$("select[name='passRoleNexus']")[0].value = extension.get("roleNexus");
			var roleOrgval= extension.get("roleOrg");
			//$('#roleOrg').combobox('setValue',roleOrgval);
			setpcomboxval("passOrg",roleOrgval);
			if(roleOrgval=="-3"||roleOrgval=="-6"){
				$("#passOrgLevelId").show();
			}
			//$("select[name='passOrg']")[0].value = extension.get("roleOrg");
			$("select[name='passOrgLevel']")[0].value = extension.get("roleOrgLevel");
		}else if(extension.get("code") == "someGroups"){
			//从选定的群组中选择 someGroups
			//设置  participantGivenGroupName 选定群组名 和 participantGivenGroup 选定群组id 和 partGroupNexus 关系 和 partgGroupOrg  组织  partgGroupOrgLevel  组织级别
			$("textarea[name='passRoundGivenGroupName']")[0].value = extension.get("givenGroupName");
			$("input[name='passRoundGivenGroup']")[0].value = extension.get("givenGroup");
			$("select[name='passPartGroupNexus']")[0].value = extension.get("groupNexus");
            
			var groupOrgVal=extension.get("groupOrg");
			if(groupOrgVal=="-3"||groupOrgVal=="-6"){
				$("#passPartgGroupOrgLevelID").show();
			}
			//$("select[name='passPartgGroupOrg']")[0].value = groupOrgVal;

			setpcomboxval("passPartgGroupOrg",groupOrgVal); 
			$("select[name='passPartgGroupOrg']").change();
			$("select[name='passPartgGroupOrgLevel']")[0].value = extension.get("groupOrgLevel");
			  
			if(groupOrgVal=="-4"){
				$("#passaddressTypeSpan").show();
			    //相同办公地点的分类 
		     	$("select[name='passworkAddressType']")[0].value = extension.get("workAddressType");
			}

			var groupNeedAllSendV=extension.get("groupNeedAllSend");
			if(groupNeedAllSendV!=null&&groupNeedAllSendV=="true"){
			    $("input[name='passRoundGroupNeedAllSend']")[0].checked=true;
			} 
 
			//$("select[name='partGroupNexus']")[0].value = extension.get("partGroupNexus");
			//$("select[name='partgGroupOrg']")[0].value = extension.get("partgGroupOrg");
			//$("select[name='partgGroupOrgLevel']")[0].value = extension.get("partgGroupOrgLevel");
		}else if(extension.get("code") == "someUsers"){
			//从候选人员中指定 someUsers
			//candidateId 候选人ID candidate 候选人
			$("input[name='passRound_candidateId']")[0].value = extension.get("candidateId");
			$("textarea[name='passRound_candidate']")[0].value = extension.get("candidate");
		}else if(extension.get("code") == "someScope"){
			//从选定的范围中选择 someScope
			//participantGivenOrgName 选定的范围名称 participantGivenOrg 选定的范围
			$("textarea[name='passRoundGivenOrgName']")[0].value = extension.get("givenOrgName");
			$("input[name='passRoundGivenOrg']")[0].value = extension.get("givenOrg");
		}else if(extension.get("code") == "someField"){
			//由表单中的某个字段值决定 someField
			//participantUserField participantUserFieldType 
			$("select[name='passRoundUserField']")[0].value = extension.get("userField");
			//$("select[name='participantUserFieldType']")[0].value = extension.get("participantUserFieldType");
		}else if(extension.get("code") == "setAllTransactors"){
			//指定全部办理人 setAllTransactors
			//allUserId allUser 
			$("input[name='passRound_allUserId']")[0].value = extension.get("allUserId");
			$("textarea[name='passRound_allUser']")[0].value = extension.get("allUser");
		}else if(extension.get("code") == "setByInterface"){
			//由接口决定 setByInterface
			//passRoundUserClassName 接口类名 passRoundUserMethodName 接口方法名 passRoundInpaNames 接口参数名 passRoundInpaValues 接口参数值
			$("input[name='passRoundUserClassName']")[0].value = extension.get("className");
			$("input[name='passRoundUserMethodName']")[0].value = extension.get("methodName");
			$("input[name='passRoundInpaNames']")[0].value = extension.get("inPaNames");
			$("input[name='passRoundInpaValues']")[0].value = extension.get("inPavalues");
		}
	}

	initDataStatus="0";
	//渲染
    //setCheckStyle();
	initSystem();
}


//全选按钮选择事件 选中或取消所有按钮
/*function selectAllBtn(obj) {
	var btnCheckBox = $("input[name='operButton']");
	if(btnCheckBox.length > 0) {
		//第二个值是选择范围
		for( i = 0; i < btnCheckBox.length; i++) {
			btnCheckBox[i].checked = obj.checked;
		}
	}
	if(!obj.checked){
		$("#tranTR").hide();
		$("#backMailRangeTR").hide();
		$("#addSignTR").hide();
		$("#tranReadTR").hide();
	}else{
		showTranTR();
		checkBackButton();
		showAddSignTR();
		showTranReadTR();
	}
	clickSelfsend();
}*/

function selectAllBtn(obj){
    if(obj.checked == true){
 		$("input[name='operButton']").each(function(){
			//alert($(this).attr("checked"));
			//alert($(this).prop("checked"));
			//alert($(this).prop("value"));
			//alert($(this).val());
 		    $(this).prop("checked",true);		
 	    });
 	}else{
 		$("input[name='operButton']").each(function(){
 		     //$(this).attr("checked",false);
			 $(this).prop("checked",false);
 	    });
 	}

	showTranTR();
	checkBackButton();
	showAddSignTR();
	showEdAddSignTR();
	showTranReadTR();
	clickSelfsend();
	showDispenseTR();
	//渲染
    setCheckStyle();
}

/**
渲染checkbox
*/
function  setCheckStyle(){
	if(initDataStatus=="0"){ 
    }
}



//设置参与者使用的js
function clickParticipantType(obj) {
	if(obj.value == "someUsers") {
		$("#hxr").show();//document.all.hxr.style.display = "";
		$("#qbblr").hide();//document.all.qbblr.style.display = "none";
		$("#bdzd").hide();//document.all.bdzd.style.display = "none";
		$("#participantRole").hide();//document.all.participantRole.style.display = "none";
		$("#zdzz").hide();//document.all.zdzz.style.display = "none";
		$("#xdqz").hide();//document.all.xdqz.style.display = "none";
	} else if(obj.value == "setAllTransactors") {
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
	} else if(obj.value == "someScope") {
		$("#hxr").hide();
		$("#qbblr").hide();
		$("#bdzd").hide();
		$("#participantRole").hide();
		$("#zdzz").show();
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
 
 */
function needPassRount(obj) {
	needPassRount_withValue(obj.value);
	//按钮阅件事件
}
/**
*/
function needPassRount_withValue(needValue){
	//
	if(needValue == 0) {
		if($("#nodeCommentField").length>0){
			//document.XX.passRoundCommFieldType[2].onclick(); //nodeCommentFieldClick(this)
			$("#passNodeCommentField").val("nullCommentField");
			$("#passNodeCommentFieldsDiv").hide();
		}
        $("#needPassRound_tr").hide();
		if($("#needPassRoundTR").length>0){
			$("#needPassRoundTR").hide();
		}
		$('input:checkbox[name="operButton"]').eq(3).prop("checked",false);	
	} else {
		$("#needPassRound_tr").show();
		if($("#needPassRoundTR").length>0){
			$("#needPassRoundTR").show();
		}
		$('input:checkbox[name="operButton"]').eq(3).prop("checked",true);	
	}
    //渲染
    setCheckStyle();

}

//阅件办理人选择事件
function clickPassRoundUserType(obj) {
	if(obj.value == "someUsers") {
		$("#passhxr").show();
        $("#passqbblr").hide();
		$("#passbdzd").hide();
		$("#passRoundRole").hide();
		$("#passRoundzdzz").hide();
		$("#passRoundxdqz").hide();
	} else if(obj.value == "setAllTransactors") {
		$("#passhxr").hide();
        $("#passqbblr").show();
		$("#passbdzd").hide();
		$("#passRoundRole").hide();
		$("#passRoundzdzz").hide();
		$("#passRoundxdqz").hide();
	} else if(obj.value == "someField") {
		$("#passhxr").hide();
        $("#passqbblr").hide();
		$("#passbdzd").show();
		$("#passRoundRole").hide();
		$("#passRoundzdzz").hide();
		$("#passRoundxdqz").hide();
	} else if(obj.value == "systemRole") {
		$("#passhxr").hide();
        $("#passqbblr").hide();
		$("#passbdzd").hide();
		$("#passRoundRole").show();
		$("#passRoundzdzz").hide();
		$("#passRoundxdqz").hide();
	} else if(obj.value == "someScope") {
		$("#passhxr").hide();
        $("#passqbblr").hide();
		$("#passbdzd").hide();
		$("#passRoundRole").hide();
		$("#passRoundzdzz").show();
		$("#passRoundxdqz").hide(); 
	} else if(obj.value == "someGroups") {
	    $("#passhxr").hide();
        $("#passqbblr").hide();
		$("#passbdzd").hide();
		$("#passRoundRole").hide();
		$("#passRoundzdzz").hide();
		$("#passRoundxdqz").show(); 
	}else{
		$("#passhxr").hide();
        $("#passqbblr").hide();
		$("#passbdzd").hide();
		$("#passRoundRole").hide();
		$("#passRoundzdzz").hide();
		$("#passRoundxdqz").hide(); 
	}
	if(obj.value == "setByInterface") {
		$("#passRoundUserinterfacetr").show(); 
	} else {
		$("#passRoundUserinterfacetr").hide();
	}
}

//批示意见点击事件
function nodeCommentFieldClick(obj){
	if(obj.value==""){//批示意见对应字段
		//显示字段选择div
		$("#nodeCommentFieldsDiv").show();
	}else if(obj.value=="nullCommentField"){//无批示意见字段 
		$("#nodeCommentFieldsDiv").hide();
	}else if(obj.value=="autoCommentField"){//自动追加字段
		$("#nodeCommentFieldsDiv").hide();
	}
}


//阅办意见点击事件
function passRoundCommFieldSel_ck(obj) {
	if($("#passNodeCommentFieldsDiv").length>0) {
		if(obj.value == 'autoCommentField') {
			$("#passNodeCommentFieldsDiv").hide();
		} else if(obj.value == 'nullCommentField') {
			//无批示意见
			$("#passNodeCommentFieldsDiv").hide();
		} else {
			$("#passNodeCommentFieldsDiv").show();
				
		}
	}
}

//办理期限使用的js
function clickPressType(value) {
	if(value == 0) {
		$("#show_box04").hide();
		$("#show_box03").hide();
		$("#show_box05").hide(); 
	} else if(value == 1) {
		$("#show_box03").show();
		$("#show_box04").hide();	
		$("#show_box05").show(); 
	} else if(value == 2) {
		$("#show_box03").hide();
		$("#show_box04").show();	
		$("#show_box05").show();
	}
}

/**
判断是否 有buttonValue这个值
*/
function getOperButtonCheckByValue(buttonValue){
	var result=false;
	$("input[name='operButton']").each(function(){
            if($(this).prop("checked")){
				if($(this).prop("value")==buttonValue){
				    result=true;
					return false;
				}
			}
			
 	 });
	 return result;
}

//转办
function showTranTR(){
	if(getOperButtonCheckByValue("EzFlowTransfer")){
		 $("#tranTR").show();
	}else{
		$("#tranTR").hide();
	}

	var tranType_v=getRadioValue("EzFlowTransfer");
	if(tranType_v=="4"){
		$("#tranCustomTR").show();
	}else{
	    $("#tranCustomTR").hide();
	}
}

/**
取radio的值
*/
function getRadioValue(name){
    var choosedActivityIdObj=document.getElementsByName(name);
    var value="";
	if(choosedActivityIdObj){
		if(choosedActivityIdObj.length>0){
			if(choosedActivityIdObj.length>1){
				for(var i=0;i<choosedActivityIdObj.length;i++){
				   if(choosedActivityIdObj[i].checked){
					   value=choosedActivityIdObj[i].value;
					   //break  保证是第一个 选中的
					   break;
				   } 
				}
			}else{
				//if(choosedActivityIdObj.checked){
				   value=choosedActivityIdObj.value;
				//}
			}
		}
	}
	return value;
}
 
 
//加签
function  showAddSignTR(){
	if(getOperButtonCheckByValue("EzFlowAddSignTask")){
		 $("#addSignTR").show();
	}else{
		$("#addSignTR").hide();
	}
    
	var addSignType_v=getRadioValue("EzFlowAddSignTask");
	if(addSignType_v=="4"){
		$("#addSignCustomTR").show();
	}else{
	    $("#addSignCustomTR").hide();
	}
}

//补签
function showEdAddSignTR(){
	if(getOperButtonCheckByValue("EdAddSign")){
		 $("#edaddSignTR").show();
	}else{
		$("#edaddSignTR").hide();
	}
    
	var addSignType_v=getRadioValue("EdAddSign");
	if(addSignType_v=="4"){
		$("#edaddSignCustomTR").show();
	}else{
	    $("#edaddSignCustomTR").hide();
	}
}
 
 
//分发选择
function showDispenseTR(){

	if(getOperButtonCheckByValue("Sendclose")){
		 $("#dispenseTR").show();
	}else{
		$("#dispenseTR").hide();
	}
    
	var addSignType_v=getRadioValue("Sendclose");
	if(addSignType_v=="4"){
		$("#dispenseCustomTR").show();
	}else{
	    $("#dispenseCustomTR").hide();
	}
}
 
 

//转阅
function showTranReadTR(){
	if(getOperButtonCheckByValue("EzFlowTranRead")){
		 $("#tranReadTR").show();
	}else{
		$("#tranReadTR").hide();
	}
    
	var tvalue=getRadioValue("EzFlowTranRead");
	if(tvalue=="4"){
		$("#tranReadCustomTR").show();
	}else{
	    $("#tranReadCustomTR").hide();
	}
}
 

//选择退回按钮的事件
function  checkBackButton(obj){
    if(getOperButtonCheckByValue("EzFlowBackTask")){
		   $("#backMailRangeTR").show();		   		    
	}else{
          $("#backMailRangeTR").hide();
	}
}
 

 
 //阅件
 function clickSelfsend(){ 
	  //有阅件按钮
	  if(getOperButtonCheckByValue("EzFlowSendReadTask")){
		   $('input:radio[name="taskNeedRead"]').eq(1).attr("checked",'checked');
		   needPassRount_withValue(1);
	  }else{
		   $('input:radio[name="taskNeedRead"]').eq(0).attr("checked",'checked');
		   needPassRount_withValue(0);
	  }
      //渲染
      setCheckStyle();
 }
 
 
 //检查为空
function checkEmpty(fieldname,showname){
	var filedctl = $("*[name='"+fieldname+"']");
	if(filedctl != null && filedctl.length > 0 ){
		if(filedctl[0].value == "" || filedctl[0].value.replace(/(^\s*)|(\s*$)/g, "") == "" ){
			alert(showname + "不能为空！");
			try{
				filedctl[0].focus();
			}catch(e){
			}
			return false;
		}else if( filedctl[0].value.indexOf("'") >= 0 ){
			alert(showname + "不能有'号！");
			return false;
		}
	}
	return true;
}
 
 
function transferOptions(srcObj,desObj){
   if($("#"+srcObj+" option:selected").length>0){
　　　 $("#"+srcObj+" option:selected").each(function(){
　　　　　  $("#"+desObj).append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
　　　　　  $(this).remove();　
　　　 })
   } else { 
      $.dialog.alert("请选择字段！",function(){});
　 } 
}


function transferOptionsAll(srcObj,desObj){ 
    if($("#"+srcObj+" option").length>0){
　　　 $("#"+srcObj+" option").each(function(){ 
　　　　　  $("#"+desObj).append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option>");
　　　　　  $(this).remove();　
　　　 })
   } else {
　　　 $.dialog.alert("请选择字段！",function(){});
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
上传办件接口
*/
function participantClassNameJs(json){
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#participantClassName").val(file_name+file_type);
}


/**
上传阅件接口
*/
function  passRoundUserClassNameJs(json){
	 var file_type=json.file_type; 
	 var save_name=json.save_name;
	 var file_name=json.file_name;
	 $("#passRoundUserClassName").val(file_name+file_type);
}

var trIndexNum=0;

function addRow(pp){
 
	var index = -1;
	var table = document.getElementById("dispTable"); 
	var parentTr=null;
    if(pp != null){
		    parentTr = $(pp).parent().parent();  
			var f_tableName_tr_html=parentTr.html();
			parentTr.after($('<tr>'+f_tableName_tr_html+'</tr>'));
	 }else{ 
          parentTr = $("#dispTable tr:last");  
		  var f_tableName_tr_html=parentTr.html();
		  parentTr.after($('<tr>'+f_tableName_tr_html+'</tr>'));  
	 } 

	 trIndexNum=trIndexNum+1;  
	 var  tdhtml='<select  name="customPressUserIds_select" id="customPressUserIds_select" class="selectlist"  style="width:120px;height:29px">'+
			   '<option value="$-1$">无</option><option value="$-2$">当前办理人</option><option value="$-3$">当前办理人上级领导</option>'+
	           '<option value="$-4$">当前办理人分管领导</option><option value="$-5$">当前办理人部门领导</option></select>'+
		       '<input type="hidden"  name="dispTable_index"  value="'+trIndexNum+'">'+
		       '<input type="hidden" name="customPressUserIds'+trIndexNum+'" id="customPressUserIds'+trIndexNum+'" value="">'+
		       '<input  name="customPressUserNames'+trIndexNum+'" id="customPressUserNames'+trIndexNum+'"    type="text" class="inputText"    style="width:40%" readonly>'+
		       '<a href="#" class="selectIco" onclick="openSelect({allowId:\'customPressUserIds'+trIndexNum+'\', allowName:\'customPressUserNames'+trIndexNum+'\', select:\'user\', single:\'yes\', show:\'userorggroup\', range:\'*0*\'});"><img src="/defaultroot/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>';
     //").next("tr")
	 //$("#dispTable tr:last td:last").html(tdhtml);  
	 //$(parentTr).next("td").eq(-2).html(tdhtml);

	  $(parentTr).next("tr").find("td").eq(-2).html(tdhtml);
	// $("#dispTable tr:last td").eq(-2).html(tdhtml);
}
function delRow(pp){
	/*var index = -1;
	var table = document.getElementById("dispTable");   
	for (var i=0; i < table.rows.length; i++) //遍历table的行,
	{ 

		if(pp==table.rows[i].cells[5].getElementsByTagName("IMG")[1]) //cells[2]为触发事件的列的索引
		{ //判断是否是触发事件的A标签
		// alert(table.rows[i].cells[0].innerText); //演示,弹出所在行的第一列的内容   
		index = i;
		break;
		} 
	} 
	var totalRows = table.rows.length;
	if(totalRows> 2){
	   table.deleteRow(index);
	}*/
    var table = document.getElementById("dispTable");
	var totalRows = table.rows.length;
	if(totalRows> 2){
	   $(pp).parent().parent().remove(); 
	}
 

}

//全选所有
function selectAllField(o,n){	
	$("input[name='"+n+"']").each(function(){
		if(this.disabled){
			
		}else{
			this.checked = o.checked;
			if(n == 'nodeProtectedField') return;
			disableOthers(this);
		}
	});
	setCheckStyle();
}

//禁止其他字段
function disableOthers(o){
	var v = o.value;
	var n = o.name;
	var c = o.checked;
	var c1 = $("input[name='nodeWriteField'][value='"+v+"']");
	//var c2 = $("input[name='nodeProtectedField'][value='"+v+"']");
	var c3 = $("input[name='nodeHiddenField'][value='"+v+"']");
	
	if(c1.length >0 && c1[0].name != n){
		c1[0].disabled = c;
	}
	//if(c2.length >0 && c2[0].name != n){
	//	c2[0].disabled = c;
	//}
	if(c3.length >0 && c3[0].name != n){
		c3[0].disabled = c;
	}
	
}
 

function changerFormKey(formKey){ 
	if(formKey!=null){
		 $("#formType").val(formKey.substring(formKey.length-1));
		 formKey=formKey.substring(0,formKey.length-1);
		//alert("formKeyformKey:"+formKey);  
	} 

	var result = $.ajax({
	  url: "/defaultroot/ezflowprocess!getFieldByForm.action?formKey="+encodeURIComponent(formKey)+"&formType="+$("#formType").val()+"&moduleId="+$("#moduleId").val(),
	  async: false
	}).responseXML;
 
   
	$("#nodeCommentFieldsDiv").html("");
	$("#passNodeCommentFieldsDiv").html("");
	
	//写控制： 源字段 
	var field1Select = $("select[name='field1']");//全部字段下拉框
	//清空
	if(field1Select.length >0 ){
		var alloptions = field1Select[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			field1Select[0].remove(j);
		}
	}

	//写控制： 读字段：
	var readFieldsSelect = $("select[name='readFields']");//全部字段下拉框
	//清空
	if(readFieldsSelect.length >0 ){
		var alloptions = readFieldsSelect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			readFieldsSelect[0].remove(j);
		}
	}

	//写控制： 写字段：
	var writeFieldsSelect = $("select[name='writeFields']");//全部字段下拉框
	//清空
	if(writeFieldsSelect.length >0 ){
		var alloptions = writeFieldsSelect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			writeFieldsSelect[0].remove(j);
		}
	}


	//签章保护字段： 源字段：
	var field2Select = $("select[name='field2']");//全部字段下拉框
	//清空
	if(field2Select.length >0 ){
		var alloptions = field2Select[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			field2Select[0].remove(j);
		}
	}
	
	//保护字段：
	var protectedFieldsSelect = $("select[name='protectedFields']");//全部字段下拉框
	//清空
	if(protectedFieldsSelect.length >0 ){
		var alloptions = protectedFieldsSelect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			protectedFieldsSelect[0].remove(j);
		}
	}

	//隐藏字段设置：源字段：
	var field3Select = $("select[name='field3']");//全部字段下拉框
	//清空
	if(field3Select.length >0 ){
		var alloptions = field3Select[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			field3Select[0].remove(j);
		}
	}

	//隐藏字段：
	var field3Select = $("select[name='field3']");//全部字段下拉框
	//清空
	if(field3Select.length >0 ){
		var alloptions = field3Select[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			field3Select[0].remove(j);
		}
	}

	var hiddenFieldsSelect = $("select[name='hiddenFields']");//可写字段下拉框
	//清空
	if(hiddenFieldsSelect.length >0 ){
		var alloptions = hiddenFieldsSelect[0].options;
		for( j=alloptions.length-1;j>=0;j--){
			hiddenFieldsSelect[0].remove(j);
		}
	}

	//
	var form2Select = $("select[name='customFieldName']");//下拉框
	//清空
	if(form2Select.length >0 ){
		for( k =0;k<form2Select.length;k++){
			var alloptions = form2Select[k].options;
			for( j=alloptions.length-1;j>=0;j--){
				form2Select[k].remove(j);
			}
		}
	}


	form2Select.append("<option value='condi_initiatorDuty'>启动人职务</option>");
	form2Select.append("<option value='condi_initiatorDutyLevel'>启动人职务级别</option>");
	form2Select.append("<option value='condi_preTransactorDutyLevel'>上一活动办理人职务级别</option>");
	form2Select.append("<option value='condi_initiatorLeaderDutyLevel'>启动人上级领导职务级别</option>");   
	form2Select.append("<option value='condi_preTransactorLeaderDutyLevel'>上一活动办理人上级领导职务级别</option>");
	form2Select.append("<option value='condi_initiatorOrgName'>启动人组织</option>");
	form2Select.append("<option value='condi_initiatorLeaderUserAccount'>启动人上级领导账号</option>");
	form2Select.append("<option value='condi_initiatorDepartLeaderUserAccount'>启动人部门领导账号</option>");
	form2Select.append("<option value='condi_initiatorChargeLeaderUserAccount'>启动人分管领导账号</option>");
 
	
	/*while(fieldTable.rows.length -3 > 0){
		fieldTable.deleteRow(1); 
	}*/

	var passRoundUserFieldSelect = $("select[name='passRoundUserField']");//下拉框 
	var participantUserFieldSelect = $("select[name='participantUserField']");//下拉框 
	var inputnum = 0;

	var fieldTableObj = $('#fieldTable'); 
	//$("table tbody tr").eq(0).nextAll().remove();
	while ($('#fieldTable').find("tr").length>1)
	{
		$('#fieldTable').find("tr").eq(1).remove();
	}


	 ///var tab = $('#fieldTable');       //获取table的对象
    // if($('#fieldTable').find("tr").leng)
    // tab.find("tr").eq(4).remove(); //删除第5行，eq的下标是从0开始。
 

	//$("#fieldTable tbody tr").eq(1).nextAll().remove(); 
 
	//加载
	//if(field1Select.length >0 ){
		$(result).find("field").each(function(i){    
			var fieldid=$(this).children("fieldid").text();   
			var fieldtext=$(this).children("fieldtext").text();   
			var fieldtype=$(this).children("fieldtype").text(); 
			//alert(1);
			var tableType=$(this).children("tabletype").text(); 
            var row = $('<tr></tr>'); 
			var newOpt ; 
		    var td0 = $('<td  bgcolor="#F0F0F0"  class="table_linebottom" align="left" >'+fieldtext+'</td>'); 
			var td1 = $('<td  align="center" ></td>'); 
            td1.append("<input name='nodeWriteField' type='checkbox'  onclick='disableOthers(this)'  value='"+fieldid+"'>"); 
		    var td2 = $('<td>&nbsp;</td>'); 
			var td4 = $('<td>&nbsp;</td>'); 
			var td6 = $('<td>&nbsp;</td>'); 
			var td7 = $('<td>&nbsp;</td>');
			var td3 = $('<td  align="center" ></td>');              
            if(fieldtype == '401'){
				 td3.append("<input name='nodeProtectedField' type='checkbox' disabled  value='"+fieldid+"'>");  
			}else{
				 td3.append("<input name='nodeProtectedField' type='checkbox'  value='"+fieldid+"'>");  
			}
		
			var td5 = $('<td  align="center" ></td>'); 
			td5.append("<input name='nodeHiddenField' type='checkbox'  onclick='disableOthers(this)' value='"+fieldid+"'>");  
             
			row.append(td0);
			row.append(td1);
			row.append(td2);
			row.append(td3);
			row.append(td4);
			row.append(td5);
			row.append(td6);
			row.append(td7);
			
			//表单控制：不显示批示意见字段
			if(fieldtype != '401'){
				fieldTableObj.append(row);
			}


			if(tableType == 0){
				return;
			}

			//202 登入人姓名 fieldtype == "202" ||      fieldtype == ("215")||
			if(fieldtype == ("210")||fieldtype == ("211")||fieldtype == ("704")||fieldtype == ("705")){ 
                 //由字段决定 加字段
				 $("#passRoundUserField").append("<option value='"+fieldid+"'>"+fieldtext+"</option");
				 $("#participantUserField").append("<option value='"+fieldid+"'>"+fieldtext+"</option");
			}
            
			//疑问
			/*for( k =0;k<form2Select.length;k++){
				var alloptions = form2Select[k].options;
				newOpt =document.createElement("OPTION");
				newOpt.value=fieldid;
				newOpt.text =fieldtext;
				form2Select[k].add(newOpt);
			}*/

			if(form2Select.length >0 ){
                 form2Select.append("<option value='"+fieldid+"'>"+fieldtext+"</option>");
			}




			//批示意见字段只加批示意见字段
			if(fieldtype == '401'){
				inputnum ++;
				if(inputnum % 8 == 0){
					//$("#processRemindFieldDiv").append("<br/>");
				}
				$("#nodeCommentFieldsDiv").append("<input name='nodeCommentFields' type='radio' value='"+fieldid+"' text='"+fieldtext+"'>"+fieldtext);
				//if( $("#passRoundCommFieldType").val() == ""){
				if($("#passNodeCommentFieldsDiv").length>0){
					$("#passNodeCommentFieldsDiv").append("<input name='passNodeCommentFields' type='radio'  value='"+fieldid+"' text='"+fieldtext+"'>"+fieldtext);
				}else{
					$("#passNodeCommentFieldsDiv").append("<input name='passNodeCommentFields' type='radio'  value='"+fieldid+"' text='"+fieldtext+"'>"+fieldtext);
				}
			}


		});  
		
  
		$('#fieldTable').append('<tr class="Table_nobttomline" ><td></td><td colspan="7"><input type="button" class="btnButton4font" onClick="save(\'trueModify\');" value=\''+workflowMessage_js.saveclose+'\' />&nbsp;<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value=\''+workflowMessage_js.reset+'\' />&nbsp;<input type="button" class="btnButton4font" onClick="window.close();" value=\''+workflowMessage_js.exit+'\'/></td></tr>');

		setCheckStyle();
		
	//}
}

function  initSystem(){
   /* setInputStyle();
    digitCheck();
    $("input[type='hidden'],select").each(function(){
        $(this).attr("defaultValue",$(this).val());
    });*/
}



//初始化ext combox
function  initExt(){ 
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
	 



   //阅件 参与人 角色选择 角色
	var cb4= new Ext.form.ComboBox({
		id : 'passRole_extId',  
		typeAhead: true,
		triggerAction: 'all',
		transform:'passRole',
		width:360,
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){ 		 
				}
			}
		}
	});  
	//阅件 参与人 角色选择  组织
	var cb5= new Ext.form.ComboBox({
		id : 'passOrg_extId',  
		typeAhead: true,
		triggerAction: 'all',
		transform:'passOrg',
		width:360,
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){ 
					 // roleOrgchange(this,'passOrgLevelId'); 
					 roleOrgchange('passOrg','passOrgLevelId','');
				}
			}
		}
	}); 

	   //群组  组织
	var cb5= new Ext.form.ComboBox({
		id : 'passPartgGroupOrg_extId',  
		typeAhead: true,
		triggerAction: 'all',
		transform:'passPartgGroupOrg',
		width:360,
		forceSelection:true, 
		listeners:{
			select:{
				fn:function(combo, record, index){  
					 roleOrgchange('passPartgGroupOrg','passPartgGroupOrgLevelID','passaddressTypeSpan');
				}
			}
		}
	}); 
}



function  initChange(){
   $('#formKey').change(function(){changeFormKey();});  
   $('#partRoleOrg').change(function(){roleOrgchange('partRoleOrg','partRoleOrgLevelID','');});  
   $('#partgGroupOrg').change(function(){roleOrgchange('partgGroupOrg','partgGroupOrgLevelID','addressTypeSpan');});  

   
   $('#passOrg').change(function(){roleOrgchange('passOrg','passOrgLevelId','');});  
   $('#passPartgGroupOrg').change(function(){roleOrgchange('passPartgGroupOrg','passPartgGroupOrgLevelID','passaddressTypeSpan');});  
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

function clickActivityTips(value){
	if(value=="0"){
		$("#activityTipTitle_tr").hide();
		$("#activityTipCotent_tr").hide();
	}else{
		$("#activityTipTitle_tr").show();
		$("#activityTipCotent_tr").show();
	}
}