<%--
    Class Name :sysRoleUserPopup.jsp
    Description: 권한 관리 > 권한-사용자설정
    Modification Information
         수정일                  수정자     수정내용
    ---------  ------ ---------------------------
    2020.06.18  박종용     최초 생성
    author: 박종용
    since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	    uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>

<script language="javascript">

var gridList1;
var gridList2;

$(document).ready(function() {
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', null, "", "전체");
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');

    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
	
	setInitGrid1();
	setInitGrid2();
	
	fnSearch();
	fnSearch2();
});


function fnSearch(){
	var params = fnGetParams();
    params.ROLE_CD = '${PARAM.ROLE_CD}';
    gridList1.setRows("");
	searchCall(gridList1, '/com/sys/selectRoleUnassignedUserList', null, params);
}

function fnSearch2(){
	var params = fnGetParams();
    params.ROLE_CD = '${PARAM.ROLE_CD}';
    searchCall(gridList2, '/com/sys/selectRoleAssignmentUserList', 'fnSearch2', params);
    gridList2.setRows("");
}

function setInitGrid1() {
	
	var gridId = "gridList1";
    gridList1 = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    
    addField(cm, 'DEPT_CD',       {text: '부서코드'},     80,  'text',     {textAlignment: 'center'},    {editable:false});
    addField(cm, 'DEPT_NAME',     {text: '부서명'},     100,  'text',     {textAlignment: 'near'},    {editable:false});
    addField(cm, 'USER_ID',       {text: '사용자ID'},    80,  'text',     {textAlignment: 'center'},    {editable:false});
    addField(cm, 'USER_NAME',     {text: '사용자명'},     80,  'text',     {textAlignment: 'center'},    {editable:false});
    
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

function setInitGrid2() {
	
	var gridId = "gridList2";
	gridList2 = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    
    addField(cm, 'DEPT_CD',       {text: '부서코드'},     80,  'text',     {textAlignment: 'center'},    {editable:false});
    addField(cm, 'DEPT_NAME',     {text: '부서명'},     100,  'text',     {textAlignment: 'near'},    {editable:false});
    addField(cm, 'USER_ID',       {text: '사용자ID'},    80,  'text',     {textAlignment: 'center'},    {editable:false});
    addField(cm, 'USER_NAME',     {text: '사용자명'},     80,  'text',     {textAlignment: 'center'},    {editable:false});
    
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

var fnAdd = function(){

    var dataList = gridList1.getSelectedItems();
    
    if( dataList.length == 0 ) {
        alert( "추가 할 대상을 선택 해 주세요.");
        return;
    } else {
        if(dataList.length > 0){
            $.each(dataList, function(idx, vo) {
                gridList2.addRow(vo);
                gridList2.commit();
            });
        }
        
        gridList1.deleteSelectedRows();
    }
    gridList1.commit();
}

var fnDel = function(){
    var dataList = gridList2.getSelectedItems();
    
    if( dataList.length == 0 ) {
        alert( "삭제 할 대상을 선택 해 주세요.");
        return;
    } else {
        
        if(dataList.length > 0){
            $.each(dataList, function(idx, vo) {
                gridList1.addRow(vo);
                gridList1.commit();
            });
        }
        
        gridList2.deleteSelectedRows();
    }
    
    gridList2.commit();
}

var fnSave = function(){
    if(confirm("저장하시겠습니까?")){
        var params = fnGetMakeParams();
        params.ROLE_CD = '${PARAM.ROLE_CD}';
        
        $.extend(params, {"ITEM_LIST" : gridList2.getAllJsonRowsExcludeDeleteRow()});
        
        ajaxJsonCall("<c:url value='/com/sys/updateRoleUser.do'/>", params, function(obj){
            alert("저장되었습니다.");
            fnSearch();
            fnSearch2();
            
            try{opener.fnSearch(1);}catch(e){}
        });
    }
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
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
 * 조회 후 처리
 */
function fnSearch2Success(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridList2.clearRows();
	// 그리고 데이터 setting
    gridList2.setPageRows(data);
    // 상태바 비활성화
    gridList2.closeProgress();
}

</script>

<div class="pop-wrap">
    <div class="pop-head">
        <h2>권한-사용자설정</h2>
        
        <div class="head-btn">
            <button class="btn" id="btnSave">저장</a>
        </div>
    </div><!-- //popHead -->
    
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
			<div class="tbl-search-area">
				<table class="tbl-search">
                    <colgroup>
		                <col style="width:120px">
		                <col style="width:300px">
		                <col style="width:120px">
		                <col style="width:300px">
		                <col style="width:120px">
		                <col style="width:300px">
		                <col>
                    </colgroup>
                    <tbody>
                        <tr>
							<th><span>회사</span></th>
							<td>
								<select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD">
							</td>
                            <th><span>권한코드</span></th>
                            <td>
                                <input type="text" id="S_ROLE_CD" value="${PARAM.ROLE_CD}" maxlength="15" disabled>
                            </td>
                            <th><span>권한명</span></th>
                            <td>
                                <input type="text" id="S_ROLE_NAME" value="${PARAM.ROLE_NAME}" maxlength="15" disabled>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <th><span>사용자명</span></th>
                            <td>
                                <input type="text" id="S_USER_NM" value="" maxlength="15">
                            </td>
                            <th><span>사용자ID</span></th>
                            <td>
                                <input type="text" id="S_USER_ID" value="" maxlength="15">
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
                                <h4>사용자목록</h4>
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
                                <h4>ROLE 할당 사용자목록 (${PARAM.ROLE_NAME})</h4>
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