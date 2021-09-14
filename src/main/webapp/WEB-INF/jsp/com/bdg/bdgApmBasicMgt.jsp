<%--
	File Name : bdgApmBasicMgt.jsp
	Description:예산 > 영업관리 > APM예산신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.28  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.28
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var statusCodes  = new Array();
var statusLabels = new Array();
var chcCtcCodes  = new Array();
var chcCtcLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var statusList  = stringToArray("${CODELIST_YS010}");
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");

	var etcGubnList  = stringToArray("${CODELIST_YS012}");
	fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList,     'CODE', 'CODE_NM', null);

	statusCodes  = getComboSet('${CODELIST_YS010}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS010}', 'CODE_NM');
	
	chcCtcCodes  = getComboSet('${CODELIST_YS012}', 'CODE');
	chcCtcLabels = getComboSet('${CODELIST_YS012}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_ORG_NM").val('${LOGIN_INFO.DEPT_NM}');
	$("#TB_ORG_CD").val('${LOGIN_INFO.DEPT_CD}');
	$("#SB_CHC_ETC_GBN").val('${LOGIN_INFO.ETC_CHC_GUBN}');

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '진행상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'CHC_ETC_GBN',          {text:'부문'},       60,            'text',              {textAlignment:"center"},{lookupDisplay: true,values:chcCtcCodes,labels:chcCtcLabels, editable: false},'dropDown');
    addField(cm,    'REQ_ORG_CD',           {text:'부서코드'},        80,            'text',              {textAlignment:"center"});
    addField(cm,    'REQ_ORG_NM',           {text:'부서명'},  100,            'text',           {textAlignment:"near"});
    addField(cm,    'REQ_SABUN',            {text:'사원코드'},      100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},         15,     'popupLink');
    addField(cm,    'REQ_SABUN_NM',         {text:'사원명'},      60,            'text',           {textAlignment:"center"});
    
//     addField(cm,    'PRE_BAL_AMT',         {text:' '},        100,            'number',           {textAlignment:"far"});
//     addField(cm,    'TERM_BUGT_AMT',       {text:'당기예산'},        100,            'number',           {textAlignment:"far"});
//     addField(cm,    'TERM_TRANS_SEND_AMT', {text:'당기이관송신액'},        100,            'number',           {textAlignment:"far"});
//     addField(cm,    'TERM_TRANS_RECV_AMT', {text:'당기이관수신액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'TERM_USE_AMT',        {text:'당월사용액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'BAL_AMT',             {text:'당월잔액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'NEW_BUGT_AMT',        {text:'신규예산'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'MAKE_ID',             {text:'작성자'},        60,            'text',           {textAlignment:"center"});
    addField(cm,    'MAKE_DATE',           {text:'작성일자'},        80,            'text',           {textAlignment:"center"});
    addField(cm,    'CANCEL_REASON',       {text:'취소사유'},        250,            'text',           {textAlignment:"near"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트센터'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    //addField(cm,    'PRE_BAL_AMT',          {text: '전월잔액'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'CARD_NO',              {text: '카드번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'BANK_KEY',             {text: '은행키'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ACC_NO',               {text: '계좌번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP전송여부'},     0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SYS_MGMT_NO',          {text: '시스템관리번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });


    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
       		fnSearchUser();
       	}

    };
    
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn = values.STATUS;
        if (gubn == '1' || gubn == '5') {
            styles.editable = true;
            styles.background = "#d5e2f2";
        } else {
        	styles.editable = false;
        }

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };        
    
    setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
	gridView.setColumnProperty("NEW_BUGT_AMT"  , "dynamicStyles", columnDynamicStyles);

	gridView.setOptions({sortMode:"explicit"});
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectApmBasicMgt');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();
    
//     var header1 = gridView.getColumnProperty("PRE_BAL_AMT", "header");
//     if(((toNumber($('#TB_CRTN_YYMM').val().substring(5,7)) -1) == 0)){
//     	header1.text = 11 + "월";
//     } else if(((toNumber($('#TB_CRTN_YYMM').val().substring(5,7)) -2) == 0)){
//     	header1.text = 12 + "월";
//     } else {
//     	header1.text = (toNumber($('#TB_CRTN_YYMM').val().substring(5,7)) -2)+ "월";
//     }
    
//     gridView.setColumnProperty("PRE_BAL_AMT", "header", header1);
    
//     var header2 = gridView.getColumnProperty("BAL_AMT", "header");
//     if(((toNumber($('#TB_CRTN_YYMM').val().substring(5,7)) -1) == 0)){
//     	header2.text = 12 + "월";
//     } else {
//     	header2.text = (toNumber($('#TB_CRTN_YYMM').val().substring(5,7)) -1)+ "월";
//     }
    
//     gridView.setColumnProperty("BAL_AMT", "header", header2);
    
    // 모든 데이터가 작성중인 경우만 버튼 활성화
//     if (data.fields.check.CNT == "0") {
//     	$('#btnReceive').show();
//     } else {
//     	$('#btnReceive').hide();
//     }
}


