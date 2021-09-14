<%--
	File Name : bdgOpBasicMgtExcel.jsp
	Description:예산 > 예산관리 > 경영기본예산신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.30  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.30
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var gridData;
var gridCode1;
var gridCode2;
var gridCode3;
var gridCode4;

var compCodes  = new Array();
var compLabels = new Array();

var clauseCdCodes  = new Array();
var clauseCdLabels = new Array();

var distibCdCodes  = new Array();
var distibCdLabels = new Array();

var accountCdCodes  = new Array();
var accountCdLabels = new Array();

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,  'CODE', 'CODE_NM');
	
    clauseCdCodes  = getComboSet('${CODELIST_YS006}', 'CODE');
    clauseCdLabels = getComboSet('${CODELIST_YS006}', 'CODE_NM');
	
    distibCdCodes  = getComboSet('${CODELIST_YS008}', 'CODE');
    distibCdLabels = getComboSet('${CODELIST_YS008}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
    fnCompCdChange();
	// 그리드 생성
	setInitGridData();
	setInitGridCode1();
	setInitGridCode2();
	setInitGridCode3();
	setInitGridCode4();
    fnSearchCode();
    
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
	$("#TB_CRTN_YY").val('${PARAM.TB_CRTN_YY}');
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	$("#SB_BELONG_CCTR_CD").val('${PARAM.SB_BELONG_CCTR_CD}');
	
}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_BELONG_CCTR_CD', costList, 'CODE', 'CODE_NM');
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ITEM_CD',              {text:'품목코드'},         100,            'text',           {textAlignment:"near"});
//     addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    addField(cm ,   'DISTRIB_CD',           {text:'유통코드'},         60,            'text',              {textAlignment: 'center'});
    addField(cm ,   'ACCOUNT_NO',           {text:'계정코드'},         80,            'text',              {textAlignment: 'center'},  {lookupDisplay: true}, 'dropDown', {labelField: "ACCOUNT_NM"});
//     addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},         130,            'text',           {textAlignment:"near"});
    addField(cm,    'CCTR_CD',              {text:'관리코스트센터'},         90,            'text',           {textAlignment:"center"});
