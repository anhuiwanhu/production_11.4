// 无需下载附件类型
var allFileType = "";
// IOS客户端可预览附件类型
var iosOpenFileType = ".doc.ppt.docx.pptx.jpg.png.gif.jpeg.pdf.txt.xls.xlsx";
// ANDROID客户端可预览附件类型
var androidFileType = ".doc.docx.xls.xlsx.txt.jpg.png.gif.jpeg.pptx.ppt.pdf";
/**
*
*  Base64 encode / decode
*
*  @author haitao.tu
*  @date   2010-04-26
*  @email  tuhaitao@foxmail.com
*
*/
 
function Base64() {
 
	// private property
	_keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
 
	// public method for encoding
	this.encode = function (input) {
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;
		input = _utf8_encode(input);
		while (i < input.length) {
			chr1 = input.charCodeAt(i++);
			chr2 = input.charCodeAt(i++);
			chr3 = input.charCodeAt(i++);
			enc1 = chr1 >> 2;
			enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
			enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
			enc4 = chr3 & 63;
			if (isNaN(chr2)) {
				enc3 = enc4 = 64;
			} else if (isNaN(chr3)) {
				enc4 = 64;
			}
			output = output +
			_keyStr.charAt(enc1) + _keyStr.charAt(enc2) +
			_keyStr.charAt(enc3) + _keyStr.charAt(enc4);
		}
		return output;
	}
 
	// public method for decoding
	this.decode = function (input) {
		var output = "";
		var chr1, chr2, chr3;
		var enc1, enc2, enc3, enc4;
		var i = 0;
		input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");
		while (i < input.length) {
			enc1 = _keyStr.indexOf(input.charAt(i++));
			enc2 = _keyStr.indexOf(input.charAt(i++));
			enc3 = _keyStr.indexOf(input.charAt(i++));
			enc4 = _keyStr.indexOf(input.charAt(i++));
			chr1 = (enc1 << 2) | (enc2 >> 4);
			chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
			chr3 = ((enc3 & 3) << 6) | enc4;
			output = output + String.fromCharCode(chr1);
			if (enc3 != 64) {
				output = output + String.fromCharCode(chr2);
			}
			if (enc4 != 64) {
				output = output + String.fromCharCode(chr3);
			}
		}
		output = _utf8_decode(output);
		return output;
	}
 
	// private method for UTF-8 encoding
	_utf8_encode = function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
		for (var n = 0; n < string.length; n++) {
			var c = string.charCodeAt(n);
			if (c < 128) {
				utftext += String.fromCharCode(c);
			} else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			} else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
		return utftext;
	}
 
	// private method for UTF-8 decoding
	_utf8_decode = function (utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
		while ( i < utftext.length ) {
			c = utftext.charCodeAt(i);
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			} else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			} else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
		}
		return string;
	}
}
$(function(){
	var sw = $(window).width();
	var sh = $(window).height();
	$('body').append("<div id='subBg' style='position:fixed; left:0; top:0; background:rgba(0,0,0,0.8);z-index:9999; cursor:default;width:100%;height:100%;display:none;'><p style='text-align:center; color:#fff;font-size:16px;font-family:microsoft yahei; display:block;line-height:2em;padding-top:70px;background:url(/defaultroot/evo/weixin/images/subDot.png) no-repeat right center;'>非常抱歉，由于微信不支持直接打开该类型文件，请点击此处，并选择在浏览器中打开</p></div>");
	$('#subBg').width(sw);
	$('#subBg').height(sh);
	$('.active').mousedown(function(){
		$(this).css('background','#f5f5f5');
	})
	$('.active').mouseup(function(){
		$(this).css('background','');
	})
})

//判断是否微信
function is_weixin(){
	var ua = navigator.userAgent.toLowerCase();
	if(ua.match(/MicroMessenger/i)=="micromessenger") {
		return true;
 	} else {
		return false;
	}
}

