/******************************************************公共函数***********************************************************************************/
var loadComplete = false;//是否加载完毕
//国产化
if(typeof checkCOS == 'function'){
    if(checkCOS()){
        isAttachPreview="0";
    }
}
function init(json){
	var dir = json.dir ,uniqueId = json.uniqueId ,canModify = json.canModify ,realFileNameInputId = json.realFileNameInputId ,saveFileNameInputId = json.saveFileNameInputId ;
	var realFileName = $('#'+realFileNameInputId).val();
	var saveFileName = $('#'+saveFileNameInputId).val();
	if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
		realFileName = $('#'+realFileNameInputId,window.parent.document).val();
		saveFileName = $('#'+saveFileNameInputId,window.parent.document).val(); 
	}
	
	if(realFileName != ""){
		$('#'+uniqueId).find("#files").show();
		$('#'+uniqueId).find("#files").css('display','block');

		while(realFileName.substring(realFileName.length-1, realFileName.length) == '|'){
			realFileName = realFileName.substring(0, realFileName.length-1);
		}
		while(saveFileName.substring(saveFileName.length-1, saveFileName.length) == '|'){
			saveFileName = saveFileName.substring(0, saveFileName.length-1);
		}

		var r_arr = realFileName.split("|");
		var s_arr = saveFileName.split("|");
        var isEncrypt_arr = "";
        var verifyCode_arr = "";
		
		//显示批量下载按钮
		if($("#"+uniqueId).find("#batchdownload_btn").length > 0 && s_arr.length > 1){
			$("#"+uniqueId).find("#batchdownload_btn").show();
			$("#"+uniqueId).find("#batchdownload_btn").css('display', 'block');
		}

        var previewUrl = preUrl.indexOf('http://')!=-1?preUrl+"/public/viewfile/fileview.jsp":whirRootPath+"/public/viewfile/file_view.jsp";
        var downloadUrl = preUrl + "/public/download/download.jsp?";
        if(isPad()){
            downloadUrl = preUrl + "/DownloadServlet?cd=inline&isPad=true&";
        }
		
        var total_file_size_ = 0;
		for(var i=0, rlen=r_arr.length; i<rlen; i++){
			if(r_arr[i] != ''){		
				var msg = $.ajax({
							  type : "post",
							  url  : whirRootPath+"/public/upload/uploadify/getFileInfo.jsp",
						      data : "saveFileName="+s_arr[i]+'&date='+Math.random(),
							  async: false
						 }).responseText;
				var file_info = eval('('+$.trim(msg)+')');
				var name = r_arr[i].replaceAll_("&","|").replaceAll_("'","&#39;");
				
				//更新总大小
				var size = file_info.accLongSize;//accSizeStr;
                total_file_size_ += size;
                var isEncrypt = file_info.isEncrypt;
                if("1" != isEncrypt) isEncrypt = "0";

                isEncrypt_arr += isEncrypt + ",";
                verifyCode_arr += file_info.dlcode + "|";

                if(isPad()){
                    downloadUrl += "encrypt="+isEncrypt+"&";
                }
				
				if(canModify == 'yes'){
                    var _files_tr = '<tr><td><img src="'+whirRootPath+'/images/fj2.gif" /></td><td id="file_name"><a href="javascript:void(0);" onclick=\'commonSubmitDynamicForm({target:"downloadFileIfr'+uniqueId+'",action:"'+downloadUrl+'verifyCode='+file_info.dlcode+'&FileName='+s_arr[i]+'&path='+dir+'", params:[{"name\":"name", "value":"'+name+'"}]});\' title="'+comm.whir_upload_7+'" filename="'+r_arr[i]+'">'+r_arr[i]+'</a></td><td id="persent" style="color:#3F7F7F" nowrap>100%</td><td id="file_size" nowrap>'+file_info.accSizeStr+'</td><td id="delete"><img size="'+size+'" src="'+whirRootPath+'/public/upload/uploadify/del.gif" id="'+s_arr[i]+'" uploaded="yes" title="'+comm.whir_delete+'" onclick="deleteUploadedFile(this,\''+dir+'\',\''+uniqueId+'\',\''+realFileNameInputId+'\',\''+saveFileNameInputId+'\',0);" /></td>';
                    var _file_tolowercase = s_arr[i].toLowerCase();
                    var _fileType = _file_tolowercase.substring(_file_tolowercase.lastIndexOf('.'));
                    if(',.jpg,.png,.gif,.bmp,.jpeg,'.indexOf(_fileType)!=-1){
                        _files_tr += '<td nowrap>&nbsp;<a href="javascript:void(0);" onclick="window.open(\''+whirRootPath+'/public/upload/uploadify/view.jsp?fileName='+s_arr[i]+'&path='+dir+'\',\'\',\'TOP=100,LEFT=100,scrollbars=yes,resizable=yes,width=600,height=400\')">预览</a></td>';
                    }else if(',.mpg,.mp3,.wmv,.avi,.mpeg,.rm,.ipx,.rmvb,.swf,.wav,.mov,.asf,'.indexOf(_fileType)!=-1){
                        _files_tr += '<td nowrap>&nbsp;<a href="javascript:void(0);" onclick="window.open(\''+preUrl +'/public/download/player.jsp?fileType='+_fileType+'&fileName='+s_arr[i]+'&path='+dir+'\',\'\',\'TOP=100,LEFT=100,scrollbars=yes,resizable=yes,width=600,height=400\')">播放</a></td>';
                    }else if(isAttachPreview == '1' && ',.txt,.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,'.indexOf(_fileType)!=-1 && isPad()==false){//在线预览、编辑功能
                        _files_tr += '<td nowrap>&nbsp;<a href="javascript:void(0);" onclick="_previewFile(\''+previewUrl +'\', \''+dir+'\', \''+s_arr[i]+'\', \''+file_info.dlcode+'\', \''+isEncrypt+'\');">预览</a>';
                        //if($.browser.msie || "ActiveXObject" in window){
                            if(',.doc,.docx,.xls,.xlsx,.ppt,.pptx,'.indexOf(_fileType)!=-1){
                                _files_tr += '&nbsp;&nbsp;<a href="javascript:void(0);" onclick="window.open(\''+whirRootPath+'/public/iWebOfficeSign/AttachmentEdit.jsp?moduleType='+dir+'&docName='+s_arr[i]+'&showEditButton=1&code='+file_info.dlcode+'&isEncrypt='+isEncrypt+'\',\'oneditfile\',\'TOP=100,LEFT=100,scrollbars=yes,resizable=yes,width=800,height=600\')">在线编辑</a>';
                            }
                        //}
                        _files_tr += '</td>';
                    }
                    _files_tr += '</tr>';
					$('#'+uniqueId).find("#files").append(_files_tr);
				}else{
                    var _files_tr = '<tr><td><img src="'+whirRootPath+'/images/fj2.gif" /></td><td id="file_name"><a href="javascript:void(0);" onclick="singleDownload(\''+uniqueId+'\', \''+downloadUrl+'\', \''+file_info.dlcode+'\', \''+s_arr[i]+'\', \''+name+'\', \''+dir+'\');" title="'+comm.whir_upload_7+'" filename="'+r_arr[i]+'">'+r_arr[i]+'</a></td><td id="persent" style="color:#3F7F7F">&nbsp;</td><td id="file_size">'+file_info.accSizeStr+'</td><td id="delete">&nbsp;</td>';
                    var _file_tolowercase = s_arr[i].toLowerCase();
                    var _fileType = _file_tolowercase.substring(_file_tolowercase.lastIndexOf('.'));                    
                    if(',.jpg,.png,.gif,.bmp,.jpeg,'.indexOf(_fileType)!=-1){
                        _files_tr += '<td nowrap><a href="javascript:void(0);" onclick="window.open(\''+whirRootPath+'/public/upload/uploadify/view.jsp?fileName='+s_arr[i]+'&path='+dir+'\',\'\',\'TOP=100,LEFT=100,scrollbars=yes,resizable=yes,width=600,height=400\')">预览</a></td>';
                    }else if(',.mpg,.mp3,.wmv,.avi,.mpeg,.rm,.ipx,.rmvb,.swf,.wav,.mov,.asf,'.indexOf(_fileType)!=-1){
                        _files_tr += '<td nowrap><a href="javascript:void(0);" onclick="window.open(\''+preUrl +'/public/download/player.jsp?fileType='+_fileType+'&fileName='+s_arr[i]+'&path='+dir+'\',\'\',\'TOP=100,LEFT=100,scrollbars=yes,resizable=yes,width=600,height=400\')">播放</a></td>';
                    }else if(isAttachPreview == '1' && ',.txt,.pdf,.doc,.docx,.xls,.xlsx,.ppt,.pptx,'.indexOf(_fileType)!=-1 && isPad()==false){//在线预览
                        _files_tr += '<td nowrap>&nbsp;<a href="javascript:void(0);" onclick="_previewFile(\''+previewUrl +'\', \''+dir+'\', \''+s_arr[i]+'\', \''+file_info.dlcode+'\', \''+isEncrypt+'\');">预览</a>';
                        _files_tr += '</td>';
                    }
                    _files_tr += '</tr>';
					$('#'+uniqueId).find("#files").append(_files_tr);
				}
			}
		}
        $("#"+uniqueId).find("#total_file_size").val(total_file_size_);
	
		//绑定批量下载按钮事件
		$("#batch_"+uniqueId).bind("click",function(){
            initBatchDownLoad(uniqueId, dir, saveFileName, realFileName, realFileNameInputId, isEncrypt_arr, verifyCode_arr);
		});		
	}
	
	//自适应iframe的高度
	var offset = 30;
	if(canModify != 'yes'){
		offset = 5;
	}

    var _userAgent = window.navigator.userAgent.toLowerCase();
	
	//iframe情况
	if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
		offset = 45;
		if(canModify != 'yes'){
            if($.browser.chrome || $.browser.opera || (_userAgent.indexOf('chrome') != -1 && _userAgent.indexOf('safari ') != -1)){
                offset = 35;
            }else{
			    offset = 25;
            }
		}
	}

	iframeResizeHeight_upload(uniqueId,$("#"+uniqueId).find("#filesDiv_").eq(0), offset);
	
	setTimeout(function(){iframeResizeHeight_upload(uniqueId,$("#"+uniqueId).find("#filesDiv_").eq(0),offset);}, 1500);

    //加载完毕
    loadComplete = true;
}	

