<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>

<head lang="en">
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
  <title>会议室申请</title>
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
  <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css" />
  <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/calender/calender.css" />
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
  <script type="text/javascript" src="/defaultroot/evo/weixin/template/js/calender/simplecalendar.js"></script> 
  <script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
  <script type="text/javascript">
    $(document).ready(function() {
      calendar.init('', '/defaultroot/evo/weixin/json/events.json');
    });

     
  </script>
</head>

<body>
<form id="sendForm" class="dialog" action="/defaultroot/meeting/meetingRoomList.controller" method="post">
  <section class="wh-section wh-section-bottomfixed">
    <article class="wh-edit wh-edit-forum">
      <div class="wh-container">
	  <c:if test="${not empty docXml}">
	      <x:parse xml="${docXml}" var="doc"/>
		  <c:set var="dateAttend">
			  <x:forEach select="$doc//dateList/meetingDate" var="md" ><x:out select="$md/text()"/>,</x:forEach>
		  </c:set>
		  <input type="hidden" id="dtAttend" value="${dateAttend}"/>
	  </c:if>
        <div class="meeting-room-apply"> 
          <div class="calendar hidden-print">
            <header>
              <h2 class="month"></h2>
              <!-- <a class="btn-prev fontawesome-angle-left" href="#"></a>
              <a class="btn-next fontawesome-angle-right" href="#"></a> -->
              <i class="btn-prev fa fa-angle-left " ></i>
              <i class="btn-next fa fa-angle-right "></i>
            </header>
            <table>
              <thead class="event-days">
                <tr></tr>
              </thead>
              <tbody class="event-calendar">
                <tr class="one"></tr>
                <tr class="two"></tr>
                <tr class="three"></tr>
                <tr class="four"></tr>
                <tr class="five "></tr>
              </tbody>
            </table> 
            <div class="list">
              <!--<div class="day-event" date-day="2" date-month="2" date-year="2016"  data-number="1"></div>-->
            </div>
          </div>
             
          <table class="wh-table-edit"> 
              <th>开始时间：</th>
              <td>
                <div class="edit-ipt-a-arrow edit-ipt-r">
                  <input class="edit-ipt-r" type="text" id="startDate" name="startDate" readonly="readonly"/> 
                </div>
                <div class="edit-ipt-a-arrow edit-ipt-r">
                  <input class="edit-ipt-r" data-datetype="time" id="startHour" type="text"  name="startHour" placeholder="选择时分" />
                </div>
              </td>
            </tr>
            <tr>
              <th>结束时间：</th>
              <td>
                <div class="edit-ipt-a-arrow edit-ipt-r">
                  <input class="edit-ipt-r" type="text" id="endDate" name="endDate" readonly="readonly"/> 
                </div>
                <div class="edit-ipt-a-arrow edit-ipt-r">
                  <input class="edit-ipt-r" data-datetype="time" id="endHour" type="text" name="endHour" placeholder="选择时分" />
                </div>
              </td>
            </tr>
            <tr>
              <th>出席人数：</th>
              <td>
                <div class="edit-ipt-r">
                  <input class="edit-ipt-r" type="text" id="personNum" name="personNum" placeholder="请填写" />
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
    </article>
  </section>
  <footer class="wh-footer wh-footer-forum">
    <div class="wh-wrapper">
      <div class="wh-container">
        <div class="wh-footer-btn">
          <a href="javascript:subForm();" class="fbtn-matter col-xs-12">查看可用会议室</a>
        </div>
      </div>
    </div>
  </footer>
