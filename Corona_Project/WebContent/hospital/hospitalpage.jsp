<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<% response.setContentType("text/html; charset=UTF-8");%>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CoronaKiller</title>
</head>
<body style="background:#edf3f1;">
<%@ include file="../home/header.jsp" %>
<br/><br/><br/><br/><br/><br/><br/><br/>
<div style="text-align:center;">
	<h2>국민안심병원 위치정보</h2>
	<p>국민안심병원 위치정보입니다.<br/>
		발열이나 기침증상이 있으신 분은 방문하셔서 검사받으시기 바랍니다.</p>
</div>
<!-- 카카오 지도 API영역 -->
	<div id="map" style="width:100%;height:1800px;"></div>
<!-- 카카오 지도 API영역 -->

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3edd977bc49d2f1b75366610458e6d17&libraries=services"></script>
<script type="text/javascript">
//전역변수
var g_iwContent = new Array(); //!!
var g_cnt = 0; //!!

$(function() {	 
	  CallData();
  
});
function CallData(){
	$.ajax({
    	url: 'hospitalloc.txt',
    	dataType: 'text',
 	 }).done(getMap);
}

var imageSrc = '/Corona_Project/resources/images/hospital/hospital.png', // 마커이미지의 주소입니다    
imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
imageOption = {offset: new kakao.maps.Point(10, 10)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption), 
markerPosition = new kakao.maps.LatLng(0, 0);

function getMap(data){
	
	var c1 = null;
	var rowCells = "";
	
	var allRows = data.split(/\r?\n|\r/);
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표
    level: 13 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
	//alert(allRows.length);
for (singleRow = 0; singleRow < allRows.length; singleRow++) {
	 rowCells = allRows[singleRow].split(',');
	console.log(rowCells);
	  g_iwContent[singleRow] = '<div style="padding:5px; width:700px; font-size:40px; height:350px;">'+
	  			 '번호: ' + rowCells[0] + '<br>' +
	  			 '기관명: ' + rowCells[3] + '<br>' +
     			 '주소: ' + rowCells[4] + '<br>' +
      			 '신청유형: ' + rowCells[5]  + '<br>' +
      			 '전화번호: ' + rowCells[6] + '</div>';		    	
//주소로 좌표를 검색합니다

geocoder.addressSearch(rowCells[4], function(result, status) {
// 정상적으로 검색이 완료됐으면 
g_cnt += 1;
//alert(g_cnt+"g_cnt");
//alert( g_iwContent[g_cnt]+" g_iwContent[g_cnt]");

 if (status === kakao.maps.services.Status.OK) {

     var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
     
     c1 = map.getCenter();
     var c2 = coords;

        var marker = new kakao.maps.Marker({
           map : map,
           position : coords,
           image : markerImage
        });
        
        var markers = [marker]; 
        
        //clusterer.addMarkers(markers);

        var infowindow = new kakao.maps.InfoWindow({
                 content : g_iwContent[g_cnt],
                 removable : true
              });
        // 마커에 클릭이벤트를 등록합니다 
        kakao.maps.event.addListener(marker, 'click', function() { // 마커 위에 인포윈도우를 표시합니다 
        	infowindow.open(map, marker); 
        });
}

});   
				
		
	}	
}

	
</script>
</body>
</html>