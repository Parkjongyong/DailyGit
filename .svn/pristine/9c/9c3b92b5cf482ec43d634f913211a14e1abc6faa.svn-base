<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 추가예산신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.20  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.20
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var apprCodes  = new Array();
var apprLabels = new Array();

var processTypeCodes  = new Array();
var processTypeLabels = new Array();

var nextDeptCodes  = new Array();

var processType  = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM');
	
	fnCompCdChange();

	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
	nextDeptCodes = getComboSet('${CODELIST_YS039}', 'CODE');
	
	apprCodes  = getComboSet('${CODELIST_YS001}', 'CODE');
	apprLabels = getComboSet('${CODELIST_YS001}', 'CODE_NM');

	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	

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
	$("#TB_CRTN_YMD").val(getDiffDay("y",0));
	//fnSearch();

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '승인상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:apprCodes,labels:apprLabels, editable:false},'dropDown');
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'text',              {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',  	    {text: ' '},    15,     'popupLink');
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'BUGT_BASIC_AMT',       {text:'당월기본예산'},  100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_EXEC_AMT',        {text:'배정실행예산'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_RESULT_AMT',      {text:'현재실적'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_BALANCE_AMT',     {text:'실행잔액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REQUEST_AMT',          {text:'신청액'},    100,            'integer',           {textAlignment:"far"});
    addField(cm,    'CODEMAPPING2',  	    {text: '상세내역'},    50,     'popupLink');
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트센터'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PROCESS_TYPE',         {text: '등록구분'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP 전송여부'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'REQUEST_DESC',         {text: '추가예산내역'},        0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_4       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
    	var temp = gridView.getValues(colIndex.itemIndex);
       	$("#TB_REQUEST_DESC").val(temp.REQUEST_DESC);
    	
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
        	fnSearchAccount();
       	}
       	
       	if(colIndex.fieldName == "CODEMAPPING2"){
       		if (gridView.getValue(colIndex.itemIndex,"CRUD") == 'I') {
    			alert("상세내역은 저장후 사용 가능합니다. 등록 후 작업하세요.");
    			return false;
       		} else {
       			if (gridView.getValue(colIndex.itemIndex, "ACCOUNT_NO") != "0055004040") {
        			alert("여비교통비/국내출장 계장만 등록 및 조회 가능합니다. 확인 후 작업하세요.");
        			return false;      				
       			} else {
       				fnSearchDetail(colIndex);	
       			}
       		}
       	}       	
    };

    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
        // 동적 스타일 적용
        var columnDynamicStyles = function(grid, index, value) {
            var styles = {};
            var values = grid.getValues(index.itemIndex);
            var gubn   = values.CRUD;
            var processType = values.PROCESS_TYPE;
            var status = values.STATUS;
            if (gubn == 'I') {
            	styles = enableColStyle;
            } else {
            	if (processType == "2") {
            		styles = disibleColStyle;
            	} else {
                    if (status == '1' || status == '3') {
                    	styles = enableColStyle;
                    } else {
                    	styles = disibleColStyle;
                    }
            	}
            }
            return styles;
        };
        
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
            return disibleColStyle;
        };        
        
        setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
        gridView.setColumnProperty("REQUEST_AMT"  , "dynamicStyles", columnDynamicStyles);
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
 
    fnGridSortFalse(gridView);
    gridView.setDisplayOptions({columnMovable:false})
}


/**
 * 조회
 */
function fnSearch() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"TB_CRTN_YMD_I" : $('#TB_CRTN_YMD').val()});
	
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectSupplement', null, params);
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
    if(data.rows.length > 0){
    	$("#TB_REQUEST_DESC").val(data.rows[0].REQUEST_DESC);
    }
}



/**
 * 상세내역 조회
 */
function fnSearchDetail(data) {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_NM" : $("#SB_COMP_CD option:selected").text()});
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	var target    = "bdgSupplementDetail";
	var width     = "1200";
	var height    = "720";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgSupplementDetail', params, target, width, height, scrollbar, resizable);
}




