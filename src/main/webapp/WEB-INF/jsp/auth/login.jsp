<%@page import="org.apache.commons.lang.time.DateFormatUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>로그인</title>
</head>
<c:url value="/login" var="loginUrl"/>
<form action="${pageContext.request.contextPath}/auth/j_spring_security_check.do" method="post">       
    <p>
        <label for="username">Username</label>
        <input type="text" id="userid" name="userid"/>	
    </p>
    <p>
        <label for="password">Password</label>
        <input type="password" id="password" name="password"/>	
    </p>
    <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
    <button type="submit" class="btn">Log in</button>(admin/admin or user/user)
</form>
