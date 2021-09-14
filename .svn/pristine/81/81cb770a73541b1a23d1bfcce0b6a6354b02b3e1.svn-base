<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

var gridView;
var scrollItem = 460;

$(document).ready(function() {
    init();
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
    setInitGrid();
});

//초기화함수
function init() {
	
}


/****************************************** 구매요청 목록 Grid **********************************************/

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var colModel = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(colModel, 'BATCH_SEQ',         {text: 'BATCH_SEQ'},             80,     'text',      {textAlignment: 'center'});
    addField(colModel, 'BATCH_IP',          {text: 'BATCH_IP'},              90,     'text',      {textAlignment: 'center'});
    addField(colModel, 'BATCH_START_TIME',  {text: 'BATCH_START_TIME'},     150,     'text',      {textAlignment: 'center'});
    addField(colModel, 'BATCH_END_TIME',    {text: 'BATCH_END_TIME'},       150,     'text',      {textAlignment: 'center'});
    addField(colModel, 'BATCH_SUCC_YN',     {text: 'BATCH_SUCC_YN'},        120,     'text',      {textAlignment: 'center'});
    
    addField(colModel, 'BATCH_ERR_MSG',     {text: '오류 상세보기'},   85,     'popupLink');
    
    addField(colModel, 'BATCH_RUN_TIME',    {text: 'BATCH_RUN_TIME'},       120,     'text',      {textAlignment: 'center'});
    addField(colModel, 'PROC_ID',           {text: 'PROC_ID'},              190,     'text',      {textAlignment: 'near'});
    addField(colModel, 'TOTAL_CNT',         {text: 'TOTAL_CNT'},             80,     'text',      {textAlignment: 'center'},{visible:false});
    addField(colModel, 'SUCC_CNT',          {text: 'SUCC_CNT'},              80,     'text',      {textAlignment: 'center'},{visible:false});
    addField(colModel, 'FAIL_CNT',          {text: 'FAIL_CNT'},              80,     'text',      {textAlignment: 'center'},{visible:false});
    
    addField(colModel, 'RNUM',            {text: 'RNUM'},           0,    'text',     {textAlignment: "center"},  {visible:false});
    
    gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : 300       //required 그리드 높이
       ,columns        : colModel        // required
       ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,insertable : true
       ,appendable : true
       ,copySingle : false // default ture : 복사하지 않음
       ,autoHResize    : true     //윈도우 높이가 변경시 그리드 전체 높이 자동 조절
       ,viewCount      : true      //그리드 건수 표현
   });
   
   gridView.onTopItemIndexChanged = function(grid, item) {
       if (item > scrollItem) {
           scrollItem += 450;
           loadNext();
       }
   }
   
   gridView.onDataCellClicked =  function (grid, index) {
       if (index.column == "BATCH_ERR_MSG" && gridView.getValue(index.itemIndex, "BATCH_ERR_MSG") == "1" ) {
           fnShowDetail(index);
       }
   };
   
   fnSearch();
}

function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+499});
    
    ajaxJsonCall('<c:url value="/com/sys/selectBatchLogMgmtDetailList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}

//배치 Log 조회
function fnSearch() {
	searchCall(gridView, '/com/sys/selectBatchLogMgmtDetailList');
}

function fnSearchSuccess(data) {
    scrollItem = 460;
    
    if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
        alert(data.errMsg);
        return;
    }
    
    gridView.clearRows();
    gridView.setPageRows(data);
    gridView.closeProgress();
}

//상세화면 팝업
function fnShowDetail(row) {
    
    var params = fnGetMakeParams();
    $.extend(params, {"BATCH_SEQ" : gridView.getValue(row.itemIndex, "BATCH_SEQ")});
    
    var target = "sysBatchLogMgmtErrPop";
    var width = "1024";
    var height = "400";
    
    fnPostPopup('/com/sys/sysBatchLogMgmtErrPop', params, target, width, height); 
};

</script>

<input type="hidden" id="BATCH_ID" name="BATCH_ID" value='<c:out value="${paramMap.BATCH_ID }" />' />

<div class="pop-wrap"  style="width:100%;">
    <div class="pop-head">
        <h2>배치관리 Log 상세 화면 (<c:out value="${paramMap.BATCH_ID }" />)</h2>
        
    </div>
    
        <div class="tbl-search-wrap">
            <div class="tbl-search-area">
                <table class="tbl-search">
                    <colgroup>
                        <col style="width:70px;">
                        <col style="width480px;">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                        	<th><span>일자</span></th>
		                    <td>
		                        <span class="date-area">
		                        	<input type="text" class="datepicker" id="TB_START_DT" dateHolder="bgn">
		                        </span>
		                        <em> ~ </em>
		                        <span class="date-area">
		                        	<input type="text" class="datepicker" id="TB_END_DT" dateHolder="end">
		                        </span>
		                    </td>
		                    <td></td>
                        </tr>
                    </tbody>
                </table>
            </div><!-- //searchTableArea -->
		    <div class="tbl-search-btn">
		        <button class="btn-search" id="btnSearch">조회</button>
		    </div><!-- //search_btn_area -->
        </div><!-- // search_field_wrap -->
        <!-- realgrid 들어가는 영역 : S -->
        <div class="realgrid-area">
            <div id="gridView"></div>
        </div>
    </div><!-- //popCont -->

