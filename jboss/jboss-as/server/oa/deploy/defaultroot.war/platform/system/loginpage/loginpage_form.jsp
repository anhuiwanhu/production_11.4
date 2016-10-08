<s:hidden name="loginPagePO.id" id="id"/>
<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline" >
    <tr>
        <td for="登录页名称" width="100" class="td_lefttitle">登录页名称<span class="MustFillColor">*</span>：</td>
        <td><s:textfield name="loginPagePO.setName" id="setName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':30},'spechar3']" cssStyle="width:98%;" maxlength="30"/>
        </td>
    </tr>
    <tr>
        <td for="LOGO图" class="td_lefttitle" valign=top>系统LOGO图：</td>
        <td>
            <s:hidden name="loginPagePO.loginPic" id="loginPic"/>
            <s:hidden name="loginPagePO.loginPicName" id="loginPicName"/>
            <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="isShowBatchDownButton"     value="no" />
                <jsp:param name="accessType"       value="include" />
                <jsp:param name="makeYMdir"        value="yes" />
                <jsp:param name="dir"      value="loginpage" />
                <jsp:param name="uniqueId"    value="uniqueId_loginPic" />
                <jsp:param name="realFileNameInputId"    value="loginPicName" />
                <jsp:param name="saveFileNameInputId"    value="loginPic" />
                <jsp:param name="canModify"       value="yes" />
               
                <jsp:param name="multi"        value="false" />
                <jsp:param name="buttonClass" value="upload_btn" />
                <jsp:param name="buttonText"       value="上传图片" />
                <jsp:param name="fileSizeLimit"        value="0" />
                <jsp:param name="fileTypeExts"         value="*.png;" />
                <jsp:param name="uploadLimit"      value="1" />
            </jsp:include> 
            <font color="#999999"><span class="MustFillColor">上传要求：350*80px，格式：png</span></font>
        </td>
    </tr>
    <tr>
        <td for="主背景图" class="td_lefttitle" valign=top>主背景图：</td>
        <td>
            <s:hidden name="loginPagePO.broadPic" id="broadPic"/>
            <s:hidden name="loginPagePO.broadPicName" id="broadPicName"/>
            <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                <jsp:param name="isShowBatchDownButton"     value="no" />
                <jsp:param name="accessType"       value="include" />
                <jsp:param name="makeYMdir"        value="yes" />
                <jsp:param name="dir"      value="loginpage" />
                <jsp:param name="uniqueId"    value="uniqueId_broadPic" />
                <jsp:param name="realFileNameInputId"    value="broadPicName" />
                <jsp:param name="saveFileNameInputId"    value="broadPic" />
                <jsp:param name="canModify"       value="yes" />
 				
                <jsp:param name="multi"        value="false" />
                <jsp:param name="buttonClass" value="upload_btn" />
                <jsp:param name="buttonText"       value="上传图片" />
                <jsp:param name="fileSizeLimit"        value="0" />
                <jsp:param name="fileTypeExts"         value="*.jpg;*.png;" />
                <jsp:param name="uploadLimit"      value="3" />
            </jsp:include> 
            <font color="#999999"><span class="MustFillColor">上传要求：1920*1080px，格式：png/jpg，最多允许上传3张</span></font>
        </td>
    </tr>
    <tr>
     	<td for="二维码" class="td_lefttitle" valign=top>二维码：</td>
     	<td>
     		 <s:radio id="qrcodeStatus" name="loginPagePO.qrcodeStatus" list="#{'0':'关闭','1':'开启'}" onclick = "openEwm(this);" ></s:radio>
     	</td>
     </tr>
     <tr id= "ewmPhoto" style = "display: none;">
        <td for="上传二维码" class="td_lefttitle" valign=top>上传二维码：</td>
        <td>
        	<input type = "button" value = "添加二维码" onclick="addEwm()" class="wh-fileup-ewm"/>
        	<div><font color="#999999"><span class="MustFillColor">上传要求：200*200px，格式：png/jpg</span></font><div>
        </td>
        <td>
	            <s:hidden name="loginPagePO.mainPic" id="mainPic"/>
 	            <s:hidden name="loginPagePO.mainPicName" id="mainPicName"/>
        </td>
    </tr>
    <tr id= "ewmNameshow">
    	<td></td>
    	<td id = "trewm" class="ewm_code_info"></td>
    <tr>
    <tr class="Table_nobttomline">
        <td></td>
        <td nowrap>
            <input type="button" class="btnButton4font" onClick="saveLoginpage(0,this);" value='<s:text name="comm.saveclose"/>' />
            <input type="button" class="btnButton4font" onClick="seePreview();" value="预览效果" />
            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />
            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
        </td>
    </tr>
    <iframe id="downf" name="downf" style="display:none;"></iframe>
