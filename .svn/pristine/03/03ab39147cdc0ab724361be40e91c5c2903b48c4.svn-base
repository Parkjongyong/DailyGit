<%--
	File Name : wrhStockDueDate.jsp
	Description: 입고예정 > 입고승인 > 입고예정상세
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.22  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.22
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">
var gridView;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	// 그리드 생성
	setInitGridView();
	
	// 초기 상태값 처리
    fnInitStatus();
	
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();

    fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	$("#TB_SYSDATE").val(getDiffDay("d", 0));
	var menuCd = '${PARAM.G_MENU_CD}';
	
	if(menuCd == "WRH161" || menuCd == "WRH164" || menuCd == "VWRH152" ||  menuCd == "WRH171"){// 중요자재확인, 입고예정현황, 입고예정정보
		$("#btnAppr").hide();
		$("#btnReturn").hide();
		$("#SEARCH_PLANT").hide();
		$("#TB_APPROVE_DOC_TXT").attr("disabled", "disabled");
	} else if(menuCd == "WRH162" || menuCd == "WRH163"){ // 입고승인, 구매입고승인
		$("#btnAppr").show();
		$("#btnReturn").show();
		$("#SEARCH_PLANT").show();
		$("#TB_APPROVE_DOC_TXT").removeAttr("disabled");
	} else if(menuCd == "WRH165"){ // 입고예정관리
		$("#btnAppr").hide();
		$("#btnReturn").show();
		$("#SEARCH_PLANT").hide();
		$("#TB_APPROVE_DOC_TXT").attr("disabled", "disabled");
	}
	
    $("#return_remark").dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:170, //팝업 가로
        width: 500, //팝업 높이
        close: function(event,ui) {
            $("#return_remark").dialog( "close" );
        }
    });

}


