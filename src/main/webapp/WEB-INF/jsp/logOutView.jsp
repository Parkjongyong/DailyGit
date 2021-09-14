<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%

response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8" charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Expires" content="-1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<title>${_siteTitle}</title>
<script>
	location.replace("logOutView.jsp");
	// 내부사용자 도메인으로 처리해야함!
	var internalUser = "${USER_CLS}"; 
	if(internalUser == "B") {
		location.href="${pageContext.request.contextPath}/loginView.do";
	} else {
		location.href="${pageContext.request.contextPath}/loginViewExternal.do";
	}
</script>
<body>
LOGOUT....
</body>
</html>