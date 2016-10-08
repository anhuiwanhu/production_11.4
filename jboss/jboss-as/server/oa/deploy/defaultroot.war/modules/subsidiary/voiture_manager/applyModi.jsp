<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>

<%
    String voitureId = "";
	if(request.getAttribute("voitureId") !=null){
	    voitureId = request.getAttribute("voitureId").toString();
	}
	String userId = session.getAttribute("userId").toString();
    String userName = session.getAttribute("userName").toString();
	String orgId = session.getAttribute("orgId").toString();
	String orgName = session.getAttribute("orgName").toString();
    com.whir.ezoffice.voiture.po.VoitureApplyPO voitureApplyPO=null;
    if(request.getAttribute("voitureApplyPO") !=null){
	    voitureApplyPO = (com.whir.ezoffice.voiture.po.VoitureApplyPO)request.getAttribute("voitureApplyPO");
	}
    Date startDate = new Date();
    Date endDate = new Date();
    String startTime="";
    String endTime="";

    String startHour="";
    String startMinute="";
    String endHour="";
    String endMinute="";
    if(voitureApplyPO != null){
        startDate=voitureApplyPO.getStartDate();
        endDate=voitureApplyPO.getEndDate();
        voitureId=voitureApplyPO.getVoitureId()+"";
        startTime=voitureApplyPO.getStartTime()+"";
        endTime=voitureApplyPO.getEndTime()+"";
    }
    if(startTime != null && !startTime.equals("")){
        startHour=startTime.split(":")[0];
        startMinute=startTime.split(":")[1];
    }
    if(endTime != null && !endTime.equals("")){
        endHour=endTime.split(":")[0];
        endMinute=endTime.split(":")[1];
    }
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
    String curModifyField=request.getAttribute("p_wf_cur_ModifyField")==null?"":request.getAttribute("p_wf_cur_ModifyField").toString();
    String p_wf_openType = request.getParameter("p_wf_openType")==null?"":request.getParameter("p_wf_openType").toString();
    // reStart重新发起
    // startAgain再次发起
    String resubmit="";
    if(p_wf_openType.equals("reStart")){
        resubmit="1";
    }
     String canview = request.getParameter("canview")==null?"":request.getParameter("canview").toString();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><%if(canview.equals("1")){%>查看申请<%}else{%>申请处理<%}%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <%@ include file="/public/include/meta_base_head.jsp"%>
    <%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--工作流包含页 js文件-->  
	<%@ include file="/public/include/meta_base_bpm.jsp"%>
    <!--这里可以追加导入模块内私有的js文件或css文件-->      
    <style TYPE="text/css">
<!--
#receiveForm{
  background-color:#000000;
}
.receiveForm td{
  font-size:12px;
  background-color:#ffffff;
}
.doc_Content{ padding:20px 0px;}
.doc_Content td{ padding:5px;}
//-->
</style>
<SCRIPT LANGUAGE="JavaScript">
    //打印
     function cmdPrint(){
         var val='<%=rootPath%>/modules/subsidiary/voiture_manager/printWord.jsp';
        openWin({url:val,width:800,height:400,winName:'printWord'});
    }
    </SCRIPT>
