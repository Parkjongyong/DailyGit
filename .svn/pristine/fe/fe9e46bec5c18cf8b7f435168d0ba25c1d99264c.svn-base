<%--
	File Name : bdgEstCostReq.jsp
	Description: 예산 > 예산관리 > 원가검토의뢰 > 의뢰내용 > 견적내용 
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

$(document).ready(function() {
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
}


/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	var params = {};
	$.extend(params, fnGetParams());
	$.extend(params, {"SB_COMP_CD" : '${PARAM.SB_COMP_CD}', "TB_REQ_DOC_NO" : '${PARAM.TB_REQ_DOC_NO}', "SEQ_NO" : '${PARAM.SEQ_NO}' });
	
	searchCall(null, '/com/bdg/selectEstCostReqDetailResult', 'fnSearch', params);
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	$("#col1").css("width","0px")
	$("#col2").css("width","0px")
	$("#col3").css("width","0px")
    $.each(data.rows, function(index,item){
        if(item.REQ_GUBN == "1"){ // 견적원가
        	$("#col1").css("width","200px")
        	$("#header1").text("견적원가");
            $("#TB_MAT_NUMBER").html('<input type="hidden" value="'+item.MAT_NUMBER+'" />'+item.MAT_NUMBER);
            $("#TB_MAT_DESC").html('<input type="hidden"   value="'+item.MAT_DESC+'" />'+item.MAT_DESC);
            $("#TB_REQ_AMT01_1").html('<input type="hidden" value="'+item.REQ_AMT01+'" />'+item.REQ_AMT01);        
            $("#TB_REQ_AMT02_1").html('<input type="hidden" value="'+item.REQ_AMT02+'" />'+item.REQ_AMT02);        
            $("#TB_REQ_AMT03_1").html('<input type="hidden" value="'+item.REQ_AMT03+'" />'+item.REQ_AMT03);        
            $("#TB_REQ_AMT04_1").html('<input type="hidden" value="'+item.REQ_AMT04+'" />'+item.REQ_AMT04);        
            $("#TB_REQ_AMT05_1").html('<input type="hidden" value="'+item.REQ_AMT05+'" />'+item.REQ_AMT05);        
            $("#TB_REQ_AMT06_1").html('<input type="hidden" value="'+item.REQ_AMT06+'" />'+item.REQ_AMT06);        
            $("#TB_REQ_AMT07_1").html('<input type="hidden" value="'+item.REQ_AMT07+'" />'+item.REQ_AMT07);        
            $("#TB_REQ_AMT08_1").html('<input type="hidden" value="'+item.REQ_AMT08+'" />'+item.REQ_AMT08);        
            $("#TB_REQ_AMT09_1").html('<input type="hidden" value="'+item.REQ_AMT09+'" />'+item.REQ_AMT09);        
            $("#TB_REQ_AMT10_1").html('<input type="hidden" value="'+item.REQ_AMT10+'" />'+item.REQ_AMT10);        
            $("#TB_REQ_AMT11_1").html('<input type="hidden" value="'+item.REQ_AMT11+'" />'+item.REQ_AMT11);        
            $("#TB_REQ_AMT12_1").html('<input type="hidden" value="'+item.REQ_AMT12+'" />'+item.REQ_AMT12);        
            $("#TB_REQ_AMT13_1").html('<input type="hidden" value="'+item.REQ_AMT13+'" />'+item.REQ_AMT13);        
            $("#TB_REQ_AMT14_1").html('<input type="hidden" value="'+item.REQ_AMT14+'" />'+item.REQ_AMT14);        
            $("#TB_REQ_AMT15_1").html('<input type="hidden" value="'+item.REQ_AMT15+'" />'+item.REQ_AMT15);
            $("#TB_REQ_AMT16_1").html('<input type="hidden" value="'+item.REQ_AMT16+'" />'+item.REQ_AMT16);                	
        } else if(item.REQ_GUBN == "2") { // 비즈니스모델1
        	$("#header2").text("비즈니스모델1");
        	$("#col2").css("width","200px")
            $("#TB_MAT_NUMBER").html('<input type="hidden" value="'+item.MAT_NUMBER+'" />'+item.MAT_NUMBER);
            $("#TB_MAT_DESC").html('<input type="hidden"   value="'+item.MAT_DESC+'" />'+item.MAT_DESC);
            $("#TB_REQ_AMT01_2").html('<input type="hidden" value="'+item.REQ_AMT01+'" />'+item.REQ_AMT01);        
            $("#TB_REQ_AMT02_2").html('<input type="hidden" value="'+item.REQ_AMT02+'" />'+item.REQ_AMT02);        
            $("#TB_REQ_AMT03_2").html('<input type="hidden" value="'+item.REQ_AMT03+'" />'+item.REQ_AMT03);        
            $("#TB_REQ_AMT04_2").html('<input type="hidden" value="'+item.REQ_AMT04+'" />'+item.REQ_AMT04);        
            $("#TB_REQ_AMT05_2").html('<input type="hidden" value="'+item.REQ_AMT05+'" />'+item.REQ_AMT05);        
            $("#TB_REQ_AMT06_2").html('<input type="hidden" value="'+item.REQ_AMT06+'" />'+item.REQ_AMT06);        
            $("#TB_REQ_AMT07_2").html('<input type="hidden" value="'+item.REQ_AMT07+'" />'+item.REQ_AMT07);        
            $("#TB_REQ_AMT08_2").html('<input type="hidden" value="'+item.REQ_AMT08+'" />'+item.REQ_AMT08);        
            $("#TB_REQ_AMT09_2").html('<input type="hidden" value="'+item.REQ_AMT09+'" />'+item.REQ_AMT09);        
            $("#TB_REQ_AMT10_2").html('<input type="hidden" value="'+item.REQ_AMT10+'" />'+item.REQ_AMT10);        
            $("#TB_REQ_AMT11_2").html('<input type="hidden" value="'+item.REQ_AMT11+'" />'+item.REQ_AMT11);        
            $("#TB_REQ_AMT12_2").html('<input type="hidden" value="'+item.REQ_AMT12+'" />'+item.REQ_AMT12);        
            $("#TB_REQ_AMT13_2").html('<input type="hidden" value="'+item.REQ_AMT13+'" />'+item.REQ_AMT13);        
            $("#TB_REQ_AMT14_2").html('<input type="hidden" value="'+item.REQ_AMT14+'" />'+item.REQ_AMT14);        
            $("#TB_REQ_AMT15_2").html('<input type="hidden" value="'+item.REQ_AMT15+'" />'+item.REQ_AMT15);
            $("#TB_REQ_AMT16_2").html('<input type="hidden" value="'+item.REQ_AMT16+'" />'+item.REQ_AMT16);               	
        } else {
        	$("#col3").css("width","200px")
        	$("#header3").text("비즈니스모델2");
            $("#TB_MAT_NUMBER").html('<input type="hidden" value="'+item.MAT_NUMBER+'" />'+item.MAT_NUMBER);
            $("#TB_MAT_DESC").html('<input type="hidden"   value="'+item.MAT_DESC+'" />'+item.MAT_DESC);
            $("#TB_REQ_AMT01_3").html('<input type="hidden" value="'+item.REQ_AMT01+'" />'+item.REQ_AMT01);        
            $("#TB_REQ_AMT02_3").html('<input type="hidden" value="'+item.REQ_AMT02+'" />'+item.REQ_AMT02);        
            $("#TB_REQ_AMT03_3").html('<input type="hidden" value="'+item.REQ_AMT03+'" />'+item.REQ_AMT03);        
            $("#TB_REQ_AMT04_3").html('<input type="hidden" value="'+item.REQ_AMT04+'" />'+item.REQ_AMT04);        
            $("#TB_REQ_AMT05_3").html('<input type="hidden" value="'+item.REQ_AMT05+'" />'+item.REQ_AMT05);        
            $("#TB_REQ_AMT06_3").html('<input type="hidden" value="'+item.REQ_AMT06+'" />'+item.REQ_AMT06);        
            $("#TB_REQ_AMT07_3").html('<input type="hidden" value="'+item.REQ_AMT07+'" />'+item.REQ_AMT07);        
            $("#TB_REQ_AMT08_3").html('<input type="hidden" value="'+item.REQ_AMT08+'" />'+item.REQ_AMT08);        
            $("#TB_REQ_AMT09_3").html('<input type="hidden" value="'+item.REQ_AMT09+'" />'+item.REQ_AMT09);        
            $("#TB_REQ_AMT10_3").html('<input type="hidden" value="'+item.REQ_AMT10+'" />'+item.REQ_AMT10);        
            $("#TB_REQ_AMT11_3").html('<input type="hidden" value="'+item.REQ_AMT11+'" />'+item.REQ_AMT11);        
            $("#TB_REQ_AMT12_3").html('<input type="hidden" value="'+item.REQ_AMT12+'" />'+item.REQ_AMT12);        
            $("#TB_REQ_AMT13_3").html('<input type="hidden" value="'+item.REQ_AMT13+'" />'+item.REQ_AMT13);        
            $("#TB_REQ_AMT14_3").html('<input type="hidden" value="'+item.REQ_AMT14+'" />'+item.REQ_AMT14);        
            $("#TB_REQ_AMT15_3").html('<input type="hidden" value="'+item.REQ_AMT15+'" />'+item.REQ_AMT15);
            $("#TB_REQ_AMT16_3").html('<input type="hidden" value="'+item.REQ_AMT16+'" />'+item.REQ_AMT16);        	
        }
        

    });	
	
	// 에러메세지 처리
	alertErrMsg(data);
}

