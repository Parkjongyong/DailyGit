<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>


<script type="text/javascript">

gfnShowProgressing();

$(document).ready(function() {
	
    fnInitStatus();
    searchNotice();
    searchData();
    searchFaq();
});

function fnInitStatus() {
	$("ul.tabs-control li a.tabtext").click(function () {
        var activeTab = $(this).attr("rel");
        moveTabMenu(activeTab);
    });
	
	$(document).on("click", "#btnNoticeWrite", function(e){
        fnNoticeWrite();
    });
	
	$(document).on("click", "#btnDataWrite", function(e){
        fnDataWrite();
    });
	
	$(document).on("click", "#btnFaqWrite", function(e){
        fnFaqWrite();
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



function searchNotice(page){
	gfnCloseProgressing();
	
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "001"});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtOutBoardNoticeList.do"/>',  params, function(data){
        
        $('#noticeTotal').empty();
        $('#noticeList > tbody').empty();
        
        if(data.rows.length > 0){
            $.each(data.rows, function(idx, vo) {
                
                var html = '';
                html += '<tr>'
                html +=     '<td align="center">'+ vo.TNUM  +'</td>'
                html +=     '<td align="center">'+ vo.NOTICE_NM  +'</td>'
                html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
                html +=     '<td class="subject"><a href="javascript:fnNoticeDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
                html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
                html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
                html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
                html += '</tr>'
                
                $('#noticeList > tbody:last').append(html);
            });
        }else{
            var html = '';
            html += '<tr>'
            html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
            html += '</tr>'
            
            $('#noticeList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#noticePaging').empty();
            $('#noticePaging').append(data.fields.pagingTag);
        }
        
        $('#noticeTotal').append("총 <strong>"+data.records+"</strong>건");
        $('#noticePage').val(page);
    });
}

function searchData(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpData").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtData").val()});
    $.extend(params, {"BOARD_ID" : "002"});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtOutBoardDataList.do"/>',  params, function(data){
        
        $('#dataTotal').empty();
        $('#dataList > tbody').empty();
        
        if(data.rows.length > 0){
            $.each(data.rows, function(idx, vo) {
                
                var html = '';
                html += '<tr>'
                html +=     '<td align="center">'+ vo.TNUM  +'</td>'
                html +=     '<td align="center">'+ vo.NOTICE_NM  +'</td>'
                html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
                html +=     '<td class="subject"><a href="javascript:fnDataDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
                html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
                html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
                html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
                html += '</tr>'
                
                $('#dataList > tbody:last').append(html);
            });
        }else{
            var html = '';
            html += '<tr>'
            html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
            html += '</tr>'
            
            $('#dataList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#dataPaging').empty();
            $('#dataPaging').append(data.fields.pagingTag);
        }
        
        $('#dataTotal').append("총 <strong>"+data.records+"</strong>건");
        $('#dataPage').val(page);
    });
}

function searchFaq(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"BOARD_ID" : "004"});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtOutBoardFaqList.do"/>',  params, function(data){
        
        $('#faqTotal').empty();
        $('#faqList > tbody').empty();
        
        if(data.rows.length > 0){
            $.each(data.rows, function(idx, vo) {
                
                var html = '';
                html += '<tr>'
                html +=     '<td align="center">'+ vo.TNUM  +'</td>'
                html +=     '<td align="center">'+ vo.CONTENTS_CLS_NM  +'</td>'
                html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
                html +=     '<td class="subject"><a href="javascript:fnFaqDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
                html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
                html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
                html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
                html += '</tr>'
                
                $('#faqList > tbody:last').append(html);
            });
        }else{
            var html = '';
            html += '<tr>'
            html +=     '<td align="center" colspan="7">조회 된 데이터가 없습니다.</td>'
            html += '</tr>'
            
            $('#faqList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#faqPaging').empty();
            $('#faqPaging').append(data.fields.pagingTag);
        }
        
        $('#faqTotal').append("총 <strong>"+data.records+"</strong>건");
        $('#faqPage').val(page);
    });
}

var fnNoticeDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "001"});
    $.extend(params, {"page" : $("#noticePage").val()});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnNoticeWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "001"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}

var fnDataDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "002"});
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpData").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtData").val()});
    $.extend(params, {"page" : $("#dataePage").val()});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnDataWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "002"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}


var fnFaqDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"BOARD_ID" : "004"});
    $.extend(params, {"page" : $("#faqPage").val()});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnFaqWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "004"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}

</script>

<input type="hidden" name="BOARD_ID" id="BOARD_ID" value="">
<input type="hidden" name="activeTab" id="activeTab" value="">

<input type="hidden" name="noticePage" id="noticePage" />
<input type="hidden" name="dataPage" id="dataPage" />
<input type="hidden" name="faqPage" id="faqPage" />

