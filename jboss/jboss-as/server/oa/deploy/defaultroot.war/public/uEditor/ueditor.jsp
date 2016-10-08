<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<SCRIPT LANGUAGE="JavaScript">
	var defaultFontSize="";
	var defaultFontFamily="";
</SCRIPT>
<script src="session.jsp"></script>
</head>
<body>
	<script id="container" name="content" type="text/plain"></script>
    <!-- 配置文件 -->
    <script type="text/javascript" src="ueditor.config.js"></script>
    <!-- 编辑器源码文件 -->
    <script type="text/javascript" src="ueditor.all.js"></script>

    <!-- 实例化编辑器 -->
    <script type="text/javascript">
        var ue = UE.getEditor('container',{
        	initialFrameHeight:500,
        	initialFrameWidth:'100%',
			//initialStyle: 'table{font-size:26px;}',//优先级高于iframeCssUrl
			iframeCssUrl: 'themes/iframe.css'
        });
    </script>
    
</body>
</html>