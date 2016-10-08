//----------------------------------------
//会议自定义表单校验js
//----------------------------------------
//javascript中判断是否国产化客户端环境
var isCOSClient=checkCOS();//true-是 false-否
//会议室时间增加一行
function addBoardtime(){
     commonAddTr({tableId:'board_time_tbl',trIndex:1,operate:'clone',position:'end',isKeep:true,obj:null,callbackfunction:mycall});
}
function mycall(newTr){
   $(newTr).show();
   
}
//会议室时间删除一行
function minRow(obj) {
    var len=document.getElementById('board_time_tbl').rows.length;
    var index = $(obj).parent("td").parent("tr").index();
    $(obj).parent("td").parent("tr").remove();
}

//根据容纳人数、时间、设备搜索符合要求的会议室
function searchBoardroom(){
	var p_wf_pool_processId = $("#p_wf_pool_processId").val();
	//容纳人数
	var personNum = '';
	if(document.getElementById('personnum')){
		personNum =$("#personnum").val();
	}

	//会议时间
	var destineDate = '';
	var startHour ='';
	var startMinutes ='';
	var endHour = '';
	var endMinutes = '';
	var destineDateObj = $('input[name=destineDate]');
	if(destineDateObj.length>0){
		destineDate = $('input[name=destineDate]')[0].value;
		startHour =$('select[name=startHour]')[0].value;
		startMinutes =$('select[name=startMinutes]')[0].value; 
		endHour = $('select[name=endHour]')[0].value;
		endMinutes = $('select[name=endMinutes]')[0].value;
	}

	var boardtime = '';
	var startTime = '';
	var endTime ='';
	if(destineDate != null && destineDate !='' && destineDate!='null'){
		boardtime = destineDate.replace(/\//gm,'-');
	}
	if(startHour != null && startHour !='' && startHour!='null'){
		startTime = startHour * 3600 + startMinutes * 60;
	}
	if(endHour != null && endHour !='' && endHour!='null'){
		endTime = endHour * 3600 + endMinutes * 60;
	}
	//设备
	var equipment = getCheckBoxData("bdEquName", "value");
	  $.ajax({
			url:whirRootPath +'/modules/subsidiary/boardroom/boardRoom_httprequest.jsp?personNum=' + personNum +"&boardtime="+boardtime+"&startTime="+startTime+"&endTime="+endTime+"&equipment=" +equipment+"&p_wf_pool_processId="+p_wf_pool_processId+"&" + Math.round(Math.random()*1000),
			type: 'GET',
			data: null,
			timeout: 1000,
			async: false,      //true异，false,ajax同步
			error: function(){
				whir_alert('Error loading XML document',null,null);
			},
			success: function(data){
				data = data.replace(/(^\s*)|(\s*$)/g,"");
				document.getElementById("_boardrooms").innerHTML=data;
			}
	});
	changeBoardRoom("");
}
//视频会议要显示点数，其他会议室要隐藏点数
	$(document).ready(function(){
		var mailForm="";
		if(document.getElementById('mailForm')){
			mailForm=document.getElementById("mailForm").value;
		}
		var isVideo="";
		if(document.getElementById('isVideo')){
			isVideo=document.getElementById("isVideo").value;
		}
		if( isVideo != null && isVideo !='' && isVideo !='null'){
			if(isVideo == '1'){
				if(document.getElementById('oa_boardroomapply-addr')){
					document.getElementById("oa_boardroomapply-addr").innerHTML="";
				}
			}else{
				if(document.getElementById('oa_boardroomapply-points')){
					document.getElementById("oa_boardroomapply-points").innerHTML="";
				}
			}
		}
		var userId=document.getElementById("sys_userId").value;
		var p_wf_openType="";
		if(document.getElementById('p_wf_openType')){
			p_wf_openType=document.getElementById("p_wf_openType").value;
		}
		var p_wf_moduleId=$("#p_wf_moduleId").val();
		if(p_wf_moduleId == '15'){
			if(p_wf_openType =='modifyView' || p_wf_openType =='waitingDeal' || p_wf_openType =='myTask'){
				if(!isCOSClient){
					whirToolbar.addjsonButtonStr("{id:'Printpriview',name:'会议通知预览',tips:'会议通知预览',img:'/defaultroot/images/toolbar/yl.png',width:'10'}");
					whirToolbar.showToolbar();
				}
			}
		}
		if(p_wf_openType =='modifyView' || mailForm =='mailView'){
			var swperson=getObjectByName('swperson',0,'_Id').value;
			if(swperson.indexOf("$"+userId+"$") > -1){
				addButton();
				showDetail();
			}else{
				showDetail();
			}
		}
	});
	function addButton(){
		//whirToolbar.addjsonButtonStr("{id:'ZpToSend',name:'转批',tips:'转批',img:'/defaultroot/images/toolbar/trandeal.gif',width:'10'}");

		whirToolbar.addjsonButtonStr("{id:'ZfToSend',name:'转发',tips:'转发',img:'/defaultroot/images/toolbar/transend.gif',width:'10'}");
		whirToolbar.showToolbar();
	}
//使用记录、会议通知列表打开没有单位收文员的下面要显示
//回复信息 | 回复信息统计 | 查看情况 | 会议执行情况 
function showDetail(){
	var noteperson=getObjectByName('notepersonname',0,'_Id').value;
	var userId=document.getElementById("sys_userId").value;
	var p_wf_recordId=document.getElementById("p_wf_recordId").value;
	var meetingId='';
	if(document.getElementById('meetingId')){
		meetingId=document.getElementById("meetingId").value;
	}
	var executeStatus='';
	if(document.getElementById('executeStatus')){
		executeStatus=document.getElementById("executeStatus").value;
	}
	var isView='';
	if(document.getElementById('isView')){
		isView=document.getElementById("isView").value;
	}
	var nr ="<br /><table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" id=\"report_table\" style=\"display:\"><tr><td align=\"center\" width=\"100%\">"
	+"<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"inlineBottomLine\"><tr><td height=\"10\"></td></tr><tr><td width=\"100%\" nowrap=\"nowrap\" align=\"left\"><span id=\"_Panle1\" onClick=\"changePanle1(1,"+p_wf_recordId+");\" style=\"color:red;cursor:hand\">回复信息</span>| <span id=\"_Panle5\" onClick=\"changePanle1(5,"+p_wf_recordId+");\" style=\"color:black;cursor:hand\">回复信息统计</span> | <span id=\"_Panle3\" onClick=\"changePanle1(3,"+p_wf_recordId+");\" style=\"color:black;cursor:hand\">查看情况</span>";
	if(executeStatus == 'true' || noteperson.indexOf("$"+userId+"$") > -1 
		&& (meetingId != null && meetingId != '')){
		nr+="| <span id=\"_Panle4\" onClick=\"changePanle1(4,"+p_wf_recordId+");\" style=\"color:black;cursor:hand\">会议执行情况</span>";
	}
    nr+="</td></tr></table>";   
	nr+="<table width=\"100%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" class=\"docBoxNoPanel\"><tr><td height=\"100\" valign=\"top\">";
	nr+="<div id=\"div_1\" style=\"display:block\"><iframe  id=\"reports\" name=\"reports\" src=\""+whirRootPath+"/boardRoom!applyReportList.action?boardroomApplyId="+p_wf_recordId+"&isView="+isView+"\" scrolling=\"no\" frameborder=\"0\"  style=\"width:100%\"></iframe></div>";
    nr+="<div id=\"div_5\" style=\"display:none\"><iframe  id=\"tj\" name=\"tj\" src=\""+whirRootPath+"/modules/subsidiary/boardroom/boardRoomApply_tj.jsp?boardroomApplyId="+p_wf_recordId+"\" scrolling=\"no\" frameborder=\"0\"  style=\"width:100%\"></iframe></div>";
    nr+="<div id=\"div_2\" style=\"display:none\"></div><div id=\"div_3\" style=\"display:none\"></div>";
	if(noteperson.indexOf("$"+userId+"$") > -1){
		nr+="<div id=\"div_4\" style=\"display:none\"></div>";
	}
	nr+="</td></tr></table></td></tr></table>";
	//alert("111:"+nr);
	$("#formHTML").after(nr);
}
function changePanle1(id,boardroomApplyId){
	for(i=0;i<=5;i++){
 	 	if(document.getElementById("_Panle"+i)){
	 		document.getElementById("_Panle"+i).style.color = "black";
	 	}
 	 	if(document.getElementById("div_"+i)){
	 		document.getElementById("div_"+i).style.display = "none";
	 	}
  	}
	if(document.getElementById("_Panle"+id)){
		document.getElementById("_Panle"+id).style.color = "red";
	}
	if(document.getElementById("div_"+id)){
		document.getElementById("div_"+id).style.display = "";
	}

	if(id==1){
		//document.all.reports.src="BoardRoomAction.do?action=applyReportList&boardroomApplyId=<%=boardroomApplyId%>&isView=<%=request.getParameter("isView")%>";
	}
	if(id==5){
		document.getElementById("tj").src=whirRootPath +"/modules/subsidiary/boardroom/boardRoomApply_tj.jsp?boardroomApplyId="+boardroomApplyId;
	}
    if(id==4){
		var meetingId=document.getElementById("meetingId").value;
		var url=whirRootPath +'/boardRoom!executeStatus.action?boardroomApplyId='+boardroomApplyId+'&meetingId='+meetingId;
        openWin({url:url,width:650,height:500,winName:'executeStatus'});
        
	}
     if(id==3){
        openWin({url:'realtimemessage!onlinelist.action?id='+boardroomApplyId+'&fromtype=boardroom',isFull:'true',winName: 'viewUsers' });
	}
}
//更换会议室
function changeBoardRoom(){
	var boardroomId = '';
	if(document.getElementById('boardroomId')){
		boardroomId =$("#boardroomId").val();
	}
	 $.ajax({
			url:whirRootPath +'/modules/subsidiary/boardroom/boardRoom_changeBoardRoom_httprequest.jsp?boardroomId=' + boardroomId +"&" + Math.round(Math.random()*1000),
			type: 'GET',
			data: null,
			timeout: 1000,
			async: false,      //true异，false,ajax同步
			error: function(){
				whir_alert('Error loading XML document',null,null);
			},
			success: function(data){
				data = data.replace(/(^\s*)|(\s*$)/g,"");
				var arr=data.split("##");
				var isVideo=arr[0].split("@@")[1];
				if(document.getElementById('isVideo')){
					document.getElementById("isVideo").value=isVideo;
				}

				if(isVideo != null && isVideo !='' && isVideo !='null' ){
					if(isVideo == '1'){
						var points=arr[1].split("@@")[1];
						if(document.getElementById('oa_boardroomapply-points')){
							document.getElementById("oa_boardroomapply-points").innerHTML=points;
							if(document.getElementById("oa_boardroomapply-addr")){
								document.getElementById("oa_boardroomapply-addr").innerHTML="";
							}
						}
					}else{
						var addr=arr[1].split("@@")[1];
						if(document.getElementById('oa_boardroomapply-addr')){
							document.getElementById("oa_boardroomapply-addr").innerHTML=addr;
							if(document.getElementById("oa_boardroomapply-points")){
								document.getElementById("oa_boardroomapply-points").innerHTML="";
							}
						}
					}
				}
				var bdEqu=arr[2].split("@@")[1];
				if(document.getElementById('oa_boardroomapply-boardequipment')){
					document.getElementById("oa_boardroomapply-boardequipment").innerHTML=bdEqu;
				}
			}
	});
}
//验证表单元素
function checkFormElement(){
    var result=true;
	var isVideo="";
	var p_wf_recordId='';
	if(document.getElementById('p_wf_recordId')){
		p_wf_recordId=document.getElementById('p_wf_recordId').value;
	}
	var boardroomApplyId='';
	if(document.getElementById('boardroomApplyId')){
		boardroomApplyId=document.getElementById('boardroomApplyId').value;
	}
	if(p_wf_recordId == '' && boardroomApplyId !=''){
		p_wf_recordId=boardroomApplyId;
	}
	//检查表单上面的必须存在的元素begin
	
	if(!document.getElementById('boardroomApplyType')){
		whir_alert("会议类型为表单上必须要的元素，请添加！",null,null);
		result=false;
	}
	
	if(!document.getElementById('motif')){
		whir_alert("会议主题为表单上必须要的元素，请添加！",null,null);
		result=false;
	}
	
	//function getObjectByName(name/*对象名称*/, index/*下标，默认为0*/, suffix/*后缀：1)选择组织用户：_Id,_Name; 2)附件：_fileName,_saveName; 3)其它无后缀，为空*/) {
	//相对于 document.getElementsByName(name)[index];

	var emceeNameObj=getObjectByName('emceename',0,'_Id');
	
	if(emceeNameObj == null){
		whir_alert("主持人为表单上必须要的元素，请添加！",null,null);
		result=false;
	}
	
	if($('input[name=destineDate]:not(:disabled)').length<0){
		whir_alert("时间为表单上必须要的元素，请添加！",null,null);
		return false;
	}
	if(!document.getElementById('boardroomId')){
		whir_alert("会议室名称为表单上必须要的元素，请添加！",null,null);
		result=false;
	}
	/*if(document.getElementById('boardroomId')){
		if(document.getElementById('isVideo')){
			isVideo=document.getElementById("isVideo").value;
		}
		if(isVideo == '1'){	
			if(!document.getElementById('points')){
				whir_alert("视频会议室点数为表单上必须要的元素，请添加！",null,null);
				result=false;
			}
		}else if(!document.getElementById('addr')){
			whir_alert("非视频会议室地点为表单上必须要的元素，请添加！",null,null);
			result=false;
		}
	}*/
	if(document.getElementById('boardroomId')){
		var boardroomId=$('#boardroomId').val();
		if(boardroomId == ''){
			 whir_poshytip($('#boardroomId'),"会议室名称不能为空！");
             result=false;
		}
	}
	if(document.getElementById('boardroomcode')){
		var code=$('#boardroomcode').val();
		var rs=spechar3(code);
		if(rs != ''){
			 whir_poshytip($('#boardroomcode'),"会议编号不能有"+rs+"特殊字符");
             result=false;
		}
	}
	//检查表单上面的必须存在的元素end
	if(document.getElementById('boardEquipment')){
		var strCheckBox =getCheckBoxData("bdEqu", "value");
		$("#boardEquipment").val(strCheckBox);
	}
	var motif ="";
	if(document.getElementById('motif')){
		motif =$('#motif').val();
	}
	if (motif !=""){
		if(motif.substring(0,1) ==" "){
             whir_poshytip($('#motif'),"会议主题不得为空格开头，请去空格。");
			 $('#motif')
             result=false;
		}
		var rs=spechar3(motif);
		if(rs != ''){
			 whir_poshytip($('#motif'),"会议主题不能有"+rs+"特殊字符");
             result=false;
		}
	}
	if (document.getElementById('applyOrgName')){
		var applyOrgName=$('#applyOrgName').val();
		if(applyOrgName ==""){
			whir_poshytip($('#applyOrgName'),"预定部门不得为空，必须选取。");
            result=false;
        }
	}
	if (document.getElementById('personnum')){
		var personnum=$('#personnum').val();
		if(personnum != ''){
			var reg = new RegExp(/^\d+$/);
			if(!reg.test(personnum)){
				whir_poshytip($('#personnum'),"出席人数只能输入正整数！");
				result=false;
			}
		}
	}
	if(document.getElementById("linktelephone")){
		var rs=isPhone($("#linktelephone").val());
		if(!rs){
			whir_poshytip($('#linktelephone'),"电话号码格式不对！");
			result=false;
		}
	}
	if(document.getElementById('isVideo')){
		isVideo=document.getElementById("isVideo").value;
	}
	var destineDateBeginTime = 0;
	var destineDateEndTime = 0;
    var _destineDate = $('input[name=destineDate]:not(:disabled)');
	
	_flag = false;
	for(var i=0; i<_destineDate.length; i++){
        if(i!=1){
            //会议时间数组
            var destineDate = $('input[name=destineDate]:not(:disabled)')[i].value;
            $("#destineDateBeginTime").val($('select[name=startHour]')[i].value *3600 +$('select[name=startMinutes]')[i].value*60);
            $("#destineDateEndTime").val($('select[name=endHour]')[i].value *3600 +$('select[name=endMinutes]')[i].value*60);
            destineDateBeginTime = $("#destineDateBeginTime").val();
            destineDateEndTime = $("#destineDateEndTime").val();

            if(eval(destineDateBeginTime)>=eval(destineDateEndTime)){
                whir_poshytip($('select[name=startHour]')[i],"预定结束时间不得小于或等于预定开始时间，请调整。");
                result=false;
            }
            var boardroomId = $("#boardroomId").val();
           if (_flag==false && !checkMeetingDateAndTime(i)){result=false;}
		 
            //临时会议室不判断时间
            if(isVideo != '2'){
                $.ajax({
                    url: whirRootPath +'/modules/subsidiary/boardroom/selectImpropriateTime.jsp?destineDate=' + destineDate + "&destineDateBeginTime="+destineDateBeginTime+"&destineDateEndTime="
                    +destineDateEndTime+"&boardroomId="+boardroomId+"&boardroomApplyId="+p_wf_recordId+"&isVideo="+isVideo + "&" + Math.round(Math.random()*1000),
                    type: 'GET',
                    data: null,
                    timeout: 1000,
                    async: false,      //true异，false,ajax同步
                    error: function(){
                    //alert('Error loading XML document');
                    },
                    success: function(data){
                    	//alert("data:"+data);
                        data = data.replace(/(^\s*)|(\s*$)/g,"");
                        if(data == '-1'){
                            whir_alert("您申请的时间段已定出，请重新申请。",null,null);
                            result=false;
                        }else{
                            if(isVideo == '1'){
                                if(Number($("#maxNumber").val())-(data)<Number($("#points").val())){
                                    whir_alert("该会议室本时间段内可以使用的点数为:"+(Number($("#maxNumber").val())-(data)),null,null);
                                    $("#points").val(Number($("#maxNumber").val())-(data));
                                    result=false;
                                }
                            }
                        }
                    }
                });
				if(document.getElementById("points")){
					var points=$("#points").val();
					if(points != ''){
						var reg = new RegExp(/^\d+$/);
						if(!reg.test(points)){
							whir_poshytip($('#points'),"点数只能输入正整数！");
							result=false;
						}
					}
				}
            }
        }
	}
	
	for(var i=0; i<_destineDate.length-1; i++){
        if(i!=1){
            //会议时间数组
            var destineDate = $('input[name=destineDate]:not(:disabled)')[i].value;
            $("#destineDateBeginTime").val($('select[name=startHour]')[i].value *3600 +$('select[name=startMinutes]')[i].value*60);
            $("#destineDateEndTime").val($('select[name=endHour]')[i].value *3600 +$('select[name=endMinutes]')[i].value*60);
            destineDateBeginTime = $("#destineDateBeginTime").val();
            destineDateEndTime = $("#destineDateEndTime").val();

            for(var j=i+1; j<_destineDate.length; j++){
                if(j!=1){
                    var destineDate2 = $('input[name=destineDate]:not(:disabled)')[j].value;
                    var destineDateBeginTime2 = $('select[name=startHour]')[j].value *3600 +$('select[name=startMinutes]')[j].value*60;
                    var destineDateEndTime2 = $('select[name=endHour]')[j].value *3600 +$('select[name=endMinutes]')[j].value*60;
			
                    if(destineDate == destineDate2 &&
                    ((eval(destineDateBeginTime)<=eval(destineDateBeginTime2) && eval(destineDateBeginTime2)<=eval(destineDateEndTime)) ||
                    (eval(destineDateBeginTime)<=eval(destineDateEndTime2) && eval(destineDateEndTime2)<=eval(destineDateEndTime)) ||
                    (eval(destineDateBeginTime)>=eval(destineDateBeginTime2) && eval(destineDateEndTime)<=eval(destineDateEndTime2)))){
                        whir_poshytip($('select[name=startHour]')[j],"申请的会议时间有重复，请调整。");
						
                        result=false;
						break;
                    }
                }
            }
        }
	}
	return result;
}
function checkMeetingDateAndTime(_index) {
	var pageDate =  $('input[name=destineDate]:not(:disabled)')[_index].value.replace(/[/]/g,"-");
	var today = new Date();
    var year= ( today.getYear() < 1900 ) ? ( 1900 + today.getYear() ):today.getYear();
	var hour = today.getHours();
	var minute = today.getMinutes();
	var time = (hour > 9 ? hour : ("0"+hour)) + ":" + (minute > 9 ? minute : ("0"+minute));
	var midStr = year + "-" + (today.getMonth()+1) + "-" + today.getDate();
	var beTime =$("#destineDateBeginTime").val();
	beTime = (beTime / 3600) + "";
	if (beTime.indexOf(".") > 0) {
		var tArr = beTime.split(".");
		var tH;
		var tT;
		if (tArr[0].length > 1)
			tH = "0" + tArr[0];
		else
			tH = tArr[0];
		if (tArr[1] = 5)
			tT = "30";
		else
			tT = "00";
		beTime = tH + ":" + tT;
	} else {
		if (beTime > 9)
			beTime = beTime + ":00";
		else
			beTime = "0" + beTime + ":00";
	}
if (checkDateEarlier(midStr, pageDate) == '0') {
		if (!confirm("选择的会议日期已过期， 是否确定安排这次会议！")){
			return false;
		} else {
			_flag = true;
		}
	} else if (checkDateEarlier(midStr, pageDate) == '1') {
		return true;
	} else if (comptime(time,beTime) != -1) {
		if (!confirm("选择的会议时间已过期， 是否确定安排这次会议！")){
			return false;
		} else {
			_flag = true;
		}
	}
	return true;
}
function checkIsValidDate(str){
    //如果为空，则通过校验
	if(str == ""){return true;}
	var pattern = /^((\\d{4})|(\\d{2}))-(\\d{1,2})-(\\d{1,2})$/g;
	var arrDate = str.split("-");
	if(parseInt(arrDate[0],10) < 100){
		arrDate[0] = 2000 + parseInt(arrDate[0],10) + "";
    }
    
	var date =  new Date(arrDate[0],(parseInt(arrDate[1],10) -1)+"",arrDate[2]);
    var year= ( date.getYear() < 1900 ) ? ( 1900 + date.getYear() ):date.getYear();
	if(year == arrDate[0]
		&& date.getMonth() == (parseInt(arrDate[1],10) -1)+""
		&& date.getDate() == arrDate[2]){
		return true;
    }else{
		return false;
    }
}
function checkDateEarlier(strStart,strEnd){
	if(checkIsValidDate(strStart) == false || checkIsValidDate(strEnd) == false) {
		alert("wrong");
		return false;
	}
    //如果有一个输入为空，则通过检验
	if (( strStart == "" ) || ( strEnd == "" ))
		return true;
	var arr1 = strStart.split("-");
	var arr2 = strEnd.split("-");
	var date1 = new Date(arr1[0],parseInt(arr1[1].replace(/^0/,""),10) - 1,arr1[2]);
	var date2 = new Date(arr2[0],parseInt(arr2[1].replace(/^0/,""),10) - 1,arr2[2]);
	if(arr1[1].length == 1)
		arr1[1] = "0" + arr1[1];
	if(arr1[2].length == 1)
		arr1[2] = "0" + arr1[2];
	if(arr2[1].length == 1)
		arr2[1] = "0" + arr2[1];
	if(arr2[2].length == 1)
		arr2[2]="0" + arr2[2];
	var d1 = arr1[0] + arr1[1] + arr1[2];
	var d2 = arr2[0] + arr2[1] + arr2[2];
	if(parseInt(d1,10) > parseInt(d2,10)) {
		return "0";
	} else if(parseInt(d1,10) < parseInt(d2,10)) {
		return "1";
	} else {
		return "2";
	}
	return "1";
}
function comptime(a,b) {
	var dateA = new Date("1900/1/1 " + a);
	var dateB = new Date("1900/1/1 " + b);
	if(isNaN(dateA) || isNaN(dateB)) return null;
	if(dateA > dateB) return 1;
	if(dateA < dateB) return -1;
	return 0;
}
function checkPhone(val) {//"^[0-9]{2,5}-?[0-9]{3,10}$"
    var regu = /["^[0-9]{2,5}-?[0-9]{3,10}$"/g ;
    var re = new RegExp(regu);
    if (val.search(re) != -1){
		try{
			return false ;
		}catch(e){
			return false ;
		}
        return false ;
    }
    return true;
}
function isPhone(val) {
	var str = "0123456789- ()" ;
	for(var i = 0  ; i < val.length ; i++ ) {
		if(str.indexOf(val.substring(i,i+1))==-1) {
			return false ;
		}
	}
	return true ;
}
function spechar3(value){
	return spechar(value,"\\\,/,?,#,&,\',\"");
}
function spechar(value,r_value){
	var speCharArr = r_value.split(",");
	for(var i=0;i<speCharArr.length;i++ ){
		if(speCharArr[i]!='' && value.indexOf(speCharArr[i])>=0){
			return replaceAll(r_value,",","，");
		}
	}
	return "";
}
//发送时校验表单
function _check_boardroomapply() {
	var p_wf_moduleId=$("#p_wf_moduleId").val();
	//alert("p_wf_moduleId:"+p_wf_moduleId);
	if(p_wf_moduleId == '15'){
		var result=checkFormElement();
		//alert("result:"+result);
		if(result){
			return true;
		}else{
			return false;
		}
	}else{
		return true;
	}
}
//预览
function cmdPrintpriview(){
	var p_wf_recordId=document.getElementById("p_wf_recordId").value;
	var val=whirRootPath +'/modules/subsidiary/boardroom/selectTemplate.jsp?boardroomApplyId='+p_wf_recordId;
	openWin({url:val,width:560,height:300,winName:'preview'});
}
//转批
function cmdZpToSend(){
	var p_wf_recordId=document.getElementById("p_wf_recordId").value;
	var url=whirRootPath +'/modules/subsidiary/boardroom/selectWorkFlowSW.jsp?boardroomApplyId='+p_wf_recordId+'&moduleId=16&isNewOrOld=new';
	openWin({url:url,width:560,height:300,winName:'zfWrokflow'});
	window.close();
}
//转发
function cmdZfToSend(){
	var p_wf_recordId=document.getElementById("p_wf_recordId").value;
	var p_wf_processInstanceId=document.getElementById("p_wf_processInstanceId").value;
	var p_wf_taskId=document.getElementById("p_wf_taskId").value;
	var verifyCode=document.getElementById("verifyCode").value;
	var val=whirRootPath +'/modules/subsidiary/boardroom/toSend.jsp?boardroomApplyId='+p_wf_recordId+'&isNewOrOld=new&p_wf_recordId='+p_wf_recordId+'&p_wf_processInstanceId='+p_wf_processInstanceId+'&p_wf_taskId='+p_wf_taskId+'&verifyCode='+verifyCode;
	openWin({url:val,width:800,height:700,winName:'zfToSend'});
}