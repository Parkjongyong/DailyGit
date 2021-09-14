<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@ page import="com.app.ildong.common.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/tags"%>
<%
String URL_IN = PropertiesUtil.getProperty("HTTP.SERVER.URL.IN");
request.setAttribute("URL_IN" ,  URL_IN);
%>
<script type="text/javascript">

</script>
<div class="pop-wrap" style="width:100%;"><!-- min-width:1200px -->
    <div class="pop-cont link">
        <div class="section6 scrolls" id="section6">
            <div class="sub-tit  im_on" id="fileUploadTableOfferTitle">
                <h4>첨부파일</h4>
            </div>
            <div id="fileUploadTableOffer" class="jqGridArea m_t5  im_on">
                <table class="table-style">
                    <tbody>
                        <tr>
                            <th style="text-align: center;" width="10%">No</th>
                            <th style="text-align: center;">파일명</th>
                            <!-- <th class="center">등록일자</th>
                            <th class="center">파일크기</th> -->
                        </tr>
                        <c:forEach var="FILE" items="${FILE_LIST}" varStatus="status">
                        <tr class="F_File_ROW">
                            <td style="text-align: center;">${status.count}</td>
                            <td class="t_left">
                            <a href="${URL_IN}/download.do?APP_SEQ=${FILE.APP_SEQ}&amp;ATTACHMENT_SEQ=${FILE.ATTACHMENT_SEQ}" title="${FILE.FILE_NAME}" style="color:blue;" download="${FILE.FILE_NAME}">${FILE.FILE_NAME}</a></td>
                            <!-- <td class="t_center">2019-12-12</td>
                            <td class="t_right">0.06 KB</td> -->
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>