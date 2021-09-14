<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>


<script type="text/javascript">

$(document).ready(function() {
    var BOARD_ID = '${data.BOARD_ID}';
	changeBtn(BOARD_ID);
});


function changeTab(BOARD_ID) {
	$("#BOARD_ID").val(BOARD_ID);
	
	var params = fnGetParams();
	params['selectBox'] = '01';
	params['searchBox'] = '';
	
	fnPostGoto("<c:url value='/com/mgt/mgtBoardList.do'/>", params, "_self");
}

function changeBtn(BOARD_ID) {
	var btn = $("#bbs_"+BOARD_ID);
	btn.addClass("changeBtn");
}


function selectMode(){
	var selectMOde = '';
	selectMode = $("#mode option:selected").val();
	
	if(selectMode == 'innerBoard'){
		changeTab('001');  //내부게시판 공지사항
	}else{
		changeTab('101');  //BP게시판 공지사항
	}
}

function fnParams() {
	var params = fnGetParams();
	params['BOARD_ID'] = '${data.BOARD_ID}';
	params['userId'] = '${SESSION_INFO.USER_ID}';
	return params;
}

function fnSaveSuccess(result) {
	console.log(result);
}

function fnSaveFail(result) {
	console.log(result);
}

function changeContents(contents) {
	var con = contents.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
	con = con.replaceAll("\u0020", "&nbsp;").replaceAll("\n", "<br>");
	con = con.replaceAll(/\"/g, "&quot;").replaceAll(/\'/g, "&#39;");
	return con;
}

function reChangeContents(contents) {
	var con = contents.replaceAll("<br>", "\r\n");
	return con;
}

function fnCloseYn(closedYn, regUserId) {
	var deptAuth = '${SESSION_INFO.DEPT_ROLE}';
	var userId = '${SESSION_INFO.USER_ID}';
	var roleList = '${SESSION_INFO.ROLE_LIST}';
	
	if(closedYn == 'Y'){
		if(roleList.indexOf("${PropertiesUtil.getProperty('ROLE_BBS')}") != -1 || regUserId == userId) {
// 		if(deptAuth.indexOf("R100") != -1 || deptAuth.indexOf("R500") != -1 || regUserId == userId || deptAuth.indexOf("R111") != -1){
			return true;
		}else{
			alert("<spring:message code='board.invalid.access'/>");
			return false;
		}
	}else{
		return true;
	}
}

</script>

	<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, PropertiesUtil.getProperty('ROLE_PUR')) == true}">
	<div class="tab-selec">
		<select name="mode" id="mode" onchange="selectMode()" class="w130" style="height:32px;">
	        <option value="innerBoard" <c:if test="${data.mode == 'innerBoard'}">selected</c:if>>내부게시판</option>
	        <option value="outterBoard" <c:if test="${data.mode == 'outterBoard'}">selected</c:if>>BP게시판</option>
	    </select>
	</div>
	</c:if>
    
    <div class="tabs">
	    <ul>
	        <c:forEach items="${boardInfoAll }" var="board" varStatus="status">
	            <c:if test="${boardInfo.DISPLAY_SITE == board.DISPLAY_SITE }">
	                <c:choose>
                        <c:when test="${board.BOARD_ID == '201' }">
	                       <c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, PropertiesUtil.getProperty('ROLE_PUR')) == true}">
                                <li ${data.BOARD_ID==board.BOARD_ID?"class=ui-tabs-active":""}><a href="#none" onClick="javascript:changeTab('${board.BOARD_ID}')">${board.BOARD_NM}</a></li>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                                <li ${data.BOARD_ID==board.BOARD_ID?"class=ui-tabs-active":""}><a href="#none" onClick="javascript:changeTab('${board.BOARD_ID}')">${board.BOARD_NM}</a></li>
                        </c:otherwise>
                    </c:choose>
	            </c:if>
	        </c:forEach>
	    </ul>
    </div>
    <input type="hidden" name="BOARD_ID" id="BOARD_ID" value="">
		