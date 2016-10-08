<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@page import="com.whir.component.security.crypto.EncryptUtil"%>
<%@ include file="/public/include/init.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml" class="body_gray">
<head>
	<title><s:property value="information.informationTitle"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%@ include file="/public/include/meta_base.jsp"%>
	<%@ include file="/public/include/meta_detail.jsp"%>
	<style type="text/css">
		html{ overflow:auto;}
	</style>
	<s:if test="information.forbidCopy==1">
    <script type="text/javascript"> 
	<!-- 
	document.oncontextmenu=function(e){return false;} 
	// -->
	</script> 
	<style><!-- 
	body { 
	-moz-user-select:none; 
	} 
	--></style>
	</s:if>
</head>
<%
	String iso = request.getParameter("iso")!=null?request.getParameter("iso"):"";
	String path = "information";
	if(iso!=null && iso.equals("1")){
		path = "isodoc";
	}
	String userId = session.getAttribute("userId").toString();
	String canVindicate = request.getAttribute("canVindicate")!=null?request.getAttribute("canVindicate").toString():"false";//栏目维护权限
	String delComment = request.getAttribute("delComment")!=null?request.getAttribute("delComment").toString():"0";//评论修改删除权限
	String fileServer = com.whir.component.config.ConfigReader.getFileServer(request.getRemoteAddr());
	List alist = new ArrayList();
	String content = request.getAttribute("content").toString();
	
	//2013-09-02-----修改开始
	String gd     =(request.getParameter("gd")==null || "null".equals(request.getParameter("gd")))?"":request.getParameter("gd");
	String gdType = EncryptUtil.htmlcode(request,"gdType");
	gdType = gdType.equals("")?"information":gdType;
	String gdFromType =(request.getParameter("gdFromType")==null || "null".equals(request.getParameter("gdFromType")))?"":request.getParameter("gdFromType");
	//2013-09-02-----修改结束
	
	//2013-09-11-----单位主页归档需要的参数-----start
  	String departchannelId =request.getParameter("departchannelId")==null?"":request.getParameter("departchannelId").toString();
  	String departchannelType =request.getParameter("departchannelType")==null?"":request.getParameter("departchannelType").toString();
  	String departuserChannelName =request.getParameter("departuserChannelName")==null?"":request.getParameter("departuserChannelName").toString();
  	String departuserDefine =request.getParameter("departuserDefine")==null?"":request.getParameter("departuserDefine").toString();
  	String departheadColor =request.getParameter("departheadColor")==null?"":request.getParameter("departheadColor").toString();
  	//2013-09-11-----单位主页归档需要的参数-----end
	com.whir.common.util.UploadFile upFile = new com.whir.common.util.UploadFile();
	//20151116 -by jqq 取该信息点赞次数
	String praiseNum = request.getAttribute("praiseNum")!=null?request.getAttribute("praiseNum").toString():"0";
	String haspraise = request.getAttribute("haspraise")!=null?request.getAttribute("haspraise").toString():"0";
	//20151215 -by jqq 取该信息阅读统计总数
	String viewnum = request.getAttribute("viewnum")!=null?request.getAttribute("viewnum").toString():"0";
	//20151217 -by jqq 取该用户对该信息是否有打印权限
	String canprint = request.getAttribute("canPrint")!=null?request.getAttribute("canPrint").toString():"0";
	//20160913 -by jqq https金格控件改造
	String prefixURL = "http://";
  if(null != request.getScheme() && "https".equalsIgnoreCase(request.getScheme())){
		prefixURL = "https://";
  }
