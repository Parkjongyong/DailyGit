<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var gridView;

$(document).ready(function() {
    
    fnInitStatus();
    boardListWithAjax();
});

function fnInitStatus() {
    
    $("#btnSearch").click(function(e){
        boardListWithAjax();
    });
    
   //Enter 이벤트
    $(".enterEvnt").keyup(function(e) {
        if (e.keyCode == 13) {
        	boardListWithAjax();
        }
    });
}

function boardListWithAjax(page){
    var params = fnParams();
    params.status = "1";

    ajaxJsonCall('<c:url value="/com/mgt/selectMgtBoardListFaq.do"/>',  params, fnSuccess);
}

function fnSuccess(data) {
	var faqArea = $("#faqArea");
    faqArea.empty();
    
    $.each(data.rows, function(index, value){
        var html = '';
        var subject = value.SUBJECT;
        subject = subject.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br/>").replaceAll("\r", "<br/>").replaceAll("\n", "<br/>").replaceAll(" ", "&nbsp;");
        var contents = value.CONTENTS;
        contents = contents.replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br/>").replaceAll("\r", "<br/>").replaceAll("\n", "<br/>").replaceAll(" ", "&nbsp;");
        
        html += "<dl class='faq-box'>";
        
        html += "<dt>";
        html += "<em class='faq-type'>Q.</em>";
        html += "<strong class=faq-tit'>";
        html += "<c:out value='"+subject+"' escapeXml='false' />";
        html += "</strong>";
        html += "</dt>";

        html += "<dd>";
        html += "<em class='faq-type st2'>A.</em>";
        html += "<p>";
        html += "<c:out value='"+contents+"' escapeXml='false' />";
        html += "</p>";
        html += "</dd>";
        
        html += "</dl>";

        faqArea.prepend(html).trigger("create");
        
    });
    $('.faq-box:eq(0) dt, .faq-box:eq(0) dd').addClass('active');
    $('.faq-box:eq(0) dd').show();
    
    $('.faq-box > dt').on('click', function () {
        
        $(this).toggleClass('active');
        $('.faq-box > dt').not(this).removeClass('active'); 
        $('.faq-box > dd').not(this).removeClass('active'); 

        var target = $(this).next('dd');
        target.toggleClass('active');
        

        var other = $('.faq-box > dt').not(this).next('dd');
        target.stop(true,true).slideToggle(300)
        other.stop(true,true).slideUp(300);
        
        return false;
    });
}

function fnParams() {
    var params = fnGetParams();
    params['BOARD_ID'] = '${data.BOARD_ID}';
    params['userId'] = '${SESSION_INFO.USER_ID}';
    return params;
}

</script>

<div class="pop-wrap">
    <div class="pop-head">
		<div class="cont-tit" style="height:60px;">
		    <h2>${boardInfo.BOARD_NM}</h2>
		</div>
	
		<div class="sub_tit">
		    <h3><c:out value="${boardInfo.MEMO }"/></h3>
		</div>  
    </div>
    <div class="pop-cont">
		<div class="search-area">     
		     <div class="search-cont">
		         <select id="CONTENTS_CLS">
		             <option value="">전체</option>
		             <c:forEach var="item" items="${CODELIST_ADM003}" varStatus="status">
		                 <option value="${item.CODE}">${item.CODE_NM}</option>
		             </c:forEach>
		         </select>
		         <div class="search-btn-box wp100">
		             <input type="text" id="srchTxt"  class="enterEvnt" placeholder="궁금하신 점을 검색해 보세요.">  
		             <button id="btnSearch" class="search-btn">검색</button>  
		         </div>
		     </div>
		</div>
		
		<div id="faqArea" class="faq-list">
		</div>
	</div>
</div>


