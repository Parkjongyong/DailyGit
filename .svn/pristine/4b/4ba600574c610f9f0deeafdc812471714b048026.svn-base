<%--
	File Name : bdgUsesDeptMgt.jsp
	Description: 시스템관리 > 사용자관리> 담당자별 부서권한관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.24 길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.24
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridUser;
var gridDept;
var compCodes  = new Array();
var compLabels = new Array();
var sabun;

$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}");
	
    fnMakeComboOption('SB_COMP_CD' , compList,      'CODE', 'CODE_NM', null, "","전체");
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridUser();
	setInitgridDept();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	
}

function setInitgridUser() {
    var gridId = "gridUser";
    gridUser = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'SABUN',                {text: '사번'},        100,     'text', {textAlignment: "center"});
    addField(cm,    'SABUN_NM',             {text: '사원명'},       100,     'text', {textAlignment: "center"});
    
    addField(cm,    'ORG_CD',               {text:'부서코드'},          100,            'text',              {textAlignment:"center"},{visible:false});
    addField(cm,    'ORG_NM',               {text:'부서명'},          200,            'text',              {textAlignment:"center"},{visible:false});
    addField(cm,    'CODEMAPPING1',         {text: ' '},         15,     'popupLink');
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},         0,     'text', {textAlignment: "center"},{visible:false});

    gridUser.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    

    gridUser.onDataCellClicked = function (grid, data) {
    	// 품목코드
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchUser();
        }
    	
    	var curr = grid.getCurrent();
        var values = grid.getValues(curr.itemIndex);
        var value = values.SABUN;
        sabun = value;
        if (values.CRUD == "R" && (data.fieldName === "SABUN" || data.fieldName === "SABUN_NM")) {
        	fnSearchDeptMgtList(value);
        }
   	
    	
    };
    
    //그리드 변경 시 체크박스 true
    gridUser.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridUser.checkItem(dataRow, true);
    };


    gridUser.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	var curr = grid.getCurrent();
        var editable = false;
        
        if (curr.itemIndex > -1) {
            var values = grid.getValues(curr.itemIndex);
            var value = values.SABUN;
            //grid.setValue(grid.getCurrent().itemIndex,"SABUN" ,grid.getDisplayValues(curr.itemIndex,"COMP_CD").COMP_CD);
            if($.trim(value) === ""){

            } else {
            	fnSearchDeptMgtList(value);
            }
            
            sabun = value;
        }
        
    };
    
    gridUser.setOptions({sortMode:"explicit"});

    
}

function setInitgridDept() {
    var gridId = "gridDept";
    gridDept = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'SABUN',                {text: '사번'},        100,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SABUN_NM',             {text: '사원명'},       100,     'text', {textAlignment: "center"},{visible:false});
    
    addField(cm,    'ORG_CD',               {text:'부서코드'},          100,            'text',              {textAlignment:"center"});
    addField(cm,    'ORG_NM',               {text:'부서명'},          200,            'text',              {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},         15,     'popupLink');
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},         0,     'text', {textAlignment: "center"},{visible:false});

    gridDept.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    

    gridDept.onDataCellClicked = function (grid, data) {
    	// 품목코드
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchDept();
        }
    };
    
    //그리드 변경 시 체크박스 true
    gridDept.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDept.checkItem(dataRow, true);
    };
    
    gridDept.setOptions({sortMode:"explicit"});
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridUser, '/com/bdg/selectUsersMgtList');
}

/**
 * 조회
 */
function fnSearchDeptMgtList(param) {
    var params = fnGetParams();
    params.TB_SABUN = param;
	// 조회 요청
	searchCall(gridDept, '/com/bdg/selectDeptMgtList', 'fnSearchDeptMgtList', params);
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridDept.clearRows();
	}
	
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridUser.clearRows();
	// 그리고 데이터 setting
    gridUser.setPageRows(data);
    // 상태바 비활성화
    gridUser.closeProgress();
}

/**
 * 조회 후 처리
 */
function fnSearchDeptMgtListSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridDept.clearRows();
	// 그리고 데이터 setting
    gridDept.setPageRows(data);
    // 상태바 비활성화
    gridDept.closeProgress();
}


//저장
function fnSaveUser() {
	gridUser.commit();
	
	var checkedRows = gridUser.getCheckedItems(false);	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridUser.getValues(checkedRows[i]);
		
		if (temp.CRUD == 'R') {
			gridUser.checkItem(checkedRows[i], false);
		}
	}		
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["SABUN", "ORG_CD"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridUser, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?")){
			var params = {};
			$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridUser)});
			$.extend(params, fnGetParams());
			
			saveCall(gridUser, '/com/bdg/saveUsersMgt', 'fnSave', params);
		}
	}
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridUser.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridUser.closeProgress();
}


