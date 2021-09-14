<%--
	File Name : bdgVactionMgmt.jsp
	Description: 영업 > 영업관리 > 휴가일수관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.13  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.13
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridHeader;
var compList     = new Array();
var statusCodes  = new Array();
var statusLabels = new Array();

$(document).ready(function() {
	
	var compList    = stringToArray("[{ATTR01=ALL, ATTR02=IPGO, CODE=1100, USG_YN=Y, CODE_GRP=SYS001, CODE_NM=일동제약}]");
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM');
    
	var etcGubnList  = stringToArray("${CODELIST_YS012}");
	fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList,     'CODE', 'CODE_NM',  "", "", "전체");

    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	
}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ORG_CD',                   {text:'부서코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ORG_NM',                   {text:'부서명'},                         60,     'text', {textAlignment: "near"});
    addField(cm,    'SABUN',                   {text:'사원코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'SABUN_NM',                   {text:'사원명'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'VACAT_NUM',                   {text:'휴가일수'},                         60,     'text', {textAlignment: "center"});
    
    addField(cm,    'COMP_CD',                 {text: '회사코드'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',               {text: '기준년월'},         0,     'text', {textAlignment: "center"},{visible:false});


    gridHeader.onDataCellClicked = function (grid, data) {
    	var gridView = grid.getDataProvider();
       	rowIndex = data.itemIndex;
       	//구별되기 위해 체크박스 체크
       	gridHeader.checkItem(data.itemIndex, true);
       	// 상세조회
       	fnSearchDetail(gridView.getValue(rowIndex,"ORG_CD"), gridView.getValue(rowIndex,"SABUN"));
    };
    
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
    
    gridHeader.setOptions({sortMode:"explicit"});
    
}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'VACAT_DAY',                   {text:'휴가일'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'VACAT_GUBUN',                   {text:'구분'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'VACAT_TXT',                   {text:'적요'},                         100,     'text', {textAlignment: "near"});

    
    gridDetail.rgrid({
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
    
    gridDetail.setOptions({sortMode:"explicit"});
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectVacationMgmt');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	gridDetail.clearRows();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridHeader.clearRows();
	// 그리고 데이터 setting
    gridHeader.setPageRows(data);
    // 상태바 비활성화
    gridHeader.closeProgress();	
}

/**
 * 조회
 */
function fnSearchDetail(orgCd, sabun) {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"TB_ORG_CD" : orgCd, "TB_SABUN" : sabun} );	
	
	// 조회 요청
	searchCall(gridDetail, '/com/bdg/selectVacationDetail', 'fnSearchDetail', params);
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
 * 출장비수신
 */
function fnTravel() {
	if(confirm("출장비수신 하시겠습니까?")){
		var params = {};
		$.extend(params, fnGetParams());
		saveCall(gridHeader, '/com/bdg/receptionTravel', 'fnTravel', params);
	}
	
}

/**
 * 휴가정보수신
 */
function fnVacation() {
	if(confirm("휴가정보 수신하시겠습니까?")){
		var params = {};
		$.extend(params, fnGetParams());
		saveCall(gridHeader, '/com/bdg/receptionVacation', 'fnVacation', params);
	}
}

/**
 * 출장비수신 성공
 */
function fnTravelSuccess(data) {
	alert("출장비수신 되었습니다.");
	fnSearch();
}


/**
 * 출장비수신 실패
 */
function fnTravelFail(data) {
	alert(data.errMsg);
}

/**
 * 휴가정보수신 성공
 */
function fnVacationSuccess(data) {
	alert("휴가정보 수신되었습니다.");
	fnSearch();
}

/**
 * 휴가정보수신 실패
 */
function fnVacationFail(data) {
	alert(data.errMsg);
}

/**
 * 확인
 */
function fnConfirm() {
	if(confirm("확인 하시겠습니까?")){
		var params = {};
		$.extend(params, fnGetParams());
		saveCall(gridHeader, '/com/bdg/confirmVacation', 'fnConfirm', params);
	}
}

/**
 * 확인 성공
 */
function fnConfirmSuccess(data) {
	alert("확인 되었습니다.");
	fnSearch();
}

/**
 * 확인 실패
 */
function fnConfirmFail(data) {
	alert(data.errMsg);
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD">
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:70px;"/>
                    </td>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN">
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
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th><span>기본정보</span></th>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="btnArea t_right">
    <button type="button" class="btn" id="btnTravel">출장비수신</button>
    <button type="button" class="btn" id="btnVacation">휴가정보수신</button>
    <button type="button" class="btn" id="btnConfirm">확인</button>
</div>
</div>
<div class="realgrid-area">
    <div id="gridHeader"></div> 
</div>
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th><span>상세정보</span></th>
	        	<td></td>
	        </tr>
		</table>
	</div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
