var PORTLET_LAZY_TIME = 0;
var PORTAL_CACHE = true;
var PORTAL_PATH = whirRootPath;

var PORTLET_DEFAULT_HEIGHT = "auto";
var PORTLET_UPDATING = "更新中...";

var DEFAULT_COLOR = {"themes/2011/green":"#1E6C00","themes/2011/blue":"#0F6CBB","themes/2011/orange":"#E55600","themes/2011/gray":"#2B5672","themes/2007/blue":"#1D5BC8","themes/2009/blue":"#0F6CBB","themes/2012/blue":"#42B6EF","themes/2012/green":"#52B600","themes/metro/blue":"#FFF","themes/metro/green":"#FFF","themes/department/default/blue":"#FFFFFF","themes/department/default/green":"#52B600","themes/2013/blue":"#555555","themes/2013/green":"#555555","themes/2013/red":"#555555","themes/2013/lightblue":"#555555"};

var reLiWidth = true;
var asyncArr = [];
var Portlet = {
	DEL_MSG: '确认删除吗？',
	updating: function(target){
        //content_pid
		var pid = $(target).attr('id').substr(8);
        //$('#'+pid+'_span_h').html(PORTLET_UPDATING);
	},
	setPortletTitle: function(target, title){
        //content_pid
		var pid = $(target).attr('id').substr(8);
        //$('#'+pid+'_span_h').html(title);
	},
    setPortletDataTitle: function(portletSettingId, jsonData){
        var dataLen = jsonData && jsonData[0].data ? jsonData[0].data.length : 0;

        var hObj = $("#header_portletSettingId_"+portletSettingId);
        var _title = hObj.attr('data-title');
        var _color = hObj.attr('data-color');
        var _iconFont = hObj.attr('data-iconFont');
        var _hasTitle = hObj.attr('data-hasTitle');
        var _hastoolbar = hObj.attr('data-toolbar');
        if(dataLen == 0) {//默认标题
            jsonData = [
                {
                    ulCss: "",
                    data: [
                        { title: _title, url:'', onclick:'', defaultSelected: 'on', liCss:'', titleColor: _color, morelink: '' }
                    ]
                }
            ];
        }

        //用于生成多个页签
        var titleTemplate = "";
        var linum = 0;
        if(jsonData.length > 0){
            var _jd = jsonData[0];
            titleTemplate += '<ul id="ul_'+portletSettingId+'" class="wh-portal-i-title-left '+_jd.ulCss+' clearfix">';
            var _items = _jd.data;
            for(var i=0, j=_items.length; i<j; i++){
                var _item = _items[i];
                if(_item){
                    var _title = _item.title?_item.title:"";
                    if(_title.length > 5){
                        _title = _title.substring(0, 5) + "...";
                    }
                    titleTemplate += '    <li pid="'+portletSettingId+'" class="wh-portal-title-li '+(_item.liCss?_item.liCss:'')+' '+(_item.defaultSelected?_item.defaultSelected:'')+'" morelink="'+(_item.morelink?_item.morelink:'')+'"><a href="javascript:void(0);" style="color:'+_color+'" title="'+_item.title+'">'+(i==0 && _iconFont && _iconFont != undefined && _iconFont != 'undefined' && _iconFont != ""?'<i class="fa ' + _iconFont+'" id="i_portletSettingId_'+portletSettingId+'"></i>':'')+_title+'</a></li>';
                    linum++;
                }
            }
            titleTemplate += '</ul>';
        }

        hObj.html('');

        $(titleTemplate).appendTo(hObj);

        //更新主标题
        if(dataLen > 0){
            hObj.append('<h3 id="h_portletSettingId_'+portletSettingId+'" '+(reLiWidth?' style="right:20px;"':'')+'><a href="javascript:void(0);" id="mt_portletSettingId_'+portletSettingId+'" style="color:'+_color+'">'+hObj.attr('data-title')+'</a></h3>');
        }

        if(_hasTitle != '1'){
            $('#h_portletSettingId_'+portletSettingId).hide();
            if(_hasTitle != '1' && _hastoolbar != '1'){
                $('#header_portletSettingId_'+portletSettingId).show();
            }
        }

        //用于计算多页签宽度
        $('#ul_'+portletSettingId).attr("data-linum", linum);
        //重新计算li宽度
        //resizeTabUlLiWidth(portletSettingId);
	},
    setMoreLink: function(portletSettingId, opts){
        //var opts = {click: ''};//test data
		var _topHref = top.location.href;
		if(_topHref.indexOf("information_department/department_index.jsp")!=-1){//因框架原因，单位主页隐藏more
			 $('#more_portletSettingId_'+portletSettingId).hide();
			return;
		}
        var _toolbar = $("#header_portletSettingId_"+portletSettingId).attr('data-toolbar');
        if(_toolbar == '1'){
            $('#more_portletSettingId_'+portletSettingId).show();
            var _morelink = $('#ul_'+portletSettingId+' li:eq(0)').attr('morelink');
            if(opts.click == undefined && _morelink){
                opts.click = _morelink;
            }
            if(opts.click){
                $('#more_portletSettingId_'+portletSettingId).unbind('click');
                $('#more_portletSettingId_'+portletSettingId).bind('click', function(){
                    eval(opts.click);
                    return false;
                });
            }
            $('#h_portletSettingId_'+portletSettingId).css({right:'60px'});
        }
    },
    setOtherLink: function(portletSettingId, opts){
        //var opts = {id: 'other', name: 'Test', fa: 'fa-more', click: 'alert(1);', position: 'after'};//test data
        if($('#'+opts.id+'_portletSettingId_'+portletSettingId).attr('id'))return;
        var _html = '<i id="'+opts.id+'_portletSettingId_'+portletSettingId+'" title="'+opts.name+'" class="fa '+opts.fa+' fa-color" onclick="'+opts.click+'"></i>';
        var _target = $('#tools_portletSettingId_'+portletSettingId);
        if(opts.position == 'after'){
            _target.append(_html);
        }else{
            _target.prepend(_html);
        }
    },
	addPortlet: function(opts){
		var portletSettingId = opts.portletSettingId;
		var pid = 'portletSettingId_'+portletSettingId;
		var title = opts.title;
		var layoutId = opts.layoutId;
		var portletId = opts.portletId;
		var type = opts.type;
		var iconCls = opts.iconCls;
		var height = opts.height?opts.height:PORTLET_DEFAULT_HEIGHT;
		var flag = opts.flag;

		var fn = eval(type);
        if($.browser.msie){
			var ver = $.browser.version;
			if(ver <= 8.0){
				/*if(PORTLET_LAZY_TIME > 0){
					if(opts.portletIndex){
						setTimeout(function(){fn.refresh($('#content_'+pid), opts);}, opts.portletIndex*PORTLET_LAZY_TIME+50);
					}else{
						fn.refresh($('#content_'+pid), opts);
					}
				}else{
					fn.refresh($('#content_'+pid), opts);
				}*/
				//asyncArr.push(function(){fn.refresh($('#content_'+pid), opts);});
				asyncArr[portletSettingId]=function(){fn.refresh($('#content_'+pid), opts);};
			}else{
				fn.refresh($('#content_'+pid), opts);
			}            
        }else{
            fn.refresh($('#content_'+pid), opts);
        }

        //$('#'+pid+'_span_h').html(title);

        try{
            parseInt(height, 10);
            height = height + 'px';
        }catch(e){
            height = PORTLET_DEFAULT_HEIGHT;
        }

        $('#content_'+pid).css('height', height);

		var titleColor = opts.titleColor?opts.titleColor:"";
		var contentBgColor = opts.contentBgColor?opts.contentBgColor:"";

        //$('#'+pid+'_h').css('color', DEFAULT_COLOR[PORTAL_SKIN]);
		if(titleColor!=''){
            $('#t_'+pid).css('color', titleColor);
		}

		if(contentBgColor!=''){
			//$('#contents_'+pid).css('background',contentBgColor);
			$('#content_'+pid).css('background',contentBgColor);
		}

        if(opts.hasTitle!='1'){
            //$('#header_'+pid).hide();
            $('#header_'+pid).children().hide();
        }

        if(opts.hasToolbar!='1'){            
            $('#refresh_'+pid).hide();
            $('#more_'+pid).hide();
        }

        if(opts.hasTitle!='1' && opts.hasToolbar!='1'){//
            $('#header_'+pid).hide();
        }

        if(opts.hasBorder!='1'){
            $('#'+pid).addClass('wh-portal-noborder');
        }else{
            if(opts.hasTitle!='1'){
                //
            }
        }

		setIconCls(pid, opts);

        $('#refresh_'+pid).bind('click', function(){
			fn.refresh($('#content_'+pid), opts);
		});

		return null;
	},
	getCommonOpts: function(ps, opts){
		var title = $(ps).find('title:first').text();
		var contentBgColor = $(ps).find('contentBgColor:first').text();
		var titleColor = $(ps).find('titleColor:first').text();

		var hasTitle = $(ps).find('hasTitle:first').text();
		var hasToolbar = $(ps).find('hasToolbar:first').text();
		var hasBorder = $(ps).find('hasBorder:first').text();

		var iconCls = opts.iconCls;
		var _iconCls = $(ps).find('iconCls:first').text();
		if(_iconCls!=''){
			iconCls = _iconCls;
		}

        var iconFont = opts.iconFont;
		var _iconFont = $(ps).find('iconFont:first').text();
		if(_iconFont!=''){
			iconFont = _iconFont;
		}

		var height = $(ps).find('windowHeight:first').text();

		opts = $.extend(opts, {title:title, titleColor:titleColor, contentBgColor:contentBgColor, iconCls:iconCls, iconFont:iconFont, height:height, hasTitle:hasTitle, hasToolbar:hasToolbar, hasBorder:hasBorder});

		return opts;
	}
};