function _previewFile(previewUrl, dir, fileName, verifyCode, isEncrypt){
    if(loadComplete==false)return;

    window.open(previewUrl +'?path='+dir+'&convertType=pdfToSwf&fileName='+fileName+'&isEncrypt='+isEncrypt+'&verifyCode='+verifyCode+'&width=800&height=500','preview','TOP=100,LEFT=100,scrollbars=yes,resizable=yes,width=1024,height=768');
}

function deleteUploadedFile(obj, dir, uniqueId, realFileNameInputId, saveFileNameInputId, isInit){
	window.parent.whir_confirm(comm.whir_upload_8, function(){
        //--知识文库删除附件时，同时删除表单--start--
        try{
            var id1 = $(obj).attr("id");
            var fid = id1.split(".")[0];
            $("#"+fid).remove();
        }catch(e){alert(e);}
        //--知识文库删除附件时，同时删除表单--end--

		//if(uniqueId.indexOf('$')!=-1)uniqueId = uniqueId.replace(/\$/g,"\\$");
		//if(realFileNameInputId.indexOf('$')!=-1)realFileNameInputId = realFileNameInputId.replace(/\$/g,"\\$");
		//if(saveFileNameInputId.indexOf('$')!=-1)saveFileNameInputId = saveFileNameInputId.replace(/\$/g,"\\$");

        uniqueId = replaceDollar(uniqueId);
        realFileNameInputId = replaceDollar(realFileNameInputId);
        saveFileNameInputId = replaceDollar(saveFileNameInputId);
		
		var src = $(obj).attr("src");
		//未上传成功或正在上传中.
		if(src.substring(src.lastIndexOf(".")+1,src.length) == "jpg"){
			return false;
		}

		var id = $(obj).attr("id");
		if(id == undefined || id == 'img'){
			$(obj).parent().parent().remove();
			return false;

		}else{
            $(obj).parent().parent().remove();

            if($("#"+uniqueId).find("#files").find("tr").length == 0){
                $("#"+uniqueId).find("#files").hide();
            }
            
            //隐藏批量下载按钮
            if($("#"+uniqueId).find("#files").find("img[uploaded='yes']").length <= 1){
                $("#"+uniqueId).find("#batchdownload_btn").hide();
            }

            //重新设值
            resetFileValue(id, realFileNameInputId, saveFileNameInputId);

            //更新总大小
            var size = $(obj).attr("size");
            var s = $("#"+uniqueId).find("#total_file_size").val();
            $("#"+uniqueId).find("#total_file_size").val(s*1+0-size);
            
            //更新插件自己的统计
            //var s = window['uploadify_div_' + uniqueId].getStats();
            //var d  = s.successful_uploads -1 ;//alert(d);
            //window['uploadify_div_' + uniqueId].setStats({files_queued:0,successful_uploads:d,upload_errors:0});
                
            //删除当前上传的文件的物理文件（isInit==1），之前已经上传的文件不删除物理文件（isInit==0），主要在修改页面，防止未点击保存按钮就删除了文件.
            var addParam = '';
            if(attachPortletSettingId != '' && attachPortletSettingId != null && attachPortletSettingId != 'null'){//portlet设置上传图片、媒体文件，删除功能
                isInit = 1;
                addParam = "&portletSettingId="+attachPortletSettingId;//删除portlet对应的记录
            }
            if(isInit==1){
                jQuery.ajax({
                    type: "POST",
                    url: whirRootPath+"/public/upload/uploadify/deleteFile.jsp?delpath="+dir+"&delfile="+id+addParam,
                    success: function(msg){
                        if($.trim(msg) == "success"){
                            
                        }else if($.trim(msg) == "fault"){
                            //whir_alert("删除失败!",null); 
                        }
                    },error: function (data, status, e){   		
                        //whir_alert("删除失败!",null);   
                    }
                });
            }
            
            //自适应iframe的高度
            var offset = 30;
            //iframe情况
            if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
                offset = 45;
            }
            iframeResizeHeight_upload(uniqueId,$("#"+uniqueId).find("#filesDiv_").eq(0),offset);
        }
	});
}

