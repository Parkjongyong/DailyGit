<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var gridView;

CKEDITOR.config.height = 430;

$(document).ready(function() {
    fnInitStatus();
    
    CKEDITOR.instances.editor_area.setData($("#hidOrgCont").val());
});

function fnInitStatus() {
	
	$("#btnList").click(function(e){
		fnList();
    });
	
	$("#btnSave").click(function(e){
		fnSave();
    });
	
	$("#btnDel").click(function(e){
		fnDel();
    });
	
	fnInitFileUpload();
	
	//파일첨부 추가 이벤트 등록
    $("#btnMultiFile").click(function(e){
        var fileParams = {
             KEY_ID: 'APP_SEQ' // required 연관 파일 키
            ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
        };
        openFileUplaod(fileParams);
    });
}

var fnList = function() {
	var params = fnParams();
	fnPostGoto("<c:url value='/com/mgt/mgtBoardList.do'/>", params, "_self");
}

var fnBack = function() {
	var params = fnParams();
	fnPostGoto("<c:url value='/com/mgt/mgtBoardView.do'/>", params, "_self");
}

var fnSave = function() {
	if (fnValidator()) {
		if (confirm("저장하시겠습니까?")) {
			var sBodyValue = CKEDITOR.instances.editor_area.getData();
			
			$("#contents").val(sBodyValue);
			
			var params = fnParams();
// 			ajaxJsonCall("<c:url value='/com/mgt/modifyBoard.do'/>",  params, fnSaveSuccess);

			ajaxJsonCall("<c:url value='/com/mgt/modifyBoard.do'/>",  params, function(data){
				alert("저장 되었습니다.");
				fnBack();
			});
		}
	}
}

var fnDel = function() {
	var writer = "${boardView.USER_ID}";
    var currentUserId = "${SESSION_INFO.USER_ID}";
    if (writer !== currentUserId) {
        alert('타인의 게시물을 수정할 수 없습니다.'); return;
    }
	if (confirm("삭제하시겠습니까?")) {
	   var params = fnParams();
		ajaxJsonCall("<c:url value='/com/mgt/deleteBoard.do'/>",  params, function(data){
			alert("삭제 되었습니다.");
			fnList();
		});
	}
}

function fnValidator() {
	var writer = "${boardView.USER_ID}";
	var currentUserId = "${SESSION_INFO.USER_ID}";
	if (writer !== currentUserId) {
		alert('타인의 게시물을 수정할 수 없습니다.'); return false;
	}
	var subject = $('#subject');
	if(subject.val() == '' || subject.val() == null) {
		alert('제목을 입력하세요.');
		subject.focus();
		return false;
	}
	
	var editor_area = CKEDITOR.instances.editor_area.getData();
	
	if (editor_area == "") {
		 alert("작성된 내용이 없습니다. 내용을 입력하세요.");
		 CKEDITOR.instances.editor_area.focus();
         return false;
	}

	
	return true;
}

function fnSaveSuccess(data) {
	fnBack();
}

//첨부파일멀티용 시작
var fnInitFileUpload= function() {
    if ($("#APP_SEQ").val() != "") 
        displayFileUpload({
            KEY_ID      : 'APP_SEQ',
            DATA_FORMAT : 'table',
            CALLBACK    : 'fnFileUploadCallback'
        });
};

var fnFileUploadCallback = function(data) {
    $('#fileUploadTable').empty().html(data);
};

</script>

<style type="text/css">
</style>

<textarea id="contents" name="contents" style="display: none;"></textarea>
<input type="hidden" id="hidOrgCont" name="hidOrgCont" value="<c:out value='${boardView.CONTENTS }'/>">
<input type="hidden" id="SEQ" name="SEQ" value="<c:out value='${boardView.SEQ }'/>">

<input type="hidden" id="headnum" name="headnum" value="">


<jsp:include page="/WEB-INF/jsp/com/mgt/mgtBoardHeader.jsp" flush="false" />

<div class="cont-tit">
    <div class="right">
        <button type="button" id="btnList" class="btn st1">목록</button>
        <button type="button" id="btnSave" class="btn st1">저장</button>
        <button type="button" id="btnDel" class="btn st1">삭제</button>
    </div>
</div>
<div class="sub_tit subject_font ellipsis">
	<input type="text" id="subject" name="subject" class="wp100" maxlength="500" placeholder="제목을 입력하세요." value="<c:out value='${boardView.SUBJECT }'/>" style="height: 35px;">
</div>

<div>
    <c:choose>
        <c:when test="${boardInfo.BOARD_TYPE == 'FAQ'}">
                        구분&nbsp;:&nbsp;
            <select id="contents_cls">
              <c:forEach var="item" items="${CODELIST_ADM002}" varStatus="status">
                  <option value="${item.CODE}" <c:if test="${boardView.CONTENTS_CLS == item.CODE}">selected</c:if>>${item.CODE_NM}</option>
              </c:forEach>
            </select>
        </c:when>
        <c:otherwise><!-- 협력업체 FAQ -->
                      공지여부&nbsp;:&nbsp;
          <select id="notice" name="notice">
              <option value="0" <c:if test="${boardView.NOTICE == '0'}">selected</c:if>>일반</option>
              <option value="1" <c:if test="${boardView.NOTICE == '1'}">selected</c:if>>공지</option>
          </select>
                     게시여부&nbsp;:&nbsp;
          <select id="status" name="status">
              <option value="0" <c:if test="${boardView.STATUS == '0'}">selected</c:if>>임시저장</option>
              <option value="1" <c:if test="${boardView.STATUS == '1'}">selected</c:if>>게시</option>
          </select>
          <c:choose>
            <c:when test="${boardView.BOARD_ID == '201'}">
	                            익명여부&nbsp;:&nbsp;
	             <select id="closed_yn" name="closed_yn">
	                <option value="Y" <c:if test="${boardView.CLOSED_YN == 'Y'}">selected</c:if>>익명</option>
	                <option value="N" <c:if test="${boardView.CLOSED_YN == 'N'}">selected</c:if>>기명</option>
	             </select>
            </c:when>
            <c:otherwise>
                <input type="hidden" id="closed_yn" name="status" value="N">
            </c:otherwise>
          </c:choose>
       </c:otherwise>
    </c:choose>
</div>

<div>
	<textarea id="editor_area" name="editor_area" class="ckeditor" ></textarea>
</div>

<div class="sub-tit">
    <h4>첨부파일</h4>
    <input type="hidden" id="APP_SEQ" name="APP_SEQ" value="${boardView.ATTACHMENT }">
    <div class="right">
        <button type="button" id="btnMultiFile" class="btn writeBtn">첨부파일</button>
    </div>
</div>

<div id="fileUploadTable">
    <table class="table-style t_center">
        <colgroup>
            <col style="width: 8%;">
            <col style="width: 67%;">
            <col style="width: 15%;">
            <col style="width: 10%;">
        </colgroup>
        <thead>
        <tr>
            <th>No</th>
            <th>파일명</th>
            <th>등록일자</th>
            <th>파일크기</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td colspan="4" class="t_center" style="height: 80px">파일이 없습니다.</td>
        </tr>
        </tbody>
    </table>
</div>