//重新计算li宽度
function resizeTabUlLiWidth(pid){
    var linum = $("#ul_"+pid).data('linum');
    if(linum){
        var _linum = parseInt(linum, 10);
        if(_linum > 0){
            var tabLiDom = $('#ul_'+pid+' li');
            var tabLiWidth = 100 / _linum +"%"; //计算页签个数取整;
            tabLiDom.css({'width':tabLiWidth});
            
            if(_linum == 2){
                tabLiDom.css({width:"96px"});
            }
            if(_linum == 1){
                tabLiDom.css({width:"auto"});
            }
        }
    }
}

function setPortletSettingStyle(portletSettingId, portletOptions, lazyTime){
    var pid = 'portletSettingId_'+portletSettingId;
    var opts = portletOptions.opts;
    var type = opts.type;

    var fn = eval(type);
    fn.portletAdd(opts);

    if(type == 'userinfo'){//个人卡片
        $('#'+pid).addClass('wh-portal-nopadding wh-portal-nohidden');
        $('#'+pid).css({'z-index':102});//fixed
    }else if(type == 'microblog'){
        $('#'+pid).addClass('wh-portal-noscroll');
    }else if(type == 'html'){
        $('#'+pid).addClass('wh-portal-html');
    }
}

function setIconCls(pid, opts){
    //
    /*
    var result = ajaxResponseXML(opts.portletSettingId);
    if($('portletSettings', result).length > 0){
        var ps = $('portletSettings', result).eq(0);
        opts.iconFont = $(ps).find('iconFont:first').text();
    }
    */

    var cls = '';
    if(opts.iconFont != '') cls = 'fa ' + opts.iconFont;
    if(cls == ''){
        $('#i_'+pid).removeClass();
    }else{
        $('#i_'+pid).addClass(cls);
    }
}