function resetFileValue(id, realFileNameInputId, saveFileNameInputId){
	var realFileName = $("#"+realFileNameInputId).val();
	var saveFileName = $("#"+saveFileNameInputId).val();
	if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
		realFileName = $("#"+realFileNameInputId, window.parent.document).val();
		saveFileName = $("#"+saveFileNameInputId, window.parent.document).val();
	}
	var new_realFileName = "";
	var new_saveFileName = "";
	if(realFileName!=""){
		var r_arr = realFileName.split("|");
		var s_arr = saveFileName.split("|");							
		for(var i=0;i<s_arr.length;i++){
			//id是删除的文件的id
			if(s_arr[i] != id){
				new_realFileName += r_arr[i]+"|";
				new_saveFileName += s_arr[i]+"|";
			}
		}
	}
	if(new_realFileName!=""){
		new_realFileName = new_realFileName.substring(0,new_realFileName.length-1);
		new_saveFileName = new_saveFileName.substring(0,new_saveFileName.length-1);
	}
	
	if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
		$("#"+realFileNameInputId,window.parent.document).val(new_realFileName);
		$("#"+saveFileNameInputId,window.parent.document).val(new_saveFileName);
	}else{
		$("#"+realFileNameInputId).val(new_realFileName);
		$("#"+saveFileNameInputId).val(new_saveFileName);
	}
}

