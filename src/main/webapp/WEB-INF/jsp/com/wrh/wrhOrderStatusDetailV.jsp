<%--
	File Name : wrhOrderStatusDetail.jsp
	Description: 입고예정 > 발주/입고 > 발주현황(발주현황상세)
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.15  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.15
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
var compCodes  = new Array();
var compLabels = new Array();
var sumAmt;

var purGroupCodes  = new Array();
var purGroupLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	var purGroupList = stringToArray("${CODELIST_IG001}");
	var orderStatus  = stringToArray("${CODELIST_IG004}");
	var orderYN      = stringToArray("${CODELIST_IG005}");
	
    // 개별코드 생성(그리드용)
    compCodes      = getComboSet('${CODELIST_SYS001}', 'CODE');
    compLabels     = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
    purGroupCodes  = getComboSet('${CODELIST_IG001}', 'CODE');
    purGroupLabels = getComboSet('${CODELIST_IG001}', 'CODE_NM');
	
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
	$("#TB_REQUEST_DATE").val('${PARAM.REQUEST_DATE}');
	
	// 필수 체크 대상(그리드)
	var poYn = nvl('${PARAM.PO_YN}', '2');
	if (poYn == "1") {
		$(".btn").hide();
	}
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    //addField(cm,    'PO_CHANGE_FLAG',    {text: '삭제유무'},      60,     'text',     {textAlignment: "center"},   {lookupDisplay: true,values:compCodes,labels:compLabels},'dropDown');
    
    addField(cm,    'DEL_FLAG_NM',       {text: '삭제유무'},      80,     'text', {textAlignment: "center"});
    addField(cm,    'RETURN_ORDER_FLAG_NM',       {text: '반품여부'},      80,     'text', {textAlignment: "center"});
    addField(cm,    'PO_NUMBER',         {text: '발주번호'},      80,     'textLink', {textAlignment: "center"});
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
    
    addField(cm,    'ITEM_QTY',          {text: '발주수량'},      80,     'number',     {textAlignment: "far"});
    addField(cm,    'CURR_CD',           {text: '통화'},          60,     'text',     {textAlignment: "center"});
    addField(cm,    'UNIT_PRICE',        {text: '구매단가'},     100,     'number',     {textAlignment: "far"});
    addField(cm,    'ITEM_AMT',          {text: '발주금액'},     100,     'number',     {textAlignment: "far"});
    addField(cm,    'H_SUM_AMT',         {text: '발주금액'},     100,     'text',     {textAlignment: "far"},{visible:false});

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

    addField(cm,    'H_UNIT_PRICE',      {text: '구매단가'},     100,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_ITEM_AMT',        {text: '발주금액'},     100,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_ITEM_QTY',        {text: '발주수량'},      80,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_PLT_QTY',         {text: '적재수량'},      80,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'H_BOX_QTY',         {text: '박스입수'},      60,     'text',     {textAlignment: "far"},{visible:false});
    addField(cm,    'NO_CHARGE_FLAG_NM', {text: '무상유무'},      60,     'text',     {textAlignment: "far"},{visible:false});
    
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 300       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, colIndex) {
    	var curr = grid.getCurrent();
        var values = grid.getValues(curr.itemIndex);
        if (colIndex.fieldName === "PO_NUMBER" || colIndex.fieldName === "PO_SEQ") {
        	fnSearchDetailOne();
        }
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = true;
        	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"}
        return styles;
    };
    
    // 고정스타일
    gridView.setColumnProperty("RQ_DATE", "dynamicStyles", columnDefaultStyles); 
    
	gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
		// 전체 그리드 컬럼 비활성화
		fnEditableFalse(grid);
		// 선택적 그리드 컬럼 활성화
    	grid.setColumnProperty("RQ_DATE", "editable", true);
    	grid.setColumnProperty("REMARK", "editable", true);
    	// 수정가능한 컬럼 색상 변경 처리
    	fnEditableStyle(grid);
    };      
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	var params = {};
	$.extend(params, {"SB_COMP_CD" : "${PARAM.COMP_CD}", "PO_NUMBER" : "${PARAM.PO_NUMBER}"});
	searchCall(gridView, '/com/wrh/selectWrhOrderStatusDetail', null, params);
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridView.clearRows();
	} else {
		sumAmt = data.fields.H_SUM_AMT;
		$("#sum_amt").text(sumAmt);
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
 * 발주상세
 */
function fnSearchDetailOne() {
	var params = fnGetMakeParams();
	$.extend(params, fnGetGridParams(gridView));
	
	var target    = "wrhOrderStatusDetailOne";
	var width     = "800";
	var height    = "670";
	
 	fnPostPopup('/com/wrh/wrhOrderStatusDetailOne', params, target, width, height);
	
}

/**
 * 발주확인
 */
function fnConfirmPoDetail() {
	
	gridView.commit();
	
	// 그리드 전체 데이터를 수집하기 윟 전체 체크박스 선택 처리
	for(var i = 0; i < gridView.getRowCount(); i++){
		gridView.checkItem(i, true);
	}
	//$.extend(params, {"COMP_CD"   : '${PARAM.COMP_CD}'});
	//$.extend(params, {"PO_NUMBER" : '${PARAM.PO_NUMBER}'});
	
	//전체행 체크
	for(var i = 0; i < gridView.getRowCount(); i++){
		var temp = gridView.getValues(i);
		
		if (temp.RD_DATE != temp.RQ_DATE) {
			if (isNullValue(temp.REMARK)) {
				alert("납기요청일과 납기희망일이 다른 경우, 비고는 필수 입력입니다.");
				return false;
			}
		}
	}
	
	var params = fnGetParams();
	$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridView)});	
	
	// 필수 체크 후 저장 진행
     if(confirm("발주확인 하시겠습니까?")){
    	 saveCall(gridView, '/com/wrh/wrhOrderStatusDetailConfirm', 'fnConfirmPoDetail', params);
     }		
}

