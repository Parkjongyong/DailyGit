<%--
	File Name : bdgCostMgt.jsp
	Description: 예산 > 예산관리> 코스트센터 관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.10.23  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.10.23
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

var compCodes  = new Array();
var compLabels = new Array();

var deptPopGubn  = "";
$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	var deptList   = stringToArray("${CODELIST_USRDPT}");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_ORG_CD'     , deptList,     'CODE', 'CODE_NM', null, "","전체");

	compCodes  = getComboSet('${CODELIST_SYS001}', 'CODE');
	compLabels = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGrid();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	//$("#TB_CCTR_CD").val('${LOGIN_INFO.COST_CD}');
	

}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    addField(cm,    'COMP_CD',              {text: '회사'},        100,     'text', {textAlignment: "center"},{lookupDisplay: true,values:compCodes,labels:compLabels},'dropDown');
    addField(cm,    'ORG_CD',               {text:'부서'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'ORG_NM',               {text:'부서명'},         200,            'text',           {textAlignment:"near"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          10,     'popupLink');
    
    addField(cm,    'CCTR_CD',             {text:'코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',             {text:'코스트센터명'},        200,            'text',           {textAlignment:"near"});
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
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
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles2 = function(grid, index, value) {
        return enableColStyle;
    };

    // 고정스타일
    gridView.setColumnProperty("COMP_CD"           , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("ORG_CD"           , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ORG_NM"           , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_CD"           , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("CCTR_NM"           , "dynamicStyles", columnDefaultStyles2);
    
    gridView.onDataCellClicked = function (grid, data) {
    	// 품목정보
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchDept('grid');
        }

    };
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.setOptions({sortMode:"explicit"});

    
}

/**
 * 부서 조회
 */
 function fnSearchDept(gubn) {
	var params = {};
	deptPopGubn = gubn;
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_CD" : ""});
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
	if(deptPopGubn == 'grid'){
		var values = {
		         "ORG_CD"  : rows.DEPT_CD 
		        ,"ORG_NM"  : rows.DEPT_NM
		     };

		gridView.setValues(gridView.getCurrent().itemIndex, values);
	} else {
		$('#TB_ORG_NM').val(rows.DEPT_NM);
		$('#TB_ORG_CD').val(rows.DEPT_CD);
	}

}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectCostMgtList');
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



//저장
var fnSave = function(){
	gridView.commit();
	var params = {};
	
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "ORG_CD", "CCTR_CD"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?")){
			
			saveCall(gridView, '/com/bdg/saveCostMgt', 'fnSave', params);
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

//삭제
function fnDelete() {
	
	gridView.commit();
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/deleteCostMgt', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	gridView.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
}


//행추가
function fnRowAdd() {
	 
	var values = { "CRUD" : "I" 
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CODEMAPPING1" : "1"
	};
	
// 	gridView.insertRow(0, values);
// 	gridView.checkItem(0, true);
	 
	fnAddRow(gridView, values, 0);
	
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

//부서 리셋
function fnDeptReset() {
	$("#TB_ORG_CD").val("");
	$("#TB_ORG_NM").val("");
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
                <col style="width:140px">
                <col style="width:410px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD">
	                    </select>
                    </td>
                    <th><span>부서명</span></th>
                    <td>
	                    <input type="text" id="TB_ORG_NM" name="TB_ORG_NM" disabled="disabled">              
	                    <input type="hidden" id="TB_ORG_CD">
						<a href="javascript:fnSearchDept('header');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						<a href="javascript:fnDeptReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <th><span>코스트센터명</span></th>
                    <td>
	                    <input type="text" id="TB_CCTR_NM" name="TB_CCTR_NM">      
	                    <input type="hidden" id="TB_CCTR_CD" name="TB_CCTR_CD">      
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
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