function setFileValue(c_realFileName, c_saveFileName, realFileNameInputId, saveFileNameInputId){
	var realFileName = $("#"+realFileNameInputId).val();
	var saveFileName = $("#"+saveFileNameInputId).val();
	//alert(self.frameElement.name );
	if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
		realFileName = $("#"+realFileNameInputId,window.parent.document).val();
		saveFileName = $("#"+saveFileNameInputId,window.parent.document).val();
	}

    var R_splitChar1 = '|';
    var S_splitChar2 = '|';
    if(realFileName.charAt(realFileName.length-1)==R_splitChar1){
        R_splitChar1 = '';
    }
    if(saveFileName.charAt(saveFileName.length-1)==S_splitChar2){
        S_splitChar2 = '';
    }
	
	if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
		if(realFileName == ""){
			$("#"+realFileNameInputId,window.parent.document).val(c_realFileName);
		}else{
			$("#"+realFileNameInputId,window.parent.document).val(realFileName+ R_splitChar1 +c_realFileName);
		}
		if(saveFileName == ""){
			$("#"+saveFileNameInputId,window.parent.document).val(c_saveFileName);
		}else{
			$("#"+saveFileNameInputId,window.parent.document).val(saveFileName+ S_splitChar2 +c_saveFileName);
		}
	}else{
		if(realFileName == ""){
			$("#"+realFileNameInputId).val(c_realFileName);
		}else{
			$("#"+realFileNameInputId).val(realFileName+ R_splitChar1 +c_realFileName);
		}
		if(saveFileName == ""){
			$("#"+saveFileNameInputId).val(c_saveFileName);
		}else{
			$("#"+saveFileNameInputId).val(saveFileName+ S_splitChar2 +c_saveFileName);
		}
	}
}

