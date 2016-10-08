;
var _saveOperateType = 'base';
function confirmSave(obj){
    var _id = $(obj).attr('id');
    _saveOperateType = _id;

    var liVal = $('#whir_tab_ul li.tag_aon').attr('id');
    if(liVal !='inforights' && _id != liVal){
        $.dialog.confirm('您的操作需要保存吗？', yesConfirm, noConfirm, null );
    }else{
        saveSuccess(null);
    }
}

function yesConfirm(){
    var saveOperateType = $('#saveOperateType').val();
    var liVal = $('#whir_tab_ul li.tag_aon').attr('id');

    saveForm(2, null);
}

function noConfirm(){
    saveSuccess(null);
}

function saveSuccess(result){//alert(result);
    var isReapt = 0;
    if(result != null){
        if(result.data){
            var empId = result.data.empId;
            if(empId){
                if($('#action').val()=='add'){
                    $('#action').val('modify');
                    $('#empId').val(empId)
                    var act = $('#dataForm').attr('action');
                    act = act.replace(/saveUser\.action/, 'modifyUser.action');
                    $('#dataForm').attr('action', act);
                }
            }
        }

        if(result.result.indexOf('账号重复')!=-1){//账号或是用户简码重复
            isReapt = 1;
        }else if(result.result.indexOf('用户简码重复')!=-1){
            isReapt = 2;
        }
    }

    if(isReapt == 1 || isReapt == 2){
        $('#saveOperateType').val('base');
        innerTab('base', 'whir_tab_ul');

        if(isReapt == 1){
            $('#userAccounts').focus();
        }else if(isReapt == 2){
            $('#userSimpleName').focus();
        }
    }else{
        $('#saveOperateType').val(_saveOperateType);
        innerTab(_saveOperateType, 'whir_tab_ul');
    }
}

function changeInfoRights(obj){
    innerTab('inforights', 'whir_tab_ul');

    var options = $('#inforights').attr("whir-options");
    var _json = (new Function('return ' + options))();
    innerCallback(_json);
}

function changePanel(tabId){
    //$('#'+tabId).click();

    innerTab('base', 'whir_tab_ul');
}

function saveTheForm(type, obj){

    var userAccounts = $('#userAccounts').val();
    var empName = $('#empName').val();
    var userSimpleName = $('#userSimpleName').val();
    var orgIds = $('#orgIds').val();

    var action = $('#action').val();

    if(userAccounts == '' || empName == '' || userSimpleName == '' || orgIds == ''){
        changePanel('base');
    }

    if(action == 'add'){
        var userPassword = $('#userPassword').val();
        var confirmPassword = $('#confirmPassword').val();
        if(userPassword == '' || confirmPassword == ''){
            changePanel('base');
        }
    }

    saveForm(type, obj);
}

function saveForm(type, obj){
    var dogMaxUserNum = $('#dogMaxUserNum').val();
    var currentUserNum = $('#currentUserNum').val();
    var action = $('#action').val();

    if(action == 'add' && (parseInt(dogMaxUserNum)-parseInt(currentUserNum))<=0){
        whir_alert("当前用户和禁用用户数为"+currentUserNum+"，授权用户数为"+dogMaxUserNum+"，不能再添加用户！", function(){
            return ;
        });
        return ;
    }

    var tansUse = $('#tansUse').val();
    if(tansUse == '1'){
        if($('#empIdCard').val() == '' || $('#empIdCard').val() == 'NULL'){
            $('#empIdCard').val('');
            changePanel('base');
        }
    }

    var validation = validateForm('dataForm');

    if(validation == false){
        return;
    }

    //检查用户输入是否合法
    if(!checkInput())return;

    var userOrderCode = $('#userOrderCode').val();
    if(userOrderCode != ''){
        var userOrderCodeArr = userOrderCode.split('.');
        if(userOrderCodeArr[0].length > 5){
            changePanel('base');
            whir_poshytip($('#userOrderCode'), "排序整数部分长度不能大于5");
            return;
        }
        if(userOrderCodeArr.length>1 && userOrderCodeArr[1].length > 4){
            changePanel('base');
            whir_poshytip($('#userOrderCode'), "排序小数部分长度不能大于4");
            return;
        }
    }

    //检查用户的权限范围
    if(!checkUserRight()) return;

    //收集用户权限信息
    beforeSubmit();
    
    $('form').find("#saveType").val(type);
	if(validation){
        var empLeaderId = $('#empLeaderId').val();
        /*if($.trim(empLeaderId)=='' || $.trim(empLeaderId)=='null'){
            $.dialog.confirm('如果此用户有上级领导而未被设置，则系统的某些模块可能会运行不正常！\n您确定此用户没有上级领导吗？', function(){$('#dataForm').submit();}, function(){}, null );
        }*/

        /*if($.trim(empLeaderId)=='' || $.trim(empLeaderId)=='null'){
            whir_confirm("如果此用户有上级领导而未被设置，则系统的某些模块可能会运行不正常！\n您确定此用户没有上级领导吗？", function(){
                $('#dataForm').submit();
            });
        }else{
            $('#dataForm').submit();
        }*/

        $('#dataForm').submit();
	}
}


