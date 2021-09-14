<%--
	File Name : sysDeptRolePopup.jsp
	Description: 사용자 롤 조회/등록/수정/삭제 화면
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.06.19  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.06.19
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>

<script language="javascript">

var gridList1;
var gridList2;
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
 	setInitGrid1();// 왼쪽
 	setInitGrid2();// 오른쪽
 	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {

}

/**
 * 조회 버튼 클릭 시 이벤트
 */
function fnSearch() {
	fnLeftSearch(); // 왼쪽
	fnRightSearch();// 오른쪽
}

/**
* 미할당된된 롤 조회(왼쪽 그리드 데이터 조회)
*/
function fnLeftSearch() {
	// 파라미터 셋팅
    var params = fnGetParams();
    $.extend(params, {S_DEPT_CD   : '${PARAM.S_DEPT_CD}'});
    $.extend(params, {DEPT_CD     : '${PARAM.DEPT_CD}'});
    $.extend(params, {MODULE_TYPE : '${PARAM.USER_CLS}'});
    
	// 조회 요청
	searchCall(gridList1, '/com/sys/selectUnassignedDeptRoleList', 'fnLeftSearch', params);    
}

/**
 * 조회 성공 후 처리(왼쪽)
 */
function fnLeftSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridList1.clearRows();
	// 그리고 데이터 setting
    gridList1.setPageRows(data);	
 	// 상태바 비활성화
    gridList1.closeProgress();	
}


/**
* 부여된 롤 조회(오른쪽 그리드 데이터 조회)
*/
function fnRightSearch() {
	// 파라미터 셋팅
    var params = fnGetParams();
    $.extend(params, {S_DEPT_CD : '${PARAM.S_DEPT_CD}'});
    $.extend(params, {DEPT_CD   : '${PARAM.DEPT_CD}'});
	// 조회 요청
	searchCall(gridList2, '/com/sys/selectAssignedDeptRoleList', 'fnRightSearch', params); 
}

/**
 * 조회 성공 후 처리(오른쪽)
 */
function fnRightSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridList2.clearRows();
	// 그리고 데이터 setting
    gridList2.setPageRows(data);	
 	// 상태바 비활성화
    gridList2.closeProgress();	
}

/**
 * 닫기 버튼 클릭 시 이벤트
 */
function fnClose() {
	window.close();
}

/**
 * 추가 버튼 클릭 시 이벤트
 */
function fnAdd() {

	// 왼쪽에 체크된 데이터 추출
    var dataList = gridList1.getSelectedItems();
    
    if( dataList.length == 0 ) {
        alert( "추가 할 대상을 선택 해 주세요.");
        return;
    } else {
    	// 체크된 데이터를 오른쪽으로 데이터 이동
        if(dataList.length > 0){
            $.each(dataList, function(idx, vo) {
                gridList2.addRow(vo);
                gridList2.commit();
                
            });
        }
        //왼쪽에 체크된 데이터를 삭제
        gridList1.deleteSelectedRows();
    }
    //왼쪽 그리드를 확정
    gridList1.commit();
}

/**
 * 삭제 버튼 클릭 시 이벤트
 */
function fnDel() {
	
	// 오른쪽에 체크된 데이터를 추출
    var dataList = gridList2.getSelectedItems();
    
    if( dataList.length == 0 ) {
        alert( "삭제 할 대상을 선택 해 주세요.");
        return;
    } else {
    	// 체크된 데이터를 왼쪽으로 데이터 이동
        if(dataList.length > 0){
            $.each(dataList, function(idx, vo) {
                gridList1.addRow(vo);
                gridList1.commit();
            });
        }
      	//오른쪽에 체크된 데이터를 삭제
        gridList2.deleteSelectedRows();
    }
  	//오른쪽 그리드를 확정
    gridList2.commit();
}

/**
 * 저장 버튼 클릭 시 이벤트
 */
function fnSave() {
	if(confirm("저장 하시겠습니까?")){
		// 기본 데이터 추출
		var params = fnGetMakeParams();
		// 추가 데이터 추출
		$.extend(params, {S_DEPT_CD : '${PARAM.S_DEPT_CD}'});
		$.extend(params, {DEPT_CD   : '${PARAM.DEPT_CD}'});
		$.extend(params, {"ITEM_LIST" : gridList2.getAllJsonRowsExcludeDeleteRow()});
		
	    saveCall(gridList2, '/com/sys/updateDeptRole', null, params);
    }	
}

/**
 * 저장 성공 시 처리
 */
