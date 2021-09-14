/**
 * 파일업로드 공통팝업
 * options 항목 target, url, callback, dataFormat, width, height, readOnly
 */
var openFileUplaod = function(options) {
    options = options || {};
    if (options["KEY_ID"] === 'undefined') {
        alert('필수값 keyId가 없습니다.');
        return;
    }
    var defaults = {TARGET:'FileUpload', 
    				url:getContextPath() + '/upload', 
    				CALLBACK:'fnCallBackFileUpload', 
    				DATA_FORMAT:'raw', 
    				width:800, 
    				height:500, 
    				READ_ONLY:false,
    				SEND_OUT_FLAG:"N"};
    for(var prop in defaults) {
        options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : defaults[prop];
    }
    
    $.extend(options,fnGetParams());
    
    options.APP_SEQ = $("#" + options.KEY_ID).val();
    fnPostPopup(options.url, options, options.TARGET, 800, 500);
    
};

var openUploadPop = function(options) {
    options = options || {};
    if (options["KEY_ID"] === 'undefined') {
        alert('필수값 keyId가 없습니다.');
        return;
    }
    var defaults = {TARGET:'FileUpload', 
    				url:getContextPath() + '/uploadForm', 
    				CALLBACK:'fnCallBackFileUpload', 
    				DATA_FORMAT:'raw', 
    				width:800, 
    				height:500, 
    				READ_ONLY:false,
    				SEND_OUT_FLAG:"N"};
    for(var prop in defaults) {
        options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : defaults[prop];
    }
    
    $.extend(options,fnGetParams());
    
    options.APP_SEQ = $("#" + options.KEY_ID).val();
    fnPostPopup(options.url, options, options.TARGET, 800, 500);
}

var openDownPop = function(options) {
    options = options || {};
    if (options["KEY_ID"] === 'undefined') {
        alert('필수값 keyId가 없습니다.');
        return;
    }
    var defaults = {TARGET:'FileUpload', 
    				url:getContextPath() + '/downForm', 
    				CALLBACK:'fnCallBackFileUpload', 
    				DATA_FORMAT:'raw', 
    				width:800, 
    				height:500, 
    				READ_ONLY:false,
    				SEND_OUT_FLAG:"N"};
    for(var prop in defaults) {
        options[prop] = typeof options[prop] !== 'undefined' ? options[prop] : defaults[prop];
    }
    
    $.extend(options,fnGetParams());
    
    options.APP_SEQ = $("#" + options.KEY_ID).val();
    fnPostPopup(options.url, options, options.TARGET, 800, 500);
}


/**
 * Item 검색 팝업
 * callBack function : doSetItemInfo(rowId, rowData){}
 * ex)
	
	popup호출
	var rowData = $("#gridList").jqGrid("getRowData", row);
	searchItemPop(row);
	
	callBack 호출.
	var rowData = $("#gridList").jqGrid("getRowData", row);
	opener.doSetItemInfo('${PARAM.ROW_KEY}', rowData);
			
	callBack 처리.
	
	var doSetItemInfo = function(rowId, rowData)
	{
		$("#gridList").setCellValue(rowId, "ITEM_CD",rowData.ITEM_NO);
		$("#gridList").setCellValue(rowId, "ITEM_NM",rowData.ITEM_NAME);
	}
	
	#data define#
	소분류코드	: rowData.SRC_GRP_CD
	소분류명		: rowData.SRC_GRP_NAME
	ITEM타입		: rowData.ITEM_TYPE
	ITEM코드		: rowData.ITEM_NO
	ITEM명		: rowData.ITEM_NAME
	규격			: rowData.ITEM_SPEC
	모델명		: rowData.MODEL_NAME
	제조사		: rowData.MAKER_NAME
	단위			: rowData.ITEM_UNIT
 */
var searchItemPop = function(pPLANT_FIX,pPLANT_CD,pPLANT_NM) {
	
	var url = getContextPath() + "/com/cmn/cmnItemSearchPopup.do";
	var target = "cmnItemSearchPopup";
	var width = "1024";
	var height = "600";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.plant_fix = pPLANT_FIX == 'undefined' ?"" : pPLANT_FIX;
	params.plant_cd = pPLANT_CD  == 'undefined' ?"" : pPLANT_CD;
	params.plant_nm = pPLANT_NM  == 'undefined' ?"" : pPLANT_NM;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
};
var searchSrcMappingItemPop = function() {
	
	var url = getContextPath() + "/com/cmn/cmnSrcMappingItemSearchPopup.do";
	var target = "cmnMappingItemItemSearchPopup";
	var width = "1024";
	var height = "600";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
};

