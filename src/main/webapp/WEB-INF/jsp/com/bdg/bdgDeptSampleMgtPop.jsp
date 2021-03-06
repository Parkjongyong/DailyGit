<%--
	File Name : bdgDeptSampleMgt.jsp
	Description: 예산 > 영업관리 > 부서견본신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.14  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.09.14
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var gridDetail;

var rowIndex     = -1;
var d3Cnt        = 0;

var statusCodes  = new Array();
var statusLabels = new Array();

var orderTypeCodes  = new Array();
var orderTypeLabels = new Array();

var accountList  = new Array();

var userPopGubn  = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	var statusList = stringToArray("${CODELIST_YS024}");
	accountList = stringToArray("${CODELIST_YS025}");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_STATUS'     , statusList,   'CODE', 'CODE_NM', null, "","전체");

	statusCodes  = getComboSet('${CODELIST_YS024}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS024}', 'CODE_NM');
	
	orderTypeCodes  = getComboSet('${CODELIST_YS025}', 'CODE');
	orderTypeLabels = getComboSet('${CODELIST_YS025}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGrid();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    var epsDocNo = '${PARAM.EPS_DOC_NO}';
    if(isNotEmpty(epsDocNo) == true){
    	$("#TB_EPS_DOC_NO").val(epsDocNo);
    	fnSearch();
    }    

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YMD").val(getDiffDay("y",0));
	$("#TB_TODAY").val(getDiffDay("y",0).replace('-', '').replace('-', ''));
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	
	fnCompCdChange();

}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
	var deptList   = stringToArray("${CODELIST_USRDPT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_ORG_CD', deptList, 'CODE', 'CODE_NM');
}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text:'진행상태'},      80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable:false},'dropDown');
    addField(cm,    'SD_SEND_NO',           {text:'주문번호'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'ORDER_TYPE',           {text: '주문유형'},      150,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:orderTypeCodes,labels:orderTypeLabels},'dropDown');
    addField(cm,    'MAT_NUMBER',           {text:'품목코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'MAT_DESC',             {text:'품목명'},         200,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_CD',              {text:'코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코스트센터명'},         100,            'text',           {textAlignment:"near"});
    addField(cm,    'REQ_SABUN',            {text:'사원코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'REQ_SABUN_NM',         {text:'사원명'},         100,            'text',           {textAlignment:"center"}); 
    addField(cm,    'DELIVERY_LOC_TXT',     {text:'납품처'},         150,            'text',           {textAlignment:"near"});
    addField(cm,    'RELEASE_REQ_YMD',      {text:'출고요청일'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'REQUEST_QTY',          {text:'수량'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'SAMPLE_AMT',           {text:'견본가'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REQUEST_AMT',          {text:'금액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'JAEGO_QTY',            {text:'품목재고'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'TOTAL_AMT',            {text:'예산금액'},        100,            'integer',           {textAlignment:"far"});
    
    
    
    
    addField(cm,    'REMARK',               {text:'비고'},         150,            'text',           {textAlignment:"near"});
    
    
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'DELIVERY_LOC',         {text: '납품처코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BUGT_AMT',             {text:'예산금액'},        100,            'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'RESULT_AMT',           {text:'실적금액'},        100,            'integer', {textAlignment: "center"},{visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.STATUS;
        if (gubn == '1' || gubn == '3') {
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

    // 고정스타일
    gridView.setColumnProperty("STATUS"           , "dynamicStyles", columnDefaultStyles);  
    gridView.setColumnProperty("SD_SEND_NO"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("MAT_NUMBER"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("MAT_DESC"         , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("SAMPLE_AMT"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REQUEST_AMT"      , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("JAEGO_QTY"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BUGT_AMT"         , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REQ_SABUN"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REQ_SABUN_NM"     , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("DELIVERY_LOC_TXT" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REMARK"           , "dynamicStyles", columnDefaultStyles);
    
    //가변스타일
    gridView.setColumnProperty("REQUEST_QTY"     , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("RELEASE_REQ_YMD" , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("ORDER_TYPE"      , "dynamicStyles", columnDynamicStyles);
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectDeptSampleMgtListPop');
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
                    <th><span>작성일</span></th>
                    <td>
                    	<input type="text" class="datepicker" id="TB_CRTN_YMD" dateHolder="bgn" value="" style="width:90px;" disabled/>
                    	<input type="hidden" id="TB_TODAY">
                    </td>
                    <th><span>부서명</span></th>
                    <td>
	                    <select id="SB_ORG_CD" name="SB_ORG_CD" disabled>
	                    </select>
	                    <input type="hidden" id="TB_EPS_DOC_NO"/>                    
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
<div class="sub-tit">
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
