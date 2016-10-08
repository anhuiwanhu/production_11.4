<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.component.config.ConfigXMLReader"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.po.EVoInfoPO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<% 
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
   
  String valid = request.getParameter("validate")==null?"":request.getParameter("validate").toString();
  ConfigXMLReader reader=new ConfigXMLReader();
  String evoserver=reader.getAttribute("Evopath", "evoUploadPath");
  String evoip=reader.getAttribute("Evopath", "evoUploadIp");
  String evoport=reader.getAttribute("Evopath", "evoUploadPort");
  String serverPath=reader.getAttribute("Evopath", "serverPath");
  
  String enterpriseNumber = request.getAttribute("enterpriseNumber")+""; 
  if(enterpriseNumber==null|"null".equals(enterpriseNumber)){
     enterpriseNumber="";
  }
  
  EVoInfoPO uploadImg750 =  (EVoInfoPO)request.getAttribute("uploadImg750*1334");  
  EVoInfoPO uploadImg1080 = (EVoInfoPO)request.getAttribute("uploadImg1080*1920");
  EVoInfoPO uploadImg480 = (EVoInfoPO)request.getAttribute("uploadImg480*845");
  EVoInfoPO uploadImg1242 = (EVoInfoPO)request.getAttribute("uploadImg1242*2208");
  EVoInfoPO uploadImg720 = (EVoInfoPO)request.getAttribute("uploadImg720*1280");
  
	//String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
	//java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
	//int smartInUse = 0;
	//if(sysMap != null && sysMap.get("附件上传") != null){
	//	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
	//}
	//String path = preUrl ;
	String src = preUrl + "/upload/mobileevoLogo/";	
	String defaultImgName="logo.png"; 
	String unitImgSaveName_1080 = uploadImg1080.getImgUploadSaveName()==null||"null".equals(uploadImg1080.getImgUploadSaveName())?"201610801920.png":uploadImg1080.getImgUploadSaveName();
	String unitImgSaveName_720 = uploadImg720.getImgUploadSaveName()==null||"null".equals(uploadImg720.getImgUploadSaveName())?"20167201280.png":uploadImg720.getImgUploadSaveName();
	String unitImgSaveName_480 = uploadImg480.getImgUploadSaveName()==null||"null".equals(uploadImg480.getImgUploadSaveName())?"2016480854.png":uploadImg480.getImgUploadSaveName();
	String unitImgSaveName_750 = uploadImg750.getImgUploadSaveName()==null||"null".equals(uploadImg750.getImgUploadSaveName())?"20167501334.png":uploadImg750.getImgUploadSaveName();
	String unitImgSaveName_1242 = uploadImg1242.getImgUploadSaveName()==null||"null".equals(uploadImg1242.getImgUploadSaveName())?"201612422208.png":uploadImg1242.getImgUploadSaveName();
	
	String src1080 = src+unitImgSaveName_1080;
	String src720 = src+unitImgSaveName_720;
	String src480 = src+unitImgSaveName_480;
	String src750 = src+unitImgSaveName_750;
	String src1242 = src+unitImgSaveName_1242;
 
%>
<head>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<title>evo客户端管理</title>
</head>
<style type="text/css">
.operateLink{margin-right:8px;}
</style>
<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="${ctx}/mobilecustmenu!getMobileCustMenuList.action" method="post" theme="simple">
<%@ include file="/public/include/form_list.jsp"%>
   
<div class="Public_tag">  
		<ul>  
			<li id="enterprisenumberLI" onclick="enterprisenumberLI()" ><span class="tag_center">微信企业号管理</span><span class="tag_right"></span></li>
			<li id="evoLI" class="tag_aon" onclick="evoLI()" ><span class="tag_center">evo客户端管理</span><span class="tag_right"></span></li>
		</ul>  
