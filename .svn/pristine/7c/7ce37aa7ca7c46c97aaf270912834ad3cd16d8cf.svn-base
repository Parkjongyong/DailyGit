<%--
	File Name : wrhStorageSpaceMgmt.jsp
	Description: 입고예정 > 창고관리 > 창고공간
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.20  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.20
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<s:eval var="_dateUtil"               expression="T(com.app.ildong.common.util.DateUtil)"/>
<s:eval var="_unformat_today"         expression="_dateUtil.getToday()"/>
<s:eval var="_today"                  expression="_dateUtil.formatDate(_unformat_today, '-')"/>                  <%-- 포맷된 오늘날짜 --%>
<s:eval var="_getMonthFirstDay"       expression="_dateUtil.formatDate(_dateUtil.getMonthFirstDay(), '-')"/>     <%-- 포맷된 현재월 1일 --%>

<script type="text/javascript">
var gridView;
var firstDay; // 기준일
var nextDay;  // 가변일
var saveData = new Array();  // 창고여유공간 변경일
var eventsData;
var calendarEl;
var calendar;
var dataCnt = 0;
var reDate     = new Array();
var compCodes  = new Array();
var compLabels = new Array();
var btnYn      = "N";

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList    = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	var matTypeList = stringToArray("${CODELIST_IG002}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', getComboValue(compList, "CODE", 0));
    fnCompCdChange();
    fnMakeComboOption('SB_MAT_TYPE', matTypeList, 'CODE', 'CODE_NM', null, "", "전체");
    
	// 초기 상태값 처리
    fnInitStatus();
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    // 달력 생성
    fnCreateCal();
    
	$(".fc-prev-button").click(function() {
		if (isNullValue(nextDay)) {
			nextDay = firstDay;
		}
	    var newDt = new Date(nextDay); 
	    newDt.setMonth( newDt.getMonth() - 1 ); 
	    newDt.setDate( 1); 
	    nextDay = converDateString(newDt);
	    saveData = new Array();
	    // 조회
	    fnSearch();
	});
	
	$(".fc-next-button").click(function() {
		if (isNullValue(nextDay)) {
			nextDay = firstDay;
		}
	    var newDt = new Date(nextDay); 
	    newDt.setMonth( newDt.getMonth() + 1 ); 
	    newDt.setDate( 1); 
	    nextDay = converDateString(newDt);
	    saveData = new Array();
	    // 조회
	    fnSearch();
	});
	
	$(".fc-today-button").click(function() {
	    nextDay = firstDay;
	    saveData = new Array();
	    
	    // 조회
	    fnSearch();
	});
	
	//비밀번호 입력 Dialog
    $("#storage_dialog").dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:170, 
        width: 250, 
        close: function(event,ui) {
            $("#storage_dialog").dialog( "close" );
        }
    });	
	
});

function converDateString(dt){ 
	return dt.getFullYear() + "-" + addZero(eval(dt.getMonth()+1)) + "-" + addZero(dt.getDate()); 
}

function addZero(i){ 
	var rtn = i + 100; 
	return rtn.toString().substring(1,3); 
}

/**
 * 초기 설정
 */
function fnInitStatus() {
	firstDay = firstDayByMonth(getDiffDay("m",0,null));
}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
    
    fnPlantCdChange();
}

/**
 * 회사 코드 변경 이벤트
 */
function fnPlantCdChange() {
    var StorageList = stringToArray("${CODELIST_SYSSTR}", $("#SB_COMP_CD").val(), $("#SB_PLANT_CD").val());
    fnMakeComboOption('SB_STORAGE_CD', StorageList, 'CODE', 'CODE_NM');
}



/**
 * 조회
 */
