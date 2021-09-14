<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 추가예산관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.21  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.21
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var apprCodes  = new Array();
var apprLabels = new Array();
var processTypeCodes  = new Array();
var processTypeLabels = new Array();

var processType  = "";
var paramGubn    = "";


$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
	apprCodes  = getComboSet('${CODELIST_YS001}', 'CODE');
	apprLabels = getComboSet('${CODELIST_YS001}', 'CODE_NM');
	
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	

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
	$("#TB_CRTN_YMD").val(getDiffDay("y",0));
	$("#SB_SAP_SEND_YN").val("N");
	$("#TB_START_DT").val(getDiffDay("m",-1));
	$("#TB_END_DT").val(getDiffDay("y",0));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];

    addField(cm,    'CRTN_YMD',             {text: '작성일자'},      60,     'text', {textAlignment: 'center'});
    addField(cm,    'SAP_SEND_YN',          {text: '전송여부'},      60,     'text', {textAlignment: 'center'});
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'STATUS',               {text: '승인상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:apprCodes,labels:apprLabels, editable:false},'dropDown');
    addField(cm,    'CCTR_CD',               {text: '코스트센터'},      80,     'text', {textAlignment: 'center'});
    addField(cm,    'CODEMAPPING1',  	    {text: ' '},    15,     'popupLink');
    addField(cm,    'CCTR_NM',               {text: '코스트센터명'},       100,     'text', {textAlignment: 'center'});
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'text',              {textAlignment:"center"});
    addField(cm,    'CODEMAPPING2',  	    {text: ' '},    15,     'popupLink');
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'BUGT_BASIC_AMT',       {text:'당월기본예산'},  100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_EXEC_AMT',        {text:'배정실행예산'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_RESULT_AMT',      {text:'현재실적'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_BALANCE_AMT',    {text:'실행잔액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REQUEST_AMT',          {text:'신청액'},    100,            'integer',           {textAlignment:"far"});
    addField(cm,    'CODEMAPPING3',  	    {text: '상세내역'},    50,     'popupLink');
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PROCESS_TYPE',         {text: '등록구분'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'REQUEST_DESC',         {text: '추가예산내역'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_4       //required 그리드 높이
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
       	$("#TB_REQUEST_DESC").val(gridView.getValue(colIndex.itemIndex,"REQUEST_DESC"));
       	
        if (gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' &&  colIndex.fieldName == "CODEMAPPING1") {
        	fnSearchCctr();
        }
       	
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING2"){
       		if(isEmpty(gridView.getValue(colIndex.itemIndex,"CCTR_CD")) == true){
       			alert("코스트센터는 필수입력입니다.");
       			return false;
       		}
       		
        	fnSearchAccount();
       	}
       	
       	if(colIndex.fieldName == "CODEMAPPING3"){
       		if (gridView.getValue(colIndex.itemIndex,"CRUD") == 'I') {
    			alert("상세내역은 저장후 사용 가능합니다. 등록 후 작업하세요.");
    			return false;
       		} else {
       			if (gridView.getValue(colIndex.itemIndex, "ACCOUNT_NO") != "0055004040") {
        			alert("여비교통비/국내출장 계장만 등록 및 조회 가능합니다. 확인 후 작업하세요.");
        			return false;      				
       			} else {
       				fnSearchDetail(colIndex);	
       			}
       		}
       	}         	

    };

    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
        // 동적 스타일 적용
        var columnDynamicStyles = function(grid, index, value) {
            var styles = {};
            var values = grid.getValues(index.itemIndex);
            var gubn   = values.CRUD;
            var processType = values.PROCESS_TYPE;
            var status = values.STATUS;
            if (gubn == 'I') {
            	styles = enableColStyle;
            } else {
            	if (processType == "2") {
            		styles = disibleColStyle;
            	} else {
//                     if (status == '1' || status == '3') {
//                     	styles = enableColStyle;
//                     } else {
//                     	styles = disibleColStyle;
//                     }
            		styles = enableColStyle;
            	}
            }
            return styles;
        };
        
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
            return disibleColStyle;
        };        
        
        setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
        gridView.setColumnProperty("REQUEST_AMT"    , "dynamicStyles", columnDynamicStyles);
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    fnGridSortFalse(gridView);
    gridView.setDisplayOptions({columnMovable:false})
}

/**
 * 상세내역 조회
 */
function fnSearchDetail(data) {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_NM" : $("#SB_COMP_CD option:selected").text()});
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	var target    = "bdgSupplementDetail";
	var width     = "1200";
	var height    = "720";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgSupplementDetail', params, target, width, height, scrollbar, resizable);
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectSupplement');
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
    if(data.rows.length > 0){
    	$("#TB_REQUEST_DESC").val(data.rows[0].REQUEST_DESC);
    } else {
    	$("#TB_REQUEST_DESC").val("");
    }
}