//행추가
function fnRowAdd() {
	var values = { "CRUD" : "I" 
	              ,"STATUS" : "1"
	              ,"CHC_ETC_GBN" : $('#SB_CHC_ETC_GBN').val()
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replaceAll('-', '')
	              ,"ORG_CD" : $('#TB_ORG_CD').val()
	              ,"CODEMAPPING1" : "1"
	              };
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

//승인요청
var fnAppr = function(){
	gridView.commit();
	if(gridView.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_008"}); // 양식키
	$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
	$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
	$.extend(params, {"MANAGER_YN"    : "N"}); // 본부장표시여부
	$.extend(params, {"REVIEW_ORG_CD" : ""}); // 처리부서코드
	//$.extend(params, {"BGT_URL"   : "http://192.168.110.76/com/bdg/bdgApmBasicMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_DEPT_NM=" + $('#TB_DEPT_NM').val() + "&TB_DEPT_CD=" + $('#TB_DEPT_CD').val()}); // 팝업 url
	//$.extend(params, {"BGT_BUS_URL"   : "http://192.168.110.76/com/bdg/bdgApmBasicMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141"}); // 처리로직  url
	if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
		$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgApmBasicMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgApmBasicMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141"}); // 처리로직  url
	} else {
		$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgApmBasicMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgApmBasicMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141"}); // 처리로직  url
	}
	
	$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
	$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
	//$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
    if(confirm("승인요청 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/apprApmBasicMgt', 'fnAppr', params);
    }
	
}

function fnApprFail(result) {
	alert(result.errMsg);
}

function fnApprSuccess(data) {
	//alert("승인요청 되었습니다.");
	gridView.clearRows();
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key"          : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : data.fields.result.EPS_FORM_ID}); //양식key
	 	$.extend(params, {"empno"        : data.fields.result.SABUN}); // 기안자
	 	$.extend(params, {"deptcd"       : data.fields.result.ORG_CD}); //기안자 부서코드
	 	$.extend(params, {"geMangerYn"   : 'N'}); //본부장 표시여부
	 	$.extend(params, {"reqDeptcd"    : ''}); //처리부서코드
	 	$.extend(params, {"systemUrl"    : data.fields.result.BGT_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //popup_url
	 	$.extend(params, {"businessUrl"  : data.fields.result.BGT_BUS_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //business_url
	 	$.extend(params, {"systemName"   : '전사시스템'}); //시스템이름
	 	$.extend(params, {"subject"      : ''}); //제목
	 	$.extend(params, {"status"       : '2'}); //상태코드
	 	
// 	 	var htmlTag = "<!DOCTYPE html>";
// 	 	htmlTag += "<html lang='ko'>";
// 	 	htmlTag += "<head>";
// 	 	htmlTag += "<meta charset='UTF-8'>";
// 	 	htmlTag += "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>";
// 	 	htmlTag += "<style>";
// 	 	htmlTag += ".tit-area{overflow:hidden;position:relative;padding:18px 0 13px;}";
// 	 	htmlTag += ".tbl-view{width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;}";
// 	 	htmlTag += ".tbl-view tbody th{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;background-color:#f1f2f6;text-align:left;}";
// 	 	htmlTag += ".tbl-view tbody td{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;}";
// 	 	htmlTag += "</style>";
// 	 	htmlTag += "</head>";
	 	
// 	 	htmlTag += "<body>";
// 	 	htmlTag += "<div class='tit-area' style='padding:15px;'>";
// 	 	htmlTag += "<div>";
// 	 	htmlTag += "<h3>APM예산신청</h3>";
// 	 	htmlTag += "</div>";
// 	    htmlTag += "<div class='tbl-search-wrap'>";
// 	    htmlTag += "<div class='tbl-search-area'>";
// 	    htmlTag += "<table class='tbl-search'>";
// 	    htmlTag += "<colgroup>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";	    
// 	    htmlTag += "<col>";
// 	    htmlTag += "</colgroup>";
// 	    htmlTag += "<tbody>";
// 	    htmlTag += "<tr>";
// 	    htmlTag += "<th><span>회사</span></th>";
// 	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
// 	    htmlTag += "<th><span>년월</span></th>";
// 	    htmlTag += "<td>" + $('#TB_CRTN_YYMM').val() + "</td>";
// 	    htmlTag += "<th><span>부서</span></th>";
// 	    htmlTag += "<td>" + $('#TB_DEPT_NM').val() + "</td>";
// 	    htmlTag += "<td></td>";
// 	    htmlTag += "</tr>";
// 	    htmlTag += "</tbody>";
// 	    htmlTag += "</table>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "<div class='pop-cont'>";
// 	    htmlTag += "<div class='pop-cont'>";
// 	    htmlTag += "<table class='tbl-view'>";
// 	    htmlTag += "<colgroup>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:150px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "</colgroup>";
// 	    htmlTag += "<tbody>";
// 	    htmlTag += "<tr>";
// 	    htmlTag += "<th style='text-align:center'>계정코드</th>";
// 	    htmlTag += "<th style='text-align:center'>계정명</th>";
// 	    htmlTag += "<th style='text-align:center'>당기기본예산</th>";
// 	    htmlTag += "<th style='text-align:center'>산정추정</th>";
// 	    htmlTag += "<th style='text-align:center'>예산추정</th>";
// 	    htmlTag += "<th style='text-align:center'>집행율</th>";
// 	    htmlTag += "<th style='text-align:center'>합계</th>";
// 	    htmlTag += "<th style='text-align:center'>예산증감율</th>";
// 	    htmlTag += "<th style='text-align:center'>산정증감율</th>";
// 	    htmlTag += "<th style='text-align:center'>예상증감율</th>";
// 	    htmlTag += "</tr>";
	    
// 	    for (var i=0 ; i < gridHeader.getRowCount(); i++) {
// 	    	htmlTag += "<tr>";
// 	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_NO") + "</td>";
// 	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_DESC") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "A_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "B_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "PRESUME_AMT") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "D_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "C_SUM") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "A_RATE") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "B_RATE") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "C_RATE") + "</td>";
// 	    	htmlTag += "</tr>";
// 	    }
	    
// 	    htmlTag += "</tbody>";
// 	    htmlTag += "</table>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "</body>";
// 	    htmlTag += "</html>";
	    
// 	    $.extend(params, {"HTMLBody" : htmlTag}); //본문 데이터
	 	
	 	// 새로운 tab으로 전자결재 시스템 활성화
		//fnPostGoto("http://epsdev.ildong.com/approval/legacy/goFormLink", params, "GW");
	    
		var target    = "goFormLink";
		var width     = "1200";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	    //fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
	    if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
			fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		} else {
			fnPostPopup('https://eps.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		}
	}
	
	fnSearch();
}


// 확정
var fnConfirm = function(){
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});

	if(isEmpty(params.ITEM_LIST.CHECK_LIST)){
		alert("확정할 대상이 없습니다.");
		return false;
	}

	if(isNotEmpty(params.ITEM_LIST.CREATED)){
		alert("작성 후 가능합니다.");
		return false;
	}

	for(var i = 0; i < params.ITEM_LIST.CHECK_LIST.length; i++){
		if(params.ITEM_LIST.CHECK_LIST[i].STATUS != '5'){
			alert("재작성요청 건만 확정 가능합니다.");
			return false;
		}
	}

	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_SABUN", "NEW_BUGT_AMT"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("확정 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/confirmApmBasicMgt', 'fnConfirm', params);
	     }
	}
}

function fnConfirmSuccess(data) {
	alert("확정 되었습니다.");
	fnSearch();

}

function fnConfirmFail(result) {
	alert(result.errMsg);
}


/**
 * 저장
 */
function fnSave() {
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	if(gridView.getCheckedItems(false).length == 0){
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
		if(params.ITEM_LIST.UPDATED[i].STATUS != '1' && params.ITEM_LIST.UPDATED[i].STATUS != '5'){
			alert("작성중, 재작성요청 데이터만 저장 가능합니다.");
			return false;
		}
	}

	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_ORG_CD", "REQ_SABUN", "NEW_BUGT_AMT"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveApmBasicMgt', null, params);
	     }
	}

}

