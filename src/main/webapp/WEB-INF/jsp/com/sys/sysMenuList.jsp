<%--
	File Name : sysMenuList.jsp
	Description: 메뉴 조회/등록/수정/삭제 화면
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

<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring"     uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn"         uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"     uri="http://www.springframework.org/tags"%>
<script language="javascript">
var $grid;
var treeView;
var menuTd = '<input type="text" class="point w80" data-type="textinput" name="MENU_CD" id="MENU_CD" data-bind="value:MENU_CD" maxlength="8">';
/**
 * 화면 로딩시 처리 로직
 */
$(document).ready(function() {

	// 초기 상태값 처리
    fnInitStatus();
	var codeList = stringToArray("${CODELIST_ID001}");
    // 콤보 구성(조회 조건)
    fnMakeComboOption('MODULE_TYPE', codeList, 'CODE', 'CODE_NM');
 	// 그리드 생성
 	setInitGrid();
    // 버튼 클릭 이벤트 생성
    // 버튼별 이벤트 함수 생성 예) btnAddRowGrp인 경우, fnAddRowGrp() 으로 함수 생성하여 로직 구현!!!
    makeBtnClickEvent();
    // 자동 조회
    fnSearch();
});

/**
 * 초기 설정
 */
function fnInitStatus() {
	// Site 구분 변경 시 이벤트 등록
    $("#MODULE_TYPE").on('change', function() {
        $("#GUBUN").val("ADD");
        // input 값 초기화
        setClearValue(["UP_MENU_CD", "MENU_NM", "MENU_NM_EN", "LINK_URL", "ORD_NO", "MENU_TD"]);
        // td tag 값 초기화
        setClearHtml(["UP_MENU_TD"]);
        $("#MENU_TD").html(menuTd);
        // 콤보박스 선택 처리
        setSelectedCombo(["MODULE_YN", "USG_YN", "DISPLAY_YN"]);
        // 자동 조회
        fnSearch();
    });
}
/**
 * 조회
 */
function fnSearch() {
	//  parameter setting
	var params = {UP_MENU_CD : "ROOT", MODULE_TYPE : $("#MODULE_TYPE").val()};
	// 조회 요청
	searchCall(treeView, '/com/sys/selectMenuMngList', null, params);
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
	// 에러메세지 처리
	alertErrMsg(data);
	// 상태바 비활성화
    treeView.closeProgress();
	// 트리뷰 설정
    treeView.setTreeRows(data.rows, "TREE", false);
    treeView.expandAll();
    // 상세 조회
	fnDetailSearch(treeView.getValue(0, "MENU_CD"));
}

/**
 * 상세 조회
 */
function fnDetailSearch(seq){
	// SEQ setting	
	$("#MENU_CD_SE").val(seq);
	//  parameter setting
    var params = {MENU_CD_SE : $("#MENU_CD_SE").val(), MODULE_TYPE : $("#MODULE_TYPE").val()};
	// 상세 조회 요청(그리드가 아닌 콤포넌트에 매핑할 데이터 조회)
	searchCall(null, '/com/cmn/selectMenuDetailList', 'fnDetailSearch', params);  
}

/**
 * 상세 조회 후 처리
 */
function fnDetailSearchSuccess(obj) {
	
    $.each(obj.fields.detailList, function(index,item){
        $("#GUBUN").val("MOD");
        // obj의 필요한 value만 추출하여 값 setting
        // 필요한 value 지정 없을 시에는 obj의 모든 데이터를 mapping하여 값 setting 예) setAllCompValue(item);
        setAllCompValue(item, ["UP_MENU_CD", "MENU_NM", "MENU_NM_EN", "LINK_URL", "ORD_NO", "USG_YN", "MODULE_YN", "DISPLAY_YN"]);
        $("#UP_MENU_TD").html(item.UP_MENU_NM);
        $("#MENU_TD").html('<input type="hidden" id="MENU_CD" name="MENU_CD" data-bind="value:MENU_CD" value="'+item.MENU_CD+'" />'+item.MENU_CD);
    });	

}

/**
 * 삭제 버튼 클릭 시 이벤트
 */
