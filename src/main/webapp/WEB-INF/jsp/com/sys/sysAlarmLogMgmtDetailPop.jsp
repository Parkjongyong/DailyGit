<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
</script>

<div class="pop-wrap"  style="width:100%;">
    <div class="pop-head">
        <h2>알림 발송 로그 상세화면</h2>
        
        <a href="#none" class="close">닫기</a> 
    </div>
    
    <div class="pop-cont">  
        <div class="sub-tit">
            <h4>텍스트</h4>
        </div>
    
        <table class="tbl-view">
            <colgroup>
                <col style="width:15%;">
                <col>
                <col style="width:15%;">
                <col>
            </colgroup>
            
            <tbody>
                <tr>
                    <th class="center">제목</th>
                    <td colspan="3">
                        <textarea rows="1" id="SUBJECT"><c:out value="${alarmLogInfo.SUBJECT }" /></textarea>
                    </td>
                </tr>
                <tr>
                    <th class="center">내용</th>
                    <td colspan="3">
                        <textarea rows="17" id="CONTENT"><c:out value="${alarmLogInfo.CONTENT }" /></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
        
        
        <c:if test="${alarmLogInfo.MSG_TYPE eq 'MAIL'}">
        <div class="sub-tit">
            <h4>미리보기</h4>
        </div>
    
        <div class="editorText-area">
            <pre style="white-space: pre-wrap" readOnly="ReadOnly">${alarmLogInfo.CONTENT }</pre>
        </div>
        </c:if>
    </div>
    
</div>

