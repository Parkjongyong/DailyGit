<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/tags"%>
<%@ page import="com.app.ildong.common.util.PropertiesUtil" %>
<%@ page import="com.app.ildong.common.session.UserSessionUtil" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>

<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);

if (request.getProtocol().equals("HTTP/1.1")) {
    response.setHeader("Cache-Control", "no-cache");
}
%>

<%-- <script src="<c:url value='/resources/plugin/assets/js/custom-scripts.js'/>"></script> <!-- Custom Js --> --%>

<script language="javascript">

$(document).ready(function() {
	var outImgList  = stringToArray("${outImgList}");
    $( "#passwd_dialog" ).dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:270, //팝업 가로
        width: 700, //팝업 높이
        close: function(event,ui) {
            $("#passwd_dialog").dialog( "close" );
            goLogout();
        }
    });
    
    if(isEmpty('${LOGIN_INFO.PWD_MOD_DATE}') == true || Number('${LOGIN_INFO.DATEGAP}') > 90){
    	pwChangePop();
    }
    
	var noticeList  = stringToArray("${noticeInfo}");

    $("#news-container").empty();

    var html = '';
    html += '<div class="swiper-wrapper">';
    
    var noticeCnt = 0;
    var loopCnt = 0;
    if (isNotEmpty(noticeList)) {
    	noticeCnt = noticeList.length;
    }
    for(var i = 0; i < 3; i++){
      if(i == 0){
          html += '<div class="swiper-slide">';
          html += '<ul class="noticeList">';
          
          if (noticeCnt > 3) {
        	  loopCnt = 3; 
          } else {
        	  loopCnt = noticeCnt;
          }
        for(var j = 0; j < loopCnt; j++){
          html += '<li>';
          html += '<a href="javascript:fnNoticeDetail('+nvl(noticeList[j].POST_SEQ, '') +')" class="subject">'+nvl(noticeList[j].SUBJECT, '')+'</a>';
          html += '<p><span>'+nvl(noticeList[j].INS_DT, '')+'</span></p>';
          html += '</li>';
        }
        html += '</ul>';
        html += '</div>';
        
      } else if(i == 1){
          html += '<div class="swiper-slide">';
          html += '<ul class="noticeList">';
          if (noticeCnt > 6) {
        	  loopCnt = 6; 
          } else {
        	  loopCnt = noticeCnt;
          }
        for(var j = 3; j < loopCnt; j++){
          html += '<li>';
          html += '<a href="javascript:fnNoticeDetail('+nvl(noticeList[j].POST_SEQ, '') +')" class="subject">'+nvl(noticeList[j].SUBJECT, '')+'</a>';
          html += '<p><span>'+nvl(noticeList[j].INS_DT, '')+'</span></p>';
          html += '</li>';
        }
        html += '</ul>';
        html += '</div>';
      } else {
          html += '<div class="swiper-slide">';
          html += '<ul class="noticeList">';
          if (noticeCnt > 9) {
        	  loopCnt = 9; 
          } else {
        	  loopCnt = noticeCnt;
          }          
        for(var j =6; j < loopCnt; j++){
          html += '<li>';
          html += '<a href="javascript:fnNoticeDetail('+nvl(noticeList[j].POST_SEQ, '') +')" class="subject">'+nvl(noticeList[j].SUBJECT, '')+'</a>';
          html += '<p><span>'+nvl(noticeList[j].INS_DT, '')+'</span></p>';
          html += '</li>';
        }
        html += '</ul>';
        html += '</div>';
      }
    }
	
    html += '</div>';
	html += '<!-- Pagination -->';
	html += '<div class="swiper-pagination"></div>';
    html += '</div>';
    
    $("#news-container").append(html);
    
	var visual = new Swiper('.out-side-container', {
		slidesPerView: 1,
		loop: true,
		autoplay: {
			delay: 3000,
			disableOnInteraction: false,
		 },
		 pagination: {
			el: '.swiper-pagination',
			clickable: true,
		 },
		navigation: {
			nextEl: '.swiper-button-next',
			prevEl: '.swiper-button-prev',
		 }				
	});
	$(".swiper-button-on").click(function(){
		if(!$(this).hasClass("on")){			
			visual.autoplay.stop();
			$(this).addClass("on");
		}else{
			visual.autoplay.start();
			$(this).removeClass("on");
		}
	});

	var visua1 = new Swiper('.news-container', {
		 pagination: {
			el: '.swiper-pagination',
			clickable: true,
		 }
	});
	
    //공지 팝업 호출
    fnCallPop();	
	
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();

});

