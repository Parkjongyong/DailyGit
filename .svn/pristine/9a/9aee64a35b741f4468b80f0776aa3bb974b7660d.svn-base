<%--
	File Name : bdgEstCostReq.jsp
	Description: 예산 > 예산관리 > 원가검토의뢰(의뢰내용)
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.11.06  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.11.06
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">

var seqNo = "";

$(document).ready(function() {
	var requestItem  = stringToArray("${REQUESTITEM1}");
	fnMakeComboOption('SB_ITEM_TYPE', requestItem,  'CODE', 'CODE_NM');
	
	// 초기 상태값 처리
    fnInitStatus();
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    fnChangeItem();
    fnSearch();

});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// 년도 셋팅
	$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
	$("#TB_ORG_CD").val('${PARAM.TB_ORG_CD}');
	$("#TB_REQ_DOC_NO").val('${PARAM.REQ_DOC_NO}');
	if(isNotEmpty('${PARAM.CTRN_YMD}')){
		$("#TB_CTRN_YMD").val('${PARAM.CTRN_YMD}');	
	} else {
		$("#TB_CTRN_YMD").val(getDiffDay("m",0).replaceAll('-',''));
	}
	
	
	if('${PARAM.STATUS}' == '1' || isEmpty('${PARAM.STATUS}')){
		$("#btnSave").css('visibility','visible');
		$("#btnDelete").css('visibility','visible');
	} else {
		$("#btnSave").css('visibility','hidden');
		$("#btnDelete").css('visibility','hidden');
	}
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(null, '/com/bdg/selectEstCostReqDetail');
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	if(isNotEmpty(data.rows)){
		$("#TB_DOC_TITLE").val(data.rows[0].DOC_TITLE);
		
		$("#SB_ITEM_TYPE").val(data.rows[0].ITEM_TYPE);
		
	    var distribList = stringToArray("${REQUESTITEM2}", $("#SB_ITEM_TYPE").val());
	    fnMakeComboOption('SB_DISTRIB_TYPE', distribList, 'CODE', 'CODE_NM');
		
		$("#SB_DISTRIB_TYPE").val(data.rows[0].DISTRIB_TYPE);
		
	    var reqList = stringToArray("${REQUESTITEM3}", $("#SB_ITEM_TYPE").val(), $("#SB_DISTRIB_TYPE").val());
	    fnMakeComboOption('SB_REQ_TYPE', reqList, 'CODE', 'CODE_NM');
		
		$("#SB_REQ_TYPE").val(data.rows[0].REQ_TYPE);
		
		$("#TB_REQ_CODE").val(data.rows[0].REQ_CODE);
		$("#TB_PRODUCT_NM").val(data.rows[0].PRODUCT_NM);
		$("#TB_SALE_QTY").val(data.rows[0].SALE_QTY);
		$("#TB_USE_TYPE").val(data.rows[0].USE_TYPE);
		$("#TB_NEED_DATE").val(data.rows[0].NEED_DATE);
		$("#TB_REFER_PRODUCT").val(data.rows[0].REFER_PRODUCT);
		$("#TB_REQ_DOC_NO").val(data.rows[0].REQ_DOC_NO);
		
		if(data.rows[0].PACK_TYPE == "1"){
			$('input:radio[name="RD_PACK_TYPE"][value="1"]').prop('checked', true);
		} else if(data.rows[0].PACK_TYPE == "2"){
			$('input:radio[name="RD_PACK_TYPE"][value="2"]').prop('checked', true);
		} else if(data.rows[0].PACK_TYPE == "3"){
			$('input:radio[name="RD_PACK_TYPE"][value="3"]').prop('checked', true);
		} else if(data.rows[0].PACK_TYPE == "4"){
			$('input:radio[name="RD_PACK_TYPE"][value="4"]').prop('checked', true);
		} else if(data.rows[0].PACK_TYPE == "5"){
			$('input:radio[name="RD_PACK_TYPE"][value="5"]').prop('checked', true);
		} else if(data.rows[0].PACK_TYPE == "6"){
			$('input:radio[name="RD_PACK_TYPE"][value="6"]').prop('checked', true);
		}
		
		$("#TB_PACK_WAY").val(data.rows[0].PACK_WAY);
		
		
		$("#TB_ETC_DESC").val(data.rows[0].ETC_DESC);
		
		for(var i = 0; i < 10; i++){
			$("#TB_STAND_DESC" + i).val("");
		}		
		
		for(var i = 0; i < data.rows.length; i++){
			$("#TB_STAND_DESC" + i).val(data.rows[i].STAND_DESC);
		}		
	}

	
}

//삭제
function fnDelete() {
	
	var params = {};
	$.extend(params, fnGetParams());
	
	if(confirm("삭제 하시겠습니까?")){
		deleteCall(null, '/com/bdg/deleteEstCostDetail', 'fnDelete', params);
	}
	
}

