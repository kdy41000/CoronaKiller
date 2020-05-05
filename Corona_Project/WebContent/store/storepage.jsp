<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%
   request.setCharacterEncoding("UTF-8");
%>
<%
   response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style>
.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap {
   position: relative;
   width: 100%;
   height: 1800px;
}



/* The Modal (background) */
.searchModal {
   display: none; /* Hidden by default */
   position: fixed; /* Stay in place */
   z-index: 10; /* Sit on top */
   left: 0;
   top: 0;
   width: 100%; /* Full width */
   height: 100%; /* Full height */
   overflow: auto; /* Enable scroll if needed */
   background-color: rgb(0, 0, 0); /* Fallback color */
   background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}
/* Modal Content/Box */
.search-modal-content {
   background-color: #fefefe;
   margin: 15% auto; /* 15% from the top and centered */
   padding: 20px;
   border: 1px solid #888;   
   width: 48%; /* Could be more or less, depending on screen size */
}
#mask{
	text-align:center;
}
</style>
<meta charset="UTF-8">
<title>CoronaKiller</title>


</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<body style="background:#f6f6f7;">
<%@ include file="../home/header.jsp" %>
<br/><br/><br/><br/><br/><br/><br/><br/>
<div style="text-align:center;">
	<h2>마스크판매처 위치정보</h2>
	<p>마스크판매처 위치정보입니다.<br/>
		코로나바이러스 확진자 방지를 위해 마스크 판매처 정보를 공유합니다.<br/>
		많은 이용 부탁드립니다.</p>
