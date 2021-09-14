<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="menu.label.title"/></title>
<script type="text/javascript">
</script>
</head>
<body>
	<div class="contTitle">
		<h1><spring:message code="menu.label.title"/></h1>
	</div>
	<div class="searchArea">
		<form id="form" name="form" action="/" method="POST">
			<table class="tb_search">
				<colgroup>
					<col width="130" />
					<col width="648" />
					<col width="160" />
				</colgroup>
				<tr>
					<th><label for="schWord"><spring:message code="menu.label.topMenuId"/></label></th>
					<td align="left">${menuInfo.topMenuId}</td>
					
				</tr>
				<tr>
					<th><label for="schWord"><spring:message code="menu.label.parentMenuId"/></label></th>
					<td align="left">${menuInfo.parentMenuId}</td>
					
				</tr>
				<tr>
					<th><label for="schWord"><spring:message code="menu.label.curMenuId"/></label></th>
					<td align="left">${menuInfo.curMenuId}</td>
					
				</tr>				
			</table>
		</form>
	</div>				
</body>
</html>