</script>

	<section class="pop-wrap">
		<div class="pop-cont">
			<div class="sub-tit">
				<h4>※ 견적내용</h4>
			</div>

			<table class="tbl-view">
				<colgroup>
					<col style="width:10%">
					<col style="width:15%">
					<col style="width:10%">
					<col style="width:30%">
				</colgroup>
				<tbody>
					<tr>
						<th id="TB_REQ_DOC_NO_H" style="text-align: center">자재코드</th>
						<td id="TB_MAT_NUMBER">
						</td>
						<th id="TB_REQ_DOC_NO_H" style="text-align: center">자재명</th>
						<td id="TB_MAT_DESC">
							<input type="hidden" name="TB_REQ_DOC_NO" id="TB_REQ_DOC_NO" disabled="disabled">
						</td>
					</tr>
				</tbody>
			</table>
			<br>
			
			<table class="tbl-view">
				<colgroup>
					<col style="width:150px">
					<col id = "col1">
					<col id = "col2">
					<col id = "col3">
				</colgroup>
				<tbody>
					<tr>
						<th style="text-align: center"></th>
						<th id="header1" style="text-align: center"></th>
						<th id="header2" style="text-align: center"></th>
						<th id="header3" style="text-align: center"></th>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">주재료비</th>
						<td id="TB_REQ_AMT01_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT01_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT01_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">공통재료비</th>
						<td id="TB_REQ_AMT02_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT02_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT02_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">직접인건비</th>
						<td id="TB_REQ_AMT03_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT03_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT03_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">간접인건비</th>
						<td id="TB_REQ_AMT04_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT04_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT04_3" style="text-align: right">
						</td>

					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">기계감가비</th>
						<td id="TB_REQ_AMT05_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT05_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT05_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">기타감가비</th>
						<td id="TB_REQ_AMT06_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT06_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT06_3" style="text-align: right">
						</td>

					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">노무성경비</th>
						<td id="TB_REQ_AMT07_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT07_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT07_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">설비성경비</th>
						<td id="TB_REQ_AMT08_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT08_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT08_3" style="text-align: right">
						</td>

					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">외주가공비</th>
						<td id="TB_REQ_AMT09_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT09_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT09_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">기술료</th>
						<td id="TB_REQ_AMT10_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT10_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT10_3" style="text-align: right">
						</td>

					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">개발상각비</th>
						<td id="TB_REQ_AMT11_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT11_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT11_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">품질관리-노무</th>
						<td id="TB_REQ_AMT12_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT12_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT12_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">품질관리-기계</th>
						<td id="TB_REQ_AMT13_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT13_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT13_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">품질보증비</th>
						<td id="TB_REQ_AMT14_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT14_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT14_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">시약재료비</th>
						<td id="TB_REQ_AMT15_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT15_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT15_3" style="text-align: right">
						</td>
					</tr>
					<tr>
						<th id="SB_DOC_TITLE_H" style="text-align: center">합계</th>
						<td id="TB_REQ_AMT16_1" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT16_2" style="text-align: right">
						</td>
						<td id="TB_REQ_AMT16_3" style="text-align: right">
						</td>
					</tr>

				</tbody>
			</table>
		</div><!-- //popCont -->
	</section>
