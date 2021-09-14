<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

CKEDITOR.config.height = 430;

$(document).ready(function() {
	fnInitStatus();
	
	CKEDITOR.instances.editor_area.setData($("#CONTENTS").val());

});

function fnInitStatus() {
	
	$("#btnModify").click(function(e){
		fnModify();
    });
	
	$("#SITE").change(function(e){
		if($(this).val()=='I') {
			$("#PRESENT_FLAG").val('A');
			$("#PRESENT_FLAG").prop('disabled', 'disabled');
		} else {
			$("#PRESENT_FLAG").prop('disabled', '');
		}
	});
}

var fnModify = function() {
	if(!fnValidator()) {
		return;
	}
	if(!confirm("수정하시겠습니까?")) {
		return;
	}
	
	var params = fnParams();
	params['SEQ'] = '${popupView.SEQ}';
	
	console.log(params);
	
	ajaxJsonCall("<c:url value='/com/mgt/modifyPopupMgmt.do'/>", params, function(result) {
		console.log(result);
		if(result.fields.resultCd == 'S') {
			alert("수정 완료 되었습니다.");
			$(opener.location).attr("href","javascript:searchList();");
			self.close();
		} else {
			alert("수정 중 에러가 발생하였습니다.");
		}
	}
	, function(result) {
		console.log(result);
		alert("수정 중 에러가 발생하였습니다.");
	});
};

function fnValidator() {
	var startDate = $("#START_DT");
	if(isEmpty(startDate.val())) {
		alert('시작일을 입력하세요.');
		startDate.focus();
		return false;
	}
	var endDate = $("#END_DT");
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

function fnParams() {
	var params = fnGetParams();
	params['userId'] = '${SESSION_INFO.USER_ID}';
	return params;
}


</script>
<div class="pop-wrap" style="width:100%;">
    <textarea id="CONTENTS" name="CONTENTS" style="display:none;">${popupView.CONTENTS }</textarea>
    
	<div class="pop-head">
		<h2>팝업 수정</h2>
		
		<div class="head-btn">
		  <button class="btn" id="btnModify">수정</button>
		</div>
	</div>
	
	<div class="pop-cont">
        <table class="table-style">
			<colgroup>
				<col style="width:15%;">
				<col style="width:35%;">
				<col style="width:15%;">
				<col style="width:35%;">
			</colgroup>
			<tbody>
				<tr>
					<th><strong class="stit">기간</strong></th>
					<td colspan="3">
						<input type="text" class="datepicker w120 t_center" id="START_DT" ReadOnly placeholder="시작일을 입력하세요." dateHolder="bgn" value="<c:out value='${popupView.START_DATE }'/>">
						<select id="START_HOUR" class="w50">
							<c:forEach var="i" begin="0" end="23">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />" <c:if test="${popupView.START_HOUR == i }">selected</c:if>><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>시</em>
						<select id="START_MIN" class="w50">
							<c:forEach var="i" begin="0" end="59">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />" <c:if test="${popupView.START_MIN == i }">selected</c:if>><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>분</em>
						<em>&nbsp;~&nbsp;</em>
						<input type="text" class="datepicker w120 t_center" id="END_DT" ReadOnly placeholder="종료일 입력하세요." dateHolder="end" value="<c:out value='${popupView.END_DATE }'/>">
						<select id="END_HOUR" class="w50">
							<c:forEach var="i" begin="0" end="23">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />" <c:if test="${popupView.END_HOUR == i }">selected</c:if>><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>시</em>
						<select id="END_MIN" class="w50">
							<c:forEach var="i" begin="0" end="59">
							<option value="<fmt:formatNumber value="${i }" pattern="00" />" <c:if test="${popupView.END_MIN == i }">selected</c:if>><fmt:formatNumber value="${i }" pattern="00" /></option>
							</c:forEach>
						</select>
						<em>분</em>
					</td>
				</tr>
				<tr>
					<th><strong class="stit">가로*세로 크기</strong></th>
					<td>
						<input type="text" id="WIDTH" class="w45" placeholder="가로크기" maxlength="4" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="<c:out value='${popupView.WIDTH }'/>">&nbsp;<strong>*</strong>&nbsp;<input type="text" id="HEIGHT" class="w45" maxlength="4" placeholder="세로크기" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="<c:out value='${popupView.HEIGHT }'/>">
					</td>
					<th><strong class="stit">상단,왼쪽 위치</strong></th>
					<td>
						<strong>(</strong>&nbsp;<input type="text" id="TOP" class="w45" maxlength="4" placeholder="상단위치" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="<c:out value='${popupView.TOP }'/>">&nbsp;<strong>,</strong>&nbsp;<input type="text" id="LEFT" maxlength="4" class="w45" placeholder="왼쪽위치" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" value="<c:out value='${popupView.LEFT }'/>">&nbsp;<strong>)</strong>
					</td>
				</tr>
				<tr>
					<th><strong class="stit">내부/외부</strong></th>
					<td>
						<select id="SITE" class="w100">
							<option value="A" <c:if test="${popupView.SITE == 'A' }">selected</c:if>>전체</option>
							<option value="I" <c:if test="${popupView.SITE == 'I' }">selected</c:if>>내부</option>
							<option value="E" <c:if test="${popupView.SITE == 'E' }">selected</c:if>>외부</option>
						</select>
					</td>
					<th><strong class="stit">표시시점</strong></th>
					<td>
						<select id="PRESENT_FLAG" class="w100" <c:if test="${popupView.SITE == 'I' }">disabled="disabled"</c:if>>
							<option value="A" <c:if test="${popupView.PRESENT_FLAG == 'A' }">selected</c:if>>로그인후</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><strong class="stit">사용여부</strong></th>
					<td colspan="3">
						<select id="DEL_YN" class="w100">
							<option value="N" <c:if test="${popupView.DEL_YN == 'N' }">selected</c:if>>사용</option>
							<option value="Y" <c:if test="${popupView.DEL_YN == 'Y' }">selected</c:if>>미사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th><strong class="stit">팝업명</strong></th>
					<td colspan="3"><input type="text" id="SUBJECT" class="wp100" maxlength="500" placeholder="제목을 입력하세요." value="<c:out value='${popupView.SUBJECT }'/>"></td>
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