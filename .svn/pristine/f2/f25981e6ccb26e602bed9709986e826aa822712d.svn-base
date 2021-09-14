<%--
	File Name : bdgVendBankMgt.jsp
	Description: 예산 > 부가정보 > 공급업체계좌등록(EPS)
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.18  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.18
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

var condCodes  = new Array();
var condLabels = new Array();

var compList = new Array();
var condList = new Array();

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

}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
    

  
    addField(cm,    'VENDOR_CD',            {text:'업체코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'POBUSI_NO',            {text:'사업자번호'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'VENDOR_NM',            {text:'업체명'},         100,            'textLink',           {textAlignment:"near"});
    
    addField(cm,    'PRESIDENT_NM',         {text:'대표자명'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'BUSS_TYPE',            {text:'업종'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'BUSIN',                {text:'업태'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'TEL_NO',               {text:'대표전화번호'},         100,            'text',           {textAlignment:"near"});
    
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EMAIL',                {text: 'EMAIL'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridHeader.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 250       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
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
        	//구별되기 위해 체크박스 체크
        	gridHeader.checkItem(data.itemIndex, true);
        	// 기등록 데이터인 경우만 상세조회
        	if (values.CRUD == 'R') {
        		fnSearchDetail();	
        	}
        }
        
    };

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    };
    
}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'SAP_RECV_YN',          {text: 'SAP등록여부'},    80,            'text',           {textAlignment:"center"});
	addField(cm,    'STATUS',               {text: '진행상태'},       80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'BANK_CD',              {text: '은행'},       150,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:bankCodes,labels:bankLabels},'dropDown');
    addField(cm,    'BANK_ACCOUNT_NO',      {text: '계좌번호'},       150,            'text',           {textAlignment:"near"});
    addField(cm,    'BANK_USER',            {text: '예금주'},         100,            'text',           {textAlignment:"center"},{visible:false});
    addField(cm,    'BANK_DESC',            {text: '예금주'},        150,            'text',           {textAlignment:"near"});
    addField(cm,    'PAY_COND',             {text: '지급조건'},       150,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:condCodes,labels:condLabels},'dropDown');

    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YMD',             {text: '기준년월일'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'POBUSI_NO',            {text: '사업자 번호'},           0,     'text', {textAlignment: "center"},{visible:false});
    
    addField(cm,    'RETURN_DESC',          {text: '반려사유'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BANK_NATION',          {text: '은행국가키'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'BANK_ACCOUNT_ID',      {text: '은행ID'},           0,     'text', {textAlignment: "center"},{visible:false});
    
    
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 200       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
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
    	
    	if (field == 6) {
    		gridDetail.setRowValue(itemIndex, "BANK_ACCOUNT_ID" ,getComboValue(condList, "ATTR01", getComboIndex(condList, "CODE", newValue)));
    	}
    };    
}

/**
 * 조회
 */
function fnSearch() {
	//초기화
	rowIndex = -1;
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectVendBankMgtHeadListPop');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
		gridDetail.clearRows();
	} else {
		rowIndex = 0;
		$('#TB_CRTN_YMD').val(data.rows[0].TB_CRTN_YMD);
		$('#SB_COMP_CD').val(data.rows[0].COMP_CD);
		$('#TB_ORG_NM').val(data.rows[0].ORG_NM);
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
                    <th><span>신청일자</span></th>
                    <td>
                    	<input type="text" id="TB_CRTN_YMD" value="" style="width:90px;" disabled/>
                    </td>
                    <th><span>부서명</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" style="text-align: near;" disabled>
                        <input type="hidden" id="TB_ORG_CD">
                        <input type="hidden" id="EPS_DOC_NO"/>
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
</div>
<div class="realgrid-area">
    <div id="gridHeader"></div> 
</div>
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:400px">
                <col>
            </colgroup>
	        <tr>
				<th><span>계좌정보</span></th>
	        	<td></td>
	        	<td></td>
	        </tr>
		</table>
	</div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
