<%--
    Class Name :sysCodeMgmtList.jsp
    Description: 공통코드 관리
    Modification Information
         수정일                  수정자     수정내용
    ---------  ------ ---------------------------
    2020.06.18  박종용     최초 생성
    author: 박종용
    since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/tags"%>

<script language="javascript">
// 전역 변수 선언
var gridViewGrp;
var gridViewDetl;

var _curSelGrpCd    = "";
var _requestUrl     = "";
var _onChangeDetlCd = false;

var useYnCodes  = new Array();
var useYnLabels = new Array();
/**
 * 화면 준비
 */
$(document).ready(function() {
	// 초기 상태값 처리
    fnInitStatus();

    // 개별코드 생성(그리드용)
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');
    
    // 그리드 생성
    setInitGridGrp();
    setInitGridDetl();
    
    // 자동 조회
    fnSearch();
    
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트는 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
});

/**
 * 초기 설정
 */
function fnInitStatus() {

}

/**
 * 그리드 기본  셋팅(그룹)
 */
function setInitGridGrp() {
    var gridId = "gridListGrp";
    gridViewGrp = new RealGridJS.GridView(gridId);
    
    var colModel = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(colModel ,   'CODE_GRP',         {text: '그룹코드'},         90,   'text',     {textAlignment: 'center'});
    addField(colModel ,   'CODE_GRP_NM',      {text: '코드명'},          200,   'text',     {textAlignment: 'center'});
    addField(colModel ,   'CODE_GRP_EN_NM',   {text: '코드영문명'},       200,   'text',     {textAlignment: 'center'});
    addField(colModel ,   'USE_YN',           {text: '사용여부'},         80,    'text',     {textAlignment: 'center'},  {lookupDisplay: true, values:useYnCodes,labels:useYnLabels},'dropDown');
    addField(colModel ,   'CRUD',             {text: 'CRUD'},           0,    'text',     {textAlignment: 'center'},  {visible:false});
    
    gridViewGrp.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 260       //required 그리드 높이
        //,width            : "100%"    //default 100% 그리드 넓이
        //,rowHeight        : 30        //default 30 row height
        ,columns        : colModel        // required
        //,headerHeight : 30        //default null  헤더 사이즈
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        //,exclusive        : false     //default false 한 행만 체크 가능할지의 여부를 지정한다.
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        //,columnMovable    : false     //default false 컬럼 이동가능 여부
        //,columnResizable: true        //default true  이 값이 False로 설정하면 사용자가 모든 컬럼의 크기를 변경할 수 없습니다.
        //,footerVisible    : false     //default false 그리드 footer 표시 여부
        //,stateBarVisible: false       //default false 컬럼 상태 표시 여부
        //,indicatorDp  : "index"   //default "index" 컬럼번호 표시 방식 : none, row, index(정렬무시)
        //,rowStylesFirst   : false     //default false row<->column 색상 우선순위 : true:column우선, false:row우선
        //,pager            : pagerParam//default 페이지 없음.
        //,dynamicResize  : true      //default false 동적 그리드 높이 변경
        ,appendable : true
        //,pager : pagerParam
        ,copySingle : false // default ture : 복사하지 않음 
        ,viewCount      : true       //조회 건수 표시
    });
    
    //셀이 수정된후 
    gridViewGrp.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };
     
    
    gridViewGrp.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	var curr = grid.getCurrent();
        var editable = false;
        if (newRow === -1 && curr.itemIndex > -1) {
            editable = true;
        } else if (newRow === -1 && curr.itemIndex === -1) {
            editable = false;
        } else {
            if (grid.getRowState(curr.itemIndex) === "created") {
                editable = true;
            }
        }
        grid.setColumnProperty("CODE_GRP", "editable", editable);
        
        if (curr.itemIndex > -1) {
            var values = grid.getValues(curr.itemIndex);
            var value = values.CODE_GRP;
            if($.trim(value) === ""){
                	
            }else{
            	fnSearchDetl(value);
            }
            _curSelGrpCd = value;
        }
    };

    //그리드 변경 시 체크박스 true
    gridViewGrp.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridViewGrp.checkItem(dataRow, true);
    };
    
    //fnRowsPastedCheck(gridViewGrp);
    gridViewGrp.setOptions({sortMode:"explicit"});
    

}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridViewGrp, '/com/sys/selectSysGrpCdList');
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	
	// 에러메세지 처리
	alertErrMsg(data);
    
	// 그리드 초기화
    gridViewGrp.clearRows();
	// 그리고 데이터 setting
    gridViewGrp.setPageRows(data);
    
	// 현재  rowIndex 정보 추출
    var dataRow = gridViewGrp.getCurrent().dataRow;
    
    if (dataRow > -1) {
        var value = gridViewGrp.getDataSource().getValue(dataRow, "CODE_GRP");
        fnSearchDetl(value);
        _curSelGrpCd = value;
    }
    
    // 상태바 비활성화
    gridViewGrp.closeProgress();
}

