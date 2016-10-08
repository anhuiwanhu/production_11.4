<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.basedata.po.UnitInfoPO"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

UnitInfoPO unitInfo;
String unitName="";
String unitImgName="",unitImgSaveName="",unitId="";

String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
//java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(session.getAttribute("domainId").toString());
int smartInUse = 0;
if(sysMap != null && sysMap.get("附件上传") != null){
	smartInUse = Integer.parseInt(sysMap.get("附件上传").toString());
}
String path = smartInUse == 1 ? rootPath : fileServer;
String src = path + "/upload/desktop/";

unitImgName="desktop.png";
unitImgSaveName="desktop.png";

String unitImgSaveName_ = request.getAttribute("unitImgSaveName")!=null?request.getAttribute("unitImgSaveName")+"":unitImgSaveName;

src += unitImgSaveName_;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>界面设置</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <style type="text/css">
    .imgPhoto{
        margin-top:-25px;padding-top:3px;float:right;height:19px;width:94px;background:#fff;border:1px solid #808080;text-align:center;cursor:pointer;
    }
    </style>
    <!--[if IE 6]>
    <style type="text/css">
    .imgPhoto{margin-top:-20px;}
    </style>
    <![endif]-->
</head>

<body class="Pupwin"><!--MainFrameBox-->
<div class="BodyMargin_10">
    <div class="docBoxNoPanel">

        <s:form name="dataForm" id="dataForm" action="/UnitSet!update.action" method="post">
        <%@ include file="/public/include/form_detail.jsp"%>
        <table width="100%" class="Table_bottomline" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td for="系统名称"class="td_lefttitle" width="100">系统名称<span class="MustFillColor">*</span>：</td>
                <td>
                    <s:textfield id="unitName" name="unitName" cssClass="inputText" size="40" maxlength="30" whir-options="vtype:['notempty']" style="width:60%"/>
                </td>
            </tr>
            <tr>
                <td for="版权信息"class="td_lefttitle" width="100">版权信息：</td>
                <td>
                    <s:textfield id="copyRights" name="copyRights" cssClass="inputText" size="100" maxlength="100" whir-options="vtype:['notempty']" style="width:60%"/>
                </td>
            </tr>
            <tr>
                <td for="系统LOGO" class="td_lefttitle" valign="top">企业LOGO<span class="MustFillColor">*</span>：</td>
                <td>
                    <s:textfield id="unitImgName" name="unitImgName" cssClass="inputText" size="40" whir-options="vtype:['notempty']" readonly="true" style="width:60%"/>
                    <s:hidden id="unitImgSaveName" name="unitImgSaveName"/>
				    <input type="button" class="btnButton4font" onclick="javascript:setDefault();" value="恢复默认"/>
                    <div><span class="MustFillColor" style="padding-left:0;">建议：LOGO尺寸高度请勿超出50px，格式为png。</span></div>
                    <div style="width:214px;">
                        <div style="float:left;width:120px;padding-top:5px;">
                        <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
                            <jsp:param name="onInit" value="" />
                            <jsp:param name="onSelect" value="" />

                            <jsp:param name="onUploadSuccess" value="showIMG" />
                            <jsp:param name="isShowBatchDownButton" value="no" />

                            <jsp:param name="accessType" value="include" />
                            <jsp:param name="makeYMdir" value="no" />
                            <jsp:param name="dir" value="desktop" />
                            <jsp:param name="uniqueId" value="uniqueId_unitImgName" />
                            <jsp:param name="realFileNameInputId" value="unitImgName" />
                            <jsp:param name="saveFileNameInputId" value="unitImgSaveName" />
                            <jsp:param name="canModify" value="yes" />
                            <jsp:param name="width" value="90" />
                            <jsp:param name="height" value="20" />
                            <jsp:param name="multi" value="false" />
                            <jsp:param name="buttonClass" value="upload_btn" />
                            <jsp:param name="buttonText" value="上传图片" />
                            <jsp:param name="fileSizeLimit" value="5MB" />
                            <jsp:param name="fileTypeExts" value="*.jpg;*.jpeg;*.gif;*.png;" />
                            <jsp:param name="uploadLimit" value="0" />
                        </jsp:include>
                        </div>
                        <div class="imgPhoto" onclick="clearImg();">删除图片</div>                   
                    </div>                    
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <div style="margin-top:5px;"><img id="ImgShow" src="<%=src%>"></div>
                </td>
            </tr>
            <tr class="Table_nobttomline">
                <td>&nbsp;</td>
			    <td>
				    <input type="button" class="btnButton4font" onclick="ok(0,this);" value="<s:text name="comm.save"/>"/>
				    <input type="button" class="btnButton4font" onclick="javascript:location.reload();" value="<s:text name="comm.reset"/>"/>
			    </td>
		    </tr>
        </table>
        </s:form>

	 </div>
</div>
</body>
<script type="text/javascript">
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//设置表单为异步提交  
initDataFormToAjax({
    "dataForm": 'dataForm',
    "queryForm": '',
    "tip": '<s:text name="comm.interfacesettings"/>'
});

//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
</script>
</html>
<script language="javascript">
$(document).ready(function(){
    //showIMG();
});

function showIMG(json){
    var flag = false;
	$('#ImgShow').attr("src", "<%=path%>/upload/desktop/"+json.save_name+json.file_type).load(function() {
        var fileOffsetWidth = this.width;
        var fileOffsetHeight = this.height;
        if(flag == false){            
            //alert(fileOffsetWidth + "X" + fileOffsetHeight);
            flag = true;

            if(99>fileOffsetWidth || 19>fileOffsetHeight){
                whir_confirm("系统推荐上传的图片尺寸为265X56，而您上传的图片大小为"+fileOffsetWidth+"X"+fileOffsetHeight+"，可能导致显示不正常！您确定重新上传吗？", function(){
                    clearImg();
                },
                function(){
                });
            }else if(101<fileOffsetWidth || 21<fileOffsetHeight){
                whir_confirm("系统推荐上传的图片尺寸为265X56，而您上传的图片大小为"+fileOffsetWidth+"X"+fileOffsetHeight+"，可能导致显示不正常！您确定重新上传吗？", function(){
                    clearImg();
                },
                function(){
                });
            }
        }
    });
    $('#unitImgName').val(json.file_name+json.file_type);
    $('#unitImgSaveName').val(json.save_name+json.file_type);
}

function setDefault(){
    $('#unitImgName').val('desktop.png');
    $('#unitImgSaveName').val('desktop.png');
	$('#ImgShow').attr("src","<%=path%>/upload/desktop/"+$('#unitImgSaveName').val());
}

function clearImg(){
    $('#ImgShow').attr('src','<%=rootPath%>/images/blank.gif');
    $('#unitImgName').val('');
    $('#unitImgSaveName').val('');
}
</script>