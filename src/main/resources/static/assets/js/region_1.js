// 시도 버튼을 누르면
// 해당 시도에 맞는 구 보여주기
var areaCode, gugunCode;
document.getElementById('search-gugun-id').addEventListener('click', function() {
	console.log("군구 클릭");
    areaCode = document.getElementById('search-area').value;
    gugunCode = document.getElementById('search-gugun-id').value;
    console.log(gugunCode);
    var langSelect = document.getElementById("search-gugun-id");
    var selectText = langSelect.options[langSelect.selectedIndex].text;
    console.log(selectText);
    
//    document.getElementById('search-gugun-id').onchange();
//    if(gugunCode != 0) {
//    	gugunCode.innterText = 
//    }
    let searchUrl = `./assets/data/gugun.json`;

    fetch(searchUrl, { method: "GET" })
        .then((response) => response.json())
        .then((data) => makeAreaOption(data));

    function makeAreaOption(data) {
//        let areas = data.response.body.items.item;
        let sel = document.getElementById('search-gugun-id');

        if (sel.childElementCount > 1) {
            let vals = document.querySelectorAll('.search-content-code');
            console.log(vals);
            if (!vals) { }
            else {
                vals.forEach((val) => {
                    val.remove();
                });
            }
        }
        if (!data) { }
        else {
            data.forEach((area) => {
                if (areaCode == area.sido_code) {
                    let opt = document.createElement('option');
                    opt.setAttribute('value', area.gugun_code);
                    opt.setAttribute('class', 'search-content-code');
                    opt.setAttribute('id', area.gugun_name);
                    opt.appendChild(document.createTextNode(area.gugun_name));

                    sel.appendChild(opt);
                }
            });
        }
    }
});

// 검색 버튼을 누르면..
// 지역, 유형, 검색어 얻기.
// 위 데이터를 가지고 공공데이터에 요청.
// 받은 데이터를 이용하여 화면 구성.
document.getElementById("btn-search").addEventListener("click", () => {
    document.getElementById("trip-list").innerHTML = '';
    // &contentTypeId=${contentTypeId}
    let areaCode = document.getElementById("search-area").value;
    // 시도/구군 코드
    let sigugunCode = document.getElementById('search-gungu-id').value;
    // 12 : 관광지 , 14 : 문화시설, 15: 축제공연행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점
    let contentTypeId = document.getElementById('search-content-id').value;

    let searchUrl = `https://apis.data.go.kr/B551011/KorService1/areaBasedSyncList1?serviceKey=${serviceKey}&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&showflag=1&listYN=Y&arrange=A`;

    if (parseInt(contentTypeId)) searchUrl += `&contentTypeId=${contentTypeId}`;
    if (parseInt(areaCode)) searchUrl += `&areaCode=${areaCode}`;
    if (parseInt(sigugunCode)) searchUrl += `&sigunguCode=${sigugunCode}`;

    fetch(searchUrl)
        .then((response) => response.json())
        .then((data) => makeList(data));
});

var positions; // marker 배열.
function makeList(data) {
    let trips = data.response.body.items.item;
    positions = [];
    if (!trips) { }
    else {
        let markerInfo = {
            title: area.title,
            latlng: new kakao.maps.LatLng(area.mapy, area.mapx),
        };
        positions.push(markerInfo);
    }
    displayMarker();
}

// 카카오지도
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
    mapOption = {
        center: new kakao.maps.LatLng(37.500613, 127.036431), // 지도의 중심좌표
        level: 5, // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption);

var overlay = {};

var marker = "";

function displayMarker() {
    // 마커 이미지의 이미지 주소입니다
    var imageSrc = "./assets/img/icon/location.png";

    for (var i = 0; i < positions.length; i++) {
        // 마커 이미지의 이미지 크기 입니다
        var imageSize = new kakao.maps.Size(30, 35);

        // 마커 이미지를 생성합니다
        var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

        // 마커를 생성합니다
        marker = new kakao.maps.Marker({
            map: map, // 마커를 표시할 지도
            position: positions[i].latlng, // 마커를 표시할 위치
            title: positions[i].title, // a마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
            image: markerImage, // 마커 이미지
        });
        // // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);

        // test
        console.log(positions[i]);

        var content = `<div class="wrap">` +
            `    <div class="info">` +
            `        <div class="title">` +
            `            ${positions[i].title}` +
            `            <div class="close" onclick="closeOverlay()" title="닫기"></div>` +
            `        </div>` +
            `        <div class="body">` +
            `            <div class="img">` +
            `                <img src="${positions[i].image}" width="73" height="70">` +
            `           </div>` +
            `            <div class="desc">` +
            `                <div class="ellipsis">${positions[i].addr}</div>` +
            `                <div class="jibun ellipsis">(우) ${positions[i].zipcode}</div>` +
            `                <div><a href="https://www.kakaocorp.com/main" target="_blank" class="link">홈페이지</a></div>` +
            `            </div>` +
            `        </div>` +
            `    </div>` +
            `</div>`;

        overlay = new kakao.maps.CustomOverlay({
            content: content,
            map: map,
            position: marker.getPosition()
        });
    }

    // 첫번째 검색 정보를 이용하여 지도 중심을 이동 시킵니다
    map.setCenter(positions[0].latlng);
}

// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
kakao.maps.event.addListener(marker, 'click', function () {
    overlay.setMap(map);
});

// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다
function closeOverlay() {
    overlay.setMap(null);
}

var addImage = '';
var addTitle = '';
function moveCenter(lat, lng, image, title) {
    map.setCenter(new kakao.maps.LatLng(lat, lng));

    addImage = image;
    addTitle = title;
    console.log(addImage);
}