</div> 
<div style="border: 1px solid #ccc; padding:15px; ">
<table width="100%" border="0" cellpadding="0" cellspacing="0" >
    <tr>
      <td  style="padding: 10px 0; ">
       <table>    
             <tr>
                <td for="系统LOGO" class="td_lefttitle" valign="top" width="150" style="line-height:30px; font-size: 15px; ">1、evo服务器地址：</td>
                <td>
                    <s:textfield id="ipAdress" name="ipAdress" cssClass="inputText" size="40" readonly="true" style="width:200px"/>
                    <s:textfield id="portNum" name="portNum" cssClass="inputText" size="40" readonly="true" style="width:80px"/>                                 
                </td>
            </tr>
      </table>
      </td>
    </tr>
     <tr>
        <td>         
          <table width="100%"  border="0" cellpadding="0" cellspacing="0" >  
            <tr>
              <td for="横幅LOGO"  colspan="3" class="td_lefttitle" valign="bottom" ><span style="font-size: 15px; padding-right: 44px; ">2、横幅LOGO: </span>请按照对应尺寸上传对应横幅LOGO图片(png)</td>              
            </tr>   
         </table>
        <div style="padding-left: 150px; ">
     	<table>
     		<tr>
             <td class="td_lefttitle" valign="top" style="padding: 13px 0 3px 0; font-weight:blod; " colspan="3">安卓系统：</td>           
            </tr>          
            <tr valign="top">               
                <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName1080" id="unitImgName1080"  value="<%=uploadImg1080.getImgUploadShowName()==null||"null".equals(uploadImg1080.getImgUploadShowName())?uploadImg1080.getImgDefaultName():uploadImg1080.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName1080" id="unitImgSaveName1080" value="<%=unitImgSaveName_1080%>"/> 				                     
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                            <jsp:param name="onInit" value="" />
                            <jsp:param name="onSelect" value="" />

                            <jsp:param name="onUploadSuccess" value="showIMG" />
                            <jsp:param name="isShowBatchDownButton" value="no" />
                            <jsp:param name="thumbnail"  value="" />  
                            
                            <jsp:param name="makeYMdir"  value="no" />                       
                            <jsp:param name="dir"      value="mobileevoLogo" />
					        <jsp:param name="uniqueId"    value="unitImg1"/>
					        <jsp:param name="realFileNameInputId"    value="unitImgName1080" />
					        <jsp:param name="saveFileNameInputId"    value="unitImgSaveName1080" />
					        <jsp:param name="canModify"   value="yes" />
					        <jsp:param name="width"        value="90" />
					        <jsp:param name="height"       value="20" /> 
				            <jsp:param name="multi"        value="false" />
				            <jsp:param name="buttonClass" value="upload_btn" />
				            <jsp:param name="buttonText"       value="489*52" />
					        <jsp:param name="fileSizeLimit"        value="10KB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1"/>
                        </jsp:include> 
                        <div class="imgPhoto" onclick="clearImg('ImgShow_1080','unitImgName1080','unitImgSaveName1080');">删除</div>                                          
                </td>
                 <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName720" id="unitImgName720" value="<%=uploadImg720.getImgUploadShowName()==null?uploadImg720.getImgDefaultName():uploadImg720.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName720" id="unitImgSaveName720" value="<%=unitImgSaveName_720%>"/> 				                  
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                            <jsp:param name="onInit" value="" />
                            <jsp:param name="onSelect" value="" />

                            <jsp:param name="onUploadSuccess" value="showIMG" />
                            <jsp:param name="isShowBatchDownButton" value="no" />
                            <jsp:param name="thumbnail"                  value="" />  
                            
                            <jsp:param name="makeYMdir"  value="no" />                       
                            <jsp:param name="dir"      value="mobileevoLogo" />
					        <jsp:param name="uniqueId"    value="unitImg2"/>
					        <jsp:param name="realFileNameInputId"    value="unitImgName720" />
					        <jsp:param name="saveFileNameInputId"    value="unitImgSaveName720" />
					        <jsp:param name="canModify"   value="yes" />
					        <jsp:param name="width"        value="90" />
					        <jsp:param name="height"       value="20" /> 
				            <jsp:param name="multi"        value="false" />
				            <jsp:param name="buttonClass" value="upload_btn" />
				            <jsp:param name="buttonText"       value="321*34" />
					        <jsp:param name="fileSizeLimit"        value="10KB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include> 
                        <div class="imgPhoto" onclick="clearImg('ImgShow_720','unitImgName720','unitImgSaveName720');">删除</div>                                          
                </td>
                <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName480" id="unitImgName480" value="<%=uploadImg480.getImgUploadShowName()==null||"null".equals(uploadImg480.getImgUploadShowName())?uploadImg480.getImgDefaultName():uploadImg480.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName480" id="unitImgSaveName480" value="<%=unitImgSaveName_480%>"/> 				                   
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                            <jsp:param name="onInit" value="" />
                            <jsp:param name="onSelect" value="" />

                            <jsp:param name="onUploadSuccess" value="showIMG" />
                            <jsp:param name="isShowBatchDownButton" value="no" />
                            <jsp:param name="thumbnail"                  value="" />  
                            
                            <jsp:param name="makeYMdir"  value="no" />                       
                            <jsp:param name="dir"      value="mobileevoLogo" />
					        <jsp:param name="uniqueId"    value="unitImg3"/>
					        <jsp:param name="realFileNameInputId"    value="unitImgName480" />
					        <jsp:param name="saveFileNameInputId"    value="unitImgSaveName480" />
					        <jsp:param name="canModify"   value="yes" />
					        <jsp:param name="width"        value="90" />
					        <jsp:param name="height"       value="20" /> 
				            <jsp:param name="multi"        value="false" />
				            <jsp:param name="buttonClass" value="upload_btn" />
				            <jsp:param name="buttonText"       value="217*22" />
					        <jsp:param name="fileSizeLimit"        value="10KB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include> 
                        <div class="imgPhoto" onclick="clearImg('ImgShow_480','unitImgName480','unitImgSaveName480');">删除</div>                                                
                </td>               
            </tr>
            <tr id ="s_showImg1">
            	<td> 
            	    <div id="imgdiv_1080"  <%if("201610801920.png".equals(unitImgSaveName_1080)){%>style="display:none"<%} %>>           	    
            		<div class="fileup-imgdiv"><img id="ImgShow_1080" name="imgNameS" src="<%=src1080%>"></div>  
            		</div>            	 
            	</td>
            	<td> 
            	    <div id="imgdiv_720"  <%if("20167201280.png".equals(unitImgSaveName_720)){%>style="display:none"<%} %>>
            	    <div class="fileup-imgdiv" ><img id="ImgShow_720" name="imgNameS" src="<%=src720%>"></div> 
            	    </div>          	            		
            	</td>
            	<td>
            		<div id="imgdiv_480" <%if("2016480854.png".equals(unitImgSaveName_480)){%>style="display:none"<%} %>>
            		<div class="fileup-imgdiv" ><img id="ImgShow_480" name="imgNameS" src="<%=src480%>"></div>
            		</div>            	 
            	</td>
            </tr>
             <tr>
             <td class="td_lefttitle" valign="top" style="padding: 13px 0 3px 0 ; " colspan="3">苹果系统：</td>            
             </tr>    
             <tr valign="top">               
                <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName750" id="unitImgName750" value="<%=uploadImg750.getImgUploadShowName()==null||"null".equals(uploadImg750.getImgUploadShowName())?uploadImg750.getImgDefaultName():uploadImg750.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName750" id="unitImgSaveName750" value="<%=unitImgSaveName_750%>"/> 				                  
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                            <jsp:param name="onInit" value="" />
                            <jsp:param name="onSelect" value="" />

                            <jsp:param name="onUploadSuccess" value="showIMG" />
                            <jsp:param name="isShowBatchDownButton" value="no" />
                            <jsp:param name="thumbnail"                  value="" />  
                            
                            <jsp:param name="makeYMdir"  value="no" />                       
                            <jsp:param name="dir"      value="mobileevoLogo" />
					        <jsp:param name="uniqueId"    value="unitImg4"/>
					        <jsp:param name="realFileNameInputId"    value="unitImgName750" />
					        <jsp:param name="saveFileNameInputId"    value="unitImgSaveName750" />
					        <jsp:param name="canModify"   value="yes" />
					        <jsp:param name="width"        value="90" />
					        <jsp:param name="height"       value="20" /> 
				            <jsp:param name="multi"        value="false" />
				            <jsp:param name="buttonClass" value="upload_btn" />
				            <jsp:param name="buttonText"       value="328*33" />
					        <jsp:param name="fileSizeLimit"        value="10KB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include>  
                        <div class="imgPhoto" onclick="clearImg('ImgShow_750','unitImgName750','unitImgSaveName750');">删除</div>                                       
                </td>
                <td width=33.3% height=50 colspan="2">
                    <input type="hidden" name="unitImgName1242" id="unitImgName1242" value="<%=uploadImg1242.getImgUploadShowName()==null||"null".equals(uploadImg1242.getImgUploadShowName())?uploadImg1242.getImgDefaultName():uploadImg1242.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName1242" id="unitImgSaveName1242" value="<%=unitImgSaveName_1242%>"/> 				                   
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                            <jsp:param name="onInit" value="" />
                            <jsp:param name="onSelect" value="" />

                            <jsp:param name="onUploadSuccess" value="showIMG" />
                            <jsp:param name="isShowBatchDownButton" value="no" />
                            <jsp:param name="thumbnail"                  value="" />  
                            
                            <jsp:param name="makeYMdir"  value="no" />                       
                            <jsp:param name="dir"      value="mobileevoLogo" />
					        <jsp:param name="uniqueId"    value="unitImg5"/>
					        <jsp:param name="realFileNameInputId"    value="unitImgName1242" />
					        <jsp:param name="saveFileNameInputId"    value="unitImgSaveName1242" />
					        <jsp:param name="canModify"   value="yes" />
					        <jsp:param name="width"        value="90" />
					        <jsp:param name="height"       value="20" /> 
				            <jsp:param name="multi"        value="false" />
				            <jsp:param name="buttonClass" value="upload_btn" />
				            <jsp:param name="buttonText"       value="570*89" />
					        <jsp:param name="fileSizeLimit"        value="10KB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include>  
                        <div class="imgPhoto" onclick="clearImg('ImgShow_1242','unitImgName1242','unitImgSaveName1242');">删除</div>                                      
                </td>              
            </tr>
           <tr id ="s_showImg2">              
            	<td>  
            	    <div id="imgdiv_750" <%if("20167501334.png".equals(unitImgSaveName_750)){%>style="display:none"<%} %>>    	    
            		<div class="fileup-imgdiv"><img id="ImgShow_750" name="imgNameS" src="<%=src750%>"></div>
            		</div>
            	</td>
            	<td>            	   
            		<div id="imgdiv_1242" <%if("201612422208.png".equals(unitImgSaveName_1242)){%>style="display:none"<%} %>>
            		<div class="fileup-imgdiv" ><img id="ImgShow_1242" src="<%=src1242%>"></div>
            		</div>
            	</td>
            	<td></td>
            </tr>
            <tr class="Table_nobttomline">               
			    <td style="text-align: left; " colspan="3">
				    <input type="button" class="btnButton4font" onclick="saveset();" value="<s:text name="comm.save"/>"/>
				    <input type="button" class="btnButton4font"  onclick="javascript:setDefault();" value="恢复默认"/>              				     
			    </td>
		    </tr>		    
     	</table>
     	</div> 
      </td>
    </tr>