function setInitGridView() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
  
    addField(cm,    'PO_NUMBER',         {text: '발주번호'},      80,     'text',     {textAlignment: "center"});
    addField(cm,    'PO_SEQ',            {text: '발주항번'},      70,      'text',     {textAlignment: "center"});
    addField(cm,    'MAT_TYPE_NM',       {text: '자재유형'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MAT_NUMBER',        {text: '자재코드'},      80,     'text',     {textAlignment: "center"});
    addField(cm,    'MAT_DESC',          {text: '자재내역'},      200,     'text',     {textAlignment: "near"});
    addField(cm,    'UNIT_MEASURE',      {text: '단위'},          80,     'text',     {textAlignment: "center"});
    addField(cm,    'CURR_CD',           {text: '통화'},          60,     'text',     {textAlignment: "center"});
    addField(cm,    'UNIT_PER_MEASURE',  {text: 'PER'},          60,     'number',     {textAlignment: "center"});
    
    addField(cm,    'PO_ITEM_QTY',       {text: '발주수량'},      80,     'number',     {textAlignment: "far"});
    addField(cm,    'ADD_GR_QTY',        {text: '누적입고수량'},   0,     'number',     {textAlignment: "far"}, {visible:false});
    addField(cm,    'NON_PAY_QTY',       {text: '미납수량'},      80,     'number',     {textAlignment: "far"});
    addField(cm,    'ITEM_QTY',          {text: '납품수량'},      80,     'number',     {textAlignment: "far"});
    addField(cm,    'ITEM_AMT',          {text: '금액'},         100,     'number',     {textAlignment: "far"});
    addField(cm,    'UNIT_PRICE',        {text: '단가'},         100,     'number',     {textAlignment: "far"});
    
    addField(cm,    'PRODUCT_NO',        {text: '공급업체 제품코드'},     80,      'text',     {textAlignment: "center"});
    addField(cm,    'PRODUCT_TXT',       {text: '공급업체 제품명'},     100,      'text',     {textAlignment: "center"});
    addField(cm,    'MAKER_LOT_NO',      {text: '로트번호'},     100,      'text',     {textAlignment: "center"});
    addField(cm,    'MAKER_DATE',        {text: '제조일자'},     80,      'text',     {textAlignment: "center"});
    addField(cm,    'USE_BY_DATE',       {text: '유효일자'},     80,      'text',     {textAlignment: "center"});
    addField(cm,    'BOX_WEIGHT',        {text: '박스중량(g)'},     80,      'number',     {textAlignment: "far"});    
    addField(cm,    'PRODUCT_WEIGHT',    {text: '제품중량(g)'},     80,      'number',     {textAlignment: "far"});    
    addField(cm,    'W_D_H',             {text: '가로*세로*높이'}, 100,      'text',     {textAlignment: "center"}); 
    addField(cm,    'INV_PERCENT',       {text: '초과납품허용한도(%)'}, 80,      'number',     {textAlignment: "center"});     
    addField(cm,    'INV_ITEM_QTY',      {text: '초과납품가능수량'}, 80,      'number',     {textAlignment: "far"});     
    addField(cm,    'BOX_QTY',           {text: '박스입수'},      80,     'text',     {textAlignment: "far"});
    //addField(cm,    'AREA_QTY',          {text: '배면'},          100,     'text',     {textAlignment: "center"});
    //addField(cm,    'HEIGH_QTY',         {text: '배단'},          100,     'text',     {textAlignment: "center"});
    addField(cm,    'PLT_QTY',           {text: 'PLT적재수량'},   80,     'number',     {textAlignment: "far"});
    addField(cm,    'PLT_CAL_QTY',       {text: 'PLT수량'},   80,     'number',     {textAlignment: "far"});
    
    addField(cm,    'PO_ORG',            {text: '구매조직'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PO_ORG_NM',         {text: '구매그룹명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PLANT_CODE',        {text: '플랜트'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_CD',         {text: '업체코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_NM',         {text: '업체명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MINI_EXP_PER',      {text: '최저잔존수명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'DOC_NO',            {text: '문서번호'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'DOC_SEQ',           {text: '문서일련번호'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'MAT_TYPE',          {text: '자재코드'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'COMP_NM',           {text: '회사명'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'PLANT_NM',          {text: '플랜트'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'LOCATION_TXT',      {text: '입고장소'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_DELY_DATE',      {text: '입고예정일'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_DELY_TIME',      {text: '입고예정시간'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_PERSON_NAME',    {text: '입고담당자'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'GR_PERSON_TEL',     {text: '연락처'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'VENDOR_DOC_TXT',    {text: '업체비고'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'APPROVE_DOC_TXT',   {text: '승인자비고'},      0,     'text',     {textAlignment: "center"}, {visible:false});
    
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 400       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,appendable     : true
        ,copySingle     : false // default ture : 복사하지 않음
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridView.setFixedOptions({
    	  colCount: 4
    });    
}

/**
 * 조회
 */
function fnSearch() {
	var docNo = '${PARAM.DOC_NO}';
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"TB_DOC_NO" :  docNo});
	// 조회 요청
	searchCall(gridView, '/com/wrh/selectWhrStockDueDate', null, params);
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	
	if(isNotEmpty(data.rows)){
	 	// DB에 저장된 데이터를 조회하여 화면 상단에 셋팅
		$("#TB_COMP_NM").val(data.rows[0].COMP_NM);
		$("#TB_COMP_CD").val(data.rows[0].COMP_CD);
		$("#TB_PLANT_NAME").val(data.rows[0].PLANT_NAME);
		$("#TB_PLANT_CODE").val(data.rows[0].PLANT_CODE);
		$("#TB_LOCATION_TXT").val(data.rows[0].LOCATION_TXT);
		$("#TB_LOCATION").val(data.rows[0].LOCATION);
		$("#TB_LOCATION_OLD").val(data.rows[0].LOCATION_OLD);
		$("#TB_VENDOR_CD").val(data.rows[0].VENDOR_CD);
		$("#TB_VENDOR_NM").val(data.rows[0].VENDOR_NM);
		$("#TB_PO_ORG").val(data.rows[0].PO_ORG);
		$("#TB_PO_ORG_NM").val(data.rows[0].PO_ORG_NM);
		$("#TB_GR_DELY_DATE").val(data.rows[0].GR_DELY_DATE);
		$("#TB_GR_DELY_TIME").val(data.rows[0].GR_DELY_TIME);
		$("#TB_GR_PERSON_NAME").val(data.rows[0].GR_PERSON_NAME);
		$("#TB_GR_PERSON_TEL").val(data.rows[0].GR_PERSON_TEL);
		$("#TB_DOC_NO").val(data.rows[0].DOC_NO);
		$("#TB_VENDOR_DOC_TXT").val(data.rows[0].VENDOR_DOC_TXT);
		$("#TB_APPROVE_DOC_TXT").val(data.rows[0].APPROVE_DOC_TXT);
		$("#TB_DOC_STATUS").val(data.rows[0].DOC_STATUS);
		$("#TB_IMP_MAT_YN").val(data.rows[0].IMP_MAT_YN);
	}
	
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();	
}

/**
 * 그리드의 상세보기 클릭시 이벤트
 */
function fnPlantStorageDetail(val) {
    var params = fnGetParams();
    params.SB_COMP_CD = $("#TB_COMP_CD").val();
    params.SB_COMP_NM = $("#TB_COMP_NM").val();
    var target = "sysPlantStorage";
    var width  = "970";
    var height = "670";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('/com/cmn/plantStorageList', params, target, width, height, scrollbar, resizable);
}

/**
 * 플랜트 창고 팝업 콜백
 */
function fnCallbackPlantStoagePopup(rows) {
	$("#TB_PLANT_CODE").val(rows.PLANT_CD);
	$("#TB_PLANT_NAME").val(rows.PLANT_NM);
	$("#TB_LOCATION").val(rows.STORAGE_CD);
	$("#TB_LOCATION_TXT").val(rows.STORAGE_NM);

}

//승인
var fnAppr = function(){
	gridView.commit();
	
	var params = {};
	if('${PARAM.G_MENU_CD}' == "WRH162"){
		if($("#TB_DOC_STATUS").val() != "2"){
			alert("승인요청 상태에서만 승인 가능합니다.");
			return false;
		}
	} else {
		if($("#TB_DOC_STATUS").val() != "3"){
			alert("물품반려 상태에서만 승인 가능합니다.");
			return false;
		}
	}
	
    if(confirm("승인 하시겠습니까?")){
    	var params = {};
    	$.extend(params, fnGetParams());
   		saveCall(gridView, '/com/wrh/apprReceivedDetail', "fnAppr", params);
	}

}

/**
 * 승인 성공
 */
function fnApprSuccess(result) {
	alert("승인되었습니다.");
	
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN" : "DETAIL"});
	$.extend(params, {  "STATUS_NM"     : '승인' 
		              , "VENDOR_NM"     : '${PARAM.VENDOR_NM}'
		              , "DOC_NO"        : '${PARAM.DOC_NO}'
		              , "GR_DATE_TIME"  : '${PARAM.GR_DATE_TIME}'
		              , "EMAIL_ID"      : '${PARAM.EMAIL_ID}'
		              , "MOBILE_NO"     : '${PARAM.MOBILE_NO}'
		              , "FULL_LOCATION" : '${PARAM.FULL_LOCATION}'
		              });
    saveCall(gridView, '/com/wrh/sendMail', "fnSendMail", params);
    
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 승인 실패
 */
function fnApprFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

//반려
var fnReturn = function(){
	gridView.commit();
	var params = {};
	
	if('${PARAM.G_MENU_CD}' == "WRH162"){ // 입고승인
		if($("#TB_DOC_STATUS").val() != "2"){
			alert("승인요청 상태에서만 반려 가능합니다.");
			return false;
		}
		
		if($("#TB_IMP_MAT_YN").val() == "Y"){
			alert("중요자재인 경우 반려가 불가합니다.");
			return false;
		}
	} else if('${PARAM.G_MENU_CD}' == "WRH165"){ // 입고예정관리
		if($("#TB_DOC_STATUS").val() != "5"){
			alert("승인완료 상태에서만 반려 가능합니다.");
			return false;
		}
		if($("#TB_GR_DELY_DATE").val().replaceAll("-","") <= $("#TB_SYSDATE").val().replaceAll("-","")){
			alert("입고예정일시가 미래인 데이터만 가능합니다.");
			return false;
		}
		
		
	} else {
		if($("#TB_DOC_STATUS").val() != "3"){
			alert("물품반려 상태에서만 반려 가능합니다.");
			return false;
		}
	}


    if(confirm("반려 하시겠습니까?")){
   		$("#return_remark").dialog("open");
    }
}



/**
 * 반려
 */
function fnReturnSave() {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
	$.extend(params, {"REMARK" : $("#remark_return").val()});
	saveCall(gridView, '/com/wrh/returnReceivedApprDetail', "fnReturn", params);
}

/**
 * 반려 성공
 */
function fnReturnSuccess(result) {
	alert("반려되었습니다.");
	$("#return_remark").dialog( "close" );
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"GUBN" : "DETAIL"});
	$.extend(params, {  "STATUS_NM"     : '반려' 
		              , "VENDOR_NM"     : '${PARAM.VENDOR_NM}'
		              , "DOC_NO"        : '${PARAM.DOC_NO}'
		              , "GR_DATE_TIME"  : '${PARAM.GR_DATE_TIME}'
		              , "EMAIL_ID"      : '${PARAM.EMAIL_ID}'
		              , "MOBILE_NO"     : '${PARAM.MOBILE_NO}'
		              , "FULL_LOCATION" : '${PARAM.FULL_LOCATION}'
		              });
    saveCall(gridView, '/com/wrh/sendMail', "fnSendMail", params);

    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 반려 실패
 */
function fnReturnFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    gridView.closeProgress();
}

</script>
<div class="tit-area">
    <h3>입고예정상세</h3>
</div>
<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:100px">
                <col style="width:450px">
                <col style="width:120px">
                <col style="width:430px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><span>회사</span></th>
                    <td>
                    	<input type="text" id="TB_COMP_NM" name="TB_COMP_NM" value="" readonly="readonly"/>
                    	<input type="hidden" id="TB_COMP_CD" name="TB_COMP_CD" value="">
                    </td>
                    <th><span>플랜트</span></th>
                    <td>
                    	<input type="text" id="TB_PLANT_NAME" name="TB_PLANT_NAME" value="" readonly="readonly"/>
                    	<input type="hidden" id="TB_PLANT_CODE" name="TB_PLANT_CODE" value="">
                    </td>
					<th><span>입고장소</span></th>
                    <td>
                    	<input type="text" id="TB_LOCATION_TXT" name="TB_LOCATION_TXT" value="" readonly="readonly"/>
                    	<input type="hidden" id="TB_LOCATION" name="TB_LOCATION" value="">
                    	<input type="hidden" id="TB_LOCATION_OLD" name="TB_LOCATION_OLD" value="">
                    	<a id="SEARCH_PLANT" href="javascript:fnPlantStorageDetail();" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
                    </td>
                    <td>
                    	<input type="hidden" id="TB_PO_ORG"     name="TB_PO_ORG" value="">
                    	<input type="hidden" id="TB_PO_ORG_NM"  name="TB_PO_ORG_NM" value="">
                    	<input type="hidden" id="TB_DOC_STATUS" name="TB_DOC_STATUS" value="">
                    	<input type="hidden" id="TB_IMP_MAT_YN" name="TB_IMP_MAT_YN" value="">
                    </td>
                </tr>            
                <tr>
                    <th><span>업체</span></th>
                    <td>
                        <input type="text" id="TB_VENDOR_CD"	style="width: 70px;" 	readonly="readonly"/>
                        <input type="text" id="TB_VENDOR_NM"	style="width: 150px;"	readonly="readonly"/>
                    </td>
                    <th><span>입고예정일</span></th>
                    <td>
                    	<input type="text" id="TB_GR_DELY_DATE"	style="width: 150px;"	readonly="readonly"/>
                    	<input type="hidden" id="TB_SYSDATE"/>
                    </td>
                    <th><span>입고예정시간</span></th>
                    <td>
                        <input type="text"  id="TB_GR_DELY_TIME" readonly="readonly"/>
                    </td>                    
                    <td></td>
                </tr>
                <tr>
                    <th><span>입고담당자</span></th>
                    <td>
                        <input type="text"  id="TB_GR_PERSON_NAME" readonly="readonly"/>
                    </td>
                    <th><span>연락처</span></th>
                    <td>
                        <input type="text"  id="TB_GR_PERSON_TEL" readonly="readonly"/>
                    </td>
                    <th><span>문서번호</span></th>
                    <td>
                        <input type="text"  id="TB_DOC_NO" value="" readonly="readonly"/>
                    </td>
                    <td></td>
                </tr>
				<tr>
					<th><span>업체비고</span></th>
					<td colspan="3">
						<textarea rows="1" id="TB_VENDOR_DOC_TXT" disabled=""></textarea>
					</td>
					<td></td>
				</tr>                                
				<tr>
					<th><span>승인자비고</span></th>
					<td colspan="3">
						<textarea rows="1" id="TB_APPROVE_DOC_TXT" disabled=""></textarea>
					</td>
					<td></td>
				</tr>                                
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
</div><!-- // search_field_wrap -->
<div class="sub-tit">
    <div class="btnArea t_right">
        <button type="button" class="btn" id="btnReturn" hidden="true">반려</button>
        <button type="button" class="btn" id="btnAppr"   hidden="true">승인</button>
    </div>
</div>
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>

<div id="return_remark" title="반려">
    <table class="tbl-view">
        <colgroup>
          <col style="width:30%;">
          <col>
        </colgroup>
       <tbody>
            <tr>
                <th>반려사유</th>
                <td>
	                <input type="text" id="remark_return" name="remark_return" class="wp100" maxlength="100" onkeypress="if(event.keyCode==13){fnReturnSave();}" />
                </td>
                
            </tr>       
      </tbody>
    </table>
    <br>
    <div align="center">
        <button type="button" class="btn" onClick="javascript:fnReturnSave();">확인</button>
    </div>
</div>