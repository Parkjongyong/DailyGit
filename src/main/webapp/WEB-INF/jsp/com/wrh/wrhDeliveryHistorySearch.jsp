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
		
		// 자동 조회
		fnSearch();
	});

	
	//초기화함수
	function init() {
		$('#TB_DOC_NO').val('${PARAM.DOC_NO}');
	}
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm,    'DOC_SEQ',          {text: 'SEQ'},      60,     'text', {textAlignment: "center"});
	    addField(cm,    'DOC_STATUS',       {text: '진행상태'},   100,     'text',  {textAlignment: "center"});
	    addField(cm,    'USER_NM',      	{text: '담당자'},     100,     'text', {textAlignment: "center"});
	    addField(cm,    'PROC_DATE',      	{text: '처리일자'},    80,     'text', {textAlignment: "center"});
	    addField(cm,    'REMARK',      	    {text: 'COMMENTS'},     300,     'text', {textAlignment: "near"});

	    addField(cm,    'USER_ID',          {text: '담당자'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    addField(cm,    'DOC_NO',           {text: '문서번호'},   0,     'text',  {textAlignment: "center"},  {visible:false});
	    
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
	    
	}
	
	//사용자목록 조회
	function fnSearch() {
		
		// 조회 요청
		searchCall(gridView, '/com/wrh/selectDeliveryHistoryList');
	}

	function fnSearchSuccess(data) {
		if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
	        alert(data.errMsg);
	        return;
	    }
		
	    gridView.setPageRows(data);
	    gridView.closeProgress();
	}

	
</script>

<div class="pop-wrap"  style="width:100%;">

	<div class="pop-head">
		<h2>입고예정일 승인현황</h2>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
		            <colgroup>
		                <col style="width:100px">
		                <col style="width:150px">
		                <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th></th>
		                    <td>
		                    	<input type="hidden" id="TB_DOC_NO" name="TB_DOC_NO" value="">
		                    </td>
		                    <td></td>
		                </tr>
		            </tbody>
				</table>                    
			</div><!-- //searchTableArea -->
		</div><!-- // search_field_wrap -->
		</br>
		<!-- realgrid 들어가는 영역 : S -->
		<div class="realgrid-area">
		    <div id="gridView"></div>
		</div>
	</div><!-- //popCont -->
</div>

