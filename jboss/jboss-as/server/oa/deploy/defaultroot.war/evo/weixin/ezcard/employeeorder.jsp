<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>${pageTitle }</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />

    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.icons.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.scroller.ios7.css"/>
    <link rel="stylesheet" type="text/css" href="/defaultroot/evo/weixin/template/css/mobiscroll/mobiscroll.animation.css"/>

	
</head>
<body>

<!-- 存储名片订购盒数和地址。 -->
<input type="hidden" name="ezcardPo.ezCardNum" value="" id="ezCardNum"/>
<input type="hidden" name="ezcardPo.ezCardAddress" value="" id="ezCardAddress"/>

<!-- 获取申请人的信息 -->
<c:if test="${not empty docXml2}">
	<x:parse xml="${docXml2}" var="doc2"/>
	<script>
		alert(${docXml2});
	</script>
	<c:set var="EmployeeName"><x:out select="$doc2//EmployeeName/text()" /></c:set>
	<c:set var="EmployeeNameEn"><x:out select="$doc2//EmployeeNameEn/text()" /></c:set>
	<c:set var="FirstPosition"><x:out select="$doc2//FirstPosition/text()" /></c:set>
	<c:set var="Mobile"><x:out select="$doc2//Mobile/text()" /></c:set>
	<c:set var="Email"><x:out select="$doc2//Email/text()" /></c:set>
	<c:set var="FirstDeptName"><x:out select="$doc2//FirstDeptName/text()" /></c:set>
	<c:set var="FirstFax"><x:out select="$doc2//FirstFax/text()" /></c:set>
	<c:set var="OfficePhone"><x:out select="$doc2//OfficePhone/text()" /></c:set>
	<c:set var="FirstAddress"><x:out select="$doc2//FirstAddress/text()" /></c:set>
	<c:set var="FourthDeptName"><x:out select="$doc2//FourthDeptName/text()" /></c:set>
</c:if>


<section class="wh-section wh-section-bottomfixed">
    <article class="wh-edit wh-edit-forum">
        <div class="wh-container">
        	<c:if test="${not empty docXml}">
        		<x:parse xml="${docXml}" var="doc"/>
            	<table class="wh-table-edit">
                	<tr>
                    	<th>申请人：</th>
                    	<td><input class="edit-ipt-r" type="text" value="${userName }" readonly="readonly"/></td>
                	</tr>
                	<tr>
                    	<th>申请部门：</th>
                    	<td><input class="edit-ipt-r" type="text" value="${orgName }" readonly="readonly"/></td>
                	</tr>
                	<tr>
                    	<th>申请日期：</th>
                    	<td>
                        	<div class="edit-ipt-a-arrow">
                            	<input class="edit-ipt-r edit-ipt-arrow" id="scroller" type="text" name="scroller" placeholder="选择日期" onchange="getDate();"/>
                            	<label class="edit-ipt-label" for="scroller"></label>
                        	</div>
                    	</td>
                	</tr>
                	<tr>
                  		<th>选择模板</th>
                        <td>
                        	<div class="examine">
								<a class="edit-select edit-ipt-r">
									<div class="edit-sel-show">
										<span>请选择</span>
									</div>    
									<select id="sel" class="btn-bottom-pop" onchange="setSpanHtml(this);">
										 <option value="">请选择</option>
										 <x:forEach select="$doc//templatelist" var="tl" >
										 	<option value="<x:out select="$tl/templateId/text()"/>"><x:out select="$tl/templateName/text()"/></option>
										 </x:forEach>
									</select>
								</a>
							</div>                        
                        </td>
                	</tr>
                	<tr>
                    	<td colspan="2">
                        	<div class="wh-iframe wh-ios-iframe-bug">
                            	<iframe src="" id="iframe_id" allowtransparency="transparent" scrolling="auto" style="zoom:75%" class="wh-portal" width="100%" height="100%" marginheight="0" marginwidth="0" frameborder="0"></iframe>
                        	</div>
                    	</td>
                	</tr>
            	</table>
            </c:if>
        </div>
    </article>
</section>
<footer class="wh-footer wh-footer-forum">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:send();" class="fbtn-matter col-xs-12">发送</a>
            </div>
        </div>
    </div>
