<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.whir.ezoffice.customdb.common.util.DbOpt" %>
<%@ include file="/public/include/init.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head>  
<title>显示设置</title>  
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
<%
whir_custom_str="My97DatePicker,easyui";
%>
<%@ include file="/public/include/meta_base.jsp"%>  
<%@ include file="/public/include/meta_list.jsp"%>  
<!--这里可以追加导入模块内私有的js文件或css文件-->
<script src="<%=rootPath%>/platform/custom/custom_database/js/show.js" type="text/javascript"></script>
<style type="text/css">
.btnM{
    margin-left:3px;
}
</style>
</head>  

<body class="MainFrameBox" margin=0>  
<!--这里的表单id queryForm 允许修改 -->  
<s:form name="dataForm" id="dataForm" action="/Show!saveShow.action" method="post">
<%@ include file="/public/include/form_detail.jsp"%>
<s:hidden name="tableId" id="tableId"/>

<!-- SEARCH PART END -->
  
<!-- MIDDLE  BUTTONS START -->  
<!--table width="100%" border="0" cellpadding="0" cellspacing="0" class="toolbarBottomLine">    
    <tr> 
        <td align="right">
        </td>  
    </tr>
</table-->  
<!-- MIDDLE  BUTTONS END -->  

<%
int index=0;
String[][] showList = (String[][])request.getAttribute("showList");
String tableId = (String)request.getAttribute("tableId");
String[][] relationObject = (String[][])request.getAttribute("relationObject");
String[][] showDateArr = (String[][])request.getAttribute("showDateArr");
String[][] tabelInfo = (String[][])request.getAttribute("tabelInfo");
String tableName = tabelInfo[0][3];
%>
<!-- LIST TITLE PART START -->      
<table width="100%" border="0" cellpadding="0" cellspacing="1" class="listTable">
    <tr class="listTableHead">
        <td width="15%">字段名称</td>
        <td width="7%" nowrap>列表显示</td>
        <td width="7%" nowrap>显示顺序</td>
        <td width="7%" nowrap>列表宽度</td>
        <td width="12%">编辑方式</td>
        <td width="52%">取值范围</td>
    </tr>

    <%
        if(showList != null){
            for(int i=0,len=showList.length; i<len; i++){
                index++;

                String[] obj = showList[i];
                String showId = "" + obj[4];
                String showName = "" + obj[6];
                String sysAttr = "" + obj[13];
                String listClass="listTableLine1";
                String fieldValue = obj[5]!=null?obj[5].toString():"";
                String fieldDefault = obj[14]!=null?obj[14].toString():"";
                if(index%2 != 0){listClass="listTableLine2";}
                String isReadonly="";
                if(",101,107,108,109,110,112,113,116,117,118,404,405,702,703,704,705,401,801,802,806,".indexOf(","+showId+",")!=-1){
                    isReadonly="readOnly";
                }
                if("0".equals(sysAttr)){
                    isReadonly="readOnly";
                }
    %>
    <tr class="<%=listClass%>">
        <td><%=obj[1]%><input type="hidden" name="fieldName" value="<%=obj[0]%>"></td>
		<td nowrap><input type="checkbox" name="id" value="<%=obj[0].toString()%>" <%if(obj[2]!=null && "1".equals(obj[2])){%>checked<%}%> onclick="checkID(this, '<%=showId%>', '<%=obj[8]%>');"/>显示</td>
		<td><input type="text" class="inputText" name="fieldSeq" maxlength="3" size="3" onblur="isValidNum(this)" <%if(obj[9]!=null && !"".equals(obj[9])){%>value="<%=obj[9].toString()%>"<%}%>/></td>
		<td><input type="text" class="inputText" name="fieldWidth" maxlength="3" size="3" onblur="isValidNum(this)" <%if(obj[3]!=null){%>value="<%=obj[3].toString()%>"<%}%>/></td>
		<td>
        <%
            if("0".equals(sysAttr)){
        %>  
            <input type="hidden" name="fieldShow" value="<%=showId%>">
            <input type="text" class="inputText" value="<%=showName%>" style="width:180px;" readonly/>
        <%
            }else if(",gov_documentsendfile,gov_receivefile,gov_sendfilecheckwithworkflow,".indexOf(","+tableName+",")!=-1){//公文管理模块特殊需求
        %> 
            <select name="fieldShow" onchange="update(<%=i%>)" style="width:180px;" class="selectlist">
                <optgroup label="基本输入">
                <option value="101" <%="101".equals(showId)?"selected":""%>>单行文本</option>
                <option value="110" <%="110".equals(showId)?"selected":""%>>多行文本</option>
                <option value="401" <%="401".equals(showId)?"selected":""%>>批示意见</option>            
                </optgroup>
				<optgroup label="选择输入">
					<option value="103" <%="103".equals(showId)?"selected":""%>>单选</option>
					<option value="104" <%="104".equals(showId)?"selected":""%>>多选</option>
					<option value="105" <%="105".equals(showId)?"selected":""%>>下拉框</option>  
				</optgroup>
                <optgroup label="编辑上传">
                <option value="116" <%="116".equals(showId)?"selected":""%>>Word编辑</option>
                <option value="117" <%="117".equals(showId)?"selected":""%>>Excel编辑</option>
                <option value="118" <%="118".equals(showId)?"selected":""%>>WPS编辑</option>
                <option value="115" <%="115".equals(showId)?"selected":""%>>附件上传</option>
                </optgroup>
                <optgroup label="日期时间">
                <option value="107" <%="107".equals(showId)?"selected":""%>>日期</option>
                <option value="108" <%="108".equals(showId)?"selected":""%>>时间</option>
                <option value="109" <%="109".equals(showId)?"selected":""%>>日期时间</option>
                <option value="204" <%="204".equals(showId)?"selected":""%>>当前日期</option>
                <option value="703" <%="703".equals(showId)?"selected":""%>>当前日期时间</option>
                </optgroup>
                <optgroup label="组织用户">
				<option value="210" <%="210".equals(showId)?"selected":""%>>单选人（全部）</option>
				<option value="211" <%="211".equals(showId)?"selected":""%>>多选人（全部）</option>
				<option value="704" <%="704".equals(showId)?"selected":""%>>单选人（本组织）</option>
				<option value="705" <%="705".equals(showId)?"selected":""%>>多选人（本组织）</option>
				<option value="212" <%="212".equals(showId)?"selected":""%>>单选组织</option>
				<option value="214" <%="214".equals(showId)?"selected":""%>>多选组织</option>
				</optgroup>
				<!--<optgroup label="编号类型">
				<option value="111" <%="111".equals(showId)?"selected":""%>>自动编号</option>
				</optgroup>-->
                <optgroup label="自定义">
                <option value="999" <%="999".equals(showId)?"selected":""%>>自定义模板</option>
                </optgroup>
            </select>
        <%}else{%>
            <select name="fieldShow" onchange="update(<%=i%>)" style="width:180px;" class="selectlist">
    <%if(obj[8]!=null && (obj[8].equals("1000000")||obj[8].equals("1000001"))){%>
            <optgroup label="基本输入">
            <option value="101" <%="101".equals(showId)?"selected":""%>>单行文本</option>
            </optgroup>

            <%if(obj[8].equals("1000000")){%>
            <optgroup label="选择输入">
            <option value="103" <%="103".equals(showId)?"selected":""%>>单选</option>
            <option value="105" <%="105".equals(showId)?"selected":""%>>下拉框</option>
            </optgroup>
            <%}%>

            <optgroup label="金额类型">
            <option value="301" <%="301".equals(showId)?"selected":""%>>金额</option>
            </optgroup>
            <optgroup label="计算字段">
            <option value="203" <%="203".equals(showId)?"selected":""%>>计算字段</option>
            <option value="606" <%="606".equals(showId)?"selected":""%>>子表字段合计</option>
            <option value="808" <%="808".equals(showId)?"selected":""%>>日期时间计算</option>
            </optgroup>

            <%if(obj[8].equals("1000000")){%>
            <optgroup label="用户信息">
            <option value="201" <%="201".equals(showId)?"selected":""%>>登录人ID</option>
            </optgroup>
            <%}%>

            <!--option value="">--------------</option-->
            <%if(obj[8].equals("1000001")){%>
            <optgroup label="预算管理">
            <option value="803" <%="803".equals(showId)?"selected":""%>>预算金额</option>
            <option value="804" <%="804".equals(showId)?"selected":""%>>预算余额</option>
            <option value="807" <%="807".equals(showId)?"selected":""%>>任务预算余额</option>
            </optgroup>
            <%}%>
    <%}%>
    <%if(obj[8]!=null && obj[8].equals("1000002")){%>
            <optgroup label="基本输入">
            <option value="101" <%="101".equals(showId)?"selected":""%>>单行文本</option>
            <option value="110" <%="110".equals(showId)?"selected":""%>>多行文本</option>
            <option value="102" <%="102".equals(showId)?"selected":""%>>密码输入</option>
            <option value="401" <%="401".equals(showId)?"selected":""%>>批示意见</option>            
            </optgroup>

            <optgroup label="选择输入">
            <option value="103" <%="103".equals(showId)?"selected":""%>>单选</option>
            <option value="104" <%="104".equals(showId)?"selected":""%>>多选</option>
            <option value="105" <%="105".equals(showId)?"selected":""%>>下拉框</option>            
            <option value="404" <%="404".equals(showId)?"selected":""%>>单选弹出选择</option>
            <option value="405" <%="405".equals(showId)?"selected":""%>>多选弹出选择</option>
            <option value="707" <%="707".equals(showId)?"selected":""%>>外部接口数据</option>
            <option value="402" <%="402".equals(showId)?"selected":""%>>关联保存</option>
            <option value="706" <%="706".equals(showId)?"selected":""%>>弹出窗口</option>
            </optgroup>

            <!--option value="">--------------</option-->
            <optgroup label="编辑上传">
            <%if(showId.equals("113")){%>
            <option value="113" <%="113".equals(showId)?"selected":""%>>HTML编辑</option>
            <%}%>
            <option value="116" <%="116".equals(showId)?"selected":""%>>Word编辑</option>
            <option value="117" <%="117".equals(showId)?"selected":""%>>Excel编辑</option>
            <option value="118" <%="118".equals(showId)?"selected":""%>>WPS编辑</option>
            <option value="115" <%="115".equals(showId)?"selected":""%>>附件上传</option>
            </optgroup>
            <!--option value="">--------------</option-->
            

            <!--option value="">--------------</option-->

            <optgroup label="日期时间">
            <option value="107" <%="107".equals(showId)?"selected":""%>>日期</option>
            <option value="108" <%="108".equals(showId)?"selected":""%>>时间</option>
            <option value="109" <%="109".equals(showId)?"selected":""%>>日期时间</option>
            <option value="204" <%="204".equals(showId)?"selected":""%>>当前日期</option>
            <option value="703" <%="703".equals(showId)?"selected":""%>>当前日期时间</option>
            <option value="808" <%="808".equals(showId)?"selected":""%>>日期时间计算</option>
            </optgroup>
            <!--option value="">--------------</option-->

            <optgroup label="编号类型">
            <option value="111" <%="111".equals(showId)?"selected":""%>>自动编号</option>
            </optgroup>
            <optgroup label="金额类型">
            <option value="302" <%="302".equals(showId)?"selected":""%>>金额大写</option>
            </optgroup>
            <!--option value="">--------------</option-->

            <optgroup label="用户信息">
            <option value="201" <%="201".equals(showId)?"selected":""%>>登录人ID</option>
            <option value="202" <%="202".equals(showId)?"selected":""%>>登录人姓名</option>
            <option value="601" <%="601".equals(showId)?"selected":""%>>登录人英文名</option>
            <option value="406" <%="406".equals(showId)?"selected":""%>>登录人账号</option>

            <option value="213" <%="213".equals(showId)?"selected":""%>>登录人组织ID</option>
            <option value="207" <%="207".equals(showId)?"selected":""%>>登录人组织</option>
            <option value="605" <%="605".equals(showId)?"selected":""%>>登录人组织英文名</option>

            <option value="602" <%="602".equals(showId)?"selected":""%>>登录人工号</option>
            <option value="603" <%="603".equals(showId)?"selected":""%>>登录人商务电话</option>
            <option value="607" <%="607".equals(showId)?"selected":""%>>登录人岗位</option>
            <option value="604" <%="604".equals(showId)?"selected":""%>>登录人职务</option>

            <option value="215" <%="215".equals(showId)?"selected":""%>>当前办理人姓名</option>
            <option value="701" <%="701".equals(showId)?"selected":""%>>批示人和日期</option>
            <option value="809" <%="809".equals(showId)?"selected":""%>>批示人姓名</option>
            <option value="810" <%="810".equals(showId)?"selected":""%>>签名图片</option>
            <option value="702" <%="702".equals(showId)?"selected":""%>>登录人姓名和日期</option>
            </optgroup>
            <!--option value="">--------------</option-->

            <optgroup label="组织用户">
            <option value="210" <%="210".equals(showId)?"selected":""%>>单选人（全部）</option>
            <option value="211" <%="211".equals(showId)?"selected":""%>>多选人（全部）</option>
            <option value="704" <%="704".equals(showId)?"selected":""%>>单选人（本组织）</option>
            <option value="705" <%="705".equals(showId)?"selected":""%>>多选人（本组织）</option>
            <option value="708" <%="708".equals(showId)?"selected":""%>>流程发起人（批量发起）</option>
            <option value="212" <%="212".equals(showId)?"selected":""%>>单选组织</option>
            <option value="214" <%="214".equals(showId)?"selected":""%>>多选组织</option>
            </optgroup>

            <!--option value="">--------------</option-->

            <optgroup label="相关对象">
            <option value="501" <%="501".equals(showId)?"selected":""%>>相关对象</option>            
            </optgroup>

            <!--option value="">--------------</option-->
            <optgroup label="预算管理">
            <option value="801" <%="801".equals(showId)?"selected":""%>>预算部门</option>
            <option value="802" <%="802".equals(showId)?"selected":""%>>预算科目</option>
            <option value="806" <%="806".equals(showId)?"selected":""%>>项目任务预算</option>
            <option value="805" <%="805".equals(showId)?"selected":""%>>预算年月</option>
            </optgroup>
    <%}%>
    <%if(obj[8]!=null && obj[8].equals("1000003")){%>
            <optgroup label="基本输入">
            <option value="110" <%="111".equals(showId)?"selected":""%>>多行文本</option>
            <option value="401" <%="401".equals(showId)?"selected":""%>>批示意见</option>
            </optgroup>

            <!--option value="">--------------</option-->
            <optgroup label="选择输入">
            <option value="402" <%="402".equals(showId)?"selected":""%>>关联保存</option>
            <option value="706" <%="706".equals(showId)?"selected":""%>>弹出窗口</option>
            </optgroup>

            <!--option value="">--------------</option-->
            <optgroup label="编辑上传">
            <option value="113" <%="113".equals(showId)?"selected":""%>>HTML编辑</option>
            <option value="116" <%="116".equals(showId)?"selected":""%>>Word编辑</option>
            <option value="117" <%="117".equals(showId)?"selected":""%>>Excel编辑</option>
            <option value="118" <%="118".equals(showId)?"selected":""%>>WPS编辑</option>
            <option value="115" <%="115".equals(showId)?"selected":""%>>附件上传</option>
            </optgroup>

            <!--option value="">--------------</option-->
            <optgroup label="金额类型">
            <option value="302" <%="302".equals(showId)?"selected":""%>>金额大写</option>
            </optgroup>
            <!--optgroup label="计算字段">
            <option value="203" <%if(showId.equals("203")) out.print("selected");%>>计算字段</option>
            </optgroup-->

            <optgroup label="组织用户">
            <option value="211" <%="211".equals(showId)?"selected":""%>>多选人（全部）</option>
            <option value="705" <%="705".equals(showId)?"selected":""%>>多选人（本组织）</option>
            <option value="708" <%="708".equals(showId)?"selected":""%>>流程发起人（批量发起）</option>
            <option value="214" <%="214".equals(showId)?"selected":""%>>多选组织</option>
            </optgroup>

            <!--option value="">--------------</option-->
            <optgroup label="相关对象">
            <option value="501" <%="501".equals(showId)?"selected":""%>>相关对象</option>
            </optgroup>
    <%}%>

            <optgroup label="自定义">
            <option value="999" <%="999".equals(showId)?"selected":""%>>自定义模板</option>
            </optgroup>

		    </select>
        <%}%>
        </td>
		<td class="listTableLineLastTD" nowrap="nowrap">
            <div name="selectvalDIV" style="display:<%if(",302,501,701,707,809,810,".indexOf(","+showId+",")!=-1) out.print("none"); else out.print("");%>"><span name="fieldvalueSpan" style="display:<%if(",401,207,808,".indexOf(","+showId+",")!=-1) out.print("none"); else out.print("");%>"><%
                String _value = "";
                if(!showId.equals("113")){
                    _value = fieldValue;
                }
                if(fieldValue.length()>0){
                    out.print("<input type=\"text\" class=inputText name=fieldvalue style=\"width:180px\" "+isReadonly+"  value='"+fieldValue.replaceAll("'","&#39;")+"'>");
                }else{
                    out.print("<input type=\"text\" class=inputText name=fieldvalue style=\"width:180px\" "+isReadonly+" >");
                }
                boolean bugetFlag0 = false;
                boolean bugetFlag1 = false;
                boolean bugetFlag2 = false;
                if(",803,".indexOf(showId+"")!=-1){
                    if(fieldValue==null||"".equals(fieldValue)||"null".equals(fieldValue)){
                        bugetFlag0 = true;
                    }else if(fieldValue!=null&&!"".equals(fieldValue)&&!fieldValue.startsWith("@[")){
                        bugetFlag1 = true;
                    }else if(fieldValue!=null&&fieldValue.startsWith("@[")){
                        bugetFlag2 = true;
                    }
                }else if(",101,".indexOf(showId+"")!=-1){_value="";}%></span><%if(!"999".equals(sysAttr)){%><input type="button" class="btnButton4font btnM" name="setDefaultValue" style="display:<%if(showId.equals("101") || showId.equals("110") || showId.equals("113") || showId.equals("116") || showId.equals("117")) out.print(""); else out.print("none");%>" onclick="setInputDefaultValue('<%=obj[10].toString()%>','<%=i%>');" value="默认值"><span name="bugetSelectSpan" style="display:<%if(",803,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>"><select name="bugetSelect" class="selectlist" style="width:21%;margin:0 5px 0 0;" onchange="selectBugetType(this, '<%=i%>');"><option value="" <%=bugetFlag0?"selected":""%>></option><option value="1" <%=bugetFlag1?"selected":""%>>计算字段</option><option value="2" <%=bugetFlag2?"selected":""%>>子表字段合计</option></select></span><span name="span207" style="display:<%if(",207,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>"><select name="select207" class="selectlist" style="width:50%;margin:0 5px 0 0;"><option value="full" <%="full".equals(_value)?"selected":""%>>组织长名称</option><option value="self" <%="self".equals(_value)?"selected":""%>>最末端组织</option><option value="parent" <%="parent".equals(_value)?"selected":""%>>最末端组织向上一级</option><option value="unit" <%="unit".equals(_value)?"selected":""%>>从本单位开始至末端</option></select></span><input type="button" class="btnButton4font btnM" name="selecttable" style="display:<%if(showId.equals("103") || showId.equals("104") || showId.equals("105") || showId.equals("402")) out.print(""); else out.print("none");%>" onclick="setSelectTable('<%=obj[10].toString()%>','<%=i%>','<%=_value%>');" value="选择表"><input type="button" class="btnButton4font btnM" name="setcount" style="display:<%if(showId.equals("203") || bugetFlag1) out.print(""); else out.print("none");%>" onclick="setCountField('<%=obj[1]%>','<%=tableId%>','<%=i%>','<%=_value%>');" value="设　置"><input type="button" class="btnButton4font btnM" name="autoCode" style="display:<%if(showId.equals("111")) out.print(""); else out.print("none");%>" onclick="setAutoCode('<%=obj[10].toString()%>','<%=i%>','<%=_value%>');" value="设　置"><input type="button" class="btnButton4font btnM" name="expression" style="display:<%if(showId.equals("403")) out.print(""); else out.print("none");%>" onclick="setExpression('<%=obj[1]%>','<%=tableId%>','<%=i%>','<%=_value%>');" value="设　置"><input type="button" class="btnButton4font btnM" name="sigleSelect" style="display:<%if(showId.equals("404")) out.print(""); else out.print("none");%>" onclick="setSelectPopTable('<%=obj[10].toString()%>','<%=i%>','<%=_value%>','sigle');" value="选择表"><input type="button" class="btnButton4font btnM" name="moreSelect" style="display:<%if(showId.equals("405")) out.print(""); else out.print("none");%>" onclick="setSelectPopTable('<%=obj[10].toString()%>','<%=i%>','<%=_value.replaceAll("#","\\$")%>','more');" value="选择表"><input type="button" class="btnButton4font btnM" name="selectSubTable" style="display:<%if((showId.equals("606")) || bugetFlag2) out.print(""); else out.print("none");%>" onclick="setSelectSubTable('<%=obj[10].toString()%>','<%=i%>','<%=_value%>','<%=tableId%>');" value="选择表"><span name="percentSpan" style="display:<%if(showId.equals("203")) out.print(""); else out.print("none");%>"><input type=hidden name="fieldPercent" value="<%=obj[11]!=null?obj[11].toString():""%>"><input type="checkbox" name="fieldPercentCHK" value="1" <%=obj[11]!=null&&"1".equals(obj[11].toString())?"checked":""%> onclick="changePercent(this,<%=i%>)">显示为百分率</span><span name="defSelectedSpan" style="display:<%if(",107,108,109,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>"><input type=hidden name="defSelected" value="<%=obj[12]!=null?obj[12].toString():""%>"><input type="checkbox" name="defSelectedCHK" value="1" <%=obj[12]!=null&&"1".equals(obj[12].toString())?"checked":""%> onclick="changeDefSelected(this,<%=i%>)">默认为空</span><span name="defaultCommentSpan" style="display:<%if(",401,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>"><select name="defaultComment" class="selectlist" style="width:40%;"><option value="0" <%=obj[12]!=null&&"0".equals(obj[12].toString())?"selected":""%>>签名+日期时间</option><option value="1" <%=obj[12]!=null&&"1".equals(obj[12].toString())?"selected":""%>>签名+日期</option><option value="2" <%=obj[12]!=null&&"2".equals(obj[12].toString())?"selected":""%>>仅签名</option></select></span><span name="span401" style="display:<%if(",401,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>">&nbsp;&nbsp;显示组织：<select name="select401" class="selectlist" style="width:40%;margin:0 5px 0 0;"><option value=""></option><option value="full" <%="full".equals(_value)?"selected":""%>>组织长名称</option><option value="self" <%="self".equals(_value)?"selected":""%>>最末端组织</option><option value="parent" <%="parent".equals(_value)?"selected":""%>>最末端组织向上一级</option><option value="unit" <%="unit".equals(_value)?"selected":""%>>从本单位开始至末端</option></select></span><span name="showDateSpan" style="display:<%if(",808,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>">结束：<select name="showDateEnd" class="selectlist" style="width:25%;"><%if(showDateArr!=null){for(int s0=0; s0<showDateArr.length; s0++){%><option value="<%=showDateArr[s0][2]%>" <%=(":"+fieldValue+":").indexOf(":"+showDateArr[s0][2]+":")!=-1?"selected":""%>><%=showDateArr[s0][1]%></option><%}}%></select>&nbsp;减&nbsp;开始：<select name="showDateStart" class="selectlist" style="width:25%;"><%if(showDateArr!=null){for(int s0=0; s0<showDateArr.length; s0++){%><option value="<%=showDateArr[s0][2]%>" <%=("|"+fieldValue+":").indexOf("|"+showDateArr[s0][2]+":")!=-1?"selected":""%> show="<%=showDateArr[s0][3]%>"><%=showDateArr[s0][1]%></option><%}}%></select>&nbsp;<select name="showDateType" class="selectlist" style="width:50px;"><option value="days" <%=(":"+fieldValue+":").indexOf(":days:")!=-1?"selected":""%>>天</option><option value="hours" <%=(":"+fieldValue+":").indexOf(":hours:")!=-1?"selected":""%>>小时</option></select><input type="hidden" name="showDateWorkday" value="<%=(":"+fieldValue+":").indexOf(":1:")!=-1?"1":"0"%>"><input <%=(":"+fieldValue+":").indexOf(":1:")!=-1?"checked":""%> type="checkbox" name="showDateWorkdayCHK" value="1" onclick="changeShowDateWorkday(this,<%=i%>)">只计算工作日</span><%}%><span name="defaultValueSet" style="<%if(",103,104,105,".indexOf(","+showId+",")==-1){%>display:none<%}%>">&nbsp;&nbsp;默认选中&nbsp;<input type="text" name="defaultSelectedValue" class="inputText" style="width:140px;" value="<%=fieldDefault%>" maxlength="60"/></span>
            </div><div name="amountTrans"></div><div name="commentTrans"></div><div name="outterTrans"></div><span name="objectSelect" style="display:<%if(",501,".indexOf(showId+"")!=-1) out.print(""); else out.print("none");%>"><%if(relationObject!=null){for(int j0=0; j0<relationObject.length; j0++){%><input type="checkbox" name="relationObject<%=i%>" value="<%=relationObject[j0][2]%>" <%=(","+_value+",").indexOf(","+relationObject[j0][2]+",")!=-1?"checked":""%>><%=relationObject[j0][1].replaceAll("相关","")%><%}}%></span>
        </td>
    </tr>
    <%}}%>

    <tr>
        <td colspan=6>
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td align=center>
                    <label class="MustFillColor">
                    <font id="remark101" name="remark101" style="display:none"><label class="MustFillColor">单行文本框输入。</label></font>
                    <font id="remark102" name="remark102" style="display:none"><label class="MustFillColor">显示*掩盖您输入的字符，存储密码的字段适用此类型。</label></font>
                    <font id="remark103" name="remark103" style="display:none"><label class="MustFillColor">采用<input type="radio">的方式提供选择。显示为<input type="radio" checked>万户<input type="radio">华为<br><br>有两种数据来源：<br>1、指定取值范围:请在取值范围一栏的输入框中指定取值:<br>&nbsp;&nbsp;形式：[值]/[显示文字];[值]/[显示文字];...。例：0/万户;1/汉斯;2/华为<br>2、从指定库中取值:请点击取值范围一栏的"选择表"按钮选择数据表。默认选中格式：显示值（如：万户）。</label></font>
                    <font id="remark104" name="remark104" style="display:none"><label class="MustFillColor">采用<input type="checkbox">的方式提供选择。显示为<input type="checkbox" checked>万户<input type="checkbox">汉斯<input type="checkbox" checked>华为<br><br>有两种数据来源：<br>1、指定取值范围:请在取值范围一栏的输入框中指定取值:<br>&nbsp;&nbsp;形式一：[值]/[显示文字];[值]/[显示文字];...。例：0/万户;1/汉斯;2/华为<br>&nbsp;&nbsp;形式二：[显示文字];[显示文字];...。例：万户;汉斯;华为<br>2、从指定库中取值:请点击取值范围一栏的"选择表"按钮选择数据表。默认选中格式：显示值（多个以逗号,分隔，如：万户,汉斯）。</label></font>
                    <font id="remark105" name="remark105" style="display:none"><label class="MustFillColor">采用<select></select>的方式提供选择。显示为<select><option>万户</option><option>汉斯</option><option>华为</option></select><br><br>有两种数据来源：<br>1、指定取值范围:请在取值范围一栏的输入框中指定取值:<br>&nbsp;&nbsp;形式一：[值]/[显示文字];[值]/[显示文字];...。例：0/万户;1/汉斯;2/华为<br>&nbsp;&nbsp;形式二：[显示文字];[显示文字];...。例：万户;汉斯;华为<br>2、从指定库中取值:请点击取值范围一栏的"选择表"按钮选择数据表。默认选中格式：显示值（如：万户）。</label></font>
                    <font id="remark107" name="remark107" style="display:none"><label class="MustFillColor">请输入日期的格式。可供选择的样式有：<br>&nbsp;&nbsp;[yyyy-mm-dd]<!-- [yy-mm-dd] --></label></font>
                    <font id="remark108" name="remark108" style="display:none"><label class="MustFillColor">请输入时间的格式。可供选择的样式有：<br>&nbsp;&nbsp;[hh:nn:ss]<!-- [hh:nn] --></label></font>
                    <font id="remark109" name="remark109" style="display:none"><label class="MustFillColor">请输入日期时间的格式。可供选择的样式有：<br>&nbsp;&nbsp;[yyyy-mm-dd hh:nn]<!-- [yyyy-mm-dd hh:nn] [yy-mm-dd hh:nn:ss] [yy-mm-dd hh:nn]--></label></font>
                    <font id="remark110" name="remark110" style="display:none"><label class="MustFillColor">文本框输入，字数小于2000字符(1000汉字)。</label></font>
                    <font id="remark111" name="remark111" style="display:none"><label class="MustFillColor">系统根据你的设置自动生成此字段的值。</label></font>
                    <font id="remark112" name="remark112" style="display:none"><label class="MustFillColor">从新打开的页面获取值。:<br>&nbsp;&nbsp;形式:[FileName].[ControlID].<br>&nbsp;&nbsp;例: [UploadFile.aspx].[myFile].前面是页面文件名，后者是页面上要取值控件的ID。
                    <br>请在取值范围的输入框中填入您的页面文件名和要取值控件ID值。</label></font>
                    <font id="remark113" name="remark113" style="display:none"><label class="MustFillColor">用于存储有HTML编辑框中获取的数据。（只适用于文本型字段）</label></font>
                    <font id="remark114" name="remark114" style="display:none"><label class="MustFillColor">用于存储图片的文件名。（只适用于字符型字段）</label></font>
                    <font id="remark115" name="remark115" style="display:none"><label class="MustFillColor">用于存储上传文件的文件名。（只适用于字符型字段）</label></font>
                    <font id="remark116" name="remark116" style="display:none"><label class="MustFillColor">用于存储从Word编辑器中获取的数据。（适用于字符型字段和文本型字段）</label></font>
                    <font id="remark117" name="remark117" style="display:none"><label class="MustFillColor">用于存储从Excel编辑器中获取的数据。（只适用于字符型字段）</label></font>
                    <font id="remark118" name="remark118" style="display:none"><label class="MustFillColor">用于存储从WPS编辑器中获取的数据。（只适用于字符型字段）</label></font>
                    <font id="remark201" name="remark201" style="display:none"><label class="MustFillColor">用于存储登录人ID。</label></font>
                    <font id="remark202" name="remark202" style="display:none"><label class="MustFillColor">用于存储登录人姓名。（只适用于字符型字段）</label></font>
                    <font id="remark203" name="remark203" style="display:none"><label class="MustFillColor">生成计算字段表达式。</label></font>
                    <font id="remark204" name="remark204" style="display:none"><label class="MustFillColor">用于存储当前日期。（只适用于字符型字段）</label></font>
                    <font id="remark206" name="remark206" style="display:none"><label class="MustFillColor">只适用于字符型字段。</label></font>
                    <font id="remark207" name="remark207" style="display:none"><label class="MustFillColor">用于存储登录人组织。</label></font>
                    <font id="remark208" name="remark208" style="display:none"><label class="MustFillColor">用于存储登录人群组ID。</label></font>
                    <font id="remark213" name="remark213" style="display:none"><label class="MustFillColor">用于存储登录人组织ID。</label></font>
                    <font id="remark210" name="remark210" style="display:none"><label class="MustFillColor">用于存储用户选择的人员。</label></font>
                    <font id="remark211" name="remark211" style="display:none"><label class="MustFillColor">用于存储用户选择的多个人员。</label></font>
                    <font id="remark212" name="remark212" style="display:none"><label class="MustFillColor">用于存储用户选择的单个组织。</label></font>
                    <font id="remark214" name="remark214" style="display:none"><label class="MustFillColor">用于存储用户选择的多个组织。</label></font>
                    <font id="remark215" name="remark215" style="display:none"><label class="MustFillColor">用于存储当前办理人姓名。（只适用于字符型字段）</label></font>
                    <font id="remark301" name="remark301" style="display:none"><label class="MustFillColor">用于存储金额。</label></font>
                    <font id="remark401" name="remark401" style="display:none"><label class="MustFillColor">用于存储批示意见，不能在数据列表中显示。（仅支持主表字段）</label></font>
                    <font id="remark402" name="remark402" style="display:none"><label class="MustFillColor">用于存储关联数据表字段的信息。</label></font>
                    <font id="remark403" name="remark403" style="display:none"><label class="MustFillColor">用于数据检索使用，在保存的时候不做处理。</label></font>
                    <font id="remark404" name="remark404" style="display:none"><label class="MustFillColor">用于单选弹出选择。</label></font>
                    <font id="remark405" name="remark405" style="display:none"><label class="MustFillColor">用于多选弹出选择。</label></font>
                    <font id="remark406" name="remark406" style="display:none"><label class="MustFillColor">用于存储登录人账号。</label></font>
                    <font id="remark501" name="remark501" style="display:none"><label class="MustFillColor">用于在页面选择相关对象信息。（仅支持主表字段）</label></font>
                    <font id="remark502" name="remark502" style="display:none"><label class="MustFillColor">用于在页面选择相关项目。</label></font>
                    <font id="remark302" name="remark302" style="display:none"><label class="MustFillColor">用于将金额小写转化为大写。</label></font>
                    <font id="remark601" name="remark601" style="display:none"><label class="MustFillColor">用于存储登录人英文名。</label></font>
                    <font id="remark602" name="remark602" style="display:none"><label class="MustFillColor">用于存储登录人工号。</label></font>
                    <font id="remark603" name="remark603" style="display:none"><label class="MustFillColor">用于存储登录人商务电话。</label></font>
                    <font id="remark604" name="remark604" style="display:none"><label class="MustFillColor">用于存储登录人职务。</label></font>
                    <font id="remark605" name="remark605" style="display:none"><label class="MustFillColor">用于存储登录人组织英文名。</label></font>
                    <font id="remark606" name="remark606" style="display:none"><label class="MustFillColor">用于对子表中的某一字段值进行合计。</label></font>
                    <font id="remark607" name="remark607" style="display:none"><label class="MustFillColor">用于存储登录人岗位。</label></font>
                    <font id="remark701" name="remark701" style="display:none"><label class="MustFillColor">用于显示批示意见的批示人和日期。</label></font>
                    <font id="remark702" name="remark702" style="display:none"><label class="MustFillColor">用于存储登录人姓名和日期。</label></font>
                    <font id="remark703" name="remark703" style="display:none"><label class="MustFillColor">用于存储当前日期时间。（只适用于字符型字段）</label></font>
                    <font id="remark704" name="remark704" style="display:none"><label class="MustFillColor">用于存储用户选择本组织的人员。</label></font>
                    <font id="remark705" name="remark705" style="display:none"><label class="MustFillColor">用于存储用户选择本组织的多个人员。</label></font>
                    <font id="remark706" name="remark706" style="display:none"><label class="MustFillColor">用于显示弹出窗口。</label></font>
                    <font id="remark707" name="remark707" style="display:none"><label class="MustFillColor">用于调用外部系统数据。</label></font>
                    <font id="remark708" name="remark708" style="display:none"><label class="MustFillColor">用于批量发起流程。<br>如秘书代报销流程、HR发起绩效考核流程等，由一个发起人选择多个用户，<br>分别发起这些用户的流程，发送到下一办理人处。（仅支持主表字段）</label></font>

                    <font id="remark801" name="remark801" style="display:none"><label class="MustFillColor">用于预算管理中的预算部门。</label></font>
                    <font id="remark802" name="remark802" style="display:none"><label class="MustFillColor">用于预算管理中的预算科目。</label></font>
                    <font id="remark803" name="remark803" style="display:none"><label class="MustFillColor">用于预算管理中的预算金额。</label></font>
                    <font id="remark804" name="remark804" style="display:none"><label class="MustFillColor">用于预算管理中的预算余额。</label></font>
                    <font id="remark805" name="remark805" style="display:none"><label class="MustFillColor">用于预算管理中的预算年月。</label></font>
                    <font id="remark806" name="remark806" style="display:none"><label class="MustFillColor">用于项目管理中的项目任务预算。</label></font>
                    <font id="remark807" name="remark807" style="display:none"><label class="MustFillColor">用于项目管理中的任务预算余额。</label></font>
                    <font id="remark808" name="remark808" style="display:none"><label class="MustFillColor">用于两个时间段内的日期时间计算。</label></font>
                    <font id="remark809" name="remark809" style="display:none"><label class="MustFillColor">用于显示批示人姓名。</label></font>
                    <font id="remark810" name="remark810" style="display:none"><label class="MustFillColor">用于显示批示人签名图片。</label></font>
                    <font id="remark999" name="remark999" style="display:none"><label class="MustFillColor">用于自定义模板展现方式。</label></font>
                    </label>
                </td>
            </tr>
        </table>
        </td>
    </tr>

    <tr class="Table_nobttomline" height=30>
        <td nowrap colspan=6>&nbsp;
            <input id="saveBtn" type="button" class="btnButton4font" onClick="saveFormData(0,this);" value="<s:text name="comm.save"/>" />
            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value="<s:text name="comm.reset"/>" />
        </td>
    </tr>
</table>
<!-- LIST TITLE PART END -->  

</s:form>
<IFRAME style="WIDTH: 0px; HEIGHT: 0px; diapay: none" id=ictiframe src="" border=0 frameborder=0></IFRAME>
</body>
<!--script src="<%=rootPath%>/scripts/main/whir.ready.js" type="text/javascript"></script-->
<script type="text/javascript">

//设置表单为异步提交  
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存', "callbackfunction":changeTab});

var isVerify = false;
function saveFormData(flag, obj){
    var fieldvalue = document.getElementsByName("fieldvalue");
     for (var i = 0; i < fieldvalue.length; i++) {
         if (fieldvalue[i].value.replace(/[^\x00-\xff]/g, "**").length > 2000) {
             whir_alert("取值范围不能超过2000个字符！", null);
             fieldvalue[i].focus();
             return false;
         }
         if (document.getElementsByName("fieldShow")[i].value == '111') { //自动编号
             if (fieldvalue[i].value.length <= 0) {
                 whir_alert("请设置自动编号！", null);
                 document.getElementsByName("fieldShow")[i].focus();
                 return false;
             }
         }
     }

    ok(flag, obj);

    isVerify = true;
}

function doIframe(){
    //document.getElementById('ictiframe').src = whirRootPath + "/platform/custom/custom_database/js/t.jsp";
}

var changed = false;
function isFormChanged() {   
    var isChanged = false;   
    var form = document.forms[0];   
    for (var i = 0; i < form.elements.length; i++) {   
        var element = form.elements[i];   
        var type    = element.type;   
        if (type == "text" || type == "hidden") {   
            if (element.value != element.defaultValue) {   
                isChanged = true;   
                break;   
            }   
        } else if (type == "radio" || type == "checkbox") {   
            if (element.checked != element.defaultChecked) {   
                isChanged = true;   
                break;   
            }   
        }
        if(element.tagName=="SELECT") {
        	for (var j = 0; j < element.options.length; j++) {   
                if (element.options[j].selected != element.options[j].defaultSelected) {   
                    isChanged = true;   
                    break;   
                }   
            }   
        }   
      
    }   
    return isChanged;   
}  

function initChangeEvent(){
	$("input[type=radio]").each(function(){
		$(this).change(function(){
			this.defaultValue=this.value;
		});
	});
	$("input[type=checkbox]").each(function(){
		$(this).change(function(){
			this.defaultValue=this.value;
		});
	});
	$("select").each(function(){
        for (var j = 0; j < this.options.length; j++) {   
            if (this.options[j].selected != this.options[j].defaultSelected) {   
                this.options[j].defaultSelected=this.options[j].selected;
            }   
        }   
	});
}

var _currentTargetTab = null;
function verifySave(){
    if(isVerify == false && isFormChanged()){
        return true;
    }
    return false;
}

//调用见whir.util.js:initTab
function confirmSave(_currentTarget){
    whir_confirm("您的操作需要保存吗?", function(){
        isVerify = true;
        _currentTargetTab = _currentTarget;
        saveFormData(0, document.getElementById('saveBtn'));
    },
    function(){
        isVerify = true;
        $(_currentTarget).click();
    });
}

function changeTab(){
    if(_currentTargetTab){
        $(_currentTargetTab).click();
        _currentTargetTab = null;
    }
}

$(document).ready(function(){
    initAmount();
    initComment();
    initCommentPerson();
    initCommentPersonSignImg();
    initOutterDataInterface();

    setTimeout(initChangeEvent, 100);
});
</script>
</html>