<%--
	File Name : bdgTravelCal.jsp
	Description: 예산 > 현황 > 예산실적 > 전표내역팝업
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.18  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compList     = new Array();
var statusCodes  = new Array();
var statusLabels = new Array();

$(document).ready(function() {
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
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
  
    addField(cm,    'SALE_NO',               {text:'전표번호'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ACCOUNT_DATE',          {text:'전표일자'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ACCOUNT_AMT',           {text:'금액'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'APPROVAL_STATUS',       {text:'승인구분'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'SUM_DESC',              {text:'적요'},                         60,     'text', {textAlignment: "near"});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_4       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

}
/**
 * 조회
 */
function fnSearch() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"COMP_CD" : '${PARAM.SB_COMP_CD}', "CRTN_YYMM" : '${PARAM.TB_CRTN_YYMM}', "CCTR_CD" : '${PARAM.SB_CCTR_CD}', "ACCOUNT_NO": '${PARAM.ACCOUNT_NO}', "PROCESS_TYPE": '${PARAM.PROCESS_TYPE}'});
	searchCall(gridView, '/com/bdg/selectResultPop', null, params);
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
<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
</div>
<br>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
