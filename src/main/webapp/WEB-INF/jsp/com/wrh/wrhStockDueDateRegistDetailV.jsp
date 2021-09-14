<%--
	File Name : wrhStockDueDateRegistDetailV.jsp
	Description: 입고예정 > 발주/입고 > 입고예정등록
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.20  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.20
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	// 그리드 생성
	setInitGridView();
	
	// 초기 상태값 처리
    fnInitStatus();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
	if (!isNullValue($('#TB_DOC_NO').val())) {
		fnSearch();
	}    

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	
	var docNo = '${PARAM.DOC_NO}';
	
	if (!isNullValue(docNo)) {
		// 부모창에서 문서번호만 받는 경우
		$("#TB_DOC_NO").val(docNo);
	} else {
		// 전체 데이터를 부모창에서 받는 경우
		if (!isNullValue('${PARAM.CHECK_LIST}')) {
			var detailList = JSON.parse('${PARAM.CHECK_LIST}');
			// 하단 그리드 데이터 셋팅
			for (var i=0 ; i < detailList.length; i ++) {
				fnAddRow(gridView, detailList[i], i, true);
				
				// 상단 조회 조건 데이터 셋팅
				if (i ==  0) {
					$("#TB_COMP_NM").val(detailList[0].COMP_NM);
					$("#TB_COMP_CD").val(detailList[0].COMP_CD);
					$("#TB_PLANT_NAME").val(detailList[0].PLANT_NAME);
					$("#TB_PLANT_CODE").val(detailList[0].PLANT_CODE);
					$("#TB_LOCATION_TXT").val(detailList[0].LOCATION_TXT);
					$("#TB_LOCATION").val(detailList[0].LOCATION);
					$("#TB_VENDOR_CD").val(detailList[0].VENDOR_CD);
					$("#TB_VENDOR_NM").val(detailList[0].VENDOR_NM);
					$("#TB_PO_ORG").val(detailList[0].PO_ORG);
					$("#TB_PO_ORG_NM").val(detailList[0].PO_ORG_NM);
				}		
			}
			
			gridView.commit();
			
			fnSearchPltQty();
		}
	}
}


