<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"	uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><tiles:insertAttribute name="title" /></title>
        <link href="<c:url value='/resources/plugin/jquery-ui-1.12.1/jquery-ui.min.css'/>" rel="stylesheet"/>
        
        
        
	    <link href="<c:url value='/resources/plugin/assets/css/bootstrap.css'/>" rel="stylesheet" /> <!-- Bootstrap Styles-->
	    <link href="<c:url value='/resources/plugin/assets/css/font-awesome.css'/>" rel="stylesheet" /> <!-- FontAwesome Styles-->
	    <link href="<c:url value='/resources/plugin/assets/js/morris/morris-0.4.3.min.css'/>" rel="stylesheet" /> <!-- Morris Chart Styles-->
	    <link href="<c:url value='/resources/plugin/assets/js/Lightweight-Chart/cssCharts.css'/>" rel="stylesheet"> 
	    
        
        
        <link href="<c:url value='/resources/plugin/jquery-mCustomScrollbar/jquery.mCustomScrollbar.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/plugin/jquery-multiselect/jquery.multiselect.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/plugin/poshytip-1.2/src/tip-yellow/tip-yellow.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/plugin/jquery.swiper/swiper.min.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/css/reset.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/css/common.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/css/custom.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/css/rgrid.css'/>" rel="stylesheet"/>
        <link href="<c:url value='/resources/css/calendar.css'/>" rel="stylesheet"/>
        
        <!-- SCRIPT -->
        <tiles:insertAttribute name="script" />

    </head>
    <body>
        <div class="wrap">
            <header class="header-wrap">
                <!-- header -->
		        <tiles:insertAttribute name="header" />
		        <tiles:insertAttribute name="authority" />
            </header>

            <div class="container">
				<section class="lnb-area">
					<tiles:insertAttribute name="menu" />
				</section><!-- //lnb-area -->
				<button class="lnb-btn">lnb ??????/??????</button>
				<section class="content main">
					<tiles:insertAttribute name="body" />
				</section><!-- //content -->
            </div>
            <footer class="footer-wrap">
                <tiles:insertAttribute name="footer" /> 
            </footer>
        </div>
        	<!-- ????????? ??????  -->
	<div class="loading-area" hidden="true">
		<div class="loading">
			<strong>?????? ????????? ?????????.</strong>
			<p>????????? ?????????????????? ????????????.</p>
		</div>
	</div>
    </body>
</html>