function fnDelete() {
	
	// 체크된 row 데이터 추출
	var items = treeView.getCheckedItems();
	if(fnDeleteCheck(treeView) == true){
		// 메뉴코드 담기
        var menuCdArr = "";
        for (var ii=0;ii<items.length;ii++){
            if(menuCdArr == ""){
                menuCdArr += treeView.getValue(items[ii], "MENU_CD");
            } else {
                menuCdArr += "," + treeView.getValue(items[ii], "MENU_CD");
            }
        }
        // parameter setting
        var params = { MENU_CD_ARR : menuCdArr };
		// 조회 요청
		deleteCall(treeView, '/com/cmn/deleteMenu', 'fnDelete', params);
	}
}

/**
 * 삭제 성공 시 처리
 */
function fnDeleteSuccess(jObj) {
	if (jObj.status = "SUCC") {
		alert("삭제 되었습니다.");
        fnSearch();
        return;
	}
}

/**
 * 삭제 실패 시 처리
 */
function fnDeleteFail(jObj) {
	if (jObj.errMsg == ""){
		alert("삭제에 실패했습니다.");
	} else {
		alert(jObj.errMsg);
	}
	return;
} 

/**
 * 저장 버튼 클릭 시 이벤트
 */
function fnSave() {
	
	// 그리드 수정사항 확정처리
	treeView.commit();
	// 필수 체크 대상(그리드)
	var requiredVal   = ["MENU_CD", "MENU_NM", "ORD_NO"];
	
	// 추가 체크 후 저장 진행
	if (fnExtValidation("save") == true) {
		
		if(confirm("저장 하시겠습니까?")){
	    	
			// 기본 데이터 추출
			var params = fnGetParams();
			// 추가 데이터 추출
			$.extend(params, {MODE : $("#GUBUN").val()});
		    saveCall(treeView, '/com/cmn/updateMenu', null, params);
	    }			
	}
}

/**
 * 저장 성공 시 처리
 */
function fnSaveSuccess(jObj) {
	alert("저장되었습니다.");
	fnSearch();
}

/**
 * 저장 실패 시 처리
 */
function fnSaveFail(jObj) {
	if (jObj.errMsg == ""){
		alert("삭제에 실패했습니다.");
	} else {
		alert(jObj.errMsg);
	}
	return;
}

/**
 * 추가 체크로직
 */
function fnExtValidation(gubn) {
	
	if (gubn == "save") {
		
        if ($("#MENU_CD").val().trim() == ""){
            alert("메뉴코드를 입력하세요.");
            $("#MENU_CD").focus();
            return false;
        } else if ($("#MENU_NM").val().trim() == ""){
            alert("메뉴명을 입력하세요.");
            $("#MENU_NM").focus();
            return false;
        } else if ($("#ORD_NO").val().trim() == ""){
            alert("정렬번호를 입력하세요.");
            $("#ORD_NO").focus();
            return false;
        }		
		
        var menuCd = $("#MENU_CD").val();
        var moduleClass = $("#MODULE_TYPE").val();
        
        if (menuCd.length > 3) {
            //내부사용자
            if (moduleClass == "B"){
                /* if(menuCd.substring(0,3) != "EPM")
                {
                    
                    alert("메뉴코드는 EPM으로 시작하여야 합니다.");
                    $("#MENU_CD").focus();
                    return false;
                } */
            //공급업체
            } else if(moduleClass == "S"){
                if (menuCd.substring(0,1) != "V"){
                    alert("메뉴코드는 'V'으로 시작하여야 합니다.");
                    $("#MENU_CD").focus();
                    return false;
                }
            }
        } else {
            alert("메뉴코드는 4자 이상이어야 합니다.");
            $("#MENU_CD").focus();
            return false;
        }
        
        return true;
	}
}

/**
 * 추가 버튼 클릭 시 이벤트
 */
function fnAdd() {
	// 행추가 default setting
	fnAddDefault("UP_MENU_CD", "UP_MENU_NM");

}

/**
 * 하위노드 추가 버튼 클릭 시 이벤트
 */
function fnNodeAdd() {
	// 행추가 default setting
	fnAddDefault("MENU_CD", "MENU_NM");
}

/**
 * 행추가 기본 정보
 */
