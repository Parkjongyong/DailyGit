<%--
	File Name : bdgMeetingMgmt.jsp
	Description: 영업 > 영업관리 > 영업회의참여자관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.13  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.13
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var compList     = new Array();
var gubnList     = new Array();
var etcGubnList  = new Array();
var statusCodes  = new Array();
var statusLabels = new Array();

$(document).ready(function() {
	
	compList = stringToArray("${CODELIST_SYS001}");
	gubnList = stringToArray("${CODELIST_YS035}", '${LOGIN_INFO.ETC_CHC_GUBN}');
	etcGubnList = stringToArray("${CODELIST_YS012}");
	
    // 콤보 구성(조회 조건)
    fnMakeComboOption('SB_COMP_CD'    , compList, 'CODE', 'CODE_NM');
    fnMakeComboOption('SB_GUBN_CD'    , gubnList, 'CODE', 'CODE_NM');
    fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList, 'CODE', 'CODE_NM');
    
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#SB_COMP_CD").val('1100');
	$("#TB_CRTN_YYMM").val(getDiffDay("y",0).substring(0,7));
	$("#TB_MEETING_DATE").val(getDiffDay("y",0));
	$("#SB_CHC_ETC_GBN").val('${LOGIN_INFO.ETC_CHC_GUBN}');
}

