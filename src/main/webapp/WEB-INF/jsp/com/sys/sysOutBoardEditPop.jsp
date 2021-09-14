<%--
	File Name : sysOutBoardEditPop.jsp
	Description: 공지사항 수정 화면
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
.vos-write dt { width:10%; }
.vos-write dd { width:90%; }
</style>

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
	// 원본 데이터 셋팅
    CKEDITOR.instances.editor_area.setData($("#hidOrgCont").val());
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	
	// 첨부파일 업로드
    fnInitFileUpload();
	
}

/**
 * 첨부파일 버튼 클릭 시 이벤트
 */
function fnAttFile() {
    var fileParams = {KEY_ID: 'APP_SEQ' // required 연관 파일 키
                     ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
                     };
    openFileUplaod(fileParams);
}


/**
 * 닫기 버튼 클릭 시 이벤트
 */
function fnClose() {
	self.close();
}

/**
 * 첨부파일멀티용 시작
 */
function fnInitFileUpload() {
    if ($("#APP_SEQ").val() != "") 
    	// 첨부파일 활성화
        displayFileUpload({
            KEY_ID      : 'APP_SEQ',
            DATA_FORMAT : 'outTable',
            CALLBACK    : 'fnFileUploadCallback'
        });
};

/**
 * 첨부파일멀티용 CALL BACK
 */
function fnFileUploadCallback(data) {
    $('.upload-list').empty().html(data);
};

/**
 * 저장 버튼 클릭 시 이벤트
 */
function fnSave() {
	// 필수 체크
	var boardId = $("#BOARD_ID").val();
	if (fnValidate() ) {
	    if(confirm("저장 하시겠습니까?")) {
	    	
	    	if (boardId == "103" || boardId == "004"){
	    		$("#contents").val(CKEDITOR.instances.editor_area.getData().replace(/(<([^>]+)>)/ig,""));
	    	}else{
	    		$("#contents").val(CKEDITOR.instances.editor_area.getData());
	    	}
	        
	        var params = {};
	        $.extend(params, fnGetParams());
	        
			// 조회 요청
			deleteCall(null, '/com/sys/modifyBoard', 'fnSave', params);    
	    }
	}
}

/**
 * 삭제 성공 시 처리
 */
function fnSaveSuccess(result) {
    console.log(result);
	// 필수 체크
	var boardId = $("#BOARD_ID").val();
    if(result.fields.resultCd == 'S') {
        alert("저장 되었습니다.");
        
        if (boardId == "101" || boardId == "001" || boardId == "301"){
        	// 부모 공지사항 조회	
        	parentCallback('fnSearchNotice', result.page);                        
        } else if (boardId == "102" || boardId == "002" || boardId == "302"){
        	// 부모 자료실 조회	
        	parentCallback('fnSearchData', result.page);                     	
        } else if (boardId == "103" || boardId == "004"){
        	// 부모 FAQ 조회	
        	parentCallback('fnSearchFaq', result.page);                     	
        }
    } else {
        alert("저장에 실패 하였습니다.");
    }
}

/**
 * 삭제 실패 시 처리
 */
function fnSaveFail(jObj) {
    console.log(result);
    alert("저장에 실패 하였습니다.");
}

/**
 * 필수 체크 로직
 */
function fnValidate() {
	var editor_area = CKEDITOR.instances.editor_area.getData();
	
    if($("#subject").val() == ""){
    	alert("제목을 입력 해 주세요.");
    	$("#subject").focus();
    	return false;
    }else if (editor_area == "") {
    	alert("내용을 입력 해 주세요.");
    	CKEDITOR.instances.editor_area.focus();
        return false;
    }
    return true;
}

</script>

<input type="hidden" id="BOARD_ID" name="BOARD_ID" value="<c:out value="${boardInfo.BOARD_ID }" />" />
<input type="hidden" id="APP_SEQ" name="APP_SEQ" value="<c:out value="${dataInfo.ATTACHMENT }" />" />
<input type="hidden" id="SEQ" name="SEQ" value="<c:out value="${dataInfo.SEQ }" />" />
<input type="hidden" id="hidOrgCont" name="hidOrgCont" value="<c:out value='${dataInfo.CONTENTS }'/>">

<textarea id="contents" name="contents" style="display:none;"></textarea>

