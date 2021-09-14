<%--
	File Name : bdgApmTransMgt.jsp
	Description: 예산 > 영업관리 > APM예산이관신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.28  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.28
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var gridDetail;
var apprCodes  = new Array();
var apprLabels = new Array();

var accountNo    = "";
var accountDesc  = "";
var remark       = "";
var rowIndex     = -1;
var d3Cnt        = 0;
var addCnt       = 0;

var statusCodes  = new Array();
var statusLabels = new Array();

var gubnCodes  = new Array();
var gubnLabels = new Array();

var useYnCodes  = new Array();
var useYnLabels = new Array();

var userPopGubn  = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	var gubnList   = stringToArray("${CODELIST_YS012}");
	var statusList = stringToArray("${CODELIST_YS011}");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_CHC_ETC_GBN', gubnList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_STATUS'     , statusList,     'CODE', 'CODE_NM', null, "","전체");

	statusCodes  = getComboSet('${CODELIST_YS011}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS011}', 'CODE_NM');
	
	gubnCodes  = getComboSet('${CODELIST_YS012}', 'CODE');
	gubnLabels = getComboSet('${CODELIST_YS012}', 'CODE_NM');	
	
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');		

	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	
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

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '진행상태'},      80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable:false},'dropDown');
    addField(cm,    'CHC_ETC_GBN',          {text: '부문'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:gubnCodes,labels:gubnLabels, editable:false},'dropDown');
    addField(cm,    'SEND_ORG_CD',          {text:'부서코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'SEND_ORG_NM',          {text:'부서명'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'SEND_SABUN',           {text:'사원코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'SEND_SABUN_NM',        {text:'사원명'},         100,            'textLink',           {textAlignment:"center"});
    
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    
    addField(cm,    'BAL_AMT',              {text:'당월잔액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'CANCEL_REASON',        {text:'취소사유'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_CCTR_CD',         {text: '이관코스트센터'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridHeader.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 250       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };

    gridHeader.setColumnProperty("STATUS"       , "dynamicStyles", columnDefaultStyles);    
    gridHeader.setColumnProperty("CHC_ETC_GBN"  , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_ORG_CD"  , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_ORG_NM"  , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_SABUN"   , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_SABUN_NM", "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("BAL_AMT"      , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("CANCEL_REASON", "dynamicStyles", columnDefaultStyles);
    
    
    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
        if (data.column == "SEND_SABUN_NM") {
        	rowIndex = data.itemIndex;
        	//구별되기 위해 체크박스 체크
        	gridHeader.checkItem(data.itemIndex, true);
        	// 상세조회
        	fnSearchDetail();
        }
        
    	// 사원정보
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchUser('header');
        }        
    };

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    };
    
    gridHeader.setOptions({sortMode:"explicit"});
}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm ,   'RETURN_YN',           {text:'사내입금'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    addField(cm,    'CHC_ETC_GBN',          {text: '부문'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:gubnCodes,labels:gubnLabels, editable:false},'dropDown');
    addField(cm,    'RECV_ORG_CD',          {text:'부서코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'RECV_ORG_NM',          {text:'부서명'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'RECV_SABUN',           {text:'사원코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'RECV_SABUN_NM',        {text:'사원명'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    
    addField(cm,    'RECV_BAL_AMT',         {text:'수신금액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'RECV_DATE',            {text:'이관기준일'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'RECV_CCTR_CD',         {text: '코스트센터'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_SABUN',           {text: '이관사번'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_NO',              {text: '이관번호'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 200       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
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
        if (gubn == '1' || gubn == '4' || gubn == '6') {
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
    
    gridDetail.setColumnProperty("RECV_BAL_AMT" , "dynamicStyles", columnDynamicStyles);
    
    gridDetail.setColumnProperty("CHC_ETC_GBN"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_ORG_CD"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_ORG_NM"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_SABUN"   , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_SABUN_NM", "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_DATE"    , "dynamicStyles", columnDefaultStyles); 
    

    gridDetail.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	var curr = grid.getCurrent();
    	var values = grid.getValues(curr.itemIndex);
        var editable = false;
        if (newRow === -1 && curr.itemIndex > -1) {
            editable = true;
        } else if (newRow === -1 && curr.itemIndex === -1) {
            editable = false;
        } else {
            if (grid.getRowState(curr.itemIndex) === "created") {
                editable = true;
            }
        }
        
    };
    
    gridDetail.onDataCellClicked = function (grid, data) {
        
        if (data.fieldName == "CODEMAPPING1") {
        	fnSearchUser('detail');
        }
    };
    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
    	
    	if (field == 0 && newValue == "Y") {
    		gridDetail.setRowValue(dataRow, "RECV_ORG_CD", "");
    		gridDetail.setRowValue(dataRow, "RECV_ORG_NM", "");
    		gridDetail.setRowValue(dataRow, "RECV_SABUN", "");
    		gridDetail.setRowValue(dataRow, "RECV_SABUN_NM", "");
    		gridDetail.setRowValue(dataRow, "RECV_CCTR_CD", "");
    	}    	
    };
    
    gridDetail.setOptions({sortMode:"explicit"});
}

/**
 * 부서 조회
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
 * 부서 콜백
 */
function fnCallbackDeptSearchPop(rows) {
	var values = {
	         "TB_ORG_CD"  : rows.DEPT_CD 
	        ,"TB_ORG_NM"  : rows.DEPT_NM
	     };

	gridDetail.setValues(gridDetail.getCurrent().itemIndex, values);

}

/**
 * 사용자 조회 팝업
 */
function fnSearchUser(gubn) {
    var params = fnGetParams();
    userPopGubn = gubn;
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
 * 사용자 조회 팝업 콜백
 */
function fnCallbackPop(rows) {
	
	if (userPopGubn == "header") {
		var values = {
		         "SEND_SABUN"    : rows.USER_ID
		       , "SEND_SABUN_NM" : rows.USER_NM
		       , "SEND_ORG_CD"   : rows.DEPT_CD
		       , "SEND_ORG_NM"   : rows.DEPT_NM
		       , "SEND_CCTR_CD"  : rows.COST_CD
		     };
		gridHeader.setValues(gridHeader.getCurrent().itemIndex, values);
		
		//당월잔액
		fnSearchBalAmt(gridHeader.getCurrent().itemIndex);
	} else {
		var values = {
		             "RECV_SABUN"    : rows.USER_ID
			       , "RECV_SABUN_NM" : rows.USER_NM
			       , "RECV_ORG_CD"   : rows.DEPT_CD
			       , "RECV_ORG_NM"   : rows.DEPT_NM
			       , "RECV_CCTR_CD"  : rows.COST_CD
		     };
		gridDetail.setValues(gridDetail.getCurrent().itemIndex, values);		
	}

}

/**
 * 조회
 */
function fnSearchBalAmt(rIndex) {
	
	var params = {};
	$.extend(params, gridHeader.getValues(rIndex));
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectApmTransBalAmt', 'fnSearchBalAmt', params);
}

/**
 * 조회 후 처리
 */
function fnSearchBalAmtSuccess(data) {
	if(isNotEmpty(data.fields.result) == true){
		if(isNotEmpty(data.fields.result.ZCURBAL)){
			if(data.fields.result.ZCURBAL == "0" || toNumber(data.fields.result.ZCURBAL) == 0){
				alert("당월잔액이 존재하지 않습니다. 확인 후 작업하세요.");
				gridHeader.setValue(gridHeader.getCurrent().itemIndex, "BAL_AMT",   null);
				return false;
			} else {
				gridHeader.setValue(gridHeader.getCurrent().itemIndex, "BAL_AMT",   data.fields.result.ZCURBAL);
			}
		} else {
			alert("당월잔액이 존재하지 않습니다. 확인 후 작업하세요.");
			gridHeader.setValue(gridHeader.getCurrent().itemIndex, "BAL_AMT",   null);
			return false;
		}
	} else {
		alert("당월잔액이 존재하지 않습니다. 확인 후 작업하세요.");
		gridHeader.setValue(gridHeader.getCurrent().itemIndex, "BAL_AMT",   null);
		return false;
	}
}

/**
 * 조회 후 처리
 */
function fnSearchBalAmtFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}


/**
 * 조회
 */
function fnSearch() {
	//초기화
	rowIndex = -1;
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectApmTransMgtHeadList');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	addCnt = 0;
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
	    // 상태바 비활성화
	    gridHeader.closeProgress();	
	    
	    // 상세 조회
	    fnSearchDetail();	    
	} else {
		gridDetail.clearRows();
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridHeader.clearRows();
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
	    // 상태바 비활성화
	    gridHeader.closeProgress();
	}

}


/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
}



//저장
var fnSave = function(){
	gridDetail.commit();
	gridHeader.commit();
	var checkedRows = gridHeader.getCheckedItems();
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridHeader.getValues(checkedRows[i]);
		
		if (isEmpty(temp.BAL_AMT)) {
			alert("당월잔액이 존재하지 않습니다. 확인 후 작업하세요.");
			return false;				
		}		
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만 저장가능합니다.");
			return false;				
		}

	}
	
	// 필수 체크
	for(var i = 0; i < gridDetail.getRowCount(); i++){
		var temp = gridDetail.getValues(i);
		
		if (temp.RETURN_YN == "N") {
			if (isEmpty(temp.RECV_SABUN)) {
				alert("수신자 사번은 필수 입니다. 확인 후 작업하세요.");
				return false;				
			}
		}
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CHC_ETC_GBN", "SEND_ORG_CD", "SEND_SABUN", "COMP_CD", "CRTN_YYMM", "ORG_CD", "SEND_CCTR_CD"];
	var requiredVal2  = ["CHC_ETC_GBN", "RECV_BAL_AMT", "COMP_CD", "CRTN_YYMM"];
	
	var headTotalAmt = toNumber(gridHeader.getRowValue(gridHeader.getCurrent().itemIndex, "BAL_AMT"));
	var detailTotalAmt = 0;
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridHeader, requiredVal, true) == true){
		if(fnSaveCheck(gridDetail, requiredVal2, false) == true){
			if(confirm("저장 하시겠습니까?")){
				
				// 이관수시자 데이터를 수집하기 디테일 그리드의  체크박스 전체 선택 처리
				for(var i = 0; i < gridDetail.getRowCount(); i++){
					gridDetail.checkItem(i, true);
					detailTotalAmt += toNumber(gridDetail.getRowValue(i, "RECV_BAL_AMT"));
				}
				
				if (detailTotalAmt > headTotalAmt) {
					alert("당월잔액보다 수신금액이 큽니다. 확인 후 작업하세요.");
					return false;
				}
				
				var params = {};
				$.extend(params, {"GUBN"        : "SA"});
				$.extend(params, fnGetParams());
				$.extend(params, {"HEAD_LIST"   : fnGetGridCheckData(gridHeader)});
				$.extend(params, {"DETAIL_LIST" : fnGetGridCheckData(gridDetail)});
				
				saveCall(gridHeader, '/com/bdg/saveApmTransMgt', 'fnSave', params);
			}
		}

	}
	
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridHeader.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridHeader.closeProgress();
}

