<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>

<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<!DOCTYPE html>
<html lang="ko">
<head>

<script type="text/javascript">

$(document).ready(function() {
	fnInit();

});

function fnInit() {
	
	textareaHeight($('.setHeight'));
	
	$("#btnReply").click(function(e){
		fnReply();
    });
	
	
	$(".mdiv").hide();
	$(".rdiv").hide();
	
}

var fnReply = function() {
	if(!fnValidator()) {
		return;
	}
	
	if(!confirm("댓글 등록하시겠습니까?")) {
		return;
	}
	
	
	var params = fnParams();
	params['comments'] = $("#comments").val();

	
	console.log(params);
	
	
	ajaxJsonCall("<c:url value='/com/mgt/insertReply.do'/>", params
			, function(result) {
				console.log(result);
				if(result.fields.resultCd == 'S') {
					alert("댓글 저장 완료 되었습니다.");
					fnPostGoto("<c:url value='/com/mgt/mgtBoardView.do'/>", params, "_self");
				} else {
					alert("댓글 저장 중 에러가 발생하였습니다.");
				}
			}
			, function(result) {
				console.log(result);
				alert("댓글 저장 중 에러가 발생하였습니다.");
			}
	);
	
};

function fnValidator() {
	var comments = $('#comments');
	if(comments.val() == '' || comments.val() == null) {
		alert('댓글을 입력하세요.');
		comments.focus();
		return false;
	}
	return true;
}

function fnValidatorMod(rseq) {
	var comments = $('#modifyComments_'+rseq);
	if(comments.val() == '' || comments.val() == null) {
		alert('수정할 댓글을 입력하세요.');
		comments.focus();
		return false;
	}
	return true;
}

function fnValidatorRe(rseq) {
	var comments = $('#rereplyComments_'+rseq);
	if(comments.val() == '' || comments.val() == null) {
		alert('댓글을 입력하세요.');
		comments.focus();
		return false;
	}
	return true;
}

function reReplyForm(seq, rseq) {
	$("#rereply_"+rseq).toggle("fast", function(){
		$("#rereplyComments_"+rseq).val("");
	});
}

function modifyForm(seq, rseq) {
	$("#modifyComments_"+rseq).val(reChangeContents($("#modifyComments_"+rseq).val()));
	$("#reply_"+rseq).toggle();
	$("#mreply_"+rseq).toggle();
	$("#rereply_"+rseq).hide("fast", function(){
		$("#rereplyComments_"+rseq).val("");
	});
}

function deleteReply(seq, rseq) {
	
	if(!confirm("댓글 삭제하시겠습니까?")) {
		return;
	}
	
	
	var params = fnParams();
	params['rseq'] = rseq;
	
	console.log(params);
	
	
	ajaxJsonCall("<c:url value='/com/mgt/deleteReply.do'/>", params
			, function(result) {
				console.log(result);
				if(result.fields.resultCd == 'S') {
					alert("댓글 삭제 완료 되었습니다.");
					fnPostGoto("<c:url value='/com/mgt/mgtBoardView.do'/>", params, "_self");
				} else {
					alert("댓글 삭제 중 에러가 발생하였습니다.");
				}
			}
			, function(result) {
				console.log(result);
				alert("댓글 삭제 중 에러가 발생하였습니다.");
			}
	);
}

function modifyReply(seq, rseq) {
	if(!fnValidatorMod(rseq)) {
		return;
	}
	
	if(!confirm("댓글 수정하시겠습니까?")) {
		return;
	}
	
	
	var params = fnParams();
	params['comments'] = $("#modifyComments_"+rseq).val();
	params['rseq'] = rseq;
	
	
	console.log(params);
	
	
	ajaxJsonCall("<c:url value='/com/mgt/modifyReply.do'/>", params
			, function(result) {
				console.log(result);
				if(result.fields.resultCd == 'S') {
					alert("댓글 수정 완료 되었습니다.");
					fnPostGoto("<c:url value='/com/mgt/mgtBoardView.do'/>", params, "_self");
				} else {
					alert("댓글 수정 중 에러가 발생하였습니다.");
				}
			}
			, function(result) {
				console.log(result);
				alert("댓글 수정 중 에러가 발생하였습니다.");
			}
	);
	
}

