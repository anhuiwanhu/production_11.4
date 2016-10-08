//20151012 -by jqq 当前栏目相关参数赋值（审核流程）
function processChangeChannel(val,str,fromGov){
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				if(data.processId!="0"){
					if(data.processId=="-1"){
						whir_alert(str);
						whirExtCombobox.setValue('channelId','');
					}else{
						//$("#Send").attr("disabled","disabled");
						$("#p_wf_pool_processId").val(data.processId);
						$("#channel").val(val);
						$("#reader").val(data.canReader);
						$("#readerName").val(data.canReaderName);
						$("#remindType").val(data.remindType);
						$("#printer").val(data.printer);
						$("#printerName").val(data.printerName);
						$("#printNum_").val(data.printNum);
						$("#downloader").val(data.downloader);
						$("#downloaderName").val(data.downloaderName);
						$("#downloadNum_").val(data.downloadNum);
						
						$("#module").val(fromGov);
						$("#form").attr("action","Information!start.action");
						//$("#form").submit();
					}
				//初始化网站同步
				//initOutSiteSynDiv();
				}
			}
		}
	});
}

//切换页签
function  changePanle(flag,id){
    for(var i=0;i<2;i++){
        $("#Panle"+i).removeClass("aon");
    }
    $("#Panle"+flag).addClass("aon");
    $("div[id^='docinfo']").hide();
    $("#docinfo"+flag).show();
	if(flag==1){
		//处理新建信息页面经常加载不出相关对象
		var url=whirRootPath+"/relation!relationIncludeList.action?moduleType=information&infoId="+id+"&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationadd=1";
		$("#relationIFrame").attr("src", url);
	}
}

function setEditerContent(){
	if ($("#tempContent").val()!=""){
		document.getElementById("newedit").contentWindow.setHTML($("#tempContent").val());
	}
}

function changeInfoType(val,isyibo){
	if(val==0){
		$("#temp").hide();
		$("#selectImg").show();
		if("1" == isyibo){
			$("#selectAppend").hide();
		}else{
			$("#selectAppend").show();
		}
		$("#txt").show();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==1){
		$("#temp").show();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").show();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==2){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").show();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==3){
		$("#temp").hide();
		$("#selectImg").hide();
		$("#selectAppend").hide();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").show();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").hide();
		//处理ie10点击选择文件没反应问题-----20130929
		whir_uploader_reset("uploadFile");
	}else if(val==4){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").show();
		$("#excel").hide();
		$("#ppt").hide();
	}else if(val==5){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").show();
		$("#ppt").hide();
	}else if(val==6){
		$("#temp").hide();
		$("#selectImg").show();
		$("#selectAppend").show();
		$("#txt").hide();
		$("#edit").hide();
		$("#url").hide();
		$("#file").hide();
		$("#word").hide();
		$("#excel").hide();
		$("#ppt").show();
	}
}

//选择模板
function changeTemplate(val){
	if(val != 0){
		$.ajax({
			type: 'POST',
			url: whirRootPath+"/Template!getTemplateContent.action?id="+val,
			async: true,
			dataType: 'text',
			success: function(data){
				if(data!=null && data!=""){
					document.getElementById("newedit").contentWindow.setHTML(data);
				}
			}
		});
    }else{
	    try{
			document.getElementById("newedit").contentWindow.setHTML("");
		}catch(e){}
    }
}

function fileLink(json){
	$("#fileLinkContent").val(json.file.name);
}

function uploadSuccess(json){
	$("#fileLinkContentHidd").val(json.save_name+json.file_type);
}

