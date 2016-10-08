<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="com.whir.ezoffice.workflow.vo.PackageVO"%>
<%@ page import="com.whir.ezoffice.workflow.vo.AccessTableVO"%>
<%@ page import="com.whir.ezoffice.workflow.vo.SimpleFieldVO"%>
<%@ page import="java.util.*"%>
<%
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();
%>

<%@page import="com.whir.i18n.Resource"%>
<%
	java.util.List noWriteList = (java.util.List) request.getAttribute("noWriteFieldList");
	java.util.List hiddenFieldList = (java.util.List) request.getAttribute("hiddenFieldList");
	java.util.List fieldList = (java.util.List) request.getAttribute("fieldList");
	java.util.List attribteRelateList = (java.util.List) request.getAttribute("attribteRelateList");

    boolean   chanNoWrite=false;
	if(request.getParameter("chanNoWrite")!=null&&request.getParameter("chanNoWrite").toString().equals("1")){
	   chanNoWrite=true;
	}
	boolean   chanRemind=false;
	if(request.getParameter("chanRemind")!=null&&request.getParameter("chanRemind").toString().equals("1")){
	   chanRemind=true;
	}
	String    moduleId=request.getParameter("moduleId")==null?"1":request.getParameter("moduleId").toString();
%>
 
<table  width="100%" border="0" cellpadding="0" cellspacing="0" class="Table_bottomline"  style="margin-left:4px;margin-top:4px;" >
	<%if(chanNoWrite){%>
	<tr>
		<td id="field_td1" class="td_lefttitle"  width="120px" nowrap>
		   <bean:message 	bundle="workflow" key="workflow.newworkflownowritefield" />：
		</td>
		<!-- 发起时不填的字段 -->
		<td id="field_td2" colspan="3">
			<table width="100%" border="0" style="margin-left:-4px;" >
				<tr>
					<td width="105px">
					<select name="field" id="field" multiple="multiple"  size="9"  style="width: 100px">				
					 <%
					  String noWriteString = "";
					  for(int i = 0; i < noWriteList.size(); i ++){
						 noWriteString = noWriteString + "$" + noWriteList.get(i) + "$";
					  }
					  SimpleFieldVO simpleFieldVO = new SimpleFieldVO();
					  for(int i = 0; i < fieldList.size(); i ++){
						  simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
						  if(noWriteString.indexOf("$" + simpleFieldVO.getId() + "$") < 0 && !"401".equals(simpleFieldVO.getPoField())){
							  if(simpleFieldVO.isCanIdea() ==false){//公文不显示批示意见字段
					  %>
								<option value="<%=simpleFieldVO.getId()%>"><%=simpleFieldVO.getDisplayName()%></option>
					  <%
					  }}}
					  %>
					</select>
					</td>
					<td  width="90px"  align="center" >
				   	    <input name="button" type="button" class="btnButton4font"  id="button" value=" > " onclick='transferOptions("field","noWriteField");'><div style="height:5px">&nbsp;</div>
					    <input name="button" type="button" class="btnButton4font"  id="button" value=">>" onclick='transferOptionsAll("field","noWriteField");'><div style="height:5px">&nbsp;</div>
					    <input name="button" type="button" class="btnButton4font"  id="button" value=" < " onclick='transferOptions("noWriteField","field");'><div style="height:5px">&nbsp;</div>
					    <input name="button" type="button" class="btnButton4font"  id="button" 	value="<<" onclick='transferOptionsAll("noWriteField","field");'><div style="height:5px">&nbsp;</div>
					</td>
					<td width="105px">
					 <select name="noWriteField" id="noWriteField" 	multiple="multiple" size="9" style="width: 100px">
			       <%
                     for(int i = 0; i < fieldList.size(); i ++){
                         simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
                         for(int j =0; j < noWriteList.size(); j ++){
                             if(simpleFieldVO.getId() == Long.parseLong(noWriteList.get(j).toString())){
                   %>
							<option value="<%=simpleFieldVO.getId()%>"><%=simpleFieldVO.getDisplayName()%></option>
				   <%        
				             }
                         }
                     }			      
				   %>
					 </select>
				   </td>
				   <td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr style="display:<%=(moduleId.equals("1")||moduleId.equals("2")||moduleId.equals("3")||moduleId.equals("34"))?"''":"none"%>">
		<!-- 对发起人隐藏字段 -->
		<td id="field_td5"><bean:message 	bundle="workflow" key="workflow.set_hiddenforinit" />：</td>
		<td id="field_td6" colspan="3">
			<table width="100%" border="0" style="margin-left:-4px;">
				<tr>
					<td  width="105px">
					     <select name="fieldAll" id="fieldAll" multiple="multiple" size="9"  style="width: 100px">
				        <%
                         String hiddenString = "";
                         for(int i = 0; i < hiddenFieldList.size(); i ++){
                              hiddenString = hiddenString + "$" + hiddenFieldList.get(i) + "$";
                         }
                         simpleFieldVO = new SimpleFieldVO();
                         for(int i = 0; i < fieldList.size(); i ++){
                             simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
							 String  prName=simpleFieldVO.getRealName();
							 if(moduleId.equals("2")||moduleId.equals("3")||moduleId.equals("34")){
							      prName=simpleFieldVO.getPoField();
							 } 
                             if(hiddenString.indexOf("$" +prName + "$") < 0 && !"401".equals(simpleFieldVO.getPoField())){
								 if(simpleFieldVO.isCanIdea() ==false){//公文不显示批示意见字段
                        %>
							  <option value="<%=prName%>"><%=simpleFieldVO.getDisplayName()%></option>
						<%   
						 }}}                       
						%>
					    </select>
					</td>
					<td width="90px"  align="center" >
					    <input name="button" type="button"  class="btnButton4font"  id="button" value=" > " onclick='transferOptions("fieldAll","firstHiddenField");'>
						<div style="height:5px">&nbsp;</div> 
						<input name="button" type="button" class="btnButton4font"   id="button" value=">>" onclick='transferOptionsAll("fieldAll","firstHiddenField");'>
						<div style="height:5px">&nbsp;</div> 
						<input name="button" type="button" class="btnButton4font"   id="button"  value=" < " onclick='transferOptions("firstHiddenField","fieldAll");'>
						<div style="height:5px">&nbsp;</div> 
						<input name="button" type="button" class="btnButton4font"   id="button" 	value="<<" onclick='transferOptionsAll("firstHiddenField","fieldAll");'>
						<div style="height:5px">&nbsp;</div>
				    </td>
					<td width="105px">
					     <select name="firstHiddenField" id="firstHiddenField" multiple="multiple" size="9" 	style="width: 100px">
						 <%
                            for(int i = 0; i < fieldList.size(); i ++){
                                simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
                                for(int j =0; j < hiddenFieldList.size(); j ++){
									 String  prName=simpleFieldVO.getRealName();
									 if(moduleId.equals("2")||moduleId.equals("3")||moduleId.equals("34")){
										  prName=simpleFieldVO.getPoField();
									 } 
                                    if(prName.equals(hiddenFieldList.get(j).toString())){
                         %>
							<option value="<%=prName%>"><%=simpleFieldVO.getDisplayName()%></option>
						 <%         }
                                } 
                            }
						 %>
					    </select>
				   </td>
				   <td>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
	<%}else{%>
	<input type="hidden" name="noWriteField"
		value="<%=request.getAttribute("moduleVO.noWrite")%>">
	<%}%>


	<%if(chanRemind){%>
	<tr>
		<td id="field_td3" class="td_lefttitle">
		   <bean:message bundle="workflow" key="workflow.newworkflowwarning" />：
		</td>
		<!-- 提醒项 -->
		<td id="field_td4" colspan="3">
			<%
			String remindField = request.getAttribute("remindField").toString();
		    if(remindField==null||remindField.equals("")||remindField.equals("null")){
				remindField= request.getAttribute("remindField").toString();
			}

			//处理提醒项预览顺序问题-----start
			String _nowDisplayName="";
			String _nowHiddenId="";
			String _remindField =remindField;
		    if(_remindField!=null && !_remindField.equals("") && !_remindField.equals("null")){
				_remindField = _remindField.substring(1, _remindField.length()-1);
				_remindField = _remindField.replaceAll("SS", ",");
				String[] remindFieldObj =_remindField.split(",");
				if(remindFieldObj !=null && remindFieldObj.length >0){
					for(int m=0;m<remindFieldObj.length;m++){
						SimpleFieldVO vo = new SimpleFieldVO();
						for(int n = 0; n < fieldList.size(); n ++){
							vo = (SimpleFieldVO) fieldList.get(n);
							//110 多行文本
							//当为form1表明是 主表字段
							if(vo.getArea_name().equals("form1") && vo.isRemind()){
								if(remindFieldObj[m].equals(vo.getRealName())){
									//不显示多行文本
									_nowDisplayName+="["+vo.getDisplayName()+"]";
									_nowHiddenId+="S" + vo.getRealName() + "S";
								}
							}
						}
					}
				}
			}
			//处理提醒项预览顺序问题-----end

			String nowDisplayName="";
			String nowHiddenId="";		 
			//System.out.print("\n-----remindField-----\n"+remindField+"\n----------\n");
			int show = 0;
			int k = 1;
			SimpleFieldVO simpleFieldVO = new SimpleFieldVO();
			for(int j = 0; j < fieldList.size(); j ++){
			    simpleFieldVO = (SimpleFieldVO) fieldList.get(j);
				//110 多行文本
			    //当为form1表明是 主表字段
				if(simpleFieldVO.getArea_name().equals("form1")&&simpleFieldVO.isRemind()){
		  		    if(remindField.indexOf("S" + simpleFieldVO.getRealName() + "S") >= 0){
						//不显示多行文本
						nowDisplayName+="["+simpleFieldVO.getDisplayName()+"]";
						nowHiddenId+="S" + simpleFieldVO.getRealName() + "S";
				    }
			%> 
			 <input type="checkbox" name="remindField" value="<%=simpleFieldVO.getRealName()%>" 	onclick="chooseRemindField(this,'<%=simpleFieldVO.getRealName()%>','<%=simpleFieldVO.getDisplayName()%>')" <%if(remindField.indexOf("S" + simpleFieldVO.getRealName() + "S") >= 0) out.print("checked");%>><%=simpleFieldVO.getDisplayName()%>
		    <%
				    if(k % 8 == 0) out.print("<br>");
				     k ++;
				 }
		    }
		    %>
		</td>
	</tr>
	<!--提醒项预览-->
	<tr>
		<td id="field_td31"  class="td_lefttitle" ><bean:message 	bundle="workflow" key="workflow.set_remindview" />：</td>
		<!-- 提醒项预览 -->
		<td id="field_td41" colspan="3"><input type="text"  class="inputText" readonly id="remindFieldDisplayName"
			name="remindFieldDisplayName" style="width: 78%"  value="<%=_nowDisplayName%>"><input type="hidden" name="remindFieldHiddenId" value="<%=_nowHiddenId%>"
			id="remindFieldHiddenId">
	   </td>
	</tr>
	<%
	}else{
    %>
	<input type="hidden" name="remindField"
		value="<%=request.getAttribute("moduleVO.remind")%>">
	<%}%>

	<%
     if(chanNoWrite){
		 SimpleFieldVO  simpleFieldVO = new SimpleFieldVO();
    %>
	<!--启动属性关联设置 style="display:'<%=("1".equals(request.getAttribute("formType")==null?"":request.getAttribute("formType").toString().trim())||!moduleId.equals("1"))?"none":""%>'"  -->
	<tr id="attributeCheckTr"  <%if(!moduleId.equals("1")){out.print("style=\"display:none\"");}%> >
	    <td class="td_lefttitle" ><bean:message 	bundle="workflow" key="workflow.set_attributerelation" />：</td>
		<td colspan="3" align="left"> <s:checkbox name="attributeRelate" id="attributeRelate" onclick="attributeRelateCheck(this);"></s:checkbox>
		</td>
	</tr>
	<tr style="display:none"  id="attributeCheckTr_table">
	    <td width="110px">&nbsp;</td>
		<td colspan="3" align="left" id="field_td8" 	name="field_td8">
			<table id="tbl_1" width="93%" border="0" cellpadding="0" cellspacing="0" align="left">
				<TBODY>
					<tr>					
						<td><bean:message 	bundle="workflow" key="workflow.set_chooseField" /></td>
						<td><bean:message 	bundle="workflow" key="workflow.set_chooseValue" /></td>
						<td><bean:message 	bundle="workflow" key="workflow.set_relationField" /></td>
						<td><bean:message 	bundle="workflow" key="workflow.set_relationAttribute" /></td>
					    <td>
						   &nbsp;
						</td>
					</tr>
					<%
					  int ii=0;
				      if(attribteRelateList!=null&&attribteRelateList.size()>0){
				    %>
					<%   Object [] attributeObj=null;
						  String fieldId_check="";					
					      for(ii=0;ii<attribteRelateList.size();ii++){
						    attributeObj=(Object [])attribteRelateList.get(ii);		 
						  %>
					<tr id="tbl_tr<%=ii%>">
						<td>
						    <select name="relateField" onChange="attributeSelectOnchange(this)" class="selectlist" >
							    <option  value="-1" fieldId="-1">--请选择--</option>
								<%
								 for(int i = 0; i < fieldList.size(); i ++){
									 simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
										 //if("103".equals(simpleFieldVO.getPoField())||"105".equals(simpleFieldVO.getPoField())
								     if("105".equals(simpleFieldVO.getPoField())){
							    %>
								<option value="<%=simpleFieldVO.getRealName()%>" fieldId="<%=simpleFieldVO.getId()%>"
									<%if(simpleFieldVO.getRealName().equals(attributeObj[0].toString())){out.print("selected");fieldId_check=""+simpleFieldVO.getId();}%>><%=simpleFieldVO.getDisplayName()%>
								</option>
								<%
										
									 }
								 }
								%>
						     </select>
						</td>
						<td>
							<%
								  com.whir.ezoffice.customForm.ui.UIBD uibd=new  com.whir.ezoffice.customForm.ui.UIBD();
						    %> 
						     <select name="relateValue"  class="selectlist">
							<%													 
								 List uibdlist=uibd.getDataWithFieldId(fieldId_check);
								 if(uibdlist!=null&&uibdlist.size()>0){
								     Object  [] ooobje=null;
									 for(int iii=0;iii<uibdlist.size();iii++){
										 ooobje=(Object [])uibdlist.get(iii);
							%>
								<option value="<%=ooobje[0]%>" <%if((attributeObj[1]+"").equals(ooobje[0].toString())){out.print("selected");}%>><%=ooobje[1]%></option>
							<%
							          }
								 }
						   %>
						     </select>
						</td>
						<td>
						   <select name="beRelateField" class="selectlist">
						  <%
							 for(int i = 0; i < fieldList.size(); i ++){
								 simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
								 if("101".equals(simpleFieldVO.getPoField())||"110".equals(simpleFieldVO.getPoField())){
						  %>
								<option value="<%=simpleFieldVO.getRealName()%>" <%if(simpleFieldVO.getRealName().equals(attributeObj[2].toString())){out.print("selected");}%>><%=simpleFieldVO.getDisplayName()%>
								</option>
						  <%										
								  }
							 }
						  %>
						   </select>
						</td>
						<td>
						    <select name="beRelateStatus" class="selectlist" >
								<option value="0" <%if(attributeObj[3].toString().equals("0")){out.print("selected");}%>><bean:message 	bundle="workflow" key="workflow.set_must" /></option>
								<option value="1" <%if(attributeObj[3].toString().equals("1")){out.print("selected");}%>><bean:message 	bundle="workflow" key="workflow.set_edit" /></option>
						    </select>
						</td>
						<td>
						    <img style="cursor:hand" src="<%=rootPath%>/images/addarrow.gif" title='<bean:message 	bundle="workflow" key="workflow.set_addattributerelation" />' onclick="addRow(this);" border="0" height="16" width="16">
			                <img style="cursor:hand" src="<%=rootPath%>/images/delarrow.gif" title='<bean:message 	bundle="workflow" key="workflow.set_deleteattributerelation" />' onclick="deleteRow(this);" border="0" height="15" width="15">
						</td>
					</tr>
					<%
					 }
				    }else{
				    %>
					<tr id="tbl_tr<%=ii%>">
						<td>
						   <select name="relateField" onChange="attributeSelectOnchange(this)" class="selectlist">
						    <option value="-1" fieldId="-1">--请选择--</option>
				    <%
						    for(int i = 0; i < fieldList.size(); i ++){
							   simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
							   //if("103".equals(simpleFieldVO.getPoField())||"105".equals(simpleFieldVO.getPoField())
							   if("105".equals(simpleFieldVO.getPoField())){
				    %>
						          <option value="<%=simpleFieldVO.getRealName()%>" fieldId="<%=simpleFieldVO.getId()%>"><%=simpleFieldVO.getDisplayName()%></option>
					<% 				
							  }
					       }
				    %>
						  </select></td>
						<td></td>
						<td><select name="beRelateField">
				   <%
						  for(int i = 0; i < fieldList.size(); i ++){
							   simpleFieldVO = (SimpleFieldVO) fieldList.get(i);
							   //if(!"401".equals(simpleFieldVO.getPoField())){
							   if("101".equals(simpleFieldVO.getPoField())||"110".equals(simpleFieldVO.getPoField())){
				   %>
								  <option value="<%=simpleFieldVO.getRealName()%>"><%=simpleFieldVO.getDisplayName()%></option>
				   <%										
							   }
						  }
				   %>
						  </select></td>
						<td><select name="beRelateStatus" class="selectlist">
								<option value="0"><bean:message 	bundle="workflow" key="workflow.set_must" /></option>
								<option value="1"><bean:message 	bundle="workflow" key="workflow.set_edit" /></option>
						   </select></td>
					   <td><img style="cursor:hand" src="<%=rootPath%>/images/addarrow.gif" title='<bean:message 	bundle="workflow" key="workflow.set_addattributerelation" />' onclick="addRow(this);" border="0" height="16" width="16"><img style="cursor:hand" src="<%=rootPath%>/images/delarrow.gif" title='<bean:message 	bundle="workflow" key="workflow.set_deleteattributerelation" />' onclick="deleteRow(this);" border="0" height="15" width="15"></td>
					</tr>
				  <%
				    }
				  %>
				</TBODY>
			</table>
		</td>
	</tr>

	<%}%>
	<input type="hidden" name="hasindex" id="hasindex" value='<s:property  value="#request.hasindex" />' />
    

	 <tr>
		<td  colspan=4>
			<div id="realtefielddiv"></div>
		</td>
	 </tr>
			  
	<%
	  if(chanNoWrite&&moduleId.equals("1")){
	%>  
	    <!--启动字段联动设置-->
		<tr id="fieldCheckTr" >
			<td  class="td_lefttitle"><bean:message 	bundle="workflow" key="workflow.set_relationTrig" />：</td>
			<td colspan="3" > <s:checkbox  name="fieldRelate"  id="fieldRelate" onclick="fieldRelateCheck(this);" ></s:checkbox></td>
		</tr>
		<tr>
		    <td  class="td_lefttitle">&nbsp;</td>
		    <td   colspan="3" align="left" id="field_td7"  name="field_td7"></td>
		</tr>
	<%
	   }
    %>

	 <tr>
		   <td class="td_lefttitle" >&nbsp;</td>
		   <td colspan="3">
			<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
			<s:if test="wfWorkFlowProcessId==null">
			<input type="button" class="btnButton4font" onClick="save(1,this);"  id="saveContinueButton" value='<s:text name="comm.savecontinue"/>' />  
			</s:if>
			<input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
			<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
		   </td>
	 </tr>
</table>