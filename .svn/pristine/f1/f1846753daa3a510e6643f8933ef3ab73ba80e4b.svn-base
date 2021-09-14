<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c"       uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"  uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"      uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/tags"%>

 
</head>

<script type="text/javascript">
var $grid;
var gridListIn;
var gridListOut;

$(document).ready(function() {
    
    fnInitStatus();
    setInitGridIn();
    setInitGridOut();
    
});

function fnInitStatus() {

    $("#btnInChange").click(function(e){
        alert("내부자 변경");
    });
    $("#btnOutChange").click(function(e){
        alert("외부자 변경");
    });
    $("#btnInSearch").click(function(e){
        fnDoQuery('in');
    });
    $("#btnOutSearch").click(function(e){
        fnDoQuery('out');
    });
    $("#btnReset").click(function(e){
        fnAllPwdChg();
    });
    $("#btnResetIn").click(function(e){
        fnInAllPwdChg();
    });
    
    
    $("#USER_NAME").keypress(function(e){
        if(e.keyCode == 13) {
            fnDoQuery('in');
        }
    });
    $("#USER_ID").keypress(function(e){
        if(e.keyCode == 13) {
            fnDoQuery('in');
        }
    });
    $("#POBUSI_NM").keypress(function(e){
        if(e.keyCode == 13) {
            fnDoQuery('out');
        }
    });
    $("#POBUSI_REG_NO").keypress(function(e){
        if(e.keyCode == 13) {
            fnDoQuery('out');
        }
    });
    
}

function setInitGridIn() {
    var gridId = "gridListIn";
    gridListIn = new RealGridJS.GridView(gridId);
    
    var colModel = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(colModel, 'USER_ID',       {text: '사용자ID'},     100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'USER_NAME',     {text: '사용자명'},    100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'DEPT_NAME',     {text: '부서'},      100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'TEL_NO',        {text: '전화번호'},    100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'MOBLIE_NO',     {text: '휴대전화'},    100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'EMAIL_ID',      {text: '메일주소'},    100,    'text',      {textAlignment: 'center'});
    
    gridListIn.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : 300       //required 그리드 높이
       ,columns        : colModel        // required
       ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
       ,editable       : false     //default false 그리드 전체 에디트 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,appendable : true
       ,copySingle : false // default ture : 복사하지 않음 
   });
    
    gridListIn.onCurrentRowChanged =  function (grid, itemIndex, dataRow, field) {
    	
        $("#USER_NAME").val(grid.getValue(itemIndex, 'USER_NAME'));
        $("#USER_ID").val(grid.getValue(itemIndex, 'USER_ID'));
    };
}

function setInitGridOut() {
	var gridId = "gridListOut";
	gridListOut = new RealGridJS.GridView(gridId);
    
	var colModel = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(colModel, 'USER_ID',       {text: '사용자ID'},     100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'USER_NAME',     {text: '사용자명'},    100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'POBUSI_NM',     {text: '공급업체명'},     100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'POBUSI_REG_NO', {text: '사업자번호'},    100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'BIZ_ID_TYPE',   {text: 'ID구분'},     100,    'text',      {textAlignment: 'center'});
    addField(colModel, 'REPRE_NM',     {text: '대표자명'},    100,    'text',      {textAlignment: 'center'});
    
    //url : '<c:url value="/com/usr/selectBusrUserSearchOutList.do"/>'
    
    gridListOut.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : 300       //required 그리드 높이
       ,columns        : colModel        // required
       ,checkBar       : true     //default true   앞쪽 체크박스 표시 여부
       ,editable       : false     //default false 그리드 전체 에디트 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,appendable : true
       ,copySingle : false // default ture : 복사하지 않음 
   });
    
    gridListOut.onCurrentRowChanged =  function (grid, itemIndex, dataRow, field) {
        
        $("#POBUSI_NM").val(grid.getValue(itemIndex, 'POBUSI_NM'));
        $("#POBUSI_REG_NO").val(grid.getValue(itemIndex, 'POBUSI_REG_NO'));
    };
}




var fnDoQuery = function(flag) {/* used 시행결의 및 견적요청 조회 */

    var gridList = '';
    if(flag == 'in') {
    	searchInList();
    } else {
    	searchOutList();
    }
    
};

function fnParams() {
    var params = fnGetParams();

    return params;
}


