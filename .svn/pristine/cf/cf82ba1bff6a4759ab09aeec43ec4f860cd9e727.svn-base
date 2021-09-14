<%--
	File Name : sysExcelForm.jsp
	Description: 엑셀양식지 관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.02  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.09.02 
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<script language="javascript">
var gridView;
/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();	
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
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
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/sys/selectExcelFormList');	
}

/**
 * 조회 성공 후 처리
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
 * 그리드 기본  셋팅
 */
function setInitGrid() {
	var gridId = "gridView";
	gridView = new RealGridJS.GridView(gridId);
	
	var cm = [];
	addField(cm ,	'MENU_NM',	     	{text: '화면명'},	 	    150,		'text', 	{textAlignment: "near"});
	addField(cm ,	'MENU_CD',	     	{text: '화면코드'}, 	    150,		'text', 	{textAlignment: "near"},  {visible:false});
	addField(cm ,	'ATTACHMENT',		{text: '파일 KEY'},	    100,        'text', 	{textAlignment: "center"});
		
	gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
       ,columns        : cm        // required
       ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,copySingle : false // default ture : 복사하지 않음
       //,autoHResize    : true       //화면 크기에 맞게 높이 자동조절
       ,viewCount      : true       //조회 건수 표시
   });

}

/**
 * 저장
 */
function fnSave() {
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = [];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, true) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/sys/saveExcelForm', null, params);
	     }
	}
	
}


function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	fnSearch();

}

function fnSaveFail(result) {
	alert("실패 하였습니다.");
}


/**
 * 첨부파일 버튼 클릭 시 이벤트
 */
function fnAttFile() {
	var checkArray = fnGetDeleteData(gridView);
	if(isEmpty(checkArray) == true){
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	if(checkArray.DELETED.length > 1){
		alert("한건씩만 가능합니다.");
		return false;
	}
	
	 $("#APP_SEQ").val(checkArray.DELETED[0].ATTACHMENT); 
    var fileParams = {KEY_ID: 'APP_SEQ' // required 연관 파일 키
                     ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
                     };
    openFileUplaod(fileParams);
}

/**
 * 첨부파일멀티용 시작
 */
function fnInitFileUpload() {
    if ($("#APP_SEQ").val() != "") 
    	// 첨부파일 활성화
        displayFileUpload({
            KEY_ID      : 'APP_SEQ',
            DATA_FORMAT : 'outTable',
            CALLBACK    : 'fnFileUploadCallback'
        });
};

/**
 * 첨부파일멀티용 CALL BACK
 */
function fnFileUploadCallback(data) {
    $('.upload-list').empty().html(data);
};


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
                <col style="width:70px">
                <col style="width:480px">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th><span>화면명</span></th>
					<td>
						<input type="text" id="TB_MENU_NM" value="">
						<input type="hidden" id="APP_SEQ"  name="APP_SEQ"  value="">
					</td>
					<td></td>
				</tr>
			</tbody>
		</table>
	</div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- //searchWrap -->
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnAttFile">파일추가</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area" style="width:30%">
	<div id="gridView"></div>
</div>