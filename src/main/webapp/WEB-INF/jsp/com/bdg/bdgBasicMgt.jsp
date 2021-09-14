<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 기본예산신청
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.12  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.12
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;
var apprCodes  = new Array();
var apprLabels = new Array();

var processTypeCodes  = new Array();
var processTypeLabels = new Array();

var nextDeptCodes  = new Array();

var processType  = "";
var accountNo    = "";
var accountDesc  = "";
var accountGubn  = "";
var remark       = "";
var rowIndex     = "";
var nextYear     = getDiffDay("y",1).substring(0,4);
var bBudget      = 0;
var modifyFlag   = "N";
var wCode        = "";
var status       = "";

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${COMPLIST}");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM');
	
	fnCompCdChange();
	
	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");
	
	nextDeptCodes = getComboSet('${CODELIST_YS039}', 'CODE');

	apprCodes  = getComboSet('${CODELIST_YS001}', 'CODE');
	apprLabels = getComboSet('${CODELIST_YS001}', 'CODE_NM');
	
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM');	
	
	// 초기 상태값 처리
    fnInitStatus();
	
	// 그리드 생성
	setInitGridHeader();
	setInitGridDetail();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	if (toNumber(getDiffDay("y",0).substring(5,7)) >= 10) {
		$("#TB_CRTN_YY").val(getDiffDay("y",1).substring(0,4));	
	} else {
		$("#TB_CRTN_YY").val(getDiffDay("y",0).substring(0,4));
	}
	
	//$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');

}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '승인상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:apprCodes,labels:apprLabels, editable:false},'dropDown');
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'textLink',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        140,            'text',              {textAlignment:"near"});
    // 당기수정기본예산 : 2020년 기준 2019년 당기수정예산
    addField(cm,    'A_BUDGET',             {text:'당기기본예산'},  100,            'integer',           {textAlignment:"far"});
    // 산정추정 : 2019년 1월 ~ 9월 실적 + 2019년 10월 ~ 12월 수정기본예산 합
    addField(cm,    'B_BUDGET',             {text:'산정추정'},      100,            'integer',           {textAlignment:"far"});
    // 예상추정 : 산정추정값과 동일하고 수정 가능
    addField(cm,    'PRESUME_AMT',          {text:'예상추정'},      100,            'integer',           {textAlignment:"far"});
    // 집행률 : 예상추정 / 당기수정기본예산
    addField(cm,    'D_BUDGET',             {text:'집행율'},        100,            'number',           {textAlignment:"far"}, {editable:false});
    addField(cm,    'WK_M01',               {text:'1월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'A_SUM',                {text:'상반기'},         100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'B_SUM',                {text:'하반기'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'C_SUM',                {text:'합계'},          100,            'integer',           {textAlignment:"far"});
    // 예산증감률 :  수정기본예산 / 1월 ~12월 합계
    addField(cm,    'A_RATE',               {text:'예산증감율'},    100,            'number',           {textAlignment:"far"});
    // 산정증감율 :  산정추정 / 1월 ~12월 합계
    addField(cm,    'B_RATE',               {text:'산정증감율'},    100,            'number',           {textAlignment:"far"});
    // 예산증감율 :  예상추정 / 1월 ~12월 합계
    addField(cm,    'C_RATE',               {text:'예상증감율'},    100,            'number',           {textAlignment:"far"});
    addField(cm,    'REMARK',               {text: '증감요인'},     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    
    addField(cm,    'COMP_CD',              {text: 'COMP_CD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YY',              {text: 'CRTN_YY'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CCTR_CD',              {text: 'CCTR_CD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'W_CODE',               {text: '위탁연구비코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'ACCOUNT_GUBN',         {text: '계정구분'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    

    gridHeader.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 260       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridHeader.onDataCellClicked = function (grid, colIndex) {
    	if(modifyFlag == "Y"){
    		if(confirm("수정 중인 데이터가 존재합니다.\n저장 하시겠습니까?")){
    			fnSaveD("Y");
    		}
    		
    	}

    	modifyFlag = "N";
    	var gridView = grid.getDataProvider();
        if (colIndex.fieldName == "ACCOUNT_NO") {
        	accountNo   = gridView.getValue(colIndex.itemIndex,"ACCOUNT_NO");
        	accountDesc = gridView.getValue(colIndex.itemIndex,"ACCOUNT_DESC");
        	remark      = gridView.getValue(colIndex.itemIndex,"REMARK");
        	processType = gridView.getValue(colIndex.itemIndex,"PROCESS_TYPE");
        	accountGubn = gridView.getValue(colIndex.itemIndex,"ACCOUNT_GUBN");
        	status      = gridView.getValue(colIndex.itemIndex,"STATUS");
        	
        	rowIndex    = colIndex.itemIndex;
        	
        	if(toNumber(gridView.getValue(colIndex.itemIndex,"B_RATE")) > 10 || toNumber(gridView.getValue(colIndex.itemIndex,"B_RATE")) < -10){
        	} else {
        		//document.getElementById("TB_REMARK").readOnly = true;
        	}

        	
        	$("#TB_ACCOUNT_NO").val(gridView.getValue(colIndex.itemIndex,"ACCOUNT_NO"));
        	$("#TB_ACCOUNT_DESC").val(gridView.getValue(colIndex.itemIndex,"ACCOUNT_DESC"));
        	$("#TB_REMARK").val(gridView.getValue(colIndex.itemIndex,"REMARK"));
        	$("#TB_PRESUME_AMT").val(gridView.getValue(colIndex.itemIndex,"PRESUME_AMT"));
        	$("#TB_PROCESS_TYPE").val(gridView.getValue(colIndex.itemIndex,"PROCESS_TYPE"));
        	
        	$("#SB_COMP_CD").val(gridView.getValue(colIndex.itemIndex,"COMP_CD"));
        	$("#TB_CRTN_YY").val(gridView.getValue(colIndex.itemIndex,"CRTN_YY"));
        	$("#SB_CCTR_CD").val(gridView.getValue(colIndex.itemIndex,"CCTR_CD"));
        	
        	
        	//위탁연구비 계정일때만 보이게 처리
        	if($("#TB_ACCOUNT_NO").val() == wCode){
        		gridDetail.setColumnProperty("PROJECT", "visible", true);
        		gridDetail.setColumnProperty("CODEMAPPING2", "visible", true);
        	} else {
        		gridDetail.setColumnProperty("PROJECT", "visible", false);
        		gridDetail.setColumnProperty("CODEMAPPING2", "visible", false);
        	}
        	
        	if (processType == "2") {
        		$("#div_btnD").hide();
        		gridDetail.setColumnProperty("DETAIL_DESC", "visible", false);
        		gridDetail.setColumnProperty("BELONG_CCTR", "visible", true);
        	} else {
        		if (accountGubn == "N") {
        			$("#div_btnD").hide();
            		gridDetail.setColumnProperty("DETAIL_DESC", "visible", false);
            		//gridDetail.setColumnProperty("BELONG_CCTR", "visible", true);        			
        		} else {
        			if (status == "1") {
                		$("#div_btnD").show();
                		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
                		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);           				

        			} else {
            			$("#div_btnD").hide();
                		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
                		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);      				
        			}
        		}
        	}        	
        	
        	
//         	if($("#TB_CRTN_YY").val() != nextYear){
//         		$("#div_btnH").css("visibility", "hidden");
//         		$("#div_btnD").css("visibility", "hidden");
//         	} else {
//         		$("#div_btnH").css("visibility", "visible");
//         		$("#div_btnD").css("visibility", "visible");
//         	}

        	fnSearchDetail();
        }
    };

    gridHeader.onCurrentRowChanged =  function (grid, oldRow, newRow) {
        // 동적 스타일 적용
        var columnDynamicStyles = function(grid, index, value) {
            var styles = {};
            var values = grid.getValues(index.itemIndex);
            var gubn   = values.CRUD;
            var processType = values.PROCESS_TYPE;
            var accountGubn = values.ACCOUNT_GUBN;
            var status = values.STATUS;
            if (gubn == 'I') {
            	styles = enableColStyle;
            } else {
            	if (processType == "2") {
            		styles = disibleColStyle;
            	} else {
            		if (accountGubn == "Y") {
            			if (status == "1") {
            				styles = enableColStyle;	
            			} else {
            				styles = disibleColStyle;
            			}
            		} else {
            			styles = disibleColStyle;
            		}
            	}
            }
            return styles;
        };
        
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
            return disibleColStyle;
        };        
        
        setDefaultStyle(gridHeader, "dynamicStyles",columnDefaultStyles);
        gridHeader.setColumnProperty("PRESUME_AMT"    , "dynamicStyles", columnDynamicStyles);
        
    };

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    };
    
    gridHeader.setFixedOptions({
    	  colCount: 4
    });
    
    fnGridSortFalse(gridHeader);
    gridHeader.setDisplayOptions({columnMovable:false})

}

function setInitGridDetail() {
    var gridId = "gridDetail";
    gridDetail = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'DETAIL_DESC',          {text:'구분'},       200,            'text',              {textAlignment:"near"});
    addField(cm,    'BELONG_CCTR',       {text:'귀속코스트센터'},   140,            'text',              {textAlignment:"near"},{visible:false});
    addField(cm,    'PROJECT',              {text:'내부오더'},  100,            'text',              {textAlignment:"center"},{visible:false});
    addField(cm,    'CODEMAPPING2',  	    {text: ' '},    15,     'popupLink',null,{visible:false});
    addField(cm,    'UNIT_PRICE',           {text:'단가'},       100,            'text',           {textAlignment:"near"});
    addField(cm,    'UNIT_QTY',             {text:'수량'},       100,            'text',           {textAlignment:"near"});
    addField(cm,    'WK_M01',               {text:'1월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M02',               {text:'2월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M03',               {text:'3월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M04',               {text:'4월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M05',               {text:'5월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M06',               {text:'6월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'A_SUM',                {text:'상반기'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M07',               {text:'7월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M08',               {text:'8월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M09',               {text:'9월'},           100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M10',               {text:'10월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M11',               {text:'11월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'WK_M12',               {text:'12월'},          100,            'integer',           {textAlignment:"far"});
    addField(cm,    'B_SUM',                {text:'하반기'},        100,            'integer',           {textAlignment:"far"});
    addField(cm,    'C_SUM',                {text:'합계'},          100,            'integer',           {textAlignment:"far"});
    
    addField(cm,    'CRUD',              {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'COMP_CD',           {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRTN_YY',           {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'CCTR_CD',            {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'ACCOUNT_NO',        {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'SEQ_NO',            {text: ''},                    60,     'integer', {textAlignment: "center"},{visible:false});
    addField(cm,    'BELONG_CCTR_CD',     {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PROJECT_CD',        {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'PROCESS_TYPE',      {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'STATUS',            {text: ''},                    60,     'text', {textAlignment: "center"},{visible:false});    

    
    gridDetail.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 230       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : true     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });

    gridDetail.onCurrentRowChanged =  function (grid, oldRow, newRow) {
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
        
        // 동적 스타일 적용
        var columnDynamicStyles = function(grid, index, value) {
            var styles = {};
            var values = grid.getValues(index.itemIndex);
            var gubn   = values.CRUD;
            var processType = values.PROCESS_TYPE;
            var status = values.STATUS;
            var temp = {};
            var accountGubn = "";
            if (rowIndex == "") {
            	accountGubn = "Y"; 
            } else {
            	temp = gridHeader.getValues(gridHeader.getCurrent().itemIndex); 
            	accountGubn = temp.ACCOUNT_GUBN;
            }
            if (gubn == 'I') {
                styles = enableColStyle;
            } else {
            	if (processType == "2") {
            		styles = disibleColStyle;
            	} else {
            		if (accountGubn == "Y") {
            			styles = enableColStyle;
            		} else {
            			styles = disibleColStyle;
            		}
            	}
            }

            return styles;
        };
        
        // 기본 스타일 적용
        var columnDefaultStyles = function(grid, index, value) {
        	return disibleColStyle;
        };        
        
        gridHeader.setColumnProperty("PRESUME_AMT"    , "dynamicStyles", columnDynamicStyles);
        
        gridDetail.setColumnProperty("DETAIL_DESC", "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("UNIT_PRICE" , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("UNIT_QTY"   , "dynamicStyles", columnDynamicStyles);
        
        gridDetail.setColumnProperty("WK_M01"    , "dynamicStyles", columnDynamicStyles);        
        gridDetail.setColumnProperty("WK_M02"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M03"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M04"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M05"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M06"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M07"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M08"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M09"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M10"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M11"    , "dynamicStyles", columnDynamicStyles);
        gridDetail.setColumnProperty("WK_M12"    , "dynamicStyles", columnDynamicStyles);
        
        gridDetail.setColumnProperty("BELONG_CCTR", "dynamicStyles", columnDefaultStyles);
        gridDetail.setColumnProperty("A_SUM"     , "dynamicStyles", columnDefaultStyles);
        gridDetail.setColumnProperty("B_SUM"     , "dynamicStyles", columnDefaultStyles);
        gridDetail.setColumnProperty("C_SUM"     , "dynamicStyles", columnDefaultStyles);
        
    };

    //그리드 변경 시 체크박스 true
    gridDetail.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	modifyFlag = "Y";
    	var values = grid.getValues(itemIndex);
    	gridDetail.setValue(itemIndex, "A_SUM", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06));
    	gridDetail.setValue(itemIndex, "B_SUM", toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
    	gridDetail.setValue(itemIndex, "C_SUM", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06) + toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
    	
    	gridDetail.checkItem(dataRow, true);
    };
    

    //paste 시 합계 자동 계산
    gridDetail.onRowsPasted = function(grid, items){
    	modifyFlag = "Y";
    	for(var i = 0; i < items.length; i++){
    		var values = grid.getValues(items[i]);
        	gridDetail.setValue(items[i], "A_SUM", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06));
        	gridDetail.setValue(items[i], "B_SUM", toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
        	gridDetail.setValue(items[i], "C_SUM", toNumber(values.WK_M01) + toNumber(values.WK_M02) + toNumber(values.WK_M03) + toNumber(values.WK_M04) + toNumber(values.WK_M05) + toNumber(values.WK_M06) + toNumber(values.WK_M07) + toNumber(values.WK_M08) + toNumber(values.WK_M09) + toNumber(values.WK_M10) + toNumber(values.WK_M11) + toNumber(values.WK_M12));
        	gridDetail.checkItem(items[i], true);
    	}
    };    

    gridDetail.onDataCellClicked = function (grid, colIndex) {
    	var gridView = grid.getDataProvider();
        
        if (colIndex.fieldName == "CODEMAPPING2") {
        	fnSearchProj();
        }
        
    };

    fnGridSortFalse(gridDetail);
    gridDetail.setDisplayOptions({columnMovable:false})

}

/**
 * 조회
 */
function fnSearch() {
// 	if($("#TB_CRTN_YY").val() != nextYear){
// 		$("#div_btnH").css("visibility", "hidden");
// 		$("#div_btnD").css("visibility", "hidden");
// 	} else {
// 		$("#div_btnH").css("visibility", "visible");
// 		$("#div_btnD").css("visibility", "visible");
// 	}

	$("#TB_ACCOUNT_NO").val("");
	$("#TB_ACCOUNT_DESC").val("");

	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectBasicMgtHeader');
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	if(isNotEmpty(data.fields) == true){
		bBudget = toNumber(data.fields.B_BUDGET);		
	}
	
	var gridView = gridHeader.getDataProvider();
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	} else {
		wCode = data.rows[0].W_CODE;
	}
	
	if(isNotEmpty(rowIndex) == true){
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
		gridHeader.setTopItem(rowIndex);
		
		$("#TB_ACCOUNT_NO").val(accountNo);
		$("#TB_ACCOUNT_DESC").val(accountDesc);
		
		if(gridHeader.getRowCount() > 0){
			$("#TB_REMARK").val(gridHeader.getValue(toNumber(rowIndex),"REMARK"));
		}

	    // 상태바 비활성화
	    gridHeader.closeProgress();
	} else {
		gridDetail.clearRows();
		$("#TB_REMARK").val("");
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridHeader.clearRows();
		// 그리고 데이터 setting
	    gridHeader.setPageRows(data);
	    // 상태바 비활성화
	    gridHeader.closeProgress();
	    $("#div_btnD").show();
	}
	
	rowIndex = "";
	

}

/**
 * 조회 후 처리
 */
function fnSearchDetailSuccess(data) {
	if(isEmpty(data.rows)){
		gridDetail.clearRows();
	}
	
	if (data.fields.PROCESS_TYPE == "2") {
		$("#div_btnD").hide();
		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);   		
	} else {
		if (data.fields.STATUS == "1") {
			$("#div_btnD").show();
			gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
			gridDetail.setColumnProperty("BELONG_CCTR", "visible", false); 				
		} else {
			$("#div_btnD").hide();
			gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
			gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);  			
		}
	}	
	
	
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridDetail.clearRows();
	// 그리고 데이터 setting
    gridDetail.setPageRows(data);
    // 상태바 비활성화
    gridDetail.closeProgress();
    
}

/**
 * 계정 조회
 */
function fnSearchAccount() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ACCOUNT_GUBN" : "B"});
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    rowIndex = "";
	
 	fnPostPopup('/com/cmn/accountSearch', params, target, width, height, scrollbar, resizable);
}

/**
 * 계정 콜백
 */
function fnCallbackAccountSearchPop(rows) {
	$("#TB_ACCOUNT_NO").val(rows.ACCOUNT_NO);
	$("#TB_ACCOUNT_DESC").val(rows.ACCOUNT_DESC);
	wCode = rows.W_CODE;
	
	//위탁연구비 계정일때만 보이게 처리
	if($("#TB_ACCOUNT_NO").val() == wCode){
		gridDetail.setColumnProperty("PROJECT", "visible", true);
		gridDetail.setColumnProperty("CODEMAPPING2", "visible", true);
	} else {
		gridDetail.setColumnProperty("PROJECT", "visible", false);
		gridDetail.setColumnProperty("CODEMAPPING2", "visible", false);
	}
	
	searchCall(gridDetail, '/com/bdg/selectBbugdet', 'fnSearchBbugdet');
	
}

/**
 * 조회 후 처리
 */
function fnSearchBbugdetSuccess(data) {
	if(isEmpty(data.rows) == true){
		bBudget = 0;
	} else {
		bBudget = toNumber(data.rows[0].B_BUDGET);
	}
	
	if (isNotEmpty(data.fields.STATUS)) {
		if (data.fields.STATUS == "1") {
    		$("#div_btnD").show();
    		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
    		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);   				
		} else {
			$("#div_btnD").hide();
    		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
    		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false); 				
		}
	} else {
		$("#div_btnD").show();
		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);			
	}	
	
	fnSearchDetail();
}

/**
 * 프로젝트 콜백
 */
function fnCallbackProjSearchPop(rows) {
	var values = {
	         "PROJECT_CD"  : rows.ORDER_NO 
	        ,"PROJECT"     : rows.ORDER_NO + '-' + rows.ORDER_DESC
	     };

	gridDetail.setValues(gridDetail.getCurrent().itemIndex, values);	
	
}


//저장
var fnSaveD = function(confirmYn){
	gridDetail.checkAll(true,false);
	gridDetail.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveAllData(gridDetail)});
	
	if($("#TB_ACCOUNT_NO").val() == null || $("#TB_ACCOUNT_NO").val() == ""){
		alert("계정코드는 필수입니다.");
		return false;
	}
	
	// 필수 체크 대상(그리드)
	var requiredVal   = ["DETAIL_DESC", "CCTR_CD"];
	
	var sum = 0;
	var grid = gridDetail.getDataProvider();
	
	for(var i = 0; i < gridDetail.getRowCount(); i++){
		sum +=  nvl(grid.getValue(i, "WK_M01"), 0)
		       +nvl(grid.getValue(i, "WK_M02"), 0)
		       +nvl(grid.getValue(i, "WK_M03"), 0)
		       +nvl(grid.getValue(i, "WK_M04"), 0)
		       +nvl(grid.getValue(i, "WK_M05"), 0)
		       +nvl(grid.getValue(i, "WK_M06"), 0)
		       +nvl(grid.getValue(i, "WK_M07"), 0)
		       +nvl(grid.getValue(i, "WK_M08"), 0)
		       +nvl(grid.getValue(i, "WK_M09"), 0)
		       +nvl(grid.getValue(i, "WK_M10"), 0)
		       +nvl(grid.getValue(i, "WK_M11"), 0)
		       +nvl(grid.getValue(i, "WK_M12"), 0)
		       ;
	}

	if((bBudget / sum) > 10 || (bBudget / sum) < -10){
		if(isEmpty($("#TB_REMARK").val()) == true){
			alert("산정증감이"+ Math.floor(bBudget / sum) + "%입니다.\n증감요인은 필수로 입력해야합니다.")
			return false;
		}
	}
	
	// 필수 체크 후 저장 진행
	if(fnSaveCheck(gridDetail, requiredVal) == true){
		if(confirmYn == "Y"){
			saveCall(gridHeader, '/com/bdg/saveBasicMgt', 'fnSaveD', params);
		} else {
			if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
		    	 saveCall(gridHeader, '/com/bdg/saveBasicMgt', 'fnSaveD', params);
		     }
		}
	}
	
}

/**
 * 저장 성공
 */
function fnSaveDSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    gridDetail.closeProgress();
    fnSearch();
    modifyFlag = 'N';
}

/**
 * 저장 실패
 */
function fnSaveDFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridDetail.closeProgress();
}

/**
 * 예산상세
 */
function fnSearchDetail() {
	
	if($("#TB_PROCESS_TYPE").val() == null || $("#TB_PROCESS_TYPE").val() == ""){
		$("#TB_PROCESS_TYPE").val('1');
	}	
	searchCall(gridDetail, '/com/bdg/selectBasicMgtDetail', 'fnSearchDetail');
}

//행추가
function fnRowAdd() {
	
	gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);
	if($("#TB_ACCOUNT_NO").val() == null || $("#TB_ACCOUNT_NO").val() == ""){
		alert("계정코드는 필수입니다.");
		return false;
	}
	
	var detailValues = {
			             "CRUD":"I" 
			            ,"CCTR_CD" : $("#SB_CCTR_CD").val()
			            ,"BELONG_CCTR_CD" : $("#SB_CCTR_CD").val()
			            ,"SEQ_NO" :  gridDetail.getRowCount() + 1
			            ,"CODEMAPPING2":"1"
			           };
	fnAddRow(gridDetail, detailValues);
}