//点击下载附件
function clickSub_backup(url,event){
	if(!is_weixin()){
		var b = new Base64();   
		//  alert(url);
          
		var str = b.encode(url);   
		//return;

		//window.open("/defaultroot/evo/weixin/common/download.jsp?url="+str);
		window.open(url);
		return;
	}
	var fileType = "";
	var fileName = $(event).html();
	if(fileName){
		fileType = fileName.substr(fileName.lastIndexOf(".")).replace(/<[^>]+>/g,'');
	}
	if(allFileType.indexOf(fileType)==0){
		window.open(url);
		return;
	}
	$('#subBg').show();
	$('#subBg').click(function(){
		$(this).hide();
	})
}

//点击下载附件
function clickSub(url,obj,saveFileName,moduleName,smartInUse,isYzOffice){
	
	// 非微信环境直接下载（可禁用）
	if(!is_weixin()){
		window.open(url);
		return;
	}
	// 获取文件类型
	var fileType = "";
	var fileName = $(obj).find('strong').text().trim();
	if(fileName){
		fileType = fileName.substr(fileName.lastIndexOf(".")).replace(/<[^>]+>/g,'').toLowerCase();
	}
	// 全客户端支持打开文件类型 
	/*
		if(allFileType.indexOf(fileType) != -1){
			window.open(url);
			return;
		}
	*/
	// 是否需要打开 点击浏览器提示页面标识
	var isOpenTip = true;
	// 判断客户端环境是否为ios
	var userAgent = navigator.userAgent.toLowerCase();
	if(!((userAgent.indexOf("android") != -1) || (
		(userAgent.indexOf("linux") != -1) && (((userAgent.indexOf("chrome") != -1) || (userAgent.indexOf("safari") != -1)))))){
		if(iosOpenFileType.indexOf(fileType) != -1){
			window.open(url);
			return;
		}
	}else{
		// 暂时支持http上传方式的文件读取
		//if(smartInUse != '0'){
			// android客户端环境
			if(androidFileType.indexOf(fileType) != -1){
				isOpenTip = false;
				if(fileType.toLowerCase() == '.doc' || fileType.toLowerCase() == '.docx'){
					$.ajax({
						url : '/defaultroot/convertFile/doc2Html.controller',
						type : 'post',
						data : {'saveFileName': saveFileName, 'moduleName' : moduleName,'url': url},
						success : function(data){
							if(data){
								var jsonData = eval('('+data+')');
								var result = jsonData.result;
								if('success' == result){
									if(jsonData.data0){
										window.open(jsonData.data0);
									}else{
										alert('打开文件失败，请尝试使用浏览器打开下载！');
									}
								}else if('fail' == result){
									alert(jsonData.data0);
								}else{
									alert('打开文件失败，请尝试使用浏览器打开下载！');
								}
							}
						},
						error : function(){
							dialog.close();
							alert('打开文件失败，请尝试使用浏览器打开下载！');
						}
					});
				}else if(fileType.toLowerCase() == '.xls' || fileType.toLowerCase() == '.xlsx'){
					window.open('/defaultroot/convertFile/xls2Html.controller?saveFileName='+saveFileName+'&moduleName='+moduleName);
				}else if(fileType.toLowerCase() == '.ppt' || fileType.toLowerCase() == '.pptx' || fileType.toLowerCase() == '.pdf'){
					window.open('/defaultroot/evo/weixin/common/ppt_img.jsp?saveFileName='+saveFileName+'&moduleName='+moduleName);
				}else if(fileType.toLowerCase() == '.txt'){
					window.open('/defaultroot/convertFile/text2Html.controller?saveFileName='+saveFileName+'&moduleName='+moduleName);
				}else if(fileType.toLowerCase() == '.png' || fileType.toLowerCase() == '.jpg' || fileType.toLowerCase() == '.gif'
					|| fileType.toLowerCase() == '.jpeg'){
					window.open('/defaultroot/evo/weixin/common/img_view.jsp?saveFileName='+saveFileName+'&moduleName='+moduleName);
				}
			}
		//}
	}
	// 显示打开浏览器提示
	if(isOpenTip){
		$('#subBg').show();
		$('#subBg').click(function(){
			$(this).hide();
		});
	}
}

