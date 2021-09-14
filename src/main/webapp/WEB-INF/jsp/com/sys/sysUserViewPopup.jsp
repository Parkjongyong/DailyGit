<%--
    Class Name :sysUserViewPopup.jsp
    Description: 사용자 관리 > 사용자별 화면 관리
    Modification Information
         수정일                  수정자     수정내용
    ---------  ------ ---------------------------
    2020.07.02  박종용     최초 생성
    author: 박종용
    since: 2020.07.02
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>


<script language="javascript">
var gridList;
var useYnCodes  = new Array();
var useYnLabels = new Array();

$(document).ready(function() {
	
    // 개별코드 생성(그리드용)
    useYnCodes  = getComboSet('${CODELIST_E102}', 'CODE');
    useYnLabels = getComboSet('${CODELIST_E102}', 'CODE_NM');
	
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
	setInitGrid();
	fnSearch();
});


function fnSearch(){
	var params = fnGetParams();
	$.extend(params, {"ROLE_CD" : "${PARAM.ROLE_CD}"});
	$.extend(params, {"MODULE_TYPE" : '${PARAM.USER_CLS}'});
	$.extend(params, {"USER_ID" : "${PARAM.USER_ID}"});
	$.extend(params, {"DEPT_CD" : "${PARAM.DEPT_CD}"});
	
    searchCall(treeView, '/com/sys/selectUserViewList',null, params);
}
/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
    treeView.setTreeRows(data.rows, "TREE", false, '', '');
    treeView.checkAll(true);
    var gridProvider = treeView.getDataProvider();
    if(gridProvider.getRowCount() > 0){
        for(var index=0; index < gridProvider.getRowCount(); index++){
            
            if(isNotEmpty(treeView.getValue(index, "MENU_USE_YN")) == true){
            	
            } else {
                var IS_ROLE_MAPPING = "";
                
                IS_ROLE_MAPPING += treeView.getValue(index, "IS_ROLE_MAPPING");
                
                if(IS_ROLE_MAPPING == "1"){
                	treeView.setValue(index,"MENU_USE_YN", "Y");
                } else {
                	treeView.setValue(index,"MENU_USE_YN", "N");
                }
            }
            
            treeView.expand(index, true);
        }
    }
    
  //그리드 변경 시 체크박스 true
//     treeView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
//     	treeView.checkItem(dataRow, true);
//     };
    

    var columnDynamicStyles = function(grid, index, value) {
        var styles = {};
        var values = grid.getValues(index.itemIndex);
        var gubn   = values.MENU_USE_YN;
        if (gubn == 'Y') {
            styles.editable = false;
            styles.background = "#d5e2f2";
        } else {
        	styles.editable = false;
        }
        
        return styles;
    };	    

    
    treeView.setColumnProperty("MENU_USE_YN"   , "dynamicStyles", columnDynamicStyles);    
    
    
    // 상태바 비활성화
    treeView.closeProgress();

}

