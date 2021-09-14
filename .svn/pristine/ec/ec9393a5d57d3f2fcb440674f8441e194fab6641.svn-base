<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="authority.label.title"/></title>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="contTitle">
		<h1><spring:message code="authority.label.title"/></h1>
	</div>
	<div class="searchArea">
		<div>현재 권한: <sec:authorize access="isAnonymous()">익명</sec:authorize><sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.authorities" /></sec:authorize></div>
		<table class="tb_search">
			<colgroup>
				<col width="230" />
				<col width="160" />
				<col width="260" />
			</colgroup>
			<tr>
				<th><label for="schWord"><spring:message code="authority.label.adminPage"/></label></th>
				<td align="left"><a href="${ctx}/adminPage.do">링크</a></td>
				<td>
					<sec:authorize access="!hasAuthority('ROLE_ADMIN')">접근 불가</sec:authorize>
					<sec:authorize access="hasAuthority('ROLE_ADMIN')">ADMIN 접근 가능</sec:authorize>
				</td>
				
			</tr>
			<tr>
				<th><label for="schWord"><spring:message code="authority.label.userPage"/></label></th>
				<td align="left"><a href="${ctx}/userPage.do">링크</a></td>
				<td>
					<sec:authorize access="isAnonymous()">접근 불가</sec:authorize>
					<sec:authorize access="hasAuthority('ROLE_USER')">USER 접근 가능</sec:authorize>
				</td>
				
			</tr>
			<tr>
				<th><label for="schWord"><spring:message code="authority.label.anonyPage"/></label></th>
				<td align="left"><a href="${ctx}/anonymousPage.do?test=aaa">링크</a></td>
				<td>
					<sec:authorize access="isAnonymous()">접근 가능</sec:authorize>
					<sec:authorize access="isAuthenticated()">인증 사용자 접근 불가</sec:authorize>
				</td>
				
			</tr>				
		</table>
	</div>				
</body>
</html>