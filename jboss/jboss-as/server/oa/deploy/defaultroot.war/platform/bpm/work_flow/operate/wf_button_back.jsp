<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
List flowedActivityList=new ArrayList();
if(request.getAttribute("flowedActivityList")!=null){
	flowedActivityList=(List)request.getAttribute("flowedActivityList");
}

List officelist =new ArrayList();
if(request.getAttribute("officelist")!=null){
   officelist =(List)request.getAttribute("officelist");
}
String backMailRange =request.getAttribute("backMailRange")==null?"":request.getAttribute("backMailRange").toString();
String curIsForkTask=request.getAttribute("p_wf_isForkTask")==null?"":request.getAttribute("p_wf_isForkTask").toString();

//是否有短信权限
boolean showSmsRemind=false;
if(request.getAttribute("showSmsRemind")!=null&&request.getAttribute("showSmsRemind").toString().equals("true")){
   showSmsRemind=true;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>退回</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<%@ include file="/public/include/meta_base.jsp"%>
<style type="text/css">
<!--
#noteDiv {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
	background-color:#ffffff;
}

#noteDiv1 {
	position:absolute;
	width:220px;
	height:126px;
	z-index:1;
	overflow:auto;
	border:1px solid #829FBB;
	display:none;
}
.divOver{
    background-color:#003399;
	color:#FFFFFF;
	border-bottom:1px dashed #cccccc;
    width:100%;
	height:20px;
	line-height:20px;
	cursor:default;
	padding-left:5px;
}
.divOut{
    background-color:#ffffff;
	color:#000000;
	border-bottom:1px dashed #cccccc;
    width:100%;
	height:20px;
	line-height:20px;
	cursor:default;
	padding-left:5px;
}
-->
</style>
</head>
<body>
<div class="BodyMargin_10">  
   <div class="docBoxNoPanel">
    <input type="hidden" name="addDivContent"  id="addDivContent" value=""> <!-- 在  常用语中用到-->
	 <table width="100%" border="0" cellspacing="2" cellpadding="0" class="Table_bottomline">
	  <tr>
		<td width="85" valign="top"  class="td_lefttitle"><bean:message bundle="workflow" key="workflow.back_step"/><span class="MustFillColor">*</span>：</td>
		<td>
		  <select size="4" name="include_backActivity"   id="include_backActivity" style="width: 98%; height: 100px;">
			 <%
					String[] tmp = null;
					String tempActivityName="";
					String tempActivityId="";
					String tempStep="";
					int  userIndex=0;
					String forkStepCount="";
					String forkStepCountName="";

					for(int i = 0; i < flowedActivityList.size(); i ++){
						  tmp = (String[]) flowedActivityList.get(i);//tmp[0] 活动ID,tmp[1] 活动名称,tmp[2] 活动步骤数 
						  forkStepCount="";
						  forkStepCountName="";
						  //分支步骤的退回
						  if(curIsForkTask.equals("1")){ 
							  forkStepCount=","+tmp[5];
							  forkStepCountName=Resource.getValue(local,"workflow","workflow.back_forkSection")+tmp[5]+Resource.getValue(local,"workflow","workflow.back_step1");
						  }
						  if(!tempActivityId.equals("")&&!tmp[0].equals(tempActivityId)){
							  if(userIndex!=1){
			  %>
						<option
							value='<%=tempActivityId + "," + tempStep + "," + tempActivityName + ",-1," + tempActivityName+Resource.getValue(local,"workflow","workflow.back_linktransactor")+forkStepCount%>'
							style="color: red"><%=tempActivityName%>:<%=tempActivityName%><%=Resource.getValue(local,"workflow","workflow.back_linktransactor")%><%=Resource.getValue(local,"workflow","workflow.back_Section")%><%=tempStep%><%=Resource.getValue(local,"workflow","workflow.back_step1")%><%=forkStepCountName%></option>
			 <% 
							  }
							  userIndex=0;
						  }
						  tempActivityId=tmp[0];
						  tempActivityName=tmp[1];
						  tempStep=tmp[2];
						  userIndex++;
			 %>
						<option
							value='<%=tmp[0] + "," + tmp[2] + "," + tmp[1] + "," + tmp[3]+ "," + tmp[4]+forkStepCount%>'><%=tmp[1]%>:<%=tmp[4]%><%=Resource.getValue(local,"workflow","workflow.back_Section")%><%=tmp[2]%><%=Resource.getValue(local,"workflow","workflow.back_step1")%><%=forkStepCountName%></option>
			 <%
					   }
			 %>
			 <%        if(userIndex!=1&&tempActivityName!=null&&!tempActivityName.equals("")&&!tempActivityName.equals("null")){%>
						<option
							value='<%=tempActivityId + "," + tempStep + "," + tempActivityName + ",-1," + tempActivityName+Resource.getValue(local,"workflow","workflow.back_linktransactor")+forkStepCount%>'
							style="color: red"><%=tempActivityName%>:<%=tempActivityName%><%=Resource.getValue(local,"workflow","workflow.back_linktransactor")%><%=Resource.getValue(local,"workflow","workflow.back_Section")%><%=tempStep%><%=Resource.getValue(local,"workflow","workflow.back_step1")%><%=forkStepCountName%></option>
			 <%        }
			 %>
						<option value=0>
							<!-- 发起人 -->
							<bean:message bundle="workflow" key="workflow.Sponsor" />
						</option>
			  </select>
		</td>
		<td>&nbsp;</td>
	  </tr>
	  <tr>
		 <td></td>
		 <td>
			 <div align="right"   style="text-align:right;width: 98%;"><a  id="trigger1" href="javascript:;"  rel="noteDiv" ><!-- 常用语 --><%=Resource.getValue(local,"workflow","workflow.Frequentusedwords")%></a></div>
				 <div id="noteDiv"  value="commentTxt" >
				 <%
				  if(officelist!=null&&officelist.size()>0){
				   for(int i=0;i<officelist.size();i++){
					 String offContent=""+officelist.get(i);%>
					  <div class="divOut"  onmouseover="this.className='divOver'" onmouseout="this.className='divOut'" onclick="include_set_comment(this,'commentTxt')"><%=offContent%></div>
				   <%}
				 }
				 %>
				 <div class="divOut"><a href="#"  onclick="addOffical();">>><!-- 添加 --><%=Resource.getValue(local,"workflow","workflow.newactivitydefineadd")%></a></div>
			  </div> 
		  </td>
	  </tr>
	  <tr >
		<td width="85" valign="top"  class="td_lefttitle" for="<bean:message bundle="workflow" key="workflow.back_reason"/>"><bean:message bundle="workflow" key="workflow.back_reason"/><span class="MustFillColor">*</span>：</td>
		<td>  
			  <textarea name="commentTxt" id="commentTxt" rows="6" class="inputTextarea" style="width: 98%;"  maxlength="500" ></textarea>
		</td>
		<td>&nbsp;</td>
	  </tr>
	  
	  <tr class="Table_nobttomline">
		<td width="85" valign="top"  class="td_lefttitle">&nbsp;</td>
		<td><div><%=Resource.getValue(local,"workflow","workflow.EmailReminder")%>：
		  <input type="radio" name="backRemindRange" id="backRemindRange" value="0"
			<%if(backMailRange.equals("0"))out.print("checked");%>><%=Resource.getValue(local,"workflow","workflow.ReturnPartOfManagers")%><!--退回环节经办人-->
		   <input type="radio" name="backRemindRange" id="backRemindRange"
			value="1" <%if(backMailRange.equals("1"))out.print("checked");%>><%=Resource.getValue(local,"workflow","workflow.AllParticipator")%>
			<!--所有经办人-->
			<span <%=showSmsRemind?"":"style='display:none'"%> ><input type="checkbox" id="needSendMsgcheck" name="needSendMsgcheck" /><bean:message bundle="workflow" key="workflow.activitysmsremind"/></span></div>
		   </td>
	  </tr>
	  <tr class="Table_nobttomline">
		  <td > </td>
		  <td > 
			<div ><input name="input2"  id="back_button" type="button" value='<%=Resource.getValue(local,"workflow","workflow.button_ok")%>' class="btnButton4font" onclick="dealProcess(0,this);" />
					<input name="input2" type="button" value='<%=Resource.getValue(local,"workflow","workflow.button_cancel")%>' class="btnButton4font" onclick="thisClose();" />
			</div>
		  </td>
		  <td>&nbsp;</td>
	   </tr>
   </table>
 </div>
