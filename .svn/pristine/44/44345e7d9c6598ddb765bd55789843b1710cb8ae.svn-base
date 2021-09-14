<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<h1 class="logo" onclick="javascript:goMain();return false;">
   	<a href="#none">일동전사시스템</a>
</h1>		
<ul class="top-menu">
	<c:if test="${LOGIN_INFO.USER_CLS eq 'B'}">
		<li><a href="#none" class="user" onclick="changePw();"><strong>${LOGIN_INFO.USER_NM} 님</strong><span>(${LOGIN_INFO.DEPT_NM})</span></a></li>
	</c:if>
	<c:if test="${LOGIN_INFO.USER_CLS eq 'S'}">
		<li><a href="#none" class="user" onclick="changePw();"><strong>${LOGIN_INFO.VENDOR_NM} 님</strong></a></li>
	</c:if>	
	<li><a href="#none" class="loginout" onclick="goLogout();return false;">LOGOUT</a></li>
</ul>
<ul class="gnb">
    <c:forEach var="topMenu" items="${LOGIN_INFO.TOP_MENU_MAP}">
		<c:if test="${topMenu.value.DISPLAY_YN eq 'Y'}">
			<li>
    			<a href="#none" onclick="goLeftMenu('${topMenu.value.MENU_CD}','${topMenu.value.MENU_NM}');return false;"><c:out value="${topMenu.value.MENU_NM}" /></a>
			</li>
		</c:if>
	</c:forEach>
</ul>		  

<!-- //header -->
<script language="javascript">

function goLeftMenu(menuCd, menuNm) {
	lnbMenuClick(menuCd, menuNm, null);
}

function goMain(){
    document.location.href = "${pageContext.request.contextPath}/main.do";
}

function goMenu(topMenuCd, topMenuNm, upMenuCd, menuCd) {
	//DEFAULT
	document.location.href = "${pageContext.request.contextPath }/goMenu.do?G_TOP_MENU_CD=" + encodeURI(topMenuCd) + "&G_TOP_MENU_NM=" + encodeURI(topMenuNm) + "&G_UP_MENU_CD=" + encodeURI(upMenuCd) + "&G_MENU_CD=" + encodeURI(menuCd);
}

function goLogout(){
    document.location.href = "${pageContext.request.contextPath}/logout.do";
}

function changePw(){
	var params = {};
    //권한관련 파라미터 추가 - 팝업권한
    params['G_TOP_MENU_CD'] = "IAD100"; 
    params['G_MENU_CD']     = "IAD240";
	
	var target    = "sysPwChangePopup";
	var width     = "600";
	var height    = "180";
	var scrollbar = "yes";
	var resizable = "yes";
	
	fnPostPopup('/com/sys/sysPwChange', params, target, width, height, scrollbar, resizable);

}
</script>