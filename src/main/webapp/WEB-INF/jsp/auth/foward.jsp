<%@page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@page import="com.app.ildong.common.session.UserSessionUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%  	
	Map userInfo = null;

	try {
		userInfo = (Map)UserSessionUtil.getUserSession(request);
	} catch (Exception e) {
		String tLink = request.getContextPath() + "/common/error/noaccess.jsp" ;
		out.println("\t<script type=\"text/javascript\">window.location.href='"+tLink+"';</script>");	
	} 	
	
	if(userInfo == null){
		String tLink = request.getContextPath() + "/common/error/noaccess.jsp" ;
		//out.print("2222<br/>");
		out.println("\t<script type=\"text/javascript\">window.location.href='"+tLink+"';</script>");
	} else {
		Map lh = (HashMap)request.getAttribute("linkedHashMap");
		String tLink = (String)lh.get("FWD_URL");
		out.println("\t<script type=\"text/javascript\">window.location.href='"+tLink+"';</script>");
	}
%>
<style>
/* 페이지 로딩 */
.pageLoader { 
	position:fixed;
	top:0;
	left:0;
	width:100%;
	height:100%;
	background-image:url('<%=request.getContextPath()%>/resources/images/common/loader.gif');
	background-repeat:no-repeat;
	background-position:50%;
	background-color: rgba(255, 255, 255, 0.5);
	z-index:999;
}
</style>
<body>
<div class="pageLoader"></div>
</body>