<%--
	File Name : sysPopupMgmtView.jsp
	Description: 알림 팝업 화면
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.06.18  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
.pop-cont { padding: 5px 30px; }
.view-tit { padding-bottom: 0px; border-bottom: 1px solid #2f2f2f; }
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
	// 스타일 적용
	textareaHeight($('#CONTENTS'));
}

/**
 * 하루동안 창을 띄우지 않습니다 클릭 시 이벤트
 */
function fnPopDay() {
	setCookieInfo();
	self.close();
}

/**
 * 확인 클릭 시 이벤트
 */
function fnPopOk() {
	self.close();
}

/**
 * textarea 스타일 적용
 */
function textareaHeight(obj) {
	$(obj).css("height", $(obj).prop('scrollHeight')+12+"px");
}

/**
 * 쿠키정보 셋팅
 */
function setCookieInfo() {
	var date = new Date();
	date.setDate(date.getDate() + 1);
	date.setHours(0, 0, 1);
	$.cookie("popup_${popupView.SEQ}", "true", {path:"/", expires: date, secure: false});
}

</script>
<div class="pop-wrap"  style="width:100%;">

    <div class="pop-head">
        <h2><c:out value="${popupView.SUBJECT }"/></h2>
        
        <a href="#none" class="close">닫기</a>
    </div>
	
	<div class="pop-cont">
		<div class="view-tit">
        </div>
        <div class="view-area">
            <div class="view-cont">
                <div class="view-desc">
	               <pre style="white-space: pre-wrap">${popupView.CONTENTS }</pre>
	            </div>
            </div>
            
            <div class="b-btn-area t_center">
                <button type="button" id="btnPopDay" class="btn">하루동안 창을 띄우지 않습니다.</button>
                <button type="button" id="btnPopOk" class="btn">확인</button>
            </div>
        </div>
    </div>
</div>