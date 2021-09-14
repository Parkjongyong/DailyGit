<%--
	File Name : bdgFamilyEvent.jsp
	Description:예산 > 부가정보 > 대외경조관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.09.04  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.09.04
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var statusCodes  = new Array();
var statusLabels = new Array();

var evntCodes  = new Array();
var evntLabels = new Array();

var rltnlCodes  = new Array();
var rltnlLabels = new Array();

var wayCodes  = new Array();
var wayLabels = new Array();

var useYnCodes  = new Array();
var useYnLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var statusList  = stringToArray("${CODELIST_YS013}");
	fnMakeComboOption('SB_STATUS', statusList,     'CODE', 'CODE_NM', null, "","전체");

	statusCodes  = getComboSet('${CODELIST_YS013}', 'CODE');
	statusLabels = getComboSet('${CODELIST_YS013}', 'CODE_NM');
	
	evntCodes  = getComboSet('${CODELIST_YS014}', 'CODE');
	evntLabels = getComboSet('${CODELIST_YS014}', 'CODE_NM');
	
	rltnlCodes  = getComboSet('${CODELIST_YS015}', 'CODE');
	rltnlLabels = getComboSet('${CODELIST_YS015}', 'CODE_NM');
	
	wayCodes  = getComboSet('${CODELIST_YS016}', 'CODE');
	wayLabels = getComboSet('${CODELIST_YS016}', 'CODE_NM');
	
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	//$("#TB_DEPT_NM").val('${LOGIN_INFO.DEPT_NM}');
	//$("#TB_DEPT_CD").val('${LOGIN_INFO.DEPT_CD}');
	$("#SB_STATUS").val('2');
	$("#TB_START_DT").val(firstDayByMonth(getDiffDay("m",0))); //한달전 첫째일
	$("#TB_END_DT").val(lastDayByMonth(getDiffDay("m",1)));

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '진행상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:statusCodes,labels:statusLabels, editable: false},'dropDown');
    addField(cm,    'ORG_CD',           {text:'부서코드'},        80,            'text',              {textAlignment:"center"});
    addField(cm,    'ORG_NM',           {text:'부서명'},        100,            'text',           {textAlignment:"near"});
    addField(cm,    'REQ_SABUN',            {text:'신청자사번'},      100,            'text',           {textAlignment:"center"});
    addField(cm,    'CODEMAPPING1',         {text: ' '},         15,     'popupLink');
    addField(cm,    'REQ_SABUN_NM',         {text:'신청자명'},      80,            'text',           {textAlignment:"center"});
    
    addField(cm,    'REQ_DATE',            {text:'신청일자'},        100,            'datetime',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'EVNT_DATE',           {text:'경조일자'},        100,            'datetime',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
    addField(cm,    'EVNT_CODE',           {text:'경조구분'},        60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:evntCodes,labels:evntLabels},'dropDown');
    addField(cm,    'EVNT_YR_NM',          {text:'경조당사자\n(결혼당사자/사망자)'},        120,    'text',           {textAlignment:"center"});
    
    addField(cm,    'EVNT_RLTNL_CODE',     {text:'관계'},        80,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:rltnlCodes,labels:rltnlLabels},'dropDown');
    addField(cm,    'EVNT_TRGT_NM',        {text:'성명'},        80,            'text',           {textAlignment:"center"});
    addField(cm,    'VENDOR_CD',           {text:'거래처코드'},        80,            'text',           {textAlignment:"center"});
    addField(cm,    'VENDOR_NM',           {text:'거래처명'},        120,            'text',           {textAlignment:"near"});
    addField(cm,    'CODEMAPPING2',         {text: ' '},         15,     'popupLink');
    addField(cm,    'EVNT_WAY_CODE',       {text:'경조방법'},        60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:wayCodes,labels:wayLabels},'dropDown');
    addField(cm,    'EVNT_AMT',            {text:'경조금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'EVNT_LOCATION',       {text:'장소'},        120,            'text',           {textAlignment:"near"});
    addField(cm,    'EVNT_KYR_YN',         {text:'김영란법유무'},        80,            'text',           {textAlignment:"center"},{lookupDisplay: true,values:useYnCodes,labels:useYnLabels},'dropDown');
    
    addGroup(cm, {"경조대상자" : ["EVNT_RLTNL_CODE","EVNT_TRGT_NM"], "거래처정보" : ["VENDOR_CD","VENDOR_NM"]});
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'REQ_SEQ',              {text: '요청 SEQ'},      0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사'},      0,     'text', {textAlignment: 'center'},  {visible:false});

    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 550       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });


    gridView.onCurrentRowChanged =  function (grid, oldRow, newRow) {
    	
    };

    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    gridView.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
    	var status = gridView.getValue(colIndex.itemIndex,"STATUS");
       	if(gridView.getValue(colIndex.itemIndex,"CRUD") == 'I' && colIndex.fieldName == "CODEMAPPING1"){
       		fnSearchUser();
       	}
       	
       	if((status == '1' || status == '3') && colIndex.fieldName == "CODEMAPPING2"){
       		fnSearchCustomer();
       	}       	

    };
    
    
    // 동적 스타일 적용
    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn = values.STATUS;
            styles.editable = true;
            styles.background = "#d5e2f2";

        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };        
    
    setDefaultStyle(gridView, "dynamicStyles",columnDefaultStyles);
	gridView.setColumnProperty("EVNT_DATE"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_YR_NM"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_TRGT_NM"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_AMT"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_LOCATION"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_KYR_YN"  , "dynamicStyles", columnDynamicStyles);
	
	gridView.setColumnProperty("EVNT_CODE"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_RLTNL_CODE"  , "dynamicStyles", columnDynamicStyles);
	gridView.setColumnProperty("EVNT_WAY_CODE"  , "dynamicStyles", columnDynamicStyles);
    
    gridView.setHeader({height : 50});
    
    gridView.setOptions({sortMode:"explicit"});
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectFamilyEvent');
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
 * 거래처 조회 팝업
 */
function fnSearchCustomer() {
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"COMP_CD" : gridView.getRowValue(gridView.getCurrent().itemIndex, "COMP_CD")});
    var target = "customerList";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/customerList', params, target, width, height, scrollbar, resizable);
}

