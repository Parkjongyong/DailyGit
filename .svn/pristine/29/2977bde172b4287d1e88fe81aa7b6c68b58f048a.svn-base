<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
$(document).ready(function() {
	init();
});


function init() {
	$(document).on("click", "#btnReturn", function(e){
		fnReturn();
    });
	
	$(document).on("click", "#btnClose", function(e){
        window.close();
    });
	
	JCO_PARAMS
}

var fnReturn = function(){
	if(confirm("재전송 하시겠습니까?")){
		var params = fnGetMakeParams();
		$.extend(params, {"JCO_PARAMS" : JSON.parse($("#JCO_PARAMS").val())});
		
		ajaxJsonCall("<c:url value='/com/sys/returnJcoInfo.do'/>", params, function(data) {
            if(data.status == "SUCC"){
                alert("재전송 되었습니다.");
                $(opener.location).attr("href","javascript:searchList();"); //jQuery 이용
                window.close();
                
            }
        },function(data) {
            if(data.fields.RESULT == "F"){
                alert("재전송에 실패 하였습니다.");
            }
        });
	}
}

</script>

<div class="pop-wrap"  style="width:100%;">
    <div class="pop-head">
        <h2>RFC Log 상세화면</h2>
        
        <div class="head-btn">
            <button type="button" class="btn" id="btnReturn">재전송</button>
            <button type="button" class="btn" id="btnClose">닫기</button>
        </div>
    </div>
    
    <div class="pop-cont">  
        <div class="sub-tit first">
            <h4>JCO_PARAMS</h4>
        </div>
    
        <table class="table-style">
            <colgroup>
                <col style="width:15%;">
                <col>
                <col style="width:15%;">
                <col>
            </colgroup>
            
            <tbody>
                <tr>
                    <th class="center">JCO_PARAMS</th>
                    <td colspan="3">
                        <textarea rows="17" id="JCO_PARAMS" name="JCO_PARAMS"><c:out value="${rfcLogInfo.JCO_PARAMS }" /></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        
        <div class="sub-tit">
            <h4>JCO_DATA</h4>
        </div>
    
        <table class="table-style">
            <colgroup>
                <col style="width:15%;">
                <col>
                <col style="width:15%;">
                <col>
            </colgroup>
            
            <tbody>
                <tr>
                    <th class="center">JCO_DATA</th>
                    <td colspan="3">
                        <textarea rows="17" id="JCO_DATA" name="JCO_DATA"><c:out value="${rfcLogInfo.JCO_DATA }" /></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

