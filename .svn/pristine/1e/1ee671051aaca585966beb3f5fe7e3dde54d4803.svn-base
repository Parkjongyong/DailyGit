<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map"%>
<%@ page import="sun.misc.BASE64Encoder"%>
<%!
public String getQueryStringForGetNPost(HttpServletRequest request) {
	StringBuilder sb = new StringBuilder();
	if( "GET".equals( request.getMethod()) ) {
	    sb.append(request.getQueryString());
	} else {
		Map<String, String[]> params = request.getParameterMap();
		int pos = 0;
		for (String key : params.keySet()) {
			String[] values = params.get(key);
			for (int i = 0; i <values.length; i++) {
				String value = values[i];
				if( pos > 0 ) {
				    sb.append("&");
				}
				sb.append(key).append("=").append(value);
				pos++;
			}
		}
	}

	return sb.toString();
}
%>

<%
	final String tnetAuthCookieName = "SM_USER";

	boolean tnetAuthCookie = false;
	javax.servlet.http.Cookie[] cookies = null;

	String userId = "";
	
	Map userInfo = null;
	
	try {
// 		userInfo = (Map)UserSessionUtil.getUserSession(request);
	} catch (Exception e) {
	//	out.print("NO SESSION");
	} 	
	
	if(userInfo == null){
		
		 cookies = request.getCookies();
         if (cookies != null) {
            for(int i=0, cookiesLength = cookies.length; i< cookiesLength; i++) {
	   
	   if (tnetAuthCookieName.equals(cookies[i].getName()) == true) {
			tnetAuthCookie = true;
			userId = cookies[i].getValue();
			//out.print("==>" + userId + "<br/>");
		    break;
	   }
		    }
         }
         
	     if (tnetAuthCookie == true) {
	        //t-net 로그인을 하면 SM_USER 쿠키값이 로컬피시에 생성이된다 
	        //타 사이트에서 다시 돌아 오면 쿠키값이 없어지므로 i-supply.co.kr 으로 다시 쿠키값을 심어서 사용한다. 
	        //읽은 쿠키값을다시 설정한다.
	 	
          	String fwrdUrl = request.getAttribute("fwrdUrl")==null?"":request.getAttribute("fwrdUrl").toString();
          	String queryString = getQueryStringForGetNPost(request);
          	
        	if(null == fwrdUrl|| "null".equals(fwrdUrl) || "".equals(fwrdUrl)){	        		
        		fwrdUrl = "main.do";
         	
        	}
     		
         	queryString = "fwrdUrl=" + fwrdUrl+ "?" + queryString;
         	String returnURL = java.net.URLEncoder.encode(queryString);

         	
         	String tLink = request.getContextPath()+"/login.do?COMP_CD=1000&USER_ID="+userId+"&FWD_TYPE=CKATO&FWD_URL="+returnURL;
         	       	
           	
	//혹시라도 무한 반복이 되면안되니 로직을 걸어 둔다.
	//if(reURL.equals("")){ 
		//out.println(tLink);
		out.println("\t<script type=\"text/javascript\">window.location.href='"+tLink+"';</script>");					
	//}
	
	     }else{
	    	 // redirect login page
	if (com.app.ildong.common.util.PropertiesUtil.isRealMode()) {
	    //out.println("\t<script type=\"text/javascript\">document.location=\"http://i-supply.com/login.asp\";</script>");
	    out.println("\t<script type=\"text/javascript\">document.location=\"http://i-supply.co.kr\";</script>");
	    return;
	} else { 
		out.println("\t<script type=\"text/javascript\">document.location=\""+request.getContextPath()+"/loginView.do\";</script>");
	         	return;
	}
	     }
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