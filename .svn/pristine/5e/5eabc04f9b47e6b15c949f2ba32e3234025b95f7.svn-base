<%--
	File Name : sysInBoardList.jsp
	Description: 내부게시판 조회/등록/수정/삭제 화면
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.06.22  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.06.22
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
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
	// 공지사항 조회
    fnSearchNotice();
	// 자료실 조회
    fnSearchData();
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
 * 공지사항 글쓰시 팝업
 */
function fnNoticeWrite() {
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "001"});
    
    fnPostPopup('/com/sys/sysOutBoardWritePop', params, "sysOutBoardWritePop","900","900");
}

/**
 * 자료실 글쓰시 팝업
 */
 function fnDataWrite() {
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "002"});
    
    fnPostPopup('/com/sys/sysOutBoardWritePop', params, "sysOutBoardWritePop","900","900");
}

/**
 * FAQ 글쓰시 팝업
 */
 function fnFaqWrite() {
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "004"});
    
    fnPostPopup('/com/sys/sysOutBoardWritePop', params, "sysOutBoardWritePop","900","900");
}

 /**
  * 공지사항 조회
  */
function fnSearchNotice(page){
	gfnCloseProgressing();
	
	// 페이지 초기화
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "001"});
    
	// 조회 요청
	searchCall(null, '/com/sys/selectSysOutBoardNoticeList', 'fnSearchNotice', params);    
}
 
/**
 * 공지사항 조회 성공 후 처리
 */
function fnSearchNoticeSuccess(data) {
	// total cnt 초기화
    $('#noticeTotal').empty();
	// 공지사항 내용 초기화
    $('#noticeList > tbody').empty();
    
    if(data.rows.length > 0){
        $.each(data.rows, function(idx, vo) {
            var html = '';
            html += '<tr>'
            html +=     '<td align="center">'+ vo.TNUM  +'</td>'
            html +=     '<td align="center">'+ vo.NOTICE_NM  +'</td>'
            html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
            html +=     '<td><a class="subject" href="javascript:fnNoticeDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
            html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
            html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
            html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
            html += '</tr>'
            
            $('#noticeList > tbody:last').append(html);
        });
    } else {
        var html = '';
        html += '<tr>'
        html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
        html += '</tr>'
        
        $('#noticeList > tbody:last').append(html);
    }
    
    // 페이징 처리
    if(!isEmpty(data.fields.pagingTag)){
        $('#noticePaging').empty();
        $('#noticePaging').append(data.fields.pagingTag);
    }
    
    // 전체건수 셋팅
    $('#noticeTotal').append("Total :<em>"+data.records+"</em>");
    // 데이터 셋팅
    $('#noticePage').val(data.page);
}

/**
 * 자료실 조회
 */
function fnSearchData(page){
	// 페이지 초기화
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpData").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtData").val()});
    $.extend(params, {"BOARD_ID" : "002"});
    
	// 조회 요청
	searchCall(null, '/com/sys/selectSysOutBoardDataList', 'fnSearchData', params);
}

/**
 * 자료실 조회 성공 후 처리
 */
function fnSearchDataSuccess(data) {
	// total cnt 초기화
    $('#dataTotal').empty();
	// 자료실 내용 초기화
    $('#dataList > tbody').empty();
    
    if(data.rows.length > 0){
        $.each(data.rows, function(idx, vo) {
            var html = '';
            html += '<tr>'
            html +=     '<td align="center">'+ vo.TNUM  +'</td>'
            html +=     '<td align="center">'+ vo.NOTICE_NM  +'</td>'
            html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
            html +=     '<td><a class="subject" href="javascript:fnDataDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
            html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
            html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
            html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
            html += '</tr>'
            
            $('#dataList > tbody:last').append(html);
        });
    } else {
        var html = '';
        html += '<tr>'
        html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
        html += '</tr>'
        
        $('#dataList > tbody:last').append(html);
    }
    
 	// 페이징 처리
    if(!isEmpty(data.fields.pagingTag)){
        $('#dataPaging').empty();
        $('#dataPaging').append(data.fields.pagingTag);
    }
    
 	// 전체건수 셋팅
    $('#dataTotal').append("Total <em>"+data.records+"</em>");
 	// 데이터 셋팅
    $('#dataPage').val(data.page);
}

/**
 * FAQ 조회
 */
