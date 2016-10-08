<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
	String isOldOrNew = request.getParameter("isOldOrNew")==null?"0":request.getParameter("isOldOrNew").trim();//新老流程标志：0、老流程，1、新流程
    String status = request.getParameter("status")==null?"":request.getParameter("status").trim();
    String ids = request.getParameter("ids")==null?"":request.getParameter("ids").trim();//已选ids,用于修改进入
    String type = request.getParameter("type")==null?"checkbox":request.getParameter("type").trim();//单选，还是复选;
    String id = request.getParameter("id")==null?"":request.getParameter("id").trim();//父界面赋值id域
    String name = request.getParameter("name")==null?"":request.getParameter("name").trim();//父界面赋值name域
    String wait = request.getParameter("wait")==null?"":request.getParameter("wait").trim();//是否需要确认后再赋值
    String reload = request.getParameter("reload")==null?"":request.getParameter("reload").trim();//是否刷新父页面
    String from = request.getParameter("from")==null?"":request.getParameter("from").trim();//调整来源
    String balance = request.getParameter("balance")==null?"":request.getParameter("balance").trim();//预算余额计算
    String rowIndex = request.getParameter("rowIndex")==null?"":request.getParameter("rowIndex").trim();//赋值字段索引，带子表
    String sectionids = request.getAttribute("sectionids")==null?"":request.getAttribute("sectionids").toString();
    String sectionsNames = request.getAttribute("sectionsNames")==null?"":request.getAttribute("sectionsNames").toString();

    if(!"".equals(ids) && !ids.endsWith(",")){
        ids+=",";
    }
    String budgetYearMonth = request.getParameter("budgetYearMonth")==null?"":request.getParameter("budgetYearMonth").trim();//赋值字段索引，带子表
    String budgetBalance= request.getParameter("budgetBalance")==null?"":request.getParameter("budgetBalance").trim();//关联流程
    String budgetSection = request.getParameter("budgetSection")==null?"":request.getParameter("budgetSection").trim();//赋值字段索引，带子表
    String budgetSubject= request.getParameter("budgetSubject")==null?"":request.getParameter("budgetSubject").trim();//关联流程
    String checkType= request.getParameter("checkType")==null?"":request.getParameter("checkType").trim();
    int count= request.getParameter("count")==null?0:Integer.parseInt(request.getParameter("count").trim());
    Date d = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
    String sd = sdf.format(d);
    String year_month = sd.substring(0,7);
    String year =  sd.substring(0,4);
    String p_wf_processId = request.getParameter("p_wf_processId")==null?"":request.getParameter("p_wf_processId").trim();
    int rowIndexInt=Integer.parseInt(rowIndex);
    if(rowIndexInt<count){
       rowIndexInt=count;
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>预算科目</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>

<body class="MainFrameBox">
	<s:form name="queryForm" id="queryForm" action="${ctx}/budgetSubject!list2.action" method="post" theme="simple">
	 <input type="hidden"  name="isOldOrNew" value="<%=isOldOrNew%>" />
    <input type="hidden"  name="status" value="<%=status%>" />
    <input type="hidden"  name="rowIndex" value="<%=rowIndex%>" />
    <input type="hidden"  name="ids" value="<%=ids%>" />
    <input type="hidden" name="type" value="<%=type%>" />
    <input type="hidden" name="id" value="<%=id%>" />
    <input type="hidden" name="name" value="<%=name%>" />
    <input type="hidden" name="wait" value="<%=wait%>" />
    <input type="hidden" name="reload" value="<%=reload%>" />
    <input type="hidden" name="from" value="<%=from%>" />
    <input type="hidden" name="p_wf_processId" value="<%=p_wf_processId%>" />
    <input type="hidden" name="sectionids" id="sectionids" value="<%=sectionids%>" />
    <input type="hidden" name="sectionsNames" id="sectionsNames" value="<%=sectionsNames%>" />
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="SearchBar">
        <tr>
            <td class="whir_td_searchtitle2">预算科目：</td>
            <td class="whir_td_searchinput">
                <s:textfield id="subjectname" name="subjectname" size="16" cssClass="inputText" />
            </td>
            <td class="SearchBar_toolbar">
                <input type="button" class="btnButton4font"  onclick="refreshListForm('queryForm');"  value='<s:text name="comm.searchnow"/>' />
                <!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" value='<s:text name="comm.clear"/>' onclick="resetForm(this);" />
            </td>
        </tr>
    </table>
	<!-- SEARCH PART END -->
    

	<!-- MIDDLE	BUTTONS	START -->
   <table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">  
        <tr>
            <td align="right">
                 <input type="button" class="btnButton4font" onclick="qdxz();" value='<s:text name="comm.confirm"/>' />
              
            </td>
        </tr>
    </table>
    <!-- MIDDLE	BUTTONS	END -->
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<thead id="headerContainer">
        <tr class="listTableHead">
            <%
            if("checkbox".equals(type)){
            %>
                <td whir-options="field:'subjectid',width:'2%',checkbox:true,renderer:showValue"><input type="checkbox" name="items" id="items" onclick="setCheckBoxState('subjectid',this.checked);" ></td>
            <%}else{%>
               <td whir-options="field:'subjectid',width:'2%',radio:true,renderer:showValue"></td> 
            <%}%>
			<td whir-options="field:'subjectnamestring',width:'25%'">科目名称</td> 
            <td whir-options="field:'subjectperiod',width:'25%',renderer:showYearMonth">预算年月</td>
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


</body>


	<script type="text/javascript">	
    if(!window.opener.document.getElementById("subjectperiod_select")){
        <%
        if(count >0 ){
            for(int j=0;j<=rowIndexInt;j++){
        %>
            $(window.opener.document.body).append('<input type="hidden" id="subjectperiod_select" name="subjectperiod_select">');
        <%}}%>
    }else{
        var subjectperiod_select1 = window.opener.document.getElementsByName('subjectperiod_select');
        //var subjectPeriodCount=<%=count%>;
        var subjectPeriodCount=<%=rowIndexInt%>;
        if(subjectperiod_select1.length <=subjectPeriodCount){
            subjectPeriodCount=subjectPeriodCount-subjectperiod_select1.length;
            for(var n=0;n<=subjectPeriodCount;n++){
                $(window.opener.document.body).append('<input type="hidden" id="subjectperiod_select" name="subjectperiod_select">');
            }
        }
    }
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm'});
	});
	 function showYearMonth(po,i){
        var subjectperiod=po.subjectperiod;
        var html='';
        if(subjectperiod == '0'){      
            html='<input  name="subjectperiod" id="subjectperiod" type="text"  value="<%=year_month%>"   class="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:\'yyyy-MM\',readOnly:true})"/>';
        }else{
            html='<input  name="subjectperiod" id="subjectperiod" type="text"  value="<%=year%>"   class="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:\'yyyy\',readOnly:true})"/>';
        }
		return html;
	}
     function showValue(po,i){
        var html='newValue="'+po.subjectid+';'+po.subjectnamestring+'"';
         var ids='<%=ids%>';
        var id=po.subjectid;
        if(ids.indexOf(id+",") >= 0){
            html+=' checked';
        }
		return html;
	}
	function qdxz() {
		var parm =''; 
		 <%
            if("checkbox".equals(type)){
            %>
			parm =getCheckBoxData("subjectid", "newValue");//alert("parm:"+parm);
		<%}else{%>
		   $("input[name=subjectid]").each(function(){
				if($(this).prop("checked")==true ){
					parm =$(this).attr("newValue");
				}
			});
		<%}%>
        if(parm == "") {
        whir_alert("请选择！",null,null);
        return;
        }
        var arr=parm.split(",");
        var subjectids = '';
        var subjectnames = '';
        for(var i=0;i<arr.length;i++){
            var t=arr[i];
            if(subjectids ==''){
                subjectids = t;
                subjectnames = t.split(";")[1];
            }else{
                subjectids = subjectids+','+t;
                subjectnames = subjectnames+','+t.split(";")[1];
            }
        }
        var objNames = $("input[name='subjectid']");
        for(var k=0;k<objNames.length;k++){
			if(objNames[k].checked){ //$(obj).parent().find($("input[name='"+text+"']"))
                var nr=$(objNames[k]).closest("td").next().next().find($("input[name='subjectperiod']")).val();
                opener.$("input[name='subjectperiod_select']")[<%=rowIndex%>].value=nr;
			}
		}
        opener.$("input[name='<%=id%>']")[<%=rowIndex%>].value=subjectids;
        opener.$("input[name='<%=name%>']")[<%=rowIndex%>].value=subjectnames;
        <%if(!"".equals(balance)){%>
        window.opener.budgetBalanceEvent('<%=budgetBalance%>','<%=budgetSection%>','<%=budgetSubject%>','<%=rowIndex%>');//计算所选科目余额
        <%}%>
        if(window.opener.document.getElementById('budgetYearMonth')){
             opener.$("input[name='<%=budgetYearMonth%>']")[<%=rowIndex%>].value=opener.$("input[name='subjectperiod_select']")[<%=rowIndex%>].value;
        }


window.close();

    }
   </script>

</html>

