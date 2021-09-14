<%--
	File Name : wrhSerialRegister.jsp
	Description: 입고관리 > 입고예정 > 입고품목별일련번호등록
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.12.10  박종용           최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.12.10
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
var scrollItem = 470;
var compCodes  = new Array();
var compLabels = new Array();

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 기간 시작인 셋팅
	$("#TB_GR_DELY_DATE").val(getDiffDay("m",0));
	
	$("#TB_VENDOR_CD").val('${LOGIN_INFO.VENDOR_CD}');
	$("#TB_VENDOR_NM").val('${LOGIN_INFO.VENDOR_NM}');	
}


function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PROD_ID',           {text: '제품ID(RFID/2D)'},      100,     'text', {textAlignment: "center"});
    addField(cm,    'STND_CD',           {text: '표준코드'},      70,      'text',     {textAlignment: "center"});
    addField(cm,    'MNFC_NB',           {text: '제조번호'},     100,      'text',     {textAlignment: "center"});
    addField(cm,    'MNFC_DATE',         {text: '제조일자'},      100,     'text',     {textAlignment: "center"});
    addField(cm,    'DSTR_DATE',         {text: '유통기간'},      100,     'text',     {textAlignment: "center"});
    addField(cm,    'LBOX_ID',           {text: '대박스ID'},      130,     'text',     {textAlignment: "near"});
    addField(cm,    'RECV_YN',           {text: '수신여부'},       50,     'text',     {textAlignment: "center"});
    
    addField(cm,    'VENDOR_CD',         {text: '업체코드'},     0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'SEQ',               {text: '시퀀스'},       0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_DELY_DATE',      {text: '입고예정일'},    0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_DELY_TIME',      {text: '입고예정시간'},   0,     'text',     {textAlignment: "center"}, {visible:false});
    
    addField(cm,    'CRUD',              {text: 'CRUD'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'CRE_DATE',          {text: '등록일'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'CRE_USER',          {text: '등록자'},      0,     'number',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MOD_DATE',          {text: '수정일'},      0,     'number',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MOD_USER',          {text: '수정자'},      0,     'number',     {textAlignment: "center"}, {visible:false});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.onDataCellClicked = function (grid, colIndex) {
    };

    
    gridView.onRowsPasted = function(grid, items){
       	for(var i = 0; i < items.length; i++){
       		var values = grid.getValues(items[i]);
           	gridView.setValue(items[i], "VENDOR_CD", $("#TB_VENDOR_CD").val());
           	gridView.setValue(items[i], "GR_DELY_DATE", $("#TB_GR_DELY_DATE").val());
           	gridView.setValue(items[i], "GR_DELY_TIME", $("#TB_GR_DELY_TIME").val());
           	gridView.setValue(items[i], "CRUD", 'I');
           	gridView.checkItem(items[i], true);
       	}
    	
    };
    
    gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 450;
            loadNext();
        }
    }    
    
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWrhSerialRegisterList');
}

function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+499});
    
    ajaxJsonCall('<c:url value="/com/wrh/selectWrhSerialRegisterList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	gridView.refresh();
	gridView.clearRows();
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();	
}

//행삭제
var fnRowDel = function(){
	fnAddRowDelete(gridView);
}

//행추가
function fnRowAdd() {
	if(isEmpty($("#TB_GR_DELY_DATE").val()) || isEmpty($("#TB_GR_DELY_TIME").val())){
		alert("입고예약일과 예약시간을 선택해야 합니다.");
		return false;
	}
	
	var values = {"VENDOR_CD" :  $("#TB_VENDOR_CD").val(), "GR_DELY_DATE" : $("#TB_GR_DELY_DATE").val(), "GR_DELY_TIME":$("#TB_GR_DELY_TIME").val(), "CRUD" : "I"};
	fnAddRow(gridView, values);
}


function fnSearchTime() {
	var params    = {};
	$.extend(params, fnGetParams());
	var target    = "dateTimeSearchPop";
	var width     = "460";
	var height    = "500";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/wrh/wrhDateTimeSearchPop', params, target, width, height, scrollbar, resizable);
	
}


//양식지 다운로드
function fnDownLoad() {
	oneFileDownload('${dataInfo.ATTACHMENT}', '${dataInfo.ATTACH_SEQ}');

}

/**
 * 팝업 콜백
 */
function fnCallbackDelyDateSearchPop(rows) {
	$("#TB_GR_DELY_TIME").val(rows.DELY_TIME);
	fnSearch();
}

/**
 * 저장
 */