function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	fnSearch();

}

function fnSaveFail(result) {
	alert(result.errMsg);
}


/**
 * 삭제
 */
function fnDelete() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(isEmpty(params.ITEM_LIST)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
		if(params.ITEM_LIST.DELETED[i].STATUS != '1'){
			alert("작성중 상태만 삭제 가능합니다.");
			return false;
		}
	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delApmBasicMgt', 'fnDel', params);
	}

}

/**
 * 삭제 성공
 */
function fnDelSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

/**
 * 삭제 실패
 */
function fnDelFail(result) {
	alert(result.errMsg);
}	

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}


/**
 * 부서 조회
 */
function fnSearchDept(str) {
	paramGubn = str;
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnDeptSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/deptList', params, target, width, height, scrollbar, resizable);
}

/**
 * 부서 콜백
 */
function fnCallbackDeptSearchPop(rows) {
	$("#TB_ORG_CD").val(rows.DEPT_CD);
	$("#TB_ORG_NM").val(rows.DEPT_NM);
}

/**
 * 사원 조회
 */
function fnSearchUser() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_NM" :  $("#SB_COMP_CD option:selected").text()});
	
	var target    = "cmnUserSearchPop";
	var width     = "1200";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 사원 콜백
 */
 function fnCallbackPop(rows) {
	var values = {
	         "REQ_SABUN"   : rows.USER_ID,
	         "REQ_SABUN_NM"   : rows.USER_NM,
	         "REQ_ORG_NM"   : rows.DEPT_NM,
	         "REQ_ORG_CD"   : rows.DEPT_CD,
	         "CCTR_CD"      : rows.CCTR_CD
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);

}

