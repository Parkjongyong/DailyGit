<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="board.title.detail"/></title>
<script>
function modifyBoard() {
	var form = document.form;	 	
	form.action = '<%=request.getContextPath()%>/board/goBoardEdit.do';		
	form.submit();
}
function removeBoard() {
	if(window.confirm("삭제하시겠습니까?")) {
		var form = document.form;	 	
		form.action = '<%=request.getContextPath()%>/board/removeBoard.do';		
		form.submit();
	}
}
</script>
</head>
<body>
	<div class="contTitle">
		<h1><spring:message code="board.title.detail"/></h1>
	</div>
	<div class="btn_common">
		<span class="button iconBtn">
			<button id="btnModify" type="button" onclick="modifyBoard();">
				<span class="button-icon ui-icon-func-save"></span><span class="button-text"><spring:message code="board.btn.modify"/></span>
			</button> 
		</span>
		<span class="button iconBtn">
			<button id="btnRemove" type="button" onclick="removeBoard();">
				<span class="button-icon ui-icon-func-delete"></span><span class="button-text"><spring:message code="board.btn.remove"/></span>
			</button> 
		</span> 
		<span class="button iconBtn">
			<a id="btnList" type="button" href="<%=request.getContextPath()%>/board/">
				<span class="button-icon ui-icon-func-cancelRequest"></span><span class="button-text"><spring:message code="board.btn.list"/></span>
			</a>
		</span>
	</div>
	<div class="tb_data">
		<form id="form" name="form" action="/" method="POST">
			<table>
				<colgroup>
					<col width="75" />
					<col width="420" />
					<col width="75" />
					<col width="420" />
				</colgroup>
				<tr>
					<th><label><spring:message code="board.label.seq"/></label></th>
					<td><span>${boardInfo.seqNo}</span></td>
					<td colspan="2"><input id="seqNo" name="seqNo" value="${boardInfo.seqNo}" type="hidden"/></td>
				</tr>
				<tr>
					<th><label><spring:message code="board.label.writer"/></label></th>
					<td><span>${boardInfo.writer}</span></td>
					<th><label><spring:message code="board.label.readCnt"/></label></th>
					<td><span>${boardInfo.readCnt}</span></td>
				</tr>
				<tr>
					<th><label><spring:message code="board.label.regDate"/></label></th>
					<td><span>${boardInfo.reqDate}</span></td>
					<th><label><spring:message code="board.label.dueDate"/></label></th>
					<td><span>${boardInfo.dueDate}</span></td>
				</tr>				
				<tr>
					<th><label for="title"><spring:message code="board.label.title"/></label></th>
					<td colspan="3"><span>${boardInfo.title}</span></td>
				</tr>
				<tr>
					<th><label for="content"><spring:message code="board.label.content"/></label></th>
					<td colspan="3"><span>${boardInfo.content}</span></td>
				</tr>						
			</table>
		</form>
	</div>		
</body>
</html>