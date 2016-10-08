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
            <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
             <tr>  
                <td for="应用名称" class="td_lefttitle" style="padding-left: 0px; padding-right: 12px;">  
                                       应用名称<span class="MustFillColor">*</span>：
                </td>  
                <td>  
                 <input type="text" name="mobileMenuDisplayName"  onkeyup="value=value.substr(0,80);"  whir-options="vtype:['notempty',{'maxLength':80}]"  maxlength="80" class="inputText" style="width:444px;" value="<%=po.getMobileMenuDisplayName()==null||"null".equals(po.getMobileMenuDisplayName())?"":po.getMobileMenuDisplayName()%>"/>
                 <input type="hidden" name="mobileId" value="<%=po.getMobileId()%>"/>
                </td>  
            </tr>  
            <tr>  
                <td for="排序" class="td_lefttitle" style="padding-left: 0px;padding-right: 12px;">  
                                      排序<span class="MustFillColor">*</span>：
                </td>  
                <td>  
                 <input type="text" name="mobileMenuOrder"  whir-options="vtype:['notempty','p_integer_e']"  maxlength="10" class="inputText" style="width:150px;" value="<%=po.getMobileMenuOrder()%>"/>
                </td>  
            </tr> 
            <tr>  
                <td class="td_lefttitle" style="padding-left: 0px;padding-right: 12px;">  
                                           适用范围 ： 
                </td>  
                <td>  
                <input type="hidden" id="mobileMenuScopeIds" name="mobileMenuScopeIds" value="<%=po.getMobileMenuScopeIds()==null||"null".equals(po.getMobileMenuScopeIds())?"":po.getMobileMenuScopeIds()%>"/>
                <textarea class="inputTextarea" style="width:444px;" id="mobileMenuScope" name="mobileMenuScope" readonly="readonly"><%=po.getMobileMenuScope()==null||"null".equals(po.getMobileMenuScope())?"":po.getMobileMenuScope()%></textarea>
                <a href="javascript:void(0);" class="selectIco textareaIco"  onClick="openSelect({allowId:'mobileMenuScopeIds', allowName:'mobileMenuScope', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',limited:'1'});"></a>  
                </td>  
            </tr> 
            <tr>  
                <td class="td_lefttitle" style="padding-left: 0px;padding-right: 12px;" >  
                                         是否启用： 
                </td>  
                <td>  
                 <label class="isuse"><input name="mobileMenuIsUse" type="radio" value="1" <%if("1".equals(po.getMobileMenuIsUse()+"")){%>checked="checked"<%}%>/>&nbsp;是 </label>
                 <label class="isuse"><input name="mobileMenuIsUse" type="radio" value="0" <%if("0".equals(po.getMobileMenuIsUse()+"")){%>checked="checked"<%}%>/>&nbsp;否 </label>
                </td>  
            </tr> 
      
          </table>  
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
                <label>1.44*44 png</label>
                <ul>                  
                    <input type="hidden" name="Img1showName" id="Img1showName" style="width:800px;" value="<%=po.getImg1showName()==null?"":po.getImg1showName()%>"/>   
					<input type="hidden" name="Img1saveName" id="Img1saveName" style="width:800px;" value="<%=po.getImg1saveName()==null?"":po.getImg1saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId1" />
					   <jsp:param name="realFileNameInputId"    value="Img1showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img1saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="8" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10KB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div> 
               <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>2.57*57 png</label>
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
					   <jsp:param name="fileSizeLimit"        value="10KB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
            </div>  
            <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>3.96*96 png</label>
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
                <label>4.114*114 png</label>
                <ul>                  
                    <input type="hidden" name="Img4showName" id="Img4showName" style="width:800px;" value="<%=po.getImg4showName()==null?"":po.getImg4showName()%>"/>   
					<input type="hidden" name="Img4saveName" id="Img4saveName" style="width:800px;" value="<%=po.getImg4saveName()==null?"":po.getImg4saveName()%>"/> 
                       <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                       <jsp:param name="makeYMdir"  value="no" />                    					     
					   <jsp:param name="dir"      value="mobileevoImg" />
					   <jsp:param name="uniqueId"    value="formId4"/>
					   <jsp:param name="realFileNameInputId"    value="Img4showName" />
					   <jsp:param name="saveFileNameInputId"    value="Img4saveName" />
					   <jsp:param name="canModify"   value="yes" />
					   <jsp:param name="width"        value="70" />
					   <jsp:param name="height"       value="10" /> 
				       <jsp:param name="multi"        value="false" />
				       <jsp:param name="buttonClass" value="upload_btn" />
				       <jsp:param name="buttonText"       value="上传" />
					   <jsp:param name="fileSizeLimit"        value="10KB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
              
            <div class="evo-app-icon evo-fileup-div clearfix">
                <label></label>
                <label>5.144*144 png</label>
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
					   <jsp:param name="fileSizeLimit"        value="10KB" />
					   <jsp:param name="fileTypeExts"		 value="*.png" />
					   <jsp:param name="uploadLimit"      value="1" />
			           </jsp:include>
                          
                </ul>
                </div>
                                 
            </div>
            <div class="app-edit-btn"> 
                   <!-- <input type="button" class="btnButton4font" onclick="ok(0,this)" value='保存退出' name="option"/> --> 
                   <input type="button" class="btnButton4font" onclick="ok_save(this)" value='保存退出' name="option"/>
                   <input type="button" class="btnButton4font" onclick="resetDataForm(this)" value='&nbsp;重    置&nbsp;' name="option"/>
                   <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='&nbsp;退   出&nbsp;' name="option"/>                                                                                                                                                     
                               
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

