<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>  
<%@ page import="com.whir.ezoffice.information.common.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<script src="<%=rootPath%>/scripts/i18n/<%=whir_locale%>/InformationResource.js" type="text/javascript"></script>
</head>
<%
	String checkdepart = request.getParameter("checkdepart")==null?"":request.getParameter("checkdepart").toString();
%>
<body class="MainFrameBox">
<s:form name="queryForm" id="queryForm" action="InfoList!list.action" method="post" theme="simple">
	<%@ include file="/public/include/form_list.jsp"%>
	<input type="hidden" name="checkdepart"    id="checkdepart"    value="<%=checkdepart%>" />
	<s:hidden id="channelType" name="channelType" />
	<s:hidden id="userDefine" name="userDefine" />
	<s:hidden id="userChannelName" name="userChannelName" />
	<s:hidden id="type" name="type" />
	<s:hidden id="channelId" name="channelId" />
	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="searchTable" class="SearchBar" style="display:none;">  
        <tr>
            <td class="whir_td_searchtitle">  
				<s:text name="info.columnname"/>：
			</td>
			<td class="whir_td_searchinput">
				<select id="searchChannels" name="searchChannels">
					<option value="0">===<s:text name="info.pselectcolumn"/>===</option>
					<%
					List list = (List)request.getAttribute("channelList");
					for(int i=0;i<list.size();i++){
						Object[] obj = (Object[])list.get(i);
					%>
					<option value='<%=obj[0]%>'><%=obj[1].toString()%></option>
					<%}%>
				</select>
			</td> 
			<td class="whir_td_searchtitle">  
				<s:text name="info.searchareadepartment"/>：
			</td>
			<td class="whir_td_searchinput">
				<s:hidden id="searchOrgId" name="searchOrgId"/>
				<s:textfield name="searchOrgName" id="searchOrgName" cssClass="inputText" cssStyle="width:97%" readonly="true"/><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'searchOrgId', allowName:'searchOrgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a>  
			</td>
			<td class="whir_td_searchtitle">  
				<s:text name="info.searchareaattachment"/>：
			</td>
			<td class="whir_td_searchinput">
				<s:textfield name="append" id="append" cssClass="inputText" />
			</td>
        </tr>
		<tr>
			<td class="whir_td_searchtitle">  
				<s:text name="info.searchareatitle"/>：
			</td>
			<td class="whir_td_searchinput">
				<s:textfield name="title" id="title" cssClass="inputText" cssStyle="width:95%"/>
			</td>
			<td class="whir_td_searchtitle">  
				<s:text name="info.newinfosecondtitle"/>：
			</td>
			<td class="whir_td_searchinput">
				<s:textfield name="subtitle" id="subtitle" cssClass="inputText" cssStyle="width:97%"/>
			</td>
			<td class="whir_td_searchtitle">  
				<s:text name="info.searchareakey"/>：
			</td>
			<td class="whir_td_searchinput">
				<s:textfield name="key" id="key" cssClass="inputText"/>
			</td>
		</tr>
		<tr>
			<td class="whir_td_searchtitle">  
				<s:text name="info.searchareapublisher"/>：
			</td>
			<td class="whir_td_searchinput">
				<s:textfield name="searchIssuerName" id="searchIssuerName" cssClass="inputText" cssStyle="width:95%"/>
			</td>
			<td class="whir_td_searchtitle">  
				<s:text name="info.searchareapubdate"/>：
			</td>
			<td class="whir_td_searchinput" colspan="2">
				<s:textfield name="startDate" id="startDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\\'endDate\\')}'})"/>&nbsp;<s:text name="info.to"/>&nbsp;<s:textfield name="endDate" id="endDate" cssClass="Wdate whir_datebox" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\\'startDate\\')}'})" />
			</td>
			<td align="right">
                <input type="button" class="btnButton4font" onclick="refreshListForm('queryForm');"  value="<s:text name='comm.searchnow'/>" />
				<!--resetForm(obj)为公共方法-->
                <input type="button" class="btnButton4font" onclick="resetForm(this);" value="<s:text name='comm.clear'/>" />
            </td>
		</tr>
		<tr style="display:none;">
            <td >  
				全文检索关键字：
			</td>
			<td colspan="3">
				<s:textfield name="retrievalKey" id="retrievalKey" cssClass="inputText" cssStyle="width:500px;"/>
			</td> 
			<td colspan="2" align="right">
				<input type="button" class="btnButton4font" onclick="retrievalAllser();"  value="全文检索" />
			</td>
        </tr>
    </table>

	<table width="100%" height="35px" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">  
        <tr>
			<td>
				<div class="whir_public_movebg">  
					<div class="whir_flright Public_tag" style="float:right;">  
						<div id="whir_titlesearch">  
							<%--<s:if test="channelId!='' && channelId!=null && #request.hasRight">
								<input type="button" class="btnButton4font" onclick="batchSetCommend();"  value="<s:text name='info.allsuggest'/>" />
								<input type="button" class="btnButton4font" onclick="transfer();"  value="<s:text name='info.alltransfer'/>" />
								<input type="button" class="btnButton4font" onclick="batchDelete();"  value="<s:text name='info.alldeleteselect'/>" />
							</s:if>--%>
								<input type="button" class="btnButton4font" onclick="chSearch(this);"  value="<s:text name='comm.opensearch'/>" />  
						</div>  
					</div>  
				   
					<s:if test='#request.onlyRetrievalAll != 1'>
					<div class="Public_tag">  
						<ul>  
							<li id="list" onclick="list();"><span class="tag_center"><s:text name="comm.list" /></span><span class="tag_right"></span></li>  
							<li id="detail" onclick="detail();"><span class="tag_center"><s:text name="comm.detail" /></span><span class="tag_right"></span></li>  
							<s:if test="channelId!='' && channelId!=null">
							<li id="thumb" class="tag_aon" onclick="thumbnail();"><span class="tag_center"><s:text name="info.allthumbnail" /></span><span class="tag_right"></span></li>
							</s:if>
						</ul>
					</div>
					</s:if>
				</div>
			</td>
		</tr>
	</table>
	
	<div class="divborder2">
		<ul id="itemContainer" class="pic_column">
			
		</ul>
		<div class="clear_0"></div>
	</div>

	<table width="100%" border="0" cellpadding="0" cellspacing="0" class="Pagebar">
        <tr>
            <td>
                <%@ include file="/public/page/pager.jsp"%>
            </td>
        </tr>
    </table>
