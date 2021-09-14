<%--
	File Name : wrhStockDueDateInfo.jsp
	Description: 입고예정 > 입고승인 > 입고예정정보
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.22  길용덕           최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.22
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.auto.js"></script>
<script type="text/javascript" src="<c:url value='/resources/js/html2canvas.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/jspdf.min.js'/>"></script>

<script type="text/javascript">
var gridView;
var gridPdf1;
var gridPdf2;
var gridPdf3;
var gridPdf4;
var gridPdf5;
var scrollItem   = 20;
var statusCodes  = new Array();
var statusLabels = new Array();
var useYnCodes   = new Array();
var useYnLabels  = new Array();
var gridParam    = {};

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');
    
	var compList  = stringToArray("${CODELIST_SYS001}","ALL","IPGO");
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', getComboValue(compList, "CODE", 0), "", "전체");
    fnCompCdChange();
	
	var statusList  = stringToArray("${CODELIST_IG}");
	fnMakeComboOption('SB_STAT_CD', statusList,     'CODE', 'CODE_NM', null, "","전체");

    statusCodes  = getComboSet('${CODELIST_IG007}', 'CODE');
    statusLabels = getComboSet('${CODELIST_IG007}', 'CODE_NM');
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    $("#pdfDiv1").hide();
    $("#pdfDiv2").hide();
    $("#pdfDiv3").hide();
    $("#pdfDiv4").hide();
    $("#pdfDiv5").hide();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	
	// 기간 시작인 셋팅
	$("#TB_START_DATE").val(getDiffDay("m",0));
	$("#TB_END_DATE").val(getDiffDay("m",3));
	
	$("#TB_VENDOR_CD").val('${LOGIN_INFO.VENDOR_CD}');
	$("#TB_VENDOR_NM").val('${LOGIN_INFO.VENDOR_NM}');		

}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'DOC_NO',                       {text:'문서번호'},                         60,     'textLink', {textAlignment: "center"});
    
    addField(cm,    'DOC_STATUS',                   {text: '진행상태'},                         60,     'text', {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels},'dropDown');
    
    addField(cm,    'GR_DELY_DATE',                 {text: '입고예정일'},                       60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'GR_DELY_DATE_OLD',             {text: '입고예정일'},                       60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'GR_DELY_TIME',                 {text: '입고예정시간'},                     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'GR_DATE_TIME',                 {text: '입고예정일시'},                     60,     'textLink', {textAlignment: "center", textWrap : "explicit"});
    
    addField(cm,    'VENDOR_CD',                    {text:'업체코드'},                          60,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_NM',                    {text:'업체명'},                            60,     'text', {textAlignment: "center"});

    addField(cm,    'LOCATION',                     {text:'입고장소'},                          60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'LOCATION_TXT',                 {text:'저장위치내역'},                     100,     'text', {textAlignment: "near"});
    
    addField(cm,    'GR_PERSON_NAME',               {text: '입고담당자'},                       60,     'text', {textAlignment: "center"});
    addField(cm,    'GR_PERSON_TEL',                {text: '연락처'},                          60,     'text', {textAlignment: "center"});
    
    addField(cm,    'COMP_NM',                      {text:'회사명'},                          60,     'text', {textAlignment: "center"});
    addField(cm,    'PLANT_NM',                     {text: '플랜트'},                           60,     'text', {textAlignment: "center"});
    addField(cm,    'VENDOR_DOC_TXT',               {text: '업체비고'},                         200,     'text', {textAlignment: "near"});
    
    addField(cm,    'APPROVE_DOC_TXT',              {text: '승인자비고'},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'LOC_RETURN_DESC',              {text: '물류반려사유'},                     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_RETURN_DESC',              {text: '구매반려사유'},                     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PO_ORG',                       {text:'구매조직(구매그룹)'},                60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PO_ORG_NM',                    {text:'구매그룹명'},                        60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                         {text: 'CRUD'},                           0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',                      {text: '회사코드'},                           0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PLANT_CODE',                   {text: '플랜트코드'},                           0,     'text', {textAlignment: 'center'},  {visible:false});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 480       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : false
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, item) {
    	var values = grid.getValues(item.itemIndex);
    	var Qty    = values.ITEM_QTY;
    	
        if (item.fieldName === "DOC_NO") {
        	if (gridView.getValue(item.itemIndex,"DOC_STATUS") == "1") {
        		fnStockDueDateRegistDetail(item);
        	} else {
        		fnSearchDetail(item);	
        	}
        }
        
        if (item.fieldName === "GR_DATE_TIME") {
        	fnSearchDelyDate(item);
        }        
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
}


/**
 * 입고예정일 팝업
 */
function fnSearchDelyDate(data) {
	var params = {};
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	$.extend(params, fnGetParams());
	var target    = "delyDateSearchPop";
	var width     = "600";
	var height    = "575";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhDelyDateSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 팝업 콜백
 */
function fnCallbackDelyDateSearchPop(rows) {
	var values = {
	         "GR_DELY_DATE"    : rows.DELY_DATE_GRID
	       , "GR_DELY_TIME"    : rows.DELY_TIME_GRID
	       , "GR_DATE_TIME"    : rows.DELY_DATE_TIME
	     };
	var docStatus = gridView.getValue(gridView.getCurrent().itemIndex,"DOC_STATUS");
	if (docStatus == "1" || docStatus == "3" || docStatus == "4") {
		gridView.setValues(gridView.getCurrent().itemIndex, values);
		gridView.checkItem(gridView.getCurrent().itemIndex, true);
	}
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectStockDueDateList');
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridView.clearRows();
	}
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
 * 입고예정등록 화면
 */
function fnStockDueDateRegistDetail(data) {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	
	
	var target    = "wrhStockDueDateRegistDetailV";
	var width     = "1400";
	var height    = "850";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhStockDueDateRegistDetailV', params, target, width, height, scrollbar, resizable);

}

/**
 * 입고예정상세
 */
function fnSearchDetail(data) {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
	
	var target    = "wrhStockDueDate";
	var width     = "1320";
	var height    = "780";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('wrhStockDueDate', params, target, width, height, scrollbar, resizable);

}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
    
    fnPlantCdChange();
}

/**
 * 플랜트 코드 변경 이벤트
 */
function fnPlantCdChange() {
    var StorageList = stringToArray("${CODELIST_SYSSTR}", $("#SB_COMP_CD").val(), $("#SB_PLANT_CD").val());
    fnMakeComboOption('SB_STORAGE_CD', StorageList, 'CODE', 'CODE_NM', "", "", "전체");
}

//저장
function fnSave() {
	// 그리드 수정사항 확정처리
	gridView.commit();
	
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	for(var i = 0; i < checkedRows.length; i++){
		if(   checkedRows[i].DOC_STATUS == "1" 
		   || checkedRows[i].DOC_STATUS == "3"
		   || checkedRows[i].DOC_STATUS == "4"){

		} else {
			alert("[작성중/물류반려/구매반려] 상태에서만 저장 가능합니다.");
			return false;
		}
	}
	
	var params = fnGetParams();
	
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["DOC_NO", "GR_DELY_DATE", "GR_DELY_TIME"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/saveDueDateInfo', null, params);
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
function fnDel() {
	
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	for(var i = 0; i < checkedRows.length; i++){
		if(   checkedRows[i].DOC_STATUS == "1" 
		   || checkedRows[i].DOC_STATUS == "3"
		   || checkedRows[i].DOC_STATUS == "4"){

		} else {
			alert("[작성중/물류반려/구매반려] 상태에서만 저장 가능합니다.");
			return false;
		}
	}
	
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/wrh/delDueDateInfo', null, params);
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
	gridView.closeProgress();
}




//승인요청
function fnRequest() {
	// 그리드 수정사항 확정처리
	gridView.commit();
	
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	for(var i = 0; i < checkedRows.length; i++){
		if(checkedRows[i].DOC_STATUS != "1"){
			alert("작성중 상태에서만 승인요청 가능합니다.");
			return false;
		}
	}
	
	var params = fnGetParams();
	
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["DOC_NO", "GR_DELY_DATE", "GR_DELY_TIME"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("승인요청 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/requestDueDateInfo', 'fnRequest', params);
	     }
	}
}

/**
 * 승인요청 성공
 */
function fnRequestSuccess(result) {
	alert("승인요청되었습니다.");
	
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 승인 요청 실패
 */
function fnRequestFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

//승인요청취소
function fnCancel() {
	// 그리드 수정사항 확정처리
	gridView.commit();
	
	// 그리드 수정사항 확정처리
	var checkedRows = gridView.getSelectedItems();
	for(var i = 0; i < checkedRows.length; i++){
		if(checkedRows[i].DOC_STATUS != "2"){
			alert("승인요청 상태에서만 승인요청취소 가능합니다.");
			return false;
		}
	}
	
	var params = fnGetParams();
	
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["DOC_NO", "GR_DELY_DATE", "GR_DELY_TIME"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("승인요청취소 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/cancelDueDateInfo', 'fnCancel', params);
	     }
	}
}

/**
 * 승인요청취소 성공
 */
function fnCancelSuccess(result) {
	alert("승인요청취소되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 승인 요청취소 실패
 */
function fnCancelFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

//거래명세표 생성
function fnCreate() {
	
	var params = {};
	var browser = checkBroswer();
	
	var checkedRows = gridView.getCheckedItems(false);
	
	if(isEmpty(checkedRows) == true){
		alert("데이터가 존재하지 않습니다.");
		return false;
	}
	
	if(checkedRows.length > 1){
		alert("한건씩만 가능합니다.");
		return false;
	}
	
	window.scrollTo(0,0);
	var curr  = gridView.getCurrent();
	var docNo = gridView.getValues(curr.itemIndex).DOC_NO;
	$("#DOC_NO").val(docNo);
	
	$.extend(params, fnGetParams());
	$.extend(params, {"START_NUM" : '1', "END_NUM" : '12'});
	
	searchCall(null, '/com/wrh/createPdf', 'fnCreate', params);
}

/**
 * 조회 후 처리
 */
function fnCreateSuccess(data) {
	$('#gridPdf1 > tbody').empty();
	if(isEmpty(data.rows)){
	} else {
		$("#pdfDiv1").show();
	    $("#A_POBUSI_NO1").text(data.rows[0].A_POBUSI_NO);         // 공급받는자 사업자번호
	    $("#A_COMP_NM1").text(data.rows[0].A_COMP_NM);             // 공급받는자 상호
	    $("#A_PRESIDENT_NM1").text(data.rows[0].A_PRESIDENT_NM);   // 공급받는자 성명
	    $("#B_POBUSI_NO1").text(data.rows[0].B_POBUSI_NO);         // 공급자 사업자번호
	    $("#B_COMP_NM1").text(data.rows[0].B_COMP_NM);             // 공급자 상호
	    $("#B_PRESIDENT_NM1").text(data.rows[0].B_PRESIDENT_NM);   // 공급자 성명
	    $("#GR_PERSON_NAME1").text(data.rows[0].GR_PERSON_NAME);   // 인수자
	    $("#APPROVE_DOC_TXLOCATION_TXT").text(data.rows[0].APPROVE_DOC_TXT); // 승인자 COMMENT
	    $("#DOC_NO1").text(data.rows[0].DOC_NO);                   // 문서번호
	    $("#LOCATION_TXT1").text(data.rows[0].LOCATION_TXT);                   // 입고장소
	    $("#GR_DELY_TIME1").text(data.rows[0].GR_DELY_TIME);                   // 입고일시
	    $("#GR_PERSON_NAME1").text(data.rows[0].GR_PERSON_NAME);                   // 입고담당자
	    $("#GR_PERSON_TEL1").text(data.rows[0].GR_PERSON_TEL);                   // 연락처
	    
	    if(data.rows[0].CNT > 12){
	    	var params = {};
	    	$.extend(params, fnGetParams());
	    	$.extend(params, {"START_NUM" : '13', "END_NUM" : '24'});
	    	searchCall(gridPdf2, '/com/wrh/createPdf', 'fnCreate2', params);
	    } else {
	    	if(data.rows.length > 0){
	    		var html = '';
	            $.each(data.rows, function(idx, vo) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center">'+ vo.PO_NUMBER  +'</td>';
	                html +=     '<td align="center">'+ vo.PO_SEQ  +'</td>';
	                html +=     '<td align="center">'+ vo.MAT_NUMBER  +'</td>';
	                html +=     '<td align="left">'+ vo.MAT_DESC  +'</td>';
	                html +=     '<td align="center">'+ vo.UNIT_MEASURE  +'</td>';
	                html +=     '<td align="right">'+ vo.PO_ITEM_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.UNIT_PRICE  +'</td>';
	                html +=     '<td align="right">'+ vo.AMOUNT  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_LOT_NO  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_DATE  +'</td>';
	                html +=     '<td align="center">'+ vo.USE_BY_DATE  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_SUM  +'</td>';
	                html +=     '<td align="right">'+ vo.PLT_QTY  +'</td>';
	                html += '</tr>';
	            });
	            
	            // 공백채우기
	            for (var emptyRow=0; emptyRow < (12 - data.rows.length); emptyRow++) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="left"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html += '</tr>';	            	
	            }
	            $('#gridPdf1 > tbody:last').append(html);
	    	}
	    	
	        setTimeout(function(){
	        	fnCreatePdf1();
	        }, 2000)
	    }

	}

}

/**
 * 조회 후 처리
 */
function fnCreate2Success(data) {
	$('#gridPdf2 > tbody').empty();
	if(isEmpty(data.rows)){
	} else {
		$("#pdfDiv2").show();
	    $("#A_POBUSI_NO2").text(data.rows[0].A_POBUSI_NO);         // 공급받는자 사업자번호
	    $("#A_COMP_NM2").text(data.rows[0].A_COMP_NM);             // 공급받는자 상호
	    $("#A_PRESIDENT_NM2").text(data.rows[0].A_PRESIDENT_NM);   // 공급받는자 성명
	    $("#B_POBUSI_NO2").text(data.rows[0].B_POBUSI_NO);         // 공급자 사업자번호
	    $("#B_COMP_NM2").text(data.rows[0].B_COMP_NM);             // 공급자 상호
	    $("#B_PRESIDENT_NM2").text(data.rows[0].B_PRESIDENT_NM);   // 공급자 성명
	    $("#GR_PERSON_NAME2").text(data.rows[0].GR_PERSON_NAME);   // 인수자
	    $("#APPROVE_DOC_TXGR_DELY_TIME").text(data.rows[0].APPROVE_DOC_TXT); // 승인자 COMMENT
	    $("#DOC_NO2").text(data.rows[0].DOC_NO);                   // 문서번호
	    $("#LOCATION_TXT2").text(data.rows[0].LOCATION_TXT);                  // 입고장소
	    $("#GR_DELY_TIME2").text(data.rows[0].GR_DELY_TIME);                  // 입고일시
	    $("#GR_PERSON_NAME2").text(data.rows[0].GR_PERSON_NAME)                 // 입고담당자
	    $("#GR_PERSON_TEL2").text(data.rows[0].GR_PERSON_TEL);                 // 연락처

	    if(data.rows[0].CNT > 24){
	    	var params = {};
	    	$.extend(params, fnGetParams());
	    	$.extend(params, {"START_NUM" : '25', "END_NUM" : '36'});
	    	searchCall(gridPdf3, '/com/wrh/createPdf', 'fnCreate3', params);
	    } else {
	    	if(data.rows.length > 0){
	    		var html = '';
	            $.each(data.rows, function(idx, vo) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center">'+ vo.PO_NUMBER  +'</td>';
	                html +=     '<td align="center">'+ vo.PO_SEQ  +'</td>';
	                html +=     '<td align="center">'+ vo.MAT_NUMBER  +'</td>';
	                html +=     '<td align="left">'+ vo.MAT_DESC  +'</td>';
	                html +=     '<td align="center">'+ vo.UNIT_MEASURE  +'</td>';
	                html +=     '<td align="right">'+ vo.PO_ITEM_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.UNIT_PRICE  +'</td>';
	                html +=     '<td align="right">'+ vo.AMOUNT  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_LOT_NO  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_DATE  +'</td>';
	                html +=     '<td align="center">'+ vo.USE_BY_DATE  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_SUM  +'</td>';
	                html +=     '<td align="right">'+ vo.PLT_QTY  +'</td>';
	                html += '</tr>';
	            });
	            
	            // 공백채우기
	            for (var emptyRow=0; emptyRow < (12 - data.rows.length); emptyRow++) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="left"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html += '</tr>';	            	
	            }
	            $('#gridPdf2 > tbody:last').append(html);
	    	}
	    	
	        setTimeout(function(){
	        	fnCreatePdf2();
	        }, 2000)
	    }

	}
    
}

/**
 * 조회 후 처리
 */
function fnCreate3Success(data) {
	$('#pdfDiv3 > tbody').empty();
	if(isEmpty(data.rows)){
	} else {
		$("#pdfDiv3").show();
	    $("#A_POBUSI_NO3").text(data.rows[0].A_POBUSI_NO);         // 공급받는자 사업자번호
	    $("#A_COMP_NM3").text(data.rows[0].A_COMP_NM);             // 공급받는자 상호
	    $("#A_PRESIDENT_NM3").text(data.rows[0].A_PRESIDENT_NM);   // 공급받는자 성명
	    $("#B_POBUSI_NO3").text(data.rows[0].B_POBUSI_NO);         // 공급자 사업자번호
	    $("#B_COMP_NM3").text(data.rows[0].B_COMP_NM);             // 공급자 상호
	    $("#B_PRESIDENT_NM3").text(data.rows[0].B_PRESIDENT_NM);   // 공급자 성명
	    $("#GR_PERSON_NAME3").text(data.rows[0].GR_PERSON_NAME);   // 인수자
	    $("#APPROVE_DOC_TXGR_PERSON_NAME").text(data.rows[0].APPROVE_DOC_TXT); // 승인자 COMMENT
	    $("#DOC_NO3").text(data.rows[0].DOC_NO);                   // 문서번호
	    $("#LOCATION_TXT3").text(data.rows[0].LOCATION_TXT);                  // 입고장소
	    $("#GR_DELY_TIME3").text(data.rows[0].GR_DELY_TIME);                  // 입고일시
	    $("#GR_PERSON_NAME3").text(data.rows[0].GR_PERSON_NAME)                 // 입고담당자
	    $("#GR_PERSON_TEL3").text(data.rows[0].GR_PERSON_TEL);                 // 연락처

	    if(data.rows[0].CNT > 36){
	    	var params = {};
	    	$.extend(params, fnGetParams());
	    	$.extend(params, {"START_NUM" : '37', "END_NUM" : '48'});
	    	searchCall(gridPdf4, '/com/wrh/createPdf', 'fnCreate4', params);
	    } else {
	    	
	    	if(data.rows.length > 0){
	    		var html = '';
	            $.each(data.rows, function(idx, vo) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center">'+ vo.PO_NUMBER  +'</td>';
	                html +=     '<td align="center">'+ vo.PO_SEQ  +'</td>';
	                html +=     '<td align="center">'+ vo.MAT_NUMBER  +'</td>';
	                html +=     '<td align="left">'+ vo.MAT_DESC  +'</td>';
	                html +=     '<td align="center">'+ vo.UNIT_MEASURE  +'</td>';
	                html +=     '<td align="right">'+ vo.PO_ITEM_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.UNIT_PRICE  +'</td>';
	                html +=     '<td align="right">'+ vo.AMOUNT  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_LOT_NO  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_DATE  +'</td>';
	                html +=     '<td align="center">'+ vo.USE_BY_DATE  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_SUM  +'</td>';
	                html +=     '<td align="right">'+ vo.PLT_QTY  +'</td>';
	                html += '</tr>';
	            });
	            
	            // 공백채우기
	            for (var emptyRow=0; emptyRow < (12 - data.rows.length); emptyRow++) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="left"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html += '</tr>';	            	
	            }
	            $('#gridPdf3 > tbody:last').append(html);
	    	}	    	
	        setTimeout(function(){
	        	fnCreatePdf3();
	        }, 2000)
	    }
	}
	
}

