<%--
	File Name : wrhStockDueDateRegistV.jsp
	Description: 입고예정 > 발주/입고 > 입고예정일등록
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.20  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.20
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

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList    = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	var matTypeList = stringToArray("${CODELIST_IG002}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', "", "", "전체");
    
    fnMakeComboOption('SB_MAT_TYPE', matTypeList, 'CODE', 'CODE_NM', null, "", "전체");
    
    //var plantList = stringToArray("${CODELIST_SYSPLT}", '${LOGIN_INFO.COMP_CD}');
    //fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM', null, "", "전체");
    
    //var StorageList = stringToArray("${CODELIST_SYSSTR}", '${LOGIN_INFO.COMP_CD}', plantList[0].CODE);
    //fnMakeComboOption('SB_STORAGE_CD', StorageList, 'CODE', 'CODE_NM', null, "", "전체");
    
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
	$("#TB_START_DT").val(getDiffDay("m",-1,null));
	$("#TB_END_DT").val(getDiffDay("m",0,null));
	
	$("#TB_VENDOR_CD").val('${LOGIN_INFO.VENDOR_CD}');
	$("#TB_VENDOR_NM").val('${LOGIN_INFO.VENDOR_NM}');	
}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
    
    fnPlantCdChange();
}

/**
 * 회사 코드 변경 이벤트
 */
function fnPlantCdChange() {
    var StorageList = stringToArray("${CODELIST_SYSSTR}", $("#SB_COMP_CD").val(), $("#SB_PLANT_CD").val());
    fnMakeComboOption('SB_STORAGE_CD', StorageList, 'CODE', 'CODE_NM', "", "", "전체");
}