var searchItemExtWithSapPop = function(pPLANT_CD,pPLANT_NM) {
	var url = getContextPath() + "/com/cmn/cmnItemSearchExtWithSapPopup.do";
	var target = "cmnItemSearchExtWithSapPopup";
	var width = "1024";
	var height = "600";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.PLANT_CD = pPLANT_CD  == 'undefined' ?"" : pPLANT_CD;
	params.PLANT_NM = pPLANT_NM  == 'undefined' ?"" : pPLANT_NM;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
};

/**
 * 소분류 검색 팝업
 * callBack function : doSetSgInfo(rowData){}
 * ex)
	popup호출
	var callType = "SINGLE";
	var src_grp_name = $("#S_SRC_GRP_NAME").val();
		
	searchSmallCatePopup(callType, src_grp_name);

	callback 호출
	var rowData = $("#gridList").jqGrid("getRowData", row);
	opener.doSetSgInfo(rowData);
	
	callback처리
	var doSetSgInfo = function(rowData)
	{
		if(rowData != null)
		{
			$("#S_SRC_GRP_CD").val(rowData.SM_CD);
			$("#S_SRC_GRP_NAME").val(rowData.SM_NAME);
		}
	}
	
	#data define#
	대분류코드	: rowData.BIG_CD
	대분류명		: rowData.BIG_NAME
	중분류코드	: rowData.MID_CD
	중분류명		: rowData.MID_NAME
	소분류코드	: rowData.SM_CD
	소분류명		: rowData.SM_NAME
 */
var searchSmallCatePopup = function(callType, src_grp_name, rowKey){
	var url = getContextPath() + "/com/cmn/smallCatePopup.do";
	var target = "smallCatePopup";
	var width  = "600";
	var height = "600";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.CALL_TYPE = callType;
	params.SRC_GRP_NM = src_grp_name;
	params.ROW_KEY = rowKey;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
}

/**
 * 업체조회 팝업
*	callBack function : doSetVendorInfo(rowDataList){}
*
*	ex)
	popup호출
	searchVendorPopup('DO');

	callback 호출
	var selRowIds = $("#gridList").jqGrid('getGridParam','selarrrow');
	var rowDataList = "";
	
	if(selRowIds.length > 0)
	{
		rowDataList =  $("#gridList").getRowValues(selRowIds);	
	}
	else
	{
		alert("데이터를 선택해 주시기 바랍니다.");
		return false;
	}
	console.log(JSON.stringify(rowDataList));
	opener.doSetVendorInfo(rowDataList);
	window.close();
	
	callback처리
	for(var i = 0 ; i < rowDataList.length ; i ++)
	{
		var $grid = $("#gridList2");
		var last = Number($grid.getGridParam("records")) + 1;
		var newId = $.jgrid.randId();
		var row = rowDataList[i];
		
		var datarow = {
					VENDOR_REGNO			: row.VENDOR_REGNO,
					VENDOR_NAME	  			: row.VENDOR_NAME,
					VENDOR_DAMDANG_NAME		: row.VENDOR_DAMDANG_NAME,
					VENDOR_DAMDANG_MOBILE 	: row.VENDOR_DAMDANG_MOBILE,
					VENDOR_REASON			: ""
			};
		
		$grid.addRowData(newId, datarow, "last");
	}
	
	#data define#
	중분류(거래영역)	: row.MID_CLS_NM
	소분류			: row.SRC_GRP_NM
	업체코드			: row.VENDOR_CD
	업체명			: row.VENDOR_NAME
	사업자등록번호	: row.VENDOR_REGNO
	대표자명			: row.VENDOR_REPRE
	담당자명			: row.VENDOR_DAMDANG_NAME
	연락처			: row.VENDOR_DAMDANG_MOBILE
	담당자 E-MAIL	: row.VENDOR_DAMDANG_EMAIL
	
 */
var searchVendorPopup = function(cntrt_dstin, callbackFunc, defaultVendorName){
	var url = getContextPath() + "/com/cmn/cmnVendorPerSearchPopup.do";
	var target = "cmnVendorPerSearchPopup";
	var width = "1020";
	var height = "520";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
		params.CNTRT_DSTIN = cntrt_dstin;
		params.callbackFunc = callbackFunc;
		if (!isEmpty(defaultVendorName)){
			params.vendorName = defaultVendorName;
		}
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}

