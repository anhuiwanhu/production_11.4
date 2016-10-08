/**预算流程选择预算部门*/
function budgetSectionChoose(text,value,obj,evt){//"whir$t3217_f4031_txt","whir$t3217_f4031"
	var	budgetSection=findFieldValue("budgetSection",value.split('_')[0]);
	var index=findIndex(budgetSection,value.split('_')[0],obj,evt);
	var budgetSectionIds ='';
	budgetSectionIds = $('input[name=' + value.replace("$", "\\$") + ']')[index].value;

	if(budgetSectionIds !=''){
		budgetSectionIds = budgetSectionIds.split(';')[0];
	}
	var url=whirRootPath + '/budgetSection!sectionChooseList.action?forward=sectionChoose&rowIndex=' + index +'&wait=1&opt=1&type=radio&ids=' + budgetSectionIds+'&id=' + value.replace("$", "\\$") +'&name=' + text.replace("$", "\\$") + '&from=wf';
   openWin({url:url,width:600,height:400,winName:'selSection'});
}

//查找顺序值
	function findIndex(field,tableId,obj,evt){
		var popIndex = 0;
		var target = window.event?window.event.srcElement.parentElement:evt.target.parentNode;
		var field_obj = document.getElementsByName(field);
		for (var i = 0; i < field_obj.length; i++) {
			var val=field_obj[i].value;
			var parentElement=window.event?field_obj[i].parentElement:field_obj[i].parentNode;
			if (target == parentElement) {
				popIndex=i;
				break;
			}
		}
		return popIndex;
	}
//根据input的name和子表名称查找相应字段的值
	function findFieldValue(field,tableId){
		var value = '';
		var field_obj = document.getElementsByName(field);
		for (var i = 0; i < field_obj.length; i++) {
			var val=field_obj[i].value;
			if(val.indexOf(tableId) >= 0 ){
				value = val;
				break;
			}
		}
		return value;
	}
/**预算流程选择预算科目*/
function budgetSubjectChoose(text,value,obj,evt){
	var tableIds=null;
	if(document.getElementById('showTable')){
		tableIds=$('input[name=showTable]');
	}else if(document.getElementById('hiddenTable')){
		tableIds=$('input[name=hiddenTable]');
	}
	
	var	budgetSubjectObj=null;
	var	budgetSection=null;
	var	budgetBalance=null;
	var	budgetYearMonth=null;
	
	//<input type="hidden" id="isEzForm" name="isEzForm" value="1"/>
		var isOldOrNew='0';
		if(document.getElementById('isEzForm')){
			isOldOrNew=document.getElementById('isEzForm').value;
		}
	if(tableIds == null ){//不带子表的
		 budgetSubjectObj=$('input[name=budgetSubject]').val();
		 budgetSection=$('input[name=budgetSection]').val();
		 budgetBalance=$('input[name=budgetBalance]').val();
		 budgetYearMonth=$('input[name=budgetYearMonth]').val();
	}else{//有子表的
		budgetSubjectObj=findFieldValue("budgetSubject",value.split('_')[0]);
		budgetSection=findFieldValue("budgetSection",value.split('_')[0]);
		budgetBalance=findFieldValue("budgetBalance",value.split('_')[0]);
		budgetYearMonth=findFieldValue("budgetYearMonth",value.split('_')[0]);
	}
	var index=findIndex(budgetSubjectObj,value.split('_')[0],obj,evt);
	var count=budgetSection.length;
	var budgetSectionIds ='';

	budgetSectionIds=$('input[name=' + budgetSection.replace("$", "\\$") + ']')[index].value;	
	var budgetSectionObj = $('input[name=budgetSection]');
	
	if(budgetSectionObj.length>0){
		var budgetSubjectIds = $('input[name=' + value.replace("$", "\\$") + ']')[index].value;
		var processId = "";
		processId=$('input[name="p_wf_pool_processId"]').val();
		if(budgetSectionIds !=''){
			budgetSectionIds = budgetSectionIds.split(';')[0];
		}
		
		if(budgetSectionIds==''){
			whir_alert('请选择预算部门！',null,null);
			return false;
		}
		if(budgetSubjectIds !=''){
			budgetSubjectIds = budgetSubjectIds.split(';')[0];
		}
		
		var url=whirRootPath + '/budgetSubject!subjectChooseList.action?rowIndex=' + index +'&balance=1&wait=1&status=0&from=wf&forward=choose&opt=1&type=radio&ids=' + budgetSubjectIds+'&id=' + value +'&name=' + text + '&sectionids=' + budgetSectionIds + '&p_wf_processId=' + processId+'&budgetYearMonth='+budgetYearMonth+'&budgetBalance='+budgetBalance
		+'&budgetSection='+budgetSection+'&budgetSubject='+value.replace("$", "\\$")
		+'&count='+count+'&isOldOrNew='+isOldOrNew;
		
		openWin({url:url,width:600,height:400,winName:'selSubject'});
	}else{
		whir_alert('请选择预算部门！',null,null);
		return false;
	}
}