function beforeSubmit() {
    var rightIds = "";
    var rightScopeTypes = "";
    var rightScopeScopes = "";
    var rightScopeDsps = "";

    var defaultRightScopeScopeId = $('#defaultRightScopeScopeId').val();
	var defaultRightScopeScopeDsp = $('#defaultRightScopeScopeDsp').val();

    var _s = new Date().getTime();

    var rightId_ = document.getElementsByName("rightId_");
    for(var i=0,m=rightId_.length; i<m; i++){
        rightIds += rightId_[i].value + ",";

        if(document.getElementById("rightIdScope_"+i) != null){
            var $rightScopeType = document.getElementsByName('rightScopeType_'+i);
            if($rightScopeType.length > 0){
                var _rightScopeType = '';
                for(var k=0, j=$rightScopeType.length; k<j; k++){
                    if($rightScopeType[k].checked==true){
                        _rightScopeType = $rightScopeType[k].value;
                        rightScopeTypes += _rightScopeType + ",";
                        break;
                    }
                }

                var rightScopeType = _rightScopeType;
                if(rightScopeType=='4'){
                    var rightScopeScope_ = document.getElementById("rightScopeScope_"+i).value;
                    if(rightScopeScope_==''){
                        rightScopeScopes += defaultRightScopeScopeId + ",";
                        rightScopeDsps += defaultRightScopeScopeDsp + "|";
                    }else{
                        rightScopeScopes += rightScopeScope_ + ",";
                        rightScopeDsps += document.getElementById("rightScopeScopeDsp_"+i).value + "|";
                    }
                }else{
                    rightScopeScopes += "0,";
                    rightScopeDsps += "0|";
                }
            }else{
                rightScopeTypes += "0,";
                rightScopeScopes += "0,";
                rightScopeDsps += "0|";
            }
        }else{
            rightScopeTypes += "0,";
            rightScopeScopes += "0,";
            rightScopeDsps += "0|";
        }
    }

    var _e = new Date().getTime();
    //alert(_e-_s);

    $('#rightIds').val(rightIds);
    $('#rightScopeTypes').val(rightScopeTypes);
    $('#rightScopeScopes').val(rightScopeScopes);
    $('#rightScopeDsps').val(rightScopeDsps);

    var userRole=$('#userRoleId').val();
    while(userRole.indexOf("$")>=0){
        userRole=userRole.replace("$","");
    };
    $('#userRoleId').val(userRole);

    //alert(rightIds);    alert(rightScopeTypes);    alert(rightScopeScopes);    alert(rightScopeDsps);    alert(userRole);

    //alert($('#userRoleId').val());

    //检查排序
    var orderCode = $('#userOrderCode').val();
    if (orderCode == null || orderCode == "" || orderCode == "null") {
        $('#userOrderCode').val(10000);
    }

    if($('#isAdCheckbox').attr('checked')=='checked'){
        $('#isAdCheck').val('1');
    }else{
        $('#isAdCheck').val('0');
    }
}

function resetTheDataForm(obj){
    resetDataForm(obj);

    changePasswordRule();

    var rd = $('input:radio[name=rd]:checked');
    selRange(rd[0]);

    showDate();

    var mobileUserFlag = $("input:checkbox[name='userPO.mobileUserFlag']");
    checkMobile(mobileUserFlag[0]);
}

//用于回调领导
function getFillLeader(){
    var orgIds = $('#orgIds').val();
    if(orgIds != ''){
        var leaderJson = ajaxForSync(whirRootPath + '/User!getLeaders.action', 'orgIds='+orgIds);
        leaderJson = eval("("+leaderJson+")");
        $('#chargeLeaderIds').val(leaderJson.chargeLeaderIds);
        $('#chargeLeaderNames').val(leaderJson.chargeLeaderNames);
        $('#deptLeaderIds').val(leaderJson.deptLeaderIds);
        $('#deptLeaderNames').val(leaderJson.deptLeaderNames);
        $('#empLeaderId').val(leaderJson.empLeaderId);
        $('#empLeaderName').val(leaderJson.empLeaderName);
    }else{
        $('#chargeLeaderIds').val('');
        $('#chargeLeaderNames').val('');
        $('#deptLeaderIds').val('');
        $('#deptLeaderNames').val('');
        $('#empLeaderId').val('');
        $('#empLeaderName').val('');
    }
    linkage_changeOrg();
}