function checkUploadFile(file, uniqueId, fileSizeLimit, uploadLimit){
	//校验文件个数
	var count = $("#"+uniqueId).find("#files").find("tr").length;
	if( (count+1) > uploadLimit ){
		$.dialog.alert('最多只能上传'+uploadLimit+'个文件！',function(){});
		return false;
	}else if(fileSizeLimit!='0'){
		var size = file.size;
		var tsize = 0;
		if(fileSizeLimit.indexOf('GB') >0){
			tsize = fileSizeLimit.substring(0,fileSizeLimit.length-2)*1024*1024*1024+0;
		}else if(fileSizeLimit.indexOf('MB') >0){
			tsize = fileSizeLimit.substring(0,fileSizeLimit.length-2)*1024*1024+0;
		}else if(fileSizeLimit.indexOf('KB') >0){
			tsize = fileSizeLimit.substring(0,fileSizeLimit.length-2)*1024+0;
		}else if(fileSizeLimit.indexOf('B') >0){
			tsize = fileSizeLimit.substring(0,fileSizeLimit.length-1)*1+0;
		}	
		if(size > tsize){
			$.dialog.alert('上传文件最大为'+fileSizeLimit+'！',function(){});
			return false;
		}
	}
}

/******************************************************公共回调函数***********************************************************************************/
function onSelect(select_json){
	var file = select_json.file ;
	var uniqueId = select_json.uniqueId ;
	var realFileNameInputId = select_json.realFileNameInputId;
	var files = select_json.files;
	var uploader = select_json.uploader;
	
	var b = false;
	$("#"+uniqueId).find("#files").find("a").each(function(){
		if($(this).attr('filename') == file.name){
			b = true;
			return false;
		}
	});

	if(b){
		whir_alert(file.name+comm.whir_upload_9,null,null);

		$.each(files, function(i, file1) {
            if(file.name == file1.name){
   	 		    uploader.removeFile(file1);
                try{
                    if(cansend == '0')cansend = "1";//目前仅内部邮件使用
                }catch(e){}
                return false ;
            }
   	 	});

		return false ;
	}
	
	//2015-12-18 限制上传图片名称  xiehd
	if(file.name.length>100){
		whir_alert("文件名称过长,请重新上传！");
		$.each(files, function(i, file1) {
            		if(file.name == file1.name){
   	 		    uploader.removeFile(file1);
                	try{
                    		if(cansend == '0')cansend = "1";//目前仅内部邮件使用
               		 }catch(e){}
                	return false ;
            		}
   	 	});
		return false ;
	}
	
	
	
    $("#"+uniqueId).find("#files").show();
    var size = file.size;
    var s = $("#"+uniqueId).find("#total_file_size").val();
    $("#"+uniqueId).find("#total_file_size").val(s*1+0+size);
    
    var file_size = "";
    if(size>=(1024*1024*1024)){
        size = (size/(1024*1024*1024)).toFixed(2);
        file_size = size+"GB";
    }else if(size>=(1024*1024)){
        size = (size/(1024*1024)).toFixed(2);
        file_size = size+"MB";
    }else if(size>=1024){
        size = (size/1024).toFixed(2);
        file_size = size+"KB";
    }else{
        file_size = size+"B";
    }

    $("#"+uniqueId).find("#files").append('<tr><td><img src="'+whirRootPath+'/images/fj2.gif" /></td><td id="file_name"><a href="javascript:void(0);" title="'+comm.whir_upload_7+'"  filename="'+file.name+'">'+file.name+'</a></td><td id="persent"  nowrap>--</td><td id="file_size" nowrap>'+file_size+'</td><td id="delete" nowrap><img size="'+file.size+'" src="'+whirRootPath+'/public/upload/uploadify/del.gif" id="img" alt="'+comm.whir_delete+'" onclick="deleteUploadedFile(this,\''+select_json.dir+'\',\''+select_json.uniqueId+'\',\''+select_json.realFileNameInputId+'\',\''+select_json.saveFileNameInputId+'\',1);" /></td></tr>');

    //自适应iframe的高度
    var offset = 30;
    //iframe情况
    if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' && $('#'+realFileNameInputId).length==0 ){
        offset =45;
    }
    iframeResizeHeight_upload(uniqueId,$("#"+uniqueId).find("#filesDiv_").eq(0),offset);
}

