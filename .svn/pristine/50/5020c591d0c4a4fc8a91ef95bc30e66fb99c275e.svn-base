<%--
	File Name : wrhStorageSpaceM.jsp
	Description: 입고예정 > 창고관리 > 모바일창고
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
<%@ page import = "com.app.ildong.common.util.PropertiesUtil" %>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="<c:url value='/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.css'/>" rel="stylesheet"/>

<%-- <link href="<c:url value='/resources/plugin/assets/css/bootstrap.min.css'/>" rel="stylesheet" /> <!-- Bootstrap Styles--> --%>
<link href="<c:url value='/resources/plugin/assets/css/bootstrap.css'/>" rel="stylesheet" /> <!-- Bootstrap Styles-->
<link href="<c:url value='/resources/plugin/assets/css/font-awesome.css'/>" rel="stylesheet" /> <!-- FontAwesome Styles-->
<link href="<c:url value='/resources/plugin/assets/js/morris/morris-0.4.3.min.css'/>" rel="stylesheet" /> <!-- Morris Chart Styles-->
<link href="<c:url value='/resources/plugin/assets/js/Lightweight-Chart/cssCharts.css'/>" rel="stylesheet"> 
<link href="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mCustomScrollbar.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/plugin/jquery-multiselect/jquery.multiselect.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/plugin/poshytip-1.2/src/tip-yellow/tip-yellow.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/plugin/jquery.swiper/swiper.min.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/css/reset.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/css/custom.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/css/rgrid.css'/>" rel="stylesheet"/>
<link href="<c:url value='/resources/css/calendar.css'/>" rel="stylesheet"/>
        
<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.2.1.min.js'/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-migrate-1.4.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-migrate-3.0.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mousewheel.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mCustomScrollbar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-validation/jquery.validate.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-validation/localization/messages_ko.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-number-master/jquery.number.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-multiselect/jquery.multiselect.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/poshytip-1.2/src/jquery.poshytip.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery.swiper/swiper.min.js'/>"></script>

<%
 if(PropertiesUtil.isRealMode()){
%>
<!-- realGrid -->
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/realgridjs-lic.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/realgridjs.1.1.36.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/realgridjs-api.1.1.36.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/jszip.min.js'/>"></script>

<%
} else{
%>
<!-- realGrid -->
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/realgridjs-lic.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/realgridjs_eval.1.1.33.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/realgridjs-api.1.1.33.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/jszip.min.js'/>"></script>

<% 
}
%>

<script type="text/javascript" src="<c:url value='/resources/plugin/jquery.swiper/swiper.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/site_define.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/rgrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/rtgrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/calendar.js'/>"></script>

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
var gridView;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList    = stringToArray("${CODELIST_ST_COMP}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', getComboValue(compList, "CODE", 0));
    fnCompCdChange();
    
	// 초기 상태값 처리
    fnInitStatus();
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    // 달력 생성
    fnCreateCal();
    setInitGrid();
    
    $("#sub_page").hide();
    
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
	
});


//그리드 초기화 함수
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'VENDOR_NM',                    {text:'업체명'},                       70,     'text', {textAlignment: "near"});
    addField(cm,    'MAT_NUMBER',                   {text: '자재코드'},                     80,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_DESC',                     {text: '자재명'},                      80,     'text', {textAlignment: "near", textWrap : "normal"});
    addField(cm,    'ITEM_QTY',                     {text: '수량'},                        60,     'number', {textAlignment: "far"});
    addField(cm,    'PLT_CAL_QTY',                  {text: 'PLT수량'},                     60,     'number', {textAlignment: "far"});
	    
    //addField(cm,    'VENDOR_CD',                    {text:'업체코드'},                          55,     'text', {textAlignment: "center"});
//     addField(cm,    'GR_PERSON_NAME',               {text: '입고담당자'},                       65,     'text', {textAlignment: "center"});
//     addField(cm,    'GR_PERSON_TEL',                {text: '연락처'},                          80,     'text', {textAlignment: "center"});
    
    addField(cm,    'COMP_NM',                      {text:'회사'},                          100,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PLANT_CODE',                   {text: '플랜트'},                           60,     'text', {textAlignment: "center"},{visible:false});
    
    addField(cm,    'APPROVE_DOC_TXT',              {text: '승인자비고'},                    150,     'text', {textAlignment: "near"},{visible:false});
    addField(cm,    'CRUD',                         {text: 'CRUD'},                           0,     'text', {textAlignment: 'center'},  {visible:false});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_POP_WIDTH_S       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : false       //조회 건수 표시
    });
    
    gridView.setIndicator({
    	  visible: false  
    });
    
    gridView.setDisplayOptions({
  	  eachRowResizable:true,
  	});
    


}

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
    var plantList = stringToArray("${CODELIST_ST_PLANT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
    
    fnPlantCdChange();
}