function getFillLeader2(){
    var orgIds = $('#orgIds').val();
    if(orgIds != ''){
        var leaderJson = ajaxForSync(whirRootPath + '/User!getLeaders.action', 'orgIds='+orgIds);
        leaderJson = eval("("+leaderJson+")");
        $('#empLeaderId').val(leaderJson.empLeaderId);
        $('#empLeaderName').val(leaderJson.empLeaderName);
    }else{
        $('#empLeaderId').val('');
        $('#empLeaderName').val('');
    }
}

function changePasswordRule(){
    if($('#isPasswordRule').attr('checked')=='checked'){
        $('#passwordRule_TR').show();
    }else{
        $('#passwordRule_TR').hide();
    }
}

function checkMobile(obj){
    if(obj.checked){
        $('#mobileSpan').show();
        document.getElementById("mobileSpan").style.display="";
        
        if( document.getElementById("empMobilePhoneTR")){
	        $('#empMobilePhoneTR').show();
	        document.getElementById("empMobilePhoneTR").style.display="";
        }
    }else{
    	
        $('#mobileSpan').hide();
        if(!$('#enterprisenumber').is(':checked')){
        	 $('#empMobilePhoneTR').hide();
        }
       
    }
}
function checkEnterprisenumber(obj){
	if(obj.checked){
      
        $('#empMobilePhoneTR').show();
        document.getElementById("empMobilePhoneTR").style.display="";
    }else{
    	//alert($('#mobileUserFlag').checked)
    	 if(!$('#mobileUserFlag').is(':checked')){
    		 $('#empMobilePhoneTR').hide();
    	 }
    }
}
function showDate(){
    if($('#userIsSuper').attr('checked')=='checked'){
        $('#userIsSuper').attr('value', '1');
        $('#showDate').show();
    }else{
        $('#userIsSuper').attr('value', '0');
        $('#showDate').hide();
    }
}

function selRange(obj){
	if($(obj).val()=='0'){
        $('#browseRangeTR').hide();
	}else{
		$('#browseRangeTR').show();
	}
}

function accountAllow(){
    var userAccounts = $('#userAccounts').val();
    /*if(userAccounts==''){
        whir_alert("用户账号不能为空！", function(){
            $('#userAccounts').focus();
            return false;
        });
        return false;
    }

    if(userAccounts.indexOf("'")!=-1){
        whir_alert("用户账号不能包含字符: ' ", function(){
            $('#userAccounts').focus();
            return false;
        });
        return false;
    }

    if(userAccounts.length<2){
        whir_alert("用户账号长度应在2~20个字符之间！", function(){
            $('#userAccounts').focus();
            return false;
        });
        return false;
    }

    if(userAccounts.indexOf(" ")>=0 || userAccounts.indexOf("　")>=0){
        whir_alert("用户账号中不能包含空格！", function(){
            $('#userAccounts').val('');
            $('#userAccounts').focus();
            return false;
        });
        return false;
    }*/
    var reSpecialChars = /[\!\@\#\$\%|^\&\*\(\)\+\|\\|?\/\>\<\.\,]+/i;//验证是否包含了特殊字符
    if(reSpecialChars.test(userAccounts)){
        /*whir_alert("密码必须包含特殊字符！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        whir_poshytip($('#userAccounts'), "用户账号不能包含特殊字符！");
        $('#userAccounts').focus();
    	return false;
    }
    
    if(userAccounts != ''){
        if(userAccounts.indexOf("'")!=-1){
            /*whir_alert("用户账号不能包含字符: ' ", function(){
                $('#userAccounts').focus();
                return false;
            });*/
            whir_poshytip($('#userAccounts'), "用户账号不能包含字符: ' ");
            $('#userAccounts').focus();
            return false;
        }

        if(userAccounts.length<2){
            /*whir_alert("用户账号长度应在2~20个字符之间！", function(){
                $('#userAccounts').focus();
                return false;
            });*/
            whir_poshytip($('#userAccounts'), "用户账号长度应在2~20个字符之间！");
            $('#userAccounts').focus();
            return false;
        }

        if(userAccounts.indexOf(" ")>=0 || userAccounts.indexOf("　")>=0){
            /*whir_alert("用户账号中不能包含空格！", function(){
                $('#userAccounts').val('');
                $('#userAccounts').focus();
                return false;
            });*/
            whir_poshytip($('#userAccounts'), "用户账号中不能包含空格！");
           // $('#userAccounts').val('');
            $('#userAccounts').focus();
            return false;
        }

        var result = ajaxForSync(whirRootPath + '/User!checkUserAccounts.action', 'userAccount='+encodeURIComponent(userAccounts)+'&empId='+$('#empId').val());
        if(result != ''){
            result = eval('('+result+')');
            if(result.result=='0'){
                $('#userAccountAllow').html('<font color=green>'+result.message+'</font>');
            }else if(result.result=='1'){
                $('#userAccountAllow').html('<font color=red>'+result.message+'</font>');
            }
        }
    }

    return true;
}

/**
 * 检查用户的输入信息是否合法
 */
