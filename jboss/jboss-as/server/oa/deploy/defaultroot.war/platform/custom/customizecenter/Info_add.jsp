<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
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

 CustomerInfoBD bd = new CustomerInfoBD();
 CustomerHtmlBD hbd = new CustomerHtmlBD();
 String fieldvalue = "";
 String fieldid = "";
 String fielddesname = "";
 String fieldname  = "";
 String fieldtype = "";
 String fieldshow = "";
 String fieldonly = "";
 //需要判断唯一性
 List fieldonlys = new ArrayList();
 //需要判断不为空
 List notNullFields = new ArrayList();

%>
<head>  
	<title>新增客户信息</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_detail.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/WorkflowResource.js" type="text/javascript"></script>
	<SCRIPT language=javascript src="<%=rootPath%>/platform/custom/custom_form/run/js/form.js"></SCRIPT>
	<script language="javascript" src="<%=rootPath%>/platform/custom/ezform/js/popselectdata.js"></script>
</head>  
  
<body class="Pupwin" >  
	<div class="BodyMargin_10">    
		<div class="docBoxNoPanel">  
		<s:form name="dataForm" id="dataForm" action="/custinfo!saveCustInfo.action" method="post" theme="simple" >  
          <input type="hidden" name="tabName" value="<%=tableName%>">
		  <input type="hidden" name="user_Name" id="user_Name" value="<%=user_Name%>">
          <input type="hidden" name="TableId" value="<%=TableId%>">
          <input type="hidden" name="CENTERID" value="<%=CENTERID%>">
          <input type="hidden" name="ModClassId" value="<%=ModClassId%>">
          <input type="hidden" name="rightscope" value="<%=rightscope%>">
		  <input type="hidden" name="rightcodemanage" value="<%=rightcodemanage%>">
		  <input type="hidden" name="Page_Id" id="Page_Id" value="<%=TableId%>">
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">  
		   
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
	                  
	                //设置唯一性字段或者自动编号字段
	                if("1".equals(fieldonly) || 
						  "111".equals(fieldshow)){
					     Object[] _obj = new  Object[3];
                         _obj[0] = fieldname;
						 _obj[1] = fieldtype;
						 _obj[2] = fielddesname;
						 fieldonlys.add(_obj);
	                 }
	                 //判断是否必填字段
					 if( "1".equals(bd.getFieldDetailsInfoById(fieldid,CommonUtils.getSessionDomainId(request)+"")) ){
						 Object[] _obj = new  Object[2];
                         _obj[0] = fieldname;
						 _obj[1] = fielddesname;
						 notNullFields.add(_obj);
                      }
                   %>
				      <td width="6%" class="td_lefttitle">    
						   <%=fielddesname%><%if( "1".equals(bd.getFieldDetailsInfoById(fieldid,CommonUtils.getSessionDomainId(request)+""))){%><span class="MustFillColor">*</span><%}%>：    
					  </td>
	                  <td width="<%=_listsize%>%" valign="top">
	              	 <%
	              	   if((com.whir.component.util.Field.FIELD_UP_FILE+"").equals(fieldshow)||
					       (com.whir.component.util.Field.FIELD_EDIT_WORD+"").equals(fieldshow)||
					       (com.whir.component.util.Field.FIELD_EDIT_EXCEL+"").equals(fieldshow)||
					       (com.whir.component.util.Field.FIELD_EDIT_WPS+"").equals(fieldshow)){
		                     
		                     String[] pama = new String[10];
								     	   pama[0] = fieldshow;
								     	   pama[1] = fieldvalue;
								     	   pama[2] = fieldtype;
								     	   pama[3] = fieldname;
								     	   pama[4] = "";
								     	   pama[5] = "2";
								     	   pama[6] = fieldid;
										   pama[7] = TableId;
					                       pama[8] = "";
										   pama[9] = "add";
	              	 %>
	              	  <%=hbd.getHtmlInLoadPage(pama,request)%>
	              	 <%}else{
	              	  	   String[] pama = new String[10];
								     	   pama[0] = fieldshow;
								     	   pama[1] = fieldvalue;
								     	   pama[2] = fieldtype;
								     	   pama[3] = fieldname;
								     	   pama[4] = "";
								     	   pama[5] = "0";
								     	   pama[6] = fieldid;
										   pama[7] = TableId;
					                       pama[8] = "";
										   pama[9] = "add";
	              	 %>
		               <%=hbd.getHtmlInLoadPage(pama,request)%>
		               
		             <%}%>
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
				   <input type="button" class="btnButton4font" onClick="saveclose(this);" value="<%=Resource.getValue(whir_locale,"common","comm.saveclose")%>" />
				   <input type="button" class="btnButton4font" onClick="savecontinue(this);" value="<%=Resource.getValue(whir_locale,"common","comm.savecontinue")%>" />
				   <input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value="<%=Resource.getValue(whir_locale,"common","comm.reset")%>" />    
				   <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<%=Resource.getValue(whir_locale,"common","comm.exit")%>" />    
			   </td>    
		   </tr>    
		</table>  
		 
		</s:form>  
		</div>  
	</div>  
