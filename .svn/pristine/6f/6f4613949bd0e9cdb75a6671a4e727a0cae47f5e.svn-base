<%--
	File Name : wrhInvoiceInfoV.jsp
	Description: 입고관리 > 마감정보 > 송장마감정보
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.17  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.17
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

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {

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
	var dateObj = new Date();
	var y1 = dateObj.getFullYear();
	
	// 기간 시작인 셋팅
	$("#TB_START_MON").val(y1+"-01");
	$("#TB_END_MON").val(getDiffMon("m",0));
	
	//업체 자동 세팅
	$("#TB_VENDOR_CD").val('${LOGIN_INFO.VENDOR_CD}');
	$("#TB_VENDOR_NM").val('${LOGIN_INFO.VENDOR_NM}');
	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'IV_DOC_MON',       {text: '전기월'},      60,     'textLink', {textAlignment: "center"});
    addField(cm,    'CURR_CD',          {text: '통화'},       100,     'text', {textAlignment: "center"});
    addField(cm,    'IV_AMT',           {text: '송장금액'},   100,     'integer', {textAlignment: "far"});
    addField(cm,    'IV_TAX_AMT',       {text: '부가세'},     100,     'integer', {textAlignment: "far"});
    addField(cm,    'IV_AMT_TOT',       {text: '총 송장액'},  100 ,    'integer', {textAlignment: "far"});
    addField(cm,    'VENDOR_CD',        {text: '업체코드'},    80,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_NM',        {text: '업체명'},     120,     'text', {textAlignment: "center"});

    //addField(cm,    'PO_ORG',          	 {text: '구매그룹'},       60,     'text', {textAlignment: "near"},{visible:false});
    
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
        if (colIndex.fieldName === "IV_DOC_MON") {
        	fnSearchDetail();
        }
    };

}

/**
 * 조회
 */
function fnSearch() {
	if(isEmpty($("#TB_VENDOR_CD").val())){
		alert("업체를 입력해주세요.");
		return false;
	}
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectInvoiceInfo');
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
 * 발주현황상세
 */
function fnSearchDetail() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridParams(gridView));
	
	var target    = "wrhInvoiceInfoDetail";
	var width     = "1440";
	var height    = "840";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhInvoiceInfoDetail', params, target, width, height, scrollbar, resizable);

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
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly"/>
                    </td>
                    <th><span>전기월</span></th>
                    <td>
                        <input type="text" class="datepicker_ym" id="TB_START_MON" dateHolder="bgn" value="" style="width:70px;"/>
                        <em> ~ </em>
                        <input type="text" class="datepicker_ym" id="TB_END_MON" dateHolder="end" value="" style="width:70px;"/>
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
