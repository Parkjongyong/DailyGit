<%--
    Class Name sysPwChangePopup.jsp
    Description: 패스워드 변경
    Modification Information
        수정일                  수정자      수정내용
    ---------  ------ ---------------------------
    2020.06.22  박종용     최초 생성
    author: 박종용
    since: 2020.06.22
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s"  uri="http://www.springframework.org/tags"%>
<style>
html {overflow:hidden;}
</style>
<script language="javascript">

$(document).ready(function() {
	init();
	if(isEmpty('${LOGIN_INFO.PWD_MOD_DATE}') == true){
		$('#ment').text("※ 최초 로그인 시 비밀번호를 변경해야 합니다.");
	} else if('${LOGIN_INFO.PWD_MOD_DATE}' > 90) {
		$('#ment').text("※ 90일동안 비밀번호를 변경하지 않으셨습니다. 비밀번호를 변경해야 합니다.");
	} else {
		$('#ment').text("※ 비밀번호 변경");
	}
});

//초기화함수
function init() {
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
}

function fnChange() {
    // 버튼 클릭 이벤트 생성
    if(isEmpty($('#BEFORE_PW').val()) == true){
    	alert("현재 비밀번호를 입력해주세요.");
    	return false;
    } 
    if(isEmpty($('#AFTER_PW').val()) == true){
    	alert("변경할 비밀번호를 입력해주세요.");
    	return false;
    } 
    if(isEmpty($("#CONFIRM_PW").val()) == true){
    	alert("비밀번호 확인란을 입력해주세요.");
    	return false;
    }
    
    if($('#AFTER_PW').val() != $('#CONFIRM_PW').val()){
    	alert("변경할 비밀번호가 일치하지 않습니다.");
    	$('#AFTER_PW').focus();
    	return false;
    }
    
    if(chkPwValidate('USER_ID', 'AFTER_PW') == true){
        var params = fnGetParams();
        $.extend(params, {'USER_ID' : '${LOGIN_INFO.USER_ID}'});
        ajaxJsonCall('<c:url value="/com/sys/savePw.do"/>',  params, fnSuccess);
    }
}

function fnSuccess(data) {
    if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
        alert(data.errMsg);
        return;
    } else {
    	alert("정상적으로 변경 되었습니다.");
    	window.close();
    }
}

</script>
<p id="ment" style="font-family:'맑은고딕', 'Malgun Gothic','돋움', 'Dotum', sans-serif; font-size:12px; color:#999; margin-bottom: 5px; margin-top: 5px; margin-left: 3px;"></p>
        <table class="tbl-view">
            <colgroup>
                <col style="width:15%">
                <col style="width:75%">
            </colgroup>
            <tbody>
                <tr>
                    <th>현재 비밀번호</th>
                    <td>
                        <input type="password" class="wp100" id="BEFORE_PW">
                        <input type="hidden" id="USER_ID" value="${LOGIN_INFO.USER_ID}">
                    </td>
                </tr>
                <tr>
                    <th>변경할 비밀번호</th>
                    <td>
                        <input type="password" class="wp100" id="AFTER_PW">
                    </td>
                </tr>
                <tr>
                    <th>비밀번호 확인</th>
                    <td>
                        <input type="password" class="wp100" id="CONFIRM_PW">
                    </td>
                </tr>
            </tbody>
        </table>                    
<div align="center">
    <button type="button" class="btn" id="btnChange" style="margin-top: 5px;">변경</button>
</div>