</table>

<style>
.MainFrameBox table{
margin: 0; 
}
.btnButton4font{
padding: 0 15px;
height: 34px;
margin: 10px 0 0 0;
}

.fileup-imgdiv{
	width: 286px;
	height: 45px;
	border: 1px solid #eee; 
	overflow:hidden;
}

.fileup-imgdiv img {
	display: block;
	width: 286px;
	height:45px;
} 

.imgPhoto{
	margin-top: -24px; 
	margin-left: 100px;
	padding-top: 3px;
	float: left;
	height: 20px;
	width: 94px;
	background: none repeat scroll 0% 0% #FFF;
	border: 1px solid #808080;
	text-align: center;
	cursor: pointer;
}
</style>

       <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			 <td align="left" width="55%" style="vertical-align: middle;"> 			   			   
               <span style="font-size: 15px; "> 3、应用管理 </span> 				 
			 </td>           
        </tr>
      </table>
 <!-- LIST TITLE PART START -->	 
		
        <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead" >                                        
          <td whir-options="field:'mobileMenuDisplayName',width:'25%'">应用名称</td>
          <td whir-options="field:'mobileMenuScope',width:'35%'" >适用范围</td>
          <td whir-options="field:'uploadLogo',width:'8%'" >图标</td>
          <td whir-options="field:'mobileMenuIsUse',width:'8%',renderer:showIsUse" >是否启用</td>
          <td whir-options="field:'mobileMenuOrder',width:'8%'" >排序</td>
          <td whir-options="field:'',width:'16%',renderer:showoperate" >操作</td>
        </tr>
		</thead>
		<tbody  id="itemContainer" >		
		</tbody>
       </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->
