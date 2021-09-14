<%--
	File Name : wrhInvoiceInfoDetailV.jsp
	Description: 입고관리 > 마감정보 > 송장마감정보 > 마감상세현황
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

<script type="text/javascript">
var gridView;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {

	var a = "${PARAM}";
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
	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'IV_DOC_DATE',      {text: '전기일'},        60,     'text', {textAlignment: "center"});
    addField(cm,    'PO_NUMBER',        {text: '발주번호'},      60,     'text', {textAlignment: "center"});
    addField(cm,    'PO_SEQ',           {text: '발주항번'},      40,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_NUMBER',       {text: '자재코드'},      60,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_DESC',         {text: '자재내역'},      100,     'text', {textAlignment: "near"});
    addField(cm,    'GR_DATE',          {text: '입고일'},        50,     'text', {textAlignment: "center"});
    addField(cm,    'TAX_BILL_NUMBER',  {text: '세금계산서번호'},60,     'text', {textAlignment: "center"});
    addField(cm,    'IV_NUMBER',        {text: '송장번호'},      60,     'text', {textAlignment: "center"});
    addField(cm,    'IV_SEQ',           {text: '송장항번'},      50,     'text', {textAlignment: "center"});
    addField(cm,    'CURR_CD',          {text: '통화'},          50,     'text', {textAlignment: "center"});
    addField(cm,    'IV_UNIT_MEASURE',  {text: '단위'},          50,     'text', {textAlignment: "center"});
    addField(cm,    'IV_QTY',           {text: '수량'},          60,     'integer', {textAlignment: "far"});
    addField(cm,    'IV_AMT',           {text: '금액'},          60,     'integer', {textAlignment: "far"});
    addField(cm,    'TAX_CD',           {text: '세금코드'},          40,     'text', {textAlignment: "center"});
    addField(cm,    'TAX_TXT',          {text: '세금코드내역'},       100,     'text', {textAlignment: "near"});
    
    addField(cm,    'ROW_GUBN',         {text: '행구분'},           60,     'text',     {textAlignment: "far"},{visible:false});


    //addField(cm,    'PO_ORG',          	 {text: '구매그룹'},       60,     'text', {textAlignment: "near"},{visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn = values.ROW_GUBN;
        if (gubn == '1') {
            //styles.background = "#faf4c0";
        } else {
        	styles.background = "#d4f4fa";
        }

        return styles;
    };
    
    setDefaultStyle(gridView, "dynamicStyles",columnDynamicStyles);    

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectInvoiceInfoDetail');
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

</script>
	<section class="pop-wrap">
		<div class="pop-head">
			<h2>송장마감정보</h2>
		</div><!-- //popHead -->	

		<div class="pop-cont">
			<div class="sub-tit">
				<h4>마감상세현황</h4>
			</div>

		<table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly" value="${PARAM.TB_VENDOR_CD}"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly" value="${PARAM.TB_VENDOR_NM}"/>
                        <input type="hidden" id="TB_IV_DOC_MON" value="${PARAM.IV_DOC_MON}"/>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>                    
		</div><!-- //popCont -->
	</section>
<br>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
