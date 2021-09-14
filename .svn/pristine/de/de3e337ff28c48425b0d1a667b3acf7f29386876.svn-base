<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">

	var workGubunCodes  = new Array();
	var workGubunLabels = new Array();
	
	var ynGubunCodes  = new Array();
	var ynGubunLabels = new Array();	

	$(document).ready(function() {
		//초기화함수
		init();
    	makeBtnClickEvent();
		//그리드 초기화
		setInitGrid();
		setInitGrid2();
		
		fnSearch();
	});

	
	//초기화함수
	function init() {
		
	    // 개별코드 생성(그리드용)
	    workGubunCodes  = getComboSet('${CODELIST_IG003}', 'CODE');
	    workGubunLabels = getComboSet('${CODELIST_IG003}', 'CODE_NM');	
	    
	    ynGubunCodes  = getComboSet('${CODELIST_E102}', 'CODE');
	    ynGubunLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');		    
		
	}
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridVendorPurchOrg";
		gridVendorPurchOrg = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm ,   'PURCHORG_NM', {text: '구매조직'}     ,100     , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'CURR_CD'    , {text: '통화'}        ,70      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'PAY_COND'   , {text: '대금지급조건'}   ,100     , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'PAY_COND_NM', {text: '대금지급내역'}   ,200     , 'text'            , {textAlignment: "near"});
	    
	    gridVendorPurchOrg.rgrid({
	         gridId         : gridId    //required 그리드 ID
	        ,height         : 200      //required 그리드 높이
	        //,width            : "100%"    //default 100% 그리드 넓이
	        //,rowHeight        : 30        //default 30 row height
	        ,columns        : cm        // required
	        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
	        ,exclusive      : true      //default false 한 행만 체크 가능할지의 여부를 지정한다.
	        ,editable       : false      //default false 그리드 전체 에디트 여부
	        ,selectStyle    : "singleRow"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
	        ,dynamicResize  : false     //default false 동적 그리드 높이 변경
	        ,copySingle     : false // default ture : 복사하지 않음 
	    });
	    
	}	
	
	
	//그리드 초기화 함수
	function setInitGrid2() {
		var gridId = "gridVendorUser";
		gridVendorUser = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm ,   'WORK_GUBUN' , {text: '업무구분'}    ,100     , 'text'            , {textAlignment: "center"},  {lookupDisplay: true,values:workGubunCodes,labels:workGubunLabels},'dropDown');
	    addField(cm ,   'USER_NM'    , {text: '담당자'}     ,100     , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'TEL_NO'     , {text: '연락처'}     ,100     , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'EMAIL'      , {text: 'EMAIL'}    ,150     , 'text'            , {textAlignment: "near"});
	    addField(cm ,   'SAP_RECV_YN', {text: 'SAP수신'}   ,60      , 'text'            , {textAlignment: "center"});
	    //addField(cm ,   'EMAIL_YN'   , {text: 'EMAIL수신'} ,60      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'EMAIL_YN'   , {text: 'EMAIL수신'}    ,60     , 'text'            , {textAlignment: "center"},  {lookupDisplay: true,values:ynGubunCodes,labels:ynGubunLabels},'dropDown');
	    //addField(cm ,   'SMS_YN'     , {text: 'SMS수신'}   ,60      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'SMS_YN'   , {text: 'SMS수신'}    ,60     , 'text'            , {textAlignment: "center"},  {lookupDisplay: true,values:ynGubunCodes,labels:ynGubunLabels},'dropDown');
	    addField(cm,    'SEQ'        , {text: 'SEQ'}      ,0       , 'text'            , {textAlignment: 'center'},  {visible:false});
	    addField(cm,    'CRUD'       , {text: 'CRUD'}     ,0       , 'text'            , {textAlignment: 'center'},  {visible:false});
	    addField(cm,    'VENDOR_CD'  , {text: '업체코드'}    ,0       , 'text'            , {textAlignment: 'center'},  {visible:false});
	    
	    
	    gridVendorUser.rgrid({
	         gridId         : gridId    //required 그리드 ID
	        ,height         : 200      //required 그리드 높이
	        //,width            : "100%"    //default 100% 그리드 넓이
	        //,rowHeight        : 30        //default 30 row height
	        ,columns        : cm        // required
	        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
	        ,exclusive      : false      //default false 한 행만 체크 가능할지의 여부를 지정한다.
	        ,editable       : true      //default false 그리드 전체 에디트 여부
	        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
	        ,dynamicResize  : false     //default false 동적 그리드 높이 변경
	        ,copySingle     : false // default ture : 복사하지 않음 
	    });
	    
	    // 동적 스타일 적용
	    var columnDynamicStyles = function(grid, index, value) {
	        var styles = {};
	        var values = grid.getValues(index.itemIndex);
	        var gubn   = values.SAP_RECV_YN;
	        if (gubn == "N") {
	            styles.editable = true;
	            styles.background = "#d5e2f2";
	        } else {
	        	styles.editable = false;
	        }

	        return styles;
	    };
	    
	    // 기본 스타일 적용
	    var columnDefaultStyles = function(grid, index, value) {
	        var styles = {};
	        	styles.editable = false;
	        return styles;
	    };
	    
	    gridVendorUser.setColumnProperty("WORK_GUBUN" , "dynamicStyles", columnDynamicStyles);
	    gridVendorUser.setColumnProperty("USER_NM"    , "dynamicStyles", columnDynamicStyles);
	    gridVendorUser.setColumnProperty("TEL_NO"     , "dynamicStyles", columnDynamicStyles);
	    gridVendorUser.setColumnProperty("EMAIL"      , "dynamicStyles", columnDynamicStyles);
	    gridVendorUser.setColumnProperty("EMAIL_YN"   , "dynamicStyles", columnDynamicStyles);
	    gridVendorUser.setColumnProperty("SMS_YN"     , "dynamicStyles", columnDynamicStyles);
	    
	    gridVendorUser.setColumnProperty("SAP_RECV_YN", "dynamicStyles", columnDefaultStyles);	    
	    
	    
	    
	    gridVendorUser.onCurrentRowChanged =  function (grid, oldRow, newRow) {
	    	var curr   = grid.getCurrent();
	    	var values = grid.getValues(curr.itemIndex);
	        var editable = false;
	        if (newRow === -1 && curr.itemIndex > -1) {
	            editable = true;
	        } else if (newRow === -1 && curr.itemIndex === -1) {
	            editable = false;
	        } else {
	            if (grid.getRowState(curr.itemIndex) === "created") {
	                editable = true;
	            } else {
	            	var value = values.SAP_RECV_YN;
	            	if ($.trim(value) === "Y"){
	            		editable = false;
		            } else {
		            	editable = true;
		            }
	            }
	        }
	    };
	    
	    //그리드 변경 시 체크박스 true
	    gridVendorUser.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
	    	gridVendorUser.checkItem(dataRow, true);
	    };	    
	}
	
	//전체 조회
	function fnSearch() {
		
	    var params = fnGetMakeParams();
	    $.extend(params, {"VENDOR_CD"    : '${PARAM.VENDOR_CD}'});
		// 구매조직 조회
		searchCall(gridVendorPurchOrg, '/com/wrh/selectVendorPurchOrgList', "fnVendorPurchOrgList", params);
		//구매 담당자 정보 조회
		searchCall(gridVendorUser, '/com/wrh/selectVendorUserList', "fnVendorUserList", params);
	}

	// 구매조직 조회 후처리
	function fnVendorPurchOrgListSuccess(data) {
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridVendorPurchOrg.clearRows();
		// 그리고 데이터 setting
	    gridVendorPurchOrg.setPageRows(data);
		// 프로그레스바 클로즈
		gridVendorPurchOrg.closeProgress();
	}
	
	// 구매담당자 조회 후처리
	function fnVendorUserListSuccess(data) {
		// 에러메세지 처리
		alertErrMsg(data);
		// 그리드 초기화
	    gridVendorUser.clearRows();
		// 그리고 데이터 setting
	    gridVendorUser.setPageRows(data);
		// 프로그레스바 클로즈
		gridVendorUser.closeProgress();
	}
	
	//행삭제
	var fnRowDel = function(){
		fnAddRowDelete(gridVendorUser);
	}

	//행추가
	function fnRowAdd() {
		var values = {"CRUD":"I", "WORK_GUBUN": "1", "SAP_RECV_YN":"N", "EMAIL_YN":"Y", "SMS_YN" : "Y", "VENDOR_CD":'${PARAM.VENDOR_CD}'};
		fnAddRow(gridVendorUser, values);
	}

	//삭제
	var fnDel = function(){
		
		gridVendorUser.commit();
		
		// 그리드 수정사항 확정처리
		var checkedRows = gridVendorUser.getSelectedItems();
		for(var i = 0; i < checkedRows.length; i++){
			if(checkedRows[i].CRUD == "R" && checkedRows[i].SAP_RECV_YN == "Y"){
				alert("SAP 수신된 데이터는 삭제 할 수 없습니다.");
				return false;
			}
		}
		
		var params = {};
		$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridVendorUser)});
		if(fnDeleteCheck(gridVendorUser) == true){
			// 조회 요청
			deleteCall(gridVendorUser, '/com/wrh/deleteVendorUser', null, params);
		}
		
	}

	//저장
	var fnSave = function(){
		
		gridVendorUser.commit();
		
		// 그리드 수정사항 확정처리
		var checkedRows = gridVendorUser.getSelectedItems();
		for(var i = 0; i < checkedRows.length; i++){
			if(checkedRows[i].CRUD == "R" && checkedRows[i].SAP_RECV_YN == "Y"){
				alert("SAP 수신된 데이터는 수정 할 수 없습니다.");
				return false;
			}
			
			if (isEmpty(checkedRows[i].TEL_NO)) {
				alert("전화번호는 필수입력입니다.");
				return false;
			} else {
//	 			if (checkPhoneNumber(checkedRows[i].TEL_NO) == false) {
// 				alert("전화번호형식에 형식에 맞지 않습니다.");
// 				return false;
// 			}				
			}
			
			if (isEmpty(checkedRows[i].EMAIL)) {
				alert("전화번호는 필수입력입니다.");
				return false;
			} else {
				if (EemailFormatCheck(checkedRows[i].EMAIL) == false) {
					return false;
				}				
			}			
		}
		
		var params = {};
		$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridVendorUser)});
		
		// 필수 체크 대상(그리드)
		var requiredVal   = [];

		// 필수 체크 후 저장 진행
		if(fnSaveCheck(gridVendorUser, requiredVal) == true){
		     if(confirm("저장 하시겠습니까?")){
		    	 saveCall(gridVendorUser, '/com/wrh/saveVendorUser', null, params);
		     }
		}
	}

	/**
	 * 저장 성공
	 */
	function fnSaveSuccess(result) {
		alert("저장되었습니다.");
	    // 상태바 비활성화
	    gridVendorUser.closeProgress();
	    
	    var params = fnGetMakeParams();
	    $.extend(params, {"VENDOR_CD"    : '${PARAM.VENDOR_CD}'});	    
		//구매 담당자 정보 조회
		searchCall(gridVendorUser, '/com/wrh/selectVendorUserList', "fnVendorUserList", params);
	}

	/**
	 * 저장 실패
	 */
	function fnSaveFail(data) {
		alert(data.errMsg);
	    // 상태바 비활성화
	    gridVendorUser.closeProgress();
	}

	/**
	 * 삭제 성공
	 */
	function fnDeleteSuccess(result) {
		alert("삭제 하였습니다.");
		
	    var params = fnGetMakeParams();
	    $.extend(params, {"VENDOR_CD"    : '${PARAM.VENDOR_CD}'});		
		//구매 담당자 정보 조회
		searchCall(gridVendorUser, '/com/wrh/selectVendorUserList', "fnVendorUserList", params);
	}

	/**
	 * 삭제 실패
	 */
	function fnDeleteFail(result) {
		alert(result.errMsg);
	}	

	