</div>
</s:form>
</body>
<script type="text/javascript"> 
//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){       
	initListFormToAjax({formId:"queryForm"}); 
	$("#ipAdress").val('<%=evoip%>');	  
	$("#portNum").val('<%=evoport%>');
	//alert($("#unitImgSaveName1080").val());
		      
});  

function enterManager(){
    openWin({url:'<%=rootPath%>/platform/custom/mobile_custmenu/clientApplication.jsp',isFull:true,winName:'写短信'});   
}
function gotoInit(){
   var enterpriseNumber=$("#enterpriseNumber").val();
   openWin({
   url:'<%=rootPath%>/mobilecustmenu!microEnterpriseNumber.action?status=1&enterpriseNumber='+enterpriseNumber,
   isFull:true,
   winName:'evo客户端管理'
   });
}
 //企业号页签
function enterprisenumberLI(){	 
	location_href("<%=rootPath%>/MoveOAmanager!wxmanager.action");
}

//evo页签
function evoLI(){ 
	location_href("<%=rootPath%>/mobilecustmenu!mobCustMenu.action");
}

function showoperate(po,i){
   var html = "";
   if(po.mobileMenuIsUse==1){
	   html +=  '<a href="javascript:void(0)" title="隐藏" onclick="hideMenu('+po.mobileId+')" class="operateLink">隐藏</a>'; 
	}else{
	   html +=  '<a href="javascript:void(0)"  title="启用" onclick="showMenu('+po.mobileId+')" class="operateLink">启用</a>';
	}	 
	 html += '<a href="javascript:void(0)" title="编辑" onclick="edit('+po.mobileId+')">编辑</a>';	
	return html;
}