%>
<body class="body_gray" <s:if test="information.forbidCopy==1">onselectstart="return false"</s:if> >
	<table border="0" align="center" cellpadding="0" cellspacing="0" class="doc_width">
		<tr valign="top">
			<td class="docbody_margin" ></td>
		</tr>
		<tr valign="top">
			<td height="100%"><div class="docbox doc_contentbg">
				<!--<s:if test="information.informationOrISODoc==1">
				<div style="padding:20px 0 0 20px;"><s:property value="information.documentNo"/></div>
				</s:if>-->
				<div class="news_contentBox">
					<input type="hidden" name="gd" value="<%=gd%>" id="gd"/>
					<s:hidden id="channelId" name="channelId"/>
					<s:hidden id="userChannelName" name="userChannelName"/>
					<s:hidden id="userDefine" name="userDefine"/>
					<s:hidden id="channelType" name="channelType"/>
					<s:if test="information.displayTitle == 1"><div class="news_title" style="word-wrap:break-word; word-break:break-all; display:block; width:100%;"><s:property value="information.informationTitle"/></div></s:if>
					<s:if test="information.informationSubTitle!=null && information.informationSubTitle!=''">
					<div class="news_subtitle"><s:property value="information.informationSubTitle"/></div>
					</s:if>
					<s:if test="#request.fileLink == 'fileLink'">
					<%
					String fileName = request.getAttribute("fileName")==null?"":request.getAttribute("fileName").toString();
					String saveName = request.getAttribute("saveName")==null?"":request.getAttribute("saveName").toString();
					java.io.File file = new java.io.File(preUrl+"/upload/"+path+"/"+saveName);
					String subFolder = "";
					if(!file.exists()){
						subFolder = saveName.substring(0,6)+"/";
					}
					%>
					
						<s:if test="#request.fileName!='' && #request.saveName!=''">
							<s:if test="#request.fileType == 'PDF'">
								<s:if test="information.forbidCopy == 1">
								<div id="pdfDiv" align="center">
									<iframe name="dd" src="<%=rootPath%>/modules/kms/information_manager/newViewPDF.jsp?url=<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" frameborder=0 style="width:900px;height:630px;" border=0></iframe>
								</div>
								</s:if>
								<s:else>
								<div id="pdfDiv" align="center">
									<iframe name="dd" src="<%=rootPath%>/modules/govoffice/gov_documentmanager/viewPDF.jsp?url=<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" frameborder=0 style="width:900px;height:630px;" border=0></iframe>
								</div>
								</s:else>
							</s:if>
							<s:elseif test="#request.fileType == 'JPG' || #request.fileType == 'BMP' || #request.fileType == 'GIF'">
								<div class="news_photoarea"><img src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>"/></div>
							</s:elseif>
							<!--视频播放-----20130929-----start-->
							<s:elseif test="#request.fileType == 'MPG' || #request.fileType == 'MP3' || #request.fileType == 'WMV' || #request.fileType == 'ASF' || #request.fileType == 'AVI' || #request.fileType == 'MPEG'">
						    	<div class="news_photoarea">
							    	<object classid="clsid:22d6f312-b0f6-11d0-94ab-0080c74c7e95" >
										<param name="showstatusbar" value="1">
										<param name="filename" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
							            <embed src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>"></embed>
									</object>
								</div>
						    </s:elseif>
							<s:elseif test="#request.fileType == 'RM' || #request.fileType == 'RMVB'">
								<div class="news_photoarea">
									<object classid="clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa" width="400" height="350" align="center">
										<param name="src" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
										<param name="console" value="clip1"><param name="controls" value="imagewindow">
										<param name="autostart" value="true">
									</object><br>
									<object classid="clsid:cfcdaa03-8be4-11cf-b84b-0020afbbccfa" height="32" width="400" align="center">
										<param name="src" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
										<param name="controls" value="controlpanel"><param name="console" value="clip1">
									</object><br>如果不能播放请<a href="<%=rootPath%>/modules/kms/information_manager/RealONEPlayerV6.0.11.868.exe">下载realone播放器</a>
								</div>
							</s:elseif>
							<s:elseif test="#request.fileType == 'SWF'">
								<div class="news_photoarea">
									<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="400" height="350" codebase="<%=rootPath%>/modules/kms/information_manager/SWFLASH.CAB">
										<param name="movie" value="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>">
	    								<param name="quality" value="high">
	    								<embed src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" type="application/x-shockwave-flash"></embed>
									</object>
								</div>
							</s:elseif>
							<s:elseif test="#request.fileType == 'IPX'">
								<div class="news_photoarea">
									<embed src="<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>" width="364" height="359"></embed>&nbsp;如果不能播放请<a href="<%=rootPath%>/modules/kms/information_manager/axIpx32.exe">下载安装IPIX插件</a>
								</div>
							</s:elseif>
							<s:elseif test="#request.fileType == 'DWF'">
								<div class="news_photoarea">
									<object id='FNDWF70' classid='clsid:B2BE75F3-9197-11CF-ABF4-08000996E931' width='600' height='400' align='center'>
										<param name='Filename' value='<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>'>
										<param name='UserInterface' value='on'>
										<param name='BackColor' value='#FFFFFF'>
										<embed width='600' height='400' filename='<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>' userinterface='on' backcolor='#000000' align='center' name='FNDWF' pluginspage='http://www.autodesk.com/prods/whip' src='<%=preUrl%>/upload/<%=path%>/<%=subFolder+saveName%>'></embed>
									</object><br>如果不能浏览请<a href="<%=rootPath%>/modules/kms/information_manager/ExpressViewerSetup.exe">下载安装插件</a>
								</div>
							</s:elseif>
							<%
							EncryptUtil util = new EncryptUtil();
							String dlcode = util.getSysEncoderKeyVlaue("FileName",saveName,"dir");
							%>
							<!--视频播放-----20130929-----end-->
							<s:if test="information.forbidCopy != 1">
							<div class="news_fileLink">链接附件：<a href="<%=preUrl%>/public/download/download.jsp?FileName=<%=saveName%>&name=<%=fileName%>&path=<%=path%>&verifyCode=<%=dlcode%>"  target="_self"><%=fileName%></a></div>
							</s:if>
						</s:if>
						<s:else>
							<div class="news_fileLink">链接附件：<span class="MustFillColor">链接文件不存在或已经被删除！</span></div>
						</s:else>
					
					</s:if>
					<s:else>
						<s:if test="information.informationType == 0 || information.informationType == 1">
						<%
						String infoPicName = request.getAttribute("infoPicName")!=null?request.getAttribute("infoPicName").toString():"";
						String infoPicSaveName = request.getAttribute("infoPicSaveName")!=null?request.getAttribute("infoPicSaveName").toString():"";
						
						if(!infoPicName.equals("")){
							String[] imgs = infoPicSaveName.split("\\|");
							for(int i=0;i<imgs.length;i++){
								String img = imgs[i];
								String realSrcUrl = preUrl+"/upload/"+path+"/"+img;
								java.io.File file = new java.io.File(realSrcUrl);
								if(!file.exists()){
									realSrcUrl = preUrl+"/upload/"+path+"/"+img.substring(0,6)+"/"+img;
								}
						%>
						<s:if test="information.displayImage == 1">
						<div class="news_photoarea"><img name="image" src="<%=realSrcUrl%>"/></div>
						</s:if>
						<%
							}
						}
						%>
						<div class="news_content">
							<%=content%>
						</div>
						</s:if>
						<s:else>
							<%
							String infoPicName2 = request.getAttribute("infoPicName2")!=null?request.getAttribute("infoPicName2").toString():"";
							String infoPicSaveName2 = request.getAttribute("infoPicSaveName2")!=null?request.getAttribute("infoPicSaveName2").toString():"";
							
							if(!infoPicName2.equals("")){
								String[] imgs2 = infoPicSaveName2.split("\\|");
								for(int i=0;i<imgs2.length;i++){
									String img2 = imgs2[i];
									String realSrcUrl2 = preUrl+"/upload/"+path+"/"+img2;
									java.io.File file2 = new java.io.File(realSrcUrl2);
									if(!file2.exists()){
										realSrcUrl2 = preUrl+"/upload/"+path+"/"+img2.substring(0,6)+"/"+img2;
									}
							%>
							<s:if test="information.displayImage == 1">
							<div class="news_photoarea"><img name="image" src="<%=realSrcUrl2%>"/></div>
							</s:if>
							<%
								}
							}
							%>
						
							<div class="news_content">
								<form name="webform" method="post">
									<table width="100%" id="showImage">
										<tr id="showImage">
											<td height="1" align="center">
												<div id="panel3" name="panel3">
													<%@ include file="/public/iWebOfficeSign/iWebOfficeVersion2.jsp"%>
												</div>
											</td>
											<input type="hidden" name="weboff">
										</tr>
									</table>
								</form>
							</div>
						</s:else>
					</s:else>
					<div class="news_aboutFile">
						<table width="98%" border="0" align="center" cellpadding="1" cellspacing="1">
							<tr>
								<td width="7%" align="left" valign="top">
									<s:text name="info.viewattachment"/>：
								</td>
								<td width="93%" align="left">
								<%
								String infoAppendName = request.getAttribute("infoAppendName")!=null?request.getAttribute("infoAppendName").toString():"";
								String infoAppendSaveName = request.getAttribute("infoAppendSaveName")!=null?request.getAttribute("infoAppendSaveName").toString():"";
								%>
								<s:if test="information.forbidCopy != 1">
									<s:if test="information.informationType == 4">
									<%
									infoAppendName += "|"+content+".doc";
									infoAppendSaveName += "|"+content+".doc";
									%>
									</s:if>
									<s:if test="information.informationType == 5">
									<%
									infoAppendName += "|"+content+".xls";
									infoAppendSaveName += "|"+content+".xls";
									%>
									</s:if>
									<s:if test="information.informationType == 6">
									<%
									infoAppendName += "|"+content+".ppt";
									infoAppendSaveName += "|"+content+".ppt";
									%>
									</s:if>
								</s:if>
								<%
									//2013-09-18-----处理附件问题
									if(infoAppendName.startsWith("|")){
										infoAppendName =infoAppendName.substring(1,infoAppendName.length());
									}
									if(infoAppendSaveName.startsWith("|")){
										infoAppendSaveName =infoAppendSaveName.substring(1,infoAppendSaveName.length());
									}
									//2013-09-18-----处理附件问题
								%>
								<input type="hidden" name="infoAppendName" id="infoAppendName" value="<%=infoAppendName%>"/>
								<input type="hidden" name="infoAppendSaveName" id="infoAppendSaveName" value="<%=infoAppendSaveName%>"/>
								<jsp:include page="/public/upload/uploadify/upload_include.jsp" flush="true">
								   <jsp:param name="dir" value="<%=path%>" />
								   <jsp:param name="uniqueId" value="uploadAppend" />
								   <jsp:param name="realFileNameInputId" value="infoAppendName" />
								   <jsp:param name="saveFileNameInputId" value="infoAppendSaveName" /> 
								   <jsp:param name="canModify" value="no" /> 
								   <jsp:param name="width" value="90" />
								   <jsp:param name="height" value="20" />
								   <jsp:param name="multi" value="true" />  
								   <jsp:param name="buttonClass" value="upload_btn" />
								   <jsp:param name="buttonText" value="上传附件" />
								   <jsp:param name="fileSizeLimit" value="0" /> 
								   <jsp:param name="fileTypeExts" value="" /> 
								   <jsp:param name="uploadLimit" value="0" /> 
								</jsp:include>
								</td>
							</tr>
						</table>
					</div>
					<div class="news_infobox">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="50%"><s:text name="info.searchareapublisher"/>：<s:property value="information.informationIssueOrg"/>.<s:property value="information.informationIssuer"/>
								</td>
								<td width="25%"><s:text name="info.detailversion"/>：<s:property value="information.informationVersion"/>
								</td>
								<td width="25%">
									<div class="open_infomenu"><img src="<%=rootPath%>/<%=whir_skin%>/images/info_ico.gif"  />
										<div class="open_infosubmenu" style="top:-130px;">
											<div><s:text name="info.viewmodifier"/>：<s:property value="information.modifyEmp"/></div>
											<div><s:text name="info.viewmodifytime"/>：<s:if test="information.informationModifyTime > information.informationIssueTime"><s:date name="information.informationModifyTime" format="yyyy-MM-dd HH:mm:ss"/></s:if></div>
											<div onclick="historyDiv();"><font color="#0657AB"><s:text name="info.viewhistoryversion"/></font></div>
										</div>
									</div>
								</td>
							</tr>
							<s:if test="information.informationOrISODoc!=1">
							<tr>
								<td>
									<s:text name="info.viewcolumn"/>：<a href="javascript:void(0);" onclick="openChannel();" style='cursor:hand'><s:property value="#request.channelNameString"/></a>
								</td>
								<td colspan="2"><s:text name="info.viewauthor"/>：<s:property value="%{information.informationAuthor}"/></td>
							</tr>
							</s:if>
							<tr>
								<td> 
									<s:text name="info.viewpubtime"/>：<s:date name="information.informationIssueTime" format="yyyy-MM-dd HH:mm:ss"/>
								</td>
								<td colspan="2">
									<s:text name="info.searchareakey"/>：<s:property value="information.informationKey"/>
								</td>
							</tr>
							<s:if test="information.informationOrISODoc!=1">
							<tr>
								<td> 
									<s:text name="info.viewcontenttype"/>：<s:if test="information.documentType==0"><s:text name="info.authorstatcompose"/></s:if><s:if test="information.documentType==1"><s:text name="info.authorstatedit"/></s:if><s:if test="information.documentType==2"><s:text name="info.authorstatexcerpt"/></s:if>
								</td>
								<td colspan="2">&nbsp;</td>
							</tr>
							</s:if>
							<tr class="no_bottomline">
								<td colspan="3"> 
									<s:text name="info.viewabstract"/>：<s:property value="information.informationSummary"/>
								</td>
							</tr>
						</table>
					</div>
					<DIV class='news_redbox'>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="140" height="36">
								<s:if test="information.informationOrISODoc!=1">
									<s:text name="info.Current"/><span class="font_red"><s:property value="#request.commentNum"/></span><s:text name="info.Reviews"/>
								</s:if>
								</td>
								<td width="140">
								<s:if test="information.informationOrISODoc!=1">
									<div class="open_pl" onclick=javascript:ShowFLT(1) >
										<IMG height=20 src="<%=rootPath%>/<%=whir_skin%>/images/open_pl.gif" title="<s:text name='comm.slide'/>" width=20 align=absMiddle id="treePic1" >
									</div>
								</s:if>
								</td>
								<s:if test="information.informationOrISODoc!=1">
								<td class="news_redinfo">
								</s:if>
								<s:else>
								<td  class="news_redinfo" nowrap="nowrap">
								</s:else>
								<div class="news_redright">
									<%if("0".equals(haspraise)){%>
									<img id="praise_img" src="<%=rootPath%>/themes/common/images/icon_zan0.gif" /><span class="operate_span" onclick="clickPraise();"><label id="praise_<s:property value='information.informationId'/>" style="cursor:pointer;">赞 </label><label id="praisenum_<s:property value='information.informationId'/>" style="cursor:pointer;"><%=praiseNum%></label></span>
									<%}else{%>
									<img id="praise_img" src="<%=rootPath%>/themes/common/images/icon_zan1.gif" /><span class="operate_span" onclick="clickPraise();" style="cursor:pointer;"><label id="praise_<s:property value='information.informationId'/>" style="cursor:pointer;">已赞 </label><label id="praisenum_<s:property value='information.informationId'/>" style="cursor:pointer;"><%=praiseNum%></label></span>
									<%}%>
									<img src="<%=rootPath%>/themes/common/images/icon_d1.gif" /><span class="operate_span" onclick="browser();"><s:text name="info.ReadCircumstance"/><font color="red">(<%=viewnum%>)</font></span>
									<s:if test="information.informationOrISODoc!=1">
										<s:if test='information.informationCanRemark!=0'>
										<img src="<%=rootPath%>/themes/common/images/icon_d4.gif" /><span id="newComment" class="operate_span" onclick="newComment();"><s:text name="info.detailcomment"/></span>
										</s:if>
										<img src="<%=rootPath%>/themes/common/images/icon_d3.gif" /><span id="mailSend" class="operate_span" onclick="mailSend();"><s:text name="info.emailSend"/></span>
									</s:if>
									<s:if test="information.dossierStatus!=1 && #request.canVindicate && #request.dossierGD">
										<div id="gddiv"><img src="<%=rootPath%>/themes/common/images/officeset.gif" /><span id="dossier" class="operate_span" onclick="gd();"><s:text name="info.viewarchive"/></span></div>
									</s:if>
									<s:if test='information.forbidCopy!=1 && #request.canPrint==1'>
									<img src="<%=rootPath%>/themes/common/images/icon_d6.gif" /><span class="operate_span" onclick="addPrintNum();"><s:text name="info.viewprint"/></span>
									</s:if>
									<s:if test="information.informationOrISODoc!=1">
									<div class="news_more"><span class="operate_span" ><s:text name="info.More"/></span>
										<div class="news_redsubmenu" >
											<div><img src="<%=whir_skin%>/images/sc.gif" width="20" height="20" /><span class="operate_span_more" onclick="collection();"><s:text name="info.collection"/></span></div>
											<div><img src="<%=whir_skin%>/images/bj.gif" width="20" height="20" /><span class="operate_span_more" onclick="addNote();"><s:text name="info.viewwritenotes"/></span></div>
											<!--div><img src="<%=whir_skin%>/images/fx.gif" width="20" height="20" /><span class="operate_span_more" onclick=""><s:text name="info.Share"/></span></div-->
										</div>
									</div>
									</s:if>
									<img src="<%=rootPath%>/themes/common/images/close.gif" /><span class="operate_span" onclick="window.close();"><s:text name="comm.Close"/></span>
								</div></td>
							</tr>
						</table>
					</DIV>
					
					<s:form id="commentForm" name="commentForm" action="Information!commentList.action" method="post" >
					<s:hidden id="informationId" name="information.informationId" />
					<div class="news_Booklist" id="LM1" style="display:none;">
					</div>
					</s:form>
					
					<s:form id="setCommentForm" name="setCommentForm" action="Information!setComment.action" method="post" >
					<div id="remark" class="news_Formwrite" style="display:none">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td for="<s:text name='info.Comment'/>" width="9%"><s:text name="info.Comment"/>：</td>
								<td width="87%">
									<s:hidden id="informationId" name="information.informationId" />
									<s:hidden id="channelId" name="channelId" />
									<input type="hidden" id="updateCommentId" name="updateCommentId"/>
									<input type="hidden" id="tempContent" name="tempContent"/>
									<s:textarea rows="3" cssClass="inputTextarea" id="commentContent" name="commentContent" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':500}]"/>
								</td>
								<td align="left">
									<input name="commit" type="button" value="<s:text name='info.saysubmit'/>" class="btnButton4font" onclick="saveComment(1,this);"/>
									<div style="padding-top:12px;">
										<input name="clean" type="button" value="<s:text name='info.sayreset'/>" class="btnButton4font" onclick="cleanComment();"/>
									</div>
								</td>
							</tr>
						</table>
					</div>
					</s:form>
					
					<s:form id="historyForm" name="historyForm" action="Information!historyList.action" method="post" >
						<s:hidden id="informationId" name="information.informationId" />
						<div id="history" class="news_Booklist" style="display:none;">
							<table width="100%" border="1" bordercolor="#e7e7e7" cellspacing="0" cellpadding="0" class="news_modify">
								<thead id="headerContainer">
									<tr class="news_modifyTitle">
										<td whir-options="field:'historyId',width:'4%',renderer:nono"><s:text name="info.nono"/></td>
										<td whir-options="field:'historyVersion',width:'8%',renderer:historyView"><s:text name="info.versionumber"/></td> 
										<td whir-options="field:'historyMark', width:'40%'"><s:text name='info.ModifyRemarks'/></td> 
										<td whir-options="field:'historyIssuerName', width:'15%'"><s:text name="info.viewmodifier"/></td> 
										<td whir-options="field:'historyTime',width:'15%',renderer:'dateFormat'"><s:text name="info.viewpubtime"/></td> 
										<td whir-options="field:'',width:'8%',renderer:historyOperate"><s:text name="comm.opr"/></td> 
									</tr>
								</thead>
								<tbody id="itemContainer" >
								
								</tbody>
							</table>
						</div>
					</s:form>
					
					<s:form id="modifyHistoryForm" name="modifyHistoryForm" action="Information!modifyHistory.action" method="post">
					<div id="modifyHistory" class="news_Formwrite" style="display:none;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td for="<s:text name='info.Remark'/>" width="9%"><s:text name='info.ModifyRemarks'/>：</td>
								<td width="87%">
									<input type="hidden" id="historyId" name="historyId"/>
									<input type="hidden" id="tempHistoryMark" name="tempHistoryMark"/>
									<s:textarea rows="3" cssClass="inputTextarea" id="historyMark" name="historyMark" cssStyle="width:98%;" whir-options="vtype:[{'maxLength':100}]"/>
								</td>
								<td align="left">
									<input name="commit" type="button" value="<s:text name='info.saysubmit'/>" class="btnButton4font" onclick="save(1,this);"/>
									<div style="padding-top:12px;">
										<input name="clean" type="button" value="<s:text name='info.sayreset'/>" class="btnButton4font" onclick="cleanHistory();"/>
									</div>
								</td>
							</tr>
						</table>
					</div>
					</s:form>
					<s:if test="information.informationOrISODoc!=1">
					<input name="moduleType" type="hidden" value="information">
					<div id='relationObjectDIV'></div>
					<IFRAME name='relationIFrame' id='relationIFrame' src='<%=rootPath%>/relation!relationIncludeList.action?moduleType=information&infoId=<s:property value="information.informationId"/>&showAdd=0&tagName=relationObjectDIV&iframeName=relationIFrame&relationview=1&hasprintright=<%=canprint%>' frameborder='0' marginwidth='0' marginheight='0' scrolling='auto' width='100%' height='150' style="display:''"></IFRAME>	
					</s:if>
					<s:else>
					<div class="news_aboutFile">
						<table width="98%" border="0" align="center" cellpadding="1" cellspacing="1">
							<tr>
								<td width="9%" align="left" valign="top">
									<s:text name="info.viewrelatedcontent"/>：
								</td>
								<td width="91%" align="left">
						<%
						List assoicateInfo = (List)request.getAttribute("assoicateInfo");
						if(assoicateInfo!=null && assoicateInfo.size()>0){
							for(int i=0;i<assoicateInfo.size();i++){
								Object[] obj = (Object[])assoicateInfo.get(i);
						%>
									<a href="#" onclick="viewInfo('<%=obj[1].toString()%>','<%=obj[6].toString()%>','<%=obj[7].toString()%>')" style="cursor:pointer"><%=obj[2].toString()%></a>
						<%
							}
						}
						%>
								</td>
							</tr>
						</table>
					</div>
					</s:else>
				</div>
			</div>
		</td>
		<td width="5" height="100%" class="doc_Bgline" ><div class="doc_black"></div></td>
	</tr>
    <tr valign="top">
		<td height="5" colspan="2" valign="top" class="doc_Bgline"><div class="doc_black"></div></td>
	</tr>