function fnSearchFaq(page){
	// 페이지 초기화
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
//     $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
//     $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
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
 * 공지사항 상세내용 조회
 */
function fnNoticeDetail(SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "001"});
    $.extend(params, {"page" : $("#noticePage").val()});
    
    fnPostPopup('/com/sys/sysOutBoardDetail', params, "sysOutBoardDetail","900","900");
}

/**
 * 자료실 상세내용 조회
 */
function fnDataDetail(SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "002"});
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpData").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtData").val()});
    $.extend(params, {"page" : $("#dataePage").val()});
    
    fnPostPopup('/com/sys/sysOutBoardDetail', params, "sysOutBoardDetail","900","900");
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
    
    fnPostPopup('/com/sys/sysOutBoardDetail', params, "sysOutBoardDetail","900","900");
}

</script>

<input type="hidden" name="BOARD_ID" id="BOARD_ID" value="">
<input type="hidden" name="activeTab" id="activeTab" value="">

<input type="hidden" name="noticePage" id="noticePage" />
<input type="hidden" name="dataPage" id="dataPage" />
<input type="hidden" name="faqPage" id="faqPage" />

<div class="tabs">
    <ul class="tabs-control">
        <li><a href="#tabs1" class="tabtext" rel="tabs1">공지사항</a></li>
        <li><a href="#tabs2" class="tabtext" rel="tabs2">자료실</a></li>
        <li><a href="#tabs3" class="tabtext" rel="tabs3">FAQ</a></li>
    </ul>
    
    <div id="tabs1" class="tabs-cont">
    
        <div class="tbl-top-area">
		    <div class="selec-sch-box" style="float:left;">
		        <select id="srchGrpData" name="srchGrpNotice"> 
		            <option value ="01">제목</option>
		            <option value ="02">내용</option>
		            <option value ="03">작성자</option>
		        </select>
		        
		        <div class="tbl-sch-box">
		            <input type="text" id="srchTxtNotice" name="srchTxtData" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
		            <a href="javascript:fnSearchNotice();">검색</a>
		        </div>
		    </div>
			<div class="btnArea t_right" style="float:right;">
				<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
					<button type="button" class="btn" id="btnNoticeWrite">글쓰기</button>
				</c:if>
			</div>			    
		 </div>
		<table class="tbl-list" id="noticeList">
		    <colgroup>
		        <col style="width:50px">
		        <col style="width:70px">
		        <col style="width:70px">
		        <col style="width:*">
		        <col style="width:100px">
		        <col style="width:70px">
		        <col style="width:100px">
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
		<div class="paging">
			<span class="total" id="noticeTotal">Total : <em>999</em></span>
			<div id="noticePaging">
				
			    <c:if test="${not empty paginationInfo}">
			        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fnSearchNotice" />
			    </c:if>
			</div>
		</div>
    </div>
    
    <div id="tabs2" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
		    <div class="selec-sch-box" style="float:left;">
		        <select id="srchGrpData" name="srchGrpData">
		            <option value ="01">제목</option>
		            <option value ="02">내용</option>
		            <option value ="03">작성자</option>
		        </select>
		        
		        <div class="tbl-sch-box">
		            <input type="text" id="srchTxtData" name="srchTxtData" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
		            <a href="javascript:fnSearchData();">검색</a>
		        </div>
		    </div>
			<div class="btnArea t_right" style="float:right;">
				<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
					<button type="button" class="btn" id="btnDataWrite">글쓰기</button>
				</c:if>
			</div>			    
		 </div>
		
		<table class="tbl-list" id="dataList">
		    <colgroup>
		        <col style="width:50px">
		        <col style="width:70px">
		        <col style="width:70px">
		        <col style="width:*">
		        <col style="width:100px">
		        <col style="width:70px">
		        <col style="width:100px">
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
		
		<div class="paging">
			<span class="total" id="dataTotal">Total : <em>999</em></span>
			<div id="dataPaging">
				
			    <c:if test="${not empty paginationInfo}">
			        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fnSearchData" />
			    </c:if>
			</div>
		</div>
    </div>
    
    <div id="tabs3" class="tabs-cont">                           
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
		            <a href="javascript:fnSearchFaq;">검색</a>
		        </div>
		    </div>
		    
			<div class="btnArea t_right" style="float:right;">
				<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
					<button type="button" class="btn" id="btnFaqWrite">글쓰기</button>
				</c:if>
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
</div>


