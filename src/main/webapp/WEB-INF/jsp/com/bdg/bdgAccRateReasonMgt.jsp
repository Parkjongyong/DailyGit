<%--
	File Name : bdgAccRateReasonMgt.jsp
	Description: 예산 > 예산관리 > 오차율 사유등록
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.24 길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.08.24
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

var paramGubn      = "";
var accountPopGubn = "";
var rowIndex       = "";

$(document).ready(function() {
	
	
    // 개별코드 생성(그리드용)
	compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM');
	
	fnCompCdChange();
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

});

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
}


/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    
    addField(cm,    'COMP_CD',              {text:'회사'},         60,            'text',              {textAlignment:"center"});
    addField(cm,    'COMP_NM',              {text:'회사명'},        100,            'text',              {textAlignment:"center"});
    addField(cm,    'CCTR_CD',              {text:'코스트센터'},          80,            'text',              {textAlignment:"center"});
    addField(cm,    'CCTR_NM',              {text:'코스트센터명'},          80,            'text',              {textAlignment:"center"});
    addField(cm ,   'ACCOUNT_NO',           {text:'계정코드'},         80,            'text',              {textAlignment: 'center'});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},         130,            'text',           {textAlignment:"near"});
    
    addField(cm,    'BUGT_EXEC_AMT_GRID',   {text:'월초예산'},           100,            'number',           {textAlignment:"far"});
    addField(cm,    'BUGT_RESULT_AMT_GRID', {text:'실적'},           100,            'number',           {textAlignment:"far"});
    addField(cm,    'ERROR_RATE_GRID',      {text:'오차율'},           100,            'number',           {textAlignment:"far"});
    addField(cm,    'ERROR_DESC',           {text:'오차사유'},         150,            'text',           {textAlignment:"near"});
    
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월'},         0,     'text', {textAlignment: "center"},{visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_3       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
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
        var errorRate = values.ERROR_RATE_GRID;
        // 오차율이 30이상인 경우만 수정 가능하게 처리
        if (toNumber(errorRate) >= 30) {
        	styles = enableColStyle;
        } else {
        	styles = disibleColStyle;
        }

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
    	return disibleColStyle;
    };
    
    gridView.setColumnProperty("ERROR_DESC"     , "dynamicStyles", columnDynamicStyles);
    
    gridView.setColumnProperty("COMP_CD"              , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("COMP_NM"              , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_CD"              , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("CCTR_NM"              , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ACCOUNT_NO"           , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ACCOUNT_DESC"         , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BUGT_EXEC_AMT_GRID"   , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("BUGT_RESULT_AMT_GRID" , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("ERROR_RATE_GRID"      , "dynamicStyles", columnDefaultStyles);
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectAccRateAMgtRightList');
}

/**
 * 조회 후 처리(1번 tab)
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


//저장
function fnSave() {
	gridView.commit();
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["ERROR_DESC"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?")){
			var params = {};
			$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
			$.extend(params, fnGetParams());
			
			saveCall(gridView, '/com/bdg/saveAccRateReasonMgt', 'fnSave', params);
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





/**
 * 계정 조회
 */
function fnSearchAccount(gubn) {
	var params = {};
	accountPopGubn = gubn;
	$.extend(params, fnGetParams());
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/accountSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 팝업 콜백
 */
function fnCallbackAccountSearchPop(rows) {
	if (accountPopGubn == "grid") {
		gridView.setRowValue(gridView.getCurrent().itemIndex, "ACCOUNT_NO", rows.ACCOUNT_NO);
		gridView.setRowValue(gridView.getCurrent().itemIndex, "ACCOUNT_DESC", rows.ACCOUNT_DESC);
	} else if (accountPopGubn == "header") {
		$('#TB_ACCOUNT_NO').val(rows.ACCOUNT_NO);
		$('#TB_ACCOUNT_DESC').val(rows.ACCOUNT_DESC);
		
		fnSearch();
	}	
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
                <col style="width:400px">
                <col style="width:120px">
                <col style="width:400px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();">
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
                    	<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM" dateHolder="bgn" value="" style="width:70px;"/>
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD">
	                    </select>
                    </td>
                    <td></td>
                </tr>
                <tr>
					<th><span>계정</span></th>
		        	<td>
					    <input type="text" id="TB_ACCOUNT_NO"	style="width: 90px;" 	disabled/>
					    <input type="text" id="TB_ACCOUNT_DESC"	style="width: 150px;"	disabled/>
					    <a href="javascript:fnSearchAccount('header');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
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
    <div id="div_table" class="tbl-search-area" style="float:left; width:800px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:90px">
                <col style="width:60px">
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 10px;">(단위 : 원)</th>
				<td style="padding-top: 10px;"></td>
	        	<td style="padding-top: 10px;"></td>
				<td style="padding-top: 10px;"></td>
	        	<td style="padding-top: 10px;"></td>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>