</table>

<div class="docbody_margin"></div>
<s:form id="gdform" name="gdform" action="Information!file.action" method="POST" target="dossier">
    <input type="hidden" id="pageContent" name="pageContent">
    <input type="hidden" id="pageStyle_common" name="pageStyle_common">
    <input type="hidden" id="pageStyle_style" name="pageStyle_style">
    <input type="hidden" id="gdType" name="gdType" value="<%=gdType%>">
	<s:hidden id="informationId" name="informationId"/>
	<s:hidden id="informationTitle" name="information.informationTitle"/>
</s:form>

<s:form id="mailForm" name="mailForm" action="innerMail!openAddMail.action" method="post" target="sendMail">
	<s:hidden type="hidden" id="pageURL" name="pageURL"/>
	<s:hidden type="hidden" id="informationIdForMail" name="informationIdForMail"/>
	<s:hidden type="hidden" id="channelIdForMail" name="channelIdForMail"/>
</s:form>

<s:form id="noteForm" name="noteForm" action="NoteBookAction!addNoteBook.action" method="post" target="note" >
	<s:hidden name="formNoteClassName" id="formNoteClassName" value="信息"/>
	<s:hidden name="formNoteTitle" id="formNoteTitle" value=""/>
	<s:hidden name="formNoteLink" id="formNoteLink" value=""/>
