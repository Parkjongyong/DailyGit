<%--
	File Name : wrhStockStatusV.jsp
	Description: 입고예정 > 발주/입고 > 입고현황
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.16  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.16
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
var scrollItem = 20;
var compCodes  = new Array();
var compLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', "", "", "전체");
    
	var purGroupList = stringToArray("${CODELIST_IG001}");
	fnMakeComboOption('SB_PO_ORG' , purGroupList, 'CODE', 'CODE_NM', null, "","전체");    
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 기간 시작인 셋팅
	$("#TB_START_DT").val(getDiffDay("m",-3,null));
	$("#TB_END_DT").val(getDiffDay("m",0,null));
	
	$("#TB_VENDOR_CD").val('${LOGIN_INFO.VENDOR_CD}');
	$("#TB_VENDOR_NM").val('${LOGIN_INFO.VENDOR_NM}');	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PO_NUMBER',         {text: '발주번호'},      80,     'textLink', {textAlignment: "center"});
    addField(cm,    'PO_SEQ',            {text: '발주항번'},      50,      'text',     {textAlignment: "center"});
    addField(cm,    'MAT_NUMBER',        {text: '자재코드'},      70,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_DESC',          {text: '자제내역'},      130,     'text',     {textAlignment: "near"});
    addField(cm,    'PO_ORG_NM',         {text: '구매그룹'},           0,     'text',     {textAlignment: "center"});
    addField(cm,    'COMP_NM',           {text: '회사명'},        100,     'text',     {textAlignment: "near"});
    addField(cm,    'PLANT_NAME',        {text: '플랜트'},       80,     'text',     {textAlignment: "center"});
    addField(cm,    'LOCATION_TXT',      {text: '저장위치내역'},   80,     'text',     {textAlignment: "center"});    
    addField(cm,    'VENDOR_CD',         {text: '업체코드'},       70,     'text',     {textAlignment: "center"});
    addField(cm,    'VENDOR_NM',         {text: '업체명'},        100,     'text',     {textAlignment: "near"});
    
    addField(cm,    'MV_TXT',            {text: '이동유형'},      100,     'text',     {textAlignment: "near"});
    addField(cm,    'GR_YEAR',           {text: '입고년도'},      60,     'text',     {textAlignment: "center"});
    addField(cm,    'GR_DATE_GRID',      {text: '입고일자'},      80,     'datetime', {textAlignment: "center"});
    addField(cm,    'GR_NUMBER',         {text: '입고번호'},      80,     'textLink', {textAlignment: "center"});
    addField(cm,    'GR_SEQ',            {text: '입고항번'},      60,     'textLink', {textAlignment: "center"});
    addField(cm,    'CURR_CD',           {text: '통화'},          40,     'text',     {textAlignment: "center"});
    addField(cm,    'ITEM_QTY',          {text: '입고수량'},      100,     'number',   {textAlignment: "far"});
    addField(cm,    'GR_AMT',            {text: '입고금액'},      100,     'number',   {textAlignment: "far"})
    addField(cm,    'COMP_CD',           {text: '회사'},            0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'UNIT_MEASURE',      {text: '기본단위'},         0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BFR_GR_YY',         {text: '원자재전표연도'},  0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BFR_GR_NUMBER',     {text: '원자재문서번호'},  0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BFR_GR_SEQ',        {text: '원자재문서의품목'},0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_DATE',           {text: '발주일'},          0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'LOCATION',          {text: '저장위치'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BATCH_NO',          {text: 'BATCH NO'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MV_GUBUN',          {text: '이동유형코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_DATE',           {text: '입고일자'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    
    
    addField(cm,    'PO_CHANGE_FLAG',    {text: '발주상태'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_YN',             {text: '발주확인유무'},       0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'CONFIRM_DATE',      {text: '확인일자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_CHANGE_DATE',    {text: '변경일자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_CREATE_DATE',    {text: '발주일자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_ORG',          	 {text: '구매그룹'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    
    addField(cm,    'ERP_ADD_USER_ID',   {text: '발주담당자'},         0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'ERP_ADD_USER_NAME', {text: '발주담당자'},         0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PAY_COND',          {text: '결재조건'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PAY_COND_NM',       {text: '결재조건'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'H_ITEM_QTY',        {text: '입고수량'},      100,     'text',   {textAlignment: "far"}, {visible:false});
    addField(cm,    'H_GR_AMT',          {text: '입고금액'},      100,     'text',   {textAlignment: "far"}, {visible:false});
    addField(cm,    'DC_INDICATOR',      {text: '차대지시자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, colIndex) {
        if (colIndex.fieldName === "PO_NUMBER") {
        	fnSearchPoDetail();
        }
        if (colIndex.fieldName === "GR_NUMBER" || colIndex.fieldName === "GR_SEQ") {
        	fnSearchGrDetail();
        }        
    };
    
	gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 50;
            loadNext();
        }
    }    
    
    

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWrhStockStatusList');
}

/**
 * 페이징 처리 조회
 */
function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+49});
    
    ajaxJsonCall('<c:url value="/com/wrh/selectWrhStockStatusList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridView.clearRows();
	} else {
		$('#TB_TOT_GR_AMT').val();
	}
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();	
}

/**
 * 업체 조회
 */
function fnSearchVendor() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnVendorSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/vendorSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 발주현황상세조회
 */
function fnSearchPoDetail() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridParams(gridView));
	
	var target    = "wrhOrderStatusDetail";
	var width     = "1250";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhOrderStatusDetail', params, target, width, height, scrollbar, resizable);
}

/**
 * 입고상세조회
 */
function fnSearchGrDetail() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridParams(gridView));	
	var target    = "wrhStockStatusDetail";
	var width     = "600";
	var height    = "470";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhStockStatusDetail', params, target, width, height, scrollbar, resizable);
}

