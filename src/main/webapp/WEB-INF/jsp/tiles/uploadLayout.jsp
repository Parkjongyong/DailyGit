<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML>
<!--
/*
 * jQuery File Upload Plugin jQuery UI Demo
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2013, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * https://opensource.org/licenses/MIT
 */
-->
<html lang="ko">
<head>
    <title>공통파일업로드</title>
    <meta charset="utf-8">
    <meta name="description" content="File Upload 공통">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Expires" content="-1">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Cache-Control" content="no-cache">
    <!-- jQuery UI styles -->
    <link rel="stylesheet" href="/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.css">
    <!-- Generic page styles -->
    <link rel="stylesheet" href="/resources/plugin/jQuery-File-Upload-master/css/style.css">
    <link href="<c:url value='/resources/css/custom.css'/>" rel="stylesheet"/>
    <link href="<c:url value='/resources/css/rgrid.css'/>" rel="stylesheet"/>
    <link href="<c:url value='/resources/css/reset.css'/>" rel="stylesheet"/>
    <link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet"/>
	<style>
	/* Adjust the jQuery UI widget font-size: */
	.ui-widget {
	    font-size: 0.95em;
	}
	</style>
	<!-- blueimp Gallery styles -->
	<link rel="stylesheet" href="/resources/css/blueimp-gallery.min.css">
	<!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
	<link rel="stylesheet" href="/resources/plugin/jQuery-File-Upload-master/css/jquery.fileupload.css">
	<link rel="stylesheet" href="/resources/plugin/jQuery-File-Upload-master/css/jquery.fileupload-ui.css">
	<!-- CSS adjustments for browsers with JavaScript disabled -->
	<noscript><link rel="stylesheet" href="/resources/plugin/jQuery-File-Upload-master/css/jquery.fileupload-noscript.css"></noscript>
	<noscript><link rel="stylesheet" href="/resources/plugin/jQuery-File-Upload-master/css/jquery.fileupload-ui-noscript.css"></noscript>
</head>
<body>
    <tiles:insertAttribute name="body" /> 
</body>
</html>

