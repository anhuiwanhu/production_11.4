<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String pageId = request.getParameter("pageId");
String processId = request.getParameter("processId");
String process_type = request.getParameter("process_type");
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>${param.processName}</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" /> 
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/swiper/template.swiper.css" />
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>
</head>
<body>
	<form id="sendForm" class="dialog"  method="post">
		<input type="hidden" id="process_type" name="process_type" value="${param.process_type}"/>
		<input  id="processId" type="hidden"  name="processId" value="<%=processId%>" />
		<section class="wh-section wh-section-bottomfixed" id="mainContent">
			<article class="wh-edit wh-edit-document">
				 <div>
				 	<c:if test="${not empty docXml}">
				 		<x:parse xml="${docXml}" var="doc"/>
		            	<table class="wh-table-edit" id="table_form">
		            		<x:forEach select="$doc//fieldList/field" var="fd" >
		            			<c:set var="voitureName"><x:out select="$fd/voitureName/text()"/></c:set>
		            			<c:set var="orgName"><x:out select="$fd/orgName/text()"/></c:set>
		            			<c:set var="empName"><x:out select="$fd/empName/text()"/></c:set>
		            			<c:set var="destination"><x:out select="$fd/destination/text()"/></c:set>
		            			<c:set var="personNum"><x:out select="$fd/personNum/text()"/></c:set>
		            			<c:set var="genchePerson"><x:out select="$fd/genchePerson/text()"/></c:set>
		            			<c:set var="motorMan"><x:out select="$fd/motorMan/text()"/></c:set>
		            			<c:set var="startDate"><x:out select="$fd/startDate/text()"/></c:set>
		            			<c:set var="endDate"><x:out select="$fd/endDate/text()"/></c:set>
		            			<c:set var="voitureStyle"><x:out select="$fd/voitureStyle/text()"/></c:set>
		            			<c:set var="reason"><x:out select="$fd/reason/text()"/></c:set>
		            			<c:set var="remark"><x:out select="$fd/remark/text()"/></c:set>
		            			<c:set var="mustfilled"><x:out select="$fd/mustfilled/text()"/></c:set>
		            			<!-- 申请车辆名称 -->
		            			<c:if test="${voitureName !='null' && voitureName !=''}">
			            			<tr>
			            				<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${voitureName }：</th>
			            				<td>
			            					<div class="examine">
												<a class="edit-select edit-ipt-r">
													<div class="edit-sel-show">
														<span>请选择</span>
													</div>    
													<select onchange="setCar(this);" class="btn-bottom-pop" name='voitureName' id='voitureName'>
														<option value="">请选择</option>
														<x:forEach select="$fd/dataList/val" var="selectvalue" >
															<option value='<x:out select="$selectvalue/motorMan/text()"/>,<x:out select="$selectvalue/hiddenval/text()"/>' >
																<x:out select="$selectvalue/showval/text()"/>
															</option>
														</x:forEach>
													</select>
												</a>
											</div>
											<input type="hidden" id="voitureId" name="voitureId"/>
			            				</td>
			            			</tr>
		            			</c:if>
		            			<!-- 申请部门名称 -->
		            			<c:if test="${orgName !='null' && orgName !=''}">
		            				<tr>
		            					<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${orgName}：</th>
		            					<td>
		            						<input type="hidden" readonly="readonly" id='orgId' name='orgId' value='<x:out select="$fd/hiddenval/text()"/>' />
			           						<input type="text"   readonly="readonly" id='orgName'  name='orgName' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","orgName","orgId","*0*","org");' placeholder="请选择"/> 
		            					</td>
		            				</tr>
		            			</c:if>
		            			<!-- 申请人名称 -->
								<c:if test="${empName !='null' && empName !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${empName}：</th>
										<td>
										<input type="hidden" readonly="readonly" id='empId' name='empId' value='<x:out select="$fd/hiddenval/text()"/>' />
			           					<input type="text"   readonly="readonly" id='empName' name='empName' value='<x:out select="$fd/value/text()"/>' class="edit-ipt-r edit-ipt-arrow" onclick='selectUser("0","empName","empId","*0*","user")' placeholder="请选择"/>
										</td>
									</tr>
								</c:if>
								<!-- 目的地 -->
								<c:if test="${destination !='null' && destination !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${destination}：</th>
										<td><input class="edit-ipt-r" placeholder="请输入" id="destination"  type="text" maxlength="30" name='destination'/></td>
									</tr>
							    </c:if>
							    <!-- 跟车人数 -->
							    <c:if test="${personNum !='null' && personNum !=''}">
									<tr>
									  	<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${personNum}：</th>
										<td><input class="edit-ipt-r" placeholder="请输入"  type="text" maxlength="3" name='personNum' id='personNum'  oninput="value=value.replace(/[^\d]/g,'')"/></td>
									</tr>
							    </c:if>
							    <!-- 跟车人 -->
							    <c:if test="${genchePerson !='null' && genchePerson !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${genchePerson}：</th>
										<td><input class="edit-ipt-r" placeholder="请输入"  type="text" maxlength="100" name='genchePerson' id="genchePerson"/></td>
									</tr>
							    </c:if>
							    <!-- 司机 -->
							    <c:if test="${motorMan !='null' && motorMan !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${motorMan}：</th>
										<td><input class="edit-ipt-r" placeholder="请输入"  type="text" maxlength="20" name='motorMan' id='motorMan'/></td>
									</tr>
							    </c:if>
							    <!-- 预计用车开始时间 -->
							    <c:if test="${startDate !='null' && startDate !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${startDate}：</th>
										<td>
											<div class="edit-ipt-a-arrow">
												<input data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='startDateTime' name='startDateTime' placeholder="选择日期时间"/>
												<label class="edit-ipt-label" for="scroller"></label>
											</div>
										</td>
									</tr>
							    </c:if>
							    <!-- 预计用车结束时间 -->
								<c:if test="${endDate !='null' && endDate !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${endDate}：</th>
										<td>
											<div class="edit-ipt-a-arrow">
												<input data-dateType="datetime" class="edit-ipt-r edit-ipt-arrow" type="text" id='endDateTime' name='endDateTime' placeholder="选择日期时间"/>
												<label class="edit-ipt-label" for="scroller"></label>
											</div>
										</td>
									</tr>
								</c:if>
								<!-- 用车类型 -->
								<c:if test="${voitureStyle !='null' && voitureStyle !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${voitureStyle}：</th>
										<td>
											<div class="examine">
												<a class="edit-select edit-ipt-r">
													<div class="edit-sel-show">
														<span>普通用车</span>
													</div>    
													<select onchange="setSpanHtml(this);" name='voitureStyle' id ='voitureStyle' class="btn-bottom-pop">
														<x:forEach select="$fd/dataList/val" var="selectvalue" >
															<c:set var ="selFlag"><x:out select="$selectvalue/showval/text()"/></c:set>
															<option value='<x:out select="$selectvalue/hiddenval/text()"/>' <c:if test="${selFlag == '普通用车'}">selected="true"</c:if>><x:out select="$selectvalue/showval/text()"/></option>
														</x:forEach>
													</select>
												</a>
											</div>
										</td>
									</tr>
								</c:if>
								<!-- 事由 -->
								<c:if test="${reason !='null' && reason !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${reason}：</th>
										<td>
											<textarea name='reason' id='reason' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"></textarea>
											<span class="edit-txta-num">300</span>
										</td>
									</tr>
								</c:if>
								<!-- 备注 -->
								<c:if test="${remark !='null' && remark !=''}">
									<tr>
										<th><c:if test="${mustfilled == 1}"><i class="fa fa-asterisk"></i></c:if>${remark}：</th>
										<td>
											<textarea name='remark' id='remark' onkeyup="$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );"   class="edit-txta edit-txta-l" maxlength="300"></textarea>
											<span class="edit-txta-num">300</span>
										</td>
									</tr>
								</c:if>
							</x:forEach>
		            	</table>
				 	</c:if>
				 </div>
			</article>
		</section>
		<footer class="wh-footer wh-footer-forum" id="footerButton">
		    <div class="wh-wrapper">
		        <div class="wh-container">
		            <div class="wh-footer-btn">
		                <a href="javascript:formCheck();" class="fbtn-matter col-xs-12"><i class="fa fa-check-square"></i>发送</a>
		            </div>
		        </div>
		    </div>
		</footer>
		<section id="selectContent" style="display:none">
		</section>
		<jsp:include page="../common/include_workflow_subTable.jsp" flush="true">
			<jsp:param name="docXml" value="${docXml}" />
			<jsp:param name="orgId" value="<%=orgId %>" />
		</jsp:include>
	</form>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="/defaultroot/modules/comm/microblog/script/ajaxfileupload.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/swiper/swiper.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/selector.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.core.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.scroller.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.datetime.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/mobiscroll/mobiscroll.select.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/followskip/followskip.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/uploadPreview.min.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/subClick.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script>
	var dialog = null;
	function pageLoading(){
	    dialog = $.dialog({
	        content:"页面加载中...",
	        title: 'load'
	    });
	}
	//打开选择人员页面
	function selectUser(selectType,selectName,selectId,range,listType){
		pageLoading();
		var selectIdVal = $('input[id="'+selectId+'"]').val();
		if( selectIdVal.indexOf(";") > 0 ){
			var selectIdArray = selectIdVal.split(';');
			selectIdVal = selectIdArray[1];
		}
		if(selectIdVal.indexOf('$') != -1){
			var selectIdArray = selectIdVal.split('$');
			if(selectIdArray){
				selectIdVal = '';
				for(var i=0,length=selectIdArray.length;i<length;i++){
					if(selectIdArray[i]){
						selectIdVal += selectIdArray[i] + ',';
					}
				}
			}
		}
		var postUrl = '';
		if(listType == 'org'){
			postUrl = '/defaultroot/person/searchOrg.controller?flag=org';
		}else if(listType=='user'){
			postUrl = '/defaultroot/person/newsearch.controller?flag=user';
		}
		$.ajax({
			url : postUrl,
			type : "post",
			data : {'selectType':selectType,'selectName':selectName,'selectId':selectId,
					'selectNameVal':$('input[id="'+selectName+'"]').val(),'selectIdVal':selectIdVal,'range':range},
			success : function(data){
				$("#selectContent").append(data);
				hiddenContent(0);
				if(dialog){
					dialog.close();
				}
			}
		});
	}

	//表单必填项验证
    function formCheck(){
		if(confirmForm()){
			var checkOk = '';
			var checkUrl = '/defaultroot/workflow/checkVoitureApplyed.controller';
			var voitureId = $('#voitureId').val();
			var startDateTime = $('#startDateTime').val();
			var endDateTime = $('#endDateTime').val();
			$.ajax({
				url : checkUrl,
				type : "post",
				data : 'voitureId='+voitureId+'&startDateTime='+startDateTime+'&endDateTime='+endDateTime,
				success : function(data){
					if(data=='0'){
						alert("您申请的车辆在此时间段已被占用！");
					}else{
						sendFlow();
					}
				}
			});
		}
    }
    
	//提交表单
	var flag = 1;
	function sendFlow(){
		//防止重复提交
		if(flag == 0){
    		return;
    	}
    	flag = 0;
		var url = '/defaultroot/workflow/sendVoitureApply.controller';
		$.ajax({
			url : url,
			type : "post",
			data : $('#sendForm').serialize(),
			success : function(infoId){
				openNextPage(infoId);
			}
		});
	}
	//流程开始
	function openNextPage(infoId){
		var processId = $('#processId').val();
		var mainLinkFile = '/defaultroot/voitureApply!modi.action';
		var process_type = '${param.process_type}';
		var openUrl = '';
		if(process_type=='0'){
			openUrl='/defaultroot/workflow/sendFlow.controller?mainLinkFile='+mainLinkFile+'&infoId='+infoId+'&processId='+processId;
		}else{
			openUrl='/defaultroot/workflow/sendezFlow.controller?mainLinkFile='+mainLinkFile+'&infoId='+infoId+'&processId='+processId;
		}
		window.location = openUrl;
	}
	//选人选组织代码-----开始
	function hiddenContent(flag){
		if(flag == 0){
			if($('#mainContent').is(':hidden')){
				$('[id="subHeader_'+subTableName+'"]').hide();
				$('[id="subSection_'+subTableName+'"]').hide();
				$('[id="subFooter_'+subTableName+'"]').hide();
				$('[id="subHeader_'+subTableName+'"]').data('hide','1');
			}else{
				$("#mainContent").css("display","none");
				$("#footerButton").css("display","none");
			}
			$("#selectContent").css("display","block");
		}else if(flag == 1){
			if($('[id="subHeader_'+subTableName+'"]') && $('[id="subSection_'+subTableName+'"]').is(':hidden') 
					&& $('[id="subHeader_'+subTableName+'"]').data('hide') == '1'){
				$('[id="subHeader_'+subTableName+'"]').data('hide','0');
				$('#selectContent').hide();
				$('[id="subHeader_'+subTableName+'"]').show();
				$('[id="subSection_'+subTableName+'"]').show();
				$('[id="subFooter_'+subTableName+'"]').show();
			}else{
				$("#selectContent").css("display","none");
				$("#mainContent").css("display","block");
				$("#footerButton").css("display","block");
			}
			$("#selectContent").empty();
		}
	}

	$(function(){
	    selectDateTime();
		$("textarea").each(function(){
			$(this).change(function(){ 
				$(this).next('.edit-txta-num').html($(this).attr('maxlength')-$(this).val().length );
			});
		});
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

	//设置车辆id和司机
	function setCar(obj,selectVal){
		var selVal = $(obj).find("option:selected").val();
		if(selVal==''){
			$('#motorMan').val('');
			$('#voitureId').val('');
		}else{
			var selVals = selVal.split(",");
			$('#motorMan').val(selVals[0]);
			$('#voitureId').val(selVals[1]);
		}
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	} 

	//设置span中的值
	function setSpanHtml(obj,selectVal){
    	if(!selectVal){
    		selectVal = $(obj).find("option:selected").text();
    	}
		$(obj).parent().find('div>span').html(selectVal);
	} 
</script>
