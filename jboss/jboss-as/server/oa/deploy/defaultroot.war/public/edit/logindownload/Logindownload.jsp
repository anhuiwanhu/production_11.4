<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.common.util.UploadFile"%>
<%@ page import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ page import="java.io.FileInputStream"%>
<%@ page import="java.io.BufferedInputStream"%>
<%@ page import="java.io.File"%>


<%
String rootPath = com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
	
	String local = session.getAttribute("org.apache.struts.action.LOCALE")!=null?session.getAttribute("org.apache.struts.action.LOCALE").toString():"zh_CN";
	request.setCharacterEncoding("UTF-8");
   	String FileName =request.getParameter("fileName");
	// String path = request.getContextPath() +"/activex.msi";  
       if("activex.msi".equals(FileName)){  
        File pdfFile = new File(request.getRealPath("/").concat(  
            "/").replace("\\", "/")  +FileName );  
        response.setContentType("application/msi");  
        response.setContentType("application/force-download");  
        response.addHeader(  
                "Content-Disposition","attachment; filename=\"" +FileName+"\"" );  
        response.setContentLength( (int) pdfFile.length( ) );  
          
        FileInputStream input = new FileInputStream(pdfFile);  
        BufferedInputStream bufferedInputStream = new BufferedInputStream(input);  
        int readBytes = 0;  
        while((readBytes = bufferedInputStream.read( )) != -1)  
               response.getOutputStream().write(readBytes); 
	  }
	/*UploadFile upFile = new UploadFile();
	String encrypt = upFile.getFileEncrypt(FileName);	
	String path="/defaultroot";
	
	response.setContentType("application/x-download");
	
	response.addHeader("Content-Disposition", "attachment;filename=\"" +FileName+"\"");
	try {
	    if("1".equals(encrypt)){
	        out.clearBuffer();
	        upFile.decryptFile(request.getRealPath(path + "/" + FileName), response.getOutputStream(), true);
	    }else{
	        out.clearBuffer();
	        upFile.decryptFile(request.getRealPath(path + "/" + FileName), response.getOutputStream(), false);
	    }
	} catch(Throwable e) {
	  	e.printStackTrace();
	} finally {
	  	response.flushBuffer();
	}*/
%>