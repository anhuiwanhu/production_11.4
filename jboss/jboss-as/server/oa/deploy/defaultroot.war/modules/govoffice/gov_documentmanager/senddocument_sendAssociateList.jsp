<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored ="false" %>
<%@ include file="/public/include/init.jsp"%>
<%
String winOpen = request.getParameter("winOpen")==null?"":request.getParameter("winOpen").trim();//是否是办理查阅里打开的
if(!"".equals(winOpen)){%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%}%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
int index = 0  ;
int countRecordCount = 0  ;
if(request.getParameter("pager.offset")!=null)
    index=Integer.parseInt(request.getParameter("pager.offset"));
int offset1 = index ;

 Object[] procObj = null;
  com.whir.ezoffice.workflow.common.util.NewProc newProc = new com.whir.ezoffice.workflow.common.util.NewProc();


  String filetitle=request.getParameter("filetitle")==null?"":request.getParameter("filetitle").toString();


//相关收文数量
int receivNum=0;
java.util.List list = new java.util.ArrayList();
if(request.getAttribute("mylist") !=null){
	list = (java.util.List)request.getAttribute("mylist");
}
receivNum = list.size();
if(!"".equals(winOpen)){
%>
<head>
	<title><%=filetitle%></title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_list.jsp"%>
	<!--这里可以追加导入模块内私有的js文件或css文件-->
</head>
<body  class="MainFrameBox" onload="<%if(!"".equals(winOpen)){%>resizeWin(800,400);<%}%>">
<%}%>
<%if(!"".equals(winOpen)){%>
  	<script type="text/javascript"> 
	var whirRootPath = "/defaultroot";
	var preUrl = "/defaultroot"; 
</script>

 
<!--[if IE 6]>
<script type="text/javascript" src="/defaultroot/scripts/desktop/iepng.js"></script>
<script type="text/javascript"> 
EvPNG.fix('img,.scrollArrowLeft,.scrollArrowLeftDisabled,.scrollArrowRight,.scrollArrowRightDisabled,.face_box,.top_boxbg,.bg_01,.bg_02,.topread_box,.skin_btn,.f_person,.hint_area,.facebg,.logo_img,.bg_png,.main_box,.bg_png');
</script>
<![endif]-->
 
<script type="text/javascript"> 
	/********公共初始化操作**********************/
	$(document).ready(function(){			
		setInputStyle();
		digitCheck();
		$("input[type='hidden'],select").each(function(){
			$(this).attr("defaultValue",$(this).val());
		});
	});
</script>

		


<%}%>
	<%@ include file="/public/include/meta_list.jsp"%>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="listTable">
<tr><td style="font-size:12px;">
<%=request.getParameter("filetitle")==null?"":request.getParameter("filetitle") + "收文接收情况："%>
</td>
</tr>
</table>
	<!--这里的表单id queryForm 允许修改 -->
	<s:form name="queryForm" id="queryForm1" action="%{#ctx}/GovDocSend!sendAssociateData.action" method="post" theme="simple">
