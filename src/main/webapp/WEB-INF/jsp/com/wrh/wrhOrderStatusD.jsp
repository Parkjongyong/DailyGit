<%--
	File Name : wrhOrderStatusD.jsp
	Description: 입고예정 > 발주/입고 > 발주현황상세
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.10.23  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.10.23
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

var purGroupCodes  = new Array();
var purGroupLabels = new Array();

var orderStatusCodes  = new Array();
var orderStatusLabels = new Array();

var orderYnCodes  = new Array();
var orderYnLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	var purGroupList = stringToArray("${CODELIST_IG001}");
	var orderStatus  = stringToArray("${CODELIST_IG004}");
	var orderYN      = stringToArray("${CODELIST_IG005}");
	
    // 개별코드 생성(그리드용)
    compCodes         = getComboSet('${CODELIST_SYS001}', 'CODE');
    compLabels        = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
    purGroupCodes     = getComboSet('${CODELIST_IG001}', 'CODE');
    purGroupLabels    = getComboSet('${CODELIST_IG001}', 'CODE_NM');
    orderStatusCodes  = getComboSet('${CODELIST_IG004}', 'CODE');
    orderStatusLabels = getComboSet('${CODELIST_IG004}', 'CODE_NM');
    orderYnCodes      = getComboSet('${CODELIST_IG005}', 'CODE');
    orderYnLabels     = getComboSet('${CODELIST_IG005}', 'CODE_NM');
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");
    fnMakeComboOption('SB_PO_ORG' , purGroupList, 'CODE', 'CODE_NM');
    fnMakeComboOption('SB_ORD_CD' , orderStatus,  'CODE', 'CODE_NM', null, "","전체");
    fnMakeComboOption('SB_ORD_YN' , orderYN,      'CODE', 'CODE_NM', null, "","전체");
    
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
	
