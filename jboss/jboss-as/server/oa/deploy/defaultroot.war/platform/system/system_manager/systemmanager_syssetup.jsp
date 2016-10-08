<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/public/include/init.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);

Map sysSetupMap = (Map)request.getAttribute("sysSetupMap");
String options = (String)sysSetupMap.get("options");
String attachLimitSize = (String)sysSetupMap.get("attachLimitSize");
String limitSize = (String)sysSetupMap.get("limitSize");
String wfOverDate = (String)sysSetupMap.get("wfOverDate");
String workLog = (String)sysSetupMap.get("workLog");
String[] historyMailInfo = (String[])sysSetupMap.get("historyMailInfo");
String historyLog = (String)sysSetupMap.get("historyLog");
String logSaveDays = (String)sysSetupMap.get("logSaveDays");
String logRunHour = (String)sysSetupMap.get("logRunHour");
String htmlFontType = (String)sysSetupMap.get("htmlFontType");
String htmlWordSize = (String)sysSetupMap.get("htmlWordSize");
String[] mailRemindType = (String[])sysSetupMap.get("mailRemindType");
String mobileOA_startTimeHH = (String)sysSetupMap.get("mobileOA_startTimeHH");
String mobileOA_startTimemm = (String)sysSetupMap.get("mobileOA_startTimemm");
String mobileOA_endTimeHH = (String)sysSetupMap.get("mobileOA_endTimeHH");
String mobileOA_endTimemm = (String)sysSetupMap.get("mobileOA_endTimemm");
String mailBoxSize = (String)sysSetupMap.get("mailBoxSize");
String mailNum = (String)(sysSetupMap.get("mailNum")==null?"":sysSetupMap.get("mailNum"));
String netDiskSize = (String)sysSetupMap.get("netDiskSize");
Boolean used = (Boolean)sysSetupMap.get("used");
String captcha = (String)sysSetupMap.get("captcha");
String accountscase = (String)sysSetupMap.get("accountscase");
String wordlimitsize = (String)sysSetupMap.get("wordlimitsize");
String workflowType = (String)sysSetupMap.get("workflowType");
String usemail = (String)sysSetupMap.get("usemail");
String attachPreview = (String)sysSetupMap.get("attachPreview");
String pageFontSize = (String)sysSetupMap.get("pageFontSize");
String resetPassword = (String)sysSetupMap.get("resetPassword");
String location = (String)sysSetupMap.get("location");
String wxlocation = (String)sysSetupMap.get("wxlocation");
String yibo_flag = (String)sysSetupMap.get("yibo_flag");
String oa_PDF = (String)sysSetupMap.get("oa_PDF");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>系统设置</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@ include file="/public/include/meta_base.jsp"%>
</head>
<body class="Pupwin">
<div class="BodyMargin_10" style="padding-top:5px;">
    <div class="docBoxNoPanel">

        <s:form name="dataForm" id="dataForm" action="/SysSetup!update.action" method="post">
        <table class="Table_bottomline" border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td>系统设置：</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>附件上传：</td>
                <td>
                    <input type="radio" value="0" id="attach0" name="attach" <%if(options.charAt(0)=='0'){%>checked<%}%> onclick="javascript:chg('0');">FTP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="attach1" name="attach" <%if(options.charAt(0)=='1'){%>checked<%}%> onclick="javascript:chg('1');">HTTP &nbsp;&nbsp;<span id="span_isEncrypt" style="display:none"><input type="checkbox" id="isEncrypt" name="isEncrypt" value="1" <%if(options.length() > 10 && options.charAt(10)=='1'){%>checked<%}%>>附件加密存储</span>
                </td>
            </tr>
            <tr id="tr_ftpdown" style="display:none">
                <td>&nbsp;</td>
                <td>附件下载：</td>
                <td>
                    <input type="radio" value="0" id="downloadType0" name="downloadType">FTP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="downloadType1" name="downloadType" checked>HTTP
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>附件大小：</td>
                <td>
                    <input type="radio" value="0" id="attachLimit0" name="attachLimit" checked onclick="showAttachSize();">不限制&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="attachLimit1" name="attachLimit" onclick="showAttachSize();" <%if(attachLimitSize.startsWith("1")){%>checked<%}%>>限制 &nbsp;&nbsp;<span id="attachSizeSpan" <%if(attachLimitSize.startsWith("1")){}else{%>style="display:none"<%}%>><input type="text" id="attachLimitSize" name="attachLimitSize" class="inputText" style="width:40px" value="<%=limitSize%>" maxlength="6">&nbsp;M</span>
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>登录验证码：</td>
                <td>
                    <input type="radio" value="0" id="captcha0" name="captcha" <%if("0".equals(captcha)){%>checked<%}%>>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="captcha1" name="captcha" <%if("1".equals(captcha)){%>checked<%}%>>使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="2" id="captcha2" name="captcha" <%if("2".equals(captcha)){%>checked<%}%>>连续输入错误时使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>账号大小写：</td>
                <td>
                    <input type="radio" value="0" id="accountscase0" name="accountscase" <%if("0".equals(accountscase)){%>checked<%}%>>不区分&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="accountscase1" name="accountscase" <%if("1".equals(accountscase)){%>checked<%}%>>区分
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>手写意见：</td>
                <td>
                    <input type="radio" value="0" id="sign0" name="sign" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="sign1" name="sign" <%if(options.charAt(1)=='1'){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>电子签章：</td>
                <td>
                    <input type="radio" value="0" id="signature0" name="signature" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="signature1" name="signature" <%if(options.charAt(7)=='1'){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>短信：</td>
                <td>
                    <input type="radio" value="0" id="message0" name="message" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="message1" name="message" <%if(options.charAt(2)=='1'){%>checked<%}%>>使用
                </td>
            </tr>
            <tr style="display:none">
                <td>&nbsp;</td>
                <td>图形工作流：</td>
                <td>
                    <input type="radio" value="0" id="potoflow0" name="potoflow" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="potoflow1" name="potoflow" <%if(options.charAt(3)=='1'){%>checked<%}%>>使用
                </td>
            </tr>
            <tr <%if(!used.booleanValue()){%>style="display=none"<%}%>>
                <td>&nbsp;</td>
                <td>在线感知：</td>
                <td>
                    <input type="radio" value="0" id="rtx0" name="rtx" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="rtx1" name="rtx" <%if(options.charAt(4)=='1'){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>附件在线预览：</td>
                <td>
                    <input type="radio" value="0" id="attachPreview0" name="attachPreview" <%if("0".equals(attachPreview)){%>checked<%}%>>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="attachPreview1" name="attachPreview" <%if("1".equals(attachPreview)){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>WORD编辑：</td>
                <td>
                    <!--  <input type="checkbox" value="0" id="word0" name="word" checked onclick="chgWord(0);">不使用&nbsp;&nbsp;&nbsp;-->
                    <input type="checkbox" value="<%=options.charAt(5) %>" id="word1" name="word" <%if(options.charAt(5)=='1'){%>checked<%}%> 
                     onclick="chgWord1(this);"/>网页端&nbsp;&nbsp;&nbsp;
                    <input type="checkbox" value="<%=options.charAt(16) %>" id="word0" name="evoword"  <%if(options.length()>16&&options.charAt(16)=='1'&&"0".equals(oa_PDF)){%>checked<%}%> onclick="chgWord0(this);"  <%if("1".equals(oa_PDF)){%>disabled<%}%> />EVO端
                    <span id="wordSizeSpan" <%if(options.charAt(5)!='1'&&options.charAt(16)!='1'){%>style="display:none"<%}%> >&nbsp;&nbsp;附件大小限制&nbsp;&nbsp;<input type="text" id="wordlimitsize" name="wordlimitsize" class="inputText" style="width:40px" value="<%=wordlimitsize%>" maxlength="3">&nbsp;M</span>
                </td>
            </tr>
			<tr>
                <td>&nbsp;</td>
                <td>PDF批注：</td>
                <td>
                    <input type="radio" value="0" id="oa_PDF0" name="oa_PDF" onClick="chgPDF0(this)" <%if("0".equals(oa_PDF)){%>checked<%}%>>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="oa_PDF1" name="oa_PDF" onClick="chgPDF1(this)" <%if("1".equals(oa_PDF)){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>工作流引擎：</td>
                <td>
                    <input type="radio" value="0" id="workflowType0" name="workflowType" <%if("0".equals(workflowType)){%>checked<%}%>>仅使用ezFLOW引擎&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="workflowType1" name="workflowType" <%if("1".equals(workflowType)){%>checked<%}%>>仅使用老引擎&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="2" id="workflowType2" name="workflowType" <%if("2".equals(workflowType)){%>checked<%}%>>新老引擎都支持
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>工作流程超期判断：</td>
                <td>
                    <input type="radio" value="0" id="wfOverDate0" name="wfOverDate" checked onclick="showWfOverDate();">自然天&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="wfOverDate1" name="wfOverDate" <%if("1".equals(wfOverDate)){%>checked<%}%> onclick="showWfOverDate();">工作日&nbsp;<span id="wfOverDateSpan" style="display:<%="1".equals(wfOverDate)?" ":"none"%>"><input type="button" class="btnButton4font" onclick="setWorkDate()" value="设&nbsp;&nbsp;&nbsp;置"></span>
                </td>
            </tr>
            <tr style="display:none">
                <td>&nbsp;</td>
                <td>信息未查看用户：</td>
                <td>
                    <input type="radio" value="0" id="InfoNotView0" name="InfoNotView" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="InfoNotView1" name="InfoNotView" <%if(options.length()>12 && options.charAt(12)=='1'){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>工作日志维护：</td>
                <td>
                    <input type="radio" value="0" id="worklog_rad0" name="worklog_rad" <%=workLog.equals("0")? "checked='checked'": ""%>onclick="wkCk(0);">不允许&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="worklog_rad1" name="worklog_rad" onclick="wkCk(1);" <%=workLog.equals("0")? "": "checked='checked'"%>>允许 <span id="worklog_sp" style="<%=workLog.equals("0")?"display:none ":" "%>"><input type="text" id="worklog" name="worklog" class="inputText" style="width:30px" value="<%=workLog%>" maxlength="3"> 天之内维护</span>
                </td>
            </tr>
            <tr style="display:none">
                <td>&nbsp;</td>
                <td>同一用户同时登录：</td>
                <td>
                    <input type="radio" value="0" id="userLoginType0" name="userLoginType" <%if(options.length()>11 && options.charAt(11)=='0'){%>checked<%}%>>不允许&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="userLoginType1" name="userLoginType" <%if(options.length()>11 && options.charAt(11)!='0'){%>checked<%}%>>允许
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>邮件群发：</td>
                <td>
                    <input type="radio" value="0" id="emailSend0" name="emailSend" <%if((options.length()>8 && options.charAt(8)=='0')||options.length()<=8){%>checked<%}%>>不控制&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="emailSend1" name="emailSend" <%if(options.length()>8 && options.charAt(8)!='0'){%>checked<%}%>>控制
                </td>
            </tr>
            <tr style="display:none">
                <td>&nbsp;</td>
                <td>内部联系人查看：</td>
                <td>
                    <input type="radio" value="0" id="innerPerson0" name="innerPerson" <%if(options.length()>9 && options.charAt(9)=='0'){%>checked<%}%>>不控制&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="innerPerson1" name="innerPerson" <%if(options.length()>9 && options.charAt(9)!='0'){%>checked<%}%>>控制
                </td>
            </tr>
            <tr style="display:">
                <td>&nbsp;</td>
                <td>历史邮件：</td>
                <td nowrap="nowrap">
                    <input type="radio" value="0" id="historyMail0" name="historyMail" onclick="javascript:changeHistoryMail('0');" checked/>不启用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="historyMail1" name="historyMail"  onclick="javascript:changeHistoryMail('1');" <%if(historyMailInfo[0].equals("1")){%>checked<%}%>/>启用
                    <span id="historyMail_span" style="display:none"><select id="saveDays" name="saveDays" class="selectlist" style="width:70px;"  >
                        <option value="15" <%if(historyMailInfo[1].equals("15"))out.print("selected");%>>15天</option>
                        <option value="30" <%if(historyMailInfo[1].equals("30"))out.print("selected");%>>1个月</option>
                        <option value="60" <%if(historyMailInfo[1].equals("60"))out.print("selected");%>>2个月</option>
                        <option value="90" <%if(historyMailInfo[1].equals("90"))out.print("selected");%>>3个月</option>
                        <option value="180" <%if(historyMailInfo[1].equals("180"))out.print("selected");%>>6个月</option>
                        <option value="360" <%if(historyMailInfo[1].equals("360"))out.print("selected");%>>12个月</option>
                        <option value="450" <%if(historyMailInfo[1].equals("450"))out.print("selected");%>>18个月</option>
                        <option value="720" <%if(historyMailInfo[1].equals("720"))out.print("selected");%>>24个月</option>
                    </select>之前的邮件转入历史邮件，在
                   
                    <select id="runHour" name="runHour" class="selectlist" style="width:40px;">
                        <%for(int sTime=0;sTime<24;sTime++){%>
                        <option value="<%=sTime%>" <%if(historyMailInfo[2].equals(sTime+""))out.print("selected");%>><%=sTime%></option>
                        <%}%>
                    </select>点运行
                    </span>
                </td>
            </tr>
            <tr id="historyMail_tr" style="display:none">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><font color="red">&nbsp;如果启用历史邮件，则历史邮件只能查看，不能进行回复、转发等操作。</font></td>
            </tr>
            <tr style="display:">
                <td>&nbsp;</td>
                <td>历史日志：</td>
                <td nowrap="nowrap">
                    <input type="radio" value="0" id="historyLog0" name="historyLog" onclick="javascript:changeHistoryLog('0');" checked>不启用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="historyLog1" name="historyLog" onclick="javascript:changeHistoryLog('1');" <%if(historyLog.equals("1")){%>checked<%}%>>启用
                    <span id="historyLog_span" style="display:none"><select id="logSaveDays" name="logSaveDays" class="selectlist" style="width:40px;">
                    <%for(int sDay=1;sDay<=60;sDay++){%>
                        <option value="<%=sDay%>" <%if(logSaveDays.equals(sDay+""))out.print("selected");%>><%=sDay%></option>
                    <%}%>
                    </select>天之前的日志转入历史日志，在
                    <select id="logRunHour" name="logRunHour" class="selectlist" style="width:40px;">
                    <%for(int sTime=0;sTime<24;sTime++){%>
                        <option value="<%=sTime%>" <%if(logRunHour.equals(sTime+""))out.print("selected");%>><%=sTime%></option>
                    <%}%>
                    </select>点运行
                    </span>
                </td>
            </tr>
            <tr style="display:">
                <td>&nbsp;</td>
                <td>Html编辑器默认字体：</td>
                <td>
                    <select id="fontType" name="fontType" class="selectlist" style="width:125px;">
                        <option value="宋体" <%if(htmlFontType.equals("宋体"))out.print("selected");%>>宋体</option>
                        <option value="黑体" <%if(htmlFontType.equals("黑体"))out.print("selected");%>>黑体</option>
                        <option value="楷体" <%if(htmlFontType.equals("楷体"))out.print("selected");%>>楷体</option>
                        <option value="仿宋" <%if(htmlFontType.equals("仿宋"))out.print("selected");%>>仿宋</option>
                        <option value="隶书" <%if(htmlFontType.equals("隶书"))out.print("selected");%>>隶书</option>
                        <option value="幼圆" <%if(htmlFontType.equals("幼圆"))out.print("selected");%>>幼圆</option>
                        <option value="Arial" <%if(htmlFontType.equals("Arial"))out.print("selected");%>>Arial</option>
                        <option value="Arial Black" <%if(htmlFontType.equals("Arial Black"))out.print("selected");%>>Arial Black</option>
                        <option value="Arial Narrow" <%if(htmlFontType.equals("Arial Narrow"))out.print("selected");%>>Arial Narrow</option>
                        <option value="Brush Script MT" <%if(htmlFontType.equals("Brush Script MT"))out.print("selected");%>>Brush Script MT</option>
                        <option value="Century Gothic" <%if(htmlFontType.equals("Century Gothic"))out.print("selected");%>>Century Gothic</option>
                        <option value="Comic Sans MS" <%if(htmlFontType.equals("Comic Sans MS"))out.print("selected");%>>Comic Sans MS</option>
                        <option value="Courier" <%if(htmlFontType.equals("Courier"))out.print("selected");%>>Courier</option>
                        <option value="Courier New" <%if(htmlFontType.equals("Courier New"))out.print("selected");%>>Courier New</option>
                        <option value="MS Sans Serif" <%if(htmlFontType.equals("MS Sans Serif"))out.print("selected");%>>MS Sans Serif</option>
                        <option value="Script" <%if(htmlFontType.equals("Script"))out.print("selected");%>>Script</option>
                        <option value="System" <%if(htmlFontType.equals("System"))out.print("selected");%>>System</option>
                        <option value="Times New Roman" <%if(htmlFontType.equals("Times New Roman"))out.print("selected");%>>Times New Roman</option>
                        <option value="Verdana" <%if(htmlFontType.equals("Verdana"))out.print("selected");%>>Verdana</option>
                        <option value="Wide Latin" <%if(htmlFontType.equals("Wide Latin"))out.print("selected");%>>Wide Latin</option>
                        <option value="Wingdings" <%if(htmlFontType.equals("Wingdings"))out.print("selected");%>>Wingdings</option>
                    </select>
                    <select id="wordSize" name="wordSize" class="selectlist" style="width:60px;">
                        <option value="26pt" <%if(htmlWordSize.equals("26pt"))out.print("selected");%>>1号</option>
                        <option value="22pt" <%if(htmlWordSize.equals("22pt"))out.print("selected");%>>2号</option>
                        <option value="16pt" <%if(htmlWordSize.equals("16pt"))out.print("selected");%>>3号</option>
                        <option value="14pt" <%if(htmlWordSize.equals("14pt"))out.print("selected");%>>4号</option>
                        <option value="10.5pt" <%if(htmlWordSize.equals("10.5pt"))out.print("selected");%>>5号</option>
                        <option value="7.5pt" <%if(htmlWordSize.equals("7.5pt"))out.print("selected");%>>6号</option>
                        <option value="5.5pt" <%if(htmlWordSize.equals("5.5pt"))out.print("selected");%>>7号</option>
                        <option value="12px" <%if(htmlWordSize.equals("12px"))out.print("selected");%>>12px</option>
                        <option value="14px" <%if(htmlWordSize.equals("14px"))out.print("selected");%>>14px</option>
                        <option value="16px" <%if(htmlWordSize.equals("16px"))out.print("selected");%>>16px</option>
                        <option value="18px" <%if(htmlWordSize.equals("18px"))out.print("selected");%>>18px</option>
                        <option value="20px" <%if(htmlWordSize.equals("20px"))out.print("selected");%>>20px</option>
                        <option value="22px" <%if(htmlWordSize.equals("22px"))out.print("selected");%>>22px</option>
                        <option value="24px" <%if(htmlWordSize.equals("24px"))out.print("selected");%>>24px</option>
                        <option value="26px" <%if(htmlWordSize.equals("26px"))out.print("selected");%>>26px</option>
                        <option value="30px" <%if(htmlWordSize.equals("30px"))out.print("selected");%>>30px</option>
                        <option value="36px" <%if(htmlWordSize.equals("36px"))out.print("selected");%>>36px</option>
                        <option value="48px" <%if(htmlWordSize.equals("48px"))out.print("selected");%>>48px</option>
                    </select>
                </td>
            </tr>
            <tr style="display:none;">
                <td>&nbsp;</td>
                <td>界面字体：</td>
                <td>
                    <input type="radio" value="14" id="pageFontSize0" name="pageFontSize" <%if("14".equals(pageFontSize)){%>checked<%}%>>大号(14)&nbsp;
                    <input type="radio" value="12" id="pageFontSize1" name="pageFontSize" <%if("12".equals(pageFontSize)){%>checked<%}%>>小号(12)
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>与ezSITE结合：</td>
                <td>
                    <input type="radio" value="0" id="ezsite0" name="ezsite" checked>否&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="ezsite1" name="ezsite" <%if(options.length()>6 && options.charAt(6)=='1'){%>checked<%}%>>是
                </td>
            </tr>
            <tr style='display:none'>
                <td>&nbsp;</td>
                <td>移动办公信息推送：</td>
                <td>
                    <input type="radio" value="0" id="isMobilePush0" name="isMobilePush" checked>不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="isMobilePush1" name="isMobilePush" <%if(options.length()>13 && options.charAt(13)=='1'){%>checked<%}%>>使用
                </td>
            </tr>

            <tr style="display:none;">
                <td>&nbsp;</td>
                <td>使用邮件：</td>
                <td>
                    <input type="radio" value="0" id="usemail0" name="usemail" <%if("0".equals(usemail)){%>checked<%}%>>外部邮件&nbsp;
                    <input type="radio" value="1" id="usemail1" name="usemail" <%if("1".equals(usemail)){%>checked<%}%>>内部邮件&nbsp;
                    <input type="radio" value="2" id="usemail2" name="usemail" <%if("2".equals(usemail)){%>checked<%}%>>全部使用
                </td>
            </tr>

            <tr>
                <td>&nbsp;</td>
                <td>邮件提醒方式：</td>
                <td>
                    <input type="radio" value="1" id="mailRemindType0" name="mailRemindType" onclick="changeMailRemidType('1')" <%="1".equals(mailRemindType[0]) || "2".equals(mailRemindType[0])? "checked": ""%>>外部邮件&nbsp;
                    <input type="radio" value="0" id="mailRemindType1" name="mailRemindType" onclick="changeMailRemidType('0')" <%=(!"1".equals(mailRemindType[0]) && !"2".equals(mailRemindType[0]))? "checked": ""%>>内部邮件
                </td>
            </tr>
            <tr id="mailSMTP_span" style="display:none">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td valign="top">
                    <span style="padding-bottom:3px;line-height:100%;">
                    <div style="padding-left:20px;display:inline;">
                        <table border="0" cellpadding="0" cellspacing="0" style="margin-top:-20px;">
                            <tr>
                                <td>SMTP服务器地址：</td>
                                <td><input class="inputText" type="text" id="stmpAddr" name="stmpAddr" maxlength="50" value="<%=mailRemindType[1]%>" style="width:120px;"></td>
                                <td>&nbsp;&nbsp;电子邮件地址：</td>
                                <td><input class="inputText" type="text" id="mailAddr" name="mailAddr" maxlength="50" value="<%=mailRemindType[3]%>" style="width:120px;"></td>
                            </tr>
                            <tr>
                                <td>帐号：</td>
                                <td><input class="inputText" type="text" id="mailAccount" name="mailAccount" maxlength="50" value="<%=mailRemindType[4]%>" style="width:120px;"></td>
                                <td>&nbsp;&nbsp;密码：</td>
                                <td><input class="inputText" type="password" id="mailPass" name="mailPass" maxlength="50" value="<%=mailRemindType[5]%>" style="width:120px;"></td>
                            </tr>
                            <tr>
                                <td>邮件提醒发件人：</td>
                                <td>
                                    <input type="radio" value="0" id="sendMailType0" name="sendMailType" checked>系统账号&nbsp;
                                    <input type="radio" value="1" id="sendMailType1" name="sendMailType" <%="2".equals(mailRemindType[0])? "checked": ""%>>用户账号
                                </td>
                            </tr>
                        </table>
                    </div>
                    </span>
                </td>
            </tr>
            <tr style="display:none;">
                <td>&nbsp;</td>
                <td>移动OA位置服务：</td>
                <td>
                    <input type="radio" value="0" id="isMobilePositionService0" name="isMobilePositionService" checked onclick="isMobileCk(0);">不使用&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="isMobilePositionService1" name="isMobilePositionService" <%if(options.length()>15 && options.charAt(15)=='1'){%>checked<%}%> onclick="isMobileCk(1);">使用&nbsp;<span id="isMobilePos_sp" style="<%if(options.length() > 15 && options.charAt(15)=='1'){out.print("display:none");}else{out.print("display:none ");}%>">
                    开启时间:
                    <select id="startTime_HH" name="startTime_HH" class="selectlist" style="width:40px;">
                    <%for(int i=0;i<24;i++){
                    String ii = ((i+"").length()<2)?"0"+i:""+i;
                    %>
                        <option value="<%=ii%>" <%if(ii.equals(mobileOA_startTimeHH))out.print("selected");%> ><%=ii%></option>
                    <%}%>
                    </select>时
                    <select id="startTime_mm" name="startTime_mm" class="selectlist" style="width:40px;">
                    <%for(int i=0;i<60;i++){
                    String ii = ((i+"").length()<2)?"0"+i:""+i;
                    %>
                        <option value="<%=ii%>" <%if(ii.equals(mobileOA_startTimemm))out.print("selected");%> ><%=ii%></option>
                    <%}%>
                    </select>分 &nbsp;
                    结束时间:
                    <select id="endTime_HH" name="endTime_HH" class="selectlist" style="width:40px;">
                    <%for(int i=0;i<24;i++){
                    String ii = ((i+"").length()<2)?"0"+i:""+i;
                    %>
                        <option value="<%=ii%>" <%if(ii.equals(mobileOA_endTimeHH))out.print("selected");%> ><%=ii%></option>
                    <%}%>
                    </select>时
                    <select id="endTime_mm" name="endTime_mm" class="selectlist" style="width:40px;">
                    <%for(int i=0;i<60;i++){
                    String ii = ((i+"").length()<2)?"0"+i:""+i;
                    %>
                        <option value="<%=ii%>" <%if(ii.equals(mobileOA_endTimemm))out.print("selected");%> ><%=ii%></option>
                    <%}%>
                    </select>分
                    </span>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>找回密码：</td>
                <td>
                    <input type="radio" value="0" id="resetPassword0" name="resetPassword" checked <%if("0".equals(resetPassword)){%>checked<%}%>>不使用&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="resetPassword1" name="resetPassword" <%if("1".equals(resetPassword)){%>checked<%}%>>使用
                    &nbsp;&nbsp;&nbsp;&nbsp;<span class="MustFillColor">需要配置并使用短信功能方可使用此功能</span>
                </td>
            </tr>
            <tr >
                <td>&nbsp;</td>
                <td>移动考勤：</td>
                <td>
                    <input type="checkbox" value="<%=location%>" id="location" name="location" <%if("1".equals(location)){%>checked<%}%> 
                     onclick="OAlocation(this)"/>客户端定位&nbsp;&nbsp;&nbsp;
                    <input type="checkbox" value="<%=wxlocation%>" id="wxlocation" name="wxlocation"  <%if("1".equals(wxlocation)){%>checked<%}%>
                     onclick="wxlocationaction(this)"/>微信定位
                </td>
            </tr>
             <tr>
                <td>&nbsp;</td>
                <td>易播栏目：</td>
                <td>
                    <input type="radio" value="0" id="yibo_flag1" name="yibo_flag" checked <%if("0".equals(yibo_flag)){%>checked<%}%>>不使用&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" value="1" id="yibo_flag2" name="yibo_flag" <%if("1".equals(yibo_flag)){%>checked<%}%>>使用
                </td>
            </tr>
            <tr>
                <td nowrap>容量设置：</td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">内部邮件容量：
                    <input type="text" id="mailBoxSize" name="mailBoxSize" class="inputText" size="5" maxlength="6" value="<%=mailBoxSize%>" style="width:60px;">&nbsp;M&nbsp;&nbsp; 邮件数量：
                    <input type="text" id="mailNum" name="mailNum" class="inputText" size="5" maxlength="6" value="<%=mailNum%>" style="width:60px;">&nbsp;封</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">我的文档容量：
                    <input type="text" id="netDiskSize" name="netDiskSize" class="inputText" size="5" maxlength="6" value="<%=netDiskSize%>" style="width:60px;">&nbsp;M
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <input type="button" class="btnButton4font" onClick="javascript:save();" value="<s:text name="comm.save"/>"/>
                </td>
            </tr>
        </table>
        </s:form>

	 </div>
</div>
</body>
<script type="text/javascript">
//*************************************下面的函数属于公共的或半自定义的*************************************************//  

//设置表单为异步提交  
initDataFormToAjax({
    "dataForm": 'dataForm',
    "queryForm": '',
    "tip": '<s:text name="comm.save1"/>',
    "reset":'no'
});

//*************************************下面的函数属于各个模块 完全 自定义的*************************************************//

$(document).ready(function(){
    initPage();

    <%if(options.charAt(0)=='1'){%>
    chg('1');
    <%}%>

    changeMailRemidType('<%=mailRemindType[0]%>');
});


 
function save() {
 //var  myselect=document.getElementById("saveDays");
 //var index=myselect.selectedIndex ;
 //alert(myselect.options[index].text);

    if (isNaN($('#wordlimitsize').val()) || parseInt($('#wordlimitsize').val()) < 0 || $.trim($('#wordlimitsize').val())=='') {
        whir_alert("WORD编辑附件大小必须为正整数！", function(){
            $('#wordlimitsize').focus();
            return false;
        });
        $('#wordlimitsize').focus();
        return;
    }

    var worklog = $.trim($('#worklog').val());
    if ($('#worklog_rad1').attr('checked') == 'checked' && (isNaN(worklog) || parseInt(worklog) <= 0 || worklog == 'e' || worklog.indexOf('.')!=-1 || worklog=='')) {
        whir_alert("工作日志维护天数必须为正整数！", function(){
            $('#worklog').focus();
            return false;
        });
        $('#worklog').focus();
        return;
    }
   
    if ($.trim($('#mailBoxSize').val())=='') {
        whir_alert("内部邮件容量不能为空！", function(){
            $('#mailBoxSize').focus();
            return false;
        });
        $('#mailBoxSize').focus();
        return;
    }
    
    if (isNaN($('#mailBoxSize').val()) || parseInt($('#mailBoxSize').val()) < 0 ) {
        whir_alert("内部邮件容量必须为正整数！", function(){
            $('#mailBoxSize').focus();
            return false;
        });
        $('#mailBoxSize').focus();
        return;
    }

    if ($.trim($('#netDiskSize').val())=='') {
        whir_alert("我的文档容量不能为空！", function(){
            $('#netDiskSize').focus();
            return false;
        });
        $('#netDiskSize').focus();
        return;
    }
    if (isNaN($('#netDiskSize').val()) || parseInt($('#netDiskSize').val()) < 0) {
        whir_alert("我的文档容量必须为正整数！", function(){
            $('#netDiskSize').focus();
            return false;
        });
        $('#netDiskSize').focus();
        return;
    }
    if (parseInt($('#netDiskSize').val(), 10) > 2048) {
        whir_alert("我的文档容量不能大于2048M！", function(){
            $('#netDiskSize').focus();
            return false;
        });
        $('#netDiskSize').focus();
        return;
    }

    if ($.trim($('#mailNum').val())=='') {
        whir_alert("邮件数量不能为空！", function(){
            $('#mailNum').focus();
            return false;
        });
        $('#mailNum').focus();
        return;
    }    
    if ($('#mailNum').val().replace(" ", "").length == 0) {
        whir_alert("请输入邮件数量！", function(){
            $('#mailNum').focus();
            return false;
        });
        $('#mailNum').focus();
        return;
    }
    if (isNaN($('#mailNum').val()) || parseInt($('#mailNum').val()) < 0) {
        whir_alert("邮件数量必须为正整数！", function(){
            $('#mailNum').focus();
            return false;
        });
        $('#mailNum').focus();
        return;
    }

    if ($('#attachLimit1').attr('checked') == 'checked') {
        if (isNaN($('#attachLimitSize').val()) || parseInt($('#attachLimitSize').val()) < 0 || $('#attachLimitSize').val().indexOf(".") >= 0||$.trim($('#attachLimitSize').val())=='') {
            whir_alert("附件限制大小必须为正整数！", function(){
                $('#attachLimitSize').focus();
                return false;
            });
            $('#attachLimitSize').focus();
            return;
        } else if (parseInt($('#attachLimitSize').val()) == 0) {
            whir_alert("请设置有效的附件大小！", function(){
                $('#attachLimitSize').focus();
                return false;
            });
            $('#attachLimitSize').focus();
            return;
        }
    } else {
        $('#attachLimitSize').val("0");
    }

    if ($('#mailRemindType0').attr('checked') == 'checked') {
        if ($('#stmpAddr').val() == "") {
            whir_alert("请输入SMTP服务器地址！", function(){
                $('#stmpAddr').focus();
                return false;
            });
            $('#stmpAddr').focus();
            return;
        }
        var r = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
        if ($('#mailAddr').val() == ""||!r.test($.trim($('#mailAddr').val())) ) {
            whir_alert("请输入正确的电子邮件地址！", function(){
                $('#mailAddr').focus();
                return false;
            });
            $('#mailAddr').focus();
            return;
        }
        if ($('#mailAccount').val() == "") {
            whir_alert("请输入帐号！", function(){
                $('#mailAccount').focus();
                return false;
            });
            $('#mailAccount').focus();
            return;
        }
        if ($('#mailPass').val() == "") {
            whir_alert("请输入密码！", function(){
                $('#mailPass').focus();
                return false;
            });            
            return;
        }
    }

    $('#mailNum').val(parseInt($('#mailNum').val()));//邮件数量格式化成整数
    $('#dataForm').submit();
    
}

function showAttachSize() {
    if ($('#attachLimit1').attr('checked') == 'checked') {
        $('#attachSizeSpan').css('display', '');
    } else {
        $('#attachSizeSpan').css('display', 'none');
        $('#attachLimitSize').val('');
    }
}

function changeHistoryMail(vtype) {
    if (vtype == "0") {
        $('#historyMail_span').css('display', 'none');
        $('#historyMail_tr').css('display', 'none');
    } else {
        $('#historyMail_span').css('display', '');
        $('#historyMail_tr').css('display', '');
    }
}

function initPage() {
    vtype = '<%=historyMailInfo[0]%>';
    if (vtype == "1") { //历史邮件启用
        $('#historyMail_span').css('display', '');
        $('#historyMail_tr').css('display', '');
    } else {
        $('#historyMail_span').css('display', 'none');
        $('#historyMail_tr').css('display', 'none');
    }

    changeHistoryLog('<%=historyLog%>');
}

//历史日志

function changeHistoryLog(vtype) {
    if (vtype == "0") {
        $('#historyLog_span').css('display', 'none');
    } else {
        $('#historyLog_span').css('display', '');
    }
}

function chg(val) {
    if (val == '0') {
        $('#span_isEncrypt').css('display', 'none');
        $('input:checkbox[id=isEncrypt]').each(function(){
            var chk = $(this);
            //chk.attr("checked", false);
            chk.removeAttr("checked");
            //chk.parent().removeClass("checked");
        });
    } else {
        $('#span_isEncrypt').css('display', '');
        $('#downloadType1').attr('checked', 'checked');
    }
}

function showWfOverDate() {
    if ($('#wfOverDate1').attr('checked') == 'checked') {
        $('#wfOverDateSpan').css('display', '');
    } else {
        $('#wfOverDateSpan').css('display', 'none');
    }
}

function changeMailRemidType(val) {
    if (val == '1' || val == '2') {
        $('#mailSMTP_span').css('display', '');
    } else {
        $('#mailSMTP_span').css('display', 'none');
    }
}

function wkCk(flag) {
    var worklog = <%=workLog%>;
    if (flag == 0) {
        $('#worklog_sp').css('display', 'none');
        $('#worklog').val(0);
    } else {
        $('#worklog_sp').css('display', '');
        if (worklog == 0) {
            $('#worklog').val(3);
        } else {
            $('#worklog').val(worklog);
        }
    }
}

function isMobileCk(flag) {
    /*if (flag == 0) {
        $('#isMobilePos_sp').css('display', 'none');
    } else {
        $('#isMobilePos_sp').css('display', '');
    }*/
}

function setWorkDate() {
    openWin({url:'<%=rootPath%>//WorkDay!initList.action', isPost:true, width:800, height:600, isScroll:'yes', isResizable:'yes', winName:'workday_setting'});
}

function chgWord1(obj){
	if(obj.checked){
		$(obj).val("1");
	}else{
		$(obj).val("0");
	}
    if($(obj).val()!=1&&$("#word0").val()!=1){
        $('#wordSizeSpan').hide();
    }else{
        $('#wordSizeSpan').show();
    }

}
function chgWord0(obj){
	if(obj.checked){
		$(obj).val("1");
	}else{
		$(obj).val("0");
	}
    if($("#word1").val()!=1&&$(obj).val()!=1){
        $('#wordSizeSpan').hide();
    }else{
        $('#wordSizeSpan').show();
    }

}

function OAlocation(obj){
	if(obj.checked){
		$(obj).val("1");
	}else {
		$(obj).val("0");
	}
	 if($("#wxlocation").val()==1&&$(obj).val()!=1){
		$("#wxlocation").val("0")
		$("#wxlocation").attr("checked",false);
	}
	
   

}
function wxlocationaction(obj){
	if(obj.checked){
		$(obj).val("1");
	}else {
		$(obj).val("0");
	}
	if($("#location").val()!=1&&$(obj).val()==1){
		$("#location").val("1")
		$("#location").attr("checked",true);
	}
	
}

function chgPDF1(obj){
	if(obj.checked){
		var word0 = $('#word0');
		word0.attr("checked", false);
		word0.attr("disabled",true);
	}
   

}
function chgPDF0(obj){
	if(obj.checked){
		var word0 = $('#word0');
		word0.attr("disabled",false);
		<%if(options.length()>16&&options.charAt(16)=='1'&&"0".equals(oa_PDF)){ %>
		word0.attr("checked", true);
		<%}%>
	}
   

}

//-->
</script>
</html>