<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>

<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"   %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s"       uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
.pop-cont { padding: 5px 30px; }
.tab-cont02 { margin-top:10px; }
</style>

<script type="text/javascript">
$(document).ready(function() {
    init();
});

var init = function(){
}

function goNotice(){
	var page = $("#page").val();
	
	if( isEmpty(page)) { page = 1;}
	
    var params = fnGetParams();
    $.extend(params, {"page" : page});
    
    $.extend(params, {"srchGrp" : $("#srchGrp").val()});
    $.extend(params, {"srchTxt" : $("#srchTxt").val()});
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    
    fnPostPopup("<c:url value='/com/mgt/mgtBoardListPopup.do'/>", params, "_self");
}

function fnDetail(POST_SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":POST_SEQ});
    $.extend(params, {"page": $("#page").val()});
    
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    
    $.extend(params, {"srchGrp" : $("#srchGrp").val()});
    $.extend(params, {"srchTxt" : $("#srchTxt").val()});
    
    fnPostPopup("<c:url value='/com/mgt/mgtBoardDetailPopup.do'/>", params, "_self");
}

</script>


<input type="hidden" id="page" name="page" value="<c:out value="${page }" />" />

<input type="hidden" id="srchGrp" name="srchGrp" value="<c:out value="${srchGrp }" />" />
<input type="hidden" id="srchTxt" name="srchTxt" value="<c:out value="${srchTxt }" />" />
<input type="hidden" id="BOARD_ID" name="BOARD_ID" value="<c:out value="${boardInfo.BOARD_ID }" />" />
<div class="pop-wrap" style="width:900px">
	<div class="pop-head">
	    <h2 id="headTitle"><c:out value="${boardInfo.BOARD_NM }" /></h2>
	</div>
	
	<div class="pop-cont">
	    <section id="tabList2-01" class="tab-cont02 active">
	        <div class="view-area">
	            <div class="view-tit">
	                <h4><c:out value="${noticeInfo.SUBJECT }" /></h4>
	                
	                <ul class="view-info">
	                    <li>No : <c:out value="${noticeInfo.SEQ }" /></li>
	                    <li>작성일 : <c:out value="${noticeInfo.INS_DT }" /></li>
	                    <li>조회수 : <c:out value="${noticeInfo.HIT_CNT }" /></li>
	                </ul>
	            </div>
	            
	            <div class="view-cont">
	                <div class="view-desc">
	                    <pre style="white-space: pre-wrap" readOnly="ReadOnly">${noticeInfo.CONTENTS }</pre>
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
	                <a href="javascript:goNotice();" class="bbtn s">목록</a>
	            </div>
	            
	            <ul class="view-paging">
	            <c:if test="${not empty subNoticeInfo.PRE_SEQ}">
	                <li>
		               <span class="paging prev">이전 글</span>
		               <strong><a href="javascript:fnDetail(<c:out value='${subNoticeInfo.PRE_SEQ }' />)"><c:out value="${subNoticeInfo.PRE_SUBJECT }" /></a></strong>
		               <span class="date"><c:out value="${subNoticeInfo.PRE_INS_DT }" /></span>
	                </li>
	            </c:if>
	                
	            <c:if test="${not empty subNoticeInfo.NEXT_SEQ}">
	                <li>
	                    <span class="paging next">다음 글</span>
	                    <strong><a href="javascript:fnDetail(<c:out value='${subNoticeInfo.NEXT_SEQ }' />)"><c:out value="${subNoticeInfo.NEXT_SUBJECT }" /></a></strong>
	                    <span class="date"><c:out value="${subNoticeInfo.NEXT_INS_DT }" /></span>
	                </li>
	            </c:if>
	            </ul>
	        </div>
	    </section><!--//공지사항 -->
	</div>
</div>