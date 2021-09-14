<%--
	File Name : bdgApmBasicMgtPop.jsp
	Description:예산 > 영업관리 > APM예산신청(EPS)
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.28  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.28
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var statusCodes  = new Array();
var statusLabels = new Array();
var chcCtcCodes  = new Array();
var chcCtcLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var statusList  = stringToArray("${CODELIST_YS010}");
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");

	var etcGubnList  = stringToArray("${CODELIST_YS012}");
	fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList,     'CODE', 'CODE_NM', null);

	statusCodes  = getComboSet('${CODELIST_YS010}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS010}', 'CODE_NM');
	
	chcCtcCodes  = getComboSet('${CODELIST_YS012}', 'CODE');
	chcCtcLabels = getComboSet('${CODELIST_YS012}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
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

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '진행상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'CHC_ETC_GBN',          {text:'부문'},       60,            'text',              {textAlignment:"center"},{lookupDisplay: true,values:chcCtcCodes,labels:chcCtcLabels, editable: false},'dropDown');
    addField(cm,    'REQ_ORG_CD',           {text:'부서코드'},        80,            'text',              {textAlignment:"center"});
    addField(cm,    'REQ_ORG_NM',           {text:'부서명'},  100,            'text',           {textAlignment:"near"});
    addField(cm,    'REQ_SABUN',            {text:'사원코드'},      100,            'text',           {textAlignment:"center"});
    addField(cm,    'REQ_SABUN_NM',         {text:'사원명'},      60,            'text',           {textAlignment:"center"});
    
    addField(cm,    'TERM_BUGT_AMT',       {text:'당기예산'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'TERM_TRANS_SEND_AMT', {text:'당기이관송신액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'TERM_TRANS_RECV_AMT', {text:'당기이관수신액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'TERM_USE_AMT',        {text:'당기사용액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'BAL_AMT',             {text:'당월잔액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'NEW_BUGT_AMT',        {text:'신규예산'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'MAKE_ID',             {text:'작성자'},        60,            'text',           {textAlignment:"center"});
    addField(cm,    'MAKE_DATE',           {text:'작성일자'},        80,            'text',           {textAlignment:"center"});
    addField(cm,    'CANCEL_REASON',       {text:'취소사유'},        250,            'text',           {textAlignment:"near"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',              {text: '코스트센터'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'PRE_BAL_AMT',          {text: '전월잔액'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'CARD_NO',              {text: '카드번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'BANK_KEY',             {text: '은행키'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ACC_NO',               {text: '계좌번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SAP_SEND_YN',          {text: 'SAP전송여부'},     0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'EPS_DOC_NO',           {text: '전자결재문서번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SYS_MGMT_NO',          {text: '시스템관리번호'},        0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
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


    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
       		fnSearchUser();
       	}

    };
    
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn = values.STATUS;
        if (gubn == '1' || gubn == '5') {
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
    
    setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
	gridView.setColumnProperty("NEW_BUGT_AMT"  , "dynamicStyles", columnDynamicStyles);
    
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectApmBasicMgtPop');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	
	$("#TB_CRTN_YYMM").val(data.rows[0].CRTN_YYMM);
	$("#SB_COMP_CD").val(data.rows[0].COMP_CD);
	$("#TB_DEPT_NM").val(data.rows[0].REQ_ORG_NM);
	$("#TB_DEPT_CD").val(data.rows[0].REQ_ORG_CD);

	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();
    
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
						<input type="text" id="TB_CRTN_YYMM"  style="width:70px;" disabled/>
                    </td>
                    <th><span>부서</span></th>
                    <td>
                        <input type="text"   id="TB_DEPT_NM" disabled>
                        <input type="hidden" id="TB_DEPT_CD">
				    	<input type="hidden" id="EPS_DOC_NO"/>
                    </td>
                    <td></td>
                </tr>
<!--                 <tr> -->
<%--                     <th><span>부문</span></th> --%>
<!--                     <td> -->
<%-- 	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN"> --%>
<%-- 	                    </select> --%>
<!--                     </td> -->
<%--                     <th><span>진행상태</span></th> --%>
<!--                     <td> -->
<%--                         <select id="SB_STATUS" name="SB_STATUS"> --%>
<%--                         </select> --%>
<!--                     </td> -->
<!--                     <td></td> -->
<!--                 </tr> -->
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
    <div id="gridView"></div> 
</div>