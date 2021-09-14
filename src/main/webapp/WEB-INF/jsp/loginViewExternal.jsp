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
<style>
/* header-wrap */
.header-wrap1{
	position:relative;	
	box-sizing:border-box;
	border-top:2px solid #429caf;
	border-bottom:1px solid #d6d6d7;
	height:68px;	
	background-color:#fff;
	/*box-shadow:1px 2px 5px rgba(214,214,214, 0.5)*/
}

body.main .header-wrap1 {border-bottom:0}

.inner {	
	width:1200px; height:100%;
	overflow:hidden;
	position:relative;
	margin:0 auto; 
}

.logo1 {
		float:left; margin:22px 80px 0 20px;
}

.logo1 a{
 	display:inline-block;
	width:182px;
 	height:22px; text-indent:-9999px;
	background:url('../../resources/images/common/logo.png') no-repeat 50%;
 }
 
 /* footer */
.footer-wrap1{
	position:absolute;
	left:0;
	right:0;
	bottom:0;
	z-index:20;	
	border-top:1px solid #c1c7d2;
	height:70px;	
}
</style>    
<script type="text/javascript">


$(document).ready(function(){
	
	var outImgList  = stringToArray("${outImgList}");
	
	<c:if test ="${not empty message}">
	alert('${message}');
		location.href="${pageContext.request.contextPath}/loginViewExternal.do";
	</c:if>

    var userInputId = getCookie("userInputId");
    var setCookieYN = getCookie("setCookieYN");
	
    if(setCookieYN == 'Y') {
        $("#idSaveCheck").prop("checked", true);
    } else {
        $("#idSaveCheck").prop("checked", false);
    }
    
    $("#USER_ID").val(userInputId); 
    
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
    init();
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
    if($("#idSaveCheck").is(":checked")){ 
        var userInputId = $("#USER_ID").val();
        setCookie("userInputId", userInputId, 60); 
        setCookie("setCookieYN", "Y", 60);
    } else {
        deleteCookie("userInputId");
        deleteCookie("setCookieYN");
    }
	
	
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
    obj.setAttribute('value', 'S'); 
    f.appendChild(obj);

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


//쿠키값 Set
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + 
    exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}

//쿠키값 Delete
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

//쿠키값 가져오기
function getCookie(cookie_name) {
    var x, y;
    var val = document.cookie.split(';');
    
    for (var i = 0; i < val.length; i++) {
        x = val[i].substr(0, val[i].indexOf('='));
        y = val[i].substr(val[i].indexOf('=') + 1);
        x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
        
        if (x == cookie_name) {
          return unescape(y); // unescape로 디코딩 후 값 리턴
        }
    }
}

function caps_lock(e) {
    var keyCode = 0;
    var shiftKey = false;
    keyCode = e.keyCode;
    shiftKey = e.shiftKey;
    if (((keyCode >= 65 && keyCode <= 90) && !shiftKey)
            || ((keyCode >= 97 && keyCode <= 122) && shiftKey)) {
        show_caps_lock();
        setTimeout("hide_caps_lock()", 3500);
    } else {
        hide_caps_lock();
    }
}

function show_caps_lock() {
 $("#capslock").show();
}

function hide_caps_lock() {
 $("#capslock").hide();
}


</script>
	<div class="wrap">
		<header class="header-wrap1">
			<div class="inner">
				<h1 class="logo1">
					<a href="#none">일동전사시스템</a>
				</h1>		
			</div>
		</header>

		<div class="container">
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

			<section class="contentArea">
				<article class="box todolist">
					<h3><span>T</span>o <span>D</span>o List</h3>
					<ul>
						<li>
							<a href="#hone">
								<div class="circle type1"></div>
								<p>승인요청</p>
							</a>
						</li>
						<li>
							<a href="#hone">
								<div class="circle type2"></div>
								<p>승인완료</p>
							</a>
						</li>
						<li>
							<a href="#hone">
								<div class="circle type3"></div>
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
						<h2 class="titleBox">LOGIN</h2>
						<div class="logBox">
							<ul>
								<li><input id="USER_ID" type="text" placeholder="ID" value=""></li>
								<li><input id="USER_PWD" type="password" placeholder="Password" onkeypress="javascript:caps_lock(event); if(event.keyCode==13){loginProcess()}" value=""></li>
								<p id="capslock" style="position:relative; border:2px solid #003b83; width:300px; bottom:0px; display:none"> 
								    &nbsp;<b>CapsLock</b> 키가 눌려있습니다.&nbsp;
								</p>
							</ul>
							<button class="login" id="btnLogin">로그인</button>
							<ul class="check">
								<li><label><input type="checkbox" id="idSaveCheck"> ID저장</li>
								<li><button class="idpw"></button></li>
							</ul>
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
		</div><!-- //container -->


		<footer class="footer-wrap1">
			<div class="inner">
				<div class="footer">
					<span>COPYRIGHT ⓒ ILDONG PHARMACEUTICAL CO.,LTD. ALL RIGHTS RESERVED.</span>
				</div>
			</div>
		</footer><!-- //footer-wrap -->

	</div><!-- //wrap -->		
