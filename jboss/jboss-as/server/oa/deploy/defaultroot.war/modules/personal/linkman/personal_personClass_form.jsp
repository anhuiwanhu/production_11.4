                
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <s:hidden name="personPO.id" id="id" />
                    <s:if test="classType=='public'">
                        <s:hidden name="personPO.classType" id="classType" value="1" />
                    </s:if>
                    <s:else>
                        <s:hidden name="personPO.classType" id="classType" value="0" />
                    </s:else>
                    <!-- Main Part Start -->
                    <tr>
                        <td for='<s:text name="pubcontact.categoryname"/>' class="td_lefttitle" width="60px">
                            <s:text name="pubcontact.categoryname"/><span class="MustFillColor">*</span>：
                        </td>
                        <td>
                            <s:textfield name="personPO.className" id="className" cssClass="inputText" whir-options="vtype:['notempty',{'maxLength':25}, 'spechar3']" maxLength="25" /> 
                        </td>
                    </tr>
                    <tr>  
                        <s:if test="personClassId!=null">
                            <s:hidden name="formOrderCodeFlag" id="formOrderCodeFlag" value="0" />
                        </s:if>
                        <td for='<s:text name="pubcontact.Category"/>' class="td_lefttitle">  
                            <s:text name="pubcontact.Category"/>：  
                        </td>  
                        <td >  
                            <s:if test="personClassId!=null">
                                <s:hidden id="classParentIdOld" value="%{personPO.classParentId}" /> 
                            </s:if>
                            <select name="personPO.classParentId" id="classParentId" class="easyui-combobox" style="width:300px;" data-options="  selectOnFocus:true,onSelect: function(record){loadClassSiblingList(record);}, editable:false">
                                <s:iterator var="obj" value="#request.classParentList" >
	                                
	                                    <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
	                               
                                </s:iterator>
                            </select>
                        </td>  
                    </tr>
                    <tr>  
                        <td for='<s:text name="pubcontact.Sort"/>' class="td_lefttitle">  
                            <s:text name="pubcontact.Sort"/>：  
                        </td>  
                        <td>  
                            <s:if test="personClassId!=null">
                                <s:hidden id="formInsertReferIdOld" value="%{formInsertReferId}" /> 
                            </s:if>
                            <select name="formInsertReferId" id="formInsertReferId" class="easyui-combobox" style="width:300px;" data-options="selectOnFocus:true, valueField:'id', textField:'text', editable:false">
                                <s:iterator var="obj" value="#request.classSiblingList" >
	                                <s:if test="#obj[0]!=-1">
	                                    <option value="<s:property value='#obj[0]'/>" ><s:property value='#obj[1]' escape="false"/></option>
	                                 </s:if>
                                </s:iterator>
                            </select>&nbsp;&nbsp;
                            <s:if test="personClassId==null">
                                <s:radio name="formInsertSite" id="formInsertSite" list="%{#{'0':getText('pubcontact.Forward'),'1':getText('pubcontact.Afterward')}}" value="0" theme="simple"></s:radio>
                            </s:if>
                            <s:else>
                                <s:hidden id="formInsertSiteOld" value="%{formInsertSite}" />  
                                <s:radio name="formInsertSite" id="formInsertSite" list="%{#{'0':getText('pubcontact.Forward'),'1':getText('pubcontact.Afterward')}}" theme="simple"></s:radio>
                            </s:else>
                        </td>  
                    </tr>
                    <tr>
                        <td for='<s:text name="pubcontact.description"/>' class="td_lefttitle">
                            <s:text name="pubcontact.description"/>：
                        </td>
                        <td>
                            <s:textarea name="personPO.classDescribe" id="classDescribe" cssClass="inputTextarea" cssStyle="width:98%" rows="4" whir-options="vtype:[{'maxLength':100}, 'spechar3']" maxLength="100" ></s:textarea>
                        </td>
                    </tr>
                    <!-- Main Part End   -->
                    <tr class="Table_nobttomline"> 
                        <td >&nbsp;</td> 
                        <td nowrap>
                            <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(0,this);}" value='<s:text name="comm.saveclose"/>' />
                            <s:if test="personClassId==null" >
                                <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(1,this);}" value='<s:text name="comm.savecontinue"/>' />
                            </s:if>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
                        </td>  
                    </tr>
                </table>  