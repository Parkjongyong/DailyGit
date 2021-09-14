<%--
	File Name : sysOutBoardDetail.jsp
	Description: 공지사항 상세내용 조회
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.06.22  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.06.22
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"   %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s"       uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
.pop-cont { padding: 5px 30px; }
.tab-cont02 { margin-top:10px; }
.view-tit h4{ overflow: hidden; text-overflow: ellipsis; white-space: nowrap; width: 840px; }
</style>

<script type="text/javascript">
/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();	
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	if("${BTN_YN}" == "N"){
		$("#div_btn").hide();
	}
}

/**
 * 공지사항 수정 버튼 클릭 시 이벤트
 */
function fnEdit() {
	var params = fnGetMakeParams();
    $.extend(params, {"SEQ":$("#SEQ").val()});
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    $.extend(params, {"page": $("#page").val()});
	
	fnPostGoto('/com/sys/sysOutBoardEditPop', params, "_self");
}

/**
 * 이전/다음글 조회
 */
function fnDetail(POST_SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":POST_SEQ});
    $.extend(params, {"page": $("#page").val()});
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    $.extend(params, {"srchGrp" : $("#srchGrp").val()});
    $.extend(params, {"srchTxt" : $("#srchTxt").val()});
    
    if("${BTN_YN}" == "N"){
        $.extend(params, {"BTN_YN" : "N"});
    }
    
    fnPostPopup('/com/sys/sysOutBoardDetail', params, "_self");
}


/**
 * 공지사항 삭제 버튼 클릭 시 이벤트
 */
function fnDelete() {
	var params = fnGetMakeParams();
    $.extend(params, {"SEQ":$("#SEQ").val()});
    $.extend(params, {"BOARD_ID":$("#BOARD_ID").val()});
    
    if (confirm("삭제하시겠습니까?")) {
		// 조회 요청
		deleteCall(null, '/com/sys/deleteBoard', 'fnDelete', params);
     }
}

/**
 * 삭제 성공 시 처리
 */
function fnDeleteSuccess(jObj) {
    alert("삭제 되었습니다.");
    
    var boardId = $("#BOARD_ID").val();
    if (boardId == "101" || boardId == "001" || boardId == "301"){
    	// 부모 공지사항 조회	
    	parentCallback('fnSearchNotice');
    } else if (boardId == "102" || boardId == "002" || boardId == "302"){
    	// 부모 자료실 조회	
    	parentCallback('fnSearchData');    	
    } else if (boardId == "103" || boardId == "004"){
    	// 부모 FAQ 조회	
    	parentCallback('fnSearchFaq');     	
    } 
}

/**
 * 삭제 실패 시 처리
 */
function fnDeleteFail(jObj) {
	if (jObj.errMsg == ""){
		alert("삭제에 실패했습니다.");
	} else {
		alert(jObj.errMsg);
	}
	return;
}

function fnClose() {
	self.close();
}



</script>

<input type="hidden" id="page" name="page" value="<c:out value="${page }" />" />

<input type="hidden" id="srchGrp" name="srchGrp" value="<c:out value="${srchGrp }" />" />
<input type="hidden" id="srchTxt" name="srchTxt" value="<c:out value="${srchTxt }" />" />
<input type="hidden" id="BOARD_ID" name="BOARD_ID" value="<c:out value="${BOARD_ID }" />" />
<input type="hidden" id="SEQ" name="SEQ" value="<c:out value="${dataInfo.SEQ }" />" />
<div class="pop-wrap" style="width:900px">
	<div class="pop-head">
	    <h2 id="headTitle"><c:out value="${boardInfo.BOARD_NM }" /></h2>
	</div>
	
	<div class="pop-cont">
	    <section id="tabList2-01" class="tab-cont02 active">
	        <div class="view-area">
	            <div class="view-tit">
	                <h4><c:out value="${dataInfo.SUBJECT }" /></h4>
	                
	                <ul class="view-info">
	                    <li>No : <c:out value="${dataInfo.SEQ }" /></li>
	                    <li>작성일 : <c:out value="${dataInfo.INS_DT }" /></li>
	                    <li>조회수 : <c:out value="${dataInfo.HIT_CNT }" /></li>
	                </ul>
	            </div>
	            
	            <div class="view-cont">
	                <div class="view-desc">
	                    <pre style="white-space: pre-wrap" readOnly="ReadOnly">${dataInfo.CONTENTS }</pre>
	                </div>
	                
	                <c:if test="${!empty fileList}">
	                <ul class="file-list">
	                    <c:forEach var="fileInfo" items="${fileList}" varStatus="status">
	                    <li><a href="javascript:oneFileDownload('${fileInfo.APP_SEQ}', '${fileInfo.attachmentSeq}');" class="file">${fileInfo.FILE_NAME}</a></li>
	                    </c:forEach>
	                </ul>
	                </c:if>
	            </div>
	            
	            <div class="b-btn-area t_right" id="div_btn">
	            <c:if test="${(fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')) && SESSION_INFO.USER_ID == dataInfo.USER_ID }">
	            	<button type="button" id="btnEdit" class="btn">수정</button>
                    
                    <c:if test="${BOARD_ID ne '304'}">
                    	<button type="button" id="btnDelete" class="btn">삭제</button>
                    </c:if>
                </c:if>
                	<button type="button" id="btnClose" class="btn">닫기</button>
	            </div>
	            
	            <ul class="view-paging">
	            <c:if test="${not empty subDataInfo.PRE_SEQ}">
	                <li>
	                   <span class="paging prev">이전글</span>
	                   <strong><a class="subject" href="javascript:fnDetail(<c:out value='${subDataInfo.PRE_SEQ }' />)"><c:out value="${subDataInfo.PRE_SUBJECT }" /></a></strong>
	                   <span class="date"><c:out value="${subDataInfo.PRE_INS_DT }" /></span>
	                </li>
	            </c:if>
	                
	            <c:if test="${not empty subDataInfo.NEXT_SEQ}">
	                <li>
	                    <span class="paging next">다음글</span>
	                    <strong><a href="javascript:fnDetail(<c:out value='${subDataInfo.NEXT_SEQ }' />)"><c:out value="${subDataInfo.NEXT_SUBJECT }" /></a></strong>
	                    <span class="date"><c:out value="${subDataInfo.NEXT_INS_DT }" /></span>
	                </li>
	            </c:if>
	            </ul>
	        </div>
	    </section><!--//공지사항 -->
	</div>
</div>