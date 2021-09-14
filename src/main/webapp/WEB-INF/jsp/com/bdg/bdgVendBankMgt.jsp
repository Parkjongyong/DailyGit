<%--
	File Name : bdgVendBankMgt.jsp
	Description: 예산 > 부가정보 > 공급업체계좌등록
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.16  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.16
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridHeader;
var gridDetail;
var apprCodes  = new Array();
var apprLabels = new Array();

var rowIndex     = -1;

var statusCodes  = new Array();
var statusLabels = new Array();

var bankCodes  = new Array();
var bankLabels = new Array();

var bankIdCodes  = new Array();
var bankIdLabels = new Array();

var condCodes  = new Array();
var condLabels = new Array();

var compList = new Array();
var condList = new Array();

var nextDeptCodes  = new Array();

var userPopGubn  = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	compList = stringToArray("${CODELIST_SYS001}","ALL");
	condList = stringToArray("${CODELIST_YS019}");
	
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");
	
	statusCodes  = getComboSet('${CODELIST_YS026}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS026}', 'CODE_NM');
	
	condCodes  = getComboSet('${CODELIST_YS019}', 'CODE');
	condLabels = getComboSet('${CODELIST_YS019}', 'CODE_NM');
	
	bankCodes  = getComboSet('${CODELIST_YS027}', 'CODE');
	bankLabels = getComboSet('${CODELIST_YS027}', 'CODE_NM');
	
	bankIdCodes  = getComboSet('${CODELIST_YS033}', 'CODE');
	bankIdLabels = getComboSet('${CODELIST_YS033}', 'CODE_NM');
	
	$("#TB_START_DT").val(getDiffDay("m",-1));
	$("#TB_END_DT").val(getDiffDay("m",0));	
	$("#TB_CRTN_YMD").val(getDiffDay("m",0));	

	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    $('#POBUSI_NO').off();
    
    $("#pobusi_dialog").dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:170, //팝업 가로
        width: 500, //팝업 높이
        close: function(event,ui) {
            $("#POBUSI_NO").val("");
            $("#pobusi_dialog").dialog( "close" );
        }
    });    
    
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YMD").val(getDiffDay("y",0));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_ORG_NM").val('${LOGIN_INFO.DEPT_NM}');
	$("#TB_ORG_CD").val('${LOGIN_INFO.DEPT_CD}');
}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
    

    addField(cm,    'CRTN_YMD',             {text:'신청일자'},           80,     'text', {textAlignment: "center"});
    addField(cm,    'STATUS',               {text: '진행상태'},       80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'VENDOR_CD',            {text:'업체코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'POBUSI_NO',            {text:'사업자번호'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    addField(cm,    'VENDOR_NM',            {text:'업체명'},         100,            'textLink',           {textAlignment:"near"});
    
    addField(cm,    'PRESIDENT_NM',         {text:'대표자명'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'BUSS_TYPE',            {text:'업종'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'BUSIN',                {text:'업태'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'TEL_NO',               {text:'대표전화번호'},         100,            'text',           {textAlignment:"near"});
    
    addField(cm,    'CNT',                  {text: 'DETAIL CNT'},       0,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    
    addField(cm,    'ORG_CD',               {text: '부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EMAIL',                {text: 'EMAIL'},           0,     'text', {textAlignment: "center"},{visible:false});
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

    gridHeader.setColumnProperty("VENDOR_CD"   , "dynamicStyles", columnDefaultStyles);    
    gridHeader.setColumnProperty("POBUSI_NO"   , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("VENDOR_NM"   , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("PRESIDENT_NM", "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("BUSS_TYPE"   , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("BUSIN"       , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("TEL_NO"      , "dynamicStyles", columnDefaultStyles);
    
    
    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
    	var values = grid.getValues(data.itemIndex); 
        if (data.column == "VENDOR_NM") {
        	rowIndex = data.itemIndex;
        	
        	for(var i = 0; i < gridHeader.getRowCount(); i++){
        		gridHeader.checkItem(i, false);
        	}
        	
        	//구별되기 위해 체크박스 체크
        	gridHeader.checkItem(data.itemIndex, true);
        	// 기등록 데이터인 경우만 상세조회
        	if (values.CRUD == 'R') {
        		fnSearchDetail();	
        	}
        }
        
    	// 품목코드
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnNewData();
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
    
    addField(cm,    'SAP_RECV_YN',          {text: 'SAP등록여부'},    80,            'text',           {textAlignment:"center"});
	addField(cm,    'STATUS',               {text: '진행상태'},       80,            'text',              {textAlignment: "center"},{visible:false,lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
	addField(cm,    'BANK_ACCOUNT_ID',      {text: '은행ID'},       130,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:bankIdCodes,labels:bankIdLabels},'dropDown');
    addField(cm,    'BANK_CD',              {text: '은행'},       100,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:bankCodes,labels:bankLabels},'dropDown');
    addField(cm,    'BANK_ACCOUNT_NO',      {text: '계좌번호'},       130,            'text',           {textAlignment:"near"});
    addField(cm,    'BANK_USER',            {text: '예금주'},         0,            'text',           {textAlignment:"center"},{visible:false});
    addField(cm,    'BANK_DESC',            {text: '예금주'},        300,            'text',           {textAlignment:"near"});
    addField(cm,    'PAY_COND',             {text: '지급조건'},       150,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:condCodes,labels:condLabels},'dropDown');

    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'POBUSI_NO',            {text: '사업자 번호'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'VENDOR_NM',            {text:'업체명'},         0,            'text',           {textAlignment: "center"},{visible:false});
    
    addField(cm,    'RETURN_DESC',          {text: '반려사유'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BANK_NATION',          {text: '은행국가키'},           0,     'text', {textAlignment: "center"},{visible:false});
    
    
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 200       //required 그리드 높이
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
        var gubn   = values.SAP_RECV_YN;
        var status = values.STATUS;
        if (gubn == 'N' && status == '1') {
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
    
    
    gridDetail.setColumnProperty("BANK_CD"         , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("BANK_ACCOUNT_ID" , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("BANK_ACCOUNT_NO" , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("BANK_USER"       , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("BANK_DESC"       , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("PAY_COND"        , "dynamicStyles", columnDynamicStyles);
     
    gridDetail.setColumnProperty("SAP_RECV_YN"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("STATUS"       , "dynamicStyles", columnDefaultStyles);
    
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
    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
    	
//     	if (field == 6) {
//     		gridDetail.setRowValue(itemIndex, "BANK_ACCOUNT_ID" ,getComboValue(condList, "ATTR01", getComboIndex(condList, "CODE", newValue)));
//     	}
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
	
	$('#TB_ORG_CD').val(rows.DEPT_CD );
	$('#TB_ORG_NM').val(rows.DEPT_NM );
}


/**
 * 조회
 */
function fnSearch() {
	//초기화
	rowIndex = -1;
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectVendBankMgtHeadList');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
		gridDetail.clearRows();
	}
	
	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
	    // 상태바 비활성화
	    gridHeader.closeProgress();	
	    gridDetail.clearRows();
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


var fnSave = function(){
	gridDetail.commit();
	gridHeader.commit();
	var checkedRows = gridHeader.getCheckedItems();
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridHeader.getValues(checkedRows[i]);
		
		if (temp.CNT == 0) {
			continue;
		} else {
			alert("[작성중] 상태에서만 저장가능합니다.");
			return false;				
		}
		
		if (temp.CRUD == 'R') {
			gridHeader.checkItem(checkedRows[i], false);
		}
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["VENDOR_CD", "POBUSI_NO"];
	var requiredVal2  = ["BANK_CD", "BANK_ACCOUNT_NO", "BANK_USER", "PAY_COND"];
	
	//전체행 체크
	for(var i = 0; i < gridDetail.getRowCount(); i++){
		gridDetail.checkItem(i, true);
	}	
	
	if(fnSaveCheck(gridHeader, requiredVal, true) == true){
		if(fnSaveCheck(gridDetail, requiredVal, false) == true){
			if(confirm("저장 하시겠습니까?")){
				
				var params = {};
				$.extend(params, {"GUBN"        : "SA"});
				$.extend(params, fnGetParams());
				$.extend(params, {"HEAD_LIST"   : fnGetGridCheckData(gridHeader)});
				$.extend(params, {"DETAIL_LIST" : fnGetSaveAllData(gridDetail)});
				
				for(var i = 0; i < params.DETAIL_LIST.ALLDATA.length; i++){
					
					for(var j = i+1; j < params.DETAIL_LIST.ALLDATA.length; j++){
						if(params.DETAIL_LIST.ALLDATA[i].BANK_ACCOUNT_NO == params.DETAIL_LIST.ALLDATA[j].BANK_ACCOUNT_NO){
							alert("계좌번호가 중복되었습니다. \n확인 후 작업을 진행해주세요.");
							return false;
						}
					}
					
				}				
				
				saveCall(gridHeader, '/com/bdg/saveVendBankMgt', 'fnSave', params);
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
	gridDetail.commit();
	var checkedRows = gridHeader.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridHeader.getValues(checkedRows[i]);
		
		if (temp.CNT == 0) {
			continue;
		} else {
			alert("[작성중] 상태에서만 삭제가능합니다.");
			return false;				
		}
	}	
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "DE"});
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridHeader)});
	
	if(fnDeleteCheck(gridHeader) == true){
		deleteCall(gridHeader, '/com/bdg/deleteVendBankMgt', 'fnDelete', params);
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


//삭제
function fnDetailDelete() {
	
	gridDetail.commit();
	var checkedRows = gridDetail.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridDetail.getValues(checkedRows[i]);
		
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
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridDetail)});
	
	if(fnDeleteCheck(gridHeader) == true){
		deleteCall(gridHeader, '/com/bdg/deleteVendBankDetailMgt', 'fnDetailDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDetailDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	gridDetail.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDetailDeleteFail(result) {
	alert(result.errMsg);
}


/**
 * 계좌정보조회
 */
function fnSearchDetail() {
	
	if(rowIndex != -1){
		var temp = gridHeader.getValues(rowIndex);
		$('#TB_POBUSI_NO').val(temp.POBUSI_NO);
		
		var params = {};
		$.extend(params, fnGetParams());
		$.extend(params, temp);
		searchCall(gridDetail, '/com/bdg/selectVendBankMgtDetailList', 'fnSearchDetail', params);
	}
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

/**
 * 신규작성
 */
function fnNewData() {
	 $("#pobusi_dialog").dialog( "open" );
}	

/**
 * 사업자번호 확인
 */
function fnPobusiNo() {
	
	gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "POBUSI_NO", $('#POBUSI_NO').val()); //사업자번호
	var temp = fnGetGridRowParams(gridHeader, gridHeader.getCurrent().itemIndex);
	 
	if(temp.POBUSI_NO == null || temp.POBUSI_NO == ""){
		alert("사업자번호는 필수입니다.");
		return false;
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"POBUSI_NO" : temp.POBUSI_NO.replace("-", "").replace("-", "")});
	gridDetail.clearRows();
	
	searchCall(gridHeader, '/com/bdg/selectPobusiNo2', 'fnPobusiNo', params);
}

/**
 * 조회 후 처리
 */
function fnPobusiNoSuccess(data) {
	// 상단 header 정보 추가
	gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "CNT", "0"); //대표자명
 	// 에러메세지 처리
 	if(isEmpty(data.fields.headMap) == true){
 		$('#SB_RELATE_COMPANY').val($('#SB_COMP_CD').val());
 		alert("해당 사업자번호로 SAP에 등록된 정보가 존재하지 않습니다. 신규 추가하십시오.");
 		return false;
 	} else {
 		// TB_PRESIDENT_NM 
 		if(isNotEmpty(data.fields.headMap.REPRESN)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "PRESIDENT_NM", data.fields.headMap.REPRESN); //대표자명
 		}
 		if(isNotEmpty(data.fields.headMap.NAME1)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "VENDOR_NM", data.fields.headMap.NAME1); //공급업체명
 		}
 		if(isNotEmpty(data.fields.headMap.LIFNR)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "VENDOR_CD", data.fields.headMap.LIFNR); //공급업체코드
 		} 		
 		if(isNotEmpty(data.fields.headMap.TELF1)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "TEL_NO", data.fields.headMap.TELF1); //전화번호
 		}
 		if(isNotEmpty(data.fields.headMap.SMTP_ADDR)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "EMAIL", data.fields.headMap.SMTP_ADDR); //email
 		} 		
 		if(isNotEmpty(data.fields.headMap.GESTYPN)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "BUSS_TYPE", data.fields.headMap.GESTYPN); //업종
 		}
 		if(isNotEmpty(data.fields.headMap.INDTYPN)) {
 			gridHeader.setRowValue(gridHeader.getCurrent().itemIndex, "BUSIN", data.fields.headMap.INDTYPN); //업태
 		}
 		
 		gridHeader.commit();
 		
 		var headInfo = gridHeader.getValues(rowIndex);
 		
 		var addCnt = 0;
 		if(!isEmpty(data.fields.bankList)){
 			// 데이터 건수 만큼  row정보 추가
 			for(var i = 0; i < data.fields.bankList.length; i++){
 				var temp = data.fields.bankList[i];
 				
 				if (isNotEmpty(temp.BANKN)) {
 					addCnt++;
 					var values = { "CRUD" : "I" 
 					      ,"STATUS" : "1"
 					      ,"COMP_CD" : headInfo.COMP_CD
 					      ,"CRTN_YMD" : headInfo.CRTN_YMD
 					      ,"ORG_CD" : headInfo.ORG_CD
 					      ,"POBUSI_NO" : headInfo.POBUSI_NO
 					      ,"SAP_RECV_YN" : 'Y'
 					      ,"STATUS" : '1'
 					      ,"BANK_CD" : temp.BANKL
 					      ,"BANK_ACCOUNT_NO" : temp.BANKN
 					      ,"BANK_ACCOUNT_ID" : temp.BVTYP
 					      //,"BANK_USER" : temp.KOINH
 					      ,"BANK_DESC" : temp.BKREF
 					      //,"PAY_COND" : temp.ZTERM
 					      ,"BANK_NATION" : temp.BANKS
 					      ,"SAP_SEND_YN" : "Y"
 					      };

 					fnAddRow(gridDetail, values, gridDetail.getRowCount());
 					gridDetail.commit();				
 				}
 			}

 		}
 	}
	
 	$("#pobusi_dialog").dialog( "close" );
 	
	if (addCnt == 0) {
		alert("해당 업체에 등록된 계좌정보가 존재하지 않습니다. 행추가 후 작업하세요.");
	}
 		
}

//행추가
function fnRowAdd(data) {
	
	gridHeader.checkAll(false,false);
	if($("#SB_COMP_CD").val() == null || $("#SB_COMP_CD").val() == ""){
		alert("회사는 필수입니다.");
		return false;
	}
	
	var values = { "CRUD" : "I" 
		          ,"CODEMAPPING1" : "1"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YMD" : $('#TB_CRTN_YMD').val().replace('-', '').replace('-', '')
			      ,"ORG_CD" : $('#TB_ORG_CD').val()
			      };
	// 추가될 위치로 index 변경
	rowIndex = gridHeader.getRowCount();
	
	fnAddRow(gridHeader, values, gridHeader.getRowCount());
	
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridHeader);
}

//행추가
function fnDetailRowAdd() {
	
	if($("#SB_COMP_CD").val() == null || $("#SB_COMP_CD").val() == ""){
		alert("회사는 필수입니다.");
		return false;
	}
	
	if($("#TB_CRTN_YMD").val() == null || $("#TB_CRTN_YMD").val() == ""){
		alert("신청일자는 필수입니다.");
		return false;
	}
	
	if(rowIndex == -1){
		alert("공급업체 클릭  후 작업하세요.");
		return false;
	}
	
	var headInfo = gridHeader.getValues(rowIndex);
	
	var values = { "CRUD" : "I" 
	      ,"STATUS" : "1"
	      ,"COMP_CD" : headInfo.COMP_CD
	      ,"CRTN_YMD" : headInfo.CRTN_YMD
	      ,"ORG_CD" : headInfo.ORG_CD
	      ,"POBUSI_NO" : headInfo.POBUSI_NO
	      ,"BANK_NATION" : 'KR'
	      ,"SAP_RECV_YN" : 'N'
	      ,"SAP_SEND_YN" : "N"
	      };
	fnAddRow(gridDetail, values, gridDetail.getRowCount());
	gridDetail.commit();
	
}

//행삭제
function fnDetailRowDel() {
	fnAddRowDelete(gridDetail);
}

//승인요청
var fnAppr = function(){
	gridHeader.commit();
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	var checkedRows = gridHeader.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridHeader.getValues(checkedRows[i]);
		
		if (temp.CNT == 0) {
			continue;
		} else {
			alert("[작성중] 상태에서만 승인요청가능합니다.");
			return false;				
		}
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["VENDOR_CD", "POBUSI_NO"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridHeader, requiredVal, true) == true){
		if(confirm("승인요청 하시겠습니까?")){
			
			var params = {};
			$.extend(params, fnGetParams());
			$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_006"}); // 양식키
			$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
			$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
			$.extend(params, {"MANAGER_YN"    : "N"}); // 본부장표시여부
			$.extend(params, {"REVIEW_ORG_CD" : ""}); // 처리부서코드
			if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
				$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgVendBankMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
				$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgVendBankMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141"}); // 처리로직  url
			} else {
				$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgVendBankMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
				$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgVendBankMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141"}); // 처리로직  url
			}
// 			$.extend(params, {"BGT_URL"       : "http://192.168.110.76/com/bdg/bdgVendBankMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YMD=" + $('#TB_CRTN_YMD').val() + "&TB_ORG_NM=" + $('#TB_ORG_NM').val() + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
// 			$.extend(params, {"BGT_BUS_URL"   : "http:/192.168.110.76/com/bdg/bdgVendBankMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG141"}); // 처리로직  url
			$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
			$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
			
			$.extend(params, {"GUBN"      : "AR"});
			$.extend(params, {"STATUS"    : "2"});
			$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridHeader)});
			
			saveCall(gridHeader, '/com/bdg/apprVendBankMgt', 'fnAppr', params);
		}

	}	
}

function fnApprSuccess(data) {
	
	//alert("승인요청 되었습니다.");
	gridHeader.clearRows();
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key"          : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : data.fields.result.EPS_FORM_ID}); //양식key
	 	$.extend(params, {"empno"        : data.fields.result.SABUN}); // 기안자
	 	$.extend(params, {"deptcd"       : data.fields.result.ORG_CD}); //기안자 부서코드
	 	$.extend(params, {"geMangerYn"   : 'N'}); //본부장 표시여부
	 	//$.extend(params, {"reqDeptcd"    : ''}); //처리부서코드
	 	
	 	if ($('#SB_COMP_CD').val() == "1100") {
	 		nextDeptCodes = getComboSet('${CODELIST_YS040}', 'CODE', $('#SB_COMP_CD').val());	
	 	} else {
	 		nextDeptCodes = getComboSet('${CODELIST_YS040}', 'CODE', 'ALL');
	 	}
	 	
	 	$.extend(params, {"reqDeptcd" : nextDeptCodes[0]}); //처리부서코드
	 	
	 	$.extend(params, {"systemUrl"    : data.fields.result.BGT_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //popup_url
	 	$.extend(params, {"businessUrl"  : data.fields.result.BGT_BUS_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //business_url
	 	$.extend(params, {"systemName"   : '전사시스템'}); //시스템이름
	 	$.extend(params, {"subject"      : ''}); //제목
	 	$.extend(params, {"status"       : '2'}); //상태코드
	 	
	 	var htmlTag = "<!DOCTYPE html>";
	 	htmlTag += "<html lang='ko'>";
	 	htmlTag += "<head>";
	 	htmlTag += "<meta charset='UTF-8'>";
	 	htmlTag += "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>";
	 	htmlTag += "<style>";
	 	htmlTag += ".tit-area{overflow:hidden;position:relative;padding:18px 0 13px;}";
	 	htmlTag += ".tbl-view{width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;}";
	 	htmlTag += ".tbl-view tbody th{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;background-color:#f1f2f6;text-align:left;}";
	 	htmlTag += ".tbl-view tbody td{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;}";
	 	htmlTag += "</style>";
	 	htmlTag += "</head>";
	 	
	 	htmlTag += "<body>";
	 	htmlTag += "<div class='tit-area' style='text-align:center; padding:15px;'>";
	 	htmlTag += "<div>";
	 	htmlTag += "<h3>공급업체계좌등록</h3>";
	 	htmlTag += "</div>";
	    htmlTag += "<div class='tbl-search-wrap'>";
	    htmlTag += "<div class='tbl-search-area'>";
	    htmlTag += "<table class='tbl-search'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:480px'>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:480px'>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:480px'>";	    
	    htmlTag += "<col>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th><span>회사 :</span></th>";
	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
	    htmlTag += "<th><span>부서 :</span></th>";
	    htmlTag += "<td>" + $('#TB_ORG_NM').val() + "</td>";
	    htmlTag += "<td></td>";
	    htmlTag += "</tr>";
	    htmlTag += "</tbody>";
	    htmlTag += "</table>";
	    htmlTag += "</div>";
	    htmlTag += "</div>";
	    htmlTag += "<div class='pop-cont'>";
	    htmlTag += "<div class='pop-cont'>";
	    htmlTag += "<table class='tbl-view'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:120px'>";
	    htmlTag += "<col style='width:120px'>";
	    htmlTag += "<col style='width:200px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th style='text-align:center'>사업자번호</th>";
	    htmlTag += "<th style='text-align:center'>업체명</th>";
	    htmlTag += "<th style='text-align:center'>은행ID</th>";
	    htmlTag += "<th style='text-align:center'>은행</th>";
	    htmlTag += "<th style='text-align:center'>계좌번호</th>";
	    htmlTag += "<th style='text-align:center'>예금주</th>";
	    htmlTag += "<th style='text-align:center'>지급조건</th>";
	    htmlTag += "</tr>";
	    
	    if (!isNullValue(data.fields.epsList)) {
	    	for (var i=0 ; i < data.fields.epsList.length; i++) {
	 	    	htmlTag += "<tr>";
	 	    	htmlTag += "<td style='text-align:center'>" + data.fields.epsList[i].POBUSI_NO + "</td>";
	 	    	htmlTag += "<td style='text-align:center'>" + data.fields.epsList[i].VENDOR_NM + "</td>";
	 	    	htmlTag += "<td style='text-align:center'>" + data.fields.epsList[i].BANK_ACCOUNT_ID + "</td>";
	 	    	htmlTag += "<td style='text-align:center'>" + data.fields.epsList[i].BANK_CD + "</td>";
	 	    	htmlTag += "<td style='text-align:center'>" + data.fields.epsList[i].BANK_ACCOUNT_NO + "</td>";
	 	    	htmlTag += "<td style='text-align:left'>"   + data.fields.epsList[i].BANK_DESC + "</td>";
	 	    	htmlTag += "<td style='text-align:center'>" + data.fields.epsList[i].PAY_COND + "</td>";
	 	    	htmlTag += "</tr>";	    		
	    	}
	    }
	    
	    htmlTag += "</tbody>";
	    htmlTag += "</table>";
	    htmlTag += "</div>";
	    htmlTag += "</body>";
	    htmlTag += "</html>";
	    
	    $.extend(params, {"HTMLBody" : htmlTag}); //본문 데이터
	 	
	 	// 새로운 tab으로 전자결재 시스템 활성화
		//fnPostGoto("http://epsdev.ildong.com/approval/legacy/goFormLink", params, "GW");
	    
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

/**
 * 저장 실패
 */
function fnApprFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridHeader.closeProgress();
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
                    <th><span class="stit">신청일자</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DT" dateHolder="end" value=""/>
                        
                    </td>
                    <th><span>부서명</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" style="text-align: near;" disabled>
<!--                         <a href="javascript:fnSearchDept();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
                        <input type="hidden" id="TB_ORG_CD">
                        <input type="hidden" id="TB_CRTN_YMD"  name="신청일자"  value="">
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
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:150px">
                <col style="width:150px">
                <col>
            </colgroup>
	        <tr>
				<th><span>공급업체LIST</span></th>
				<th></th>
				<td></td>
	        </tr>
		</table>
	</div>
    <div class="btnArea t_right">
    	<button type="button" class="btn" id="btnAppr">승인요청</button>
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
                <col style="width:100px">
                <col style="width:100px">
                <col style="width:400px">
                <col>
            </colgroup>
	        <tr>
				<th><span>계좌정보</span></th>
	        	<td></td>
				<th></th>
	        	<td>
				    <input type="hidden" id="TB_POBUSI_NO" dateHolder="bgn" value="" style="width:150px;"/>
<!-- 				    <a href="javascript:fnPobusiNo();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>
    <div class="btnArea t_right" id="div_btnD">
        <button type="button" class="btn" id="btnDetailRowDel">행삭제</button>
        <button type="button" class="btn" id="btnDetailRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDetailDelete">삭제</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
<!-- dialog-Pop : S -->
<div id="pobusi_dialog" title="공급업체 조회">
    <table class="tbl-view">
        <colgroup>
          <col style="width:30%;">
          <col>
        </colgroup>
       <tbody>
            <tr>
                <th>사업자번호</th>
                <td><input type="text" id="POBUSI_NO" name="POBUSI_NO" class="wp100" maxlength="100" onkeypress="if(event.keyCode==13){fnPobusiNo();}" /></td>
            </tr>       
      </tbody>
    </table>
    <br>
    <div align="center">
        <button type="button" class="btn" onClick="javascript:fnPobusiNo();">확인</button>
    </div>
</div>