</s:form>

<s:form id="collectionForm" name="collectionForm" action="netdisk!infoFolderSelect.action" method="post" target="collection">
	<s:hidden type="hidden" id="httpUrl" name="httpUrl"/>
	<s:hidden type="hidden" id="infoId" name="infoId"/>
	<s:hidden type="hidden" id="channelIdForCollection" name="channelIdForCollection"/>
	<s:hidden type="hidden" id="title" name="title"/>
</s:form>
<iframe id="dossier" name="dossier" src="" width=0 height=0 style="display:none;"></iframe>
<script>
function FormatImagesSize(w){
    var e = new Image();
    $("img[name='image']").each(function(){
        e.src = $(this).attr("src");
        if(e.width>w){
		    $(this).attr("width", w);
        }
    });
}

FormatImagesSize(800);
</script>

<script>
initDataFormToAjax({"dataForm":'setCommentForm',"queryForm":'',"tip":'<s:text name="info.detailcomment"/>',"callbackfunction":commentCallBack});

initDataFormToAjax({"dataForm":'modifyHistoryForm',"queryForm":'',"tip":'<s:text name="info.ModifyRemarks"/>',"callbackfunction":historyCallBack});

$(document).ready(function(){
	initCommentListFormToAjax({formId:"commentForm"});
	initHistoryListFormToAjax({formId:"historyForm"});
	
	/*
	$('.open_infomenu').mousemove(function(){
		$(this).find('.open_infosubmenu').show();
	});
	$('.open_infomenu').mouseleave(function(){
		$(this).find('.open_infosubmenu').slideUp("fast");
	});
	*/

	$('.open_infomenu').click(function(){
		if($(this).find('.open_infosubmenu').is(":hidden")){
			$(this).find('.open_infosubmenu').show();
		} else {
			$(this).find('.open_infosubmenu').slideUp("fast");
		}
	});

	var isfordbidCopy = '<s:property value="information.forbidCopy"/>';
	var hasprintright = '<%=canprint%>';
	var informationId = '<s:property value="information.informationId"/>';
	var channelId = '<s:property value="channelId"/>';
	if(hasprintright != '1'){
		//禁止右键
		document.oncontextmenu = stoprightbutton;
	}else{
		//拥有权限，并且打印次数用完，不允许右键
		$.ajax({
		type: 'POST',
		url: whirRootPath+'/Information!judgePrintNum.action?informationId='+informationId+'&channelId='+channelId,
		async: true,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!=""){
				if(data!="1"){
					//禁止右键
					document.oncontextmenu = stoprightbutton;
				}
			}
		}
	});
	}
	
	//if(isfordbidCopy == '1'){
        document.onkeydown = function(event){
			var e = event || window.event;
            if((e.ctrlKey) && (e.keyCode==80)){
                if(isIe()){
                    alert("禁止打印");
                    //IE中阻止函数器默认动作的方式
                    window.event.cancelBubble = true;
                    window.event.returnValue = false;
                }else{
                    e.preventDefault();
                }
				return false;
            }
        };
	//}
	
	/*
	$('.news_more').mousemove(function(){
		$(this).find('.news_redsubmenu').show();
	});
	$('.news_more').mouseleave(function(){
		$(this).find('.news_redsubmenu').slideUp("fast");
	});
	*/
	$('.news_more').click(function(){
		if($(this).find('.news_redsubmenu').is(":hidden")){
			$(this).find('.news_redsubmenu').show();
		} else {
			$(this).find('.news_redsubmenu').slideUp("fast");
		}
	});

	$("body").unbind('keydown');

	if($('#gd').val()=='1'){gd();}
});
//禁止页面右键（点击返回页面退回，可能导致审核信息不经审核就保存）
function stoprightbutton(){
	return false;
}
function isIe(){
	return ("ActiveXObject" in window);
}
function save(flag,obj){
	var content = $("#historyMark").val();
	if(content!=""){
		if(content.indexOf("'")>-1){
			whir_alert('修改备注不能包含单引号！');
			return;
		}else{
			ok(flag,obj);
		}
	}else{
		whir_alert('<s:text name="info.Notescannotempty" />！');
		return;
	}
}

