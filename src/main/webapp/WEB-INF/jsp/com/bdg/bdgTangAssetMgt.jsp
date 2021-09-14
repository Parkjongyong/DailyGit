<%--
	File Name : bdgTangAssetMgt.jsp
	Description: 예산 > 예산관리 > 유형자산투자계획신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.20 길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.20
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridHeader;
var gridDetail;
var gridTotal;
var investGaolCodes  = new Array();
var investGaolLabels = new Array();
var assetClassCodes  = new Array();
var assetClassLabels = new Array();
var fundGubnCodes  = new Array();
var fundGubnLabels = new Array();
var useYnCodes  = new Array();
var useYnLabels = new Array();

var nextDeptCodes  = new Array();

var rowIndex     = "";
var addCnt       = 0;

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,  'CODE', 'CODE_NM');
	
	fnCompCdChange();
	
	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");

	nextDeptCodes = getComboSet('${CODELIST_YS039}', 'CODE');
	
	investGaolCodes  = getComboSet('${CODELIST_YS002}', 'CODE');
	investGaolLabels = getComboSet('${CODELIST_YS002}', 'CODE_NM');
	
	assetClassCodes  = getComboSet('${CODELIST_YS003}', 'CODE');
	assetClassLabels = getComboSet('${CODELIST_YS003}', 'CODE_NM');	
	
	fundGubnCodes    = getComboSet('${CODELIST_YS004}', 'CODE');
	fundGubnLabels   = getComboSet('${CODELIST_YS004}', 'CODE_NM');	
	
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	setInitGridTotal();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YY").val(getDiffDay("y",1).substring(0,4));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'STATUS_NM',            {text:'승인상태'},       60,            'text',              {textAlignment:"center"});
    addField(cm ,   'BFR_CRTN_YN',          {text:'전년도 자산여부'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    addField(cm ,   'INVEST_GOAL',          {text:'투자목적'},      80,             'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:investGaolCodes, labels:investGaolLabels}, 'dropDown');
    addField(cm,    'INVEST_NO',            {text:'투자번호'},        100,            'textLink',            {textAlignment:"center"});
    addField(cm,    'BUSIN_TITLE',          {text:'사업명'},         100,            'text',           {textAlignment:"center"});
    addField(cm ,   'ASSET_CLASS',          {text:'자산유형'},      80,             'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:assetClassCodes, labels:assetClassLabels}, 'dropDown');
    addField(cm,    'CCTR_CD',              {text:'코스트센터'},        100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코스트센터명'},        100,            'text',           {textAlignment:"near"});
    addField(cm,    'CAPITAL_DATE',         {text:'자본화일자'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm ,   'FUND_GUBUN',           {text:'자금유형'},      80,             'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:fundGubnCodes, labels:fundGubnLabels}, 'dropDown');
    addField(cm ,   'CONST_ACC_YN',         {text:'건설가계정'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    addField(cm ,   'TERM_YN',              {text:'당기완료'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    
    addField(cm,    'DATA_GUBN',            {text: '데이터구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP전송여부'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_YMD',             {text: '전송일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'DEL_FLAG',             {text: '삭제구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridHeader.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 250       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    

    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
        if (data.fieldName == "INVEST_NO") {
        	
        	var temp = fnGetGridRowParams(gridHeader, data.itemIndex);
        	
        	if (temp.DATA_GUBN == "D1") {
            	rowIndex = data.itemIndex;
            	// 상세조회
            	fnSearchDetail(data.itemIndex);
        	}
        }
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.DATA_GUBN;
        var status = values.STATUS;
        if (gubn == 'D1' && (status == '1' || status == '3')) {
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.DATA_GUBN;
        var status = values.STATUS;
        var crud = values.CRUD;
        if (gubn == 'D1' && status == '1' && crud == 'I') {
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDateStyles = function(grid, index, value) {
        var styles = {};
        
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.DATA_GUBN;
        var status = values.STATUS;
        if (gubn == 'D1' && (status == '1' || status == '3')) {
        	styles.editable = true;
        	styles.border = "#88888888,1";
        	styles.borderBottom = "#ff999999,1";
        	styles.borderRight = "#ff999999,1";
        	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"};
        } else {
        	styles = disibleColStyle;
        }
        return styles;
    };    
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };      
    
    gridHeader.setColumnProperty("INVEST_GOAL"  , "dynamicStyles", columnDynamicStyles);
    gridHeader.setColumnProperty("BUSIN_TITLE"  , "dynamicStyles", columnDynamicStyles);
    gridHeader.setColumnProperty("ASSET_CLASS"  , "dynamicStyles", columnDynamicStyles);
    gridHeader.setColumnProperty("FUND_GUBUN"   , "dynamicStyles", columnDynamicStyles);
    gridHeader.setColumnProperty("CONST_ACC_YN" , "dynamicStyles", columnDynamicStyles);
    gridHeader.setColumnProperty("TERM_YN"      , "dynamicStyles", columnDynamicStyles);
    gridHeader.setColumnProperty("CAPITAL_DATE" , "dynamicStyles", columnDateStyles);
    gridHeader.setColumnProperty("BFR_CRTN_YN"  , "dynamicStyles", columnDynamicStyles2);
    
    
    gridHeader.setColumnProperty("STATUS_NM"    , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("INVEST_NO"    , "dynamicStyles", columnDefaultStyles);  
    gridHeader.setColumnProperty("CCTR_CD"      , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("CCTR_NM"      , "dynamicStyles", columnDefaultStyles);
    

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    	if (field == 10 && newValue == 'N') {
    		gridHeader.setRowValue( itemIndex, "TERM_YN", "Y");
    	}
    };
    
    fnGridSortFalse(gridHeader);
    gridHeader.setDisplayOptions({columnMovable:false});
    
}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];

    addField(cm,    'HJ_GUBUN_NM',             {text:'구분'},       60,            'text',              {textAlignment:"center"});
    addField(cm,    'WK_M01',               {text:'1월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},       100,            'integer',       {textAlignment:"far"});  
    addField(cm,    'SUM_HALF1',            {text:'상반기계'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'SUM_HALF2',            {text:'하반기계'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'SUM_TOTAL',            {text:'계'},           100,            'integer',       {textAlignment:"far"});
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'HJ_GUBUN',             {text: '구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'INVEST_NO',            {text: '투자번호'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BFR_CRTN_YN',          {text: '전년도 구분'},       0,     'text', {textAlignment: "center"},{visible:false});

    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 100       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridDetail.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	var curr = grid.getCurrent();
    	var values = grid.getValues(curr.itemIndex);
        var editable = false;
        if (newRow === -1 && curr.itemIndex > -1) {
            editable = true;
        } else if (newRow === -1 && curr.itemIndex === -1) {
            editable = false;
        } else {
            if (grid.getRowState(curr.itemIndex) === "created") {
                editable = true;
            }
        }
        
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var status = values.STATUS;
        if (status == '1' || status == '3') {
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var status = values.STATUS;
        var gubn = values.BFR_CRTN_YN;
        if (status == '1' || status == '3') {
        	if (gubn == "Y") {
        		styles = disibleColStyle;
        	} else {
        		styles = enableColStyle;
        	}
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };    
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };        
    
    gridDetail.setColumnProperty("WK_M01"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M02"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M03"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M04"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M05"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M06"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M07"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M08"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M09"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M10"  , "dynamicStyles", columnDynamicStyles2);
    gridDetail.setColumnProperty("WK_M11"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M12"  , "dynamicStyles", columnDynamicStyles);
    
    gridDetail.setColumnProperty("HJ_GUBUN"   , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("SUM_HALF1"  , "dynamicStyles", columnDefaultStyles);  
    gridDetail.setColumnProperty("SUM_HALF2"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("SUM_TOTAL"  , "dynamicStyles", columnDefaultStyles);
    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	var values = grid.getValues(itemIndex);
    	gridDetail.setValue(itemIndex, "SUM_HALF1", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06));    	
    	gridDetail.setValue(itemIndex, "SUM_HALF2", toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
    	gridDetail.setValue(itemIndex, "SUM_TOTAL", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06) + toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
    	gridDetail.checkItem(dataRow, true);
    };
    
    //paste 시 합계 자동 계산
    gridDetail.onRowsPasted = function(grid, items){
    	for(var i = 0; i < items.length; i++){
    		var values = grid.getValues(items[i]);
    		gridDetail.setValue(items[i], "SUM_HALF1", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06));
    		gridDetail.setValue(items[i], "SUM_HALF2", toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
    		gridDetail.setValue(items[i], "SUM_TOTAL", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06) + toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
    		gridDetail.checkItem(items[i], true);
    	}
    };
    
    fnGridSortFalse(gridDetail);
    gridDetail.setDisplayOptions({columnMovable:false});    
}

function setInitGridTotal() {
    var gridId = "gridTotal";
    gridTotal = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'HJ_GUBUN_NM',          {text:'구분'},       60,            'text',              {textAlignment:"center"});
    
    addField(cm,    'WK_M01',               {text:'1월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},       100,            'integer',       {textAlignment:"far"});  
    addField(cm,    'SUM_HALF1',            {text:'상반기계'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'SUM_HALF2',            {text:'하반기계'},       100,            'integer',       {textAlignment:"far"});
    addField(cm,    'SUM_TOTAL',            {text:'계'},           100,            'integer',       {textAlignment:"far"});
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'HJ_GUBUN',             {text: '구분코드'},       0,     'text', {textAlignment: "center"},{visible:false});

    gridTotal.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 100       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    
    fnGridSortFalse(gridTotal);
    gridTotal.setDisplayOptions({columnMovable:false});     
    
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectTangAssetMgtHeadList');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	addCnt = 0;
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	if(isEmpty(data.fields.result)){
		gridTotal.clearRows();
	} else {
		gridTotal.clearRows();
		// 그리고 데이터 setting
	    gridTotal.setPageRows(data.fields.result);
	    // 상태바 비활성화
	    gridTotal.closeProgress();		
		
	}
	

	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
	    // 상태바 비활성화
	    gridHeader.closeProgress();	
	    
	    // 상세 조회
	    fnSearchDetail(rowIndex);
	} else {
		gridDetail.clearRows();
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridHeader.clearRows();
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
	    // 상태바 비활성화
	    gridHeader.closeProgress();	
	    
	    rowIndex = "";
	}
	
}

/**
 * 조회 후 처리
 */
function fnSearchDetailSuccess(data) {
	if(isEmpty(data.rows)){
		gridDetail.clearRows();
	}
	
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridDetail.clearRows();
	// 그리고 데이터 setting
    gridDetail.setPageRows(data);
    // 상태바 비활성화
    gridDetail.closeProgress();
    
    if (data.rows == 0) {
    	
    	var temp = fnGetGridRowParams(gridHeader, rowIndex);
    	var value1 = { "CRUD" : "I"
    		,"HJ_GUBUN" : "H"
    		,"HJ_GUBUN_NM" : "회계"
		    ,"DATA_GUBN" : "D1"
		    ,"STATUS" : "1"
		    ,"COMP_CD" : temp.COMP_CD
			,"CRTN_YY" : temp.CRTN_YY
			,"CCTR_CD" : temp.CCTR_CD
			,"INVEST_NO" : temp.INVEST_NO
			,"BFR_CRTN_YN" : temp.BFR_CRTN_YN
		};
    	var value2 = { "CRUD" : "I"
  		  	,"HJ_GUBUN" : "J"
  		  	,"HJ_GUBUN_NM" : "자금"
		    ,"DATA_GUBN" : "D1"
		    ,"STATUS" : "1"
		    ,"COMP_CD" : temp.COMP_CD
		    ,"CRTN_YY" : temp.CRTN_YY
			,"CCTR_CD" : temp.CCTR_CD
			,"INVEST_NO" : temp.INVEST_NO	
			,"BFR_CRTN_YN" : temp.BFR_CRTN_YN
		};    	
		fnAddRow(gridDetail, value1, gridDetail.getRowCount());
		fnAddRow(gridDetail, value2, gridDetail.getRowCount());
    }
    
}


//저장
var fnSave = function(){
	gridHeader.commit();
	gridDetail.commit();
	
	// Detail 필수 체크
	for(var i = 0; i < gridHeader.getAllRows().length; i++){
		
		var temp = fnGetGridRowParams(gridHeader, i);
		
		if (temp.STATUS == '1' || temp.STATUS == '3') {
			continue;
		} else {
			alert("[작성중/반려] 상태에서만 수정이 가능합니다.");
			return false;				
		}
	}
	
	if(gridDetail.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("저장 할 상세데이터가 존재하지 않습니다. 확인 후 작업하세요.");
		return false;
	}	
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["INVEST_GOAL", "BUSIN_TITLE", "ASSET_CLASS", "CCTR_CD", "FUND_GUBUN"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridHeader, requiredVal, true) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
			var params = {};
			$.extend(params, {"HEAD_LIST"   : fnGetGridCheckData(gridHeader)});
			
			// 그리드 전체 데이터를 수집하기 윟 전체 체크박스 선택 처리
			for(var i = 0; i < gridDetail.getRowCount(); i++){
				gridDetail.checkItem(i, true);
			}				
			$.extend(params, {"DETAIL_LIST" : fnGetSaveAllData(gridDetail)});
			$.extend(params, fnGetParams());
			
			saveCall(gridHeader, '/com/bdg/saveTangAssetMgt', 'fnSave', params);
		}
	}
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridDetail.closeProgress();
    fnSearch();
}

// /**
//  * 저장 실패
//  */
function fnSaveFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridDetail.closeProgress();
}

/**
 * 유형자산투자계획상세
 */
function fnSearchDetail(rIndex) {
	
	if (rIndex <= gridHeader.getRowCount()-1) {
		var params = fnGetGridRowParams(gridHeader, rIndex);
		$.extend(params, fnGetParams());
		searchCall(gridDetail, '/com/bdg/selectTangAssetDetailList', 'fnSearchDetail', params);		
	} else {
		gridDetail.clearRows();
	}
}

//행추가
function fnRowAdd() {
	
	if (addCnt > 0) {
		alert("자산투가계획관리는 회계/자금입력으로 인해 한 건씩만 등록이 가능합니다. 기등록 작업을 완료 후 추가하십시오.");
		return false;
	} else {
		addCnt = addCnt + 1;
	}
	var values = { "CRUD" : "I" 
			      ,"DATA_GUBN" : "D1"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YY" : $('#TB_CRTN_YY').val()
			      ,"CCTR_CD" : $('#SB_CCTR_CD').val()
			      ,"CCTR_NM" : $("#SB_CCTR_CD option:selected").text()
			      ,"STATUS_NM" : "작성중"
			      ,"STATUS" : "1"
			      ,"INVEST_NO" : "XXXXXXX"
			      ,"BFR_CRTN_YN" : "N"
			      ,"SAP_SEND_YN" : "N"
			      };
	fnAddRow(gridHeader, values, gridHeader.getRowCount());
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridHeader);
}

//승인요청
var fnAppr = function(){
	gridHeader.commit();
	gridDetail.commit();
	
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_005"}); // 양식키
	$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
	$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
	$.extend(params, {"geMangerYn"    : 'N'}); //본부장 표시여부
 	if ('${LOGIN_INFO.DEPT_CD}' == nextDeptCodes[0]) {
 		$.extend(params, {"reqDeptcd" : ""}); //처리부서코드
 	} else {
 		$.extend(params, {"reqDeptcd" : nextDeptCodes[0]}); //처리부서코드	
 	}
	//$.extend(params, {"BGT_URL"     : "http://192.168.110.76/com/bdg/bdgTangAssetMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG119" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YY=" + $('#TB_CRTN_YY').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}'}); // 팝업 url
	//$.extend(params, {"BGT_BUS_URL" : "http://192.168.110.76/com/bdg/bdgTangAssetMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG119"}); // 처리로직  url
	if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
		$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgTangAssetMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG119" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YY=" + $('#TB_CRTN_YY').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}' + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgTangAssetMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG119"}); // 처리로직  url
	} else {
		$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgTangAssetMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG119" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YY=" + $('#TB_CRTN_YY').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}' + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgTangAssetMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG119"}); // 처리로직  url
	}
	$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
	$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
	//$.extend(params, {"ITEM_LIST"     : fnGetSaveData(gridView)});
	
     if(confirm("승인요청 하시겠습니까?")){
    	 saveCall(gridHeader, '/com/bdg/apprTangAssetMgt', 'fnAppr', params);
     }
	
}

function fnApprSuccess(data) {
	//alert("승인요청 되었습니다.");
	gridDetail.clearRows();
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key" : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : "WF_LINK_005"}); //양식key
	 	$.extend(params, {"empno" : '${LOGIN_INFO.USER_ID}'}); // 기안자
	 	$.extend(params, {"deptcd" : '${LOGIN_INFO.DEPT_CD}'}); //기안자 부서코드
	 	$.extend(params, {"geMangerYn" : 'N'}); //본부장 표시여부
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
	 	htmlTag += "<h3>유형자산투자계획신청</h3>";
	 	htmlTag += "</div>";
	    htmlTag += "<div class='tbl-search-wrap'>";
	    htmlTag += "<div class='tbl-search-area'>";
	    htmlTag += "<table class='tbl-search'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:150px'>";  
	    htmlTag += "<col>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th><span>회사 : </span></th>";
	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
	    htmlTag += "<th><span>년도 : </span></th>";
	    htmlTag += "<td>" + $('#TB_CRTN_YY').val() + "</td>";
	    htmlTag += "<th><span>코스트센터 : </span></th>";
	    htmlTag += "<td>" + $("#SB_CCTR_CD option:selected").text()+ "</td>";
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
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th style='text-align:center'>코드</th>";
	    htmlTag += "<th style='text-align:center'>사업명</th>";
	    htmlTag += "<th style='text-align:center'>자산유형</th>";
	    htmlTag += "<th style='text-align:center'>상반기</th>";
	    htmlTag += "<th style='text-align:center'>하반기</th>";
	    htmlTag += "<th style='text-align:center'>합계</th>";
	    htmlTag += "</tr>";
	    
	    for (var i=0 ; i < data.fields.apprList.length; i++) {
	    	htmlTag += "<tr>";
	    	htmlTag += "<td style='text-align:center'>" + data.fields.apprList[i].INVEST_NO + "</td>";
	    	htmlTag += "<td style='text-align:left'>"   + nvl(data.fields.apprList[i].BUSIN_TITLE, '') + "</td>";
	    	htmlTag += "<td style='text-align:center'>" + nvl(data.fields.apprList[i].ASSET_CLASS, '') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].SUM_HALF1), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].SUM_HALF2), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(data.fields.apprList[i].SUM_TOTAL), '0') + "</td>";
	    	htmlTag += "</tr>";
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

// //삭제
function fnDelete() {
	
	gridHeader.commit();
	
	// Detail 필수 체크
	for(var i = 0; i < gridHeader.getAllRows().length; i++){
		
		var temp = fnGetGridRowParams(gridHeader, i);
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만 삭제가능합니다.");
			return false;				
		}
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridHeader)});
	
	if(fnDeleteCheck(gridHeader) == true){
		deleteCall(gridHeader, '/com/bdg/deleteTangAssetData', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
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
                <col style="width:70px">
                <col style="width:400px">
                <col style="width:120px">
                <col style="width:480px">
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
                    <th><span>년도</span></th>
                    <td>
                    	<input type="number" id="TB_CRTN_YY"  style="width: 50px; text-align: center" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" onchange="fnSearch();">
	                    </select>
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
        <button type="button" class="btn" id="btnAppr">승인요청</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>

<div class="realgrid-area">
    <div id="gridHeader"></div> 
</div>
<div class="sub-tit">
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 15px;">* 합계</th>
	        	<td></td>
	        </tr>
		</table>
	</div>
</div>

<div class="realgrid-area">
    <div id="gridTotal"></div> 
</div>