</head>
<body  onload="initBody();" scroll=no class="docBodyStyle">
    <!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
     <div class="doc_Scroll">
    <s:form name="dataForm" id="dataForm" action="${ctx}/voitureApply!save.action" method="post" theme="simple" >
	 <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
         <tr valign="top">
             <td height="100%">
	            <div class="docbox_noline">
					   <div class="doc_Movetitle">
						 <ul>
							  <li class="aon"  id="Panle0"><a href="javascript:void(0);" onClick="changePanle(0);" >基本信息</a></li>
							  <li id="Panle1"><a href="javascript:void(0);" onClick="changePanle(1);">流程图</a></li> 
                              <li id="Panle2" ><a href="javascript:void(0);" onClick="changePanle(2);">流程记录</a></li>
							  <li id="Panle3" ><a href="javascript:void(0);" onClick="changePanle(3);">相关流程<span class="redBold" id="viewrelationnum"></span></a></li>
                              <li id="Panle4" ><a href="javascript:void(0);" onClick="changePanle(4);">相关附件<span class="redBold" id="viewaccnum"></span></a></li>
						 </ul>
					   </div>  
                       <div class="clearboth"></div>  
                       <div id="docinfo0" class="doc_Content">
							<!--表单包含页-->
                              <table width="100%"  border="0" cellpadding="2" cellspacing="1" class="docBoxNoPanel">
                                    <s:hidden name="voitureApplyPO.voitureId" id="voitureId"/>
                                    <s:hidden name="voitureApplyPO.id" id="id"/>
                                    <tr>
                                        <td for="车辆名称" width="9%" class="td_lefttitle" nowrap="nowrap">
                                            车辆名称<span class="MustFillColor">*</span>：
                                        </td>
                                        <td width="40%">
                                          <s:textfield name="voiturePO.name" id="name" cssClass="inputText" cssStyle="width:95%" readonly="true"/>
                                        </td>
                                        <td for="申请部门" width="9%" class="td_lefttitle" nowrap="nowrap">
                                            申请部门：
                                        </td>
                                        <td>
                                             <s:textfield name="voitureApplyPO.orgName" id="orgName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]"  maxlength="100" readonly="true" cssStyle="width:95%"/>
                                             <%if (curModifyField.indexOf("$voitureApplyPO.orgName$") > -1 || "1".equals(resubmit)){%>
                                             <a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'orgId', allowName:'orgName', select:'org', single:'yes', show:'org', range:'*0*'});"></a>
                                                <%}%>
                                                <s:hidden name="voitureApplyPO.orgId" id="orgId" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="申请人" class="td_lefttitle" nowrap="nowrap">
                                            申请人<span class="MustFillColor">*</span>：
                                        </td>
                                        <td>
                                             <s:textfield name="voitureApplyPO.empName" id="empName" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':30}]"  maxlength="30" readonly="true" cssStyle="width:95%"/>
                                             <%if (curModifyField.indexOf("$voitureApplyPO.empName$") > -1 || "1".equals(resubmit)){%>
                                             <a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'empId', allowName:'empName', select:'user', single:'yes', show:'userorggroup', range:'*0*'});"></a>
                                             <%}%>
                                             <s:hidden name="voitureApplyPO.empId" id="empId" />
                                        </td>
                                        <td for="目的地" class="td_lefttitle">
                                            目的地：
                                        </td>
                                        <td>
                                            <%                                       
                                              if (curModifyField.indexOf("$voitureApplyPO.destination$") > -1 || "1".equals(resubmit)) {
                                              if("modifyView".equals(p_wf_openType)){
                                              %>
                                             <s:textfield name="voitureApplyPO.destination" id="destination" cssClass="inputText" whir-options="vtype:[{'maxLength':30}]"  maxlength="30" cssStyle="width:95%" readonly="true"/>
                                             <%}else{%>
                                             <s:textfield name="voitureApplyPO.destination" id="destination" cssClass="inputText" whir-options="vtype:[{'maxLength':30}]"  maxlength="30" cssStyle="width:95%"/>
                                             <%}}else{%>
                                             <s:textfield name="voitureApplyPO.destination" id="destination" cssClass="inputText" whir-options="vtype:[{'maxLength':30}]"  maxlength="30" cssStyle="width:95%" readonly="true"/>
                                            <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="跟车人数" class="td_lefttitle">
                                            跟车人数：
                                        </td>
                                        <td>
                                            <% 
                                          
                                              if (curModifyField.indexOf("$voitureApplyPO.personNum$") > -1 || "1".equals(resubmit)) {
                                               if("modifyView".equals(p_wf_openType)){%>
                                            <s:textfield name="voitureApplyPO.personNum" id="personNum" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':3}]"  maxlength="3" cssStyle="width:95%" readonly="true"/>
                                            <%}else{%>
                                            <s:textfield name="voitureApplyPO.personNum" id="personNum" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':3}]"  maxlength="3" cssStyle="width:95%"/>
                                            <%}}else{%>
                                            <s:textfield name="voitureApplyPO.personNum" id="personNum" cssClass="inputText" whir-options="vtype:['p_integer_e',{'maxLength':3}]"  maxlength="3" cssStyle="width:95%" readonly="true"/>
                                            <%}%>
                                        </td>
                                        <td for="跟车人" class="td_lefttitle">
                                            跟车人：
                                        </td>
                                        <td>
                                            <%
                                              
                                              if (curModifyField.indexOf("$voitureApplyPO.genchePerson$") > -1 || "1".equals(resubmit)) {
                                              if("modifyView".equals(p_wf_openType)){
                                                    %>
                                             <s:textfield name="voitureApplyPO.genchePerson" id="genchePerson" cssClass="inputText" whir-options="vtype:[{'maxLength':100},'spechar3']"  maxlength="100" cssStyle="width:95%" readonly="true"/>
                                             <%}else{%>
                                              <s:textfield name="voitureApplyPO.genchePerson" id="genchePerson" cssClass="inputText" whir-options="vtype:[{'maxLength':100},'spechar3']"  maxlength="100" cssStyle="width:95%"/>
                                             <%}}else{%>
                                             <s:textfield name="voitureApplyPO.genchePerson" id="genchePerson" cssClass="inputText" whir-options="vtype:[{'maxLength':100},'spechar3']"  maxlength="100" cssStyle="width:95%" readonly="true"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="司机" class="td_lefttitle">
                                            司机：
                                        </td>
                                        <td>
                                            <%
                                             
                                              if (curModifyField.indexOf("$voitureApplyPO.motorMan$") > -1 || "1".equals(resubmit)) {
                                               if("modifyView".equals(p_wf_openType)){%>
                                            <s:textfield name="voitureApplyPO.motorMan" id="motorMan" cssClass="inputText" whir-options="vtype:[{'maxLength':20},'spechar3']"  maxlength="20" cssStyle="width:95%" readonly="true"/>
                                            <%}else{%>
                                            <s:textfield name="voitureApplyPO.motorMan" id="motorMan" cssClass="inputText" whir-options="vtype:[{'maxLength':20},'spechar3']"  maxlength="20" cssStyle="width:95%"/>
                                            <%}}else{%>
                                            <s:textfield name="voitureApplyPO.motorMan" id="motorMan" cssClass="inputText" whir-options="vtype:[{'maxLength':20},'spechar3']"  maxlength="20" cssStyle="width:95%" readonly="true"/>
                                            <%}%>
                                        </td>
                                        <td  class="td_lefttitle">&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td for="预计用车时间" class="td_lefttitle" nowrap="nowrap">
                                            预计用车时间<span class="MustFillColor">*</span>：
                                        </td>
                                        <td height="25" colspan="3">
                                            <%
                                            boolean isModiDate = false;
                                            
                                            if (curModifyField.indexOf("$voitureApplyPO.startDate$") > -1 || "1".equals(resubmit)) {
                                               if("modifyView".equals(p_wf_openType)){
                                               isModiDate = false;
                                            }else{
                                               isModiDate = true;
                                               }
                                                
                                              }
                                         
											boolean isModiEndDate = false;
											 
                                            if (curModifyField.indexOf("$voitureApplyPO.endDate$") > -1 || "1".equals(resubmit)) {
                                                 if("modifyView".equals(p_wf_openType)){
                                              isModiDate = false;
                                            }else{
                                               isModiDate = true;
                                               }
                                                 
                                              }
                                        
                                       %>
                                        <%if(!isModiDate){%>
                                                <input type="hidden" name="voitureApplyPO.startDate" value="<%=formatter.format(startDate)%>">
                                                <input type="hidden" name="voitureApplyPO.endDate" value="<%=formatter.format(endDate)%>">
                                                <input type="hidden" name="startHour" value="<%=startHour%>">
                                                 <input type="hidden" name="startMinute" value="<%=startMinute%>">
                                                <input type="hidden" name="endHour" value="<%=endHour%>">
                                                <input type="hidden" name="endMinute" value="<%=endMinute%>">
                                                <%}%>
                                            <input type="text" name="voitureApplyPO.startDate" id="startDate" class="Wdate whir_datebox" whir-options="vtype:['notempty']"onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,maxDate:'#F{$dp.$D(\'endDate\',{d:0});}'})"  value="<%=formatter.format(startDate)%>"<%=isModiDate?"":"disabled='true'"%>/> 
                                             <s:hidden name="voitureApplyPO.startTime" id="startTime"/>
                                           <select name="startHour"  id="startHour"style="font-size:9pt;width:6%;" class="selectlist" <%=isModiDate?"":"disabled"%>>
                                            <%
                                            for(int hi=0;hi<24;hi++)
                                            {
                                                String hh=hi+"";
                                                if(hh.length()<2){
                                                    hh="0"+hh;
                                                }
                                                String selected = hh.equals(startHour) ? "selected":"";
                                            %>
                                            <option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
                                            <%}%>
                                            </select> 时 <select name="startMinute" id="startMinute"style="font-size:9pt;width:6%;" class="selectlist"<%=isModiDate?"":"disabled"%>>
                                            <%
                                            for(int mi=0;mi<60;)
                                            {
                                                  String mm=mi+"";
                                                if(mm.length()<2){
                                                    mm="0"+mm;
                                                }
                                                String selected = mm.equals(startMinute) ? "selected":"";
                                            %>
                                             <option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
                                            <%
                                                 mi+=5;
                                            }%>
                                            </select> 分 &nbsp;至&nbsp;
                                            <input type="text" name="voitureApplyPO.endDate" id="endDate" class="Wdate whir_datebox" whir-options="vtype:['notempty']"onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true,minDate:'#F{$dp.$D(\'startDate\',{d:0});}'})" value="<%=formatter.format(endDate)%>" <%=isModiDate?"":"disabled='true'"%>/>
                                            <s:hidden name="voitureApplyPO.endTime" id="endTime"/>
                                            <select name="endHour"id="endHour" style="font-size:9pt;width:6%;" class="selectlist" <%=isModiEndDate?"":"disabled"%>>
                                            <%
                                            for(int hi=0;hi<24;hi++)
                                            {
                                                 String hh=hi+"";
                                                if(hh.length()<2){
                                                    hh="0"+hh;
                                                }
                                                String selected = hh.equals(endHour) ? "selected":"";
             
                                            %>
                                             <option value="<%=String.valueOf(hi)%>" <%=selected%>><%=String.valueOf(hi)%></option>
                                            <%}%>
                                            </select> 时 <select name="endMinute" id="endMinute" style="font-size:9pt;width:6%;" class="selectlist" <%=isModiDate?"":"disabled"%>>
                                            <%
                                           for(int mi=0;mi<60;)
                                            {
                                                  String mm=mi+"";
                                                if(mm.length()<2){
                                                    mm="0"+mm;
                                                }
                                                String selected = mm.equals(endMinute) ? "selected":"";
              
                                            %>
                                            <option value="<%=String.valueOf(mi)%>" <%=selected%>><%=String.valueOf(mi)%></option>
                                            <%
                                                mi+=5;
                                            }%>
                                            </select> 分
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="用车类型" class="td_lefttitle">
                                            用车类型：
                                        </td>
                                        <td colspan="3">
                                             <s:radio name="voitureApplyPO.voitureStyle" list="%{#{'1':'普通用车','2':'接待用车','3':'大型活动用车','4':'其他用车'}}"  theme="simple" disabled="true"></s:radio>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="事由" class="td_lefttitle">
                                            事由：
                                        </td>
                                        <td colspan="3">
                                            <%
                                             
                                             if (curModifyField.indexOf("$voitureApplyPO.reason$") > -1 || "1".equals(resubmit)) {
                                                if("modifyView".equals(p_wf_openType)){%>
                                            <s:textarea name="voitureApplyPO.reason" id="reason" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':200}]" maxlength="200" readonly="true"/>                                         
                                             <%}else{%>
                                             <s:textarea name="voitureApplyPO.reason" id="reason" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':200}]" maxlength="200"/>                                                                 
                                             <%}}else {%>
                                             <s:textarea name="voitureApplyPO.reason" id="reason" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':200}]" maxlength="200" readonly="true"/>
                                             <%}%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td for="备注" class="td_lefttitle">
                                            备注：
                                        </td>
                                        <td colspan="3">
                                            <%
                                            
                                            if (curModifyField.indexOf("$voitureApplyPO.remark$") > -1 || "1".equals(resubmit)) {
                                             if("modifyView".equals(p_wf_openType)){%>
                                            <s:textarea name="voitureApplyPO.remark" id="remark" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':200}]" maxlength="200" readonly="true"/>
                                            <%}else {%>
                                            <s:textarea name="voitureApplyPO.remark" id="remark" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':200}]" maxlength="200"/>
                                            <%}}else {%>
                                            <s:textarea name="voitureApplyPO.remark" id="remark" cols="112" rows="2"  cssClass="inputTextarea" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':200}]" maxlength="200" readonly="true"/>
                                            <%}%>
                                        </td>
                                    </tr>
                                </table>
								
							<!--工作流包含页-->
							 <div>  
								  <%@ include file="/platform/bpm/pool/pool_include_form.jsp"%>
						    </div>
							 <!--批示意见包含页-->
							<div>
								  <%@ include file="/platform/bpm/pool/pool_include_comment.jsp"%>
							</div>
				      </div>
					  <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo3" class="doc_Content"  style="display:none;"></div>
					 <div id="docinfo4" class="doc_Content"  style="display:none;"></div>
                 </div>
             </td>
         </tr>
     </table>
     </s:form>
	</div>
    <div class="docbody_margin"></div>
	<%@ include file="/platform/bpm/pool/pool_include_form_end.jsp"%>  
	<%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
