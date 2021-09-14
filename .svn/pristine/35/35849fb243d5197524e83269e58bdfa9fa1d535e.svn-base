<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>


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
	
	$("#btnModify").click(function(e){
		fnModify();
    });
	
	fnInitFileUpload();
}

var fnList = function() {
	var params = fnParams();
	fnPostGoto("<c:url value='/com/mgt/mgtBoardList.do'/>", params, "_self");
}

var fnModify = function() {
	if(fnValidator()){
		var params = fnParams();
		fnPostGoto("<c:url value='/com/mgt/mgtBoardModify.do'/>", params, "_self");
	}
}

function fnValidator() {
    var writer = "${boardView.USER_ID}";
    var currentUserId = "${SESSION_INFO.USER_ID}";
    if (writer !== currentUserId) {
        alert('타인의 게시물을 수정할 수 없습니다.'); return false;
    }else{
    	return true;
    }
}


function fnSaveSuccess(data) {
	fnList();
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

	
<textarea id="contents" name="contents" style="display:none;"></textarea>
<input type="hidden" id="hidOrgCont" name="hidOrgCont" value="<c:out value='${boardView.CONTENTS }'/>">
<input type="hidden" id="SEQ" name="SEQ" value="<c:out value='${boardView.SEQ }'/>">

<jsp:include page="/WEB-INF/jsp/com/mgt/mgtBoardHeader.jsp" flush="false" />
<br/>
<div class="cont-tit">
	<div class="right">
        <button type="button" id="btnList" class="btn st1">목록</button>
        <button type="button" id="btnModify" class="btn st1">수정</button>
    </div>
</div>

<table class="table-view">
    <colgroup>
        <col>
    </colgroup>
    <thead>
        <tr>
            <th>
                <h2 class="view-tit"><c:out value='${boardView.SUBJECT }'/></h2>
            </th>
        </tr>
        <tr>
            <td>
                <div class="view-info">
                <c:choose>
                    <c:when test="${boardInfo.BOARD_TYPE == 'FAQ'}">
                        <dl>
	                        <dt>구분</dt>
	                        <dd>
	                            <select id="contents_cls" disabled>
	                              <c:forEach var="item" items="${CODELIST_ADM002}" varStatus="status">
	                                  <option value="${item.CODE}" <c:if test="${boardView.CONTENTS_CLS == item.CODE}">selected</c:if>>${item.CODE_NM}</option>
	                              </c:forEach>
	                             </select>
	                        </dd>
	                    </dl>
	                    <dl>
	                        <dt>No</dt>
	                        <dd><c:out value="${boardView.SEQ}" /></dd>
	                    </dl>
	                    <dl>
	                        <dt>등록일</dt>
	                        <dd><c:out value="${boardView.INS_DT}" /></dd>
	                    </dl>
	                    <dl>
	                        <dt>수정일</dt>
	                        <dd><c:out value="${boardView.MOD_DT}" /></dd>
	                    </dl>
	                </c:when>
	                <c:otherwise><!-- 협력업체 FAQ -->
                        <dl>
                            <dt>공지여부</dt>
                            <dd>
	                            <select id="notice" name="notice" disabled>
	                                <option value="0" <c:if test="${boardView.NOTICE == '0'}">selected</c:if>>일반</option>
	                                <option value="1" <c:if test="${boardView.NOTICE == '1'}">selected</c:if>>공지</option>
	                            </select>
                            </dd>
                        </dl>
                        <dl>
	                        <dt>게시여부</dt>
	                        <dd>
	                            <select id="status" name="status" disabled>
	                                <option value="0" <c:if test="${boardView.STATUS == '0'}">selected</c:if>>임시저장</option>
	                                <option value="1" <c:if test="${boardView.STATUS == '1'}">selected</c:if>>게시</option>
	                            </select>
	                        </dd>
	                    </dl>
	                    <c:if test="${boardView.BOARD_ID == '201'}">
	                    <dl>
	                        <dt>익명여부</dt>
	                        <dd>
	                            <select id="closed_yn" name="closed_yn" disabled>
	                                <option value="Y" <c:if test="${boardView.CLOSED_YN == 'Y'}">selected</c:if>>익명</option>
	                                <option value="N" <c:if test="${boardView.CLOSED_YN == 'N'}">selected</c:if>>기명</option>
	                            </select>
	                        </dd>
	                    </dl>
                        </c:if>
                        <dl>
                            <dt>No</dt>
                            <dd><c:out value="${boardView.SEQ}" /></dd>
                        </dl>
                        <dl>
	                        <dt>작성일</dt>
	                        <dd><c:out value="${boardView.INS_DT}" /></dd>
	                    </dl>
	                    <c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, PropertiesUtil.getProperty('ROLE_BBS')) == true}">
                        <dl>
                            <dt>작성자</dt>
                            <dd><c:out value="${boardView.USER_NM}" /></dd>
                        </dl>
                        <dl>
                            <dt>작성자소속</dt>
                            <dd><c:out value="${boardView.DEPT_NM}" /></dd>
                        </dl>
	                    </c:if>
	                    <dl>
                            <dt>조회수</dt>
                            <dd><c:out value="${boardView.HIT_CNT}" /></dd>
                        </dl>
	                </c:otherwise>
	            </c:choose>
                </div>
            </td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <div id="editor_area"></div>
            </td>
        </tr>
    </tbody>
</table>
		


<c:if test="${boardInfo.BOARD_TYPE != 'FAQ' }">
    <div class="layoutArea">
    <input type="hidden" id="APP_SEQ" value="${boardView.ATTACHMENT }">
        <div class="sub_tit p_t20">
            <h3>첨부파일</h3>
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
        <div style="color: #999;">
        upload가능파일 (bmp,gif,jpg,jpeg,png,pdf,xls,xlsx,ppt,pptx,doc,docx,hwp,txt,pdf,zip,htx,mht)
        </div>
    </div>
</c:if>

<!-- c:if test="${boardInfo.BOARD_TYPE == 'QNA' }"-->
    <!-- jsp:include page="/WEB-INF/jsp/com/mgt/mgtBoardReply.jsp" flush="false" / -->
<!-- /c:if  -->
