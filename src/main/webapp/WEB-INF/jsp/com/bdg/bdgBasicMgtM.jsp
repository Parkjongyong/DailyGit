<%--
	File Name : bdgBasicMgt.jsp
	Description: 예산 > 예산관리 > 기본예산관리
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.08.14  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.08.14
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

var processType  = "";
var accountNo    = "";
var accountDesc  = "";
var accountGubn  = "";
var remark       = "";
var rowIndex     = "";
var paramGubn    = "";
var nextYear     = getDiffDay("y",1).substring(0,4);
var bBudget      = 0;
var modifyFlag   = "N";
var wCode        = "";
var status       = "";

$(document).ready(function() {
	
    $("#chasu_dialog").dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:170, //팝업 가로
        width: 240, //팝업 높이
        close: function(event,ui) {
            $("#chasu_dialog").dialog( "close" );
        }
    });
	
    // 개별코드 생성(그리드용)
	var compList  = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD', compList,     'CODE', 'CODE_NM', null, "","전체");

	var apprStatusList  = stringToArray("${CODELIST_YS001}");
	fnMakeComboOption('SB_STATUS_CD', apprStatusList,     'CODE', 'CODE_NM', null, "","전체");

	apprCodes  = getComboSet('${CODELIST_YS001}', 'CODE');
	apprLabels = getComboSet('${CODELIST_YS001}', 'CODE_NM');
	
	processTypeCodes  = getComboSet('${CODELIST_YS009}', 'CODE');
	processTypeLabels = getComboSet('${CODELIST_YS009}', 'CODE_NM')	
	
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
	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');

}

function setInitGridHeader() {
    var gridId = "gridHeader";
    gridHeader = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'STATUS',               {text: '승인상태'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:apprCodes,labels:apprLabels, editable:false},'dropDown');
    addField(cm,    'PROCESS_TYPE',         {text: '구분'},      60,            'text',              {textAlignment: "center"},{lookupDisplay: true,values:processTypeCodes,labels:processTypeLabels, editable:false},'dropDown');
    addField(cm,    'CCTR_CD',               {text:'코스트센터'},       80,            'text',              {textAlignment:"center"});
    addField(cm,    'CCTR_NM',               {text:'코스트센터명'},        100,            'text',              {textAlignment:"near"});
    addField(cm,    'ACCOUNT_NO',           {text:'계정코드'},       80,            'textLink',              {textAlignment:"center"});
    addField(cm,    'ACCOUNT_DESC',         {text:'계정명'},        140,            'text',              {textAlignment:"near"});
    // 당기수정기본예산 : 2020년 기준 2019년 당기수정예산
    addField(cm,    'A_BUDGET',             {text:'당기기본예산'},  100,            'integer',           {textAlignment:"far"});
    // 산정추정 : 2019년 1월 ~ 9월 실적 + 2019년 10월 ~ 12월 수정기본예산 합
    addField(cm,    'B_BUDGET',             {text:'산정추정'},      100,            'integer',           {textAlignment:"far"});
    // 예상추정 : 산정추정값과 동일하고 수정 가능
    addField(cm,    'PRESUME_AMT',          {text:'예상추정'},      100,            'integer',           {textAlignment:"far"});
    // 집행률 : 예상추정 / 당기수정기본예산
    addField(cm,    'D_BUDGET',             {text:'집행율'},        100,            'integer',           {textAlignment:"far"});
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
    addField(cm,    'A_RATE',               {text:'예산증감율'},    100,            'integer',           {textAlignment:"far"});
    // 산정증감율 :  산정추정 / 1월 ~12월 합계
    addField(cm,    'B_RATE',               {text:'산정증감율'},    100,            'integer',           {textAlignment:"far"});
    // 예산증감율 :  예상추정 / 1월 ~12월 합계
    addField(cm,    'C_RATE',               {text:'예상증감율'},    100,            'integer',           {textAlignment:"far"});
    addField(cm,    'REMARK',               {text: '증감요인'},     60,     'text', {textAlignment: "center"},{visible:false});
    addField(cm,    'CRUD',                 {text: 'CRUD'},        0,     'text', {textAlignment: 'center'},  {visible:false});

    addField(cm,    'COMP_CD',                {text: 'COMP_CD'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'CRTN_YY',                {text: 'CRTN_YY'},        0,     'text', {textAlignment: 'center'},  {visible:false});
//     addField(cm,    'PROCESS_TYPE',           {text: 'PROCESS_TYPE'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SEND_CHASU',           {text: '차수'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'SEND_YMD',           {text: '전송일자'},        0,     'text', {textAlignment: 'center'},  {visible:false});
    addField(cm,    'W_CODE',             {text: '위탁연구비코드'},        0,     'text', {textAlignment: 'center'},  {visible:false});
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
        	$("#SB_COMP_CD").val(gridView.getValue(colIndex.itemIndex,"COMP_CD")); 
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
        	$("#TB_SEND_CHASU").val(gridView.getValue(colIndex.itemIndex,"SEND_CHASU"));
        	$("#TB_SEND_YMD").val(gridView.getValue(colIndex.itemIndex,"SEND_YMD"));
        	
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
//         			if (status == "1") {
//                 		$("#div_btnD").show();
//                 		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
//                 		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);           				

//         			} else {
//             			$("#div_btnD").hide();
//                 		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
//                 		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);      				
//         			}
					// 관리자는 상태와 상관없이 수정 가능
               		$("#div_btnD").show();
               		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
               		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);  					
					
        		}
        	}
        	