function checkInput(){
    var userAccounts = $('#userAccounts').val();
    /*if(userAccounts==''){
        whir_alert("用户账号不能为空！", function(){
            $('#userAccounts').focus();
            return false;
        });
        return false;
    }*/

    if(userAccounts.indexOf("'")!=-1){
        /*whir_alert("用户账号不能包含字符: ' ", function(){
            $('#userAccounts').focus();
            return false;
        });*/
        whir_poshytip($('#userAccounts'), "用户账号不能包含字符: ' ");
        $('#userAccounts').focus();
        return false;
    }

    if(userAccounts.length<2){
        /*whir_alert("用户账号长度应在2~20个字符之间！", function(){
            $('#userAccounts').focus();
            return false;
        });*/
        whir_poshytip($('#userAccounts'), "用户账号长度应在2~20个字符之间！");
        $('#userAccounts').focus();
        return false;
    }

    if(userAccounts.indexOf(" ")>=0 || userAccounts.indexOf("　")>=0){
        /*whir_alert("用户账号中不能包含空格！", function(){
            $('#userAccounts').val('');
            $('#userAccounts').focus();
            return false;
        });*/
        whir_poshytip($('#userAccounts'), "用户账号中不能包含空格！");
        //$('#userAccounts').val('');
        $('#userAccounts').focus();
        return false;
    }

    var userPassword = $('#userPassword').val();
    var confirmPassword = $('#confirmPassword').val();
    if(userPassword.indexOf("'")>=0){
        /*whir_alert("密码不能包含字符: ' ", function(){
            $('#userPassword').focus();
            $('#confirmPassword').val('');
            return false;
        });*/
        whir_poshytip($('#userPassword'), "密码不能包含字符: ' ");
        $('#userPassword').focus();
        $('#confirmPassword').val('');
        return false;
    }

    var action = $('#action').val();
    if(action=="add"){
        if($('#isPasswordRule').attr('checked')=='checked'){//启用了密码规则
            if(!checkPasswordByRule()){
                return false;
            }
        }

        if($.trim(userPassword)==''){
            /*whir_alert("密码不能为空！", function(){
                $('#userPassword').val('');
                $('#userPassword').focus();
                return false;
            });*/
            whir_poshytip($('#userPassword'), "密码不能为空！");
            $('#userPassword').val('');
            $('#userPassword').focus();
            return false;
        }

        if(userPassword.length<6){
            /*whir_alert("密码至少为六位字符！", function(){
                $('#userPassword').focus();
                return false;
            });*/
            whir_poshytip($('#userPassword'), "密码至少为六位字符！");
            $('#userPassword').focus();
            return false;
        }

        if(userPassword != confirmPassword){
            /*whir_alert("您两次输入的密码不一致,请检查！", function(){
                $('#userPassword').focus();
                $('#confirmPassword').val('');
                return false;
            });*/
            changePanel('base');
            whir_poshytip($('#userPassword'), "您两次输入的密码不一致,请检查！");
            $('#userPassword').focus();
            $('#confirmPassword').val('');
            return false;
        }
    }else{
        if($('#isPasswordRule').attr('checked')=='checked'){//启用了密码规则
            if(!checkPasswordByRule()){
                return false;
            }

            //判断是否在2年内的密码重复
            var vuserId = $('#empId').val();
            var vpassword = userPassword;
            vpassword = vpassword.replace(/\&/g, '￥'); //由于&为参数地址连接符，用"￥"替换"&",然后在还原
            var returnValue = getPasswordIsRepeat(vuserId, vpassword).replace(/\n|\r/g, ""); //判断该用户密码在2年内是否重复，重复返回"1",不重复返回"0"
            returnValue = eval("("+returnValue+")");
            if (returnValue.result == 1) { //密码在2年内重复
                changePanel('base');
                whir_alert("密码在2年内不能重复！", function(){
                    $('#userPassword').focus();
                    return false;
                });
                return false;
            }
        }else{
        }

        if(userPassword != ''){
            if($.trim(userPassword)==''){
                /*whir_alert("密码不能为空！", function(){
                    $('#userPassword').val('');
                    $('#userPassword').focus();
                    return false;
                });*/
                whir_poshytip($('#userPassword'), "密码不能为空！");
                $('#userPassword').val('');
                $('#userPassword').focus();
                return false;
            }

            if(userPassword.length<6){
                /*whir_alert("密码至少为六位字符！", function(){
                    $('#userPassword').focus();
                    return false;
                });*/
                whir_poshytip($('#userPassword'), "密码至少为六位字符！");
                $('#userPassword').focus();
                return false;
            }
        }

        if(userPassword != confirmPassword){
            /*whir_alert("您两次输入的密码不一致,请检查！", function(){
                $('#userPassword').focus();
                $('#confirmPassword').val('');
                return false;
            });*/
            changePanel('base');
            whir_poshytip($('#userPassword'), "您两次输入的密码不一致,请检查！");
            $('#userPassword').focus();
            $('#confirmPassword').val('');
            return false;
        }
       
    }

    var empName = $('#empName').val();
    if($.trim(empName)==''){
        /*whir_alert("中文名不能为空！", function(){
            $('#empName').val('');
            $('#empName').focus();
            return false;
        });*/
        whir_poshytip($('#empName'), "中文名不能为空！");
        $('#empName').val('');
        $('#empName').focus();
        return false;
    }

    if(empName.indexOf("'")>=0){
        /*whir_alert("中文名不能包含字符: ' ", function(){
            $('#empName').focus();
            return false;
        });*/
        whir_poshytip($('#empName'), "中文名不能包含字符: ' ");
        $('#empName').focus();
        return false;
    }

    var empEnglishName = $('#empEnglishName').val();
    if(empEnglishName.indexOf("'")>=0){
        /*whir_alert("英文名不能包含字符: ' ", function(){
            $('#empEnglishName').focus();
            return false;
        });*/
        whir_poshytip($('#empEnglishName'), "英文名不能包含字符: ' ");
        $('#empEnglishName').focus();
        return false;
    }

    var userSimpleName = $('#userSimpleName').val();
    if($.trim(userSimpleName)==''){
        /*whir_alert("用户简码不能为空！", function(){
            $('#userSimpleName').val('');
            $('#userSimpleName').focus();
            return false;
        });*/
        whir_poshytip($('#userSimpleName'), "用户简码不能为空！");
        $('#userSimpleName').val('');
        $('#userSimpleName').focus();
        return false;
    }

    var tansUse = $('#tansUse').val();
    if(tansUse == '1'){
        var empIdCard = $('#empIdCard').val();
        if($.trim(empIdCard)==''){
            /*whir_alert("身份证号不能为空！", function(){
                $('#empIdCard').val('');
                $('#empIdCard').focus();
                return false;
            });*/
            whir_poshytip($('#empIdCard'), "身份证号不能为空！");
            $('#empIdCard').val('');
            $('#empIdCard').focus();
            return false;
        }
    }

    var orgIds = $('#orgIds').val();
    if($.trim(orgIds)==''){
        whir_alert("所属组织不能为空！", function(){
            $('#orgIds').focus();
            return false;
        });
        whir_poshytip($('#orgIds'), "所属组织不能为空！");
        $('#orgIds').focus();
        return false;
    }

    if($('#userIsSuper').attr('checked')=='checked'){
        var beginDate=new Date($('#userSuperBegin').val());
        var endDate=new Date($('#userSuperEnd').val());
        if(beginDate>endDate){
            whir_alert("特权开始日期不能在结束日期之后！", function(){
                return false;
            });
            return false;
        }
    }

    var netDiskSize = $('#netDiskSize').val();
    if(parseInt(netDiskSize)>2048){
        /*whir_alert("我的文档大小不得大于2048M！", function(){
            $('#netDiskSize').focus();
            return false;
        });*/
        whir_poshytip($('#netDiskSize'), "我的文档大小不得大于2048M！");
        $('#netDiskSize').focus();
        return false;
    }
    /*var dis = document.getElementById("empMobilePhoneTR").style.display;
    if(dis!="none"){
	    var empMobilePhone = $.trim($('#empMobilePhone').val());
	    if(empMobilePhone.length<11){
	       
	        whir_poshytip($('#empMobilePhone'), "手机号码输入不正确");
	        $('#empMobilePhone').focus();
	        return false;
	    }
    }*/

    var sidelineOrg = $('#sidelineOrg').val();
    if($.trim(sidelineOrg)!=''&&sidelineOrg.indexOf(orgIds)>0){
        whir_poshytip($('#sidelineOrgName'), "兼职组织不能和所属组织重复！");
        $('#sidelineOrgName').focus();
        return false;
    }
   
    var mobileUserFlag  = $('#mobileUserFlag');
    if(mobileUserFlag.is(':checked')){ 
    	var appflag = judgmentAppNum(userAccounts);
    	if(appflag=="0"){
    		return false;
    	}
    }
    
    var enterprisenumber  = $('#enterprisenumber');
    if(enterprisenumber.is(':checked')){
    	 var weixinflag = judgmentWeixinNum(userAccounts);
    	 if(weixinflag=="0"){
     		return false;
     	}
    }
	if(tansUse == '1'){
		var empIdCardCheck = empIdCardAllow();
			 if(!empIdCardCheck){
				return false;
			}
    }
    return true;
}

