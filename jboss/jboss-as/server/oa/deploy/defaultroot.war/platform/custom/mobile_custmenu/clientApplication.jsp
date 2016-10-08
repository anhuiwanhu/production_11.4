<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.component.config.ConfigXMLReader"%>
 
<!DOCTYPE html>
<html lang="zh-cn"> 
<%  
   ConfigXMLReader reader=new ConfigXMLReader();
   String evoserver=reader.getAttribute("Evopath", "evoUploadPath");
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>客户端应用管理</title> 
    
    <%@ include file="/public/include/meta_new_base.jsp"%>
    <%@ include file="/public/include/meta_list.jsp"%>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.system.css" />
    <script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
</head>

<body class="MainFrameBox">
   <s:form name="queryForm" id="queryForm" action="mobilecustmenu!getMobileCustMenuList.action" method="post" theme="simple">                         
    <%@ include file="/public/include/form_list.jsp"%>
    <div class="wh-wrapper wh-evo">
        <div class="wh-evo-header">
            <div class="wh-main clearfix">
                <i class="fa fa-users"></i>
                <h1>移动客户管理平台</h1>
            </div>
        </div>
        <div class="wh-evo-content">
            <div class="wh-main clearfix">
                <table class="wh-evo-table">
                    <tr>
                        <td>
                            <div class="wh-evo-cnav">
                                <ul>
                                    <li>
                                        <a href="<%=evoserver%>">
                                            <i class="fa fa-laptop fa-color"></i>
                                            <span>客户端界面设置</span>
                                            <span class="wh-evo-btn-switch"></span>
                                        </a>
                                    </li>
                                    <li class="current">
                                        <a href="javascript:void(0)" onclick="javascript:openWin({url:'<%=rootPath%>/mobilecustmenu!mobCustMenuList.action',isFull:true,winName:'移动客户端平台'});" >
                                            <i class="fa fa-cog fa-color"></i>
                                            <span>客户端应用管理</span>
                                            <span class="wh-evo-btn-switch"></span>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="javascript:void(0)" onclick="javascript:openWin({url:'<%=rootPath%>/mobilecustmenu!microEnterpriseNumber.action',isFull:true,winName:'移动客户端平台'});" >
                                            <i class="fa fa-tablet fa-color"></i>
                                            <span>微信企业号管理</span>
                                            <span class="wh-evo-btn-switch"></span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </td>
                        <td class="wh-evo-conr-td">
                            <div class="wh-evo-conr">
                                <div class="wx-app-info">
                               
                                    <table  class="wx-app-table">
                                    <thead id="headerContainer"  >
                                        <tr class="listTableHead">                                        
                                            <td whir-options="field:'mobileMenuDisplayName',width:'15%'" class="td-head">应用名称</td>
                                            <td whir-options="field:'mobileMenuScope',width:'55%'" class="td-head">适用范围</td>
                                            <td whir-options="field:'mobileId',width:'8%'" class="td-head">图标</td>
                                            <td whir-options="field:'mobileMenuIsUse',width:'6%',renderer:showIsUse" class="td-head">是否启用</td>
                                            <td whir-options="field:'mobileMenuOrder',width:'6%'" class="td-head">排序</td>
                                            <td whir-options="field:'',width:'10%',renderer:showoperate" class="td-head">操作</td>
                                        </tr>
                                   </thead>
		                           <tbody  id="itemContainer" > 
		                           
		                           </tbody>                                       
                                    </table> 
                                    
                                    <div class="wh-evo-page">
                                    <%@ include file="/public/page/pagerExpert.jsp"%>
                                    </div> 
                                 
                                </div>    
                            </div>
                        </td>                                        
                    </tr>                                       
                </table>
                                                 
            </div>
            
        </div>
    </div>
</s:form>
</body>   
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgcore.lhgdialog.min.js" ></script>
<script>
//初始化列表页form表单,"queryForm"是表单id，可修改。  
$(document).ready(function(){ 
      
 initListFormToAjax({formId:"queryForm"}); 
  
   /* 判断浏览器的高度 给.wh-evo赋值 */ 
       function setH(evoH,evohH,evoT){ 
            var evoHeight = $(window).height() - evohH.height();     
            if(evoHeight > evoT.height()){
                evoH.css('height',evoHeight -1);
            }
            else{
                evoH.attr("style","");
            }
        } 
        var xevoH = $(".wh-evo-content .wh-main");
        var xevoT = $(".wh-evo-content .wh-evo-table");
        var xevohH = $(".wh-evo-header"); 
        setH(xevoH,xevohH,xevoT);
        $(window).resize(function(){  
            setH(xevoH,xevohH,xevoT);
        });          
});  
      
function showoperate(po,i){
   var html = "";
   if(po.mobileMenuIsUse==1){
	   html +=  '<a href="javascript:void(0)" title="隐藏" onclick="hideMenu('+po.mobileId+')">隐藏</a>'; 
	}else{
	   html +=  '<a href="javascript:void(0)"  title="启用" onclick="showMenu('+po.mobileId+')">启用</a>';
	}	 
	 html += '<a href="javascript:void(0)" title="修改" onclick="edit('+po.mobileId+')">修改</a>';	
	return html;
}

function showIsUse(po,i){
        var html = "&nbsp;";
        if(po.mobileMenuIsUse=='0'){
            html = "否";
        }else if(po.mobileMenuIsUse=='1'){
            html = "是";
        } 
        return html;
}

function edit(id){
    //openWin({url:"<%=rootPath%>/mobilecustmenu!mobCustMenuModi.action?mobileId="+id,isFull:'true',winName:'应用编辑'});
    var casher_dialog = $.dialog({
              title: '应用编辑',
              content: "url:<%=rootPath%>/mobilecustmenu!mobCustMenuModi.action?mobileId="+id,
              width: 640,
              height: 600,
              min:false,
              max:false
          });

}
function hideMenu(id){
   whir_confirm("您确定要隐藏吗？",function(){
	ajaxOperate({urlWithData:'mobilecustmenu!hideORShowMenu.action?status=0&mobileId='+id,tip:'隐藏菜单',isconfirm:false,formId:'queryForm'});
   });
}
function showMenu(id){
   whir_confirm("您确定要启用吗？",function(){
	ajaxOperate({urlWithData:'mobilecustmenu!hideORShowMenu.action?status=1&mobileId='+id,tip:'启用菜单',isconfirm:false,formId:'queryForm'});
   });
}
</script>
 
</html>