function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PO_NUMBER',         {text: '발주번호'},      100,     'text', {textAlignment: "center"});
    addField(cm,    'PO_SEQ',            {text: '발주항번'},      70,      'text',     {textAlignment: "center"});
    addField(cm,    'MAT_NUMBER',        {text: '자재코드'},      100,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_DESC',          {text: '자재내역'},      130,     'text',     {textAlignment: "near"});
    addField(cm,    'UNIT_MEASURE',      {text: '단위'},            0,     'text',     {textAlignment: "center"});
    addField(cm,    'CURR_CD',           {text: '통화'},          100,     'text',     {textAlignment: "center"});
    addField(cm,    'UNIT_PER_MEASURE',  {text: 'Per'},          100,     'number',     {textAlignment: "center"});
    
    addField(cm,    'PO_ITEM_QTY',       {text: '발주수량'},      100,     'number',     {textAlignment: "center"});
    addField(cm,    'ADD_GR_QTY',        {text: '누적입고수량'},   0,     'number',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'NON_PAY_QTY',       {text: '미납수량'},      100,     'number',     {textAlignment: "center"});
    addField(cm,    'ITEM_QTY',          {text: '납품수량'},      100,     'number',     {textAlignment: "center"});
    addField(cm,    'ITEM_AMT',          {text: '금액'},         100,     'number',     {textAlignment: "center"});
    addField(cm,    'UNIT_PRICE',        {text: '단가'},         100,     'number',     {textAlignment: "center"});
    

    addField(cm,    'MAKER_LOT_NO',      {text: '로트번호'},     100,      'text',     {textAlignment: "center"});
    addField(cm,    'MAKER_DATE',        {text: '제조일자'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'USE_BY_DATE',       {text: '유효일자'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    
    addField(cm,    'PRODUCT_NO',        {text: '공급처제품코드'},     100,      'text',     {textAlignment: "center"});
    addField(cm,    'PRODUCT_TXT',       {text: '공급처제품명'},     100,      'text',     {textAlignment: "center"});    
    addField(cm,    'BOX_WEIGHT',        {text: '박스중량(g)'},     100,      'number',     {textAlignment: "center"});    
    addField(cm,    'PRODUCT_WEIGHT',    {text: '제품중량(g)'},     100,      'number',     {textAlignment: "center"});    
    addField(cm,    'W_D_H',             {text: '가로*세로*높이'}, 100,      'text',     {textAlignment: "center"}); 
    addField(cm,    'INV_PERCENT',       {text: '초과납품허용한도(%)'}, 100,      'number',     {textAlignment: "center"});     
    addField(cm,    'INV_ITEM_QTY',      {text: '초과납품가능수량'}, 100,      'number',     {textAlignment: "center"});     
    addField(cm,    'BOX_QTY',           {text: '박스입수'},      100,     'text',     {textAlignment: "center"});
//     addField(cm,    'AREA_QTY',          {text: '배면'},          100,     'text',     {textAlignment: "center"});
//     addField(cm,    'HEIGH_QTY',         {text: '배단'},          100,     'text',     {textAlignment: "center"});
    addField(cm,    'PLT_QTY',           {text: 'PLT적재수량'},   100,     'number',     {textAlignment: "center"});
    addField(cm,    'PLT_CAL_QTY',       {text: 'PLT수량'},   100,     'number',     {textAlignment: "center"});
    
    addField(cm,    'PO_ORG',            {text: '구매조직'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_ORG_NM',         {text: '구매그룹명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PLANT_CODE',        {text: '플랜트'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_CD',         {text: '업체코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_NM',         {text: '업체명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MINI_EXP_PER',      {text: '최저잔존수명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'DOC_NO',            {text: '문서번호'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'DOC_SEQ',           {text: '문서일련번호'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MAT_TYPE',          {text: '자재코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'CRUD',              {text: 'CRUD'}     ,0       , 'text'            , {textAlignment: 'center'},  {visible:false});
    addField(cm,    'MAT_TYPE_NM',       {text: '자재유형'},      0,     'text',     {textAlignment: "center"},  {visible:false});
    
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 450       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridView.setFixedOptions({
    	  colCount: 4
    });
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = true;
        	styles.background = "#faed7d";
        	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"}
        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles2 = function(grid, index, value) {
        var styles = {};
        	styles.editable = true;
        	styles.background = "#faed7d";
        return styles;
    };    
    
    gridView.setColumnProperty("MAKER_DATE" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("USE_BY_DATE" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ITEM_QTY" , "dynamicStyles", columnDefaultStyles2);
    gridView.setColumnProperty("MAKER_LOT_NO" , "dynamicStyles", columnDefaultStyles2);
    
	gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
		// 전체 그리드 컬럼 비활성화
		fnEditableFalse(grid);
		// 선택적 그리드 컬럼 활성화
    	//grid.setColumnProperty("ITEM_QTY", "editable", true);
    	grid.setColumnProperty("PRODUCT_NO", "editable", true);
    	grid.setColumnProperty("PRODUCT_TXT", "editable", true);
    	//grid.setColumnProperty("MAKER_LOT_NO", "editable", true);
    	grid.setColumnProperty("MAKER_DATE", "editable", true);
    	grid.setColumnProperty("USE_BY_DATE", "editable", true);
    	grid.setColumnProperty("BOX_WEIGHT", "editable", true);
    	grid.setColumnProperty("PRODUCT_WEIGHT", "editable", true);
    	grid.setColumnProperty("W_D_H", "editable", true);
    	// 수정가능한 컬럼 색상 변경 처리
    	fnEditableStyle(grid);
    };  
    
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	
    	var values = grid.getValues(itemIndex);
    	var Qty    = values.ITEM_QTY;
    	var price  = values.UNIT_PRICE;
    	var per    = values.UNIT_PER_MEASURE;
    	var pltQyt = values.PLT_QTY;
    	
    	// 금액 = 납품수량 * 단가 * PER
    	gridView.setValue(itemIndex, "ITEM_AMT", Qty * price * per);
    	if (!isNullValue(pltQyt)) {
    		if (pltQyt > 0) {
    			// PLT수량 = 납품수량 / PLT적재수량
    			gridView.setValue(itemIndex, "PLT_CAL_QTY", setTrunc((Qty / pltQyt).toString(), 1));
    		}
    	}
    	
    	gridView.checkItem(dataRow, true);
    };    

    
    gridView.setOptions({sortMode:"explicit"});
    
    gridView.onRowsPasted = function(grid, items){
    	for(var i = 0; i < items.length; i++){
        	var values = grid.getValues(items[i]);
        	var Qty    = values.ITEM_QTY;
        	var price  = values.UNIT_PRICE;
        	var per    = values.UNIT_PER_MEASURE;
        	var pltQyt = values.PLT_QTY;
        	
        	// 금액 = 납품수량 * 단가 * PER
        	gridView.setValue(items[i], "ITEM_AMT", Qty * price * per);
        	if (!isNullValue(pltQyt)) {
        		if (pltQyt > 0) {
        			// PLT수량 = 납품수량 / PLT적재수량
        			gridView.setValue(items[i], "PLT_CAL_QTY", setTrunc((Qty / pltQyt).toString(), 1));
        		}
        	}
        	
        	gridView.checkItem(items[i], true);
    	}
    	
    };
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWhrStockDueDateRegistDetailList');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	
	// DB에 저장된 데이터를 조회하여 화면 상단에 셋팅
	$("#TB_COMP_NM").val(data.fields.headerInfo.COMP_NM);
	$("#TB_COMP_CD").val(data.fields.headerInfo.COMP_CD);
	$("#TB_PLANT_NAME").val(data.fields.headerInfo.PLANT_NAME);
	$("#TB_PLANT_CODE").val(data.fields.headerInfo.PLANT_CODE);
	$("#TB_LOCATION_TXT").val(data.fields.headerInfo.LOCATION_TXT);
	$("#TB_LOCATION").val(data.fields.headerInfo.LOCATION);
	$("#TB_VENDOR_CD").val(data.fields.headerInfo.VENDOR_CD);
	$("#TB_VENDOR_NM").val(data.fields.headerInfo.VENDOR_NM);
	$("#TB_PO_ORG").val(data.fields.headerInfo.PO_ORG);
	$("#TB_PO_ORG_NM").val(data.fields.headerInfo.PO_ORG_NM);
	$("#TB_GR_DELY_DATE").val(data.fields.headerInfo.GR_DELY_DATE);
	// 변경일자를 관리하여 창고여유를 재계산하기 위함
	$("#GR_DELY_DATE_OLD").val(data.fields.headerInfo.GR_DELY_DATE_OLD);
	$("#TB_GR_DELY_TIME").val(data.fields.headerInfo.GR_DELY_TIME);
	$("#TB_GR_PERSON_NAME").val(data.fields.headerInfo.GR_PERSON_NAME);
	$("#TB_GR_PERSON_TEL").val(data.fields.headerInfo.GR_PERSON_TEL);
	$("#TB_DOC_NO").val(data.fields.headerInfo.DOC_NO);
	$("#TB_VENDOR_DOC_TXT").val(data.fields.headerInfo.VENDOR_DOC_TXT);
	$("#TB_DOC_STATUS").val(data.fields.headerInfo.DOC_STATUS);
	
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();	
}

/**
 * 수량 조회
 */
function fnSearchPltQty() {
	
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridView)});
	
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectPltQtyList', 'fnSearchPltQty', params);
}

/**
 * 조회 후 처리
 */
function fnSearchPltQtySuccess(data) {
	
	for (var i=0; i < data.fields.pltQtyInfo.length; i++) {
		sObj = data.fields.pltQtyInfo[i];
		
		for(var j = 0; j < gridView.getRowCount(); j++){
			var temp = gridView.getValues(j);
			if (sObj.MAT_NUMBER == temp.MAT_NUMBER && sObj.PLANT_CODE == temp.PLANT_CODE) {
				gridView.setRowValue(j, "BOX_QTY", sObj.BOX_QTY);
				gridView.setRowValue(j, "PLT_QTY", sObj.PLT_QTY);
			}
		}
	}
}


//저장
function fnSave() {
	// 그리드 수정사항 확정처리
	gridView.commit();
	var docStatus = nvl($("#TB_DOC_STATUS").val(), '1');
	if (docStatus == "1" || docStatus == "3" || docStatus == "4") {
		// 작성중 or 물류반려 or 구매반려 인경우만 저장 가능
	} else {
		alert("작성중 상태에서만 저장 가능합니다.");
		return false;
	}
	
	// 그리드 전체 데이터를 수집하기 윟 전체 체크박스 선택 처리
	var poNumberOld = "";
	var poSeqOld = "";
	var itemQyt = 0;
	var poItemQty = 0;
	var addGrQty = 0;
	var invItemQty = 0;
	
	for(var i = 0; i < gridView.getRowCount(); i++){
		if (i == 0) {
			poNumberOld = gridView.getValue(i,"PO_NUMBER");
			poSeqOld    = gridView.getValue(i,"PO_SEQ");
			itemQyt     = gridView.getValue(i,"ITEM_QTY");
			
			poItemQty   = gridView.getValue(i,"PO_ITEM_QTY");
			addGrQty    = gridView.getValue(i,"ADD_GR_QTY");
			invItemQty  = gridView.getValue(i,"INV_ITEM_QTY");
			
		} else {
			// 발주번호와 항번이 같은 경우
			if (   poNumberOld == gridView.getValue(i,"PO_NUMBER") 
				&& poSeqOld    == gridView.getValue(i,"PO_SEQ")) {
				itemQyt += gridView.getValue(i,"ITEM_QTY");
			} else {
				
				// 신규 체크할 데이터 셋팅
				poNumberOld = gridView.getValue(i,"PO_NUMBER");
				poSeqOld    = gridView.getValue(i,"PO_SEQ");
				itemQyt     = gridView.getValue(i,"ITEM_QTY");
				
				poItemQty   = gridView.getValue(i,"PO_ITEM_QTY");
				addGrQty    = gridView.getValue(i,"ADD_GR_QTY");
				invItemQty  = gridView.getValue(i,"INV_ITEM_QTY");			
			}
		}
		
		// 납품가능 수량 체크
		// 총남품가능 수량 = (발주수량 + 초과납품가능수량) - 누적입고수량
		// 초과납품가능수량 = 발주수량
		if ( ((poItemQty + invItemQty) - addGrQty) - itemQyt < 0 ) {
			alert("총납품가능 수량을 초과했습니다. 확인 후 작업하세요.");
			return false;
		}		
	}	
	
	// 그리드 전체 데이터를 수집하기 윟 전체 체크박스 선택 처리
	for(var i = 0; i < gridView.getRowCount(); i++){
		gridView.checkItem(i, true);
	}	
	var params = fnGetParams();
	
	$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ITEM_QTY", "MAKER_LOT_NO", "MAKER_LOT_NO", "MAKER_DATE", "USE_BY_DATE"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/saveDueDateRegist', null, params);
	     }
	}
}

//승인요청
function fnRequest() {
	// 그리드 수정사항 확정처리
	gridView.commit();
	
	if (nvl($("#TB_DOC_STATUS").val(), '1') != "1") {
		alert("작성중 상태에서만 승인요청 가능합니다.");
		return false;
	}	
	
	if (isNullValue($('#TB_GR_DELY_DATE').val())) {
		alert("입고예정일은 필수 입력 항목입니다..");
		return false;
	}
	
	if (isNullValue($('#TB_GR_DELY_TIME').val())) {
		alert("입고예정시간은 필수 입력 항목입니다..");
		return false;
	}
	
	if (isNullValue($('#TB_GR_PERSON_NAME').val())) {
		alert("입고담당자는 필수 입력 항목입니다..");
		return false;
	}
	
	if (isNullValue($('#TB_GR_PERSON_TEL').val())) {
		alert("연락처는 필수 입력 항목입니다..");
		return false;
	}	
	
	// 그리드 전체 데이터를 수집하기 윟 전체 체크박스 선택 처리
	for(var i = 0; i < gridView.getRowCount(); i++){
		gridView.checkItem(i, true);
	}
	var params = fnGetParams();
	
	$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ITEM_QTY", "MAKER_LOT_NO", "MAKER_LOT_NO", "MAKER_DATE", "USE_BY_DATE"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("승인요청 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/requestDueDateRegist', 'fnRequest', params);
	     }
	}
}

//승인요청취소
function fnCancel() {
	// 그리드 수정사항 확정처리
	gridView.commit();
	
	if (nvl($("#TB_DOC_STATUS").val(), '1') != "2") {
		alert("승인요청 상태에서만 취소 가능합니다.");
		return false;
	}
	
	for(var i = 0; i < gridView.getRowCount(); i++){
		gridView.checkItem(i, true);
	}
	var params = fnGetParams();
	
	$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ITEM_QTY", "MAKER_LOT_NO", "MAKER_LOT_NO", "MAKER_DATE", "USE_BY_DATE"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("승인요청 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/cancelDueDateRegist', 'fnCancel', params);
	     }
	}
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
	
	$("#TB_DOC_NO").val(result.fields.result.TB_DOC_NO);
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

/**
 * 승인요청 성공
 */
function fnRequestSuccess(result) {
	alert("승인요청되었습니다.");
	
	$("#TB_DOC_NO").val(result.fields.result.TB_DOC_NO);
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

/**
 * 승인요청취소 성공
 */
function fnCancelSuccess(result) {
	alert("승인요청취소되었습니다.");
	
	$("#TB_DOC_NO").val(result.fields.result.TB_DOC_NO);
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

//행추가
function fnRowAdd() {
	
	var checkList = gridView.getCheckedItems();
	
	if(checkList.length == 0) {
	    alert("복사 대상을 선택하셔야 합니다.");
	    return false;
	} else if (checkList.length > 1) {
	    alert("한건 씩 복사 가능합니다.");
	    return false;		
	}
	
	var values = fnGetGridRowParams(gridView, checkList[0]);
	values.CRUD = "I";
	fnAddRow(gridView, values, checkList[0]+1);
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

//삭제
function fnDel() {
	
	if (isEmpty($("#TB_DOC_NO").val())) {
		alert("등록 후 삭제 가능합니다.");
		return false;
	}	
	
	if (nvl($("#TB_DOC_STATUS").val(), '1') != "1") {
		alert("작성중 상태에서만 삭제 가능합니다.");
		return false;
	}
	
	var params = fnGetParams();
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/wrh/deleteDueDateRegist', null, params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
}



/**
 * 입고예정일 팝업
 */
function fnSearchDelyDate() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"P_MENU_CD": '${PARAM.G_MENU_CD}' + '_P'});
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
	$("#TB_GR_DELY_DATE").val(rows.DELY_DATE_GRID);
	$("#TB_GR_DELY_TIME").val(rows.DELY_TIME_GRID);
	//$("#TB_GR_DELY_DATETIME").val(rows.DELY_DATE_TIME);
}


</script>
<div class="tit-area">
    <h3>입고예정상세등록</h3>
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
                    	<input type="text" id="TB_COMP_NM" name="TB_COMP_NM" value="" readonly="readonly"/>
                    	<input type="hidden" id="TB_COMP_CD" name="TB_COMP_CD" value="">
                    </td>
                    <th><span>플랜트</span></th>
                    <td>
                    	<input type="text" id="TB_PLANT_NAME" name="TB_PLANT_NAME" value="" readonly="readonly"/>
                    	<input type="hidden" id="TB_PLANT_CODE" name="TB_PLANT_CODE" value="">
                    </td>
					<th><span>입고장소</span></th>
                    <td>
                    	<input type="text" id="TB_LOCATION_TXT" name="TB_LOCATION_TXT" value="" readonly="readonly"/>
                    	<input type="hidden" id="TB_LOCATION" name="TB_LOCATION" value="">
                    </td>
                    <td>
                    	<input type="hidden" id="TB_PO_ORG"     name="TB_PO_ORG" value="">
                    	<input type="hidden" id="TB_PO_ORG_NM"  name="TB_PO_ORG_NM" value="">
                    	<input type="hidden" id="TB_DOC_STATUS" name="TB_DOC_STATUS" value="">
                    </td>
                </tr>            
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly"/>
                    </td>
                    <th><span>입고예정일</span></th>
                    <td>
                    	<input type="text" class="datepicker t_center" style="width:120px;" id="TB_GR_DELY_DATE" value=""/>
                    	<input type="hidden" id="GR_DELY_DATE_OLD" name="GR_DELY_DATE_OLD" value="">
                    </td>
                    <th><span>입고예정시간</span></th>
                    <td>
                        <input type="text"  id="TB_GR_DELY_TIME" style="width:120px;text-align:center" value="" readonly="readonly"/>
                        <a href="javascript:fnSearchDelyDate();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>                    
                    <td></td>
                </tr>
                <tr>
                    <th><span>입고담당자</span></th>
                    <td>
                        <input type="text"  id="TB_GR_PERSON_NAME" value=""/>
                    </td>
                    <th><span>연락처</span></th>
                    <td>
                        <input type="text"  id="TB_GR_PERSON_TEL" value=""/>
                    </td>
                    <th><span>문서번호</span></th>
                    <td>
                        <input type="text"  id="TB_DOC_NO" value="" readonly="readonly"/>
                    </td>
                    <td></td>
                </tr>
				<tr>
					<th><span>비고</span></th>
					<td colspan="3">
						<textarea rows="1" id="TB_VENDOR_DOC_TXT"></textarea>
					</td>
					<td></td>
				</tr>                                
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
</div><!-- // search_field_wrap -->
<br>
<div class="sub-tit">
    <div class="btnArea t_right">
<!--     	<button type="button" class="btn" id="btnSearch">조회</button> -->
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnCancel">승인취소</button>
        <button type="button" class="btn" id="btnRequest">승인요청</button>
        <button type="button" class="btn" id="btnDel">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