/**
 * 조회 후 처리
 */
function fnCreate4Success(data) {
	$('#pdfDiv4 > tbody').empty();
	if(isEmpty(data.rows)){
	} else {
		$("#pdfDiv4").show();
	    $("#A_POBUSI_NO4").text(data.rows[0].A_POBUSI_NO);         // 공급받는자 사업자번호
	    $("#A_COMP_NM4").text(data.rows[0].A_COMP_NM);             // 공급받는자 상호
	    $("#A_PRESIDENT_NM4").text(data.rows[0].A_PRESIDENT_NM);   // 공급받는자 성명
	    $("#B_POBUSI_NO4").text(data.rows[0].B_POBUSI_NO);         // 공급자 사업자번호
	    $("#B_COMP_NM4").text(data.rows[0].B_COMP_NM);             // 공급자 상호
	    $("#B_PRESIDENT_NM4").text(data.rows[0].B_PRESIDENT_NM);   // 공급자 성명
	    $("#GR_PERSON_NAME4").text(data.rows[0].GR_PERSON_NAME);   // 인수자
	    $("#APPROVE_DOC_TXGR_PERSON_TEL").text(data.rows[0].APPROVE_DOC_TXT); // 승인자 COMMENT
	    $("#DOC_NO4").text(data.rows[0].DOC_NO);                   // 문서번호
	    $("#LOCATION_TXT4").text(data.rows[0].LOCATION_TXT);                  // 입고장소
	    $("#GR_DELY_TIME4").text(data.rows[0].GR_DELY_TIME);                  // 입고일시
	    $("#GR_PERSON_NAME4").text(data.rows[0].GR_PERSON_NAME)                 // 입고담당자
	    $("#GR_PERSON_TEL4").text(data.rows[0].GR_PERSON_TEL);                 // 연락처

	    if(data.rows[0].CNT > 48){
	    	var params = {};
	    	$.extend(params, fnGetParams());
	    	$.extend(params, {"START_NUM" : '49', "END_NUM" : '60'});
	    	searchCall(gridPdf5, '/com/wrh/createPdf', 'fnCreate5', params);
	    } else {
	    	
	    	if(data.rows.length > 0){
	    		var html = '';
	            $.each(data.rows, function(idx, vo) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center">'+ vo.PO_NUMBER  +'</td>';
	                html +=     '<td align="center">'+ vo.PO_SEQ  +'</td>';
	                html +=     '<td align="center">'+ vo.MAT_NUMBER  +'</td>';
	                html +=     '<td align="left">'+ vo.MAT_DESC  +'</td>';
	                html +=     '<td align="center">'+ vo.UNIT_MEASURE  +'</td>';
	                html +=     '<td align="right">'+ vo.PO_ITEM_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.UNIT_PRICE  +'</td>';
	                html +=     '<td align="right">'+ vo.AMOUNT  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_LOT_NO  +'</td>';
	                html +=     '<td align="center">'+ vo.MAKER_DATE  +'</td>';
	                html +=     '<td align="center">'+ vo.USE_BY_DATE  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_QTY  +'</td>';
	                html +=     '<td align="right">'+ vo.BOX_SUM  +'</td>';
	                html +=     '<td align="right">'+ vo.PLT_QTY  +'</td>';
	                html += '</tr>';
	            });
	            
	            // 공백채우기
	            for (var emptyRow=0; emptyRow < (12 - data.rows.length); emptyRow++) {
	                html += '<tr style="height:20px;">';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="left"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="center"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html +=     '<td align="right"></td>';
	                html += '</tr>';	            	
	            }
	            $('#gridPdf4 > tbody:last').append(html);
	    	}	    	
	    	
	        setTimeout(function(){
	        	fnCreatePdf4();
	        }, 2000)
	    }
	}

}

