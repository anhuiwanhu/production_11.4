<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ include file="../common/taglibs.jsp"%>
<%
String docXml = request.getParameter("docXml");
String orgId = session.getAttribute("orgId")==null?"":session.getAttribute("orgId").toString();
%>
<c:if test="${not empty param.docXml}">
<x:parse xml="${param.docXml}" var="doc2"/>
<header class="wh-header" id="subHeader" style="display:none" data-hide="0">
    <div class="wh-wrapper">
        <div class="wh-hd-op-left"></div>
        <div class="wh-container">
            <nav class="wh-info-nav">
                <ul class="wh-i-n-default swiper-wrapper" id="swiper_ul">
                	<c:if test="${not empty docXml}">
                		<c:set var="liNum"></c:set>
			        	<x:forEach select="$doc2//subTableList/subFieldList" varStatus="xhli">
			        		<c:set var="liNum">${xhli.index+1}</c:set>
	                    	<li <c:if test="${liNum eq 1}">class="col-xs-2 swiper-slide nav-active"</c:if>
	                    	<c:if test="${liNum ne 1}">class="col-xs-2 swiper-slide"</c:if> data-checkbox="check">
	                    		<a href="#stp${liNum}">${liNum}</a><em><i class="fa fa-check-circle"></i></em>
                    		</li>
	                	</x:forEach>
               		</c:if>
                </ul>
            </nav>
        </div>
        <div class="wh-hd-op-right"></div>
    </div>
</header>
<section class="wh-section wh-section-topfixed wh-section-bottomfixed"  id="subSection" style="display:none">
    <article class="wh-edit wh-edit-forum">
        <div class="wh-container">
        	<c:set var="subFieldsNum"></c:set>
		    <x:forEach select="$doc2//subTableList/subFieldList" var="ct" varStatus="xh">
			    <c:set var="subFieldsNum">${xh.index+1}</c:set>
	            <span class="wh-place-holder" id="stp${subFieldsNum}"></span>
	             <div <c:if test="${subFieldsNum eq 1}">class="wh-edit-lists wh-edit-list-d wh-edit-list-d-fst"</c:if>
	             <c:if test="${subFieldsNum ne 1}">class="wh-edit-lists wh-edit-list-d"</c:if> id="subTableTemplate">
	                <div class="wh-l-ckbox">
	                    <i class="fa fa-check-circle"></i>
	                </div>
	                <div class="wh-r-tbbox">                
	                    <table class="wh-table-edit">
	                        <c:set var="goodsId"><x:out select="$ct/goodsId/text()"/></c:set>
							<c:set var="goodsName"><x:out select="$ct/goodsName/text()"/></c:set>
							<c:set var="goodsSpecs"><x:out select="$ct/goodsSpecs/text()"/></c:set>
							<c:set var="goodsUnit"><x:out select="$ct/goodsUnit/text()"/></c:set>
							<c:set var="amount"><x:out select="$ct/amount/text()"/></c:set>
							<c:set var="price"><x:out select="$ct/price/text()"/></c:set>
							<c:set var="money"><x:out select="$ct/money/text()"/></c:set>
	                        <tr>
	                            <th>存货编号</th>
	                            <td>${goodsId }</td>
	                        </tr>
	                        <tr>
	                            <th>存货名称</th>
	                            <td>${goodsName }</td>
	                        </tr>
	                        <tr>
	                            <th>规格型号</th>
	                            <td>${goodsSpecs }</td>
	                        </tr>
	                        <tr>
	                            <th>计量单位</th>
	                            <td>${goodsUnit }</td>
	                        </tr>
	                        <tr>
	                            <th>数量</th>
	                            <td>${amount }
	                            <input type="hidden"  name="amount" value="${amount }"/>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th>单价</th>
	                            <td>${price }</td>
	                        </tr>
	                        <tr>
	                            <th>金额</th>
	                            <td>
	                            	${money }
	                            	<input type="hidden" name="money" value="${money }"/>
	                            </td>
	                        </tr>
	                        <tr id="userMan" style="display:none">
	                            <th>使用人</th>
	                            <td><x:out select="$ct/userMan/text()"/></td>
	                        </tr>
	                    </table>
	                </div>
	            </div>
            </x:forEach>
        </div>
    </article>
</section>
<footer class="wh-ofooter" id="subFooter1" style="display:none">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="s-table-count">
                <strong id="totname"></strong><span id="tot"></span>
            </div>
        </div>
    </div>
</footer>
<footer class="wh-footer wh-footer-forum" id="subFooter" style="display:none">
    <div class="wh-wrapper">
        <div class="wh-container">
            <div class="wh-footer-btn">
                <a href="javascript:finishSubTableForm();" class="fbtn-matter col-xs-12">
                	<i class="fa fa-check-square"></i>完成
                </a>
            </div>
        </div>
    </div>
</footer>
</c:if>
<script type="text/javascript">
    //添加子表数据
    function addSubTable(flag){
        if(flag==1){
        	$('[id="userMan"]').show();
         }
    	$('#mainContent').hide();
		$('#footerButton').hide();
		$('#subHeader').show();
		$('#subSection').show();
		$('#subFooter').show();
		$('#subFooter1').show();
		showSubOperate();
		initTot();
    	bindLiClick();
    }
 	 //初始化子表表单
    function bindLiClick(){
    	//水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 5,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
    	var $swiperLis = $('[id="swiper_ul"] li');
    	$swiperLis.unbind('click');
    	$swiperLis.click(function(){
    		var $swiperLi = $(this);
    		$swiperLis.not(this).removeClass('nav-active').data("checkbox","uncheck");
            $swiperLi.addClass('nav-active').data("checkbox","check");
    	});
    }
    
    function showSubOperate(){
    	//水平滑动
        var infoNavswiper = new Swiper('.wh-info-nav', {
            slidesPerView: 5,
            paginationClickable: true,
            spaceBetween: 0,
            freeMode: true
        });
        var infoNavli = $('.wh-info-nav .wh-i-n-default li');
        infoNavli.first().addClass("nav-active");
    }
    
    function initTot() {
    	//子表合计字段相关
		$("#totname").html("合计项：");
		var amountSum = 0;
		var arrAmo = $("input[name=amount]");
		for(var i=0;i<arrAmo.length;i++){
			var num = arrAmo[i].value-0;
			amountSum += num;
		}
		var	moneySum = 0;
		var arrMon = $("input[name=money]");
		for(var i=0;i<arrMon.length;i++){
			var num1 = arrMon[i].value-0;
			moneySum += num1;
		}
		$('#tot').html('数量:'+amountSum+' 金额:'+moneySum);
	}

  	//添加完成子表表单
    function finishSubTableForm(){
    	$('#mainContent').show();
		$('#footerButton').show();
		$('#subHeader').hide();
		$('#subSection').hide();
		$('#subFooter').hide();
		$('#subFooter1').hide();
    }
</script>
