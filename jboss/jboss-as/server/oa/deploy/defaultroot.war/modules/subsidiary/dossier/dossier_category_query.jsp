<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>档案查询</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<%
  Long categoryId = new Long(-1);
  if(request.getAttribute("categoryId")!=null){
     categoryId = new Long(request.getAttribute("categoryId").toString());
  }
  
  Long pcategoryId = new Long(-1);
  if(request.getAttribute("pcategoryId")!=null){
     pcategoryId = new Long(request.getAttribute("pcategoryId").toString());
  }
  
  String idStr="";
  if(request.getAttribute("idStr")!=null){
	 idStr = request.getAttribute("idStr").toString();
  }
  
  List categoryList = (List)request.getAttribute("categoryList");
  String space="";
  String dossierType = request.getAttribute("dossierType")!=null?request.getAttribute("dossierType").toString():"";
  String paraClass = request.getAttribute("paraClass")!=null?request.getAttribute("paraClass").toString():null;

  //预防脚本注入
  String level = com.whir.component.security.crypto.EncryptUtil.htmlcode(request,"level");
%>
<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="/dossierCategoryQueryAction!getQueryList.action" method="post" theme="simple">
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">  
        <input type="hidden" name="level" id="level" value="<%=level%>"/>
        <input type="hidden" name="categoryId" id="categoryId" value="<%=categoryId%>"/>
    	<input type="hidden" name="pcategoryId" id="pcategoryId" value="<%=pcategoryId%>"/>
        <tr>
            <td class="whir_td_searchtitle">题名：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="title" name="title" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">所属类目：</td>
            <td class="whir_td_searchinput">
                <select name="idStr" id="idStr" class="selectlist" onchange="chgLevel(this);">
                    <option property="0" value="">请选择</option>
                    <%
					  if(categoryList!=null&&categoryList.size()>0){
							for(int i=0; i<categoryList.size(); i++){
								Object[] c = (Object[])categoryList.get(i);
								space="";
								for(int j=1; j<Integer.parseInt(c[3].toString()); j++){
									space+="&nbsp;&nbsp;";
								}
					%>
					<option property="<%=c[3]%>" value="<%=c[2]%>" <%=idStr.equals(c[2])?"selected":""%>><%=space%><%=c[1]%></option>
					<%}}%>
                </select>
            </td>
            <td class="whir_td_searchtitle">档案类型：</td>
            <td class="whir_td_searchinput">
                <select name="dossierType" id="dossierType" class="selectlist">
                    <option value="">请选择</option>
                    <%
				 	  if(paraClass!=null){
					  	 String[] s0 = paraClass.split(";");
					  	 for(int i=0; i<s0.length; i++){
				    %>
					<option value="<%=s0[i]%>" <%=dossierType.equals(s0[i])?"selected":""%>><%=s0[i]%></option>
				    <%}}%>
                </select>
            </td>
        </tr>
        <tr>
        	<td class="whir_td_searchtitle">文号：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="filenum" name="filenum" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">主办部门：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="transOrg" name="transOrg" size="16" cssClass="inputText" />
            </td>
            <td class="whir_td_searchtitle">借阅情况：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="dStatus" name="dStatus" size="16" cssClass="inputText" />
            </td>
        </tr>
        <tr>
            <td colspan="6" class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm_Ext();"  value="<s:text name="comm.searchnow"/>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value="<s:text name="comm.clear"/>" onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    
	<!-- MIDDLE	BUTTONS	START -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr >
			<td align="left">
                <span id="targetFixed" style="height:20px; padding:1px;" class="target_fixed"></span>
            </td>
            <td align="right">
                <input type="button" class="btnButton4font" onclick="borrowAll();" value="批量借阅" />
                <input type="button" class="btnButton4font" onclick="print();" value="<s:text name="comm.export"/>" />
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->
    
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
			<td whir-options="field:'id',width:'2%',checkbox:true,renderer:show_checkbox"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('id',this.checked);" ></td>
			<td whir-options="field:'docnum',width:'12%'">件号</td> 
		    <td whir-options="field:'title',width:'29%'">题名</td> 
		    <td whir-options="field:'sendDate',width:'8%',allowSort:true,renderer:show_sendDate">发文日期</td> 
			<td whir-options="field:'duty',width:'10%'">责任者</td> 
			<td whir-options="field:'filenum',width:'12%',allowSort:true">文号</td> 
		    <td whir-options="field:'pageNum',width:'5%'">页数</td> 
		    <td whir-options="field:'secretlevel',width:'5%'">密级</td> 
		    <td whir-options="field:'name',width:'9%'">借阅情况</td> 
			<td whir-options="field:'',width:'8%',renderer:myOperate">操作</td> 
        </tr>
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
    <s:form name="exportForm" id="exportForm" action="" method="post" theme="simple">
       
    </s:form>
