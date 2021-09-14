<%@ page pageEncoding="UTF-8" %>
<%@ page trimDirectiveWhitespaces= "true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<form id="_MENU_FROM_" name="_MENU_FROM_" >
		<input type="hidden" id="G_TOP_MENU_CD" name="G_TOP_MENU_CD" value="<c:out value="${param.G_TOP_MENU_CD}" />" >
		<input type="hidden" id="G_MENU_CD" name="G_MENU_CD" value="<c:out value="${param.G_MENU_CD}" />" >
	</form>
</div>
<%
    java.util.Map SESSION_INFO = com.app.ildong.common.session.UserSessionUtil.getUserSession(request);
    request.setAttribute("SESSION_INFO", SESSION_INFO); 
 %>
<c:set var="G_AUTH_SAVE" value="${LOGIN_INFO.MENU_MAP[ param.G_MENU_CD ].AUTH_SAVE}" scope="request"/>
<c:set var="G_MENU_NM" value="${LOGIN_INFO.MENU_MAP[ param.G_MENU_CD ].MENU_NM}" scope="request"/>