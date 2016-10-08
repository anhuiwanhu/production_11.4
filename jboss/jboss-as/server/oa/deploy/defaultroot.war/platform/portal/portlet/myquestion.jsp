<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%@ page import="java.util.*"%>
<%@ page import="com.whir.ezoffice.zhidao.bd.KnowIndexBD"%>
<%@ page import="com.whir.ezoffice.portal.bd.PortletBD"%>
<%@ page import="com.whir.ezoffice.portal.cache.ConfMap"%>
<%@ page import="com.whir.ezoffice.knowledge.po.ExpertPO"%>
<%@ page import="com.whir.ezoffice.knowledge.bd.ExpertBD"%>
<%
response.setContentType("text/html; charset=UTF-8");
String portletSettingId = request.getParameter("portletSettingId");
PortletBD pbd = new PortletBD();
ConfMap confMap = pbd.getConfMap(portletSettingId);
String limitNum = confMap.get("limitNum");
String limitChar = confMap.get("limitChar");
int limitCharInt=20;
if(limitChar==null||"".equals(limitChar)||"undefined".equals(limitChar)){
   limitCharInt=20;
}else{
   limitCharInt=Integer.parseInt(limitChar);
}
String userId = session.getAttribute("userId").toString();
//多个页签展示，此处是以原来我的提问表单修改而来
String personInfomationValue = confMap.get("personInfomationValue"); 
String myKnowValue = confMap.get("myKnowValue"); 
String myAnswerValue = confMap.get("myAnswerValue"); 
String otherQuestinValue = confMap.get("otherQuestinValue");  

//我的提问
List askList = new KnowIndexBD().getMyQuestionList(userId,limitNum);

//个人信息
com.whir.org.bd.usermanager.UserBD _ubd = new com.whir.org.bd.usermanager.UserBD();
String _userphoto = _ubd.getUserPhoto(userId);
String _userImage = "/defaultroot/images/p1.jpg";
if(_userphoto!=null&&!"".equals(_userphoto)&&!"null".equals(_userphoto)){
    String _userphoto_f = _userphoto.substring(0, _userphoto.lastIndexOf("."));
    String __userphoto_ext = _userphoto.substring(_userphoto.lastIndexOf("."));
    _userImage = preUrl + "/upload/peopleinfo/" + _userphoto_f + "_middle" + __userphoto_ext;
}
String userName = session.getAttribute("userName").toString();
Map map = new KnowIndexBD().getMyCount(userId);
ExpertPO po = new ExpertBD().loadByUserId(userId,null);
boolean isExpert = false;
if(po!=null){
	isExpert = true;
}
//我的回答
List answerList = new KnowIndexBD().getMyAnswerList(userId,limitNum);
//他人求助
List otherHelpList = new KnowIndexBD().getOtherHelpList(userId,limitNum);
String orgName = session.getAttribute("orgName").toString();
%>
 <div class="wh-portal-info-content">
	<div class="wh-portal-slide02">
		<ul class="clearfix">
		<%if("1".equals(confMap.get("personInfomationValue"))){%>
			 <li>
				<div class="wh-portal-personal-info clearfix">
				<div class="wh-p-person-header">
					<a><img src="<%=_userImage%>" alt="" class="wh-portal-personal-img"/></a>
					<a class="wh-p-person-job" title="<%=orgName%>"><%=orgName%></a>
				</div>
				<div class="wh-p-person-info">
					<h3><a><%=userName%></a></h3>			 
					<em><a href="javascript:void(0)"  onclick="jumpnew('<%=rootPath%>/classSet!menu.action','<%=rootPath%>/question!myQuestionList.action')" >我的提问：<%=map.get("count_tw")%></a></em>
					<em><a href="javascript:void(0)"  onclick="jumpnew('<%=rootPath%>/classSet!menu.action','<%=rootPath%>/question!myAnswerList.action')" >我的回答：<%=map.get("count_hd")%></a></em>
					<em><a href="javascript:void(0)"  onclick="jumpnew('<%=rootPath%>/classSet!menu.action','<%=rootPath%>/question!otherHelpList.action')" >他人求助：<%=map.get("count_qz")%></a></em>
				</div>
				</div>
			</li>
			<%}%>
			<%if("1".equals(confMap.get("myKnowValue"))){%>			
			<li <%if("1".equals(confMap.get("personInfomationValue"))){%> class="wh-portal-hidden" <%}%>>
			
			 <div class="wh-slide-consult-slide">
               <ul class="wh-slide-consult-ul clearfix">
				<%
				if(askList != null && askList.size() > 0){
					for (int i = 0; i < askList.size(); i++) {
						Object[] obj = (Object[]) askList.get(i);
				%>
				<li>
				<div class="wh-portal-i-item clearfix">
					<a href="javascript:void(0)"><i class="fa fa-file-o"></i>
					<span class="wh-portal-a-cursor" onclick="openWin({url:'<%=rootPath%>/question!viewQuestion.action?id=<%=obj[0]%>',isFull:true,winName:'查看问题<%=obj[0]%>'});" title="<%=obj[1]%>"><%=obj[1].toString().length()>limitCharInt?obj[1].toString().substring(0,limitCharInt)+"...":obj[1].toString()%></span>
					<em class="wh-pending-em">[<%=obj[4]%>]</em>
					 </a>
				</div>
				</li>
			   <%}}%>
			    </ul>
                </div>	
			</li>
			<%}%>
			<%if("1".equals(confMap.get("myAnswerValue"))){%>
			<li <%if("1".equals(confMap.get("myKnowValue"))||"1".equals(confMap.get("personInfomationValue"))){%> class="wh-portal-hidden" <%}%>>
			  <div class="wh-slide-consult-slide">
                <ul class="wh-slide-consult-ul clearfix">
			   <%
				if(answerList != null && answerList.size() > 0){
					for (int j = 0; j < answerList.size(); j++) {
						Object[] obj = (Object[]) answerList.get(j);
				%>
				<li>
				<div class="wh-portal-i-item clearfix">
					<a href="javascript:void(0)"><i class="fa fa-file-o"></i>
					<span class="wh-portal-a-cursor"  onclick="openWin({url:'<%=rootPath%>/question!viewQuestion.action?id=<%=obj[0]%>',isFull:true,winName:'查看问题<%=obj[0]%>'});" title="<%=obj[1]%>"><%=obj[1].toString().length()>limitCharInt?obj[1].toString().substring(0,limitCharInt)+"...":obj[1].toString()%></span>
					<em class="wh-pending-em">[<%=obj[4]%>]</em>
					</a>
				</div>
				</li>
				<%}}%>
				 </ul>
                </div>	
			</li>
			<%}%>
			<%if("1".equals(confMap.get("otherQuestinValue"))){%>
			<li class="wh-portal-hidden">
			<div class="wh-slide-consult-slide">
             <ul class="wh-slide-consult-ul clearfix">
			   <%
				if(otherHelpList != null && otherHelpList.size() > 0){
					for (int i = 0; i < otherHelpList.size(); i++) {
						Object[] obj = (Object[]) otherHelpList.get(i);
				%>
				<li>
				<div class="wh-portal-i-item clearfix">
					<a href="javascript:void(0)">
						<b><%=obj[3]%></b>
						<span  class="wh-portal-a-cursor"  onclick="openWin({url:'<%=rootPath%>/question!viewQuestion.action?id=<%=obj[0]%>',isFull:true,winName:'查看问题<%=obj[0]%>'});" title="<%=obj[1]%>"><%=obj[1].toString().length()>limitCharInt?obj[1].toString().substring(0,limitCharInt)+"...":obj[1].toString()%> [<%=obj[4]%>]</span>
					    <em class="wh-pending-em"><%=obj[2]%></em>
					</a>									
				</div>
				</li>
				<%}}%>
				  </ul>
                </div>				
			</li>
			<%}%>
		</ul>
	</div>
