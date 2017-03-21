<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="java.io.*"%>
<%@ page import="jxl.Workbook"%>
<%@ page import="jxl.Sheet"%>
<%@ page import="jxl.Cell"%>
<%@ page import="jxl.NumberCell"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
String separator = System.getProperty("file.separator");
String path = request.getParameter("path");
int col = Integer.parseInt(request.getParameter("col"));
String showType = request.getParameter("fieldShow");
String fieldType = request.getParameter("fieldType");
String[] _showArr = showType.split(",");
String[] _typeArr = fieldType.split(",");

String uploadFolder = request.getRealPath("/upload/"+path+"/");
File uploadPath = new File(uploadFolder);//上传文件目录
if (!uploadPath.exists()) {
    uploadPath.mkdirs();
}
File tempPathFile = new File(uploadFolder);// 临时文件目录
if (!tempPathFile.exists()) {
    tempPathFile.mkdirs();
}
DiskFileItemFactory factory = null;
File file = null;
String data = "[";
try {
    factory = new DiskFileItemFactory();
    factory.setSizeThreshold(1024*4); // 设置缓冲区大小4kb
    factory.setRepository(tempPathFile);//设置缓冲区目录
    ServletFileUpload upload = new ServletFileUpload(factory);
    upload.setSizeMax(1024*1024*100); // 设置最大文件尺寸50MB
    List items = upload.parseRequest(request);//得到所有的文件
    Iterator i = items.iterator();
    if (i.hasNext()) {
        FileItem fi = (FileItem) i.next();
        String fileName = fi.getName();
        if (fileName != null) {
            if(fileName.lastIndexOf(separator)!=-1){
                fileName = fileName.substring(fileName.lastIndexOf(separator)+1);
            }
            String myRandom=new com.whir.common.util.Random().getRandom();
            String ext = fileName.indexOf(".")!=-1?fileName.substring(fileName.lastIndexOf(".")):"";
            String newFileName = myRandom+ext;
            File fullFile = new File(fi.getName());
            String datePath = "";
            datePath = "/" + myRandom.substring(0,6);
            File uploadDatePath = new File(uploadFolder+datePath);
            if (!uploadDatePath.exists()) {
                uploadDatePath.mkdirs();
            }
            File savedFile = new File(uploadFolder+datePath, newFileName);
            fi.write(savedFile);
            int fileSize = (int)fi.getSize();
            String _fn = myRandom+ext;

            //System.out.println(request.getContextPath()+"/upload/"+path+"/"+filename);
            file = new File(request.getRealPath("/upload/" + path + "/" + datePath) + "/" + _fn);
            if (file != null && file.isFile()) {
                InputStream in = new FileInputStream(file);
                jxl.Workbook rwb = Workbook.getWorkbook(in);

                Sheet sheet = rwb.getSheet(0);
                //列数
                int colCount = sheet.getColumns();
                //行数
                int rowCount = sheet.getRows();
                List list = new ArrayList();
                System.out.println("行："+rowCount+"列："+colCount);
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                SimpleDateFormat sdf3 = new SimpleDateFormat("HH:mm");
                for (int row = 1; row < rowCount; row++) {
                    int k=0;

                    if(row>1)data += ",";
                    data += "[";
                    for(int j=0; j<col; j++){
                        if(j>0)data += ",";
                        data += "\"";
                        if("108".equals(_showArr[j])){
                            if(sheet.getCell(k,row).getType() == jxl.CellType.DATE){
                                jxl.DateCell datec11 = (jxl.DateCell)sheet.getCell(k++, row);
                                Date date = datec11.getDate();
                                sdf3.setTimeZone(TimeZone.getTimeZone("GMT"));
                                data += sdf3.format(date);
                            }else{
                                String tempData = ((Cell) sheet.getCell(k++, row)).getContents();
                                if(tempData != null && !"".equals(tempData) && !"null".equals(tempData)){
                                    tempData = tempData.trim();
                                    sdf3.parse(tempData);
                                }
                                data += tempData;
                            }
                        }else if("107".equals(_showArr[j]) || "204".equals(_showArr[j])){
                            if(sheet.getCell(k,row).getType() == jxl.CellType.DATE){
                                jxl.DateCell datec11 = (jxl.DateCell)sheet.getCell(k++, row);
                                Date date = datec11.getDate();
                                sdf.setTimeZone(TimeZone.getTimeZone("GMT"));
                                data += sdf.format(date);
                            }else{
                                String tempData = ((Cell) sheet.getCell(k++, row)).getContents();
                                if(tempData != null && !"".equals(tempData) && !"null".equals(tempData)){
                                    tempData = tempData.trim();
                                    sdf.parse(tempData);
                                }
                                data += tempData;
                            }
                        }else if("109".equals(_showArr[j]) || "703".equals(_showArr[j])){
                            if(sheet.getCell(k,row).getType() == jxl.CellType.DATE){
                                jxl.DateCell datec11 = (jxl.DateCell)sheet.getCell(k++, row);
                                Date date = datec11.getDate();
                                sdf2.setTimeZone(TimeZone.getTimeZone("GMT"));
                                data += sdf2.format(date);
                            }else{
                                String tempData = ((Cell) sheet.getCell(k++, row)).getContents();
                                if(tempData != null && !"".equals(tempData) && !"null".equals(tempData)){
                                    tempData = tempData.trim();
                                    sdf2.parse(tempData);
                                }
                                data += tempData;
                            }
                        }else{
                           String tempData = ((Cell) sheet.getCell(k++, row)).getContents();
							String reg = "^[+-]?\\d+(\\.\\d+)?$";
							if(tempData.matches(reg)){
								NumberCell numberCell = (NumberCell)sheet.getCell(k-1, row);
								double namberValue = numberCell.getValue();
								tempData = namberValue+"";
								if(tempData.indexOf(".")!=-1){
									if(Long.valueOf(tempData.split("\\.")[1])==0){
										tempData = tempData.split("\\.")[0];
									}
								}
								if(tempData!=null){
									tempData = tempData.replaceAll("\"", "\\\\\\\"");//"\\\\\\\\\\\\\"");
									tempData = tempData.replaceAll("\r|\n", "");
								}
								data += tempData;
							}else{
								if(tempData != null && !"".equals(tempData) && !"null".equals(tempData)){
									if("number".equals(_typeArr[j])){
										Double.parseDouble(tempData);//校验数值型
									}
								}
								if(tempData!=null){
									tempData = tempData.replaceAll("\"", "\\\\\\\"");//"\\\\\\\\\\\\\"");
									tempData = tempData.replaceAll("\r|\n", "");
								}
								data += tempData;
							}
                        }
                        data += "\"";
                    }
                    data += "]";
                }
                rwb.close();
                in.close();
            }
            data += "]";
%>
<script language="JavaScript">
<!--
    parent.document.getElementById('fileUrl').value='';
    parent.fillData(<%=data%>);
    alert('导入成功');
    parent.window.close();
//-->
</script>
<%
        }
    }
} catch (NumberFormatException e) {
    e.printStackTrace();
%>
<script language="JavaScript">
<!--
    parent.document.getElementById('fileUrl').value='';
    alert('导入数值类型错误');
    parent.window.close();
//-->
</script>
<%
} catch (ParseException e) {
    e.printStackTrace();
%>
<script language="JavaScript">
<!--
    parent.document.getElementById('fileUrl').value='';
    alert('日期类型格式错误');
    parent.window.close();
//-->
</script>
<%
} catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript">
<!--
    parent.document.getElementById('fileUrl').value='';
    alert('导入失败');
    parent.window.close();
//-->
</script>
<%
} finally{
    if(file!=null){
        file.delete();
    }
    factory = null;
}
%>