//삭제
function fnDelete() {
	
	gridHeader.commit();
	var checkedRows = gridHeader.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridHeader.getValues(checkedRows[i]);
		
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중/반려] 상태에서만 삭제가능합니다.");
			return false;				
		}
	}	
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "DE"});
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridHeader)});
	
	if(fnDeleteCheck(gridHeader) == true){
		deleteCall(gridHeader, '/com/bdg/deleteApmTransMgt', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	gridHeader.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
}


/**
 * 실행예산상세
 */
function fnSearchDetail() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, gridHeader.getValues(rowIndex));
	searchCall(gridDetail, '/com/bdg/selectApmTransMgtDetailList', 'fnSearchDetail', params);
}

/**
 * 조회 후 처리
 */
function fnSearchDetailSuccess(data) {
	if(isEmpty(data.rows)){
		gridDetail.clearRows();
	}
	
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridDetail.clearRows();
	// 그리고 데이터 setting
    gridDetail.setPageRows(data);
    // 상태바 비활성화
    gridDetail.closeProgress();
    
}

//행추가
function fnRowAdd() {
	
	if (addCnt > 0) {
		alert("APM예산이관신청은 이관수신자 입력으로 인해 한 건씩만 등록이 가능합니다. 기등록 작업을 완료 후 추가하십시오.");
		return false;
	} else {
		addCnt = addCnt + 1;
	}	
	
	if($("#SB_CHC_ETC_GBN").val() == null || $("#SB_CHC_ETC_GBN").val() == ""){
		alert("부문는 필수입니다.");
		return false;
	}
	
	if($("#TB_ORG_CD").val() == null || $("#TB_ORG_CD").val() == ""){
		alert("부서는 필수입니다.");
		return false;
	}
	
	// 이관수시자 데이터를 수집하기 디테일 그리드의  체크박스 전체 선택 처리
	for(var i = 0; i < gridHeader.getRowCount(); i++){
		gridHeader.checkItem(i, false);
	}		
	
	var values = { "CRUD" : "I" 
			      ,"STATUS" : "1"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CHC_ETC_GBN" : $('#SB_CHC_ETC_GBN').val()
			      ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replace('-', '')
			      ,"ORG_CD" : $('#TB_ORG_CD').val()
			      ,"CODEMAPPING1" : "1"};
	
	fnAddRow(gridHeader, values, gridHeader.getRowCount());
	
	gridDetail.clearRows();
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridHeader);
}

