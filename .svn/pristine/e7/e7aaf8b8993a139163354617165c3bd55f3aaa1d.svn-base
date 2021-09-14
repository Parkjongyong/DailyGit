<%--
	File Name : bdgBugtTerm.jsp
	Description: 예산 > 예산관리> 예산등록기간관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.10.30  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.10.30
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

var bugtCodes  = new Array();
var bugtLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var bugtList   = stringToArray("${CODELIST_YS029}");
	fnMakeComboOption('SB_BUGT_GUBN'    , bugtList,     'CODE', 'CODE_NM', null, "","전체");

	bugtCodes  = getComboSet('${CODELIST_YS029}', 'CODE');
	bugtLabels = getComboSet('${CODELIST_YS029}', 'CODE_NM');
	
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
	$("#TB_CRTN_YY").val(getDiffDay("y",0).substring(0,4));
}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    addField(cm,    'BUGT_GUBN',            {text: '예산구분'},        80,     'text', {textAlignment: "center"},{lookupDisplay: true,values:bugtCodes,labels:bugtLabels},'dropDown');
    addField(cm,    'REG_FROM_DATE',        {text:'등록시작일'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'REG_TO_DATE',          {text:'등록종료일'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    
    addField(cm,    'CRTN_YY',             {text:'년도'},         100,            'text',           {textAlignment:"center"},{visible:false});
    addField(cm,    'CRUD',                {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    

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
            styles.editable = true;
        } else {
        	styles.editable = false;
        	styles.background = "#e4e4e4";
        }

        return styles;
    };
    
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = true;
        	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"}
        return styles;
    };
    
    // 고정스타일
    gridView.setColumnProperty("CRTN_YY"           , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("BUGT_GUBN"         , "dynamicStyles", columnDynamicStyles);
    
    gridView.setColumnProperty("REG_FROM_DATE"         , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REG_TO_DATE"           , "dynamicStyles", columnDefaultStyles);
    
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };

    gridView.setOptions({sortMode:"explicit"});
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectBugtTermList');
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
	var requiredVal   = ["CRTN_YY", "BUGT_GUBN", "REG_FROM_DATE", "REG_TO_DATE"];

	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?")){
			
			saveCall(gridView, '/com/bdg/saveBugtTerm', 'fnSave', params);
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
		deleteCall(gridView, '/com/bdg/deleteBugtTerm', 'fnDelete', params);
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
			      ,"CRTN_YY" : $('#TB_CRTN_YY').val()
	};
	
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
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
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>년도</span></th>
                    <td>
						<input type="number" id="TB_CRTN_YY"  style="text-align: right; width: 50px; text-align: center">
                    </td>
                    <th><span>예산구분</span></th>
                    <td>
	                    <select id="SB_BUGT_GUBN" name="SB_BUGT_GUBN">
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
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
