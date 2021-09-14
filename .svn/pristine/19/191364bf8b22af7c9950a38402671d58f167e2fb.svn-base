<%--
	File Name : bdgTravelCalDetail.jsp
	Description: 예산 > 영업관리 > 영업출장비정산 > 영업출장비세부내역
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.25  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.25
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
var orgCd        = "";

$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ORG_CD',                   {text:'부서코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ORG_NM',                   {text:'부서명'},                         60,     'text', {textAlignment: "near"});
    addField(cm,    'SABUN',                    {text:'사원코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'SABUN_NM',                 {text:'사원명'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'TRANS_AMT',                {text:'교통비'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'TRAVEL_AMT',               {text:'출장비'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'ROOM_AMT',                 {text:'숙박비'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'EXCEPT_AMT',               {text:'차감액'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'SEND_AMT',                 {text:'송금액'},                         60,     'integer', {textAlignment: "far"});
    
    addField(cm,    'COMP_CD',                 {text: '회사코드'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',               {text: '기준년월'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SAP_SEND_YN',             {text: 'SAP전송여부'},      0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'LEGACYNO',                {text: 'SAPLegacy 시스템 관리 번호'},      0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SAP_SEND_YMD',            {text: 'SAP전송일자'},      0,     'text', {textAlignment: "center"},{visible:false});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이
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
	$.extend(params, {"SB_COMP_CD" : '${PARAM.SB_COMP_CD}', "TB_CRTN_YYMM" : '${PARAM.TB_CRTN_YYMM}', "SB_CHC_ETC_GBN" : '${PARAM.SB_CHC_ETC_GBN}', "TB_ORG_CD" : '${PARAM.TB_ORG_CD}'});
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectTravelCalDetail','fnSearch', params);
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
    <h3>영업출장비세부내역</h3>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