var searchSgVendorPopup = function(cntrt_dstin, callbackFunc, defaultVendorName){
	var url = getContextPath() + "/com/cmn/cmnSgVendorPerSearchPopup.do";
	var target = "cmnSgVendorPerSearchPopup";
	var width = "1020";
	var height = "700";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
		params.CNTRT_DSTIN = cntrt_dstin;
		params.callbackFunc = callbackFunc;
		if (!isEmpty(defaultVendorName)){
			params.vendorName = defaultVendorName;
		}
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}

/**
 * 사용자 검색 함수
 * 시스템의 사용자를 검색 팝업
 * 
 * USER_CB_FNC : 사용자 선택시 부모창의 호출 함수 (필수)
 * USER_CB_NAME : 기본 사용자 검색값 (선택)
 */
var searchUserPop = function() {
	var url = getContextPath()+"/com/cmn/cmnUserSearchPop.do";
	var params = {};
	$.extend(params, fnGetParams());
	
	var target = "cmnUserSearchPop";
	var width = "800";
	var height = "500";
	
	fnPostPopup(url, params, target, width, height); 
};


/**
 * 사용자 검색 함수 구매담당자
 * 시스템의 사용자를 검색 팝업
 * 
 * USER_CB_FNC : 사용자 선택시 부모창의 호출 함수 (필수)
 * USER_CB_NAME : 기본 사용자 검색값 (선택)
 */
var searchPurUserPop = function() {
	var url = getContextPath()+"/com/cmn/cmnUserSearchPop.do";
	var params = {};
	params.SRCH_ROLE = "PUR";
	
	$.extend(params, fnGetParams());
	
	var target = "cmnUserSearchPop";
	var width = "800";
	var height = "500";
	
	fnPostPopup(url, params, target, width, height); 
};

var searchPurUserPopInGrid = function() {
	var url = getContextPath()+"/com/cmn/cmnUserSearchPop.do";
	var params = {};
	params.SRCH_ROLE = "PUR";
	$.extend(params, fnGetParams());
	
	var target = "cmnUserSearchPop";
	var width = "800";
	var height = "480";
	
	fnPostPopup(url, params, target, width, height); 
};


/**
 * 부서검색
 * 시스템의 부서목록을 검색 팝업
 * 
 * USER_CB_FNC : 사용자 선택시 부모창의 호출 함수 (필수)
 * USER_CB_NAME : 기본 사용자 검색값 (선택)
 */
var searchDeptPop = function() {
	var url = getContextPath()+"/com/cmn/cmnDeptSearchPop.do";
	var params = {};
	$.extend(params, fnGetParams());
	
	var target = "cmnDeptSearchPop";
	var width = "800";
	var height = "520";
	
	fnPostPopup(url, params, target, width, height); 
};


/**
 * G/L 검색 팝업
 * 
 * GL_CB_FNC : 선택시 부모창의 호출 함수 (필수)
 * GL_CODE : 기본 사용자 검색값 (선택)
 */
var searchGLPop = function(rowKey) {
	var url = getContextPath() + "/com/cmn/searchGlCodePopup.do"; //cmnGLSearchPop
	var params = {};
	$.extend(params, fnGetParams());
	
	var target = "searchGlCodePopup";
	var width = "440";
	var height = "440";
	
	var params = fnGetParams();
	params.ROW_KEY = rowKey;
	
	fnPostPopup(url, params, target, width, height);
};
/**
 * WBS 검색 팝업
 * 
 * GL_CB_FNC : 선택시 부모창의 호출 함수 (필수)
 * GL_CODE : 기본 사용자 검색값 (선택)
 */
var searchWBSPop = function(rowKey) {
	var url = getContextPath() + "/com/cmn/searchWbsCodePopup.do"; //cmnGLSearchPop
	var params = {};
	$.extend(params, fnGetParams());
	
	var target = "searchWbsCodePopup";
	var width = "440";
	var height = "440";
	
	var params = fnGetParams();
	params.ROW_KEY = rowKey;
	
	fnPostPopup(url, params, target, width, height);
};



var openEdmsSender = function(options) {
	var url = getContextPath() + "/edms/edmsSendPopup.do";
	var params = fnGetParams();
	$.extend(params, options);
	
	var target 	= "EDMS_SEND";
	var width 	= "600";
	var height 	= "400";
	
	fnPostPopup(url, params, target, width, height);
};

/*
 * SAP_COST_CENTER 정보 조회 팝업
 */
var searchSapCostCenterPopup = function(cntrt_dstin){
	var url = getContextPath() + "/com/cmn/sapCostCenterSearchPopup.do";
	var target = "sapCostCenterSearchPopup";
	var width = "1000";
	var height = "580";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
		params.CNTRT_DSTIN = cntrt_dstin;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}