//         	if($("#TB_CRTN_YY").val() != nextYear){
//         		$("#div_btnH").css("visibility", "hidden");
//         		$("#div_btnD").css("visibility", "hidden");
//         	} else {
//         		$("#div_btnH").css("visibility", "visible");
//         		$("#div_btnD").css("visibility", "visible");
//         	}
        	
        	$("#TB_CCTR_NM").val(gridView.getValue(colIndex.itemIndex,"CCTR_NM"));
        	$("#SB_CCTR_CD").val(gridView.getValue(colIndex.itemIndex,"CCTR_CD"));

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
//             			if (status == "1") {
//             				styles = enableColStyle;	
//             			} else {
//             				styles = disibleColStyle;
//             			}
						// 관리자는 상태와 상관없이 수정
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
        
        setDefaultStyle(gridHeader, "dynamicStyles",columnDefaultStyles);
        gridHeader.setColumnProperty("PRESUME_AMT"    , "dynamicStyles", columnDynamicStyles);
        
    };

    //그리드 변경 시 체크박스 true
    gridHeader.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	gridHeader.checkItem(dataRow, true);
    };
    
    gridHeader.setFixedOptions({
    	  colCount: 6
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
    addField(cm,    'CODEMAPPING2',  	    {text: ' '},    15,     'popupLink', null,{visible:false});
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

	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"MODIFY_GUBN" : "Y"});

	$("#TB_ACCOUNT_NO").val("");
	$("#TB_ACCOUNT_DESC").val("");
	
	if(isEmpty($("#TB_CCTR_NM").val()) == true){
		$("#SB_CCTR_CD").val("");
	}
	
	// 조회 요청
	searchCall(gridHeader, '/com/bdg/selectBasicMgtHeader', null, params);
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
		$("#TB_SEND_CHASU").val(data.rows[0].SEND_CHASU);
		$("#TB_SEND_YMD").val(data.rows[0].SEND_YMD);
		wCode =data.rows[0].W_CODE;
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
// 		if (data.fields.STATUS == "1") {
// 			$("#div_btnD").show();
// 			gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
// 			gridDetail.setColumnProperty("BELONG_CCTR", "visible", false); 				
// 		} else {
// 			$("#div_btnD").hide();
// 			gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
// 			gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);  			
// 		}
		$("#div_btnD").show();
		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false); 	
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
	if(isEmpty($("#SB_CCTR_CD").val()) == true){
		alert("코스트 선택 후 가능합니다.");
		return false;
	}
	rowIndex = "";
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ACCOUNT_GUBN" : "B"});
	var target    = "cmnAccountSearchPop";
	var width     = "600";
	var height    = "670";
    var scrollbar = "yes";
    var resizable = "yes";
	
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
	
