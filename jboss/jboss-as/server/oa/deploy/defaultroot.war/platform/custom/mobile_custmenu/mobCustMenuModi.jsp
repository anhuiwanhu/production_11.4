<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.po.CustomerMenuCurMobilePO"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.component.config.ConfigXMLReader"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*"%>
 
<!DOCTYPE html>
<html lang="zh-cn"> 
<%  
  CustomerMenuCurMobilePO po = (CustomerMenuCurMobilePO)request.getAttribute("curMobilePO"); 
  String imgName=po.getImgName()==null||"null".equals(po.getImgName())||"".equals(po.getImgName())?"":po.getImgName();//图标名称
  String isSystem=po.getIsSystem()+"";//是否是系统文件
  //String isSystem="0";//是否是系统文件
  ConfigXMLReader reader=new ConfigXMLReader();  
  String serverPath=reader.getAttribute("Evopath", "serverPath");
  StringBuffer buf = new StringBuffer();
  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
  buf.append(sdf.format(new Date()));//加上日期
  buf.append(".png");//加上后缀
  if("".equals(imgName)){
    imgName=buf.toString();
  }
  //String imgName_s=buf.toString();
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>应用编辑</title> 
    <%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.system.css" />
    <script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
     
</head>

<body class="MainFrameBox">
 <div class="app-info-edit"> 
    <div class="app-iedit-con">
        <s:form name="dataForm" id="dataForm" action="mobilecustmenu!updMobileCustMenu.action" method="post" theme="simple" >&nbsp; 
            <input type="hidden" id="uploadType" value="1"/>
            <%@ include file="/public/include/form_detail.jsp"%>
            <div>
                <label>应用名称：</label>
                <input type="hidden" name="mobileId" value="<%=po.getMobileId()%>"/>
                <input type="text" name="mobileMenuDisplayName"  maxlength="80" class="app-inputtext" value="<%=po.getMobileMenuDisplayName()==null||"null".equals(po.getMobileMenuDisplayName())?"":po.getMobileMenuDisplayName()%>"/>
            </div>
            <div>
                <label>排序：</label>
                <input type="text" name="mobileMenuOrder"  class="app-inputtext" value="<%=po.getMobileMenuOrder()%>"/>
            </div>
            <!--<div <%if("1".equals(isSystem)){ %>style="display:none"<%}%>>
                <label>适用范围<span class="MustFillColor">*</span>：</label>
                
                <input type="hidden" id="mobileMenuScopeIds" name="mobileMenuScopeIds" value="<%=po.getMobileMenuScopeIds()==null||"null".equals(po.getMobileMenuScopeIds())?"":po.getMobileMenuScopeIds()%>"/>
                <textarea class="inputTextarea" style="width:444px;" id="mobileMenuScope" name="mobileMenuScope" readonly="readonly"><%=po.getMobileMenuScope()==null||"null".equals(po.getMobileMenuScope())?"":po.getMobileMenuScope()%></textarea><a href="javascript:void(0);" class="selectIco textareaIco" onClick="openSelect({allowId:'mobileMenuScopeIds', allowName:'mobileMenuScope', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',limited:'1'});"></a>  
            </div> -->
            <div>
                <label>适用范围 ：</label>
                
                <input type="hidden" id="mobileMenuScopeIds" name="mobileMenuScopeIds" value="<%=po.getMobileMenuScopeIds()==null||"null".equals(po.getMobileMenuScopeIds())?"":po.getMobileMenuScopeIds()%>"/>
                <textarea class="inputTextarea" style="width:444px;" id="mobileMenuScope" name="mobileMenuScope" readonly="readonly"><%=po.getMobileMenuScope()==null||"null".equals(po.getMobileMenuScope())?"":po.getMobileMenuScope()%></textarea><a href="javascript:void(0);" class="selectIco textareaIco" onClick="openSelect({allowId:'mobileMenuScopeIds', allowName:'mobileMenuScope', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',limited:'1'});"></a>  
            </div>
           <div class="clearfix">
                <label>是否启用：</label>
                <label class="isuse"> <input name="mobileMenuIsUse" type="radio" value="1" <%if("1".equals(po.getMobileMenuIsUse()+"")){%>checked="checked"<%}%>/>是 </label>
                <label class="isuse"> <input name="mobileMenuIsUse" type="radio" value="0" <%if("0".equals(po.getMobileMenuIsUse()+"")){%>checked="checked"<%}%>/>否 </label>
            </div>
            <style>
            	#formId1,#formId2,#formId3,#formId4,#formId5,#formId6,#formId7,#formId8,#formId9,#formId10{ height:28px; }
            </style>
            <div <%if("1".equals(isSystem)){ %>style="display:none"<%}%>>
             <div class="evo-app-icon clearfix">
                <label>图标显示名称：</label>
                <label><input type="hidden" name="imgName" id="imgName" readonly="true" value="<%=imgName%>"/><%=imgName%></label>                               
            </div>
 
            <div class="evo-app-icon evo-fileup-div clearfix">
              
                <label>图标：</label>
                <label>1080x1800 png</label>
                <ul>                  
                    <input type="hidden" name="Img1showName" id="Img1showName" style="width:800px;" value="<%=po.getImg1showName()==null?"":po.getImg1showName()%>"/>   
					<input type="hidden" name="Img1saveName" id="Img1saveName" style="width:800px;" value="<%=po.getImg1saveName()==null?"":po.getImg1saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId1"/>
					   <jsp:param name="realFileNameInputId"    value="Img1showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img1saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
                
                <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>720x1280 png</label>
                <ul>                  
                    <input type="hidden" name="Img2showName" id="Img2showName" style="width:800px;" value="<%=po.getImg2showName()==null?"":po.getImg2showName()%>"/>   
					<input type="hidden" name="Img2saveName" id="Img2saveName" style="width:800px;" value="<%=po.getImg2saveName()==null?"":po.getImg2saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                       <jsp:param name="makeYMdir"  value="no" />                     					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId2" />
					   <jsp:param name="realFileNameInputId"    value="Img2showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img2saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
            </div>
            <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>480x800 png</label>
                <ul>                  
                    <input type="hidden" name="Img3showName" id="Img3showName" style="width:800px;" value="<%=po.getImg3showName()==null?"":po.getImg3showName()%>"/>   
					<input type="hidden" name="Img3saveName" id="Img3saveName" style="width:800px;" value="<%=po.getImg3saveName()==null?"":po.getImg3saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId3" />
					   <jsp:param name="realFileNameInputId"    value="Img3showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img3saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="8" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
                <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>320x480 png</label>
                <ul>                  
                    <input type="hidden" name="Img4showName" id="Img4showName" style="width:800px;" value="<%=po.getImg4showName()==null?"":po.getImg4showName()%>"/>   
					<input type="hidden" name="Img4saveName" id="Img4saveName" style="width:800px;" value="<%=po.getImg4saveName()==null?"":po.getImg4saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId4" />
					   <jsp:param name="realFileNameInputId"    value="Img4showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img4saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="8" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
            </div>
            <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>1536x2048 png</label>
                <ul>                  
                    <input type="hidden" name="Img5showName" id="Img5showName" style="width:800px;" value="<%=po.getImg5showName()==null?"":po.getImg5showName()%>"/>   
					<input type="hidden" name="Img5saveName" id="Img5saveName" style="width:800px;" value="<%=po.getImg5saveName()==null?"":po.getImg5saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                       <jsp:param name="makeYMdir"  value="no" />                     					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId5" />
					   <jsp:param name="realFileNameInputId"    value="Img5showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img5saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
                <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>768x1024 png</label>
                <ul>                  
                    <input type="hidden" name="Img6showName" id="Img6showName" style="width:800px;" value="<%=po.getImg6showName()==null?"":po.getImg6showName()%>"/>   
					<input type="hidden" name="Img6saveName" id="Img6saveName" style="width:800px;" value="<%=po.getImg6saveName()==null?"":po.getImg6saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId6" />
					   <jsp:param name="realFileNameInputId"    value="Img6showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img6saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
            </div>
            <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>1242x2208 png</label>
                <ul>                  
                    <input type="hidden" name="Img7showName" id="Img7showName" style="width:800px;" value="<%=po.getImg7showName()==null?"":po.getImg7showName()%>"/>   
					<input type="hidden" name="Img7saveName" id="Img7saveName" style="width:800px;" value="<%=po.getImg7saveName()==null?"":po.getImg7saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                       <jsp:param name="makeYMdir"  value="no" />                     					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId7" />
					   <jsp:param name="realFileNameInputId"    value="Img7showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img7saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
                <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>750x1334 png</label>
                <ul>                  
                    <input type="hidden" name="Img8showName" id="Img8showName" style="width:800px;" value="<%=po.getImg8showName()==null?"":po.getImg8showName()%>"/>   
					<input type="hidden" name="Img8saveName" id="Img8saveName" style="width:800px;" value="<%=po.getImg8saveName()==null?"":po.getImg8saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                       <jsp:param name="makeYMdir"  value="no" />                     					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId8" />
					   <jsp:param name="realFileNameInputId"    value="Img8showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img8saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
            </div>
            <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>640x960 png</label>
                <ul>                  
                    <input type="hidden" name="Img9showName" id="Img9showName" style="width:800px;" value="<%=po.getImg9showName()==null?"":po.getImg9showName()%>"/>   
					<input type="hidden" name="Img9saveName" id="Img9saveName" style="width:800px;" value="<%=po.getImg9saveName()==null?"":po.getImg9saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId9" />
					   <jsp:param name="realFileNameInputId"    value="Img9showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img9saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
                <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>640x1136 png</label>
                <ul>                  
                    <input type="hidden" name="Img10showName" id="Img10showName" style="width:800px;" value="<%=po.getImg10showName()==null?"":po.getImg10showName()%>"/>   
					<input type="hidden" name="Img10saveName" id="Img10saveName" style="width:800px;" value="<%=po.getImg10saveName()==null?"":po.getImg10saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">  
                       <jsp:param name="makeYMdir"  value="no" />                   					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId10" />
					   <jsp:param name="realFileNameInputId"    value="Img10showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img10saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10MB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
            </div>
            </div>
            <div class="app-edit-btn"> 
                   <!-- <input type="button" class="btnButton4font" onclick="ok(0,this)" value='保存退出' name="option"/> --> 
                   <input type="button" class="btnButton4font" onclick="ok_save(this)" value='保存退出' name="option"/>                                                      
                  <a href="javascript:void(0)" class="reload"  onclick="resetDataForm(this)">重置</a>                 
            </div>
        </s:form>
    </div>