/**
 * 계정 조회
 */
function fnSearchAccount() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ACCOUNT_GUBN" : "S"});
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/accountSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 계정 콜백
 */
function fnCallbackAccountSearchPop(rows) {
	var values = {
	         "ACCOUNT_NO"   : rows.ACCOUNT_NO 
	        ,"ACCOUNT_DESC" : rows.ACCOUNT_DESC
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);
	$("#TB_ACCOUNT_NO").val(rows.ACCOUNT_NO);
	
	searchCall(gridView, '/com/bdg/selectSupplementAmt', 'fnSetAmt');
}

//행추가
function fnRowAdd() {
	for(var i = 0; i < gridView.getRowCount(); i++){
		if(gridView.getRowValue(i,"STATUS") == "2" || gridView.getRowValue(i,"STATUS") == "3" || gridView.getRowValue(i,"STATUS") == "5"){
			alert("기등록된 승인데이터가 존재합니다.");
			return false;
		}
	}

	var values = { "CRUD" : "I" 
	              ,"STATUS" : "1"
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YMD" : $('#TB_CRTN_YMD').val().replaceAll('-', '')
	              ,"CCTR_CD" : $('#SB_CCTR_CD').val()
	              ,"CCTR_NM" : $("#SB_CCTR_CD option:selected").text()
	              ,"SAP_SEND_YN" : "N"	              
	              ,"PROCESS_TYPE" : "1"
	              ,"CODEMAPPING1" : "1"};
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

// 승인요청
var fnAppr = function(){
	gridView.commit();
	if(gridView.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	for(var i = 0; i < gridView.getRowCount(); i++){
		if(gridView.getRowValue(i,"STATUS") == "2" || gridView.getRowValue(i,"STATUS") == "3" || gridView.getRowValue(i,"STATUS") == "5"){
			alert("기등록된 승인데이터가 존재합니다.");
			return false;
		}
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_004"}); // 양식키
	$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
	$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
	$.extend(params, {"geMangerYn"    : 'N'}); //본부장 표시여부
 	if ('${LOGIN_INFO.DEPT_CD}' == nextDeptCodes[0]) {
 		$.extend(params, {"reqDeptcd" : ""}); //처리부서코드
 	} else {
 		$.extend(params, {"reqDeptcd" : nextDeptCodes[0]}); //처리부서코드	
 	}
	//$.extend(params, {"BGT_URL"     : "http://192.168.110.76/com/bdg/bdgSupplementPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG117" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}'}); // 팝업 url
	//$.extend(params, {"BGT_BUS_URL" : "http://192.168.110.76/com/bdg/bdgSupplementEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG117"}); // 처리로직  url
	if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
		$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgSupplementPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG117" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}' + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgSupplementEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG117"}); // 처리로직  url
	} else {
		$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgSupplementPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG117" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}' + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgSupplementEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG117"}); // 처리로직  url
	}
	$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
	$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
	//$.extend(params, {"ITEM_LIST"     : fnGetSaveData(gridView)});
	
	
     if(confirm("승인요청 하시겠습니까?")){
    	 saveCall(gridView, '/com/bdg/apprSupplement', 'fnAppr', params);
     }
}