//행추가
function fnRowAddUser() {
	
	var values = { "CRUD" : "I" 
			      ,"COMP_CD" : $("#SB_COMP_CD").val()
			      ,"CODEMAPPING1" : "1"
			      };
	
	fnAddRow(gridUser, values, gridUser.getRowCount());
}

//행삭제
function fnRowDelUser() {
	fnAddRowDelete(gridUser);
}

//삭제
function fnDeleteUser() {
	
	gridUser.commit();
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridUser)});
	
	if(fnDeleteCheck(gridUser) == true){
		deleteCall(gridUser, '/com/bdg/deleteUsersMgt', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
    gridUser.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
}



//저장
function fnSaveDept() {
	gridDept.commit();
	
	var checkedRows = gridDept.getCheckedItems(false);	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridDept.getValues(checkedRows[i]);
		
		if (temp.CRUD == 'R') {
			gridDept.checkItem(checkedRows[i], false);
		}
	}		
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["SABUN", "ORG_CD"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridDept, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?")){
			var params = {};
			$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridDept)});
			$.extend(params, fnGetParams());
			
			saveCall(gridDept, '/com/bdg/saveDeptMgt', 'fnSaveDept', params);
		}
	}
}

/**
 * 저장 성공
 */
function fnSaveDeptSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridDept.closeProgress();
    fnSearchDeptMgtList(sabun);
}

/**
 * 저장 실패
 */
function fnSaveDeptFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridDept.closeProgress();
}


//행추가
function fnRowAddDept() {
	
	if(isEmpty(sabun)){
		alert("사번은 필수입니다.");
		return false;
	}
	var values = { "CRUD" : "I" 
			      ,"COMP_CD" : $("#SB_COMP_CD").val()
			      ,"SABUN"   : sabun
			      ,"CODEMAPPING1" : "1"
			      };
	
	fnAddRow(gridDept, values, gridDept.getRowCount());
}

//행삭제
function fnRowDelDept() {
	fnAddRowDelete(gridDept);
}

//삭제
function fnDeleteDept() {
	
	gridDept.commit();
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridDept)});
	
	if(fnDeleteCheck(gridDept) == true){
		deleteCall(gridDept, '/com/bdg/deleteDeptMgt', 'fnDeleteDept', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteDeptSuccess(result) {
	alert("삭제 하였습니다.");
    gridDept.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteDeptFail(result) {
	alert(result.errMsg);
}


/**
 * 관리부서 조회(귀속부서인지 확인 필요!!!!!)
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
 * 관리부서 콜백
 */
function fnCallbackDeptSearchPop(rows) {
	gridDept.setRowValue(gridDept.getCurrent().itemIndex, "ORG_CD", rows.DEPT_CD);
	gridDept.setRowValue(gridDept.getCurrent().itemIndex, "ORG_NM", rows.DEPT_NM);
}

/**
 * 사용자 조회 팝업
 */
function fnSearchUser() {
    var params = fnGetParams();
    $.extend(params, {"SB_COMP_NM" :  $("#SB_COMP_CD option:selected").text()});
    var target = "userList";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 사용자 조회 팝업 콜백
 */
function fnCallbackPop(rows) {
	
	var values = {
	             "SABUN"    : rows.USER_ID
		       , "SABUN_NM" : rows.USER_NM
		       , "ORG_CD"   : rows.DEPT_CD
	     };
	
	gridUser.setValues(gridUser.getCurrent().itemIndex, values);		

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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnSearch();">
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
<div class="pack-layout">
	<div class="layout1" style="width:50%">
		<div class="sub-tit">
		    <div class="btnArea t_right">
		        <button type="button" class="btn" id="btnRowDelUser">행삭제</button>
		        <button type="button" class="btn" id="btnRowAddUser">행추가</button>
		        <button type="button" class="btn" id="btnDeleteUser">삭제</button>
		        <button type="button" class="btn" id="btnSaveUser">저장</button>
		    </div>
		</div>
		<div class="realgrid-area">
		    <div id="gridUser"></div> 
		</div>
    </div>
          
    <div class="layout2" style="width:50%">
		<div class="sub-tit">
		    <div class="btnArea t_right">
		        <button type="button" class="btn" id="btnRowDelDept">행삭제</button>
		        <button type="button" class="btn" id="btnRowAddDept">행추가</button>
		        <button type="button" class="btn" id="btnDeleteDept">삭제</button>
		        <button type="button" class="btn" id="btnSaveDept">저장</button>
		    </div>
		</div>
		<div class="realgrid-area">
		    <div id="gridDept"></div> 
		</div>
    </div>
</div>
