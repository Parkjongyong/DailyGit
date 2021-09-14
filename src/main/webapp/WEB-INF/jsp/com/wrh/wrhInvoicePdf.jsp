<%--
	File Name : wrhInvoiceInfo.jsp
	Description: 입고예정 > 마감정보 > 송장마감정보
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.07.17  박종용            최초 생성
	-----------------------------------------------
	author: 박종용
	since: 2020.07.17
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
</div>

<div class="layout-box">
	<div class="layout-left" style="padding-right:380px; padding-left:15px;">
 		<textarea rows="4">입고장소&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%="\r\n"%>입고일시&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<%="\r\n"%>입고담당자&nbsp;&nbsp;:<%="\r\n"%>연락처&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</textarea>
	</div>
	<div class="layout-right" style="padding-left:325px; padding-right:15px;">
		<div style="border:1px solid #ddd; height:71px;">
			<table class="tbl-view">
				<colgroup>
					<col style="width:30%;">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align:center">문서번호</th>
						<td style="height:60px;"></td>
					</tr>
				</tbody>			
			</table>
		</div>
	</div>
</div>
<div class="pop-cont">
	<table class="tbl-view">
		<colgroup>
			<col style="width:100px">
			<col style="width:100px">
			<col style="width:150px">
			<col style="width:50px">
			<col style="width:100px">
			<col style="width:100px">
			<col style="width:100px">
			<col style="width:150px">
			<col style="width:50px">
			<col style="width:100px">
		</colgroup>
		<tbody>
			<tr>
				<th style="text-align:center" rowspan="2">공급받는자</th>
				<th style="text-align:center">사업자번호</th>
				<td colspan="3"></td>
				<th style="text-align:center" rowspan="2">공급자</th>
				<th style="text-align:center">사업자번호</th>
				<td colspan="3"></td>
			</tr>
			<tr>
				<th style="text-align:center">상호</th>
				<td></td>
				<th style="text-align:center">성명</th>
				<td></td>
				<th style="text-align:center">상호</th>
				<td></td>
				<th style="text-align:center">성명</th>
				<td></td>				
			</tr>			
		</tbody>
	</table>
</div><!-- //popCont -->

<div class="pop-cont">
	<table class="tbl-view">
		<colgroup>
			<col style="width:30px">  <!-- 순번 -->
			<col style="width:100px"> <!-- 발주번호 -->
			<col style="width:80px">  <!-- 발주항번-->
			<col style="width:80px">  <!-- 자재코드 -->
			<col style="width:100px"> <!-- 자재내역 -->
			<col style="width:60px">  <!-- 단위 -->
			<col style="width:60px">  <!-- 수량 -->
			<col style="width:80px">  <!-- 단가 -->
			<col style="width:80px">  <!-- 금액 -->
			<col style="width:80px">  <!-- 표시자재버전 -->
			<col style="width:80px">  <!-- 제조원배치번호 -->
			<col style="width:80px">  <!-- 제조일자 -->
			<col style="width:80px">  <!-- 유효일자 -->
			<col style="width:80px">  <!-- 박스입수 -->
			<col style="width:80px">  <!-- 박스수량 -->
		</colgroup>
		<tbody>
			<tr>
				<th style="text-align:center">순번</th>
				<th style="text-align:center">발주번호</th>
				<th style="text-align:center">발주항번</th>
				<th style="text-align:center">자재코드</th>
				<th style="text-align:center">자재내역</th>
				<th style="text-align:center">단위</th>
				<th style="text-align:center">수량</th>
				<th style="text-align:center">단가</th>
				<th style="text-align:center">금액</th>
				<th style="text-align:center">표시자재버전</th>
				<th style="text-align:center">제조원배치번호</th>
				<th style="text-align:center">제조일자</th>
				<th style="text-align:center">유효일자</th>
				<th style="text-align:center">박스입수</th>
				<th style="text-align:center">박스수량</th>
			</tr>		
			<tr>
				<td style="text-align:center">1</td>
				<td style="text-align:center">1</td>
				<td style="text-align:center">1</td>
				<td>1</td>
				<td>1</td>
				<td style="text-align:center">1</td>
				<td style="text-align:right">1</td>
				<td style="text-align:right">1</td>
				<td style="text-align:right">1</td>
				<td style="text-align:center">1</td>
				<td style="text-align:center">1</td>
				<td style="text-align:center">1</td>
				<td style="text-align:center">1</td>
				<td style="text-align:right">1</td>
				<td style="text-align:right">1</td>
			</tr>
			<tr>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">3</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">4</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">5</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">6</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">7</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">8</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">9</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">10</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">11</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
			<tr>
				<td style="text-align:center">12</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td>2</td>
				<td>2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:center">2</td>
				<td style="text-align:right">2</td>
				<td style="text-align:right">2</td>
			</tr>
		</tbody>
	</table>
</div>
<div class="pop-cont">
	<table class="tbl-view">
		<colgroup>
			<col style="width:100px">
			<col style="width:500px">
			<col style="width:100px">
			<col style="width:500px">
		</colgroup>
		<tbody>
			<tr>
				<th style="text-align:center">비고</th>
				<td></td>
				<th style="text-align:center">인수자</th>
				<td></td>
			</tr>
		</tbody>
	</table>
</div>	