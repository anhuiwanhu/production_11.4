<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.netdisk.po.NetDiskPO" %>
<%@ page import="com.whir.component.security.crypto.EncryptUtil" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
    NetDiskPO netdiskPO=request.getAttribute("netdiskPO")!=null?(NetDiskPO)request.getAttribute("netdiskPO"):null;
%>
<head>  
    <title><%=netdiskPO.getFileSaveName()!=null?netdiskPO.getFileSaveName():""%></title>  
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base.jsp"%>
    <%@ include file="/public/include/meta_detail.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件--> 
    <link rel="stylesheet" type="text/css" href="<%=rootPath%>/modules/personal/netdisk/netdisk.css" />
    <script type="text/javascript" src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/PersonalworkResource.js" ></script> 
</head>
<body class="Pupwin">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td align="center" valign="middle">
             <table width="90%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="10">&nbsp;</td>
                </tr>
              </table>

              <table width="96%" height="96%" border="0" cellpadding="0" cellspacing="0">
                <!-- 最上面的 _|   |_  样式显示 start-->
                <tr>
                    <td bgcolor="#FFFFFF">
                        <table width="96%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="22" height="40" valign="bottom">
                                    <table width="22" height="22" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td width="1" rowspan="2" bgcolor="8A9AA2"></td>
                                        </tr>
                                        <tr>
                                            <td height="1" bgcolor="8A9AA2"></td>
                                        </tr>
                                    </table>
                                </td>
                                <td>&nbsp;</td>
                                <td width="22" valign="bottom">
                                    <table width="22" height="22" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="1" rowspan="2" bgcolor="8A9AA2"></td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td height="1" bgcolor="8A9AA2"></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <!-- 最上面的 _|   |_  样式显示 end-->
                            <tr>
                                <td>&nbsp;</td>
                                <td valign="top">
                                    <table width="98%" border="0" align="center" cellpadding="1" cellspacing="1">
                                        <tr>
                                            <td colspan="2" align="center" class=big0></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" valign="top" align="center">
                                                <font class="fileSaveName"><%=netdiskPO.getFileSaveName()!=null?netdiskPO.getFileSaveName():""%></font>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" valign="top">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" valign="top" style="word-break:break-all;">
                                            <%
                                                String _fileContent = netdiskPO.getFileContent()!=null?netdiskPO.getFileContent():"";
                                                //_fileContent = _fileContent.replaceAll("\r\n","<br>");
  												if(netdiskPO.getFileType()==3){
                                                 	_fileContent = _fileContent.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
                                                }
                                            %>
                                                <%out.print(_fileContent);%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <!-- 最下面的 -|   |-  样式显示 start-->
                <tr>
                    <td bgcolor="#FFFFFF">
                        <table width="96%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="22" height="40" valign="bottom">
                                    <table width="22" height="22" border="0" cellpadding="0" cellspacing="0">
                                        <tr bgcolor="8A9AA2">
                                            <td height="1" colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td width="1" bgcolor="8A9AA2"></td>
                                        </tr>
                                    </table>
                                </td>
                                <td>&nbsp;</td>
                                <td width="22" valign="bottom">
                                    <table width="22" height="22" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td height="1" colspan="2" bgcolor="8A9AA2"></td>
                                        </tr>
                                        <tr>
                                            <td width="1" bgcolor="8A9AA2"></td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <!-- 最下面的  -|   |-  样式显示 end-->
                <tr>
                    <td height="10" bgcolor="#FFFFFF">&nbsp;</td>
                </tr>
            </table>

            <table width="90%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td height="20">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>

<script type="text/javascript">
</script>
</html>