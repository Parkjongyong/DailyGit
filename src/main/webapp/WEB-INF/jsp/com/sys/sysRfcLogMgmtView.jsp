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
        setEvent();
        setInitGrid();
    });
    
    //초기화함수
    function init() {
    }
    
    //이벤트셋팅
    function setEvent() {
        $("#btnSearch").click(function(e) {
        	searchList();
        });
        
        $(document).on("click", "#btnWrite", function(e){
        	fnShowDetail();
        });
        
        //Enter 이벤트
        $(".enterEvnt").keyup(function(e) {
            if (e.keyCode == 13) {
            	searchList();
            }
        });
    }
    
    /****************************************** 구매요청 목록 Grid **********************************************/
    
    function setInitGrid() {
        var gridId = "gridView";
        gridView = new RealGridJS.GridView(gridId);
        
        var colModel = [];
        // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
        addField(colModel, 'JCO_SEQ',           {text: 'JCO_SEQ'},       50,     'text',      {textAlignment: 'center'});
        addField(colModel, 'FUNCTION_NAME',     {text: 'FUNCTION_NAME'}, 80,     'text',      {textAlignment: 'center'});
        addField(colModel, 'RESULT_NM',         {text: '상태'},     80,     'text',      {textAlignment: 'center'});
        addField(colModel, 'RESULT_MSG',        {text: 'RESULT_MSG'},    250,     'text',      {textAlignment: 'near'});
        
        addField(colModel, 'D_JCO_PARAMS',      {text: 'JCO_PARAMS'},   50,     'popupLink');
        addField(colModel, 'D_JCO_DATA',        {text: 'JCO_DATA'},     50,     'popupLink');
        
        addField(colModel, 'START_DT',          {text: '시작시간'},        100,     'text',      {textAlignment: 'center'});
        addField(colModel, 'END_DT',            {text: '종료시간'},        100,     'text',      {textAlignment: 'center'});
        
        addField(colModel, 'RNUM',            {text: 'RNUM'},                0,    'text',     {textAlignment: "center"},  {visible:false});
        addField(colModel, 'RESULT_CD',       {text: 'RESULT_CD'},           0,    'text',     {textAlignment: "center"},  {visible:false});
        
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
       
       gridView.onDataCellClicked =  function (grid, index) {
           if (index.column == "D_JCO_PARAMS" || index.column == "D_JCO_DATA") {
               fnShowDetail(index);
           }
       };
       
       searchList();
    }
    
    function loadNext() {
        var params = fnGetParams();
        var newStart = gridView.getDataProvider().getRowCount()+1;
        
        $.extend(params, {"page" : newStart});
        $.extend(params, {"pageSize" : newStart+499});
        
        ajaxJsonCall('<c:url value="/com/sys/selectRfcLogMgmtList.do"/>',  params, function(data){
            gridView.addRows(data.rows, data.records);
        });
    }
    
    //RFC Log 조회
    function searchList() {
        
        var params = fnGetParams();
        ajaxJsonCall('<c:url value="/com/sys/selectRfcLogMgmtList.do"/>',  params, fnSuccess);
    }
    
    function fnSuccess(data) {
        scrollItem = 460;
        
        if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
            alert(data.errMsg);
            return;
        }
        
        gridView.clearRows();
        gridView.setPageRows(data);
    }
    
    //상세화면 팝업
    function fnShowDetail(row) {
        
        var params = fnGetMakeParams();
        $.extend(params, {"JCO_SEQ" : gridView.getValue(row.itemIndex, "JCO_SEQ")});
        
        var target = "sysRfcLogMgmtDetail";
        var width = "1024";
        var height = "768";
        
        fnPostPopup("<c:url value='/com/sys/sysRfcLogMgmtDetailPop'/>", params, target, width, height); 
    };
    

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
                    <th><strong class="stit">Function명</strong></th>
                    <td>
                        <input type="text" id="S_FUNCTION_NAME" class="wp100" maxlength="20">
                    </td>
                    <th><strong class="stit">일자</strong></th>
                    <td>
                        <input type="text" class="datepicker t_center" id="S_START_DT" dateHolder="bgn" value=""/>
                        <em> ~ </em>
                        <input type="text" class="datepicker t_center" id="S_END_DT" dateHolder="end" value=""/>
                    </td>
                    <th><strong class="stit">상태</strong></th>
                    <td>
                        <select id="S_RESULT_CD" name="S_STATUS">
                            <option value="">전체</option>
                            <option value="S">성공</option>
                            <option value="E">오류</option>
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