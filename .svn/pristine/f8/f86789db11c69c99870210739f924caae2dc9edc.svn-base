<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.ecbank.framework.resourcebundle.code.CodeVO" %>
<%@ page import="com.ecbank.framework.resourcebundle.code.CodeSourceAccessor"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="board.title.list"/></title>
<script type="text/javascript">
function getBoardList(pageNo, rowPerPage) {
	var form = document.form;
	form.action = '<%=request.getContextPath()%>/board/getBoardList.do?pageNo=' + pageNo + '&rowPerPage=' + rowPerPage;		
	form.submit();
}
</script>
</head>
<body>
	<div class="contTitle">
		<h1><spring:message code="board.title.list"/></h1>
	</div>
	<div class="searchArea">
		<form id="form" name="form" action="/" method="POST">
			<table class="tb_search">
				<colgroup>
					<col width="130" />
					<col width="648" />
					<col width="160" />
				</colgroup>
				<tr>
					<th><label for="schWord"><spring:message code="board.label.condition"/></label></th>
					<td>
						<select id="schKind" name="schKind" class="Select">
							<%
								List<CodeVO> codeList = CodeSourceAccessor.getGroupCode("BIZ","C001");
								for(CodeVO codeVO : codeList){  %>
									<option value="<%=codeVO.getCodeId()%>"><%=codeVO.getCodeName()%></option>
							<% } %>
						</select>
						<input id="schWord" name="schWord" type="text" class="Textinput input01" value="${boardVO.schWord}"/>
					</td>
					<td class="searchBtn">
						<span class="button iconBtn">
							<button id="btnSearch" type="button" onclick="getBoardList(1, ${pager.rowPerPage});">
								<span class="button-icon ui-icon-search-reset"></span><span class="button-text"><spring:message code="board.btn.search"/></span>
							</button> 
						</span>
					</td>
				</tr>
			</table>
		</form>
	</div>				
	<div class="btn_common">
		<span class="button iconBtn">
			<a id="btnAdd" type="button" href="<%=request.getContextPath()%>/board/goBoardEdit.do">
				<span class="button-icon ui-icon-search-reset"></span><span class="button-text"><spring:message code="board.btn.add"/></span>			
			</a> 
		</span>
	</div>						
	<div class="tb_basic">
		<table id="board"  border="1" cellpadding="0" cellspacing="0" width="100%">
			<tr class="header">
				<th bgcolor="orange" width="10%"><spring:message code="board.label.seq"/></th>
				<th bgcolor="orange" width="40%"><spring:message code="board.label.title"/></th>
				<th bgcolor="orange" width="10%"><spring:message code="board.label.writer"/></th>
				<th bgcolor="orange" width="10%"><spring:message code="board.label.readCnt"/></th>
				<th bgcolor="orange" width="15%"><spring:message code="board.label.regDate"/></th>
				<th bgcolor="orange" width="15%"><spring:message code="board.label.dueDate"/></th>
			</tr>
			<c:choose>
				<c:when test="${empty boardList}">
					<tr><td colspan="6" align="center"><spring:message code="board.label.none"/></td></tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="board" items="${boardList}">
						<c:if test="${!board['seqNo']}">
						 	<tr>
								<td>${board.seqNo}</td>
								<td align="left"><a href="<%=request.getContextPath()%>/board/getBoardInfo.do?seqNo=${board.seqNo}">${board.title}</a></td>
								<td align="center">${board.writer}</td>
								<td>${board.readCnt}</td>
								<td align="center">${board.reqDate}</td>
								<td align="center">${board.dueDate}</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>		
		</table>
		<div class="pager" style="position: relative;">
			<div class="pager-left">
				<span><spring:message code="common.pager.total"/>: ${pager.totalCnt}</span>
			</div>
			<div class="pager-center">
				<c:forEach var="i" begin="1" end="${pager.endPageNo}">
				<ul class="pagination page-list">
					<li class="page-item page-button ${pager.pageNo == i ? 'current' : ''}">
						<a class="page-set" href="" onclick="getBoardList(${i}, ${pager.rowPerPage}); return false;">${i}</a>
					</li>
				</ul>
				</c:forEach>
			</div>
			<div class="pager-right">
				<select onchange="getBoardList(1,this.value);">
					<option value="5" ${pager.rowPerPage == '5' ? 'selected' : ''}>5</option>
					<option value="10" ${pager.rowPerPage == '10' ? 'selected' : ''}>10</option>
					<option value="30" ${pager.rowPerPage == '30' ? 'selected' : ''}>30</option>				
				</select>
			</div>
		</div>
	</div>
</body>
</html>