<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.whir.ezoffice.workflow.po.WFPressPO"%>
<%@ page import="com.whir.ezoffice.workflow.po.WFReadWriteControlPO"%>
<%@ page import="com.whir.ezoffice.workflow.po.WFProtectControlPO"%>
<%@ page import="com.whir.ezoffice.workflow.po.WFHideControlPO"%>
<%@ page import="com.whir.ezoffice.workflow.vo.SimpleFieldVO"%>
<%@ page import="java.util.*"%>
<%@page import="com.whir.i18n.Resource"%> 
<%   
     //子过程的显示
     String  subProcDivDisplay="";
	 String    activityClass=request.getAttribute("po.activityClass")+"";
	 //只有子过程类型才显示
	 if(!activityClass.equals("0")){
		 subProcDivDisplay="style=\"display:none\"";
	 }


	 String moduleId=""+request.getAttribute("moduleId");

	 // 办理方式   办理期限  是否需要阅件  
	 String activityDivDisplay="";
	 if(activityClass.equals("0")||activityClass.equals("2")||activityClass.equals("4")||activityClass.equals("5")){
		 activityDivDisplay="style=\"display:none\"";
	 }
 
     
	 //聚合数 
	 String joinApproveNumSpanDisplay="";
	 if(!activityClass.equals("5")){
		 joinApproveNumSpanDisplay="style=\"display:none\"";
	 }

	 //参与者 ，  写控制    隐藏字段设置  高级设置
	 String tr1Display="";
	 //批示意见对应字段 
	 String  tmdDisplay="";
	 String  tmdtrDisplay="";

	 String tmdtrDisplay2="style=\"display:none\"";
	 
	 if(activityClass.equals("2")||activityClass.equals("4")||activityClass.equals("5")){
		 tr1Display="style=\"display:none\"";
		 tmdDisplay="style=\"display:none\"";
		 tmdtrDisplay="style=\"display:none\"";
	 }else{
	     if(moduleId.equals("1")||moduleId.equals("2")||moduleId.equals("3")||moduleId.equals("34")){
		    tmdtrDisplay2="";
		 }
	 }

	 // 催办提醒
	 String  pressDealTRDisplay="";

	 String  po_pressType=request.getAttribute("po.pressType")+"";
	 if(po_pressType.equals("1")||po_pressType.equals("2")){
	 }else{
		 pressDealTRDisplay="style=\"display:none\"";
	 }


	 String bltsDisplay="";
	 String txsjDisplay="";

	 if(po_pressType.equals("1")){
		 bltsDisplay="";
		 txsjDisplay="";
	 }else{
		 bltsDisplay="style=\"display:none\"";
		 txsjDisplay="style=\"display:none\"";
	 }


	
	 String sFormDisplay="";
	 if(moduleId.equals("1")&&!(activityClass.equals("2")||activityClass.equals("4")||activityClass.equals("5"))){
	     sFormDisplay="";
	 }else{
	     sFormDisplay="style=\"display:none\"";
	 }

	 String  po_needPassRound=""+request.getAttribute("po.needPassRound");  
     String needPassRound_trDisplay="";
	 String needPassRoundTRDisplay="";
	 if(activityClass.equals("2")||activityClass.equals("4")||activityClass.equals("5")||po_needPassRound.equals("0")){
		  needPassRound_trDisplay="style=\"display:none\"";
		  needPassRoundTRDisplay="style=\"display:none\"";
	 }

	 //参与者
	 String  po_participantType=""+request.getAttribute("po.participantType");     
     String  participantRoleDisplay="";
	 String  xdqzDisplay="";
	 String  hxrDisplay="";
	 String  zdzzDisplay="";
	 String  bdzdDisplay="";
	 String  qbblrDisplay="";
	 String  participantinterfacetrDisplay="";
	 if(!po_participantType.equals("6")){
		 participantRoleDisplay="style=\"display:none\"";
	 }
	 //xdqz
	 if(!po_participantType.equals("13")){
		 xdqzDisplay="style=\"display:none\"";
	 }
	 //hrx
	 if(!po_participantType.equals("2")){
		 hxrDisplay="style=\"display:none\"";
	 }
	 //zdzz
	 if(!po_participantType.equals("8")){
		 zdzzDisplay="style=\"display:none\"";
	 }

	 //bdzd
	 if(!po_participantType.equals("4")){
		 bdzdDisplay="style=\"display:none\"";
	 }

	 //qbblr
	 if(!po_participantType.equals("3")){
		 qbblrDisplay="style=\"display:none\"";
	 }

	 //participantinterfacetr
	 if(!po_participantType.equals("16")){
		 participantinterfacetrDisplay="style=\"display:none\"";
	 }

	 //阅件参与者
	 String  po_passRoundUserType=""+request.getAttribute("po.passRoundUserType"); 
	 String  passRoundRoleDisplay="";
	 String  passRoundxdqzDisplay="";
	 String  passhxrDisplay="";
	 String  passRoundzdzzDisplay="";
	 String  passbdzdDisplay="";
	 String  passqbblrDisplay="";
	 String  passRoundUserinterfacetrDisplay="";
	 //passRoundRole
	 if(!po_passRoundUserType.equals("6")){
		 passRoundRoleDisplay="style=\"display:none\"";
	 }
	 //passRoundxdqz
	 if(!po_passRoundUserType.equals("13")){
		 passRoundxdqzDisplay="style=\"display:none\"";
	 }
	 //passhxr
	 if(!po_passRoundUserType.equals("2")){
		 passhxrDisplay="style=\"display:none\"";
	 }
	 //passRoundzdzz
	 if(!po_passRoundUserType.equals("8")){
		 passRoundzdzzDisplay="style=\"display:none\"";
	 }
	 //passbdzd
	 if(!po_passRoundUserType.equals("4")){
		 passbdzdDisplay="style=\"display:none\"";
	 }
	 //#passqbblr
	 if(!po_passRoundUserType.equals("3")){
		 passqbblrDisplay="style=\"display:none\"";
	 }
	 if(!po_passRoundUserType.equals("16")){
		 passRoundUserinterfacetrDisplay="style=\"display:none\"";
	 }
 

	 //表单类型
	 String  formCtrl=""+request.getAttribute("formCtrl");
	 String  form_spanDisplay="";
	 if(!formCtrl.equals("0")){
		 form_spanDisplay="style=\"display:none\"";
	 }
    

	String signatureInUse=request.getAttribute("signatureInUse")+"";
    String tr15Display="";
	if(signatureInUse.equals("0")){
		tr15Display="style=\"display:none\"";
	}

	String comm_upload = Resource.getValue(local,"common","comm.upload");
 
%>
 
<s:hidden name="processId"                 id="processId" />
<s:hidden name="tableId"                   id="tableId" />
<s:hidden name="wfActivityId"              id="wfActivityId" />
<s:hidden name="moduleId"                  id="moduleId" />
<s:hidden name="moduleVO.formClassName"    id="moduleVO_formClassName"/>
<s:hidden name="moduleVO.newFormMethod"    id="moduleVO_newFormMethod"/>
<s:hidden name="moduleVO.completeMethod"   id="moduleVO_completeMethod"/>
<s:hidden name="processPO.processSort"     id="processSort" />
<s:hidden name="signatureInUse"            id="signatureInUse" />
<s:hidden name="smsInUse"                  id="smsInUse" />
<s:hidden name="formId"                    id="formId" />
<div class="BodyMargin_10">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="inlineBottomLine">
    <tr>
        <td colspan="2">
            <div class="Public_tag">
                <ul>
                    <li class="tag_aon" id="Panle0" onClick="changePanle(0);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newactivitybasicinfo"/></span><span class="tag_right"></span>
                    </li>
                    <li id="Panle1" onClick="changePanle(1);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newactivityoperbutton"/></span><span class="tag_right"></span>
                    </li> 
					<li id="Panle2" onClick="changePanle(2);"><span class="tag_center"><bean:message bundle="workflow" key="workflow.newactivityinterface"/></span><span class="tag_right"></span>
                    </li> 
                </ul>
            </div>
        </td>
    </tr>
