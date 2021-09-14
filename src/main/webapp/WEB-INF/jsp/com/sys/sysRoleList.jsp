<%--
    Class Name :sysRoleList.jsp
    Description: 권한 관리
    Modification Information
         수정일                  수정자     수정내용
    ---------  ------ ---------------------------
    2020.06.18  박종용     최초 생성
    author: 박종용
    since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>

<script language="javascript">
var gridView;

var userCodes  = new Array();
var userLabels = new Array();

//전역변수 설정
var idRow	= "";
var idCol	= "";
var kRow	= "";
var kCol	= "";

$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();

    // 개별코드 생성(그리드용)
    userCodes  = getComboSet('${CODELIST_ID001}', 'CODE');
    userLabels = getComboSet('${CODELIST_ID001}', 'CODE_NM');
    
    // 그리드 생성
    setInitGrid();

    // 자동 조회
    fnSearch();
    
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트는 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
});

function fnInitStatus(result) {

}

function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

function fnDeleteFail(result) {
	alert("실패하였습니다.");
}


function fnSaveSuccess(result){
	alert("성공 하였습니다.");
	fnSearch();
}

function fnSaveFail(result){
	alert("실패하였습니다.");
}

function fnParams() {
	var params = fnGetParams();
	return params;
}

function setInitGrid() {
		
	var gridId = "gridView";
	gridView = new RealGridJS.GridView(gridId);
	    
	var colModel = [];
	
	// obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	addField(colModel, 'ROLE_CD',       {text: '역할코드'},     80,    'text',      {textAlignment: 'center'});
	addField(colModel, 'ROLE_NAME',     {text: '역할명'},     200,    'text',      {textAlignment: 'near'});
	
	addField(colModel ,   'MODULE_TYPE'    , {text: '사용자(SITE)구분'} , 100,   'text',     {textAlignment: "center"},
            {lookupDisplay: true,values:userCodes,labels:userLabels},'dropDown');
	
	addField(colModel, 'ROLE_MENU',     {text: '메뉴설정'},     80,    'popupLink');
	addField(colModel, 'ROLE_USER',     {text: '사용자설정'},    80,    'popupLink');
	addField(colModel, 'ROLE_DEPT',     {text: '부서설정'},     80,    'popupLink');
	
	addField(colModel, 'REG_NM',        {text: '등록자'},     100,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'REG_DT',        {text: '등록일'},     100,    'datetime',  {textAlignment: "center"}, {datetimeFormat: "yyyy-MM-dd"}, {editable:false});
	
	addField(colModel, 'FLAG',          {text: '구분'},         0,    'text',    {textAlignment: "center"},  {visible:false});
	addField(colModel, 'PRE_ROLE_CD',   {text: '기존역할코드'},         0,    'text',    {textAlignment: "center"},  {visible:false});

	gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이 
        ,columns        : colModel        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable : true
        ,copySingle : false // default ture : 복사하지 않음 
        ,viewCount      : true       //조회 건수 표시
	});

	gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
        if (itemIndex !== -1 && field === 0) {//userId
            if (dataRow === -1 || grid.getRowState(itemIndex) === "created") {
                var val = grid.getValue(itemIndex, "ROLE_CD");
                var addRow = gridView.getAllJsonRowsExcludeDeleteRow();
                
                //PLANT_CD 중복 선택 막기
                if(addRow.length > 0){
                    $.each(addRow, function(idx, vo) {
                        if(vo.ROLE_CD.toUpperCase() == val.toUpperCase() && vo.ROLE_CD != ""){
                            alert("역할 코드는 중복 등록 할 수 없습니다.");
                            grid.setValue(itemIndex, "ROLE_CD", "");
                            return false;
                        }
                    });
                }
            }
        }
    };
    
    //셀이 수정된후 
    gridView.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };
	
	gridView.onDataCellClicked = function (grid, colIndex) {
		if ( colIndex.fieldName === "ROLE_MENU" ) {
			fnMenuPopup(grid.getValues(colIndex.itemIndex));
		}else if ( colIndex.fieldName === "ROLE_USER" ) {
			fnUserPopup(grid.getValues(colIndex.itemIndex));
		}else if ( colIndex.fieldName === "ROLE_DEPT" ) {
			fnDeptPopup(grid.getValues(colIndex.itemIndex));
		}
	};
	
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
	
    gridView.setOptions({sortMode:"explicit"});
}

//권한-메뉴 설정 Popup
var fnMenuPopup = function(row){
	
	var url  = "/com/sys/sysRoleMenuPopup";
	var params = fnGetParams();
		params.ROLE_CD 	= row.ROLE_CD;
		params.ROLE_NAME= row.ROLE_NAME;
		params.MODULE_TYPE= row.MODULE_TYPE;
	
	var target = "roleMenuPopup";
	var width  = "1150";
	var height = "815";
	var scrollbar = "yes";
	var resizable = "yes";
	
	//조회하거나 수정한 데이터가 아닐 경우 메뉴설정 팝업 차단.
	if(row.FLAG != 'R' && row.FLAG != 'U'){
		alert("저장 후 메뉴 설정 가능 합니다.");
		return false;
	}else{
		fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
	}
};

