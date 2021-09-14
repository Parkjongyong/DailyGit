<%--
	File Name : wrhStockStatusDetail.jsp
	Description: 입고예정 > 발주/입고 > 입고현황 > 입고현황상세
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.17  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.07.17
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

</script>
	<section class="pop-wrap">
		<div class="pop-head">
			<h2>입고현황상세</h2>
		</div><!-- //popHead -->	

		<div class="pop-cont">
			<div class="sub-tit">
				<h4>기본내용</h4>
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
						<th>업체코드</th>
						<td>${PARAM.VENDOR_CD}</td>
						<th>업체명</th>
						<td>${PARAM.VENDOR_NM}</td>
					</tr>
					<tr>
						<th>입고번호</th>
						<td>${PARAM.GR_NUMBER}</td>
						<th>입고항번</th>
						<td>${PARAM.GR_SEQ}</td>
					</tr>
					<tr>
						<th>입고년도</th>
						<td>${PARAM.GR_YEAR}</td>
						<th>입고일자</th>
						<td>${PARAM.GR_DATE}</td>
					</tr>
					<tr>
						<th>이동유형</th>
						<td>${PARAM.MV_TXT}</td>
						<th>입고장소</th>
						<td>${PARAM.LOCATION_TXT}</td>
					</tr>
					<tr>
						<th>단위</th>
						<td>${PARAM.UNIT_MEASURE}</td>
						<th>통화</th>
						<td>${PARAM.CURR_CD}</td>
					</tr>
					<tr>
						<th>입고수량</th>
						<td>${PARAM.ITEM_QTY}</td>
						<th>입고금액</th>
						<td>${PARAM.GR_AMT}</td>
					</tr>
					<tr>
						<th>자재코드</th>
						<td>${PARAM.MAT_NUMBER}</td>
						<th>자재내역</th>
						<td>${PARAM.MAT_DESC}</td>
					</tr>
					<tr>
						<th>원입고번호</th>
						<td>${PARAM.BFR_GR_NUMBER}</td>
						<th>원입고항번</th>
						<td>${PARAM.BFR_GR_SEQ}</td>
					</tr>
					<tr>
						<th>원입고년도</th>
						<td>${PARAM.BFR_GR_YY}</td>
						<th>배치번호</th>
						<td>${PARAM.BATCH_NO}</td>
					</tr>
				</tbody>
			</table>
		</div><!-- //popCont -->
	</section>
