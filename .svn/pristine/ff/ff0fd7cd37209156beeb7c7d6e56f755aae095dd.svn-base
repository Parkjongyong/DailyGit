<%--
	File Name : sysPopupMgmtWrite.jsp
	Description: 알림 팝업 신규 등록 화면
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

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

CKEDITOR.config.height = 430;
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
	$("#SITE").change(function(e){
		if($(this).val() == 'I') {
			$("#PRESENT_FLAG").val('A');
			$("#PRESENT_FLAG").prop('disabled', 'disabled');
		} else {
			$("#PRESENT_FLAG").prop('disabled', '');
		}
	});
}

/**
 * 저장 버튼 클릭 시 이벤트
 */
var fnSave = function() {
	// 추가 체크 후 저장 진행
	if (fnExtValidation() == true) {
		
		if(confirm("저장 하시겠습니까?")){
	    	
			// 파라미터 초기화
			var params = {};
			// 추가 데이터 추출
			$.extend(params, fnGetParams());
			$.extend(params, {userId : '${SESSION_INFO.USER_ID}'});
		    saveCall(null, '/com/sys/insertPopupMgmt', null, params);
	    }			
	}
};

/**
 * 저장 성공 시 처리
 */
function fnSaveSuccess(jObj) {
	console.log(jObj);
	if(jObj.fields.resultCd == 'S') {
		alert("저장 완료 되었습니다.");
		$(opener.location).attr("href","javascript:fnSearch();");
		self.close();
	} else {
		alert("저장 중 에러가 발생하였습니다.");
	}
}

/**
 * 저장 실패 시 처리
 */
function fnSaveFail(jObj) {
	console.log(jObj);
	alert("저장 중 에러가 발생하였습니다.");
}

/**
 * 추가 체크로직
 */
function fnExtValidation() {

	var startDate = $("#TB_START_DT");
	if(isEmpty(startDate.val())) {
		alert('시작일을 입력하세요.');
		startDate.focus();
		return false;
	}
	var endDate = $("#TB_END_DT");
	if(isEmpty(endDate.val())) {
		alert('종료일을 입력하세요.');
		endDate.focus();
		return false;
	}
	
	var width = $("#WIDTH");
	if(isEmpty(width.val())) {
		alert('가로크기를 입력하세요.');
		width.focus();
		return false;
	}
	if(!isNumCheck(width.val())){
		alert('숫자만 입력하세요.');
		width.focus();
		return false;
	}
	var height = $("#HEIGHT");
	if(isEmpty(height.val())) {
		alert('세로크기를 입력하세요.');
		height.focus();
		return false;
	}
	if(!isNumCheck(height.val())){
		alert('숫자만 입력하세요.');
		width.focus();
		return false;
	}
	var top = $("#TOP");
	if(isEmpty(top.val())) {
		alert('상단위치를 입력하세요.');
		top.focus();
		return false;
	}
	if(!isNumCheck(top.val())){
		alert('숫자만 입력하세요.');
		width.focus();
		return false;
	}
	var left = $("#LEFT");
	if(isEmpty(left.val())) {
		alert('왼쪽위치를 입력하세요.');
		left.focus();
		return false;
	}
	if(!isNumCheck(left.val())){
		alert('숫자만 입력하세요.');
		width.focus();
		return false;
	}
	
	var subject = $('#SUBJECT');
	if(isEmpty(subject.val())) {
		alert('제목을 입력하세요.');
		subject.focus();
		return false;
	}
	
	var editor_area = CKEDITOR.instances.editor_area.getData();

	console.log(editor_area.replace(/(<([^>]+)>)/ig,""));
	
	if (editor_area == "") {
		alert("내용을 입력하세요.");
		CKEDITOR.instances.editor_area.focus();
		return false;
	}else{
		$('#CONTENTS').val(editor_area);
	}
	
	var start = startDate.val().replace(/-/g, "");
	start += $("#START_HOUR").val()+$("#START_MIN").val();
	var end = endDate.val().replace(/-/g, "");
	end += $("#END_HOUR").val()+$("#END_MIN").val();
	if(end - start < 0){
		alert("종료일이 시작일보다 이전일 수 없습니다.");
		startDate.focus();
		return false;
	}
	
	return true;
}

</script>
<div class="pop-wrap" style="width:100%;">
    
	<textarea id="CONTENTS" name="CONTENTS" style="display:none;">${popupView.CONTENTS }</textarea>

	<div class="pop-head">
		<h2>팝업 작성</h2>

		<div class="head-btn">
            <button class="btn" id="btnSave">저장</a>
        </div>
	</div>
	
	<div class="pop-cont">
		<table class="tbl-view">
			<colgroup>
				<col style="width:15%;">
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:35%;">
			</colgroup>
			<tbody>
				<tr>
					<th><span>기간</span></th>
					<td colspan="3">
						<input type="text" class="datepicker w120 t_center" id="TB_START_DT" ReadOnly placeholder="시작일을 입력하세요." dateHolder="bgn">
						<select id="START_HOUR" >
							<c:forEach var="i" begin="0" end="23">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />"><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>시</em>
						<select id="START_MIN" >
							<c:forEach var="i" begin="0" end="59">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />"><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>분</em>
						<em>&nbsp;~&nbsp;</em>
						<input type="text" class="datepicker w120 t_center" id="TB_END_DT" ReadOnly placeholder="종료일 입력하세요." dateHolder="end">
						<select id="END_HOUR" >
							<c:forEach var="i" begin="0" end="23">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />"><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>시</em>
						<select id="END_MIN" >
							<c:forEach var="i" begin="0" end="59">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />"><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>분</em>
					</td>
				</tr>
				<tr>
					<th><span>가로*세로 크기</span></th>
					<td>
						<input type="text" id="WIDTH" class="w45" placeholder="가로크기" maxlength="4">&nbsp;<span>*</span>&nbsp;<input type="text" id="HEIGHT" class="w45" placeholder="세로크기" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
					</td>
					<th><span>상단,왼쪽 위치</span></th>
					<td>
						<span>(</span>&nbsp;<input type="text" id="TOP" class="w45" maxlength="4" placeholder="상단위치" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">&nbsp;<span>,</span>&nbsp;<input type="text" id="LEFT" class="w45" placeholder="왼쪽위치" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">&nbsp;<span>)</span>
					</td>
				</tr>
				<tr>
					<th><span>내부/외부</span></th>
					<td>
						<select id="SITE" >
							<option value="A">전체</option>
							<option value="I">내부</option>
							<option value="E">외부</option>
						</select>
					</td>
					<th><span>표시시점</span></th>
					<td>
						<select id="PRESENT_FLAG" >
							<option value="A">로그인후</option>
						</select>
					</td>
				</tr>
					<th><span>사용여부</span></th>
					<td colspan="3">
						<select id="DEL_YN" >
							<option value="N">사용</option>
							<option value="Y">미사용</option>
						</select>
					</td>
				<tr>
				</tr>
				<tr>
					<th><span>팝업명</span></th>
					<td colspan="3">
					   <input type="text" id="SUBJECT" class="wp100" maxlength="500" placeholder="제목을 입력하세요.">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<textarea id="editor_area" name="editor_area" class="ckeditor" ></textarea>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>