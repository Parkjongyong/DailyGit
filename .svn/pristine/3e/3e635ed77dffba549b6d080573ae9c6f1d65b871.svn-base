<%--
	File Name : sysPopupMgmt.jsp
	Description: 알림 팝업 조회/등록/수정 화면
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.06.18  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<s:eval var="_dateUtil"               expression="T(com.app.ildong.common.util.DateUtil)"/>
<s:eval var="_unformat_today"         expression="_dateUtil.getToday()"/>
<s:eval var="_today"                  expression="_dateUtil.formatDate(_unformat_today, '-')"/>                  <%-- 포맷된 오늘날짜 --%>
<s:eval var="_getMonthFirstDay"       expression="_dateUtil.formatDate(_dateUtil.getMonthFirstDay(), '-')"/>     <%-- 포맷된 현재월 1일 --%>

<script type="text/javascript">
var gridView;
/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();
	// 그리드 생성
	setInitGrid();
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();	
	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 기간 시작인 셋팅
	$("#TB_START_DT").val(firstDayByMonth(getDiffDay("m",-1))); //한달전 첫째일
}

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
  
    addField(cm,    'RNUM',         {text: '상세보기'},      50,     'popupLink');
    addField(cm,    'RNUM2',        {text: '편집'},        50,     'popupLink');
    addField(cm,    'START_DATE',   {text: '시작일'},      100,     'datetime',  {textAlignment: "center"}, {datetimeFormat: "yyyy-MM-dd"});
    addField(cm,    'END_DATE',     {text: '종료일'},      100,     'datetime',  {textAlignment: "center"}, {datetimeFormat: "yyyy-MM-dd"});
    addField(cm,    'WIDTH',        {text: '가로크기'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'HEIGHT',       {text: '세로크기'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'TOP',          {text: '상단위치'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'LEFT',         {text: '왼쪽위치'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'SUBJECT',      {text: '제목'},       250,     'text',     {textAlignment: 'near'});
    addField(cm,    'SITE',         {text: '내부/외부'},     80,     'text',     {textAlignment: 'center'});
    addField(cm,    'PRESENT_FLAG', {text: '표시시점'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'DEL_YN',       {text: '사용여부'},      80,     'text',     {textAlignment: 'center'});

    addField(cm,    'SEQ',          {text: 'SEQ'},        0,     'text',     {textAlignment: "center"},  {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,copySingle     : false // default ture : 복사하지 않음
        ,autoHResize    : false       //화면 크기에 맞게 높이 자동조절
        ,viewCount      : true       //조회 건수 표시
        
    });
    
    gridView.onDataCellClicked =  function (grid, index) {
        if (index.column == "RNUM") {
            fnShowDetail(index);
        }else if (index.column == "RNUM2") {
        	fnModifyPop(index);
        }
    };
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/sys/selectSysPopupMgmtList');
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
 * 그리드의 상세보기 클릭시 이벤트
 */
function fnShowDetail(row) {
    
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ" : gridView.getValue(row.itemIndex, "SEQ")});
        
    var target = "mgtPopupMgmtView_"+gridView.getValue(row.itemIndex, "SEQ");
    var width  = gridView.getValue(row.itemIndex, "WIDTH");
    var height = gridView.getValue(row.itemIndex, "HEIGHT");
    var top    = gridView.getValue(row.itemIndex, "TOP");
    var left   = gridView.getValue(row.itemIndex, "LEFT");
    var scrollbar = "yes";
    var resizable = "yes";
    
    window.open("", target, "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top + ",status=no, scrollbars=" + scrollbar + ", resizable=" + resizable );
    fnPostGoto('/com/sys/sysPopupMgmtView', params, target);
    
}

/**
 * 수정 팝업
 */
function fnModifyPop(row) {
	var params = fnGetMakeParams();
    
    
	var params = fnGetMakeParams();
    $.extend(params, {"SEQ" : gridView.getValue(row.itemIndex, "SEQ")});
        
    var target = "mgtPopupMgmtModify_"+gridView.getValue(row.itemIndex, "SEQ");
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/sys/sysPopupMgmtModify', params, target, width, height, scrollbar, resizable);
}

/**
 * 글쓰기 팝업
 */
function fnWrite() {
    var params = fnGetParams(); 
    
    var target = "mgtPopupMgmtWrite";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/sys/sysPopupMgmtWrite', params, target, width, height, scrollbar, resizable);
}
    

</script>
<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
	<div class="btnArea abtit">
        <button type="button" class="btn" id="btnWrite">새 팝업 작성</button>
	</div>
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
            </colgroup>
            <tbody>
                <tr>
                    <th><span>기간</span></th>
                    <td>
                        <span class="date-area">
                        	<input type="text" class="datepicker" id="TB_START_DT" dateHolder="bgn">
                        </span>
                        <em> ~ </em>
                        <span class="date-area">
                        	<input type="text" class="datepicker" id="TB_END_DT" dateHolder="end">
                        </span>
                    </td>
                    <th><span>내부/외부</span></th>
                    <td>
                        <select id="SB_SITE">
                            <option value="">선택</option>
                            <option value="A">전체</option>
                            <option value="I">내부</option>
                            <option value="E">외부</option>
                        </select>
                    </td>
                    <th><span>사용여부</span></th>
                    <td>
                        <select id="SB_DEL_YN">
                            <option value="">전체</option>
                            <option value="N">사용</option>
                            <option value="Y">미사용</option>
                        </select>
                    </td>   
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearch">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
<br>

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>