</body>
	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//
	
	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:"queryForm"});
	});
	
	//自定义操作栏内容
	function myOperate(po,i){
		var html ='';
		if(po.canRead=='true' && po.isRigthRead =='false'){
			html = '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/dossierAction!load.action?id='+po.id+'&isView=true&verifyCode='+po.verifyCode+'\',width:1000,height:600,winName:\'详细\'});"><img border="0" src="<%=rootPath%>/images/look.gif" title="详细" ></a>';
		}else if(po.borrow=='true' && po.isRigthRead =='false'){
           	html ='<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/dossierCategoryQueryAction!borrowFlow.action?borrowtype=One&ids='+po.id+'\',width:600,height:200,winName:\'借阅\'});"><img border="0" src="<%=rootPath%>/images/sq.gif" title="借阅" ></a>';
        }
        if(po.isRigthRead =='true'){
          	 html += '<a href="javascript:void(0)" onclick="openWin({url:\'<%=rootPath%>/dossierAction!load.action?id='+po.id+'&isView=true&verifyCode='+po.verifyCode+'\',width:1000,height:600,winName:\'详细\'});"><img border="0" src="<%=rootPath%>/images/look.gif" title="详细" ></a>';
	        if(po.zwUrl !=null && po.zwUrl !=''){
	           html += '<a href="javascript:void(0)" onclick="openWin({url:\''+po.zwUrl+'\',width:1000,height:600,winName:\'查看正文\'});"><img border="0" src="<%=rootPath%>/images/lookzw.gif" title="查看正文" ></a>';
	        }
        }
		return html;
	}
	
	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//
	function refreshListForm_Ext(){
		if($('#idStr').val() !=''){
		   var idStr =$('#idStr').val() +"$";
		   idStr = idStr.substring(1,idStr.length);
		   var idStrs = idStr.split("$$");
		   $('#categoryId').val(idStrs[idStrs.length-2]);
		}
		
	    refreshListForm('queryForm');
	}
	
	function show_checkbox(po,i){
	    var html ='';
	    if(po.borrow =='false' || po.isRigthRead =='true' || (po.canRead=='true' && po.isRigthRead =='false')){
	       html= 'disabled="true"';
	    }
	    return html;
	}
	
	function show_sendDate(po,i){
	    var html ='';
	    if(po.sendDate.length >10){
	       html =po.sendDate.substring(0,10);
	    }
	    return html;
	}
	
	function print(){
		var title =$('#title').val();
		var idStr =$('#idStr').val();
		var dossierType =$('#dossierType').val();
		var filenum =$('#filenum').val();
		var transOrg =$('#transOrg').val();
		var dStatus  =$('#dStatus').val();
		var categoryId =$('#categoryId').val();
		var param = 'title='+title+'&idStr='+idStr+'&dossierType='+dossierType+'&filenum='+filenum+'&transOrg='+transOrg+'&dStatus='+dStatus+'&categoryId='+categoryId+'';
	    $('#exportForm').attr('action','dossierCategoryQueryAction!export.action?'+param);
	    $('#exportForm').submit();
	}
	
	function chgLevel(obj){
	    var level = $(obj).find('option:selected').attr('property');
	    $('#level').val(level);
	}
	
	function borrowAll(){
	    var ids ="";
	    $('#itemContainer').find('input[type=checkbox]:checked').each(function(){
	    	ids += $(this).attr('id') + ",";
	    });
	    if(ids!=null && ids !=''){
	       ids =ids.substring(0,ids.lastIndexOf(','));
	       var idss = ids.split(',');
	       if(idss.length ==1){
	          openWin({url:'<%=rootPath%>/dossierCategoryQueryAction!borrowFlow.action?borrowtype=One&ids='+ids+'',width:600,height:150,winName:'借阅'});
	       }else{
	          openWin({url:'<%=rootPath%>/dossierCategoryQueryAction!borrowFlow.action?borrowtype=All&ids='+ids+'',width:600,height:150,winName:'借阅'});
	       }
	    }else{
	       whir_alert('请选择要借阅的文件！', null);
	    }
	}
   </script>
</html>