function clickSubyz(url,obj,saveFileName,moduleName,smartInUse,isYzOffice){
	var dialog = $.dialog({
		content:"正在打开，请稍候...",
		title : "ok"
	});
	var fileType = saveFileName.substr(saveFileName.lastIndexOf(".")).replace(/<[^>]+>/g,'').toLowerCase();
	if(fileType.toLowerCase() != '.xls' && fileType.toLowerCase() != '.xlsx'
			&& fileType.toLowerCase() != '.doc' && fileType.toLowerCase() != '.docx' 
			&& fileType.toLowerCase() != '.ppt' && fileType.toLowerCase() != '.pptx' 
			&& fileType.toLowerCase() != '.rtf' && fileType.toLowerCase() != '.eio'
			&& fileType.toLowerCase() != '.pdf' && fileType.toLowerCase() != '.xml'
			&& fileType.toLowerCase() != '.txt' && fileType.toLowerCase() != '.zip'
			&& fileType.toLowerCase() != '.rar' && fileType.toLowerCase() != '.jpg'
			&& fileType.toLowerCase() != '.png' && fileType.toLowerCase() != '.gif'
			&& fileType.toLowerCase() != '.jpeg' && fileType.toLowerCase() != '.bmp'){
		//timeout = true;
		dialog.close();
		alert("该类型不支持预览，请于电脑端查看！");
		return;
		
	}
	
	if(isYzOffice != '1' && (fileType.toLowerCase() == '.rar' || fileType.toLowerCase() == '.zip' || fileType.toLowerCase() == '.xml')){
		//timeout = true;
		dialog.close();
		alert("该类型不支持预览，请于电脑端查看！");
		return;
	}
	
	if(fileType.toLowerCase() == '.jpg' || fileType.toLowerCase() == '.png' || fileType.toLowerCase() == '.gif' || 
			fileType.toLowerCase() == '.jpeg' || fileType.toLowerCase() == '.bmp'){
			dialog.close();
			window.open('/defaultroot/evo/weixin/common/img_view.jsp?saveFileName='+saveFileName+'&moduleName='+moduleName);
			return;
	}
	
	if(isYzOffice == 1){
		$.ajax({
			url : '/defaultroot/yzConvertFile/file2Html.controller',
			type : 'post',
			dataType:'text',
			data : {'fileName': saveFileName, 'path' : moduleName,'url': url, 'isEncrypt' :'0'},
			success : function(data){
				dialog.close();
			var jsonData = eval("("+data+")");
		 	if(jsonData.result == '0'){
		 		window.location = jsonData.data;
		 	}else if(jsonData.result == '3'){
		 		alert("指定文件不存在！");
		 	}else{
		 		alert(jsonData.message);
		 	}
				
			},
			error : function(){
				dialog.close();
				//dialog.close();
				alert('打开文件失败，请尝试使用浏览器打开下载！');
			}
		});
	}else{
		var userAgent = navigator.userAgent.toLowerCase();
		if(!((userAgent.indexOf("android") != -1) || (
			(userAgent.indexOf("linux") != -1) && (((userAgent.indexOf("chrome") != -1) || (userAgent.indexOf("safari") != -1))))) && fileType.toLowerCase() =='.pdf'){
			if(iosOpenFileType.indexOf(fileType) != -1){
				window.location.href=url;
				return;
			}
		}else{
			if(fileType.toLowerCase() == '.pdf' ){
				window.open('/defaultroot/evo/weixin/common/ppt_img.jsp?saveFileName='+saveFileName+'&moduleName='+moduleName);
			}else{
				$.ajax({
					url : '/defaultroot/yzConvertFile/fileView.controller',
					type : 'post',
					dataType:'text',
					data : {'fileName': saveFileName, 'path' : moduleName,'url': url, 'isEncrypt' :'0'},
					success : function(data){
						dialog.close();
						var jsonData = eval("("+data+")");
						window.location.href=jsonData.data0;
					},
					error : function(){
						dialog.close();
						//dialog.close();
						alert('打开文件失败，请尝试使用浏览器打开下载！');
					}
				});
			}
		}
	}
}





  
