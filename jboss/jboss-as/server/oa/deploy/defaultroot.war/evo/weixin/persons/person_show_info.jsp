<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=0,minimal-ui">
    <title>人员信息</title>
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.reset.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.icon.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.fa.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/template.style.css" />
    <link rel="stylesheet" href="/defaultroot/evo/weixin/template/css/alert/template.alert.css" />
</head>
<body>
<c:if test="${not empty docXml}">
	<x:parse xml="${docXml}" var="doc"/>
	<c:set var="EmpName"><x:out select="$doc//EmpName/text()" /></c:set>
	<c:set var="EmpEnglishName"><x:out select="$doc//EmpEnglishName/text()" /></c:set>
	<c:set var="EmpDepart"><x:out select="$doc//EmpDepart/text()" /></c:set>
	<c:set var="EmpSex"><x:out select="$doc//EmpSex/text()" /></c:set>
	<c:set var="EmpLivingPhoto"><x:out select="$doc//EmpLivingPhoto/text()" /></c:set>
	<c:set var="EmpPhone"><x:out select="$doc//EmpPhone/text()" /></c:set>
	<c:set var="EmpMobilePhone"><x:out select="$doc//EmpMobilePhone/text()" /></c:set>
	<c:set var="EmpBusinessPhone"><x:out select="$doc//EmpBusinessPhone/text()" /></c:set>
	<c:set var="EmpEmail"><x:out select="$doc//EmpEmail/text()" /></c:set>
	<c:set var="uId"><x:out select="$doc//id/text()" /></c:set>
	<c:set var="uCcounts"><x:out select="$doc//EmpUserAccounts/text()" /></c:set>

</c:if>
<section class="wh-section wh-section-topstatic">
    <aside class="wh-contact-info">
        <div class="contact-hdinfo">
            <hgroup>
                <h1><img src="/defaultroot/upload/peopleinfo/${EmpLivingPhoto}" onerror="this.src='/defaultroot/evo/weixin/images/head.png'" /></h1>
                <h2>${EmpName} ${LinkManEnName}</h2>
                <h3>${EmpDepart}</h3>
            </hgroup>
        </div>
        <div class="contact-nav">
            <div class="wh-container">
            	<a href="#" onclick="toMessage('${uCcounts}','${uId}')" class="contact-msg">
                    <span class="red"><i class="fa fa-commenting"></i>立即聊天</span> 
                </a> 
                <a href="javascript:void(0);" class="contact-msg" id="toEmpSms">
                	<span class="green"><i class="fa fa-comments-o"></i>发信息</span>
                </a>
                <a href="javascript:void(0);" class="contact-tel" id="toEmpTel">
                	<span class="blue"><i class="fa fa-phone"></i>打电话</span>
                </a>
				<a href="javascript:void(0);" class="contact-mail" id="toEmpEMail">
					<span class="oranger"><i class="fa fa-envelope-o"></i>写邮件</span>
				</a>
            </div>
        </div>
    </aside>
    <article class="wh-edit wh-edit-contact">
        <div>
            <table class="wh-table-edit">
                <tr>
                    <th>性别：</th>
                    <td><span class="edit-ipt-reslut-r"><c:choose><c:when test="${EmpSex eq '1'}">女</c:when><c:otherwise>男</c:otherwise></c:choose></span></td>
                </tr>
                <tr>
                    <th>职务：</th>
                    <td><span class="edit-ipt-reslut-r"><x:out select="$doc//EmpDuty/text()" /></span></td>
                </tr>
                <tr>
                    <th>办公电话：</th>
                    <td><span class="edit-ipt-reslut-r">${EmpBusinessPhone}</span></td>
                </tr>
                <tr>
                    <th>移动电话：</th>
                    <td><span class="edit-ipt-reslut-r">${EmpMobilePhone}<c:if test="${EmpPhone != ''}">,${EmpPhone}</c:if></span></td>
                </tr>
                <tr>
                    <th>电子信箱：</th>
                    <td><span class="edit-ipt-reslut-r"><a href="mailto:test@whir.net">${EmpEmail}</a></span></td>
                </tr>
            </table>
        </div>
    </article>
</section>
</body>
</html>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/zepto.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/touch.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/fx.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/template/js/alert/zepto.alert.js"></script>
<script type="text/javascript">
$(function(){
	setPhoneHref();
	setEmailHref();
})

