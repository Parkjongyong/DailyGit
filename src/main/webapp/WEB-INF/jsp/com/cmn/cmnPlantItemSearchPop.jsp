<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
var scrollItem = 470;

	$(document).ready(function() {
		$("#SB_COMP_CD").val('${PARAM.SB_COMP_CD}');
		
	    var plantList = stringToArray("${CODELIST_SYSPLT}", '${PARAM.SB_COMP_CD}');
	    fnMakeComboOption('SB_PLANT_CD', plantList, 'CODE', 'CODE_NM');
		
	    lvlList = stringToArray("${CODELIST_YS005}");
		fnMakeComboOption('SB_LVL' , lvlList,   'CODE', 'CODE_NM', null, "","전체");
		
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
	    addField(cm,    'PLANT_CODE',        {text: '플랜트'},    50,     'text', {textAlignment: "center"} ,  {editable:false});
	    addField(cm,    'PLANT_NM',        {text: '플랜트명'},    100,     'text', {textAlignment: "center"} ,  {editable:false});
	    addField(cm,    'MAT_NUMBER',        {text: '품목코드'},    100,     'text', {textAlignment: "center"} ,  {editable:false});
	    addField(cm,    'MAT_DESC',      {text: '품목명'},     150,     'text', {textAlignment: "near"}   ,  {editable:false});

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
            ,appendable     : true
	    });
	    
	    gridView.onDataCellDblClicked =  function (grid, index) {
    	  setOpenerData(grid.getCurrentRow());
    	};
    	
    	gridView.onTopItemIndexChanged = function(grid, item) {
            if (item > scrollItem) {
                scrollItem += 450;
                loadNext();
            }
        }
    	
        fnSearch(); 
    	 
    } 

    function loadNext() {
        var params = fnGetParams();
        var newStart = gridView.getDataProvider().getRowCount()+1;
        
        $.extend(params, {"page" : newStart});
        $.extend(params, {"pageSize" : newStart+499});
        
        ajaxJsonCall('<c:url value="/com/cmn/selectPlantItemList.do"/>',  params, function(data){
            gridView.addRows(data.rows, data.records);
        });
    }

	//사용자목록 조회
	function fnSearch() {
		// 조회 요청
		searchCall(gridView, '/com/cmn/selectPlantItemList');
	}

	//부모창에 선택값 셋팅함수 호출
	function setOpenerData(rowData) {
		parentCallback('fnCallbackPlantItemSearchPop',rowData);
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
		<h2>품목정보</h2>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
		            <colgroup>
		                <col style="width:70px;">
		                <col style="width:130px;">
		                <col style="width:70px;">
		                <col style="width:150px;">
		                <col style="width:70px;">
		                <col style="width:150px;">
		                <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th><span>플랜트</span></th>
		                    <td>
			                    <select id="SB_PLANT_CD" name="SB_PLANT_CD" data-type="select" data-bind="selectedOptions: SB_PLANT_CD">
				                    <option value="">전체</option>
			                    </select>
		                    </td>
		                    <th><span>품목코드</span></th>
		                    <td>
								<input type="text" id="TB_MAT_NUMBER" class="w120">
		                    </td>
		                    <th><span>품목명</span></th>
		                    <td>
								<input type="text" id="TB_MAT_DESC" class="w120">
								<input type="hidden" id="SB_COMP_CD">
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

