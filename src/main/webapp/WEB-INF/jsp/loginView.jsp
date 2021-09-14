<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>
<%@ page import="com.app.ildong.common.util.StringUtil" %>

<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
    String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
    String remoteIp = request.getRemoteHost();
    String linkParam1 = "";
    String linkParam2 = "";
    if (!"".equals(StringUtil.isNullToString(request.getParameter("LINK_PARAM1")).trim())) {
    	linkParam1 = request.getParameter("LINK_PARAM1");
    }
    
//     if (!"".equals(StringUtil.isNullToString(request.getParameter("LINK_PARAM2")).trim())) {
//     	linkParam2 = request.getParameter("LINK_PARAM2");
//     }    
    
%>    

<script type="text/javascript">

var linkParam1 = '<%=linkParam1 %>';
//var linkParam2 = '<%=linkParam2 %>';
$(document).ready(function(){
    init();
    
	<c:if test ="${not empty message}">
		alert('${message}');
		linkParam1 = "";
		//linkParam2 = "";
  		location.href="${pageContext.request.contextPath}/loginView.do";
  	</c:if>
  	
//   	if (isNotEmpty(linkParam1) && isNotEmpty(linkParam2)) {
//   		loginProcess2();
//   	}

  	if (isNotEmpty(linkParam1)) {
  		loginProcess2();
  	}
  
});

function init() {
    $("#USER_ID").focus();
    
    $("#btnLogin").click(function(e) {
        loginProcess();
    });
    
    $(".enterEvnt").keyup(function(e) { //입력창 Enter 이벤트
        if (e.keyCode == 13) {
        	loginProcess();
        }
    });
}

function loginProcess(){
    
    var userId = $("#USER_ID").val();
    var userPwd = $("#USER_PWD").val();
     
    userId = userId.replace(/\ /g,'');
    userPwd = userPwd.replace(/\ /g,'');

    if(userId == ""){
        alert("아이디를 입력하세요.");
        $("#USER_ID").focus();
        return false;
    }
    
    if(userPwd == ""){
        alert("비밀번호를 입력하세요.");
        $("#USER_PWD").focus();
        return false;
    }
    
    
    var f = document.createElement('form');
    var obj, value;
    obj = document.createElement('input');
    obj.setAttribute('type', 'hidden');
    obj.setAttribute('name', "USER_ID");
    obj.setAttribute('value', userId);
    f.appendChild(obj);
    obj = document.createElement('input');
    obj.setAttribute('type', 'hidden');
    obj.setAttribute('name', "USER_PWD");
    obj.setAttribute('value', userPwd); 
    f.appendChild(obj);
    obj = document.createElement('input');
    obj.setAttribute('type', 'hidden');
    obj.setAttribute('name', "USER_CLS");
    obj.setAttribute('value', 'B'); 
    f.appendChild(obj);

    f.setAttribute('method', 'post');
    f.setAttribute('action', '/login.do');
    document.body.appendChild(f);
    f.submit();    
    
}


function loginProcess2(){
    
    var f = document.createElement('form');
    var obj, value;
    obj = document.createElement('input');
    obj.setAttribute('type', 'hidden');
    obj.setAttribute('name', "LINK_PARAM1");
    obj.setAttribute('value', linkParam1);
    f.appendChild(obj);
//     obj = document.createElement('input');
//     obj.setAttribute('type', 'hidden');
//     obj.setAttribute('name', "LINK_PARAM2");
//     obj.setAttribute('value', linkParam2);
//     f.appendChild(obj);    

    f.setAttribute('method', 'post');
    f.setAttribute('action', '/login.do');
    document.body.appendChild(f);
    f.submit();    
    
}

function setUser(id,pwd) {
    $("#USER_ID").val(id);
    $("#USER_PWD").val(pwd);
    loginProcess();
}



function fnParams() {
	var params = fnGetParams();
	

	return params;
}


</script>
<h1 class="login-logo"></h1>
<section class="loginAreaWrap">
	<div class="loginBox">
		<h2><img src="<c:url value='/resources/images/login/logo_s.png'/>" alt="일동 전사시스템"></h2>
		<p><strong>전사시스템</strong>에 오신것을 환영합니다.</p>
		
		<ul class="log">
			<li><input id="USER_ID" type="text" placeholder="ID" ></li>
			<li><input id="USER_PWD" type="password" placeholder="Password" onkeypress="javascript:if(event.keyCode==13){loginProcess()}" ></li>
		</ul>
					
		<button id="btnLogin">LOGIN</button>
		<p class="copy">COPYRIGHT ⓒ ILDONG PHARMACEUTICAL CO.,LTD. ALL RIGHTS RESERVED.</p>
	</div><!-- //loginArea -->
</section><!-- //loginAreaWrap -->