//하단 삭제
function fnDelD() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridDetail)});
	
	if(fnDeleteCheck(gridDetail) == true){
		deleteCall(gridDetail, '/com/bdg/delBasicMgt', 'fnDelD', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDelDSuccess(result) {
	alert("삭제 하였습니다.");
	fnSearchDetail();
	fnSearch();
	
}

/**
 * 삭제 실패
 */
function fnDelDFail(result) {
	alert(result.errMsg);
}	

/**
 * 삭제 성공
 */
function fnSearchDelSuccess(data) {
	if(isEmpty(data.rows)){
		gridHeader.clearRows();
	}
	
	// 그리드 초기화
    gridHeader.clearRows();
	// 그리고 데이터 setting
    gridHeader.setPageRows(data);
    // 상태바 비활성화
    gridHeader.closeProgress();	

}	

//행삭제
function fnRowDel() {
	fnAddRowDelete(gridDetail);
}


// 승인요청
var fnAppr = function(){
	gridHeader.commit();
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("승인요청 할 데이터가 존재하지 않습니다.");
		return false;
	}
	
	for(var i = 0; i < gridHeader.getRowCount(); i++){
		
		if (isEmpty(gridHeader.getValue(i, "PRESUME_AMT")) && gridHeader.getValue(i, "PROCESS_TYPE") == "1" && gridHeader.getValue(i, "ACCOUNT_GUBN") == "Y") {
			if (isEmpty(gridHeader.getValue(i, "REMARK"))) {
				alert("예상추정이 없는 경우 증감요인은 필수입력입니다.");
				return false;
			}
		}
	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"EPS_FORM_ID"   : "WF_LINK_001"}); // 양식키
	$.extend(params, {"SABUN"         : '${LOGIN_INFO.USER_ID}'}); // 기안자사번
	$.extend(params, {"ORG_CD"        : '${LOGIN_INFO.DEPT_CD}'}); // 기안자부서
	$.extend(params, {"geMangerYn"    : 'N'}); //본부장 표시여부
 	if ('${LOGIN_INFO.DEPT_CD}' == nextDeptCodes[0]) {
 		$.extend(params, {"reqDeptcd" : ""}); //처리부서코드
 	} else {
 		$.extend(params, {"reqDeptcd" : nextDeptCodes[0]}); //처리부서코드	
 	}
	//$.extend(params, {"BGT_URL"     : "http://192.168.110.76/com/bdg/bdgBasicMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG111" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YY=" + $('#TB_CRTN_YY').val() + "&TB_DEPT_NM=" + $('#TB_DEPT_NM').val() + "&TB_DEPT_CD=" + $('#TB_DEPT_CD').val()}); // 팝업 url
	//$.extend(params, {"BGT_BUS_URL" : "http://192.168.110.76/com/bdg/bdgBasicMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG111"}); // 처리로직  url
	
	if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
		$.extend(params, {"BGT_URL"       : "http://172.16.17.64/com/bdg/bdgBasicMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG111" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YY=" + $('#TB_CRTN_YY').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}' + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "http://172.16.17.64/com/bdg/bdgBasicMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG111"}); // 처리로직  url
	} else {
		$.extend(params, {"BGT_URL"       : "https://wp.ildong.com/com/bdg/bdgBasicMgtPop.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG111" + "&SB_COMP_CD=" + $('#SB_COMP_CD').val() + "&TB_CRTN_YY=" + $('#TB_CRTN_YY').val() + "&SB_CCTR_CD=" + $('#SB_CCTR_CD').val() + "&ORG_CD=" + '${LOGIN_INFO.DEPT_CD}' + "&USER_ID=" + '${LOGIN_INFO.USER_ID}'}); // 팝업 url
		$.extend(params, {"BGT_BUS_URL"   : "https://wp.ildong.com/com/bdg/bdgBasicMgtEps.do?G_TOP_MENU_CD=BDG100&G_MENU_CD=BDG111"}); // 처리로직  url
	}
	
	$.extend(params, {"BGT_NAME"      : "전사시스템"}); // 전사시스템 이름
	$.extend(params, {"STATUS"        : "REQUEST"}); // 결재이력테이블에 삽입할 상태코드/ 이력 저장 후 반드시 코드를 2번으로 변경하여 해당테이블에  UPDATE!!!!
	//$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
    if(confirm("승인요청 하시겠습니까?")){
    	saveCall(gridHeader, '/com/bdg/apprBasicMgt', 'fnAppr', params);
    }
	
}

function fnApprSuccess(data) {
	//alert("승인요청 되었습니다.");
	gridDetail.clearRows();
	
	if (!isNullValue(data.fields.result.EPS_DOC_NO)) {
		
	 	var params = {};
	 	$.extend(params, {"key" : data.fields.result.EPS_DOC_NO}); //연동키
	 	$.extend(params, {"legacyFormID" : "WF_LINK_001"}); //양식key
	 	$.extend(params, {"empno" : '${LOGIN_INFO.USER_ID}'}); // 기안자
	 	$.extend(params, {"deptcd" : '${LOGIN_INFO.DEPT_CD}'}); //기안자 부서코드
		$.extend(params, {"geMangerYn"    : 'N'}); //본부장 표시여부
	 	if ('${LOGIN_INFO.DEPT_CD}' == nextDeptCodes[0]) {
	 		$.extend(params, {"reqDeptcd" : ""}); //처리부서코드
	 	} else {
	 		$.extend(params, {"reqDeptcd" : nextDeptCodes[0]}); //처리부서코드	
	 	}
	 	$.extend(params, {"systemUrl"   : data.fields.result.BGT_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //popup_url
	 	$.extend(params, {"businessUrl" : data.fields.result.BGT_BUS_URL + '&EPS_DOC_NO=' + data.fields.result.EPS_DOC_NO}); //business_url
	 	$.extend(params, {"systemName" : '전사시스템'}); //시스템이름
	 	//$.extend(params, {"attachFiles" : ''}); //첨부파일
	 	$.extend(params, {"subject" : ''}); //제목
	 	$.extend(params, {"status" : '2'}); //상태코드
	 	
	 	var htmlTag = "<!DOCTYPE html>";
	 	htmlTag += "<html lang='ko'>";
	 	htmlTag += "<head>";
	 	htmlTag += "<meta charset='UTF-8'>";
	 	htmlTag += "<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>";
	 	htmlTag += "<style>";
	 	htmlTag += ".tit-area{overflow:hidden;position:relative;padding:18px 0 13px;}";
	 	htmlTag += ".tbl-view{width:100%;table-layout:fixed;border-top:2px solid #2d5ab5;border-right:1px solid #e0e0e0;}";
	 	htmlTag += ".tbl-view tbody th{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;background-color:#f1f2f6;text-align:left;}";
	 	htmlTag += ".tbl-view tbody td{height:25px;padding:5px 8px;border-left:1px solid #e0e0e0;border-bottom:1px solid #e0e0e0;color:#666;text-align:left;}";
	 	htmlTag += "</style>";
	 	htmlTag += "</head>";
	 	
	 	htmlTag += "<body>";
	 	htmlTag += "<div class='tit-area' style='padding:15px;'>";
	 	htmlTag += "<div>";
	 	htmlTag += "<h3>기본예산신청</h3>";
	 	htmlTag += "</div>";
	    htmlTag += "<div class='tbl-search-wrap'>";
	    htmlTag += "<div class='tbl-search-area'>";
	    htmlTag += "<table class='tbl-search'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:70px'>";
	    htmlTag += "<col style='width:100px'>";	    
	    htmlTag += "<col>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th><span>회사 : </span></th>";
	    htmlTag += "<td>" + $("#SB_COMP_CD option:selected").text() + "</td>";
	    htmlTag += "<th><span>년도 : </span></th>";
	    htmlTag += "<td>" + $('#TB_CRTN_YY').val() + "</td>";
	    htmlTag += "<th><span>코스트센터 : </span></th>";
	    htmlTag += "<td>" + $("#SB_CCTR_CD option:selected").text() + "</td>";
	    htmlTag += "<th><span>합계 : </span></th>";
	    htmlTag += "<td>" + nvl(addComma(data.fields.sumData.SUM_A_BUDGET), '0') + "</td>";	    
	    htmlTag += "<td></td>";
	    htmlTag += "</tr>";
	    htmlTag += "</tbody>";
	    htmlTag += "</table>";
	    htmlTag += "</div>";
	    htmlTag += "</div>";
	    htmlTag += "<div class='pop-cont'>";
	    htmlTag += "<div class='pop-cont'>";
	    htmlTag += "<table class='tbl-view'>";
	    htmlTag += "<colgroup>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:150px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "<col style='width:100px'>";
	    htmlTag += "</colgroup>";
	    htmlTag += "<tbody>";
	    htmlTag += "<tr>";
	    htmlTag += "<th style='text-align:center'>계정코드</th>";
	    htmlTag += "<th style='text-align:center'>계정명</th>";
	    htmlTag += "<th style='text-align:center'>" + $('#TB_CRTN_YY').val() + "년예산</th>";
	    htmlTag += "<th style='text-align:center'>산정추정</th>";
	    htmlTag += "<th style='text-align:center'>예산추정</th>";
	    htmlTag += "<th style='text-align:center'>집행율</th>";
	    htmlTag += "<th style='text-align:center'>예산증감율</th>";
	    htmlTag += "<th style='text-align:center'>산정증감율</th>";
	    htmlTag += "<th style='text-align:center'>예상증감율</th>";
	    htmlTag += "</tr>";
	    
	    for (var i=0 ; i < gridHeader.getRowCount(); i++) {
	    	htmlTag += "<tr>";
	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_NO") + "</td>";
	    	htmlTag += "<td style='text-align:center'>" + gridHeader.getRowValue(i, "ACCOUNT_DESC") + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "A_BUDGET")), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "B_BUDGET")), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "PRESUME_AMT")), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "D_BUDGET")), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "A_RATE")), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "B_RATE")), '0') + "</td>";
	    	htmlTag += "<td style='text-align:right'>"  + nvl(addComma(gridHeader.getRowValue(i, "C_RATE")), '0') + "</td>";
	    	htmlTag += "</tr>";
	    }
	    
	    htmlTag += "</tbody>";
	    htmlTag += "</table>";
	    htmlTag += "</div>";
	    htmlTag += "</body>";
	    htmlTag += "</html>";
	    
	    $.extend(params, {"HTMLBody" : htmlTag}); //본문 데이터
	 	
	 	// 새로운 tab으로 전자결재 시스템 활성화
		//fnPostGoto("http://epsdev.ildong.com/approval/legacy/goFormLink", params, "GW");
		var target    = "goFormLink";
		var width     = "1200";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	 	//fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		if('${LOGIN_INFO.SRV_TYPE}' == "LOCAL" || '${LOGIN_INFO.SRV_TYPE}' == "DEV") {
			fnPostPopup('http://epsdev.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		} else {
			fnPostPopup('https://eps.ildong.com/approval/legacy/goFormLink', params, "GW", width, height, scrollbar, resizable);
		}	    
	}
	
	fnSearch();
}