/**
 * 행추가
 */
function fnAddRowGrp() {
    var values = {"USE_YN":"Y", "CRUD" : "I"}
    gridViewGrp.insertRow(0, values);
    gridViewGrp.checkItem(0, true);
    gridViewGrp.setFocus();
    gridViewGrp.showEditor();
}

/**
 * 그룹코드 삭제로직
 */
function fnDelRowGrp() {
	
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridViewGrp)});
	
	if(fnDeleteCheck(gridViewGrp) == true){
		// 조회 요청
		deleteCall(gridViewGrp, '/com/sys/deleteGrpCd', 'fnDelRowGrp', params);
	}
}

/**
 * 그룹코드 삭제 성공
 */
function fnDelRowGrpSuccess(result) {
    alert("그룹코드 삭제 성공하였습니다.");
    // 상태바 비활성화
    gridViewGrp.closeProgress();
    
    fnSearch();
}

/**
 * 그룹코드 삭제 실패
 */
function fnDelRowGrpFail(data) {
	alert(data.errMsg);
	
    // 상태바 비활성화
    gridViewGrp.closeProgress();	
}

/**
 * 그룹코드 저장 로직
 */
function fnSaveGrp() {
	// 그리드 수정사항 확정처리
	gridViewGrp.commit();
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridViewGrp)});
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CODE_GRP"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridViewGrp, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridViewGrp, '/com/sys/saveGrpCd', null, params);
	     }		
	}
}

/**
 * 그룹코드 저장 성공
 */
function fnSaveSuccess(result) {
    alert("<spring:message code='common.save.success'/>");
    
    // 상태바 비활성화
    gridViewGrp.closeProgress();
    
    fnSearch();
}

/**
 * 그룹코드 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
	
    // 상태바 비활성화
    gridViewGrp.closeProgress();	
}

/**
 * 그리드 기본  셋팅(상세)
 */
function setInitGridDetl() {
    var gridId = "gridListDetl";
    gridViewDetl = new RealGridJS.GridView(gridId);
    
    var colModel = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(colModel, 'CODE_GRP',       {text: '그룹코드'},     90, 'text',     {textAlignment: 'center'}, {editable:false});
    addField(colModel, 'CODE',           {text: '코드'},        80, 'text',     {textAlignment: 'center'});
    addField(colModel, 'CODE_NM',        {text: '코드명'},      200, 'text',     {textAlignment: 'center'});
    addField(colModel, 'CODE_EN_NM',     {text: '영문명'},      200, 'text',     {textAlignment: 'center'});
    addField(colModel, 'EXPL',           {text: '코드설명'},     200, 'text',     {textAlignment: 'center'});
    addField(colModel, 'ATTR01',         {text: '속성01'},      80, 'text',     {textAlignment: 'center'});
    addField(colModel, 'ATTR02',         {text: '속성02'},      80, 'text',     {textAlignment: 'center'});
    addField(colModel, 'ATTR03',         {text: '속성03'},      80, 'text',     {textAlignment: 'center'});
    addField(colModel, 'ATTR04',         {text: '속성04'},      80, 'text',     {textAlignment: 'center'});
    addField(colModel, 'USG_YN',         {text: '사용여부'},     80,  'text',     {textAlignment: 'center'}, {lookupDisplay:true,values:useYnCodes,labels:useYnLabels},'dropDown');
    addField(colModel, 'ORD_NO',         {text: '정렬순서'},     100, 'number',   {textAlignment: 'far'});
    addField(colModel, 'CRUD',           {text: 'CRUD'},            0,    'text',      {textAlignment: 'center'},  {visible:false});
    
    gridViewDetl.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 260       //required 그리드 높이
        //,width            : "100%"    //default 100% 그리드 넓이
        //,rowHeight        : 30        //default 30 row height
        ,columns        : colModel        // required
        //,headerHeight : 30        //default null  헤더 사이즈
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        //,exclusive        : false     //default false 한 행만 체크 가능할지의 여부를 지정한다.
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        //,columnMovable    : false     //default false 컬럼 이동가능 여부
        //,columnResizable: true        //default true  이 값이 False로 설정하면 사용자가 모든 컬럼의 크기를 변경할 수 없습니다.
        //,footerVisible    : false     //default false 그리드 footer 표시 여부
        //,stateBarVisible: false       //default false 컬럼 상태 표시 여부
        //,indicatorDp  : "index"   //default "index" 컬럼번호 표시 방식 : none, row, index(정렬무시)
        //,rowStylesFirst   : false     //default false row<->column 색상 우선순위 : true:column우선, false:row우선
        //,pager            : pagerParam//default 페이지 없음.
//      ,dynamicResize  : true      //default false 동적 그리드 높이 변경
        ,appendable : true
//          ,pager : pagerParam
        ,copySingle : false // default ture : 복사하지 않음 
        ,viewCount      : true       //조회 건수 표시
    });
    
    //셀이 수정된후 
    gridViewDetl.onCellEdited = function (grid, itemIndex, dataRow, field) {
        this.commit(); //강제 커밋.
    };
    
    gridViewDetl.onCurrentRowChanged =  function (grid, oldRow, newRow) {
        var curr = grid.getCurrent();
        var editable = false;
        if (newRow === -1 && curr.itemIndex > -1) {
            editable = true;
        } else if (newRow === -1 && curr.itemIndex === -1) {
            editable = false;
        } else {
            if (grid.getRowState(curr.itemIndex) === "created") {
                editable = true;
            }
        }
        grid.setColumnProperty("CODE_GRP", "editable", false);
        grid.setColumnProperty("CODE", "editable", editable);
    };
    
    //그리드 변경 시 체크박스 true
    gridViewDetl.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridViewDetl.checkItem(dataRow, true);
    };
    
    //fnRowsPastedCheck(gridViewDetl);
    gridViewDetl.setOptions({sortMode:"explicit"});

}