// 	if (isNotEmpty(data.fields.STATUS)) {
// 		if (data.fields.STATUS == "1") {
//     		$("#div_btnD").show();
//     		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
//     		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);   				
// 		} else {
// 			$("#div_btnD").hide();
//     		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
//     		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false); 				
// 		}
	
// 	} else {
// 		$("#div_btnD").show();
// 		gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
// 		gridDetail.setColumnProperty("BELONG_CCTR", "visible", false);			
// 	}
	
	// 관리자는 상태와 상관없이 수정
	$("#div_btnD").show();
	gridDetail.setColumnProperty("DETAIL_DESC", "visible", true);
	gridDetail.setColumnProperty("BELONG_CCTR", "visible", false); 		
	
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

	if(bBudget / sum > 10 || bBudget / sum < -10){
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

	if($("#SB_COMP_CD").val() == null || $("#SB_COMP_CD").val() == ""){
		alert("회사는 필수입니다.");
		return false;
	}
	
	if($("#SB_CCTR_CD").val() == null || $("#SB_CCTR_CD").val() == ""){
		alert("코스트센터는 필수입니다.");
		return false;
	}
	
	if($("#TB_ACCOUNT_NO").val() == null || $("#TB_ACCOUNT_NO").val() == ""){
		alert("계정코드는 필수입니다.");
		return false;
	}
	
	var values = {  "CRUD":"I" 
			      , "CCTR_CD" :  $("#SB_CCTR_CD").val()
			      , "BELONG_CCTR_CD" : $("#SB_CCTR_CD").val()
			      , "BELONG_CCTR" : $("#TB_CCTR_NM").val()
			      , "SEQ_NO" :  gridDetail.getRowCount() + 1
			      , "CODEMAPPING2":"1"
			     };
	fnAddRow(gridDetail, values);
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
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
     if(confirm("승인요청 하시겠습니까?")){
    	 saveCall(gridHeader, '/com/bdg/apprBasicMgt', 'fnAppr', params);
     }
	
}

