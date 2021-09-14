<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>
<%--
과서 ePro 출력팝업 화면용 
 --%>
<%
response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="Cache-Control" content="no-cache; no-store; no-save">
        <title><tiles:insertAttribute name="title" /></title>
        <link href="<c:url value='/resources/css/eproPop.css'/>" rel="stylesheet" />
    </head>
    <body bgcolor="#ededed">
        <tiles:insertAttribute name="body" />
    </body>
</html>