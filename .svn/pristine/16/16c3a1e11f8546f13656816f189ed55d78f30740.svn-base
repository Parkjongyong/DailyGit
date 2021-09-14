<%--
	File Name : bdgDraft.jsp
	Description:예산 > 부가정보 > 문안변경등록
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.16  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.09.16
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var statusCodes  = new Array();
var statusLabels = new Array();
var paramGubn    = "";

var useYnCodes  = new Array();
var useYnLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	var ynList    = stringToArray("${CODELIST_E102}");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var statusList  = stringToArray("${CODELIST_YS013}");
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_DRAFT_CHANGE_YN', ynList,     'CODE', 'CODE_NM', null, "","전체");
	
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'MAT_NUMBER',         {text: '품목코드'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'CODEMAPPING1',       {text: ' '},        7,     'popupLink');
    addField(cm,    'MAT_DESC',           {text:'품목명'},        80,            'text',              {textAlignment:"center"});
    addField(cm,    'DRAFT_NO',           {text:'화판번호'},        80,            'text',           {textAlignment:"near"});
    addField(cm,    'DRAFT_CHANGE_YN',    {text: '문안변경'},      30,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:useYnCodes,labels:useYnLabels, editable: true},'dropDown');
    addField(cm,    'CHANGE_DESC',        {text:'변경사유'},      100,            'text',           {textAlignment:"near"});
    addField(cm,    'CRE_USER_NM',        {text:'등록자'},        100,            'text',           {textAlignment:"center"});

    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},      0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });


    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
       		fnSearchPlantItem();
       	}

    };
    

    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var status = values.CRUD;
        if (status == 'I') {
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
    
    // 기본 스타일 적용
    var columnTrueStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = true;
        	styles.background = "#d5e2f2";
        return styles;
    };
    
    setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
    gridView.setColumnProperty("DRAFT_NO"  , "dynamicStyles", columnTrueStyles);
    gridView.setColumnProperty("DRAFT_CHANGE_YN"  , "dynamicStyles", columnTrueStyles);
    gridView.setColumnProperty("CHANGE_DESC"  , "dynamicStyles", columnTrueStyles);

    gridView.setOptions({sortMode:"explicit"});
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectDraft');
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


//행추가
function fnRowAdd() {
	var values = { "CRUD" : "I" 
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CODEMAPPING1" : "1"
	              };
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

/**
 * 저장
 */
function fnSave() {
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	if(gridView.getCheckedItems(false).length == 0){
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "MAT_NUMBER"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveDraft', null, params);
	     }
	}

}

function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	fnSearch();

}

function fnSaveFail(result) {
	alert(result.errMsg);
}


/**
 * 삭제
 */
function fnDelete() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(isEmpty(params.ITEM_LIST)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delDraft', 'fnDel', params);
	}

}

/**
 * 삭제 성공
 */
function fnDelSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

/**
 * 삭제 실패
 */
function fnDelFail(result) {
	alert(result.errMsg);
}	

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}


/**
 * 품목 조회
 */
function fnSearchPlantItem(str) {
	paramGubn = str;
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnPlantItemSearchPop";
	var width     = "900";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/plantItemList', params, target, width, height, scrollbar, resizable);
}

/**
 * 품목 콜백
 */
function fnCallbackPlantItemSearchPop(rows) {
 	if(paramGubn == 'condition1'){
 		$("#TB_MAT_NUMBER1").val(rows.MAT_NUMBER);
 		$("#TB_MAT_DESC1").val(rows.MAT_DESC);
 	} else if(paramGubn == 'condition2'){
 		$("#TB_MAT_NUMBER2").val(rows.MAT_NUMBER);
 		$("#TB_MAT_DESC2").val(rows.MAT_DESC);
 	} else {
 		var values = {
 		         "MAT_NUMBER"  : rows.MAT_NUMBER 
 		        ,"MAT_DESC"  : rows.MAT_DESC
 		     };
 		gridView.setValues(gridView.getCurrent().itemIndex, values);
 	}
}

//품목 리셋1
function fnMatReset1() {
	$("#TB_MAT_NUMBER1").val("");
	$("#TB_MAT_DESC1").val("");
	fnSearch();
}

//품목 리셋1
function fnMatReset2() {
	$("#TB_MAT_NUMBER2").val("");
	$("#TB_MAT_DESC2").val("");
	fnSearch();
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
                <col style="width:70px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD">
	                    </select>
                    </td>
                    <th><span>품목명</span></th>
                    <td>
                        <input type="text"   id="TB_MAT_DESC">
                    </td>
                    <th><span>문안변경</span></th>
                    <td>
	                    <select id="SB_DRAFT_CHANGE_YN" name="SB_DRAFT_CHANGE_YN">
	                    </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>품목코드</span></th>
                    <td colspan="3">
                        <input type="text"   id="TB_MAT_NUMBER1" disabled style="width: 70px;">
                        <input type="text"   id="TB_MAT_DESC1" disabled style="width: 120px;">
                        <a href="javascript:fnSearchPlantItem('condition1');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnMatReset1();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <em> ~ </em>
                        <input type="text"   id="TB_MAT_NUMBER2" disabled style="width: 70px;">
                        <input type="text"   id="TB_MAT_DESC2" disabled style="width: 120px;">
                        <a href="javascript:fnSearchPlantItem('condition2');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnMatReset2();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
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