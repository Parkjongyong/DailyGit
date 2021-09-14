<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
    request.setAttribute("smUserIps", smUserIps); 
%>
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

<script type="text/javascript">
function goLoginView(){
	
	if(opener) {
	    //팝업인 경우
		window.open('','_self').close();
	}
	
    document.location.href = "<c:url value='/loginView.do'/>";
    opener.location.href = "<c:url value='/loginView.do'/>";
}
</script>
</head>
<body class="error-body">
<div class="error-wrap">
	<div class="error-cont">
		<h2 class="color">WARNING</h2>
		<h3>로그인정보가 없습니다.</h3>
		<p>
			본 작업을 수행하기 위해서는 로그인이 필요합니다.<br>
			로그인 후 작업을 재 수행해보시기 바랍니다.<br>
			문제가 반복될 경우에는, <br>
			브라우져를 모두 닫았다가 다시 시도해보시기 바랍니다. <br>
		</p>
		<c:if test='${pageContext.request.remoteHost eq "127.0.0.1" or fn:contains(smUserIps, pageContext.request.remoteHost)}'>
		    <c:if test='${empty LOGIN_INFO and empty LOGIN_INFO.USER_ID}'>
            <div class="error-btn">           
	            <a href="#none" onclick="goLoginView();">로그인하기</a>
	        </div>
	        </c:if>
	    </c:if>
	</div>
</div>
</body>
</html>