$(document).ready(function(){
    var isfordbidCopy = '<s:property value="information.forbidCopy"/>';
	//是否有打印权限
	var canprint = '<%=canprint%>';
	var forbidcopy = isfordbidCopy;
	
	if(isfordbidCopy == '1'){
		isfordbidCopy="-1,1,0,0,0,0,0,0";
	}else{
		isfordbidCopy="-1,2,0,0,0,0,1,0";
	}

	<s:if test="information.informationType==4">
		if(isSurface()){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = '<%=content%>';
			webform.WebOffice.WebUrl="<%=prefixURL%>"+"<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
			webform.WebOffice.RecordID=content;
			webform.WebOffice.Template="";
			webform.WebOffice.FileName=content+".doc";
			webform.WebOffice.FileType=".doc";
			webform.WebOffice.EditType=isfordbidCopy;
			webform.WebOffice.UserName="<%=session.getAttribute("userName")%>";
			webform.WebOffice.showMenu = "0";
			webform.WebOffice.EnablePrint =isfordbidCopy;
			if(isfordbidCopy == "-1,2,0,0,0,0,1,0"){
				//20151217 -by jqq 添加权限控制
				if(canprint == '1'){
					webform.WebOffice.AppendTools("106","打印",5);
				}else{
					//3：自定义工具栏=true,	Office工具栏=false
					webform.WebOffice.ShowToolBar = 3;
			   }
			}else{
				webform.WebOffice.ShowToolBar = 3;
			}
			webform.WebOffice.WebOpen();
            //webform.WebOffice.FullSize();全屏显示
			webform.WebOffice.ShowType="1";
			
			webform.WebOffice.WebToolsVisible('Standard',false);  //标准
			webform.WebOffice.WebToolsVisible('Formatting',false);  //格式
			webform.WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			webform.WebOffice.WebToolsVisible('Database',false);  // 数据库
			webform.WebOffice.WebToolsVisible('Drawing',false);  //绘图
			webform.WebOffice.WebToolsVisible('Forms',false);  //窗体
			webform.WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			webform.WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			webform.WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			webform.WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			webform.WebOffice.WebToolsVisible('Web',false);  //Web
			webform.WebOffice.WebToolsVisible('Picture',false);  //图片
			webform.WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			webform.WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			webform.WebOffice.WebToolsVisible('Frames',false);//  框架集
			webform.WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			webform.WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			webform.WebOffice.WebToolsVisible('Outlining',false); // 大纲
			webform.WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			webform.WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			webform.WebOffice.VisibleTools("保存文件",false);
			webform.WebOffice.VisibleTools("文字批注",false);
			webform.WebOffice.VisibleTools("手写批注",false);
			webform.WebOffice.VisibleTools("文档清稿",false);
			webform.WebOffice.VisibleTools("重新批注",false);
			//ShowRevision(false);
			$("#panel3").show();
		}
	</s:if>
	<s:if test="information.informationType==5">
		if(isSurface()){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = '<%=content%>';
			webform.WebOffice.WebUrl="<%=prefixURL%>"+"<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
			webform.WebOffice.RecordID=content;
			webform.WebOffice.Template="";
			webform.WebOffice.FileName=content+".xls";
			webform.WebOffice.FileType=".xls";
			webform.WebOffice.EditType=isfordbidCopy;
			webform.WebOffice.UserName="<%=session.getAttribute("userName")%>";
			webform.WebOffice.showMenu = "0";
			webform.WebOffice.EnablePrint =isfordbidCopy;
			if(forbidcopy != "1"){
				//20151217 -by jqq 添加权限控制
				if(canprint == '1'){
					webform.WebOffice.AppendTools("106","打印",5);
				}else{
					//3：自定义工具栏=true,	Office工具栏=false
					webform.WebOffice.ShowToolBar = 3;
			   }
			}else{
				webform.WebOffice.ShowToolBar = 3;
			}
			webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
            //webform.WebOffice.FullSize();
			webform.WebOffice.ShowType="1";
			webform.WebOffice.WebToolsVisible('Standard',false);  //标准
			webform.WebOffice.WebToolsVisible('Formatting',false);  //格式
			webform.WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			webform.WebOffice.WebToolsVisible('Database',false);  // 数据库
			webform.WebOffice.WebToolsVisible('Drawing',false);  //绘图
			webform.WebOffice.WebToolsVisible('Forms',false);  //窗体
			webform.WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			webform.WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			webform.WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			webform.WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			webform.WebOffice.WebToolsVisible('Web',false);  //Web
			webform.WebOffice.WebToolsVisible('Picture',false);  //图片
			webform.WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			webform.WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			webform.WebOffice.WebToolsVisible('Frames',false);//  框架集
			webform.WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			webform.WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			webform.WebOffice.WebToolsVisible('Outlining',false); // 大纲
			webform.WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			webform.WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			webform.WebOffice.VisibleTools("保存文件",false);
			webform.WebOffice.VisibleTools("文字批注",false);
			webform.WebOffice.VisibleTools("手写批注",false);
			webform.WebOffice.VisibleTools("文档清稿",false);
			webform.WebOffice.VisibleTools("重新批注",false);
			//ShowRevision(false);
			$("#panel3").show();
		}
	</s:if>
	<s:if test="information.informationType==6">
		if(isSurface()){
			whir_alert("该页面不支持在PAD上显示，请于PC端查看!");
		}else{
			var content = '<%=content%>';
			webform.WebOffice.WebUrl="<%=prefixURL%>"+"<%=request.getServerName()+":"+request.getServerPort()%><%=rootPath%>/officeserverservlet";
			webform.WebOffice.RecordID=content;
			webform.WebOffice.Template="";
			webform.WebOffice.FileName=content+".ppt";
			webform.WebOffice.FileType=".ppt";
			webform.WebOffice.EditType=isfordbidCopy;
			webform.WebOffice.UserName="<%=session.getAttribute("userName")%>";
			webform.WebOffice.showMenu = "0";
			webform.WebOffice.EnablePrint =isfordbidCopy;
			if(forbidcopy != "1"){
				if(canprint == '1'){
					webform.WebOffice.AppendTools("106","打印",5);
				}else{
					//3：自定义工具栏=true,	Office工具栏=false
					webform.WebOffice.ShowToolBar = 3;
			   }
			}else{
				webform.WebOffice.ShowToolBar = 3;
			}
			webform.WebOffice.WebOpen();  	//打开该文档    交互OfficeServer的OPTION="LOADTEMPLATE"
            //webform.WebOffice.FullSize();
			webform.WebOffice.WebToolsVisible('Standard',false);  //标准
			webform.WebOffice.WebToolsVisible('Formatting',false);  //格式
			webform.WebOffice.WebToolsVisible('Tables and Borders',false);  //表格和边框
			webform.WebOffice.WebToolsVisible('Database',false);  // 数据库
			webform.WebOffice.WebToolsVisible('Drawing',false);  //绘图
			webform.WebOffice.WebToolsVisible('Forms',false);  //窗体
			webform.WebOffice.WebToolsVisible('Visual Basic',false);  //Visual Basic
			webform.WebOffice.WebToolsVisible('Mail Merge',false);  //邮件合并
			webform.WebOffice.WebToolsVisible('Extended Formatting',false);  //其它格式
			webform.WebOffice.WebToolsVisible('AutoText',false);  //自动图文集
			webform.WebOffice.WebToolsVisible('Web',false);  //Web
			webform.WebOffice.WebToolsVisible('Picture',false);  //图片
			webform.WebOffice.WebToolsVisible('Control Toolbox',false); //控件工具箱
			webform.WebOffice.WebToolsVisible('Web Tools',false);  //Web工具箱
			webform.WebOffice.WebToolsVisible('Frames',false);//  框架集
			webform.WebOffice.WebToolsVisible('WordArt',false);  //艺术字
			webform.WebOffice.WebToolsVisible('符号栏',false);  //符号栏
			webform.WebOffice.WebToolsVisible('Outlining',false); // 大纲
			webform.WebOffice.WebToolsVisible('E-mail',false); //电子邮件
			webform.WebOffice.WebToolsVisible('Word Count',false); //字数统计
			//隐藏按钮
			webform.WebOffice.VisibleTools("新建文件",false); //隐藏“新建文件”功能按钮
			webform.WebOffice.VisibleTools("打开文件",false); //隐藏“打开文件”功能按钮
			webform.WebOffice.VisibleTools("保存文件",false);
			webform.WebOffice.VisibleTools("文字批注",false);
			webform.WebOffice.VisibleTools("手写批注",false);
			webform.WebOffice.VisibleTools("文档清稿",false);
			webform.WebOffice.VisibleTools("重新批注",false);
			$("#panel3").show();
		}
	</s:if>
});

