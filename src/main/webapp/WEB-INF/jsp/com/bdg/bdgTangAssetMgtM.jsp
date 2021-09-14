<%--
	File Name : bdgTangAssetMgtM.jsp
	Description: 예산 > 예산관리 > 유형자산투자계획관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.21 길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.21
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
var nextYear     = getDiffDay("y",1).substring(0,4);

var rowIndex     = "";
var addCnt       = 0;

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList    = stringToArray("${CODELIST_SYS001}","ALL");
	var sapSendList = stringToArray("${CODELIST_E102}");
	fnMakeComboOption('SB_COMP_CD'    , compList,   'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_SAP_SEND_YN', sapSendList,'CODE', 'CODE_NM', null, "","전체");

	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
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
	$("#SB_SAP_SEND_YN").val('N');

}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm ,   'SAP_SEND_YN',          {text:'전송여부'},      60,             'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels}, 'dropDown');
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
    addField(cm ,   'CONST_ACC_YN',         {text: '건설가계정'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    addField(cm ,   'TERM_YN',              {text: '당기완료'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    
    addField(cm,    'DATA_GUBN',            {text: '데이터구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},       0,     'text', {textAlignment: "center"},{visible:false});
    //addField(cm,    'SAP_SEND_YN',          {text: 'SAP전송여부'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_YMD',             {text: '전송일'},           0,     'text', {textAlignment: "center"},{visible:false});

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
            	
            	$("#SB_CCTR_CD").val(gridView.getValue(data.itemIndex,"CCTR_CD"));
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
//         if (gubn == 'D1' && (status == '1' || status == '3')) {
//         	styles = enableColStyle;
//         } else {
//         	styles = disibleColStyle;
//         }
        styles = enableColStyle;

        return styles;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.DATA_GUBN;
        var status = values.STATUS;
        var crud = values.CRUD;
//         if (gubn == 'D1' && status == '1' && crud == 'I') {
//         	styles = enableColStyle;
//         } else {
//         	styles = disibleColStyle;
//         }
        styles = enableColStyle;

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDateStyles = function(grid, index, value) {
        var styles = {};
        
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.DATA_GUBN;
        var status = values.STATUS;
//		if (gubn == 'D1' && (status == '1' || status == '3')) {
//         	styles.editable = true;
//         	styles.border = "#88888888,1";
//         	styles.borderBottom = "#ff999999,1";
//         	styles.borderRight = "#ff999999,1";
//         	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"};
//         } else {
//         	styles = disibleColStyle;
//         }
        
    	styles.editable = true;
    	styles.border = "#88888888,1";
    	styles.borderBottom = "#ff999999,1";
    	styles.borderRight = "#ff999999,1";
    	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"};
    	
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
    gridHeader.setColumnProperty("SAP_SEND_YN"  , "dynamicStyles", columnDefaultStyles);
    

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    	if (field == 9 && newValue == 'N') {
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
//         if (status == '1' || status == '3') {
//         	styles = enableColStyle;
//         } else {
//         	styles = disibleColStyle;
//         }
		styles = enableColStyle;
        return styles;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var status = values.STATUS;
        var gubn = values.BFR_CRTN_YN;
//         if (status == '1' || status == '3') {
//         	if (gubn == "Y") {
//         		styles = disibleColStyle;
//         	} else {
//         		styles = enableColStyle;
//         	}
//         } else {
//         	styles = disibleColStyle;
//         }
        
		styles = enableColStyle;     

        return styles;
    };    
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };        
    
    gridDetail.setColumnProperty("WK_M01"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M02"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M03"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M04"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M05"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M06"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M07"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M08"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M09"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("WK_M10"  , "dynamicStyles", columnDynamicStyles);
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
    addField(cm,    'HJ_GUBUN',              {text: '구분코드'},       0,     'text', {textAlignment: "center"},{visible:false});

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
		
// 		if (temp.STATUS == '1' || temp.STATUS == '3') {
// 			continue;
// 		} else {
// 			alert("[작성중/반려] 상태에서만 수정이 가능합니다.");
// 			return false;				
// 		}
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
    //fnSearch();
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
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트센터는 필수입니다.");
		return false;
	}
	
	if (addCnt > 0) {
		alert("자산투가계획관리는 회계/자금입력으로 인해 한 건씩만 등록이 가능합니다. 기등록 작업을 완료 후 추가하십시오,");
		return false;
	} else {
		addCnt = addCnt + 1;
	}
	var values = { "CRUD" : "I" 
			      ,"DATA_GUBN" : "D1"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YY" : $('#TB_CRTN_YY').val()
			      ,"CCTR_CD" : $('#SB_CCTR_CD').val()
			      ,"CCTR_NM" : $("#TB_CCTR_NM").val()
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

// //삭제
function fnDelete() {
	
	gridHeader.commit();
	
	// Detail 필수 체크
	for(var i = 0; i < gridHeader.getAllRows().length; i++){
		
		var temp = fnGetGridRowParams(gridHeader, i);
		
// 		if (temp.STATUS == '1') {
// 			continue;
// 		} else {
// 			alert("[작성중] 상태에서만 삭제가능합니다.");
// 			return false;				
// 		}
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

//반려
var fnReject = function(){
	gridHeader.commit();
	var params = {};
	$.extend(params, fnGetParams());
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트코드는 필수입니다.");
		return false;
	}	
	
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("반려 할 데이터가 존재하지 않습니다. 조회 후 진행하십시오.");
		return false;
	}	
	
	// Detail 필수 체크
// 	for(var i = 0; i < gridHeader.getAllRows().length; i++){
		
// 		var temp = fnGetGridRowParams(gridHeader, i);
		
// 		if (temp.STATUS == '5') {
// 			continue;
// 		} else {
// 			alert("[승인완료] 상태에서만  반려 가능합니다.");
// 			return false;				
// 		}
// 	}
	
	$.extend(params, {"STATUS" : "1"});
	//$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
    if(confirm("반려 하시겠습니까?")){
    	saveCall(gridHeader, '/com/bdg/rejectTangAssetMgtStatus', 'fnReject', params);
    }
	
}

function fnRejectSuccess(data) {
	alert("반려되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnRejectFail(result) {
	alert(result.errMsg);
}


//내년만 가능
function fnCheckYear() {
	if($("#TB_CRTN_YY").val() != nextYear){
		alert(nextYear + "년도만 가능합니다.");
		return false;
	}
}

//SAP 전송
var fnSap = function(){
	gridHeader.commit();
	
// 	if(fnCheckYear() == false){
//		return false;
//	}	
	
// 	if(gridHeader.getSelectedItems().length == 0){
// 		alert("SAP 전송할 데이터가 존재하지 않습니다. 확인 후 작업하세요.");
// 		return false;
// 	}	
	var params = {};
	$.extend(params, fnGetParams());
	//$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridHeader)});
	
    if(confirm("전송 하시겠습니까?")){
    	saveCall(gridHeader, '/com/bdg/sendSapTangAssetData', 'fnSap', params);
    }
	
}

function fnSapSuccess(data) {
	alert("SAP전송 되었습니다.");
}

function fnSapFail(result) {
	alert(result.errMsg);
}

/**
 * 부서 조회
 */
function fnSearchDept() {
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
 * 코스트 조회
 */
function fnSearchCctr() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnCctrSearchPop";
	var width     = "900";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/cctrList', params, target, width, height, scrollbar, resizable);
}

/**
 * 코스트 콜백
 */
function fnCallbackPop(rows) {
	$("#SB_CCTR_CD").val(rows.CCTR_CD);
	$("#TB_CCTR_NM").val(rows.CCTR_NM);
	fnSearch();
}

//코스트 리셋
function fnCctrReset() {
	$("#SB_CCTR_CD").val("");
	$("#TB_CCTR_NM").val("");
	fnSearch();
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
                <col style="width:400px">
                <col style="width:120px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCctrReset();">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
                    	<input type="number" id="TB_CRTN_YY"  style="text-align: center; width: 50px" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_CCTR_NM" disabled="disabled">
                        <input type="hidden" id="SB_CCTR_CD">
                        <a href="javascript:fnSearchCctr();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <th><span>전송여부</span></th>
                    <td>
	                    <select id="SB_SAP_SEND_YN" name="SB_SAP_SEND_YN" onchange="fnSearch();">
	                    </select>
                    </td>                    
                    <td></td>
                </tr>
                <tr>
                    <th><span>승인상태</span></th>
                    <td>
	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <td></td>
                    <td></td>
					<td></td>
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
        <button type="button" class="btn" id="btnSap">SAP전송</button>
        <button type="button" class="btn" id="btnReject">반려</button>
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