</s:form>
<%@ include file="/public/include/include_extjs.jsp"%>
<script language="javascript">
Ext.onReady(function() {
	var modelCombo = Ext.create('Ext.form.field.ComboBox', {
		id: 'channelId',
		typeAhead: true,
		transform: 'searchChannels',
		hiddenName: 'searchChannel',
		width: 213,
		forceSelection: true,
		//emptyText: '--请选择--',
		listeners: {
			select: function(combo, record, index) {
				
			}
		}
	});

	initInfoListFormToAjax({formId:"queryForm"});
});

//查询前判断日期
function searchBefore(){
	var startDate = $("#startDate").val();
	var endDate = $("#endDate").val();
	if($(":checkbox[name='searchDate']").attr("checked")=="checked"){
		if(startDate==null || startDate==''){
			alert('请选择开始日期');
			return;
		}
		if(endDate==null || endDate==''){
			alert('请选择结束日期');
			return;
		}
	}
	refreshListForm('queryForm');
}

//列表页签
function list(){
	$("#list").addClass("tag_aon");
	$("#detail").removeClass();
	$("#thumb").removeClass();
	location_href("<%=rootPath%>/InfoList!allInfo.action?type="+$("#type").val()+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val()+"&userChannelName="+$("#userChannelName").val()+"&listType=1"+"&channelId="+$("#channelId").val());
}

//详细页签
function detail(){
	$("#detail").addClass("tag_aon");
	$("#list").removeClass();
	$("#thumb").removeClass();
	location_href("<%=rootPath%>/InfoList!allList.action?type="+$("#type").val()+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val()+"&userChannelName="+$("#userChannelName").val()+"&channelId="+$("#channelId").val());
}

//缩略图页签
function thumbnail(){
	$("#thumb").addClass("tag_aon");
	$("#list").removeClass();
	$("#detail").removeClass();
	location_href("<%=rootPath%>/InfoList!allThumb.action?type="+$("#type").val()+"&checkdepart="+$('#checkdepart').val()+"&channelType="+$("#channelType").val()+"&userDefine="+$("#userDefine").val()+"&userChannelName="+$("#userChannelName").val()+"&channelId="+$("#channelId").val());
}

//打开/关闭查询
function chSearch(obj){
	if(obj.value == "<s:text name='info.opensearch'/>"){
		obj.value = "<s:text name='comm.closesearch'/>";
		$("#searchTable").show();
	}else{
		obj.value = "<s:text name='info.opensearch'/>";
		$("#searchTable").hide();
	}
}

