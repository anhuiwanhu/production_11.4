
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <s:hidden id="forumClassId" value="%{forumClassId}" />
                    <tr>  
                        <td for='<s:text name="bbs.bbsname" />' width="100" class="td_lefttitle">  
                            <s:text name="bbs.bbsname" /><span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="3">  
                            <s:hidden name="forumPO.id" id="id" />
                            <s:textfield name="forumPO.className" id="className" cssClass="inputText" cssStyle="width:95%" whir-options="vtype:['notempty',{'maxLength':40}, 'spechar3']" maxLength="40" />
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="bbs.webmaster" />' class="td_lefttitle">  
                            <s:text name="bbs.webmaster" />：  
                        </td>  
                        <td colspan="3">  
                            <s:hidden name="forumPO.classOwnerIds" id="classOwnerIds" whir-options="vtype:[{'maxLength':100}]" maxLength="100" />
                            <s:textfield name="forumPO.classOwnerName" id="classOwnerName" cssClass="inputText" cssStyle="width:95%" readonly="true" whir-options="vtype:[{'maxLength':100}]" maxLength="100" /><a href="javascript:void(0);" class="selectIco" onclick="openSelect({allowId:'classOwnerIds', allowName:'classOwnerName', select:'user', single:'no', show:'user', range:'*0*'});"></a>
                        </td> 
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.belong" />' class="td_lefttitle">  
                            <s:text name="bbs.belong" />：  
                        </td>  
                        <td colspan="3">
                            <s:if test="forumClassId!=null">
                                <s:hidden value="%{forumPO.classParent}" id="classParentOld" />
                            </s:if>
                            <select name="forumPO.classParent" id="classParent" class="easyui-combobox" style="width:290px;" data-options="  selectOnFocus:true,onSelect: function(record){loadClassSortCodeComboboxData(record);}, editable:false">
                                <option value="0">--<s:text name="bbs.Pleaseselect" />--</option>
                                <s:iterator var="obj" value="#request.classParentList" >
                                    <option value="<s:property value='#obj[0]'/>"><s:property value='#obj[1]' escape="false"/></option>
                                </s:iterator>
                            </select>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.Sort" />' class="td_lefttitle">  
                            <s:text name="bbs.Sort" />：  
                        </td>  
                        <td colspan="3">  
                            <s:if test="forumClassId!=null">
                                <s:hidden id="formInsertReferIdOld" value="%{formInsertReferId}" />  
                                <s:hidden id="formInsertSiteOld" value="%{formInsertSite}" />  
                                <s:hidden name="formOrderCodeFlag" id="formOrderCodeFlag" value="0" />  
                            </s:if>
                            <select name="formInsertReferId" id="formInsertReferId" class="easyui-combobox" style="width:290px;" data-options="valueField:'id',textField:'text', editable:false">
                            <s:if test="#request.classSiblingList==null || #request.classSiblingList.size==0">
                                <option value="-1">--<s:text name="bbs.null" />--</option>
                            </s:if>
                                <s:iterator var="obj" value="#request.classSiblingList" >
                                    <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
                                </s:iterator>
                            </select>
                            <s:if test="forumClassId==null || #request.formInsertSite==null">
                                <s:radio name="formInsertSite" id="formInsertSite" list="%{#{'0':getText('bbs.before'),'1':getText('bbs.after')}}" value="0" theme="simple"></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="formInsertSite" id="formInsertSite" list="%{#{'0':getText('bbs.before'),'1':getText('bbs.after')}}" theme="simple"></s:radio>
                            </s:else>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.CanPosted" />' class="td_lefttitle">  
                            <s:text name="bbs.CanbePosted" />：  
                        </td>  
                        <td colspan="3">  
                            <s:hidden name="classAddUserRange" id="classAddUserRange" />   
                            <s:textarea name="forumPO.classUserName" id="classUserName" rows="3" cssClass="inputTextarea" cssStyle="width:95%" readonly="true" ></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'classAddUserRange', allowName:'classUserName', select:'orgusergroup', single:'no', show:'orgusergroup', range:'*0*'});"></a>
                        </td>
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.Toseepeople" />' class="td_lefttitle">  
                            <s:text name="bbs.Toseepeople" />：  
                        </td>  
                        <td colspan="3">  
                            <s:hidden name="classViewUserRange" id="classViewUserRange" />  
                            <s:textarea name="forumPO.viewUserName" id="viewUserName" rows="3" cssClass="inputTextarea" cssStyle="width:95%" readonly="true" ></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'classViewUserRange', allowName:'viewUserName', select:'orgusergroup', single:'no', show:'orgusergroup', range:'*0*'});"></a><br/><span class="MustFillColor"><s:text name="bbs.Artificialspacethatcanviewallusers" /></span>
                        </td>
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.description" />' class="td_lefttitle">  
                            <s:text name="bbs.description" />：  
                        </td>  
                        <td colspan="3">  
                            <s:textarea name="forumPO.classRemark"  id="classRemark" rows="3" cssClass="inputTextarea" cssStyle="width:95%" whir-options="vtype:[{'maxLength':400}]" maxLength="400" ></s:textarea>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.Forbiddenprintingandcopy" />' class="td_lefttitle">  
                            <s:text name="bbs.Forbiddenprintingandcopy" />：  
                        </td>  
                        <td colspan="3">  
                            <s:if test="forumClassId==null || forumPO.banPrint==null">
                                <s:radio name="forumPO.banPrint" id="banPrint" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" value="0" theme="simple"></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="forumPO.banPrint" id="banPrint" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" theme="simple"></s:radio>
                            </s:else>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.opentime" />' class="td_lefttitle">  
                            <s:text name="bbs.opentime" />：  
                        </td>  
                        <td colspan="3">  
                            <s:if test="forumClassId==null || forumPO.fullDay==null">
                                <s:radio name="forumPO.fullDay" id="fullDay" list="%{#{'1':getText('bbs.allday'),'0':getText('bbs.hour')}}" value="1" theme="simple" onclick="showOpenPeriod(this.value);"></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="forumPO.fullDay" id="fullDay" list="%{#{'1':getText('bbs.allday'),'0':getText('bbs.hour')}}" theme="simple" onclick="showOpenPeriod(this.value);"></s:radio>
                            </s:else>
                            <s:hidden name="forumPO.startPeriod" id="startPeriod" />
                            <s:hidden name="forumPO.endPeriod" id="endPeriod" />
                        </td>  
                    </tr>
                    <tr id="tr_openPeriod">
                        <td >&nbsp;</td>
                        <td colspan="3">
                            <div>
                                <select name="startPeriod" class="selectlist" style="width:60px;" >
                                <%
                                    for(int i=0; i<24; i++){
                                        for(int j=0; j<2; j++){
                                            String period = (i<10?"0":"") + i + ":" + (j==0?"00":"30");
                                            String selected = (i==8 && j==1)?"selected":"";
                                %>
                                            <option value="<%=period%>" flag="<%=(i*2+j)%>" <%=selected%>><%=period%></option>
                                <%                                
                                        }
                                    }
                                %>
                                </select>
                                <s:text name="bbs.to" />
                                <select name="endPeriod" class="selectlist" style="width:60px;" >
                                <%
                                    for(int i=0; i<24; i++){
                                        for(int j=0; j<2; j++){
                                            String period = (i<10?"0":"") + i + ":" + (j==0?"00":"30");
                                            String selected = (i==18 && j==0)?"selected":"";
                                %>
                                            <option value="<%=period%>" flag="<%=(i*2+j)%>" <%=selected%>><%=period%></option>
                                <%                                
                                        }
                                    }
                                %>
                                </select>
                                <span class="openPeriod">
                                <img name="img_addPeriodRow" style="cursor:hand; width:12px; height:12px; border:0px;" src="<%=rootPath%>/images/addarrow.gif" onClick="addRow(this); " />
                                <img style="cursor:hand; width:12px; height:12px; border:0px;" src="<%=rootPath%>/images/delarrow.gif" onClick="delRow(this);" />
                                </span>
                            </div>
                        </td>
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.Postaudit" />' class="td_lefttitle">  
                            <s:text name="bbs.Postaudit" />：  
                        </td>  
                        <td colspan="3">  
                            <s:if test="forumClassId==null || forumPO.checkExamin==null">
                                <s:radio name="forumPO.checkExamin" id="checkExamin" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" value="0" theme="simple"></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="forumPO.checkExamin" id="checkExamin" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" theme="simple"></s:radio>
                            </s:else>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="bbs.Allowanonymous" />' class="td_lefttitle">  
                            <s:text name="bbs.Allowanonymous" />：  
                        </td>  
                        <td>  
                            <s:if test="forumClassId==null || forumPO.estopAnonymity==null">
                                <s:radio name="forumPO.estopAnonymity" id="estopAnonymity" list="%{#{'0':getText('bbs.Yes'),'1':getText('bbs.No')}}" value="0" theme="simple" onclick="showIsShowAnonymityOrg(this.value);"></s:radio>
                            </s:if>
                            <s:else>
                                <s:radio name="forumPO.estopAnonymity" id="estopAnonymity" list="%{#{'0':getText('bbs.Yes'),'1':getText('bbs.No')}}" theme="simple" onclick="showIsShowAnonymityOrg(this.value);"></s:radio>
                            </s:else>
                        </td>  
                        <td>
                            <span id="span_isShowAnonymityOrg">
                                <s:text name="bbs.Displayanonymousorganization" />：  
                                <s:if test="forumClassId==null || forumPO.isShowAnonymityOrg==null">
                                    <s:radio name="forumPO.isShowAnonymityOrg" id="isShowAnonymityOrg" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" value="0" theme="simple" onclick="showAnonymityOrg(this.value);"></s:radio>
                                </s:if>
                                <s:else>
                                    <s:radio name="forumPO.isShowAnonymityOrg" id="isShowAnonymityOrg" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" theme="simple" onclick="showAnonymityOrg(this.value);"></s:radio>
                                </s:else>
                            </span>
                        </td>
                    </tr>
                    <tr id="tr_isShowAnonymityOrg">
                        <td>&nbsp;</td>
                        <td colspan="3">
                            <s:text name="bbs.DisplayStartTime" />：<input type="text" class="Wdate whir_datebox" name="forumPO.showOrgStartDate" id="showOrgStartDate" value='<s:property value="%{formShowOrgStartDate}" />'  onclick="WdatePicker({el:'showOrgStartDate',isShowWeek:true, isShowClear:false, readOnly:true })"/>
                            <br />
                            <bean:message bundle="bbs" key="bbs.Displaythelevelofanonymousorganization" />：
                            <br />
                            <s:hidden name="forumPO.anonymityShowOrgIds" id="anonymityShowOrgIds" />
                            <s:textarea name="forumPO.anonymityShowOrgNames" id="anonymityShowOrgNames" rows="3" cssClass="inputTextarea" cssStyle="width:95%" readonly="true"></s:textarea><a href="javascript:void(0);" class="selectIco textareaIco" onclick="openSelect({allowId:'anonymityShowOrgIds', allowName:'anonymityShowOrgNames', select:'org', single:'no', show:'org', range:'*0*'});"></a>
                        </td>
                    </tr>
                    <tr class="Table_nobttomline">   
                        <td>&nbsp;</td>
                        <td>
                            <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(0,this);}" value='<s:text name="comm.saveclose"/>' />
                            <s:if test="forumClassId==null" >
                                <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(1,this);}" value='<s:text name="comm.savecontinue"/>' />
                            </s:if>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
                        </td>  
                    </tr>  
                </table>  