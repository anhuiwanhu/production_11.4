<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
String orgId = session.getAttribute("orgId").toString();
String userId = session.getAttribute("userId").toString();
String userName = session.getAttribute("userName").toString();
String empLivingPhoto = request.getParameter("empLivingPhoto")==null?"":request.getParameter("empLivingPhoto");
%>
<!DOCTYPE html>
<html>
<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>会议通知</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css" />
  <link rel="stylesheet" type="text/css" href="template/css/mobiscroll/mobiscroll.animation.css" />
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.zepto.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.core.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.datetime.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.select.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.ios7.js"></script>
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
  <script type="text/javascript">
  $(function() {
    pageLoading();
  })
  var dialog = null;

  function pageLoading() {
    dialog = $.dialog({
      content: "页面加载中...",
      title: 'load'
    });
  }

  function pageLoaded() {
    if (document.readyState == "complete") {
      setTimeout(function() {
        dialog.close();
      }, 500);
    }
  }
  document.onreadystatechange = pageLoaded;

  $(function() {

    //演示1
    $("#demo-1").tap(function() {
      $.dialog({
        content: "数据加载中...",
        title: 'ok',
        time: 2000
      });
    })
    $("#demo-2").tap(function() {
      $.dialog({
        content: '<div class="xx"><h1>确认流程信息</h1><p>流程名称：年休假申请流程<br />下一环节：总经理评审<br />下一办理人：徐成、王辉、李玲、曹晓、王辉等30人</p></div>',
        title: null,
        ok: function() {},
        okText: "确认发送",
        cancel: function() {},
        cancelText: "返回修改"
      });
    })
    $("#demo-3").tap(function() {
      $.dialog({
        content: '<div class="xx"><p>这是无图模式提示哦，请切换成为无图模式浏览省流量</p></div>',
        title: null,
        ok: function() {},
        okText: "无图浏览",
        cancel: function() {},
        cancelText: "取消咯"
      });
    })

    $("#scroller").mobiscroll().date();
    var currYear = (new Date()).getFullYear();

    //初始化日期控件
    var opt = {
      preset: 'datetime', //日期，可选：date\datetime\time\tree_list\image_text\select
      theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
      display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
      mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
      lang: 'zh',
      dateFormat: 'yy-mm-dd', // 日期格式
      timeFormat: 'HH:ii',
      timeWheels: 'HHii',
      setText: '确定', //确认按钮名称
      cancelText: '取消', //取消按钮名籍我
      dateOrder: 'yymmdd', //面板中日期排列格式
      monthNames: ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12'],
      dayText: '日',
      monthText: '月',
      yearText: '年',
      hourText: '时',
      minuteText: '分',
      amText: '',
      pmText: '',
      showNow: false,
      startYear: 1999,
      endYear: 2099
    };
    $("#scroller").mobiscroll(opt);

  });
  </script>
</head>

