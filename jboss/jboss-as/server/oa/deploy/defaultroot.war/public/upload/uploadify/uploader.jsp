<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.net.ftp.FTPClient" %>
<%@ page import="com.whir.ezoffice.customForm.WorkFlowUploadFile" %>
<%@ page import="com.whir.ezoffice.netdisk.bd.NetdiskBD" %>
<%@ page import="com.whir.ezoffice.microblog.util.CutPhotoSize" %>
<%@page  import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@page  import="com.whir.common.util.CommonUtils"%>
<%@page  import="com.whir.common.util.FileType"%>
<%@page  import="java.io.InputStream"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/json;charset=UTF-8");
response.setHeader("Cache_Control", "no-cache");
if(session.getAttribute("userName")!=null){
    //门户portlet设置图片、媒体上传
    String portletSettingId = request.getParameter("portletSettingId")!=null?request.getParameter("portletSettingId"):null;
    String rootPath = com.whir.component.config.PropertiesUtil.getInstance().getRootPath();
    String domainId = session.getAttribute("domainId")!=null?session.getAttribute("domainId").toString():"0" ;
    // 磁盘绝对路径  
    String path = request.getRealPath("");
    // 模块文件夹
    String dir = request.getParameter("dir")!=null?request.getParameter("dir"):"dir";
    String makeYMdir = request.getParameter("makeYMdir")!=null?request.getParameter("makeYMdir"):"yes";
    // 年月文件夹
    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String str_date = sdf.format(now);
    String year = str_date.substring(0,4);
    String month = str_date.substring(5,7);
    // 绝对路径
    //如果dir以/开头，则不放在upload下，属于自定义上传目录
    if("/".equals(dir)||dir.indexOf("/..")>-1){
        response.sendRedirect(rootPath+"/public/messages/noright.jsp");
        return;
    }else if(dir.length() > 0 && dir.indexOf("/") == 0){
        path = (path + dir);
    }else{
        String path1 = path + "/upload/"+dir+"/";

        path = makeYMdir.equals("yes")?(path + "/upload/"+dir+"/" + year+month+"/"):(path + "/upload/"+dir+"/");

        //创建文件夹
       
        if(makeYMdir.equals("yes")){
            File file = new File(path1);
            if (file.exists()) {
                File file2 = new File(path);
                if (!file2.exists()) {
                    file2.mkdirs();
                }
            }
        }
    }
    
    String preUrl = rootPath;
    //是否为FTP上传
    boolean isFtpUpload_ = false;
    Map ftpMap = new HashMap();
    if (CommonUtils.isFtpUpload(domainId)) {
        String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
        ftpMap = com.whir.component.config.ConfigReader.getUploadMap(request.getRemoteAddr(), domainId);
        preUrl = fileServer;
        isFtpUpload_ = true;
    }
    // request中参数部分
    String isEncrypt = CommonUtils.isEncrypt(domainId);
    //customize biz import datas
    boolean isDeleteFile = true;
    if ("imp".equals(dir) || "datas".equals(dir) || "fileimport".equals(dir) || dir.indexOf("custom/ezform/ext")!=-1 || dir.indexOf("modulesext/devform")!=-1 || dir.indexOf("/form/")!=-1 || dir.indexOf("/formhandler/")!=-1) {
        isEncrypt = "0";
        isDeleteFile = false;
    }
    //相对路径
    String relative_path = makeYMdir.equals("yes")?(preUrl+"/upload/"+dir+"/"+ year+month+"/"):(preUrl+"/upload/"+dir+"/");// /defaultroot/upload/dir/201303/
    if(dir.indexOf("/") == 0){
        relative_path = preUrl+dir;
    }
    ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
    String fileName = "",sourcePath="",fileNameStr = "",json="";
    try {
        List fileList = sfu.parseRequest(request);
        String name = "";
        String extName = "";
        for (int i = 0; i < fileList.size(); i++) {
            FileItem fi = (FileItem) fileList.get(i);
            if (!fi.isFormField()) {
                name = fi.getName();
                //System.out.println("name1:"+name);
                if(name.lastIndexOf("\\")>=0){
                    name = name.substring(name.lastIndexOf("\\")+1);
                }
                //System.out.println("name2:"+name);
                if (name == null || "".equals(name.trim())) {
                    continue;
                }
                if (name.lastIndexOf(".") >= 0) {
                    extName = name.substring(name.lastIndexOf("."));
                }
                String checkExtName = ("" + extName).toLowerCase();
                //System.out.println("extName:"+checkExtName);
				 //合法后缀
				String s1="|.doc|.txt|.png|.jpeg|.gif|.bmp|.jpg|.docx|.xls|.xlsx|.xlsm|.ppt|.pptx|.pps|.wps|.mpp|" +
				".odt|.ods|.odp|.rar|.zip|.7z|.pdf|.xml|.dwg|.vsd|.eml|.msg|.ceb|.tif|" +
				".tiff|.key|.iso|.ofd|.asf|.wmv|.wav|.swf|.flv|.mp3|.mp4|.rm|.rmvb|.avi|.caf|.amr|";
				boolean b= s1.indexOf("|" + checkExtName + "|") > -1;
				  if(!b){
					 response.sendRedirect(rootPath+"/public/messages/noright.jsp");
					 return;	
				  }
                //if(",innerMailbox,information,peopleinfo,weibo,taskCenter,taskcentermodel,boardroom,govdocumentmanager,contract,forum,dossier,project,projectmodel,ptrain,workreport,goodspic,netdisk,".indexOf(","+dir+",") != -1){
               // if(dir.indexOf("/custom/ezform/ext/") == -1 && dir.indexOf("/modulesext/devform/customize/") == -1 && dir.indexOf("/modulesext/devform/workflow/") == -1 && dir.indexOf("/ezoffice/form/") == -1 && dir.indexOf("/ezoffice/formhandler/") == -1){
                    if(",.jsp,.jspx,.asp,.aspx,.bat,.cmd,.exe,.ocx,.cab,.dll,.js,.html,.htm,.php,.action,.msi,.scr,.com,.class,.jsp::$data,.eee,.wooyun".indexOf(checkExtName)!=-1){
                        continue;
                    }
                //}
                //如果dir以/开头，则保持原文件名，属于自定义上传目录
                String myRandom=new com.whir.common.util.Random().getRandom();
                if(dir.indexOf("/") == 0){
                    fileName = name;
                    myRandom = name.substring(0,name.lastIndexOf("."));
                }else{
                    fileName = myRandom + extName;
                }
                //sourcePath = (path + fileName).replaceAll("/","\\\\");
                sourcePath = (path + fileName).replaceAll("\\\\","/");
				
				 //---通过文件头文件获取文件类型--防止文件后缀名被修改上传的情况--xiehd20160707--start
				 InputStream stream =  fi.getInputStream();
				 String filetype = FileType.getFileType(stream);
                 System.out.println("=============filetype:"+filetype);
				String s2 = "|.war|.exe|.js|.jsp|.bat|.chm|.class|.mxp|.sql|.jspx|.asp|.cmd|.ocx|.com|.dll|";
				boolean b2= s2.indexOf("|." + filetype + "|") > -1; 
				if(b2){
				 System.out.println("=============filetype：文件类型非法");
					 response.sendRedirect(rootPath+"/public/messages/noright.jsp");
					 return;	
				}
				//---通过文件头文件获取文件类型--防止文件后缀名被修改上传的情况--xiehd20160707--end
				
                //保存
                File saveFile = new File(sourcePath);
                fi.write(saveFile);
                fileNameStr += fileName + ",";

                //文件大小
                int fileSize = (int)fi.getSize();//837494
                com.whir.common.util.UploadFile upFile=new com.whir.common.util.UploadFile();
                upFile.setFileSize(fileName, fileSize, dir, request, "1".equals(isEncrypt)?true:false);//upFile.getFileSize(fileName);//817.86K

                //门户portlet设置图片、媒体上传
                if(portletSettingId != null){
                    PortalPortletFilePO fpo = new PortalPortletFilePO();
                    fpo.setRealname(name);
                    fpo.setSavename(fileName);
                    fpo.setSize(fileSize+"");
                    fpo.setSortNo(new Integer(1));
                    PortalPortletSettingPO spo = new PortalPortletSettingPO();
                    spo.setPortletSettingId(new Long(portletSettingId));
                    fpo.setSettingPO(spo);
                    new PortalLayoutBD().savePortalPortletFilePO(fpo);
                }

                //生成缩略图
                String imgType = "*.jpg;*.jpeg;*.gif;*.png";
                if(imgType.indexOf(extName.toLowerCase())>0){
                    CutPhotoSize _cutPhotoSize=new CutPhotoSize();
                    //缩略图信息，格式：150x150_small;300x300
                    String thumbnail  = request.getParameter("thumbnail")!=null?request.getParameter("thumbnail"):"";
                    if(!thumbnail.equals("")){
                        String[] thumbnail_arr = thumbnail.split(";");
                        //循环数组元素
                        for(int m =0; m<thumbnail_arr.length; m++){
                            String width  = thumbnail_arr[m].substring(0,thumbnail_arr[m].indexOf("x"));
                            String height = thumbnail_arr[m].substring(thumbnail_arr[m].indexOf("x")+1,thumbnail_arr[m].indexOf("_")>0?thumbnail_arr[m].indexOf("_"):thumbnail_arr[m].length());
                            String shortName = thumbnail_arr[m].indexOf("_")>0?thumbnail_arr[m].substring(thumbnail_arr[m].indexOf("_")+1,thumbnail_arr[m].length()):thumbnail_arr[m];
                            String newFileName = myRandom+"_"+shortName+extName ;
                            String newSourcePath = (path+newFileName).replaceAll("\\\\","/");
                            //System.out.println("extName.toLowerCase():"+extName.toLowerCase());
                            if (!".gif".equals(extName.toLowerCase())) {  
                                 //System.out.println("进入scaleImage");
                                _cutPhotoSize.scaleImage(sourcePath,newSourcePath,Integer.parseInt(width),Integer.parseInt(height));
                            }else{
                                 //System.out.println("进入getGifImage");
                                _cutPhotoSize.getGifImage(sourcePath,newSourcePath,Integer.parseInt(width),Integer.parseInt(height),true); 
                            }
                            //是否为FTP上传
                            if (isFtpUpload_) {
                                WorkFlowUploadFile.buildList(dir,(dir.indexOf("/") == 0) ?"":(year + month),ftpMap.get("server").toString(),ftpMap.get("user").toString(),ftpMap.get("oriPass") + "whir?!");
                                com.whir.govezoffice.documentmanager.common.util.NewFtpClient ftpClient1 = new com.whir.govezoffice.documentmanager.common.util.NewFtpClient(
                                ftpMap.get("server").toString(),ftpMap.get("port").toString(),ftpMap.get("user").toString(),ftpMap.get("oriPass") + "whir?!",newSourcePath,newFileName, (dir.indexOf("/") == 0) ? dir:(makeYMdir.equals("yes")?(dir+"/" + year + month):(dir)));
                                ftpClient1.upload2();
                                //如果是ftp上传，删除应用下的临时附件
                                File newSaveFile = new File(newSourcePath);
                                newSaveFile.delete();
                            }
                        }
                    }
                }
                //是否为FTP上传
                if (isFtpUpload_) {
                    WorkFlowUploadFile.buildList(dir, (dir.indexOf("/") == 0) ?"":(year + month),ftpMap.get("server").toString(),ftpMap.get("user").toString(),ftpMap.get("oriPass") + "whir?!");
                    com.whir.govezoffice.documentmanager.common.util.NewFtpClient ftpClient1 = new com.whir.govezoffice.documentmanager.common.util.NewFtpClient(
                    ftpMap.get("server").toString(),ftpMap.get("port").toString(),ftpMap.get("user").toString(),ftpMap.get("oriPass") + "whir?!",sourcePath,fileName, (dir.indexOf("/") == 0) ? dir:(makeYMdir.equals("yes")?(dir+"/" + year + month):(dir)));
                    ftpClient1.upload2();
                    
                    //如果是ftp上传，删除应用下的临时附件
                    if(isDeleteFile){
                        saveFile.delete();
                    }
                }
                EncryptUtil util = new EncryptUtil();
                String dlcode = util.getSysEncoderKeyVlaue("FileName",myRandom+extName,"dir");
                json += "{id:\"\",master:\"\",dlcode:\""+dlcode+"\",file_type:\""+extName+"\",save_name:\""+myRandom+"\",file_name:\""+name.substring(0,name.lastIndexOf("."))+"\",relative_path:\""+relative_path+"\"}";
            }
        }
        //返回json字符串
        out.print(json);
    } catch (FileUploadException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>