</div>
<script type="text/javascript">
  var personInfomationValue = '<%=personInfomationValue%>';
  var myKnowValue = '<%=myKnowValue%>';
  var myAnswerValue = '<%=myAnswerValue%>'; 
  var otherQuestinValue = '<%=otherQuestinValue%>'; 
  var content = new Array();
 
  var j = 0;
  if(personInfomationValue == '1'){
	content[j++] = "个人信息";
  }
  if(myKnowValue == '1'){
	content[j++] = "我的提问";
  }	
  if(myAnswerValue == '1'){
	content[j++] = "我的回答";
  }
  if(otherQuestinValue == '1'){
	content[j++] = "他人求助";
  }
  
  var con = "";
  for(var i=0;i<content.length;i++){
	var scontent =JSON.stringify(content[i]);
	var leftUrl="/modules/personal/personal_menu.jsp?expNodeCode=myInfo";
	var rightUrl = "MyInfoAction!modiMyInfo.action";
	if(scontent=='\"我的提问\"'){
		leftUrl = "/defaultroot/classSet!menu.action?portletSettingId=myQuestion";
		rightUrl = "/defaultroot/question!myQuestionList.action";
	}else if(scontent=='\"我的回答\"'){
		leftUrl = "/defaultroot/classSet!menu.action?portletSettingId=myAnswer";
		rightUrl = "/defaultroot/question!myAnswerList.action";
	}else if(scontent=='\"他人求助\"'){
		leftUrl = "/defaultroot/classSet!menu.action?portletSettingId=help";
		rightUrl = "/defaultroot/question!otherHelpList.action";
	}
	if(i != content.length-1){
		if(i == 0){
			con += '{title:'+scontent+',url:"",onclick:"",defaultSelected:"on",liCss:"wh-portal-overflow",morelink:"jumpnew(\''+leftUrl+'\',\''+rightUrl+'\')"},';
		}else{
			con += '{title:'+scontent+',url:"",onclick:"",defaultSelected:"",liCss:"wh-portal-overflow",morelink:"jumpnew(\''+leftUrl+'\',\''+rightUrl+'\')"},';
		}
	}else{
	    if(i == 0){
			con += '{title:'+scontent+',url:"",onclick:"",defaultSelected:"on",liCss:"wh-portal-overflow",morelink:"jumpnew(\''+leftUrl+'\',\''+rightUrl+'\')"}';
		}else{
			con += '{title:'+scontent+',url:"",onclick:"",defaultSelected:"",liCss:"wh-portal-overflow",morelink:"jumpnew(\''+leftUrl+'\',\''+rightUrl+'\')"}';
		}
	}
  }
  var jsonDataStr ='[{ulCss:"wh-portal-title-slide02",data:['+con+']}]';
  var jsonData = eval('(' + jsonDataStr + ')');
  Portlet.setPortletDataTitle('<%=portletSettingId%>',jsonData);
  Portlet.setMoreLink('<%=portletSettingId%>', {});
  slideTab('slide02');
</script>