.app-info-edit .app-iedit-con div.app-edit-btn {
    height: 30px;
    padding-left: 87px;
    text-align: left;
}
.textareaIco {
    margin-top: 74px;
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
   
	 var filename_480=$("#Img1saveName").val();
	 var filename_720=$("#Img2saveName").val();
	 var filename_750=$("#Img3saveName").val();
	 var filename_1080=$("#Img4saveName").val();
	 var filename_1242=$("#Img5saveName").val();
	 
      if(filename_480!=""||filename_720!=""||filename_750!=""||filename_1080!=""||filename_1242!=""){
          if(filename_480==""||filename_720==""||filename_750==""||filename_1080==""||filename_1242==""){      
                alert("图片没有上传完！"); 
                return false;     
      }else{      
         ok(0,obj);  
        }  
    
     }else{
        $("#imgName").val("");       
        ok(0,obj); 
     }                     
   }else{
      ok(0,obj); 
   }
}
function backList(){
  var isSystem='<%=isSystem%>';
  var nam=$("#imgName").val();   
  if(isSystem!=1){
   if(nam!=""){  
	  $.ajax({
			url:"<%=rootPath%>/mobilecustmenu!updateEvoUploadImg.action",
		    data:{
		        imgName:nam,		        
                path_adr_1080:"mobileevoImg",
		    	path_adr_720:"mobileevoImg",
		    	path_adr_480:"mobileevoImg",		    	 
		    	path_ios_1242:"mobileevoImg",
		    	path_ios_750:"mobileevoImg",		     
		    	
		        filename_adr_480:$("#Img1saveName").val(),
		    	filename_adr_720:$("#Img2saveName").val(),
		    	filename_ios_750:$("#Img3saveName").val(),
		    	filename_adr_1080:$("#Img4saveName").val(),
		    	filename_ios_1242:$("#Img5saveName").val(),		    	 
		    	
		    	realname_adr_480:$("#Img1showName").val(),
		    	realname_adr_720:$("#Img2showName").val(),
		    	realname_ios_750:$("#Img3showName").val(),
		    	realname_adr_1080:$("#Img4showName").val(),
		    	realname_ios_1242:$("#Img5showName").val(),		    	 		    	
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
  }
	 //location_href("<%=rootPath%>/mobilecustmenu!mobCustMenu.action");
}
</script>
 
</html>