/**
 * 팝업 콜백
 */
function fnCallbackVendorSearchPop(rows) {
	$("#TB_VENDOR_CD").val(rows.VENDOR_CD);
	$("#TB_VENDOR_NM").val(rows.VENDOR_NM);
}

/**
 * 발주현황상세
 */
function fnSearchDetail() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridParams(gridView));
	
	var target    = "wrhOrderStatusDetail";
	var width     = "1200";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhOrderStatusDetailV', params, target, width, height, scrollbar, resizable);

}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM', null, "","전체");
    
    fnPlantCdChange();
}

/**
 * 회사 코드 변경 이벤트
 */
function fnPlantCdChange() {
    var StorageList = stringToArray("${CODELIST_SYSSTR}", $("#SB_COMP_CD").val(), $("#SB_PLANT_CD").val());
    fnMakeComboOption('SB_STORAGE_CD', StorageList, 'CODE', 'CODE_NM', null, "","전체");
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnCompCdChange();">
	                    <option>전체</option>
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
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly"/>
                    </td>
                    <th>
                    	<span>
                        <select id="SB_COND_01" name="SB_COND_01" data-type="select" data-bind="selectedOptions:SB_COND_01">
                            <option value="GD">입고일</option>
                            <option value="PD">발주일</option>
                        </select>
                        </span>                            
                    </th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DT" dateHolder="end" value=""/>
                    </td>
                    <th>
                    	<span>
                        <select id="SB_COND_02" name="SB_COND_02" data-type="select" data-bind="selectedOptions:SB_COND_02">
                            <option value="GN">입고번호</option>
                            <option value="PN">발주번호</option>
                        </select>
                        </span>                            
                    </th>
                    <td>
                        <input class="w120" type="text" id="TB_START_NO" value=""/>
                        <em> ~ </em>
                        <input class="w120" type="text" id="TB_END_NO" value=""/>
                    </td>                    
                    <td></td>
                </tr>
                <tr>
                    <th><span>자재코드</span></th>
                    <td>
						<input class="w120" id="TB_MAT_NUMBER" value=""/>
                    </td>
                    <th><span>구매그룹</span></th>
                    <td>
	                    <select id="SB_PO_ORG" name="SB_PO_ORG" data-type="select" data-bind="selectedOptions: SB_PO_ORG">
	                    </select>
                    </td> 
                    <th><span>입고금액</span></th>
                    <td>
						<input class="w120" type="text" style="text-align:right;" id="TB_TOT_GR_AMT" value=""/>
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
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
