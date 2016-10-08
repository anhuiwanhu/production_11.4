<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
  String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>档案借阅</title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base_head.jsp"%>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
	<%@ include file="/public/include/meta_base_bpm.jsp"%>
</head>
<body  class="docBodyStyle" scroll=no   onload="initBody();">
	<!--包含头部--->
	<jsp:include page="/public/toolbar/toolbar_include.jsp" flush="true"></jsp:include>
	<div class="doc_Scroll">
	   <s:form name="dataForm" id="dataForm" action="" method="post" theme="simple" >
		  <%@ include file="/public/include/form_detail.jsp"%>
	      <table border="0"  cellpadding="0" cellspacing="0" height="100%" align="center" class="doc_width">
	         <tr valign="top">
	            <td height="100%">
	               <div class="docbox_noline">
	                  <div class="doc_Movetitle">
	                     <ul>
	                        <li class="aon"  id="Panle0"><a href="#" onClick="changePanle(0);" >基本信息</a></li>
	                        <li id="Panle1"><a href="#" onClick="changePanle(1);">流程图</a></li>
	                        <li id="Panle2"><a href="#" onClick="changePanle(2);">关联流程<span class="redBold" id="viewrelationnum"></span></a></li>
	                     </ul>
	                  </div>
	                  <div class="clearboth"></div>
	                  <div id="docinfo0" class="doc_Content">
	                  <!--表单包含页-->
	                  <div>
	                  <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                         <input type="hidden" name="borrowtype" id="borrowtype" value="<%=request.getParameter("borrowtype")%>">
					     <input type="hidden" name="ids" id="ids" value="<%=request.getParameter("ids")%>">
                         <%
                           if(!"All".equals(request.getParameter("borrowtype"))){
                              com.whir.ezoffice.dossier.po.DossierPO po = (com.whir.ezoffice.dossier.po.DossierPO)request.getAttribute("dossierBorrow");
                         %>
                         <input type="hidden" name="categoryId" value="<%=po.getDossierCategory()!=null?po.getDossierCategory().getId()+"":""%>">
                         <tr>
			                <td for="题名" width="9%" class="td_lefttitle" nowrap>题名：</td>
			                <td width="89%" colspan="3">
                                <s:textfield name="title" id="title" value="%{#request.title}" cssClass="inputText" cssStyle="width:99%;" readonly="true" />
                            </td>
			             </tr>
			             <tr>
			                <td for="文号" width="9%" class="td_lefttitle" nowrap>文号：</td>
			                <td width="40%">
                                <s:textfield name="filenum" id="filenum" value="%{#request.filenum}" cssClass="inputText" cssStyle="width:98%;" readonly="true" />
                            </td>
                            <td for="件号" width="9%" class="td_lefttitle" nowrap>件号：</td>
			                <td width="40%">
                                <s:textfield name="docnum" id="docnum" value="%{#request.docnum}" cssClass="inputText" cssStyle="width:98%;" readonly="true" />
                            </td>
			             </tr>
			             <tr>
			                <td for="档案关键字" width="9%" class="td_lefttitle" nowrap>档案关键字：</td>
			                <td width="40%">
                                <s:textfield name="keyword" id="keyword" value="%{#request.keyword}" cssClass="inputText" cssStyle="width:98%;" readonly="true" />
                            </td>
                            <td for="档案类型" width="9%" class="td_lefttitle" nowrap>档案类型：</td>
			                <td width="40%">
                                <s:textfield name="dossierType" id="dossierType" value="%{#request.dossierType}" cssClass="inputText" cssStyle="width:98%;" readonly="true" />
                            </td>
			             </tr>
			             <tr>
			                <td for="所属类目" width="9%" class="td_lefttitle" nowrap>所属类目：</td>
			                <td width="40%">
                                <s:textfield name="categoryName" id="categoryName" value="%{#request.sCategoryFullName}" cssClass="inputText" cssStyle="width:98%;" readonly="true" />
                            </td>
                            <td for="主办部门" width="9%" class="td_lefttitle" nowrap>主办部门：</td>
			                <td width="40%">
                                <s:textfield name="transOrg" id="transOrg" value="%{#request.transOrg}" cssClass="inputText" cssStyle="width:98%;" readonly="true" />
                            </td>
			             </tr>
			             <tr>
			                <td for="密级" width="9%" class="td_lefttitle" nowrap>密级：</td>
			                <td width="89%" colspan="3">
                                <s:textfield name="secretlevel" id="secretlevel" value="%{#request.secretlevel}" cssClass="inputText" cssStyle="width:99%;" readonly="true" />
                            </td>
			             </tr>
                         <%} else {%>
                         <tr>
			                <td for="题名" width="9%" class="td_lefttitle" nowrap>题名：</td>
			                <td width="89%" colspan="3">
                                <%
                                  List dossierBorrowList = (List)request.getAttribute("dossierBorrowList");
                                  //密级取最高等级
                                  com.whir.ezoffice.dossier.bd.DossierBD dossierbd = new com.whir.ezoffice.dossier.bd.DossierBD();
                                  com.whir.ezoffice.dossier.po.DossierParaPO dossierParaPO = dossierbd.loadDossierPara(session.getAttribute("domainId").toString());
                                  String secretLevel = "";
								  if(dossierParaPO !=null){
									  secretLevel =dossierParaPO.getSecretLevel();
								  }
                                  if(secretLevel == null || "null".equals(secretLevel)){
									 secretLevel="";
								  }
                                  String[] secretLevels = secretLevel.split(";");
                                  int secretLevel0 = -1;
                                  if(dossierBorrowList != null){
                                     for(int i=0;i<dossierBorrowList.size();i++){
                                     	 com.whir.ezoffice.dossier.po.DossierPO po = (com.whir.ezoffice.dossier.po.DossierPO) dossierBorrowList.get(i);
                                     	 String tmpSecretlevel = po.getSecretlevel();
                                     	 int secretLevel1 = -1;
                                         //找出最大密级的下标
                                         for(int j=0;j<secretLevels.length;j++){
                                         	 if(secretLevels[j].equals(tmpSecretlevel)){
                                         	 	 secretLevel1 = j;
                                         	 	 break;
                                         	 }
                                         }
                                         if(secretLevel1 > secretLevel0){
                                         	 secretLevel0 = secretLevel1;
                                         }
                                %>
                                <%=po.getTitle()%></br>
                                <!--<a style="cursor:hand" href="#" onclick="openWin({url:'<%=rootPath%>/dossierAction!load.action?id=<%=po.getId()%>&isView=true',width:1000,height:500,winName:'取得文件著录'});"><%=po.getTitle()%></a></br>-->
                                <!--<a href="javascript:void(0)" onclick="del('<%=po.getId()%>');"><img border="0" src="<%=rootPath%>/images/del.gif" title="删除" ></a>-->
                                <%}}%>
                            </td>
			             </tr>
			             <tr>
			                <td for="密级" width="9%" class="td_lefttitle" nowrap>密级：</td>
			                <td width="89%" colspan="3">
			                	<input type="text" name="secretlevel" class="inputText" style="width:99%;" value="<%if(secretLevel0 != -1){out.print(secretLevels[secretLevel0]);}%>" readonly="true">
                            </td>
			             </tr>
                         <%}%>
                         
                         <tr>
			                <td for="借阅人" width="9%" class="td_lefttitle" nowrap>借阅人：</td>
			                <td width="40%">
                                <s:textfield name="userName" id="userName" value="%{#request.userName}" cssClass="inputText" cssStyle="width:98%;" readonly="true"/>
                                <s:hidden name="userId" id="userId" value="%{#request.userId}"/>
                            </td>
                            <td for="借阅人部门" width="9%" class="td_lefttitle" nowrap>借阅人部门：</td>
			                <td width="40%">
                                <s:textfield name="orgName" id="orgName" value="%{#request.orgName}" cssClass="inputText" cssStyle="width:98%;" readonly="true"/>
                                <s:hidden name="orgId" id="orgId" value="%{#request.orgId}"/>
                            </td>
		                 </tr>
                         
                         <tr>
			                <td for="借阅时间" width="9%" class="td_lefttitle" nowrap>借阅时间：</td>
			                <td width="89%" colspan="3">
			                    <s:textfield name="borrowSdate" id="borrowSdate" value="%{#request._date}" cssClass="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
			                    至
			                    <s:textfield name="borrowEdate" id="borrowEdate" value="%{#request._date}" cssClass="Wdate" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" />
			                </td>
			             </tr>
			             
                         <tr>
                            <td for="借出本地" width="9%" class="td_lefttitle" nowrap>借出本地：</td>
                            <td width="40%">
                            	<s:radio id="isNative" name="isNative" list="%{#{'0':'否','1':'是'}}" value="0" theme="simple"></s:radio>
                            </td>
                            <td for="跨部门借阅" width="9%" class="td_lefttitle" nowrap>跨部门借阅：</td>
                            <td width="40%">
                            	<s:radio id="selfOrg" name="selfOrg" list="%{#{'0':'否','1':'是'}}" value="0" theme="simple"></s:radio>
                            </td>
                         </tr>
                         
                         <tr>
			                <td for="借阅原因" width="9%" class="td_lefttitle" nowrap>借阅原因<span class="MustFillColor">*</span>：</td>
			                <td width="89%" colspan="3">
			                    <s:textarea name="borrowReason"  id="borrowReason" cols="112" rows="5" cssClass="inputTextarea" cssStyle="width:99%;" ></s:textarea>
			                </td>
			             </tr>
                         
	                  </table>
	                  </div>
	                  <!--工作流包含页-->
	                  <div><%@ include file="/platform/bpm/pool/pool_include_form.jsp"%></div>
	                  </div>
	                  <div id="docinfo1" class="doc_Content"  style="display:none;"></div>
	                  <div id="docinfo2" class="doc_Content"  style="display:none;"></div>
	               </div>
	            </td>
	         </tr>
	      </table>
	   </s:form>
	</div>
	<div class="docbody_margin"></div>
    <%@ include file="/platform/bpm/work_flow/operate/wf_include_form_end.jsp"%>
