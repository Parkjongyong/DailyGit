<%--
	File Name : bdgOpSupplement.jsp
	Description: 예산 > 예산관리 > 경영예산등록_추가예산
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

var clauseCdCodes  = new Array();
var clauseCdLabels = new Array();

var distribCode = "";
var distribDesc = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM');
	
	fnCompCdChange();
	
	var apprStatusList  = stringToArray("${CODELIST_YS007}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");

	statusCodes  = getComboSet('${CODELIST_YS007}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS007}', 'CODE_NM');
	
    clauseCdCodes  = getComboSet('${CODELIST_YS006}', 'CODE', 'Y');
    clauseCdLabels = getComboSet('${CODELIST_YS006}', 'CODE_NM', 'Y');	
	
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
}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels},'dropDown');
    addField(cm ,   'CLAUSE_CD',            {text:'항목'},     120,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:clauseCdCodes, labels:clauseCdLabels},'dropDown');
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'text',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'BUGT_BASIC_AMT',       {text:'당월기본예산'},  100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_EXEC_AMT',        {text:'배정실행예산'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_RESULT_AMT',      {text:'현재실적'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'BUGT_BALANCE_AMT',    {text:'실행잔액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REQUEST_AMT',          {text:'신청액'},    100,            'integer',           {textAlignment:"far"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트센터'},        0,     'text', {textAlignment: 'center'},  {visible:false});

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


    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn = values.STATUS;
        if (gubn == '1') {
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
 
    
	gridView.setColumnProperty("STATUS"  , "dynamicStyles", columnDefaultStyles);
// 	gridView.setColumnProperty("ACCOUNT_NO"  , "dynamicStyles", columnDefaultStyles);
 	gridView.setColumnProperty("ACCOUNT_DESC"  , "dynamicStyles", columnDefaultStyles);
	gridView.setColumnProperty("BUGT_BASIC_AMT"  , "dynamicStyles", columnDefaultStyles);
	gridView.setColumnProperty("BUGT_EXEC_AMT"  , "dynamicStyles", columnDefaultStyles);
	gridView.setColumnProperty("BUGT_RESULT_AMT"  , "dynamicStyles", columnDefaultStyles);
	gridView.setColumnProperty("BUGT_BALANCE_AMT"  , "dynamicStyles", columnDefaultStyles);

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
    
    gridView.setColumnProperty("REQUEST_AMT", "dynamicStyles", 
        	function (grid, index, value) {
        		var styles = {};
                var status  = grid.getValue(index.itemIndex, "STATUS");
                
                if (status == '1') {
                	styles = enableColStyle;
                } else {
                	styles = disibleColStyle;
                }
                
                styles.editor = {
                    	type: "integer",
            			};                   
                
        		return styles;
        	}
        ); 
    
    // ACCOUNT_NO 콤보 변경 시 ACCOUNT_NM 값 셋팅
    gridView.onGetEditValue = function (grid, index, editResult) {
        if (index.fieldName === "ACCOUNT_NO") {
        	gridView.setValue(index.itemIndex, "ACCOUNT_DESC", editResult.text);
        	var gubun = grid.getValue(index.itemIndex, "CLAUSE_CD");
        	
       		$("#TB_ACCOUNT_NO").val(editResult.value);
       		var params = {};
       		$.extend(params, fnGetParams());
       		searchCall(gridView, '/com/bdg/selectOpSupplementAmt', 'fnSetAmt', params);
        }
        
        if (index.fieldName === "CLAUSE_CD") {
        	gridView.setValue(index.itemIndex, "ACCOUNT_NO", '');
        	gridView.setValue(index.itemIndex, "ACCOUNT_DESC", '');
        	gridView.setValue(index.itemIndex, "BUGT_BASIC_AMT", '');
        	gridView.setValue(index.itemIndex, "BUGT_EXEC_AMT", '');
        	gridView.setValue(index.itemIndex, "BUGT_RESULT_AMT", '');
        	gridView.setValue(index.itemIndex, "BUGT_BALANCE_AMT", '');
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
	searchCall(gridView, '/com/bdg/selectOpSupplement');
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
	if(isEmpty($("#SB_COMP_CD").val()) == true){
		alert("회사를 선택해주세요.");
		return false;
	}
	
	var values = { "CRUD" : "I" 
        ,"STATUS" : "1"
        ,"COMP_CD" : $('#SB_COMP_CD').val()
        ,"CRTN_YMD" : $('#TB_CRTN_YMD').val().replaceAll('-', '')
        ,"CCTR_CD" : $('#SB_CCTR_CD').val()
        //,"CLAUSE_CD" : "3"
        };	
	
	fnAddRow(gridView, values, gridView.getRowCount());	
	
	//
}

// 확정
var fnConfirm = function(){
	var params = {};
	$.extend(params, fnGetParams());

     if(confirm("확정 하시겠습니까?")){
    	 saveCall(gridView, '/com/bdg/confirmOpSupplement', 'fnConfirm', params);
     }
}

function fnConfirmSuccess(data) {
	alert("확정 되었습니다.");
	fnSearch();

}

function fnConfirmFail(result) {
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
	
	if(gridView.getCheckedItems(false).length == 0){
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.CREATED.length; i++){
		if(toNumber(params.ITEM_LIST.CREATED[i].BUGT_BALANCE_AMT) + toNumber(params.ITEM_LIST.CREATED[i].REQUEST_AMT) < 0){
			alert("신청액이 부족합니다.");
			return false;
		}
	}
	
	for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
		if(params.ITEM_LIST.UPDATED[i].STATUS != '1'){
			alert("확정,전송된 데이터는 저장이 불가능합니다.");
			return false;
		}
		if(toNumber(params.ITEM_LIST.UPDATED[i].BUGT_BALANCE_AMT) + toNumber(params.ITEM_LIST.UPDATED[i].REQUEST_AMT) < 0){
			alert("신청액이 부족합니다.");
			return false;
		}
	}

	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ACCOUNT_NO", "REQUEST_AMT"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
	    	 saveCall(gridView, '/com/bdg/saveOpSupplement', null, params);
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
	
	if(isEmpty(params.ITEM_LIST)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
		if(params.ITEM_LIST.DELETED[i].STATUS != '1'){
			alert("저장 상태만 삭제 가능합니다.");
			return false;
		}
	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delOpSupplement', 'fnDel', params);
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
	} else {
		fnSearch();
	}
}

//당월기본예산, 배정실행예산, 현재실적, 실행잔액 세팅
function fnSetAmtSuccess(data) {
	if(isNotEmpty(data.rows) == true){
		gridView.setRowValue(gridView.getCurrent().itemIndex, "BUGT_BASIC_AMT", data.rows[0].BUGT_BASIC_AMT);
		gridView.setRowValue(gridView.getCurrent().itemIndex, "BUGT_EXEC_AMT", data.rows[0].BUGT_EXEC_AMT);
		gridView.setRowValue(gridView.getCurrent().itemIndex, "BUGT_RESULT_AMT", data.rows[0].BUGT_RESULT_AMT);
		gridView.setRowValue(gridView.getCurrent().itemIndex, "BUGT_BALANCE_AMT", data.rows[0].BUGT_BALANCE_AMT);
		
// 		var values = { 
// 			 "BUGT_BASIC_AMT" : data.rows[0].BUGT_BASIC_AMT
// 	        ,"BUGT_EXEC_AMT" : data.rows[0].BUGT_EXEC_AMT
// 	        ,"BUGT_RESULT_AMT" : data.rows[0].BUGT_RESULT_AMT
// 	        ,"BUGT_BALANCE_AMT" : data.rows[0].BUGT_BALANCE_AMT
// 	        };
// 		fnAddRow(gridView, values, gridView.getRowCount());	
	}
	
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}


/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
}

/**
 * 코스트 조회
 */
function fnSearchCctr() {
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
	var values = {
	         "CCTR_CD"  : rows.CCTR_CD
	        ,"CCTR_NM"  : rows.CCTR_NM
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);
		
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
                <col style="width:120px">
                <col style="width:430px">
                <col style="width:70px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();">
	                    </select>
                    </td>
                    <th><span>작성일자</span></th>
                    <td>
						<input type="text" class="datepicker" id="TB_CRTN_YMD"  value="" style="width:90px;" onchange="fnCheckDate()"/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <th><span>상태</span></th>
                    <td>
	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" onchange="fnSearch();">
	                    </select>
	                     <input type="hidden" id="TB_ACCOUNT_NO"/>
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
        <button type="button" class="btn" id="btnConfirm">확정</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>