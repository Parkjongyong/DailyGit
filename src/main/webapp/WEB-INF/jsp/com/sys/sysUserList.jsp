<%--
	File Name : sysUserList.jsp
	Description: 사용자 정보
	Modification Information
	-----------------------------------------------
	수정일               수정자            수정내용
	---------- -------- ---------------------------
	2020.06.18  길용덕            최초 생성
	-----------------------------------------------
	author: 길용덕
	since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" 	uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" 	uri="http://www.springframework.org/tags"%>
<script language="javascript">
var gridView;
var changeUserParams;
var scrollItem = 460;

/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {
	
	var compList   = stringToArray("${CODELIST_SYS001}","ALL");
	fnMakeComboOption('SB_COMP_CD' , compList,     'CODE', 'CODE_NM', null, "","전체");
	
	// 초기 상태값 처리
    fnInitStatus();	
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
 	// 그리드 생성
 	setInitGrid();
 	// 자동 조회
	fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	

	$("#SB_COMP_CD").val('${LOGIN_INFO.COMP_CD}');
	
	//비밀번호 입력 Dialog
    $( "#passwd_dialog" ).dialog({
        autoOpen: false,
        resizable: true,
        modal : true,
        height:170, //팝업 가로
        width: 500, //팝업 높이
        close: function(event,ui) {
            $("#PASSWD").val("");
            $("#passwd_dialog").dialog( "close" );
        }
    });
}

/**
 * 조회
 */
function fnSearch() {
	// 조회 요청
	searchCall(gridView, '/com/sys/selectUserList');	
}

/**
 * 페이징 처리 조회
 */
function loadNext() {
    var params = fnGetParams();
    var newStart = gridView.getDataProvider().getRowCount()+1;
    
    $.extend(params, {"page" : newStart});
    $.extend(params, {"pageSize" : newStart+499});
    
    ajaxJsonCall('<c:url value="/com/sys/selectUserList.do"/>',  params, function(data){
        gridView.addRows(data.rows, data.records);
    });
}


/**
 * EAI 호출
 */
function fnCallEai() {
	// 조회 요청
	searchCall(gridView, '/com/sys/callEai');	
}


/**
 * 조회 성공 후 처리
 */
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

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
	var gridId = "gridView";
	gridView = new RealGridJS.GridView(gridId);
	
	var cm = [];
	addField(cm ,	'COMP_NM',			{text: '회사명'},			100,		'text', 	{textAlignment: "center"});
	addField(cm ,	'USER_ID',			{text: '사용자ID'},			80,		'text', 	{textAlignment: "center"});
	addField(cm ,	'USER_NAME',		{text: '사용자명'},			80,		'text', 	{textAlignment: "center"});
	addField(cm ,	'USER_ROLES',		{text: '사용자권한'},		   200,		'text', 	{textAlignment: "near"});
	addField(cm ,	'ROLE_USER',		{text: '사용자별 권한 설정'},		80,     'popupLink');
	addField(cm ,	'DEPT_CD',			{text: '부서코드'},			80,		'text', 	{textAlignment: "center"});
	addField(cm ,	'DEPT_NAME',		{text: '부서명'},			   100,		'text', 	{textAlignment: "near"});
	addField(cm ,	'DEPT_ROLE',		{text: '부서권한'},		   200,		'text', 	{textAlignment: "near"});
	addField(cm ,	'USER_VIEW_ROLE',	{text: '사용자별 화면 권한'},		80,     'popupLink');
	addField(cm ,	'ROLE_DEPT',		{text: '부서별 권한 설정'},		80,     'popupLink');
	addField(cm,    'LOGIN_SWITCH',      {text: '사용자전환'},       	80,    'popupLink');
    addField(cm,    'LOGIN_SWITCH_PW',   {text: '사용자전환 비밀번호'},     0,    'text',    {textAlignment: "center"},  {visible:false});
    addField(cm,    'INIT_PW',           {text: '비밀번호 초기화'},    	80,    'popupLink');
    addField(cm,    'USER_CLS',          {text: '사용자 구분'},           0,     'text',     {textAlignment: "center"}, {visible:false});
    addField(cm,    'ROLE_CD',          {text: '롤'},           0,     'text',     {textAlignment: "center"}, {visible:false});
		
	gridView.rgrid({
        gridId         : gridId    //required 그리드 ID
       ,height         : _G_GRID_HEIGHT_SUB       //required 그리드 높이
       ,columns        : cm        // required
       ,checkBar       : false     //default true   앞쪽 체크박스 표시 여부
       ,selectStyle    : "block"   //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
       ,copySingle : false // default ture : 복사하지 않음
       ,appendable     : true
       //,autoHResize    : true       //화면 크기에 맞게 높이 자동조절
       ,viewCount      : true       //조회 건수 표시
   });

	// 데이터 클릭 시 이벤트 설정
	gridView.onDataCellClicked =  function (grid, index) {
		if (index.column == "ROLE_USER") {
			fnUserRolePopup(index);
        } else if (index.column == "ROLE_DEPT") {
        	fnDeptRolePopup(index);
        } else if (index.column == "USER_VIEW_ROLE") {
        	fnUserViewPopup(index);
        } else if ( index.column === "LOGIN_SWITCH" ) {
            $("#ITEM_INDEX").val(index.itemIndex);
            $( "#passwd_dialog" ).dialog( "open" );
        } else if ( index.column === "INIT_PW" ) {
        	fnInitPw(index);
        }
	};
	
	gridView.onTopItemIndexChanged = function(grid, item) {
        if (item > scrollItem) {
        	scrollItem += 450;
            loadNext();
        }
    }    

}

