<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "com.app.ildong.common.util.PropertiesUtil" %>

<!-- jquery -->
<script type="text/javascript" src="<c:url value='/resources/js/jquery-3.2.1.min.js'/>"></script>
<!-- script type="text/javascript" src="<c:url value='/resources/plugin/jquery-1.12.3/jquery-1.12.3.js'/>"></script -->
<!-- script type="text/javascript" src="<c:url value="/resources/js/jquery-migrate-1.4.1.min.js" />"></script -->
<script type="text/javascript" src="<c:url value="/resources/js/jquery-migrate-3.0.1.min.js" />"></script>
<!-- //jquery -->
<!--plugin -->
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery.cookie.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mousewheel.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mCustomScrollbar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-validation/jquery.validate.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-validation/localization/messages_ko.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-number-master/jquery.number.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/jquery-multiselect/jquery.multiselect.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/poshytip-1.2/src/jquery.poshytip.min.js'/>"></script>

<%
 if(PropertiesUtil.isRealMode()){
%>
<!-- realGrid -->
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/realgridjs-lic.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/realgridjs.1.1.36.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/realgridjs-api.1.1.36.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/real/jszip.min.js'/>"></script>

<%
} else{
%>
<!-- realGrid -->
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/realgridjs-lic.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/realgridjs_eval.1.1.33.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/realgridjs-api.1.1.33.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/plugin/realgrid/dev/jszip.min.js'/>"></script>

<% 
}
%>


<script type="text/javascript" src="<c:url value='/resources/plugin/jquery.swiper/swiper.min.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/site_define.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/common.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/rgrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/rtgrid.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/calendar.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/calendar.js'/>"></script>

<!-- //realGrid -->

<!-- ckeditor4 -->
<script type="text/javascript" src="<c:url value="/resources/plugin/ckeditor/ckeditor.js"/>"></script>
<!-- //ckeditor4 -->


 
    <script src="<c:url value='/resources/plugin/assets/js/bootstrap.min.js'/>"></script>				<!-- Bootstrap Js -->
    <script src="<c:url value='/resources/plugin/assets/js/jquery.metisMenu.js'/>"></script>			<!-- Metis Menu Js -->
    <script src="<c:url value='/resources/plugin/assets/js/morris/raphael-2.1.0.min.js'/>"></script>	<!-- Morris Chart Js -->
    <script src="<c:url value='/resources/plugin/assets/js/morris/morris.js'/>"></script>				<!-- Morris Chart Js -->
	<script src="<c:url value='/resources/plugin/assets/js/easypiechart.js'/>"></script>				<!-- Easypie Chart Js -->
	<script src="<c:url value='/resources/plugin/assets/js/easypiechart-data.js'/>"></script>			<!-- Easypie Chart Js -->
	<script src="<c:url value='/resources/plugin/assets/js/Lightweight-Chart/jquery.chart.js'/>"></script>	<!-- Jquery Chart Js -->
	
    

<!-- //plugin -->

<script type="text/javascript" src="<c:url value='/resources/js/jquery-ui.datepicker-ko.js'/>"></script>

<script type="text/javascript" src="<c:url value='/resources/js/jquery.form.js'/>"></script>

<!-- script type="text/javascript" src="<c:url value='/resources/js/inputmask.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/extensions/inputmask.extensions.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/extensions/inputmask.numeric.extensions.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/extensions/inputmask.date.extensions.js'/>"></script> --><!-- common.js isValidDate 함수 중복문제로 제외함. --> 
<script type="text/javascript" src="<c:url value='/resources/js/jquery.inputmask.js'/>"></script>


<!-- ipro -->
<script type="text/javascript" src="<c:url value='/resources/js/custom.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/popup.js'/>"></script>
<!-- //ipro -->

