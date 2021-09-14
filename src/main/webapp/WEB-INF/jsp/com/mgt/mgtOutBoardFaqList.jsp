<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>

<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>
<script type="text/javascript">

$(document).ready(function() {
	initFaq();
//     setEvent();
});

var initFaq = function(){
	searchFaq();
	
	$(document).on("click", "#btnFaqWrite", function(e){
        fnFaqWrite();
    });
}

function searchFaq(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"BOARD_ID" : "103"});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtOutBoardFaqList.do"/>',  params, function(data){
        
        $('#faqTotal').empty();
        $('#faqList > tbody').empty();
        
        if(data.rows.length > 0){
	        $.each(data.rows, function(idx, vo) {
	            
	            var html = '';
	            html += '<tr>'
	            html +=     '<td align="center">'+ vo.TNUM  +'</td>'
	            html +=     '<td align="center">'+ vo.CONTENTS_CLS_NM  +'</td>'
	            html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
	            html +=     '<td class="subject"><a href="javascript:fnFaqDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
	            html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
	            html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
	            html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
	            html += '</tr>'
	            
	            $('#faqList > tbody:last').append(html);
	        });
        }else{
        	var html = '';
            html += '<tr>'
            html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
            html += '</tr>'
            
            $('#faqList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#faqPaging').empty();
            $('#faqPaging').append(data.fields.pagingTag);
        }
        
        $('#faqTotal').append("총 <strong>"+data.records+"</strong>건");
        $('#faqPage').val(page);
    });
}

var fnFaqDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"BOARD_ID" : "103"});
    $.extend(params, {"page" : $("#faqPage").val()});
    
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnFaqWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "103"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}

</script>

<input type="hidden" id="faqPage" name="faqPage" />

<div class="tbl-top-area">
    <span class="total" id="faqTotal">총 <strong><c:out value="${TOT_CNT }" /></strong>건</span>

    <div class="selec-sch-box">
        <select id="srchGrpFaq" name="srchGrpFaq">
            <option value ="01">제목</option>
            <option value ="02">내용</option>
            <option value ="03">작성자</option>
        </select>
        
        <div class="tbl-sch-box">
            <input type="text" id="srchTxtFaq" name="srchTxtFaq" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
            <a href="javascript:searchFaq();">검색</a>
        </div>
    </div>
 </div>

<table class="table-style01" id="faqList">
    <colgroup>
        <col style="width:5%">
        <col style="width:7%">
        <col style="width:7%">
        <col>
        <col style="width:7%">
        <col style="width:5%">
        <col style="width:7%">
    </colgroup>

    <thead>
        <tr>
            <th>번호</th>
            <th>공지여부</th>
            <th>게시여부</th>
            <th>제목</th>
            <th>작성자</th>
            <th>조회수</th>
            <th>등록일</th>
        </tr>
    </thead>
    <tbody>
    </tbody>
</table>

<!-- 쓰기, 수정 권한 (시스템담당자, 구매담당자) 수정은 본인 것만 -->
<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
<div class="paging-btn">
    <a href="#none" id="btnFaqWrite" class="bbtn">글쓰기</a>
</div>
</c:if>

<div class="paging-area" id="faqPaging">
    <c:if test="${not empty paginationInfo}">
        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchFaq" />
    </c:if>
</div>