<input type="hidden" name="sendFileId" value="<%=request.getParameter("sendFileId")%>"/>
	<!-- SEARCH PART START -->
	<%@ include file="/public/include/form_list.jsp"%>
	
	<!-- LIST TITLE PART START -->	
    <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable">
		<!-- thead必须存在且id必须为headerContainer -->
		<thead id="headerContainer">
        <tr class="listTableHead">
			
			<td whir-options="field:'createdTime',width:'10%',renderer:common_DateFormat">转收文日期</td> 
			<td whir-options="field:'orgName',width:'25%'">收文单位</td> 
			<td whir-options="field:'id', width:'45%',renderer:getTitle">收文标签</td> 
			<td whir-options="field:'transactStatus',width:'20%',renderer:myOperate">收文状态</td> 

        </tr>
		</thead>
		<!-- tbody必须存在且id必须为itemContainer -->
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
	<%if(!"".equals(winOpen)){%>
</body>
	<%}%>

	<script type="text/javascript">
	
	//*************************************下面的函数属于公共的或半自定义的*************************************************//

	//初始化列表页form表单,"queryForm"是表单id，可修改。
	$(document).ready(function(){		
		initListFormToAjax({formId:'queryForm1'});		
	});
	
	function openFlow(workFlowPara){
		openWin({url:"govezoffice/gov_documentmanager/send_flow.jsp?"+workFlowPara,width:620,height:290,isResizable: true,isFull: true});
	}
	function getCreatedTime(po,i){
		return po.createdTime==null?"&nbsp;":("2008-12-12 00:00:00"==po.createdTime? po.receivefile_receivedate:  po.createdTime)
	}

	function getTitle(po,i){

		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'GovDocReceiveProcess!editfile.action?editType=0&p_wf_openType=modifyView&canEdit=0&viewOnly=1&myFile=1&p_wf_tableId='+po.tableId+'&p_wf_recordId='+po.receivefile_id+'\',width:620,height:290,isResizable: true,isFull: true,winName:\'21212\'});">'+po.receivefile_title+'</a>';
		return html;

	}


	//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

	function sex(po,i){
		var html ;
		if(po.sex==0){
			html = "男";
		}else{
			html = "女";
		}
		return html;
	}

	function downloadLink(po,i){
		return "<a href='alert(\""+po.gridId+"\")' >下载正文</a>";
	}

	function formatDate(po,i){
		return getFormatDateByLong(po.createdTime,"yyyy-MM-dd hh:mm:ss");
	}

	//自定义操作栏内容
	function myOperate(po,i){
		//alert('GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id);
		/*var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'/defaultroot/GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id+'\',width:820,height:550,isFull:true,winName:\'modifyUser\'});"><img border="0" src="<%=rootPath%>/images/modi.gif" alt="修改" ></a><a href="javascript:void(0)" onclick="ajaxDelete(\'/defaultroot/GovCustom!delForm.action?govFormId='+ po.govFormId+'&id='+po.id+'\',this);"><img border="0" src="<%=rootPath%>/images/del.gif" alt="删除" ></a>';*/
	   var html='<a href="#" onclick="javascript:openFlow(\''+po.workFlowPara+'\');">';
                                     if(po.receivefile_status == null){
                                        html+=("&nbsp;");
                                     }else if("0" == po.receivefile_status){
                                        // procObj = (Object[]) newProc.getDocInfo("3", obj[4].toString(),obj[0].toString());
                                        // out.print(procObj[0]+"&nbsp;");
										 html+=(po.dealInfo0+"："+po.dealInfo1+"");
                                         //out.print("办理中");
                                     }else if("1"  == po.receivefile_status){
                                          html+=("办理完毕");
                                     }else if("2" == po.receivefile_status){
                                          html+=("退回");
                                     }else if("3"  == po.receivefile_status){
									 
									      html+=("取消");
									 }
		html += "</a>";

  
	 html='';
                                     if(po.receivefile_status == null){
                                        html+=("&nbsp;");
                                     }else if("0" == po.receivefile_status){
                                        // procObj = (Object[]) newProc.getDocInfo("3", obj[4].toString(),obj[0].toString());
                                        // out.print(procObj[0]+"&nbsp;");
										 html+=(po.dealInfo0+"："+po.dealInfo1+"");
                                         //out.print("办理中");
                                     }else if("1"  == po.receivefile_status){
                                          html+=("办理完毕");
                                     }else if("2" == po.receivefile_status){
                                          html+=("退回");
                                     }else if("3"  == po.receivefile_status){
									 
									      html+=("取消");
									 }
		html += "";
		return html;
	}

	//显示模版
	function showTemplate(po,i){
		//alert('GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'/defaultroot/GovCustom!loadForm.action?gffType=0&govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id+'\',width:820,height:550,winName:\'modifyUser\'});">显示模板</a>';
		return html;
	}

	//打印模版
	function printTemplate(po,i){
		//alert('GovCustom!loadForm.action?govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id);
		var html =  '<a href="javascript:void(0)" onclick="openWin({url:\'/defaultroot/GovCustom!loadForm.action?gffType=1&govFormType='+po.govFormType+'&formId='+ po.govFormId+'&id='+po.id+'\',width:820,height:550,winName:\'modifyUser\'});">打印模板</a>';
		return html;
	}

	function updateField(){
	 
		var hhref = "/defaultroot/GovCustom!loadAllowField.action?action=loadAllowField&govFormType=<%=request.getParameter("govFormType")%>"  ;
		openWin({url:hhref,width:800,height:600,winName:'updateFieldWin'});
	}
</script>

</html>


