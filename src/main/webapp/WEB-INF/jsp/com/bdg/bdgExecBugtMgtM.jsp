<%--
	File Name : bdgExecBugtMgtM.jsp
	Description: 예산 > 예산관리 > 실행예산관리(관리자용)
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.19  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.19
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

var processTypeCodes  = new Array();
var processTypeLabels = new Array();

var editRows     = new Array();

var accountNo    = "";
var accountDesc  = "";
var remark       = "";
var rowIndex     = "";
var deptPopGubn  = "";
var d3Cnt        = 0;
var wCode        = "";
var status       = "";

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");
	
	// 위탁연구비 계정 코드 셋팅
	var wList     = stringToArray("${CODELIST_SYS003}","ALL");
	wCode = wList[0].CODE;
	
	// 상태 코드 셋팅(조회조건)
	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
	// 상태 코드 셋팅(그리드)
	apprCodes  = getComboSet('${CODELIST_YS001}', 'CODE');
	apprLabels = getComboSet('${CODELIST_YS001}', 'CODE_NM');
	
	// 구분 코드 셋팅(그리드)
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	setInitGridTotal();
	
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

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS_NM',            {text:'승인상태'},       60,            'text',              {textAlignment:"center"});
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'CCTR_CD',              {text:'코스트센터'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코스트센터명'},         100,            'text',           {textAlignment:"near"});      
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'textLink',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        100,            'text',              {textAlignment:"center"});
    addField(cm,    'GUBN_NM',              {text:'구분'},         100,            'text',           {textAlignment:"center"});
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
    
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_YMD',             {text: '전송일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_NM',               {text: '부서명'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},           0,     'text', {textAlignment: "center"},{visible:false});
      

    gridHeader.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 260       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridHeader.setColumnProperty("STATUS_NM"   , "mergeRule", {criteria:"value"});
    gridHeader.setColumnProperty("PROCESS_TYPE", "mergeRule", {criteria:"value"});
    gridHeader.setColumnProperty("CCTR_CD"     , "mergeRule", {criteria:"values['PROCESS_TYPE'] + values['ACCOUNT_NO']"});
    gridHeader.setColumnProperty("CCTR_NM"     , "mergeRule", {criteria:"values['PROCESS_TYPE'] + values['ACCOUNT_NO']"});
    gridHeader.setColumnProperty("ACCOUNT_NO"  , "mergeRule", {criteria:"value"});
    gridHeader.setColumnProperty("ACCOUNT_DESC", "mergeRule", {criteria:"value"});
    gridHeader.setColumnProperty("GUBN_NM"     , "mergeRule", {criteria:"value"});

    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
        if (data.fieldName == "ACCOUNT_NO") {
        	accountNo   = gridView.getValue(data.itemIndex,"ACCOUNT_NO");
        	accountDesc = gridView.getValue(data.itemIndex,"ACCOUNT_DESC");
        	processType = gridView.getValue(data.itemIndex,"PROCESS_TYPE");
        	status      = gridView.getValue(data.itemIndex,"STATUS");
        	rowIndex    = data.itemIndex;
        	
        	$("#TB_ACCOUNT_NO").val(gridView.getValue(data.itemIndex,"ACCOUNT_NO"));
        	$("#TB_ACCOUNT_DESC").val(gridView.getValue(data.itemIndex,"ACCOUNT_DESC"));
        	
        	$("#SB_CCTR_CD").val(gridView.getValue(data.itemIndex,"CCTR_CD"));
        	$("#TB_CCTR_NM").val(gridView.getValue(data.itemIndex,"CCTR_NM"));

        	//위탁연구비 계정일때만 보이게 처리
        	if($("#TB_ACCOUNT_NO").val() == wCode){
        		gridDetail.setColumnProperty("PROJECT", "visible", true);
        		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", false);
        		gridDetail.setColumnProperty("CODEMAPPING1", "visible", true);
        	} else {
        		gridDetail.setColumnProperty("PROJECT", "visible", false);
        		gridDetail.setColumnProperty("CODEMAPPING1", "visible", false);
        	}        	
        	
        	if (processType == "2") {
        		$("#div_btnD").hide();
        		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", true);
        		gridDetail.setColumnProperty("PROJECT", "visible", true);
        		gridDetail.setColumnProperty("CODEMAPPING1", "visible", false); 
        	} else {
//        			if (status == "1") {
//             		$("#div_btnD").show();     		
//             		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", false);
//             		gridDetail.setColumnProperty("PROJECT", "visible", false);          				
//        			} else {
//            			$("#div_btnD").hide();
//                		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
//                		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);
//                		gridDetail.setColumnProperty("CODEMAPPING1", "visible", false);
//        			}
       			
        		$("#div_btnD").show();     		
        		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", false);
        		gridDetail.setColumnProperty("PROJECT", "visible", false);         			
        	}
        	
        	editRows = [];
        	// 상세조회
        	fnSearchDetail();
        }
    };

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    };
    
    fnGridSortFalse(gridHeader);
    gridHeader.setDisplayOptions({columnMovable:false})
}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'GUBN',                 {text:'분류'},       60,            'text',              {textAlignment:"center"});
    addField(cm,    'DETAIL_DESC',          {text:'구분'},      300,            'text',              {textAlignment:"center"});
    addField(cm,    'BELONG_ORG',           {text:'귀속부서'},    150,            'text',              {textAlignment:"center"},{visible:false});
    addField(cm,    'PROJECT',              {text:'내부오더'},  150,            'text',               {textAlignment:"center"},{visible:false});
    addField(cm,    'CODEMAPPING1',  	    {text: ' '},    15,     'popupLink',null,{visible:false});
    addField(cm,    'M01',                  {text:'N'},           100,            'integer',       {textAlignment:"far"});
    addField(cm,    'M02',                  {text:'N+1'},           100,            'integer',       {textAlignment:"far"});
    addField(cm,    'M03',                  {text:'N+2'},           100,            'integer',       {textAlignment:"far"});
    addField(cm,    'CRTN_MM',              {text:'적요'},          300,            'text',           {textAlignment:"near"});
    
    addField(cm,    'CRUD',                 {text: '행구분'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트코드'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ACCOUNT_NO',           {text: '계정코드'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEQ_NO',               {text: 'SEQ'},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'BELONG_CCTR_CD',       {text:'귀속코스트'},           0,            'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PROJECT_CD',           {text:'내부오더'},           0,            'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'DATA_GUBN',            {text:'데이터구분'},           0,            'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'UNIT_PRICE',           {text: '단가'},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'UNIT_QTY',             {text: '수량'},                    60,     'integer', {textAlignment: "center"},{visible:false});

    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 188       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : false       //조회 건수 표시
    });
    
    gridDetail.setColumnProperty("GUBN", "mergeRule", {criteria:"value"});
    

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
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn = values.DATA_GUBN;
        var processType = values.PROCESS_TYPE;
        if (gubn == 'D3' && processType == "1") {
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        return disibleColStyle;
    };        
    
    gridDetail.setColumnProperty("DETAIL_DESC"  , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("M01"          , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("M02"          , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("M03"          , "dynamicStyles", columnDynamicStyles);
    gridDetail.setColumnProperty("CRTN_MM"      , "dynamicStyles", columnDynamicStyles);
    
    gridDetail.setColumnProperty("PROJECT_NM"   , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("BELONG_ORG_NM", "dynamicStyles", columnDefaultStyles);  
    gridDetail.setColumnProperty("GUBN"         , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("BELONG_ORG"   , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("PROJECT"      , "dynamicStyles", columnDefaultStyles);
    
    
    gridDetail.onDataCellClicked = function (grid, data) {
        
    	var temp = fnGetGridRowParams(gridDetail, data.itemIndex);
        if (data.fieldName == "CODEMAPPING1" && temp.DATA_GUBN == 'D3') {
        	fnSearchProj();
        }       
    };
    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
    	if((oldValue != newValue) && (grid.getColumns()[field].name != "CRTN_MM")){
    		editRows.push(itemIndex);
    	}
    };    
    
    fnGridSortFalse(gridDetail);
    gridDetail.setDisplayOptions({columnMovable:false})
}

function setInitGridTotal() {
    var gridId = "gridTotal";
    gridTotal = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'GUBN',                 {text:'분류'},       360,            'text',              {textAlignment:"center"});
    addField(cm,    'M01',                  {text:'N'},           100,            'integer',       {textAlignment:"far"});
    addField(cm,    'M02',                  {text:'N+1'},           100,            'integer',       {textAlignment:"far"});
    addField(cm,    'M03',                  {text:'N+2'},           100,            'integer',       {textAlignment:"far"});
    addField(cm,    'M04',                  {text:'비고'},           300,            'integer',       {textAlignment:"far"});

    gridTotal.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 80       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : false       //조회 건수 표시
    });
    
    gridTotal.setHeader({visible : false});    
}

/**
 * 프로젝트 조회
 */
function fnSearchProj() {
	var params = {};
	$.extend(params, fnGetParams());
	//$.extend(params, {"TB_DEPT_CD": $('#TB_ORG_CD').val()});
	var target    = "cmnProjSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/projList', params, target, width, height, scrollbar, resizable);
}

/**
 * 프로젝트 콜백
 */
function fnCallbackProjSearchPop(rows) {
	var values = {
	         "PROJECT_CD"  : rows.ORDER_NO 
	        ,"PROJECT"     : rows.ORDER_NO + '-' + rows.ORDER_DESC
	     };

	gridDetail.setValues(gridDetail.getCurrent().itemIndex, values);	
	
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectExecBugtMgtHeadList');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	var header1 = gridDetail.getColumnProperty("M01", "header");
	var header2 = gridDetail.getColumnProperty("M02", "header");
	var header3 = gridDetail.getColumnProperty("M03", "header");
	header1.text = (toNumber($('#TB_CRTN_YYMM').val().substring(5))) + "월";
	if ($('#TB_CRTN_YYMM').val().substring(5) == "11") {
		header2.text = (toNumber($('#TB_CRTN_YYMM').val().substring(5)) + 1) + "월";
		header3.text = " ";
    } else if ($('#TB_CRTN_YYMM').val().substring(5) == "12") {
		header2.text = " ";
		header3.text = " ";
	} else {
		header2.text = (toNumber($('#TB_CRTN_YYMM').val().substring(5)) + 1) + "월";
		header3.text = (toNumber($('#TB_CRTN_YYMM').val().substring(5)) + 2) + "월";
	}	
	gridDetail.setColumnProperty("M01", "header", header1);
	gridDetail.setColumnProperty("M02", "header", header2);
	gridDetail.setColumnProperty("M03", "header", header3);
	
	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
		$("#TB_ACCOUNT_NO").val(accountNo);
		$("#TB_ACCOUNT_DESC").val(accountDesc);
	    // 상태바 비활성화
	    gridHeader.closeProgress();	
	    
	    // 상세 조회
	    fnSearchDetail();
	} else {
		gridDetail.clearRows();
		$("#TB_ACCOUNT_NO").val("");
		$("#TB_ACCOUNT_DESC").val("");
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridHeader.clearRows();
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
	    // 상태바 비활성화
	    gridHeader.closeProgress();			
	}
	
	var rIndex = getComboIndex(data.rows, "GUBN", "D1");
	if (rIndex > -1) {
		$("#TB_SEND_YMD").val(data.rows[rIndex].SEND_YMD);	
	}
	
    //포커스된 셀 변경
    var focusCell = gridHeader.getCurrent();
    focusCell.column = "WK_M01";
    focusCell.fieldName = "1월";	     
    gridHeader.setCurrent(focusCell);

}

/**
 * 조회 후 처리
 */
function fnSearchDetailSuccess(data) {
	if(isEmpty(data.rows)){
		gridDetail.clearRows();
	}
	
	if (data.fields.PROCESS_TYPE == "2") {
		$("#div_btnD").hide();
		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", true);
		gridDetail.setColumnProperty("PROJECT", "visible", true);
		gridDetail.setColumnProperty("CODEMAPPING1", "visible", false); 
	} else {
// 		if (data.fields.STATUS == "1") {
//     		$("#div_btnD").show();     		
//     		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", false);
//     		gridDetail.setColumnProperty("PROJECT", "visible", false);          				
// 		} else {
//    			$("#div_btnD").hide();
//        		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
//        		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);
//        		gridDetail.setColumnProperty("CODEMAPPING1", "visible", false);
// 		}
		
		$("#div_btnD").show();     		
		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", false);
		gridDetail.setColumnProperty("PROJECT", "visible", false);  		
	}	
	
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridDetail.clearRows();
	// 그리고 데이터 setting
    gridDetail.setPageRows(data);
    // 상태바 비활성화
    gridDetail.closeProgress();
    
    //포커스된 셀 변경
    var focusCell = gridDetail.getCurrent();
    focusCell.column = "DETAIL_DESC";
    focusCell.fieldName = "구분";	     
    gridDetail.setCurrent(focusCell);
    
	if(isEmpty(data.fields.total)){
		gridTotal.clearRows();
	} else {
		gridTotal.clearRows();
		// 그리고 데이터 setting
	    gridTotal.setPageRows(data.fields.total);
	    // 상태바 비활성화
	    gridTotal.closeProgress();		
	}     
}

/**
 * 계정 조회
 */
function fnSearchAccount() {
	
	gridDetail.clearRows();
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트코드는 필수입니다.");
		return false;
	}
	
	var params = {};
	rowIndex = "";
	$.extend(params, fnGetParams());
	$.extend(params, {"ACCOUNT_GUBN" : "E"});
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/accountSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 팝업 콜백
 */
function fnCallbackAccountSearchPop(rows) {
	wCode = rows.W_CODE;
	$("#TB_ACCOUNT_NO").val(rows.ACCOUNT_NO);
	$("#TB_ACCOUNT_DESC").val(rows.ACCOUNT_DESC);
	
	if ($("#TB_ACCOUNT_NO").val() == wCode) {
		gridDetail.setColumnProperty("PROJECT", "visible", true);
		gridDetail.setColumnProperty("BELONG_ORG", "visible", false);
		gridDetail.setColumnProperty("CODEMAPPING1", "visible", true);		
	    gridDetail.setFixedOptions({colCount: 4 }); 
	} else {
		gridDetail.setColumnProperty("PROJECT", "visible", false);
		gridDetail.setColumnProperty("CODEMAPPING1", "visible", false);		
		gridDetail.setFixedOptions({colCount: 2 });
	}

	// 상세조회
    //fnSearchDetail();
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"COMP_CD"    : $('#SB_COMP_CD').val()});
	$.extend(params, {"CRTN_YYMM"  : $('#TB_CRTN_YYMM').val()});
	$.extend(params, {"CCTR_CD"    : $('#SB_CCTR_CD').val()});
	$.extend(params, {"ACCOUNT_NO" : $('#TB_ACCOUNT_NO').val()});
	$.extend(params, {"PROCESS_TYPE" : "1"});
	
	searchCall(gridDetail, '/com/bdg/selectExecBugtMgtDetailList', 'fnSearchDetail', params);	
	
}

