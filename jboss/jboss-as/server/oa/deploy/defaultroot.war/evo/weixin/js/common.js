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
