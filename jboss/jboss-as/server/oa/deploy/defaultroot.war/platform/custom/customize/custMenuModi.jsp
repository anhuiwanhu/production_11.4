<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>  
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.vo.*"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.po.*"%>
<%@ page import="com.whir.common.util.CommonUtils"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustomerMenuDB"%>
<%@ page import="com.whir.ezoffice.customize.customermenu.bd.CustMenuWithOriginalBD"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  CustomerMenuDB  menubd = new CustomerMenuDB();
  String allMenuList = (String)request.getAttribute("allMenuList");
  List workFlows = (List)request.getAttribute("workFlows");
  String[][] modellist = (String[][])request.getAttribute("modellist");
  String rightRange = (String)request.getAttribute("rightRange");

  String queryCasesSelName = request.getAttribute("queryCasesSelName")+"";
  String listCasesSelName =  request.getAttribute("listCasesSelName")+"";
  String listCasesSel2Name =  request.getAttribute("listCasesSel2Name")+"";

  CustomerMenuConfigerPO po = (CustomerMenuConfigerPO)request.getAttribute("configerPO");
  
  String tableModelId = (String)request.getAttribute("tableModelId");
  List navMenuList = (List)request.getAttribute("navMenuList");
%>
<head>  
	<title>修改自定义模块</title>  
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>  
	<%@ include file="/public/include/meta_base.jsp"%>  
	<%@ include file="/public/include/meta_detail.jsp"%>  
	<!--这里可以追加导入模块内私有的js文件或css文件-->  
  
</head>  
  