</table>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="TableLine">
    <tr>
	    <td valign="top">
            <div id="docinfo0" style="display:;"  multiTag='yes' >
                <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0">
				  <!--活动名称--->
				   <tr>  
		               <td for='<bean:message bundle="workflow" key="workflow.newactivityname"/>'   class="td_lefttitle" width="100" nowrap="nowrap" ><bean:message bundle="workflow" key="workflow.newactivityname"/><span class="MustFillColor">*</span>：</td>  
		               <td colspan=3 >  
						<s:textfield name="po.activityName" id="activityName" cssClass="inputText"  whir-options="vtype:['notempty',{'maxLength':100},'spechar3']" cssStyle="width:90%;" />  
		               </td>  
	              </tr> 
				  <!--子流程相关信息-->
				  <s:if test="moduleVO.chanActiClass==true">	
				  <%//1:'标准活动',0:'子过程活动',2:'虚拟活动',3:'自动返回活动',4:'分叉活动',5:'聚合活动'%>   
				  <tr>
				     <td class="td_lefttitle" for='<bean:message bundle="workflow" key="workflow.joinnum"/>'><bean:message bundle="workflow" key="workflow.newactivitytype"/>：</td>
					 <td colspan=3><s:radio name="po.activityClass"  id="activityClass" list="%{#{1:getText('workflow.newactivitystandard'),0:getText('workflow.newactivityson'),2:getText('workflow.newactivityvirtual'),3:getText('workflow.newactivityautoback'),4:getText('workflow.forkActivity'),5:getText('workflow.joinActivity')}}" theme="simple"  onClick="changeActiClass();" ></s:radio> <span  id="joinApproveNumSpan" <%=joinApproveNumSpanDisplay%> ><s:text name="workflow.joinnum"/>： <s:textfield name="po.joinApproveNum" id="joinApproveNum" cssClass="inputText" whir-options="vtype:['p_integer',{'maxLength':2},{'range':'1-67'}]" cssStyle="width:14%;" /></span>
					 </td>
			     </tr>

				 <tr id="subProcDiv0"   <%=subProcDivDisplay%> >
                     <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivitysonworkflow"/><span class="MustFillColor">*</span>：</td>
                     <td>
                         <s:textfield name="po.activitySubProcName" id="activitySubProcName" readonly="true" cssClass="inputText"  cssStyle="width:90%;" /><a href="#" class="selectIco" onclick="selectSubProc('activitySubProc','activitySubProcName');"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a> 
						 <s:hidden  name="po.activitySubProc"  id="activitySubProc" />  
                     </td>
					  <!-- 继承主流程相同数据表数据 -->
					 <td colspan="2">&nbsp;<s:checkbox  name="extendMainTable"  id="extendMainTable" ></s:checkbox>&nbsp;<bean:message bundle="workflow" key="workflow.Succeedthesamedatatableofmainworkflow"/> 
				     </td>			 
                 </tr>

				  <tr id="subProcDiv1"  <%=subProcDivDisplay%> >
                      <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivitysontype"/>：</td>
                      <td colspan=3>
					      <!-- 1    1:串行子过程',0:'并行子过程 ' -->
					      <s:radio name="po.subProcType"  id="subProcType" list="%{#{1:getText('workflow.activityseries'),0:getText('workflow.activityparallel')}}" theme="simple"  onClick="changeActiClass(this);" ></s:radio>
                      </td>
                  </tr>
    			 </s:if>
				   <s:else>
                     <s:hidden  name="po.activityClass"  id="activityClass"/>
                   </s:else>
				  <s:if test="moduleVO.chanActiType==true">
				     <!--<bean:message bundle="workflow" key="workflow.newactivityuseroriented"/>   <bean:message bundle="workflow" key="workflow.newactivityworkfloworiented"/>  '1':'由当前用户决定活动走向','0':'由流程决定活动走向 '--->
				     <tr id="tr10" <%=tr1Display%> >
						  <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityoriented"/>：</td>
						  <td colspan=3>
						    <s:radio name="po.activityType"  id="activityType" list="%{#{'1':getText('workflow.newactivityuseroriented'),'0':getText('workflow.newactivityworkfloworiented')}}" theme="simple"></s:radio>
						  </td>
                    </tr>
				 </s:if>
				  <s:else>
                     <s:hidden  name="po.activityType"  id="activityType"/>
                  </s:else>


                 <!--办理方式-->
				 <s:if test="moduleVO.chanTranType==true">
				     <tr id="activityDiv0" <%=activityDivDisplay%> >
						  <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityprocesstype"/>：</td>
						  <!--'2':'单个','0':'单个多人','3':'多人串行','1':'多人并行'-->
						  <td  colspan=3>
						        <s:checkbox  name="transactType_2"  id="transactType_2" ></s:checkbox><bean:message bundle="workflow" key="workflow.newactivitysingletype"/>
								<s:checkbox  name="transactType_0"  id="transactType_0" ></s:checkbox><bean:message bundle="workflow" key="workflow.newactivitysinglemul"/>
								<s:checkbox  name="transactType_3"  id="transactType_3" ></s:checkbox><bean:message bundle="workflow" key="workflow.newactivitymul"/>
								<s:checkbox  name="transactType_1"  id="transactType_1" ></s:checkbox><bean:message bundle="workflow" key="workflow.newactivitymulcollateral"/>
                          </td>
                    </tr>
				 </s:if>
				 <s:else>
                    <s:hidden  name="po.transactType"  id="transactType"/>
                 </s:else>

                 <%//'1':'默认','0':'自定义' %>
				 <tr id="sForm" <%=sFormDisplay%>>
                     <td class="td_lefttitle" ><bean:message bundle="workflow" key="workflow.newactivityformuse"/>：</td><!--- 使用表单 --->
                     <td colspan=3>
					      <s:radio name="formCtrl"  id="formCtrl" list="%{#{'1':getText('workflow.newactivitydefault'),'0':getText('workflow.newactivityselfdefine')}}" theme="simple"  onClick="changeformCtrl();" ></s:radio>
						  <span id="form_span" <%=form_spanDisplay%> >
                          <s:select cssClass="selectlist"  name="form" id="form" list="#request.formList" listKey="id"  listValue="pageName" headerKey="" headerValue="--%{getText('workflow.Pleaseselect')}--"  cssStyle="width:200px;height:29px;"     /></span> 
                     </td>
	             </tr>
				 <tr>
                     <td class="td_lefttitle"  for='<bean:message bundle="workflow" key="workflow.newactivitydescription"/>' ><bean:message bundle="workflow" key="workflow.newactivitydescription"/>：</td>
                     <td  colspan=3>
                          <s:textarea name="po.activityDescription"  id="activityDescription" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;"   whir-options="vtype:[{'maxLength':100}]"  ></s:textarea>
					 </td>
                 </tr>
				 <tr id="activityDiv1"  height="1" <%=activityDivDisplay%>>
                     <td colspan="4">
					     <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr height="1" bgcolor="#808080">
                                 <td height="1"  style="padding:0px 0 0px 0;"></td>
                             </tr>
                             <tr height="1"  bgcolor="#FFFFFF">
                                  <td height="1"  style="padding:0px 0 0px 0;"></td>
                             </tr>
                          </table>
				     </td>
                 </tr>
				 <!---<bean:message bundle="workflow" key="workflow.newactivityperiodnone"/>   <bean:message bundle="workflow" key="workflow.newactivityperiodfix"/>   0:'无',1:'固定'  --->
                 <tr id="activityDiv2"  <%=activityDivDisplay%>>
                       <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityperiod"/>：</td>
                       <td colspan=3>
					        <s:radio name="po.pressType"  id="pressType" list="%{#{0:getText('workflow.newactivityperiodnone'),1:getText('workflow.newactivityperiodfix')}}" theme="simple"  onClick="clickPressType();" ></s:radio>
                           <span id="blts"  <%=bltsDisplay%> >
                            <s:select cssClass="selectlist"  name="pressLimit" id="pressLimit" list="#request.pressLimitList" listKey="id"  listValue="id"   cssStyle="width:80px;height:29px;" /> 

							<s:select cssClass="selectlist"  name="po.pressMotionTimeType" id="pressMotionTimeType" list="#request.pressMotionTimeTypeList" listKey="id"  listValue="key" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:80px;height:29px;" />
							</span>
                            <span id="txsj"  <%=txsjDisplay%>>
							 <bean:message bundle="workflow" key="workflow.newactivityperiodfixdetail"/>
							 <s:checkbox  name="motion"  id="motion" ></s:checkbox>
                             <s:select cssClass="selectlist"  name="po.pressMotionTime" id="pressMotionTime" list="#request.pressMotionTimeList" listKey="id"  listValue="text" headerKey="0" headerValue="%{getText('file.total')}"  cssStyle="width:80px;height:29px;" /> 
                            </span>
                               <!--  <input type="radio" value="2" name="pressType" <%//if(pressType.equals("2")) out.print("checked");%> onclick="clickPressType(this);" style="display:'none'"><!-- 定义办理期限 -->
                         </td>
                  </tr>
				  <!--  自定义办理期限  <tr id="dyblqx" style="display:none">--->
 
				  <tr id="pressDealTR"  <%=pressDealTRDisplay%> >
				      <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.activityduedeal"/>：</td>
                      <td colspan="3">
					     <!--  <s:checkbox  name="pressDealType_sys"  id="pressDealType_sys" ></s:checkbox><bean:message bundle="workflow" key="workflow.activitydueremind"/> -->
						  <s:if test="hasRtxOnline==true">
						       <s:checkbox  name="pressDealType_RTX"  id="pressDealType_RTX" ></s:checkbox> <bean:message bundle="mail" key="mail.imRemind"/><!--即时通讯提醒-->
				          </s:if> 
						  <s:if test="purviewMessage==true">
						       <s:checkbox  name="pressDealType_note"  id="pressDealType_note" ></s:checkbox> <bean:message bundle="mail" key="mail.messageremind" /> 
				          </s:if> 
						   <s:checkbox  name="pressDealType_press"  id="pressDealType_press" ></s:checkbox><bean:message bundle="workflow" key="workflow.activityduepress"/>
                           <s:checkbox  name="pressDealType_autojump"  id="pressDealType_autojump" ></s:checkbox><s:text name="workflow.Autojump"/>
	                   </td>
                   </tr>

				   <tr id="activityDiv3" <%=activityDivDisplay%> height="1">
                        <td colspan="4">
						    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr height="1" bgcolor="#808080">
                                  <td height="1" style="padding:0px 0 0px 0;"></td>
                               </tr>
                               <tr height="1"  bgcolor="#FFFFFF">
                                    <td height="1"  style="padding:0px 0 0px 0;" ></td>
                               </tr>
                             </table>
						</td>
                   </tr>

			        <!--participantUserName -->
				   
				   <tr id="tr11"  <%=tr1Display%> >
                       <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityparticipant"/>：</td>
                       <td colspan=3>
					       <table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-left:-4px;">
							 <tr>
                                <td width="44%">
                                  <B><bean:message bundle="workflow" key="workflow.newactivityroleselect"/></B>
                                </td>
                                <td width="56%" height="22">&nbsp;</td>
                             </tr>
                             <!--从系统角色中指定--->
						     <tr>
                                <td>
								  <s:radio name="po.participantType"  id="participantType" list="%{#{'6':getText('workflow.newactivityroleselect1')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio> 
                                </td>
                                <td >&nbsp;</td>
                             </tr>
                             <tr id="participantRole"  <%=participantRoleDisplay%>>
                                 <td colspan="2" >
									<table width="100%" border="0">
									  <tr>
									     <td width="60" nowrap><bean:message bundle="workflow" key="workflow.newactivityroleselect"/></td>
                                         <td width="50%">
										    <s:select   name="partRole" id="partRole" list="#request.roleList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"     cssStyle="width:200px;height:29px;" /> 
                                         </td> 
                                         <td>
										    <s:select cssClass="selectlist"  name="partRoleNexus" id="partRoleNexus" list="#request.roleNexusList" listKey="key"  listValue="value"   cssStyle="width:200px;height:29px;" />   
										 </td>
									  </tr>

									  <tr> 
									    <td><bean:message bundle="workflow" key="workflow.Organization"/><!--组织--> </td>
                                        <td>
										    <s:select    name="partRoleOrg" id="partRoleOrg" list="#request.orgList" listKey="key"  listValue="value"  cssStyle="width:200px;height:29px;"  />								 
										</td>
										<td id="partRoleOrgLevelID" name="partRoleOrgLevelID"  <s:if test="partRoleOrg==-3||partRoleOrg==-6"></s:if><s:else>style="display:none"</s:else>  ><!-- 从 --><bean:message bundle="workflow" key="workflow.from"/><!-- <bean:message bundle="workflow" key="workflow.OrganizationalLevel"/> --><!--组织级别-->
										    <s:select cssClass="selectlist"  name="partRoleOrgLevel" id="partRoleOrgLevel" list="#request.partRoleOrgLevelList" listKey="key"  listValue="value"  cssStyle="width:90px;height:29px;" /><!-- 级组织向下寻找 --><bean:message bundle="workflow" key="workflow.Lookingfordownlevelorganization"/> 		  
									     </td>
									   </tr>
									  </table>
                                    </td>
                                  </tr>
                                 
								  <!--  流程启动人-->
								  <tr>
                                    <td>
									  <s:radio name="po.participantType"  id="participantType" list="%{#{'5':getText('workflow.newactivityroleselect2')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>  
                                    </td>
                                    <td colspan=3>&nbsp;</td>
                                  </tr>

                                  <!--  流程启动人的上级领导-->
                                  <tr>
                                    <td width="44%">
									     <s:radio name="po.participantType"  id="participantType" list="%{#{0:getText('workflow.activitysubmitpersonupleader')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td width="56%" height="22">&nbsp;</td>
                                  </tr>


                                  <!-- 流程启动人的部门领导-->
								  <tr>
                                     <td width="44%">
									      <s:radio name="po.participantType"  id="participantType" list="%{#{18:getText('workflow.StartOneDepartmentHeads')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                      </td>
                                     <td width="56%" height="22">&nbsp;</td>
                                  </tr>

                                 <!-- 流程启动人的分管领导-->
								 <tr>
                                    <td width="44%">
									    <s:radio name="po.participantType"  id="participantType" list="%{#{19:getText('workflow.StartOneLeadersInCharge')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td width="56%" height="22">&nbsp;</td>
                                  </tr>

                                  <!--  上一活动办理人的上级领导-->
								  <tr>
                                    <td >
									    <s:radio name="po.participantType"  id="participantType" list="%{#{7:getText('workflow.newactivityroleselect3')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>                                   
								  <!-- 上一活动办理人的组织及下级组织-->
								  <tr>
                                    <td nowrap >
								     	 <s:radio name="po.participantType"  id="participantType" list="%{#{17:getText('workflow.OrganizationAndLowerLevelOrganizationOfPreviousActivity')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                         &nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.from"/> <!-- <bean:message bundle="workflow" key="workflow.OrganizationalLevel"/> --><!--组织级别-->
										 <s:select cssClass="selectlist"  name="lastParticipantOrgLevel" id="lastParticipantOrgLevel" list="#request.partRoleOrgLevelList" listKey="key"  listValue="value" cssStyle="width:90px;height:29px;" /><!-- 级组织向下寻找 --><bean:message bundle="workflow" key="workflow.Lookingfordownlevelorganization"/>  
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr> 


                                 <!--  上一活动所有参与者-->
                                  <tr>
                                    <td >
									<s:radio name="po.participantType"  id="participantType" list="%{#{11:getText('workflow.newactivityroleselect12')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>


								 <!--活动参与者本人-->
								 <tr>
                                    <td>
									   <s:radio name="po.participantType"  id="participantType" list="%{#{20:getText('workflow.activityself')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
									    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<s:select cssClass="selectlist"  name="dealedActivityId" id="dealedActivityId" list="#request.activityList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}" cssStyle="width:200px;height:29px;" /> 
                                    </td>
                                     <td>&nbsp;                                    
									</td>
                                 </tr>

								 <!--活动参与者上级领导-->
								 <tr>
                                    <td>
									  <s:radio name="po.participantType"  id="participantType" list="%{#{21:getText('workflow.activityLeader')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp;
									  <s:select cssClass="selectlist"  name="dealedActivityId_leader" id="dealedActivityId_leader" list="#request.activityList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;" />  
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>
                                
								 <!-- 选中组织的分管领导-->
								 <tr>
                                    <td>
								    	<s:radio name="po.participantType"  id="participantType" list="%{#{15:getText('workflow.LeadersInCharge')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp; 
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>
                                 
								 <!-- 选中组织的部门领导-->
								 <tr>
                                    <td>
									    <s:radio name="po.participantType"  id="participantType" list="%{#{10:getText('workflow.DepartmentHeads')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp; 
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>

                                  <!--<bean:message bundle="workflow" key="workflow.activitysubmitpersonuporg"/> 流程启动人上级组织 AND 职务级别-->
								  <tr>
                                    <td colspan="2">
									    <s:radio name="po.participantType"  id="participantType" list="%{#{14:getText('workflow.activitysubmitpersonuporg')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp;

										<s:select cssClass="selectlist"  name="dutyLevelOperate" id="dutyLevelOperate" list="#request.dutyLevelOperateList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;" /> 

									    <s:select cssClass="selectlist"  name="dutyLevel" id="dutyLevel" list="#request.dutyList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;" />  
 
                                    </td>
                                  </tr>


								  <tr>
                                    <td width="44%">
                                        <B><bean:message bundle="workflow" key="workflow.newactivityorggroup"/></B>
                                    </td>
                                    <td width="56%" height="22">&nbsp;</td>
                                  </tr>

                                  
                                  <!-- 从所有用户中选择-->
								  <tr>
                                    <td>
									    <s:radio name="po.participantType"  id="participantType" list="%{#{1:getText('workflow.newactivityroleselect4')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp; 
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>

                                  <!--<bean:message bundle="workflow" key="workflow.activityallorg"/>-->
								  <tr style="display:none">
                                    <td>
									    <s:radio name="po.participantType"  id="participantType" list="%{#{12:'从所有用户中选择'}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp;                       
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>

                                  <!--<bean:message bundle="workflow" key="workflow.activityallgroup"/>  从选定的群组中选择-->
								  <tr style="display:">
                                    <td>
									    <s:radio name="po.participantType"  id="participantType" list="%{#{13:getText('workflow.activityallgroup')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp; 
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>


								  <!-- 群组 -->
								  <tr id="xdqz" <%=xdqzDisplay%>>
                                    <td colspan="2">
									   <table border="0" width="100%">
									    <tr>
										  <td colspan="3">
											<s:textarea name="participantGivenGroupName"  id="participantGivenGroupName" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true"  ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'participantGivenGroup', allowName:'participantGivenGroupName', select:'group', single:'no', show:'group', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
											<s:hidden  name="participantGivenGroup"  id="participantGivenGroup" />
											<label class="MustFillColor">*</label>
										  </td>
										</tr> 
										 <tr>
											 <td width="80" nowrap>
											     <s:select cssClass="selectlist"  name="partGroupNexus" id="partGroupNexus" list="#request.partGroupNexusList" listKey="key"  listValue="value"   cssStyle="width:50px;height:29px;" /><bean:message bundle="workflow" key="workflow.Organization"/>
											 </td>
											 <td width="300"><s:select   name="partgGroupOrg" id="partgGroupOrg" list="#request.orgList" listKey="key"  listValue="value"   cssStyle="width:100px;height:29px;"  />
                                              </td>
											  <td width="40%" nowrap >
										          <span id="partgGroupOrgLevelID" name="partgGroupOrgLevelID"  <s:if test="partgGroupOrg==-3||partgGroupOrg==-6"></s:if><s:else>style="display:none"</s:else> > <bean:message bundle="workflow" key="workflow.from"/> <!-- <bean:message bundle="workflow" key="workflow.OrganizationalLevel"/> --><!--组织级别-->
                                                   <s:select cssClass="selectlist"  name="partgGroupOrgLevel" id="partgGroupOrgLevel" list="#request.partRoleOrgLevelList" listKey="key"  listValue="value"  cssStyle="width:80px;height:29px;"   /><!-- 级组织向下寻找 --><bean:message bundle="workflow" key="workflow.Lookingfordownlevelorganization"/> 
												   </span>
                                              </td>
										   </tr>
										</table>
                                    </td>
                                  </tr>

                                 <!--<bean:message bundle="workflow" key="workflow.newactivityroleselect10"/> 从本级组织及其下级组织中选择-->
								 <tr>
                                    <td>
									 <s:radio name="po.participantType"  id="participantType" list="%{#{9:getText('workflow.newactivityroleselect10')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>&nbsp;
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>

                                 
								 <!--<bean:message bundle="workflow" key="workflow.newactivityroleselect6"/> 从候选人员中指定-->
                                  <tr>
                                    <td height="18">
									<s:radio name="po.participantType"  id="participantType" list="%{#{2:getText('workflow.newactivityroleselect6')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio> 
                                    </td>
                                    <td height="18">&nbsp;</td>
                                  </tr>


                                  <tr id="hxr"  <%=hxrDisplay%>>
                                    <td height="18" colspan="2">
									    <s:textarea name="candidate"  id="candidate" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'candidateId', allowName:'candidate', select:'user', single:'no', show:'usergroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										<s:hidden  name="candidateId" id="candidateId"/><label class="MustFillColor">*</label>
                                    </td>
                                  </tr>

                                 
								 <!--<bean:message bundle="workflow" key="workflow.newactivityroleselect7"/> 从选定的范围中选择-->
                                  <tr>
                                    <td >
									     <s:radio name="po.participantType"  id="participantType" list="%{#{8:getText('workflow.newactivityroleselect7')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>
                                  <tr id="zdzz" <%=zdzzDisplay%>>
                                    <td colspan="2">
									    <s:textarea name="participantGivenOrgName"  id="participantGivenOrgName" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'participantGivenOrg', allowName:'participantGivenOrgName', select:'orggroup', single:'no', show:'orggroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										<s:hidden  name="participantGivenOrg" id="participantGivenOrg"/>
										<label class="MustFillColor">*</label>
                                    </td>
                                  </tr>
								  <tr>
                                    <td width="44%">
                                        <B><bean:message bundle="workflow" key="workflow.newactivitydefaultselect"/></B>
                                    </td>
                                    <td width="56%" height="22">&nbsp;</td>
                                 </tr>
                                 
								 <!-- 由表单中的某个字段值决定-->
								  <tr style="display:">
                                    <td colspan="2">
									   <s:radio name="po.participantType"  id="participantType" list="%{#{'4':getText('workflow.newactivityroleselect9')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio> 
                                       <span id="bdzd" <%=bdzdDisplay%>>
                                          <s:select cssClass="selectlist"  name="po.participantUserField" id="participantUserField" list="#request.participantUserFieldList" listKey="id"  listValue="displayName" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;"   /> 
                                         <s:select cssClass="selectlist"  name="po.participantUserFieldType" id="participantUserFieldType" list="#request.leadTypeList" listKey="key"  listValue="vlaue" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:80px;height:29px;"   />
										</span>
									
                                    </td>
                                  </tr>
                                  
								  <!--指定全部办理人-->
								  <tr>
                                    <td>
									    <s:radio name="po.participantType"  id="participantType" list="%{#{'3':getText('workflow.newactivityroleselect8')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr id="qbblr"  <%=qbblrDisplay%>>
                                    <td colspan="2">
									    <s:textarea name="allUser"  id="allUser" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'allUserId', allowName:'allUser', select:'user', single:'no', show:'usergroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										<s:hidden  name="allUserId" id="allUserId"/>
										<label class="MustFillColor">*</label>
                                    </td>
                                  </tr>

								 <!--由接口决定--->
								 <tr>
                                    <td>
									     <s:radio name="po.participantType"  id="participantType" list="%{#{'16':getText('workflow.byTheInterface')}}" theme="simple"  onClick="clickParticipantType(this);" ></s:radio>
                                    </td>
                                    <td>&nbsp;</td>
                                 </tr>
								 <tr id="participantinterfacetr"  <%=participantinterfacetrDisplay%>>
                                    <td colspan="2">
									   <table border="0" width="100%">
									      <tr>
										       <td>
											       <bean:message bundle="workflow" key="workflow.className"/><!--接口类名-->：
											   </td>
											   <td>
											       <s:textfield name="po.participantClassName" id="participantClassName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" />
											   </td>
											   <td><bean:message bundle="workflow" key="workflow.methodName"/><!--方法名-->：</td>
											   <td>
											       <s:textfield name="po.participantMethodName" id="participantMethodName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" />
											   </td>
											   <td></td>
										  </tr>
										   <tr>
										       <td>
											       <bean:message bundle="workflow" key="workflow.parameterName"/><!--接口参数名-->：
											   </td>
											   <td>
											      <s:textfield name="po.participantInPaNames" id="participantInPaNames" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" />
											   </td>
											   <td><bean:message bundle="workflow" key="workflow.parameterValue"/><!--接口参数值-->：</td>
											   <td>
											       <s:textfield name="po.participantInPavalues" id="participantInPavalues" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" /> 
											   </td>
											   <td width="110px">
											      <%--<div style="margin-left:-1px;margin-top:10px">
													 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">      
													   <jsp:param name="onInit"               value="" /> 
													   <jsp:param name="onSelect"             value="" />  
													   <jsp:param name="onUploadProgress"     value="" /> 
													   <jsp:param name="onUploadSuccess"      value="participantClassName_set"  />
													   <jsp:param name="dir"                  value="/WEB-INF/classes/com/whir/ezoffice/form/" />
													   <jsp:param name="uniqueId"             value="workFlow_participantClassName"  />
													   <jsp:param name="realFileNameInputId"  value="formClassName1" /> 
													   <jsp:param name="saveFileNameInputId"  value="formClassName2" />
													   <jsp:param name="canModify"            value="yes" /> 		  
													   <jsp:param name="width"                value="70" /> 
													   <jsp:param name="height"               value="20" /> 
													   <jsp:param name="multi"                value="true" /> 
													   <jsp:param name="buttonClass"          value="upload_btn" /> 
													   <jsp:param name="buttonText"           value="" /> 
													   <jsp:param name="fileSizeLimit"        value="0" /> 
													   <jsp:param name="fileTypeExts"         value="*.class" /> 
													   <jsp:param name="uploadLimit"          value="0" /> 
													</jsp:include>
												  </div> --%>
											   </td>
										  </tr>
									   </table>
										 
									 
									</td>
                                  </tr>
                                </table></td>
                    </tr>
				   <tr  height="1">
					    <td colspan="4"> 
							 <table width="100%" border="0" cellpadding="0" cellspacing="0">
							  <tr height="1" bgcolor="#808080">
								<td height="1"  style="padding:0px 0 0px 0;"></td>
							  </tr>
							  <tr height="1"  bgcolor="#FFFFFF">
								<td height="1"  style="padding:0px 0 0px 0;"></td>
							  </tr>
							</table>
						 </td>
                     </tr>
					<s:hidden   name="po.actiCommType" id="actiCommType" />
					<s:if test="po.actiCommType==1">
					  <tr id="tmd0"  <%=tmdDisplay%>>
						<td><bean:message bundle="workflow" key="workflow.activitycomment"/>：</td>
						<s:if test="moduleId==2||moduleId==3||moduleId==34">
						   <td>
							<s:select cssClass="selectlist"  name="po.actiCommField" id="actiCommField" list="#request.staticCommentList" listKey="poField"  listValue="displayName" headerKey="-1" headerValue="%{getText('workflow.newactivitycomment3')}"  cssStyle="width:200px;height:29px;"   />     
						   </td>
						</s:if>
						<s:else>				 
						   <td>
							   <table  border="0" cellspacing="0" cellpadding="0" style="margin-left:-4px;" >                            
								<!-- '1':'批示意见对应字段','0':'自动增加批示意见','-1':'无批示意见'
                                 --->
								<tr>
								   <td nowrap="nowrap">
									<s:radio name="po.actiCommFieldType"  id="actiCommFieldType" list="%{#{'1':getText('workflow.newactivitycomment1'),'0':getText('workflow.newactivitycomment2'),'-1':getText('workflow.newactivitycomment3')}}" theme="simple"  onClick="actiCommFieldSel_ck();" ></s:radio>
								   </td>
								   <td nowrap="nowrap"> </td>
								   <td nowrap="nowrap"> </td>
								</tr>

								<tr id="actiCommField_tr">
									<td> 
									<s:radio  name="po.actiCommField" id="actiCommField"   list="#request.user_definedCommentList" listKey="realName"  listValue="displayName"   />
								   </td>
								</tr>
							</table>
						</td>
						</s:else>
						<td colspan=2>&nbsp;</td>
					</tr>
					</s:if>
					<s:else>
					   <s:hidden  name="po.actiCommField" id="actiCommField"/> 
					</s:else>

					<tr><td colspan="4">&nbsp;</td></tr>
					<tr height="1">
					   <td colspan="4"> <table width="100%" border="0" cellpadding="0" cellspacing="0">
						  <tr height="1" bgcolor="#808080">
							<td height="1"  style="padding:0px 0 0px 0;"></td>
						  </tr>
						  <tr height="1"  bgcolor="#FFFFFF">
							<td height="1"  style="padding:0px 0 0px 0;"></td>
						  </tr>
						</table></td>
					  </tr>
              
                            
					 <!--<bean:message bundle="workflow" key="workflow.newactivityneedno"/>  <bean:message bundle="workflow" key="workflow.newactivityneed"/> '0':'不需要','1':'需要'--->
					 <tr id="activityDiv4" <%=activityDivDisplay%>>
                         <td><bean:message bundle="workflow" key="workflow.newactivityneedreview"/>：</td>
                          <td colspan=3>
                             <s:radio name="po.needPassRound"  id="needPassRound" list="%{#{'0':getText('workflow.newactivityneedno'),'1':getText('workflow.newactivityneed')}}" theme="simple" onclick="needPassRount(this);"></s:radio>
                           </td>
                     </tr>

					 <tr id="needPassRound_tr"  <%=needPassRound_trDisplay%>>
                        <td class="td_lefttitle">&nbsp;</td>
                        <td colspan="3">
                               <table width="100%" border="0"  cellspacing="0" cellpadding="0" style="margin-left:-4px;" >
							           <tr>
                                            <td width="44%">
                                              <B><bean:message bundle="workflow" key="workflow.newactivityroleselect"/></B>
                                            </td>
                                            <td width="56%" height="22">&nbsp;</td>
                                       </tr>

									   <!--  从系统角色中指定-->
								       <tr>
                                            <td height="18">
											   <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{6:getText('workflow.newactivityroleselect1')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                            </td>
                                            <td height="18">&nbsp;</td>
                                       </tr>
                                        <tr id="passRoundRole" <%=passRoundRoleDisplay%>>
                                             <td height="18" colspan="2">
									            <table width="100%">
												   <tr>
												       <td width="66" nowrap><bean:message bundle="workflow" key="workflow.newactivityroleselect"/></td>
                                                       <td  width="50%">
												          <s:select   name="passRole" id="passRole" list="#request.roleList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;"    />  
												       </td>
                                                        <td>

												            <s:select cssClass="selectlist"  name="passRoleNexus" id="passRoleNexus" list="#request.roleNexusList" listKey="key"  listValue="value"   cssStyle="width:200px;height:29px;" />
													   </td>
												   </tr> 
												   <tr nowrap>
												       <td><bean:message bundle="workflow" key="workflow.Organization"/><!--组织--></td>
                                                       <td>
												        <s:select   name="passOrg" id="passOrg" list="#request.orgList" listKey="key"  listValue="value"   cssStyle="width:200px;height:29px;"    /> 
												       </td>
										               <td id="passOrgLevelId" name="passOrgLevelId"  <s:if test="passOrg==-3||passOrg==-6"></s:if><s:else>style="display:none"</s:else> > <bean:message bundle="workflow" key="workflow.from"/> <!-- <bean:message bundle="workflow" key="workflow.OrganizationalLevel"/> --><!--组织级别-->
													     <s:select cssClass="selectlist"  name="passOrgLevel" id="passOrgLevel" list="#request.partRoleOrgLevelList" listKey="key"  listValue="value"    cssStyle="width:90px;height:29px;"   /><!-- 级组织向下寻找 --><bean:message bundle="workflow" key="workflow.Lookingfordownlevelorganization"/>  
									                  </td>
									              </tr>
									            </table>
                                            </td>
                                       </tr>

									   <!-- 流程启动人-->
								       <tr>
                                           <td>
										     <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{5:getText('workflow.newactivityroleselect2')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                           </td>
                                           <td colspan=3>&nbsp;</td>
                                      </tr>

									  <!--  流程启动人的上级领导-->
                                      <tr>
                                          <td width="44%">
										     <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{0:getText('workflow.activitysubmitpersonupleader')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio> 
                                         </td>
                                          <td width="56%" height="22">&nbsp;</td>
                                     </tr>


                                    <!--  流程启动人 的部门领导-->
								     <tr>
                                         <td width="44%">
										      <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{18:getText('workflow.StartOneDepartmentHeads')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                          </td>
                                         <td width="56%" height="22">&nbsp;</td>
                                     </tr>
                                    
									<!--  流程启动人 的分管领导-->
								    <tr>
                                         <td width="44%">
										    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{19:getText('workflow.StartOneLeadersInCharge')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                         </td>
                                         <td width="56%" height="22">&nbsp;</td>
                                    </tr>
                           
                                  <!-- 上一活动办理人的上级领导 -->
								  <tr>
                                      <td>
									     <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{7:getText('workflow.newactivityroleselect3')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                     </td>
                                     <td >&nbsp;</td>
                                  </tr>

                                  <!--
								  <bean:message bundle="workflow" key="workflow.OrganizationAndLowerLevelOrganizationOfPreviousActivity"/>上一活动办理人的组织及下级组织-->
								  <tr>
                                    <td>
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{17:getText('workflow.OrganizationAndLowerLevelOrganizationOfPreviousActivity')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>&nbsp;&nbsp; <!-- <bean:message bundle="workflow" key="workflow.OrganizationalLevel"/> --><!--组织级别-->								   
                                    </td>
                                    <td ><bean:message bundle="workflow" key="workflow.from"/> <s:select cssClass="selectlist"  name="lastpassRoundUserOrgLevel" id="lastpassRoundUserOrgLevel" list="#request.partRoleOrgLevelList" listKey="key"  listValue="value"   cssStyle="width:90px;height:29px;" /><!-- 级组织向下寻找 --><bean:message bundle="workflow" key="workflow.Lookingfordownlevelorganization"/></td>
                                   </tr> 
                                  

								  <!--上一活动所有参与者-->
                                  <tr>
                                    <td >
									     <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{11:getText('workflow.newactivityroleselect12')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>

                                  <!--  分管领导-->
								  <tr>
                                    <td >
									     <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{15:getText('workflow.LeadersInCharge')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>

                                  <!-- 部门领导-->
								  <tr>
                                    <td >
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{10:getText('workflow.DepartmentHeads')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td >&nbsp;</td>
                                  </tr>

                                  <!--流程启动人上级组织 AND 职务级别 -->
								  <tr>
                                    <td colspan="2">
									      <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{14:getText('workflow.activitysubmitpersonuporg')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>&nbsp;

										  <s:select cssClass="selectlist"  name="passDutyLevelOperate" id="passDutyLevelOperate" list="#request.dutyLevelOperateList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;" /> 

									     <s:select cssClass="selectlist"  name="passDutyLevel" id="passDutyLevel" list="#request.dutyList" listKey="key"  listValue="value" headerKey="" headerValue="%{getText('file.total')}"  cssStyle="width:200px;height:29px;" />  
                                    </td>
                                  </tr>


								  <tr>
                                    <td width="44%">
                                        <B><bean:message bundle="workflow" key="workflow.newactivityorggroup"/></B>
                                    </td>
                                    <td width="56%" height="22">&nbsp;</td>
                                  </tr>

                                  <!--  从所有用户中选择-->
								  <tr>
                                    <td>
									   <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{1:getText('workflow.newactivityroleselect4')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>  
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>

                                  <!-- 从所有用户中选择-->
								  <tr style="display:none">
                                    <td>
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{12:'从所有用户中选择'}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>
                            
                                  <!--  从选定的群组中选择-->
								  <tr style="display:">
                                    <td>
									     <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{13:getText('workflow.activityallgroup')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>


								  <tr id="passRoundxdqz" <%=passRoundxdqzDisplay%>>
                                    <td colspan="2">
									     <s:textarea name="passRoundGivenGroupName"  id="passRoundGivenGroupName" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRoundGivenGroup', allowName:'passRoundGivenGroupName', select:'group', single:'no', show:'group', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <s:hidden  name="passRoundGivenGroup" id="passRoundGivenGroup"/>
										 <label class="MustFillColor">*</label>
                                    </td>
                                  </tr>

                                  <!--  从本级组织及其下级组织中选择-->
								  <tr>
                                    <td>
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{9:getText('workflow.newactivityroleselect10')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td height="22">&nbsp;</td>
                                  </tr>

                                  <!--<bean:message bundle="workflow" key="workflow.newactivityroleselect6"/> 从候选人员中指定-->
                                  <tr>
									<td height="18">
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{2:getText('workflow.newactivityroleselect6')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
									</td>
									<td height="18">&nbsp;</td>
								</tr>


								<tr id="passhxr"  <%=passhxrDisplay%>>
									<td height="18" colspan="2">
									     <s:textarea name="passRound_candidate"  id="passRound_candidate" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRound_candidateId', allowName:'passRound_candidate', select:'user', single:'no', show:'usergroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <s:hidden  name="passRound_candidateId" id="passRound_candidateId"/>
										 <label class="MustFillColor">*</label>
									</td>
								</tr>
                                 
								<!--  从选定的范围中选择-->
                                <tr>
                                    <td height="18">
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{8:getText('workflow.newactivityroleselect7')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio> 
                                    </td>
                                    <td height="18">&nbsp;</td>
                                </tr>


                                 <tr id="passRoundzdzz" <%=passRoundzdzzDisplay%>>
                                    <td colspan="2">
									     <s:textarea name="passRoundGivenOrgName"  id="passRoundGivenOrgName" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRoundGivenOrg', allowName:'passRoundGivenOrgName', select:'orggroup', single:'no', show:'orggroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <s:hidden  name="passRoundGivenOrg" id="passRoundGivenOrg"/>
										 <label class="MustFillColor">*</label>
                                    </td>
                                 </tr>

 							     <tr>
                                    <td width="44%">
                                        <B><bean:message bundle="workflow" key="workflow.newactivitydefaultselect"/></B>
                                    </td>
                                    <td width="56%" height="22">&nbsp;</td>
                                 </tr>

								 <!--  由表单中的某个字段值决定-->
								 <tr style="display:">
									<td colspan="2">
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{4:getText('workflow.newactivityroleselect9')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio> 
									     <span id="passbdzd" <%=passbdzdDisplay%>>
									     <s:select cssClass="selectlist"  name="po.passRoundUserField" id="passRoundUserField" list="#request.participantUserFieldList" listKey="id"  listValue="displayName" headerKey="" headerValue="%{getText('file.total')}"   cssStyle="width:200px;height:29px;" />
										 </span>
									</td>
								</tr>

                                 <!-- 指定全部办理人-->
								 <tr>
									<td>
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{3:getText('workflow.newactivityroleselect8')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
									</td>
									<td>&nbsp;</td>
								</tr>
								<tr id="passqbblr" <%=passqbblrDisplay%>>
									<td colspan="2">
									    <s:textarea name="passRound_allUser"  id="passRound_allUser" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'passRound_allUserId', allowName:'passRound_allUser', select:'user', single:'no', show:'usergroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
										 <s:hidden  name="passRound_allUserId" id="passRound_allUserId"/>
										  <label class="MustFillColor">*</label>
									</td>
								</tr>

								<!--  由接口决定-->
								<tr>
                                    <td>
									    <s:radio name="po.passRoundUserType"  id="passRoundUserType" list="%{#{16:getText('workflow.byTheInterface')}}" theme="simple"  onClick="clickPassRoundUserType(this);" ></s:radio>
                                    </td>
                                    <td>&nbsp;</td>
                                </tr>
                               <tr id="passRoundUserinterfacetr"  <%=passRoundUserinterfacetrDisplay%>>
                                    <td colspan="2">
									    <table border="0" width="100%">
									      <tr>
										       <td>
											       <bean:message bundle="workflow" key="workflow.className"/><!--接口类名-->：
											   </td>
											   <td>
											       <s:textfield name="po.passRoundUserClassName" id="passRoundUserClassName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" /> 
											   </td>
											   <td><bean:message bundle="workflow" key="workflow.methodName"/><!--方法名-->：</td>
											   <td>
											      <s:textfield name="po.passRoundUserMethodName" id="passRoundUserMethodName" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" />
											   </td>
											   <td></td>
										  </tr>
										   <tr>
										       <td>
											       <bean:message bundle="workflow" key="workflow.parameterName"/><!--接口参数名-->：
											   </td>
											   <td>
											    <s:textfield name="po.passRoundInpaNames" id="passRoundInpaNames" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" />
											   </td>
											   <td><bean:message bundle="workflow" key="workflow.parameterValue"/><!--接口参数值-->：</td>
											   <td>
											      <s:textfield name="po.passRoundInpaValues" id="passRoundInpaValues" cssClass="inputText" whir-options="vtype:[{'maxLength':100}]" cssStyle="width:98%;" /> 
											   </td>
											   <td width="110px">
											      <%--<div style="margin-left:-1px;margin-top:10px">
													 <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">      
													   <jsp:param name="onInit"               value="" /> 
													   <jsp:param name="onSelect"             value="" />  
													   <jsp:param name="onUploadProgress"     value="" /> 
													   <jsp:param name="onUploadSuccess"      value="passRoundUserClassName_set"  />
													   <jsp:param name="dir"                  value="/WEB-INF/classes/com/whir/ezoffice/form/" />
													   <jsp:param name="uniqueId"             value="workFlow_passRoundUserClassName"  />
													   <jsp:param name="realFileNameInputId"  value="formClassName1" /> 
													   <jsp:param name="saveFileNameInputId"  value="formClassName2" />
													   <jsp:param name="canModify"            value="yes" /> 		  
													   <jsp:param name="width"                value="70" /> 
													   <jsp:param name="height"               value="20" /> 
													   <jsp:param name="multi"                value="true" /> 
													   <jsp:param name="buttonClass"          value="upload_btn" /> 
													   <jsp:param name="buttonText"           value="" /> 
													   <jsp:param name="fileSizeLimit"        value="0" /> 
													   <jsp:param name="fileTypeExts"         value="*.class" /> 
													   <jsp:param name="uploadLimit"          value="0" /> 
													</jsp:include>
												  </div> --%>
											   </td>
										  </tr>
									   </table>
									 
									 </td>
                                  </tr>
							</table>
                         </td>
                     </tr>
 
					   <s:if test="po.actiCommType==1||moduleId==1">
                           <tr id="needPassRoundTR"  <%=needPassRoundTRDisplay%>>
                                <td id="tmd1" class="td_lefttitle"><bean:message bundle="workflow" key="workflow.activityreviewcomment"/>：</td> 
						          <s:if test="moduleId==2||moduleId==3||moduleId==34">
								  <td colspan="3">
								     <s:select cssClass="selectlist"  name="po.passRoundCommField" id="passRoundCommField" list="#request.staticCommentList" listKey="poField"  listValue="displayName" headerKey="-1" headerValue="%{getText('workflow.newactivitycomment3')}"   cssStyle="width:200px;height:29px;"   />     
                                   </td>
								 </s:if>
								  <s:else>	
								  <td colspan="3">		 
                                   <table border="0"  cellspacing="0" cellpadding="0" style="margin-left:-4px;" >                           
										<!--<bean:message bundle="workflow" key="workflow.newactivitycomment1"/>  <bean:message bundle="workflow" key="workflow.newactivitycomment2"/>  <bean:message bundle="workflow" key="workflow.newactivitycomment3"/>
										'1':'批示意见对应字段','0':'自动增加批示意见','-1':'无批示意见'
										getText('workflow.byTheInterface')
										--->
										<tr>
										   <td nowrap="nowrap">
											<s:radio name="po.passRoundCommFieldType"  id="passRoundCommFieldType" list="%{#{'1':getText('workflow.newactivitycomment1'),'0':getText('workflow.newactivitycomment2'),'-1':getText('workflow.newactivitycomment3')}}" theme="simple"  onClick="passRoundCommFieldSel_ck();" ></s:radio>
										   </td>
										   <td nowrap="nowrap"> </td>
										   <td nowrap="nowrap"> </td>
										</tr>

										<tr id="passRoundCommField_tr">
											<td>  	<s:radio  name="po.passRoundCommField" id="passRoundCommField"   list="#request.user_definedCommentList" listKey="realName"  listValue="displayName"   />
										   </td>
										</tr>
                                    </table>
									</td>
								</s:else>
                           </tr>
                           </s:if>
                            <s:else> 
                            <s:hidden  name="po.passRoundCommField"  id="passRoundCommField"/>
                           </s:else> 


					    <tr id="tr12"  <%=tr1Display%>>
						  <td height="18">&nbsp;</td>
						  <td width="29%" height="25">&nbsp;</td>
						  <td width="17%" height="18">&nbsp;</td>
						  <td width="43%" height="18">&nbsp;</td>
						</tr>

						<tr id="tr13" <%=tr1Display%> height="1">
                              <td height="25" colspan="4"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                  <tr height="1" bgcolor="#808080">
                                    <td height="1"  style="padding:0px 0 0px 0;" ></td>
                                  </tr>
                                  <tr height="1"  bgcolor="#FFFFFF">
                                    <td height="1"  style="padding:0px 0 0px 0;"></td>
                                  </tr>
                                </table></td>
                       </tr>
                       <%
					      SimpleFieldVO    fieldVO=null;	
						  java.util.Set rControl =  (java.util.Set) request.getAttribute("rwControlSet");
                          java.util.Iterator rIterator = rControl.iterator();
						  java.util.List fieldList = (java.util.List) request.getAttribute("allFieldList");
						  if(fieldList==null){
							  fieldList = new java.util.ArrayList();
						  }
					   %>
					   <tr id="tr14" <%=tr1Display%> >
                              <td><bean:message bundle="workflow" key="workflow.newactivitywritecontrol"/>：</td>
                              <td height="357" colspan="3" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
                                  <tr>
                                    <td width="130"><bean:message bundle="workflow" key="workflow.newactivitysourcefield"/>：</td>
                                    <td height="22" colspan="3"><bean:message bundle="workflow" key="workflow.newactivityreadfield"/></td>
                                  </tr>
                                  <tr>
                                    <td width="130" rowspan="4">
                                        <select name="fountainField" id="fountainField" size="19" multiple="multiple">	 
											<logic:iterate id="ffieldVO" name="r_ALLFieldList"> 
                                                <%
													 fieldVO = (SimpleFieldVO) ffieldVO;
													 if(fieldVO.isCanModify() && !"401".equals(fieldVO.getPoField())){
													 out.print("<option value="+fieldVO.getId()+">"+fieldVO.getDisplayName()+"</option>");
													 }
												%>
                                             </logic:iterate> 									 
                                        </select>

                                    </td>
                                    <td width="75" height="100"  valign="middle" > <div align="center">
                                        <input name="button" type="button" id="button" value="> " onClick="transferOptions('fountainField','readField');" class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value=">>" onClick="transferOptionsAll('fountainField','readField');" class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value="< " onClick="transferOptions('readField','fountainField');" class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button22" type="button" id="button22" value="<<" onClick="transferOptionsAll('readField','fountainField');" class="btnButton4font">
                                      </div></td>
                                    <td width="130">
                                        <select name="readField"  id="readField"  size="8" multiple="multiple"  style="width:95px" >
                                            <%while(rIterator.hasNext()){
                                                WFReadWriteControlPO rwPO = (WFReadWriteControlPO) rIterator.next();
                                                if(rwPO.getControlType() == 0){
                                                    for(int i = 0; i < fieldList.size(); i ++){
                                                        fieldVO = (SimpleFieldVO) fieldList.get(i);
                                                        if(rwPO.getControlField().longValue() == fieldVO.getId()){
                                                        %>
                                                        <option value="<%=fieldVO.getId()%>"><%=fieldVO.getDisplayName()%></option>
                                                        <%
                                                        }
                                                    }
                                                }
                                            }%>
                                        </select>
                                    </td>
									
									<td  rowspan="4"></td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td colspan="2"><bean:message bundle="workflow" key="workflow.newactivitywritefield"/></td>
                                  </tr>
                                  <tr>
                                    <td height="94"  valign="middle"> <div align="center">
                                        <input name="button" type="button" id="button" value="> " onClick="transferOptions('fountainField','writeField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value=">>" onClick="transferOptionsAll('fountainField','writeField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value="< " onClick="transferOptions('writeField','fountainField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button22" type="button" id="button22" value="<<" onClick="transferOptionsAll('writeField','fountainField');"  class="btnButton4font">
                                      </div></td>
                                    <td>
                                        <%
                                        java.util.Set wControl = (java.util.Set) request.getAttribute("rwControlSet");
                                        java.util.Iterator wIterator = wControl.iterator();
                                        %>
                                        <select name="writeField"  id="writeField" size="8" multiple="multiple" style="width:95px" >
                                            <%while(wIterator.hasNext()){
                                                WFReadWriteControlPO rwPO = (WFReadWriteControlPO) wIterator.next();
                                                if(rwPO.getControlType() == 1){
                                                    for(int i = 0; i < fieldList.size(); i ++){
                                                        fieldVO = (SimpleFieldVO) fieldList.get(i);
                                                        if(rwPO.getControlField().longValue() == fieldVO.getId()){
                                                        %>
                                                        <option value="<%=fieldVO.getId()%>"><%=fieldVO.getDisplayName()%></option>
                                                        <%
                                                        }
                                                    }
                                                }
                                            }%>
                                        </select>
                                    </td>
                                  </tr>
                                </table></td>
                            </tr>
                            
                            <tr id="tr15"   <%=tr1Display%>>
                              <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivitysignaturefield"/>：</td>
                              <td height="250" colspan="3"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                                  <tr>
                                    <td width="130"><bean:message bundle="workflow" key="workflow.newactivitysourcefield"/>：</td>
                                    <td height="22" colspan="3"> <bean:message bundle="workflow" key="workflow.newactivityprotectfield"/></td>
                                  </tr>
                                  <tr>
                                    <td width="130">
										<select name="preProtectField" id="preProtectField"  size="12" multiple="multiple" style="width:95px">
                                            <%//if("1".equals(request.getParameter("moduleId"))){%>
											<logic:iterate id="NotPtFieldList" name="NotPtFieldList" scope="request">
												<%
													 fieldVO = (SimpleFieldVO) NotPtFieldList;
													 if(fieldVO.isCanModify() && !"401".equals(fieldVO.getPoField())){
													 out.print("<option value="+fieldVO.getId()+">"+fieldVO.getDisplayName()+"</option>");
													 }
												%>
											</logic:iterate>
											<%//}%>
                                        </select>
                                    </td>
                                    <td width="75" height="100" valign="middle" > <div align="center">
                                        <input name="button" type="button" id="button" value="> " onClick="transferOptions('preProtectField','protectField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value=">>" onClick="transferOptionsAll('preProtectField','protectField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value="< " onClick="transferOptions('protectField','preProtectField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button22" type="button" id="button22" value="<<" onClick="transferOptionsAll('protectField','preProtectField');"  class="btnButton4font">
                                      </div>
									 </td>
                                    <td width="130">
										<%
											java.util.Set ptControl = (java.util.Set) request.getAttribute("ptControlSet");
											java.util.Iterator ptIterator = ptControl.iterator();
                                        %>
										<select name="protectField" id="protectField" size="12" multiple="multiple" style="width:95px">
											<%while(ptIterator.hasNext()){
                                                WFProtectControlPO ptPO = (WFProtectControlPO) ptIterator.next();
                                                if(ptPO.getControlType() == 2){
                                                    for(int i = 0; i < fieldList.size(); i ++){
                                                        fieldVO = (SimpleFieldVO) fieldList.get(i);
                                                        if(ptPO.getControlField().longValue() == fieldVO.getId()){
                                                        %>
                                                        <option value="<%=fieldVO.getId()%>"><%=fieldVO.getDisplayName()%></option>
                                                        <%
                                                        }
                                                    }
                                                }
                                            }%>
                                        </select>
                                    </td>
									<td>&nbsp;</td>
                                  </tr>
                                </table>
								</td>
                            </tr>

							<tr id="tr16"  <%=tmdtrDisplay2%>>
                              <td class="td_lefttitle" nowrap><bean:message bundle="workflow" key="workflow.HiddenFieldSet"/><!--隐藏字段设置-->：</td>
                              <td height="250" colspan="3"><table width="100%" border="0" cellspacing="1" cellpadding="0">
                                  <tr>
                                    <td width="130"><bean:message bundle="workflow" key="workflow.newactivitysourcefield"/>：</td>
                                    <td height="22" colspan="3"> <bean:message bundle="workflow" key="workflow.HiddenField"/><!--隐藏字段--></td>
                                  </tr>
                                  <tr>
                                    <td width="130">
										<select name="preHideField"  id="preHideField" size="12" multiple="multiple" style="width:95px"> 
											<logic:iterate id="NotHideFieldList" name="NotHideFieldList" scope="request">
												<%
													 fieldVO = (SimpleFieldVO) NotHideFieldList;
													 if(fieldVO.isCanModify() && !"401".equals(fieldVO.getPoField())){
													 out.print("<option value="+fieldVO.getId()+">"+fieldVO.getDisplayName()+"</option>");
													 }
												%>
											</logic:iterate> 
                                        </select>
                                    </td>
                                    <td width="75" height="100" valign="middle"> <div align="center">
                                        <input name="button" type="button" id="button" value="> " onclick="transferOptions('preHideField','hideField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value=">>" onclick="transferOptionsAll('preHideField','hideField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button" type="button" id="button" value="< " onclick="transferOptions('hideField','preHideField');"  class="btnButton4font">
                                        <div style="height:5px">&nbsp;</div> 
                                        <input name="button22" type="button" id="button22" value="<<" onclick="transferOptionsAll('hideField','preHideField');" class="btnButton4font">
                                      </div></td>
                                    <td width="130">
										<%
											java.util.Set hideControl = (java.util.Set) request.getAttribute("hideControlSet");
											java.util.Iterator hideIterator = hideControl.iterator();
                                        %>
										<select name="hideField" id="hideField" size="12" multiple="multiple" style="width:95px">
											<%while(hideIterator.hasNext()){
                                                WFHideControlPO hidePO = (WFHideControlPO) hideIterator.next();
                                                if(hidePO.getControlType() == 3){
                                                    for(int i = 0; i < fieldList.size(); i ++){
                                                        fieldVO = (SimpleFieldVO) fieldList.get(i);
                                                        if(hidePO.getControlField().longValue() == fieldVO.getId()){
                                                        %>
                                                        <option value="<%=fieldVO.getId()%>"><%=fieldVO.getDisplayName()%></option>
                                                        <%
                                                        }
                                                    }
                                                }
                                            }%>
                                        </select>
                                    </td>
									<td>&nbsp;</td>
                                  </tr>
                                </table>
								</td>
                            </tr>

							<tr id="tmdtr" <%=tmdtrDisplay%>>
                                <td class="td_lefttitle" nowrap ><bean:message bundle="workflow" key="workflow.newactivitycommentcheck"/>：</td>
                                <td height="40" colspan="3">
								 <s:textarea name="po.commentRangeName"  id="commentRangeName" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:90%;" readonly="true" ></s:textarea><a href="#" class="selectIco textareaIco" onclick="openSelect({allowId:'commentRange', allowName:'commentRangeName', select:'user', single:'no', show:'userorggroup', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><s:hidden  name="po.commentRange" id="commentRange"/>								  
                                </td>
                            </tr>

							<tr id="tr17"  <%=tr1Display%>  height="1">
                              <td height="25" colspan="4"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                  <tr height="1" bgcolor="#808080">
                                    <td height="1"  style="padding:0px 0 0px 0;"></td>
                                  </tr>
                                  <tr height="1"  bgcolor="#FFFFFF">
                                    <td height="1"  style="padding:0px 0 0px 0;"></td>
                                  </tr>
                                </table></td>
                            </tr>

							<tr id="tr18" <%=tr1Display%> >
                              <td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityadvancedsetting"/>：</td>
                              <td height="40" colspan="3" valign="middle">
							      <s:checkbox  name="allowStandFor"  id="allowStandFor" ></s:checkbox><bean:message bundle="workflow" key="workflow.newactivityreplacement"/>
                                  <img width="14" height="16" border="0" src="images/helpuser.gif"  title='<bean:message bundle="workflow" key="workflow.daibannote"/>'/>
                                   <s:if test="smsInUse==0">
								       <input type="hidden" name="allowSmsRemind"  id="allowSmsRemind"  value="false" />
								   </s:if>
								   <s:else>
								      <span>
								         <s:checkbox  name="allowSmsRemind"  id="allowSmsRemind" onclick="allowSmsRemindCheck(this)" ></s:checkbox><bean:message bundle="workflow" key="workflow.activitysmsremind"/>
								      </span>
									   <span  id="remindTypeId"  <s:if test="!allowSmsRemind" >style="display:none"</s:if> >
								        <s:radio name="allowSmsRemindType"  id="allowSmsRemindType" list="%{#{'1':getText('workflow.defaultcheck'),'2':getText('workflow.defaultnotcheck')}}" theme="simple"  ></s:radio>
								       </span>
								   </s:else> 
                              </td>
                           </tr>
						   <tr  class="Table_nobttomline">  
							 <td class="td_lefttitle">&nbsp; </td> 
							 <td colspan="2">  
								<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
								<s:if test="wfActivityId==null">
								<input type="button" class="btnButton4font" onClick="save(1,this);"  id="saveContinueButton" value='<s:text name="comm.savecontinue"/>' />  
								</s:if>
								<input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
								<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
							 </td>  
						 </tr> 
       </table>
  </div>
  <div id="docinfo1" style="display:none;"  multiTag='yes' > 
         <table width="100%" border="0" class="Table_bottomline" cellpadding="0" cellspacing="0" style="margin-left:4px;margin-top:4px;">
              <tr>
                   <td colspan="2" align="left">
                       <bean:message bundle="workflow" key="workflow.newactivitybuttonall"/>：<input type="checkbox" name="sa" onClick="selectAll(this);showTranTR();showAddSignTR();showDispenseTR();showTranReadTR();clickSelfsend();checkBackButton();setCheckStyle();">
                   </td>
             </tr>
             <tr>
		  		<td colspan="2">
			    	<B><bean:message bundle="workflow" key="workflow.newactivitybuttonworkflow"/></B>
				</td>
        	 </tr>
             <tr>
		  		  <td width="50%">
				       <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdBack")!=-1?"checked":""%> value="cmdBack"  onclick="checkBackButton()"><IMG SRC="images/toolbar/back.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonback"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
				  </td>
		  		   <td width="50%">
				       <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdDelete")!=-1?"checked":""%> value="cmdDelete"><IMG SRC="images/toolbar/delete.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonvoid"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
				    </td>
        	 </tr>
			 <tr id="backMailRangeTR" <%=(request.getAttribute("operButton")+"").indexOf("cmdBack")!=-1?"":"style=\"display:none\""%>>
			   	 <%
				   String  backMailRange=request.getAttribute("backMailRange")==null?"0":""+request.getAttribute("backMailRange");
			 	 %>
				  <td colspan="2"><s:text name="workflow.mailRange"/><!-- 邮件提醒范围 -->：
					<INPUT TYPE="radio" NAME="backMailRange" value="0"  <%if(backMailRange.equals("0"))out.print("checked");%> ><s:text name="workflow.ReturnPartOfManagers"/><!-- 退回环节经办人 --><INPUT TYPE="radio" NAME="backMailRange" value="1" <%if(backMailRange.equals("1"))out.print("checked");%> ><s:text name="workflow.AllParticipator"/><!-- 所有经办人 -->
				   </td>
             </tr>
             <tr>
		  		  <td>
				     <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"cmd").indexOf("cmdTrancmd")!=-1?"checked":""%> value="cmdTran" onClick="showTranTR();"><IMG SRC="images/toolbar/transend.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonshift"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】&nbsp;&nbsp;<input type="checkbox" value="1" name="autoTranReturn"  <%=(request.getAttribute("autoTranReturn")+"").equals("1")?"checked":""%>><bean:message bundle="workflow" key="workflow.Automaticallyreturn"/>
				  </td>

				 <td>
				    <INPUT TYPE="checkbox" NAME="operButton" onClick="clickSelfsend();" <%=(request.getAttribute("operButton")+"").indexOf("cmdSelfsend")!=-1?"checked":""%> value="cmdSelfsend"><IMG SRC="images/toolbar/view.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonreview"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
			    </td>
              </tr>
			  <tr id="tranTR">
				   <td colspan="2" nowrap>
						<bean:message bundle="workflow" key="workflow.activitytranrange"/>：
                        <INPUT TYPE="radio" NAME="tranType"  <%=(request.getAttribute("tranType")==null?"0":request.getAttribute("tranType").toString()).equals("0")?"checked":""%> value="0" onClick="showTranTR();"><bean:message bundle="workflow" key="workflow.activitytranall"/>
						<INPUT TYPE="radio" NAME="tranType"  <%=(request.getAttribute("tranType")+"").equals("1")?"checked":""%> value="1" onClick="showTranTR();"><bean:message bundle="workflow" key="workflow.activitytranorg"/>
						<INPUT TYPE="radio" NAME="tranType"  <%=(request.getAttribute("tranType")+"").equals("2")?"checked":""%> value="2" onClick="showTranTR();" style="display:none">
						<INPUT TYPE="radio" NAME="tranType"  <%=(request.getAttribute("tranType")+"").equals("3")?"checked":""%> value="3" onClick="showTranTR();"><bean:message bundle="workflow" key="workflow.activitytranperson"/>
						<INPUT TYPE="radio" NAME="tranType"  <%=(request.getAttribute("tranType")+"").equals("4")?"checked":""%> value="4" onClick="showTranTR();"><bean:message bundle="workflow" key="workflow.activitytrandiy"/>　
				   </td>
               </tr>

			    <tr  id="tranCustomTR">
				   <td colspan="2" nowrap>　　　　　 <INPUT TYPE="text" NAME="tranCustomExtent"  id="tranCustomExtent" value="<%=request.getAttribute("tranCustomExtent")==null?"":request.getAttribute("tranCustomExtent")+""%>" class="inputText"   readonly  style="width:31%"><input type="hidden" name="tranCustomExtentId" id="tranCustomExtentId" value="<%=request.getAttribute("tranCustomExtentId")==null?"":request.getAttribute("tranCustomExtentId")+""%>"><a href="#" class="selectIco" onclick="openSelect({allowId:'tranCustomExtentId', allowName:'tranCustomExtent', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a> 　
				   </td>
               </tr>
			   <tr>
		  		   <td>
				      <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdAddSign")!=-1?"checked":""%> value="cmdAddSign" onClick="showAddSignTR();"><IMG SRC="images/toolbar/adds.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.addsign"/><!--加签-->【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
				   </td>
		  		   <td>
				       <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdRelation")!=-1?"checked":""%> value="cmdRelation"><IMG SRC="images/toolbar/relation.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.Relatedworkflow"/><!--关联流程-->【<bean:message bundle="workflow" key="workflow.newactivitybuttonunderapp"/>】
				   </td>
        	   </tr>
               <tr id="addSignTR">
				   <td colspan="2"><s:text name="workflow.addsignRange"/><!-- 加签范围 -->：
						<INPUT TYPE="radio" NAME="addSignType" <%=(request.getAttribute("addSignType")==null?"0":request.getAttribute("addSignType").toString()).equals("0")?"checked":""%> value="0" onClick="showAddSignTR();"><bean:message bundle="workflow" key="workflow.activitytranall"/>
                        <INPUT TYPE="radio" NAME="addSignType"  <%=(request.getAttribute("addSignType")+"").equals("1")?"checked":""%> value="1" onClick="showAddSignTR();"><bean:message bundle="workflow" key="workflow.activitytranorg"/>
						<INPUT TYPE="radio" NAME="addSignType"  <%=(request.getAttribute("addSignType")+"").equals("2")?"checked":""%> value="2" onClick="showAddSignTR();" style="display:none"><!-- <bean:message bundle="workflow" key="workflow.activitytranunit"/>
						&nbsp; -->
						<INPUT TYPE="radio" NAME="addSignType"  <%=(request.getAttribute("addSignType")+"").equals("3")?"checked":""%> value="3" onClick="showAddSignTR();"><bean:message bundle="workflow" key="workflow.activitytranperson"/>
						<INPUT TYPE="radio" NAME="addSignType"  <%=(request.getAttribute("addSignType")+"").equals("4")?"checked":""%> value="4" onClick="showAddSignTR();"><bean:message bundle="workflow" key="workflow.activitytrandiy"/>
						 
				   </td>
               </tr>
			   <tr id="addSignCustomTR">
				   <td colspan="2">　　　　　 <INPUT TYPE="text" NAME="addSignCustomExtent" id="addSignCustomExtent" value="<%=request.getAttribute("addSignCustomExtent")==null?"":request.getAttribute("addSignCustomExtent")+""%>" class="inputText"   readonly="true" style="width:31%"><a href="#" class="selectIco" onclick="openSelect({allowId:'addSignCustomExtentId', allowName:'addSignCustomExtent', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a>
						<input type="hidden" name="addSignCustomExtentId" id="addSignCustomExtentId" value="<%=request.getAttribute("addSignCustomExtentId")==null?"":request.getAttribute("addSignCustomExtentId")+""%>"> 
				   </td>
               </tr>
			   <tr>
				    <td>
					    <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdTranRead")!=-1?"checked":""%> value="cmdTranRead" onClick="showTranReadTR();"><IMG SRC="images/toolbar/tranview.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.Transferforreview"/>【<bean:message bundle="workflow" key="workflow.Waitingtoreviewbutton"/>】
					</td>
		  		    <td>
					   <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdUndo")!=-1?"checked":""%> value="cmdUndo"><IMG SRC="images/toolbar/undo.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttondrawback"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】
				    </td>
        	   </tr>
               <tr id="tranReadTR">
					<td colspan="2"><!-- 转阅范围 --><bean:message bundle="workflow" key="workflow.Scopeoftransferforreviewing"/>：
						  <INPUT TYPE="radio" NAME="tranReadType" <%=(request.getAttribute("tranReadType")==null?"0":request.getAttribute("tranReadType").toString()).equals("0")?"checked":""%> value="0" onClick="showTranReadTR();"><bean:message bundle="workflow" key="workflow.activitytranall"/>
						  <INPUT TYPE="radio" NAME="tranReadType"  <%=(request.getAttribute("tranReadType")+"").equals("1")?"checked":""%> value="1" onClick="showTranReadTR();"><bean:message bundle="workflow" key="workflow.activitytranorg"/>
						  <INPUT TYPE="radio" NAME="tranReadType"  <%=(request.getAttribute("tranReadType")+"").equals("3")?"checked":""%> value="3" onClick="showTranReadTR();"><!-- 本活动阅件人 --><bean:message bundle="workflow" key="workflow.CurrentReviewer"/>
						  <INPUT TYPE="radio" NAME="tranReadType"  <%=(request.getAttribute("tranReadType")+"").equals("4")?"checked":""%> value="4" onClick="showTranReadTR();"><bean:message bundle="workflow" key="workflow.activitytrandiy"/>
						  
					</td>
               </tr>
			    <tr id="tranReadCustomTR">
					<td colspan="2">　　　　　 <INPUT TYPE="text" NAME="tranReadCustomExtent" id="tranReadCustomExtent" value="<%=request.getAttribute("tranReadCustomExtent")==null?"":request.getAttribute("tranReadCustomExtent")+""%>" class="inputText"   readonly="true" style="width:31%" ><a href="#" class="selectIco" onclick="openSelect({allowId:'tranReadCustomExtentId', allowName:'tranReadCustomExtent', select:'userorggroup', single:'no', show:'userorggroup', range:'*0*'});"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a> <input type="hidden" name="tranReadCustomExtentId" id="tranReadCustomExtentId" value="<%=request.getAttribute("tranReadCustomExtentId")==null?"":request.getAttribute("tranReadCustomExtentId")+""%>"> 
					</td>
               </tr>
               <tr>
		  		    <td>
				        <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdFeedback")!=-1?"checked":""%> value="cmdFeedback"><IMG SRC="images/toolbar/feedback.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonfeedback"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】
					 </td>
					<td>
					   <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdReturn")!=-1?"checked":""%> value="cmdReturn"><IMG SRC="images/toolbar/drawback.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonrecycle"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinishedfinished"/>】
					</td>
        	  </tr>
			  <tr>
		  		    <td>
				      <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdCancel")!=-1?"checked":""%> value="cmdCancel"><IMG SRC="images/toolbar/cancel.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.Cancel"/>【<bean:message bundle="workflow" key="workflow.Buttonofmydocumentinprocessing"/>】
				    </td>
			        <td>
				      <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdAddNew")!=-1?"checked":""%> value="cmdAddNew"> <IMG SRC="images/toolbar/addnew.png">&nbsp;&nbsp;<bean:message bundle="information" key="info.newProcess"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】
				    </td>
        	  </tr>
              <tr>
		  		  <td>
				     <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdWait")!=-1?"checked":""%> value="cmdWait"><IMG SRC="images/toolbar/press.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonurge"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttonunfinished"/>】
				  </td>
		  		  <td>
				     <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdEmailSend")!=-1?"checked":""%> value="cmdEmailSend"><IMG SRC="images/toolbar/tranmail.png">&nbsp;&nbsp;<bean:message bundle="information" key="info.emailSend"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】
				  </td>
        	  </tr>
              <tr>
		  		   <td>
				      <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdPrint")!=-1?"checked":""%> value="cmdPrint"><IMG SRC="images/toolbar/print.png">&nbsp;&nbsp;<bean:message bundle="workflow" key="workflow.newactivitybuttonprint"/>【<bean:message bundle="workflow" key="workflow.newactivitybuttoncommon"/>】
				  </td>
		  		  <td>&nbsp;&nbsp;</td> 
        	  </tr>
			  <s:if test="moduleId==2||moduleId==3||moduleId==34||(moduleId>200&&moduleId<300)">
			  <!---公文按钮--->
			  <tr height="1">
				  <td colspan="2"> <table width="100%" border="0" cellpadding="0" cellspacing="0">
					  <tr height="1" bgcolor="#808080">
						<td height="1"  style="padding:0px 0 0px 0;"></td>
					  </tr>
					  <tr height="1"  bgcolor="#FFFFFF">
						<td height="1"  style="padding:0px 0 0px 0;"></td>
					  </tr>
					</table>
				 </td>
			  </tr>
              <tr>
		  		<td colspan="2"><B>公文按钮</B></td>
        	  </tr>  			 
			  <tr>	 
		  		  <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdGovUnionTask")!=-1?"checked":""%> value="cmdGovUnionTask"><IMG SRC="images/toolbar/addunion.png">&nbsp;&nbsp;加入督办任务【待办按钮】</td>
			      <td>&nbsp;&nbsp;</td>
        	  </tr>
			  </s:if>
			 <s:if  test="moduleId==2||(moduleId>=260&&moduleId<300)">
			  <!--//发文按钮-->
			  <tr height="1">
				    <td colspan="2"> 
				        <table width="100%" border="0" cellpadding="0" cellspacing="0">
					         <tr height="1" bgcolor="#808080">
					     	   <td height="1"  style="padding:0px 0 0px 0;"></td>
					        </tr>
					        <tr height="1"  bgcolor="#FFFFFF">
						       <td height="1"  style="padding:0px 0 0px 0;"></td>
					        </tr>
					    </table>
				   </td>
			  </tr>
              <tr>
		  		   <td colspan="2">
				       <B>发文按钮</B>
				   </td>
        	  </tr>
              <tr>
		  		     <td>
				        <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdWritetext")!=-1?"checked":""%> value="cmdWritetext"><IMG SRC="images/toolbar/writetext.gif">&nbsp;&nbsp;起草正文【待办按钮】
				     </td>
		  	         <td>
				        <INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdReadtext")!=-1?"checked":""%> value="cmdReadtext"><IMG SRC="images/toolbar/readtext.gif">&nbsp;&nbsp;批阅正文【待办按钮】
					 </td>
        	 </tr>
             <tr>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdSavefile")!=-1?"checked":""%> value="cmdSavefile"><IMG SRC="images/toolbar/savefile.gif">&nbsp;&nbsp;生成正式文件【待办按钮】</td>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdCode")!=-1?"checked":""%> value="cmdCode"><IMG SRC="images/toolbar/code.gif">&nbsp;&nbsp;编号【待办按钮】
					</td>
        	  </tr>
			 <tr>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdSendclose")!=-1?"checked":""%> value="cmdSendclose"  onClick="showDispenseTR();"><IMG SRC="images/toolbar/documentSend.gif">&nbsp;&nbsp;分发【待办按钮】</td>
		  			<td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdToreceive")!=-1?"checked":""%> value="cmdToreceive"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转收文【通用按钮】
					</td>
        	 </tr>
		     <tr id="dispenseTR">
					<td colspan="2">分发范围：
					<INPUT TYPE="radio" NAME="dispenseType" <%=(request.getAttribute("dispenseType")+"").equals("0")?"checked":""%> value="0" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytranall"/>
					<INPUT TYPE="radio" NAME="dispenseType"  <%=(request.getAttribute("dispenseType")+"").equals("1")?"checked":""%> value="1" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytranorg"/>
					<INPUT TYPE="radio" NAME="dispenseType"  <%=(request.getAttribute("dispenseType")+"").equals("2")?"checked":""%> value="2" onClick="showDispenseTR();" style="display:none">
					<INPUT TYPE="radio" NAME="dispenseType"  <%=(request.getAttribute("dispenseType")+"").equals("3")?"checked":""%> value="3" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytranperson"/>
					<INPUT TYPE="radio" NAME="dispenseType"  <%=(request.getAttribute("dispenseType")+"").equals("4")?"checked":""%> value="4" onClick="showDispenseTR();"><bean:message bundle="workflow" key="workflow.activitytrandiy"/>
					<span id="dispenseCustomTR"><INPUT TYPE="text" name="dispenseCustomExtent"  id="dispenseCustomExtent" value="<%=request.getAttribute("dispenseCustomExtent")==null?"":request.getAttribute("dispenseCustomExtent")+""%>" class="inputText"   readonly  style="width:50%" ><a href="#" class="selectIco" onclick="openSelect({allowId:'dispenseCustomExtentId', allowName:'dispenseCustomExtent', select:'orggroup', single:'no', show:'orggroup', range:'*0*'});return false;"><img src="<%=rootPath%>/images/select_arrow.gif" width="16" height="16" align="absmiddle"/></a><input type="hidden" name="dispenseCustomExtentId" id="dispenseCustomExtentId" value="<%=request.getAttribute("dispenseCustomExtentId")==null?"":request.getAttribute("dispenseCustomExtentId")+""%>"> 
					</span>
					</td>
               </tr>
			   <tr>
					<td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdTocheck")!=-1?"checked":""%> value="cmdTocheck"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转文件送审签【通用按钮】</td>
					<td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdGovExchange")!=-1?"checked":""%> value="cmdGovExchange"><IMG SRC="images/toolbar/govexchange.png">&nbsp;&nbsp;公文交换【通用按钮】</td>
        	  </tr>
			  <tr>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdViewtext")!=-1?"checked":""%> value="cmdViewtext"><IMG SRC="images/toolbar/viewtext.gif">&nbsp;&nbsp;查看正文【通用按钮】</td>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdReSavefile")!=-1?"checked":""%> value="cmdReSavefile"><IMG SRC="images/toolbar/worddue.png">&nbsp;&nbsp;再次套红【待办按钮】</td> 
        	  </tr>
             </s:if>
             <s:if test="moduleId==3||(moduleId>230&&moduleId<259)">
			  <!--//收文按钮-->
			  <tr height="1">
				   <td colspan="2">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0">
							  <tr height="1" bgcolor="#808080">
								<td height="1"  style="padding:0px 0 0px 0;"></td>
							  </tr>
							  <tr height="1"  bgcolor="#FFFFFF">
								<td height="1"  style="padding:0px 0 0px 0;"></td>
							  </tr>
					   </table>
				    </td>
			  </tr>
              <tr>
		  		    <td colspan="2"><B>收文按钮</B></td>
        	  </tr>
			  <tr>
				    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdTosend")!=-1?"checked":""%> value="cmdTosend"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转发文【通用按钮】</td>
					<td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdTocheck")!=-1?"checked":""%> value="cmdTocheck"><IMG SRC="images/toolbar/toreceive.gif">&nbsp;&nbsp;转文件送审签【通用按钮】</td>			
        	 </tr>
             </s:if>
			 <s:if test="moduleId==34 ||(moduleId>200&&moduleId<229)">
			  <tr height="1">
				  <td colspan="2">
					   <table width="100%" border="0" cellpadding="0" cellspacing="0">
							  <tr height="1" bgcolor="#808080">
								<td height="1"  style="padding:0px 0 0px 0;"></td>
							  </tr>
							  <tr height="1"  bgcolor="#FFFFFF">
								<td height="1"  style="padding:0px 0 0px 0;"></td>
							  </tr>
						</table>
				  </td>
			  </tr>
              <tr>
		  		   <td colspan="2"><B>文件送审签按钮</B></td>
        	  </tr>
              <tr>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdWritetext")!=-1?"checked":""%> value="cmdWritetext"><IMG SRC="images/toolbar/writetext.gif">&nbsp;&nbsp;起草正文【待办按钮】</td>
		  		    <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdReadtext")!=-1?"checked":""%> value="cmdReadtext"><IMG SRC="images/toolbar/readtext.gif">&nbsp;&nbsp;批阅正文【待办按钮】</td>
        	   </tr>
			   <!-- <tr>
				     <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdSavefile")!=-1?"checked":""%> value="cmdSavefile"><IMG SRC="images/toolbar/savefile.gif">&nbsp;&nbsp;生成正式文件【待办按钮】</td>
                     <td>&nbsp;</td> 
				</tr> -->
			</s:if>
             <%   //取 自定义扩展的按钮
                  com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD  workFlowButtonBD=new  com.whir.ezoffice.workflow.newBD.WorkFlowButtonBD();
                  List extButtonsList=workFlowButtonBD.getAllExtButtons();
				  if(extButtonsList!=null&&extButtonsList.size()>0){
					   int  extButtonsListSize=extButtonsList.size();
					   int  nowTdIndex=1;
					   Object extButtonArr[]=null;
					   
			 %>
			<tr>
			  <td colspan="2"><B><s:text name="workflow.trandiyButton"/></B></td>
			</tr>
			 <%
				for(int jj=0;jj<extButtonsListSize;jj++){ 
					 extButtonArr=(Object [])extButtonsList.get(jj);
					 if(nowTdIndex==1){ 
				         out.print("<tr>");
					 }
			 %>
					 <td><INPUT TYPE="checkbox" NAME="operButton" <%=(request.getAttribute("operButton")+"").indexOf("cmdEXT"+extButtonArr[0])!=-1?"checked":""%> value="<%="cmdEXT"+extButtonArr[0]%>"><IMG SRC="<%=extButtonArr[1]%>">&nbsp;&nbsp;<%=extButtonArr[2]%></td>
					  <%
						 if(nowTdIndex==2){
							nowTdIndex=1;
							out.print("</tr>");  
						  }else{
							nowTdIndex=2;
						  }

				}			 
			    if(nowTdIndex==2){%>
					  <td>&nbsp;&nbsp;</td> 
        	       </tr>		
			 <%  }else{
				
				
				} 
			  }
			%>

             <tr>
          			<td><INPUT TYPE="hidden" NAME="operButtonValue"></td>
          			<td>&nbsp;</td> 
        	 </tr>
			 <tr  class="Table_nobttomline">  
			    <td colspan="2">
					 <table width="100%" border="0">
					  <tr  class="Table_nobttomline">
						 <td class="td_lefttitle">&nbsp;</td> 
						 <td>
							<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
							<s:if test="wfActivityId==null">
							<input type="button" class="btnButton4font" onClick="save(1,this);"  id="saveContinueButton" value='<s:text name="comm.savecontinue"/>' /> 
							</s:if>
							<input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />
							<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
						 </td>  
				      </tr>
				  </table>
               <td>
			</tr>
         </table>
      </div>
      <div id="docinfo2" style="display:none;" multiTag='yes'>
			<!--接口-->
			<table width="100%" border="0"   class="Table_bottomline" cellpadding="0" cellspacing="0" >
			  <tr>
					<td width="160" class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityworkflowmethod"/>：</td>
					<td height="40" colspan="2" valign="middle">
					   <s:textfield name="po.formClassMethod" id="formClassMethod" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':25}]" cssStyle="width:98%;" /> 
					</td>
					<td><label class="MustFillColor"><bean:message bundle="workflow" key="workflow.newactivityspecialwarning"/></label>
					</td>
			  </tr>
			  <tr>
					<td class="td_lefttitle"><bean:message bundle="workflow" key="workflow.newactivityreturnmethod"/>：</td>
					<td height="40" colspan="2" valign="middle">
						<s:textfield name="po.untreadMethod" id="untreadMethod" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':25}]" cssStyle="width:98%;" /> 
					</td>
					<td><label class="MustFillColor"><bean:message bundle="workflow" key="workflow.newactivityspecialwarning"/></label>
					</td>
			  </tr>

			  <tr><td colspan="4" class="td_lefttitle" ><b><s:text name="workflow.set_dealwithjsmethod"/><!-- 加载或保存时执行的脚本 --></b></td></tr>
			  <tr>
					<td class="td_lefttitle"><s:text name="workflow.set_loadjsmethod"/><!-- 页面加载方法名 -->：</td>
					<td colspan=2>
						<s:textfield name="po.jsLoadMethod" id="jsLoadMethod" cssClass="inputText" whir-options="vtype:[{'maxLength':25}] " cssStyle="width:98%;" /> 
					</td>
					<td></td>
				  </tr>
				  <tr>
					<td class="td_lefttitle"><s:text name="workflow.set_updatejsmethod"/><!-- 页面保存方法名 -->：</td>
					<td colspan=2>
						 <s:textfield name="po.jsSaveMethod" id="jsSaveMethod" cssClass="inputText" whir-options="vtype:[{'maxLength':25}] " cssStyle="width:98%;" />
					</td>
					<td></td>
				  </tr>
				  <tr  class="Table_nobttomline">  
					 <td class="td_lefttitle">&nbsp; </td> 
					 <td colspan="3">  
						<input type="button" class="btnButton4font" onClick="save(0,this);" value='<s:text name="comm.saveclose"/>' />  
						<s:if test="wfActivityId==null">
						<input type="button" class="btnButton4font" onClick="save(1,this);"  id="saveContinueButton" value='<s:text name="comm.savecontinue"/>' />  
						</s:if>
						<input type="button" class="btnButton4font" onClick="resetDataForm(this);"     value='<s:text name="comm.reset"/>' />  
						<input type="button" class="btnButton4font" onClick="window.close();" value='<s:text name="comm.exit"/>' />  
				     </td>  
                 </tr> 
			</table>
        </div>           
      </td>
   </tr>
</table>
</div>
<SCRIPT LANGUAGE="JavaScript">
<!--
function save(type, obj){ 
	var activityClass_v=getRadioValue("po.activityClass");
	if(activityClass_v==0){
		if($("#activitySubProc").val()==""||$("#activitySubProc").val()=="0"){
			changePanle(0);
			whir_poshytip($("#activitySubProcName"),'请选择子过程。');
			return false;
		}
	} 
	if( $('input[name=formCtrl]').eq(1).attr("checked")=="checked"){
		if($("#form").val()=="0"||$("#form").val()==""){
			changePanle(0);
			whir_poshytip($('input[name=formCtrl]').eq(1),'<s:text name="workflow.activityselectform"/>');
			//$("#form").focus(); 
			return false;
		}else{
		    $("#formId").val($("#form").val());
		}
	}
 
    var pressLimit = true;
    if($("#activityName").val().indexOf("'") >=0){
		whir_poshytip($("#activityName"),'活动名称不能包含单引号！');
		$("#activityName").focus(); 
		return false;
    }

	if($("#activityName").val().indexOf(">") >=0){
		whir_poshytip($("#activityName"),'活动名称不能包含>！');
		$("#activityName").focus(); 
		return false;
    }

	if($("#activityName").val().indexOf("<") >=0){
		whir_poshytip($("#activityName"),'活动名称不能包含<！');
		$("#activityName").focus(); 
		return false;
    }
	
	var  transactTypeValue=false;

	if($("#transactType_2").attr("checked")=="checked"){
		transactTypeValue=true;
	}
	if($("#transactType_1").attr("checked")=="checked"){
		transactTypeValue=true;
	}
	if($("#transactType_3").attr("checked")=="checked"){
		transactTypeValue=true;
	}
	if($("#transactType_0").attr("checked")=="checked"){
		transactTypeValue=true;
	}
    
	if(!transactTypeValue){
		changePanle(0);
		whir_poshytip($("#transactType_2"),'<s:text name="workflow.activityselectdealtype"/>');
		return false;
	}

	var  participantTypevalue=getRadioValue("po.participantType");
	var  passRoundUserTypevalue=getRadioValue("po.passRoundUserType");
	//从候选人员中指定 
    if(participantTypevalue==2&&$("#candidateId").val() == ''){
		changePanle(0);
		whir_poshytip($("#candidate"),'<s:text name="workflow.activitytranselcandidate"/>');
		return false;
	} 
	//指定全部办理人
	if(participantTypevalue==3&&$("#allUserId").val()== ''){
		changePanle(0);
		whir_poshytip($("#allUser"),'<s:text name="workflow.activitytranselcandidate"/>');
		return false;
    }

	//从选定的群组中选择 
	if(participantTypevalue==13&& $("#participantGivenGroup").val() == ''){
		changePanle(0);
		whir_poshytip($("#participantGivenGroupName"),'<s:text name="workflow.activitytranselgroup"/>');
		return false;
	}

	//从选定的范围中选择 
	if(participantTypevalue==8&& $("#participantGivenOrgName").val() == ''){ 
		changePanle(0);
		whir_poshytip($("#participantGivenOrgName"),'<s:text name="workflow.activitytranselrange"/>');
		return false;
	}
	
	//从选定的范围中选择 
	if(participantTypevalue==16){
		if($("#participantClassName").val()==""){
			//接口类不能为空！
			whir_poshytip($("#participantClassName"),'<s:text name="workflow.participantClassNameNotNull"/>');
			//$("#participantClassName").focus(); 
			return false;
		}
		if($("#participantMethodName").val()==""){
			//接口方法不能为空！
			whir_poshytip($("#participantMethodName"),'<s:text name="workflow.participantMethodNameNotNull"/>');
			//$("#participantMethodName").focus();
			return false;
		}
	}
	
	var needPassRound_val=getRadioValue("po.needPassRound");
	if(needPassRound_val==1&&passRoundUserTypevalue==2 && $("#passRound_candidateId").val()== ''){
		changePanle(0);
		whir_poshytip($("#passRound_candidate"),'<s:text name="workflow.activitytranselcandidate"/>');
		return false;
	}

	if(needPassRound_val==1 && passRoundUserTypevalue==3 && $("#passRound_allUserId").val()== ''){
		changePanle(0);
		whir_poshytip($("#passRound_allUser"),'<s:text name="workflow.activitytranselalldealer"/>');
		return false;
	}
    
	if(needPassRound_val==1 &&passRoundUserTypevalue==13&& $("#passRoundGivenGroupName").val()== ''){
		changePanle(0);
		whir_poshytip($("#passRoundGivenGroupName"),'<s:text name="workflow.activitytranselgroup"/>');
		return false;
	}
                 
    if(needPassRound_val==1 && passRoundUserTypevalue==8 && $("#passRoundGivenOrgName").val() == ''){
		changePanle(0);
		whir_poshytip($("#passRoundGivenOrgName"),'<s:text name="workflow.activitytranselrange"/>');
		return false;
	}
	
	if(needPassRound_val==1 && passRoundUserTypevalue==16){
		if($("#passRoundUserClassName").val()==""){
			whir_poshytip($("#passRoundUserClassName"),'<s:text name="workflow.participantClassNameNotNull"/>');
			//$("#passRoundUserClassName").focus();
			return false;
		}
		if($("#passRoundUserMethodName").val()==""){
			whir_poshytip($("#passRoundUserMethodName"),'<s:text name="workflow.participantMethodNameNotNull"/>');
			return false;
		}
	}
 
	//默认只读	 
	transferOptionsAll('fountainField','readField');
	chooseAllselect("readField");
	chooseAllselect("writeField");
	//电子签章保护字段
	chooseAllselect("protectField");
	//隐藏字段
	chooseAllselect("hideField");
	
	var  url='<%=rootPath%>/platform/bpm/work_flow/activity/wf_activity_name_judge.jsp';
	var  para='activityId='+$("#wfActivityId").val()+'&activityName=' +encodeURI($("#activityName").val()) +'&processId=' +$("#processId").val(); 
	//检测重名
	var  responseText=ajaxForSync(url,para);  
	if(responseText=="1"){
		whir_alert("名称重复！",null);
		return false;
	}
	ok(type,obj);
}
 

showTranTR();
showAddSignTR();
showDispenseTR();
showTranReadTR();

//办件批示意见 影藏
actiCommFieldSel_ck();
passRoundCommFieldSel_ck();

//渲染
//setInputStyle();

//【2106-01-15 虚拟活动、分叉活动、聚合活动只需显示基本信息页签，操作按钮、接口页签应该隐藏掉】
showPanle();
//-->
</SCRIPT>
 