/**
 * 저장 성공
 */
function fnConfirmPoDetailSuccess(result) {
	
	$(".btn").hide();
	alert("발주확인되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnConfirmPoDetailFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}



</script>
	<section class="pop-wrap">
		<div class="pop-head">
			<h2>발주현황</h2>
		</div><!-- //popHead -->	

		<div class="pop-cont">
			<div class="sub-tit">
				<h4>발주현황상세</h4>
				
			    <div class="btnArea t_right">
			        <button type="button" class="btn" id="btnConfirmPoDetail">발주확인</button>
			    </div>				
			</div>

			<table class="tbl-view">
				<colgroup>
					<col style="width:15%">
					<col>
					<col style="width:15%">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>업체명</th>
						<td>${PARAM.VENDOR_NM}</td>
						<th>업체코드</th>
						<td>${PARAM.VENDOR_CD}</td>
					</tr>
					<tr>
						<th>발주번호</th>
						<td>${PARAM.PO_NUMBER}</td>
						<th>발주일자</th>
						<td>${PARAM.PO_CREATE_DATE}</td>
					</tr>
					<tr>
						<th>발주금액</th>
						<td id="sum_amt"></td>
						<th>구매그룹</th>
						<td>${PARAM.PO_ORG_NM}</td>
					</tr>
					<tr>
						<th>발주담당자</th>
						<td>${PARAM.ERP_ADD_USER_NAME}</td>
						<th>결제조건</th>
						<td>${PARAM.PAY_COND_NM}</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th>납기희망일</th> -->
<!-- 						<td><input type="text" class="datepicker" id="TB_REQUEST_DATE"  value="" style="width:90px;"/></td> -->
<!-- 						<th></th> -->
<!-- 						<td></td> -->
<!-- 					</tr>					 -->
					<tr>
						<th>비고</th>
						<td colspan="3">
							<textarea id="TB_REMARK" rows="5" disabled="disabled"></textarea>
						</td>
					</tr>
				</tbody>
			</table>

		</div><!-- //popCont -->
	</section>
<br>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