//初始化数据(待完善)
function initInfoListFormToAjax(formJson){
	var formJson_ = eval(formJson);
	var formId = formJson_.formId;
	//分页参数等html、公共js事件绑定
	initList(formId);
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		beforeSend:function(){
			$.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
		},
		success:function(responseText){
			$.dialog({id:"Tips"}).close();
			jq_form.find("#itemContainer").html("");
			//解析服务器返回的json字符串
			var json = eval("("+responseText+")").data;
			var pager = json.pager;
			var data = json.data;
			//分页信息
			jq_form.find("#page_count").val(pager.pageCount);
			jq_form.find("#recordCount").val(pager.recordCount);
			//循环数据信息
			var li = '';			
			var now = new Date();
			for (var i=0; i<data.length; i++) {
				var po = data[i];	
				//是否新信息
				var isNew = '';
				var fileImg = '';//信息中的图片
				var informationIssueTime = po.informationIssueTime;
	            var now = new Date();
	            var issueDate = new Date(informationIssueTime.replace(/-/g,"/"));
                var newInfoDeadLine = parseInt(po.newInfoDeadLine);
				if(now.getTime() - issueDate.getTime() < 3600*24*1000*newInfoDeadLine){
					isNew = " <img src='<%=rootPath%>/images/new.gif' width='28' height='11'>";
				}
				//信息中的图片
				var picSaveName = $.ajax({
					type:'post',
					url: whirRootPath+'/Information!getOneInfoPic.action?informationId='+po.informationId,
					async: false
				}).responseText;
				var picType = picSaveName.substring(picSaveName.indexOf(".")+1);
				var picPath = picSaveName.substring(0,6);
				if(picSaveName!='' && (picType.toUpperCase()=='JPG' || picType.toUpperCase()=='JPEG' || picType.toUpperCase()=='GIF' ||			picType.toUpperCase()=='BMP' || picType.toUpperCase()=='PNG')){
					fileImg = '<img id="infoPhoto" width="134px" height="100px" src="<%=preUrl%>/upload/information/'+picPath+'/'+picSaveName+'">';
				} else {
					fileImg = '<img id="infoPhoto" width="134px" height="100px" src="'+whirRootPath+'/images/nophoto.gif">';
				}
				//信息标题是否红色
				var title = HtmlEncode(po.informationTitle);
				if(po.titleColor==1){
					title = '<font color="red">'+HtmlEncode(po.informationTitle)+'</font>';
				}
				//是否精华信息
				if(po.informationIsCommend==1){
					title = "<img src='<%=rootPath%>/images/addgood.gif' >&nbsp;"+title;
				}
				li += '<li style="height:150px;overflow:hidden;text-overflow:ellipsis;"><table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td class="Imgbox" valign="middle"><a href="javascript:void(0);" onclick="openWin({url:\'Information!view.action?informationId='+po.informationId+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.informationId+'\',isFull:true});">'+fileImg+'</a></td></tr></table><div class="picInfo"><input type="checkbox" name="informationId" id="informationId" value="'+po.informationId+'"><a href="javascript:void(0);" title='+po.informationTitle+'  onclick="openWin({url:\'Information!view.action?informationId='+po.informationId+'&informationType='+po.informationType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+po.channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&checkdepart='+$('#checkdepart').val()+'\',winName:\'viewInfo'+po.informationId+'\',isFull:true});">'+title+'</a>'+isNew+'</div></li>'
			}
			jq_form.find("#itemContainer").append(li);
			setList(formId);
			//如果没有查询到记录，给出提示
			if(data.length == 0){
				var no_record_tip = '<div style="width:100%;text-align:center;"><div style="260px;text-align:center;font-size:12px;" >'+comm.norecord+'</div></div>';
				jq_form.find("#itemContainer").append(no_record_tip);
				jq_form.find(".page").hide();
			}
			//调用回调事件
			if(formJson_.onLoadSuccessAfter){
			    formJson_.onLoadSuccessAfter.call(this);
			}
			
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	$("#"+formId).submit();
}

//批量设置精华
function batchSetCommend(url){
	var informationId = getCheckBoxData("informationId", "value");
	if(informationId!=""){
		whir_confirm("<s:text name='info.confirmsuggest'/>",function(){
			ajaxOperate({urlWithData:'Information!setCommend.action?informationId='+informationId,tip:'设置精华',isconfirm:false,formId:'queryForm'});
		});
	}else{
		whir_alert('<s:text name="info.notselectedrecords"/>');
	}
}

//批量转移
function transfer(){
	var informationId = getCheckBoxData("informationId", "value"); 
	if(informationId!=""){
		whir_confirm("<s:text name='info.confirmtransfer'/>",function(){
			openWin({url:'Information!toTransfer.action?informationId='+informationId+'&channelId='+$("#channelId").val()+'&userChannelName='+$("#userChannelName").val(),winName:'transferInfo',width:600,height:240});
		//ajaxOperate({urlWithData:'Information!toTransfer.action?informationId='+informationId+'&channelId='+$("#channelId").val(),tip:'转移',isconfirm:false,formId:'queryForm'});
		});
	}else{
		whir_alert('<s:text name="info.notselectedrecords"/>');
	}
}

//批量删除
function batchDelete(){
	var informationId = getCheckBoxData("informationId", "value"); 
	if(informationId!=''){
		whir_confirm("<s:text name='info.confirmdelete'/>",function(){
			ajaxOperate({urlWithData:'Information!batchDelete.action?informationId='+informationId,tip:'批量删除',isconfirm:false,formId:'queryForm'});
		});
	}else{
		whir_alert('<s:text name="info.notselectedrecords"/>');
	}
}
</script>
</body>
</html>