/**
 * 그리드에서 사용자별 권한 설정 클릭 시 이벤트
 */
function fnUserRolePopup(row) {
	var userId = gridView.getValue(row.itemIndex, "USER_ID");
	
	if("" == userId || undefined == userId){
		alert("사용자ID가 없습니다.");
		return false;
	} else {
		
		var params = fnGetMakeParams();
        $.extend(params, {"S_USER_ID" : userId});
        $.extend(params, {"USER_ID"   : userId});
        $.extend(params, {"USER_NAME" : gridView.getValue(row.itemIndex, "USER_NAME")});
        $.extend(params, {"USER_CLS"  : gridView.getValue(row.itemIndex, "USER_CLS")});
			
		var target    = "userRolePopup";
		var width     = "1000";
		var height    = "700";
		var scrollbar = "yes";
		var resizable = "yes";
		
		fnPostPopup('/com/sys/userRolePopup', params, target, width, height, scrollbar, resizable);
	}
}

/**
 * 그리드에서 부서별 권한 설정 클릭 시 이벤트
 */
function fnDeptRolePopup(row){
	
	var deptCd = gridView.getValue(row.itemIndex, "DEPT_CD");
	
	if("" == deptCd || undefined == deptCd){
		alert("부서코드가 없습니다.");
		return false;
	} else {
		
		var params = fnGetMakeParams();
	    $.extend(params, {"S_DEPT_CD" : deptCd});
	    $.extend(params, {"DEPT_CD"   : deptCd});
	    $.extend(params, {"DEPT_NAME" : gridView.getValue(row.itemIndex, "DEPT_NAME")});
	    $.extend(params, {"USER_CLS"  : gridView.getValue(row.itemIndex, "USER_CLS")});
		
		var target    = "userRolePopup";
		var width     = "1000";
		var height    = "700";
		var scrollbar = "yes";
		var resizable = "yes";
		
		fnPostPopup('/com/sys/deptRolePopup', params, target, width, height, scrollbar, resizable);
	}
}

/**
 * 패스워드 체크로직
 */
function fnCheckPw() {
    
    if($("#PASSWD").val() == ""){
        alert("비밀번호를 입력 해 주세요.");
        $("#PASSWD").focus();
        return false;
    }
    
    if($("#PASSWD").val() == gridView.getValue($("#ITEM_INDEX").val(), "LOGIN_SWITCH_PW")){
    	// 초기화
    	changeUserParams = {};
    	// 그리드 파라미터 추출
        changeUserParams = fnGetMakeParams();
    	// 팝업에서 전달받은 패스워드 셋팅
        $.extend(changeUserParams, {"PASSWD" : $("#PASSWD").val()});
    	// 변경할 사용자 정보 조회 요청
    	searchCall(gridView, '/com/sys/changeVendorUser', 'fnCheckPw', changeUserParams);        
    } else {
        alert("패스워드를 확인 해 주세요.");
        return false;
    }
}

/**
 * 사용자 변환 성공 시 처리
 */