//저장
var fnSaveD = function(){
	gridDetail.commit();
	
	// 계정코드 필수 체크
	if(isNullValue($("#TB_ACCOUNT_NO").val())){
		alert("계정코드는 필수입니다.");
		return false;
	}
	
	var seq = 0;
	// Detail 필수 체크
	for(var i = 0; i < gridDetail.getAllRows().length; i++){
		gridDetail.checkItem(i, true);
		var temp = fnGetGridRowParams(gridDetail, i);
		
		if (temp.DATA_GUBN != 'D3') {
			continue;
		} else {
			
			gridDetail.setRowValue(i, "SEQ_NO", seq);
			seq++;
			
			if (isNullValue(temp.DETAIL_DESC)) {
				alert("구분은 필수입니다.");
				return false;				
			}
			if (isNullValue(temp.BELONG_CCTR_CD)) {
				alert("귀속코스트는 필수입니다.");
				return false;				
			}
// 			if (isNullValue(temp.PROJECT_CD)) {
// 				alert("프로젝트는 필수입니다.");
// 				return false;				
// 			}
// 			if (isNullValue(temp.M01)) {
// 				alert("N월은 필수입니다.");
// 				return false;				
// 			}
// 			if (isNullValue(temp.M02)) {
// 				alert("N+1월은 필수입니다.");
// 				return false;				
// 			}	
// 			if (isNullValue(temp.M03)) {
// 				alert("N+2월은 필수입니다.");
// 				return false;				
// 			}
// 			if (isNullValue(temp.CRTN_MM)) {
// 				alert("적요는 필수입니다.");
// 				return false;				
// 			}			
		}

	}

	for(var j = 0; j < editRows.length; j++){
		if(isEmpty(gridDetail.getValue(editRows[j],"CRTN_MM"))){
			alert("적요는 필수입니다.");
			return false;				
		}
	}	
	
	editRows = [];
	
	if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
		var params = {};
		$.extend(params, fnGetParams());
		$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridDetail)});
		
		saveCall(gridHeader, '/com/bdg/saveExecBugtMgtDetailM', 'fnSaveD', params);
	}
	
	
	
}

