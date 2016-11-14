<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.whir.i18n.Resource"%> 
<%@ include file="/public/include/init.jsp"%>
<%
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<% 
  List sortList=new ArrayList();
  List sortList2=new ArrayList();
  List packageList=new ArrayList();
  List packageList2=new ArrayList();

  if(request.getAttribute("sortList")!=null){
      sortList=(java.util.List)request.getAttribute("sortList");
  }
   if(request.getAttribute("sortList2")!=null){
      sortList2=(java.util.List)request.getAttribute("sortList2");
  }

  if(request.getAttribute("packageList")!=null){
      packageList=(java.util.List)request.getAttribute("packageList");
  }

  if(request.getAttribute("packageList2")!=null){
      packageList2=(java.util.List)request.getAttribute("packageList2");
  }
%>
<div class="whir_space10"></div>
<%
if(packageList!=null&&packageList.size()>0){
	 Object[] packageObj = null;
	 Object[] processObj = null;
	 String packageName="";
	 for(int i = 0; i < packageList.size(); i ++){
		   packageName = (String) packageList.get(i);%>
			 <div  class="grayline_notop"> 
				<div class="title"><span class="left"></span><h1><%=(packageName.toUpperCase().equals("NULL") || packageName.trim().length()<1)?Resource.getValue(local,"filetransact","file.otherprocess"):packageName%></h1><span class="right"></span></div>
				<div  class="grayline_title">
					<ul class="three_column">
					 <%
					  for(int j = 0; j < sortList.size(); j ++){
						  //分类key    流程id    流程名  流程key
						  processObj = (Object[]) sortList.get(j);
						  if(packageName.equals(""+processObj[0])){ %>
						   <li><span class="ico"><img src="<%=rootPath%>/images/detail.gif" width="16" height="18" /></span>
						    <a href="#" onclick="transfer('<%=processObj[3]%>','<%=processObj[1]%>','<%=processObj[6]%>','<%=processObj[7]%>');"><%=processObj[1]%>(<label style="color:red"><%=processObj[2]%></label>)</a></li>
						  <%}
					  }
				   %>
					</ul>
					<div class="clearboth"></div>
				</div>  
		  </div>   
	<%}
 }
%>

<%
if(packageList2!=null&&packageList2.size()>0){
	 Object[] packageObj = null;
	 Object[] processObj = null;
	 String packageName="";
	 for(int i = 0; i < packageList2.size(); i ++){
		   packageName = (String) packageList2.get(i);%>
			 <div  class="grayline_notop"> 
				<div class="title"><span class="left"></span><h1><%=(packageName.toUpperCase().equals("NULL") || packageName.trim().length()<1)?Resource.getValue(local,"filetransact","file.otherprocess"):packageName%></h1><span class="right"></span></div>
				<div  class="grayline_title">
					<ul class="three_column">
					 <%
					  for(int j = 0; j < sortList2.size(); j ++){
						  //分类key    流程id    流程名  流程key
						  processObj = (Object[]) sortList2.get(j);
						  if(packageName.equals(""+processObj[0])){ %>
						   <li><span class="ico"><img src="<%=rootPath%>/images/detail.gif" width="16" height="18" /></span>
						    <a href="#" onclick="transfer('<%=processObj[3]%>','<%=processObj[1]%>');"><%=processObj[1]%>(<label style="color:red"><%=processObj[2]%></label>)</a></li>
						  <%}
					  }
				   %>
					</ul>
					<div class="clearboth"></div>
				</div>  
		  </div>   
	<%}
 }
%>
<script LANGUAGE="javascript">	
<!--
 
//用户点击分类中流程，跳转到只显示该流程的列表画面
function transfer(processID,processName,moduleId,isEzflow){
	var isViewWorkFlow=$('#isViewWorkFlow').val(); 
	//alert("tableId:"+tableId+"|moduleId:"+moduleId);
	if(moduleId !='1'){
		$("#last_processName").val(processName);
		$("#processID").val(processID);
		refreshListForm('queryForm');
		changePanle("0");
	}else{
		var openType =$('#openType').val();
		var relation =$('#relation').val();
		var noTreatment ='0';
		var from =$('#from').val();
		
		var url ='<%=rootPath%>/wfdealwith!sortInitList.action?processID='+processID+'&openType='+openType+'&relation='+relation+'&from='+from+'&isViewWorkFlow='+isViewWorkFlow+'&noTreatment='+noTreatment+'&isEzflow='+isEzflow+'';

        if($("#searchBeginDate").length>0){ 
	        url+="&searchBeginDate="+$("#searchBeginDate").val();  
        }
        if($("#searchEndDate").length>0){
		    url+="&searchEndDate="+$("#searchEndDate").val();
        }
        if($("#startUserName").length>0){
            url+="&startUserName="+$("#startUserName").val();
        }
        if($("#workDoneWithDateEnd").length>0){
		    url+="&workDoneWithDateEnd="+$("#workDoneWithDateEnd").val();
        }
        if($("#workDoneWithDateBegin").length>0){
		    url+="&workDoneWithDateBegin="+$("#workDoneWithDateBegin").val();
        }
        if($("#search_attention").length>0){
		    url+="&search_attention="+$("#search_attention").val();
        }
        if($("#submitOrg").length>0){
		    url+="&submitOrg="+$("#submitOrg").val();
        }
        if($("#workTitle").length>0){
		    url+="&workTitle="+$("#workTitle").val();
        }
        if($("#pressDeal").length>0){
	        url+="&pressDeal="+$("#pressDeal").val();
        }


		if(from =='hrm'){
			var underUserId =$('#underUserId').val();
			url += "&underUserId="+underUserId;

			var employeeId =$('#employeeId').val();
			url += "&employeeId="+employeeId;
		}
		url = encodeURI(url);
		//alert(url);
		location_href(url);
	}
}
 
//-->
</script>
 