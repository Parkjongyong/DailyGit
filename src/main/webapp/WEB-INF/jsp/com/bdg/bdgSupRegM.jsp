<%--
	File Name : bdgSupRegM.jsp
	Description:예산 > 부가정보 > 공급업체관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.14  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.09.14
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var statusCodes  = new Array();
var statusLabels = new Array();

var createGubn = "";

var relateCompanyCodes  = new Array();
var relateCompanyLabels = new Array();

var bpTypeCompanyCodes  = new Array();
var bpTypeCompanyLabels = new Array();

$(document).ready(function() {
    // 개별코드 생성(그리드용)
	var compList          = stringToArray("${CODELIST_SYS001}","ALL");
	var statusList        = stringToArray("${CODELIST_YS013}");
	var bpTypeList        = stringToArray("${CODELIST_YS017}");
	var accountGroupList  = stringToArray("${CODELIST_YS018}");
	var payCondList       = stringToArray("${CODELIST_YS019}");
	var reconAccountList  = stringToArray("${CODELIST_YS020}");
	var vendorAccountList = stringToArray("${CODELIST_YS022}");

	statusCodes  = getComboSet('${CODELIST_YS023}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS023}', 'CODE_NM');
	
	relateCompanyCodes  = getComboSet('${CODELIST_SYS001}', 'CODE');
	relateCompanyLabels = getComboSet('${CODELIST_SYS001}', 'CODE_NM');
	
	bpTypeCompanyCodes  = getComboSet('${CODELIST_YS017}', 'CODE');
	bpTypeCompanyLabels = getComboSet('${CODELIST_YS017}', 'CODE_NM');
	
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");	
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_BP_TYPE',             bpTypeList,     'CODE', 'CODE_NM');
	fnMakeComboOption('SB_ACCOUNT_GROUP', accountGroupList,     'CODE', 'CODE_NM');
	fnMakeComboOption('SB_PAY_COND',           payCondList,     'CODE', 'CODE_NM');
	fnMakeComboOption('SB_RECON_ACCOUNT', reconAccountList,     'CODE', 'CODE_NM');
	fnMakeComboOption('SB_VENDOR_ACCOUNT',vendorAccountList,    'CODE', 'CODE_NM');
	fnMakeComboOption('SB_RELATE_COMPANY', compList,     'CODE', 'CODE_NM');
	
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_DEPT_NM").val('${LOGIN_INFO.DEPT_NM}');
	$("#TB_DEPT_CD").val('${LOGIN_INFO.DEPT_CD}');
	//$("#TB_START_DT").val(firstDayByMonth(getDiffDay("m",0)));	
	//$("#TB_END_DT").val(firstDayByMonth(getDiffDay("m",1)));
	$("#TB_START_DT").val(getDiffDay("m",-1));
	$("#TB_END_DT").val(getDiffDay("m",0));
	$("#TB_CRTN_YMD").val(getDiffDay("m",0));
	$("#SB_STATUS").val('2');	

	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    $('#POBUSI_NO').off();
    
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#TB_POBUSI_NO").val("");
	$("#TB_VENDOR_NM").val("");
	$("#TB_PRESIDENT_NM").val("");
	$("#TB_ZIP_NO").val("");
	$("#TB_ADDR_HEAD").val("");
	$("#TB_ADDR_DETAIL").val("");
	$("#TB_TEL_NO").val("");
	$("#TB_FAX_NO").val("");
	$("#TB_EMAIL").val("");
	$("#TB_BUSS_TYPE").val("");
	$("#TB_BUSIN").val("");
	$("#TB_FILE_ATTACH").val("");
	$("#SB_RELATE_COMPANY").val($("#SB_COMP_CD").val());

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
	
}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    addField(cm,    'STATUS',               {text: '진행상태'},       60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'CRTN_YMD',             {text: '신청일자'},      60,     'text', {textAlignment: 'center'});
    addField(cm,    'VENDOR_CD',            {text:'업체코드'},        60,            'text',              {textAlignment:"center"});
    addField(cm,    'POBUSI_NO',            {text:'사업자번호'},        80,            'textLink',           {textAlignment:"center"});
    addField(cm,    'VENDOR_NM',            {text:'업체명'},        100,            'text',           {textAlignment:"near"});
    addField(cm,    'PRESIDENT_NM',         {text:'대표자명'},      60,            'text',           {textAlignment:"center"});
    addField(cm,    'BP_TYPE',              {text:'BP유형'},      80,            'text',           {textAlignment: "center"},{lookupDisplay: true, values:bpTypeCompanyCodes,labels:bpTypeCompanyLabels},'dropDown');
    
    addField(cm,    'RELATE_COMPANY',       {text:'관계사'},      100,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:relateCompanyCodes,labels:relateCompanyLabels},'dropDown');
    addField(cm,    'BUSS_TYPE',            {text:'업종'},        80,    'text',           {textAlignment:"center"});
    addField(cm,    'BUSIN',                {text:'업태'},        80,            'text',              {textAlignment: "center"});
    addField(cm,    'ADDR_HEAD',            {text:'주소'},        160,            'text',           {textAlignment:"center"});
    addField(cm,    'RETURN_DESC',          {text:'반려사유'},      120,            'text',           {textAlignment:"center"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'VENDOR_NM',            {text: '업체명'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ACCOUNT_GROUP',        {text: '계정그룹'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'ZIP_NO',               {text: '우편번호'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ADDR_DETAIL',          {text: '상세주소'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'TEL_NO',               {text: '전화번호'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'FAX_NO',               {text: '팩스번호'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'EMAIL',                {text: 'Email'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'RECON_ACCOUNT',        {text: '조정계정'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PAY_COND',             {text: '지급조건'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PAY_WAY',              {text: '지급방법'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'VENDOR_ACCOUNT',       {text: '공급업체계정'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'FILE_ATTACH',          {text: '첨부파일'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP전송여부'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'FILE_NM',              {text: '파일이름'},      0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 300       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });


    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	
    	document.getElementById("chk01").checked = false;
    	document.getElementById("chk02").checked = false;
    	document.getElementById("chk03").checked = false;
    	document.getElementById("chk04").checked = false;
    	document.getElementById("chk05").checked = false;
    	document.getElementById("chk06").checked = false;
    	
    	grid.setAllCheck(false);
    	grid.checkAll(false,false);
    	grid.checkItem(colIndex.itemIndex, true);
    	
    	createGubn = "";
    	
    	var gridView = grid.getDataProvider();
    	$("#TB_POBUSI_NO").val(gridView.getValue(colIndex.itemIndex,"POBUSI_NO"));
    	$("#TB_VENDOR_CD").val(gridView.getValue(colIndex.itemIndex,"VENDOR_CD"));
    	$("#TB_VENDOR_NM").val(gridView.getValue(colIndex.itemIndex,"VENDOR_NM"));
    	$("#TB_PRESIDENT_NM").val(gridView.getValue(colIndex.itemIndex,"PRESIDENT_NM"));
    	$("#SB_ACCOUNT_GROUP").val(gridView.getValue(colIndex.itemIndex,"ACCOUNT_GROUP"));
    	$("#TB_ZIP_NO").val(gridView.getValue(colIndex.itemIndex,"ZIP_NO"));
    	$("#TB_ADDR_HEAD").val(gridView.getValue(colIndex.itemIndex,"ADDR_HEAD"));
    	$("#TB_ADDR_DETAIL").val(gridView.getValue(colIndex.itemIndex,"ADDR_DETAIL"));
    	$("#TB_TEL_NO").val(gridView.getValue(colIndex.itemIndex,"TEL_NO"));
    	$("#TB_FAX_NO").val(gridView.getValue(colIndex.itemIndex,"FAX_NO"));
    	$("#TB_EMAIL").val(gridView.getValue(colIndex.itemIndex,"EMAIL"));
    	$("#SB_RELATE_COMPANY").val(gridView.getValue(colIndex.itemIndex,"RELATE_COMPANY"));
    	$("#SB_BP_TYPE").val(gridView.getValue(colIndex.itemIndex,"BP_TYPE"));
    	$("#TB_BUSS_TYPE").val(gridView.getValue(colIndex.itemIndex,"BUSS_TYPE"));
    	$("#TB_BUSIN").val(gridView.getValue(colIndex.itemIndex,"BUSIN"));
    	$("#SB_RECON_ACCOUNT").val(gridView.getValue(colIndex.itemIndex,"RECON_ACCOUNT"));
    	$("#SB_PAY_COND").val(gridView.getValue(colIndex.itemIndex,"PAY_COND"));
    	$("#SB_VENDOR_ACCOUNT").val(gridView.getValue(colIndex.itemIndex,"VENDOR_ACCOUNT"));
    	$("#TB_FILE_ATTACH").val(gridView.getValue(colIndex.itemIndex,"FILE_NM"));
    	
    	if(gridView.getValue(colIndex.itemIndex,"PAY_WAY").indexOf("C") > -1){
    		document.getElementById("chk01").checked = true;
    	}
    	
    	if(gridView.getValue(colIndex.itemIndex,"PAY_WAY").indexOf("E") > -1){
    		document.getElementById("chk02").checked = true;
    	}
    	
    	if(gridView.getValue(colIndex.itemIndex,"PAY_WAY").indexOf("X") > -1){
    		document.getElementById("chk03").checked = true;
    	}
    	
    	if(gridView.getValue(colIndex.itemIndex,"PAY_WAY").indexOf("Y") > -1){
    		document.getElementById("chk04").checked = true;
    	}
    	
    	if (gridView.getValue(colIndex.itemIndex,"PAY_WAY").indexOf("T") > -1){
    		document.getElementById("chk05").checked = true;
    	}
    	
    	if (gridView.getValue(colIndex.itemIndex,"PAY_WAY").indexOf("W") > -1){
    		document.getElementById("chk06").checked = true;
    	} 
    	
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };        
    
    setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
    
}


/**
 * 조회
 */
function fnSearch() {
	fnInitStatus();
	createGubn = "";
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectSupReg');
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
 * 저장
 */
function fnSave() {
	
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
	
	if (createGubn == "new") {
		if(gridView.getCheckedItems(false).length == 0){
			if(isEmpty($("#SB_COMP_CD").val()) == true){
				alert("신규 추가 시 회사는 필수선택입니다.");
				return false;
			}
		}		
	} else {
		if(gridView.getCheckedItems(false).length > 1){
			alert("한건씩만  저장 가능합니다.");
			return false;
		}
		
// 		for(var i = 0; i < params.ITEM_LIST.CHECK_LIST.length; i++){
// 			if(params.ITEM_LIST.CHECK_LIST[i].STATUS == '1' || params.ITEM_LIST.CHECK_LIST[i].STATUS == '3'){
// 				continue;
// 			} else {
// 				alert("작성중 상태에서만 저장 가능합니다.");
// 				return false;				
// 			}
// 		}		
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["TB_POBUSI_NO", "TB_VENDOR_NM", "TB_PRESIDENT_NM", "SB_ACCOUNT_GROUP", "SB_BP_TYPE", "TB_BUSS_TYPE", "TB_BUSIN", "SB_RECON_ACCOUNT", "SB_PAY_COND", "TB_ADDR_HEAD", "TB_ADDR_DETAIL"];
	
	// 필수 체크 후 저장 진행
	if(fnValidationCheckForm(requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveSupReg', null, params);
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
	
// 	for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
// 		if(params.ITEM_LIST.DELETED[i].STATUS != '1'){
// 			alert("저장 상태만 삭제 가능합니다.");
// 			return false;
// 		}
// 	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delSupReg', 'fnDel', params);
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
	$("#TB_DEPT_CD").val(rows.DEPT_CD);
	$("#TB_DEPT_NM").val(rows.DEPT_NM);
}

//SAP 전송
 var fnSap = function(){
 	gridView.commit();
 	var params = {};
 	$.extend(params, fnGetParams());
 	$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
 	
 	if(isEmpty(params.ITEM_LIST.CHECK_LIST) == true){
 		alert("체크된 데이터가 없습니다.");
 		return false;
 	} 	
 	
     if(confirm("전송 하시겠습니까?")){
     	saveCall(gridView, '/com/bdg/sendSapSupReg', 'fnSap', params);
     }
 	
 }

 function fnSapSuccess(data) {
 	alert("SAP전송 되었습니다.");
 }

 function fnSapFail(result) {
	 alert(result.errMsg);
 }

//반려
 var fnReject = function(){
	gridView.commit();
 	var params = {};
 	$.extend(params, fnGetParams());
 	$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
 	
 	if(isEmpty(params.ITEM_LIST.CHECK_LIST) == true){
 		alert("체크된 데이터가 없습니다.");
 		return false;
 	}
 	
	for(var i = 0; i < params.ITEM_LIST.CHECK_LIST.length; i++){
		if(params.ITEM_LIST.CHECK_LIST[i].STATUS != '2'){
			alert("신청 상태만 반려가능합니다.");
			return false;
		}
	}
 	
 	
     if(confirm("반려 하시겠습니까?")){
     	saveCall(gridView, '/com/bdg/returnSupReg', 'fnReject', params);
     }
 	
 }

 function fnRejectSuccess(data) {
 	alert("반려 되었습니다.");
 	fnSearch();

 }

 function fnRejectFail(result) {
	 alert(result.errMsg);
 }

 
 /**
  * 신규작성
  */
 function fnNewData() {
	 var pobusiNo = $('#TB_POBUSI_NO').val().replace("-", "").replace("-", "");
	 $('#POBUSI_NO').val(pobusiNo);
     gridView.setAllCheck(false);
	 gridView.checkAll(false,false);
	 $("#pobusi_dialog").dialog( "open" );
 }	

 /**
  * 사업자번호 확인
  */
 function fnPobusiNo() {
	var params = {};
	$.extend(params, fnGetParams());
	var pobusiNo = $('#POBUSI_NO').val().replace("-", "").replace("-", "");
	if (pobusiNo.length != 10) {
		alert("사업자 번호는 10자리만 입력 가능합니다. 확인 후 작업하세요.");
	 	return false;
	}	
	$('#TB_POBUSI_NO').val(pobusiNo);
	$('#POBUSI_NO').val(pobusiNo);
	searchCall(gridView, '/com/bdg/selectPobusiNo', 'fnPobusiNo', params);
 }
 
 /**
  * 조회 후 처리
  */
 function fnPobusiNoSuccess(data) {
	 
	 createGubn = "new";
	 
 	// 에러메세지 처리
 	if(isEmpty(data.fields.headMap) == true){
 		$('#SB_RELATE_COMPANY').val($('#SB_COMP_CD').val());
 		alert("해당 사업자번호로 SAP에 등록된 정보가 존재하지 않습니다. 신규 추가하십시오.");
 		return false;
 	} else {
 		
 		if(isNotEmpty(data.fields.headMap.LIFNR)) {
 			$('#TB_VENDOR_CD').val(data.fields.headMap.LIFNR); //공급업체명
 		} else {
 	 		alert("해당 사업자번호로 SAP에 등록된 정보가 존재하지 않습니다. 신규 추가하십시오.");
 	 		return false; 			
 		}
 		
 		// TB_PRESIDENT_NM 
 		if(isNotEmpty(data.fields.headMap.REPRESN)) {
 			$('#TB_PRESIDENT_NM').val(data.fields.headMap.REPRESN); //대표자명
 		}
 		
 		if(isNotEmpty(data.fields.headMap.NAME1)) {
 			$('#TB_VENDOR_NM').val(data.fields.headMap.NAME1); //공급업체명
 		}
 		if(isNotEmpty(data.fields.headMap.KTOKK)) {
 			$('#SB_ACCOUNT_GROUP').val(data.fields.headMap.KTOKK); //계정그룹
 		}
 		if(isNotEmpty(data.fields.headMap.PSTLZ)) {
 			$('#TB_ZIP_NO').val(data.fields.headMap.PSTLZ); //우편번호
 		}
 		if(isNotEmpty(data.fields.headMap.ORT01)) {
 			$('#TB_ADDR_HEAD').val(data.fields.headMap.ORT01); //주소
 		}
 		if(isNotEmpty(data.fields.headMap.STRAS)) {
 			$('#TB_ADDR_DETAIL').val(data.fields.headMap.STRAS); //상세주소
 		}
 		if(isNotEmpty(data.fields.headMap.TELF1)) {
 			$('#TB_TEL_NO').val(data.fields.headMap.TELF1); //전화번호
 		}
 		if(isNotEmpty(data.fields.headMap.TELFX)) {
 			$('#TB_FAX_NO').val(data.fields.headMap.TELFX); //FAX NO
 		}
 		if(isNotEmpty(data.fields.headMap.SMTP_ADDR)) {
 			$('#TB_EMAIL').val(data.fields.headMap.SMTP_ADDR); //EMAIL
 		}
 		if(isNotEmpty(data.fields.headMap.VBUND)) {
 			$('#SB_RELATE_COMPANY').val(data.fields.headMap.VBUND); //관계사
 		} else {
 			$('#SB_RELATE_COMPANY').val($('#SB_COMP_CD').val());
 		}
 		if(isNotEmpty(data.fields.headMap.BPKIND)) {
 			$('#SB_BP_TYPE').val(data.fields.headMap.BPKIND); //BP유형
 		}
 		if(isNotEmpty(data.fields.headMap.GESTYPN)) {
 			$('#TB_BUSS_TYPE').val(data.fields.headMap.GESTYPN); //업종
 		}
 		if(isNotEmpty(data.fields.headMap.INDTYPN)) {
 			$('#TB_BUSIN').val(data.fields.headMap.INDTYPN); //업태
 		}
 		if(isNotEmpty(data.fields.headMap.AKONT)) {
 			$('#SB_RECON_ACCOUNT').val(data.fields.headMap.AKONT); //조정계정
 		}
 		if(isNotEmpty(data.fields.headMap.ZTERM)) {
 			$('#SB_PAY_COND').val(data.fields.headMap.ZTERM); //지급조건
 		}
 		if(isNotEmpty(data.fields.headMap.ZWELS)) { // 지급방법
 	    	if(data.fields.headMap.ZWELS.indexOf("C") > -1){
 	    		document.getElementById("chk01").checked = true;
 	    	}
 	    	if(data.fields.headMap.ZWELS.indexOf("E") > -1){
 	    		document.getElementById("chk02").checked = true;
 	    	}
 	    	
 	    	if(data.fields.headMap.ZWELS.indexOf("X") > -1){
 	    		document.getElementById("chk03").checked = true;
 	    	}
 	    	
 	    	if(data.fields.headMap.ZWELS.indexOf("Y") > -1){
 	    		document.getElementById("chk04").checked = true;
 	    	}
 	    	
 	    	if (data.fields.headMap.ZWELS.indexOf("T") > -1){
 	    		document.getElementById("chk05").checked = true;
 	    	}
 	    	
 	    	if (data.fields.headMap.ZWELS.indexOf("W") > -1){
 	    		document.getElementById("chk06").checked = true;
 	    	}  			
 		} 		
 		if(isNotEmpty(data.fields.headMap.EIKTO)) {
 			$('#SB_VENDOR_ACCOUNT').val(data.fields.headMap.EIKTO); //공급업체계정
 		} 		
 	}
 	$("#pobusi_dialog").dialog( "close" );

 }


 /**
  * 첨부파일 버튼 클릭 시 이벤트
  */
 function fnAttFile() {
 	var checkArray = fnGetDeleteData(gridView);
 	if(isEmpty(checkArray) == true){
 		alert("체크된 데이터가 없습니다.");
 		return false;
 	}
 	
 	if(checkArray.DELETED.length > 1){
 		alert("한건씩만 가능합니다.");
 		return false;
 	}
 	
 	 $("#APP_SEQ").val(checkArray.DELETED[0].FILE_ATTACH); 
     var fileParams = {KEY_ID: 'APP_SEQ' // required 연관 파일 키
                      ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
                      };
     openFileUplaod(fileParams);
 }
 
 /**
  * 첨부파일멀티용 시작
  */
 function fnInitFileUpload() {
     if ($("#APP_SEQ").val() != "") 
     	// 첨부파일 활성화
         displayFileUpload({
             KEY_ID      : 'APP_SEQ',
             DATA_FORMAT : 'outTable',
             CALLBACK    : 'fnFileUploadCallback'
         });
 };

 /**
  * 첨부파일멀티용 CALL BACK
  */
 function fnFileUploadCallback(data) {
     $('.upload-list').empty().html(data);
 };
 
//부서 리셋
 function fnDeptReset() {
 	$("#TB_DEPT_NM").val("");
 	$("#TB_DEPT_CD").val("");
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD"></select>
                    </td>
                    <th><span class="stit">신청일자</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DT" dateHolder="end" value=""/>
                        
                    </td>
                    <th><span>부서</span></th>
                    <td>
                        <input type="text"   id="TB_DEPT_NM" disabled>
                        <input type="hidden" id="TB_DEPT_CD">
                        <a href="javascript:fnSearchDept('condition');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						<a href="javascript:fnDeptReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>                        
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>진행상태</span></th>
                    <td>
	                    <select id="SB_STATUS" name="SB_STATUS"></select>
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
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnSap">SAP전송</button>
        <button type="button" class="btn" id="btnNewData">신규작성</button>
        <button type="button" class="btn" id="btnReject">반려</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>

<div class="tit-area">
    <h3>상세내역</h3>
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:130px">
                <col style="width:420px">
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th ><span>사업자번호</span></th>
                    <td colspan="3">
<!--                         <input type="text"   id="TB_POBUSI_NO" name="사업자번호" disabled> -->
                        <input type="text"   id="TB_POBUSI_NO" name="사업자번호">
                        <a href="javascript:fnNewData();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <th><span>업체명</span></th>
                    <td>
                        <input type="text"   id="TB_VENDOR_NM" name="업체명">
                        <input type="hidden"   id="TB_VENDOR_CD" name="업체코드">
                    </td>
                    <th><span>대표자</span></th>
                    <td>
                        <input type="text"   id="TB_PRESIDENT_NM" name="대표자">
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <th><span>계정그룹</span></th>
                    <td>
                    	<select id="SB_ACCOUNT_GROUP" name="계정그룹" disabled></select>
                    </td>
                    <th><span>우편번호</span></th>
                    <td>
                        <input type="text"   id="TB_ZIP_NO">
                    </td>
                    <th><span>주소</span></th>
                    <td>
                        <input type="text"   id="TB_ADDR_HEAD" name="주소" style="width: 90%;">
                    </td>
                    <th><span>상세주소</span></th>
                    <td>
                        <input type="text"   id="TB_ADDR_DETAIL" name="상세주소" style="width: 90%;">
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <th><span>전화번호</span></th>
                    <td>
                    	<input type="text"   id="TB_TEL_NO">
                    </td>
                    <th><span>팩스번호</span></th>
                    <td>
                        <input type="text"   id="TB_FAX_NO">
                    </td>
                    <th><span>Email</span></th>
                    <td>
                        <input type="text"   id="TB_EMAIL" name="Email" style="width: 90%;">
                    </td>
                    <td></td>
                    <td></td>
                </tr>

                <tr>
                    <th><span>관계사</span></th>
                    <td>
                    	<select id="SB_RELATE_COMPANY" name="관계사"></select>
                    </td>
                    <th><span>BP유형</span></th>
                    <td>
                        <select id="SB_BP_TYPE" name="BP유형"></select>
                    </td>
                    <th><span>업종</span></th>
                    <td>
                        <input type="text"   id="TB_BUSS_TYPE" name="업종">
                    </td>
                    <th><span>업태</span></th>
                    <td>
                        <input type="text"   id="TB_BUSIN" name="업태">
                    </td>
                    <td></td>
                </tr>

                <tr>
                    <th><span>조정계정</span></th>
                    <td>
                    	<select id="SB_RECON_ACCOUNT" name="조정계정" disabled></select>
                    </td>
                    <th><span>지급조건</span></th>
                    <td>
                        <select id="SB_PAY_COND" name="지급조건"></select>
                    </td>
                    <th><span>지급방법</span></th>
					<td colspan="3">
						<label for="chk01" class="chk"><input id="chk01" type="checkbox">법인카드</label>
						<label for="chk02" class="chk"><input id="chk02" type="checkbox">개인법인카드</label>
						<label for="chk03" class="chk"><input id="chk03" type="checkbox">하나은행구매론</label>
						<label for="chk04" class="chk"><input id="chk04" type="checkbox">하나은행동반성장론</label>
						<label for="chk05" class="chk"><input id="chk05" type="checkbox">수취계좌이체</label>
						<label for="chk06" class="chk"><input id="chk06" type="checkbox">전자어음</label>
                    </td>
                </tr>

                <tr>
                    <th><span>공급업체계정</span></th>
                    <td>
                    	<select id="SB_VENDOR_ACCOUNT" name="공급업체계정"></select>
                    </td>
                    <th><span>첨부</span></th>
                    <td colspan="2">
                        <input type="text"   id="TB_FILE_ATTACH" disabled="disabled">
                        <button type="button" class="btn" id="btnAttFile">파일추가</button>
<%--                         <span>&nbsp;※&nbsp; 파일추가는 저장 후 가능합니다.</span> --%>
                        <input type="hidden" id="APP_SEQ"  name="APP_SEQ"  value="">
                        <input type="hidden" id="TB_CRTN_YMD"  name="신청일자"  value="">
                    <td></td>
                    <td></td>
                </tr>

            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
</div><!-- // search_field_wrap -->
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