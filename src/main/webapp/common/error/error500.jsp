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
		<h2 class="color">ERROR</h2>
		<h3>시스템 안내</h3>
		<p>
		    정상 처리되지 않았습니다.<br>
            잠시 대기후 작업을 재 수행해보시기 바랍니다.<br>
            문제가 반복될 경우에는,<br> 
            시스템 관리자에게 연락바랍니다.<br>
		</p>
		<div class="error-btn">   
            <c:if test='${!empty LOGIN_INFO and !empty LOGIN_INFO.USER_ID}'>
                <a href="#none" onClick="goMainView();">홈으로 가기</a>
                <a href="javascript:history.back();" class="st2">이전페이지</a>
            </c:if>
        </div>
	</div>
</div>
</body>
</html>
