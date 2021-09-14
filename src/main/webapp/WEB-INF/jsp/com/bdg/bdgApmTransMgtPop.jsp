<%--
	File Name : bdgApmTransMgt.jsp
	Description: 예산 > 영업관리 > APM예산이관신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.28  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.28
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var gridDetail;
var apprCodes  = new Array();
var apprLabels = new Array();

var accountNo    = "";
var accountDesc  = "";
var remark       = "";
var rowIndex     = -1;
var d3Cnt        = 0;

var statusCodes  = new Array();
var statusLabels = new Array();

var gubnCodes  = new Array();
var gubnLabels = new Array();

var useYnCodes  = new Array();
var useYnLabels = new Array();

var userPopGubn  = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	var gubnList   = stringToArray("${CODELIST_YS012}");
	var statusList = stringToArray("${CODELIST_YS011}");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_CHC_ETC_GBN', gubnList,     'CODE', 'CODE_NM', null, "","전체");
	fnMakeComboOption('SB_STATUS'     , statusList,     'CODE', 'CODE_NM', null, "","전체");

	statusCodes  = getComboSet('${CODELIST_YS011}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS011}', 'CODE_NM');
	
	gubnCodes  = getComboSet('${CODELIST_YS012}', 'CODE');
	gubnLabels = getComboSet('${CODELIST_YS012}', 'CODE_NM');
	
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');	

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
	$("#TB_CRTN_YYMM").val('${PARAM.TB_CRTN_YYMM}');
	$("#TB_ORG_CD").val('${PARAM.TB_ORG_CD}');
	$("#TB_ORG_NM").val('${PARAM.TB_ORG_NM}');
}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '진행상태'},      80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable:false},'dropDown');
    addField(cm,    'CHC_ETC_GBN',          {text: '부문'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:gubnCodes,labels:gubnLabels, editable:false},'dropDown');
    addField(cm,    'SEND_ORG_CD',          {text:'부서코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'SEND_ORG_NM',          {text:'부서명'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'SEND_SABUN',           {text:'사원코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'SEND_SABUN_NM',        {text:'사원명'},         100,            'textLink',           {textAlignment:"center"});
    
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    
    addField(cm,    'BAL_AMT',              {text:'당월잔액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'CANCEL_REASON',        {text:'취소사유'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_CCTR_CD',         {text: '이관코스트센터'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},           0,     'text', {textAlignment: "center"},{visible:false});

    gridHeader.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 250       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
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

    gridHeader.setColumnProperty("STATUS"       , "dynamicStyles", columnDefaultStyles);    
    gridHeader.setColumnProperty("CHC_ETC_GBN"  , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_ORG_CD"  , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_ORG_NM"  , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_SABUN"   , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("SEND_SABUN_NM", "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("BAL_AMT"      , "dynamicStyles", columnDefaultStyles);
    gridHeader.setColumnProperty("CANCEL_REASON", "dynamicStyles", columnDefaultStyles);
    
    
    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
        if (data.column == "SEND_SABUN_NM") {
        	rowIndex = data.itemIndex;
        	//구별되기 위해 체크박스 체크
        	gridHeader.checkItem(data.itemIndex, true);
        	// 상세조회
        	fnSearchDetail();
        }
        
    	// 사원정보
        if (data.column == "CODEMAPPING1" && grid.getCurrentRow().CRUD == "I") {
        	fnSearchUser('header');
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
  
    addField(cm ,   'RETURN_YN',           {text:'사내입금'},     80,           'text',              {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes, labels:useYnLabels},'dropDown');
    addField(cm,    'CHC_ETC_GBN',          {text: '부문'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:gubnCodes,labels:gubnLabels, editable:false},'dropDown');
    addField(cm,    'RECV_ORG_CD',          {text:'부서코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'RECV_ORG_NM',          {text:'부서명'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'RECV_SABUN',           {text:'사원코드'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'RECV_SABUN_NM',        {text:'사원명'},         100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},          20,     'popupLink');
    
    addField(cm,    'RECV_BAL_AMT',         {text:'수신금액'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'RECV_DATE',            {text:'이관기준일'},         100,            'text',           {textAlignment:"center"});
    
    addField(cm,    'STATUS',               {text: '승인상태코드'},       0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'RECV_CCTR_CD',         {text: '코스트센터'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_SABUN',           {text: '이관사번'},           0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEND_NO',              {text: '이관번호'},           0,     'text', {textAlignment: "center"},{visible:false});
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
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };
    
    gridDetail.setColumnProperty("RECV_BAL_AMT" , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("CHC_ETC_GBN"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_ORG_CD"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_ORG_NM"  , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_SABUN"   , "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_SABUN_NM", "dynamicStyles", columnDefaultStyles);
    gridDetail.setColumnProperty("RECV_DATE"    , "dynamicStyles", columnDefaultStyles); 
    

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
    
    gridDetail.onDataCellClicked = function (grid, data) {
        
        if (data.fieldName == "CODEMAPPING1") {
        	fnSearchUser('detail');
        }
    };
    
    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridDetail.checkItem(dataRow, true);
    };    
}

/**
 * 조회
 */
function fnSearch() {
	//초기화
	rowIndex = -1;
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectApmTransMgtPop');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
	    // 상태바 비활성화
	    gridHeader.closeProgress();	
	    
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
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var plantList = stringToArray("${CODELIST_SYSPLT}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
}

/**
 * 실행예산상세
 */
function fnSearchDetail() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, gridHeader.getValues(rowIndex));
	searchCall(gridDetail, '/com/bdg/selectApmTransMgtDetailList', 'fnSearchDetail', params);
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
                    <th><span>년월</span></th>
                    <td>
                    	<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM" dateHolder="bgn" value="" style="width:70px;"/>
<!-- 						<input type="text" id="TB_CRTN_YYMM"  style="text-align: center;" disabled> -->
                    </td>
                    <th><span>부서명</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" style="text-align: near;" disabled>
<!--                         <a href="javascript:fnSearchDept('condition');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> -->
                        <input type="hidden" id="TB_ORG_CD">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>항목</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>진행상태</span></th>
                    <td>
	                    <select id="SB_STATUS" name="SB_STATUS">
	                    </select>
	                    <input type="hidden" id="EPS_DOC_NO"/>
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
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:150px">
                <col style="width:150px">
                <col>
            </colgroup>
	        <tr>
				<th><span>이관송신자</span></th>
				<th>(단위 : 원)</th>
				<td></td>
	        </tr>
		</table>
	</div>
<!--     <div class="btnArea t_right"> -->
<!--     	<button type="button" class="btn" id="btnAppr">승인요청</button> -->
<!--     	<button type="button" class="btn" id="btnConfirm">확정</button> -->
<!--         <button type="button" class="btn" id="btnRowDel">행삭제</button> -->
<!--         <button type="button" class="btn" id="btnRowAdd">행추가</button> -->
<!--         <button type="button" class="btn" id="btnDelete">삭제</button> -->
<!--         <button type="button" class="btn" id="btnSave">저장</button> -->
<!--     </div> -->
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
				<th><span>이관수신자</span></th>
	        	<td></td>
	        	<td></td>
	        </tr>
		</table>
	</div>
<!--     <div class="btnArea t_right" id="div_btnD"> -->
<!--         <button type="button" class="btn" id="btnDetailRowDel">행삭제</button> -->
<!--         <button type="button" class="btn" id="btnDetailRowAdd">행추가</button> -->
<!--     </div> -->
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
