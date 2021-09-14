<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 현황 > 년간예산실적
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.18  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.11.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var processTypeCodes  = new Array();
var processTypeLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM');
	
	var bugtGubnList  = stringToArray("${CODELIST_YS034}");
	fnMakeComboOption('SB_BUGT_CD', bugtGubnList, 'CODE', 'CODE_NM');
	
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	
	
	fnCompCdChange();
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YY").val(getDiffDay("y",0).substring(0,4));
	//$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'text',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        140,            'text',              {textAlignment:"near"});
    addField(cm,    'DATA_GUBN_NM',         {text:'구분'},           80,            'text',              {textAlignment:"center"});
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

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridView.setColumnProperty("PROCESS_TYPE" , "mergeRule", {criteria:"value"});
    gridView.setColumnProperty("ACCOUNT_NO"   , "mergeRule", {criteria:"value"});
    gridView.setColumnProperty("ACCOUNT_DESC" , "mergeRule", {criteria:"value"});
    
    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
            var styles = {};
            	styles.editable = false;
            	styles.background = "#e4e4e4";
            return styles;
        };        
        
        //setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
    };

}

/**
 * 조회
 */
function fnSearch() {
	
	if($("#TB_CRTN_YY").val() == null || $("#TB_CRTN_YY").val() == ""){
		alert("년도는 필수입니다.");
		return false;
	}
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트코드는 필수입니다.");
		return false;
	}
	
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectYearResultMgt');
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
                <col style="width:120px">
                <col style="width:430px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
						<input type="number" id="TB_CRTN_YY"  style="text-align: right; width: 50px; text-align: center" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>예산구분</span></th>
                    <td>
	                    <select id="SB_BUGT_CD" name="SB_BUGT_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <td></td>
                    <td></td>
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
    <div class="tbl-search-area" style="float:left;">
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
<br>
<br>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>