<%--
	File Name : wrhConfirmUser.jsp
	Description: 예산 > 부가정보 > 업무차량운행일지
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.04  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.09.04
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

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
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
}

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    
    addField(cm,    'VHCL_NUMBER',      {text: '차량번호'},      100,     'text', {textAlignment: "center"});
    addField(cm,    'CODEMAPPING2',     {text: ' '},          15,     'popupLink');
    addField(cm,    'VHCL_KIND',        {text: '차종'},     150,     'text', {textAlignment: "near"});
    addField(cm,    'SABUN',   		    {text: '사원코드'},     100,     'text',  {textAlignment: "center"});
    addField(cm,    'SABUN_NM',   		{text: '사원명'},    100,     'text',  {textAlignment: "near"});
    addField(cm,    'CODEMAPPING1',     {text: ' '},          15,     'popupLink');
    addField(cm,    'JIKWEE_NM',     	{text: '직위'},       100,     'text',  {textAlignment: "center"});
    addField(cm,    'ORG_CD',     	    {text: '부서코드'},      100,     'text',  {textAlignment: "center"});
    addField(cm,    'ORG_NM',     	    {text: '부서명'},      100,     'text',  {textAlignment: "center"});
    
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
    
    // 기본 스타일 적용2
    var columnDefaultStyles2 = function(grid, index, value) {
        var styles = {};
	        styles.editable = true;
	        styles.background = "#d5e2f2";
        return styles;
    };     

    gridView.setColumnProperty("VHCL_NUMBER", "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("VHCL_KIND", "dynamicStyles", columnDefaultStyles2);
    
    gridView.setColumnProperty("SABUN", "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("SABUN_NM", "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("JIKWEE_NM", "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ORG_CD", "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ORG_NM", "dynamicStyles", columnDefaultStyles);
    
    
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
        if (data.fieldName == "CODEMAPPING1") {
        	fnSearchUser();
        }
        
        if (data.fieldName == "CODEMAPPING2") {
        	fnSearchDetail(data);
        }        
    };
    
    gridView.setOptions({sortMode:"explicit"});
    
}

/**
 * 월별일지팝업
 */
function fnSearchDetail(data) {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	
	var target    = "bdgVehicleOp";
	var width     = "1260";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgVehicleOp', params, target, width, height, scrollbar, resizable);
}


/**
 * 사용자 조회 팝업
 */
function fnSearchUser() {
    var params = fnGetParams();
    
    $.extend(params, {"SB_COMP_CD" : '${LOGIN_INFO.COMP_CD}'});
    
    var target = "userList";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/userList2', params, target, width, height, scrollbar, resizable);
}

/**
 * 사용자 조회 팝업 콜백
 */
function fnCallbackPop(rows) {
	
	var values = {
	             "SABUN"    : rows.USER_ID
		       , "SABUN_NM" : rows.USER_NM
		       , "ORG_CD"   : rows.DEPT_CD
		       , "ORG_NM"   : rows.DEPT_NM
		       , "JIKWEE_NM": rows.DESIGNATION_N
	     };
	
	gridView.setValues(gridView.getCurrent().itemIndex, values);		

}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectVehicleMgtList');
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
	var values = {"CODEMAPPING1":"1", "CRUD" : "I", "CODEMAPPING1":"2"};
	fnAddRow(gridView, values);
}

//삭제
var fnDel = function(){
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		// 조회 요청
		deleteCall(gridView, '/com/bdg/deleteVehicleMgt', null, params);
	}
	
}

//저장
var fnSave = function(){
	
	gridView.commit();
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["VHCL_NUMBER", "SABUN"];

	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveVehicleMgt', null, params);
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
                <col style="width:90px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>차량번호</span></th>
                    <td>
                        <input type="text"   id="TB_VHCL_NUMBER">
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