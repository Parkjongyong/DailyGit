<%--
	File Name : wrhPurchaser.jsp
	Description: 입고예정 > 담당자관리 > 구매담당자
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.07  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.07
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compCodes  = new Array();
var compLabels = new Array();
var purGroupCodes  = new Array();
var purGroupLabels = new Array();

var compList = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	compList         = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	var purGroupList = stringToArray("${CODELIST_IG001}", "ALL");
	
    // 개별코드 생성(그리드용)
    compCodes      = getComboSet('${CODELIST_SYS001}', 'CODE');
    compLabels     = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
    purGroupCodes  = getComboSet('${CODELIST_IG001}', 'CODE');
    purGroupLabels = getComboSet('${CODELIST_IG001}', 'CODE_NM');
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");
    fnMakeComboOption('SB_PO_ORG' , purGroupList, 'CODE', 'CODE_NM', null, "","전체");
    
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
	if (getComboIndex(compList, "CODE", '${LOGIN_INFO.COMP_CD}') > -1) {
		$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	}
}

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
  
    addField(cm,    'COMP_CD',          {text: '회사'},      100,     'text', {textAlignment: "near"},   {visible:false});
    addField(cm,    'COMP_NM',          {text: '회사명'},      100,     'text', {textAlignment: "near"},   {lookupDisplay: true,values:compCodes,labels:compLabels},'dropDown');
    addField(cm,    'PO_ORG',        	{text: '구매그룹'},   100,     'text', {textAlignment: "near"},   {lookupDisplay: true,values:purGroupCodes,labels:purGroupLabels},'dropDown');
    addField(cm,    'ORG_CD',   		{text: '부서코드'},   100,     'text',  {textAlignment: "center"},  {visible:false});
    addField(cm,    'ORG_NM',   		{text: '부서명'},    100,     'text',  {textAlignment: "near"},{visible:false} );
    addField(cm,    'DUTY_NAME',     	{text: '직급'},      100,     'text',  {textAlignment: "center"});
    addField(cm,    'DUTY_CODE',     	{text: '직급코드'},      100,     'text',  {textAlignment: "center"},   {visible:false});
    addField(cm,    'PURCHASER_ID',     {text: '담당자ID'},  100,     'text',     {textAlignment: 'near'},  {visible:false});
    addField(cm,    'PURCHASER_NAME',   {text: '담당자'},    100,     'text',   {textAlignment: 'center'});
    addField(cm,    'CODEMAPPING',  	{text: ' '},    15,     'popupLink');
    addField(cm,    'MOBILE_NO',        {text: '연락처'},    120,     'text',     {textAlignment: 'center'});
    addField(cm,    'EMAIL_ID',         {text: 'EMAIL'},   200,     'text',     {textAlignment: 'near'});
    addField(cm,    'CRUD',            {text: 'CRUD'},      0,     'text',      {textAlignment: 'center'},  {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
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

//     gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
//     	var curr = grid.getCurrent();
//         var editable = false;
//         if (newRow === -1 && curr.itemIndex > -1) {
//             editable = true;
//         } else if (newRow === -1 && curr.itemIndex === -1) {
//             editable = false;
//         } else {
//             if (grid.getRowState(curr.itemIndex) === "created") {
//                 editable = true;
//             }
//         }
        
// 		fnEditableFalse(grid);
		
//         grid.setColumnProperty("DUTY_NAME", "editable", false);
//         grid.setColumnProperty("PURCHASER_NAME", "editable", false);
//         grid.setColumnProperty("MOBILE_NO", "editable", false);
//         grid.setColumnProperty("EMAIL_ID", "editable", false);
//         fnEditableStyle(grid);
//     };
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.CRUD;
        if (gubn == 'I') {
            styles.editable = true;
            styles.background = "#d5e2f2";
        } else {
        	styles.editable = false;
        }

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };
    
    gridView.setColumnProperty("PO_ORG"         , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("CODEMAPPING" , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("COMP_NM"       , "dynamicStyles", columnDynamicStyles);
     
    gridView.setColumnProperty("DUTY_NAME"  , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("STATUS"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("MOBILE_NO"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("EMAIL_ID"       , "dynamicStyles", columnDefaultStyles);
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
//     	grid.setValue(grid.getCurrent().itemIndex, "COMP_NM" ,grid.getDisplayValues(grid.getCurrent().itemIndex, "COMP_CD").COMP_CD);
    };
    
    gridView.onDataCellClicked =  function (grid, index) {
        if (index.column == "CODEMAPPING" && grid.getCurrentRow().CRUD == "I") {
            fnDeptDetail(grid);
        }
    };
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWhrPurchaserList');
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
	var values = {"COMP_NM" :  $("#SB_COMP_CD").val(), "PO_ORG" : $("#SB_PO_ORG").val(), "CODEMAPPING":"1", "CRUD" : "I"};
	fnAddRow(gridView, values);
}

//삭제
var fnDel = function(){
    var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		// 조회 요청
		deleteCall(gridView, '/com/wrh/deletePurchaser', null, params);
	}
	
}

//저장
var fnSave = function(){
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	for(var i = 0; i < checkedRows.length; i++){
		if(checkedRows[i].CRUD == "R"){
			alert("기등록된 데이터는 저장 할 수 없습니다.");
			return false;
		}
	}

	gridView.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_NM", "PO_ORG", "ORG_CD", "PURCHASER_ID"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/savePurchaser', null, params);
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
function fnDeleteFail(data) {
	alert(data.errMsg);
}

/**
 * 그리드의 상세보기 클릭시 이벤트
 */
function fnDeptDetail(grid) {
	var curr = grid.getCurrent();
	if(isEmpty(grid.getRowValue(curr.itemIndex, "COMP_NM")) == true){
		alert("회사선택 후 클릭 가능합니다.");
		return false;
	}
	
	
    var params = fnGetParams();
    params.SB_COMP_NM = grid.getDisplayValues(grid.getCurrent().itemIndex, "COMP_NM").COMP_NM;
    params.SB_COMP_CD = grid.getRowValue(curr.itemIndex, "COMP_NM");
    var target = "sysDept";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 팝업 콜백
 */
function fnCallbackPop(rows) {
	var values = {
			         "ORG_CD"         : rows.DEPT_CD
			       , "ORG_NM"         : rows.DEPT_NM
			       , "DUTY_NAME"      : rows.DUTY_NAME
			       , "DUTY_CODE"      : rows.DUTY_CODE
			       , "PURCHASER_ID"   : rows.USER_ID
			       , "PURCHASER_NAME" : rows.USER_NM
			       , "MOBILE_NO"      : rows.MOBILE_NO
			       , "EMAIL_ID"       : rows.EMAIL_ID
			     };
	
	gridView.setValues(gridView.getCurrent().itemIndex, values);
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
                <col style="width:100px;"><!-- 타이틀 길이에 따라 가변적 -->
                <col style="width:450px;">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD">
	                    </select>
                    </td>
                    <th><span>구매그룹</span></th>
                    <td>
	                    <select id="SB_PO_ORG" name="SB_PO_ORG" data-type="select" data-bind="selectedOptions: SB_PO_ORG">
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