//     addField(cm,    'CCTR_NM',              {text:'관리코스트센터명'},         100,            'text',           {textAlignment:"near"});
//     addField(cm,    'CODEMAPPING2',         {text: ' '},             20,     'popupLink');
    
    addField(cm,    'WK_M01',               {text:'1월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},           80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},          80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},          80,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},          80,            'integer',           {textAlignment:"far"});
    addField(cm,    'TOTAL',                {text:'합계'},          100,            'integer',           {textAlignment:"far"}, {editable : false});
    addField(cm,    'ERROR_YN',           {text:'에러여부'},       60,            'text',              {textAlignment:"center"}, {editable : false});
    addField(cm,    'REMARK',               {text:'에러내역'},           300,            'text',           {textAlignment:"near"}, {editable : false});
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',              {text: '기준년도'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',               {text: '상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BELONG_CCTR_CD',       {text: '귀속코스트'},       0,     'text', {textAlignment: "center"},{visible:false});

	addField(cm,    'STATUS_NM',            {text:'상태'},         60,            'text',              {textAlignment:"center"},{visible:false});
 	addField(cm ,   'CLAUSE_CD',            {text:'항목코드'},         120,            'text',              {textAlignment: 'center'},{visible:false});
 	addField(cm,    'LEVEL_CD',             {text:'레벨'},         100,            'text',           {textAlignment:"center"},{visible:false});
    addField(cm,    'ITEM_DESC',            {text:'품목명'},        120,            'text',           {textAlignment:"near"},{visible:false});
    
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
    //합계 자동 계산
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

function setInitGridData() {
    var gridId = "gridData";
    gridData = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ITEM_CD',              {text:'품목코드'},         120,            'text',           {textAlignment:"center"});
    addField(cm ,   'DISTRIB_CD',           {text:'유통코드'},         80,            'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:distibCdCodes, labels:distibCdLabels}, 'dropDown');
    addField(cm ,   'ACCOUNT_NO',           {text:'계정코드'},         150,            'text',              {textAlignment: 'center'},  {lookupDisplay: true}, 'dropDown', {labelField: "ACCOUNT_NM"});
    addField(cm,    'CCTR_CD',              {text:'관리코스트센터'},         150,            'text',           {textAlignment:"center"});
    
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
    
    gridData.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
}

function setInitGridCode1() {
    var gridId = "gridCode1";
    gridCode1 = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ITEM_CD',              {text:'품목코드'},           150,            'text',           {textAlignment:"center"});
    addField(cm,    'ITEM_DESC',            {text:'품목코드명'},           150,            'text',          {textAlignment:"near"});

    gridCode1.rgrid({
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
	
}

function setInitGridCode2() {
    var gridId = "gridCode2";
    gridCode2 = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'CODE',              {text:'코드'},           150,            'text',           {textAlignment:"center"});
    addField(cm,    'CODE_NM',              {text:'코드명'},           150,            'text',           {textAlignment:"near"});

    gridCode2.rgrid({
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
	
}

function setInitGridCode3() {
    var gridId = "gridCode3";
    gridCode3 = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'CLAUSE_NM',            {text:'항목명'},           150,            'text',           {textAlignment:"center"});
    addField(cm,    'CODE',                 {text:'코드'},           150,            'text',           {textAlignment:"center"});
    addField(cm,    'CODE_NM',              {text:'코드명'},           150,            'text',           {textAlignment:"near"});

    gridCode3.rgrid({
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
	
}

function setInitGridCode4() {
    var gridId = "gridCode4";
    gridCode4 = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'CCTR_CD',              {text:'코드'},           150,            'text',           {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코드명'},           150,            'text',           {textAlignment:"near"});

    gridCode4.rgrid({
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
	
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectOpBasicMgtExcel');
}

/**
 * 조회
 */
function fnSearchCode() {
	// 조회 요청
	searchCall(gridData,  '/com/bdg/selectOpBasicMgtData' , 'fnGridData');
	searchCall(gridCode1, '/com/bdg/selectOpBasicMgtCode1', 'fnGridCode1');
	searchCall(gridCode2, '/com/bdg/selectOpBasicMgtCode2', 'fnGridCode2');
	searchCall(gridCode3, '/com/bdg/selectOpBasicMgtCode3', 'fnGridCode3');
	searchCall(gridCode4, '/com/bdg/selectOpBasicMgtCode4', 'fnGridCode4');
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
    
	if(isEmpty(data.rows)){
		fnRowAdd();
	}
}


/**
 * 조회 후 처리
 */
function fnGridDataSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridData.clearRows();
	// gridData 데이터 setting
    gridData.setPageRows(data);
    // 상태바 비활성화
    gridData.closeProgress();
}

/**
 * 조회 후 처리
 */
function fnGridCode1Success(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridCode1.clearRows();
	// 그리고 데이터 setting
    gridCode1.setPageRows(data);
    // 상태바 비활성화
    gridCode1.closeProgress();
}

/**
 * 조회 후 처리
 */
function fnGridCode2Success(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridCode2.clearRows();
	// 그리고 데이터 setting
    gridCode2.setPageRows(data);
    // 상태바 비활성화
    gridCode2.closeProgress();
}

/**
 * 조회 후 처리
 */
function fnGridCode3Success(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridCode3.clearRows();
	// 그리고 데이터 setting
    gridCode3.setPageRows(data);
    // 상태바 비활성화
    gridCode3.closeProgress();
}

/**
 * 조회 후 처리
 */
function fnGridCode4Success(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridCode4.clearRows();
	// 그리고 데이터 setting
    gridCode4.setPageRows(data);
    // 상태바 비활성화
    gridCode4.closeProgress();
}

//행추가
function fnRowAdd() {
	var values = { 
				   "CRUD" : "I" 
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YY" : $('#TB_CRTN_YY').val().replaceAll('-', '')
	              ,"BELONG_CCTR_CD" : $('#SB_BELONG_CCTR_CD').val()
	              };
	
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

/**
 * 저장
 */
function fnSave() {
	gridView.setAllCheck(true);
	gridView.checkAll(true,false);
	gridView.commit();

	// 필수 체크 대상(그리드)
	var requiredVal   = ["CCTR_CD", "ITEM_CD", "DISTRIB_CD", "ACCOUNT_NO"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
			var params = {};
			$.extend(params, fnGetParams());
			$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
			
			saveCall(gridView, '/com/bdg/saveOpBasicMgtExcel', 'fnSave', params);
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

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

/**
 * 업로드
 */
 function fnUpload() {
	gridView.setAllCheck(true);
	gridView.checkAll(true,false);
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN"      : "SA"});
	$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
	
	for(var i = 0; i < params.ITEM_LIST.CHECK_LIST.length; i++){
		if(params.ITEM_LIST.CHECK_LIST[i].ERROR_YN == 'Y'){
			alert("에러내역이 존재합니다.\n에러내역를 확인하시고 업로드를 진행해주세요.");
			return false;
		}
		
		if(isEmpty(params.ITEM_LIST.CHECK_LIST[i].ERROR_YN)){
			alert("신규데이터가 존재합니다. 저장 후 업로드 해주세요.");
			return false;
		}

	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_ORG_CD", "REQ_SABUN"];
	
	// 필수 체크 후 업로드 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("업로드 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveOpBasicMgt', 'fnUpload', params);
	     }
	}
}

 /**
 * 삭제 성공
 */
function fnUploadSuccess(result) {
	alert("업로드 성공하였습니다.");
	close();
	parentCallback('fnSearch');
}

/**
 * 삭제 실패
 */
function fnUploadFail(result) {
	alert(result.errMsg);
}	


//행삭제
function fnRowDel() {
	fnCheckRowDelete(gridView);
}

//양식지 다운로드
function fnDownLoad() {
	
	RealGridJS.exportGrid({
        type:"excel",
        target:"local",
        fileName:"경영기본예산신청"+fn_getCurrentTime()+".xlsx",
        compatibility: "2010",
        exportGrids:[
        {
         grid:gridData,
         sheetName:"업로드데이터" // 다른 그리드와 중복되어서는 안된다.
        },
        {
         grid:gridCode1,
         sheetName:"품목정보" // 다른 그리드와 중복되어서는 안된다.
        },
        {
         grid:gridCode2,
         sheetName:"유통정보"
        },
        { 
         grid:gridCode3,
         sheetName:"계정정보"
        },
        { 
         grid:gridCode4,
         sheetName:"코스트센터"
        }
      ]
	});
	
}

/**
 * 양식지 업로드 버튼 클릭 시 이벤트
 */
function fnAttFile() {
    var fileParams = {KEY_ID: 'APP_SEQ' // required 연관 파일 키
                     ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
                     };
    openFileUplaod(fileParams);
}

/**
 * 첨부파일 버튼 클릭 시 이벤트
 */
 function fnInitFileUpload() {
    if ($("#APP_SEQ").val() != "") 
        displayFileUpload({
            KEY_ID      : 'APP_SEQ',
            DATA_FORMAT : 'outTable',
            CALLBACK    : 'fnFileUploadCallback'
        });
}

 /**
  * 첨부파일멀티용 CALL BACK
  */
function fnFileUploadCallback(data) {
    $('.upload-list').empty().html(data);
}
 


</script>
    <form name="downForm" target="dowmloadFilePop">
		<input type="hidden" id="APP_SEQ" name="APP_SEQ" value="<c:out value="${dataInfo.ATTACHMENT }" />" />
		<input type="hidden" id="ATTACH_SEQ" name="ATTACH_SEQ" value="<c:out value="${dataInfo.ATTACH_SEQ }" />" />
    </form>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
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
                <col style="width:110px">
                <col style="width:440px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
                    	<input type="number" id="TB_CRTN_YY"  style="text-align: right; width: 50px; text-align: center" disabled="disabled">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_BELONG_CCTR_CD" name="SB_BELONG_CCTR_CD" disabled="disabled">
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
<!--         <button type="button" class="btn" id="btnAttFile">양식지업로드</button> -->
        <button type="button" class="btn" id="btnDownLoad">양식지다운로드</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnSave">저장</button>
        <button type="button" class="btn" id="btnUpload">업로드</button>
    </div>
</div>
<div class="realgrid-area">
	<div id="gridView"></div>
</div>
<div class="realgrid-area" hidden="true">
	<div id="gridData"></div>
</div>
<div class="realgrid-area" hidden="true">
    <div id="gridCode1"></div> 
</div>
<div class="realgrid-area" hidden="true">
    <div id="gridCode2"></div> 
</div>
<div class="realgrid-area" hidden="true">
    <div id="gridCode3"></div> 
</div>
<div class="realgrid-area" hidden="true">
    <div id="gridCode4"></div> 
</div>