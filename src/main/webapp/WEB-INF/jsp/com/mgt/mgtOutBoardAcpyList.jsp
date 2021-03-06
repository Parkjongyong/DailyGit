<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/tags"%>

<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>

<script type="text/javascript">

gfnShowProgressing();

$(document).ready(function() {
    
    fnInitStatus();
    searchNotice();
    searchData();
    searchNews();
    searchVos();
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
    
    $(document).on("click", "#btnNewsWrite", function(e){
        fnNewsWrite();
    });
}

var moveTabMenu = function(activeTab){
    $(".tabs-cont").hide();
    $("#" + activeTab).fadeIn();

    $("#activeTab").val();
    $("#activeTab").val(activeTab);
 
}

function searchNotice(page){
    gfnCloseProgressing();
    
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "301"});
    
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
            html +=     '<td align="center" colspan="7">?????? ??? ???????????? ????????????.</td>'
            html += '</tr>'
            
            $('#noticeList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#noticePaging').empty();
            $('#noticePaging').append(data.fields.pagingTag);
        }
        
        $('#noticeTotal').append("??? <strong>"+data.records+"</strong>???");
        $('#noticePage').val(page);
    });
}

function searchData(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpData").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtData").val()});
    $.extend(params, {"BOARD_ID" : "302"});
    
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
            html +=     '<td align="center" colspan="7">?????? ??? ???????????? ????????????.</td>'
            html += '</tr>'
            
            $('#dataList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#dataPaging').empty();
            $('#dataPaging').append(data.fields.pagingTag);
        }
        
        $('#dataTotal').append("??? <strong>"+data.records+"</strong>???");
        $('#dataPage').val(page);
    });
}

function searchNews(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpNews").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNews").val()});
    $.extend(params, {"BOARD_ID" : "303"});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtOutBoardNewsList.do"/>',  params, function(data){
        
        $('#newsTotal').empty();
        $('#newsList > tbody').empty();
        
        if(data.rows.length > 0){
            $.each(data.rows, function(idx, vo) {
                
                var html = '';
                html += '<tr>'
                html +=     '<td align="center">'+ vo.TNUM  +'</td>'
                html +=     '<td align="center">'+ vo.NOTICE_NM  +'</td>'
                html +=     '<td align="center">'+ vo.STATUS_NM  +'</td>'
                html +=     '<td class="subject"><a href="javascript:fnNewsDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
                html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
                html +=     '<td align="center">'+ vo.HIT_CNT  +'</td>'
                html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
                html += '</tr>'
                
                $('#newsList > tbody:last').append(html);
            });
        }else{
            var html = '';
            html += '<tr>'
            html +=     '<td align="center" colspan="7">?????? ??? ???????????? ????????????.</td>'
            html += '</tr>'
            
            $('#newsList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#newsPaging').empty();
            $('#newsPaging').append(data.fields.pagingTag);
        }
        
        $('#newsTotal').append("??? <strong>"+data.records+"</strong>???");
        $('#newsPage').val(page);
    });
}

function searchVos(page){
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpVos").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtVos").val()});
    $.extend(params, {"BOARD_ID" : "304"});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtOutBoardVosList.do"/>',  params, function(data){
        
        $('#vosTotal').empty();
        $('#vosList > tbody').empty();
        
        if(data.rows.length > 0){
            $.each(data.rows, function(idx, vo) {
                
                var html = '';
                html += '<tr>'
                html +=     '<td align="center">'+ vo.TNUM  +'</td>'
                html +=     '<td class="subject"><a href="javascript:fnVosDetail('+vo.SEQ +');">'+vo.SUBJECT+'</a></td>'
                html +=     '<td align="center">'+ vo.USER_NM  +'</td>'
                html +=     '<td align="center">'+ nvl(vo.VENDOR_CD, "")  +'</td>'
                html +=     '<td align="center">'+ nvl(vo.WRITE_NM, "")  +'</td>'
                html +=     '<td align="center">'+ vo.INS_DT  +'</td>'
                html += '</tr>'
                
                $('#vosList > tbody:last').append(html);
            });
        }else{
            var html = '';
            html += '<tr>'
            html +=     '<td align="center" colspan="6">?????? ??? ???????????? ????????????.</td>'
            html += '</tr>'
            
            $('#vosList > tbody:last').append(html);
        }
        
        if(!isEmpty(data.fields.pagingTag)){
            $('#vosPaging').empty();
            $('#vosPaging').append(data.fields.pagingTag);
        }
        
        $('#vosTotal').append("??? <strong>"+data.records+"</strong>???");
        $('#page').val(page);
    });
}

var fnNoticeDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "301"});
    $.extend(params, {"page" : $("#noticePage").val()});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnNoticeWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "301"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}

var fnDataDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "302"});
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpData").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtData").val()});
    $.extend(params, {"page" : $("#dataPage").val()});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnDataWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "302"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}


var fnNewsDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpNews").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNews").val()});
    $.extend(params, {"BOARD_ID" : "303"});
    $.extend(params, {"page" : $("#newsPage").val()});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

var fnNewsWrite = function(){
    var params = fnGetMakeParams();
    $.extend(params, {"BOARD_ID" : "303"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardWritePop.do' />", params, "mgtOutBoardWritePop","920","900");
}
 
var fnVosDetail = function(SEQ){
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpVos").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtVos").val()});
    $.extend(params, {"BOARD_ID" : "304"});
    
    fnPostPopup("<c:out value='/com/mgt/mgtOutBoardDetail.do' />", params, "mgtOutBoardDetail","920","900");
}

</script>

<input type="hidden" name="BOARD_ID" id="BOARD_ID" value="">
<input type="hidden" name="activeTab" id="activeTab" value="">

<input type="hidden" name="noticePage" id="noticePage" />
<input type="hidden" name="dataPage" id="dataPage" />
<input type="hidden" name="newsPage" id="newsPage" />

