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
$(document).ready(function() {
    init();
});

var init = function(){
	$(document).on("click", "#btnEdit", function(e){
		fnEdit();
    });
	
	$(document).on("click", "#btnDelete", function(e){
		fnDelete();
    });
}

function fnDetail(POST_SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":POST_SEQ});
    $.extend(params, {"page": $("#page").val()});
    
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    
    $.extend(params, {"srchGrp" : $("#srchGrp").val()});
    $.extend(params, {"srchTxt" : $("#srchTxt").val()});
    
    fnPostPopup("<c:url value='/com/mgt/mgtOutBoardDetail.do'/>", params, "_self");
}

function fnEdit() {
	var params = fnGetMakeParams();
    $.extend(params, {"SEQ":$("#SEQ").val()});
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    $.extend(params, {"page": $("#page").val()});
	
	fnPostGoto("<c:url value='/com/mgt/mgtOutBoardEditPop.do'/>", params, "_self");
}

var fnDelete = function(){
	var params = fnGetMakeParams();
    $.extend(params, {"SEQ":$("#SEQ").val()});
    $.extend(params, {"BOARD_ID":$("#BOARD_ID").val()});
    
    if (confirm("삭제하시겠습니까?")) {
         
    	ajaxJsonCall("<c:url value='/com/mgt/deleteBoard.do'/>",  params, function(data){
             alert("삭제 되었습니다.");
             
             if ($("#BOARD_ID").val() == "101" || $("#BOARD_ID").val() == "001" || $("#BOARD_ID").val() == "301"){
                 $(opener.location).attr("href","javascript:searchNotice();"); //공지사항
             }else if ($("#BOARD_ID").val() == "102" || $("#BOARD_ID").val() == "002" || $("#BOARD_ID").val() == "302"){
                 $(opener.location).attr("href","javascript:searchData();"); //자료실
             }else if ($("#BOARD_ID").val() == "103" || $("#BOARD_ID").val() == "004"){
                 $(opener.location).attr("href","javascript:searchFaq();"); //FAQ
             }else if ($("#BOARD_ID").val() == "104"){
                 $(opener.location).attr("href","javascript:searchPolicy();"); //jQuery 이용
             }else if ($("#BOARD_ID").val() == "303"){
                 $(opener.location).attr("href","javascript:searchNews();"); // 동반성장 News
             }

             window.opener="Self";
             window.open("","_parent","");
             window.close();
         });
     }
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
	            
	            <div class="b-btn-area t_right">
	            <c:if test="${(fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')) && SESSION_INFO.USER_ID == dataInfo.USER_ID }">
                    <a href="#none" class="bbtn s" id="btnEdit">수정</a>
                    
                    <c:if test="${BOARD_ID ne '304'}">
                    <a href="#none" class="bbtn s" id="btnDelete">삭제</a>
                    </c:if>
                </c:if>
	                <a href="javascript:self.close();" class="bbtn s">닫기</a>
	            </div>
	            
	            <ul class="view-paging">
	            <c:if test="${not empty subDataInfo.PRE_SEQ}">
	                <li>
	                   <span class="paging prev">이전글</span>
	                   <strong><a href="javascript:fnDetail(<c:out value='${subDataInfo.PRE_SEQ }' />)"><c:out value="${subDataInfo.PRE_SUBJECT }" /></a></strong>
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