function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PO_NUMBER',         {text: '발주번호'},      100,     'textLink', {textAlignment: "center"});
    addField(cm,    'PO_SEQ',            {text: '발주항번'},      70,      'text',     {textAlignment: "center"});
    addField(cm,    'PO_ORG_NM',         {text: '구매그룹'},     100,      'text',     {textAlignment: "center"});
    addField(cm,    'MAT_TYPE_NM',       {text: '자재유형'},      100,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_NUMBER',        {text: '자재코드'},      100,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_DESC',          {text: '자재내역'},      130,     'text',     {textAlignment: "near"});
    addField(cm,    'UNIT_MEASURE',      {text: '단위'},            0,     'text',     {textAlignment: "center"});
    addField(cm,    'CURR_CD',           {text: '통화'},          100,     'text',     {textAlignment: "center"});
    addField(cm,    'PO_ITEM_QTY',       {text: '발주수량'},      100,     'number',     {textAlignment: "center"});
    addField(cm,    'TOT_ITEM_QTY',      {text: '입고예정수량'},      100,     'number',     {textAlignment: "center"});
    addField(cm,    'ADD_GR_QTY',        {text: '누적입고수량'},  100,     'number',     {textAlignment: "center"});
    addField(cm,    'NON_PAY_QTY',       {text: '미납수량'},      100,     'number',     {textAlignment: "center"});
    addField(cm,    'PO_DATE_GRID',      {text: '발주일'},        100,     'datetime',     {textAlignment: "center"});
    addField(cm,    'RD_DATE_GRID',      {text: '납기일'},        100,     'datetime',     {textAlignment: "center"});
    addField(cm,    'LOCATION_TXT',      {text: '입고장소'},      100,     'text',     {textAlignment: "center"});
    addField(cm,    'COMP_NM',           {text: '회사'},          100,     'text',     {textAlignment: "center"});
    addField(cm,    'PLANT_NAME',        {text: '플랜트'},        100,     'text',     {textAlignment: "center"});  
    addField(cm,    'PLT_QTY',           {text: 'PLT적재수량'},   100,     'number',     {textAlignment: "center"});
    //addField(cm,    'PLT_CAL_QTY',       {text: 'PLT수량'},   100,     'number',     {textAlignment: "center"});
    
    addField(cm,    'CRUD',              {text: 'CRUD'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_ORG',            {text: '구매그룹코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_CD',         {text: '업체코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_NM',         {text: '업체명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'COMP_CD',           {text: '회사코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MAT_TYPE',          {text: '자재유형코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'RD_LOCATION_TXT',   {text: '입고장소'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    
    addField(cm,    'BFR_GR_YY',         {text: '원자재전표연도'},  0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BFR_GR_NUMBER',     {text: '원자재문서번호'},  0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BFR_GR_SEQ',        {text: '원자재문서의품목'},0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'LOCATION_TXT',      {text: '저장위치내역'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'LOCATION',          {text: '저장위치'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BATCH_NO',          {text: 'BATCH NO'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MV_GUBUN',          {text: '이동유형코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_DATE',           {text: '발주일'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'RD_DATE',           {text: '납기일'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_CHANGE_FLAG',    {text: '발주상태'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_YN',             {text: '발주확인유무'},       0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'CONFIRM_DATE',      {text: '확인일자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_CHANGE_DATE',    {text: '변경일자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_CREATE_DATE',    {text: '발주일자'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'ERP_ADD_USER_ID',   {text: '발주담당자'},         0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'ERP_ADD_USER_NAME', {text: '발주담당자'},         0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PAY_COND',          {text: '결재조건'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PAY_COND_NM',       {text: '결재조건'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'INV_PERCENT',       {text: '초과납품허용한도'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'INV_ITEM_QTY',      {text: '초과납품가능수량'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'UNIT_PER_MEASURE',  {text: 'PER'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PLANT_CODE',        {text: '플랜트코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'UNIT_PRICE',        {text: '단가'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MINI_EXP_PER',      {text: '최저잔존수명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'BOX_QTY',           {text: '박스입수'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'AREA_QTY',          {text: '최저잔존수명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'HEIGH_QTY',         {text: '배단'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_4       //required 그리드 높이
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
        	fnSearchPoDetail(colIndex);
        }
    };

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWhrStockDueDateRegistList');
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
 * 발주현황상세조회
 */
function fnSearchPoDetail(data) {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	
	var target    = "wrhOrderStatusDetailV";
	var width     = "1260";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhOrderStatusDetailV', params, target, width, height, scrollbar, resizable);
}

/**
 * 입고예정등록
 */
function fnStockDueDateRegistDetail() {
	
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	var poOrgOld = "";
	var matTypeOld = "";
	var locationOld = "";
	
	if (checkedRows.length == 0) {
		alert("선택된 데이터가 없습니다.");
		return false;				
	}
	
	for(var i = 0; i < checkedRows.length; i++){
		
		if (i == 0) {
			poOrgOld = checkedRows[i].PO_ORG; 
			matTypeOld = checkedRows[i].MAT_TYPE;
			locationOld = checkedRows[i].LOCATION;
		} else {
			if (checkedRows[i].PO_ORG != poOrgOld) {
				alert("동일 구매그룹만 등록 가능합니다.");
				return false;				
			}
			
			if (checkedRows[i].MAT_TYPE != matTypeOld) {
				alert("동일 자재유형만 등록 가능합니다.");
				return false;				
			}
			
			if (checkedRows[i].LOCATION != locationOld) {
				alert("동일 납품장소만 등록 가능합니다.");
				return false;				
			}			
		}
	}
	
	var params = {};
	$.extend(params, fnGetGridCheckSendPopupData(gridView));
	$.extend(params, fnGetParams());
	
	var target    = "wrhStockDueDateRegistDetailV";
	var width     = "1400";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhStockDueDateRegistDetailV', params, target, width, height, scrollbar, resizable);
 	
	//전체행 체크해제
	for(var i = 0; i < gridView.getRowCount(); i++){
		gridView.checkItem(i, false);
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnCompCdChange();" >
	                    <option value="">전체</option>
	                    </select>
                    </td>
                    <th><span>플랜트</span></th>
                    <td>
	                    <select  id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD" onchange="fnPlantCdChange();">
	                    <option value="">전체</option>
	                    </select>
                    </td>
					<th><span>입고장소</span></th>
                    <td>
	                    <select  id="SB_STORAGE_CD" name="SB_STORAGE_CD" data-type="select" data-bind="selectedOptions: SB_STORAGE_CD">
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
                            <option value="PD">발주일</option>
                            <option value="RD">납기일</option>
                        </select>
                        </span>                            
                    </th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DT" dateHolder="end" value=""/>
                    </td>
					<th><span>발주번호</span></th>
                    <td>
                        <input class="w120" type="text" id="TB_START_NO" value=""/>
                        <em> ~ </em>
                        <input class="w120" type="text" id="TB_END_NO" value=""/>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>자재유형</span></th>
                    <td>
                        <select id="SB_MAT_TYPE" name="SB_MAT_TYPE" data-type="select" data-bind="selectedOptions:SB_MAT_TYPE">
                        <option value="">전체</option>
                        </select>
                    </td>
                    <th><span>정렬기준</span></th>
                    <td>
                    	<input type="radio" id="RD_SORT_GUBN1" name="RD_SORT_GUBN" value="Y" checked>
                    	<label for="RD_SORT_GUBN1">발주번호&nbsp;&nbsp;</label>
                    	<input type="radio" id="RD_SORT_GUBN2" name="RD_SORT_GUBN" value="N">
                    	<label for="RD_SORT_GUBN2">자재코드&nbsp;&nbsp;</label>                    	
                    </td>
                    <td colspan="2">
						<label class="chk"><input id="CB_COMPLETE_YN" vlaue="Y" type="checkbox">&nbsp;&nbsp;종결 오더포함</label>                   	
                    </td>
                </tr>                
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearch">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnStockDueDateRegistDetail">입고예정등록</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