function fnApprSuccess(data) {
	alert("승인요청 되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnApprFail(result) {
	alert(result.errMsg);
}

function fnReturnSuccess(data) {
	alert("반려 되었습니다.");
	gridDetail.clearRows();
	fnSearch();

}

function fnReturnFail(result) {
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

function fnConfirmSuccess(data) {
	alert("전송 되었습니다.");
	$("#chasu_dialog").dialog( "close" );

}

function fnConfirmFail(result) {
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
	
	if(isEmpty(params.ITEM_LIST) == true){
		if(isEmpty(accountNo)){
			alert("헤더정보의 계정코드를 선택해주세요.");
			return false;
		}
		
		if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
	    	 saveCall(gridHeader, '/com/bdg/saveHeader', null, params);
	     }
	} else {
		// 필수 체크 대상(그리드)
		var requiredVal   = [];
		
		// 필수 체크 후 저장 진행
		if(fnSaveCheck(gridHeader, requiredVal) == true){
			for(var i = 0; i < params.ITEM_LIST.UPDATED.length; i++){
				if(params.ITEM_LIST.UPDATED[i].PROCESS_TYPE == '2'){
					alert("경영예산인 경우 저장이 불가능합니다. 확인후 작업하세요.");
					return false;
				}
				
				if(params.ITEM_LIST.UPDATED[i].ACCOUNT_GUBN == 'N'){
					alert("저장 불가한 계정입니다. 확인후 작업하세요.");
					return false;
				}				
			}			
			if(confirm("저장 하시겠습니까?\n※금액은 원단위 입니다.\n반드시 확인 후 작업하세요.")){
		    	 saveCall(gridHeader, '/com/bdg/saveHeader', null, params);
		     }
		}
	}
	
	modifyFlag = 'N';

}

// SAP 전송
function fnSap() {
// 	if(fnCheckYear() == false){
// 		return false;
// 	}
	
	$("#chasu_dialog").dialog("open");
}

// SAP 전송 확인
function fnConfirm() {
    var params = fnGetParams();
    
    if(confirm("전송 하시겠습니까?")){
   	 saveCall(gridHeader, '/com/bdg/saveBasicMaster', 'fnConfirm', params);
    }
}

// 반려
function fnReturn() {
// 	if(fnCheckYear() == false){
// 		return false;
// 	}
	
	gridHeader.commit();
	
	if(gridHeader.getAllJsonRowsExcludeDeleteRow().length == 0){
		alert("반려 할 데이터가 존재하지 않습니다. 조회 후 진행하십시오.");
		return false;
	}	
	
	if(isEmpty($("#SB_CCTR_CD").val()) == true){
		alert("코스트센터 선택은 필수 입니다.");
		return false;
	}
	
// 	// Detail 필수 체크
// 	for(var i = 0; i < gridHeader.getAllRows().length; i++){
		
// 		var temp = fnGetGridRowParams(gridHeader, i);
		
// 		if (temp.STATUS == '5') {
// 			continue;
// 		} else {
// 			alert("[승인완료] 상태에서만  반려 가능합니다.");
// 			return false;				
// 		}
// 	}
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : gridHeader.getAllJsonRowsExcludeDeleteRow()});
	
     if(confirm("반려 하시겠습니까?")){
    	 saveCall(gridHeader, '/com/bdg/returnBasicMgt', 'fnReturn', params);
     }

}

/**
 * 헤더 삭제
 */
function fnDeleteH() {
	rowIndex = "";
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridHeader)});
	
	for(var i = 0; i < params.ITEM_LIST.DELETED.length; i++){
		if(params.ITEM_LIST.DELETED[i].PROCESS_TYPE == '2'){
			alert("경영예산인 경우 삭제가 불가능합니다. 확인후 작업하세요.");
			return false;
		}
		
		if(params.ITEM_LIST.DELETED[i].ACCOUNT_GUBN == 'N'){
			alert("삭제 불가한 계정입니다. 확인후 작업하세요.");
			return false;
		}			
	}
	
	if(fnDeleteCheck(gridHeader) == true){
		deleteCall(gridHeader, '/com/bdg/delBasicH', 'fnDelD', params);
	}

}

//내년만 가능
function fnCheckYear() {
	if($("#TB_CRTN_YY").val() != nextYear){
		alert(nextYear + "년도만 가능합니다.");
		return false;
	}
}

/**
 * 코스트 조회
 */
function fnSearchCctr(str) {
	paramGubn = str;
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "cmnCctrSearchPop";
	var width     = "900";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/cmn/cctrList', params, target, width, height, scrollbar, resizable);
}

/**
 * 코스트 콜백
 */
function fnCallbackPop(rows) {
	$("#SB_CCTR_CD").val(rows.CCTR_CD);
	$("#TB_CCTR_NM").val(rows.CCTR_NM);
	fnSearch();
}

//코스트 리셋
function fnCctrReset() {
	$("#SB_CCTR_CD").val("");
	$("#TB_CCTR_NM").val("");
	fnSearch();
}

//HR 예산수신
function fnReceiveHrBugt() {
	var params = {};
 	$.extend(params, fnGetParams());
 	
     if(confirm("HR 예산을 수신하시겠습니까?")){
     	saveCall(gridView, '/com/bdg/receiveBasicHrBugt', 'fnReceiveHrBugt', params);
     }
 }

 function fnReceiveHrBugtSuccess(data) {
 	alert("HR예산이 수신되었습니다.");
 	fnSearch();
 }

 function fnReceiveHrBugtFail(result) {
 	alert("HR예산 실패 하였습니다.");
 }
 
