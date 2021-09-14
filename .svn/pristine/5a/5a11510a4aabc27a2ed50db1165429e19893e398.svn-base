<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.app.ildong.common.session.UserSessionUtil" %>
<%@ page import="com.app.ildong.common.pagenation.PaginationInfo"%>

<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"   %>
<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s"       uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<style type="text/css">
.pop-cont { padding: 0px 30px; }
.tab-cont02{ margin-top:0px; }
</style>
<script type="text/javascript">

$(document).ready(function() {
    init();
    setEvent();
});

var init = function(){
}

var setEvent = function () {
    $(".enterEvnt").keyup(function(e) { //입력창 Enter 이벤트
        if (e.keyCode == 13) {
            linkPage();
        }
    });
}

function linkPage(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrp").val()});
    $.extend(params, {"srchTxt" : $("#srchTxt").val()});
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectcoNoticeList.do"/>',  params, function(data){
        
        $('#noticeTotal').empty();
        $('#noticeList > tbody').empty();
        
        $.each(data.rows, function(idx, vo) {
            
            var html = '';
            html += '<tr>'
            html +=     '<td align="center">'+ vo.TNUM  +'</td>'
            html +=     '<td class="subject"><a href="javascript:fnDetail('+vo.POST_SEQ +');">'+vo.SUBJECT+'</a></td>'
            html +=     '<td>'+ vo.USER_NM  +'</td>'
            html +=     '<td>'+ vo.HIT_CNT  +'</td>'
            html +=     '<td>'+ vo.INS_DT  +'</td>'
            html += '</tr>'
            
            $('#noticeList > tbody:last').append(html);
        });
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#noticePaging').empty();
            $('#noticePaging').append(data.fields.pagingTag);
        }
        
        $('#noticeTotal').append("총 <strong>"+data.records+"</strong>건");
        $('#page').val(page);
    });
}

function fnDetail(POST_SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":POST_SEQ});
    $.extend(params, {"page": $("#page").val()});
    $.extend(params, {"BOARD_ID": $("#BOARD_ID").val()});
    
    $.extend(params, {"srchGrp" : $("#srchGrp").val()});
    $.extend(params, {"srchTxt" : $("#srchTxt").val()});
    
    fnPostPopup("<c:url value='/com/mgt/mgtBoardDetailPopup.do'/>", params, "_self");
}

</script>
<input type="hidden" id="page"  name="page"  value="<c:out value="${page }" />" />
<input type="hidden" id="BOARD_ID"  name="BOARD_ID"  value="<c:out value="${boardInfo.BOARD_ID }" />" />

<div class="pop-wrap" style="width:900px">
	<div class="pop-head">
	    <h2 id="headTitle"><c:out value="${boardInfo.BOARD_NM }" /></h2>
	</div>
	
	<div class="pop-cont">
	    <section id="tabList2-01" class="tab-cont02 active">
	        <div class="tbl-top-area st2">
	            <span class="total" id="noticeTotal">총 <strong><c:out value="${TOT_CNT }" /></strong>건</span>
	            <div class="selec-sch-box">
	                <select id="srchGrp" name="srchGrp">
	                    <option value="01" <c:if test="${srchGrp == '01'}">selected="selected"</c:if>>제목</option>
	                    <option value="02" <c:if test="${srchGrp == '02'}">selected="selected"</c:if>>내용</option>
	                    <option value="03" <c:if test="${srchGrp == '03'}">selected="selected"</c:if>>작성자</option>
	                </select>
	                <div class="tbl-sch-box">
	                    <input type="text" id="srchTxt" name="srchTxt" value="<c:out value="${srchTxt }" />" class="w240 enterEvnt" placeholder="검색어를 입력해 주세요." maxlength="15">
	                    <a href="javascript:linkPage();">검색</a>
	                </div>
	            </div>
	        </div>
	
	        <table class="table-style01" id="noticeList">
	            <colgroup>
	                <col style="width: 8%">
	                <col>
	                <col style="width: 15%">
	                <col style="width: 10%">
	                <col style="width: 12%">
	            </colgroup>
	            <thead>
	                <tr>
	                    <th>번호</th>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>조회수</th>
	                    <th>등록일</th>
	                </tr>
	            </thead>
	            <tbody>
	            <c:forEach items="${dataList}" var="noticeInfo" varStatus="status">
	                <tr>
	                    <td><c:out value="${noticeInfo.TNUM }" /></td>
	                    <td class="subject"><a href="javascript:fnDetail(<c:out value='${noticeInfo.POST_SEQ }' />);"><c:out value='${noticeInfo.SUBJECT.replaceAll("\\\<.*?\\\>","")}' /></a></td>
	                    <td><c:out value="${noticeInfo.USER_NM }" /></td>
	                    <td><c:out value="${noticeInfo.HIT_CNT }" /></td>
	                    <td><c:out value="${noticeInfo.INS_DT }" /></td>
	                </tr>
	                </c:forEach>
	            </tbody>
	        </table>
	
	        <div class="paging-area" id="noticePaging">
	            <c:if test="${not empty paginationInfo}">
	                <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
	            </c:if>
	        </div>
	    </section>
	</div>
</div>