function fnAddDefault(arg1, arg2) {
	
	var currRow = treeView.getCurrent();
    if(currRow != null) {
        $("#GUBUN").val("ADD");
        $("#UP_MENU_CD").val(treeView.getValue(currRow.itemIndex, arg1));
        $("#UP_MENU_TD").html(treeView.getValue(currRow.itemIndex, arg2));
        // input 값 초기화
        setClearValue(["MENU_NM", "MENU_NM_EN", "LINK_URL", "ORD_NO"]);
        $("#MENU_TD").html(menuTd);
        // 콤보박스 선택 처리
        setSelectedCombo(["MODULE_YN", "USG_YN", "DISPLAY_YN"]);
        
    } else {
        alert("선택된 항목이 없습니다.");
        return;
    }
}

/**
 * 그리드 기본  셋팅
 */
function setInitGrid() {
    var gridId = "gridList";
    treeView = new RealGridJS.TreeView(gridId);

    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(cm ,'TREE'        ,{text: "tree"}     ,100 ,'text'     ,''   ,{visible:false,sortable:false} );
    addField(cm ,'MENU_NM'     ,{text: "메뉴명"}    ,240 ,'text'     ,''   ,{visible:true,sortable:false} );
    addField(cm ,'LVL'         ,{text: "레벨"}     ,48  ,'text'    ,''   ,{visible:true,sortable:false} );
    addField(cm ,'MENU_CD'     ,{text: "메뉴코드"}  ,60   ,'text'    ,''  ,{visible:true,sortable:false} );
    addField(cm ,'UP_MENU_CD'  ,{text: "상위코드"}  ,80   ,'text'    ,''  ,{visible:false,sortable:false} );
    addField(cm ,'UP_MENU_NM'  ,{text: "상위코드명"},80   ,'text'    ,''  ,{visible:false,sortable:false} );
    addField(cm ,'LINK_URL'    ,{text: "URL"}      ,150   ,'text'    ,''  ,{visible:true,sortable:false} );
    addField(cm ,'ORD_NO'      ,{text: "정렬순서"}  ,60   ,'text'    ,{textAlignment: 'center'}  ,{visible:true,sortable:false} );
    addField(cm ,'MODULE_YN'   ,{text: "모듈여부"}  ,60   ,'text'    ,{textAlignment: 'center'}  ,{visible:true,sortable:false} );
    addField(cm ,'USG_YN'      ,{text: "사용여부"}  ,60   ,'text'    ,{textAlignment: 'center'}  ,{visible:true,sortable:false} );
    addField(cm ,'DISPLAY_YN'  ,{text: "DISPLAY"}  ,60   ,'text'    ,{textAlignment: 'center'}  ,{visible:true,sortable:false} );


    treeView.rtgrid({
            gridId            : gridId    //required 그리드 ID
           ,height            : _G_GRID_HEIGHT        //required 그리드 높이
           //,width            : "100%"    //default 100% 그리드 넓이
        //,rowHeight        : 30        //default 30 row height
           ,columns         : cm        // required
           //,headerHeight    : 30        //default null    헤더 사이즈
           ,checkBar         : true     //default true    앞쪽 체크박스 표시 여부
           //,exclusive        : false        //default false 한 행만 체크 가능할지의 여부를 지정한다.
           //,editable         : false        //default true    그리드 전체 에디트 여부
           //,selectStyle    : "singleRow"    //default singleRow 그리드 선택기능 block:BLOCK ,rows:ROWS , columns:COLUMNS , singleRow:SINGLE_ROW ,singleColumn:SINGLE_COLUMN,  none: NONE
           //,columnMovable    : false        //default true    컬럼 이동가능 여부
           //,columnResizable: true        //default true  이 값이 False로 설정하면 사용자가 모든 컬럼의 크기를 변경할 수 없습니다.
           //,footerVisible    : false        //default false    그리드 footer 표시 여부
           //,stateBarVisible: false        //default false 컬럼 상태 표시 여부
           //,indicatorDp    : "index"    //default "index" 컬럼번호 표시 방식 : none, row, index(정렬무시)
           //,rowStylesFirst    : false        //default false    row<->column 색상 우선순위 : true:column우선, false:row우선
        //,dynamicResize : true
        	,viewCount      : true       //조회 건수 표시
        });
	treeView.onDataCellClicked = function (grid, colIndex) {
		var currRow = this.getCurrent();
		if (currRow != null) {
			fnDetailSearch(treeView.getValue(currRow.itemIndex, "MENU_CD"));
		}
	};
    
}


