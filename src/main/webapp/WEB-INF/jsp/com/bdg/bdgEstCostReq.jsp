<%--
	File Name : bdgEstCostReq.jsp
	Description: 예산 > 예산관리 > 원가검토의뢰
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.06  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.06
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

var compCodes  = new Array();
var compLabels = new Array();

var statusCodes  = new Array();
var statusLabels = new Array();

var itemCodes  = new Array();
var itemLabels = new Array();

var distribCodes  = new Array();
var distribLabels = new Array();

var reqCodes  = new Array();
var reqLabels = new Array();


var deptPopGubn  = "";
$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD'    , compList,     'CODE', 'CODE_NM', null, "","전체");

	var statusList  = stringToArray("${CODELIST_YS024}");
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");
	
	statusCodes  = getComboSet('${CODELIST_YS024}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS024}', 'CODE_NM');
	
	itemCodes  = getComboSet('${REQUESTITEM1}', 'CODE');
	itemLabels = getComboSet('${REQUESTITEM1}', 'CODE_NM');
	
	distribCodes  = getComboSet('${REQUESTITEM2}', 'CODE');
	distribLabels = getComboSet('${REQUESTITEM2}', 'CODE_NM');
	
	reqCodes  = getComboSet('${REQUESTITEM3}', 'CODE');
	reqLabels = getComboSet('${REQUESTITEM3}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGrid();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_ORG_NM").val('${LOGIN_INFO.DEPT_NM}');
	$("#TB_ORG_CD").val('${LOGIN_INFO.DEPT_CD}');
	
	$("#TB_START_DATE").val(getDiffDay("m",-1));
	$("#TB_END_DATE").val(getDiffDay("m",0));
	

}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    addField(cm,    'STATUS',               {text:'진행상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable:false},'dropDown');
    addField(cm,    'CTRN_YMD',             {text:'의뢰일자'},         60,            'text',           {textAlignment:"center"});
    addField(cm,    'REQ_DOC_NO',           {text:'견적번호'},         60,            'text',           {textAlignment:"center"});
    addField(cm,    'DOC_TITLE',            {text:'제목'},             200,            'textLink',           {textAlignment:"near"});
    addField(cm,    'ITEM_TYPE',            {text:'품목분류'},         100,            'text',           {textAlignment:"near"},{lookupDisplay: true,values:itemCodes,labels:itemLabels, editable:false},'dropDown');
    addField(cm,    'DISTRIB_TYPE',         {text:'유통분류'},         100,            'text',           {textAlignment:"near"},{lookupDisplay: true,values:distribCodes,labels:distribLabels, editable:false},'dropDown');
    addField(cm,    'REQ_TYPE',             {text:'견적유형'},         100,            'text',           {textAlignment:"near"},{lookupDisplay: true,values:reqCodes,labels:reqLabels, editable:false},'dropDown');
    addField(cm,    'PRODUCT_NM',           {text:'제품명'},          200,            'text',           {textAlignment:"near"});
    
    addField(cm,    'COMP_CD',              {text: '회사'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'ORG_CD',               {text: '부서'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: '행구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_3       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.CRUD;
        if (gubn == 'I') {
            styles.editable = true;
        } else {
        	styles.editable = false;
        	styles.background = "#e4e4e4";
        }

        return styles;
    };
    
    
    gridView.onDataCellClicked = function (grid, data) {
        if (grid.getCurrentRow().CRUD == "R") {
         	$("#REQ_DOC_NO").val(grid.getCurrentRow().REQ_DOC_NO); 
         	$("#CTRN_YMD").val(grid.getCurrentRow().CTRN_YMD);
        	$("#STATUS").val(grid.getCurrentRow().STATUS);
        	fnRequest('grid');
        }
	
    };
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };

    
    gridView.setOptions({sortMode:"explicit"});
}



/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectEstCostReqList');
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

//삭제
function fnDelete() {
	
	gridView.commit();
	
	var checkedRows = gridView.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		if (temp.STATUS == '1' || temp.STATUS == '3') {
			continue;
		} else {
			alert("[작성중/반려] 상태에서만 삭제가능합니다.");
			return false;				
		}
	}	

	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/deleteEstCostReq', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	gridView.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
}

/**
 * 의뢰서 작성
 */
function fnRequest(str) {
	var params = {};
	
	if(str == 'grid'){
		$("#REQ_DOC_NO").val(gridView.getCurrentRow().REQ_DOC_NO);	
	} else {
		$("#REQ_DOC_NO").val('');
		$("#STATUS").val('');
	}

	$.extend(params, fnGetParams());
	
	var target    = "bdgEstCostDetail";
	var width     = "1200";
	var height    = "630";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgEstCostDetail', params, target, width, height, scrollbar, resizable);

}

//승인요청
var fnAppr = function(){
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	if (checkedRows.length == 0) {
		alert("체크된 데이터가 존재하지 않습니다. 확인 후 작업하세요.");
		return false;			
	}
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		if (temp.STATUS == '1') {
			continue;
		} else {
			alert("[작성중] 상태에서만 저장가능합니다.");
			return false;				
		}
	}	
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_010"}); // 양식키
	$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
	$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자사번
	$.extend(params, {"MANAGER_YN"    : "N"}); // 본부장표시여부
	$.extend(params, {"REVIEW_ORG_CD" : ""}); // 처리부서코드
	//$.extend(params, {"BGT_URL"   : "http://192.168.110.76/com/bdg/bdgApmTransMgtPop.do?G_TOP_MENU_CD=BDG110&G_MENU_CD=BDG134" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + $('#TB_ORG_NM').val() + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
	//$.extend(params, {"BGT_BUS_URL"   : "http://192.168.110.76/com/bdg/bdgApmTransMgtEps.do?G_TOP_MENU_CD=BDG110&G_MENU_CD=BDG134"}); // 처리로직  url
	if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
		$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgEstCostReqPop.do?G_TOP_MENU_CD=BDG110&G_MENU_CD=BDG134" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgEstCostReqEps.do?G_TOP_MENU_CD=BDG110&G_MENU_CD=BDG134"}); // 처리로직  url
	} else {
		$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgEstCostReqPop.do?G_TOP_MENU_CD=BDG110&G_MENU_CD=BDG134" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YYMM=" + $('#TB_CRTN_YYMM').val() + "&TB_ORG_NM=" + encodeURI($('#TB_ORG_NM').val()) + "&TB_ORG_CD=" + $('#TB_ORG_CD').val()}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgEstCostReqEps.do?G_TOP_MENU_CD=BDG110&G_MENU_CD=BDG134"}); // 처리로직  url
	}
	
	$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
	$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
	$.extend(params, {"ITEM_LIST"     : fnGetGridCheckData(gridView)});
	
    if(confirm("승인요청 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/apprEstCost', 'fnAppr', params);
    }
	
}