/**
 * 저장 성공
 */
function fnSaveDSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridDetail.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveDFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridDetail.closeProgress();
}

/**
 * 실행예산상세
 */
function fnSearchDetail() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridHeader, gridHeader.getCurrent().itemIndex));
	searchCall(gridDetail, '/com/bdg/selectExecBugtMgtDetailList', 'fnSearchDetail', params);
}

//행추가
function fnRowAdd() {
	
	if($("#TB_ACCOUNT_NO").val() == null || $("#TB_ACCOUNT_NO").val() == ""){
		alert("계정코드는 필수입니다.");
		return false;
	}
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트코드는 필수입니다.");
		return false;
	}
	
	var addRowIndex = 1;
	
	for(var i = 0; i < gridDetail.getAllRows().length; i++){
		var temp = fnGetGridRowParams(gridDetail, i);
		// 당월실행인 경우  count
		if (temp.DATA_GUBN == "D3") {
			addRowIndex++;
		}
	}
	
	var values = { "CRUD" : "I" 
			      ,"DATA_GUBN" : "D3"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replace('-', '')
			      ,"CCTR_CD" : $('#SB_CCTR_CD').val()
			      ,"ACCOUNT_NO" : $('#TB_ACCOUNT_NO').val()
			      ,"PROCESS_TYPE" : "1"
			      ,"GUBN" : "당월실행"
			      ,"BELONG_CCTR_CD" : $('#SB_CCTR_CD').val()
			      ,"BELONG_CCTR_NM" : $('#SB_CCTR_CD').val() + '-' + $("#TB_CCTR_NM").val()
			      ,"SEQ_NO" :  addRowIndex
			      ,"M01" : "0"
			      ,"M02" : "0"
			      ,"M03" : "0"
			      ,"CODEMAPPING1" : "1"};
	fnAddRow(gridDetail, values, gridDetail.getRowCount());
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridDetail);
}

