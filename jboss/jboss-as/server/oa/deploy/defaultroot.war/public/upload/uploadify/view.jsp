<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
String path=request.getParameter("path"); 
String filename = request.getParameter("fileName");
String datePath = filename.substring(0,6);
String filename_lower = filename.toLowerCase();

datePath="/"+datePath; 
if(path!=null&&path.equals("mobileevoImg")){
	datePath="";
}
%>
<html>
<title>图片预览</title>
<script type="text/javascript">
<!--
function resizeWin(w,h){
    window.resizeTo(w,h);
    var t=0;
    var l=0;
    l=(screen.width-w)/2;
    t=(screen.height-h)/2;
    window.moveTo(l,t);
}
//-->
</script>
<body onload="resizeWin(screen.width,screen.height);">
<%if(filename_lower.indexOf(".jpg")!=-1 || filename_lower.indexOf(".png")!=-1 || filename_lower.indexOf(".gif")!=-1 || filename_lower.indexOf(".jpeg")!=-1 || filename_lower.indexOf(".bmp")!=-1){%>
<img src="<%=fileServer%>/upload/<%=path%><%=datePath%>/<%=filename%>">
<%}%>
</body>
</html>