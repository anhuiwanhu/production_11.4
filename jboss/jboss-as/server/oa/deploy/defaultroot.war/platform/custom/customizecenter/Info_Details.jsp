<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.org.manager.bd.*"%>
<%@ page import="com.whir.common.util.CommonUtils" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.common.CustomerCenterConfig" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.po.*" %>
<%@ page import="com.whir.ezoffice.customize.customerCenter.bd.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  

<%
  String tableName = (String)request.getAttribute("tableName");

  String TableId = request.getParameter("TableId");
  String CENTERID = request.getParameter("CENTERID");
  String ModClassId = request.getParameter("ModClassId");
  String rightscope = request.getParameter("rightscope");
  String rightcodemanage = request.getParameter("rightcodemanage");
  String user_Name = (String)request.getAttribute("userName");// 11.4补丁文档 2016-05-04 添加
  List allFieldList = (List)request.getAttribute("allFieldList");
  Map valueMap = (Map)request.getAttribute("valueMap");

 CustomerInfoBD bd = new CustomerInfoBD();
 CustomerHtmlBD hbd = new CustomerHtmlBD();
 String fieldvalue = "";
 String fieldid = "";
 String fielddesname = "";
 String fieldname  = "";
 String fieldtype = "";
 String fieldshow = "";
 String fieldonly = "";

 String InfoId =  request.getParameter("InfoId");

 ManagerBD managerBD = new ManagerBD();
 boolean right1 = false;
 if(managerBD.hasRight(CommonUtils.getSessionUserId(request)+"", rightcodemanage)){
		right1=true;
  }

%>
<head>  
	<title>客户信息详细</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%> 
	<%@ include file="/public/include/meta_detail.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/WorkflowResource.js" type="text/javascript"></script>
	<SCRIPT language=javascript src="<%=rootPath%>/platform/custom/custom_form/run/js/form.js"></SCRIPT>
	<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>
</head>  
  
<body class="Pupwin" >  
	<div class="BodyMargin_10">    
		<div class="docBoxNoPanel">  
		<s:form name="dataForm" id="dataForm" method="post" theme="simple" >  
		<%@ include file="/public/include/form_detail.jsp"%>

		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">  
		  <input type="hidden" name="user_Name" id="user_Name" value="<%=user_Name%>"> 
		   <%
		     //列宽
		     int _listsize= 0;
			 //第一行列数
		     int _lists = 0;
	         for(int i=0;i<allFieldList.size();i++){
                List _list = (List) allFieldList.get(i);
           %>
                <tr>
           <%
			    if(i==0)  {
			     _listsize=(100-_list.size()*6)/_list.size();
				 _lists = _list.size();
				}
                for(int j=0;j<_list.size();j++){

                    List __list = (List) _list.get(j);
                    fieldvalue = (String) __list.get(0);
                    fieldid = (String) __list.get(1);
	                fielddesname = (String) __list.get(3);
	                fieldname  = (String) __list.get(4);
	                fieldtype = (String) __list.get(6);
	                fieldshow = (String) __list.get(9);
	                fieldonly = (String) __list.get(10);
				    String[] pama = new String[10];
				    pama[0] = fieldshow;
				    pama[1] = fieldvalue;
				    pama[2] = fieldtype;
				    pama[3] = fieldname;
				    pama[4] = valueMap.get(fieldname)==null?"":valueMap.get(fieldname)+"";
				    pama[5] = "1";
				    pama[6] = fieldid;
				    pama[7] = TableId;
				    pama[8] = InfoId;
				    pama[9] = "see";
             %>
				      <td width="6%"  class="td_lefttitle">    
						   <%=fielddesname%>：    
					  </td>
	                  <td width="<%=_listsize%>%" valign="top">
	              	    <%=hbd.getHtmlInLoadPage(pama,request)%>
	                  </td>
                  <%}%>
				  <%if(_lists>_list.size()){
				     for(int kk=0;kk<(_lists-_list.size());kk++){
				   %>
				   <td></td>
				   <td></td>
				  <%}}%>
                </tr>
		  <%}%>

		   <tr class="Table_nobttomline">    
			<td > </td>   
			   <td nowrap>   
			       <%if(right1){%>
				   <input type="button" class="btnButton4font" onClick="upd();" value="修改" />
				   <%  if("2".equals(ModClassId) || "3".equals(ModClassId)){%>
				   <input type="button" class="btnButton4font" onClick="conInfo();" value="合并" />
				   <%  }%>
				   <input type="button" class="btnButton4font" onClick="del();"     value="删除" />
				   <%}%>
				   <input type="button" class="btnButton4font" id="exitBut" onClick="closeWindow(null);" value="退出" />   
				   
			   </td>    
		   </tr>    
		</table>  
		  
		</div>  
	</div> 
    </s:form>

