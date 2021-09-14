<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
    var gridView;
    
    $(document).ready(function() {
        //초기화 함수
        init();
        //이벤트셋팅
        setEvent();
        //그리드 초기화
        setInitGrid();
        
        searchAlarmList();
        
        $("#detail").dialog({ autoOpen: false, width: 800  });
    });

    
    //초기화함수
    function init() {
        
    }
    
    //이벤트셋팅
    function setEvent() {
    	//불러오기
        $("#btnSearch").click(function(e) {
        	searchAlarmList();
        });
    }
    
    
    //그리드 초기화 함수
    function setInitGrid() {
        var gridId = "gridList";
        gridView = new RealGridJS.GridView(gridId);
        
        var colModel = [];
        // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
        addField(colModel,     'SEQ',      {text: '상세보기'},        40, 'popupLink');
        addField(colModel ,   'MAIL_ID',   {text: 'MAIL_ID'},       0,   'text',     {textAlignment: 'center'}, {visible : false});
        addField(colModel ,   'INS_DT',    {text: '일자'},           50,   'text',     {textAlignment: 'center'});
        addField(colModel ,   'SUBJECT',   {text: '알림제목'},        80,   'text');
        addField(colModel ,   'CONTENT',   {text: '알림내용'},        0,   'text', '', {visible : false});
        
        
        gridView.rgrid({
             gridId         : gridId    //required 그리드 ID
            ,height         : 300       //required 그리드 높이
            //,width            : "100%"    //default 100% 그리드 넓이
            //,rowHeight        : 30        //default 30 row height
            ,columns        : colModel        // required
            //,headerHeight : 30        //default null  헤더 사이즈
            ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
            //,exclusive        : false     //default false 한 행만 체크 가능할지의 여부를 지정한다.
            //,editable       : true     //default false 그리드 전체 에디트 여부
            ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
            //,columnMovable    : false     //default false 컬럼 이동가능 여부
            //,columnResizable: true        //default true  이 값이 False로 설정하면 사용자가 모든 컬럼의 크기를 변경할 수 없습니다.
            //,footerVisible    : false     //default false 그리드 footer 표시 여부
            //,stateBarVisible: false       //default false 컬럼 상태 표시 여부
            ,indicatorDp  : "index"   //default "index" 컬럼번호 표시 방식 : none, row, index(정렬무시)
            //,rowStylesFirst   : false     //default false row<->column 색상 우선순위 : true:column우선, false:row우선
            //,pager            : pagerParam//default 페이지 없음.
            //,dynamicResize  : true      //default false 동적 그리드 높이 변경
            //,appendable : true
            //,pager : pagerParam
            ,autoHResize    : true
            ,viewCount      : true
            ,copySingle : false // default ture : 복사하지 않음 
        });
        
        gridView.onDataCellClicked =  function (grid, index) {
            if (index.column == "SEQ") {
                fnShowDetail(index);    
            }
        };
    }
    
    //파라미터 셋팅
    function fnParams() {
        var params = fnGetParams();
        return params;
    }
    
    //안 읽은 알람 조회
    function searchAlarmList() {
        fnDoQuery(1);
    }
    
    var fnDoQuery = function(pageNo) {
        var params = {};
        ajaxJsonCall("<c:url value='/com/mai/selectAlarmList.do'/>",  params, fnSuccess);
    };
    
    function fnSuccess(data) {
        if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
            alert(data.errMsg);
            return;
        }
        gridView.setPageRows(data);
    }
    
    //알람 상세
    function fnShowDetail(row) {
        var rowData = gridView.getCurrentRow();
        $("#detail").empty().append(rowData.CONTENT);
        $("#detail").dialog( "open" );
      
        var params = {SEQ : rowData.SEQ};
        ajaxJsonCall('<c:url value="/com/mai/updateAlertRead.do"/>',  params);
    };
</script>

<div class="pop-wrap">
    <div class="pop-head">
		<h2>메일 알림 현황</h2>
		<div class="head-btn">
            <button type="button" id="btnSearch" class="btn">조회</button>
        </div>
	</div><!-- //popHead -->
	<div class="pop-cont">
	    <!-- realgrid 들어가는 영역 : S -->
        <div class="realgrid-area">
            <div id="gridList"></div>
        </div>
	</div><!-- //pop-cont -->
</div><!-- //pop-wrap -->

<div id="detail" style="display:none;" title="메일 상세보기">메일 내용</div>