</script>

<div class="tit-area">
    <h3>${G_MENU_NM}</h3>
	<div class="btnArea abtit">
	</div>    
</div>

<div class="layout-box">

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
	                	<th><span>Site 구분</span></th>
	                    <td>
                    <select id="MODULE_TYPE" name="MODULE_TYPE" data-type="select" data-bind="selectedOptions: MODULE_TYPE" style="width:200px;">
                    </select>
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
    
    <div class="layout-left" style="width:44%">
		<div class="sub-tit">
		    <h4>메뉴리스트</h4>
		    
		    <div class="btnArea t_right">
		        <button type="button" class="btn" id="btnAdd">현재노드추가</button>
		        <button type="button" class="btn" id="btnNodeAdd">하위노드추가</button>
		        <button type="button" class="btn" id="btnDelete">삭제</button>
		    </div>
		</div>
        <div class="realgrid-area">
            <div id="gridList"></div> 
        </div>
        
        <input type="hidden" id="MENU_CD_SE" name="MENU_CD_SE" data-bind="value:MENU_CD_SE" />  
    </div>
    
    <div class="layout-right" style="width:56%">
		<div class="sub-tit">
		    <h4>메뉴상세</h4>
		    
		    <div class="btnArea t_right">
		        <button type="button" class="btn" id="btnSave">저장</button>
		    </div>
		</div>
        
        <input type="hidden" id="UP_MENU_CD" name="UP_MENU_CD" data-bind="value:UP_MENU_CD" />
        <input type="hidden" id="GUBUN" name="GUBUN" data-bind="value:GUBUN" />

        <table class="tbl-view">
            <colgroup>
                <col style="width:20%;">
                <col>
            </colgroup>
            
            <tbody>
                <tr>
                    <th>상위메뉴명</th>
                    <td id="UP_MENU_TD">        </td>
                </tr>        
                <tr>
                    <th><span class="req">메뉴코드</span></th>
                    <td id="MENU_TD"></td>
                </tr>
                <tr>
                    <th>메뉴명</th>
                    <td>
                        <input type="text" class="point" data-type="textinput" name="MENU_NM" id="MENU_NM" data-bind="value:MENU_NM" maxlength="32">
                    </td>
                </tr>
                <tr>
                    <th>메뉴영문명</th>
                    <td>
                        <input type="text" class="point" data-type="textinput" name="MENU_NM_EN" id="MENU_NM_EN" data-bind="value:MENU_NM_EN" maxlength="32">
                    </td>
                </tr>
                <tr>
                    <th>URL</th>
                    <td>
                        <input type="text" class="wp100" data-type="textinput" name="LINK_URL" id="LINK_URL" data-bind="value:LINK_URL" maxlength="100">
                    </td>
                </tr>
                <tr>
                    <th>모듈여부</th>
                    <td>
                        <select id="MODULE_YN" name="MODULE_YN" data-type="select" data-bind="selectedOptions:MODULE_YN">
                            <option value="Y">Y</option>
                            <option value="N">N</option>
                        </select>                            
                    </td>
                </tr>
                <tr>
                    <th>DISPLAY</th>
                    <td>
                        <select id="DISPLAY_YN" name="DISPLAY_YN" data-type="select" data-bind="selectedOptions:DISPLAY_YN">
                            <option value="N">N</option>
                            <option value="Y">Y</option>
                        </select>                            
                    </td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td>
                        <select id="USG_YN" name="USG_YN" data-type="select" data-bind="selectedOptions:USG_YN">
                            <option value="N">미사용</option>
                            <option value="Y">사용</option>
                        </select>                            
                    </td>
                </tr>
                <tr>
                    <th>정렬</th>
                    <td>
                        <input type="text" class="w80" data-type="textinput" name="ORD_NO" id="ORD_NO" data-bind="value:ORD_NO" maxlength="2" data-keyfilter-rule="digits">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
                    