</div>
<!--解决 浮动层 被Object 覆盖的问题加的  注意  z-Index:-1 -->
<!-- <iframe id='iframebar' src="about:blank" frameBorder=0 marginHeight=0 marginWidth=0 style="position:absolute; visibility:inherit; top:6px; left:6px;height:98%;width:98%; z-Index:-1; filter='progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)';">
</iframe> -->
<!-- <iframe id='iframebar' src="about:blank" frameBorder=0 marginHeight=0 marginWidth=0 style="position:absolute; visibility:inherit; top:6px; left:6px;height:98%;width:98%; z-Index:-1;filter:alpha(opacity=0);opacity:0;-ms-filter:'progid:DXImageTransform.Microsoft.Alpha(Opacity=0)';">
</iframe> -->
<div class="ezFLOW_overlay"></div>
<div id="ezFLOW_AjaxLoading" class="ezFLOW_showbox">
	<div class="ezFLOW_loadingWord"><img src="<%=rootPath%>/images/loading20.gif"><%=Resource.getValue(local,"workflow","workflow.watingdeal")%></div>
</div>
<style type="text/css">
<!--
 
.ezFLOW_overlay{position:fixed;top:0;right:0;bottom:0;left:0;z-index:998;width:100%;height:100%;_padding:0 20px 0 0;background:#f6f4f5;display:none;}
.ezFLOW_showbox{position:fixed;top:0;left:50%;z-index:9999;opacity:0;filter:alpha(opacity=0);margin-left:-80px;}
*html .ezFLOW_showbox,*html .ezFLOW_overlay{position:absolute;top:expression(eval(document.documentElement.scrollTop));}
#ezFLOW_AjaxLoading{border:1px solid #8CBEDA;color:#37a;font-size:12px;font-weight:bold;}
#ezFLOW_AjaxLoading div.ezFLOW_loadingWord{width:180px;height:50px;line-height:50px;border:1px solid #D6E7F2;background:#fff;}
#ezFLOW_AjaxLoading img{margin:10px 15px;float:left;display:inline;}


-->
</style>

<script type="text/javascript"> 


 //只有退回发起人是偶， 默认选择退回发起人
 if($("#include_backActivity option").length==1){
　　 $("#include_backActivity option").each(function(){ 
　　　　 $(this).attr("selected", true); 　
　　 })
 }

 var api =null;
 var W=null;
 api=frameElement.api, W = api.opener; 

 var DG = frameElement.lhgDG
 

// 给 常用语添加 弹出层
$("#trigger1").powerFloat();



/**
常用语添加
*/
function addDivContent(){
	var adddivcontent=$("#addDivContent").val();
	var comment=document.getElementById("noteDiv").getAttribute("value");
	document.getElementById("noteDiv").innerHTML= ""+"<div class='divOut' onmouseover='this.className=\"divOver\"' onmouseout='this.className=\"divOut\"' onclick=\"include_set_comment(this,\'"+comment+"\');\">"+adddivcontent+"<\/div>"+document.getElementById("noteDiv").innerHTML;
}

/**
新加常用语
*/
function  addOffical(){
	//
    var openurl='<%=rootPath%>/OfficalDictionAction!addOfficalDiction.action';
    openWin({url:openurl,width:600,height:300,winName:''});
}


/**
设置批示意见框里的值
*/
function include_set_comment(obj,commentName){
	var val=$(obj).text();
    var  cobj=document.getElementById(commentName);
	if(cobj.length){
        cobj[0].value=cobj[0].value+val;
	} else{
		cobj.value=cobj.value+val;
	}
}
 
/**
关闭当前的对话框
*/
 function  thisClose(){
      //$.dialog({id:'workflowDialog'}).close(); 
	  api.close();
 }
  
  
//新保存
function dealProcess(type,obj){
	if($("#commentTxt").val()==null || $("#commentTxt").val()==''){ 
		whir_alert("<%=Resource.getValue(local,"workflow","workflow.back_reason")%>不能为空！",function(){},api);
		return false;
	}

	if($("#commentTxt").val()!=null&&$("#commentTxt").val().length>500){ 
		whir_alert("<%=Resource.getValue(local,"workflow","workflow.back_reason")%>长度不能超过500！",function(){},api);
		return false;
	}

    //重置
	$("#workflow_hiddenDiv").html("");
	var include_backActivity_val=$("#include_backActivity").val()
    if(include_backActivity_val==null||include_backActivity_val==""){
		 //$.dialog.alert("<%=Resource.getValue(local,"filetransact","file.selreturnstep")%>",function(){},api);
	     whir_alert("<%=Resource.getValue(local,"filetransact","file.selreturnstep")%>",function(){},api);
		 return;
	}
	//退回意见
	$('#back_comment',W.document).val($("#commentTxt").val());
    var backRemindRangeObj=$('input[name=backRemindRange]:checked');  
	 //退回  邮件提醒的范围
    var backRemindRangeValue =backRemindRangeObj.val();
	$('#backRemindRange',W.document).val(backRemindRangeValue); 

 

	var backActivityName=include_backActivity_val.split(",")[2];

 

	if(backActivityName==null||backActivityName==""){
		backActivityName="<%=Resource.getValue(local,"workflow","workflow.Sponsor")%>";
	} 
    whir_confirm('<%=Resource.getValue(local,"filetransact","file.confirmreturn")%>'+backActivityName+'?', function (){ back();},function(){},api) ;    

   /* W.$.dialog.confirm('<%=Resource.getValue(local,"filetransact","file.confirmreturn")%>'+backActivityName+'?',function (){ back();},function (){},$.dialog({id:'workflowDialog'}));*/
 
}

function  back(){


 
	/* whir_tips("正在退回中", 1000, "", function(){}, api);

	 W.$.dialog.tips("正在退回中", 1000, "", function(){}, false);*/
    //短信
   if($("#needSendMsgcheck").attr("checked")=="checked"){
		$("#needSendMsg",W.document).val("1"); 
   } 
   parent.include_backSubmit($("#include_backActivity").val());  


  

   //设置按钮不可用
   $("#back_button").attr("disabled", "disabled"); 
     //控制弹出层的最大化
    var h = $(document).height();
	$(".ezFLOW_showbox").show();
    $(".ezFLOW_overlay").css({"height": h });
    $(".ezFLOW_overlay").css({'display':'block','opacity':'0.8'});
    $(".ezFLOW_showbox").stop(true).animate({'margin-top':'100px','opacity':'1'},200); 
}
 
</script>
</body>
</html>
