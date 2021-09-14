<%--
	File Name : bdgOpBasicMgtM.jsp
	Description: 예산 > 예산관리 > 경영예산관리_기본예산
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.25 길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.25
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compCodes  = new Array();
var compLabels = new Array();

var clauseCdCodes  = new Array();
var clauseCdLabels = new Array();

var distibCdCodes  = new Array();
var distibCdLabels = new Array();

var accountCdCodes  = new Array();
var accountCdLabels = new Array();

var rowIndex  = "";
var paramGubn = "";

var gridCompCd = "";

$(document).ready(function() {
	
	var compList     = stringToArray("${CODELIST_SYS001}");
	var clauseCdList = stringToArray("${CODELIST_YS006}");
	
	var apprStatusList  = stringToArray("${CODELIST_YS007}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD' , compList,      'CODE', 'CODE_NM', null, "","전체");
    fnMakeComboOption('SB_CLAUSE_CD', clauseCdList, 'CODE', 'CODE_NM', null, "","전체");

    clauseCdCodes  = getComboSet('${CODELIST_YS006}', 'CODE');
    clauseCdLabels = getComboSet('${CODELIST_YS006}', 'CODE_NM');
	
    distibCdCodes  = getComboSet('${CODELIST_YS008}', 'CODE');
    distibCdLabels = getComboSet('${CODELIST_YS008}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YY").val(getDiffDay("y",1).substring(0,4));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'STATUS_NM',            {text:'상태'},         60,            'text',              {textAlignment:"center"});
    addField(cm,    'BELONG_CCTR_CD',       {text:'코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'BELONG_CCTR_NM',       {text:'코스트센터명'},         100,            'text',           {textAlignment:"near"});    
    addField(cm ,   'CLAUSE_CD',            {text:'항목'},         120,            'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:clauseCdCodes, labels:clauseCdLabels}, 'dropDown');
    addField(cm,    'LEVEL_CD',             {text:'레벨'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'ITEM_CD',              {text:'품목'},         100,            'text',           {textAlignment:"near"});
    addField(cm,    'ITEM_DESC',            {text:'품목명'},        120,            'text',           {textAlignment:"near"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    addField(cm ,   'DISTRIB_CD',           {text:'유통'},         80,            'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:distibCdCodes, labels:distibCdLabels}, 'dropDown');
    addField(cm ,   'ACCOUNT_NO',           {text:'계정코드'},         80,            'text',              {textAlignment: 'center'},  {lookupDisplay: true}, 'dropDown', {labelField: "ACCOUNT_NM"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},    130,            'text',           {textAlignment:"near"},{editable:false});
    addField(cm,    'CCTR_CD',               {text:'관리코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',               {text:'관리코스트센터명'},         100,            'text',           {textAlignment:"near"});
    addField(cm,    'CODEMAPPING2',         {text: ' '},             20,     'popupLink');
    
    addField(cm,    'WK_M01',               {text:'1월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'TOTAL',                {text:'합계'},          100,            'integer',           {textAlignment:"far"});
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',               {text: '상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BELONG_CCTR_CD',        {text: '귀속코스트센터'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CNT',                  {text: '기본예산신청승인건'},       0,     'text', {textAlignment: "center"},{visible:false});
    

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_3       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    

    gridView.onDataCellClicked = function (grid, data) {
    	// 품목코드
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchItem();
        }
        
        if (data.column == "CODEMAPPING2" && grid.getCurrentRow().CRUD == "I") {
        	gridCompCd = grid.getCurrentRow().COMP_CD;
        	fnSearchCctr('grid');
        }  
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.CRUD;
        var status = values.STATUS;
        if (gubn == 'I') {
            styles.editable = true;
        } else {
        	
        	if (status != '1') {
        		styles = disibleColStyle;
        	} else {
        		styles = enableColStyle;
        	}
        }
        return styles;
    }; 
    
    gridView.setColumnProperty("CLAUSE_CD", "dynamicStyles", 
        	function (grid, index, value) {
        		var styles = {};
                var crud  = grid.getValue(index.itemIndex, "CRUD");
                
                if (crud == 'I') {
                	styles = enableColStyle;
                } else {
                	styles = disibleColStyle;
                } 
                
                styles.editor = {
                	type: "dropDown",
                    values: clauseCdCodes,
                    labels: clauseCdLabels
                };		    
        		
        		return styles;
        	}
        );     
    gridView.setColumnProperty("DISTRIB_CD", "dynamicStyles", 
        	function (grid, index, value) {
        		var styles = {};
                var crud  = grid.getValue(index.itemIndex, "CRUD");
                
                if (crud == 'I') {
                	styles = enableColStyle;
                } else {
                	styles = disibleColStyle;
                } 
                
                styles.editor = {
                	type: "dropDown",
                    values: distibCdCodes,
                    labels: distibCdLabels
                };		    
        		
        		return styles;
        	}
        );
    
    gridView.setColumnProperty("STATUS_NM"     , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ITEM_CD"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("LEVEL_CD"      , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ITEM_DESC"     , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ACCOUNT_NM"    , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BELONG_CCTR_CD" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BELONG_CCTR_NM" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ACCOUNT_NO"     , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ACCOUNT_DESC"   , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_CD"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_NM"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("TOTAL"          , "dynamicStyles", columnDefaultStyles);  
    
    gridView.setColumnProperty("WK_M01"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M02"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M03"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M04"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M05"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M06"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M07"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M08"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M09"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M10"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M11"        , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("WK_M12"        , "dynamicStyles", columnDynamicStyles);    
    
    gridView.setColumnProperty("ACCOUNT_NO", "dynamicStyles", 
        	function (grid, index, value) {
        		var styles = {};
        		var gubun = grid.getValue(index.itemIndex, "CLAUSE_CD");
                var crud  = grid.getValue(index.itemIndex, "CRUD");
                
                if (crud == 'I') {
                	styles = enableColStyle;
                } else {
                	styles = disibleColStyle;
                } 
                if (isEmpty(gubun)) {
                    styles.editor = {};
                } else {
                    styles.editor = {
    		                    	type: "dropDown",
    		                        values: getComboSet("${CODELIST_SYSACC}", "CODE" , $('#SB_COMP_CD').val(), gubun),
    		                        labels: getComboSet("${CODELIST_SYSACC}", "CODE_NM" , $('#SB_COMP_CD').val(), gubun)
                        			};            	
                }
        		
        		return styles;
        	}
        ); 
    
    // ACCOUNT_NO 콤보 변경 시 ACCOUNT_NM 값 셋팅
    gridView.onGetEditValue = function (grid, index, editResult) {
        if (index.fieldName === "ACCOUNT_NO") {
        	gridView.setValue(index.itemIndex, "ACCOUNT_DESC", editResult.text);
        }
    };    

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	var values = grid.getValues(itemIndex);
    	gridView.setValue(itemIndex, "TOTAL", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06) + toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));    	
    	gridView.checkItem(dataRow, true);
    };
    
    //paste 시 합계 자동 계산
    gridView.onRowsPasted = function(grid, items){
    	for(var i = 0; i < items.length; i++){
    		var values = grid.getValues(items[i]);
        	gridView.setValue(items[i], "TOTAL", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06) + toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
        	gridView.checkItem(items[i], true);
    	}
    };      

    fnGridSortFalse(gridView);
    gridView.setDisplayOptions({columnMovable:false})
}

/**
 * 조회
 */
function fnSearch() {
	
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectOpBasicMgtList');
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
function fnSave() {
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만 저장가능합니다.");
			return false;				
		}
	}	
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CCTR_CD", "CLAUSE_CD", "LEVEL_CD", "ITEM_CD", "ITEM_DESC", "DISTRIB_CD", "ACCOUNT_NO", "BELONG_CCTR_CD"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
			var params = {};
			$.extend(params, {"GUBN"      : "SC"});
			$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
			$.extend(params, fnGetParams());
			
			saveCall(gridView, '/com/bdg/saveOpBasicMgt', 'fnSave', params);
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


//행추가
function fnRowAdd() {
	if($("#SB_COMP_CD").val() == null || $("#SB_COMP_CD").val() == ""){
		alert("회사는 필수입니다.");
		return false;
	}
	
	if($("#SB_BELONG_CCTR_CD").val() == null || $("#SB_BELONG_CCTR_CD").val() == ""){
		alert("코스트센터는 필수입니다.");
		return false;
	}
	
	var values = { "CRUD" : "I" 
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YY" : $('#TB_CRTN_YY').val()
			      ,"BELONG_CCTR_CD" : $('#SB_BELONG_CCTR_CD').val()
			      ,"BELONG_CCTR_NM" : $("#TB_BELONG_CCTR_NM").val()
			      ,"STATUS_NM" : "저장"
			      ,"STATUS" : "1"
			      ,"CODEMAPPING1" : "1"
			      ,"CODEMAPPING2" : "1"
			      ,"CCTR_CD"      : $('#SB_BELONG_CCTR_CD').val()
			      ,"CCTR_NM"      : $('#TB_BELONG_CCTR_NM').val()
			      };
	
	fnAddRow(gridView, values, gridView.getRowCount());
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

// //삭제
function fnDelete() {
	
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만 삭제가능합니다.");
			return false;				
		}
	}	
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "DE"});
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/deleteOpBasicMgt', 'fnDelete', params);
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

//확정취소
function fnCancel() {
	
	if(isEmpty($("#SB_COMP_CD").val()) == true){
		alert("회사를 선택해주십시오.");
		return false;
	}

	if(isEmpty($("#SB_BELONG_CCTR_CD").val()) == true){
		alert("코스트센터를 선택해주십시오.");
		return false;
	}
	
	if(gridView.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("데이터가 존재하지 않습니다.");
		return false;
	}

	
	var params = {};
	$.extend(params, fnGetParams());
	
    if(confirm("확정 취소 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/cancelOpBasicMgt', 'fnCancel', params);
    }
	
}

function fnCancelSuccess(data) {
	alert("확정취소 되었습니다.");
    gridView.closeProgress();
    fnSearch();
}

function fnCancelFail(result) {
	alert(result.errMsg);
}

//전송
function fnSend() {
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "SD"});
	
    if(confirm("전송 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendOpBasicMgt', 'fnSend', params);
    }
	
}

function fnSendSuccess(data) {
	alert("전송 되었습니다.");
    gridView.closeProgress();
    fnSearch();
}

function fnSendFail(result) {
	alert(result.errMsg);
}

//전송
function fnSendCancel() {
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "SC"});
	
    if(confirm("전송취소 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendCancelOpBasicMgt', 'fnSendCancel', params);
    }
	
}

function fnSendCancelSuccess(data) {
	alert("전송취소 되었습니다.");
    gridView.closeProgress();
    fnSearch();
}

function fnSendCancelFail(result) {
	alert(result.errMsg);
}

/**
 * 코스트 조회
 */
function fnSearchCctr(str) {
	paramGubn = str;
	var params = {};
	$.extend(params, fnGetParams());
	if(paramGubn == 'grid'){
		$.extend(params, {"SB_COMP_CD" : gridCompCd});
	}
	var target    = "cmnCctrSearchPop";
	var width     = "900";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/cctrList', params, target, width, height, scrollbar, resizable);
}

/**
 * 코스트 콜백
 */
function fnCallbackPop(rows) {
	if(paramGubn == 'header'){
		$("#SB_BELONG_CCTR_CD").val(rows.CCTR_CD);
		$("#TB_BELONG_CCTR_NM").val(rows.CCTR_NM);
		fnSearch();
	} else {
		var values = {
		         "CCTR_CD"  : rows.CCTR_CD
		        ,"CCTR_NM"  : rows.CCTR_NM
		     };

		gridView.setValues(gridView.getCurrent().itemIndex, values);
		
	}
}

/**
 * 품목팝업
 */
function fnSearchItem() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnItemMgmtSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/cmnItemMgmtSearchPop', params, target, width, height, scrollbar, resizable);
}

/**
 * 품목팝업 콜백
 */
function fnCallbackItemMgmtSearchPop(rows) {
	gridView.setRowValue(gridView.getCurrent().itemIndex, "ITEM_CD" , rows.ITEM_CD);
    gridView.setRowValue(gridView.getCurrent().itemIndex, "ITEM_DESC", rows.ITEM_DESC);
    gridView.setRowValue(gridView.getCurrent().itemIndex, "LEVEL_CD" , rows.LVL);
}

//코스트센터 리셋
function fnCctrReset() {
	$("#TB_BELONG_CCTR_NM").val("");
	$("#SB_BELONG_CCTR_CD").val("");
	fnSearch();
}

/**
 * 엑셀
 */
 function fnExcel() {
		var params = {};
		$.extend(params, fnGetParams());
		
		if(isEmpty(params.SB_COMP_CD) == true){
			alert("회사는 필수입니다.");
			return false;
		}
		
		if(isEmpty(params.TB_CRTN_YY) == true){
			alert("년도은 필수입니다.");
			return false;
		}
		
		if(isEmpty(params.SB_BELONG_CCTR_CD) == true){
			alert("코스트센터는 필수입니다.");
			return false;
		}
		
		var target    = "bdgOpBasicMgtExcel";
		var width     = "1800";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	 	fnPostPopup('/com/bdg/bdgOpBasicMgtExcel', params, target, width, height, scrollbar, resizable);

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
                <col style="width:100px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCctrReset()">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
                    	<input type="number" id="TB_CRTN_YY"  style="text-align: right; width: 50px; text-align: center" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_BELONG_CCTR_NM" style="text-align: near;" disabled>&nbsp;
                        <a href="javascript:fnSearchCctr('header');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <input type="hidden" id="SB_BELONG_CCTR_CD">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>항목</span></th>
                    <td>
	                    <select id="SB_CLAUSE_CD" name="SB_CLAUSE_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <th><span>상태</span></th>
                    <td>
	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <td></td>
                    <td></td>
					<td></td>
                    <td></td>
                </tr>                
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearch">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 15px;">(단위 : 원)</th>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right">
		<button type="button" class="btn" id="btnExcel">EXCEL UPLOAD</button>
<!--         <button type="button" class="btn" id="btnDownload">양식지받기</button> -->
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnCancel">확정취소</button>
        <button type="button" class="btn" id="btnSend">전송</button>
        <button type="button" class="btn" id="btnSendCancel">전송취소</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>

<div class="realgrid-area">
    <div id="gridView"></div> 
</div>