function showIsUse(po,i){
        var html = "&nbsp;";
        if(po.mobileMenuIsUse=='0'){
            html = "否";
        }else if(po.mobileMenuIsUse=='1'){
            html = "是";
        } 
        return html;
}

function edit(id){
      var openurl="<%=rootPath%>/mobilecustmenu!mobCustMenuModi.action?mobileId="+id;      
      openWin({url:openurl,isFull:true,width:550,height:650,winName:'应用编辑'});
      //var casher_dialog = $.dialog({
      //        id:"evoE",
      //        title: '应用编辑',
      //        content: "url:<%=rootPath%>/mobilecustmenu!mobCustMenuModi.action?mobileId="+id,
      //        width: 640,
      //        height: 600,
      //        min:false,
      //        max:false
      //   }); 

}
function hideMenu(id){
   whir_confirm("您确定要隐藏吗？",function(){
	ajaxOperate({urlWithData:'mobilecustmenu!hideORShowMenu.action?status=0&mobileId='+id,tip:'隐藏菜单',isconfirm:false,formId:'queryForm'});
   });
}
function showMenu(id){
   whir_confirm("您确定要启用吗？",function(){
	ajaxOperate({urlWithData:'mobilecustmenu!hideORShowMenu.action?status=1&mobileId='+id,tip:'启用菜单',isconfirm:false,formId:'queryForm'});
   });
}
function setDefault(){
     $.ajax({
			url:"<%=rootPath%>/mobilecustmenu!resetEvoUploadLogo.action",		     
		    type:"POST",
		    dataType:"text",			
		    async:false,
		    error:function(e){			
		    	alert("恢复默认到移动端出错!");
		    },						    
		    success:function(data){
		    var d = eval('(' + data + ')');		     
		     if(d.result=="0"){//0：失败  1成功。返回字符串
		    	    alert("恢复默认到移动端失败!");
			        return false;		   		    	 
		    	 }else if(d.result=="1"){
		    	    alert("恢复默认到移动端成功!");			         
		    	 } 	      	 
		    }
		});
		location_href("<%=rootPath%>/mobilecustmenu!mobCustMenu.action");		
}