//반려
var fnReject = function(){
	gridHeader.commit();
	var params = {};
	$.extend(params, fnGetParams());
	
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트코드는 필수입니다.");
		return false;
	}
	
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("반려 할 데이터가 존재하지 않습니다. 조회 후 진행하십시오.");
		return false;
	}	
	
	// Detail 필수 체크
// 	for(var i = 0; i < gridHeader.getAllRows().length; i++){
		
// 		var temp = fnGetGridRowParams(gridHeader, i);
		
// 		if (temp.STATUS == '5') {
// 			continue;
// 		} else {
// 			alert("[승인완료] 상태에서만  반려 가능합니다.");
// 			return false;				
// 		}
// 	}
	
	$.extend(params, {"STATUS" : "4"});
	$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
     if(confirm("반려 하시겠습니까?")){
    	 saveCall(gridHeader, '/com/bdg/rejectExecBugtMgt', 'fnReject', params);
     }
	
}

function fnRejectSuccess(data) {
	alert("반려되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnRejectFail(result) {
	alert(result.errMsg);
}

//실행예산생성
var fnCreate = function(){
	gridHeader.commit();
	var params = {};
	$.extend(params, fnGetParams());
	
     if(confirm("실행예산생성 하시겠습니까?")){
    	 saveCall(gridHeader, '/com/bdg/createExecBugtMgt', 'fnCreate', params);
     }
	
}

function fnCreateSuccess(data) {
	alert("실행예산 생성 되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnCreateFail(result) {
	alert(result.errMsg);
}

// SAP 전송
function fnSap() {
	gridHeader.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"BATCH_ARG5" : $('#SB_COMP_CD').val()
		             ,"BATCH_ARG6" : $('#TB_CRTN_YYMM').val().replace('-', '')
		             ,"BATCH_ARG7" : 'C'
		             ,"BATCH_ARG8" : $('#TB_CRTN_YYMM').val().replace('-', '').substring(4)
		             ,"BATCH_ID"   : 'MAKE_SEND_BUGT_DATA'});
	
    if(confirm("전송 하시겠습니까?")){
    	saveCall(gridHeader, '/com/bdg/sendExecBugtMgt', 'fnSap', params);
    }
}

