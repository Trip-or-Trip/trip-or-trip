var latitude;
var longitude;
var idxs = [];

/** 추가 버튼 클릭하면 여행 계획란으로 정보 복사 됨 */
document.getElementById("plan-add-btn").addEventListener("click", () => {
//	console.log(clickInfo);
  let placeName = clickInfo.place_name;
  let placeAddr = clickInfo.address_name;
  let placeId = clickInfo.id;
  let placeLat = clickInfo.y;
  let placeLng = clickInfo.x;
  let placeTel = clickInfo.phone;
//  let placeImageUrl = "./assets/img/noimage.png";
  let placeImageUrl = placeImg;
  
  console.log(placeAddr);

  let makeDiv = `<div id='${placeId}' class='trip-plan-card rounded border-opacity-50 border border-5 border-primary-subtle me-1' sytle="background-color: gray; width: 100%; height: 100px;">
                          <div class='text-center p-2'>
                              <div class="place-title">${placeName}</div>
                              <div>${placeAddr}</div>
                              <div class="lat" style="display: none;">${placeLat}</div>
                              <div class="lng" style="display: none;">${placeLng}</div>
                          </div>`;
  
  let info = 
	  		`<input type="hidden" name='place_id' value=${placeId} />` +
  			`<input type="hidden" name='name' value= "${placeName}"/>` +
  			`<input type="hidden" name='address' value= "${placeAddr}"/>` +
  			`<input type="hidden" name='tel' value= ${placeTel} />` +
  			`<input type="hidden" name='lat' value=${placeLat} />` +
  			`<input type="hidden" name='lng' value=${placeLng} />` +
  			`<input type="hidden" name='image_url' value= ${placeImageUrl} />` +
  			`</div>`; 

  document.getElementById("plan-content").innerHTML += makeDiv;  
  document.getElementById("plan-content").innerHTML += info;

  let latlng = new kakao.maps.LatLng(clickInfo.y, clickInfo.x);
  drawLine(latlng);
  clickInfo = null;

  // 지도 선 삭제
  let mark;

  let latlngLa = latlng.La.toFixed(13);
  let latlngMa = latlng.Ma.toFixed(13);

  let len = idxs.length;
  // marker들 뒤에서부터 읽어오면서 위도 경도 값이 같다면 그대로 두고 아닌 것들은 마커 다 삭제
  for (var i = markers.length - 1; i >= len; i--) {
// console.log(i);
    if (
      markers[i].getPosition().getLat().toFixed(13) == latlngMa &&
      markers[i].getPosition().getLng().toFixed(13) == latlngLa
    ) {
      idxs.push(markers[i]);
    } else {
      markers[i].setMap(null);
      markers.splice(i, 1);
    }
  }
});

/** 저장 버튼 누르면 DB에 여행 계획 정보 저장 */
document.getElementById("plan-save-btn").addEventListener("click", () => {
	console.log("add-btn");
	let form = document.getElementById("plan-form");
	form.setAttribute("action", "save");
	form.submit();
});

/** 삭제 버튼 클릭하면 여행 계획란에 있던 정보 삭제 됨*/
document.getElementById("plan-delete-btn").addEventListener("click", () => {
	let parent = document.getElementById("plan-content");
	let childs = document.querySelectorAll(".trip-plan-card");
	
	childs.forEach(function(child) {
		parent.removeChild(child);
	});
	
    // 지도에 표시되어 있는 마크 삭제
    for (var i = markers.length - 1; i >= 0; i--) {
		markers[i].setMap(null);
	    markers.splice(i, 1);
//		markers[i] = null;
		deleteLine();
    }
    console.log(markers);
    markers = [];
    lines = [];
});

/** 선 지우기 */
function deleteLine() {
  deleteClickLine();
  deleteDistance();
  deleteCircleDot();
}

// 카카오지도
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
    level: 5, // 지도의 확대 레벨
  };

// 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

document.getElementById("btn-search").addEventListener("click", () => {
  // 키워드로 장소를 검색합니다
  ps.keywordSearch(document.getElementById("search-keyword").value, placesSearchCB);
});

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
  if (status === kakao.maps.services.Status.OK) {
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    var bounds = new kakao.maps.LatLngBounds();
    
    for (var i = 0; i < data.length; i++) {
        // 이미지 정보 불러오기
        var keyword = data[i].place_name;
        areaUrl += keyword + "&_type=json";
        
        var place = data[i];
        fetch(areaUrl, {method: "GET" })
        .then((response) => response.json())
        .then((data) => makeOption(data));
    }

    for (var i = 0; i < data.length; i++) {
      displayMarker(data[i]);
      bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
    }

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
  }
}

// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

// 클릭한 위치 정보
var clickInfo = "";
var overlay = {};


// 관광지 이미지 API로 가져오기
let areaUrl =
  "https://apis.data.go.kr/B551011/PhotoGalleryService1/gallerySearchList1?serviceKey=" +
  serviceKey +
  "&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=A&keyword=";

var placeImg = "";

function makeOption(data) {
  let areas = data.response.body.items.item;
  if (!areas) { }
  else {
	placeImg = areas[0].galWebImageUrl;
	console.log(areas[0].galWebImageUrl);
  }
}


// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
	// 마커 이미지의 이미지 주소입니다
	  var imageSrc = "${root}/assets/img/icon/location.png";

    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(30, 35);

    // 마커 이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

    // 마커를 생성합니다
    marker = new kakao.maps.Marker({
      map: map, // 마커를 표시할 지도
      position: new kakao.maps.LatLng(place.y, place.x), // 마커를 표시할 위치
      title: place.place_name, // a마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
      image: markerImage, // 마커 이미지
    });
    
    markers.push(marker);
    
    var content = "";
//    var noimg = "./assets/img/noimage.png";
    var tempimg = placeImg;

  // 마커에 클릭이벤트를 등록합니다
  kakao.maps.event.addListener(marker, "click", function () {
    
    content = `<div class="wrap">` +
    `    <div class="info">` +
    `        <div class="title">` +
    `            ${place.place_name}` +
    `            <div class="close" onclick="closeOverlay(this)" title="닫기"></div>` +
    `        </div>` +
    `        <div class="body">` +
    `            <div class="img">` +
    `                <img src="${tempimg}" width="73" height="70">` +
    `           </div>` +
    `            <div class="desc">` +
    `                <div class="ellipsis">${place.address_name}</div>` +
    `                <div class="jibun ellipsis">${place.category_group_name}</div>` +
    `                <div><a href="https://map.kakao.com/link/to/${place.place_name},${place.y},${place.x}" style="color:blue" target="_blank" class="link">길찾기</a></div>` +
    `            </div>` +
    `        </div>` +
    `    </div>` +
    `</div>`;
    
    overlay = new kakao.maps.CustomOverlay({
      content: content,
      map: map,
      position: new kakao.maps.LatLng(place.y, place.x)
    });
    
    overlay.setMap(map);
    
    // =================================================================
    // 총 거리 표시하는 오버레이
    // 선을 그리고있는 상태이면
//    if (drawingFlag) {
//        
//        // 그린 선의 좌표 배열을 얻어옵니다
//        var path = clickLine.getPath();
//    
//        // 선을 구성하는 좌표의 개수가 2개 이상이면
//        if (path.length > 1) {
//
//            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
//            if (dots[dots.length-1].distance) {
//                dots[dots.length-1].distance.setMap(null);
//                dots[dots.length-1].distance = null;    
//            }
//
//            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
//                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
//                
//            // 그려진 선의 거리정보를 지도에 표시합니다
//            showDistance(content, path[path.length-1]);  
//             
//        } else {
//
//            // 선을 구성하는 좌표의 개수가 1개 이하이면 
//            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
//            deleteClickLine();
//            deleteCircleDot(); 
//            deleteDistnce();
//
//        }
//        
//        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
//        drawingFlag = false;          
//    }  
    // ====================================================================
    
    // 추가 버튼 보이게 하기 (활성화)
    document.getElementById("plan-add-btn").style.display = "block";
    // 저장 버튼 보이게 하기 (활성화)
    document.getElementById("plan-save-btn").style.display = "block";
    
    clickInfo = place;
  });

}

function closeOverlay(btn) {
	btn.parentNode.parentNode.parentNode.remove();
//	overlay.setMap(null);
}

var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var clickLine; // 마우스로 클릭한 좌표로 그려질 선 객체입니다
var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.
var lines = [];
var markers = [];
var circleOverlays = [];
var disOverlays = [];

