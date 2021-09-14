<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="board.title.new"/></title>
</head>
<script>
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};

function submit() {
	var form = document.form;
	var seqNo = document.getElementById('seqNo');
	
	var data = JSON.stringify($('#form').serializeObject());
	
	$.ajaxSetup({
		   'beforeSend': function(xhr) {           
		      xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");
		    }
	});
	$.ajax({
		url : '<%=request.getContextPath()%>/board/modifyBoard.json',
		type : 'POST',
		dataType : 'json',
		contentType : 'application/json',
		mimeType: 'application/json',
		processData : false,
		data : data,
		cache : false,
		success : function(response, status, xhr) {
			// Validation Message 초기화
			$('.error').text('');
			
			if(response.resultMessage == "FAIL") {
				var validError = response.errorMessageList;
				for (var i = 0; i < validError.length; i++) {
					$('#'+validError[i].field+'\\.error').text(validError[i].message);
				}
			} else {
				alert('SUCCESS');
			}
		},
		error : function(xhr, status, error) {
			console.log(error);
			console.log(arguments);
		}
	});
}
</script>
<body>
	<div class="contTitle">
		<h1><spring:message code="board.title.modify"/></h1>
	</div>
	<div class="tb_data">
		<form:form id="form" name="form" action="/" method="POST" modelAttribute="boardVO">
			<table>
				<colgroup>
					<col width="130" />
					<col width="300" />
					<col width="160" />
					<col width="400" />
				</colgroup>
				<tr>
					<th>
						<form:label path="seqNo" for="seqNo"><spring:message code="board.label.seq"/></form:label>
					</th>
					<td colspan="3">
						<form:input path="seqNo" value="${boardInfo.seqNo}" readonly="true"/>
					</td>
				</tr>				
				<tr>
					<th>
						<form:label path="writer" for="writer"><spring:message code="board.label.writer"/></form:label>
					</th>
					<td>
						<form:input path="writer" value="${boardInfo.writer}"/>
						<span id="writer.error" class="error"></span>
					</td>
					<th>
						<form:label path="dueDate" for="dueDate"><spring:message code="board.label.dueDate"/> (yyyy-mm-dd)</form:label>						
					</th>
					<td>
						<form:input path="dueDate" value="${boardInfo.dueDate}"/>
						<span id="dueDate.error" class="error"></span>
					</td>
				</tr>
				<tr>
					<th>
						<form:label path="title" for="title"><spring:message code="board.label.title"/>(<spring:message code="board.label.max"/>10)</form:label>
					</th>
					<td colspan="3">
						<form:input path="title" cssClass="Textinput input01 num05" value="${boardInfo.title}"/>
						<span id="title.error" class="error"></span>
					</td>
					
				</tr>								
				<tr>
					<th>
						<form:label path="content" for="content"><spring:message code="board.label.content"/></form:label>
					</th>
					<td colspan="3">
						<span id="content.error" class="error"></span>
						<textarea id="content" name="content" class="textarea05" >${boardInfo.content}</textarea>
					</td>					
				</tr>
			</table>					
		</form:form>
	</div>	
	<div class="btn_main">
		<span class="button iconBtn">
			<a id="btnSave" type="button" onclick="submit(); return false;" href="">
				<span class="button-icon ui-icon-func-save"></span> <span class="button-text"><spring:message code="board.btn.save"/></span>
			</a> </span> <span class="button iconBtn">
			<a id="btnCancel" type="button" class="button" href="<%=request.getContextPath()%>/board/">
				<span class="button-icon ui-icon-func-cancelRequest"></span> <span class="button-text"><spring:message code="board.btn.cancel"/></span>
			</a> 			
		</span>
	</div>
</body>
</html>