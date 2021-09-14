<%--
	File Name : sysInFaqListPop.jsp
	Description: FAQ 팝업화면
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.10.20  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.10.20
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>

<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<script type="text/javascript">

gfnShowProgressing();
/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();
	// FAQ 조회
    fnSearchFaq();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("ul.tabs-control li a.tabtext").click(function () {
        var activeTab = $(this).attr("rel");
        moveTabMenu(activeTab);
    });
	
	
}

/**
 *  tab menu활성화
 */
function moveTabMenu(activeTab){
	$(".tabs-cont").hide();
	$("#" + activeTab).fadeIn();

    $("#activeTab").val();
    $("#activeTab").val(activeTab);
}


/**
 * FAQ 조회
 */
function fnSearchFaq(page){
	// 페이지 초기화
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"BOARD_ID" : "004"});
    
	// 조회 요청
	searchCall(null, '/com/sys/selectSysOutBoardFaqList', 'fnSearchFaq', params);
}

/**
 * 자료실 조회 성공 후 처리
 */
function fnSearchFaqSuccess(data) {
	// total cnt 초기화
    $('#faqTotal').empty();
	// FAQ 내용 초기화
    $('#faqList > tbody').empty();
    
	// 조회건수가 존재하는 경우
    if(data.rows.length > 0){
        $.each(data.rows, function(idx, vo) {
            
            var html = '';
            html += '<tr>'
            html +=     '<td align="center">'+ vo.TNUM  +'</td>'
            html +=     '<td align="center">'+ vo.CONTENTS_CLS_NM  +'</td>'
            html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
            html +=     '<td><a class="subject" href="javascript:fnFaqDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
            html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
            html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
            html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
            html += '</tr>'
            
            $('#faqList > tbody:last').append(html);
        });
    // 조회 건수가 미존재하는 경우
    } else {
        var html = '';
        html += '<tr>'
        html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
        html += '</tr>'
        
        $('#faqList > tbody:last').append(html);
    }
    
    // 페이징 처리
    if(!isEmpty(data.fields.pagingTag)){
        $('#faqPaging').empty();
        $('#faqPaging').append(data.fields.pagingTag);
    }
    
    // 전체건수 셋팅
    $('#faqTotal').append("Total <em>"+data.records+"</em>");
 	// 데이터 셋팅
    $('#faqPage').val(data.page);
}

/**
 * FAQ 상세내용 조회
 */
function fnFaqDetail(SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"BOARD_ID" : "004"});
    $.extend(params, {"page" : $("#faqPage").val()});
    $.extend(params, {"BTN_YN" : "N"});

    fnPostPopup('/com/sys/sysOutBoardDetail', params, "sysOutBoardDetail","900","600");
}

</script>

<input type="hidden" name="BOARD_ID" id="BOARD_ID" value="">
<input type="hidden" name="activeTab" id="activeTab" value="">

<input type="hidden" name="faqPage" id="faqPage" />

<div class="tabs">
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
		    <div class="selec-sch-box" style="float:left;">
		        <select id="srchGrpFaq" name="srchGrpFaq">
		            <option value ="01">제목</option>
		            <option value ="02">내용</option>
		            <option value ="03">작성자</option>
		        </select>
		        
		        <div class="tbl-sch-box">
		            <input type="text" id="srchTxtFaq" name="srchTxtFaq" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
		            <a href="javascript:fnSearchFaq();">검색</a>
		        </div>
		    </div>
		    
		 </div>
		
		<table class="tbl-list" id="faqList">
		    <colgroup>
		        <col style="width:50px">
		        <col style="width:100px">
		        <col style="width:70px">
		        <col style="width:*">
		        <col style="width:100px">
		        <col style="width:70px">
		        <col style="width:100px">
		    </colgroup>
		
		    <thead>
		        <tr>
		            <th>번호</th>
		            <th>구분</th>
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
		<div class="paging">
			<span class="total" id="faqTotal">Total : <em>999</em></span>
			<div id="faqPaging">
				
			    <c:if test="${not empty paginationInfo}">
			        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fnSearchData" />
			    </c:if>
			</div>
		</div>		
    </div>