</form>
</body>
<script type="text/javascript">
     $(function(){
		//已经预定的日期置灰
        var ids = $("#dtAttend").val();
		if(ids != "" && ids != undefined){
			ids = ids.substring(0,ids.length-1);
			var idArr = ids.split(",");
			for(var i=0;i<idArr.length;i++){
				$("#"+idArr[i]).addClass("event null");
			}
		}
     });
    function grayDate(){
		//已经预定的日期置灰
        var ids = $("#dtAttend").val();
		if(ids != "" && ids != undefined){
			ids = ids.substring(0,ids.length-1);
			var idArr = ids.split(",");
			for(var i=0;i<idArr.length;i++){
				$("#"+idArr[i]).addClass("event null");
			}
		}
	}

	function selectdate(obj){
		var year = $(obj).attr("date-year");
		var month = $(obj).attr("date-month");
		var day = $(obj).attr("date-day");
		if(month<10){
			month='0'+month;
		}
		if(day<10){
			day='0'+day;
		}
		var date=year+'-'+month+'-'+day;
		$("#startDate").val(date);
		$("#endDate").val(date);
	}

	var flag = 1;//防止重复提交
    function subForm(){
    	if(flag == 0){
    		return;
    	}   	
		flag = 0;
		if(checkForm()){
    		$('#sendForm').submit();
        }
    }

	function checkForm(){
		flag = 1;
		var startDate=$("#startHour").val();
		var startHour=$("#startHour").val();
		var endDate=$("#endDate").val();
		var endHour=$("#endHour").val();
		var personNum=$("#personNum").val();
		if(startDate =="" && startHour=="" && endDate=="" &&endHour =="" && personNum==""){
			return true;
		}else{
			if(startDate ==""){
				alert("日期不能为空！");
				return false;
			}
			if(startHour ==""){
				alert("开始时间不能为空！");
				return false;
			}
			if(endDate ==""){
				alert("日期不能为空！");
				return false;
			}
			if(endHour ==""){
				alert("结束时间不能为空！");
				return false;
			}
			if(personNum ==""){
				alert("出席人数不能为空！");
				return false;
			}
			if(isNaN(personNum)){
			    alert("出席人数只能为数字！");
				return false;
			}

			var startDate=$("#startDate").val(); 
		    var now = new Date();
            var nowDate = now.getFullYear()+"-"+((now.getMonth()+1)<10?"0":"")+(now.getMonth()+1)+"-"+(now.getDate()<10?"0":"")+now.getDate();
		    var d1 = new Date(startDate.replace(/\-/g, "\/")); 
		    var d2 = new Date(nowDate.replace(/\-/g, "\/")); 

		    if(d1 < d2) 
		    { 
				alert("开始日期不能早于当前日期！"); 
				return false; 
		    }
		    
		    var startArr = startHour.split(':');
		    var sum1 = '';
		    for (var i = 0; i < startArr.length; i++) {
		    	sum1 = startArr[0]*60*60+startArr[1]*60;
		    }
		    
		    var endArr = endHour.split(':'); 
		    var sum2 = '';
		    for (var i = 0; i < endArr.length; i++) {
		    	sum2 = endArr[0]*60*60+endArr[1]*60;
		    }
		    
		    if(sum1 > sum2){
		    	alert("结束时间不能早于开始时间！");
		    	return false; 
		    }
		    if(sum1 == sum2){
		    	alert("开始时间不能和结束时间相同！");
		    	return false; 
		    }
		}
        return true;
	}

    $(function(){
        selectDateTime();
    });
	 //日期空间初始化参数
    var opt = {
		'date': {
			preset: 'date', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            showNow: false,
            endYear:2099
		},
		'datetime': {
	  	 	preset: 'datetime', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            dateFormat: 'yy-mm-dd', // 日期格式
            timeFormat: 'HH:ii',
            timeWheels:'HHii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            dateOrder: 'yymmdd', //面板中日期排列格式
            dayText: '日',
            monthText: '月',
            yearText: '年',
            hourText:'时',
            minuteText:'分',
            showNow: false,
            endYear:2099
		},
		'time': {
	  	 	preset: 'time', //日期，可选：date\datetime\time\tree_list\image_text\select
            theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
            display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
            mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
            lang:'zh',
            timeFormat: 'HH:ii',
            setText: '确定', //确认按钮名称
            cancelText: '取消',//取消按钮名籍我
            hourText:'时',
            minuteText:'分',
            amText:'上午',
            pmText:'下午',
            showNow: false,
            endYear:2099
		}
	}
    
    //选择日期时间
    function selectDateTime(){
    	var dateType = '';
    	$('input[data-datetype=date],[data-datetype=datetime],[data-datetype=time]').each(function(){
    		dateType = $(this).data('datetype');
    		if(dateType){
				$(this).mobiscroll(opt[dateType]);
    		}
    	});
    }
</script>
</html>