//행추가
function fnRowAdd() {
	if(isEmpty($("#SB_COMP_CD").val()) == true){
		alert("회사를 선택하십시오.");
		return false;
	}
	
	if(isEmpty($("#SB_CCTR_CD").val()) == true){
		alert("코스트센터를 선택하십시오.");
		return false;
	}	
	
	var values = { "CRUD" : "I" 
	              ,"STATUS" : "1"
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YMD" : $('#TB_CRTN_YMD').val().replaceAll('-', '')
	              ,"PROCESS_TYPE" : "1"
	              ,"CCTR_CD" : $("#SB_CCTR_CD").val()
	              ,"CCTR_NM" : $("#SB_CCTR_CD option:selected").text()
	              ,"SAP_SEND_YN" : "N"
	              ,"CODEMAPPING1" : "1"
	              ,"CODEMAPPING2" : "1"
	             };
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

// 반려
var fnReturn = function(){
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	if(gridView.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("반려 할 데이터가 존재하지 않습니다. 조회 후 진행하십시오.");
		return false;
	}	
	
// 	for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
// 		if(params.ITEM_LIST.UPDATED[i].STATUS != '5'){
// 			alert("반려 불가능 데이터입니다.");
// 			return false;
// 		}
// 	}
	
    if(confirm("반려 하시겠습니까?")){
   		saveCall(gridView, '/com/bdg/returnSupplement', 'fnReturn', params);
    }
}

function fnReturnSuccess(data) {
	alert("반려 되었습니다.");
	fnSearch();

}

function fnReturnFail(result) {
	alert(result.errMsg);
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
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CCTR_CD", "ACCOUNT_NO", "REQUEST_AMT"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
	    	 saveCall(gridView, '/com/bdg/saveSupplement', null, params);
	     }
	}

}


/**
 * 삭제
 */
function fnDelete() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(isEmpty(params.ITEM_LIST.DELETED.length)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	
// 	for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
// 		if(params.ITEM_LIST.DELETED[i].STATUS == '2' || params.ITEM_LIST.DELETED[i].STATUS == '4'){
// 			alert("작성중, 반려인 건만 삭제 가능합니다.");
// 			return false;
// 		}
// 	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delSupplement', 'fnDel', params);
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

//작성일자 체크
function fnCheckDate() {
	if($("#TB_CRTN_YMD").val().substring(0,7) < getDiffDay("m",-1).substring(0,7)){
		alert("작성일자는 전월까지 가능합니다.");
		$("#TB_CRTN_YMD").val(getDiffDay("y",0));
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
 * 계정 조회
 */
function fnSearchAccount() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ACCOUNT_GUBN" : "S"});
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

	$("#TB_ACCOUNT_NO").val(rows.ACCOUNT_NO);
	gridView.setValues(gridView.getCurrent().itemIndex, values);
	searchCall(gridView, '/com/bdg/selectSupplementAmt', 'fnSetAmt', null);
}


//SAP 전송 
function fnSap() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});

	if(isEmpty(params.ITEM_LIST)){
		alert("전송할 대상이 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
		if(params.ITEM_LIST.UPDATED[i].SAP_SEND_YN == 'Y'){
			alert("미전송 건만 가능합니다.");
			return false;
		}
	}

    if(confirm("전송 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendSupplement', 'fnSap', params);
    }

}

function fnSapSuccess(data) {
	alert("전송 되었습니다.");
}

function fnSapFail(result) {
	alert(result.errMsg);
}

/**
 * 코스트 조회
 */
function fnSearchCctr(str) {
	paramGubn = str;
	var params = {};
	$.extend(params, fnGetParams());
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
	$("#SB_CCTR_CD").val(rows.CCTR_CD);
	$("#TB_CCTR_NM").val(rows.CCTR_NM);
	fnSearch();
}



//코스트 리셋
function fnCctrReset() {
	$("#SB_CCTR_CD").val("");
	$("#TB_CCTR_NM").val("");
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
                <col style="width:120px">
                <col style="width:430px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCctrReset();">
	                    </select>
                    </td>
                    <th><span>작성일자</span></th>
                    <td>
						<input type="text" class="datepicker" id="TB_CRTN_YMD"  value="" style="width:90px;" onchange="fnCheckDate()"/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_CCTR_NM" disabled="disabled">
                        <input type="hidden" id="SB_CCTR_CD">
                        <a href="javascript:fnSearchCctr();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>전송여부</span></th>
                    <td>
	                    <select id="SB_SAP_SEND_YN" name="SB_SAP_SEND_YN" onchange="fnSearch();">
                            <option value="">전체</option>
                            <option value="Y">Y</option>
                            <option value="N">N</option>
	                    </select>
                    </td>
                    <th><span>기간</span></th>
                    <td>
                        <span class="date-area">
                        	<input type="text" class="datepicker" id="TB_START_DT" style="width:90px; height:28px;" onchange="fnSearch();">
                        </span>
                        <em> ~ </em>
                        <span class="date-area">
                        	<input type="text" class="datepicker" id="TB_END_DT" style="width:90px; height:28px;" onchange="fnSearch();">
                        </span>
                    </td>
                    <th><span>승인상태</span></th>
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
        <button type="button" class="btn" id="btnSap">SAP전송</button>
        <button type="button" class="btn" id="btnReturn">반려</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
<table class="tbl-view">
	<colgroup>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th><span>추가예산내역<br></span></th>
			<td>
				<textarea rows="2" id="TB_REQUEST_DESC"></textarea>
			</td>
		</tr>
	</tbody>
</table>