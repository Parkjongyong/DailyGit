<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	var scrollItem = 20;

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
	    // 개별코드 생성(그리드용)
		var compList   = stringToArray("${CODELIST_SYS001}","ALL");
		fnMakeComboOption('SB_COMP_CD', compList, 'CODE', 'CODE_NM', null, "", "전체");
		$("#SB_COMP_CD").val('${PARAM.COMP_CD}');
	}
	
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm,    'CUST_NAME1',       {text: '거래처명'},    120,     'text', {textAlignment: "near"} ,  {editable:false});
	    addField(cm,    'DISTRIB_NM',      	{text: '유통'}   ,     70,     'text', {textAlignment: "center"}   ,  {editable:false});
	    
	    addField(cm ,   'COMP_CD',          {text: '회사코드'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'DISTRIB_CD',       {text: '유통코드'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'CUST_CD',          {text: '거래처코드'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    
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
                scrollItem += 50;
                loadNext();
            }
        }      	
	}
	
	function loadNext() {
	    var params = fnGetParams();
	    var newStart = gridView.getDataProvider().getRowCount()+1;
	    
	    $.extend(params, {"page" : newStart});
	    $.extend(params, {"pageSize" : newStart+49});
	    
	    ajaxJsonCall('<c:url value="/com/cmn/selectCustomerList.do"/>',  params, function(data){
	        gridView.addRows(data.rows, data.records);
	    });
	}	
	
	//거래처 조회
	function fnSearch() {
// 		if ($("#SB_COMP_CD").val() == "1100" && ($("#TB_DISTRIB_CD").val() == null || $("#TB_DISTRIB_CD").val() == "")) {
// 			if($("#TB_CUST_NAME1").val() == null || $("#TB_CUST_NAME1").val() == ""){
// 				alert("거래처명은 필수입니다.");
// 				loadingEnd();
// 				return false;
// 			}			
// 		}
		// 조회 요청
		searchCall(gridView, '/com/cmn/selectCustomerList');
	}

	//부모창에 선택값 셋팅함수 호출
	function setOpenerData(rowData) {
		parentCallback('fnCallbackCustomerSearchPop',rowData);
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
		<h2>거래처 정보</h2>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
					<colgroup>
		                <col style="width:70px">
		                <col style="width:250px">
		                <col style="width:100px">
		                <col style="width:250px">
					</colgroup>
					<tbody>
						<tr>
							<th><span>회사</span></th>
							<td>
			                    <select id="SB_COMP_CD" name="SB_COMP_CD" disabled>
			                    </select>
							</td>
							<th><span>거래처명 </span></th>
							<td>
							     <input type="text" id="TB_CUST_NAME1" name="TB_CUST_NAME1" class="w150 enterEvnt" style="ime-mode:active;"/>
							     <input type="hidden" id="TB_DISTRIB_CD" name="TB_DISTRIB_CD" value="${PARAM.DISTRIB_CD}"/>
							</td>
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

