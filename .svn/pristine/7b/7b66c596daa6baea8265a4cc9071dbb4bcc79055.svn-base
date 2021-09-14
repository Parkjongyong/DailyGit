<%--
	File Name : bdgAccountMgmt.jsp
	Description: 예산 > 예산관리 > 경영예산계정관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.24  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.24
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compCodes  = new Array();
var compLabels = new Array();

var clauseCdCodes  = new Array();
var clauseCdLabels = new Array();

var useYnCodes  = new Array();
var useYnLabels = new Array();

var useYCodes  = new Array();
var useYLabels = new Array();

var rowIndex = "";
var popGubn  = "";

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}");
	var clauseCdList = stringToArray("${CODELIST_YS006}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD' , compList,      'CODE', 'CODE_NM', null, "","전체");
    fnMakeComboOption('SB_CLAUSE_CD', clauseCdList, 'CODE', 'CODE_NM', null, "","전체");   
    
    clauseCdCodes  = getComboSet('${CODELIST_YS006}', 'CODE');
    clauseCdLabels = getComboSet('${CODELIST_YS006}', 'CODE_NM');
    
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');
    
    useYCodes  = getComboSet('${CODELIST_E102}', 'CODE', 'Y');
    useYLabels = getComboSet('${CODELIST_E102}', 'CODE_NM', 'Y');    
    useYCodes.push("");
    useYLabels.push("");
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGrid();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
}

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
  
    addField(cm ,   'CLAUSE_CD',        {text:'항목'},      60,       'text',  {textAlignment: 'center'},  {lookupDisplay: true, values:clauseCdCodes, labels:clauseCdLabels}, 'dropDown');
    addField(cm,    'ACCOUNT_NO',       {text: '계정코드'},     80,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'ACCOUNT_DESC',     {text: '계정명'},     120,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'CODEMAPPING1',     {text: ' '},          15,     'popupLink');
    addField(cm,    'ETC_ORDER_NO',     {text: 'ETC내부오더'},   80,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'ETC_ORDER_NM',   	{text: 'ETC내부오더명'},    120,     'text',  {textAlignment: "near"}  ,  {editable:false});
    addField(cm,    'CODEMAPPING2',     {text: ' '},          15,     'popupLink');
    addField(cm,    'CHC_ORDER_NO',     {text: 'CHC내부오더'},   80,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'CHC_ORDER_NM',   	{text: 'CHC내부오더명'},    120,     'text',  {textAlignment: "near"}  ,  {editable:false});
    addField(cm,    'CODEMAPPING3',     {text: ' '},          15,     'popupLink');
    addField(cm ,   'DISTRIB_YN',        {text:'유통판촉비계정여부'},      60,       'text',  {textAlignment: 'center'},  {lookupDisplay: true, values:useYCodes, labels:useYLabels}, 'dropDown');
    addField(cm ,   'DISPLAY_YN',        {text:'DISPLAY구분'},      60,       'text',  {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels}, 'dropDown');
    
    addField(cm,    'CRUD',             {text: 'CRUD'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',          {text: '회사'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
        
    });
    
    //셀이 수정된후 
    gridView.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };

    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	var curr = grid.getCurrent();
        var editable = false;
        if (newRow === -1 && curr.itemIndex > -1) {
            editable = true;
        } else if (newRow === -1 && curr.itemIndex === -1) {
            editable = false;
        } else {
            if (grid.getRowState(curr.itemIndex) === "created") {
                editable = true;
            }
        }
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.CRUD;
        if (gubn == 'I') {
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var clauseCd = values.CLAUSE_CD;
        if(clauseCd == '3'){
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 기본 스타일 적용(수정불가)
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };
    
    // 기본 스타일 적용(수정가능)
    var columnDefaultStyles2 = function(grid, index, value) {
        return enableColStyle;
    };     
    
    gridView.setColumnProperty("CLAUSE_CD"  , "dynamicStyles", columnDynamicStyles);
    
    gridView.setColumnProperty("ACCOUNT_NO"   , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ACCOUNT_DESC" , "dynamicStyles", columnDefaultStyles);  
    gridView.setColumnProperty("ETC_ORDER_NO" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ETC_ORDER_NM" , "dynamicStyles", columnDefaultStyles);    
    gridView.setColumnProperty("CHC_ORDER_NO" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CHC_ORDER_NM" , "dynamicStyles", columnDefaultStyles);
    
    gridView.setColumnProperty("DISTRIB_YN" , "dynamicStyles", columnDynamicStyles2);
    gridView.setColumnProperty("DISPLAY_YN" , "dynamicStyles", columnDefaultStyles2);
    

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked =  function (grid, data) {
    	// 계정코드
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchAccount(data.itemIndex);
        }
        
        if (data.column == "CODEMAPPING2" || data.column == "CODEMAPPING3") {
        	fnSearchProj(data);
        }        
    };
    
}

/**
 * 계정 조회
 */
function fnSearchAccount(rIndex) {
	rowIndex = rIndex;
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ACCOUNT_GUBN" : "O"});
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/accountSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 팝업 콜백
 */
function fnCallbackAccountSearchPop(rows) {
// 	var values = {
// 	         "ACCOUNT_NO"   : rows.ACCOUNT_NO
// 	       , "ACCOUNT_DESC" : rows.ACCOUNT_DESC
// 	     };
	
	gridView.setRowValue(gridView.getCurrent().itemIndex, "ACCOUNT_NO", rows.ACCOUNT_NO);
	gridView.setRowValue(gridView.getCurrent().itemIndex, "ACCOUNT_DESC", rows.ACCOUNT_DESC);

}

/**
 * 프로젝트 조회
 */
function fnSearchProj(data) {
	var params = {};
	rowIndex = data.itemIndex;
	popGubn = data.column;
	$.extend(params, fnGetParams());
	var target    = "cmnProjSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/projList', params, target, width, height, scrollbar, resizable);
}

/**
 * 프로젝트 콜백
 */
function fnCallbackProjSearchPop(rows) {
	if (popGubn == "CODEMAPPING2") {
// 		var values = {
// 		         "ETC_ORDER_NO"   : rows.ORDER_NO
// 		       , "ETC_ORDER_NM" : rows.ORDER_DESC
// 		     };

		gridView.setRowValue(gridView.getCurrent().itemIndex, "ETC_ORDER_NO", rows.ORDER_NO);
		gridView.setRowValue(gridView.getCurrent().itemIndex, "ETC_ORDER_NM", rows.ORDER_DESC);
		
	}
	if (popGubn == "CODEMAPPING3") {
// 		var values = {
// 		         "CHC_ORDER_NO"   : rows.ORDER_NO
// 		       , "CHC_ORDER_NM" : rows.ORDER_DESC
// 		     };
		
		gridView.setRowValue(gridView.getCurrent().itemIndex, "CHC_ORDER_NO", rows.ORDER_NO);
		gridView.setRowValue(gridView.getCurrent().itemIndex, "CHC_ORDER_NM", rows.ORDER_DESC);		

	}	
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectAccountMgmtList');
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

//행삭제
var fnRowDel = function(){
	fnAddRowDelete(gridView);
}

//행추가
function fnRowAdd() {
	var values = {"CODEMAPPING1":"1", "CODEMAPPING2":"1", "CODEMAPPING3":"1", "CRUD" : "I", "COMP_CD" : $('#SB_COMP_CD').val(), "CLAUSE_CD" : $("#SB_CLAUSE_CD").val()};
	fnAddRow(gridView, values);
}

//삭제
var fnDel = function(){
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		// 조회 요청
		deleteCall(gridView, '/com/bdg/deleteAccontMgmt', null, params);
	}
	
}

//저장
var fnSave = function(){
	// 그리드 수정사항 확정처리
	gridView.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CLAUSE_CD", "ACCOUNT_NO"];

	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveAccountMgmt', null, params);
	     }
	}
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <th><span>항목</span></th>
                    <td>
	                    <select id="SB_CLAUSE_CD" name="SB_CLAUSE_CD" data-type="select" data-bind="selectedOptions: SB_CLAUSE_CD" onchange="fnSearch();">
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

<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDel">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>