//외부유저 비밀번호 초기화
function fnAllPwdChg(){
    
    var params  = {};
    
    if(confirm("전체사용자의 비밀번호가 초기화 됩니다.\n전체사용자의 비밀번호가 초기화 됩니다.\n\n외부 사용자 비밀번호가 초기화(사업자번호와 동일) 됩니다.\n진행하시겠습니까?\n")){
        ajaxJsonCall("<c:url value='/com/usr/updateAllUserPwd.do'/>", params, function(obj){
            alert("비밀번호가 초기화 되었습니다.");
        });
    }
}

//내부유저 비밀번호 초기화
function fnInAllPwdChg(){
    var params  = {};
    
    if(confirm("전체사용자의 비밀번호가 초기화 됩니다.\n전체사용자의 비밀번호가 초기화 됩니다.\n\n내부 사용자 비밀번호가 초기화(유저아이디와 동일) 됩니다.\n진행하시겠습니까?")){
        ajaxJsonCall("<c:url value='/com/usr/updateInAllUserPwd.do'/>", params, function(obj){
            alert("비밀번호가 초기화 되었습니다.");
        });
    }
}

function searchInList() {
	gridListIn.showProgress();
    var params = fnGetParams();
    ajaxJsonCall('<c:url value="/com/usr/selectBusrUserSearchInList.do"/>',  params, function(data){
    	if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
            alert(data.errMsg);
            return;
        }
        
    	gridListIn.clearRows();
        
    	gridListIn.setPageRows(data);
    	gridListIn.closeProgress();
    });
}

function searchOutList() {
	gridListOut.showProgress();
    var params = fnGetParams();
    ajaxJsonCall('<c:url value="/com/usr/selectBusrUserSearchOutList.do"/>',  params, function(data){
        if (typeof data.status != 'undefined' && 'SUCC' !== data.status) {
            alert(data.errMsg);
            return;
        }
        
        gridListOut.clearRows();
        
        gridListOut.setPageRows(data);
        gridListOut.closeProgress();
    });
}

</script>

<div class="cont-tit">
    <h3>${G_MENU_NM}</h3>
    
    <div class="right">
        <button type="button" class="btn" id="btnInChange">내부자 변경</button>
        <button type="button" class="btn" id="btnOutChange">외부자 변경</button>
    </div>
</div>

<div class="sub-tit">
    <h4>사용자 조회</h4>
</div>

<div class="search_field_wrap">
    <div class="search_field_area">
        <table class="search_field">
            <colgroup>
                <col style="width:25%;">
                <col style="width:25%;">
                <col style="width:25%;">
                <col style="width:25%;">
            </colgroup>
            
            <tbody>
                <tr>
                    <tr>
                        <th><strong class="stit">사용자명</strong></th>
                        <td>
                            <input type="text" id="USER_NAME" class="wp50">
                            <span id="userId"></span>
                        </td>
                        <th><strong class="stit">사용자ID</strong></th>
                        <td>
                            <input type="text" id="USER_ID" class="wp50">
                        </td>
                    </tr>
                </tr>
            </tbody>
        </table>
    </div><!-- //searchTableArea -->
    <div class="search_btn_area">
        <button class="search_btn" id="btnInSearch">검색</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap -->    


<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridListIn"></div> 
</div>

<div class="sub-tit">
    <h4>공급업체 조회</h4>
    
    <div class="right">
        <button type="button" class="btn" id="btnReset">외부유저 비밀번호 초기화</button>
        <button type="button" class="btn" id="btnResetIn">내부유저 비밀번호 초기화</button>
    </div>
</div>

<div class="search_field_wrap">
    <div class="search_field_area">
        <table class="search_field">
            <colgroup>
                <col style="width:25%;">
                <col style="width:25%;">
                <col style="width:25%;">
                <col style="width:25%;">
            </colgroup>
            
            <tbody>
                <tr>
                    <th><strong class="stit">공급업체명</strong></th>
                    <td>
                        <input type="text" id="POBUSI_NM" class="wp50"">
                        <span id="vUserId"></span>
                    </td>
                    <th><strong class="stit">사업자번호</strong></th>
                    <td>
                        <input type="text" id="POBUSI_REG_NO" class="wp50">
                    </td>
                </tr>
            </tbody>
        </table>
    </div><!-- //searchTableArea -->
    <div class="search_btn_area">
        <button class="search_btn" id="btnOutSearch">검색</button>
    </div><!-- //search_btn_area -->
</div><!-- // search_field_wrap -->    

<!-- realgrid 들어가는 영역 : S -->
<div class="realgrid-area">
    <div id="gridListOut"></div> 
</div>