function fnSapSuccess(data) {
	alert("SAP전송 되었습니다.");
}

function fnSapFail(result) {
	alert("SAP전송 실패 하였습니다.");
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
                <col style="width:400px">
                <col style="width:70px">
                <col style="width:400px">
                <col style="width:100px">
                <col style="width:400px">
                <col style="width:100px">
                <col style="width:400px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCctrReset();">
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
                    	<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM" dateHolder="bgn" value="" style="width:70px;" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_CCTR_NM" disabled="disabled">
                        <input type="hidden" id="SB_CCTR_CD">
                        <a href="javascript:fnSearchCctr();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
<%--                     <th><span>승인상태</span></th> --%>
<!--                     <td> -->
<%-- 	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" onchange="fnSearch();"> --%>
<%-- 	                    </select> --%>
<!--                     </td>                     -->
                    <td></td>
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearch">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
    <div class="tbl-search-area" style="float:left; width:800px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:90px">
                <col style="width:60px">
                <col style="width:90px">
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 10px;">(단위 : 원)</th>
				<td style="padding-top: 10px;"></td>
	        	<td style="padding-top: 10px;"></td>
				<th style="padding-top: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>전송일</span></th>
	        	<td style="padding-top: 10px;">
					<input type="text" id="TB_SEND_YMD" class="w80" disabled>	        	
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right">
    	<button type="button" class="btn" id="btnSap">SAP전송</button>
    	<button type="button" class="btn" id="btnCreate">실행예산생성</button>
        <button type="button" class="btn" id="btnReject">반려</button>
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
				<th><span>계정</span></th>
	        	<td>
				    <input type="text" id="TB_ACCOUNT_NO"	style="width: 90px;" 	readonly="readonly"/>
				    <input type="text" id="TB_ACCOUNT_DESC"	style="width: 150px;"	readonly="readonly"/>
				    <a href="javascript:fnSearchAccount();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>
    <div class="btnArea t_right" id="div_btnD">
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnSaveD">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
<br>
<div class="realgrid-area">
    <div id="gridTotal"></div> 
</div>