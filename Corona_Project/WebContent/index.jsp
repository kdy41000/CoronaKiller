<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronaKiller</title>
<link href="resources/css/home/home.css"    
	  rel="stylesheet"    
	  type="text/css" /> 
<link href="resources/css/home/mediaQuery.css"    
	  rel="stylesheet"    
	  type="text/css" /> 	  
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="resources/js/home/home.js"></script>
<!-- 버튼 -->
<script src="https://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>
<link href='https://fonts.googleapis.com/css?family=Montserrat:700' rel='stylesheet' type='text/css'>
<!-- 버튼 -->
<body>
<div class="webcontroller">
	<img alt="img" src="resources/images/home/cryingicon.png" style="margin:15% 0% 0% 43%;"/>
	<h2 style="text-align:center; margin-top:3%;">웹 브라우저 환경에서 지원되지 않습니다.</h2>
</div>

<div class="mobilecontroller">
<div class="header">

<!--Content before waves-->
<div class="inner-header flex">
<!--Just the logo.. Don't mind this-->
<img alt="img" src="resources/images/home/logo.png" style="width:10%; height:90px;"/>
<h1>CoronaKiller</h1>
</div>

<!-- 버튼 -->
<a href="#" class="boton" onclick="location.href='home.do?command=gohome';">
GoHome   
</a>
<!-- 버튼 -->

<!--Waves Container-->
<div>
<svg class="waves" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
viewBox="0 24 150 28" preserveAspectRatio="none" shape-rendering="auto">
<defs>
<path id="gentle-wave" d="M-160 44c30 0 58-18 88-18s 58 18 88 18 58-18 88-18 58 18 88 18 v44h-352z" />
</defs>
<g class="parallax">
<use xlink:href="#gentle-wave" x="48" y="0" fill="rgba(255,255,255,0.7" />
<use xlink:href="#gentle-wave" x="48" y="3" fill="rgba(255,255,255,0.5)" />
<use xlink:href="#gentle-wave" x="48" y="5" fill="rgba(255,255,255,0.3)" />
<use xlink:href="#gentle-wave" x="48" y="7" fill="#fff" />
</g>
</svg>
</div>
<!--Waves end-->

</div>
<!--Header ends-->

<!--Content starts-->
<div class="content flex">
<p>Created By DongyoungKim | 2020 | Free to use</p>
</div>
<!--Content ends-->
</div>
</body>
</html>