function ShowFLT(i) {
	if ($("#LM"+i).css("display")=="none") {
		$("#treePic"+i).attr("src","<%=whir_skin%>/images/colse_pl.gif");
		$("#treePic"+i).attr("title","<s:text name='comm.slideup'/>");
		$("#LM"+i).show();
	}else {
		$("#treePic"+i).attr("src","<%=whir_skin%>/images/open_pl.gif");
		$("#treePic"+i).attr("title","<s:text name='comm.slide'/>");
		$("#LM"+i).hide();
	}
}

//归档
function gd(){
	$("#gd").val("-1");
	$("#pageStyle_common").val("<%=rootPath%>/themes/common/common.css");
	$("#pageStyle_style").val("<%=rootPath%>/<%=whir_skin%>/style.css");
	$("#pageContent").val(document.body.innerHTML);
	//openWin({url:'',winName:'dossier',width:10,height:10});
    $("#gdform").submit();
    try{
		$("#gddiv").hide();
    }catch(e){}
    
    whir_alert('<s:text name="info.archive" />！',function(){
    	<%if("checkdepart".equals(gdFromType)){%>
    		var url="/defaultroot/InfoList!allList.action?checkdepart=1&channelId=<%=departchannelId%>&channelType=<%=departchannelType%>&userChannelName=<%=departuserChannelName%>&userDefine=<%=departuserDefine%>&headColor=<%=departheadColor%>";
    		window.parent.location_href(url);
    	<%}else{%>
    		window.parent.refreshListForm('queryForm');
    	<%}%>
    });
}

