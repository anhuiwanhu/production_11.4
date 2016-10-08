//选择用户【返回】
function retUserOK(selectUserName, selectUserId){
	var newtype =$('#newtype').val();
	var selectType =$('#selectType').val();
	var userNames =$("#userNames").val();
	var userIds =$("#userIds").val();
	var banliUserId ="";
	var banliUserName ="";
	if(userIds =="" || userNames ==""){
		alert("请选择用户！");
	}else{
		//alert("newtype:"+newtype+"|selectType:"+selectType+"|banliUserId:"+userIds+"|banliUserName:"+userNames);
		if(selectType == "checkbox"){//多选人
			var userIdsObj   =userIds.split(",");
			var userNamesObj =userNames.split(",");
			for(var i=0;i<userIdsObj.length;i++){
				banliUserId += "$"+userIdsObj[i]+"$";
				banliUserName += userNamesObj[i]+",";
			}
		}else{//单选人
			banliUserId = userIds;
			banliUserName =userNames;
		}
		//alert("newtype:"+newtype+"|selectType:"+selectType+"|banliUserId:"+banliUserId+"|banliUserName:"+banliUserName);
		hiddenDiv(1);
		retSelectUser(selectUserName, selectUserId, newtype, selectType, banliUserId, banliUserName);
	}
}

function retSelectUser(selectUserName, selectUserId ,newtype, selectType, banliUserId, banliUserName){
	if(newtype == '0'){//适用新建流程选人字段
		document.getElementById(selectUserName).value = banliUserName;
		document.getElementById(selectUserId).value   = banliUserName+";"+banliUserId;
	}else{
		document.getElementById(selectUserName).value = banliUserName;
		document.getElementById(selectUserId).value   = banliUserId;
	}
}

//选择组织【返回】
function retOrgOK(selectUserName, selectUserId){
	var selectType =$('#selectType').val();
	var orgIds =$('#orgIds').val();
	var orgNames =$('#orgNames').val();
	var banliOrgId ="";
	var banliOrgName ="";
	if(orgIds =="" || orgNames ==""){
		alert("请选择组织！");
	}else{
		if(selectType == "checkbox"){//多选组织
			var orgIdsObj   =orgIds.split(",");
			var orgNamesObj =orgNames.split(",");
			for(var i=0;i<orgIdsObj.length;i++){
				banliOrgId += "$"+orgIdsObj[i]+"$";
				banliOrgName += orgNamesObj[i]+",";
			}
		}else{
			banliOrgId =orgIds;
			banliOrgName =orgNames;
		}
		hiddenDiv(1);
		retSelectOrg(selectUserName, selectUserId, banliOrgId, banliOrgName);
	}
}

function retSelectOrg(selectUserName, selectUserId, banliOrgId, banliOrgName){
	document.getElementById(selectUserName).value = banliOrgName;
	document.getElementById(selectUserId).value   = banliOrgName+";"+banliOrgId;
}

/*
 * 打开弹出框
 * @param {Object} openJson
 */
function openDialog(openJson){
	var paramJson = {param_1:''};
}

/*
 * 打开提示弹出框
 * @param {Object} tipContent
 * @param {Object} title
 * @param {Object} time
 * @return {TypeName} 
 */
function openTipsDialog(tipContent,title,time){
	return $.dialog({
        content : tipContent,
        title :	title,
        time : time
    });
}

//文字纯色背景图标数组
var iconClassArray = ['icon-font-acd598','icon-font-8f82bc','icon-font-84ccc9',
					  'icon-font-c989be','icon-font-f29c9f','icon-font-facd89',
					  'icon-font-d5b798','icon-font-7ecef4','icon-font-82bc90','icon-font-c6c1ba'];

/*
 * 获取随机icon class样式
 */
function getIconClass(){
	var random = Math.random();
	var index = Math.round(random * (iconClassArray.length-1));
	return iconClassArray[index];
}

/*
 * 获取随机icon样式
 * @return {TypeName}
 */
