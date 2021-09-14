<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">

$(document).ready(function() {
	//초기화 함수
	init();
});


//초기화함수
function init() {
	if(!isEmpty($("#APP_SEQ").val())) {
		displayFileUpload({
			KEY_ID		: 'APP_SEQ',
			DATA_FORMAT	: 'table',
			CALLBACK	: 'fnFileUploadCallback'
		});	
	}
}

function fnFileUploadCallback(data) {
	$("#fileUploadTable").empty().html(data);
}

</script>
<div class="pop-wrap fixed" style="overflow-x: hidden">
	<div class="pop-head fixed">
		<h2>첨부파일</h2>
	</div>
	
	<div class="pop-cont"><!-- 상단 타이틀 영역 고정시 fixed 클래스 추가 -->
		<div class="sub-tit first">
	       <h4><c:out value="${param.TITLE}"/></h4>
	    </div>
	    <input type="hidden" id="APP_SEQ" name="APP_SEQ" value="${param.APP_SEQ}">
	    <div id="fileUploadTable">        
		    <table class="table-style t_center topLineNo leftLine">
		         <colgroup>
		             <col style="width: 8%;">
		             <col style="width: 67%;">
		             <col style="width: 15%;">
		             <col style="width: 10%;">
		         </colgroup>
		         <thead>
		             <tr>
		                 <th>No</th>
		                 <th>파일명</th>
		                 <th>등록일자</th>
		                 <th>파일크기</th>
		             </tr>
		         </thead>
		         <tbody>
		             <tr>
		                 <td colspan="4" class="t_center" style="height: 80px">파일이 없습니다.</td>
		              </tr>
		          </tbody>
		      </table>
		  </div>
	</div>
  </div>
</body>
</html>