// 	if(isNotEmpty('${LOGIN_INFO.COMP_CD}')){
// 		$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
// 	}
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PO_NUMBER',         {text: '발주번호'},      100,     'textLink', {textAlignment: "center"});
    addField(cm,    'PO_SEQ',            {text: '발주항번'},      80,     'textLink', {textAlignment: "center"});
    addField(cm,    'RD_DATE',           {text: '납기요청일'},    80,     'text',     {textAlignment: "center"});
    addField(cm,    'RQ_DATE',           {text: '납기희망일'},   100,     'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'REMARK',            {text: '비고'},      200,     'text',     {textAlignment: "near"});
    addField(cm,    'COMPLETE_YN',       {text: '납품완료'},      60,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_NUMBER',        {text: '자재코드'},      80,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_DESC',          {text: '자재내역'},     100,     'text',     {textAlignment: "near"});
    addField(cm,    'RD_LOCATION_TXT',   {text: '납품장소'},     200,     'text',     {textAlignment: "near"});
    addField(cm,    'UNIT_MEASURE',      {text: '단위'},          60,     'text',     {textAlignment: "center"});
    addField(cm,    'UNIT_PER_MEASURE',  {text: 'PER'},          60,     'text',     {textAlignment: "center"});
    addField(cm,    'ITEM_QTY',          {text: '발주수량'},      100,     'number', {textAlignment: "far", numberFormat : "###,###,###.###"});
    addField(cm,    'CURR_CD',           {text: '통화'},          60,     'text',     {textAlignment: "center"});
    addField(cm,    'UNIT_PRICE',        {text: '구매단가'},      100,     'number', {textAlignment: "far", numberFormat : "###,###,###.##"});
    addField(cm,    'ITEM_AMT',          {text: '발주금액'},     100,     'number', {textAlignment: "far", numberFormat : "###,###,###.##"});

    
    addField(cm,    'VENDOR_NM',         {text: '업체명'},          0,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_CD',         {text: '업체코드'},      100,     'text', {textAlignment: "center"});
    addField(cm,    'PO_CREATE_DATE',    {text: '발주일자'},       80,     'text', {textAlignment: "center"});
    addField(cm,    'PAY_COND_NM',       {text: '결재조건'},      100,     'text', {textAlignment: "center"});
    
    
    addField(cm,    'PO_YN',             {text: '발주확인유무'},    100,     'text', {textAlignment: "center"},   {lookupDisplay: true,values:orderYnCodes,labels:orderYnLabels},'dropDown');
    addField(cm,    'CONFIRM_DATE',      {text: '확인일자'},       80,     'text', {textAlignment: "center"});
    addField(cm,    'PO_CHANGE_DATE',    {text: '변경일자'},       80,     'text', {textAlignment: "center"});
    addField(cm,    'COMP_NM',           {text: '회사'},          100,     'text', {textAlignment: "center"});
    addField(cm,    'PO_ORG',          	 {text: '구매그룹'},       60,     'text', {textAlignment: "near"},{visible:false});
    addField(cm,    'PO_ORG_NM',         {text: '구매그룹'},      100,     'text', {textAlignment: "center"});
    addField(cm,    'ERP_ADD_USER_ID',   {text: '발주담당자'},      0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ERP_ADD_USER_NAME', {text: '발주담당자'},    100,     'text', {textAlignment: "center"});
    addField(cm,    'PAY_COND',          {text: '결재조건'},        0,     'text', {textAlignment: "center"},{visible:false});
    
    addField(cm,    'PO_CHANGE_FLAG',    {text: '발주상태'},      80,     'text', {textAlignment: "center"},   {lookupDisplay: true,values:orderStatusCodes,labels:orderStatusLabels},'dropDown');

    addField(cm,    'COMP_CD',           {text: '회사코드'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'PLANT_CODE',        {text: '플랜트'},             60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'RETURN_ORDER_FLAG', {text: '반품지시자'},         60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'NO_CHARGE_FLAG',    {text: '무상지시자'},         60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'BATCH_FLAG',        {text: '배치관리대상'},       60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'INV_PERCENT',       {text: '초과납품 허용한도'},  60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'REVLV',             {text: '표시자재 버젼'},      60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'MAT_GROUP',         {text: '자재그룹'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'MAT_GROUP_DESC',    {text: '자재그룹내역'},       60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'MAT_TYPE',          {text: '자재유형'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'RD_DATE',           {text: '납기일자'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'RD_TIME',           {text: '납품시간'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'LOCATION',          {text: '저장위치'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'LOCATION_TXT',      {text: '저장위치내역'},       60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'RD_LOCATION_TXT',   {text: '납품장소내역'},       60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'MAKER_CODE',        {text: '제조원코드'},         60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'MAKER_NAME',        {text: '제조원명'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'MINI_EXP_PER',      {text: '최저잔존수명'},       60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'PO_CHG_DATE',       {text: '발주변경일'},         60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'DEL_FLAG',          {text: '삭제여부'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'BOX_QTY',           {text: '박스입수'},           60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'AREA_QTY',          {text: '배면'},               60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'HEIGH_QTY',         {text: '배단'},               60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'PLT_QTY',           {text: 'PLT적재수량'},        60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'PLANT_NM',          {text: '플랜트명'},        60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'PO_CREATE_DATE',    {text: '발주생성일자'},        60,     'text',     {textAlignment: "far"},{visible:false});

    addField(cm,    'H_UNIT_PRICE',        {text: '구매단가'},     100,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_ITEM_AMT',          {text: '발주금액'},     100,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_ITEM_QTY',          {text: '발주수량'},      80,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_PLT_QTY',           {text: '적재수량'},      80,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_BOX_QTY',           {text: '박스입수'},      60,     'text',     {textAlignment: "far"},{visible:false});
    
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, colIndex) {
    	var curr = grid.getCurrent();
        if (colIndex.fieldName === "PO_NUMBER" || colIndex.fieldName === "PO_SEQ") {
        	fnSearchDetailOne();
        }
    };

	gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 50;
            loadNext();
        }
    }
	
	fnSearch();

}

function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+49});
    
    ajaxJsonCall('<c:url value="/com/wrh/selectWrhOrderStatusList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWrhOrderStatusDetail');

}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridView.clearRows();
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
 * 팝업 콜백
 */
function fnCallbackVendorSearchPop(rows) {
	$("#TB_VENDOR_CD").val(rows.VENDOR_CD);
	$("#TB_VENDOR_NM").val(rows.VENDOR_NM);
}

/**
 * 상세 조회
 */
function fnSearchDetailOne() {
	var params = fnGetMakeParams();
	$.extend(params, fnGetGridParams(gridView));
	
	var target    = "wrhOrderStatusDetailOne";
	var width     = "800";
	var height    = "670";
	
 	fnPostPopup('/com/wrh/wrhOrderStatusDetailOne', params, target, width, height);
	
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
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:130px">
                <col style="width:420px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD">
	                    <option>전체</option>
	                    </select>
                    </td>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	/>
                        <a href="javascript:fnSearchVendor();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <th><span>발주일</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DT" dateHolder="end" value=""/>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>발주상태</span></th>
                    <td>
	                    <select id="SB_ORD_CD" name="SB_ORD_CD" data-type="select" data-bind="selectedOptions: SB_ORD_CD">
	                    </select>
                    </td>
                    <th><span>발주번호</span></th>
                    <td>
                        <input type="text"  id="TB_START_PO_NUMBER" style="width: 90px;"/>
                        <em> ~ </em>
                        <input type="text"  id="TB_END_PO_NUMBER" style="width: 90px;"/>
                    </td>
                    <th><span>발주확인유무</span></th>
                    <td>
	                    <select id="SB_ORD_YN" name="SB_ORD_YN" data-type="select" data-bind="selectedOptions: SB_ORD_YN">
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
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