function selectReader(){
	var channelReader_ = $("#informationReaderId_").val();
	if(channelReader_!=""){
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelReader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationReaderId', allowName:'informationReaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectPrinter(){
	var channelPrinter_ = $("#informationPrinterId_").val();
	if(channelPrinter_!=""){
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelPrinter_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationPrinterId', allowName:'informationPrinterName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

function selectDownLoader(){
	var channelDownLoader_ = $("#informationDownLoaderId_").val();
	if(channelDownLoader_!=""){
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:channelDownLoader_,showShortcut:'0'});
	}else{
		openSelect({allowId:'informationDownLoaderId', allowName:'informationDownLoaderName', select:'userorggroup', single:'no', show:'orgusergroup', range:'*0*'});
	}
}

//加载网站同步信息
function initOutSiteSynDiv(){
    var _channel = whirExtCombobox.getValue('channelId');//whirCombobox.getValue("selectChannel");
	var _channelId="";
	if(_channel!=""&&_channel!="0"&&_channel!=null){
	    _channelId=_channel.substring(0,_channel.indexOf(","));
	}
	if(_channelId==""){
	    return ;
	}
    var url=whirRootPath+"/modules/kms/information_manager/informationmanager_info_synsite_div.jsp?channelId="+_channelId;
    var html = $.ajax({url: url,async: false}).responseText;
    $("#outSiteSynDiv").html(html); 
}
  
//处理键盘事件 禁止后退键（Backspace）密码或单行、多行文本框除外  
function banBackSpace(e){     
    var ev = e || window.event;//获取event对象     
    var obj = ev.target || ev.srcElement;//获取事件源     
    var t = obj.type || obj.getAttribute('type');//获取事件源类型    
    //获取作为判断条件的事件类型  
    var vReadOnly = obj.getAttribute('readonly');  
    var vEnabled = obj.getAttribute('enabled');  
    //处理null值情况  
    vReadOnly = (vReadOnly == null) ? false : vReadOnly;  
    vEnabled = (vEnabled == null) ? true : vEnabled;  
    //当敲Backspace键时，事件源类型为密码或单行、多行文本的，  
    //并且readonly属性为true或enabled属性为false的，则退格键失效  
    var flag1=(ev.keyCode == 8 && (t=="password" || t=="text" || t=="textarea")   
                && (vReadOnly==true || vEnabled!=true))?true:false;  
    //当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效  
    var flag2=(ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea")  
                ?true:false;          
    //判断  
    if(flag2){  
        return false;  
    }  
    if(flag1){     
        return false;     
    }     
}  

//初始化  
function chushihua(titlename,fromGov,title,govId,docNo,serverdate){     
	//信息类型change事件
	$(":radio[name='information.informationType']").change(function(){
		changeInfoType(this.value,$("#isyiboflag").val());
	});
	//有效期change事件
	$(":radio[name='information.informationValidType']").change(function(){
		if(this.value==1){
			$("#validBeginTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validEndTime").val(getFormatDate(new Date(),"yyyy-MM-dd"));
			$("#validTime").show();
		}else{
			$("#validBeginTime").val('');
			$("#validBeginTime").val('');
			$("#validTime").hide();
		}
	});
	//初始化发布时间
	$("#informationIssueTime").val(serverdate);
	//初始化可查看人
	var reader = $("#reader").val();
	var readerName = $("#readerName").val();
	if(reader!=''){
		$("#informationReaderId").val(reader);
		$("#informationReaderId_").val(reader);
		$("#informationReaderName").val(readerName);
	}
	//初始化可打印人
	var printer = $("#printer").val();
	var printerName = $("#printerName").val();
	if(printer!=''){
		$("#informationPrinterId").val(printer);
		$("#informationPrinterId_").val(printer);
		$("#informationPrinterName").val(printerName);
	}
	//打印次数
	var printNum = $("#printNum_").val();
	if(printNum!=''){
		$("#printNum").val(printNum);
	}
	//初始化可下载人
	var downloader = $("#downloader").val();
	var downloaderName = $("#downloaderName").val();
	if(downloader!=''){
		$("#informationDownLoaderId").val(downloader);
		$("#informationDownLoaderId_").val(downloader);
		$("#informationDownLoaderName").val(downloaderName);
	}
	//下载次数
	var downloadNum = $("#downloadNum_").val();
	if(downloadNum!=''){
		$("#downLoadNum").val(downloadNum);
	}
	//初始化内容
	setTimeout("setEditerContent()",500);
	//从公文同步
	//var fromGov = '<%=fromGov%>';
	if(fromGov=='1'||fromGov=='0'||fromGov=='4'){
		$(":radio[name='information.informationType'][value=4]").attr("checked",true);
		changeInfoType(4,$("#isyiboflag").val());
		$("#informationTitle").val(title);
		$("#fromGOV").val(fromGov);
		$("#fromGOVDocument").val(govId);
		$("#documentNo").val(docNo);
		$("#content").val($("#_content").val());
	}
	//工作流程同步
	if(fromGov=='2'){
		$(":radio[name='information.informationType'][value=1]").attr("checked",true);
		changeInfoType(1,$("#isyiboflag").val());
		$("#informationTitle").val(title);
		$("#fromGOV").val(fromGov);
		$("#fromGOVDocument").val(govId);
		if ($("#_content").val()!=""){
			$("#tempContent").val($("#_content").val());
			setTimeout("setEditerContent()",1000);
			//document.getElementById("newedit").contentWindow.setHTML($("#_content").val());
		}
	}

	//易播栏目页面初始化
	//易播栏目新建信息页面，部分页面元素不展示
	if("1" == $("#isyiboflag").val()){
			//易播文件模式，默认普通输入
			$(":radio[name='information.informationType'][value=0]").attr("checked",true);
			changeInfoType(0,$("#isyiboflag").val());
			$(":radio[name='information.informationType'][value='1']").hide().next().hide();
			$(":radio[name='information.informationType'][value='2']").hide().next().hide();
			$(":radio[name='information.informationType'][value='4']").hide().next().hide();
			$(":radio[name='information.informationType'][value='5']").hide().next().hide();
			$(":radio[name='information.informationType'][value='6']").hide().next().hide();
			$(document).attr("title","新易播信息");//修改title
			$("#info_add_center_1").hide();
			$("#info_add_1").hide();
			$("#temp").hide();
			$("#info_add_2").hide();
			$("#selectAppend").hide();
	}else{
	}
}
//选择栏目
function changeChannel(val,isyibo,newinfo,noprocess,fromGov){
	var infotype = $(':radio[name="information.informationType"]:checked').val();
	var channelId = val.substring(0,val.indexOf(","));
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!changeChannel.action?channelId="+channelId,
        async: false,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				//是否易播栏目
				var isYiBoChannel = data.isYiBoChannel != null && data.isYiBoChannel != "" && data.isYiBoChannel != '' ? data.isYiBoChannel : "0";
				//whir_alert(isYiBoChannel);
				$("#isyiboflag").val(isYiBoChannel); 
				$("#_isyiboflag").val(isYiBoChannel);
				//易播栏目新建信息页面，部分页面元素不展示
				if(isYiBoChannel == "1"){
					//易播文件模式，默认普通输入
					$(":radio[name='information.informationType'][value=0]").attr("checked",true);
					changeInfoType(0,"1");
					$(":radio[name='information.informationType'][value='1']").hide().next().hide();
					$(":radio[name='information.informationType'][value='2']").hide().next().hide();
					$(":radio[name='information.informationType'][value='4']").hide().next().hide();
					$(":radio[name='information.informationType'][value='5']").hide().next().hide();
					$(":radio[name='information.informationType'][value='6']").hide().next().hide();
					$(document).attr("title","新易播信息");//修改title
					$("#info_add_center_1").hide();
					$("#info_add_1").hide();
					$("#temp").hide();
					$("#info_add_2").hide();
					$("#selectAppend").hide();
				}else{
					if(infotype == null || infotype == ""){
						$(":radio[name='information.informationType'][value=1]").attr("checked",true);
						infotype = 1;
					}
					changeInfoType(infotype,"0");
					$(":radio[name='information.informationType'][value='1']").show().next().show();
					$(":radio[name='information.informationType'][value='2']").show().next().show();
					$(":radio[name='information.informationType'][value='4']").show().next().show();
					$(":radio[name='information.informationType'][value='5']").show().next().show();
					$(":radio[name='information.informationType'][value='6']").show().next().show();
					$(document).attr("title",newinfo);
					$("#info_add_center_1").show();
					$("#info_add_1").show();
					if(infotype == '1' || infotype == 1){
						$("#temp").show();
					}else{
						$("#temp").hide();
					}
					$("#info_add_2").show();
					if(infotype == '2' || infotype == '3'){
						$("#selectAppend").hide();
					}else{
						$("#selectAppend").show();
					}
				}
				if(data.processId!="0"){
					if(data.processId=="-1"){
						whir_alert(noprocess);
						whirExtCombobox.setValue('channelId','');
					}else{
						$("#Send").attr("disabled","disabled");
						$("#p_wf_pool_processId").val(data.processId);
						$("#channel").val(val);
						$("#reader").val(data.canReader);
						$("#readerName").val(data.canReaderName);
						$("#remindType").val(data.remindType);
						$("#printer").val(data.printer);
						$("#printerName").val(data.printerName);
						$("#printNum_").val(data.printNum);
						$("#downloader").val(data.downloader);
						$("#downloaderName").val(data.downloaderName);
						$("#downloadNum_").val(data.downloadNum);
						if($(':radio[name="information.informationType"]:checked').val()=='1'){
							try{
								$("#tempContent").val(document.getElementById("newedit").contentWindow.getHTML());
							}catch(e){

							}
						}
						//var fromGov = '<%=fromGov%>';
						$("#module").val(fromGov);
						$("#form").attr("action","Information!start.action");
						$("#form").submit();
					}
				}else{
					$("#channel").val(val);
					$("#reader").val(data.canReader);
					$("#readerName").val(data.canReaderName);
					$("#remindType").val(data.remindType);
					$("#printer").val(data.printer);
					$("#printerName").val(data.printerName);
					$("#printNum_").val(data.printNum);
					$("#downloader").val(data.downloader);
					$("#downloaderName").val(data.downloaderName);
					$("#downloadNum_").val(data.downloadNum);
					if($(':radio[name="information.informationType"]:checked').val()=='1'){
						$("#tempContent").val(document.getElementById("newedit").contentWindow.getHTML());
					}
					//var fromGov = '<%=fromGov%>';
					$("#module").val(fromGov);
					$("#form").attr("action","Information!add.action");
					$("#form").submit();
				}
				//初始化网站同步
				initOutSiteSynDiv();
			}
		}
	});
}
//禁止页面右键（点击返回页面退回，可能导致审核信息不经审核就保存）
function stoprightbutton(){
	return false;
}
document.oncontextmenu = stoprightbutton; 

//20160111 -by jqq 页面禁止回退
window.location.hash="";
window.location.hash="";//again because google chrome don't insert first hash into history
window.onhashchange=function(){window.location.hash="";}