/**
 * 회사 코드 변경 이벤트
 */
function fnPlantCdChange() {
    var StorageList = stringToArray("${CODELIST_ST_STORAGE}", $("#SB_COMP_CD").val(), $("#SB_PLANT_CD").val());
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
					title     : obj.TITLE_TXT + "(" + nvl(obj.SUM_PLT_QTY,0) + ")",
					title_old : obj.TITLE_TXT_OLD,
					start     : obj.START_DATE,
					cnt       : 0	//모바일은 이미지 필요없어서 주석으로 막음
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
		 	    	$("#TB_SRART").val(this.id.substring(3));
		 	    	$("#TB_TITLE").val($('#' + this.id).html().substring(0, $('#' + this.id).html().indexOf('(')));
		 	    	$("#TB_TITLE_OLD").val($('#' + this.id).html().substring(0, $('#' + this.id).html().indexOf('(')));
		 			var rIndex = getComboIndex(reDate, "START_DATE", this.id.substring(3));
		 			if (rIndex > -1 && getComboValue(reDate, "CNT", rIndex) != "0") {
// 		 			    var params = fnGetParams();
// 		 			    $.extend(params, {"YYYYMMDD":this.id.substring(3)});
// 		 			    var target = "wrhStorageSpacePop";
// 		 			    var width  = "1070";
// 		 			    var height = "470";
// 		 			    var scrollbar = "yes";
// 		 			    var resizable = "yes";
// 		 			    var url = "/com/wrh/wrhStorageSpacePop.do?SB_COMP_CD="+params.SB_COMP_CD+"&SB_PLANT_CD="+params.SB_PLANT_CD+"&SB_STORAGE_CD="+params.SB_STORAGE_CD+"&YYYYMMDD="+this.id.substring(3);
// 		 			    var target = "wrhStorageSpacePop";
// 		 			    window.open(url, "_blank", "toolbar=no,scrollbars=yes,resizable=yes,width=900,height=900");
		 			    var params = fnGetParams();
		 			    $.extend(params, {"YYYYMMDD"  :this.id.substring(3)});
		 			   $("#sub_page").show();
		 			   $("#main_page").hide();
		 			   searchCall(gridView, '/com/wrh/wrhStorageSpacePopList', 'fnSearchD', params);
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

function fnSearchDSuccess(data) {
	//$("#gridView").show();
	gridView.clearRows();
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();
    
    gridView.fitRowHeightAll(0, true);
	
}


function detailClose() {
	// 그리드 초기화
    gridView.clearRows();
	$("#main_page").show();
	$("#sub_page").hide();

}

</script>
<div id = "main_page" data-role="page">
<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col>
                <col>
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
                    <td></td>
                </tr>            
                <tr>
                    <th><span>플랜트</span></th>
                    <td>
	                    <select id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD" onchange="fnPlantCdChange();">
	                    <option value="">전체</option>
	                    </select>
                    </td>
                    <td></td>
                </tr>            
                <tr>
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
	<div class="tbl-search-btn" style="width:60px;">
		<button class="btn-search" id="btnSearch" style="width:55px;">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
    <br>
<div id='calendar'></div>
</div>
<style type="text/css">
.fc-daygrid-block-event .fc-event-time,
  .fc-daygrid-block-event .fc-event-title {
    padding: 0 80px 0px 0px;
    cursor: pointer;
    border: antiquewhite;
    font-size: 12px;
  }
  .fc-calendar-img {background:url('../../../../resources/images/common/ico_calendar_off.png') no-repeat top 0 right 0px;  background-size:0px; }
</style>

<div class="realgrid-area" id="sub_page" data-role="page">
    <div class="tbl-search-wrap">
    <div class="tbl-search-area">
	<div class="tbl-search-btn" style="width:60px; float: right;">
		<button class="btn-search" id="btnSearch" style="width:55px;" onclick="detailClose()" >닫기</button>
	</div>
	</div>
	</div>			    
    <div id="gridView"></div>
</div>