function checkPasswordByRule(){
    var vpassword = $('#userPassword').val();
    var reChars = /[a-zA-Z]+/i;
    var reNums = /[0-9]+/i;
    var reSpecialChars = /[\!\@\#\$\%|^\&\*\(\)\+\|\\|?\/\>\<\.\,]+/i;//验证是否包含了特殊字符
    if(vpassword.length<7){
        /*whir_alert("密码长度必须大于等于7位！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        whir_poshytip($('#userPassword'), "密码长度必须大于等于7位！");
        $('#userPassword').focus();
    	return false;
    }else if(!reChars.test(vpassword)){
        /*whir_alert("密码必须包含字母！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        whir_poshytip($('#userPassword'), "密码必须包含字母！");
        $('#userPassword').focus();
    	return false;
    }else if(!reNums.test(vpassword)){
        /*whir_alert("密码必须包含数字！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        whir_poshytip($('#userPassword'), "密码必须包含数字！");
        $('#userPassword').focus();
    	return false;
    }else if(!reSpecialChars.test(vpassword)){
        /*whir_alert("密码必须包含特殊字符！", function(){
            $('#userPassword').focus();
            return false;
        });*/
        whir_poshytip($('#userPassword'), "密码必须包含特殊字符！");
        $('#userPassword').focus();
    	return false;
    }
    return true;
}

//根据用户id和密码，判断该密码是否在2年内重复
function getPasswordIsRepeat(vuserId, vpassword){
    return ajaxForSync(whirRootPath + '/User!checkPasswordIsRepeat.action', 'userId='+vuserId+'&password='+vpassword);
}

/**
 * 检查用户的权限范围
 */
function checkUserRight(){
    var ret = true;
    var selectValue = whirExtCombobox.getValue('changeRights');
    var defaultRightScopeScopeId = $('#defaultRightScopeScopeId').val();
    /*fast check*/
    if((selectValue == '4' && defaultRightScopeScopeId=='') || selectValue != '4'){
        $('span.showRightScope_span').each(function(i){
            var $this = $(this);
            var display = $this.css('display');
            if(display == 'inline'){
                var dsp = $this.attr('dsp');
                var dspVal = document.getElementById(dsp).value;
                if(dspVal == ''){
                    whir_alert('权限范围不能为空！', null);
                    ret = false;
                    return ret;
                }
            }
        });
    }

    return ret;
}

function setupButtonStatus(disabled){
    $('.saveBtn').each(function(){
        $(this).attr('disabled', disabled);
        if(disabled){
            $(this).addClass('sysSaveBtn');
        }else{
            $(this).removeClass('sysSaveBtn');
        }
    });
}

function initRightsFormToAjax(dataForm){
    $('#'+dataForm).ajaxForm({
		beforeSend:function(){
            setupButtonStatus(true);
			//$.dialog.tips("正在加载权限...",1000,'loading.gif',function(){});
		},
		success:function(responseText){
            var $result = $('<div class="rights"/>').append($($.trim(responseText)));
            $('#tab_0').html($result.find('.sysRights'));
            $('#tab_1').html($result.find('.customRights'));
            $('#tab_2').html($result.find('.customizeRights'));
            $result = null;
            //$.dialog({id:"Tips"}).close();
            setupButtonStatus(false);
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
            //$.dialog({id:"Tips"}).close();
            setupButtonStatus(false);
            //$.dialog.alert('加载异常',function(){});
		}
	});
}

function setUserRole(obj){
    if(obj){
        var userRole = $('#userRoleId').val();
        var objVal = $(obj).val();
        if($(obj).attr('checked')=='checked'){
            if(userRole.indexOf("$"+ objVal + "$,")==-1){
                userRole = userRole + "$"+ objVal + "$,";
            }
        }else{
            userRole = userRole.substring(0, userRole.indexOf("$"+ objVal + "$")) + userRole.substring(userRole.indexOf("$"+ objVal + "$") + (objVal.length+3), userRole.length);
        }
        //alert(userRole);
        $('#userRoleId').val(userRole);
    }
}

function showRights(index){
    var imgSrc = $('#img_'+index).attr('src');
    if(imgSrc.indexOf('menuminus_b')!=-1){
        $('#img_'+index).attr('src', whirRootPath + '/images/menuplus_b.gif');
    }else{
        $('#img_'+index).attr('src', whirRootPath + '/images/menuminus_b.gif');
    }

    $('#rightsList .showRight_'+index).each(function(){
        if($(this).css('display')=='none'){
            $(this).show();
        }else{
            $(this).hide();
        }
    });
}

function showRightScope(obj, index){
    if(obj.value==4){
        $('#showRightScope_'+index).show();
    }else{
        if($('#showRightScope_'+index)){
            $('#showRightScope_'+index).hide();
        }
    }
}

function _changeScope(i, selectValue){
    $('#rightsList input:radio[name=rightScopeType_'+i+'][value='+selectValue+']').attr('checked', true);
}

function ChangeSelect(obj){
    var selectValue = whirExtCombobox.getValue('changeRights');
    if(selectValue=='4'){
        $('#defaulDefineRangeTD').show();
	}else{
        $('#defaulDefineRangeTD').hide();
        $('#defaultRightScopeScopeId').val('');
        $('#defaultRightScopeScopeDsp').val('');
	}

    $('#changeSelectScope').remove();//使用完必须移除
    _setSelectedRight();
    $('<input type="hidden" id="changeSelectScope" name="changeSelectScope" value="'+selectValue+'"/>').appendTo($('#rightsForm'));
    $('#rightsForm').submit();
    $('#changeSelectScope').remove();//使用完必须移除
}

/**
 * 当更改角色时记录当前已经选择的权限ID、范围等
 */
function _setSelectedRight(){
    var hadSelected="";

    $('#hadSelectedRight').html('');

    var _s = new Date().getTime();

    var rightId_ = document.getElementsByName("rightId_");
    for(var i=0,m=rightId_.length; i<m; i++){
        hadSelected+="<input type='hidden' name='rightIdSend' value='"+rightId_[i].value+"'>";

        var rightTypeSend = '0';//'2';
        var rightScopeSend = '0';
        var rightScopeDspSend = '';

        if(document.getElementById("rightIdScope_"+i) != null){//如果此权限有权限范围
            var $rightScopeType = document.getElementsByName('rightScopeType_'+i);
            if($rightScopeType.length > 0){                
                for(var k=0, j=$rightScopeType.length; k<j; k++){
                    if($rightScopeType[k].checked==true){
                        rightTypeSend = $rightScopeType[k].value;
                        break;
                    }
                }
                
                if(rightTypeSend=='4'){
                    rightScopeSend = document.getElementById('rightScopeScope_'+i).value;
                    rightScopeDspSend = document.getElementById('rightScopeScopeDsp_'+i).value;
                }
            }
        }

        hadSelected+="<input type='hidden' name='rightTypeSend' value='"+rightTypeSend+"'>";
        hadSelected+="<input type='hidden' name='rightScopeSend' value='"+rightScopeSend+"'>";
        hadSelected+="<input type='hidden' name='rightScopeDspSend' value='"+rightScopeDspSend+"'>";
    }

    var _e = new Date().getTime();
    //alert(_e-_s);

    $('#hadSelectedRight').html(hadSelected);
}

/**
 * 重新选择角色或修改时得到选择的角色包含的权限
 */
function getRights(obj, flag){
    if(flag){
        setUserRole(obj);
    }

    var __roleIds = $('#roleIds').val();

    //alert(__roleIds);

    var roleIds="";
    _setSelectedRight();

    //search-panel
    $('#search-panel input:checkbox[name=roleId]').each(function(){
        var _this = $(this);
        var _val = _this.val();
        if(_this.attr('checked')=='checked'){
            if(("," + __roleIds).indexOf(","+_val+",")==-1){
                roleIds += _val+",";
            }
        }else{
            __roleIds = ("," + __roleIds).replace(","+_val+",",",");
            if(__roleIds.length >0 && __roleIds.substr(0,1)==","){
                __roleIds = __roleIds.substr(1);
            }
        }
    });

    //alert(__roleIds + roleIds);

    $('#roleIds').val(__roleIds + roleIds);
    $('#rightsForm').submit();
}

function selectRoleClass(obj){
    var roleClassId = $(obj).val();
	var vsysManagerFlag = $('#sysManagerFlag').val();

    var checkFlag = false;
    if($(obj).attr('checked')=='checked'){
        checkFlag = true;
    }

    $('#search-panel input:checkbox[name=roleId]').each(function(i){
        var $this = $(this);
        var $classId = $this.attr('classId');
        if(roleClassId == $classId){
            /*if(vsysManagerFlag=="0"){//普通管理员
                var roleNameTemp = document.getElementsByName("roleNameAry")[i].value;
                if(roleNameTemp != "普通管理员-自定义平台" && roleNameTemp != "普通管理员-用户管理"){
                    $this.attr('checked', checkFlag);
                }
            }else{//系统管理员*/
                $this.attr('checked', checkFlag);
            //}
            setUserRole($this);
        }
    });

    getRights(null, false);
}

function getAllRole(obj){
    var vsysManagerFlag = $('#sysManagerFlag').val();

    var checkFlag = false;
    if($(obj).attr('checked')=='checked'){
        checkFlag = true;
    }

    $('#search-panel input:checkbox[name=roleClassId]').each(function(i){
        $(this).attr('checked', checkFlag);
    });

    $('#search-panel input:checkbox[name=roleId]').each(function(i){
        var $this = $(this);
        /*if(vsysManagerFlag=="0"){//普通管理员
            var roleNameTemp = document.getElementsByName("roleNameAry")[i].value;
            if(roleNameTemp != "普通管理员-自定义平台" && roleNameTemp != "普通管理员-用户管理"){
                $this.attr('checked', checkFlag);
            }
        }else{//系统管理员*/
            $this.attr('checked', checkFlag);
        //}
        setUserRole($this);
    });

    getRights(null, false);
}

function loadRights(){
    if($('#action').val()=='modify'){
        getRights(null, false);
    }
}

function selectWorkAddress(){
	var workAddress = $("#workAddress").val();
	var workAddressName = $("#workAddressName").val();
	popup({content: "url:"+whirRootPath+"/workaddress!workAddress_list_select.action",width:800,height:500,title:"选择办公地点"});
}

//联动：改变组织
function linkage_changeOrg(){

	var oldOrgId = $("#_orgId").val();
	var newOrgId = $("#orgIds").val();
	if(oldOrgId != newOrgId){
		var vUrl = whirRootPath + '/employee!getLinkageData_changeOrg.action';
		vUrl += '?oldOrgId=' + oldOrgId;
		vUrl += '&newOrgId=' + newOrgId;
		ajaxForAsync(vUrl, '', callback_changeOrg)
	}
}
function callback_changeOrg(msg){

	var msg_json = eval("(" + msg + ")");
	// 工作地点
	// 工作地点
	var waIds = ",";
	//',' + $('#workAddress').val();
	var waNames = ",";
	//',' + $('#workAddressName').val();
	
	var oData = msg_json.oldData;
	if(oData){
		var waArr = oData.workAddress;
		if(waArr != undefined) {
			for(var i=0; i<waArr.length; i++){
				waIds = replaceAll(waIds, ','+waArr[i].id+',', ',');
				waNames = replaceAll(waNames, ','+waArr[i].name+',', ',');
			}
		}
	}
	var nData = msg_json.newData;
	if(nData){
		var waArr = nData.workAddress;
		if(waArr != undefined) {
			for(var i=0; i<waArr.length; i++){
				if(waIds.indexOf(',' + waArr[i].id + ',')<0){
					waIds += waArr[i].id + ',';
					waNames += waArr[i].name + ',';
				}
			}
		}
	}
	waIds = waIds.substring(1, waIds.length);
	waNames = waNames.substring(1, waNames.length);
	$('#workAddress').val(waIds);
	$('#workAddressName').val(waNames);
	
	// 
	$("#_orgId").val($("#orgIds").val());
}

function judgmentAppNum(userAccount){
	var flag = "0";
	$.ajax({
		url: "/defaultroot/User!judgmentAPPNum.action?userAccount="+userAccount,
		cache: false,
		async: false,
		success: function(dataForm) {
			var data = eval('('+dataForm+')');
			if(data.result=="true"){
				flag = "1";
			}else{
				//whir_alert("移动APP用户数量已超出最大值！");
				whir_alert("APP用户数量超过最大限制，保存失败！");
			}
		}
	});
	return flag;
}

function judgmentWeixinNum(userAccount){
	var flag = "0";
	$.ajax({
		url: "/defaultroot/User!judgmentWeixinNum.action?userAccount="+userAccount,
		cache: false,
		async: false,
		success: function(dataForm) {
		
			var data = eval('('+dataForm+')');
			if(data.result=="true"){
				flag = "1";
			}else{
				//whir_alert("企业号用户数量已超出最大值！");
				whir_alert("企业号用户数超出最大限制，保存失败！");
			}
		}
	});
	return flag;
}

function batchjudgmentAppNum(userIdStr){
	var flag = "0";
	$.ajax({
		url: "/defaultroot/User!batchjudgmentAPPNum.action?userIdStr="+userIdStr,
		cache: false,
		async: false,
		success: function(dataForm) {
			var data = eval('('+dataForm+')');
			if(data.result=="true"){
				flag = "1";
			}else{
				//whir_alert("移动APP用户数量已超出最大值！");
				whir_alert("APP用户数量超过最大限制，保存失败！");
			}
		}
	});
	return flag;
}

function batchjudgmentWeixinNum(userIdStr){
	var flag = "0";
	$.ajax({
		url: "/defaultroot/User!batchjudgmentWeixinNum.action?userIdStr="+userIdStr,
		cache: false,
		async: false,
		success: function(dataForm) {
		
			var data = eval('('+dataForm+')');
			if(data.result=="true"){
				flag = "1";
			}else{
				//whir_alert("企业号用户数量已超出最大值！");
				whir_alert("企业号用户数超出最大限制，保存失败！");
			}
		}
	});
	return flag;
}


//身份证号码校验是否重复
function empIdCardAllow(){
	var empIdCard =  $('#empIdCard').val();
	 var result = ajaxForSync(whirRootPath + '/User!empIdCardCheck.action?empIdCard='+encodeURIComponent(empIdCard)+'&empId='+$('#empId').val());
        if(result != ''){
            result = eval('('+result+')');
            if(result.result=='0'){
				return true;
            }else if(result.result=='1'){
				whir_alert("身份证号码重复，保存失败！");
				return false;
            }
        }
}