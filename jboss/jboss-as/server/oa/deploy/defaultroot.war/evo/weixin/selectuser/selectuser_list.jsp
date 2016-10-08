<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp" %>
<body>
<header class="wh-header" id="header_content">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div id="headerBtn" class="wh-header-btn">
                <a href="#" class="active"><span>全部</span></a>
                <a href="#"><span>组织</span></a>
            </div>
        </div>
    </div>
</header>
<section id="sectionScroll" class="wh-section wh-section-topfixed wh-section-bottomfixed">
    <header class="wh-search" id="search_header">
        <div class="wh-container">
            <form method="post" id="searchForm">
                <input type="search" placeholder="搜索用户姓名" name="title" value="${title}" id="queryCondition"/>
                <input type="text" style="display: none;"/>
                <i class="fa fa-search"></i>
            </form>
        </div>
    </header>
    <aside class="wh-category wh-category-contact" style="display:none">
        <div class="wh-container">
            <div class="wh-cate-lists" name="cateListChek">
            	<ul id="org_list" name="org_list" data-loadorgflag='0'>
            	<c:if test="${not empty docXml1}">
					<x:parse xml="${docXml1}" var="orgDoc"/>
					<c:set var="recordCount3"><x:out select="$orgDoc//recordcount/text()" /></c:set>
					<c:if test="${recordCount3==0}">
						<li>系统没有查询到任何记录！</li> 
					</c:if>
					<x:forEach select="$orgDoc//list" var="n1" varStatus="status">
						<c:set var="orgHasJunior"><x:out select="$n1//orgHasJunior/text()" /></c:set>
						<c:set var="orgId"><x:out select="$n1//orgId/text()" /></c:set>
						<c:set var="orgName"><x:out select="$n1//orgName/text()" /></c:set>
						<c:set var="orgUserNum"><x:out select="$n1//orgUserNum/text()" /></c:set>
						<li>
							<c:choose>
								<c:when test="${orgHasJunior==1 || orgUserNum ne '0'}">
		                        	<div class="wh-cate-libox" onclick="loadNextOrgAndSubEmp('${orgId}',this);">
								</c:when>
								<c:otherwise>
									<div class="wh-cate-libox wh-cate-libox-empty">
								</c:otherwise>
							</c:choose>
								<%--<i class="fa fa-check-circle"></i>--%>
	                            <a>
	                                <i class="icon">${fn:substring(orgName, 0, 1)}</i>
	                                <p>
	                                    <strong>${orgName}</strong>
	                                    <span>人数<x:out select="$n1/orgUserNum/text()" /><c:if test="${orgHasJunior==1}">&nbsp;&nbsp;下级组织<x:out select="$n1/childOrgNum/text()" /></c:if></span>
	                                </p>
	                            </a>
	                        </div>
	                    </li>
                    </x:forEach>
				</c:if>
            	</ul>
            </div>
        </div>
    </aside>
    <article class="wh-article wh-article-contact">
        <div class="wh-container">
            <div class="wh-article-lists">
            	<ul id="all_user_list" name="all_user_list" data-loaduserflag='0'>
              	 	<c:if test="${not empty docXml}">
	                	<x:parse xml="${docXml}" var="empDoc" />
	                	<c:set var="recordCount"><x:out select="$empDoc//recordCount/text()" /></c:set>
						<c:if test="${recordCount==0}">
							<li>
		                        <p><strong>系统没有查询到任何记录！</strong></p>
		                    </li>
						</c:if>
	                	<x:forEach select="$empDoc//list" var="n" varStatus="status">
							<c:set var="empId"><x:out select="$n/userId/text()"/></c:set>
							<c:set var="empLivingPhoto"><x:out select="$n/empLivingPhoto/text()"/></c:set>
							<c:set var="empName"><x:out select="$n/userName/text()"/></c:set>
							<c:set var="orgName"><x:out select="$n/orgNameString/text()"/></c:set>
		                    <li class="after-hidden">
								<div class="wh-cate-libox wh-cate-libox-empty">
									<i class="fa fa-check-circle" data-empid="${empId}," data-empname="${empName},"></i>
									<a>
					                    <strong class="contact-icon">
						                    <c:choose>
												<c:when test="${not empty empLivingPhoto}"><img src="/defaultroot/upload/peopleinfo/${empLivingPhoto}"/></c:when>
												<c:otherwise><img src="/defaultroot/evo/weixin/images/head.png"/></c:otherwise>
											</c:choose>
										</strong>
			                            <p>
			                                <strong>${empName}</strong>
				                            <span>${orgName}</span>
			                            </p>
			                        </a>
		                        </div>
		                    </li>
		                </x:forEach>
                	</c:if>
            	</ul>
            </div>
        </div>
    </article>
    <aside class="wh-load-box" style="display: none">
        <div class="wh-load-tap">上滑加载更多</div>
        <div class="wh-load-md" style="display: none">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </aside>
</section>
<footer class="wh-footer wh-footer-text">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:clearSelect();" class="fbtn-cancel col-xs-6"><i class="fa fa-bitbucket"></i>清空</a>
                <a href="javascript:confirmSelect();" class="fbtn-matter col-xs-6"><i class="fa fa-check-square"></i>确认</a>
            </div>
        </div>
    </div>
</footer>
<input type="hidden" value="${offset}" id="offset" name="offset"/>
<input type="hidden" value="${offset1}" id="orgOffset"/>
<input type="hidden" value="${nomore}" id="nomore"/>
<input type="hidden" value="${param.range}" id="range"/>
<input type="hidden" value="${nomore1}" id="orgNomore"/>
<input type="hidden" value="${param.selectType}" id="selectType"/>
<input type="hidden" value="${param.selectName}" id="selectName"/>
<input type="hidden" value="${param.selectId}" id="selectId"/>
<input type="hidden" value="${param.selectNameVal}" id="selectNameVal"/>
<input type="hidden" value="${param.selectIdVal}" id="selectIdVal"/>
</body>
<script type="text/javascript" src="/defaultroot/evo/weixin/js/common.js"></script>
<script type="text/javascript" src="/defaultroot/evo/weixin/selectuser/js/select_user_org.js"></script>
<script>
  $(function(){
		$(document).scrollTop(0);
  });

  	//input输入时，顶部fixed错位
	$('#queryCondition').bind('focus',function(){
	    $('#header_content').css('position','static');
	    $("#sectionScroll").css('padding-top',0);
	}).bind('blur',function(){
	    //$('#header_content').css('position','fixed');
	    //$("#sectionScroll").removeAttr("style");
	});
</script>