function saveset(){
	var unitImgName1 = $('#unitImgName1080').val();
	var unitImgName2 = $('#unitImgName720').val();
	var unitImgName3 = $('#unitImgName480').val();
	var unitImgName4 = $('#unitImgName750').val();
	var unitImgName5 = $('#unitImgName1242').val();
	
	if(unitImgName1==""||unitImgName2==""||unitImgName3==""||unitImgName4==""||unitImgName5==""){
		whir_alert("图片没有上传完！");
		return false;
	}
     
	if(unitImgName1.length>30||unitImgName2.length>30||unitImgName3.length>30||unitImgName4.length>30||unitImgName5.length>30){
		whir_alert("图片名称长度超出30，请重新上传！");
		return false;
	}else{
	   
	   $.ajax({
			url:"<%=rootPath%>/mobilecustmenu!updateEvoUploadLogo.action",
		    data:{	
		    	path_adr_1080:"mobileevoLogo",
		    	path_adr_720:"mobileevoLogo",
		    	path_adr_480:"mobileevoLogo",
		    	path_ios_1242:"mobileevoLogo",
		    	path_ios_750:"mobileevoLogo",
		    	     		    	 		    	
		        filename_show_1080:$("#unitImgName1080").val(),
		    	filename_show_720:$("#unitImgName720").val(),
		    	filename_show_480:$("#unitImgName480").val(),
		    	filename_show_750:$("#unitImgName750").val(),
		    	filename_show_1242:$("#unitImgName1242").val(),
		    	 		    	
		    	realname_save_1080:$("#unitImgSaveName1080").val(),
		    	realname_save_720:$("#unitImgSaveName720").val(),
		    	realname_save_480:$("#unitImgSaveName480").val(),
		    	realname_save_750:$("#unitImgSaveName750").val(),
		    	realname_save_1242:$("#unitImgSaveName1242").val(),
		    	 
		    	random : new Date().getTime()
		    },
		    type:"POST",
		    dataType:"text",			
		    async:false,
		    error:function(e){			
		    	alert("图片同步到移动端出错!");
		    },						    
		    success:function(data){
		    var d = eval('(' + data + ')');		     
		     if(d.result=="0"){//0：失败  1成功。返回字符串
		    	    alert("图片同步到移动端失败!");
			        return false;		   		    	 
		    	 }else if(d.result=="1"){
		    	    alert("图片同步到移动端成功!");			         
		    	 } 	      	 
		    }
		});
	 location_href("<%=rootPath%>/mobilecustmenu!mobCustMenu.action");
	}
	 
}
function clearImg(imgId,rNameId,sNameId){
    $('#'+imgId).attr('src','<%=rootPath%>/images/blank.gif');
    $('#'+rNameId).val('');
    $('#'+sNameId).val('');
}
function setDefault_New(){
    $('#unitImgName1080').val('logo.png');
    $('#unitImgSaveName1080').val('logo.png');
	$('#ImgShow').attr("src","<%=preUrl%>/upload/mobileevoLogo/"+$('#unitImgSaveName').val());
}
function showIMG(json){
    var flag = false;   
    var uniqueId=json.uniqueId;
    var rName="";
    var sName="";
    var sImgId="";
    if(uniqueId=="unitImg1"){
      rName="unitImgName1080";
      sName="unitImgSaveName1080";
      sImgId='ImgShow_1080';
      $('#imgdiv_1080').show();
    }else if(uniqueId=="unitImg2"){
       sImgId="ImgShow_720";
       rName="unitImgName720";
       sName="unitImgSaveName720";       
      $('#imgdiv_720').show();
    }else if(uniqueId=="unitImg3"){
       sImgId="ImgShow_480";
       rName="unitImgName480";
       sName="unitImgSaveName480";
       $('#imgdiv_480').show();
    }else if(uniqueId=="unitImg4"){
       sImgId="ImgShow_750";
       rName="unitImgName750";
       sName="unitImgSaveName750";
       $('#imgdiv_750').show();
    }else if(uniqueId=="unitImg5"){
       sImgId="ImgShow_1242";
       rName="unitImgName1242";
       sName="unitImgSaveName1242";
       $('#imgdiv_1242').show();
    }
   
    $('#'+sImgId).attr("src","<%=preUrl%>/upload/mobileevoLogo/"+json.save_name+json.file_type);
	//$('#'+sImgId).attr("src", "<%=preUrl%>/upload/mobileevoLogo/"+json.save_name+json.file_type).load(function() {
        //var fileOffsetWidth = this.width;
        //var fileOffsetHeight = this.height;
        //if(flag == false){            
            //alert(fileOffsetWidth + "X" + fileOffsetHeight);
            //flag = true;

            //if(209>fileOffsetWidth || 49>fileOffsetHeight){
            //    whir_confirm("系统推荐上传的图片尺寸为210X50，而您上传的图片大小为"+fileOffsetWidth+"X"+fileOffsetHeight+'，可能导致显示不正常！点击"确定"继续上传，点击"取消"退出上传。',function(){
            //    }, function(){
             //       clearImg();
             //   }
             //  );
            //}else if(211<fileOffsetWidth || 51<fileOffsetHeight){
             //   whir_confirm("系统推荐上传的图片尺寸为210X50，而您上传的图片大小为"+fileOffsetWidth+"X"+fileOffsetHeight+'，可能导致显示不正常！点击"确定"继续上传，点击"取消"退出上传。',function(){
             //   }, function(){
             //       clearImg();
             //  });
            //}
        //}
    //});
    $('#'+rName).val(json.file_name+json.file_type);
    $('#'+sName).val(json.save_name+json.file_type);
}
</script>
</html>
 