function writeRereply(seq, rseq) {
	if(!fnValidatorRe(rseq)) {
		return;
	}
	
	if(!confirm("댓글 등록하시겠습니까?")) {
		return;
	}
	
	
	var params = fnParams();
	params['comments'] = $("#rereplyComments_"+rseq).val();
	params['mother'] = rseq;
	
	console.log(params);
	
	
	ajaxJsonCall("<c:url value='/com/mgt/insertReply.do'/>", params
			, function(result) {
				console.log(result);
				if(result.fields.resultCd == 'S') {
					alert("댓글 저장 완료 되었습니다.");
					fnPostGoto("<c:url value='/com/mgt/mgtBoardView.do'/>", params, "_self");
				} else {
					alert("댓글 저장 중 에러가 발생하였습니다.");
				}
			}
			, function(result) {
				console.log(result);
				alert("댓글 저장 중 에러가 발생하였습니다.");
			}
	);
	
}

function textareaHeight(obj) {
	$(obj).each(function(index, value){
		$(this).css("height", $(this).prop('scrollHeight')+12+"px");
	});
}

function resize(obj) {
	obj.style.height = "1px";
	obj.style.height = (12+obj.scrollHeight)+"px";
}

</script>
<style type="text/css">

.replyBox {
	width: 100%;
	height: auto;
	overflow: hidden;
	padding-top: 10px;
}
.replyBox textarea {
	float: left;
	width: 90%;
	height: 50px;
}
.replyBoxBtn {
	float: right;
	width: 9%;
	height: 50px;
	line-height: 50px;
	margin-top: auto;
	margin-bottom: auto;
}

.replyList {
	padding-top: 10px;
}
.replyListNum {
	font-size: 12px;
	border-bottom: 1px solid #999;
	padding: 10px 0;
}
.replyListNum span {
	font-weight: bold;
	color: #e51937;
}

.replyView {
	padding-top: 5px;
}
.replyView dt {
	font-size: 13px;
	color: #828282;
	padding: 5px 0;
	position: relative;
}
.replyView dd {
	font-size: 20px;
	border-bottom: 1px solid #d6d6d6;
	padding: 15px 0 15px;
}
.replyBtnGroup {
	position: absolute;
	right: 0;
	top: 10px;
	cursor: pointer;
}

.changeColor:hover {
	color: #e51937;
}


</style>
</head>


