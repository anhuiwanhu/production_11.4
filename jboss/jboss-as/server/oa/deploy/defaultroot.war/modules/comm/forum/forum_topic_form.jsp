                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <s:hidden id="forumClassIdOld" value="%{forumClassId}" name="forumClassIdOld"/> 
                    <s:if test="forumId==null" >
                        <input type="hidden" id="actionType" value="add" />
                        <tr>  
                            <td for='<s:text name="bbs.Column" />' class="td_lefttitle" width="70px" >  
                                <s:text name="bbs.Column" /><span class="MustFillColor">*</span>：  
                            </td>  
                            <td id="test_classParent" colspan="3" >
                                <s:hidden id="hasAddRight" value="%{#request.hasAddRight}" />  
                                <select name="forumClassId" id="forumClassId" class="easyui-combobox" style="width:300px;" data-options="onSelect: function(record){changeForumClass(record);}, editable:false">
                                    <option value="0">--<s:text name="bbs.Pleaseselect" />--</option>
                                    <s:iterator var="obj" value="#request.classList_addRange" >
                                        <option value="<s:property value='#obj[0]'/>" estopAnonymity="<s:property value='#obj[4]'/>" ><s:property value='#obj[1]' escape="false"/></option>
                                    </s:iterator>
                                </select>
                                <input type="button" class="btnButton4font" onClick="tmp_uaMatch();" style="display:none;" value='检测浏览器' />
                            </td>  
                        </tr>
                    </s:if>
                    <s:else>
                        <input type="hidden" id="actionType" value="modi" />
                    </s:else>
                    <tr>  
                        <td for='<s:text name="bbs.title" />' class="td_lefttitle">  
                            <s:text name="bbs.title" /><span class="MustFillColor">*</span>：  
                        </td>  
                        <td colspan="3">  
                            <s:hidden name="forum.id" id="id" />  
                            
                            <s:textfield name="forum.forumTitle" id="forumTitle" cssClass="inputText" cssStyle="width:98%;" whir-options="vtype:['notempty', {'maxLength':50}, 'spechar3'], 'promptText':'%{getText('bbs.tipPleaseEnterTheTitle')}'" maxLength="50" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="bbs.attachment" />' class="td_lefttitle">  
                            <s:text name="bbs.attachment" />：
                        </td>  
                        <td colspan="3">
                            <s:hidden name="formAttachRealName" id="formAttachRealName"/>
                            <s:hidden name="formAttachSaveName" id="formAttachSaveName"/>
                            <jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true"> 
                               <jsp:param name="dir" value="forum" />
                               <jsp:param name="uniqueId" value="forum" />
                               <jsp:param name="realFileNameInputId" value="formAttachRealName" />
                               <jsp:param name="saveFileNameInputId" value="formAttachSaveName" />
                               <jsp:param name="canModify" value="yes" />
                               <jsp:param name="uploadLimit" value="10" />
                            </jsp:include>
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="bbs.expression" />' class="td_lefttitle">  
                            <s:text name="bbs.expression" />：
                        </td>  
                        <td colspan="3" style="padding-bottom:8px;">
                            <%@ include file="include_face.jsp"%>
                        </td>
                    </tr>  
                    <tr>  
                        <td for='<s:text name="bbs.text" />' class="td_lefttitle">  
                            <s:text name="bbs.text" />：
                        </td>  
                        <td colspan="3">
                            <s:hidden name="forum.forumContent" id="forumContent" />  
                            <iframe id="ewebeditorIFrame" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=forum.forumContent&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="98%" height="350"></iframe>
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="bbs.licenserequirements" />' class="td_lefttitle">  
                            <s:text name="bbs.licenserequirements" />：
                        </td>  
                        <td>
                            <s:hidden id="userNickName" value="%{#request.userNickName}"/>
                            <s:hidden name="forum.nickName" id="nickName" value="%{#request.userNickName}" />
                            <s:if test="forumId==null">
                                <s:hidden name="forum.anonymous" id="anonymous" value="0" />
                            </s:if>
                            <s:else>
                                <s:hidden name="forum.anonymous" id="anonymous" />
                            </s:else>
                            <s:hidden id="h_eStopAnonymity" value="%{#request.eStopAnonymity}" />
                            
                            <input type="radio" name="anonymous" id="anonymous0" value="0" onclick="changeAnonymous(0);"/><label for="anonymous0"><s:text name="bbs.realname" /></label>
                            <span id="span_anonymous1">
                                <input type="radio" name="anonymous" id="anonymous1" value="1" onclick="changeAnonymous(1);"/><label for="anonymous1"><s:text name="bbs.anonymity" /></label>
                            </span>
                            <input type="radio" name="anonymous" id="anonymous2" value="2" onclick="changeAnonymous(2);"/><label for="anonymous2"><s:text name="bbs.nickname" /></label>
                            <span id="useUserNickNameTip" style="color:green;"></span>
                        </td>   
                        <td colspan="2">
						    <s:text name="bbs.psignature" />：
                            <s:hidden name="forum.forumSign" id="forumSign" />
                            <s:hidden id="userSignature" value="%{#request.userSignature}"/>
                            <s:radio name="isUseUserSignature" list="%{#{'1':getText('bbs.Yes'),'0':getText('bbs.No')}}" theme="simple" onclick="changeUserSignature(this.value);"></s:radio>
                        </td>  
                    </tr>  
                    <tr id="tr_userSignature" style="display:none;">
                        <td >&nbsp;</td>  
                        <td colspan="3" style="word-break: break-all; word-wrap:break-word;">
                        <%
                            String userSignature = request.getAttribute("userSignature")==null?"":request.getAttribute("userSignature").toString();
                            userSignature = com.whir.component.util.StringUtils.resizeImgSize(userSignature, "650", "100");
                        %>
                            <s:text name="bbs.yourPersonalizedSignature" />：<%=userSignature%>
                        </td>  
                    </tr>  
                    <tr class="Table_nobttomline">  
                        <td>&nbsp;</td>
                        <td colspan="3" nowrap>
                            <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(0,this);}" value='<s:text name="comm.saveclose"/>' />
                            <s:if test="forumId==null" >
                                <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(1,this);}" value='<s:text name="comm.savecontinue"/>' />
                            </s:if>
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
                            <input type="button" class="btnButton4font" onClick="closeWindow(null);" value='<s:text name="comm.exit"/>' />
                        </td>  
                    </tr>  
                </table>  