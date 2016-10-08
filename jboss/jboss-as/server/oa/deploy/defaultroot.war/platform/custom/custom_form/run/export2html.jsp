<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<%
String title = request.getParameter("title")!=null?request.getParameter("title"):"导出HTML格式";
response.setHeader("Content-disposition", "attachment;filename="+com.whir.component.util.SystemUtils.encodeName(title, request)+".html");
String content = request.getParameter("content");
%>
<head>
<meta http-equiv=Content-Type content="text/html; charset=utf-8">
<style type="text/css">
html,body {
    padding: 0px;
    font-family:"微软雅黑";	
}
body {
	font-family:"微软雅黑";
    margin: 0px;
	font-family:"Microsoft YaHei","微软雅黑";
    background: #ffffff;
	font-size:12px;
}
table{
    margin:0 auto;
}
td,div,p,font,option,label,li {
    line-height: 150%;
	font-size:12px;
}
div{
    font-size:14px;
    text-align:left;
}
/*带标题模板*/
.templateBox{ clear:both; width:98%;}
.templateBox .templateBoxline{ border:1px solid #dcdcdc; padding:0 20px; margin:0; min-height: 100px;  height: auto !important;  height: 100px;}
.templateBox .templateTitle{ height:28px; line-height:28px; font-weight:bold; color:#000; font-size:12px; margin:0; padding:0 15px;}
.templateBox .templateContent{
    width:100%;
    border-collapse: collapse;
    clear: both;
    display: table;
    border-spacing: 0;
    table-layout: auto;
}

.relationObjDiv{
    width:98%;
    float:left;
    margin:5px;
    /*display:inline;*/
    display: table-cell;
    vertical-align: top;
}

.templateBox .templateContent .relationObjDiv_outter{
    width:49%;
    float:left;
}

.dataDiv{
}
</style>
</head>
<body>
<div>
<%=content%>
</div>
</body>
</html>