function fnCheckPwSuccess(jObj) {
    if ('SUCC' == jObj.status) {
        fnPostGoto('/main', changeUserParams, "_self");
    }else{
        alert("사용자 전환에 실패 하였습니다.");
        return false;
    }
}

/**
 * 비밀번호 초기화
 */
function fnInitPw(row){
	
	var userId = gridView.getValue(row.itemIndex, "USER_ID");
	var params = fnGetMakeParams();
    $.extend(params, {USER_ID : userId});
	if(confirm("비밀번호는 아이디 값으로 초기화 됩니다.\n초기화 하시겠습니까?")){
		saveCall(gridView, '/com/sys/saveInitPw', 'fnInitPw', params); 
	}
		
}

/**
 * 비밀번호 초기화 성공
 */
function fnInitPwSuccess(data){
    alert("비밀번호가 초기화 되었습니다.");
    // 상태바 비활성화
    gridView.closeProgress();
    fnSearch();
}

/**
 * 비밀번호 초기화 실패
 */
function fnInitPwFail(data){
	// 에러메세지 처리
	alertErrMsg(data.errMsg);
 	// 상태바 비활성화
    gridView.closeProgress();	
}

/**
 * 그리드에서 유저별 권한 설정 클릭 시 이벤트
 */
function fnUserViewPopup(row){
	
	var deptCd = gridView.getValue(row.itemIndex, "DEPT_CD");
	var deptNm = gridView.getValue(row.itemIndex, "DEPT_NAME");
	var userId = gridView.getValue(row.itemIndex, "USER_ID");
	var userNm = gridView.getValue(row.itemIndex, "USER_NAME");
	var userCl = gridView.getValue(row.itemIndex, "USER_CLS");
	var roleCd = gridView.getValue(row.itemIndex, "ROLE_CD");
	
	var params = fnGetMakeParams();
    $.extend(params, {USER_ID : userId, USER_NAME : userNm, DEPT_CD : deptCd, DEPT_NM : deptNm, USER_CLS : userCl, ROLE_CD : roleCd});
	
	var target    = "userViewPopup";
	var width     = "635";
	var height    = "760";
	var scrollbar = "yes";
	var resizable = "yes";
	
	fnPostPopup('/com/sys/userViewPopup', params, target, width, height, scrollbar, resizable);
}
</script>

<input type="hidden" id="ITEM_INDEX" />

<div class="tit-area">
	<h3>${G_MENU_NM}</h3>
	<div class="btnArea abtit">
<!--         <button type="button" class="btn st1" id="btnCallEai">EAI 호출</button> -->
	</div>
</div>	

		
<div class="tbl-search-wrap">
    <div class="tbl-search-area">
        <table class="tbl-search">
			<colgroup>
                <col style="width:70px">
                <col style="width:480px">
                <col style="width:90px">
                <col style="width:480px">
                <col style="width:80px">
                <col style="width:465px">
				<col>
			</colgroup>
			<tbody>
				<tr>
                    <th><span>회사</span></th>
                    <td>
	                    <select id="SB_COMP_CD" name="SB_COMP_CD">
	                    </select>
                    </td>
					<th><span>사용자명</span></th>
					<td>
						<input type="text" id="S_USER_NM" value="" maxlength="20">
					</td>
					<th><span>부서명</span></th>
					<td>
						<input type="text" id="S_DEPT_NM" value="" maxlength="20">
					</td>
				</tr>
			</tbody>
		</table>
	</div><!-- //searchTableArea -->
    <div class="tbl-search-btn">
        <button class="btn-search" id="btnSearch">조회</button>
    </div><!-- //search_btn_area -->
</div><!-- //searchWrap -->
<br/>		
<div class="realgrid-area">
	<div id="gridView"></div>
</div>

<!-- dialog-Pop : S -->
<div id="passwd_dialog" title="로그인 전환 검증">
    <table class="tbl-view">
        <colgroup>
          <col style="width:30%;">
          <col>
        </colgroup>
       <tbody>
            <tr>
                <th>검증 비밀번호</th>
                <td><input type="password" id="PASSWD" name="PASSWD" class="wp100" maxlength="100" onkeypress="if(event.keyCode==13){fnCheckPw();}" /></td>
            </tr>       
      </tbody>
    </table>
    <br>
    <div align="center">
        <button type="button" class="btn" onClick="javascript:fnCheckPw();">확인</button>
    </div>
</div>