</div>
   <div class="map_wrap">
   		<div id="category">
         	<h1 id="mask" data-order="5"><strong></strong></h1>
        </div>
      	<div id="map" style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
   </div>

   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3edd977bc49d2f1b75366610458e6d17&libraries=services,clusterer,drawing"></script>
   <script type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3edd977bc49d2f1b75366610458e6d17&libraries=services"></script>
   <script>
 
   
   var c1 = null;
   
   // 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
   var placeOverlay = new kakao.maps.CustomOverlay({
      zIndex : 1
   }), contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
   markers = [], // 마커를 담을 배열입니다
   currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

   
    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
        center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
        level : 13 // 지도의 확대 레벨 
    }); 
   
    // 마커 클러스터러를 생성합니다  
    var clusterer = new kakao.maps.MarkerClusterer({
        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
        minLevel: 9 // 클러스터 할 최소 지도 레벨 
    });
   

   // 장소 검색 객체를 생성합니다
   var ps = new kakao.maps.services.Places(map);

   // 지도에 idle 이벤트를 등록합니다
   kakao.maps.event.addListener(map, 'idle', searchPlaces);

   // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
   contentNode.className = 'placeinfo_wrap';

   // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
   // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
   addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
   addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);
   
   // 커스텀 오버레이 컨텐츠를 설정합니다
   placeOverlay.setContent(contentNode);

   // 각 카테고리에 클릭 이벤트를 등록합니다 
   addCategoryClickEvent();

   // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다 
   function addEventHandle(target, type, callback) {
      if (target.addEventListener) {
         target.addEventListener(type, callback);
      } else {
         target.attachEvent('on' + type, callback);
      }
   }

   // 카테고리 검색을 요청하는 함수입니다
   function searchPlaces() {
      if (!currCategory) {
         return;
      }

      // 커스텀 오버레이를 숨깁니다 
      placeOverlay.setMap(null);

      // 지도에 표시되고 있는 마커를 제거합니다
      removeMarker();

      ps.categorySearch(currCategory, placesSearchCB, {
         useMapBounds : true
      });
   } 

   // 지도에 마커를 표출하는 함수입니다 
   function displayPlaces(places) {

      // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
      // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
      var order = document.getElementById(currCategory).getAttribute('data-order');

      for (var i = 0; i < places.length; i++) {

         // 마커를 생성하고 지도에 표시합니다
         var marker = addMarker(new kakao.maps.LatLng(places[i].y,
               places[i].x), order);
         
         // 마커와 검색결과 항목을 클릭 했을 때
         // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
         (function(marker, place) {
            kakao.maps.event.addListener(marker, 'click', function() {
               displayPlaceInfo(place);
            });
         })(marker, places[i]);
      }
   }

   // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
   function addMarker(position, order) { 
      var imageSrc = 'http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
      imageSize = new kakao.maps.Size(34, 35), // 마커 이미지의 크기
      imgOptions = {
         spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
         spriteOrigin : new kakao.maps.Point(46, (order * 36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
         offset : new kakao.maps.Point(11, 28)
      
      
      // 마커 좌표에 일치시킬 이미지 내에서의 좌표 
      }, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
            imgOptions), marker = new kakao.maps.Marker({
         position : position, // 마커의 위치
         image : markerImage 
      });

      marker.setMap(map); // 지도 위에 마커를 표출합니다
      markers.push(marker); // 배열에 생성된 마커를 추가합니다

      return marker;
   }

   // 지도 위에 표시되고 있는 마커를 모두 제거합니다
   function removeMarker() {
      for (var i = 0; i < markers.length; i++) {
         markers[i].setMap(null);
      }
      markers = [];
   }

   // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
   function displayPlaceInfo(place) {
      var content = '<div class="placeinfo">'
            + '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">'
            + place.place_name + '</a>';

      if (place.road_address_name) {
         content += '    <span title="' + place.road_address_name + '">'
               + place.road_address_name
               + '</span>'
               + '  <span class="jibun" title="' + place.address_name + '">(지번 : '
               + place.address_name + ')</span>';
      } else {
         content += '    <span title="' + place.address_name + '">'
               + place.address_name + '</span>';
      }

      content += '    <span class="tel">' + place.phone + '</span>'
            + '</div>' + '<div class="after"></div>';

      contentNode.innerHTML = content;
      placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
      placeOverlay.setMap(map);
   }

   // 각 카테고리에 클릭 이벤트를 등록합니다
   function addCategoryClickEvent() {
      var category = document.getElementById('category'), children = category.children;  

      for (var i = 0; i < children.length; i++) {
         children[i].onclick = onClickCategory;
      }
   }

   // 카테고리를 클릭했을 때 호출되는 함수입니다
   function onClickCategory() {
      var id = this.id, className = this.className;

      placeOverlay.setMap(null);

      if (className === 'on') {
         currCategory = '';
         changeCategoryClass();
         removeMarker();
      } else {
         currCategory = id;
         changeCategoryClass(this);
         searchPlaces();
      }
   }
  
   // 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
   var mapTypeControl = new kakao.maps.MapTypeControl();
   map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
   

   
     var imageSrc = '/Corona_Project/resources/images/store/maskstore.png', // 마커이미지의 주소입니다    
        imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
        imageOption = {offset: new kakao.maps.Point(10, 10)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption), 
        markerPosition = new kakao.maps.LatLng(0, 0);
   
      //-----------------------------------------줌컨트롤--------------------------------------------------
      //지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
      var zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

      // 지도가 확대 또는 축소되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
      kakao.maps.event.addListener(map, 'zoom_changed', function() {        
          
          
          
      });

      //-----------------------------------------줌컨트롤--------------------------------------------------

       $(function() {	  
    	  var remainStat = ""; 
    	  var stockat = "";
    	  var created_at ="";
    	  
    	  var geocoder = new kakao.maps.services.Geocoder(); 	  
          $.getJSON("https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByAddr/json",function(data) {
             $.each(data, function(key, val) {
                if (key == "stores") {
                   $.each(val, function(k, v) {
                      console.log(v.addr);
   geocoder.addressSearch(v.addr, function(result, status) {
      	
	   			if(v.remain_stat == "empty" || v.remain_stat =="break"){
	   				remainStat = "매진";
	   			}else if(v.remain_stat == "few" || v.remain_stat =="some"){
	   				remainStat = "소량보유중";
	   			}else if(v.remain_stat == "plenty"){
	   				remainStat = "보유중";
   				}else{
	   				remainStat = "파악불가";
	   			}
	   			
	   			if(v.stock_at == null){
	   				stockat = "파악불가";
	   			}else{
	   				stockat = v.stock_at;
	   			} 
	   			
	   			if(v.created_at == null){
	   				created_at = "파악불가";
	   			}else{
	   				created_at = v.created_at;
	   			}
	   
      iwContent = '<div style="padding:5px; width:700px; font-size:40px; height:450px;">'+
               '약국 이름 : ' +v.name + '<br>'+
               '재고 입고 시간 : ' + stockat + '<br>' +
               '갱신시간 : ' + created_at + '<br>' +
               '재고량 : ' + remainStat + '<br>' + 
               '주소 : ' + v.addr + '</div>';
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
               
              clusterer.addMarkers(markers);

               var infowindow = new kakao.maps.InfoWindow(
                     {
                        content : iwContent,
                        removable : true
                     });
            // 마커에 클릭이벤트를 등록합니다 
            kakao.maps.event.addListener(marker, 'click', function() { // 마커 위에 인포윈도우를 표시합니다 
            	infowindow.open(map, marker); 
            });

  
                  }
               })
   
             });
          }
      });
   });
});
     
    
    
   </script>
</body>
</html>