//异步初始化评论列表
function initCommentListFormToAjax(formJson){
	var userId = '<%=userId%>';
	var canVindicate = '<%=canVindicate%>';
	var delComment = '<%=delComment%>';
	var formJson_ = eval(formJson);
	var formId = formJson_.formId;
	//分页参数等html、公共js事件绑定
	initList(formId);
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		beforeSend:function(){
			//$.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
		},
		success:function(responseText){
			$.dialog({id:"Tips"}).close();
			jq_form.find("#LM1").html("");
			//解析服务器返回的json字符串
			var json = eval("("+responseText+")").data;
			var data = json.data;
			//循环数据信息
			var comment = '';
			//20151106 -by jqq 获取informationid用以删除评论同时，将信息表中评论数量减一
			var informationId = '<s:property value="information.informationId"/>';			
			for (var i=0; i<data.length; i++) {
				var po = data[i];	
				comment += '<div class="news_Booktitle">';
				if(po.commentIssuerId==userId || delComment=='1' || canVindicate=='true'){
					comment += '<div class="newsBtnbox"><span style="cursor:pointer;" onclick="modifyComment('+po.commentId+');"><img style="cursor:hand" border="0" src="<%=rootPath%>/images/modi.gif" title="<s:text name="info.columnmodify"/>"></span><span style="cursor:pointer;" onclick="deleteComment('+po.commentId+','+informationId+')"><img style="cursor:hand" border="0" src="<%=rootPath%>/images/del.gif" title="<s:text name="info.columndelete"/>"></span>&nbsp;</div>'
				}
				comment += po.commentIssuerOrg+'.'+po.commentIssuerName+'<span class="date">'+po.commentIssueTime+'</span></div><div class="news_Bookcontent">'+trancComment(po.commentContent)+'</div><input type="hidden" id="comment'+po.commentId+'" name="comment'+po.commentId+'" value="'+po.commentContent+'">';
			}
			jq_form.find("#LM1").append(comment);
			//调用回调事件
			if(formJson_.onLoadSuccessAfter){
			    formJson_.onLoadSuccessAfter.call(this);
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	$("#"+formId).submit();
}

function trancComment(val){
	if(val.indexOf("<")>-1){
		val = val.replace(/\</g,'&lt;');
	}
	if(val.indexOf(">")>-1){
		val = val.replace(/\>/g,'&gt;');
	}
	if(val.indexOf("\"")>-1){
		val = val.replace(/\"/g,'&quot;');
	}
	return val;
}

//保存评论
function saveComment(flag,obj){
	if($("#commentContent").val()==''){
		whir_alert('<s:text name="info.PleaseenterComment" />！');
		return;
	}else{
        $("#commentContent").val(trancComment($("#commentContent").val()));
		ok(flag,obj);
	}
}

//修改评论
function modifyComment(commentId){
	var content = $("#comment"+commentId).val();
	if(content.indexOf("<br/>")>-1){
		content = content.replace(/\<br\/\>/g,'\r');
	}
	if($("#remark").is(":hidden")){
		$("#remark").show();
		$("#updateCommentId").val(commentId);
		$("#commentContent").val(content);
		$("#tempContent").val($("#commentContent").val());
	}else{
		$("#updateCommentId").val(commentId);
		$("#commentContent").val(content);
		$("#tempContent").val($("#commentContent").val());
	}
}

//删除评论
function deleteComment(commentId,informationId){
	whir_confirm('<s:text name="info.deleteThisComment" />',function(){
		ajaxOperate({urlWithData:'Information!deleteComment2.action?commentId='+commentId+'&informationId='+informationId,tip:'<s:text name="info.DelComment" />',isconfirm:false,formId:'commentForm',callbackfunction:commentCallBack});
	});
}

//清除评论textarea
function cleanComment(){
	$("#commentContent").val($("#tempContent").val());
}

//新增评论
function newComment(){
	if($("#remark").is(":hidden")){
		$("#remark").show();
		$("#updateCommentId").val('');
		$("#commentContent").val('');
		$("#tempContent").val('');
	}else{
		$("#remark").hide();
		$("#updateCommentId").val('');
		$("#commentContent").val('');
		$("#tempContent").val('');
	}
}

//评论成功回调函数
function commentCallBack(){
	initCommentListFormToAjax({formId:"commentForm"}); 
	$("#remark").hide();
	var informationId = '<s:property value="information.informationId"/>';
	$.ajax({
		type: 'POST',
		url: whirRootPath+"/Information!getCommentNum.action?informationId="+informationId,
		async: true,
		dataType: 'json',
		success: function(data){
			if(data!=null && data!=""){
				data = eval(data);
				if(data.num != null){
					$(".font_red").html(data.num);
				}
			}
		}
	});
}

//异步初始化历史版本列表
function initHistoryListFormToAjax(formJson){
	var formJson_ = eval(formJson);
	var formId = formJson_.formId;
	//分页参数等html、公共js事件绑定
	initList(formId);
 	var jq_form = $('#'+formId);
	jq_form.ajaxForm({
		beforeSend:function(){
			//$.dialog.tips(comm.loadingdata,1000,'loading.gif',function(){});
		},
		success:function(responseText){
			$.dialog({id:"Tips"}).close();
			jq_form.find("#itemContainer").html("");
			var td_length = jq_form.find("#headerContainer").find("td").length ;
			//解析服务器返回的json字符串
			var json = eval("("+responseText+")").data;
			var data = json.data;
			//循环数据信息		
			for (var i=0; i<data.length; i++) {
				var po = data[i];				
				var tr = '<tr>';
				var td_i = 0 ;
				jq_form.find("#headerContainer").find("td").each(function(){
					td_i = td_i + 1;
					var td_class = 'class="listTableLine1"';
					if(td_i == td_length){
						td_class = 'class="listTableLineLastTD"';
					}
					var whir_options = eval("({"+$(this).attr("whir-options")+"})");
					var checkbox = whir_options.checkbox;
					var radio = whir_options.radio;
					var renderer = whir_options.renderer;
					var field = whir_options.field;		
					var width = whir_options.width;	
				    if(renderer){
						if(renderer=="dateFormat"){
							if(field=="" || eval("po."+field)==null || eval("po."+field)==""){
								tr += '<td  '+td_class+' width="'+width+'" align="center">&nbsp;</td>';
							}else{
								tr += '<td  '+td_class+' width="'+width+'" align="center">'+eval("po."+field).substring(0,10)+'</td>';
							}
						}else{
							tr += '<td  '+td_class+' width="'+width+'" align="center">'+renderer.call(renderer,po,i)+'</td>';
						}
					}else{
						if(field=="" || eval("po."+field)==null || eval("po."+field)==""){
							tr += '<td  '+td_class+' width="'+width+'" align="center">&nbsp;</td>';
						}else{
							if(field=="historyMark"){
								tr += '<td  '+td_class+' width="'+width+'" align="left">'+(eval("po."+field))+'</td>';
							}else{
								tr += '<td  '+td_class+' width="'+width+'" align="center">'+(eval("po."+field))+'</td>';
							}
						}
					}
				});
				tr += "</tr>";
				jq_form.find("#itemContainer").append(tr);
			}
			//调用回调事件
			if(formJson_.onLoadSuccessAfter){
			    formJson_.onLoadSuccessAfter.call(this);
			}
		},
		error:function(XMLHttpRequest, textStatus, errorThrown){
			$.dialog({id:"Tips"}).close();
			$.dialog.alert(comm.loadfailure,function(){});
		}
	}); 
	//初次提交表单获得数据
	$("#"+formId).submit();
}

//历史版本查看
function historyView(po,i){
	var html = "";
	var informationId = '<s:property value="information.informationId"/>';
	var informationType = '<s:property value="information.informationType"/>';
	var channelId = $("#channelId").val();
	var userChannelName = $("#userChannelName").val();
	var num = Math.random()*100;
	html = '<a href="javascript:void(0);" onClick="openWin({url:\'Information!historyView.action?historyId='+po.historyId+'&informationId='+informationId+'&informationType='+informationType+'&channelId='+channelId+'&userChannelName='+userChannelName+'\',winName:\'historyInfo'+parseInt(num)+'\',isFull:true})">'+po.historyVersion+'</a>';
	return html;
}

//历史版本操作按钮
function historyOperate(po,i){
	var html = '';
	var userId = "<%=userId%>";
	var canVindicate = '<%=canVindicate%>';
	if(po.historyIssuerId == userId || canVindicate=='true'){
		var historyMark = po.historyMark!=null && po.historyMark ? po.historyMark : "";
		historyMark = trancComment(historyMark);
		html += '<a href="javascript:void(0)" onclick="modifyHistory('+po.historyId+',\''+historyMark+'\');"><img border="0" style="" src="<%=rootPath%>/images/modi.gif" align="absmiddle" title="<s:text name="info.columnmodify"/>"></a><a href="javascript:void(0)" onclick="deleteHistory('+po.historyId+');"><img border="0" src="<%=rootPath%>/images/del.gif" align="absmiddle" title="<s:text name="info.alldelete"/>"></a>';
	}
	return html;
}

//历史版本修改备注
function modifyHistory(historyId,historyMark){
	historyMark = historyMark.replace(/\<br\/\>/g,'\n');
	if($("#modifyHistory").is(":hidden")){
		$("#modifyHistory").show();
		$("#historyId").val(historyId);
		$("#historyMark").val(historyMark);
		$("#tempHistoryMark").val(historyMark);
	}else{
		$("#modifyHistory").hide();
	}
}

//删除历史版本
function deleteHistory(historyId){
	whir_confirm("是否确认删除该历史版本？",function(){
		ajaxOperate({urlWithData:'Information!deleteHistory.action?historyId='+historyId,tip:'删除历史版本',isconfirm:false,formId:'historyForm'});
	});
}

//历史版本修改备注成功回调函数
function historyCallBack(){
	initHistoryListFormToAjax({formId:"historyForm"}); 
	$("#modifyHistory").hide();
}

//历史版本修改备注清除
function cleanHistory(){
	$("#historyMark").val($("#tempHistoryMark").val());
}

//打印前记录打印数量
function addPrintNum(){
	var informationId = '<s:property value="information.informationId"/>';
	var channelId = '<s:property value="channelId"/>';
	//ajaxOperate({urlWithData:'Information!print.action?informationId='+informationId+'&channelId='+channelId,tip:'',isconfirm:false,formId:''});
	$.ajax({
		type: 'POST',
		url: whirRootPath+'/Information!print.action?informationId='+informationId+'&channelId='+channelId,
		async: true,
		dataType: 'text',
		success: function(data){
			if(data!=null && data!=""){
				if(data=="1"){
					window.print();
				}else{
					//禁止右键
					document.oncontextmenu = stoprightbutton;
					whir_alert("打印次数已达上限！");
				}
			}
		}
	});
}

//邮件转发
function mailSend(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	var informationTitle = "<s:property value='information.informationTitle'/>";
	var channelType = $("#channelType").val();
	var userDefine = $("#userDefine").val();
	$("#pageURL").val("<a onclick='openWin({url:\"Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+userChannelName+"&channelId="+channelId+"&channelType="+channelType+"&userDefine="+userDefine+"\",isFull:true,winName:\"info\"});' href='javascript:void(0);'>"+informationTitle+"</a>");
	$("#informationIdForMail").val(informationId);
	$("#channelIdForMail").val(channelId);
	openWin({url:'innerMail!openAddMail.action',winName:'sendMail',isFull:true});
	//window.open("","sendMail","");
	$("#mailForm").submit();
}

//记笔记
function addNote(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	var informationTitle = "<s:property value='information.informationTitle'/>";
	var vUrl = whirRootPath + '/NoteBookAction!addNoteBook.action?noteType=information'
	vUrl += '&informationId=' + informationId;
	vUrl += "&informationType=" + informationType;
	vUrl += "&channelId=" + channelId;
	vUrl += "&informationTitle=" + informationTitle;
	vUrl += "&userChannelName=" + userChannelName;
	openWin({url:vUrl, width:620, height:350, winName:'addNoteBook'});
}

//收藏
function collection(){
	var informationId = "<s:property value='information.informationId'/>";
	var channelId = '<s:property value="channelId"/>';
	var userChannelName = '<s:property value="#request.channelNameString"/>';
	var informationType = "<s:property value='information.informationType'/>";
	var informationTitle = "<s:property value='information.informationTitle'/>";
	$("#httpUrl").val("Information!view.action?informationId="+informationId+"&informationType="+informationType+"&userChannelName="+userChannelName+"&channelId="+channelId);
	$("#title").val(informationTitle);
	$("#infoId").val(informationId);
	$("#channelIdForCollection").val(channelId);
	openWin({url:'netdisk!infoFolderSelect.action',winName:'collection',width:650,height:350});
	$("#collectionForm").submit();
	//var url = whirRootPath + 'netdisk!infoFolderSelect.action?title=' + informationTitle + '&infoId=' + informationId + '&channelIdForCollection=' + channelId;
	//url += '&httpUrl=Information!view.action%3FinformationId%3D'+informationId+'%26informationType%3D'+informationType+'%26userChannelName%3D'+userChannelName+'%26channelId%3D'+channelId;
	//openWin({url:url,winName:'collection',width:650,height:350});
}

//阅读情况
function browser(){
	openWin({url:'realtimemessage!onlinelist.action?fromtype=information&id='+'<s:property value="information.informationId"/>',winName:'browser',isFull:true});
}

function nono(po,i){
	var html = i+1;
	return html;
}

function historyDiv(){
	if($("#history").is(":visible")==false){
		$("#history").show();   
	}else{ 
		$("#history").hide(); 
	}
}

function openChannel(){
	openWin({url:"InfoList!allList.action?channelId="+$('#channelId').val()+"&channelType="+$('#channelType').val()+"&userChannelName="+$('#userChannelName').val()+"&userDefine="+$('#userDefine').val(),isFull:true,winName:"channelList"});
}

function viewInfo(infoId,intoType,channelId){
	openWin({url:'Information!view.action?informationId='+infoId+'&informationType='+intoType+'&userChannelName='+$("#userChannelName").val()+'&channelId='+channelId+'&userDefine='+$('#userDefine').val()+'&channelType='+$('#channelType').val()+'&iso=1',isFull:true,winName:"info"+infoId});
}

//作用：打印文档
function WebOpenPrint(){
  try{
    webform.WebOffice.WebOpenPrint();
    StatusMsg(webform.WebOffice.Status);
  }catch(e){}
}

//20151116 -by jqq  信息页面点赞处理
function clickPraise(){
	var informationId = "<s:property value='information.informationId'/>";
	ajaxOperate({urlWithData:'<%=rootPath%>/Information!praiseInfo.action?praiseType=1&praiseInformationId='+informationId,tip:'点赞',isconfirm:false,callbackfunction:function(){
			var praisenums =$("#praisenum_"+informationId).text();
			$("#praisenum_"+informationId).text(parseInt(praisenums)+1);
			$("#praise_img").attr("src","<%=rootPath%>/themes/common/images/icon_zan1.gif");
			$("#praise_"+informationId).text("已赞 ");
		}});
}

</script>
<script language="javascript" for=WebOffice event="OnMenuClick(vIndex,vCaption)">
   if (vIndex==1){  //打开本地文件
      WebOpenLocal();
   }
   if (vIndex==2){  //保存本地文件
      WebSaveLocal();
   }
   if (vIndex==4){  //保存并退出
     SaveDocument();    //保存正文
     webform.submit();  //提交表单
   }
   if (vIndex==6){  //打印文档
      WebOpenPrint();
   }
</script>
<script language="javascript" for=WebOffice event="OnToolsClick(vIndex,vCaption)">
   webform.WebOffice.showMenu = "0";       
   WebToolsVisible('Standard',false);  //标准
   WebToolsVisible('Formatting',false);  //格式
   WebToolsVisible('Tables and Borders',false);  //表格和边框
   WebToolsVisible('Database',false);  // 数据库
   WebToolsVisible('Drawing',false);  //绘图
   WebToolsVisible('Forms',false);  //窗体
   WebToolsVisible('Visual Basic',false);  //Visual Basic
   WebToolsVisible('Mail Merge',false);  //邮件合并
   WebToolsVisible('Extended Formatting',false);  //其它格式
   WebToolsVisible('AutoText',false);  //自动图文集
   WebToolsVisible('Web',false);  //Web
   WebToolsVisible('Picture',false);  //图片
   WebToolsVisible('Control Toolbox',false); //控件工具箱
   WebToolsVisible('Web Tools',false);  //Web工具箱
   WebToolsVisible('Frames',false);//  框架集
   WebToolsVisible('WordArt',false);  //艺术字
   WebToolsVisible('符号栏',false);  //符号栏
   WebToolsVisible('Outlining',false); // 大纲
   WebToolsVisible('E-mail',false); //电子邮件
   WebToolsVisible('Word Count',false); //字数统计
   
   if (vIndex==106){WebOpenPrint();}
   if (vIndex==-1&&vCaption=='全屏'){
	   document.all.panel3.style.display="";
   }
   if (vIndex==-1 && vCaption=='返回'){
  	   webform.WebOffice.WebObject.Saved = true;
       document.all.panel3.style.display="none";
   }
</script>
</body>
</html>