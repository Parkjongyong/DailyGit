<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="f" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<style type="text/css">
.pop-cont { padding: 5px 30px; }
.view-tit { padding-bottom: 0px; border-bottom: 1px solid #2f2f2f; }
</style>
<script type="text/javascript">

$(document).ready(function() {
	fnInitStatus();
});

function fnInitStatus() {
	
	textareaHeight($('#CONTENTS'));
	
	$("#popDay").click(function(e){
		closePopup();
		self.close();
    });
	$("#popOk").click(function(e){
		self.close();
    });
	
}

function textareaHeight(obj) {
	$(obj).css("height", $(obj).prop('scrollHeight')+12+"px");
}

function closePopup() {
	var date = new Date();
	date.setDate(date.getDate() + 7);
	date.setHours(0, 0, 1);
	$.cookie("popup_${popupView.SEQ}", "true", {path:"/", expires: date, secure: false});
}

document.title = "${popupView.SUBJECT}"; 
</script>
<div class="pop-wrap" style="width:100%;">
    <div class="pop-head">
        <h2><c:out value="${popupView.SUBJECT }"/></h2>
        
        <a href="#none" class="close">닫기</a>
    </div>
    
    <div class="pop-cont">
        <div class="view-tit">
        </div>
        <div class="view-area">
            <div class="view-cont">
                <div class="view-desc">
                    <pre style="white-space: pre-wrap" readOnly="ReadOnly">${popupView.CONTENTS }</pre>
                </div>
            </div>
            
            <div class="b-btn-area t_center">
                <button type="button" id="popDay" class="bbtn s">1주일동안 창을 띄우지 않습니다.</button>
                <button type="button" id="popOk" class="bbtn s">확인</button>
            </div>
        </div>
    </div>
</div>