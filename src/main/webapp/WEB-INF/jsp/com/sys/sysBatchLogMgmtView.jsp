<%--
    Class Name sysBatchLogMgmtView.jsp
    Description: 배치 관리
    Modification Information
        수정일                  수정자      수정내용
    ---------  ------ ---------------------------
    2020.06.19  박종용     최초 생성
    2020.06.24  길용덕     배치 실행 기능 추가
    author: 박종용
    since: 2020.06.19
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s"  uri="http://www.springframework.org/tags"%>

<script language="javascript">
var gridView;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
   
	// 초기 상태값 처리
    fnInitStatus();	
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
    // 그리드 생성
    setInitGrid();
    // 자동 조회
    fnSearch();
    
});

/**
 * 초기 설정
 */
function fnInitStatus() {

}

/**
 * 그리드 기본  셋팅
 */
var setInitGrid = function(){
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
        
    var colModel = [];
    
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(colModel, 'BATCH_ID',       {text: 'BATCH_ID'},      150,    'text',      {textAlignment: 'near'}, {editable:false});
    addField(colModel, 'BATCH_DESC',     {text: 'BATCH_DESC'},    200,    'text',      {textAlignment: 'near'}, {editable:false});
    addField(colModel, 'RUN_IP',         {text: 'RUN_IP'},        100,    'text',      {textAlignment: 'center'}, {editable:false});
    addField(colModel, 'BATCH_YN',       {text: 'BATCH_YN'},      100,    'text',      {textAlignment: 'center'}, {editable:false});
    addField(colModel, 'BATCH_START_TIME',     {text: 'BATCH_START_TIME'},     120,    'text',      {textAlignment: 'center'}, {editable:false});
    addField(colModel, 'BATCH_END_TIME',       {text: 'BATCH_END_TIME'},       120,    'text',      {textAlignment: 'center'}, {editable:false});
    addField(colModel, 'RNUM',      {text: '상세보기'},   100,     'popupLink');
    addField(colModel, 'BATCH_SUCC_YN',        {text: 'SUCC_YN'},        100,    'text',      {textAlignment: 'center'}, {editable:false});
    addField(colModel, 'TOTAL_CNT',      {text: 'T_CNT'},      70,    'text',      {textAlignment: 'center'}, {visible:false});
    addField(colModel, 'SUCC_CNT',       {text: 'S_CNT'},       70,    'text',      {textAlignment: 'center'}, {visible:false});
    addField(colModel, 'FAIL_CNT',       {text: 'F_CNT'},       70,    'text',      {textAlignment: 'center'}, {visible:false});
    addField(colModel, 'BATCH_ARG1',     {text: '시작일'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG2',     {text: '종료일'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG3',     {text: '시작시간'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG4',     {text: '종료시간'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG5',     {text: 'BATCH_ARG5'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG6',     {text: 'BATCH_ARG6'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG7',     {text: 'BATCH_ARG7'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG8',     {text: 'BATCH_ARG8'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG9',     {text: 'BATCH_ARG9'},     100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'BATCH_ARG10',    {text: 'BATCH_ARG10'},    100,    'text',      {textAlignment: 'left'}, {editable:true});
    addField(colModel, 'CRUD',           {text: 'CRUD'},            0,    'text',      {textAlignment: 'center'},  {visible:false});
    

    gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이
       ,width          : "100%"
       ,columns        : colModel        // required
       ,editable       : true     //default false 그리드 전체 에디트 여부
       ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,copySingle     : false // default ture : 복사하지 않음
       //,autoHResize    : true       //화면 크기에 맞게 높이 자동조절
       ,viewCount      : true       //조회 건수 표시
       ,appendable     : false 
    });
    
    gridView.onDataCellClicked = function (grid, colIndex) {
        if ( colIndex.fieldName === "RNUM" ) {
        	fnShowDetail(grid.getValues(colIndex.itemIndex));
        }
    };
    
}
    
/**
 * 조회 버튼 클릭 시 이벤트
 */
function fnSearch() {
	searchCall(gridView, '/com/sys/selectBatchLogMgmtList');
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
 * 그리드의 상세화면 이미지 클릭시 팝업 활성화
 */
function fnShowDetail(row) {
    
	console.log("row : " + row);
	console.log("row : " + JSON.stringify(row));
	
    var params = fnGetMakeParams();
    $.extend(params, {"BATCH_ID" : row.BATCH_ID});
    
    var target = "sysBatchLogMgmtDetailPop";
    var width = "1350";
    var height = "568";
    
    fnPostPopup('/com/sys/sysBatchLogMgmtDetailPop', params, target, width, height); 
};


/**
 * 배치 실행 버튼 클릭 시 이벤트
 */
function fnCallBatch() {
	
	gridView.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	var requiredVal   = [];
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, true) == true){
	     if(confirm("배치 실행 하시겠습니까?")){
	    	 saveCall(gridView, '/com/sys/sysCallBatch', 'fnCallBatch', params);
	     }		
	}
}

/**
 * 배치 실행 성공
 */
function fnCallBatchSuccess(result) {
    alert("배치 실행을 성공하였습니다.");
    
    // 상태바 비활성화
    gridView.closeProgress();
    
    fnSearch();
}

/**
 * 배치 실행 실패
 */
function fnCallBatchFail(data) {
	alert("배치 실행을 실패하였습니다.");
	
    // 상태바 비활성화
    gridView.closeProgress();	
}

</script>

<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
	<div class="btnArea abtit">
	</div>    
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:100px"><!-- 타이틀 길이에 따라 가변적 -->
                <col style="width:450px">
                <col style="width:100px"><!-- 타이틀 길이에 따라 가변적 -->
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>BATCH ID</span></th>
                    <td>
                        <input type="text" data-type="textinput" name="BATCH_ID" id="BATCH_ID" data-bind="value:BATCH_ID">
                    </td>
                    <th><span>BATCH DESC</span></th>
                    <td>
                        <input type="text" data-type="textinput" name="BATCH_DESC" id="BATCH_DESC" data-bind="value:BATCH_DESC">
                    </td>
                    <td></td>
                <tr>
            </tbody>
        </table>
    </div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap --> 

<div class="sub-tit">
    <h4>배치 리스트</h4>
    <div class="btnArea t_right">
    	<button type="button" class="btn" id="btnCallBatch">배치 실행</button>
    </div>
</div>   

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