/**
 * 조회 후 처리
 */
function fnCreate5Success(data) {
	$('#pdfDiv5 > tbody').empty();
	if(isEmpty(data.rows)){
	} else {
		$("#pdfDiv5").show();
	    $("#A_POBUSI_NO5").text(data.rows[0].A_POBUSI_NO);         // 공급받는자 사업자번호
	    $("#A_COMP_NM5").text(data.rows[0].A_COMP_NM);             // 공급받는자 상호
	    $("#A_PRESIDENT_NM5").text(data.rows[0].A_PRESIDENT_NM);   // 공급받는자 성명
	    $("#B_POBUSI_NO5").text(data.rows[0].B_POBUSI_NO);         // 공급자 사업자번호
	    $("#B_COMP_NM5").text(data.rows[0].B_COMP_NM);             // 공급자 상호
	    $("#B_PRESIDENT_NM5").text(data.rows[0].B_PRESIDENT_NM);   // 공급자 성명
	    $("#GR_PERSON_NAME5").text(data.rows[0].GR_PERSON_NAME);   // 인수자
	    $("#APPROVE_DOC_TXT5").text(data.rows[0].APPROVE_DOC_TXT); // 승인자 COMMENT
	    $("#DOC_NO5").text(data.rows[0].DOC_NO);                   // 문서번호
	    $("#LOCATION_TXT5").text(data.rows[0].LOCATION_TXT);                  // 입고장소
	    $("#GR_DELY_TIME5").text(data.rows[0].GR_DELY_TIME);                  // 입고일시
	    $("#GR_PERSON_NAME5").text(data.rows[0].GR_PERSON_NAME)                 // 입고담당자
	    $("#GR_PERSON_TEL5").text(data.rows[0].GR_PERSON_TEL);                 // 연락처
	    
    	if(data.rows.length > 0){
    		var html = '';
            $.each(data.rows, function(idx, vo) {
                html += '<tr style="height:20px;">';
                html +=     '<td align="center">'+ vo.PO_NUMBER  +'</td>';
                html +=     '<td align="center">'+ vo.PO_SEQ  +'</td>';
                html +=     '<td align="center">'+ vo.MAT_NUMBER  +'</td>';
                html +=     '<td align="left">'+ vo.MAT_DESC  +'</td>';
                html +=     '<td align="center">'+ vo.UNIT_MEASURE  +'</td>';
                html +=     '<td align="right">'+ vo.PO_ITEM_QTY  +'</td>';
                html +=     '<td align="right">'+ vo.UNIT_PRICE  +'</td>';
                html +=     '<td align="right">'+ vo.AMOUNT  +'</td>';
                html +=     '<td align="center">'+ vo.MAKER_LOT_NO  +'</td>';
                html +=     '<td align="center">'+ vo.MAKER_DATE  +'</td>';
                html +=     '<td align="center">'+ vo.USE_BY_DATE  +'</td>';
                html +=     '<td align="right">'+ vo.BOX_QTY  +'</td>';
                html +=     '<td align="right">'+ vo.BOX_SUM  +'</td>';
                html +=     '<td align="right">'+ vo.PLT_QTY  +'</td>';
                html += '</tr>';
            });
            
            // 공백채우기
            for (var emptyRow=0; emptyRow < (12 - data.rows.length); emptyRow++) {
                html += '<tr style="height:20px;">';
                html +=     '<td align="center"></td>';
                html +=     '<td align="center"></td>';
                html +=     '<td align="center"></td>';
                html +=     '<td align="left"></td>';
                html +=     '<td align="right"></td>';
                html +=     '<td align="right"></td>';
                html +=     '<td align="right"></td>';
                html +=     '<td align="right"></td>';
                html +=     '<td align="center"></td>';
                html +=     '<td align="center"></td>';
                html +=     '<td align="center"></td>';
                html +=     '<td align="right"></td>';
                html +=     '<td align="right"></td>';
                html +=     '<td align="right"></td>';
                html += '</tr>';	            	
            }
            $('#gridPdf5 > tbody:last').append(html);
    	}	    

	    setTimeout(function(){
	    	fnCreatePdf5();
	    }, 2000)

	}
    
}