//행추가
function fnDetailRowAdd() {

	if(rowIndex == -1){
		alert("이관송신자를 선택(클릭) 후 작업하세요.");
		return false;
	}
	
	var headInfo = gridHeader.getValues(rowIndex);
	
	var values = { "CRUD" : "I" 
			      ,"STATUS" : "1"
			      ,"COMP_CD" : headInfo.COMP_CD
			      ,"CHC_ETC_GBN" : headInfo.CHC_ETC_GBN
			      ,"CRTN_YYMM" : headInfo.CRTN_YYMM
			      ,"ORG_CD" : headInfo.ORG_CD
			      ,"SEND_SABUN" : headInfo.SEND_SABUN
			      ,"SEND_NO" : (gridDetail.getRowCount() + 1)
			      ,"RETURN_YN" : "N"
			      ,"CODEMAPPING1" : "1"};
	
	fnAddRow(gridDetail, values, gridDetail.getRowCount());
}

//행삭제
function fnDetailRowDel() {
	fnAddRowDelete(gridDetail);
}

//확정
var fnConfirm = function(){
	gridDetail.commit();
	gridHeader.commit();
	
	var checkedRows = gridHeader.getCheckedItems(false);
	
	var retCnt = 0;
	var detailTotalAmt = 0;
	
	if(checkedRows.length == 0){
		alert("확정할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridHeader.getValues(checkedRows[i]);
		
		if (temp.STATUS == '6') {
			retCnt++;
			if (retCnt > 1) {
				alert("[재작성요청]건은 한건씩 처리 가능합니다.");
				return false;		
			}
		} else if(temp.STATUS != '6' && temp.STATUS != '1'){
			alert("[작성중/재작성요청] 상태에서만 확정가능합니다.");
			return false;				
		}
	}
	

	
	var headTotalAmt = toNumber(gridHeader.getRowValue(gridHeader.getCurrent().itemIndex, "BAL_AMT"));
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"HEAD_LIST" : fnGetGridCheckData(gridHeader)});
	
    if(confirm("확정 하시겠습니까?")){
    	if (retCnt == 1) {
    		 
   			if (gridDetail.getRowCount() == 0) {
   				alert("재작성요청 시, 이관수신자 정보는 필수 입니다. 이관송신자[사원명]을 클릭 후 작업하세요.");
   			 	return false;		
   			}    		 
    		 
			// 이관수시자 데이터를 수집하기 디테일 그리드의  체크박스 전체 선택 처리
			for(var i = 0; i < gridDetail.getRowCount(); i++){
				gridDetail.checkItem(i, true);
				detailTotalAmt += toNumber(gridDetail.getRowValue(i, "RECV_BAL_AMT"));
			}
			
			if (detailTotalAmt > headTotalAmt) {
				alert("당월잔액보다 수신금액이 큽니다. 확인 후 작업하세요.");
				return false;
			}	
			
			$.extend(params, {"GUBN" : "RC"});
			$.extend(params, {"DETAIL_LIST" : fnGetGridCheckData(gridDetail)});
			//1건씩 재확정 처리
			saveCall(gridHeader, '/com/bdg/returnApmTransMgt', 'fnConfirm', params);
    	} else {
    		// 다건 확정처리
    		$.extend(params, {"GUBN" : "SA"});
    		saveCall(gridHeader, '/com/bdg/updatApmTransMgtStatus', 'fnConfirm', params);	 
    	}
    	 
    }
	
}

