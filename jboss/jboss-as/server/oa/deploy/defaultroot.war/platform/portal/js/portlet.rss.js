/*-------------------------------------------------------*/
//RSS站点
/*-------------------------------------------------------*/
/*--------------------portlet---------start--------------*/
var rss = {
	portletAdd: function(opts){
		var portletSettingId = opts.portletSettingId;
		var isNew = opts.isNew?opts.isNew:false;
		if(!isNew){
			var result = ajaxResponseXML(portletSettingId);
			if($('portletSettings', result).length > 0){
				var ps = $('portletSettings', result).eq(0);
				opts = Portlet.getCommonOpts(ps, opts);

				var rssSource = $(ps).find('rssSource:first').text();
				var limitNum = $(ps).find('limitNum:first').text();
				var limitChar = $(ps).find('limitChar:first').text();
				var charEncode = $(ps).find('charEncode:first').text();				
				
				opts = $.extend(opts, {rssSource:rssSource, limitNum:limitNum, limitChar:limitChar, charEncode:charEncode});
			}
		}

		var p = Portlet.addPortlet(opts);

		return p;
	},
	refresh: function(target, opts){
		var data = '';//'http://news.baidu.com/n?cmd=1&class=civilnews&tn=rss&sub=0';
		if(opts.rssSource){
			data = opts.rssSource;
			data = data.substring(0, data.length-1);
		}
		if(data!=''){
			Portlet.updating(target);

			var datas = data.split(",");
			var limitNum = 5;
			var limitChar = -1;
			if(opts.limitNum!=''&&!isNaN(opts.limitNum)){
				limitNum = parseInt(opts.limitNum);
			}
			if(opts.limitChar!=''&&!isNaN(opts.limitChar)){
				limitChar = parseInt(opts.limitChar);
			}

			var charEncode = opts.charEncode;
			var htmlContent = '<div class="wh-portal-info-content"><div class="wh-portal-slide04-'+opts.portletSettingId+'"><ul class="clearfix">';
			var titleTop="";
			for(var j=0;j<datas.length;j++){
				$.getFeed({
					url: whirRootPath+"/platform/portal/portlet/rssproxy.jsp?rssUrl="+datas[j].replace(/&/igm, '%26')+"&charEncode="+charEncode,//data,//
					async: false,
					success: function(feed) {//alert(feed);
						titleTop += feed.title+",";
						if(j==0){
							htmlContent+='<li>';
						}else{
							htmlContent+='<li class="wh-portal-hidden">';
						}
						for(var i = 0; i < feed.items.length && i < limitNum; i++) {
							var item = feed.items[i];
							var _title = $.trim(item.title);
							if(limitChar!=-1){
								_title = _title.replace(/\"/g,"&quot;");
								_title = (_title.length>limitChar)?(_title.substring(0, limitChar)+'...'):_title;
							}
							
							htmlContent += '<div class="wh-portal-i-item clearfix">'+
										'<a href="javascript:void(0)" title="'+item.title+'" onclick="javascript:openWin({url:\''+item.link+'\',isFull:true,isPost:false})">'+
										'<i class="fa fa-file-o"></i>'+
										'<span>'+_title+'</span>'+
										'</a>'+
										'</div>';
						}
						htmlContent+='</li>';
					}
				});
			}
			
			htmlContent += '</ul></div></div>';
			target.html(htmlContent);
			Portlet.setPortletTitle(target, opts.title);
			
			titleTop = titleTop.substring(0,titleTop.length-1);
			var top = titleTop.split(",");
			var datas=new Array();
			for(var i=0;i<top.length;i++){
				if(top[i]!=null && top[i]!=""){
					top[i] = $.trim(top[i]);
					datas[i]={title:top[i],url:'#',onclick:'',defaultSelected:i==0?"on":"",liCss:''};
				}
			}
			var jsonData=[{
				ulCss:"wh-portal-title-slide04-"+opts.portletSettingId,
				data:datas
			}];
			Portlet.setPortletDataTitle(opts.portletSettingId,jsonData);
			
			slideTab("slide04-"+opts.portletSettingId);
		}
	},
	getSettingsXml: function(target, opts){
		var result = "";

		var rssSource ='';
		$('input[name=rssSource]').each(function(){
			var val = $(this).val();
			if(val!=null && val!=""){
				val = val.replace(/\&/g, "%26" );
				rssSource += val + ',';
			}
		});
		result += '<rssSource>'+rssSource+'</rssSource>';
		
		var limitChar = $('input[name=limitChar]').val();
		result += '<limitChar>'+limitChar+'</limitChar>';
		var limitNum = $('input[name=limitNum]').val();
		result += '<limitNum>'+limitNum+'</limitNum>';

		var charEncode = $('input[name=charEncode]:checked').val();
		result += '<charEncode>'+charEncode+'</charEncode>';

		opts = $.extend(opts, {rssSource:rssSource, limitChar:limitChar, limitNum:limitNum, charEncode:charEncode});

		return result;
	}
};
/*--------------------portlet---------end--------------*/