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

$(document).ready(function() {
    init();
    CKEDITOR.instances.editor_area.setData($("#hidOrgCont").val());
});

var init = function(){
	
    fnInitFileUpload();
    
    //파일첨부 추가 이벤트 등록
    $("#btnAttFile").click(function(e){
        var fileParams = {
             KEY_ID: 'APP_SEQ' // required 연관 파일 키
            ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
        };
        openFileUplaod(fileParams);
    });
    
    fnDx5View();
    
    $(document).on("click", "#btnSave", function(e){
        fnSave();
    });
    
    dext_editor_loaded_event();
}

//첨부파일멀티용 시작
var fnInitFileUpload = function() {
    if ($("#APP_SEQ").val() != "") 
        displayFileUpload({
            KEY_ID      : 'APP_SEQ',
            DATA_FORMAT : 'outTable',
            CALLBACK    : 'fnFileUploadCallback'
        });
};

var fnFileUploadCallback = function(data) {
    $('.upload-list').empty().html(data);
};

var fnSave = function(){
	if (fnValidate() ) {
	    if(confirm("저장 하시겠습니까?")){
	    	
	    	if ($("#BOARD_ID").val() == "103" || $("#BOARD_ID").val() == "004"){
	    		$("#contents").val(CKEDITOR.instances.editor_area.getData().replace(/(<([^>]+)>)/ig,""));
	    	}else{
	    		$("#contents").val(CKEDITOR.instances.editor_area.getData());
	    	}
	        
	        var params = {};
	        $.extend(params, fnGetParams());
	        
	        ajaxJsonCall("<c:url value='/com/mgt/modifyBoard.do'/>",  params, function(result) {
                console.log(result);
                if(result.fields.resultCd == 'S') {
                    alert("저장 되었습니다.");
                    
                    if ($("#BOARD_ID").val() == "101" || $("#BOARD_ID").val() == "001" || $("#BOARD_ID").val() == "301"){
                        $(opener.location).attr("href","javascript:searchNotice('<c:out value="${page }"/>');"); //공지사항
                    }else if ($("#BOARD_ID").val() == "102" || $("#BOARD_ID").val() == "002" || $("#BOARD_ID").val() == "302"){
                        $(opener.location).attr("href","javascript:searchData('<c:out value="${page }"/>');"); //자료실
                    }else if ($("#BOARD_ID").val() == "103" || $("#BOARD_ID").val() == "004"){
                        $(opener.location).attr("href","javascript:searchFaq('<c:out value="${page }"/>');"); //FAQ
                    }else if ($("#BOARD_ID").val() == "104"){
                        $(opener.location).attr("href","javascript:searchPolicy('<c:out value="${page }"/>');"); //jQuery 이용
                    }else if ($("#BOARD_ID").val() == "303"){
                        $(opener.location).attr("href","javascript:searchNews('<c:out value="${page }"/>');"); // 동반성장 News
                    }

                    window.opener="Self";
                    window.open("","_parent","");
                    window.close();
                } else {
                    alert("저장에 실패 하였습니다.");
                }
            }
            , function(result) {
                console.log(result);
                alert("저장에 실패 하였습니다.");
            });
	    }
	}
}

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
	    <a href="javascript:self.close();" class="close" title="닫기">닫기</a>
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
	                        
	                        <div class="f_right">
	                            <a href="#none" id="btnAttFile" class="bbtn s ico1">파일추가</a>
	                        </div>
	                    </div>
	                </dd>
                </dl>
            </li>
            
            <div class="b-btn-area">
                <a href="#none" class="bbtn" id="btnSave">저장</a>
                <a href="javascript:self.close();" class="bbtn">닫기</a>
            </div>
        </ul>
	</div>
</div>