<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s"  uri="http://www.springframework.org/tags"%>

<script language="javascript">
var gridView;
var scrollItem = 460;

$(document).ready(function() {
	init();
	setEvent();
	setInitGrid();
});

//초기화함수
function init() {
}

//이벤트셋팅
function setEvent() {
	
	 //조회
    $("#btnSearch").on('click', function(){
        searchList();
    });
    
    //엔터키 이벤트
    $("input[type='text']").keydown(function(e){
        if(e.keyCode==13){
            searchList();
        }
    });
    
    $(".enterEvnt").keyup(function(e) { //입력창 Enter 이벤트
        if (e.keyCode == 13) {
            searchList();
        }
    });
    
	
}


var setInitGrid = function(){
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    console.log(gridView);
	var colModel = [];
	
	// obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
	addField(colModel, 'SNO'   ,  {text: 'No'}      , 40,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'SERVER_IP',  {text: '서버아이피'} , 80,    'text',      {textAlignment: 'center'}, {visible:false});
	addField(colModel, 'SYS_ID'   ,  {text: '시스템아이디'} , 80,    'text',      {textAlignment: 'center'}, {visible:false});
	addField(colModel, 'TYPE_ID'  ,  {text: '접속타입'}  , 60,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'USER_ID'  ,  {text: '유저아이디'} , 60,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'USER_IP'  ,  {text: '유저아이피'} , 60,    'text',      {textAlignment: 'center'}, {editable:false});
	
	addField(colModel, 'URL' ,  {text: 'URL'}    ,200,    'text',      {textAlignment: 'near'}, {editable:false});
	addField(colModel, 'MENU_CD' ,  {text: '메뉴코드'}    , 60,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'SESSION_ID' ,  {text: '세션 값'}    , 180,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'PROC_START_TIME' ,  {text: '처리 시작 시간'}    , 110,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'PROC_END_TIME' ,  {text: '처리 종료 시간'}    , 110,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'PROC_DELAY_TIME' ,  {text: '처리\n지연 시간'}    , 70,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'SUCC_YN'  ,  {text: '성공\n여부'}  , 40,    'text',      {textAlignment: 'center'}, {editable:false});
	addField(colModel, 'ERR_MSG'  ,  {text: '에러메세지'} , 100,    'text',      {textAlignment: 'near'}, {editable:false});
	addField(colModel, 'REG_DATE' ,  {text: '등록일'}    , 80,    'text',      {textAlignment: 'center'}, {editable:false});

	
	gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
        ,height         : 300       //required 그리드 높이
        ,columns        : colModel        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,insertable : true
        ,appendable : true
        ,copySingle : false // default ture : 복사하지 않음
        ,autoHResize    : true     //윈도우 높이가 변경시 그리드 전체 높이 자동 조절
        ,viewCount      : true      //그리드 건수 표현
    });
	 
	gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
            scrollItem += 450;
            loadNext();
        }
    }
	
	
    searchList(); 
	 
} 

function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+499});
    
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtAccessLogList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}

//알림 Log 조회
function searchList() {
    
    var params = fnGetParams();
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtAccessLogList.do"/>',  params, fnSuccess);
}

function fnSuccess(data) {
    if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
        alert(data.errMsg);
        return;
    }
    
    gridView.clearRows();
    gridView.setPageRows(data);
}


</script>

<div class="cont-tit">
    <h3>${G_MENU_NM}</h3>
</div>


<div class="search_field_wrap">
    <div class="search_field_area">
        <table class="search_field">
            <colgroup>
                <col style="width:100px">
                <col>
                <col style="width:100px">
                <col>
                <col style="width:100px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th><strong class="stit">유저아이디</strong></th>
                    <td>
                        <input type="text" class="wp100" id="USER_ID">
                    </td>
                    <th colspan="4"></th>
                    
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
    <div class="search_btn_area">
        <button class="search_btn" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap -->


<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
