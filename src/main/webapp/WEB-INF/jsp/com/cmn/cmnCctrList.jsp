<%--
	File Name : cmnCctrList.jsp
	Description: 코스트센터 조회 화면
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

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<script language="javascript">
var gridView;
var compCodes  = new Array();
var compLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();	
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
 	// 그리드 생성
 	setInitGrid();
 	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	compCodes  = getComboSet('${CODELIST_SYS001}', 'CODE');
	compLabels = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
	var compCdList = stringToArray("${CODELIST_SYS001}");
    fnMakeComboOption('SB_COMP_CD', compCdList, 'CODE', 'CODE_NM', '${PARAM.SB_COMP_CD}');
    
    if (isNotEmpty('${PARAM.COMP_GUBN}')) {
    	$('#TB_COMP_GUBN').val('${PARAM.COMP_GUBN}');
    	$('#SB_COMP_CD').val('1100');
    }
    
    
	if(opener){
    	var progressingDivHtml = 
            '<div class="loading-area">'
           +   '<div class="loading">' 
           +   '<strong>처리 진행중 입니다.</strong>' 
           +   '<p>잠시만 기다려주시기 바랍니다.</p>' 
           +   '</div>' 
           +'</div>'
           $(progressingDivHtml).appendTo('body');

	}

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/cmn/selectCctrList');	
}

/**
 * 조회 성공 후 처리
 */
function fnSearchSuccess(data) {
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
 * 그리드 기본  셋팅
 */
function setInitGrid() {
	var gridId = "gridView";
	gridView = new RealGridJS.GridView(gridId);
	
	var cm = [];
    addField(cm,    'COMP_CD',          {text: '회사'},        100,     'text', {textAlignment: "center"},{lookupDisplay: true,values:compCodes,labels:compLabels},'dropDown');
	addField(cm ,	'ORG_CD',		    {text: '부서코드'},	    100,		'text', 	{textAlignment: "center"});
	addField(cm ,	'ORG_NM',	     	{text: '부서명'},	 	    150,		'text', 	{textAlignment: "near"});
	addField(cm ,	'CCTR_CD',		    {text: '코스트센터'},  100,		'text', 	{textAlignment: "center"});
	addField(cm ,	'CCTR_NM',		    {text: '코스트센터명'},	150,		'text', 	{textAlignment: "near"});
		
	gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
       ,columns        : cm        // required
       ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,copySingle : false // default ture : 복사하지 않음
       //,autoHResize    : true       //화면 크기에 맞게 높이 자동조절
       ,viewCount      : true       //조회 건수 표시
   });

    gridView.onDataCellDblClicked =  function (grid, index) {
  	  setOpenerData(grid.getCurrentRow());
  	};

}

//부모창에 선택값 셋팅함수 호출
function setOpenerData(rowData) {
	if ('${PARAM.COMP_GUBN}' == 'A' || '${PARAM.COMP_GUBN}' == 'B') {
		parentCallback('fnCallbackDeptSamplePop',rowData);
	} else {
		parentCallback('fnCallbackPop',rowData);	
	}
	
}


</script>

<div class="tit-area">
	<h3>코스트 센터</h3>
	<div class="btnArea abtit">
	</div>
</div>	

		
<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
			<colgroup>
                <col style="width:70px">
                <col style="width:200px">
                <col style="width:70px">
                <col style="width:200px">
                <col style="width:130px">
                <col style="width:200px">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th><span>회사</span></th>
					<td>
						<select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" disabled="disabled">
					</td>
					<th><span>부서명</span></th>
					<td>
						<input type="text" id="TB_ORG_NM" value="">
					</td>
					<th><span>코스트센터명</span></th>
					<td>
						<input type="text" id="TB_CCTR_NM" value="">
						<input type="hidden" id="TB_COMP_GUBN" value="${PARAM.COMP_GUBN}"/>
						<input type="hidden" id="TB_ORG_CD" value="${PARAM.SB_ORG_CD}"/>
					</td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- //searchWrap -->
<br/>		
<div class="realgrid-area">
	<div id="gridView"></div>
</div>