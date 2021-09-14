<%--
	File Name : bdgExecBugtMgt.jsp
	Description: 예산 > 예산관리 > 실행예산신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.14  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.14
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var apprCodes  = new Array();
var apprLabels = new Array();

var accountNo    = "";
var accountDesc  = "";
var remark       = "";
var rowIndex     = "";
var d3Cnt        = 0;
var wCode        = "";
var apprCnt      = "1";

var processTypeCodes  = new Array();
var processTypeLabels = new Array();

var processType  = "";

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,  'CODE', 'CODE_NM');
	
	fnCompCdChange();
	
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
    
    var epsDocNo = '${PARAM.EPS_DOC_NO}';
    if(isNotEmpty(epsDocNo) == true){
    	$("#EPS_DOC_NO").val(epsDocNo);
    	fnSearch();
    }

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	fnCompCdChange();
	$("#TB_CRTN_YYMM").val('${PARAM.TB_CRTN_YYMM}');
	$("#SB_CCTR_CD").val('${PARAM.SB_CCTR_CD}');

}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS_NM',            {text:'승인상태'},       60,            'text',              {textAlignment:"center"});
    addField(cm,    'PROCESS_TYPE',         {text:'구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
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
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트센터코드'},           0,     'text', {textAlignment: "center"},{visible:false});

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
    gridHeader.setColumnProperty("ACCOUNT_NO"  , "mergeRule", {criteria:"value"});
    gridHeader.setColumnProperty("ACCOUNT_DESC", "mergeRule", {criteria:"value"});
    gridHeader.setColumnProperty("GUBN_NM"     , "mergeRule", {criteria:"value"});

    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
        if (data.fieldName == "ACCOUNT_NO") {
        	accountNo   = gridView.getValue(data.itemIndex,"ACCOUNT_NO");
        	accountDesc = gridView.getValue(data.itemIndex,"ACCOUNT_DESC");
        	processType = gridView.getValue(data.itemIndex,"PROCESS_TYPE");
        	rowIndex    = data.itemIndex;
        	
        	$("#TB_ACCOUNT_NO").val(gridView.getValue(data.itemIndex,"ACCOUNT_NO"));
        	$("#TB_ACCOUNT_DESC").val(gridView.getValue(data.itemIndex,"ACCOUNT_DESC"));
        	
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
        		$("#div_btnD").show();     		
        		gridDetail.setColumnProperty("BELONG_CCTR_NM", "visible", false);
        		gridDetail.setColumnProperty("PROJECT", "visible", false);
        	}
        	
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
    addField(cm,    'BELONG_CCTR_NM',       {text:'귀속코스트명'},    150,            'text',              {textAlignment:"center"},{visible:false});
    addField(cm,    'PROJECT',              {text:'내무오더'},  150,            'text',               {textAlignment:"center"},{visible:false});
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
    addField(cm,    'BELONG_CCTR_CD',        {text:'귀속부서코드'},           0,            'text', {textAlignment: "center"},{visible:false});
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
        ,viewCount      : true       //조회 건수 표시
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
    
    gridDetail.setColumnProperty("DETAIL_DESC"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("M01"          , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("M02"          , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("M03"          , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("CRTN_MM"      , "dynamicStyles", columnDefaultStyles);
    
    gridDetail.setColumnProperty("PROJECT_NM"    , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("BELONG_CCTR_NM", "dynamicStyles", columnDefaultStyles);  
    gridDetail.setColumnProperty("GUBN"          , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("BELONG_CCTR_CD", "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("PROJECT"       , "dynamicStyles", columnDefaultStyles);
    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
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
 * 조회
 */
function fnSearch() {
	if (apprCnt == "0") {
		alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
		return false;			
	}		
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectExecBugtMgtHeadListPop');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	if (isNotEmpty(data.fields.result.CNT)) {
		apprCnt = data.fields.result.CNT;
		if (data.fields.result.CNT == "0") {
			alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
			return false;			
		}
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
 * 실행예산상세
 */
function fnSearchDetail() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, fnGetGridRowParams(gridHeader, gridHeader.getCurrent().itemIndex));
	
	searchCall(gridDetail, '/com/bdg/selectExecBugtMgtDetailList', 'fnSearchDetail', params);
}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled>
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
                    	<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM" dateHolder="bgn" value="" style="width:70px;" disabled/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" disabled>
	                    </select>
                    </td>
<%--                     <th><span>승인상태</span></th> --%>
<!--                     <td> -->
<%-- 	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" disabled> --%>
<%-- 	                    </select> --%>
<!--                     </td>                     -->
                    <td></td>
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
</div><!-- // search_field_wrap -->
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
				    <input type="hidden" id="EPS_DOC_NO"/>
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
<br>
<div class="realgrid-area">
    <div id="gridTotal"></div> 
</div>