/*
 * SAP_UNIT 정보 조회 팝업
 */
var searchSapUnitPopup = function(cntrt_dstin){
	var url = getContextPath() + "/com/cmn/sapUnitSearchPopup.do";
	var target = "sapUnitSearchPopup";
	var width = "500";
	var height = "580";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.CNTRT_DSTIN = cntrt_dstin;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}
/*
 * SAP_STORAGE_LOC 정보 조회 팝업
 */
var searchSapStorageLocPopup = function(cntrt_dstin){
	var url = getContextPath() + "/com/cmn/sapStorageLocSearchPopup.do";
	var target = "sapStorageLocSearchPopup";
	var width = "750";
	var height = "580";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.CNTRT_DSTIN = cntrt_dstin;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}

/*
 * SG Search PopUp 부모창에서 받는 부분 구현X
 */

var searchSgPopup = function(cntrt_dstin){
	var url = getContextPath() + "/com/cmn/cmnSGSearchPopup.do";
	var target = "sapStorageLocSearchPopup";
	var width = "800";
	var height = "530";
	var scrollbar = "no";
	var resizable = "yes";
	
	var params = fnGetParams();
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}
/**
 * 저장위치 선택팝업
 * callbackFunc - 콜백함수명
 * plant_fix - 공장코드고정여부Y,N
 * plant_cd - 고정 공장코드
 * plant_nm - 고정 공장명
 */
var searchStoragePopup = function(callbackFunc, plant_fix, plant_cd, plant_nm){
	
	var url = getContextPath() + "/com/cmn/cmnStorageSearchPop.do";
	var target    = "searchStoragePopup";
	var width     = "800";
	var height    = "560";
	var scrollbar = "no";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.callbackFunc = callbackFunc;
    params.plant_fix    = plant_fix;
    params.plant_cd     = plant_cd;
    params.plant_nm     = plant_nm;
    
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);	
}

/**
 * 협력사 신용평가정보(이크레더블 Web link) 조회 팝업
 * bizno : 사업자번호
 * defaultTab (옵션):  기본설정탭 2(Watch메인-default), 3(전자인증서메인), 4(건설실적메인), 5(거래위험메인) , 55(기술평가) 
 */
var viewVendorCreditEvalPop = function(bizno, defaultTab) {
	
	var url = getContextPath() + "/com/cmn/cmnVendorCreditEvalViewPopup.do";
	var target = "viewVendorCreditEvalPop";
	var width = "1024";
	var height = "768";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	params.bizno = bizno;
	params.defaultTab = defaultTab;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
};

/**
 * RFC 호출 결과로그 팝업
 * JCO_SEQ   : JCO로그일련번호 (필수)
 * REF_DATA1 : 참조값1 (옵션)
 * REF_DATA2 : 참조값2 (옵션)
 * REF_DATA3 : 참조값3 (옵션)
 */
var viewJcoReturnLogPop = function(JCO_SEQ, REF_DATA1, REF_DATA2, REF_DATA3) {
	
	var url = getContextPath() + "/com/cmn/cmnJcoReturnLogPopup.do";
	var target = "cmnJcoReturnLogPop";
	var width = "1000";
	var height = "400";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetParams();
	$.extend(params, {'JCO_SEQ':JCO_SEQ
        ,'REF_DATA1':REF_DATA1
        ,'REF_DATA2':REF_DATA2
        ,'REF_DATA3':REF_DATA3});
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
};

/**
 * 장비 검색 함수
 * 
 * USER_CB_FNC : 사용자 선택시 부모창의 호출 함수 (필수)
 * USER_CB_NAME : 기본 사용자 검색값 (선택)
 */
var searchEquipmentPop = function() {
	var url = getContextPath()+"/com/cmn/cmnEQSearchPop.do";
	var params = {};
	
	$.extend(params, fnGetParams());
	
	var target = "cmnEQSearchPop";
	var width = "800";
	var height = "500";
	
	fnPostPopup(url, params, target, width, height); 
};

/**
 * 전자결재 상세 조회 팝업
 * apprId : 결재연동번호
 */
var fnApprView = function(apprId) {
	
	var url = getContextPath() + "/com/cmn/cmnUserAppViewPopup.do";
	var target = "cmnUserAppViewPopup";
	var width = "1024";
	var height = "768";
	var scrollbar = "yes";
	var resizable = "yes";
	
	var params = fnGetMakeParams();
	params.apprId = apprId;
	
	fnPostPopup(url, params, target, width, height, scrollbar, resizable);
};