function fnApprFail(result) {
	alert(result.errMsg);
}

function fnSaveSuccess(data) {
	alert("저장 되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnSaveFail(result) {
	alert(result.errMsg);
}

/**
 * 프로젝트 조회
 */
function fnSearchProj() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnProjSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/projList', params, target, width, height, scrollbar, resizable);
}

/**
 * 예상추정 저장
 */
function fnSaveH() {
	gridHeader.commit();
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridHeader)});
	
		// 필수 체크 대상(그리드)
		var requiredVal   = [];
		
		// 필수 체크 후 저장 진행
		if(fnSaveCheck(gridHeader, requiredVal) == true){
			for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
				if(   params.ITEM_LIST.UPDATED[i].STATUS == '1'
				   || params.ITEM_LIST.UPDATED[i].STATUS == '4'){
					// 작성중/반려인 경우 저장 가능
				} else {
					alert("작성중/반려 상태인 경우 저장가능합니다.");
					return false;					
				}
			}
			
			if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
		    	 saveCall(gridHeader, '/com/bdg/saveHeader', null, params);
		     }
		}

		modifyFlag = 'N';

}


/**
 * 헤더 삭제
 */
function fnDeleteH() {
	rowIndex = "";
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridHeader)});
	
	if(fnDeleteCheck(gridHeader) == true){
		for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
			
			if(   params.ITEM_LIST.DELETED[i].STATUS == '1'
			   || params.ITEM_LIST.UPDATED[i].STATUS == '4'){
					// 작성중/반려인 경우 저장 가능
			} else {
				alert("작성중/반려 상태인 경우 삭제가능합니다.");
				return false;					
			}
			
			if(params.ITEM_LIST.DELETED[i].PROCESS_TYPE == '2'){
				alert("경영예산인 경우 삭제가 불가능합니다. 확인후 작업하세요.");
				return false;
			}
			
			if(params.ITEM_LIST.DELETED[i].ACCOUNT_GUBN == 'N'){
				alert("삭제 불가한 계정입니다. 확인후 작업하세요.");
				return false;
			}	
		}

		deleteCall(gridHeader, '/com/bdg/delBasicH', 'fnDelD', params);
	}

}

