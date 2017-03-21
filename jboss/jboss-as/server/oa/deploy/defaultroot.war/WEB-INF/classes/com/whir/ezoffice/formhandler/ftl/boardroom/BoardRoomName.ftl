<#--
/* $Id: Test.ftl 2014-01-17 17:12:24Z w3 $
 *
 * 会议自定义字段显示模板（v1.0）
 *
 * 会议室名称，会议室更换主要是更换点数、地点，设备
 */
-->
<#if dataMap.boardroomApplyId?exists && dataMap.boardroomApplyId != '' && dataMap.boardroomApplyId != 'null'>
	<input type="text" name="boardroomName"  value="<#if dataMap.boardroomName?exists>${dataMap.boardroomName}</#if>" readonly="readonly" id="boardroomName" class="inputText" style="width:88%;"/>
	<input type="hidden" name="boardroomId"  id="boardroomId" value="<#if dataMap.boardroomId?exists>${dataMap.boardroomId}</#if>">
<#else>
	<input type="button" class="btnButton6font" onClick="searchBoardroom();" value='搜索会议室'/>
	<#assign modifyField=requestAttribute.p_wf_cur_ModifyField>
	<#if ui.operateType== 2>
		<#assign modifyField=''>
	</#if>
	<span id="_boardrooms">
		<select name="boardroomId" id="boardroomId" 
		whir-options="vtype:['notempty']" class="selectlist"  
		onChange="changeBoardRoom();" style="width:50%;" <#if modifyField?exists && modifyField != '' && modifyField != 'null' && modifyField?contains("$boardroomid$")><#else>disabled</#if>>
			<#if dataMap.boardRoomList?exists>
				<#assign maps=dataMap.boardRoomList> 
				<#assign keys=maps?keys> 
				<#list keys  as key>                                       
					<option value="${key}" <#if key == dataMap.boardroomId>selected</#if>>${maps[key]}</option>
				</#list>  
			</#if>
		</select>
	</span>
	<span class="MustFillColor">根据容纳人数、时间、设备搜索符合要求的会议室。</span>
	<#if modifyField?exists && modifyField != '' && modifyField != 'null' && modifyField?contains("$boardroomid$")>
	<#else>
		<input type="hidden" name="boardroomId"  id="boardroomId" value="<#if dataMap.boardroomId?exists>${dataMap.boardroomId}</#if>">
	</#if>
</#if>

<input type="hidden" name="isVideo"  id="isVideo" value="<#if dataMap.isVideo?exists>${dataMap.isVideo}</#if>">
<#if dataMap.mailForm?exists>
<input type="hidden" name="mailForm"  id="mailForm" value="<#if dataMap.mailForm?exists>${dataMap.mailForm}</#if>">
</#if>
<#if dataMap.meetingId?exists>
<input type="hidden" name="meetingId"  id="meetingId" value="<#if dataMap.meetingId?exists>${dataMap.meetingId}</#if>">
</#if>
<#if dataMap.isView?exists>
<input type="hidden" name="isView"  id="isView" value="<#if dataMap.isView?exists>${dataMap.isView}</#if>">
</#if>
<#if dataMap.executeStatus?exists>
<input type="hidden" name="executeStatus"  id="executeStatus" value="<#if dataMap.executeStatus?exists>${dataMap.executeStatus}</#if>">
</#if>
<#if dataMap.fromAdr?exists>
<input type="hidden" name="fromAdr"  id="fromAdr" value="<#if dataMap.fromAdr?exists>${dataMap.fromAdr}</#if>">
</#if>
