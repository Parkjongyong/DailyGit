<%--
	File Name : wrhConfirmUser.jsp
	Description: 입고예정 > 담당자관리 > 승인담당자
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.09  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.09
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compList   = new Array();
var compCodes  = new Array();
var compLabels = new Array();

var purGroupCodes  = new Array();
var purGroupLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	compList = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', "", "", "전체");
    
    compCodes  = getComboSet('${CODELIST_SYS001}','CODE',"ALL","IPGO");
    compLabels = getComboSet('${CODELIST_SYS001}','CODE_NM',"ALL","IPGO");    
    
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
  
    addField(cm,    'COMP_CD',          {text: '회사'},      100,    'text',              {textAlignment: "center"},{lookupDisplay: true,values:compCodes,labels:compLabels, editable:false},'dropDown');
    //addField(cm,    'COMP_NM',        	{text: '회사명'},     150,     'text', {textAlignment: "near"}   ,  {editable:false});
    addField(cm,    'PLANT_CD',   		{text: '플랜트코드'},     100,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'PLANT_NM',   		{text: '플랜트명'},    100,     'text',  {textAlignment: "center"}  ,  {editable:false});
    addField(cm,    'STORAGE_CD',     	{text: '창고코드'},       100,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'STORAGE_NM',     	{text: '창고명'},      100,     'text',  {textAlignment: "center"} ,  {editable:false});
    addField(cm,    'RNUM1',          	{text: ' '},          15,     'popupLink');
    addField(cm,    'CONFIRM_USER',     {text: '승인자사번'},    100,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'CONFIRM_USER_NM',  {text: '승인자명'},     100,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'RNUM2',          	{text: ' '},          15,     'popupLink');
    addField(cm,    'CRUD',             {text: 'CRUD'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
    
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
        grid.setColumnProperty("RNUM1", "editable", editable);
        grid.setColumnProperty("RNUM2", "editable", editable);
    };
    

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked =  function (grid, index) {
        if (index.column == "RNUM1" && grid.getCurrentRow().CRUD == "I") {
        	
        	if ($('#SB_COMP_CD').val() == "") {
    			alert("회사는 필수입니다. 선택 후 작업하세요.");
    			return false;
        	}
        	
        	fnPlantStorageDetail();
        }
        
        if (index.column == "RNUM2" && grid.getCurrentRow().CRUD == "I") {
        	if ($('#SB_COMP_CD').val() == "") {
    			alert("회사는 필수입니다. 선택 후 작업하세요.");
    			return false;
        	}        	
        	fnDeptDetail();
        }        
    };
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWhrConfirmUserList');
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
	var values = {"RNUM1":"1", "RNUM2":"1", "CRUD" : "I"};
	fnAddRow(gridView, values);
}

//삭제
var fnDel = function(){
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		// 조회 요청
		deleteCall(gridView, '/com/wrh/deleteConfirmUser', null, params);
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
	var requiredVal   = ["COMP_CD", "PLANT_CD", "STORAGE_CD", "CONFIRM_USER"];

	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/saveConfirmUser', null, params);
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

/**
 * 그리드의 상세보기 클릭시 이벤트
 */
function fnPlantStorageDetail(val) {
    var params = fnGetParams();
    params.SB_COMP_NM = $("#SB_COMP_CD option:selected").text();
    var target = "sysPlantStorage";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/plantStorageList', params, target, width, height, scrollbar, resizable);
}

/**
 * 그리드의 상세보기 클릭시 이벤트
 */
function fnDeptDetail(val) {
    var params = fnGetParams();
    params.SB_COMP_NM = $("#SB_COMP_CD option:selected").text();
    params.SB_COMP_CD = $("#SB_COMP_CD").val();
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
			         "CONFIRM_USER"   : rows.USER_ID
			       , "CONFIRM_USER_NM" : rows.USER_NM
			     };
	
	gridView.setValues(gridView.getCurrent().itemIndex, values);
}


/**
 * 플랜트 창고 팝업 콜백
 */
function fnCallbackPlantStoagePopup(rows) {
	var values = {
			         "COMP_CD"    : rows.COMP_CD
			       , "COMP_NM"    : rows.COMP_NM
			       , "PLANT_CD"   : rows.PLANT_CD
			       , "PLANT_NM"   : rows.PLANT_NM
			       , "STORAGE_CD" : rows.STORAGE_CD
			       , "STORAGE_NM" : rows.STORAGE_NM
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
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnSearch();">
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