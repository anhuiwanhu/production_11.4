<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.portal.bd.*"%>
<%@ page import="com.whir.ezoffice.portal.po.*"%>
<%@ page import="com.whir.ezoffice.portal.vo.*"%>
<%@ page import="com.whir.ezoffice.portal.cache.*"%>
<%@ page import="com.whir.ezoffice.portal.common.util.*"%>
<%
ConfMap confMap = (ConfMap)request.getAttribute("confMap");

String limitNum = confMap.get("limitNum");
String limitChar = confMap.get("limitChar");
String charEncode = confMap.get("charEncode");
if(charEncode==null || "".equals(charEncode)){
	charEncode = "UTF-8";
}
String rssSource = confMap.get("rssSource");
if(rssSource==null || ",".equals(rssSource)){
	rssSource = "";
}
String []source=null;
if(null!=rssSource && !"".equals(rssSource)){
	rssSource = rssSource.replaceAll("%26","&" );
	source = rssSource.split(",");
}
//初始化默认值
if(limitNum==null||"".equals(limitNum)||"null".equals(limitNum)){
    limitNum = "5";//默认记录数
}
%>
<tr>
    <th><em>页面编码：</em></th>
    <td colspan="3">
        <div class="wh-choose-info-box">
            <span><input type="radio" name="charEncode" value="GBK" <%="GBK".equals(charEncode) ? "checked" : "" %>/>GBK</span>
        </div>
        <div class="wh-choose-info-box">
            <span><input type="radio" name="charEncode" value="UTF-8" <%="UTF-8".equals(charEncode) ? "checked" : "" %>/>UTF-8</span>
        </div>
    </td>
</tr>
<tr>
    <th><em>RSS地址：</em></th>
    <td colspan="3">
        <form id="rssAddress">
            <div class="wh-choose-rss"><input type="url" name="rssSource" value="<%=source==null ? "" : source[0] %>" class="wh-choose-input-wid"><i class="fa fa-plus wh-rss-plus" onclick="add()"></i></div>
            <% 
            if(source!=null){
             for(int i=1;i<source.length;i++){
            %>
            <script>
            	var flag = document.getElementById("rssAddress").getElementsByTagName("div").length;
            	flag++;
            	var div = document.createElement("div");
				div.setAttribute("id", "addcontent"+flag);
				div.setAttribute("class","wh-choose-rss");
				document.getElementById('rssAddress').appendChild(div);
				var input = document.createElement("input");
				input.setAttribute("type", "url");
				input.setAttribute("name", "rssSource");
				input.setAttribute("class", "wh-choose-input-wid");
				input.setAttribute("value", "<%=source[i] %>");
				document.getElementById("addcontent"+flag).appendChild(input);
				var i = document.createElement("i");
				i.setAttribute("data", "addcontent"+flag);
				i.setAttribute("class", "fa fa-minus wh-rss-minus");
				i.setAttribute("onclick", "removeDiv(this)");
				document.getElementById("addcontent"+flag).appendChild(i);
            </script>
            <!--<div><input type="url" name="rssSource" value="<%=source[i] %>" class="wh-choose-input-wid"><i class="fa fa-minus wh-rss-minus" onclick="remove(this)"></i></div>
        	--><%}} %>
        </form>
    </td>
</tr>
<tr>
    <th><em>列表字数限制：</em></th>
    <td>
        <div class="wh-choose-input">
            <input type="text" id="limitChar" name="limitChar" maxlength="2" data-maxval="25" data-minval="1" class="wh-choose-input-wid" value="<%=limitChar%>"/>
        </div>
    </td>
	<th><em>信息条数：</em></th>
    <td>
        <div class="wh-choose-input-w-box">
            <i class="fa fa-plus wh-pic-num-plus" onClick="setAmount.max=20;setAmount.add('#limitNum')"></i>
                 <input type="text" class="wh-choose-input-num wh-backstage-pic-num" id="limitNum" name="limitNum" value="<%=limitNum%>" data-maxval="20" data-minval="1" maxlength="2"/>
			<i class="fa fa-minus wh-pic-num-minus" onClick="setAmount.min=1;setAmount.reduce('#limitNum')"></i>
        </div>
    </td>
</tr>
<script>
	function add(){
		var flag = document.getElementById("rssAddress").getElementsByTagName("div").length;
		flag++;
		if(document.getElementById("rssAddress").getElementsByTagName("div").length==4){
			whir_alert("最多可添加4个RSS站点");
			return;
		}
		if(document.getElementById("rssAddress").getElementsByTagName("div").length<4){
			var div = document.createElement("div");
			div.setAttribute("id", "addcontent"+flag);
			div.setAttribute("class","wh-choose-rss");
			document.getElementById('rssAddress').appendChild(div);
			var input = document.createElement("input");
			input.setAttribute("type", "url");
			input.setAttribute("name", "rssSource");
			input.setAttribute("class", "wh-choose-input-wid");
			input.setAttribute("value", "");
			document.getElementById("addcontent"+flag).appendChild(input);
			var i = document.createElement("i");
			i.setAttribute("data", "addcontent"+flag);
			i.setAttribute("class", "fa fa-minus wh-rss-minus");
			i.setAttribute("onclick", "removeDiv(this)");
			document.getElementById("addcontent"+flag).appendChild(i);
		}
	}
	
	function removeDiv(obj){
		var iNode = $(obj).attr("data");
		var node = document.getElementById(iNode);
		node.parentNode.removeChild(node);
	}
</script>