function setIconClass($objs){
	if($objs){
		$objs.each(function(){
			if($(this).attr('class') == 'icon'){
				$(this).addClass(getIconClass());
			}
		});
	}
	/*
	var icon_obj = document.getElementById(iconId);
	if(icon_obj.className){
		icon_obj.setAttribute("class", icon_obj.className + ' ' + iconClass);
	}else{
		icon_obj.setAttribute("class", iconClass);
	}
	*/
}   
//自定义表单验证
function confirmForm(){
	var tipsName = '';
	var checkOk = true;
	var $parentObj;
	var $childrenObj;
	var objValue;
	var tipsName;
	var checkboxFlag = true;
	$('table tr th i').each(function(){
		$parentObj = $(this).parent();
		tipsName = $parentObj.text().replace('：','');
		$parentObj.next('td').find('input[type!="file"],textarea,select').each(function(){
			$childrenObj = $(this);
			objValue = $childrenObj.val();
			if($childrenObj.attr('type') != 'checkbox'){
				if(objValue.replace(/\s/g,"")==""){
					alert(tipsName.trim()+'不能为空！');
	    			checkOk = false;
	    			return false;
				}
			}else{//checkbox单独验证
				checkboxFlag = false;
				checkOk = false;
				if($childrenObj.is(':checked')){
					checkOk = true;
					checkboxFlag = true;
					return false;
				}
			}
		});
		//checkbox单独验证
		if(!checkboxFlag){
			alert(tipsName.trim()+'不能为空！');
			checkOk = false;
			return false;
		}
		//select text textarea验证
		if(!checkOk){
			return false;
		}
	});
	return checkOk;
}

//将数字转换成大写的人民币

function changeNumMoneyToChinese(money) {

　　var cnNums = new Array("零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖"); //汉字的数字

　　var cnIntRadice = new Array("", "拾", "佰", "仟"); //基本单位

　　var cnIntUnits = new Array("", "万", "亿", "兆"); //对应整数部分扩展单位

　　var cnDecUnits = new Array("角", "分", "毫", "厘"); //对应小数部分单位

　　var cnInteger = "整"; //整数金额时后面跟的字符

　　var cnIntLast = "元"; //整型完以后的单位

　　var maxNum = 999999999999999.9999; //最大处理的数字

　　var IntegerNum; //金额整数部分

　　var DecimalNum; //金额小数部分

　　var ChineseStr = ""; //输出的中文金额字符串

　　var parts; //分离金额后用的数组，预定义

　　if (money == "") {

　　return "";

　　}

　　money = parseFloat(money);

　　if (money >= maxNum) {

　　alert('超出最大处理数字');

　　return "";

　　}

　　if (money == 0) {

　　ChineseStr = cnNums[0] + cnIntLast + cnInteger;

　　return ChineseStr;

　　}

　　money = money.toString(); //转换为字符串

　　if (money.indexOf(".") == -1) {

　　IntegerNum = money;

　　DecimalNum = '';

　　} else {

　　parts = money.split(".");

　　IntegerNum = parts[0];

　　DecimalNum = parts[1].substr(0, 4);

　　}

　　if (parseInt(IntegerNum, 10) > 0) { //获取整型部分转换

　　var zeroCount = 0;

　　var IntLen = IntegerNum.length;

　　for (var i = 0; i < IntLen; i++) {

　　var n = IntegerNum.substr(i, 1);

　　var p = IntLen - i - 1;

　　var q = p / 4;

　　var m = p % 4;

　　if (n == "0") {

　　zeroCount++;

　　} else {

　　if (zeroCount > 0) {

　　ChineseStr += cnNums[0];

　　}

　　zeroCount = 0; //归零

　　ChineseStr += cnNums[parseInt(n)] + cnIntRadice[m];

　　}

　　if (m == 0 && zeroCount < 4) {

　　ChineseStr += cnIntUnits[q];

　　}

　　}

　　ChineseStr += cnIntLast;

　　//整型部分处理完毕

　　}

　　if (DecimalNum != '') { //小数部分

　　var decLen = DecimalNum.length;

　　for (var i = 0; i < decLen; i++) {

　　var n = DecimalNum.substr(i, 1);

　　if (n != '0') {

　　ChineseStr += cnNums[Number(n)] + cnDecUnits[i];

　　}

　　}

　　}

　　if (ChineseStr == '') {

　　ChineseStr += cnNums[0] + cnIntLast + cnInteger;

　　} else if (DecimalNum == '') {

　　ChineseStr += cnInteger;

　　}

　　return ChineseStr;
}
