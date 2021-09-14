<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
var gridRowCnt = 0;
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
		// 년도 셋팅
		$("#TB_CRTN_YY").val(getDiffDay("y",0).substring(0,4));
	}
	
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm,    'CRTN_YMD',         {text: '일자'},         150,            'date',           {textAlignment:"center"}, {datetimeFormat: "yyyyMMdd"});
	    addField(cm,    'VHCL_RRE_DST',     {text: '주행전거리'},     100,     'number',     {textAlignment: "far"});
	    addField(cm,    'VHCL_FNS_DST',     {text: '주행후거리'},     100,     'number',     {textAlignment: "far"});
	    addField(cm,    'VHCL_DST',         {text: '주행거리'},     100,     'number',     {textAlignment: "far"});
	    addField(cm,    'VHCL_WORK_DST',    {text: '일반업무용'},     100,     'number',     {textAlignment: "far"});
	    addField(cm,    'VHCL_NWRK_DST',    {text: '비업무용'},     100,     'number',     {textAlignment: "far"});
	    addField(cm,    'VHCL_REMK',   		{text: '비고'},    300,     'text',  {textAlignment: "near"});
	    
	    addField(cm,    'CRUD',             {text: 'CRUD'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
	    addField(cm,    'RCHK',             {text: '첫행체크'},        0,     'text',      {textAlignment: 'center'},  {visible:false});
	    addField(cm,    'VHCL_NUMBER',      {text: '차량번호'},        0,     'text',      {textAlignment: 'center'},  {visible:false});

	    gridView.rgrid({
	         gridId         : gridId    //required 그리드 ID
	        ,height         : 265      //required 그리드 높이
	        //,width            : "100%"    //default 100% 그리드 넓이
	        //,rowHeight        : 30        //default 30 row height
	        ,columns        : cm        // required
	        ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
	        ,exclusive      : false      //default false 한 행만 체크 가능할지의 여부를 지정한다.
	        ,editable       : true     //default false 그리드 전체 에디트 여부
	        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
	        ,dynamicResize  : false     //default false 동적 그리드 높이 변경
	        ,copySingle     : false // default ture : 복사하지 않음 
            ,autoHResize    : true          //화면 크기에 맞게 높이 자동조절
            ,viewCount      : true          //조회 건수 표시
	    });
	    
	    //셀이 수정된후 
	    gridView.onCellEdited = function (grid, itemIndex, dataRow, field) {
	        this.commit(); //강제 커밋.
	    };
	    
	    gridView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
	    	
	    	var values = grid.getValues(itemIndex);
	    	var dst1   = toNumber(values.VHCL_WORK_DST);
	    	var dst2   = toNumber(values.VHCL_NWRK_DST);
	    	var dst3   = dst1 + dst2; // 주행거리
	    	var dst4   = toNumber(values.VHCL_RRE_DST);
	    	var dst5   = dst3 + dst4;
	    	
	    	gridView.setValue(itemIndex, "VHCL_DST", dst3);
	    	gridView.setValue(itemIndex, "VHCL_FNS_DST", dst5);
	    	gridView.checkItem(dataRow, true);
	    };
	    
	    gridView.onRowsPasted = function(grid, items){
	    	
	    	for(var i = 0; i < items.length; i++){
	        	var values = grid.getValues(items[i]);
	        	var preValues = {};
	        	if (i > 0) {
	        		preValues = grid.getValues(items[i-1]);
	        	}
	        	
		    	var dst1   = toNumber(values.VHCL_WORK_DST);
		    	var dst2   = toNumber(values.VHCL_NWRK_DST);
		    	var dst3   = dst1 + dst2; // 주행거리
		    	
		    	var dst4   = 0;
		    	if (i == 0) {
		    		dst4 = toNumber(values.VHCL_RRE_DST);	
		    	} else {
		    		dst4 = toNumber(preValues.VHCL_FNS_DST);
		    	}
		    	gridView.setValue(items[i], "VHCL_RRE_DST", dst4);
		    	
		    	var dst5   = dst3 + dst4;
		    	gridView.setValue(items[i], "VHCL_DST", dst3);
		    	gridView.setValue(items[i], "VHCL_FNS_DST", dst5);
		    	gridView.setValue(items[i], "CRUD", "I");
		    	gridView.setValue(items[i], "VHCL_NUMBER", $('#TB_VHCL_NUMBER').val());
	        	
	        	gridView.checkItem(items[i], true);
	    	}
	    	
	    };	    
	    
	    // 동적 스타일 적용
	    var columnDynamicStyles1 = function(grid, index, value) {
	        var styles = {};
	        var values = grid.getValues(index.itemIndex);
	        var gubn   = values.RCHK;
	        if (gubn == 'Y' && gridView.getRowCount() == 1) {
	            styles.editable = true;
	            styles.background = "#d5e2f2";
	        } else {
	        	styles.editable = false;
	        }
	        
	        return styles;
	    };
	    
	    var columnDynamicStyles2 = function(grid, index, value) {
	        var styles = {};
	        var values = grid.getValues(index.itemIndex);
	        var gubn   = values.CRUD;
	        if (gubn == 'I') {
	            styles.editable = true;
	            styles.background = "#d5e2f2";
	        } else {
	        	styles.editable = false;
	        }
	        
	        return styles;
	    };	    
	    
	    // 기본 스타일 적용
	    var columnDefaultStyles = function(grid, index, value) {
	        var styles = {};
	        	styles.editable = false;
	        return styles;
	    };
	    
	    // 기본 스타일 적용2
	    var columnDefaultStyles2 = function(grid, index, value) {
	        var styles = {};
		        styles.editable = true;
		        styles.background = "#d5e2f2";
	        return styles;
	    };
	    
	    // 날짜 스타일 적용
	    var columnDateStyles = function(grid, index, value) {
	        var styles = {};
	        var values = grid.getValues(index.itemIndex);
	        var gubn   = values.CRUD;
	        if (gubn == 'I') {
	        	styles.editable = true;
	        	styles.background = "#d5e2f2";
	        	styles.editor = {"type": "date","datetimeFormat": "yyyyMMdd"};
	        } else {
	        	styles.editable = false;
	        }	        
	        return styles;
	    };	    

	    gridView.setColumnProperty("CRTN_YMD", "dynamicStyles", columnDateStyles);
	    gridView.setColumnProperty("VHCL_RRE_DST", "dynamicStyles", columnDynamicStyles1);
	    
	    gridView.setColumnProperty("VHCL_FNS_DST", "dynamicStyles", columnDefaultStyles);
	    gridView.setColumnProperty("VHCL_DST", "dynamicStyles", columnDefaultStyles);
	    
	    gridView.setColumnProperty("VHCL_WORK_DST", "dynamicStyles", columnDefaultStyles2);
	    gridView.setColumnProperty("VHCL_NWRK_DST", "dynamicStyles", columnDefaultStyles2);
	    gridView.setColumnProperty("VHCL_REMK", "dynamicStyles", columnDefaultStyles2);
	    
	}
	
	//프로젝트 조회
	function fnSearch() {
		// 조회 요청
		searchCall(gridView, '/com/bdg/selectVehicleOpList');
	}

	function fnSearchSuccess(data) {
		if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
	        alert(data.errMsg);
	        return;
	    }
	    gridView.setPageRows(data);
	    gridView.closeProgress();
	    
	    gridRowCnt = gridView.getRowCount();

	}

	//행삭제
	var fnRowDel = function(){
		fnAddRowDelete(gridView);
	}

	//행추가
	function fnRowAdd() {
		
		var values = {};
		var toDay = getDiffDay("y",0).replace('-', '').replace('-', '');
		
// 		if (gridView.getRowCount() > 0) {
// 			if (toDay == gridView.getRowValue(0, "CRTN_YMD")) {
// 				alert("기 등록된 일지 정보가 존재합니다. 확인 후 작업하세요.");
// 				return false;	
// 			}			
// 		}

		if (gridRowCnt == 0) {
			values = {"CODEMAPPING1":"1", "CRUD" : "I", "RCHK": "Y", "VHCL_NUMBER" : $('#TB_VHCL_NUMBER').val(), "CRTN_YMD":getDiffDay("y",0).replace('-', '').replace('-', '')};
		} else {
			values = {"CODEMAPPING1":"1", "CRUD" : "I", "RCHK": "N", "VHCL_NUMBER" : $('#TB_VHCL_NUMBER').val(), "VHCL_RRE_DST": gridView.getRowValue(gridView.getRowCount()-1, "VHCL_FNS_DST"), "CRTN_YMD":toDay};
		}
		fnAddRow(gridView, values);
		gridRowCnt++;
	}

	//삭제
	var fnDel = function(){
		var params = {};
		$.extend(params, {"ITEM_LIST" : fnGetDeleteData(gridView)});
		if(fnDeleteCheck(gridView) == true){
			// 조회 요청
			deleteCall(gridView, '/com/bdg/deleteVehicleOp', null, params);
		}
		
	}

	//저장
	var fnSave = function(){
		
		gridView.commit();
		
		var preDate = "";
		for(var i = 0; i < gridView.getRowCount(); i++){
			var temp = gridView.getValues(i);
			if (i == 0) {
				preDate = temp.CRTN_YMD;
			} else {
				if (preDate >= temp.CRTN_YMD) {
			        alert("운행일자는 순서대로 등록가능합니다. 일자확인 후 작업하세요.");
			        return;
				} else {
					preDate = temp.CRTN_YMD;
				}
			}
			// 중복 체크
			var j = i + 1;
			for(j; j < gridView.getRowCount(); j++){
				var temp2 = gridView.getValues(j);
				if (temp.CRTN_YMD == temp2.CRTN_YMD) {
			        alert("중복된 일자는 등록 불가합니다. 일자확인 후 작업하세요.");
			        return;					
				}
			}
		}		
		
		var params = {};
		$.extend(params, {"ITEM_LIST" : fnGetSaveData(gridView)});
		
		// 필수 체크 대상(그리드)
		var requiredVal   = ["CRTN_YMD", "VHCL_RRE_DST"];
		
		// 필수 체크 후 저장 진행
		if(fnSaveCheck(gridView, requiredVal) == true){
		     if(confirm("저장 하시겠습니까?")){
		    	 saveCall(gridView, '/com/bdg/saveVehicleOp', null, params);
		     }
		}
	}

	/**
	 * 저장 성공
	 */
	function fnSaveSuccess(result) {
		alert("저장되었습니다.");
	    // 상태바 비활성화
	    gridView.closeProgress();
	    fnSearch();
	}

	/**
	 * 저장 실패
	 */
	function fnSaveFail(data) {
		alert(data.errMsg);
	    // 상태바 비활성화
	    gridView.closeProgress();
	}

	/**
	 * 삭제 성공
	 */
	function fnDeleteSuccess(result) {
		alert("삭제 하였습니다.");
		fnSearch();
	}

	/**
	 * 삭제 실패
	 */
	function fnDeleteFail(result) {
		alert(result.errMsg);
	}	
	
</script>

<div class="pop-wrap"  style="width:100%;">

	<div class="pop-head">
		<h2>월별운행일지</h2>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
		            <colgroup>
		                <col style="width:120px;">
		                <col style="width:280px;">
		                <col style="width:120px;">
		                <col style="width:120px;">
		                <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th><span>차량번호</span></th>
		                    <td>
								<input type="text" id="TB_VHCL_NUMBER" value="${PARAM.VHCL_NUMBER}" readOnly>
		                    </td>
		                    <th><span>관리년도</span></th>
		                    <td>
								<input type="text" id="TB_CRTN_YY"  value="" style="text-align: right;width: 50px;">
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
		<div class="sub-tit">
		    <div class="btnArea t_right">
		        <button type="button" class="btn" id="btnRowDel">행삭제</button>
		        <button type="button" class="btn" id="btnRowAdd">행추가</button>
		        <button type="button" class="btn" id="btnDel">삭제</button>
		        <button type="button" class="btn" id="btnSave">저장</button>
		    </div>
		</div>
		<!-- realgrid 들어가는 영역 : S -->
		<div class="realgrid-area">
		    <div id="gridView"></div>
		</div>
	</div><!-- //popCont -->
</div>