/**
 * 거래처 조회 팝업 콜백
 */
function fnCallbackCustomerSearchPop(rows) {
	
	var values = {
	         "VENDOR_CD" : rows.CUST_CD
	       , "VENDOR_NM" : rows.CUST_NAME1
	     };
	gridView.setValues(gridView.getCurrent().itemIndex, values);

}

//행추가
function fnRowAdd() {
	var values = { "CRUD" : "I" 
	              ,"STATUS" : "3"
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"REQ_DATE" :getDiffDay("y",0).replaceAll('-','')
	              ,"CODEMAPPING1" : "1"
	              ,"CODEMAPPING2" : "1"
	              };
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

// 확정
var fnConfirm = function(){
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetGridCheckData(gridView)});

	if(isEmpty(params.ITEM_LIST.CHECK_LIST)){
		alert("확정할 대상이 없습니다.");
		return false;
	}

	for(var i = 0; i < params.ITEM_LIST.CHECK_LIST.length; i++){
		if(params.ITEM_LIST.CHECK_LIST[i].STATUS != '2'){
			alert("신청 건만 확정 가능합니다.");
			return false;
		}
	}

	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_SABUN", "NEW_BUGT_AMT"]; 
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("확정 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/confirmFamilyEvent', 'fnConfirm', params);
	     }
	}
}

function fnConfirmSuccess(data) {
	alert("확정 되었습니다.");
	fnSearch();

}

function fnConfirmFail(result) {
	alert(result.errMsg);
}


/**
 * 저장
 */
function fnSave() {
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	
	if(gridView.getCheckedItems(false).length == 0){
		alert("체크된 데이터가 없습니다.");
		return false;
	}
	
	for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
		if(params.ITEM_LIST.UPDATED[i].STATUS != '1'){
			alert("신청 또는 확정된 데이터는  저장이 불가능합니다.");
			return false;
		}
	}

	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "ORG_CD", "REQ_SABUN"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/saveFamilyEvent', null, params);
	     }
	}

}

function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	fnSearch();

}

function fnSaveFail(result) {
	alert(result.errMsg);
}


/**
 * 삭제
 */
function fnDelete() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(isEmpty(params.ITEM_LIST)){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/delFamilyEvent', 'fnDel', params);
	}

}

/**
 * 삭제 성공
 */
function fnDelSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearch();
}

/**
 * 삭제 실패
 */
function fnDelFail(result) {
	alert(result.errMsg);
}	

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}


/**
 * 부서 조회
 */
function fnSearchDept(str) {
	paramGubn = str;
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnDeptSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/deptList', params, target, width, height, scrollbar, resizable);
}

/**
 * 부서 콜백
 */
function fnCallbackDeptSearchPop(rows) {
	$("#TB_DEPT_CD").val(rows.DEPT_CD);
	$("#TB_DEPT_NM").val(rows.DEPT_NM);
}

/**
 * 사원 조회
 */
function fnSearchUser() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_NM" :  $("#SB_COMP_CD option:selected").text()});
	
	var target    = "cmnUserSearchPop";
	var width     = "1200";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 사원 콜백
 */
 function fnCallbackPop(rows) {
	var values = {
	         "REQ_SABUN"   : rows.USER_ID,
	         "REQ_SABUN_NM"   : rows.USER_NM,
	         "ORG_NM"   : rows.DEPT_NM,
	         "ORG_CD"   : rows.DEPT_CD
	     };

	gridView.setValues(gridView.getCurrent().itemIndex, values);

}

//부서 리셋
function fnDeptReset() {
	$("#TB_DEPT_CD").val("");
	$("#TB_DEPT_NM").val("");
	fnSearch();
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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD">
	                    </select>
                    </td>
                    <th><span class="stit">신청일자</span></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="TB_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="TB_END_DT" dateHolder="end" value=""/>
                    </td>
                    <th><span>부서</span></th>
                    <td>
                        <input type="text"   id="TB_DEPT_NM" disabled>
                        <input type="hidden" id="TB_DEPT_CD">
                        <a href="javascript:fnSearchDept('condition');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnDeptReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>진행상태</span></th>
                    <td>
                        <select id="SB_STATUS" name="SB_STATUS">
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
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnConfirm">확정</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>
        <button type="button" class="btn" id="btnSave">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>