<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<%--
JCO retrun log 팝업화면
 --%>
<script type="text/javascript">
    var grid;
    
    /*********************************** 화면 제어 및 이벤트 설정 ************************************/

    $(document).ready(function() {
        //초기화함수
        init();
        //이벤트셋팅
        setEvent();
        //그리드 초기화
        setInitGrid();
        //조회 
        searchList();
    });
    
    //초기화함수
    function init() {
    	$("#JCO_SEQ").val  ('${param.JCO_SEQ}');
    	$("#REF_DATA1").val('${param.REF_DATA1}');
    	$("#REF_DATA2").val('${param.REF_DATA2}');
    	$("#REF_DATA3").val('${param.REF_DATA3}');
    }
    
    //이벤트셋팅
    function setEvent() {
    }
    
    //데이타 조회 후 화면제어
    function setDisplayElement() {
    }
  
    //그리드 초기화 함수
    function setInitGrid() {
    	setGrid();
    }
    
    /********************************** 그리드 셋팅 ***************************************/
    function setGrid() {
    	var gridId = "grid";
    	grid = new RealGridJS.GridView(gridId);
    	    	
        var colModel = [];
        // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
        addField(colModel, 'JCO_SEQ',     {text: 'JCO일련번호'}, 100, 'text', {textAlignment: 'center'});
        addField(colModel, 'RFC_NAME',    {text: 'RFC명'},       180, 'text');
        addField(colModel, 'TYPE',        {text: '리턴코드'},     80, 'text', {textAlignment: 'center'});
        addField(colModel, 'MESSAGE',     {text: '메세지'},      200, 'text');
        addField(colModel, 'INS_DT',      {text: '일시'},        130, 'text', {textAlignment: 'center'});
        addField(colModel, 'CODE',        {text: '메세지코드'},   10, 'text', '', {visible:false});
        addField(colModel, 'LOG_NO',      {text: '로그번호'},           30, 'text', '', {visible:false});
        addField(colModel, 'LOG_MSG_NO',  {text: '내부메세지일련번호'}, 30, 'text', '', {visible:false});
        addField(colModel, 'MESSAGE_V1',  {text: '메세지1'},     100, 'text');
        addField(colModel, 'MESSAGE_V2',  {text: '메세지2'},     100, 'text');
        addField(colModel, 'MESSAGE_V3',  {text: '메세지3'},     100, 'text');
        addField(colModel, 'MESSAGE_V4',  {text: '메세지4'},     100, 'text');
        
        grid.rgrid({
             gridId         : gridId    //required 그리드 ID
            ,height         : 58       //required 그리드 높이
            ,width          : "100%"
            ,columns        : colModel        // required
            ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
            ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
            ,indicatorDp  : "index"   //default "index" 컬럼번호 표시 방식 : none, row, index(정렬무시)
            ,editable : false
            ,appendable : false
            ,copySingle : false // default ture : 복사하지 않음 
            ,autoHResize    : true 
        });
        //셀이 수정된후 
        grid.onCellEdited = function (grid, itemIndex, dataRow, field) {
        	grid.commit(); //강제 커밋.
        };
        
        grid.setColumnProperty("JCO_SEQ",   "mergeRule", {criteria:"value"})
        grid.setColumnProperty("RFC_NAME",  "mergeRule", {criteria:"prevvalues+value"})
    }
    
    //목록조회
    function searchList() {
        grid.showProgress();
        var params = fnGetParams();
        ajaxJsonCall('<c:url value="/com/cmn/selectJcoReturnLogList.do"/>',  params, fnSuccess);
    }
    
    function fnSuccess(data) {
        if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
            alert(data.errMsg);
            return;
        }
        grid.setPageRows(data);
        grid.closeProgress();
    }
    
</script>
<input type="hidden" id="JCO_SEQ">
<input type="hidden" id="REF_DATA1">
<input type="hidden" id="REF_DATA2">
<input type="hidden" id="REF_DATA3">
<div class="pop-wrap" style="width:100%;min-width:300px">
    <div class="pop-head">
        <h2>RFC 호출 결과</h2>
    </div><!-- //popHead -->
    <div class="pop-cont">  
        <div class="sub-tit">
            <h4>결과</h4>
        </div>
        <!-- realgrid 들어가는 영역 : S -->
        <div class="realgrid-area">
            <div id="grid"></div>
        </div>
    </div>
</div>
