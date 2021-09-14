<%--
	File Name : bdgTangAssetMgt.jsp
	Description: 예산 > 예산관리 > 유형자산투자계획신청(EPS)
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

var apprCnt      = "1";
var rowIndex     = "";

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,  'CODE', 'CODE_NM');
	
	fnCompCdChange();

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
    
    var epsDocNo = '${PARAM.EPS_DOC_NO}';
    if(isNotEmpty(epsDocNo) == true){
    	$("#EPS_DOC_NO").val(epsDocNo);
    	fnSearch();
    }

});

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
}

/**
 * 초기 설정
 */
function fnInitStatus() {
	
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	fnCompCdChange();
	$("#TB_CRTN_YY").val('${PARAM.TB_CRTN_YY}');
	$("#SB_CCTR_CD").val('${PARAM.SB_CCTR_CD}');
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
    addField(cm,    'CCTR_CD',              {text:'코스트코드'},        100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코스트명'},        100,            'text',           {textAlignment:"near"});
    addField(cm,    'CAPITAL_DATE',         {text:'자본화일자'},        100,            'text',           {textAlignment:"center"});
    addField(cm ,   'FUND_GUBUN',           {text:'자금유형'},      80,             'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:fundGubnCodes, labels:fundGubnLabels}, 'dropDown');
    addField(cm ,   'CONST_ACC_YN',         {text: '건설가계정'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    addField(cm ,   'TERM_YN',              {text: '당기완료'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    
    addField(cm,    'DATA_GUBN',            {text: '데이터구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP전송여부'},       0,     'text', {textAlignment: "center"},{visible:false});
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
    
    setDefaultStyle(gridHeader, "dynamicStyles",columnDefaultStyles);

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
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };        
    
    setDefaultStyle(gridDetail, "dynamicStyles",columnDefaultStyles);

    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
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
	
	if (apprCnt == "0") {
		alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
		return false;			
	}		
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectTangAssetMgtHeadListPop');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	
	//$("#TB_CRTN_YY").val(data.rows[0].CRTN_YY);
	//$("#SB_COMP_CD").val(data.rows[0].COMP_CD);
	//$("#SB_CCTR_CD").val(data.rows[0].CCTR_CD);

	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	if (isNotEmpty(data.fields.epsInfo.CNT)) {
		apprCnt = data.fields.epsInfo.CNT;
		if (data.fields.epsInfo.CNT == "0") {
			alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
			return false;			
		}
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
		};    	
		fnAddRow(gridDetail, value1, gridDetail.getRowCount());
		fnAddRow(gridDetail, value2, gridDetail.getRowCount());
    }
    
}


/**
 * 유형자산투자계획상세
 */
function fnSearchDetail(rIndex) {
	
	var params = fnGetGridRowParams(gridHeader, rIndex);
	$.extend(params, fnGetParams());
	searchCall(gridDetail, '/com/bdg/selectTangAssetDetailList', 'fnSearchDetail', params);
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
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();" disabled>
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
                    	<input type="number" id="TB_CRTN_YY"  style="width: 50px; text-align: center" disabled>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" disabled>
	                    </select>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div><!-- //searchTableArea -->
</div><!-- // search_field_wrap -->
    <div class="tbl-search-area">
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
	        	<td><input type="hidden" id="EPS_DOC_NO"/></td>
	        </tr>
		</table>
	</div>
</div>

<div class="realgrid-area">
    <div id="gridTotal"></div> 
</div>