function toMessage(uCcounts,uid){
	wx.openEnterpriseChat({
		userIds:uCcounts,
		groupName:'',
		success: function(res){
			
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

//设置拨打电话、发送短信---bad code,be ashamed of
function setPhoneHref(){
	var empPhone = "";
	var firstEmpPhone = '';
	var secondEmpPhone = '';
	if('${EmpPhone}' && !'${EmpMobilePhone}'){
		firstEmpPhone = "${EmpPhone}";
		empPhone = firstEmpPhone;
	}else if('${EmpMobilePhone}' && !'${EmpPhone}'){
		firstEmpPhone = "${EmpMobilePhone}";
		empPhone = firstEmpPhone;
	}else if('${EmpPhone}' && '${EmpMobilePhone}'){
		firstEmpPhone = '${EmpMobilePhone}';
		secondEmpPhone = '${EmpPhone}';
		empPhone = firstEmpPhone + ',' + secondEmpPhone;
	}
	var empBusinessPhone = "${EmpBusinessPhone}";
	var $toEmpSms = $("#toEmpSms");
	var $toEmpTel = $("#toEmpTel");
	if(empPhone && empBusinessPhone){
		//打电话操作
		var selectTelDom = '<select class="btn-bottom-pop" id="telSelect">'+
							'<option value="" selected="selected">取消</option>'+
	                        '<option value="'+empBusinessPhone+'">拨打办公电话</option>';
	    if(firstEmpPhone && secondEmpPhone){
	    	selectTelDom += '<option value="'+firstEmpPhone+'">拨打移动电话1</option><option value="'+secondEmpPhone+'">拨打移动电话2</option></select>';
	    }else{
	    	selectTelDom += '<option value="'+empPhone+'">拨打移动电话</option></select>';
	    }
		$toEmpTel.append(selectTelDom);
		var $telSelect = $('#telSelect');
		$telSelect.bind('change',function(){
			var telSelectVal = $telSelect.val();
			if(telSelectVal){
				$toEmpTel.attr("href","tel:"+telSelectVal).click();
				$toEmpTel.attr("href","javascript:void(0);");
			}
		});
		//发短信操作
		var selectSmsDom = '<select class="btn-bottom-pop" id="smsSelect">'+
							'<option value="" selected="selected">取消</option>'+
	                        '<option value="'+empBusinessPhone+'">给办公电话发送短信</option>';
		if(firstEmpPhone && secondEmpPhone){
	    	selectSmsDom += '<option value="'+firstEmpPhone+'">给移动电话1发送短信</option><option value="'+secondEmpPhone+'">给移动电话2发送短信</option></select>';
	    }else{
	    	selectSmsDom += '<option value="'+empPhone+'">给移动电话发送短信</option></select>';
	    }
		$toEmpSms.append(selectSmsDom);
		var $smsSelect = $('#smsSelect');
		$smsSelect.bind('change',function(){
			var smsSelectVal = $smsSelect.val();
			if(smsSelectVal){
				$toEmpSms.attr("href","sms:"+smsSelectVal).click();
				$toEmpSms.attr("href","javascript:void(0);");
			}
		});
	}else if(empPhone && !empBusinessPhone){
		// 区分移动电话1和移动电话2 ！YBDZ！
		if(firstEmpPhone && secondEmpPhone){
			//打电话操作
			var selectTelDom = '<select class="btn-bottom-pop" id="telSelect">'+
								'<option value="" selected="selected">取消</option>';
		    selectTelDom += '<option value="'+firstEmpPhone+'">拨打移动电话1</option><option value="'+secondEmpPhone+'">拨打移动电话2</option></select>';
			$toEmpTel.append(selectTelDom);
			var $telSelect = $('#telSelect');
			$telSelect.bind('change',function(){
				var telSelectVal = $telSelect.val();
				if(telSelectVal){
					$toEmpTel.attr("href","tel:"+telSelectVal).click();
					$toEmpTel.attr("href","javascript:void(0);");
				}
			});
			//发短信操作
			var selectSmsDom = '<select class="btn-bottom-pop" id="smsSelect">'+
								'<option value="" selected="selected">取消</option>';
	    	selectSmsDom += '<option value="'+firstEmpPhone+'">给移动电话1发送短信</option><option value="'+secondEmpPhone+'">给移动电话2发送短信</option></select>';
			$toEmpSms.append(selectSmsDom);
			var $smsSelect = $('#smsSelect');
			$smsSelect.bind('change',function(){
				var smsSelectVal = $smsSelect.val();
				if(smsSelectVal){
					$toEmpSms.attr("href","sms:"+smsSelectVal).click();
					$toEmpSms.attr("href","javascript:void(0);");
				}
			});
		}else{
			$toEmpSms.attr("href","sms:"+empPhone);
			$toEmpTel.attr("href","tel:"+empPhone);
		}
	}else if(!empPhone && empBusinessPhone){
		$toEmpSms.attr("href","sms:"+empBusinessPhone);
		$toEmpTel.attr("href","tel:"+empBusinessPhone);
	}else{
		$toEmpSms.attr("href","javascript:alert('抱歉！用户暂无电话信息。');");
		$toEmpTel.attr("href","javascript:alert('抱歉！用户暂无电话信息。');");
	}
}

//设置发送邮件链接
function setEmailHref(){
	var EmpEmail = '${EmpEmail}';
	var $toEmpEmail = $('#toEmpEMail');
	if(EmpEmail){
		$toEmpEmail.append('<select class="btn-bottom-pop" id="mailSelect">'+
							'<option value="cancel" selected="selected">取消</option>'+
	                        '<option value="inner">发送内部邮件</option>'+
	                      //  '<option value="'+EmpEmail+'">发送外部邮件</option>'+   TODO 外部邮件暂缺
	                     '</select>');
		$mailSelect = $('#mailSelect');
		$mailSelect.bind('change',function(){
			var mailSelectVal = $mailSelect.val();
			if(mailSelectVal == 'inner'){
				$toEmpEmail.attr("href","javascript:openSendInnerMail();").click();
			}else if(mailSelectVal && mailSelectVal != 'cancel'){
				$toEmpEmail.attr("href","mailto:"+mailSelectVal).click();
			}
			$toEmpEmail.attr("href","javascript:void(0);");
		});
	}else{
		$toEmpEmail.attr("href","javascript:openSendInnerMail();");
	}
}

//打开发送内部邮件界面
function openSendInnerMail(){
	window.location = '/defaultroot/mail/new.controller?openType=personSend&empName=${EmpName}&personId=${param.personId}';
}
</script>