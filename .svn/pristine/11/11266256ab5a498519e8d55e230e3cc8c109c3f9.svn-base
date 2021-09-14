<%--
	File Name : wrhScheduledArrival.jsp
	Description: 입고예정 > 기준정보 > 자재마스터정보
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.23  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.23
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
var gridParam    = {};
var scrollItem = 20;

$(document).ready(function() {
	
	compList    = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	var matTypeList = stringToArray("${CODELIST_IG002}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', "", "", "전체");
    
    fnMakeComboOption('SB_MAT_TYPE', matTypeList, 'CODE', 'CODE_NM', null, "", "전체");
    
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
	
	if (getComboIndex(compList, "CODE", '${LOGIN_INFO.COMP_CD}') > -1) {
		$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
		fnCompCdChange();
	}	
	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'MAT_NUMBER',                   {text:'자재 번호'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_TYPE',                   {text:'자재유형'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_TYPE_TXT',                   {text:'자재유형명'},                         100,     'text', {textAlignment: "near"});
    addField(cm,    'UNIT_MEASURE',                   {text:'기본 단위'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_GROUP',                   {text:'자재 그룹'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'MAT_DESC',                   {text:'자재내역'},                         200,     'text', {textAlignment: "near"});
    addField(cm,    'PLANT_CODE',                   {text:'플랜트코드'},                          0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PLANT_NAME',                   {text:'플랜트'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'DRAFT_FLAG',                   {text:'화판번호관리대상'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'BOX_QTY',                   {text:'원박스입수'},                         60,     'number', {textAlignment: "far"});
    addField(cm,    'PLT_QTY',                   {text:'PLT 입상수수량'},                         60,     'number', {textAlignment: "far"});
    
//     addField(cm,    'APPROVE_DOC_TXT',              {text: '승인자비고'},                    60,     'text', {textAlignment: "center"},{visible:false});
//     addField(cm,    'LOC_RETURN_DESC',              {text: '물류반려사유'},                     60,     'text', {textAlignment: "center"},{visible:false});
//     addField(cm,    'ORG_RETURN_DESC',              {text: '구매반려사유'},                     60,     'text', {textAlignment: "center"},{visible:false});
//     addField(cm,    'PO_ORG',                       {text:'구매조직(구매그룹)'},                60,     'text', {textAlignment: "center"},{visible:false});
//     addField(cm,    'PO_ORG_NM',                    {text:'구매그룹명'},                        60,     'text', {textAlignment: "center"},{visible:false});
//     addField(cm,    'CRUD',                         {text: 'CRUD'},                           0,     'text', {textAlignment: 'center'},  {visible:false});
//     addField(cm,    'COMP_CD',                      {text: '회사코드'},                           0,     'text', {textAlignment: 'center'},  {visible:false});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
	gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 50;
            loadNext();
        }
    }     
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectMatInfo');
}


/**
 * 페이징 처리 조회
 */
function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+49});
    
    ajaxJsonCall('<c:url value="/com/wrh/selectMatInfo.do"/>',  params, function(data){
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
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM', null, "", "전체");
    
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
	                    <select id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD">
		                    <option value="">전체</option>
	                    </select>
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
                    <th><span>자재번호</span></th>
                    <td>
                        <input type="text" id="TB_MAT_NUMBER" />
                    </td>
                    <th><span>자재내역</span></th>
                    <td>
                        <input type="text" id="TB_MAT_DESC" />
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
<br/>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