//권한-사용자 설정 Popup
var fnUserPopup = function(row){
	
	if(row.MODULE_TYPE == "S"){
		alert("공급업체 권한의 경우 해당 기능을 사용 할 수 없습니다.");
		return false;
	}
	
	var url  = "/com/sys/sysRoleUserPopup";
	var params = fnGetParams();
		params.ROLE_CD 	= row.ROLE_CD;
		params.ROLE_NAME= row.ROLE_NAME;
	
	var target = "roleUserPopup";
	var width  = "1000";
	var height = "730";
	var scrollbar = "yes";
	var resizable = "yes";
	
	//조회하거나 수정한 데이터가 아닐 경우 메뉴설정 팝업 차단.
	if(row.FLAG != 'R' && row.FLAG != 'U'){
		alert("저장 후 사용자 설정 가능 합니다.");
		return false;
	}else{
		fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
	}
};

//권한-부서 설정 Popup
var fnDeptPopup = function(row){
	
	if(row.MODULE_TYPE == "S"){
        alert("공급업체 권한의 경우 해당 기능을 사용 할 수 없습니다.");
        return false;
    }
	
	var url  = "/com/sys/sysRoleDeptPopup";
	var params = fnGetParams();
		params.ROLE_CD 	= row.ROLE_CD;
		params.ROLE_NAME= row.ROLE_NAME;
	
	var target = "roleDeptPopup";
	var width  = "1000";
	var height = "730";
	var scrollbar = "yes";
	var resizable = "yes";
	
	//조회하거나 수정한 데이터가 아닐 경우 메뉴설정 팝업 차단.
	if(row.FLAG != 'R' && row.FLAG != 'U'){
		alert("저장 후 부서 설정 가능 합니다.");
		return false;
	}else{
		fnPostPopup(url, params, target, width, height, scrollbar, resizable);
		return false;
	}
};

//조회
var fnSearch = function() {
	searchCall(gridView, '/com/sys/selectRoleList');
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


//추가
var fnAdd = function(){
    var values = {"ROLE_CD":'', "ROLE_NAME":"", "MODULE_TYPE":'', "CRUD": "I"};
    gridView.insertRow(0, values);
    gridView.checkItem(0, true);
    gridView.setFocus();
    gridView.showEditor();
    gridView.commit();
}

//저장
var fnSave = function(){
	gridView.commit();
    
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ROLE_CD", "ROLE_NAME", "MODULE_TYPE"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		// 필수체크
		if(fnValidationChk(gridView) != false){
		     if(confirm("저장 하시겠습니까?")){
		         var params = fnGetMakeParams();
		         $.extend(params, {"ITEM_LIST":gridView.getStateRows()}); 
		    	 saveCall(gridView, '/com/sys/updateRoleList' , null, params);
		     }		
		}
	}
}

//필수 체크
function fnValidationChk(grid) {
    var gridProvider = gridView.getDataProvider();
    if(gridProvider.getRowCount() > 0){
        for(var index=0; index < gridProvider.getRowCount(); index++){
            var ROLE_CD = "";
            var ROLE_NAME = "";
            var MODULE_TYPE = "";
            
            ROLE_CD += gridView.getValue(index, "ROLE_CD");
            if(ROLE_CD == ""){
                alert("역할코드를 입력 해 주세요.");
                return false;
            }else if(ROLE_CD.length > 20){
                gridView.setValue(index, "ROLE_CD", "");
                
                alert("글자 수는 20자리 이상 넘을 수 없습니다.");
                return false;
            }else{
            	gridView.setValue(index, "ROLE_CD", ROLE_CD.replace(/[^a-z0-9]/gi,'').toUpperCase());
            }
            
            ROLE_NAME += gridView.getValue(index, "ROLE_NAME");
            if(ROLE_NAME == ""){
                alert("역할 명을  입력 해 주세요.");
                return false;
            }else if(ROLE_NAME.length > 30){
                gridView.setValue(index, "ROLE_NAME", "");
                alert("글자 수는 30자리 이상 넘을 수 없습니다.");
                return false;
            }
            
            MODULE_TYPE += gridView.getValue(index, "MODULE_TYPE");
            if(MODULE_TYPE == ""){
                alert("사용자 구분을 선택 해 주세요.");
                return false;
            }
        }
    }
}

//삭제
var fnDel = function(){
	if(fnDeleteCheck(gridView) == true){
        var params = fnGetMakeParams();
        $.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
		deleteCall(gridView, '/com/sys/delRoleList', null, params);
	}
}

</script>

<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
	<div class="btnArea abtit">
	</div>
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:115px">
                <col style="width:435px">
            </colgroup>
            <tbody>
                <tr>
                    <th><span>역할코드</span></th>
                    <td>
                        <input type="text" id="S_ROLE_CD" value="" maxlength="10">
                    </td>
                    <th><span>역할명</span></th>
                    <td>
                        <input type="text" id="S_ROLE_NM" value="" maxlength="15">
                    </td>
                    <th></th>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap -->    

<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnAdd">추가</button>
        <button type="button" class="btn" id="btnDel">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>

