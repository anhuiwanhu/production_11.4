<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.component.config.ConfigXMLReader"%>
<!DOCTYPE html>
<html lang="zh-cn"> 
<%  
  ConfigXMLReader reader=new ConfigXMLReader();
  String evoserver=reader.getAttribute("Evopath", "evoUploadPath");
  String enterpriseNumber = request.getAttribute("enterpriseNumber")+""; 
  if(enterpriseNumber==null|"null".equals(enterpriseNumber)){
     enterpriseNumber="";
  }
  
%>
 
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>微信企业号管理</title> 
    <%@ include file="/public/include/meta_base.jsp"%>  
    <%@ include file="/public/include/meta_detail.jsp"%>
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.reset.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.fa.css" />
    <link rel="stylesheet" href="<%=rootPath%>/templates/template_system/common/css/template.system.css" />
    <script src="<%=rootPath%>/scripts/plugins/form/jquery.form.js" type="text/javascript"></script>
</head>

<body>
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
									<li>
										<a href="javascript:void(0)" onclick="javascript:openWin({url:'<%=rootPath%>/mobilecustmenu!mobCustMenuList.action',isFull:true,winName:'移动客户端平台'});" >
											<i class="fa fa-cog fa-color"></i>
											<span>客户端应用管理</span>
											<span class="wh-evo-btn-switch"></span>
										</a>
									</li>
									<li class="current">
										<a href="javascript:void(0)" onclick="javascript:openWin({url:'<%=rootPath%>/mobilecustmenu!microEnterpriseNumber.action',isFull:true,winName:'移动客户端平台'});" >
											<i class="fa fa-tablet fa-color"></i>
											<span>微信企业号管理</span>
											<span class="wh-evo-btn-switch" ></span>
										</a>
									</li>
								</ul> 
							</div>
						</td>
						<td>
							<div class="wh-evo-conr">
								<div class="wx-numer">
									<form>
										<div class="clearfix">
											<label>企业ID号：</label>
											<input type="text" class="idnum" name="enterpriseNumber" value="<%=enterpriseNumber%>"/>
											<input type="submit" class="link-submit" name="link-submit" value="链接验证" />
										</div>
										<div >
											<label>同步组织：</label> 
											<a href="javascript:void(0);" class="evo-btn">立即同步</a>
										</div>
										<div >
											<label>初始化菜单：</label> 
											<a href="javascript:void(0);" class="evo-btn">立即初始化</a>
										</div>
									</form>
								</div> 
							</div>
						</td>
					</tr>
				</table>  
			</div>
		</div>
	</div>
</div>
</body>   
<script src="<%=rootPath%>/scripts/plugins/lhgdialog/lhgcore.lhgdialog.min.js" ></script>
<script>
//设置表单为异步提交
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});
 
function edit(id){
    openWin({url:"<%=rootPath%>/mobilecustmenu!mobCustMenuModi.action?mobileId="+id,isFull:'true',winName:'应用编辑'});
}
 
</script>
 
</html>