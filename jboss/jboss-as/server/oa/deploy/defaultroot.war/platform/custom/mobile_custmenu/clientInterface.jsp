<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>移动OA管理</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    
</head>

<body class="Pupwin"> 
<div class="BodyMargin_10">
    <div class="docBoxNoPanel">

        <s:form name="dataForm" id="dataForm" action="/UnitSet!update.action" method="post">
        <%@ include file="/public/include/form_detail.jsp"%>
        <table width="100%" class="Table_bottomline" border="0" cellpadding="0" cellspacing="0">
        	<tr>
        	<td style="padding:15px;">
           <table>
           <tr>
                <td for="移动客户端管理"class="td_lefttitle" width="100">移动客户端管理</td>
                <td></td>
            </tr>
           
             <tr>
                <td for="系统LOGO" class="td_lefttitle" valign="top">evo服务器地址：</td>
                <td>
                    <s:textfield id="ipAdress" name="ipAdress" cssClass="inputText" size="40" whir-options="vtype:['notempty']"  style="width:300px"/>
                    <s:textfield id="portNum" name="portNum" cssClass="inputText" size="40" whir-options="vtype:['notempty']"  style="width:80px"/>
				    <input type="button" class="btnButton4font" onclick="enterManager()" value="进入管理" style="vertical-align: middle;"/>
                                   
                </td>
            </tr>
            </table>
            <hr />
            </td>
            </tr>
            <tr>
            <td style="padding:15px;">
            <table>
           <tr>
                <td for="微信企业号管理"class="td_lefttitle" width="100">微信企业号管理</td>
                <td></td>
            </tr>
           <tr>
                <td for="系统LOGO" class="td_lefttitle" valign="top">初始化管理页：</td>
                <td>
                    <s:textfield id="enterpriseNumber" name="enterpriseNumber" cssClass="inputText" size="40" whir-options="vtype:['notempty']" style="width:50%"/>                   
				    <input type="button" class="btnButton4font" onclick="gotoInit()" value="初始化" style="vertical-align: middle;"/>                                  
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <div style="margin-top:5px;"></div>
                </td>
            </tr>
            </table>
            </td>
            </tr>
        </table>
        </s:form>

	 </div>
</div>
</body>
<script type="text/javascript">

function enterManager(){
    
}

function gotoInit(){
     
}
</script>
</html>
 