<div class="BodyMargin_10">
<%
    String limitname = "";
	String limittable = "";
	String limitfield = "";
	String limitprytable = "";
	String limitpryfield = "";
	String limitfieldtype = "";

  List linkTableList = (List)request.getAttribute("linkTableList");
  //关联表名称列
  if(linkTableList != null && linkTableList.size() > 0){
  

%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">    
	<tr>
	    <td width="20%"></td>
		<td width="60%" align="center">
		| <a href="#" onclick="selconemplist();" style="cursor:pointer">相关员工</a> |
		<br>
		| 
		<%
		  for(int i=0;i < linkTableList.size();i++){
		    List list111 = (List)linkTableList.get(i);
		%>
		 <a href="#" onclick="linkl('<%=i%>');" style="cursor:pointer"><%=list111.get(0)%></a> |
		<%}%>
		</td>
		<td width="20%"> </td>
	</tr>
</table>

<%
    List defaultlink = (List)request.getAttribute("defaultlink");
    String headerContainer = (String)request.getAttribute("headerContainer");
	limitname = defaultlink.get(0)+"";
	limittable = defaultlink.get(1)+"";
	limitfield = defaultlink.get(2)+"";
	limitprytable = defaultlink.get(3)+"";
	limitpryfield = defaultlink.get(4)+"";
	limitfieldtype = defaultlink.get(5)+"";

%>
	<s:form name="queryForm" id="queryForm" action="custinfo!getCustLinkDataList.action" method="post" theme="simple">
          <input type="hidden" name="tabName" value="<%=tableName%>">
          <input type="hidden" name="TableId" value="<%=TableId%>">
          <input type="hidden" name="CENTERID" value="<%=CENTERID%>">
          <input type="hidden" name="ModClassId" value="<%=ModClassId%>">
          <input type="hidden" name="rightscope" value="<%=rightscope%>">
		  <input type="hidden" name="rightcodemanage" value="<%=rightcodemanage%>">

		  <input type="hidden" name="limitname" value="<%=limitname%>">
		  <input type="hidden" name="limittable" value="<%=limittable%>">
		  <input type="hidden" name="limitfield" value="<%=limitfield%>">
		  <input type="hidden" name="limitprytable" value="<%=limitprytable%>">
		  <input type="hidden" name="limitpryfield" value="<%=limitpryfield%>">
		  <input type="hidden" name="limitfieldtype" value="<%=limitfieldtype%>">
		  <input type="hidden" name="InfoId" value="<%=InfoId%>">
		  
 
    <%@ include file="/public/include/form_list.jsp"%>       
  
    <!-- MIDDLE  BUTTONS START -->  
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
        <tr> 
			<td align="left">&nbsp;<%=limitname%></td>
	        <td align="right">
			   <%if(right1){%>
			    <input type="button" class="btnButton4font" onclick="addLinkInfo('<%=limittable%>','<%=limitfield%>','<%=limitprytable%>','<%=limitpryfield%>','<%=limitfieldtype%>');" value="新  增" />
			   <%}%>
			 </td>
        </tr>  

    </table>  
    <!-- MIDDLE  BUTTONS END -->  

	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
          <%=headerContainer%>
		</thead>
		<tbody  id="itemContainer" >
          

		</tbody>
    </table>
    <!-- LIST TITLE PART END -->

    <!-- PAGER START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
    <!-- PAGER END -->
	</s:form>
<%}%>
</div>

</body>  
  
<script type="text/javascript">
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){     
  <%if(linkTableList != null && linkTableList.size() > 0){%>
	   initListFormToAjax({formId:"queryForm"});   
  <%}%>
	
});  
//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//  