</table>
<SCRIPT LANGUAGE="JavaScript">


$(document).ready(function() {
	 var value=""; 
	  var radio=document.getElementsByName("loginPagePO.qrcodeStatus");
	   for(var i=0;i<radio.length;i++){ 
	   if(radio[i].checked==true){ 
		   value=radio[i].value;
		   openEwm(radio[i]);
		    break; 
	   	} 
	  } 	
	  if(value == ""){
		   radio[0].checked = true;
		 }
	//加载显示项
	var mainPicName  = $("#mainPicName").val();
	var mainPic = $("#mainPic").val();
	var qrcodeVerifyCode = $("#qrcodeVerifyCode").val();
	var pid  = "";
	var hz = "";
	if(mainPicName != "" && mainPic != ""){
		var mainPicNameArr = mainPicName.split("|");
		var mainPicArr = mainPic.split("|");
		for(var i=0;i<mainPicNameArr.length;i++){
			if(mainPicArr[i] != null && mainPicArr[i] != ""){
				var pidArr = mainPicArr[i].split(".");
				if(pidArr.length > 1){
				 pid = pidArr[0];
				 hz = pidArr[1];
				}else{
				 pid = pidArr[0];
				}
			}
			$("#trewm").append(" <p id = '"+pid+"'><a style='cursor:pointer;' title ='点击下载' href = '/defaultroot/platform/monitor/download.jsp?FileName="+mainPicArr[i]+"&name="+encodeURIComponent(mainPicNameArr[i]+"."+hz)+"&path=loginpage\' target='downf'><span>"+mainPicNameArr[i]+"</span></a>&nbsp;&nbsp;<img src = '/defaultroot/images/del.gif' onclick = deleteEwmName(this,\'"+mainPicNameArr[i]+"\',\'"+mainPicArr[i]+"\') /></p>");
		}
	}
});
function addEwm(){
    var url = whirRootPath + "/platform/system/loginpage/ewmSet.jsp";
	popup({content:'url:'+url, title:"添加二维码", width:'500px', height:'240px', lock:true, resize: false, min: false, max: false});
}

//是否开启二维码
function openEwm(obj){
	if(obj.value == 0){
		$("#ewmPhoto").hide();
		$("#ewmNameshow").hide();
	}else if(obj.value == 1){
		$("#ewmPhoto").show();
		$("#ewmNameshow").show();
	}
}

function getEwmStyle(){
	var value=""; 
	  var radio=document.getElementsByName("loginPagePO.qrcodeStatus");
	   for(var i=0;i<radio.length;i++){ 
	   if(radio[i].checked==true){ 
		   value=radio[i].value;
		   openEwm(radio[i]);
		    break; 
	   	} 
	  } 	
	return value;
}

