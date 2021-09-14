<%--
	File Name : wrhMgmtWareHouse.jsp
	Description: 입고예정 > 담당자관리 > 창고관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.09  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.09
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridPlant;
var gridWareHouse;
var plantCode;
var compCodes  = new Array();
var compLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}", "ALL", "IPGO");
	var purGroupList = stringToArray("${CODELIST_IG001}");
	
    // 개별코드 생성(그리드용)
    compCodes      = getComboSet('${CODELIST_SYS001}', 'CODE');
    compLabels     = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "", "전체");
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridWareHouse();
	setInitGridPlant();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

	// 자동 조회
	fnSearchPlant();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
}

function setInitGridPlant() {
    var gridId = "gridPlant";
    gridPlant = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'COMP_CD',         {text: '회사'},       100,     'text', {textAlignment: "center"},   {lookupDisplay: true,values:compCodes,labels:compCodes},'dropDown');
    addField(cm,    'COMP_NM',         {text: '회사명'},      100,     'text', {textAlignment: "near"},   {lookupDisplay: true,values:compCodes,labels:compLabels},'dropDown');
    addField(cm,    'PLANT_CD',        {text: '플랜트'},      100,     'text', {textAlignment: "center"});
    addField(cm,    'PLANT_NM',        {text: '플랜트명'},     100,     'text', {textAlignment: "near"});
    addField(cm,    'CRUD',            {text: 'CRUD'},         0,    'text', {textAlignment: 'center'},  {visible:false});
    
    gridPlant.rgrid({
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
    gridPlant.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };

    gridPlant.onCurrentRowChanged =  function (grid, oldRow, newRow) {
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
        grid.setColumnProperty("COMP_CD", "editable", editable);
        grid.setColumnProperty("COMP_NM", "editable", false);
        grid.setColumnProperty("PLANT_CD", "editable", editable);
        
        if (curr.itemIndex > -1) {
            var values = grid.getValues(curr.itemIndex);
            var value = values.PLANT_CD;
            grid.setValue(grid.getCurrent().itemIndex,"COMP_NM" ,grid.getDisplayValues(curr.itemIndex,"COMP_CD").COMP_CD);
            if($.trim(value) === ""){
                	
            } else {
            	fnSearchWareHouse(value);
            }
            plantCode = value;
        }
        
    };
    
    gridPlant.onDataCellClicked = function (grid, colIndex) {
    	var curr = grid.getCurrent();
        var values = grid.getValues(curr.itemIndex);
        var value = values.PLANT_CD;
        if (values.CRUD == "R" && (colIndex.fieldName === "COMP_CD" || colIndex.fieldName === "COMP_NM" || colIndex.fieldName === "PLANT_CD")) {
        	fnSearchWareHouse(value);
        }
    };

    
    //그리드 변경 시 체크박스 true
    gridPlant.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridPlant.checkItem(dataRow, true);
        grid.setValue(grid.getCurrent().itemIndex, "COMP_NM" ,grid.getDisplayValues(grid.getCurrent().itemIndex, "COMP_CD").COMP_CD);
    };
    
}

/**
 * 그리드 기본  셋팅
 */
function setInitGridWareHouse() {
    var gridId = "gridWareHouse";
    gridWareHouse = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption

	addField(cm,    'COMP_CD',         {text: '회사'},      100,     'text', {textAlignment: "center"},   {visible:false});
	addField(cm,    'PLANT_CD',        {text: '플랜트'},      100,     'text', {textAlignment: "center"},   {visible:false});
	addField(cm,    'STORAGE_CD',      {text: '창고코드'},      50,     'text', {textAlignment: "center"} );
	addField(cm,    'STORAGE_NM',      {text: '창고명칭'},    100,     'text', {textAlignment: "near"}   );
    addField(cm,    'CRUD',            {text: 'CRUD'},      0,     'text',      {textAlignment: 'center'},  {visible:false});
    
    gridWareHouse.rgrid({
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
    gridWareHouse.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };

    gridWareHouse.onCurrentRowChanged =  function (grid, oldRow, newRow) {
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
        grid.setColumnProperty("STORAGE_CD", "editable", editable);
    };
    

    //그리드 변경 시 체크박스 true
    gridWareHouse.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridWareHouse.checkItem(dataRow, true);
    };
    
}

/**
 * 조회
 */
function fnSearchPlant() {
	// 조회 요청
	searchCall(gridPlant, '/com/wrh/selectWrhMgmtPlantList');
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridWareHouse.clearRows();
	}
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridPlant.clearRows();
	// 그리고 데이터 setting
    gridPlant.setPageRows(data);
    // 상태바 비활성화
    gridPlant.closeProgress();	
}