<div class="pop-wrap" style="width:900px">
	<div class="pop-head">
	    <h2 id="headTitle"><c:out value="${boardInfo.BOARD_NM }" /></h2>
	</div>
	
	<div class="pop-cont">
        <ul class="vos-write-area">
        <c:choose>
            <c:when test="${boardInfo.BOARD_ID == '103'}">
            <li>
                <dl class="vos-write">
                    <dt>구분</dt>
                    <dd>
                        <select id="contents_cls">
                        <c:forEach var="item" items="${CODELIST_ADM002}" varStatus="status">
                            <option value="${item.CODE}" <c:if test="${dataInfo.CONTENTS_CLS == item.CODE}">selected</c:if>>${item.CODE_NM}</option>
                        </c:forEach>
			            </select>
                    </dd>
                </dl>
            </li>
            <li>
                <dl class="vos-write">
                    <dt>게시여부</dt>
                    <dd>
                        <select id="status" name="status">
                            <option value="0" <c:if test="${dataInfo.STATUS == '0'}">selected</c:if>>임시저장</option>
                            <option value="1" <c:if test="${dataInfo.STATUS == '1'}">selected</c:if>>게시</option>
                        </select>
                    </dd>
                </dl>
            </li>
            </c:when>
            <c:when test="${boardInfo.BOARD_ID == '004'}">
            <li>
                <dl class="vos-write">
                    <dt>구분</dt>
                    <dd>
                        <select id="contents_cls">
                        <c:forEach var="item" items="${CODELIST_ADM003}" varStatus="status">
                            <option value="${item.CODE}" <c:if test="${dataInfo.CONTENTS_CLS == item.CODE}">selected</c:if>>${item.CODE_NM}</option>
                        </c:forEach>
                        </select>
                    </dd>
                </dl>
            </li>
            <li>
                <dl class="vos-write">
                    <dt>게시여부</dt>
                    <dd>
                        <select id="status" name="status">
                            <option value="0" <c:if test="${dataInfo.STATUS == '0'}">selected</c:if>>임시저장</option>
                            <option value="1" <c:if test="${dataInfo.STATUS == '1'}">selected</c:if>>게시</option>
                        </select>
                    </dd>
                </dl>
            </li>
            </c:when>
            <c:otherwise>
            <li>
                <dl class="vos-write">
                    <dt>공지여부</dt>
                    <dd>
                        <select id="notice" name="notice">
                            <option value="0" <c:if test="${dataInfo.NOTICE == '0'}">selected</c:if>>일반</option>
                            <option value="1" <c:if test="${dataInfo.NOTICE == '1'}">selected</c:if>>공지</option>
                        </select>
                    </dd>
                </dl>
            </li>
            <li>
                <dl class="vos-write">
                    <dt>게시여부</dt>
                    <dd>
                        <select id="status" name="status">
                            <option value="0" <c:if test="${dataInfo.STATUS == '0'}">selected</c:if>>임시저장</option>
                            <option value="1" <c:if test="${dataInfo.STATUS == '1'}">selected</c:if>>게시</option>
                        </select>
                    </dd>
                </dl>
            </li>
            </c:otherwise>
        </c:choose>
            <li>
                <dl class="vos-write">
                    <dt>제목</dt>
                    <dd>
                        <input type="text" id="subject" name="subject" value="<c:out value="${dataInfo.SUBJECT }" />" class="wp100" maxlength="100">
                    </dd>
                </dl>
            </li>
            <li>
                <dl class="vos-write">
                    <dt>내용</dt>
                    <dd>
                        <textarea id="editor_area" name="editor_area" class="ckeditor" ></textarea>
                    </dd>
                </dl>
            </li>
            <li>
                <dl class="vos-write">
	                <dt>첨부파일</dt>
	                <dd>
	                    <div class="upload-area">
	                        <ul class="upload-list">
	                            <li>첨부 파일이 없습니다.</li>
	                        </ul>
	                    </div>
	                    <div class="upload-btn">
	                        <p>*업로드 가능한 파일은 (txt, xls, xlsx, doc…) 입니다.</p>
	                        
							<button type="button" class="btn" id="btnAttFile">파일추가</button>
	                    </div>
	                </dd>
                </dl>
            </li>
            
            <div class="b-btn-area t_center">
                <button type="button" id="btnSave" class="btn">저장</button>
                <button type="button" id="btnClose" class="btn">닫기</button>
            </div>               
        </ul>
	</div>
</div>