function fnConfirmSuccess(data) {
	alert("확정 되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnConfirmFail(result) {
	alert(result.errMsg);
}


//승인요청
var fnAppr = function(){
	gridHeader.commit();
	gridDetail.commit();
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_009"}); // 양식키
	$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
	$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
	$.extend(params, {"MANAGER_YN"    : "N"}); // 본부장표시여부
	$.extend(params, {"REVIEW_ORG_CD" : ""}); // 처리부서코드
	//$.extend(params, {"BGT_URL"   : "http://192.168.110.76/com/bdg/bdgApmTransMgtPop.do?G_TOP_MENU_CD=BDG140&G_MENU_CD=BDG143" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + $('#TB_ORG_NM').val() + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
	//$.extend(params, {"BGT_BUS_URL"   : "http://192.168.110.76/com/bdg/bdgApmTransMgtEps.do?G_TOP_MENU_CD=BDG140&G_MENU_CD=BDG143"}); // 처리로직  url
	$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgApmTransMgtPop.do?G_TOP_MENU_CD=BDG140&G_MENU_CD=BDG143" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
	$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgApmTransMgtEps.do?G_TOP_MENU_CD=BDG140&G_MENU_CD=BDG143"}); // 처리로직  url
	
	$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
	$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
	//$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
    if(confirm("승인요청 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/apprApmTransMgt', 'fnAppr', params);
    }
	
}

function fnApprFail(result) {
	alert(result.errMsg);
}

function fnApprSuccess(data) {
	//alert("승인요청 되었습니다.");
	
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
// 	 	htmlTag += "<h3>APM이관신청</h3>";
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
// 	    htmlTag += "<th><span>년월</span></th>";
// 	    htmlTag += "<td>" + $('#TB_CRTN_YYMM').val() + "</td>";
// 	    htmlTag += "<th><span>부서</span></th>";
// 	    htmlTag += "<td>" + $('#TB_ORG_NM').val() + "</td>";
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
	    
// 	    for (var i=0 ; i < gridHeader.getRowCount(); i++) {
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
                    <th><span>년월</span></th>
                    <td>
                    	<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM" dateHolder="bgn" value="" style="width:70px;"/>
<!-- 						<input type="text" id="TB_CRTN_YYMM"  style="text-align: center;" disabled> -->
                    </td>
                    <th><span>부서명</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" style="text-align: near;" disabled>
<!--                         <a href="javascript:fnSearchDept('condition');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
                        <input type="hidden" id="TB_ORG_CD">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>진행상태</span></th>
                    <td>
	                    <select id="SB_STATUS" name="SB_STATUS">
	                    </select>
                    </td>
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
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:150px">
                <col style="width:150px">
                <col>
            </colgroup>
	        <tr>
				<th><span>이관송신자</span></th>
				<th>(단위 : 원)</th>
				<td></td>
	        </tr>
		</table>
	</div>
    <div class="btnArea t_right">
<!--     	<button type="button" class="btn" id="btnAppr">승인요청</button> -->
    	<button type="button" class="btn" id="btnConfirm">확정</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridHeader"></div> 
</div>
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:480px">
            </colgroup>
	        <tr>
				<th><span>이관수신자</span></th>
	        	<td></td>
	        	<td></td>
	        </tr>
		</table>
	</div>
    <div class="btnArea t_right" id="div_btnD">
        <button type="button" class="btn" id="btnDetailRowDel">행삭제</button>
        <button type="button" class="btn" id="btnDetailRowAdd">행추가</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