/**
 * 회사 코드 변경 이벤트
 */
function fnCompCdChange() {
    var costList = stringToArray("${COSTLIST}", $("#SB_COMP_CD").val());
    fnMakeComboOption('SB_CCTR_CD', costList, 'CODE', 'CODE_NM');
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
                <col style="width:120px">
                <col style="width:430px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCompCdChange();">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
						<input type="number" id="TB_CRTN_YY"  style="text-align: right; width: 50px; text-align: center" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
	                    <select id="SB_CCTR_CD" name="SB_CCTR_CD" onchange="fnSearch();">
	                    </select>
                    </td>
                    <th><span>승인상태</span></th>
                    <td>
	                    <select id="SB_STATUS_CD" name="SB_STATUS_CD" onchange="fnSearch();">
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
    <div class="btnArea t_right" id="div_btnH">
<!--     	<button type="button" class="btn" id="btnCreateHtml">데이터 확인</button> -->
        <button type="button" class="btn" id="btnAppr">승인요청</button>
        <button type="button" class="btn" id="btnDeleteH">삭제</button>
        <button type="button" class="btn" id="btnSaveH">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridHeader"></div> 
</div>
<table class="tbl-view">
	<colgroup>
		<col style="width:15%">
		<col>
	</colgroup>
	<tbody>
		<tr>
			<th><span>증감요인<br> &lt;산정증감  ±10%이상시&gt;</span></th>
			<td>
				<textarea rows="2" id="TB_REMARK"></textarea>
			</td>
		</tr>
	</tbody>
</table>
<div class="sub-tit">
    <div class="tbl-search-area" style="float:left; width:600px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:480px">
            </colgroup>
	        <tr>
				<th><span>계정</span></th>
	        	<td>
				    <input type="text" id="TB_ACCOUNT_NO"	style="width: 90px;" 	readonly="readonly"/>
				    <input type="text" id="TB_ACCOUNT_DESC"	style="width: 150px;"	readonly="readonly"/>
				    <input type="hidden" id="TB_PRESUME_AMT"/>
				    <input type="hidden" id="TB_PROCESS_TYPE"/>
				    <a href="javascript:fnSearchAccount();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>
    <div class="btnArea t_right" id="div_btnD">
        <button type="button" class="btn" id="btnRowDel">행삭제</button>
        <button type="button" class="btn" id="btnRowAdd">행추가</button>
        <button type="button" class="btn" id="btnDelD">삭제</button>
        <button type="button" class="btn" id="btnSaveD">저장</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridDetail"></div> 
</div>
