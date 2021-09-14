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
		popupLoading(opener);
	}
	
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm,    'ORDER_NO',           {text: '오더유형'},   70,     'text', {textAlignment: "center"} ,  {editable:false});
	    addField(cm,    'ORDER_DESC',         {text: '내역'},     120,     'text', {textAlignment: "near"}   ,  {editable:false});

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
	    
	    gridView.onDataCellDblClicked =  function (grid, index) {
    	  setOpenerData(grid.getCurrentRow());
    	};
	}
	
	//프로젝트 조회
	function fnSearch() {
		// 조회 요청
		searchCall(gridView, '/com/cmn/selectProjList');
	}

	//부모창에 선택값 셋팅함수 호출
	function setOpenerData(rowData) {
		parentCallback('fnCallbackProjSearchPop',rowData);
	}
	
	function fnSearchSuccess(data) {
		if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
	        alert(data.errMsg);
	        return;
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
		<h2>프로젝트 정보</h2>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
		            <colgroup>
		                <col style="width:120px;">
		                <col style="width:100px;">
		                <col style="width:120px;">
		                <col style="width:120px;">
		                <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th><span>오더유형</span></th>
		                    <td>
								<input type="text" id="TB_ORDER_NO" value="" class="w100">
		                    </td>
		                    <td></td>
		                    <th><span>내역</span></th>
		                    <td>
								<input type="text" id="TB_ORDER_DESC"   value="" class="w120">
								
								<input type="hidden" id="SB_COMP_CD"    value="${PARAM.SB_COMP_CD}">
								<input type="hidden" id="TB_DEPT_CD"    value="${PARAM.TB_DEPT_CD}">
								<input type="hidden" id="TB_ACCOUNT_NO" value="${PARAM.TB_ACCOUNT_NO}">
								<input type="hidden" id="SB_CCTR_CD" value="${PARAM.SB_CCTR_CD}">
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