<div class="tabs">
    <ul class="tabs-control">
        <li><a href="#tabs1" class="tabtext" rel="tabs1">???????????? ????????????</a></li>
        <li><a href="#tabs2" class="tabtext" rel="tabs2">???????????? ?????????</a></li>
        <li><a href="#tabs3" class="tabtext" rel="tabs3">???????????? News</a></li>
        <li><a href="#tabs4" class="tabtext" rel="tabs4">???????????? VOS</a></li>
    </ul>
    
    <div id="tabs1" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
            <span class="total" id="noticeTotal">??? <strong><c:out value="${TOT_CNT }" /></strong>???</span>
        
            <div class="selec-sch-box">
                <select id="srchGrpNotice" name="srchGrpNotice">
                    <option value ="01">??????</option>
                    <option value ="02">??????</option>
                    <option value ="03">?????????</option>
                </select>
                
                <div class="tbl-sch-box">
                    <input type="text" id="srchTxtNotice" name="srchTxtNotice" maxlength="15" class="w240" placeholder="???????????? ??????????????????.">
                    <a href="javascript:searchNotice();">??????</a>
                </div>
            </div>
        </div>
        
        <table class="table-style01" id="noticeList">
            <colgroup>
                <col style="width:8%">
                <col style="width:7%">
                <col style="width:7%">
                <col>
                <col style="width:7%">
                <col style="width:5%">
                <col style="width:7%">
            </colgroup>
        
            <thead>
                <tr>
                    <th>??????</th>
                    <th>????????????</th>
                    <th>????????????</th>
                    <th>??????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        <!-- ??????, ?????? ?????? (??????????????????, ???????????????) ????????? ?????? ?????? -->
        <c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
        <div class="paging-btn">
            <a href="#none" id="btnNoticeWrite" class="bbtn">?????????</a>
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
            <span class="total" id="dataTotal">??? <strong><c:out value="${TOT_CNT }" /></strong>???</span>
        
            <div class="selec-sch-box">
                <select id="srchGrpData" name="srchGrpData">
                    <option value ="01">??????</option>
                    <option value ="02">??????</option>
                    <option value ="03">?????????</option>
                </select>
                
                <div class="tbl-sch-box">
                    <input type="text" id="srchTxtData" name="srchTxtData" maxlength="15" class="w240" placeholder="???????????? ??????????????????.">
                    <a href="javascript:searchData();">??????</a>
                </div>
            </div>
         </div>
        
        <table class="table-style01" id="dataList">
            <colgroup>
                <col style="width:8%">
                <col style="width:7%">
                <col style="width:7%">
                <col>
                <col style="width:7%">
                <col style="width:5%">
                <col style="width:7%">
            </colgroup>
        
            <thead>
                <tr>
                    <th>??????</th>
                    <th>????????????</th>
                    <th>????????????</th>
                    <th>??????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        <!-- ??????, ?????? ?????? (??????????????????, ???????????????) ????????? ?????? ?????? -->
        <c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
        <div class="paging-btn">
            <a href="#none" id="btnDataWrite" class="bbtn">?????????</a>
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
            <span class="total" id="newsTotal">??? <strong><c:out value="${TOT_CNT }" /></strong>???</span>
        
            <div class="selec-sch-box">
                <select id="srchGrpNews" name="srchGrpNews">
                    <option value ="01">??????</option>
                    <option value ="02">??????</option>
                    <option value ="03">?????????</option>
                </select>
                
                <div class="tbl-sch-box">
                    <input type="text" id="srchTxtNews" name="srchTxtNews" maxlength="15" class="w240" placeholder="???????????? ??????????????????.">
                    <a href="javascript:searchNews();">??????</a>
                </div>
            </div>
         </div>
        
        <table class="table-style01" id="newsList">
            <colgroup>
                <col style="width:8%">
                <col style="width:7%">
                <col style="width:7%">
                <col>
                <col style="width:7%">
                <col style="width:5%">
                <col style="width:7%">
            </colgroup>
        
            <thead>
                <tr>
                    <th>??????</th>
                    <th>????????????</th>
                    <th>????????????</th>
                    <th>??????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        <!-- ??????, ?????? ?????? (??????????????????, ???????????????) ????????? ?????? ?????? -->
        <c:if test="${fn:contains(SESSION_INFO.ROLE_LIST, 'PUR002') || fn:contains(SESSION_INFO.ROLE_LIST, 'SYS001')}">
        <div class="paging-btn">
            <a href="#none" id="btnNewsWrite" class="bbtn">?????????</a>
        </div>
        </c:if>
        
        <div class="paging-area" id="newsPaging">
            <c:if test="${not empty paginationInfo}">
                <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchNews" />
            </c:if>
        </div>
    </div>
    
    <div id="tabs4" class="tabs-cont">                           
        <div class="sub-tit mt0">
        </div>
        
        <div class="tbl-top-area">
            <span class="total" id="vosTotal">??? <strong><c:out value="${TOT_CNT }" /></strong>???</span>
        
            <div class="selec-sch-box">
                <select id="srchGrpVos" name="srchGrpVos">
                    <option value ="01">??????</option>
                    <option value ="02">??????</option>
                    <option value ="03">BP???</option>
                </select>
                
                <div class="tbl-sch-box">
                    <input type="text" id="srchTxtVos" name="srchTxtVos" maxlength="15" class="w240" placeholder="???????????? ??????????????????.">
                    <a href="javascript:searchVos();">??????</a>
                </div>
            </div>
         </div>
        
        <table class="table-style01" id="vosList">
            <colgroup>
                <col style="width:8%">
                <col>
                <col style="width:15%">
                <col style="width:8%">
                <col style="width:15%">
                <col style="width:8%">
            </colgroup>
        
            <thead>
                <tr>
                    <th>??????</th>
                    <th>??????</th>
                    <th>BP???</th>
                    <th>BP??????</th>
                    <th>?????????</th>
                    <th>?????????</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        
        <div class="paging-area" id="vosPaging">
            <c:if test="${not empty paginationInfo}">
                <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="searchVos" />
            </c:if>
        </div>
    </div>
</div>


