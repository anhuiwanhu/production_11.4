<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.information.infomanager.bd.*"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.common.util.DataSourceBase"%>
<%@ page import="java.sql.*"%>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
boolean _outter_ = "1".equals(request.getParameter("outter"));

String _outter_arg = "";
if(_outter_){
    _outter_arg = "&outter=1";
}

ModuleVO mvo = (ModuleVO)request.getAttribute("mvo");
if(mvo!=null){
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String classId = confMap.get("classId");
String scrolling = confMap.get("scrolling");
boolean topPreview = "1".equals(confMap.get("topPreview"))?true:false;
String infoType = confMap.get("infoType");
String limitNum = confMap.get("limitNum");
String imgNum = confMap.get("imgNum")!=null&&!"".equals(confMap.get("imgNum"))?confMap.get("imgNum"):"5";
String portalHeight = confMap.get("windowHeight")!=null&&!"".equals(confMap.get("windowHeight"))?confMap.get("windowHeight"):"auto";
String picWidth = confMap.get("picWidth")!=null&&!"".equals(confMap.get("picWidth"))?confMap.get("picWidth"):"";
String picHeight = confMap.get("picHeight")!=null&&!"".equals(confMap.get("picHeight"))?confMap.get("picHeight"):"";
%>
<%
if(classId!=null&&!"".equals(classId)){
    Map itemMapName = mvo.getItemMapName();
    Map itemMap = mvo.getItemMap();
    Map linkMap = mvo.getLinkMap();
    Map imageMap = mvo.getImageMap();
    int mapSize = itemMapName.size();
    String[] cid = classId.split(",");
    int len = cid.length;
%>
<script>
var jsonData = [
	{
	
		ulCss:"wh-portal-title-slide04-<%=portletSettingId%>",
		data:[
		 <%
    	if(len>0){
		%>
		 	<%
            for(int i0=0; i0<mapSize; i0++){
                String className = (String)itemMapName.get(cid[i0]);
                //className = className.replaceAll("\"", "\\\\\"");
                String[] moreType = (String[])linkMap.get(cid[i0]);
                String linkUrl = "";
               	linkUrl = "javascript:"+moreType[1];//.replaceAll("\"", "\\\\\"");
                
                if(_outter_)linkUrl="openWin({url:'"+rootPath+"/PortalInformation!informationList.action?channelId="+cid[i0]+"', isFull:true});";
        	%>
			{title:"<%=className%>", url:"", onclick:"<%=linkUrl%>", defaultSelected:"<%=i0==0?"on":""%>",liCss:"wh-portal-overflow", morelink:"<%=linkUrl%>"},
			<%}%>
		<%}%>
		]
	}
];
Portlet.setPortletDataTitle('<%=portletSettingId%>',jsonData);
Portlet.setMoreLink('<%=portletSettingId%>',{});
</script>

<div class="wh-portal-info-content">
    <div class="wh-portal-slide04-<%=portletSettingId%>" id="slideKnowCon-<%=portletSettingId%>">
        <ul class="clearfix">		
<%
    int[] flex = new int[mapSize];
	for(int i0=0; i0<mapSize; i0++){
%>
   <%if(i0 == 0){%>
		<li>
	<%}else{%>
		<li class="wh-portal-hidden">
	<%}%>
<%
        List list = (List)itemMap.get(cid[i0]);
        if(list != null && list.size() > 0){
%>
<%
            if(topPreview && ("0".equals(infoType) || "1".equals(infoType))){
                ItemVO ivo = (ItemVO)list.get(0);
                String content = PortletUtil.HtmlToText(ivo.getContent());
                String _link = "";
                if("true".equals(ivo.getIsConf())){
                    _link = "openWin({url:'"+ivo.getLink()+"',winName:'info"+ivo.getId()+"',isFull:true});"; 
                    if(_outter_)_link="openWin({url:'"+rootPath+"/PortalInformation!getInformation.action?title="+ivo.getPoptitle()+"&id="+ivo.getId()+"', isFull:true});";
                }else{
                    _link = "javascript:alert('这是一份加密文件,您无权查看!');";
                }
                String[] _images = (String[])imageMap.get(cid[i0]);                
%>
				<div class="wh-portal-info-title">
					<div class="wh-portal-infotitle">
						<a href="javascript:void(0)" onclick="<%=_link%>"><strong><%=ivo.getName()%></strong></a>
						<p><span><%=ivo.getTime()%></span></p>
					</div>
					<div class="wh-portal-infocon">
                         <p><%=content.length()>100?content.substring(0,100)+"…":content%><span><%=ivo.getTime()%></span><a href="#" onclick="<%=_link%>">[详细]</a></p>
                    </div>
                 </div>
<%}%><!---if topPreview------->
   
<%if("0".equals(infoType)){//文%>
    <div class="wh-portal-pic-content clearfix">   
		<div id="wh-portal-iclist-<%=portletSettingId%>-<%=i0%>" class="wh-portal-iclist-<%=portletSettingId%>-<%=i0%> wh-protal-overflow">
        <%
            int j0 = topPreview?1:0;
            for (; j0 < list.size(); j0++) {
                ItemVO ivo = (ItemVO)list.get(j0);
                String _link = "";
                if("true".equals(ivo.getIsConf())){
                    _link = "openWin({url:'"+ivo.getLink()+"',winName:'info"+ivo.getId()+"',isFull:true});";
                    if(_outter_)_link="openWin({url:'"+rootPath+"/PortalInformation!getInformation.action?title="+ivo.getPoptitle()+"&id="+ivo.getId()+"', isFull:true});";
                }else{
                    _link = "javascript:alert('这是一份加密文件,您无权查看!');";
                }
        %>
		<div class="wh-portal-i-item clearfix">
			<a href="#<%=ivo.getId()%>">
         	<i class="fa fa-file-o"></i>
            <span class="wh-portal-a-cursor" onclick="<%=_link%>" title="<%=ivo.getPoptitle()%>"><%=ivo.getName()%></span>
            <em><%=ivo.getTime()%></em><%=ivo.getTitle()%>
            </a>
        </div>
        <%}%>
		</div>
	</div>
<%}else if("1".equals(infoType)){//图文%>
<div class="wh-portal-pic-content clearfix"> 
<%
boolean isImage = "1".equals(infoType);
if(isImage){
	ItemVO ivo = (ItemVO)list.get(0);
	String[] _images = (String[])imageMap.get(cid[i0]);
	if(!"/defaultroot/images/nophoto.gif".equals(_images[0])){
		String imageLink = "openWin({url:'"+_images[2]+"',winName:'info"+ivo.getId()+"', isFull:true});";
		if(_outter_)
			imageLink="openWin({url:'"+rootPath+"/PortalInformation!getInformation.action?title="+_images[1]+"&id="+ivo.getId()+"', isFull:true});";
%>
		<div class="wh-portal-pic-box">
        	<a href="javascript:void(0)"><img src="<%=_images[0]%>" alt="<%=_images[1]%>" width="100%" height="188" onclick="<%=imageLink%>"/></a>
		</div>
	<%}%>
	<div class="wh-portal-iclist-<%=portletSettingId%>-<%=i0%> wh-protal-overflow wh-portal-info-content">
		<div id="wh-portal-iclist-<%=portletSettingId%>-<%=i0%>" class="wh-portal-iclist-<%=portletSettingId%>-<%=i0%> wh-protal-overflow">
<%}%>
        <%
		int j0 = topPreview?1:0;
		for (; j0 < list.size(); j0++) {
			ItemVO ivo = (ItemVO)list.get(j0);
			String _link = "";
			if("true".equals(ivo.getIsConf())){
				_link = "openWin({url:'"+ivo.getLink()+"',winName:'info"+ivo.getId()+"',isFull:true});";
				if(_outter_)_link="openWin({url:'"+rootPath+"/PortalInformation!getInformation.action?title="+ivo.getPoptitle()+"&id="+ivo.getId()+"', isFull:true});";
			}else{
				_link = "javascript:alert('这是一份加密文件,您无权查看!');";
			}
        %>
		<div class="wh-portal-i-item clearfix">
			<a href="#<%=ivo.getId()%>">
         	<i class="fa fa-file-o"></i>
            <span class="wh-portal-a-cursor" onclick="<%=_link%>" title="<%=ivo.getPoptitle()%>"><%=ivo.getName()%></span>
            <em><%=ivo.getTime()%></em><%=ivo.getTitle()%>
            </a>
        </div>
		<%}%>
<%if(isImage){%>
		</div>
	</div>
<%}%>
</div>
<%}else{%>
<%
String channelId = cid[i0];
String userChannelName= "公司新闻";
int num = Integer.parseInt(imgNum);
int limitNum2 = Integer.parseInt(confMap.get("limitNum")!=null&&!"".equals(confMap.get("limitNum")) ? confMap.get("limitNum") : "20");
String domainId = CommonUtils.getSessionDomainId(request).toString();
String userId = session.getAttribute("userId") == null ? "-1" : session.getAttribute("userId").toString();
String orgId = session.getAttribute("orgId")!=null?session.getAttribute("orgId").toString():"-1";
String orgIdString = session.getAttribute("orgIdString")!=null?session.getAttribute("orgIdString").toString():"$-1$";

String files = "";
String texts = "";
String links = "";

int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
    smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());

List list_scroll = new ArrayList();
List listInfo = pbd.listInformation(channelId, userId, orgId, orgIdString, domainId,limitNum2);
String imageName = "-1"; //图片新闻图片名称,初始值为-1
String imageNewsTitle = "-1"; //图片新闻标题,初始值为-1
String imageNewsTitleLink = "-1"; //图片新闻标题链接,初始值为-1
int c = 0;
for (int i = 0; i < listInfo.size(); i++) {
	//设置图片显示数目
	if(c>=num){
		break;
	}

	Object[] obj = (Object[]) listInfo.get(i);
	int channelType = ((Integer) obj[7]).intValue();

	//图片新闻
	String informationId = obj[1].toString();
	InformationAccessoryBD accBD = new InformationAccessoryBD();
	List listAcc = accBD.getAccessory(informationId);
	for (int k = 0; k < listAcc.size(); k++,c++) {	
		Object[] objAcc = (Object[]) listAcc.get(k);
		if (((Integer) objAcc[4]).intValue() == 1) {
			//设置图片显示数目
			if(c>num){
				break;
			}

			imageName = objAcc[2].toString(); //标记已找到图片,标记为附件名称
			String datePath = imageName.substring(0,6);
			String subFolder = "";
			if(smartInUse==0){
				com.whir.common.util.UploadFile upFile = new com.whir.common.util.UploadFile();
				subFolder = upFile.getSubFolder(imageName);
				if(subFolder.length()>0){
					subFolder += "/";
				}
			}
			imageName=(smartInUse==1?rootPath+"/upload/information/"+datePath+"/"+imageName:fileServer+"/upload/information/"+subFolder+imageName);
			//
			imageNewsTitle = obj[2].toString(); //标题
			if("4".equals(infoType)){
				imageNewsTitle = imageNewsTitle.length()>10?imageNewsTitle.substring(0, 8)+"":imageNewsTitle;
			}
			imageNewsTitleLink =
					rootPath+"/Information!view.action?" +
					"informationId=" + obj[1] +
					"&userDefine=" + obj[11] + "&informationType=" +
					obj[6] + "&channelId=" + channelId + 
					"&channelType=" + channelType +
					"&userChannelName=" +
					"信息管理";
            if(_outter_){
                imageNewsTitleLink = rootPath+"/PortalInformation!getInformation.action?title="+imageNewsTitle+"&id="+obj[1];
            }

			files = files + imageName+"|";
			texts = texts + imageNewsTitle+"|";
			links = links + imageNewsTitleLink+"|";

			list_scroll.add(new String[]{imageName, imageNewsTitle, imageNewsTitleLink});
		}
	}
}
if(files.equals("")){
	files = rootPath+"/images/nophoto.gif";
	Object[] obj = (Object[]) listInfo.get(0);
	if(obj != null){
		String imageTitleTmp = obj[2].toString(); //标题
		int channelType = ((Integer) obj[7]).intValue();
		String imageNewsTitleLinkTmp =
					rootPath+"/Information!view.action?" +
					"informationId=" + obj[1] +
					"&userDefine=" + obj[11] + "&informationType=" +
					obj[6] + "&channelId=" + channelId + 
					"&channelType=" + channelType +
					"&userChannelName=" +
					"信息管理";
            if(_outter_){
                imageNewsTitleLinkTmp = rootPath+"/PortalInformation!getInformation.action?title="+imageTitleTmp+"&id="+obj[1];
            }
		texts = imageTitleTmp != null ? imageTitleTmp : "暂无图片";
		links = imageNewsTitleLinkTmp != null ? imageNewsTitleLinkTmp :"javascript:void(0)";
	}else{
		texts = "暂无图片";
		links = "javascript:void(0)";
	}	
}else if(files.endsWith("|")){
	files = files.substring(0,files.length()-1);
	texts = texts.substring(0,texts.length()-1);
	links = links.substring(0,links.length()-1);
	//links = links.replaceAll("&","%26");
}
%>
<%if("2".equals(infoType)){%>
		<div class="wh-portal-pic-slide" id="slide-pic-flex-<%=portletSettingId%>-<%=i0%>">
        	<ul class="slides clearfix">
				<%
					String[] fileArray = files.split("\\|");
					String[] textArray = texts.split("\\|");
					String[] linkArray = links.split("\\|");
					flex[i0] = fileArray.length;
					for(int i=0;i<fileArray.length;i++){
				%>
					 <li>
                		<div class="wh-portal-pic-slide-box" id="test-<%=fileArray.length%>">
                    		<a href="javascript:void(0)" class="wh-portal-pic-slide-img"><img name="image" style="cursor:pointer;" <%if(!"".equals(picWidth)){%> width="<%=picWidth%>"<%}%> <%if(!"".equals(picHeight)){%> height="<%=picHeight%>"<%}%> src="<%=fileArray[i]%>" onclick="openWin({url:'<%=linkArray[i]%>',winName:'info',isFull:true});" alt="<%=textArray[i]%>" /></a>
                    		<a href="javascript:void(0)" onclick="openWin({url:'<%=linkArray[i]%>',winName:'info',isFull:true});" class="wh-portal-pic-slide-txt"><%=textArray[i]%></a>
                		</div>
            		</li>
					<%}%>
			</ul>
			<ul class="wh-portal-pic-slide-circle" id="wh-pic-small-<%=portletSettingId%>-<%=i0%>">
			<%
			int pic_num = fileArray.length;
			int last_num = num > pic_num ? pic_num : num;
			for(int x=0;x<last_num;x++){
			%>
				<li></li>
			<%}%>
   		 	</ul>
	</div>

<%}else if("3".equals(infoType)){%>
<div class="wh-portal-pic-slide flexslider" id="slide-pic-flex-<%=portletSettingId%>-<%=i0%>">
        <ul class="slides clearfix">
				<%
					String[] fileArray = files.split("\\|");
					String[] textArray = texts.split("\\|");
					String[] linkArray = links.split("\\|");
					int pic_num = fileArray.length;
					int last_num = num > pic_num ? pic_num : num;
					flex[i0] = pic_num;
					for(int i=0;i<last_num;i++){
				%>
            <li>
                <div class="wh-portal-pic-slide-box">
                    <a href="javascript:void(0)" class="wh-portal-pic-slide-bg">
                    <img src="<%=fileArray[i]%>" width="100%" height="208" onclick="openWin({url:'<%=linkArray[i]%>',winName:'info',isFull:true});"/><span></span></a>
                    <a href="javascript:void(0)" class="wh-portal-pic-slide-text" onclick="openWin({url:'<%=linkArray[i]%>',winName:'info',isFull:true});"><%=textArray[i]%></a>
                </div>
            </li>
           <%}%>
        </ul>
	<ul class="wh-portal-pic-slide-small clearfix" id="wh-pic-small-<%=portletSettingId%>-<%=i0%>">
        		<%
					for(int i=0;i<last_num;i++){
				%>
		<li>
            <span class="wh-portal-pic-small-bg"></span>
            <img src="<%=fileArray[i]%>" alt="<%=textArray[i]%>"/>
        </li>
        <%}%>
    </ul>
</div>

<%}else if("4".equals(infoType)){%>

<div class="wh-slide-sim-consult-slide flexslider" id="wh-slide-sim-slide-<%=portletSettingId%>-<%=i0%>">
    <ul class="wh-slide-sim-consult-ul clearfix" id="wh-slide-sim-slideUl-<%=portletSettingId%>-<%=i0%>">
			<%
            String[] obj = null;
            for(int a = 0; a < list_scroll.size(); a ++){
           	obj = (String[]) list_scroll.get(a);
           	%>
					<li>
                       <div class="wh-slide-sim-consult-box">
                       		<div class="wh-slide-sim-look">
                           		<div class="wh-p-person-header">
                                   <img src="<%=obj[0]%>" onclick="openWin({url:'<%=obj[2]%>',winName:'info',isFull:true});" alt="<%=obj[1]%>" style="cursor:pointer"/>
                               </div>
                           </div>
                       </div>
                   </li>
			<%}%>
	</ul>
</div>

<script type="text/javascript">
    function slideFlex(slideSelector, slideSelectorUL){
        $(slideSelector).flexslider({
            selector: slideSelectorUL + " > li",
            animation: "slide",
            animationLoop: false,
            itemWidth: 150,
            itemMargin: 4,
            minItems: 2,
            maxItems: 4,
            directionNav: true,
            controlNav: false
            // pausePlay: true
        });
    }
	
    $(function(){
    <%
    for(int c0=0; c0<len; c0++){
	%>
        var $tab_li = $('.wh-portal-title-slide04-<%=portletSettingId%> li');
        $tab_li.mousemove(function(){
            $(this).addClass('on').siblings().removeClass('on');
            var index = $tab_li.index(this);
            $('#slideKnowCon-<%=portletSettingId%> > ul > li').eq(index).show().siblings().hide();

            if(index == 1){
                $("#wh-slide-sim-slide-<%=portletSettingId%>-<%=c0%>").resize();
            }
        });
		slideFlex("#wh-slide-sim-slide-<%=portletSettingId%>-<%=c0%>", "#wh-slide-sim-slideUl-<%=portletSettingId%>-<%=c0%>");
	<%}%>
    });
    
</script>
<%}%>

<%}%>

<%} //list != null的 %>
</li>
<%} //for 循环map的 %>
</ul>
</div>
</div>
<script language="JavaScript">
<!--
function openInfoChannel(url){
	if(!_def_isDesignPage_){
		location_href(url);
	}
}

function openDeptChannel(url, text){
    if(!_def_isDesignPage_){
		parent.menuJump(url, text);
	}
}
//-->
</script>
<script language="JavaScript">
<!--
slideTab('slide04-<%=portletSettingId%>');
<%if("1".equals(scrolling)){%>
	<%
    for(int a0=0; a0<len; a0++){
	%>
	<%
    List list = (List)itemMap.get(cid[a0]);
    if(list != null && list.size() > 0){
    %>
	//列表滚动
    var _wrap=$('#wh-portal-iclist-<%=portletSettingId%>-<%=a0%>');
	<%if(!topPreview || (topPreview && list.size() > 1)){%>
	scrolling(_wrap);
    <%}%>
    <%}%>
    <%}%>
<%}%>

function scrolling(obj){
	//列表滚动
    var _wrap = obj;
	var _interval=3000;
    var _moving;
    var infonum = <%=limitNum%>;
    var info_line_height = 26;
    var counth = info_line_height*(infonum);
    _wrap.css('height',counth);
    _wrap.hover(function(){
        clearInterval(_moving);
    },function(){
        _moving=setInterval(function(){
            var _field=_wrap.find('.wh-portal-i-item:first');
            var _h=_field.height();
            $('<div class="wh-portal-i-item clearfix">'+_field.html()+'</div>').appendTo(_wrap);
            _field.animate({marginTop:-_h+'px'},600,function(){
                _field.css('marginTop',0).remove();
            })

        },_interval)
    }).trigger('mouseleave');
}
//-->
</script>

<script type="text/javascript">
    $(function(){
        <%for(int b0=0; b0<len; b0++){
			if(flex[b0] > 1){
		%>
			$('#slide-pic-flex-<%=portletSettingId%>-<%=b0%>').flexslider({
			    manualControls:"#wh-pic-small-<%=portletSettingId%>-<%=b0%> li",
			    animation: "fade",
			    directionNav: false,
			    pauseOnHover: false
			});
			<%}%>
			var $tab_li = $('.wh-portal-title-slide04-<%=portletSettingId%> li');
	        $tab_li.mousemove(function(){
	            $(this).addClass('on').siblings().removeClass('on');
	            var index = $tab_li.index(this);
	            $('#slideKnowCon-<%=portletSettingId%> > ul > li').eq(index).show().siblings().hide();
	            $("#slide-pic-flex-<%=portletSettingId%>-<%=b0%>").resize();
	        });
		<%}%>
    })
</script>


<%}%>
<%}%>