function fnSave() {
	if(isEmpty($("#TB_GR_DELY_DATE").val()) || isEmpty($("#TB_GR_DELY_TIME").val())){
		alert("입고예약일과 예약시간을 선택해야 합니다.");
		return false;
	}
	
	gridView.commit();
	gridView.checkAll(true,false);
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});
	
	if(gridView.getCheckedItems(false).length == 0){
		alert("데이터가 없습니다.");
		return false;
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = [];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?\n기등록된 데이터는 삭제하고 저장됩니다.")){
	    	 saveCall(gridView, '/com/wrh/saveSerialRegister', null, params);
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

//삭제
function fnDel() {
	
	var params = fnGetParams();
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/wrh/deleteSerialRegister', null, params);
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

function fnExcelUpload() {
	if(isEmpty($("#TB_GR_DELY_DATE").val()) || isEmpty($("#TB_GR_DELY_TIME").val())){
		alert("입고예약일과 예약시간을 선택해야 합니다.");
		return false;
	}
	
	 $('#excelFile').click();
}

function excelExport(event){
	var files = event.target.files;
	var i, f;
	for (i = 0, f = files[i]; i != files.length; ++i) {
	    var reader = new FileReader();
	    var name = f.name;
	    reader.onload = function (event) {
	        var data = event.target.result;
	
	        //var workbook = XLSX.read(data, { type: 'binary' });
	        var arr = fixdata(data);
	        workbook = XLSX.read(btoa(arr), { type: 'base64' });
	
	        process_wb(workbook);
	        /* DO SOMETHING WITH workbook HERE */
	    };
	    //reader.readAsBinaryString(f);
	    reader.readAsArrayBuffer(f);
	
	}
}

function process_wb(wb) {
    var output = "";
 
    output = to_json(wb);
 
    var sheetNames = Object.keys(output);
    
    output[sheetNames]
 
    if (sheetNames.length > 0) {
        var colsObj = output[sheetNames[0]][0];
//	        var colsObj = output[sheetNames][0];
 
        if (colsObj) {
            setFieldsSetColumns(colsObj);
            var dataProvider = gridView.getDataProvider();
            dataProvider.fillJsonData(output, { rows: sheetNames[0], start: 1 })
        }
    }

    for(var i = 0; i < gridView.getRowCount(); i++){
    	gridView.setValue(i, "VENDOR_CD", '${LOGIN_INFO.VENDOR_CD}');
    	gridView.setValue(i, "SEQ", i);
    	gridView.setValue(i, "GR_DELY_DATE", $("#TB_GR_DELY_DATE").val());
    	gridView.setValue(i, "GR_DELY_TIME", $("#TB_GR_DELY_TIME").val());
    }
    
    gridView.setColumnProperty("VENDOR_CD"    , "visible", false);
    gridView.setColumnProperty("SEQ"          , "visible", false);
    gridView.setColumnProperty("GR_DELY_DATE" , "visible", false);
    gridView.setColumnProperty("GR_DELY_TIME" , "visible", false);
    
    fnSave();
}
 
function setFieldsSetColumns(colsObj) {
    var fields = [];
    var columns = [];
 
    var colNames = Object.keys(colsObj);
 
    for (var i = 0 ; i < colNames.length ; i++) {
        var field = {};
        field.fieldName = colNames[i];
        fields.push(field);
 
        var column = {}
        column.name = field.fieldName;
        column.fieldName = field.fieldName;
        column.header = { text: colsObj[colNames[i]] };
        columns.push(column);
    }
    
    
    var dataProvider = gridView.getDataProvider();
    dataProvider.setFields(fields);
    gridView.setColumns(columns);
}

function fixdata(data) {
    var o = "", l = 0, w = 10240;
    for (; l < data.byteLength / w; ++l) o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w, l * w + w)));
    o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l * w)));
    return o;
}


function to_json(workbook) {
    var result = {};
    workbook.SheetNames.forEach(function (sheetName) {
        var roa = XLSX.utils.sheet_to_row_object_array(workbook.Sheets[sheetName], { header: gridView.getColumnNames() });
        if (roa.length > 0) {
            result[sheetName] = roa;
        }
    });
    return result;
}

</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.14.3/xlsx.full.min.js"></script>
    <form name="downForm" target="dowmloadFilePop">
		<input type="hidden" id="APP_SEQ" name="APP_SEQ" value="<c:out value="${dataInfo.ATTACHMENT }" />" />
		<input type="hidden" id="ATTACH_SEQ" name="ATTACH_SEQ" value="<c:out value="${dataInfo.ATTACH_SEQ }" />" />
    </form>

<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
</div>
<input type="file" id="excelFile" onchange="excelExport(event)"/>
<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:80px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly"/>
                    </td>
                    <th><span>입고예약일</span></th>
                    <td>
                    	<input type="text" class="datepicker t_center" id="TB_GR_DELY_DATE" onchange="fnSearch()"	style="width: 90px;"/>
                    </td>
                    <th><span>입고예약시간</span></th>
                    <td>
                        <input type="text"  id="TB_GR_DELY_TIME" style="width: 55px;"  readonly="readonly"/>
                        <a href="javascript:fnSearchTime();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
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
        <button type="button" class="btn" id="btnDownLoad">양식지다운로드</button>
        <button type="button" class="btn" id="btnExcelUpload">엑셀업로드</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDel">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
<script type="text/javascript" src="../../../resources/js/shim.js"></script>
<script type="text/javascript" src="../../../resources/js/xlsx.js"></script>