</body>
<script type="text/javascript">
	$(document).ready(function(){			//使用jquery的ready方法似的加载运行   
		if (window.screen) {				//判断浏览器是否支持window.screen判断浏览器是否支持screen   
			var myw = screen.availWidth;	//定义一个myw，接受到当前全屏的宽   
		    var myh = screen.availHeight;	//定义一个myw，接受到当前全屏的高   
		    window.moveTo(0, 0);			//把window放在左上脚   
		    window.resizeTo(myw, myh);		//把当前窗体的长宽跳转为myw和myh   
	    }   
	});   

	
    /**切换页面*/
    function  changePanle(flag){
        for(var i=0;i<3;i++){
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
           showWorkFlowRelation("docinfo2");
        }
    }
    
    /**初始话信息*/
    function initBody(){
        //初始话信息
        ezFlowinit();
    }
	
	//检查页面参数有效性
	function initPara(){
	    var start_date =$('#borrowSdate').val();
	    var end_date   =$('#borrowEdate').val();
	    var result_0 =compareTwoDate(start_date,end_date);
	    if(result_0 ==">"){
	       $.dialog.alert("借阅结束时间不得比开始时间小！",function(){});
		   return false;
	    }
	    
	    if($('#borrowReason').val() ==''){
	       $.dialog.alert("借阅原因不能为空！",function(){
	           $('#borrowReason').focus();
	       });
	       return false;
	    }else{
	       var borrowReason = $('#borrowReason').val();
	       var len = borrowReason.length; 
	       if(len >249){
	          $.dialog.alert("借阅原因过长,最多允许输入249个字！！",function(){
	              $('#borrowReason').focus();
	          });
	          return false;
	       }
	    }
	    return true;
	}
</script>
</html>