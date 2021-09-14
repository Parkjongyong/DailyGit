<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><tiles:insertAttribute name="title" /></title>
        <link href="<c:url value='/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mCustomScrollbar.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/plugin/jquery-multiselect/jquery.multiselect.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/plugin/poshytip-1.2/src/tip-yellow/tip-yellow.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/css/reset.css'/>" rel="stylesheet" />
        <link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet" />
        <link href="<c:url value='/resources/css/custom.css'/>" rel="stylesheet" />
        <link href="<c:url value='/resources/css/rgrid.css'/>" rel="stylesheet" />
        
        <!-- SCRIPT -->
        <tiles:insertAttribute name="script" />
        <c:set value="none" var="_serverType"/>
        <c:if test="${pageContext.request.serverName eq 'localhost' or pageContext.request.serverName eq '127.0.0.1' or pageContext.request.serverName eq '192.168.30.103'}">
        <c:set value="break" var="_serverType"/>
        </c:if>

        <!-- auth -->
        <tiles:insertAttribute name="authority" />
        <!-- // auth -->
    </head>
    <body>
        <tiles:insertAttribute name="body" /> 
    </body>
</html>