/**
 * 거래명세표 생성 실패
 */
function fnCreateFail(data) {
	alert(data.errMsg);
}


function fnCreatePdf1() {
	var doc = new jsPDF('l', 'mm', 'a4');
	html2canvas(document.getElementById("pdfDiv1"),{scale:2}).then(function(canvas) {
        var img1 = canvas.toDataURL('image/png');
        doc.addImage(img1, 'PNG', 0, 0, 297, 210);
        doc.save($('#DOC_NO1').text()+".pdf");
    	callBackPdf();
	});
    
}

function fnCreatePdf2() {
	
	var doc = new jsPDF('l', 'mm', 'a4');
	html2canvas(document.getElementById("pdfDiv1"),{scale:2}).then(function(canvas) {
        var img1 = canvas.toDataURL('image/png');
        doc.addImage(img1, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv2"),{scale:2}).then(function(canvas) {
        var img2 = canvas.toDataURL('image/png');
        doc.addImage(img2, 'PNG', 0, 0, 297, 210);
        doc.save($('#DOC_NO1').text()+".pdf");
    	callBackPdf();
	});
    
}

function fnCreatePdf3() {
	
	var doc = new jsPDF('l', 'mm', 'a4');
	html2canvas(document.getElementById("pdfDiv1"),{scale:2}).then(function(canvas) {
        var img1 = canvas.toDataURL('image/png');
        doc.addImage(img1, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv2"),{scale:2}).then(function(canvas) {
        var img2 = canvas.toDataURL('image/png');
        doc.addImage(img2, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv3"),{scale:2}).then(function(canvas) {
        var img3 = canvas.toDataURL('image/png');
        doc.addImage(img3, 'PNG', 0, 0, 297, 210);
        doc.save($('#DOC_NO1').text()+".pdf");
    	callBackPdf();
	});
    
}

function fnCreatePdf4() {
	
	var doc = new jsPDF('l', 'mm', 'a4');
	html2canvas(document.getElementById("pdfDiv1"),{scale:2}).then(function(canvas) {
        var img1 = canvas.toDataURL('image/png');
        doc.addImage(img1, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv2"),{scale:2}).then(function(canvas) {
        var img2 = canvas.toDataURL('image/png');
        doc.addImage(img2, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv3"),{scale:2}).then(function(canvas) {
        var img3 = canvas.toDataURL('image/png');
        doc.addImage(img3, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});
    
	html2canvas(document.getElementById("pdfDiv4"),{scale:2}).then(function(canvas) {
        var img4 = canvas.toDataURL('image/png');
        doc.addImage(img4, 'PNG', 0, 0, 297, 210);
        doc.save($('#DOC_NO1').text()+".pdf");
    	callBackPdf();
	});
    
}

function fnCreatePdf5() {
	
	var doc = new jsPDF('l', 'mm', 'a4');
	html2canvas(document.getElementById("pdfDiv1"),{scale:2}).then(function(canvas) {
        var img1 = canvas.toDataURL('image/png');
        doc.addImage(img1, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv2"),{scale:2}).then(function(canvas) {
        var img2 = canvas.toDataURL('image/png');
        doc.addImage(img2, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});

	html2canvas(document.getElementById("pdfDiv3"),{scale:2}).then(function(canvas) {
        var img3 = canvas.toDataURL('image/png');
        doc.addImage(img3, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});
    
	html2canvas(document.getElementById("pdfDiv4"),{scale:2}).then(function(canvas) {
        var img4 = canvas.toDataURL('image/png');
        doc.addImage(img4, 'PNG', 0, 0, 297, 210);
    	doc.addPage();
	});
    
	html2canvas(document.getElementById("pdfDiv5"),{scale:2}).then(function(canvas) {
        var img5 = canvas.toDataURL('image/png');
        doc.addImage(img5, 'PNG', 0, 0, 297, 210);
        doc.save($('#DOC_NO1').text()+".pdf");
    	callBackPdf();
	});
    
}

function callBackPdf() {
	$("#pdfDiv1").hide();
	$("#pdfDiv2").hide();
	$("#pdfDiv3").hide();
	$("#pdfDiv4").hide();
	$("#pdfDiv5").hide();
	loadingEnd();
}

var ajaxJsonCall = function(url, param, successCallback, errorCallback) {
	var contentType;
    var data;
    var dataType;

    if (typeof param == "string") {
        contentType = "application/json;charset=UTF-8";
        data = param;
        dataType = "json"
    } else {
        //contentType = "application/x-www-form-urlencoded;charset=UTF-8";
    	contentType = "application/json;charset=UTF-8";
    	data = JSON.stringify(param);;
        dataType = "json";
    }

    $.ajax({
    type : 'POST',
    url : url,
    contentType : contentType,
    data : data,
    dataType : dataType,
    cache: false,
    beforeSend:function(){
    	//$('body').append('<div class="loading-area"></div>');
    	loading();
    },
    complete:function(){
    	//if (undefined==param.pageLoader || !param.pageLoader) $('.loading-area').remove();
    	//loadingEnd();
    },
    success : function(data) {
        try {
            if (data) {
                if (data["status"] == "SUCC") {
                    if (typeof successCallback !== 'undefined') {
                        successCallback(data);
                    }
                } else if (data["status"] == "FAIL"){
                    
                    if (typeof errorCallback !== 'undefined') {
                        errorCallback(data);
                    }else{
                    	alert(data["errMsg"]);
                    }
//                    try{ $('.loading-area').remove(); } catch(e){}
                    try{ loadingEnd(); } catch(e){}
                } else {
                    if (typeof successCallback !== 'undefined') {
                        successCallback(data);
                    }
                }
            }
        } catch (e) {
            alert(e.message);
//            try{ $('.loading-area').remove(); } catch(e){}
            try{ loadingEnd(); } catch(e){}
        }
    },
    error : function(xhr, status, error) {
        if (401 === xhr.status) {
            alert('<spring:message code="M1000015" javaScriptEscape="true"/>');
            location.href = "/";
        } else if (500 === xhr.status) {
        	alert('서버에 오류가 발생하여 요청을 수행할 수 없습니다. 시스템 관리자에게 문의 바랍니다.');
        } else {
            alert(error);
        }
        try{ $('.loading-area').remove(); } catch(e){}
        }
    });
};

</script>
<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
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
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" onchange="fnCompCdChange();" >
		                    <option value="">전체</option>
	                    </select>
                    </td>
                    <th><span>플랜트</span></th>
                    <td>
	                    <select id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD" onchange="fnPlantCdChange();">
		                    <option value="">전체</option>
	                    </select>
                    </td>
					<th><span>입고장소</span></th>
                    <td>
	                    <select id="SB_STORAGE_CD" name="SB_STORAGE_CD" data-type="select" data-bind="selectedOptions: SB_STORAGE_CD" onchange="fnStorageCdChange();">
		                    <option value="">전체</option>
	                    </select>
                    </td>
                    <td></td>
                </tr>            
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly"/>
                        <input type="text" id="DOC_NO"	hidden="true"/>
<!--                         <a href="javascript:fnSearchVendor();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
                    </td>
                    <th><span>입고예정일</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DATE" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DATE" dateHolder="end" value=""/>
                    </td>
                    <th><span>문서번호</span></th>
                    <td>
                        <input type="text" id="TB_DOC_NO" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>진행상태</span></th>
                    <td>
	                    <select id="SB_STAT_CD" name="SB_STAT_CD" data-type="select" data-bind="selectedOptions: SB_STAT_CD">
		                    <option>전체</option>
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
<br>

<div class="sub-tit">
    <div class="btnArea t_right">
    	<button type="button" class="btn" id="btnCreate">거래명세표</button>
        <button type="button" class="btn" id="btnCancel">승인취소</button>
        <button type="button" class="btn" id="btnRequest">승인요청</button>
        <button type="button" class="btn" id="btnDel">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
	<div id="pdfDiv1" style="border: 1px solid #ddd; padding-right: 10px;">
		<div class="pdf-area" style="padding:15px;font-size:20px;">
			<h3>거래명세서</h3>
		</div>
		<div class="layout-box">
			<div class="layout-left" style="padding-right:325px; padding-left:15px;">
					<table class="pdf-view" style="width:680px;">
						<colgroup>
							<col style="width:160px;" />
							<col style="width:200px;" />
							<col style="width:160px;" />
							<col style="width:160px;" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center;border-bottom:0px;">입고장소</th>
								<td style="text-align:center;border-bottom:0px;" id="LOCATION_TXT1"></td>
								<th style="text-align:center;border-bottom:0px;">입고일시</th>
								<td style="text-align:center;border-bottom:0px;" id="GR_DELY_TIME1"></td>
							</tr>
							<tr>
								<th style="text-align:center;">입고담당자</th>
								<td style="text-align:center;" id="GR_PERSON_NAME1"></td>
								<th style="text-align:center;">연락처</th>
								<td style="text-align:center;" id="GR_PERSON_TEL1"></td>
							</tr>
						</tbody>
					</table>

			</div>
			<div class="layout-right" style="padding-left:325px; padding-right:15px;">
				<div style="height:71px;">
					<table class="pdf-view" style="height:70px;">
						<colgroup>
							<col style="width:100px;" />
							<col style="width:260px;" />
						</colgroup>
						<tbody>
							<tr style="text-align:center;height:68px;">
								<th style="text-align:center;">문서번호</th>
								<td style="text-align:center;" id="DOC_NO1"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;" rowspan="2">공급받는자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="A_POBUSI_NO1" style="text-align:center;border-bottom:0px;"></td>
						<th style="text-align:center;" rowspan="2">공급자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="B_POBUSI_NO1" style="text-align:center;border-bottom:0px;"></td>
					</tr>
					<tr>
						<th style="text-align:center;">상호</th>
						<td id="A_COMP_NM1" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="A_PRESIDENT_NM1" style="text-align:center;"></td>
						<th style="text-align:center;">상호</th>
						<td id="B_COMP_NM1" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="B_PRESIDENT_NM1" style="text-align:center;"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="pop-cont">
			<table class="pdf-list" id="gridPdf1">
				<colgroup>
					<col style="width:70px"/>
					<col style="width:50px"/>
					<col style="width:70px"/>
					<col style="width:200px"/>
					<col style="width:50px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:70px"/>
					<col style="width:70px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
				</colgroup>
		    	<thead>
		        	<tr>
			            <th>발주번호</th>
			            <th>발주항번</th>
			            <th>자재코드</th>
			            <th>자재내역</th>
			            <th>단위</th>
			            <th>수량</th>
			            <th>단가</th>
			            <th>금액</th>
			            <th>제조원배치번호</th>
			            <th>제조일자</th>
			            <th>유효일자</th>
			            <th>박스입수</th>
			            <th>박스수량</th>
			            <th>PLT수량</th>
		        	</tr>
		    	</thead>				
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:500px" />
					<col style="width:100px" />
					<col style="width:500px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;">비고</th>
						<td id="APPROVE_DOC_TXLOCATION_TXT" style=""></td>
						<th style="text-align:center;">인수자</th>
						<td id="GR_PERSON_NAME1" style=""></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="pdfDiv2" style="border: 1px solid #ddd; padding-right: 10px;">
		<div class="pdf-area" style="padding:15px;font-size:20px;">
			<h3>거래명세서</h3>
		</div>
		<div class="layout-box">
			<div class="layout-left" style="padding-right:325px; padding-left:15px;">
					<table class="pdf-view" style="width:680px;">
						<colgroup>
							<col style="width:160px;" />
							<col style="width:200px;" />
							<col style="width:160px;" />
							<col style="width:160px;" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center;border-bottom:0px;">입고장소</th>
								<td style="text-align:center;border-bottom:0px;" id="LOCATION_TXT2"></td>
								<th style="text-align:center;border-bottom:0px;">입고일시</th>
								<td style="text-align:center;border-bottom:0px;" id="GR_DELY_TIME2"></td>
							</tr>
							<tr>
								<th style="text-align:center;">입고담당자</th>
								<td style="text-align:center;" id="GR_PERSON_NAME2"></td>
								<th style="text-align:center;">연락처</th>
								<td style="text-align:center;" id="GR_PERSON_TEL2"></td>
							</tr>
						</tbody>
					</table>

			</div>
			<div class="layout-right" style="padding-left:325px; padding-right:15px;">
				<div style="height:71px;">
					<table class="pdf-view" style="height:70px;">
						<colgroup>
							<col style="width:100px;" />
							<col style="width:260px;" />
						</colgroup>
						<tbody>
							<tr style="text-align:center;height:68px;">
								<th style="text-align:center;">문서번호</th>
								<td style="text-align:center;" id="DOC_NO2"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;" rowspan="2">공급받는자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="A_POBUSI_NO2" style="text-align:center;border-bottom:0px;"></td>
						<th style="text-align:center;" rowspan="2">공급자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="B_POBUSI_NO2" style="text-align:center;border-bottom:0px;"></td>
					</tr>
					<tr>
						<th style="text-align:center;">상호</th>
						<td id="A_COMP_NM2" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="A_PRESIDENT_NM2" style="text-align:center;"></td>
						<th style="text-align:center;">상호</th>
						<td id="B_COMP_NM2" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="B_PRESIDENT_NM2" style="text-align:center;"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="pop-cont">
			<table class="pdf-list" id="gridPdf2">
				<colgroup>
					<col style="width:70px"/>
					<col style="width:50px"/>
					<col style="width:70px"/>
					<col style="width:200px"/>
					<col style="width:50px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:70px"/>
					<col style="width:70px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
				</colgroup>
		    	<thead>
		        	<tr>
			            <th>발주번호</th>
			            <th>발주항번</th>
			            <th>자재코드</th>
			            <th>자재내역</th>
			            <th>단위</th>
			            <th>수량</th>
			            <th>단가</th>
			            <th>금액</th>
			            <th>제조원배치번호</th>
			            <th>제조일자</th>
			            <th>유효일자</th>
			            <th>박스입수</th>
			            <th>박스수량</th>
			            <th>PLT수량</th>
		        	</tr>
		    	</thead>				
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:500px" />
					<col style="width:100px" />
					<col style="width:500px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;">비고</th>
						<td id="APPROVE_DOC_TXLOCATION_TXT" style=""></td>
						<th style="text-align:center;">인수자</th>
						<td id="GR_PERSON_NAME2" style=""></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="pdfDiv3" style="border: 1px solid #ddd; padding-right: 10px;">
		<div class="pdf-area" style="padding:15px;font-size:20px;">
			<h3>거래명세서</h3>
		</div>
		<div class="layout-box">
			<div class="layout-left" style="padding-right:325px; padding-left:15px;">
					<table class="pdf-view" style="width:680px;">
						<colgroup>
							<col style="width:160px;" />
							<col style="width:200px;" />
							<col style="width:160px;" />
							<col style="width:160px;" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center;border-bottom:0px;">입고장소</th>
								<td style="text-align:center;border-bottom:0px;" id="LOCATION_TXT3"></td>
								<th style="text-align:center;border-bottom:0px;">입고일시</th>
								<td style="text-align:center;border-bottom:0px;" id="GR_DELY_TIME3"></td>
							</tr>
							<tr>
								<th style="text-align:center;">입고담당자</th>
								<td style="text-align:center;" id="GR_PERSON_NAME3"></td>
								<th style="text-align:center;">연락처</th>
								<td style="text-align:center;" id="GR_PERSON_TEL3"></td>
							</tr>
						</tbody>
					</table>

			</div>
			<div class="layout-right" style="padding-left:325px; padding-right:15px;">
				<div style="height:71px;">
					<table class="pdf-view" style="height:70px;">
						<colgroup>
							<col style="width:100px;" />
							<col style="width:260px;" />
						</colgroup>
						<tbody>
							<tr style="text-align:center;height:68px;">
								<th style="text-align:center;">문서번호</th>
								<td style="text-align:center;" id="DOC_NO3"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;" rowspan="2">공급받는자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="A_POBUSI_NO3" style="text-align:center;border-bottom:0px;"></td>
						<th style="text-align:center;" rowspan="2">공급자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="B_POBUSI_NO3" style="text-align:center;border-bottom:0px;"></td>
					</tr>
					<tr>
						<th style="text-align:center;">상호</th>
						<td id="A_COMP_NM3" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="A_PRESIDENT_NM3" style="text-align:center;"></td>
						<th style="text-align:center;">상호</th>
						<td id="B_COMP_NM3" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="B_PRESIDENT_NM3" style="text-align:center;"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="pop-cont">
			<table class="pdf-list" id="gridPdf3">
				<colgroup>
					<col style="width:70px"/>
					<col style="width:50px"/>
					<col style="width:70px"/>
					<col style="width:200px"/>
					<col style="width:50px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:70px"/>
					<col style="width:70px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
				</colgroup>
		    	<thead>
		        	<tr>
			            <th>발주번호</th>
			            <th>발주항번</th>
			            <th>자재코드</th>
			            <th>자재내역</th>
			            <th>단위</th>
			            <th>수량</th>
			            <th>단가</th>
			            <th>금액</th>
			            <th>제조원배치번호</th>
			            <th>제조일자</th>
			            <th>유효일자</th>
			            <th>박스입수</th>
			            <th>박스수량</th>
			            <th>PLT수량</th>
		        	</tr>
		    	</thead>				
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:500px" />
					<col style="width:100px" />
					<col style="width:500px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;">비고</th>
						<td id="APPROVE_DOC_TXLOCATION_TXT" style=""></td>
						<th style="text-align:center;">인수자</th>
						<td id="GR_PERSON_NAME3" style=""></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="pdfDiv4" style="border: 1px solid #ddd; padding-right: 10px;">
		<div class="pdf-area" style="padding:15px;font-size:20px;">
			<h3>거래명세서</h3>
		</div>
		<div class="layout-box">
			<div class="layout-left" style="padding-right:325px; padding-left:15px;">
					<table class="pdf-view" style="width:680px;">
						<colgroup>
							<col style="width:160px;" />
							<col style="width:200px;" />
							<col style="width:160px;" />
							<col style="width:160px;" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center;border-bottom:0px;">입고장소</th>
								<td style="text-align:center;border-bottom:0px;" id="LOCATION_TXT4"></td>
								<th style="text-align:center;border-bottom:0px;">입고일시</th>
								<td style="text-align:center;border-bottom:0px;" id="GR_DELY_TIME4"></td>
							</tr>
							<tr>
								<th style="text-align:center;">입고담당자</th>
								<td style="text-align:center;" id="GR_PERSON_NAME4"></td>
								<th style="text-align:center;">연락처</th>
								<td style="text-align:center;" id="GR_PERSON_TEL4"></td>
							</tr>
						</tbody>
					</table>

			</div>
			<div class="layout-right" style="padding-left:325px; padding-right:15px;">
				<div style="height:71px;">
					<table class="pdf-view" style="height:70px;">
						<colgroup>
							<col style="width:100px;" />
							<col style="width:260px;" />
						</colgroup>
						<tbody>
							<tr style="text-align:center;height:68px;">
								<th style="text-align:center;">문서번호</th>
								<td style="text-align:center;" id="DOC_NO4"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;" rowspan="2">공급받는자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="A_POBUSI_NO4" style="text-align:center;border-bottom:0px;"></td>
						<th style="text-align:center;" rowspan="2">공급자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="B_POBUSI_NO4" style="text-align:center;border-bottom:0px;"></td>
					</tr>
					<tr>
						<th style="text-align:center;">상호</th>
						<td id="A_COMP_NM4" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="A_PRESIDENT_NM4" style="text-align:center;"></td>
						<th style="text-align:center;">상호</th>
						<td id="B_COMP_NM4" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="B_PRESIDENT_NM4" style="text-align:center;"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="pop-cont">
			<table class="pdf-list" id="gridPdf4">
				<colgroup>
					<col style="width:70px"/>
					<col style="width:50px"/>
					<col style="width:70px"/>
					<col style="width:200px"/>
					<col style="width:50px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:70px"/>
					<col style="width:70px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
				</colgroup>
		    	<thead>
		        	<tr>
			            <th>발주번호</th>
			            <th>발주항번</th>
			            <th>자재코드</th>
			            <th>자재내역</th>
			            <th>단위</th>
			            <th>수량</th>
			            <th>단가</th>
			            <th>금액</th>
			            <th>제조원배치번호</th>
			            <th>제조일자</th>
			            <th>유효일자</th>
			            <th>박스입수</th>
			            <th>박스수량</th>
			            <th>PLT수량</th>
		        	</tr>
		    	</thead>				
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:500px" />
					<col style="width:100px" />
					<col style="width:500px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;">비고</th>
						<td id="APPROVE_DOC_TXLOCATION_TXT" style=""></td>
						<th style="text-align:center;">인수자</th>
						<td id="GR_PERSON_NAME4" style=""></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div id="pdfDiv5" style="border: 1px solid #ddd; padding-right: 10px;">
		<div class="pdf-area" style="padding:15px;font-size:20px;">
			<h3>거래명세서</h3>
		</div>
		<div class="layout-box">
			<div class="layout-left" style="padding-right:325px; padding-left:15px;">
					<table class="pdf-view" style="width:680px;">
						<colgroup>
							<col style="width:160px;" />
							<col style="width:200px;" />
							<col style="width:160px;" />
							<col style="width:160px;" />
						</colgroup>
						<tbody>
							<tr>
								<th style="text-align:center;border-bottom:0px;">입고장소</th>
								<td style="text-align:center;border-bottom:0px;" id="LOCATION_TXT5"></td>
								<th style="text-align:center;border-bottom:0px;">입고일시</th>
								<td style="text-align:center;border-bottom:0px;" id="GR_DELY_TIME5"></td>
							</tr>
							<tr>
								<th style="text-align:center;">입고담당자</th>
								<td style="text-align:center;" id="GR_PERSON_NAME5"></td>
								<th style="text-align:center;">연락처</th>
								<td style="text-align:center;" id="GR_PERSON_TEL5"></td>
							</tr>
						</tbody>
					</table>

			</div>
			<div class="layout-right" style="padding-left:325px; padding-right:15px;">
				<div style="height:71px;">
					<table class="pdf-view" style="height:70px;">
						<colgroup>
							<col style="width:100px;" />
							<col style="width:260px;" />
						</colgroup>
						<tbody>
							<tr style="text-align:center;height:68px;">
								<th style="text-align:center;">문서번호</th>
								<td style="text-align:center;" id="DOC_NO5"></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:100px" />
					<col style="width:150px" />
					<col style="width:50px" />
					<col style="width:100px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;" rowspan="2">공급받는자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="A_POBUSI_NO5" style="text-align:center;border-bottom:0px;"></td>
						<th style="text-align:center;" rowspan="2">공급자</th>
						<th style="text-align:center;border-bottom:0px;">사업자번호</th>
						<td colspan="3" id="B_POBUSI_NO5" style="text-align:center;border-bottom:0px;"></td>
					</tr>
					<tr>
						<th style="text-align:center;">상호</th>
						<td id="A_COMP_NM5" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="A_PRESIDENT_NM5" style="text-align:center;"></td>
						<th style="text-align:center;">상호</th>
						<td id="B_COMP_NM5" style="text-align:center;"></td>
						<th style="text-align:center;">성명</th>
						<td id="B_PRESIDENT_NM5" style="text-align:center;"></td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="pop-cont">
			<table class="pdf-list" id="gridPdf5">
				<colgroup>
					<col style="width:70px"/>
					<col style="width:50px"/>
					<col style="width:70px"/>
					<col style="width:200px"/>
					<col style="width:50px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:70px"/>
					<col style="width:70px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
					<col style="width:60px"/>
				</colgroup>
		    	<thead>
		        	<tr>
			            <th>발주번호</th>
			            <th>발주항번</th>
			            <th>자재코드</th>
			            <th>자재내역</th>
			            <th>단위</th>
			            <th>수량</th>
			            <th>단가</th>
			            <th>금액</th>
			            <th>제조원배치번호</th>
			            <th>제조일자</th>
			            <th>유효일자</th>
			            <th>박스입수</th>
			            <th>박스수량</th>
			            <th>PLT수량</th>
		        	</tr>
		    	</thead>				
				<tbody>
				</tbody>
			</table>
		</div>
		<div class="pop-cont">
			<table class="pdf-view">
				<colgroup>
					<col style="width:100px" />
					<col style="width:500px" />
					<col style="width:100px" />
					<col style="width:500px" />
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center;">비고</th>
						<td id="APPROVE_DOC_TXLOCATION_TXT" style=""></td>
						<th style="text-align:center;">인수자</th>
						<td id="GR_PERSON_NAME5" style=""></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