function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'ORG_CD',                  {text:'부서코드'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'ORG_NM',                  {text:'부서명'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'SABUN',                   {text:'사번'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'SABUN_NM',                {text:'사원명'},                         60,     'text', {textAlignment: "center"});
    addField(cm,    'CODEMAPPING1',            {text: ' '},          20,     'popupLink');
    addField(cm,    'MEETING_DATE',            {text:'회의일자'},                         60,     'text', {textAlignment: "center"});

    addField(cm,    'COMP_CD',                 {text: '회사코드'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YYMM',               {text: '기준년월'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CHC_ETC_GBN',             {text: 'ETCCHC구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'DATA_GUBN',               {text: '구분'},         0,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'G_GUBN',                  {text: '직급구분'},      60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'GUBN_DESC',               {text: '영업회의'},      60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                    {text: '행구분'},        60,     'text', {textAlignment: "center"},{visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : _G_GRID_HEIGHT_M       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    //그리드 변경 시 체크박스 true
    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridView.checkItem(dataRow, true);
    };
    
    
    gridView.onDataCellClicked = function (grid, data) {
        
    	var temp = fnGetGridRowParams(gridView, data.itemIndex);
        if (data.fieldName == "CODEMAPPING1" && temp.DATA_GUBN == 'Y' && temp.CRUD == "I") {
        	fnSearchUser();
        }       
    };    
    
    // 기본 스타일 적용
    var columnDefaultStyles = function(grid, index, value) {
        var styles = {};
        	styles.editable = false;
        return styles;
    };
    
    // 기본 스타일 적용
    var columnDefaultStyles2 = function(grid, index, value) {
        var styles = {};
        	styles.editable = true;
        	styles.editable = "#d5e2f2";
        return styles;
    };    

    gridView.setColumnProperty("ORG_CD"  , "dynamicStyles", columnDefaultStyles);    
    gridView.setColumnProperty("ORG_NM"  , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("SABUN"   , "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("SABUN_NM", "dynamicStyles", columnDefaultStyles);
    gridView.setColumnProperty("MEETING_DATE", "dynamicStyles", columnDefaultStyles2);
    
    gridView.setOptions({sortMode:"explicit"});
}
/**
 * 조회
 */
function fnSearch() {
	$('#ORG_CD').val('${LOGIN_INFO.DEPT_CD}');
	var etcChcGubn = '${LOGIN_INFO.ETC_CHC_GUBN}';
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectMeetingMgmt');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isEmpty(data.rows)){
		gridView.clearRows();
	}
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
 * 사용자 조회 팝업
 */
function fnSearchUser() {
    var params = fnGetParams();
    params.SB_COMP_NM  = $("#SB_COMP_CD option:selected").text();
    params.SB_COMP_CD  = $("#SB_COMP_CD").val();
    params.JICK_GUBN   = $("#SB_GUBN_CD").val();
    params.CHC_ETC_GBN = $("#SB_CHC_ETC_GBN").val();
    var target = "userList";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/userList', params, target, width, height, scrollbar, resizable);
}

/**
 * 사용자 조회 팝업 콜백
 */
function fnCallbackPop(rows) {
	
	var values = {
	             "SABUN"    : rows.USER_ID
		       , "SABUN_NM" : rows.USER_NM
		       , "ORG_CD"   : rows.DEPT_CD
		       , "ORG_NM"   : rows.DEPT_NM
	     };
	gridView.setValues(gridView.getCurrent().itemIndex, values);		

}

//일괄입력
function fnAllInput() {
	
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	
	// 필수 체크
	for(var i = 0; i < checkedRows.length; i++){
		var temp = gridView.getValues(checkedRows[i]);
		
		gridView.setValue(checkedRows[i], "MEETING_DATE", $('#TB_MEETING_DATE').val().replace('-', '').replace('-', ''));
	}	
	
}

//행추가
function fnRowCopy() {
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("년월 필수입니다.");
		return false;
	}
	
	var dataGubn = "";
	
	if ($("#SB_GUBN_CD").val() == "4") {
		dataGubn = "Y";
	} else {
		dataGubn = "N";
	}
	var checkedRows = gridView.getCheckedItems(false);
	if (checkedRows.length > 1) {
		alert("한 건만 체크 후 작업하세요.");
		return false;		
	}
	
	var temp = fnGetGridRowParams(gridView, checkedRows[0]);
	
	var values = { "CRUD" : "I" 
			      ,"DATA_GUBN" : dataGubn
			      ,"COMP_CD" : temp.COMP_CD
			      ,"CRTN_YYMM" : temp.CRTN_YYMM
			      ,"CHC_ETC_GBN" : temp.CHC_ETC_GBN
			      ,"ORG_CD" : temp.ORG_CD
			      ,"G_GUBN" : temp.G_GUBN
			      ,"ORG_NM" : temp.ORG_NM
			      ,"SABUN" : temp.SABUN
			      ,"SABUN_NM" : temp.SABUN_NM
			      ,"CODEMAPPING1" : "1"};
	gridView.insertRow(toNumber(checkedRows[0])+1, values);
}

//행추가
function fnRowAdd() {
	
	if($("#TB_CRTN_YYMM").val() == null || $("#TB_CRTN_YYMM").val() == ""){
		alert("년월 필수입니다.");
		return false;
	}
	
	if($("#SB_GUBN_CD").val() == "4"){
		//영업사원은 pass
	} else {
		alert("행추가는 영업사원 등록시에만 가능합니다. 구분값을 확인하시고 작업하세요.");
		return false;		
	}
	
	var values = { "CRUD" : "I" 
			      ,"DATA_GUBN" : "Y"
			      ,"COMP_CD" : $('#SB_COMP_CD').val()
			      ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replace('-', '')
			      ,"G_GUBN" : $('#SB_GUBN_CD').val()
			      ,"CHC_ETC_GBN" : $('#SB_CHC_ETC_GBN').val()
			      ,"CODEMAPPING1" : "1"};
	fnAddRow(gridView, values, gridView.getRowCount());
}

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridView);
}

//저장
function fnSave() {
	gridView.commit();
	var checkedRows = gridView.getCheckedItems(false);
	
	// 필수 체크 대상(그리드)
	var requiredVal   = [];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal, false) == true){
		if(confirm("저장 하시겠습니까?")){
			var params = {};
			$.extend(params, {"ITEM_LIST"   : fnGetGridCheckData(gridView)});
			$.extend(params, fnGetParams());
			
			saveCall(gridView, '/com/bdg/saveMeetingMgmt', 'fnSave', params);
		}
	}
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

//삭제
function fnDelete() {
	
	gridView.commit();

	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
	
	if(fnDeleteCheck(gridView) == true){
		deleteCall(gridView, '/com/bdg/deleteMeetingMgmt', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
    gridView.closeProgress();
    fnSearch();
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
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
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD" disabled="disabled"></select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text" class="datepicker_ym" id="TB_CRTN_YYMM"  value="" style="width:70px;"/>
                    </td>
                    <th><span>구분</span></th>
                    <td>
                        <select id="SB_GUBN_CD" name="SB_GUBN_CD" data-type="select" data-bind="selectedOptions: SB_GUBN_CD" ></select>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" disabled="disabled">
	                    </select>
                    </td>
                    <td>
                    	<input type="hidden" id="ORG_CD">
                    </td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>                            
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
	<div class="tbl-search-btn">
		<button class="btn-search" id="btnSearch">조회</button>
	</div>			    
</div><!-- // search_field_wrap -->
    <div class="tbl-search-area" style="float:left; width:350px;">
        <table class="tbl-search">
            <colgroup>
                <col>
                <col>
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 10px; padding-left: 15px;"><span>회의일자</span></th>
	        	<td style="padding-top: 10px;">
	        		<input type="text" class="datepicker" id="TB_MEETING_DATE"  value="" style="width:90px;"/>
					<button type="button" class="btn" id="btnAllInput">일괄입력</button>	        	
	        	</td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
	<div class="btnArea t_right">
		<button type="button" class="btn" id="btnRowCopy">복사</button>
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelete">삭제</button>	
	    <button type="button" class="btn" id="btnSave">저장</button>
	</div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