<body class="Pupwin" >  
	<div class="BodyMargin_10">    
		<div class="docBoxNoPanel">  
		<s:form name="dataForm" id="dataForm" action="custormermenu!updCustMenu.action" method="post" theme="simple" >  
         <%@ include file="/public/include/form_detail.jsp"%>  
		<table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline"> 
		   <input name="id" type="hidden" id="id" value="<%=po.getId()%>">
		   <tr>    
			   <td for="模块名称" width="100" class="td_lefttitle">    
				   模块名称<span class="MustFillColor">*</span>：    
			   </td>    
			   <td>
				   <input class="inputText"  name="menuName" id="menuName"  whir-options="vtype:['spechar3']"  style="width:444px;" value="<%=po.getMenuName()%>">
			   </td>    
		   </tr>
		   <tr>    
			   <td width="100" class="td_lefttitle">    
				   所属模块<span class="MustFillColor">*</span>：    
			   </td>    
			   <td>
			       <select id="menuBlone"  name="menuBlone" class="selectlist" style="width:200px;" onchange="changeSub(this.value);">     
						<option value="-1">主菜单</option>
						<%=allMenuList%>  
				  </select> 
				  <div id="mainmenuorder" style="display:inline;">
                     主菜单排序码：<input class="inputText"  name="parentOrder" id="parentOrder" style="width:150px;" maxlength="9" value="<%=po.getMenuOrderSet()==null?"":po.getMenuOrderSet()%>">
			     </div>
			   </td>    
		   </tr>
		   <tr id="defHrefSpan" style="display:none">    
			   <td width="100" class="td_lefttitle">默认导航：</td>    
			   <td>
				    <select  id="defHrefSel" name="defHrefSel" style="width:202px" class="selectlist">
                      <option value="-1">--请选择--</option>
                    <%
                    if (navMenuList != null && navMenuList.size() > 0) {
                            for(int i = 0; i < navMenuList.size(); i++) {
                              Object[] obj = (Object[])navMenuList.get(i);
                    %>
                      <option value="<%=obj[0]%>" <%if(obj[0].toString().equals(po.getMenuURLSet())){%> selected = "selected" <%}%>><%=obj[1]%></option>
                    <%}}%>
                  </select>
			   </td>    
		   </tr>

           <tr>    
			   <td width="100" class="td_lefttitle">模块位置：</td>    
			   <td>
				    <select id="menuLocation"  name="menuLocation" class="selectlist" style="width:202px;"></select>
					  <span id="orderSet" style="display:">
                        <input type="radio" name="zorder" id="zorder" value="0"/>前 
					    <input type="radio" name="zorder" id="zorder" value="1" checked/>后
                      </span>
			   </td>    
		   </tr>
		   <%
		      String menuScope = po.getMenuScope();
			  String menuView = "";
			  String menuViewId = "";
			  if(menuScope.indexOf(",-")>-1||menuScope.indexOf("-")>-1){
			      menuView=menuScope.substring(0,menuScope.lastIndexOf("-"));
				  menuViewId=menuScope.substring(menuScope.lastIndexOf("-")+1,menuScope.length());
		      } 
              menuView = menuView.replaceAll(",,",",");
		   %>
		   <tr>    
			   <td for="适用范围" width="100" class="td_lefttitle">适用范围<span class="MustFillColor">*</span>：</td>    
			   <td>
				   <input type="hidden" id="menuViewId" name="menuViewId" value="<%=menuViewId%>"/>
                   <textarea class="inputTextarea" style="width:444px;" id="menuView" name="menuView" readonly="readonly"><%=menuView%></textarea><a href="javascript:void(0);" class="selectIco textareaIco" onClick="openSelect({allowId:'menuViewId', allowName:'menuView', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*',limited:'1'});"></a>  
			   </td>    
		   </tr>
	 
		   <tr id="mobileIsOpen" <%if("-1".equals(po.getMenuBlone()+"")){%>style="display:"<%}else{%>style="display:none;"<%}%>>
			  <td width="100" class="td_lefttitle">移动端启用：</td>
			  <td>			    
			      <input type="radio" name="mobile_use" value="0" <%if("0".equals(po.getMobile_use()+"")){%>checked="checked"<%}%>/>关闭 
			      <input type="radio" name="mobile_use" value="1" <%if("1".equals(po.getMobile_use()+"")){%>checked="checked"<%}%>/>开启					  			    
			 </td>
		  </tr>
		  <tr id="mobileEnterpriseId" <%if("-1".equals(po.getMenuBlone()+"")){%>style="display:"<%}else{%>style="display:none;"<%}%>>    
			   <td width="100" class="td_lefttitle">企业号应用ID：</td>    
			   <td><input class="inputText"  name="mobile_enterpriseId"  id="mobile_enterpriseId"  maxlength="80"  style="width:210px;" value="<%=po.getMobile_enterpriseId()==null?"":po.getMobile_enterpriseId()%>"/></td>    
		 </tr>
		   
		   <tr id="activityDiv">
			  <td colspan="2">
			    <table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr height="1" bgcolor="#808080">
					<td style="padding:0;"></td>
				  </tr>
				  <tr height="1"  bgcolor="#FFFFFF">
					<td style="padding:0;"></td>
				  </tr>
				</table>
			  </td>
		  </tr>
		   <!-- ***************************************************************************** -->
		  <tr>    
		    <td width="100" class="td_lefttitle">模块属性：</td>    
		    <td>&nbsp;</td>    
	      </tr>
		  <tr id="linktitleTR1" style="display:">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="1" id="readCK1" name="readCK" onclick="cleanData(1);"/>地址链接</td>
		  </tr>
		  <tr id="linkTR1" style="display:">
             <td>&nbsp;</td>    
		     <td>
			   <table >
                    <tr>
                        <td valign="top">&nbsp;&nbsp;链接地址：
						  <input class="inputText"  name="menuAction" id="menuAction"  style="width:360px;" value="<%=po.getMenuAction()==null?"":po.getMenuAction()%>">
                        </td>
                      </tr>
					  <%
					    String menuActionParams1 = po.getMenuActionParams1();
						String paraPre1 = "";
                        String params1 = "";
						if(menuActionParams1!=null&&!"null".equals(menuActionParams1)&&!"".equals(menuActionParams1)){
						  paraPre1 = menuActionParams1.split("\\|")[0];
						  params1 = menuActionParams1.split("\\|")[1];
						}
					  %>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名一：
						      <input class="inputText"  name="paraPre1" id="paraPre1"  style="width:150px;" value="<%=paraPre1%>">值
						      <select id="params1" name="params1" class="selectlist" style="width:150px;">    
								<option value="1" <%if("1".equals(params1)){out.print("selected");}%>>登录用户 </option>
                                <option value="2" <%if("2".equals(params1)){out.print("selected");}%>>登录密码 </option>
                                <option value="3" <%if("3".equals(params1)){out.print("selected");}%>>登录组织 </option>
							  </select>
                        </td>
                      </tr>
					  <%
					    String menuActionParams2 = po.getMenuActionParams2();
						String paraPre2 = "";
                        String params2 = "";
						if(menuActionParams2!=null&&!"null".equals(menuActionParams2)&&!"".equals(menuActionParams2)){
						  paraPre2 = menuActionParams2.split("\\|")[0];
						  params2 = menuActionParams2.split("\\|")[1];
						}
					  %>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名二：
                          <input class="inputText"  name="paraPre2" id="paraPre2"  style="width:150px;" value="<%=paraPre2%>">值
						  <select id="params2" name="params2" class="selectlist" style="width:150px;">    
							<option value="1"  <%if("1".equals(params2)){out.print("selected");}%>>登录用户 </option>
							<option value="2"  <%if("2".equals(params2)){out.print("selected");}%>>登录密码 </option>
							<option value="3"  <%if("3".equals(params2)){out.print("selected");}%>>登录组织 </option>
						  </select>
                        </td>
                      </tr>
					  <%
					    String menuActionParams3 = po.getMenuActionParams3();
						String paraPre3 = "";
                        String params3 = "";
						if(menuActionParams3!=null&&!"null".equals(menuActionParams3)&&!"".equals(menuActionParams3)){
						  paraPre3 = menuActionParams3.split("\\|")[0];
						  params3 = menuActionParams3.split("\\|")[1];
						}
					  %>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名三：
                          <input class="inputText"  name="paraPre3" id="paraPre3"  style="width:150px;" value="<%=paraPre3%>">值
						  <select id="params3" name="params3" class="selectlist" style="width:150px;">    
							<option value="1" <%if("1".equals(params3)){out.print("selected");}%>>登录用户 </option>
							<option value="2" <%if("2".equals(params3)){out.print("selected");}%>>登录密码 </option>
							<option value="3" <%if("3".equals(params3)){out.print("selected");}%>>登录组织 </option>
						  </select>
                          </td>
                      </tr>
					  <%
					    String menuActionParams4 = po.getMenuActionParams4()==null?"":po.getMenuActionParams4();
						String menuActionParams4Value = po.getMenuActionParams4Value()==null?"":po.getMenuActionParams4Value();
					  %>
                      <tr>
                        <td valign="bottom">&nbsp;&nbsp;参数名四：
                          <input class="inputText"  name="paraPre4" id="paraPre4"  style="width:150px;" value="<%=menuActionParams4%>">值
						  <select id="params4" name="params4" class="selectlist" style="width:150px;">    
							 <option value="4">常值</option>
						  </select>
						  <input class="inputText"  name="menuActionParams4Value" id="menuActionParams4Value"  style="width:85px;" value="<%=menuActionParams4Value%>">
                        </td>
                      </tr>
                  </table>
			 </td>    
	      </tr>
		  
		  <tr id="linktitleTR2" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="2" id="readCK2" name="readCK" onclick="cleanData(2);"/>启动信息列表项</td>
		  </tr>
		  <tr id="linkTR2" id style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left" style="padding: 6px 2px 6px 45px;">
                <!----------------------------------------------------------------------------------------------------------------------------------->
				<table>
				      
					  <tr>
                        <td valign="top">数据表分类：
						     <select id="menuListTableModelMapSel" name="menuListTableModelMapSel" class="selectlist" style="width:200px;" onchange="initListTalbes(this.value);">
								<option value=''>--请选择--</option>
							    <%
								  if(modellist!=null){
									   for(int i=0;i<modellist.length;i++){
										   String[] obj = (String[]) modellist[i];
								%>
								<option value="<%=obj[0]%>" <%=((obj[0]+"").equals(tableModelId)?" selected ":"")%>><%=obj[2]%> </option>
								<%     }
								  }
								%>
							  </select>
                        </td>
						<td valign="top">
						  <table> 
						     <tr>
							 <td><span style="padding-left:50px">数据表：&nbsp;&nbsp;&nbsp;</span></td>
						     <!--select id="menuListTableMapSel" name="menuListTableMapSel" class="easyui-combobox" data-options="panelHeight:'260',valueField:'id',textField:'text',onSelect: function(record){  
									selmenuListTab($('#menuListTableMapSel').combobox('getValue'),'');  
								}" style="width:200px;">
							 </select-->
							 <td><div id="menuListTableMapSelCombo"></div></td>							 
							</tr>
						   </table>
                        </td>						  
                      </tr>
                     
                      <tr>
                        <td valign="top">维护表单：&nbsp;&nbsp;&nbsp;
						<select id="menuSearchBound" name="menuSearchBound" class="selectlist" style="width:200px;" onchange="setFields_update(this.value);$('#menuWhereSql').val('');">
						</select>
                        </td>
						<td>
						<table> 
						     <tr>
							 <td><span style="padding-left:50px">相关流程：</span></td>
						      
							 <td>
							 <select id="menuRefFlow"  name="menuRefFlow_" class="xeasyui-combobox" data-options="panelHeight:200" style="width:260px;">
					        <%
						      if (workFlows != null && workFlows.size() > 0) {
							  for(int i = 0; i < workFlows.size(); i++) {
							  ListItem item = (ListItem)workFlows.get(i);
						    %>
							 <option value="<%=item.getId()%>" <%if((item.getId()+"").equals(po.getMenuRefFlow()+"")){out.print("selected");}%>><%=item.getName()%></option>
						    <%}}%>
					      </select> 
					       </td>							 
							</tr>
						   </table>									        
				       </td>
						 
                    </tr>
                 <tr>
                    <td height="6"></td>
                </tr>                    
					 <tr>
						<td colspan="2">							
							<div class="whir_mainbox">
                              <div class="Public_tag">
									<ul id="whir_tab_ul">
										<li id="tabClass_1" class="tag_aon" >
											<span class="tag_center" onclick="changePanle(1)">主表约束</span>
											<span class="tag_right"></span>
										</li>
										<li id="tabClass_2">
											<span class="tag_center"  onclick="changePanle(2)">字段控制</span>
											<span class="tag_right"></span>
										</li>
										<li id="tabClass_3">
											<span class="tag_center" onclick="changePanle(3)">列表方案</span>
											<span class="tag_right"></span>
										</li>
										 
									</ul>
								</div>
                                <!--滑动标签结束-->
								<div class="clear_fix"></div>
                                <div id="tab_1" class="grayline">								  
							     <table cellspacing=0 cellpadding=0>
								<tr>
									<td colspan=7>主表约束：</td>
								</tr>
								<tr>
									<td>
										<select id="mainTblField1" name="mainTblField1" class="selectlist" style="width:100px;"></select>
									</td>
									<td>
										<select id="mainoper1" name="mainoper1" class="selectlist" style="width:50px;">
												<option value=">">></option>
												<option value="<"><</option>
												<option value=">=">>=</option>
												<option value="<="><=</option>
												<option value="=">=</option>
												<option value="<>"><></option>
												<option value="like">like</option>
												<option value="is">is</option>
										</select>
									</td>
									<td width="115">
									   <select id="mainval1" name="mainval1" class="selectlist" style="width:120px;">
											<option value=""></option>
											<option value="&userAccounts">＆userAccounts</option>
											<option value="&userOrgID">＆userOrgID</option>
											<option value="&empidcard">＆empidcard</option>
											<option value="&uid">＆uid</option>
											<option value="&Currenttime">＆Currenttime</option>
									   </select>
									</td>
									<td>
										 <select id="mainuion" name="mainuion" class="selectlist" style="width:50px;">
												<option value="-1">关系</option>
												<option value="and">并且</option>
												<option value="or">或者</option>
										  </select>		
									</td>
									<td>
										<select id="mainTblField2" name="mainTblField2" class="selectlist" style="width:100px;"></select>
									</td>
									<td>
									   <select id="mainoper2" name="mainoper2" class="selectlist" style="width:50px;">
												<option value=">">></option>
												<option value="<"><</option>
												<option value=">=">>=</option>
												<option value="<="><=</option>
												<option value="=">=</option>
												<option value="<>"><></option>
												<option value="like">like</option>
												<option value="is">is</option>
										</select>
									 </td>
									<td width="115">
									   <select id="mainval2" name="mainval2" class="selectlist" style="width:120px;">
											<option value=""></option>
											<option value="&userAccounts">＆userAccounts</option>
											<option value="&userOrgID">＆userOrgID</option>
											<option value="&empidcard">＆empidcard</option>
											<option value="&uid">＆uid</option>
											<option value="&Currenttime">＆Currenttime</option>
									   </select>
									</td>
								</tr>
								<tr height="30">
									<td colspan=7>
									  <input id="constrainA" type="button" class="btnButton4font"  value="确 定" />
									  <input id="constrainB" type="button" class="btnButton4font"  value="清 除" />
									</td>
								</tr>
								<tr height="30">
									<td colspan=7>
									   <textarea class="inputTextarea" style="width:650px;" rows="5" id="menuWhereSql" name="menuWhereSql"></textarea>
									</td>
								</tr>
								<tr height="30">
									<td colspan=7>
									<font color="red">当前用户Id: &uid; 当前用户帐号: &userAccounts; 当前用户组织id: &userOrgID; 当前用户身份证号: &empidcard;</font>
									</td>
								</tr>
							</table>
					 
								</div>

								<div id="tab_2" class="grayline" style="display:none">
								 <table>
								   <tr>
									       <td colspan=7>字段控制（全不勾选为默认方案）：</td>
								   </tr>
								   </table>
								   <div style="height:300px;overflow-y:auto;border:1px solid #b7b7b7;">
                                  <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable change-table" style="border:0 none;">
								        <input id="fountainField_all" name="fountainField_all" type="hidden" value=""></input>
										<input id="readField_check" name="readField_check" type="hidden" value=""></input>
										<input id="writeField_check" name="writeField_check" type="hidden" value=""></input>
										<input id="hiddenField_check" name="hiddenField_check" type="hidden" value=""></input>
										<input id="fountainField1_ucheck" name="fountainField1_ucheck" type="hidden" value=""></input>
										<input id="listWriteField_check" name="listWriteField_check" type="hidden" value=""></input>
										<input id="formfieldFlag" name="formfieldFlag" type="hidden" value="0">
										<input id="listfieldFlag" name="listfieldFlag" type="hidden" value="0">
		                                <thead id="headerContainer">									  
                                           <tr class="listTableHead">
			                               <td>源字段</td>			 
			                               <td><input type="checkbox" name="items_read" id="items_read" onclick="setCheckBoxState_My('readField',this.checked,1);" >表单可读</td>			
			                               <td><input type="checkbox" name="items_write" id="items_write" onclick="setCheckBoxState_My('writeField',this.checked,2);" >表单可写</td> 
			                               <td><input type="checkbox" name="items_hide" id="items_hide" onclick="setCheckBoxState_My('hiddenField',this.checked,3);" >表单隐藏</td> 
			                               <td><input type="checkbox" name="items_modi" id="items_modi" onclick="setCheckBoxState('listWriteField',this.checked);" >列表编辑</td>
                                           </tr>
		                               </thead>
		                               <tbody  id="itemContainer" >
		                                 
		                               </tbody>
                                 </table>
								</div>
								<table>
								 <tr>
					             <td>数据查看范围：
						         <input type="radio" id="menuSeeAuth" name="menuSeeAuth" value="0" onclick="changeDef(this.value);" <%if("0".equals(po.getMenuSeeAuth()+"")||("".equals(po.getMenuSeeAuth()+""))||("null".equals(po.getMenuSeeAuth()+""))||(po.getMenuSeeAuth()==null)){out.print("checked");}%>/>不设查看权限看不见数据&nbsp; 
						         <input type="radio" id="menuSeeAuth" name="menuSeeAuth" value="1" onclick="changeDef(this.value);" <%if("1".equals(po.getMenuSeeAuth()+"")){out.print("checked");}%>/>不设查看权限看到所有数据 					      
					             </td>
					              </tr>
								  </table>
								</div>

							   <div id="tab_3" class="grayline" style="display:none">
			                     <table>
								   <tr>
									       <td colspan=7>列表显示方案（全不勾选为默认方案）：</td>
								   </tr>
								   </table>
								   <div style="height:300px;overflow-y:auto;border:1px solid #b7b7b7;">
								   <table width="100%" border="0" cellpadding="1" cellspacing="1" class="listTable change-table" style="border:0 none;">
								        <input id="queryradio" name="queryradio" type="hidden" value="0">
								        <input id="queryCasesSel" name="queryCasesSel" type="hidden" value=""></input>
										<input id="titleradio" name="titleradio" type="hidden" value="0">
										<input id="listCasesSel" name="listCasesSel" type="hidden" value=""></input>
										<input id="expfieldradio" name="expfieldradio" type="hidden" value="2">
										<input id="listCasesSel2" name="listCasesSel2" type="hidden" value=""></input>
										<input id="mobilesearch" name="mobilesearch" type="hidden" value="0">
										<input id="mobile_search" name="mobile_search" type="hidden" value="">
										<input id="mobilelist" name="mobilelist" type="hidden" value="0">
										<input id="mobile_listfield" name="mobile_listfield" type="hidden" value="">
		                                <thead id="headerContainer">									  
                                           <tr class="listTableHead">
			                               <td>源字段</td>			 
			                               <td><input type="checkbox" name="items_listShow"  onclick="setCheckBoxState('listShow',this.checked);" >列表显示</td>			
			                               <td><input type="checkbox" name="items_selectCase"  onclick="setCheckBoxState('selectCase',this.checked);" >查询方案</td> 
			                               <td><input type="radio" name="items_link" checked="checked">链接字段</td> 
			                               <td><input type="checkbox" name="items_exportField"  onclick="setCheckBoxState('exportField',this.checked);" >导出字段</td>
										   <td><input type="checkbox" name="items_mobile_listfield"  onclick="setCheckBoxState('mobile_listf',this.checked);" >移动列表</td> 
			                               <td><input type="checkbox" name="items_mobile_search" onclick="setCheckBoxState('mobile_searchf',this.checked);" >移动查询</td>
                                           </tr>
		                               </thead>
		                               <tbody  id="itemContainer_list" >
		                                 
		                               </tbody>
                                 </table>
								 </div>
								 <table>
								 <tr>
							<td>排序：&nbsp;&nbsp;&nbsp;
								<input type="radio" id="defOrder1" name="defOrder" value="-1" <%if(("".equals(po.getMenuDefQueryOrder()+""))||("null".equals(po.getMenuDefQueryOrder()+""))||(po.getMenuDefQueryOrder()==null)){out.print("checked");}%> onclick="changeDef(this.value);"/>默认
								<input type="radio" id="defOrder2" name="defOrder" value="0"  onclick="changeDef(this.value);"/>设置
							</td>
					</tr>
                    <tr>
                     <td>
							<table width="100%" id="taborder" style="display:none">
								<tr>
									<td align="left">
										<select id="fieldName1" name="fieldName1" class="selectlist" style="width:100px;"></select>
										<input type="checkbox" id="field1Desc1" name="field1Desc1" value="desc"/>降序
										<input id="orderbutA" type="button" class="btnButton4font"  value="确 定" />
										<input id="orderbutB" type="button" class="btnButton4font"  value="清 除" />
									</td>
								</tr>
								<tr>
									<td valign="top" align="left">
										 <textarea class="inputTextarea" style="width:650px;" rows="5" id="orderStr" name="orderStr"></textarea>
									</td>
								</tr>
							 </table>
			         </td>
				</tr>
				  <tr>
                    <td height="10"></td>
                </tr>
				
                <tr>
				  <td>
				      列表自定义按钮：<input id="listtabbutadd" type="button" class="btnButton4font" value="新 增" />
				  </td>
                </tr>

                <tr>
					<td  valign="top" width="100%">
						  <table border="0" width="82%" bordercolor="" cellpadding="0" cellspacing="0" id="actionTbl" class="listTable" style="border-top: 1px solid #e7e7e7;">
								<tr>
									<td class="listTableLine1" align="center" width="100">操作名称</td>
									<td class="listTableLine1" align="center" width="100">动作属性</td>
									<td class="listTableLine1" align="center" width="100">链接文件</td>
									<td class="listTableLine1" align="center" width="160">查看权限</td>
									<td class="listTableLine1"  width="60">操作</td>
								</tr>

                                <%
							   List buttonList = (List)request.getAttribute("buttonList");
							   if(buttonList != null && buttonList.size()>0){
								   for(int i=0;i<buttonList.size();i++){
									   CustomerMenuButtonPO customerMenuButtonPO =  (CustomerMenuButtonPO) buttonList.get(i);
									   String actname = customerMenuButtonPO.getActname();
									   String actType = customerMenuButtonPO.getActtype();
									   String viewscopenames = customerMenuButtonPO.getViewscopenames();
									   if(viewscopenames == null || "null".equals(viewscopenames)) viewscopenames="";
									   String viewscopes = customerMenuButtonPO.getViewscopes();
									   if(viewscopes == null || "null".equals(viewscopes)) viewscopes="";
									   String linkurl = customerMenuButtonPO.getLinkurl();
						       %>
								<tr id='<%=i%>' align='center'>
		                           <td><input type="text" id="actname<%=i%>" name="actname" class="inputText" style="width:80px;" value="<%=actname%>"/></td>
		                           <td>
								      <select id="acttype<%=i%>" name="acttype">
								        <option value="0" <%if("0".equals(actType)){out.print("selected");}%>>批量动作</option>
										<option value="1" <%if("1".equals(actType)){out.print("selected");}%>>单选动作</option>
									  </select>
								   </td>
		                           <td><input type="text" id="linkurl<%=i%>" name="linkurl" class="inputText" style="width:80px;" value="<%=linkurl%>"/></td>
		                           <td><input type="hidden" id="viewscopes<%=i%>" name="viewscopes" value="<%=viewscopes%>">
		                               <input type="text" id="viewscopenames<%=i%>" name="viewscopenames" readonly="readonly" class="inputText"  style="width:80px;" value="<%=viewscopenames%>">
		                               &nbsp;
		                               <a href="javascript:void(0);" style="cursor:pointer" onClick="openSelect({allowId:'viewscopes<%=i%>', allowName:'viewscopenames<%=i%>', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"><img src="images/select_arrow.gif" align="absmiddle" style="cursor:pointer"/></a>

                                   </td>
		                           <td><input type="button" class="btnButton4font" value="移 除" onclick="deleteRow('<%=i%>')"/></td>
		                        </tr>
							  <%
								   }
							   }			
						      %>

							</table>
					</td>
                </tr>
				<tr>
                    <td height="10"></td>
                </tr>
     
				<tr>
				  <td>
					列表动作：<input id="actionTbutton1" type="button" class="btnButton4font" value="打 开" />
				  </td>
				</tr>
				
				<tr>
				  <td>
					  <table border="0" bordercolor="gray" cellpadding="0" cellspacing="0" id="actionTb1" class="listTable" style="width:610px;display:none;border-top: 1px solid #e7e7e7;">
								<tr>
									<td class="listTableLine1" align="center" width="40%" nowrap>列表处理文件：</td>
									<td width="60%">
										<input type="text" name="listtabrealFileName" id="listtabrealFileName" style="width:350px;" value="<%=po.getListIncludeFile()==null?"":po.getListIncludeFile() %>"/>   
										<input type="hidden" name="listtabsaveFileName" id="listtabsaveFileName" style="width:800px;" value="<%=po.getListIncludeFile()==null?"":po.getListIncludeFile() %>"/> 
										<%-- <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
										   <jsp:param name="dir"      value="/modulesext/devform/customize/" />
										   <jsp:param name="uniqueId"    value="listId" />
										   <jsp:param name="realFileNameInputId"    value="listtabrealFileName" />
										   <jsp:param name="saveFileNameInputId"    value="listtabsaveFileName" />
										   <jsp:param name="canModify"   value="yes" />
										   <jsp:param name="width"        value="90" />
										   <jsp:param name="height"       value="20" /> 
										   <jsp:param name="multi"        value="false" />
										   <jsp:param name="buttonClass" value="upload_btn" />
										   <jsp:param name="buttonText"       value="上传jsp" />
										   <jsp:param name="fileSizeLimit"        value="0" />
										   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
										   <jsp:param name="uploadLimit"      value="1" />
										</jsp:include>--%>
									</td>
								</tr>
								<tr>
									<td class="listTableLine1" align="center" width="150">操作名称</td>
									<td class="listTableLine1" align="center" width="250">方法名</td>
								</tr>
								<tr>

										<td class="listTableLine1" align="center">删除加载</td>
										<td class="listTableLine1" align="center"><input type="text" id="delLoad" name="delLoad" class="inputText" style="width:350px;"/></td>
								</tr>
								<tr>

										<td class="listTableLine1" align="center">批量删除加载</td>
										<td class="listTableLine1" align="center"><input type="text" id="delAllLoad" name="delAllLoad" class="inputText" style="width:350px;"/></td>
								</tr>
								<tr>

										<td class="listTableLine1" align="center">批量保存加载</td>
										<td class="listTableLine1" align="center"><input type="text" id="saveAllLoad" name="saveAllLoad" class="inputText" style="width:350px;"/></td>
								</tr>

						</table>

					 </td>
				  </tr>
				
				  
              
				
				  <tr>
                    <td height="10"></td>
                </tr>

				<tr>
				   <td>
					 表单动作：<input id="actionTbutton2" type="button" class="btnButton4font" value="打 开" />
				   </td>
                </tr>
				<tr>
				  <td>
						<table border="0" bordercolor="gray" cellpadding="0" cellspacing="0" id="actionTb2" style="width:610px;display:none;border-top: 1px solid #e7e7e7;" class="listTable" >
							<tr>
									<td width="40%" class="listTableLine1" align="center" nowrap>表单处理文件：</td>
									<td width="60%">
										<input type="text" name="formtabrealFileName" id="formtabrealFileName" style="width:350px;" value="<%=po.getIncludeFile()==null?"":po.getIncludeFile() %>"/>   
										<input type="hidden" name="formtabsaveFileName" id="formtabsaveFileName" style="width:800px;" value="<%=po.getIncludeFile()==null?"":po.getIncludeFile() %>"/> 
										<%-- <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
										   <jsp:param name="dir"      value="/modulesext/devform/customize/" />
										   <jsp:param name="uniqueId"    value="formId" />
										   <jsp:param name="realFileNameInputId"    value="formtabrealFileName" />
										   <jsp:param name="saveFileNameInputId"    value="formtabsaveFileName" />
										   <jsp:param name="canModify"   value="yes" />
										   <jsp:param name="width"        value="90" />
										   <jsp:param name="height"       value="20" /> 
										   <jsp:param name="multi"        value="false" />
										   <jsp:param name="buttonClass" value="upload_btn" />
										   <jsp:param name="buttonText"       value="上传jsp" />
										   <jsp:param name="fileSizeLimit"        value="0" />
										   <jsp:param name="fileTypeExts"         value="*.jsp" /> 
										   <jsp:param name="uploadLimit"      value="1" />
										</jsp:include>--%>
									</td>
							</tr>
							<tr>
								<td class="listTableLine1" align="center" width="150">操作名称</td>
								<td class="listTableLine1" align="center" width="250">方法名</td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">新增加载</td>
									<td class="listTableLine1" align="center"><input type="text" id="addLoad" name="addLoad" class="inputText" style="width:350px;"/></td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">修改加载</td>
									<td class="listTableLine1" align="center"><input type="text" id="modiLoad" name="modiLoad" class="inputText" style="width:350px;"/></td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">新增保存</td>
									<td class="listTableLine1" align="center"><input type="text" id="addSaveLoad" name="addSaveLoad" class="inputText" style="width:350px;"/></td>
							</tr>
							<tr>

									<td class="listTableLine1" align="center">修改保存</td>
									<td class="listTableLine1" align="center"><input type="text" id="modiSaveLoad" name="modiSaveLoad" class="inputText" style="width:350px;"/></td>
							</tr>
						</table>
					 </td>
				  </tr>
				  		
			 </table>
			 
			 
					           </div>

                             
                           </div>					      
						</td>
					</tr>
					 
					<tr>
						<td height="10"></td>
					</tr>				 

	          </table>

			  <!----------------------------------------------------------------------------------------------------------------------------------->

             </td>
		  </tr>


		  <tr id="linktitleTR3" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="3" id="readCK4" name="readCK" onclick="cleanData(3);"/>启动一个流程</td>
		  </tr>
		  <tr id="linkTR3" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left">
			   <table >
					  <tr>
                        <td valign="top">
							  <select id="menuStartFlow"  name="menuStartFlow_" class="xeasyui-combobox" data-options="panelHeight:200" style="width:260px;">
							   <%
								  if (workFlows != null && workFlows.size() > 0) {
									for(int i = 0; i < workFlows.size(); i++) {
									  ListItem item = (ListItem)workFlows.get(i);
								%>
									<option value="<%=item.getId()%>"><%=item.getName()%></option>
								<%}}%>
							 </select> 
						 </td>
                     </tr>
			  </table>
			</td>
		  </tr>
		  <tr id="linktitleTR4" style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left"><input type="radio" value="4" id="readCK5" name="readCK" onclick="cleanData(4);"/>链接一个文件</td>
		  </tr>
		  <tr id="linkTR4" id style="display:none">
			<td>&nbsp;</td>
			<td valign="top" align="left">
			  <table >
					  <tr>
                        <td valign="top">
                            <input type="hidden" name="menuFileLink" id="menuFileLink" style="width:800px;" value="<%=po.getMenuFileLink()==null?"":po.getMenuFileLink()%>"/>   
							<input type="hidden" name="menuHtmlLink" id="menuHtmlLink" style="width:800px;" value="<%=po.getMenuHtmlLink()==null?"":po.getMenuHtmlLink()%>"/> 
							<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">   
							   <jsp:param name="dir"      value="customize" />
							   <jsp:param name="uniqueId"    value="linkfileId" />
							   <jsp:param name="realFileNameInputId"    value="menuFileLink" />
							   <jsp:param name="saveFileNameInputId"    value="menuHtmlLink" />
							   <jsp:param name="canModify"   value="yes" />
							   <jsp:param name="multi"        value="false" />
							   <jsp:param name="buttonClass" value="upload_btn" />
							   <jsp:param name="fileSizeLimit"        value="0" />
							   <jsp:param name="uploadLimit"      value="1" />
							</jsp:include>
					    </td>
                     </tr>
			  </table>
			</td>
		  </tr>
		  <tr>
			  <td colspan="2">
			    <table width="100%" border="0" cellpadding="0" cellspacing="0">
				  <tr height="1" bgcolor="#808080">
					<td style="padding:0;"></td>
				  </tr>
				  <tr height="1"  bgcolor="#FFFFFF">
					<td style="padding:0;"></td>
				  </tr>
				</table>
			  </td>
		  </tr>
		   <!-- ***************************************************************************** -->
		   <tr>
			<td>显示方式：</td>
			<td valign="top" align="left">
              <input type="radio" name="menuOpenStyle" value="0"  <%if("0".equals(po.getMenuOpenStyle()+"")){out.print("checked");}%>/>内嵌 
			  <input type="radio" name="menuOpenStyle" value="1"  <%if("1".equals(po.getMenuOpenStyle()+"")){out.print("checked");}%>/>弹出
			</td>
		  </tr>


		   <tr class="Table_nobttomline">    
			<td > </td>   
			   <td nowrap>    
				   <input type="button" class="btnButton4font" onClick="modiclose(this);" value="<%=Resource.getValue(whir_locale,"common","comm.saveclose")%>" />
				   <input type="button" class="btnButton4font" onClick="resetDataForm();"     value="<%=Resource.getValue(whir_locale,"common","comm.reset")%>" />    
				   <input type="button" class="btnButton4font" onClick="closeWindow(null);" value="<%=Resource.getValue(whir_locale,"common","comm.exit")%>" />    
			   </td>    
		   </tr>    
		</table>  
		 
		</s:form>  
		</div>  
	</div>  
