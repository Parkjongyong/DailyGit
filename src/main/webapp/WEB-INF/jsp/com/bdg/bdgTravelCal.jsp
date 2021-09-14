<%--
	File Name : bdgTravelCal.jsp
	Description: 예산 > 영업관리 > 영업출장비정산
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.16  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.16
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
var compList     = new Array();
var statusCodes  = new Array();
var statusLabels = new Array();
var html = "";
var orgCd        = "";

$(document).ready(function() {
	
	var compList    = stringToArray("[{ATTR01=ALL, ATTR02=IPGO, CODE=1100, USG_YN=Y, CODE_GRP=SYS001, CODE_NM=일동제약}]");
	
	var etcGubnList  = stringToArray("${CODELIST_YS012}");
	fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList,     'CODE', 'CODE_NM',  "", "", "전체");

	// 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM');
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    // pdfDivHtml 숨기기
    pdfDivHide();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ORG_CD',                   {text:'부서코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ORG_NM',                   {text:'부서명'},                         60,     'textLink', {textAlignment: "near"});
    addField(cm,    'TRANS_AMT',                {text:'교통비'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'TRAVEL_AMT',               {text:'출장비'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'ROOM_AMT',                 {text:'숙박비'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'EXCEPT_AMT',               {text:'차감액'},                         60,     'integer', {textAlignment: "far"});
    addField(cm,    'SEND_AMT',                 {text:'송금액'},                         60,     'integer', {textAlignment: "far"});
    
    addField(cm,    'COMP_CD',                 {text: '회사코드'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',               {text: '기준년월'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SAP_SEND_YN',             {text: 'SAP전송여부'},      0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'LEGACYNO',                {text: 'SAPLegacy 시스템 관리 번호'},      0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'SAP_SEND_YMD',            {text: 'SAP전송일자'},      0,     'text', {textAlignment: "center"},{visible:false});

    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
       	if(colIndex.fieldName == "ORG_NM"){
       		orgCd = gridView.getValue(colIndex.itemIndex,"ORG_CD");
       		fnSearchDetail();
       	}

     };
     
     gridView.setOptions({sortMode:"explicit"});

}
/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectTravelCal');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridView.clearRows();
		$("#TB_SAP_SEND_YN").val("");
		$("#TB_SAP_SEND_YMD").val("");
		$("#TB_LEGACYNO").val("");
	} else {
		$("#TB_SAP_SEND_YN").val(data.rows[0].SAP_SEND_YN);
		$("#TB_SAP_SEND_YMD").val(data.rows[0].SAP_SEND_YMD);
		$("#TB_LEGACYNO").val(data.rows[0].LEGACYNO);
	}
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();	
}


//SAP 전송
function fnSap() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : gridView.getAllJsonRowsExcludeDeleteRow()});
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("기준년월은 필수입니다.");
		return false;
	}	
	
	if($("#SB_CHC_ETC_GBN").val() == null || $("#SB_CHC_ETC_GBN").val() == ""){
		alert("부문은 필수입니다.");
		return false;
	}	

	if($("#TB_SAP_SEND_YN").val() == 'Y'){
		alert("미전송 건만 가능합니다.");
		return false;
	}	

	if(isEmpty(params.ITEM_LIST)){
		alert("전송할 대상이 없습니다.");
		return false;
	}
	
	
    if(confirm("SAP전송 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendTravelCal', 'fnSap', params);
    }
}

function fnSapSuccess(data) {
	alert("SAP전송 되었습니다.");
	fnSearch();
}

function fnSapFail(result) {
	alert("SAP전송 실패 하였습니다.");
}

//SAP 취소
function fnSapCancel() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : gridView.getAllJsonRowsExcludeDeleteRow()});
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("기준년월은 필수입니다.");
		return false;
	}	
	
	if($("#SB_CHC_ETC_GBN").val() == null || $("#SB_CHC_ETC_GBN").val() == ""){
		alert("부문은 필수입니다.");
		return false;
	}	

	if($("#TB_SAP_SEND_YN").val() == 'N'){
		alert("SAP 전송 건만 가능합니다.");
		return false;
	}	

	if(isEmpty(params.ITEM_LIST)){
		alert("전송할 대상이 없습니다.");
		return false;
	}
	
    if(confirm("SAP전송 취소 하시겠습니까?")){
    	saveCall(gridView, '/com/bdg/sendCancelTravelCal', 'fnSapCancel', params);
    }
}

