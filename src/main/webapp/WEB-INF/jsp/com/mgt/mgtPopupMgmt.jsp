<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions"%>

<s:eval var="_dateUtil"               expression="T(com.app.ildong.common.util.DateUtil)"/>
<s:eval var="_unformat_today"         expression="_dateUtil.getToday()"/>
<s:eval var="_today"                  expression="_dateUtil.formatDate(_unformat_today, '-')"/>                  <%-- 포맷된 오늘날짜 --%>
<s:eval var="_getMonthFirstDay"       expression="_dateUtil.formatDate(_dateUtil.getMonthFirstDay(), '-')"/>     <%-- 포맷된 현재월 1일 --%>

<script type="text/javascript">
var gridView;

$(document).ready(function() {
	init();
	setInitGrid();
	searchList();
});

//초기화함수
function init() {
	
	$(document).on("click", "#btnSearch", function(e){
		searchList();
    });
	
	$(".enterEvnt").keyup(function(e) {
        if (e.keyCode == 13) {
        	searchList();
        }
    });
	
	$(document).on("click", "#btnWrite", function(e){
		fnWrite();
    });
	
	$("#S_START_DT").val(firstDayByMonth(getDiffDay("m",-1))); //한달전 첫째일
}

function setInitGrid() {
    var gridId = "gridView";
    gridView = new RealGridJS.GridView(gridId);
    
    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
  
    addField(cm,    'RNUM',         {text: '상세보기'},      50,     'popupLink');
    addField(cm,    'RNUM2',        {text: '편집'},        50,     'popupLink');
    addField(cm,    'START_DATE',   {text: '시작일'},      100,     'datetime',  {textAlignment: "center"}, {datetimeFormat: "yyyy-MM-dd"});
    addField(cm,    'END_DATE',     {text: '종료일'},      100,     'datetime',  {textAlignment: "center"}, {datetimeFormat: "yyyy-MM-dd"});
    addField(cm,    'WIDTH',        {text: '가로크기'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'HEIGHT',       {text: '세로크기'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'TOP',          {text: '상단위치'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'LEFT',         {text: '왼쪽위치'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'SUBJECT',      {text: '제목'},       250,     'text',     {textAlignment: 'near'});
    addField(cm,    'SITE',         {text: '내부/외부'},     80,     'text',     {textAlignment: 'center'});
    addField(cm,    'PRESENT_FLAG', {text: '표시시점'},      80,     'text',     {textAlignment: 'center'});
    addField(cm,    'DEL_YN',       {text: '사용여부'},      80,     'text',     {textAlignment: 'center'});

    addField(cm,    'SEQ',          {text: 'SEQ'},        0,     'text',     {textAlignment: "center"},  {visible:false});
    
    gridView.rgrid({
         gridId         : gridId    //required 그리드 ID
        ,height         : 300       //required 그리드 높이
        ,columns        : cm        // required
        ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
        ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
        ,copySingle     : false // default ture : 복사하지 않음
        ,autoHResize    : true       //화면 크기에 맞게 높이 자동조절
        ,viewCount      : true       //조회 건수 표시
        
    });
    
    gridView.onDataCellClicked =  function (grid, index) {
        if (index.column == "RNUM") {
            fnShowDetail(index);
        }else if (index.column == "RNUM2") {
        	fnModifyPop(index);
        }
    };
}
    
function searchList() {
    var params = fnGetParams();
    ajaxJsonCall('<c:url value="/com/mgt/selectMgtPopupMgmtList.do"/>',  params, fnSuccess);
}
    
function fnSuccess(data) {
	
	gridView.setPageRows("");
	
	if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
		alert(data.errMsg);
		return;
	}
	gridView.setPageRows(data);
}

var fnShowDetail = function(row) {/* used 시행결의 상세 보기 */
    
    var params = fnGetMakeParams();
    $.extend(params, {"SEQ" : gridView.getValue(row.itemIndex, "SEQ")});
        
    var target = "mgtPopupMgmtView_"+gridView.getValue(row.itemIndex, "SEQ");
    var width = gridView.getValue(row.itemIndex, "WIDTH");
    var height = gridView.getValue(row.itemIndex, "HEIGHT");
    var top = gridView.getValue(row.itemIndex, "TOP");
    var left = gridView.getValue(row.itemIndex, "LEFT");
    var scrollbar = "yes";
    var resizable = "yes";
    
    window.open("", target, "width=" + width + ",height=" + height + ",left=" + left + ",top=" + top + ",status=no, scrollbars=" + scrollbar + ", resizable=" + resizable );
    fnPostGoto('<c:url value="/com/mgt/mgtPopupMgmtView.do"/>', params, target);
    
};

var fnModifyPop = function(row) {
	var params = fnGetMakeParams();
    
    
	var params = fnGetMakeParams();
    $.extend(params, {"SEQ" : gridView.getValue(row.itemIndex, "SEQ")});
        
    var target = "mgtPopupMgmtModify_"+gridView.getValue(row.itemIndex, "SEQ");
    var width  = "970";
    var height = "800";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('<c:url value="/com/mgt/mgtPopupMgmtModify.do"/>', params, target, width, height, scrollbar, resizable);
}

var fnWrite = function(){
    var params = fnGetParams(); 
    
    var target = "mgtPopupMgmtWrite";
    var width  = "970";
    var height = "800";
    var scrollbar = "yes";
    var resizable = "yes";
    
    fnPostPopup('<c:url value="/com/mgt/mgtPopupMgmtWrite.do"/>', params, target, width, height, scrollbar, resizable);
}
    

</script>
<div class="cont-tit">
    <h3>${G_MENU_NM}</h3>
    
    <div class="right">
        <button type="button" class="btn st1" id="btnWrite">새 팝업 작성</button>
    </div>
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
                    <th><strong class="stit">기간</strong></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="S_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="S_END_DT" dateHolder="end" value=""/>
                    </td>
                    <th>내부/외부</th>
                    <td>
                        <select id="S_SITE" class="wp100">
                            <option value="">선택</option>
                            <option value="A">전체</option>
                            <option value="I">내부</option>
                            <option value="E">외부</option>
                        </select>
                    </td>
                    <th>사용여부</th>
                    <td>
                        <select id="S_DEL_YN" class="wp100">
                            <option value="">전체</option>
                            <option value="N">사용</option>
                            <option value="Y">미사용</option>
                        </select>
                    </td>   
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