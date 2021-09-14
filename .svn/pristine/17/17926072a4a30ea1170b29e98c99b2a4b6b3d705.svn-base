<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
var filter = "win16|win32|win64|mac|macintel";
	$(document).ready(function() {
		//초기화함수
		init();
    	makeBtnClickEvent();
		//그리드 초기화
		setInitGrid();
		
		// 자동조회
		fnSearch();
	});

	
	//초기화함수
	function init() {
		if(opener){
	    	var progressingDivHtml = 
	            '<div class="loading-area">'
	           +   '<div class="loading">' 
	           +   '<strong>처리 진행중 입니다.</strong>' 
	           +   '<p>잠시만 기다려주시기 바랍니다.</p>' 
	           +   '</div>' 
	           +'</div>'
	           $(progressingDivHtml).appendTo('body');

		}
	}
	
	//그리드 초기화 함수
	function setInitGrid() {
	    var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	  
	    addField(cm,    'GR_DATE_TIME',                 {text: '입고예정일시'},                     100,     'text', {textAlignment: "center"});
	    
 	    addField(cm,    'VENDOR_CD',                    {text:'업체코드'},                          60,     'text', {textAlignment: "center"});
	    addField(cm,    'VENDOR_NM',                    {text:'업체명'},                            100,     'text', {textAlignment: "center"});
	
	    addField(cm,    'GR_PERSON_NAME',               {text: '입고담당자'},                       60,     'text', {textAlignment: "center"});
	    addField(cm,    'GR_PERSON_TEL',                {text: '연락처'},                          80,     'text', {textAlignment: "center"});
	    
	    addField(cm,    'COMP_NM',                      {text:'회사'},                          100,     'text', {textAlignment: "center"},{visible:false});
	    addField(cm,    'PLANT_CODE',                   {text: '플랜트'},                           60,     'text', {textAlignment: "center"},{visible:false});
	    
	    addField(cm,    'APPROVE_DOC_TXT',              {text: '승인자비고'},                    150,     'text', {textAlignment: "near"},{visible:false});
	    addField(cm,    'CRUD',                         {text: 'CRUD'},                           0,     'text', {textAlignment: 'center'},  {visible:false});
	
	    
	    gridView.rgrid({
	         gridId         : gridId    //required 그리드 ID
	        ,height         : _G_GRID_HEIGHT_10       //required 그리드 높이
	        ,columns        : cm        // required
	        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
	        ,editable       : false     //default false 그리드 전체 에디트 여부
	        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
	        ,appendable     : true
	        ,copySingle     : false // default ture : 복사하지 않음
	        ,viewCount      : true       //조회 건수 표시
	    });
	
	    gridView.onDataCellClicked = function (grid, item) {
	        if (item.fieldName === "DOC_NO") {
	        	fnSearchDetail(item);
	        }
	    };	    

	    
	    // 기본 스타일 적용
	    var columnDefaultStyles = function(grid, index, value) {
	    	var styles = {};
	    	if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
	    		styles.visible = true;
	    	} else { 
	    		styles.visible = false;	    		 
	    	} 
	        return styles;
	    };    
	    
	    gridView.setColumnProperty("DOC_NO" , "dynamicStyles", columnDefaultStyles);
	    gridView.setColumnProperty("VENDOR_CD" , "dynamicStyles", columnDefaultStyles);
	    
// 	    gridView.setColumnProperty("GR_DATE_TIME" , "dynamicStyles", columnDefaultStyles2);
// 	    gridView.setColumnProperty("VENDOR_NM" , "dynamicStyles", columnDefaultStyles2);
// 	    gridView.setColumnProperty("GR_PERSON_NAME" , "dynamicStyles", columnDefaultStyles2);
// 	    gridView.setColumnProperty("GR_PERSON_TEL" , "dynamicStyles", columnDefaultStyles2);
	}
	
	/**
	 * 입고예정상세
	 */
	function fnSearchDetail(data) {
		var params = {};
		$.extend(params, fnGetParams());
		$.extend(params, fnGetGridRowParams(gridView, data.itemIndex));
		
		var target    = "wrhStockDueDate";
		var width     = "1320";
		var height    = "800";
	    var scrollbar = "yes";
	    var resizable = "yes";
		
	 	fnPostPopup('wrhStockDueDate', params, target, width, height, scrollbar, resizable);

	}	
	
	//사용자목록 조회
	function fnSearch() {
		
	    var params = fnGetParams();
	    $.extend(params, {"COMP_CD"   :'${PARAM.SB_COMP_CD}'});
	    $.extend(params, {"PLANT_CD"  :'${PARAM.SB_PLANT_CD}'});
	    $.extend(params, {"STORAGE_CD":'${PARAM.SB_STORAGE_CD}'});	    
	    $.extend(params, {"YYYYMMDD"  :'${PARAM.YYYYMMDD}'});
		// 조회 요청
		searchCall(gridView, '/com/wrh/wrhStorageSpacePopList', null , params);
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
		<h2>입고예정정보</h2>
	</div>
	
    <div class="pop-cont">    
		</br>
		<!-- realgrid 들어가는 영역 : S -->
		<div class="realgrid-area">
		    <div id="gridView"></div>
		</div>
	</div><!-- //popCont -->
</div>

