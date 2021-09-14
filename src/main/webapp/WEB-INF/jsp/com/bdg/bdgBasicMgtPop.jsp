<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 기본예산신청(EPS)
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.12  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.12
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var apprCodes  = new Array();
var apprLabels = new Array();

var processTypeCodes  = new Array();
var processTypeLabels = new Array();

var processType  = "";
var accountNo    = "";
var accountDesc  = "";
var remark       = "";
var rowIndex     = "";
var wCode        = "";
var apprCnt      = "1";

$(document).ready(function() {
	
    // 회사 코드 셋팅
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,  'CODE', 'CODE_NM');
	
	fnCompCdChange();


	apprCodes  = getComboSet('${CODELIST_YS001}', 'CODE');
	apprLabels = getComboSet('${CODELIST_YS001}', 'CODE_NM');
	
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	
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
	
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	fnCompCdChange();
	$("#TB_CRTN_YY").val('${PARAM.TB_CRTN_YY}');
	$("#SB_CCTR_CD").val('${PARAM.SB_CCTR_CD}');

}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '승인상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:apprCodes,labels:apprLabels, editable:false},'dropDown');
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'textLink',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        140,            'text',              {textAlignment:"near"});
    // 당기수정기본예산 : 2020년 기준 2019년 당기수정예산
    addField(cm,    'A_BUDGET',             {text:'당기기본예산'},  100,            'integer',           {textAlignment:"far"});
    // 산정추정 : 2019년 1월 ~ 9월 실적 + 2019년 10월 ~ 12월 수정기본예산 합
    addField(cm,    'B_BUDGET',             {text:'산정추정'},      100,            'integer',           {textAlignment:"far"});
    // 예상추정 : 산정추정값과 동일하고 수정 가능
    addField(cm,    'PRESUME_AMT',          {text:'예상추정'},      100,            'integer',           {textAlignment:"far"});
    // 집행률 : 예상추정 / 당기수정기본예산
    addField(cm,    'D_BUDGET',             {text:'집행율'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'WK_M01',               {text:'1월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'A_SUM',                {text:'상반기'},         100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'B_SUM',                {text:'하반기'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'C_SUM',                {text:'합계'},          100,            'integer',           {textAlignment:"far"});
    // 예산증감률 :  수정기본예산 / 1월 ~12월 합계
    addField(cm,    'A_RATE',               {text:'예산증감율'},    100,            'number',           {textAlignment:"far"});
    // 산정증감율 :  산정추정 / 1월 ~12월 합계
    addField(cm,    'B_RATE',               {text:'산정증감율'},    100,            'number',           {textAlignment:"far"});
    // 예산증감율 :  예상추정 / 1월 ~12월 합계
    addField(cm,    'C_RATE',               {text:'예상증감율'},    100,            'number',           {textAlignment:"far"});
    addField(cm,    'REMARK',               {text: '증감요인'},     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'COMP_CD',                {text: 'COMP_CD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YY',                {text: 'CRTN_YY'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',                 {text: 'CCTR_CD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'W_CODE',             {text: '위탁연구비코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});

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

    gridHeader.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
        if (colIndex.fieldName == "ACCOUNT_NO") {
        	accountNo   = gridView.getValue(colIndex.itemIndex,"ACCOUNT_NO");
        	accountDesc = gridView.getValue(colIndex.itemIndex,"ACCOUNT_DESC");
        	remark      = gridView.getValue(colIndex.itemIndex,"REMARK");
        	processType = gridView.getValue(colIndex.itemIndex,"PROCESS_TYPE");
        	rowIndex    = colIndex.itemIndex;
        	
        	$("#TB_ACCOUNT_NO").val(gridView.getValue(colIndex.itemIndex,"ACCOUNT_NO"));
        	$("#TB_ACCOUNT_DESC").val(gridView.getValue(colIndex.itemIndex,"ACCOUNT_DESC"));
        	$("#TB_REMARK").val(gridView.getValue(colIndex.itemIndex,"REMARK"));
        	$("#TB_PRESUME_AMT").val(gridView.getValue(colIndex.itemIndex,"PRESUME_AMT"));
        	
        	//위탁연구비 계정일때만 보이게 처리
        	if($("#TB_ACCOUNT_NO").val() == wCode){
        		gridDetail.setColumnProperty("PROJECT", "visible", true);
        	} else {
        		gridDetail.setColumnProperty("PROJECT", "visible", false);
        	}
        	
        	if (processType == "2") {
        		$("#div_btnD").hide();
        		gridDetail.setColumnProperty("DETAIL_DESC", "visible", false);
        		gridDetail.setColumnProperty("BELONG_CCTR", "visible", true);
        	} else {
        		$("#div_btnD").show();
        		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
        		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);
        	}        	
        	
        	fnSearchDetail();
        }
    };

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    };
    
    gridHeader.setFixedOptions({
    	  colCount: 3
    });
    
    fnGridSortFalse(gridHeader);
    gridHeader.setDisplayOptions({columnMovable:false})

}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'DETAIL_DESC',          {text:'구분'},       60,            'text',              {textAlignment:"center"});
    addField(cm,    'BELONG_CCTR',          {text:'귀속코스트센터'},   140,            'text',              {textAlignment:"near"});
    addField(cm,    'PROJECT',              {text:'내부오더'},  100,            'text',              {textAlignment:"center"},{visible:false});
    addField(cm,    'UNIT_PRICE',           {text:'단가'},       100,            'integer',           {textAlignment:"far"});
    addField(cm,    'UNIT_QTY',             {text:'수량'},       100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M01',               {text:'1월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'A_SUM',                {text:'상반기'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'B_SUM',                {text:'하반기'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'C_SUM',                {text:'합계'},          100,            'integer',           {textAlignment:"far"});
    
    addField(cm,    'CRUD',              {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',           {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',           {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'CCTR_CD',           {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'ACCOUNT_NO',        {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEQ_NO',            {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'BELONG_CCTR_CD',     {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PROJECT_CD',        {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PROCESS_TYPE',      {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',            {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});    

    
    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 230       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridDetail.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	var curr = grid.getCurrent();
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
        
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
            var styles = {};
            	styles.editable = false;
            return styles;
        };        
        
        setDefaultStyle(gridHeader, "dynamicStyles",columnDefaultStyles);
        setDefaultStyle(gridDetail, "dynamicStyles",columnDefaultStyles);

        
    };

    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
    };

    fnGridSortFalse(gridDetail);
    gridDetail.setDisplayOptions({columnMovable:false})
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
	searchCall(gridHeader, '/com/bdg/selectBasicMgtHeaderPop');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	} else {
		wCode = data.rows[0].W_CODE;
	}
	
	if (isNotEmpty(data.fields.result.CNT)) {
		apprCnt = data.fields.result.CNT;
		if (data.fields.result.CNT == "0") {
			alert("해당 결재진행건이 반려되어 조회할수 없습니다.")
			return false;			
		}
	}	
	
	//$("#TB_CRTN_YY").val(data.rows[0].CRTN_YY);
	//$("#SB_COMP_CD").val(data.rows[0].COMP_CD);
	
    //var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    //fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');

	
	//$("#TB_CCTR_NM").val(data.rows[0].CCTR_NM);
	//$("#SB_CCTR_CD").val(data.rows[0].CCTR_CD);

	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
		$("#TB_ACCOUNT_NO").val(accountNo);
		$("#TB_ACCOUNT_DESC").val(accountDesc);
		if(gridView.getRowCount() > 0){
			$("#TB_REMARK").val(gridView.getValue(rowIndex,"REMARK"));
		}

	    // 상태바 비활성화
	    gridHeader.closeProgress();			
	} else {
		gridDetail.clearRows();
		$("#TB_ACCOUNT_NO").val("");
		$("#TB_ACCOUNT_DESC").val("");
		$("#TB_REMARK").val("");
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridHeader.clearRows();
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
	    // 상태바 비활성화
	    gridHeader.closeProgress();			
	}
	
	rowIndex = "";

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
 * 예산상세
 */
function fnSearchDetail() {
	searchCall(gridDetail, '/com/bdg/selectBasicMgtDetail', 'fnSearchDetail');
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD"  disabled="disabled">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
						<input type="text" id="TB_CRTN_YY"  style="width:70px;" disabled/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" disabled="disabled">
	                    </select>
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
</div><!-- // search_field_wrap -->
    <div class="tbl-search-area">
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
<div class="realgrid-area">
    <div id="gridHeader"></div> 
</div>
<table class="tbl-view">
	<colgroup>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th><span>증감요인<br> &lt;산정증감  ±10%이상시&gt;</span></th>
			<td>
				<textarea rows="2" id="TB_REMARK"></textarea>
			</td>
		</tr>
	</tbody>
</table>
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
				    <input type="hidden" id="TB_PRESUME_AMT"/>
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