</body>
<script type="text/javascript">
    var screenwidth;//分辨率宽度
    var screenheight;//分辨率高度
    screenwidth = screen.availWidth-5;
    screenheight = screen.availHeight-18;

/**
 切换页面
 */
function  changePanle(flag){
	for(var i=0;i<5;i++){
		$("#Panle"+i).removeClass("aon");
	}
	$("#Panle"+flag).addClass("aon");
	$("div[id^='docinfo']").hide();
	$("#docinfo"+flag).show();
    
	//显示流程图
	if(flag=="1"){
		//传流程图的div的id
       showWorkFLowGraph("docinfo1");
	}
    //显示关联流程
	if(flag=="2"){
	   showWorkFlowLog("docinfo2");
	}
	//显示关联流程
	if(flag=="3"){
	   showWorkFlowRelation("docinfo3");
	}

	//显示相关附件
	if(flag=="4"){
	   showWorkFlowAcc("docinfo4");
	}
}

/**
初始话信息
*/
function initBody(){
	//初始话信息
    ezFlowinit();
    var windowWidth = window.screen.availWidth;
	var windowHeight = window.screen.availHeight;
	window.moveTo(0,0);
    window.resizeTo(windowWidth,windowHeight);
}
function changeChannel(obj){
  $("#voitureId").val(obj.value);
  var motorMan=$('#voitureName option[value='+obj.value+']').attr('motorMan');
  $("#motorMan").val(motorMan);
}
function initPara() {
    var validation = validateForm("dataForm");
     if(validation){
            var voitureId=$("#voitureId").val();
            var startDate=$("#startDate").val();
            var startHour=$("#startHour").val();
            var startMinute=$("#startMinute").val();

            var endDate=$("#endDate").val();
            var endHour=$("#endHour").val();
            var endMinute=$("#endMinute").val();

            var startTime=startHour*3600+startMinute*60;
            var endTime=endHour*3600+endMinute*60;

            if(startDate == endDate && startTime>=endTime) {
            whir_poshytip($("#startHour"),"开始时间要在结束时间之前！");
            return false;
            }
            return true;
            var sendStartTimeTotal=new Date(startDate.replace(/-/g, "/"));
            var sendEndTimeTotal=new Date(endDate.replace(/-/g, "/"));
            var StartMonth0 = (sendStartTimeTotal.getMonth()+1).toString();
            if(StartMonth0.length<2){
            StartMonth0="0"+StartMonth0;
            }
            var StartDay0 = sendStartTimeTotal.getDate().toString();
            if(StartDay0.length<2){
            StartDay0="0"+StartDay0;
            }
            var startHour0 =startHour.toString();
            if(startHour0.length<2){
            startHour0="0"+startHour0;
            }
            var startMinute0 = startMinute.toString();
            if(startMinute0.length<2){
            startMinute0="0"+startMinute0;
            }

            startDate0 = sendStartTimeTotal.getFullYear()+StartMonth0+StartDay0+startHour0+startMinute0;

            var EndMonth0 = (sendEndTimeTotal.getMonth()+1).toString();
            if(EndMonth0.length<2){
            EndMonth0="0"+EndMonth0;
            }
            var EndDay0 = sendEndTimeTotal.getDate().toString();
            if(EndDay0.length<2){
            EndDay0="0"+EndDay0;
            }

            var endHour0 = endHour.toString();
            if(endHour0.length<2){
            endHour0="0"+endHour0;
            }
            var endMinute0 = endMinute.toString();
            if(endMinute0.length<2){
            endMinute0="0"+endMinute0;
            }
            endDate0 = sendEndTimeTotal.getFullYear()+EndMonth0+EndDay0+endHour0+endMinute0;

           
    }
	return false;
}
   function hasVoi(startdate,enddate,voitureId){
        var ok = true;
        $.ajax({
            url: '<%=rootPath%>/voitureApply!voituregetsource.action?startDate=' +startdate+"&endDate="+enddate+"&voitureId="+voitureId+"&" + Math.round(Math.random()*1000),
            type: 'GET',
            data: null,
            timeout: 1000,
            async: false,      //true异，false,ajax同步
            error: function(){
                whir_alert("Error loading XML document",null,null);
            },
            success: function(data){
                data = data.replace(/(^\s*)|(\s*$)/g,"");					
                if(data !='' && data=='0'){
                    ok = false;
                }
            }
        });
        return ok;
    } 
</script>
</html>