</body>  
  
<script type="text/javascript">  
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//设置表单为异步提交  
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});  

//*************************************下面的函数属于各个模块 完全 自定义的*********************************************//

function saveclose(obj){
	var a ='';
    <%
	   if(notNullFields!=null){
		  for(int i=0;i<notNullFields.size();i++){
			  Object[] _obj = (Object[])notNullFields.get(i);
	%>
	     a=replaceDollar('<%=_obj[0]%>');
	     var _a = $("#"+a).val();
         if(_a=="" || $.trim(_a)=="") {
            whir_alert('<%=_obj[1]%>不能为空!', null);
	        return;
	     }

	<%   }
	  }
	%>
	<%
	   if(fieldonlys!=null){
		  for(int i=0;i<fieldonlys.size();i++){
			  Object[] _obj = (Object[])fieldonlys.get(i);
	%>
		 a=replaceDollar('<%=_obj[0]%>');
         var _a = $("#"+a).val();
		 var json = ajaxForSync("<%=rootPath%>/custinfo!checkOnlyFields.action","tableName=<%=tableName%>&fieldname=<%=_obj[0]%>&fieldtype=<%=_obj[1]%>&value="+_a);
		 if(json != "true"){
		    whir_alert('<%=_obj[2]%>已经存在!',null);
	        return;
		 }

	<%   }
	  }
	%>
	ok(0,obj);
}
function savecontinue(obj){
	var a ='';
    <%
	   if(notNullFields!=null){
		  for(int i=0;i<notNullFields.size();i++){
			  Object[] _obj = (Object[])notNullFields.get(i);
	%>
		 a=replaceDollar('<%=_obj[0]%>');
	     var _a = $("#"+a).val();
	     if(_a=="" || $.trim(_a)=="") {
            whir_alert('<%=_obj[1]%>不能为空!',null);
	        return;
	     }

	<%   }
	  }
	%>
	<%
	   if(fieldonlys!=null){
		  for(int i=0;i<fieldonlys.size();i++){
			  Object[] _obj = (Object[])fieldonlys.get(i);
	%>
		 a=replaceDollar('<%=_obj[0]%>');
	     var _a = $("#"+a).val();
		 var json = ajaxForSync("<%=rootPath%>/custinfo!checkOnlyFields.action","tableName=<%=tableName%>&fieldname=<%=_obj[0]%>&fieldtype=<%=_obj[1]%>&value="+_a);
		 if(json != "true"){
		    whir_alert('<%=_obj[2]%>已经存在!',null);
	        return;
		 }

	<%   }
	  }
	%>
	ok(1,obj);
}

</script>
<script src="<%=rootPath%>/platform/custom/customizecenter/js/common.js" language="javascript"></script>
</html>  