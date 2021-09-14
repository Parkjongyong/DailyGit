<%--
	File Name : bdgEstCostReq.jsp
	Description: 예산 > 예산관리 > 원가검토의뢰
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.06  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.06
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

var compCodes  = new Array();
var compLabels = new Array();

var statusCodes  = new Array();
var statusLabels = new Array();

var itemCodes  = new Array();
var itemLabels = new Array();

var distribCodes  = new Array();
var distribLabels = new Array();

var reqCodes  = new Array();
var reqLabels = new Array();


var deptPopGubn  = "";
$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");

	var statusList  = stringToArray("${CODELIST_YS024}");
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");
	
	statusCodes  = getComboSet('${CODELIST_YS024}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS024}', 'CODE_NM');
	
	itemCodes  = getComboSet('${REQUESTITEM1}', 'CODE');
	itemLabels = getComboSet('${REQUESTITEM1}', 'CODE_NM');
	
	distribCodes  = getComboSet('${REQUESTITEM2}', 'CODE');
	distribLabels = getComboSet('${REQUESTITEM2}', 'CODE_NM');
	
	reqCodes  = getComboSet('${REQUESTITEM3}', 'CODE');
	reqLabels = getComboSet('${REQUESTITEM3}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGrid();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    var epsDocNo = '${PARAM.EPS_DOC_NO}';
    if(isNotEmpty(epsDocNo) == true){
    	$("#EPS_DOC_NO").val(epsDocNo);
    	fnSearch();
    }
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	$("#TB_ORG_CD").val('${PARAM.TB_ORG_CD}');
	$("#TB_ORG_NM").val('${PARAM.TB_ORG_NM}');
}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    addField(cm,    'STATUS',               {text:'진행상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable:false},'dropDown');
    addField(cm,    'CTRN_YMD',             {text:'의뢰일자'},         60,            'text',           {textAlignment:"center"});
    addField(cm,    'REQ_DOC_NO',           {text:'견적번호'},         60,            'text',           {textAlignment:"center"});
    addField(cm,    'DOC_TITLE',            {text:'제목'},             200,            'textLink',           {textAlignment:"near"});
    addField(cm,    'ITEM_TYPE',            {text:'품목분류'},         100,            'text',           {textAlignment:"near"},{lookupDisplay: true,values:itemCodes,labels:itemLabels, editable:false},'dropDown');
    addField(cm,    'DISTRIB_TYPE',         {text:'유통분류'},         100,            'text',           {textAlignment:"near"},{lookupDisplay: true,values:distribCodes,labels:distribLabels, editable:false},'dropDown');
    addField(cm,    'REQ_TYPE',             {text:'견적유형'},         100,            'text',           {textAlignment:"near"},{lookupDisplay: true,values:reqCodes,labels:reqLabels, editable:false},'dropDown');
    addField(cm,    'PRODUCT_NM',           {text:'제품명'},          200,            'text',           {textAlignment:"near"});
    
    addField(cm,    'COMP_CD',              {text: '회사'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    

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
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.CRUD;
        if (gubn == 'I') {
            styles.editable = true;
        } else {
        	styles.editable = false;
        	styles.background = "#e4e4e4";
        }

        return styles;
    };
    
    
    gridView.onDataCellClicked = function (grid, data) {
        if (grid.getCurrentRow().CRUD == "R") {
        	$("#TB_REQ_DOC_NO").val(grid.getCurrentRow().REQ_DOC_NO);
        	$("#REQ_DOC_NO").val(grid.getCurrentRow().REQ_DOC_NO);
        	$("#TB_CTRN_YMD").val(grid.getCurrentRow().CTRN_YMD);
        	$("#STATUS").val(grid.getCurrentRow().STATUS);
        	fnRequest();
        }
	
    };
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
}

/**
 * 의뢰서 작성
 */
function fnRequest() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "bdgEstCostDetail";
	var width     = "1200";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgEstCostDetail', params, target, width, height, scrollbar, resizable);

}



/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectEstCostReqListPop');
}


/**
 * 조회 후 처리
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
                <col style="width:70px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>부서</span></th>
                    <td>
	                    <input type="text" id="TB_ORG_NM" name="TB_ORG_NM" disabled="disabled">              
	                    <input type="hidden" id="TB_ORG_CD">
	                    <input type="hidden" id="EPS_DOC_NO"/>
	                    <input type="hidden" id="STATUS">
	                    <input type="hidden" id="TB_REQ_DOC_NO"/>
	                    <input type="hidden" id="REQ_DOC_NO"/>
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
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