//감가상각비수신
function fnReceiveDpreAccount() {
 	var params = {};
  	$.extend(params, fnGetParams());
  	
	if(isEmpty($("#TB_CRTN_YY").val()) == true){
		alert("년도는 필수입니다.");
		return false;
	}  	
  	
    if(confirm("감가상각비를 수신하시겠습니까?")){
		saveCall(gridView, '/com/bdg/receiveDpreBasic', 'fnReceiveDpreAccount', params);
    }
}

function fnReceiveDpreAccountSuccess(data) {
	alert("감가상각비 수신되었습니다.");
	fnSearch();
}

function fnReceiveDpreAccountFail(result) {
	alert("감가상각비 실패 하였습니다.");
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
                <col style="width:140px">
                <col style="width:410px">
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD" onchange="fnCctrReset();">
	                    </select>
                    </td>
                    <th><span>년도</span></th>
                    <td>
						<input type="number" id="TB_CRTN_YY"  style="text-align: right; width: 50px; text-align: center" onchange="fnSearch();">
                    </td>
                    <th><span>코스트센터</span></th>
                    <td>
                        <input type="text"   id="TB_CCTR_NM" disabled="disabled">
                        <input type="hidden" id="SB_CCTR_CD">
                        <a href="javascript:fnSearchCctr();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                        <a href="javascript:fnCctrReset();" style="background:url(../../../resources/images/icon/IcoDel.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
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
    <div class="tbl-search-area" style="float:left; width:800px;">
        <table class="tbl-search">
            <colgroup>
                <col style="width:70px">
                <col style="width:90px">
                <col style="width:60px">
                <col style="width:90px">
                <col>
            </colgroup>
	        <tr>
				<th style="padding-top: 10px;">(단위 : 원)</th>
				<th style="padding-top: 10px; padding-left: 15px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>차수</span></th>
	        	<td style="padding-top: 10px;">
					<input type="text" id="TB_SEND_CHASU"  style="text-align: center; width: 40px;" disabled>	        	
	        	</td>
				<th style="padding-top: 10px; padding-left: 5px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>전송일</span></th>
	        	<td style="padding-top: 10px;">
					<input type="text" id="TB_SEND_YMD"  style="text-align: center; width: 80px;" disabled>	        	
	        	</td>
	        	<td></td>
	        </tr>
		</table>
	</div>
<div class="sub-tit">
    <div class="btnArea t_right" id="div_btnH">
        <button type="button" class="btn" id="btnSap">SAP전송</button>
        <button type="button" class="btn" id="btnReceiveHrBugt">HR예산수신</button>
        <button type="button" class="btn" id="btnReceiveDpreAccount">감가상각비수신</button>
        <button type="button" class="btn" id="btnReturn">반려</button>
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

<div id="chasu_dialog" title="차수 ">
<p id="ment" style="font-family:'맑은고딕', 'Malgun Gothic','돋움', 'Dotum', sans-serif; font-size:12px; color:#999; margin-bottom: 5px; margin-top: 5px; margin-left: 3px;"></p>
        <table class="tbl-view">
            <colgroup>
                <col style="width:40%">
                <col style="width:60%">
            </colgroup>
            <tbody>
                <tr>
                    <th>차수</th>
                    <td>
	                    <select id="SB_CHASU" name="SB_CHASU" data-type="select" data-bind="selectedOptions: SB_CHASU">
		                    <option value="00">00</option>
		                    <option value="01">01</option>
		                    <option value="02">02</option>
		                    <option value="03">03</option>
		                    <option value="04">04</option>
		                    <option value="05">05</option>
		                    <option value="06">06</option>
		                    <option value="07">07</option>
		                    <option value="08">08</option>
		                    <option value="09">09</option>
	                    </select>
                    </td>
                </tr>
            </tbody>
        </table>                    
<div align="center">
    <button type="button" class="btn" id="btnConfirm" style="margin-top: 5px;">확인</button>
</div>
 </div>