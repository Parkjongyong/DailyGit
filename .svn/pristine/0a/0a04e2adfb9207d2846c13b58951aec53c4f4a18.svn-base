<%--
	File Name : wrhVendorMgmt.jsp
	Description: 입고예정 > 업체정보 > 업체정보관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.15  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.15
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var scrollItem = 20;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGrid();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

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
function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
  
    addField(cm,    'VENDOR_CD',        {text: '업체코드'},    70,     'textLink', {textAlignment: "center"} ,  {editable:false});
    addField(cm,    'VENDOR_NM',      	{text: '업체명'},     120,     'text', {textAlignment: "near"}   ,  {editable:false});
    addField(cm,    'POBUSI_NO_DSP',    {text: '사업자번호'},   70,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'PRESIDENT_NM',   	{text: '대표이사'},    100,     'text',  {textAlignment: "center"}  ,  {editable:false});
    addField(cm,    'BUSS_TYPE',     	{text: '업종'},        80,     'text',  {textAlignment: "center"},  {editable:false});
    addField(cm,    'BUSIN',          	{text: '업태'},        80,     'text', {textAlignment: "center"},  {editable:false});
    addField(cm,    'MAIN_EMAIL',     	{text: 'Email'},     120,     'text',  {textAlignment: "near"} ,  {editable:false});
    addField(cm,    'ADDR',             {text: '주소'},       200,     'text',  {textAlignment: "near"},  {editable:false});
    addField(cm,    'CRUD',             {text: 'CRUD'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'FUND_TYPE',        {text: '내/외자구분코드'},  0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'FUND_TYPE_NM',     {text: '내/외자구분명'},   0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CORP_NO',          {text: 'CORP_NO'},     0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ZIP_NO',           {text: '우편번호'},       0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'MAIN_TELL_NO',     {text: '대표전화번호'},     0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'MAIN_FAXNO',       {text: 'FAX'},          0,     'text',      {textAlignment: 'center'},  {visible:false});
    addField(cm,    'POBUSI_NO',        {text: '사업자번호'},      0,     'text',      {textAlignment: 'center'},  {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
        
    });
    
    gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 50;
            loadNext();
        }
    }    

    gridView.onDataCellClicked =  function (grid, index) {
        if (index.column == "VENDOR_CD") {
        	fnVendorInfoDetail(index);
        }
    };
    
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWhrVendorList');
}

function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+49});
    
    ajaxJsonCall('<c:url value="/com/wrh/selectWhrVendorList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
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
 * 그리드의 업체코드 클릭시 이벤트
 */
function fnVendorInfoDetail(row) {
    var params = fnGetMakeParams();
    $.extend(params, fnGetGridParams(gridView));

    var target = "cmnVendorInfoPop";
    var width  = "800";
    var height = "900";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/wrh/wrhVendorInfoPop', params, target, width, height, scrollbar, resizable);
}

//승인요청
function fnInitialPW() {
	// 필수 체크 대상(그리드)
	var requiredVal   = ["POBUSI_NO"];
	
	var params = {};
	$.extend(params, fnGetSaveAllData(gridView));
	$.extend(params, fnGetParams());
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("패스워드 초기화 하시겠습니까?")){
	    	 saveCall(gridView, '/com/wrh/initialWhrVendorMgmt', 'fnInitialPW', params);
	     }
	}
}

/**
 * 패스워드 초기화 성공
 */
function fnInitialPWSuccess(result) {
	alert("패스워드 초기화되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 패스워드 초기화 실패
 */
function fnInitialPWFail(data) {
	alert(data.errMsg);
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
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>공급업체</span></th>
                    <td>
						<input class="w90" type="text" id="TB_VENDOR_CD" value="" maxlength="20">
						<input type="text" id="TB_VENDOR_NM" value="" maxlength="20">
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
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnInitialPW">PW초기화</button>
    </div>
</div>

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>