//행삭제
var fnRowDelPlt = function(){
	fnAddRowDelete(gridPlant);
}

//행추가
function fnRowAddPlt() {
	var values = {"COMP_CD" : $("#SB_COMP_CD").val(), "PO_ORG" : $("#SB_PO_ORG").val(), "CODEMAPPING":"1", "CRUD" : "I"};
	fnAddRow(gridPlant, values);
}

//삭제
var fnDelPlt = function(){
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridPlant)});
	if(fnDeleteCheck(gridPlant) == true){
		// 조회 요청
		deleteCall(gridPlant, '/com/wrh/deletePlant', 'fnDeletePlant', params);
	}
	
}

//저장
var fnSavePlt = function(){
	gridPlant.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridPlant)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "PLANT_CD"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridPlant, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridPlant, '/com/wrh/savePlant', 'fnSavePlant', params);
	     }
	}
}

/**
 * 저장 성공
 */
function fnSavePlantSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridPlant.closeProgress();
    fnSearchPlant();
}

/**
 * 저장 실패
 */
function fnSavePlantFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridPlant.closeProgress();
}

/**
 * 삭제 성공
 */
function fnDeletePlantSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearchPlant();
	fnSearchWareHouse();
}

/**
 * 삭제 실패
 */
function fnDeletePlantFail(result) {
	alert(result.errMsg);
}

/**
 * 조회
 */
function fnSearchWareHouse(param) {
    var params = fnGetParams();
    params.TB_PLANT_CODE = param;
	// 조회 요청
	searchCall(gridWareHouse, '/com/wrh/selectWrhMgmtWareHouseList', 'fnSearchWareHouse', params);
}

/**
 * 조회 후 처리
 */
function fnSearchWareHouseSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridWareHouse.clearRows();
	// 그리고 데이터 setting
    gridWareHouse.setPageRows(data);
    // 상태바 비활성화
    gridWareHouse.closeProgress();	
}


//행삭제
var fnRowDelWrh = function(){
	fnAddRowDelete(gridWareHouse);
}

//행추가
function fnRowAddWrh() {
	var values = {"COMP_CD" : $("#SB_COMP_CD").val(), "PLANT_CD" : plantCode, "CRUD" : "I"};
	fnAddRow(gridWareHouse, values);
}

//삭제
var fnDelWrh = function(){
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridWareHouse)});
	if(fnDeleteCheck(gridWareHouse) == true){
		// 조회 요청
		deleteCall(gridWareHouse, '/com/wrh/deleteWareHouse', 'fnDeleteWareHouse', params);
	}
	
}

//저장
var fnSaveWrh = function(){
	gridWareHouse.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridWareHouse)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "PLANT_CD" ,"STORAGE_CD"];

	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridWareHouse, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridWareHouse, '/com/wrh/saveWareHouse', 'fnSaveWareHouse', params);
	     }
	}
}

/**
 * 저장 성공
 */
function fnSaveWareHouseSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridWareHouse.closeProgress();
    fnSearchWareHouse(plantCode);
}

/**
 * 저장 실패
 */
function fnSaveWareHouseFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridWareHouse.closeProgress();
}

/**
 * 삭제 성공
 */
function fnDeleteWareHouseSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearchWareHouse(plantCode);
}

/**
 * 삭제 실패
 */
function fnDeleteWareHouseFail(result) {
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
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnSearchPlant()">
	                    	<option value="">전체</option>
	                    </select>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearchPlant">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->

<div style="width:50%; float:left; margin-right:20px;">
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnRowDelPlt">행삭제</button>
        <button type="button" class="btn" id="btnRowAddPlt">행추가</button>
        <button type="button" class="btn" id="btnDelPlt">삭제</button>
        <button type="button" class="btn" id="btnSavePlt">저장</button>
    </div>
</div>

<div class="realgrid-area">
    <div id="gridPlant"></div> 
</div>
</div>

<div style="width:48%; float:left;">
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnRowDelWrh">행삭제</button>
        <button type="button" class="btn" id="btnRowAddWrh">행추가</button>
        <button type="button" class="btn" id="btnDelWrh">삭제</button>
        <button type="button" class="btn" id="btnSaveWrh">저장</button>
    </div>
</div>

<div class="realgrid-area">
    <div id="gridWareHouse"></div> 
</div>
</div>