</script>

<div class="pop-wrap"  style="width:100%;">
	<div class="pop-head">
		<h2>업체상세정보</h2>
	</div>
    <div class="pop-cont">
    	<div class="sub-tit">
		    <h4>기본정보</h4>
		</div>    
        <table class="tbl-view">
			<colgroup>
                <col style="width:15%">
                <col>
                <col style="width:15%">
                <col>
			</colgroup>
			<tbody>
				<tr>
					<th>업체명</th>
					<td id="TB_VENDOR_NM">${PARAM.VENDOR_NM}</td>
					<th>업체코드 </th>
					<td id="TB_VENDOR_CD">${PARAM.VENDOR_CD}</td>
				</tr>
				<tr>
					<th>사업자번호</th>
					<td id="TB_POBUSI_NO_DSP">${PARAM.POBUSI_NO_DSP}
						<input type="hidden" id="TB_POBUSI_NO" name="TB_POBUSI_NO" value="${PARAM.POBUSI_NO}">
					</td>
					<th>법인번호</th>
					<td id="TB_CORP_NO">${PARAM.CORP_NO}</td>
				</tr>
				<tr>
					<th>대표자명</th>
					<td id="TB_PRESIDENT_NM">${PARAM.PRESIDENT_NM}</td>
					<th>내외자구분</th>
					<td id="TB_FUND_TYPE">${PARAM.FUND_TYPE_NM}</td>
				</tr>
				<tr>
					<th>업종</th>
					<td id="TB_BUSS_TYPE">${PARAM.BUSS_TYPE}</td>
					<th>업태</th>
					<td id="TB_BUSIN">${PARAM.BUSIN}</td>
				</tr>
				<tr>
					<th>우편번호</th>
					<td id="TB_ZIP_NO">${PARAM.ZIP_NO}</td>
					<th>주소</th>
					<td id="TB_ADDR">${PARAM.ADDR}</td>
				</tr>
				<tr>
					<th>Email</th>
					<td id="TB_MAIN_EMAIL">${PARAM.MAIN_EMAIL}</td>
					<th>전화번호</th>
					<td id="TB_MAIN_TELL_NO">${PARAM.MAIN_TELL_NO}</td>
				</tr>
				<tr>
					<th>FAX</th>
					<td colspan="3" id="TB_MAIN_FAXNO">${PARAM.MAIN_FAXNO}</td>
				</tr>
			</tbody>
		</table>                    
		<div class="sub-tit">
		    <h4>구매조직</h4>
		</div>		
		<div class="realgrid-area">
		    <div id="gridVendorPurchOrg"></div>
		</div>
		<div class="sub-tit">
		    <h4>담당자</h4>
		    <div class="btnArea t_right">
		        <button type="button" class="btn" id="btnRowDel">행삭제</button>
		        <button type="button" class="btn" id="btnRowAdd">행추가</button>
		        <button type="button" class="btn" id="btnDel">삭제</button>
		        <button type="button" class="btn" id="btnSave">저장</button>
		    </div>		    
		</div>		
		<div class="realgrid-area">
		    <div id="gridVendorUser"></div>
		</div>		
	</div><!-- //popCont -->
</div>