</footer>
</body>
</html>

	<script type="text/javascript" src="/defaultroot/evo/weixin/js/jquery-1.8.2.min.js"></script>
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
    <script type="text/javascript">
        
		//OA流程id
		var oaflowId="${oaflowId}";
		//ezcard流程id
		var processId="${processId}";
		//ezcard流程类型
		var process_type="${process_type}";
		//客户唯一标识
		var appId="${appId}";
		
		var EmployeeNum="${userId}";
		var EmployeeName="${EmployeeName}";
		var EmployeeNameEn="${EmployeeNameEn}";
		var FirstPosition="${FirstPosition}";
		var Mobile="${Mobile}";
		var Email="${Email}";
		var FirstDeptName="${FirstDeptName}";
		var FirstFax="${FirstFax}";//"0551 62885310"
		var OfficePhone="${OfficePhone}";//"0551 62885310-8606"
		var FirstAddress="${FirstAddress}";
		var FourthDeptName="${FourthDeptName}";
        
        $(function(){
            pageLoading();
        })
        var dialog = null;
        function pageLoading(){
            dialog = $.dialog({
                content:"页面加载中...",
                title: 'load'
            });
        }
        function pageLoaded(){
            if (document.readyState == "complete") {//判断页面是否加载完成
                setTimeout(function(){
                    dialog.close();
                },500);
            }
        }
        document.onreadystatechange = pageLoaded;//方法判断页面加载是否完成

        $(function(){
            $("#scroller").mobiscroll().date();
            var currYear = (new Date()).getFullYear();//开始年份
            //初始化日期控件
            var opt = {
                preset: 'date', //日期，可选：date\datetime\time\tree_list\image_text\select
                theme: 'ios7', //皮肤样式，可选：default\android\android-ics light\android-ics\ios\jqm\sense-ui\wp light\wp
                display: 'bottom', //显示方式 ，可选：modal\inline\bubble\top\bottom
                mode: 'scroller', //日期选择模式，可选：scroller\clickpick\mixed
                lang:'zh',
                dateFormat: 'yy/mm/dd', // 日期格式
                setText: '确定', //确认按钮名称
                cancelText: '取消',//取消按钮名籍我
                dateOrder: 'yymmdd', //面板中日期排列格式
                monthNames:['01','02','03','04','05','06','07','08','09','10','11','12'],
                dayText: '日',
                monthText: '月',
                yearText: '年',
                showNow: false,//是否显示当前日期
                startYear:2010,
                endYear:2099
            };
            $("#scroller").mobiscroll(opt);
        });
        
        //设置下拉选择框span中的值
		function setSpanHtml(obj,selectVal){
    		if(!selectVal){
    			selectVal = $(obj).find("option:selected").text();
    		}
			//$(obj).parent().find('div>span')[0].innerHTML=selectVal;
			$(obj).parent().find('div>span').html(selectVal);
			
			//获取option中value值。就是模板id
			var templateId=$("#sel option:selected").val();
			//调用显示模板接口，在iframe里显示个人信息
			var url="http://demo.namex.cn:4005/OA/Moblie/EmployeeCardPicture.aspx?appId="+appId+"&templateId="+templateId+"&oaflowId="+oaflowId+"&EmployeeNum="+EmployeeNum+"&EmployeeName="+EmployeeName+"&EmployeeNameEn="+EmployeeNameEn+"&FirstPosition="+FirstPosition+"&Mobile="+Mobile+"&Email="+Email+"&FirstDeptName="+FirstDeptName+"&FirstFax="+FirstFax+"&OfficePhone="+OfficePhone+"&FirstAddress="+FirstAddress+"&FourthDeptName="+FourthDeptName;
			$('#iframe_id').attr('src', url);
		} 
		
		//发送（保存ezcard数据）
		function send(){
			if(!checkForm()){
	    		return false;
	    	}
	    	var ezCardDate=$("#scroller").val();
	    	var ezCardTemplateId=$("#sel option:selected").val();
	    	var ezCardNum=$('#ezCardNum').val();
	    	var ezCardAddress=$('#ezCardAddress').val();
	    	var address="saveEzCardForm.controller?ezCardDate="+ezCardDate+"&ezCardTemplateId="+ezCardTemplateId+"&ezCardNum="+ezCardNum+"&ezCardAddress="+ezCardAddress+"&oaflowId="+oaflowId;
	    	$.ajax({
				url : address,
				type : "post",
				success : function(infoId){
					sendFlow(infoId);
				}
			});
		}
		
		//发起流程
		function sendFlow(infoId){
			var address="";
			var mainLinkFile = '/defaultroot/ezcardAction!modify.action';
			if(process_type=='0'){//老流程
				address="sendOldFlow.controller?processId="+processId+"&mainLinkFile="+mainLinkFile+"&infoId="+infoId;
			}else if(process_type=='1'){//新流程
				address="sendNewFlow.controller?processId="+processId+"&mainLinkFile="+mainLinkFile+"&infoId="+infoId;
			}
			window.location=address;
		}
		
		//校验表单（申请日期，选择模板，确认模板）
		function checkForm(){
			var eaCardDate = $('#scroller').val();
			var templateId=$("#sel option:selected").val();
			if(eaCardDate==''){
				alert('请填写申请日期！');
    			return false;
			}
			if(templateId==''){
				alert('请选择模板！');
    			return false;
			}
			//获取订购信息（接口）
			var ezcardUrl = "http://demo.namex.cn:4005/OA/GetOaFlowInfo.aspx";
			var address="ajaxGetInfo.controller?ezcardUrl="+ezcardUrl+"&appId="+appId+"&oaflowId="+oaflowId;
			$.ajax({
				url:address,
				dataType:'json',
				type:'post',
				async:false,    //同步，
				success:function(data){
					if(data !=null){
						$('#ezCardNum').val(data.Num);
						$('#ezCardAddress').val(decodeURIComponent(data.Address));
					}	
				}
			});
			
			if($('#ezCardNum').val() =="" || $('#ezCardAddress').val() ==""){
				alert('请确认模板！');
				return false;
			}
			return true;
		}
		
		
    </script>