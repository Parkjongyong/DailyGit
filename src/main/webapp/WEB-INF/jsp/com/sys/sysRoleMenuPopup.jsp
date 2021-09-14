<%--
    Class Name :sysRoleMenuPopup.jsp
    Description: 권한 관리 > 메뉴목록
    Modification Information
         수정일                  수정자     수정내용
    ---------  ------ ---------------------------
    2020.06.18  박종용     최초 생성
    author: 박종용
    since: 2020.06.18
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<%@ taglib prefix="c" 		uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" 		uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" 	uri="http://www.springframework.org/tags"%>


<script language="javascript">
var gridList;

$(document).ready(function() {
    // 버튼 클릭 이벤트 생성
    makeBtnClickEvent();
	setInitGrid();
	fnSearch();
});


function fnSearch(){
	var params = fnGetMakeParams();
    $.extend(params, {"ROLE_CD" : "${PARAM.ROLE_CD}"});
    $.extend(params, {"MODULE_TYPE" : $("#MODULE_TYPE").val()});
    searchCall(treeView, '/com/sys/selectMenuList', null, params);
}

/**
 * 조회 후 처리
 */
function fnSearchSuccess(data) {
    treeView.setTreeRows(data.rows, "TREE", false, '', '');
    var gridProvider = treeView.getDataProvider();
    if(gridProvider.getRowCount() > 0){
        for(var index=0; index < gridProvider.getRowCount(); index++){
            var IS_ROLE_MAPPING = "";
            
            IS_ROLE_MAPPING += treeView.getValue(index, "IS_ROLE_MAPPING");
            if(IS_ROLE_MAPPING == "1"){
            	treeView.checkItem( index, true, false );
            }
            treeView.expand(index, true);
        }
    }
    
    
    // 상태바 비활성화
    treeView.closeProgress();

}

function doSearchContext(){
// 	var params = {ROLE_CD : "${PARAM.ROLE_CD}", MODULE_TYPE : $("#MODULE_TYPE").val()};
// 	ajaxJsonCall("<c:url value='/com/cmn/selectRoleDetailList.do' />", params, function(obj){
// 		var html = "";
// 		$.each(obj.fields.detailList, function(index, iteam){
// 			html+= iteam.MENU_NM+"</br>";
// 		});
// 		$("#roleList").html(html);
// 	});
}

function setInitGrid() {
	
	var gridId = "gridList";
    treeView = new RealGridJS.TreeView(gridId);

    var cm = [];
    // obj, fieldName, headerStyle, width, dataType, colStyles, extraOption(visible, sortable 등), editType, editOption
    addField(cm ,'TREE'             ,{text: "tree"}     , 100    ,'text'    ,''   ,{visible:false,sortable:false} );
    addField(cm ,'MENU_NM'          ,{text: "메뉴명"}      , 300    ,'text'    ,{textAlignment: "near"}   ,{visible:true,sortable:false} );
    addField(cm ,'LVL'              ,{text: "레벨"}       ,  40    ,'text'    ,{textAlignment: "center"}   ,{visible:true,sortable:false} );
    addField(cm ,'MENU_CD'          ,{text: "메뉴코드"}     ,  80    ,'text'    ,{textAlignment: "center"}   ,{visible:true,sortable:false} );

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
        				treeView.checkItem(j, true);
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
       				treeView.checkItem(itemIndex, false);
       				treeView.checkItem(j, false);
       				
   				} else {
       				treeView.setValue(j, "MENU_USE_YN", "Y");
       				treeView.checkItem(j, true);
       				treeView.checkItem(itemIndex, true);
   				}
   			} else if(baseLvl >= grid.getValue(j,"LVL")){
   				if(newValue == "N"){
   					treeView.checkItem(itemIndex, false);
   				} else {
   					treeView.checkItem(itemIndex, true);
   				}
   				break;
   			} else {
   				break;
   			}
    	}
    	
    };    
//     treeView.onItemChecked = function(grid, itemIndex, checked) {
//     	treeChecked(grid, itemIndex, checked);
//     };
    
//     function treeChecked(grid, index, checked) {
//     	var gridProvider = grid.getDataProvider();
//     	//하위레벨 체크
//     	var baseLvl = grid.getValues(index).LVL;
//        	for (var j = index + 1; j < gridProvider.getRowCount(); j++) {
//    			if(toNumber(baseLvl) < toNumber(grid.getValue(j,"LVL"))){
//    				if(grid.isCheckedItem(index) == true){
//        				treeView.checkItem(j, true);
//    				} else {
//    					treeView.checkItem(j, false);
//    				}
//    			} else {
//    				break;
//    			}
//     	}
//     }
    
