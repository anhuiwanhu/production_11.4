<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.whir.org.bd.SelectForWorkFlow" %>
<%@ page import="com.whir.i18n.Resource" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);


String treeKey  = request.getParameter("treeKey")!=null?request.getParameter("treeKey"):"1";
String treeRange = request.getParameter("treeRange")!=null?request.getParameter("treeRange"):"";
String leader_type = request.getParameter("leader_type")!=null?request.getParameter("leader_type"):"";
String part_timer = request.getParameter("part_timer")!=null?request.getParameter("part_timer"):"false";

String tree_userAgent = request.getHeader("User-Agent")+"";
String local = session.getAttribute("org.apache.struts.action.LOCALE").toString();


%>
<style>
/* .level0{  display:inline; float:left; margin-right:8px; white-space:nowrap; line-height:25px;}
 .level0{ text-align:center; line-height:25px; display:block; } 
 display:inline-block .level0{padding:0; margin:0; list-style:none; line-height:14px; text-align:left; white-space:nowrap; outline:0}
.ztree li{padding:0; margin:0 1px 2px 0; list-style:none; line-height:14px;  min-width:114px;  text-align:left; white-space:nowrap;overflow:hidden; outline:0;display:inline-block;}*/

<%if(false&&(treeRange.indexOf("*")<0 && treeRange.indexOf("@")<0)&&(tree_userAgent.indexOf("MSIE 10")>=0||tree_userAgent.indexOf("MSIE 9")>=0||tree_userAgent.indexOf("MSIE 8")>=0||tree_userAgent.indexOf("MSIE 7")>=0)){%>
.ztree li{padding:0; margin:0 1px 2px 0; list-style:none; line-height:14px;  text-align:left; white-space:nowrap; outline:0;min-width:114px;display:inline-block;}
<%}%>
</style>
<table border="0" width="100%" align="center" style="margin-top:18px;table-layout:fixed;">
<tr>
<td width="3%">
&nbsp;
</td>
<td width="38%">

	<div  id="left_div<%=treeKey%>"  style="border:solid 1px #ededed;height:250px;overflow-y:auto;"   >
			<ul id="tree<%=treeKey%>" class="ztree"></ul>
	</div>
</td>
<td width="20%" >
	<div style="height:150px;text-align:center;line-height:20px;margin-left:5px;">
			</br>
			<%
			if(!treeRange.equals("")){
			if(treeRange.indexOf("*")<0 && treeRange.indexOf("@")<0 ){%>
			<input type="button" value="<%=Resource.getValue(local,"workflow","workflow.AddAll")%>" class="btnButton6font" onclick="addAllOption<%=treeKey%>();"></br></br>
			<%}%>
			<% if(treeRange.indexOf("*")<0 && treeRange.indexOf("$")<0 && treeRange.indexOf("@")>=0 ){
			%>
			<input type="button" value="<%=Resource.getValue(local,"workflow","workflow.AddAll")%>" class="btnButton6font" onclick="groupaddAllOption<%=treeKey%>();"></br></br>
			<%}%>
			<input type="button" value="<%=Resource.getValue(local,"common","comm.delete")%>"  class="btnButton6font" onclick="removeOption<%=treeKey%>();"></br></br>
			<input type="button" value="<%=Resource.getValue(local,"workflow","workflow.deleteall")%>" class="btnButton6font"   onclick="removeAllOption<%=treeKey%>();">
			<%}%>
	</div>
</td>
<td style="width:35%;height:250px;">

		<select ondblclick="removeOption<%=treeKey%>();" id="select<%=treeKey%>" multiple style="width:150px;height:250px;margin-top:-1px" ></select>

