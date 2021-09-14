<%--
	File Name : wrhVendorScheduled.jsp
	Description: 입고예정 > 발주/입고 > 공급업체입고예정현황
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.04  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.04
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
var scrollItem     = 20;
var compList       = new Array();
var statusCodes    = new Array();
var statusLabels   = new Array();
var useYnCodes     = new Array();
var useYnLabels    = new Array();
var gridParam      = {};

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');
    
	compList  = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");
	
	var statusList  = stringToArray("${CODELIST_IG}","ALL","ATTR01","ATTR02","ATTR03");
	fnMakeComboOption('SB_STAT_CD', statusList,     'CODE', 'CODE_NM', null, "","전체");

	var purGroupList = stringToArray("${CODELIST_IG001}");
	fnMakeComboOption('SB_PO_ORG' , purGroupList, 'CODE', 'CODE_NM', null, "","전체");
	
    statusCodes  = getComboSet('${CODELIST_IG007}', 'CODE');
    statusLabels = getComboSet('${CODELIST_IG007}', 'CODE_NM');
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	
	// 기간 시작인 셋팅
	$("#TB_START_DATE").val(getDiffDay("d", 1));
	$("#TB_SYSDATE").val(getDiffDay("d", 0));
	$("#TB_END_DATE").val(getDiffDay("m", 3));
	
	if (getComboIndex(compList, "CODE", '${LOGIN_INFO.COMP_CD}') > -1) {
		$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
		fnCompCdChange();
	}	
	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'WEEK',                       {text:'주차'},                         40,     'text', {textAlignment: "far"});
    addField(cm,    'GR_DELY_DATE',               {text: '입고예정일'},                         70,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_CD',                 {text: '공급업체'},                       60,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_NM',             {text: '공급업체명'},                       80,     'text', {textAlignment: "near"});    
    addField(cm,    'MAT_NUMBER',                 {text: '자재'},                     60,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_DESC',                 {text: '자재내역'},                     200,     'text', {textAlignment: "near"});
    addField(cm,    'ITEM_QTY',                    {text:'입고예정수량'},                        100,     'integer', {textAlignment: "far"});
    addField(cm,    'PLT_QTY',                    {text:'PLT예상공간'},                          80,     'integer', {textAlignment: "far"});
    addField(cm,    'USE_PLT',                    {text:'PLT사용현황'},                            80,     'text', {textAlignment: "center"});
    addField(cm,    'UNIT_PRICE',                     {text:'단가'},                          80,     'integer', {textAlignment: "far"});
    addField(cm,    'UNIT_AMT',                 {text:'금액'},                     100,     'integer', {textAlignment: "far"});
    addField(cm,    'PLANT_CODE',               {text: '플랜트'},                       60,     'text', {textAlignment: "center"});
    addField(cm,    'PLANT_NM',                {text: '플랜트명'},                          150,     'text', {textAlignment: "center"});
    addField(cm,    'LOCATION',                      {text: '저장위치'},                          60,     'text', {textAlignment: "center"});
    addField(cm,    'LOCATION_TXT',                   {text: '저장위치명'},                           200,     'text', {textAlignment: "near"});
    addField(cm,    'PO_NUMBER',                   {text: '구매오더번호'},                           100,     'text', {textAlignment: "center"});
    addField(cm,    'PO_SEQ',               {text: '구매오더항번'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'PO_ORG',              {text: '구매그룹'},                    60,     'text', {textAlignment: "center"});
    addField(cm,    'PO_ORG_NM',              {text: '구매그룹명'},                     100,     'text', {textAlignment: "center"});
    addField(cm,    'PO_ITEM_QTY',              {text: '구매오더수량'},                     100,     'integer', {textAlignment: "far"});
    addField(cm,    'ADD_GR_QTY',                       {text:'現입고완료수량'},                100,     'integer', {textAlignment: "far"});
    addField(cm,    'UNIT_MEASURE',                         {text: '구매오더단위'},                           60,     'text', {textAlignment: 'center'});
    addField(cm,    'UNIT_PER_MEASURE',                      {text: 'PER'},                           60,     'text', {textAlignment: 'center'});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,columns        : cm        // required
        ,height         : _G_GRID_HEIGHT_3       //required 그리드 높이
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });


    gridView.setFixedOptions({
  	  colCount: 6
  });    

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectVendorScheduled');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	gridView.clearRows();
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
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM',"", "", "전체");
    
    fnPlantCdChange();
}

/**
 * 플랜트 코드 변경 이벤트
 */
function fnPlantCdChange() {
    var StorageList = stringToArray("${CODELIST_SYSSTR}", $("#SB_COMP_CD").val(), $("#SB_PLANT_CD").val());
    fnMakeComboOption('SB_STORAGE_CD', StorageList, 'CODE', 'CODE_NM', "", "", "전체");
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
	                    <select id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD" onchange="fnPlantCdChange();">
		                    <option value="">전체</option>
	                    </select>
                    </td>
					<th><span>입고장소</span></th>
                    <td>
	                    <select id="SB_STORAGE_CD" name="SB_STORAGE_CD" data-type="select" data-bind="selectedOptions: SB_STORAGE_CD" onchange="fnStorageCdChange();">
		                    <option value="">전체</option>
	                    </select>
                    </td>
                    <td></td>
                </tr>            
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"/>
                        <a href="javascript:fnSearchVendor();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <th><span>입고예정일</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DATE" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DATE" dateHolder="end" value=""/>
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
                    <th><span>자재내역</span></th>
                    <td>
                        <input type="text" id="TB_MAT_DESC" />
                    </td>
                    <th><span>구매그룹</span></th>
                    <td>
	                    <select id="SB_PO_ORG" name="SB_PO_ORG" data-type="select" data-bind="selectedOptions: SB_PO_ORG">
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
