<%--
	File Name : bdgPromDetail.jsp
	Description:예산 > 영업관리 > 홍보디테일관리_EXCEL
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.31  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.31
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var chcCtcCodes  = new Array();
var chcCtcLabels = new Array();
var distCodes    = new Array();
var distLabels   = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var distList  = stringToArray("${CODELIST_YS008}");
	fnMakeComboOption('SB_DIST', distList,     'CODE', 'CODE_NM', null,"","전체");

	var etcGubnList  = stringToArray("${CODELIST_YS012}");
	fnMakeComboOption('SB_CHC_ETC_GBN', etcGubnList,     'CODE', 'CODE_NM', null);

	chcCtcCodes  = getComboSet('${CODELIST_YS012}', 'CODE');
	chcCtcLabels = getComboSet('${CODELIST_YS012}', 'CODE_NM');
	
	distCodes  = getComboSet('${CODELIST_YS008}', 'CODE');
	distLabels = getComboSet('${CODELIST_YS008}', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitgridView();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    
    // 자동조회
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#TB_CRTN_YYMM").val('${PARAM.TB_CRTN_YYMM}');
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	$("#TB_ORG_NM").val('${PARAM.TB_ORG_NM}');
	$("#TB_ORG_CD").val('${PARAM.TB_ORG_CD}');
	$("#SB_CHC_ETC_GBN").val('${PARAM.SB_CHC_ETC_GBN}');
	$("#SB_DIST").val('${PARAM.SB_DIST}');
	

}

function setInitgridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'REQ_SABUN',           {text:'사원코드'},      100,            'text',           {textAlignment:"center"});
    addField(cm,    'FORWARD_AMT',         {text:'이월금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'BAL_BUGT_AMT',        {text:'당월예산금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'ETC_BUGT_AMT',        {text:'기타금액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'RESULT_AMT',          {text:'실적'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'TOT_BUDGET',          {text:'예산누계'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'BAL_BUDGET',          {text:'예산잔액'},        100,            'number',           {textAlignment:"far"});
    addField(cm,    'REMARK',              {text:'에러내역'},           300,            'text',           {textAlignment:"near"});
    
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'COMP_CD',              {text: '회사코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YYMM',            {text: '기준년월일'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ORG_CD',               {text: '작성부서코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'DISTRIB_CD',           {text: '유통'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CHC_ETC_GBN',          {text:'부문'},       60,            'text',              {textAlignment:"center"},{lookupDisplay: true,values:chcCtcCodes,labels:chcCtcLabels, editable: false ,visible:false},'dropDown');

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
    };
    
    
    gridView.onRowsPasted = function(grid, items){
    	
    	for(var i = 0; i < items.length; i++){
	    	gridView.setValue(items[i], "CRUD", "I");
	    	gridView.setValue(items[i], "CHC_ETC_GBN", $('#SB_CHC_ETC_GBN').val());
	    	gridView.setValue(items[i], "COMP_CD", $('#SB_COMP_CD').val());
	    	gridView.setValue(items[i], "CRTN_YYMM", $('#TB_CRTN_YYMM').val().replaceAll('-', ''));
	    	gridView.setValue(items[i], "ORG_CD", $('#TB_ORG_CD').val());
	    	gridView.setValue(items[i], "DISTRIB_CD", $('#SB_DIST').val());
        	gridView.checkItem(items[i], true);
    	}
    	
    };	    
    
    // 동적 스타일 적용
    var columnDynamicStyles1 = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.BAL_BUDGET;
        if (toNumber(gubn) >= 0) {
            styles.editable = true;
            styles.background = "#d5e2f2";
        } else {
            styles.editable = false;
        }
        return styles;
    };
    
    // 동적 스타일 적용
    var columnDynamicStyles2 = function(grid, index, value) {
        var styles = {};
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
	gridView.setColumnProperty("ETC_BUGT_AMT"  , "dynamicStyles", columnDynamicStyles1);
	gridView.setColumnProperty("FORWARD_AMT"  , "dynamicStyles", columnDynamicStyles2);
	gridView.setColumnProperty("BAL_BUGT_AMT"  , "dynamicStyles", columnDynamicStyles2);
	gridView.setColumnProperty("DISTRIB_CD"  , "dynamicStyles", columnDynamicStyles2);
	gridView.setColumnProperty("REQ_SABUN"  , "dynamicStyles", columnDynamicStyles2);
	
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/bdg/selectPromDetailExcel');
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
    
    if (isEmpty(data.rows)) {
    	fnRowAdd();
    }
    
}


//행추가
function fnRowAdd() {
	var values = { 
				   "CRUD" : "I" 
	              ,"CHC_ETC_GBN" : $('#SB_CHC_ETC_GBN').val()
	              ,"COMP_CD" : $('#SB_COMP_CD').val()
	              ,"CRTN_YYMM" : $('#TB_CRTN_YYMM').val().replaceAll('-', '')
	              ,"ORG_CD" : $('#TB_ORG_CD').val()
	              ,"DISTRIB_CD" : $('#SB_DIST').val()
	              };
	
	fnAddRow(gridView, values, gridView.getRowCount());
	
}

/**
 * 저장
 */
function fnSave() {
	//전체 체크
	gridView.setAllCheck(true);
	gridView.checkAll(true,false);
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : gridView.getAllJsonRowsExcludeDeleteRow()});
	
	for(var i = 0; i < params.ITEM_LIST.length; i++){
		
		for(var j = i+1; j < params.ITEM_LIST.length; j++){
			if(params.ITEM_LIST[i].REQ_SABUN == params.ITEM_LIST[j].REQ_SABUN){
				alert("사원코드가 중복되었습니다. \n확인 후 작업을 진행해주세요.");
				return false;
			}
		}
		
	}
		
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_SABUN"];
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("저장 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/savePromDetailExcel', null, params);
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
		deleteCall(gridView, '/com/bdg/delPromDetail', 'fnDel', params);
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
 * 업로드
 */
 function fnUpload() {
	gridView.setAllCheck(true);
	gridView.checkAll(true,false);
	gridView.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : gridView.getAllJsonRowsExcludeDeleteRow()});
	
	
	for(var i = 0; i < params.ITEM_LIST.length; i++){
		if(isNotEmpty(params.ITEM_LIST[i].REMARK) == true){
			alert("에러내역이 존재합니다.\n에러내역를 확인하시고 업로드를 진행해주세요.");
			return false;
		}
		
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["COMP_CD", "REQ_SABUN"];
	
	// 필수 체크 후 업로드 진행
	if(fnSaveCheck(gridView, requiredVal) == true){
	     if(confirm("업로드 하시겠습니까?")){
	    	 saveCall(gridView, '/com/bdg/savePromDetailUpload', 'fnUpload', params);
	     }
	}
}

 /**
 * 삭제 성공
 */
function fnUploadSuccess(result) {
	alert("업로드 성공하였습니다.");
	close();
	parentCallback('fnSearch');
}

/**
 * 삭제 실패
 */
function fnUploadFail(result) {
	alert(result.errMsg);
}	


//행삭제
function fnRowDel() {
	fnCheckRowDelete(gridView);
}

//양식지 다운로드
function fnDownLoad() {
	oneFileDownload('${dataInfo.ATTACHMENT}', '${dataInfo.ATTACH_SEQ}');

}

/**
 * 양식지 업로드 버튼 클릭 시 이벤트
 */
function fnAttFile() {
    var fileParams = {KEY_ID: 'APP_SEQ' // required 연관 파일 키
                     ,CALLBACK: 'fnInitFileUpload' // required 업로드후 콜백 받을 함수 - 여기서는 첨부파일 조회함수를 재 호출하도록 함
                     };
    openFileUplaod(fileParams);
}

/**
 * 첨부파일 버튼 클릭 시 이벤트
 */
 function fnInitFileUpload() {
    if ($("#APP_SEQ").val() != "") 
        displayFileUpload({
            KEY_ID      : 'APP_SEQ',
            DATA_FORMAT : 'outTable',
            CALLBACK    : 'fnFileUploadCallback'
        });
}

 /**
  * 첨부파일멀티용 CALL BACK
  */
function fnFileUploadCallback(data) {
    $('.upload-list').empty().html(data);
}
 


</script>
    <form name="downForm" target="dowmloadFilePop">
		<input type="hidden" id="APP_SEQ" name="APP_SEQ" value="<c:out value="${dataInfo.ATTACHMENT }" />" />
		<input type="hidden" id="ATTACH_SEQ" name="ATTACH_SEQ" value="<c:out value="${dataInfo.ATTACH_SEQ }" />" />
    </form>

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
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled="disabled">
	                    </select>
                    </td>
                    <th><span>년월</span></th>
                    <td>
						<input type="text"  id="TB_CRTN_YYMM"  value="" style="width:90px;" disabled="disabled"/>
                    </td>
                    <th><span>부서</span></th>
                    <td>
                        <input type="text"   id="TB_ORG_NM" disabled>
                        <input type="hidden" id="TB_ORG_CD">
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <th><span>부문</span></th>
                    <td>
	                    <select id="SB_CHC_ETC_GBN" name="SB_CHC_ETC_GBN" disabled>
	                    </select>
                    </td>
                    <th><span>유통</span></th>
                    <td>
                        <select id="SB_DIST" name="SB_DIST" disabled>
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
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 15px;">(단위 : 원)</th>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right">
<!--         <button type="button" class="btn" id="btnAttFile">양식지업로드</button> -->
<!--         <button type="button" class="btn" id="btnDownLoad">양식지다운로드</button> -->
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnSave">저장</button>
        <button type="button" class="btn" id="btnUpload">업로드</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>