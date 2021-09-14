<%--
	File Name : bdgPromDetail.jsp
	Description:예산 > 영업관리 > 홍보디테일관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.31  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.31
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<style type="text/css">

#excelFile { display:none; } 

</style>

<script type="text/javascript">
var gridView;
var dataProvider;
var chcCtcCodes  = new Array();
var chcCtcLabels = new Array();
var distCodes    = new Array();
var distLabels   = new Array();

$(document).ready(function() {

	// 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var distList  = stringToArray("${CODELIST_YS008}");
	fnMakeComboOption('SB_DIST', distList,     'CODE', 'CODE_NM', null,"","전체");

	var etcGubnList  = stringToArray("${CODELIST_YS012}");
	fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList,     'CODE', 'CODE_NM', null);

	chcCtcCodes  = getComboSet('${CODELIST_YS012}', 'CODE');
	chcCtcLabels = getComboSet('${CODELIST_YS012}', 'CODE_NM');
	
	distCodes  = getComboSet('${CODELIST_YS008}', 'CODE');
	distLabels = getComboSet('${CODELIST_YS008}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_ORG_NM").val('${LOGIN_INFO.DEPT_NM}');
	$("#TB_ORG_CD").val('${LOGIN_INFO.DEPT_CD}');
	$("#SB_CHC_ETC_GBN").val('${LOGIN_INFO.ETC_CHC_GUBN}');
}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    var cm = [];
  
    addField(cm,    'REQ_ORG_CD',           {text:'부서코드'},        80,            'text',              {textAlignment:"center"});
    addField(cm,    'REQ_ORG_NM',           {text:'부서명'},  100,            'text',           {textAlignment:"near"});
    addField(cm,    'REQ_SABUN',            {text:'사원코드'},      100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},         15,     'popupLink');
    addField(cm,    'REQ_SABUN_NM',         {text:'사원명'},      60,            'text',           {textAlignment:"center"});
    addField(cm ,   'DISTRIB_CD',           {text:'유통'},      80,             'text',              {textAlignment: 'center'},  {lookupDisplay: true,values:distCodes, labels:distLabels}, 'dropDown');

    
    addField(cm,    'FORWARD_AMT',         {text:'이월금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'BAL_BUGT_AMT',        {text:'당월예산금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'ETC_BUGT_AMT',        {text:'기타금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'ETC_TOT_AMT',         {text:'기타누계금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'RESULT_AMT',          {text:'실적'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'TOT_BUDGET',          {text:'예산누계'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'BAL_BUDGET',          {text:'예산잔액'},        100,            'number',           {textAlignment:"far"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'CHC_ETC_GBN',          {text:'부문'},       60,            'text',              {textAlignment:"center"},{lookupDisplay: true,values:chcCtcCodes,labels:chcCtcLabels, editable: false ,visible:false},'dropDown');

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
 	
 	if (field == 8) {
 		var values       = grid.getValues(itemIndex);
 		var etcAmt       = toNumber(values.ETC_BUGT_AMT);
 		var etcTotAmt    = toNumber(values.ETC_TOT_AMT);
 		var newEtcTotAmt = etcAmt + etcTotAmt;
 		
 		gridView.setValue(itemIndex, "ETC_TOT_AMT", newEtcTotAmt);		
 	}

 };
 
 gridView.onDataCellClicked = function (grid, colIndex) {
 	var gridView = grid.getDataProvider();
    	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
    		fnSearchUser();
    	}

 };
 
 
 // 동적 스타일 적용
 var columnDynamicStyles1 = function(grid, index, value) {
     var styles = {};
     var values = grid.getValues(index.itemIndex);
     var gubn   = values.BAL_BUDGET;
     if (toNumber(gubn) > 0) {
         styles.editable = true;
         styles.background = "#d5e2f2";
     } else {
         styles.editable = false;
     }
     return styles;
 };
 
 // 동적 스타일 적용
 var columnDynamicStyles2 = function(grid, index, value) {
     var styles = {};
     styles.editable = true;
     styles.background = "#d5e2f2";
     return styles;
 };
 
 // 기본 스타일 적용
 var columnDefaultStyles = function(grid, index, value) {
     var styles = {};
     	styles.editable = false;
     return styles;
 };

    //setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
	gridView.setColumnProperty("ETC_BUGT_AMT"  , "dynamicStyles", columnDynamicStyles1);
	gridView.setColumnProperty("FORWARD_AMT"  , "dynamicStyles", columnDynamicStyles2);
	gridView.setColumnProperty("BAL_BUGT_AMT"  , "dynamicStyles", columnDynamicStyles2);
	gridView.setColumnProperty("DISTRIB_CD"  , "dynamicStyles", columnDynamicStyles2);    

	gridView.setColumnProperty("REQ_ORG_CD"  , "dynamicStyles", columnDefaultStyles);    
	gridView.setColumnProperty("REQ_ORG_NM"  , "dynamicStyles", columnDefaultStyles);    
	gridView.setColumnProperty("REQ_SABUN"  , "dynamicStyles", columnDefaultStyles);    
	gridView.setColumnProperty("REQ_SABUN_NM"  , "dynamicStyles", columnDefaultStyles);    
	gridView.setColumnProperty("ETC_TOT_AMT"  , "dynamicStyles", columnDefaultStyles);
	
	gridView.setOptions({sortMode:"explicit"});
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectPromDetail');
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
	var values = { 
				   "CRUD" : "I" 
	              ,"CHC_ETC_GBN" : $('#SB_CHC_ETC_GBN').val()
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replaceAll('-', '')
	              ,"ORG_CD" : $('#TB_ORG_CD').val()
	              ,"CODEMAPPING1" : "1"
	              ,"DISTRIB_CD" : "10"
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
	//$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
	
	if(gridView.getCheckedItems(false).length == 0){
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_ORG_CD", "REQ_SABUN"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/savePromDetail', null, params);
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
		deleteCall(gridView, '/com/bdg/delPromDetail', 'fnDel', params);
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
 * 부서 조회
 */
function fnSearchDept(str) {
	paramGubn = str;
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
 * 부서 콜백
 */
function fnCallbackDeptSearchPop(rows) {
	$("#TB_ORG_CD").val(rows.DEPT_CD);
	$("#TB_ORG_NM").val(rows.DEPT_NM);
}

/**
 * 사원 조회
 */
function fnSearchUser() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_NM" :  $("#SB_COMP_CD option:selected").text()});
	
	var target    = "cmnUserSearchPop";
	var width     = "1200";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 사원 콜백
 */
 function fnCallbackPop(rows) {
	var values = {
	         "REQ_SABUN"   : rows.USER_ID,
	         "REQ_SABUN_NM"   : rows.USER_NM,
	         "REQ_ORG_NM"   : rows.DEPT_NM,
	         "REQ_ORG_CD"   : rows.DEPT_CD,
	         "CCTR_CD"      : rows.CCTR_CD
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);

}

/**
 * 엑셀
 */
 function fnExcel() {
		var params = {};
		$.extend(params, fnGetParams());
		
		if(isEmpty(params.SB_COMP_CD) == true){
			alert("회사코드는 필수입니다.");
			return false;
		}
		
		if(isEmpty(params.TB_CRTN_YYMM) == true){
			alert("년월은 필수입니다.");
			return false;
		}
		
		if(isEmpty(params.TB_ORG_CD) == true){
			alert("부서는 필수입니다.");
			return false;
		}
		
		if(isEmpty(params.SB_CHC_ETC_GBN) == true){
			alert("부문은 필수입니다.");
			return false;
		}
		
		if(isEmpty(params.SB_DIST) == true){
			alert("유통은 필수입니다.");
			return false;
		}		
		
		var target    = "bdgPromDetailExcel";
		var width     = "1500";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	 	fnPostPopup('/com/bdg/bdgPromDetailExcel', params, target, width, height, scrollbar, resizable);

}

/**
 * 엑셀
 */
 function fnExcelUpload() {
	 $('#excelFile').click();
}


//실적수신
 function fnSend() {
	
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());	
	
	if(gridView.getCheckedItems(false).length == 0 ) {
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
	 
	if(confirm("실적수신 하시겠습니까?")){
		saveCall(gridView, '/com/bdg/receptionPromDetail', 'fnSend', params);
	}
	
}
 
function fnSendSuccess(data) {
	alert("실적수신 되었습니다.");
	fnSearch();
}

function fnSendFail(result) {
	alert("실적수신 실패 하였습니다.");
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
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:74px;"/>
                    </td>
                    <th><span>부서</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" disabled>
                        <input type="hidden" id="TB_ORG_CD">
<!--                         <a href="javascript:fnSearchDept('condition');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" disabled>
	                    </select>
                    </td>
                    <th><span>유통</span></th>
                    <td>
                        <select id="SB_DIST" name="SB_DIST">
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
<!--         <button type="button" class="btn" id="btnExcelUpload">엑셀업로드</button> -->
        <button type="button" class="btn" id="btnExcel">EXCEL</button>
        <button type="button" class="btn" id="btnSend">실적수신</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>