function onUploadProgress(progress_json){
	var file = progress_json.file ;
	var uniqueId = progress_json.uniqueId ;
	$("#"+uniqueId).find("#files").find("a").each(function(){
		if($(this).attr('filename') == file.name ){
			$(this).parent().next().next().next().find("img").attr("src",whirRootPath+"/public/upload/uploadify/del.jpg");
			var persent = progress_json.percent;
			//$(this).parent().next().html(persent+"%");
			if((persent*1+0) == 100){
                //$(this).parent().next().css("color","#3F7F7F");
                //$(this).parent().next().next().next().find("img").attr("src",whirRootPath+"/public/upload/uploadify/del.gif");
			}else{
                $(this).parent().next().html(persent+"%");
            }
		}
	});
}

function onUploadSuccess(success_json){
	var file = success_json.file ;
	var uniqueId = success_json.uniqueId ;
	$("#"+uniqueId).find("#files").find("a").each(function(){
		if($(this).attr('filename') == (success_json.file_name+success_json.file_type+"")){
            var src = success_json.relative_path+success_json.save_name+success_json.file_type ;
            $(this).bind("click",function(){				
                commonSubmitDynamicForm({target:'downloadFileIfr'+uniqueId,action:preUrl+"/public/download/download.jsp?verifyCode="+success_json.dlcode+"&FileName="+success_json.save_name+success_json.file_type+"&path="+success_json.dir, params:[{'name':'name', 'value':success_json.file_name+success_json.file_type}]});//&name="+replaceAll((success_json.file_name+success_json.file_type),'&','|')+"
            });
            $(this).parent().next().next().next().find("img").eq(0).attr("id",success_json.save_name+success_json.file_type);
            $(this).parent().next().next().next().find("img").eq(0).attr("src",whirRootPath+"/public/upload/uploadify/del.gif");

            //fixed bug, see {onUploadProgress}
            $(this).parent().next().html("100%");
            $(this).parent().next().css("color","#3F7F7F");
		}
	});
	//赋值
	setFileValue(success_json.file_name+success_json.file_type, success_json.save_name+success_json.file_type, success_json.realFileNameInputId, success_json.saveFileNameInputId);	
}

/******************************************************导入文件回调函数***********************************************************************************/
function onSelect_import(select_json){
	if(whirPluploader.files.length>1){
		whirPluploader.splice(0,1);
	}
	$("#"+select_json.realFileNameInputId).val(select_json.file.name);
	$("#import_button").attr("disabled", false);
}
function onUploadSuccess_import(success_json){
	//赋值
	$("#"+success_json.saveFileNameInputId).val(success_json.save_name+success_json.file_type);
	//写入数据库	
	importFile(success_json.save_name+success_json.file_type);
}

/******************************************************人事管理回调函数***********************************************************************************/
function onUploadProgress_hrm(progress_json){
	//var persent = (progress_json.bytesUploaded*100/progress_json.bytesTotal).toFixed(0);
	$("#icon").hide();
	$("#uploadprogressbar").show();
    //$("#uploadprogressbar").progressBar(progress_json.percent,{showText: true});	
}
function onUploadSuccess_hrm(success_json){
	//$("#uploadprogressbar").hide();
	var src = success_json.relative_path+success_json.save_name+"_middle"+success_json.file_type ;
	$("#ImgShow").attr("src", src);
	//赋值
	$("#empLivingPhoto").val(success_json.save_name+success_json.file_type);
	$("#empLivingPhoto").val(success_json.save_name+success_json.file_type);
}

function init_hrm(json){
	var saveFileName = $("#empLivingPhoto").val();
	if(saveFileName!=""){
		var file_type =  saveFileName.substring(saveFileName.lastIndexOf("."),saveFileName.length);
		var save_name =  saveFileName.substring(0,saveFileName.lastIndexOf("."));
		var middle_name = save_name+"_middle"+file_type;
		$("#ImgShow").attr("src", preUrl+"/upload/peopleinfo/"+middle_name);
	}
}

function deleteUploadedFile_hrm(){
	$("#ImgShow").attr("src", whirRootPath+"/images/blank.gif");
	$("#empLivingPhoto").val("");
}