/**
 * 삭제 성공
 */
function fnDeleteSuccess(result) {
	alert("삭제 하였습니다.");
	window.opener.location.reload();
    window.close();
    
}

/**
 * 삭제 실패
 */
function fnDeleteFail(result) {
	alert(result.errMsg);
}

/**
 * 견적내용
 */
function fnResult() {
	var params = {};
	$.extend(params, fnGetParams());
	var target    = "bdgEstCostResult";
	var width     = "1400";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
 	fnPostPopup('/com/bdg/bdgEstCostResult', params, target, width, height, scrollbar, resizable);

}

/**
 * 품목분류 체인지 이벤트
 */
function fnChangeItem() {
    var distribList = stringToArray("${REQUESTITEM2}", $("#SB_ITEM_TYPE").val());
    fnMakeComboOption('SB_DISTRIB_TYPE', distribList, 'CODE', 'CODE_NM');
    fnChangeDistrib();
}

/**
 * 유통분류 체인지 이벤트
 */
function fnChangeDistrib() {
    var reqList = stringToArray("${REQUESTITEM3}", $("#SB_ITEM_TYPE").val(), $("#SB_DISTRIB_TYPE").val());
    fnMakeComboOption('SB_REQ_TYPE', reqList, 'CODE', 'CODE_NM');
}

/**
 * 저장
 */
function fnSave() {
	
	// 필수 체크 대상
	var requiredVal   = ["TB_DOC_TITLE", "SB_ITEM_TYPE", "SB_DISTRIB_TYPE", "SB_REQ_TYPE"];
	
	if(isEmpty($("#TB_STAND_DESC0").val()) == true){
		alert("규격 한건은 필수입력입니다.");
		return false;
	}

	if(fnSaveCheckTable(requiredVal) == true){
		if(confirm("저장 하시겠습니까?")){
			var params = {};
			$.extend(params, fnGetParams());
			saveCall(null, '/com/bdg/saveEstCostReq', 'fnSave', params);
		}
	}
	
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
	fnSearch();
	$("#TB_REQ_DOC_NO").val(result.fields.result.TB_REQ_DOC_NO);
	$("#TB_CTRN_YMD").val(result.fields.result.TB_CTRN_YMD);
	//window.opener.location.reload();
    //window.close();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
}

/**
 * 견적내용 팝업
 */
function fnEstCostDetailSap(num) {
	seqNo = num;
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SEQ_NO" : num});
	searchCall(null, '/com/bdg/selectEstCostCnt', 'fnEstCostDetailSap', params);
}


function fnEstCostDetailSapSuccess(data) {
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SEQ_NO" : seqNo});
	var target    = "bdgEstCostDetailResult";
	var width     = "1200";
	var height    = "800";
    var scrollbar = "yes";
    var resizable = "yes";
	
    if(isEmpty(data.fields)){
		alert("견적내용이 존재하지 않습니다.");
		return false;
    } else if(data.fields.CNT == '1'){
		width = "600";
	} else if(data.fields.CNT == '2'){
		width = "900";
	} else if(data.fields.CNT == '3'){
		width = "1200";
	} 
	
 	fnPostPopup('/com/bdg/bdgEstCostDetailResult', params, target, width, height, scrollbar, resizable);
	
}