<div class="tabs">
    <ul class="tabs-control">
        <li><a href="#tabs1" class="tabtext" rel="tabs1">공지사항</a></li>
        <li><a href="#tabs2" class="tabtext" rel="tabs2">자료실</a></li>
        <li><a href="#tabs3" class="tabtext" rel="tabs3">FAQ</a></li>
    </ul>
    
    <div id="tabs1" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
		    <span class="total" id="noticeTotal">총 <strong><c:out value="${TOT_CNT }" /></strong>건</span>
		
		    <div class="selec-sch-box">
		        <select id="srchGrpNotice" name="srchGrpNotice">
		            <option value ="01">제목</option>
		            <option value ="02">내용</option>
		            <option value ="03">작성자</option>
		        </select>
		        
		        <div class="tbl-sch-box">
		            <input type="text" id="srchTxtNotice" name="srchTxtNotice" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
		            <a href="javascript:searchNotice();">검색</a>
		        </div>
		    </div>
		</div>
		
		<table class="table-style01" id="noticeList">
		    <colgroup>
		        <col style="width:5%">
		        <col style="width:7%">
		        <col style="width:7%">
		        <col>
		        <col style="width:7%">
		        <col style="width:5%">
		        <col style="width:7%">
		    </colgroup>
		
		    <thead>
		        <tr>
		            <th>번호</th>
		            <th>공지여부</th>
		            <th>게시여부</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>조회수</th>
		            <th>등록일</th>
		        </tr>
		    </thead>
		    <tbody>
		    </tbody>
		</table>
		
		<!-- 쓰기, 수정 권한 (시스템담당자, 구매담당자) 수정은 본인 것만 -->
		<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
		<div class="paging-btn">
		    <a href="#none" id="btnNoticeWrite" class="bbtn">글쓰기</a>
		</div>
		</c:if>
		
		<div class="paging-area" id="noticePaging">
		    <c:if test="${not empty paginationInfo}">
		        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchNotice" />
		    </c:if>
		</div>
    </div>
    
    <div id="tabs2" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
		    <span class="total" id="dataTotal">총 <strong><c:out value="${TOT_CNT }" /></strong>건</span>
		
		    <div class="selec-sch-box">
		        <select id="srchGrpData" name="srchGrpData">
		            <option value ="01">제목</option>
		            <option value ="02">내용</option>
		            <option value ="03">작성자</option>
		        </select>
		        
		        <div class="tbl-sch-box">
		            <input type="text" id="srchTxtData" name="srchTxtData" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
		            <a href="javascript:searchData();">검색</a>
		        </div>
		    </div>
		 </div>
		
		<table class="table-style01" id="dataList">
		    <colgroup>
		        <col style="width:5%">
		        <col style="width:7%">
		        <col style="width:7%">
		        <col>
		        <col style="width:7%">
		        <col style="width:5%">
		        <col style="width:7%">
		    </colgroup>
		
		    <thead>
		        <tr>
		            <th>번호</th>
		            <th>공지여부</th>
		            <th>게시여부</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>조회수</th>
		            <th>등록일</th>
		        </tr>
		    </thead>
		    <tbody>
		    </tbody>
		</table>
		
		<!-- 쓰기, 수정 권한 (시스템담당자, 구매담당자) 수정은 본인 것만 -->
		<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
		<div class="paging-btn">
		    <a href="#none" id="btnDataWrite" class="bbtn">글쓰기</a>
		</div>
		</c:if>
		
		<div class="paging-area" id="dataPaging">
		    <c:if test="${not empty paginationInfo}">
		        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchData" />
		    </c:if>
		</div>
    </div>
    
    <div id="tabs3" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
		    <span class="total" id="faqTotal">총 <strong><c:out value="${TOT_CNT }" /></strong>건</span>
		
		    <div class="selec-sch-box">
		        <select id="srchGrpFaq" name="srchGrpFaq">
		            <option value ="01">제목</option>
		            <option value ="02">내용</option>
		            <option value ="03">작성자</option>
		        </select>
		        
		        <div class="tbl-sch-box">
		            <input type="text" id="srchTxtFaq" name="srchTxtFaq" maxlength="15" class="w240" placeholder="검색어를 입력해주세요.">
		            <a href="javascript:searchFaq();">검색</a>
		        </div>
		    </div>
		 </div>
		
		<table class="table-style01" id="faqList">
		    <colgroup>
		        <col style="width:5%">
		        <col style="width:7%">
		        <col style="width:7%">
		        <col>
		        <col style="width:7%">
		        <col style="width:5%">
		        <col style="width:7%">
		    </colgroup>
		
		    <thead>
		        <tr>
		            <th>번호</th>
		            <th>구분</th>
		            <th>게시여부</th>
		            <th>제목</th>
		            <th>작성자</th>
		            <th>조회수</th>
		            <th>등록일</th>
		        </tr>
		    </thead>
		    <tbody>
		    </tbody>
		</table>
		
		<!-- 쓰기, 수정 권한 (시스템담당자, 구매담당자) 수정은 본인 것만 -->
		<c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
		<div class="paging-btn">
		    <a href="#none" id="btnFaqWrite" class="bbtn">글쓰기</a>
		</div>
		</c:if>
		
		<div class="paging-area" id="faqPaging">
		    <c:if test="${not empty paginationInfo}">
		        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchFaq" />
		    </c:if>
		</div>
    </div>
</div>