/**
 * 조회
 */
function fnSearchDetl(param) {
	
    var params = fnGetParams();
    params.S_CODE_GRP = param;
	// 조회 요청
	searchCall(gridViewDetl, '/com/sys/selectSysDetlCdList','fnSearchDetl', params);
}

/**
 * 조회 후 처리
 */
function fnSearchDetlSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridViewDetl.clearRows();
	// 그리고 데이터 setting
    gridViewDetl.setPageRows(data);
    // 상태바 비활성화	
    gridViewDetl.closeProgress();
}

/**
 * 상세코드 추가 로직
 */
function fnAddRowDetl() {
	var values = {"CODE_GRP":_curSelGrpCd,  "USG_YN" : "Y",  "CRUD" : "I"}
	gridViewDetl.insertRow(0, values);
	gridViewDetl.checkItem(0, true);
	gridViewDetl.setFocus();
	gridViewDetl.showEditor();
}

/**
 * 상세코드 삭제 로직
 */
function fnDelRowDetl() {
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridViewDetl)});
	if(fnDeleteCheck(gridViewDetl) == true){
		// 조회 요청
		deleteCall(gridViewDetl, '/com/sys/deleteDetlCd', 'fnDeleteDetl', params);
	}
}

/**
 * 상세코드 저장 로직
 */
function fnSaveDetl() {
	// 그리드 수정사항 확정처리
	gridViewDetl.commit();
	
	var params = {};
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridViewDetl)});
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["CODE"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridViewDetl, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridViewDetl, '/com/sys/saveDetlCd', 'fnSaveDetl', params);
	     }		
	}
}


/**
 * 그룹코드 저장 성공
 */
function fnSaveDetlSuccess(result) {
    alert("<spring:message code='common.save.success'/>");
    // 상태바 비활성화
    gridViewDetl.closeProgress();
}

/**
 * 그룹코드 저장 실패
 */
function fnSaveDetlFail(data) {
	alert(data.errMsg);
	
    // 상태바 비활성화
    gridViewDetl.closeProgress();	
}

/**
 * 그룹코드 삭제 성공
 */
function fnDeleteDetlSuccess(result) {
    alert("<spring:message code='common.process.success'/>");
    // 상태바 비활성화
    gridViewDetl.closeProgress();
}

/**
 * 그룹코드 삭제 실패
 */
function fnDeleteDetlFail(data) {
	alert(data.errMsg);
	
    // 상태바 비활성화
    gridViewDetl.closeProgress();	
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
                <col style="width:100px;"><!-- 타이틀 길이에 따라 가변적 -->
                <col style="width:450px;">
                <col style="width:100px;"><!-- 타이틀 길이에 따라 가변적 -->
                <col style="width:450px;">
            </colgroup>
            
            <tbody>
                <tr>
                    <th><span>그룹코드</span></th>
                    <td>
                        <input type="text" id="S_CODE_GRP"  maxlength="6">
                    </td>
                    <th><span>그룹코드명</span></th>
                    <td colspan="3">
                        <input type="text" id="S_CODE_GRP_NM"  maxlength="50">
                    </td>
                </tr>
            </tbody>
        </table>
    </div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap -->

<div class="sub-tit">
    <h4>그룹코드</h4>
    
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnAddRowGrp">그룹추가</button>
        <button type="button" class="btn" id="btnDelRowGrp">삭제</button>
        <button type="button" class="btn" id="btnSaveGrp">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridListGrp"></div> 
</div>

<div class="sub-tit">
    <h4>상세코드</h4>
    
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnAddRowDetl">상세추가</button>
        <button type="button" class="btn" id="btnDelRowDetl">삭제</button>
        <button type="button" class="btn" id="btnSaveDetl">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridListDetl"></div> 
</div>