</script>
<input type="hidden" name="SB_COMP_CD" id="SB_COMP_CD">
<input type="hidden" name="TB_ORG_CD" id="TB_ORG_CD">
<input type="hidden" name="TB_CTRN_YMD" id="TB_CTRN_YMD">

	<section class="pop-wrap" style="width:70%; float:left;">
		<div class="pop-cont">
			<div class="sub-tit">
				<h4>의뢰내용</h4>
			</div>

			<table class="tbl-view">
				<colgroup>
					<col style="width:15%">
					<col style="width:85%">
				</colgroup>
				<tbody>
					<tr>
						<th id="TB_REQ_DOC_NO_H">견적번호</th>
						<td>
							<input type="text" class="w70"name="TB_REQ_DOC_NO" id="TB_REQ_DOC_NO" disabled="disabled">
						</td>
					</tr>
					<tr>
						<th id="TB_DOC_TITLE_H">제목</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_DOC_TITLE" id="TB_DOC_TITLE">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H">품목분류</th>
						<td>
							<select name="SB_ITEM_TYPE" id="SB_ITEM_TYPE" onchange="fnChangeItem()"></select>
						</td>

					</tr>
					<tr>
						<th id="SB_DISTRIB_TYPE_H">유통분류</th>
						<td>
							<select name="SB_DISTRIB_TYPE" id="SB_DISTRIB_TYPE" onchange="fnChangeDistrib()"></select>
						</td>

					</tr>
					<tr>
						<th id="SB_REQ_TYPE_H">견적유형</th>
						<td>
							<select name="SB_REQ_TYPE" id="SB_REQ_TYPE"></select>
						</td>

					</tr>
					<tr>
						<th>CODE</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_REQ_CODE" id="TB_REQ_CODE">
						</td>

					</tr>
					<tr>
						<th>제품명</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_PRODUCT_NM" id="TB_PRODUCT_NM">
						</td>

					</tr>
					<tr>
						<th>년판매량</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_SALE_QTY" id="TB_SALE_QTY">
						</td>

					</tr>
					<tr>
						<th>사용용도</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_USE_TYPE" id="TB_USE_TYPE">
						</td>

					</tr>
					<tr>
						<th>필요시기</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_NEED_DATE" id="TB_NEED_DATE">
						</td>

					</tr>
					<tr>
						<th>기존참고제품</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_REFER_PRODUCT" id="TB_REFER_PRODUCT">
						</td>

					</tr>
					<tr>
						<th>포장형태</th>
						<td>
	                    	<input type="radio" id="RD_PACK_TYPE1" name="RD_PACK_TYPE" value="1">
	                    	<label for="RD_PACK_TYPE1">Blister&nbsp;&nbsp;</label>
	                    	<input type="radio" id="RD_PACK_TYPE2" name="RD_PACK_TYPE" value="2">
	                    	<label for="RD_PACK_TYPE2">Pack&nbsp;&nbsp;</label>                    	
	                    	<input type="radio" id="RD_PACK_TYPE3" name="RD_PACK_TYPE" value="3">
	                    	<label for="RD_PACK_TYPE3">용기&nbsp;&nbsp;</label>                    	
	                    	<input type="radio" id="RD_PACK_TYPE4" name="RD_PACK_TYPE" value="4">
	                    	<label for="RD_PACK_TYPE4">Bottle&nbsp;&nbsp;</label>                    	
	                    	<input type="radio" id="RD_PACK_TYPE5" name="RD_PACK_TYPE" value="5">
	                    	<label for="RD_PACK_TYPE5">S.P&nbsp;&nbsp;</label>                    	
	                    	<input type="radio" id="RD_PACK_TYPE6" name="RD_PACK_TYPE" value="6">
	                    	<label for="RD_PACK_TYPE6">기타&nbsp;&nbsp;</label>						
						</td>
					</tr>
					<tr>
						<th>포장방법</th>
						<td>
                    		<input type="text" style="width: 100%;" name="TB_PACK_WAY" id="TB_PACK_WAY">
						</td>

					</tr>
					<tr>
						<th>기타참고사항</th>
						<td>
							<input type="text" style="width: 100%;" name="TB_ETC_DESC" id="TB_ETC_DESC">
						</td>

					</tr>

				</tbody>
			</table>
		</div><!-- //popCont -->
	</section>
	
	
	<section class="pop-wrap" style="width:30%; float:left;">
		<div class="pop-cont">
		<br>
		    <div class="btnArea t_right" style="padding-bottom: 3px">
		        <button type="button" class="btn" id="btnDelete">삭제</button>
		        <button type="button" class="btn" id="btnSave">저장</button>
		    </div>
		    

			<table class="tbl-view">
				<colgroup>
					<col style="width:20%">
					<col style="width:80%">
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align: center">순번</th>
						<th style="text-align: center">규격</th>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC0_H">0</th>
						<td>
							<input type="text" name="TB_STAND_DESC0" id="TB_STAND_DESC0" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('0');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC1_H">1</th>
						<td>
							<input type="text" name="TB_STAND_DESC1" id="TB_STAND_DESC1" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('1');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC2_H">2</th>
						<td>
							<input type="text" name="TB_STAND_DESC2" id="TB_STAND_DESC2" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('2');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC3_H">3</th>
						<td>
							<input type="text" name="TB_STAND_DESC3" id="TB_STAND_DESC3" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('3');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC4_H">4</th>
						<td>
							<input type="text" name="TB_STAND_DESC4" id="TB_STAND_DESC4" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('4');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC5_H">5</th>
						<td>
							<input type="text" name="TB_STAND_DESC5" id="TB_STAND_DESC5" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('5');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC6_H">6</th>
						<td>
							<input type="text" name="TB_STAND_DESC6" id="TB_STAND_DESC6" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('6');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC7_H">7</th>
						<td>
							<input type="text" name="TB_STAND_DESC7" id="TB_STAND_DESC7" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('7');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC8_H">8</th>
						<td>
							<input type="text" name="TB_STAND_DESC8" id="TB_STAND_DESC8" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('8');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
					<tr>
						<th style="text-align: center" id="TB_STAND_DESC9_H">9</th>
						<td>
							<input type="text" name="TB_STAND_DESC9" id="TB_STAND_DESC9" style="width: 87%;">
							<a href="javascript:fnEstCostDetailSap('9');" style="background:url(../../../resources/images/common/search_icon_b.png) no-repeat 20%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
						</td>
					</tr>
				</tbody>
			</table>
		</div><!-- //popCont -->
	</section>