function fnApprFail(result) {
	alert(result.errMsg);
}

function fnApprSuccess(data) {
	//alert("승인요청 되었습니다.");
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key"          : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : data.fields.result.EPS_FORM_ID}); //양식key
	 	$.extend(params, {"empno"        : data.fields.result.SABUN}); // 기안자
	 	$.extend(params, {"deptcd"       : data.fields.result.ORG_CD}); //기안자 부서코드
	 	$.extend(params, {"geMangerYn"   : 'N'}); //본부장 표시여부
	 	$.extend(params, {"reqDeptcd"    : ''}); //처리부서코드
	 	$.extend(params, {"systemUrl"    : data.fields.result.BGT_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //popup_url
	 	$.extend(params, {"businessUrl"  : data.fields.result.BGT_BUS_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //business_url
	 	$.extend(params, {"systemName"   : '전사시스템'}); //시스템이름
	 	$.extend(params, {"subject"      : ''}); //제목
	 	$.extend(params, {"status"       : '2'}); //상태코드
	 	
// 	 	var htmlTag = "<!DOCTYPE html>";
// 	 	htmlTag += "<html lang='ko'>";
// 	 	htmlTag += "<head>";
// 	 	htmlTag += "<meta charset='UTF-8'>";
// 	 	htmlTag += "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>";
// 	 	htmlTag += "<style>";
// 	 	htmlTag += ".tit-area{overflow:hidden;position:relative;padding:18px 0 13px;}";
// 	 	htmlTag += ".tbl-view{width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;}";
// 	 	htmlTag += ".tbl-view tbody th{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;background-color:#f1f2f6;text-align:left;}";
// 	 	htmlTag += ".tbl-view tbody td{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;}";
// 	 	htmlTag += "</style>";
// 	 	htmlTag += "</head>";
	 	
// 	 	htmlTag += "<body>";
// 	 	htmlTag += "<div class='tit-area' style='padding:15px;'>";
// 	 	htmlTag += "<div>";
// 	 	htmlTag += "<h3>원가의뢰검토</h3>";
// 	 	htmlTag += "</div>";
// 	    htmlTag += "<div class='tbl-search-wrap'>";
// 	    htmlTag += "<div class='tbl-search-area'>";
// 	    htmlTag += "<table class='tbl-search'>";
// 	    htmlTag += "<colgroup>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";
// 	    htmlTag += "<col style='width:70px'>";
// 	    htmlTag += "<col style='width:480px'>";	    
// 	    htmlTag += "<col>";
// 	    htmlTag += "</colgroup>";
// 	    htmlTag += "<tbody>";
// 	    htmlTag += "<tr>";
// 	    htmlTag += "<th><span>회사</span></th>";
// 	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
// 	    htmlTag += "<th><span>부서</span></th>";
// 	    htmlTag += "<td>" + $('#TB_ORG_NM').val() + "</td>";
// 	    htmlTag += "<td></td>";
// 	    htmlTag += "</tr>";
// 	    htmlTag += "</tbody>";
// 	    htmlTag += "</table>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "<div class='pop-cont'>";
// 	    htmlTag += "<div class='pop-cont'>";
// 	    htmlTag += "<table class='tbl-view'>";
// 	    htmlTag += "<colgroup>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:150px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "<col style='width:100px'>";
// 	    htmlTag += "</colgroup>";
// 	    htmlTag += "<tbody>";
// 	    htmlTag += "<tr>";
// 	    htmlTag += "<th style='text-align:center'>계정코드</th>";
// 	    htmlTag += "<th style='text-align:center'>계정명</th>";
// 	    htmlTag += "<th style='text-align:center'>당기기본예산</th>";
// 	    htmlTag += "<th style='text-align:center'>산정추정</th>";
// 	    htmlTag += "<th style='text-align:center'>예산추정</th>";
// 	    htmlTag += "<th style='text-align:center'>집행율</th>";
// 	    htmlTag += "<th style='text-align:center'>합계</th>";
// 	    htmlTag += "<th style='text-align:center'>예산증감율</th>";
// 	    htmlTag += "<th style='text-align:center'>산정증감율</th>";
// 	    htmlTag += "<th style='text-align:center'>예상증감율</th>";
// 	    htmlTag += "</tr>";
	    
// 	    for (var i=0 ; i < gridHeader.getRowCount(); i++) {
// 	    	htmlTag += "<tr>";
// 	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_NO") + "</td>";
// 	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_DESC") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "A_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "B_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "PRESUME_AMT") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "D_BUDGET") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "C_SUM") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "A_RATE") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "B_RATE") + "</td>";
// 	    	htmlTag += "<td style='text-align:right'>"  + gridHeader.getRowValue(i, "C_RATE") + "</td>";
// 	    	htmlTag += "</tr>";
// 	    }
	    
// 	    htmlTag += "</tbody>";
// 	    htmlTag += "</table>";
// 	    htmlTag += "</div>";
// 	    htmlTag += "</body>";
// 	    htmlTag += "</html>";
	    
// 	    $.extend(params, {"HTMLBody" : htmlTag}); //본문 데이터
	 	
	 	// 새로운 tab으로 전자결재 시스템 활성화
		//fnPostGoto("http://epsdev.ildong.com/approval/legacy/goFormLink", params, "GW");
	    
		var target    = "goFormLink";
		var width     = "1200";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	 	//fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
	    if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
			fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		} else {
			fnPostPopup('https://eps.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		}	    
	}
	
	fnSearch();
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>의뢰일자</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DATE" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DATE" dateHolder="end" value=""/>
                    </td>
                    <th><span>부서</span></th>
                    <td>
	                    <input type="text" id="TB_ORG_NM" name="TB_ORG_NM" disabled="disabled">              
	                    <input type="hidden" id="TB_ORG_CD">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>진행상태</span></th>
                    <td>
	                    <select id="SB_STATUS" name="SB_STATUS"></select>
                    </td>
                    <th><span>견적번호</span></th>
                    <td>
                        <input type="text" id="TB_REQ_DOC_NO"/>
                        <input type="hidden" id="REQ_DOC_NO"/>
	                    <input type="hidden" id="STATUS">
	                    <input type="hidden" id="CTRN_YMD">
                    </td>
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
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnRequest">의뢰서작성</button>
        <button type="button" class="btn" id="btnAppr">승인요청</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
