<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	$(document).ready(function() {
		//초기화함수
		init();
    	makeBtnClickEvent();
		//그리드 초기화
		setInitGrid();
		
		// 입고예정일이 존재하면 자동 조회
		if (!isNullValue($('#TB_GR_DELY_DATE').val())) {
			fnSearch();
		}
	});

	
	//초기화함수
	function init() {
		var menuCd  = '${PARAM.G_MENU_CD}';
		var pMenuCd = '${PARAM.P_MENU_CD}';
		
		if(menuCd == "VWRH151" || menuCd == "VWRH152"){// 입고예정등록
			if (pMenuCd == "VWRH151_P" || pMenuCd == "VWRH152_P") {
				$('#TB_GR_DELY_DATE').val('${PARAM.TB_GR_DELY_DATE}');
				$('#TB_LOCATION').val('${PARAM.TB_LOCATION}');
				$('#TB_COMP_CD').val('${PARAM.TB_COMP_CD}');
				$('#TB_PLANT_CODE').val('${PARAM.TB_PLANT_CODE}');
			} else {
				$('#TB_GR_DELY_DATE').val('${PARAM.GR_DELY_DATE}');
				$('#TB_LOCATION').val('${PARAM.LOCATION}');
				$('#TB_COMP_CD').val('${PARAM.COMP_CD}');
				$('#TB_PLANT_CODE').val('${PARAM.PLANT_CODE}');					
			}
		} else if (menuCd == "WRH165") { // 입고예정정보, 입고예정관리
			$('#TB_GR_DELY_DATE').val('${PARAM.GR_DELY_DATE}');
			$('#TB_LOCATION').val('${PARAM.LOCATION}');
			$('#TB_COMP_CD').val('${PARAM.COMP_CD}');
			$('#TB_PLANT_CODE').val('${PARAM.PLANT_CODE}');			
		}
	}
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm,    'DELY_TIME_GRID',   {text: '시간'},    150,     'text', {textAlignment: "center"});
	    addField(cm,    'DELY_RESV',      	{text: '예약'},     150,     'text', {textAlignment: "center"});
	    addField(cm,    'DELY_DATE_GRID',   {text: '입고예정일'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    addField(cm,    'DELY_DATE_TIME',   {text: '입고예정일시'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    addField(cm,    'DELY_RESV_YN',     {text: '예약가능여부'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    addField(cm,    'DELY_TIME',        {text: '시간'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    addField(cm,    'DELY_DATE',        {text: '입고예정일'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    
	    gridView.rgrid({
	         gridId         : gridId    //required 그리드 ID
	        ,height         : 265      //required 그리드 높이
	        //,width            : "100%"    //default 100% 그리드 넓이
	        //,rowHeight        : 30        //default 30 row height
	        ,columns        : cm        // required
	        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
	        ,exclusive      : true      //default false 한 행만 체크 가능할지의 여부를 지정한다.
	        ,editable       : false     //default false 그리드 전체 에디트 여부
	        ,selectStyle    : "singleRow"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
	        ,dynamicResize  : false     //default false 동적 그리드 높이 변경
	        ,copySingle     : false // default ture : 복사하지 않음 
            ,autoHResize    : true          //화면 크기에 맞게 높이 자동조절
            ,viewCount      : true          //조회 건수 표시
	    });
	    
	    gridView.setColumnProperty("DELY_RESV","dynamicStyles",function(grid, item, value) {
        	if (gridView.getValue(item.itemIndex,"DELY_RESV_YN") == 'O' ) {
        		return {fontUnderline:true,foreground:"#0000ff"};
        	}	    	
	    });	    
	    
	    gridView.onDataCellClicked =  function (grid, item) {
            if (item.column == "DELY_RESV") {
            	if (gridView.getValue(item.itemIndex,"DELY_RESV_YN") == 'O' ) {
            		setOpenerData(grid.getCurrentRow());
            	} else {
            		alert("예약 불가능한 시간입니다.");
            		return false;
            	}
            }
    	};
	}
	
	//사용자목록 조회
	function fnSearch() {
		
		if (isNullValue($('#TB_GR_DELY_DATE').val())) {
			alert("입고예정일은 필수 입력 항목입니다.");
			return false;
		}
		
		// 조회 요청
		searchCall(gridView, '/com/cmn/selectDelyDateList');
	}

	//부모창에 선택값 셋팅함수 호출
	function setOpenerData(rowData) {
		parentCallback('fnCallbackDelyDateSearchPop',rowData);
	}
	
	function fnSearchSuccess(data) {
		if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
	        alert(data.errMsg);
	        return;
	    }
		$("#TD_STRG_SPCE").html('');
		if (isNotEmpty(data.rows)) {
			if (!isNullValue(data.rows[0].STRG_SPCE)) {
				$("#TD_STRG_SPCE").html("창고 여유공간 : " + data.rows[0].STRG_SPCE);	
			}			
		} else {
			alert("해당일자[" + $('#TB_GR_DELY_DATE').val() + "]에 예약가능한 시간이 존재하지 않습니다.");
		}

		
	    gridView.setPageRows(data);
	    gridView.closeProgress();
	    //조회결과가 1건인 경우 자동 세팅
	    if(data.rows != null && data.rows.length == 1){
	        setOpenerData(gridView.getCurrentRow());
	    }

	}

	
</script>

<div class="pop-wrap"  style="width:100%;">

	<div class="pop-head">
		<h2>입고예정시간</h2>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
		            <colgroup>
		                <col style="width:100px">
		                <col style="width:150px">
		                <col style="width:150px">
		                <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th><span>입고예정일</span></th>
		                    <td>
		                    	<input type="text" class="datepicker t_center" id="TB_GR_DELY_DATE" onkeypress="if(event.keyCode==13){fnSearch();}" value=""/>
		                    	<input type="hidden" id="TB_COMP_CD" name="TB_COMP_CD" value="">
		                    	<input type="hidden" id="TB_PLANT_CODE" name="TB_PLANT_CODE" value="">
		                    	<input type="hidden" id="TB_LOCATION" name="TB_LOCATION" value="">
		                    </td>
		                    <td id="TD_STRG_SPCE">
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
		</br>
		<!-- realgrid 들어가는 영역 : S -->
		<div class="realgrid-area">
		    <div id="gridView"></div>
		</div>
	</div><!-- //popCont -->
</div>