</body>  
<%@ include file="/public/include/include_extjs.jsp"%>
<script type="text/javascript">  
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//设置表单为异步提交  
initDataFormToAjax({"dataForm":'dataForm',"queryForm":'queryForm',"tip":'保存'});  

//*************************************下面的函数属于各个模块 完全 自定义的*********************************************//

function resetDataForm(){
  location_href('<%=rootPath%>/custormermenu!modiCustMenu.action?validate=<%=request.getParameter("validate")%>&id=<%=request.getParameter("id")%>');
}

function initModiData() {

   <%if("0".equals(po.getMenuLevelSet())){%>
      $('#defHrefSpan').show();
      <%if(po.getMenuURLSet()!=null&&!"0".equals(po.getMenuURLSet())&&!"-1".equals(po.getMenuURLSet())){%>
       //$('#defHrefSel').combobox('select', '<%=po.getMenuURLSet()%>');
	    whirSelect.setValue('defHrefSel','<%=po.getMenuURLSet()%>');
	  <%}%>
   <%}%>
  
   <% 
     if(po.getMenuListTableMap()!=null&&
		!"".equals(po.getMenuListTableMap())){
   %>
	   cleanData(2);

       //var url='custormermenu!getTableListByModelId.action?modelId=<%=tableModelId%>&menuListTableId=<%=po.getMenuListTableMap()%>';
       //whirCombobox.clear('menuListTableMapSel');
	   //whirCombobox.reload('menuListTableMapSel', url);
	   //whirCombobox.setValue('menuListTableMapSel', '<%=po.getMenuListTableMap()%>');

	whirExtCombobox.clear('menuListTableMapSel');

	tableStore.load({params:{modelId:'<%=tableModelId%>', menuListTableId:'<%=po.getMenuListTableMap()%>'}});

    whirExtCombobox.setValue('menuListTableMapSel', '<%=po.getMenuListTableMap()%>|<%=po.getMenuListTableName()%>');


	   selmenuListTab('<%=po.getMenuListTableMap()%>','<%=po.getMenuSearchBound()%>');
	   //setFields('<%=po.getMenuSearchBound()%>');
	   setFields_update('<%=po.getMenuSearchBound()%>');//update 2015/12/17

	   <%
		  CustMenuWithOriginalBD oribd = new CustMenuWithOriginalBD();
		  List fountainFieldlist = oribd.getFieldControls(po.getId()+"","0");
		  List readFieldlist = oribd.getFieldControls(po.getId()+"","1");
		  List writeFieldlist = oribd.getFieldControls(po.getId()+"","2");
		  List hiddenFieldlist = oribd.getFieldControls(po.getId()+"","3");
		  List listWriteFieldlist = oribd.getFieldControls(po.getId()+"","4");
		  List fountainField1list = oribd.getFieldControls(po.getId()+"","5");

		  if((fountainFieldlist!= null && fountainFieldlist.size()>0)||
			  (readFieldlist!= null && readFieldlist.size()>0)||
			  (writeFieldlist!= null && writeFieldlist.size()>0)||
			  (hiddenFieldlist!= null && hiddenFieldlist.size()>0)){
		%>
			//opensetField(document.getElementById('formfieldCK'));  //update 2015/12/17
		
			//$("#fountainField").empty(); //update 2015/12/17
		    //$("#readField").empty();     //update 2015/12/17
			//$("#writeField").empty();    //update 2015/12/17
			//$("#hiddenField").empty();   //update 2015/12/17
		<%
		   if(fountainFieldlist!=null){
			   for(int i=0;i<fountainFieldlist.size();i++){
				  List _list = (List)fountainFieldlist.get(i);
				  String fieldid = (String)_list.get(0);
				  String fieldname = (String)_list.get(1);
				  String field_desname = (String)_list.get(2);
		%>
			  //$("#fountainField").append("<option value='<%=fieldid+"|"+fieldname%>'><%=field_desname%></option>");

		<%}
			   }
		   if(readFieldlist!=null){
			   for(int i=0;i<readFieldlist.size();i++){
				  List _list = (List)readFieldlist.get(i);
				  String fieldid = (String)_list.get(0);
				  String fieldname = (String)_list.get(1);
				  String field_desname = (String)_list.get(2);
				  String readstr=fieldid+"|"+fieldname;
		%>
			   $("input[name='readField']").each(function(){			       
			      if($(this).val()=='<%=readstr%>'){
				    $(this).attr("checked","checked");
				   }			 
                  });
			   			   
			   //$("#readField").append("<option value='<%=fieldid+"|"+fieldname%>'><%=field_desname%></option>"); //update 2015/12/17

		 <%    }
		    }
		     if(writeFieldlist!=null){
			   for(int i=0;i<writeFieldlist.size();i++){
				  List _list = (List)writeFieldlist.get(i);
				  String fieldid = (String)_list.get(0);
				  String fieldname = (String)_list.get(1);
				  String field_desname = (String)_list.get(2);
		  %>
		         $("input[name='writeField']").each(function(){
			        if($(this).val()=='<%=fieldid+"|"+fieldname%>'){
				      $(this).attr("checked","checked");
				   }			 
                  });
			   //$("#writeField").append("<option value='<%=fieldid+"|"+fieldname%>'><%=field_desname%></option>");//update 2015/12/17

		   <%  }
			 }
			 if(hiddenFieldlist!=null){
				   for(int i=0;i<hiddenFieldlist.size();i++){
					  List _list = (List)hiddenFieldlist.get(i);
					  String fieldid = (String)_list.get(0);
					  String fieldname = (String)_list.get(1);
					  String field_desname = (String)_list.get(2);
			%>
			
			       $("input[name='hiddenField']").each(function(){
			          if($(this).val()=='<%=fieldid+"|"+fieldname%>'){
				        $(this).attr("checked","checked");
				   }			 
                  });
				//$("#hiddenField").append("<option value='<%=fieldid+"|"+fieldname%>'><%=field_desname%></option>");//update 2015/12/17

			<%     }
			  }

		  }
		  if((listWriteFieldlist!= null && listWriteFieldlist.size()>0)||
			  (fountainField1list!= null && fountainField1list.size()>0)){
		%>
		    //opensetField1(document.getElementById('listfieldCK'));  //update 2015/12/17
		    //$("#fountainField1").empty();  //update 2015/12/17
		    //$("#listWriteField").empty();  //update 2015/12/17
		
        <%
		   if(fountainField1list!=null){
			   for(int i=0;i<fountainField1list.size();i++){
				  List _list = (List)fountainField1list.get(i);
				  String fieldid = (String)_list.get(0);
				  String fieldname = (String)_list.get(1);
				  String field_desname = (String)_list.get(2);
		%>
		    //$("#fountainField1").append("<option value='<%=fieldid+"|"+fieldname%>'><%=field_desname%></option>"); //update 2015/12/17

		<%     }
		    }
			if(listWriteFieldlist!=null){
			   for(int i=0;i<listWriteFieldlist.size();i++){
				  List _list = (List)listWriteFieldlist.get(i);
				  String fieldid = (String)_list.get(0);
				  String fieldname = (String)_list.get(1);
				  String field_desname = (String)_list.get(2);
		%>
			
			$("input[name='listWriteField']").each(function(){
			          if($(this).val()=='<%=fieldid+"|"+fieldname%>'){
				        $(this).attr("checked","checked");
				   }			 
                  });
			//$("#listWriteField").append("<option value='<%=fieldid+"|"+fieldname%>'><%=field_desname%></option>");//update 2015/12/17

		 <%     }
			 }
		  }
		%>
            $('#menuWhereSql').val("<%=(po.getMenuDefQueryCondition()==null?"":po.getMenuDefQueryCondition())%>");
		<%
		  //设置排序
		  if((po.getMenuDefQueryOrder()!=null)&&(!"".equals(po.getMenuDefQueryOrder()))&&(!"null".equals(po.getMenuDefQueryOrder()))){	
		%>
			 $("input[name='defOrder']").each(function(){
				if($(this).val()==0){
			 	$(this).attr("checked","checked");
			 }
			  });
			changeDef("0");
            $('#orderStr').val("<%=(po.getMenuDefQueryOrder()==null?"":po.getMenuDefQueryOrder())%>");
		<%}else{%>
		   $("input[name='defOrder']").each(function(){
				 if($(this).val()==-1){
					 $(this).attr("checked","checked");
				 }
			  });
		
		<%}%>
		
		<%
		  String listIncludeFile = po.getListIncludeFile()==null?"":po.getListIncludeFile();
		  String delLoad = po.getDelLoad()==null?"":po.getDelLoad();
		  String delAllLoad = po.getDelAllLoad()==null?"":po.getDelAllLoad();
		  String saveAllLoad = po.getSaveAllLoad()==null?"":po.getSaveAllLoad();
		  if(!"".equals(delLoad)||!"".equals(delAllLoad)||!"".equals(saveAllLoad)){
	    %>
	        
           $("#actionTbutton1").val('关闭');
		   $('#actionTb1').show();
           $("#listtabrealFileName").val('<%=listIncludeFile%>');
		   $("#listtabsaveFileName").val('<%=listIncludeFile%>');
		   $("#delLoad").val('<%=delLoad%>');
		   $("#delAllLoad").val('<%=delAllLoad%>');
		   $("#saveAllLoad").val('<%=saveAllLoad%>');
		 <%
		  }
		%>

		<%
		  String includeFile = po.getIncludeFile()==null?"":po.getIncludeFile();
		  String addLoad = po.getAddLoad()==null?"":po.getAddLoad();
		  String modiLoad = po.getModiLoad()==null?"":po.getModiLoad();
		  String addSaveLoad = po.getAddSaveLoad()==null?"":po.getAddSaveLoad();
		  String modiSaveLoad = po.getModiSaveLoad()==null?"":po.getModiSaveLoad();
		  if(!"".equals(addLoad)||!"".equals(modiLoad)||!"".equals(addSaveLoad)||!"".equals(modiSaveLoad)){
		%>
		   
           $("#actionTbutton2").val('关闭');
		   $('#actionTb2').show();
		   $("#formtabrealFileName").val('<%=includeFile%>');
		   $("#formtabsaveFileName").val('<%=includeFile%>');
		   $("#addLoad").val('<%=addLoad%>');
		   $("#modiLoad").val('<%=modiLoad%>');
		   $("#addSaveLoad").val('<%=addSaveLoad%>');
		   $("#modiSaveLoad").val('<%=modiSaveLoad%>');
		<%
		  }
		%>
		<%
		  if(po.getMenuListQueryConditionElements()!=null&&
			  !"null".equals(po.getMenuListQueryConditionElements())&&
			  !"".equals(po.getMenuListQueryConditionElements())){	
		%>
          /**  update 2015/12/17
		    showQuery("1");  
		   $("input[name='queryradio']").each(function(){
		  	if($(this).val()==1){
					$(this).attr("checked","checked");
				}
			 });
			whirSelect.setValue('queryCasesSel', '<%=po.getMenuListQueryConditionElements()%>');      
			selplan(0);
			//输入框赋值
			$("#queryCaseName").val('<%=queryCasesSelName%>');  
			**/ 
			selplanNew(0,'<%=po.getMenuListQueryConditionElements()%>');// add by 2015/12/17		
		<%}%>
		<%
		  if(po.getMobile_listfield()!=null&&
			  !"null".equals(po.getMobile_listfield())&&
			  !"".equals(po.getMobile_listfield())){	
		%>
          /**  update 2015/12/17
		    showQuery("1");  
		   $("input[name='queryradio']").each(function(){
		  	if($(this).val()==1){
					$(this).attr("checked","checked");
				}
			 });
			whirSelect.setValue('queryCasesSel', '<%=po.getMenuListQueryConditionElements()%>');      
			selplan(0);
			//输入框赋值
			$("#queryCaseName").val('<%=queryCasesSelName%>');  
			**/ 
			selplanNew(5,'<%=po.getMobile_listfield()%>');// add by 2015/12/17		
		<%}%>
		<%
		  if(po.getMobile_search()!=null&&
			  !"null".equals(po.getMobile_search())&&
			  !"".equals(po.getMobile_search())){	
		%>
          /**  update 2015/12/17
		    showQuery("1");  
		   $("input[name='queryradio']").each(function(){
		  	if($(this).val()==1){
					$(this).attr("checked","checked");
				}
			 });
			whirSelect.setValue('queryCasesSel', '<%=po.getMenuListQueryConditionElements()%>');      
			selplan(0);
			//输入框赋值
			$("#queryCaseName").val('<%=queryCasesSelName%>');  
			**/ 
			selplanNew(6,'<%=po.getMobile_search()%>');// add by 2015/12/17		
		<%}%>
		<%
		  if(po.getMenuListDisplayElements()!=null&&
			  !"null".equals(po.getMenuListDisplayElements())&&
			  !"".equals(po.getMenuListDisplayElements())){	
		%>
           /**
		   showTitle("1");
		   $("input[name='titleradio']").each(function(){
				if($(this).val()==1){
					$(this).attr("checked","checked");
				}
			 });
			whirSelect.setValue('listCasesSel', '<%=po.getMenuListDisplayElements()%>');
			selplan(1);
			//输入框赋值
			$("#listCaseName").val('<%=listCasesSelName%>');
			**/			
			selplanNew(1,'<%=po.getMenuListDisplayElements()%>');// add by 2015/12/17				
		<%}%>
		<%
		  if("default".equals(po.getMenuListExpDisplayElements())){	
		%>
           /**showexp("2");
		   $("input[name='expfieldradio']").each(function(){
				if($(this).val()==2){
					$(this).attr("checked","checked");
				}
			 });**/
		<%}else if(po.getMenuListExpDisplayElements()!=null&&
			  !"null".equals(po.getMenuListExpDisplayElements())&&
			  !"".equals(po.getMenuListExpDisplayElements())){%>
           /**showexp("1");
		   $("input[name='expfieldradio']").each(function(){
				if($(this).val()==1){
					$(this).attr("checked","checked");
				}
			 });
			 whirSelect.setValue('listCasesSel2', '<%=po.getMenuListExpDisplayElements()%>');
			 selplan(2);
			 //输入框赋值
			 $("#listCaseName2").val('<%=listCasesSel2Name%>');
			 **/
			 selplanNew(2,'<%=po.getMenuListExpDisplayElements()%>');// add by 2015/12/17				 
		<%}else{%>
           /**showexp("0");
		   $("input[name='expfieldradio']").each(function(){
				if($(this).val()==0){
					$(this).attr("checked","checked");
				}
			 });
			 **/
		<%}%>
		<%if(po.getMenuMaintenanceSubTableName()!=null&&
			!"-1".equals(po.getMenuMaintenanceSubTableName())&&
			!"".equals(po.getMenuMaintenanceSubTableName())){%>
             //设置链接字段
		    // whirCombobox.clear('menuMaintenanceSubTableName');
	        // whirCombobox.reload('menuMaintenanceSubTableName', 'custormermenu!getListFieldByTblId.action?tblId=<%=po.getMenuListTableMap()%>&selname=<%=po.getMenuMaintenanceSubTableName()%>');
			
			// var json1 = ajaxForSync("custormermenu!getListFieldByTblId.action","tblId=<%=po.getMenuListTableMap()%>&selname=<%=po.getMenuMaintenanceSubTableName()%>");
	        // setSelectObj(json1,$('#menuMaintenanceSubTableName'));
			// whirSelect.setValue('menuMaintenanceSubTableName','<%=po.getMenuMaintenanceSubTableName()%>');
             
			 $("input[name='menuMaintenanceSubTableName']").each(function(){//update by 2015/12/17
				if($(this).val()=='<%=po.getMenuMaintenanceSubTableName()%>'){
					$(this).attr("checked","checked");
				}
			 });
			
			
		<%}%>


   <%
	 }else if(po.getMenuStartFlow()!=null&&
		!"".equals(po.getMenuStartFlow())&&
		!"-1".equals(po.getMenuStartFlow())){
   %>
	   cleanData(3);
       //$('#menuStartFlow').combobox('select','<%=po.getMenuStartFlow()%>');
	   whirExtCombobox.setValue('menuStartFlow', '<%=po.getMenuStartFlow()%>') 
   <%
	 }else if(po.getMenuFileLink()!=null&&
		!"".equals(po.getMenuFileLink())){
   %>
       cleanData(4);
   <%
	 }else{
   %>
	   cleanData(1);
   <%}
   %>
   <%if(!"0".equals(po.getMenuLevelSet()+"")){%>
      //$('#menuBlone').combobox('select', '<%=po.getMenuBlone()%>');
      whirSelect.setValue('menuBlone','<%=po.getMenuBlone()%>');
	  setMenuLocation('<%=po.getId()%>','<%=po.getMenuBlone()%>');
   <%}else{%>
      //$('#menuBlone').combobox('select', '-1');
      whirSelect.setValue('menuBlone','-1');
	  changeSub('-1');
   <%}%>
   

}
</script>  
<script src="<%=rootPath%>/platform/custom/customize/js/common_modi.js" language="javascript"></script>
<script src="<%=rootPath%>/platform/custom/customize/js/common.js" language="javascript"></script>
<script src="<%=rootPath%>/platform/custom/customize/js/common_new.js" language="javascript"></script>

<!--script src="<%=rootPath%>/scripts/main/whir.ready.js" type="text/javascript"></script-->
</html>  