function ajaxResponseXML(portletSettingId){
    var _xml_ = eval('portletOptions'+portletSettingId).xml;
    var xmldom=null 
    if(navigator.userAgent.toLowerCase().indexOf("msie")!=-1){ 
        xmldom=new ActiveXObject("Microsoft.XMLDOM"); 
        xmldom.loadXML(_xml_); 
    } else {
        xmldom=new DOMParser().parseFromString(_xml_,"text/xml");
    }
    _xml_ = null;
    return xmldom;
}

function loadScriptLazy(url, callback) {
    var script = document.creatElement("script");
    script.type = "text/javascript";
    if (script.readyState) { //IE
        script.onreadystatechange = function () {
            if (script.readyState == "loaded" || script.readyState == "complete") {
                script.onreadystatechange = null;
                callback();
            }
        };

    } else { //其他浏览器
        script.onload = function () {
            callback();
        };
    }
    script.src = url;
    document.getElementsByTagName_r("head")[0].appendChild(script);
}

function showHide(obj, pid, type) {
	//window.event.cancelBubble = true;
	var moduleContents = $(obj).parent().parent().find('.wh-portal-i-content');//$(obj).parent().parent().siblings('.wh-portal-i-content');
	if(moduleContents){
		if(moduleContents.css('display')=='none'){
			moduleContents.css('display','block');
            $('#mm_'+pid).removeClass('fa-plus').addClass('fa-minus');
			$(obj).attr("title", "闭合");

            if(type=='microblog'){
                //$('#refresh_'+pid).click();
            }
		}else{
			moduleContents.css('display','none');
            $('#mm_'+pid).removeClass('fa-minus').addClass('fa-plus');
			$(obj).attr("title", "展开");
		}
	}
}

//局部刷新portlet
function refreshPortlet(portletSettingId){
    setTimeout(function(){$('#refresh_portletSettingId_'+portletSettingId).click();}, 1000);
}

function refreshMod(type, portletSettingId){
    //防止以前页面出错
    refreshPortlet(portletSettingId);
}

function gotoPortletURL(obj, opts){//alert(21);
    if(_def_isDesignPage_)return;

    var _lefturl = opts.lefturl;
    var _righturl = opts.righturl;
    var _winname = opts.winname;
    var _wintype = opts.wintype;//0-location.href 1-window.open
    if(_wintype=='0'){
        //location.href=whirRootPath+'/platform/portal/more.jsp?left='+_lefturl+'&right='+_righturl;
        jumpnew(_lefturl, _righturl);
    }else if(_wintype=='1'){
        //弹出窗口
		openWin({url:encodeURI(_lefturl),winName:_winname,isFull:true})

        //window.open(encodeURI(_lefturl), _winname, 'TOP=0,LEFT=0,toolbar=no,location=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=800,height=600')
    }
}

function hidenMsg(){
    if(document.getElementById('startMsg')){
	    document.getElementById('startMsg').style.display='none';
    }
    document.getElementById('portalMainDiv').style.display='';
}

function showPortlet(){
	hidenMsg();

	runAsync();
}

function runAsync(){
	if($.browser.msie){
		var ver = $.browser.version;
		if(ver <= 8.0){
			for(var i=0, len=_portlets_arr.length; i<len; i++){
				if(i>2 && i%3!=0){
					setTimeout(asyncArr[_portlets_arr[i]], 350+i*50);
				}else{
					asyncArr[_portlets_arr[i]]();
				}
			}
		}
	}
}