<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
var gridView;

$(document).ready(function() {
    
    fnInitStatus();
    initGridView();
    boardListWithAjax();
});

function fnInitStatus() {
    
    $("#btnSearch").click(function(e){
        boardListWithAjax();
    });
}

function initGridView() {
    var gridId = "gridView";
    var BOARD_ID = '${data.BOARD_ID}';
    var BOARD_TYPE = '${boardInfo.BOARD_TYPE}';
    var roleList = '${SESSION_INFO.ROLE_LIST}';
    var cm = [];
    
    gridView = new RealGridJS.GridView(gridId);
    
    addField(cm ,   'SEQ',              {text: '번호'},           40,     'text');
    if(BOARD_TYPE == 'FAQ') {
        addField(cm ,   'CONTENTS_CLS_NM',  {text: '구분'},       60,     'text');
    }else {
    	addField(cm ,   'NOTICE_NM',  {text: '공지여부'},           60,     'text');
    }
    addField(cm ,   'SUBJECT',          {text: '제목'},           200,    'textLink',     {textAlignment: "near"});
    if(BOARD_ID == '201') {
        addField(cm ,   'CLOSED_YN',        {text: '익명여부'},         40,     'text'),  '', {visable:"false"};
        addField(cm ,   'CLOSED_NM',        {text: '익명여부'},         40,     'text');
    }
    if(roleList.indexOf('${PropertiesUtil.getProperty("ROLE_BBS")}') != -1) {
        addField(cm ,   'USER_NM',          {text: '작성자'},          80,     'text');
        addField(cm ,   'DEPT_NM',          {text: '작성자소속'},        80,     'text');
    }
    addField(cm ,   'HIT_CNT',          {text: '조회수'},          40,     'number');
    addField(cm ,   'INS_DT',           {text: '등록일'},          80,     'datetime', {textAlignment: "center"}, {datetimeFormat: "yyyy-MM-dd"});
      
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 300       //required 그리드 높이
        ,columns        : cm        // required
        ,dynamicResize  : true
        ,checkBar       : false     //default true  앞쪽 체크박스 표시 여부
        ,editable       : false     //default false 그리드 전체 에디트 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,copySingle : false // default ture : 복사하지 않음 
        ,autoHResize    : true       //화면 크기에 맞게 높이 자동조절
        ,viewCount      : true       //조회 건수 표시
    });
    
    gridView.onDataCellClicked = function (grid, colIndex) {
        
        if ( colIndex.fieldName === "SUBJECT" ) {
            var params = fnParams();
            $.extend(params, gridView.getCurrentRow());
            
            fnPostGoto("<c:url value='/com/mgt/mgtBoardViewPop.do'/>", params, "_self");
        }  
    };
}

function boardListWithAjax(page){
    var params = fnParams();
    params.status = "1";
    console.log( "params =" + JSON.stringify( params));

    ajaxJsonCall('<c:url value="/com/mgt/selectMgtBoardList.do"/>',  params, fnSuccess);
}



function fnSuccess(data) {
    gridView.setPageRows(data);
}

function fnParams() {
    var params = fnGetParams();
    params['BOARD_ID'] = '${data.BOARD_ID}';
    params['userId'] = '${SESSION_INFO.USER_ID}';
    return params;
}

</script>

<div class="pop-wrap">
    <div class="pop-head">
		<div class="cont-tit" style="height:60px;">
		    <h2>${boardInfo.BOARD_NM}</h2>
		</div>
	</div>
	<div class="pop-cont">
		<div class="search_field_wrap">
		    <div class="search_field_area">
		        <table class="search_field">
		            <colgroup>
		                <col>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <td>
		                        <select id="srchGrp" name="srchGrp">
		                            <option value = "01">제목</option>
		                            <option value = "02">내용</option>
		                            <option value = "03">작성자</option>
		                        </select>
		                        <input type="text" id="srchTxt" name="srchTxt" class="w220" />
		                    </td>
		                </tr>
		            </tbody>
		        </table>                    
		    </div><!-- //searchTableArea -->
		    <div class="search_btn_area">
		        <button class="search_btn" id="btnSearch">조회</button>
		    </div><!-- //search_btn_area -->
		</div><!-- // search_field_wrap -->
	
		<div class="realgrid-area">
		    <div id="gridView"></div>
		</div>
	</div>
</div>