function setInitGrid() {
	
	var gridId = "gridList";
    treeView = new RealGridJS.TreeView(gridId);

    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(cm ,'TREE'             ,{text: "tree"}     , 100    ,'text'    ,''   ,{visible:false,sortable:false} );
    addField(cm ,'MENU_NM'          ,{text: "메뉴명"}     , 340    ,'text'    ,{textAlignment: "near"}   ,{visible:true,sortable:false} );
    addField(cm ,'LVL'              ,{text: "레벨"}       ,  40    ,'text'    ,{textAlignment: "center"}   ,{visible:true,sortable:false} );
    addField(cm ,'MENU_CD'          ,{text: "메뉴코드"}    ,  80    ,'text'    ,{textAlignment: "center"}   ,{visible:true,sortable:false} );
    addField(cm ,'UP_MENU_CD'       ,{text: "상위코드"}                 ,  0    ,'text'    ,''   ,{visible:false,sortable:false} );
    addField(cm ,'UP_MENU_NM'       ,{text: "상위코드명"}                ,  0    ,'text'    ,''   ,{visible:false,sortable:false} );
    addField(cm ,'IS_ROLE_MAPPING'  ,{text: "IS_ROLE_MAPPING"}       ,  0    ,'text'    ,''   ,{visible:false,sortable:false} );
    addField(cm ,'MENU_USE_YN'      ,{text: '사용유무'}    , 60,   'text',     {textAlignment: "center"}, {editable: false,sortable:false,
    	renderer: {
        type: "check",
        editable: true,
        startEditOnClick: true,
        trueValues: "Y",
        falseValues: "N"
    }});
    

    treeView.rtgrid({
            gridId            : gridId    //required 그리드 ID
           ,height            : _G_POP_HEIGHT_M        //required 그리드 높이
           ,columns           : cm        // required
           ,checkBar          : false     //default true    앞쪽 체크박스 표시 여부
           ,editable       : true     //default false 그리드 전체 에디트 여부
           
    });
    
	//셀이 수정된후 
	treeView.onCellEdited = function (grid, itemIndex, dataRow, field) {
	    this.commit(); //강제 커밋.
	};
    
    //그리드 변경 시 체크박스 true
    treeView.onEditRowChanged = function (grid, itemIndex, dataRow, field, oldValue, newValue) {
    	var gridProvider = treeView.getDataProvider();
    	//현재 행 체크
    	treeView.checkItem(dataRow-1, true);
    	
    	//상위레벨 체크
    	var upMenuChk = grid.getValues(itemIndex).TREE.replaceAll(".ROOT.","").split(".");
    	for (var i = 0; i < upMenuChk.length; i++) {
        	for (var j = 0; j < gridProvider.getRowCount(); j++) {
    			if(grid.getValue(j,"MENU_CD") == upMenuChk[i]){
    				if(newValue == "Y"){
        				treeView.setValue(j, "MENU_USE_YN", "Y");
//         				treeView.checkItem(j, true);
    				}
    			}
	    	}
		}
    	
    	//하위레벨 체크
    	var baseLvl = grid.getValues(itemIndex).LVL;
       	for (var j = itemIndex + 1; j < gridProvider.getRowCount(); j++) {
   			if(baseLvl < grid.getValue(j,"LVL")){
   				if(newValue == "N"){
       				treeView.setValue(j, "MENU_USE_YN", "N");
//        				treeView.checkItem(j, true);
   				} else {
       				treeView.setValue(j, "MENU_USE_YN", "Y");
//        				treeView.checkItem(j, true);
   				}
   			} else {
   				break;
   			}
    	}
    	
    };
	
}

/**
 * 저장
 */
function fnSave() {
	var params = fnGetParams();
	var items = treeView.getSelectedRows();
	$.extend(params, {"ITEM_LIST" : items});
	$.extend(params, {"USER_ID" : "${PARAM.USER_ID}"});
	
    if(confirm("저장 하시겠습니까?")){
		saveCall(treeView, '/com/sys/updateUserMenuList', null, params);
    }
}

/**
 * 초기화
 */
function fnReset() {
	var params = fnGetParams();
	$.extend(params, {"USER_ID" : "${PARAM.USER_ID}"});
	
    if(confirm("초기화 하시겠습니까?")){
		saveCall(treeView, '/com/sys/resetUserMenuList', 'fnSave', params);
    }
}

/**
 * 저장 성공
 */
function fnSaveSuccess(result) {
	alert("저장되었습니다.");
    // 상태바 비활성화
    treeView.closeProgress();
    fnSearch();
}

/**
 * 저장 실패
 */
function fnSaveFail(data) {
	alert(data.errMsg);
    // 상태바 비활성화
    treeView.closeProgress();
}

</script>


<div class="pop-wrap">
    <div class="pop-head">
		<h2>사용자-화면설정</h2>
	</div><!-- //popHead -->
	
	<div class="pop-cont">

		<div class="tbl-search-wrap">
			<div class="tbl-search-area">
				<table class="tbl-search">
					<colgroup>
						<col style="width:14%">
						<col style="width:36%">
						<col style="width:14%">
						<col style="width:36%">
					</colgroup>
					<tbody>
						<tr>
							<th><span>사용자ID</span></th>
							<td>
								<input type="text" id="S_USER_ID"  value="${PARAM.USER_ID}" maxlength="15" disabled>
							</td>
							<th><span>사용자명</span></th>
							<td>
								<input type="text" id="S_USER_NAME" value="${PARAM.USER_NAME}" maxlength="15" disabled>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="pack-layout">
            <div class="layout1" style="width:100%">
                <div class="sub-tit first">
                    <h4>메뉴리스트</h4>
                    
                    <div class="right">
		                <button type="button" class="btn" id="btnReset">초기화</button>
		                <button type="button" class="btn" id="btnSave">저장</button>
		            </div>
                </div>
                
                <div class="realgrid-area">
		            <div id="gridList"></div> 
		        </div>
            </div>
        </div>
	</div>
</div>