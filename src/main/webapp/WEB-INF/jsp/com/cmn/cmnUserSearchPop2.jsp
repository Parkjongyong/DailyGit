<%
	/**
		공통 사용자 검색 팝업
		USER_CB_FNC : 사용자 선택시 부모창의 호출 함수 (필수)
		USER_CB_NAME : 기본 사용자 검색값 (선택)
	*/
%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
	$(document).ready(function() {
		
		var compList     = stringToArray("${CODELIST_SYS001}");
		fnMakeComboOption('TB_COMP_CD' , compList,      'CODE', 'CODE_NM', null, "","전체");
		//초기화함수
		init();
    	makeBtnClickEvent();
		//그리드 초기화
		setInitGrid();
		fnSearch();
	});

	
	//초기화함수
	function init() {
		$('#TB_COMP_CD').val('${PARAM.SB_COMP_CD}')
		popupLoading(opener);
// 		if(opener){
// 	    	var progressingDivHtml = 
// 	            '<div class="loading-area">'
// 	           +   '<div class="loading">' 
// 	           +   '<strong>처리 진행중 입니다.</strong>' 
// 	           +   '<p>잠시만 기다려주시기 바랍니다.</p>' 
// 	           +   '</div>' 
// 	           +'</div>'
// 	           $(progressingDivHtml).appendTo('body');

// 		}
	}
	
	
	//그리드 초기화 함수
	function setInitGrid() {
		var gridId = "gridView";
	    gridView = new RealGridJS.GridView(gridId);
	    
	    var cm = [];
	    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	    addField(cm ,   'COMP_NM'      , {text: '회사'}    ,100       , 'text'            , {textAlignment: "near"});
	    addField(cm ,   'COMP_CD'      , {text: '회사코드'} ,0       , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'DEPT_NM'      , {text: '부서명'}  ,100      , 'text'            , {textAlignment: "near"});
	    addField(cm ,   'DEPT_CD'      , {text: '부서코드'} ,0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'DUTY_NAME'    , {text: '직급'}    , 60      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'DUTY_CODE'    , {text: '직급코드'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'USER_ID'      , {text: '담당자사번'}, 100      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'USER_NM'      , {text: '담당자명'} , 80      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'MOBILE_NO'    , {text: '연락처'} , 100      , 'text'            , {textAlignment: "center"});
	    addField(cm ,   'EMAIL_ID'     , {text: 'EMAIL'} , 120      , 'text'            , {textAlignment: "near"});
	    addField(cm ,   'COST_CD'      , {text: '코스트센터'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'DESIGNATION'  , {text: '직위명'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    addField(cm ,   'DESIGNATION_N', {text: '직위코드'} , 0        , 'text'            , {textAlignment: "center"} ,{visible:false});
	    
	    
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
	        ,copySingle : false // default ture : 복사하지 않음 
            ,autoHResize    : true          //화면 크기에 맞게 높이 자동조절
            ,viewCount      : true          //조회 건수 표시
	    });
	    
	    gridView.onDataCellDblClicked =  function (grid, index) {
    	  setOpenerData(grid.getCurrentRow());
    	};
	}
	
	//사용자목록 조회
	function fnSearch() {
		// 조회 요청
		searchCall(gridView, '/com/cmn/selectUserList');
	}

	//부모창에 선택값 셋팅함수 호출
	function setOpenerData(rowData) {
		parentCallback('fnCallbackPop',rowData);
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
		<h2>사용자정보</h2>
		<a href="#none" class="close">닫기</a>
	</div>
	
    <div class="pop-cont">    
		<div class="tbl-search-wrap">
		    <div class="tbl-search-area">
		        <table class="tbl-search">
					<colgroup>
		                <col style="width:80px">
		                <col style="width:390px">
		                <col style="width:80px">
		                <col style="width:390px">
		                <col style="width:160px">
		                <col style="width:350px">
					</colgroup>
					<tbody>
						<tr>
							<th><span>회사</span></th>
							<td>
							     <select id="TB_COMP_CD" name="TB_COMP_CD" data-type="select" data-bind="selectedOptions: SB_COMP_CD">
	                             </select>
							     <input type="hidden" id="JICK_GUBN" name="JICK_GUBN" value="${PARAM.JICK_GUBN}"/>
							     <input type="hidden" id="CHC_ETC_GBN" name="CHC_ETC_GBN" value="${PARAM.CHC_ETC_GBN}"/>
							</td>
							<th><span>부서 </span></th>
							<td>
							     <input type="text" id="TB_DEPT_NM" name="TB_DEPT_NM"  style="ime-mode:active;"/>
							</td>
							<th><span>담당자명 </span></th>
							<td>
							     <input type="text" id="TB_USER_NM" name="TB_USER_NM"  style="ime-mode:active;"/>
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
