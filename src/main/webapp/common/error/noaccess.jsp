<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!doctype html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><spring:message code='site.title'/></title>
<!-- CSS -->
<link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
<script src="<c:url value='/resources/js/jquery-3.2.1.min.js'/>"></script>
<style type="text/css">
/* 링크에서 밑줄 없애기 */
a { text-decoration:none; }
</style>
</head>
<script type="text/javascript">
function goMainView(){
    document.location.href = "<c:url value='/main.do'/>";
}
</script>
<body class="error-body">
<div class="error-wrap">
	<div class="error-cont">
		<h2 class="color">WARNING</h2>
		<p>
                     관리자에게 연락바랍니다.<br>
		</p>
		<div class="error-btn">   
                <a href="#none" onClick="goMainView();">홈으로 가기</a>
        </div>
	</div>
</div>
</body>
</html>
