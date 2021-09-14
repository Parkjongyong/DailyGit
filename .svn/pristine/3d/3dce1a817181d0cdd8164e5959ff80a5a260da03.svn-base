<%--
	File Name : sysMainImage.jsp
	Description: 메인화면 이미지 관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.23  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.09.23 
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
	searchCall(gridView, '/com/sys/selectMainImageList');	
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
	addField(cm ,	'CODE_NM',	        {text: '등록화면'},	 	    150,		'text', 	{textAlignment: "near"});
	addField(cm ,	'CODE',	     	    {text: '등록화면코드'}, 	    150,		'text', 	{textAlignment: "near"},  {visible:false});
	addField(cm ,	'ATTH_SEQ',	     	{text: '파일 KEY'},	    100,        'text', 	{textAlignment: "center"});
		
	gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : 300       //required 그리드 높이
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
	    	 saveCall(gridView, '/com/sys/saveMainImage', null, params);
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
	
	$("#TB_APP_SEQ").val(checkArray.DELETED[0].ATTH_SEQ);
	$("#TB_APP_TYPE").val("MAIN_IMG");
    var fileParams = {KEY_ID: 'TB_APP_SEQ' // required 연관 파일 키
    	             ,S: 'TB_APP_TYPE'
                     ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
                     };
    openFileUplaod(fileParams);
}

/**
 * 첨부파일멀티용 시작
 */
function fnInitFileUpload() {
    if ($("#TB_APP_SEQ").val() != "") 
    	// 첨부파일 활성화
        displayFileUpload({
            KEY_ID      : 'TB_APP_SEQ',
            KEY_TYPE    : 'TB_APP_TYPE',
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

<table>
	<colgroup>
    	<col style="width:500px;color:red">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<td>* 이미지 파일은 등록화면별 하나씩만 등록하시길 바랍니다.</td>
			<td>
				<input type="hidden" id="TB_APP_SEQ">
				<input type="hidden" id="TB_APP_TYPE">
			</td>
		</tr>
	</tbody>
</table>
<div class="sub-tit">
    <div class="btnArea t_right" style="width:30%">
        <button type="button" class="btn" id="btnAttFile">파일추가</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area" style="width:30%">
	<div id="gridView"></div>
</div>