function fnSearch() {
	
	if (isNullValue($('#SB_COMP_CD').val())) {
		alert("회사는 필수 입력 조건입니다.");
		return;
	}
	
	if (isNullValue($('#SB_PLANT_CD').val())) {
		alert("플랜트는 필수 입력 조건입니다.");
		return;
	}
	
	if (isNullValue($('#SB_STORAGE_CD').val())) {
		alert("입고장소는 필수 입력 조건입니다.");
		return;
	}
	
	if (isNullValue(nextDay)) {
		nextDay = firstDay;
	}	
	
	var params = {};
	$.extend(params, fnGetParams());	
	$.extend(params, {"YYYYMMDD":nextDay});
	
	// bg 클랙 사용한 모든 클랙스 삭제  
	$("[class*=bg]").each(function(){
		$(this).removeClass("bg")
	});
	
	// 조회 요청
	searchCall(null, '/com/wrh/selectWhrStorageSpaceMgmtList', null, params);
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	btnYn = data.fields.storageSpace[0].BTN_YN;
	if (!isNullValue(data.fields.storageSpace)) {
		dataCnt = data.fields.storageSpace.length;
		eventsData = new Array();
		reDate = data.fields.storageSpace;
		for (var i=0; i < reDate.length; i++) {
			var obj = reDate[i];
			if (   obj.DAYS_GUBN == '토'
				|| obj.DAYS_GUBN == '일'
				|| obj.DAYS_GUBN == '휴') {
				// pass
			} else {
				eventsData[eventsData.length] = {
					title     : obj.TITLE_TXT + "(" + nvl(obj.SUM_PLT_QTY,0) + ")" ,
					title_old : obj.TITLE_TXT_OLD,
					start     : obj.START_DATE,
					cnt       : obj.CNT
			   	};				
			}
				
		}
		
		calendar.removeAllEventSources();
		calendar.addEventSource(eventsData);		
		
		for (var i=0; i < reDate.length; i++) {
			var obj = reDate[i];
			// 토/일/휴는 이벤트 데이터는 누락
			if (   obj.DAYS_GUBN == '토'
				|| obj.DAYS_GUBN == '일'
				|| obj.DAYS_GUBN == '휴') {
				// 휴일인 경우는  요일 class를 휴일 class로 변경
				if (obj.DAYS_GUBN == '휴') {
					if (obj.DAYS_K == '월') {
						$("[data-date='" + obj.START_DATE + "']").removeClass('fc-day-mon');
					} else if (obj.DAYS_K == '화') {
						$("[data-date='" + obj.START_DATE + "']").removeClass('fc-day-tue');
					} else if (obj.DAYS_K == '화') {
						$("[data-date='" + obj.START_DATE + "']").removeClass('fc-day-wed');
					} else if (obj.DAYS_K == '화') {
						$("[data-date='" + obj.START_DATE + "']").removeClass('fc-day-thu');
					} else if (obj.DAYS_K == '화') {
						$("[data-date='" + obj.START_DATE + "']").removeClass('fc-day-fri');
					} else if (obj.DAYS_K == '화') {
						$("[data-date='" + obj.START_DATE + "']").removeClass('fc-day-sat');
					}
					$("[data-date='" + obj.START_DATE + "']").addClass('fc-day-hol');
				}
			} else {
				$("#TB-" + obj.START_DATE).click(function() {
					if(btnYn == "Y"){
			 	    	$("#storage_dialog").dialog("open");
			 	    	$("#TB_SRART").val(this.id.substring(3));
			 	    	$("#TB_TITLE").val($('#' + this.id).html().substring(0, $('#' + this.id).html().indexOf('(')));
			 	    	$("#TB_TITLE_OLD").val($('#' + this.id).html().substring(0, $('#' + this.id).html().indexOf('(')));
						
					} else {
						
					}
				});
				
				$("#IG-" + obj.START_DATE).click(function() {
		 			var rIndex = getComboIndex(reDate, "START_DATE", this.id.substring(3));
		 			if (rIndex > -1 && getComboValue(reDate, "CNT", rIndex) != "0") {
		 			    var params = fnGetParams();
		 			    $.extend(params, {"YYYYMMDD":this.id.substring(3)});
		 			    var target = "wrhStorageSpacePop";
		 			    var width  = "1070";
		 			    var height = "470";
		 			    var scrollbar = "yes";
		 			    var resizable = "yes";
					    
		 			    fnPostPopup('/com/wrh/wrhStorageSpacePop', params, target, width, height, scrollbar, resizable);
		 			}
				});					
			}
		}
	} else {
		dataCnt    = 0;
		reDate     = new Array();
		eventsData = new Array();
		calendar.removeAllEventSources();
		calendar.addEventSource(eventsData);
	}
	
	// 달력생성
	//fnCreateCal();	
}

//저장
function fnSave() {
	if(saveData.length == 0){
		alert("저장할 내역이 존재하지 않습니다.");
		return false;
	}

	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : saveData});
	
	// 필수 체크 후 저장 진행
     if(confirm("창고여유공간을 변경 하시겠습니까?")){
    	 saveCall(null, '/com/wrh/saveWhrStorageSpace', null, params);
     }
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("창고여유공간이 변경되었습니다.");
    // 저장할 내역 초기화
    saveData = new Array();
    // 자동조회
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
}

/**
 * 달력 생성 이벤트
 */
function fnCreateCal() {
	
	calendarEl = document.getElementById('calendar');
	calendar = new FullCalendar.Calendar(calendarEl, {
	  	editable: false,
	  	locale : "ko",
	  	selectable: true,
	  	businessHours: true,
	  	dayMaxEvents: true, // allow "more" link when too many events
	  	events: eventsData
	});
	
		

	calendar.setOption('height', '650px');
	calendar.render();
	
}

/**
 * title 변경 이벤트
 */
function fnChangeStorageSpace() {
	
	// 기등록된 데이터와 상이한 경우
	if (nvl($('#TB_TITLE_OLD').val(), '') != nvl($("#TB_TITLE").val(), '')) {
		saveData = new Array();
		saveData.push({"STRD_DATE" : $('#TB_SRART').val(), "STORAGE_SPACE" : $("#TB_TITLE").val()});
		fnSave();
	}
	$("#storage_dialog").dialog( "close" );
	
	
}

</script>
<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnCompCdChange();" >
	                    <option value="">전체</option>
	                    </select>
                    </td>
                    <th><span>플랜트</span></th>
                    <td>
	                    <select id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD" onchange="fnPlantCdChange();">
	                    <option value="">전체</option>
	                    </select>
                    </td>
					<th><span>입고장소</span></th>
                    <td>
	                    <select id="SB_STORAGE_CD" name="SB_STORAGE_CD" data-type="select" data-bind="selectedOptions: SB_STORAGE_CD">
	                    <option value="">전체</option>
	                    </select>
                    </td>
                    <td></td>
                </tr>            
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearch">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
    <br>
<div id='calendar'></div>
<!-- dialog-Pop : S -->
<div id="storage_dialog" title="창고여유공간 변경">
    <table class="tbl-view">
        <colgroup>
          <col style="width:100px;">
          <col style="width:120px;">
        </colgroup>
       <tbody>
            <tr>
                <th>창고여유공간</th>
                <td>
                	<input type="text" class="w100" id="TB_TITLE" value="" onkeypress="if(event.keyCode==13){fnChangeStorageSpace();}">
                	<input type="hidden" id="TB_TITLE_OLD" value="">
                	<input type="hidden" id="TB_SRART" value="">
                </td>
            </tr>       
      </tbody>
    </table>
    <br>
    <div align="center">
        <button type="button" class="btn" onClick="javascript:fnChangeStorageSpace();">변경</button>
    </div>
</div>