//预算余额
function budgetBalanceEvent(budgetBalance,budgetSection,budgetSubject,rowIndex){
	var  decnum=$('input[name=' + budgetBalance.replace("$", "\\$") + ']').attr("decnum");
	var budgetSectionValue='';
	var budgetBudgetSubjectValue='';
		
	budgetSectionValue = $('input[name=' + budgetSection.replace("$", "\\$") + ']')[rowIndex].value;
	budgetBudgetSubjectValue = $('input[name=' + budgetSubject.replace("$", "\\$") + ']')[rowIndex].value;

	var subjectperiod_select = $('input[name=subjectperiod_select]')[rowIndex].value;
		
		if(budgetSectionValue !='' && budgetBudgetSubjectValue !=''){
			//budgetSectionValue = budgetSectionValue.split(';')[0];
			//budgetBudgetSubjectValue = budgetBudgetSubjectValue.split(';')[0];
			var isOldOrNew='0';
			if(document.getElementById('isEzForm')){
				isOldOrNew=document.getElementById('isEzForm').value;
			}
			var p_wf_processId = "";
			processId=$('input[name="p_wf_pool_processId"]').val();
			var  p_wf_recordId=$("#p_wf_recordId").val();
			$.ajax({
			url:whirRootPath + '/modules/subsidiary/budget/getServices.jsp?tag=budgetBalance&sectionid=' + budgetSectionValue +'&subjectid=' + budgetBudgetSubjectValue + "&subjectperiod="+subjectperiod_select+"&p_wf_processId="+p_wf_processId+"&p_wf_recordId="+p_wf_recordId+"&decnum="+decnum+"&" + Math.round(Math.random()*1000),
			type: 'GET',
			data: null,
			timeout: 1000,
			async: false,      //true异，false,ajax同步
			error: function(){
				whir_alert('Error loading XML document',null,null);
			},
			success: function(data){
				data = data.replace(/(^\s*)|(\s*$)/g,"");
				$('input[name=' + budgetBalance.replace("$", "\\$") + ']')[rowIndex].value=data;
			}
			});
	}
}

