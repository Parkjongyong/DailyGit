<%--
	File Name : bdgDeptSampleMgt.jsp
	Description: 예산 > 영업관리 > 부서견본신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.14  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.09.14
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var gridDetail;

var rowIndex     = -1;
var d3Cnt        = 0;

var statusCodes  = new Array();
var statusLabels = new Array();

var orderTypeCodes  = new Array();
var orderTypeLabels = new Array();

var accountList  = new Array();
var deptList     = new Array();

var userPopGubn  = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	var statusList = stringToArray("${CODELIST_YS024}");
	deptList   = stringToArray("${CODELIST_USRDPT}");
	accountList = stringToArray("${CODELIST_YS025}");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_STATUS'     , statusList,   'CODE', 'CODE_NM', null, "","전체");
	//fnMakeComboOption('SB_ORG_CD'     , deptList,     'CODE', 'CODE_NM');

	statusCodes  = getComboSet('${CODELIST_YS024}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS024}', 'CODE_NM');
	
	orderTypeCodes  = getComboSet('${CODELIST_YS025}', 'CODE');
	orderTypeLabels = getComboSet('${CODELIST_YS025}', 'CODE_NM');
	
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
	$("#TB_CRTN_YMD").val(getDiffDay("y",0));
	$("#TB_TODAY").val(getDiffDay("y",0).replace('-', '').replace('-', ''));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	
	fnCompCdChange();
	
}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
	var deptList   = stringToArray("${CODELIST_USRDPT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_ORG_CD', deptList, 'CODE', 'CODE_NM');
}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text:'진행상태'},      80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable:false},'dropDown');
    addField(cm,    'SD_SEND_NO',           {text:'주문번호'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'ORDER_TYPE',           {text: '주문유형'},      150,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:orderTypeCodes,labels:orderTypeLabels},'dropDown');
    addField(cm,    'MAT_NUMBER',           {text:'품목코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'MAT_DESC',             {text:'품목명'},         200,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    
    addField(cm,    'CCTR_CD',              {text:'코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코스트센터명'},         100,            'text',           {textAlignment:"near"});
    addField(cm,    'CODEMAPPING4',         {text: ' '},             20,     'popupLink');
    addField(cm,    'REQ_SABUN',            {text: '사원코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'REQ_SABUN_NM',         {text: '사원명'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING2',         {text: ' '},          20,     'popupLink');    
    addField(cm,    'RELEASE_REQ_YMD',      {text:'출고요청일'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'DELIVERY_LOC_TXT',     {text:'납품처'},         150,            'text',           {textAlignment:"near"});
    addField(cm,    'CODEMAPPING3',         {text: ' '},          20,     'popupLink');    
    addField(cm,    'REQUEST_QTY',          {text: '수량'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'SAMPLE_AMT',           {text: '견본가'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REQUEST_AMT',          {text: '금액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'JAEGO_QTY',            {text: '품목재고'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'TOTAL_AMT',            {text: '예산금액'},        100,            'integer',           {textAlignment:"far"});
    

    
    
    
    

    
    addField(cm,    'REMARK',               {text:'비고'},         300,            'text',           {textAlignment:"near"});
    
    
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'DEPT_CD',              {text: '사원부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'DELIVERY_LOC',         {text: '납품처코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BUGT_AMT',             {text: '예산금액'},        100,            'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'RESULT_AMT',           {text: '실적금액'},        100,            'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'ACCOUNT_NO',           {text: '계정코드'},        100,            'text', {textAlignment: "center"},{visible:false});
    //addField(cm,    'CCTR_CD',              {text: '코스트센터'},        100,            'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PLANT_CD',             {text: '플랜트'},        100,            'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'REQ_YN',               {text: '주문가능여부'},        100,            'text', {textAlignment: "center"},{visible:false});
    

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
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
        var gubn   = values.STATUS;
        if (gubn == '1' || gubn == '3') {
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
    var columnDateStyles = function(grid, index, value) {
        var styles = {};
        
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.DATA_GUBN;
        var status = values.STATUS;
        if (status == '1' || status == '3') {
        	styles.editable = true;
        	styles.border = "#88888888,1";
        	styles.background = "#d5e2f2";
        	styles.borderBottom = "#ff999999,1";
        	styles.borderRight = "#ff999999,1";
        	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"};
        } else {
        	styles = disibleColStyle;
        }
        return styles;
    };      

    // 고정스타일
    gridView.setColumnProperty("STATUS"           , "dynamicStyles", columnDefaultStyles);  
    gridView.setColumnProperty("SD_SEND_NO"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("MAT_NUMBER"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("MAT_DESC"         , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("SAMPLE_AMT"       , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REQUEST_AMT"      , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("JAEGO_QTY"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BUGT_AMT"         , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REQ_SABUN"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REQ_SABUN_NM"     , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("TOTAL_AMT"        , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("DELIVERY_LOC_TXT" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("REMARK"           , "dynamicStyles", columnDefaultStyles);
    
    //가변스타일
    gridView.setColumnProperty("REQUEST_QTY"     , "dynamicStyles", columnDynamicStyles);
    gridView.setColumnProperty("RELEASE_REQ_YMD" , "dynamicStyles", columnDateStyles);
    gridView.setColumnProperty("ORDER_TYPE"      , "dynamicStyles", columnDynamicStyles);
    
    gridView.onDataCellClicked = function (grid, data) {
    	// 품목정보
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	var orderType = grid.getCurrentRow().ORDER_TYPE;
        	
        	if (isEmpty(orderType)) {
    			alert("주문유형 선택 후 작업하세요.");
    			return false;		
        	} else {
        		fnSearchMat();	
        	}
        	
        }

    	// 사원정보
        if (data.column == "CODEMAPPING2" && grid.getCurrentRow().STATUS == "1") {
        	fnSearchUser();
        }
    	
    	// 납품처
        if (data.column == "CODEMAPPING3" && grid.getCurrentRow().STATUS == "1") {
        	fnSearchCustomer();
        }
    	
    	// 코스트센터
        if (data.column == "CODEMAPPING4" && grid.getCurrentRow().STATUS == "1") {
        	fnSearchCctr();
        }     	
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    	
    	var values = grid.getValues(itemIndex);
    	var Qty    = values.REQUEST_QTY;
    	var price  = values.SAMPLE_AMT;
    	var orderType  = values.ORDER_TYPE;
    	var toDay  = $('#TB_TODAY').val();
    	var reqDay = values.RELEASE_REQ_YMD;
    	
    	if (toDay > reqDay) {
    		gridView.setValue(itemIndex, "RELEASE_REQ_YMD", "");
    	}
    	var accountNo = getComboValue(accountList, "ATTR01", getComboIndex(accountList, "CODE", orderType));
    	
    	// 금액 = 납품수량 * 단가 * PER
    	gridView.setValue(itemIndex, "REQUEST_AMT", Qty * price);
    	gridView.setValue(itemIndex, "ACCOUNT_NO", accountNo);
    	
    };
    
    gridView.onRowsPasted = function(grid, items){
    	for(var i = 0; i < items.length; i++){
        	var values = grid.getValues(items[i]);
        	var Qty    = values.REQUEST_QTY;
        	var price  = values.SAMPLE_AMT;
        	var orderType  = values.ORDER_TYPE;
        	var toDay  = $('#TB_TODAY').val();
        	var reqDay = values.RELEASE_REQ_YMD;
        	
        	if (toDay > reqDay) {
        		gridView.setValue(items[i], "RELEASE_REQ_YMD", "");
        	}        	
        	var accountNo = getComboValue(accountList, "ATTR01", getComboIndex(accountList, "CODE", orderType));
        	
        	// 금액 = 납품수량 * 단가 * PER
        	gridView.setValue(items[i], "REQUEST_AMT", Qty * price);
        	gridView.setValue(items[i], "ACCOUNT_NO", accountNo);
        	gridView.checkItem(items[i], true);
    	}
    	
    };
    
    // ACCOUNT_NO 콤보 변경 시 ACCOUNT_NM 값 셋팅
    gridView.onGetEditValue = function (grid, index, editResult) {
       
        if (index.fieldName === "ORDER_TYPE") {
        	gridView.setValue(index.itemIndex, "MAT_NUMBER", '');
        	gridView.setValue(index.itemIndex, "MAT_DESC", '');
        	gridView.setValue(index.itemIndex, "PLANT_CD", '');
        }        
    };      

    gridView.setOptions({sortMode:"explicit"});
    
}

/**
 * 사용자 조회 팝업
 */
function fnSearchUser() {
    var params = fnGetParams();
    params.SB_COMP_NM = $("#SB_COMP_CD option:selected").text();
    params.SB_COMP_CD = $("#SB_COMP_CD").val();
    var target = "userList";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 납품처 조회 팝업
 */
function fnSearchCustomer() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"COMP_CD" : "1100"});
	$.extend(params, {"DISTRIB_CD" : "99"});
	
    var target = "customerList";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/customerList', params, target, width, height, scrollbar, resizable);
}

/**
 * 코스트 조회
 */
function fnSearchCctr() {
	var params = {};
	$.extend(params, fnGetParams());
	var comp_gubn = "";
	// 일동제약인 경우와 일동제약이 아닌경우로 구분해서 코스트센터 조회 분리
	if ($('#SB_COMP_CD').val() == "1100") {
		comp_gubn = "A";
	} else {
		comp_gubn = "B";
	}
	$.extend(params, {"COMP_GUBN" : comp_gubn});
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
function fnCallbackDeptSamplePop(rows) {
	gridView.setRowValue(gridView.getCurrent().itemIndex, "CCTR_CD", rows.CCTR_CD);
	gridView.setRowValue(gridView.getCurrent().itemIndex, "CCTR_NM", rows.CCTR_NM);
}



/**
 * 사용자 조회 팝업 콜백
 */
function fnCallbackPop(rows) {
	
	var values = {
	         "REQ_SABUN"    : rows.USER_ID
	       , "REQ_SABUN_NM" : rows.USER_NM
	       , "DEPT_CD"      : rows.DEPT_CD
	     };
	gridView.setValues(gridView.getCurrent().itemIndex, values);
	
	var params = {};
	$.extend(params, {"COMP_CD" : gridView.getRowValue(gridView.getCurrent().itemIndex, "COMP_CD")});
	//$.extend(params, {"ORG_CD"  : gridView.getRowValue(gridView.getCurrent().itemIndex, "DEPT_CD")});
	$.extend(params, {"ORG_CD"  : rows.DEPT_CD});
	
	searchCall(gridView, '/com/bdg/selectDeptCustomerData', 'fnDeptCustomerData', params);

}


/**
 * 조회 후 처리
 */
function fnDeptCustomerDataSuccess(data) {
	
	if (isNotEmpty(data.fields)) {
		if (isNotEmpty(data.fields.CUST_CD) && isNotEmpty(data.fields.CUST_NM)) {
			var values = {
			         "DELIVERY_LOC"     : data.fields.CUST_CD
			       , "DELIVERY_LOC_TXT" : data.fields.CUST_NM
			     };
			gridView.setValues(gridView.getCurrent().itemIndex, values);
		}		
	}
}


/**
 * 납품업체 조회 팝업 콜백
 */
function fnCallbackCustomerSearchPop(rows) {
	
	var values = {
	         "DELIVERY_LOC"     : rows.CUST_CD
	       , "DELIVERY_LOC_TXT" : rows.CUST_NAME1
	     };
	gridView.setValues(gridView.getCurrent().itemIndex, values);

}


/**
 * 품목 조회 팝업
 */
function fnSearchMat() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN" : gridView.getRowValue(gridView.getCurrent().itemIndex, 'ORDER_TYPE')});
    var target    = "matList";
	var width     = "900";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/bdg/bdgMatSearchPop', params, target, width, height, scrollbar, resizable);
}

/**
 * 품목 조회 팝업 콜백
 */
function fnCallbackMatSearchPop(rows) {
	
	var values = {
	         "MAT_NUMBER" : rows.MAT_NUMBER
	       , "MAT_DESC"   : rows.MAT_DESC
	       , "PLANT_CD"   : rows.PLANT_CODE
	     };
    		
	gridView.setValues(gridView.getCurrent().itemIndex, values);

}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectDeptSampleMgtList');
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
	var checkedRows = gridView.getCheckedItems();
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		var requestAmt = toNumber(temp.REQUEST_AMT);
		var bugtAmt = toNumber(temp.TOTAL_AMT);
		
// 		if (temp.REQ_YN == "Y") {
// 			alert("견본주문가능한 품목이 아닙니다. 확인 후 작업하세요.");
// 			return false;				
// 		}
		
		if (bugtAmt == 0) {
			alert("예산금액이 0원 입니다. 확인 후 작업하세요.");
			return false;
		}		

		if (requestAmt > bugtAmt) {
			alert("요청금액이 예산금액보다 큽니다.");
			return false;
		}
		if (temp.STATUS == '1' || temp.STATUS == '3') {
			continue;
		} else {
			alert("[작성중/반려] 상태에서만 저장가능합니다.");
			return false;				
		}
	}
	
	// 필수 체크 대상(그리드)
	//var requiredVal   = ["MAT_NUMBER", "REQ_SABUN", "REQUEST_QTY", "RELEASE_REQ_YMD", "ORDER_TYPE", "DELIVERY_LOC"];
	var requiredVal   = ["CCTR_CD", "MAT_NUMBER", "MAT_DESC", "PLANT_CD", "REQ_SABUN", "REQUEST_QTY", "RELEASE_REQ_YMD", "ORDER_TYPE"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?")){
			
			var params = {};
			$.extend(params, fnGetParams());
			$.extend(params, {"GUBN"      : "SA"});
			$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
			
			saveCall(gridView, '/com/bdg/saveDeptSampleMgt', 'fnSave', params);
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
	var checkedRows = gridView.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		if (temp.STATUS == '1' || temp.STATUS == '3') {
			continue;
		} else {
			alert("[작성중/반려] 상태에서만 삭제가능합니다.");
			return false;				
		}
	}	
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "DE"});
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/deleteDeptSampleMgt', 'fnDelete', params);
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
	
	if($("#SB_ORG_CD").val() == null || $("#SB_ORG_CD").val() == ""){
		alert("부서는 필수입니다.");
		return false;
	}
	
	if($("#TB_CRTN_YMD").val() == null || $("#TB_CRTN_YMD").val() == ""){
		alert("작성일자는 필수입니다.");
		return false;
	}
	
	var cctrCd = "";
	var cctrNm = "";
	
	// 일동제약은 행추가시 코스트 센터를 자동 셋팅
	if ($('#SB_COMP_CD').val() == "1100") {
		cctrCd = getComboValue(deptList, 'CCTR_CD', getComboIndex(deptList, 'CODE', $('#SB_ORG_CD').val()));
		cctrNm = getComboValue(deptList, 'CCTR_NM', getComboIndex(deptList, 'CODE', $('#SB_ORG_CD').val()));
	}
	
	var values = { "CRUD" : "I" 
			      ,"STATUS" : "1"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YMD" : $('#TB_CRTN_YMD').val().replace('-', '').replace('-', '')
			      ,"ORG_CD" : $('#SB_ORG_CD').val()
			      ,"CODEMAPPING1" : "1"
			      ,"CODEMAPPING2" : "1"
			      ,"CODEMAPPING3" : "1"
			      ,"CODEMAPPING4" : "1"
			      ,"CCTR_CD" : cctrCd
			      ,"CCTR_NM" : cctrNm
			      //,"ACCOUNT_NO" : accountList[0].CODE
			      // 테스트 용도
			      //,"SAMPLE_AMT" : 200
			      //,"JAEGO_QTY" : 50
			      //,"BUGT_AMT" : 20000
			      
	};
	
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}


//승인요청
var fnAppr = function(){
	gridView.commit();
	if(gridView.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	var checkedRows = gridView.getCheckedItems(false);
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		var requestAmt = toNumber(temp.REQUEST_AMT);
		var bugtAmt = toNumber(temp.TOTAL_AMT);
		
// 		if (temp.REQ_YN == "Y") {
// 			alert("견본주문가능한 품목이 아닙니다. 확인 후 작업하세요.");
// 			return false;				
// 		}
		
		if (bugtAmt == 0) {
			alert("예산금액이 0원 입니다. 확인 후 작업하세요.");
			return false;
		}		

		if (requestAmt > bugtAmt) {
			alert("요청금액이 예산금액보다 큽니다.");
			return false;
		}		
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만 승인요청가능합니다.");
			return false;				
		}
	}


	// 필수 체크 대상(그리드)
	var requiredVal   = ["MAT_NUMBER", "REQ_SABUN", "REQUEST_QTY", "RELEASE_REQ_YMD", "ORDER_TYPE", "DELIVERY_LOC"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("승인요청 하시겠습니까?")){
			
			var params = {};
			$.extend(params, fnGetParams());
			$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_012"}); // 양식키
			$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
			$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
			$.extend(params, {"MANAGER_YN"    : "N"}); // 본부장표시여부
			$.extend(params, {"REVIEW_ORG_CD" : ""}); // 처리부서코드
			
			if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
				$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgDeptSampleMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG146" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&SB_ORG_CD=" + $('#SB_ORG_CD').val() + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
				$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgDeptSampleMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG146"}); // 처리로직  url
			} else {
				$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgDeptSampleMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG146" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&SB_ORG_CD=" + $('#SB_ORG_CD').val() + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
				$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgDeptSampleMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG146"}); // 처리로직  url
			}
			
			$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
			$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
			
			$.extend(params, {"GUBN"      : "AR"});
			$.extend(params, {"STATUS"    : "2"});
			$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
			
			saveCall(gridView, '/com/bdg/apprDeptSampleMgt', 'fnAppr', params);
		}

	}	
}

function fnApprSuccess(data) {
	
	//alert("승인요청 되었습니다.");
	gridView.clearRows();
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key"          : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : data.fields.result.EPS_FORM_ID}); //양식key
	 	$.extend(params, {"empno"        : data.fields.result.SABUN}); // 기안자
	 	$.extend(params, {"deptcd"       : data.fields.result.ORG_CD}); //기안자 부서코드
	 	$.extend(params, {"geMangerYn"   : 'N'}); //본부장 표시여부
	 	$.extend(params, {"reqDeptcd"    : ''}); //처리부서코드
	 	$.extend(params, {"systemUrl"    : data.fields.result.BGT_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //popup_url
	 	$.extend(params, {"businessUrl"  : data.fields.result.BGT_BUS_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //business_url
	 	$.extend(params, {"systemName"   : '전사시스템'}); //시스템이름
	 	$.extend(params, {"subject"      : ''}); //제목
	 	$.extend(params, {"status"       : '2'}); //상태코드
	 	
// 	 	var htmlTag = "<!DOCTYPE html>";
// 	 	htmlTag += "<html lang='ko'>";
// 	 	htmlTag += "<head>";
// 	 	htmlTag += "<meta charset='UTF-8'>";
// 	 	htmlTag += "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>";
// 	 	htmlTag += "<style>";
// 	 	htmlTag += ".tit-area{overflow:hidden;position:relative;padding:18px 0 13px;}";
// 	 	htmlTag += ".tbl-view{width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;}";
// 	 	htmlTag += ".tbl-view tbody th{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;background-color:#f1f2f6;text-align:left;}";
// 	 	htmlTag += ".tbl-view tbody td{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;}";
// 	 	htmlTag += "</style>";
// 	 	htmlTag += "</head>";
	 	
// 	 	htmlTag += "<body>";
// 	 	htmlTag += "<div class='tit-area' style='padding:15px;'>";
// 	 	htmlTag += "<div>";
// 	 	htmlTag += "<h3>부서견본신청</h3>";
// 	 	htmlTag += "</div>";
// 	    htmlTag += "<div class='tbl-search-wrap'>";
// 	    htmlTag += "<div class='tbl-search-area'>";
// 	    htmlTag += "<table class='tbl-search'>";
// 	    htmlTag += "<colgroup>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";	    
// 	    htmlTag += "<col>";
// 	    htmlTag += "</colgroup>";
// 	    htmlTag += "<tbody>";
// 	    htmlTag += "<tr>";
// 	    htmlTag += "<th><span>회사</span></th>";
// 	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
// 	    htmlTag += "<th><span>작성일</span></th>";
// 	    htmlTag += "<td>" + $('#TB_CRTN_YMD').val() + "</td>";
// 	    htmlTag += "<th><span>부서</span></th>";
// 	    htmlTag += "<td>" + $("#SB_ORG_CD option:selected").text() + "</td>";
// 	    htmlTag += "<td></td>";
// 	    htmlTag += "</tr>";
// 	    htmlTag += "</tbody>";
// 	    htmlTag += "</table>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "<div class='pop-cont'>";
// 	    htmlTag += "<div class='pop-cont'>";
// 	    htmlTag += "<table class='tbl-view'>";
// 	    htmlTag += "<colgroup>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:150px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "</colgroup>";
// 	    htmlTag += "<tbody>";
// 	    htmlTag += "<tr>";
// 	    htmlTag += "<th style='text-align:center'>계정코드</th>";
// 	    htmlTag += "<th style='text-align:center'>계정명</th>";
// 	    htmlTag += "<th style='text-align:center'>당기기본예산</th>";
// 	    htmlTag += "<th style='text-align:center'>산정추정</th>";
// 	    htmlTag += "<th style='text-align:center'>예산추정</th>";
// 	    htmlTag += "<th style='text-align:center'>집행율</th>";
// 	    htmlTag += "<th style='text-align:center'>합계</th>";
// 	    htmlTag += "<th style='text-align:center'>예산증감율</th>";
// 	    htmlTag += "<th style='text-align:center'>산정증감율</th>";
// 	    htmlTag += "<th style='text-align:center'>예상증감율</th>";
// 	    htmlTag += "</tr>";
	    
// 	    for (var i=0 ; i < gridView.getRowCount(); i++) {
// 	    	htmlTag += "<tr>";
// 	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_NO") + "</td>";
// 	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_DESC") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "A_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "B_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "PRESUME_AMT") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "D_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "C_SUM") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "A_RATE") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "B_RATE") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "C_RATE") + "</td>";
// 	    	htmlTag += "</tr>";
// 	    }
	    
// 	    htmlTag += "</tbody>";
// 	    htmlTag += "</table>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "</body>";
// 	    htmlTag += "</html>";
	    
// 	    $.extend(params, {"HTMLBody" : htmlTag}); //본문 데이터

		var target    = "goFormLink";
		var width     = "1200";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	    //fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
	    if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
			fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		} else {
			fnPostPopup('https://eps.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		}
	}
	
	fnSearch();
}


function fnApprFail(result) {
	alert(result.errMsg);
}

// 견본가수신
var fnReception = function(){
	gridView.commit();
	var checkedRows = gridView.getCheckedItems();
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만견본가수신가능합니다.");
			return false;				
		}
	}	
	
	// 필수 체크 대상(그리드)
	//var requiredVal   = ["MAT_NUMBER", "REQ_SABUN", "REQUEST_QTY", "RELEASE_REQ_YMD", "ORDER_TYPE", "DELIVERY_LOC"];
	var requiredVal   = ["MAT_NUMBER", "REQ_SABUN", "REQUEST_QTY", "RELEASE_REQ_YMD", "ORDER_TYPE"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("견본가수신 하시겠습니까?")){
			
			var params = {};
			$.extend(params, fnGetParams());
			
			$.extend(params, {"TB_CRTN_YMD" : $('#TB_CRTN_YMD').val().replace("-", "").replace("-", "")});
			$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
			
			saveCall(gridView, '/com/bdg/receptionDeptSampleMgt', 'fnReception', params);
		}
	}
}

/**
 * 저장 성공
 */
function fnReceptionSuccess(data) {
	alert("견본가수신되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    
	if(isNotEmpty(data.fields.result) == true){
		// 필수 체크
		for(var i = 0; i < data.fields.result.length; i++){
			var tempObj = data.fields.result[i];
			gridView.setRowValue(tempObj.itemIndex, "SAMPLE_AMT" , tempObj.SAMPLE_AMT);
			gridView.setRowValue(tempObj.itemIndex, "JAEGO_QTY"  , tempObj.JAEGO_QTY);
			gridView.setRowValue(tempObj.itemIndex, "BUGT_AMT"   , tempObj.BUGT_AMT);
			gridView.setRowValue(tempObj.itemIndex, "RESULT_AMT" , tempObj.RESULT_AMT);
			gridView.setRowValue(tempObj.itemIndex, "REQUEST_AMT", toNumber(tempObj.REQUEST_QTY) * toNumber(tempObj.SAMPLE_AMT));
			gridView.setRowValue(tempObj.itemIndex, "TOTAL_AMT"  , toNumber(tempObj.BUGT_AMT) - toNumber(tempObj.RESULT_AMT));
			gridView.setRowValue(tempObj.itemIndex, "REQ_YN"     , tempObj.REQ_YN);
			   
		}	
	} else {
		alert("견본가수신 정보가 존재하지 않습니다.");
		return false;
	}
}

/**
 * 저장 실패
 */
function fnReceptionFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

/**
 * 회사 코드 변경 이벤트
 */
function fnOrgCdChange() {
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled>
	                    </select>
                    </td>
                    <th><span>작성일</span></th>
                    <td>
                    	<input type="text" class="datepicker" id="TB_CRTN_YMD" dateHolder="bgn" value="" style="width:90px;"/>
                    	<input type="hidden" id="TB_TODAY">
                    </td>
                    <th><span>부서명</span></th>
                    <td>
	                    <select id="SB_ORG_CD" name="SB_ORG_CD" onchange="fnOrgCdChange();">
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
    	<button type="button" class="btn" id="btnReception">견본가수신</button>
    	<button type="button" class="btn" id="btnAppr">승인요청</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