</td>
<td>&nbsp;</td>
</tr>
</table>
<div style="clear:both"></div>

      <SCRIPT type="text/javascript">
		
		<!--

		var setting<%=treeKey%> = {
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {	
				onDblClick:onDblClick<%=treeKey%>,
				onClick:onClick<%=treeKey%>,
				onExpand:onExpand<%=treeKey%>,
				onAsyncSuccess:autoAdd<%=treeKey%>
				
			},
			view: {
				fontCss: getFont<%=treeKey%>,
				nameIsHTML: true,
				dblClickExpand:false,
				selectedMulti: false
			},
			async: {
				enable: true,
				url:"<%=rootPath%>/public/treeselectcode/getNodes.jsp",
				autoParam:["id", "code", "selectType"],
				otherParam:{"range":"<%=treeRange%>","leader_type":"<%=leader_type%>","part_timer":"<%=part_timer%>"},
				dataFilter: filter
			}
		};

		function filter(treeId, parentNode, childNodes) {
			if (!childNodes) return null;
			for (var i=0, l=childNodes.length; i<l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
			}
			return childNodes;
		}
		


		function onDblClick<%=treeKey%>(event, treeId, treeNode, clickFlag){	
			var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
			var leader_type = '<%=leader_type%>';
			/**
			if(treeNode.font!= undefined){				
				zTree.cancelSelectedNode(treeNode);
				if(treeNode.isParent){
				   zTree.expandNode(treeNode, true, null, null, null);
				}
				return false;
			}*/		
				
			if(treeNode.selectType=="org"){
				if(treeNode.isParent){
					//if(!treeNode.open){
					//	zTree.expandNode(treeNode, true, null, null, true);
					//}else{
					//	zTree.expandNode(treeNode, false, null, null, null);
					//}				
					//return false;
				}
				if(leader_type != ''){
					isExistLeader<%=treeKey%>(leader_type,event, treeId, treeNode, clickFlag);
					return false;
				}
			}else if(treeNode.selectType=="user"){
				isExist<%=treeKey%>(event, treeId, treeNode, clickFlag);
			}
		
		}


		function onClick<%=treeKey%>(event, treeId, treeNode, clickFlag) {	
			var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
			var leader_type = '<%=leader_type%>';
			if(treeNode.isParent){
				if(!treeNode.open){
					zTree.expandNode(treeNode, true, null, null, true);
				}else{
					zTree.expandNode(treeNode, false, null, null, null);
				}				
			}
			if(treeNode.selectType=="org"){
				if(leader_type != ''){
					isExistLeader<%=treeKey%>(leader_type,event, treeId, treeNode, clickFlag);
					return false;
				}
			}else if(treeNode.selectType=="user"){
				isExist<%=treeKey%>(event, treeId, treeNode, clickFlag);
			}
		
		}	
		
		//无子节点则取消parent身份，不显示空白.
		function onExpand<%=treeKey%>(event, treeId, treeNode, clickFlag) {	
			var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
			var b = treeNode.children!=undefined && treeNode.children!='undefined' && treeNode.children!=null && treeNode.children!='' ;
			if(!b){
				zTree.expandNode(treeNode, false, null, null, null);
				treeNode.isParent = false;
				zTree.updateNode(treeNode,false);
			}			
		}	
		
		function isExist<%=treeKey%>(event, treeId, treeNode, clickFlag) {			
			var exist = false;
			$('#select<%=treeKey%> option').each(function(){    
				if( $(this).val() == treeNode.id){        
					exist = true ;
				}
			});
			if(!exist){
				var isSingle="no"; 
                if ($.isFunction(window.judgeIsSingleUser)){
			         isSingle=judgeIsSingleUser();
			    }   
				if(isSingle=="yes"){
                    var len=$('#select<%=treeKey%> option').length;
				    if(len>0){
					   whir_alert("审批方式为单人不能选择多个办理人！");
					   return ;
					}
				}	
				var html = "<option code='"+treeNode.code+"' value='"+treeNode.id+"'>"+treeNode.name+"</option>";
				$("#select<%=treeKey%>").append(html);
			}
		}	
		
		String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
			 if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
				 return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi": "g")), replaceWith);
			} else {
				 return this.replace(reallyDo, replaceWith);
			 }
		}

		function isExistLeader<%=treeKey%>(leader_type,event, treeId, treeNode, clickFlag) {	
			var leader_ids = treeNode.manage_leader_id;
			if(leader_type=='charger'){
				leader_ids = treeNode.charge_leader_id;
			}
			if(leader_ids==''){
				if(leader_type=='charger'){
					whir_alert("分管领导不存在！",function(){});
				}else{
					whir_alert("部门领导不存在！",function(){});
				}
				return false;
			}
			leader_ids = leader_ids.replaceAll("\\\$\\\$",",").replaceAll("\\\$","");
			var json_str = $.ajax({
								  url: '<%=rootPath%>/public/treeselectcode/getLeaderJson.jsp?leader_ids='+leader_ids+'&date='+Math.random(),
								  async: false
							 }).responseText;
			var json = eval(json_str);
			
			for(var i=0;i<json.length;i++){
				var exist = false;
				$('#select<%=treeKey%> option').each(function(){    
					if( $(this).val() == json[i].id){        
						exist = true ;
					}
				});
				if(!exist){
					var html = "<option code='"+json[i].code+"' value='"+json[i].id+"'>"+json[i].name+"</option>";
					$("#select<%=treeKey%>").append(html);
				}				
			}
		}	

		function removeOption<%=treeKey%>(){
			$('#select<%=treeKey%> option').each(function(){    
				if( $(this).attr("selected") == "selected"){        
					$(this).remove();
				}
			});
		}

		function removeAllOption<%=treeKey%>(){
			$('#select<%=treeKey%> option').each(function(){    
					$(this).remove();
			});
		}
		
		function addAllOption<%=treeKey%>(){ 
			
			var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
			var nodes = zTree.getNodes();
		    if(nodes.length>1){
				var isSingle="no"; 
				if ($.isFunction(window.judgeIsSingleUser)){
					 isSingle=judgeIsSingleUser();
				}   
				if(isSingle=="yes"){ 
				     whir_alert("审批方式为单人不能选择多个办理人！");
					 return ; 
				}	
			}
            removeAllOption<%=treeKey%>();

			for(var i=0;i<nodes.length;i++){
				var html = "<option code='"+nodes[i].code+"' value='"+nodes[i].id+"'>"+nodes[i].name+"</option>";
				$("#select<%=treeKey%>").append(html);
			}			
		}


		function getFont<%=treeKey%>(treeId, node) {
			return node.font ? node.font : {};
		}

		$(document).ready(function(){
			$.fn.zTree.init($("#tree<%=treeKey%>"), setting<%=treeKey%>);
			//jQuery('#left_div<%=treeKey%>').jScrollPane({showArrows:true,contentWidth:200});
		});


		function getTree<%=treeKey%>Ids(){
		    var ids = "";
			$('#select<%=treeKey%> option').each(function(){    
				ids += $(this).val()+",";
			});
			return ids;
		}
		function getTree<%=treeKey%>Names(){
		    var names = "";
			$('#select<%=treeKey%> option').each(function(){    
				names += $(this).text()+",";
			});
			return names;
		}
		function getTree<%=treeKey%>Codes(){
		    var codes = "";
			$('#select<%=treeKey%> option').each(function(){    
				codes += $(this).attr("code")+",";
			});
			return codes;
		}
		

		function autoAdd<%=treeKey%>(event, treeId, treeNode, msg){
			<% if(treeRange.indexOf("*")<0 && treeRange.indexOf("@")<0 ){%>
					var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
					var nodes = zTree.getNodes();
					if(nodes.length ==1){
						addAllOption<%=treeKey%>();
						parentAutoDeal();
					}			
			<%}%>
			//只有一个群组时默认展开，且当这个群组只有一个成员时默认选中到右边
			<% if(treeRange.indexOf("*")<0 && treeRange.indexOf("$")<0 && treeRange.indexOf("@")>=0 ){
				String r = treeRange.substring(treeRange.indexOf("@")+1,treeRange.lastIndexOf("@"));
				if(r.indexOf("@")<0){
			%>
					var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
					var nodes = zTree.getNodes();
					if(nodes.length ==1){						
						if(nodes[0].isParent){
							zTree.expandNode(nodes[0], true, null, null, true);
						}
					}		
					
					if(nodes.length>0 && nodes[0].isParent &&  nodes[0].children!=undefined && nodes[0].children.length==1){		
						 isExist<%=treeKey%>(event, treeId, (nodes[0].children)[0], null);
						 parentAutoDeal();
					}
			<%}}%>
            
			<% if(treeRange.indexOf("*")>=0 && treeRange.indexOf("$")<0 && treeRange.indexOf("@")<0 ){
				String r = treeRange.substring(treeRange.indexOf("*")+1,treeRange.lastIndexOf("*"));
				//只有一个组织时
				if(r.indexOf("*")<0){ 
		    %>
				var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
			    singleExpanNode(zTree,null); 
			<% }}%> 
		}
        
		/**自动打开单一下子节点*/
	    function singleExpanNode(zTree, node){
			var newNode=null;
			if(node==null){
				 var nodes = zTree.getNodes();
				 var nodes = zTree.getNodes();
				 if(nodes.length ==1){	
					 newNode=nodes[0];
					 if(newNode.isParent){
						 zTree.expandNode(newNode, true, null, null, true);   
						 singleExpanNode(zTree,newNode);
					 }
				}		
			}else{
				var childrenNodes =node.children;
				if (childrenNodes) { 
					 if(childrenNodes.length==1){
						 newNode=childrenNodes[0];
						 if(newNode.isParent){
						     zTree.expandNode(newNode, true, null, null, true); 
							 singleExpanNode(zTree,newNode);
						 }
					 } 
				}  
			} 
		}


		function groupaddAllOption<%=treeKey%>(){
			var treeId = "tree<%=treeKey%>" ;
			var zTree = $.fn.zTree.getZTreeObj("tree<%=treeKey%>");
		    var nodes = zTree.getSelectedNodes();
			for(var i=0;i<nodes.length;i++){
				var type = nodes[i].selectType;
				if(type=='group'){
					var children = nodes[i].children;
					for(var k=0;k<children.length;k++){
						isExist<%=treeKey%>(null, treeId, children[k], null);
					}
				}				
			}			
		}

		function  parentAutoDeal(){
		      if ($.isFunction(window.dealAfterTreeAuto)){
			          dealAfterTreeAuto();
			    } 
		}

		//-->
	</SCRIPT>