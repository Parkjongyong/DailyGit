<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
	var G_UP_MENU_CD = "";
	var GUBN_M_D = "";
    $(document).ready(function() {
    	
    	//tab
    	$(".tab_content").hide(); 
    	$("ul.lnbtabs li:first").addClass("active").show(); 
    	$(".tab_content:first").show();
    	
    	var topMenuCd = "${param.G_TOP_MENU_CD}";
    	var topMenuNm = "${param.G_TOP_MENU_NM}";
    	G_UP_MENU_CD  = "${param.G_UP_MENU_CD}";
    	
    	// 상세 업무화면 진입시
    	if (topMenuCd != null && topMenuCd != 'undefined' && topMenuCd != "" && isNotEmpty(topMenuNm)) {
    		GUBN_M_D = "D";
    		lnbMenuClick(topMenuCd, topMenuNm);
    	} else {
    		GUBN_M_D = "M";
        	//LNB 메뉴 event 설정
        	fnEventMenu();
        	
    	}
    	
    	$("ul.lnbtabs li").click(function() {
    		
        	$(".tab_content").hide(); 
    		$("ul.lnbtabs li").removeClass("active"); 
    		$(this).addClass("active"); 

    		var activeTab = $(this).find("a").attr("href");
    		if (activeTab == "#tab1") {
            	$("ul.lnbtabs li:first").addClass("active").show(); 
            	$(".tab_content:first").show();
    		}
    		$(activeTab).fadeIn();
    		
    		return false;
    	});
    	
    	//lnb 열고/닫기
    	$(".lnb-btn").click(function(){
    		if(!$(this).hasClass("on")){
    			$(".lnb-area").css("margin-left","-225px");
    			$(".content").css("padding-left","30px");
    			
//     			if (GUBN_M_D == "M") {
//         			$(".lnb-area").css("margin-left","-300px");
//         			$(".content").css("padding-left","140px");
//         			$(".content").css("margin-left","270px");
//     			} else {
//         			$(".lnb-area").css("margin-left","-240px");
//         			$(".content").css("padding-left","20px");    				
//     			}
    			$(this).addClass("on");
    			
    			if (typeof(Event) === 'function') {
    			    // modern browsers
    			     window.dispatchEvent(new Event('resize'));
    			} else {
    			    // for IE and other old browsers
    			    // causes deprecation warning on modern browsers
    			    var evt = window.document.createEvent('UIEvents'); 
    			    evt.initUIEvent('resize', true, false, window, 0); 
    			    window.dispatchEvent(evt);
    			}
    			
    		} else {
    			
    			$(".lnb-area").css("margin-left","0");
    			$(".content").css("padding-left","250px");    			
//     			if (GUBN_M_D == "M") {
//         			$(".lnb-area").css("margin-left","0");
//         			$(".content").css("padding-left","140px");
//         			$(".content").css("margin-left","270px");
//     			} else {
//         			$(".lnb-area").css("margin-left","0");
//         			$(".content").css("padding-left","240px");   				
//     			}    			
    			$(this).removeClass("on");
    			
    			if (typeof(Event) === 'function') {
    			    // modern browsers
    			     window.dispatchEvent(new Event('resize'));
    			} else {
    			    // for IE and other old browsers
    			    // causes deprecation warning on modern browsers
    			    var evt = window.document.createEvent('UIEvents'); 
    			    evt.initUIEvent('resize', true, false, window, 0); 
    			    window.dispatchEvent(evt);
    			}
    		}
    	});    	

    	//jquery ui 활성
    	$( ".tabs" ).tabs();		    	
    	
    	//내부스크롤
        $(".custom-scroll").mCustomScrollbar({
            theme:"minimal-dark"
        });
    	
    	// 마이메뉴 그리기
        fnRenderMyMenu();

	});
    
    /**
     * 상단 대메뉴에서 진입시 이벤트 처리
     */
    function lnbMenuClick(topMenuCd, topMenuNm){
    	
    	if($(".lnb-btn").hasClass("on")){
    		$(".lnb-btn").trigger("click");	
    	}
    	
        // 업무메뉴 활성화
        $("ul.lnbtabs li").removeClass("active");
        
    	$(".tab_content").hide(); 
    	$("ul.lnbtabs li:first").addClass("active").show(); 
    	$(".tab_content:first").show(); 
    	
        $('#tab1').addClass("active"); 
        $('#tab1').fadeIn();
        
        // 업무메뉴 그리기 설정
        // 대메뉴 기준으로 filter 처리된 메뉴만 활성화
        fnRenderLnbMenuList(topMenuCd, topMenuNm);
        
    	//jquery ui 활성
    	$( ".tabs" ).tabs();         
        
    }    
    
    
    /**
     * 나의 메뉴 추가
     */
    function fnAddMyMenu(){
    	var menuCd = "${param.G_MENU_CD}";
    	
    	if(!isEmpty(menuCd)){
  	        // parameter setting
  	        var params = { MENU_CD : menuCd };
  			// 조회 요청
  			saveCall(null, '/addMyMenu', 'fnMyMenu', params);     	        
    	}
    }
    
    /**
     * 나의 메뉴 전체 삭제
     */
    function fnAllDelMyMenu(){
		// 삭제 요청
		deleteCall(null, '/allDelMyMenu', 'fnMyMenu');     	        
    }     
    
    /**
     * 나의 메뉴 삭제 성공시 이벤트
     */    
    function fnMyMenuSuccess(data){
    	// 에러메세지 처리
    	alertErrMsg(data);
    	
    	var strLi = ""; 
        for(var i in data.fields.myMenuList) {
            var upMenuCd = data.fields.myMenuList[i].UP_MENU_CD;
            var upMenuNm = data.fields.myMenuList[i].UP_MENU_NM;
            var menuCd = data.fields.myMenuList[i].MENU_CD;
            var menuNm = data.fields.myMenuList[i].MENU_NM;
            strLi  += "<li>                                                     ";
            strLi  += "<a href=\"#none\" onclick=\"goMenu('" + upMenuCd + "','" + upMenuNm + "','" + upMenuCd + "','" + menuCd + "');return false;\">" + menuNm + "</a>      ";
            strLi  += "    <button onclick=\"fnDelMyMenu('" + menuCd + "');return false;\" class=\"minus\"></button>             ";
            strLi  += "</li>                                                    ";
        }
        $("#myMenu").empty().append(strLi);
        
    	$(".tab_content").hide(); 
		$("ul.lnbtabs li").removeClass("active");
    	$("ul.lnbtabs li:last").addClass("active").show(); 
    	$(".tab_content:last").show(); 
		$("#tab2").fadeIn();
    }
    
    /**
     * 나의 메뉴 추가 실패시 이벤트
     */    
    function fnMyMenuFail(data){
    	// 에러메세지 처리
    	alertErrMsg(data);
    }     
    
    /**
     * 나의 메뉴 삭제
     */
    function fnDelMyMenu(menuCd){
        // parameter setting
        var params = { MENU_CD : menuCd };
		// 조회 요청
		deleteCall(null, '/delMyMenu', 'fnDelMyMenu', params);        
    }
    
    /**
     * 나의 메뉴 삭제 성공시 이벤트
     */    
    function fnDelMyMenuSuccess(data){
    	// 에러메세지 처리
    	alertErrMsg(data);
    	
    	var strLi = ""; 
        for(var i in data.fields.myMenuList) {
            var upMenuCd = data.fields.myMenuList[i].UP_MENU_CD;
            var upMenuNm = data.fields.myMenuList[i].UP_MENU_NM;
            var menuCd = data.fields.myMenuList[i].MENU_CD;
            var menuNm = data.fields.myMenuList[i].MENU_NM;
            strLi  += "<li>                                                     ";
            strLi  += "<a href=\"#none\" onclick=\"goMenu('" + upMenuCd + "','" + upMenuNm + "','" + upMenuCd + "','" + menuCd + "');return false;\">" + menuNm + "</a>      ";
            strLi  += "    <button onclick=\"fnDelMyMenu('" + menuCd + "');return false;\" class=\"minus\"></button>             ";
            strLi  += "</li>                                                    ";
        }
        $("#myMenu").empty().append(strLi);
    }
    
    /**
     * 나의 메뉴 삭제 실패시 이벤트
     */    
    function fnDelMyMenuFail(data){
    	// 에러메세지 처리
    	alertErrMsg(data);
    }      
    
    
    /**
     * 상단 대메뉴에서 진입시 업무 메뉴 재설정
     */    
    function fnRenderLnbMenuList(topMenuCd, topMenuNm, upMenuCd){
    	var strLi = "";
    	
    	
    	$("#lnbTitle").empty();
    	strLi = topMenuNm + "<a href=\"#none\" onclick=\"fnAddMyMenu();return false;\" class=\"menuplus\" data-tooltip-text=\"MY메뉴 추가\"></a>";
    	$("#lnbTitle").append(strLi);
    	strLi = "";
    	$("#lnbMenuList").empty();
    	
    	<c:forEach var="leftMenu" items="${LOGIN_INFO.SUB_MENU_MAP}" varStatus="status">
    		var displayYn = "${leftMenu.value.DISPLAY_YN}";
    		var topMenuNo = "${leftMenu.value.TOP_MENU_NO}";
    		if (displayYn == "Y" && topMenuNo == topMenuCd) {
            	
            	var menuCd    = "${leftMenu.value.MENU_CD}";
            	var upMenuCd  = "${leftMenu.value.UP_MENU_CD}";
            	var menuNm    = "${leftMenu.value.MENU_NM}";
            	
            	strLi  += "<li>";	
            	<c:if test="${leftMenu.value.CHILD_YN eq 'Y'}">
            		strLi  += "    <a href=\"#none\" id=\"${leftMenu.value.MENU_CD}\">" + menuNm + "</a>";
            	</c:if>
            	<c:if test="${leftMenu.value.CHILD_YN ne 'Y'}">
            		strLi  += "    <a href=\"#none\" onclick=\"goMenu('" + topMenuNo + "', '" + topMenuNm + "', '" + upMenuCd + "', '" + menuCd + "');return false;\">" + menuNm + "</a>";
            	</c:if>
            	strLi  += "    <ul class=\"lnb-sub\">";
            	<c:forEach var="subMenu" items="${leftMenu.value.SUB_CHILD_MENU_LIST}" varStatus="status">
            		<c:if test="${subMenu.DISPLAY_YN eq 'Y'}">
                		var subMenuCd    = "${subMenu.MENU_CD}";
                		var subMenuNm    = "${subMenu.MENU_NM}";            		
                		var subUpMenuCd  = "${subMenu.UP_MENU_CD}";
            			strLi  += "    <li><a href=\"#none\" onclick=\"goMenu('" + topMenuNo + "', '" + topMenuNm + "', '" + subUpMenuCd + "', '" + subMenuCd + "');return false;\">" + subMenuNm + "</a></li>";
            		</c:if>   
            	</c:forEach>
            	strLi  += "    </ul>";
            	strLi  += "</li>" ;
    		}
        </c:forEach>
        
        $("#lnbMenuList").append(strLi);
        
        //LNB 메뉴 event 설정
        fnEventMenu();
        
    }
    
    /**
     * 업무 메뉴 event 설정
     */    
    function fnEventMenu() {

	    var lnbUI = {
	    	click : function (target, speed) {
	      		var _self = this, $target = $(target);
	      		_self.speed = speed || 300;
	      
	      		$target.each(function(){
			
	        		if(findChildren($(this))) {
	          			return;
	        		}
	        		$(this).addClass('noDepth');
	      		});
	      
	      		function findChildren(obj) {
	        		return obj.find('> ul').length > 0;
	      		}
	      
	      		$target.on('click','a', function(e){		 
	          		e.stopPropagation();
			 
	          		var $this = $(this),
	                $depthTarget = $this.next(),
	                $siblings = $this.parent().siblings();
			
	        		$this.parent('li').find('ul li').removeClass('on');
	        		$siblings.removeClass('on');
	        		$siblings.find('ul').slideUp(250);
	        
	        		if($depthTarget.css('display') == 'none') {
	        			if ($depthTarget.children().length > 0) {
		          			_self.activeOn($this);
		          			$depthTarget.slideDown(_self.speed);
	        			}
	        		} else {
	          			$depthTarget.slideUp(_self.speed);
	          			_self.activeOff($this);
	        		}		
	      		})
	      
	    	},
	    	activeOff : function($target) {
	      		$target.parent().removeClass('on');
	    	},
	    	activeOn : function($target) {
	      		$target.parent().addClass('on');
	    	}
	  	};  
	
		// Call lnbUI
		$(function(){
			lnbUI.click('.lnb-menu li', 300)
		});
		
		if (!isEmpty(G_UP_MENU_CD)) {
			fnOnClickMenu();
			
		}
    }
    
    /**
     * 업무 메뉴 event 설정
     */    
    function fnOnClickMenu() {
  		var $this = $('a#' + G_UP_MENU_CD);
        var $depthTarget = $this.next();
        $siblings = $this.parent().siblings();

		$this.parent('li').find('ul li').removeClass('on');
		$siblings.removeClass('on');
		$siblings.find('ul').slideUp(250);

		if($depthTarget.css('display') == 'none') {
			if ($depthTarget.children().length > 0) {
				$this.parent().addClass('on');
      			$depthTarget.slideDown(300);
			}
		} else {
  			$depthTarget.slideUp(300);
  			$this.parent().removeClass('on');
		}    	
    }
    
    /**
     * 나의 메뉴 그리기
     */ 	
    function fnRenderMyMenu(){
        var strLi = ""; 
        <c:forEach var="myMenu" items="${LOGIN_INFO.MY_MENU}">
            var topMenuCd = "${myMenu.TOP_MENU_CD}";
            var topMenuNm = "${myMenu.TOP_MENU_NM}";
            var upMenuCd = "${myMenu.UP_MENU_CD}";
            var upMenuNm = "${myMenu.UP_MENU_NM}";
            var menuCd   = "${myMenu.MENU_CD}";
            var menuNm   = "${myMenu.MENU_NM}";
            strLi  += "<li>                                                     ";
            strLi  += "    <a href=\"#none\" onclick=\"goMenu('" + topMenuCd + "','"+topMenuNm+ "','" + upMenuCd +  "','"+ menuCd + "');return false;\">" + menuNm + "</a>      ";
            strLi  += "    <button onclick=\"fnDelMyMenu('" + menuCd + "');return false;\" class=\"minus\"></button>             ";
            strLi  += "</li>                                                    ";
        </c:forEach>
        $("#myMenu").empty().append(strLi);
    }