/** 지도에 선그리는 메소드 */
function drawLine(latlng) {
  // 추가한 위치입니다
  var clickPosition = latlng;

  // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
  if (!drawingFlag) {
    // 상태를 true로, 선이 그리고있는 상태로 변경합니다
    drawingFlag = true;

    // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
    deleteClickLine();

    // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
    deleteDistance();

    // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
    deleteCircleDot();

    // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
    clickLine = new kakao.maps.Polyline({
      map: map, // 선을 표시할 지도입니다
      path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
      strokeWeight: 3, // 선의 두께입니다
      strokeColor: "#db4040", // 선의 색깔입니다
      strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
      strokeStyle: "solid", // 선의 스타일입니다
    });

    lines.push(clickLine);

    // 클릭한 지점에 대한 정보를 지도에 표시합니다
    displayCircleDot(clickPosition, 0);
  } else {
    // 선이 그려지고 있는 상태이면

    // 그려지고 있는 선의 좌표 배열을 얻어옵니다
    var path = clickLine.getPath();

    // 좌표 배열에 클릭한 위치를 추가합니다
    path.push(clickPosition);

    // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
    clickLine.setPath(path);

    var distance = Math.round(clickLine.getLength());
    displayCircleDot(clickPosition, distance);
  }
}

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
  if (clickLine) {
    clickLine.setMap(null);
    clickLine = null;
  }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
function showDistance(content, position) {
  if (distanceOverlay) {
    // 커스텀오버레이가 생성된 상태이면

    // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
    distanceOverlay.setPosition(position);
    distanceOverlay.setContent(content);
  } else {
    // 커스텀 오버레이가 생성되지 않은 상태이면

    // 커스텀 오버레이를 생성하고 지도에 표시합니다
    distanceOverlay = new kakao.maps.CustomOverlay({
      map: map, // 커스텀오버레이를 표시할 지도입니다
      content: content, // 커스텀오버레이에 표시할 내용입니다
      position: position, // 커스텀오버레이를 표시할 위치입니다.
      xAnchor: 0,
      yAnchor: 0,
      zIndex: 3,
    });

    disOverlays.push(distanceOverlay);
  }
}

// 그려지고 있는 선의 총거리 정보와
// 선 그리기가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistance() {
  if (distanceOverlay) {
    distanceOverlay.setMap(null);
    distanceOverlay = null;
  }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
function displayCircleDot(position, distance) {
  // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
  var circleOverlay = new kakao.maps.CustomOverlay({
    content: '<span class="dot"></span>',
    position: position,
    zIndex: 1,
  });

  circleOverlays.push(circleOverlay);

  // 지도에 표시합니다
  circleOverlay.setMap(map);

  if (distance > 0) {
    // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
    var distanceOverlay = new kakao.maps.CustomOverlay({
      content:
        '<div class="dotOverlay">거리 <span class="number">' + distance + "</span>m</div>",
      position: position,
      yAnchor: 1,
      zIndex: 2,
    });

    // 지도에 표시합니다
    distanceOverlay.setMap(map);
  }

  // 배열에 추가합니다
  dots.push({ circle: circleOverlay, distance: distanceOverlay });
}

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
function deleteCircleDot() {
  var i;

  for (i = 0; i < dots.length; i++) {
    if (dots[i].circle) {
      dots[i].circle.setMap(null);
    }

    if (dots[i].distance) {
      dots[i].distance.setMap(null);
    }
  }

  dots = [];
}

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {
  // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
  var walkkTime = (distance / 67) | 0;
  var walkHour = "",
    walkMin = "";

  // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
  if (walkkTime > 60) {
    walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + "</span>시간 ";
  }
  walkMin = '<span class="number">' + (walkkTime % 60) + "</span>분";

  // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
  var bycicleTime = (distance / 227) | 0;
  var bycicleHour = "",
    bycicleMin = "";

  // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
  if (bycicleTime > 60) {
    bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + "</span>시간 ";
  }
  bycicleMin = '<span class="number">' + (bycicleTime % 60) + "</span>분";

  // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
  var content = '<ul class="dotOverlay distanceInfo">';
  content += "    <li>";
  content +=
    '        <span class="label">총거리</span><span class="number">' + distance + "</span>m";
  content += "    </li>";
  content += "    <li>";
  content += '        <span class="label">도보</span>' + walkHour + walkMin;
  content += "    </li>";
  content += "    <li>";
  content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
  content += "    </li>";
  content += "</ul>";

  return content;
}