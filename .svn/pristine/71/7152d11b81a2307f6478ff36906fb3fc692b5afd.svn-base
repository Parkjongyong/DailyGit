<%--
	File Name : bdgOpExecBugtMgtM.jsp
	Description: 예산 > 예산관리 > 경영예산관리_실행예산
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.25  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.25
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var statusCodes  = new Array();
var statusLabels = new Array();

var clauseCodes  = new Array();
var clauseLabels = new Array();

var distribCodes  = new Array();
var distribLabels = new Array();

var paramGubn = "";
var gridCompCd = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");
	
	var clauseList  = stringToArray("${CODELIST_YS006}");
	fnMakeComboOption('SB_CLAUSE_CD', clauseList,  'CODE', 'CODE_NM', null, "","전체");

	var apprStatusList  = stringToArray("${CODELIST_YS007}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
	statusCodes  = getComboSet('${CODELIST_YS007}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS007}', 'CODE_NM');
	
	clauseCodes  = getComboSet('${CODELIST_YS006}', 'CODE');
	clauseLabels = getComboSet('${CODELIST_YS006}', 'CODE_NM');
	
	distribCodes  = getComboSet('${CODELIST_YS008}', 'CODE');
	distribLabels = getComboSet('${CODELIST_YS008}', 'CODE_NM');
	
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
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];

    addField(cm,    'STATUS',               {text: '상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels},'dropDown');
    addField(cm,    'BELONG_CCTR_CD',       {text:'코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'BELONG_CCTR_NM',       {text:'코스트센터명'},         100,            'text',           {textAlignment:"near"});     
    addField(cm,    'CLAUSE_CD',            {text: '항목'},      120,           'text',              {textAlignment: "center"},{lookupDisplay: true,values:clauseCodes,labels:clauseLabels},'dropDown');
    addField(cm,    'LEVEL_CD',             {text:'레벨'},       60,            'text',              {textAlignment:"center"});
    addField(cm,    'ITEM_CD',              {text:'품목코드'},  100,            'text',              {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},         15,     'popupLink');
    addField(cm,    'ITEM_DESC',            {text:'품목명'},    100,            'text',              {textAlignment:"near"});
    addField(cm,    'DISTRIB_CD',           {text:'유통'},      100,            'text',              {textAlignment:"near"},{lookupDisplay: true,values:distribCodes,labels:distribLabels},'dropDown');
    addField(cm ,   'ACCOUNT_NO',           {text:'계정코드'},         80,            'text',              {textAlignment: 'center'},  {lookupDisplay: true}, 'dropDown', {labelField: "ACCOUNT_NM"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},    100,            'text',           {textAlignment:"near"},{editable:false});
    addField(cm,    'CCTR_CD',              {text:'관리코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING2',         {text: ' '},         15,     'popupLink');
    addField(cm,    'CCTR_NM',              {text:'관리코스트센터명'},         100,            'text',           {textAlignment:"near"});
    addField(cm,    'A01',                  {text:'기본예산'},  100,            'integer',              {textAlignment:"far"});
    addField(cm,    'A02',                  {text:'기준월-2'},  100,            'integer',              {textAlignment:"far"});
    addField(cm,    'A03',                  {text:'기준월-1'},  100,            'integer',              {textAlignment:"far"});
    addField(cm,    'A04',                  {text:'기준월'},    100,            'integer',              {textAlignment:"far"});
    addField(cm,    'B01',                  {text:'기본예산'},  100,            'integer',              {textAlignment:"far"});
    addField(cm,    'B02',                  {text:'기준월-1'},  100,            'integer',              {textAlignment:"far"});
    addField(cm,    'B03',                  {text:'기준월'},    100,            'integer',              {textAlignment:"far"});
    addField(cm,    'C01',                  {text:'기본예산'},  100,            'integer',              {textAlignment:"far"});
    addField(cm,    'C02',                  {text:'기준월'},    100,            'integer',              {textAlignment:"far"});
    addGroup(cm, {"기준월계획" : ["A01","A02","A03","A04"], "기준월+1 계획" : ["B01","B02","B03"], "기준월+2 계획" : ["C01","C02"]});

    
    addField(cm,    'CRUD',                 {text: 'CRUD'},         0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월일'},       0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PROJECT_CD',           {text: '프로젝트코드'},     0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CNT',                  {text: '실행예산신청승인건'},       0,     'integer', {textAlignment: "center"},{visible:false});

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

    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
       		fnSearchItem();
       	}
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING2"){
        	gridCompCd = grid.getCurrentRow().COMP_CD;
       		fnSearchCctr('grid');
       	}

    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };

    gridView.setFixedOptions({
    	  colCount: 12
    });    

    gridView.setHeader(
      {height : 50}
    );
    
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
    
    // 기본 스타일 적용(수정불가)
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.CRUD;
        var status = values.STATUS;
        var cnt    = values.CNT;
        if (gubn == 'I') {
            styles.editable = true;
        } else {
        	
        	if (status != '1' && status != '2') {
        		styles = disibleColStyle;
        	} else {
        		if (cnt == 0) {
        			styles = enableColStyle;
        		} else {
        			styles = disibleColStyle;
        		}
        	}
        }

        return styles;
    };     
    
    
    gridView.setColumnProperty("CLAUSE_CD"  , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("DISTRIB_CD"  , "dynamicStyles", columnDynamicStyles);
    //gridView.setColumnProperty("ACCOUNT_NO"  , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("ACCOUNT_DESC"  , "dynamicStyles", columnDynamicStyles);
    
    gridView.setColumnProperty("STATUS" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("LEVEL_CD" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ITEM_CD" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ITEM_DESC" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_CD"  , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_NM"  , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BELONG_CCTR_CD" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BELONG_CCTR_NM" , "dynamicStyles", columnDefaultStyles);
    
    
    gridView.setColumnProperty("A01" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("A02" , "dynamicStyles", columnDefaultStyles);  
    gridView.setColumnProperty("A03" , "dynamicStyles", columnDefaultStyles);    
    gridView.setColumnProperty("B01" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("B02" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("C01" , "dynamicStyles", columnDefaultStyles);
    
    gridView.setColumnProperty("A04" , "dynamicStyles", columnDynamicStyles2);
    gridView.setColumnProperty("B03" , "dynamicStyles", columnDynamicStyles2);
    gridView.setColumnProperty("C02" , "dynamicStyles", columnDynamicStyles2);

    gridView.setColumnProperty("ACCOUNT_NO", "dynamicStyles", 
        	function (grid, index, value) {
        		var ret = {};
        		var gubun = grid.getValue(index.itemIndex, "CLAUSE_CD");
                var crud  = grid.getValue(index.itemIndex, "CRUD");
                
                if (crud == 'I') {
                	ret = enableColStyle;
                } else {
                	ret = disibleColStyle;
                }  		
        		    
                ret.editor = {
                	type: "dropDown",
                    values: getComboSet("${CODELIST_SYSACC}", "CODE" , $('#SB_COMP_CD').val(), gubun),
                    labels: getComboSet("${CODELIST_SYSACC}", "CODE_NM" , $('#SB_COMP_CD').val(), gubun)
                }		    
        		
        		return ret;
        	}
        ); 
    
    // ACCOUNT_NO 콤보 변경 시 ACCOUNT_NM 값 셋팅
    gridView.onGetEditValue = function (grid, index, editResult) {
        if (index.fieldName === "ACCOUNT_NO") {
        	gridView.setValue(index.itemIndex, "ACCOUNT_DESC", editResult.text);
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
	searchCall(gridView, '/com/bdg/selectOpExec');
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

/**
 * 계정 조회
 */
function fnSearchAccount() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/accountSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 계정 콜백
 */
function fnCallbackAccountSearchPop(rows) {
	var values = {
	         "ACCOUNT_NO"   : rows.ACCOUNT_NO 
	        ,"ACCOUNT_DESC" : rows.ACCOUNT_DESC
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);
	
	searchCall(gridView, '/com/bdg/selectSupplementAmt', 'fnSetAmt', null);
}

/**
 * 품목 조회
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
 * 품목 콜백
 */
function fnCallbackItemMgmtSearchPop(rows) {
	var values = {
	         "ITEM_CD"   : rows.ITEM_CD 
	        ,"ITEM_DESC" : rows.ITEM_DESC
	        ,"LEVEL_CD" : rows.LVL
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);
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
	              ,"STATUS" : "1"
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replaceAll('-', '')
	              ,"CCTR_CD" : $('#SB_BELONG_CCTR_CD').val()
	              ,"CCTR_NM" : $("#TB_BELONG_CCTR_NM").val()
	              ,"BELONG_CCTR_CD" : $('#SB_BELONG_CCTR_CD').val()
	              ,"BELONG_CCTR_NM" : $('#TB_BELONG_CCTR_NM').val()
	              ,"CODEMAPPING1" : "1"
	              ,"CODEMAPPING2" : "1"
	              };
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	fnSearch();

}

function fnSaveFail(result) {
	alert(result.errMsg);
}



/**
 * 저장
 */
function fnSave() {
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "SA"});
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CLAUSE_CD", "LEVEL_CD", "ITEM_CD", "ITEM_DESC", "DISTRIB_CD", "ACCOUNT_NO", "CCTR_CD"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
	    	 saveCall(gridView, '/com/bdg/saveOpExec', null, params);
	     }
	}

}

//당월기본예산, 배정실행예산, 현재실적, 실행잔액 세팅
function fnSetAmtSuccess(data) {
	var curr = gridView.getCurrent().itemIndex;
	if(isNotEmpty(data.rows[0]) == true){
		gridView.setValue(curr, "BUGT_BASIC_AMT",   data.rows[0].BUGT_BASIC_AMT);
		gridView.setValue(curr, "BUGT_EXEC_AMT",    data.rows[0].BUGT_EXEC_AMT);
		gridView.setValue(curr, "BUGT_RESULT_AMT",  data.rows[0].BUGT_RESULT_AMT);
		gridView.setValue(curr, "BUGT_BALANCE_AMT", data.rows[0].BUGT_BALANCE_AMT);
	}
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}


/**
 * 확정취소
 */
function fnConfirmCancel() {
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
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
	
    if(confirm("확정취소 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/confirmCancelOpExec', 'fnConfirmCancel', params);
    }

}

function fnConfirmCancelSuccess(data) {
	alert("확정취소 되었습니다.");
	fnSearch();

}

function fnConfirmCancelFail(result) {
	alert(result.errMsg);
}

/**
 * 전송
 */
function fnSend() {
	if($("#SB_COMP_CD").val() == null || $("#SB_COMP_CD").val() == ""){
		alert("회사는 필수입니다.");
		return false;
	}
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("년월은 필수입니다.");
		return false;
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	
    if(confirm("전송 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendOpExec', 'fnSend', params);
    }
	
}


function fnSendSuccess(data) {
	alert("전송 되었습니다.");
	fnSearch();

}

function fnSendFail(result) {
	alert(result.errMsg);
}

/**
 * 전송취소
 */
function fnSendCancel() {
	if($("#SB_COMP_CD").val() == null || $("#SB_COMP_CD").val() == ""){
		alert("회사는 필수입니다.");
		return false;
	}
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("년월은 필수입니다.");
		return false;
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	
    if(confirm("전송취소 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendCancelOpExec', 'fnSendCancel', params);
    }
	
}


function fnSendCancelSuccess(data) {
	alert("전송취소 되었습니다.");
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

//코스트 리셋
function fnCctrReset() {
	$("#SB_BELONG_CCTR_CD").val("");
	$("#TB_BELONG_CCTR_NM").val("");
	fnSearch();
}

/**
 * 삭제 
 */
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
		deleteCall(gridView, '/com/bdg/deleteOpExec', 'fnDelete', params);
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


//실행예산생성
var fnCreate = function(){
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	
     if(confirm("실행예산생성 하시겠습니까?(당월작성중인 데이터는 모두 삭제됩니다.)")){
    	 saveCall(gridView, '/com/bdg/createOpExecBugtMgt', 'fnCreate', params);
     }
	
}

function fnCreateSuccess(data) {
	alert("실행예산 생성 되었습니다.");
	gridView.clearRows();
	fnSearch();

}

function fnCreateFail(result) {
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
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCctrReset()">
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:90px;" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_BELONG_CCTR_NM" disabled="disabled">
                        <input type="hidden" id="SB_BELONG_CCTR_CD">
                        <a href="javascript:fnSearchCctr('header');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
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
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnCreate">실행예산생성</button>
        <button type="button" class="btn" id="btnConfirmCancel">확정취소</button>
        <button type="button" class="btn" id="btnSend">전송</button>
        <button type="button" class="btn" id="btnSendCancel">전송취소</button>
        <button type="button" class="btn" id="btnSave">저장</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