</div>
<style>
.evo-fileup-div{
	width: 570px;
	height: 80px;
	float: left; 
}
.app-info-edit .app-iedit-con div{
	clear: none; 
}
.app-info-edit .app-iedit-con div.app-edit-btn{
	clear: left; 
}
.MainFrameBox table {
 margin: 0; 
}

</style>
</body> 
<script type="text/javascript"> 

//设置表单为异步提交
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存',callbackfunction:backList});
//initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
 
function ok_save(obj){
     var isSystem='<%=isSystem%>';
     if(isSystem!=1){    
     var filename_1080=$("#Img1saveName").val();
	 var filename_720=$("#Img2saveName").val();
	 var filename_480=$("#Img3saveName").val();
	 var filename_320=$("#Img4saveName").val();
	 var filename_1536=$("#Img5saveName").val();
	 var filename_768=$("#Img6saveName").val();
	 var filename_1242=$("#Img7saveName").val();
	 var filename_750=$("#Img8saveName").val();
	 var filename_640_960=$("#Img9saveName").val();
	 var filename_640_1136=$("#Img10saveName").val();
	 
      if(filename_1080==""&&filename_1080==""&&filename_480==""&&filename_320==""
      &&filename_1536==""&&filename_768==""&&filename_1242==""&&filename_750==""
      &&filename_640_960==""&&filename_640_1136==""){
         alert("请上传图片！");
         return false; 
      }else{
         if(filename_1080==""||filename_1080==""||filename_480==""||filename_320==""
         ||filename_1536==""||filename_768==""||filename_1242==""||filename_750==""
        ||filename_640_960==""||filename_640_1136==""){      
         alert("图片没有上传完！"); 
         return false;     
      }else{      
         ok(0,obj);  
        }  
      } 
     }else{
        ok(0,obj); 
     }                     
}
function backList(){
  var isSystem='<%=isSystem%>';
  if(isSystem!=1){ 
   var imgNames='<%=imgName%>';
	  $.ajax({
			url:"<%=rootPath%>/mobilecustmenu!updateEvoUploadImg.do",
		    data:{
		        imgName:imgNames,		        
                path_adr_1080:"mobileevoImg",
		    	path_adr_720:"mobileevoImg",
		    	path_adr_480:"mobileevoImg",
		    	path_adr_320:"mobileevoImg",
		    	path_ios_1536:"mobileevoImg",
		    	path_ios_768:"mobileevoImg",
		    	path_ios_1242:"mobileevoImg",
		    	path_ios_750:"mobileevoImg",
		    	path_ios_640_960:"mobileevoImg",
		    	path_ios_640_1136:"mobileevoImg",
		    	
		        filename_adr_1080:$("#Img1saveName").val(),
		    	filename_adr_720:$("#Img2saveName").val(),
		    	filename_adr_480:$("#Img3saveName").val(),
		    	filename_adr_320:$("#Img4saveName").val(),
		    	filename_ios_1536:$("#Img5saveName").val(),
		    	filename_ios_768:$("#Img6saveName").val(),
		    	filename_ios_1242:$("#Img7saveName").val(),
		    	filename_ios_750:$("#Img8saveName").val(),
		    	filename_ios_640_960:$("#Img9saveName").val(),
		    	filename_ios_640_1136:$("#Img10saveName").val(),
		    	
		    	realname_adr_1080:$("#Img1showName").val(),
		    	realname_adr_720:$("#Img2showName").val(),
		    	realname_adr_480:$("#Img3showName").val(),
		    	realname_adr_320:$("#Img4showName").val(),
		    	realname_ios_1536:$("#Img5showName").val(),
		    	realname_ios_768:$("#Img6showName").val(),
		    	realname_ios_1242:$("#Img7showName").val(),
		    	realname_ios_750:$("#Img8showName").val(),
		    	realname_ios_640_960:$("#Img9showName").val(),
		    	realname_ios_640_1136:$("#Img10showName").val(),		    	
		    	random : new Date().getTime()
		    },
		    type:"POST",
		    contentType:"application/x-www-form-urlencoded;charset=utf-8",
		    dataType:"text",			
		    async:false,						     
		    success:function(data){		       
		    	var d = eval('(' + data + ')');		     
		        if(d.result=="0"){//0：失败  1成功。返回字符串
		    	    alert("同步到手机端的图片上传失败！");
			        //return false;		   		    	 
		    	 }else if(d.result=="1"){
		    	    alert("同步到手机端的图片上传成功！");		         
		    	 } 				 
		    }
		});	 
	}
	 //location_href("<%=rootPath%>/mobilecustmenu!mobCustMenu.action");
}
</script>
 
</html>