function fnSaveSuccess(jObj) {
	alert("저장되었습니다.");
	// 자동조회
	//fnSearch();
	// 부모창 조회	
	parentCallback('fnSearch');
}

/**
 * 저장 실패 시 처리
 */
function fnSaveFail(jObj) {
	if (jObj.errMsg == ""){
		alert("삭제에 실패했습니다.");
	} else {
		alert(jObj.errMsg);
	}
	return;
}

/**
 * 그리드 기본  셋팅(왼쪽)
 */
function setInitGrid1() {
	var gridId = "gridList1";
    gridList1 = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    
    addField(cm, 'ROLE_CD',       {text: '권한코드'},    60,  'text',     {textAlignment: 'center'},    {editable:false});
    addField(cm, 'ROLE_NAME',     {text: '권한명'},     80,  'text',     {textAlignment: 'near'},    {editable:false});
    
    addField(cm, 'MOD_FLAG',      {text: '구분'},       0,  'text',     {textAlignment: "center"},  {visible:false});
    
    gridList1.rgrid({
        gridId         : gridId    //required 그리드 ID
        ,height         : 450       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,copySingle     : false // default ture : 복사하지 않음 
        ,appendable     : true
        ,insertable     : true
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridList1.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };
    
    gridList1.setPageRows("");
}

/**
* 그리드 기본  셋팅(오른쪽)
*/
function setInitGrid2() {	
	var gridId = "gridList2";
    gridList2 = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    
    addField(cm, 'ROLE_CD',       {text: '권한코드'},    60,  'text',     {textAlignment: 'center'},  {editable:false});
    addField(cm, 'ROLE_NAME',     {text: '권한명'},     80,  'text',     {textAlignment: 'near'},    {editable:false});
    
    addField(cm, 'MOD_FLAG',      {text: '구분'},       0,  'text',     {textAlignment: "center"},  {visible:false});
    
    gridList2.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : 450       //required 그리드 높이
       ,columns        : cm        // required
       ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
       ,editable       : true     //default false 그리드 전체 에디트 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,copySingle     : false // default ture : 복사하지 않음 
       ,appendable     : true
       ,insertable     : true
       ,viewCount      : true       //조회 건수 표시
    });
    
    gridList2.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };
    
    gridList2.setPageRows("");
}

</script>

<div class="pop-wrap">
    <div class="pop-head">
        <h2>부서-권한 설정</h2>
        
        <div class="head-btn">
            <button class="btn" id="btnSave">저장</a>
        </div>
    </div><!-- //popHead -->
    
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
			<div class="tbl-search-area">
				<table class="tbl-search">
                    <colgroup>
						<col style="width:8%">
						<col style="width:25%">
						<col style="width:7%">
						<col style="width:26%">
						<col style="width:7%">
						<col style="width:26%">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><span>부서코드</span></th>
                            <td>
                                <input type="text" id="S_DEPT_ID" value="${PARAM.DEPT_CD}" maxlength="15" disabled>
                            </td>
                            <th><span>부서명</span></th>
                            <td>
                                <input type="text" id="S_DEPT_NAME" value="${PARAM.DEPT_NAME}" maxlength="15" disabled>
                            </td>
                            <th><span>권한명</span></th>
                            <td>
                                <input type="text" id="S_ROLE_NM" value="${S_ROLE_NM}" maxlength="15">
                            </td>
                        </tr>
                    </tbody>
                </table>                    
            </div><!-- //searchTableArea -->
		    <div class="tbl-search-btn">
		        <button class="btn-search" id="btnSearch">조회</button>
		    </div><!-- //search_btn_area -->
        </div><!-- // search_field_wrap -->
        <!-- realgrid 들어가는 영역 : S -->
        <div class="pack-layout">
            <table class="tbl-view">
                <colgroup>
                    <col style="width:45%">
                    <col>
                    <col style="width:45%">
                </colgroup>
                <tbody>
                    <tr>
                        <td rowspan="2">
                            <div class="sub-tit first">
                                <h4>권한목록</h4>
                            </div>
                            <div class="realgrid-area">
                                <div id="gridList1"></div> 
                            </div>
                        </td>
                        <td align="center" valign="bottom">
                            <div class="t_center">
                                <button type="button" class="btn" id="btnAdd">추가</button>
                            </div>
                        </td>
                        
                        <td rowspan="2">
                            <div class="sub-tit first">
                                <h4>부서 할당 ROLE목록</h4>
                            </div>
                            <div class="realgrid-area">
                                <div id="gridList2"></div> 
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="top">
                            <div class="t_center">
                                <button type="button" class="btn" id="btnDel">삭제</button>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div><!-- //popCont -->
</div>