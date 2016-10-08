<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.org.bd.organizationmanager.OrganizationBD"%>
<%
PortalLayoutBD bd     = new PortalLayoutBD();
String _skin          = EncryptUtil.htmlcode(request,"skin");//request.getParameter("skin")!=null?request.getParameter("skin"):whir_skin;
_skin                 = _skin!=null && !"".equals(_skin) ? _skin : whir_skin;
String layoutId       = request.getParameter("layoutId");
String secMd5         = new com.whir.common.util.MD5().toMD5("net.whir"+layoutId);
String sec            = request.getParameter("sec");
String sessionId      = request.getParameter("v1.0");
boolean isSameSession = session!=null?session.getId().equals(sessionId):false;
String orgId          = request.getParameter("orgId")!=null?request.getParameter("orgId"):"";
if(!"".equals(orgId)){
	OrganizationBD orgbd = new OrganizationBD();
    String orgStyle = orgbd.getOrgStyle(orgId);
	String style = orgStyle!=null && !"".equals(orgStyle)?orgStyle:"default/blue";
	whir_skin = "themes/department/"+style;
}
if(!isSameSession && !secMd5.equals(sec)){
%>
location.href="about:blank";
<%
}
if(isSameSession || secMd5.equals(sec)){
%>

var PORTAL_CACHE = true;
var PORTAL_PATH = whirRootPath;
var PORTAL_SKIN = "<%=_skin%>";
<%if("0".equals(request.getParameter("preview"))){%>
    //PORTAL_SKIN = "themes/2012/blue";
<%}%>

var PORTLET_SETTING_SAVE_XML = PORTAL_PATH+"/platform/portal/layout/common/getPortletSettingsXml.jsp";

<%if(isSameSession){%>
var PORTLET_ADD_URL = PORTAL_PATH+"/platform/portal/layout/common/portletAdd.jsp";
var PORTLET_DELETE = PORTAL_PATH+"/platform/portal/layout/common/portletDelete.jsp";
var PORTLET_SETTING_URL = PORTAL_PATH+"/platform/portal/layout/common/portletSetting113.jsp";
var PORTLET_SETTING_SAVE_URL = PORTAL_PATH+"/PortalServlet";
var LAYOUT_TEMPLATE_UPDATE = PORTAL_PATH+"/platform/portal/layout/common/updateLayoutTemplate.jsp";
<%}%>

<%if(false){%>
<script language="JavaScript">
<!--
<%}%>

<%
String portlet_type_ = "";
String module = "outter";
if(("1".equals(request.getParameter("preview"))&&layoutId!=null&&!"".equals(layoutId)&&!"null".equals(layoutId))||
    (!"1".equals(request.getParameter("preview"))&&(layoutId==null||"".equals(layoutId)||"null".equals(layoutId)))){
    module = "";
}
if("outter".equals(request.getParameter("type"))){
    module = "outter";
}
List portletList = bd.getPortletList(module, new Long(0));
if(portletList!=null){
    int k=0;
    for(int i=0, j=portletList.size(); i<j; i++){
        PortalPortletPO portlet = (PortalPortletPO)portletList.get(i);
        String type_ = portlet.getType_();
        if(!"separator".equals(type_)){//去掉分隔符

            portlet_type_ += (k>0?",":"") + type_;
            k++;
        }
    }
}

//Exchange服务地址
String exchangeServer = "";
try{
    exchangeServer = new com.whir.component.config.ConfigXMLReader().getAttribute("ExchangeWebService", "server1");
}catch(Exception e){}
%>

var EXCHANGE_SERVER = "<%=exchangeServer%>";
var PORTLET_TYPES   = "<%=portlet_type_%>,personaltip,weather,calendar";
//var PORTLET_TYPES = "chart,stock,rss,weather,calendar,login,onlineuser,forum,information,text,picture,media,html,websearch,expert,knowledgelabel";

var PORTLET_DEFAULT_HEIGHT = "auto";//"auto";
var PORTLET_UPDATING = "更新中...";

var DEFAULT_COLOR = {"themes/2011/green":"#1E6C00","themes/2011/blue":"#0F6CBB","themes/2011/orange":"#E55600","themes/2011/gray":"#2B5672","themes/2007/blue":"#1D5BC8","themes/2009/blue":"#0F6CBB","themes/2012/blue":"#42B6EF","themes/2012/green":"#52B600","themes/metro/blue":"#FFF","themes/metro/green":"#FFF","themes/department/default/blue":"#FFFFFF","themes/department/default/green":"#52B600","themes/2013/blue":"#555555","themes/2013/green":"#555555","themes/2013/red":"#555555","themes/2013/lightblue":"#555555"};

var _body_scrollTop = 0;
var _outter = "<%=module%>";
var reLiWidth = _outter == 'outter' ? true:false;

var Portlet = {
	DEL_MSG: '确认删除吗？',//'确定要永久删除这个内容从当前页面吗？',
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

        if(reLiWidth && _hasTitle != '1'){
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
        }
    },
    setOtherLink: function(portletSettingId, opts){
    },
	addPortlet: function(opts){
		var portletSettingId = opts.portletSettingId;
		var pid = 'portletSettingId_'+portletSettingId;
		var title = opts.title;
		var layoutId = opts.layoutId;
		var portletId = opts.portletId;
		var type = opts.type;
		var iconCls = opts.iconCls;
        var iconFont = opts.iconFont;
		var height = opts.height?opts.height:PORTLET_DEFAULT_HEIGHT;
		var flag = opts.flag;
        var titleColor = opts.titleColor?opts.titleColor:"";
		var contentBgColor = opts.contentBgColor?opts.contentBgColor:"";
        var hasToolbar = opts.hasToolbar?opts.hasToolbar:"";
        var hasTitle = opts.hasTitle?opts.hasTitle:"";
        
        var module = '';

        //portlet container
        module += '<div class="wh-portal-info-box" id='+pid+' portletSettingId='+portletSettingId+' portletId='+portletId+' layoutId='+layoutId+' type="'+type+'">';

        //-- toolbar start--
        module += '    <div class="wh-portal-tools" id="tools_'+pid+'">';
        //module += '        <i id="mm_'+pid+'" title="闭合" class="fa fa-minus fa-color" onclick="showHide(this,\''+pid+'\',\''+type+'\');"></i>';
        module += '        <i id="refresh_'+pid+'" title="刷新" class="fa fa-refresh fa-color"></i>';
        if(flag==1){
            <%if(isSameSession){%>
        module += '        <i id="edit_'+pid+'" title="设置" class="fa fa-pencil fa-color"></i>';
        module += '        <i id="delete_'+pid+'" title="删除" class="fa fa-times fa-color" onclick="moduleClose(this,'+portletSettingId+','+layoutId+', \''+title.replace(/"/g,'&quot;')+'\');"></i>';
            <%}%>
        }
        if(flag==0){
            //module += '        <i id="more_'+pid+'" title="更多" class="fa fa-more fa-color"></i>';
        }
        module += '    </div>';
        //-- toolbar end--

        //-- main start--
        module += '    <div class="wh-portal-info">';

        //-- title start--
        module += '        <div class="wh-portal-i-title clearfix" id="header_'+pid+'" data-title="'+title.replace(/"/g,'&quot;')+'" data-color="'+titleColor+'" data-iconFont="'+iconFont+'" data-toolbar="'+hasToolbar+'" data-hasTitle="'+hasTitle+'">';
        module += '            <ul id="ul_'+pid+'" class="wh-portal-i-title-left clearfix">';
        module += '                <li class="wh-portal-title-li on"><a href="javascript:void(0);" '+(titleColor != ''?'style="color:'+titleColor+'"':'')+' id="t_'+pid+'"><i class="'+(iconFont?'fa ' + iconFont:'')+'" id="i_'+pid+'"></i>'+title+'</a></li>';
        module += '            </ul>';
        //module += '            <h3><a href="javascript:void(0);" id="mt_'+pid+'"></a></h3>';
        module += '        </div>';
        //-- title end--

        //-- content start--
        module += '        <div class="wh-portal-i-content" id="content_'+pid+'">';
        module += '        </div>';
        //-- content end--

        module += '    </div>';
        //-- main end--

        module += '</div>';

		var p = $(module).appendTo('body');
		$('#edit_'+pid).bind('click', function(){
			portletSetting(p, layoutId, portletId, portletSettingId, type, title);
		});
		$('#refresh_'+pid).bind('click', function(){
			eval(type).refresh($('#content_'+pid), opts);
		});

        try{
            parseInt(height, 10);
            height = height + 'px';
        }catch(e){}

        $('#content_'+pid).css('height', height);
		
		if(titleColor != ''){
            $('#t_'+pid).css('color', titleColor);
		}
		if(contentBgColor!=''){
			$('#content_'+pid).css('background', contentBgColor);
		}

		if(flag == 0){
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
		}

		return p;
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

/*--------ajax post--------*/
function ajaxPost(url, data){
	$.ajax({
		type: 'POST',
		url: url,
		cache: false,
		data: data,
		dataType: 'json',
		success: function(json) {
			//alert("处理成功");
		}
	});
}

var _portletSettingsXml_ = null;
function ajaxResponseXML(portletSettingId){
    //_portletSettingsXml_=null;
    if(_portletSettingsXml_!=null){
        //_portletSettingsXml_=_portletSettingsXml_.replace('<?xml version="1.0" encoding="UTF-8"?>','');
        _portletSettingsXml_ = _portletSettingsXml_;//'<xml>'+_portletSettingsXml_+'</xml>';
        var xmldom=null 
        if(navigator.userAgent.toLowerCase().indexOf("msie")!=-1){ 
            xmldom=new ActiveXObject("Microsoft.XMLDOM"); 
            xmldom.loadXML(_portletSettingsXml_); 
        } else {
            xmldom=new DOMParser().parseFromString(_portletSettingsXml_,"text/xml");
        }
        _portletSettingsXml_ = null;
        return xmldom;
    }else{
        var result = $.ajax({
            type: 'POST',
            url: PORTLET_SETTING_SAVE_XML+'?time='+(new Date().getTime()),
            cache: true,
            async: false,
            data: 'portletSettingId='+portletSettingId,
            dataType: 'xml',
            success: function(response) {
                //alert(response);
            }
        }).responseXML;
        return result;
    }
}

function newPortlet(opts){
	var layoutId = opts.layoutId;
	var portletId = opts.portletId;
	var type = opts.type;
	var iconCls = opts.iconCls;
	var title = opts.title;

	var options = {layoutId:layoutId, portletId:portletId, type:type, title:title, layoutName:opts.layoutName};

    var zones = $('td.portal-column-td[zone]');
    if(zones.length>0){
        var zone = $(zones[0]).attr('zone');
		options = $.extend(options, {zone:zone});
        $.post(PORTLET_ADD_URL+'?time='+(new Date().getTime()), options, 
			function(data){
                if(data.success){
                    //alert("添加成功");                    
                    var portletSettingId = data.portletSettingId;
					var portletOptions = $.extend(options, {portletSettingId:portletSettingId, iconCls:iconCls, flag:1, isNew:true, titleColor:DEFAULT_COLOR[PORTAL_SKIN]});
					newPortletZone(portletOptions);
                    document.body.scrollTop = 0;
                }else{
                    //添加失败

                }
            }, 'json'
        );
    }
}

var g_cnt=0;
var g_lazyTime=1;
var g_zone=[];

function newPortletZone(opts){	
	var type = opts.type;
	var zone = opts.zone;
	var flag = opts.flag;
	var isNew = opts.isNew;
	opts = $.extend(opts, {skin:PORTAL_SKIN});
	/*$.each(PORTLET_TYPES.split(','), function(i, ptype){
		if(type==ptype){*/
			var fn = eval(type);
			if(fn){
				//if($.isFunction(fn.portletAdd)){
					var p = fn.portletAdd(opts);
					if(p){
						var c = g_zone[zone];
						if(c == undefined){
							c = $('#portalMain').find('td.portal-column-td[zone="'+zone+'"]');
							g_zone[zone]=c;
						}
						
						if(opts.append){
							c.append(p);
						}else{
							p.prependTo(c);
						}

						var pid = p.attr('id');

						if(flag==1){
							if(Util.dragArray){
								var dragItemCnt = Util.dragArray.length;
								Util.dragArray[dragItemCnt] = new _draggable(document.getElementById(pid));
							}
						}

                        if(!opts.titleColor || opts.titleColor==''){
                            opts = $.extend(opts, {titleColor:DEFAULT_COLOR[PORTAL_SKIN]});
                        }

						//if($.isFunction(fn.refresh)){
                            /*if(typeof _def_isPortalPage_ != 'undefined'){//登录前用

                                opts = $.extend(opts, {outter:"<%="outter".equals(request.getParameter("type"))?"1":"0"%>"});
                            }*/
                            
							//fn.refresh($('#content_'+pid), opts);
							if(g_cnt%8==0)g_lazyTime+=60;
							setTimeout(function(){fn.refresh($('#content_'+pid), opts);}, g_cnt*g_lazyTime);g_cnt++;
						//}
					}
					p = null;					
				//}
			}
			/*return;
		}
	});*/
}
var api = null;
<%if(isSameSession){%>
function portletSetting(target, layoutId, portletId, portletSettingId, type, title){
	var data = '&layoutId='+layoutId+'&portletId='+portletId+'&portletSettingId='+portletSettingId+'&type='+type+'&outter=<%="outter".equals(request.getParameter("type"))?"1":"0"%>&portalType=<%=request.getParameter("type")%>';
	var api1 = $.dialog({id:portletSettingId,title:title+'设置',width:730,height:150,lock:true,ok:function(){return saveSetting();},okVal:'保存',cancel:true,cancelVal:'取消',max:false,min:false,resize:false}); 
	api = api1;
	$.ajax({ 
		url:PORTLET_SETTING_URL+'?time='+(new Date().getTime())+data, 
		success:function(data){ 
			api.content(data); 
		}, 
		cache:false 
	});
	$('input[name=title]').focus();
}

function portletMove(opt){
	var data = '';
	var layoutId = $('#layoutId').val();
	$('td.portal-column-td[zone]').each(function(i) {
		var zone = $(this).attr('zone');
		var portletSettingIds = "";
		$(this).find('div.wh-portal-info-box').each(function(){
			//var portletId = $(this).attr('portletId');
			var portletSettingId = $(this).attr('portletSettingId');
			portletSettingIds += '$' + portletSettingId + '$';
			/*if(layoutId==''){
				layoutId = $(this).attr('layoutId');
			}*/
		});
		data += '&zone=' + zone + '&portletSettingIds=' + portletSettingIds;
	});

	data = 'layoutId=' + layoutId + data;
	//alert(data);
	if(layoutId!=''){
		$.ajax({
			type: 'POST',
			url: whirRootPath+'/platform/portal/layout/common/portletMove.jsp?time='+(new Date().getTime()),
			cache: false,
			data: data,
			success: function(json) {
                if(opt && opt.save == '1'){
				    whir_alert("保存成功！");
                }
			}
		});
	}
}

//保存方案
function saveLayout(obj){
    portletMove({save:'1'});
}

function deletePortlet(portletSettingId, layoutId, title){
    $.post(PORTLET_DELETE, {
        portletSettingId:portletSettingId, layoutId:layoutId, title:title
        }, function(data){
            if(data.success){
                //alert("删除成功");

            }else{
                //删除失败
            }
        }, 'json'
    );
}

function layoutSettingPanel(layoutId,templateId){
    /*var _bw = $('body').width();
	var _bh = $('body').height();
	var _pw = $('#layoutSetting').width();
	var _ph = $('#layoutSetting').height();

	var _left = (_bw-_pw)/2;
	var _top = (_bh-_ph)/2-30;

	var _templateId = $('input[name=_templateId]').val();
	$('input[name=newTemplateId][value='+_templateId+']').attr("checked",true);
    $('#layoutSetting').window('open').panel('resize', {left:_left+'px', top:_top+'px'});*/

	var data = '&layoutId='+layoutId+'&templateId='+templateId+'&type=<%=request.getParameter("type")%>';
	var api1 = $.dialog({id:layoutId,title:'布局设置',width:600,height:250,lock:true,ok:function(){ok();},okVal:'保存',cancel:true,cancelVal:'取消',max:false,min:false,resize:false}); 
	api = api1;
	$.ajax({ 
		url:'PortalLayout!templateSet.action'+'?time='+(new Date().getTime())+data, 
		success:function(data){ 
			api.content(data); 
		}, 
		cache:false 
	});
}

function moduleClose(obj, portletSettingId, layoutId, title){
	whir_confirm(Portlet.DEL_MSG,function(){
		//$(obj).parent().parent().parent().parent().remove();
        $(obj).parent().parent().remove();
		deletePortlet(portletSettingId, layoutId, title);
	});
}

function openCtrlPanel(){
    var ctrlPanelTd = $('#ctrlPanelTd');
    if(ctrlPanelTd.css('display')=='none'){
        ctrlPanelTd.css('display','block');
    }else{
        ctrlPanelTd.css('display','none');
    }
}

/*function expandAll(){
	$('#portalMain').find('div.modbox').each(function(){
		var modbox = $(this);
		$(this).find('div.moduleContents').each(function(){
			var moduleContents = $(this);
			if(moduleContents.css('display')=='none'){
				moduleContents.css('display','block');
				var pid = moduleContents.attr('id').substr(9);
				$('#mm_'+pid).attr("src", PORTAL_PATH+"/"+PORTAL_SKIN+"/portal/yc.gif");
				$('#mm_'+pid).attr("title", "隐藏");
			}
		});		
	});
}*/

//展开闭合
function collapseAll(obj){
    var _title = $(obj).html();
    if(_title == '全部闭合'){
        $(obj).html('全部展开');
        $('#portalMain').find('div.wh-portal-info-box').each(function(){
            var moduleContents = $(this);
            var pid = moduleContents.attr('id');//.substr(9);
            $(this).find('div.wh-portal-i-content').each(function(){
                if($(this).css('display') == 'block'){
                    $(this).hide();
                    $('#mm_'+pid).removeClass('fa-minus').addClass('fa-plus');
                    $('#mm_'+pid).attr("title", "闭合");
                }
            });		
        });
    }else{
        $(obj).html('全部闭合');
        $('#portalMain').find('div.wh-portal-info-box').each(function(){
            var moduleContents = $(this);
            var pid = moduleContents.attr('id');//.substr(9);
            $(this).find('div.wh-portal-i-content').each(function(){
                if($(this).css('display') == 'none'){
                    $(this).show();
                    $('#mm_'+pid).removeClass('fa-plus').addClass('fa-minus');
                    $('#mm_'+pid).attr("title", "展开");
                }
            });		
        });
    }
}

//清空portlets
function clearAll(obj){
    $('#portalMain').find('div.wh-portal-info-box').remove();
}
<%}%>

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

var portletSettingIds_ = "";
function refreshPortlets(){
    //setTimeout("refreshPortlets_();", 1000);
    refreshPortlets_();
}

function refreshPortlets_(){
    window.scroll(0,0);

    var cnt=0;
    var lazyTime=1;
    if(portletSettingIds_ != ''){
        var arr = portletSettingIds_.split(",");
        for(var i=0,j=arr.length; i<j; i++){
            if(arr[i] != ''){
                if(cnt%9==0)lazyTime+=50;
                //setTimeout(function(){$('#refresh_portletSettingId_'+arr[i]).click();}, cnt*lazyTime);cnt++;
                $('#refresh_portletSettingId_'+arr[i]).click();
            }
        }
    }
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

function checkSession(obj, paramOpts){//{"lefturl":"", "righturl":"", "wintype":"0|1|2"}
<%
    if(session.getAttribute("userName")==null){
%>
    whir_alert("请先登录！");
<%}else{%>
<%}%>
}

var _st=0;
var _et=0;
_st=new Date().getTime();
<%
if(layoutId!=null&&!"".equals(layoutId)&&!"null".equals(layoutId)){
%>
portletSettingIds_ = "";
var g_zoneArr = [];
var g_portletSetting = [];
var g_portletSettingIds = "";
/*var _loadTyps_ = ",";
var head_tag = document.getElementsByTagName('head')[0];
PORTLET_TYPES = '';*/
<%
Map portletMap = bd.getPortalLayoutPortletMap(layoutId);
String[][] PortalLayoutPortlet = (String[][])portletMap.get("PortalLayoutPortlet");
String[][] PortalPortletSetting = (String[][])portletMap.get("PortalPortletSetting");
if(PortalPortletSetting!=null&&PortalPortletSetting.length>0){
    if(PortalLayoutPortlet!=null&&PortalLayoutPortlet.length>0){
        for(int i=0; i<PortalLayoutPortlet.length; i++){
            String zone = PortalLayoutPortlet[i][1];
            String settingIds = PortalLayoutPortlet[i][0];
            if(settingIds!=null&&!"".equals(settingIds)&&!"null".equals(settingIds)){
%>
                g_zoneArr['<%=zone%>'] = '<%=settingIds%>';
                g_portletSettingIds += g_zoneArr['<%=zone%>'];
<%
                settingIds = settingIds.substring(1, settingIds.length()-1);
                String[] idArr = settingIds.split("\\$\\$");
                //for(int j=idArr.length-1; j>=0; j--){
				for(int j=0; j<idArr.length; j++){
                    for(int k=0; k<PortalPortletSetting.length; k++){
                        String portletSettingId = PortalPortletSetting[k][0];
                        if(idArr[j].equals(portletSettingId)){
%>
    g_portletSetting['<%=portletSettingId%>'] = {xml: '<%=PortalPortletSetting[k][5]%>', opts: {layoutId:'<%=layoutId%>', portletId:'<%=PortalPortletSetting[k][1]%>', portletSettingId:'<%=portletSettingId%>', zone:'<%=zone%>', type:'<%=PortalPortletSetting[k][2]%>', iconCls:'<%=PortalPortletSetting[k][3]%>', title:'<%=PortalPortletSetting[k][4]%>', flag:0, append:true}};
	portletSettingIds_ += "<%=portletSettingId%>,";

    <%--if(_loadTyps_.indexOf('<%=PortalPortletSetting[k][2]%>')==-1){
        _loadTyps_+="<%=PortalPortletSetting[k][2]%>,";
        var se = document.createElement('script');
        se.src = whirRootPath+'/platform/portal/js/portlet.<%=PortalPortletSetting[k][2]%>.js';
        head_tag.appendChild(se);
    }--%>
<%
                            break;
                        }
                    }
                }                
            }
        }
    }
}
%>

$(function(){
    $("#portalMain").css('display','none');

    //portletSettingIds_ = "";

    var zoneArr = [];
    $('#portalMain').find('td.portal-column-td[zone]').each(function(i){
        //alert($(this).attr("zone"));
        var zone = $(this).attr("zone");
        zoneArr[i]=zone;
    });

    $("#startMsg").css('display','none');
    $("#portalMain").css('display','');

	while(g_portletSettingIds.length>0){
        for(var i=0; i<zoneArr.length; i++){
            var zone = zoneArr[i];
            var settingIds = g_zoneArr[zone];
            if(settingIds && settingIds.indexOf("$")!=-1){
                var sid = settingIds.substring(1, settingIds.indexOf("$$")!=-1?settingIds.indexOf("$$"):settingIds.lastIndexOf("$"));
                g_portletSettingIds = g_portletSettingIds.replace('$'+sid+'$','');

                g_zoneArr[zone] = settingIds.substring(settingIds.indexOf("$$")!=-1?settingIds.indexOf("$$")+1:settingIds.lastIndexOf("$")+1);

                _portletSettingsXml_ = g_portletSetting[sid].xml;
                newPortletZone(g_portletSetting[sid].opts);
            }
        }
    }

    g_portletSetting = null;
    delete g_portletSetting;

    _portletSettingsXml_ = null;

	//_dt = new Date().getTime();alert(_dt-_st);
       
    //IE
    if($.browser.msie){
        setTimeout("CollectGarbage();", 3000);
    }
	
<%if("1".equals(request.getParameter("preview"))){%>
    //resizeFullWin();
<%}%>
});
<%}%>

<%if(false){%>
//-->
</script>
<%}%>

<%}%>