//删除二维码
function deleteEwmName(obj,ewmName,mainPic1){
	window.parent.whir_confirm("确认要删除此二维码吗？",function(){
	//为隐藏域赋值
	var oldmainPicName = $("#mainPicName").val();
	var oldmainPic = $("#mainPic").val();
	var newmainPicName = "";
	var newmainPic = "";
	if(oldmainPicName != ""){
		var mainPicNameArr = oldmainPicName.split("|");
		for(var i=0;i<mainPicNameArr.length;i++){
			if(mainPicNameArr[i] !=  ewmName){
				newmainPicName += mainPicNameArr[i]+"|";
			}
		}
		if(newmainPicName != ""){
			newmainPicName =  newmainPicName.substring(0,newmainPicName.length-1);
		}
		 $("#mainPicName").val(newmainPicName);	
	}
	if(oldmainPic != ""){
		var oldmainPicArr = oldmainPic.split("|");
		for(var i=0;i<oldmainPicArr.length;i++){
			if(oldmainPicArr[i] !=  mainPic1){
				newmainPic += oldmainPicArr[i]+"|";
			}
		}
		if(newmainPic != ""){
			newmainPic =  newmainPic.substring(0,newmainPic.length-1);
		}
			$("#mainPic").val(newmainPic);	
	}
	//删除显示项
	if(mainPic1 != ""){
		var pId = mainPic1.split(".");
		$("#"+pId[0]).remove();
	}
	//删除数据库数据，暂时先不处理
	
	});
}

function seePreview() {
    var logopicacc = $('#loginPic').val();
    var logoindexpicacc = $('#mainPic').val();
    var logoindexpicaccName = $('#mainPicName').val();
    var logobroadpicacc = $('#broadPic').val();
	var isOpenewm = getEwmStyle();
    /*if (logopicacc == "") {
        logopicacc = whirRootPath + "/images/loginpage/logo.png";
    } else {
        logopicacc = preUrl + "/upload/loginpage/" + logopicacc.substring(0, 6) + "/" + logopicacc;
    }

    if (logoindexpicacc == "") {
        logoindexpicacc = "";
    } else {
        logoindexpicacc = preUrl + "/upload/loginpage/" + logoindexpicacc.substring(0, 6) + "/" + logoindexpicacc;
    }

    if (logobroadpicacc == "") {
        logobroadpicacc = whirRootPath + "/images/loginpage/main_bodybg.jpg";
    } else {
        logobroadpicacc = preUrl + "/upload/loginpage/" + logobroadpicacc.substring(0, 6) + "/" + logobroadpicacc;
    }

    openWin({url:"<%=rootPath%>/LoginPageSet!previewLoginPage.action?preview=true&logopicacc=" + logopicacc + "&logoindexpicacc=" + logoindexpicacc + "&logobroadpicacc=" + logobroadpicacc,isPost:true,isFull:true,isScroll:'yes',winName:'p'});*/
    openWin({url:"<%=rootPath%>/LoginPageSet!previewLoginPage.action?preview=true&logopicacc=" + logopicacc + "&logoindexpicacc=" + logoindexpicacc + "&logobroadpicacc=" + logobroadpicacc+"&logoindexpicaccName="+logoindexpicaccName+"&isOpenewm="+isOpenewm,isPost:true,isFull:true,isScroll:'yes',winName:'p'});
}

function resetTheDataForm(obj){
    resetDataForm(obj);
    location.href = whirRootPath + '/LoginPageSet!addLoginPage.action';
}

function saveLoginpage(flag,obj){
	var setName = $.trim($('#setName').val());
	var id = $('#id').val();
	if(setName!=null&&setName!=""){
		$.ajax({
							url: whirRootPath+"/LoginPageSet!getLoginPageSetBySetName.action?setName="+setName+"&id="+id,
							cache: false,
							async: true,
							success: function(dataForm) {
								var data = eval('('+dataForm+')');
								if(data.result=="true"){
									$('#setName').focus();
								  whir_alert("该名称不能为空，请重新填写 ！");
								}else{
									
									ok(flag,obj);
								}
							}
						});
	}else{
		whir_alert("该名称不能为空，请重新填写 ！");
	}  
}


</SCRIPT>
 <style type="text/css">
	 	input.wh-fileup-ewm{
	 		padding: 1px 6px;
	 		align-items: flex-start;
		    text-align: center;
		    cursor: default; 
		    padding: 4px 0;
		    text-align: center; 
		    box-sizing: border-box;
		    background-color: #fff;
			border: 1px solid gray;
			width:94px;
			font-size:12px;
			
	 	} 
	 	.ewm_code_info p a{
	 		display:inline-block;
	 		float:left;
	 	}
</style>