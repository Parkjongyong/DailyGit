<%--
	File Name : wrhScheduledArrival.jsp
	Description: 입고예정 > 입고승인 > 입고예정현황
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.21  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.21
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
var scrollItem   = 20;
var compList     = new Array();
var statusCodes  = new Array();
var statusLabels = new Array();
var useYnCodes   = new Array();
var useYnLabels  = new Array();
var gridParam    = {};

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');
    
	compList  = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");
	
	var statusList  = stringToArray("${CODELIST_IG}","ALL","ATTR01","ATTR02","ATTR03");
	fnMakeComboOption('SB_STAT_CD', statusList,     'CODE', 'CODE_NM', null, "","전체");

    statusCodes  = getComboSet('${CODELIST_IG007}', 'CODE');
    statusLabels = getComboSet('${CODELIST_IG007}', 'CODE_NM');
    
	var purGroupList = stringToArray("${CODELIST_IG001}");
	fnMakeComboOption('SB_PO_ORG' , purGroupList, 'CODE', 'CODE_NM', null, "","전체");
	
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
	$("#TB_START_DATE").val(getDiffDay("m",0));
	$("#TB_END_DATE").val(getDiffDay("m",3));
	
	if (getComboIndex(compList, "CODE", '${LOGIN_INFO.COMP_CD}') > -1) {
		$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	}	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'DOC_NO',                       {text:'문서번호'},                         100,     'textLink', {textAlignment: "center"});
    
    addField(cm,    'DOC_STATUS',                   {text: '진행상태'},                         60,     'text', {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels},'dropDown');
    
    addField(cm,    'GR_DELY_DATE',                 {text: '입고예정일'},                       60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'GR_DELY_TIME',                 {text: '입고예정시간'},                     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'GR_DATE_TIME',                 {text: '입고예정일시'},                     100,     'multiline', {textAlignment: "center", textWrap : "explicit"});
    
    addField(cm,    'PO_ORG_NM',                    {text:'구매그룹명'},                        60,     'text', {textAlignment: "center"});
    
    addField(cm,    'VENDOR_CD',                    {text:'업체코드'},                          60,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_NM',                    {text:'업체명'},                            100,     'text', {textAlignment: "center"});

    addField(cm,    'LOCATION',                     {text:'입고장소'},                          60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'LOCATION_TXT',                 {text:'저장위치내역'},                     100,     'text', {textAlignment: "near"});
    
    addField(cm,    'GR_PERSON_NAME',               {text: '입고담당자'},                       60,     'text', {textAlignment: "center"});
    addField(cm,    'GR_PERSON_TEL',                {text: '연락처'},                          60,     'text', {textAlignment: "center"});
    
    addField(cm,    'COMP_NM',                      {text: '회사명'},                          60,     'text', {textAlignment: "center"});
    addField(cm,    'PLANT_CODE',                   {text: '플랜트코드'},                           60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PLANT_NAME',                   {text: '플랜트'},                           60,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_DOC_TXT',               {text: '업체비고'},                         200,     'text', {textAlignment: "near"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    
    addField(cm,    'APPROVE_DOC_TXT',              {text: '승인자비고'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'LOC_RETURN_DESC',              {text: '물류반려사유'},                     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_RETURN_DESC',              {text: '구매반려사유'},                     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PO_ORG',                       {text:'구매조직(구매그룹)'},                60,     'text', {textAlignment: "center"},{visible:false});
    
    addField(cm,    'CRUD',                         {text: 'CRUD'},                           0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',                      {text: '회사코드'},                           0,     'text', {textAlignment: 'center'},  {visible:false});

    
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
        if (colIndex.fieldName === "DOC_NO") {
        	fnSearchDetail();
        }
        
        if (colIndex.fieldName === "CODEMAPPING1") {
        	fnSearchDeliveryHistory();
        }         
    };

	gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 50;
            loadNext();
        }
    }

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };

    

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectScheduledArrival');
}

function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+49});
    
    ajaxJsonCall('<c:url value="/com/wrh/selectScheduledArrival.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
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
 * 이력 팝업
 */
function fnSearchDeliveryHistory() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridView, gridView.getCurrent().itemIndex));
	var target    = "deliveryHistory";
	var width     = "900";
	var height    = "575";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhDeliveryHistory', params, target, width, height, scrollbar, resizable);
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
 * 입고예정상세
 */
function fnSearchDetail() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridParams(gridView));
	
	var target    = "wrhStockDueDate";
	var width     = "1320";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('wrhStockDueDate', params, target, width, height, scrollbar, resizable);

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
                    <th><span>문서번호</span></th>
                    <td>
                        <input type="text" id="TB_DOC_NO" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>진행상태</span></th>
                    <td>
	                    <select id="SB_STAT_CD" name="SB_STAT_CD" data-type="select" data-bind="selectedOptions: SB_STAT_CD">
		                    <option>전체</option>
	                    </select>
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