function fnApprSuccess(data) {
	//alert("승인요청 되었습니다.");
	gridView.clearRows();
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key" : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : "WF_LINK_004"}); //양식key
	 	$.extend(params, {"empno" : '${LOGIN_INFO.USER_ID}'}); // 기안자
	 	$.extend(params, {"deptcd" : '${LOGIN_INFO.DEPT_CD}'}); //기안자 부서코드
		$.extend(params, {"geMangerYn"    : 'N'}); //본부장 표시여부
	 	if ('${LOGIN_INFO.DEPT_CD}' == nextDeptCodes[0]) {
	 		$.extend(params, {"reqDeptcd" : ""}); //처리부서코드
	 	} else {
	 		$.extend(params, {"reqDeptcd" : nextDeptCodes[0]}); //처리부서코드	
	 	}
	 	$.extend(params, {"systemUrl"   : data.fields.result.BGT_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //popup_url
	 	$.extend(params, {"businessUrl" : data.fields.result.BGT_BUS_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //business_url
	 	$.extend(params, {"systemName" : '전사시스템'}); //시스템이름
	 	//$.extend(params, {"attachFiles" : ''}); //첨부파일
	 	$.extend(params, {"subject" : ''}); //제목
	 	$.extend(params, {"status" : '2'}); //상태코드
	 	
	 	var htmlTag = "<!DOCTYPE html>";
	 	htmlTag += "<html lang='ko'>";
	 	htmlTag += "<head>";
	 	htmlTag += "<meta charset='UTF-8'>";
	 	htmlTag += "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>";
	 	htmlTag += "<style>";
	 	htmlTag += ".tit-area{overflow:hidden;position:relative;padding:18px 0 13px;}";
	 	htmlTag += ".tbl-view{width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;}";
	 	htmlTag += ".tbl-view tbody th{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;background-color:#f1f2f6;text-align:left;}";
	 	htmlTag += ".tbl-view tbody td{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;}";
	 	htmlTag += "</style>";
	 	htmlTag += "</head>";
	 	
	 	htmlTag += "<body>";
	 	htmlTag += "<div class='tit-area' style='padding:15px;'>";
	 	htmlTag += "<div>";
	 	htmlTag += "<h3>추가예산신청</h3>";
	 	htmlTag += "</div>";
	    htmlTag += "<div class='tbl-search-wrap'>";
	    htmlTag += "<div class='tbl-search-area'>";
	    htmlTag += "<table class='tbl-search'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:150px'>";      
	    htmlTag += "<col>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th><span>회사 : </span></th>";
	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
	    htmlTag += "<th><span>작성일자 : </span></th>";
	    htmlTag += "<td>" + $('#TB_CRTN_YMD').val() + "</td>";
	    htmlTag += "<th><span>코스트센터 : </span></th>";
	    htmlTag += "<td>" + $("#SB_CCTR_CD option:selected").text() + "</td>";
	    htmlTag += "<td></td>";
	    htmlTag += "</tr>";
	    htmlTag += "</tbody>";
	    htmlTag += "</table>";
	    htmlTag += "</div>";
	    htmlTag += "</div>";
	    htmlTag += "<div class='pop-cont'>";
	    htmlTag += "<div class='pop-cont'>";
	    htmlTag += "<table class='tbl-view'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>계정코드</th>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>예산세목</th>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>기본예산</th>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>실행예산</th>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>현재실적</th>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>추가예산</th>";
	    htmlTag += "<th rowspan='2' style='text-align:center'>추정실적</th>";
	    htmlTag += "<th colspan='2' style='text-align:center'>당기 월평균</th>";
	    htmlTag += "<th colspan='2' style='text-align:center'>전기 월평균</th>";
	    htmlTag += "</tr>";
	    htmlTag += "<tr>";
	    htmlTag += "<th style='text-align:center'>실적</th>";
	    htmlTag += "<th style='text-align:center'>증감율</th>";
	    htmlTag += "<th style='text-align:center'>실적</th>";
	    htmlTag += "<th style='text-align:center'>증감율</th>";
	    htmlTag += "</tr>";	    
	    
	    if (isNotEmpty(data.fields.apprList)) {
		    for (var i=0 ; i < data.fields.apprList.length; i++) {
		    	htmlTag += "<tr>";
		    	htmlTag += "<td style='text-align:center'>" + data.fields.apprList[i].ACCOUNT_NO + "</td>";
		    	htmlTag += "<td style='text-align:center'>" + data.fields.apprList[i].ACCOUNT_DESC + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].BUGT_BASIC_AMT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].BUGT_EXEC_AMT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].BUGT_RESULT_AMT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].REQUEST_AMT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].CHUJUNG_AMT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].N_RESULT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].N_RATE), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].P_RESULT), '0') + "</td>";
		    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].P_RATE), '0') + "</td>";
		    	htmlTag += "</tr>";
		    }	    	
	    }
	    
	    htmlTag += "</tbody>";
	    htmlTag += "</table>";
	    htmlTag += "</div>";
	    htmlTag += "</body>";
	    htmlTag += "</html>";
	    
	    $.extend(params, {"HTMLBody" : htmlTag}); //본문 데이터
	 	
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

