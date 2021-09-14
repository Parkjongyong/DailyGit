<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<%
    String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
    String remoteIp = request.getRemoteHost();
    
    if(PropertiesUtil.isRealMode()){
        if(smUserIps.contains(remoteIp)){
            response.sendRedirect("/main.do");
        }
    }else{
        response.sendRedirect("/main.do");
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
   <dl>
    <dt>현재 신규 시스템 오픈 전환 작업중입니다.</dt>
    <dd>2019 11월 13일  18시00분 ~ 2019년 11월 14일 08시30분 까지)</dd>
    <dd>2019년 11월 14일(목) 08시30분 오픈 예정입니다.</dd>       
   </dl>
</body>
</html>