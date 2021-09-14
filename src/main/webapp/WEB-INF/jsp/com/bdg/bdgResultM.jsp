<%--
	File Name : bdgTravelCal.jsp
	Description: 예산 > 현황 > 예산실적관리
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

var processTypeCodes  = new Array();
var processTypeLabels = new Array();

$(document).ready(function() {
	
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM');
    
	var bdgGubnList  = stringToArray("${CODELIST_YS034}");
	fnMakeComboOption('SB_BGD_GUBN', bdgGubnList,     'CODE', 'CODE_NM');
	
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	
    
    fnCompCdChange();
    
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
	//$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PROCESS_TYPE',             {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'ACCOUNT_NO',               {text:'계정코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ACCOUNT_DESC',             {text:'계정명'},                         60,     'text', {textAlignment: "near"});
    addField(cm,    'WK_M',                     {text:'예산'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'ACCOUNT_AMT',              {text:'실적'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'ACCOUNT_AMT_Y',            {text:'승인금액'},                         60,     'textLink', {textAlignment: "far"});
    addField(cm,    'ACCOUNT_AMT_N',            {text:'미승인금액'},                         60,     'textLink', {textAlignment: "far"});
    addField(cm,    'AVAILABLE_AMT',            {text:'가용금액'},                         60,     'integer', {textAlignment: "far"});
    
    addField(cm,    'COMP_CD',                 {text: '회사코드'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',               {text: '기준년월'},         0,     'text', {textAlignment: "center"},{visible:false});

    
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
    
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	if(colIndex.fieldName == "ACCOUNT_AMT_Y" || colIndex.fieldName == "ACCOUNT_AMT_N"){ 
       		//var str = gridView.getValue(colIndex.itemIndex,"ACCOUNT_NO");
       		fnSearchDetail(colIndex.itemIndex);
       	}

    };


}
/**
 * 조회
 */
function fnSearch() {
	if(isEmpty($("#SB_CCTR_CD").val()) == true){
		alert("코스트센터를 선택해주세요.");
		return false;
	}
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectResult');
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
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
}


/**
 * 전표 조회
 */
function fnSearchDetail(itemIndex) {
	var params = {};
	$.extend(params, fnGetParams());
	var accountNo  = gridView.getValue(itemIndex,"ACCOUNT_NO");
	var processType = gridView.getValue(itemIndex,"PROCESS_TYPE");
	$.extend(params, {"ACCOUNT_NO" : accountNo});
	$.extend(params, {"PROCESS_TYPE" : processType});
	
	var target    = "bdgResultPop";
	var width     = "1200";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgResultPop', params, target, width, height, scrollbar, resizable);
}
/**
 * 코스트 조회
 */
function fnSearchCctr() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnCctrSearchPop";
	var width     = "900";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/cctrList', params, target, width, height, scrollbar, resizable);
}

/**
 * 코스트 콜백
 */
function fnCallbackPop(rows) {
	$("#SB_CCTR_CD").val(rows.CCTR_CD);
	$("#TB_CCTR_NM").val(rows.CCTR_NM);
	fnSearch();
}

//코스트 리셋
function fnCctrReset() {
	$("#SB_CCTR_CD").val("");
	$("#TB_CCTR_NM").val("");
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();"></select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:70px;"/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_CCTR_NM" disabled="disabled">
                        <input type="hidden" id="SB_CCTR_CD">
                        <a href="javascript:fnSearchCctr('header');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <td></td>
                </tr>            
                <tr>
                    <th><span>예산구분</span></th>
                    <td>
	                    <select id="SB_BGD_GUBN" name="SB_BGD_GUBN"></select>
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
    <div class="tbl-search-area" style="float:left;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 15px;">(단위 : 원)</th>
	        	<td></td>
	        </tr>
		</table>
	</div>
<br>
<br>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