function fnApprFail(result) {
	alert(result.errMsg);
}

function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	fnSearch();

}

function fnSaveFail(result) {
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
	
	if(gridView.getSelectedItems().length == 0){
		alert("저장 할 데이터가 존재하지 않습니다.");
		return false;
	}	
	
	if(isNotEmpty(params.ITEM_LIST.UPDATED)){
		for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
			if(params.ITEM_LIST.UPDATED[i].STATUS == '2' || params.ITEM_LIST.UPDATED[i].STATUS == '3' || params.ITEM_LIST.UPDATED[i].STATUS == '5'){
				alert("작성중, 반려인 건만 저장 가능합니다.");
				return false;
			}
			
			if(params.ITEM_LIST.UPDATED[i].PROCESS_TYPE == '2'){
				alert("경영예산추가신청은 저장 불가합니다.");
				return false;
			}			
		}
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ACCOUNT_NO", "REQUEST_AMT"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
	    	 saveCall(gridView, '/com/bdg/saveSupplement', null, params);
	     }
	}

}


/**
 * 삭제
 */
function fnDelete() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(isEmpty(params.ITEM_LIST.DELETED.length)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
		if(params.ITEM_LIST.DELETED[i].STATUS == '2' || params.ITEM_LIST.DELETED[i].STATUS == '3' || params.ITEM_LIST.DELETED[i].STATUS == '5'){
			alert("작성중, 반려인 건만 삭제 가능합니다.");
			return false;
		}
		
		if(params.ITEM_LIST.DELETED[i].PROCESS_TYPE == '2'){
			alert("경영예산추가신청은 삭제 불가합니다.");
			return false;
		}		
	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delSupplement', 'fnDel', params);
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

//작성일자 체크
function fnCheckDate() {
	if($("#TB_CRTN_YMD").val().substring(0,7) < getDiffDay("m",-1).substring(0,7)){
		alert("작성일자는 전월까지 가능합니다.");
		$("#TB_CRTN_YMD").val(getDiffDay("y",0));
	} else {
		fnSearch();
	}
}

//당월기본예산, 배정실행예산, 현재실적, 실행잔액 세팅
function fnSetAmtSuccess(data) {
	var curr = gridView.getCurrent().itemIndex;
	if(isNotEmpty(data.rows[0]) == true){
		gridView.setValue(curr, "BUGT_BASIC_AMT",   data.rows[0].BUGT_BASIC_AMT);
		gridView.setValue(curr, "BUGT_EXEC_AMT",    data.rows[0].BUGT_EXEC_AMT);
		gridView.setValue(curr, "BUGT_RESULT_AMT",  data.rows[0].BUGT_RESULT_AMT);
		gridView.setValue(curr, "BUGT_BALANCE_AMT", data.rows[0].BUGT_BALANCE_AMT);
	}
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
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
                <col style="width:90px">
                <col style="width:460px">
                <col style="width:120px">
                <col style="width:430px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();">
	                    </select>
                    </td>
                    <th><span>작성일자</span></th>
                    <td>
						<input type="text" class="datepicker" id="TB_CRTN_YMD"  value="" style="width:90px;" onchange="fnCheckDate()"/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" onchange="fnSearch();">
	                    </select>
                        <input type="hidden" id="TB_ACCOUNT_NO">
                    </td>
                    <th><span>승인상태</span></th>
                    <td>
	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" onchange="fnSearch();">
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
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnAppr">승인요청</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
<table class="tbl-view">
	<colgroup>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th><span>추가예산내역<br></span></th>
			<td>
				<textarea rows="2" id="TB_REQUEST_DESC"></textarea>
			</td>
		</tr>
	</tbody>
</table>