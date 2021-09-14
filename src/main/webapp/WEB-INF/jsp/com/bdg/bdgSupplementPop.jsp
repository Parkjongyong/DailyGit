<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 추가예산신청(EPS)
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

var processType  = "";
var apprCnt      = "1";

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,  'CODE', 'CODE_NM');
	
	fnCompCdChange();

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
	$("#TB_CRTN_YMD").val('${PARAM.TB_CRTN_YMD}');
	$("#SB_CCTR_CD").val('${PARAM.SB_CCTR_CD}');
}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '승인상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:apprCodes,labels:apprLabels, editable:false},'dropDown');
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'text',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'BUGT_BASIC_AMT',       {text:'당월기본예산'},  100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_EXEC_AMT',        {text:'배정실행예산'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_RESULT_AMT',      {text:'현재실적'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_BALANCE_AMT',    {text:'실행잔액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REQUEST_AMT',          {text:'신청액'},    100,            'integer',           {textAlignment:"far"});
    addField(cm,    'CODEMAPPING1',  	    {text: '상세내역'},    50,     'popupLink');
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PROCESS_TYPE',         {text: '등록구분'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP 전송여부'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'REQUEST_DESC',         {text: '추가예산내역'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	$("#TB_REQUEST_DESC").val(gridView.getValue(colIndex.itemIndex,"REQUEST_DESC"));
       	
       	if(colIndex.fieldName == "CODEMAPPING1"){
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
                styles.editable = true;
                styles.background = "#d5e2f2";
            } else {
            	if (processType == "2") {
            		styles.editable = false;	
            	} else {
            		// 상태코드에따른 수정불가 처리 추가 필요!!!!!!
            		// 일단은 그냥 풀어둠
                    styles.editable = true;
                    styles.background = "#d5e2f2";        		
            	}
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

    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };        
    
    setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);

    fnGridSortFalse(gridView);
    gridView.setDisplayOptions({columnMovable:false})
    
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
 * 조회
 */
function fnSearch() {
	
	if (apprCnt == "0") {
		alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
		return false;			
	}	
	
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectSupplementPop');
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
    
	if (isNotEmpty(data.fields.epsInfo.CNT)) {
		apprCnt = data.fields.epsInfo.CNT;
		if (data.fields.epsInfo.CNT == "0") {
			alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
			return false;			
		}
	}	    
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled>
	                    </select>
                    </td>
                    <th><span>작성일자</span></th>
                    <td>
						<input type="text"  id="TB_CRTN_YMD"  value="" style="width:90px;" disabled/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" disabled="disabled">
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
	        	<td><input type="hidden" id="EPS_DOC_NO"/></td>
	        </tr>
		</table>
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