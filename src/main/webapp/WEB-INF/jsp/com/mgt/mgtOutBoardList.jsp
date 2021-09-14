<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>

<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<script type="text/javascript">

gfnShowProgressing();

$(document).ready(function() {
	
    fnInitStatus();
});

function fnInitStatus() {
	$("ul.tabs-control li a.tabtext").click(function () {
        var activeTab = $(this).attr("rel");
        moveTabMenu(activeTab);
    });
}

var moveTabMenu = function(activeTab){
	$(".tabs-cont").hide();
	$("#" + activeTab).fadeIn();

    $("#activeTab").val();
    $("#activeTab").val(activeTab);
 
//     if(activeTab == "tab0"){
//     }else if(activeTab == "tab1"){
//     }
}



</script>

<input type="hidden" name="BOARD_ID" id="BOARD_ID" value="">
<input type="hidden" name="activeTab" id="activeTab" value="">

<div class="tabs">
    <ul class="tabs-control">
        <li><a href="#tabs1" class="tabtext" rel="tabs1">BP 공지사항</a></li>
        <li><a href="#tabs2" class="tabtext" rel="tabs2">BP 자료실</a></li>
        <li><a href="#tabs3" class="tabtext" rel="tabs3">BP FAQ</a></li>
        <li><a href="#tabs4" class="tabtext" rel="tabs4">BP 구매규정 및 정책</a></li>
    </ul>
    
    <div id="tabs1" class="tabs-cont">                           
        <div class="sub-tit mt0">
<%--         <c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'SSP001')}"> --%>
<!--             <div class="right"> -->
<!--                 <button type="button" class="btn" id="btnAddLv1">추가</button> -->
<!--                 <button type="button" class="btn st1" id="btnSaveLv1">저장</button> -->
<!--             </div> -->
<%--         </c:if> --%>
        </div>
        <jsp:include page="/com/mgt/mgtOutBoardNoticeList.do" flush="false" />
        
    </div>
    
    <div id="tabs2" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        <jsp:include page="/com/mgt/mgtOutBoardDataList.do" flush="false"/>
<%--         <jsp:include page="/WEB-INF/jsp/com/mgt/mgtOutBoardDataList.jsp" flush="true" /> --%>
    </div>
    
    <div id="tabs3" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        <jsp:include page="/com/mgt/mgtOutBoardFaqList.do" flush="false"/>
    </div>
    
    <div id="tabs4" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        <jsp:include page="/com/mgt/mgtOutBoardPolicyList.do" flush="false"/>
    </div>
</div>


