<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.component.config.ConfigXMLReader"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.po.EVoInfoPO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%  
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
                <td width=33.3% height=50 >
                    <input type="hidden" name="unitImgName1080" id="unitImgName1080"  value="<%=uploadImg1080.getImgUploadShowName()==null||"null".equals(uploadImg1080.getImgUploadShowName())?uploadImg1080.getImgDefaultName():uploadImg1080.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName1080" id="unitImgSaveName1080" value="<%=uploadImg1080.getImgUploadSaveName()==null||"null".equals(uploadImg1080.getImgUploadSaveName())||"logo.png".equals(uploadImg1080.getImgUploadSaveName().toString())?"201610801920.png":uploadImg1080.getImgUploadSaveName()%>"/> 				                     
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
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
				            <jsp:param name="buttonText"       value="1080*1920" />
					        <jsp:param name="fileSizeLimit"        value="10MB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1"/>
                        </jsp:include>                                           
                </td>
                 <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName720" id="unitImgName720" value="<%=uploadImg720.getImgUploadShowName()==null?uploadImg720.getImgDefaultName():uploadImg720.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName720" id="unitImgSaveName720" value="<%=uploadImg720.getImgUploadSaveName()==null||"logo.png".equals(uploadImg720.getImgUploadSaveName().toString())?"20167201280.png":uploadImg720.getImgUploadSaveName()%>"/> 				                  
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
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
				            <jsp:param name="buttonText"       value="720*1280" />
					        <jsp:param name="fileSizeLimit"        value="10MB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include>                                          
                </td>
                <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName480" id="unitImgName480" value="<%=uploadImg480.getImgUploadShowName()==null||"null".equals(uploadImg480.getImgUploadShowName())?uploadImg480.getImgDefaultName():uploadImg480.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName480" id="unitImgSaveName480" value="<%=uploadImg480.getImgUploadSaveName()==null||"null".equals(uploadImg480.getImgUploadSaveName())||"logo.png".equals(uploadImg720.getImgUploadSaveName().toString())?"2016480854.png":uploadImg480.getImgUploadSaveName()%>"/> 				                   
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
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
				            <jsp:param name="buttonText"       value="480*854" />
					        <jsp:param name="fileSizeLimit"        value="10MB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include>                                               
                </td>               
            </tr>
            
             <tr>
             <td class="td_lefttitle" valign="top" style="padding: 13px 0 3px 0 ; " colspan="3">苹果系统：</td>            
             </tr>    
             <tr valign="top">               
                <td width=33.3% height=50>
                    <input type="hidden" name="unitImgName750" id="unitImgName750" value="<%=uploadImg750.getImgUploadShowName()==null||"null".equals(uploadImg750.getImgUploadShowName())?uploadImg750.getImgDefaultName():uploadImg750.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName750" id="unitImgSaveName750" value="<%=uploadImg750.getImgUploadSaveName()==null||"null".equals(uploadImg750.getImgUploadSaveName())||"logo.png".equals(uploadImg750.getImgUploadSaveName().toString())?"20167501334.png":uploadImg750.getImgUploadSaveName()%>"/> 				                  
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
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
				            <jsp:param name="buttonText"       value="750*1334" />
					        <jsp:param name="fileSizeLimit"        value="10MB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include>                                       
                </td>
                <td width=33.3% height=50 colspan="2">
                    <input type="hidden" name="unitImgName1242" id="unitImgName1242" value="<%=uploadImg1242.getImgUploadShowName()==null||"null".equals(uploadImg1242.getImgUploadShowName())?uploadImg1242.getImgDefaultName():uploadImg1242.getImgUploadShowName()%>"/>   
					<input type="hidden" name="unitImgSaveName1242" id="unitImgSaveName1242" value="<%=uploadImg1242.getImgUploadSaveName()==null||"null".equals(uploadImg1242.getImgUploadSaveName())||"logo.png".equals(uploadImg1242.getImgUploadSaveName().toString())?"201612422208.png":uploadImg1242.getImgUploadSaveName()%>"/> 				                   
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
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
				            <jsp:param name="buttonText"       value="1242*2208" />
					        <jsp:param name="fileSizeLimit"        value="10MB" />
					        <jsp:param name="fileTypeExts"		 value="*.png" />
					        <jsp:param name="uploadLimit"      value="1" />
                        </jsp:include>                                      
                </td>              
            </tr>
          
            <tr class="Table_nobttomline">               
			    <td style="text-align: left; " colspan="3">
				    <input type="button" class="btnButton4font" onclick="saveset();" value="<s:text name="comm.save"/>"/>
				    <input type="button" class="btnButton4font"  onclick="javascript:setDefault('750*1334');" value="恢复默认"/>              				     
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
	 html += '<a href="javascript:void(0)" title="修改" onclick="edit('+po.mobileId+')">修改</a>';	
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
function setDefault(stype){
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
	if(unitImgName1.length>30||unitImgName2.length>30||unitImgName3.length>30||unitImgName4.length>30||unitImgName5.length>30){
		whir_alert("图片名称长度超出30，请重新上传！");
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
</script>
</html>
 