</script>
<ul class="lnbtabs">
	<li><a href="#tab1" class="menu01">업무메뉴</a></li>
	<li><a href="#tab2" class="menu02">MY메뉴</a></li>
</ul>

<div class="tab_container">
	<div id="tab1" class="tab_container">
		<div id="tab1" class="tab_content">
			<h2 id="lnbTitle" class="lnb_tit"><c:out value="${LOGIN_INFO.FIRST_MENU_NAME}" /><a href="#none" onclick="fnAddMyMenu();return false;" class="menuplus" data-tooltip-text="MY메뉴 추가"></a></h2>
			<ul id="lnbMenuList" class="lnb-menu">
	            <c:forEach var="leftMenu" items="${LOGIN_INFO.SUB_MENU_MAP}" varStatus="status">
                
                    <c:if test="${leftMenu.value.DISPLAY_YN eq 'Y' and leftMenu.value.TOP_MENU_NO eq LOGIN_INFO.FIRST_MENU_NO}">
                        <li>
                            <c:if test="${leftMenu.value.CHILD_YN eq 'Y'}">
                            	<a href="#none" id="${leftMenu.value.MENU_CD}"><c:out value="${leftMenu.value.MENU_NM}" /></a>
                            </c:if>
                            <c:if test="${leftMenu.value.CHILD_YN ne 'Y'}">
                            	<a href="#none" onclick="goMenu('${leftMenu.value.TOP_MENU_NO}', '${LOGIN_INFO.FIRST_MENU_NAME}', '${leftMenu.value.UP_MENU_CD}','${leftMenu.value.MENU_CD}');return false;"><c:out value="${leftMenu.value.MENU_NM}" /></a>
                            </c:if>                           
                             <ul class="lnb-sub">
                                 <c:forEach var="subMenu" items="${leftMenu.value.SUB_CHILD_MENU_LIST}" varStatus="status">
                                    <c:if test="${subMenu.DISPLAY_YN eq 'Y'}">
                                       <li><a href="#none" onclick="goMenu('${leftMenu.value.TOP_MENU_NO}', '${LOGIN_INFO.FIRST_MENU_NAME}', '${subMenu.UP_MENU_CD}', '${subMenu.MENU_CD}');return false;" ><c:out value="${subMenu.MENU_NM}" /></a></li>
                                    </c:if>    
                                </c:forEach>
                             </ul>
                        </li>
                    </c:if>
                </c:forEach>			
			</ul>
		</div>
	</div>
	<div id="tab2" class="tab_content type2">
		<h2 class="lnb_tit">MY메뉴 <a href="#none"  onclick="fnAllDelMyMenu();return false;" class="totaldel">전체삭제</a></h2>
		<ul id="myMenu" class="mymenu">
			
		</ul>
	</div>
</div>
