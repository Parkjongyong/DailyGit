<%--
	File Name : wrhOrderStatusDetailOne.jsp
	Description: 입고예정 > 발주/입고 > 발주현황(발주현황상세) > 발주품목상세
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.16  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.16
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript">

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	// 초기 상태값 처리
    fnInitStatus();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	
}


/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
}

</script>
	<section class="pop-wrap">
		<div class="pop-head">
			<h2>발주현황</h2>
		</div><!-- //popHead -->	

		<div class="pop-cont">
			<div class="sub-tit">
				<h4>발주품목상세</h4>
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
						<th>발주번호</th>
						<td>${PARAM.PO_NUMBER}</td>
						<th>발주항번</th>
						<td>${PARAM.PO_SEQ}</td>
					</tr>
					<tr>
						<th>발주일자</th>
						<td>${PARAM.PO_CREATE_DATE}</td>
						<th>자재그룹</th>
						<td>${PARAM.MAT_GROUP_DESC}</td>
					</tr>
					<tr>
						<th>자재번호</th>
						<td>${PARAM.MAT_NUMBER}</td>
						<th>자재내역</th>
						<td>${PARAM.MAT_DESC}</td>
					</tr>
					<tr>
						<th>단위 / PER</th>
						<td>${PARAM.UNIT_MEASURE} / ${PARAM.UNIT_PER_MEASURE}</td>
						<th>발주수량</th>
						<td>${PARAM.H_ITEM_QTY}</td>
					</tr>
					<tr>
						<th>구매단가</th>
						<td>${PARAM.H_UNIT_PRICE}</td>
						<th>발주금액</th>
						<td>${PARAM.H_ITEM_AMT}</td>
					</tr>
					<tr>
						<th>플랜트</th>
						<td>${PARAM.PLANT_NM}</td>
						<th>저장위치</th>
						<td>${PARAM.LOCATION_TXT}</td>
					</tr>
					<tr>
						<th>납품완료여부</th>
						<td>${PARAM.COMPLETE_YN}</td>
						<th>반품여부</th>
						<td>${PARAM.RETURN_ORDER_FLAG_NM}</td>
					</tr>
					<tr>
						<th>무상유무</th>
						<td>${PARAM.NO_CHARGE_FLAG_NM}</td>
						<th>초과납품허용율</th>
						<td>${PARAM.INV_PERCENT}</td>
					</tr>
					<tr>
						<th>표시자재버전</th>
						<td>${PARAM.REVLV}</td>
						<th>발주변경일</th>
						<td>${PARAM.PO_CHG_DATE}</td>
					</tr>
					<tr>
						<th>제조원</th>
						<td>${PARAM.MAKER_NAME}</td>
						<th>납품요청일</th>
						<td>${PARAM.RD_DATE}</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th>박스입수</th> -->
<%-- 						<td>${PARAM.BOX_QTY}</td> --%>
<!-- 						<th>배면</th> -->
<%-- 						<td>${PARAM.AREA_QTY}</td> --%>
<!-- 					</tr> -->
<!-- 					<tr> -->
<!-- 						<th>배단</th> -->
<%-- 						<td>${PARAM.HEIGH_QTY}</td> --%>
<!-- 						<th>PLT적재수량</th> -->
<%-- 						<td>${PARAM.H_PLT_QTY}</td> --%>
<!-- 					</tr> -->
					<tr>
						<th>비고</th>
						<td colspan="3">
							<textarea rows="5" disabled="disabled"></textarea>
						</td>
					</tr>
				</tbody>
			</table>
		</div><!-- //popCont -->
	</section>