//공지팝업 호출
function fnCallPop(){

    var params = fnGetParams();
    
    //권한관련 파라미터 추가 - 팝업권한
    params['G_TOP_MENU_CD'] = "EPM99000"; 
    params['G_MENU_CD']     = "EPM99991";
    
    
    ajaxJsonCall("<c:url value='/com/mai/selectPopupMgmtListMain.do'/>", params
            , function(result) {
                $.each(result.rows, function(index, value){
                    if($.cookie("popup_"+value.SEQ) != 'true') {
                        var url = "<c:url value='/com/mai/selectPopupMgmtMain'/>";
                        params['SEQ'] = value.SEQ;
                        var target = "popup_"+value.SEQ;

                        var width = value.WIDTH;
                        var height = value.HEIGHT;
                        var top = value.TOP;
                        var left = value.LEFT;
                        var scrollbar = "yes";
                        var resizable = "yes";
                        
                        window.open("", target, "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top + ",status=no, scrollbars=" + scrollbar + ", resizable=" + resizable );
                        fnPostGoto(url, params, target);
                    }
                });
            }
            , function(result) {
                console.log(result);
                alert("공지팝업 호출 중 에러가 발생하였습니다.");
            }
    );
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
    	$("#passwd_dialog").dialog("close");
    	goLogout();
    }
}

function pwChangePop() {
    
	$("#passwd_dialog").dialog("open");
	
	if(isEmpty('${LOGIN_INFO.PWD_MOD_DATE}') == true){
		$('#ment').text("※ 최초 로그인 시 비밀번호를 변경해야 합니다.");
	} else if('${LOGIN_INFO.PWD_MOD_DATE}' > 90) {
		$('#ment').text("※ 90일동안 비밀번호를 변경하지 않으셨습니다. 비밀번호를 변경해야 합니다.");
	} else {
		$('#ment').text("※ 비밀번호 변경");
	}
}

function goLogout(){
    document.location.href = "${pageContext.request.contextPath}/logout.do";
}

/**
 * FAQ 팝업
 */
function fnSearchFaqList(page) {
	
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"G_MENU_CD" : "BBS110"});
    $.extend(params, {"BOARD_ID" : "004"});
    
	// 조회 요청
	fnPostPopup('/com/sys/sysInFaqListPop', params, "/sysInFaqListPop","900","600");

}


/**
 * 자료실 팝업
 */