var twoTip='0';
var	outSectionIds='';
var	outSubjectids='';
var	outSubjectperiod='';
var	outCurAmounts='';
//流程提交控制方式
function beforeSubmitBudgetEvent(){
	var result = true;
	var tableIds;
	var tableId='';
	var tableIds1=null;
	if(document.getElementById('showTable')){
		tableIds1=$('input[name=showTable]');
	}else if(document.getElementById('hiddenTable')){
		tableIds1=$('input[name=hiddenTable]');
	}

	if(tableIds1 != null && tableIds1.length >0){
		for(var i=0;i<tableIds1.length;i++){
			var val=tableIds1[i].value;
			var len=$('#'+val.substring(0, 4)+'\\'+val.substring(4, val.length)+'DIV').find('input[name=budgetSubject]').length;
			if(len > 0){
				tableId+=val+',';
			}
			
		}
	}
	//alert("tableId:"+tableId);
	if(tableId != null && tableId != ''){
		 tableId = tableId.substring(0, tableId.length - 1);
		 tableIds=tableId.split(',');
	}
	
	var budgetSectionObj = $('input[name=budgetSection]');
	var budgetBalanceObj = $('input[name=budgetBalance]');
	var budgetCostObj = $('input[name=budgetCost]');
	var budgetSubjectObj = $('input[name=budgetSubject]');
	var subjectPeriodObj = $('input[name=subjectperiod_select]');

	var sectionIds ='';//待提交检查预算科ID串
	var subjectids='';
	var curAmounts ='';
	var subjectPeriods ='';

	if(budgetSectionObj.length>0 && budgetCostObj.length>0 && budgetSubjectObj.length>0){
		if(tableIds == null ){//不带子表的
			for(var k=0;k<budgetSubjectObj.length;k++){
				var sectionId ='';
				var subjectid = '';
				var subjectperiod = '';
				sectionId =$('input[name=' + $('input[name=budgetSection]').val().replace("$", "\\$") + ']')[k].value;
				subjectid =$('input[name=' + $('input[name=budgetSubject]').val().replace("$", "\\$") + ']')[k].value;
				//subjectperiod =$('input[name=subjectperiod_select]')[k].value;
				subjectperiod =$('input[name=' + $('input[name=budgetYearMonth]').val().replace("$", "\\$") + ']')[k].value;
				
				var curAmount='';
				curAmount = $('input[name=' + $('input[name=budgetCost]').val().replace("$", "\\$") + ']')[k].value;
				//if(curAmount<0) {
				//	whir_alert("预算金额不能小于0！",null,null);
					//$('input[name=' + budgetCostObj[k].value + ']').focus();
					//return false;
				//}
				if(curAmount=="") {//2016/03/24
					curAmount=0;
				}
				if(sectionId !='' && subjectid !=''){
					sectionIds +=sectionId.split(';')[0] + ',';
					subjectids +=subjectid.split(';')[0] + ',';
					curAmounts +=curAmount + ',';
					subjectPeriods +=subjectperiod + ',';
				}
			}
		}else{//有子表的
			if(tableIds != null && tableIds.length >0){
				for(var i=0;i<tableIds.length;i++){
					var val=tableIds[i];
					var	budgetSection=findFieldValue("budgetSection",val);
					var	budgetSubject=findFieldValue("budgetSubject",val);
					var	budgetCost=findFieldValue("budgetCost",val);
					var	budgetYearMonth=findFieldValue("budgetYearMonth",val);
					var	budgetSubjects=$('input[name='+budgetSubject.replace("$", "\\$")+']');
					if(budgetSubjects != null && budgetSubjects.length >0){
						for(var n=0;n<budgetSubjects.length;n++){
							var sectionId ='';
							var subjectid = '';
							var subjectperiod = '';
							sectionId =$('input[name=' + budgetSection.replace("$", "\\$") + ']')[n].value;
							subjectid =$('input[name=' + budgetSubject.replace("$", "\\$") + ']')[n].value;
							subjectperiod =$('input[name=' + budgetYearMonth.replace("$", "\\$") + ']')[n].value;;
							var curAmount='';
							curAmount = $('input[name=' + budgetCost.replace("$", "\\$") + ']')[n].value;
							//if(curAmount<0) {
								//whir_alert("预算金额不能小于0！",null,null);

								//$('input[name=' + budgetCostObj[k].value + ']').focus();
								//return false;
							//}
							if(curAmount=="") {//2016/03/24
								curAmount=0;
							}
							if(sectionId !='' && subjectid !=''){
								sectionIds +=sectionId.split(';')[0] + ',';
								subjectids +=subjectid.split(';')[0] + ',';
								curAmounts +=curAmount + ',';
								subjectPeriods +=subjectperiod + ',';
							}
						}
					}
					
				}
			}
		}

		if(sectionIds !=''){
			sectionIds = sectionIds.substring(0,sectionIds.length-1);
		}
		if(subjectids !=''){
			subjectids = subjectids.substring(0,subjectids.length-1);
		}
		if(curAmounts !=''){
			curAmounts = curAmounts.substring(0,curAmounts.length-1);
		}
		if(subjectPeriods !=''){
			subjectPeriods = subjectPeriods.substring(0,subjectPeriods.length-1);
		}
		
	}

	var year ;
	var month ;
	var subjectperiod_select ;//= $("#subjectperiod_select").val();
	if(document.getElementById("subjectperiod_select")){
	    subjectperiod_select = $("#subjectperiod_select").val();
	}else {
		  subjectperiod_select="";
		  var  budgetYearMonthColumn=$("#budgetYearMonth").val();
		  if(document.getElementById(budgetYearMonthColumn)){
	         subjectperiod_select=document.getElementById(budgetYearMonthColumn).value;
		  }
	}
	if(subjectperiod_select && subjectperiod_select.indexOf("-")>0){
		year = subjectperiod_select.substring(0,4);
		month = subjectperiod_select.substring(5,subjectperiod_select.length);
	}
	if(year !="" && !document.getElementById("adjustyear")){
		$(window.opener.document.body).append('<input type="hidden" id="adjustyear" value="'+year+'">');
	}else{
		$("#adjustyear").attr("value",year);
	}
	if(month !="" &&  !document.getElementById("adjustmonth")){
		$(window.opener.document.body).append('<input type="hidden" id="adjustmonth"  value="'+month+'">');
	}else{
		$("#adjustmonth").attr("value",month);
	}
	
	//alert("sectionIds:"+sectionIds);
	//alert("subjectids:"+subjectids);
	//alert("subjectperiod_select:"+subjectPeriods);
	//alert("curAmounts:"+curAmounts);
	//return;
		var isOldOrNew='0';
		if(document.getElementById('isEzForm')){
			isOldOrNew=document.getElementById('isEzForm').value;
		}
		var p_wf_processId = "";
		processId=$('input[name="p_wf_pool_processId"]').val();
	var  p_wf_recordId=$("#p_wf_recordId").val();
	if(sectionIds !=''){	
		$.ajax({
		url: whirRootPath + '/modules/subsidiary/budget/getServices.jsp?tag=budgetBalanceCheck&sectionIds=' + sectionIds + '&subjectids=' + subjectids + '&subjectperiod='+subjectPeriods+'&curAmounts=' + curAmounts 
		+"&p_wf_processId="+p_wf_processId+"&p_wf_recordId="+p_wf_recordId+ "&" + Math.round(Math.random()*1000),
		type: 'GET',
		data: null,
		timeout: 1000,
		async: false,      //true异，false,ajax同步
		error: function(){
			whir_alert('Error loading XML document',null,null);
		},
		success: function(data){
			data = data.replace(/(^\s*)|(\s*$)/g,"");
			//alert("data:"+data);
			var tip = '';
			if(data !=''){
				var dataArray = data.split(';');
				if(dataArray[1]=='1'){
						result = false;
				}
				tip = dataArray[0] + '\n';
			}
			
			if(tip !=''){
				if(tip.indexOf('没') >= 0){
					result = false;
					whir_alert('您提交的:' + tip + '请申请预算!',null,null);
				}
				if(tip.indexOf('超') >= 0){
					if(twoTip == '0' || outSectionIds != sectionIds || outSubjectids != subjectids ||outCurAmounts != curAmounts){
					//twoTip = '1';
					//outSectionIds = sectionIds;
					//outSubjectids = subjectids;
					//outCurAmounts = curAmounts;
					if(result){
						$("#callBackTips").val("您提交的:" + tip + "请申请预算!");
					}else{
						whir_alert('您提交的:' + tip + '请申请预算!',null,null);
					}
					}
				}
				
			}
		}
		});
	}else{
		return result;
	}
	return result;
}