<body>
  <section class="wh-section wh-section-bottomfixed">
    <article class="wh-edit wh-edit-forum">
      <div class="wh-container">
	    <x:parse xml="${docXml}" var="doc" />
		<c:set var="attendanceType"><x:out select="$doc//attendanceType/text()"/></c:set>
		<c:set var="isAdmin"><x:out select="$doc//isAdmin/text()"/></c:set>
		<c:set var="meetingId"><x:out select="$doc//meetingId/text()"/></c:set>
		<c:set var="motif"><x:out select="$doc//motif/text()"/></c:set>
		<c:set var="applyDate"><x:out select="$doc//applyDate/text()"/></c:set>
		<c:set var="content"><x:out select="$doc//personList/content/text()"/></c:set>
		<c:set var="status"><x:out select="$doc//personList/status/text()"/></c:set>
        <c:set var="empLivingPhoto"><x:out select="$doc//empLivingPhoto/text()"/></c:set>
		<c:set var="boardApplyId"><x:out select="$doc//boardroomApplyId/text()"/></c:set>
		<c:set var="status"><x:out select="$doc//status/text()"/></c:set>
		<c:set var="meetingAttendance"><x:out select="$doc//meetingAttendance/text()"/></c:set>
		<c:set var="meetingTime">
		<x:out select="$doc//meetingTimeList/destineDate/text()"/> <x:out select="$doc//meetingTimeList/startHour/text()"/>:<x:out select="$doc//meetingTimeList/startMinute/text()"/>-<x:out select="$doc//meetingTimeList/endHour/text()"/>:<x:out select="$doc//meetingTimeList/endMinute/text()"/>	
		</c:set>
		<%
		String date =(String)pageContext.getAttribute("applyDate");
		String[] dateArr = date.split(" ");
		String ndate = dateArr[0];
		pageContext.setAttribute("applyDate",ndate);
		%>
		<input type="hidden" id ="boardroomApplyId" value="${boardApplyId}">
		<input type="hidden" id ="statu" value="${status}">
		<input type="hidden" id ="motif" value="${motif}">
		<input type="hidden" id ="meetingId" value="${meetingId}">
		<input type="hidden" id ="meetingTime" value="${meetingTime}">
		<input type="hidden" id ="empLivingPhoto" value="${empLivingPhoto}">
        <table class="wh-table-edit">
          <tr>
            <th>会议室名称</th>
            <td>
              <span class="edit-ipt-reslut-l" ><x:out select="$doc//boardroomName/text()" /></span>
            </td>
          </tr>
		  <tr>
            <th>地址：</th>
            <td>
               <span class="edit-ipt-reslut-l" ><x:out select="$doc//addr/text()" /></span>
            </td>
          </tr>
          <tr>
            <th>点数：</th>
            <td>
               <span class="edit-ipt-reslut-l" ><x:out select="$doc//mailsubject/text()" /></span>
            </td>
          </tr>
          <tr>
            <th>出席人数：</th>
            <td>
               <span class="edit-ipt-reslut-l" ><x:out select="$doc//personNum/text()" /></span>
            </td>
          </tr>
          <tr>
            <th>会议主题：</th>
            <td>
				<span class="edit-ipt-reslut-l" ><x:out select="$doc//motif/text()" /></span>
            </td>
          </tr>
          <tr>
            <th>主持人：</th>
            <td>
				<span class="edit-ipt-reslut-l" ><x:out select="$doc//emceeName/text()" /></span>
            </td>
          </tr>
          <tr>
            <th>时间：</th>
            <td>
				<span class="edit-ipt-reslut-l" >${meetingTime}</span> 
            </td>
          </tr>
          <tr>
            <th>会议内容：</th>
            <td>
				<span class="edit-ipt-reslut-l" ><x:out select="$doc//depict/text()" /></span> 
            </td>
          </tr>
			<!-- 会议室编号 -->
			<tr>				
				<th>会议室编号：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//boardroomCode/text()" /></span> 
				</td>
			</tr>
			<!-- 会议类型 -->
			<tr>				
				<th>会议类型：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//boardroomApplyType/text()" /></span>    
				</td>
			</tr>
			<!-- 出席领导 -->
			<tr>				
				<th>出席领导 ：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//attendeeLeader/text()" /></span>    
				</td>
			</tr>
			<!-- 会议记录人 -->
				<th>会议记录人 ：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//notePersonName/text()" /></span>   
				</td>
			</tr>
			<!-- 会议出席人 -->
			<tr>				
				<th>会议出席人：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//attendee/text()" /></span>    
				</td>
			</tr>
			<!-- 其它参会人 -->
			<tr>				
				<th>其它参会人：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//otherAttendeePerson/text()" /></span>    
				</td>
			</tr>
			<!-- 预定者 -->
			<tr>				
				<th>预定者：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//applyEmpName/text()" /></span>    
				</td>
			</tr>
			<!-- 预定部门 -->
			<tr>				
				<th>预定部门：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//applyOrgName/text()" /></span>   
				</td>
			</tr>
			<!-- 预定日期 -->
			<tr>				
				<th>预定日期：</th>
				<td>					
					<span class="edit-ipt-reslut-l" >${applyDate}</span>  
				</td>
			</tr>
			<!-- 联系电话 -->
			<tr>				
				<th>联系电话：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//linkTelephone/text()" /></span>    
				</td>
			</tr>
			<!-- 席卡 -->
			<tr>				
				<th>席卡：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//seatcard/text()" /></span>    
				</td>
			</tr>
			<!-- 备注 -->
			<tr>				
				<th>备注：</th>
				<td>					
					<span class="edit-ipt-reslut-l" ><x:out select="$doc//remark/text()" /></span>     
				</td>
			</tr>
			 <tr>
				 <th>附件：</th>
				 <td>
						<c:set var="rfn">
						<x:forEach select="$doc//boardroomFileList" var="fe" ><x:out select="$fe/boardroomFileName/text()"/>|</x:forEach>
						</c:set>
						<c:set var="sfn">
						<x:forEach select="$doc//boardroomFileList" var="ffe" ><x:out select="$ffe/boardroomSaveName/text()"/>|</x:forEach>
						</c:set>
						<c:if test="${not empty sfn}">
							<%
								String realFileNames =(String)pageContext.getAttribute("rfn");
								String saveFileNames =(String)pageContext.getAttribute("sfn");
								String moduleName ="boardroom";
								
								realFileNames =realFileNames.substring(0,realFileNames.length() -1);
								saveFileNames =saveFileNames.substring(0,saveFileNames.length() -1);
								
							%>
							<jsp:include page="../common/include_download.jsp" flush="true">
									<jsp:param name="realFileNames"	value="<%=realFileNames%>" />
									<jsp:param name="saveFileNames" value="<%=saveFileNames%>" />
									<jsp:param name="moduleName" value="<%=moduleName%>" />
							</jsp:include>
						</c:if>
				 <td>
			 </tr>
			 <c:if test="${content !='null' && content !=''}">
             <tr>
				 <th>不参会原因：</th>
				 <td>
					<span class="edit-ipt-reslut-l" >${content}</span>  
				 <td>
			 </tr>
			 </c:if>
            </table>
        <!--<div class="meeting-other">
          <p onclick="showfeild()" id="show">展开填写非必填项</p>
          <span class="span-arrow-down"></span>
        </div>-->
      </div>
    </article>
  </section>
  <footer class="wh-footer wh-footer-forum">
    <div class="wh-wrapper">
      <div class="wh-container">
        <div class="wh-footer-btn">
          <!-- <a href="#" class="fbtn-cancel col-xs-6"><i class="fa fa-file-text-o"></i>保存草稿</a>
                <a href="#" class="fbtn-matter col-xs-6"><i class="fa fa-check-square"></i>发送</a> -->
          <a href="#" class="fbtn-cancel col-xs-8 btn-radio">
            <em class="btn-radio-l join" id="join">参加</em>
            <em class="btn-radio-l join-not" id="notjoin">不参加</em>
          </a>		
		  <c:if test="${status == '2' || isAdmin == '0'}">
			  <c:if test="${meetingAttendance == '0'}">
				  <c:if test="${attendanceType == '0'}">
					 <a href="javascript:scan(0)" class="fbtn-matter col-xs-4 login-scan" id="signActive">签到扫描</a>
				  </c:if>
				  <c:if test="${attendanceType == '1'}">
					 <c:if test="${isAdmin == '1'}">
						<a href="#" class="fbtn-matter col-xs-4 login-scan" id="signCode">签到码</a>
					 </c:if>
					 <c:if test="${isAdmin == '0'}">
						<a href="javascript:scan(1)" class="fbtn-matter col-xs-4 login-scan" id="signPassive">签到扫描</a>
					 </c:if>
				  </c:if>
			  </c:if>
		  </c:if>
        </div>
      </div>
    </div>
  </footer>
  <div class="login-qrcode">
    <div>
        
    </div>
    <img src="images/qrcode.png"  id="qrImg"/>
    <div id="qrcodeDiv">
     
    </div>
    <a href="#" class="close-qrcode" id="ctwoqrcode"><i class="fa fa-times-circle-o"></i></a>
  </div>
  <div  id="adminScan">
  </div>
  <script type="text/javascript">
  $(document).ready(function(){
	//标记通知详情中参加不参加
	var statu = $("#statu").val();
	if(statu == '2'){
		 $("#join").addClass("btn-radio-active").siblings().removeClass('btn-radio-active');
		 $(".join,.join-not").unbind( "click" );
	}else if(statu == '1'){
		$("#notjoin").addClass("btn-radio-active").siblings().removeClass('btn-radio-active');
		$(".join,.join-not").unbind( "click" );
	}
  
  })
  $('.join').on('click', function() {
    $(this).addClass("btn-radio-active").siblings().removeClass('btn-radio-active');
    $.dialog({
      content: '确定参会',
      title: null,

      width: 200,
      ok: function() {
		var boardroomApplyId = $("#boardroomApplyId").val();
		$.ajax({
			url : "meetingNoticeReply.controller",
			type : "post",
			data : {"status":"2","boardroomApplyId":boardroomApplyId,"content":""},
			success : function(){
			 $(".join,.join-not").unbind( "click" );
			 alert("反馈成功！");
			},
            error: function(xhr, type){
                alert('反馈异常！');
            }
		 });
      },
      cancel: function() {

      },
      lock: true
    });
  });

  $('.join-not').on('click', function() {
    $(this).addClass("btn-radio-active").siblings().removeClass('btn-radio-active');
    $.dialog({
      content: '<div class="meeting-subform"><form><input type="text" id="reason" name="" value="" placeholder="请输入不参会理由"/></form></div>',
      title: null,
      width: 250,
      ok: function() {
		  var reason = $("#reason").val();
		  var boardroomApplyId = $("#boardroomApplyId").val();
		  $.ajax({
			url : "meetingNoticeReply.controller",
			type : "post",
			data : {"status":"1","boardroomApplyId":boardroomApplyId,"content":reason},
			success : function(){
             $(".join,.join-not").unbind( "click" );
			 alert("反馈成功！");
			},
            error: function(xhr, type){
                alert('反馈异常！');
            }
		  });
      },
      cancel: function() {

      },
      lock: true
    });
  });

  //扫码
  function scan(flag){
	    var meetingId = $("#meetingId").val();
		var idVal ='';
        var applyIdVal ='';
        var empId ='';
		var empName ='';
		var orgId ='';
		var orgName ='';
		var motif='';
		var meetingTime='';
		var empLivingPhoto='';
		wx.scanQRCode({
			desc: 'scanQRCode desc',
			needResult: 1, // 默认为0，扫描结果由微信处理，1则直接返回扫描结果，
			scanType: ["qrCode","barCode"], // 可以指定扫二维码还是一维码，默认二者都有
			success: function (res) {
		    var boardroomApplyId = $("#boardroomApplyId").val();
			var result = res.resultStr; // 当needResult 为 1 时，扫码返回的结果
			if(flag == '0'){//主动扫码
				applyIdVal = result;
				if(applyIdVal != boardroomApplyId){//判断是否是本次会议二维码
					alert("二维码不匹配，请扫描本次会议二维码！");
					return false;
				}
				idVal = meetingId;
			}else{//被动扫码
				applyIdVal = result.split(";")[0];
				if(applyIdVal != boardroomApplyId){//判断是否是本次会议二维码
					alert("二维码不匹配，请扫描本次会议二维码！");
					return false;
				}
				meetingId = result.split(";")[1];
                empId =result.split(";")[2];
				empName =result.split(";")[3];
				orgId =result.split(";")[4];
				orgName =result.split(";")[5];
				motif = result.split(";")[6];
				meetingTime = result.split(";")[7];
				empLivingPhoto = result.split(";")[8];
				empLivingPhoto='/defaultroot/upload/peopleinfo/'+empLivingPhoto;
				idVal = meetingId;
			}
			$.ajax({
			url : "meetingNoticeStatus.controller",
			type : "post",
			data : {"meetingId":idVal,"boardroomApplyId":applyIdVal,"empId":empId,"empName":empName,"orgId":orgId,"orgName":orgName,"flag":flag},
			success : function(){
				if(flag == '1'){
					var result ='<div class="meeting-scan">'
								+ '<h2>扫描结果如下</h2>'
								+ '<div class="meeting-scan-user">'
								+ '	<img src="'+empLivingPhoto+'"/> '
								+ '	<strong>'+empName+'</strong><strong>已签到</strong><i class="fa fa-check"></i>'
								+ '	<p>'+meetingTime+'</p>'
								+ '	<p>'+motif+'</p>'
								+ '</div> '
								+ '<div class="mbtn">'
								+ '	<a href="javascript:close()" class="mbtn-cancle btn-l" >关闭</a>'
								+ '	<a href="javascript:scan(1)" class="mbtn-master btn-r" >扫一扫</a>'
								+ '</div> '
							   + ' </div>'
					$("#adminScan").show();
					$("#adminScan").html(result);
					$(".wh-section").hide();
					$(".wh-footer").hide();
				}else{
					alert('签到成功');
				}
			},
            error: function(xhr, type){
                alert('签到异常！');
            }
		 });
		},
        fail: function(res){
        	if(res.errMsg.indexOf('function not exist') > 0){
                alert("微信版本过低请升级!")
            }else if(res.errCode == '-1'){
				alert("系统出错!");
			}else if(res.errCode == '10001'){
        		alert("appid无效!");
        	}else if(res.errCode == '10002'){
				alert("该用户未关注企业号！");    		
			}else if(res.errCode == '10003'){
				alert("消息服务未开启！");
			}else if(res.errCode == '10004'){
				alert("用户不在消息服务可见范围！");
			}else if(res.errCode == '10006'){
				alert("消息会话成员数不合法！");
			}else if(res.errCode == '10005'){
				alert("您的帐号规则可能与其他用户不一致,尝试为你匹配其他方式！");
        		wx.openEnterpriseChat({
        			userIds:uid, 
        			groupName:'',
        			success: function(res2){
        				
        			},
        	        fail: function(res2){
        	        	if(res2.errMsg.indexOf('function not exist') > 0){
        	                alert("微信版本过低请升级!")
        	            }else if(res2.errCode == '10005'){
        					alert("您的帐号规则异常，无法使用消息功能，请联系单位管理员!");
        				}else if(res2.errCode == '-1'){
        					alert("系统出错!");
        				}else if(res2.errCode == '10001'){
        	        		alert("appid无效!");
        	        	}else if(res2.errCode == '10002'){
        					alert("该用户未关注企业号！");    		
        				}else if(res2.errCode == '10003'){
        					alert("消息服务未开启！");
        				}else if(res2.errCode == '10004'){
        					alert("用户不在消息服务可见范围！");
        				}
        			}
        		});
        	}
		}
		});
	}
   
   //签到码
	$("#signCode").on('click', function() {
    var userId = '<%=userId%>';
	var userName = '<%=userName%>';
    var meetingId = $("#meetingId").val();
	var motif = $("#motif").val();
	var meetingTime = $("#meetingTime").val();
	var empLivingPhoto = $("#empLivingPhoto").val();
	var boardroomApplyId = $("#boardroomApplyId").val();
    $.ajax({
		url : "productTwodbc.controller",
		type : "post",
		data : {"meetingId":meetingId,"boardroomApplyId":boardroomApplyId,"motif":motif,"meetingTime":meetingTime,"empLivingPhoto":empLivingPhoto},
		success : function(){
			var result ='<strong>'+userName+'</strong>'
                           + '<p>'+meetingTime+'</p>'
                           +'<p>'+motif+'</p>'
            
			$("#qrImg").attr("src","/defaultroot/upload/boardroom/twodbc/"+userId+".jpg");
			$("#qrcodeDiv").html(result);
			$(".wh-section").addClass("section-hide");
			$(".wh-footer").hide();
			$(".login-qrcode").addClass("login-show");
		}
	 });

     });
   
    $("#ctwoqrcode").on('click', function() {
    $(".wh-section").removeClass("section-hide");
    $(".wh-footer").show();
    $(".login-qrcode").removeClass("login-show");
  })

  function close(){
	 $(".wh-section").show();
	 $(".wh-footer").show();
	 $("#adminScan").hide();
  }
  </script>
</body>

</html>