function fnSearchDataList(page) {
    if( isEmpty(page)) { page = 1;}
    
    var params = fnGetMakeParams();
    $.extend(params, {"page" : page});
    $.extend(params, {"srchGrp" : $("#srchGrpFaq").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtFaq").val()});
    $.extend(params, {"G_MENU_CD" : "BBS110"});
    $.extend(params, {"BOARD_ID" : "004"});
    
	// 조회 요청
	fnPostPopup('/com/sys/sysInDataListPop', params, "/sysInDataListPop","900","600");

}

/**
 * 공지사항 상세내용 조회
 */
function fnNoticeDetail(SEQ) {
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ":SEQ});
    $.extend(params, {"srchGrp" : $("#srchGrpNotice").val()});
    $.extend(params, {"srchTxt" : $("#srchTxtNotice").val()});
    $.extend(params, {"BOARD_ID" : "001"});
    $.extend(params, {"G_MENU_CD" : "BBS110"});
    $.extend(params, {"page" : $("#noticePage").val()});
    $.extend(params, {"BTN_YN" : "N"});
    
    fnPostPopup('/com/sys/sysOutBoardDetail', params, "sysOutBoardDetail","900","600");
}


</script>

<div class="inner">
	<div class="out-side-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<h3>Global Healthcare Company</h3>
				<h4>함께하면 행복해지는 <span>국민건강연구소</span></h4>
				<div class="img"><img src="<c:url value='/resources/images/common/sysMainImage/${outImgList[0].FILE_NM}'/>"></div>
			</div>
			<div class="swiper-slide">
				<h3>Global Healthcare Company</h3>
				<h4>함께하면 행복해지는 <span>국민건강연구소</span></h4>
				<div class="img"><img src="<c:url value='/resources/images/common/sysMainImage/${outImgList[1].FILE_NM}'/>"></div>
			</div>
			<div class="swiper-slide">
				<h3>Global Healthcare Company</h3>
				<h4>함께하면 행복해지는 <span>국민건강연구소</span></h4>
				<div class="img"><img src="<c:url value='/resources/images/common/sysMainImage/${outImgList[2].FILE_NM}'/>"></div>
			</div>
		</div>
		<!-- Pagination -->
		<div class="swiper-pagination"></div>
		 <!-- Arrows -->
		<div class="swiper-button-prev">prev</div>
		<div class="swiper-button-next">next</div>
		<!-- stop/play -->
		<div class="swiper-button-on">on</div>
	</div>
</div>

<div class="inner">
	<section class="contentArea">
		<article class="box todolist">
			<h3><span>T</span>o <span>D</span>o List</h3>
			<ul>
				<li>
					<a href="#hone" onclick="goMenu('${G_TOP_MENU_CD}','${G_TOP_MENU_NM}','${G_UP_MENU_CD}','${G_MENU_CD}')">
						<div class="circle type1">
							<span>${oferCnt}</span>
						</div>
						<p>제안</p>
					</a>
				</li>
				<li>
					<a href="#hone" onclick="goMenu('${G_TOP_MENU_CD}','${G_TOP_MENU_NM}','${G_UP_MENU_CD}','${G_MENU_CD}')">
						<div class="circle type2">
							<span>${oferCompCnt}</span>
						</div>
						<p>제안완료</p>
					</a>
				</li>
				<li>
					<a href="#hone" onclick="goMenu('${G_TOP_MENU_CD}','${G_TOP_MENU_NM}','${G_UP_MENU_CD}','${G_MENU_CD}')">
						<div class="circle type3">
							<span>${cmpnCnt}</span>
						</div>
						<p>반려</p>
					</a>
				</li>
			</ul>
		</article><!-- Todo list END -->

		<article class="box news">
			<h2 class="titleBox">NEWS</h2>
					<div class="news-container" id="news-container">
						<!-- Pagination -->
					<div class="swiper-pagination"></div>
					</div>

		</article><!-- news END -->

		<article class="box">
			<div class="loginBoxArea">
				<h2 class="titleBox">LOGOUT</h2>
				<div class="logBox in">
					<p onclick="changePw();">
						<span>${LOGIN_INFO.VENDOR_NM}</span>님 
						<em>만나서 반갑습니다.</em>
					</p>
					<button onclick="goLogout();return false;">로그아웃</button>
				</div>
			</div>

			<div class="quickArea">
				<ul>
					<li><a href="javascript:fnSearchFaqList();"><span class="qico01">FAQ</span></a></li>
					<li><a href="javascript:fnSearchDataList();"><span class="qico02">자료실</span></a></li>
				</ul>
			</div>
		</article>
	</section>
</div>		

		
				
<div id="passwd_dialog" title="패스워드 변경">
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
 </div>