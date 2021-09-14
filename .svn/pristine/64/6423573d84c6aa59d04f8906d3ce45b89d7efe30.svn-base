<%--
	File Name : bdgDeptCustomerMgmt.jsp
	Description: 예산 > 영업관리 > 부서거래처관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.26  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.11.26
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compCodes  = new Array();
var compLabels = new Array();

var rowIndex = "";

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD' , compList,      'CODE', 'CODE_NM', null, "","전체");

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
	$("#SB_COMP_CD").val('1100');
}

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
  
    addField(cm,    'CUST_CD',          {text: '거래처코드'},     120,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'CUST_NAME1',       {text: '거래처명'},     150,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'CUST_NAME1',       {text: '거래처명'},     150,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'ORG_CD',           {text: '부서코드'},     150,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'ORG_NM',           {text: '부서명'},      150,     'text', {textAlignment: "center"}   ,  {editable:false});
    addField(cm,    'CODEMAPPING1',     {text: ' '},          15,     'popupLink');
    addField(cm,    'CRUD',             {text: 'CRUD'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',          {text: '회사'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
    
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
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked =  function (grid, data) {
    	// 부서
        if (data.column == "CODEMAPPING1") {
        	fnSearchDept();
        }
    };
    
}

/**
 * 부서 조회
 */
function fnSearchDept() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnDeptSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/deptList', params, target, width, height, scrollbar, resizable);
}

/**
 * 부서 콜백
 */
function fnCallbackDeptSearchPop(rows) {
	var values = {
	         "ORG_CD"   : rows.DEPT_CD,
	         "ORG_NM"   : rows.DEPT_NM,
	     };
	gridView.setValues(gridView.getCurrent().itemIndex, values);
	gridView.checkItem(gridView.getCurrent().itemIndex, true);
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectDeptCustomerMgmtList');
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


//삭제
var fnDel = function(){
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		// 조회 요청
		deleteCall(gridView, '/com/bdg/deleteDeptCustomerMgmt', null, params);
	}
	
}

//저장
var fnSave = function(){
	// 그리드 수정사항 확정처리
	gridView.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ORG_CD"];

	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveDeptCustomerMgmt', null, params);
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>항목</span></th>
                    <td>
						<input type="text" id="TB_CUST_NAME"	style="width: 150px;"/>
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
        <button type="button" class="btn" id="btnDel">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>