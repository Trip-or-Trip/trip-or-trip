// 카카오지도
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
    level: 5, // 지도의 확대 레벨
  };

// 지도를 표시할 div와 지도 옵션으로 지도를 생성
var map = new kakao.maps.Map(mapContainer, mapOption);

var overlay = {};
var marker = {};


let searchUrl = "./assets/data/gugun.json";

// 선택된 시도에 따른 구군 값 가져오기
let areaCode, gugunCode;
let mainCity = document.getElementById("search-area");
let subArea = document.getElementById("search-gugun-id");

mainCity.addEventListener("change", function() {
	
	var mainOption = mainCity.options[mainCity.selectedIndex].value;
	
	fetch(searchUrl)
		.then((response) => response.json())
		.then((data) => makeSubAreaOption(data));
	
	function makeSubAreaOption(data) {
		subArea.options.length = 0;
		let area = data[mainOption];
		for(let i = 1; i < area.length; i++) {
			if(area[i].hasOwnProperty(i)) {
				let option = document.createElement("option");
				option.innerText = area[i][i];
				option.setAttribute('value', i);
				option.setAttribute('class', 'search-content-code');
				option.setAttribute('id', area[i][i]);
				subArea.append(option);
			}
		}
	}
	
});


// 지역별 검색을 눌렀을 때 구군 선택 지역을 초기화하는 함수
function initSubAreaOption(sidoCode, gugunCode) {
	fetch(searchUrl)
		.then((response) => response.json())
		.then((data) => makeSubAreaOption(data));
		
	function makeSubAreaOption(data) {
		subArea.options.length = 0;
		let area = data[sidoCode];
		for(let i = 1; i < area.length; i++) {
			if(area[i].hasOwnProperty(i)) {
				let option = document.createElement("option");
				option.innerText = area[i][i];
				option.setAttribute('value', i);
				option.setAttribute('class', 'search-content-code');
				option.setAttribute('id', area[i][i]);
				subArea.append(option);
			}
		}
		
		$("#search-gugun-id").val(gugunCode).prop("selected", true);
	}
}


// 마커 표시 함수
function displayMarker(positions) {
	var imageSrc = "./assets/img/icon/location.png"; // 마커 이미지의 이미지 주소
	
	for(let i = 0; i < positions.length; i++) {
		var imageSize = new kakao.maps.Size(30, 35); // 마커 이미지의 이미지 크기
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지 생성

		// 마커 생성
	    marker = new kakao.maps.Marker({
	    	map: map, // 마커를 표시할 지도
	    	position: positions[i].latlng, // 마커를 표시할 위치
	    	title: positions[i].title, // a마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시
	    	image: markerImage, // 마커 이미지
		});
	    
	    // 마커가 지도 위에 표시되도록 설정
	    marker.setMap(map);
	    
	    // 마커에 클릭 이벤트 등록
	    kakao.maps.event.addListener(marker, 'click', function() {
	    	makeMapUrl(positions[i]);
	    });
	}
	
	map.setCenter(positions[0].latlng);
}


// 지도 검색 url을 구하는 함수
function makeMapUrl(marker) {
	let ps = new kakao.maps.services.Places(); // 장소 검색 객체 생성
	
	let callback = function(result, status) {
		if(status === kakao.maps.services.Status.OK) {
			displayCustomOverlay(result[0].place_url, marker);
		}
		else if(status === kakao.maps.services.Status.ZERO_RESULT) {
			displayCustomOverlay("", marker);
		}
		else {
			alert("서버에 문제가 있습니다. 다시 시도해 주세요.");
		}
	};
	
	ps.keywordSearch(marker.title, callback);
	
}


//커스텀 오버레이 표시 함수
function displayCustomOverlay(mapUrl, marker) {
	console.log(mapUrl.length);
	let image = "";
	if(marker.image !== "") {
		image = marker.image;
	}
	else {
		image = "./assets/img/noimage.png";
	}
	
	let content = `
		<div class="wrap">
			<div class="info">
				<div class="title">
					${marker.title}
					<div class="close" onclick="closeOverlay(this)" title="닫기"></div>
				</div>
				<div class="body">
					<div class="img">
    					<img src="${image}" width="73" height="70">
					</div>
					<div class="desc">
    					<div class="ellipsis mb-1">${marker.addr}</div>
    					<div class="jibun ellipsis">(우) ${marker.zipcode}</div>
    					<div class="mt-1">`;

	if(mapUrl !== "") {
		content += `<a href="${mapUrl}" target="_blank" class="me-2" style="color: black; text-decoration: none;"><i class="tourist-icon bi bi-geo-alt me-1"></i>지도검색</a>`;
	}
	
	content += `<a href="https://map.kakao.com/link/to/${marker.title},${marker.latlng.Ma},${marker.latlng.La}" target="_blank" class="me-2" style="color: black; text-decoration: none;"><i class="tourist-icon bi bi-sign-turn-right me-1"></i>길찾기</a>   						
    					</div>
					</div>
				</div>
			</div>
		</div>
	`;

	overlay = new kakao.maps.CustomOverlay({
		content: content,
		map: map,
		position: marker.latlng
	});
	
	overlay.setMap(map);
}


// 커스텀 오버레이를 닫는 함수
function closeOverlay(btn) {
	btn.parentNode.parentNode.parentNode.remove();
//	overlay.setMap(null);
}