/**
 * iframe高度自适应.
 * @param iframe 	iframe对象或iframe的id.
 * @param div    	iframe内的div对象或div的id.
 * @param offset    可调节偏移量，以适应不同的页面情况，为整数.
 */
function iframeResizeHeight_upload(iframe, div, offset){
 	var Jiframe = null;
 	var Jdiv = null;
	if((typeof iframe) == "string" ){
		Jiframe = $("#"+iframe,parent.document);
	}else{
		Jiframe = $(iframe,parent.document);
	}
	if((typeof div) == "string" ){
		Jdiv = $("#"+div);
	}else{
		Jdiv = $(div);
	}
 	if(Jiframe.length>0){
  		var div_height = Jdiv[0].scrollHeight;
  		//alert(div_height);
  		//alert(document.getElementById("uniqueId1").scrollHeight);
  		//alert(document.getElementById("filesDiv_").scrollHeight);
  		//alert(document.getElementById("filesDiv").scrollHeight);
  		div_height = (div_height*1 + offset);
		Jiframe.height(div_height);
 	}
}

function initBatchDownLoad(uniqueId, dir, saveFileName, realFileName, realFileNameInputId, isEncrypt, verifyCode){
	//alert(whir_isEncrypt);
	var zipName='';
    var _d_name_arr = ["mailsubject", "BT", "information.informationTitle", "sendFileCheckTitle", "documentSendFileTitle", "receiveFileTitle", "title"];
    for(var i=0; i<_d_name_arr.length; i++){
        var _t_name = document.getElementsByName(_d_name_arr[i]).length>0?document.getElementsByName(_d_name_arr[i])[0].value:"";
        if(_t_name!=''){
            zipName = _t_name;
            break;
        }
    }
    var r_arr = realFileName.split("|");
	var s_arr = saveFileName.split("|");
    var isEncrypt_arr = isEncrypt.split(",");
    var verifyCode_arr = verifyCode.split("|");
	var downloadUrl = preUrl + "/public/download/download.jsp?";
	if(isPad()){
		downloadUrl = preUrl + "/DownloadServlet?cd=inline&isPad=true&";
	}
    if(zipName==''){
        zipName = r_arr[0];
        zipName = zipName.substring(0, zipName.lastIndexOf('.'));
    }

    zipName = zipName.replace(/#/gm, '＃').replace(/&/gm, '＆').replace(/:/gm, '：').replace(/</gm, '《').replace(/>/gm, '》').replace(/\\/gm, '﹨').replace(/\//gm, '∕').replace(/\*/gm, '﹡').replace(/\?/gm, '？').replace(/"/gm, '”');
    
    var _html = "";
    	_html+=  '	<div style="width:650px;height:320px;overflow-y:auto" >';
	    _html+=  '		<form id="_frm_'+uniqueId+'_" name="_frm_'+uniqueId+'_" action="'+preUrl+'/DownloadServlet" method="post" target="downloadFileIfr'+uniqueId+'">';
		_html+=  '				<input type="hidden" name="path" id="path"  value="'+dir+'" >';
		_html+=  '				<input type="hidden" name="downloadAll" id="downloadAll" value="1" >';
		_html+=  '				<input type="hidden" name="zipName" id="zipName" value="'+zipName+'.zip" >';
		_html+=  '				<input type="hidden" name="FileName" id="FileName">';
		_html+=  '				<input type="hidden" name="name" id="name" >';
		_html+=  '				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable" >';
		_html+=  '					<tr class="listTableLine1" style="height:20px;line-height:20px;" >';
		_html+=  '						<td width="2%" >';
		_html+=  '							<input type="checkbox" name="_chk_file_all_"  checked onclick="setCheckBoxState(\'_chk_file_\',this.checked);" >';
		_html+=  '						</td>';
		_html+=  '						<td  align="center" class="listTableLineLastTD" >'+comm.whir_upload_10+'</td>';
		_html+=  '					</tr>';
    for(var i=0;i<r_arr.length;i++){
        if(isPad()){
            downloadUrl += "encrypt="+isEncrypt_arr[i]+"&";
        }
        _html+= 					'<tr class="listTableLine1" >';
        _html+= 						'<td>';
        _html+= 							'<input type="checkbox" name="_chk_file_"            value="'+s_arr[i]+'" checked>';
        _html+= 							'<input type="hidden"   name="_chk_file_val_"        value="'+r_arr[i]+'">';
        _html+= 							'<input type="hidden"   name="_chk_file_isEncrypt_"  value="'+isEncrypt_arr[i]+'">';//whir_isEncrypt
        _html+= 						'</td>';
        _html+= 						'<td class="listTableLineLastTD" >&nbsp;';
        _html+= 							'<a href="javascript:void(0);" onclick="singleDownload(\''+uniqueId+'\', \''+downloadUrl+'\',\''+verifyCode_arr[i]+'\', \''+s_arr[i]+'\', \''+r_arr[i].replaceAll_("'","\\'")+'\', \''+dir+'\');" title="'+comm.whir_upload_7+'" >'+r_arr[i]+'</a>';
        _html+= 						'</td>';
        _html+= 					'</tr>';            
    }
		_html+=  '				</table>';
		_html+=  '		</form>';
    	_html+=  '	</div>';

	window.parent.popup({
		id:'batchDownLoad',
		content:_html,
		title:comm.whir_upload_11,
		width:650,
		height:350,
		resize:false,
		lock:true,
		max:false,
		min:false,
		button: [ 
			{ 
				id:'valueOk', 
				name:comm.whir_upload_12, 
				focus: true,
				callback:function(){
					//$("#"+uniqueId).get(1).contentWindow.batchDownLoad(uniqueId);
					batchDownLoad(uniqueId);
					return false; 
				}
			},
			{ 
                name: comm.cancel 
			} 
		]
	});
}

function singleDownload(uniqueId, server, dlcode, fileName, name, dir){
	//信息管理中记录下载附件次数
	if(dir=="information"){
		var informationId = $("#informationId").val();
		$.ajax({
			type: 'POST',
			url: whirRootPath+'/Information!download.action?informationId='+informationId+'&fileName='+fileName,
			async: false,
			dataType: 'text',
			success: function(data){
				if(data!=null && data=='-1'){
					whir_alert("下载次数已达上限！",null);
				}else if(data!=null && data=='0'){
					whir_alert("您没有下载权限！",null);
				}else{
					commonSubmitDynamicForm({target:'downloadFileIfr'+uniqueId,action:server+'verifyCode='+dlcode+'&FileName='+fileName+'&path='+dir, params:[{'name':'name', 'value':name}]});
				}
			}
		});
	}else{
		commonSubmitDynamicForm({target:'downloadFileIfr'+uniqueId,action:server+'verifyCode='+dlcode+'&FileName='+fileName+'&path='+dir, params:[{'name':'name', 'value':name}]});
	}
}

function batchDownLoad(uniqueId){
	 var _fn = "";
     var _sn = "";
	 var files = "";
     var frm = $('#_frm_'+uniqueId+'_');
     if(self.frameElement!=null && self.frameElement.tagName=="IFRAME" && self.frameElement.name!='mainFrame' ){
		 frm = $('#_frm_'+uniqueId+'_',window.parent.document);
	 }
     $(frm).find('#FileName').val('');
     $(frm).find('#name').val('');
	
     $(frm).find('input[name="_chk_file_"]').each(function(i){
         if($(this).prop("checked")===true){
             _fn += $(this).attr("value") + "," + $(this).next().next().val() + "|";
             _sn += $(this).next().val() + "|";
			 files += $(this).attr("value") + "|";
         }
     });
	
    if(_fn==''){
        whir_alert(comm.whir_upload_13,null);
        return false;
    }

     $(frm).find('#FileName').val(_fn);
     $(frm).find('#name').val(_sn);
     //信息管理中记录下载附件次数
	 var path = $(frm).find('#path').val();
	 if(path=='information'){
		 var informationId = window.parent.$("#informationId").val();
		 $.ajax({
			 type: 'POST',
			 url: whirRootPath+'/Information!download.action?informationId='+informationId+'&fileName='+files,
			 async: false,
			 dataType: 'text',
			 success: function(data){
				 if(data!=null && data=='-1'){
					 whir_alert("下载次数已达上限！",null);
				 }else if(data!=null && data=='0'){
					 whir_alert("您没有下载权限！",null);
				 }else{
					 jQuery(frm).submit();
				 }
			 }
		 });
	 }else{
		 jQuery(frm).submit();
	 }
     window.parent.lhgdialog.list['batchDownLoad'].close();
}