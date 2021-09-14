<%--
    Class Name sysAlarmLogMgmtView.jsp
    Description: 알림 발송 로그
    Modification Information
        수정일                  수정자      수정내용
    ---------  ------ ---------------------------
    2020.06.19  박종용     최초 생성
    author: 박종용
    since: 2020.06.19
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<s:eval var="_dateUtil"               expression="T(com.app.ildong.common.util.DateUtil)"/>
<s:eval var="_unformat_today"         expression="_dateUtil.getToday()"/>
<s:eval var="_today"                  expression="_dateUtil.formatDate(_unformat_today, '-')"/>                  <%-- 포맷된 오늘날짜 --%>
<s:eval var="_getMonthFirstDay"       expression="_dateUtil.formatDate(_dateUtil.getMonthFirstDay(), '-')"/>     <%-- 포맷된 현재월 1일 --%>

<script type="text/javascript">
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
    
    /****************************************** 구매요청 목록 Grid **********************************************/
    
    function setInitGrid() {
        var gridId = "gridView";
        gridView = new RealGridJS.GridView(gridId);
        
        var colModel = [];
        // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
        addField(colModel, 'SEQ',           {text: 'SEQ'},              50,     'text',      {textAlignment: 'center'});
        addField(colModel, 'MAIL_ID',       {text: 'ID명'},              80,     'text',      {textAlignment: 'center'});
        addField(colModel, 'MSG_TYPE',      {text: '유형'},               80,     'text',      {textAlignment: 'center'});
        addField(colModel, 'FROM_ID',       {text: '발신자'},              100,     'text',      {textAlignment: 'near'});
        addField(colModel, 'TO_ID',         {text: '수신자'},              100,     'text',      {textAlignment: 'near'});
        addField(colModel, 'SUBJECT',       {text: '제목'},               250,     'text',      {textAlignment: 'near'});
        addField(colModel, 'D_CONTENT_DATA',{text: '내용 상세보기'},   50,     'popupLink');
        addField(colModel, 'INS_DT',          {text: '등록시간'},        100,     'text',      {textAlignment: 'center'});
        addField(colModel, 'RNUM',            {text: 'RNUM'},           0,    'text',     {textAlignment: "center"},  {visible:false});
        
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
               fnLoadNext();
           }
       }
       
       gridView.onDataCellClicked =  function (grid, index) {
           if (index.column == "D_CONTENT_DATA") {
               fnShowDetail(index);
           }
       };
       
       fnSearch();
    }
    
  	//다음 페이지 조회
    function fnLoadNext() {
        var params = fnGetParams();
        var newStart = gridView.getDataProvider().getRowCount()+1;
        
        $.extend(params, {"page" : newStart});
        $.extend(params, {"pageSize" : newStart+499});
        
        searchCall(gridView, '/com/sys/selectAlarmLogMgmtList', 'fnLoadNext', params);
    }
    
    //다음 페이지 조회 후 처리
    function fnLoadNextSuccess(data) {
    	gridView.addRows(data.rows, data.records);
    }    
    
    //알림 Log 조회
    function fnSearch() {
    	searchCall(gridView, '/com/sys/selectAlarmLogMgmtList');
    }
    
    //조회 후 처리
    function fnSearchSuccess(data) {
        scrollItem = 460;
        
    	// 에러메세지 처리
    	alertErrMsg(data);
    	// 그리드 초기화
        gridView.clearRows();
    	// 그리고 데이터 setting
        gridView.setPageRows(data);
        // 상태바 비활성화
        gridView.closeProgress();
    }
    
    //상세화면 팝업
    function fnShowDetail(row) {
        
        var params = fnGetMakeParams();
        $.extend(params, {"SEQ" : gridView.getValue(row.itemIndex, "SEQ")});
        
        var target = "sysAlarmLogMgmtDetailPop";
        var width = "1024";
        var height = "568";
        
        fnPostPopup('/com/sys/sysAlarmLogMgmtDetailPop', params, target, width, height); 
    };
    

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
                <col style="width:70px">
                <col style="width:480px">
                <col style="width:70px">
                <col style="width:480px">
                <col style="width:70px">
                <col style="width:480px">
                <col>
            </colgroup>
            <tbody>
                <tr>
                	<th><span>ID명</span></th>
                    <td>
                        <input type="text" id="S_ID_NAME" maxlength="20">
                    </td>
                    <th><span>일자</span></th>
                    <td>
                        <span class="date-area">
                        	<input type="text" class="datepicker" id="TB_START_DT" dateHolder="bgn">
                        </span>
                        <em> ~ </em>
                        <span class="date-area">
                        	<input type="text" class="datepicker" id="TB_END_DT" dateHolder="end">
                        </span>
                    </td>
                    <th><span>유형</span></th>
                    <td>
                        <select id="S_MSG_TYPE" name="S_MSG_TYPE">
                            <option value="">전체</option>
                            <option value="MAIL">MAIL</option>
                            <option value="SMS">SMS</option>
                        </select>
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
<br>
<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridView"></div> 
</div>