// 	var lastIndex;
	
// 	$('#treeGrid').treegrid({
// 		  width:500
// 		, height:520
// 		, fitColumns:true
// 		, cache:false
// 		, singleSelect:true
// 		, idField:'MENU_CD'
// 		, treeField:'MENU_CD'
// 		, onLoadSuccess: function (row, param)
// 		{
// 			if(param != ""){
// 				$('#treeGrid').treegrid('select',param[0].MENU_CD);
// 			}
// 		},
// 		columns:[[
// 			{title:'부모1',field:'UP_MENU_CD',hidden:'true'},
// 			{title:'부모',field:'IS_ROLE_MAPPING', hidden:'false'},
//  			{title:'선택',field:'ctgrySeq',width:10,align : 'center',
// 				formatter:function(value,row)
// 				{
// 					var chk = "";
// 					if(row.IS_ROLE_MAPPING == "1")
// 					{
// 						chk = 'checked = "checked"';
// 					}
// 					return '<input type="checkbox" data-type="checkbox" name="chk" id="chk" data-bind="checked:chk" '+chk+' value="'+row.MENU_CD+'" >';
// 				}
// 			},
// 			{title:'메뉴코드',field:'MENU_CD',width:50,align : 'left'},
// 			{title:'메뉴명',field:'MENU_NM',width:50,align : 'left'}
// 			]],
// 			onClickCell:function(rowIndex, cell){
// 				if(rowIndex == "ctgrySeq")
// 				{
// 					$(this).treegrid('cascadeCheck',{
// 						  id:cell.MENU_CD
// 						, deepCascade:true
// 					}); 
// 				}
// 				if(rowIndex == "ctgrySeq"){
// 					doSave();
// 				}
				
// 			}
// 	}); 
}

function doSave(){
	var params = fnGetParams();
	params.ROLE_CD = "${PARAM.ROLE_CD}";
	params.MODULE_TYPE = $("#MODULE_TYPE").val();
	
	$.extend(params, {"ITEM_LIST" : treeView.getSelectedRows()});
	
	
	ajaxJsonCall("<c:url value='/com/sys/updateRoleMenuList.do'/>", params, function(data) {
        if(data.fields.RESULT == "S"){
            alert("저장 되었습니다.");
        }
	});
}

/**
 * 저장
 */
function fnSave() {
	var params = fnGetParams();
	params.ROLE_CD = "${PARAM.ROLE_CD}";
	params.MODULE_TYPE = $("#MODULE_TYPE").val();
	$.extend(params, {"ITEM_LIST" : treeView.getSelectedRows()});
    if(confirm("저장 하시겠습니까?")){
		saveCall(treeView, '/com/sys/updateRoleMenuList', null, params);
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
		<h2>권한-메뉴설정</h2>
	</div><!-- //popHead -->
	
	<div class="pop-cont">
		<div class="sub-tit first">
			<h4>메뉴목록</h4>
		</div>

		<div class="tbl-search-wrap">
			<div class="tbl-search-area">
				<table class="tbl-search">
					<colgroup>
						<col style="width:7%">
						<col style="width:26%">
						<col style="width:6%">
						<col style="width:27%">
						<col style="width:10%">
						<col style="width:23%">
					</colgroup>
					<tbody>
						<tr>
							<th><span>권한코드</span></th>
							<td>
								<input type="text" id="S_ROLE_CD"  value="${PARAM.ROLE_CD}" maxlength="15" disabled>
							</td>
							<th><span>권한명</span></th>
							<td>
								<input type="text" id="S_ROLE_NAME" value="${PARAM.ROLE_NAME}" maxlength="15" disabled>
							</td>
							<th><span>사용자(SITE)구분</span></th>
							<td>
								<select id="MODULE_TYPE" name="MODULE_TYPE" disabled>
									<option value="B" <c:if test="${PARAM.MODULE_TYPE eq 'B'}" >selected</c:if>>내부사용자</option>
									<option value="S" <c:if test="${PARAM.MODULE_TYPE eq 'S'}" >selected</c:if>>공급업체</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="pack-layout">
            <div class="layout1" style="width:50%">
                <div class="sub-tit first">
                    <h4>메뉴리스트</h4>
                    
                    <div class="right">
		                <button type="button" class="btn" id="btnSave">저장</button>
		            </div>
                </div>
                
                <div class="realgrid-area">
		            <div id="gridList"></div> 
		        </div>
            </div>
            
            <div class="layout2" style="width:50%">
            </div>
        </div>
	</div>
</div>