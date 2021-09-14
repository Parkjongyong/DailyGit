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
		fnSearch();
	});

	
	//초기화함수
	function init() {
		
	}
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm,    'DELY_TIME',        {text: '시간'},   0,     'text',  {textAlignment: "center"});
	    
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
	    
	    gridView.setColumnProperty("DELY_TIME","dynamicStyles",function(grid, item, value) {
       		return {fontUnderline:true,foreground:"#0000ff"};
	    });	    
	    
	    gridView.onDataCellClicked =  function (grid, item) {
           		setOpenerData(grid.getCurrentRow());
    	};
	}
	
	//사용자목록 조회
	function fnSearch() {
		// 조회 요청
		searchCall(gridView, '/com/wrh/selectDateTime');
	}

	//부모창에 선택값 셋팅함수 호출
	function setOpenerData(rowData) {
		parentCallback('fnCallbackDelyDateSearchPop',rowData);
	}
	
	function fnSearchSuccess(data) {
	    gridView.setPageRows(data);
	    gridView.closeProgress();

	}

	
</script>

<div class="pop-wrap"  style="width:100%;">

	<div class="pop-head">
		<h2>입고예약시간</h2>
	</div>
	
    <div class="pop-cont">    
		<!-- realgrid 들어가는 영역 : S -->
		<div class="realgrid-area">
		    <div id="gridView"></div>
		</div>
	</div><!-- //popCont -->
</div>

