<%--
    Class Name sysAccessLogList.jsp
    Description: 로그관리
    Modification Information
        수정일                  수정자      수정내용
    ---------  ------ ---------------------------
    2020.06.19  박종용     최초 생성
    author: 박종용
    since: 2020.06.19
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s"  uri="http://www.springframework.org/tags"%>

<script language="javascript">
var gridView;
var scrollItem = 460;

$(document).ready(function() {
	init();
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
	setInitGrid();
});

//초기화함수
function init() {
}

var setInitGrid = function(){
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
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
        ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
        ,columns        : colModel        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,insertable : true
        ,appendable : true
        ,copySingle : false // default ture : 복사하지 않음
        //,autoHResize    : true     //윈도우 높이가 변경시 그리드 전체 높이 자동 조절
        ,viewCount      : true      //그리드 건수 표현
    });
	 
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
    
    ajaxJsonCall('<c:url value="/com/sys/selectSysAccessLogList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}

//알림 Log 조회
function fnSearch() {
	searchCall(gridView, '/com/sys/selectSysAccessLogList');
}

// 조회 후 처리
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 그리드 초기화
    gridView.clearRows();
	// 그리고 데이터 setting
    gridView.setPageRows(data);
    // 상태바 비활성화
    gridView.closeProgress();
}


</script>

<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
	<div class="btnArea abtit">
	</div>    
</div>

<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
            <colgroup>
                <col style="width:100px">
                <col style="width:450px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                	<th><span>유저아이디</span></th>
                    <td>
                        <input type="text" id="USER_ID" class="w100">
                    </td>
                    <td></td>
                </tr>
            </tbody>
        </table>                    
    </div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap -->
<br/>

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>