<div class="popwrap">


	<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, PropertiesUtil.getProperty('ROLE_BBS')) == true}">
	<section class="replyBox">
		<textarea class="contents_font" id="comments" name="comments" placeholder="댓글을 입력 하실 수 있습니다." style="resize: vertical;" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
		<a href="#none" class="btnTop replyBoxBtn" id="btnReply">등록</a>
	</section><!-- //댓글쓰기 -->
	</c:if>
	
	
	<input type="hidden" id="mother" name="mother" value="0">
	<input type="hidden" id="parent" name="parent" value="${boardView.SEQ }"> <!-- 본문의 글번호 -->
	<input type="hidden" id="seq" name="seq" value="${boardView.SEQ }">

 
 
 	<%
	pageContext.setAttribute("CR", "\r");
	pageContext.setAttribute("LF", "\n");
	pageContext.setAttribute("CRLF", "\r\n");
	pageContext.setAttribute("SP", "&nbsp;");
	pageContext.setAttribute("BR", "<br/>");
	%>
 <section class="replyList">
    <p class="replyListNum">총 <span>${boardReply == '[]' ? 0 : boardReply.get(0).TOT_CNT }</span> 개</p>
    <dl class="replyView">
    	<c:forEach var="reply" items="${boardReply }">
      		<div id="reply_${reply.SEQ}" class="odiv">
        		<dt style="padding-left: <c:out value="${(reply.LEVEL-1)*10 }"/>px;">
        			<c:if test="${reply.LEVEL != 1}">└ &nbsp;</c:if>
        			${reply.REG_NM} | ${reply.DEPT_NM} | ${reply.REG_DT}
        			<div class="replyBtnGroup">
        				<c:if test="${reply.REG_ID == SESSION_INFO.USER_ID}">
        					<span class="replyBtn changeColor" id="updatebtn_${reply.SEQ}" onclick="modifyForm('${boardView.SEQ}','${reply.SEQ}')">수정</span>
	                        <span class="replyBtn changeColor" onclick="deleteReply('${boardView.SEQ}','${reply.SEQ}');">삭제</span>
        				</c:if>
        				<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, PropertiesUtil.getProperty('ROLE_BBS')) == true}">
	        				<c:if test="${reply.MOTHER == 0 }">
	        					<span class="replyBtn changeColor" onclick="reReplyForm('${boardView.SEQ}','${reply.SEQ}')">댓글</span>
	        				</c:if>
        				</c:if>
        			</div>
        		</dt>
        		<dd style="padding-left: <c:out value="${(reply.LEVEL-1)*30 }"/>px;" class="contents_font">
        			<c:set var="replyComments" value="${reply.COMMENTS }" />
        			<c:set var="replyComments" value="${fn:replace(replyComments,'<','&lt;')}" />
					<c:set var="replyComments" value="${fn:replace(replyComments,'>','&gt;')}" />
					<c:set var="replyComments" value="${fn:replace(replyComments,CRLF, BR)}" />
					<c:set var="replyComments" value="${fn:replace(replyComments,CR, BR)}" />
					<c:set var="replyComments" value="${fn:replace(replyComments,LF, BR)}" />
					<c:set var="replyComments" value="${fn:replace(replyComments,' ',SP)}" />
					<c:out value="${replyComments }" escapeXml="false" />
<%--         			<textarea id="comments_${reply.SEQ}" class="viewContents setHeight" readonly="readonly" style="font-size: 15px;"><c:out value='${reply.COMMENTS}'/></textarea> --%>
        		</dd>
       		</div>
       		<div id="mreply_${reply.SEQ}" class="mdiv">
        		<dt style="padding-left: <c:out value="${(reply.LEVEL-1)*10 }"/>px;">
        			<c:if test="${reply.LEVEL != 1}">└ &nbsp;</c:if>
        			${reply.REG_NM} | ${reply.DEPT_NM} | ${reply.REG_DT}
        			<div class="replyBtnGroup">
       					<span class="replyBtn changeColor" id="updatebtn_${list.seq}" onclick="modifyReply('${boardView.SEQ}','${reply.SEQ}')">저장</span>
                        <span class="replyBtn changeColor" onclick="modifyForm('${boardView.SEQ}','${reply.SEQ}');">취소</span>
        			</div>
        		</dt>
        		<dd style="padding-left: <c:out value="${(reply.LEVEL-1)*30 }"/>px;">
        			<textarea id="modifyComments_${reply.SEQ}" class="setHeight contents_font" style="resize: vertical;" onkeydown="resize(this)" onkeyup="resize(this)"><c:out value='${reply.COMMENTS}'/></textarea>
        		</dd>
       		</div>
       		<div id="rereply_${reply.SEQ}" class="rdiv">
        		<dt style="padding-left: <c:out value="${(reply.LEVEL-1)*10 }"/>px;">
        			▼
        			<div class="replyBtnGroup">
       					<span class="replyBtn changeColor" id="updatebtn_${list.seq}" onclick="writeRereply('${boardView.SEQ}','${reply.SEQ}')">저장</span>
                        <span class="replyBtn changeColor" onclick="reReplyForm('${boardView.SEQ}','${reply.SEQ}');">취소</span>
        			</div>
        		</dt>
        		<dd style="padding-left: <c:out value="${(reply.LEVEL-1)*30 }"/>px;">
        			<textarea class="contents_font" id="rereplyComments_${reply.SEQ}" rows="2" cols="100%" placeholder="댓글을 입력 하실 수 있습니다." style="width: 90%; resize: vertical;" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
        		</dd>
       		</div>
        </c:forEach>
    </dl>
</section>

</div>
