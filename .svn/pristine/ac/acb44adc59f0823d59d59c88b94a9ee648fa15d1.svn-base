<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 추가예산신청 > 출장비 상세내역
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.12.02  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.12.02
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
var travelGubnCodes  = new Array();
var travelGubnLabels = new Array();

var wayGubnCodes  = new Array();
var wayGubnLabels = new Array();

var tripGubnCodes  = new Array();
var tripGubnLabels = new Array();

$(document).ready(function() {
	
	travelGubnCodes  = getComboSet('${CODELIST_YS036}', 'CODE');
	travelGubnLabels = getComboSet('${CODELIST_YS036}', 'CODE_NM');

	wayGubnCodes  = getComboSet('${CODELIST_YS037}', 'CODE');
	wayGubnLabels = getComboSet('${CODELIST_YS037}', 'CODE_NM');
	
	tripGubnCodes  = getComboSet('${CODELIST_YS038}', 'CODE');
	tripGubnLabels = getComboSet('${CODELIST_YS038}', 'CODE_NM');	

	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    // pdfDivHtml 숨기기
    pdfDivHide();    
    
    //자동조회
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$('#SB_COMP_CD').val('${PARAM.SB_COMP_CD}');
	$('#SB_COMP_NM').val('${PARAM.SB_COMP_NM}');
	$('#TB_CRTN_YMD').val('${PARAM.TB_CRTN_YMD}');
	$('#SB_CCTR_CD').val('${PARAM.SB_CCTR_CD}');
	$('#TB_ACCOUNT_NO').val('${PARAM.ACCOUNT_NO}');
	$('#STATUS').val('${PARAM.STATUS}');
	$('#REQUEST_AMT').val('${PARAM.REQUEST_AMT}');
	
	if (isNotEmpty('${PARAM.STATUS}')) {
		if ('${PARAM.STATUS}' == '1') {
			$('#btnRowDel').show();
			$('#btnRowAdd').show();
			$('#btnDelete').show();
			$('#btnSave').show();			
		} else {
			$('#btnRowDel').hide();
			$('#btnRowAdd').hide();
			$('#btnDelete').hide();
			$('#btnSave').hide();
		}
	}
	
}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'FROM_YMD',             {text: '기간(From)'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'TO_YMD',               {text: '기간(To)'},         100,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'SABUN',                {text: '사번'},        100,            'text',              {textAlignment:"center"});
    addField(cm,    'NAME',                 {text: '이름'},        100,            'text',              {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',  	    {text: ' '},    15,     'popupLink');
    
    addField(cm,    'START_POINT',          {text: '출발지'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'VIA_POINT',            {text: '경유지'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'DEST_POINT',           {text: '도착지'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'TRAFFIC_WAY',          {text: '교통수단'},      100,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:wayGubnCodes,labels:wayGubnLabels},'dropDown');
    addField(cm,    'TRAFFIC_AMT',          {text: '교통비'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'ROOM_AMT',             {text: '숙박비'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'DAY_PAY',              {text: '일당'},      100,            'integer',           {textAlignment:"far"});
    addField(cm,    'TOT_AMT',              {text: '계'},      100,            'integer',           {textAlignment:"far"});
    
    addField(cm,    'TRAVEL_GUBN',          {text: '편도/왕복 구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:travelGubnCodes,labels:travelGubnLabels},'dropDown');
    addField(cm,    'TRIP_GUBN',            {text: '출장구분'},      150,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:tripGubnCodes,labels:tripGubnLabels},'dropDown');
    addField(cm,    'PEOPLE_NUM',           {text: '인원'},      100,            'integer',           {textAlignment:"far"});
    
    addField(cm,    'BIGO_TXT',             {text: '비고'},        250,            'text',              {textAlignment:"near"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트센터'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PROCESS_TYPE',         {text: '등록구분'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ACCOUNT_NO',           {text: '계정코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SEQ_NO',               {text: 'SEQ'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'TRAFFIC_WAY_NM',       {text: '교통수단명'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'TRAVEL_GUBN_NM',       {text: '편도/왕복 구분명'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'TRIP_GUBN_NM',         {text: '출장구분명'},        0,     'text', {textAlignment: 'center'},  {visible:false});

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
       	if(colIndex.fieldName == "CODEMAPPING1"){
       		fnSearchUser();
       	}
    };

    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
        // 동적 스타일 적용
        var columnDynamicStyles = function(grid, index, value) {
            var styles = {};
            var status = $('#STATUS').val();
            if (status == '1') {
            	$.extend(styles, enableColStyle);
            } else {
            	$.extend(styles, disibleColStyle);
            }
            return styles;
        };
        
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
        	var styles = {};
        	$.extend(styles, disibleColStyle);
            return styles;
        };  
        
        // 기본 스타일 적용
        var columnDatetStyles = function(grid, index, value) {
        	var styles = {};
            var status = $('#STATUS').val();
            if (status == '1') {
            	$.extend(styles, enableColStyle);
            	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"};
            } else {
            	$.extend(styles, disibleColStyle);
            }
            
            return styles;
        };
        
        setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
        
        gridView.setColumnProperty("FROM_YMD"    , "dynamicStyles", columnDatetStyles);
        gridView.setColumnProperty("TO_YMD"      , "dynamicStyles", columnDatetStyles);
        gridView.setColumnProperty("START_POINT" , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("VIA_POINT"   , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("DEST_POINT"  , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("TRAFFIC_WAY" , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("TRAFFIC_AMT" , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("ROOM_AMT"    , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("DAY_PAY"     , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("TRAVEL_GUBN" , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("TRIP_GUBN"   , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("PEOPLE_NUM"  , "dynamicStyles", columnDynamicStyles);
        gridView.setColumnProperty("BIGO_TXT"    , "dynamicStyles", columnDynamicStyles);
        
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    	var values = grid.getValues(itemIndex);
    	gridView.setValue(itemIndex, "TOT_AMT", toNumber(values.TRAFFIC_AMT) + toNumber(values.ROOM_AMT) + toNumber(values.DAY_PAY));
    };
    
    fnGridSortFalse(gridView);
    gridView.setDisplayOptions({columnMovable:false})
    
    
}

/**
 * 사용자 조회 팝업
 */
function fnSearchUser(gubn) {
    var params = fnGetParams();
    userPopGubn = gubn;
    params.SB_COMP_NM = $("#SB_COMP_NM").val();
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
	

	var values = {
	             "SABUN"    : rows.USER_ID
		       , "NAME" : rows.USER_NM
	     };
	
	gridView.setValues(gridView.getCurrent().itemIndex, values);		

}



/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectSupplementDetail');
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
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	if(gridView.getSelectedItems().length == 0){
		alert("저장 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	var totalAmt = 0;
	// 이관수시자 데이터를 수집하기 디테일 그리드의  체크박스 전체 선택 처리
	for(var i = 0; i < gridView.getRowCount(); i++){
		totalAmt += toNumber(gridView.getRowValue(i, "TOT_AMT"));
		gridView.checkItem(i, true);
	}
	
	if (totalAmt == toNumber($('#REQUEST_AMT').val())) {

	} else {
		alert("추가예산신청 신청액과 상세내역 합계가 불일치합니다. 확인 후 작업하세요.");
		return false;		
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["SABUN", "TOT_AMT"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
	    	 saveCall(gridView, '/com/bdg/saveSupplementDetail', null, params);
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
	
	if(isEmpty(params.ITEM_LIST.DELETED.length)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}

	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delSupplementDetail', 'fnDel', params);
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

//행추가
function fnRowAdd() {

	var values = { "CRUD" : "I" 
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YMD" : $('#TB_CRTN_YMD').val().replaceAll('-', '').replaceAll('-', '')
	              ,"CCTR_CD" : $('#SB_CCTR_CD').val()
	              ,"PROCESS_TYPE" : "1"
	              ,"ACCOUNT_NO" : $('#TB_ACCOUNT_NO').val()
	              ,"CODEMAPPING1" : "1"};
	fnAddRow(gridView, values, gridView.getRowCount());
	
}


//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

function fnCreate() {
	
	if(gridView.getRowCount() == 0){
		
		alert("조회 후 작업하세요.");
		return false;
	} else {
	    var rowCnt = gridView.getRowCount();
	    var createCnt = 0;
	    var checkCnt  = 7;
	    var viewCnt   = 1;
	    var img1;
	    
	    html = '';
	    var doc = new jsPDF('l', 'mm', 'a4');
	    for (createCnt; createCnt < rowCnt; createCnt++) {
	    	var vo = gridView.getValues(createCnt);
	    	
            html += '<tr>';
            html +=     '<td rowspan="2" style="font-size:12px;" align="center">'+ vo.FROM_YMD +'</td>';
            html +=     '<td rowspan="2" style="font-size:12px;" align="center">'+ vo.TO_YMD  +'</td>';
            html +=     '<td rowspan="2" style="font-size:12px;" align="center">'+ vo.SABUN +'</td>';
            html +=     '<td rowspan="2" style="font-size:12px;" align="center">'+ vo.NAME + '</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ nvl(vo.START_POINT,'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ nvl(vo.VIA_POINT,'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ nvl(vo.DEST_POINT,'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ vo.TRAFFIC_WAY_NM  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ nvl(addComma(vo.TRAFFIC_AMT),'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ nvl(addComma(vo.ROOM_AMT),'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ nvl(addComma(vo.DAY_PAY),'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ nvl(addComma(vo.TOT_AMT),'')  +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ vo.TRAVEL_GUBN_NM  +'</td>';
            html += '</tr>';
            html += '<tr>';
            html +=     '<td colspan="3" style="font-size:12px;" align="center">'+ vo.TRIP_GUBN_NM +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ vo.PEOPLE_NUM  +'</td>';
            html +=     '<td colspan="5" style="font-size:12px;" align="left">'+ vo.BIGO_TXT +'</td>';
            html += '</tr>';            
            
	    	if (createCnt == checkCnt && createCnt < rowCnt-1) {
	    		$('#gridPdf' + viewCnt + ' > tbody').empty();
	    		$('#pdfDiv' + viewCnt).show();
	    		$('#gridPdf' + viewCnt + ' > tbody:last').append(html);
	    		html = '';
	    		html2canvas(document.getElementById("pdfDiv" + viewCnt),{scale:2}).then(function(canvas) {
	    			eval('var img' + viewCnt + ' = canvas.toDataURL(\"image/png\");');
	    			eval('doc.addImage(img' + viewCnt + ' , \"PNG\", 0, 0, 297, 210);');
	    	    	doc.addPage();
	    		});	
	    		
	    		viewCnt++;
	    		checkCnt = checkCnt + 8;
	    	} else {
	    		// 총건수와 일치하는 경우
	    		if (createCnt == rowCnt-1) {
	    			$('#gridPdf' + viewCnt + ' > tbody').empty();
	    			$('#gridPdf' + viewCnt + ' > tbody:last').append(html);
	    			$('#pdfDiv' + viewCnt).show();
	    			html = '';
	    			if (createCnt <= checkCnt) {
	    	    		html2canvas(document.getElementById("pdfDiv" + viewCnt),{scale:2}).then(function(canvas) {
	    	    			eval('img' + viewCnt + ' = canvas.toDataURL("image/png");');
	    	    			eval('doc.addImage(img' + viewCnt + ' , "PNG", 0, 0, 297, 210);');
	    	    	    	doc.save(getDiffDay("m",0)+".pdf");
	    	    	    	
	    	    		});
	    	    		break;
	    			}
	    		}
	    	}
	    }
	    pdfDivHide();
	}
}

function pdfDivHide() {
	for (var hideDiv=1; hideDiv < 31; hideDiv++) {
		$('#pdfDiv' + hideDiv).hide();
	}
}



</script>
<div class="tit-area">
    <h3>출장비상세내역</h3>
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
	        	<td>
	        		<input type="hidden" id="SB_COMP_CD">
	        		<input type="hidden" id="SB_COMP_NM">
	        		<input type="hidden" id="TB_CRTN_YMD">
	        		<input type="hidden" id="SB_CCTR_CD">
	        		<input type="hidden" id="TB_ACCOUNT_NO">
	        		<input type="hidden" id="REQUEST_AMT">
	        		<input type="hidden" id="STATUS">
	        	</td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right">
    	<button type="button" class="btn" id="btnCreate">명세서출력</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
<div id="pdfDiv1" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf1"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv2" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf2"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv3" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf3"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv4" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf4"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv5" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf5"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv6" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf6"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv7" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf7"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv8" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf8"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv9" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf9"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv10" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf10"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv11" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf11"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv12" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf12"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv13" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf13"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv14" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf14"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv15" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf15"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv16" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf16"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv17" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf17"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv18" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf18"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv19" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf19"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv20" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf20"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv21" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf21"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv22" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf22"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv23" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf23"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv24" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf24"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv25" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf25"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv26" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf26"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv27" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf27"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv28" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf28"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv29" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf29"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>
<div id="pdfDiv30" style="padding-right:10px;width:100%;height:100%">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>국내출장비 상세내역</h3></div>
 	<table><tr><td style="text-align:center;padding-left:15px;">금액단위(원)</td></tr></table>
	<div class="pop-cont"><table class="pdf-list" id="gridPdf30"><colgroup><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:55px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup><thead><tr><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(From)</th><th rowspan="2" style="font-weight:500;font-size:12px;">출장기간(To)</th><th rowspan="2" style="font-weight:500;font-size:12px;">사번</th><th rowspan="2" style="font-weight:500;font-size:12px;">성명</th><th style="font-weight:500;font-size:12px;">출발지</th><th style="font-weight:500;font-size:12px;">경유지</th><th style="font-weight:500;font-size:12px;">도착지</th><th style="font-weight:500;font-size:12px;">종별</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">일당</th><th style="font-weight:500;font-size:12px;">계</th><th style="font-weight:500;font-size:12px;">구분</th></tr><tr><th colspan="3" style="font-weight:500;font-size:12px;">출장구분</th><th style="font-weight:500;font-size:12px;">인원수</th><th colspan="5" style="font-weight:500;font-size:12px;">비고</th></tr></thead><tbody></tbody></table></div>
</div>