<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<%
	response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	
    String smUserIps = PropertiesUtil.getProperty("sm.user.ip");
    String remoteIp = request.getRemoteHost();
%>    

<script type="text/javascript">

$(document).ready(function(){
  init();
    
  <c:if test ="${not empty message}">
  alert('${message}');
  location.href="${pageContext.request.contextPath}/loginView.do";
  </c:if>
  
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
    
    $("#loginFrm").submit();
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

    <form name="loginFrm" id="loginFrm" action="<c:url value='/login.do'/>" method="post">
    <input type="hidden" id="COMP_CD" name="COMP_CD" value=""/> 
    
    <div class="loginArea">
        <div class="inputAreas">
            <input type="text" id="USER_ID" name="USER_ID" placeholder="아이디" class="wp80 enterEvnt" />
            <input type="password" id="USER_PWD" name="USER_PWD" placeholder="비밀번호"  class="wp80 m_t10 enterEvnt"/>
            
            <button type="button" id="btnLogin" class="btn st1">로그인</button>
        </div>
    </div>

    </form>
 <c:if test="${_serverType ne 'none'}">
       <div>
       <br/>
           <button type="button" class="btn" onClick="javascript:setUser('sysadmin','1111');">관리자유저(sysadmin)</button>&nbsp;
           <button type="button" class="btn" onClick="javascript:setUser('251514','1111');">구매1팀유저(원자재)</button>&nbsp;
           <button type="button" class="btn" onClick="javascript:setUser('252041','1111');">구매2팀유저(장비시설)</button>&nbsp;
           <button type="button" class="btn" onClick="javascript:setUser('254019','1111');">구매요청현업(LS장비기술팀)</button>&nbsp;
           <button type="button" class="btn" onClick="javascript:setUser('254593','1111');">전략구매담당자</button>&nbsp;
           <button type="button" class="btn" onClick="javascript:setUser('252557','1111');">품질담당자</button>&nbsp;
       </div>
   </c:if>
<%
// if(smUserIps.contains(remoteIp)){
%>    
<%--        <c:if test="${_serverType ne 'none'}"> --%>
<!--         <div> -->
<!--         <br/> -->
<!--             <button type="button" class="btn" onClick="javascript:setUser('sysadmin','1111');">관리자유저(sysadmin)</button>&nbsp; -->
<!--             <button type="button" class="btn" onClick="javascript:setUser('251514','1111');">구매1팀유저(원자재)</button>&nbsp; -->
<!--             <button type="button" class="btn" onClick="javascript:setUser('252041','1111');">구매2팀유저(장비시설)</button>&nbsp; -->
<!--             <button type="button" class="btn" onClick="javascript:setUser('254019','1111');">구매요청현업(LS장비기술팀)</button>&nbsp; -->
<!--             <button type="button" class="btn" onClick="javascript:setUser('254593','1111');">전략구매담당자</button>&nbsp; -->
<!--             <button type="button" class="btn" onClick="javascript:setUser('252557','1111');">품질담당자</button>&nbsp; -->
<!--         </div> -->
<%--     </c:if> --%>
<%
// }
%>
    