<%
  List showJSData = (List)request.getAttribute("showJSData");

  if(showJSData!=null){
	String _jsName = "";
	String p_fieldId="";
	String p_fieldname="";
	String p_fieldshow="";
	String p_fieldvalue="";
	String p_fieldtype="";
	String[] pama1 = null;
	Object[] _obj = null;
    for (int i = 0; i < showJSData.size(); i++) {
		_obj = (Object[])showJSData.get(i);
		_jsName = _obj[0]+"";
		p_fieldId=_obj[5]+"";
		p_fieldname=_obj[1]+"";
		p_fieldshow = _obj[2]+"";
		p_fieldvalue = _obj[3]+"";
		p_fieldtype = _obj[4]+"";
%>
         function <%=_jsName%>(po,i){
			var html='';
			var json = ajaxForSync("<%=rootPath%>/custinfo!getShowHTML.action","id="+po.id+"&value="+po.<%=p_fieldname%>+"&fieldId=<%=p_fieldId%>&fieldname=<%=p_fieldname%>&fieldshow=<%=p_fieldshow%>&fieldvalue=<%=p_fieldvalue%>&fieldtype=<%=p_fieldtype%>");
			html = json;
			return html;

        }

<%  }
  }%>

 function showoperate(po,i){

       var html='<img  style="cursor:pointer" border="0" src="<%=rootPath%>/images/xsxg.gif" title="查看" onclick="loadDetails(\''+po.id+'\')">';
	   <%if(right1){%>
		   html += '<img  style="cursor:pointer" border="0" src="<%=rootPath%>/images/modi.gif" title="修改" onclick="loadDetails2(\''+po.id+'\')">';
	       html += '<img  style="cursor:pointer" border="0" src="<%=rootPath%>/images/del.gif" title="删除" onclick="delLink(\''+po.id+'\')">';
	   <%}%>
	   return html;
 }
 //删除关联表信息
 function delLink(DelId){

   whir_confirm("您确定要删除吗？",function(){
	ajaxOperate({urlWithData:'<%=rootPath%>/custinfo!delCustLinkInfo.action?&DelId='+DelId+'&tabId=<%=limitprytable%>',tip:'删除',isconfirm:false,formId:'queryForm'});
   });
}
//删除主表信息
 function del(){

	 var json = ajaxForSync("custinfo!checkHasLink.action","tabId=<%=TableId%>&InfoId=<%=InfoId%>");
	 if(json=="1"){
        whir_confirm("您确定要删除吗？",function(){
	         ajaxOperate({urlWithData:'<%=rootPath%>/custinfo!delCustInfo.action?&delid=<%=InfoId%>&TableId=<%=TableId%>',tip:'删除',isconfirm:false,formId:'queryForm'});
			 window.opener.refreshListForm('queryForm');
			 closeWindow(null);
        });
	 }else{
	    whir_confirm("该信息有关联信息，删除该信息将删除所有的关联信息，确定删除吗？",function(){
	         ajaxOperate({urlWithData:'<%=rootPath%>/custinfo!delCustInfo.action?&delid=<%=InfoId%>&TableId=<%=TableId%>',tip:'删除',isconfirm:false,formId:'queryForm'});
			 window.opener.refreshListForm('queryForm');
			 closeWindow(null);
        });
	 }
 }
 function linkl(index){
   location_href("<%=rootPath%>/custinfo!seeDetailsCustInfo.action?InfoId=<%=InfoId%>&linkIndex="+index+"&CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>");
 }
 function addLinkInfo(tabId,fieId,pTabId,pFieId,typeId){

   openWin({url:'<%=rootPath%>/custinfo!addCustLinkInfo.action?CENTERID=<%=CENTERID%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>&TableId='+tabId+'&fieId='+fieId+'&pTabId='+pTabId+'&pFieId='+pFieId+'&typeId='+typeId+'&InfoId=<%=InfoId%>',isFull:'true',winName:"addLinkInfo"});
}

function loadDetails(pInfoId){

   openWin({url:'<%=rootPath%>/custinfo!loadCustLinkInfo.action?CENTERID=<%=CENTERID%>&ModClassId=<%=ModClassId%>&TableId=<%=limittable%>&fieId=<%=limitfield%>&pTabId=<%=limitprytable%>&pFieId=<%=limitpryfield%>&typeId=<%=limitfieldtype%>&InfoId=<%=InfoId%>&pInfoId='+pInfoId+'&loadtype=see',isFull:'true',winName:"modiLinkInfo"+pInfoId});
}
function loadDetails2(pInfoId){

   openWin({url:'<%=rootPath%>/custinfo!loadCustLinkInfo.action?CENTERID=<%=CENTERID%>&ModClassId=<%=ModClassId%>&TableId=<%=limittable%>&fieId=<%=limitfield%>&pTabId=<%=limitprytable%>&pFieId=<%=limitpryfield%>&typeId=<%=limitfieldtype%>&InfoId=<%=InfoId%>&pInfoId='+pInfoId+'&loadtype=modi',isFull:'true',winName:"modiLinkInfo"+pInfoId});
}
function selconemplist(){
   openWin({url:'<%=rootPath%>/custinfo!selconemplist.action?TableId=<%=TableId%>&InfoId=<%=InfoId%>',isFull:'true',winName:"selconemplist"});
}
function upd(){

   openWin({url:'<%=rootPath%>/custinfo!loadCustInfo.action?CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&InfoId=<%=InfoId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>',isFull:'true',winName:"loadCustInfo"});
}

function conInfo(){
   
   openWin({url:'<%=rootPath%>/custinfo!custRightList.action?selectInfo=1&CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>&InfoId=<%=InfoId%>',isFull:'true',winName:"conInfo"});

}
function reflush_DataForm(){
    //resetDataForm(document.getElementById('exitBut'));
	//window.location.href="<%=rootPath%>/custinfo!seeDetailsCustInfo.action?InfoId=<%=InfoId%>&CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>";
	whir_tips("",1,'',function(){
	  location_href("<%=rootPath%>/custinfo!seeDetailsCustInfo.action?InfoId=<%=InfoId%>&CENTERID=<%=CENTERID%>&TableId=<%=TableId%>&ModClassId=<%=ModClassId%>&rightscope=<%=rightscope%>&rightcodemanage=<%=rightcodemanage%>");
	});
}
</SCRIPT>
<script src="<%=rootPath%>/platform/custom/customizecenter/js/common.js" language="javascript"></script>
</html>  