function fnSapCancelSuccess(data) {
	alert("SAP전송 취소 되었습니다.");
	fnSearch();
}

function fnSapCancelFail(result) {
	alert("SAP전송 취소 실패 하였습니다.");
}

/**
 * 영업출장비세부내역 조회
 */
function fnSearchDetail() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"TB_ORG_CD" :  orgCd});
	
	var target    = "bdgTravelCalDetail";
	var width     = "1200";
	var height    = "690";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgTravelCalDetail', params, target, width, height, scrollbar, resizable);
}

//SAP 전송
function fnCreate() {
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("기준년월은 필수입니다.");
		return false;
	}	
	
	if($("#SB_CHC_ETC_GBN").val() == null || $("#SB_CHC_ETC_GBN").val() == ""){
		alert("부문은 필수입니다.");
		return false;
	}	
	
    if(confirm("명세표출력 하시겠습니까?")){
    	searchCall(null, '/com/bdg/createPdf', 'fnCreate', params);
    }
}

function fnCreateSuccess(data) {
	
	if(isEmpty(data.rows)){
	} else {
// 	    $("#TD_CRTN_YYMM1").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
// 	    $("#TD_CRTN_YYMM2").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
// 	    $("#TD_CRTN_YYMM3").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
// 	    $("#TD_CRTN_YYMM4").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
// 	    $("#TD_CRTN_YYMM5").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
// 	    $("#TD_CRTN_YYMM5").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
// 	    $("#TD_CRTN_YYMM5").text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
	    
	    var rowCnt = data.rows.length;
	    var createCnt = 0;
	    var checkCnt  = 23;
	    var viewCnt   = 1;
	    var img1;
	    
	    html = '';
	    var doc = new jsPDF('p', 'mm', 'a4');
	    for (createCnt; createCnt < rowCnt; createCnt++) {
	    	var vo = data.rows[createCnt];
	    	
            html += '<tr style="height:20px;">';
            html +=     '<td style="font-size:12px;" align="center">'+ vo.ORG_NM +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ vo.SABUN_NM  +'</td>';
            html +=     '<td style="font-size:12px;" align="center">'+ vo.GRADE_NAME +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ vo.TRANS_CNT + '</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ vo.TRANS_AMT  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ vo.TRAVEL_AMT  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ vo.ROOM_AMT  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ vo.EXCEPT_AMT  +'</td>';
            html +=     '<td style="font-size:12px;" align="right">'+ vo.SEND_AMT  +'</td>';
            html += '</tr>';
            
	    	if (createCnt == checkCnt && createCnt < rowCnt-1) {
	    		$('#gridPdf' + viewCnt + ' > tbody').empty();
	    		$("#TD_CRTN_YYMM" + viewCnt).text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
	    		$('#pdfDiv' + viewCnt).show();
	    		$('#gridPdf' + viewCnt + ' > tbody:last').append(html);
	    		html = '';
	    		
	    		html2canvas(document.getElementById("pdfDiv" + viewCnt),{scale:1}).then(function(canvas) {
	    			eval('var img' + viewCnt + ' = canvas.toDataURL(\"image/png\");');//var img1 = canvas.toDataURL('image/png');
	    			eval('doc.addImage(img' + viewCnt + ' , \"PNG\", 0, 0);');
	    	    	doc.addPage();
	    		});	
	    		
	    		viewCnt++;
	    		checkCnt = checkCnt + 24;
	    	} else {
	    		// 총건수와 일치하는 경우
	    		if (createCnt == rowCnt-1) {
	    			$("#TD_CRTN_YYMM" + viewCnt).text("해당 년월 : " + $('#TB_CRTN_YYMM').val()); //해당당 년월
	    			$('#gridPdf' + viewCnt + ' > tbody:last').append(html);
	    			$('#pdfDiv' + viewCnt).show();
	    			html = '';
	    			if (createCnt <= checkCnt) {
	    	    		html2canvas(document.getElementById("pdfDiv" + viewCnt),{scale:1}).then(function(canvas) {
	    	    			eval('img' + viewCnt + ' = canvas.toDataURL("image/png");');//var img1 = canvas.toDataURL('image/png');
	    	    			eval('doc.addImage(img' + viewCnt + ' , "PNG", 0, 0);');
	    	    	    	doc.addPage();
	    	    	    	doc.save(getDiffDay("m",0)+".pdf");
	    	    		});		    				
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
    <h3>${G_MENU_NM}</h3>
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" ></select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:70px;"/>
                    </td>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" onchange="fnSearch()">
	                    </select>
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
    <div class="tbl-search-area" style="float:left; width:900px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:120px">
                <col style="width:90px">
                <col style="width:120px">
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 10px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>SAP전송여부</span></th>
	        	<td style="padding-top: 10px;">
					<input type="text" id="TB_SAP_SEND_YN"  style="text-align: center; width: 40px;" disabled>	        	
	        	</td>
				<th style="padding-top: 10px; padding-left: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>SAP전송일자</span></th>
	        	<td style="padding-top: 10px;">
					<input type="text" id="TB_SAP_SEND_YMD"  style="text-align: center; width: 80px;" disabled>	        	
					<input type="hidden" id="TB_LEGACYNO">	        	
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>

<div class="sub-tit">
	<div class="btnArea t_right">
	    <button type="button" class="btn" id="btnCreate">명세서출력</button>
	    <button type="button" class="btn" id="btnSap">SAP전송</button>
	    <button type="button" class="btn" id="btnSapCancel">SAP전송취소</button>
	</div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
<div id="pdfDiv1" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM1" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf1"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv2" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM2" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf2"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv3" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM3" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf3"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv4" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM4" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf4"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv5" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM5" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf5"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv6" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM6" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf6"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv7" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM7" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf7"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv8" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM8" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf8"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv9" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM9" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf9"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv10" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM10" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf10"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>

<div id="pdfDiv11" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM11" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf11"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv12" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM12" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf12"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv13" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM13" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf13"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv14" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM14" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf14"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv15" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM15" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf15"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv16" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM16" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf16"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv17" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM17" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf17"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv18" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM18" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf18"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv19" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM19" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf19"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv20" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM20" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf20"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>

<div id="pdfDiv21" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM21" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf21"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv22" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM22" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf22"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv23" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM23" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf23"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv24" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM24" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf24"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv25" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM25" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf25"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv26" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM26" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf26"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv27" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM27" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf27"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv28" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM28" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf28"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv29" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM29" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf29"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
<div id="pdfDiv30" style="padding-right:10px;width:800px;">
	<div class="pdf-area" style="text-align:center;padding:15px;font-size:20px;"><h3>영업출장비 명세서</h3></div>
 	<table><tr><td id="TD_CRTN_YYMM30" style="text-align:center;padding-left:15px;"></td></tr></table>
	<div class="pop-cont">
		<table class="pdf-list" id="gridPdf30"><colgroup><col style="width:120px"/><col style="width:70px"/><col style="width:50px"/><col style="width:30px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/><col style="width:60px"/></colgroup>
		<thead><tr><th style="font-weight:500;font-size:12px;">지점</th><th style="font-weight:500;font-size:12px;">담당자코드/명</th><th style="font-weight:500;font-size:12px;">직급명</th><th style="font-weight:500;font-size:12px;">일수</th><th style="font-weight:500;font-size:12px;">교통비</th><th style="font-weight:500;font-size:12px;">출장비</th><th style="font-weight:500;font-size:12px;">숙박비</th><th style="font-weight:500;font-size:12px;">차감액</th><th style="font-weight:500;font-size:12px;">합계</th></tr></thead><tbody></tbody>
		</table>
	</div>
</div>