//예산잔액수신
function fnReceive() {
	gridView.commit();
 	var params = {};
 	var preYear  = toNumber($("#TB_CRTN_YYMM").val().substring(0,4));
 	// 당월 데이터 추출로 로직 변경(이지예사원이 최종적으로 회의끝에 결론이라고 함 2020.12.23)
 	//var preMonth = toNumber($("#TB_CRTN_YYMM").val().substring(5,7)) - 1;
 	//preMonth     = (preMonth > 9) ? preMonth : "0" + preMonth;
 	//var preYM    = (preMonth == 0) ? preYear -1 + "12" :  preYear +  preMonth.toString(); 
 	$.extend(params, fnGetParams());
 	//$.extend(params, {"CRTN_YYMM" : preYM});
 	$.extend(params, {"CRTN_YYMM" : $("#TB_CRTN_YYMM").val()});
 	
     if(confirm("예산잔액수신 시 작성중인 데이터는 초기화 됩니다. 예산잔액수신  하시겠습니까?")){
     	saveCall(gridView, '/com/bdg/ReceiveApmBasicMgt', 'fnReceive', params);
     }
 }

 function fnReceiveSuccess(data) {
 	alert("예산잔액수신 되었습니다.");
 	fnSearch();
 }

 function fnReceiveFail(result) {
 	alert("예산잔액수신 실패 하였습니다.");
 }
</script>
<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:480px">
                <col style="width:70px">
                <col style="width:480px">
                <col style="width:70px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD">
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:90px;"/>
                    </td>
                    <th><span>부서</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" disabled>
                        <input type="hidden" id="TB_ORG_CD">
<!--                         <a href="javascript:fnSearchDept('condition');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>진행상태</span></th>
                    <td>
                        <select id="SB_STATUS" name="SB_STATUS">
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
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 15px;">(단위 : 원)</th>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnReceive">예산잔액수신</button>
        <button type="button" class="btn" id="btnAppr">승인요청</button>
        <button type="button" class="btn" id="btnConfirm">확정</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>